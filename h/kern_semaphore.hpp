//
// Created by os on 6/4/23.
//

#ifndef OS1_KERN_SEMAPHORE_HPP
#define OS1_KERN_SEMAPHORE_HPP
#include "../lib/hw.h"
#include "./kern_threads.hpp"

enum sem_status {
    SEM_USED,
    SEM_UNUSED
};

struct sem_s {
    int val;
    enum sem_status status;
    thread_t waiting_thread;
};

typedef struct sem_s* sem_t;
void kern_sem_init();
int kern_sem_open (sem_t* handle, unsigned init);
int kern_sem_close (sem_t handle);
void kern_sem_signal(sem_t id);
int kern_sem_wait(sem_t id);
#endif //OS1_KERN_SEMAPHORE_HPP
