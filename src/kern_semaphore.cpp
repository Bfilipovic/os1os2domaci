//
// Created by os on 6/4/23.
//

#include "../h/kern_semaphore.hpp"
#include "../h/kern_reg_util.h"
#include "../h/kern_threads.hpp"
#include "../h/kern_slab.hpp"


#define MAX_SEMAPHORES 256

struct sem_s semaphores[MAX_SEMAPHORES];
kmem_cache_t * semaphore_cache;

void kern_sem_ctor(void* addr)
{
    sem_t sem = (sem_t) addr;
    sem->status=SEM_UNUSED;
    sem->waiting_thread=0;
    sem->val=0;
}

void kern_sem_init()
{
    semaphore_cache = (kmem_cache_t*) kmem_cache_create("sem cache", sizeof(sem_s),kern_sem_ctor,0);

}

int kern_sem_open (sem_t* handle, unsigned init)
{
    sem_t sem=(sem_t) kmem_cache_alloc(semaphore_cache);
    *handle=sem;
    if(sem==0) return -1;
    sem->status=SEM_USED;
    sem->val=init;
    return 0;
}

int kern_sem_close (sem_t handle)
{
    handle->status=SEM_UNUSED;
    handle->val=0;
    if(handle->waiting_thread!=0){
        thread_t curr = handle->waiting_thread;
        while(curr){
            curr->mailbox=-2;
            curr->status=READY;
            thread_t prev=curr;
            curr=curr->sem_next;
            prev->sem_next=0;
            kern_scheduler_put(prev);
        }
        handle->waiting_thread=0;
    }
    kmem_cache_free(semaphore_cache,handle);
    return 0;
}

void kern_sem_signal(sem_t id)
{
    if(id->val>0 || id->waiting_thread==0) id->val++;
    else {
        thread_t woken = id->waiting_thread;
        id->waiting_thread=woken->sem_next;
        woken->mailbox=0;
        woken->status=READY;
        kern_scheduler_put(woken);
    }
}

int kern_sem_wait(sem_t id)
{
    if(id->val<=0){
        running->status=SUSPENDED;
        if(id->waiting_thread==0) id->waiting_thread=running;
        else {
            thread_t curr = id->waiting_thread;
            while (curr->sem_next!=0) curr=curr->sem_next;
            curr->sem_next=running;
        }
        running->sem_next=0;
        uint64 volatile sstatus = r_sstatus();
        uint64 volatile v_sepc = r_sepc();
        kern_thread_yield();
        w_sstatus(sstatus);
        w_sepc(v_sepc);
        return running->mailbox;
    }
    else {
        id->val--;
        return 1;
    }
}
