//
// Created by os on 5/22/23.
//

#include "../h/kern_threads.h"
#include "../h/kern_defs.h"
#include "../lib/hw.h"

#define MAX_THREADS 64

enum ThreadStatus {
    UNUSED,
    CREATED,
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
    enum ThreadType type;
    enum ThreadStatus status;
};
typedef struct thread_s* thread_t;

struct thread_s threads[MAX_THREADS];
thread_t running;
static int id;

struct thread_s* kern_thread_create(thread_t* handle, void(*start_routine)(void*), void* arg);

void kern_thread_init()
{
    id=0;
    for (int i=0;i<MAX_THREADS;i++){
        threads[i].status=UNUSED;
    }
}

thread_t kern_scheduler_get()
{
    int num = running-threads;
    for(int i=1;i<=MAX_THREADS;i++){
        num = (num+i)%MAX_THREADS;
        if(threads[num].status==READY) return &threads[num];
    }
    return 0;
}

void kern_thread_yield()
{
    __asm__ volatile ("ecall");
}

void popSppSpie()
{
    __asm__ volatile("csrw sepc, ra"); //ovde dodaj izlazak iz privilegovanog moda
    __asm__ volatile("sret");
}

extern void contextSwitch(thread_t old, thread_t new);

void kern_thread_dispatch()
{
    thread_t old = running;
    running=kern_scheduler_get();
    if(old!=running){
        contextSwitch(old,running);
    }
}

void kern_thread_wrapper()
{
    popSppSpie();
    running->body(running->arg);
    running->status=UNUSED;
    kern_thread_yield();
}
