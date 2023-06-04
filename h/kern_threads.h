//
// Created by os on 5/22/23.
//

#ifndef OS1_KERN_THREADS_H
#define OS1_KERN_THREADS_H
#include "../lib/hw.h"

enum ThreadStatus {
    UNUSED,
    RUNNING,
    READY,
    SUSPENDED,
};

enum ThreadType {
    REGULAR,
    PERIODIC
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
    enum ThreadType type;
    enum ThreadStatus status;
    uint64 syscall_retval;
};

typedef struct thread_s* thread_t;

extern  thread_t running;

extern struct thread_s threads[];

void kern_thread_init();
int kern_thread_create(struct thread_s** handle, void(*start_routine)(void*), void* arg, void* stack_space);
void kern_thread_dispatch();
thread_t kern_scheduler_get();
#endif //OS1_KERN_THREADS_H
