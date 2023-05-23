//
// Created by os on 5/22/23.
//

#include "../lib/hw.h"
#include "../lib/console.h"

#define INTR_ILLEGAL_INSTRUCTION 0x0000000000000002UL
#define INTR_ILLEGAL_ADDR_RD 0x0000000000000005UL
#define INTR_ILLEGAL_ADDR_WR 0x0000000000000007UL
#define INTR_USER_ECALL 0x0000000000000008UL
#define INTR_KERNEL_ECALL 0x0000000000000009UL
#define INTR_TIMER 0x8000000000000001UL
#define INTR_CONSOLE 0x8000000000000009UL

inline uint64 r_scause();
inline void w_scause(uint64 scause);
inline uint64 r_sepc();
inline void w_sepc(uint64 sepc);
inline uint64 r_stvec();
inline void w_stvec(uint64 stvec);
inline uint64 r_stval();
inline void w_stval(uint64 stval);
inline void ms_sip(uint64 mask);
inline void mc_sip(uint64 mask);
inline uint64 r_sip();
inline void w_sip(uint64 sip);
inline void ms_sstatus(uint64 mask);
inline void mc_sstatus(uint64 mask);
inline uint64 r_sstatus();
inline void w_sstatus(uint64 sstatus);
extern void supervisorTrap();

enum BitMaskSstatus
{
    SSTATUS_SIE = (1 << 1),
    SSTATUS_SPIE = (1 << 5),
    SSTATUS_SPP = (1 << 8),
};

enum BitMaskSip
{
    SIP_SSIP = (1 << 1),
    SIP_STIP = (1 << 5),
    SIP_SEIP = (1 << 9),
};



void kern_interrupt_init()
{
    w_stvec((uint64) &supervisorTrap);
    ms_sstatus(SSTATUS_SIE);
}


int time=0;

void handleSupervisorTrap()
{
    uint64 scause = r_scause();
    if (scause == INTR_USER_ECALL || scause == INTR_KERNEL_ECALL)
    {
        // interrupt: no; cause code: environment call from U-mode(8) or S-mode(9)
    }
    else if (scause == INTR_TIMER)
    {
       mc_sip(SIP_SSIP);
       if(++time>=30){
           __putc('!');
       }
       time=time%30;
    }
    else if (scause == INTR_CONSOLE)
    {
        // interrupt: yes; cause code: supervisor external interrupt (PLIC; could be keyboard)
        plic_claim();
       // console_handler();
    }
    else
    {
        // unexpected trap cause
    }
}

inline uint64 r_scause()
{
    uint64 volatile scause;
    __asm__ volatile ("csrr %[scause], scause" : [scause] "=r"(scause));
    return scause;
}

inline void w_scause(uint64 scause)
{
    __asm__ volatile ("csrw scause, %[scause]" : : [scause] "r"(scause));
}

inline uint64 r_sepc()
{
    uint64 volatile sepc;
    __asm__ volatile ("csrr %[sepc], sepc" : [sepc] "=r"(sepc));
    return sepc;
}

inline void w_sepc(uint64 sepc)
{
    __asm__ volatile ("csrw sepc, %[sepc]" : : [sepc] "r"(sepc));
}

inline uint64 r_stvec()
{
    uint64 volatile stvec;
    __asm__ volatile ("csrr %[stvec], stvec" : [stvec] "=r"(stvec));
    return stvec;
}

inline void w_stvec(uint64 stvec)
{
    __asm__ volatile ("csrw stvec, %[stvec]" : : [stvec] "r"(stvec));
}

inline uint64 r_stval()
{
    uint64 volatile stval;
    __asm__ volatile ("csrr %[stval], stval" : [stval] "=r"(stval));
    return stval;
}

inline void w_stval(uint64 stval)
{
    __asm__ volatile ("csrw stval, %[stval]" : : [stval] "r"(stval));
}

inline void ms_sip(uint64 mask)
{
    __asm__ volatile ("csrs sip, %[mask]" : : [mask] "r"(mask));
}

inline void mc_sip(uint64 mask)
{
    __asm__ volatile ("csrc sip, %[mask]" : : [mask] "r"(mask));
}

inline uint64 r_sip()
{
    uint64 volatile sip;
    __asm__ volatile ("csrr %[sip], sip" : [sip] "=r"(sip));
    return sip;
}

inline void w_sip(uint64 sip)
{
    __asm__ volatile ("csrw sip, %[sip]" : : [sip] "r"(sip));
}

inline void ms_sstatus(uint64 mask)
{
    __asm__ volatile ("csrs sstatus, %[mask]" : : [mask] "r"(mask));
}

inline void mc_sstatus(uint64 mask)
{
    __asm__ volatile ("csrc sstatus, %[mask]" : : [mask] "r"(mask));
}

inline uint64 r_sstatus()
{
    uint64 volatile sstatus;
    __asm__ volatile ("csrr %[sstatus], sstatus" : [sstatus] "=r"(sstatus));
    return sstatus;
}

inline void w_sstatus(uint64 sstatus)
{
    __asm__ volatile ("csrw sstatus, %[sstatus]" : : [sstatus] "r"(sstatus));
}
