//
// Created by os on 5/23/23.
//

#ifndef OS1_SYSCALL_C_H
#define OS1_SYSCALL_C_H
#include "../lib/hw.h"



void* mem_alloc (size_t size);
int mem_free (void*);

struct thread_s;
typedef struct thread_s* thread_t;
int thread_create (
        thread_t* handle,
        void(*start_routine)(void*),
        void* arg
);
void thread_join(thread_t handle);
int thread_exit ();
void thread_dispatch();
int time_sleep(unsigned long time);

struct sem_s;
typedef struct sem_s* sem_t;
int sem_open (sem_t* handle, unsigned init);
int sem_close (sem_t handle);
int sem_wait (sem_t id);
int sem_signal (sem_t id);


#endif //OS1_SYSCALL_C_H
