//
// Created by os on 5/22/23.
//

#include "../lib/hw.h"
#include "../lib/console.h"
#include "../h/kern_interrupts.h"
#include "../h/kern_reg_util.h"
#include "../h/kern_memory.h"
#include "../h/kern_threads.h"
#include "../h/syscall_c.h"
#include "../h/kern_semaphore.h"

#define INTR_ILLEGAL_INSTRUCTION 0x0000000000000002UL
#define INTR_ILLEGAL_ADDR_RD 0x0000000000000005UL
#define INTR_ILLEGAL_ADDR_WR 0x0000000000000007UL
#define INTR_USER_ECALL 0x0000000000000008UL
#define INTR_KERNEL_ECALL 0x0000000000000009UL
#define INTR_TIMER 0x8000000000000001UL
#define INTR_CONSOLE 0x8000000000000009UL


extern void supervisorTrap();


uint64 SYSTEM_TIME;


void kern_syscall(enum SyscallNumber num, ...)
{
    __asm__ volatile ("ecall");
    return;
}

void kern_interrupt_init()
{
    SYSTEM_TIME=0;
    w_stvec((uint64) &supervisorTrap);
    ms_sstatus(SSTATUS_SIE);
}


int time=0;

void handleEcall(uint64 a0, uint64 a1, uint64 a2, uint64 a3, uint64 a4) {
    /*uint64 a0, a1, a2, a3, a4;
    __asm__ volatile ("mv %[a0], a0" : [a0] "=r"(a0));
    __asm__ volatile ("mv %[a1], a1" : [a1] "=r"(a1));
    __asm__ volatile ("mv %[a2], a2" : [a2] "=r"(a2));
    __asm__ volatile ("mv %[a3], a3" : [a3] "=r"(a3));
    __asm__ volatile ("mv %[a4], a4" : [a4] "=r"(a4));
     */
    uint64 scause = r_scause();
    if (scause == INTR_USER_ECALL || scause == INTR_KERNEL_ECALL) {
        uint64 retval;
        uint64 syscall_num = a0;
        uint64 sepc = r_sepc() + 4;
        w_sepc(sepc);
        switch (syscall_num) {
            case MEM_ALLOC: {
                uint64 size = a1;
                retval = (uint64) kern_mem_alloc(size);
                w_a0(retval);
                break;
            }

            case MEM_FREE: {
                uint64 addr = a1;
                retval = (uint64) kern_mem_free((void *) addr);
                w_a0(retval);
                break;
            }

            case THREAD_CREATE: {
                uint64 handle = a1;
                uint64 start_routine = a2;
                uint64 arg = a3;
                uint64 stack = a4;
                retval = (uint64) kern_thread_create((thread_t *) handle,
                                                     (void (*)(void *)) start_routine,
                                                     (void *) arg,
                                                     (void *) stack);
                (*(thread_t *) handle)->endTime = SYSTEM_TIME + DEFAULT_TIME_SLICE;
                w_a0(retval);
                break;
            }

            case THREAD_DISPATCH: {
                uint64 volatile sstatus = r_sstatus();
                uint64 volatile v_sepc = r_sepc();
                kern_thread_dispatch();
                w_sstatus(sstatus);
                w_sepc(v_sepc);
                running->endTime = time + running->timeslice;
                break;
            }

            case THREAD_JOIN: {
                thread_t handle = (thread_t) a1;
                uint64 volatile sstatus = r_sstatus();
                uint64 volatile v_sepc = r_sepc();
                kern_thread_join(handle);
                w_sstatus(sstatus);
                w_sepc(v_sepc);
                running->endTime = time + running->timeslice;
                break;
            }

            case THREAD_EXIT: {
                kern_thread_end_running();
            }

            case SEM_OPEN: {
                sem_t *handle = (sem_t *) a1;
                uint64 init = a2;
                retval = kern_sem_open(handle, init);
                w_a0(retval);
                break;
            }

            case SEM_CLOSE: {
                sem_t handle = (sem_t) a1;
                retval = kern_sem_close(handle);
                w_a0(retval);
                break;
            }

            case SEM_SIGNAL: {
                sem_t handle = (sem_t) a1;
                kern_sem_signal(handle);
                retval = 0;
                w_a0(retval);
                break;
            }

            case SEM_WAIT: {
                sem_t handle = (sem_t) a1;
                retval = kern_sem_wait(handle);
                if (retval == 1) { //nije promenjen kontekst
                    retval = 0;
                }
                else {
                    running->endTime = time + running->timeslice;
                }
                w_a0(retval);
                break;
            }

            case TIME_SLEEP : {
                uint64 period = a1;
                running->status = SLEEPING;
                running->endTime = SYSTEM_TIME + period;
                uint64 volatile sstatus = r_sstatus();
                uint64 volatile v_sepc = r_sepc();
                kern_thread_dispatch();
                w_sstatus(sstatus);
                w_sepc(v_sepc);
                running->endTime = time + running->timeslice;
            }

            case GETC: {
                break;
            }

            case PUTC: {
                break;
            }


        }
    }
}

void handleInterrupt()
{
    uint64 scause = r_scause();
    if (scause == INTR_TIMER)
    {
        SYSTEM_TIME++;
        mc_sip(SIP_SSIP);


        kern_thread_wakeup(SYSTEM_TIME);

        if(SYSTEM_TIME>=running->endTime){
            //__putc('(');
            //__putc('0'+running->id);
            //__putc('-');
            //__putc('>');
            uint64 volatile sstatus = r_sstatus();
            uint64 volatile v_sepc = r_sepc();
            kern_thread_dispatch();
            w_sstatus(sstatus);
            w_sepc(v_sepc);
            running->endTime=SYSTEM_TIME+running->timeslice;
            //__putc('0'+running->id);
            //__putc(')');
        }

    }
    else if (scause == INTR_CONSOLE)
    {
        // interrupt: yes; cause code: supervisor external interrupt (PLIC; could be keyboard)
        int i = plic_claim();
        if(i==10){
            plic_complete(i);
            i--;
        }
        else {
            i++;
        }
        console_handler();
    }
    else if(scause == INTR_ILLEGAL_INSTRUCTION)
    {
        // unexpected trap cause
    }
    else if(scause == INTR_ILLEGAL_ADDR_RD)
    {

    }
    else if(scause==INTR_ILLEGAL_ADDR_WR){

    }
}
