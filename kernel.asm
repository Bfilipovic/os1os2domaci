
kernel:     file format elf64-littleriscv


Disassembly of section .text:

0000000080000000 <_entry>:
    80000000:	0000d117          	auipc	sp,0xd
    80000004:	b6813103          	ld	sp,-1176(sp) # 8000cb68 <_GLOBAL_OFFSET_TABLE_+0x38>
    80000008:	00001537          	lui	a0,0x1
    8000000c:	f14025f3          	csrr	a1,mhartid
    80000010:	00158593          	addi	a1,a1,1
    80000014:	02b50533          	mul	a0,a0,a1
    80000018:	00a10133          	add	sp,sp,a0
    8000001c:	7c4070ef          	jal	ra,800077e0 <start>

0000000080000020 <spin>:
    80000020:	0000006f          	j	80000020 <spin>
	...

0000000080001000 <copy_and_swap>:
# a1 holds expected value
# a2 holds desired value
# a0 holds return value, 0 if successful, !0 otherwise
.global copy_and_swap
copy_and_swap:
    lr.w t0, (a0)          # Load original value.
    80001000:	100522af          	lr.w	t0,(a0)
    bne t0, a1, fail       # Doesn’t match, so fail.
    80001004:	00b29a63          	bne	t0,a1,80001018 <fail>
    sc.w t0, a2, (a0)      # Try to update.
    80001008:	18c522af          	sc.w	t0,a2,(a0)
    bnez t0, copy_and_swap # Retry if store-conditional failed.
    8000100c:	fe029ae3          	bnez	t0,80001000 <copy_and_swap>
    li a0, 0               # Set return to success.
    80001010:	00000513          	li	a0,0
    jr ra                  # Return.
    80001014:	00008067          	ret

0000000080001018 <fail>:
    fail:
    li a0, 1               # Set return to failure.
    80001018:	00100513          	li	a0,1
    8000101c:	00008067          	ret

0000000080001020 <supervisorTrap>:
.align 4
.global supervisorTrap
.type supervisorTrap @function
supervisorTrap:

    addi sp, sp, -24
    80001020:	fe810113          	addi	sp,sp,-24
    sd t0, 0(sp)
    80001024:	00513023          	sd	t0,0(sp)
    sd t1, 8(sp)
    80001028:	00613423          	sd	t1,8(sp)
    sd t2, 16(sp)
    8000102c:	00713823          	sd	t2,16(sp)
    csrr t0, scause
    80001030:	142022f3          	csrr	t0,scause
    li t1, 8
    80001034:	00800313          	li	t1,8
    li t2, 9
    80001038:	00900393          	li	t2,9
    beq t0, t1, ecall
    8000103c:	10628c63          	beq	t0,t1,80001154 <ecall>
    beq t0, t2, ecall
    80001040:	10728a63          	beq	t0,t2,80001154 <ecall>

    # spoljasnji prekidi nemaju povratnu vrednost => cuvamo i a0 (x10)
    addi sp, sp, -256
    80001044:	f0010113          	addi	sp,sp,-256
    .irp index, 0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31
    sd x\index, \index * 8(sp)
    .endr
    80001048:	00013023          	sd	zero,0(sp)
    8000104c:	00113423          	sd	ra,8(sp)
    80001050:	00213823          	sd	sp,16(sp)
    80001054:	00313c23          	sd	gp,24(sp)
    80001058:	02413023          	sd	tp,32(sp)
    8000105c:	02513423          	sd	t0,40(sp)
    80001060:	02613823          	sd	t1,48(sp)
    80001064:	02713c23          	sd	t2,56(sp)
    80001068:	04813023          	sd	s0,64(sp)
    8000106c:	04913423          	sd	s1,72(sp)
    80001070:	04a13823          	sd	a0,80(sp)
    80001074:	04b13c23          	sd	a1,88(sp)
    80001078:	06c13023          	sd	a2,96(sp)
    8000107c:	06d13423          	sd	a3,104(sp)
    80001080:	06e13823          	sd	a4,112(sp)
    80001084:	06f13c23          	sd	a5,120(sp)
    80001088:	09013023          	sd	a6,128(sp)
    8000108c:	09113423          	sd	a7,136(sp)
    80001090:	09213823          	sd	s2,144(sp)
    80001094:	09313c23          	sd	s3,152(sp)
    80001098:	0b413023          	sd	s4,160(sp)
    8000109c:	0b513423          	sd	s5,168(sp)
    800010a0:	0b613823          	sd	s6,176(sp)
    800010a4:	0b713c23          	sd	s7,184(sp)
    800010a8:	0d813023          	sd	s8,192(sp)
    800010ac:	0d913423          	sd	s9,200(sp)
    800010b0:	0da13823          	sd	s10,208(sp)
    800010b4:	0db13c23          	sd	s11,216(sp)
    800010b8:	0fc13023          	sd	t3,224(sp)
    800010bc:	0fd13423          	sd	t4,232(sp)
    800010c0:	0fe13823          	sd	t5,240(sp)
    800010c4:	0ff13c23          	sd	t6,248(sp)

    call handleInterrupt
    800010c8:	6a8020ef          	jal	ra,80003770 <handleInterrupt>

    .irp index, 0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31
    ld x\index, \index * 8(sp)
    .endr
    800010cc:	00013003          	ld	zero,0(sp)
    800010d0:	00813083          	ld	ra,8(sp)
    800010d4:	01013103          	ld	sp,16(sp)
    800010d8:	01813183          	ld	gp,24(sp)
    800010dc:	02013203          	ld	tp,32(sp)
    800010e0:	02813283          	ld	t0,40(sp)
    800010e4:	03013303          	ld	t1,48(sp)
    800010e8:	03813383          	ld	t2,56(sp)
    800010ec:	04013403          	ld	s0,64(sp)
    800010f0:	04813483          	ld	s1,72(sp)
    800010f4:	05013503          	ld	a0,80(sp)
    800010f8:	05813583          	ld	a1,88(sp)
    800010fc:	06013603          	ld	a2,96(sp)
    80001100:	06813683          	ld	a3,104(sp)
    80001104:	07013703          	ld	a4,112(sp)
    80001108:	07813783          	ld	a5,120(sp)
    8000110c:	08013803          	ld	a6,128(sp)
    80001110:	08813883          	ld	a7,136(sp)
    80001114:	09013903          	ld	s2,144(sp)
    80001118:	09813983          	ld	s3,152(sp)
    8000111c:	0a013a03          	ld	s4,160(sp)
    80001120:	0a813a83          	ld	s5,168(sp)
    80001124:	0b013b03          	ld	s6,176(sp)
    80001128:	0b813b83          	ld	s7,184(sp)
    8000112c:	0c013c03          	ld	s8,192(sp)
    80001130:	0c813c83          	ld	s9,200(sp)
    80001134:	0d013d03          	ld	s10,208(sp)
    80001138:	0d813d83          	ld	s11,216(sp)
    8000113c:	0e013e03          	ld	t3,224(sp)
    80001140:	0e813e83          	ld	t4,232(sp)
    80001144:	0f013f03          	ld	t5,240(sp)
    80001148:	0f813f83          	ld	t6,248(sp)
    addi sp, sp, 256
    8000114c:	10010113          	addi	sp,sp,256

    j return
    80001150:	1080006f          	j	80001258 <return>

0000000080001154 <ecall>:

ecall:
    # If scause register is 8 or 9
    addi sp, sp, -256
    80001154:	f0010113          	addi	sp,sp,-256
    .irp index, 0,1,2,3,4,5,6,7,8,9,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31
    sd x\index, \index * 8(sp)
    .endr
    80001158:	00013023          	sd	zero,0(sp)
    8000115c:	00113423          	sd	ra,8(sp)
    80001160:	00213823          	sd	sp,16(sp)
    80001164:	00313c23          	sd	gp,24(sp)
    80001168:	02413023          	sd	tp,32(sp)
    8000116c:	02513423          	sd	t0,40(sp)
    80001170:	02613823          	sd	t1,48(sp)
    80001174:	02713c23          	sd	t2,56(sp)
    80001178:	04813023          	sd	s0,64(sp)
    8000117c:	04913423          	sd	s1,72(sp)
    80001180:	04b13c23          	sd	a1,88(sp)
    80001184:	06c13023          	sd	a2,96(sp)
    80001188:	06d13423          	sd	a3,104(sp)
    8000118c:	06e13823          	sd	a4,112(sp)
    80001190:	06f13c23          	sd	a5,120(sp)
    80001194:	09013023          	sd	a6,128(sp)
    80001198:	09113423          	sd	a7,136(sp)
    8000119c:	09213823          	sd	s2,144(sp)
    800011a0:	09313c23          	sd	s3,152(sp)
    800011a4:	0b413023          	sd	s4,160(sp)
    800011a8:	0b513423          	sd	s5,168(sp)
    800011ac:	0b613823          	sd	s6,176(sp)
    800011b0:	0b713c23          	sd	s7,184(sp)
    800011b4:	0d813023          	sd	s8,192(sp)
    800011b8:	0d913423          	sd	s9,200(sp)
    800011bc:	0da13823          	sd	s10,208(sp)
    800011c0:	0db13c23          	sd	s11,216(sp)
    800011c4:	0fc13023          	sd	t3,224(sp)
    800011c8:	0fd13423          	sd	t4,232(sp)
    800011cc:	0fe13823          	sd	t5,240(sp)
    800011d0:	0ff13c23          	sd	t6,248(sp)
    
    call handleEcall
    800011d4:	30c020ef          	jal	ra,800034e0 <handleEcall>
    
    .irp index, 0,1,2,3,4,5,6,7,8,9,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31
    ld x\index, \index * 8(sp)
    .endr
    800011d8:	00013003          	ld	zero,0(sp)
    800011dc:	00813083          	ld	ra,8(sp)
    800011e0:	01013103          	ld	sp,16(sp)
    800011e4:	01813183          	ld	gp,24(sp)
    800011e8:	02013203          	ld	tp,32(sp)
    800011ec:	02813283          	ld	t0,40(sp)
    800011f0:	03013303          	ld	t1,48(sp)
    800011f4:	03813383          	ld	t2,56(sp)
    800011f8:	04013403          	ld	s0,64(sp)
    800011fc:	04813483          	ld	s1,72(sp)
    80001200:	05813583          	ld	a1,88(sp)
    80001204:	06013603          	ld	a2,96(sp)
    80001208:	06813683          	ld	a3,104(sp)
    8000120c:	07013703          	ld	a4,112(sp)
    80001210:	07813783          	ld	a5,120(sp)
    80001214:	08013803          	ld	a6,128(sp)
    80001218:	08813883          	ld	a7,136(sp)
    8000121c:	09013903          	ld	s2,144(sp)
    80001220:	09813983          	ld	s3,152(sp)
    80001224:	0a013a03          	ld	s4,160(sp)
    80001228:	0a813a83          	ld	s5,168(sp)
    8000122c:	0b013b03          	ld	s6,176(sp)
    80001230:	0b813b83          	ld	s7,184(sp)
    80001234:	0c013c03          	ld	s8,192(sp)
    80001238:	0c813c83          	ld	s9,200(sp)
    8000123c:	0d013d03          	ld	s10,208(sp)
    80001240:	0d813d83          	ld	s11,216(sp)
    80001244:	0e013e03          	ld	t3,224(sp)
    80001248:	0e813e83          	ld	t4,232(sp)
    8000124c:	0f013f03          	ld	t5,240(sp)
    80001250:	0f813f83          	ld	t6,248(sp)
    addi sp, sp, 256
    80001254:	10010113          	addi	sp,sp,256

0000000080001258 <return>:
    
    
return:
    ld t0, 0(sp)
    80001258:	00013283          	ld	t0,0(sp)
    ld t1, 8(sp)
    8000125c:	00813303          	ld	t1,8(sp)
    ld t2, 16(sp)
    80001260:	01013383          	ld	t2,16(sp)
    addi sp, sp, 24
    80001264:	01810113          	addi	sp,sp,24
    80001268:	10200073          	sret

000000008000126c <contextSwitch>:
.global contextSwitch
.type contextSwitch, @function
contextSwitch:
    sd ra, 0 * 8(a0)
    8000126c:	00153023          	sd	ra,0(a0) # 1000 <_entry-0x7ffff000>
    sd sp, 1 * 8(a0)
    80001270:	00253423          	sd	sp,8(a0)

    ld ra, 0 * 8(a1)
    80001274:	0005b083          	ld	ra,0(a1)
    ld sp, 1 * 8(a1)
    80001278:	0085b103          	ld	sp,8(a1)

    8000127c:	00008067          	ret

0000000080001280 <_Z9mem_allocm>:

#include <stdarg.h>

#define CONSOLE_CAN_READ ((*(char*)CONSOLE_STATUS)&CONSOLE_RX_STATUS_BIT)

void* mem_alloc (size_t size){
    80001280:	fe010113          	addi	sp,sp,-32
    80001284:	00113c23          	sd	ra,24(sp)
    80001288:	00813823          	sd	s0,16(sp)
    8000128c:	02010413          	addi	s0,sp,32
    uint64 blocks = (size+MEM_BLOCK_SIZE-1)/MEM_BLOCK_SIZE;
    80001290:	03f50593          	addi	a1,a0,63
    kern_syscall(MEM_ALLOC, blocks);
    80001294:	0065d593          	srli	a1,a1,0x6
    80001298:	00100513          	li	a0,1
    8000129c:	00002097          	auipc	ra,0x2
    800012a0:	20c080e7          	jalr	524(ra) # 800034a8 <_Z12kern_syscall13SyscallNumberz>
};

inline uint64 r_a0()
{
    uint64 volatile a0;
    __asm__ volatile ("mv %[a0], a0" : [a0] "=r"(a0));
    800012a4:	00050793          	mv	a5,a0
    800012a8:	fef43423          	sd	a5,-24(s0)
    return a0;
    800012ac:	fe843503          	ld	a0,-24(s0)
    uint64 newBlockAddr = r_a0();
    return (void *) newBlockAddr;
}
    800012b0:	01813083          	ld	ra,24(sp)
    800012b4:	01013403          	ld	s0,16(sp)
    800012b8:	02010113          	addi	sp,sp,32
    800012bc:	00008067          	ret

00000000800012c0 <_Z8mem_freePv>:

int mem_free (void* addr){
    800012c0:	fe010113          	addi	sp,sp,-32
    800012c4:	00113c23          	sd	ra,24(sp)
    800012c8:	00813823          	sd	s0,16(sp)
    800012cc:	02010413          	addi	s0,sp,32
    800012d0:	00050593          	mv	a1,a0
    kern_syscall(MEM_FREE,addr);
    800012d4:	00200513          	li	a0,2
    800012d8:	00002097          	auipc	ra,0x2
    800012dc:	1d0080e7          	jalr	464(ra) # 800034a8 <_Z12kern_syscall13SyscallNumberz>
    __asm__ volatile ("mv %[a0], a0" : [a0] "=r"(a0));
    800012e0:	00050793          	mv	a5,a0
    800012e4:	fef43423          	sd	a5,-24(s0)
    return a0;
    800012e8:	fe843503          	ld	a0,-24(s0)
    int res = (int) r_a0();
    return res;
}
    800012ec:	0005051b          	sext.w	a0,a0
    800012f0:	01813083          	ld	ra,24(sp)
    800012f4:	01013403          	ld	s0,16(sp)
    800012f8:	02010113          	addi	sp,sp,32
    800012fc:	00008067          	ret

0000000080001300 <_Z13thread_createPP8thread_sPFvPvES2_>:

struct thread_s;
typedef struct thread_s* thread_t;

int thread_create (thread_t* handle, void(*start_routine)(void*), void* arg)
{
    80001300:	fc010113          	addi	sp,sp,-64
    80001304:	02113c23          	sd	ra,56(sp)
    80001308:	02813823          	sd	s0,48(sp)
    8000130c:	02913423          	sd	s1,40(sp)
    80001310:	03213023          	sd	s2,32(sp)
    80001314:	01313c23          	sd	s3,24(sp)
    80001318:	04010413          	addi	s0,sp,64
    8000131c:	00050493          	mv	s1,a0
    80001320:	00058913          	mv	s2,a1
    80001324:	00060993          	mv	s3,a2
    void * stack = mem_alloc(DEFAULT_STACK_SIZE);
    80001328:	00001537          	lui	a0,0x1
    8000132c:	00000097          	auipc	ra,0x0
    80001330:	f54080e7          	jalr	-172(ra) # 80001280 <_Z9mem_allocm>
    if(stack==0) return -1;
    80001334:	04050663          	beqz	a0,80001380 <_Z13thread_createPP8thread_sPFvPvES2_+0x80>
    80001338:	00050713          	mv	a4,a0
    kern_syscall(THREAD_CREATE,handle,start_routine,arg,stack);
    8000133c:	00098693          	mv	a3,s3
    80001340:	00090613          	mv	a2,s2
    80001344:	00048593          	mv	a1,s1
    80001348:	01100513          	li	a0,17
    8000134c:	00002097          	auipc	ra,0x2
    80001350:	15c080e7          	jalr	348(ra) # 800034a8 <_Z12kern_syscall13SyscallNumberz>
    __asm__ volatile ("mv %[a0], a0" : [a0] "=r"(a0));
    80001354:	00050793          	mv	a5,a0
    80001358:	fcf43423          	sd	a5,-56(s0)
    return a0;
    8000135c:	fc843503          	ld	a0,-56(s0)
    int res = r_a0();
    80001360:	0005051b          	sext.w	a0,a0
    return res;
}
    80001364:	03813083          	ld	ra,56(sp)
    80001368:	03013403          	ld	s0,48(sp)
    8000136c:	02813483          	ld	s1,40(sp)
    80001370:	02013903          	ld	s2,32(sp)
    80001374:	01813983          	ld	s3,24(sp)
    80001378:	04010113          	addi	sp,sp,64
    8000137c:	00008067          	ret
    if(stack==0) return -1;
    80001380:	fff00513          	li	a0,-1
    80001384:	fe1ff06f          	j	80001364 <_Z13thread_createPP8thread_sPFvPvES2_+0x64>

0000000080001388 <_Z15thread_dispatchv>:

void thread_dispatch(){
    80001388:	ff010113          	addi	sp,sp,-16
    8000138c:	00113423          	sd	ra,8(sp)
    80001390:	00813023          	sd	s0,0(sp)
    80001394:	01010413          	addi	s0,sp,16
    kern_syscall(THREAD_DISPATCH);
    80001398:	01300513          	li	a0,19
    8000139c:	00002097          	auipc	ra,0x2
    800013a0:	10c080e7          	jalr	268(ra) # 800034a8 <_Z12kern_syscall13SyscallNumberz>
}
    800013a4:	00813083          	ld	ra,8(sp)
    800013a8:	00013403          	ld	s0,0(sp)
    800013ac:	01010113          	addi	sp,sp,16
    800013b0:	00008067          	ret

00000000800013b4 <_Z11thread_exitv>:

int thread_exit ()
{
    800013b4:	fe010113          	addi	sp,sp,-32
    800013b8:	00113c23          	sd	ra,24(sp)
    800013bc:	00813823          	sd	s0,16(sp)
    800013c0:	00913423          	sd	s1,8(sp)
    800013c4:	02010413          	addi	s0,sp,32
    void* stack = (void*)running->stack_space;
    800013c8:	0000b797          	auipc	a5,0xb
    800013cc:	7887b783          	ld	a5,1928(a5) # 8000cb50 <_GLOBAL_OFFSET_TABLE_+0x20>
    800013d0:	0007b783          	ld	a5,0(a5)
    800013d4:	0407b483          	ld	s1,64(a5)
    kern_syscall(THREAD_EXIT);
    800013d8:	01200513          	li	a0,18
    800013dc:	00002097          	auipc	ra,0x2
    800013e0:	0cc080e7          	jalr	204(ra) # 800034a8 <_Z12kern_syscall13SyscallNumberz>
    kern_syscall(MEM_FREE,stack);
    800013e4:	00048593          	mv	a1,s1
    800013e8:	00200513          	li	a0,2
    800013ec:	00002097          	auipc	ra,0x2
    800013f0:	0bc080e7          	jalr	188(ra) # 800034a8 <_Z12kern_syscall13SyscallNumberz>
    return 0;
}
    800013f4:	00000513          	li	a0,0
    800013f8:	01813083          	ld	ra,24(sp)
    800013fc:	01013403          	ld	s0,16(sp)
    80001400:	00813483          	ld	s1,8(sp)
    80001404:	02010113          	addi	sp,sp,32
    80001408:	00008067          	ret

000000008000140c <_Z11thread_joinP8thread_s>:

void thread_join(thread_t handle)
{
    8000140c:	ff010113          	addi	sp,sp,-16
    80001410:	00113423          	sd	ra,8(sp)
    80001414:	00813023          	sd	s0,0(sp)
    80001418:	01010413          	addi	s0,sp,16
    8000141c:	00050593          	mv	a1,a0
    kern_syscall(THREAD_JOIN,handle);
    80001420:	01400513          	li	a0,20
    80001424:	00002097          	auipc	ra,0x2
    80001428:	084080e7          	jalr	132(ra) # 800034a8 <_Z12kern_syscall13SyscallNumberz>
}
    8000142c:	00813083          	ld	ra,8(sp)
    80001430:	00013403          	ld	s0,0(sp)
    80001434:	01010113          	addi	sp,sp,16
    80001438:	00008067          	ret

000000008000143c <_Z8sem_openPP5sem_sj>:

int sem_open (sem_t* handle, unsigned init)
{
    8000143c:	fe010113          	addi	sp,sp,-32
    80001440:	00113c23          	sd	ra,24(sp)
    80001444:	00813823          	sd	s0,16(sp)
    80001448:	02010413          	addi	s0,sp,32
    8000144c:	00058613          	mv	a2,a1
    kern_syscall(SEM_OPEN,handle,init);
    80001450:	00050593          	mv	a1,a0
    80001454:	02100513          	li	a0,33
    80001458:	00002097          	auipc	ra,0x2
    8000145c:	050080e7          	jalr	80(ra) # 800034a8 <_Z12kern_syscall13SyscallNumberz>
    __asm__ volatile ("mv %[a0], a0" : [a0] "=r"(a0));
    80001460:	00050793          	mv	a5,a0
    80001464:	fef43423          	sd	a5,-24(s0)
    return a0;
    80001468:	fe843503          	ld	a0,-24(s0)
    int res = r_a0();
    return res;
}
    8000146c:	0005051b          	sext.w	a0,a0
    80001470:	01813083          	ld	ra,24(sp)
    80001474:	01013403          	ld	s0,16(sp)
    80001478:	02010113          	addi	sp,sp,32
    8000147c:	00008067          	ret

0000000080001480 <_Z9sem_closeP5sem_s>:

int sem_close (sem_t handle)
{
    80001480:	fe010113          	addi	sp,sp,-32
    80001484:	00113c23          	sd	ra,24(sp)
    80001488:	00813823          	sd	s0,16(sp)
    8000148c:	02010413          	addi	s0,sp,32
    80001490:	00050593          	mv	a1,a0
    kern_syscall(SEM_CLOSE,handle);
    80001494:	02200513          	li	a0,34
    80001498:	00002097          	auipc	ra,0x2
    8000149c:	010080e7          	jalr	16(ra) # 800034a8 <_Z12kern_syscall13SyscallNumberz>
    __asm__ volatile ("mv %[a0], a0" : [a0] "=r"(a0));
    800014a0:	00050793          	mv	a5,a0
    800014a4:	fef43423          	sd	a5,-24(s0)
    return a0;
    800014a8:	fe843503          	ld	a0,-24(s0)
    int res = r_a0();
    return res;
}
    800014ac:	0005051b          	sext.w	a0,a0
    800014b0:	01813083          	ld	ra,24(sp)
    800014b4:	01013403          	ld	s0,16(sp)
    800014b8:	02010113          	addi	sp,sp,32
    800014bc:	00008067          	ret

00000000800014c0 <_Z8sem_waitP5sem_s>:

int sem_wait (sem_t id)
{
    800014c0:	fe010113          	addi	sp,sp,-32
    800014c4:	00113c23          	sd	ra,24(sp)
    800014c8:	00813823          	sd	s0,16(sp)
    800014cc:	02010413          	addi	s0,sp,32
    800014d0:	00050593          	mv	a1,a0
    kern_syscall(SEM_WAIT,id);
    800014d4:	02300513          	li	a0,35
    800014d8:	00002097          	auipc	ra,0x2
    800014dc:	fd0080e7          	jalr	-48(ra) # 800034a8 <_Z12kern_syscall13SyscallNumberz>
    __asm__ volatile ("mv %[a0], a0" : [a0] "=r"(a0));
    800014e0:	00050793          	mv	a5,a0
    800014e4:	fef43423          	sd	a5,-24(s0)
    return a0;
    800014e8:	fe843503          	ld	a0,-24(s0)
    int res = r_a0();
    return res;
}
    800014ec:	0005051b          	sext.w	a0,a0
    800014f0:	01813083          	ld	ra,24(sp)
    800014f4:	01013403          	ld	s0,16(sp)
    800014f8:	02010113          	addi	sp,sp,32
    800014fc:	00008067          	ret

0000000080001500 <_Z10sem_signalP5sem_s>:

int sem_signal (sem_t id){
    80001500:	fe010113          	addi	sp,sp,-32
    80001504:	00113c23          	sd	ra,24(sp)
    80001508:	00813823          	sd	s0,16(sp)
    8000150c:	02010413          	addi	s0,sp,32
    80001510:	00050593          	mv	a1,a0
    kern_syscall(SEM_SIGNAL,id);
    80001514:	02400513          	li	a0,36
    80001518:	00002097          	auipc	ra,0x2
    8000151c:	f90080e7          	jalr	-112(ra) # 800034a8 <_Z12kern_syscall13SyscallNumberz>
    __asm__ volatile ("mv %[a0], a0" : [a0] "=r"(a0));
    80001520:	00050793          	mv	a5,a0
    80001524:	fef43423          	sd	a5,-24(s0)
    return a0;
    80001528:	fe843503          	ld	a0,-24(s0)
    int res = r_a0();
    return res;
}
    8000152c:	0005051b          	sext.w	a0,a0
    80001530:	01813083          	ld	ra,24(sp)
    80001534:	01013403          	ld	s0,16(sp)
    80001538:	02010113          	addi	sp,sp,32
    8000153c:	00008067          	ret

0000000080001540 <_Z10time_sleepm>:

int time_sleep(unsigned long time){
    80001540:	ff010113          	addi	sp,sp,-16
    80001544:	00113423          	sd	ra,8(sp)
    80001548:	00813023          	sd	s0,0(sp)
    8000154c:	01010413          	addi	s0,sp,16
    80001550:	00050593          	mv	a1,a0
    kern_syscall(TIME_SLEEP,time);
    80001554:	03100513          	li	a0,49
    80001558:	00002097          	auipc	ra,0x2
    8000155c:	f50080e7          	jalr	-176(ra) # 800034a8 <_Z12kern_syscall13SyscallNumberz>
    return 0;
}
    80001560:	00000513          	li	a0,0
    80001564:	00813083          	ld	ra,8(sp)
    80001568:	00013403          	ld	s0,0(sp)
    8000156c:	01010113          	addi	sp,sp,16
    80001570:	00008067          	ret

0000000080001574 <_Z4getcv>:

#define Reg(reg) ((volatile unsigned char *)(reg))

char getc(){
    80001574:	fe010113          	addi	sp,sp,-32
    80001578:	00113c23          	sd	ra,24(sp)
    8000157c:	00813823          	sd	s0,16(sp)
    80001580:	02010413          	addi	s0,sp,32
    kern_syscall(GETC);
    80001584:	04100513          	li	a0,65
    80001588:	00002097          	auipc	ra,0x2
    8000158c:	f20080e7          	jalr	-224(ra) # 800034a8 <_Z12kern_syscall13SyscallNumberz>
    __asm__ volatile ("mv %[a0], a0" : [a0] "=r"(a0));
    80001590:	00050793          	mv	a5,a0
    80001594:	fef43423          	sd	a5,-24(s0)
    return a0;
    80001598:	fe843503          	ld	a0,-24(s0)
    char c = r_a0();
    return c;
}
    8000159c:	0ff57513          	andi	a0,a0,255
    800015a0:	01813083          	ld	ra,24(sp)
    800015a4:	01013403          	ld	s0,16(sp)
    800015a8:	02010113          	addi	sp,sp,32
    800015ac:	00008067          	ret

00000000800015b0 <_Z4putcc>:


void putc(char c){
    800015b0:	ff010113          	addi	sp,sp,-16
    800015b4:	00113423          	sd	ra,8(sp)
    800015b8:	00813023          	sd	s0,0(sp)
    800015bc:	01010413          	addi	s0,sp,16
    800015c0:	00050593          	mv	a1,a0
    kern_syscall(PUTC,c);
    800015c4:	04200513          	li	a0,66
    800015c8:	00002097          	auipc	ra,0x2
    800015cc:	ee0080e7          	jalr	-288(ra) # 800034a8 <_Z12kern_syscall13SyscallNumberz>
}
    800015d0:	00813083          	ld	ra,8(sp)
    800015d4:	00013403          	ld	s0,0(sp)
    800015d8:	01010113          	addi	sp,sp,16
    800015dc:	00008067          	ret

00000000800015e0 <_Z26bba_print_used_blocks_infov>:
char* buddyMemStart;
char* buddyMemEnd;


void bba_print_used_blocks_info()
{
    800015e0:	fe010113          	addi	sp,sp,-32
    800015e4:	00113c23          	sd	ra,24(sp)
    800015e8:	00813823          	sd	s0,16(sp)
    800015ec:	00913423          	sd	s1,8(sp)
    800015f0:	02010413          	addi	s0,sp,32
    bba_block_t * curr = bba_allocatedBlocks;
    800015f4:	0000b497          	auipc	s1,0xb
    800015f8:	5cc4b483          	ld	s1,1484(s1) # 8000cbc0 <bba_allocatedBlocks>
    while (curr){
    800015fc:	04048263          	beqz	s1,80001640 <_Z26bba_print_used_blocks_infov+0x60>
        printf("\nBlock of size %d is allocated on addr start+%lx and its descriptor is located at start+%lx (%lx), ends at start+%lx", curr->n, curr->addr-buddyMemStart, (char*)curr-buddyMemStart,curr,curr->addr-buddyMemStart+(1<<curr->n));
    80001600:	0084a583          	lw	a1,8(s1)
    80001604:	0104b603          	ld	a2,16(s1)
    80001608:	0000b697          	auipc	a3,0xb
    8000160c:	5c06b683          	ld	a3,1472(a3) # 8000cbc8 <buddyMemStart>
    80001610:	40d60633          	sub	a2,a2,a3
    80001614:	00100793          	li	a5,1
    80001618:	00b797bb          	sllw	a5,a5,a1
    8000161c:	00f607b3          	add	a5,a2,a5
    80001620:	00048713          	mv	a4,s1
    80001624:	40d486b3          	sub	a3,s1,a3
    80001628:	00009517          	auipc	a0,0x9
    8000162c:	9f850513          	addi	a0,a0,-1544 # 8000a020 <CONSOLE_STATUS+0x10>
    80001630:	00001097          	auipc	ra,0x1
    80001634:	c64080e7          	jalr	-924(ra) # 80002294 <_Z6printfPKcz>
        curr=curr->next;
    80001638:	0004b483          	ld	s1,0(s1)
    while (curr){
    8000163c:	fc1ff06f          	j	800015fc <_Z26bba_print_used_blocks_infov+0x1c>
    }
}
    80001640:	01813083          	ld	ra,24(sp)
    80001644:	01013403          	ld	s0,16(sp)
    80001648:	00813483          	ld	s1,8(sp)
    8000164c:	02010113          	addi	sp,sp,32
    80001650:	00008067          	ret

0000000080001654 <_Z26bba_print_free_blocks_infov>:

void bba_print_free_blocks_info()
{
    80001654:	fe010113          	addi	sp,sp,-32
    80001658:	00113c23          	sd	ra,24(sp)
    8000165c:	00813823          	sd	s0,16(sp)
    80001660:	00913423          	sd	s1,8(sp)
    80001664:	01213023          	sd	s2,0(sp)
    80001668:	02010413          	addi	s0,sp,32
    printf("\n BLOCK INFO");
    8000166c:	00009517          	auipc	a0,0x9
    80001670:	a2c50513          	addi	a0,a0,-1492 # 8000a098 <CONSOLE_STATUS+0x88>
    80001674:	00001097          	auipc	ra,0x1
    80001678:	c20080e7          	jalr	-992(ra) # 80002294 <_Z6printfPKcz>
    for (int i=0;i<18;i++){
    8000167c:	00000913          	li	s2,0
    80001680:	0400006f          	j	800016c0 <_Z26bba_print_free_blocks_infov+0x6c>
        bba_block_t* p = buddyBlocks[i];
        while (p!=0){
            printf("\n block of size %d (n=%d) at address start+%p (%p), ends at start+%p",(1<<i), i, (char*)p-buddyMemStart,p,(char*)p-buddyMemStart+(1<<i));
    80001684:	00100593          	li	a1,1
    80001688:	012595bb          	sllw	a1,a1,s2
    8000168c:	0000b697          	auipc	a3,0xb
    80001690:	53c6b683          	ld	a3,1340(a3) # 8000cbc8 <buddyMemStart>
    80001694:	40d486b3          	sub	a3,s1,a3
    80001698:	00b687b3          	add	a5,a3,a1
    8000169c:	00048713          	mv	a4,s1
    800016a0:	00090613          	mv	a2,s2
    800016a4:	00009517          	auipc	a0,0x9
    800016a8:	a0450513          	addi	a0,a0,-1532 # 8000a0a8 <CONSOLE_STATUS+0x98>
    800016ac:	00001097          	auipc	ra,0x1
    800016b0:	be8080e7          	jalr	-1048(ra) # 80002294 <_Z6printfPKcz>
            p=p->next;
    800016b4:	0004b483          	ld	s1,0(s1)
        while (p!=0){
    800016b8:	fc0496e3          	bnez	s1,80001684 <_Z26bba_print_free_blocks_infov+0x30>
    for (int i=0;i<18;i++){
    800016bc:	0019091b          	addiw	s2,s2,1
    800016c0:	01100793          	li	a5,17
    800016c4:	0127ce63          	blt	a5,s2,800016e0 <_Z26bba_print_free_blocks_infov+0x8c>
        bba_block_t* p = buddyBlocks[i];
    800016c8:	00391713          	slli	a4,s2,0x3
    800016cc:	0000b797          	auipc	a5,0xb
    800016d0:	4f478793          	addi	a5,a5,1268 # 8000cbc0 <bba_allocatedBlocks>
    800016d4:	00e787b3          	add	a5,a5,a4
    800016d8:	0107b483          	ld	s1,16(a5)
    800016dc:	fddff06f          	j	800016b8 <_Z26bba_print_free_blocks_infov+0x64>
        }
    }
}
    800016e0:	01813083          	ld	ra,24(sp)
    800016e4:	01013403          	ld	s0,16(sp)
    800016e8:	00813483          	ld	s1,8(sp)
    800016ec:	00013903          	ld	s2,0(sp)
    800016f0:	02010113          	addi	sp,sp,32
    800016f4:	00008067          	ret

00000000800016f8 <_Z8bba_initPcS_>:
void bba_init(char* start, char *end)
{
    800016f8:	fe010113          	addi	sp,sp,-32
    800016fc:	00113c23          	sd	ra,24(sp)
    80001700:	00813823          	sd	s0,16(sp)
    80001704:	00913423          	sd	s1,8(sp)
    80001708:	01213023          	sd	s2,0(sp)
    8000170c:	02010413          	addi	s0,sp,32
    80001710:	00050493          	mv	s1,a0
    80001714:	00058913          	mv	s2,a1

    //printf("\noldStart: %ld", (long)start);
    if((long)start%MINBBSIZE!=0) start = (char*) (( ((long)start / MINBBSIZE) +1)*MINBBSIZE); //align start to MINBBSIZE
    80001718:	01f57793          	andi	a5,a0,31
    8000171c:	00078e63          	beqz	a5,80001738 <_Z8bba_initPcS_+0x40>
    80001720:	43f55793          	srai	a5,a0,0x3f
    80001724:	01f7f793          	andi	a5,a5,31
    80001728:	00f504b3          	add	s1,a0,a5
    8000172c:	4054d493          	srai	s1,s1,0x5
    80001730:	00148493          	addi	s1,s1,1
    80001734:	00549493          	slli	s1,s1,0x5
    if((long)end%MINBBSIZE!=0) end = (char*) (( ((long)end / MINBBSIZE) -1)*MINBBSIZE); //align end to MINBBSIZE
    80001738:	01f97793          	andi	a5,s2,31
    8000173c:	00078e63          	beqz	a5,80001758 <_Z8bba_initPcS_+0x60>
    80001740:	43f95793          	srai	a5,s2,0x3f
    80001744:	01f7f793          	andi	a5,a5,31
    80001748:	00f90933          	add	s2,s2,a5
    8000174c:	40595913          	srai	s2,s2,0x5
    80001750:	fff90913          	addi	s2,s2,-1
    80001754:	00591913          	slli	s2,s2,0x5
    //printf("\nstart: %ld", (long)start);
    //printf("\nend: %ld", (long)end);
    buddyMemStart=start;
    80001758:	0000b797          	auipc	a5,0xb
    8000175c:	46878793          	addi	a5,a5,1128 # 8000cbc0 <bba_allocatedBlocks>
    80001760:	0097b423          	sd	s1,8(a5)
    buddyMemEnd=end;
    80001764:	0b27b023          	sd	s2,160(a5)

    printf("\nspace size=%d", end-start);
    80001768:	409905b3          	sub	a1,s2,s1
    8000176c:	00009517          	auipc	a0,0x9
    80001770:	98450513          	addi	a0,a0,-1660 # 8000a0f0 <CONSOLE_STATUS+0xe0>
    80001774:	00001097          	auipc	ra,0x1
    80001778:	b20080e7          	jalr	-1248(ra) # 80002294 <_Z6printfPKcz>

    for(int i=0;i<17;i++){
    8000177c:	00000793          	li	a5,0
    80001780:	01000713          	li	a4,16
    80001784:	02f74063          	blt	a4,a5,800017a4 <_Z8bba_initPcS_+0xac>
        buddyBlocks[i] = 0;
    80001788:	00379693          	slli	a3,a5,0x3
    8000178c:	0000b717          	auipc	a4,0xb
    80001790:	43470713          	addi	a4,a4,1076 # 8000cbc0 <bba_allocatedBlocks>
    80001794:	00d70733          	add	a4,a4,a3
    80001798:	00073823          	sd	zero,16(a4)
    for(int i=0;i<17;i++){
    8000179c:	0017879b          	addiw	a5,a5,1
    800017a0:	fe1ff06f          	j	80001780 <_Z8bba_initPcS_+0x88>
    }

    char* a = start;

    int allocatedSize = 0;
    800017a4:	00000593          	li	a1,0
    800017a8:	05c0006f          	j	80001804 <_Z8bba_initPcS_+0x10c>
    while(a<end){
        //printf("\n a=%ld",(long)a);
        int n=5;
        while(a+(1<<n)<=end && n<18) n++; // maximum block size is 2^17
    800017ac:	0017071b          	addiw	a4,a4,1
    800017b0:	00100793          	li	a5,1
    800017b4:	00e797bb          	sllw	a5,a5,a4
    800017b8:	00f487b3          	add	a5,s1,a5
    800017bc:	00f96663          	bltu	s2,a5,800017c8 <_Z8bba_initPcS_+0xd0>
    800017c0:	01100793          	li	a5,17
    800017c4:	fee7d4e3          	bge	a5,a4,800017ac <_Z8bba_initPcS_+0xb4>
        n--;
    800017c8:	fff7071b          	addiw	a4,a4,-1
    800017cc:	0007069b          	sext.w	a3,a4

        bba_block_t *newBlock = (bba_block_t*) a;
        newBlock->n=n;
    800017d0:	00e4a423          	sw	a4,8(s1)
        newBlock->next=buddyBlocks[n];
    800017d4:	00369793          	slli	a5,a3,0x3
    800017d8:	0000b717          	auipc	a4,0xb
    800017dc:	3e870713          	addi	a4,a4,1000 # 8000cbc0 <bba_allocatedBlocks>
    800017e0:	00f70733          	add	a4,a4,a5
    800017e4:	01073783          	ld	a5,16(a4)
    800017e8:	00f4b023          	sd	a5,0(s1)
        buddyBlocks[n] = newBlock; //ulancavamo novi blok na pocetak liste
    800017ec:	00973823          	sd	s1,16(a4)

        //printf("\n n=%d, block of size %ld allocated at %ld",n,(1<<n), (long)a);
        allocatedSize+=(1<<n);
    800017f0:	00100793          	li	a5,1
    800017f4:	00d797bb          	sllw	a5,a5,a3
    800017f8:	0007871b          	sext.w	a4,a5
    800017fc:	00b785bb          	addw	a1,a5,a1
        a+=(1<<n);
    80001800:	00e484b3          	add	s1,s1,a4
    while(a<end){
    80001804:	0124f663          	bgeu	s1,s2,80001810 <_Z8bba_initPcS_+0x118>
        int n=5;
    80001808:	00500713          	li	a4,5
    8000180c:	fa5ff06f          	j	800017b0 <_Z8bba_initPcS_+0xb8>
    }


    printf("\nallocatedSize=%d\n",allocatedSize);
    80001810:	00009517          	auipc	a0,0x9
    80001814:	8f050513          	addi	a0,a0,-1808 # 8000a100 <CONSOLE_STATUS+0xf0>
    80001818:	00001097          	auipc	ra,0x1
    8000181c:	a7c080e7          	jalr	-1412(ra) # 80002294 <_Z6printfPKcz>
    //bba_print_free_blocks_info();
}
    80001820:	01813083          	ld	ra,24(sp)
    80001824:	01013403          	ld	s0,16(sp)
    80001828:	00813483          	ld	s1,8(sp)
    8000182c:	00013903          	ld	s2,0(sp)
    80001830:	02010113          	addi	sp,sp,32
    80001834:	00008067          	ret

0000000080001838 <_Z9bba_spliti>:

void bba_split(int n) //blok velicine n deli na 2 velicine n-1, ne alocira nista, ulancava oba nova bloka
{
    if(n==0) return;
    80001838:	0a050063          	beqz	a0,800018d8 <_Z9bba_spliti+0xa0>
    bba_block_t* addr = buddyBlocks[n];
    8000183c:	00351713          	slli	a4,a0,0x3
    80001840:	0000b797          	auipc	a5,0xb
    80001844:	38078793          	addi	a5,a5,896 # 8000cbc0 <bba_allocatedBlocks>
    80001848:	00e787b3          	add	a5,a5,a4
    8000184c:	0107b703          	ld	a4,16(a5)
    if(addr==0){
    80001850:	04070a63          	beqz	a4,800018a4 <_Z9bba_spliti+0x6c>
        printf("\ncant split block of size %d, there are no blocks of that size",n);
        return;
    }
    //printf("\nsplitting block of size %d into two smaller blocks...",n);
    buddyBlocks[n] = addr->next; //izbacujemo
    80001854:	00073603          	ld	a2,0(a4)
    80001858:	0000b697          	auipc	a3,0xb
    8000185c:	36868693          	addi	a3,a3,872 # 8000cbc0 <bba_allocatedBlocks>
    80001860:	00351793          	slli	a5,a0,0x3
    80001864:	00f687b3          	add	a5,a3,a5
    80001868:	00c7b823          	sd	a2,16(a5)
    bba_block_t* half = (bba_block_t*) ((long )addr+(1<<(n-1))); //polovina starog bloka
    8000186c:	fff5051b          	addiw	a0,a0,-1
    80001870:	0005061b          	sext.w	a2,a0
    80001874:	00100793          	li	a5,1
    80001878:	00a797bb          	sllw	a5,a5,a0
    8000187c:	00f707b3          	add	a5,a4,a5
    half->n=n-1;
    80001880:	00a7a423          	sw	a0,8(a5)
    addr->n=n-1;
    80001884:	00a72423          	sw	a0,8(a4)
    half->next=buddyBlocks[n-1];
    80001888:	00361613          	slli	a2,a2,0x3
    8000188c:	00c686b3          	add	a3,a3,a2
    80001890:	0106b603          	ld	a2,16(a3)
    80001894:	00c7b023          	sd	a2,0(a5)
    addr->next=half;
    80001898:	00f73023          	sd	a5,0(a4)
    buddyBlocks[n-1]=addr;
    8000189c:	00e6b823          	sd	a4,16(a3)
    800018a0:	00008067          	ret
{
    800018a4:	ff010113          	addi	sp,sp,-16
    800018a8:	00113423          	sd	ra,8(sp)
    800018ac:	00813023          	sd	s0,0(sp)
    800018b0:	01010413          	addi	s0,sp,16
        printf("\ncant split block of size %d, there are no blocks of that size",n);
    800018b4:	00050593          	mv	a1,a0
    800018b8:	00009517          	auipc	a0,0x9
    800018bc:	86050513          	addi	a0,a0,-1952 # 8000a118 <CONSOLE_STATUS+0x108>
    800018c0:	00001097          	auipc	ra,0x1
    800018c4:	9d4080e7          	jalr	-1580(ra) # 80002294 <_Z6printfPKcz>
}
    800018c8:	00813083          	ld	ra,8(sp)
    800018cc:	00013403          	ld	s0,0(sp)
    800018d0:	01010113          	addi	sp,sp,16
    800018d4:	00008067          	ret
    800018d8:	00008067          	ret

00000000800018dc <_Z13bba_get_blocki>:

//nalazi ili kreira i vraca blok velicine 2^n
bba_block_t * bba_get_block(int size)
{
    if(size<MINBBSIZE) size=MINBBSIZE;
    800018dc:	01f00793          	li	a5,31
    800018e0:	00a7da63          	bge	a5,a0,800018f4 <_Z13bba_get_blocki+0x18>
    if(size>MAXBBSIZE) return 0;
    800018e4:	000207b7          	lui	a5,0x20
    800018e8:	00a7d863          	bge	a5,a0,800018f8 <_Z13bba_get_blocki+0x1c>
    800018ec:	00000513          	li	a0,0
            return buddyBlocks[n];
        }
    }

    return 0;
}
    800018f0:	00008067          	ret
    if(size<MINBBSIZE) size=MINBBSIZE;
    800018f4:	02000513          	li	a0,32
{
    800018f8:	fe010113          	addi	sp,sp,-32
    800018fc:	00113c23          	sd	ra,24(sp)
    80001900:	00813823          	sd	s0,16(sp)
    80001904:	00913423          	sd	s1,8(sp)
    80001908:	01213023          	sd	s2,0(sp)
    8000190c:	02010413          	addi	s0,sp,32
    if(size<MINBBSIZE) size=MINBBSIZE;
    80001910:	00500493          	li	s1,5
    80001914:	0080006f          	j	8000191c <_Z13bba_get_blocki+0x40>
    while((1<<n)<size && n<18) n++;
    80001918:	0014849b          	addiw	s1,s1,1
    8000191c:	00100793          	li	a5,1
    80001920:	009797bb          	sllw	a5,a5,s1
    80001924:	00a7d663          	bge	a5,a0,80001930 <_Z13bba_get_blocki+0x54>
    80001928:	01100793          	li	a5,17
    8000192c:	fe97d6e3          	bge	a5,s1,80001918 <_Z13bba_get_blocki+0x3c>
    if(buddyBlocks[n]!=0){ //imamo blok tacno te velicine
    80001930:	00349713          	slli	a4,s1,0x3
    80001934:	0000b797          	auipc	a5,0xb
    80001938:	28c78793          	addi	a5,a5,652 # 8000cbc0 <bba_allocatedBlocks>
    8000193c:	00e787b3          	add	a5,a5,a4
    80001940:	0107b503          	ld	a0,16(a5)
    80001944:	00050e63          	beqz	a0,80001960 <_Z13bba_get_blocki+0x84>
}
    80001948:	01813083          	ld	ra,24(sp)
    8000194c:	01013403          	ld	s0,16(sp)
    80001950:	00813483          	ld	s1,8(sp)
    80001954:	00013903          	ld	s2,0(sp)
    80001958:	02010113          	addi	sp,sp,32
    8000195c:	00008067          	ret
    for(int i=n+1;i<18;i++){
    80001960:	0014891b          	addiw	s2,s1,1
    80001964:	01100793          	li	a5,17
    80001968:	ff27c0e3          	blt	a5,s2,80001948 <_Z13bba_get_blocki+0x6c>
        if(buddyBlocks[i]!=0){
    8000196c:	00391713          	slli	a4,s2,0x3
    80001970:	0000b797          	auipc	a5,0xb
    80001974:	25078793          	addi	a5,a5,592 # 8000cbc0 <bba_allocatedBlocks>
    80001978:	00e787b3          	add	a5,a5,a4
    8000197c:	0107b783          	ld	a5,16(a5)
    80001980:	00079663          	bnez	a5,8000198c <_Z13bba_get_blocki+0xb0>
    for(int i=n+1;i<18;i++){
    80001984:	0019091b          	addiw	s2,s2,1
    80001988:	fddff06f          	j	80001964 <_Z13bba_get_blocki+0x88>
            while(i>n){
    8000198c:	0124dc63          	bge	s1,s2,800019a4 <_Z13bba_get_blocki+0xc8>
                bba_split(i);
    80001990:	00090513          	mv	a0,s2
    80001994:	00000097          	auipc	ra,0x0
    80001998:	ea4080e7          	jalr	-348(ra) # 80001838 <_Z9bba_spliti>
                i--;
    8000199c:	fff9091b          	addiw	s2,s2,-1
            while(i>n){
    800019a0:	fedff06f          	j	8000198c <_Z13bba_get_blocki+0xb0>
            return buddyBlocks[n];
    800019a4:	00349493          	slli	s1,s1,0x3
    800019a8:	0000b797          	auipc	a5,0xb
    800019ac:	21878793          	addi	a5,a5,536 # 8000cbc0 <bba_allocatedBlocks>
    800019b0:	009784b3          	add	s1,a5,s1
    800019b4:	0104b503          	ld	a0,16(s1)
    800019b8:	f91ff06f          	j	80001948 <_Z13bba_get_blocki+0x6c>

00000000800019bc <_Z16bba_can_allocatei>:
int bba_can_allocate(int n)
{
    int index=0;

    //mozemo li smestiti blok
    for(int i=n;i<18;i++){
    800019bc:	00050793          	mv	a5,a0
    800019c0:	01100713          	li	a4,17
    800019c4:	02f74863          	blt	a4,a5,800019f4 <_Z16bba_can_allocatei+0x38>
        if(buddyBlocks[i]!=0) {
    800019c8:	00379693          	slli	a3,a5,0x3
    800019cc:	0000b717          	auipc	a4,0xb
    800019d0:	1f470713          	addi	a4,a4,500 # 8000cbc0 <bba_allocatedBlocks>
    800019d4:	00d70733          	add	a4,a4,a3
    800019d8:	01073703          	ld	a4,16(a4)
    800019dc:	00071663          	bnez	a4,800019e8 <_Z16bba_can_allocatei+0x2c>
    for(int i=n;i<18;i++){
    800019e0:	0017879b          	addiw	a5,a5,1
    800019e4:	fddff06f          	j	800019c0 <_Z16bba_can_allocatei+0x4>
            if(i>n) return 1;
    800019e8:	00f55863          	bge	a0,a5,800019f8 <_Z16bba_can_allocatei+0x3c>
    800019ec:	00100513          	li	a0,1
    800019f0:	00008067          	ret
    int index=0;
    800019f4:	00000793          	li	a5,0
        }
    }

    //za svakio alocirani blok pravimo i jedan mali blok (deskriptor) sa metapodacima - ovde proveravamo da li imamo
    // mesta i za taj mali blok
    for(int i=5;i<18;i++){
    800019f8:	00500713          	li	a4,5
    800019fc:	0080006f          	j	80001a04 <_Z16bba_can_allocatei+0x48>
    80001a00:	0017071b          	addiw	a4,a4,1
    80001a04:	01100693          	li	a3,17
    80001a08:	02e6c863          	blt	a3,a4,80001a38 <_Z16bba_can_allocatei+0x7c>
        if(buddyBlocks[i]!=0){
    80001a0c:	00371613          	slli	a2,a4,0x3
    80001a10:	0000b697          	auipc	a3,0xb
    80001a14:	1b068693          	addi	a3,a3,432 # 8000cbc0 <bba_allocatedBlocks>
    80001a18:	00c686b3          	add	a3,a3,a2
    80001a1c:	0106b683          	ld	a3,16(a3)
    80001a20:	fe0680e3          	beqz	a3,80001a00 <_Z16bba_can_allocatei+0x44>
            if(i!=index || buddyBlocks[i]->next!=0) return 1;
    80001a24:	04e79463          	bne	a5,a4,80001a6c <_Z16bba_can_allocatei+0xb0>
    80001a28:	0006b683          	ld	a3,0(a3)
    80001a2c:	fc068ae3          	beqz	a3,80001a00 <_Z16bba_can_allocatei+0x44>
    80001a30:	00100513          	li	a0,1
        }
    }

    printf("\n alloc error - cant allocate");
    return 0;
}
    80001a34:	00008067          	ret
{
    80001a38:	ff010113          	addi	sp,sp,-16
    80001a3c:	00113423          	sd	ra,8(sp)
    80001a40:	00813023          	sd	s0,0(sp)
    80001a44:	01010413          	addi	s0,sp,16
    printf("\n alloc error - cant allocate");
    80001a48:	00008517          	auipc	a0,0x8
    80001a4c:	71050513          	addi	a0,a0,1808 # 8000a158 <CONSOLE_STATUS+0x148>
    80001a50:	00001097          	auipc	ra,0x1
    80001a54:	844080e7          	jalr	-1980(ra) # 80002294 <_Z6printfPKcz>
    return 0;
    80001a58:	00000513          	li	a0,0
}
    80001a5c:	00813083          	ld	ra,8(sp)
    80001a60:	00013403          	ld	s0,0(sp)
    80001a64:	01010113          	addi	sp,sp,16
    80001a68:	00008067          	ret
            if(i!=index || buddyBlocks[i]->next!=0) return 1;
    80001a6c:	00100513          	li	a0,1
    80001a70:	00008067          	ret

0000000080001a74 <_Z12bba_allocatem>:

void* bba_allocate(unsigned long size)
{
    80001a74:	fd010113          	addi	sp,sp,-48
    80001a78:	02113423          	sd	ra,40(sp)
    80001a7c:	02813023          	sd	s0,32(sp)
    80001a80:	00913c23          	sd	s1,24(sp)
    80001a84:	01213823          	sd	s2,16(sp)
    80001a88:	01313423          	sd	s3,8(sp)
    80001a8c:	03010413          	addi	s0,sp,48

    if(size<MINBBSIZE) size=MINBBSIZE;
    80001a90:	01f00793          	li	a5,31
    80001a94:	00a7fc63          	bgeu	a5,a0,80001aac <_Z12bba_allocatem+0x38>
    80001a98:	00050913          	mv	s2,a0
    if(size>MAXBBSIZE) return 0;
    80001a9c:	000207b7          	lui	a5,0x20
    80001aa0:	00a7f863          	bgeu	a5,a0,80001ab0 <_Z12bba_allocatem+0x3c>
    80001aa4:	00000913          	li	s2,0
    80001aa8:	0880006f          	j	80001b30 <_Z12bba_allocatem+0xbc>
    if(size<MINBBSIZE) size=MINBBSIZE;
    80001aac:	02000913          	li	s2,32
    80001ab0:	00500493          	li	s1,5
    80001ab4:	0080006f          	j	80001abc <_Z12bba_allocatem+0x48>
    int n=5;
    while((1UL<<n)<size && n<18) n++;
    80001ab8:	0014849b          	addiw	s1,s1,1
    80001abc:	00100793          	li	a5,1
    80001ac0:	009797b3          	sll	a5,a5,s1
    80001ac4:	0127f663          	bgeu	a5,s2,80001ad0 <_Z12bba_allocatem+0x5c>
    80001ac8:	01100793          	li	a5,17
    80001acc:	fe97d6e3          	bge	a5,s1,80001ab8 <_Z12bba_allocatem+0x44>


    if(bba_can_allocate(n)==0) return 0;
    80001ad0:	00048513          	mv	a0,s1
    80001ad4:	00000097          	auipc	ra,0x0
    80001ad8:	ee8080e7          	jalr	-280(ra) # 800019bc <_Z16bba_can_allocatei>
    80001adc:	06050a63          	beqz	a0,80001b50 <_Z12bba_allocatem+0xdc>

    bba_block_t *newBlock=0;
    bba_block_t *descriptor=0;

    newBlock = bba_get_block(size);
    80001ae0:	0009051b          	sext.w	a0,s2
    80001ae4:	00000097          	auipc	ra,0x0
    80001ae8:	df8080e7          	jalr	-520(ra) # 800018dc <_Z13bba_get_blocki>
    80001aec:	00050913          	mv	s2,a0
    buddyBlocks[n] = newBlock->next;
    80001af0:	00053703          	ld	a4,0(a0)
    80001af4:	0000b997          	auipc	s3,0xb
    80001af8:	0cc98993          	addi	s3,s3,204 # 8000cbc0 <bba_allocatedBlocks>
    80001afc:	00349793          	slli	a5,s1,0x3
    80001b00:	00f987b3          	add	a5,s3,a5
    80001b04:	00e7b823          	sd	a4,16(a5) # 20010 <_entry-0x7ffdfff0>

    descriptor = bba_get_block(sizeof(bba_block_t));
    80001b08:	01800513          	li	a0,24
    80001b0c:	00000097          	auipc	ra,0x0
    80001b10:	dd0080e7          	jalr	-560(ra) # 800018dc <_Z13bba_get_blocki>
    buddyBlocks[5] = descriptor->next;
    80001b14:	00053783          	ld	a5,0(a0)
    80001b18:	02f9bc23          	sd	a5,56(s3)


    //ulancavamo deskriptor
    descriptor->next=bba_allocatedBlocks;
    80001b1c:	0009b783          	ld	a5,0(s3)
    80001b20:	00f53023          	sd	a5,0(a0)
    bba_allocatedBlocks=descriptor;
    80001b24:	00a9b023          	sd	a0,0(s3)
    descriptor->n=n;
    80001b28:	00952423          	sw	s1,8(a0)
    descriptor->addr=(char*)newBlock;
    80001b2c:	01253823          	sd	s2,16(a0)

    return newBlock;

}
    80001b30:	00090513          	mv	a0,s2
    80001b34:	02813083          	ld	ra,40(sp)
    80001b38:	02013403          	ld	s0,32(sp)
    80001b3c:	01813483          	ld	s1,24(sp)
    80001b40:	01013903          	ld	s2,16(sp)
    80001b44:	00813983          	ld	s3,8(sp)
    80001b48:	03010113          	addi	sp,sp,48
    80001b4c:	00008067          	ret
    if(bba_can_allocate(n)==0) return 0;
    80001b50:	00000913          	li	s2,0
    80001b54:	fddff06f          	j	80001b30 <_Z12bba_allocatem+0xbc>

0000000080001b58 <_Z26bba_try_merge_single_blockP9bba_blocki>:

/*
 * ako moze da spoji, izlancava ukrupnjeni blok (prosledjeni blok nije ni bio ulancan ) i vraca adresu ukrupnjenog bloka, ako ne moze vraca null
 */
bba_block_t * bba_try_merge_single_block(bba_block_t* freedBlock, int n)
{
    80001b58:	ff010113          	addi	sp,sp,-16
    80001b5c:	00813423          	sd	s0,8(sp)
    80001b60:	01010413          	addi	s0,sp,16
    80001b64:	00050693          	mv	a3,a0
    long size = (1<<n);
    80001b68:	00100613          	li	a2,1
    80001b6c:	00b6163b          	sllw	a2,a2,a1
    bba_block_t *curr = buddyBlocks[n];
    80001b70:	0000b717          	auipc	a4,0xb
    80001b74:	05070713          	addi	a4,a4,80 # 8000cbc0 <bba_allocatedBlocks>
    80001b78:	00359793          	slli	a5,a1,0x3
    80001b7c:	00f707b3          	add	a5,a4,a5
    80001b80:	0107b503          	ld	a0,16(a5)
    bba_block_t *prev=0;

    int odd = (((char*)freedBlock-buddyMemStart)/size)%2;
    80001b84:	00873703          	ld	a4,8(a4)
    80001b88:	40e68733          	sub	a4,a3,a4
    80001b8c:	02c74733          	div	a4,a4,a2
    80001b90:	03f75813          	srli	a6,a4,0x3f
    80001b94:	010707b3          	add	a5,a4,a6
    80001b98:	0017f793          	andi	a5,a5,1
    80001b9c:	410787b3          	sub	a5,a5,a6
    bba_block_t *prev=0;
    80001ba0:	00000813          	li	a6,0
    80001ba4:	05c0006f          	j	80001c00 <_Z26bba_try_merge_single_blockP9bba_blocki+0xa8>

    while (curr!=0){
        if(odd==1 && (long)curr+size==(long)freedBlock){
    80001ba8:	00c50733          	add	a4,a0,a2
    80001bac:	06d71063          	bne	a4,a3,80001c0c <_Z26bba_try_merge_single_blockP9bba_blocki+0xb4>
            if(prev!=0) prev->next=curr->next;
    80001bb0:	00080863          	beqz	a6,80001bc0 <_Z26bba_try_merge_single_blockP9bba_blocki+0x68>
    80001bb4:	00053783          	ld	a5,0(a0)
    80001bb8:	00f83023          	sd	a5,0(a6)
    80001bbc:	06c0006f          	j	80001c28 <_Z26bba_try_merge_single_blockP9bba_blocki+0xd0>
            else buddyBlocks[n]=curr->next;
    80001bc0:	00053703          	ld	a4,0(a0)
    80001bc4:	00359593          	slli	a1,a1,0x3
    80001bc8:	0000b797          	auipc	a5,0xb
    80001bcc:	ff878793          	addi	a5,a5,-8 # 8000cbc0 <bba_allocatedBlocks>
    80001bd0:	00b785b3          	add	a1,a5,a1
    80001bd4:	00e5b823          	sd	a4,16(a1)
            return curr;
    80001bd8:	0500006f          	j	80001c28 <_Z26bba_try_merge_single_blockP9bba_blocki+0xd0>
        }
        if(odd==0 && (long)curr-size==(long)freedBlock){
            if(prev!=0) prev->next=curr->next;
            else buddyBlocks[n]=curr->next;
    80001bdc:	00053703          	ld	a4,0(a0)
    80001be0:	00359593          	slli	a1,a1,0x3
    80001be4:	0000b797          	auipc	a5,0xb
    80001be8:	fdc78793          	addi	a5,a5,-36 # 8000cbc0 <bba_allocatedBlocks>
    80001bec:	00b785b3          	add	a1,a5,a1
    80001bf0:	00e5b823          	sd	a4,16(a1)
    80001bf4:	0300006f          	j	80001c24 <_Z26bba_try_merge_single_blockP9bba_blocki+0xcc>
            return freedBlock;
        }
        prev=curr;
    80001bf8:	00050813          	mv	a6,a0
        curr=curr->next;
    80001bfc:	00053503          	ld	a0,0(a0)
    while (curr!=0){
    80001c00:	02050463          	beqz	a0,80001c28 <_Z26bba_try_merge_single_blockP9bba_blocki+0xd0>
        if(odd==1 && (long)curr+size==(long)freedBlock){
    80001c04:	00100713          	li	a4,1
    80001c08:	fae780e3          	beq	a5,a4,80001ba8 <_Z26bba_try_merge_single_blockP9bba_blocki+0x50>
        if(odd==0 && (long)curr-size==(long)freedBlock){
    80001c0c:	fe0796e3          	bnez	a5,80001bf8 <_Z26bba_try_merge_single_blockP9bba_blocki+0xa0>
    80001c10:	40c50733          	sub	a4,a0,a2
    80001c14:	fed712e3          	bne	a4,a3,80001bf8 <_Z26bba_try_merge_single_blockP9bba_blocki+0xa0>
            if(prev!=0) prev->next=curr->next;
    80001c18:	fc0802e3          	beqz	a6,80001bdc <_Z26bba_try_merge_single_blockP9bba_blocki+0x84>
    80001c1c:	00053783          	ld	a5,0(a0)
    80001c20:	00f83023          	sd	a5,0(a6)
            return freedBlock;
    80001c24:	00068513          	mv	a0,a3
    }
    return 0;
}
    80001c28:	00813403          	ld	s0,8(sp)
    80001c2c:	01010113          	addi	sp,sp,16
    80001c30:	00008067          	ret

0000000080001c34 <_Z16bba_merge_blocksP9bba_blocki>:

void bba_merge_blocks(bba_block_t* freedBlock, int n)
{
    80001c34:	fe010113          	addi	sp,sp,-32
    80001c38:	00113c23          	sd	ra,24(sp)
    80001c3c:	00813823          	sd	s0,16(sp)
    80001c40:	00913423          	sd	s1,8(sp)
    80001c44:	01213023          	sd	s2,0(sp)
    80001c48:	02010413          	addi	s0,sp,32
    80001c4c:	00050913          	mv	s2,a0
    80001c50:	00058493          	mv	s1,a1
    bba_block_t * mergedBlock = 0;
    while (n<17){
    80001c54:	01000793          	li	a5,16
    80001c58:	0297c263          	blt	a5,s1,80001c7c <_Z16bba_merge_blocksP9bba_blocki+0x48>
        mergedBlock=bba_try_merge_single_block(freedBlock,n);
    80001c5c:	00048593          	mv	a1,s1
    80001c60:	00090513          	mv	a0,s2
    80001c64:	00000097          	auipc	ra,0x0
    80001c68:	ef4080e7          	jalr	-268(ra) # 80001b58 <_Z26bba_try_merge_single_blockP9bba_blocki>
        if(mergedBlock==0){
    80001c6c:	00050863          	beqz	a0,80001c7c <_Z16bba_merge_blocksP9bba_blocki+0x48>
            break;
        }
        n++;
    80001c70:	0014849b          	addiw	s1,s1,1
        freedBlock=mergedBlock;
    80001c74:	00050913          	mv	s2,a0
    while (n<17){
    80001c78:	fddff06f          	j	80001c54 <_Z16bba_merge_blocksP9bba_blocki+0x20>
    }

    freedBlock->n=n;
    80001c7c:	00992423          	sw	s1,8(s2)
    freedBlock->next=buddyBlocks[n];
    80001c80:	00349493          	slli	s1,s1,0x3
    80001c84:	0000b797          	auipc	a5,0xb
    80001c88:	f3c78793          	addi	a5,a5,-196 # 8000cbc0 <bba_allocatedBlocks>
    80001c8c:	009784b3          	add	s1,a5,s1
    80001c90:	0104b783          	ld	a5,16(s1)
    80001c94:	00f93023          	sd	a5,0(s2)
    buddyBlocks[n]=freedBlock;
    80001c98:	0124b823          	sd	s2,16(s1)
}
    80001c9c:	01813083          	ld	ra,24(sp)
    80001ca0:	01013403          	ld	s0,16(sp)
    80001ca4:	00813483          	ld	s1,8(sp)
    80001ca8:	00013903          	ld	s2,0(sp)
    80001cac:	02010113          	addi	sp,sp,32
    80001cb0:	00008067          	ret

0000000080001cb4 <_Z19bba_find_descriptorPKv>:

bba_block_t *bba_find_descriptor(const void*addr)
{
    80001cb4:	ff010113          	addi	sp,sp,-16
    80001cb8:	00813423          	sd	s0,8(sp)
    80001cbc:	01010413          	addi	s0,sp,16
    80001cc0:	00050713          	mv	a4,a0
    bba_block_t *curr = bba_allocatedBlocks;
    80001cc4:	0000b517          	auipc	a0,0xb
    80001cc8:	efc53503          	ld	a0,-260(a0) # 8000cbc0 <bba_allocatedBlocks>
    while (curr){
    80001ccc:	00050a63          	beqz	a0,80001ce0 <_Z19bba_find_descriptorPKv+0x2c>
        if(curr->addr==addr) return curr;
    80001cd0:	01053783          	ld	a5,16(a0)
    80001cd4:	00e78663          	beq	a5,a4,80001ce0 <_Z19bba_find_descriptorPKv+0x2c>
        curr=curr->next;
    80001cd8:	00053503          	ld	a0,0(a0)
    while (curr){
    80001cdc:	ff1ff06f          	j	80001ccc <_Z19bba_find_descriptorPKv+0x18>
    }
    return 0;
}
    80001ce0:	00813403          	ld	s0,8(sp)
    80001ce4:	01010113          	addi	sp,sp,16
    80001ce8:	00008067          	ret

0000000080001cec <_Z21bba_unlink_descriptorP9bba_block>:

void bba_unlink_descriptor(bba_block_t* descriptor){
    80001cec:	ff010113          	addi	sp,sp,-16
    80001cf0:	00813423          	sd	s0,8(sp)
    80001cf4:	01010413          	addi	s0,sp,16
    bba_block_t *curr = bba_allocatedBlocks;
    80001cf8:	0000b797          	auipc	a5,0xb
    80001cfc:	ec87b783          	ld	a5,-312(a5) # 8000cbc0 <bba_allocatedBlocks>
    bba_block_t *prev = 0;
    80001d00:	00000713          	li	a4,0
    while (curr!=descriptor){
    80001d04:	00a78863          	beq	a5,a0,80001d14 <_Z21bba_unlink_descriptorP9bba_block+0x28>
        prev=curr;
    80001d08:	00078713          	mv	a4,a5
        curr=curr->next;
    80001d0c:	0007b783          	ld	a5,0(a5)
    while (curr!=descriptor){
    80001d10:	ff5ff06f          	j	80001d04 <_Z21bba_unlink_descriptorP9bba_block+0x18>
    }
    if(prev!=0){
    80001d14:	00070c63          	beqz	a4,80001d2c <_Z21bba_unlink_descriptorP9bba_block+0x40>
        prev->next=curr->next;
    80001d18:	0007b783          	ld	a5,0(a5)
    80001d1c:	00f73023          	sd	a5,0(a4)
    } else{
        bba_allocatedBlocks=curr->next;
    }
}
    80001d20:	00813403          	ld	s0,8(sp)
    80001d24:	01010113          	addi	sp,sp,16
    80001d28:	00008067          	ret
        bba_allocatedBlocks=curr->next;
    80001d2c:	0007b783          	ld	a5,0(a5)
    80001d30:	0000b717          	auipc	a4,0xb
    80001d34:	e8f73823          	sd	a5,-368(a4) # 8000cbc0 <bba_allocatedBlocks>
}
    80001d38:	fe9ff06f          	j	80001d20 <_Z21bba_unlink_descriptorP9bba_block+0x34>

0000000080001d3c <_Z14bba_free_blockPKv>:

void bba_free_block(const void* addr)
{
    80001d3c:	fe010113          	addi	sp,sp,-32
    80001d40:	00113c23          	sd	ra,24(sp)
    80001d44:	00813823          	sd	s0,16(sp)
    80001d48:	00913423          	sd	s1,8(sp)
    80001d4c:	01213023          	sd	s2,0(sp)
    80001d50:	02010413          	addi	s0,sp,32
    80001d54:	00050913          	mv	s2,a0
    bba_block_t * descriptor = bba_find_descriptor(addr);
    80001d58:	00000097          	auipc	ra,0x0
    80001d5c:	f5c080e7          	jalr	-164(ra) # 80001cb4 <_Z19bba_find_descriptorPKv>
    80001d60:	00050493          	mv	s1,a0
    if(descriptor==0) printf("\nERROR (bba_free_block): Cant find descriptor");
    80001d64:	04050463          	beqz	a0,80001dac <_Z14bba_free_blockPKv+0x70>
    int n = descriptor->n;

    bba_block_t *freedBlock = (bba_block_t*) addr;
    bba_merge_blocks(freedBlock,n);
    80001d68:	0084a583          	lw	a1,8(s1)
    80001d6c:	00090513          	mv	a0,s2
    80001d70:	00000097          	auipc	ra,0x0
    80001d74:	ec4080e7          	jalr	-316(ra) # 80001c34 <_Z16bba_merge_blocksP9bba_blocki>

    bba_unlink_descriptor(descriptor);
    80001d78:	00048513          	mv	a0,s1
    80001d7c:	00000097          	auipc	ra,0x0
    80001d80:	f70080e7          	jalr	-144(ra) # 80001cec <_Z21bba_unlink_descriptorP9bba_block>
    bba_merge_blocks(descriptor,5);
    80001d84:	00500593          	li	a1,5
    80001d88:	00048513          	mv	a0,s1
    80001d8c:	00000097          	auipc	ra,0x0
    80001d90:	ea8080e7          	jalr	-344(ra) # 80001c34 <_Z16bba_merge_blocksP9bba_blocki>
}
    80001d94:	01813083          	ld	ra,24(sp)
    80001d98:	01013403          	ld	s0,16(sp)
    80001d9c:	00813483          	ld	s1,8(sp)
    80001da0:	00013903          	ld	s2,0(sp)
    80001da4:	02010113          	addi	sp,sp,32
    80001da8:	00008067          	ret
    if(descriptor==0) printf("\nERROR (bba_free_block): Cant find descriptor");
    80001dac:	00008517          	auipc	a0,0x8
    80001db0:	3cc50513          	addi	a0,a0,972 # 8000a178 <CONSOLE_STATUS+0x168>
    80001db4:	00000097          	auipc	ra,0x0
    80001db8:	4e0080e7          	jalr	1248(ra) # 80002294 <_Z6printfPKcz>
    80001dbc:	fadff06f          	j	80001d68 <_Z14bba_free_blockPKv+0x2c>

0000000080001dc0 <_ZL15printInt_staticiii>:
    for (i = 0; i < (int)(sizeof(uint64) * 2); i++, x <<= 4)
        putc(digits[x >> (sizeof(uint64) * 8 - 4)]);
}

static void printInt_static(int xx, int base, int sgn)
{
    80001dc0:	fd010113          	addi	sp,sp,-48
    80001dc4:	02113423          	sd	ra,40(sp)
    80001dc8:	02813023          	sd	s0,32(sp)
    80001dcc:	00913c23          	sd	s1,24(sp)
    80001dd0:	03010413          	addi	s0,sp,48
    char buf[16];
    int i, neg;
    uint x;

    neg = 0;
    if(sgn && xx < 0){
    80001dd4:	00060463          	beqz	a2,80001ddc <_ZL15printInt_staticiii+0x1c>
    80001dd8:	08054463          	bltz	a0,80001e60 <_ZL15printInt_staticiii+0xa0>
        neg = 1;
        x = -xx;
    } else {
        x = xx;
    80001ddc:	0005051b          	sext.w	a0,a0
    neg = 0;
    80001de0:	00000813          	li	a6,0
    }

    i = 0;
    80001de4:	00000493          	li	s1,0
    do{
        buf[i++] = digits[x % base];
    80001de8:	0005879b          	sext.w	a5,a1
    80001dec:	02b5773b          	remuw	a4,a0,a1
    80001df0:	00048613          	mv	a2,s1
    80001df4:	0014849b          	addiw	s1,s1,1
    80001df8:	02071693          	slli	a3,a4,0x20
    80001dfc:	0206d693          	srli	a3,a3,0x20
    80001e00:	0000b717          	auipc	a4,0xb
    80001e04:	b2070713          	addi	a4,a4,-1248 # 8000c920 <digits>
    80001e08:	00d70733          	add	a4,a4,a3
    80001e0c:	00074683          	lbu	a3,0(a4)
    80001e10:	fe040713          	addi	a4,s0,-32
    80001e14:	00c70733          	add	a4,a4,a2
    80001e18:	fed70823          	sb	a3,-16(a4)
    }while((x /= base) != 0);
    80001e1c:	0005071b          	sext.w	a4,a0
    80001e20:	02b5553b          	divuw	a0,a0,a1
    80001e24:	fcf772e3          	bgeu	a4,a5,80001de8 <_ZL15printInt_staticiii+0x28>
    if(neg)
    80001e28:	00080c63          	beqz	a6,80001e40 <_ZL15printInt_staticiii+0x80>
        buf[i++] = '-';
    80001e2c:	fe040793          	addi	a5,s0,-32
    80001e30:	009784b3          	add	s1,a5,s1
    80001e34:	02d00793          	li	a5,45
    80001e38:	fef48823          	sb	a5,-16(s1)
    80001e3c:	0026049b          	addiw	s1,a2,2

    while(--i >= 0)
    80001e40:	fff4849b          	addiw	s1,s1,-1
    80001e44:	0204c463          	bltz	s1,80001e6c <_ZL15printInt_staticiii+0xac>
        putc(buf[i]);
    80001e48:	fe040793          	addi	a5,s0,-32
    80001e4c:	009787b3          	add	a5,a5,s1
    80001e50:	ff07c503          	lbu	a0,-16(a5)
    80001e54:	fffff097          	auipc	ra,0xfffff
    80001e58:	75c080e7          	jalr	1884(ra) # 800015b0 <_Z4putcc>
    80001e5c:	fe5ff06f          	j	80001e40 <_ZL15printInt_staticiii+0x80>
        x = -xx;
    80001e60:	40a0053b          	negw	a0,a0
        neg = 1;
    80001e64:	00100813          	li	a6,1
        x = -xx;
    80001e68:	f7dff06f          	j	80001de4 <_ZL15printInt_staticiii+0x24>

}
    80001e6c:	02813083          	ld	ra,40(sp)
    80001e70:	02013403          	ld	s0,32(sp)
    80001e74:	01813483          	ld	s1,24(sp)
    80001e78:	03010113          	addi	sp,sp,48
    80001e7c:	00008067          	ret

0000000080001e80 <_ZL15printptr_staticm>:
{
    80001e80:	fe010113          	addi	sp,sp,-32
    80001e84:	00113c23          	sd	ra,24(sp)
    80001e88:	00813823          	sd	s0,16(sp)
    80001e8c:	00913423          	sd	s1,8(sp)
    80001e90:	01213023          	sd	s2,0(sp)
    80001e94:	02010413          	addi	s0,sp,32
    80001e98:	00050493          	mv	s1,a0
    putc('0');
    80001e9c:	03000513          	li	a0,48
    80001ea0:	fffff097          	auipc	ra,0xfffff
    80001ea4:	710080e7          	jalr	1808(ra) # 800015b0 <_Z4putcc>
    putc('x');
    80001ea8:	07800513          	li	a0,120
    80001eac:	fffff097          	auipc	ra,0xfffff
    80001eb0:	704080e7          	jalr	1796(ra) # 800015b0 <_Z4putcc>
    for (i = 0; i < (int)(sizeof(uint64) * 2); i++, x <<= 4)
    80001eb4:	00000913          	li	s2,0
    80001eb8:	00f00793          	li	a5,15
    80001ebc:	0327c663          	blt	a5,s2,80001ee8 <_ZL15printptr_staticm+0x68>
        putc(digits[x >> (sizeof(uint64) * 8 - 4)]);
    80001ec0:	03c4d713          	srli	a4,s1,0x3c
    80001ec4:	0000b797          	auipc	a5,0xb
    80001ec8:	a5c78793          	addi	a5,a5,-1444 # 8000c920 <digits>
    80001ecc:	00e787b3          	add	a5,a5,a4
    80001ed0:	0007c503          	lbu	a0,0(a5)
    80001ed4:	fffff097          	auipc	ra,0xfffff
    80001ed8:	6dc080e7          	jalr	1756(ra) # 800015b0 <_Z4putcc>
    for (i = 0; i < (int)(sizeof(uint64) * 2); i++, x <<= 4)
    80001edc:	0019091b          	addiw	s2,s2,1
    80001ee0:	00449493          	slli	s1,s1,0x4
    80001ee4:	fd5ff06f          	j	80001eb8 <_ZL15printptr_staticm+0x38>
}
    80001ee8:	01813083          	ld	ra,24(sp)
    80001eec:	01013403          	ld	s0,16(sp)
    80001ef0:	00813483          	ld	s1,8(sp)
    80001ef4:	00013903          	ld	s2,0(sp)
    80001ef8:	02010113          	addi	sp,sp,32
    80001efc:	00008067          	ret

0000000080001f00 <_Z11printStringPKc>:
{
    80001f00:	fe010113          	addi	sp,sp,-32
    80001f04:	00113c23          	sd	ra,24(sp)
    80001f08:	00813823          	sd	s0,16(sp)
    80001f0c:	00913423          	sd	s1,8(sp)
    80001f10:	02010413          	addi	s0,sp,32
    80001f14:	00050493          	mv	s1,a0
    LOCK();
    80001f18:	00100613          	li	a2,1
    80001f1c:	00000593          	li	a1,0
    80001f20:	0000b517          	auipc	a0,0xb
    80001f24:	d4850513          	addi	a0,a0,-696 # 8000cc68 <lockPrint>
    80001f28:	fffff097          	auipc	ra,0xfffff
    80001f2c:	0d8080e7          	jalr	216(ra) # 80001000 <copy_and_swap>
    80001f30:	00050863          	beqz	a0,80001f40 <_Z11printStringPKc+0x40>
    80001f34:	fffff097          	auipc	ra,0xfffff
    80001f38:	454080e7          	jalr	1108(ra) # 80001388 <_Z15thread_dispatchv>
    80001f3c:	fddff06f          	j	80001f18 <_Z11printStringPKc+0x18>
    while (*string != '\0')
    80001f40:	0004c503          	lbu	a0,0(s1)
    80001f44:	00050a63          	beqz	a0,80001f58 <_Z11printStringPKc+0x58>
        putc(*string);
    80001f48:	fffff097          	auipc	ra,0xfffff
    80001f4c:	668080e7          	jalr	1640(ra) # 800015b0 <_Z4putcc>
        string++;
    80001f50:	00148493          	addi	s1,s1,1
    while (*string != '\0')
    80001f54:	fedff06f          	j	80001f40 <_Z11printStringPKc+0x40>
    UNLOCK();
    80001f58:	00000613          	li	a2,0
    80001f5c:	00100593          	li	a1,1
    80001f60:	0000b517          	auipc	a0,0xb
    80001f64:	d0850513          	addi	a0,a0,-760 # 8000cc68 <lockPrint>
    80001f68:	fffff097          	auipc	ra,0xfffff
    80001f6c:	098080e7          	jalr	152(ra) # 80001000 <copy_and_swap>
    80001f70:	fe0514e3          	bnez	a0,80001f58 <_Z11printStringPKc+0x58>
}
    80001f74:	01813083          	ld	ra,24(sp)
    80001f78:	01013403          	ld	s0,16(sp)
    80001f7c:	00813483          	ld	s1,8(sp)
    80001f80:	02010113          	addi	sp,sp,32
    80001f84:	00008067          	ret

0000000080001f88 <_Z9getStringPci>:
char* getString(char *buf, int max) {
    80001f88:	fd010113          	addi	sp,sp,-48
    80001f8c:	02113423          	sd	ra,40(sp)
    80001f90:	02813023          	sd	s0,32(sp)
    80001f94:	00913c23          	sd	s1,24(sp)
    80001f98:	01213823          	sd	s2,16(sp)
    80001f9c:	01313423          	sd	s3,8(sp)
    80001fa0:	01413023          	sd	s4,0(sp)
    80001fa4:	03010413          	addi	s0,sp,48
    80001fa8:	00050993          	mv	s3,a0
    80001fac:	00058a13          	mv	s4,a1
    LOCK();
    80001fb0:	00100613          	li	a2,1
    80001fb4:	00000593          	li	a1,0
    80001fb8:	0000b517          	auipc	a0,0xb
    80001fbc:	cb050513          	addi	a0,a0,-848 # 8000cc68 <lockPrint>
    80001fc0:	fffff097          	auipc	ra,0xfffff
    80001fc4:	040080e7          	jalr	64(ra) # 80001000 <copy_and_swap>
    80001fc8:	00050863          	beqz	a0,80001fd8 <_Z9getStringPci+0x50>
    80001fcc:	fffff097          	auipc	ra,0xfffff
    80001fd0:	3bc080e7          	jalr	956(ra) # 80001388 <_Z15thread_dispatchv>
    80001fd4:	fddff06f          	j	80001fb0 <_Z9getStringPci+0x28>
    for(i=0; i+1 < max; ){
    80001fd8:	00000913          	li	s2,0
    80001fdc:	00090493          	mv	s1,s2
    80001fe0:	0019091b          	addiw	s2,s2,1
    80001fe4:	03495a63          	bge	s2,s4,80002018 <_Z9getStringPci+0x90>
        cc = getc();
    80001fe8:	fffff097          	auipc	ra,0xfffff
    80001fec:	58c080e7          	jalr	1420(ra) # 80001574 <_Z4getcv>
        if(cc < 1)
    80001ff0:	02050463          	beqz	a0,80002018 <_Z9getStringPci+0x90>
        buf[i++] = c;
    80001ff4:	009984b3          	add	s1,s3,s1
    80001ff8:	00a48023          	sb	a0,0(s1)
        if(c == '\n' || c == '\r')
    80001ffc:	00a00793          	li	a5,10
    80002000:	00f50a63          	beq	a0,a5,80002014 <_Z9getStringPci+0x8c>
    80002004:	00d00793          	li	a5,13
    80002008:	fcf51ae3          	bne	a0,a5,80001fdc <_Z9getStringPci+0x54>
        buf[i++] = c;
    8000200c:	00090493          	mv	s1,s2
    80002010:	0080006f          	j	80002018 <_Z9getStringPci+0x90>
    80002014:	00090493          	mv	s1,s2
    buf[i] = '\0';
    80002018:	009984b3          	add	s1,s3,s1
    8000201c:	00048023          	sb	zero,0(s1)
    UNLOCK();
    80002020:	00000613          	li	a2,0
    80002024:	00100593          	li	a1,1
    80002028:	0000b517          	auipc	a0,0xb
    8000202c:	c4050513          	addi	a0,a0,-960 # 8000cc68 <lockPrint>
    80002030:	fffff097          	auipc	ra,0xfffff
    80002034:	fd0080e7          	jalr	-48(ra) # 80001000 <copy_and_swap>
    80002038:	fe0514e3          	bnez	a0,80002020 <_Z9getStringPci+0x98>
}
    8000203c:	00098513          	mv	a0,s3
    80002040:	02813083          	ld	ra,40(sp)
    80002044:	02013403          	ld	s0,32(sp)
    80002048:	01813483          	ld	s1,24(sp)
    8000204c:	01013903          	ld	s2,16(sp)
    80002050:	00813983          	ld	s3,8(sp)
    80002054:	00013a03          	ld	s4,0(sp)
    80002058:	03010113          	addi	sp,sp,48
    8000205c:	00008067          	ret

0000000080002060 <_Z11stringToIntPKc>:
int stringToInt(const char *s) {
    80002060:	ff010113          	addi	sp,sp,-16
    80002064:	00813423          	sd	s0,8(sp)
    80002068:	01010413          	addi	s0,sp,16
    8000206c:	00050693          	mv	a3,a0
    n = 0;
    80002070:	00000513          	li	a0,0
    while ('0' <= *s && *s <= '9')
    80002074:	0006c603          	lbu	a2,0(a3)
    80002078:	fd06071b          	addiw	a4,a2,-48
    8000207c:	0ff77713          	andi	a4,a4,255
    80002080:	00900793          	li	a5,9
    80002084:	02e7e063          	bltu	a5,a4,800020a4 <_Z11stringToIntPKc+0x44>
        n = n * 10 + *s++ - '0';
    80002088:	0025179b          	slliw	a5,a0,0x2
    8000208c:	00a787bb          	addw	a5,a5,a0
    80002090:	0017979b          	slliw	a5,a5,0x1
    80002094:	00168693          	addi	a3,a3,1
    80002098:	00c787bb          	addw	a5,a5,a2
    8000209c:	fd07851b          	addiw	a0,a5,-48
    while ('0' <= *s && *s <= '9')
    800020a0:	fd5ff06f          	j	80002074 <_Z11stringToIntPKc+0x14>
}
    800020a4:	00813403          	ld	s0,8(sp)
    800020a8:	01010113          	addi	sp,sp,16
    800020ac:	00008067          	ret

00000000800020b0 <_Z8printIntiii>:
{
    800020b0:	fc010113          	addi	sp,sp,-64
    800020b4:	02113c23          	sd	ra,56(sp)
    800020b8:	02813823          	sd	s0,48(sp)
    800020bc:	02913423          	sd	s1,40(sp)
    800020c0:	03213023          	sd	s2,32(sp)
    800020c4:	01313c23          	sd	s3,24(sp)
    800020c8:	04010413          	addi	s0,sp,64
    800020cc:	00050493          	mv	s1,a0
    800020d0:	00058913          	mv	s2,a1
    800020d4:	00060993          	mv	s3,a2
    LOCK();
    800020d8:	00100613          	li	a2,1
    800020dc:	00000593          	li	a1,0
    800020e0:	0000b517          	auipc	a0,0xb
    800020e4:	b8850513          	addi	a0,a0,-1144 # 8000cc68 <lockPrint>
    800020e8:	fffff097          	auipc	ra,0xfffff
    800020ec:	f18080e7          	jalr	-232(ra) # 80001000 <copy_and_swap>
    800020f0:	00050863          	beqz	a0,80002100 <_Z8printIntiii+0x50>
    800020f4:	fffff097          	auipc	ra,0xfffff
    800020f8:	294080e7          	jalr	660(ra) # 80001388 <_Z15thread_dispatchv>
    800020fc:	fddff06f          	j	800020d8 <_Z8printIntiii+0x28>
    if(sgn && xx < 0){
    80002100:	00098463          	beqz	s3,80002108 <_Z8printIntiii+0x58>
    80002104:	0804c463          	bltz	s1,8000218c <_Z8printIntiii+0xdc>
        x = xx;
    80002108:	0004851b          	sext.w	a0,s1
    neg = 0;
    8000210c:	00000593          	li	a1,0
    i = 0;
    80002110:	00000493          	li	s1,0
        buf[i++] = digits[x % base];
    80002114:	0009079b          	sext.w	a5,s2
    80002118:	0325773b          	remuw	a4,a0,s2
    8000211c:	00048613          	mv	a2,s1
    80002120:	0014849b          	addiw	s1,s1,1
    80002124:	02071693          	slli	a3,a4,0x20
    80002128:	0206d693          	srli	a3,a3,0x20
    8000212c:	0000a717          	auipc	a4,0xa
    80002130:	7f470713          	addi	a4,a4,2036 # 8000c920 <digits>
    80002134:	00d70733          	add	a4,a4,a3
    80002138:	00074683          	lbu	a3,0(a4)
    8000213c:	fd040713          	addi	a4,s0,-48
    80002140:	00c70733          	add	a4,a4,a2
    80002144:	fed70823          	sb	a3,-16(a4)
    }while((x /= base) != 0);
    80002148:	0005071b          	sext.w	a4,a0
    8000214c:	0325553b          	divuw	a0,a0,s2
    80002150:	fcf772e3          	bgeu	a4,a5,80002114 <_Z8printIntiii+0x64>
    if(neg)
    80002154:	00058c63          	beqz	a1,8000216c <_Z8printIntiii+0xbc>
        buf[i++] = '-';
    80002158:	fd040793          	addi	a5,s0,-48
    8000215c:	009784b3          	add	s1,a5,s1
    80002160:	02d00793          	li	a5,45
    80002164:	fef48823          	sb	a5,-16(s1)
    80002168:	0026049b          	addiw	s1,a2,2
    while(--i >= 0)
    8000216c:	fff4849b          	addiw	s1,s1,-1
    80002170:	0204c463          	bltz	s1,80002198 <_Z8printIntiii+0xe8>
        putc(buf[i]);
    80002174:	fd040793          	addi	a5,s0,-48
    80002178:	009787b3          	add	a5,a5,s1
    8000217c:	ff07c503          	lbu	a0,-16(a5)
    80002180:	fffff097          	auipc	ra,0xfffff
    80002184:	430080e7          	jalr	1072(ra) # 800015b0 <_Z4putcc>
    80002188:	fe5ff06f          	j	8000216c <_Z8printIntiii+0xbc>
        x = -xx;
    8000218c:	4090053b          	negw	a0,s1
        neg = 1;
    80002190:	00100593          	li	a1,1
        x = -xx;
    80002194:	f7dff06f          	j	80002110 <_Z8printIntiii+0x60>
    UNLOCK();
    80002198:	00000613          	li	a2,0
    8000219c:	00100593          	li	a1,1
    800021a0:	0000b517          	auipc	a0,0xb
    800021a4:	ac850513          	addi	a0,a0,-1336 # 8000cc68 <lockPrint>
    800021a8:	fffff097          	auipc	ra,0xfffff
    800021ac:	e58080e7          	jalr	-424(ra) # 80001000 <copy_and_swap>
    800021b0:	fe0514e3          	bnez	a0,80002198 <_Z8printIntiii+0xe8>
}
    800021b4:	03813083          	ld	ra,56(sp)
    800021b8:	03013403          	ld	s0,48(sp)
    800021bc:	02813483          	ld	s1,40(sp)
    800021c0:	02013903          	ld	s2,32(sp)
    800021c4:	01813983          	ld	s3,24(sp)
    800021c8:	04010113          	addi	sp,sp,64
    800021cc:	00008067          	ret

00000000800021d0 <_Z8printptrm>:
{
    800021d0:	fe010113          	addi	sp,sp,-32
    800021d4:	00113c23          	sd	ra,24(sp)
    800021d8:	00813823          	sd	s0,16(sp)
    800021dc:	00913423          	sd	s1,8(sp)
    800021e0:	01213023          	sd	s2,0(sp)
    800021e4:	02010413          	addi	s0,sp,32
    800021e8:	00050493          	mv	s1,a0
    LOCK();
    800021ec:	00100613          	li	a2,1
    800021f0:	00000593          	li	a1,0
    800021f4:	0000b517          	auipc	a0,0xb
    800021f8:	a7450513          	addi	a0,a0,-1420 # 8000cc68 <lockPrint>
    800021fc:	fffff097          	auipc	ra,0xfffff
    80002200:	e04080e7          	jalr	-508(ra) # 80001000 <copy_and_swap>
    80002204:	00050863          	beqz	a0,80002214 <_Z8printptrm+0x44>
    80002208:	fffff097          	auipc	ra,0xfffff
    8000220c:	180080e7          	jalr	384(ra) # 80001388 <_Z15thread_dispatchv>
    80002210:	fddff06f          	j	800021ec <_Z8printptrm+0x1c>
    putc('0');
    80002214:	03000513          	li	a0,48
    80002218:	fffff097          	auipc	ra,0xfffff
    8000221c:	398080e7          	jalr	920(ra) # 800015b0 <_Z4putcc>
    putc('x');
    80002220:	07800513          	li	a0,120
    80002224:	fffff097          	auipc	ra,0xfffff
    80002228:	38c080e7          	jalr	908(ra) # 800015b0 <_Z4putcc>
    for (i = 0; i < (int)(sizeof(uint64) * 2); i++, x <<= 4)
    8000222c:	00000913          	li	s2,0
    80002230:	00f00793          	li	a5,15
    80002234:	0327c663          	blt	a5,s2,80002260 <_Z8printptrm+0x90>
        putc(digits[x >> (sizeof(uint64) * 8 - 4)]);
    80002238:	03c4d713          	srli	a4,s1,0x3c
    8000223c:	0000a797          	auipc	a5,0xa
    80002240:	6e478793          	addi	a5,a5,1764 # 8000c920 <digits>
    80002244:	00e787b3          	add	a5,a5,a4
    80002248:	0007c503          	lbu	a0,0(a5)
    8000224c:	fffff097          	auipc	ra,0xfffff
    80002250:	364080e7          	jalr	868(ra) # 800015b0 <_Z4putcc>
    for (i = 0; i < (int)(sizeof(uint64) * 2); i++, x <<= 4)
    80002254:	0019091b          	addiw	s2,s2,1
    80002258:	00449493          	slli	s1,s1,0x4
    8000225c:	fd5ff06f          	j	80002230 <_Z8printptrm+0x60>
    UNLOCK();
    80002260:	00000613          	li	a2,0
    80002264:	00100593          	li	a1,1
    80002268:	0000b517          	auipc	a0,0xb
    8000226c:	a0050513          	addi	a0,a0,-1536 # 8000cc68 <lockPrint>
    80002270:	fffff097          	auipc	ra,0xfffff
    80002274:	d90080e7          	jalr	-624(ra) # 80001000 <copy_and_swap>
    80002278:	fe0514e3          	bnez	a0,80002260 <_Z8printptrm+0x90>
}
    8000227c:	01813083          	ld	ra,24(sp)
    80002280:	01013403          	ld	s0,16(sp)
    80002284:	00813483          	ld	s1,8(sp)
    80002288:	00013903          	ld	s2,0(sp)
    8000228c:	02010113          	addi	sp,sp,32
    80002290:	00008067          	ret

0000000080002294 <_Z6printfPKcz>:

void
printf(const char *fmt, ...)
{
    80002294:	f8010113          	addi	sp,sp,-128
    80002298:	02113c23          	sd	ra,56(sp)
    8000229c:	02813823          	sd	s0,48(sp)
    800022a0:	02913423          	sd	s1,40(sp)
    800022a4:	03213023          	sd	s2,32(sp)
    800022a8:	01313c23          	sd	s3,24(sp)
    800022ac:	04010413          	addi	s0,sp,64
    800022b0:	00050993          	mv	s3,a0
    800022b4:	00b43423          	sd	a1,8(s0)
    800022b8:	00c43823          	sd	a2,16(s0)
    800022bc:	00d43c23          	sd	a3,24(s0)
    800022c0:	02e43023          	sd	a4,32(s0)
    800022c4:	02f43423          	sd	a5,40(s0)
    800022c8:	03043823          	sd	a6,48(s0)
    800022cc:	03143c23          	sd	a7,56(s0)
    LOCK();
    800022d0:	00100613          	li	a2,1
    800022d4:	00000593          	li	a1,0
    800022d8:	0000b517          	auipc	a0,0xb
    800022dc:	99050513          	addi	a0,a0,-1648 # 8000cc68 <lockPrint>
    800022e0:	fffff097          	auipc	ra,0xfffff
    800022e4:	d20080e7          	jalr	-736(ra) # 80001000 <copy_and_swap>
    800022e8:	00050863          	beqz	a0,800022f8 <_Z6printfPKcz+0x64>
    800022ec:	fffff097          	auipc	ra,0xfffff
    800022f0:	09c080e7          	jalr	156(ra) # 80001388 <_Z15thread_dispatchv>
    800022f4:	fddff06f          	j	800022d0 <_Z6printfPKcz+0x3c>
    va_list ap;
    int i, c;
    char *s;


    if (fmt == 0) return;
    800022f8:	14098663          	beqz	s3,80002444 <_Z6printfPKcz+0x1b0>

    va_start(ap, fmt);
    800022fc:	00840793          	addi	a5,s0,8
    80002300:	fcf43423          	sd	a5,-56(s0)
    for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
    80002304:	00000913          	li	s2,0
    80002308:	0100006f          	j	80002318 <_Z6printfPKcz+0x84>
        if(c != '%'){
            putc(c);
    8000230c:	fffff097          	auipc	ra,0xfffff
    80002310:	2a4080e7          	jalr	676(ra) # 800015b0 <_Z4putcc>
    for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
    80002314:	0019091b          	addiw	s2,s2,1
    80002318:	012987b3          	add	a5,s3,s2
    8000231c:	0007c503          	lbu	a0,0(a5)
    80002320:	0005079b          	sext.w	a5,a0
    80002324:	10050263          	beqz	a0,80002428 <_Z6printfPKcz+0x194>
        if(c != '%'){
    80002328:	02500713          	li	a4,37
    8000232c:	fee790e3          	bne	a5,a4,8000230c <_Z6printfPKcz+0x78>
            continue;
        }
        c = fmt[++i] & 0xff;
    80002330:	0019091b          	addiw	s2,s2,1
    80002334:	012987b3          	add	a5,s3,s2
    80002338:	0007c483          	lbu	s1,0(a5)
        if(c == 0)
    8000233c:	0e048663          	beqz	s1,80002428 <_Z6printfPKcz+0x194>
            break;
        switch(c){
    80002340:	07000793          	li	a5,112
    80002344:	06f48863          	beq	s1,a5,800023b4 <_Z6printfPKcz+0x120>
    80002348:	0297fc63          	bgeu	a5,s1,80002380 <_Z6printfPKcz+0xec>
    8000234c:	07300793          	li	a5,115
    80002350:	08f48063          	beq	s1,a5,800023d0 <_Z6printfPKcz+0x13c>
    80002354:	07800793          	li	a5,120
    80002358:	0af49a63          	bne	s1,a5,8000240c <_Z6printfPKcz+0x178>
            case 'd':
                printInt_static(va_arg(ap, int), 10, 1);
                break;
            case 'x':
                printInt_static(va_arg(ap, int), 16, 1);
    8000235c:	fc843783          	ld	a5,-56(s0)
    80002360:	00878713          	addi	a4,a5,8
    80002364:	fce43423          	sd	a4,-56(s0)
    80002368:	00100613          	li	a2,1
    8000236c:	01000593          	li	a1,16
    80002370:	0007a503          	lw	a0,0(a5)
    80002374:	00000097          	auipc	ra,0x0
    80002378:	a4c080e7          	jalr	-1460(ra) # 80001dc0 <_ZL15printInt_staticiii>
    8000237c:	f99ff06f          	j	80002314 <_Z6printfPKcz+0x80>
        switch(c){
    80002380:	02500793          	li	a5,37
    80002384:	06f48c63          	beq	s1,a5,800023fc <_Z6printfPKcz+0x168>
    80002388:	06400793          	li	a5,100
    8000238c:	08f49063          	bne	s1,a5,8000240c <_Z6printfPKcz+0x178>
                printInt_static(va_arg(ap, int), 10, 1);
    80002390:	fc843783          	ld	a5,-56(s0)
    80002394:	00878713          	addi	a4,a5,8
    80002398:	fce43423          	sd	a4,-56(s0)
    8000239c:	00100613          	li	a2,1
    800023a0:	00a00593          	li	a1,10
    800023a4:	0007a503          	lw	a0,0(a5)
    800023a8:	00000097          	auipc	ra,0x0
    800023ac:	a18080e7          	jalr	-1512(ra) # 80001dc0 <_ZL15printInt_staticiii>
    800023b0:	f65ff06f          	j	80002314 <_Z6printfPKcz+0x80>
                break;
            case 'p':
                printptr_static(va_arg(ap, uint64));
    800023b4:	fc843783          	ld	a5,-56(s0)
    800023b8:	00878713          	addi	a4,a5,8
    800023bc:	fce43423          	sd	a4,-56(s0)
    800023c0:	0007b503          	ld	a0,0(a5)
    800023c4:	00000097          	auipc	ra,0x0
    800023c8:	abc080e7          	jalr	-1348(ra) # 80001e80 <_ZL15printptr_staticm>
    800023cc:	f49ff06f          	j	80002314 <_Z6printfPKcz+0x80>
                break;
            case 's':
                if((s = va_arg(ap, char*)) == 0)
    800023d0:	fc843783          	ld	a5,-56(s0)
    800023d4:	00878713          	addi	a4,a5,8
    800023d8:	fce43423          	sd	a4,-56(s0)
    800023dc:	0007b483          	ld	s1,0(a5)
    800023e0:	f2048ae3          	beqz	s1,80002314 <_Z6printfPKcz+0x80>
                    break;
                for(; *s; s++)
    800023e4:	0004c503          	lbu	a0,0(s1)
    800023e8:	f20506e3          	beqz	a0,80002314 <_Z6printfPKcz+0x80>
                    putc(*s);
    800023ec:	fffff097          	auipc	ra,0xfffff
    800023f0:	1c4080e7          	jalr	452(ra) # 800015b0 <_Z4putcc>
                for(; *s; s++)
    800023f4:	00148493          	addi	s1,s1,1
    800023f8:	fedff06f          	j	800023e4 <_Z6printfPKcz+0x150>
                break;
            case '%':
                putc('%');
    800023fc:	02500513          	li	a0,37
    80002400:	fffff097          	auipc	ra,0xfffff
    80002404:	1b0080e7          	jalr	432(ra) # 800015b0 <_Z4putcc>
    80002408:	f0dff06f          	j	80002314 <_Z6printfPKcz+0x80>
                break;
            default:
                // Print unknown % sequence to draw attention.
                putc('%');
    8000240c:	02500513          	li	a0,37
    80002410:	fffff097          	auipc	ra,0xfffff
    80002414:	1a0080e7          	jalr	416(ra) # 800015b0 <_Z4putcc>
                putc(c);
    80002418:	00048513          	mv	a0,s1
    8000241c:	fffff097          	auipc	ra,0xfffff
    80002420:	194080e7          	jalr	404(ra) # 800015b0 <_Z4putcc>
    80002424:	ef1ff06f          	j	80002314 <_Z6printfPKcz+0x80>
                break;
        }
    }

    UNLOCK();
    80002428:	00000613          	li	a2,0
    8000242c:	00100593          	li	a1,1
    80002430:	0000b517          	auipc	a0,0xb
    80002434:	83850513          	addi	a0,a0,-1992 # 8000cc68 <lockPrint>
    80002438:	fffff097          	auipc	ra,0xfffff
    8000243c:	bc8080e7          	jalr	-1080(ra) # 80001000 <copy_and_swap>
    80002440:	fe0514e3          	bnez	a0,80002428 <_Z6printfPKcz+0x194>
}
    80002444:	03813083          	ld	ra,56(sp)
    80002448:	03013403          	ld	s0,48(sp)
    8000244c:	02813483          	ld	s1,40(sp)
    80002450:	02013903          	ld	s2,32(sp)
    80002454:	01813983          	ld	s3,24(sp)
    80002458:	08010113          	addi	sp,sp,128
    8000245c:	00008067          	ret

0000000080002460 <_Z14kern_mem_alloci>:

mem_block_s * freeHead;


void* kern_mem_alloc(int sizeInBlocks)
{
    80002460:	ff010113          	addi	sp,sp,-16
    80002464:	00813423          	sd	s0,8(sp)
    80002468:	01010413          	addi	s0,sp,16
    8000246c:	00050693          	mv	a3,a0
    mem_block_s *curr = freeHead;
    80002470:	0000b597          	auipc	a1,0xb
    80002474:	8005b583          	ld	a1,-2048(a1) # 8000cc70 <freeHead>
    80002478:	00058513          	mv	a0,a1
    mem_block_s *prev = 0;
    8000247c:	00000613          	li	a2,0
    80002480:	0480006f          	j	800024c8 <_Z14kern_mem_alloci+0x68>

    while (curr){
        if(curr->sizeInBlocks==sizeInBlocks+1){
            if(curr==freeHead) freeHead=curr->next;
    80002484:	02b50063          	beq	a0,a1,800024a4 <_Z14kern_mem_alloci+0x44>
            else prev->next = curr->next;
    80002488:	00853783          	ld	a5,8(a0)
    8000248c:	00f63423          	sd	a5,8(a2)
            curr->sizeInBlocks=sizeInBlocks+1;
    80002490:	00e52023          	sw	a4,0(a0)
            return (curr+MEM_BLOCK_SIZE);
    80002494:	40050513          	addi	a0,a0,1024
        prev=curr;
        curr=curr->next;
    }

    return 0;
}
    80002498:	00813403          	ld	s0,8(sp)
    8000249c:	01010113          	addi	sp,sp,16
    800024a0:	00008067          	ret
            if(curr==freeHead) freeHead=curr->next;
    800024a4:	00853783          	ld	a5,8(a0)
    800024a8:	0000a697          	auipc	a3,0xa
    800024ac:	7cf6b423          	sd	a5,1992(a3) # 8000cc70 <freeHead>
    800024b0:	fe1ff06f          	j	80002490 <_Z14kern_mem_alloci+0x30>
            if(curr==freeHead) freeHead=newFreeBlock;
    800024b4:	0000a797          	auipc	a5,0xa
    800024b8:	7ab7be23          	sd	a1,1980(a5) # 8000cc70 <freeHead>
    800024bc:	05c0006f          	j	80002518 <_Z14kern_mem_alloci+0xb8>
        prev=curr;
    800024c0:	00050613          	mv	a2,a0
        curr=curr->next;
    800024c4:	00853503          	ld	a0,8(a0)
    while (curr){
    800024c8:	fc0508e3          	beqz	a0,80002498 <_Z14kern_mem_alloci+0x38>
        if(curr->sizeInBlocks==sizeInBlocks+1){
    800024cc:	00052783          	lw	a5,0(a0)
    800024d0:	0016871b          	addiw	a4,a3,1
    800024d4:	fae788e3          	beq	a5,a4,80002484 <_Z14kern_mem_alloci+0x24>
        else if(curr->sizeInBlocks>sizeInBlocks+1){
    800024d8:	fef754e3          	bge	a4,a5,800024c0 <_Z14kern_mem_alloci+0x60>
            mem_block_s* newFreeBlock = curr+(sizeInBlocks+1)*MEM_BLOCK_SIZE;
    800024dc:	00a71593          	slli	a1,a4,0xa
    800024e0:	00b505b3          	add	a1,a0,a1
            newFreeBlock->sizeInBlocks = curr->sizeInBlocks-sizeInBlocks-1;
    800024e4:	40d787bb          	subw	a5,a5,a3
    800024e8:	fff7879b          	addiw	a5,a5,-1
    800024ec:	00f5a023          	sw	a5,0(a1)
            newFreeBlock->startingBlock=curr->startingBlock+sizeInBlocks+1;
    800024f0:	00452783          	lw	a5,4(a0)
    800024f4:	00d786bb          	addw	a3,a5,a3
    800024f8:	0016869b          	addiw	a3,a3,1
    800024fc:	00d5a223          	sw	a3,4(a1)
            newFreeBlock->next = curr->next;
    80002500:	00853783          	ld	a5,8(a0)
    80002504:	00f5b423          	sd	a5,8(a1)
            if(curr==freeHead) freeHead=newFreeBlock;
    80002508:	0000a797          	auipc	a5,0xa
    8000250c:	7687b783          	ld	a5,1896(a5) # 8000cc70 <freeHead>
    80002510:	faa782e3          	beq	a5,a0,800024b4 <_Z14kern_mem_alloci+0x54>
            else prev->next=newFreeBlock;
    80002514:	00b63423          	sd	a1,8(a2)
            curr->sizeInBlocks=sizeInBlocks+1;
    80002518:	00e52023          	sw	a4,0(a0)
            return (curr+MEM_BLOCK_SIZE);
    8000251c:	40050513          	addi	a0,a0,1024
    80002520:	f79ff06f          	j	80002498 <_Z14kern_mem_alloci+0x38>

0000000080002524 <_Z13kern_mem_freePv>:

int kern_mem_free(void* addr)
{
    80002524:	ff010113          	addi	sp,sp,-16
    80002528:	00813423          	sd	s0,8(sp)
    8000252c:	01010413          	addi	s0,sp,16
    mem_block_s* freedBlock = (mem_block_s*) addr-MEM_BLOCK_SIZE;
    80002530:	c0050713          	addi	a4,a0,-1024
    mem_block_s* curr=freeHead;
    80002534:	0000a797          	auipc	a5,0xa
    80002538:	73c7b783          	ld	a5,1852(a5) # 8000cc70 <freeHead>
    mem_block_s * prev =0;
    8000253c:	00000693          	li	a3,0

    while (curr<freedBlock && curr!=0){
    80002540:	00e7fa63          	bgeu	a5,a4,80002554 <_Z13kern_mem_freePv+0x30>
    80002544:	00078863          	beqz	a5,80002554 <_Z13kern_mem_freePv+0x30>
        prev=curr;
    80002548:	00078693          	mv	a3,a5
        curr=curr->next;
    8000254c:	0087b783          	ld	a5,8(a5)
    while (curr<freedBlock && curr!=0){
    80002550:	ff1ff06f          	j	80002540 <_Z13kern_mem_freePv+0x1c>
    char* cfreedBlock = (char *)freedBlock;
    char* cprev = (char *)prev;
    char* ccurr = (char *)curr;
    */

    if(prev){
    80002554:	04068e63          	beqz	a3,800025b0 <_Z13kern_mem_freePv+0x8c>
        if(prev->startingBlock+prev->sizeInBlocks==freedBlock->startingBlock){
    80002558:	0046a603          	lw	a2,4(a3)
    8000255c:	0006a583          	lw	a1,0(a3)
    80002560:	00b6063b          	addw	a2,a2,a1
    80002564:	c0452803          	lw	a6,-1020(a0)
    80002568:	03060a63          	beq	a2,a6,8000259c <_Z13kern_mem_freePv+0x78>
            prev->sizeInBlocks+=freedBlock->sizeInBlocks;
            freedBlock=prev;
        } else {
            prev->next=freedBlock;
    8000256c:	00e6b423          	sd	a4,8(a3)
        }
    }
    else freeHead=freedBlock;

    if(curr){
    80002570:	00078e63          	beqz	a5,8000258c <_Z13kern_mem_freePv+0x68>
        if(freedBlock->startingBlock+freedBlock->sizeInBlocks==curr->startingBlock){
    80002574:	00472683          	lw	a3,4(a4)
    80002578:	00072603          	lw	a2,0(a4)
    8000257c:	00c686bb          	addw	a3,a3,a2
    80002580:	0047a583          	lw	a1,4(a5)
    80002584:	02b68c63          	beq	a3,a1,800025bc <_Z13kern_mem_freePv+0x98>
            freedBlock->sizeInBlocks+=curr->sizeInBlocks;
            freedBlock->next=curr->next;
        } else{
          freedBlock->next=curr;
    80002588:	00f73423          	sd	a5,8(a4)
        }
    }


    return 0;
}
    8000258c:	00000513          	li	a0,0
    80002590:	00813403          	ld	s0,8(sp)
    80002594:	01010113          	addi	sp,sp,16
    80002598:	00008067          	ret
            prev->sizeInBlocks+=freedBlock->sizeInBlocks;
    8000259c:	c0052703          	lw	a4,-1024(a0)
    800025a0:	00e585bb          	addw	a1,a1,a4
    800025a4:	00b6a023          	sw	a1,0(a3)
            freedBlock=prev;
    800025a8:	00068713          	mv	a4,a3
    800025ac:	fc5ff06f          	j	80002570 <_Z13kern_mem_freePv+0x4c>
    else freeHead=freedBlock;
    800025b0:	0000a697          	auipc	a3,0xa
    800025b4:	6ce6b023          	sd	a4,1728(a3) # 8000cc70 <freeHead>
    800025b8:	fb9ff06f          	j	80002570 <_Z13kern_mem_freePv+0x4c>
            freedBlock->sizeInBlocks+=curr->sizeInBlocks;
    800025bc:	0007a683          	lw	a3,0(a5)
    800025c0:	00d6063b          	addw	a2,a2,a3
    800025c4:	00c72023          	sw	a2,0(a4)
            freedBlock->next=curr->next;
    800025c8:	0087b783          	ld	a5,8(a5)
    800025cc:	00f73423          	sd	a5,8(a4)
    800025d0:	fbdff06f          	j	8000258c <_Z13kern_mem_freePv+0x68>

00000000800025d4 <_Z13kern_mem_initPvS_>:

unsigned long ukupno_memorije;
void kern_mem_init(void* start, void* end)
{
    800025d4:	ff010113          	addi	sp,sp,-16
    800025d8:	00813423          	sd	s0,8(sp)
    800025dc:	01010413          	addi	s0,sp,16
    unsigned long lstart = (unsigned long) start;
    unsigned long lend = (unsigned long) end;
    800025e0:	00058793          	mv	a5,a1

    if(lstart%MEM_BLOCK_SIZE>0) start =(void*) ((lstart/MEM_BLOCK_SIZE+1)*MEM_BLOCK_SIZE);
    800025e4:	03f57713          	andi	a4,a0,63
    800025e8:	00070863          	beqz	a4,800025f8 <_Z13kern_mem_initPvS_+0x24>
    800025ec:	00655513          	srli	a0,a0,0x6
    800025f0:	00150513          	addi	a0,a0,1
    800025f4:	00651513          	slli	a0,a0,0x6
    if(lend%MEM_BLOCK_SIZE>0) end =(void*) ((lend/MEM_BLOCK_SIZE)*MEM_BLOCK_SIZE);
    800025f8:	03f7f713          	andi	a4,a5,63
    800025fc:	00070463          	beqz	a4,80002604 <_Z13kern_mem_initPvS_+0x30>
    80002600:	fc07f593          	andi	a1,a5,-64

    freeHead = (mem_block_s*)start;
    80002604:	0000a797          	auipc	a5,0xa
    80002608:	66c78793          	addi	a5,a5,1644 # 8000cc70 <freeHead>
    8000260c:	00a7b023          	sd	a0,0(a5)
    freeHead->next=0;
    80002610:	00053423          	sd	zero,8(a0)
    freeHead->startingBlock=0;
    80002614:	00052223          	sw	zero,4(a0)
    freeHead->sizeInBlocks = ((uint64)end-(uint64)start)/MEM_BLOCK_SIZE;
    80002618:	40a58533          	sub	a0,a1,a0
    8000261c:	00655513          	srli	a0,a0,0x6
    80002620:	0007b703          	ld	a4,0(a5)
    80002624:	00a72023          	sw	a0,0(a4)
    ukupno_memorije=freeHead->sizeInBlocks;
    80002628:	0007b703          	ld	a4,0(a5)
    8000262c:	00072703          	lw	a4,0(a4)
    80002630:	00e7b423          	sd	a4,8(a5)
}
    80002634:	00813403          	ld	s0,8(sp)
    80002638:	01010113          	addi	sp,sp,16
    8000263c:	00008067          	ret

0000000080002640 <_Z17kern_console_initv>:
    int input_w;
    int output_r;
    int output_w;
} console;

void kern_console_init(){
    80002640:	ff010113          	addi	sp,sp,-16
    80002644:	00813423          	sd	s0,8(sp)
    80002648:	01010413          	addi	s0,sp,16
    console.input_r=0;
    8000264c:	0000b797          	auipc	a5,0xb
    80002650:	63478793          	addi	a5,a5,1588 # 8000dc80 <kthreads+0x7b0>
    80002654:	8007a023          	sw	zero,-2048(a5)
    console.input_w=0;
    80002658:	8007a223          	sw	zero,-2044(a5)
    console.output_r=0;
    8000265c:	8007a423          	sw	zero,-2040(a5)
    console.input_w=0;
}
    80002660:	00813403          	ld	s0,8(sp)
    80002664:	01010113          	addi	sp,sp,16
    80002668:	00008067          	ret

000000008000266c <_Z12uart_getcharv>:

int uart_getchar(void)
{
    8000266c:	ff010113          	addi	sp,sp,-16
    80002670:	00813423          	sd	s0,8(sp)
    80002674:	01010413          	addi	s0,sp,16
    if((ReadReg(CONSOLE_STATUS) & CONSOLE_RX_STATUS_BIT)!=0){
    80002678:	0000a797          	auipc	a5,0xa
    8000267c:	4c87b783          	ld	a5,1224(a5) # 8000cb40 <_GLOBAL_OFFSET_TABLE_+0x10>
    80002680:	0007b783          	ld	a5,0(a5)
    80002684:	0007c783          	lbu	a5,0(a5)
    80002688:	0017f793          	andi	a5,a5,1
    8000268c:	02078263          	beqz	a5,800026b0 <_Z12uart_getcharv+0x44>
        // input data is ready.
        return ReadReg(CONSOLE_RX_DATA);
    80002690:	0000a797          	auipc	a5,0xa
    80002694:	4a87b783          	ld	a5,1192(a5) # 8000cb38 <_GLOBAL_OFFSET_TABLE_+0x8>
    80002698:	0007b783          	ld	a5,0(a5)
    8000269c:	0007c503          	lbu	a0,0(a5)
    800026a0:	0ff57513          	andi	a0,a0,255
    } else {
        return -1;
    }
}
    800026a4:	00813403          	ld	s0,8(sp)
    800026a8:	01010113          	addi	sp,sp,16
    800026ac:	00008067          	ret
        return -1;
    800026b0:	fff00513          	li	a0,-1
    800026b4:	ff1ff06f          	j	800026a4 <_Z12uart_getcharv+0x38>

00000000800026b8 <_Z12uart_putcharv>:

void uart_putchar()
{
    800026b8:	ff010113          	addi	sp,sp,-16
    800026bc:	00813423          	sd	s0,8(sp)
    800026c0:	01010413          	addi	s0,sp,16
    if(console.output_r==console.output_w) return;
    800026c4:	0000b717          	auipc	a4,0xb
    800026c8:	5bc70713          	addi	a4,a4,1468 # 8000dc80 <kthreads+0x7b0>
    800026cc:	80872783          	lw	a5,-2040(a4)
    800026d0:	80c72703          	lw	a4,-2036(a4)
    800026d4:	06e78063          	beq	a5,a4,80002734 <_Z12uart_putcharv+0x7c>

    if((ReadReg(CONSOLE_STATUS) & CONSOLE_TX_STATUS_BIT) == 0){
    800026d8:	0000a717          	auipc	a4,0xa
    800026dc:	46873703          	ld	a4,1128(a4) # 8000cb40 <_GLOBAL_OFFSET_TABLE_+0x10>
    800026e0:	00073703          	ld	a4,0(a4)
    800026e4:	00074703          	lbu	a4,0(a4)
    800026e8:	0ff77713          	andi	a4,a4,255
    800026ec:	02077713          	andi	a4,a4,32
    800026f0:	04070263          	beqz	a4,80002734 <_Z12uart_putcharv+0x7c>
        return;
    }

    char c = console.output[(console.output_r++)%BUFFER_SIZE];
    800026f4:	0017871b          	addiw	a4,a5,1
    800026f8:	0000b697          	auipc	a3,0xb
    800026fc:	d8e6a823          	sw	a4,-624(a3) # 8000d488 <console+0x808>
    80002700:	41f7d71b          	sraiw	a4,a5,0x1f
    80002704:	0167571b          	srliw	a4,a4,0x16
    80002708:	00f707bb          	addw	a5,a4,a5
    8000270c:	3ff7f793          	andi	a5,a5,1023
    80002710:	40e787bb          	subw	a5,a5,a4
    80002714:	0000a717          	auipc	a4,0xa
    80002718:	56c70713          	addi	a4,a4,1388 # 8000cc80 <console>
    8000271c:	00f707b3          	add	a5,a4,a5
    80002720:	4007c703          	lbu	a4,1024(a5)
    WriteReg(CONSOLE_TX_DATA,c);
    80002724:	0000a797          	auipc	a5,0xa
    80002728:	43c7b783          	ld	a5,1084(a5) # 8000cb60 <_GLOBAL_OFFSET_TABLE_+0x30>
    8000272c:	0007b783          	ld	a5,0(a5)
    80002730:	00e78023          	sb	a4,0(a5)
}
    80002734:	00813403          	ld	s0,8(sp)
    80002738:	01010113          	addi	sp,sp,16
    8000273c:	00008067          	ret

0000000080002740 <_Z17kern_uart_handlerv>:

void kern_uart_handler()
{
    80002740:	ff010113          	addi	sp,sp,-16
    80002744:	00113423          	sd	ra,8(sp)
    80002748:	00813023          	sd	s0,0(sp)
    8000274c:	01010413          	addi	s0,sp,16
    while(1){
        int c = uart_getchar();
    80002750:	00000097          	auipc	ra,0x0
    80002754:	f1c080e7          	jalr	-228(ra) # 8000266c <_Z12uart_getcharv>
        if(c==-1) break;
    80002758:	fff00793          	li	a5,-1
    8000275c:	04f50063          	beq	a0,a5,8000279c <_Z17kern_uart_handlerv+0x5c>
        console.input[(console.input_w++)%BUFFER_SIZE]=c;
    80002760:	0000b717          	auipc	a4,0xb
    80002764:	52070713          	addi	a4,a4,1312 # 8000dc80 <kthreads+0x7b0>
    80002768:	80472783          	lw	a5,-2044(a4)
    8000276c:	0017869b          	addiw	a3,a5,1
    80002770:	80d72223          	sw	a3,-2044(a4)
    80002774:	41f7d71b          	sraiw	a4,a5,0x1f
    80002778:	0167571b          	srliw	a4,a4,0x16
    8000277c:	00f707bb          	addw	a5,a4,a5
    80002780:	3ff7f793          	andi	a5,a5,1023
    80002784:	40e787bb          	subw	a5,a5,a4
    80002788:	0000a717          	auipc	a4,0xa
    8000278c:	4f870713          	addi	a4,a4,1272 # 8000cc80 <console>
    80002790:	00f707b3          	add	a5,a4,a5
    80002794:	00a78023          	sb	a0,0(a5)
    }
    80002798:	fb9ff06f          	j	80002750 <_Z17kern_uart_handlerv+0x10>

    uart_putchar();
    8000279c:	00000097          	auipc	ra,0x0
    800027a0:	f1c080e7          	jalr	-228(ra) # 800026b8 <_Z12uart_putcharv>
}
    800027a4:	00813083          	ld	ra,8(sp)
    800027a8:	00013403          	ld	s0,0(sp)
    800027ac:	01010113          	addi	sp,sp,16
    800027b0:	00008067          	ret

00000000800027b4 <_Z20kern_console_getcharv>:

int kern_console_getchar()
{
    800027b4:	ff010113          	addi	sp,sp,-16
    800027b8:	00813423          	sd	s0,8(sp)
    800027bc:	01010413          	addi	s0,sp,16
    if(console.input_r<console.input_w){
    800027c0:	0000b717          	auipc	a4,0xb
    800027c4:	4c070713          	addi	a4,a4,1216 # 8000dc80 <kthreads+0x7b0>
    800027c8:	80072783          	lw	a5,-2048(a4)
    800027cc:	80472703          	lw	a4,-2044(a4)
    800027d0:	04e7d063          	bge	a5,a4,80002810 <_Z20kern_console_getcharv+0x5c>
        return console.input[(console.input_r++)%BUFFER_SIZE];
    800027d4:	0017871b          	addiw	a4,a5,1
    800027d8:	0000b697          	auipc	a3,0xb
    800027dc:	cae6a423          	sw	a4,-856(a3) # 8000d480 <console+0x800>
    800027e0:	41f7d71b          	sraiw	a4,a5,0x1f
    800027e4:	0167571b          	srliw	a4,a4,0x16
    800027e8:	00f707bb          	addw	a5,a4,a5
    800027ec:	3ff7f793          	andi	a5,a5,1023
    800027f0:	40e787bb          	subw	a5,a5,a4
    800027f4:	0000a717          	auipc	a4,0xa
    800027f8:	48c70713          	addi	a4,a4,1164 # 8000cc80 <console>
    800027fc:	00f707b3          	add	a5,a4,a5
    80002800:	0007c503          	lbu	a0,0(a5)
    }
    else return -1;
}
    80002804:	00813403          	ld	s0,8(sp)
    80002808:	01010113          	addi	sp,sp,16
    8000280c:	00008067          	ret
    else return -1;
    80002810:	fff00513          	li	a0,-1
    80002814:	ff1ff06f          	j	80002804 <_Z20kern_console_getcharv+0x50>

0000000080002818 <_Z20kern_console_putcharc>:

int kern_console_putchar(char c)
{
    80002818:	ff010113          	addi	sp,sp,-16
    8000281c:	00813423          	sd	s0,8(sp)
    80002820:	01010413          	addi	s0,sp,16
    if(ReadReg(CONSOLE_STATUS) & CONSOLE_TX_STATUS_BIT){
    80002824:	0000a797          	auipc	a5,0xa
    80002828:	31c7b783          	ld	a5,796(a5) # 8000cb40 <_GLOBAL_OFFSET_TABLE_+0x10>
    8000282c:	0007b783          	ld	a5,0(a5)
    80002830:	0007c783          	lbu	a5,0(a5)
    80002834:	0ff7f793          	andi	a5,a5,255
    80002838:	0207f793          	andi	a5,a5,32
    8000283c:	02078263          	beqz	a5,80002860 <_Z20kern_console_putcharc+0x48>
        WriteReg(CONSOLE_TX_DATA,c);
    80002840:	0000a797          	auipc	a5,0xa
    80002844:	3207b783          	ld	a5,800(a5) # 8000cb60 <_GLOBAL_OFFSET_TABLE_+0x30>
    80002848:	0007b783          	ld	a5,0(a5)
    8000284c:	00a78023          	sb	a0,0(a5)
    }
    else{
        if(console.output_r-console.output_w>=BUFFER_SIZE) return -1;
        console.output[(console.output_w++)%BUFFER_SIZE]=c;
    }
    return 0;
    80002850:	00000513          	li	a0,0
}
    80002854:	00813403          	ld	s0,8(sp)
    80002858:	01010113          	addi	sp,sp,16
    8000285c:	00008067          	ret
        if(console.output_r-console.output_w>=BUFFER_SIZE) return -1;
    80002860:	0000b797          	auipc	a5,0xb
    80002864:	42078793          	addi	a5,a5,1056 # 8000dc80 <kthreads+0x7b0>
    80002868:	8087a703          	lw	a4,-2040(a5)
    8000286c:	80c7a783          	lw	a5,-2036(a5)
    80002870:	40f7073b          	subw	a4,a4,a5
    80002874:	3ff00693          	li	a3,1023
    80002878:	02e6ce63          	blt	a3,a4,800028b4 <_Z20kern_console_putcharc+0x9c>
        console.output[(console.output_w++)%BUFFER_SIZE]=c;
    8000287c:	0017871b          	addiw	a4,a5,1
    80002880:	0000b697          	auipc	a3,0xb
    80002884:	c0e6a623          	sw	a4,-1012(a3) # 8000d48c <console+0x80c>
    80002888:	41f7d71b          	sraiw	a4,a5,0x1f
    8000288c:	0167571b          	srliw	a4,a4,0x16
    80002890:	00f707bb          	addw	a5,a4,a5
    80002894:	3ff7f793          	andi	a5,a5,1023
    80002898:	40e787bb          	subw	a5,a5,a4
    8000289c:	0000a717          	auipc	a4,0xa
    800028a0:	3e470713          	addi	a4,a4,996 # 8000cc80 <console>
    800028a4:	00f707b3          	add	a5,a4,a5
    800028a8:	40a78023          	sb	a0,1024(a5)
    return 0;
    800028ac:	00000513          	li	a0,0
    800028b0:	fa5ff06f          	j	80002854 <_Z20kern_console_putcharc+0x3c>
        if(console.output_r-console.output_w>=BUFFER_SIZE) return -1;
    800028b4:	fff00513          	li	a0,-1
    800028b8:	f9dff06f          	j	80002854 <_Z20kern_console_putcharc+0x3c>

00000000800028bc <_Z8bodyIdlePv>:

Semaphore* semTest;

int idleAlive=1;
void bodyIdle(void* arg){
    while(idleAlive){
    800028bc:	0000a797          	auipc	a5,0xa
    800028c0:	07c7a783          	lw	a5,124(a5) # 8000c938 <idleAlive>
    800028c4:	02078c63          	beqz	a5,800028fc <_Z8bodyIdlePv+0x40>
void bodyIdle(void* arg){
    800028c8:	ff010113          	addi	sp,sp,-16
    800028cc:	00113423          	sd	ra,8(sp)
    800028d0:	00813023          	sd	s0,0(sp)
    800028d4:	01010413          	addi	s0,sp,16
        thread_dispatch();
    800028d8:	fffff097          	auipc	ra,0xfffff
    800028dc:	ab0080e7          	jalr	-1360(ra) # 80001388 <_Z15thread_dispatchv>
    while(idleAlive){
    800028e0:	0000a797          	auipc	a5,0xa
    800028e4:	0587a783          	lw	a5,88(a5) # 8000c938 <idleAlive>
    800028e8:	fe0798e3          	bnez	a5,800028d8 <_Z8bodyIdlePv+0x1c>
    };
}
    800028ec:	00813083          	ld	ra,8(sp)
    800028f0:	00013403          	ld	s0,0(sp)
    800028f4:	01010113          	addi	sp,sp,16
    800028f8:	00008067          	ret
    800028fc:	00008067          	ret

0000000080002900 <_Z5bodyCPv>:

void bodyC(void* arg)
{
    80002900:	fe010113          	addi	sp,sp,-32
    80002904:	00113c23          	sd	ra,24(sp)
    80002908:	00813823          	sd	s0,16(sp)
    8000290c:	00913423          	sd	s1,8(sp)
    80002910:	01213023          	sd	s2,0(sp)
    80002914:	02010413          	addi	s0,sp,32
    80002918:	00050913          	mv	s2,a0
    int counter=0;
    8000291c:	00000493          	li	s1,0
    char*c = (char*)arg;
    while(counter<10){
    80002920:	00900793          	li	a5,9
    80002924:	0297c263          	blt	a5,s1,80002948 <_Z5bodyCPv+0x48>
        //if(++counter>5) delete semTest;
        putc(*c);
    80002928:	00094503          	lbu	a0,0(s2)
    8000292c:	fffff097          	auipc	ra,0xfffff
    80002930:	c84080e7          	jalr	-892(ra) # 800015b0 <_Z4putcc>
        time_sleep(1);
    80002934:	00100513          	li	a0,1
    80002938:	fffff097          	auipc	ra,0xfffff
    8000293c:	c08080e7          	jalr	-1016(ra) # 80001540 <_Z10time_sleepm>
        counter++;
    80002940:	0014849b          	addiw	s1,s1,1
    while(counter<10){
    80002944:	fddff06f          	j	80002920 <_Z5bodyCPv+0x20>
    }
    counter++;
    //thread_exit();
}
    80002948:	01813083          	ld	ra,24(sp)
    8000294c:	01013403          	ld	s0,16(sp)
    80002950:	00813483          	ld	s1,8(sp)
    80002954:	00013903          	ld	s2,0(sp)
    80002958:	02010113          	addi	sp,sp,32
    8000295c:	00008067          	ret

0000000080002960 <_Z5bodyAPv>:

void bodyA(void* arg)
{
    80002960:	fe010113          	addi	sp,sp,-32
    80002964:	00113c23          	sd	ra,24(sp)
    80002968:	00813823          	sd	s0,16(sp)
    8000296c:	00913423          	sd	s1,8(sp)
    80002970:	02010413          	addi	s0,sp,32
    char c = 'a';
    //if(semTest->wait()) c='A';
    for(int i=0;i<10;i++){
    80002974:	00000493          	li	s1,0
    80002978:	0180006f          	j	80002990 <_Z5bodyAPv+0x30>
        putc(c);
        if(i==5) thread_exit();
    8000297c:	fffff097          	auipc	ra,0xfffff
    80002980:	a38080e7          	jalr	-1480(ra) # 800013b4 <_Z11thread_exitv>
        thread_dispatch();
    80002984:	fffff097          	auipc	ra,0xfffff
    80002988:	a04080e7          	jalr	-1532(ra) # 80001388 <_Z15thread_dispatchv>
    for(int i=0;i<10;i++){
    8000298c:	0014849b          	addiw	s1,s1,1
    80002990:	00900793          	li	a5,9
    80002994:	0097ce63          	blt	a5,s1,800029b0 <_Z5bodyAPv+0x50>
        putc(c);
    80002998:	06100513          	li	a0,97
    8000299c:	fffff097          	auipc	ra,0xfffff
    800029a0:	c14080e7          	jalr	-1004(ra) # 800015b0 <_Z4putcc>
        if(i==5) thread_exit();
    800029a4:	00500793          	li	a5,5
    800029a8:	fcf49ee3          	bne	s1,a5,80002984 <_Z5bodyAPv+0x24>
    800029ac:	fd1ff06f          	j	8000297c <_Z5bodyAPv+0x1c>
    }
}
    800029b0:	01813083          	ld	ra,24(sp)
    800029b4:	01013403          	ld	s0,16(sp)
    800029b8:	00813483          	ld	s1,8(sp)
    800029bc:	02010113          	addi	sp,sp,32
    800029c0:	00008067          	ret

00000000800029c4 <_Z5bodyBPv>:

int g=0;

char str[15] = "tesa legenda";
void bodyB(void* arg)
{
    800029c4:	fe010113          	addi	sp,sp,-32
    800029c8:	00113c23          	sd	ra,24(sp)
    800029cc:	00813823          	sd	s0,16(sp)
    800029d0:	00913423          	sd	s1,8(sp)
    800029d4:	02010413          	addi	s0,sp,32

    //time_sleep(10);
    for(int i=0;i<10;i++){
    800029d8:	00000493          	li	s1,0
    800029dc:	0540006f          	j	80002a30 <_Z5bodyBPv+0x6c>
        putc(str[i]);
        for(int k=0;k<10000;k++){
            for(int m=0;m<1000;m++){
    800029e0:	0017071b          	addiw	a4,a4,1
    800029e4:	3e700793          	li	a5,999
    800029e8:	02e7c663          	blt	a5,a4,80002a14 <_Z5bodyBPv+0x50>
                if((m*k)%1337==0) g++;
    800029ec:	02e607bb          	mulw	a5,a2,a4
    800029f0:	53900693          	li	a3,1337
    800029f4:	02d7e7bb          	remw	a5,a5,a3
    800029f8:	fe0794e3          	bnez	a5,800029e0 <_Z5bodyBPv+0x1c>
    800029fc:	0000b697          	auipc	a3,0xb
    80002a00:	a9468693          	addi	a3,a3,-1388 # 8000d490 <g>
    80002a04:	0006a783          	lw	a5,0(a3)
    80002a08:	0017879b          	addiw	a5,a5,1
    80002a0c:	00f6a023          	sw	a5,0(a3)
    80002a10:	fd1ff06f          	j	800029e0 <_Z5bodyBPv+0x1c>
        for(int k=0;k<10000;k++){
    80002a14:	0016061b          	addiw	a2,a2,1
    80002a18:	000027b7          	lui	a5,0x2
    80002a1c:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    80002a20:	00c7c663          	blt	a5,a2,80002a2c <_Z5bodyBPv+0x68>
            for(int m=0;m<1000;m++){
    80002a24:	00000713          	li	a4,0
    80002a28:	fbdff06f          	j	800029e4 <_Z5bodyBPv+0x20>
    for(int i=0;i<10;i++){
    80002a2c:	0014849b          	addiw	s1,s1,1
    80002a30:	00900793          	li	a5,9
    80002a34:	0297c263          	blt	a5,s1,80002a58 <_Z5bodyBPv+0x94>
        putc(str[i]);
    80002a38:	0000a797          	auipc	a5,0xa
    80002a3c:	f0078793          	addi	a5,a5,-256 # 8000c938 <idleAlive>
    80002a40:	009787b3          	add	a5,a5,s1
    80002a44:	0087c503          	lbu	a0,8(a5)
    80002a48:	fffff097          	auipc	ra,0xfffff
    80002a4c:	b68080e7          	jalr	-1176(ra) # 800015b0 <_Z4putcc>
        for(int k=0;k<10000;k++){
    80002a50:	00000613          	li	a2,0
    80002a54:	fc5ff06f          	j	80002a18 <_Z5bodyBPv+0x54>
        }
        int wait (){
            return sem_wait(myHandle);
        }
        int signal (){
            return sem_signal(myHandle);
    80002a58:	0000b797          	auipc	a5,0xb
    80002a5c:	a407b783          	ld	a5,-1472(a5) # 8000d498 <semTest>
    80002a60:	0087b503          	ld	a0,8(a5)
    80002a64:	fffff097          	auipc	ra,0xfffff
    80002a68:	a9c080e7          	jalr	-1380(ra) # 80001500 <_Z10sem_signalP5sem_s>
            }
        }
    }
    semTest->signal();
}
    80002a6c:	01813083          	ld	ra,24(sp)
    80002a70:	01013403          	ld	s0,16(sp)
    80002a74:	00813483          	ld	s1,8(sp)
    80002a78:	02010113          	addi	sp,sp,32
    80002a7c:	00008067          	ret

0000000080002a80 <main>:
        putc(c++);
    }
};

int main()
{
    80002a80:	fe010113          	addi	sp,sp,-32
    80002a84:	00113c23          	sd	ra,24(sp)
    80002a88:	00813823          	sd	s0,16(sp)
    80002a8c:	02010413          	addi	s0,sp,32
    kern_thread_init();
    80002a90:	00000097          	auipc	ra,0x0
    80002a94:	190080e7          	jalr	400(ra) # 80002c20 <_Z16kern_thread_initv>

    kern_mem_init((void*)HEAP_START_ADDR, (void*)HEAP_END_ADDR);
    80002a98:	0000a797          	auipc	a5,0xa
    80002a9c:	0d87b783          	ld	a5,216(a5) # 8000cb70 <_GLOBAL_OFFSET_TABLE_+0x40>
    80002aa0:	0007b583          	ld	a1,0(a5)
    80002aa4:	0000a797          	auipc	a5,0xa
    80002aa8:	0a47b783          	ld	a5,164(a5) # 8000cb48 <_GLOBAL_OFFSET_TABLE_+0x18>
    80002aac:	0007b503          	ld	a0,0(a5)
    80002ab0:	00000097          	auipc	ra,0x0
    80002ab4:	b24080e7          	jalr	-1244(ra) # 800025d4 <_Z13kern_mem_initPvS_>
    kern_interrupt_init();
    80002ab8:	00001097          	auipc	ra,0x1
    80002abc:	9bc080e7          	jalr	-1604(ra) # 80003474 <_Z19kern_interrupt_initv>
    kern_sem_init();
    80002ac0:	00000097          	auipc	ra,0x0
    80002ac4:	768080e7          	jalr	1896(ra) # 80003228 <_Z13kern_sem_initv>
    kern_console_init();
    80002ac8:	00000097          	auipc	ra,0x0
    80002acc:	b78080e7          	jalr	-1160(ra) # 80002640 <_Z17kern_console_initv>

    Thread* thrIdle = new Thread(&bodyIdle,0);
    80002ad0:	02000513          	li	a0,32
    80002ad4:	00000097          	auipc	ra,0x0
    80002ad8:	0fc080e7          	jalr	252(ra) # 80002bd0 <_Znwm>
        {
    80002adc:	0000a797          	auipc	a5,0xa
    80002ae0:	e8478793          	addi	a5,a5,-380 # 8000c960 <_ZTV6Thread+0x10>
    80002ae4:	00f53023          	sd	a5,0(a0)
            this->body=body;
    80002ae8:	00000597          	auipc	a1,0x0
    80002aec:	dd458593          	addi	a1,a1,-556 # 800028bc <_Z8bodyIdlePv>
    80002af0:	00b53823          	sd	a1,16(a0)
            this->arg=arg;
    80002af4:	00053c23          	sd	zero,24(a0)
    80002af8:	fea43423          	sd	a0,-24(s0)
            else return thread_create(&myHandle,body,arg);
    80002afc:	00000613          	li	a2,0
    80002b00:	00850513          	addi	a0,a0,8
    80002b04:	ffffe097          	auipc	ra,0xffffe
    80002b08:	7fc080e7          	jalr	2044(ra) # 80001300 <_Z13thread_createPP8thread_sPFvPvES2_>
    thrIdle->start();

    printf("Printf proba %d valjda radi %x, %p\n", &thrIdle, &thrIdle, &thrIdle);
    80002b0c:	fe840593          	addi	a1,s0,-24
    80002b10:	00058693          	mv	a3,a1
    80002b14:	00058613          	mv	a2,a1
    80002b18:	00007517          	auipc	a0,0x7
    80002b1c:	69050513          	addi	a0,a0,1680 # 8000a1a8 <CONSOLE_STATUS+0x198>
    80002b20:	fffff097          	auipc	ra,0xfffff
    80002b24:	774080e7          	jalr	1908(ra) # 80002294 <_Z6printfPKcz>
*/
    /*char x = getc();
    x=getc();
    x++;
    putc(x);*/
    userMain();
    80002b28:	00004097          	auipc	ra,0x4
    80002b2c:	130080e7          	jalr	304(ra) # 80006c58 <_Z8userMainv>
    }

    pt->terminate();
    pt2->terminate();
    */
    idleAlive=0;
    80002b30:	0000a797          	auipc	a5,0xa
    80002b34:	e007a423          	sw	zero,-504(a5) # 8000c938 <idleAlive>
    return 0;
    80002b38:	00000513          	li	a0,0
    80002b3c:	01813083          	ld	ra,24(sp)
    80002b40:	01013403          	ld	s0,16(sp)
    80002b44:	02010113          	addi	sp,sp,32
    80002b48:	00008067          	ret

0000000080002b4c <_ZN6ThreadD1Ev>:
        virtual ~Thread (){
    80002b4c:	ff010113          	addi	sp,sp,-16
    80002b50:	00813423          	sd	s0,8(sp)
    80002b54:	01010413          	addi	s0,sp,16
        }
    80002b58:	00813403          	ld	s0,8(sp)
    80002b5c:	01010113          	addi	sp,sp,16
    80002b60:	00008067          	ret

0000000080002b64 <_ZN6Thread3runEv>:
        virtual void run () {}
    80002b64:	ff010113          	addi	sp,sp,-16
    80002b68:	00813423          	sd	s0,8(sp)
    80002b6c:	01010413          	addi	s0,sp,16
    80002b70:	00813403          	ld	s0,8(sp)
    80002b74:	01010113          	addi	sp,sp,16
    80002b78:	00008067          	ret

0000000080002b7c <_ZN6Thread11threadEntryEPv>:
        static void threadEntry(void* arg){
    80002b7c:	ff010113          	addi	sp,sp,-16
    80002b80:	00113423          	sd	ra,8(sp)
    80002b84:	00813023          	sd	s0,0(sp)
    80002b88:	01010413          	addi	s0,sp,16
            self->run();
    80002b8c:	00053783          	ld	a5,0(a0)
    80002b90:	0107b783          	ld	a5,16(a5)
    80002b94:	000780e7          	jalr	a5
        }
    80002b98:	00813083          	ld	ra,8(sp)
    80002b9c:	00013403          	ld	s0,0(sp)
    80002ba0:	01010113          	addi	sp,sp,16
    80002ba4:	00008067          	ret

0000000080002ba8 <_ZN6ThreadD0Ev>:
        virtual ~Thread (){
    80002ba8:	ff010113          	addi	sp,sp,-16
    80002bac:	00113423          	sd	ra,8(sp)
    80002bb0:	00813023          	sd	s0,0(sp)
    80002bb4:	01010413          	addi	s0,sp,16
        }
    80002bb8:	00000097          	auipc	ra,0x0
    80002bbc:	040080e7          	jalr	64(ra) # 80002bf8 <_ZdlPv>
    80002bc0:	00813083          	ld	ra,8(sp)
    80002bc4:	00013403          	ld	s0,0(sp)
    80002bc8:	01010113          	addi	sp,sp,16
    80002bcc:	00008067          	ret

0000000080002bd0 <_Znwm>:
// Created by os on 6/7/23.
//
#include "../h/syscall_cpp.hpp"


void* operator new(size_t size) {
    80002bd0:	ff010113          	addi	sp,sp,-16
    80002bd4:	00113423          	sd	ra,8(sp)
    80002bd8:	00813023          	sd	s0,0(sp)
    80002bdc:	01010413          	addi	s0,sp,16
    void* ptr = mem_alloc(size);
    80002be0:	ffffe097          	auipc	ra,0xffffe
    80002be4:	6a0080e7          	jalr	1696(ra) # 80001280 <_Z9mem_allocm>
    return ptr;
}
    80002be8:	00813083          	ld	ra,8(sp)
    80002bec:	00013403          	ld	s0,0(sp)
    80002bf0:	01010113          	addi	sp,sp,16
    80002bf4:	00008067          	ret

0000000080002bf8 <_ZdlPv>:

void operator delete(void* ptr) {
    80002bf8:	ff010113          	addi	sp,sp,-16
    80002bfc:	00113423          	sd	ra,8(sp)
    80002c00:	00813023          	sd	s0,0(sp)
    80002c04:	01010413          	addi	s0,sp,16
    mem_free(ptr);
    80002c08:	ffffe097          	auipc	ra,0xffffe
    80002c0c:	6b8080e7          	jalr	1720(ra) # 800012c0 <_Z8mem_freePv>
}
    80002c10:	00813083          	ld	ra,8(sp)
    80002c14:	00013403          	ld	s0,0(sp)
    80002c18:	01010113          	addi	sp,sp,16
    80002c1c:	00008067          	ret

0000000080002c20 <_Z16kern_thread_initv>:
} scheduler;

void kern_thread_yield();

void kern_thread_init()
{
    80002c20:	ff010113          	addi	sp,sp,-16
    80002c24:	00813423          	sd	s0,8(sp)
    80002c28:	01010413          	addi	s0,sp,16
    id=0;
    80002c2c:	0000b797          	auipc	a5,0xb
    80002c30:	8607aa23          	sw	zero,-1932(a5) # 8000d4a0 <_ZL2id>
    for (int i=0;i<MAX_THREADS;i++){
    80002c34:	00000793          	li	a5,0
    80002c38:	03f00713          	li	a4,63
    80002c3c:	02f74263          	blt	a4,a5,80002c60 <_Z16kern_thread_initv+0x40>
        kthreads[i].status=UNUSED;
    80002c40:	06800713          	li	a4,104
    80002c44:	02e786b3          	mul	a3,a5,a4
    80002c48:	0000b717          	auipc	a4,0xb
    80002c4c:	88870713          	addi	a4,a4,-1912 # 8000d4d0 <kthreads>
    80002c50:	00d70733          	add	a4,a4,a3
    80002c54:	04072823          	sw	zero,80(a4)
    for (int i=0;i<MAX_THREADS;i++){
    80002c58:	0017879b          	addiw	a5,a5,1
    80002c5c:	fddff06f          	j	80002c38 <_Z16kern_thread_initv+0x18>
    }

    //set kthreads[0] as main thread
    kthreads[0].status=RUNNING;
    80002c60:	0000b797          	auipc	a5,0xb
    80002c64:	87078793          	addi	a5,a5,-1936 # 8000d4d0 <kthreads>
    80002c68:	00100713          	li	a4,1
    80002c6c:	04e7a823          	sw	a4,80(a5)
    kthreads[0].id=0;
    80002c70:	0007b823          	sd	zero,16(a5)
    kthreads[0].timeslice=DEFAULT_TIME_SLICE+2;
    80002c74:	00400713          	li	a4,4
    80002c78:	02e7b823          	sd	a4,48(a5)
    kthreads[0].endTime=0;
    80002c7c:	0207bc23          	sd	zero,56(a5)
    kthreads[0].next_thread=0;
    80002c80:	0607b023          	sd	zero,96(a5)
    running=&kthreads[0];
    80002c84:	0000b717          	auipc	a4,0xb
    80002c88:	81c70713          	addi	a4,a4,-2020 # 8000d4a0 <_ZL2id>
    80002c8c:	00f73423          	sd	a5,8(a4)
    scheduler.ready_head=0;
    80002c90:	00073823          	sd	zero,16(a4)
    scheduler.ready_tail=0;
    80002c94:	00073c23          	sd	zero,24(a4)
    scheduler.joined_head=0;
    80002c98:	02073023          	sd	zero,32(a4)
    scheduler.sleeping_head=0;
    80002c9c:	02073423          	sd	zero,40(a4)
}
    80002ca0:	00813403          	ld	s0,8(sp)
    80002ca4:	01010113          	addi	sp,sp,16
    80002ca8:	00008067          	ret

0000000080002cac <_Z18kern_scheduler_putP8thread_s>:

void kern_scheduler_put(thread_t t)
{
    80002cac:	ff010113          	addi	sp,sp,-16
    80002cb0:	00813423          	sd	s0,8(sp)
    80002cb4:	01010413          	addi	s0,sp,16
    t->status=READY;
    80002cb8:	00200793          	li	a5,2
    80002cbc:	04f52823          	sw	a5,80(a0)
    if(scheduler.ready_tail==0){
    80002cc0:	0000a797          	auipc	a5,0xa
    80002cc4:	7f87b783          	ld	a5,2040(a5) # 8000d4b8 <scheduler+0x8>
    80002cc8:	02078063          	beqz	a5,80002ce8 <_Z18kern_scheduler_putP8thread_s+0x3c>
        scheduler.ready_tail=t;
        scheduler.ready_head=t;
    } else{
        scheduler.ready_tail->next_thread=t;
    80002ccc:	06a7b023          	sd	a0,96(a5)
        scheduler.ready_tail=t;
    80002cd0:	0000a797          	auipc	a5,0xa
    80002cd4:	7ea7b423          	sd	a0,2024(a5) # 8000d4b8 <scheduler+0x8>
    }
    t->next_thread=0;
    80002cd8:	06053023          	sd	zero,96(a0)
}
    80002cdc:	00813403          	ld	s0,8(sp)
    80002ce0:	01010113          	addi	sp,sp,16
    80002ce4:	00008067          	ret
        scheduler.ready_tail=t;
    80002ce8:	0000a797          	auipc	a5,0xa
    80002cec:	7b878793          	addi	a5,a5,1976 # 8000d4a0 <_ZL2id>
    80002cf0:	00a7bc23          	sd	a0,24(a5)
        scheduler.ready_head=t;
    80002cf4:	00a7b823          	sd	a0,16(a5)
    80002cf8:	fe1ff06f          	j	80002cd8 <_Z18kern_scheduler_putP8thread_s+0x2c>

0000000080002cfc <_Z18kern_scheduler_getv>:


thread_t kern_scheduler_get()
{
    80002cfc:	ff010113          	addi	sp,sp,-16
    80002d00:	00813423          	sd	s0,8(sp)
    80002d04:	01010413          	addi	s0,sp,16
    if(scheduler.ready_head==0) return 0;
    80002d08:	0000a517          	auipc	a0,0xa
    80002d0c:	7a853503          	ld	a0,1960(a0) # 8000d4b0 <scheduler>
    80002d10:	02050063          	beqz	a0,80002d30 <_Z18kern_scheduler_getv+0x34>
    thread_t t = scheduler.ready_head;
    scheduler.ready_head=scheduler.ready_head->next_thread;
    80002d14:	06053703          	ld	a4,96(a0)
    80002d18:	0000a797          	auipc	a5,0xa
    80002d1c:	78878793          	addi	a5,a5,1928 # 8000d4a0 <_ZL2id>
    80002d20:	00e7b823          	sd	a4,16(a5)
    if(scheduler.ready_tail==t) scheduler.ready_tail=0;
    80002d24:	0187b783          	ld	a5,24(a5)
    80002d28:	00f50a63          	beq	a0,a5,80002d3c <_Z18kern_scheduler_getv+0x40>
    t->next_thread=0;
    80002d2c:	06053023          	sd	zero,96(a0)
    return t;
}
    80002d30:	00813403          	ld	s0,8(sp)
    80002d34:	01010113          	addi	sp,sp,16
    80002d38:	00008067          	ret
    if(scheduler.ready_tail==t) scheduler.ready_tail=0;
    80002d3c:	0000a797          	auipc	a5,0xa
    80002d40:	7607be23          	sd	zero,1916(a5) # 8000d4b8 <scheduler+0x8>
    80002d44:	fe9ff06f          	j	80002d2c <_Z18kern_scheduler_getv+0x30>

0000000080002d48 <_Z10popSppSpiev>:
    w_sepc(v_sepc);
}

//samo izlazi iz kernela i vraca se odakle je pozvana
void popSppSpie()
{
    80002d48:	ff010113          	addi	sp,sp,-16
    80002d4c:	00813423          	sd	s0,8(sp)
    80002d50:	01010413          	addi	s0,sp,16
    __asm__ volatile("csrw sepc, ra"); //ovde dodaj izlazak iz privilegovanog moda
    80002d54:	14109073          	csrw	sepc,ra
    __asm__ volatile("csrc sstatus, %[mask]" : : [mask] "r"(1 << 8));
    80002d58:	10000793          	li	a5,256
    80002d5c:	1007b073          	csrc	sstatus,a5
    __asm__ volatile("sret");
    80002d60:	10200073          	sret
}
    80002d64:	00813403          	ld	s0,8(sp)
    80002d68:	01010113          	addi	sp,sp,16
    80002d6c:	00008067          	ret

0000000080002d70 <_Z19kern_thread_wrapperv>:
        contextSwitch(old,running);
    }
}

void kern_thread_wrapper()
{
    80002d70:	ff010113          	addi	sp,sp,-16
    80002d74:	00113423          	sd	ra,8(sp)
    80002d78:	00813023          	sd	s0,0(sp)
    80002d7c:	01010413          	addi	s0,sp,16
    popSppSpie();
    80002d80:	00000097          	auipc	ra,0x0
    80002d84:	fc8080e7          	jalr	-56(ra) # 80002d48 <_Z10popSppSpiev>
    running->body(running->arg);
    80002d88:	0000a797          	auipc	a5,0xa
    80002d8c:	7207b783          	ld	a5,1824(a5) # 8000d4a8 <running>
    80002d90:	0187b703          	ld	a4,24(a5)
    80002d94:	0207b503          	ld	a0,32(a5)
    80002d98:	000700e7          	jalr	a4
    running->joined_tid=-1;
    for(int i=0;i<MAX_THREADS;i++){
        if(kthreads[i].status==JOINED && kthreads[i].joined_tid==running->id) kthreads[i].status=READY;
    }
*/
    thread_exit();
    80002d9c:	ffffe097          	auipc	ra,0xffffe
    80002da0:	618080e7          	jalr	1560(ra) # 800013b4 <_Z11thread_exitv>
}
    80002da4:	00813083          	ld	ra,8(sp)
    80002da8:	00013403          	ld	s0,0(sp)
    80002dac:	01010113          	addi	sp,sp,16
    80002db0:	00008067          	ret

0000000080002db4 <_Z17kern_thread_yieldv>:
{
    80002db4:	fe010113          	addi	sp,sp,-32
    80002db8:	00113c23          	sd	ra,24(sp)
    80002dbc:	00813823          	sd	s0,16(sp)
    80002dc0:	00913423          	sd	s1,8(sp)
    80002dc4:	01213023          	sd	s2,0(sp)
    80002dc8:	02010413          	addi	s0,sp,32
    thread_t old = running;
    80002dcc:	0000a917          	auipc	s2,0xa
    80002dd0:	6d490913          	addi	s2,s2,1748 # 8000d4a0 <_ZL2id>
    80002dd4:	00893483          	ld	s1,8(s2)
    running=kern_scheduler_get();
    80002dd8:	00000097          	auipc	ra,0x0
    80002ddc:	f24080e7          	jalr	-220(ra) # 80002cfc <_Z18kern_scheduler_getv>
    80002de0:	00a93423          	sd	a0,8(s2)
    if(old!=running){
    80002de4:	04950663          	beq	a0,s1,80002e30 <_Z17kern_thread_yieldv+0x7c>
    80002de8:	00050593          	mv	a1,a0
        running->status=RUNNING;
    80002dec:	00100793          	li	a5,1
    80002df0:	04f52823          	sw	a5,80(a0)
        if(old->status==RUNNING) old->status=READY;
    80002df4:	0504a703          	lw	a4,80(s1)
    80002df8:	00100793          	li	a5,1
    80002dfc:	02f70463          	beq	a4,a5,80002e24 <_Z17kern_thread_yieldv+0x70>
        contextSwitch(old,running);
    80002e00:	00048513          	mv	a0,s1
    80002e04:	ffffe097          	auipc	ra,0xffffe
    80002e08:	468080e7          	jalr	1128(ra) # 8000126c <contextSwitch>
}
    80002e0c:	01813083          	ld	ra,24(sp)
    80002e10:	01013403          	ld	s0,16(sp)
    80002e14:	00813483          	ld	s1,8(sp)
    80002e18:	00013903          	ld	s2,0(sp)
    80002e1c:	02010113          	addi	sp,sp,32
    80002e20:	00008067          	ret
        if(old->status==RUNNING) old->status=READY;
    80002e24:	00200793          	li	a5,2
    80002e28:	04f4a823          	sw	a5,80(s1)
    80002e2c:	fd5ff06f          	j	80002e00 <_Z17kern_thread_yieldv+0x4c>
        old->status=RUNNING;
    80002e30:	00100793          	li	a5,1
    80002e34:	04f4a823          	sw	a5,80(s1)
}
    80002e38:	fd5ff06f          	j	80002e0c <_Z17kern_thread_yieldv+0x58>

0000000080002e3c <_Z20kern_thread_dispatchv>:
{
    80002e3c:	fd010113          	addi	sp,sp,-48
    80002e40:	02113423          	sd	ra,40(sp)
    80002e44:	02813023          	sd	s0,32(sp)
    80002e48:	03010413          	addi	s0,sp,48
    kern_scheduler_put(running);
    80002e4c:	0000a517          	auipc	a0,0xa
    80002e50:	65c53503          	ld	a0,1628(a0) # 8000d4a8 <running>
    80002e54:	00000097          	auipc	ra,0x0
    80002e58:	e58080e7          	jalr	-424(ra) # 80002cac <_Z18kern_scheduler_putP8thread_s>
}

inline uint64 r_sstatus()
{
    uint64 volatile sstatus;
    __asm__ volatile ("csrr %[sstatus], sstatus" : [sstatus] "=r"(sstatus));
    80002e5c:	100027f3          	csrr	a5,sstatus
    80002e60:	fcf43c23          	sd	a5,-40(s0)
    return sstatus;
    80002e64:	fd843783          	ld	a5,-40(s0)
    uint64 volatile sstatus = r_sstatus();
    80002e68:	fef43423          	sd	a5,-24(s0)
    __asm__ volatile ("csrr %[sepc], sepc" : [sepc] "=r"(sepc));
    80002e6c:	141027f3          	csrr	a5,sepc
    80002e70:	fcf43823          	sd	a5,-48(s0)
    return sepc;
    80002e74:	fd043783          	ld	a5,-48(s0)
    uint64 volatile v_sepc = r_sepc();
    80002e78:	fef43023          	sd	a5,-32(s0)
    kern_thread_yield();
    80002e7c:	00000097          	auipc	ra,0x0
    80002e80:	f38080e7          	jalr	-200(ra) # 80002db4 <_Z17kern_thread_yieldv>
    w_sstatus(sstatus);
    80002e84:	fe843783          	ld	a5,-24(s0)
}

inline void w_sstatus(uint64 sstatus)
{
    __asm__ volatile ("csrw sstatus, %[sstatus]" : : [sstatus] "r"(sstatus));
    80002e88:	10079073          	csrw	sstatus,a5
    w_sepc(v_sepc);
    80002e8c:	fe043783          	ld	a5,-32(s0)
    __asm__ volatile ("csrw sepc, %[sepc]" : : [sepc] "r"(sepc));
    80002e90:	14179073          	csrw	sepc,a5
}
    80002e94:	02813083          	ld	ra,40(sp)
    80002e98:	02013403          	ld	s0,32(sp)
    80002e9c:	03010113          	addi	sp,sp,48
    80002ea0:	00008067          	ret

0000000080002ea4 <_Z23kern_thread_end_runningv>:
{
    80002ea4:	fe010113          	addi	sp,sp,-32
    80002ea8:	00113c23          	sd	ra,24(sp)
    80002eac:	00813823          	sd	s0,16(sp)
    80002eb0:	00913423          	sd	s1,8(sp)
    80002eb4:	01213023          	sd	s2,0(sp)
    80002eb8:	02010413          	addi	s0,sp,32
    thread_t old = running;
    80002ebc:	0000a917          	auipc	s2,0xa
    80002ec0:	5ec93903          	ld	s2,1516(s2) # 8000d4a8 <running>
    old->status=UNUSED;
    80002ec4:	04092823          	sw	zero,80(s2)
    for(int i=0;i<MAX_THREADS;i++){
    80002ec8:	00000493          	li	s1,0
    80002ecc:	02c0006f          	j	80002ef8 <_Z23kern_thread_end_runningv+0x54>
            kthreads[i].status=READY;
    80002ed0:	06800513          	li	a0,104
    80002ed4:	02a487b3          	mul	a5,s1,a0
    80002ed8:	0000a517          	auipc	a0,0xa
    80002edc:	5f850513          	addi	a0,a0,1528 # 8000d4d0 <kthreads>
    80002ee0:	00f50533          	add	a0,a0,a5
    80002ee4:	00200793          	li	a5,2
    80002ee8:	04f52823          	sw	a5,80(a0)
            kern_scheduler_put(&kthreads[i]);
    80002eec:	00000097          	auipc	ra,0x0
    80002ef0:	dc0080e7          	jalr	-576(ra) # 80002cac <_Z18kern_scheduler_putP8thread_s>
    for(int i=0;i<MAX_THREADS;i++){
    80002ef4:	0014849b          	addiw	s1,s1,1
    80002ef8:	03f00793          	li	a5,63
    80002efc:	0497c463          	blt	a5,s1,80002f44 <_Z23kern_thread_end_runningv+0xa0>
        if(kthreads[i].status==JOINED && kthreads[i].joined_tid==old->id) {
    80002f00:	06800793          	li	a5,104
    80002f04:	02f48733          	mul	a4,s1,a5
    80002f08:	0000a797          	auipc	a5,0xa
    80002f0c:	5c878793          	addi	a5,a5,1480 # 8000d4d0 <kthreads>
    80002f10:	00e787b3          	add	a5,a5,a4
    80002f14:	0507a703          	lw	a4,80(a5)
    80002f18:	00400793          	li	a5,4
    80002f1c:	fcf71ce3          	bne	a4,a5,80002ef4 <_Z23kern_thread_end_runningv+0x50>
    80002f20:	06800793          	li	a5,104
    80002f24:	02f48733          	mul	a4,s1,a5
    80002f28:	0000a797          	auipc	a5,0xa
    80002f2c:	5a878793          	addi	a5,a5,1448 # 8000d4d0 <kthreads>
    80002f30:	00e787b3          	add	a5,a5,a4
    80002f34:	0287b703          	ld	a4,40(a5)
    80002f38:	01093783          	ld	a5,16(s2)
    80002f3c:	faf71ce3          	bne	a4,a5,80002ef4 <_Z23kern_thread_end_runningv+0x50>
    80002f40:	f91ff06f          	j	80002ed0 <_Z23kern_thread_end_runningv+0x2c>
    running=kern_scheduler_get();
    80002f44:	00000097          	auipc	ra,0x0
    80002f48:	db8080e7          	jalr	-584(ra) # 80002cfc <_Z18kern_scheduler_getv>
    80002f4c:	0000a797          	auipc	a5,0xa
    80002f50:	54a7be23          	sd	a0,1372(a5) # 8000d4a8 <running>
    if(old->stack_space!=0) kern_mem_free((void*)old->stack_space);
    80002f54:	04093503          	ld	a0,64(s2)
    80002f58:	02051a63          	bnez	a0,80002f8c <_Z23kern_thread_end_runningv+0xe8>
    if(old!=running){
    80002f5c:	0000a597          	auipc	a1,0xa
    80002f60:	54c5b583          	ld	a1,1356(a1) # 8000d4a8 <running>
    80002f64:	01258863          	beq	a1,s2,80002f74 <_Z23kern_thread_end_runningv+0xd0>
        contextSwitch(old,running);
    80002f68:	00090513          	mv	a0,s2
    80002f6c:	ffffe097          	auipc	ra,0xffffe
    80002f70:	300080e7          	jalr	768(ra) # 8000126c <contextSwitch>
}
    80002f74:	01813083          	ld	ra,24(sp)
    80002f78:	01013403          	ld	s0,16(sp)
    80002f7c:	00813483          	ld	s1,8(sp)
    80002f80:	00013903          	ld	s2,0(sp)
    80002f84:	02010113          	addi	sp,sp,32
    80002f88:	00008067          	ret
    if(old->stack_space!=0) kern_mem_free((void*)old->stack_space);
    80002f8c:	fffff097          	auipc	ra,0xfffff
    80002f90:	598080e7          	jalr	1432(ra) # 80002524 <_Z13kern_mem_freePv>
    80002f94:	fc9ff06f          	j	80002f5c <_Z23kern_thread_end_runningv+0xb8>

0000000080002f98 <_Z18kern_thread_createPP8thread_sPFvPvES2_S2_>:

int kern_thread_create(thread_t* handle, void(*start_routine)(void*), void* arg, void* stack_space)
{
    80002f98:	00050893          	mv	a7,a0
    *handle=0;
    80002f9c:	00053023          	sd	zero,0(a0)
    thread_t t=&kthreads[0]; //dodela da bismo sklonili upozorenje
    for(int i=0;i<MAX_THREADS;i++){
    80002fa0:	00000793          	li	a5,0
    80002fa4:	03f00713          	li	a4,63
    80002fa8:	0cf74863          	blt	a4,a5,80003078 <_Z18kern_thread_createPP8thread_sPFvPvES2_S2_+0xe0>
        if(kthreads[i].status==UNUSED){
    80002fac:	06800713          	li	a4,104
    80002fb0:	02e78833          	mul	a6,a5,a4
    80002fb4:	0000a717          	auipc	a4,0xa
    80002fb8:	51c70713          	addi	a4,a4,1308 # 8000d4d0 <kthreads>
    80002fbc:	01070733          	add	a4,a4,a6
    80002fc0:	05072703          	lw	a4,80(a4)
    80002fc4:	00070663          	beqz	a4,80002fd0 <_Z18kern_thread_createPP8thread_sPFvPvES2_S2_+0x38>
    for(int i=0;i<MAX_THREADS;i++){
    80002fc8:	0017879b          	addiw	a5,a5,1
    80002fcc:	fd9ff06f          	j	80002fa4 <_Z18kern_thread_createPP8thread_sPFvPvES2_S2_+0xc>
            *handle=&kthreads[i];
    80002fd0:	0000a517          	auipc	a0,0xa
    80002fd4:	50050513          	addi	a0,a0,1280 # 8000d4d0 <kthreads>
    80002fd8:	00a80533          	add	a0,a6,a0
    80002fdc:	00a8b023          	sd	a0,0(a7)
            t=&kthreads[i];
            break;
        }
    }
    if(*handle==0) return -1;
    80002fe0:	0008b783          	ld	a5,0(a7)
    80002fe4:	0a078063          	beqz	a5,80003084 <_Z18kern_thread_createPP8thread_sPFvPvES2_S2_+0xec>
{
    80002fe8:	ff010113          	addi	sp,sp,-16
    80002fec:	00113423          	sd	ra,8(sp)
    80002ff0:	00813023          	sd	s0,0(sp)
    80002ff4:	01010413          	addi	s0,sp,16

    t->id=++id;
    80002ff8:	0000a717          	auipc	a4,0xa
    80002ffc:	4a870713          	addi	a4,a4,1192 # 8000d4a0 <_ZL2id>
    80003000:	00072783          	lw	a5,0(a4)
    80003004:	0017879b          	addiw	a5,a5,1
    80003008:	0007881b          	sext.w	a6,a5
    8000300c:	00f72023          	sw	a5,0(a4)
    80003010:	01053823          	sd	a6,16(a0)
    t->status=READY;
    80003014:	00200793          	li	a5,2
    80003018:	04f52823          	sw	a5,80(a0)
    t->arg=arg;
    8000301c:	02c53023          	sd	a2,32(a0)
    t->joined_tid=-1;
    80003020:	fff00793          	li	a5,-1
    80003024:	02f53423          	sd	a5,40(a0)
    t->timeslice=DEFAULT_TIME_SLICE;
    80003028:	00200793          	li	a5,2
    8000302c:	02f53823          	sd	a5,48(a0)
    t->body=start_routine;
    80003030:	00b53c23          	sd	a1,24(a0)
    t->stack_space = ((uint64)stack_space);
    80003034:	04d53023          	sd	a3,64(a0)
    t->sp = t->stack_space+(DEFAULT_STACK_SIZE);
    80003038:	000017b7          	lui	a5,0x1
    8000303c:	00f686b3          	add	a3,a3,a5
    80003040:	00d53423          	sd	a3,8(a0)
    t->ra=(uint64) &kern_thread_wrapper;
    80003044:	00000797          	auipc	a5,0x0
    80003048:	d2c78793          	addi	a5,a5,-724 # 80002d70 <_Z19kern_thread_wrapperv>
    8000304c:	00f53023          	sd	a5,0(a0)
    t->sem_next=0;
    80003050:	04053c23          	sd	zero,88(a0)
    t->next_thread=0;
    80003054:	06053023          	sd	zero,96(a0)
    t->mailbox=0;
    80003058:	04053423          	sd	zero,72(a0)
    kern_scheduler_put(t);
    8000305c:	00000097          	auipc	ra,0x0
    80003060:	c50080e7          	jalr	-944(ra) # 80002cac <_Z18kern_scheduler_putP8thread_s>

    return 0;
    80003064:	00000513          	li	a0,0
}
    80003068:	00813083          	ld	ra,8(sp)
    8000306c:	00013403          	ld	s0,0(sp)
    80003070:	01010113          	addi	sp,sp,16
    80003074:	00008067          	ret
    thread_t t=&kthreads[0]; //dodela da bismo sklonili upozorenje
    80003078:	0000a517          	auipc	a0,0xa
    8000307c:	45850513          	addi	a0,a0,1112 # 8000d4d0 <kthreads>
    80003080:	f61ff06f          	j	80002fe0 <_Z18kern_thread_createPP8thread_sPFvPvES2_S2_+0x48>
    if(*handle==0) return -1;
    80003084:	fff00513          	li	a0,-1
}
    80003088:	00008067          	ret

000000008000308c <_Z16kern_thread_joinP8thread_s>:

void kern_thread_join(thread_t handle)
{
    if(handle->status==UNUSED) return;
    8000308c:	05052783          	lw	a5,80(a0)
    80003090:	00079463          	bnez	a5,80003098 <_Z16kern_thread_joinP8thread_s+0xc>
    80003094:	00008067          	ret
{
    80003098:	fd010113          	addi	sp,sp,-48
    8000309c:	02113423          	sd	ra,40(sp)
    800030a0:	02813023          	sd	s0,32(sp)
    800030a4:	03010413          	addi	s0,sp,48
    running->joined_tid=handle->id;
    800030a8:	0000a717          	auipc	a4,0xa
    800030ac:	3f870713          	addi	a4,a4,1016 # 8000d4a0 <_ZL2id>
    800030b0:	00873783          	ld	a5,8(a4)
    800030b4:	01053683          	ld	a3,16(a0)
    800030b8:	02d7b423          	sd	a3,40(a5)
    running->status=JOINED;
    800030bc:	00400693          	li	a3,4
    800030c0:	04d7a823          	sw	a3,80(a5)
    running->next_thread=scheduler.joined_head;
    800030c4:	02073683          	ld	a3,32(a4)
    800030c8:	06d7b023          	sd	a3,96(a5)
    scheduler.joined_head=running;
    800030cc:	02f73023          	sd	a5,32(a4)
    __asm__ volatile ("csrr %[sstatus], sstatus" : [sstatus] "=r"(sstatus));
    800030d0:	100027f3          	csrr	a5,sstatus
    800030d4:	fcf43c23          	sd	a5,-40(s0)
    return sstatus;
    800030d8:	fd843783          	ld	a5,-40(s0)
    uint64 volatile sstatus = r_sstatus();
    800030dc:	fef43423          	sd	a5,-24(s0)
    __asm__ volatile ("csrr %[sepc], sepc" : [sepc] "=r"(sepc));
    800030e0:	141027f3          	csrr	a5,sepc
    800030e4:	fcf43823          	sd	a5,-48(s0)
    return sepc;
    800030e8:	fd043783          	ld	a5,-48(s0)
    uint64 volatile v_sepc = r_sepc();
    800030ec:	fef43023          	sd	a5,-32(s0)
    kern_thread_yield();
    800030f0:	00000097          	auipc	ra,0x0
    800030f4:	cc4080e7          	jalr	-828(ra) # 80002db4 <_Z17kern_thread_yieldv>
    w_sstatus(sstatus);
    800030f8:	fe843783          	ld	a5,-24(s0)
    __asm__ volatile ("csrw sstatus, %[sstatus]" : : [sstatus] "r"(sstatus));
    800030fc:	10079073          	csrw	sstatus,a5
    w_sepc(v_sepc);
    80003100:	fe043783          	ld	a5,-32(s0)
    __asm__ volatile ("csrw sepc, %[sepc]" : : [sepc] "r"(sepc));
    80003104:	14179073          	csrw	sepc,a5
}
    80003108:	02813083          	ld	ra,40(sp)
    8000310c:	02013403          	ld	s0,32(sp)
    80003110:	03010113          	addi	sp,sp,48
    80003114:	00008067          	ret

0000000080003118 <_Z18kern_thread_wakeupm>:

void kern_thread_wakeup(uint64 system_time)
{
    80003118:	fe010113          	addi	sp,sp,-32
    8000311c:	00113c23          	sd	ra,24(sp)
    80003120:	00813823          	sd	s0,16(sp)
    80003124:	00913423          	sd	s1,8(sp)
    80003128:	01213023          	sd	s2,0(sp)
    8000312c:	02010413          	addi	s0,sp,32
    80003130:	00050913          	mv	s2,a0
    for(int i=0;i<MAX_THREADS;i++){
    80003134:	00000493          	li	s1,0
    80003138:	0240006f          	j	8000315c <_Z18kern_thread_wakeupm+0x44>
        if(kthreads[i].status==SLEEPING && kthreads[i].endTime<system_time){
            kthreads[i].status=READY;
    8000313c:	0000a517          	auipc	a0,0xa
    80003140:	39450513          	addi	a0,a0,916 # 8000d4d0 <kthreads>
    80003144:	00e50533          	add	a0,a0,a4
    80003148:	00200793          	li	a5,2
    8000314c:	04f52823          	sw	a5,80(a0)
            kern_scheduler_put(&kthreads[i]);
    80003150:	00000097          	auipc	ra,0x0
    80003154:	b5c080e7          	jalr	-1188(ra) # 80002cac <_Z18kern_scheduler_putP8thread_s>
    for(int i=0;i<MAX_THREADS;i++){
    80003158:	0014849b          	addiw	s1,s1,1
    8000315c:	03f00793          	li	a5,63
    80003160:	0497c263          	blt	a5,s1,800031a4 <_Z18kern_thread_wakeupm+0x8c>
        if(kthreads[i].status==SLEEPING && kthreads[i].endTime<system_time){
    80003164:	06800793          	li	a5,104
    80003168:	02f48733          	mul	a4,s1,a5
    8000316c:	0000a797          	auipc	a5,0xa
    80003170:	36478793          	addi	a5,a5,868 # 8000d4d0 <kthreads>
    80003174:	00e787b3          	add	a5,a5,a4
    80003178:	0507a703          	lw	a4,80(a5)
    8000317c:	00500793          	li	a5,5
    80003180:	fcf71ce3          	bne	a4,a5,80003158 <_Z18kern_thread_wakeupm+0x40>
    80003184:	06800793          	li	a5,104
    80003188:	02f48733          	mul	a4,s1,a5
    8000318c:	0000a797          	auipc	a5,0xa
    80003190:	34478793          	addi	a5,a5,836 # 8000d4d0 <kthreads>
    80003194:	00e787b3          	add	a5,a5,a4
    80003198:	0387b783          	ld	a5,56(a5)
    8000319c:	fb27fee3          	bgeu	a5,s2,80003158 <_Z18kern_thread_wakeupm+0x40>
    800031a0:	f9dff06f          	j	8000313c <_Z18kern_thread_wakeupm+0x24>
        }
    }
}
    800031a4:	01813083          	ld	ra,24(sp)
    800031a8:	01013403          	ld	s0,16(sp)
    800031ac:	00813483          	ld	s1,8(sp)
    800031b0:	00013903          	ld	s2,0(sp)
    800031b4:	02010113          	addi	sp,sp,32
    800031b8:	00008067          	ret

00000000800031bc <_Z17kern_thread_sleepm>:

void kern_thread_sleep(uint64 wakeTime)
{
    800031bc:	fd010113          	addi	sp,sp,-48
    800031c0:	02113423          	sd	ra,40(sp)
    800031c4:	02813023          	sd	s0,32(sp)
    800031c8:	03010413          	addi	s0,sp,48
    running->status=SLEEPING;
    800031cc:	0000a797          	auipc	a5,0xa
    800031d0:	2dc7b783          	ld	a5,732(a5) # 8000d4a8 <running>
    800031d4:	00500713          	li	a4,5
    800031d8:	04e7a823          	sw	a4,80(a5)
    running->endTime=wakeTime;
    800031dc:	02a7bc23          	sd	a0,56(a5)
    __asm__ volatile ("csrr %[sstatus], sstatus" : [sstatus] "=r"(sstatus));
    800031e0:	100027f3          	csrr	a5,sstatus
    800031e4:	fcf43c23          	sd	a5,-40(s0)
    return sstatus;
    800031e8:	fd843783          	ld	a5,-40(s0)
    uint64 volatile sstatus = r_sstatus();
    800031ec:	fef43423          	sd	a5,-24(s0)
    __asm__ volatile ("csrr %[sepc], sepc" : [sepc] "=r"(sepc));
    800031f0:	141027f3          	csrr	a5,sepc
    800031f4:	fcf43823          	sd	a5,-48(s0)
    return sepc;
    800031f8:	fd043783          	ld	a5,-48(s0)
    uint64 volatile v_sepc = r_sepc();
    800031fc:	fef43023          	sd	a5,-32(s0)
    kern_thread_yield();
    80003200:	00000097          	auipc	ra,0x0
    80003204:	bb4080e7          	jalr	-1100(ra) # 80002db4 <_Z17kern_thread_yieldv>
    w_sstatus(sstatus);
    80003208:	fe843783          	ld	a5,-24(s0)
    __asm__ volatile ("csrw sstatus, %[sstatus]" : : [sstatus] "r"(sstatus));
    8000320c:	10079073          	csrw	sstatus,a5
    w_sepc(v_sepc);
    80003210:	fe043783          	ld	a5,-32(s0)
    __asm__ volatile ("csrw sepc, %[sepc]" : : [sepc] "r"(sepc));
    80003214:	14179073          	csrw	sepc,a5
}
    80003218:	02813083          	ld	ra,40(sp)
    8000321c:	02013403          	ld	s0,32(sp)
    80003220:	03010113          	addi	sp,sp,48
    80003224:	00008067          	ret

0000000080003228 <_Z13kern_sem_initv>:
#define MAX_SEMAPHORES 256

struct sem_s semaphores[MAX_SEMAPHORES];

void kern_sem_init()
{
    80003228:	ff010113          	addi	sp,sp,-16
    8000322c:	00813423          	sd	s0,8(sp)
    80003230:	01010413          	addi	s0,sp,16
    for(int i=0;i<MAX_SEMAPHORES;i++){
    80003234:	00000713          	li	a4,0
    80003238:	0ff00793          	li	a5,255
    8000323c:	02e7c663          	blt	a5,a4,80003268 <_Z13kern_sem_initv+0x40>
        semaphores[i].waiting_thread=0;
    80003240:	00471693          	slli	a3,a4,0x4
    80003244:	0000c797          	auipc	a5,0xc
    80003248:	c8c78793          	addi	a5,a5,-884 # 8000eed0 <semaphores>
    8000324c:	00d787b3          	add	a5,a5,a3
    80003250:	0007b423          	sd	zero,8(a5)
        semaphores[i].val=0;
    80003254:	0007a023          	sw	zero,0(a5)
        semaphores[i].status=SEM_UNUSED;
    80003258:	00100693          	li	a3,1
    8000325c:	00d7a223          	sw	a3,4(a5)
    for(int i=0;i<MAX_SEMAPHORES;i++){
    80003260:	0017071b          	addiw	a4,a4,1
    80003264:	fd5ff06f          	j	80003238 <_Z13kern_sem_initv+0x10>
    }
}
    80003268:	00813403          	ld	s0,8(sp)
    8000326c:	01010113          	addi	sp,sp,16
    80003270:	00008067          	ret

0000000080003274 <_Z13kern_sem_openPP5sem_sj>:

int kern_sem_open (sem_t* handle, unsigned init)
{
    80003274:	ff010113          	addi	sp,sp,-16
    80003278:	00813423          	sd	s0,8(sp)
    8000327c:	01010413          	addi	s0,sp,16
    int res=-1;
    for(int i=0;i<MAX_SEMAPHORES;i++){
    80003280:	00000793          	li	a5,0
    80003284:	0080006f          	j	8000328c <_Z13kern_sem_openPP5sem_sj+0x18>
    80003288:	0017879b          	addiw	a5,a5,1
    8000328c:	0ff00713          	li	a4,255
    80003290:	04f74663          	blt	a4,a5,800032dc <_Z13kern_sem_openPP5sem_sj+0x68>
        if(semaphores[i].status==SEM_UNUSED){
    80003294:	00479693          	slli	a3,a5,0x4
    80003298:	0000c717          	auipc	a4,0xc
    8000329c:	c3870713          	addi	a4,a4,-968 # 8000eed0 <semaphores>
    800032a0:	00d70733          	add	a4,a4,a3
    800032a4:	00472683          	lw	a3,4(a4)
    800032a8:	00100713          	li	a4,1
    800032ac:	fce69ee3          	bne	a3,a4,80003288 <_Z13kern_sem_openPP5sem_sj+0x14>
            semaphores[i].status=SEM_USED;
    800032b0:	00479793          	slli	a5,a5,0x4
    800032b4:	0000c717          	auipc	a4,0xc
    800032b8:	c1c70713          	addi	a4,a4,-996 # 8000eed0 <semaphores>
    800032bc:	00f707b3          	add	a5,a4,a5
    800032c0:	0007a223          	sw	zero,4(a5)
            semaphores[i].val=init;
    800032c4:	00b7a023          	sw	a1,0(a5)
            *handle=&semaphores[i];
    800032c8:	00f53023          	sd	a5,0(a0)
            res++;
    800032cc:	00000513          	li	a0,0
            break;
        }
    }
    return res;
}
    800032d0:	00813403          	ld	s0,8(sp)
    800032d4:	01010113          	addi	sp,sp,16
    800032d8:	00008067          	ret
    int res=-1;
    800032dc:	fff00513          	li	a0,-1
    800032e0:	ff1ff06f          	j	800032d0 <_Z13kern_sem_openPP5sem_sj+0x5c>

00000000800032e4 <_Z14kern_sem_closeP5sem_s>:

int kern_sem_close (sem_t handle)
{
    800032e4:	fe010113          	addi	sp,sp,-32
    800032e8:	00113c23          	sd	ra,24(sp)
    800032ec:	00813823          	sd	s0,16(sp)
    800032f0:	00913423          	sd	s1,8(sp)
    800032f4:	01213023          	sd	s2,0(sp)
    800032f8:	02010413          	addi	s0,sp,32
    800032fc:	00050913          	mv	s2,a0
    handle->status=SEM_UNUSED;
    80003300:	00100793          	li	a5,1
    80003304:	00f52223          	sw	a5,4(a0)
    handle->val=0;
    80003308:	00052023          	sw	zero,0(a0)
    if(handle->waiting_thread!=0){
    8000330c:	00853503          	ld	a0,8(a0)
    80003310:	02051663          	bnez	a0,8000333c <_Z14kern_sem_closeP5sem_s+0x58>
    80003314:	0300006f          	j	80003344 <_Z14kern_sem_closeP5sem_s+0x60>
        thread_t curr = handle->waiting_thread;
        while(curr){
            curr->mailbox=-2;
    80003318:	ffe00793          	li	a5,-2
    8000331c:	04f53423          	sd	a5,72(a0)
            curr->status=READY;
    80003320:	00200793          	li	a5,2
    80003324:	04f52823          	sw	a5,80(a0)
            thread_t prev=curr;
            curr=curr->sem_next;
    80003328:	05853483          	ld	s1,88(a0)
            prev->sem_next=0;
    8000332c:	04053c23          	sd	zero,88(a0)
            kern_scheduler_put(prev);
    80003330:	00000097          	auipc	ra,0x0
    80003334:	97c080e7          	jalr	-1668(ra) # 80002cac <_Z18kern_scheduler_putP8thread_s>
            curr=curr->sem_next;
    80003338:	00048513          	mv	a0,s1
        while(curr){
    8000333c:	fc051ee3          	bnez	a0,80003318 <_Z14kern_sem_closeP5sem_s+0x34>
        }
        handle->waiting_thread=0;
    80003340:	00093423          	sd	zero,8(s2)
    }
    return 0;
}
    80003344:	00000513          	li	a0,0
    80003348:	01813083          	ld	ra,24(sp)
    8000334c:	01013403          	ld	s0,16(sp)
    80003350:	00813483          	ld	s1,8(sp)
    80003354:	00013903          	ld	s2,0(sp)
    80003358:	02010113          	addi	sp,sp,32
    8000335c:	00008067          	ret

0000000080003360 <_Z15kern_sem_signalP5sem_s>:

void kern_sem_signal(sem_t id)
{
    if(id->val>0 || id->waiting_thread==0) id->val++;
    80003360:	00052783          	lw	a5,0(a0)
    80003364:	00f05863          	blez	a5,80003374 <_Z15kern_sem_signalP5sem_s+0x14>
    80003368:	0017879b          	addiw	a5,a5,1
    8000336c:	00f52023          	sw	a5,0(a0)
    80003370:	00008067          	ret
    80003374:	00853703          	ld	a4,8(a0)
    80003378:	fe0708e3          	beqz	a4,80003368 <_Z15kern_sem_signalP5sem_s+0x8>
{
    8000337c:	ff010113          	addi	sp,sp,-16
    80003380:	00113423          	sd	ra,8(sp)
    80003384:	00813023          	sd	s0,0(sp)
    80003388:	01010413          	addi	s0,sp,16
    else {
        thread_t woken = id->waiting_thread;
        id->waiting_thread=woken->sem_next;
    8000338c:	05873783          	ld	a5,88(a4)
    80003390:	00f53423          	sd	a5,8(a0)
        woken->mailbox=0;
    80003394:	04073423          	sd	zero,72(a4)
        woken->status=READY;
    80003398:	00200793          	li	a5,2
    8000339c:	04f72823          	sw	a5,80(a4)
        kern_scheduler_put(woken);
    800033a0:	00070513          	mv	a0,a4
    800033a4:	00000097          	auipc	ra,0x0
    800033a8:	908080e7          	jalr	-1784(ra) # 80002cac <_Z18kern_scheduler_putP8thread_s>
    }
}
    800033ac:	00813083          	ld	ra,8(sp)
    800033b0:	00013403          	ld	s0,0(sp)
    800033b4:	01010113          	addi	sp,sp,16
    800033b8:	00008067          	ret

00000000800033bc <_Z13kern_sem_waitP5sem_s>:

int kern_sem_wait(sem_t id)
{
    if(id->val<=0){
    800033bc:	00052783          	lw	a5,0(a0)
    800033c0:	00f05a63          	blez	a5,800033d4 <_Z13kern_sem_waitP5sem_s+0x18>
        w_sstatus(sstatus);
        w_sepc(v_sepc);
        return running->mailbox;
    }
    else {
        id->val--;
    800033c4:	fff7879b          	addiw	a5,a5,-1
    800033c8:	00f52023          	sw	a5,0(a0)
        return 1;
    800033cc:	00100513          	li	a0,1
    }
}
    800033d0:	00008067          	ret
{
    800033d4:	fd010113          	addi	sp,sp,-48
    800033d8:	02113423          	sd	ra,40(sp)
    800033dc:	02813023          	sd	s0,32(sp)
    800033e0:	03010413          	addi	s0,sp,48
        running->status=SUSPENDED;
    800033e4:	00009797          	auipc	a5,0x9
    800033e8:	76c7b783          	ld	a5,1900(a5) # 8000cb50 <_GLOBAL_OFFSET_TABLE_+0x20>
    800033ec:	0007b683          	ld	a3,0(a5)
    800033f0:	00300793          	li	a5,3
    800033f4:	04f6a823          	sw	a5,80(a3)
        if(id->waiting_thread==0) id->waiting_thread=running;
    800033f8:	00853783          	ld	a5,8(a0)
    800033fc:	06078863          	beqz	a5,8000346c <_Z13kern_sem_waitP5sem_s+0xb0>
            while (curr->sem_next!=0) curr=curr->sem_next;
    80003400:	00078713          	mv	a4,a5
    80003404:	0587b783          	ld	a5,88(a5)
    80003408:	fe079ce3          	bnez	a5,80003400 <_Z13kern_sem_waitP5sem_s+0x44>
            curr->sem_next=running;
    8000340c:	04d73c23          	sd	a3,88(a4)
        running->sem_next=0;
    80003410:	0406bc23          	sd	zero,88(a3)
    __asm__ volatile ("csrr %[sstatus], sstatus" : [sstatus] "=r"(sstatus));
    80003414:	100027f3          	csrr	a5,sstatus
    80003418:	fef43423          	sd	a5,-24(s0)
    return sstatus;
    8000341c:	fe843783          	ld	a5,-24(s0)
        uint64 volatile sstatus = r_sstatus();
    80003420:	fcf43823          	sd	a5,-48(s0)
    __asm__ volatile ("csrr %[sepc], sepc" : [sepc] "=r"(sepc));
    80003424:	141027f3          	csrr	a5,sepc
    80003428:	fef43023          	sd	a5,-32(s0)
    return sepc;
    8000342c:	fe043783          	ld	a5,-32(s0)
        uint64 volatile v_sepc = r_sepc();
    80003430:	fcf43c23          	sd	a5,-40(s0)
        kern_thread_yield();
    80003434:	00000097          	auipc	ra,0x0
    80003438:	980080e7          	jalr	-1664(ra) # 80002db4 <_Z17kern_thread_yieldv>
        w_sstatus(sstatus);
    8000343c:	fd043783          	ld	a5,-48(s0)
    __asm__ volatile ("csrw sstatus, %[sstatus]" : : [sstatus] "r"(sstatus));
    80003440:	10079073          	csrw	sstatus,a5
        w_sepc(v_sepc);
    80003444:	fd843783          	ld	a5,-40(s0)
    __asm__ volatile ("csrw sepc, %[sepc]" : : [sepc] "r"(sepc));
    80003448:	14179073          	csrw	sepc,a5
        return running->mailbox;
    8000344c:	00009797          	auipc	a5,0x9
    80003450:	7047b783          	ld	a5,1796(a5) # 8000cb50 <_GLOBAL_OFFSET_TABLE_+0x20>
    80003454:	0007b783          	ld	a5,0(a5)
    80003458:	0487a503          	lw	a0,72(a5)
}
    8000345c:	02813083          	ld	ra,40(sp)
    80003460:	02013403          	ld	s0,32(sp)
    80003464:	03010113          	addi	sp,sp,48
    80003468:	00008067          	ret
        if(id->waiting_thread==0) id->waiting_thread=running;
    8000346c:	00d53423          	sd	a3,8(a0)
    80003470:	fa1ff06f          	j	80003410 <_Z13kern_sem_waitP5sem_s+0x54>

0000000080003474 <_Z19kern_interrupt_initv>:
#ifdef __cplusplus
}
#endif

void kern_interrupt_init()
{
    80003474:	ff010113          	addi	sp,sp,-16
    80003478:	00813423          	sd	s0,8(sp)
    8000347c:	01010413          	addi	s0,sp,16
    SYSTEM_TIME=0;
    80003480:	0000d797          	auipc	a5,0xd
    80003484:	a407b823          	sd	zero,-1456(a5) # 8000fed0 <SYSTEM_TIME>
    w_stvec((uint64) &supervisorTrap);
    80003488:	00009797          	auipc	a5,0x9
    8000348c:	6d07b783          	ld	a5,1744(a5) # 8000cb58 <_GLOBAL_OFFSET_TABLE_+0x28>
    __asm__ volatile ("csrw stvec, %[stvec]" : : [stvec] "r"(stvec));
    80003490:	10579073          	csrw	stvec,a5
    __asm__ volatile ("csrs sstatus, %[mask]" : : [mask] "r"(mask));
    80003494:	00200793          	li	a5,2
    80003498:	1007a073          	csrs	sstatus,a5
    ms_sstatus(SSTATUS_SIE);
}
    8000349c:	00813403          	ld	s0,8(sp)
    800034a0:	01010113          	addi	sp,sp,16
    800034a4:	00008067          	ret

00000000800034a8 <_Z12kern_syscall13SyscallNumberz>:


void kern_syscall(enum SyscallNumber num, ...)
{
    800034a8:	fb010113          	addi	sp,sp,-80
    800034ac:	00813423          	sd	s0,8(sp)
    800034b0:	01010413          	addi	s0,sp,16
    800034b4:	00b43423          	sd	a1,8(s0)
    800034b8:	00c43823          	sd	a2,16(s0)
    800034bc:	00d43c23          	sd	a3,24(s0)
    800034c0:	02e43023          	sd	a4,32(s0)
    800034c4:	02f43423          	sd	a5,40(s0)
    800034c8:	03043823          	sd	a6,48(s0)
    800034cc:	03143c23          	sd	a7,56(s0)
    __asm__ volatile ("ecall");
    800034d0:	00000073          	ecall
    return;
}
    800034d4:	00813403          	ld	s0,8(sp)
    800034d8:	05010113          	addi	sp,sp,80
    800034dc:	00008067          	ret

00000000800034e0 <handleEcall>:
#ifdef __cplusplus
extern "C" {
#endif


void handleEcall(uint64 a0, uint64 a1, uint64 a2, uint64 a3, uint64 a4) {
    800034e0:	fd010113          	addi	sp,sp,-48
    800034e4:	02113423          	sd	ra,40(sp)
    800034e8:	02813023          	sd	s0,32(sp)
    800034ec:	00913c23          	sd	s1,24(sp)
    800034f0:	01213823          	sd	s2,16(sp)
    800034f4:	03010413          	addi	s0,sp,48
    800034f8:	00060913          	mv	s2,a2
    800034fc:	00068613          	mv	a2,a3
    __asm__ volatile ("csrr %[scause], scause" : [scause] "=r"(scause));
    80003500:	142027f3          	csrr	a5,scause
    80003504:	fcf43823          	sd	a5,-48(s0)
    return scause;
    80003508:	fd043783          	ld	a5,-48(s0)
    __asm__ volatile ("mv %[a2], a2" : [a2] "=r"(a2));
    __asm__ volatile ("mv %[a3], a3" : [a3] "=r"(a3));
    __asm__ volatile ("mv %[a4], a4" : [a4] "=r"(a4));
     */
    uint64 scause = r_scause();
    if (scause == INTR_USER_ECALL || scause == INTR_KERNEL_ECALL) {
    8000350c:	ff878793          	addi	a5,a5,-8
    80003510:	00100693          	li	a3,1
    80003514:	00f6fe63          	bgeu	a3,a5,80003530 <handleEcall+0x50>
            }


        }
    }
}
    80003518:	02813083          	ld	ra,40(sp)
    8000351c:	02013403          	ld	s0,32(sp)
    80003520:	01813483          	ld	s1,24(sp)
    80003524:	01013903          	ld	s2,16(sp)
    80003528:	03010113          	addi	sp,sp,48
    8000352c:	00008067          	ret
    80003530:	00058493          	mv	s1,a1
    __asm__ volatile ("csrr %[sepc], sepc" : [sepc] "=r"(sepc));
    80003534:	141027f3          	csrr	a5,sepc
    80003538:	fcf43c23          	sd	a5,-40(s0)
    return sepc;
    8000353c:	fd843783          	ld	a5,-40(s0)
        uint64 sepc = r_sepc() + 4;
    80003540:	00478793          	addi	a5,a5,4
        uint64 time = SYSTEM_TIME;
    80003544:	0000d597          	auipc	a1,0xd
    80003548:	98c5b583          	ld	a1,-1652(a1) # 8000fed0 <SYSTEM_TIME>
    __asm__ volatile ("csrw sepc, %[sepc]" : : [sepc] "r"(sepc));
    8000354c:	14179073          	csrw	sepc,a5
        switch (syscall_num) {
    80003550:	04200793          	li	a5,66
    80003554:	fca7e2e3          	bltu	a5,a0,80003518 <handleEcall+0x38>
    80003558:	00251513          	slli	a0,a0,0x2
    8000355c:	00007697          	auipc	a3,0x7
    80003560:	c7068693          	addi	a3,a3,-912 # 8000a1cc <CONSOLE_STATUS+0x1bc>
    80003564:	00d50533          	add	a0,a0,a3
    80003568:	00052783          	lw	a5,0(a0)
    8000356c:	00d787b3          	add	a5,a5,a3
    80003570:	00078067          	jr	a5
                retval = (uint64) kern_mem_alloc(size);
    80003574:	0004851b          	sext.w	a0,s1
    80003578:	fffff097          	auipc	ra,0xfffff
    8000357c:	ee8080e7          	jalr	-280(ra) # 80002460 <_Z14kern_mem_alloci>
    __asm__ volatile ("mv a0, %[value]" :: [value] "r"(value));
    80003580:	00050513          	mv	a0,a0
}
    80003584:	f95ff06f          	j	80003518 <handleEcall+0x38>
                retval = (uint64) kern_mem_free((void *) addr);
    80003588:	00048513          	mv	a0,s1
    8000358c:	fffff097          	auipc	ra,0xfffff
    80003590:	f98080e7          	jalr	-104(ra) # 80002524 <_Z13kern_mem_freePv>
    __asm__ volatile ("mv a0, %[value]" :: [value] "r"(value));
    80003594:	00050513          	mv	a0,a0
}
    80003598:	f81ff06f          	j	80003518 <handleEcall+0x38>
                retval = (uint64) kern_thread_create((thread_t *) handle,
    8000359c:	00070693          	mv	a3,a4
    800035a0:	00090593          	mv	a1,s2
    800035a4:	00048513          	mv	a0,s1
    800035a8:	00000097          	auipc	ra,0x0
    800035ac:	9f0080e7          	jalr	-1552(ra) # 80002f98 <_Z18kern_thread_createPP8thread_sPFvPvES2_S2_>
                (*(thread_t *) handle)->endTime = SYSTEM_TIME + DEFAULT_TIME_SLICE;
    800035b0:	0004b703          	ld	a4,0(s1)
    800035b4:	0000d797          	auipc	a5,0xd
    800035b8:	91c7b783          	ld	a5,-1764(a5) # 8000fed0 <SYSTEM_TIME>
    800035bc:	00278793          	addi	a5,a5,2
    800035c0:	02f73c23          	sd	a5,56(a4)
    __asm__ volatile ("mv a0, %[value]" :: [value] "r"(value));
    800035c4:	00050513          	mv	a0,a0
}
    800035c8:	f51ff06f          	j	80003518 <handleEcall+0x38>
                kern_thread_dispatch();
    800035cc:	00000097          	auipc	ra,0x0
    800035d0:	870080e7          	jalr	-1936(ra) # 80002e3c <_Z20kern_thread_dispatchv>
                running->endTime = SYSTEM_TIME + running->timeslice;
    800035d4:	00009797          	auipc	a5,0x9
    800035d8:	57c7b783          	ld	a5,1404(a5) # 8000cb50 <_GLOBAL_OFFSET_TABLE_+0x20>
    800035dc:	0007b703          	ld	a4,0(a5)
    800035e0:	03073783          	ld	a5,48(a4)
    800035e4:	0000d697          	auipc	a3,0xd
    800035e8:	8ec6b683          	ld	a3,-1812(a3) # 8000fed0 <SYSTEM_TIME>
    800035ec:	00d787b3          	add	a5,a5,a3
    800035f0:	02f73c23          	sd	a5,56(a4)
                break;
    800035f4:	f25ff06f          	j	80003518 <handleEcall+0x38>
                kern_thread_join(handle);
    800035f8:	00048513          	mv	a0,s1
    800035fc:	00000097          	auipc	ra,0x0
    80003600:	a90080e7          	jalr	-1392(ra) # 8000308c <_Z16kern_thread_joinP8thread_s>
                running->endTime = SYSTEM_TIME + running->timeslice;
    80003604:	00009797          	auipc	a5,0x9
    80003608:	54c7b783          	ld	a5,1356(a5) # 8000cb50 <_GLOBAL_OFFSET_TABLE_+0x20>
    8000360c:	0007b703          	ld	a4,0(a5)
    80003610:	03073783          	ld	a5,48(a4)
    80003614:	0000d697          	auipc	a3,0xd
    80003618:	8bc6b683          	ld	a3,-1860(a3) # 8000fed0 <SYSTEM_TIME>
    8000361c:	00d787b3          	add	a5,a5,a3
    80003620:	02f73c23          	sd	a5,56(a4)
                break;
    80003624:	ef5ff06f          	j	80003518 <handleEcall+0x38>
                kern_thread_end_running();
    80003628:	00000097          	auipc	ra,0x0
    8000362c:	87c080e7          	jalr	-1924(ra) # 80002ea4 <_Z23kern_thread_end_runningv>
                retval = kern_sem_open(handle, init);
    80003630:	0009059b          	sext.w	a1,s2
    80003634:	00048513          	mv	a0,s1
    80003638:	00000097          	auipc	ra,0x0
    8000363c:	c3c080e7          	jalr	-964(ra) # 80003274 <_Z13kern_sem_openPP5sem_sj>
    __asm__ volatile ("mv a0, %[value]" :: [value] "r"(value));
    80003640:	00050513          	mv	a0,a0
}
    80003644:	ed5ff06f          	j	80003518 <handleEcall+0x38>
                retval = kern_sem_close(handle);
    80003648:	00048513          	mv	a0,s1
    8000364c:	00000097          	auipc	ra,0x0
    80003650:	c98080e7          	jalr	-872(ra) # 800032e4 <_Z14kern_sem_closeP5sem_s>
    __asm__ volatile ("mv a0, %[value]" :: [value] "r"(value));
    80003654:	00050513          	mv	a0,a0
}
    80003658:	ec1ff06f          	j	80003518 <handleEcall+0x38>
                kern_sem_signal(handle);
    8000365c:	00048513          	mv	a0,s1
    80003660:	00000097          	auipc	ra,0x0
    80003664:	d00080e7          	jalr	-768(ra) # 80003360 <_Z15kern_sem_signalP5sem_s>
    __asm__ volatile ("mv a0, %[value]" :: [value] "r"(value));
    80003668:	00000793          	li	a5,0
    8000366c:	00078513          	mv	a0,a5
}
    80003670:	ea9ff06f          	j	80003518 <handleEcall+0x38>
                retval = kern_sem_wait(handle);
    80003674:	00048513          	mv	a0,s1
    80003678:	00000097          	auipc	ra,0x0
    8000367c:	d44080e7          	jalr	-700(ra) # 800033bc <_Z13kern_sem_waitP5sem_s>
                if (retval == 1) { //nije promenjen kontekst
    80003680:	00100793          	li	a5,1
    80003684:	02f50663          	beq	a0,a5,800036b0 <handleEcall+0x1d0>
                    running->endTime = SYSTEM_TIME + running->timeslice;
    80003688:	00009797          	auipc	a5,0x9
    8000368c:	4c87b783          	ld	a5,1224(a5) # 8000cb50 <_GLOBAL_OFFSET_TABLE_+0x20>
    80003690:	0007b703          	ld	a4,0(a5)
    80003694:	03073783          	ld	a5,48(a4)
    80003698:	0000d697          	auipc	a3,0xd
    8000369c:	8386b683          	ld	a3,-1992(a3) # 8000fed0 <SYSTEM_TIME>
    800036a0:	00d787b3          	add	a5,a5,a3
    800036a4:	02f73c23          	sd	a5,56(a4)
    __asm__ volatile ("mv a0, %[value]" :: [value] "r"(value));
    800036a8:	00050513          	mv	a0,a0
}
    800036ac:	e6dff06f          	j	80003518 <handleEcall+0x38>
                    retval = 0;
    800036b0:	00000513          	li	a0,0
    800036b4:	ff5ff06f          	j	800036a8 <handleEcall+0x1c8>
                kern_thread_sleep(wakeTime);
    800036b8:	00958533          	add	a0,a1,s1
    800036bc:	00000097          	auipc	ra,0x0
    800036c0:	b00080e7          	jalr	-1280(ra) # 800031bc <_Z17kern_thread_sleepm>
                running->endTime=time+running->timeslice;
    800036c4:	00009797          	auipc	a5,0x9
    800036c8:	48c7b783          	ld	a5,1164(a5) # 8000cb50 <_GLOBAL_OFFSET_TABLE_+0x20>
    800036cc:	0007b703          	ld	a4,0(a5)
    800036d0:	03073783          	ld	a5,48(a4)
    800036d4:	0000c697          	auipc	a3,0xc
    800036d8:	7fc6b683          	ld	a3,2044(a3) # 8000fed0 <SYSTEM_TIME>
    800036dc:	00d787b3          	add	a5,a5,a3
    800036e0:	02f73c23          	sd	a5,56(a4)
                break;
    800036e4:	e35ff06f          	j	80003518 <handleEcall+0x38>
                    c = kern_console_getchar();
    800036e8:	fffff097          	auipc	ra,0xfffff
    800036ec:	0cc080e7          	jalr	204(ra) # 800027b4 <_Z20kern_console_getcharv>
                    if(c==-1){
    800036f0:	fff00793          	li	a5,-1
    800036f4:	02f51863          	bne	a0,a5,80003724 <handleEcall+0x244>
                        kern_thread_dispatch();
    800036f8:	fffff097          	auipc	ra,0xfffff
    800036fc:	744080e7          	jalr	1860(ra) # 80002e3c <_Z20kern_thread_dispatchv>
                        running->endTime = SYSTEM_TIME + running->timeslice;
    80003700:	00009797          	auipc	a5,0x9
    80003704:	4507b783          	ld	a5,1104(a5) # 8000cb50 <_GLOBAL_OFFSET_TABLE_+0x20>
    80003708:	0007b703          	ld	a4,0(a5)
    8000370c:	03073783          	ld	a5,48(a4)
    80003710:	0000c697          	auipc	a3,0xc
    80003714:	7c06b683          	ld	a3,1984(a3) # 8000fed0 <SYSTEM_TIME>
    80003718:	00d787b3          	add	a5,a5,a3
    8000371c:	02f73c23          	sd	a5,56(a4)
                    c = kern_console_getchar();
    80003720:	fc9ff06f          	j	800036e8 <handleEcall+0x208>
    __asm__ volatile ("mv a0, %[value]" :: [value] "r"(value));
    80003724:	00050513          	mv	a0,a0
}
    80003728:	df1ff06f          	j	80003518 <handleEcall+0x38>
                char c = a1;
    8000372c:	0ff4f493          	andi	s1,s1,255
                    res=kern_console_putchar(c);
    80003730:	00048513          	mv	a0,s1
    80003734:	fffff097          	auipc	ra,0xfffff
    80003738:	0e4080e7          	jalr	228(ra) # 80002818 <_Z20kern_console_putcharc>
                    if(res==-1){
    8000373c:	fff00793          	li	a5,-1
    80003740:	dcf51ce3          	bne	a0,a5,80003518 <handleEcall+0x38>
                        kern_thread_dispatch();
    80003744:	fffff097          	auipc	ra,0xfffff
    80003748:	6f8080e7          	jalr	1784(ra) # 80002e3c <_Z20kern_thread_dispatchv>
                        running->endTime = SYSTEM_TIME + running->timeslice;
    8000374c:	00009797          	auipc	a5,0x9
    80003750:	4047b783          	ld	a5,1028(a5) # 8000cb50 <_GLOBAL_OFFSET_TABLE_+0x20>
    80003754:	0007b703          	ld	a4,0(a5)
    80003758:	03073783          	ld	a5,48(a4)
    8000375c:	0000c697          	auipc	a3,0xc
    80003760:	7746b683          	ld	a3,1908(a3) # 8000fed0 <SYSTEM_TIME>
    80003764:	00d787b3          	add	a5,a5,a3
    80003768:	02f73c23          	sd	a5,56(a4)
                    res=kern_console_putchar(c);
    8000376c:	fc5ff06f          	j	80003730 <handleEcall+0x250>

0000000080003770 <handleInterrupt>:
int counter=0;
#define BUFFER_SIZE 1024
char cbuf[BUFFER_SIZE];

void handleInterrupt()
{
    80003770:	fd010113          	addi	sp,sp,-48
    80003774:	02113423          	sd	ra,40(sp)
    80003778:	02813023          	sd	s0,32(sp)
    8000377c:	00913c23          	sd	s1,24(sp)
    80003780:	03010413          	addi	s0,sp,48
    __asm__ volatile ("csrr %[scause], scause" : [scause] "=r"(scause));
    80003784:	142027f3          	csrr	a5,scause
    80003788:	fcf43c23          	sd	a5,-40(s0)
    return scause;
    8000378c:	fd843703          	ld	a4,-40(s0)
    uint64 scause = r_scause();
    if (scause == INTR_TIMER)
    80003790:	fff00793          	li	a5,-1
    80003794:	03f79793          	slli	a5,a5,0x3f
    80003798:	00178793          	addi	a5,a5,1
    8000379c:	02f70863          	beq	a4,a5,800037cc <handleInterrupt+0x5c>
        if(SYSTEM_TIME>=running->endTime){
            kern_thread_dispatch();
            running->endTime=SYSTEM_TIME+running->timeslice;
        }
    }
    else if (scause == INTR_CONSOLE)
    800037a0:	fff00793          	li	a5,-1
    800037a4:	03f79793          	slli	a5,a5,0x3f
    800037a8:	00978793          	addi	a5,a5,9
    800037ac:	08f70463          	beq	a4,a5,80003834 <handleInterrupt+0xc4>
            kern_uart_handler();
        }
        plic_complete(irq);
        // console_handler();
    }
    else if(scause == INTR_ILLEGAL_INSTRUCTION)
    800037b0:	00200793          	li	a5,2
    800037b4:	0af70863          	beq	a4,a5,80003864 <handleInterrupt+0xf4>

    }
    else if(scause==INTR_ILLEGAL_ADDR_WR){

    }
}
    800037b8:	02813083          	ld	ra,40(sp)
    800037bc:	02013403          	ld	s0,32(sp)
    800037c0:	01813483          	ld	s1,24(sp)
    800037c4:	03010113          	addi	sp,sp,48
    800037c8:	00008067          	ret
        SYSTEM_TIME++;
    800037cc:	0000c497          	auipc	s1,0xc
    800037d0:	70448493          	addi	s1,s1,1796 # 8000fed0 <SYSTEM_TIME>
    800037d4:	0004b503          	ld	a0,0(s1)
    800037d8:	00150513          	addi	a0,a0,1
    800037dc:	00a4b023          	sd	a0,0(s1)
    __asm__ volatile ("csrc sip, %[mask]" : : [mask] "r"(mask));
    800037e0:	00200793          	li	a5,2
    800037e4:	1447b073          	csrc	sip,a5
        kern_thread_wakeup(SYSTEM_TIME);
    800037e8:	00000097          	auipc	ra,0x0
    800037ec:	930080e7          	jalr	-1744(ra) # 80003118 <_Z18kern_thread_wakeupm>
        if(SYSTEM_TIME>=running->endTime){
    800037f0:	00009797          	auipc	a5,0x9
    800037f4:	3607b783          	ld	a5,864(a5) # 8000cb50 <_GLOBAL_OFFSET_TABLE_+0x20>
    800037f8:	0007b783          	ld	a5,0(a5)
    800037fc:	0387b703          	ld	a4,56(a5)
    80003800:	0004b783          	ld	a5,0(s1)
    80003804:	fae7eae3          	bltu	a5,a4,800037b8 <handleInterrupt+0x48>
            kern_thread_dispatch();
    80003808:	fffff097          	auipc	ra,0xfffff
    8000380c:	634080e7          	jalr	1588(ra) # 80002e3c <_Z20kern_thread_dispatchv>
            running->endTime=SYSTEM_TIME+running->timeslice;
    80003810:	00009797          	auipc	a5,0x9
    80003814:	3407b783          	ld	a5,832(a5) # 8000cb50 <_GLOBAL_OFFSET_TABLE_+0x20>
    80003818:	0007b703          	ld	a4,0(a5)
    8000381c:	03073783          	ld	a5,48(a4)
    80003820:	0000c697          	auipc	a3,0xc
    80003824:	6b06b683          	ld	a3,1712(a3) # 8000fed0 <SYSTEM_TIME>
    80003828:	00d787b3          	add	a5,a5,a3
    8000382c:	02f73c23          	sd	a5,56(a4)
    80003830:	f89ff06f          	j	800037b8 <handleInterrupt+0x48>
        int irq = plic_claim();
    80003834:	00005097          	auipc	ra,0x5
    80003838:	800080e7          	jalr	-2048(ra) # 80008034 <plic_claim>
    8000383c:	00050493          	mv	s1,a0
        if(irq==CONSOLE_IRQ) {
    80003840:	00a00793          	li	a5,10
    80003844:	00f50a63          	beq	a0,a5,80003858 <handleInterrupt+0xe8>
        plic_complete(irq);
    80003848:	00048513          	mv	a0,s1
    8000384c:	00005097          	auipc	ra,0x5
    80003850:	820080e7          	jalr	-2016(ra) # 8000806c <plic_complete>
    80003854:	f65ff06f          	j	800037b8 <handleInterrupt+0x48>
            kern_uart_handler();
    80003858:	fffff097          	auipc	ra,0xfffff
    8000385c:	ee8080e7          	jalr	-280(ra) # 80002740 <_Z17kern_uart_handlerv>
    80003860:	fe9ff06f          	j	80003848 <handleInterrupt+0xd8>
        kern_mem_free((void*)running->stack_space);
    80003864:	00009797          	auipc	a5,0x9
    80003868:	2ec7b783          	ld	a5,748(a5) # 8000cb50 <_GLOBAL_OFFSET_TABLE_+0x20>
    8000386c:	0007b783          	ld	a5,0(a5)
    80003870:	0407b503          	ld	a0,64(a5)
    80003874:	fffff097          	auipc	ra,0xfffff
    80003878:	cb0080e7          	jalr	-848(ra) # 80002524 <_Z13kern_mem_freePv>
        kern_thread_end_running();
    8000387c:	fffff097          	auipc	ra,0xfffff
    80003880:	628080e7          	jalr	1576(ra) # 80002ea4 <_Z23kern_thread_end_runningv>
}
    80003884:	f35ff06f          	j	800037b8 <handleInterrupt+0x48>

0000000080003888 <_Z11kmem_strcpyPcPKc>:
#define ALLOCATION_CHUNK_SIZE 16

kmem_cache_t *kmem_cache_head;


void kmem_strcpy(char* dst, const char* src) {
    80003888:	ff010113          	addi	sp,sp,-16
    8000388c:	00813423          	sd	s0,8(sp)
    80003890:	01010413          	addi	s0,sp,16
    int i = 0;
    80003894:	00000793          	li	a5,0
    while (src[i] != '\0' && i < 15) {
    80003898:	00078713          	mv	a4,a5
    8000389c:	00f586b3          	add	a3,a1,a5
    800038a0:	0006c683          	lbu	a3,0(a3)
    800038a4:	00068e63          	beqz	a3,800038c0 <_Z11kmem_strcpyPcPKc+0x38>
    800038a8:	00e00613          	li	a2,14
    800038ac:	00f64a63          	blt	a2,a5,800038c0 <_Z11kmem_strcpyPcPKc+0x38>
        dst[i] = src[i];
    800038b0:	00f50733          	add	a4,a0,a5
    800038b4:	00d70023          	sb	a3,0(a4)
        i++;
    800038b8:	0017879b          	addiw	a5,a5,1
    while (src[i] != '\0' && i < 15) {
    800038bc:	fddff06f          	j	80003898 <_Z11kmem_strcpyPcPKc+0x10>
    }
    dst[i] = '\0';
    800038c0:	00e50533          	add	a0,a0,a4
    800038c4:	00050023          	sb	zero,0(a0)
}
    800038c8:	00813403          	ld	s0,8(sp)
    800038cc:	01010113          	addi	sp,sp,16
    800038d0:	00008067          	ret

00000000800038d4 <_Z9kmem_initPvi>:

void kmem_init(void *space, int block_num)
{
    800038d4:	ff010113          	addi	sp,sp,-16
    800038d8:	00113423          	sd	ra,8(sp)
    800038dc:	00813023          	sd	s0,0(sp)
    800038e0:	01010413          	addi	s0,sp,16
    bba_init((char*)space,(char*)space+block_num*BLOCK_SIZE);
    800038e4:	00c5959b          	slliw	a1,a1,0xc
    800038e8:	00b505b3          	add	a1,a0,a1
    800038ec:	ffffe097          	auipc	ra,0xffffe
    800038f0:	e0c080e7          	jalr	-500(ra) # 800016f8 <_Z8bba_initPcS_>
    kmem_cache_head=0;
    800038f4:	0000d797          	auipc	a5,0xd
    800038f8:	9e07b623          	sd	zero,-1556(a5) # 800102e0 <kmem_cache_head>
}
    800038fc:	00813083          	ld	ra,8(sp)
    80003900:	00013403          	ld	s0,0(sp)
    80003904:	01010113          	addi	sp,sp,16
    80003908:	00008067          	ret

000000008000390c <_Z14kmem_slab_initP12kmem_cache_s>:
    }
}

//creates a slab, adds it to cache list, initializes up to ALLOCATION_CHUNK_SIZE objs if needed
kmem_slab_t *kmem_slab_init(kmem_cache_t* cache)
{
    8000390c:	fd010113          	addi	sp,sp,-48
    80003910:	02113423          	sd	ra,40(sp)
    80003914:	02813023          	sd	s0,32(sp)
    80003918:	00913c23          	sd	s1,24(sp)
    8000391c:	01213823          	sd	s2,16(sp)
    80003920:	01313423          	sd	s3,8(sp)
    80003924:	01413023          	sd	s4,0(sp)
    80003928:	03010413          	addi	s0,sp,48
    8000392c:	00050913          	mv	s2,a0
    void* memory = bba_allocate(cache->memorySize);
    80003930:	04852503          	lw	a0,72(a0)
    80003934:	ffffe097          	auipc	ra,0xffffe
    80003938:	140080e7          	jalr	320(ra) # 80001a74 <_Z12bba_allocatem>
    8000393c:	00050a13          	mv	s4,a0
    if(memory==0) return 0;
    80003940:	10050a63          	beqz	a0,80003a54 <_Z14kmem_slab_initP12kmem_cache_s+0x148>

    int bitmapCharCount = (cache->slotsInSlab+8-1)/8;
    80003944:	05092503          	lw	a0,80(s2)
    80003948:	0075079b          	addiw	a5,a0,7
    8000394c:	41f7d51b          	sraiw	a0,a5,0x1f
    80003950:	01d5551b          	srliw	a0,a0,0x1d
    80003954:	00f5053b          	addw	a0,a0,a5
    80003958:	4035551b          	sraiw	a0,a0,0x3
    8000395c:	0005049b          	sext.w	s1,a0
    int descriptorSize = sizeof(kmem_slab_t) + bitmapCharCount*2;
    80003960:	0015151b          	slliw	a0,a0,0x1
    kmem_slab_t *slab = (kmem_slab_t*) bba_allocate(descriptorSize);
    80003964:	0285051b          	addiw	a0,a0,40
    80003968:	ffffe097          	auipc	ra,0xffffe
    8000396c:	10c080e7          	jalr	268(ra) # 80001a74 <_Z12bba_allocatem>
    80003970:	00050993          	mv	s3,a0
    if(slab==0){
    80003974:	02050663          	beqz	a0,800039a0 <_Z14kmem_slab_initP12kmem_cache_s+0x94>
        bba_free_block(memory);
        return 0;
    }

    slab->memory=memory;
    80003978:	01453423          	sd	s4,8(a0)
    slab->freeSlotsBitmap = (char*)slab + sizeof(kmem_slab_t);
    8000397c:	02850793          	addi	a5,a0,40
    80003980:	00f53c23          	sd	a5,24(a0)
    slab->initializedSlotsBitmap = slab->freeSlotsBitmap + bitmapCharCount;
    80003984:	009787b3          	add	a5,a5,s1
    80003988:	00f53823          	sd	a5,16(a0)
    slab->usedSlotsCount=0;
    8000398c:	00052023          	sw	zero,0(a0)
    slab->initializedSlotsCount=0;
    80003990:	00052223          	sw	zero,4(a0)
    slab->nextSlab=0;
    80003994:	02053023          	sd	zero,32(a0)


    //marks all slots as free, if ctor is provided initializes objects in slab, but no more than ALLOCATION_CHUNK_SIZE objects
    for (int i = 0; i < cache->slotsInSlab; i++) {
    80003998:	00000493          	li	s1,0
    8000399c:	04c0006f          	j	800039e8 <_Z14kmem_slab_initP12kmem_cache_s+0xdc>
        bba_free_block(memory);
    800039a0:	000a0513          	mv	a0,s4
    800039a4:	ffffe097          	auipc	ra,0xffffe
    800039a8:	398080e7          	jalr	920(ra) # 80001d3c <_Z14bba_free_blockPKv>
        return 0;
    800039ac:	0ac0006f          	j	80003a58 <_Z14kmem_slab_initP12kmem_cache_s+0x14c>
        if (cache->ctor!=0 && i < ALLOCATION_CHUNK_SIZE) {
            cache->ctor(curr);
            slab->initializedSlotsCount++;
            setBitmapValue(slab->initializedSlotsBitmap, i, SLOT_INITIALIZED);
        }
        setBitmapValue(slab->freeSlotsBitmap, i, SLOT_FREE);
    800039b0:	0189b703          	ld	a4,24(s3)
    int wordPosition = position/8;
    800039b4:	41f4d79b          	sraiw	a5,s1,0x1f
    800039b8:	01d7d69b          	srliw	a3,a5,0x1d
    800039bc:	009687bb          	addw	a5,a3,s1
    800039c0:	4037d61b          	sraiw	a2,a5,0x3
    int bitPosition = position%8;
    800039c4:	0077f793          	andi	a5,a5,7
    800039c8:	40d787bb          	subw	a5,a5,a3
        bitmapStart[wordPosition] = bitmapStart[wordPosition] | (1<<bitPosition);
    800039cc:	00c70733          	add	a4,a4,a2
    800039d0:	00070683          	lb	a3,0(a4)
    800039d4:	00100613          	li	a2,1
    800039d8:	00f617bb          	sllw	a5,a2,a5
    800039dc:	00f6e7b3          	or	a5,a3,a5
    800039e0:	00f70023          	sb	a5,0(a4)
    for (int i = 0; i < cache->slotsInSlab; i++) {
    800039e4:	0014849b          	addiw	s1,s1,1
    800039e8:	05092783          	lw	a5,80(s2)
    800039ec:	06f4d663          	bge	s1,a5,80003a58 <_Z14kmem_slab_initP12kmem_cache_s+0x14c>
        char *curr = (char*)memory + i * cache->slotSize;
    800039f0:	02093783          	ld	a5,32(s2)
    800039f4:	02f487b3          	mul	a5,s1,a5
    800039f8:	00fa0533          	add	a0,s4,a5
        if (cache->ctor!=0 && i < ALLOCATION_CHUNK_SIZE) {
    800039fc:	02893783          	ld	a5,40(s2)
    80003a00:	fa0788e3          	beqz	a5,800039b0 <_Z14kmem_slab_initP12kmem_cache_s+0xa4>
    80003a04:	00f00713          	li	a4,15
    80003a08:	fa9744e3          	blt	a4,s1,800039b0 <_Z14kmem_slab_initP12kmem_cache_s+0xa4>
            cache->ctor(curr);
    80003a0c:	000780e7          	jalr	a5
            slab->initializedSlotsCount++;
    80003a10:	0049a783          	lw	a5,4(s3)
    80003a14:	0017879b          	addiw	a5,a5,1
    80003a18:	00f9a223          	sw	a5,4(s3)
            setBitmapValue(slab->initializedSlotsBitmap, i, SLOT_INITIALIZED);
    80003a1c:	0109b703          	ld	a4,16(s3)
    int wordPosition = position/8;
    80003a20:	41f4d79b          	sraiw	a5,s1,0x1f
    80003a24:	01d7d69b          	srliw	a3,a5,0x1d
    80003a28:	009687bb          	addw	a5,a3,s1
    80003a2c:	4037d61b          	sraiw	a2,a5,0x3
    int bitPosition = position%8;
    80003a30:	0077f793          	andi	a5,a5,7
    80003a34:	40d787bb          	subw	a5,a5,a3
        bitmapStart[wordPosition] = bitmapStart[wordPosition] | (1<<bitPosition);
    80003a38:	00c70733          	add	a4,a4,a2
    80003a3c:	00070683          	lb	a3,0(a4)
    80003a40:	00100613          	li	a2,1
    80003a44:	00f617bb          	sllw	a5,a2,a5
    80003a48:	00f6e7b3          	or	a5,a3,a5
    80003a4c:	00f70023          	sb	a5,0(a4)
    80003a50:	f61ff06f          	j	800039b0 <_Z14kmem_slab_initP12kmem_cache_s+0xa4>
    if(memory==0) return 0;
    80003a54:	00050993          	mv	s3,a0
    }

    return slab;
}
    80003a58:	00098513          	mv	a0,s3
    80003a5c:	02813083          	ld	ra,40(sp)
    80003a60:	02013403          	ld	s0,32(sp)
    80003a64:	01813483          	ld	s1,24(sp)
    80003a68:	01013903          	ld	s2,16(sp)
    80003a6c:	00813983          	ld	s3,8(sp)
    80003a70:	00013a03          	ld	s4,0(sp)
    80003a74:	03010113          	addi	sp,sp,48
    80003a78:	00008067          	ret

0000000080003a7c <_Z17kmem_cache_createPKcmPFvPvES3_>:

//creates cache with one empty slab
kmem_cache_t *kmem_cache_create(const char *name, unsigned long size,void (*ctor)(void *),void (*dtor)(void *))
{
    80003a7c:	fc010113          	addi	sp,sp,-64
    80003a80:	02113c23          	sd	ra,56(sp)
    80003a84:	02813823          	sd	s0,48(sp)
    80003a88:	02913423          	sd	s1,40(sp)
    80003a8c:	03213023          	sd	s2,32(sp)
    80003a90:	01313c23          	sd	s3,24(sp)
    80003a94:	01413823          	sd	s4,16(sp)
    80003a98:	01513423          	sd	s5,8(sp)
    80003a9c:	04010413          	addi	s0,sp,64
    80003aa0:	00050a93          	mv	s5,a0
    80003aa4:	00058913          	mv	s2,a1
    80003aa8:	00060a13          	mv	s4,a2
    80003aac:	00068993          	mv	s3,a3
    kmem_cache_t* cache = (kmem_cache_t*) bba_allocate(sizeof(kmem_cache_t));
    80003ab0:	05800513          	li	a0,88
    80003ab4:	ffffe097          	auipc	ra,0xffffe
    80003ab8:	fc0080e7          	jalr	-64(ra) # 80001a74 <_Z12bba_allocatem>
    80003abc:	00050493          	mv	s1,a0
    if(cache==0) return 0;
    80003ac0:	06050c63          	beqz	a0,80003b38 <_Z17kmem_cache_createPKcmPFvPvES3_+0xbc>

    if(size<SMALL_SIZE) cache->memorySize=SMALL_SLAB;
    80003ac4:	03f00793          	li	a5,63
    80003ac8:	0927ec63          	bltu	a5,s2,80003b60 <_Z17kmem_cache_createPKcmPFvPvES3_+0xe4>
    80003acc:	000017b7          	lui	a5,0x1
    80003ad0:	04f52423          	sw	a5,72(a0)
    else if(size<LARGE_SIZE) cache->memorySize=MEDIUM_SLAB;
    else cache->memorySize=LARGE_SLAB;

    cache->error=0;
    80003ad4:	0404a623          	sw	zero,76(s1)
    cache->slotsInSlab = cache->memorySize/size;
    80003ad8:	0484a783          	lw	a5,72(s1)
    80003adc:	0327d7b3          	divu	a5,a5,s2
    80003ae0:	04f4a823          	sw	a5,80(s1)
    cache->slotSize=size;
    80003ae4:	0324b023          	sd	s2,32(s1)
    cache->dtor=dtor;
    80003ae8:	0334b823          	sd	s3,48(s1)
    cache->ctor=ctor;
    80003aec:	0344b423          	sd	s4,40(s1)
    cache->emptySlabsHead=0;
    80003af0:	0004b023          	sd	zero,0(s1)
    cache->usedSlabsHead=0;
    80003af4:	0004b423          	sd	zero,8(s1)
    cache->fullSlabsHead=0;
    80003af8:	0004b823          	sd	zero,16(s1)
    kmem_strcpy(cache->name,name);
    80003afc:	000a8593          	mv	a1,s5
    80003b00:	03848513          	addi	a0,s1,56
    80003b04:	00000097          	auipc	ra,0x0
    80003b08:	d84080e7          	jalr	-636(ra) # 80003888 <_Z11kmem_strcpyPcPKc>

    kmem_slab_t * slab = kmem_slab_init(cache);
    80003b0c:	00048513          	mv	a0,s1
    80003b10:	00000097          	auipc	ra,0x0
    80003b14:	dfc080e7          	jalr	-516(ra) # 8000390c <_Z14kmem_slab_initP12kmem_cache_s>
    80003b18:	00050913          	mv	s2,a0
    if(slab==0){
    80003b1c:	06050263          	beqz	a0,80003b80 <_Z17kmem_cache_createPKcmPFvPvES3_+0x104>
        bba_free_block(cache);
        return 0;
    }
    cache->emptySlabsHead=slab;
    80003b20:	00a4b023          	sd	a0,0(s1)

    cache->nextCache=kmem_cache_head;
    80003b24:	0000c797          	auipc	a5,0xc
    80003b28:	7bc78793          	addi	a5,a5,1980 # 800102e0 <kmem_cache_head>
    80003b2c:	0007b703          	ld	a4,0(a5)
    80003b30:	00e4bc23          	sd	a4,24(s1)
    kmem_cache_head=cache;
    80003b34:	0097b023          	sd	s1,0(a5)
    return cache;
}
    80003b38:	00048513          	mv	a0,s1
    80003b3c:	03813083          	ld	ra,56(sp)
    80003b40:	03013403          	ld	s0,48(sp)
    80003b44:	02813483          	ld	s1,40(sp)
    80003b48:	02013903          	ld	s2,32(sp)
    80003b4c:	01813983          	ld	s3,24(sp)
    80003b50:	01013a03          	ld	s4,16(sp)
    80003b54:	00813a83          	ld	s5,8(sp)
    80003b58:	04010113          	addi	sp,sp,64
    80003b5c:	00008067          	ret
    else if(size<LARGE_SIZE) cache->memorySize=MEDIUM_SLAB;
    80003b60:	0ff00793          	li	a5,255
    80003b64:	0127e863          	bltu	a5,s2,80003b74 <_Z17kmem_cache_createPKcmPFvPvES3_+0xf8>
    80003b68:	000027b7          	lui	a5,0x2
    80003b6c:	04f52423          	sw	a5,72(a0)
    80003b70:	f65ff06f          	j	80003ad4 <_Z17kmem_cache_createPKcmPFvPvES3_+0x58>
    else cache->memorySize=LARGE_SLAB;
    80003b74:	000047b7          	lui	a5,0x4
    80003b78:	04f52423          	sw	a5,72(a0)
    80003b7c:	f59ff06f          	j	80003ad4 <_Z17kmem_cache_createPKcmPFvPvES3_+0x58>
        bba_free_block(cache);
    80003b80:	00048513          	mv	a0,s1
    80003b84:	ffffe097          	auipc	ra,0xffffe
    80003b88:	1b8080e7          	jalr	440(ra) # 80001d3c <_Z14bba_free_blockPKv>
        return 0;
    80003b8c:	00090493          	mv	s1,s2
    80003b90:	fa9ff06f          	j	80003b38 <_Z17kmem_cache_createPKcmPFvPvES3_+0xbc>

0000000080003b94 <_Z24kmem_slab_destoy_objectsP11kmem_slab_sP12kmem_cache_s>:

void kmem_slab_destoy_objects(kmem_slab_t* slab, kmem_cache_t* cache)
{
    80003b94:	fd010113          	addi	sp,sp,-48
    80003b98:	02113423          	sd	ra,40(sp)
    80003b9c:	02813023          	sd	s0,32(sp)
    80003ba0:	00913c23          	sd	s1,24(sp)
    80003ba4:	01213823          	sd	s2,16(sp)
    80003ba8:	01313423          	sd	s3,8(sp)
    80003bac:	03010413          	addi	s0,sp,48
    80003bb0:	00050913          	mv	s2,a0
    80003bb4:	00058993          	mv	s3,a1
    for(int i=0;i < (cache->slotsInSlab) && (slab->initializedSlotsCount>0); i++){
    80003bb8:	00000493          	li	s1,0
    80003bbc:	0080006f          	j	80003bc4 <_Z24kmem_slab_destoy_objectsP11kmem_slab_sP12kmem_cache_s+0x30>
    80003bc0:	0014849b          	addiw	s1,s1,1
    80003bc4:	0509a783          	lw	a5,80(s3)
    80003bc8:	06f4d063          	bge	s1,a5,80003c28 <_Z24kmem_slab_destoy_objectsP11kmem_slab_sP12kmem_cache_s+0x94>
    80003bcc:	00492783          	lw	a5,4(s2)
    80003bd0:	04f05c63          	blez	a5,80003c28 <_Z24kmem_slab_destoy_objectsP11kmem_slab_sP12kmem_cache_s+0x94>
       if(getBitmapValue(slab->initializedSlotsBitmap,i)==SLOT_INITIALIZED){
    80003bd4:	01093703          	ld	a4,16(s2)
    int wordPosition = position/8;
    80003bd8:	41f4d79b          	sraiw	a5,s1,0x1f
    80003bdc:	01d7d79b          	srliw	a5,a5,0x1d
    80003be0:	009787bb          	addw	a5,a5,s1
    80003be4:	4037d79b          	sraiw	a5,a5,0x3
    return (bitmapStart[wordPosition]>>position)&1;
    80003be8:	00f707b3          	add	a5,a4,a5
    80003bec:	0007c783          	lbu	a5,0(a5) # 4000 <_entry-0x7fffc000>
    80003bf0:	4097d7bb          	sraw	a5,a5,s1
    80003bf4:	0017f793          	andi	a5,a5,1
       if(getBitmapValue(slab->initializedSlotsBitmap,i)==SLOT_INITIALIZED){
    80003bf8:	fc0784e3          	beqz	a5,80003bc0 <_Z24kmem_slab_destoy_objectsP11kmem_slab_sP12kmem_cache_s+0x2c>
           cache->dtor((char*)(slab->memory)+i*cache->slotSize);
    80003bfc:	0309b703          	ld	a4,48(s3)
    80003c00:	00893503          	ld	a0,8(s2)
    80003c04:	0209b783          	ld	a5,32(s3)
    80003c08:	02f487b3          	mul	a5,s1,a5
    80003c0c:	00f50533          	add	a0,a0,a5
    80003c10:	000700e7          	jalr	a4
           slab->initializedSlotsCount--;
    80003c14:	00492783          	lw	a5,4(s2)
    80003c18:	fff7879b          	addiw	a5,a5,-1
    80003c1c:	0007871b          	sext.w	a4,a5
    80003c20:	00f92223          	sw	a5,4(s2)
           if(slab->initializedSlotsCount==0) return;
    80003c24:	f8071ee3          	bnez	a4,80003bc0 <_Z24kmem_slab_destoy_objectsP11kmem_slab_sP12kmem_cache_s+0x2c>
       }
    }
}
    80003c28:	02813083          	ld	ra,40(sp)
    80003c2c:	02013403          	ld	s0,32(sp)
    80003c30:	01813483          	ld	s1,24(sp)
    80003c34:	01013903          	ld	s2,16(sp)
    80003c38:	00813983          	ld	s3,8(sp)
    80003c3c:	03010113          	addi	sp,sp,48
    80003c40:	00008067          	ret

0000000080003c44 <_Z17kmem_cache_shrinkP12kmem_cache_s>:


int kmem_cache_shrink(kmem_cache_t *cachep)
{
    80003c44:	fd010113          	addi	sp,sp,-48
    80003c48:	02113423          	sd	ra,40(sp)
    80003c4c:	02813023          	sd	s0,32(sp)
    80003c50:	00913c23          	sd	s1,24(sp)
    80003c54:	01213823          	sd	s2,16(sp)
    80003c58:	01313423          	sd	s3,8(sp)
    80003c5c:	03010413          	addi	s0,sp,48
    80003c60:	00050913          	mv	s2,a0
    kmem_slab_t *curr = cachep->emptySlabsHead;
    80003c64:	00053483          	ld	s1,0(a0)
    kmem_slab_t *prev = 0;
    80003c68:	0300006f          	j	80003c98 <_Z17kmem_cache_shrinkP12kmem_cache_s+0x54>
    while (curr!=0){
        prev=curr;
        curr=curr->nextSlab;

        if(cachep->ctor!=0){
            kmem_slab_destoy_objects(prev,cachep);
    80003c6c:	00090593          	mv	a1,s2
    80003c70:	00048513          	mv	a0,s1
    80003c74:	00000097          	auipc	ra,0x0
    80003c78:	f20080e7          	jalr	-224(ra) # 80003b94 <_Z24kmem_slab_destoy_objectsP11kmem_slab_sP12kmem_cache_s>
        }

        bba_free_block(prev->memory);
    80003c7c:	0084b503          	ld	a0,8(s1)
    80003c80:	ffffe097          	auipc	ra,0xffffe
    80003c84:	0bc080e7          	jalr	188(ra) # 80001d3c <_Z14bba_free_blockPKv>
        bba_free_block(prev);
    80003c88:	00048513          	mv	a0,s1
    80003c8c:	ffffe097          	auipc	ra,0xffffe
    80003c90:	0b0080e7          	jalr	176(ra) # 80001d3c <_Z14bba_free_blockPKv>
        curr=curr->nextSlab;
    80003c94:	00098493          	mv	s1,s3
    while (curr!=0){
    80003c98:	00048a63          	beqz	s1,80003cac <_Z17kmem_cache_shrinkP12kmem_cache_s+0x68>
        curr=curr->nextSlab;
    80003c9c:	0204b983          	ld	s3,32(s1)
        if(cachep->ctor!=0){
    80003ca0:	02893783          	ld	a5,40(s2)
    80003ca4:	fc0794e3          	bnez	a5,80003c6c <_Z17kmem_cache_shrinkP12kmem_cache_s+0x28>
    80003ca8:	fd5ff06f          	j	80003c7c <_Z17kmem_cache_shrinkP12kmem_cache_s+0x38>
    }

    cachep->emptySlabsHead=0;
    80003cac:	00093023          	sd	zero,0(s2)
    return 0;
}
    80003cb0:	00000513          	li	a0,0
    80003cb4:	02813083          	ld	ra,40(sp)
    80003cb8:	02013403          	ld	s0,32(sp)
    80003cbc:	01813483          	ld	s1,24(sp)
    80003cc0:	01013903          	ld	s2,16(sp)
    80003cc4:	00813983          	ld	s3,8(sp)
    80003cc8:	03010113          	addi	sp,sp,48
    80003ccc:	00008067          	ret

0000000080003cd0 <_Z27kmem_slab_construct_objectsP11kmem_slab_sP12kmem_cache_s>:

//initialize up to ALLOCATION_CHUNK_SIZE objects in a given slab
void kmem_slab_construct_objects(kmem_slab_t *slab, kmem_cache_t *cache)
{
    80003cd0:	fc010113          	addi	sp,sp,-64
    80003cd4:	02113c23          	sd	ra,56(sp)
    80003cd8:	02813823          	sd	s0,48(sp)
    80003cdc:	02913423          	sd	s1,40(sp)
    80003ce0:	03213023          	sd	s2,32(sp)
    80003ce4:	01313c23          	sd	s3,24(sp)
    80003ce8:	01413823          	sd	s4,16(sp)
    80003cec:	01513423          	sd	s5,8(sp)
    80003cf0:	04010413          	addi	s0,sp,64
    80003cf4:	00050993          	mv	s3,a0
    80003cf8:	00058a13          	mv	s4,a1
    int count=0;
    for(int i=0;i<cache->slotsInSlab;i++){
    80003cfc:	00000913          	li	s2,0
    int count=0;
    80003d00:	00000a93          	li	s5,0
    80003d04:	0080006f          	j	80003d0c <_Z27kmem_slab_construct_objectsP11kmem_slab_sP12kmem_cache_s+0x3c>
    for(int i=0;i<cache->slotsInSlab;i++){
    80003d08:	0019091b          	addiw	s2,s2,1
    80003d0c:	050a2783          	lw	a5,80(s4)
    80003d10:	0af95863          	bge	s2,a5,80003dc0 <_Z27kmem_slab_construct_objectsP11kmem_slab_sP12kmem_cache_s+0xf0>
        if(getBitmapValue(slab->freeSlotsBitmap,i)==SLOT_FREE &&
    80003d14:	0189b783          	ld	a5,24(s3)
    int wordPosition = position/8;
    80003d18:	41f9549b          	sraiw	s1,s2,0x1f
    80003d1c:	01d4d49b          	srliw	s1,s1,0x1d
    80003d20:	012484bb          	addw	s1,s1,s2
    80003d24:	4034d49b          	sraiw	s1,s1,0x3
    return (bitmapStart[wordPosition]>>position)&1;
    80003d28:	009787b3          	add	a5,a5,s1
    80003d2c:	0007c783          	lbu	a5,0(a5)
    80003d30:	4127d7bb          	sraw	a5,a5,s2
    80003d34:	0017f793          	andi	a5,a5,1
        if(getBitmapValue(slab->freeSlotsBitmap,i)==SLOT_FREE &&
    80003d38:	fc0788e3          	beqz	a5,80003d08 <_Z27kmem_slab_construct_objectsP11kmem_slab_sP12kmem_cache_s+0x38>
           getBitmapValue(slab->initializedSlotsBitmap,i)!=SLOT_INITIALIZED)
    80003d3c:	0109b783          	ld	a5,16(s3)
    return (bitmapStart[wordPosition]>>position)&1;
    80003d40:	009787b3          	add	a5,a5,s1
    80003d44:	0007c783          	lbu	a5,0(a5)
    80003d48:	4127d7bb          	sraw	a5,a5,s2
    80003d4c:	0017f793          	andi	a5,a5,1
        if(getBitmapValue(slab->freeSlotsBitmap,i)==SLOT_FREE &&
    80003d50:	fa079ce3          	bnez	a5,80003d08 <_Z27kmem_slab_construct_objectsP11kmem_slab_sP12kmem_cache_s+0x38>
        {
            cache->ctor((char*)(slab->memory)+i*cache->slotSize);
    80003d54:	028a3703          	ld	a4,40(s4)
    80003d58:	0089b503          	ld	a0,8(s3)
    80003d5c:	020a3783          	ld	a5,32(s4)
    80003d60:	02f907b3          	mul	a5,s2,a5
    80003d64:	00f50533          	add	a0,a0,a5
    80003d68:	000700e7          	jalr	a4
            slab->initializedSlotsCount++;
    80003d6c:	0049a783          	lw	a5,4(s3)
    80003d70:	0017879b          	addiw	a5,a5,1
    80003d74:	00f9a223          	sw	a5,4(s3)
            setBitmapValue(slab->initializedSlotsBitmap,i,SLOT_INITIALIZED);
    80003d78:	0109b703          	ld	a4,16(s3)
    int bitPosition = position%8;
    80003d7c:	41f9579b          	sraiw	a5,s2,0x1f
    80003d80:	01d7d69b          	srliw	a3,a5,0x1d
    80003d84:	012687bb          	addw	a5,a3,s2
    80003d88:	0077f793          	andi	a5,a5,7
    80003d8c:	40d787bb          	subw	a5,a5,a3
        bitmapStart[wordPosition] = bitmapStart[wordPosition] | (1<<bitPosition);
    80003d90:	009704b3          	add	s1,a4,s1
    80003d94:	00048703          	lb	a4,0(s1)
    80003d98:	00100693          	li	a3,1
    80003d9c:	00f697bb          	sllw	a5,a3,a5
    80003da0:	00f767b3          	or	a5,a4,a5
    80003da4:	00f48023          	sb	a5,0(s1)
            count++;
    80003da8:	001a8a9b          	addiw	s5,s5,1
            if(count==ALLOCATION_CHUNK_SIZE || slab->initializedSlotsCount==cache->slotsInSlab) return;
    80003dac:	01000793          	li	a5,16
    80003db0:	00fa8863          	beq	s5,a5,80003dc0 <_Z27kmem_slab_construct_objectsP11kmem_slab_sP12kmem_cache_s+0xf0>
    80003db4:	0049a703          	lw	a4,4(s3)
    80003db8:	050a2783          	lw	a5,80(s4)
    80003dbc:	f4f716e3          	bne	a4,a5,80003d08 <_Z27kmem_slab_construct_objectsP11kmem_slab_sP12kmem_cache_s+0x38>
        }
    }
}
    80003dc0:	03813083          	ld	ra,56(sp)
    80003dc4:	03013403          	ld	s0,48(sp)
    80003dc8:	02813483          	ld	s1,40(sp)
    80003dcc:	02013903          	ld	s2,32(sp)
    80003dd0:	01813983          	ld	s3,24(sp)
    80003dd4:	01013a03          	ld	s4,16(sp)
    80003dd8:	00813a83          	ld	s5,8(sp)
    80003ddc:	04010113          	addi	sp,sp,64
    80003de0:	00008067          	ret

0000000080003de4 <_Z25kmem_slab_get_free_objectP11kmem_slab_sP12kmem_cache_s>:



void* kmem_slab_get_free_object(kmem_slab_t *slab, kmem_cache_t *cache)
{
    80003de4:	ff010113          	addi	sp,sp,-16
    80003de8:	00813423          	sd	s0,8(sp)
    80003dec:	01010413          	addi	s0,sp,16
    int charCnt = (cache->slotsInSlab+8-1)/8;
    80003df0:	0505a783          	lw	a5,80(a1)
    80003df4:	0077871b          	addiw	a4,a5,7
    80003df8:	41f7579b          	sraiw	a5,a4,0x1f
    80003dfc:	01d7d79b          	srliw	a5,a5,0x1d
    80003e00:	00e787bb          	addw	a5,a5,a4
    80003e04:	4037d79b          	sraiw	a5,a5,0x3
    for(int i=0;i<charCnt;i++){
    80003e08:	00000693          	li	a3,0
    80003e0c:	0af6d263          	bge	a3,a5,80003eb0 <_Z25kmem_slab_get_free_objectP11kmem_slab_sP12kmem_cache_s+0xcc>
        char c = slab->freeSlotsBitmap[i];
    80003e10:	01853803          	ld	a6,24(a0)
    80003e14:	00d80733          	add	a4,a6,a3
    80003e18:	00074603          	lbu	a2,0(a4)
        if(c==0) continue; //a quick way to check 8 slots at once
    80003e1c:	02060263          	beqz	a2,80003e40 <_Z25kmem_slab_get_free_objectP11kmem_slab_sP12kmem_cache_s+0x5c>
        int k = 0;
    80003e20:	00000793          	li	a5,0
        while(k<8){
    80003e24:	00700713          	li	a4,7
    80003e28:	02f74063          	blt	a4,a5,80003e48 <_Z25kmem_slab_get_free_objectP11kmem_slab_sP12kmem_cache_s+0x64>
            if( ((c>>k)&1) == SLOT_FREE) break;
    80003e2c:	40f6573b          	sraw	a4,a2,a5
    80003e30:	00177713          	andi	a4,a4,1
    80003e34:	00071a63          	bnez	a4,80003e48 <_Z25kmem_slab_get_free_objectP11kmem_slab_sP12kmem_cache_s+0x64>
            k++;
    80003e38:	0017879b          	addiw	a5,a5,1
        while(k<8){
    80003e3c:	fe9ff06f          	j	80003e24 <_Z25kmem_slab_get_free_objectP11kmem_slab_sP12kmem_cache_s+0x40>
    for(int i=0;i<charCnt;i++){
    80003e40:	0016869b          	addiw	a3,a3,1
    80003e44:	fc9ff06f          	j	80003e0c <_Z25kmem_slab_get_free_objectP11kmem_slab_sP12kmem_cache_s+0x28>
        }

        slab->usedSlotsCount++;
    80003e48:	00052703          	lw	a4,0(a0)
    80003e4c:	0017071b          	addiw	a4,a4,1
    80003e50:	00e52023          	sw	a4,0(a0)
        setBitmapValue(slab->freeSlotsBitmap,i*8+k,SLOT_TAKEN);
    80003e54:	0036969b          	slliw	a3,a3,0x3
    80003e58:	00f687bb          	addw	a5,a3,a5
    80003e5c:	0007869b          	sext.w	a3,a5
    int wordPosition = position/8;
    80003e60:	41f7d71b          	sraiw	a4,a5,0x1f
    80003e64:	01d7571b          	srliw	a4,a4,0x1d
    80003e68:	00f707bb          	addw	a5,a4,a5
    80003e6c:	4037d61b          	sraiw	a2,a5,0x3
    int bitPosition = position%8;
    80003e70:	0077f793          	andi	a5,a5,7
    80003e74:	40e787bb          	subw	a5,a5,a4
        bitmapStart[wordPosition] = bitmapStart[wordPosition] & (~(1<<bitPosition));
    80003e78:	00c80833          	add	a6,a6,a2
    80003e7c:	00080603          	lb	a2,0(a6)
    80003e80:	00100713          	li	a4,1
    80003e84:	00f717bb          	sllw	a5,a4,a5
    80003e88:	fff7c793          	not	a5,a5
    80003e8c:	00f677b3          	and	a5,a2,a5
    80003e90:	00f80023          	sb	a5,0(a6)
        return ((char*)slab->memory+(i*8+k)*cache->slotSize);
    80003e94:	00853503          	ld	a0,8(a0)
    80003e98:	0205b783          	ld	a5,32(a1)
    80003e9c:	02f687b3          	mul	a5,a3,a5
    80003ea0:	00f50533          	add	a0,a0,a5
    }
    return 0;
}
    80003ea4:	00813403          	ld	s0,8(sp)
    80003ea8:	01010113          	addi	sp,sp,16
    80003eac:	00008067          	ret
    return 0;
    80003eb0:	00000513          	li	a0,0
    80003eb4:	ff1ff06f          	j	80003ea4 <_Z25kmem_slab_get_free_objectP11kmem_slab_sP12kmem_cache_s+0xc0>

0000000080003eb8 <_Z37kmem_slab_get_initialized_free_objectP11kmem_slab_sP12kmem_cache_s>:

void* kmem_slab_get_initialized_free_object(kmem_slab_t *slab, kmem_cache_t *cache)
{
    80003eb8:	ff010113          	addi	sp,sp,-16
    80003ebc:	00813423          	sd	s0,8(sp)
    80003ec0:	01010413          	addi	s0,sp,16
    int charCnt = (cache->slotsInSlab+8-1)/8;
    80003ec4:	0505a783          	lw	a5,80(a1)
    80003ec8:	0077871b          	addiw	a4,a5,7
    80003ecc:	41f7579b          	sraiw	a5,a4,0x1f
    80003ed0:	01d7d79b          	srliw	a5,a5,0x1d
    80003ed4:	00e787bb          	addw	a5,a5,a4
    80003ed8:	4037d79b          	sraiw	a5,a5,0x3
    for(int i=0;i<charCnt;i++){
    80003edc:	00000693          	li	a3,0
    80003ee0:	0af6de63          	bge	a3,a5,80003f9c <_Z37kmem_slab_get_initialized_free_objectP11kmem_slab_sP12kmem_cache_s+0xe4>
        char c = (char)(slab->initializedSlotsBitmap[i]&slab->freeSlotsBitmap[i]);
    80003ee4:	01053703          	ld	a4,16(a0)
    80003ee8:	00d70733          	add	a4,a4,a3
    80003eec:	00074603          	lbu	a2,0(a4)
    80003ef0:	01853883          	ld	a7,24(a0)
    80003ef4:	00d88733          	add	a4,a7,a3
    80003ef8:	00074703          	lbu	a4,0(a4)
    80003efc:	00e67633          	and	a2,a2,a4
        if(c==0) continue; //a quick way to check 8 slots at once
    80003f00:	02060663          	beqz	a2,80003f2c <_Z37kmem_slab_get_initialized_free_objectP11kmem_slab_sP12kmem_cache_s+0x74>
        int k = 0;
    80003f04:	00000713          	li	a4,0
        while(k<8){
    80003f08:	00700793          	li	a5,7
    80003f0c:	02e7c463          	blt	a5,a4,80003f34 <_Z37kmem_slab_get_initialized_free_objectP11kmem_slab_sP12kmem_cache_s+0x7c>
            if( (c&(1<<k)) == SLOT_INITIALIZED) break;
    80003f10:	00100793          	li	a5,1
    80003f14:	00e797bb          	sllw	a5,a5,a4
    80003f18:	00f677b3          	and	a5,a2,a5
    80003f1c:	00100813          	li	a6,1
    80003f20:	01078a63          	beq	a5,a6,80003f34 <_Z37kmem_slab_get_initialized_free_objectP11kmem_slab_sP12kmem_cache_s+0x7c>
            k++;
    80003f24:	0017071b          	addiw	a4,a4,1
        while(k<8){
    80003f28:	fe1ff06f          	j	80003f08 <_Z37kmem_slab_get_initialized_free_objectP11kmem_slab_sP12kmem_cache_s+0x50>
    for(int i=0;i<charCnt;i++){
    80003f2c:	0016869b          	addiw	a3,a3,1
    80003f30:	fb1ff06f          	j	80003ee0 <_Z37kmem_slab_get_initialized_free_objectP11kmem_slab_sP12kmem_cache_s+0x28>
        }

        slab->usedSlotsCount++;
    80003f34:	00052783          	lw	a5,0(a0)
    80003f38:	0017879b          	addiw	a5,a5,1
    80003f3c:	00f52023          	sw	a5,0(a0)
        setBitmapValue(slab->freeSlotsBitmap,i*8+k,SLOT_TAKEN);
    80003f40:	0036969b          	slliw	a3,a3,0x3
    80003f44:	00e6873b          	addw	a4,a3,a4
    80003f48:	0007069b          	sext.w	a3,a4
    int wordPosition = position/8;
    80003f4c:	41f7579b          	sraiw	a5,a4,0x1f
    80003f50:	01d7d79b          	srliw	a5,a5,0x1d
    80003f54:	00e7873b          	addw	a4,a5,a4
    80003f58:	4037561b          	sraiw	a2,a4,0x3
    int bitPosition = position%8;
    80003f5c:	00777713          	andi	a4,a4,7
    80003f60:	40f7073b          	subw	a4,a4,a5
        bitmapStart[wordPosition] = bitmapStart[wordPosition] & (~(1<<bitPosition));
    80003f64:	00c888b3          	add	a7,a7,a2
    80003f68:	00088603          	lb	a2,0(a7)
    80003f6c:	00100793          	li	a5,1
    80003f70:	00e7973b          	sllw	a4,a5,a4
    80003f74:	fff74713          	not	a4,a4
    80003f78:	00e67733          	and	a4,a2,a4
    80003f7c:	00e88023          	sb	a4,0(a7)
        return ((char*)slab->memory+(i*8+k)*cache->slotSize);
    80003f80:	00853503          	ld	a0,8(a0)
    80003f84:	0205b783          	ld	a5,32(a1)
    80003f88:	02f687b3          	mul	a5,a3,a5
    80003f8c:	00f50533          	add	a0,a0,a5
    }
    return 0;
}
    80003f90:	00813403          	ld	s0,8(sp)
    80003f94:	01010113          	addi	sp,sp,16
    80003f98:	00008067          	ret
    return 0;
    80003f9c:	00000513          	li	a0,0
    80003fa0:	ff1ff06f          	j	80003f90 <_Z37kmem_slab_get_initialized_free_objectP11kmem_slab_sP12kmem_cache_s+0xd8>

0000000080003fa4 <_Z31kmem_cache_alloc_no_constructorP12kmem_cache_s>:


void *kmem_cache_alloc_no_constructor(kmem_cache_t* cachep)
{
    80003fa4:	fe010113          	addi	sp,sp,-32
    80003fa8:	00113c23          	sd	ra,24(sp)
    80003fac:	00813823          	sd	s0,16(sp)
    80003fb0:	00913423          	sd	s1,8(sp)
    80003fb4:	02010413          	addi	s0,sp,32
    80003fb8:	00050493          	mv	s1,a0
    if(cachep->usedSlabsHead==0){
    80003fbc:	00853503          	ld	a0,8(a0)
    80003fc0:	04051863          	bnez	a0,80004010 <_Z31kmem_cache_alloc_no_constructorP12kmem_cache_s+0x6c>
        if(cachep->emptySlabsHead==0){
    80003fc4:	0004b783          	ld	a5,0(s1)
    80003fc8:	02078a63          	beqz	a5,80003ffc <_Z31kmem_cache_alloc_no_constructorP12kmem_cache_s+0x58>
            cachep->usedSlabsHead = kmem_slab_init(cachep);
        }
        else {
            cachep->usedSlabsHead=cachep->emptySlabsHead;
    80003fcc:	00f4b423          	sd	a5,8(s1)
            cachep->emptySlabsHead=cachep->emptySlabsHead->nextSlab;
    80003fd0:	0207b783          	ld	a5,32(a5)
    80003fd4:	00f4b023          	sd	a5,0(s1)
        }
        return kmem_slab_get_free_object(cachep->usedSlabsHead,cachep);
    80003fd8:	00048593          	mv	a1,s1
    80003fdc:	0084b503          	ld	a0,8(s1)
    80003fe0:	00000097          	auipc	ra,0x0
    80003fe4:	e04080e7          	jalr	-508(ra) # 80003de4 <_Z25kmem_slab_get_free_objectP11kmem_slab_sP12kmem_cache_s>
            head->nextSlab=cachep->fullSlabsHead;
            cachep->fullSlabsHead=head;
        }
        return result;
    }
}
    80003fe8:	01813083          	ld	ra,24(sp)
    80003fec:	01013403          	ld	s0,16(sp)
    80003ff0:	00813483          	ld	s1,8(sp)
    80003ff4:	02010113          	addi	sp,sp,32
    80003ff8:	00008067          	ret
            cachep->usedSlabsHead = kmem_slab_init(cachep);
    80003ffc:	00048513          	mv	a0,s1
    80004000:	00000097          	auipc	ra,0x0
    80004004:	90c080e7          	jalr	-1780(ra) # 8000390c <_Z14kmem_slab_initP12kmem_cache_s>
    80004008:	00a4b423          	sd	a0,8(s1)
    8000400c:	fcdff06f          	j	80003fd8 <_Z31kmem_cache_alloc_no_constructorP12kmem_cache_s+0x34>
        void* result = kmem_slab_get_free_object(cachep->usedSlabsHead,cachep);
    80004010:	00048593          	mv	a1,s1
    80004014:	00000097          	auipc	ra,0x0
    80004018:	dd0080e7          	jalr	-560(ra) # 80003de4 <_Z25kmem_slab_get_free_objectP11kmem_slab_sP12kmem_cache_s>
        kmem_slab_t* head = cachep->usedSlabsHead;
    8000401c:	0084b783          	ld	a5,8(s1)
        if(head->usedSlotsCount==cachep->slotsInSlab){
    80004020:	0007a683          	lw	a3,0(a5)
    80004024:	0504a703          	lw	a4,80(s1)
    80004028:	fce690e3          	bne	a3,a4,80003fe8 <_Z31kmem_cache_alloc_no_constructorP12kmem_cache_s+0x44>
            cachep->usedSlabsHead=head->nextSlab;
    8000402c:	0207b703          	ld	a4,32(a5)
    80004030:	00e4b423          	sd	a4,8(s1)
            head->nextSlab=cachep->fullSlabsHead;
    80004034:	0104b703          	ld	a4,16(s1)
    80004038:	02e7b023          	sd	a4,32(a5)
            cachep->fullSlabsHead=head;
    8000403c:	00f4b823          	sd	a5,16(s1)
        return result;
    80004040:	fa9ff06f          	j	80003fe8 <_Z31kmem_cache_alloc_no_constructorP12kmem_cache_s+0x44>

0000000080004044 <_Z28kmem_cache_alloc_constructorP12kmem_cache_s>:


void *kmem_cache_alloc_constructor(kmem_cache_t *cachep)
{
    80004044:	fd010113          	addi	sp,sp,-48
    80004048:	02113423          	sd	ra,40(sp)
    8000404c:	02813023          	sd	s0,32(sp)
    80004050:	00913c23          	sd	s1,24(sp)
    80004054:	01213823          	sd	s2,16(sp)
    80004058:	01313423          	sd	s3,8(sp)
    8000405c:	03010413          	addi	s0,sp,48
    80004060:	00050913          	mv	s2,a0
    if(cachep->usedSlabsHead==0){
    80004064:	00853983          	ld	s3,8(a0)
    80004068:	02098063          	beqz	s3,80004088 <_Z28kmem_cache_alloc_constructorP12kmem_cache_s+0x44>
            cachep->emptySlabsHead=cachep->emptySlabsHead->nextSlab;
        }
        return kmem_slab_get_initialized_free_object(cachep->usedSlabsHead,cachep);
    }
    else{
        kmem_slab_t* target = cachep->usedSlabsHead;
    8000406c:	00098493          	mv	s1,s3
        while (target!=0){
    80004070:	06048463          	beqz	s1,800040d8 <_Z28kmem_cache_alloc_constructorP12kmem_cache_s+0x94>
            if(target->initializedSlotsCount>target->usedSlotsCount) break;
    80004074:	0044a703          	lw	a4,4(s1)
    80004078:	0004a783          	lw	a5,0(s1)
    8000407c:	04e7ce63          	blt	a5,a4,800040d8 <_Z28kmem_cache_alloc_constructorP12kmem_cache_s+0x94>
            target=target->nextSlab;
    80004080:	0204b483          	ld	s1,32(s1)
        while (target!=0){
    80004084:	fedff06f          	j	80004070 <_Z28kmem_cache_alloc_constructorP12kmem_cache_s+0x2c>
        if(cachep->emptySlabsHead==0){
    80004088:	00053783          	ld	a5,0(a0)
    8000408c:	02078e63          	beqz	a5,800040c8 <_Z28kmem_cache_alloc_constructorP12kmem_cache_s+0x84>
            cachep->usedSlabsHead=cachep->emptySlabsHead;
    80004090:	00f53423          	sd	a5,8(a0)
            cachep->emptySlabsHead=cachep->emptySlabsHead->nextSlab;
    80004094:	0207b783          	ld	a5,32(a5)
    80004098:	00f53023          	sd	a5,0(a0)
        return kmem_slab_get_initialized_free_object(cachep->usedSlabsHead,cachep);
    8000409c:	00090593          	mv	a1,s2
    800040a0:	00893503          	ld	a0,8(s2)
    800040a4:	00000097          	auipc	ra,0x0
    800040a8:	e14080e7          	jalr	-492(ra) # 80003eb8 <_Z37kmem_slab_get_initialized_free_objectP11kmem_slab_sP12kmem_cache_s>
            target->nextSlab=cachep->fullSlabsHead;
            cachep->fullSlabsHead=target;
        }
        return result;
    }
}
    800040ac:	02813083          	ld	ra,40(sp)
    800040b0:	02013403          	ld	s0,32(sp)
    800040b4:	01813483          	ld	s1,24(sp)
    800040b8:	01013903          	ld	s2,16(sp)
    800040bc:	00813983          	ld	s3,8(sp)
    800040c0:	03010113          	addi	sp,sp,48
    800040c4:	00008067          	ret
            cachep->usedSlabsHead = kmem_slab_init(cachep);
    800040c8:	00000097          	auipc	ra,0x0
    800040cc:	844080e7          	jalr	-1980(ra) # 8000390c <_Z14kmem_slab_initP12kmem_cache_s>
    800040d0:	00a93423          	sd	a0,8(s2)
    800040d4:	fc9ff06f          	j	8000409c <_Z28kmem_cache_alloc_constructorP12kmem_cache_s+0x58>
        if(target==0){
    800040d8:	04048663          	beqz	s1,80004124 <_Z28kmem_cache_alloc_constructorP12kmem_cache_s+0xe0>
        void* result = kmem_slab_get_initialized_free_object(target,cachep);
    800040dc:	00090593          	mv	a1,s2
    800040e0:	00048513          	mv	a0,s1
    800040e4:	00000097          	auipc	ra,0x0
    800040e8:	dd4080e7          	jalr	-556(ra) # 80003eb8 <_Z37kmem_slab_get_initialized_free_objectP11kmem_slab_sP12kmem_cache_s>
        if(target->usedSlotsCount==cachep->slotsInSlab){
    800040ec:	0004a703          	lw	a4,0(s1)
    800040f0:	05092783          	lw	a5,80(s2)
    800040f4:	faf71ce3          	bne	a4,a5,800040ac <_Z28kmem_cache_alloc_constructorP12kmem_cache_s+0x68>
            if(target==cachep->usedSlabsHead){
    800040f8:	00893783          	ld	a5,8(s2)
    800040fc:	04978063          	beq	a5,s1,8000413c <_Z28kmem_cache_alloc_constructorP12kmem_cache_s+0xf8>
                while (prev->nextSlab!=target) prev=prev->nextSlab;
    80004100:	00078713          	mv	a4,a5
    80004104:	0207b783          	ld	a5,32(a5)
    80004108:	fe979ce3          	bne	a5,s1,80004100 <_Z28kmem_cache_alloc_constructorP12kmem_cache_s+0xbc>
                prev->nextSlab=target->nextSlab;
    8000410c:	0204b783          	ld	a5,32(s1)
    80004110:	02f73023          	sd	a5,32(a4)
            target->nextSlab=cachep->fullSlabsHead;
    80004114:	01093783          	ld	a5,16(s2)
    80004118:	02f4b023          	sd	a5,32(s1)
            cachep->fullSlabsHead=target;
    8000411c:	00993823          	sd	s1,16(s2)
        return result;
    80004120:	f8dff06f          	j	800040ac <_Z28kmem_cache_alloc_constructorP12kmem_cache_s+0x68>
            kmem_slab_construct_objects(target,cachep);
    80004124:	00090593          	mv	a1,s2
    80004128:	00098513          	mv	a0,s3
    8000412c:	00000097          	auipc	ra,0x0
    80004130:	ba4080e7          	jalr	-1116(ra) # 80003cd0 <_Z27kmem_slab_construct_objectsP11kmem_slab_sP12kmem_cache_s>
            target=cachep->usedSlabsHead;
    80004134:	00098493          	mv	s1,s3
    80004138:	fa5ff06f          	j	800040dc <_Z28kmem_cache_alloc_constructorP12kmem_cache_s+0x98>
                cachep->usedSlabsHead=target->nextSlab;
    8000413c:	0204b783          	ld	a5,32(s1)
    80004140:	00f93423          	sd	a5,8(s2)
    80004144:	fd1ff06f          	j	80004114 <_Z28kmem_cache_alloc_constructorP12kmem_cache_s+0xd0>

0000000080004148 <_Z16kmem_cache_allocP12kmem_cache_s>:

void *kmem_cache_alloc(kmem_cache_t* cachep){
    80004148:	ff010113          	addi	sp,sp,-16
    8000414c:	00113423          	sd	ra,8(sp)
    80004150:	00813023          	sd	s0,0(sp)
    80004154:	01010413          	addi	s0,sp,16
    if(cachep->ctor!=0) return kmem_cache_alloc_constructor(cachep);
    80004158:	02853783          	ld	a5,40(a0)
    8000415c:	00078e63          	beqz	a5,80004178 <_Z16kmem_cache_allocP12kmem_cache_s+0x30>
    80004160:	00000097          	auipc	ra,0x0
    80004164:	ee4080e7          	jalr	-284(ra) # 80004044 <_Z28kmem_cache_alloc_constructorP12kmem_cache_s>
    else return kmem_cache_alloc_no_constructor(cachep);
}
    80004168:	00813083          	ld	ra,8(sp)
    8000416c:	00013403          	ld	s0,0(sp)
    80004170:	01010113          	addi	sp,sp,16
    80004174:	00008067          	ret
    else return kmem_cache_alloc_no_constructor(cachep);
    80004178:	00000097          	auipc	ra,0x0
    8000417c:	e2c080e7          	jalr	-468(ra) # 80003fa4 <_Z31kmem_cache_alloc_no_constructorP12kmem_cache_s>
    80004180:	fe9ff06f          	j	80004168 <_Z16kmem_cache_allocP12kmem_cache_s+0x20>

0000000080004184 <_Z15kmem_cache_freeP12kmem_cache_sPv>:

// Deallocate one object from cache
void kmem_cache_free(kmem_cache_t *cachep, void *objp)
{
    80004184:	ff010113          	addi	sp,sp,-16
    80004188:	00813423          	sd	s0,8(sp)
    8000418c:	01010413          	addi	s0,sp,16
    //look for the object amongst nonfull slabs
    kmem_slab_t* curr = cachep->usedSlabsHead;
    80004190:	00853783          	ld	a5,8(a0)
    kmem_slab_t* prev = 0;
    80004194:	00000613          	li	a2,0
    80004198:	0180006f          	j	800041b0 <_Z15kmem_cache_freeP12kmem_cache_sPv+0x2c>
            int positionInSlab = ((char*)objp - (char*)curr->memory)/cachep->slotSize;
            setBitmapValue(curr->freeSlotsBitmap,positionInSlab,SLOT_FREE);
            curr->usedSlotsCount--;
            if(curr->usedSlotsCount==0){
                if(prev==0){
                    cachep->usedSlabsHead=curr->nextSlab;
    8000419c:	0207b703          	ld	a4,32(a5)
    800041a0:	00e53423          	sd	a4,8(a0)
    800041a4:	0840006f          	j	80004228 <_Z15kmem_cache_freeP12kmem_cache_sPv+0xa4>
                curr->nextSlab=cachep->emptySlabsHead;
                cachep->emptySlabsHead=curr;
            }
            return;
        }
        prev=curr;
    800041a8:	00078613          	mv	a2,a5
        curr=curr->nextSlab;
    800041ac:	0207b783          	ld	a5,32(a5)
    while(curr!=0){
    800041b0:	08078463          	beqz	a5,80004238 <_Z15kmem_cache_freeP12kmem_cache_sPv+0xb4>
        if(objp>curr->memory && objp<((char*)(curr->memory)+cachep->memorySize)){
    800041b4:	0087b703          	ld	a4,8(a5)
    800041b8:	feb778e3          	bgeu	a4,a1,800041a8 <_Z15kmem_cache_freeP12kmem_cache_sPv+0x24>
    800041bc:	04852683          	lw	a3,72(a0)
    800041c0:	00d706b3          	add	a3,a4,a3
    800041c4:	fed5f2e3          	bgeu	a1,a3,800041a8 <_Z15kmem_cache_freeP12kmem_cache_sPv+0x24>
            int positionInSlab = ((char*)objp - (char*)curr->memory)/cachep->slotSize;
    800041c8:	40e58733          	sub	a4,a1,a4
    800041cc:	02053583          	ld	a1,32(a0)
    800041d0:	02b75733          	divu	a4,a4,a1
            setBitmapValue(curr->freeSlotsBitmap,positionInSlab,SLOT_FREE);
    800041d4:	0187b683          	ld	a3,24(a5)
    int wordPosition = position/8;
    800041d8:	41f7559b          	sraiw	a1,a4,0x1f
    800041dc:	01d5d59b          	srliw	a1,a1,0x1d
    800041e0:	00e5873b          	addw	a4,a1,a4
    800041e4:	4037581b          	sraiw	a6,a4,0x3
    int bitPosition = position%8;
    800041e8:	00777713          	andi	a4,a4,7
    800041ec:	40b7073b          	subw	a4,a4,a1
        bitmapStart[wordPosition] = bitmapStart[wordPosition] | (1<<bitPosition);
    800041f0:	010686b3          	add	a3,a3,a6
    800041f4:	00068583          	lb	a1,0(a3)
    800041f8:	00100813          	li	a6,1
    800041fc:	00e8173b          	sllw	a4,a6,a4
    80004200:	00e5e733          	or	a4,a1,a4
    80004204:	00e68023          	sb	a4,0(a3)
            curr->usedSlotsCount--;
    80004208:	0007a703          	lw	a4,0(a5)
    8000420c:	fff7071b          	addiw	a4,a4,-1
    80004210:	0007069b          	sext.w	a3,a4
    80004214:	00e7a023          	sw	a4,0(a5)
            if(curr->usedSlotsCount==0){
    80004218:	0a069c63          	bnez	a3,800042d0 <_Z15kmem_cache_freeP12kmem_cache_sPv+0x14c>
                if(prev==0){
    8000421c:	f80600e3          	beqz	a2,8000419c <_Z15kmem_cache_freeP12kmem_cache_sPv+0x18>
                    prev->nextSlab=curr->nextSlab;
    80004220:	0207b703          	ld	a4,32(a5)
    80004224:	02e63023          	sd	a4,32(a2)
                curr->nextSlab=cachep->emptySlabsHead;
    80004228:	00053703          	ld	a4,0(a0)
    8000422c:	02e7b023          	sd	a4,32(a5)
                cachep->emptySlabsHead=curr;
    80004230:	00f53023          	sd	a5,0(a0)
            return;
    80004234:	09c0006f          	j	800042d0 <_Z15kmem_cache_freeP12kmem_cache_sPv+0x14c>
    }

    //amongst full slabs
    curr=cachep->fullSlabsHead;
    80004238:	01053703          	ld	a4,16(a0)
    prev=0;
    8000423c:	0180006f          	j	80004254 <_Z15kmem_cache_freeP12kmem_cache_sPv+0xd0>
        if(objp>curr->memory && objp<((char*)(curr->memory)+cachep->memorySize)){
            int positionInSlab = ((char*)objp - (char*)curr->memory)/cachep->slotSize;
            setBitmapValue(curr->freeSlotsBitmap,positionInSlab,SLOT_FREE);
            curr->usedSlotsCount--;
            if(prev==0){
                cachep->fullSlabsHead=curr->nextSlab;
    80004240:	02073783          	ld	a5,32(a4)
    80004244:	00f53823          	sd	a5,16(a0)
    80004248:	07c0006f          	j	800042c4 <_Z15kmem_cache_freeP12kmem_cache_sPv+0x140>
            }
            curr->nextSlab=cachep->usedSlabsHead;
            cachep->usedSlabsHead=curr;
            return;
        }
        prev=curr;
    8000424c:	00070793          	mv	a5,a4
        curr=curr->nextSlab;
    80004250:	02073703          	ld	a4,32(a4)
    while(curr!=0){
    80004254:	06070e63          	beqz	a4,800042d0 <_Z15kmem_cache_freeP12kmem_cache_sPv+0x14c>
        if(objp>curr->memory && objp<((char*)(curr->memory)+cachep->memorySize)){
    80004258:	00873683          	ld	a3,8(a4)
    8000425c:	feb6f8e3          	bgeu	a3,a1,8000424c <_Z15kmem_cache_freeP12kmem_cache_sPv+0xc8>
    80004260:	04852603          	lw	a2,72(a0)
    80004264:	00c68633          	add	a2,a3,a2
    80004268:	fec5f2e3          	bgeu	a1,a2,8000424c <_Z15kmem_cache_freeP12kmem_cache_sPv+0xc8>
            int positionInSlab = ((char*)objp - (char*)curr->memory)/cachep->slotSize;
    8000426c:	40d586b3          	sub	a3,a1,a3
    80004270:	02053583          	ld	a1,32(a0)
    80004274:	02b6d6b3          	divu	a3,a3,a1
            setBitmapValue(curr->freeSlotsBitmap,positionInSlab,SLOT_FREE);
    80004278:	01873603          	ld	a2,24(a4)
    int wordPosition = position/8;
    8000427c:	41f6d59b          	sraiw	a1,a3,0x1f
    80004280:	01d5d59b          	srliw	a1,a1,0x1d
    80004284:	00d586bb          	addw	a3,a1,a3
    80004288:	4036d81b          	sraiw	a6,a3,0x3
    int bitPosition = position%8;
    8000428c:	0076f693          	andi	a3,a3,7
    80004290:	40b686bb          	subw	a3,a3,a1
        bitmapStart[wordPosition] = bitmapStart[wordPosition] | (1<<bitPosition);
    80004294:	01060633          	add	a2,a2,a6
    80004298:	00060583          	lb	a1,0(a2)
    8000429c:	00100813          	li	a6,1
    800042a0:	00d816bb          	sllw	a3,a6,a3
    800042a4:	00d5e6b3          	or	a3,a1,a3
    800042a8:	00d60023          	sb	a3,0(a2)
            curr->usedSlotsCount--;
    800042ac:	00072683          	lw	a3,0(a4)
    800042b0:	fff6869b          	addiw	a3,a3,-1
    800042b4:	00d72023          	sw	a3,0(a4)
            if(prev==0){
    800042b8:	f80784e3          	beqz	a5,80004240 <_Z15kmem_cache_freeP12kmem_cache_sPv+0xbc>
                prev->nextSlab=curr->nextSlab;
    800042bc:	02073683          	ld	a3,32(a4)
    800042c0:	02d7b023          	sd	a3,32(a5)
            curr->nextSlab=cachep->usedSlabsHead;
    800042c4:	00853783          	ld	a5,8(a0)
    800042c8:	02f73023          	sd	a5,32(a4)
            cachep->usedSlabsHead=curr;
    800042cc:	00e53423          	sd	a4,8(a0)
    }
}
    800042d0:	00813403          	ld	s0,8(sp)
    800042d4:	01010113          	addi	sp,sp,16
    800042d8:	00008067          	ret

00000000800042dc <_Z7kmallocm>:

// Alloacate one small memory buffer
void *kmalloc(unsigned long size)
{
    800042dc:	ff010113          	addi	sp,sp,-16
    800042e0:	00113423          	sd	ra,8(sp)
    800042e4:	00813023          	sd	s0,0(sp)
    800042e8:	01010413          	addi	s0,sp,16
    return bba_allocate(size);
    800042ec:	ffffd097          	auipc	ra,0xffffd
    800042f0:	788080e7          	jalr	1928(ra) # 80001a74 <_Z12bba_allocatem>
}
    800042f4:	00813083          	ld	ra,8(sp)
    800042f8:	00013403          	ld	s0,0(sp)
    800042fc:	01010113          	addi	sp,sp,16
    80004300:	00008067          	ret

0000000080004304 <_Z5kfreePKv>:

// Deallocate one small memory buffer
void kfree(const void *objp)
{
    80004304:	ff010113          	addi	sp,sp,-16
    80004308:	00113423          	sd	ra,8(sp)
    8000430c:	00813023          	sd	s0,0(sp)
    80004310:	01010413          	addi	s0,sp,16
    bba_free_block(objp);
    80004314:	ffffe097          	auipc	ra,0xffffe
    80004318:	a28080e7          	jalr	-1496(ra) # 80001d3c <_Z14bba_free_blockPKv>
}
    8000431c:	00813083          	ld	ra,8(sp)
    80004320:	00013403          	ld	s0,0(sp)
    80004324:	01010113          	addi	sp,sp,16
    80004328:	00008067          	ret

000000008000432c <_Z17kmem_destroy_listP12kmem_cache_sP11kmem_slab_s>:

void kmem_destroy_list(kmem_cache_t* cachep,kmem_slab_t* head){
    if(head==0) return;
    8000432c:	08058e63          	beqz	a1,800043c8 <_Z17kmem_destroy_listP12kmem_cache_sP11kmem_slab_s+0x9c>
void kmem_destroy_list(kmem_cache_t* cachep,kmem_slab_t* head){
    80004330:	fd010113          	addi	sp,sp,-48
    80004334:	02113423          	sd	ra,40(sp)
    80004338:	02813023          	sd	s0,32(sp)
    8000433c:	00913c23          	sd	s1,24(sp)
    80004340:	01213823          	sd	s2,16(sp)
    80004344:	01313423          	sd	s3,8(sp)
    80004348:	03010413          	addi	s0,sp,48
    8000434c:	00050993          	mv	s3,a0
    80004350:	00058493          	mv	s1,a1
    kmem_slab_t *curr = head->nextSlab;
    80004354:	0205b903          	ld	s2,32(a1)
    kmem_slab_t * prev = head;
    80004358:	0440006f          	j	8000439c <_Z17kmem_destroy_listP12kmem_cache_sP11kmem_slab_s+0x70>
    8000435c:	00090793          	mv	a5,s2
    80004360:	0340006f          	j	80004394 <_Z17kmem_destroy_listP12kmem_cache_sP11kmem_slab_s+0x68>
    while (prev!=0){
        if(cachep->dtor!=0) kmem_slab_destoy_objects(prev,cachep);
    80004364:	00098593          	mv	a1,s3
    80004368:	00048513          	mv	a0,s1
    8000436c:	00000097          	auipc	ra,0x0
    80004370:	828080e7          	jalr	-2008(ra) # 80003b94 <_Z24kmem_slab_destoy_objectsP11kmem_slab_sP12kmem_cache_s>
        bba_free_block(prev->memory);
    80004374:	0084b503          	ld	a0,8(s1)
    80004378:	ffffe097          	auipc	ra,0xffffe
    8000437c:	9c4080e7          	jalr	-1596(ra) # 80001d3c <_Z14bba_free_blockPKv>
        bba_free_block(prev);
    80004380:	00048513          	mv	a0,s1
    80004384:	ffffe097          	auipc	ra,0xffffe
    80004388:	9b8080e7          	jalr	-1608(ra) # 80001d3c <_Z14bba_free_blockPKv>
        prev=curr;
        if(curr!=0) curr=curr->nextSlab;
    8000438c:	fc0908e3          	beqz	s2,8000435c <_Z17kmem_destroy_listP12kmem_cache_sP11kmem_slab_s+0x30>
    80004390:	02093783          	ld	a5,32(s2)
    80004394:	00090493          	mv	s1,s2
    80004398:	00078913          	mv	s2,a5
    while (prev!=0){
    8000439c:	00048863          	beqz	s1,800043ac <_Z17kmem_destroy_listP12kmem_cache_sP11kmem_slab_s+0x80>
        if(cachep->dtor!=0) kmem_slab_destoy_objects(prev,cachep);
    800043a0:	0309b783          	ld	a5,48(s3)
    800043a4:	fc0790e3          	bnez	a5,80004364 <_Z17kmem_destroy_listP12kmem_cache_sP11kmem_slab_s+0x38>
    800043a8:	fcdff06f          	j	80004374 <_Z17kmem_destroy_listP12kmem_cache_sP11kmem_slab_s+0x48>
    }
}
    800043ac:	02813083          	ld	ra,40(sp)
    800043b0:	02013403          	ld	s0,32(sp)
    800043b4:	01813483          	ld	s1,24(sp)
    800043b8:	01013903          	ld	s2,16(sp)
    800043bc:	00813983          	ld	s3,8(sp)
    800043c0:	03010113          	addi	sp,sp,48
    800043c4:	00008067          	ret
    800043c8:	00008067          	ret

00000000800043cc <_Z18kmem_cache_destroyP12kmem_cache_s>:

// Deallocate cache
void kmem_cache_destroy(kmem_cache_t *cachep)
{
    800043cc:	fe010113          	addi	sp,sp,-32
    800043d0:	00113c23          	sd	ra,24(sp)
    800043d4:	00813823          	sd	s0,16(sp)
    800043d8:	00913423          	sd	s1,8(sp)
    800043dc:	02010413          	addi	s0,sp,32
    800043e0:	00050493          	mv	s1,a0
    kmem_destroy_list(cachep,cachep->usedSlabsHead);
    800043e4:	00853583          	ld	a1,8(a0)
    800043e8:	00000097          	auipc	ra,0x0
    800043ec:	f44080e7          	jalr	-188(ra) # 8000432c <_Z17kmem_destroy_listP12kmem_cache_sP11kmem_slab_s>
    kmem_destroy_list(cachep,cachep->emptySlabsHead);
    800043f0:	0004b583          	ld	a1,0(s1)
    800043f4:	00048513          	mv	a0,s1
    800043f8:	00000097          	auipc	ra,0x0
    800043fc:	f34080e7          	jalr	-204(ra) # 8000432c <_Z17kmem_destroy_listP12kmem_cache_sP11kmem_slab_s>
    kmem_destroy_list(cachep,cachep->fullSlabsHead);
    80004400:	0104b583          	ld	a1,16(s1)
    80004404:	00048513          	mv	a0,s1
    80004408:	00000097          	auipc	ra,0x0
    8000440c:	f24080e7          	jalr	-220(ra) # 8000432c <_Z17kmem_destroy_listP12kmem_cache_sP11kmem_slab_s>
    bba_free_block(cachep);
    80004410:	00048513          	mv	a0,s1
    80004414:	ffffe097          	auipc	ra,0xffffe
    80004418:	928080e7          	jalr	-1752(ra) # 80001d3c <_Z14bba_free_blockPKv>
}
    8000441c:	01813083          	ld	ra,24(sp)
    80004420:	01013403          	ld	s0,16(sp)
    80004424:	00813483          	ld	s1,8(sp)
    80004428:	02010113          	addi	sp,sp,32
    8000442c:	00008067          	ret

0000000080004430 <_Z15kmem_cache_infoP12kmem_cache_s>:
{
    printf("\n Slab at addr %lx, %d used slots, %d initialized slots",  slab->memory, slab->usedSlotsCount, slab->initializedSlotsCount);
}
// Print cache info
void kmem_cache_info(kmem_cache_t *cachep)
{
    80004430:	fc010113          	addi	sp,sp,-64
    80004434:	02113c23          	sd	ra,56(sp)
    80004438:	02813823          	sd	s0,48(sp)
    8000443c:	02913423          	sd	s1,40(sp)
    80004440:	03213023          	sd	s2,32(sp)
    80004444:	01313c23          	sd	s3,24(sp)
    80004448:	01413823          	sd	s4,16(sp)
    8000444c:	01513423          	sd	s5,8(sp)
    80004450:	04010413          	addi	s0,sp,64
    80004454:	00050a93          	mv	s5,a0
    int initObjCount=0, usedObjCount=0, slabsCount=0;
    printf("\n Cache '%s' has %d slots of size %d in each slab",cachep->name, cachep->slotsInSlab, cachep->slotSize);
    80004458:	02053683          	ld	a3,32(a0)
    8000445c:	05052603          	lw	a2,80(a0)
    80004460:	03850593          	addi	a1,a0,56
    80004464:	00006517          	auipc	a0,0x6
    80004468:	e7450513          	addi	a0,a0,-396 # 8000a2d8 <CONSOLE_STATUS+0x2c8>
    8000446c:	ffffe097          	auipc	ra,0xffffe
    80004470:	e28080e7          	jalr	-472(ra) # 80002294 <_Z6printfPKcz>
    printf("\n Empty slabs:");
    80004474:	00006517          	auipc	a0,0x6
    80004478:	e9c50513          	addi	a0,a0,-356 # 8000a310 <CONSOLE_STATUS+0x300>
    8000447c:	ffffe097          	auipc	ra,0xffffe
    80004480:	e18080e7          	jalr	-488(ra) # 80002294 <_Z6printfPKcz>
    kmem_slab_t * curr = cachep->emptySlabsHead;
    80004484:	000ab483          	ld	s1,0(s5)
    int initObjCount=0, usedObjCount=0, slabsCount=0;
    80004488:	00000a13          	li	s4,0
    8000448c:	00000913          	li	s2,0
    80004490:	00000993          	li	s3,0
    while (curr!=0){
    80004494:	02048e63          	beqz	s1,800044d0 <_Z15kmem_cache_infoP12kmem_cache_s+0xa0>
    printf("\n Slab at addr %lx, %d used slots, %d initialized slots",  slab->memory, slab->usedSlotsCount, slab->initializedSlotsCount);
    80004498:	0044a683          	lw	a3,4(s1)
    8000449c:	0004a603          	lw	a2,0(s1)
    800044a0:	0084b583          	ld	a1,8(s1)
    800044a4:	00006517          	auipc	a0,0x6
    800044a8:	e7c50513          	addi	a0,a0,-388 # 8000a320 <CONSOLE_STATUS+0x310>
    800044ac:	ffffe097          	auipc	ra,0xffffe
    800044b0:	de8080e7          	jalr	-536(ra) # 80002294 <_Z6printfPKcz>
        kmem_slab_info(curr);
        slabsCount++;
    800044b4:	001a0a1b          	addiw	s4,s4,1
        initObjCount+=curr->initializedSlotsCount;
    800044b8:	0044a783          	lw	a5,4(s1)
    800044bc:	013789bb          	addw	s3,a5,s3
        usedObjCount+=curr->usedSlotsCount;
    800044c0:	0004a783          	lw	a5,0(s1)
    800044c4:	0127893b          	addw	s2,a5,s2
        curr=curr->nextSlab;
    800044c8:	0204b483          	ld	s1,32(s1)
    while (curr!=0){
    800044cc:	fc9ff06f          	j	80004494 <_Z15kmem_cache_infoP12kmem_cache_s+0x64>
    }
    printf("\n Full slabs:");
    800044d0:	00006517          	auipc	a0,0x6
    800044d4:	e8850513          	addi	a0,a0,-376 # 8000a358 <CONSOLE_STATUS+0x348>
    800044d8:	ffffe097          	auipc	ra,0xffffe
    800044dc:	dbc080e7          	jalr	-580(ra) # 80002294 <_Z6printfPKcz>
    curr = cachep->fullSlabsHead;
    800044e0:	010ab483          	ld	s1,16(s5)
    while (curr!=0){
    800044e4:	02048e63          	beqz	s1,80004520 <_Z15kmem_cache_infoP12kmem_cache_s+0xf0>
    printf("\n Slab at addr %lx, %d used slots, %d initialized slots",  slab->memory, slab->usedSlotsCount, slab->initializedSlotsCount);
    800044e8:	0044a683          	lw	a3,4(s1)
    800044ec:	0004a603          	lw	a2,0(s1)
    800044f0:	0084b583          	ld	a1,8(s1)
    800044f4:	00006517          	auipc	a0,0x6
    800044f8:	e2c50513          	addi	a0,a0,-468 # 8000a320 <CONSOLE_STATUS+0x310>
    800044fc:	ffffe097          	auipc	ra,0xffffe
    80004500:	d98080e7          	jalr	-616(ra) # 80002294 <_Z6printfPKcz>
        kmem_slab_info(curr);
        slabsCount++;
    80004504:	001a0a1b          	addiw	s4,s4,1
        initObjCount+=curr->initializedSlotsCount;
    80004508:	0044a783          	lw	a5,4(s1)
    8000450c:	013789bb          	addw	s3,a5,s3
        usedObjCount+=curr->usedSlotsCount;
    80004510:	0004a783          	lw	a5,0(s1)
    80004514:	0127893b          	addw	s2,a5,s2
        curr=curr->nextSlab;
    80004518:	0204b483          	ld	s1,32(s1)
    while (curr!=0){
    8000451c:	fc9ff06f          	j	800044e4 <_Z15kmem_cache_infoP12kmem_cache_s+0xb4>
    }
    printf("\n Partially full slabs:");
    80004520:	00006517          	auipc	a0,0x6
    80004524:	e4850513          	addi	a0,a0,-440 # 8000a368 <CONSOLE_STATUS+0x358>
    80004528:	ffffe097          	auipc	ra,0xffffe
    8000452c:	d6c080e7          	jalr	-660(ra) # 80002294 <_Z6printfPKcz>
    curr = cachep->usedSlabsHead;
    80004530:	008ab483          	ld	s1,8(s5)
    while (curr!=0){
    80004534:	02048e63          	beqz	s1,80004570 <_Z15kmem_cache_infoP12kmem_cache_s+0x140>
    printf("\n Slab at addr %lx, %d used slots, %d initialized slots",  slab->memory, slab->usedSlotsCount, slab->initializedSlotsCount);
    80004538:	0044a683          	lw	a3,4(s1)
    8000453c:	0004a603          	lw	a2,0(s1)
    80004540:	0084b583          	ld	a1,8(s1)
    80004544:	00006517          	auipc	a0,0x6
    80004548:	ddc50513          	addi	a0,a0,-548 # 8000a320 <CONSOLE_STATUS+0x310>
    8000454c:	ffffe097          	auipc	ra,0xffffe
    80004550:	d48080e7          	jalr	-696(ra) # 80002294 <_Z6printfPKcz>
        kmem_slab_info(curr);
        slabsCount++;
    80004554:	001a0a1b          	addiw	s4,s4,1
        initObjCount+=curr->initializedSlotsCount;
    80004558:	0044a783          	lw	a5,4(s1)
    8000455c:	013789bb          	addw	s3,a5,s3
        usedObjCount+=curr->usedSlotsCount;
    80004560:	0004a783          	lw	a5,0(s1)
    80004564:	0127893b          	addw	s2,a5,s2
        curr=curr->nextSlab;
    80004568:	0204b483          	ld	s1,32(s1)
    while (curr!=0){
    8000456c:	fc9ff06f          	j	80004534 <_Z15kmem_cache_infoP12kmem_cache_s+0x104>
    }
    printf("\n Total slabs: %d, total used slots: %d, total initialized slots: %d", slabsCount, usedObjCount,initObjCount);
    80004570:	00098693          	mv	a3,s3
    80004574:	00090613          	mv	a2,s2
    80004578:	000a0593          	mv	a1,s4
    8000457c:	00006517          	auipc	a0,0x6
    80004580:	e0450513          	addi	a0,a0,-508 # 8000a380 <CONSOLE_STATUS+0x370>
    80004584:	ffffe097          	auipc	ra,0xffffe
    80004588:	d10080e7          	jalr	-752(ra) # 80002294 <_Z6printfPKcz>
    printf("\n-------------------------", usedObjCount,initObjCount);
    8000458c:	00098613          	mv	a2,s3
    80004590:	00090593          	mv	a1,s2
    80004594:	00006517          	auipc	a0,0x6
    80004598:	e3450513          	addi	a0,a0,-460 # 8000a3c8 <CONSOLE_STATUS+0x3b8>
    8000459c:	ffffe097          	auipc	ra,0xffffe
    800045a0:	cf8080e7          	jalr	-776(ra) # 80002294 <_Z6printfPKcz>
}
    800045a4:	03813083          	ld	ra,56(sp)
    800045a8:	03013403          	ld	s0,48(sp)
    800045ac:	02813483          	ld	s1,40(sp)
    800045b0:	02013903          	ld	s2,32(sp)
    800045b4:	01813983          	ld	s3,24(sp)
    800045b8:	01013a03          	ld	s4,16(sp)
    800045bc:	00813a83          	ld	s5,8(sp)
    800045c0:	04010113          	addi	sp,sp,64
    800045c4:	00008067          	ret

00000000800045c8 <_ZL16producerKeyboardPv>:
    sem_t wait;
};

static volatile int threadEnd = 0;

static void producerKeyboard(void *arg) {
    800045c8:	fe010113          	addi	sp,sp,-32
    800045cc:	00113c23          	sd	ra,24(sp)
    800045d0:	00813823          	sd	s0,16(sp)
    800045d4:	00913423          	sd	s1,8(sp)
    800045d8:	01213023          	sd	s2,0(sp)
    800045dc:	02010413          	addi	s0,sp,32
    800045e0:	00050493          	mv	s1,a0
    struct thread_data *data = (struct thread_data *) arg;

    int key;
    int i = 0;
    800045e4:	00000913          	li	s2,0
    800045e8:	00c0006f          	j	800045f4 <_ZL16producerKeyboardPv+0x2c>
    while ((key = getc()) != 13) {
        data->buffer->put(key);
        i++;

        if (i % (10 * data->id) == 0) {
            thread_dispatch();
    800045ec:	ffffd097          	auipc	ra,0xffffd
    800045f0:	d9c080e7          	jalr	-612(ra) # 80001388 <_Z15thread_dispatchv>
    while ((key = getc()) != 13) {
    800045f4:	ffffd097          	auipc	ra,0xffffd
    800045f8:	f80080e7          	jalr	-128(ra) # 80001574 <_Z4getcv>
    800045fc:	0005059b          	sext.w	a1,a0
    80004600:	00d00793          	li	a5,13
    80004604:	02f58a63          	beq	a1,a5,80004638 <_ZL16producerKeyboardPv+0x70>
        data->buffer->put(key);
    80004608:	0084b503          	ld	a0,8(s1)
    8000460c:	00003097          	auipc	ra,0x3
    80004610:	f50080e7          	jalr	-176(ra) # 8000755c <_ZN6Buffer3putEi>
        i++;
    80004614:	0019071b          	addiw	a4,s2,1
    80004618:	0007091b          	sext.w	s2,a4
        if (i % (10 * data->id) == 0) {
    8000461c:	0004a683          	lw	a3,0(s1)
    80004620:	0026979b          	slliw	a5,a3,0x2
    80004624:	00d787bb          	addw	a5,a5,a3
    80004628:	0017979b          	slliw	a5,a5,0x1
    8000462c:	02f767bb          	remw	a5,a4,a5
    80004630:	fc0792e3          	bnez	a5,800045f4 <_ZL16producerKeyboardPv+0x2c>
    80004634:	fb9ff06f          	j	800045ec <_ZL16producerKeyboardPv+0x24>
        }
    }

    threadEnd = 1;
    80004638:	00100793          	li	a5,1
    8000463c:	0000c717          	auipc	a4,0xc
    80004640:	caf72623          	sw	a5,-852(a4) # 800102e8 <_ZL9threadEnd>
    data->buffer->put('!');
    80004644:	02100593          	li	a1,33
    80004648:	0084b503          	ld	a0,8(s1)
    8000464c:	00003097          	auipc	ra,0x3
    80004650:	f10080e7          	jalr	-240(ra) # 8000755c <_ZN6Buffer3putEi>

    sem_signal(data->wait);
    80004654:	0104b503          	ld	a0,16(s1)
    80004658:	ffffd097          	auipc	ra,0xffffd
    8000465c:	ea8080e7          	jalr	-344(ra) # 80001500 <_Z10sem_signalP5sem_s>
}
    80004660:	01813083          	ld	ra,24(sp)
    80004664:	01013403          	ld	s0,16(sp)
    80004668:	00813483          	ld	s1,8(sp)
    8000466c:	00013903          	ld	s2,0(sp)
    80004670:	02010113          	addi	sp,sp,32
    80004674:	00008067          	ret

0000000080004678 <_ZL8producerPv>:

static void producer(void *arg) {
    80004678:	fe010113          	addi	sp,sp,-32
    8000467c:	00113c23          	sd	ra,24(sp)
    80004680:	00813823          	sd	s0,16(sp)
    80004684:	00913423          	sd	s1,8(sp)
    80004688:	01213023          	sd	s2,0(sp)
    8000468c:	02010413          	addi	s0,sp,32
    80004690:	00050493          	mv	s1,a0
    struct thread_data *data = (struct thread_data *) arg;

    int i = 0;
    80004694:	00000913          	li	s2,0
    80004698:	00c0006f          	j	800046a4 <_ZL8producerPv+0x2c>
    while (!threadEnd) {
        data->buffer->put(data->id + '0');
        i++;

        if (i % (10 * data->id) == 0) {
            thread_dispatch();
    8000469c:	ffffd097          	auipc	ra,0xffffd
    800046a0:	cec080e7          	jalr	-788(ra) # 80001388 <_Z15thread_dispatchv>
    while (!threadEnd) {
    800046a4:	0000c797          	auipc	a5,0xc
    800046a8:	c447a783          	lw	a5,-956(a5) # 800102e8 <_ZL9threadEnd>
    800046ac:	02079e63          	bnez	a5,800046e8 <_ZL8producerPv+0x70>
        data->buffer->put(data->id + '0');
    800046b0:	0004a583          	lw	a1,0(s1)
    800046b4:	0305859b          	addiw	a1,a1,48
    800046b8:	0084b503          	ld	a0,8(s1)
    800046bc:	00003097          	auipc	ra,0x3
    800046c0:	ea0080e7          	jalr	-352(ra) # 8000755c <_ZN6Buffer3putEi>
        i++;
    800046c4:	0019071b          	addiw	a4,s2,1
    800046c8:	0007091b          	sext.w	s2,a4
        if (i % (10 * data->id) == 0) {
    800046cc:	0004a683          	lw	a3,0(s1)
    800046d0:	0026979b          	slliw	a5,a3,0x2
    800046d4:	00d787bb          	addw	a5,a5,a3
    800046d8:	0017979b          	slliw	a5,a5,0x1
    800046dc:	02f767bb          	remw	a5,a4,a5
    800046e0:	fc0792e3          	bnez	a5,800046a4 <_ZL8producerPv+0x2c>
    800046e4:	fb9ff06f          	j	8000469c <_ZL8producerPv+0x24>
        }
    }

    sem_signal(data->wait);
    800046e8:	0104b503          	ld	a0,16(s1)
    800046ec:	ffffd097          	auipc	ra,0xffffd
    800046f0:	e14080e7          	jalr	-492(ra) # 80001500 <_Z10sem_signalP5sem_s>
}
    800046f4:	01813083          	ld	ra,24(sp)
    800046f8:	01013403          	ld	s0,16(sp)
    800046fc:	00813483          	ld	s1,8(sp)
    80004700:	00013903          	ld	s2,0(sp)
    80004704:	02010113          	addi	sp,sp,32
    80004708:	00008067          	ret

000000008000470c <_ZL8consumerPv>:

static void consumer(void *arg) {
    8000470c:	fd010113          	addi	sp,sp,-48
    80004710:	02113423          	sd	ra,40(sp)
    80004714:	02813023          	sd	s0,32(sp)
    80004718:	00913c23          	sd	s1,24(sp)
    8000471c:	01213823          	sd	s2,16(sp)
    80004720:	01313423          	sd	s3,8(sp)
    80004724:	03010413          	addi	s0,sp,48
    80004728:	00050913          	mv	s2,a0
    struct thread_data *data = (struct thread_data *) arg;

    int i = 0;
    8000472c:	00000993          	li	s3,0
    80004730:	01c0006f          	j	8000474c <_ZL8consumerPv+0x40>
        i++;

        putc(key);

        if (i % (5 * data->id) == 0) {
            thread_dispatch();
    80004734:	ffffd097          	auipc	ra,0xffffd
    80004738:	c54080e7          	jalr	-940(ra) # 80001388 <_Z15thread_dispatchv>
    8000473c:	0500006f          	j	8000478c <_ZL8consumerPv+0x80>
        }

        if (i % 80 == 0) {
            putc('\n');
    80004740:	00a00513          	li	a0,10
    80004744:	ffffd097          	auipc	ra,0xffffd
    80004748:	e6c080e7          	jalr	-404(ra) # 800015b0 <_Z4putcc>
    while (!threadEnd) {
    8000474c:	0000c797          	auipc	a5,0xc
    80004750:	b9c7a783          	lw	a5,-1124(a5) # 800102e8 <_ZL9threadEnd>
    80004754:	06079063          	bnez	a5,800047b4 <_ZL8consumerPv+0xa8>
        int key = data->buffer->get();
    80004758:	00893503          	ld	a0,8(s2)
    8000475c:	00003097          	auipc	ra,0x3
    80004760:	e90080e7          	jalr	-368(ra) # 800075ec <_ZN6Buffer3getEv>
        i++;
    80004764:	0019849b          	addiw	s1,s3,1
    80004768:	0004899b          	sext.w	s3,s1
        putc(key);
    8000476c:	0ff57513          	andi	a0,a0,255
    80004770:	ffffd097          	auipc	ra,0xffffd
    80004774:	e40080e7          	jalr	-448(ra) # 800015b0 <_Z4putcc>
        if (i % (5 * data->id) == 0) {
    80004778:	00092703          	lw	a4,0(s2)
    8000477c:	0027179b          	slliw	a5,a4,0x2
    80004780:	00e787bb          	addw	a5,a5,a4
    80004784:	02f4e7bb          	remw	a5,s1,a5
    80004788:	fa0786e3          	beqz	a5,80004734 <_ZL8consumerPv+0x28>
        if (i % 80 == 0) {
    8000478c:	05000793          	li	a5,80
    80004790:	02f4e4bb          	remw	s1,s1,a5
    80004794:	fa049ce3          	bnez	s1,8000474c <_ZL8consumerPv+0x40>
    80004798:	fa9ff06f          	j	80004740 <_ZL8consumerPv+0x34>
        }
    }

    while (data->buffer->getCnt() > 0) {
        int key = data->buffer->get();
    8000479c:	00893503          	ld	a0,8(s2)
    800047a0:	00003097          	auipc	ra,0x3
    800047a4:	e4c080e7          	jalr	-436(ra) # 800075ec <_ZN6Buffer3getEv>
        putc(key);
    800047a8:	0ff57513          	andi	a0,a0,255
    800047ac:	ffffd097          	auipc	ra,0xffffd
    800047b0:	e04080e7          	jalr	-508(ra) # 800015b0 <_Z4putcc>
    while (data->buffer->getCnt() > 0) {
    800047b4:	00893503          	ld	a0,8(s2)
    800047b8:	00003097          	auipc	ra,0x3
    800047bc:	ec0080e7          	jalr	-320(ra) # 80007678 <_ZN6Buffer6getCntEv>
    800047c0:	fca04ee3          	bgtz	a0,8000479c <_ZL8consumerPv+0x90>
    }

    sem_signal(data->wait);
    800047c4:	01093503          	ld	a0,16(s2)
    800047c8:	ffffd097          	auipc	ra,0xffffd
    800047cc:	d38080e7          	jalr	-712(ra) # 80001500 <_Z10sem_signalP5sem_s>
}
    800047d0:	02813083          	ld	ra,40(sp)
    800047d4:	02013403          	ld	s0,32(sp)
    800047d8:	01813483          	ld	s1,24(sp)
    800047dc:	01013903          	ld	s2,16(sp)
    800047e0:	00813983          	ld	s3,8(sp)
    800047e4:	03010113          	addi	sp,sp,48
    800047e8:	00008067          	ret

00000000800047ec <_Z22producerConsumer_C_APIv>:

void producerConsumer_C_API() {
    800047ec:	f9010113          	addi	sp,sp,-112
    800047f0:	06113423          	sd	ra,104(sp)
    800047f4:	06813023          	sd	s0,96(sp)
    800047f8:	04913c23          	sd	s1,88(sp)
    800047fc:	05213823          	sd	s2,80(sp)
    80004800:	05313423          	sd	s3,72(sp)
    80004804:	05413023          	sd	s4,64(sp)
    80004808:	03513c23          	sd	s5,56(sp)
    8000480c:	03613823          	sd	s6,48(sp)
    80004810:	07010413          	addi	s0,sp,112
        sem_wait(waitForAll);
    }

    sem_close(waitForAll);

    delete buffer;
    80004814:	00010b13          	mv	s6,sp
    printString("Unesite broj proizvodjaca?\n");
    80004818:	00006517          	auipc	a0,0x6
    8000481c:	bd050513          	addi	a0,a0,-1072 # 8000a3e8 <CONSOLE_STATUS+0x3d8>
    80004820:	ffffd097          	auipc	ra,0xffffd
    80004824:	6e0080e7          	jalr	1760(ra) # 80001f00 <_Z11printStringPKc>
    getString(input, 30);
    80004828:	01e00593          	li	a1,30
    8000482c:	fa040493          	addi	s1,s0,-96
    80004830:	00048513          	mv	a0,s1
    80004834:	ffffd097          	auipc	ra,0xffffd
    80004838:	754080e7          	jalr	1876(ra) # 80001f88 <_Z9getStringPci>
    threadNum = stringToInt(input);
    8000483c:	00048513          	mv	a0,s1
    80004840:	ffffe097          	auipc	ra,0xffffe
    80004844:	820080e7          	jalr	-2016(ra) # 80002060 <_Z11stringToIntPKc>
    80004848:	00050913          	mv	s2,a0
    printString("Unesite velicinu bafera?\n");
    8000484c:	00006517          	auipc	a0,0x6
    80004850:	bbc50513          	addi	a0,a0,-1092 # 8000a408 <CONSOLE_STATUS+0x3f8>
    80004854:	ffffd097          	auipc	ra,0xffffd
    80004858:	6ac080e7          	jalr	1708(ra) # 80001f00 <_Z11printStringPKc>
    getString(input, 30);
    8000485c:	01e00593          	li	a1,30
    80004860:	00048513          	mv	a0,s1
    80004864:	ffffd097          	auipc	ra,0xffffd
    80004868:	724080e7          	jalr	1828(ra) # 80001f88 <_Z9getStringPci>
    n = stringToInt(input);
    8000486c:	00048513          	mv	a0,s1
    80004870:	ffffd097          	auipc	ra,0xffffd
    80004874:	7f0080e7          	jalr	2032(ra) # 80002060 <_Z11stringToIntPKc>
    80004878:	00050493          	mv	s1,a0
    printString("Broj proizvodjaca "); printInt(threadNum);
    8000487c:	00006517          	auipc	a0,0x6
    80004880:	bac50513          	addi	a0,a0,-1108 # 8000a428 <CONSOLE_STATUS+0x418>
    80004884:	ffffd097          	auipc	ra,0xffffd
    80004888:	67c080e7          	jalr	1660(ra) # 80001f00 <_Z11printStringPKc>
    8000488c:	00000613          	li	a2,0
    80004890:	00a00593          	li	a1,10
    80004894:	00090513          	mv	a0,s2
    80004898:	ffffe097          	auipc	ra,0xffffe
    8000489c:	818080e7          	jalr	-2024(ra) # 800020b0 <_Z8printIntiii>
    printString(" i velicina bafera "); printInt(n);
    800048a0:	00006517          	auipc	a0,0x6
    800048a4:	ba050513          	addi	a0,a0,-1120 # 8000a440 <CONSOLE_STATUS+0x430>
    800048a8:	ffffd097          	auipc	ra,0xffffd
    800048ac:	658080e7          	jalr	1624(ra) # 80001f00 <_Z11printStringPKc>
    800048b0:	00000613          	li	a2,0
    800048b4:	00a00593          	li	a1,10
    800048b8:	00048513          	mv	a0,s1
    800048bc:	ffffd097          	auipc	ra,0xffffd
    800048c0:	7f4080e7          	jalr	2036(ra) # 800020b0 <_Z8printIntiii>
    printString(".\n");
    800048c4:	00006517          	auipc	a0,0x6
    800048c8:	b9450513          	addi	a0,a0,-1132 # 8000a458 <CONSOLE_STATUS+0x448>
    800048cc:	ffffd097          	auipc	ra,0xffffd
    800048d0:	634080e7          	jalr	1588(ra) # 80001f00 <_Z11printStringPKc>
    if(threadNum > n) {
    800048d4:	0324c463          	blt	s1,s2,800048fc <_Z22producerConsumer_C_APIv+0x110>
    } else if (threadNum < 1) {
    800048d8:	03205c63          	blez	s2,80004910 <_Z22producerConsumer_C_APIv+0x124>
    Buffer *buffer = new Buffer(n);
    800048dc:	03800513          	li	a0,56
    800048e0:	ffffe097          	auipc	ra,0xffffe
    800048e4:	2f0080e7          	jalr	752(ra) # 80002bd0 <_Znwm>
    800048e8:	00050a13          	mv	s4,a0
    800048ec:	00048593          	mv	a1,s1
    800048f0:	00003097          	auipc	ra,0x3
    800048f4:	bd0080e7          	jalr	-1072(ra) # 800074c0 <_ZN6BufferC1Ei>
    800048f8:	0300006f          	j	80004928 <_Z22producerConsumer_C_APIv+0x13c>
        printString("Broj proizvodjaca ne sme biti manji od velicine bafera!\n");
    800048fc:	00006517          	auipc	a0,0x6
    80004900:	b6450513          	addi	a0,a0,-1180 # 8000a460 <CONSOLE_STATUS+0x450>
    80004904:	ffffd097          	auipc	ra,0xffffd
    80004908:	5fc080e7          	jalr	1532(ra) # 80001f00 <_Z11printStringPKc>
        return;
    8000490c:	0140006f          	j	80004920 <_Z22producerConsumer_C_APIv+0x134>
        printString("Broj proizvodjaca mora biti veci od nula!\n");
    80004910:	00006517          	auipc	a0,0x6
    80004914:	b9050513          	addi	a0,a0,-1136 # 8000a4a0 <CONSOLE_STATUS+0x490>
    80004918:	ffffd097          	auipc	ra,0xffffd
    8000491c:	5e8080e7          	jalr	1512(ra) # 80001f00 <_Z11printStringPKc>
        return;
    80004920:	000b0113          	mv	sp,s6
    80004924:	1500006f          	j	80004a74 <_Z22producerConsumer_C_APIv+0x288>
    sem_open(&waitForAll, 0);
    80004928:	00000593          	li	a1,0
    8000492c:	0000c517          	auipc	a0,0xc
    80004930:	9c450513          	addi	a0,a0,-1596 # 800102f0 <_ZL10waitForAll>
    80004934:	ffffd097          	auipc	ra,0xffffd
    80004938:	b08080e7          	jalr	-1272(ra) # 8000143c <_Z8sem_openPP5sem_sj>
    thread_t threads[threadNum];
    8000493c:	00391793          	slli	a5,s2,0x3
    80004940:	00f78793          	addi	a5,a5,15
    80004944:	ff07f793          	andi	a5,a5,-16
    80004948:	40f10133          	sub	sp,sp,a5
    8000494c:	00010a93          	mv	s5,sp
    struct thread_data data[threadNum + 1];
    80004950:	0019071b          	addiw	a4,s2,1
    80004954:	00171793          	slli	a5,a4,0x1
    80004958:	00e787b3          	add	a5,a5,a4
    8000495c:	00379793          	slli	a5,a5,0x3
    80004960:	00f78793          	addi	a5,a5,15
    80004964:	ff07f793          	andi	a5,a5,-16
    80004968:	40f10133          	sub	sp,sp,a5
    8000496c:	00010993          	mv	s3,sp
    data[threadNum].id = threadNum;
    80004970:	00191613          	slli	a2,s2,0x1
    80004974:	012607b3          	add	a5,a2,s2
    80004978:	00379793          	slli	a5,a5,0x3
    8000497c:	00f987b3          	add	a5,s3,a5
    80004980:	0127a023          	sw	s2,0(a5)
    data[threadNum].buffer = buffer;
    80004984:	0147b423          	sd	s4,8(a5)
    data[threadNum].wait = waitForAll;
    80004988:	0000c717          	auipc	a4,0xc
    8000498c:	96873703          	ld	a4,-1688(a4) # 800102f0 <_ZL10waitForAll>
    80004990:	00e7b823          	sd	a4,16(a5)
    thread_create(&consumerThread, consumer, data + threadNum);
    80004994:	00078613          	mv	a2,a5
    80004998:	00000597          	auipc	a1,0x0
    8000499c:	d7458593          	addi	a1,a1,-652 # 8000470c <_ZL8consumerPv>
    800049a0:	f9840513          	addi	a0,s0,-104
    800049a4:	ffffd097          	auipc	ra,0xffffd
    800049a8:	95c080e7          	jalr	-1700(ra) # 80001300 <_Z13thread_createPP8thread_sPFvPvES2_>
    for (int i = 0; i < threadNum; i++) {
    800049ac:	00000493          	li	s1,0
    800049b0:	0280006f          	j	800049d8 <_Z22producerConsumer_C_APIv+0x1ec>
        thread_create(threads + i,
    800049b4:	00000597          	auipc	a1,0x0
    800049b8:	c1458593          	addi	a1,a1,-1004 # 800045c8 <_ZL16producerKeyboardPv>
                      data + i);
    800049bc:	00179613          	slli	a2,a5,0x1
    800049c0:	00f60633          	add	a2,a2,a5
    800049c4:	00361613          	slli	a2,a2,0x3
        thread_create(threads + i,
    800049c8:	00c98633          	add	a2,s3,a2
    800049cc:	ffffd097          	auipc	ra,0xffffd
    800049d0:	934080e7          	jalr	-1740(ra) # 80001300 <_Z13thread_createPP8thread_sPFvPvES2_>
    for (int i = 0; i < threadNum; i++) {
    800049d4:	0014849b          	addiw	s1,s1,1
    800049d8:	0524d263          	bge	s1,s2,80004a1c <_Z22producerConsumer_C_APIv+0x230>
        data[i].id = i;
    800049dc:	00149793          	slli	a5,s1,0x1
    800049e0:	009787b3          	add	a5,a5,s1
    800049e4:	00379793          	slli	a5,a5,0x3
    800049e8:	00f987b3          	add	a5,s3,a5
    800049ec:	0097a023          	sw	s1,0(a5)
        data[i].buffer = buffer;
    800049f0:	0147b423          	sd	s4,8(a5)
        data[i].wait = waitForAll;
    800049f4:	0000c717          	auipc	a4,0xc
    800049f8:	8fc73703          	ld	a4,-1796(a4) # 800102f0 <_ZL10waitForAll>
    800049fc:	00e7b823          	sd	a4,16(a5)
        thread_create(threads + i,
    80004a00:	00048793          	mv	a5,s1
    80004a04:	00349513          	slli	a0,s1,0x3
    80004a08:	00aa8533          	add	a0,s5,a0
    80004a0c:	fa9054e3          	blez	s1,800049b4 <_Z22producerConsumer_C_APIv+0x1c8>
    80004a10:	00000597          	auipc	a1,0x0
    80004a14:	c6858593          	addi	a1,a1,-920 # 80004678 <_ZL8producerPv>
    80004a18:	fa5ff06f          	j	800049bc <_Z22producerConsumer_C_APIv+0x1d0>
    thread_dispatch();
    80004a1c:	ffffd097          	auipc	ra,0xffffd
    80004a20:	96c080e7          	jalr	-1684(ra) # 80001388 <_Z15thread_dispatchv>
    for (int i = 0; i <= threadNum; i++) {
    80004a24:	00000493          	li	s1,0
    80004a28:	00994e63          	blt	s2,s1,80004a44 <_Z22producerConsumer_C_APIv+0x258>
        sem_wait(waitForAll);
    80004a2c:	0000c517          	auipc	a0,0xc
    80004a30:	8c453503          	ld	a0,-1852(a0) # 800102f0 <_ZL10waitForAll>
    80004a34:	ffffd097          	auipc	ra,0xffffd
    80004a38:	a8c080e7          	jalr	-1396(ra) # 800014c0 <_Z8sem_waitP5sem_s>
    for (int i = 0; i <= threadNum; i++) {
    80004a3c:	0014849b          	addiw	s1,s1,1
    80004a40:	fe9ff06f          	j	80004a28 <_Z22producerConsumer_C_APIv+0x23c>
    sem_close(waitForAll);
    80004a44:	0000c517          	auipc	a0,0xc
    80004a48:	8ac53503          	ld	a0,-1876(a0) # 800102f0 <_ZL10waitForAll>
    80004a4c:	ffffd097          	auipc	ra,0xffffd
    80004a50:	a34080e7          	jalr	-1484(ra) # 80001480 <_Z9sem_closeP5sem_s>
    delete buffer;
    80004a54:	000a0e63          	beqz	s4,80004a70 <_Z22producerConsumer_C_APIv+0x284>
    80004a58:	000a0513          	mv	a0,s4
    80004a5c:	00003097          	auipc	ra,0x3
    80004a60:	ca4080e7          	jalr	-860(ra) # 80007700 <_ZN6BufferD1Ev>
    80004a64:	000a0513          	mv	a0,s4
    80004a68:	ffffe097          	auipc	ra,0xffffe
    80004a6c:	190080e7          	jalr	400(ra) # 80002bf8 <_ZdlPv>
    80004a70:	000b0113          	mv	sp,s6

}
    80004a74:	f9040113          	addi	sp,s0,-112
    80004a78:	06813083          	ld	ra,104(sp)
    80004a7c:	06013403          	ld	s0,96(sp)
    80004a80:	05813483          	ld	s1,88(sp)
    80004a84:	05013903          	ld	s2,80(sp)
    80004a88:	04813983          	ld	s3,72(sp)
    80004a8c:	04013a03          	ld	s4,64(sp)
    80004a90:	03813a83          	ld	s5,56(sp)
    80004a94:	03013b03          	ld	s6,48(sp)
    80004a98:	07010113          	addi	sp,sp,112
    80004a9c:	00008067          	ret
    80004aa0:	00050493          	mv	s1,a0
    Buffer *buffer = new Buffer(n);
    80004aa4:	000a0513          	mv	a0,s4
    80004aa8:	ffffe097          	auipc	ra,0xffffe
    80004aac:	150080e7          	jalr	336(ra) # 80002bf8 <_ZdlPv>
    80004ab0:	00048513          	mv	a0,s1
    80004ab4:	0000d097          	auipc	ra,0xd
    80004ab8:	944080e7          	jalr	-1724(ra) # 800113f8 <_Unwind_Resume>

0000000080004abc <_ZL9fibonaccim>:
static volatile bool finishedA = false;
static volatile bool finishedB = false;
static volatile bool finishedC = false;
static volatile bool finishedD = false;

static uint64 fibonacci(uint64 n) {
    80004abc:	fe010113          	addi	sp,sp,-32
    80004ac0:	00113c23          	sd	ra,24(sp)
    80004ac4:	00813823          	sd	s0,16(sp)
    80004ac8:	00913423          	sd	s1,8(sp)
    80004acc:	01213023          	sd	s2,0(sp)
    80004ad0:	02010413          	addi	s0,sp,32
    80004ad4:	00050493          	mv	s1,a0
    if (n == 0 || n == 1) { return n; }
    80004ad8:	00100793          	li	a5,1
    80004adc:	02a7f863          	bgeu	a5,a0,80004b0c <_ZL9fibonaccim+0x50>
    if (n % 10 == 0) { thread_dispatch(); }
    80004ae0:	00a00793          	li	a5,10
    80004ae4:	02f577b3          	remu	a5,a0,a5
    80004ae8:	02078e63          	beqz	a5,80004b24 <_ZL9fibonaccim+0x68>
    return fibonacci(n - 1) + fibonacci(n - 2);
    80004aec:	fff48513          	addi	a0,s1,-1
    80004af0:	00000097          	auipc	ra,0x0
    80004af4:	fcc080e7          	jalr	-52(ra) # 80004abc <_ZL9fibonaccim>
    80004af8:	00050913          	mv	s2,a0
    80004afc:	ffe48513          	addi	a0,s1,-2
    80004b00:	00000097          	auipc	ra,0x0
    80004b04:	fbc080e7          	jalr	-68(ra) # 80004abc <_ZL9fibonaccim>
    80004b08:	00a90533          	add	a0,s2,a0
}
    80004b0c:	01813083          	ld	ra,24(sp)
    80004b10:	01013403          	ld	s0,16(sp)
    80004b14:	00813483          	ld	s1,8(sp)
    80004b18:	00013903          	ld	s2,0(sp)
    80004b1c:	02010113          	addi	sp,sp,32
    80004b20:	00008067          	ret
    if (n % 10 == 0) { thread_dispatch(); }
    80004b24:	ffffd097          	auipc	ra,0xffffd
    80004b28:	864080e7          	jalr	-1948(ra) # 80001388 <_Z15thread_dispatchv>
    80004b2c:	fc1ff06f          	j	80004aec <_ZL9fibonaccim+0x30>

0000000080004b30 <_ZN7WorkerA11workerBodyAEPv>:
    void run() override {
        workerBodyD(nullptr);
    }
};

void WorkerA::workerBodyA(void *arg) {
    80004b30:	fe010113          	addi	sp,sp,-32
    80004b34:	00113c23          	sd	ra,24(sp)
    80004b38:	00813823          	sd	s0,16(sp)
    80004b3c:	00913423          	sd	s1,8(sp)
    80004b40:	01213023          	sd	s2,0(sp)
    80004b44:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 10; i++) {
    80004b48:	00000913          	li	s2,0
    80004b4c:	0380006f          	j	80004b84 <_ZN7WorkerA11workerBodyAEPv+0x54>
        printString("A: i="); printInt(i); printString("\n");
        for (uint64 j = 0; j < 10000; j++) {
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
            thread_dispatch();
    80004b50:	ffffd097          	auipc	ra,0xffffd
    80004b54:	838080e7          	jalr	-1992(ra) # 80001388 <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++) {
    80004b58:	00148493          	addi	s1,s1,1
    80004b5c:	000027b7          	lui	a5,0x2
    80004b60:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    80004b64:	0097ee63          	bltu	a5,s1,80004b80 <_ZN7WorkerA11workerBodyAEPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    80004b68:	00000713          	li	a4,0
    80004b6c:	000077b7          	lui	a5,0x7
    80004b70:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    80004b74:	fce7eee3          	bltu	a5,a4,80004b50 <_ZN7WorkerA11workerBodyAEPv+0x20>
    80004b78:	00170713          	addi	a4,a4,1
    80004b7c:	ff1ff06f          	j	80004b6c <_ZN7WorkerA11workerBodyAEPv+0x3c>
    for (uint64 i = 0; i < 10; i++) {
    80004b80:	00190913          	addi	s2,s2,1
    80004b84:	00900793          	li	a5,9
    80004b88:	0527e063          	bltu	a5,s2,80004bc8 <_ZN7WorkerA11workerBodyAEPv+0x98>
        printString("A: i="); printInt(i); printString("\n");
    80004b8c:	00006517          	auipc	a0,0x6
    80004b90:	94450513          	addi	a0,a0,-1724 # 8000a4d0 <CONSOLE_STATUS+0x4c0>
    80004b94:	ffffd097          	auipc	ra,0xffffd
    80004b98:	36c080e7          	jalr	876(ra) # 80001f00 <_Z11printStringPKc>
    80004b9c:	00000613          	li	a2,0
    80004ba0:	00a00593          	li	a1,10
    80004ba4:	0009051b          	sext.w	a0,s2
    80004ba8:	ffffd097          	auipc	ra,0xffffd
    80004bac:	508080e7          	jalr	1288(ra) # 800020b0 <_Z8printIntiii>
    80004bb0:	00006517          	auipc	a0,0x6
    80004bb4:	b7050513          	addi	a0,a0,-1168 # 8000a720 <CONSOLE_STATUS+0x710>
    80004bb8:	ffffd097          	auipc	ra,0xffffd
    80004bbc:	348080e7          	jalr	840(ra) # 80001f00 <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    80004bc0:	00000493          	li	s1,0
    80004bc4:	f99ff06f          	j	80004b5c <_ZN7WorkerA11workerBodyAEPv+0x2c>
        }
    }
    printString("A finished!\n");
    80004bc8:	00006517          	auipc	a0,0x6
    80004bcc:	91050513          	addi	a0,a0,-1776 # 8000a4d8 <CONSOLE_STATUS+0x4c8>
    80004bd0:	ffffd097          	auipc	ra,0xffffd
    80004bd4:	330080e7          	jalr	816(ra) # 80001f00 <_Z11printStringPKc>
    finishedA = true;
    80004bd8:	00100793          	li	a5,1
    80004bdc:	0000b717          	auipc	a4,0xb
    80004be0:	70f70e23          	sb	a5,1820(a4) # 800102f8 <_ZL9finishedA>
}
    80004be4:	01813083          	ld	ra,24(sp)
    80004be8:	01013403          	ld	s0,16(sp)
    80004bec:	00813483          	ld	s1,8(sp)
    80004bf0:	00013903          	ld	s2,0(sp)
    80004bf4:	02010113          	addi	sp,sp,32
    80004bf8:	00008067          	ret

0000000080004bfc <_ZN7WorkerB11workerBodyBEPv>:

void WorkerB::workerBodyB(void *arg) {
    80004bfc:	fe010113          	addi	sp,sp,-32
    80004c00:	00113c23          	sd	ra,24(sp)
    80004c04:	00813823          	sd	s0,16(sp)
    80004c08:	00913423          	sd	s1,8(sp)
    80004c0c:	01213023          	sd	s2,0(sp)
    80004c10:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 16; i++) {
    80004c14:	00000913          	li	s2,0
    80004c18:	0380006f          	j	80004c50 <_ZN7WorkerB11workerBodyBEPv+0x54>
        printString("B: i="); printInt(i); printString("\n");
        for (uint64 j = 0; j < 10000; j++) {
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
            thread_dispatch();
    80004c1c:	ffffc097          	auipc	ra,0xffffc
    80004c20:	76c080e7          	jalr	1900(ra) # 80001388 <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++) {
    80004c24:	00148493          	addi	s1,s1,1
    80004c28:	000027b7          	lui	a5,0x2
    80004c2c:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    80004c30:	0097ee63          	bltu	a5,s1,80004c4c <_ZN7WorkerB11workerBodyBEPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    80004c34:	00000713          	li	a4,0
    80004c38:	000077b7          	lui	a5,0x7
    80004c3c:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    80004c40:	fce7eee3          	bltu	a5,a4,80004c1c <_ZN7WorkerB11workerBodyBEPv+0x20>
    80004c44:	00170713          	addi	a4,a4,1
    80004c48:	ff1ff06f          	j	80004c38 <_ZN7WorkerB11workerBodyBEPv+0x3c>
    for (uint64 i = 0; i < 16; i++) {
    80004c4c:	00190913          	addi	s2,s2,1
    80004c50:	00f00793          	li	a5,15
    80004c54:	0527e063          	bltu	a5,s2,80004c94 <_ZN7WorkerB11workerBodyBEPv+0x98>
        printString("B: i="); printInt(i); printString("\n");
    80004c58:	00006517          	auipc	a0,0x6
    80004c5c:	89050513          	addi	a0,a0,-1904 # 8000a4e8 <CONSOLE_STATUS+0x4d8>
    80004c60:	ffffd097          	auipc	ra,0xffffd
    80004c64:	2a0080e7          	jalr	672(ra) # 80001f00 <_Z11printStringPKc>
    80004c68:	00000613          	li	a2,0
    80004c6c:	00a00593          	li	a1,10
    80004c70:	0009051b          	sext.w	a0,s2
    80004c74:	ffffd097          	auipc	ra,0xffffd
    80004c78:	43c080e7          	jalr	1084(ra) # 800020b0 <_Z8printIntiii>
    80004c7c:	00006517          	auipc	a0,0x6
    80004c80:	aa450513          	addi	a0,a0,-1372 # 8000a720 <CONSOLE_STATUS+0x710>
    80004c84:	ffffd097          	auipc	ra,0xffffd
    80004c88:	27c080e7          	jalr	636(ra) # 80001f00 <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    80004c8c:	00000493          	li	s1,0
    80004c90:	f99ff06f          	j	80004c28 <_ZN7WorkerB11workerBodyBEPv+0x2c>
        }
    }
    printString("B finished!\n");
    80004c94:	00006517          	auipc	a0,0x6
    80004c98:	85c50513          	addi	a0,a0,-1956 # 8000a4f0 <CONSOLE_STATUS+0x4e0>
    80004c9c:	ffffd097          	auipc	ra,0xffffd
    80004ca0:	264080e7          	jalr	612(ra) # 80001f00 <_Z11printStringPKc>
    finishedB = true;
    80004ca4:	00100793          	li	a5,1
    80004ca8:	0000b717          	auipc	a4,0xb
    80004cac:	64f708a3          	sb	a5,1617(a4) # 800102f9 <_ZL9finishedB>
    thread_dispatch();
    80004cb0:	ffffc097          	auipc	ra,0xffffc
    80004cb4:	6d8080e7          	jalr	1752(ra) # 80001388 <_Z15thread_dispatchv>
}
    80004cb8:	01813083          	ld	ra,24(sp)
    80004cbc:	01013403          	ld	s0,16(sp)
    80004cc0:	00813483          	ld	s1,8(sp)
    80004cc4:	00013903          	ld	s2,0(sp)
    80004cc8:	02010113          	addi	sp,sp,32
    80004ccc:	00008067          	ret

0000000080004cd0 <_ZN7WorkerC11workerBodyCEPv>:

void WorkerC::workerBodyC(void *arg) {
    80004cd0:	fe010113          	addi	sp,sp,-32
    80004cd4:	00113c23          	sd	ra,24(sp)
    80004cd8:	00813823          	sd	s0,16(sp)
    80004cdc:	00913423          	sd	s1,8(sp)
    80004ce0:	01213023          	sd	s2,0(sp)
    80004ce4:	02010413          	addi	s0,sp,32
    uint8 i = 0;
    80004ce8:	00000493          	li	s1,0
    80004cec:	0400006f          	j	80004d2c <_ZN7WorkerC11workerBodyCEPv+0x5c>
    for (; i < 3; i++) {
        printString("C: i="); printInt(i); printString("\n");
    80004cf0:	00006517          	auipc	a0,0x6
    80004cf4:	81050513          	addi	a0,a0,-2032 # 8000a500 <CONSOLE_STATUS+0x4f0>
    80004cf8:	ffffd097          	auipc	ra,0xffffd
    80004cfc:	208080e7          	jalr	520(ra) # 80001f00 <_Z11printStringPKc>
    80004d00:	00000613          	li	a2,0
    80004d04:	00a00593          	li	a1,10
    80004d08:	00048513          	mv	a0,s1
    80004d0c:	ffffd097          	auipc	ra,0xffffd
    80004d10:	3a4080e7          	jalr	932(ra) # 800020b0 <_Z8printIntiii>
    80004d14:	00006517          	auipc	a0,0x6
    80004d18:	a0c50513          	addi	a0,a0,-1524 # 8000a720 <CONSOLE_STATUS+0x710>
    80004d1c:	ffffd097          	auipc	ra,0xffffd
    80004d20:	1e4080e7          	jalr	484(ra) # 80001f00 <_Z11printStringPKc>
    for (; i < 3; i++) {
    80004d24:	0014849b          	addiw	s1,s1,1
    80004d28:	0ff4f493          	andi	s1,s1,255
    80004d2c:	00200793          	li	a5,2
    80004d30:	fc97f0e3          	bgeu	a5,s1,80004cf0 <_ZN7WorkerC11workerBodyCEPv+0x20>
    }

    printString("C: dispatch\n");
    80004d34:	00005517          	auipc	a0,0x5
    80004d38:	7d450513          	addi	a0,a0,2004 # 8000a508 <CONSOLE_STATUS+0x4f8>
    80004d3c:	ffffd097          	auipc	ra,0xffffd
    80004d40:	1c4080e7          	jalr	452(ra) # 80001f00 <_Z11printStringPKc>
    __asm__ ("li t1, 7");
    80004d44:	00700313          	li	t1,7
    thread_dispatch();
    80004d48:	ffffc097          	auipc	ra,0xffffc
    80004d4c:	640080e7          	jalr	1600(ra) # 80001388 <_Z15thread_dispatchv>

    uint64 t1 = 0;
    __asm__ ("mv %[t1], t1" : [t1] "=r"(t1));
    80004d50:	00030913          	mv	s2,t1

    printString("C: t1="); printInt(t1); printString("\n");
    80004d54:	00005517          	auipc	a0,0x5
    80004d58:	7c450513          	addi	a0,a0,1988 # 8000a518 <CONSOLE_STATUS+0x508>
    80004d5c:	ffffd097          	auipc	ra,0xffffd
    80004d60:	1a4080e7          	jalr	420(ra) # 80001f00 <_Z11printStringPKc>
    80004d64:	00000613          	li	a2,0
    80004d68:	00a00593          	li	a1,10
    80004d6c:	0009051b          	sext.w	a0,s2
    80004d70:	ffffd097          	auipc	ra,0xffffd
    80004d74:	340080e7          	jalr	832(ra) # 800020b0 <_Z8printIntiii>
    80004d78:	00006517          	auipc	a0,0x6
    80004d7c:	9a850513          	addi	a0,a0,-1624 # 8000a720 <CONSOLE_STATUS+0x710>
    80004d80:	ffffd097          	auipc	ra,0xffffd
    80004d84:	180080e7          	jalr	384(ra) # 80001f00 <_Z11printStringPKc>

    uint64 result = fibonacci(12);
    80004d88:	00c00513          	li	a0,12
    80004d8c:	00000097          	auipc	ra,0x0
    80004d90:	d30080e7          	jalr	-720(ra) # 80004abc <_ZL9fibonaccim>
    80004d94:	00050913          	mv	s2,a0
    printString("C: fibonaci="); printInt(result); printString("\n");
    80004d98:	00005517          	auipc	a0,0x5
    80004d9c:	78850513          	addi	a0,a0,1928 # 8000a520 <CONSOLE_STATUS+0x510>
    80004da0:	ffffd097          	auipc	ra,0xffffd
    80004da4:	160080e7          	jalr	352(ra) # 80001f00 <_Z11printStringPKc>
    80004da8:	00000613          	li	a2,0
    80004dac:	00a00593          	li	a1,10
    80004db0:	0009051b          	sext.w	a0,s2
    80004db4:	ffffd097          	auipc	ra,0xffffd
    80004db8:	2fc080e7          	jalr	764(ra) # 800020b0 <_Z8printIntiii>
    80004dbc:	00006517          	auipc	a0,0x6
    80004dc0:	96450513          	addi	a0,a0,-1692 # 8000a720 <CONSOLE_STATUS+0x710>
    80004dc4:	ffffd097          	auipc	ra,0xffffd
    80004dc8:	13c080e7          	jalr	316(ra) # 80001f00 <_Z11printStringPKc>
    80004dcc:	0400006f          	j	80004e0c <_ZN7WorkerC11workerBodyCEPv+0x13c>

    for (; i < 6; i++) {
        printString("C: i="); printInt(i); printString("\n");
    80004dd0:	00005517          	auipc	a0,0x5
    80004dd4:	73050513          	addi	a0,a0,1840 # 8000a500 <CONSOLE_STATUS+0x4f0>
    80004dd8:	ffffd097          	auipc	ra,0xffffd
    80004ddc:	128080e7          	jalr	296(ra) # 80001f00 <_Z11printStringPKc>
    80004de0:	00000613          	li	a2,0
    80004de4:	00a00593          	li	a1,10
    80004de8:	00048513          	mv	a0,s1
    80004dec:	ffffd097          	auipc	ra,0xffffd
    80004df0:	2c4080e7          	jalr	708(ra) # 800020b0 <_Z8printIntiii>
    80004df4:	00006517          	auipc	a0,0x6
    80004df8:	92c50513          	addi	a0,a0,-1748 # 8000a720 <CONSOLE_STATUS+0x710>
    80004dfc:	ffffd097          	auipc	ra,0xffffd
    80004e00:	104080e7          	jalr	260(ra) # 80001f00 <_Z11printStringPKc>
    for (; i < 6; i++) {
    80004e04:	0014849b          	addiw	s1,s1,1
    80004e08:	0ff4f493          	andi	s1,s1,255
    80004e0c:	00500793          	li	a5,5
    80004e10:	fc97f0e3          	bgeu	a5,s1,80004dd0 <_ZN7WorkerC11workerBodyCEPv+0x100>
    }

    printString("A finished!\n");
    80004e14:	00005517          	auipc	a0,0x5
    80004e18:	6c450513          	addi	a0,a0,1732 # 8000a4d8 <CONSOLE_STATUS+0x4c8>
    80004e1c:	ffffd097          	auipc	ra,0xffffd
    80004e20:	0e4080e7          	jalr	228(ra) # 80001f00 <_Z11printStringPKc>
    finishedC = true;
    80004e24:	00100793          	li	a5,1
    80004e28:	0000b717          	auipc	a4,0xb
    80004e2c:	4cf70923          	sb	a5,1234(a4) # 800102fa <_ZL9finishedC>
    thread_dispatch();
    80004e30:	ffffc097          	auipc	ra,0xffffc
    80004e34:	558080e7          	jalr	1368(ra) # 80001388 <_Z15thread_dispatchv>
}
    80004e38:	01813083          	ld	ra,24(sp)
    80004e3c:	01013403          	ld	s0,16(sp)
    80004e40:	00813483          	ld	s1,8(sp)
    80004e44:	00013903          	ld	s2,0(sp)
    80004e48:	02010113          	addi	sp,sp,32
    80004e4c:	00008067          	ret

0000000080004e50 <_ZN7WorkerD11workerBodyDEPv>:

void WorkerD::workerBodyD(void* arg) {
    80004e50:	fe010113          	addi	sp,sp,-32
    80004e54:	00113c23          	sd	ra,24(sp)
    80004e58:	00813823          	sd	s0,16(sp)
    80004e5c:	00913423          	sd	s1,8(sp)
    80004e60:	01213023          	sd	s2,0(sp)
    80004e64:	02010413          	addi	s0,sp,32
    uint8 i = 10;
    80004e68:	00a00493          	li	s1,10
    80004e6c:	0400006f          	j	80004eac <_ZN7WorkerD11workerBodyDEPv+0x5c>
    for (; i < 13; i++) {
        printString("D: i="); printInt(i); printString("\n");
    80004e70:	00005517          	auipc	a0,0x5
    80004e74:	6c050513          	addi	a0,a0,1728 # 8000a530 <CONSOLE_STATUS+0x520>
    80004e78:	ffffd097          	auipc	ra,0xffffd
    80004e7c:	088080e7          	jalr	136(ra) # 80001f00 <_Z11printStringPKc>
    80004e80:	00000613          	li	a2,0
    80004e84:	00a00593          	li	a1,10
    80004e88:	00048513          	mv	a0,s1
    80004e8c:	ffffd097          	auipc	ra,0xffffd
    80004e90:	224080e7          	jalr	548(ra) # 800020b0 <_Z8printIntiii>
    80004e94:	00006517          	auipc	a0,0x6
    80004e98:	88c50513          	addi	a0,a0,-1908 # 8000a720 <CONSOLE_STATUS+0x710>
    80004e9c:	ffffd097          	auipc	ra,0xffffd
    80004ea0:	064080e7          	jalr	100(ra) # 80001f00 <_Z11printStringPKc>
    for (; i < 13; i++) {
    80004ea4:	0014849b          	addiw	s1,s1,1
    80004ea8:	0ff4f493          	andi	s1,s1,255
    80004eac:	00c00793          	li	a5,12
    80004eb0:	fc97f0e3          	bgeu	a5,s1,80004e70 <_ZN7WorkerD11workerBodyDEPv+0x20>
    }

    printString("D: dispatch\n");
    80004eb4:	00005517          	auipc	a0,0x5
    80004eb8:	68450513          	addi	a0,a0,1668 # 8000a538 <CONSOLE_STATUS+0x528>
    80004ebc:	ffffd097          	auipc	ra,0xffffd
    80004ec0:	044080e7          	jalr	68(ra) # 80001f00 <_Z11printStringPKc>
    __asm__ ("li t1, 5");
    80004ec4:	00500313          	li	t1,5
    thread_dispatch();
    80004ec8:	ffffc097          	auipc	ra,0xffffc
    80004ecc:	4c0080e7          	jalr	1216(ra) # 80001388 <_Z15thread_dispatchv>

    uint64 result = fibonacci(16);
    80004ed0:	01000513          	li	a0,16
    80004ed4:	00000097          	auipc	ra,0x0
    80004ed8:	be8080e7          	jalr	-1048(ra) # 80004abc <_ZL9fibonaccim>
    80004edc:	00050913          	mv	s2,a0
    printString("D: fibonaci="); printInt(result); printString("\n");
    80004ee0:	00005517          	auipc	a0,0x5
    80004ee4:	66850513          	addi	a0,a0,1640 # 8000a548 <CONSOLE_STATUS+0x538>
    80004ee8:	ffffd097          	auipc	ra,0xffffd
    80004eec:	018080e7          	jalr	24(ra) # 80001f00 <_Z11printStringPKc>
    80004ef0:	00000613          	li	a2,0
    80004ef4:	00a00593          	li	a1,10
    80004ef8:	0009051b          	sext.w	a0,s2
    80004efc:	ffffd097          	auipc	ra,0xffffd
    80004f00:	1b4080e7          	jalr	436(ra) # 800020b0 <_Z8printIntiii>
    80004f04:	00006517          	auipc	a0,0x6
    80004f08:	81c50513          	addi	a0,a0,-2020 # 8000a720 <CONSOLE_STATUS+0x710>
    80004f0c:	ffffd097          	auipc	ra,0xffffd
    80004f10:	ff4080e7          	jalr	-12(ra) # 80001f00 <_Z11printStringPKc>
    80004f14:	0400006f          	j	80004f54 <_ZN7WorkerD11workerBodyDEPv+0x104>

    for (; i < 16; i++) {
        printString("D: i="); printInt(i); printString("\n");
    80004f18:	00005517          	auipc	a0,0x5
    80004f1c:	61850513          	addi	a0,a0,1560 # 8000a530 <CONSOLE_STATUS+0x520>
    80004f20:	ffffd097          	auipc	ra,0xffffd
    80004f24:	fe0080e7          	jalr	-32(ra) # 80001f00 <_Z11printStringPKc>
    80004f28:	00000613          	li	a2,0
    80004f2c:	00a00593          	li	a1,10
    80004f30:	00048513          	mv	a0,s1
    80004f34:	ffffd097          	auipc	ra,0xffffd
    80004f38:	17c080e7          	jalr	380(ra) # 800020b0 <_Z8printIntiii>
    80004f3c:	00005517          	auipc	a0,0x5
    80004f40:	7e450513          	addi	a0,a0,2020 # 8000a720 <CONSOLE_STATUS+0x710>
    80004f44:	ffffd097          	auipc	ra,0xffffd
    80004f48:	fbc080e7          	jalr	-68(ra) # 80001f00 <_Z11printStringPKc>
    for (; i < 16; i++) {
    80004f4c:	0014849b          	addiw	s1,s1,1
    80004f50:	0ff4f493          	andi	s1,s1,255
    80004f54:	00f00793          	li	a5,15
    80004f58:	fc97f0e3          	bgeu	a5,s1,80004f18 <_ZN7WorkerD11workerBodyDEPv+0xc8>
    }

    printString("D finished!\n");
    80004f5c:	00005517          	auipc	a0,0x5
    80004f60:	5fc50513          	addi	a0,a0,1532 # 8000a558 <CONSOLE_STATUS+0x548>
    80004f64:	ffffd097          	auipc	ra,0xffffd
    80004f68:	f9c080e7          	jalr	-100(ra) # 80001f00 <_Z11printStringPKc>
    finishedD = true;
    80004f6c:	00100793          	li	a5,1
    80004f70:	0000b717          	auipc	a4,0xb
    80004f74:	38f705a3          	sb	a5,907(a4) # 800102fb <_ZL9finishedD>
    thread_dispatch();
    80004f78:	ffffc097          	auipc	ra,0xffffc
    80004f7c:	410080e7          	jalr	1040(ra) # 80001388 <_Z15thread_dispatchv>
}
    80004f80:	01813083          	ld	ra,24(sp)
    80004f84:	01013403          	ld	s0,16(sp)
    80004f88:	00813483          	ld	s1,8(sp)
    80004f8c:	00013903          	ld	s2,0(sp)
    80004f90:	02010113          	addi	sp,sp,32
    80004f94:	00008067          	ret

0000000080004f98 <_Z20Threads_CPP_API_testv>:


void Threads_CPP_API_test() {
    80004f98:	fc010113          	addi	sp,sp,-64
    80004f9c:	02113c23          	sd	ra,56(sp)
    80004fa0:	02813823          	sd	s0,48(sp)
    80004fa4:	02913423          	sd	s1,40(sp)
    80004fa8:	04010413          	addi	s0,sp,64
    Thread* threads[4];

    threads[0] = new WorkerA();
    80004fac:	02000513          	li	a0,32
    80004fb0:	ffffe097          	auipc	ra,0xffffe
    80004fb4:	c20080e7          	jalr	-992(ra) # 80002bd0 <_Znwm>
        static int sleep (uint64 time){
            return time_sleep(time);
        }
        protected:
        Thread (){
            body= nullptr;
    80004fb8:	00053823          	sd	zero,16(a0)
            arg= nullptr;
    80004fbc:	00053c23          	sd	zero,24(a0)
    WorkerA():Thread() {}
    80004fc0:	00008797          	auipc	a5,0x8
    80004fc4:	9d078793          	addi	a5,a5,-1584 # 8000c990 <_ZTV7WorkerA+0x10>
    80004fc8:	00f53023          	sd	a5,0(a0)
    threads[0] = new WorkerA();
    80004fcc:	fca43023          	sd	a0,-64(s0)
    printString("ThreadA created\n");
    80004fd0:	00005517          	auipc	a0,0x5
    80004fd4:	59850513          	addi	a0,a0,1432 # 8000a568 <CONSOLE_STATUS+0x558>
    80004fd8:	ffffd097          	auipc	ra,0xffffd
    80004fdc:	f28080e7          	jalr	-216(ra) # 80001f00 <_Z11printStringPKc>

    threads[1] = new WorkerB();
    80004fe0:	02000513          	li	a0,32
    80004fe4:	ffffe097          	auipc	ra,0xffffe
    80004fe8:	bec080e7          	jalr	-1044(ra) # 80002bd0 <_Znwm>
            body= nullptr;
    80004fec:	00053823          	sd	zero,16(a0)
            arg= nullptr;
    80004ff0:	00053c23          	sd	zero,24(a0)
    WorkerB():Thread() {}
    80004ff4:	00008797          	auipc	a5,0x8
    80004ff8:	9c478793          	addi	a5,a5,-1596 # 8000c9b8 <_ZTV7WorkerB+0x10>
    80004ffc:	00f53023          	sd	a5,0(a0)
    threads[1] = new WorkerB();
    80005000:	fca43423          	sd	a0,-56(s0)
    printString("ThreadB created\n");
    80005004:	00005517          	auipc	a0,0x5
    80005008:	57c50513          	addi	a0,a0,1404 # 8000a580 <CONSOLE_STATUS+0x570>
    8000500c:	ffffd097          	auipc	ra,0xffffd
    80005010:	ef4080e7          	jalr	-268(ra) # 80001f00 <_Z11printStringPKc>

    threads[2] = new WorkerC();
    80005014:	02000513          	li	a0,32
    80005018:	ffffe097          	auipc	ra,0xffffe
    8000501c:	bb8080e7          	jalr	-1096(ra) # 80002bd0 <_Znwm>
            body= nullptr;
    80005020:	00053823          	sd	zero,16(a0)
            arg= nullptr;
    80005024:	00053c23          	sd	zero,24(a0)
    WorkerC():Thread() {}
    80005028:	00008797          	auipc	a5,0x8
    8000502c:	9b878793          	addi	a5,a5,-1608 # 8000c9e0 <_ZTV7WorkerC+0x10>
    80005030:	00f53023          	sd	a5,0(a0)
    threads[2] = new WorkerC();
    80005034:	fca43823          	sd	a0,-48(s0)
    printString("ThreadC created\n");
    80005038:	00005517          	auipc	a0,0x5
    8000503c:	56050513          	addi	a0,a0,1376 # 8000a598 <CONSOLE_STATUS+0x588>
    80005040:	ffffd097          	auipc	ra,0xffffd
    80005044:	ec0080e7          	jalr	-320(ra) # 80001f00 <_Z11printStringPKc>

    threads[3] = new WorkerD();
    80005048:	02000513          	li	a0,32
    8000504c:	ffffe097          	auipc	ra,0xffffe
    80005050:	b84080e7          	jalr	-1148(ra) # 80002bd0 <_Znwm>
            body= nullptr;
    80005054:	00053823          	sd	zero,16(a0)
            arg= nullptr;
    80005058:	00053c23          	sd	zero,24(a0)
    WorkerD():Thread() {}
    8000505c:	00008797          	auipc	a5,0x8
    80005060:	9ac78793          	addi	a5,a5,-1620 # 8000ca08 <_ZTV7WorkerD+0x10>
    80005064:	00f53023          	sd	a5,0(a0)
    threads[3] = new WorkerD();
    80005068:	fca43c23          	sd	a0,-40(s0)
    printString("ThreadD created\n");
    8000506c:	00005517          	auipc	a0,0x5
    80005070:	54450513          	addi	a0,a0,1348 # 8000a5b0 <CONSOLE_STATUS+0x5a0>
    80005074:	ffffd097          	auipc	ra,0xffffd
    80005078:	e8c080e7          	jalr	-372(ra) # 80001f00 <_Z11printStringPKc>

    for(int i=0; i<4; i++) {
    8000507c:	00000493          	li	s1,0
    80005080:	0200006f          	j	800050a0 <_Z20Threads_CPP_API_testv+0x108>
            if(body== nullptr) return thread_create(&myHandle,&threadEntry, this);
    80005084:	00050613          	mv	a2,a0
    80005088:	ffffe597          	auipc	a1,0xffffe
    8000508c:	af458593          	addi	a1,a1,-1292 # 80002b7c <_ZN6Thread11threadEntryEPv>
    80005090:	00850513          	addi	a0,a0,8
    80005094:	ffffc097          	auipc	ra,0xffffc
    80005098:	26c080e7          	jalr	620(ra) # 80001300 <_Z13thread_createPP8thread_sPFvPvES2_>
    8000509c:	0014849b          	addiw	s1,s1,1
    800050a0:	00300793          	li	a5,3
    800050a4:	0297cc63          	blt	a5,s1,800050dc <_Z20Threads_CPP_API_testv+0x144>
        threads[i]->start();
    800050a8:	00349793          	slli	a5,s1,0x3
    800050ac:	fe040713          	addi	a4,s0,-32
    800050b0:	00f707b3          	add	a5,a4,a5
    800050b4:	fe07b503          	ld	a0,-32(a5)
    800050b8:	01053583          	ld	a1,16(a0)
    800050bc:	fc0584e3          	beqz	a1,80005084 <_Z20Threads_CPP_API_testv+0xec>
            else return thread_create(&myHandle,body,arg);
    800050c0:	01853603          	ld	a2,24(a0)
    800050c4:	00850513          	addi	a0,a0,8
    800050c8:	ffffc097          	auipc	ra,0xffffc
    800050cc:	238080e7          	jalr	568(ra) # 80001300 <_Z13thread_createPP8thread_sPFvPvES2_>
    800050d0:	fcdff06f          	j	8000509c <_Z20Threads_CPP_API_testv+0x104>
            thread_dispatch();
    800050d4:	ffffc097          	auipc	ra,0xffffc
    800050d8:	2b4080e7          	jalr	692(ra) # 80001388 <_Z15thread_dispatchv>
    }

    while (!(finishedA && finishedB && finishedC && finishedD)) {
    800050dc:	0000b797          	auipc	a5,0xb
    800050e0:	21c7c783          	lbu	a5,540(a5) # 800102f8 <_ZL9finishedA>
    800050e4:	fe0788e3          	beqz	a5,800050d4 <_Z20Threads_CPP_API_testv+0x13c>
    800050e8:	0000b797          	auipc	a5,0xb
    800050ec:	2117c783          	lbu	a5,529(a5) # 800102f9 <_ZL9finishedB>
    800050f0:	fe0782e3          	beqz	a5,800050d4 <_Z20Threads_CPP_API_testv+0x13c>
    800050f4:	0000b797          	auipc	a5,0xb
    800050f8:	2067c783          	lbu	a5,518(a5) # 800102fa <_ZL9finishedC>
    800050fc:	fc078ce3          	beqz	a5,800050d4 <_Z20Threads_CPP_API_testv+0x13c>
    80005100:	0000b797          	auipc	a5,0xb
    80005104:	1fb7c783          	lbu	a5,507(a5) # 800102fb <_ZL9finishedD>
    80005108:	fc0786e3          	beqz	a5,800050d4 <_Z20Threads_CPP_API_testv+0x13c>
    8000510c:	fc040493          	addi	s1,s0,-64
    80005110:	0080006f          	j	80005118 <_Z20Threads_CPP_API_testv+0x180>
        Thread::dispatch();
    }

    for (auto thread: threads) { delete thread; }
    80005114:	00848493          	addi	s1,s1,8
    80005118:	fe040793          	addi	a5,s0,-32
    8000511c:	00f48e63          	beq	s1,a5,80005138 <_Z20Threads_CPP_API_testv+0x1a0>
    80005120:	0004b503          	ld	a0,0(s1)
    80005124:	fe0508e3          	beqz	a0,80005114 <_Z20Threads_CPP_API_testv+0x17c>
    80005128:	00053783          	ld	a5,0(a0)
    8000512c:	0087b783          	ld	a5,8(a5)
    80005130:	000780e7          	jalr	a5
    80005134:	fe1ff06f          	j	80005114 <_Z20Threads_CPP_API_testv+0x17c>
}
    80005138:	03813083          	ld	ra,56(sp)
    8000513c:	03013403          	ld	s0,48(sp)
    80005140:	02813483          	ld	s1,40(sp)
    80005144:	04010113          	addi	sp,sp,64
    80005148:	00008067          	ret

000000008000514c <_ZN7WorkerDD1Ev>:
class WorkerD: public Thread {
    8000514c:	ff010113          	addi	sp,sp,-16
    80005150:	00813423          	sd	s0,8(sp)
    80005154:	01010413          	addi	s0,sp,16
    80005158:	00813403          	ld	s0,8(sp)
    8000515c:	01010113          	addi	sp,sp,16
    80005160:	00008067          	ret

0000000080005164 <_ZN7WorkerCD1Ev>:
class WorkerC: public Thread {
    80005164:	ff010113          	addi	sp,sp,-16
    80005168:	00813423          	sd	s0,8(sp)
    8000516c:	01010413          	addi	s0,sp,16
    80005170:	00813403          	ld	s0,8(sp)
    80005174:	01010113          	addi	sp,sp,16
    80005178:	00008067          	ret

000000008000517c <_ZN7WorkerBD1Ev>:
class WorkerB: public Thread {
    8000517c:	ff010113          	addi	sp,sp,-16
    80005180:	00813423          	sd	s0,8(sp)
    80005184:	01010413          	addi	s0,sp,16
    80005188:	00813403          	ld	s0,8(sp)
    8000518c:	01010113          	addi	sp,sp,16
    80005190:	00008067          	ret

0000000080005194 <_ZN7WorkerAD1Ev>:
class WorkerA: public Thread {
    80005194:	ff010113          	addi	sp,sp,-16
    80005198:	00813423          	sd	s0,8(sp)
    8000519c:	01010413          	addi	s0,sp,16
    800051a0:	00813403          	ld	s0,8(sp)
    800051a4:	01010113          	addi	sp,sp,16
    800051a8:	00008067          	ret

00000000800051ac <_ZN7WorkerAD0Ev>:
    800051ac:	ff010113          	addi	sp,sp,-16
    800051b0:	00113423          	sd	ra,8(sp)
    800051b4:	00813023          	sd	s0,0(sp)
    800051b8:	01010413          	addi	s0,sp,16
    800051bc:	ffffe097          	auipc	ra,0xffffe
    800051c0:	a3c080e7          	jalr	-1476(ra) # 80002bf8 <_ZdlPv>
    800051c4:	00813083          	ld	ra,8(sp)
    800051c8:	00013403          	ld	s0,0(sp)
    800051cc:	01010113          	addi	sp,sp,16
    800051d0:	00008067          	ret

00000000800051d4 <_ZN7WorkerBD0Ev>:
class WorkerB: public Thread {
    800051d4:	ff010113          	addi	sp,sp,-16
    800051d8:	00113423          	sd	ra,8(sp)
    800051dc:	00813023          	sd	s0,0(sp)
    800051e0:	01010413          	addi	s0,sp,16
    800051e4:	ffffe097          	auipc	ra,0xffffe
    800051e8:	a14080e7          	jalr	-1516(ra) # 80002bf8 <_ZdlPv>
    800051ec:	00813083          	ld	ra,8(sp)
    800051f0:	00013403          	ld	s0,0(sp)
    800051f4:	01010113          	addi	sp,sp,16
    800051f8:	00008067          	ret

00000000800051fc <_ZN7WorkerCD0Ev>:
class WorkerC: public Thread {
    800051fc:	ff010113          	addi	sp,sp,-16
    80005200:	00113423          	sd	ra,8(sp)
    80005204:	00813023          	sd	s0,0(sp)
    80005208:	01010413          	addi	s0,sp,16
    8000520c:	ffffe097          	auipc	ra,0xffffe
    80005210:	9ec080e7          	jalr	-1556(ra) # 80002bf8 <_ZdlPv>
    80005214:	00813083          	ld	ra,8(sp)
    80005218:	00013403          	ld	s0,0(sp)
    8000521c:	01010113          	addi	sp,sp,16
    80005220:	00008067          	ret

0000000080005224 <_ZN7WorkerDD0Ev>:
class WorkerD: public Thread {
    80005224:	ff010113          	addi	sp,sp,-16
    80005228:	00113423          	sd	ra,8(sp)
    8000522c:	00813023          	sd	s0,0(sp)
    80005230:	01010413          	addi	s0,sp,16
    80005234:	ffffe097          	auipc	ra,0xffffe
    80005238:	9c4080e7          	jalr	-1596(ra) # 80002bf8 <_ZdlPv>
    8000523c:	00813083          	ld	ra,8(sp)
    80005240:	00013403          	ld	s0,0(sp)
    80005244:	01010113          	addi	sp,sp,16
    80005248:	00008067          	ret

000000008000524c <_ZN7WorkerA3runEv>:
    void run() override {
    8000524c:	ff010113          	addi	sp,sp,-16
    80005250:	00113423          	sd	ra,8(sp)
    80005254:	00813023          	sd	s0,0(sp)
    80005258:	01010413          	addi	s0,sp,16
        workerBodyA(nullptr);
    8000525c:	00000593          	li	a1,0
    80005260:	00000097          	auipc	ra,0x0
    80005264:	8d0080e7          	jalr	-1840(ra) # 80004b30 <_ZN7WorkerA11workerBodyAEPv>
    }
    80005268:	00813083          	ld	ra,8(sp)
    8000526c:	00013403          	ld	s0,0(sp)
    80005270:	01010113          	addi	sp,sp,16
    80005274:	00008067          	ret

0000000080005278 <_ZN7WorkerB3runEv>:
    void run() override {
    80005278:	ff010113          	addi	sp,sp,-16
    8000527c:	00113423          	sd	ra,8(sp)
    80005280:	00813023          	sd	s0,0(sp)
    80005284:	01010413          	addi	s0,sp,16
        workerBodyB(nullptr);
    80005288:	00000593          	li	a1,0
    8000528c:	00000097          	auipc	ra,0x0
    80005290:	970080e7          	jalr	-1680(ra) # 80004bfc <_ZN7WorkerB11workerBodyBEPv>
    }
    80005294:	00813083          	ld	ra,8(sp)
    80005298:	00013403          	ld	s0,0(sp)
    8000529c:	01010113          	addi	sp,sp,16
    800052a0:	00008067          	ret

00000000800052a4 <_ZN7WorkerC3runEv>:
    void run() override {
    800052a4:	ff010113          	addi	sp,sp,-16
    800052a8:	00113423          	sd	ra,8(sp)
    800052ac:	00813023          	sd	s0,0(sp)
    800052b0:	01010413          	addi	s0,sp,16
        workerBodyC(nullptr);
    800052b4:	00000593          	li	a1,0
    800052b8:	00000097          	auipc	ra,0x0
    800052bc:	a18080e7          	jalr	-1512(ra) # 80004cd0 <_ZN7WorkerC11workerBodyCEPv>
    }
    800052c0:	00813083          	ld	ra,8(sp)
    800052c4:	00013403          	ld	s0,0(sp)
    800052c8:	01010113          	addi	sp,sp,16
    800052cc:	00008067          	ret

00000000800052d0 <_ZN7WorkerD3runEv>:
    void run() override {
    800052d0:	ff010113          	addi	sp,sp,-16
    800052d4:	00113423          	sd	ra,8(sp)
    800052d8:	00813023          	sd	s0,0(sp)
    800052dc:	01010413          	addi	s0,sp,16
        workerBodyD(nullptr);
    800052e0:	00000593          	li	a1,0
    800052e4:	00000097          	auipc	ra,0x0
    800052e8:	b6c080e7          	jalr	-1172(ra) # 80004e50 <_ZN7WorkerD11workerBodyDEPv>
    }
    800052ec:	00813083          	ld	ra,8(sp)
    800052f0:	00013403          	ld	s0,0(sp)
    800052f4:	01010113          	addi	sp,sp,16
    800052f8:	00008067          	ret

00000000800052fc <_Z20testConsumerProducerv>:

        td->sem->signal();
    }
};

void testConsumerProducer() {
    800052fc:	f9010113          	addi	sp,sp,-112
    80005300:	06113423          	sd	ra,104(sp)
    80005304:	06813023          	sd	s0,96(sp)
    80005308:	04913c23          	sd	s1,88(sp)
    8000530c:	05213823          	sd	s2,80(sp)
    80005310:	05313423          	sd	s3,72(sp)
    80005314:	05413023          	sd	s4,64(sp)
    80005318:	03513c23          	sd	s5,56(sp)
    8000531c:	03613823          	sd	s6,48(sp)
    80005320:	03713423          	sd	s7,40(sp)
    80005324:	03813023          	sd	s8,32(sp)
    80005328:	07010413          	addi	s0,sp,112
    delete waitForAll;
    for (int i = 0; i < threadNum; i++) {
        delete producers[i];
    }
    delete consumer;
    delete buffer;
    8000532c:	00010c13          	mv	s8,sp
    printString("Unesite broj proizvodjaca?\n");
    80005330:	00005517          	auipc	a0,0x5
    80005334:	0b850513          	addi	a0,a0,184 # 8000a3e8 <CONSOLE_STATUS+0x3d8>
    80005338:	ffffd097          	auipc	ra,0xffffd
    8000533c:	bc8080e7          	jalr	-1080(ra) # 80001f00 <_Z11printStringPKc>
    getString(input, 30);
    80005340:	01e00593          	li	a1,30
    80005344:	f9040493          	addi	s1,s0,-112
    80005348:	00048513          	mv	a0,s1
    8000534c:	ffffd097          	auipc	ra,0xffffd
    80005350:	c3c080e7          	jalr	-964(ra) # 80001f88 <_Z9getStringPci>
    threadNum = stringToInt(input);
    80005354:	00048513          	mv	a0,s1
    80005358:	ffffd097          	auipc	ra,0xffffd
    8000535c:	d08080e7          	jalr	-760(ra) # 80002060 <_Z11stringToIntPKc>
    80005360:	00050993          	mv	s3,a0
    printString("Unesite velicinu bafera?\n");
    80005364:	00005517          	auipc	a0,0x5
    80005368:	0a450513          	addi	a0,a0,164 # 8000a408 <CONSOLE_STATUS+0x3f8>
    8000536c:	ffffd097          	auipc	ra,0xffffd
    80005370:	b94080e7          	jalr	-1132(ra) # 80001f00 <_Z11printStringPKc>
    getString(input, 30);
    80005374:	01e00593          	li	a1,30
    80005378:	00048513          	mv	a0,s1
    8000537c:	ffffd097          	auipc	ra,0xffffd
    80005380:	c0c080e7          	jalr	-1012(ra) # 80001f88 <_Z9getStringPci>
    n = stringToInt(input);
    80005384:	00048513          	mv	a0,s1
    80005388:	ffffd097          	auipc	ra,0xffffd
    8000538c:	cd8080e7          	jalr	-808(ra) # 80002060 <_Z11stringToIntPKc>
    80005390:	00050493          	mv	s1,a0
    printString("Broj proizvodjaca ");
    80005394:	00005517          	auipc	a0,0x5
    80005398:	09450513          	addi	a0,a0,148 # 8000a428 <CONSOLE_STATUS+0x418>
    8000539c:	ffffd097          	auipc	ra,0xffffd
    800053a0:	b64080e7          	jalr	-1180(ra) # 80001f00 <_Z11printStringPKc>
    printInt(threadNum);
    800053a4:	00000613          	li	a2,0
    800053a8:	00a00593          	li	a1,10
    800053ac:	00098513          	mv	a0,s3
    800053b0:	ffffd097          	auipc	ra,0xffffd
    800053b4:	d00080e7          	jalr	-768(ra) # 800020b0 <_Z8printIntiii>
    printString(" i velicina bafera ");
    800053b8:	00005517          	auipc	a0,0x5
    800053bc:	08850513          	addi	a0,a0,136 # 8000a440 <CONSOLE_STATUS+0x430>
    800053c0:	ffffd097          	auipc	ra,0xffffd
    800053c4:	b40080e7          	jalr	-1216(ra) # 80001f00 <_Z11printStringPKc>
    printInt(n);
    800053c8:	00000613          	li	a2,0
    800053cc:	00a00593          	li	a1,10
    800053d0:	00048513          	mv	a0,s1
    800053d4:	ffffd097          	auipc	ra,0xffffd
    800053d8:	cdc080e7          	jalr	-804(ra) # 800020b0 <_Z8printIntiii>
    printString(".\n");
    800053dc:	00005517          	auipc	a0,0x5
    800053e0:	07c50513          	addi	a0,a0,124 # 8000a458 <CONSOLE_STATUS+0x448>
    800053e4:	ffffd097          	auipc	ra,0xffffd
    800053e8:	b1c080e7          	jalr	-1252(ra) # 80001f00 <_Z11printStringPKc>
    if (threadNum > n) {
    800053ec:	0334c463          	blt	s1,s3,80005414 <_Z20testConsumerProducerv+0x118>
    } else if (threadNum < 1) {
    800053f0:	03305c63          	blez	s3,80005428 <_Z20testConsumerProducerv+0x12c>
    BufferCPP *buffer = new BufferCPP(n);
    800053f4:	03800513          	li	a0,56
    800053f8:	ffffd097          	auipc	ra,0xffffd
    800053fc:	7d8080e7          	jalr	2008(ra) # 80002bd0 <_Znwm>
    80005400:	00050a93          	mv	s5,a0
    80005404:	00048593          	mv	a1,s1
    80005408:	00001097          	auipc	ra,0x1
    8000540c:	3e8080e7          	jalr	1000(ra) # 800067f0 <_ZN9BufferCPPC1Ei>
    80005410:	0300006f          	j	80005440 <_Z20testConsumerProducerv+0x144>
        printString("Broj proizvodjaca ne sme biti manji od velicine bafera!\n");
    80005414:	00005517          	auipc	a0,0x5
    80005418:	04c50513          	addi	a0,a0,76 # 8000a460 <CONSOLE_STATUS+0x450>
    8000541c:	ffffd097          	auipc	ra,0xffffd
    80005420:	ae4080e7          	jalr	-1308(ra) # 80001f00 <_Z11printStringPKc>
        return;
    80005424:	0140006f          	j	80005438 <_Z20testConsumerProducerv+0x13c>
        printString("Broj proizvodjaca mora biti veci od nula!\n");
    80005428:	00005517          	auipc	a0,0x5
    8000542c:	07850513          	addi	a0,a0,120 # 8000a4a0 <CONSOLE_STATUS+0x490>
    80005430:	ffffd097          	auipc	ra,0xffffd
    80005434:	ad0080e7          	jalr	-1328(ra) # 80001f00 <_Z11printStringPKc>
        return;
    80005438:	000c0113          	mv	sp,s8
    8000543c:	2780006f          	j	800056b4 <_Z20testConsumerProducerv+0x3b8>
    waitForAll = new Semaphore(0);
    80005440:	01000513          	li	a0,16
    80005444:	ffffd097          	auipc	ra,0xffffd
    80005448:	78c080e7          	jalr	1932(ra) # 80002bd0 <_Znwm>
    8000544c:	00050913          	mv	s2,a0
};


class Semaphore {
        public:
        Semaphore (unsigned init = 1){
    80005450:	00007797          	auipc	a5,0x7
    80005454:	5e078793          	addi	a5,a5,1504 # 8000ca30 <_ZTV9Semaphore+0x10>
    80005458:	00f53023          	sd	a5,0(a0)
            sem_open(&myHandle,init);
    8000545c:	00000593          	li	a1,0
    80005460:	00850513          	addi	a0,a0,8
    80005464:	ffffc097          	auipc	ra,0xffffc
    80005468:	fd8080e7          	jalr	-40(ra) # 8000143c <_Z8sem_openPP5sem_sj>
    8000546c:	0000b797          	auipc	a5,0xb
    80005470:	e927be23          	sd	s2,-356(a5) # 80010308 <_ZL10waitForAll>
    Thread *producers[threadNum];
    80005474:	00399793          	slli	a5,s3,0x3
    80005478:	00f78793          	addi	a5,a5,15
    8000547c:	ff07f793          	andi	a5,a5,-16
    80005480:	40f10133          	sub	sp,sp,a5
    80005484:	00010a13          	mv	s4,sp
    thread_data threadData[threadNum + 1];
    80005488:	0019871b          	addiw	a4,s3,1
    8000548c:	00171793          	slli	a5,a4,0x1
    80005490:	00e787b3          	add	a5,a5,a4
    80005494:	00379793          	slli	a5,a5,0x3
    80005498:	00f78793          	addi	a5,a5,15
    8000549c:	ff07f793          	andi	a5,a5,-16
    800054a0:	40f10133          	sub	sp,sp,a5
    800054a4:	00010b13          	mv	s6,sp
    threadData[threadNum].id = threadNum;
    800054a8:	00199493          	slli	s1,s3,0x1
    800054ac:	013484b3          	add	s1,s1,s3
    800054b0:	00349493          	slli	s1,s1,0x3
    800054b4:	009b04b3          	add	s1,s6,s1
    800054b8:	0134a023          	sw	s3,0(s1)
    threadData[threadNum].buffer = buffer;
    800054bc:	0154b423          	sd	s5,8(s1)
    threadData[threadNum].sem = waitForAll;
    800054c0:	0124b823          	sd	s2,16(s1)
    Thread *consumer = new Consumer(&threadData[threadNum]);
    800054c4:	02800513          	li	a0,40
    800054c8:	ffffd097          	auipc	ra,0xffffd
    800054cc:	708080e7          	jalr	1800(ra) # 80002bd0 <_Znwm>
    800054d0:	00050b93          	mv	s7,a0
            body= nullptr;
    800054d4:	00053823          	sd	zero,16(a0)
            arg= nullptr;
    800054d8:	00053c23          	sd	zero,24(a0)
    Consumer(thread_data *_td) : Thread(), td(_td) {}
    800054dc:	00007797          	auipc	a5,0x7
    800054e0:	5c478793          	addi	a5,a5,1476 # 8000caa0 <_ZTV8Consumer+0x10>
    800054e4:	00f53023          	sd	a5,0(a0)
    800054e8:	02953023          	sd	s1,32(a0)
            if(body== nullptr) return thread_create(&myHandle,&threadEntry, this);
    800054ec:	00050613          	mv	a2,a0
    800054f0:	ffffd597          	auipc	a1,0xffffd
    800054f4:	68c58593          	addi	a1,a1,1676 # 80002b7c <_ZN6Thread11threadEntryEPv>
    800054f8:	00850513          	addi	a0,a0,8
    800054fc:	ffffc097          	auipc	ra,0xffffc
    80005500:	e04080e7          	jalr	-508(ra) # 80001300 <_Z13thread_createPP8thread_sPFvPvES2_>
    threadData[0].id = 0;
    80005504:	000b2023          	sw	zero,0(s6)
    threadData[0].buffer = buffer;
    80005508:	015b3423          	sd	s5,8(s6)
    threadData[0].sem = waitForAll;
    8000550c:	0000b797          	auipc	a5,0xb
    80005510:	dfc7b783          	ld	a5,-516(a5) # 80010308 <_ZL10waitForAll>
    80005514:	00fb3823          	sd	a5,16(s6)
    producers[0] = new ProducerKeyborad(&threadData[0]);
    80005518:	02800513          	li	a0,40
    8000551c:	ffffd097          	auipc	ra,0xffffd
    80005520:	6b4080e7          	jalr	1716(ra) # 80002bd0 <_Znwm>
            body= nullptr;
    80005524:	00053823          	sd	zero,16(a0)
            arg= nullptr;
    80005528:	00053c23          	sd	zero,24(a0)
    ProducerKeyborad(thread_data *_td) : Thread(), td(_td) {}
    8000552c:	00007797          	auipc	a5,0x7
    80005530:	52478793          	addi	a5,a5,1316 # 8000ca50 <_ZTV16ProducerKeyborad+0x10>
    80005534:	00f53023          	sd	a5,0(a0)
    80005538:	03653023          	sd	s6,32(a0)
    producers[0] = new ProducerKeyborad(&threadData[0]);
    8000553c:	00aa3023          	sd	a0,0(s4)
            if(body== nullptr) return thread_create(&myHandle,&threadEntry, this);
    80005540:	01053583          	ld	a1,16(a0)
    80005544:	00058e63          	beqz	a1,80005560 <_Z20testConsumerProducerv+0x264>
            else return thread_create(&myHandle,body,arg);
    80005548:	01853603          	ld	a2,24(a0)
    8000554c:	00850513          	addi	a0,a0,8
    80005550:	ffffc097          	auipc	ra,0xffffc
    80005554:	db0080e7          	jalr	-592(ra) # 80001300 <_Z13thread_createPP8thread_sPFvPvES2_>
    for (int i = 1; i < threadNum; i++) {
    80005558:	00100913          	li	s2,1
    8000555c:	03c0006f          	j	80005598 <_Z20testConsumerProducerv+0x29c>
            if(body== nullptr) return thread_create(&myHandle,&threadEntry, this);
    80005560:	00050613          	mv	a2,a0
    80005564:	ffffd597          	auipc	a1,0xffffd
    80005568:	61858593          	addi	a1,a1,1560 # 80002b7c <_ZN6Thread11threadEntryEPv>
    8000556c:	00850513          	addi	a0,a0,8
    80005570:	ffffc097          	auipc	ra,0xffffc
    80005574:	d90080e7          	jalr	-624(ra) # 80001300 <_Z13thread_createPP8thread_sPFvPvES2_>
    80005578:	fe1ff06f          	j	80005558 <_Z20testConsumerProducerv+0x25c>
    8000557c:	00050613          	mv	a2,a0
    80005580:	ffffd597          	auipc	a1,0xffffd
    80005584:	5fc58593          	addi	a1,a1,1532 # 80002b7c <_ZN6Thread11threadEntryEPv>
    80005588:	00850513          	addi	a0,a0,8
    8000558c:	ffffc097          	auipc	ra,0xffffc
    80005590:	d74080e7          	jalr	-652(ra) # 80001300 <_Z13thread_createPP8thread_sPFvPvES2_>
    80005594:	0019091b          	addiw	s2,s2,1
    80005598:	07395a63          	bge	s2,s3,8000560c <_Z20testConsumerProducerv+0x310>
        threadData[i].id = i;
    8000559c:	00191493          	slli	s1,s2,0x1
    800055a0:	012484b3          	add	s1,s1,s2
    800055a4:	00349493          	slli	s1,s1,0x3
    800055a8:	009b04b3          	add	s1,s6,s1
    800055ac:	0124a023          	sw	s2,0(s1)
        threadData[i].buffer = buffer;
    800055b0:	0154b423          	sd	s5,8(s1)
        threadData[i].sem = waitForAll;
    800055b4:	0000b797          	auipc	a5,0xb
    800055b8:	d547b783          	ld	a5,-684(a5) # 80010308 <_ZL10waitForAll>
    800055bc:	00f4b823          	sd	a5,16(s1)
        producers[i] = new Producer(&threadData[i]);
    800055c0:	02800513          	li	a0,40
    800055c4:	ffffd097          	auipc	ra,0xffffd
    800055c8:	60c080e7          	jalr	1548(ra) # 80002bd0 <_Znwm>
            body= nullptr;
    800055cc:	00053823          	sd	zero,16(a0)
            arg= nullptr;
    800055d0:	00053c23          	sd	zero,24(a0)
    Producer(thread_data *_td) : Thread(), td(_td) {}
    800055d4:	00007797          	auipc	a5,0x7
    800055d8:	4a478793          	addi	a5,a5,1188 # 8000ca78 <_ZTV8Producer+0x10>
    800055dc:	00f53023          	sd	a5,0(a0)
    800055e0:	02953023          	sd	s1,32(a0)
        producers[i] = new Producer(&threadData[i]);
    800055e4:	00391793          	slli	a5,s2,0x3
    800055e8:	00fa07b3          	add	a5,s4,a5
    800055ec:	00a7b023          	sd	a0,0(a5)
            if(body== nullptr) return thread_create(&myHandle,&threadEntry, this);
    800055f0:	01053583          	ld	a1,16(a0)
    800055f4:	f80584e3          	beqz	a1,8000557c <_Z20testConsumerProducerv+0x280>
            else return thread_create(&myHandle,body,arg);
    800055f8:	01853603          	ld	a2,24(a0)
    800055fc:	00850513          	addi	a0,a0,8
    80005600:	ffffc097          	auipc	ra,0xffffc
    80005604:	d00080e7          	jalr	-768(ra) # 80001300 <_Z13thread_createPP8thread_sPFvPvES2_>
    80005608:	f8dff06f          	j	80005594 <_Z20testConsumerProducerv+0x298>
            thread_dispatch();
    8000560c:	ffffc097          	auipc	ra,0xffffc
    80005610:	d7c080e7          	jalr	-644(ra) # 80001388 <_Z15thread_dispatchv>
    for (int i = 0; i <= threadNum; i++) {
    80005614:	00000493          	li	s1,0
    80005618:	0299c063          	blt	s3,s1,80005638 <_Z20testConsumerProducerv+0x33c>
        }
        virtual ~Semaphore (){
            sem_close(myHandle);
        }
        int wait (){
            return sem_wait(myHandle);
    8000561c:	0000b797          	auipc	a5,0xb
    80005620:	cec7b783          	ld	a5,-788(a5) # 80010308 <_ZL10waitForAll>
    80005624:	0087b503          	ld	a0,8(a5)
    80005628:	ffffc097          	auipc	ra,0xffffc
    8000562c:	e98080e7          	jalr	-360(ra) # 800014c0 <_Z8sem_waitP5sem_s>
    80005630:	0014849b          	addiw	s1,s1,1
    80005634:	fe5ff06f          	j	80005618 <_Z20testConsumerProducerv+0x31c>
    delete waitForAll;
    80005638:	0000b517          	auipc	a0,0xb
    8000563c:	cd053503          	ld	a0,-816(a0) # 80010308 <_ZL10waitForAll>
    80005640:	00050863          	beqz	a0,80005650 <_Z20testConsumerProducerv+0x354>
    80005644:	00053783          	ld	a5,0(a0)
    80005648:	0087b783          	ld	a5,8(a5)
    8000564c:	000780e7          	jalr	a5
    for (int i = 0; i <= threadNum; i++) {
    80005650:	00000493          	li	s1,0
    80005654:	0080006f          	j	8000565c <_Z20testConsumerProducerv+0x360>
    for (int i = 0; i < threadNum; i++) {
    80005658:	0014849b          	addiw	s1,s1,1
    8000565c:	0334d263          	bge	s1,s3,80005680 <_Z20testConsumerProducerv+0x384>
        delete producers[i];
    80005660:	00349793          	slli	a5,s1,0x3
    80005664:	00fa07b3          	add	a5,s4,a5
    80005668:	0007b503          	ld	a0,0(a5)
    8000566c:	fe0506e3          	beqz	a0,80005658 <_Z20testConsumerProducerv+0x35c>
    80005670:	00053783          	ld	a5,0(a0)
    80005674:	0087b783          	ld	a5,8(a5)
    80005678:	000780e7          	jalr	a5
    8000567c:	fddff06f          	j	80005658 <_Z20testConsumerProducerv+0x35c>
    delete consumer;
    80005680:	000b8a63          	beqz	s7,80005694 <_Z20testConsumerProducerv+0x398>
    80005684:	000bb783          	ld	a5,0(s7)
    80005688:	0087b783          	ld	a5,8(a5)
    8000568c:	000b8513          	mv	a0,s7
    80005690:	000780e7          	jalr	a5
    delete buffer;
    80005694:	000a8e63          	beqz	s5,800056b0 <_Z20testConsumerProducerv+0x3b4>
    80005698:	000a8513          	mv	a0,s5
    8000569c:	00001097          	auipc	ra,0x1
    800056a0:	4bc080e7          	jalr	1212(ra) # 80006b58 <_ZN9BufferCPPD1Ev>
    800056a4:	000a8513          	mv	a0,s5
    800056a8:	ffffd097          	auipc	ra,0xffffd
    800056ac:	550080e7          	jalr	1360(ra) # 80002bf8 <_ZdlPv>
    800056b0:	000c0113          	mv	sp,s8
}
    800056b4:	f9040113          	addi	sp,s0,-112
    800056b8:	06813083          	ld	ra,104(sp)
    800056bc:	06013403          	ld	s0,96(sp)
    800056c0:	05813483          	ld	s1,88(sp)
    800056c4:	05013903          	ld	s2,80(sp)
    800056c8:	04813983          	ld	s3,72(sp)
    800056cc:	04013a03          	ld	s4,64(sp)
    800056d0:	03813a83          	ld	s5,56(sp)
    800056d4:	03013b03          	ld	s6,48(sp)
    800056d8:	02813b83          	ld	s7,40(sp)
    800056dc:	02013c03          	ld	s8,32(sp)
    800056e0:	07010113          	addi	sp,sp,112
    800056e4:	00008067          	ret
    800056e8:	00050493          	mv	s1,a0
    BufferCPP *buffer = new BufferCPP(n);
    800056ec:	000a8513          	mv	a0,s5
    800056f0:	ffffd097          	auipc	ra,0xffffd
    800056f4:	508080e7          	jalr	1288(ra) # 80002bf8 <_ZdlPv>
    800056f8:	00048513          	mv	a0,s1
    800056fc:	0000c097          	auipc	ra,0xc
    80005700:	cfc080e7          	jalr	-772(ra) # 800113f8 <_Unwind_Resume>
    80005704:	00050493          	mv	s1,a0
    waitForAll = new Semaphore(0);
    80005708:	00090513          	mv	a0,s2
    8000570c:	ffffd097          	auipc	ra,0xffffd
    80005710:	4ec080e7          	jalr	1260(ra) # 80002bf8 <_ZdlPv>
    80005714:	00048513          	mv	a0,s1
    80005718:	0000c097          	auipc	ra,0xc
    8000571c:	ce0080e7          	jalr	-800(ra) # 800113f8 <_Unwind_Resume>

0000000080005720 <_ZN8ConsumerD1Ev>:
class Consumer : public Thread {
    80005720:	ff010113          	addi	sp,sp,-16
    80005724:	00813423          	sd	s0,8(sp)
    80005728:	01010413          	addi	s0,sp,16
    8000572c:	00813403          	ld	s0,8(sp)
    80005730:	01010113          	addi	sp,sp,16
    80005734:	00008067          	ret

0000000080005738 <_ZN8ProducerD1Ev>:
class Producer : public Thread {
    80005738:	ff010113          	addi	sp,sp,-16
    8000573c:	00813423          	sd	s0,8(sp)
    80005740:	01010413          	addi	s0,sp,16
    80005744:	00813403          	ld	s0,8(sp)
    80005748:	01010113          	addi	sp,sp,16
    8000574c:	00008067          	ret

0000000080005750 <_ZN16ProducerKeyboradD1Ev>:
class ProducerKeyborad : public Thread {
    80005750:	ff010113          	addi	sp,sp,-16
    80005754:	00813423          	sd	s0,8(sp)
    80005758:	01010413          	addi	s0,sp,16
    8000575c:	00813403          	ld	s0,8(sp)
    80005760:	01010113          	addi	sp,sp,16
    80005764:	00008067          	ret

0000000080005768 <_ZN8ConsumerD0Ev>:
class Consumer : public Thread {
    80005768:	ff010113          	addi	sp,sp,-16
    8000576c:	00113423          	sd	ra,8(sp)
    80005770:	00813023          	sd	s0,0(sp)
    80005774:	01010413          	addi	s0,sp,16
    80005778:	ffffd097          	auipc	ra,0xffffd
    8000577c:	480080e7          	jalr	1152(ra) # 80002bf8 <_ZdlPv>
    80005780:	00813083          	ld	ra,8(sp)
    80005784:	00013403          	ld	s0,0(sp)
    80005788:	01010113          	addi	sp,sp,16
    8000578c:	00008067          	ret

0000000080005790 <_ZN16ProducerKeyboradD0Ev>:
class ProducerKeyborad : public Thread {
    80005790:	ff010113          	addi	sp,sp,-16
    80005794:	00113423          	sd	ra,8(sp)
    80005798:	00813023          	sd	s0,0(sp)
    8000579c:	01010413          	addi	s0,sp,16
    800057a0:	ffffd097          	auipc	ra,0xffffd
    800057a4:	458080e7          	jalr	1112(ra) # 80002bf8 <_ZdlPv>
    800057a8:	00813083          	ld	ra,8(sp)
    800057ac:	00013403          	ld	s0,0(sp)
    800057b0:	01010113          	addi	sp,sp,16
    800057b4:	00008067          	ret

00000000800057b8 <_ZN8ProducerD0Ev>:
class Producer : public Thread {
    800057b8:	ff010113          	addi	sp,sp,-16
    800057bc:	00113423          	sd	ra,8(sp)
    800057c0:	00813023          	sd	s0,0(sp)
    800057c4:	01010413          	addi	s0,sp,16
    800057c8:	ffffd097          	auipc	ra,0xffffd
    800057cc:	430080e7          	jalr	1072(ra) # 80002bf8 <_ZdlPv>
    800057d0:	00813083          	ld	ra,8(sp)
    800057d4:	00013403          	ld	s0,0(sp)
    800057d8:	01010113          	addi	sp,sp,16
    800057dc:	00008067          	ret

00000000800057e0 <_ZN9SemaphoreD1Ev>:
        virtual ~Semaphore (){
    800057e0:	ff010113          	addi	sp,sp,-16
    800057e4:	00113423          	sd	ra,8(sp)
    800057e8:	00813023          	sd	s0,0(sp)
    800057ec:	01010413          	addi	s0,sp,16
    800057f0:	00007797          	auipc	a5,0x7
    800057f4:	24078793          	addi	a5,a5,576 # 8000ca30 <_ZTV9Semaphore+0x10>
    800057f8:	00f53023          	sd	a5,0(a0)
            sem_close(myHandle);
    800057fc:	00853503          	ld	a0,8(a0)
    80005800:	ffffc097          	auipc	ra,0xffffc
    80005804:	c80080e7          	jalr	-896(ra) # 80001480 <_Z9sem_closeP5sem_s>
        }
    80005808:	00813083          	ld	ra,8(sp)
    8000580c:	00013403          	ld	s0,0(sp)
    80005810:	01010113          	addi	sp,sp,16
    80005814:	00008067          	ret

0000000080005818 <_ZN9SemaphoreD0Ev>:
        virtual ~Semaphore (){
    80005818:	fe010113          	addi	sp,sp,-32
    8000581c:	00113c23          	sd	ra,24(sp)
    80005820:	00813823          	sd	s0,16(sp)
    80005824:	00913423          	sd	s1,8(sp)
    80005828:	02010413          	addi	s0,sp,32
    8000582c:	00050493          	mv	s1,a0
    80005830:	00007797          	auipc	a5,0x7
    80005834:	20078793          	addi	a5,a5,512 # 8000ca30 <_ZTV9Semaphore+0x10>
    80005838:	00f53023          	sd	a5,0(a0)
            sem_close(myHandle);
    8000583c:	00853503          	ld	a0,8(a0)
    80005840:	ffffc097          	auipc	ra,0xffffc
    80005844:	c40080e7          	jalr	-960(ra) # 80001480 <_Z9sem_closeP5sem_s>
        }
    80005848:	00048513          	mv	a0,s1
    8000584c:	ffffd097          	auipc	ra,0xffffd
    80005850:	3ac080e7          	jalr	940(ra) # 80002bf8 <_ZdlPv>
    80005854:	01813083          	ld	ra,24(sp)
    80005858:	01013403          	ld	s0,16(sp)
    8000585c:	00813483          	ld	s1,8(sp)
    80005860:	02010113          	addi	sp,sp,32
    80005864:	00008067          	ret

0000000080005868 <_ZN8Consumer3runEv>:
    void run() override {
    80005868:	fd010113          	addi	sp,sp,-48
    8000586c:	02113423          	sd	ra,40(sp)
    80005870:	02813023          	sd	s0,32(sp)
    80005874:	00913c23          	sd	s1,24(sp)
    80005878:	01213823          	sd	s2,16(sp)
    8000587c:	01313423          	sd	s3,8(sp)
    80005880:	03010413          	addi	s0,sp,48
    80005884:	00050913          	mv	s2,a0
        int i = 0;
    80005888:	00000993          	li	s3,0
    8000588c:	0100006f          	j	8000589c <_ZN8Consumer3runEv+0x34>
        public:
        static char getc (){
            return ::getc();
        }
        static void putc (char c){
            ::putc(c);
    80005890:	00a00513          	li	a0,10
    80005894:	ffffc097          	auipc	ra,0xffffc
    80005898:	d1c080e7          	jalr	-740(ra) # 800015b0 <_Z4putcc>
        while (!threadEnd) {
    8000589c:	0000b797          	auipc	a5,0xb
    800058a0:	a647a783          	lw	a5,-1436(a5) # 80010300 <_ZL9threadEnd>
    800058a4:	04079a63          	bnez	a5,800058f8 <_ZN8Consumer3runEv+0x90>
            int key = td->buffer->get();
    800058a8:	02093783          	ld	a5,32(s2)
    800058ac:	0087b503          	ld	a0,8(a5)
    800058b0:	00001097          	auipc	ra,0x1
    800058b4:	174080e7          	jalr	372(ra) # 80006a24 <_ZN9BufferCPP3getEv>
            i++;
    800058b8:	0019849b          	addiw	s1,s3,1
    800058bc:	0004899b          	sext.w	s3,s1
    800058c0:	0ff57513          	andi	a0,a0,255
    800058c4:	ffffc097          	auipc	ra,0xffffc
    800058c8:	cec080e7          	jalr	-788(ra) # 800015b0 <_Z4putcc>
            if (i % 80 == 0) {
    800058cc:	05000793          	li	a5,80
    800058d0:	02f4e4bb          	remw	s1,s1,a5
    800058d4:	fc0494e3          	bnez	s1,8000589c <_ZN8Consumer3runEv+0x34>
    800058d8:	fb9ff06f          	j	80005890 <_ZN8Consumer3runEv+0x28>
            int key = td->buffer->get();
    800058dc:	02093783          	ld	a5,32(s2)
    800058e0:	0087b503          	ld	a0,8(a5)
    800058e4:	00001097          	auipc	ra,0x1
    800058e8:	140080e7          	jalr	320(ra) # 80006a24 <_ZN9BufferCPP3getEv>
    800058ec:	0ff57513          	andi	a0,a0,255
    800058f0:	ffffc097          	auipc	ra,0xffffc
    800058f4:	cc0080e7          	jalr	-832(ra) # 800015b0 <_Z4putcc>
        while (td->buffer->getCnt() > 0) {
    800058f8:	02093783          	ld	a5,32(s2)
    800058fc:	0087b503          	ld	a0,8(a5)
    80005900:	00001097          	auipc	ra,0x1
    80005904:	1c0080e7          	jalr	448(ra) # 80006ac0 <_ZN9BufferCPP6getCntEv>
    80005908:	fca04ae3          	bgtz	a0,800058dc <_ZN8Consumer3runEv+0x74>
        td->sem->signal();
    8000590c:	02093783          	ld	a5,32(s2)
    80005910:	0107b783          	ld	a5,16(a5)
            return sem_signal(myHandle);
    80005914:	0087b503          	ld	a0,8(a5)
    80005918:	ffffc097          	auipc	ra,0xffffc
    8000591c:	be8080e7          	jalr	-1048(ra) # 80001500 <_Z10sem_signalP5sem_s>
    }
    80005920:	02813083          	ld	ra,40(sp)
    80005924:	02013403          	ld	s0,32(sp)
    80005928:	01813483          	ld	s1,24(sp)
    8000592c:	01013903          	ld	s2,16(sp)
    80005930:	00813983          	ld	s3,8(sp)
    80005934:	03010113          	addi	sp,sp,48
    80005938:	00008067          	ret

000000008000593c <_ZN16ProducerKeyborad3runEv>:
    void run() override {
    8000593c:	fe010113          	addi	sp,sp,-32
    80005940:	00113c23          	sd	ra,24(sp)
    80005944:	00813823          	sd	s0,16(sp)
    80005948:	00913423          	sd	s1,8(sp)
    8000594c:	02010413          	addi	s0,sp,32
    80005950:	00050493          	mv	s1,a0
        while ((key = getc()) != 13) {
    80005954:	ffffc097          	auipc	ra,0xffffc
    80005958:	c20080e7          	jalr	-992(ra) # 80001574 <_Z4getcv>
    8000595c:	0005059b          	sext.w	a1,a0
    80005960:	00d00793          	li	a5,13
    80005964:	00f58c63          	beq	a1,a5,8000597c <_ZN16ProducerKeyborad3runEv+0x40>
            td->buffer->put(key);
    80005968:	0204b783          	ld	a5,32(s1)
    8000596c:	0087b503          	ld	a0,8(a5)
    80005970:	00001097          	auipc	ra,0x1
    80005974:	014080e7          	jalr	20(ra) # 80006984 <_ZN9BufferCPP3putEi>
        while ((key = getc()) != 13) {
    80005978:	fddff06f          	j	80005954 <_ZN16ProducerKeyborad3runEv+0x18>
        threadEnd = 1;
    8000597c:	00100793          	li	a5,1
    80005980:	0000b717          	auipc	a4,0xb
    80005984:	98f72023          	sw	a5,-1664(a4) # 80010300 <_ZL9threadEnd>
        td->buffer->put('!');
    80005988:	0204b783          	ld	a5,32(s1)
    8000598c:	02100593          	li	a1,33
    80005990:	0087b503          	ld	a0,8(a5)
    80005994:	00001097          	auipc	ra,0x1
    80005998:	ff0080e7          	jalr	-16(ra) # 80006984 <_ZN9BufferCPP3putEi>
        td->sem->signal();
    8000599c:	0204b783          	ld	a5,32(s1)
    800059a0:	0107b783          	ld	a5,16(a5)
    800059a4:	0087b503          	ld	a0,8(a5)
    800059a8:	ffffc097          	auipc	ra,0xffffc
    800059ac:	b58080e7          	jalr	-1192(ra) # 80001500 <_Z10sem_signalP5sem_s>
    }
    800059b0:	01813083          	ld	ra,24(sp)
    800059b4:	01013403          	ld	s0,16(sp)
    800059b8:	00813483          	ld	s1,8(sp)
    800059bc:	02010113          	addi	sp,sp,32
    800059c0:	00008067          	ret

00000000800059c4 <_ZN8Producer3runEv>:
    void run() override {
    800059c4:	fe010113          	addi	sp,sp,-32
    800059c8:	00113c23          	sd	ra,24(sp)
    800059cc:	00813823          	sd	s0,16(sp)
    800059d0:	00913423          	sd	s1,8(sp)
    800059d4:	01213023          	sd	s2,0(sp)
    800059d8:	02010413          	addi	s0,sp,32
    800059dc:	00050493          	mv	s1,a0
        int i = 0;
    800059e0:	00000913          	li	s2,0
        while (!threadEnd) {
    800059e4:	0000b797          	auipc	a5,0xb
    800059e8:	91c7a783          	lw	a5,-1764(a5) # 80010300 <_ZL9threadEnd>
    800059ec:	04079263          	bnez	a5,80005a30 <_ZN8Producer3runEv+0x6c>
            td->buffer->put(td->id + '0');
    800059f0:	0204b783          	ld	a5,32(s1)
    800059f4:	0007a583          	lw	a1,0(a5)
    800059f8:	0305859b          	addiw	a1,a1,48
    800059fc:	0087b503          	ld	a0,8(a5)
    80005a00:	00001097          	auipc	ra,0x1
    80005a04:	f84080e7          	jalr	-124(ra) # 80006984 <_ZN9BufferCPP3putEi>
            i++;
    80005a08:	0019071b          	addiw	a4,s2,1
    80005a0c:	0007091b          	sext.w	s2,a4
            Thread::sleep((i + td->id) % 5);
    80005a10:	0204b783          	ld	a5,32(s1)
    80005a14:	0007a783          	lw	a5,0(a5)
    80005a18:	00e787bb          	addw	a5,a5,a4
            return time_sleep(time);
    80005a1c:	00500513          	li	a0,5
    80005a20:	02a7e53b          	remw	a0,a5,a0
    80005a24:	ffffc097          	auipc	ra,0xffffc
    80005a28:	b1c080e7          	jalr	-1252(ra) # 80001540 <_Z10time_sleepm>
    80005a2c:	fb9ff06f          	j	800059e4 <_ZN8Producer3runEv+0x20>
        td->sem->signal();
    80005a30:	0204b783          	ld	a5,32(s1)
    80005a34:	0107b783          	ld	a5,16(a5)
            return sem_signal(myHandle);
    80005a38:	0087b503          	ld	a0,8(a5)
    80005a3c:	ffffc097          	auipc	ra,0xffffc
    80005a40:	ac4080e7          	jalr	-1340(ra) # 80001500 <_Z10sem_signalP5sem_s>
    }
    80005a44:	01813083          	ld	ra,24(sp)
    80005a48:	01013403          	ld	s0,16(sp)
    80005a4c:	00813483          	ld	s1,8(sp)
    80005a50:	00013903          	ld	s2,0(sp)
    80005a54:	02010113          	addi	sp,sp,32
    80005a58:	00008067          	ret

0000000080005a5c <_ZL9fibonaccim>:
static volatile bool finishedA = false;
static volatile bool finishedB = false;
static volatile bool finishedC = false;
static volatile bool finishedD = false;

static uint64 fibonacci(uint64 n) {
    80005a5c:	fe010113          	addi	sp,sp,-32
    80005a60:	00113c23          	sd	ra,24(sp)
    80005a64:	00813823          	sd	s0,16(sp)
    80005a68:	00913423          	sd	s1,8(sp)
    80005a6c:	01213023          	sd	s2,0(sp)
    80005a70:	02010413          	addi	s0,sp,32
    80005a74:	00050493          	mv	s1,a0
    if (n == 0 || n == 1) { return n; }
    80005a78:	00100793          	li	a5,1
    80005a7c:	02a7f863          	bgeu	a5,a0,80005aac <_ZL9fibonaccim+0x50>
    if (n % 10 == 0) { thread_dispatch(); }
    80005a80:	00a00793          	li	a5,10
    80005a84:	02f577b3          	remu	a5,a0,a5
    80005a88:	02078e63          	beqz	a5,80005ac4 <_ZL9fibonaccim+0x68>
    return fibonacci(n - 1) + fibonacci(n - 2);
    80005a8c:	fff48513          	addi	a0,s1,-1
    80005a90:	00000097          	auipc	ra,0x0
    80005a94:	fcc080e7          	jalr	-52(ra) # 80005a5c <_ZL9fibonaccim>
    80005a98:	00050913          	mv	s2,a0
    80005a9c:	ffe48513          	addi	a0,s1,-2
    80005aa0:	00000097          	auipc	ra,0x0
    80005aa4:	fbc080e7          	jalr	-68(ra) # 80005a5c <_ZL9fibonaccim>
    80005aa8:	00a90533          	add	a0,s2,a0
}
    80005aac:	01813083          	ld	ra,24(sp)
    80005ab0:	01013403          	ld	s0,16(sp)
    80005ab4:	00813483          	ld	s1,8(sp)
    80005ab8:	00013903          	ld	s2,0(sp)
    80005abc:	02010113          	addi	sp,sp,32
    80005ac0:	00008067          	ret
    if (n % 10 == 0) { thread_dispatch(); }
    80005ac4:	ffffc097          	auipc	ra,0xffffc
    80005ac8:	8c4080e7          	jalr	-1852(ra) # 80001388 <_Z15thread_dispatchv>
    80005acc:	fc1ff06f          	j	80005a8c <_ZL9fibonaccim+0x30>

0000000080005ad0 <_ZL11workerBodyDPv>:
    printString("A finished!\n");
    finishedC = true;
    thread_dispatch();
}

static void workerBodyD(void* arg) {
    80005ad0:	fe010113          	addi	sp,sp,-32
    80005ad4:	00113c23          	sd	ra,24(sp)
    80005ad8:	00813823          	sd	s0,16(sp)
    80005adc:	00913423          	sd	s1,8(sp)
    80005ae0:	01213023          	sd	s2,0(sp)
    80005ae4:	02010413          	addi	s0,sp,32
    uint8 i = 10;
    80005ae8:	00a00493          	li	s1,10
    80005aec:	0400006f          	j	80005b2c <_ZL11workerBodyDPv+0x5c>
    for (; i < 13; i++) {
        printString("D: i="); printInt(i); printString("\n");
    80005af0:	00005517          	auipc	a0,0x5
    80005af4:	a4050513          	addi	a0,a0,-1472 # 8000a530 <CONSOLE_STATUS+0x520>
    80005af8:	ffffc097          	auipc	ra,0xffffc
    80005afc:	408080e7          	jalr	1032(ra) # 80001f00 <_Z11printStringPKc>
    80005b00:	00000613          	li	a2,0
    80005b04:	00a00593          	li	a1,10
    80005b08:	00048513          	mv	a0,s1
    80005b0c:	ffffc097          	auipc	ra,0xffffc
    80005b10:	5a4080e7          	jalr	1444(ra) # 800020b0 <_Z8printIntiii>
    80005b14:	00005517          	auipc	a0,0x5
    80005b18:	c0c50513          	addi	a0,a0,-1012 # 8000a720 <CONSOLE_STATUS+0x710>
    80005b1c:	ffffc097          	auipc	ra,0xffffc
    80005b20:	3e4080e7          	jalr	996(ra) # 80001f00 <_Z11printStringPKc>
    for (; i < 13; i++) {
    80005b24:	0014849b          	addiw	s1,s1,1
    80005b28:	0ff4f493          	andi	s1,s1,255
    80005b2c:	00c00793          	li	a5,12
    80005b30:	fc97f0e3          	bgeu	a5,s1,80005af0 <_ZL11workerBodyDPv+0x20>
    }

    printString("D: dispatch\n");
    80005b34:	00005517          	auipc	a0,0x5
    80005b38:	a0450513          	addi	a0,a0,-1532 # 8000a538 <CONSOLE_STATUS+0x528>
    80005b3c:	ffffc097          	auipc	ra,0xffffc
    80005b40:	3c4080e7          	jalr	964(ra) # 80001f00 <_Z11printStringPKc>
    __asm__ ("li t1, 5");
    80005b44:	00500313          	li	t1,5
    thread_dispatch();
    80005b48:	ffffc097          	auipc	ra,0xffffc
    80005b4c:	840080e7          	jalr	-1984(ra) # 80001388 <_Z15thread_dispatchv>

    uint64 result = fibonacci(16);
    80005b50:	01000513          	li	a0,16
    80005b54:	00000097          	auipc	ra,0x0
    80005b58:	f08080e7          	jalr	-248(ra) # 80005a5c <_ZL9fibonaccim>
    80005b5c:	00050913          	mv	s2,a0
    printString("D: fibonaci="); printInt(result); printString("\n");
    80005b60:	00005517          	auipc	a0,0x5
    80005b64:	9e850513          	addi	a0,a0,-1560 # 8000a548 <CONSOLE_STATUS+0x538>
    80005b68:	ffffc097          	auipc	ra,0xffffc
    80005b6c:	398080e7          	jalr	920(ra) # 80001f00 <_Z11printStringPKc>
    80005b70:	00000613          	li	a2,0
    80005b74:	00a00593          	li	a1,10
    80005b78:	0009051b          	sext.w	a0,s2
    80005b7c:	ffffc097          	auipc	ra,0xffffc
    80005b80:	534080e7          	jalr	1332(ra) # 800020b0 <_Z8printIntiii>
    80005b84:	00005517          	auipc	a0,0x5
    80005b88:	b9c50513          	addi	a0,a0,-1124 # 8000a720 <CONSOLE_STATUS+0x710>
    80005b8c:	ffffc097          	auipc	ra,0xffffc
    80005b90:	374080e7          	jalr	884(ra) # 80001f00 <_Z11printStringPKc>
    80005b94:	0400006f          	j	80005bd4 <_ZL11workerBodyDPv+0x104>

    for (; i < 16; i++) {
        printString("D: i="); printInt(i); printString("\n");
    80005b98:	00005517          	auipc	a0,0x5
    80005b9c:	99850513          	addi	a0,a0,-1640 # 8000a530 <CONSOLE_STATUS+0x520>
    80005ba0:	ffffc097          	auipc	ra,0xffffc
    80005ba4:	360080e7          	jalr	864(ra) # 80001f00 <_Z11printStringPKc>
    80005ba8:	00000613          	li	a2,0
    80005bac:	00a00593          	li	a1,10
    80005bb0:	00048513          	mv	a0,s1
    80005bb4:	ffffc097          	auipc	ra,0xffffc
    80005bb8:	4fc080e7          	jalr	1276(ra) # 800020b0 <_Z8printIntiii>
    80005bbc:	00005517          	auipc	a0,0x5
    80005bc0:	b6450513          	addi	a0,a0,-1180 # 8000a720 <CONSOLE_STATUS+0x710>
    80005bc4:	ffffc097          	auipc	ra,0xffffc
    80005bc8:	33c080e7          	jalr	828(ra) # 80001f00 <_Z11printStringPKc>
    for (; i < 16; i++) {
    80005bcc:	0014849b          	addiw	s1,s1,1
    80005bd0:	0ff4f493          	andi	s1,s1,255
    80005bd4:	00f00793          	li	a5,15
    80005bd8:	fc97f0e3          	bgeu	a5,s1,80005b98 <_ZL11workerBodyDPv+0xc8>
    }

    printString("D finished!\n");
    80005bdc:	00005517          	auipc	a0,0x5
    80005be0:	97c50513          	addi	a0,a0,-1668 # 8000a558 <CONSOLE_STATUS+0x548>
    80005be4:	ffffc097          	auipc	ra,0xffffc
    80005be8:	31c080e7          	jalr	796(ra) # 80001f00 <_Z11printStringPKc>
    finishedD = true;
    80005bec:	00100793          	li	a5,1
    80005bf0:	0000a717          	auipc	a4,0xa
    80005bf4:	72f70023          	sb	a5,1824(a4) # 80010310 <_ZL9finishedD>
    thread_dispatch();
    80005bf8:	ffffb097          	auipc	ra,0xffffb
    80005bfc:	790080e7          	jalr	1936(ra) # 80001388 <_Z15thread_dispatchv>
}
    80005c00:	01813083          	ld	ra,24(sp)
    80005c04:	01013403          	ld	s0,16(sp)
    80005c08:	00813483          	ld	s1,8(sp)
    80005c0c:	00013903          	ld	s2,0(sp)
    80005c10:	02010113          	addi	sp,sp,32
    80005c14:	00008067          	ret

0000000080005c18 <_ZL11workerBodyCPv>:
static void workerBodyC(void* arg) {
    80005c18:	fe010113          	addi	sp,sp,-32
    80005c1c:	00113c23          	sd	ra,24(sp)
    80005c20:	00813823          	sd	s0,16(sp)
    80005c24:	00913423          	sd	s1,8(sp)
    80005c28:	01213023          	sd	s2,0(sp)
    80005c2c:	02010413          	addi	s0,sp,32
    uint8 i = 0;
    80005c30:	00000493          	li	s1,0
    80005c34:	0400006f          	j	80005c74 <_ZL11workerBodyCPv+0x5c>
        printString("C: i="); printInt(i); printString("\n");
    80005c38:	00005517          	auipc	a0,0x5
    80005c3c:	8c850513          	addi	a0,a0,-1848 # 8000a500 <CONSOLE_STATUS+0x4f0>
    80005c40:	ffffc097          	auipc	ra,0xffffc
    80005c44:	2c0080e7          	jalr	704(ra) # 80001f00 <_Z11printStringPKc>
    80005c48:	00000613          	li	a2,0
    80005c4c:	00a00593          	li	a1,10
    80005c50:	00048513          	mv	a0,s1
    80005c54:	ffffc097          	auipc	ra,0xffffc
    80005c58:	45c080e7          	jalr	1116(ra) # 800020b0 <_Z8printIntiii>
    80005c5c:	00005517          	auipc	a0,0x5
    80005c60:	ac450513          	addi	a0,a0,-1340 # 8000a720 <CONSOLE_STATUS+0x710>
    80005c64:	ffffc097          	auipc	ra,0xffffc
    80005c68:	29c080e7          	jalr	668(ra) # 80001f00 <_Z11printStringPKc>
    for (; i < 3; i++) {
    80005c6c:	0014849b          	addiw	s1,s1,1
    80005c70:	0ff4f493          	andi	s1,s1,255
    80005c74:	00200793          	li	a5,2
    80005c78:	fc97f0e3          	bgeu	a5,s1,80005c38 <_ZL11workerBodyCPv+0x20>
    printString("C: dispatch\n");
    80005c7c:	00005517          	auipc	a0,0x5
    80005c80:	88c50513          	addi	a0,a0,-1908 # 8000a508 <CONSOLE_STATUS+0x4f8>
    80005c84:	ffffc097          	auipc	ra,0xffffc
    80005c88:	27c080e7          	jalr	636(ra) # 80001f00 <_Z11printStringPKc>
    __asm__ ("li t1, 7");
    80005c8c:	00700313          	li	t1,7
    thread_dispatch();
    80005c90:	ffffb097          	auipc	ra,0xffffb
    80005c94:	6f8080e7          	jalr	1784(ra) # 80001388 <_Z15thread_dispatchv>
    __asm__ ("mv %[t1], t1" : [t1] "=r"(t1));
    80005c98:	00030913          	mv	s2,t1
    printString("C: t1="); printInt(t1); printString("\n");
    80005c9c:	00005517          	auipc	a0,0x5
    80005ca0:	87c50513          	addi	a0,a0,-1924 # 8000a518 <CONSOLE_STATUS+0x508>
    80005ca4:	ffffc097          	auipc	ra,0xffffc
    80005ca8:	25c080e7          	jalr	604(ra) # 80001f00 <_Z11printStringPKc>
    80005cac:	00000613          	li	a2,0
    80005cb0:	00a00593          	li	a1,10
    80005cb4:	0009051b          	sext.w	a0,s2
    80005cb8:	ffffc097          	auipc	ra,0xffffc
    80005cbc:	3f8080e7          	jalr	1016(ra) # 800020b0 <_Z8printIntiii>
    80005cc0:	00005517          	auipc	a0,0x5
    80005cc4:	a6050513          	addi	a0,a0,-1440 # 8000a720 <CONSOLE_STATUS+0x710>
    80005cc8:	ffffc097          	auipc	ra,0xffffc
    80005ccc:	238080e7          	jalr	568(ra) # 80001f00 <_Z11printStringPKc>
    uint64 result = fibonacci(12);
    80005cd0:	00c00513          	li	a0,12
    80005cd4:	00000097          	auipc	ra,0x0
    80005cd8:	d88080e7          	jalr	-632(ra) # 80005a5c <_ZL9fibonaccim>
    80005cdc:	00050913          	mv	s2,a0
    printString("C: fibonaci="); printInt(result); printString("\n");
    80005ce0:	00005517          	auipc	a0,0x5
    80005ce4:	84050513          	addi	a0,a0,-1984 # 8000a520 <CONSOLE_STATUS+0x510>
    80005ce8:	ffffc097          	auipc	ra,0xffffc
    80005cec:	218080e7          	jalr	536(ra) # 80001f00 <_Z11printStringPKc>
    80005cf0:	00000613          	li	a2,0
    80005cf4:	00a00593          	li	a1,10
    80005cf8:	0009051b          	sext.w	a0,s2
    80005cfc:	ffffc097          	auipc	ra,0xffffc
    80005d00:	3b4080e7          	jalr	948(ra) # 800020b0 <_Z8printIntiii>
    80005d04:	00005517          	auipc	a0,0x5
    80005d08:	a1c50513          	addi	a0,a0,-1508 # 8000a720 <CONSOLE_STATUS+0x710>
    80005d0c:	ffffc097          	auipc	ra,0xffffc
    80005d10:	1f4080e7          	jalr	500(ra) # 80001f00 <_Z11printStringPKc>
    80005d14:	0400006f          	j	80005d54 <_ZL11workerBodyCPv+0x13c>
        printString("C: i="); printInt(i); printString("\n");
    80005d18:	00004517          	auipc	a0,0x4
    80005d1c:	7e850513          	addi	a0,a0,2024 # 8000a500 <CONSOLE_STATUS+0x4f0>
    80005d20:	ffffc097          	auipc	ra,0xffffc
    80005d24:	1e0080e7          	jalr	480(ra) # 80001f00 <_Z11printStringPKc>
    80005d28:	00000613          	li	a2,0
    80005d2c:	00a00593          	li	a1,10
    80005d30:	00048513          	mv	a0,s1
    80005d34:	ffffc097          	auipc	ra,0xffffc
    80005d38:	37c080e7          	jalr	892(ra) # 800020b0 <_Z8printIntiii>
    80005d3c:	00005517          	auipc	a0,0x5
    80005d40:	9e450513          	addi	a0,a0,-1564 # 8000a720 <CONSOLE_STATUS+0x710>
    80005d44:	ffffc097          	auipc	ra,0xffffc
    80005d48:	1bc080e7          	jalr	444(ra) # 80001f00 <_Z11printStringPKc>
    for (; i < 6; i++) {
    80005d4c:	0014849b          	addiw	s1,s1,1
    80005d50:	0ff4f493          	andi	s1,s1,255
    80005d54:	00500793          	li	a5,5
    80005d58:	fc97f0e3          	bgeu	a5,s1,80005d18 <_ZL11workerBodyCPv+0x100>
    printString("A finished!\n");
    80005d5c:	00004517          	auipc	a0,0x4
    80005d60:	77c50513          	addi	a0,a0,1916 # 8000a4d8 <CONSOLE_STATUS+0x4c8>
    80005d64:	ffffc097          	auipc	ra,0xffffc
    80005d68:	19c080e7          	jalr	412(ra) # 80001f00 <_Z11printStringPKc>
    finishedC = true;
    80005d6c:	00100793          	li	a5,1
    80005d70:	0000a717          	auipc	a4,0xa
    80005d74:	5af700a3          	sb	a5,1441(a4) # 80010311 <_ZL9finishedC>
    thread_dispatch();
    80005d78:	ffffb097          	auipc	ra,0xffffb
    80005d7c:	610080e7          	jalr	1552(ra) # 80001388 <_Z15thread_dispatchv>
}
    80005d80:	01813083          	ld	ra,24(sp)
    80005d84:	01013403          	ld	s0,16(sp)
    80005d88:	00813483          	ld	s1,8(sp)
    80005d8c:	00013903          	ld	s2,0(sp)
    80005d90:	02010113          	addi	sp,sp,32
    80005d94:	00008067          	ret

0000000080005d98 <_ZL11workerBodyBPv>:
static void workerBodyB(void* arg) {
    80005d98:	fe010113          	addi	sp,sp,-32
    80005d9c:	00113c23          	sd	ra,24(sp)
    80005da0:	00813823          	sd	s0,16(sp)
    80005da4:	00913423          	sd	s1,8(sp)
    80005da8:	01213023          	sd	s2,0(sp)
    80005dac:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 16; i++) {
    80005db0:	00000913          	li	s2,0
    80005db4:	0380006f          	j	80005dec <_ZL11workerBodyBPv+0x54>
            thread_dispatch();
    80005db8:	ffffb097          	auipc	ra,0xffffb
    80005dbc:	5d0080e7          	jalr	1488(ra) # 80001388 <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++) {
    80005dc0:	00148493          	addi	s1,s1,1
    80005dc4:	000027b7          	lui	a5,0x2
    80005dc8:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    80005dcc:	0097ee63          	bltu	a5,s1,80005de8 <_ZL11workerBodyBPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    80005dd0:	00000713          	li	a4,0
    80005dd4:	000077b7          	lui	a5,0x7
    80005dd8:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    80005ddc:	fce7eee3          	bltu	a5,a4,80005db8 <_ZL11workerBodyBPv+0x20>
    80005de0:	00170713          	addi	a4,a4,1
    80005de4:	ff1ff06f          	j	80005dd4 <_ZL11workerBodyBPv+0x3c>
    for (uint64 i = 0; i < 16; i++) {
    80005de8:	00190913          	addi	s2,s2,1
    80005dec:	00f00793          	li	a5,15
    80005df0:	0527e063          	bltu	a5,s2,80005e30 <_ZL11workerBodyBPv+0x98>
        printString("B: i="); printInt(i); printString("\n");
    80005df4:	00004517          	auipc	a0,0x4
    80005df8:	6f450513          	addi	a0,a0,1780 # 8000a4e8 <CONSOLE_STATUS+0x4d8>
    80005dfc:	ffffc097          	auipc	ra,0xffffc
    80005e00:	104080e7          	jalr	260(ra) # 80001f00 <_Z11printStringPKc>
    80005e04:	00000613          	li	a2,0
    80005e08:	00a00593          	li	a1,10
    80005e0c:	0009051b          	sext.w	a0,s2
    80005e10:	ffffc097          	auipc	ra,0xffffc
    80005e14:	2a0080e7          	jalr	672(ra) # 800020b0 <_Z8printIntiii>
    80005e18:	00005517          	auipc	a0,0x5
    80005e1c:	90850513          	addi	a0,a0,-1784 # 8000a720 <CONSOLE_STATUS+0x710>
    80005e20:	ffffc097          	auipc	ra,0xffffc
    80005e24:	0e0080e7          	jalr	224(ra) # 80001f00 <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    80005e28:	00000493          	li	s1,0
    80005e2c:	f99ff06f          	j	80005dc4 <_ZL11workerBodyBPv+0x2c>
    printString("B finished!\n");
    80005e30:	00004517          	auipc	a0,0x4
    80005e34:	6c050513          	addi	a0,a0,1728 # 8000a4f0 <CONSOLE_STATUS+0x4e0>
    80005e38:	ffffc097          	auipc	ra,0xffffc
    80005e3c:	0c8080e7          	jalr	200(ra) # 80001f00 <_Z11printStringPKc>
    finishedB = true;
    80005e40:	00100793          	li	a5,1
    80005e44:	0000a717          	auipc	a4,0xa
    80005e48:	4cf70723          	sb	a5,1230(a4) # 80010312 <_ZL9finishedB>
    thread_dispatch();
    80005e4c:	ffffb097          	auipc	ra,0xffffb
    80005e50:	53c080e7          	jalr	1340(ra) # 80001388 <_Z15thread_dispatchv>
}
    80005e54:	01813083          	ld	ra,24(sp)
    80005e58:	01013403          	ld	s0,16(sp)
    80005e5c:	00813483          	ld	s1,8(sp)
    80005e60:	00013903          	ld	s2,0(sp)
    80005e64:	02010113          	addi	sp,sp,32
    80005e68:	00008067          	ret

0000000080005e6c <_ZL11workerBodyAPv>:
static void workerBodyA(void* arg) {
    80005e6c:	fe010113          	addi	sp,sp,-32
    80005e70:	00113c23          	sd	ra,24(sp)
    80005e74:	00813823          	sd	s0,16(sp)
    80005e78:	00913423          	sd	s1,8(sp)
    80005e7c:	01213023          	sd	s2,0(sp)
    80005e80:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 10; i++) {
    80005e84:	00000913          	li	s2,0
    80005e88:	0380006f          	j	80005ec0 <_ZL11workerBodyAPv+0x54>
            thread_dispatch();
    80005e8c:	ffffb097          	auipc	ra,0xffffb
    80005e90:	4fc080e7          	jalr	1276(ra) # 80001388 <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++) {
    80005e94:	00148493          	addi	s1,s1,1
    80005e98:	000027b7          	lui	a5,0x2
    80005e9c:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    80005ea0:	0097ee63          	bltu	a5,s1,80005ebc <_ZL11workerBodyAPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    80005ea4:	00000713          	li	a4,0
    80005ea8:	000077b7          	lui	a5,0x7
    80005eac:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    80005eb0:	fce7eee3          	bltu	a5,a4,80005e8c <_ZL11workerBodyAPv+0x20>
    80005eb4:	00170713          	addi	a4,a4,1
    80005eb8:	ff1ff06f          	j	80005ea8 <_ZL11workerBodyAPv+0x3c>
    for (uint64 i = 0; i < 10; i++) {
    80005ebc:	00190913          	addi	s2,s2,1
    80005ec0:	00900793          	li	a5,9
    80005ec4:	0527e063          	bltu	a5,s2,80005f04 <_ZL11workerBodyAPv+0x98>
        printString("A: i="); printInt(i); printString("\n");
    80005ec8:	00004517          	auipc	a0,0x4
    80005ecc:	60850513          	addi	a0,a0,1544 # 8000a4d0 <CONSOLE_STATUS+0x4c0>
    80005ed0:	ffffc097          	auipc	ra,0xffffc
    80005ed4:	030080e7          	jalr	48(ra) # 80001f00 <_Z11printStringPKc>
    80005ed8:	00000613          	li	a2,0
    80005edc:	00a00593          	li	a1,10
    80005ee0:	0009051b          	sext.w	a0,s2
    80005ee4:	ffffc097          	auipc	ra,0xffffc
    80005ee8:	1cc080e7          	jalr	460(ra) # 800020b0 <_Z8printIntiii>
    80005eec:	00005517          	auipc	a0,0x5
    80005ef0:	83450513          	addi	a0,a0,-1996 # 8000a720 <CONSOLE_STATUS+0x710>
    80005ef4:	ffffc097          	auipc	ra,0xffffc
    80005ef8:	00c080e7          	jalr	12(ra) # 80001f00 <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    80005efc:	00000493          	li	s1,0
    80005f00:	f99ff06f          	j	80005e98 <_ZL11workerBodyAPv+0x2c>
    printString("A finished!\n");
    80005f04:	00004517          	auipc	a0,0x4
    80005f08:	5d450513          	addi	a0,a0,1492 # 8000a4d8 <CONSOLE_STATUS+0x4c8>
    80005f0c:	ffffc097          	auipc	ra,0xffffc
    80005f10:	ff4080e7          	jalr	-12(ra) # 80001f00 <_Z11printStringPKc>
    finishedA = true;
    80005f14:	00100793          	li	a5,1
    80005f18:	0000a717          	auipc	a4,0xa
    80005f1c:	3ef70da3          	sb	a5,1019(a4) # 80010313 <_ZL9finishedA>
}
    80005f20:	01813083          	ld	ra,24(sp)
    80005f24:	01013403          	ld	s0,16(sp)
    80005f28:	00813483          	ld	s1,8(sp)
    80005f2c:	00013903          	ld	s2,0(sp)
    80005f30:	02010113          	addi	sp,sp,32
    80005f34:	00008067          	ret

0000000080005f38 <_Z18Threads_C_API_testv>:


void Threads_C_API_test() {
    80005f38:	fd010113          	addi	sp,sp,-48
    80005f3c:	02113423          	sd	ra,40(sp)
    80005f40:	02813023          	sd	s0,32(sp)
    80005f44:	03010413          	addi	s0,sp,48
    thread_t threads[4];
    thread_create(&threads[0], workerBodyA, nullptr);
    80005f48:	00000613          	li	a2,0
    80005f4c:	00000597          	auipc	a1,0x0
    80005f50:	f2058593          	addi	a1,a1,-224 # 80005e6c <_ZL11workerBodyAPv>
    80005f54:	fd040513          	addi	a0,s0,-48
    80005f58:	ffffb097          	auipc	ra,0xffffb
    80005f5c:	3a8080e7          	jalr	936(ra) # 80001300 <_Z13thread_createPP8thread_sPFvPvES2_>
    printString("ThreadA created\n");
    80005f60:	00004517          	auipc	a0,0x4
    80005f64:	60850513          	addi	a0,a0,1544 # 8000a568 <CONSOLE_STATUS+0x558>
    80005f68:	ffffc097          	auipc	ra,0xffffc
    80005f6c:	f98080e7          	jalr	-104(ra) # 80001f00 <_Z11printStringPKc>

    thread_create(&threads[1], workerBodyB, nullptr);
    80005f70:	00000613          	li	a2,0
    80005f74:	00000597          	auipc	a1,0x0
    80005f78:	e2458593          	addi	a1,a1,-476 # 80005d98 <_ZL11workerBodyBPv>
    80005f7c:	fd840513          	addi	a0,s0,-40
    80005f80:	ffffb097          	auipc	ra,0xffffb
    80005f84:	380080e7          	jalr	896(ra) # 80001300 <_Z13thread_createPP8thread_sPFvPvES2_>
    printString("ThreadB created\n");
    80005f88:	00004517          	auipc	a0,0x4
    80005f8c:	5f850513          	addi	a0,a0,1528 # 8000a580 <CONSOLE_STATUS+0x570>
    80005f90:	ffffc097          	auipc	ra,0xffffc
    80005f94:	f70080e7          	jalr	-144(ra) # 80001f00 <_Z11printStringPKc>

    thread_create(&threads[2], workerBodyC, nullptr);
    80005f98:	00000613          	li	a2,0
    80005f9c:	00000597          	auipc	a1,0x0
    80005fa0:	c7c58593          	addi	a1,a1,-900 # 80005c18 <_ZL11workerBodyCPv>
    80005fa4:	fe040513          	addi	a0,s0,-32
    80005fa8:	ffffb097          	auipc	ra,0xffffb
    80005fac:	358080e7          	jalr	856(ra) # 80001300 <_Z13thread_createPP8thread_sPFvPvES2_>
    printString("ThreadC created\n");
    80005fb0:	00004517          	auipc	a0,0x4
    80005fb4:	5e850513          	addi	a0,a0,1512 # 8000a598 <CONSOLE_STATUS+0x588>
    80005fb8:	ffffc097          	auipc	ra,0xffffc
    80005fbc:	f48080e7          	jalr	-184(ra) # 80001f00 <_Z11printStringPKc>

    thread_create(&threads[3], workerBodyD, nullptr);
    80005fc0:	00000613          	li	a2,0
    80005fc4:	00000597          	auipc	a1,0x0
    80005fc8:	b0c58593          	addi	a1,a1,-1268 # 80005ad0 <_ZL11workerBodyDPv>
    80005fcc:	fe840513          	addi	a0,s0,-24
    80005fd0:	ffffb097          	auipc	ra,0xffffb
    80005fd4:	330080e7          	jalr	816(ra) # 80001300 <_Z13thread_createPP8thread_sPFvPvES2_>
    printString("ThreadD created\n");
    80005fd8:	00004517          	auipc	a0,0x4
    80005fdc:	5d850513          	addi	a0,a0,1496 # 8000a5b0 <CONSOLE_STATUS+0x5a0>
    80005fe0:	ffffc097          	auipc	ra,0xffffc
    80005fe4:	f20080e7          	jalr	-224(ra) # 80001f00 <_Z11printStringPKc>
    80005fe8:	00c0006f          	j	80005ff4 <_Z18Threads_C_API_testv+0xbc>

    while (!(finishedA && finishedB && finishedC && finishedD)) {
        thread_dispatch();
    80005fec:	ffffb097          	auipc	ra,0xffffb
    80005ff0:	39c080e7          	jalr	924(ra) # 80001388 <_Z15thread_dispatchv>
    while (!(finishedA && finishedB && finishedC && finishedD)) {
    80005ff4:	0000a797          	auipc	a5,0xa
    80005ff8:	31f7c783          	lbu	a5,799(a5) # 80010313 <_ZL9finishedA>
    80005ffc:	fe0788e3          	beqz	a5,80005fec <_Z18Threads_C_API_testv+0xb4>
    80006000:	0000a797          	auipc	a5,0xa
    80006004:	3127c783          	lbu	a5,786(a5) # 80010312 <_ZL9finishedB>
    80006008:	fe0782e3          	beqz	a5,80005fec <_Z18Threads_C_API_testv+0xb4>
    8000600c:	0000a797          	auipc	a5,0xa
    80006010:	3057c783          	lbu	a5,773(a5) # 80010311 <_ZL9finishedC>
    80006014:	fc078ce3          	beqz	a5,80005fec <_Z18Threads_C_API_testv+0xb4>
    80006018:	0000a797          	auipc	a5,0xa
    8000601c:	2f87c783          	lbu	a5,760(a5) # 80010310 <_ZL9finishedD>
    80006020:	fc0786e3          	beqz	a5,80005fec <_Z18Threads_C_API_testv+0xb4>
    }

}
    80006024:	02813083          	ld	ra,40(sp)
    80006028:	02013403          	ld	s0,32(sp)
    8000602c:	03010113          	addi	sp,sp,48
    80006030:	00008067          	ret

0000000080006034 <_ZN16ProducerKeyboard16producerKeyboardEPv>:
    void run() override {
        producerKeyboard(td);
    }
};

void ProducerKeyboard::producerKeyboard(void *arg) {
    80006034:	fd010113          	addi	sp,sp,-48
    80006038:	02113423          	sd	ra,40(sp)
    8000603c:	02813023          	sd	s0,32(sp)
    80006040:	00913c23          	sd	s1,24(sp)
    80006044:	01213823          	sd	s2,16(sp)
    80006048:	01313423          	sd	s3,8(sp)
    8000604c:	03010413          	addi	s0,sp,48
    80006050:	00050993          	mv	s3,a0
    80006054:	00058493          	mv	s1,a1
    struct thread_data *data = (struct thread_data *) arg;

    int key;
    int i = 0;
    80006058:	00000913          	li	s2,0
    8000605c:	00c0006f          	j	80006068 <_ZN16ProducerKeyboard16producerKeyboardEPv+0x34>
            thread_dispatch();
    80006060:	ffffb097          	auipc	ra,0xffffb
    80006064:	328080e7          	jalr	808(ra) # 80001388 <_Z15thread_dispatchv>
    while ((key = getc()) != 13) {
    80006068:	ffffb097          	auipc	ra,0xffffb
    8000606c:	50c080e7          	jalr	1292(ra) # 80001574 <_Z4getcv>
    80006070:	0005059b          	sext.w	a1,a0
    80006074:	00d00793          	li	a5,13
    80006078:	02f58a63          	beq	a1,a5,800060ac <_ZN16ProducerKeyboard16producerKeyboardEPv+0x78>
        data->buffer->put(key);
    8000607c:	0084b503          	ld	a0,8(s1)
    80006080:	00001097          	auipc	ra,0x1
    80006084:	904080e7          	jalr	-1788(ra) # 80006984 <_ZN9BufferCPP3putEi>
        i++;
    80006088:	0019071b          	addiw	a4,s2,1
    8000608c:	0007091b          	sext.w	s2,a4

        if (i % (10 * data->id) == 0) {
    80006090:	0004a683          	lw	a3,0(s1)
    80006094:	0026979b          	slliw	a5,a3,0x2
    80006098:	00d787bb          	addw	a5,a5,a3
    8000609c:	0017979b          	slliw	a5,a5,0x1
    800060a0:	02f767bb          	remw	a5,a4,a5
    800060a4:	fc0792e3          	bnez	a5,80006068 <_ZN16ProducerKeyboard16producerKeyboardEPv+0x34>
    800060a8:	fb9ff06f          	j	80006060 <_ZN16ProducerKeyboard16producerKeyboardEPv+0x2c>
            Thread::dispatch();
        }
    }

    threadEnd = 1;
    800060ac:	00100793          	li	a5,1
    800060b0:	0000a717          	auipc	a4,0xa
    800060b4:	26f72423          	sw	a5,616(a4) # 80010318 <_ZL9threadEnd>
    td->buffer->put('!');
    800060b8:	0209b783          	ld	a5,32(s3)
    800060bc:	02100593          	li	a1,33
    800060c0:	0087b503          	ld	a0,8(a5)
    800060c4:	00001097          	auipc	ra,0x1
    800060c8:	8c0080e7          	jalr	-1856(ra) # 80006984 <_ZN9BufferCPP3putEi>

    data->wait->signal();
    800060cc:	0104b783          	ld	a5,16(s1)
            return sem_signal(myHandle);
    800060d0:	0087b503          	ld	a0,8(a5)
    800060d4:	ffffb097          	auipc	ra,0xffffb
    800060d8:	42c080e7          	jalr	1068(ra) # 80001500 <_Z10sem_signalP5sem_s>
}
    800060dc:	02813083          	ld	ra,40(sp)
    800060e0:	02013403          	ld	s0,32(sp)
    800060e4:	01813483          	ld	s1,24(sp)
    800060e8:	01013903          	ld	s2,16(sp)
    800060ec:	00813983          	ld	s3,8(sp)
    800060f0:	03010113          	addi	sp,sp,48
    800060f4:	00008067          	ret

00000000800060f8 <_ZN12ProducerSync8producerEPv>:
    void run() override {
        producer(td);
    }
};

void ProducerSync::producer(void *arg) {
    800060f8:	fe010113          	addi	sp,sp,-32
    800060fc:	00113c23          	sd	ra,24(sp)
    80006100:	00813823          	sd	s0,16(sp)
    80006104:	00913423          	sd	s1,8(sp)
    80006108:	01213023          	sd	s2,0(sp)
    8000610c:	02010413          	addi	s0,sp,32
    80006110:	00058493          	mv	s1,a1
    struct thread_data *data = (struct thread_data *) arg;

    int i = 0;
    80006114:	00000913          	li	s2,0
    80006118:	00c0006f          	j	80006124 <_ZN12ProducerSync8producerEPv+0x2c>
            thread_dispatch();
    8000611c:	ffffb097          	auipc	ra,0xffffb
    80006120:	26c080e7          	jalr	620(ra) # 80001388 <_Z15thread_dispatchv>
    while (!threadEnd) {
    80006124:	0000a797          	auipc	a5,0xa
    80006128:	1f47a783          	lw	a5,500(a5) # 80010318 <_ZL9threadEnd>
    8000612c:	02079e63          	bnez	a5,80006168 <_ZN12ProducerSync8producerEPv+0x70>
        data->buffer->put(data->id + '0');
    80006130:	0004a583          	lw	a1,0(s1)
    80006134:	0305859b          	addiw	a1,a1,48
    80006138:	0084b503          	ld	a0,8(s1)
    8000613c:	00001097          	auipc	ra,0x1
    80006140:	848080e7          	jalr	-1976(ra) # 80006984 <_ZN9BufferCPP3putEi>
        i++;
    80006144:	0019071b          	addiw	a4,s2,1
    80006148:	0007091b          	sext.w	s2,a4

        if (i % (10 * data->id) == 0) {
    8000614c:	0004a683          	lw	a3,0(s1)
    80006150:	0026979b          	slliw	a5,a3,0x2
    80006154:	00d787bb          	addw	a5,a5,a3
    80006158:	0017979b          	slliw	a5,a5,0x1
    8000615c:	02f767bb          	remw	a5,a4,a5
    80006160:	fc0792e3          	bnez	a5,80006124 <_ZN12ProducerSync8producerEPv+0x2c>
    80006164:	fb9ff06f          	j	8000611c <_ZN12ProducerSync8producerEPv+0x24>
            Thread::dispatch();
        }
    }

    data->wait->signal();
    80006168:	0104b783          	ld	a5,16(s1)
            return sem_signal(myHandle);
    8000616c:	0087b503          	ld	a0,8(a5)
    80006170:	ffffb097          	auipc	ra,0xffffb
    80006174:	390080e7          	jalr	912(ra) # 80001500 <_Z10sem_signalP5sem_s>
}
    80006178:	01813083          	ld	ra,24(sp)
    8000617c:	01013403          	ld	s0,16(sp)
    80006180:	00813483          	ld	s1,8(sp)
    80006184:	00013903          	ld	s2,0(sp)
    80006188:	02010113          	addi	sp,sp,32
    8000618c:	00008067          	ret

0000000080006190 <_ZN12ConsumerSync8consumerEPv>:
    void run() override {
        consumer(td);
    }
};

void ConsumerSync::consumer(void *arg) {
    80006190:	fd010113          	addi	sp,sp,-48
    80006194:	02113423          	sd	ra,40(sp)
    80006198:	02813023          	sd	s0,32(sp)
    8000619c:	00913c23          	sd	s1,24(sp)
    800061a0:	01213823          	sd	s2,16(sp)
    800061a4:	01313423          	sd	s3,8(sp)
    800061a8:	01413023          	sd	s4,0(sp)
    800061ac:	03010413          	addi	s0,sp,48
    800061b0:	00050993          	mv	s3,a0
    800061b4:	00058913          	mv	s2,a1
    struct thread_data *data = (struct thread_data *) arg;

    int i = 0;
    800061b8:	00000a13          	li	s4,0
    800061bc:	01c0006f          	j	800061d8 <_ZN12ConsumerSync8consumerEPv+0x48>
            thread_dispatch();
    800061c0:	ffffb097          	auipc	ra,0xffffb
    800061c4:	1c8080e7          	jalr	456(ra) # 80001388 <_Z15thread_dispatchv>
        }
    800061c8:	0500006f          	j	80006218 <_ZN12ConsumerSync8consumerEPv+0x88>
        if (i % (5 * data->id) == 0) {
            Thread::dispatch();
        }

        if (i % 80 == 0) {
            putc('\n');
    800061cc:	00a00513          	li	a0,10
    800061d0:	ffffb097          	auipc	ra,0xffffb
    800061d4:	3e0080e7          	jalr	992(ra) # 800015b0 <_Z4putcc>
    while (!threadEnd) {
    800061d8:	0000a797          	auipc	a5,0xa
    800061dc:	1407a783          	lw	a5,320(a5) # 80010318 <_ZL9threadEnd>
    800061e0:	06079263          	bnez	a5,80006244 <_ZN12ConsumerSync8consumerEPv+0xb4>
        int key = data->buffer->get();
    800061e4:	00893503          	ld	a0,8(s2)
    800061e8:	00001097          	auipc	ra,0x1
    800061ec:	83c080e7          	jalr	-1988(ra) # 80006a24 <_ZN9BufferCPP3getEv>
        i++;
    800061f0:	001a049b          	addiw	s1,s4,1
    800061f4:	00048a1b          	sext.w	s4,s1
        putc(key);
    800061f8:	0ff57513          	andi	a0,a0,255
    800061fc:	ffffb097          	auipc	ra,0xffffb
    80006200:	3b4080e7          	jalr	948(ra) # 800015b0 <_Z4putcc>
        if (i % (5 * data->id) == 0) {
    80006204:	00092703          	lw	a4,0(s2)
    80006208:	0027179b          	slliw	a5,a4,0x2
    8000620c:	00e787bb          	addw	a5,a5,a4
    80006210:	02f4e7bb          	remw	a5,s1,a5
    80006214:	fa0786e3          	beqz	a5,800061c0 <_ZN12ConsumerSync8consumerEPv+0x30>
        if (i % 80 == 0) {
    80006218:	05000793          	li	a5,80
    8000621c:	02f4e4bb          	remw	s1,s1,a5
    80006220:	fa049ce3          	bnez	s1,800061d8 <_ZN12ConsumerSync8consumerEPv+0x48>
    80006224:	fa9ff06f          	j	800061cc <_ZN12ConsumerSync8consumerEPv+0x3c>
        }
    }


    while (td->buffer->getCnt() > 0) {
        int key = td->buffer->get();
    80006228:	0209b783          	ld	a5,32(s3)
    8000622c:	0087b503          	ld	a0,8(a5)
    80006230:	00000097          	auipc	ra,0x0
    80006234:	7f4080e7          	jalr	2036(ra) # 80006a24 <_ZN9BufferCPP3getEv>
            ::putc(c);
    80006238:	0ff57513          	andi	a0,a0,255
    8000623c:	ffffb097          	auipc	ra,0xffffb
    80006240:	374080e7          	jalr	884(ra) # 800015b0 <_Z4putcc>
    while (td->buffer->getCnt() > 0) {
    80006244:	0209b783          	ld	a5,32(s3)
    80006248:	0087b503          	ld	a0,8(a5)
    8000624c:	00001097          	auipc	ra,0x1
    80006250:	874080e7          	jalr	-1932(ra) # 80006ac0 <_ZN9BufferCPP6getCntEv>
    80006254:	fca04ae3          	bgtz	a0,80006228 <_ZN12ConsumerSync8consumerEPv+0x98>
        Console::putc(key);
    }

    data->wait->signal();
    80006258:	01093783          	ld	a5,16(s2)
            return sem_signal(myHandle);
    8000625c:	0087b503          	ld	a0,8(a5)
    80006260:	ffffb097          	auipc	ra,0xffffb
    80006264:	2a0080e7          	jalr	672(ra) # 80001500 <_Z10sem_signalP5sem_s>
}
    80006268:	02813083          	ld	ra,40(sp)
    8000626c:	02013403          	ld	s0,32(sp)
    80006270:	01813483          	ld	s1,24(sp)
    80006274:	01013903          	ld	s2,16(sp)
    80006278:	00813983          	ld	s3,8(sp)
    8000627c:	00013a03          	ld	s4,0(sp)
    80006280:	03010113          	addi	sp,sp,48
    80006284:	00008067          	ret

0000000080006288 <_Z29producerConsumer_CPP_Sync_APIv>:

void producerConsumer_CPP_Sync_API() {
    80006288:	f9010113          	addi	sp,sp,-112
    8000628c:	06113423          	sd	ra,104(sp)
    80006290:	06813023          	sd	s0,96(sp)
    80006294:	04913c23          	sd	s1,88(sp)
    80006298:	05213823          	sd	s2,80(sp)
    8000629c:	05313423          	sd	s3,72(sp)
    800062a0:	05413023          	sd	s4,64(sp)
    800062a4:	03513c23          	sd	s5,56(sp)
    800062a8:	03613823          	sd	s6,48(sp)
    800062ac:	03713423          	sd	s7,40(sp)
    800062b0:	03813023          	sd	s8,32(sp)
    800062b4:	07010413          	addi	s0,sp,112
    for (int i = 0; i < threadNum; i++) {
        delete threads[i];
    }
    delete consumerThread;
    delete waitForAll;
    delete buffer;
    800062b8:	00010b93          	mv	s7,sp
    printString("Unesite broj proizvodjaca?\n");
    800062bc:	00004517          	auipc	a0,0x4
    800062c0:	12c50513          	addi	a0,a0,300 # 8000a3e8 <CONSOLE_STATUS+0x3d8>
    800062c4:	ffffc097          	auipc	ra,0xffffc
    800062c8:	c3c080e7          	jalr	-964(ra) # 80001f00 <_Z11printStringPKc>
    getString(input, 30);
    800062cc:	01e00593          	li	a1,30
    800062d0:	f9040493          	addi	s1,s0,-112
    800062d4:	00048513          	mv	a0,s1
    800062d8:	ffffc097          	auipc	ra,0xffffc
    800062dc:	cb0080e7          	jalr	-848(ra) # 80001f88 <_Z9getStringPci>
    threadNum = stringToInt(input);
    800062e0:	00048513          	mv	a0,s1
    800062e4:	ffffc097          	auipc	ra,0xffffc
    800062e8:	d7c080e7          	jalr	-644(ra) # 80002060 <_Z11stringToIntPKc>
    800062ec:	00050913          	mv	s2,a0
    printString("Unesite velicinu bafera?\n");
    800062f0:	00004517          	auipc	a0,0x4
    800062f4:	11850513          	addi	a0,a0,280 # 8000a408 <CONSOLE_STATUS+0x3f8>
    800062f8:	ffffc097          	auipc	ra,0xffffc
    800062fc:	c08080e7          	jalr	-1016(ra) # 80001f00 <_Z11printStringPKc>
    getString(input, 30);
    80006300:	01e00593          	li	a1,30
    80006304:	00048513          	mv	a0,s1
    80006308:	ffffc097          	auipc	ra,0xffffc
    8000630c:	c80080e7          	jalr	-896(ra) # 80001f88 <_Z9getStringPci>
    n = stringToInt(input);
    80006310:	00048513          	mv	a0,s1
    80006314:	ffffc097          	auipc	ra,0xffffc
    80006318:	d4c080e7          	jalr	-692(ra) # 80002060 <_Z11stringToIntPKc>
    8000631c:	00050493          	mv	s1,a0
    printString("Broj proizvodjaca "); printInt(threadNum);
    80006320:	00004517          	auipc	a0,0x4
    80006324:	10850513          	addi	a0,a0,264 # 8000a428 <CONSOLE_STATUS+0x418>
    80006328:	ffffc097          	auipc	ra,0xffffc
    8000632c:	bd8080e7          	jalr	-1064(ra) # 80001f00 <_Z11printStringPKc>
    80006330:	00000613          	li	a2,0
    80006334:	00a00593          	li	a1,10
    80006338:	00090513          	mv	a0,s2
    8000633c:	ffffc097          	auipc	ra,0xffffc
    80006340:	d74080e7          	jalr	-652(ra) # 800020b0 <_Z8printIntiii>
    printString(" i velicina bafera "); printInt(n);
    80006344:	00004517          	auipc	a0,0x4
    80006348:	0fc50513          	addi	a0,a0,252 # 8000a440 <CONSOLE_STATUS+0x430>
    8000634c:	ffffc097          	auipc	ra,0xffffc
    80006350:	bb4080e7          	jalr	-1100(ra) # 80001f00 <_Z11printStringPKc>
    80006354:	00000613          	li	a2,0
    80006358:	00a00593          	li	a1,10
    8000635c:	00048513          	mv	a0,s1
    80006360:	ffffc097          	auipc	ra,0xffffc
    80006364:	d50080e7          	jalr	-688(ra) # 800020b0 <_Z8printIntiii>
    printString(".\n");
    80006368:	00004517          	auipc	a0,0x4
    8000636c:	0f050513          	addi	a0,a0,240 # 8000a458 <CONSOLE_STATUS+0x448>
    80006370:	ffffc097          	auipc	ra,0xffffc
    80006374:	b90080e7          	jalr	-1136(ra) # 80001f00 <_Z11printStringPKc>
    if(threadNum > n) {
    80006378:	0324c463          	blt	s1,s2,800063a0 <_Z29producerConsumer_CPP_Sync_APIv+0x118>
    } else if (threadNum < 1) {
    8000637c:	03205c63          	blez	s2,800063b4 <_Z29producerConsumer_CPP_Sync_APIv+0x12c>
    BufferCPP *buffer = new BufferCPP(n);
    80006380:	03800513          	li	a0,56
    80006384:	ffffd097          	auipc	ra,0xffffd
    80006388:	84c080e7          	jalr	-1972(ra) # 80002bd0 <_Znwm>
    8000638c:	00050a93          	mv	s5,a0
    80006390:	00048593          	mv	a1,s1
    80006394:	00000097          	auipc	ra,0x0
    80006398:	45c080e7          	jalr	1116(ra) # 800067f0 <_ZN9BufferCPPC1Ei>
    8000639c:	0300006f          	j	800063cc <_Z29producerConsumer_CPP_Sync_APIv+0x144>
        printString("Broj proizvodjaca ne sme biti manji od velicine bafera!\n");
    800063a0:	00004517          	auipc	a0,0x4
    800063a4:	0c050513          	addi	a0,a0,192 # 8000a460 <CONSOLE_STATUS+0x450>
    800063a8:	ffffc097          	auipc	ra,0xffffc
    800063ac:	b58080e7          	jalr	-1192(ra) # 80001f00 <_Z11printStringPKc>
        return;
    800063b0:	0140006f          	j	800063c4 <_Z29producerConsumer_CPP_Sync_APIv+0x13c>
        printString("Broj proizvodjaca mora biti veci od nula!\n");
    800063b4:	00004517          	auipc	a0,0x4
    800063b8:	0ec50513          	addi	a0,a0,236 # 8000a4a0 <CONSOLE_STATUS+0x490>
    800063bc:	ffffc097          	auipc	ra,0xffffc
    800063c0:	b44080e7          	jalr	-1212(ra) # 80001f00 <_Z11printStringPKc>
        return;
    800063c4:	000b8113          	mv	sp,s7
    800063c8:	2780006f          	j	80006640 <_Z29producerConsumer_CPP_Sync_APIv+0x3b8>
    waitForAll = new Semaphore(0);
    800063cc:	01000513          	li	a0,16
    800063d0:	ffffd097          	auipc	ra,0xffffd
    800063d4:	800080e7          	jalr	-2048(ra) # 80002bd0 <_Znwm>
    800063d8:	00050493          	mv	s1,a0
        Semaphore (unsigned init = 1){
    800063dc:	00006797          	auipc	a5,0x6
    800063e0:	65478793          	addi	a5,a5,1620 # 8000ca30 <_ZTV9Semaphore+0x10>
    800063e4:	00f53023          	sd	a5,0(a0)
            sem_open(&myHandle,init);
    800063e8:	00000593          	li	a1,0
    800063ec:	00850513          	addi	a0,a0,8
    800063f0:	ffffb097          	auipc	ra,0xffffb
    800063f4:	04c080e7          	jalr	76(ra) # 8000143c <_Z8sem_openPP5sem_sj>
    800063f8:	0000a797          	auipc	a5,0xa
    800063fc:	f297b423          	sd	s1,-216(a5) # 80010320 <_ZL10waitForAll>
    Thread* threads[threadNum];
    80006400:	00391793          	slli	a5,s2,0x3
    80006404:	00f78793          	addi	a5,a5,15
    80006408:	ff07f793          	andi	a5,a5,-16
    8000640c:	40f10133          	sub	sp,sp,a5
    80006410:	00010993          	mv	s3,sp
    struct thread_data data[threadNum + 1];
    80006414:	0019071b          	addiw	a4,s2,1
    80006418:	00171793          	slli	a5,a4,0x1
    8000641c:	00e787b3          	add	a5,a5,a4
    80006420:	00379793          	slli	a5,a5,0x3
    80006424:	00f78793          	addi	a5,a5,15
    80006428:	ff07f793          	andi	a5,a5,-16
    8000642c:	40f10133          	sub	sp,sp,a5
    80006430:	00010a13          	mv	s4,sp
    data[threadNum].id = threadNum;
    80006434:	00191c13          	slli	s8,s2,0x1
    80006438:	012c07b3          	add	a5,s8,s2
    8000643c:	00379793          	slli	a5,a5,0x3
    80006440:	00fa07b3          	add	a5,s4,a5
    80006444:	0127a023          	sw	s2,0(a5)
    data[threadNum].buffer = buffer;
    80006448:	0157b423          	sd	s5,8(a5)
    data[threadNum].wait = waitForAll;
    8000644c:	0097b823          	sd	s1,16(a5)
    consumerThread = new ConsumerSync(data+threadNum);
    80006450:	02800513          	li	a0,40
    80006454:	ffffc097          	auipc	ra,0xffffc
    80006458:	77c080e7          	jalr	1916(ra) # 80002bd0 <_Znwm>
    8000645c:	00050b13          	mv	s6,a0
    80006460:	012c0c33          	add	s8,s8,s2
    80006464:	003c1c13          	slli	s8,s8,0x3
    80006468:	018a0c33          	add	s8,s4,s8
            body= nullptr;
    8000646c:	00053823          	sd	zero,16(a0)
            arg= nullptr;
    80006470:	00053c23          	sd	zero,24(a0)
    ConsumerSync(thread_data* _td):Thread(), td(_td) {}
    80006474:	00006797          	auipc	a5,0x6
    80006478:	6a478793          	addi	a5,a5,1700 # 8000cb18 <_ZTV12ConsumerSync+0x10>
    8000647c:	00f53023          	sd	a5,0(a0)
    80006480:	03853023          	sd	s8,32(a0)
            if(body== nullptr) return thread_create(&myHandle,&threadEntry, this);
    80006484:	00050613          	mv	a2,a0
    80006488:	ffffc597          	auipc	a1,0xffffc
    8000648c:	6f458593          	addi	a1,a1,1780 # 80002b7c <_ZN6Thread11threadEntryEPv>
    80006490:	00850513          	addi	a0,a0,8
    80006494:	ffffb097          	auipc	ra,0xffffb
    80006498:	e6c080e7          	jalr	-404(ra) # 80001300 <_Z13thread_createPP8thread_sPFvPvES2_>
    for (int i = 0; i < threadNum; i++) {
    8000649c:	00000493          	li	s1,0
    800064a0:	0640006f          	j	80006504 <_Z29producerConsumer_CPP_Sync_APIv+0x27c>
            threads[i] = new ProducerKeyboard(data+i);
    800064a4:	02800513          	li	a0,40
    800064a8:	ffffc097          	auipc	ra,0xffffc
    800064ac:	728080e7          	jalr	1832(ra) # 80002bd0 <_Znwm>
    800064b0:	00149793          	slli	a5,s1,0x1
    800064b4:	009787b3          	add	a5,a5,s1
    800064b8:	00379793          	slli	a5,a5,0x3
    800064bc:	00fa07b3          	add	a5,s4,a5
            body= nullptr;
    800064c0:	00053823          	sd	zero,16(a0)
            arg= nullptr;
    800064c4:	00053c23          	sd	zero,24(a0)
    ProducerKeyboard(thread_data* _td):Thread(), td(_td) {}
    800064c8:	00006717          	auipc	a4,0x6
    800064cc:	60070713          	addi	a4,a4,1536 # 8000cac8 <_ZTV16ProducerKeyboard+0x10>
    800064d0:	00e53023          	sd	a4,0(a0)
    800064d4:	02f53023          	sd	a5,32(a0)
            threads[i] = new ProducerKeyboard(data+i);
    800064d8:	00349793          	slli	a5,s1,0x3
    800064dc:	00f987b3          	add	a5,s3,a5
    800064e0:	00a7b023          	sd	a0,0(a5)
    800064e4:	08c0006f          	j	80006570 <_Z29producerConsumer_CPP_Sync_APIv+0x2e8>
            if(body== nullptr) return thread_create(&myHandle,&threadEntry, this);
    800064e8:	00050613          	mv	a2,a0
    800064ec:	ffffc597          	auipc	a1,0xffffc
    800064f0:	69058593          	addi	a1,a1,1680 # 80002b7c <_ZN6Thread11threadEntryEPv>
    800064f4:	00850513          	addi	a0,a0,8
    800064f8:	ffffb097          	auipc	ra,0xffffb
    800064fc:	e08080e7          	jalr	-504(ra) # 80001300 <_Z13thread_createPP8thread_sPFvPvES2_>
    for (int i = 0; i < threadNum; i++) {
    80006500:	0014849b          	addiw	s1,s1,1
    80006504:	0924da63          	bge	s1,s2,80006598 <_Z29producerConsumer_CPP_Sync_APIv+0x310>
        data[i].id = i;
    80006508:	00149793          	slli	a5,s1,0x1
    8000650c:	009787b3          	add	a5,a5,s1
    80006510:	00379793          	slli	a5,a5,0x3
    80006514:	00fa07b3          	add	a5,s4,a5
    80006518:	0097a023          	sw	s1,0(a5)
        data[i].buffer = buffer;
    8000651c:	0157b423          	sd	s5,8(a5)
        data[i].wait = waitForAll;
    80006520:	0000a717          	auipc	a4,0xa
    80006524:	e0073703          	ld	a4,-512(a4) # 80010320 <_ZL10waitForAll>
    80006528:	00e7b823          	sd	a4,16(a5)
        if(i>0) {
    8000652c:	f6905ce3          	blez	s1,800064a4 <_Z29producerConsumer_CPP_Sync_APIv+0x21c>
            threads[i] = new ProducerSync(data+i);
    80006530:	02800513          	li	a0,40
    80006534:	ffffc097          	auipc	ra,0xffffc
    80006538:	69c080e7          	jalr	1692(ra) # 80002bd0 <_Znwm>
    8000653c:	00149793          	slli	a5,s1,0x1
    80006540:	009787b3          	add	a5,a5,s1
    80006544:	00379793          	slli	a5,a5,0x3
    80006548:	00fa07b3          	add	a5,s4,a5
            body= nullptr;
    8000654c:	00053823          	sd	zero,16(a0)
            arg= nullptr;
    80006550:	00053c23          	sd	zero,24(a0)
    ProducerSync(thread_data* _td):Thread(), td(_td) {}
    80006554:	00006717          	auipc	a4,0x6
    80006558:	59c70713          	addi	a4,a4,1436 # 8000caf0 <_ZTV12ProducerSync+0x10>
    8000655c:	00e53023          	sd	a4,0(a0)
    80006560:	02f53023          	sd	a5,32(a0)
            threads[i] = new ProducerSync(data+i);
    80006564:	00349793          	slli	a5,s1,0x3
    80006568:	00f987b3          	add	a5,s3,a5
    8000656c:	00a7b023          	sd	a0,0(a5)
        threads[i]->start();
    80006570:	00349793          	slli	a5,s1,0x3
    80006574:	00f987b3          	add	a5,s3,a5
    80006578:	0007b503          	ld	a0,0(a5)
            if(body== nullptr) return thread_create(&myHandle,&threadEntry, this);
    8000657c:	01053583          	ld	a1,16(a0)
    80006580:	f60584e3          	beqz	a1,800064e8 <_Z29producerConsumer_CPP_Sync_APIv+0x260>
            else return thread_create(&myHandle,body,arg);
    80006584:	01853603          	ld	a2,24(a0)
    80006588:	00850513          	addi	a0,a0,8
    8000658c:	ffffb097          	auipc	ra,0xffffb
    80006590:	d74080e7          	jalr	-652(ra) # 80001300 <_Z13thread_createPP8thread_sPFvPvES2_>
    80006594:	f6dff06f          	j	80006500 <_Z29producerConsumer_CPP_Sync_APIv+0x278>
            thread_dispatch();
    80006598:	ffffb097          	auipc	ra,0xffffb
    8000659c:	df0080e7          	jalr	-528(ra) # 80001388 <_Z15thread_dispatchv>
    for (int i = 0; i <= threadNum; i++) {
    800065a0:	00000493          	li	s1,0
    800065a4:	02994063          	blt	s2,s1,800065c4 <_Z29producerConsumer_CPP_Sync_APIv+0x33c>
            return sem_wait(myHandle);
    800065a8:	0000a797          	auipc	a5,0xa
    800065ac:	d787b783          	ld	a5,-648(a5) # 80010320 <_ZL10waitForAll>
    800065b0:	0087b503          	ld	a0,8(a5)
    800065b4:	ffffb097          	auipc	ra,0xffffb
    800065b8:	f0c080e7          	jalr	-244(ra) # 800014c0 <_Z8sem_waitP5sem_s>
    800065bc:	0014849b          	addiw	s1,s1,1
    800065c0:	fe5ff06f          	j	800065a4 <_Z29producerConsumer_CPP_Sync_APIv+0x31c>
    for (int i = 0; i < threadNum; i++) {
    800065c4:	00000493          	li	s1,0
    800065c8:	0080006f          	j	800065d0 <_Z29producerConsumer_CPP_Sync_APIv+0x348>
    800065cc:	0014849b          	addiw	s1,s1,1
    800065d0:	0324d263          	bge	s1,s2,800065f4 <_Z29producerConsumer_CPP_Sync_APIv+0x36c>
        delete threads[i];
    800065d4:	00349793          	slli	a5,s1,0x3
    800065d8:	00f987b3          	add	a5,s3,a5
    800065dc:	0007b503          	ld	a0,0(a5)
    800065e0:	fe0506e3          	beqz	a0,800065cc <_Z29producerConsumer_CPP_Sync_APIv+0x344>
    800065e4:	00053783          	ld	a5,0(a0)
    800065e8:	0087b783          	ld	a5,8(a5)
    800065ec:	000780e7          	jalr	a5
    800065f0:	fddff06f          	j	800065cc <_Z29producerConsumer_CPP_Sync_APIv+0x344>
    delete consumerThread;
    800065f4:	000b0a63          	beqz	s6,80006608 <_Z29producerConsumer_CPP_Sync_APIv+0x380>
    800065f8:	000b3783          	ld	a5,0(s6)
    800065fc:	0087b783          	ld	a5,8(a5)
    80006600:	000b0513          	mv	a0,s6
    80006604:	000780e7          	jalr	a5
    delete waitForAll;
    80006608:	0000a517          	auipc	a0,0xa
    8000660c:	d1853503          	ld	a0,-744(a0) # 80010320 <_ZL10waitForAll>
    80006610:	00050863          	beqz	a0,80006620 <_Z29producerConsumer_CPP_Sync_APIv+0x398>
    80006614:	00053783          	ld	a5,0(a0)
    80006618:	0087b783          	ld	a5,8(a5)
    8000661c:	000780e7          	jalr	a5
    delete buffer;
    80006620:	000a8e63          	beqz	s5,8000663c <_Z29producerConsumer_CPP_Sync_APIv+0x3b4>
    80006624:	000a8513          	mv	a0,s5
    80006628:	00000097          	auipc	ra,0x0
    8000662c:	530080e7          	jalr	1328(ra) # 80006b58 <_ZN9BufferCPPD1Ev>
    80006630:	000a8513          	mv	a0,s5
    80006634:	ffffc097          	auipc	ra,0xffffc
    80006638:	5c4080e7          	jalr	1476(ra) # 80002bf8 <_ZdlPv>
    8000663c:	000b8113          	mv	sp,s7

}
    80006640:	f9040113          	addi	sp,s0,-112
    80006644:	06813083          	ld	ra,104(sp)
    80006648:	06013403          	ld	s0,96(sp)
    8000664c:	05813483          	ld	s1,88(sp)
    80006650:	05013903          	ld	s2,80(sp)
    80006654:	04813983          	ld	s3,72(sp)
    80006658:	04013a03          	ld	s4,64(sp)
    8000665c:	03813a83          	ld	s5,56(sp)
    80006660:	03013b03          	ld	s6,48(sp)
    80006664:	02813b83          	ld	s7,40(sp)
    80006668:	02013c03          	ld	s8,32(sp)
    8000666c:	07010113          	addi	sp,sp,112
    80006670:	00008067          	ret
    80006674:	00050493          	mv	s1,a0
    BufferCPP *buffer = new BufferCPP(n);
    80006678:	000a8513          	mv	a0,s5
    8000667c:	ffffc097          	auipc	ra,0xffffc
    80006680:	57c080e7          	jalr	1404(ra) # 80002bf8 <_ZdlPv>
    80006684:	00048513          	mv	a0,s1
    80006688:	0000b097          	auipc	ra,0xb
    8000668c:	d70080e7          	jalr	-656(ra) # 800113f8 <_Unwind_Resume>
    80006690:	00050913          	mv	s2,a0
    waitForAll = new Semaphore(0);
    80006694:	00048513          	mv	a0,s1
    80006698:	ffffc097          	auipc	ra,0xffffc
    8000669c:	560080e7          	jalr	1376(ra) # 80002bf8 <_ZdlPv>
    800066a0:	00090513          	mv	a0,s2
    800066a4:	0000b097          	auipc	ra,0xb
    800066a8:	d54080e7          	jalr	-684(ra) # 800113f8 <_Unwind_Resume>

00000000800066ac <_ZN12ConsumerSyncD1Ev>:
class ConsumerSync:public Thread {
    800066ac:	ff010113          	addi	sp,sp,-16
    800066b0:	00813423          	sd	s0,8(sp)
    800066b4:	01010413          	addi	s0,sp,16
    800066b8:	00813403          	ld	s0,8(sp)
    800066bc:	01010113          	addi	sp,sp,16
    800066c0:	00008067          	ret

00000000800066c4 <_ZN12ProducerSyncD1Ev>:
class ProducerSync:public Thread {
    800066c4:	ff010113          	addi	sp,sp,-16
    800066c8:	00813423          	sd	s0,8(sp)
    800066cc:	01010413          	addi	s0,sp,16
    800066d0:	00813403          	ld	s0,8(sp)
    800066d4:	01010113          	addi	sp,sp,16
    800066d8:	00008067          	ret

00000000800066dc <_ZN16ProducerKeyboardD1Ev>:
class ProducerKeyboard:public Thread {
    800066dc:	ff010113          	addi	sp,sp,-16
    800066e0:	00813423          	sd	s0,8(sp)
    800066e4:	01010413          	addi	s0,sp,16
    800066e8:	00813403          	ld	s0,8(sp)
    800066ec:	01010113          	addi	sp,sp,16
    800066f0:	00008067          	ret

00000000800066f4 <_ZN12ConsumerSyncD0Ev>:
class ConsumerSync:public Thread {
    800066f4:	ff010113          	addi	sp,sp,-16
    800066f8:	00113423          	sd	ra,8(sp)
    800066fc:	00813023          	sd	s0,0(sp)
    80006700:	01010413          	addi	s0,sp,16
    80006704:	ffffc097          	auipc	ra,0xffffc
    80006708:	4f4080e7          	jalr	1268(ra) # 80002bf8 <_ZdlPv>
    8000670c:	00813083          	ld	ra,8(sp)
    80006710:	00013403          	ld	s0,0(sp)
    80006714:	01010113          	addi	sp,sp,16
    80006718:	00008067          	ret

000000008000671c <_ZN12ProducerSyncD0Ev>:
class ProducerSync:public Thread {
    8000671c:	ff010113          	addi	sp,sp,-16
    80006720:	00113423          	sd	ra,8(sp)
    80006724:	00813023          	sd	s0,0(sp)
    80006728:	01010413          	addi	s0,sp,16
    8000672c:	ffffc097          	auipc	ra,0xffffc
    80006730:	4cc080e7          	jalr	1228(ra) # 80002bf8 <_ZdlPv>
    80006734:	00813083          	ld	ra,8(sp)
    80006738:	00013403          	ld	s0,0(sp)
    8000673c:	01010113          	addi	sp,sp,16
    80006740:	00008067          	ret

0000000080006744 <_ZN16ProducerKeyboardD0Ev>:
class ProducerKeyboard:public Thread {
    80006744:	ff010113          	addi	sp,sp,-16
    80006748:	00113423          	sd	ra,8(sp)
    8000674c:	00813023          	sd	s0,0(sp)
    80006750:	01010413          	addi	s0,sp,16
    80006754:	ffffc097          	auipc	ra,0xffffc
    80006758:	4a4080e7          	jalr	1188(ra) # 80002bf8 <_ZdlPv>
    8000675c:	00813083          	ld	ra,8(sp)
    80006760:	00013403          	ld	s0,0(sp)
    80006764:	01010113          	addi	sp,sp,16
    80006768:	00008067          	ret

000000008000676c <_ZN16ProducerKeyboard3runEv>:
    void run() override {
    8000676c:	ff010113          	addi	sp,sp,-16
    80006770:	00113423          	sd	ra,8(sp)
    80006774:	00813023          	sd	s0,0(sp)
    80006778:	01010413          	addi	s0,sp,16
        producerKeyboard(td);
    8000677c:	02053583          	ld	a1,32(a0)
    80006780:	00000097          	auipc	ra,0x0
    80006784:	8b4080e7          	jalr	-1868(ra) # 80006034 <_ZN16ProducerKeyboard16producerKeyboardEPv>
    }
    80006788:	00813083          	ld	ra,8(sp)
    8000678c:	00013403          	ld	s0,0(sp)
    80006790:	01010113          	addi	sp,sp,16
    80006794:	00008067          	ret

0000000080006798 <_ZN12ProducerSync3runEv>:
    void run() override {
    80006798:	ff010113          	addi	sp,sp,-16
    8000679c:	00113423          	sd	ra,8(sp)
    800067a0:	00813023          	sd	s0,0(sp)
    800067a4:	01010413          	addi	s0,sp,16
        producer(td);
    800067a8:	02053583          	ld	a1,32(a0)
    800067ac:	00000097          	auipc	ra,0x0
    800067b0:	94c080e7          	jalr	-1716(ra) # 800060f8 <_ZN12ProducerSync8producerEPv>
    }
    800067b4:	00813083          	ld	ra,8(sp)
    800067b8:	00013403          	ld	s0,0(sp)
    800067bc:	01010113          	addi	sp,sp,16
    800067c0:	00008067          	ret

00000000800067c4 <_ZN12ConsumerSync3runEv>:
    void run() override {
    800067c4:	ff010113          	addi	sp,sp,-16
    800067c8:	00113423          	sd	ra,8(sp)
    800067cc:	00813023          	sd	s0,0(sp)
    800067d0:	01010413          	addi	s0,sp,16
        consumer(td);
    800067d4:	02053583          	ld	a1,32(a0)
    800067d8:	00000097          	auipc	ra,0x0
    800067dc:	9b8080e7          	jalr	-1608(ra) # 80006190 <_ZN12ConsumerSync8consumerEPv>
    }
    800067e0:	00813083          	ld	ra,8(sp)
    800067e4:	00013403          	ld	s0,0(sp)
    800067e8:	01010113          	addi	sp,sp,16
    800067ec:	00008067          	ret

00000000800067f0 <_ZN9BufferCPPC1Ei>:
#include "buffer_CPP_API.hpp"

BufferCPP::BufferCPP(int _cap) : cap(_cap + 1), head(0), tail(0) {
    800067f0:	fd010113          	addi	sp,sp,-48
    800067f4:	02113423          	sd	ra,40(sp)
    800067f8:	02813023          	sd	s0,32(sp)
    800067fc:	00913c23          	sd	s1,24(sp)
    80006800:	01213823          	sd	s2,16(sp)
    80006804:	01313423          	sd	s3,8(sp)
    80006808:	03010413          	addi	s0,sp,48
    8000680c:	00050493          	mv	s1,a0
    80006810:	00058993          	mv	s3,a1
    80006814:	0015879b          	addiw	a5,a1,1
    80006818:	0007851b          	sext.w	a0,a5
    8000681c:	00f4a023          	sw	a5,0(s1)
    80006820:	0004a823          	sw	zero,16(s1)
    80006824:	0004aa23          	sw	zero,20(s1)
    buffer = (int *)mem_alloc(sizeof(int) * cap);
    80006828:	00251513          	slli	a0,a0,0x2
    8000682c:	ffffb097          	auipc	ra,0xffffb
    80006830:	a54080e7          	jalr	-1452(ra) # 80001280 <_Z9mem_allocm>
    80006834:	00a4b423          	sd	a0,8(s1)
    itemAvailable = new Semaphore(0);
    80006838:	01000513          	li	a0,16
    8000683c:	ffffc097          	auipc	ra,0xffffc
    80006840:	394080e7          	jalr	916(ra) # 80002bd0 <_Znwm>
    80006844:	00050913          	mv	s2,a0
        Semaphore (unsigned init = 1){
    80006848:	00006797          	auipc	a5,0x6
    8000684c:	1e878793          	addi	a5,a5,488 # 8000ca30 <_ZTV9Semaphore+0x10>
    80006850:	00f53023          	sd	a5,0(a0)
            sem_open(&myHandle,init);
    80006854:	00000593          	li	a1,0
    80006858:	00850513          	addi	a0,a0,8
    8000685c:	ffffb097          	auipc	ra,0xffffb
    80006860:	be0080e7          	jalr	-1056(ra) # 8000143c <_Z8sem_openPP5sem_sj>
    80006864:	0324b023          	sd	s2,32(s1)
    spaceAvailable = new Semaphore(_cap);
    80006868:	01000513          	li	a0,16
    8000686c:	ffffc097          	auipc	ra,0xffffc
    80006870:	364080e7          	jalr	868(ra) # 80002bd0 <_Znwm>
    80006874:	00050913          	mv	s2,a0
        Semaphore (unsigned init = 1){
    80006878:	00006797          	auipc	a5,0x6
    8000687c:	1b878793          	addi	a5,a5,440 # 8000ca30 <_ZTV9Semaphore+0x10>
    80006880:	00f53023          	sd	a5,0(a0)
            sem_open(&myHandle,init);
    80006884:	00098593          	mv	a1,s3
    80006888:	00850513          	addi	a0,a0,8
    8000688c:	ffffb097          	auipc	ra,0xffffb
    80006890:	bb0080e7          	jalr	-1104(ra) # 8000143c <_Z8sem_openPP5sem_sj>
    80006894:	0124bc23          	sd	s2,24(s1)
    mutexHead = new Semaphore(1);
    80006898:	01000513          	li	a0,16
    8000689c:	ffffc097          	auipc	ra,0xffffc
    800068a0:	334080e7          	jalr	820(ra) # 80002bd0 <_Znwm>
    800068a4:	00050913          	mv	s2,a0
        Semaphore (unsigned init = 1){
    800068a8:	00006797          	auipc	a5,0x6
    800068ac:	18878793          	addi	a5,a5,392 # 8000ca30 <_ZTV9Semaphore+0x10>
    800068b0:	00f53023          	sd	a5,0(a0)
            sem_open(&myHandle,init);
    800068b4:	00100593          	li	a1,1
    800068b8:	00850513          	addi	a0,a0,8
    800068bc:	ffffb097          	auipc	ra,0xffffb
    800068c0:	b80080e7          	jalr	-1152(ra) # 8000143c <_Z8sem_openPP5sem_sj>
    800068c4:	0324b423          	sd	s2,40(s1)
    mutexTail = new Semaphore(1);
    800068c8:	01000513          	li	a0,16
    800068cc:	ffffc097          	auipc	ra,0xffffc
    800068d0:	304080e7          	jalr	772(ra) # 80002bd0 <_Znwm>
    800068d4:	00050913          	mv	s2,a0
        Semaphore (unsigned init = 1){
    800068d8:	00006797          	auipc	a5,0x6
    800068dc:	15878793          	addi	a5,a5,344 # 8000ca30 <_ZTV9Semaphore+0x10>
    800068e0:	00f53023          	sd	a5,0(a0)
            sem_open(&myHandle,init);
    800068e4:	00100593          	li	a1,1
    800068e8:	00850513          	addi	a0,a0,8
    800068ec:	ffffb097          	auipc	ra,0xffffb
    800068f0:	b50080e7          	jalr	-1200(ra) # 8000143c <_Z8sem_openPP5sem_sj>
    800068f4:	0324b823          	sd	s2,48(s1)
}
    800068f8:	02813083          	ld	ra,40(sp)
    800068fc:	02013403          	ld	s0,32(sp)
    80006900:	01813483          	ld	s1,24(sp)
    80006904:	01013903          	ld	s2,16(sp)
    80006908:	00813983          	ld	s3,8(sp)
    8000690c:	03010113          	addi	sp,sp,48
    80006910:	00008067          	ret
    80006914:	00050493          	mv	s1,a0
    itemAvailable = new Semaphore(0);
    80006918:	00090513          	mv	a0,s2
    8000691c:	ffffc097          	auipc	ra,0xffffc
    80006920:	2dc080e7          	jalr	732(ra) # 80002bf8 <_ZdlPv>
    80006924:	00048513          	mv	a0,s1
    80006928:	0000b097          	auipc	ra,0xb
    8000692c:	ad0080e7          	jalr	-1328(ra) # 800113f8 <_Unwind_Resume>
    80006930:	00050493          	mv	s1,a0
    spaceAvailable = new Semaphore(_cap);
    80006934:	00090513          	mv	a0,s2
    80006938:	ffffc097          	auipc	ra,0xffffc
    8000693c:	2c0080e7          	jalr	704(ra) # 80002bf8 <_ZdlPv>
    80006940:	00048513          	mv	a0,s1
    80006944:	0000b097          	auipc	ra,0xb
    80006948:	ab4080e7          	jalr	-1356(ra) # 800113f8 <_Unwind_Resume>
    8000694c:	00050493          	mv	s1,a0
    mutexHead = new Semaphore(1);
    80006950:	00090513          	mv	a0,s2
    80006954:	ffffc097          	auipc	ra,0xffffc
    80006958:	2a4080e7          	jalr	676(ra) # 80002bf8 <_ZdlPv>
    8000695c:	00048513          	mv	a0,s1
    80006960:	0000b097          	auipc	ra,0xb
    80006964:	a98080e7          	jalr	-1384(ra) # 800113f8 <_Unwind_Resume>
    80006968:	00050493          	mv	s1,a0
    mutexTail = new Semaphore(1);
    8000696c:	00090513          	mv	a0,s2
    80006970:	ffffc097          	auipc	ra,0xffffc
    80006974:	288080e7          	jalr	648(ra) # 80002bf8 <_ZdlPv>
    80006978:	00048513          	mv	a0,s1
    8000697c:	0000b097          	auipc	ra,0xb
    80006980:	a7c080e7          	jalr	-1412(ra) # 800113f8 <_Unwind_Resume>

0000000080006984 <_ZN9BufferCPP3putEi>:
    delete mutexTail;
    delete mutexHead;

}

void BufferCPP::put(int val) {
    80006984:	fe010113          	addi	sp,sp,-32
    80006988:	00113c23          	sd	ra,24(sp)
    8000698c:	00813823          	sd	s0,16(sp)
    80006990:	00913423          	sd	s1,8(sp)
    80006994:	01213023          	sd	s2,0(sp)
    80006998:	02010413          	addi	s0,sp,32
    8000699c:	00050493          	mv	s1,a0
    800069a0:	00058913          	mv	s2,a1
    spaceAvailable->wait();
    800069a4:	01853783          	ld	a5,24(a0)
            return sem_wait(myHandle);
    800069a8:	0087b503          	ld	a0,8(a5)
    800069ac:	ffffb097          	auipc	ra,0xffffb
    800069b0:	b14080e7          	jalr	-1260(ra) # 800014c0 <_Z8sem_waitP5sem_s>

    mutexTail->wait();
    800069b4:	0304b783          	ld	a5,48(s1)
    800069b8:	0087b503          	ld	a0,8(a5)
    800069bc:	ffffb097          	auipc	ra,0xffffb
    800069c0:	b04080e7          	jalr	-1276(ra) # 800014c0 <_Z8sem_waitP5sem_s>
    buffer[tail] = val;
    800069c4:	0084b783          	ld	a5,8(s1)
    800069c8:	0144a703          	lw	a4,20(s1)
    800069cc:	00271713          	slli	a4,a4,0x2
    800069d0:	00e787b3          	add	a5,a5,a4
    800069d4:	0127a023          	sw	s2,0(a5)
    tail = (tail + 1) % cap;
    800069d8:	0144a783          	lw	a5,20(s1)
    800069dc:	0017879b          	addiw	a5,a5,1
    800069e0:	0004a703          	lw	a4,0(s1)
    800069e4:	02e7e7bb          	remw	a5,a5,a4
    800069e8:	00f4aa23          	sw	a5,20(s1)
    mutexTail->signal();
    800069ec:	0304b783          	ld	a5,48(s1)
            return sem_signal(myHandle);
    800069f0:	0087b503          	ld	a0,8(a5)
    800069f4:	ffffb097          	auipc	ra,0xffffb
    800069f8:	b0c080e7          	jalr	-1268(ra) # 80001500 <_Z10sem_signalP5sem_s>

    itemAvailable->signal();
    800069fc:	0204b783          	ld	a5,32(s1)
    80006a00:	0087b503          	ld	a0,8(a5)
    80006a04:	ffffb097          	auipc	ra,0xffffb
    80006a08:	afc080e7          	jalr	-1284(ra) # 80001500 <_Z10sem_signalP5sem_s>

}
    80006a0c:	01813083          	ld	ra,24(sp)
    80006a10:	01013403          	ld	s0,16(sp)
    80006a14:	00813483          	ld	s1,8(sp)
    80006a18:	00013903          	ld	s2,0(sp)
    80006a1c:	02010113          	addi	sp,sp,32
    80006a20:	00008067          	ret

0000000080006a24 <_ZN9BufferCPP3getEv>:

int BufferCPP::get() {
    80006a24:	fe010113          	addi	sp,sp,-32
    80006a28:	00113c23          	sd	ra,24(sp)
    80006a2c:	00813823          	sd	s0,16(sp)
    80006a30:	00913423          	sd	s1,8(sp)
    80006a34:	01213023          	sd	s2,0(sp)
    80006a38:	02010413          	addi	s0,sp,32
    80006a3c:	00050493          	mv	s1,a0
    itemAvailable->wait();
    80006a40:	02053783          	ld	a5,32(a0)
            return sem_wait(myHandle);
    80006a44:	0087b503          	ld	a0,8(a5)
    80006a48:	ffffb097          	auipc	ra,0xffffb
    80006a4c:	a78080e7          	jalr	-1416(ra) # 800014c0 <_Z8sem_waitP5sem_s>

    mutexHead->wait();
    80006a50:	0284b783          	ld	a5,40(s1)
    80006a54:	0087b503          	ld	a0,8(a5)
    80006a58:	ffffb097          	auipc	ra,0xffffb
    80006a5c:	a68080e7          	jalr	-1432(ra) # 800014c0 <_Z8sem_waitP5sem_s>

    int ret = buffer[head];
    80006a60:	0084b703          	ld	a4,8(s1)
    80006a64:	0104a783          	lw	a5,16(s1)
    80006a68:	00279693          	slli	a3,a5,0x2
    80006a6c:	00d70733          	add	a4,a4,a3
    80006a70:	00072903          	lw	s2,0(a4)
    head = (head + 1) % cap;
    80006a74:	0017879b          	addiw	a5,a5,1
    80006a78:	0004a703          	lw	a4,0(s1)
    80006a7c:	02e7e7bb          	remw	a5,a5,a4
    80006a80:	00f4a823          	sw	a5,16(s1)
    mutexHead->signal();
    80006a84:	0284b783          	ld	a5,40(s1)
            return sem_signal(myHandle);
    80006a88:	0087b503          	ld	a0,8(a5)
    80006a8c:	ffffb097          	auipc	ra,0xffffb
    80006a90:	a74080e7          	jalr	-1420(ra) # 80001500 <_Z10sem_signalP5sem_s>

    spaceAvailable->signal();
    80006a94:	0184b783          	ld	a5,24(s1)
    80006a98:	0087b503          	ld	a0,8(a5)
    80006a9c:	ffffb097          	auipc	ra,0xffffb
    80006aa0:	a64080e7          	jalr	-1436(ra) # 80001500 <_Z10sem_signalP5sem_s>

    return ret;
}
    80006aa4:	00090513          	mv	a0,s2
    80006aa8:	01813083          	ld	ra,24(sp)
    80006aac:	01013403          	ld	s0,16(sp)
    80006ab0:	00813483          	ld	s1,8(sp)
    80006ab4:	00013903          	ld	s2,0(sp)
    80006ab8:	02010113          	addi	sp,sp,32
    80006abc:	00008067          	ret

0000000080006ac0 <_ZN9BufferCPP6getCntEv>:

int BufferCPP::getCnt() {
    80006ac0:	fe010113          	addi	sp,sp,-32
    80006ac4:	00113c23          	sd	ra,24(sp)
    80006ac8:	00813823          	sd	s0,16(sp)
    80006acc:	00913423          	sd	s1,8(sp)
    80006ad0:	01213023          	sd	s2,0(sp)
    80006ad4:	02010413          	addi	s0,sp,32
    80006ad8:	00050493          	mv	s1,a0
    int ret;

    mutexHead->wait();
    80006adc:	02853783          	ld	a5,40(a0)
            return sem_wait(myHandle);
    80006ae0:	0087b503          	ld	a0,8(a5)
    80006ae4:	ffffb097          	auipc	ra,0xffffb
    80006ae8:	9dc080e7          	jalr	-1572(ra) # 800014c0 <_Z8sem_waitP5sem_s>
    mutexTail->wait();
    80006aec:	0304b783          	ld	a5,48(s1)
    80006af0:	0087b503          	ld	a0,8(a5)
    80006af4:	ffffb097          	auipc	ra,0xffffb
    80006af8:	9cc080e7          	jalr	-1588(ra) # 800014c0 <_Z8sem_waitP5sem_s>

    if (tail >= head) {
    80006afc:	0144a783          	lw	a5,20(s1)
    80006b00:	0104a903          	lw	s2,16(s1)
    80006b04:	0527c263          	blt	a5,s2,80006b48 <_ZN9BufferCPP6getCntEv+0x88>
        ret = tail - head;
    80006b08:	4127893b          	subw	s2,a5,s2
    } else {
        ret = cap - head + tail;
    }

    mutexTail->signal();
    80006b0c:	0304b783          	ld	a5,48(s1)
            return sem_signal(myHandle);
    80006b10:	0087b503          	ld	a0,8(a5)
    80006b14:	ffffb097          	auipc	ra,0xffffb
    80006b18:	9ec080e7          	jalr	-1556(ra) # 80001500 <_Z10sem_signalP5sem_s>
    mutexHead->signal();
    80006b1c:	0284b783          	ld	a5,40(s1)
    80006b20:	0087b503          	ld	a0,8(a5)
    80006b24:	ffffb097          	auipc	ra,0xffffb
    80006b28:	9dc080e7          	jalr	-1572(ra) # 80001500 <_Z10sem_signalP5sem_s>

    return ret;
}
    80006b2c:	00090513          	mv	a0,s2
    80006b30:	01813083          	ld	ra,24(sp)
    80006b34:	01013403          	ld	s0,16(sp)
    80006b38:	00813483          	ld	s1,8(sp)
    80006b3c:	00013903          	ld	s2,0(sp)
    80006b40:	02010113          	addi	sp,sp,32
    80006b44:	00008067          	ret
        ret = cap - head + tail;
    80006b48:	0004a703          	lw	a4,0(s1)
    80006b4c:	4127093b          	subw	s2,a4,s2
    80006b50:	00f9093b          	addw	s2,s2,a5
    80006b54:	fb9ff06f          	j	80006b0c <_ZN9BufferCPP6getCntEv+0x4c>

0000000080006b58 <_ZN9BufferCPPD1Ev>:
BufferCPP::~BufferCPP() {
    80006b58:	fe010113          	addi	sp,sp,-32
    80006b5c:	00113c23          	sd	ra,24(sp)
    80006b60:	00813823          	sd	s0,16(sp)
    80006b64:	00913423          	sd	s1,8(sp)
    80006b68:	02010413          	addi	s0,sp,32
    80006b6c:	00050493          	mv	s1,a0
            ::putc(c);
    80006b70:	00a00513          	li	a0,10
    80006b74:	ffffb097          	auipc	ra,0xffffb
    80006b78:	a3c080e7          	jalr	-1476(ra) # 800015b0 <_Z4putcc>
    printString("Buffer deleted!\n");
    80006b7c:	00004517          	auipc	a0,0x4
    80006b80:	a4c50513          	addi	a0,a0,-1460 # 8000a5c8 <CONSOLE_STATUS+0x5b8>
    80006b84:	ffffb097          	auipc	ra,0xffffb
    80006b88:	37c080e7          	jalr	892(ra) # 80001f00 <_Z11printStringPKc>
    while (getCnt()) {
    80006b8c:	00048513          	mv	a0,s1
    80006b90:	00000097          	auipc	ra,0x0
    80006b94:	f30080e7          	jalr	-208(ra) # 80006ac0 <_ZN9BufferCPP6getCntEv>
    80006b98:	02050c63          	beqz	a0,80006bd0 <_ZN9BufferCPPD1Ev+0x78>
        char ch = buffer[head];
    80006b9c:	0084b783          	ld	a5,8(s1)
    80006ba0:	0104a703          	lw	a4,16(s1)
    80006ba4:	00271713          	slli	a4,a4,0x2
    80006ba8:	00e787b3          	add	a5,a5,a4
    80006bac:	0007c503          	lbu	a0,0(a5)
    80006bb0:	ffffb097          	auipc	ra,0xffffb
    80006bb4:	a00080e7          	jalr	-1536(ra) # 800015b0 <_Z4putcc>
        head = (head + 1) % cap;
    80006bb8:	0104a783          	lw	a5,16(s1)
    80006bbc:	0017879b          	addiw	a5,a5,1
    80006bc0:	0004a703          	lw	a4,0(s1)
    80006bc4:	02e7e7bb          	remw	a5,a5,a4
    80006bc8:	00f4a823          	sw	a5,16(s1)
    while (getCnt()) {
    80006bcc:	fc1ff06f          	j	80006b8c <_ZN9BufferCPPD1Ev+0x34>
    80006bd0:	02100513          	li	a0,33
    80006bd4:	ffffb097          	auipc	ra,0xffffb
    80006bd8:	9dc080e7          	jalr	-1572(ra) # 800015b0 <_Z4putcc>
    80006bdc:	00a00513          	li	a0,10
    80006be0:	ffffb097          	auipc	ra,0xffffb
    80006be4:	9d0080e7          	jalr	-1584(ra) # 800015b0 <_Z4putcc>
    mem_free(buffer);
    80006be8:	0084b503          	ld	a0,8(s1)
    80006bec:	ffffa097          	auipc	ra,0xffffa
    80006bf0:	6d4080e7          	jalr	1748(ra) # 800012c0 <_Z8mem_freePv>
    delete itemAvailable;
    80006bf4:	0204b503          	ld	a0,32(s1)
    80006bf8:	00050863          	beqz	a0,80006c08 <_ZN9BufferCPPD1Ev+0xb0>
    80006bfc:	00053783          	ld	a5,0(a0)
    80006c00:	0087b783          	ld	a5,8(a5)
    80006c04:	000780e7          	jalr	a5
    delete spaceAvailable;
    80006c08:	0184b503          	ld	a0,24(s1)
    80006c0c:	00050863          	beqz	a0,80006c1c <_ZN9BufferCPPD1Ev+0xc4>
    80006c10:	00053783          	ld	a5,0(a0)
    80006c14:	0087b783          	ld	a5,8(a5)
    80006c18:	000780e7          	jalr	a5
    delete mutexTail;
    80006c1c:	0304b503          	ld	a0,48(s1)
    80006c20:	00050863          	beqz	a0,80006c30 <_ZN9BufferCPPD1Ev+0xd8>
    80006c24:	00053783          	ld	a5,0(a0)
    80006c28:	0087b783          	ld	a5,8(a5)
    80006c2c:	000780e7          	jalr	a5
    delete mutexHead;
    80006c30:	0284b503          	ld	a0,40(s1)
    80006c34:	00050863          	beqz	a0,80006c44 <_ZN9BufferCPPD1Ev+0xec>
    80006c38:	00053783          	ld	a5,0(a0)
    80006c3c:	0087b783          	ld	a5,8(a5)
    80006c40:	000780e7          	jalr	a5
}
    80006c44:	01813083          	ld	ra,24(sp)
    80006c48:	01013403          	ld	s0,16(sp)
    80006c4c:	00813483          	ld	s1,8(sp)
    80006c50:	02010113          	addi	sp,sp,32
    80006c54:	00008067          	ret

0000000080006c58 <_Z8userMainv>:
#include "../test/ConsumerProducer_CPP_API_test.hpp"
#include "System_Mode_test.hpp"

#endif

void userMain() {
    80006c58:	fe010113          	addi	sp,sp,-32
    80006c5c:	00113c23          	sd	ra,24(sp)
    80006c60:	00813823          	sd	s0,16(sp)
    80006c64:	00913423          	sd	s1,8(sp)
    80006c68:	02010413          	addi	s0,sp,32
    printString("Unesite broj testa? [1-7]\n");
    80006c6c:	00004517          	auipc	a0,0x4
    80006c70:	97450513          	addi	a0,a0,-1676 # 8000a5e0 <CONSOLE_STATUS+0x5d0>
    80006c74:	ffffb097          	auipc	ra,0xffffb
    80006c78:	28c080e7          	jalr	652(ra) # 80001f00 <_Z11printStringPKc>
    int test = getc() - '0';
    80006c7c:	ffffb097          	auipc	ra,0xffffb
    80006c80:	8f8080e7          	jalr	-1800(ra) # 80001574 <_Z4getcv>
    80006c84:	fd05049b          	addiw	s1,a0,-48
    getc(); // Enter posle broja
    80006c88:	ffffb097          	auipc	ra,0xffffb
    80006c8c:	8ec080e7          	jalr	-1812(ra) # 80001574 <_Z4getcv>
            printString("Nije navedeno da je zadatak 4 implementiran\n");
            return;
        }
    }

    switch (test) {
    80006c90:	00700793          	li	a5,7
    80006c94:	1097e263          	bltu	a5,s1,80006d98 <_Z8userMainv+0x140>
    80006c98:	00249493          	slli	s1,s1,0x2
    80006c9c:	00004717          	auipc	a4,0x4
    80006ca0:	b9c70713          	addi	a4,a4,-1124 # 8000a838 <CONSOLE_STATUS+0x828>
    80006ca4:	00e484b3          	add	s1,s1,a4
    80006ca8:	0004a783          	lw	a5,0(s1)
    80006cac:	00e787b3          	add	a5,a5,a4
    80006cb0:	00078067          	jr	a5
        case 1:
#if LEVEL_2_IMPLEMENTED == 1
            Threads_C_API_test();
    80006cb4:	fffff097          	auipc	ra,0xfffff
    80006cb8:	284080e7          	jalr	644(ra) # 80005f38 <_Z18Threads_C_API_testv>
            printString("TEST 1 (zadatak 2, niti C API i sinhrona promena konteksta)\n");
    80006cbc:	00004517          	auipc	a0,0x4
    80006cc0:	94450513          	addi	a0,a0,-1724 # 8000a600 <CONSOLE_STATUS+0x5f0>
    80006cc4:	ffffb097          	auipc	ra,0xffffb
    80006cc8:	23c080e7          	jalr	572(ra) # 80001f00 <_Z11printStringPKc>
#endif
            break;
        default:
            printString("Niste uneli odgovarajuci broj za test\n");
    }
    80006ccc:	01813083          	ld	ra,24(sp)
    80006cd0:	01013403          	ld	s0,16(sp)
    80006cd4:	00813483          	ld	s1,8(sp)
    80006cd8:	02010113          	addi	sp,sp,32
    80006cdc:	00008067          	ret
            Threads_CPP_API_test();
    80006ce0:	ffffe097          	auipc	ra,0xffffe
    80006ce4:	2b8080e7          	jalr	696(ra) # 80004f98 <_Z20Threads_CPP_API_testv>
            printString("TEST 2 (zadatak 2., niti CPP API i sinhrona promena konteksta)\n");
    80006ce8:	00004517          	auipc	a0,0x4
    80006cec:	95850513          	addi	a0,a0,-1704 # 8000a640 <CONSOLE_STATUS+0x630>
    80006cf0:	ffffb097          	auipc	ra,0xffffb
    80006cf4:	210080e7          	jalr	528(ra) # 80001f00 <_Z11printStringPKc>
            break;
    80006cf8:	fd5ff06f          	j	80006ccc <_Z8userMainv+0x74>
            producerConsumer_C_API();
    80006cfc:	ffffe097          	auipc	ra,0xffffe
    80006d00:	af0080e7          	jalr	-1296(ra) # 800047ec <_Z22producerConsumer_C_APIv>
            printString("TEST 3 (zadatak 3., kompletan C API sa semaforima, sinhrona promena konteksta)\n");
    80006d04:	00004517          	auipc	a0,0x4
    80006d08:	97c50513          	addi	a0,a0,-1668 # 8000a680 <CONSOLE_STATUS+0x670>
    80006d0c:	ffffb097          	auipc	ra,0xffffb
    80006d10:	1f4080e7          	jalr	500(ra) # 80001f00 <_Z11printStringPKc>
            break;
    80006d14:	fb9ff06f          	j	80006ccc <_Z8userMainv+0x74>
            producerConsumer_CPP_Sync_API();
    80006d18:	fffff097          	auipc	ra,0xfffff
    80006d1c:	570080e7          	jalr	1392(ra) # 80006288 <_Z29producerConsumer_CPP_Sync_APIv>
            printString("TEST 4 (zadatak 3., kompletan CPP API sa semaforima, sinhrona promena konteksta)\n");
    80006d20:	00004517          	auipc	a0,0x4
    80006d24:	9b050513          	addi	a0,a0,-1616 # 8000a6d0 <CONSOLE_STATUS+0x6c0>
    80006d28:	ffffb097          	auipc	ra,0xffffb
    80006d2c:	1d8080e7          	jalr	472(ra) # 80001f00 <_Z11printStringPKc>
            break;
    80006d30:	f9dff06f          	j	80006ccc <_Z8userMainv+0x74>
            testSleeping();
    80006d34:	00000097          	auipc	ra,0x0
    80006d38:	11c080e7          	jalr	284(ra) # 80006e50 <_Z12testSleepingv>
            printString("TEST 5 (zadatak 4., thread_sleep test C API)\n");
    80006d3c:	00004517          	auipc	a0,0x4
    80006d40:	9ec50513          	addi	a0,a0,-1556 # 8000a728 <CONSOLE_STATUS+0x718>
    80006d44:	ffffb097          	auipc	ra,0xffffb
    80006d48:	1bc080e7          	jalr	444(ra) # 80001f00 <_Z11printStringPKc>
            break;
    80006d4c:	f81ff06f          	j	80006ccc <_Z8userMainv+0x74>
            testConsumerProducer();
    80006d50:	ffffe097          	auipc	ra,0xffffe
    80006d54:	5ac080e7          	jalr	1452(ra) # 800052fc <_Z20testConsumerProducerv>
            printString("TEST 6 (zadatak 4. CPP API i asinhrona promena konteksta)\n");
    80006d58:	00004517          	auipc	a0,0x4
    80006d5c:	a0050513          	addi	a0,a0,-1536 # 8000a758 <CONSOLE_STATUS+0x748>
    80006d60:	ffffb097          	auipc	ra,0xffffb
    80006d64:	1a0080e7          	jalr	416(ra) # 80001f00 <_Z11printStringPKc>
            break;
    80006d68:	f65ff06f          	j	80006ccc <_Z8userMainv+0x74>
            System_Mode_test();
    80006d6c:	00000097          	auipc	ra,0x0
    80006d70:	658080e7          	jalr	1624(ra) # 800073c4 <_Z16System_Mode_testv>
            printString("Test se nije uspesno zavrsio\n");
    80006d74:	00004517          	auipc	a0,0x4
    80006d78:	a2450513          	addi	a0,a0,-1500 # 8000a798 <CONSOLE_STATUS+0x788>
    80006d7c:	ffffb097          	auipc	ra,0xffffb
    80006d80:	184080e7          	jalr	388(ra) # 80001f00 <_Z11printStringPKc>
            printString("TEST 7 (zadatak 2., testiranje da li se korisnicki kod izvrsava u korisnickom rezimu)\n");
    80006d84:	00004517          	auipc	a0,0x4
    80006d88:	a3450513          	addi	a0,a0,-1484 # 8000a7b8 <CONSOLE_STATUS+0x7a8>
    80006d8c:	ffffb097          	auipc	ra,0xffffb
    80006d90:	174080e7          	jalr	372(ra) # 80001f00 <_Z11printStringPKc>
            break;
    80006d94:	f39ff06f          	j	80006ccc <_Z8userMainv+0x74>
            printString("Niste uneli odgovarajuci broj za test\n");
    80006d98:	00004517          	auipc	a0,0x4
    80006d9c:	a7850513          	addi	a0,a0,-1416 # 8000a810 <CONSOLE_STATUS+0x800>
    80006da0:	ffffb097          	auipc	ra,0xffffb
    80006da4:	160080e7          	jalr	352(ra) # 80001f00 <_Z11printStringPKc>
    80006da8:	f25ff06f          	j	80006ccc <_Z8userMainv+0x74>

0000000080006dac <_ZL9sleepyRunPv>:

#include "../h/printing.hpp"

static volatile bool finished[2];

static void sleepyRun(void *arg) {
    80006dac:	fe010113          	addi	sp,sp,-32
    80006db0:	00113c23          	sd	ra,24(sp)
    80006db4:	00813823          	sd	s0,16(sp)
    80006db8:	00913423          	sd	s1,8(sp)
    80006dbc:	01213023          	sd	s2,0(sp)
    80006dc0:	02010413          	addi	s0,sp,32
    uint64 sleep_time = *((uint64 *) arg);
    80006dc4:	00053903          	ld	s2,0(a0)
    int i = 6;
    80006dc8:	00600493          	li	s1,6
    while (--i > 0) {
    80006dcc:	fff4849b          	addiw	s1,s1,-1
    80006dd0:	04905463          	blez	s1,80006e18 <_ZL9sleepyRunPv+0x6c>

        printString("Hello ");
    80006dd4:	00004517          	auipc	a0,0x4
    80006dd8:	a8450513          	addi	a0,a0,-1404 # 8000a858 <CONSOLE_STATUS+0x848>
    80006ddc:	ffffb097          	auipc	ra,0xffffb
    80006de0:	124080e7          	jalr	292(ra) # 80001f00 <_Z11printStringPKc>
        printInt(sleep_time);
    80006de4:	00000613          	li	a2,0
    80006de8:	00a00593          	li	a1,10
    80006dec:	0009051b          	sext.w	a0,s2
    80006df0:	ffffb097          	auipc	ra,0xffffb
    80006df4:	2c0080e7          	jalr	704(ra) # 800020b0 <_Z8printIntiii>
        printString(" !\n");
    80006df8:	00004517          	auipc	a0,0x4
    80006dfc:	a6850513          	addi	a0,a0,-1432 # 8000a860 <CONSOLE_STATUS+0x850>
    80006e00:	ffffb097          	auipc	ra,0xffffb
    80006e04:	100080e7          	jalr	256(ra) # 80001f00 <_Z11printStringPKc>
        time_sleep(sleep_time);
    80006e08:	00090513          	mv	a0,s2
    80006e0c:	ffffa097          	auipc	ra,0xffffa
    80006e10:	734080e7          	jalr	1844(ra) # 80001540 <_Z10time_sleepm>
    while (--i > 0) {
    80006e14:	fb9ff06f          	j	80006dcc <_ZL9sleepyRunPv+0x20>
    }
    finished[sleep_time/10-1] = true;
    80006e18:	00a00793          	li	a5,10
    80006e1c:	02f95933          	divu	s2,s2,a5
    80006e20:	fff90913          	addi	s2,s2,-1
    80006e24:	00009797          	auipc	a5,0x9
    80006e28:	50478793          	addi	a5,a5,1284 # 80010328 <_ZL8finished>
    80006e2c:	01278933          	add	s2,a5,s2
    80006e30:	00100793          	li	a5,1
    80006e34:	00f90023          	sb	a5,0(s2)
}
    80006e38:	01813083          	ld	ra,24(sp)
    80006e3c:	01013403          	ld	s0,16(sp)
    80006e40:	00813483          	ld	s1,8(sp)
    80006e44:	00013903          	ld	s2,0(sp)
    80006e48:	02010113          	addi	sp,sp,32
    80006e4c:	00008067          	ret

0000000080006e50 <_Z12testSleepingv>:

void testSleeping() {
    80006e50:	fc010113          	addi	sp,sp,-64
    80006e54:	02113c23          	sd	ra,56(sp)
    80006e58:	02813823          	sd	s0,48(sp)
    80006e5c:	02913423          	sd	s1,40(sp)
    80006e60:	04010413          	addi	s0,sp,64
    const int sleepy_thread_count = 2;
    uint64 sleep_times[sleepy_thread_count] = {10, 20};
    80006e64:	00a00793          	li	a5,10
    80006e68:	fcf43823          	sd	a5,-48(s0)
    80006e6c:	01400793          	li	a5,20
    80006e70:	fcf43c23          	sd	a5,-40(s0)
    thread_t sleepyThread[sleepy_thread_count];

    for (int i = 0; i < sleepy_thread_count; i++) {
    80006e74:	00000493          	li	s1,0
    80006e78:	02c0006f          	j	80006ea4 <_Z12testSleepingv+0x54>
        thread_create(&sleepyThread[i], sleepyRun, sleep_times + i);
    80006e7c:	00349793          	slli	a5,s1,0x3
    80006e80:	fd040613          	addi	a2,s0,-48
    80006e84:	00f60633          	add	a2,a2,a5
    80006e88:	00000597          	auipc	a1,0x0
    80006e8c:	f2458593          	addi	a1,a1,-220 # 80006dac <_ZL9sleepyRunPv>
    80006e90:	fc040513          	addi	a0,s0,-64
    80006e94:	00f50533          	add	a0,a0,a5
    80006e98:	ffffa097          	auipc	ra,0xffffa
    80006e9c:	468080e7          	jalr	1128(ra) # 80001300 <_Z13thread_createPP8thread_sPFvPvES2_>
    for (int i = 0; i < sleepy_thread_count; i++) {
    80006ea0:	0014849b          	addiw	s1,s1,1
    80006ea4:	00100793          	li	a5,1
    80006ea8:	fc97dae3          	bge	a5,s1,80006e7c <_Z12testSleepingv+0x2c>
    }

    while (!(finished[0] && finished[1])) {}
    80006eac:	00009797          	auipc	a5,0x9
    80006eb0:	47c7c783          	lbu	a5,1148(a5) # 80010328 <_ZL8finished>
    80006eb4:	fe078ce3          	beqz	a5,80006eac <_Z12testSleepingv+0x5c>
    80006eb8:	00009797          	auipc	a5,0x9
    80006ebc:	4717c783          	lbu	a5,1137(a5) # 80010329 <_ZL8finished+0x1>
    80006ec0:	fe0786e3          	beqz	a5,80006eac <_Z12testSleepingv+0x5c>
}
    80006ec4:	03813083          	ld	ra,56(sp)
    80006ec8:	03013403          	ld	s0,48(sp)
    80006ecc:	02813483          	ld	s1,40(sp)
    80006ed0:	04010113          	addi	sp,sp,64
    80006ed4:	00008067          	ret

0000000080006ed8 <_ZL9fibonaccim>:
static volatile bool finishedA = false;
static volatile bool finishedB = false;
static volatile bool finishedC = false;
static volatile bool finishedD = false;

static uint64 fibonacci(uint64 n) {
    80006ed8:	fe010113          	addi	sp,sp,-32
    80006edc:	00113c23          	sd	ra,24(sp)
    80006ee0:	00813823          	sd	s0,16(sp)
    80006ee4:	00913423          	sd	s1,8(sp)
    80006ee8:	01213023          	sd	s2,0(sp)
    80006eec:	02010413          	addi	s0,sp,32
    80006ef0:	00050493          	mv	s1,a0
    if (n == 0 || n == 1) { return n; }
    80006ef4:	00100793          	li	a5,1
    80006ef8:	02a7f863          	bgeu	a5,a0,80006f28 <_ZL9fibonaccim+0x50>
    if (n % 10 == 0) { thread_dispatch(); }
    80006efc:	00a00793          	li	a5,10
    80006f00:	02f577b3          	remu	a5,a0,a5
    80006f04:	02078e63          	beqz	a5,80006f40 <_ZL9fibonaccim+0x68>
    return fibonacci(n - 1) + fibonacci(n - 2);
    80006f08:	fff48513          	addi	a0,s1,-1
    80006f0c:	00000097          	auipc	ra,0x0
    80006f10:	fcc080e7          	jalr	-52(ra) # 80006ed8 <_ZL9fibonaccim>
    80006f14:	00050913          	mv	s2,a0
    80006f18:	ffe48513          	addi	a0,s1,-2
    80006f1c:	00000097          	auipc	ra,0x0
    80006f20:	fbc080e7          	jalr	-68(ra) # 80006ed8 <_ZL9fibonaccim>
    80006f24:	00a90533          	add	a0,s2,a0
}
    80006f28:	01813083          	ld	ra,24(sp)
    80006f2c:	01013403          	ld	s0,16(sp)
    80006f30:	00813483          	ld	s1,8(sp)
    80006f34:	00013903          	ld	s2,0(sp)
    80006f38:	02010113          	addi	sp,sp,32
    80006f3c:	00008067          	ret
    if (n % 10 == 0) { thread_dispatch(); }
    80006f40:	ffffa097          	auipc	ra,0xffffa
    80006f44:	448080e7          	jalr	1096(ra) # 80001388 <_Z15thread_dispatchv>
    80006f48:	fc1ff06f          	j	80006f08 <_ZL9fibonaccim+0x30>

0000000080006f4c <_ZL11workerBodyDPv>:
    printString("A finished!\n");
    finishedC = true;
    thread_dispatch();
}

static void workerBodyD(void* arg) {
    80006f4c:	fe010113          	addi	sp,sp,-32
    80006f50:	00113c23          	sd	ra,24(sp)
    80006f54:	00813823          	sd	s0,16(sp)
    80006f58:	00913423          	sd	s1,8(sp)
    80006f5c:	01213023          	sd	s2,0(sp)
    80006f60:	02010413          	addi	s0,sp,32
    uint8 i = 10;
    80006f64:	00a00493          	li	s1,10
    80006f68:	0400006f          	j	80006fa8 <_ZL11workerBodyDPv+0x5c>
    for (; i < 13; i++) {
        printString("D: i="); printInt(i); printString("\n");
    80006f6c:	00003517          	auipc	a0,0x3
    80006f70:	5c450513          	addi	a0,a0,1476 # 8000a530 <CONSOLE_STATUS+0x520>
    80006f74:	ffffb097          	auipc	ra,0xffffb
    80006f78:	f8c080e7          	jalr	-116(ra) # 80001f00 <_Z11printStringPKc>
    80006f7c:	00000613          	li	a2,0
    80006f80:	00a00593          	li	a1,10
    80006f84:	00048513          	mv	a0,s1
    80006f88:	ffffb097          	auipc	ra,0xffffb
    80006f8c:	128080e7          	jalr	296(ra) # 800020b0 <_Z8printIntiii>
    80006f90:	00003517          	auipc	a0,0x3
    80006f94:	79050513          	addi	a0,a0,1936 # 8000a720 <CONSOLE_STATUS+0x710>
    80006f98:	ffffb097          	auipc	ra,0xffffb
    80006f9c:	f68080e7          	jalr	-152(ra) # 80001f00 <_Z11printStringPKc>
    for (; i < 13; i++) {
    80006fa0:	0014849b          	addiw	s1,s1,1
    80006fa4:	0ff4f493          	andi	s1,s1,255
    80006fa8:	00c00793          	li	a5,12
    80006fac:	fc97f0e3          	bgeu	a5,s1,80006f6c <_ZL11workerBodyDPv+0x20>
    }

    printString("D: dispatch\n");
    80006fb0:	00003517          	auipc	a0,0x3
    80006fb4:	58850513          	addi	a0,a0,1416 # 8000a538 <CONSOLE_STATUS+0x528>
    80006fb8:	ffffb097          	auipc	ra,0xffffb
    80006fbc:	f48080e7          	jalr	-184(ra) # 80001f00 <_Z11printStringPKc>
    __asm__ ("li t1, 5");
    80006fc0:	00500313          	li	t1,5
    thread_dispatch();
    80006fc4:	ffffa097          	auipc	ra,0xffffa
    80006fc8:	3c4080e7          	jalr	964(ra) # 80001388 <_Z15thread_dispatchv>

    uint64 result = fibonacci(16);
    80006fcc:	01000513          	li	a0,16
    80006fd0:	00000097          	auipc	ra,0x0
    80006fd4:	f08080e7          	jalr	-248(ra) # 80006ed8 <_ZL9fibonaccim>
    80006fd8:	00050913          	mv	s2,a0
    printString("D: fibonaci="); printInt(result); printString("\n");
    80006fdc:	00003517          	auipc	a0,0x3
    80006fe0:	56c50513          	addi	a0,a0,1388 # 8000a548 <CONSOLE_STATUS+0x538>
    80006fe4:	ffffb097          	auipc	ra,0xffffb
    80006fe8:	f1c080e7          	jalr	-228(ra) # 80001f00 <_Z11printStringPKc>
    80006fec:	00000613          	li	a2,0
    80006ff0:	00a00593          	li	a1,10
    80006ff4:	0009051b          	sext.w	a0,s2
    80006ff8:	ffffb097          	auipc	ra,0xffffb
    80006ffc:	0b8080e7          	jalr	184(ra) # 800020b0 <_Z8printIntiii>
    80007000:	00003517          	auipc	a0,0x3
    80007004:	72050513          	addi	a0,a0,1824 # 8000a720 <CONSOLE_STATUS+0x710>
    80007008:	ffffb097          	auipc	ra,0xffffb
    8000700c:	ef8080e7          	jalr	-264(ra) # 80001f00 <_Z11printStringPKc>
    80007010:	0400006f          	j	80007050 <_ZL11workerBodyDPv+0x104>

    for (; i < 16; i++) {
        printString("D: i="); printInt(i); printString("\n");
    80007014:	00003517          	auipc	a0,0x3
    80007018:	51c50513          	addi	a0,a0,1308 # 8000a530 <CONSOLE_STATUS+0x520>
    8000701c:	ffffb097          	auipc	ra,0xffffb
    80007020:	ee4080e7          	jalr	-284(ra) # 80001f00 <_Z11printStringPKc>
    80007024:	00000613          	li	a2,0
    80007028:	00a00593          	li	a1,10
    8000702c:	00048513          	mv	a0,s1
    80007030:	ffffb097          	auipc	ra,0xffffb
    80007034:	080080e7          	jalr	128(ra) # 800020b0 <_Z8printIntiii>
    80007038:	00003517          	auipc	a0,0x3
    8000703c:	6e850513          	addi	a0,a0,1768 # 8000a720 <CONSOLE_STATUS+0x710>
    80007040:	ffffb097          	auipc	ra,0xffffb
    80007044:	ec0080e7          	jalr	-320(ra) # 80001f00 <_Z11printStringPKc>
    for (; i < 16; i++) {
    80007048:	0014849b          	addiw	s1,s1,1
    8000704c:	0ff4f493          	andi	s1,s1,255
    80007050:	00f00793          	li	a5,15
    80007054:	fc97f0e3          	bgeu	a5,s1,80007014 <_ZL11workerBodyDPv+0xc8>
    }

    printString("D finished!\n");
    80007058:	00003517          	auipc	a0,0x3
    8000705c:	50050513          	addi	a0,a0,1280 # 8000a558 <CONSOLE_STATUS+0x548>
    80007060:	ffffb097          	auipc	ra,0xffffb
    80007064:	ea0080e7          	jalr	-352(ra) # 80001f00 <_Z11printStringPKc>
    finishedD = true;
    80007068:	00100793          	li	a5,1
    8000706c:	00009717          	auipc	a4,0x9
    80007070:	2af70f23          	sb	a5,702(a4) # 8001032a <_ZL9finishedD>
    thread_dispatch();
    80007074:	ffffa097          	auipc	ra,0xffffa
    80007078:	314080e7          	jalr	788(ra) # 80001388 <_Z15thread_dispatchv>
}
    8000707c:	01813083          	ld	ra,24(sp)
    80007080:	01013403          	ld	s0,16(sp)
    80007084:	00813483          	ld	s1,8(sp)
    80007088:	00013903          	ld	s2,0(sp)
    8000708c:	02010113          	addi	sp,sp,32
    80007090:	00008067          	ret

0000000080007094 <_ZL11workerBodyCPv>:
static void workerBodyC(void* arg) {
    80007094:	fe010113          	addi	sp,sp,-32
    80007098:	00113c23          	sd	ra,24(sp)
    8000709c:	00813823          	sd	s0,16(sp)
    800070a0:	00913423          	sd	s1,8(sp)
    800070a4:	01213023          	sd	s2,0(sp)
    800070a8:	02010413          	addi	s0,sp,32
    uint8 i = 0;
    800070ac:	00000493          	li	s1,0
    800070b0:	0400006f          	j	800070f0 <_ZL11workerBodyCPv+0x5c>
        printString("C: i="); printInt(i); printString("\n");
    800070b4:	00003517          	auipc	a0,0x3
    800070b8:	44c50513          	addi	a0,a0,1100 # 8000a500 <CONSOLE_STATUS+0x4f0>
    800070bc:	ffffb097          	auipc	ra,0xffffb
    800070c0:	e44080e7          	jalr	-444(ra) # 80001f00 <_Z11printStringPKc>
    800070c4:	00000613          	li	a2,0
    800070c8:	00a00593          	li	a1,10
    800070cc:	00048513          	mv	a0,s1
    800070d0:	ffffb097          	auipc	ra,0xffffb
    800070d4:	fe0080e7          	jalr	-32(ra) # 800020b0 <_Z8printIntiii>
    800070d8:	00003517          	auipc	a0,0x3
    800070dc:	64850513          	addi	a0,a0,1608 # 8000a720 <CONSOLE_STATUS+0x710>
    800070e0:	ffffb097          	auipc	ra,0xffffb
    800070e4:	e20080e7          	jalr	-480(ra) # 80001f00 <_Z11printStringPKc>
    for (; i < 3; i++) {
    800070e8:	0014849b          	addiw	s1,s1,1
    800070ec:	0ff4f493          	andi	s1,s1,255
    800070f0:	00200793          	li	a5,2
    800070f4:	fc97f0e3          	bgeu	a5,s1,800070b4 <_ZL11workerBodyCPv+0x20>
    printString("C: dispatch\n");
    800070f8:	00003517          	auipc	a0,0x3
    800070fc:	41050513          	addi	a0,a0,1040 # 8000a508 <CONSOLE_STATUS+0x4f8>
    80007100:	ffffb097          	auipc	ra,0xffffb
    80007104:	e00080e7          	jalr	-512(ra) # 80001f00 <_Z11printStringPKc>
    __asm__ ("li t1, 7");
    80007108:	00700313          	li	t1,7
    thread_dispatch();
    8000710c:	ffffa097          	auipc	ra,0xffffa
    80007110:	27c080e7          	jalr	636(ra) # 80001388 <_Z15thread_dispatchv>
    __asm__ ("mv %[t1], t1" : [t1] "=r"(t1));
    80007114:	00030913          	mv	s2,t1
    printString("C: t1="); printInt(t1); printString("\n");
    80007118:	00003517          	auipc	a0,0x3
    8000711c:	40050513          	addi	a0,a0,1024 # 8000a518 <CONSOLE_STATUS+0x508>
    80007120:	ffffb097          	auipc	ra,0xffffb
    80007124:	de0080e7          	jalr	-544(ra) # 80001f00 <_Z11printStringPKc>
    80007128:	00000613          	li	a2,0
    8000712c:	00a00593          	li	a1,10
    80007130:	0009051b          	sext.w	a0,s2
    80007134:	ffffb097          	auipc	ra,0xffffb
    80007138:	f7c080e7          	jalr	-132(ra) # 800020b0 <_Z8printIntiii>
    8000713c:	00003517          	auipc	a0,0x3
    80007140:	5e450513          	addi	a0,a0,1508 # 8000a720 <CONSOLE_STATUS+0x710>
    80007144:	ffffb097          	auipc	ra,0xffffb
    80007148:	dbc080e7          	jalr	-580(ra) # 80001f00 <_Z11printStringPKc>
    uint64 result = fibonacci(12);
    8000714c:	00c00513          	li	a0,12
    80007150:	00000097          	auipc	ra,0x0
    80007154:	d88080e7          	jalr	-632(ra) # 80006ed8 <_ZL9fibonaccim>
    80007158:	00050913          	mv	s2,a0
    printString("C: fibonaci="); printInt(result); printString("\n");
    8000715c:	00003517          	auipc	a0,0x3
    80007160:	3c450513          	addi	a0,a0,964 # 8000a520 <CONSOLE_STATUS+0x510>
    80007164:	ffffb097          	auipc	ra,0xffffb
    80007168:	d9c080e7          	jalr	-612(ra) # 80001f00 <_Z11printStringPKc>
    8000716c:	00000613          	li	a2,0
    80007170:	00a00593          	li	a1,10
    80007174:	0009051b          	sext.w	a0,s2
    80007178:	ffffb097          	auipc	ra,0xffffb
    8000717c:	f38080e7          	jalr	-200(ra) # 800020b0 <_Z8printIntiii>
    80007180:	00003517          	auipc	a0,0x3
    80007184:	5a050513          	addi	a0,a0,1440 # 8000a720 <CONSOLE_STATUS+0x710>
    80007188:	ffffb097          	auipc	ra,0xffffb
    8000718c:	d78080e7          	jalr	-648(ra) # 80001f00 <_Z11printStringPKc>
    80007190:	0400006f          	j	800071d0 <_ZL11workerBodyCPv+0x13c>
        printString("C: i="); printInt(i); printString("\n");
    80007194:	00003517          	auipc	a0,0x3
    80007198:	36c50513          	addi	a0,a0,876 # 8000a500 <CONSOLE_STATUS+0x4f0>
    8000719c:	ffffb097          	auipc	ra,0xffffb
    800071a0:	d64080e7          	jalr	-668(ra) # 80001f00 <_Z11printStringPKc>
    800071a4:	00000613          	li	a2,0
    800071a8:	00a00593          	li	a1,10
    800071ac:	00048513          	mv	a0,s1
    800071b0:	ffffb097          	auipc	ra,0xffffb
    800071b4:	f00080e7          	jalr	-256(ra) # 800020b0 <_Z8printIntiii>
    800071b8:	00003517          	auipc	a0,0x3
    800071bc:	56850513          	addi	a0,a0,1384 # 8000a720 <CONSOLE_STATUS+0x710>
    800071c0:	ffffb097          	auipc	ra,0xffffb
    800071c4:	d40080e7          	jalr	-704(ra) # 80001f00 <_Z11printStringPKc>
    for (; i < 6; i++) {
    800071c8:	0014849b          	addiw	s1,s1,1
    800071cc:	0ff4f493          	andi	s1,s1,255
    800071d0:	00500793          	li	a5,5
    800071d4:	fc97f0e3          	bgeu	a5,s1,80007194 <_ZL11workerBodyCPv+0x100>
    printString("A finished!\n");
    800071d8:	00003517          	auipc	a0,0x3
    800071dc:	30050513          	addi	a0,a0,768 # 8000a4d8 <CONSOLE_STATUS+0x4c8>
    800071e0:	ffffb097          	auipc	ra,0xffffb
    800071e4:	d20080e7          	jalr	-736(ra) # 80001f00 <_Z11printStringPKc>
    finishedC = true;
    800071e8:	00100793          	li	a5,1
    800071ec:	00009717          	auipc	a4,0x9
    800071f0:	12f70fa3          	sb	a5,319(a4) # 8001032b <_ZL9finishedC>
    thread_dispatch();
    800071f4:	ffffa097          	auipc	ra,0xffffa
    800071f8:	194080e7          	jalr	404(ra) # 80001388 <_Z15thread_dispatchv>
}
    800071fc:	01813083          	ld	ra,24(sp)
    80007200:	01013403          	ld	s0,16(sp)
    80007204:	00813483          	ld	s1,8(sp)
    80007208:	00013903          	ld	s2,0(sp)
    8000720c:	02010113          	addi	sp,sp,32
    80007210:	00008067          	ret

0000000080007214 <_ZL11workerBodyBPv>:
static void workerBodyB(void* arg) {
    80007214:	fe010113          	addi	sp,sp,-32
    80007218:	00113c23          	sd	ra,24(sp)
    8000721c:	00813823          	sd	s0,16(sp)
    80007220:	00913423          	sd	s1,8(sp)
    80007224:	01213023          	sd	s2,0(sp)
    80007228:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 16; i++) {
    8000722c:	00000913          	li	s2,0
    80007230:	0400006f          	j	80007270 <_ZL11workerBodyBPv+0x5c>
            thread_dispatch();
    80007234:	ffffa097          	auipc	ra,0xffffa
    80007238:	154080e7          	jalr	340(ra) # 80001388 <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++) {
    8000723c:	00148493          	addi	s1,s1,1
    80007240:	000027b7          	lui	a5,0x2
    80007244:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    80007248:	0097ee63          	bltu	a5,s1,80007264 <_ZL11workerBodyBPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    8000724c:	00000713          	li	a4,0
    80007250:	000077b7          	lui	a5,0x7
    80007254:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    80007258:	fce7eee3          	bltu	a5,a4,80007234 <_ZL11workerBodyBPv+0x20>
    8000725c:	00170713          	addi	a4,a4,1
    80007260:	ff1ff06f          	j	80007250 <_ZL11workerBodyBPv+0x3c>
        if (i == 10) {
    80007264:	00a00793          	li	a5,10
    80007268:	04f90663          	beq	s2,a5,800072b4 <_ZL11workerBodyBPv+0xa0>
    for (uint64 i = 0; i < 16; i++) {
    8000726c:	00190913          	addi	s2,s2,1
    80007270:	00f00793          	li	a5,15
    80007274:	0527e463          	bltu	a5,s2,800072bc <_ZL11workerBodyBPv+0xa8>
        printString("B: i="); printInt(i); printString("\n");
    80007278:	00003517          	auipc	a0,0x3
    8000727c:	27050513          	addi	a0,a0,624 # 8000a4e8 <CONSOLE_STATUS+0x4d8>
    80007280:	ffffb097          	auipc	ra,0xffffb
    80007284:	c80080e7          	jalr	-896(ra) # 80001f00 <_Z11printStringPKc>
    80007288:	00000613          	li	a2,0
    8000728c:	00a00593          	li	a1,10
    80007290:	0009051b          	sext.w	a0,s2
    80007294:	ffffb097          	auipc	ra,0xffffb
    80007298:	e1c080e7          	jalr	-484(ra) # 800020b0 <_Z8printIntiii>
    8000729c:	00003517          	auipc	a0,0x3
    800072a0:	48450513          	addi	a0,a0,1156 # 8000a720 <CONSOLE_STATUS+0x710>
    800072a4:	ffffb097          	auipc	ra,0xffffb
    800072a8:	c5c080e7          	jalr	-932(ra) # 80001f00 <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    800072ac:	00000493          	li	s1,0
    800072b0:	f91ff06f          	j	80007240 <_ZL11workerBodyBPv+0x2c>
            asm volatile("csrr t6, sepc");
    800072b4:	14102ff3          	csrr	t6,sepc
    800072b8:	fb5ff06f          	j	8000726c <_ZL11workerBodyBPv+0x58>
    printString("B finished!\n");
    800072bc:	00003517          	auipc	a0,0x3
    800072c0:	23450513          	addi	a0,a0,564 # 8000a4f0 <CONSOLE_STATUS+0x4e0>
    800072c4:	ffffb097          	auipc	ra,0xffffb
    800072c8:	c3c080e7          	jalr	-964(ra) # 80001f00 <_Z11printStringPKc>
    finishedB = true;
    800072cc:	00100793          	li	a5,1
    800072d0:	00009717          	auipc	a4,0x9
    800072d4:	04f70e23          	sb	a5,92(a4) # 8001032c <_ZL9finishedB>
    thread_dispatch();
    800072d8:	ffffa097          	auipc	ra,0xffffa
    800072dc:	0b0080e7          	jalr	176(ra) # 80001388 <_Z15thread_dispatchv>
}
    800072e0:	01813083          	ld	ra,24(sp)
    800072e4:	01013403          	ld	s0,16(sp)
    800072e8:	00813483          	ld	s1,8(sp)
    800072ec:	00013903          	ld	s2,0(sp)
    800072f0:	02010113          	addi	sp,sp,32
    800072f4:	00008067          	ret

00000000800072f8 <_ZL11workerBodyAPv>:
static void workerBodyA(void* arg) {
    800072f8:	fe010113          	addi	sp,sp,-32
    800072fc:	00113c23          	sd	ra,24(sp)
    80007300:	00813823          	sd	s0,16(sp)
    80007304:	00913423          	sd	s1,8(sp)
    80007308:	01213023          	sd	s2,0(sp)
    8000730c:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 10; i++) {
    80007310:	00000913          	li	s2,0
    80007314:	0380006f          	j	8000734c <_ZL11workerBodyAPv+0x54>
            thread_dispatch();
    80007318:	ffffa097          	auipc	ra,0xffffa
    8000731c:	070080e7          	jalr	112(ra) # 80001388 <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++) {
    80007320:	00148493          	addi	s1,s1,1
    80007324:	000027b7          	lui	a5,0x2
    80007328:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    8000732c:	0097ee63          	bltu	a5,s1,80007348 <_ZL11workerBodyAPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    80007330:	00000713          	li	a4,0
    80007334:	000077b7          	lui	a5,0x7
    80007338:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    8000733c:	fce7eee3          	bltu	a5,a4,80007318 <_ZL11workerBodyAPv+0x20>
    80007340:	00170713          	addi	a4,a4,1
    80007344:	ff1ff06f          	j	80007334 <_ZL11workerBodyAPv+0x3c>
    for (uint64 i = 0; i < 10; i++) {
    80007348:	00190913          	addi	s2,s2,1
    8000734c:	00900793          	li	a5,9
    80007350:	0527e063          	bltu	a5,s2,80007390 <_ZL11workerBodyAPv+0x98>
        printString("A: i="); printInt(i); printString("\n");
    80007354:	00003517          	auipc	a0,0x3
    80007358:	17c50513          	addi	a0,a0,380 # 8000a4d0 <CONSOLE_STATUS+0x4c0>
    8000735c:	ffffb097          	auipc	ra,0xffffb
    80007360:	ba4080e7          	jalr	-1116(ra) # 80001f00 <_Z11printStringPKc>
    80007364:	00000613          	li	a2,0
    80007368:	00a00593          	li	a1,10
    8000736c:	0009051b          	sext.w	a0,s2
    80007370:	ffffb097          	auipc	ra,0xffffb
    80007374:	d40080e7          	jalr	-704(ra) # 800020b0 <_Z8printIntiii>
    80007378:	00003517          	auipc	a0,0x3
    8000737c:	3a850513          	addi	a0,a0,936 # 8000a720 <CONSOLE_STATUS+0x710>
    80007380:	ffffb097          	auipc	ra,0xffffb
    80007384:	b80080e7          	jalr	-1152(ra) # 80001f00 <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    80007388:	00000493          	li	s1,0
    8000738c:	f99ff06f          	j	80007324 <_ZL11workerBodyAPv+0x2c>
    printString("A finished!\n");
    80007390:	00003517          	auipc	a0,0x3
    80007394:	14850513          	addi	a0,a0,328 # 8000a4d8 <CONSOLE_STATUS+0x4c8>
    80007398:	ffffb097          	auipc	ra,0xffffb
    8000739c:	b68080e7          	jalr	-1176(ra) # 80001f00 <_Z11printStringPKc>
    finishedA = true;
    800073a0:	00100793          	li	a5,1
    800073a4:	00009717          	auipc	a4,0x9
    800073a8:	f8f704a3          	sb	a5,-119(a4) # 8001032d <_ZL9finishedA>
}
    800073ac:	01813083          	ld	ra,24(sp)
    800073b0:	01013403          	ld	s0,16(sp)
    800073b4:	00813483          	ld	s1,8(sp)
    800073b8:	00013903          	ld	s2,0(sp)
    800073bc:	02010113          	addi	sp,sp,32
    800073c0:	00008067          	ret

00000000800073c4 <_Z16System_Mode_testv>:


void System_Mode_test() {
    800073c4:	fd010113          	addi	sp,sp,-48
    800073c8:	02113423          	sd	ra,40(sp)
    800073cc:	02813023          	sd	s0,32(sp)
    800073d0:	03010413          	addi	s0,sp,48
    thread_t threads[4];
    thread_create(&threads[0], workerBodyA, nullptr);
    800073d4:	00000613          	li	a2,0
    800073d8:	00000597          	auipc	a1,0x0
    800073dc:	f2058593          	addi	a1,a1,-224 # 800072f8 <_ZL11workerBodyAPv>
    800073e0:	fd040513          	addi	a0,s0,-48
    800073e4:	ffffa097          	auipc	ra,0xffffa
    800073e8:	f1c080e7          	jalr	-228(ra) # 80001300 <_Z13thread_createPP8thread_sPFvPvES2_>
    printString("ThreadA created\n");
    800073ec:	00003517          	auipc	a0,0x3
    800073f0:	17c50513          	addi	a0,a0,380 # 8000a568 <CONSOLE_STATUS+0x558>
    800073f4:	ffffb097          	auipc	ra,0xffffb
    800073f8:	b0c080e7          	jalr	-1268(ra) # 80001f00 <_Z11printStringPKc>

    thread_create(&threads[1], workerBodyB, nullptr);
    800073fc:	00000613          	li	a2,0
    80007400:	00000597          	auipc	a1,0x0
    80007404:	e1458593          	addi	a1,a1,-492 # 80007214 <_ZL11workerBodyBPv>
    80007408:	fd840513          	addi	a0,s0,-40
    8000740c:	ffffa097          	auipc	ra,0xffffa
    80007410:	ef4080e7          	jalr	-268(ra) # 80001300 <_Z13thread_createPP8thread_sPFvPvES2_>
    printString("ThreadB created\n");
    80007414:	00003517          	auipc	a0,0x3
    80007418:	16c50513          	addi	a0,a0,364 # 8000a580 <CONSOLE_STATUS+0x570>
    8000741c:	ffffb097          	auipc	ra,0xffffb
    80007420:	ae4080e7          	jalr	-1308(ra) # 80001f00 <_Z11printStringPKc>

    thread_create(&threads[2], workerBodyC, nullptr);
    80007424:	00000613          	li	a2,0
    80007428:	00000597          	auipc	a1,0x0
    8000742c:	c6c58593          	addi	a1,a1,-916 # 80007094 <_ZL11workerBodyCPv>
    80007430:	fe040513          	addi	a0,s0,-32
    80007434:	ffffa097          	auipc	ra,0xffffa
    80007438:	ecc080e7          	jalr	-308(ra) # 80001300 <_Z13thread_createPP8thread_sPFvPvES2_>
    printString("ThreadC created\n");
    8000743c:	00003517          	auipc	a0,0x3
    80007440:	15c50513          	addi	a0,a0,348 # 8000a598 <CONSOLE_STATUS+0x588>
    80007444:	ffffb097          	auipc	ra,0xffffb
    80007448:	abc080e7          	jalr	-1348(ra) # 80001f00 <_Z11printStringPKc>

    thread_create(&threads[3], workerBodyD, nullptr);
    8000744c:	00000613          	li	a2,0
    80007450:	00000597          	auipc	a1,0x0
    80007454:	afc58593          	addi	a1,a1,-1284 # 80006f4c <_ZL11workerBodyDPv>
    80007458:	fe840513          	addi	a0,s0,-24
    8000745c:	ffffa097          	auipc	ra,0xffffa
    80007460:	ea4080e7          	jalr	-348(ra) # 80001300 <_Z13thread_createPP8thread_sPFvPvES2_>
    printString("ThreadD created\n");
    80007464:	00003517          	auipc	a0,0x3
    80007468:	14c50513          	addi	a0,a0,332 # 8000a5b0 <CONSOLE_STATUS+0x5a0>
    8000746c:	ffffb097          	auipc	ra,0xffffb
    80007470:	a94080e7          	jalr	-1388(ra) # 80001f00 <_Z11printStringPKc>
    80007474:	00c0006f          	j	80007480 <_Z16System_Mode_testv+0xbc>

    while (!(finishedA && finishedB && finishedC && finishedD)) {
        thread_dispatch();
    80007478:	ffffa097          	auipc	ra,0xffffa
    8000747c:	f10080e7          	jalr	-240(ra) # 80001388 <_Z15thread_dispatchv>
    while (!(finishedA && finishedB && finishedC && finishedD)) {
    80007480:	00009797          	auipc	a5,0x9
    80007484:	ead7c783          	lbu	a5,-339(a5) # 8001032d <_ZL9finishedA>
    80007488:	fe0788e3          	beqz	a5,80007478 <_Z16System_Mode_testv+0xb4>
    8000748c:	00009797          	auipc	a5,0x9
    80007490:	ea07c783          	lbu	a5,-352(a5) # 8001032c <_ZL9finishedB>
    80007494:	fe0782e3          	beqz	a5,80007478 <_Z16System_Mode_testv+0xb4>
    80007498:	00009797          	auipc	a5,0x9
    8000749c:	e937c783          	lbu	a5,-365(a5) # 8001032b <_ZL9finishedC>
    800074a0:	fc078ce3          	beqz	a5,80007478 <_Z16System_Mode_testv+0xb4>
    800074a4:	00009797          	auipc	a5,0x9
    800074a8:	e867c783          	lbu	a5,-378(a5) # 8001032a <_ZL9finishedD>
    800074ac:	fc0786e3          	beqz	a5,80007478 <_Z16System_Mode_testv+0xb4>
    }

}
    800074b0:	02813083          	ld	ra,40(sp)
    800074b4:	02013403          	ld	s0,32(sp)
    800074b8:	03010113          	addi	sp,sp,48
    800074bc:	00008067          	ret

00000000800074c0 <_ZN6BufferC1Ei>:
#include "buffer.hpp"

Buffer::Buffer(int _cap) : cap(_cap + 1), head(0), tail(0) {
    800074c0:	fe010113          	addi	sp,sp,-32
    800074c4:	00113c23          	sd	ra,24(sp)
    800074c8:	00813823          	sd	s0,16(sp)
    800074cc:	00913423          	sd	s1,8(sp)
    800074d0:	01213023          	sd	s2,0(sp)
    800074d4:	02010413          	addi	s0,sp,32
    800074d8:	00050493          	mv	s1,a0
    800074dc:	00058913          	mv	s2,a1
    800074e0:	0015879b          	addiw	a5,a1,1
    800074e4:	0007851b          	sext.w	a0,a5
    800074e8:	00f4a023          	sw	a5,0(s1)
    800074ec:	0004a823          	sw	zero,16(s1)
    800074f0:	0004aa23          	sw	zero,20(s1)
    buffer = (int *)mem_alloc(sizeof(int) * cap);
    800074f4:	00251513          	slli	a0,a0,0x2
    800074f8:	ffffa097          	auipc	ra,0xffffa
    800074fc:	d88080e7          	jalr	-632(ra) # 80001280 <_Z9mem_allocm>
    80007500:	00a4b423          	sd	a0,8(s1)
    sem_open(&itemAvailable, 0);
    80007504:	00000593          	li	a1,0
    80007508:	02048513          	addi	a0,s1,32
    8000750c:	ffffa097          	auipc	ra,0xffffa
    80007510:	f30080e7          	jalr	-208(ra) # 8000143c <_Z8sem_openPP5sem_sj>
    sem_open(&spaceAvailable, _cap);
    80007514:	00090593          	mv	a1,s2
    80007518:	01848513          	addi	a0,s1,24
    8000751c:	ffffa097          	auipc	ra,0xffffa
    80007520:	f20080e7          	jalr	-224(ra) # 8000143c <_Z8sem_openPP5sem_sj>
    sem_open(&mutexHead, 1);
    80007524:	00100593          	li	a1,1
    80007528:	02848513          	addi	a0,s1,40
    8000752c:	ffffa097          	auipc	ra,0xffffa
    80007530:	f10080e7          	jalr	-240(ra) # 8000143c <_Z8sem_openPP5sem_sj>
    sem_open(&mutexTail, 1);
    80007534:	00100593          	li	a1,1
    80007538:	03048513          	addi	a0,s1,48
    8000753c:	ffffa097          	auipc	ra,0xffffa
    80007540:	f00080e7          	jalr	-256(ra) # 8000143c <_Z8sem_openPP5sem_sj>
}
    80007544:	01813083          	ld	ra,24(sp)
    80007548:	01013403          	ld	s0,16(sp)
    8000754c:	00813483          	ld	s1,8(sp)
    80007550:	00013903          	ld	s2,0(sp)
    80007554:	02010113          	addi	sp,sp,32
    80007558:	00008067          	ret

000000008000755c <_ZN6Buffer3putEi>:
    sem_close(spaceAvailable);
    sem_close(mutexTail);
    sem_close(mutexHead);
}

void Buffer::put(int val) {
    8000755c:	fe010113          	addi	sp,sp,-32
    80007560:	00113c23          	sd	ra,24(sp)
    80007564:	00813823          	sd	s0,16(sp)
    80007568:	00913423          	sd	s1,8(sp)
    8000756c:	01213023          	sd	s2,0(sp)
    80007570:	02010413          	addi	s0,sp,32
    80007574:	00050493          	mv	s1,a0
    80007578:	00058913          	mv	s2,a1
    sem_wait(spaceAvailable);
    8000757c:	01853503          	ld	a0,24(a0)
    80007580:	ffffa097          	auipc	ra,0xffffa
    80007584:	f40080e7          	jalr	-192(ra) # 800014c0 <_Z8sem_waitP5sem_s>

    sem_wait(mutexTail);
    80007588:	0304b503          	ld	a0,48(s1)
    8000758c:	ffffa097          	auipc	ra,0xffffa
    80007590:	f34080e7          	jalr	-204(ra) # 800014c0 <_Z8sem_waitP5sem_s>
    buffer[tail] = val;
    80007594:	0084b783          	ld	a5,8(s1)
    80007598:	0144a703          	lw	a4,20(s1)
    8000759c:	00271713          	slli	a4,a4,0x2
    800075a0:	00e787b3          	add	a5,a5,a4
    800075a4:	0127a023          	sw	s2,0(a5)
    tail = (tail + 1) % cap;
    800075a8:	0144a783          	lw	a5,20(s1)
    800075ac:	0017879b          	addiw	a5,a5,1
    800075b0:	0004a703          	lw	a4,0(s1)
    800075b4:	02e7e7bb          	remw	a5,a5,a4
    800075b8:	00f4aa23          	sw	a5,20(s1)
    sem_signal(mutexTail);
    800075bc:	0304b503          	ld	a0,48(s1)
    800075c0:	ffffa097          	auipc	ra,0xffffa
    800075c4:	f40080e7          	jalr	-192(ra) # 80001500 <_Z10sem_signalP5sem_s>

    sem_signal(itemAvailable);
    800075c8:	0204b503          	ld	a0,32(s1)
    800075cc:	ffffa097          	auipc	ra,0xffffa
    800075d0:	f34080e7          	jalr	-204(ra) # 80001500 <_Z10sem_signalP5sem_s>

}
    800075d4:	01813083          	ld	ra,24(sp)
    800075d8:	01013403          	ld	s0,16(sp)
    800075dc:	00813483          	ld	s1,8(sp)
    800075e0:	00013903          	ld	s2,0(sp)
    800075e4:	02010113          	addi	sp,sp,32
    800075e8:	00008067          	ret

00000000800075ec <_ZN6Buffer3getEv>:

int Buffer::get() {
    800075ec:	fe010113          	addi	sp,sp,-32
    800075f0:	00113c23          	sd	ra,24(sp)
    800075f4:	00813823          	sd	s0,16(sp)
    800075f8:	00913423          	sd	s1,8(sp)
    800075fc:	01213023          	sd	s2,0(sp)
    80007600:	02010413          	addi	s0,sp,32
    80007604:	00050493          	mv	s1,a0
    sem_wait(itemAvailable);
    80007608:	02053503          	ld	a0,32(a0)
    8000760c:	ffffa097          	auipc	ra,0xffffa
    80007610:	eb4080e7          	jalr	-332(ra) # 800014c0 <_Z8sem_waitP5sem_s>

    sem_wait(mutexHead);
    80007614:	0284b503          	ld	a0,40(s1)
    80007618:	ffffa097          	auipc	ra,0xffffa
    8000761c:	ea8080e7          	jalr	-344(ra) # 800014c0 <_Z8sem_waitP5sem_s>

    int ret = buffer[head];
    80007620:	0084b703          	ld	a4,8(s1)
    80007624:	0104a783          	lw	a5,16(s1)
    80007628:	00279693          	slli	a3,a5,0x2
    8000762c:	00d70733          	add	a4,a4,a3
    80007630:	00072903          	lw	s2,0(a4)
    head = (head + 1) % cap;
    80007634:	0017879b          	addiw	a5,a5,1
    80007638:	0004a703          	lw	a4,0(s1)
    8000763c:	02e7e7bb          	remw	a5,a5,a4
    80007640:	00f4a823          	sw	a5,16(s1)
    sem_signal(mutexHead);
    80007644:	0284b503          	ld	a0,40(s1)
    80007648:	ffffa097          	auipc	ra,0xffffa
    8000764c:	eb8080e7          	jalr	-328(ra) # 80001500 <_Z10sem_signalP5sem_s>

    sem_signal(spaceAvailable);
    80007650:	0184b503          	ld	a0,24(s1)
    80007654:	ffffa097          	auipc	ra,0xffffa
    80007658:	eac080e7          	jalr	-340(ra) # 80001500 <_Z10sem_signalP5sem_s>

    return ret;
}
    8000765c:	00090513          	mv	a0,s2
    80007660:	01813083          	ld	ra,24(sp)
    80007664:	01013403          	ld	s0,16(sp)
    80007668:	00813483          	ld	s1,8(sp)
    8000766c:	00013903          	ld	s2,0(sp)
    80007670:	02010113          	addi	sp,sp,32
    80007674:	00008067          	ret

0000000080007678 <_ZN6Buffer6getCntEv>:

int Buffer::getCnt() {
    80007678:	fe010113          	addi	sp,sp,-32
    8000767c:	00113c23          	sd	ra,24(sp)
    80007680:	00813823          	sd	s0,16(sp)
    80007684:	00913423          	sd	s1,8(sp)
    80007688:	01213023          	sd	s2,0(sp)
    8000768c:	02010413          	addi	s0,sp,32
    80007690:	00050493          	mv	s1,a0
    int ret;

    sem_wait(mutexHead);
    80007694:	02853503          	ld	a0,40(a0)
    80007698:	ffffa097          	auipc	ra,0xffffa
    8000769c:	e28080e7          	jalr	-472(ra) # 800014c0 <_Z8sem_waitP5sem_s>
    sem_wait(mutexTail);
    800076a0:	0304b503          	ld	a0,48(s1)
    800076a4:	ffffa097          	auipc	ra,0xffffa
    800076a8:	e1c080e7          	jalr	-484(ra) # 800014c0 <_Z8sem_waitP5sem_s>

    if (tail >= head) {
    800076ac:	0144a783          	lw	a5,20(s1)
    800076b0:	0104a903          	lw	s2,16(s1)
    800076b4:	0327ce63          	blt	a5,s2,800076f0 <_ZN6Buffer6getCntEv+0x78>
        ret = tail - head;
    800076b8:	4127893b          	subw	s2,a5,s2
    } else {
        ret = cap - head + tail;
    }

    sem_signal(mutexTail);
    800076bc:	0304b503          	ld	a0,48(s1)
    800076c0:	ffffa097          	auipc	ra,0xffffa
    800076c4:	e40080e7          	jalr	-448(ra) # 80001500 <_Z10sem_signalP5sem_s>
    sem_signal(mutexHead);
    800076c8:	0284b503          	ld	a0,40(s1)
    800076cc:	ffffa097          	auipc	ra,0xffffa
    800076d0:	e34080e7          	jalr	-460(ra) # 80001500 <_Z10sem_signalP5sem_s>

    return ret;
}
    800076d4:	00090513          	mv	a0,s2
    800076d8:	01813083          	ld	ra,24(sp)
    800076dc:	01013403          	ld	s0,16(sp)
    800076e0:	00813483          	ld	s1,8(sp)
    800076e4:	00013903          	ld	s2,0(sp)
    800076e8:	02010113          	addi	sp,sp,32
    800076ec:	00008067          	ret
        ret = cap - head + tail;
    800076f0:	0004a703          	lw	a4,0(s1)
    800076f4:	4127093b          	subw	s2,a4,s2
    800076f8:	00f9093b          	addw	s2,s2,a5
    800076fc:	fc1ff06f          	j	800076bc <_ZN6Buffer6getCntEv+0x44>

0000000080007700 <_ZN6BufferD1Ev>:
Buffer::~Buffer() {
    80007700:	fe010113          	addi	sp,sp,-32
    80007704:	00113c23          	sd	ra,24(sp)
    80007708:	00813823          	sd	s0,16(sp)
    8000770c:	00913423          	sd	s1,8(sp)
    80007710:	02010413          	addi	s0,sp,32
    80007714:	00050493          	mv	s1,a0
    putc('\n');
    80007718:	00a00513          	li	a0,10
    8000771c:	ffffa097          	auipc	ra,0xffffa
    80007720:	e94080e7          	jalr	-364(ra) # 800015b0 <_Z4putcc>
    printString("Buffer deleted!\n");
    80007724:	00003517          	auipc	a0,0x3
    80007728:	ea450513          	addi	a0,a0,-348 # 8000a5c8 <CONSOLE_STATUS+0x5b8>
    8000772c:	ffffa097          	auipc	ra,0xffffa
    80007730:	7d4080e7          	jalr	2004(ra) # 80001f00 <_Z11printStringPKc>
    while (getCnt() > 0) {
    80007734:	00048513          	mv	a0,s1
    80007738:	00000097          	auipc	ra,0x0
    8000773c:	f40080e7          	jalr	-192(ra) # 80007678 <_ZN6Buffer6getCntEv>
    80007740:	02a05c63          	blez	a0,80007778 <_ZN6BufferD1Ev+0x78>
        char ch = buffer[head];
    80007744:	0084b783          	ld	a5,8(s1)
    80007748:	0104a703          	lw	a4,16(s1)
    8000774c:	00271713          	slli	a4,a4,0x2
    80007750:	00e787b3          	add	a5,a5,a4
        putc(ch);
    80007754:	0007c503          	lbu	a0,0(a5)
    80007758:	ffffa097          	auipc	ra,0xffffa
    8000775c:	e58080e7          	jalr	-424(ra) # 800015b0 <_Z4putcc>
        head = (head + 1) % cap;
    80007760:	0104a783          	lw	a5,16(s1)
    80007764:	0017879b          	addiw	a5,a5,1
    80007768:	0004a703          	lw	a4,0(s1)
    8000776c:	02e7e7bb          	remw	a5,a5,a4
    80007770:	00f4a823          	sw	a5,16(s1)
    while (getCnt() > 0) {
    80007774:	fc1ff06f          	j	80007734 <_ZN6BufferD1Ev+0x34>
    putc('!');
    80007778:	02100513          	li	a0,33
    8000777c:	ffffa097          	auipc	ra,0xffffa
    80007780:	e34080e7          	jalr	-460(ra) # 800015b0 <_Z4putcc>
    putc('\n');
    80007784:	00a00513          	li	a0,10
    80007788:	ffffa097          	auipc	ra,0xffffa
    8000778c:	e28080e7          	jalr	-472(ra) # 800015b0 <_Z4putcc>
    mem_free(buffer);
    80007790:	0084b503          	ld	a0,8(s1)
    80007794:	ffffa097          	auipc	ra,0xffffa
    80007798:	b2c080e7          	jalr	-1236(ra) # 800012c0 <_Z8mem_freePv>
    sem_close(itemAvailable);
    8000779c:	0204b503          	ld	a0,32(s1)
    800077a0:	ffffa097          	auipc	ra,0xffffa
    800077a4:	ce0080e7          	jalr	-800(ra) # 80001480 <_Z9sem_closeP5sem_s>
    sem_close(spaceAvailable);
    800077a8:	0184b503          	ld	a0,24(s1)
    800077ac:	ffffa097          	auipc	ra,0xffffa
    800077b0:	cd4080e7          	jalr	-812(ra) # 80001480 <_Z9sem_closeP5sem_s>
    sem_close(mutexTail);
    800077b4:	0304b503          	ld	a0,48(s1)
    800077b8:	ffffa097          	auipc	ra,0xffffa
    800077bc:	cc8080e7          	jalr	-824(ra) # 80001480 <_Z9sem_closeP5sem_s>
    sem_close(mutexHead);
    800077c0:	0284b503          	ld	a0,40(s1)
    800077c4:	ffffa097          	auipc	ra,0xffffa
    800077c8:	cbc080e7          	jalr	-836(ra) # 80001480 <_Z9sem_closeP5sem_s>
}
    800077cc:	01813083          	ld	ra,24(sp)
    800077d0:	01013403          	ld	s0,16(sp)
    800077d4:	00813483          	ld	s1,8(sp)
    800077d8:	02010113          	addi	sp,sp,32
    800077dc:	00008067          	ret

00000000800077e0 <start>:
    800077e0:	ff010113          	addi	sp,sp,-16
    800077e4:	00813423          	sd	s0,8(sp)
    800077e8:	01010413          	addi	s0,sp,16
    800077ec:	300027f3          	csrr	a5,mstatus
    800077f0:	ffffe737          	lui	a4,0xffffe
    800077f4:	7ff70713          	addi	a4,a4,2047 # ffffffffffffe7ff <end+0xffffffff7ffed26f>
    800077f8:	00e7f7b3          	and	a5,a5,a4
    800077fc:	00001737          	lui	a4,0x1
    80007800:	80070713          	addi	a4,a4,-2048 # 800 <_entry-0x7ffff800>
    80007804:	00e7e7b3          	or	a5,a5,a4
    80007808:	30079073          	csrw	mstatus,a5
    8000780c:	00000797          	auipc	a5,0x0
    80007810:	16078793          	addi	a5,a5,352 # 8000796c <system_main>
    80007814:	34179073          	csrw	mepc,a5
    80007818:	00000793          	li	a5,0
    8000781c:	18079073          	csrw	satp,a5
    80007820:	000107b7          	lui	a5,0x10
    80007824:	fff78793          	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    80007828:	30279073          	csrw	medeleg,a5
    8000782c:	30379073          	csrw	mideleg,a5
    80007830:	104027f3          	csrr	a5,sie
    80007834:	2227e793          	ori	a5,a5,546
    80007838:	10479073          	csrw	sie,a5
    8000783c:	fff00793          	li	a5,-1
    80007840:	00a7d793          	srli	a5,a5,0xa
    80007844:	3b079073          	csrw	pmpaddr0,a5
    80007848:	00f00793          	li	a5,15
    8000784c:	3a079073          	csrw	pmpcfg0,a5
    80007850:	f14027f3          	csrr	a5,mhartid
    80007854:	0200c737          	lui	a4,0x200c
    80007858:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    8000785c:	0007869b          	sext.w	a3,a5
    80007860:	00269713          	slli	a4,a3,0x2
    80007864:	000f4637          	lui	a2,0xf4
    80007868:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    8000786c:	00d70733          	add	a4,a4,a3
    80007870:	0037979b          	slliw	a5,a5,0x3
    80007874:	020046b7          	lui	a3,0x2004
    80007878:	00d787b3          	add	a5,a5,a3
    8000787c:	00c585b3          	add	a1,a1,a2
    80007880:	00371693          	slli	a3,a4,0x3
    80007884:	00009717          	auipc	a4,0x9
    80007888:	aac70713          	addi	a4,a4,-1364 # 80010330 <timer_scratch>
    8000788c:	00b7b023          	sd	a1,0(a5)
    80007890:	00d70733          	add	a4,a4,a3
    80007894:	00f73c23          	sd	a5,24(a4)
    80007898:	02c73023          	sd	a2,32(a4)
    8000789c:	34071073          	csrw	mscratch,a4
    800078a0:	00000797          	auipc	a5,0x0
    800078a4:	6e078793          	addi	a5,a5,1760 # 80007f80 <timervec>
    800078a8:	30579073          	csrw	mtvec,a5
    800078ac:	300027f3          	csrr	a5,mstatus
    800078b0:	0087e793          	ori	a5,a5,8
    800078b4:	30079073          	csrw	mstatus,a5
    800078b8:	304027f3          	csrr	a5,mie
    800078bc:	0807e793          	ori	a5,a5,128
    800078c0:	30479073          	csrw	mie,a5
    800078c4:	f14027f3          	csrr	a5,mhartid
    800078c8:	0007879b          	sext.w	a5,a5
    800078cc:	00078213          	mv	tp,a5
    800078d0:	30200073          	mret
    800078d4:	00813403          	ld	s0,8(sp)
    800078d8:	01010113          	addi	sp,sp,16
    800078dc:	00008067          	ret

00000000800078e0 <timerinit>:
    800078e0:	ff010113          	addi	sp,sp,-16
    800078e4:	00813423          	sd	s0,8(sp)
    800078e8:	01010413          	addi	s0,sp,16
    800078ec:	f14027f3          	csrr	a5,mhartid
    800078f0:	0200c737          	lui	a4,0x200c
    800078f4:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    800078f8:	0007869b          	sext.w	a3,a5
    800078fc:	00269713          	slli	a4,a3,0x2
    80007900:	000f4637          	lui	a2,0xf4
    80007904:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    80007908:	00d70733          	add	a4,a4,a3
    8000790c:	0037979b          	slliw	a5,a5,0x3
    80007910:	020046b7          	lui	a3,0x2004
    80007914:	00d787b3          	add	a5,a5,a3
    80007918:	00c585b3          	add	a1,a1,a2
    8000791c:	00371693          	slli	a3,a4,0x3
    80007920:	00009717          	auipc	a4,0x9
    80007924:	a1070713          	addi	a4,a4,-1520 # 80010330 <timer_scratch>
    80007928:	00b7b023          	sd	a1,0(a5)
    8000792c:	00d70733          	add	a4,a4,a3
    80007930:	00f73c23          	sd	a5,24(a4)
    80007934:	02c73023          	sd	a2,32(a4)
    80007938:	34071073          	csrw	mscratch,a4
    8000793c:	00000797          	auipc	a5,0x0
    80007940:	64478793          	addi	a5,a5,1604 # 80007f80 <timervec>
    80007944:	30579073          	csrw	mtvec,a5
    80007948:	300027f3          	csrr	a5,mstatus
    8000794c:	0087e793          	ori	a5,a5,8
    80007950:	30079073          	csrw	mstatus,a5
    80007954:	304027f3          	csrr	a5,mie
    80007958:	0807e793          	ori	a5,a5,128
    8000795c:	30479073          	csrw	mie,a5
    80007960:	00813403          	ld	s0,8(sp)
    80007964:	01010113          	addi	sp,sp,16
    80007968:	00008067          	ret

000000008000796c <system_main>:
    8000796c:	fe010113          	addi	sp,sp,-32
    80007970:	00813823          	sd	s0,16(sp)
    80007974:	00913423          	sd	s1,8(sp)
    80007978:	00113c23          	sd	ra,24(sp)
    8000797c:	02010413          	addi	s0,sp,32
    80007980:	00000097          	auipc	ra,0x0
    80007984:	0c4080e7          	jalr	196(ra) # 80007a44 <cpuid>
    80007988:	00005497          	auipc	s1,0x5
    8000798c:	20848493          	addi	s1,s1,520 # 8000cb90 <started>
    80007990:	02050263          	beqz	a0,800079b4 <system_main+0x48>
    80007994:	0004a783          	lw	a5,0(s1)
    80007998:	0007879b          	sext.w	a5,a5
    8000799c:	fe078ce3          	beqz	a5,80007994 <system_main+0x28>
    800079a0:	0ff0000f          	fence
    800079a4:	00003517          	auipc	a0,0x3
    800079a8:	ef450513          	addi	a0,a0,-268 # 8000a898 <CONSOLE_STATUS+0x888>
    800079ac:	00001097          	auipc	ra,0x1
    800079b0:	a70080e7          	jalr	-1424(ra) # 8000841c <panic>
    800079b4:	00001097          	auipc	ra,0x1
    800079b8:	9c4080e7          	jalr	-1596(ra) # 80008378 <consoleinit>
    800079bc:	00001097          	auipc	ra,0x1
    800079c0:	150080e7          	jalr	336(ra) # 80008b0c <printfinit>
    800079c4:	00003517          	auipc	a0,0x3
    800079c8:	d5c50513          	addi	a0,a0,-676 # 8000a720 <CONSOLE_STATUS+0x710>
    800079cc:	00001097          	auipc	ra,0x1
    800079d0:	aac080e7          	jalr	-1364(ra) # 80008478 <__printf>
    800079d4:	00003517          	auipc	a0,0x3
    800079d8:	e9450513          	addi	a0,a0,-364 # 8000a868 <CONSOLE_STATUS+0x858>
    800079dc:	00001097          	auipc	ra,0x1
    800079e0:	a9c080e7          	jalr	-1380(ra) # 80008478 <__printf>
    800079e4:	00003517          	auipc	a0,0x3
    800079e8:	d3c50513          	addi	a0,a0,-708 # 8000a720 <CONSOLE_STATUS+0x710>
    800079ec:	00001097          	auipc	ra,0x1
    800079f0:	a8c080e7          	jalr	-1396(ra) # 80008478 <__printf>
    800079f4:	00001097          	auipc	ra,0x1
    800079f8:	4a4080e7          	jalr	1188(ra) # 80008e98 <kinit>
    800079fc:	00000097          	auipc	ra,0x0
    80007a00:	148080e7          	jalr	328(ra) # 80007b44 <trapinit>
    80007a04:	00000097          	auipc	ra,0x0
    80007a08:	16c080e7          	jalr	364(ra) # 80007b70 <trapinithart>
    80007a0c:	00000097          	auipc	ra,0x0
    80007a10:	5b4080e7          	jalr	1460(ra) # 80007fc0 <plicinit>
    80007a14:	00000097          	auipc	ra,0x0
    80007a18:	5d4080e7          	jalr	1492(ra) # 80007fe8 <plicinithart>
    80007a1c:	00000097          	auipc	ra,0x0
    80007a20:	078080e7          	jalr	120(ra) # 80007a94 <userinit>
    80007a24:	0ff0000f          	fence
    80007a28:	00100793          	li	a5,1
    80007a2c:	00003517          	auipc	a0,0x3
    80007a30:	e5450513          	addi	a0,a0,-428 # 8000a880 <CONSOLE_STATUS+0x870>
    80007a34:	00f4a023          	sw	a5,0(s1)
    80007a38:	00001097          	auipc	ra,0x1
    80007a3c:	a40080e7          	jalr	-1472(ra) # 80008478 <__printf>
    80007a40:	0000006f          	j	80007a40 <system_main+0xd4>

0000000080007a44 <cpuid>:
    80007a44:	ff010113          	addi	sp,sp,-16
    80007a48:	00813423          	sd	s0,8(sp)
    80007a4c:	01010413          	addi	s0,sp,16
    80007a50:	00020513          	mv	a0,tp
    80007a54:	00813403          	ld	s0,8(sp)
    80007a58:	0005051b          	sext.w	a0,a0
    80007a5c:	01010113          	addi	sp,sp,16
    80007a60:	00008067          	ret

0000000080007a64 <mycpu>:
    80007a64:	ff010113          	addi	sp,sp,-16
    80007a68:	00813423          	sd	s0,8(sp)
    80007a6c:	01010413          	addi	s0,sp,16
    80007a70:	00020793          	mv	a5,tp
    80007a74:	00813403          	ld	s0,8(sp)
    80007a78:	0007879b          	sext.w	a5,a5
    80007a7c:	00779793          	slli	a5,a5,0x7
    80007a80:	0000a517          	auipc	a0,0xa
    80007a84:	8e050513          	addi	a0,a0,-1824 # 80011360 <cpus>
    80007a88:	00f50533          	add	a0,a0,a5
    80007a8c:	01010113          	addi	sp,sp,16
    80007a90:	00008067          	ret

0000000080007a94 <userinit>:
    80007a94:	ff010113          	addi	sp,sp,-16
    80007a98:	00813423          	sd	s0,8(sp)
    80007a9c:	01010413          	addi	s0,sp,16
    80007aa0:	00813403          	ld	s0,8(sp)
    80007aa4:	01010113          	addi	sp,sp,16
    80007aa8:	ffffb317          	auipc	t1,0xffffb
    80007aac:	fd830067          	jr	-40(t1) # 80002a80 <main>

0000000080007ab0 <either_copyout>:
    80007ab0:	ff010113          	addi	sp,sp,-16
    80007ab4:	00813023          	sd	s0,0(sp)
    80007ab8:	00113423          	sd	ra,8(sp)
    80007abc:	01010413          	addi	s0,sp,16
    80007ac0:	02051663          	bnez	a0,80007aec <either_copyout+0x3c>
    80007ac4:	00058513          	mv	a0,a1
    80007ac8:	00060593          	mv	a1,a2
    80007acc:	0006861b          	sext.w	a2,a3
    80007ad0:	00002097          	auipc	ra,0x2
    80007ad4:	c54080e7          	jalr	-940(ra) # 80009724 <__memmove>
    80007ad8:	00813083          	ld	ra,8(sp)
    80007adc:	00013403          	ld	s0,0(sp)
    80007ae0:	00000513          	li	a0,0
    80007ae4:	01010113          	addi	sp,sp,16
    80007ae8:	00008067          	ret
    80007aec:	00003517          	auipc	a0,0x3
    80007af0:	dd450513          	addi	a0,a0,-556 # 8000a8c0 <CONSOLE_STATUS+0x8b0>
    80007af4:	00001097          	auipc	ra,0x1
    80007af8:	928080e7          	jalr	-1752(ra) # 8000841c <panic>

0000000080007afc <either_copyin>:
    80007afc:	ff010113          	addi	sp,sp,-16
    80007b00:	00813023          	sd	s0,0(sp)
    80007b04:	00113423          	sd	ra,8(sp)
    80007b08:	01010413          	addi	s0,sp,16
    80007b0c:	02059463          	bnez	a1,80007b34 <either_copyin+0x38>
    80007b10:	00060593          	mv	a1,a2
    80007b14:	0006861b          	sext.w	a2,a3
    80007b18:	00002097          	auipc	ra,0x2
    80007b1c:	c0c080e7          	jalr	-1012(ra) # 80009724 <__memmove>
    80007b20:	00813083          	ld	ra,8(sp)
    80007b24:	00013403          	ld	s0,0(sp)
    80007b28:	00000513          	li	a0,0
    80007b2c:	01010113          	addi	sp,sp,16
    80007b30:	00008067          	ret
    80007b34:	00003517          	auipc	a0,0x3
    80007b38:	db450513          	addi	a0,a0,-588 # 8000a8e8 <CONSOLE_STATUS+0x8d8>
    80007b3c:	00001097          	auipc	ra,0x1
    80007b40:	8e0080e7          	jalr	-1824(ra) # 8000841c <panic>

0000000080007b44 <trapinit>:
    80007b44:	ff010113          	addi	sp,sp,-16
    80007b48:	00813423          	sd	s0,8(sp)
    80007b4c:	01010413          	addi	s0,sp,16
    80007b50:	00813403          	ld	s0,8(sp)
    80007b54:	00003597          	auipc	a1,0x3
    80007b58:	dbc58593          	addi	a1,a1,-580 # 8000a910 <CONSOLE_STATUS+0x900>
    80007b5c:	0000a517          	auipc	a0,0xa
    80007b60:	88450513          	addi	a0,a0,-1916 # 800113e0 <tickslock>
    80007b64:	01010113          	addi	sp,sp,16
    80007b68:	00001317          	auipc	t1,0x1
    80007b6c:	5c030067          	jr	1472(t1) # 80009128 <initlock>

0000000080007b70 <trapinithart>:
    80007b70:	ff010113          	addi	sp,sp,-16
    80007b74:	00813423          	sd	s0,8(sp)
    80007b78:	01010413          	addi	s0,sp,16
    80007b7c:	00000797          	auipc	a5,0x0
    80007b80:	2f478793          	addi	a5,a5,756 # 80007e70 <kernelvec>
    80007b84:	10579073          	csrw	stvec,a5
    80007b88:	00813403          	ld	s0,8(sp)
    80007b8c:	01010113          	addi	sp,sp,16
    80007b90:	00008067          	ret

0000000080007b94 <usertrap>:
    80007b94:	ff010113          	addi	sp,sp,-16
    80007b98:	00813423          	sd	s0,8(sp)
    80007b9c:	01010413          	addi	s0,sp,16
    80007ba0:	00813403          	ld	s0,8(sp)
    80007ba4:	01010113          	addi	sp,sp,16
    80007ba8:	00008067          	ret

0000000080007bac <usertrapret>:
    80007bac:	ff010113          	addi	sp,sp,-16
    80007bb0:	00813423          	sd	s0,8(sp)
    80007bb4:	01010413          	addi	s0,sp,16
    80007bb8:	00813403          	ld	s0,8(sp)
    80007bbc:	01010113          	addi	sp,sp,16
    80007bc0:	00008067          	ret

0000000080007bc4 <kerneltrap>:
    80007bc4:	fe010113          	addi	sp,sp,-32
    80007bc8:	00813823          	sd	s0,16(sp)
    80007bcc:	00113c23          	sd	ra,24(sp)
    80007bd0:	00913423          	sd	s1,8(sp)
    80007bd4:	02010413          	addi	s0,sp,32
    80007bd8:	142025f3          	csrr	a1,scause
    80007bdc:	100027f3          	csrr	a5,sstatus
    80007be0:	0027f793          	andi	a5,a5,2
    80007be4:	10079c63          	bnez	a5,80007cfc <kerneltrap+0x138>
    80007be8:	142027f3          	csrr	a5,scause
    80007bec:	0207ce63          	bltz	a5,80007c28 <kerneltrap+0x64>
    80007bf0:	00003517          	auipc	a0,0x3
    80007bf4:	d6850513          	addi	a0,a0,-664 # 8000a958 <CONSOLE_STATUS+0x948>
    80007bf8:	00001097          	auipc	ra,0x1
    80007bfc:	880080e7          	jalr	-1920(ra) # 80008478 <__printf>
    80007c00:	141025f3          	csrr	a1,sepc
    80007c04:	14302673          	csrr	a2,stval
    80007c08:	00003517          	auipc	a0,0x3
    80007c0c:	d6050513          	addi	a0,a0,-672 # 8000a968 <CONSOLE_STATUS+0x958>
    80007c10:	00001097          	auipc	ra,0x1
    80007c14:	868080e7          	jalr	-1944(ra) # 80008478 <__printf>
    80007c18:	00003517          	auipc	a0,0x3
    80007c1c:	d6850513          	addi	a0,a0,-664 # 8000a980 <CONSOLE_STATUS+0x970>
    80007c20:	00000097          	auipc	ra,0x0
    80007c24:	7fc080e7          	jalr	2044(ra) # 8000841c <panic>
    80007c28:	0ff7f713          	andi	a4,a5,255
    80007c2c:	00900693          	li	a3,9
    80007c30:	04d70063          	beq	a4,a3,80007c70 <kerneltrap+0xac>
    80007c34:	fff00713          	li	a4,-1
    80007c38:	03f71713          	slli	a4,a4,0x3f
    80007c3c:	00170713          	addi	a4,a4,1
    80007c40:	fae798e3          	bne	a5,a4,80007bf0 <kerneltrap+0x2c>
    80007c44:	00000097          	auipc	ra,0x0
    80007c48:	e00080e7          	jalr	-512(ra) # 80007a44 <cpuid>
    80007c4c:	06050663          	beqz	a0,80007cb8 <kerneltrap+0xf4>
    80007c50:	144027f3          	csrr	a5,sip
    80007c54:	ffd7f793          	andi	a5,a5,-3
    80007c58:	14479073          	csrw	sip,a5
    80007c5c:	01813083          	ld	ra,24(sp)
    80007c60:	01013403          	ld	s0,16(sp)
    80007c64:	00813483          	ld	s1,8(sp)
    80007c68:	02010113          	addi	sp,sp,32
    80007c6c:	00008067          	ret
    80007c70:	00000097          	auipc	ra,0x0
    80007c74:	3c4080e7          	jalr	964(ra) # 80008034 <plic_claim>
    80007c78:	00a00793          	li	a5,10
    80007c7c:	00050493          	mv	s1,a0
    80007c80:	06f50863          	beq	a0,a5,80007cf0 <kerneltrap+0x12c>
    80007c84:	fc050ce3          	beqz	a0,80007c5c <kerneltrap+0x98>
    80007c88:	00050593          	mv	a1,a0
    80007c8c:	00003517          	auipc	a0,0x3
    80007c90:	cac50513          	addi	a0,a0,-852 # 8000a938 <CONSOLE_STATUS+0x928>
    80007c94:	00000097          	auipc	ra,0x0
    80007c98:	7e4080e7          	jalr	2020(ra) # 80008478 <__printf>
    80007c9c:	01013403          	ld	s0,16(sp)
    80007ca0:	01813083          	ld	ra,24(sp)
    80007ca4:	00048513          	mv	a0,s1
    80007ca8:	00813483          	ld	s1,8(sp)
    80007cac:	02010113          	addi	sp,sp,32
    80007cb0:	00000317          	auipc	t1,0x0
    80007cb4:	3bc30067          	jr	956(t1) # 8000806c <plic_complete>
    80007cb8:	00009517          	auipc	a0,0x9
    80007cbc:	72850513          	addi	a0,a0,1832 # 800113e0 <tickslock>
    80007cc0:	00001097          	auipc	ra,0x1
    80007cc4:	48c080e7          	jalr	1164(ra) # 8000914c <acquire>
    80007cc8:	00005717          	auipc	a4,0x5
    80007ccc:	ecc70713          	addi	a4,a4,-308 # 8000cb94 <ticks>
    80007cd0:	00072783          	lw	a5,0(a4)
    80007cd4:	00009517          	auipc	a0,0x9
    80007cd8:	70c50513          	addi	a0,a0,1804 # 800113e0 <tickslock>
    80007cdc:	0017879b          	addiw	a5,a5,1
    80007ce0:	00f72023          	sw	a5,0(a4)
    80007ce4:	00001097          	auipc	ra,0x1
    80007ce8:	534080e7          	jalr	1332(ra) # 80009218 <release>
    80007cec:	f65ff06f          	j	80007c50 <kerneltrap+0x8c>
    80007cf0:	00001097          	auipc	ra,0x1
    80007cf4:	090080e7          	jalr	144(ra) # 80008d80 <uartintr>
    80007cf8:	fa5ff06f          	j	80007c9c <kerneltrap+0xd8>
    80007cfc:	00003517          	auipc	a0,0x3
    80007d00:	c1c50513          	addi	a0,a0,-996 # 8000a918 <CONSOLE_STATUS+0x908>
    80007d04:	00000097          	auipc	ra,0x0
    80007d08:	718080e7          	jalr	1816(ra) # 8000841c <panic>

0000000080007d0c <clockintr>:
    80007d0c:	fe010113          	addi	sp,sp,-32
    80007d10:	00813823          	sd	s0,16(sp)
    80007d14:	00913423          	sd	s1,8(sp)
    80007d18:	00113c23          	sd	ra,24(sp)
    80007d1c:	02010413          	addi	s0,sp,32
    80007d20:	00009497          	auipc	s1,0x9
    80007d24:	6c048493          	addi	s1,s1,1728 # 800113e0 <tickslock>
    80007d28:	00048513          	mv	a0,s1
    80007d2c:	00001097          	auipc	ra,0x1
    80007d30:	420080e7          	jalr	1056(ra) # 8000914c <acquire>
    80007d34:	00005717          	auipc	a4,0x5
    80007d38:	e6070713          	addi	a4,a4,-416 # 8000cb94 <ticks>
    80007d3c:	00072783          	lw	a5,0(a4)
    80007d40:	01013403          	ld	s0,16(sp)
    80007d44:	01813083          	ld	ra,24(sp)
    80007d48:	00048513          	mv	a0,s1
    80007d4c:	0017879b          	addiw	a5,a5,1
    80007d50:	00813483          	ld	s1,8(sp)
    80007d54:	00f72023          	sw	a5,0(a4)
    80007d58:	02010113          	addi	sp,sp,32
    80007d5c:	00001317          	auipc	t1,0x1
    80007d60:	4bc30067          	jr	1212(t1) # 80009218 <release>

0000000080007d64 <devintr>:
    80007d64:	142027f3          	csrr	a5,scause
    80007d68:	00000513          	li	a0,0
    80007d6c:	0007c463          	bltz	a5,80007d74 <devintr+0x10>
    80007d70:	00008067          	ret
    80007d74:	fe010113          	addi	sp,sp,-32
    80007d78:	00813823          	sd	s0,16(sp)
    80007d7c:	00113c23          	sd	ra,24(sp)
    80007d80:	00913423          	sd	s1,8(sp)
    80007d84:	02010413          	addi	s0,sp,32
    80007d88:	0ff7f713          	andi	a4,a5,255
    80007d8c:	00900693          	li	a3,9
    80007d90:	04d70c63          	beq	a4,a3,80007de8 <devintr+0x84>
    80007d94:	fff00713          	li	a4,-1
    80007d98:	03f71713          	slli	a4,a4,0x3f
    80007d9c:	00170713          	addi	a4,a4,1
    80007da0:	00e78c63          	beq	a5,a4,80007db8 <devintr+0x54>
    80007da4:	01813083          	ld	ra,24(sp)
    80007da8:	01013403          	ld	s0,16(sp)
    80007dac:	00813483          	ld	s1,8(sp)
    80007db0:	02010113          	addi	sp,sp,32
    80007db4:	00008067          	ret
    80007db8:	00000097          	auipc	ra,0x0
    80007dbc:	c8c080e7          	jalr	-884(ra) # 80007a44 <cpuid>
    80007dc0:	06050663          	beqz	a0,80007e2c <devintr+0xc8>
    80007dc4:	144027f3          	csrr	a5,sip
    80007dc8:	ffd7f793          	andi	a5,a5,-3
    80007dcc:	14479073          	csrw	sip,a5
    80007dd0:	01813083          	ld	ra,24(sp)
    80007dd4:	01013403          	ld	s0,16(sp)
    80007dd8:	00813483          	ld	s1,8(sp)
    80007ddc:	00200513          	li	a0,2
    80007de0:	02010113          	addi	sp,sp,32
    80007de4:	00008067          	ret
    80007de8:	00000097          	auipc	ra,0x0
    80007dec:	24c080e7          	jalr	588(ra) # 80008034 <plic_claim>
    80007df0:	00a00793          	li	a5,10
    80007df4:	00050493          	mv	s1,a0
    80007df8:	06f50663          	beq	a0,a5,80007e64 <devintr+0x100>
    80007dfc:	00100513          	li	a0,1
    80007e00:	fa0482e3          	beqz	s1,80007da4 <devintr+0x40>
    80007e04:	00048593          	mv	a1,s1
    80007e08:	00003517          	auipc	a0,0x3
    80007e0c:	b3050513          	addi	a0,a0,-1232 # 8000a938 <CONSOLE_STATUS+0x928>
    80007e10:	00000097          	auipc	ra,0x0
    80007e14:	668080e7          	jalr	1640(ra) # 80008478 <__printf>
    80007e18:	00048513          	mv	a0,s1
    80007e1c:	00000097          	auipc	ra,0x0
    80007e20:	250080e7          	jalr	592(ra) # 8000806c <plic_complete>
    80007e24:	00100513          	li	a0,1
    80007e28:	f7dff06f          	j	80007da4 <devintr+0x40>
    80007e2c:	00009517          	auipc	a0,0x9
    80007e30:	5b450513          	addi	a0,a0,1460 # 800113e0 <tickslock>
    80007e34:	00001097          	auipc	ra,0x1
    80007e38:	318080e7          	jalr	792(ra) # 8000914c <acquire>
    80007e3c:	00005717          	auipc	a4,0x5
    80007e40:	d5870713          	addi	a4,a4,-680 # 8000cb94 <ticks>
    80007e44:	00072783          	lw	a5,0(a4)
    80007e48:	00009517          	auipc	a0,0x9
    80007e4c:	59850513          	addi	a0,a0,1432 # 800113e0 <tickslock>
    80007e50:	0017879b          	addiw	a5,a5,1
    80007e54:	00f72023          	sw	a5,0(a4)
    80007e58:	00001097          	auipc	ra,0x1
    80007e5c:	3c0080e7          	jalr	960(ra) # 80009218 <release>
    80007e60:	f65ff06f          	j	80007dc4 <devintr+0x60>
    80007e64:	00001097          	auipc	ra,0x1
    80007e68:	f1c080e7          	jalr	-228(ra) # 80008d80 <uartintr>
    80007e6c:	fadff06f          	j	80007e18 <devintr+0xb4>

0000000080007e70 <kernelvec>:
    80007e70:	f0010113          	addi	sp,sp,-256
    80007e74:	00113023          	sd	ra,0(sp)
    80007e78:	00213423          	sd	sp,8(sp)
    80007e7c:	00313823          	sd	gp,16(sp)
    80007e80:	00413c23          	sd	tp,24(sp)
    80007e84:	02513023          	sd	t0,32(sp)
    80007e88:	02613423          	sd	t1,40(sp)
    80007e8c:	02713823          	sd	t2,48(sp)
    80007e90:	02813c23          	sd	s0,56(sp)
    80007e94:	04913023          	sd	s1,64(sp)
    80007e98:	04a13423          	sd	a0,72(sp)
    80007e9c:	04b13823          	sd	a1,80(sp)
    80007ea0:	04c13c23          	sd	a2,88(sp)
    80007ea4:	06d13023          	sd	a3,96(sp)
    80007ea8:	06e13423          	sd	a4,104(sp)
    80007eac:	06f13823          	sd	a5,112(sp)
    80007eb0:	07013c23          	sd	a6,120(sp)
    80007eb4:	09113023          	sd	a7,128(sp)
    80007eb8:	09213423          	sd	s2,136(sp)
    80007ebc:	09313823          	sd	s3,144(sp)
    80007ec0:	09413c23          	sd	s4,152(sp)
    80007ec4:	0b513023          	sd	s5,160(sp)
    80007ec8:	0b613423          	sd	s6,168(sp)
    80007ecc:	0b713823          	sd	s7,176(sp)
    80007ed0:	0b813c23          	sd	s8,184(sp)
    80007ed4:	0d913023          	sd	s9,192(sp)
    80007ed8:	0da13423          	sd	s10,200(sp)
    80007edc:	0db13823          	sd	s11,208(sp)
    80007ee0:	0dc13c23          	sd	t3,216(sp)
    80007ee4:	0fd13023          	sd	t4,224(sp)
    80007ee8:	0fe13423          	sd	t5,232(sp)
    80007eec:	0ff13823          	sd	t6,240(sp)
    80007ef0:	cd5ff0ef          	jal	ra,80007bc4 <kerneltrap>
    80007ef4:	00013083          	ld	ra,0(sp)
    80007ef8:	00813103          	ld	sp,8(sp)
    80007efc:	01013183          	ld	gp,16(sp)
    80007f00:	02013283          	ld	t0,32(sp)
    80007f04:	02813303          	ld	t1,40(sp)
    80007f08:	03013383          	ld	t2,48(sp)
    80007f0c:	03813403          	ld	s0,56(sp)
    80007f10:	04013483          	ld	s1,64(sp)
    80007f14:	04813503          	ld	a0,72(sp)
    80007f18:	05013583          	ld	a1,80(sp)
    80007f1c:	05813603          	ld	a2,88(sp)
    80007f20:	06013683          	ld	a3,96(sp)
    80007f24:	06813703          	ld	a4,104(sp)
    80007f28:	07013783          	ld	a5,112(sp)
    80007f2c:	07813803          	ld	a6,120(sp)
    80007f30:	08013883          	ld	a7,128(sp)
    80007f34:	08813903          	ld	s2,136(sp)
    80007f38:	09013983          	ld	s3,144(sp)
    80007f3c:	09813a03          	ld	s4,152(sp)
    80007f40:	0a013a83          	ld	s5,160(sp)
    80007f44:	0a813b03          	ld	s6,168(sp)
    80007f48:	0b013b83          	ld	s7,176(sp)
    80007f4c:	0b813c03          	ld	s8,184(sp)
    80007f50:	0c013c83          	ld	s9,192(sp)
    80007f54:	0c813d03          	ld	s10,200(sp)
    80007f58:	0d013d83          	ld	s11,208(sp)
    80007f5c:	0d813e03          	ld	t3,216(sp)
    80007f60:	0e013e83          	ld	t4,224(sp)
    80007f64:	0e813f03          	ld	t5,232(sp)
    80007f68:	0f013f83          	ld	t6,240(sp)
    80007f6c:	10010113          	addi	sp,sp,256
    80007f70:	10200073          	sret
    80007f74:	00000013          	nop
    80007f78:	00000013          	nop
    80007f7c:	00000013          	nop

0000000080007f80 <timervec>:
    80007f80:	34051573          	csrrw	a0,mscratch,a0
    80007f84:	00b53023          	sd	a1,0(a0)
    80007f88:	00c53423          	sd	a2,8(a0)
    80007f8c:	00d53823          	sd	a3,16(a0)
    80007f90:	01853583          	ld	a1,24(a0)
    80007f94:	02053603          	ld	a2,32(a0)
    80007f98:	0005b683          	ld	a3,0(a1)
    80007f9c:	00c686b3          	add	a3,a3,a2
    80007fa0:	00d5b023          	sd	a3,0(a1)
    80007fa4:	00200593          	li	a1,2
    80007fa8:	14459073          	csrw	sip,a1
    80007fac:	01053683          	ld	a3,16(a0)
    80007fb0:	00853603          	ld	a2,8(a0)
    80007fb4:	00053583          	ld	a1,0(a0)
    80007fb8:	34051573          	csrrw	a0,mscratch,a0
    80007fbc:	30200073          	mret

0000000080007fc0 <plicinit>:
    80007fc0:	ff010113          	addi	sp,sp,-16
    80007fc4:	00813423          	sd	s0,8(sp)
    80007fc8:	01010413          	addi	s0,sp,16
    80007fcc:	00813403          	ld	s0,8(sp)
    80007fd0:	0c0007b7          	lui	a5,0xc000
    80007fd4:	00100713          	li	a4,1
    80007fd8:	02e7a423          	sw	a4,40(a5) # c000028 <_entry-0x73ffffd8>
    80007fdc:	00e7a223          	sw	a4,4(a5)
    80007fe0:	01010113          	addi	sp,sp,16
    80007fe4:	00008067          	ret

0000000080007fe8 <plicinithart>:
    80007fe8:	ff010113          	addi	sp,sp,-16
    80007fec:	00813023          	sd	s0,0(sp)
    80007ff0:	00113423          	sd	ra,8(sp)
    80007ff4:	01010413          	addi	s0,sp,16
    80007ff8:	00000097          	auipc	ra,0x0
    80007ffc:	a4c080e7          	jalr	-1460(ra) # 80007a44 <cpuid>
    80008000:	0085171b          	slliw	a4,a0,0x8
    80008004:	0c0027b7          	lui	a5,0xc002
    80008008:	00e787b3          	add	a5,a5,a4
    8000800c:	40200713          	li	a4,1026
    80008010:	08e7a023          	sw	a4,128(a5) # c002080 <_entry-0x73ffdf80>
    80008014:	00813083          	ld	ra,8(sp)
    80008018:	00013403          	ld	s0,0(sp)
    8000801c:	00d5151b          	slliw	a0,a0,0xd
    80008020:	0c2017b7          	lui	a5,0xc201
    80008024:	00a78533          	add	a0,a5,a0
    80008028:	00052023          	sw	zero,0(a0)
    8000802c:	01010113          	addi	sp,sp,16
    80008030:	00008067          	ret

0000000080008034 <plic_claim>:
    80008034:	ff010113          	addi	sp,sp,-16
    80008038:	00813023          	sd	s0,0(sp)
    8000803c:	00113423          	sd	ra,8(sp)
    80008040:	01010413          	addi	s0,sp,16
    80008044:	00000097          	auipc	ra,0x0
    80008048:	a00080e7          	jalr	-1536(ra) # 80007a44 <cpuid>
    8000804c:	00813083          	ld	ra,8(sp)
    80008050:	00013403          	ld	s0,0(sp)
    80008054:	00d5151b          	slliw	a0,a0,0xd
    80008058:	0c2017b7          	lui	a5,0xc201
    8000805c:	00a78533          	add	a0,a5,a0
    80008060:	00452503          	lw	a0,4(a0)
    80008064:	01010113          	addi	sp,sp,16
    80008068:	00008067          	ret

000000008000806c <plic_complete>:
    8000806c:	fe010113          	addi	sp,sp,-32
    80008070:	00813823          	sd	s0,16(sp)
    80008074:	00913423          	sd	s1,8(sp)
    80008078:	00113c23          	sd	ra,24(sp)
    8000807c:	02010413          	addi	s0,sp,32
    80008080:	00050493          	mv	s1,a0
    80008084:	00000097          	auipc	ra,0x0
    80008088:	9c0080e7          	jalr	-1600(ra) # 80007a44 <cpuid>
    8000808c:	01813083          	ld	ra,24(sp)
    80008090:	01013403          	ld	s0,16(sp)
    80008094:	00d5179b          	slliw	a5,a0,0xd
    80008098:	0c201737          	lui	a4,0xc201
    8000809c:	00f707b3          	add	a5,a4,a5
    800080a0:	0097a223          	sw	s1,4(a5) # c201004 <_entry-0x73dfeffc>
    800080a4:	00813483          	ld	s1,8(sp)
    800080a8:	02010113          	addi	sp,sp,32
    800080ac:	00008067          	ret

00000000800080b0 <consolewrite>:
    800080b0:	fb010113          	addi	sp,sp,-80
    800080b4:	04813023          	sd	s0,64(sp)
    800080b8:	04113423          	sd	ra,72(sp)
    800080bc:	02913c23          	sd	s1,56(sp)
    800080c0:	03213823          	sd	s2,48(sp)
    800080c4:	03313423          	sd	s3,40(sp)
    800080c8:	03413023          	sd	s4,32(sp)
    800080cc:	01513c23          	sd	s5,24(sp)
    800080d0:	05010413          	addi	s0,sp,80
    800080d4:	06c05c63          	blez	a2,8000814c <consolewrite+0x9c>
    800080d8:	00060993          	mv	s3,a2
    800080dc:	00050a13          	mv	s4,a0
    800080e0:	00058493          	mv	s1,a1
    800080e4:	00000913          	li	s2,0
    800080e8:	fff00a93          	li	s5,-1
    800080ec:	01c0006f          	j	80008108 <consolewrite+0x58>
    800080f0:	fbf44503          	lbu	a0,-65(s0)
    800080f4:	0019091b          	addiw	s2,s2,1
    800080f8:	00148493          	addi	s1,s1,1
    800080fc:	00001097          	auipc	ra,0x1
    80008100:	a9c080e7          	jalr	-1380(ra) # 80008b98 <uartputc>
    80008104:	03298063          	beq	s3,s2,80008124 <consolewrite+0x74>
    80008108:	00048613          	mv	a2,s1
    8000810c:	00100693          	li	a3,1
    80008110:	000a0593          	mv	a1,s4
    80008114:	fbf40513          	addi	a0,s0,-65
    80008118:	00000097          	auipc	ra,0x0
    8000811c:	9e4080e7          	jalr	-1564(ra) # 80007afc <either_copyin>
    80008120:	fd5518e3          	bne	a0,s5,800080f0 <consolewrite+0x40>
    80008124:	04813083          	ld	ra,72(sp)
    80008128:	04013403          	ld	s0,64(sp)
    8000812c:	03813483          	ld	s1,56(sp)
    80008130:	02813983          	ld	s3,40(sp)
    80008134:	02013a03          	ld	s4,32(sp)
    80008138:	01813a83          	ld	s5,24(sp)
    8000813c:	00090513          	mv	a0,s2
    80008140:	03013903          	ld	s2,48(sp)
    80008144:	05010113          	addi	sp,sp,80
    80008148:	00008067          	ret
    8000814c:	00000913          	li	s2,0
    80008150:	fd5ff06f          	j	80008124 <consolewrite+0x74>

0000000080008154 <consoleread>:
    80008154:	f9010113          	addi	sp,sp,-112
    80008158:	06813023          	sd	s0,96(sp)
    8000815c:	04913c23          	sd	s1,88(sp)
    80008160:	05213823          	sd	s2,80(sp)
    80008164:	05313423          	sd	s3,72(sp)
    80008168:	05413023          	sd	s4,64(sp)
    8000816c:	03513c23          	sd	s5,56(sp)
    80008170:	03613823          	sd	s6,48(sp)
    80008174:	03713423          	sd	s7,40(sp)
    80008178:	03813023          	sd	s8,32(sp)
    8000817c:	06113423          	sd	ra,104(sp)
    80008180:	01913c23          	sd	s9,24(sp)
    80008184:	07010413          	addi	s0,sp,112
    80008188:	00060b93          	mv	s7,a2
    8000818c:	00050913          	mv	s2,a0
    80008190:	00058c13          	mv	s8,a1
    80008194:	00060b1b          	sext.w	s6,a2
    80008198:	00009497          	auipc	s1,0x9
    8000819c:	27048493          	addi	s1,s1,624 # 80011408 <cons>
    800081a0:	00400993          	li	s3,4
    800081a4:	fff00a13          	li	s4,-1
    800081a8:	00a00a93          	li	s5,10
    800081ac:	05705e63          	blez	s7,80008208 <consoleread+0xb4>
    800081b0:	09c4a703          	lw	a4,156(s1)
    800081b4:	0984a783          	lw	a5,152(s1)
    800081b8:	0007071b          	sext.w	a4,a4
    800081bc:	08e78463          	beq	a5,a4,80008244 <consoleread+0xf0>
    800081c0:	07f7f713          	andi	a4,a5,127
    800081c4:	00e48733          	add	a4,s1,a4
    800081c8:	01874703          	lbu	a4,24(a4) # c201018 <_entry-0x73dfefe8>
    800081cc:	0017869b          	addiw	a3,a5,1
    800081d0:	08d4ac23          	sw	a3,152(s1)
    800081d4:	00070c9b          	sext.w	s9,a4
    800081d8:	0b370663          	beq	a4,s3,80008284 <consoleread+0x130>
    800081dc:	00100693          	li	a3,1
    800081e0:	f9f40613          	addi	a2,s0,-97
    800081e4:	000c0593          	mv	a1,s8
    800081e8:	00090513          	mv	a0,s2
    800081ec:	f8e40fa3          	sb	a4,-97(s0)
    800081f0:	00000097          	auipc	ra,0x0
    800081f4:	8c0080e7          	jalr	-1856(ra) # 80007ab0 <either_copyout>
    800081f8:	01450863          	beq	a0,s4,80008208 <consoleread+0xb4>
    800081fc:	001c0c13          	addi	s8,s8,1
    80008200:	fffb8b9b          	addiw	s7,s7,-1
    80008204:	fb5c94e3          	bne	s9,s5,800081ac <consoleread+0x58>
    80008208:	000b851b          	sext.w	a0,s7
    8000820c:	06813083          	ld	ra,104(sp)
    80008210:	06013403          	ld	s0,96(sp)
    80008214:	05813483          	ld	s1,88(sp)
    80008218:	05013903          	ld	s2,80(sp)
    8000821c:	04813983          	ld	s3,72(sp)
    80008220:	04013a03          	ld	s4,64(sp)
    80008224:	03813a83          	ld	s5,56(sp)
    80008228:	02813b83          	ld	s7,40(sp)
    8000822c:	02013c03          	ld	s8,32(sp)
    80008230:	01813c83          	ld	s9,24(sp)
    80008234:	40ab053b          	subw	a0,s6,a0
    80008238:	03013b03          	ld	s6,48(sp)
    8000823c:	07010113          	addi	sp,sp,112
    80008240:	00008067          	ret
    80008244:	00001097          	auipc	ra,0x1
    80008248:	1d8080e7          	jalr	472(ra) # 8000941c <push_on>
    8000824c:	0984a703          	lw	a4,152(s1)
    80008250:	09c4a783          	lw	a5,156(s1)
    80008254:	0007879b          	sext.w	a5,a5
    80008258:	fef70ce3          	beq	a4,a5,80008250 <consoleread+0xfc>
    8000825c:	00001097          	auipc	ra,0x1
    80008260:	234080e7          	jalr	564(ra) # 80009490 <pop_on>
    80008264:	0984a783          	lw	a5,152(s1)
    80008268:	07f7f713          	andi	a4,a5,127
    8000826c:	00e48733          	add	a4,s1,a4
    80008270:	01874703          	lbu	a4,24(a4)
    80008274:	0017869b          	addiw	a3,a5,1
    80008278:	08d4ac23          	sw	a3,152(s1)
    8000827c:	00070c9b          	sext.w	s9,a4
    80008280:	f5371ee3          	bne	a4,s3,800081dc <consoleread+0x88>
    80008284:	000b851b          	sext.w	a0,s7
    80008288:	f96bf2e3          	bgeu	s7,s6,8000820c <consoleread+0xb8>
    8000828c:	08f4ac23          	sw	a5,152(s1)
    80008290:	f7dff06f          	j	8000820c <consoleread+0xb8>

0000000080008294 <consputc>:
    80008294:	10000793          	li	a5,256
    80008298:	00f50663          	beq	a0,a5,800082a4 <consputc+0x10>
    8000829c:	00001317          	auipc	t1,0x1
    800082a0:	9f430067          	jr	-1548(t1) # 80008c90 <uartputc_sync>
    800082a4:	ff010113          	addi	sp,sp,-16
    800082a8:	00113423          	sd	ra,8(sp)
    800082ac:	00813023          	sd	s0,0(sp)
    800082b0:	01010413          	addi	s0,sp,16
    800082b4:	00800513          	li	a0,8
    800082b8:	00001097          	auipc	ra,0x1
    800082bc:	9d8080e7          	jalr	-1576(ra) # 80008c90 <uartputc_sync>
    800082c0:	02000513          	li	a0,32
    800082c4:	00001097          	auipc	ra,0x1
    800082c8:	9cc080e7          	jalr	-1588(ra) # 80008c90 <uartputc_sync>
    800082cc:	00013403          	ld	s0,0(sp)
    800082d0:	00813083          	ld	ra,8(sp)
    800082d4:	00800513          	li	a0,8
    800082d8:	01010113          	addi	sp,sp,16
    800082dc:	00001317          	auipc	t1,0x1
    800082e0:	9b430067          	jr	-1612(t1) # 80008c90 <uartputc_sync>

00000000800082e4 <consoleintr>:
    800082e4:	fe010113          	addi	sp,sp,-32
    800082e8:	00813823          	sd	s0,16(sp)
    800082ec:	00913423          	sd	s1,8(sp)
    800082f0:	01213023          	sd	s2,0(sp)
    800082f4:	00113c23          	sd	ra,24(sp)
    800082f8:	02010413          	addi	s0,sp,32
    800082fc:	00009917          	auipc	s2,0x9
    80008300:	10c90913          	addi	s2,s2,268 # 80011408 <cons>
    80008304:	00050493          	mv	s1,a0
    80008308:	00090513          	mv	a0,s2
    8000830c:	00001097          	auipc	ra,0x1
    80008310:	e40080e7          	jalr	-448(ra) # 8000914c <acquire>
    80008314:	02048c63          	beqz	s1,8000834c <consoleintr+0x68>
    80008318:	0a092783          	lw	a5,160(s2)
    8000831c:	09892703          	lw	a4,152(s2)
    80008320:	07f00693          	li	a3,127
    80008324:	40e7873b          	subw	a4,a5,a4
    80008328:	02e6e263          	bltu	a3,a4,8000834c <consoleintr+0x68>
    8000832c:	00d00713          	li	a4,13
    80008330:	04e48063          	beq	s1,a4,80008370 <consoleintr+0x8c>
    80008334:	07f7f713          	andi	a4,a5,127
    80008338:	00e90733          	add	a4,s2,a4
    8000833c:	0017879b          	addiw	a5,a5,1
    80008340:	0af92023          	sw	a5,160(s2)
    80008344:	00970c23          	sb	s1,24(a4)
    80008348:	08f92e23          	sw	a5,156(s2)
    8000834c:	01013403          	ld	s0,16(sp)
    80008350:	01813083          	ld	ra,24(sp)
    80008354:	00813483          	ld	s1,8(sp)
    80008358:	00013903          	ld	s2,0(sp)
    8000835c:	00009517          	auipc	a0,0x9
    80008360:	0ac50513          	addi	a0,a0,172 # 80011408 <cons>
    80008364:	02010113          	addi	sp,sp,32
    80008368:	00001317          	auipc	t1,0x1
    8000836c:	eb030067          	jr	-336(t1) # 80009218 <release>
    80008370:	00a00493          	li	s1,10
    80008374:	fc1ff06f          	j	80008334 <consoleintr+0x50>

0000000080008378 <consoleinit>:
    80008378:	fe010113          	addi	sp,sp,-32
    8000837c:	00113c23          	sd	ra,24(sp)
    80008380:	00813823          	sd	s0,16(sp)
    80008384:	00913423          	sd	s1,8(sp)
    80008388:	02010413          	addi	s0,sp,32
    8000838c:	00009497          	auipc	s1,0x9
    80008390:	07c48493          	addi	s1,s1,124 # 80011408 <cons>
    80008394:	00048513          	mv	a0,s1
    80008398:	00002597          	auipc	a1,0x2
    8000839c:	5f858593          	addi	a1,a1,1528 # 8000a990 <CONSOLE_STATUS+0x980>
    800083a0:	00001097          	auipc	ra,0x1
    800083a4:	d88080e7          	jalr	-632(ra) # 80009128 <initlock>
    800083a8:	00000097          	auipc	ra,0x0
    800083ac:	7ac080e7          	jalr	1964(ra) # 80008b54 <uartinit>
    800083b0:	01813083          	ld	ra,24(sp)
    800083b4:	01013403          	ld	s0,16(sp)
    800083b8:	00000797          	auipc	a5,0x0
    800083bc:	d9c78793          	addi	a5,a5,-612 # 80008154 <consoleread>
    800083c0:	0af4bc23          	sd	a5,184(s1)
    800083c4:	00000797          	auipc	a5,0x0
    800083c8:	cec78793          	addi	a5,a5,-788 # 800080b0 <consolewrite>
    800083cc:	0cf4b023          	sd	a5,192(s1)
    800083d0:	00813483          	ld	s1,8(sp)
    800083d4:	02010113          	addi	sp,sp,32
    800083d8:	00008067          	ret

00000000800083dc <console_read>:
    800083dc:	ff010113          	addi	sp,sp,-16
    800083e0:	00813423          	sd	s0,8(sp)
    800083e4:	01010413          	addi	s0,sp,16
    800083e8:	00813403          	ld	s0,8(sp)
    800083ec:	00009317          	auipc	t1,0x9
    800083f0:	0d433303          	ld	t1,212(t1) # 800114c0 <devsw+0x10>
    800083f4:	01010113          	addi	sp,sp,16
    800083f8:	00030067          	jr	t1

00000000800083fc <console_write>:
    800083fc:	ff010113          	addi	sp,sp,-16
    80008400:	00813423          	sd	s0,8(sp)
    80008404:	01010413          	addi	s0,sp,16
    80008408:	00813403          	ld	s0,8(sp)
    8000840c:	00009317          	auipc	t1,0x9
    80008410:	0bc33303          	ld	t1,188(t1) # 800114c8 <devsw+0x18>
    80008414:	01010113          	addi	sp,sp,16
    80008418:	00030067          	jr	t1

000000008000841c <panic>:
    8000841c:	fe010113          	addi	sp,sp,-32
    80008420:	00113c23          	sd	ra,24(sp)
    80008424:	00813823          	sd	s0,16(sp)
    80008428:	00913423          	sd	s1,8(sp)
    8000842c:	02010413          	addi	s0,sp,32
    80008430:	00050493          	mv	s1,a0
    80008434:	00002517          	auipc	a0,0x2
    80008438:	56450513          	addi	a0,a0,1380 # 8000a998 <CONSOLE_STATUS+0x988>
    8000843c:	00009797          	auipc	a5,0x9
    80008440:	1207a623          	sw	zero,300(a5) # 80011568 <pr+0x18>
    80008444:	00000097          	auipc	ra,0x0
    80008448:	034080e7          	jalr	52(ra) # 80008478 <__printf>
    8000844c:	00048513          	mv	a0,s1
    80008450:	00000097          	auipc	ra,0x0
    80008454:	028080e7          	jalr	40(ra) # 80008478 <__printf>
    80008458:	00002517          	auipc	a0,0x2
    8000845c:	2c850513          	addi	a0,a0,712 # 8000a720 <CONSOLE_STATUS+0x710>
    80008460:	00000097          	auipc	ra,0x0
    80008464:	018080e7          	jalr	24(ra) # 80008478 <__printf>
    80008468:	00100793          	li	a5,1
    8000846c:	00004717          	auipc	a4,0x4
    80008470:	72f72623          	sw	a5,1836(a4) # 8000cb98 <panicked>
    80008474:	0000006f          	j	80008474 <panic+0x58>

0000000080008478 <__printf>:
    80008478:	f3010113          	addi	sp,sp,-208
    8000847c:	08813023          	sd	s0,128(sp)
    80008480:	07313423          	sd	s3,104(sp)
    80008484:	09010413          	addi	s0,sp,144
    80008488:	05813023          	sd	s8,64(sp)
    8000848c:	08113423          	sd	ra,136(sp)
    80008490:	06913c23          	sd	s1,120(sp)
    80008494:	07213823          	sd	s2,112(sp)
    80008498:	07413023          	sd	s4,96(sp)
    8000849c:	05513c23          	sd	s5,88(sp)
    800084a0:	05613823          	sd	s6,80(sp)
    800084a4:	05713423          	sd	s7,72(sp)
    800084a8:	03913c23          	sd	s9,56(sp)
    800084ac:	03a13823          	sd	s10,48(sp)
    800084b0:	03b13423          	sd	s11,40(sp)
    800084b4:	00009317          	auipc	t1,0x9
    800084b8:	09c30313          	addi	t1,t1,156 # 80011550 <pr>
    800084bc:	01832c03          	lw	s8,24(t1)
    800084c0:	00b43423          	sd	a1,8(s0)
    800084c4:	00c43823          	sd	a2,16(s0)
    800084c8:	00d43c23          	sd	a3,24(s0)
    800084cc:	02e43023          	sd	a4,32(s0)
    800084d0:	02f43423          	sd	a5,40(s0)
    800084d4:	03043823          	sd	a6,48(s0)
    800084d8:	03143c23          	sd	a7,56(s0)
    800084dc:	00050993          	mv	s3,a0
    800084e0:	4a0c1663          	bnez	s8,8000898c <__printf+0x514>
    800084e4:	60098c63          	beqz	s3,80008afc <__printf+0x684>
    800084e8:	0009c503          	lbu	a0,0(s3)
    800084ec:	00840793          	addi	a5,s0,8
    800084f0:	f6f43c23          	sd	a5,-136(s0)
    800084f4:	00000493          	li	s1,0
    800084f8:	22050063          	beqz	a0,80008718 <__printf+0x2a0>
    800084fc:	00002a37          	lui	s4,0x2
    80008500:	00018ab7          	lui	s5,0x18
    80008504:	000f4b37          	lui	s6,0xf4
    80008508:	00989bb7          	lui	s7,0x989
    8000850c:	70fa0a13          	addi	s4,s4,1807 # 270f <_entry-0x7fffd8f1>
    80008510:	69fa8a93          	addi	s5,s5,1695 # 1869f <_entry-0x7ffe7961>
    80008514:	23fb0b13          	addi	s6,s6,575 # f423f <_entry-0x7ff0bdc1>
    80008518:	67fb8b93          	addi	s7,s7,1663 # 98967f <_entry-0x7f676981>
    8000851c:	00148c9b          	addiw	s9,s1,1
    80008520:	02500793          	li	a5,37
    80008524:	01998933          	add	s2,s3,s9
    80008528:	38f51263          	bne	a0,a5,800088ac <__printf+0x434>
    8000852c:	00094783          	lbu	a5,0(s2)
    80008530:	00078c9b          	sext.w	s9,a5
    80008534:	1e078263          	beqz	a5,80008718 <__printf+0x2a0>
    80008538:	0024849b          	addiw	s1,s1,2
    8000853c:	07000713          	li	a4,112
    80008540:	00998933          	add	s2,s3,s1
    80008544:	38e78a63          	beq	a5,a4,800088d8 <__printf+0x460>
    80008548:	20f76863          	bltu	a4,a5,80008758 <__printf+0x2e0>
    8000854c:	42a78863          	beq	a5,a0,8000897c <__printf+0x504>
    80008550:	06400713          	li	a4,100
    80008554:	40e79663          	bne	a5,a4,80008960 <__printf+0x4e8>
    80008558:	f7843783          	ld	a5,-136(s0)
    8000855c:	0007a603          	lw	a2,0(a5)
    80008560:	00878793          	addi	a5,a5,8
    80008564:	f6f43c23          	sd	a5,-136(s0)
    80008568:	42064a63          	bltz	a2,8000899c <__printf+0x524>
    8000856c:	00a00713          	li	a4,10
    80008570:	02e677bb          	remuw	a5,a2,a4
    80008574:	00002d97          	auipc	s11,0x2
    80008578:	44cd8d93          	addi	s11,s11,1100 # 8000a9c0 <digits>
    8000857c:	00900593          	li	a1,9
    80008580:	0006051b          	sext.w	a0,a2
    80008584:	00000c93          	li	s9,0
    80008588:	02079793          	slli	a5,a5,0x20
    8000858c:	0207d793          	srli	a5,a5,0x20
    80008590:	00fd87b3          	add	a5,s11,a5
    80008594:	0007c783          	lbu	a5,0(a5)
    80008598:	02e656bb          	divuw	a3,a2,a4
    8000859c:	f8f40023          	sb	a5,-128(s0)
    800085a0:	14c5d863          	bge	a1,a2,800086f0 <__printf+0x278>
    800085a4:	06300593          	li	a1,99
    800085a8:	00100c93          	li	s9,1
    800085ac:	02e6f7bb          	remuw	a5,a3,a4
    800085b0:	02079793          	slli	a5,a5,0x20
    800085b4:	0207d793          	srli	a5,a5,0x20
    800085b8:	00fd87b3          	add	a5,s11,a5
    800085bc:	0007c783          	lbu	a5,0(a5)
    800085c0:	02e6d73b          	divuw	a4,a3,a4
    800085c4:	f8f400a3          	sb	a5,-127(s0)
    800085c8:	12a5f463          	bgeu	a1,a0,800086f0 <__printf+0x278>
    800085cc:	00a00693          	li	a3,10
    800085d0:	00900593          	li	a1,9
    800085d4:	02d777bb          	remuw	a5,a4,a3
    800085d8:	02079793          	slli	a5,a5,0x20
    800085dc:	0207d793          	srli	a5,a5,0x20
    800085e0:	00fd87b3          	add	a5,s11,a5
    800085e4:	0007c503          	lbu	a0,0(a5)
    800085e8:	02d757bb          	divuw	a5,a4,a3
    800085ec:	f8a40123          	sb	a0,-126(s0)
    800085f0:	48e5f263          	bgeu	a1,a4,80008a74 <__printf+0x5fc>
    800085f4:	06300513          	li	a0,99
    800085f8:	02d7f5bb          	remuw	a1,a5,a3
    800085fc:	02059593          	slli	a1,a1,0x20
    80008600:	0205d593          	srli	a1,a1,0x20
    80008604:	00bd85b3          	add	a1,s11,a1
    80008608:	0005c583          	lbu	a1,0(a1)
    8000860c:	02d7d7bb          	divuw	a5,a5,a3
    80008610:	f8b401a3          	sb	a1,-125(s0)
    80008614:	48e57263          	bgeu	a0,a4,80008a98 <__printf+0x620>
    80008618:	3e700513          	li	a0,999
    8000861c:	02d7f5bb          	remuw	a1,a5,a3
    80008620:	02059593          	slli	a1,a1,0x20
    80008624:	0205d593          	srli	a1,a1,0x20
    80008628:	00bd85b3          	add	a1,s11,a1
    8000862c:	0005c583          	lbu	a1,0(a1)
    80008630:	02d7d7bb          	divuw	a5,a5,a3
    80008634:	f8b40223          	sb	a1,-124(s0)
    80008638:	46e57663          	bgeu	a0,a4,80008aa4 <__printf+0x62c>
    8000863c:	02d7f5bb          	remuw	a1,a5,a3
    80008640:	02059593          	slli	a1,a1,0x20
    80008644:	0205d593          	srli	a1,a1,0x20
    80008648:	00bd85b3          	add	a1,s11,a1
    8000864c:	0005c583          	lbu	a1,0(a1)
    80008650:	02d7d7bb          	divuw	a5,a5,a3
    80008654:	f8b402a3          	sb	a1,-123(s0)
    80008658:	46ea7863          	bgeu	s4,a4,80008ac8 <__printf+0x650>
    8000865c:	02d7f5bb          	remuw	a1,a5,a3
    80008660:	02059593          	slli	a1,a1,0x20
    80008664:	0205d593          	srli	a1,a1,0x20
    80008668:	00bd85b3          	add	a1,s11,a1
    8000866c:	0005c583          	lbu	a1,0(a1)
    80008670:	02d7d7bb          	divuw	a5,a5,a3
    80008674:	f8b40323          	sb	a1,-122(s0)
    80008678:	3eeaf863          	bgeu	s5,a4,80008a68 <__printf+0x5f0>
    8000867c:	02d7f5bb          	remuw	a1,a5,a3
    80008680:	02059593          	slli	a1,a1,0x20
    80008684:	0205d593          	srli	a1,a1,0x20
    80008688:	00bd85b3          	add	a1,s11,a1
    8000868c:	0005c583          	lbu	a1,0(a1)
    80008690:	02d7d7bb          	divuw	a5,a5,a3
    80008694:	f8b403a3          	sb	a1,-121(s0)
    80008698:	42eb7e63          	bgeu	s6,a4,80008ad4 <__printf+0x65c>
    8000869c:	02d7f5bb          	remuw	a1,a5,a3
    800086a0:	02059593          	slli	a1,a1,0x20
    800086a4:	0205d593          	srli	a1,a1,0x20
    800086a8:	00bd85b3          	add	a1,s11,a1
    800086ac:	0005c583          	lbu	a1,0(a1)
    800086b0:	02d7d7bb          	divuw	a5,a5,a3
    800086b4:	f8b40423          	sb	a1,-120(s0)
    800086b8:	42ebfc63          	bgeu	s7,a4,80008af0 <__printf+0x678>
    800086bc:	02079793          	slli	a5,a5,0x20
    800086c0:	0207d793          	srli	a5,a5,0x20
    800086c4:	00fd8db3          	add	s11,s11,a5
    800086c8:	000dc703          	lbu	a4,0(s11)
    800086cc:	00a00793          	li	a5,10
    800086d0:	00900c93          	li	s9,9
    800086d4:	f8e404a3          	sb	a4,-119(s0)
    800086d8:	00065c63          	bgez	a2,800086f0 <__printf+0x278>
    800086dc:	f9040713          	addi	a4,s0,-112
    800086e0:	00f70733          	add	a4,a4,a5
    800086e4:	02d00693          	li	a3,45
    800086e8:	fed70823          	sb	a3,-16(a4)
    800086ec:	00078c93          	mv	s9,a5
    800086f0:	f8040793          	addi	a5,s0,-128
    800086f4:	01978cb3          	add	s9,a5,s9
    800086f8:	f7f40d13          	addi	s10,s0,-129
    800086fc:	000cc503          	lbu	a0,0(s9)
    80008700:	fffc8c93          	addi	s9,s9,-1
    80008704:	00000097          	auipc	ra,0x0
    80008708:	b90080e7          	jalr	-1136(ra) # 80008294 <consputc>
    8000870c:	ffac98e3          	bne	s9,s10,800086fc <__printf+0x284>
    80008710:	00094503          	lbu	a0,0(s2)
    80008714:	e00514e3          	bnez	a0,8000851c <__printf+0xa4>
    80008718:	1a0c1663          	bnez	s8,800088c4 <__printf+0x44c>
    8000871c:	08813083          	ld	ra,136(sp)
    80008720:	08013403          	ld	s0,128(sp)
    80008724:	07813483          	ld	s1,120(sp)
    80008728:	07013903          	ld	s2,112(sp)
    8000872c:	06813983          	ld	s3,104(sp)
    80008730:	06013a03          	ld	s4,96(sp)
    80008734:	05813a83          	ld	s5,88(sp)
    80008738:	05013b03          	ld	s6,80(sp)
    8000873c:	04813b83          	ld	s7,72(sp)
    80008740:	04013c03          	ld	s8,64(sp)
    80008744:	03813c83          	ld	s9,56(sp)
    80008748:	03013d03          	ld	s10,48(sp)
    8000874c:	02813d83          	ld	s11,40(sp)
    80008750:	0d010113          	addi	sp,sp,208
    80008754:	00008067          	ret
    80008758:	07300713          	li	a4,115
    8000875c:	1ce78a63          	beq	a5,a4,80008930 <__printf+0x4b8>
    80008760:	07800713          	li	a4,120
    80008764:	1ee79e63          	bne	a5,a4,80008960 <__printf+0x4e8>
    80008768:	f7843783          	ld	a5,-136(s0)
    8000876c:	0007a703          	lw	a4,0(a5)
    80008770:	00878793          	addi	a5,a5,8
    80008774:	f6f43c23          	sd	a5,-136(s0)
    80008778:	28074263          	bltz	a4,800089fc <__printf+0x584>
    8000877c:	00002d97          	auipc	s11,0x2
    80008780:	244d8d93          	addi	s11,s11,580 # 8000a9c0 <digits>
    80008784:	00f77793          	andi	a5,a4,15
    80008788:	00fd87b3          	add	a5,s11,a5
    8000878c:	0007c683          	lbu	a3,0(a5)
    80008790:	00f00613          	li	a2,15
    80008794:	0007079b          	sext.w	a5,a4
    80008798:	f8d40023          	sb	a3,-128(s0)
    8000879c:	0047559b          	srliw	a1,a4,0x4
    800087a0:	0047569b          	srliw	a3,a4,0x4
    800087a4:	00000c93          	li	s9,0
    800087a8:	0ee65063          	bge	a2,a4,80008888 <__printf+0x410>
    800087ac:	00f6f693          	andi	a3,a3,15
    800087b0:	00dd86b3          	add	a3,s11,a3
    800087b4:	0006c683          	lbu	a3,0(a3) # 2004000 <_entry-0x7dffc000>
    800087b8:	0087d79b          	srliw	a5,a5,0x8
    800087bc:	00100c93          	li	s9,1
    800087c0:	f8d400a3          	sb	a3,-127(s0)
    800087c4:	0cb67263          	bgeu	a2,a1,80008888 <__printf+0x410>
    800087c8:	00f7f693          	andi	a3,a5,15
    800087cc:	00dd86b3          	add	a3,s11,a3
    800087d0:	0006c583          	lbu	a1,0(a3)
    800087d4:	00f00613          	li	a2,15
    800087d8:	0047d69b          	srliw	a3,a5,0x4
    800087dc:	f8b40123          	sb	a1,-126(s0)
    800087e0:	0047d593          	srli	a1,a5,0x4
    800087e4:	28f67e63          	bgeu	a2,a5,80008a80 <__printf+0x608>
    800087e8:	00f6f693          	andi	a3,a3,15
    800087ec:	00dd86b3          	add	a3,s11,a3
    800087f0:	0006c503          	lbu	a0,0(a3)
    800087f4:	0087d813          	srli	a6,a5,0x8
    800087f8:	0087d69b          	srliw	a3,a5,0x8
    800087fc:	f8a401a3          	sb	a0,-125(s0)
    80008800:	28b67663          	bgeu	a2,a1,80008a8c <__printf+0x614>
    80008804:	00f6f693          	andi	a3,a3,15
    80008808:	00dd86b3          	add	a3,s11,a3
    8000880c:	0006c583          	lbu	a1,0(a3)
    80008810:	00c7d513          	srli	a0,a5,0xc
    80008814:	00c7d69b          	srliw	a3,a5,0xc
    80008818:	f8b40223          	sb	a1,-124(s0)
    8000881c:	29067a63          	bgeu	a2,a6,80008ab0 <__printf+0x638>
    80008820:	00f6f693          	andi	a3,a3,15
    80008824:	00dd86b3          	add	a3,s11,a3
    80008828:	0006c583          	lbu	a1,0(a3)
    8000882c:	0107d813          	srli	a6,a5,0x10
    80008830:	0107d69b          	srliw	a3,a5,0x10
    80008834:	f8b402a3          	sb	a1,-123(s0)
    80008838:	28a67263          	bgeu	a2,a0,80008abc <__printf+0x644>
    8000883c:	00f6f693          	andi	a3,a3,15
    80008840:	00dd86b3          	add	a3,s11,a3
    80008844:	0006c683          	lbu	a3,0(a3)
    80008848:	0147d79b          	srliw	a5,a5,0x14
    8000884c:	f8d40323          	sb	a3,-122(s0)
    80008850:	21067663          	bgeu	a2,a6,80008a5c <__printf+0x5e4>
    80008854:	02079793          	slli	a5,a5,0x20
    80008858:	0207d793          	srli	a5,a5,0x20
    8000885c:	00fd8db3          	add	s11,s11,a5
    80008860:	000dc683          	lbu	a3,0(s11)
    80008864:	00800793          	li	a5,8
    80008868:	00700c93          	li	s9,7
    8000886c:	f8d403a3          	sb	a3,-121(s0)
    80008870:	00075c63          	bgez	a4,80008888 <__printf+0x410>
    80008874:	f9040713          	addi	a4,s0,-112
    80008878:	00f70733          	add	a4,a4,a5
    8000887c:	02d00693          	li	a3,45
    80008880:	fed70823          	sb	a3,-16(a4)
    80008884:	00078c93          	mv	s9,a5
    80008888:	f8040793          	addi	a5,s0,-128
    8000888c:	01978cb3          	add	s9,a5,s9
    80008890:	f7f40d13          	addi	s10,s0,-129
    80008894:	000cc503          	lbu	a0,0(s9)
    80008898:	fffc8c93          	addi	s9,s9,-1
    8000889c:	00000097          	auipc	ra,0x0
    800088a0:	9f8080e7          	jalr	-1544(ra) # 80008294 <consputc>
    800088a4:	ff9d18e3          	bne	s10,s9,80008894 <__printf+0x41c>
    800088a8:	0100006f          	j	800088b8 <__printf+0x440>
    800088ac:	00000097          	auipc	ra,0x0
    800088b0:	9e8080e7          	jalr	-1560(ra) # 80008294 <consputc>
    800088b4:	000c8493          	mv	s1,s9
    800088b8:	00094503          	lbu	a0,0(s2)
    800088bc:	c60510e3          	bnez	a0,8000851c <__printf+0xa4>
    800088c0:	e40c0ee3          	beqz	s8,8000871c <__printf+0x2a4>
    800088c4:	00009517          	auipc	a0,0x9
    800088c8:	c8c50513          	addi	a0,a0,-884 # 80011550 <pr>
    800088cc:	00001097          	auipc	ra,0x1
    800088d0:	94c080e7          	jalr	-1716(ra) # 80009218 <release>
    800088d4:	e49ff06f          	j	8000871c <__printf+0x2a4>
    800088d8:	f7843783          	ld	a5,-136(s0)
    800088dc:	03000513          	li	a0,48
    800088e0:	01000d13          	li	s10,16
    800088e4:	00878713          	addi	a4,a5,8
    800088e8:	0007bc83          	ld	s9,0(a5)
    800088ec:	f6e43c23          	sd	a4,-136(s0)
    800088f0:	00000097          	auipc	ra,0x0
    800088f4:	9a4080e7          	jalr	-1628(ra) # 80008294 <consputc>
    800088f8:	07800513          	li	a0,120
    800088fc:	00000097          	auipc	ra,0x0
    80008900:	998080e7          	jalr	-1640(ra) # 80008294 <consputc>
    80008904:	00002d97          	auipc	s11,0x2
    80008908:	0bcd8d93          	addi	s11,s11,188 # 8000a9c0 <digits>
    8000890c:	03ccd793          	srli	a5,s9,0x3c
    80008910:	00fd87b3          	add	a5,s11,a5
    80008914:	0007c503          	lbu	a0,0(a5)
    80008918:	fffd0d1b          	addiw	s10,s10,-1
    8000891c:	004c9c93          	slli	s9,s9,0x4
    80008920:	00000097          	auipc	ra,0x0
    80008924:	974080e7          	jalr	-1676(ra) # 80008294 <consputc>
    80008928:	fe0d12e3          	bnez	s10,8000890c <__printf+0x494>
    8000892c:	f8dff06f          	j	800088b8 <__printf+0x440>
    80008930:	f7843783          	ld	a5,-136(s0)
    80008934:	0007bc83          	ld	s9,0(a5)
    80008938:	00878793          	addi	a5,a5,8
    8000893c:	f6f43c23          	sd	a5,-136(s0)
    80008940:	000c9a63          	bnez	s9,80008954 <__printf+0x4dc>
    80008944:	1080006f          	j	80008a4c <__printf+0x5d4>
    80008948:	001c8c93          	addi	s9,s9,1
    8000894c:	00000097          	auipc	ra,0x0
    80008950:	948080e7          	jalr	-1720(ra) # 80008294 <consputc>
    80008954:	000cc503          	lbu	a0,0(s9)
    80008958:	fe0518e3          	bnez	a0,80008948 <__printf+0x4d0>
    8000895c:	f5dff06f          	j	800088b8 <__printf+0x440>
    80008960:	02500513          	li	a0,37
    80008964:	00000097          	auipc	ra,0x0
    80008968:	930080e7          	jalr	-1744(ra) # 80008294 <consputc>
    8000896c:	000c8513          	mv	a0,s9
    80008970:	00000097          	auipc	ra,0x0
    80008974:	924080e7          	jalr	-1756(ra) # 80008294 <consputc>
    80008978:	f41ff06f          	j	800088b8 <__printf+0x440>
    8000897c:	02500513          	li	a0,37
    80008980:	00000097          	auipc	ra,0x0
    80008984:	914080e7          	jalr	-1772(ra) # 80008294 <consputc>
    80008988:	f31ff06f          	j	800088b8 <__printf+0x440>
    8000898c:	00030513          	mv	a0,t1
    80008990:	00000097          	auipc	ra,0x0
    80008994:	7bc080e7          	jalr	1980(ra) # 8000914c <acquire>
    80008998:	b4dff06f          	j	800084e4 <__printf+0x6c>
    8000899c:	40c0053b          	negw	a0,a2
    800089a0:	00a00713          	li	a4,10
    800089a4:	02e576bb          	remuw	a3,a0,a4
    800089a8:	00002d97          	auipc	s11,0x2
    800089ac:	018d8d93          	addi	s11,s11,24 # 8000a9c0 <digits>
    800089b0:	ff700593          	li	a1,-9
    800089b4:	02069693          	slli	a3,a3,0x20
    800089b8:	0206d693          	srli	a3,a3,0x20
    800089bc:	00dd86b3          	add	a3,s11,a3
    800089c0:	0006c683          	lbu	a3,0(a3)
    800089c4:	02e557bb          	divuw	a5,a0,a4
    800089c8:	f8d40023          	sb	a3,-128(s0)
    800089cc:	10b65e63          	bge	a2,a1,80008ae8 <__printf+0x670>
    800089d0:	06300593          	li	a1,99
    800089d4:	02e7f6bb          	remuw	a3,a5,a4
    800089d8:	02069693          	slli	a3,a3,0x20
    800089dc:	0206d693          	srli	a3,a3,0x20
    800089e0:	00dd86b3          	add	a3,s11,a3
    800089e4:	0006c683          	lbu	a3,0(a3)
    800089e8:	02e7d73b          	divuw	a4,a5,a4
    800089ec:	00200793          	li	a5,2
    800089f0:	f8d400a3          	sb	a3,-127(s0)
    800089f4:	bca5ece3          	bltu	a1,a0,800085cc <__printf+0x154>
    800089f8:	ce5ff06f          	j	800086dc <__printf+0x264>
    800089fc:	40e007bb          	negw	a5,a4
    80008a00:	00002d97          	auipc	s11,0x2
    80008a04:	fc0d8d93          	addi	s11,s11,-64 # 8000a9c0 <digits>
    80008a08:	00f7f693          	andi	a3,a5,15
    80008a0c:	00dd86b3          	add	a3,s11,a3
    80008a10:	0006c583          	lbu	a1,0(a3)
    80008a14:	ff100613          	li	a2,-15
    80008a18:	0047d69b          	srliw	a3,a5,0x4
    80008a1c:	f8b40023          	sb	a1,-128(s0)
    80008a20:	0047d59b          	srliw	a1,a5,0x4
    80008a24:	0ac75e63          	bge	a4,a2,80008ae0 <__printf+0x668>
    80008a28:	00f6f693          	andi	a3,a3,15
    80008a2c:	00dd86b3          	add	a3,s11,a3
    80008a30:	0006c603          	lbu	a2,0(a3)
    80008a34:	00f00693          	li	a3,15
    80008a38:	0087d79b          	srliw	a5,a5,0x8
    80008a3c:	f8c400a3          	sb	a2,-127(s0)
    80008a40:	d8b6e4e3          	bltu	a3,a1,800087c8 <__printf+0x350>
    80008a44:	00200793          	li	a5,2
    80008a48:	e2dff06f          	j	80008874 <__printf+0x3fc>
    80008a4c:	00002c97          	auipc	s9,0x2
    80008a50:	f54c8c93          	addi	s9,s9,-172 # 8000a9a0 <CONSOLE_STATUS+0x990>
    80008a54:	02800513          	li	a0,40
    80008a58:	ef1ff06f          	j	80008948 <__printf+0x4d0>
    80008a5c:	00700793          	li	a5,7
    80008a60:	00600c93          	li	s9,6
    80008a64:	e0dff06f          	j	80008870 <__printf+0x3f8>
    80008a68:	00700793          	li	a5,7
    80008a6c:	00600c93          	li	s9,6
    80008a70:	c69ff06f          	j	800086d8 <__printf+0x260>
    80008a74:	00300793          	li	a5,3
    80008a78:	00200c93          	li	s9,2
    80008a7c:	c5dff06f          	j	800086d8 <__printf+0x260>
    80008a80:	00300793          	li	a5,3
    80008a84:	00200c93          	li	s9,2
    80008a88:	de9ff06f          	j	80008870 <__printf+0x3f8>
    80008a8c:	00400793          	li	a5,4
    80008a90:	00300c93          	li	s9,3
    80008a94:	dddff06f          	j	80008870 <__printf+0x3f8>
    80008a98:	00400793          	li	a5,4
    80008a9c:	00300c93          	li	s9,3
    80008aa0:	c39ff06f          	j	800086d8 <__printf+0x260>
    80008aa4:	00500793          	li	a5,5
    80008aa8:	00400c93          	li	s9,4
    80008aac:	c2dff06f          	j	800086d8 <__printf+0x260>
    80008ab0:	00500793          	li	a5,5
    80008ab4:	00400c93          	li	s9,4
    80008ab8:	db9ff06f          	j	80008870 <__printf+0x3f8>
    80008abc:	00600793          	li	a5,6
    80008ac0:	00500c93          	li	s9,5
    80008ac4:	dadff06f          	j	80008870 <__printf+0x3f8>
    80008ac8:	00600793          	li	a5,6
    80008acc:	00500c93          	li	s9,5
    80008ad0:	c09ff06f          	j	800086d8 <__printf+0x260>
    80008ad4:	00800793          	li	a5,8
    80008ad8:	00700c93          	li	s9,7
    80008adc:	bfdff06f          	j	800086d8 <__printf+0x260>
    80008ae0:	00100793          	li	a5,1
    80008ae4:	d91ff06f          	j	80008874 <__printf+0x3fc>
    80008ae8:	00100793          	li	a5,1
    80008aec:	bf1ff06f          	j	800086dc <__printf+0x264>
    80008af0:	00900793          	li	a5,9
    80008af4:	00800c93          	li	s9,8
    80008af8:	be1ff06f          	j	800086d8 <__printf+0x260>
    80008afc:	00002517          	auipc	a0,0x2
    80008b00:	eac50513          	addi	a0,a0,-340 # 8000a9a8 <CONSOLE_STATUS+0x998>
    80008b04:	00000097          	auipc	ra,0x0
    80008b08:	918080e7          	jalr	-1768(ra) # 8000841c <panic>

0000000080008b0c <printfinit>:
    80008b0c:	fe010113          	addi	sp,sp,-32
    80008b10:	00813823          	sd	s0,16(sp)
    80008b14:	00913423          	sd	s1,8(sp)
    80008b18:	00113c23          	sd	ra,24(sp)
    80008b1c:	02010413          	addi	s0,sp,32
    80008b20:	00009497          	auipc	s1,0x9
    80008b24:	a3048493          	addi	s1,s1,-1488 # 80011550 <pr>
    80008b28:	00048513          	mv	a0,s1
    80008b2c:	00002597          	auipc	a1,0x2
    80008b30:	e8c58593          	addi	a1,a1,-372 # 8000a9b8 <CONSOLE_STATUS+0x9a8>
    80008b34:	00000097          	auipc	ra,0x0
    80008b38:	5f4080e7          	jalr	1524(ra) # 80009128 <initlock>
    80008b3c:	01813083          	ld	ra,24(sp)
    80008b40:	01013403          	ld	s0,16(sp)
    80008b44:	0004ac23          	sw	zero,24(s1)
    80008b48:	00813483          	ld	s1,8(sp)
    80008b4c:	02010113          	addi	sp,sp,32
    80008b50:	00008067          	ret

0000000080008b54 <uartinit>:
    80008b54:	ff010113          	addi	sp,sp,-16
    80008b58:	00813423          	sd	s0,8(sp)
    80008b5c:	01010413          	addi	s0,sp,16
    80008b60:	100007b7          	lui	a5,0x10000
    80008b64:	000780a3          	sb	zero,1(a5) # 10000001 <_entry-0x6fffffff>
    80008b68:	f8000713          	li	a4,-128
    80008b6c:	00e781a3          	sb	a4,3(a5)
    80008b70:	00300713          	li	a4,3
    80008b74:	00e78023          	sb	a4,0(a5)
    80008b78:	000780a3          	sb	zero,1(a5)
    80008b7c:	00e781a3          	sb	a4,3(a5)
    80008b80:	00700693          	li	a3,7
    80008b84:	00d78123          	sb	a3,2(a5)
    80008b88:	00e780a3          	sb	a4,1(a5)
    80008b8c:	00813403          	ld	s0,8(sp)
    80008b90:	01010113          	addi	sp,sp,16
    80008b94:	00008067          	ret

0000000080008b98 <uartputc>:
    80008b98:	00004797          	auipc	a5,0x4
    80008b9c:	0007a783          	lw	a5,0(a5) # 8000cb98 <panicked>
    80008ba0:	00078463          	beqz	a5,80008ba8 <uartputc+0x10>
    80008ba4:	0000006f          	j	80008ba4 <uartputc+0xc>
    80008ba8:	fd010113          	addi	sp,sp,-48
    80008bac:	02813023          	sd	s0,32(sp)
    80008bb0:	00913c23          	sd	s1,24(sp)
    80008bb4:	01213823          	sd	s2,16(sp)
    80008bb8:	01313423          	sd	s3,8(sp)
    80008bbc:	02113423          	sd	ra,40(sp)
    80008bc0:	03010413          	addi	s0,sp,48
    80008bc4:	00004917          	auipc	s2,0x4
    80008bc8:	fdc90913          	addi	s2,s2,-36 # 8000cba0 <uart_tx_r>
    80008bcc:	00093783          	ld	a5,0(s2)
    80008bd0:	00004497          	auipc	s1,0x4
    80008bd4:	fd848493          	addi	s1,s1,-40 # 8000cba8 <uart_tx_w>
    80008bd8:	0004b703          	ld	a4,0(s1)
    80008bdc:	02078693          	addi	a3,a5,32
    80008be0:	00050993          	mv	s3,a0
    80008be4:	02e69c63          	bne	a3,a4,80008c1c <uartputc+0x84>
    80008be8:	00001097          	auipc	ra,0x1
    80008bec:	834080e7          	jalr	-1996(ra) # 8000941c <push_on>
    80008bf0:	00093783          	ld	a5,0(s2)
    80008bf4:	0004b703          	ld	a4,0(s1)
    80008bf8:	02078793          	addi	a5,a5,32
    80008bfc:	00e79463          	bne	a5,a4,80008c04 <uartputc+0x6c>
    80008c00:	0000006f          	j	80008c00 <uartputc+0x68>
    80008c04:	00001097          	auipc	ra,0x1
    80008c08:	88c080e7          	jalr	-1908(ra) # 80009490 <pop_on>
    80008c0c:	00093783          	ld	a5,0(s2)
    80008c10:	0004b703          	ld	a4,0(s1)
    80008c14:	02078693          	addi	a3,a5,32
    80008c18:	fce688e3          	beq	a3,a4,80008be8 <uartputc+0x50>
    80008c1c:	01f77693          	andi	a3,a4,31
    80008c20:	00009597          	auipc	a1,0x9
    80008c24:	95058593          	addi	a1,a1,-1712 # 80011570 <uart_tx_buf>
    80008c28:	00d586b3          	add	a3,a1,a3
    80008c2c:	00170713          	addi	a4,a4,1
    80008c30:	01368023          	sb	s3,0(a3)
    80008c34:	00e4b023          	sd	a4,0(s1)
    80008c38:	10000637          	lui	a2,0x10000
    80008c3c:	02f71063          	bne	a4,a5,80008c5c <uartputc+0xc4>
    80008c40:	0340006f          	j	80008c74 <uartputc+0xdc>
    80008c44:	00074703          	lbu	a4,0(a4)
    80008c48:	00f93023          	sd	a5,0(s2)
    80008c4c:	00e60023          	sb	a4,0(a2) # 10000000 <_entry-0x70000000>
    80008c50:	00093783          	ld	a5,0(s2)
    80008c54:	0004b703          	ld	a4,0(s1)
    80008c58:	00f70e63          	beq	a4,a5,80008c74 <uartputc+0xdc>
    80008c5c:	00564683          	lbu	a3,5(a2)
    80008c60:	01f7f713          	andi	a4,a5,31
    80008c64:	00e58733          	add	a4,a1,a4
    80008c68:	0206f693          	andi	a3,a3,32
    80008c6c:	00178793          	addi	a5,a5,1
    80008c70:	fc069ae3          	bnez	a3,80008c44 <uartputc+0xac>
    80008c74:	02813083          	ld	ra,40(sp)
    80008c78:	02013403          	ld	s0,32(sp)
    80008c7c:	01813483          	ld	s1,24(sp)
    80008c80:	01013903          	ld	s2,16(sp)
    80008c84:	00813983          	ld	s3,8(sp)
    80008c88:	03010113          	addi	sp,sp,48
    80008c8c:	00008067          	ret

0000000080008c90 <uartputc_sync>:
    80008c90:	ff010113          	addi	sp,sp,-16
    80008c94:	00813423          	sd	s0,8(sp)
    80008c98:	01010413          	addi	s0,sp,16
    80008c9c:	00004717          	auipc	a4,0x4
    80008ca0:	efc72703          	lw	a4,-260(a4) # 8000cb98 <panicked>
    80008ca4:	02071663          	bnez	a4,80008cd0 <uartputc_sync+0x40>
    80008ca8:	00050793          	mv	a5,a0
    80008cac:	100006b7          	lui	a3,0x10000
    80008cb0:	0056c703          	lbu	a4,5(a3) # 10000005 <_entry-0x6ffffffb>
    80008cb4:	02077713          	andi	a4,a4,32
    80008cb8:	fe070ce3          	beqz	a4,80008cb0 <uartputc_sync+0x20>
    80008cbc:	0ff7f793          	andi	a5,a5,255
    80008cc0:	00f68023          	sb	a5,0(a3)
    80008cc4:	00813403          	ld	s0,8(sp)
    80008cc8:	01010113          	addi	sp,sp,16
    80008ccc:	00008067          	ret
    80008cd0:	0000006f          	j	80008cd0 <uartputc_sync+0x40>

0000000080008cd4 <uartstart>:
    80008cd4:	ff010113          	addi	sp,sp,-16
    80008cd8:	00813423          	sd	s0,8(sp)
    80008cdc:	01010413          	addi	s0,sp,16
    80008ce0:	00004617          	auipc	a2,0x4
    80008ce4:	ec060613          	addi	a2,a2,-320 # 8000cba0 <uart_tx_r>
    80008ce8:	00004517          	auipc	a0,0x4
    80008cec:	ec050513          	addi	a0,a0,-320 # 8000cba8 <uart_tx_w>
    80008cf0:	00063783          	ld	a5,0(a2)
    80008cf4:	00053703          	ld	a4,0(a0)
    80008cf8:	04f70263          	beq	a4,a5,80008d3c <uartstart+0x68>
    80008cfc:	100005b7          	lui	a1,0x10000
    80008d00:	00009817          	auipc	a6,0x9
    80008d04:	87080813          	addi	a6,a6,-1936 # 80011570 <uart_tx_buf>
    80008d08:	01c0006f          	j	80008d24 <uartstart+0x50>
    80008d0c:	0006c703          	lbu	a4,0(a3)
    80008d10:	00f63023          	sd	a5,0(a2)
    80008d14:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    80008d18:	00063783          	ld	a5,0(a2)
    80008d1c:	00053703          	ld	a4,0(a0)
    80008d20:	00f70e63          	beq	a4,a5,80008d3c <uartstart+0x68>
    80008d24:	01f7f713          	andi	a4,a5,31
    80008d28:	00e806b3          	add	a3,a6,a4
    80008d2c:	0055c703          	lbu	a4,5(a1)
    80008d30:	00178793          	addi	a5,a5,1
    80008d34:	02077713          	andi	a4,a4,32
    80008d38:	fc071ae3          	bnez	a4,80008d0c <uartstart+0x38>
    80008d3c:	00813403          	ld	s0,8(sp)
    80008d40:	01010113          	addi	sp,sp,16
    80008d44:	00008067          	ret

0000000080008d48 <uartgetc>:
    80008d48:	ff010113          	addi	sp,sp,-16
    80008d4c:	00813423          	sd	s0,8(sp)
    80008d50:	01010413          	addi	s0,sp,16
    80008d54:	10000737          	lui	a4,0x10000
    80008d58:	00574783          	lbu	a5,5(a4) # 10000005 <_entry-0x6ffffffb>
    80008d5c:	0017f793          	andi	a5,a5,1
    80008d60:	00078c63          	beqz	a5,80008d78 <uartgetc+0x30>
    80008d64:	00074503          	lbu	a0,0(a4)
    80008d68:	0ff57513          	andi	a0,a0,255
    80008d6c:	00813403          	ld	s0,8(sp)
    80008d70:	01010113          	addi	sp,sp,16
    80008d74:	00008067          	ret
    80008d78:	fff00513          	li	a0,-1
    80008d7c:	ff1ff06f          	j	80008d6c <uartgetc+0x24>

0000000080008d80 <uartintr>:
    80008d80:	100007b7          	lui	a5,0x10000
    80008d84:	0057c783          	lbu	a5,5(a5) # 10000005 <_entry-0x6ffffffb>
    80008d88:	0017f793          	andi	a5,a5,1
    80008d8c:	0a078463          	beqz	a5,80008e34 <uartintr+0xb4>
    80008d90:	fe010113          	addi	sp,sp,-32
    80008d94:	00813823          	sd	s0,16(sp)
    80008d98:	00913423          	sd	s1,8(sp)
    80008d9c:	00113c23          	sd	ra,24(sp)
    80008da0:	02010413          	addi	s0,sp,32
    80008da4:	100004b7          	lui	s1,0x10000
    80008da8:	0004c503          	lbu	a0,0(s1) # 10000000 <_entry-0x70000000>
    80008dac:	0ff57513          	andi	a0,a0,255
    80008db0:	fffff097          	auipc	ra,0xfffff
    80008db4:	534080e7          	jalr	1332(ra) # 800082e4 <consoleintr>
    80008db8:	0054c783          	lbu	a5,5(s1)
    80008dbc:	0017f793          	andi	a5,a5,1
    80008dc0:	fe0794e3          	bnez	a5,80008da8 <uartintr+0x28>
    80008dc4:	00004617          	auipc	a2,0x4
    80008dc8:	ddc60613          	addi	a2,a2,-548 # 8000cba0 <uart_tx_r>
    80008dcc:	00004517          	auipc	a0,0x4
    80008dd0:	ddc50513          	addi	a0,a0,-548 # 8000cba8 <uart_tx_w>
    80008dd4:	00063783          	ld	a5,0(a2)
    80008dd8:	00053703          	ld	a4,0(a0)
    80008ddc:	04f70263          	beq	a4,a5,80008e20 <uartintr+0xa0>
    80008de0:	100005b7          	lui	a1,0x10000
    80008de4:	00008817          	auipc	a6,0x8
    80008de8:	78c80813          	addi	a6,a6,1932 # 80011570 <uart_tx_buf>
    80008dec:	01c0006f          	j	80008e08 <uartintr+0x88>
    80008df0:	0006c703          	lbu	a4,0(a3)
    80008df4:	00f63023          	sd	a5,0(a2)
    80008df8:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    80008dfc:	00063783          	ld	a5,0(a2)
    80008e00:	00053703          	ld	a4,0(a0)
    80008e04:	00f70e63          	beq	a4,a5,80008e20 <uartintr+0xa0>
    80008e08:	01f7f713          	andi	a4,a5,31
    80008e0c:	00e806b3          	add	a3,a6,a4
    80008e10:	0055c703          	lbu	a4,5(a1)
    80008e14:	00178793          	addi	a5,a5,1
    80008e18:	02077713          	andi	a4,a4,32
    80008e1c:	fc071ae3          	bnez	a4,80008df0 <uartintr+0x70>
    80008e20:	01813083          	ld	ra,24(sp)
    80008e24:	01013403          	ld	s0,16(sp)
    80008e28:	00813483          	ld	s1,8(sp)
    80008e2c:	02010113          	addi	sp,sp,32
    80008e30:	00008067          	ret
    80008e34:	00004617          	auipc	a2,0x4
    80008e38:	d6c60613          	addi	a2,a2,-660 # 8000cba0 <uart_tx_r>
    80008e3c:	00004517          	auipc	a0,0x4
    80008e40:	d6c50513          	addi	a0,a0,-660 # 8000cba8 <uart_tx_w>
    80008e44:	00063783          	ld	a5,0(a2)
    80008e48:	00053703          	ld	a4,0(a0)
    80008e4c:	04f70263          	beq	a4,a5,80008e90 <uartintr+0x110>
    80008e50:	100005b7          	lui	a1,0x10000
    80008e54:	00008817          	auipc	a6,0x8
    80008e58:	71c80813          	addi	a6,a6,1820 # 80011570 <uart_tx_buf>
    80008e5c:	01c0006f          	j	80008e78 <uartintr+0xf8>
    80008e60:	0006c703          	lbu	a4,0(a3)
    80008e64:	00f63023          	sd	a5,0(a2)
    80008e68:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    80008e6c:	00063783          	ld	a5,0(a2)
    80008e70:	00053703          	ld	a4,0(a0)
    80008e74:	02f70063          	beq	a4,a5,80008e94 <uartintr+0x114>
    80008e78:	01f7f713          	andi	a4,a5,31
    80008e7c:	00e806b3          	add	a3,a6,a4
    80008e80:	0055c703          	lbu	a4,5(a1)
    80008e84:	00178793          	addi	a5,a5,1
    80008e88:	02077713          	andi	a4,a4,32
    80008e8c:	fc071ae3          	bnez	a4,80008e60 <uartintr+0xe0>
    80008e90:	00008067          	ret
    80008e94:	00008067          	ret

0000000080008e98 <kinit>:
    80008e98:	fc010113          	addi	sp,sp,-64
    80008e9c:	02913423          	sd	s1,40(sp)
    80008ea0:	fffff7b7          	lui	a5,0xfffff
    80008ea4:	00009497          	auipc	s1,0x9
    80008ea8:	6eb48493          	addi	s1,s1,1771 # 8001258f <end+0xfff>
    80008eac:	02813823          	sd	s0,48(sp)
    80008eb0:	01313c23          	sd	s3,24(sp)
    80008eb4:	00f4f4b3          	and	s1,s1,a5
    80008eb8:	02113c23          	sd	ra,56(sp)
    80008ebc:	03213023          	sd	s2,32(sp)
    80008ec0:	01413823          	sd	s4,16(sp)
    80008ec4:	01513423          	sd	s5,8(sp)
    80008ec8:	04010413          	addi	s0,sp,64
    80008ecc:	000017b7          	lui	a5,0x1
    80008ed0:	01100993          	li	s3,17
    80008ed4:	00f487b3          	add	a5,s1,a5
    80008ed8:	01b99993          	slli	s3,s3,0x1b
    80008edc:	06f9e063          	bltu	s3,a5,80008f3c <kinit+0xa4>
    80008ee0:	00008a97          	auipc	s5,0x8
    80008ee4:	6b0a8a93          	addi	s5,s5,1712 # 80011590 <end>
    80008ee8:	0754ec63          	bltu	s1,s5,80008f60 <kinit+0xc8>
    80008eec:	0734fa63          	bgeu	s1,s3,80008f60 <kinit+0xc8>
    80008ef0:	00088a37          	lui	s4,0x88
    80008ef4:	fffa0a13          	addi	s4,s4,-1 # 87fff <_entry-0x7ff78001>
    80008ef8:	00004917          	auipc	s2,0x4
    80008efc:	cb890913          	addi	s2,s2,-840 # 8000cbb0 <kmem>
    80008f00:	00ca1a13          	slli	s4,s4,0xc
    80008f04:	0140006f          	j	80008f18 <kinit+0x80>
    80008f08:	000017b7          	lui	a5,0x1
    80008f0c:	00f484b3          	add	s1,s1,a5
    80008f10:	0554e863          	bltu	s1,s5,80008f60 <kinit+0xc8>
    80008f14:	0534f663          	bgeu	s1,s3,80008f60 <kinit+0xc8>
    80008f18:	00001637          	lui	a2,0x1
    80008f1c:	00100593          	li	a1,1
    80008f20:	00048513          	mv	a0,s1
    80008f24:	00000097          	auipc	ra,0x0
    80008f28:	5e4080e7          	jalr	1508(ra) # 80009508 <__memset>
    80008f2c:	00093783          	ld	a5,0(s2)
    80008f30:	00f4b023          	sd	a5,0(s1)
    80008f34:	00993023          	sd	s1,0(s2)
    80008f38:	fd4498e3          	bne	s1,s4,80008f08 <kinit+0x70>
    80008f3c:	03813083          	ld	ra,56(sp)
    80008f40:	03013403          	ld	s0,48(sp)
    80008f44:	02813483          	ld	s1,40(sp)
    80008f48:	02013903          	ld	s2,32(sp)
    80008f4c:	01813983          	ld	s3,24(sp)
    80008f50:	01013a03          	ld	s4,16(sp)
    80008f54:	00813a83          	ld	s5,8(sp)
    80008f58:	04010113          	addi	sp,sp,64
    80008f5c:	00008067          	ret
    80008f60:	00002517          	auipc	a0,0x2
    80008f64:	a7850513          	addi	a0,a0,-1416 # 8000a9d8 <digits+0x18>
    80008f68:	fffff097          	auipc	ra,0xfffff
    80008f6c:	4b4080e7          	jalr	1204(ra) # 8000841c <panic>

0000000080008f70 <freerange>:
    80008f70:	fc010113          	addi	sp,sp,-64
    80008f74:	000017b7          	lui	a5,0x1
    80008f78:	02913423          	sd	s1,40(sp)
    80008f7c:	fff78493          	addi	s1,a5,-1 # fff <_entry-0x7ffff001>
    80008f80:	009504b3          	add	s1,a0,s1
    80008f84:	fffff537          	lui	a0,0xfffff
    80008f88:	02813823          	sd	s0,48(sp)
    80008f8c:	02113c23          	sd	ra,56(sp)
    80008f90:	03213023          	sd	s2,32(sp)
    80008f94:	01313c23          	sd	s3,24(sp)
    80008f98:	01413823          	sd	s4,16(sp)
    80008f9c:	01513423          	sd	s5,8(sp)
    80008fa0:	01613023          	sd	s6,0(sp)
    80008fa4:	04010413          	addi	s0,sp,64
    80008fa8:	00a4f4b3          	and	s1,s1,a0
    80008fac:	00f487b3          	add	a5,s1,a5
    80008fb0:	06f5e463          	bltu	a1,a5,80009018 <freerange+0xa8>
    80008fb4:	00008a97          	auipc	s5,0x8
    80008fb8:	5dca8a93          	addi	s5,s5,1500 # 80011590 <end>
    80008fbc:	0954e263          	bltu	s1,s5,80009040 <freerange+0xd0>
    80008fc0:	01100993          	li	s3,17
    80008fc4:	01b99993          	slli	s3,s3,0x1b
    80008fc8:	0734fc63          	bgeu	s1,s3,80009040 <freerange+0xd0>
    80008fcc:	00058a13          	mv	s4,a1
    80008fd0:	00004917          	auipc	s2,0x4
    80008fd4:	be090913          	addi	s2,s2,-1056 # 8000cbb0 <kmem>
    80008fd8:	00002b37          	lui	s6,0x2
    80008fdc:	0140006f          	j	80008ff0 <freerange+0x80>
    80008fe0:	000017b7          	lui	a5,0x1
    80008fe4:	00f484b3          	add	s1,s1,a5
    80008fe8:	0554ec63          	bltu	s1,s5,80009040 <freerange+0xd0>
    80008fec:	0534fa63          	bgeu	s1,s3,80009040 <freerange+0xd0>
    80008ff0:	00001637          	lui	a2,0x1
    80008ff4:	00100593          	li	a1,1
    80008ff8:	00048513          	mv	a0,s1
    80008ffc:	00000097          	auipc	ra,0x0
    80009000:	50c080e7          	jalr	1292(ra) # 80009508 <__memset>
    80009004:	00093703          	ld	a4,0(s2)
    80009008:	016487b3          	add	a5,s1,s6
    8000900c:	00e4b023          	sd	a4,0(s1)
    80009010:	00993023          	sd	s1,0(s2)
    80009014:	fcfa76e3          	bgeu	s4,a5,80008fe0 <freerange+0x70>
    80009018:	03813083          	ld	ra,56(sp)
    8000901c:	03013403          	ld	s0,48(sp)
    80009020:	02813483          	ld	s1,40(sp)
    80009024:	02013903          	ld	s2,32(sp)
    80009028:	01813983          	ld	s3,24(sp)
    8000902c:	01013a03          	ld	s4,16(sp)
    80009030:	00813a83          	ld	s5,8(sp)
    80009034:	00013b03          	ld	s6,0(sp)
    80009038:	04010113          	addi	sp,sp,64
    8000903c:	00008067          	ret
    80009040:	00002517          	auipc	a0,0x2
    80009044:	99850513          	addi	a0,a0,-1640 # 8000a9d8 <digits+0x18>
    80009048:	fffff097          	auipc	ra,0xfffff
    8000904c:	3d4080e7          	jalr	980(ra) # 8000841c <panic>

0000000080009050 <kfree>:
    80009050:	fe010113          	addi	sp,sp,-32
    80009054:	00813823          	sd	s0,16(sp)
    80009058:	00113c23          	sd	ra,24(sp)
    8000905c:	00913423          	sd	s1,8(sp)
    80009060:	02010413          	addi	s0,sp,32
    80009064:	03451793          	slli	a5,a0,0x34
    80009068:	04079c63          	bnez	a5,800090c0 <kfree+0x70>
    8000906c:	00008797          	auipc	a5,0x8
    80009070:	52478793          	addi	a5,a5,1316 # 80011590 <end>
    80009074:	00050493          	mv	s1,a0
    80009078:	04f56463          	bltu	a0,a5,800090c0 <kfree+0x70>
    8000907c:	01100793          	li	a5,17
    80009080:	01b79793          	slli	a5,a5,0x1b
    80009084:	02f57e63          	bgeu	a0,a5,800090c0 <kfree+0x70>
    80009088:	00001637          	lui	a2,0x1
    8000908c:	00100593          	li	a1,1
    80009090:	00000097          	auipc	ra,0x0
    80009094:	478080e7          	jalr	1144(ra) # 80009508 <__memset>
    80009098:	00004797          	auipc	a5,0x4
    8000909c:	b1878793          	addi	a5,a5,-1256 # 8000cbb0 <kmem>
    800090a0:	0007b703          	ld	a4,0(a5)
    800090a4:	01813083          	ld	ra,24(sp)
    800090a8:	01013403          	ld	s0,16(sp)
    800090ac:	00e4b023          	sd	a4,0(s1)
    800090b0:	0097b023          	sd	s1,0(a5)
    800090b4:	00813483          	ld	s1,8(sp)
    800090b8:	02010113          	addi	sp,sp,32
    800090bc:	00008067          	ret
    800090c0:	00002517          	auipc	a0,0x2
    800090c4:	91850513          	addi	a0,a0,-1768 # 8000a9d8 <digits+0x18>
    800090c8:	fffff097          	auipc	ra,0xfffff
    800090cc:	354080e7          	jalr	852(ra) # 8000841c <panic>

00000000800090d0 <kalloc>:
    800090d0:	fe010113          	addi	sp,sp,-32
    800090d4:	00813823          	sd	s0,16(sp)
    800090d8:	00913423          	sd	s1,8(sp)
    800090dc:	00113c23          	sd	ra,24(sp)
    800090e0:	02010413          	addi	s0,sp,32
    800090e4:	00004797          	auipc	a5,0x4
    800090e8:	acc78793          	addi	a5,a5,-1332 # 8000cbb0 <kmem>
    800090ec:	0007b483          	ld	s1,0(a5)
    800090f0:	02048063          	beqz	s1,80009110 <kalloc+0x40>
    800090f4:	0004b703          	ld	a4,0(s1)
    800090f8:	00001637          	lui	a2,0x1
    800090fc:	00500593          	li	a1,5
    80009100:	00048513          	mv	a0,s1
    80009104:	00e7b023          	sd	a4,0(a5)
    80009108:	00000097          	auipc	ra,0x0
    8000910c:	400080e7          	jalr	1024(ra) # 80009508 <__memset>
    80009110:	01813083          	ld	ra,24(sp)
    80009114:	01013403          	ld	s0,16(sp)
    80009118:	00048513          	mv	a0,s1
    8000911c:	00813483          	ld	s1,8(sp)
    80009120:	02010113          	addi	sp,sp,32
    80009124:	00008067          	ret

0000000080009128 <initlock>:
    80009128:	ff010113          	addi	sp,sp,-16
    8000912c:	00813423          	sd	s0,8(sp)
    80009130:	01010413          	addi	s0,sp,16
    80009134:	00813403          	ld	s0,8(sp)
    80009138:	00b53423          	sd	a1,8(a0)
    8000913c:	00052023          	sw	zero,0(a0)
    80009140:	00053823          	sd	zero,16(a0)
    80009144:	01010113          	addi	sp,sp,16
    80009148:	00008067          	ret

000000008000914c <acquire>:
    8000914c:	fe010113          	addi	sp,sp,-32
    80009150:	00813823          	sd	s0,16(sp)
    80009154:	00913423          	sd	s1,8(sp)
    80009158:	00113c23          	sd	ra,24(sp)
    8000915c:	01213023          	sd	s2,0(sp)
    80009160:	02010413          	addi	s0,sp,32
    80009164:	00050493          	mv	s1,a0
    80009168:	10002973          	csrr	s2,sstatus
    8000916c:	100027f3          	csrr	a5,sstatus
    80009170:	ffd7f793          	andi	a5,a5,-3
    80009174:	10079073          	csrw	sstatus,a5
    80009178:	fffff097          	auipc	ra,0xfffff
    8000917c:	8ec080e7          	jalr	-1812(ra) # 80007a64 <mycpu>
    80009180:	07852783          	lw	a5,120(a0)
    80009184:	06078e63          	beqz	a5,80009200 <acquire+0xb4>
    80009188:	fffff097          	auipc	ra,0xfffff
    8000918c:	8dc080e7          	jalr	-1828(ra) # 80007a64 <mycpu>
    80009190:	07852783          	lw	a5,120(a0)
    80009194:	0004a703          	lw	a4,0(s1)
    80009198:	0017879b          	addiw	a5,a5,1
    8000919c:	06f52c23          	sw	a5,120(a0)
    800091a0:	04071063          	bnez	a4,800091e0 <acquire+0x94>
    800091a4:	00100713          	li	a4,1
    800091a8:	00070793          	mv	a5,a4
    800091ac:	0cf4a7af          	amoswap.w.aq	a5,a5,(s1)
    800091b0:	0007879b          	sext.w	a5,a5
    800091b4:	fe079ae3          	bnez	a5,800091a8 <acquire+0x5c>
    800091b8:	0ff0000f          	fence
    800091bc:	fffff097          	auipc	ra,0xfffff
    800091c0:	8a8080e7          	jalr	-1880(ra) # 80007a64 <mycpu>
    800091c4:	01813083          	ld	ra,24(sp)
    800091c8:	01013403          	ld	s0,16(sp)
    800091cc:	00a4b823          	sd	a0,16(s1)
    800091d0:	00013903          	ld	s2,0(sp)
    800091d4:	00813483          	ld	s1,8(sp)
    800091d8:	02010113          	addi	sp,sp,32
    800091dc:	00008067          	ret
    800091e0:	0104b903          	ld	s2,16(s1)
    800091e4:	fffff097          	auipc	ra,0xfffff
    800091e8:	880080e7          	jalr	-1920(ra) # 80007a64 <mycpu>
    800091ec:	faa91ce3          	bne	s2,a0,800091a4 <acquire+0x58>
    800091f0:	00001517          	auipc	a0,0x1
    800091f4:	7f050513          	addi	a0,a0,2032 # 8000a9e0 <digits+0x20>
    800091f8:	fffff097          	auipc	ra,0xfffff
    800091fc:	224080e7          	jalr	548(ra) # 8000841c <panic>
    80009200:	00195913          	srli	s2,s2,0x1
    80009204:	fffff097          	auipc	ra,0xfffff
    80009208:	860080e7          	jalr	-1952(ra) # 80007a64 <mycpu>
    8000920c:	00197913          	andi	s2,s2,1
    80009210:	07252e23          	sw	s2,124(a0)
    80009214:	f75ff06f          	j	80009188 <acquire+0x3c>

0000000080009218 <release>:
    80009218:	fe010113          	addi	sp,sp,-32
    8000921c:	00813823          	sd	s0,16(sp)
    80009220:	00113c23          	sd	ra,24(sp)
    80009224:	00913423          	sd	s1,8(sp)
    80009228:	01213023          	sd	s2,0(sp)
    8000922c:	02010413          	addi	s0,sp,32
    80009230:	00052783          	lw	a5,0(a0)
    80009234:	00079a63          	bnez	a5,80009248 <release+0x30>
    80009238:	00001517          	auipc	a0,0x1
    8000923c:	7b050513          	addi	a0,a0,1968 # 8000a9e8 <digits+0x28>
    80009240:	fffff097          	auipc	ra,0xfffff
    80009244:	1dc080e7          	jalr	476(ra) # 8000841c <panic>
    80009248:	01053903          	ld	s2,16(a0)
    8000924c:	00050493          	mv	s1,a0
    80009250:	fffff097          	auipc	ra,0xfffff
    80009254:	814080e7          	jalr	-2028(ra) # 80007a64 <mycpu>
    80009258:	fea910e3          	bne	s2,a0,80009238 <release+0x20>
    8000925c:	0004b823          	sd	zero,16(s1)
    80009260:	0ff0000f          	fence
    80009264:	0f50000f          	fence	iorw,ow
    80009268:	0804a02f          	amoswap.w	zero,zero,(s1)
    8000926c:	ffffe097          	auipc	ra,0xffffe
    80009270:	7f8080e7          	jalr	2040(ra) # 80007a64 <mycpu>
    80009274:	100027f3          	csrr	a5,sstatus
    80009278:	0027f793          	andi	a5,a5,2
    8000927c:	04079a63          	bnez	a5,800092d0 <release+0xb8>
    80009280:	07852783          	lw	a5,120(a0)
    80009284:	02f05e63          	blez	a5,800092c0 <release+0xa8>
    80009288:	fff7871b          	addiw	a4,a5,-1
    8000928c:	06e52c23          	sw	a4,120(a0)
    80009290:	00071c63          	bnez	a4,800092a8 <release+0x90>
    80009294:	07c52783          	lw	a5,124(a0)
    80009298:	00078863          	beqz	a5,800092a8 <release+0x90>
    8000929c:	100027f3          	csrr	a5,sstatus
    800092a0:	0027e793          	ori	a5,a5,2
    800092a4:	10079073          	csrw	sstatus,a5
    800092a8:	01813083          	ld	ra,24(sp)
    800092ac:	01013403          	ld	s0,16(sp)
    800092b0:	00813483          	ld	s1,8(sp)
    800092b4:	00013903          	ld	s2,0(sp)
    800092b8:	02010113          	addi	sp,sp,32
    800092bc:	00008067          	ret
    800092c0:	00001517          	auipc	a0,0x1
    800092c4:	74850513          	addi	a0,a0,1864 # 8000aa08 <digits+0x48>
    800092c8:	fffff097          	auipc	ra,0xfffff
    800092cc:	154080e7          	jalr	340(ra) # 8000841c <panic>
    800092d0:	00001517          	auipc	a0,0x1
    800092d4:	72050513          	addi	a0,a0,1824 # 8000a9f0 <digits+0x30>
    800092d8:	fffff097          	auipc	ra,0xfffff
    800092dc:	144080e7          	jalr	324(ra) # 8000841c <panic>

00000000800092e0 <holding>:
    800092e0:	00052783          	lw	a5,0(a0)
    800092e4:	00079663          	bnez	a5,800092f0 <holding+0x10>
    800092e8:	00000513          	li	a0,0
    800092ec:	00008067          	ret
    800092f0:	fe010113          	addi	sp,sp,-32
    800092f4:	00813823          	sd	s0,16(sp)
    800092f8:	00913423          	sd	s1,8(sp)
    800092fc:	00113c23          	sd	ra,24(sp)
    80009300:	02010413          	addi	s0,sp,32
    80009304:	01053483          	ld	s1,16(a0)
    80009308:	ffffe097          	auipc	ra,0xffffe
    8000930c:	75c080e7          	jalr	1884(ra) # 80007a64 <mycpu>
    80009310:	01813083          	ld	ra,24(sp)
    80009314:	01013403          	ld	s0,16(sp)
    80009318:	40a48533          	sub	a0,s1,a0
    8000931c:	00153513          	seqz	a0,a0
    80009320:	00813483          	ld	s1,8(sp)
    80009324:	02010113          	addi	sp,sp,32
    80009328:	00008067          	ret

000000008000932c <push_off>:
    8000932c:	fe010113          	addi	sp,sp,-32
    80009330:	00813823          	sd	s0,16(sp)
    80009334:	00113c23          	sd	ra,24(sp)
    80009338:	00913423          	sd	s1,8(sp)
    8000933c:	02010413          	addi	s0,sp,32
    80009340:	100024f3          	csrr	s1,sstatus
    80009344:	100027f3          	csrr	a5,sstatus
    80009348:	ffd7f793          	andi	a5,a5,-3
    8000934c:	10079073          	csrw	sstatus,a5
    80009350:	ffffe097          	auipc	ra,0xffffe
    80009354:	714080e7          	jalr	1812(ra) # 80007a64 <mycpu>
    80009358:	07852783          	lw	a5,120(a0)
    8000935c:	02078663          	beqz	a5,80009388 <push_off+0x5c>
    80009360:	ffffe097          	auipc	ra,0xffffe
    80009364:	704080e7          	jalr	1796(ra) # 80007a64 <mycpu>
    80009368:	07852783          	lw	a5,120(a0)
    8000936c:	01813083          	ld	ra,24(sp)
    80009370:	01013403          	ld	s0,16(sp)
    80009374:	0017879b          	addiw	a5,a5,1
    80009378:	06f52c23          	sw	a5,120(a0)
    8000937c:	00813483          	ld	s1,8(sp)
    80009380:	02010113          	addi	sp,sp,32
    80009384:	00008067          	ret
    80009388:	0014d493          	srli	s1,s1,0x1
    8000938c:	ffffe097          	auipc	ra,0xffffe
    80009390:	6d8080e7          	jalr	1752(ra) # 80007a64 <mycpu>
    80009394:	0014f493          	andi	s1,s1,1
    80009398:	06952e23          	sw	s1,124(a0)
    8000939c:	fc5ff06f          	j	80009360 <push_off+0x34>

00000000800093a0 <pop_off>:
    800093a0:	ff010113          	addi	sp,sp,-16
    800093a4:	00813023          	sd	s0,0(sp)
    800093a8:	00113423          	sd	ra,8(sp)
    800093ac:	01010413          	addi	s0,sp,16
    800093b0:	ffffe097          	auipc	ra,0xffffe
    800093b4:	6b4080e7          	jalr	1716(ra) # 80007a64 <mycpu>
    800093b8:	100027f3          	csrr	a5,sstatus
    800093bc:	0027f793          	andi	a5,a5,2
    800093c0:	04079663          	bnez	a5,8000940c <pop_off+0x6c>
    800093c4:	07852783          	lw	a5,120(a0)
    800093c8:	02f05a63          	blez	a5,800093fc <pop_off+0x5c>
    800093cc:	fff7871b          	addiw	a4,a5,-1
    800093d0:	06e52c23          	sw	a4,120(a0)
    800093d4:	00071c63          	bnez	a4,800093ec <pop_off+0x4c>
    800093d8:	07c52783          	lw	a5,124(a0)
    800093dc:	00078863          	beqz	a5,800093ec <pop_off+0x4c>
    800093e0:	100027f3          	csrr	a5,sstatus
    800093e4:	0027e793          	ori	a5,a5,2
    800093e8:	10079073          	csrw	sstatus,a5
    800093ec:	00813083          	ld	ra,8(sp)
    800093f0:	00013403          	ld	s0,0(sp)
    800093f4:	01010113          	addi	sp,sp,16
    800093f8:	00008067          	ret
    800093fc:	00001517          	auipc	a0,0x1
    80009400:	60c50513          	addi	a0,a0,1548 # 8000aa08 <digits+0x48>
    80009404:	fffff097          	auipc	ra,0xfffff
    80009408:	018080e7          	jalr	24(ra) # 8000841c <panic>
    8000940c:	00001517          	auipc	a0,0x1
    80009410:	5e450513          	addi	a0,a0,1508 # 8000a9f0 <digits+0x30>
    80009414:	fffff097          	auipc	ra,0xfffff
    80009418:	008080e7          	jalr	8(ra) # 8000841c <panic>

000000008000941c <push_on>:
    8000941c:	fe010113          	addi	sp,sp,-32
    80009420:	00813823          	sd	s0,16(sp)
    80009424:	00113c23          	sd	ra,24(sp)
    80009428:	00913423          	sd	s1,8(sp)
    8000942c:	02010413          	addi	s0,sp,32
    80009430:	100024f3          	csrr	s1,sstatus
    80009434:	100027f3          	csrr	a5,sstatus
    80009438:	0027e793          	ori	a5,a5,2
    8000943c:	10079073          	csrw	sstatus,a5
    80009440:	ffffe097          	auipc	ra,0xffffe
    80009444:	624080e7          	jalr	1572(ra) # 80007a64 <mycpu>
    80009448:	07852783          	lw	a5,120(a0)
    8000944c:	02078663          	beqz	a5,80009478 <push_on+0x5c>
    80009450:	ffffe097          	auipc	ra,0xffffe
    80009454:	614080e7          	jalr	1556(ra) # 80007a64 <mycpu>
    80009458:	07852783          	lw	a5,120(a0)
    8000945c:	01813083          	ld	ra,24(sp)
    80009460:	01013403          	ld	s0,16(sp)
    80009464:	0017879b          	addiw	a5,a5,1
    80009468:	06f52c23          	sw	a5,120(a0)
    8000946c:	00813483          	ld	s1,8(sp)
    80009470:	02010113          	addi	sp,sp,32
    80009474:	00008067          	ret
    80009478:	0014d493          	srli	s1,s1,0x1
    8000947c:	ffffe097          	auipc	ra,0xffffe
    80009480:	5e8080e7          	jalr	1512(ra) # 80007a64 <mycpu>
    80009484:	0014f493          	andi	s1,s1,1
    80009488:	06952e23          	sw	s1,124(a0)
    8000948c:	fc5ff06f          	j	80009450 <push_on+0x34>

0000000080009490 <pop_on>:
    80009490:	ff010113          	addi	sp,sp,-16
    80009494:	00813023          	sd	s0,0(sp)
    80009498:	00113423          	sd	ra,8(sp)
    8000949c:	01010413          	addi	s0,sp,16
    800094a0:	ffffe097          	auipc	ra,0xffffe
    800094a4:	5c4080e7          	jalr	1476(ra) # 80007a64 <mycpu>
    800094a8:	100027f3          	csrr	a5,sstatus
    800094ac:	0027f793          	andi	a5,a5,2
    800094b0:	04078463          	beqz	a5,800094f8 <pop_on+0x68>
    800094b4:	07852783          	lw	a5,120(a0)
    800094b8:	02f05863          	blez	a5,800094e8 <pop_on+0x58>
    800094bc:	fff7879b          	addiw	a5,a5,-1
    800094c0:	06f52c23          	sw	a5,120(a0)
    800094c4:	07853783          	ld	a5,120(a0)
    800094c8:	00079863          	bnez	a5,800094d8 <pop_on+0x48>
    800094cc:	100027f3          	csrr	a5,sstatus
    800094d0:	ffd7f793          	andi	a5,a5,-3
    800094d4:	10079073          	csrw	sstatus,a5
    800094d8:	00813083          	ld	ra,8(sp)
    800094dc:	00013403          	ld	s0,0(sp)
    800094e0:	01010113          	addi	sp,sp,16
    800094e4:	00008067          	ret
    800094e8:	00001517          	auipc	a0,0x1
    800094ec:	54850513          	addi	a0,a0,1352 # 8000aa30 <digits+0x70>
    800094f0:	fffff097          	auipc	ra,0xfffff
    800094f4:	f2c080e7          	jalr	-212(ra) # 8000841c <panic>
    800094f8:	00001517          	auipc	a0,0x1
    800094fc:	51850513          	addi	a0,a0,1304 # 8000aa10 <digits+0x50>
    80009500:	fffff097          	auipc	ra,0xfffff
    80009504:	f1c080e7          	jalr	-228(ra) # 8000841c <panic>

0000000080009508 <__memset>:
    80009508:	ff010113          	addi	sp,sp,-16
    8000950c:	00813423          	sd	s0,8(sp)
    80009510:	01010413          	addi	s0,sp,16
    80009514:	1a060e63          	beqz	a2,800096d0 <__memset+0x1c8>
    80009518:	40a007b3          	neg	a5,a0
    8000951c:	0077f793          	andi	a5,a5,7
    80009520:	00778693          	addi	a3,a5,7
    80009524:	00b00813          	li	a6,11
    80009528:	0ff5f593          	andi	a1,a1,255
    8000952c:	fff6071b          	addiw	a4,a2,-1
    80009530:	1b06e663          	bltu	a3,a6,800096dc <__memset+0x1d4>
    80009534:	1cd76463          	bltu	a4,a3,800096fc <__memset+0x1f4>
    80009538:	1a078e63          	beqz	a5,800096f4 <__memset+0x1ec>
    8000953c:	00b50023          	sb	a1,0(a0)
    80009540:	00100713          	li	a4,1
    80009544:	1ae78463          	beq	a5,a4,800096ec <__memset+0x1e4>
    80009548:	00b500a3          	sb	a1,1(a0)
    8000954c:	00200713          	li	a4,2
    80009550:	1ae78a63          	beq	a5,a4,80009704 <__memset+0x1fc>
    80009554:	00b50123          	sb	a1,2(a0)
    80009558:	00300713          	li	a4,3
    8000955c:	18e78463          	beq	a5,a4,800096e4 <__memset+0x1dc>
    80009560:	00b501a3          	sb	a1,3(a0)
    80009564:	00400713          	li	a4,4
    80009568:	1ae78263          	beq	a5,a4,8000970c <__memset+0x204>
    8000956c:	00b50223          	sb	a1,4(a0)
    80009570:	00500713          	li	a4,5
    80009574:	1ae78063          	beq	a5,a4,80009714 <__memset+0x20c>
    80009578:	00b502a3          	sb	a1,5(a0)
    8000957c:	00700713          	li	a4,7
    80009580:	18e79e63          	bne	a5,a4,8000971c <__memset+0x214>
    80009584:	00b50323          	sb	a1,6(a0)
    80009588:	00700e93          	li	t4,7
    8000958c:	00859713          	slli	a4,a1,0x8
    80009590:	00e5e733          	or	a4,a1,a4
    80009594:	01059e13          	slli	t3,a1,0x10
    80009598:	01c76e33          	or	t3,a4,t3
    8000959c:	01859313          	slli	t1,a1,0x18
    800095a0:	006e6333          	or	t1,t3,t1
    800095a4:	02059893          	slli	a7,a1,0x20
    800095a8:	40f60e3b          	subw	t3,a2,a5
    800095ac:	011368b3          	or	a7,t1,a7
    800095b0:	02859813          	slli	a6,a1,0x28
    800095b4:	0108e833          	or	a6,a7,a6
    800095b8:	03059693          	slli	a3,a1,0x30
    800095bc:	003e589b          	srliw	a7,t3,0x3
    800095c0:	00d866b3          	or	a3,a6,a3
    800095c4:	03859713          	slli	a4,a1,0x38
    800095c8:	00389813          	slli	a6,a7,0x3
    800095cc:	00f507b3          	add	a5,a0,a5
    800095d0:	00e6e733          	or	a4,a3,a4
    800095d4:	000e089b          	sext.w	a7,t3
    800095d8:	00f806b3          	add	a3,a6,a5
    800095dc:	00e7b023          	sd	a4,0(a5)
    800095e0:	00878793          	addi	a5,a5,8
    800095e4:	fed79ce3          	bne	a5,a3,800095dc <__memset+0xd4>
    800095e8:	ff8e7793          	andi	a5,t3,-8
    800095ec:	0007871b          	sext.w	a4,a5
    800095f0:	01d787bb          	addw	a5,a5,t4
    800095f4:	0ce88e63          	beq	a7,a4,800096d0 <__memset+0x1c8>
    800095f8:	00f50733          	add	a4,a0,a5
    800095fc:	00b70023          	sb	a1,0(a4)
    80009600:	0017871b          	addiw	a4,a5,1
    80009604:	0cc77663          	bgeu	a4,a2,800096d0 <__memset+0x1c8>
    80009608:	00e50733          	add	a4,a0,a4
    8000960c:	00b70023          	sb	a1,0(a4)
    80009610:	0027871b          	addiw	a4,a5,2
    80009614:	0ac77e63          	bgeu	a4,a2,800096d0 <__memset+0x1c8>
    80009618:	00e50733          	add	a4,a0,a4
    8000961c:	00b70023          	sb	a1,0(a4)
    80009620:	0037871b          	addiw	a4,a5,3
    80009624:	0ac77663          	bgeu	a4,a2,800096d0 <__memset+0x1c8>
    80009628:	00e50733          	add	a4,a0,a4
    8000962c:	00b70023          	sb	a1,0(a4)
    80009630:	0047871b          	addiw	a4,a5,4
    80009634:	08c77e63          	bgeu	a4,a2,800096d0 <__memset+0x1c8>
    80009638:	00e50733          	add	a4,a0,a4
    8000963c:	00b70023          	sb	a1,0(a4)
    80009640:	0057871b          	addiw	a4,a5,5
    80009644:	08c77663          	bgeu	a4,a2,800096d0 <__memset+0x1c8>
    80009648:	00e50733          	add	a4,a0,a4
    8000964c:	00b70023          	sb	a1,0(a4)
    80009650:	0067871b          	addiw	a4,a5,6
    80009654:	06c77e63          	bgeu	a4,a2,800096d0 <__memset+0x1c8>
    80009658:	00e50733          	add	a4,a0,a4
    8000965c:	00b70023          	sb	a1,0(a4)
    80009660:	0077871b          	addiw	a4,a5,7
    80009664:	06c77663          	bgeu	a4,a2,800096d0 <__memset+0x1c8>
    80009668:	00e50733          	add	a4,a0,a4
    8000966c:	00b70023          	sb	a1,0(a4)
    80009670:	0087871b          	addiw	a4,a5,8
    80009674:	04c77e63          	bgeu	a4,a2,800096d0 <__memset+0x1c8>
    80009678:	00e50733          	add	a4,a0,a4
    8000967c:	00b70023          	sb	a1,0(a4)
    80009680:	0097871b          	addiw	a4,a5,9
    80009684:	04c77663          	bgeu	a4,a2,800096d0 <__memset+0x1c8>
    80009688:	00e50733          	add	a4,a0,a4
    8000968c:	00b70023          	sb	a1,0(a4)
    80009690:	00a7871b          	addiw	a4,a5,10
    80009694:	02c77e63          	bgeu	a4,a2,800096d0 <__memset+0x1c8>
    80009698:	00e50733          	add	a4,a0,a4
    8000969c:	00b70023          	sb	a1,0(a4)
    800096a0:	00b7871b          	addiw	a4,a5,11
    800096a4:	02c77663          	bgeu	a4,a2,800096d0 <__memset+0x1c8>
    800096a8:	00e50733          	add	a4,a0,a4
    800096ac:	00b70023          	sb	a1,0(a4)
    800096b0:	00c7871b          	addiw	a4,a5,12
    800096b4:	00c77e63          	bgeu	a4,a2,800096d0 <__memset+0x1c8>
    800096b8:	00e50733          	add	a4,a0,a4
    800096bc:	00b70023          	sb	a1,0(a4)
    800096c0:	00d7879b          	addiw	a5,a5,13
    800096c4:	00c7f663          	bgeu	a5,a2,800096d0 <__memset+0x1c8>
    800096c8:	00f507b3          	add	a5,a0,a5
    800096cc:	00b78023          	sb	a1,0(a5)
    800096d0:	00813403          	ld	s0,8(sp)
    800096d4:	01010113          	addi	sp,sp,16
    800096d8:	00008067          	ret
    800096dc:	00b00693          	li	a3,11
    800096e0:	e55ff06f          	j	80009534 <__memset+0x2c>
    800096e4:	00300e93          	li	t4,3
    800096e8:	ea5ff06f          	j	8000958c <__memset+0x84>
    800096ec:	00100e93          	li	t4,1
    800096f0:	e9dff06f          	j	8000958c <__memset+0x84>
    800096f4:	00000e93          	li	t4,0
    800096f8:	e95ff06f          	j	8000958c <__memset+0x84>
    800096fc:	00000793          	li	a5,0
    80009700:	ef9ff06f          	j	800095f8 <__memset+0xf0>
    80009704:	00200e93          	li	t4,2
    80009708:	e85ff06f          	j	8000958c <__memset+0x84>
    8000970c:	00400e93          	li	t4,4
    80009710:	e7dff06f          	j	8000958c <__memset+0x84>
    80009714:	00500e93          	li	t4,5
    80009718:	e75ff06f          	j	8000958c <__memset+0x84>
    8000971c:	00600e93          	li	t4,6
    80009720:	e6dff06f          	j	8000958c <__memset+0x84>

0000000080009724 <__memmove>:
    80009724:	ff010113          	addi	sp,sp,-16
    80009728:	00813423          	sd	s0,8(sp)
    8000972c:	01010413          	addi	s0,sp,16
    80009730:	0e060863          	beqz	a2,80009820 <__memmove+0xfc>
    80009734:	fff6069b          	addiw	a3,a2,-1
    80009738:	0006881b          	sext.w	a6,a3
    8000973c:	0ea5e863          	bltu	a1,a0,8000982c <__memmove+0x108>
    80009740:	00758713          	addi	a4,a1,7
    80009744:	00a5e7b3          	or	a5,a1,a0
    80009748:	40a70733          	sub	a4,a4,a0
    8000974c:	0077f793          	andi	a5,a5,7
    80009750:	00f73713          	sltiu	a4,a4,15
    80009754:	00174713          	xori	a4,a4,1
    80009758:	0017b793          	seqz	a5,a5
    8000975c:	00e7f7b3          	and	a5,a5,a4
    80009760:	10078863          	beqz	a5,80009870 <__memmove+0x14c>
    80009764:	00900793          	li	a5,9
    80009768:	1107f463          	bgeu	a5,a6,80009870 <__memmove+0x14c>
    8000976c:	0036581b          	srliw	a6,a2,0x3
    80009770:	fff8081b          	addiw	a6,a6,-1
    80009774:	02081813          	slli	a6,a6,0x20
    80009778:	01d85893          	srli	a7,a6,0x1d
    8000977c:	00858813          	addi	a6,a1,8
    80009780:	00058793          	mv	a5,a1
    80009784:	00050713          	mv	a4,a0
    80009788:	01088833          	add	a6,a7,a6
    8000978c:	0007b883          	ld	a7,0(a5)
    80009790:	00878793          	addi	a5,a5,8
    80009794:	00870713          	addi	a4,a4,8
    80009798:	ff173c23          	sd	a7,-8(a4)
    8000979c:	ff0798e3          	bne	a5,a6,8000978c <__memmove+0x68>
    800097a0:	ff867713          	andi	a4,a2,-8
    800097a4:	02071793          	slli	a5,a4,0x20
    800097a8:	0207d793          	srli	a5,a5,0x20
    800097ac:	00f585b3          	add	a1,a1,a5
    800097b0:	40e686bb          	subw	a3,a3,a4
    800097b4:	00f507b3          	add	a5,a0,a5
    800097b8:	06e60463          	beq	a2,a4,80009820 <__memmove+0xfc>
    800097bc:	0005c703          	lbu	a4,0(a1)
    800097c0:	00e78023          	sb	a4,0(a5)
    800097c4:	04068e63          	beqz	a3,80009820 <__memmove+0xfc>
    800097c8:	0015c603          	lbu	a2,1(a1)
    800097cc:	00100713          	li	a4,1
    800097d0:	00c780a3          	sb	a2,1(a5)
    800097d4:	04e68663          	beq	a3,a4,80009820 <__memmove+0xfc>
    800097d8:	0025c603          	lbu	a2,2(a1)
    800097dc:	00200713          	li	a4,2
    800097e0:	00c78123          	sb	a2,2(a5)
    800097e4:	02e68e63          	beq	a3,a4,80009820 <__memmove+0xfc>
    800097e8:	0035c603          	lbu	a2,3(a1)
    800097ec:	00300713          	li	a4,3
    800097f0:	00c781a3          	sb	a2,3(a5)
    800097f4:	02e68663          	beq	a3,a4,80009820 <__memmove+0xfc>
    800097f8:	0045c603          	lbu	a2,4(a1)
    800097fc:	00400713          	li	a4,4
    80009800:	00c78223          	sb	a2,4(a5)
    80009804:	00e68e63          	beq	a3,a4,80009820 <__memmove+0xfc>
    80009808:	0055c603          	lbu	a2,5(a1)
    8000980c:	00500713          	li	a4,5
    80009810:	00c782a3          	sb	a2,5(a5)
    80009814:	00e68663          	beq	a3,a4,80009820 <__memmove+0xfc>
    80009818:	0065c703          	lbu	a4,6(a1)
    8000981c:	00e78323          	sb	a4,6(a5)
    80009820:	00813403          	ld	s0,8(sp)
    80009824:	01010113          	addi	sp,sp,16
    80009828:	00008067          	ret
    8000982c:	02061713          	slli	a4,a2,0x20
    80009830:	02075713          	srli	a4,a4,0x20
    80009834:	00e587b3          	add	a5,a1,a4
    80009838:	f0f574e3          	bgeu	a0,a5,80009740 <__memmove+0x1c>
    8000983c:	02069613          	slli	a2,a3,0x20
    80009840:	02065613          	srli	a2,a2,0x20
    80009844:	fff64613          	not	a2,a2
    80009848:	00e50733          	add	a4,a0,a4
    8000984c:	00c78633          	add	a2,a5,a2
    80009850:	fff7c683          	lbu	a3,-1(a5)
    80009854:	fff78793          	addi	a5,a5,-1
    80009858:	fff70713          	addi	a4,a4,-1
    8000985c:	00d70023          	sb	a3,0(a4)
    80009860:	fec798e3          	bne	a5,a2,80009850 <__memmove+0x12c>
    80009864:	00813403          	ld	s0,8(sp)
    80009868:	01010113          	addi	sp,sp,16
    8000986c:	00008067          	ret
    80009870:	02069713          	slli	a4,a3,0x20
    80009874:	02075713          	srli	a4,a4,0x20
    80009878:	00170713          	addi	a4,a4,1
    8000987c:	00e50733          	add	a4,a0,a4
    80009880:	00050793          	mv	a5,a0
    80009884:	0005c683          	lbu	a3,0(a1)
    80009888:	00178793          	addi	a5,a5,1
    8000988c:	00158593          	addi	a1,a1,1
    80009890:	fed78fa3          	sb	a3,-1(a5)
    80009894:	fee798e3          	bne	a5,a4,80009884 <__memmove+0x160>
    80009898:	f89ff06f          	j	80009820 <__memmove+0xfc>
	...
