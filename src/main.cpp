//
// Created by os on 5/18/23.
//
#include "../lib/console.h"
#include "../h/strings.h"
#include "../lib/hw.h"

extern "C" {
#include "../h/kern_threads.h"
#include "../h/syscall_c.h"
#include "../h/kern_memory.h"
#include "../h/kern_interrupts.h"
}

void bodyA(void* arg)
{
    for(int i=0;i<10;i++){
        __putc('a');
        thread_dispatch();
    }
}

int g=0;

void bodyB(void* arg)
{
    for(int i=0;i<15;i++){
        __putc('b');
        for(int k=0;k<10000;k++){
            for(int m=0;m<1000;m++){
                if((m*k)%1337==0) g++;
            }
        }
    }
}


int main()
{
    kern_thread_init();
    __putc('o');
    __putc('s');
    __putc('1');
    //printstring("lalala");

    kern_mem_init((void*)HEAP_START_ADDR, (void*)HEAP_END_ADDR);
    kern_interrupt_init();
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
    thread_t thrA, thrB;
    thread_create(&thrA,&bodyA,0);
    thread_create(&thrB,&bodyB,0);



    char chr = '0';
    while (1){
        __putc(chr++);
        thread_dispatch();
        if(thrA->status==UNUSED && thrB->status==UNUSED) break;
    }

    __putc('E');

    while(1);
    return 0;
}