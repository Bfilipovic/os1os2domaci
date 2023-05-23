//
// Created by os on 5/18/23.
//
#include "../lib/console.h"
#include "../h/strings.h"
#include "../lib/hw.h"

extern "C" {
#include "../h/kern_defs.h"
#include "../h/kern_threads.h"
}

int main()
{
    __putc('o');
    __putc('s');
    __putc('1');
    printstring("lalala");
    void* a;
    void* b;
    void* c;

    kern_mem_init((void*)HEAP_START_ADDR, (void*)HEAP_END_ADDR);
    a = kern_mem_alloc(64);
    b = kern_mem_alloc(64);
    c = kern_mem_alloc(64);


    kern_mem_free(a);
    kern_mem_free(c);
    kern_mem_free(b);

    kern_interrupt_init();

    while (1){}

    return 0;
}