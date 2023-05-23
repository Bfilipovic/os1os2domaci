//
// Created by os on 5/23/23.
//

#include "../h/syscall_c.h"


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