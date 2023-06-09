//
// Created by os on 5/25/23.
//

#ifndef OS1_KERN_INTERRUPTS_HPP
#define OS1_KERN_INTERRUPTS_HPP
#include "../lib/hw.h"

// kern_interrupts.c
enum SyscallNumber {
    MEM_ALLOC  = 0x01,
    MEM_FREE = 0x02,
    THREAD_CREATE = 0x11,
    THREAD_EXIT = 0x12,
    THREAD_DISPATCH = 0x13,
    THREAD_JOIN = 0x14,
    SEM_OPEN = 0x21,
    SEM_CLOSE = 0x22,
    SEM_WAIT = 0x23,
    SEM_SIGNAL = 0x24,
    TIME_SLEEP = 0x31,
    GETC = 0x41,
    PUTC = 0x42
};
void kern_interrupt_init();
void kern_syscall(enum SyscallNumber num, ...);


#endif //OS1_KERN_INTERRUPTS_HPP
