//
// Created by os on 6/5/23.
//

#ifndef OS1_SYSCALL_CPP_HPP
#define OS1_SYSCALL_CPP_HPP
#ifndef _syscall_cpp
#define _syscall_cpp

#include "syscall_c.h"
#include "kern_semaphore.hpp"
#include "kern_threads.hpp"
#include "kern_memory.hpp"
#include "syscall_c.h"
#include "../lib/console.h"


void* operator new(size_t size);
void operator delete(void* ptr);

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
            if(body== nullptr) return thread_create(&myHandle,&threadEntry, this);
            else return thread_create(&myHandle,body,arg);
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
        Thread (){
            body= nullptr;
            arg= nullptr;
        }
        virtual void run () {}

        static void threadEntry(void* arg){
            Thread* self = static_cast<Thread*>(arg);
            self->run();
        }
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
            return ::getc();
        }
        static void putc (char c){
            ::putc(c);
        }
};
#endif

#endif //OS1_SYSCALL_CPP_HPP
