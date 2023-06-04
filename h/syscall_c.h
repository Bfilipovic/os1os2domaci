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

int thread_exit ();
void thread_dispatch();
#endif //OS1_SYSCALL_C_H
