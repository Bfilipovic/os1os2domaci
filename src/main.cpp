//
// Created by os on 5/18/23.
//
#include "../lib/console.h"
#include "../h/strings.h"
#include "../h/syscall_cpp.hpp"
#include "../lib/hw.h"

extern "C" {
#include "../h/kern_threads.h"
#include "../h/syscall_c.h"
#include "../h/kern_memory.h"
#include "../h/kern_interrupts.h"
#include "../h/kern_semaphore.h"
}


Semaphore* semTest;

int idleAlive=1;
void bodyIdle(void* arg){
    while(idleAlive){
        thread_dispatch();
    };
}

void bodyC(void* arg)
{
    int counter=0;
    char*c = (char*)arg;
    while(counter<10){
        //if(++counter>5) delete semTest;
        __putc(*c);
        time_sleep(5);
        counter++;
    }
}

void bodyA(void* arg)
{
    char c = 'a';
    if(semTest->wait()) c='A';
    for(int i=0;i<10;i++){
        __putc(c);
        if(i==5) thread_exit();
        thread_dispatch();
    }
}

int g=0;

char str[15] = "tesa legenda";
void bodyB(void* arg)
{
    time_sleep(10);
    for(int i=0;i<15;i++){
        __putc(str[i]);
        for(int k=0;k<10000;k++){
            for(int m=0;m<1000;m++){
                if((m*k)%1337==0) g++;
            }
        }
    }
    semTest->signal();
}


int main()
{
    kern_thread_init();
    //printstring("lalala");

    kern_mem_init((void*)HEAP_START_ADDR, (void*)HEAP_END_ADDR);
    kern_interrupt_init();
    kern_sem_init();

    Thread* thrIdle = new Thread(&bodyIdle,0);
    thrIdle->start();
/*
    void* a;
    void* b;
    void* c;
    a = kern_mem_alloc(64);
    b = kern_mem_alloc(64);
    c = kern_mem_alloc(64);


    kern_mem_free(a);
    kern_mem_free(c);
    kern_mem_free(b);


    a= mem_alloc(64);
    mem_free(a);
    */

/*
    semTest=new Semaphore(0);
    Thread *thrA = new Thread(&bodyA,0);
    Thread *thrB = new Thread(&bodyB,0);
    thrA->start();
    thrB->start();
    __putc('S');
    thrB->join();
    thrA->join();
    thrB->join();
    char o='O';
    char c='M';
    c++;
    o++;
    Thread* thrCobj = new Thread(bodyC, &o);
    thrCobj->start();
    thread_t thrC;
    thread_create(&thrC,bodyC,&c);
    thread_join(thrC);
    //idleAlive=0;
    thrCobj->join();
    delete thrCobj;
    */
    __putc('E');
    while(1);
    return 0;
}