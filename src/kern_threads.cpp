//
// Created by os on 5/22/23.
//

#include "../h/kern_threads.hpp"
#include "../h/kern_interrupts.hpp"
#include "../lib/hw.h"
#include "../h/kern_memory.hpp"
#include "../h/syscall_c.h"
#include "../h/kern_reg_util.h"
#include "../h/kern_slab.hpp"
#include "../h/printing.hpp"


typedef struct thread_s* thread_t;

kmem_cache_t* threads_cache;
static int id;
struct thread_s* running;
struct {
    thread_t ready_head;
    thread_t ready_tail;
    thread_t joined_head;
    thread_t sleeping_head;
} scheduler;

void kern_thread_yield();

void kern_thread_ctor(void* addr){
    thread_t t = (thread_t)addr;
    t->status=UNUSED;
    t->stack_space=0;
    t->arg=0;
    t->joined_tid=-1;
    t->timeslice=DEFAULT_TIME_SLICE;
    t->body=0;
    t->stack_space = 0;
    t->sp =0;
    t->ra=0;
    t->sem_next=0;
    t->next_thread=0;
    t->mailbox=0;
}

void kern_thread_dtor(void* addr)
{
    thread_t t = (thread_t)addr;
    printf("\n Destroying thread id=%d\n",t->id);
}
void kern_thread_init()
{
    threads_cache=kmem_cache_create("thread cache", sizeof(thread_s),kern_thread_ctor,kern_thread_dtor);
    id=0;
    /*
    for (int i=0;i<MAX_THREADS;i++){
        kthreads[i].status=UNUSED;
    }
    */
    //set main thread
    thread_t main_thread = (thread_t) kmem_cache_alloc(threads_cache);
    main_thread->status=RUNNING;
    main_thread->id=0;
    main_thread->timeslice=DEFAULT_TIME_SLICE+2;
    main_thread->endTime=0;
    main_thread->next_thread=0;
    running=main_thread;
    scheduler.ready_head=0;
    scheduler.ready_tail=0;
    scheduler.joined_head=0;
    scheduler.sleeping_head=0;
}

void kern_scheduler_put(thread_t t)
{
    t->status=READY;
    if(scheduler.ready_tail==0){
        scheduler.ready_tail=t;
        scheduler.ready_head=t;
    } else{
        scheduler.ready_tail->next_thread=t;
        scheduler.ready_tail=t;
    }
    t->next_thread=0;
}

thread_t kern_scheduler_get()
{
    if(scheduler.ready_head==0) return 0;
    thread_t t = scheduler.ready_head;
    scheduler.ready_head=scheduler.ready_head->next_thread;
    if(scheduler.ready_tail==t) scheduler.ready_tail=0;
    t->next_thread=0;
    return t;
}

void kern_thread_dispatch()
{
    kern_scheduler_put(running);
    uint64 volatile sstatus = r_sstatus();
    uint64 volatile v_sepc = r_sepc();
    kern_thread_yield();
    w_sstatus(sstatus);
    w_sepc(v_sepc);
}

//samo izlazi iz kernela i vraca se odakle je pozvana
void popSppSpie()
{
    __asm__ volatile("csrw sepc, ra"); //ovde dodaj izlazak iz privilegovanog moda
    __asm__ volatile("csrc sstatus, %[mask]" : : [mask] "r"(1 << 8));
    __asm__ volatile("sret");
}

#ifdef __cplusplus
extern "C" {
#endif
void contextSwitch(thread_t oldT, thread_t newT);
#ifdef __cplusplus
}
#endif

void kern_thread_yield()
{
    thread_t old = running;
    running=kern_scheduler_get();
    if(old!=running){
        running->status=RUNNING;
        if(old->status==RUNNING) old->status=READY;
        contextSwitch(old,running);
    }
    else {
        old->status=RUNNING;
    }
}

void kern_thread_resume_joined(uint64 joined_tid)
{
    thread_t curr = scheduler.joined_head;
    thread_t prev = 0;
    thread_t next = 0;
    while (curr!=0){
        next=curr->next_thread;
        if(curr->joined_tid<=joined_tid){
            if(prev!=0){
                prev->next_thread=curr->next_thread;
            } else{
                scheduler.joined_head=curr->next_thread;
            }
            kern_scheduler_put(curr);
        } else{
            prev=curr;
        }
        curr=next;
    }
}

void kern_thread_end_running()
{
    thread_t old = running;
    old->status=UNUSED;
    kern_thread_resume_joined(old->id);
    running=kern_scheduler_get();
    if(old->stack_space!=0) kern_mem_free((void*)old->stack_space);
    kmem_cache_free(threads_cache,old);
    if(old!=running){
        contextSwitch(old,running);
    }
}

void kern_thread_wrapper()
{
    popSppSpie();
    running->body(running->arg);
    /*
    running->status=UNUSED;
    running->sem_next=0;
    running->joined_tid=-1;
    for(int i=0;i<MAX_THREADS;i++){
        if(kthreads[i].status==JOINED && kthreads[i].joined_tid==running->id) kthreads[i].status=READY;
    }
*/
    thread_exit();
}

int kern_thread_create(thread_t* handle, void(*start_routine)(void*), void* arg, void* stack_space)
{
    *handle=0;
    thread_t t= (thread_t)kmem_cache_alloc(threads_cache);
    if(t==0) return -1;
    *handle=t;

    t->id=++id;
    t->status=READY;
    t->arg=arg;
    t->joined_tid=-1;
    t->timeslice=DEFAULT_TIME_SLICE;
    t->body=start_routine;
    t->stack_space = ((uint64)stack_space);
    t->sp = t->stack_space+(DEFAULT_STACK_SIZE);
    t->ra=(uint64) &kern_thread_wrapper;
    t->sem_next=0;
    t->next_thread=0;
    t->mailbox=0;
    kern_scheduler_put(t);

    return 0;
}

void kern_thread_join(thread_t handle)
{
    if(handle->status==UNUSED) return;
    running->joined_tid=handle->id;
    running->status=JOINED;
    running->next_thread=scheduler.joined_head;
    scheduler.joined_head=running;
    uint64 volatile sstatus = r_sstatus();
    uint64 volatile v_sepc = r_sepc();
    kern_thread_yield();
    w_sstatus(sstatus);
    w_sepc(v_sepc);
}

void kern_thread_wakeup(uint64 system_time)
{
    thread_t curr = scheduler.sleeping_head;
    thread_t prev = 0;
    thread_t next = 0;
    while (curr!=0){
        next=curr->next_thread;
        if(curr->endTime<=system_time){
            if(prev!=0){
                prev->next_thread=curr->next_thread;
            } else{
                scheduler.sleeping_head=curr->next_thread;
            }
            kern_scheduler_put(curr);
        } else{
            prev=curr;
        }
        curr=next;
    }

}

void kern_thread_sleep(uint64 wakeTime)
{
    running->status=SLEEPING;
    running->endTime=wakeTime;
    running->next_thread=scheduler.sleeping_head;
    scheduler.sleeping_head=running;
    uint64 volatile sstatus = r_sstatus();
    uint64 volatile v_sepc = r_sepc();
    kern_thread_yield();
    w_sstatus(sstatus);
    w_sepc(v_sepc);
}

