//
// Created by os on 5/18/23.
//
#include "../lib/console.h"
#include "../h/syscall_cpp.hpp"
#include "../h/syscall_c.h"
#include "../lib/hw.h"

#include "../h/kern_threads.hpp"
#include "../h/kern_memory.hpp"
#include "../h/kern_interrupts.hpp"
#include "../h/kern_semaphore.hpp"
#include "../h/kern_console.hpp"
#include "../h/printing.hpp"
#include "../h/kern_slab.hpp"

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
        putc(*c);
        time_sleep(1);
        counter++;
    }
    counter++;
    //thread_exit();
}

void bodyA(void* arg)
{
    char c = 'a';
    //if(semTest->wait()) c='A';
    for(int i=0;i<10;i++){
        putc(c);
        if(i==5) thread_exit();
        thread_dispatch();
    }
}

int g=0;

char str[15] = "tesa legenda";
void bodyB(void* arg)
{

    //time_sleep(10);
    for(int i=0;i<10;i++){
        putc(str[i]);
        for(int k=0;k<10000;k++){
            for(int m=0;m<1000;m++){
                if((m*k)%1337==0) g++;
            }
        }
    }
    semTest->signal();
}

extern void userMain();

class PeriodicTest : public PeriodicThread {
public:
    PeriodicTest(uint64 period, char c) : PeriodicThread(period){
        this->c = c;
    }
protected:
    char c;
    void periodicActivation() override {
        putc(c++);
    }
};

int main()
{
    char* buddy_start = (char*)HEAP_START_ADDR;
    uint64 memory_size = ((char *)HEAP_END_ADDR-(char *)HEAP_START_ADDR);
    uint64 buddy_size_in_blocks = (memory_size/8)/BLOCK_SIZE+1;
    char* buddy_end = buddy_start+buddy_size_in_blocks*BLOCK_SIZE;
    kmem_init(buddy_start,buddy_size_in_blocks);
    kern_mem_init((void*)buddy_end, (void*)HEAP_END_ADDR);
    kern_thread_init();

    kern_interrupt_init();
    kern_sem_init();
    kern_console_init();

    Thread* thrIdle = new Thread(&bodyIdle,0);
    thrIdle->start();

    printf("Printf proba %d valjda radi %x, %p\n", &thrIdle, &thrIdle, &thrIdle);
    //bba_init((char*)HEAP_START_ADDR, (char*)HEAP_END_ADDR);
    /*
    semTest=new Semaphore(0);
    Thread *thrA = new Thread(&bodyA,0);
    Thread *thrB = new Thread(&bodyB,0);
    thrB->start();
    thrA->start();
    thrB->join();
    putc('S');
     */
    /*
    char c='M';
    c++;
    Thread *thrCobj = new Thread(&bodyC,&c);
    thrCobj->start();

    thrCobj->join();
    */
    //thrB->join();
    //thrA->join();
    /*
    thrB->join();

    char o='O';
    o++;
    thread_t thrC;
    thread_create(&thrC,&bodyC,&o);
    thrCobj->join();
    thread_join(thrC);
    delete thrCobj;
    thrB->start();
    thrB->join();

*/
    /*char x = getc();
    x=getc();
    x++;
    putc(x);*/
    userMain();
/*
    PeriodicTest* pt = new PeriodicTest(30, 'A');
    PeriodicTest* pt2 = new PeriodicTest(10, 'a');
    pt->start();
    pt2->start();
    putc('E');
    char x = 'm';
    while (x!='x'){
        x=getc();
        putc(x);
    }

    pt->terminate();
    pt2->terminate();
    */
    idleAlive=0;
    return 0;
}