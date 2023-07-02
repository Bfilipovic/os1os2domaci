//
// Created by os on 6/4/23.
//

#include "../h/kern_semaphore.hpp"
#include "../h/kern_reg_util.h"
#include "../h/kern_threads.hpp"


#define MAX_SEMAPHORES 256

struct sem_s semaphores[MAX_SEMAPHORES];

void kern_sem_init()
{
    for(int i=0;i<MAX_SEMAPHORES;i++){
        semaphores[i].waiting_thread=0;
        semaphores[i].val=0;
        semaphores[i].status=SEM_UNUSED;
    }
}

int kern_sem_open (sem_t* handle, unsigned init)
{
    int res=-1;
    for(int i=0;i<MAX_SEMAPHORES;i++){
        if(semaphores[i].status==SEM_UNUSED){
            semaphores[i].status=SEM_USED;
            semaphores[i].val=init;
            *handle=&semaphores[i];
            res++;
            break;
        }
    }
    return res;
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
