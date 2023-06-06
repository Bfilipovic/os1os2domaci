//
// Created by os on 5/23/23.
//

#ifndef OS1_KERN_REG_UTIL_H
#define OS1_KERN_REG_UTIL_H

#include "../lib/hw.h"

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

inline uint64 r_a0()
{
    uint64 volatile a0;
    __asm__ volatile ("mv %[a0], a0" : [a0] "=r"(a0));
    return a0;
}
inline void w_a0(uint64 value)
{
    __asm__ volatile ("mv a0, %[value]" :: [value] "r"(value));
}

inline uint64 r_a1()
{
    uint64 volatile a1;
    __asm__ volatile ("mv %[a1], a1" : [a1] "=r"(a1));
    return a1;
}

inline uint64 r_a2()
{
    uint64 volatile a2;
    __asm__ volatile ("mv %[a2], a2" : [a2] "=r"(a2));
    return a2;
}

inline uint64 r_a3()
{
    uint64 volatile a3;
    __asm__ volatile ("mv %[a3], a3" : [a3] "=r"(a3));
    return a3;
}

inline uint64 r_a4()
{
    uint64 volatile a4;
    __asm__ volatile ("mv %[a4], a4" : [a4] "=r"(a4));
    return a4;
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

#endif //OS1_KERN_REG_UTIL_H
