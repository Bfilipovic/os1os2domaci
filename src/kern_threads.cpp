//
// Created by os on 5/22/23.
//

#include "../h/kern_threads.hpp"
#include "../h/kern_interrupts.hpp"
#include "../lib/hw.h"
#include "../h/kern_memory.hpp"
#include "../h/syscall_c.h"

#define MAX_THREADS 64

typedef struct thread_s* thread_t;

struct thread_s kthreads[MAX_THREADS];
static int id;
struct thread_s* running;

void kern_thread_init()
{
    id=0;
    for (int i=0;i<MAX_THREADS;i++){
        kthreads[i].status=UNUSED;
    }

    //set kthreads[0] as main thread
    kthreads[0].status=RUNNING;
    kthreads[0].id=0;
    kthreads[0].timeslice=DEFAULT_TIME_SLICE+2;
    kthreads[0].endTime=0;
    running=&kthreads[0];
}

thread_t kern_scheduler_get()
{
    int num = running-kthreads;
    for(int i=1;i<=MAX_THREADS;i++){
        num = (num+i)%MAX_THREADS;
        if(kthreads[num].status==READY){
            kthreads[num].status=RUNNING;
            return &kthreads[num];
        }
    }
    if(running->status==READY || running->status==RUNNING) {
        running->status=RUNNING;
        return running;
    }
    return 0;
}

void kern_thread_yield()
{
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

void kern_thread_dispatch()
{
    thread_t old = running;
    running=kern_scheduler_get();
    if(old!=running){
        running->status=RUNNING;
        if(old->status==RUNNING) old->status=READY;
        contextSwitch(old,running);
    }
}

void kern_thread_end_running()
{
    thread_t old = running;
    old->status=UNUSED;
    for(int i=0;i<MAX_THREADS;i++){
        if(kthreads[i].status==JOINED && kthreads[i].joined_tid==old->id) kthreads[i].status=READY;
    }
    running=kern_scheduler_get();
    if(old->stack_space!=0) kern_mem_free((void*)old->stack_space);
    if(old!=running){
        contextSwitch(old,running);
    }
}

void kern_thread_wrapper()
{
    popSppSpie();
    running->body(running->arg);
    running->status=UNUSED;
    running->sem_next=0;
    running->joined_tid=-1;
    for(int i=0;i<MAX_THREADS;i++){
        if(kthreads[i].status==JOINED && kthreads[i].joined_tid==running->id) kthreads[i].status=READY;
    }

    thread_exit();
}

int kern_thread_create(thread_t* handle, void(*start_routine)(void*), void* arg, void* stack_space)
{
    *handle=0;
    thread_t t=&kthreads[0]; //dodela da bismo sklonili upozorenje
    for(int i=0;i<MAX_THREADS;i++){
        if(kthreads[i].status==UNUSED){
            *handle=&kthreads[i];
            t=&kthreads[i];
            break;
        }
    }
    if(*handle==0) return -1;

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
    t->mailbox=0;

    return 0;
}

void kern_thread_join(thread_t handle)
{
    if(handle->status==UNUSED) return;
    running->joined_tid=handle->id;
    running->status=JOINED;
    kern_thread_dispatch();
}

void kern_thread_wakeup(uint64 system_time)
{
    for(int i=0;i<MAX_THREADS;i++){
        if(kthreads[i].status==SLEEPING && kthreads[i].endTime<system_time){
            kthreads[i].status=READY;
        }
    }
}
