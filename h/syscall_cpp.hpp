//
// Created by os on 6/5/23.
//

#ifndef OS1_SYSCALL_CPP_HPP
#define OS1_SYSCALL_CPP_HPP
#ifndef _syscall_cpp
#define _syscall_cpp

extern "C"{
#include "syscall_c.h"
#include "kern_semaphore.h"
#include "kern_threads.h"
#include "kern_memory.h"
#include "syscall_c.h"
};
#include "../lib/console.h"


void* operator new(size_t size) {
    void* ptr = mem_alloc(size);
    return ptr;
}

void operator delete(void* ptr) {
    mem_free(ptr);
}


class Thread {
        public:
        Thread (void (*body)(void*), void* arg)
        {
            this->body=body;
            this->arg=arg;
        }
        virtual ~Thread (){
            //running=myHandle;
            //thread_exit();
        }
        int start (){
            return thread_create(&myHandle,body,arg);
        }
        void join(){
            thread_join(myHandle);
        }
        static void dispatch (){
            thread_dispatch();
        }
        static int sleep (time_t time){
            return time_sleep(time);
        }
        protected:
        Thread (){}
        virtual void run () {}
        private:
        thread_t myHandle;
        void (*body)(void*); void* arg;
};

class Semaphore {
        public:
        Semaphore (unsigned init = 1){
            sem_open(&myHandle,init);
        }
        virtual ~Semaphore (){
            sem_close(myHandle);
        }
        int wait (){
            return sem_wait(myHandle);
        }
        int signal (){
            return sem_signal(myHandle);
        }
        private:
        sem_t myHandle;
};

class Console {
        public:
        static char getc (){
            return __getc();
        }
        static void putc (char c){
            __putc(c);
        }
};
#endif

#endif //OS1_SYSCALL_CPP_HPP
