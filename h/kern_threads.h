//
// Created by os on 5/22/23.
//

#ifndef OS1_KERN_THREADS_H
#define OS1_KERN_THREADS_H
struct thread_s;

struct thread_s* kern_thread_create(struct thread_s** handle, void(*start_routine)(void*), void* arg);
void kern_thread_dispatch();
#endif //OS1_KERN_THREADS_H
