//
// Created by os on 5/23/23.
//

#include "../h/syscall_c.h"
#include "../h/kern_threads.h"
#include "../h/kern_reg_util.h"
#include "../h/kern_interrupts.h"

#include <stdarg.h>


void* mem_alloc (size_t size){
    uint64 blocks = (size+MEM_BLOCK_SIZE-1)/MEM_BLOCK_SIZE;
    kern_syscall(MEM_ALLOC, blocks);
    uint64 newBlockAddr = r_a0();
    return (void *) newBlockAddr;
}

int mem_free (void* addr){
    kern_syscall(MEM_FREE,addr);
    int res = (int) r_a0();
    return res;
}

struct thread_s;
typedef struct thread_s* thread_t;

int thread_create (thread_t* handle, void(*start_routine)(void*), void* arg)
{
    void * stack = mem_alloc(DEFAULT_STACK_SIZE);
    if(stack==0) return -1;
    kern_syscall(THREAD_CREATE,handle,start_routine,arg,stack);
    int res = r_a0();
    return res;
}

void thread_dispatch(){
    kern_syscall(THREAD_DISPATCH);
}

int thread_exit ()
{
    void* stack = (void*)running->stack_space;
    kern_syscall(THREAD_EXIT);
    kern_syscall(MEM_FREE,stack);
    return 0;
}

void thread_join(thread_t handle)
{
    kern_syscall(THREAD_JOIN,handle);
}

int sem_open (sem_t* handle, unsigned init)
{
    kern_syscall(SEM_OPEN,handle,init);
    int res = r_a0();
    return res;
}

int sem_close (sem_t handle)
{
    kern_syscall(SEM_CLOSE,handle);
    int res = r_a0();
    return res;
}

int sem_wait (sem_t id)
{
    kern_syscall(SEM_WAIT,id);
    int res = r_a0();
    return res;
}

int sem_signal (sem_t id){
    kern_syscall(SEM_SIGNAL,id);
    int res = r_a0();
    return res;
}

int time_sleep(unsigned long time){
    kern_syscall(TIME_SLEEP,time);
    return 0;
}