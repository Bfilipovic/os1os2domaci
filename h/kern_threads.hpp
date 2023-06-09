//
// Created by os on 5/22/23.
//

#ifndef OS1_KERN_THREADS_HPP
#define OS1_KERN_THREADS_HPP
#include "../lib/hw.h"

enum ThreadStatus {
    UNUSED,
    RUNNING,
    READY,
    SUSPENDED,
    JOINED,
    SLEEPING
};



struct thread_s{
    uint64 ra;
    uint64 sp;
    uint64 id;
    void(*body)(void*);
    void* arg;
    uint64 joined_tid;
    uint64 timeslice;
    uint64 endTime;
    uint64 stack_space;
    uint64 mailbox;
    enum ThreadStatus status;
    struct thread_s* sem_next;
};

typedef struct thread_s* thread_t;

extern  thread_t running;

extern struct thread_s kthreads[];

void kern_thread_init();
int kern_thread_create(struct thread_s** handle, void(*start_routine)(void*), void* arg, void* stack_space);
void kern_thread_dispatch();
thread_t kern_scheduler_get();
void kern_thread_end_running();
void kern_thread_join(thread_t handle);
void kern_thread_wakeup(uint64 system_time);
#endif //OS1_KERN_THREADS_HPP
