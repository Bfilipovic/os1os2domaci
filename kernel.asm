
kernel:     file format elf64-littleriscv


Disassembly of section .text:

0000000080000000 <_entry>:
    80000000:	0000d117          	auipc	sp,0xd
    80000004:	cf813103          	ld	sp,-776(sp) # 8000ccf8 <_GLOBAL_OFFSET_TABLE_+0x38>
    80000008:	00001537          	lui	a0,0x1
    8000000c:	f14025f3          	csrr	a1,mhartid
    80000010:	00158593          	addi	a1,a1,1
    80000014:	02b50533          	mul	a0,a0,a1
    80000018:	00a10133          	add	sp,sp,a0
    8000001c:	285070ef          	jal	ra,80007aa0 <start>

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
    800010c8:	1f9020ef          	jal	ra,80003ac0 <handleInterrupt>

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
    800011d4:	65c020ef          	jal	ra,80003830 <handleEcall>
    
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
    800012a0:	55c080e7          	jalr	1372(ra) # 800037f8 <_Z12kern_syscall13SyscallNumberz>
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
    800012dc:	520080e7          	jalr	1312(ra) # 800037f8 <_Z12kern_syscall13SyscallNumberz>
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
    80001350:	4ac080e7          	jalr	1196(ra) # 800037f8 <_Z12kern_syscall13SyscallNumberz>
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
    800013a0:	45c080e7          	jalr	1116(ra) # 800037f8 <_Z12kern_syscall13SyscallNumberz>
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
    800013c8:	0000c797          	auipc	a5,0xc
    800013cc:	9187b783          	ld	a5,-1768(a5) # 8000cce0 <_GLOBAL_OFFSET_TABLE_+0x20>
    800013d0:	0007b783          	ld	a5,0(a5)
    800013d4:	0407b483          	ld	s1,64(a5)
    kern_syscall(THREAD_EXIT);
    800013d8:	01200513          	li	a0,18
    800013dc:	00002097          	auipc	ra,0x2
    800013e0:	41c080e7          	jalr	1052(ra) # 800037f8 <_Z12kern_syscall13SyscallNumberz>
    kern_syscall(MEM_FREE,stack);
    800013e4:	00048593          	mv	a1,s1
    800013e8:	00200513          	li	a0,2
    800013ec:	00002097          	auipc	ra,0x2
    800013f0:	40c080e7          	jalr	1036(ra) # 800037f8 <_Z12kern_syscall13SyscallNumberz>
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
    80001428:	3d4080e7          	jalr	980(ra) # 800037f8 <_Z12kern_syscall13SyscallNumberz>
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
    8000145c:	3a0080e7          	jalr	928(ra) # 800037f8 <_Z12kern_syscall13SyscallNumberz>
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
    8000149c:	360080e7          	jalr	864(ra) # 800037f8 <_Z12kern_syscall13SyscallNumberz>
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
    800014dc:	320080e7          	jalr	800(ra) # 800037f8 <_Z12kern_syscall13SyscallNumberz>
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
    8000151c:	2e0080e7          	jalr	736(ra) # 800037f8 <_Z12kern_syscall13SyscallNumberz>
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
    8000155c:	2a0080e7          	jalr	672(ra) # 800037f8 <_Z12kern_syscall13SyscallNumberz>
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
    8000158c:	270080e7          	jalr	624(ra) # 800037f8 <_Z12kern_syscall13SyscallNumberz>
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
    800015cc:	230080e7          	jalr	560(ra) # 800037f8 <_Z12kern_syscall13SyscallNumberz>
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
    800015f8:	75c4b483          	ld	s1,1884(s1) # 8000cd50 <bba_allocatedBlocks>
    while (curr){
    800015fc:	04048263          	beqz	s1,80001640 <_Z26bba_print_used_blocks_infov+0x60>
        printf("\nBlock of size %d is allocated on addr start+%lx and its descriptor is located at start+%lx (%lx), ends at start+%lx", curr->n, curr->addr-buddyMemStart, (char*)curr-buddyMemStart,curr,curr->addr-buddyMemStart+(1<<curr->n));
    80001600:	0084a583          	lw	a1,8(s1)
    80001604:	0104b603          	ld	a2,16(s1)
    80001608:	0000b697          	auipc	a3,0xb
    8000160c:	7506b683          	ld	a3,1872(a3) # 8000cd58 <buddyMemStart>
    80001610:	40d60633          	sub	a2,a2,a3
    80001614:	00100793          	li	a5,1
    80001618:	00b797bb          	sllw	a5,a5,a1
    8000161c:	00f607b3          	add	a5,a2,a5
    80001620:	00048713          	mv	a4,s1
    80001624:	40d486b3          	sub	a3,s1,a3
    80001628:	00009517          	auipc	a0,0x9
    8000162c:	9f850513          	addi	a0,a0,-1544 # 8000a020 <CONSOLE_STATUS+0x10>
    80001630:	00001097          	auipc	ra,0x1
    80001634:	c10080e7          	jalr	-1008(ra) # 80002240 <_Z6printfPKcz>
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
    80001678:	bcc080e7          	jalr	-1076(ra) # 80002240 <_Z6printfPKcz>
    for (int i=0;i<18;i++){
    8000167c:	00000913          	li	s2,0
    80001680:	0400006f          	j	800016c0 <_Z26bba_print_free_blocks_infov+0x6c>
        bba_block_t* p = buddyBlocks[i];
        while (p!=0){
            printf("\n block of size %d (n=%d) at address start+%p (%p), ends at start+%p",(1<<i), i, (char*)p-buddyMemStart,p,(char*)p-buddyMemStart+(1<<i));
    80001684:	00100593          	li	a1,1
    80001688:	012595bb          	sllw	a1,a1,s2
    8000168c:	0000b697          	auipc	a3,0xb
    80001690:	6cc6b683          	ld	a3,1740(a3) # 8000cd58 <buddyMemStart>
    80001694:	40d486b3          	sub	a3,s1,a3
    80001698:	00b687b3          	add	a5,a3,a1
    8000169c:	00048713          	mv	a4,s1
    800016a0:	00090613          	mv	a2,s2
    800016a4:	00009517          	auipc	a0,0x9
    800016a8:	a0450513          	addi	a0,a0,-1532 # 8000a0a8 <CONSOLE_STATUS+0x98>
    800016ac:	00001097          	auipc	ra,0x1
    800016b0:	b94080e7          	jalr	-1132(ra) # 80002240 <_Z6printfPKcz>
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
    800016d0:	68478793          	addi	a5,a5,1668 # 8000cd50 <bba_allocatedBlocks>
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
    800016f8:	ff010113          	addi	sp,sp,-16
    800016fc:	00813423          	sd	s0,8(sp)
    80001700:	01010413          	addi	s0,sp,16

    //printf("\noldStart: %ld", (long)start);
    if((long)start%MINBBSIZE!=0) start = (char*) (( ((long)start / MINBBSIZE) +1)*MINBBSIZE); //align start to MINBBSIZE
    80001704:	01f57793          	andi	a5,a0,31
    80001708:	00078e63          	beqz	a5,80001724 <_Z8bba_initPcS_+0x2c>
    8000170c:	43f55793          	srai	a5,a0,0x3f
    80001710:	01f7f793          	andi	a5,a5,31
    80001714:	00f50533          	add	a0,a0,a5
    80001718:	40555513          	srai	a0,a0,0x5
    8000171c:	00150513          	addi	a0,a0,1
    80001720:	00551513          	slli	a0,a0,0x5
    if((long)end%MINBBSIZE!=0) end = (char*) (( ((long)end / MINBBSIZE) -1)*MINBBSIZE); //align end to MINBBSIZE
    80001724:	01f5f793          	andi	a5,a1,31
    80001728:	00078e63          	beqz	a5,80001744 <_Z8bba_initPcS_+0x4c>
    8000172c:	43f5d793          	srai	a5,a1,0x3f
    80001730:	01f7f793          	andi	a5,a5,31
    80001734:	00f585b3          	add	a1,a1,a5
    80001738:	4055d593          	srai	a1,a1,0x5
    8000173c:	fff58593          	addi	a1,a1,-1
    80001740:	00559593          	slli	a1,a1,0x5
    //printf("\nstart: %ld", (long)start);
    //printf("\nend: %ld", (long)end);
    buddyMemStart=start;
    80001744:	0000b797          	auipc	a5,0xb
    80001748:	60c78793          	addi	a5,a5,1548 # 8000cd50 <bba_allocatedBlocks>
    8000174c:	00a7b423          	sd	a0,8(a5)
    buddyMemEnd=end;
    80001750:	0ab7b023          	sd	a1,160(a5)

    //printf("\nspace size=%d", end-start);

    for(int i=0;i<17;i++){
    80001754:	00000793          	li	a5,0
    80001758:	01000713          	li	a4,16
    8000175c:	06f74863          	blt	a4,a5,800017cc <_Z8bba_initPcS_+0xd4>
        buddyBlocks[i] = 0;
    80001760:	00379693          	slli	a3,a5,0x3
    80001764:	0000b717          	auipc	a4,0xb
    80001768:	5ec70713          	addi	a4,a4,1516 # 8000cd50 <bba_allocatedBlocks>
    8000176c:	00d70733          	add	a4,a4,a3
    80001770:	00073823          	sd	zero,16(a4)
    for(int i=0;i<17;i++){
    80001774:	0017879b          	addiw	a5,a5,1
    80001778:	fe1ff06f          	j	80001758 <_Z8bba_initPcS_+0x60>

    int allocatedSize = 0;
    while(a<end){
        //printf("\n a=%ld",(long)a);
        int n=5;
        while(a+(1<<n)<=end && n<18) n++; // maximum block size is 2^17
    8000177c:	0017071b          	addiw	a4,a4,1
    80001780:	00100793          	li	a5,1
    80001784:	00e797bb          	sllw	a5,a5,a4
    80001788:	00f507b3          	add	a5,a0,a5
    8000178c:	00f5e663          	bltu	a1,a5,80001798 <_Z8bba_initPcS_+0xa0>
    80001790:	01100793          	li	a5,17
    80001794:	fee7d4e3          	bge	a5,a4,8000177c <_Z8bba_initPcS_+0x84>
        n--;
    80001798:	fff7071b          	addiw	a4,a4,-1
    8000179c:	0007069b          	sext.w	a3,a4

        bba_block_t *newBlock = (bba_block_t*) a;
        newBlock->n=n;
    800017a0:	00e52423          	sw	a4,8(a0)
        newBlock->next=buddyBlocks[n];
    800017a4:	00369713          	slli	a4,a3,0x3
    800017a8:	0000b797          	auipc	a5,0xb
    800017ac:	5a878793          	addi	a5,a5,1448 # 8000cd50 <bba_allocatedBlocks>
    800017b0:	00e787b3          	add	a5,a5,a4
    800017b4:	0107b703          	ld	a4,16(a5)
    800017b8:	00e53023          	sd	a4,0(a0)
        buddyBlocks[n] = newBlock; //ulancavamo novi blok na pocetak liste
    800017bc:	00a7b823          	sd	a0,16(a5)

        //printf("\n n=%d, block of size %ld allocated at %ld",n,(1<<n), (long)a);
        allocatedSize+=(1<<n);
    800017c0:	00100793          	li	a5,1
    800017c4:	00d797bb          	sllw	a5,a5,a3
        a+=(1<<n);
    800017c8:	00f50533          	add	a0,a0,a5
    while(a<end){
    800017cc:	00b57663          	bgeu	a0,a1,800017d8 <_Z8bba_initPcS_+0xe0>
        int n=5;
    800017d0:	00500713          	li	a4,5
    800017d4:	fadff06f          	j	80001780 <_Z8bba_initPcS_+0x88>
    }


    //printf("\nallocatedSize=%d\n",allocatedSize);
    //bba_print_free_blocks_info();
}
    800017d8:	00813403          	ld	s0,8(sp)
    800017dc:	01010113          	addi	sp,sp,16
    800017e0:	00008067          	ret

00000000800017e4 <_Z9bba_spliti>:

void bba_split(int n) //blok velicine n deli na 2 velicine n-1, ne alocira nista, ulancava oba nova bloka
{
    if(n==0) return;
    800017e4:	0a050063          	beqz	a0,80001884 <_Z9bba_spliti+0xa0>
    bba_block_t* addr = buddyBlocks[n];
    800017e8:	00351713          	slli	a4,a0,0x3
    800017ec:	0000b797          	auipc	a5,0xb
    800017f0:	56478793          	addi	a5,a5,1380 # 8000cd50 <bba_allocatedBlocks>
    800017f4:	00e787b3          	add	a5,a5,a4
    800017f8:	0107b703          	ld	a4,16(a5)
    if(addr==0){
    800017fc:	04070a63          	beqz	a4,80001850 <_Z9bba_spliti+0x6c>
        printf("\ncant split block of size %d, there are no blocks of that size",n);
        return;
    }
    //printf("\nsplitting block of size %d into two smaller blocks...",n);
    buddyBlocks[n] = addr->next; //izbacujemo
    80001800:	00073603          	ld	a2,0(a4)
    80001804:	0000b697          	auipc	a3,0xb
    80001808:	54c68693          	addi	a3,a3,1356 # 8000cd50 <bba_allocatedBlocks>
    8000180c:	00351793          	slli	a5,a0,0x3
    80001810:	00f687b3          	add	a5,a3,a5
    80001814:	00c7b823          	sd	a2,16(a5)
    bba_block_t* half = (bba_block_t*) ((long )addr+(1<<(n-1))); //polovina starog bloka
    80001818:	fff5051b          	addiw	a0,a0,-1
    8000181c:	0005061b          	sext.w	a2,a0
    80001820:	00100793          	li	a5,1
    80001824:	00a797bb          	sllw	a5,a5,a0
    80001828:	00f707b3          	add	a5,a4,a5
    half->n=n-1;
    8000182c:	00a7a423          	sw	a0,8(a5)
    addr->n=n-1;
    80001830:	00a72423          	sw	a0,8(a4)
    half->next=buddyBlocks[n-1];
    80001834:	00361613          	slli	a2,a2,0x3
    80001838:	00c686b3          	add	a3,a3,a2
    8000183c:	0106b603          	ld	a2,16(a3)
    80001840:	00c7b023          	sd	a2,0(a5)
    addr->next=half;
    80001844:	00f73023          	sd	a5,0(a4)
    buddyBlocks[n-1]=addr;
    80001848:	00e6b823          	sd	a4,16(a3)
    8000184c:	00008067          	ret
{
    80001850:	ff010113          	addi	sp,sp,-16
    80001854:	00113423          	sd	ra,8(sp)
    80001858:	00813023          	sd	s0,0(sp)
    8000185c:	01010413          	addi	s0,sp,16
        printf("\ncant split block of size %d, there are no blocks of that size",n);
    80001860:	00050593          	mv	a1,a0
    80001864:	00009517          	auipc	a0,0x9
    80001868:	88c50513          	addi	a0,a0,-1908 # 8000a0f0 <CONSOLE_STATUS+0xe0>
    8000186c:	00001097          	auipc	ra,0x1
    80001870:	9d4080e7          	jalr	-1580(ra) # 80002240 <_Z6printfPKcz>
}
    80001874:	00813083          	ld	ra,8(sp)
    80001878:	00013403          	ld	s0,0(sp)
    8000187c:	01010113          	addi	sp,sp,16
    80001880:	00008067          	ret
    80001884:	00008067          	ret

0000000080001888 <_Z13bba_get_blocki>:

//nalazi ili kreira i vraca blok velicine 2^n
bba_block_t * bba_get_block(int size)
{
    if(size<MINBBSIZE) size=MINBBSIZE;
    80001888:	01f00793          	li	a5,31
    8000188c:	00a7da63          	bge	a5,a0,800018a0 <_Z13bba_get_blocki+0x18>
    if(size>MAXBBSIZE) return 0;
    80001890:	000207b7          	lui	a5,0x20
    80001894:	00a7d863          	bge	a5,a0,800018a4 <_Z13bba_get_blocki+0x1c>
    80001898:	00000513          	li	a0,0
            return buddyBlocks[n];
        }
    }

    return 0;
}
    8000189c:	00008067          	ret
    if(size<MINBBSIZE) size=MINBBSIZE;
    800018a0:	02000513          	li	a0,32
{
    800018a4:	fe010113          	addi	sp,sp,-32
    800018a8:	00113c23          	sd	ra,24(sp)
    800018ac:	00813823          	sd	s0,16(sp)
    800018b0:	00913423          	sd	s1,8(sp)
    800018b4:	01213023          	sd	s2,0(sp)
    800018b8:	02010413          	addi	s0,sp,32
    if(size<MINBBSIZE) size=MINBBSIZE;
    800018bc:	00500493          	li	s1,5
    800018c0:	0080006f          	j	800018c8 <_Z13bba_get_blocki+0x40>
    while((1<<n)<size && n<18) n++;
    800018c4:	0014849b          	addiw	s1,s1,1
    800018c8:	00100793          	li	a5,1
    800018cc:	009797bb          	sllw	a5,a5,s1
    800018d0:	00a7d663          	bge	a5,a0,800018dc <_Z13bba_get_blocki+0x54>
    800018d4:	01100793          	li	a5,17
    800018d8:	fe97d6e3          	bge	a5,s1,800018c4 <_Z13bba_get_blocki+0x3c>
    if(buddyBlocks[n]!=0){ //imamo blok tacno te velicine
    800018dc:	00349713          	slli	a4,s1,0x3
    800018e0:	0000b797          	auipc	a5,0xb
    800018e4:	47078793          	addi	a5,a5,1136 # 8000cd50 <bba_allocatedBlocks>
    800018e8:	00e787b3          	add	a5,a5,a4
    800018ec:	0107b503          	ld	a0,16(a5)
    800018f0:	00050e63          	beqz	a0,8000190c <_Z13bba_get_blocki+0x84>
}
    800018f4:	01813083          	ld	ra,24(sp)
    800018f8:	01013403          	ld	s0,16(sp)
    800018fc:	00813483          	ld	s1,8(sp)
    80001900:	00013903          	ld	s2,0(sp)
    80001904:	02010113          	addi	sp,sp,32
    80001908:	00008067          	ret
    for(int i=n+1;i<18;i++){
    8000190c:	0014891b          	addiw	s2,s1,1
    80001910:	01100793          	li	a5,17
    80001914:	ff27c0e3          	blt	a5,s2,800018f4 <_Z13bba_get_blocki+0x6c>
        if(buddyBlocks[i]!=0){
    80001918:	00391713          	slli	a4,s2,0x3
    8000191c:	0000b797          	auipc	a5,0xb
    80001920:	43478793          	addi	a5,a5,1076 # 8000cd50 <bba_allocatedBlocks>
    80001924:	00e787b3          	add	a5,a5,a4
    80001928:	0107b783          	ld	a5,16(a5)
    8000192c:	00079663          	bnez	a5,80001938 <_Z13bba_get_blocki+0xb0>
    for(int i=n+1;i<18;i++){
    80001930:	0019091b          	addiw	s2,s2,1
    80001934:	fddff06f          	j	80001910 <_Z13bba_get_blocki+0x88>
            while(i>n){
    80001938:	0124dc63          	bge	s1,s2,80001950 <_Z13bba_get_blocki+0xc8>
                bba_split(i);
    8000193c:	00090513          	mv	a0,s2
    80001940:	00000097          	auipc	ra,0x0
    80001944:	ea4080e7          	jalr	-348(ra) # 800017e4 <_Z9bba_spliti>
                i--;
    80001948:	fff9091b          	addiw	s2,s2,-1
            while(i>n){
    8000194c:	fedff06f          	j	80001938 <_Z13bba_get_blocki+0xb0>
            return buddyBlocks[n];
    80001950:	00349493          	slli	s1,s1,0x3
    80001954:	0000b797          	auipc	a5,0xb
    80001958:	3fc78793          	addi	a5,a5,1020 # 8000cd50 <bba_allocatedBlocks>
    8000195c:	009784b3          	add	s1,a5,s1
    80001960:	0104b503          	ld	a0,16(s1)
    80001964:	f91ff06f          	j	800018f4 <_Z13bba_get_blocki+0x6c>

0000000080001968 <_Z16bba_can_allocatei>:
int bba_can_allocate(int n)
{
    int index=0;

    //mozemo li smestiti blok
    for(int i=n;i<18;i++){
    80001968:	00050793          	mv	a5,a0
    8000196c:	01100713          	li	a4,17
    80001970:	02f74863          	blt	a4,a5,800019a0 <_Z16bba_can_allocatei+0x38>
        if(buddyBlocks[i]!=0) {
    80001974:	00379693          	slli	a3,a5,0x3
    80001978:	0000b717          	auipc	a4,0xb
    8000197c:	3d870713          	addi	a4,a4,984 # 8000cd50 <bba_allocatedBlocks>
    80001980:	00d70733          	add	a4,a4,a3
    80001984:	01073703          	ld	a4,16(a4)
    80001988:	00071663          	bnez	a4,80001994 <_Z16bba_can_allocatei+0x2c>
    for(int i=n;i<18;i++){
    8000198c:	0017879b          	addiw	a5,a5,1
    80001990:	fddff06f          	j	8000196c <_Z16bba_can_allocatei+0x4>
            if(i>n) return 1;
    80001994:	00f55863          	bge	a0,a5,800019a4 <_Z16bba_can_allocatei+0x3c>
    80001998:	00100513          	li	a0,1
    8000199c:	00008067          	ret
    int index=0;
    800019a0:	00000793          	li	a5,0
        }
    }

    //za svakio alocirani blok pravimo i jedan mali blok (deskriptor) sa metapodacima - ovde proveravamo da li imamo
    // mesta i za taj mali blok
    for(int i=5;i<18;i++){
    800019a4:	00500713          	li	a4,5
    800019a8:	0080006f          	j	800019b0 <_Z16bba_can_allocatei+0x48>
    800019ac:	0017071b          	addiw	a4,a4,1
    800019b0:	01100693          	li	a3,17
    800019b4:	02e6c863          	blt	a3,a4,800019e4 <_Z16bba_can_allocatei+0x7c>
        if(buddyBlocks[i]!=0){
    800019b8:	00371613          	slli	a2,a4,0x3
    800019bc:	0000b697          	auipc	a3,0xb
    800019c0:	39468693          	addi	a3,a3,916 # 8000cd50 <bba_allocatedBlocks>
    800019c4:	00c686b3          	add	a3,a3,a2
    800019c8:	0106b683          	ld	a3,16(a3)
    800019cc:	fe0680e3          	beqz	a3,800019ac <_Z16bba_can_allocatei+0x44>
            if(i!=index || buddyBlocks[i]->next!=0) return 1;
    800019d0:	04e79463          	bne	a5,a4,80001a18 <_Z16bba_can_allocatei+0xb0>
    800019d4:	0006b683          	ld	a3,0(a3)
    800019d8:	fc068ae3          	beqz	a3,800019ac <_Z16bba_can_allocatei+0x44>
    800019dc:	00100513          	li	a0,1
        }
    }

    printf("\n alloc error - cant allocate");
    return 0;
}
    800019e0:	00008067          	ret
{
    800019e4:	ff010113          	addi	sp,sp,-16
    800019e8:	00113423          	sd	ra,8(sp)
    800019ec:	00813023          	sd	s0,0(sp)
    800019f0:	01010413          	addi	s0,sp,16
    printf("\n alloc error - cant allocate");
    800019f4:	00008517          	auipc	a0,0x8
    800019f8:	73c50513          	addi	a0,a0,1852 # 8000a130 <CONSOLE_STATUS+0x120>
    800019fc:	00001097          	auipc	ra,0x1
    80001a00:	844080e7          	jalr	-1980(ra) # 80002240 <_Z6printfPKcz>
    return 0;
    80001a04:	00000513          	li	a0,0
}
    80001a08:	00813083          	ld	ra,8(sp)
    80001a0c:	00013403          	ld	s0,0(sp)
    80001a10:	01010113          	addi	sp,sp,16
    80001a14:	00008067          	ret
            if(i!=index || buddyBlocks[i]->next!=0) return 1;
    80001a18:	00100513          	li	a0,1
    80001a1c:	00008067          	ret

0000000080001a20 <_Z12bba_allocatem>:

void* bba_allocate(unsigned long size)
{
    80001a20:	fd010113          	addi	sp,sp,-48
    80001a24:	02113423          	sd	ra,40(sp)
    80001a28:	02813023          	sd	s0,32(sp)
    80001a2c:	00913c23          	sd	s1,24(sp)
    80001a30:	01213823          	sd	s2,16(sp)
    80001a34:	01313423          	sd	s3,8(sp)
    80001a38:	03010413          	addi	s0,sp,48

    if(size<MINBBSIZE) size=MINBBSIZE;
    80001a3c:	01f00793          	li	a5,31
    80001a40:	00a7fc63          	bgeu	a5,a0,80001a58 <_Z12bba_allocatem+0x38>
    80001a44:	00050913          	mv	s2,a0
    if(size>MAXBBSIZE) return 0;
    80001a48:	000207b7          	lui	a5,0x20
    80001a4c:	00a7f863          	bgeu	a5,a0,80001a5c <_Z12bba_allocatem+0x3c>
    80001a50:	00000913          	li	s2,0
    80001a54:	0880006f          	j	80001adc <_Z12bba_allocatem+0xbc>
    if(size<MINBBSIZE) size=MINBBSIZE;
    80001a58:	02000913          	li	s2,32
    80001a5c:	00500493          	li	s1,5
    80001a60:	0080006f          	j	80001a68 <_Z12bba_allocatem+0x48>
    int n=5;
    while((1UL<<n)<size && n<18) n++;
    80001a64:	0014849b          	addiw	s1,s1,1
    80001a68:	00100793          	li	a5,1
    80001a6c:	009797b3          	sll	a5,a5,s1
    80001a70:	0127f663          	bgeu	a5,s2,80001a7c <_Z12bba_allocatem+0x5c>
    80001a74:	01100793          	li	a5,17
    80001a78:	fe97d6e3          	bge	a5,s1,80001a64 <_Z12bba_allocatem+0x44>


    if(bba_can_allocate(n)==0) return 0;
    80001a7c:	00048513          	mv	a0,s1
    80001a80:	00000097          	auipc	ra,0x0
    80001a84:	ee8080e7          	jalr	-280(ra) # 80001968 <_Z16bba_can_allocatei>
    80001a88:	06050a63          	beqz	a0,80001afc <_Z12bba_allocatem+0xdc>

    bba_block_t *newBlock=0;
    bba_block_t *descriptor=0;

    newBlock = bba_get_block(size);
    80001a8c:	0009051b          	sext.w	a0,s2
    80001a90:	00000097          	auipc	ra,0x0
    80001a94:	df8080e7          	jalr	-520(ra) # 80001888 <_Z13bba_get_blocki>
    80001a98:	00050913          	mv	s2,a0
    buddyBlocks[n] = newBlock->next;
    80001a9c:	00053703          	ld	a4,0(a0)
    80001aa0:	0000b997          	auipc	s3,0xb
    80001aa4:	2b098993          	addi	s3,s3,688 # 8000cd50 <bba_allocatedBlocks>
    80001aa8:	00349793          	slli	a5,s1,0x3
    80001aac:	00f987b3          	add	a5,s3,a5
    80001ab0:	00e7b823          	sd	a4,16(a5) # 20010 <_entry-0x7ffdfff0>

    descriptor = bba_get_block(sizeof(bba_block_t));
    80001ab4:	01800513          	li	a0,24
    80001ab8:	00000097          	auipc	ra,0x0
    80001abc:	dd0080e7          	jalr	-560(ra) # 80001888 <_Z13bba_get_blocki>
    buddyBlocks[5] = descriptor->next;
    80001ac0:	00053783          	ld	a5,0(a0)
    80001ac4:	02f9bc23          	sd	a5,56(s3)


    //ulancavamo deskriptor
    descriptor->next=bba_allocatedBlocks;
    80001ac8:	0009b783          	ld	a5,0(s3)
    80001acc:	00f53023          	sd	a5,0(a0)
    bba_allocatedBlocks=descriptor;
    80001ad0:	00a9b023          	sd	a0,0(s3)
    descriptor->n=n;
    80001ad4:	00952423          	sw	s1,8(a0)
    descriptor->addr=(char*)newBlock;
    80001ad8:	01253823          	sd	s2,16(a0)

    return newBlock;

}
    80001adc:	00090513          	mv	a0,s2
    80001ae0:	02813083          	ld	ra,40(sp)
    80001ae4:	02013403          	ld	s0,32(sp)
    80001ae8:	01813483          	ld	s1,24(sp)
    80001aec:	01013903          	ld	s2,16(sp)
    80001af0:	00813983          	ld	s3,8(sp)
    80001af4:	03010113          	addi	sp,sp,48
    80001af8:	00008067          	ret
    if(bba_can_allocate(n)==0) return 0;
    80001afc:	00000913          	li	s2,0
    80001b00:	fddff06f          	j	80001adc <_Z12bba_allocatem+0xbc>

0000000080001b04 <_Z26bba_try_merge_single_blockP9bba_blocki>:

/*
 * ako moze da spoji, izlancava ukrupnjeni blok (prosledjeni blok nije ni bio ulancan ) i vraca adresu ukrupnjenog bloka, ako ne moze vraca null
 */
bba_block_t * bba_try_merge_single_block(bba_block_t* freedBlock, int n)
{
    80001b04:	ff010113          	addi	sp,sp,-16
    80001b08:	00813423          	sd	s0,8(sp)
    80001b0c:	01010413          	addi	s0,sp,16
    80001b10:	00050693          	mv	a3,a0
    long size = (1<<n);
    80001b14:	00100613          	li	a2,1
    80001b18:	00b6163b          	sllw	a2,a2,a1
    bba_block_t *curr = buddyBlocks[n];
    80001b1c:	0000b717          	auipc	a4,0xb
    80001b20:	23470713          	addi	a4,a4,564 # 8000cd50 <bba_allocatedBlocks>
    80001b24:	00359793          	slli	a5,a1,0x3
    80001b28:	00f707b3          	add	a5,a4,a5
    80001b2c:	0107b503          	ld	a0,16(a5)
    bba_block_t *prev=0;

    int odd = (((char*)freedBlock-buddyMemStart)/size)%2;
    80001b30:	00873703          	ld	a4,8(a4)
    80001b34:	40e68733          	sub	a4,a3,a4
    80001b38:	02c74733          	div	a4,a4,a2
    80001b3c:	03f75813          	srli	a6,a4,0x3f
    80001b40:	010707b3          	add	a5,a4,a6
    80001b44:	0017f793          	andi	a5,a5,1
    80001b48:	410787b3          	sub	a5,a5,a6
    bba_block_t *prev=0;
    80001b4c:	00000813          	li	a6,0
    80001b50:	05c0006f          	j	80001bac <_Z26bba_try_merge_single_blockP9bba_blocki+0xa8>

    while (curr!=0){
        if(odd==1 && (long)curr+size==(long)freedBlock){
    80001b54:	00c50733          	add	a4,a0,a2
    80001b58:	06d71063          	bne	a4,a3,80001bb8 <_Z26bba_try_merge_single_blockP9bba_blocki+0xb4>
            if(prev!=0) prev->next=curr->next;
    80001b5c:	00080863          	beqz	a6,80001b6c <_Z26bba_try_merge_single_blockP9bba_blocki+0x68>
    80001b60:	00053783          	ld	a5,0(a0)
    80001b64:	00f83023          	sd	a5,0(a6)
    80001b68:	06c0006f          	j	80001bd4 <_Z26bba_try_merge_single_blockP9bba_blocki+0xd0>
            else buddyBlocks[n]=curr->next;
    80001b6c:	00053703          	ld	a4,0(a0)
    80001b70:	00359593          	slli	a1,a1,0x3
    80001b74:	0000b797          	auipc	a5,0xb
    80001b78:	1dc78793          	addi	a5,a5,476 # 8000cd50 <bba_allocatedBlocks>
    80001b7c:	00b785b3          	add	a1,a5,a1
    80001b80:	00e5b823          	sd	a4,16(a1)
            return curr;
    80001b84:	0500006f          	j	80001bd4 <_Z26bba_try_merge_single_blockP9bba_blocki+0xd0>
        }
        if(odd==0 && (long)curr-size==(long)freedBlock){
            if(prev!=0) prev->next=curr->next;
            else buddyBlocks[n]=curr->next;
    80001b88:	00053703          	ld	a4,0(a0)
    80001b8c:	00359593          	slli	a1,a1,0x3
    80001b90:	0000b797          	auipc	a5,0xb
    80001b94:	1c078793          	addi	a5,a5,448 # 8000cd50 <bba_allocatedBlocks>
    80001b98:	00b785b3          	add	a1,a5,a1
    80001b9c:	00e5b823          	sd	a4,16(a1)
    80001ba0:	0300006f          	j	80001bd0 <_Z26bba_try_merge_single_blockP9bba_blocki+0xcc>
            return freedBlock;
        }
        prev=curr;
    80001ba4:	00050813          	mv	a6,a0
        curr=curr->next;
    80001ba8:	00053503          	ld	a0,0(a0)
    while (curr!=0){
    80001bac:	02050463          	beqz	a0,80001bd4 <_Z26bba_try_merge_single_blockP9bba_blocki+0xd0>
        if(odd==1 && (long)curr+size==(long)freedBlock){
    80001bb0:	00100713          	li	a4,1
    80001bb4:	fae780e3          	beq	a5,a4,80001b54 <_Z26bba_try_merge_single_blockP9bba_blocki+0x50>
        if(odd==0 && (long)curr-size==(long)freedBlock){
    80001bb8:	fe0796e3          	bnez	a5,80001ba4 <_Z26bba_try_merge_single_blockP9bba_blocki+0xa0>
    80001bbc:	40c50733          	sub	a4,a0,a2
    80001bc0:	fed712e3          	bne	a4,a3,80001ba4 <_Z26bba_try_merge_single_blockP9bba_blocki+0xa0>
            if(prev!=0) prev->next=curr->next;
    80001bc4:	fc0802e3          	beqz	a6,80001b88 <_Z26bba_try_merge_single_blockP9bba_blocki+0x84>
    80001bc8:	00053783          	ld	a5,0(a0)
    80001bcc:	00f83023          	sd	a5,0(a6)
            return freedBlock;
    80001bd0:	00068513          	mv	a0,a3
    }
    return 0;
}
    80001bd4:	00813403          	ld	s0,8(sp)
    80001bd8:	01010113          	addi	sp,sp,16
    80001bdc:	00008067          	ret

0000000080001be0 <_Z16bba_merge_blocksP9bba_blocki>:

void bba_merge_blocks(bba_block_t* freedBlock, int n)
{
    80001be0:	fe010113          	addi	sp,sp,-32
    80001be4:	00113c23          	sd	ra,24(sp)
    80001be8:	00813823          	sd	s0,16(sp)
    80001bec:	00913423          	sd	s1,8(sp)
    80001bf0:	01213023          	sd	s2,0(sp)
    80001bf4:	02010413          	addi	s0,sp,32
    80001bf8:	00050913          	mv	s2,a0
    80001bfc:	00058493          	mv	s1,a1
    bba_block_t * mergedBlock = 0;
    while (n<17){
    80001c00:	01000793          	li	a5,16
    80001c04:	0297c263          	blt	a5,s1,80001c28 <_Z16bba_merge_blocksP9bba_blocki+0x48>
        mergedBlock=bba_try_merge_single_block(freedBlock,n);
    80001c08:	00048593          	mv	a1,s1
    80001c0c:	00090513          	mv	a0,s2
    80001c10:	00000097          	auipc	ra,0x0
    80001c14:	ef4080e7          	jalr	-268(ra) # 80001b04 <_Z26bba_try_merge_single_blockP9bba_blocki>
        if(mergedBlock==0){
    80001c18:	00050863          	beqz	a0,80001c28 <_Z16bba_merge_blocksP9bba_blocki+0x48>
            break;
        }
        n++;
    80001c1c:	0014849b          	addiw	s1,s1,1
        freedBlock=mergedBlock;
    80001c20:	00050913          	mv	s2,a0
    while (n<17){
    80001c24:	fddff06f          	j	80001c00 <_Z16bba_merge_blocksP9bba_blocki+0x20>
    }

    freedBlock->n=n;
    80001c28:	00992423          	sw	s1,8(s2)
    freedBlock->next=buddyBlocks[n];
    80001c2c:	00349493          	slli	s1,s1,0x3
    80001c30:	0000b797          	auipc	a5,0xb
    80001c34:	12078793          	addi	a5,a5,288 # 8000cd50 <bba_allocatedBlocks>
    80001c38:	009784b3          	add	s1,a5,s1
    80001c3c:	0104b783          	ld	a5,16(s1)
    80001c40:	00f93023          	sd	a5,0(s2)
    buddyBlocks[n]=freedBlock;
    80001c44:	0124b823          	sd	s2,16(s1)
}
    80001c48:	01813083          	ld	ra,24(sp)
    80001c4c:	01013403          	ld	s0,16(sp)
    80001c50:	00813483          	ld	s1,8(sp)
    80001c54:	00013903          	ld	s2,0(sp)
    80001c58:	02010113          	addi	sp,sp,32
    80001c5c:	00008067          	ret

0000000080001c60 <_Z19bba_find_descriptorPKv>:

bba_block_t *bba_find_descriptor(const void*addr)
{
    80001c60:	ff010113          	addi	sp,sp,-16
    80001c64:	00813423          	sd	s0,8(sp)
    80001c68:	01010413          	addi	s0,sp,16
    80001c6c:	00050713          	mv	a4,a0
    bba_block_t *curr = bba_allocatedBlocks;
    80001c70:	0000b517          	auipc	a0,0xb
    80001c74:	0e053503          	ld	a0,224(a0) # 8000cd50 <bba_allocatedBlocks>
    while (curr){
    80001c78:	00050a63          	beqz	a0,80001c8c <_Z19bba_find_descriptorPKv+0x2c>
        if(curr->addr==addr) return curr;
    80001c7c:	01053783          	ld	a5,16(a0)
    80001c80:	00e78663          	beq	a5,a4,80001c8c <_Z19bba_find_descriptorPKv+0x2c>
        curr=curr->next;
    80001c84:	00053503          	ld	a0,0(a0)
    while (curr){
    80001c88:	ff1ff06f          	j	80001c78 <_Z19bba_find_descriptorPKv+0x18>
    }
    return 0;
}
    80001c8c:	00813403          	ld	s0,8(sp)
    80001c90:	01010113          	addi	sp,sp,16
    80001c94:	00008067          	ret

0000000080001c98 <_Z21bba_unlink_descriptorP9bba_block>:

void bba_unlink_descriptor(bba_block_t* descriptor){
    80001c98:	ff010113          	addi	sp,sp,-16
    80001c9c:	00813423          	sd	s0,8(sp)
    80001ca0:	01010413          	addi	s0,sp,16
    bba_block_t *curr = bba_allocatedBlocks;
    80001ca4:	0000b797          	auipc	a5,0xb
    80001ca8:	0ac7b783          	ld	a5,172(a5) # 8000cd50 <bba_allocatedBlocks>
    bba_block_t *prev = 0;
    80001cac:	00000713          	li	a4,0
    while (curr!=descriptor){
    80001cb0:	00a78863          	beq	a5,a0,80001cc0 <_Z21bba_unlink_descriptorP9bba_block+0x28>
        prev=curr;
    80001cb4:	00078713          	mv	a4,a5
        curr=curr->next;
    80001cb8:	0007b783          	ld	a5,0(a5)
    while (curr!=descriptor){
    80001cbc:	ff5ff06f          	j	80001cb0 <_Z21bba_unlink_descriptorP9bba_block+0x18>
    }
    if(prev!=0){
    80001cc0:	00070c63          	beqz	a4,80001cd8 <_Z21bba_unlink_descriptorP9bba_block+0x40>
        prev->next=curr->next;
    80001cc4:	0007b783          	ld	a5,0(a5)
    80001cc8:	00f73023          	sd	a5,0(a4)
    } else{
        bba_allocatedBlocks=curr->next;
    }
}
    80001ccc:	00813403          	ld	s0,8(sp)
    80001cd0:	01010113          	addi	sp,sp,16
    80001cd4:	00008067          	ret
        bba_allocatedBlocks=curr->next;
    80001cd8:	0007b783          	ld	a5,0(a5)
    80001cdc:	0000b717          	auipc	a4,0xb
    80001ce0:	06f73a23          	sd	a5,116(a4) # 8000cd50 <bba_allocatedBlocks>
}
    80001ce4:	fe9ff06f          	j	80001ccc <_Z21bba_unlink_descriptorP9bba_block+0x34>

0000000080001ce8 <_Z14bba_free_blockPKv>:

void bba_free_block(const void* addr)
{
    80001ce8:	fe010113          	addi	sp,sp,-32
    80001cec:	00113c23          	sd	ra,24(sp)
    80001cf0:	00813823          	sd	s0,16(sp)
    80001cf4:	00913423          	sd	s1,8(sp)
    80001cf8:	01213023          	sd	s2,0(sp)
    80001cfc:	02010413          	addi	s0,sp,32
    80001d00:	00050913          	mv	s2,a0
    bba_block_t * descriptor = bba_find_descriptor(addr);
    80001d04:	00000097          	auipc	ra,0x0
    80001d08:	f5c080e7          	jalr	-164(ra) # 80001c60 <_Z19bba_find_descriptorPKv>
    80001d0c:	00050493          	mv	s1,a0
    if(descriptor==0) printf("\nERROR (bba_free_block): Cant find descriptor");
    80001d10:	04050463          	beqz	a0,80001d58 <_Z14bba_free_blockPKv+0x70>
    int n = descriptor->n;

    bba_block_t *freedBlock = (bba_block_t*) addr;
    bba_merge_blocks(freedBlock,n);
    80001d14:	0084a583          	lw	a1,8(s1)
    80001d18:	00090513          	mv	a0,s2
    80001d1c:	00000097          	auipc	ra,0x0
    80001d20:	ec4080e7          	jalr	-316(ra) # 80001be0 <_Z16bba_merge_blocksP9bba_blocki>

    bba_unlink_descriptor(descriptor);
    80001d24:	00048513          	mv	a0,s1
    80001d28:	00000097          	auipc	ra,0x0
    80001d2c:	f70080e7          	jalr	-144(ra) # 80001c98 <_Z21bba_unlink_descriptorP9bba_block>
    bba_merge_blocks(descriptor,5);
    80001d30:	00500593          	li	a1,5
    80001d34:	00048513          	mv	a0,s1
    80001d38:	00000097          	auipc	ra,0x0
    80001d3c:	ea8080e7          	jalr	-344(ra) # 80001be0 <_Z16bba_merge_blocksP9bba_blocki>
}
    80001d40:	01813083          	ld	ra,24(sp)
    80001d44:	01013403          	ld	s0,16(sp)
    80001d48:	00813483          	ld	s1,8(sp)
    80001d4c:	00013903          	ld	s2,0(sp)
    80001d50:	02010113          	addi	sp,sp,32
    80001d54:	00008067          	ret
    if(descriptor==0) printf("\nERROR (bba_free_block): Cant find descriptor");
    80001d58:	00008517          	auipc	a0,0x8
    80001d5c:	3f850513          	addi	a0,a0,1016 # 8000a150 <CONSOLE_STATUS+0x140>
    80001d60:	00000097          	auipc	ra,0x0
    80001d64:	4e0080e7          	jalr	1248(ra) # 80002240 <_Z6printfPKcz>
    80001d68:	fadff06f          	j	80001d14 <_Z14bba_free_blockPKv+0x2c>

0000000080001d6c <_ZL15printInt_staticiii>:
    for (i = 0; i < (int)(sizeof(uint64) * 2); i++, x <<= 4)
        putc(digits[x >> (sizeof(uint64) * 8 - 4)]);
}

static void printInt_static(int xx, int base, int sgn)
{
    80001d6c:	fd010113          	addi	sp,sp,-48
    80001d70:	02113423          	sd	ra,40(sp)
    80001d74:	02813023          	sd	s0,32(sp)
    80001d78:	00913c23          	sd	s1,24(sp)
    80001d7c:	03010413          	addi	s0,sp,48
    char buf[16];
    int i, neg;
    uint x;

    neg = 0;
    if(sgn && xx < 0){
    80001d80:	00060463          	beqz	a2,80001d88 <_ZL15printInt_staticiii+0x1c>
    80001d84:	08054463          	bltz	a0,80001e0c <_ZL15printInt_staticiii+0xa0>
        neg = 1;
        x = -xx;
    } else {
        x = xx;
    80001d88:	0005051b          	sext.w	a0,a0
    neg = 0;
    80001d8c:	00000813          	li	a6,0
    }

    i = 0;
    80001d90:	00000493          	li	s1,0
    do{
        buf[i++] = digits[x % base];
    80001d94:	0005879b          	sext.w	a5,a1
    80001d98:	02b5773b          	remuw	a4,a0,a1
    80001d9c:	00048613          	mv	a2,s1
    80001da0:	0014849b          	addiw	s1,s1,1
    80001da4:	02071693          	slli	a3,a4,0x20
    80001da8:	0206d693          	srli	a3,a3,0x20
    80001dac:	0000b717          	auipc	a4,0xb
    80001db0:	cd470713          	addi	a4,a4,-812 # 8000ca80 <digits>
    80001db4:	00d70733          	add	a4,a4,a3
    80001db8:	00074683          	lbu	a3,0(a4)
    80001dbc:	fe040713          	addi	a4,s0,-32
    80001dc0:	00c70733          	add	a4,a4,a2
    80001dc4:	fed70823          	sb	a3,-16(a4)
    }while((x /= base) != 0);
    80001dc8:	0005071b          	sext.w	a4,a0
    80001dcc:	02b5553b          	divuw	a0,a0,a1
    80001dd0:	fcf772e3          	bgeu	a4,a5,80001d94 <_ZL15printInt_staticiii+0x28>
    if(neg)
    80001dd4:	00080c63          	beqz	a6,80001dec <_ZL15printInt_staticiii+0x80>
        buf[i++] = '-';
    80001dd8:	fe040793          	addi	a5,s0,-32
    80001ddc:	009784b3          	add	s1,a5,s1
    80001de0:	02d00793          	li	a5,45
    80001de4:	fef48823          	sb	a5,-16(s1)
    80001de8:	0026049b          	addiw	s1,a2,2

    while(--i >= 0)
    80001dec:	fff4849b          	addiw	s1,s1,-1
    80001df0:	0204c463          	bltz	s1,80001e18 <_ZL15printInt_staticiii+0xac>
        putc(buf[i]);
    80001df4:	fe040793          	addi	a5,s0,-32
    80001df8:	009787b3          	add	a5,a5,s1
    80001dfc:	ff07c503          	lbu	a0,-16(a5)
    80001e00:	fffff097          	auipc	ra,0xfffff
    80001e04:	7b0080e7          	jalr	1968(ra) # 800015b0 <_Z4putcc>
    80001e08:	fe5ff06f          	j	80001dec <_ZL15printInt_staticiii+0x80>
        x = -xx;
    80001e0c:	40a0053b          	negw	a0,a0
        neg = 1;
    80001e10:	00100813          	li	a6,1
        x = -xx;
    80001e14:	f7dff06f          	j	80001d90 <_ZL15printInt_staticiii+0x24>

}
    80001e18:	02813083          	ld	ra,40(sp)
    80001e1c:	02013403          	ld	s0,32(sp)
    80001e20:	01813483          	ld	s1,24(sp)
    80001e24:	03010113          	addi	sp,sp,48
    80001e28:	00008067          	ret

0000000080001e2c <_ZL15printptr_staticm>:
{
    80001e2c:	fe010113          	addi	sp,sp,-32
    80001e30:	00113c23          	sd	ra,24(sp)
    80001e34:	00813823          	sd	s0,16(sp)
    80001e38:	00913423          	sd	s1,8(sp)
    80001e3c:	01213023          	sd	s2,0(sp)
    80001e40:	02010413          	addi	s0,sp,32
    80001e44:	00050493          	mv	s1,a0
    putc('0');
    80001e48:	03000513          	li	a0,48
    80001e4c:	fffff097          	auipc	ra,0xfffff
    80001e50:	764080e7          	jalr	1892(ra) # 800015b0 <_Z4putcc>
    putc('x');
    80001e54:	07800513          	li	a0,120
    80001e58:	fffff097          	auipc	ra,0xfffff
    80001e5c:	758080e7          	jalr	1880(ra) # 800015b0 <_Z4putcc>
    for (i = 0; i < (int)(sizeof(uint64) * 2); i++, x <<= 4)
    80001e60:	00000913          	li	s2,0
    80001e64:	00f00793          	li	a5,15
    80001e68:	0327c663          	blt	a5,s2,80001e94 <_ZL15printptr_staticm+0x68>
        putc(digits[x >> (sizeof(uint64) * 8 - 4)]);
    80001e6c:	03c4d713          	srli	a4,s1,0x3c
    80001e70:	0000b797          	auipc	a5,0xb
    80001e74:	c1078793          	addi	a5,a5,-1008 # 8000ca80 <digits>
    80001e78:	00e787b3          	add	a5,a5,a4
    80001e7c:	0007c503          	lbu	a0,0(a5)
    80001e80:	fffff097          	auipc	ra,0xfffff
    80001e84:	730080e7          	jalr	1840(ra) # 800015b0 <_Z4putcc>
    for (i = 0; i < (int)(sizeof(uint64) * 2); i++, x <<= 4)
    80001e88:	0019091b          	addiw	s2,s2,1
    80001e8c:	00449493          	slli	s1,s1,0x4
    80001e90:	fd5ff06f          	j	80001e64 <_ZL15printptr_staticm+0x38>
}
    80001e94:	01813083          	ld	ra,24(sp)
    80001e98:	01013403          	ld	s0,16(sp)
    80001e9c:	00813483          	ld	s1,8(sp)
    80001ea0:	00013903          	ld	s2,0(sp)
    80001ea4:	02010113          	addi	sp,sp,32
    80001ea8:	00008067          	ret

0000000080001eac <_Z11printStringPKc>:
{
    80001eac:	fe010113          	addi	sp,sp,-32
    80001eb0:	00113c23          	sd	ra,24(sp)
    80001eb4:	00813823          	sd	s0,16(sp)
    80001eb8:	00913423          	sd	s1,8(sp)
    80001ebc:	02010413          	addi	s0,sp,32
    80001ec0:	00050493          	mv	s1,a0
    LOCK();
    80001ec4:	00100613          	li	a2,1
    80001ec8:	00000593          	li	a1,0
    80001ecc:	0000b517          	auipc	a0,0xb
    80001ed0:	f2c50513          	addi	a0,a0,-212 # 8000cdf8 <lockPrint>
    80001ed4:	fffff097          	auipc	ra,0xfffff
    80001ed8:	12c080e7          	jalr	300(ra) # 80001000 <copy_and_swap>
    80001edc:	00050863          	beqz	a0,80001eec <_Z11printStringPKc+0x40>
    80001ee0:	fffff097          	auipc	ra,0xfffff
    80001ee4:	4a8080e7          	jalr	1192(ra) # 80001388 <_Z15thread_dispatchv>
    80001ee8:	fddff06f          	j	80001ec4 <_Z11printStringPKc+0x18>
    while (*string != '\0')
    80001eec:	0004c503          	lbu	a0,0(s1)
    80001ef0:	00050a63          	beqz	a0,80001f04 <_Z11printStringPKc+0x58>
        putc(*string);
    80001ef4:	fffff097          	auipc	ra,0xfffff
    80001ef8:	6bc080e7          	jalr	1724(ra) # 800015b0 <_Z4putcc>
        string++;
    80001efc:	00148493          	addi	s1,s1,1
    while (*string != '\0')
    80001f00:	fedff06f          	j	80001eec <_Z11printStringPKc+0x40>
    UNLOCK();
    80001f04:	00000613          	li	a2,0
    80001f08:	00100593          	li	a1,1
    80001f0c:	0000b517          	auipc	a0,0xb
    80001f10:	eec50513          	addi	a0,a0,-276 # 8000cdf8 <lockPrint>
    80001f14:	fffff097          	auipc	ra,0xfffff
    80001f18:	0ec080e7          	jalr	236(ra) # 80001000 <copy_and_swap>
    80001f1c:	fe0514e3          	bnez	a0,80001f04 <_Z11printStringPKc+0x58>
}
    80001f20:	01813083          	ld	ra,24(sp)
    80001f24:	01013403          	ld	s0,16(sp)
    80001f28:	00813483          	ld	s1,8(sp)
    80001f2c:	02010113          	addi	sp,sp,32
    80001f30:	00008067          	ret

0000000080001f34 <_Z9getStringPci>:
char* getString(char *buf, int max) {
    80001f34:	fd010113          	addi	sp,sp,-48
    80001f38:	02113423          	sd	ra,40(sp)
    80001f3c:	02813023          	sd	s0,32(sp)
    80001f40:	00913c23          	sd	s1,24(sp)
    80001f44:	01213823          	sd	s2,16(sp)
    80001f48:	01313423          	sd	s3,8(sp)
    80001f4c:	01413023          	sd	s4,0(sp)
    80001f50:	03010413          	addi	s0,sp,48
    80001f54:	00050993          	mv	s3,a0
    80001f58:	00058a13          	mv	s4,a1
    LOCK();
    80001f5c:	00100613          	li	a2,1
    80001f60:	00000593          	li	a1,0
    80001f64:	0000b517          	auipc	a0,0xb
    80001f68:	e9450513          	addi	a0,a0,-364 # 8000cdf8 <lockPrint>
    80001f6c:	fffff097          	auipc	ra,0xfffff
    80001f70:	094080e7          	jalr	148(ra) # 80001000 <copy_and_swap>
    80001f74:	00050863          	beqz	a0,80001f84 <_Z9getStringPci+0x50>
    80001f78:	fffff097          	auipc	ra,0xfffff
    80001f7c:	410080e7          	jalr	1040(ra) # 80001388 <_Z15thread_dispatchv>
    80001f80:	fddff06f          	j	80001f5c <_Z9getStringPci+0x28>
    for(i=0; i+1 < max; ){
    80001f84:	00000913          	li	s2,0
    80001f88:	00090493          	mv	s1,s2
    80001f8c:	0019091b          	addiw	s2,s2,1
    80001f90:	03495a63          	bge	s2,s4,80001fc4 <_Z9getStringPci+0x90>
        cc = getc();
    80001f94:	fffff097          	auipc	ra,0xfffff
    80001f98:	5e0080e7          	jalr	1504(ra) # 80001574 <_Z4getcv>
        if(cc < 1)
    80001f9c:	02050463          	beqz	a0,80001fc4 <_Z9getStringPci+0x90>
        buf[i++] = c;
    80001fa0:	009984b3          	add	s1,s3,s1
    80001fa4:	00a48023          	sb	a0,0(s1)
        if(c == '\n' || c == '\r')
    80001fa8:	00a00793          	li	a5,10
    80001fac:	00f50a63          	beq	a0,a5,80001fc0 <_Z9getStringPci+0x8c>
    80001fb0:	00d00793          	li	a5,13
    80001fb4:	fcf51ae3          	bne	a0,a5,80001f88 <_Z9getStringPci+0x54>
        buf[i++] = c;
    80001fb8:	00090493          	mv	s1,s2
    80001fbc:	0080006f          	j	80001fc4 <_Z9getStringPci+0x90>
    80001fc0:	00090493          	mv	s1,s2
    buf[i] = '\0';
    80001fc4:	009984b3          	add	s1,s3,s1
    80001fc8:	00048023          	sb	zero,0(s1)
    UNLOCK();
    80001fcc:	00000613          	li	a2,0
    80001fd0:	00100593          	li	a1,1
    80001fd4:	0000b517          	auipc	a0,0xb
    80001fd8:	e2450513          	addi	a0,a0,-476 # 8000cdf8 <lockPrint>
    80001fdc:	fffff097          	auipc	ra,0xfffff
    80001fe0:	024080e7          	jalr	36(ra) # 80001000 <copy_and_swap>
    80001fe4:	fe0514e3          	bnez	a0,80001fcc <_Z9getStringPci+0x98>
}
    80001fe8:	00098513          	mv	a0,s3
    80001fec:	02813083          	ld	ra,40(sp)
    80001ff0:	02013403          	ld	s0,32(sp)
    80001ff4:	01813483          	ld	s1,24(sp)
    80001ff8:	01013903          	ld	s2,16(sp)
    80001ffc:	00813983          	ld	s3,8(sp)
    80002000:	00013a03          	ld	s4,0(sp)
    80002004:	03010113          	addi	sp,sp,48
    80002008:	00008067          	ret

000000008000200c <_Z11stringToIntPKc>:
int stringToInt(const char *s) {
    8000200c:	ff010113          	addi	sp,sp,-16
    80002010:	00813423          	sd	s0,8(sp)
    80002014:	01010413          	addi	s0,sp,16
    80002018:	00050693          	mv	a3,a0
    n = 0;
    8000201c:	00000513          	li	a0,0
    while ('0' <= *s && *s <= '9')
    80002020:	0006c603          	lbu	a2,0(a3)
    80002024:	fd06071b          	addiw	a4,a2,-48
    80002028:	0ff77713          	andi	a4,a4,255
    8000202c:	00900793          	li	a5,9
    80002030:	02e7e063          	bltu	a5,a4,80002050 <_Z11stringToIntPKc+0x44>
        n = n * 10 + *s++ - '0';
    80002034:	0025179b          	slliw	a5,a0,0x2
    80002038:	00a787bb          	addw	a5,a5,a0
    8000203c:	0017979b          	slliw	a5,a5,0x1
    80002040:	00168693          	addi	a3,a3,1
    80002044:	00c787bb          	addw	a5,a5,a2
    80002048:	fd07851b          	addiw	a0,a5,-48
    while ('0' <= *s && *s <= '9')
    8000204c:	fd5ff06f          	j	80002020 <_Z11stringToIntPKc+0x14>
}
    80002050:	00813403          	ld	s0,8(sp)
    80002054:	01010113          	addi	sp,sp,16
    80002058:	00008067          	ret

000000008000205c <_Z8printIntiii>:
{
    8000205c:	fc010113          	addi	sp,sp,-64
    80002060:	02113c23          	sd	ra,56(sp)
    80002064:	02813823          	sd	s0,48(sp)
    80002068:	02913423          	sd	s1,40(sp)
    8000206c:	03213023          	sd	s2,32(sp)
    80002070:	01313c23          	sd	s3,24(sp)
    80002074:	04010413          	addi	s0,sp,64
    80002078:	00050493          	mv	s1,a0
    8000207c:	00058913          	mv	s2,a1
    80002080:	00060993          	mv	s3,a2
    LOCK();
    80002084:	00100613          	li	a2,1
    80002088:	00000593          	li	a1,0
    8000208c:	0000b517          	auipc	a0,0xb
    80002090:	d6c50513          	addi	a0,a0,-660 # 8000cdf8 <lockPrint>
    80002094:	fffff097          	auipc	ra,0xfffff
    80002098:	f6c080e7          	jalr	-148(ra) # 80001000 <copy_and_swap>
    8000209c:	00050863          	beqz	a0,800020ac <_Z8printIntiii+0x50>
    800020a0:	fffff097          	auipc	ra,0xfffff
    800020a4:	2e8080e7          	jalr	744(ra) # 80001388 <_Z15thread_dispatchv>
    800020a8:	fddff06f          	j	80002084 <_Z8printIntiii+0x28>
    if(sgn && xx < 0){
    800020ac:	00098463          	beqz	s3,800020b4 <_Z8printIntiii+0x58>
    800020b0:	0804c463          	bltz	s1,80002138 <_Z8printIntiii+0xdc>
        x = xx;
    800020b4:	0004851b          	sext.w	a0,s1
    neg = 0;
    800020b8:	00000593          	li	a1,0
    i = 0;
    800020bc:	00000493          	li	s1,0
        buf[i++] = digits[x % base];
    800020c0:	0009079b          	sext.w	a5,s2
    800020c4:	0325773b          	remuw	a4,a0,s2
    800020c8:	00048613          	mv	a2,s1
    800020cc:	0014849b          	addiw	s1,s1,1
    800020d0:	02071693          	slli	a3,a4,0x20
    800020d4:	0206d693          	srli	a3,a3,0x20
    800020d8:	0000b717          	auipc	a4,0xb
    800020dc:	9a870713          	addi	a4,a4,-1624 # 8000ca80 <digits>
    800020e0:	00d70733          	add	a4,a4,a3
    800020e4:	00074683          	lbu	a3,0(a4)
    800020e8:	fd040713          	addi	a4,s0,-48
    800020ec:	00c70733          	add	a4,a4,a2
    800020f0:	fed70823          	sb	a3,-16(a4)
    }while((x /= base) != 0);
    800020f4:	0005071b          	sext.w	a4,a0
    800020f8:	0325553b          	divuw	a0,a0,s2
    800020fc:	fcf772e3          	bgeu	a4,a5,800020c0 <_Z8printIntiii+0x64>
    if(neg)
    80002100:	00058c63          	beqz	a1,80002118 <_Z8printIntiii+0xbc>
        buf[i++] = '-';
    80002104:	fd040793          	addi	a5,s0,-48
    80002108:	009784b3          	add	s1,a5,s1
    8000210c:	02d00793          	li	a5,45
    80002110:	fef48823          	sb	a5,-16(s1)
    80002114:	0026049b          	addiw	s1,a2,2
    while(--i >= 0)
    80002118:	fff4849b          	addiw	s1,s1,-1
    8000211c:	0204c463          	bltz	s1,80002144 <_Z8printIntiii+0xe8>
        putc(buf[i]);
    80002120:	fd040793          	addi	a5,s0,-48
    80002124:	009787b3          	add	a5,a5,s1
    80002128:	ff07c503          	lbu	a0,-16(a5)
    8000212c:	fffff097          	auipc	ra,0xfffff
    80002130:	484080e7          	jalr	1156(ra) # 800015b0 <_Z4putcc>
    80002134:	fe5ff06f          	j	80002118 <_Z8printIntiii+0xbc>
        x = -xx;
    80002138:	4090053b          	negw	a0,s1
        neg = 1;
    8000213c:	00100593          	li	a1,1
        x = -xx;
    80002140:	f7dff06f          	j	800020bc <_Z8printIntiii+0x60>
    UNLOCK();
    80002144:	00000613          	li	a2,0
    80002148:	00100593          	li	a1,1
    8000214c:	0000b517          	auipc	a0,0xb
    80002150:	cac50513          	addi	a0,a0,-852 # 8000cdf8 <lockPrint>
    80002154:	fffff097          	auipc	ra,0xfffff
    80002158:	eac080e7          	jalr	-340(ra) # 80001000 <copy_and_swap>
    8000215c:	fe0514e3          	bnez	a0,80002144 <_Z8printIntiii+0xe8>
}
    80002160:	03813083          	ld	ra,56(sp)
    80002164:	03013403          	ld	s0,48(sp)
    80002168:	02813483          	ld	s1,40(sp)
    8000216c:	02013903          	ld	s2,32(sp)
    80002170:	01813983          	ld	s3,24(sp)
    80002174:	04010113          	addi	sp,sp,64
    80002178:	00008067          	ret

000000008000217c <_Z8printptrm>:
{
    8000217c:	fe010113          	addi	sp,sp,-32
    80002180:	00113c23          	sd	ra,24(sp)
    80002184:	00813823          	sd	s0,16(sp)
    80002188:	00913423          	sd	s1,8(sp)
    8000218c:	01213023          	sd	s2,0(sp)
    80002190:	02010413          	addi	s0,sp,32
    80002194:	00050493          	mv	s1,a0
    LOCK();
    80002198:	00100613          	li	a2,1
    8000219c:	00000593          	li	a1,0
    800021a0:	0000b517          	auipc	a0,0xb
    800021a4:	c5850513          	addi	a0,a0,-936 # 8000cdf8 <lockPrint>
    800021a8:	fffff097          	auipc	ra,0xfffff
    800021ac:	e58080e7          	jalr	-424(ra) # 80001000 <copy_and_swap>
    800021b0:	00050863          	beqz	a0,800021c0 <_Z8printptrm+0x44>
    800021b4:	fffff097          	auipc	ra,0xfffff
    800021b8:	1d4080e7          	jalr	468(ra) # 80001388 <_Z15thread_dispatchv>
    800021bc:	fddff06f          	j	80002198 <_Z8printptrm+0x1c>
    putc('0');
    800021c0:	03000513          	li	a0,48
    800021c4:	fffff097          	auipc	ra,0xfffff
    800021c8:	3ec080e7          	jalr	1004(ra) # 800015b0 <_Z4putcc>
    putc('x');
    800021cc:	07800513          	li	a0,120
    800021d0:	fffff097          	auipc	ra,0xfffff
    800021d4:	3e0080e7          	jalr	992(ra) # 800015b0 <_Z4putcc>
    for (i = 0; i < (int)(sizeof(uint64) * 2); i++, x <<= 4)
    800021d8:	00000913          	li	s2,0
    800021dc:	00f00793          	li	a5,15
    800021e0:	0327c663          	blt	a5,s2,8000220c <_Z8printptrm+0x90>
        putc(digits[x >> (sizeof(uint64) * 8 - 4)]);
    800021e4:	03c4d713          	srli	a4,s1,0x3c
    800021e8:	0000b797          	auipc	a5,0xb
    800021ec:	89878793          	addi	a5,a5,-1896 # 8000ca80 <digits>
    800021f0:	00e787b3          	add	a5,a5,a4
    800021f4:	0007c503          	lbu	a0,0(a5)
    800021f8:	fffff097          	auipc	ra,0xfffff
    800021fc:	3b8080e7          	jalr	952(ra) # 800015b0 <_Z4putcc>
    for (i = 0; i < (int)(sizeof(uint64) * 2); i++, x <<= 4)
    80002200:	0019091b          	addiw	s2,s2,1
    80002204:	00449493          	slli	s1,s1,0x4
    80002208:	fd5ff06f          	j	800021dc <_Z8printptrm+0x60>
    UNLOCK();
    8000220c:	00000613          	li	a2,0
    80002210:	00100593          	li	a1,1
    80002214:	0000b517          	auipc	a0,0xb
    80002218:	be450513          	addi	a0,a0,-1052 # 8000cdf8 <lockPrint>
    8000221c:	fffff097          	auipc	ra,0xfffff
    80002220:	de4080e7          	jalr	-540(ra) # 80001000 <copy_and_swap>
    80002224:	fe0514e3          	bnez	a0,8000220c <_Z8printptrm+0x90>
}
    80002228:	01813083          	ld	ra,24(sp)
    8000222c:	01013403          	ld	s0,16(sp)
    80002230:	00813483          	ld	s1,8(sp)
    80002234:	00013903          	ld	s2,0(sp)
    80002238:	02010113          	addi	sp,sp,32
    8000223c:	00008067          	ret

0000000080002240 <_Z6printfPKcz>:

void
printf(const char *fmt, ...)
{
    80002240:	f8010113          	addi	sp,sp,-128
    80002244:	02113c23          	sd	ra,56(sp)
    80002248:	02813823          	sd	s0,48(sp)
    8000224c:	02913423          	sd	s1,40(sp)
    80002250:	03213023          	sd	s2,32(sp)
    80002254:	01313c23          	sd	s3,24(sp)
    80002258:	04010413          	addi	s0,sp,64
    8000225c:	00050993          	mv	s3,a0
    80002260:	00b43423          	sd	a1,8(s0)
    80002264:	00c43823          	sd	a2,16(s0)
    80002268:	00d43c23          	sd	a3,24(s0)
    8000226c:	02e43023          	sd	a4,32(s0)
    80002270:	02f43423          	sd	a5,40(s0)
    80002274:	03043823          	sd	a6,48(s0)
    80002278:	03143c23          	sd	a7,56(s0)
    LOCK();
    8000227c:	00100613          	li	a2,1
    80002280:	00000593          	li	a1,0
    80002284:	0000b517          	auipc	a0,0xb
    80002288:	b7450513          	addi	a0,a0,-1164 # 8000cdf8 <lockPrint>
    8000228c:	fffff097          	auipc	ra,0xfffff
    80002290:	d74080e7          	jalr	-652(ra) # 80001000 <copy_and_swap>
    80002294:	00050863          	beqz	a0,800022a4 <_Z6printfPKcz+0x64>
    80002298:	fffff097          	auipc	ra,0xfffff
    8000229c:	0f0080e7          	jalr	240(ra) # 80001388 <_Z15thread_dispatchv>
    800022a0:	fddff06f          	j	8000227c <_Z6printfPKcz+0x3c>
    va_list ap;
    int i, c;
    char *s;


    if (fmt == 0) return;
    800022a4:	14098663          	beqz	s3,800023f0 <_Z6printfPKcz+0x1b0>

    va_start(ap, fmt);
    800022a8:	00840793          	addi	a5,s0,8
    800022ac:	fcf43423          	sd	a5,-56(s0)
    for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
    800022b0:	00000913          	li	s2,0
    800022b4:	0100006f          	j	800022c4 <_Z6printfPKcz+0x84>
        if(c != '%'){
            putc(c);
    800022b8:	fffff097          	auipc	ra,0xfffff
    800022bc:	2f8080e7          	jalr	760(ra) # 800015b0 <_Z4putcc>
    for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
    800022c0:	0019091b          	addiw	s2,s2,1
    800022c4:	012987b3          	add	a5,s3,s2
    800022c8:	0007c503          	lbu	a0,0(a5)
    800022cc:	0005079b          	sext.w	a5,a0
    800022d0:	10050263          	beqz	a0,800023d4 <_Z6printfPKcz+0x194>
        if(c != '%'){
    800022d4:	02500713          	li	a4,37
    800022d8:	fee790e3          	bne	a5,a4,800022b8 <_Z6printfPKcz+0x78>
            continue;
        }
        c = fmt[++i] & 0xff;
    800022dc:	0019091b          	addiw	s2,s2,1
    800022e0:	012987b3          	add	a5,s3,s2
    800022e4:	0007c483          	lbu	s1,0(a5)
        if(c == 0)
    800022e8:	0e048663          	beqz	s1,800023d4 <_Z6printfPKcz+0x194>
            break;
        switch(c){
    800022ec:	07000793          	li	a5,112
    800022f0:	06f48863          	beq	s1,a5,80002360 <_Z6printfPKcz+0x120>
    800022f4:	0297fc63          	bgeu	a5,s1,8000232c <_Z6printfPKcz+0xec>
    800022f8:	07300793          	li	a5,115
    800022fc:	08f48063          	beq	s1,a5,8000237c <_Z6printfPKcz+0x13c>
    80002300:	07800793          	li	a5,120
    80002304:	0af49a63          	bne	s1,a5,800023b8 <_Z6printfPKcz+0x178>
            case 'd':
                printInt_static(va_arg(ap, int), 10, 1);
                break;
            case 'x':
                printInt_static(va_arg(ap, int), 16, 1);
    80002308:	fc843783          	ld	a5,-56(s0)
    8000230c:	00878713          	addi	a4,a5,8
    80002310:	fce43423          	sd	a4,-56(s0)
    80002314:	00100613          	li	a2,1
    80002318:	01000593          	li	a1,16
    8000231c:	0007a503          	lw	a0,0(a5)
    80002320:	00000097          	auipc	ra,0x0
    80002324:	a4c080e7          	jalr	-1460(ra) # 80001d6c <_ZL15printInt_staticiii>
    80002328:	f99ff06f          	j	800022c0 <_Z6printfPKcz+0x80>
        switch(c){
    8000232c:	02500793          	li	a5,37
    80002330:	06f48c63          	beq	s1,a5,800023a8 <_Z6printfPKcz+0x168>
    80002334:	06400793          	li	a5,100
    80002338:	08f49063          	bne	s1,a5,800023b8 <_Z6printfPKcz+0x178>
                printInt_static(va_arg(ap, int), 10, 1);
    8000233c:	fc843783          	ld	a5,-56(s0)
    80002340:	00878713          	addi	a4,a5,8
    80002344:	fce43423          	sd	a4,-56(s0)
    80002348:	00100613          	li	a2,1
    8000234c:	00a00593          	li	a1,10
    80002350:	0007a503          	lw	a0,0(a5)
    80002354:	00000097          	auipc	ra,0x0
    80002358:	a18080e7          	jalr	-1512(ra) # 80001d6c <_ZL15printInt_staticiii>
    8000235c:	f65ff06f          	j	800022c0 <_Z6printfPKcz+0x80>
                break;
            case 'p':
                printptr_static(va_arg(ap, uint64));
    80002360:	fc843783          	ld	a5,-56(s0)
    80002364:	00878713          	addi	a4,a5,8
    80002368:	fce43423          	sd	a4,-56(s0)
    8000236c:	0007b503          	ld	a0,0(a5)
    80002370:	00000097          	auipc	ra,0x0
    80002374:	abc080e7          	jalr	-1348(ra) # 80001e2c <_ZL15printptr_staticm>
    80002378:	f49ff06f          	j	800022c0 <_Z6printfPKcz+0x80>
                break;
            case 's':
                if((s = va_arg(ap, char*)) == 0)
    8000237c:	fc843783          	ld	a5,-56(s0)
    80002380:	00878713          	addi	a4,a5,8
    80002384:	fce43423          	sd	a4,-56(s0)
    80002388:	0007b483          	ld	s1,0(a5)
    8000238c:	f2048ae3          	beqz	s1,800022c0 <_Z6printfPKcz+0x80>
                    break;
                for(; *s; s++)
    80002390:	0004c503          	lbu	a0,0(s1)
    80002394:	f20506e3          	beqz	a0,800022c0 <_Z6printfPKcz+0x80>
                    putc(*s);
    80002398:	fffff097          	auipc	ra,0xfffff
    8000239c:	218080e7          	jalr	536(ra) # 800015b0 <_Z4putcc>
                for(; *s; s++)
    800023a0:	00148493          	addi	s1,s1,1
    800023a4:	fedff06f          	j	80002390 <_Z6printfPKcz+0x150>
                break;
            case '%':
                putc('%');
    800023a8:	02500513          	li	a0,37
    800023ac:	fffff097          	auipc	ra,0xfffff
    800023b0:	204080e7          	jalr	516(ra) # 800015b0 <_Z4putcc>
    800023b4:	f0dff06f          	j	800022c0 <_Z6printfPKcz+0x80>
                break;
            default:
                // Print unknown % sequence to draw attention.
                putc('%');
    800023b8:	02500513          	li	a0,37
    800023bc:	fffff097          	auipc	ra,0xfffff
    800023c0:	1f4080e7          	jalr	500(ra) # 800015b0 <_Z4putcc>
                putc(c);
    800023c4:	00048513          	mv	a0,s1
    800023c8:	fffff097          	auipc	ra,0xfffff
    800023cc:	1e8080e7          	jalr	488(ra) # 800015b0 <_Z4putcc>
    800023d0:	ef1ff06f          	j	800022c0 <_Z6printfPKcz+0x80>
                break;
        }
    }

    UNLOCK();
    800023d4:	00000613          	li	a2,0
    800023d8:	00100593          	li	a1,1
    800023dc:	0000b517          	auipc	a0,0xb
    800023e0:	a1c50513          	addi	a0,a0,-1508 # 8000cdf8 <lockPrint>
    800023e4:	fffff097          	auipc	ra,0xfffff
    800023e8:	c1c080e7          	jalr	-996(ra) # 80001000 <copy_and_swap>
    800023ec:	fe0514e3          	bnez	a0,800023d4 <_Z6printfPKcz+0x194>
}
    800023f0:	03813083          	ld	ra,56(sp)
    800023f4:	03013403          	ld	s0,48(sp)
    800023f8:	02813483          	ld	s1,40(sp)
    800023fc:	02013903          	ld	s2,32(sp)
    80002400:	01813983          	ld	s3,24(sp)
    80002404:	08010113          	addi	sp,sp,128
    80002408:	00008067          	ret

000000008000240c <_Z14kern_mem_alloci>:

mem_block_s * freeHead;


void* kern_mem_alloc(int sizeInBlocks)
{
    8000240c:	ff010113          	addi	sp,sp,-16
    80002410:	00813423          	sd	s0,8(sp)
    80002414:	01010413          	addi	s0,sp,16
    80002418:	00050693          	mv	a3,a0
    mem_block_s *curr = freeHead;
    8000241c:	0000b597          	auipc	a1,0xb
    80002420:	9e45b583          	ld	a1,-1564(a1) # 8000ce00 <freeHead>
    80002424:	00058513          	mv	a0,a1
    mem_block_s *prev = 0;
    80002428:	00000613          	li	a2,0
    8000242c:	0480006f          	j	80002474 <_Z14kern_mem_alloci+0x68>

    while (curr){
        if(curr->sizeInBlocks==sizeInBlocks+1){
            if(curr==freeHead) freeHead=curr->next;
    80002430:	02b50063          	beq	a0,a1,80002450 <_Z14kern_mem_alloci+0x44>
            else prev->next = curr->next;
    80002434:	00853783          	ld	a5,8(a0)
    80002438:	00f63423          	sd	a5,8(a2)
            curr->sizeInBlocks=sizeInBlocks+1;
    8000243c:	00e52023          	sw	a4,0(a0)
            return (curr+MEM_BLOCK_SIZE);
    80002440:	40050513          	addi	a0,a0,1024
        prev=curr;
        curr=curr->next;
    }

    return 0;
}
    80002444:	00813403          	ld	s0,8(sp)
    80002448:	01010113          	addi	sp,sp,16
    8000244c:	00008067          	ret
            if(curr==freeHead) freeHead=curr->next;
    80002450:	00853783          	ld	a5,8(a0)
    80002454:	0000b697          	auipc	a3,0xb
    80002458:	9af6b623          	sd	a5,-1620(a3) # 8000ce00 <freeHead>
    8000245c:	fe1ff06f          	j	8000243c <_Z14kern_mem_alloci+0x30>
            if(curr==freeHead) freeHead=newFreeBlock;
    80002460:	0000b797          	auipc	a5,0xb
    80002464:	9ab7b023          	sd	a1,-1632(a5) # 8000ce00 <freeHead>
    80002468:	05c0006f          	j	800024c4 <_Z14kern_mem_alloci+0xb8>
        prev=curr;
    8000246c:	00050613          	mv	a2,a0
        curr=curr->next;
    80002470:	00853503          	ld	a0,8(a0)
    while (curr){
    80002474:	fc0508e3          	beqz	a0,80002444 <_Z14kern_mem_alloci+0x38>
        if(curr->sizeInBlocks==sizeInBlocks+1){
    80002478:	00052783          	lw	a5,0(a0)
    8000247c:	0016871b          	addiw	a4,a3,1
    80002480:	fae788e3          	beq	a5,a4,80002430 <_Z14kern_mem_alloci+0x24>
        else if(curr->sizeInBlocks>sizeInBlocks+1){
    80002484:	fef754e3          	bge	a4,a5,8000246c <_Z14kern_mem_alloci+0x60>
            mem_block_s* newFreeBlock = curr+(sizeInBlocks+1)*MEM_BLOCK_SIZE;
    80002488:	00a71593          	slli	a1,a4,0xa
    8000248c:	00b505b3          	add	a1,a0,a1
            newFreeBlock->sizeInBlocks = curr->sizeInBlocks-sizeInBlocks-1;
    80002490:	40d787bb          	subw	a5,a5,a3
    80002494:	fff7879b          	addiw	a5,a5,-1
    80002498:	00f5a023          	sw	a5,0(a1)
            newFreeBlock->startingBlock=curr->startingBlock+sizeInBlocks+1;
    8000249c:	00452783          	lw	a5,4(a0)
    800024a0:	00d786bb          	addw	a3,a5,a3
    800024a4:	0016869b          	addiw	a3,a3,1
    800024a8:	00d5a223          	sw	a3,4(a1)
            newFreeBlock->next = curr->next;
    800024ac:	00853783          	ld	a5,8(a0)
    800024b0:	00f5b423          	sd	a5,8(a1)
            if(curr==freeHead) freeHead=newFreeBlock;
    800024b4:	0000b797          	auipc	a5,0xb
    800024b8:	94c7b783          	ld	a5,-1716(a5) # 8000ce00 <freeHead>
    800024bc:	faa782e3          	beq	a5,a0,80002460 <_Z14kern_mem_alloci+0x54>
            else prev->next=newFreeBlock;
    800024c0:	00b63423          	sd	a1,8(a2)
            curr->sizeInBlocks=sizeInBlocks+1;
    800024c4:	00e52023          	sw	a4,0(a0)
            return (curr+MEM_BLOCK_SIZE);
    800024c8:	40050513          	addi	a0,a0,1024
    800024cc:	f79ff06f          	j	80002444 <_Z14kern_mem_alloci+0x38>

00000000800024d0 <_Z13kern_mem_freePv>:

int kern_mem_free(void* addr)
{
    800024d0:	ff010113          	addi	sp,sp,-16
    800024d4:	00813423          	sd	s0,8(sp)
    800024d8:	01010413          	addi	s0,sp,16
    mem_block_s* freedBlock = (mem_block_s*) addr-MEM_BLOCK_SIZE;
    800024dc:	c0050713          	addi	a4,a0,-1024
    mem_block_s* curr=freeHead;
    800024e0:	0000b797          	auipc	a5,0xb
    800024e4:	9207b783          	ld	a5,-1760(a5) # 8000ce00 <freeHead>
    mem_block_s * prev =0;
    800024e8:	00000693          	li	a3,0

    while (curr<freedBlock && curr!=0){
    800024ec:	00e7fa63          	bgeu	a5,a4,80002500 <_Z13kern_mem_freePv+0x30>
    800024f0:	00078863          	beqz	a5,80002500 <_Z13kern_mem_freePv+0x30>
        prev=curr;
    800024f4:	00078693          	mv	a3,a5
        curr=curr->next;
    800024f8:	0087b783          	ld	a5,8(a5)
    while (curr<freedBlock && curr!=0){
    800024fc:	ff1ff06f          	j	800024ec <_Z13kern_mem_freePv+0x1c>
    char* cfreedBlock = (char *)freedBlock;
    char* cprev = (char *)prev;
    char* ccurr = (char *)curr;
    */

    if(prev){
    80002500:	04068e63          	beqz	a3,8000255c <_Z13kern_mem_freePv+0x8c>
        if(prev->startingBlock+prev->sizeInBlocks==freedBlock->startingBlock){
    80002504:	0046a603          	lw	a2,4(a3)
    80002508:	0006a583          	lw	a1,0(a3)
    8000250c:	00b6063b          	addw	a2,a2,a1
    80002510:	c0452803          	lw	a6,-1020(a0)
    80002514:	03060a63          	beq	a2,a6,80002548 <_Z13kern_mem_freePv+0x78>
            prev->sizeInBlocks+=freedBlock->sizeInBlocks;
            freedBlock=prev;
        } else {
            prev->next=freedBlock;
    80002518:	00e6b423          	sd	a4,8(a3)
        }
    }
    else freeHead=freedBlock;

    if(curr){
    8000251c:	00078e63          	beqz	a5,80002538 <_Z13kern_mem_freePv+0x68>
        if(freedBlock->startingBlock+freedBlock->sizeInBlocks==curr->startingBlock){
    80002520:	00472683          	lw	a3,4(a4)
    80002524:	00072603          	lw	a2,0(a4)
    80002528:	00c686bb          	addw	a3,a3,a2
    8000252c:	0047a583          	lw	a1,4(a5)
    80002530:	02b68c63          	beq	a3,a1,80002568 <_Z13kern_mem_freePv+0x98>
            freedBlock->sizeInBlocks+=curr->sizeInBlocks;
            freedBlock->next=curr->next;
        } else{
          freedBlock->next=curr;
    80002534:	00f73423          	sd	a5,8(a4)
        }
    }


    return 0;
}
    80002538:	00000513          	li	a0,0
    8000253c:	00813403          	ld	s0,8(sp)
    80002540:	01010113          	addi	sp,sp,16
    80002544:	00008067          	ret
            prev->sizeInBlocks+=freedBlock->sizeInBlocks;
    80002548:	c0052703          	lw	a4,-1024(a0)
    8000254c:	00e585bb          	addw	a1,a1,a4
    80002550:	00b6a023          	sw	a1,0(a3)
            freedBlock=prev;
    80002554:	00068713          	mv	a4,a3
    80002558:	fc5ff06f          	j	8000251c <_Z13kern_mem_freePv+0x4c>
    else freeHead=freedBlock;
    8000255c:	0000b697          	auipc	a3,0xb
    80002560:	8ae6b223          	sd	a4,-1884(a3) # 8000ce00 <freeHead>
    80002564:	fb9ff06f          	j	8000251c <_Z13kern_mem_freePv+0x4c>
            freedBlock->sizeInBlocks+=curr->sizeInBlocks;
    80002568:	0007a683          	lw	a3,0(a5)
    8000256c:	00d6063b          	addw	a2,a2,a3
    80002570:	00c72023          	sw	a2,0(a4)
            freedBlock->next=curr->next;
    80002574:	0087b783          	ld	a5,8(a5)
    80002578:	00f73423          	sd	a5,8(a4)
    8000257c:	fbdff06f          	j	80002538 <_Z13kern_mem_freePv+0x68>

0000000080002580 <_Z13kern_mem_initPvS_>:

unsigned long ukupno_memorije;
void kern_mem_init(void* start, void* end)
{
    80002580:	ff010113          	addi	sp,sp,-16
    80002584:	00813423          	sd	s0,8(sp)
    80002588:	01010413          	addi	s0,sp,16
    unsigned long lstart = (unsigned long) start;
    unsigned long lend = (unsigned long) end;
    8000258c:	00058793          	mv	a5,a1

    if(lstart%MEM_BLOCK_SIZE>0) start =(void*) ((lstart/MEM_BLOCK_SIZE+1)*MEM_BLOCK_SIZE);
    80002590:	03f57713          	andi	a4,a0,63
    80002594:	00070863          	beqz	a4,800025a4 <_Z13kern_mem_initPvS_+0x24>
    80002598:	00655513          	srli	a0,a0,0x6
    8000259c:	00150513          	addi	a0,a0,1
    800025a0:	00651513          	slli	a0,a0,0x6
    if(lend%MEM_BLOCK_SIZE>0) end =(void*) ((lend/MEM_BLOCK_SIZE)*MEM_BLOCK_SIZE);
    800025a4:	03f7f713          	andi	a4,a5,63
    800025a8:	00070463          	beqz	a4,800025b0 <_Z13kern_mem_initPvS_+0x30>
    800025ac:	fc07f593          	andi	a1,a5,-64

    freeHead = (mem_block_s*)start;
    800025b0:	0000b797          	auipc	a5,0xb
    800025b4:	85078793          	addi	a5,a5,-1968 # 8000ce00 <freeHead>
    800025b8:	00a7b023          	sd	a0,0(a5)
    freeHead->next=0;
    800025bc:	00053423          	sd	zero,8(a0)
    freeHead->startingBlock=0;
    800025c0:	00052223          	sw	zero,4(a0)
    freeHead->sizeInBlocks = ((uint64)end-(uint64)start)/MEM_BLOCK_SIZE;
    800025c4:	40a58533          	sub	a0,a1,a0
    800025c8:	00655513          	srli	a0,a0,0x6
    800025cc:	0007b703          	ld	a4,0(a5)
    800025d0:	00a72023          	sw	a0,0(a4)
    ukupno_memorije=freeHead->sizeInBlocks;
    800025d4:	0007b703          	ld	a4,0(a5)
    800025d8:	00072703          	lw	a4,0(a4)
    800025dc:	00e7b423          	sd	a4,8(a5)
}
    800025e0:	00813403          	ld	s0,8(sp)
    800025e4:	01010113          	addi	sp,sp,16
    800025e8:	00008067          	ret

00000000800025ec <_Z17kern_console_initv>:
    int input_w;
    int output_r;
    int output_w;
} console;

void kern_console_init(){
    800025ec:	ff010113          	addi	sp,sp,-16
    800025f0:	00813423          	sd	s0,8(sp)
    800025f4:	01010413          	addi	s0,sp,16
    console.input_r=0;
    800025f8:	0000c797          	auipc	a5,0xc
    800025fc:	81878793          	addi	a5,a5,-2024 # 8000de10 <semaphores+0x7a8>
    80002600:	8007a023          	sw	zero,-2048(a5)
    console.input_w=0;
    80002604:	8007a223          	sw	zero,-2044(a5)
    console.output_r=0;
    80002608:	8007a423          	sw	zero,-2040(a5)
    console.input_w=0;
}
    8000260c:	00813403          	ld	s0,8(sp)
    80002610:	01010113          	addi	sp,sp,16
    80002614:	00008067          	ret

0000000080002618 <_Z12uart_getcharv>:

int uart_getchar(void)
{
    80002618:	ff010113          	addi	sp,sp,-16
    8000261c:	00813423          	sd	s0,8(sp)
    80002620:	01010413          	addi	s0,sp,16
    if((ReadReg(CONSOLE_STATUS) & CONSOLE_RX_STATUS_BIT)!=0){
    80002624:	0000a797          	auipc	a5,0xa
    80002628:	6ac7b783          	ld	a5,1708(a5) # 8000ccd0 <_GLOBAL_OFFSET_TABLE_+0x10>
    8000262c:	0007b783          	ld	a5,0(a5)
    80002630:	0007c783          	lbu	a5,0(a5)
    80002634:	0017f793          	andi	a5,a5,1
    80002638:	02078263          	beqz	a5,8000265c <_Z12uart_getcharv+0x44>
        // input data is ready.
        return ReadReg(CONSOLE_RX_DATA);
    8000263c:	0000a797          	auipc	a5,0xa
    80002640:	68c7b783          	ld	a5,1676(a5) # 8000ccc8 <_GLOBAL_OFFSET_TABLE_+0x8>
    80002644:	0007b783          	ld	a5,0(a5)
    80002648:	0007c503          	lbu	a0,0(a5)
    8000264c:	0ff57513          	andi	a0,a0,255
    } else {
        return -1;
    }
}
    80002650:	00813403          	ld	s0,8(sp)
    80002654:	01010113          	addi	sp,sp,16
    80002658:	00008067          	ret
        return -1;
    8000265c:	fff00513          	li	a0,-1
    80002660:	ff1ff06f          	j	80002650 <_Z12uart_getcharv+0x38>

0000000080002664 <_Z12uart_putcharv>:

void uart_putchar()
{
    80002664:	ff010113          	addi	sp,sp,-16
    80002668:	00813423          	sd	s0,8(sp)
    8000266c:	01010413          	addi	s0,sp,16
    if(console.output_r==console.output_w) return;
    80002670:	0000b717          	auipc	a4,0xb
    80002674:	7a070713          	addi	a4,a4,1952 # 8000de10 <semaphores+0x7a8>
    80002678:	80872783          	lw	a5,-2040(a4)
    8000267c:	80c72703          	lw	a4,-2036(a4)
    80002680:	06e78063          	beq	a5,a4,800026e0 <_Z12uart_putcharv+0x7c>

    if((ReadReg(CONSOLE_STATUS) & CONSOLE_TX_STATUS_BIT) == 0){
    80002684:	0000a717          	auipc	a4,0xa
    80002688:	64c73703          	ld	a4,1612(a4) # 8000ccd0 <_GLOBAL_OFFSET_TABLE_+0x10>
    8000268c:	00073703          	ld	a4,0(a4)
    80002690:	00074703          	lbu	a4,0(a4)
    80002694:	0ff77713          	andi	a4,a4,255
    80002698:	02077713          	andi	a4,a4,32
    8000269c:	04070263          	beqz	a4,800026e0 <_Z12uart_putcharv+0x7c>
        return;
    }

    char c = console.output[(console.output_r++)%BUFFER_SIZE];
    800026a0:	0017871b          	addiw	a4,a5,1
    800026a4:	0000b697          	auipc	a3,0xb
    800026a8:	f6e6aa23          	sw	a4,-140(a3) # 8000d618 <console+0x808>
    800026ac:	41f7d71b          	sraiw	a4,a5,0x1f
    800026b0:	0167571b          	srliw	a4,a4,0x16
    800026b4:	00f707bb          	addw	a5,a4,a5
    800026b8:	3ff7f793          	andi	a5,a5,1023
    800026bc:	40e787bb          	subw	a5,a5,a4
    800026c0:	0000a717          	auipc	a4,0xa
    800026c4:	75070713          	addi	a4,a4,1872 # 8000ce10 <console>
    800026c8:	00f707b3          	add	a5,a4,a5
    800026cc:	4007c703          	lbu	a4,1024(a5)
    WriteReg(CONSOLE_TX_DATA,c);
    800026d0:	0000a797          	auipc	a5,0xa
    800026d4:	6207b783          	ld	a5,1568(a5) # 8000ccf0 <_GLOBAL_OFFSET_TABLE_+0x30>
    800026d8:	0007b783          	ld	a5,0(a5)
    800026dc:	00e78023          	sb	a4,0(a5)
}
    800026e0:	00813403          	ld	s0,8(sp)
    800026e4:	01010113          	addi	sp,sp,16
    800026e8:	00008067          	ret

00000000800026ec <_Z17kern_uart_handlerv>:

void kern_uart_handler()
{
    800026ec:	ff010113          	addi	sp,sp,-16
    800026f0:	00113423          	sd	ra,8(sp)
    800026f4:	00813023          	sd	s0,0(sp)
    800026f8:	01010413          	addi	s0,sp,16
    while(1){
        int c = uart_getchar();
    800026fc:	00000097          	auipc	ra,0x0
    80002700:	f1c080e7          	jalr	-228(ra) # 80002618 <_Z12uart_getcharv>
        if(c==-1) break;
    80002704:	fff00793          	li	a5,-1
    80002708:	04f50063          	beq	a0,a5,80002748 <_Z17kern_uart_handlerv+0x5c>
        console.input[(console.input_w++)%BUFFER_SIZE]=c;
    8000270c:	0000b717          	auipc	a4,0xb
    80002710:	70470713          	addi	a4,a4,1796 # 8000de10 <semaphores+0x7a8>
    80002714:	80472783          	lw	a5,-2044(a4)
    80002718:	0017869b          	addiw	a3,a5,1
    8000271c:	80d72223          	sw	a3,-2044(a4)
    80002720:	41f7d71b          	sraiw	a4,a5,0x1f
    80002724:	0167571b          	srliw	a4,a4,0x16
    80002728:	00f707bb          	addw	a5,a4,a5
    8000272c:	3ff7f793          	andi	a5,a5,1023
    80002730:	40e787bb          	subw	a5,a5,a4
    80002734:	0000a717          	auipc	a4,0xa
    80002738:	6dc70713          	addi	a4,a4,1756 # 8000ce10 <console>
    8000273c:	00f707b3          	add	a5,a4,a5
    80002740:	00a78023          	sb	a0,0(a5)
    }
    80002744:	fb9ff06f          	j	800026fc <_Z17kern_uart_handlerv+0x10>

    uart_putchar();
    80002748:	00000097          	auipc	ra,0x0
    8000274c:	f1c080e7          	jalr	-228(ra) # 80002664 <_Z12uart_putcharv>
}
    80002750:	00813083          	ld	ra,8(sp)
    80002754:	00013403          	ld	s0,0(sp)
    80002758:	01010113          	addi	sp,sp,16
    8000275c:	00008067          	ret

0000000080002760 <_Z20kern_console_getcharv>:

int kern_console_getchar()
{
    80002760:	ff010113          	addi	sp,sp,-16
    80002764:	00813423          	sd	s0,8(sp)
    80002768:	01010413          	addi	s0,sp,16
    if(console.input_r<console.input_w){
    8000276c:	0000b717          	auipc	a4,0xb
    80002770:	6a470713          	addi	a4,a4,1700 # 8000de10 <semaphores+0x7a8>
    80002774:	80072783          	lw	a5,-2048(a4)
    80002778:	80472703          	lw	a4,-2044(a4)
    8000277c:	04e7d063          	bge	a5,a4,800027bc <_Z20kern_console_getcharv+0x5c>
        return console.input[(console.input_r++)%BUFFER_SIZE];
    80002780:	0017871b          	addiw	a4,a5,1
    80002784:	0000b697          	auipc	a3,0xb
    80002788:	e8e6a623          	sw	a4,-372(a3) # 8000d610 <console+0x800>
    8000278c:	41f7d71b          	sraiw	a4,a5,0x1f
    80002790:	0167571b          	srliw	a4,a4,0x16
    80002794:	00f707bb          	addw	a5,a4,a5
    80002798:	3ff7f793          	andi	a5,a5,1023
    8000279c:	40e787bb          	subw	a5,a5,a4
    800027a0:	0000a717          	auipc	a4,0xa
    800027a4:	67070713          	addi	a4,a4,1648 # 8000ce10 <console>
    800027a8:	00f707b3          	add	a5,a4,a5
    800027ac:	0007c503          	lbu	a0,0(a5)
    }
    else return -1;
}
    800027b0:	00813403          	ld	s0,8(sp)
    800027b4:	01010113          	addi	sp,sp,16
    800027b8:	00008067          	ret
    else return -1;
    800027bc:	fff00513          	li	a0,-1
    800027c0:	ff1ff06f          	j	800027b0 <_Z20kern_console_getcharv+0x50>

00000000800027c4 <_Z20kern_console_putcharc>:

int kern_console_putchar(char c)
{
    800027c4:	ff010113          	addi	sp,sp,-16
    800027c8:	00813423          	sd	s0,8(sp)
    800027cc:	01010413          	addi	s0,sp,16
    if(ReadReg(CONSOLE_STATUS) & CONSOLE_TX_STATUS_BIT){
    800027d0:	0000a797          	auipc	a5,0xa
    800027d4:	5007b783          	ld	a5,1280(a5) # 8000ccd0 <_GLOBAL_OFFSET_TABLE_+0x10>
    800027d8:	0007b783          	ld	a5,0(a5)
    800027dc:	0007c783          	lbu	a5,0(a5)
    800027e0:	0ff7f793          	andi	a5,a5,255
    800027e4:	0207f793          	andi	a5,a5,32
    800027e8:	02078263          	beqz	a5,8000280c <_Z20kern_console_putcharc+0x48>
        WriteReg(CONSOLE_TX_DATA,c);
    800027ec:	0000a797          	auipc	a5,0xa
    800027f0:	5047b783          	ld	a5,1284(a5) # 8000ccf0 <_GLOBAL_OFFSET_TABLE_+0x30>
    800027f4:	0007b783          	ld	a5,0(a5)
    800027f8:	00a78023          	sb	a0,0(a5)
    }
    else{
        if(console.output_r-console.output_w>=BUFFER_SIZE) return -1;
        console.output[(console.output_w++)%BUFFER_SIZE]=c;
    }
    return 0;
    800027fc:	00000513          	li	a0,0
}
    80002800:	00813403          	ld	s0,8(sp)
    80002804:	01010113          	addi	sp,sp,16
    80002808:	00008067          	ret
        if(console.output_r-console.output_w>=BUFFER_SIZE) return -1;
    8000280c:	0000b797          	auipc	a5,0xb
    80002810:	60478793          	addi	a5,a5,1540 # 8000de10 <semaphores+0x7a8>
    80002814:	8087a703          	lw	a4,-2040(a5)
    80002818:	80c7a783          	lw	a5,-2036(a5)
    8000281c:	40f7073b          	subw	a4,a4,a5
    80002820:	3ff00693          	li	a3,1023
    80002824:	02e6ce63          	blt	a3,a4,80002860 <_Z20kern_console_putcharc+0x9c>
        console.output[(console.output_w++)%BUFFER_SIZE]=c;
    80002828:	0017871b          	addiw	a4,a5,1
    8000282c:	0000b697          	auipc	a3,0xb
    80002830:	dee6a823          	sw	a4,-528(a3) # 8000d61c <console+0x80c>
    80002834:	41f7d71b          	sraiw	a4,a5,0x1f
    80002838:	0167571b          	srliw	a4,a4,0x16
    8000283c:	00f707bb          	addw	a5,a4,a5
    80002840:	3ff7f793          	andi	a5,a5,1023
    80002844:	40e787bb          	subw	a5,a5,a4
    80002848:	0000a717          	auipc	a4,0xa
    8000284c:	5c870713          	addi	a4,a4,1480 # 8000ce10 <console>
    80002850:	00f707b3          	add	a5,a4,a5
    80002854:	40a78023          	sb	a0,1024(a5)
    return 0;
    80002858:	00000513          	li	a0,0
    8000285c:	fa5ff06f          	j	80002800 <_Z20kern_console_putcharc+0x3c>
        if(console.output_r-console.output_w>=BUFFER_SIZE) return -1;
    80002860:	fff00513          	li	a0,-1
    80002864:	f9dff06f          	j	80002800 <_Z20kern_console_putcharc+0x3c>

0000000080002868 <_Z8bodyIdlePv>:

Semaphore* semTest;

int idleAlive=1;
void bodyIdle(void* arg){
    while(idleAlive){
    80002868:	0000a797          	auipc	a5,0xa
    8000286c:	2307a783          	lw	a5,560(a5) # 8000ca98 <idleAlive>
    80002870:	02078c63          	beqz	a5,800028a8 <_Z8bodyIdlePv+0x40>
void bodyIdle(void* arg){
    80002874:	ff010113          	addi	sp,sp,-16
    80002878:	00113423          	sd	ra,8(sp)
    8000287c:	00813023          	sd	s0,0(sp)
    80002880:	01010413          	addi	s0,sp,16
        thread_dispatch();
    80002884:	fffff097          	auipc	ra,0xfffff
    80002888:	b04080e7          	jalr	-1276(ra) # 80001388 <_Z15thread_dispatchv>
    while(idleAlive){
    8000288c:	0000a797          	auipc	a5,0xa
    80002890:	20c7a783          	lw	a5,524(a5) # 8000ca98 <idleAlive>
    80002894:	fe0798e3          	bnez	a5,80002884 <_Z8bodyIdlePv+0x1c>
    };
}
    80002898:	00813083          	ld	ra,8(sp)
    8000289c:	00013403          	ld	s0,0(sp)
    800028a0:	01010113          	addi	sp,sp,16
    800028a4:	00008067          	ret
    800028a8:	00008067          	ret

00000000800028ac <_Z5bodyAPv>:
    counter++;
    //thread_exit();
}

void bodyA(void* arg)
{
    800028ac:	fe010113          	addi	sp,sp,-32
    800028b0:	00113c23          	sd	ra,24(sp)
    800028b4:	00813823          	sd	s0,16(sp)
    800028b8:	00913423          	sd	s1,8(sp)
    800028bc:	02010413          	addi	s0,sp,32
    char c = 'a';
    //if(semTest->wait()) c='A';
    for(int i=0;i<10;i++){
    800028c0:	00000493          	li	s1,0
    800028c4:	0180006f          	j	800028dc <_Z5bodyAPv+0x30>
        putc(c);
        if(i==5) thread_exit();
    800028c8:	fffff097          	auipc	ra,0xfffff
    800028cc:	aec080e7          	jalr	-1300(ra) # 800013b4 <_Z11thread_exitv>
        thread_dispatch();
    800028d0:	fffff097          	auipc	ra,0xfffff
    800028d4:	ab8080e7          	jalr	-1352(ra) # 80001388 <_Z15thread_dispatchv>
    for(int i=0;i<10;i++){
    800028d8:	0014849b          	addiw	s1,s1,1
    800028dc:	00900793          	li	a5,9
    800028e0:	0097ce63          	blt	a5,s1,800028fc <_Z5bodyAPv+0x50>
        putc(c);
    800028e4:	06100513          	li	a0,97
    800028e8:	fffff097          	auipc	ra,0xfffff
    800028ec:	cc8080e7          	jalr	-824(ra) # 800015b0 <_Z4putcc>
        if(i==5) thread_exit();
    800028f0:	00500793          	li	a5,5
    800028f4:	fcf49ee3          	bne	s1,a5,800028d0 <_Z5bodyAPv+0x24>
    800028f8:	fd1ff06f          	j	800028c8 <_Z5bodyAPv+0x1c>
    }
}
    800028fc:	01813083          	ld	ra,24(sp)
    80002900:	01013403          	ld	s0,16(sp)
    80002904:	00813483          	ld	s1,8(sp)
    80002908:	02010113          	addi	sp,sp,32
    8000290c:	00008067          	ret

0000000080002910 <_Z5bodyBPv>:

int g=0;

char str[15] = "tesa legenda";
void bodyB(void* arg)
{
    80002910:	fe010113          	addi	sp,sp,-32
    80002914:	00113c23          	sd	ra,24(sp)
    80002918:	00813823          	sd	s0,16(sp)
    8000291c:	00913423          	sd	s1,8(sp)
    80002920:	02010413          	addi	s0,sp,32

    //time_sleep(10);
    for(int i=0;i<10;i++){
    80002924:	00000493          	li	s1,0
    80002928:	0540006f          	j	8000297c <_Z5bodyBPv+0x6c>
        putc(str[i]);
        for(int k=0;k<10000;k++){
            for(int m=0;m<1000;m++){
    8000292c:	0017071b          	addiw	a4,a4,1
    80002930:	3e700793          	li	a5,999
    80002934:	02e7c663          	blt	a5,a4,80002960 <_Z5bodyBPv+0x50>
                if((m*k)%1337==0) g++;
    80002938:	02e607bb          	mulw	a5,a2,a4
    8000293c:	53900693          	li	a3,1337
    80002940:	02d7e7bb          	remw	a5,a5,a3
    80002944:	fe0794e3          	bnez	a5,8000292c <_Z5bodyBPv+0x1c>
    80002948:	0000b697          	auipc	a3,0xb
    8000294c:	cd868693          	addi	a3,a3,-808 # 8000d620 <g>
    80002950:	0006a783          	lw	a5,0(a3)
    80002954:	0017879b          	addiw	a5,a5,1
    80002958:	00f6a023          	sw	a5,0(a3)
    8000295c:	fd1ff06f          	j	8000292c <_Z5bodyBPv+0x1c>
        for(int k=0;k<10000;k++){
    80002960:	0016061b          	addiw	a2,a2,1
    80002964:	000027b7          	lui	a5,0x2
    80002968:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    8000296c:	00c7c663          	blt	a5,a2,80002978 <_Z5bodyBPv+0x68>
            for(int m=0;m<1000;m++){
    80002970:	00000713          	li	a4,0
    80002974:	fbdff06f          	j	80002930 <_Z5bodyBPv+0x20>
    for(int i=0;i<10;i++){
    80002978:	0014849b          	addiw	s1,s1,1
    8000297c:	00900793          	li	a5,9
    80002980:	0297c263          	blt	a5,s1,800029a4 <_Z5bodyBPv+0x94>
        putc(str[i]);
    80002984:	0000a797          	auipc	a5,0xa
    80002988:	11478793          	addi	a5,a5,276 # 8000ca98 <idleAlive>
    8000298c:	009787b3          	add	a5,a5,s1
    80002990:	0087c503          	lbu	a0,8(a5)
    80002994:	fffff097          	auipc	ra,0xfffff
    80002998:	c1c080e7          	jalr	-996(ra) # 800015b0 <_Z4putcc>
        for(int k=0;k<10000;k++){
    8000299c:	00000613          	li	a2,0
    800029a0:	fc5ff06f          	j	80002964 <_Z5bodyBPv+0x54>
        }
        int wait (){
            return sem_wait(myHandle);
        }
        int signal (){
            return sem_signal(myHandle);
    800029a4:	0000b797          	auipc	a5,0xb
    800029a8:	c847b783          	ld	a5,-892(a5) # 8000d628 <semTest>
    800029ac:	0087b503          	ld	a0,8(a5)
    800029b0:	fffff097          	auipc	ra,0xfffff
    800029b4:	b50080e7          	jalr	-1200(ra) # 80001500 <_Z10sem_signalP5sem_s>
            }
        }
    }
    semTest->signal();
}
    800029b8:	01813083          	ld	ra,24(sp)
    800029bc:	01013403          	ld	s0,16(sp)
    800029c0:	00813483          	ld	s1,8(sp)
    800029c4:	02010113          	addi	sp,sp,32
    800029c8:	00008067          	ret

00000000800029cc <_Z5bodyCPv>:
{
    800029cc:	fe010113          	addi	sp,sp,-32
    800029d0:	00113c23          	sd	ra,24(sp)
    800029d4:	00813823          	sd	s0,16(sp)
    800029d8:	00913423          	sd	s1,8(sp)
    800029dc:	01213023          	sd	s2,0(sp)
    800029e0:	02010413          	addi	s0,sp,32
    800029e4:	00050913          	mv	s2,a0
    int counter=0;
    800029e8:	00000493          	li	s1,0
    while(counter<10){
    800029ec:	00900793          	li	a5,9
    800029f0:	0297c263          	blt	a5,s1,80002a14 <_Z5bodyCPv+0x48>
        putc(*c);
    800029f4:	00094503          	lbu	a0,0(s2)
    800029f8:	fffff097          	auipc	ra,0xfffff
    800029fc:	bb8080e7          	jalr	-1096(ra) # 800015b0 <_Z4putcc>
        time_sleep(1);
    80002a00:	00100513          	li	a0,1
    80002a04:	fffff097          	auipc	ra,0xfffff
    80002a08:	b3c080e7          	jalr	-1220(ra) # 80001540 <_Z10time_sleepm>
        counter++;
    80002a0c:	0014849b          	addiw	s1,s1,1
    while(counter<10){
    80002a10:	fddff06f          	j	800029ec <_Z5bodyCPv+0x20>
}
    80002a14:	01813083          	ld	ra,24(sp)
    80002a18:	01013403          	ld	s0,16(sp)
    80002a1c:	00813483          	ld	s1,8(sp)
    80002a20:	00013903          	ld	s2,0(sp)
    80002a24:	02010113          	addi	sp,sp,32
    80002a28:	00008067          	ret

0000000080002a2c <main>:
        putc(c++);
    }
};

int main()
{
    80002a2c:	fc010113          	addi	sp,sp,-64
    80002a30:	02113c23          	sd	ra,56(sp)
    80002a34:	02813823          	sd	s0,48(sp)
    80002a38:	02913423          	sd	s1,40(sp)
    80002a3c:	03213023          	sd	s2,32(sp)
    80002a40:	01313c23          	sd	s3,24(sp)
    80002a44:	04010413          	addi	s0,sp,64
    char* buddy_start = (char*)HEAP_START_ADDR;
    80002a48:	0000a797          	auipc	a5,0xa
    80002a4c:	2907b783          	ld	a5,656(a5) # 8000ccd8 <_GLOBAL_OFFSET_TABLE_+0x18>
    80002a50:	0007b503          	ld	a0,0(a5)
    uint64 memory_size = ((char *)HEAP_END_ADDR-(char *)HEAP_START_ADDR);
    80002a54:	0000a917          	auipc	s2,0xa
    80002a58:	2ac93903          	ld	s2,684(s2) # 8000cd00 <_GLOBAL_OFFSET_TABLE_+0x40>
    80002a5c:	00093583          	ld	a1,0(s2)
    80002a60:	40a585b3          	sub	a1,a1,a0
    uint64 buddy_size_in_blocks = (memory_size/8)/BLOCK_SIZE+1;
    80002a64:	00f5d593          	srli	a1,a1,0xf
    80002a68:	00158593          	addi	a1,a1,1
    char* buddy_end = buddy_start+buddy_size_in_blocks*BLOCK_SIZE;
    80002a6c:	00c59493          	slli	s1,a1,0xc
    80002a70:	009504b3          	add	s1,a0,s1
    kmem_init(buddy_start,buddy_size_in_blocks);
    80002a74:	0005859b          	sext.w	a1,a1
    80002a78:	00001097          	auipc	ra,0x1
    80002a7c:	1ac080e7          	jalr	428(ra) # 80003c24 <_Z9kmem_initPvi>
    kern_mem_init((void*)buddy_end, (void*)HEAP_END_ADDR);
    80002a80:	00093583          	ld	a1,0(s2)
    80002a84:	00048513          	mv	a0,s1
    80002a88:	00000097          	auipc	ra,0x0
    80002a8c:	af8080e7          	jalr	-1288(ra) # 80002580 <_Z13kern_mem_initPvS_>
    kern_thread_init();
    80002a90:	00000097          	auipc	ra,0x0
    80002a94:	4e8080e7          	jalr	1256(ra) # 80002f78 <_Z16kern_thread_initv>

    kern_interrupt_init();
    80002a98:	00001097          	auipc	ra,0x1
    80002a9c:	d2c080e7          	jalr	-724(ra) # 800037c4 <_Z19kern_interrupt_initv>
    kern_sem_init();
    80002aa0:	00001097          	auipc	ra,0x1
    80002aa4:	ad8080e7          	jalr	-1320(ra) # 80003578 <_Z13kern_sem_initv>
    kern_console_init();
    80002aa8:	00000097          	auipc	ra,0x0
    80002aac:	b44080e7          	jalr	-1212(ra) # 800025ec <_Z17kern_console_initv>

    Thread* thrIdle = new Thread(&bodyIdle,0);
    80002ab0:	02000513          	li	a0,32
    80002ab4:	00000097          	auipc	ra,0x0
    80002ab8:	428080e7          	jalr	1064(ra) # 80002edc <_Znwm>
        {
    80002abc:	0000a717          	auipc	a4,0xa
    80002ac0:	00470713          	addi	a4,a4,4 # 8000cac0 <_ZTV6Thread+0x10>
    80002ac4:	00e53023          	sd	a4,0(a0)
            this->body=body;
    80002ac8:	00000717          	auipc	a4,0x0
    80002acc:	da070713          	addi	a4,a4,-608 # 80002868 <_Z8bodyIdlePv>
    80002ad0:	00e53823          	sd	a4,16(a0)
            this->arg=arg;
    80002ad4:	00053c23          	sd	zero,24(a0)
    80002ad8:	fca43423          	sd	a0,-56(s0)
    thrIdle->start();
    80002adc:	00000097          	auipc	ra,0x0
    80002ae0:	3ac080e7          	jalr	940(ra) # 80002e88 <_ZN6Thread5startEv>

    printf("Printf proba %d valjda radi %x, %p\n", &thrIdle, &thrIdle, &thrIdle);
    80002ae4:	fc840593          	addi	a1,s0,-56
    80002ae8:	00058693          	mv	a3,a1
    80002aec:	00058613          	mv	a2,a1
    80002af0:	00007517          	auipc	a0,0x7
    80002af4:	69050513          	addi	a0,a0,1680 # 8000a180 <CONSOLE_STATUS+0x170>
    80002af8:	fffff097          	auipc	ra,0xfffff
    80002afc:	748080e7          	jalr	1864(ra) # 80002240 <_Z6printfPKcz>
    //bba_init((char*)HEAP_START_ADDR, (char*)HEAP_END_ADDR);
    semTest=new Semaphore(0);
    80002b00:	01000513          	li	a0,16
    80002b04:	00000097          	auipc	ra,0x0
    80002b08:	3d8080e7          	jalr	984(ra) # 80002edc <_Znwm>
    80002b0c:	00050493          	mv	s1,a0
        Semaphore (unsigned init = 1){
    80002b10:	0000a797          	auipc	a5,0xa
    80002b14:	fd878793          	addi	a5,a5,-40 # 8000cae8 <_ZTV9Semaphore+0x10>
    80002b18:	00f53023          	sd	a5,0(a0)
            sem_open(&myHandle,init);
    80002b1c:	00000593          	li	a1,0
    80002b20:	00850513          	addi	a0,a0,8
    80002b24:	fffff097          	auipc	ra,0xfffff
    80002b28:	918080e7          	jalr	-1768(ra) # 8000143c <_Z8sem_openPP5sem_sj>
    80002b2c:	0000b797          	auipc	a5,0xb
    80002b30:	ae97be23          	sd	s1,-1284(a5) # 8000d628 <semTest>
    Thread *thrA = new Thread(&bodyA,0);
    80002b34:	02000513          	li	a0,32
    80002b38:	00000097          	auipc	ra,0x0
    80002b3c:	3a4080e7          	jalr	932(ra) # 80002edc <_Znwm>
    80002b40:	00050913          	mv	s2,a0
        {
    80002b44:	0000a997          	auipc	s3,0xa
    80002b48:	f7c98993          	addi	s3,s3,-132 # 8000cac0 <_ZTV6Thread+0x10>
    80002b4c:	01353023          	sd	s3,0(a0)
            this->body=body;
    80002b50:	00000797          	auipc	a5,0x0
    80002b54:	d5c78793          	addi	a5,a5,-676 # 800028ac <_Z5bodyAPv>
    80002b58:	00f53823          	sd	a5,16(a0)
            this->arg=arg;
    80002b5c:	00053c23          	sd	zero,24(a0)
    Thread *thrB = new Thread(&bodyB,0);
    80002b60:	02000513          	li	a0,32
    80002b64:	00000097          	auipc	ra,0x0
    80002b68:	378080e7          	jalr	888(ra) # 80002edc <_Znwm>
    80002b6c:	00050493          	mv	s1,a0
        {
    80002b70:	01353023          	sd	s3,0(a0)
            this->body=body;
    80002b74:	00000797          	auipc	a5,0x0
    80002b78:	d9c78793          	addi	a5,a5,-612 # 80002910 <_Z5bodyBPv>
    80002b7c:	00f53823          	sd	a5,16(a0)
            this->arg=arg;
    80002b80:	00053c23          	sd	zero,24(a0)
    thrB->start();
    80002b84:	00000097          	auipc	ra,0x0
    80002b88:	304080e7          	jalr	772(ra) # 80002e88 <_ZN6Thread5startEv>
    thrA->start();
    80002b8c:	00090513          	mv	a0,s2
    80002b90:	00000097          	auipc	ra,0x0
    80002b94:	2f8080e7          	jalr	760(ra) # 80002e88 <_ZN6Thread5startEv>
            thread_join(myHandle);
    80002b98:	0084b503          	ld	a0,8(s1)
    80002b9c:	fffff097          	auipc	ra,0xfffff
    80002ba0:	870080e7          	jalr	-1936(ra) # 8000140c <_Z11thread_joinP8thread_s>
    thrB->join();
    putc('S');
    80002ba4:	05300513          	li	a0,83
    80002ba8:	fffff097          	auipc	ra,0xfffff
    80002bac:	a08080e7          	jalr	-1528(ra) # 800015b0 <_Z4putcc>
    x=getc();
    x++;
    putc(x);*/
    //userMain();

    PeriodicTest* pt = new PeriodicTest(30, 'A');
    80002bb0:	03800513          	li	a0,56
    80002bb4:	00000097          	auipc	ra,0x0
    80002bb8:	328080e7          	jalr	808(ra) # 80002edc <_Znwm>
    80002bbc:	00050993          	mv	s3,a0
            body= nullptr;
    80002bc0:	00053823          	sd	zero,16(a0)
            arg= nullptr;
    80002bc4:	00053c23          	sd	zero,24(a0)
        this->period=period;
    80002bc8:	01e00793          	li	a5,30
    80002bcc:	02f53423          	sd	a5,40(a0)
        this->isThisPeriodicThreadTereminated=0;
    80002bd0:	02052023          	sw	zero,32(a0)
    PeriodicTest(uint64 period, char c) : PeriodicThread(period){
    80002bd4:	0000a497          	auipc	s1,0xa
    80002bd8:	f3448493          	addi	s1,s1,-204 # 8000cb08 <_ZTV12PeriodicTest+0x10>
    80002bdc:	00953023          	sd	s1,0(a0)
        this->c = c;
    80002be0:	04100793          	li	a5,65
    80002be4:	02f50823          	sb	a5,48(a0)
    PeriodicTest* pt2 = new PeriodicTest(10, 'a');
    80002be8:	03800513          	li	a0,56
    80002bec:	00000097          	auipc	ra,0x0
    80002bf0:	2f0080e7          	jalr	752(ra) # 80002edc <_Znwm>
    80002bf4:	00050913          	mv	s2,a0
            body= nullptr;
    80002bf8:	00053823          	sd	zero,16(a0)
            arg= nullptr;
    80002bfc:	00053c23          	sd	zero,24(a0)
        this->period=period;
    80002c00:	00a00793          	li	a5,10
    80002c04:	02f53423          	sd	a5,40(a0)
        this->isThisPeriodicThreadTereminated=0;
    80002c08:	02052023          	sw	zero,32(a0)
    PeriodicTest(uint64 period, char c) : PeriodicThread(period){
    80002c0c:	00953023          	sd	s1,0(a0)
        this->c = c;
    80002c10:	06100793          	li	a5,97
    80002c14:	02f50823          	sb	a5,48(a0)
    pt->start();
    80002c18:	00098513          	mv	a0,s3
    80002c1c:	00000097          	auipc	ra,0x0
    80002c20:	26c080e7          	jalr	620(ra) # 80002e88 <_ZN6Thread5startEv>
    pt2->start();
    80002c24:	00090513          	mv	a0,s2
    80002c28:	00000097          	auipc	ra,0x0
    80002c2c:	260080e7          	jalr	608(ra) # 80002e88 <_ZN6Thread5startEv>
    putc('E');
    80002c30:	04500513          	li	a0,69
    80002c34:	fffff097          	auipc	ra,0xfffff
    80002c38:	97c080e7          	jalr	-1668(ra) # 800015b0 <_Z4putcc>
    char x = 'm';
    80002c3c:	06d00493          	li	s1,109
    while (x!='x'){
    80002c40:	07800793          	li	a5,120
    80002c44:	02f48c63          	beq	s1,a5,80002c7c <main+0x250>
        x=getc();
    80002c48:	fffff097          	auipc	ra,0xfffff
    80002c4c:	92c080e7          	jalr	-1748(ra) # 80001574 <_Z4getcv>
    80002c50:	00050493          	mv	s1,a0
        putc(x);
    80002c54:	fffff097          	auipc	ra,0xfffff
    80002c58:	95c080e7          	jalr	-1700(ra) # 800015b0 <_Z4putcc>
    80002c5c:	fe5ff06f          	j	80002c40 <main+0x214>
    80002c60:	00050913          	mv	s2,a0
    semTest=new Semaphore(0);
    80002c64:	00048513          	mv	a0,s1
    80002c68:	00000097          	auipc	ra,0x0
    80002c6c:	29c080e7          	jalr	668(ra) # 80002f04 <_ZdlPv>
    80002c70:	00090513          	mv	a0,s2
    80002c74:	0000d097          	auipc	ra,0xd
    80002c78:	f24080e7          	jalr	-220(ra) # 8000fb98 <_Unwind_Resume>
        isThisPeriodicThreadTereminated=1;
    80002c7c:	00100793          	li	a5,1
    80002c80:	02f9a023          	sw	a5,32(s3)
    80002c84:	02f92023          	sw	a5,32(s2)
    }

    pt->terminate();
    pt2->terminate();
    idleAlive=0;
    80002c88:	0000a797          	auipc	a5,0xa
    80002c8c:	e007a823          	sw	zero,-496(a5) # 8000ca98 <idleAlive>
    return 0;
    80002c90:	00000513          	li	a0,0
    80002c94:	03813083          	ld	ra,56(sp)
    80002c98:	03013403          	ld	s0,48(sp)
    80002c9c:	02813483          	ld	s1,40(sp)
    80002ca0:	02013903          	ld	s2,32(sp)
    80002ca4:	01813983          	ld	s3,24(sp)
    80002ca8:	04010113          	addi	sp,sp,64
    80002cac:	00008067          	ret

0000000080002cb0 <_ZN6ThreadD1Ev>:
        virtual ~Thread (){
    80002cb0:	ff010113          	addi	sp,sp,-16
    80002cb4:	00813423          	sd	s0,8(sp)
    80002cb8:	01010413          	addi	s0,sp,16
        }
    80002cbc:	00813403          	ld	s0,8(sp)
    80002cc0:	01010113          	addi	sp,sp,16
    80002cc4:	00008067          	ret

0000000080002cc8 <_ZN6Thread3runEv>:
        virtual void run () {}
    80002cc8:	ff010113          	addi	sp,sp,-16
    80002ccc:	00813423          	sd	s0,8(sp)
    80002cd0:	01010413          	addi	s0,sp,16
    80002cd4:	00813403          	ld	s0,8(sp)
    80002cd8:	01010113          	addi	sp,sp,16
    80002cdc:	00008067          	ret

0000000080002ce0 <_ZN6Thread11threadEntryEPv>:
        static void threadEntry(void* arg){
    80002ce0:	ff010113          	addi	sp,sp,-16
    80002ce4:	00113423          	sd	ra,8(sp)
    80002ce8:	00813023          	sd	s0,0(sp)
    80002cec:	01010413          	addi	s0,sp,16
            self->run();
    80002cf0:	00053783          	ld	a5,0(a0)
    80002cf4:	0107b783          	ld	a5,16(a5)
    80002cf8:	000780e7          	jalr	a5
        }
    80002cfc:	00813083          	ld	ra,8(sp)
    80002d00:	00013403          	ld	s0,0(sp)
    80002d04:	01010113          	addi	sp,sp,16
    80002d08:	00008067          	ret

0000000080002d0c <_ZN12PeriodicTestD1Ev>:
class PeriodicTest : public PeriodicThread {
    80002d0c:	ff010113          	addi	sp,sp,-16
    80002d10:	00813423          	sd	s0,8(sp)
    80002d14:	01010413          	addi	s0,sp,16
    80002d18:	00813403          	ld	s0,8(sp)
    80002d1c:	01010113          	addi	sp,sp,16
    80002d20:	00008067          	ret

0000000080002d24 <_ZN12PeriodicTest18periodicActivationEv>:
    void periodicActivation() override {
    80002d24:	ff010113          	addi	sp,sp,-16
    80002d28:	00113423          	sd	ra,8(sp)
    80002d2c:	00813023          	sd	s0,0(sp)
    80002d30:	01010413          	addi	s0,sp,16
    80002d34:	00050793          	mv	a5,a0
        putc(c++);
    80002d38:	03054503          	lbu	a0,48(a0)
    80002d3c:	0015071b          	addiw	a4,a0,1
    80002d40:	02e78823          	sb	a4,48(a5)
    80002d44:	fffff097          	auipc	ra,0xfffff
    80002d48:	86c080e7          	jalr	-1940(ra) # 800015b0 <_Z4putcc>
    }
    80002d4c:	00813083          	ld	ra,8(sp)
    80002d50:	00013403          	ld	s0,0(sp)
    80002d54:	01010113          	addi	sp,sp,16
    80002d58:	00008067          	ret

0000000080002d5c <_ZN14PeriodicThread3runEv>:
    void run() override {
    80002d5c:	fe010113          	addi	sp,sp,-32
    80002d60:	00113c23          	sd	ra,24(sp)
    80002d64:	00813823          	sd	s0,16(sp)
    80002d68:	00913423          	sd	s1,8(sp)
    80002d6c:	02010413          	addi	s0,sp,32
    80002d70:	00050493          	mv	s1,a0
        while (isThisPeriodicThreadTereminated==0){
    80002d74:	0204a783          	lw	a5,32(s1)
    80002d78:	02079263          	bnez	a5,80002d9c <_ZN14PeriodicThread3runEv+0x40>
            periodicActivation();
    80002d7c:	0004b783          	ld	a5,0(s1)
    80002d80:	0187b783          	ld	a5,24(a5)
    80002d84:	00048513          	mv	a0,s1
    80002d88:	000780e7          	jalr	a5
            return time_sleep(time);
    80002d8c:	0284b503          	ld	a0,40(s1)
    80002d90:	ffffe097          	auipc	ra,0xffffe
    80002d94:	7b0080e7          	jalr	1968(ra) # 80001540 <_Z10time_sleepm>
    80002d98:	fddff06f          	j	80002d74 <_ZN14PeriodicThread3runEv+0x18>
    }
    80002d9c:	01813083          	ld	ra,24(sp)
    80002da0:	01013403          	ld	s0,16(sp)
    80002da4:	00813483          	ld	s1,8(sp)
    80002da8:	02010113          	addi	sp,sp,32
    80002dac:	00008067          	ret

0000000080002db0 <_ZN6ThreadD0Ev>:
        virtual ~Thread (){
    80002db0:	ff010113          	addi	sp,sp,-16
    80002db4:	00113423          	sd	ra,8(sp)
    80002db8:	00813023          	sd	s0,0(sp)
    80002dbc:	01010413          	addi	s0,sp,16
        }
    80002dc0:	00000097          	auipc	ra,0x0
    80002dc4:	144080e7          	jalr	324(ra) # 80002f04 <_ZdlPv>
    80002dc8:	00813083          	ld	ra,8(sp)
    80002dcc:	00013403          	ld	s0,0(sp)
    80002dd0:	01010113          	addi	sp,sp,16
    80002dd4:	00008067          	ret

0000000080002dd8 <_ZN12PeriodicTestD0Ev>:
class PeriodicTest : public PeriodicThread {
    80002dd8:	ff010113          	addi	sp,sp,-16
    80002ddc:	00113423          	sd	ra,8(sp)
    80002de0:	00813023          	sd	s0,0(sp)
    80002de4:	01010413          	addi	s0,sp,16
    80002de8:	00000097          	auipc	ra,0x0
    80002dec:	11c080e7          	jalr	284(ra) # 80002f04 <_ZdlPv>
    80002df0:	00813083          	ld	ra,8(sp)
    80002df4:	00013403          	ld	s0,0(sp)
    80002df8:	01010113          	addi	sp,sp,16
    80002dfc:	00008067          	ret

0000000080002e00 <_ZN9SemaphoreD1Ev>:
        virtual ~Semaphore (){
    80002e00:	ff010113          	addi	sp,sp,-16
    80002e04:	00113423          	sd	ra,8(sp)
    80002e08:	00813023          	sd	s0,0(sp)
    80002e0c:	01010413          	addi	s0,sp,16
    80002e10:	0000a797          	auipc	a5,0xa
    80002e14:	cd878793          	addi	a5,a5,-808 # 8000cae8 <_ZTV9Semaphore+0x10>
    80002e18:	00f53023          	sd	a5,0(a0)
            sem_close(myHandle);
    80002e1c:	00853503          	ld	a0,8(a0)
    80002e20:	ffffe097          	auipc	ra,0xffffe
    80002e24:	660080e7          	jalr	1632(ra) # 80001480 <_Z9sem_closeP5sem_s>
        }
    80002e28:	00813083          	ld	ra,8(sp)
    80002e2c:	00013403          	ld	s0,0(sp)
    80002e30:	01010113          	addi	sp,sp,16
    80002e34:	00008067          	ret

0000000080002e38 <_ZN9SemaphoreD0Ev>:
        virtual ~Semaphore (){
    80002e38:	fe010113          	addi	sp,sp,-32
    80002e3c:	00113c23          	sd	ra,24(sp)
    80002e40:	00813823          	sd	s0,16(sp)
    80002e44:	00913423          	sd	s1,8(sp)
    80002e48:	02010413          	addi	s0,sp,32
    80002e4c:	00050493          	mv	s1,a0
    80002e50:	0000a797          	auipc	a5,0xa
    80002e54:	c9878793          	addi	a5,a5,-872 # 8000cae8 <_ZTV9Semaphore+0x10>
    80002e58:	00f53023          	sd	a5,0(a0)
            sem_close(myHandle);
    80002e5c:	00853503          	ld	a0,8(a0)
    80002e60:	ffffe097          	auipc	ra,0xffffe
    80002e64:	620080e7          	jalr	1568(ra) # 80001480 <_Z9sem_closeP5sem_s>
        }
    80002e68:	00048513          	mv	a0,s1
    80002e6c:	00000097          	auipc	ra,0x0
    80002e70:	098080e7          	jalr	152(ra) # 80002f04 <_ZdlPv>
    80002e74:	01813083          	ld	ra,24(sp)
    80002e78:	01013403          	ld	s0,16(sp)
    80002e7c:	00813483          	ld	s1,8(sp)
    80002e80:	02010113          	addi	sp,sp,32
    80002e84:	00008067          	ret

0000000080002e88 <_ZN6Thread5startEv>:
        int start (){
    80002e88:	ff010113          	addi	sp,sp,-16
    80002e8c:	00113423          	sd	ra,8(sp)
    80002e90:	00813023          	sd	s0,0(sp)
    80002e94:	01010413          	addi	s0,sp,16
            if(body== nullptr) return thread_create(&myHandle,&threadEntry, this);
    80002e98:	01053583          	ld	a1,16(a0)
    80002e9c:	02058263          	beqz	a1,80002ec0 <_ZN6Thread5startEv+0x38>
            else return thread_create(&myHandle,body,arg);
    80002ea0:	01853603          	ld	a2,24(a0)
    80002ea4:	00850513          	addi	a0,a0,8
    80002ea8:	ffffe097          	auipc	ra,0xffffe
    80002eac:	458080e7          	jalr	1112(ra) # 80001300 <_Z13thread_createPP8thread_sPFvPvES2_>
        }
    80002eb0:	00813083          	ld	ra,8(sp)
    80002eb4:	00013403          	ld	s0,0(sp)
    80002eb8:	01010113          	addi	sp,sp,16
    80002ebc:	00008067          	ret
            if(body== nullptr) return thread_create(&myHandle,&threadEntry, this);
    80002ec0:	00050613          	mv	a2,a0
    80002ec4:	00000597          	auipc	a1,0x0
    80002ec8:	e1c58593          	addi	a1,a1,-484 # 80002ce0 <_ZN6Thread11threadEntryEPv>
    80002ecc:	00850513          	addi	a0,a0,8
    80002ed0:	ffffe097          	auipc	ra,0xffffe
    80002ed4:	430080e7          	jalr	1072(ra) # 80001300 <_Z13thread_createPP8thread_sPFvPvES2_>
    80002ed8:	fd9ff06f          	j	80002eb0 <_ZN6Thread5startEv+0x28>

0000000080002edc <_Znwm>:
// Created by os on 6/7/23.
//
#include "../h/syscall_cpp.hpp"


void* operator new(size_t size) {
    80002edc:	ff010113          	addi	sp,sp,-16
    80002ee0:	00113423          	sd	ra,8(sp)
    80002ee4:	00813023          	sd	s0,0(sp)
    80002ee8:	01010413          	addi	s0,sp,16
    void* ptr = mem_alloc(size);
    80002eec:	ffffe097          	auipc	ra,0xffffe
    80002ef0:	394080e7          	jalr	916(ra) # 80001280 <_Z9mem_allocm>
    return ptr;
}
    80002ef4:	00813083          	ld	ra,8(sp)
    80002ef8:	00013403          	ld	s0,0(sp)
    80002efc:	01010113          	addi	sp,sp,16
    80002f00:	00008067          	ret

0000000080002f04 <_ZdlPv>:

void operator delete(void* ptr) {
    80002f04:	ff010113          	addi	sp,sp,-16
    80002f08:	00113423          	sd	ra,8(sp)
    80002f0c:	00813023          	sd	s0,0(sp)
    80002f10:	01010413          	addi	s0,sp,16
    mem_free(ptr);
    80002f14:	ffffe097          	auipc	ra,0xffffe
    80002f18:	3ac080e7          	jalr	940(ra) # 800012c0 <_Z8mem_freePv>
}
    80002f1c:	00813083          	ld	ra,8(sp)
    80002f20:	00013403          	ld	s0,0(sp)
    80002f24:	01010113          	addi	sp,sp,16
    80002f28:	00008067          	ret

0000000080002f2c <_Z16kern_thread_ctorPv>:
    thread_t sleeping_head;
} scheduler;

void kern_thread_yield();

void kern_thread_ctor(void* addr){
    80002f2c:	ff010113          	addi	sp,sp,-16
    80002f30:	00813423          	sd	s0,8(sp)
    80002f34:	01010413          	addi	s0,sp,16
    thread_t t = (thread_t)addr;
    t->status=UNUSED;
    80002f38:	04052823          	sw	zero,80(a0)
    t->stack_space=0;
    80002f3c:	04053023          	sd	zero,64(a0)
    t->arg=0;
    80002f40:	02053023          	sd	zero,32(a0)
    t->joined_tid=-1;
    80002f44:	fff00793          	li	a5,-1
    80002f48:	02f53423          	sd	a5,40(a0)
    t->timeslice=DEFAULT_TIME_SLICE;
    80002f4c:	00200793          	li	a5,2
    80002f50:	02f53823          	sd	a5,48(a0)
    t->body=0;
    80002f54:	00053c23          	sd	zero,24(a0)
    t->stack_space = 0;
    t->sp =0;
    80002f58:	00053423          	sd	zero,8(a0)
    t->ra=0;
    80002f5c:	00053023          	sd	zero,0(a0)
    t->sem_next=0;
    80002f60:	04053c23          	sd	zero,88(a0)
    t->next_thread=0;
    80002f64:	06053023          	sd	zero,96(a0)
    t->mailbox=0;
    80002f68:	04053423          	sd	zero,72(a0)
}
    80002f6c:	00813403          	ld	s0,8(sp)
    80002f70:	01010113          	addi	sp,sp,16
    80002f74:	00008067          	ret

0000000080002f78 <_Z16kern_thread_initv>:
void kern_thread_init()
{
    80002f78:	fe010113          	addi	sp,sp,-32
    80002f7c:	00113c23          	sd	ra,24(sp)
    80002f80:	00813823          	sd	s0,16(sp)
    80002f84:	00913423          	sd	s1,8(sp)
    80002f88:	02010413          	addi	s0,sp,32
    threads_cache=kmem_cache_create("thread cache", sizeof(thread_s),kern_thread_ctor,0);
    80002f8c:	00000693          	li	a3,0
    80002f90:	00000617          	auipc	a2,0x0
    80002f94:	f9c60613          	addi	a2,a2,-100 # 80002f2c <_Z16kern_thread_ctorPv>
    80002f98:	06800593          	li	a1,104
    80002f9c:	00007517          	auipc	a0,0x7
    80002fa0:	20c50513          	addi	a0,a0,524 # 8000a1a8 <CONSOLE_STATUS+0x198>
    80002fa4:	00001097          	auipc	ra,0x1
    80002fa8:	e28080e7          	jalr	-472(ra) # 80003dcc <_Z17kmem_cache_createPKcmPFvPvES3_>
    80002fac:	0000a497          	auipc	s1,0xa
    80002fb0:	68448493          	addi	s1,s1,1668 # 8000d630 <threads_cache>
    80002fb4:	00a4b023          	sd	a0,0(s1)
    id=0;
    80002fb8:	0004a423          	sw	zero,8(s1)
    for (int i=0;i<MAX_THREADS;i++){
        kthreads[i].status=UNUSED;
    }
    */
    //set main thread
    thread_t main_thread = (thread_t) kmem_cache_alloc(threads_cache);
    80002fbc:	00001097          	auipc	ra,0x1
    80002fc0:	4d4080e7          	jalr	1236(ra) # 80004490 <_Z16kmem_cache_allocP12kmem_cache_s>
    main_thread->status=RUNNING;
    80002fc4:	00100793          	li	a5,1
    80002fc8:	04f52823          	sw	a5,80(a0)
    main_thread->id=0;
    80002fcc:	00053823          	sd	zero,16(a0)
    main_thread->timeslice=DEFAULT_TIME_SLICE+2;
    80002fd0:	00400793          	li	a5,4
    80002fd4:	02f53823          	sd	a5,48(a0)
    main_thread->endTime=0;
    80002fd8:	02053c23          	sd	zero,56(a0)
    main_thread->next_thread=0;
    80002fdc:	06053023          	sd	zero,96(a0)
    running=main_thread;
    80002fe0:	00a4b823          	sd	a0,16(s1)
    scheduler.ready_head=0;
    80002fe4:	0004bc23          	sd	zero,24(s1)
    scheduler.ready_tail=0;
    80002fe8:	0204b023          	sd	zero,32(s1)
    scheduler.joined_head=0;
    80002fec:	0204b423          	sd	zero,40(s1)
    scheduler.sleeping_head=0;
    80002ff0:	0204b823          	sd	zero,48(s1)
}
    80002ff4:	01813083          	ld	ra,24(sp)
    80002ff8:	01013403          	ld	s0,16(sp)
    80002ffc:	00813483          	ld	s1,8(sp)
    80003000:	02010113          	addi	sp,sp,32
    80003004:	00008067          	ret

0000000080003008 <_Z18kern_scheduler_putP8thread_s>:

void kern_scheduler_put(thread_t t)
{
    80003008:	ff010113          	addi	sp,sp,-16
    8000300c:	00813423          	sd	s0,8(sp)
    80003010:	01010413          	addi	s0,sp,16
    t->status=READY;
    80003014:	00200793          	li	a5,2
    80003018:	04f52823          	sw	a5,80(a0)
    if(scheduler.ready_tail==0){
    8000301c:	0000a797          	auipc	a5,0xa
    80003020:	6347b783          	ld	a5,1588(a5) # 8000d650 <scheduler+0x8>
    80003024:	02078063          	beqz	a5,80003044 <_Z18kern_scheduler_putP8thread_s+0x3c>
        scheduler.ready_tail=t;
        scheduler.ready_head=t;
    } else{
        scheduler.ready_tail->next_thread=t;
    80003028:	06a7b023          	sd	a0,96(a5)
        scheduler.ready_tail=t;
    8000302c:	0000a797          	auipc	a5,0xa
    80003030:	62a7b223          	sd	a0,1572(a5) # 8000d650 <scheduler+0x8>
    }
    t->next_thread=0;
    80003034:	06053023          	sd	zero,96(a0)
}
    80003038:	00813403          	ld	s0,8(sp)
    8000303c:	01010113          	addi	sp,sp,16
    80003040:	00008067          	ret
        scheduler.ready_tail=t;
    80003044:	0000a797          	auipc	a5,0xa
    80003048:	5ec78793          	addi	a5,a5,1516 # 8000d630 <threads_cache>
    8000304c:	02a7b023          	sd	a0,32(a5)
        scheduler.ready_head=t;
    80003050:	00a7bc23          	sd	a0,24(a5)
    80003054:	fe1ff06f          	j	80003034 <_Z18kern_scheduler_putP8thread_s+0x2c>

0000000080003058 <_Z18kern_scheduler_getv>:

thread_t kern_scheduler_get()
{
    80003058:	ff010113          	addi	sp,sp,-16
    8000305c:	00813423          	sd	s0,8(sp)
    80003060:	01010413          	addi	s0,sp,16
    if(scheduler.ready_head==0) return 0;
    80003064:	0000a517          	auipc	a0,0xa
    80003068:	5e453503          	ld	a0,1508(a0) # 8000d648 <scheduler>
    8000306c:	02050063          	beqz	a0,8000308c <_Z18kern_scheduler_getv+0x34>
    thread_t t = scheduler.ready_head;
    scheduler.ready_head=scheduler.ready_head->next_thread;
    80003070:	06053703          	ld	a4,96(a0)
    80003074:	0000a797          	auipc	a5,0xa
    80003078:	5bc78793          	addi	a5,a5,1468 # 8000d630 <threads_cache>
    8000307c:	00e7bc23          	sd	a4,24(a5)
    if(scheduler.ready_tail==t) scheduler.ready_tail=0;
    80003080:	0207b783          	ld	a5,32(a5)
    80003084:	00f50a63          	beq	a0,a5,80003098 <_Z18kern_scheduler_getv+0x40>
    t->next_thread=0;
    80003088:	06053023          	sd	zero,96(a0)
    return t;
}
    8000308c:	00813403          	ld	s0,8(sp)
    80003090:	01010113          	addi	sp,sp,16
    80003094:	00008067          	ret
    if(scheduler.ready_tail==t) scheduler.ready_tail=0;
    80003098:	0000a797          	auipc	a5,0xa
    8000309c:	5a07bc23          	sd	zero,1464(a5) # 8000d650 <scheduler+0x8>
    800030a0:	fe9ff06f          	j	80003088 <_Z18kern_scheduler_getv+0x30>

00000000800030a4 <_Z10popSppSpiev>:
    w_sepc(v_sepc);
}

//samo izlazi iz kernela i vraca se odakle je pozvana
void popSppSpie()
{
    800030a4:	ff010113          	addi	sp,sp,-16
    800030a8:	00813423          	sd	s0,8(sp)
    800030ac:	01010413          	addi	s0,sp,16
    __asm__ volatile("csrw sepc, ra"); //ovde dodaj izlazak iz privilegovanog moda
    800030b0:	14109073          	csrw	sepc,ra
    __asm__ volatile("csrc sstatus, %[mask]" : : [mask] "r"(1 << 8));
    800030b4:	10000793          	li	a5,256
    800030b8:	1007b073          	csrc	sstatus,a5
    __asm__ volatile("sret");
    800030bc:	10200073          	sret
}
    800030c0:	00813403          	ld	s0,8(sp)
    800030c4:	01010113          	addi	sp,sp,16
    800030c8:	00008067          	ret

00000000800030cc <_Z19kern_thread_wrapperv>:
        contextSwitch(old,running);
    }
}

void kern_thread_wrapper()
{
    800030cc:	ff010113          	addi	sp,sp,-16
    800030d0:	00113423          	sd	ra,8(sp)
    800030d4:	00813023          	sd	s0,0(sp)
    800030d8:	01010413          	addi	s0,sp,16
    popSppSpie();
    800030dc:	00000097          	auipc	ra,0x0
    800030e0:	fc8080e7          	jalr	-56(ra) # 800030a4 <_Z10popSppSpiev>
    running->body(running->arg);
    800030e4:	0000a797          	auipc	a5,0xa
    800030e8:	55c7b783          	ld	a5,1372(a5) # 8000d640 <running>
    800030ec:	0187b703          	ld	a4,24(a5)
    800030f0:	0207b503          	ld	a0,32(a5)
    800030f4:	000700e7          	jalr	a4
    running->joined_tid=-1;
    for(int i=0;i<MAX_THREADS;i++){
        if(kthreads[i].status==JOINED && kthreads[i].joined_tid==running->id) kthreads[i].status=READY;
    }
*/
    thread_exit();
    800030f8:	ffffe097          	auipc	ra,0xffffe
    800030fc:	2bc080e7          	jalr	700(ra) # 800013b4 <_Z11thread_exitv>
}
    80003100:	00813083          	ld	ra,8(sp)
    80003104:	00013403          	ld	s0,0(sp)
    80003108:	01010113          	addi	sp,sp,16
    8000310c:	00008067          	ret

0000000080003110 <_Z17kern_thread_yieldv>:
{
    80003110:	fe010113          	addi	sp,sp,-32
    80003114:	00113c23          	sd	ra,24(sp)
    80003118:	00813823          	sd	s0,16(sp)
    8000311c:	00913423          	sd	s1,8(sp)
    80003120:	01213023          	sd	s2,0(sp)
    80003124:	02010413          	addi	s0,sp,32
    thread_t old = running;
    80003128:	0000a917          	auipc	s2,0xa
    8000312c:	50890913          	addi	s2,s2,1288 # 8000d630 <threads_cache>
    80003130:	01093483          	ld	s1,16(s2)
    running=kern_scheduler_get();
    80003134:	00000097          	auipc	ra,0x0
    80003138:	f24080e7          	jalr	-220(ra) # 80003058 <_Z18kern_scheduler_getv>
    8000313c:	00a93823          	sd	a0,16(s2)
    if(old!=running){
    80003140:	04950663          	beq	a0,s1,8000318c <_Z17kern_thread_yieldv+0x7c>
    80003144:	00050593          	mv	a1,a0
        running->status=RUNNING;
    80003148:	00100793          	li	a5,1
    8000314c:	04f52823          	sw	a5,80(a0)
        if(old->status==RUNNING) old->status=READY;
    80003150:	0504a703          	lw	a4,80(s1)
    80003154:	00100793          	li	a5,1
    80003158:	02f70463          	beq	a4,a5,80003180 <_Z17kern_thread_yieldv+0x70>
        contextSwitch(old,running);
    8000315c:	00048513          	mv	a0,s1
    80003160:	ffffe097          	auipc	ra,0xffffe
    80003164:	10c080e7          	jalr	268(ra) # 8000126c <contextSwitch>
}
    80003168:	01813083          	ld	ra,24(sp)
    8000316c:	01013403          	ld	s0,16(sp)
    80003170:	00813483          	ld	s1,8(sp)
    80003174:	00013903          	ld	s2,0(sp)
    80003178:	02010113          	addi	sp,sp,32
    8000317c:	00008067          	ret
        if(old->status==RUNNING) old->status=READY;
    80003180:	00200793          	li	a5,2
    80003184:	04f4a823          	sw	a5,80(s1)
    80003188:	fd5ff06f          	j	8000315c <_Z17kern_thread_yieldv+0x4c>
        old->status=RUNNING;
    8000318c:	00100793          	li	a5,1
    80003190:	04f4a823          	sw	a5,80(s1)
}
    80003194:	fd5ff06f          	j	80003168 <_Z17kern_thread_yieldv+0x58>

0000000080003198 <_Z20kern_thread_dispatchv>:
{
    80003198:	fd010113          	addi	sp,sp,-48
    8000319c:	02113423          	sd	ra,40(sp)
    800031a0:	02813023          	sd	s0,32(sp)
    800031a4:	03010413          	addi	s0,sp,48
    kern_scheduler_put(running);
    800031a8:	0000a517          	auipc	a0,0xa
    800031ac:	49853503          	ld	a0,1176(a0) # 8000d640 <running>
    800031b0:	00000097          	auipc	ra,0x0
    800031b4:	e58080e7          	jalr	-424(ra) # 80003008 <_Z18kern_scheduler_putP8thread_s>
}

inline uint64 r_sstatus()
{
    uint64 volatile sstatus;
    __asm__ volatile ("csrr %[sstatus], sstatus" : [sstatus] "=r"(sstatus));
    800031b8:	100027f3          	csrr	a5,sstatus
    800031bc:	fcf43c23          	sd	a5,-40(s0)
    return sstatus;
    800031c0:	fd843783          	ld	a5,-40(s0)
    uint64 volatile sstatus = r_sstatus();
    800031c4:	fef43423          	sd	a5,-24(s0)
    __asm__ volatile ("csrr %[sepc], sepc" : [sepc] "=r"(sepc));
    800031c8:	141027f3          	csrr	a5,sepc
    800031cc:	fcf43823          	sd	a5,-48(s0)
    return sepc;
    800031d0:	fd043783          	ld	a5,-48(s0)
    uint64 volatile v_sepc = r_sepc();
    800031d4:	fef43023          	sd	a5,-32(s0)
    kern_thread_yield();
    800031d8:	00000097          	auipc	ra,0x0
    800031dc:	f38080e7          	jalr	-200(ra) # 80003110 <_Z17kern_thread_yieldv>
    w_sstatus(sstatus);
    800031e0:	fe843783          	ld	a5,-24(s0)
}

inline void w_sstatus(uint64 sstatus)
{
    __asm__ volatile ("csrw sstatus, %[sstatus]" : : [sstatus] "r"(sstatus));
    800031e4:	10079073          	csrw	sstatus,a5
    w_sepc(v_sepc);
    800031e8:	fe043783          	ld	a5,-32(s0)
    __asm__ volatile ("csrw sepc, %[sepc]" : : [sepc] "r"(sepc));
    800031ec:	14179073          	csrw	sepc,a5
}
    800031f0:	02813083          	ld	ra,40(sp)
    800031f4:	02013403          	ld	s0,32(sp)
    800031f8:	03010113          	addi	sp,sp,48
    800031fc:	00008067          	ret

0000000080003200 <_Z25kern_thread_resume_joinedm>:
{
    80003200:	fd010113          	addi	sp,sp,-48
    80003204:	02113423          	sd	ra,40(sp)
    80003208:	02813023          	sd	s0,32(sp)
    8000320c:	00913c23          	sd	s1,24(sp)
    80003210:	01213823          	sd	s2,16(sp)
    80003214:	01313423          	sd	s3,8(sp)
    80003218:	03010413          	addi	s0,sp,48
    8000321c:	00050993          	mv	s3,a0
    thread_t curr = scheduler.joined_head;
    80003220:	0000a517          	auipc	a0,0xa
    80003224:	43853503          	ld	a0,1080(a0) # 8000d658 <scheduler+0x10>
    thread_t prev = 0;
    80003228:	00000913          	li	s2,0
    8000322c:	00c0006f          	j	80003238 <_Z25kern_thread_resume_joinedm+0x38>
            prev=curr;
    80003230:	00050913          	mv	s2,a0
    80003234:	00048513          	mv	a0,s1
    while (curr!=0){
    80003238:	02050863          	beqz	a0,80003268 <_Z25kern_thread_resume_joinedm+0x68>
        next=curr->next_thread;
    8000323c:	06053483          	ld	s1,96(a0)
        if(curr->joined_tid<=joined_tid){
    80003240:	02853783          	ld	a5,40(a0)
    80003244:	fef9e6e3          	bltu	s3,a5,80003230 <_Z25kern_thread_resume_joinedm+0x30>
            if(prev!=0){
    80003248:	00090a63          	beqz	s2,8000325c <_Z25kern_thread_resume_joinedm+0x5c>
                prev->next_thread=curr->next_thread;
    8000324c:	06993023          	sd	s1,96(s2)
            kern_scheduler_put(curr);
    80003250:	00000097          	auipc	ra,0x0
    80003254:	db8080e7          	jalr	-584(ra) # 80003008 <_Z18kern_scheduler_putP8thread_s>
    80003258:	fddff06f          	j	80003234 <_Z25kern_thread_resume_joinedm+0x34>
                scheduler.joined_head=curr->next_thread;
    8000325c:	0000a797          	auipc	a5,0xa
    80003260:	3e97be23          	sd	s1,1020(a5) # 8000d658 <scheduler+0x10>
    80003264:	fedff06f          	j	80003250 <_Z25kern_thread_resume_joinedm+0x50>
}
    80003268:	02813083          	ld	ra,40(sp)
    8000326c:	02013403          	ld	s0,32(sp)
    80003270:	01813483          	ld	s1,24(sp)
    80003274:	01013903          	ld	s2,16(sp)
    80003278:	00813983          	ld	s3,8(sp)
    8000327c:	03010113          	addi	sp,sp,48
    80003280:	00008067          	ret

0000000080003284 <_Z23kern_thread_end_runningv>:
{
    80003284:	fe010113          	addi	sp,sp,-32
    80003288:	00113c23          	sd	ra,24(sp)
    8000328c:	00813823          	sd	s0,16(sp)
    80003290:	00913423          	sd	s1,8(sp)
    80003294:	01213023          	sd	s2,0(sp)
    80003298:	02010413          	addi	s0,sp,32
    thread_t old = running;
    8000329c:	0000a917          	auipc	s2,0xa
    800032a0:	39490913          	addi	s2,s2,916 # 8000d630 <threads_cache>
    800032a4:	01093483          	ld	s1,16(s2)
    old->status=UNUSED;
    800032a8:	0404a823          	sw	zero,80(s1)
    kern_thread_resume_joined(old->id);
    800032ac:	0104b503          	ld	a0,16(s1)
    800032b0:	00000097          	auipc	ra,0x0
    800032b4:	f50080e7          	jalr	-176(ra) # 80003200 <_Z25kern_thread_resume_joinedm>
    running=kern_scheduler_get();
    800032b8:	00000097          	auipc	ra,0x0
    800032bc:	da0080e7          	jalr	-608(ra) # 80003058 <_Z18kern_scheduler_getv>
    800032c0:	00a93823          	sd	a0,16(s2)
    if(old->stack_space!=0) kern_mem_free((void*)old->stack_space);
    800032c4:	0404b503          	ld	a0,64(s1)
    800032c8:	02051a63          	bnez	a0,800032fc <_Z23kern_thread_end_runningv+0x78>
    if(old!=running){
    800032cc:	0000a597          	auipc	a1,0xa
    800032d0:	3745b583          	ld	a1,884(a1) # 8000d640 <running>
    800032d4:	00958863          	beq	a1,s1,800032e4 <_Z23kern_thread_end_runningv+0x60>
        contextSwitch(old,running);
    800032d8:	00048513          	mv	a0,s1
    800032dc:	ffffe097          	auipc	ra,0xffffe
    800032e0:	f90080e7          	jalr	-112(ra) # 8000126c <contextSwitch>
}
    800032e4:	01813083          	ld	ra,24(sp)
    800032e8:	01013403          	ld	s0,16(sp)
    800032ec:	00813483          	ld	s1,8(sp)
    800032f0:	00013903          	ld	s2,0(sp)
    800032f4:	02010113          	addi	sp,sp,32
    800032f8:	00008067          	ret
    if(old->stack_space!=0) kern_mem_free((void*)old->stack_space);
    800032fc:	fffff097          	auipc	ra,0xfffff
    80003300:	1d4080e7          	jalr	468(ra) # 800024d0 <_Z13kern_mem_freePv>
    80003304:	fc9ff06f          	j	800032cc <_Z23kern_thread_end_runningv+0x48>

0000000080003308 <_Z18kern_thread_createPP8thread_sPFvPvES2_S2_>:

int kern_thread_create(thread_t* handle, void(*start_routine)(void*), void* arg, void* stack_space)
{
    80003308:	fd010113          	addi	sp,sp,-48
    8000330c:	02113423          	sd	ra,40(sp)
    80003310:	02813023          	sd	s0,32(sp)
    80003314:	00913c23          	sd	s1,24(sp)
    80003318:	01213823          	sd	s2,16(sp)
    8000331c:	01313423          	sd	s3,8(sp)
    80003320:	01413023          	sd	s4,0(sp)
    80003324:	03010413          	addi	s0,sp,48
    80003328:	00050913          	mv	s2,a0
    8000332c:	00058a13          	mv	s4,a1
    80003330:	00060993          	mv	s3,a2
    80003334:	00068493          	mv	s1,a3
    *handle=0;
    80003338:	00053023          	sd	zero,0(a0)
    thread_t t= (thread_t)kmem_cache_alloc(threads_cache);
    8000333c:	0000a517          	auipc	a0,0xa
    80003340:	2f453503          	ld	a0,756(a0) # 8000d630 <threads_cache>
    80003344:	00001097          	auipc	ra,0x1
    80003348:	14c080e7          	jalr	332(ra) # 80004490 <_Z16kmem_cache_allocP12kmem_cache_s>
    if(t==0) return -1;
    8000334c:	08050c63          	beqz	a0,800033e4 <_Z18kern_thread_createPP8thread_sPFvPvES2_S2_+0xdc>
    *handle=t;
    80003350:	00a93023          	sd	a0,0(s2)

    t->id=++id;
    80003354:	0000a717          	auipc	a4,0xa
    80003358:	2dc70713          	addi	a4,a4,732 # 8000d630 <threads_cache>
    8000335c:	00872783          	lw	a5,8(a4)
    80003360:	0017879b          	addiw	a5,a5,1
    80003364:	0007869b          	sext.w	a3,a5
    80003368:	00f72423          	sw	a5,8(a4)
    8000336c:	00d53823          	sd	a3,16(a0)
    t->status=READY;
    80003370:	00200793          	li	a5,2
    80003374:	04f52823          	sw	a5,80(a0)
    t->arg=arg;
    80003378:	03353023          	sd	s3,32(a0)
    t->joined_tid=-1;
    8000337c:	fff00793          	li	a5,-1
    80003380:	02f53423          	sd	a5,40(a0)
    t->timeslice=DEFAULT_TIME_SLICE;
    80003384:	00200793          	li	a5,2
    80003388:	02f53823          	sd	a5,48(a0)
    t->body=start_routine;
    8000338c:	01453c23          	sd	s4,24(a0)
    t->stack_space = ((uint64)stack_space);
    80003390:	04953023          	sd	s1,64(a0)
    t->sp = t->stack_space+(DEFAULT_STACK_SIZE);
    80003394:	000016b7          	lui	a3,0x1
    80003398:	00d484b3          	add	s1,s1,a3
    8000339c:	00953423          	sd	s1,8(a0)
    t->ra=(uint64) &kern_thread_wrapper;
    800033a0:	00000797          	auipc	a5,0x0
    800033a4:	d2c78793          	addi	a5,a5,-724 # 800030cc <_Z19kern_thread_wrapperv>
    800033a8:	00f53023          	sd	a5,0(a0)
    t->sem_next=0;
    800033ac:	04053c23          	sd	zero,88(a0)
    t->next_thread=0;
    800033b0:	06053023          	sd	zero,96(a0)
    t->mailbox=0;
    800033b4:	04053423          	sd	zero,72(a0)
    kern_scheduler_put(t);
    800033b8:	00000097          	auipc	ra,0x0
    800033bc:	c50080e7          	jalr	-944(ra) # 80003008 <_Z18kern_scheduler_putP8thread_s>

    return 0;
    800033c0:	00000513          	li	a0,0
}
    800033c4:	02813083          	ld	ra,40(sp)
    800033c8:	02013403          	ld	s0,32(sp)
    800033cc:	01813483          	ld	s1,24(sp)
    800033d0:	01013903          	ld	s2,16(sp)
    800033d4:	00813983          	ld	s3,8(sp)
    800033d8:	00013a03          	ld	s4,0(sp)
    800033dc:	03010113          	addi	sp,sp,48
    800033e0:	00008067          	ret
    if(t==0) return -1;
    800033e4:	fff00513          	li	a0,-1
    800033e8:	fddff06f          	j	800033c4 <_Z18kern_thread_createPP8thread_sPFvPvES2_S2_+0xbc>

00000000800033ec <_Z16kern_thread_joinP8thread_s>:

void kern_thread_join(thread_t handle)
{
    if(handle->status==UNUSED) return;
    800033ec:	05052783          	lw	a5,80(a0)
    800033f0:	00079463          	bnez	a5,800033f8 <_Z16kern_thread_joinP8thread_s+0xc>
    800033f4:	00008067          	ret
{
    800033f8:	fd010113          	addi	sp,sp,-48
    800033fc:	02113423          	sd	ra,40(sp)
    80003400:	02813023          	sd	s0,32(sp)
    80003404:	03010413          	addi	s0,sp,48
    running->joined_tid=handle->id;
    80003408:	0000a717          	auipc	a4,0xa
    8000340c:	22870713          	addi	a4,a4,552 # 8000d630 <threads_cache>
    80003410:	01073783          	ld	a5,16(a4)
    80003414:	01053683          	ld	a3,16(a0)
    80003418:	02d7b423          	sd	a3,40(a5)
    running->status=JOINED;
    8000341c:	00400693          	li	a3,4
    80003420:	04d7a823          	sw	a3,80(a5)
    running->next_thread=scheduler.joined_head;
    80003424:	02873683          	ld	a3,40(a4)
    80003428:	06d7b023          	sd	a3,96(a5)
    scheduler.joined_head=running;
    8000342c:	02f73423          	sd	a5,40(a4)
    __asm__ volatile ("csrr %[sstatus], sstatus" : [sstatus] "=r"(sstatus));
    80003430:	100027f3          	csrr	a5,sstatus
    80003434:	fcf43c23          	sd	a5,-40(s0)
    return sstatus;
    80003438:	fd843783          	ld	a5,-40(s0)
    uint64 volatile sstatus = r_sstatus();
    8000343c:	fef43423          	sd	a5,-24(s0)
    __asm__ volatile ("csrr %[sepc], sepc" : [sepc] "=r"(sepc));
    80003440:	141027f3          	csrr	a5,sepc
    80003444:	fcf43823          	sd	a5,-48(s0)
    return sepc;
    80003448:	fd043783          	ld	a5,-48(s0)
    uint64 volatile v_sepc = r_sepc();
    8000344c:	fef43023          	sd	a5,-32(s0)
    kern_thread_yield();
    80003450:	00000097          	auipc	ra,0x0
    80003454:	cc0080e7          	jalr	-832(ra) # 80003110 <_Z17kern_thread_yieldv>
    w_sstatus(sstatus);
    80003458:	fe843783          	ld	a5,-24(s0)
    __asm__ volatile ("csrw sstatus, %[sstatus]" : : [sstatus] "r"(sstatus));
    8000345c:	10079073          	csrw	sstatus,a5
    w_sepc(v_sepc);
    80003460:	fe043783          	ld	a5,-32(s0)
    __asm__ volatile ("csrw sepc, %[sepc]" : : [sepc] "r"(sepc));
    80003464:	14179073          	csrw	sepc,a5
}
    80003468:	02813083          	ld	ra,40(sp)
    8000346c:	02013403          	ld	s0,32(sp)
    80003470:	03010113          	addi	sp,sp,48
    80003474:	00008067          	ret

0000000080003478 <_Z18kern_thread_wakeupm>:

void kern_thread_wakeup(uint64 system_time)
{
    80003478:	fd010113          	addi	sp,sp,-48
    8000347c:	02113423          	sd	ra,40(sp)
    80003480:	02813023          	sd	s0,32(sp)
    80003484:	00913c23          	sd	s1,24(sp)
    80003488:	01213823          	sd	s2,16(sp)
    8000348c:	01313423          	sd	s3,8(sp)
    80003490:	03010413          	addi	s0,sp,48
    80003494:	00050993          	mv	s3,a0
    thread_t curr = scheduler.sleeping_head;
    80003498:	0000a517          	auipc	a0,0xa
    8000349c:	1c853503          	ld	a0,456(a0) # 8000d660 <scheduler+0x18>
    thread_t prev = 0;
    800034a0:	00000913          	li	s2,0
    800034a4:	00c0006f          	j	800034b0 <_Z18kern_thread_wakeupm+0x38>
            } else{
                scheduler.sleeping_head=curr->next_thread;
            }
            kern_scheduler_put(curr);
        } else{
            prev=curr;
    800034a8:	00050913          	mv	s2,a0
    800034ac:	00048513          	mv	a0,s1
    while (curr!=0){
    800034b0:	02050863          	beqz	a0,800034e0 <_Z18kern_thread_wakeupm+0x68>
        next=curr->next_thread;
    800034b4:	06053483          	ld	s1,96(a0)
        if(curr->endTime<=system_time){
    800034b8:	03853783          	ld	a5,56(a0)
    800034bc:	fef9e6e3          	bltu	s3,a5,800034a8 <_Z18kern_thread_wakeupm+0x30>
            if(prev!=0){
    800034c0:	00090a63          	beqz	s2,800034d4 <_Z18kern_thread_wakeupm+0x5c>
                prev->next_thread=curr->next_thread;
    800034c4:	06993023          	sd	s1,96(s2)
            kern_scheduler_put(curr);
    800034c8:	00000097          	auipc	ra,0x0
    800034cc:	b40080e7          	jalr	-1216(ra) # 80003008 <_Z18kern_scheduler_putP8thread_s>
    800034d0:	fddff06f          	j	800034ac <_Z18kern_thread_wakeupm+0x34>
                scheduler.sleeping_head=curr->next_thread;
    800034d4:	0000a797          	auipc	a5,0xa
    800034d8:	1897b623          	sd	s1,396(a5) # 8000d660 <scheduler+0x18>
    800034dc:	fedff06f          	j	800034c8 <_Z18kern_thread_wakeupm+0x50>
        }
        curr=next;
    }

}
    800034e0:	02813083          	ld	ra,40(sp)
    800034e4:	02013403          	ld	s0,32(sp)
    800034e8:	01813483          	ld	s1,24(sp)
    800034ec:	01013903          	ld	s2,16(sp)
    800034f0:	00813983          	ld	s3,8(sp)
    800034f4:	03010113          	addi	sp,sp,48
    800034f8:	00008067          	ret

00000000800034fc <_Z17kern_thread_sleepm>:

void kern_thread_sleep(uint64 wakeTime)
{
    800034fc:	fd010113          	addi	sp,sp,-48
    80003500:	02113423          	sd	ra,40(sp)
    80003504:	02813023          	sd	s0,32(sp)
    80003508:	03010413          	addi	s0,sp,48
    running->status=SLEEPING;
    8000350c:	0000a717          	auipc	a4,0xa
    80003510:	12470713          	addi	a4,a4,292 # 8000d630 <threads_cache>
    80003514:	01073783          	ld	a5,16(a4)
    80003518:	00500693          	li	a3,5
    8000351c:	04d7a823          	sw	a3,80(a5)
    running->endTime=wakeTime;
    80003520:	02a7bc23          	sd	a0,56(a5)
    running->next_thread=scheduler.sleeping_head;
    80003524:	03073683          	ld	a3,48(a4)
    80003528:	06d7b023          	sd	a3,96(a5)
    scheduler.sleeping_head=running;
    8000352c:	02f73823          	sd	a5,48(a4)
    __asm__ volatile ("csrr %[sstatus], sstatus" : [sstatus] "=r"(sstatus));
    80003530:	100027f3          	csrr	a5,sstatus
    80003534:	fcf43c23          	sd	a5,-40(s0)
    return sstatus;
    80003538:	fd843783          	ld	a5,-40(s0)
    uint64 volatile sstatus = r_sstatus();
    8000353c:	fef43423          	sd	a5,-24(s0)
    __asm__ volatile ("csrr %[sepc], sepc" : [sepc] "=r"(sepc));
    80003540:	141027f3          	csrr	a5,sepc
    80003544:	fcf43823          	sd	a5,-48(s0)
    return sepc;
    80003548:	fd043783          	ld	a5,-48(s0)
    uint64 volatile v_sepc = r_sepc();
    8000354c:	fef43023          	sd	a5,-32(s0)
    kern_thread_yield();
    80003550:	00000097          	auipc	ra,0x0
    80003554:	bc0080e7          	jalr	-1088(ra) # 80003110 <_Z17kern_thread_yieldv>
    w_sstatus(sstatus);
    80003558:	fe843783          	ld	a5,-24(s0)
    __asm__ volatile ("csrw sstatus, %[sstatus]" : : [sstatus] "r"(sstatus));
    8000355c:	10079073          	csrw	sstatus,a5
    w_sepc(v_sepc);
    80003560:	fe043783          	ld	a5,-32(s0)
    __asm__ volatile ("csrw sepc, %[sepc]" : : [sepc] "r"(sepc));
    80003564:	14179073          	csrw	sepc,a5
}
    80003568:	02813083          	ld	ra,40(sp)
    8000356c:	02013403          	ld	s0,32(sp)
    80003570:	03010113          	addi	sp,sp,48
    80003574:	00008067          	ret

0000000080003578 <_Z13kern_sem_initv>:
#define MAX_SEMAPHORES 256

struct sem_s semaphores[MAX_SEMAPHORES];

void kern_sem_init()
{
    80003578:	ff010113          	addi	sp,sp,-16
    8000357c:	00813423          	sd	s0,8(sp)
    80003580:	01010413          	addi	s0,sp,16
    for(int i=0;i<MAX_SEMAPHORES;i++){
    80003584:	00000713          	li	a4,0
    80003588:	0ff00793          	li	a5,255
    8000358c:	02e7c663          	blt	a5,a4,800035b8 <_Z13kern_sem_initv+0x40>
        semaphores[i].waiting_thread=0;
    80003590:	00471693          	slli	a3,a4,0x4
    80003594:	0000a797          	auipc	a5,0xa
    80003598:	0d478793          	addi	a5,a5,212 # 8000d668 <semaphores>
    8000359c:	00d787b3          	add	a5,a5,a3
    800035a0:	0007b423          	sd	zero,8(a5)
        semaphores[i].val=0;
    800035a4:	0007a023          	sw	zero,0(a5)
        semaphores[i].status=SEM_UNUSED;
    800035a8:	00100693          	li	a3,1
    800035ac:	00d7a223          	sw	a3,4(a5)
    for(int i=0;i<MAX_SEMAPHORES;i++){
    800035b0:	0017071b          	addiw	a4,a4,1
    800035b4:	fd5ff06f          	j	80003588 <_Z13kern_sem_initv+0x10>
    }
}
    800035b8:	00813403          	ld	s0,8(sp)
    800035bc:	01010113          	addi	sp,sp,16
    800035c0:	00008067          	ret

00000000800035c4 <_Z13kern_sem_openPP5sem_sj>:

int kern_sem_open (sem_t* handle, unsigned init)
{
    800035c4:	ff010113          	addi	sp,sp,-16
    800035c8:	00813423          	sd	s0,8(sp)
    800035cc:	01010413          	addi	s0,sp,16
    int res=-1;
    for(int i=0;i<MAX_SEMAPHORES;i++){
    800035d0:	00000793          	li	a5,0
    800035d4:	0080006f          	j	800035dc <_Z13kern_sem_openPP5sem_sj+0x18>
    800035d8:	0017879b          	addiw	a5,a5,1
    800035dc:	0ff00713          	li	a4,255
    800035e0:	04f74663          	blt	a4,a5,8000362c <_Z13kern_sem_openPP5sem_sj+0x68>
        if(semaphores[i].status==SEM_UNUSED){
    800035e4:	00479693          	slli	a3,a5,0x4
    800035e8:	0000a717          	auipc	a4,0xa
    800035ec:	08070713          	addi	a4,a4,128 # 8000d668 <semaphores>
    800035f0:	00d70733          	add	a4,a4,a3
    800035f4:	00472683          	lw	a3,4(a4)
    800035f8:	00100713          	li	a4,1
    800035fc:	fce69ee3          	bne	a3,a4,800035d8 <_Z13kern_sem_openPP5sem_sj+0x14>
            semaphores[i].status=SEM_USED;
    80003600:	00479793          	slli	a5,a5,0x4
    80003604:	0000a717          	auipc	a4,0xa
    80003608:	06470713          	addi	a4,a4,100 # 8000d668 <semaphores>
    8000360c:	00f707b3          	add	a5,a4,a5
    80003610:	0007a223          	sw	zero,4(a5)
            semaphores[i].val=init;
    80003614:	00b7a023          	sw	a1,0(a5)
            *handle=&semaphores[i];
    80003618:	00f53023          	sd	a5,0(a0)
            res++;
    8000361c:	00000513          	li	a0,0
            break;
        }
    }
    return res;
}
    80003620:	00813403          	ld	s0,8(sp)
    80003624:	01010113          	addi	sp,sp,16
    80003628:	00008067          	ret
    int res=-1;
    8000362c:	fff00513          	li	a0,-1
    80003630:	ff1ff06f          	j	80003620 <_Z13kern_sem_openPP5sem_sj+0x5c>

0000000080003634 <_Z14kern_sem_closeP5sem_s>:

int kern_sem_close (sem_t handle)
{
    80003634:	fe010113          	addi	sp,sp,-32
    80003638:	00113c23          	sd	ra,24(sp)
    8000363c:	00813823          	sd	s0,16(sp)
    80003640:	00913423          	sd	s1,8(sp)
    80003644:	01213023          	sd	s2,0(sp)
    80003648:	02010413          	addi	s0,sp,32
    8000364c:	00050913          	mv	s2,a0
    handle->status=SEM_UNUSED;
    80003650:	00100793          	li	a5,1
    80003654:	00f52223          	sw	a5,4(a0)
    handle->val=0;
    80003658:	00052023          	sw	zero,0(a0)
    if(handle->waiting_thread!=0){
    8000365c:	00853503          	ld	a0,8(a0)
    80003660:	02051663          	bnez	a0,8000368c <_Z14kern_sem_closeP5sem_s+0x58>
    80003664:	0300006f          	j	80003694 <_Z14kern_sem_closeP5sem_s+0x60>
        thread_t curr = handle->waiting_thread;
        while(curr){
            curr->mailbox=-2;
    80003668:	ffe00793          	li	a5,-2
    8000366c:	04f53423          	sd	a5,72(a0)
            curr->status=READY;
    80003670:	00200793          	li	a5,2
    80003674:	04f52823          	sw	a5,80(a0)
            thread_t prev=curr;
            curr=curr->sem_next;
    80003678:	05853483          	ld	s1,88(a0)
            prev->sem_next=0;
    8000367c:	04053c23          	sd	zero,88(a0)
            kern_scheduler_put(prev);
    80003680:	00000097          	auipc	ra,0x0
    80003684:	988080e7          	jalr	-1656(ra) # 80003008 <_Z18kern_scheduler_putP8thread_s>
            curr=curr->sem_next;
    80003688:	00048513          	mv	a0,s1
        while(curr){
    8000368c:	fc051ee3          	bnez	a0,80003668 <_Z14kern_sem_closeP5sem_s+0x34>
        }
        handle->waiting_thread=0;
    80003690:	00093423          	sd	zero,8(s2)
    }
    return 0;
}
    80003694:	00000513          	li	a0,0
    80003698:	01813083          	ld	ra,24(sp)
    8000369c:	01013403          	ld	s0,16(sp)
    800036a0:	00813483          	ld	s1,8(sp)
    800036a4:	00013903          	ld	s2,0(sp)
    800036a8:	02010113          	addi	sp,sp,32
    800036ac:	00008067          	ret

00000000800036b0 <_Z15kern_sem_signalP5sem_s>:

void kern_sem_signal(sem_t id)
{
    if(id->val>0 || id->waiting_thread==0) id->val++;
    800036b0:	00052783          	lw	a5,0(a0)
    800036b4:	00f05863          	blez	a5,800036c4 <_Z15kern_sem_signalP5sem_s+0x14>
    800036b8:	0017879b          	addiw	a5,a5,1
    800036bc:	00f52023          	sw	a5,0(a0)
    800036c0:	00008067          	ret
    800036c4:	00853703          	ld	a4,8(a0)
    800036c8:	fe0708e3          	beqz	a4,800036b8 <_Z15kern_sem_signalP5sem_s+0x8>
{
    800036cc:	ff010113          	addi	sp,sp,-16
    800036d0:	00113423          	sd	ra,8(sp)
    800036d4:	00813023          	sd	s0,0(sp)
    800036d8:	01010413          	addi	s0,sp,16
    else {
        thread_t woken = id->waiting_thread;
        id->waiting_thread=woken->sem_next;
    800036dc:	05873783          	ld	a5,88(a4)
    800036e0:	00f53423          	sd	a5,8(a0)
        woken->mailbox=0;
    800036e4:	04073423          	sd	zero,72(a4)
        woken->status=READY;
    800036e8:	00200793          	li	a5,2
    800036ec:	04f72823          	sw	a5,80(a4)
        kern_scheduler_put(woken);
    800036f0:	00070513          	mv	a0,a4
    800036f4:	00000097          	auipc	ra,0x0
    800036f8:	914080e7          	jalr	-1772(ra) # 80003008 <_Z18kern_scheduler_putP8thread_s>
    }
}
    800036fc:	00813083          	ld	ra,8(sp)
    80003700:	00013403          	ld	s0,0(sp)
    80003704:	01010113          	addi	sp,sp,16
    80003708:	00008067          	ret

000000008000370c <_Z13kern_sem_waitP5sem_s>:

int kern_sem_wait(sem_t id)
{
    if(id->val<=0){
    8000370c:	00052783          	lw	a5,0(a0)
    80003710:	00f05a63          	blez	a5,80003724 <_Z13kern_sem_waitP5sem_s+0x18>
        w_sstatus(sstatus);
        w_sepc(v_sepc);
        return running->mailbox;
    }
    else {
        id->val--;
    80003714:	fff7879b          	addiw	a5,a5,-1
    80003718:	00f52023          	sw	a5,0(a0)
        return 1;
    8000371c:	00100513          	li	a0,1
    }
}
    80003720:	00008067          	ret
{
    80003724:	fd010113          	addi	sp,sp,-48
    80003728:	02113423          	sd	ra,40(sp)
    8000372c:	02813023          	sd	s0,32(sp)
    80003730:	03010413          	addi	s0,sp,48
        running->status=SUSPENDED;
    80003734:	00009797          	auipc	a5,0x9
    80003738:	5ac7b783          	ld	a5,1452(a5) # 8000cce0 <_GLOBAL_OFFSET_TABLE_+0x20>
    8000373c:	0007b683          	ld	a3,0(a5)
    80003740:	00300793          	li	a5,3
    80003744:	04f6a823          	sw	a5,80(a3) # 1050 <_entry-0x7fffefb0>
        if(id->waiting_thread==0) id->waiting_thread=running;
    80003748:	00853783          	ld	a5,8(a0)
    8000374c:	06078863          	beqz	a5,800037bc <_Z13kern_sem_waitP5sem_s+0xb0>
            while (curr->sem_next!=0) curr=curr->sem_next;
    80003750:	00078713          	mv	a4,a5
    80003754:	0587b783          	ld	a5,88(a5)
    80003758:	fe079ce3          	bnez	a5,80003750 <_Z13kern_sem_waitP5sem_s+0x44>
            curr->sem_next=running;
    8000375c:	04d73c23          	sd	a3,88(a4)
        running->sem_next=0;
    80003760:	0406bc23          	sd	zero,88(a3)
    __asm__ volatile ("csrr %[sstatus], sstatus" : [sstatus] "=r"(sstatus));
    80003764:	100027f3          	csrr	a5,sstatus
    80003768:	fef43423          	sd	a5,-24(s0)
    return sstatus;
    8000376c:	fe843783          	ld	a5,-24(s0)
        uint64 volatile sstatus = r_sstatus();
    80003770:	fcf43823          	sd	a5,-48(s0)
    __asm__ volatile ("csrr %[sepc], sepc" : [sepc] "=r"(sepc));
    80003774:	141027f3          	csrr	a5,sepc
    80003778:	fef43023          	sd	a5,-32(s0)
    return sepc;
    8000377c:	fe043783          	ld	a5,-32(s0)
        uint64 volatile v_sepc = r_sepc();
    80003780:	fcf43c23          	sd	a5,-40(s0)
        kern_thread_yield();
    80003784:	00000097          	auipc	ra,0x0
    80003788:	98c080e7          	jalr	-1652(ra) # 80003110 <_Z17kern_thread_yieldv>
        w_sstatus(sstatus);
    8000378c:	fd043783          	ld	a5,-48(s0)
    __asm__ volatile ("csrw sstatus, %[sstatus]" : : [sstatus] "r"(sstatus));
    80003790:	10079073          	csrw	sstatus,a5
        w_sepc(v_sepc);
    80003794:	fd843783          	ld	a5,-40(s0)
    __asm__ volatile ("csrw sepc, %[sepc]" : : [sepc] "r"(sepc));
    80003798:	14179073          	csrw	sepc,a5
        return running->mailbox;
    8000379c:	00009797          	auipc	a5,0x9
    800037a0:	5447b783          	ld	a5,1348(a5) # 8000cce0 <_GLOBAL_OFFSET_TABLE_+0x20>
    800037a4:	0007b783          	ld	a5,0(a5)
    800037a8:	0487a503          	lw	a0,72(a5)
}
    800037ac:	02813083          	ld	ra,40(sp)
    800037b0:	02013403          	ld	s0,32(sp)
    800037b4:	03010113          	addi	sp,sp,48
    800037b8:	00008067          	ret
        if(id->waiting_thread==0) id->waiting_thread=running;
    800037bc:	00d53423          	sd	a3,8(a0)
    800037c0:	fa1ff06f          	j	80003760 <_Z13kern_sem_waitP5sem_s+0x54>

00000000800037c4 <_Z19kern_interrupt_initv>:
#ifdef __cplusplus
}
#endif

void kern_interrupt_init()
{
    800037c4:	ff010113          	addi	sp,sp,-16
    800037c8:	00813423          	sd	s0,8(sp)
    800037cc:	01010413          	addi	s0,sp,16
    SYSTEM_TIME=0;
    800037d0:	0000b797          	auipc	a5,0xb
    800037d4:	e807bc23          	sd	zero,-360(a5) # 8000e668 <SYSTEM_TIME>
    w_stvec((uint64) &supervisorTrap);
    800037d8:	00009797          	auipc	a5,0x9
    800037dc:	5107b783          	ld	a5,1296(a5) # 8000cce8 <_GLOBAL_OFFSET_TABLE_+0x28>
    __asm__ volatile ("csrw stvec, %[stvec]" : : [stvec] "r"(stvec));
    800037e0:	10579073          	csrw	stvec,a5
    __asm__ volatile ("csrs sstatus, %[mask]" : : [mask] "r"(mask));
    800037e4:	00200793          	li	a5,2
    800037e8:	1007a073          	csrs	sstatus,a5
    ms_sstatus(SSTATUS_SIE);
}
    800037ec:	00813403          	ld	s0,8(sp)
    800037f0:	01010113          	addi	sp,sp,16
    800037f4:	00008067          	ret

00000000800037f8 <_Z12kern_syscall13SyscallNumberz>:


void kern_syscall(enum SyscallNumber num, ...)
{
    800037f8:	fb010113          	addi	sp,sp,-80
    800037fc:	00813423          	sd	s0,8(sp)
    80003800:	01010413          	addi	s0,sp,16
    80003804:	00b43423          	sd	a1,8(s0)
    80003808:	00c43823          	sd	a2,16(s0)
    8000380c:	00d43c23          	sd	a3,24(s0)
    80003810:	02e43023          	sd	a4,32(s0)
    80003814:	02f43423          	sd	a5,40(s0)
    80003818:	03043823          	sd	a6,48(s0)
    8000381c:	03143c23          	sd	a7,56(s0)
    __asm__ volatile ("ecall");
    80003820:	00000073          	ecall
    return;
}
    80003824:	00813403          	ld	s0,8(sp)
    80003828:	05010113          	addi	sp,sp,80
    8000382c:	00008067          	ret

0000000080003830 <handleEcall>:
#ifdef __cplusplus
extern "C" {
#endif


void handleEcall(uint64 a0, uint64 a1, uint64 a2, uint64 a3, uint64 a4) {
    80003830:	fd010113          	addi	sp,sp,-48
    80003834:	02113423          	sd	ra,40(sp)
    80003838:	02813023          	sd	s0,32(sp)
    8000383c:	00913c23          	sd	s1,24(sp)
    80003840:	01213823          	sd	s2,16(sp)
    80003844:	03010413          	addi	s0,sp,48
    80003848:	00060913          	mv	s2,a2
    8000384c:	00068613          	mv	a2,a3
    __asm__ volatile ("csrr %[scause], scause" : [scause] "=r"(scause));
    80003850:	142027f3          	csrr	a5,scause
    80003854:	fcf43823          	sd	a5,-48(s0)
    return scause;
    80003858:	fd043783          	ld	a5,-48(s0)
    __asm__ volatile ("mv %[a2], a2" : [a2] "=r"(a2));
    __asm__ volatile ("mv %[a3], a3" : [a3] "=r"(a3));
    __asm__ volatile ("mv %[a4], a4" : [a4] "=r"(a4));
     */
    uint64 scause = r_scause();
    if (scause == INTR_USER_ECALL || scause == INTR_KERNEL_ECALL) {
    8000385c:	ff878793          	addi	a5,a5,-8
    80003860:	00100693          	li	a3,1
    80003864:	00f6fe63          	bgeu	a3,a5,80003880 <handleEcall+0x50>
            }


        }
    }
}
    80003868:	02813083          	ld	ra,40(sp)
    8000386c:	02013403          	ld	s0,32(sp)
    80003870:	01813483          	ld	s1,24(sp)
    80003874:	01013903          	ld	s2,16(sp)
    80003878:	03010113          	addi	sp,sp,48
    8000387c:	00008067          	ret
    80003880:	00058493          	mv	s1,a1
    __asm__ volatile ("csrr %[sepc], sepc" : [sepc] "=r"(sepc));
    80003884:	141027f3          	csrr	a5,sepc
    80003888:	fcf43c23          	sd	a5,-40(s0)
    return sepc;
    8000388c:	fd843783          	ld	a5,-40(s0)
        uint64 sepc = r_sepc() + 4;
    80003890:	00478793          	addi	a5,a5,4
        uint64 time = SYSTEM_TIME;
    80003894:	0000b597          	auipc	a1,0xb
    80003898:	dd45b583          	ld	a1,-556(a1) # 8000e668 <SYSTEM_TIME>
    __asm__ volatile ("csrw sepc, %[sepc]" : : [sepc] "r"(sepc));
    8000389c:	14179073          	csrw	sepc,a5
        switch (syscall_num) {
    800038a0:	04200793          	li	a5,66
    800038a4:	fca7e2e3          	bltu	a5,a0,80003868 <handleEcall+0x38>
    800038a8:	00251513          	slli	a0,a0,0x2
    800038ac:	00007697          	auipc	a3,0x7
    800038b0:	90c68693          	addi	a3,a3,-1780 # 8000a1b8 <CONSOLE_STATUS+0x1a8>
    800038b4:	00d50533          	add	a0,a0,a3
    800038b8:	00052783          	lw	a5,0(a0)
    800038bc:	00d787b3          	add	a5,a5,a3
    800038c0:	00078067          	jr	a5
                retval = (uint64) kern_mem_alloc(size);
    800038c4:	0004851b          	sext.w	a0,s1
    800038c8:	fffff097          	auipc	ra,0xfffff
    800038cc:	b44080e7          	jalr	-1212(ra) # 8000240c <_Z14kern_mem_alloci>
    __asm__ volatile ("mv a0, %[value]" :: [value] "r"(value));
    800038d0:	00050513          	mv	a0,a0
}
    800038d4:	f95ff06f          	j	80003868 <handleEcall+0x38>
                retval = (uint64) kern_mem_free((void *) addr);
    800038d8:	00048513          	mv	a0,s1
    800038dc:	fffff097          	auipc	ra,0xfffff
    800038e0:	bf4080e7          	jalr	-1036(ra) # 800024d0 <_Z13kern_mem_freePv>
    __asm__ volatile ("mv a0, %[value]" :: [value] "r"(value));
    800038e4:	00050513          	mv	a0,a0
}
    800038e8:	f81ff06f          	j	80003868 <handleEcall+0x38>
                retval = (uint64) kern_thread_create((thread_t *) handle,
    800038ec:	00070693          	mv	a3,a4
    800038f0:	00090593          	mv	a1,s2
    800038f4:	00048513          	mv	a0,s1
    800038f8:	00000097          	auipc	ra,0x0
    800038fc:	a10080e7          	jalr	-1520(ra) # 80003308 <_Z18kern_thread_createPP8thread_sPFvPvES2_S2_>
                (*(thread_t *) handle)->endTime = SYSTEM_TIME + DEFAULT_TIME_SLICE;
    80003900:	0004b703          	ld	a4,0(s1)
    80003904:	0000b797          	auipc	a5,0xb
    80003908:	d647b783          	ld	a5,-668(a5) # 8000e668 <SYSTEM_TIME>
    8000390c:	00278793          	addi	a5,a5,2
    80003910:	02f73c23          	sd	a5,56(a4)
    __asm__ volatile ("mv a0, %[value]" :: [value] "r"(value));
    80003914:	00050513          	mv	a0,a0
}
    80003918:	f51ff06f          	j	80003868 <handleEcall+0x38>
                kern_thread_dispatch();
    8000391c:	00000097          	auipc	ra,0x0
    80003920:	87c080e7          	jalr	-1924(ra) # 80003198 <_Z20kern_thread_dispatchv>
                running->endTime = SYSTEM_TIME + running->timeslice;
    80003924:	00009797          	auipc	a5,0x9
    80003928:	3bc7b783          	ld	a5,956(a5) # 8000cce0 <_GLOBAL_OFFSET_TABLE_+0x20>
    8000392c:	0007b703          	ld	a4,0(a5)
    80003930:	03073783          	ld	a5,48(a4)
    80003934:	0000b697          	auipc	a3,0xb
    80003938:	d346b683          	ld	a3,-716(a3) # 8000e668 <SYSTEM_TIME>
    8000393c:	00d787b3          	add	a5,a5,a3
    80003940:	02f73c23          	sd	a5,56(a4)
                break;
    80003944:	f25ff06f          	j	80003868 <handleEcall+0x38>
                kern_thread_join(handle);
    80003948:	00048513          	mv	a0,s1
    8000394c:	00000097          	auipc	ra,0x0
    80003950:	aa0080e7          	jalr	-1376(ra) # 800033ec <_Z16kern_thread_joinP8thread_s>
                running->endTime = SYSTEM_TIME + running->timeslice;
    80003954:	00009797          	auipc	a5,0x9
    80003958:	38c7b783          	ld	a5,908(a5) # 8000cce0 <_GLOBAL_OFFSET_TABLE_+0x20>
    8000395c:	0007b703          	ld	a4,0(a5)
    80003960:	03073783          	ld	a5,48(a4)
    80003964:	0000b697          	auipc	a3,0xb
    80003968:	d046b683          	ld	a3,-764(a3) # 8000e668 <SYSTEM_TIME>
    8000396c:	00d787b3          	add	a5,a5,a3
    80003970:	02f73c23          	sd	a5,56(a4)
                break;
    80003974:	ef5ff06f          	j	80003868 <handleEcall+0x38>
                kern_thread_end_running();
    80003978:	00000097          	auipc	ra,0x0
    8000397c:	90c080e7          	jalr	-1780(ra) # 80003284 <_Z23kern_thread_end_runningv>
                retval = kern_sem_open(handle, init);
    80003980:	0009059b          	sext.w	a1,s2
    80003984:	00048513          	mv	a0,s1
    80003988:	00000097          	auipc	ra,0x0
    8000398c:	c3c080e7          	jalr	-964(ra) # 800035c4 <_Z13kern_sem_openPP5sem_sj>
    __asm__ volatile ("mv a0, %[value]" :: [value] "r"(value));
    80003990:	00050513          	mv	a0,a0
}
    80003994:	ed5ff06f          	j	80003868 <handleEcall+0x38>
                retval = kern_sem_close(handle);
    80003998:	00048513          	mv	a0,s1
    8000399c:	00000097          	auipc	ra,0x0
    800039a0:	c98080e7          	jalr	-872(ra) # 80003634 <_Z14kern_sem_closeP5sem_s>
    __asm__ volatile ("mv a0, %[value]" :: [value] "r"(value));
    800039a4:	00050513          	mv	a0,a0
}
    800039a8:	ec1ff06f          	j	80003868 <handleEcall+0x38>
                kern_sem_signal(handle);
    800039ac:	00048513          	mv	a0,s1
    800039b0:	00000097          	auipc	ra,0x0
    800039b4:	d00080e7          	jalr	-768(ra) # 800036b0 <_Z15kern_sem_signalP5sem_s>
    __asm__ volatile ("mv a0, %[value]" :: [value] "r"(value));
    800039b8:	00000793          	li	a5,0
    800039bc:	00078513          	mv	a0,a5
}
    800039c0:	ea9ff06f          	j	80003868 <handleEcall+0x38>
                retval = kern_sem_wait(handle);
    800039c4:	00048513          	mv	a0,s1
    800039c8:	00000097          	auipc	ra,0x0
    800039cc:	d44080e7          	jalr	-700(ra) # 8000370c <_Z13kern_sem_waitP5sem_s>
                if (retval == 1) { //nije promenjen kontekst
    800039d0:	00100793          	li	a5,1
    800039d4:	02f50663          	beq	a0,a5,80003a00 <handleEcall+0x1d0>
                    running->endTime = SYSTEM_TIME + running->timeslice;
    800039d8:	00009797          	auipc	a5,0x9
    800039dc:	3087b783          	ld	a5,776(a5) # 8000cce0 <_GLOBAL_OFFSET_TABLE_+0x20>
    800039e0:	0007b703          	ld	a4,0(a5)
    800039e4:	03073783          	ld	a5,48(a4)
    800039e8:	0000b697          	auipc	a3,0xb
    800039ec:	c806b683          	ld	a3,-896(a3) # 8000e668 <SYSTEM_TIME>
    800039f0:	00d787b3          	add	a5,a5,a3
    800039f4:	02f73c23          	sd	a5,56(a4)
    __asm__ volatile ("mv a0, %[value]" :: [value] "r"(value));
    800039f8:	00050513          	mv	a0,a0
}
    800039fc:	e6dff06f          	j	80003868 <handleEcall+0x38>
                    retval = 0;
    80003a00:	00000513          	li	a0,0
    80003a04:	ff5ff06f          	j	800039f8 <handleEcall+0x1c8>
                kern_thread_sleep(wakeTime);
    80003a08:	00958533          	add	a0,a1,s1
    80003a0c:	00000097          	auipc	ra,0x0
    80003a10:	af0080e7          	jalr	-1296(ra) # 800034fc <_Z17kern_thread_sleepm>
                running->endTime=time+running->timeslice;
    80003a14:	00009797          	auipc	a5,0x9
    80003a18:	2cc7b783          	ld	a5,716(a5) # 8000cce0 <_GLOBAL_OFFSET_TABLE_+0x20>
    80003a1c:	0007b703          	ld	a4,0(a5)
    80003a20:	03073783          	ld	a5,48(a4)
    80003a24:	0000b697          	auipc	a3,0xb
    80003a28:	c446b683          	ld	a3,-956(a3) # 8000e668 <SYSTEM_TIME>
    80003a2c:	00d787b3          	add	a5,a5,a3
    80003a30:	02f73c23          	sd	a5,56(a4)
                break;
    80003a34:	e35ff06f          	j	80003868 <handleEcall+0x38>
                    c = kern_console_getchar();
    80003a38:	fffff097          	auipc	ra,0xfffff
    80003a3c:	d28080e7          	jalr	-728(ra) # 80002760 <_Z20kern_console_getcharv>
                    if(c==-1){
    80003a40:	fff00793          	li	a5,-1
    80003a44:	02f51863          	bne	a0,a5,80003a74 <handleEcall+0x244>
                        kern_thread_dispatch();
    80003a48:	fffff097          	auipc	ra,0xfffff
    80003a4c:	750080e7          	jalr	1872(ra) # 80003198 <_Z20kern_thread_dispatchv>
                        running->endTime = SYSTEM_TIME + running->timeslice;
    80003a50:	00009797          	auipc	a5,0x9
    80003a54:	2907b783          	ld	a5,656(a5) # 8000cce0 <_GLOBAL_OFFSET_TABLE_+0x20>
    80003a58:	0007b703          	ld	a4,0(a5)
    80003a5c:	03073783          	ld	a5,48(a4)
    80003a60:	0000b697          	auipc	a3,0xb
    80003a64:	c086b683          	ld	a3,-1016(a3) # 8000e668 <SYSTEM_TIME>
    80003a68:	00d787b3          	add	a5,a5,a3
    80003a6c:	02f73c23          	sd	a5,56(a4)
                    c = kern_console_getchar();
    80003a70:	fc9ff06f          	j	80003a38 <handleEcall+0x208>
    __asm__ volatile ("mv a0, %[value]" :: [value] "r"(value));
    80003a74:	00050513          	mv	a0,a0
}
    80003a78:	df1ff06f          	j	80003868 <handleEcall+0x38>
                char c = a1;
    80003a7c:	0ff4f493          	andi	s1,s1,255
                    res=kern_console_putchar(c);
    80003a80:	00048513          	mv	a0,s1
    80003a84:	fffff097          	auipc	ra,0xfffff
    80003a88:	d40080e7          	jalr	-704(ra) # 800027c4 <_Z20kern_console_putcharc>
                    if(res==-1){
    80003a8c:	fff00793          	li	a5,-1
    80003a90:	dcf51ce3          	bne	a0,a5,80003868 <handleEcall+0x38>
                        kern_thread_dispatch();
    80003a94:	fffff097          	auipc	ra,0xfffff
    80003a98:	704080e7          	jalr	1796(ra) # 80003198 <_Z20kern_thread_dispatchv>
                        running->endTime = SYSTEM_TIME + running->timeslice;
    80003a9c:	00009797          	auipc	a5,0x9
    80003aa0:	2447b783          	ld	a5,580(a5) # 8000cce0 <_GLOBAL_OFFSET_TABLE_+0x20>
    80003aa4:	0007b703          	ld	a4,0(a5)
    80003aa8:	03073783          	ld	a5,48(a4)
    80003aac:	0000b697          	auipc	a3,0xb
    80003ab0:	bbc6b683          	ld	a3,-1092(a3) # 8000e668 <SYSTEM_TIME>
    80003ab4:	00d787b3          	add	a5,a5,a3
    80003ab8:	02f73c23          	sd	a5,56(a4)
                    res=kern_console_putchar(c);
    80003abc:	fc5ff06f          	j	80003a80 <handleEcall+0x250>

0000000080003ac0 <handleInterrupt>:
int counter=0;
#define BUFFER_SIZE 1024
char cbuf[BUFFER_SIZE];

void handleInterrupt()
{
    80003ac0:	fd010113          	addi	sp,sp,-48
    80003ac4:	02113423          	sd	ra,40(sp)
    80003ac8:	02813023          	sd	s0,32(sp)
    80003acc:	00913c23          	sd	s1,24(sp)
    80003ad0:	03010413          	addi	s0,sp,48
    __asm__ volatile ("csrr %[scause], scause" : [scause] "=r"(scause));
    80003ad4:	142027f3          	csrr	a5,scause
    80003ad8:	fcf43c23          	sd	a5,-40(s0)
    return scause;
    80003adc:	fd843703          	ld	a4,-40(s0)
    uint64 scause = r_scause();
    if (scause == INTR_TIMER)
    80003ae0:	fff00793          	li	a5,-1
    80003ae4:	03f79793          	slli	a5,a5,0x3f
    80003ae8:	00178793          	addi	a5,a5,1
    80003aec:	02f70863          	beq	a4,a5,80003b1c <handleInterrupt+0x5c>
        if(SYSTEM_TIME>=running->endTime){
            kern_thread_dispatch();
            running->endTime=SYSTEM_TIME+running->timeslice;
        }
    }
    else if (scause == INTR_CONSOLE)
    80003af0:	fff00793          	li	a5,-1
    80003af4:	03f79793          	slli	a5,a5,0x3f
    80003af8:	00978793          	addi	a5,a5,9
    80003afc:	08f70463          	beq	a4,a5,80003b84 <handleInterrupt+0xc4>
            kern_uart_handler();
        }
        plic_complete(irq);
        // console_handler();
    }
    else if(scause == INTR_ILLEGAL_INSTRUCTION)
    80003b00:	00200793          	li	a5,2
    80003b04:	0af70863          	beq	a4,a5,80003bb4 <handleInterrupt+0xf4>

    }
    else if(scause==INTR_ILLEGAL_ADDR_WR){

    }
}
    80003b08:	02813083          	ld	ra,40(sp)
    80003b0c:	02013403          	ld	s0,32(sp)
    80003b10:	01813483          	ld	s1,24(sp)
    80003b14:	03010113          	addi	sp,sp,48
    80003b18:	00008067          	ret
        SYSTEM_TIME++;
    80003b1c:	0000b497          	auipc	s1,0xb
    80003b20:	b4c48493          	addi	s1,s1,-1204 # 8000e668 <SYSTEM_TIME>
    80003b24:	0004b503          	ld	a0,0(s1)
    80003b28:	00150513          	addi	a0,a0,1
    80003b2c:	00a4b023          	sd	a0,0(s1)
    __asm__ volatile ("csrc sip, %[mask]" : : [mask] "r"(mask));
    80003b30:	00200793          	li	a5,2
    80003b34:	1447b073          	csrc	sip,a5
        kern_thread_wakeup(SYSTEM_TIME);
    80003b38:	00000097          	auipc	ra,0x0
    80003b3c:	940080e7          	jalr	-1728(ra) # 80003478 <_Z18kern_thread_wakeupm>
        if(SYSTEM_TIME>=running->endTime){
    80003b40:	00009797          	auipc	a5,0x9
    80003b44:	1a07b783          	ld	a5,416(a5) # 8000cce0 <_GLOBAL_OFFSET_TABLE_+0x20>
    80003b48:	0007b783          	ld	a5,0(a5)
    80003b4c:	0387b703          	ld	a4,56(a5)
    80003b50:	0004b783          	ld	a5,0(s1)
    80003b54:	fae7eae3          	bltu	a5,a4,80003b08 <handleInterrupt+0x48>
            kern_thread_dispatch();
    80003b58:	fffff097          	auipc	ra,0xfffff
    80003b5c:	640080e7          	jalr	1600(ra) # 80003198 <_Z20kern_thread_dispatchv>
            running->endTime=SYSTEM_TIME+running->timeslice;
    80003b60:	00009797          	auipc	a5,0x9
    80003b64:	1807b783          	ld	a5,384(a5) # 8000cce0 <_GLOBAL_OFFSET_TABLE_+0x20>
    80003b68:	0007b703          	ld	a4,0(a5)
    80003b6c:	03073783          	ld	a5,48(a4)
    80003b70:	0000b697          	auipc	a3,0xb
    80003b74:	af86b683          	ld	a3,-1288(a3) # 8000e668 <SYSTEM_TIME>
    80003b78:	00d787b3          	add	a5,a5,a3
    80003b7c:	02f73c23          	sd	a5,56(a4)
    80003b80:	f89ff06f          	j	80003b08 <handleInterrupt+0x48>
        int irq = plic_claim();
    80003b84:	00004097          	auipc	ra,0x4
    80003b88:	770080e7          	jalr	1904(ra) # 800082f4 <plic_claim>
    80003b8c:	00050493          	mv	s1,a0
        if(irq==CONSOLE_IRQ) {
    80003b90:	00a00793          	li	a5,10
    80003b94:	00f50a63          	beq	a0,a5,80003ba8 <handleInterrupt+0xe8>
        plic_complete(irq);
    80003b98:	00048513          	mv	a0,s1
    80003b9c:	00004097          	auipc	ra,0x4
    80003ba0:	790080e7          	jalr	1936(ra) # 8000832c <plic_complete>
    80003ba4:	f65ff06f          	j	80003b08 <handleInterrupt+0x48>
            kern_uart_handler();
    80003ba8:	fffff097          	auipc	ra,0xfffff
    80003bac:	b44080e7          	jalr	-1212(ra) # 800026ec <_Z17kern_uart_handlerv>
    80003bb0:	fe9ff06f          	j	80003b98 <handleInterrupt+0xd8>
        kern_mem_free((void*)running->stack_space);
    80003bb4:	00009797          	auipc	a5,0x9
    80003bb8:	12c7b783          	ld	a5,300(a5) # 8000cce0 <_GLOBAL_OFFSET_TABLE_+0x20>
    80003bbc:	0007b783          	ld	a5,0(a5)
    80003bc0:	0407b503          	ld	a0,64(a5)
    80003bc4:	fffff097          	auipc	ra,0xfffff
    80003bc8:	90c080e7          	jalr	-1780(ra) # 800024d0 <_Z13kern_mem_freePv>
        kern_thread_end_running();
    80003bcc:	fffff097          	auipc	ra,0xfffff
    80003bd0:	6b8080e7          	jalr	1720(ra) # 80003284 <_Z23kern_thread_end_runningv>
}
    80003bd4:	f35ff06f          	j	80003b08 <handleInterrupt+0x48>

0000000080003bd8 <_Z11kmem_strcpyPcPKc>:
#define ALLOCATION_CHUNK_SIZE 16

kmem_cache_t *kmem_cache_head;


void kmem_strcpy(char* dst, const char* src) {
    80003bd8:	ff010113          	addi	sp,sp,-16
    80003bdc:	00813423          	sd	s0,8(sp)
    80003be0:	01010413          	addi	s0,sp,16
    int i = 0;
    80003be4:	00000793          	li	a5,0
    while (src[i] != '\0' && i < 15) {
    80003be8:	00078713          	mv	a4,a5
    80003bec:	00f586b3          	add	a3,a1,a5
    80003bf0:	0006c683          	lbu	a3,0(a3)
    80003bf4:	00068e63          	beqz	a3,80003c10 <_Z11kmem_strcpyPcPKc+0x38>
    80003bf8:	00e00613          	li	a2,14
    80003bfc:	00f64a63          	blt	a2,a5,80003c10 <_Z11kmem_strcpyPcPKc+0x38>
        dst[i] = src[i];
    80003c00:	00f50733          	add	a4,a0,a5
    80003c04:	00d70023          	sb	a3,0(a4)
        i++;
    80003c08:	0017879b          	addiw	a5,a5,1
    while (src[i] != '\0' && i < 15) {
    80003c0c:	fddff06f          	j	80003be8 <_Z11kmem_strcpyPcPKc+0x10>
    }
    dst[i] = '\0';
    80003c10:	00e50533          	add	a0,a0,a4
    80003c14:	00050023          	sb	zero,0(a0)
}
    80003c18:	00813403          	ld	s0,8(sp)
    80003c1c:	01010113          	addi	sp,sp,16
    80003c20:	00008067          	ret

0000000080003c24 <_Z9kmem_initPvi>:

void kmem_init(void *space, int block_num)
{
    80003c24:	ff010113          	addi	sp,sp,-16
    80003c28:	00113423          	sd	ra,8(sp)
    80003c2c:	00813023          	sd	s0,0(sp)
    80003c30:	01010413          	addi	s0,sp,16
    bba_init((char*)space,(char*)space+block_num*BLOCK_SIZE);
    80003c34:	00c5959b          	slliw	a1,a1,0xc
    80003c38:	00b505b3          	add	a1,a0,a1
    80003c3c:	ffffe097          	auipc	ra,0xffffe
    80003c40:	abc080e7          	jalr	-1348(ra) # 800016f8 <_Z8bba_initPcS_>
    kmem_cache_head=0;
    80003c44:	0000b797          	auipc	a5,0xb
    80003c48:	e207ba23          	sd	zero,-460(a5) # 8000ea78 <kmem_cache_head>
}
    80003c4c:	00813083          	ld	ra,8(sp)
    80003c50:	00013403          	ld	s0,0(sp)
    80003c54:	01010113          	addi	sp,sp,16
    80003c58:	00008067          	ret

0000000080003c5c <_Z14kmem_slab_initP12kmem_cache_s>:
    }
}

//creates a slab, adds it to cache list, initializes up to ALLOCATION_CHUNK_SIZE objs if needed
kmem_slab_t *kmem_slab_init(kmem_cache_t* cache)
{
    80003c5c:	fd010113          	addi	sp,sp,-48
    80003c60:	02113423          	sd	ra,40(sp)
    80003c64:	02813023          	sd	s0,32(sp)
    80003c68:	00913c23          	sd	s1,24(sp)
    80003c6c:	01213823          	sd	s2,16(sp)
    80003c70:	01313423          	sd	s3,8(sp)
    80003c74:	01413023          	sd	s4,0(sp)
    80003c78:	03010413          	addi	s0,sp,48
    80003c7c:	00050913          	mv	s2,a0
    void* memory = bba_allocate(cache->memorySize);
    80003c80:	04852503          	lw	a0,72(a0)
    80003c84:	ffffe097          	auipc	ra,0xffffe
    80003c88:	d9c080e7          	jalr	-612(ra) # 80001a20 <_Z12bba_allocatem>
    80003c8c:	00050a13          	mv	s4,a0
    if(memory==0) return 0;
    80003c90:	10050a63          	beqz	a0,80003da4 <_Z14kmem_slab_initP12kmem_cache_s+0x148>

    int bitmapCharCount = (cache->slotsInSlab+8-1)/8;
    80003c94:	05092503          	lw	a0,80(s2)
    80003c98:	0075079b          	addiw	a5,a0,7
    80003c9c:	41f7d51b          	sraiw	a0,a5,0x1f
    80003ca0:	01d5551b          	srliw	a0,a0,0x1d
    80003ca4:	00f5053b          	addw	a0,a0,a5
    80003ca8:	4035551b          	sraiw	a0,a0,0x3
    80003cac:	0005049b          	sext.w	s1,a0
    int descriptorSize = sizeof(kmem_slab_t) + bitmapCharCount*2;
    80003cb0:	0015151b          	slliw	a0,a0,0x1
    kmem_slab_t *slab = (kmem_slab_t*) bba_allocate(descriptorSize);
    80003cb4:	0285051b          	addiw	a0,a0,40
    80003cb8:	ffffe097          	auipc	ra,0xffffe
    80003cbc:	d68080e7          	jalr	-664(ra) # 80001a20 <_Z12bba_allocatem>
    80003cc0:	00050993          	mv	s3,a0
    if(slab==0){
    80003cc4:	02050663          	beqz	a0,80003cf0 <_Z14kmem_slab_initP12kmem_cache_s+0x94>
        bba_free_block(memory);
        return 0;
    }

    slab->memory=memory;
    80003cc8:	01453423          	sd	s4,8(a0)
    slab->freeSlotsBitmap = (char*)slab + sizeof(kmem_slab_t);
    80003ccc:	02850793          	addi	a5,a0,40
    80003cd0:	00f53c23          	sd	a5,24(a0)
    slab->initializedSlotsBitmap = slab->freeSlotsBitmap + bitmapCharCount;
    80003cd4:	009787b3          	add	a5,a5,s1
    80003cd8:	00f53823          	sd	a5,16(a0)
    slab->usedSlotsCount=0;
    80003cdc:	00052023          	sw	zero,0(a0)
    slab->initializedSlotsCount=0;
    80003ce0:	00052223          	sw	zero,4(a0)
    slab->nextSlab=0;
    80003ce4:	02053023          	sd	zero,32(a0)


    //marks all slots as free, if ctor is provided initializes objects in slab, but no more than ALLOCATION_CHUNK_SIZE objects
    for (int i = 0; i < cache->slotsInSlab; i++) {
    80003ce8:	00000493          	li	s1,0
    80003cec:	04c0006f          	j	80003d38 <_Z14kmem_slab_initP12kmem_cache_s+0xdc>
        bba_free_block(memory);
    80003cf0:	000a0513          	mv	a0,s4
    80003cf4:	ffffe097          	auipc	ra,0xffffe
    80003cf8:	ff4080e7          	jalr	-12(ra) # 80001ce8 <_Z14bba_free_blockPKv>
        return 0;
    80003cfc:	0ac0006f          	j	80003da8 <_Z14kmem_slab_initP12kmem_cache_s+0x14c>
        if (cache->ctor!=0 && i < ALLOCATION_CHUNK_SIZE) {
            cache->ctor(curr);
            slab->initializedSlotsCount++;
            setBitmapValue(slab->initializedSlotsBitmap, i, SLOT_INITIALIZED);
        }
        setBitmapValue(slab->freeSlotsBitmap, i, SLOT_FREE);
    80003d00:	0189b703          	ld	a4,24(s3)
    int wordPosition = position/8;
    80003d04:	41f4d79b          	sraiw	a5,s1,0x1f
    80003d08:	01d7d69b          	srliw	a3,a5,0x1d
    80003d0c:	009687bb          	addw	a5,a3,s1
    80003d10:	4037d61b          	sraiw	a2,a5,0x3
    int bitPosition = position%8;
    80003d14:	0077f793          	andi	a5,a5,7
    80003d18:	40d787bb          	subw	a5,a5,a3
        bitmapStart[wordPosition] = bitmapStart[wordPosition] | (1<<bitPosition);
    80003d1c:	00c70733          	add	a4,a4,a2
    80003d20:	00070683          	lb	a3,0(a4)
    80003d24:	00100613          	li	a2,1
    80003d28:	00f617bb          	sllw	a5,a2,a5
    80003d2c:	00f6e7b3          	or	a5,a3,a5
    80003d30:	00f70023          	sb	a5,0(a4)
    for (int i = 0; i < cache->slotsInSlab; i++) {
    80003d34:	0014849b          	addiw	s1,s1,1
    80003d38:	05092783          	lw	a5,80(s2)
    80003d3c:	06f4d663          	bge	s1,a5,80003da8 <_Z14kmem_slab_initP12kmem_cache_s+0x14c>
        char *curr = (char*)memory + i * cache->slotSize;
    80003d40:	02093783          	ld	a5,32(s2)
    80003d44:	02f487b3          	mul	a5,s1,a5
    80003d48:	00fa0533          	add	a0,s4,a5
        if (cache->ctor!=0 && i < ALLOCATION_CHUNK_SIZE) {
    80003d4c:	02893783          	ld	a5,40(s2)
    80003d50:	fa0788e3          	beqz	a5,80003d00 <_Z14kmem_slab_initP12kmem_cache_s+0xa4>
    80003d54:	00f00713          	li	a4,15
    80003d58:	fa9744e3          	blt	a4,s1,80003d00 <_Z14kmem_slab_initP12kmem_cache_s+0xa4>
            cache->ctor(curr);
    80003d5c:	000780e7          	jalr	a5
            slab->initializedSlotsCount++;
    80003d60:	0049a783          	lw	a5,4(s3)
    80003d64:	0017879b          	addiw	a5,a5,1
    80003d68:	00f9a223          	sw	a5,4(s3)
            setBitmapValue(slab->initializedSlotsBitmap, i, SLOT_INITIALIZED);
    80003d6c:	0109b703          	ld	a4,16(s3)
    int wordPosition = position/8;
    80003d70:	41f4d79b          	sraiw	a5,s1,0x1f
    80003d74:	01d7d69b          	srliw	a3,a5,0x1d
    80003d78:	009687bb          	addw	a5,a3,s1
    80003d7c:	4037d61b          	sraiw	a2,a5,0x3
    int bitPosition = position%8;
    80003d80:	0077f793          	andi	a5,a5,7
    80003d84:	40d787bb          	subw	a5,a5,a3
        bitmapStart[wordPosition] = bitmapStart[wordPosition] | (1<<bitPosition);
    80003d88:	00c70733          	add	a4,a4,a2
    80003d8c:	00070683          	lb	a3,0(a4)
    80003d90:	00100613          	li	a2,1
    80003d94:	00f617bb          	sllw	a5,a2,a5
    80003d98:	00f6e7b3          	or	a5,a3,a5
    80003d9c:	00f70023          	sb	a5,0(a4)
    80003da0:	f61ff06f          	j	80003d00 <_Z14kmem_slab_initP12kmem_cache_s+0xa4>
    if(memory==0) return 0;
    80003da4:	00050993          	mv	s3,a0
    }

    return slab;
}
    80003da8:	00098513          	mv	a0,s3
    80003dac:	02813083          	ld	ra,40(sp)
    80003db0:	02013403          	ld	s0,32(sp)
    80003db4:	01813483          	ld	s1,24(sp)
    80003db8:	01013903          	ld	s2,16(sp)
    80003dbc:	00813983          	ld	s3,8(sp)
    80003dc0:	00013a03          	ld	s4,0(sp)
    80003dc4:	03010113          	addi	sp,sp,48
    80003dc8:	00008067          	ret

0000000080003dcc <_Z17kmem_cache_createPKcmPFvPvES3_>:

//creates cache with one empty slab
kmem_cache_t *kmem_cache_create(const char *name, unsigned long size,void (*ctor)(void *),void (*dtor)(void *))
{
    80003dcc:	fc010113          	addi	sp,sp,-64
    80003dd0:	02113c23          	sd	ra,56(sp)
    80003dd4:	02813823          	sd	s0,48(sp)
    80003dd8:	02913423          	sd	s1,40(sp)
    80003ddc:	03213023          	sd	s2,32(sp)
    80003de0:	01313c23          	sd	s3,24(sp)
    80003de4:	01413823          	sd	s4,16(sp)
    80003de8:	01513423          	sd	s5,8(sp)
    80003dec:	04010413          	addi	s0,sp,64
    80003df0:	00050a93          	mv	s5,a0
    80003df4:	00058913          	mv	s2,a1
    80003df8:	00060a13          	mv	s4,a2
    80003dfc:	00068993          	mv	s3,a3
    kmem_cache_t* cache = (kmem_cache_t*) bba_allocate(sizeof(kmem_cache_t));
    80003e00:	05800513          	li	a0,88
    80003e04:	ffffe097          	auipc	ra,0xffffe
    80003e08:	c1c080e7          	jalr	-996(ra) # 80001a20 <_Z12bba_allocatem>
    80003e0c:	00050493          	mv	s1,a0
    if(cache==0) return 0;
    80003e10:	06050c63          	beqz	a0,80003e88 <_Z17kmem_cache_createPKcmPFvPvES3_+0xbc>

    if(size<SMALL_SIZE) cache->memorySize=SMALL_SLAB;
    80003e14:	03f00793          	li	a5,63
    80003e18:	0927ec63          	bltu	a5,s2,80003eb0 <_Z17kmem_cache_createPKcmPFvPvES3_+0xe4>
    80003e1c:	000017b7          	lui	a5,0x1
    80003e20:	04f52423          	sw	a5,72(a0)
    else if(size<LARGE_SIZE) cache->memorySize=MEDIUM_SLAB;
    else cache->memorySize=LARGE_SLAB;

    cache->error=0;
    80003e24:	0404a623          	sw	zero,76(s1)
    cache->slotsInSlab = cache->memorySize/size;
    80003e28:	0484a783          	lw	a5,72(s1)
    80003e2c:	0327d7b3          	divu	a5,a5,s2
    80003e30:	04f4a823          	sw	a5,80(s1)
    cache->slotSize=size;
    80003e34:	0324b023          	sd	s2,32(s1)
    cache->dtor=dtor;
    80003e38:	0334b823          	sd	s3,48(s1)
    cache->ctor=ctor;
    80003e3c:	0344b423          	sd	s4,40(s1)
    cache->emptySlabsHead=0;
    80003e40:	0004b023          	sd	zero,0(s1)
    cache->usedSlabsHead=0;
    80003e44:	0004b423          	sd	zero,8(s1)
    cache->fullSlabsHead=0;
    80003e48:	0004b823          	sd	zero,16(s1)
    kmem_strcpy(cache->name,name);
    80003e4c:	000a8593          	mv	a1,s5
    80003e50:	03848513          	addi	a0,s1,56
    80003e54:	00000097          	auipc	ra,0x0
    80003e58:	d84080e7          	jalr	-636(ra) # 80003bd8 <_Z11kmem_strcpyPcPKc>

    kmem_slab_t * slab = kmem_slab_init(cache);
    80003e5c:	00048513          	mv	a0,s1
    80003e60:	00000097          	auipc	ra,0x0
    80003e64:	dfc080e7          	jalr	-516(ra) # 80003c5c <_Z14kmem_slab_initP12kmem_cache_s>
    80003e68:	00050913          	mv	s2,a0
    if(slab==0){
    80003e6c:	06050263          	beqz	a0,80003ed0 <_Z17kmem_cache_createPKcmPFvPvES3_+0x104>
        bba_free_block(cache);
        return 0;
    }
    cache->emptySlabsHead=slab;
    80003e70:	00a4b023          	sd	a0,0(s1)

    cache->nextCache=kmem_cache_head;
    80003e74:	0000b797          	auipc	a5,0xb
    80003e78:	c0478793          	addi	a5,a5,-1020 # 8000ea78 <kmem_cache_head>
    80003e7c:	0007b703          	ld	a4,0(a5)
    80003e80:	00e4bc23          	sd	a4,24(s1)
    kmem_cache_head=cache;
    80003e84:	0097b023          	sd	s1,0(a5)
    return cache;
}
    80003e88:	00048513          	mv	a0,s1
    80003e8c:	03813083          	ld	ra,56(sp)
    80003e90:	03013403          	ld	s0,48(sp)
    80003e94:	02813483          	ld	s1,40(sp)
    80003e98:	02013903          	ld	s2,32(sp)
    80003e9c:	01813983          	ld	s3,24(sp)
    80003ea0:	01013a03          	ld	s4,16(sp)
    80003ea4:	00813a83          	ld	s5,8(sp)
    80003ea8:	04010113          	addi	sp,sp,64
    80003eac:	00008067          	ret
    else if(size<LARGE_SIZE) cache->memorySize=MEDIUM_SLAB;
    80003eb0:	0ff00793          	li	a5,255
    80003eb4:	0127e863          	bltu	a5,s2,80003ec4 <_Z17kmem_cache_createPKcmPFvPvES3_+0xf8>
    80003eb8:	000027b7          	lui	a5,0x2
    80003ebc:	04f52423          	sw	a5,72(a0)
    80003ec0:	f65ff06f          	j	80003e24 <_Z17kmem_cache_createPKcmPFvPvES3_+0x58>
    else cache->memorySize=LARGE_SLAB;
    80003ec4:	000047b7          	lui	a5,0x4
    80003ec8:	04f52423          	sw	a5,72(a0)
    80003ecc:	f59ff06f          	j	80003e24 <_Z17kmem_cache_createPKcmPFvPvES3_+0x58>
        bba_free_block(cache);
    80003ed0:	00048513          	mv	a0,s1
    80003ed4:	ffffe097          	auipc	ra,0xffffe
    80003ed8:	e14080e7          	jalr	-492(ra) # 80001ce8 <_Z14bba_free_blockPKv>
        return 0;
    80003edc:	00090493          	mv	s1,s2
    80003ee0:	fa9ff06f          	j	80003e88 <_Z17kmem_cache_createPKcmPFvPvES3_+0xbc>

0000000080003ee4 <_Z24kmem_slab_destoy_objectsP11kmem_slab_sP12kmem_cache_s>:

void kmem_slab_destoy_objects(kmem_slab_t* slab, kmem_cache_t* cache)
{
    80003ee4:	fd010113          	addi	sp,sp,-48
    80003ee8:	02113423          	sd	ra,40(sp)
    80003eec:	02813023          	sd	s0,32(sp)
    80003ef0:	00913c23          	sd	s1,24(sp)
    80003ef4:	01213823          	sd	s2,16(sp)
    80003ef8:	01313423          	sd	s3,8(sp)
    80003efc:	03010413          	addi	s0,sp,48
    80003f00:	00050913          	mv	s2,a0
    80003f04:	00058993          	mv	s3,a1
    for(int i=0;i < (cache->slotsInSlab) && (slab->initializedSlotsCount>0); i++){
    80003f08:	00000493          	li	s1,0
    80003f0c:	0080006f          	j	80003f14 <_Z24kmem_slab_destoy_objectsP11kmem_slab_sP12kmem_cache_s+0x30>
    80003f10:	0014849b          	addiw	s1,s1,1
    80003f14:	0509a783          	lw	a5,80(s3)
    80003f18:	06f4d063          	bge	s1,a5,80003f78 <_Z24kmem_slab_destoy_objectsP11kmem_slab_sP12kmem_cache_s+0x94>
    80003f1c:	00492783          	lw	a5,4(s2)
    80003f20:	04f05c63          	blez	a5,80003f78 <_Z24kmem_slab_destoy_objectsP11kmem_slab_sP12kmem_cache_s+0x94>
       if(getBitmapValue(slab->initializedSlotsBitmap,i)==SLOT_INITIALIZED){
    80003f24:	01093703          	ld	a4,16(s2)
    int wordPosition = position/8;
    80003f28:	41f4d79b          	sraiw	a5,s1,0x1f
    80003f2c:	01d7d79b          	srliw	a5,a5,0x1d
    80003f30:	009787bb          	addw	a5,a5,s1
    80003f34:	4037d79b          	sraiw	a5,a5,0x3
    return (bitmapStart[wordPosition]>>position)&1;
    80003f38:	00f707b3          	add	a5,a4,a5
    80003f3c:	0007c783          	lbu	a5,0(a5) # 4000 <_entry-0x7fffc000>
    80003f40:	4097d7bb          	sraw	a5,a5,s1
    80003f44:	0017f793          	andi	a5,a5,1
       if(getBitmapValue(slab->initializedSlotsBitmap,i)==SLOT_INITIALIZED){
    80003f48:	fc0784e3          	beqz	a5,80003f10 <_Z24kmem_slab_destoy_objectsP11kmem_slab_sP12kmem_cache_s+0x2c>
           cache->dtor((char*)(slab->memory)+i*cache->slotSize);
    80003f4c:	0309b703          	ld	a4,48(s3)
    80003f50:	00893503          	ld	a0,8(s2)
    80003f54:	0209b783          	ld	a5,32(s3)
    80003f58:	02f487b3          	mul	a5,s1,a5
    80003f5c:	00f50533          	add	a0,a0,a5
    80003f60:	000700e7          	jalr	a4
           slab->initializedSlotsCount--;
    80003f64:	00492783          	lw	a5,4(s2)
    80003f68:	fff7879b          	addiw	a5,a5,-1
    80003f6c:	0007871b          	sext.w	a4,a5
    80003f70:	00f92223          	sw	a5,4(s2)
           if(slab->initializedSlotsCount==0) return;
    80003f74:	f8071ee3          	bnez	a4,80003f10 <_Z24kmem_slab_destoy_objectsP11kmem_slab_sP12kmem_cache_s+0x2c>
       }
    }
}
    80003f78:	02813083          	ld	ra,40(sp)
    80003f7c:	02013403          	ld	s0,32(sp)
    80003f80:	01813483          	ld	s1,24(sp)
    80003f84:	01013903          	ld	s2,16(sp)
    80003f88:	00813983          	ld	s3,8(sp)
    80003f8c:	03010113          	addi	sp,sp,48
    80003f90:	00008067          	ret

0000000080003f94 <_Z17kmem_cache_shrinkP12kmem_cache_s>:


int kmem_cache_shrink(kmem_cache_t *cachep)
{
    80003f94:	fd010113          	addi	sp,sp,-48
    80003f98:	02113423          	sd	ra,40(sp)
    80003f9c:	02813023          	sd	s0,32(sp)
    80003fa0:	00913c23          	sd	s1,24(sp)
    80003fa4:	01213823          	sd	s2,16(sp)
    80003fa8:	01313423          	sd	s3,8(sp)
    80003fac:	03010413          	addi	s0,sp,48
    80003fb0:	00050913          	mv	s2,a0
    kmem_slab_t *curr = cachep->emptySlabsHead;
    80003fb4:	00053483          	ld	s1,0(a0)
    kmem_slab_t *prev = 0;
    80003fb8:	0300006f          	j	80003fe8 <_Z17kmem_cache_shrinkP12kmem_cache_s+0x54>
    while (curr!=0){
        prev=curr;
        curr=curr->nextSlab;

        if(cachep->ctor!=0){
            kmem_slab_destoy_objects(prev,cachep);
    80003fbc:	00090593          	mv	a1,s2
    80003fc0:	00048513          	mv	a0,s1
    80003fc4:	00000097          	auipc	ra,0x0
    80003fc8:	f20080e7          	jalr	-224(ra) # 80003ee4 <_Z24kmem_slab_destoy_objectsP11kmem_slab_sP12kmem_cache_s>
        }

        bba_free_block(prev->memory);
    80003fcc:	0084b503          	ld	a0,8(s1)
    80003fd0:	ffffe097          	auipc	ra,0xffffe
    80003fd4:	d18080e7          	jalr	-744(ra) # 80001ce8 <_Z14bba_free_blockPKv>
        bba_free_block(prev);
    80003fd8:	00048513          	mv	a0,s1
    80003fdc:	ffffe097          	auipc	ra,0xffffe
    80003fe0:	d0c080e7          	jalr	-756(ra) # 80001ce8 <_Z14bba_free_blockPKv>
        curr=curr->nextSlab;
    80003fe4:	00098493          	mv	s1,s3
    while (curr!=0){
    80003fe8:	00048a63          	beqz	s1,80003ffc <_Z17kmem_cache_shrinkP12kmem_cache_s+0x68>
        curr=curr->nextSlab;
    80003fec:	0204b983          	ld	s3,32(s1)
        if(cachep->ctor!=0){
    80003ff0:	02893783          	ld	a5,40(s2)
    80003ff4:	fc0794e3          	bnez	a5,80003fbc <_Z17kmem_cache_shrinkP12kmem_cache_s+0x28>
    80003ff8:	fd5ff06f          	j	80003fcc <_Z17kmem_cache_shrinkP12kmem_cache_s+0x38>
    }

    cachep->emptySlabsHead=0;
    80003ffc:	00093023          	sd	zero,0(s2)
    return 0;
}
    80004000:	00000513          	li	a0,0
    80004004:	02813083          	ld	ra,40(sp)
    80004008:	02013403          	ld	s0,32(sp)
    8000400c:	01813483          	ld	s1,24(sp)
    80004010:	01013903          	ld	s2,16(sp)
    80004014:	00813983          	ld	s3,8(sp)
    80004018:	03010113          	addi	sp,sp,48
    8000401c:	00008067          	ret

0000000080004020 <_Z27kmem_slab_construct_objectsP11kmem_slab_sP12kmem_cache_s>:

//initialize up to ALLOCATION_CHUNK_SIZE objects in a given slab
void kmem_slab_construct_objects(kmem_slab_t *slab, kmem_cache_t *cache)
{
    80004020:	fc010113          	addi	sp,sp,-64
    80004024:	02113c23          	sd	ra,56(sp)
    80004028:	02813823          	sd	s0,48(sp)
    8000402c:	02913423          	sd	s1,40(sp)
    80004030:	03213023          	sd	s2,32(sp)
    80004034:	01313c23          	sd	s3,24(sp)
    80004038:	01413823          	sd	s4,16(sp)
    8000403c:	01513423          	sd	s5,8(sp)
    80004040:	04010413          	addi	s0,sp,64
    80004044:	00050993          	mv	s3,a0
    80004048:	00058a13          	mv	s4,a1
    int count=0;
    for(int i=0;i<cache->slotsInSlab;i++){
    8000404c:	00000913          	li	s2,0
    int count=0;
    80004050:	00000a93          	li	s5,0
    80004054:	0080006f          	j	8000405c <_Z27kmem_slab_construct_objectsP11kmem_slab_sP12kmem_cache_s+0x3c>
    for(int i=0;i<cache->slotsInSlab;i++){
    80004058:	0019091b          	addiw	s2,s2,1
    8000405c:	050a2783          	lw	a5,80(s4)
    80004060:	0af95863          	bge	s2,a5,80004110 <_Z27kmem_slab_construct_objectsP11kmem_slab_sP12kmem_cache_s+0xf0>
        if(getBitmapValue(slab->freeSlotsBitmap,i)==SLOT_FREE &&
    80004064:	0189b783          	ld	a5,24(s3)
    int wordPosition = position/8;
    80004068:	41f9549b          	sraiw	s1,s2,0x1f
    8000406c:	01d4d49b          	srliw	s1,s1,0x1d
    80004070:	012484bb          	addw	s1,s1,s2
    80004074:	4034d49b          	sraiw	s1,s1,0x3
    return (bitmapStart[wordPosition]>>position)&1;
    80004078:	009787b3          	add	a5,a5,s1
    8000407c:	0007c783          	lbu	a5,0(a5)
    80004080:	4127d7bb          	sraw	a5,a5,s2
    80004084:	0017f793          	andi	a5,a5,1
        if(getBitmapValue(slab->freeSlotsBitmap,i)==SLOT_FREE &&
    80004088:	fc0788e3          	beqz	a5,80004058 <_Z27kmem_slab_construct_objectsP11kmem_slab_sP12kmem_cache_s+0x38>
           getBitmapValue(slab->initializedSlotsBitmap,i)!=SLOT_INITIALIZED)
    8000408c:	0109b783          	ld	a5,16(s3)
    return (bitmapStart[wordPosition]>>position)&1;
    80004090:	009787b3          	add	a5,a5,s1
    80004094:	0007c783          	lbu	a5,0(a5)
    80004098:	4127d7bb          	sraw	a5,a5,s2
    8000409c:	0017f793          	andi	a5,a5,1
        if(getBitmapValue(slab->freeSlotsBitmap,i)==SLOT_FREE &&
    800040a0:	fa079ce3          	bnez	a5,80004058 <_Z27kmem_slab_construct_objectsP11kmem_slab_sP12kmem_cache_s+0x38>
        {
            cache->ctor((char*)(slab->memory)+i*cache->slotSize);
    800040a4:	028a3703          	ld	a4,40(s4)
    800040a8:	0089b503          	ld	a0,8(s3)
    800040ac:	020a3783          	ld	a5,32(s4)
    800040b0:	02f907b3          	mul	a5,s2,a5
    800040b4:	00f50533          	add	a0,a0,a5
    800040b8:	000700e7          	jalr	a4
            slab->initializedSlotsCount++;
    800040bc:	0049a783          	lw	a5,4(s3)
    800040c0:	0017879b          	addiw	a5,a5,1
    800040c4:	00f9a223          	sw	a5,4(s3)
            setBitmapValue(slab->initializedSlotsBitmap,i,SLOT_INITIALIZED);
    800040c8:	0109b703          	ld	a4,16(s3)
    int bitPosition = position%8;
    800040cc:	41f9579b          	sraiw	a5,s2,0x1f
    800040d0:	01d7d69b          	srliw	a3,a5,0x1d
    800040d4:	012687bb          	addw	a5,a3,s2
    800040d8:	0077f793          	andi	a5,a5,7
    800040dc:	40d787bb          	subw	a5,a5,a3
        bitmapStart[wordPosition] = bitmapStart[wordPosition] | (1<<bitPosition);
    800040e0:	009704b3          	add	s1,a4,s1
    800040e4:	00048703          	lb	a4,0(s1)
    800040e8:	00100693          	li	a3,1
    800040ec:	00f697bb          	sllw	a5,a3,a5
    800040f0:	00f767b3          	or	a5,a4,a5
    800040f4:	00f48023          	sb	a5,0(s1)
            count++;
    800040f8:	001a8a9b          	addiw	s5,s5,1
            if(count==ALLOCATION_CHUNK_SIZE || slab->initializedSlotsCount==cache->slotsInSlab) return;
    800040fc:	01000793          	li	a5,16
    80004100:	00fa8863          	beq	s5,a5,80004110 <_Z27kmem_slab_construct_objectsP11kmem_slab_sP12kmem_cache_s+0xf0>
    80004104:	0049a703          	lw	a4,4(s3)
    80004108:	050a2783          	lw	a5,80(s4)
    8000410c:	f4f716e3          	bne	a4,a5,80004058 <_Z27kmem_slab_construct_objectsP11kmem_slab_sP12kmem_cache_s+0x38>
        }
    }
}
    80004110:	03813083          	ld	ra,56(sp)
    80004114:	03013403          	ld	s0,48(sp)
    80004118:	02813483          	ld	s1,40(sp)
    8000411c:	02013903          	ld	s2,32(sp)
    80004120:	01813983          	ld	s3,24(sp)
    80004124:	01013a03          	ld	s4,16(sp)
    80004128:	00813a83          	ld	s5,8(sp)
    8000412c:	04010113          	addi	sp,sp,64
    80004130:	00008067          	ret

0000000080004134 <_Z25kmem_slab_get_free_objectP11kmem_slab_sP12kmem_cache_s>:



void* kmem_slab_get_free_object(kmem_slab_t *slab, kmem_cache_t *cache)
{
    80004134:	ff010113          	addi	sp,sp,-16
    80004138:	00813423          	sd	s0,8(sp)
    8000413c:	01010413          	addi	s0,sp,16
    int charCnt = (cache->slotsInSlab+8-1)/8;
    80004140:	0505a783          	lw	a5,80(a1)
    80004144:	0077871b          	addiw	a4,a5,7
    80004148:	41f7579b          	sraiw	a5,a4,0x1f
    8000414c:	01d7d79b          	srliw	a5,a5,0x1d
    80004150:	00e787bb          	addw	a5,a5,a4
    80004154:	4037d79b          	sraiw	a5,a5,0x3
    for(int i=0;i<charCnt;i++){
    80004158:	00000693          	li	a3,0
    8000415c:	0af6d263          	bge	a3,a5,80004200 <_Z25kmem_slab_get_free_objectP11kmem_slab_sP12kmem_cache_s+0xcc>
        char c = slab->freeSlotsBitmap[i];
    80004160:	01853803          	ld	a6,24(a0)
    80004164:	00d80733          	add	a4,a6,a3
    80004168:	00074603          	lbu	a2,0(a4)
        if(c==0) continue; //a quick way to check 8 slots at once
    8000416c:	02060263          	beqz	a2,80004190 <_Z25kmem_slab_get_free_objectP11kmem_slab_sP12kmem_cache_s+0x5c>
        int k = 0;
    80004170:	00000793          	li	a5,0
        while(k<8){
    80004174:	00700713          	li	a4,7
    80004178:	02f74063          	blt	a4,a5,80004198 <_Z25kmem_slab_get_free_objectP11kmem_slab_sP12kmem_cache_s+0x64>
            if( ((c>>k)&1) == SLOT_FREE) break;
    8000417c:	40f6573b          	sraw	a4,a2,a5
    80004180:	00177713          	andi	a4,a4,1
    80004184:	00071a63          	bnez	a4,80004198 <_Z25kmem_slab_get_free_objectP11kmem_slab_sP12kmem_cache_s+0x64>
            k++;
    80004188:	0017879b          	addiw	a5,a5,1
        while(k<8){
    8000418c:	fe9ff06f          	j	80004174 <_Z25kmem_slab_get_free_objectP11kmem_slab_sP12kmem_cache_s+0x40>
    for(int i=0;i<charCnt;i++){
    80004190:	0016869b          	addiw	a3,a3,1
    80004194:	fc9ff06f          	j	8000415c <_Z25kmem_slab_get_free_objectP11kmem_slab_sP12kmem_cache_s+0x28>
        }

        slab->usedSlotsCount++;
    80004198:	00052703          	lw	a4,0(a0)
    8000419c:	0017071b          	addiw	a4,a4,1
    800041a0:	00e52023          	sw	a4,0(a0)
        setBitmapValue(slab->freeSlotsBitmap,i*8+k,SLOT_TAKEN);
    800041a4:	0036969b          	slliw	a3,a3,0x3
    800041a8:	00f687bb          	addw	a5,a3,a5
    800041ac:	0007869b          	sext.w	a3,a5
    int wordPosition = position/8;
    800041b0:	41f7d71b          	sraiw	a4,a5,0x1f
    800041b4:	01d7571b          	srliw	a4,a4,0x1d
    800041b8:	00f707bb          	addw	a5,a4,a5
    800041bc:	4037d61b          	sraiw	a2,a5,0x3
    int bitPosition = position%8;
    800041c0:	0077f793          	andi	a5,a5,7
    800041c4:	40e787bb          	subw	a5,a5,a4
        bitmapStart[wordPosition] = bitmapStart[wordPosition] & (~(1<<bitPosition));
    800041c8:	00c80833          	add	a6,a6,a2
    800041cc:	00080603          	lb	a2,0(a6)
    800041d0:	00100713          	li	a4,1
    800041d4:	00f717bb          	sllw	a5,a4,a5
    800041d8:	fff7c793          	not	a5,a5
    800041dc:	00f677b3          	and	a5,a2,a5
    800041e0:	00f80023          	sb	a5,0(a6)
        return ((char*)slab->memory+(i*8+k)*cache->slotSize);
    800041e4:	00853503          	ld	a0,8(a0)
    800041e8:	0205b783          	ld	a5,32(a1)
    800041ec:	02f687b3          	mul	a5,a3,a5
    800041f0:	00f50533          	add	a0,a0,a5
    }
    return 0;
}
    800041f4:	00813403          	ld	s0,8(sp)
    800041f8:	01010113          	addi	sp,sp,16
    800041fc:	00008067          	ret
    return 0;
    80004200:	00000513          	li	a0,0
    80004204:	ff1ff06f          	j	800041f4 <_Z25kmem_slab_get_free_objectP11kmem_slab_sP12kmem_cache_s+0xc0>

0000000080004208 <_Z37kmem_slab_get_initialized_free_objectP11kmem_slab_sP12kmem_cache_s>:

void* kmem_slab_get_initialized_free_object(kmem_slab_t *slab, kmem_cache_t *cache)
{
    80004208:	ff010113          	addi	sp,sp,-16
    8000420c:	00813423          	sd	s0,8(sp)
    80004210:	01010413          	addi	s0,sp,16
    int charCnt = (cache->slotsInSlab+8-1)/8;
    80004214:	0505a783          	lw	a5,80(a1)
    80004218:	0077871b          	addiw	a4,a5,7
    8000421c:	41f7579b          	sraiw	a5,a4,0x1f
    80004220:	01d7d79b          	srliw	a5,a5,0x1d
    80004224:	00e787bb          	addw	a5,a5,a4
    80004228:	4037d79b          	sraiw	a5,a5,0x3
    for(int i=0;i<charCnt;i++){
    8000422c:	00000693          	li	a3,0
    80004230:	0af6da63          	bge	a3,a5,800042e4 <_Z37kmem_slab_get_initialized_free_objectP11kmem_slab_sP12kmem_cache_s+0xdc>
        char c = (char)(slab->initializedSlotsBitmap[i]&slab->freeSlotsBitmap[i]);
    80004234:	01053703          	ld	a4,16(a0)
    80004238:	00d70733          	add	a4,a4,a3
    8000423c:	00074603          	lbu	a2,0(a4)
    80004240:	01853803          	ld	a6,24(a0)
    80004244:	00d80733          	add	a4,a6,a3
    80004248:	00074703          	lbu	a4,0(a4)
    8000424c:	00e67633          	and	a2,a2,a4
        if(c==0) continue; //a quick way to check 8 slots at once
    80004250:	02060263          	beqz	a2,80004274 <_Z37kmem_slab_get_initialized_free_objectP11kmem_slab_sP12kmem_cache_s+0x6c>
        int k = 0;
    80004254:	00000793          	li	a5,0
        while(k<8){
    80004258:	00700713          	li	a4,7
    8000425c:	02f74063          	blt	a4,a5,8000427c <_Z37kmem_slab_get_initialized_free_objectP11kmem_slab_sP12kmem_cache_s+0x74>
            if((c>>k)&SLOT_INITIALIZED) break;
    80004260:	40f6573b          	sraw	a4,a2,a5
    80004264:	00177713          	andi	a4,a4,1
    80004268:	00071a63          	bnez	a4,8000427c <_Z37kmem_slab_get_initialized_free_objectP11kmem_slab_sP12kmem_cache_s+0x74>
            k++;
    8000426c:	0017879b          	addiw	a5,a5,1
        while(k<8){
    80004270:	fe9ff06f          	j	80004258 <_Z37kmem_slab_get_initialized_free_objectP11kmem_slab_sP12kmem_cache_s+0x50>
    for(int i=0;i<charCnt;i++){
    80004274:	0016869b          	addiw	a3,a3,1
    80004278:	fb9ff06f          	j	80004230 <_Z37kmem_slab_get_initialized_free_objectP11kmem_slab_sP12kmem_cache_s+0x28>
        }

        slab->usedSlotsCount++;
    8000427c:	00052703          	lw	a4,0(a0)
    80004280:	0017071b          	addiw	a4,a4,1
    80004284:	00e52023          	sw	a4,0(a0)
        setBitmapValue(slab->freeSlotsBitmap,i*8+k,SLOT_TAKEN);
    80004288:	0036969b          	slliw	a3,a3,0x3
    8000428c:	00f687bb          	addw	a5,a3,a5
    80004290:	0007869b          	sext.w	a3,a5
    int wordPosition = position/8;
    80004294:	41f7d71b          	sraiw	a4,a5,0x1f
    80004298:	01d7571b          	srliw	a4,a4,0x1d
    8000429c:	00f707bb          	addw	a5,a4,a5
    800042a0:	4037d61b          	sraiw	a2,a5,0x3
    int bitPosition = position%8;
    800042a4:	0077f793          	andi	a5,a5,7
    800042a8:	40e787bb          	subw	a5,a5,a4
        bitmapStart[wordPosition] = bitmapStart[wordPosition] & (~(1<<bitPosition));
    800042ac:	00c80833          	add	a6,a6,a2
    800042b0:	00080603          	lb	a2,0(a6)
    800042b4:	00100713          	li	a4,1
    800042b8:	00f717bb          	sllw	a5,a4,a5
    800042bc:	fff7c793          	not	a5,a5
    800042c0:	00f677b3          	and	a5,a2,a5
    800042c4:	00f80023          	sb	a5,0(a6)
        return ((char*)slab->memory+(i*8+k)*cache->slotSize);
    800042c8:	00853503          	ld	a0,8(a0)
    800042cc:	0205b783          	ld	a5,32(a1)
    800042d0:	02f687b3          	mul	a5,a3,a5
    800042d4:	00f50533          	add	a0,a0,a5
    }
    return 0;
}
    800042d8:	00813403          	ld	s0,8(sp)
    800042dc:	01010113          	addi	sp,sp,16
    800042e0:	00008067          	ret
    return 0;
    800042e4:	00000513          	li	a0,0
    800042e8:	ff1ff06f          	j	800042d8 <_Z37kmem_slab_get_initialized_free_objectP11kmem_slab_sP12kmem_cache_s+0xd0>

00000000800042ec <_Z31kmem_cache_alloc_no_constructorP12kmem_cache_s>:


void *kmem_cache_alloc_no_constructor(kmem_cache_t* cachep)
{
    800042ec:	fe010113          	addi	sp,sp,-32
    800042f0:	00113c23          	sd	ra,24(sp)
    800042f4:	00813823          	sd	s0,16(sp)
    800042f8:	00913423          	sd	s1,8(sp)
    800042fc:	02010413          	addi	s0,sp,32
    80004300:	00050493          	mv	s1,a0
    if(cachep->usedSlabsHead==0){
    80004304:	00853503          	ld	a0,8(a0)
    80004308:	04051863          	bnez	a0,80004358 <_Z31kmem_cache_alloc_no_constructorP12kmem_cache_s+0x6c>
        if(cachep->emptySlabsHead==0){
    8000430c:	0004b783          	ld	a5,0(s1)
    80004310:	02078a63          	beqz	a5,80004344 <_Z31kmem_cache_alloc_no_constructorP12kmem_cache_s+0x58>
            cachep->usedSlabsHead = kmem_slab_init(cachep);
        }
        else {
            cachep->usedSlabsHead=cachep->emptySlabsHead;
    80004314:	00f4b423          	sd	a5,8(s1)
            cachep->emptySlabsHead=cachep->emptySlabsHead->nextSlab;
    80004318:	0207b783          	ld	a5,32(a5)
    8000431c:	00f4b023          	sd	a5,0(s1)
        }
        return kmem_slab_get_free_object(cachep->usedSlabsHead,cachep);
    80004320:	00048593          	mv	a1,s1
    80004324:	0084b503          	ld	a0,8(s1)
    80004328:	00000097          	auipc	ra,0x0
    8000432c:	e0c080e7          	jalr	-500(ra) # 80004134 <_Z25kmem_slab_get_free_objectP11kmem_slab_sP12kmem_cache_s>
            head->nextSlab=cachep->fullSlabsHead;
            cachep->fullSlabsHead=head;
        }
        return result;
    }
}
    80004330:	01813083          	ld	ra,24(sp)
    80004334:	01013403          	ld	s0,16(sp)
    80004338:	00813483          	ld	s1,8(sp)
    8000433c:	02010113          	addi	sp,sp,32
    80004340:	00008067          	ret
            cachep->usedSlabsHead = kmem_slab_init(cachep);
    80004344:	00048513          	mv	a0,s1
    80004348:	00000097          	auipc	ra,0x0
    8000434c:	914080e7          	jalr	-1772(ra) # 80003c5c <_Z14kmem_slab_initP12kmem_cache_s>
    80004350:	00a4b423          	sd	a0,8(s1)
    80004354:	fcdff06f          	j	80004320 <_Z31kmem_cache_alloc_no_constructorP12kmem_cache_s+0x34>
        void* result = kmem_slab_get_free_object(cachep->usedSlabsHead,cachep);
    80004358:	00048593          	mv	a1,s1
    8000435c:	00000097          	auipc	ra,0x0
    80004360:	dd8080e7          	jalr	-552(ra) # 80004134 <_Z25kmem_slab_get_free_objectP11kmem_slab_sP12kmem_cache_s>
        kmem_slab_t* head = cachep->usedSlabsHead;
    80004364:	0084b783          	ld	a5,8(s1)
        if(head->usedSlotsCount==cachep->slotsInSlab){
    80004368:	0007a683          	lw	a3,0(a5)
    8000436c:	0504a703          	lw	a4,80(s1)
    80004370:	fce690e3          	bne	a3,a4,80004330 <_Z31kmem_cache_alloc_no_constructorP12kmem_cache_s+0x44>
            cachep->usedSlabsHead=head->nextSlab;
    80004374:	0207b703          	ld	a4,32(a5)
    80004378:	00e4b423          	sd	a4,8(s1)
            head->nextSlab=cachep->fullSlabsHead;
    8000437c:	0104b703          	ld	a4,16(s1)
    80004380:	02e7b023          	sd	a4,32(a5)
            cachep->fullSlabsHead=head;
    80004384:	00f4b823          	sd	a5,16(s1)
        return result;
    80004388:	fa9ff06f          	j	80004330 <_Z31kmem_cache_alloc_no_constructorP12kmem_cache_s+0x44>

000000008000438c <_Z28kmem_cache_alloc_constructorP12kmem_cache_s>:


void *kmem_cache_alloc_constructor(kmem_cache_t *cachep)
{
    8000438c:	fd010113          	addi	sp,sp,-48
    80004390:	02113423          	sd	ra,40(sp)
    80004394:	02813023          	sd	s0,32(sp)
    80004398:	00913c23          	sd	s1,24(sp)
    8000439c:	01213823          	sd	s2,16(sp)
    800043a0:	01313423          	sd	s3,8(sp)
    800043a4:	03010413          	addi	s0,sp,48
    800043a8:	00050913          	mv	s2,a0
    if(cachep->usedSlabsHead==0){
    800043ac:	00853983          	ld	s3,8(a0)
    800043b0:	02098063          	beqz	s3,800043d0 <_Z28kmem_cache_alloc_constructorP12kmem_cache_s+0x44>
            cachep->emptySlabsHead=cachep->emptySlabsHead->nextSlab;
        }
        return kmem_slab_get_initialized_free_object(cachep->usedSlabsHead,cachep);
    }
    else{
        kmem_slab_t* target = cachep->usedSlabsHead;
    800043b4:	00098493          	mv	s1,s3
        while (target!=0){
    800043b8:	06048463          	beqz	s1,80004420 <_Z28kmem_cache_alloc_constructorP12kmem_cache_s+0x94>
            if(target->initializedSlotsCount>target->usedSlotsCount) break;
    800043bc:	0044a703          	lw	a4,4(s1)
    800043c0:	0004a783          	lw	a5,0(s1)
    800043c4:	04e7ce63          	blt	a5,a4,80004420 <_Z28kmem_cache_alloc_constructorP12kmem_cache_s+0x94>
            target=target->nextSlab;
    800043c8:	0204b483          	ld	s1,32(s1)
        while (target!=0){
    800043cc:	fedff06f          	j	800043b8 <_Z28kmem_cache_alloc_constructorP12kmem_cache_s+0x2c>
        if(cachep->emptySlabsHead==0){
    800043d0:	00053783          	ld	a5,0(a0)
    800043d4:	02078e63          	beqz	a5,80004410 <_Z28kmem_cache_alloc_constructorP12kmem_cache_s+0x84>
            cachep->usedSlabsHead=cachep->emptySlabsHead;
    800043d8:	00f53423          	sd	a5,8(a0)
            cachep->emptySlabsHead=cachep->emptySlabsHead->nextSlab;
    800043dc:	0207b783          	ld	a5,32(a5)
    800043e0:	00f53023          	sd	a5,0(a0)
        return kmem_slab_get_initialized_free_object(cachep->usedSlabsHead,cachep);
    800043e4:	00090593          	mv	a1,s2
    800043e8:	00893503          	ld	a0,8(s2)
    800043ec:	00000097          	auipc	ra,0x0
    800043f0:	e1c080e7          	jalr	-484(ra) # 80004208 <_Z37kmem_slab_get_initialized_free_objectP11kmem_slab_sP12kmem_cache_s>
            target->nextSlab=cachep->fullSlabsHead;
            cachep->fullSlabsHead=target;
        }
        return result;
    }
}
    800043f4:	02813083          	ld	ra,40(sp)
    800043f8:	02013403          	ld	s0,32(sp)
    800043fc:	01813483          	ld	s1,24(sp)
    80004400:	01013903          	ld	s2,16(sp)
    80004404:	00813983          	ld	s3,8(sp)
    80004408:	03010113          	addi	sp,sp,48
    8000440c:	00008067          	ret
            cachep->usedSlabsHead = kmem_slab_init(cachep);
    80004410:	00000097          	auipc	ra,0x0
    80004414:	84c080e7          	jalr	-1972(ra) # 80003c5c <_Z14kmem_slab_initP12kmem_cache_s>
    80004418:	00a93423          	sd	a0,8(s2)
    8000441c:	fc9ff06f          	j	800043e4 <_Z28kmem_cache_alloc_constructorP12kmem_cache_s+0x58>
        if(target==0){
    80004420:	04048663          	beqz	s1,8000446c <_Z28kmem_cache_alloc_constructorP12kmem_cache_s+0xe0>
        void* result = kmem_slab_get_initialized_free_object(target,cachep);
    80004424:	00090593          	mv	a1,s2
    80004428:	00048513          	mv	a0,s1
    8000442c:	00000097          	auipc	ra,0x0
    80004430:	ddc080e7          	jalr	-548(ra) # 80004208 <_Z37kmem_slab_get_initialized_free_objectP11kmem_slab_sP12kmem_cache_s>
        if(target->usedSlotsCount==cachep->slotsInSlab){
    80004434:	0004a703          	lw	a4,0(s1)
    80004438:	05092783          	lw	a5,80(s2)
    8000443c:	faf71ce3          	bne	a4,a5,800043f4 <_Z28kmem_cache_alloc_constructorP12kmem_cache_s+0x68>
            if(target==cachep->usedSlabsHead){
    80004440:	00893783          	ld	a5,8(s2)
    80004444:	04978063          	beq	a5,s1,80004484 <_Z28kmem_cache_alloc_constructorP12kmem_cache_s+0xf8>
                while (prev->nextSlab!=target) prev=prev->nextSlab;
    80004448:	00078713          	mv	a4,a5
    8000444c:	0207b783          	ld	a5,32(a5)
    80004450:	fe979ce3          	bne	a5,s1,80004448 <_Z28kmem_cache_alloc_constructorP12kmem_cache_s+0xbc>
                prev->nextSlab=target->nextSlab;
    80004454:	0204b783          	ld	a5,32(s1)
    80004458:	02f73023          	sd	a5,32(a4)
            target->nextSlab=cachep->fullSlabsHead;
    8000445c:	01093783          	ld	a5,16(s2)
    80004460:	02f4b023          	sd	a5,32(s1)
            cachep->fullSlabsHead=target;
    80004464:	00993823          	sd	s1,16(s2)
        return result;
    80004468:	f8dff06f          	j	800043f4 <_Z28kmem_cache_alloc_constructorP12kmem_cache_s+0x68>
            kmem_slab_construct_objects(target,cachep);
    8000446c:	00090593          	mv	a1,s2
    80004470:	00098513          	mv	a0,s3
    80004474:	00000097          	auipc	ra,0x0
    80004478:	bac080e7          	jalr	-1108(ra) # 80004020 <_Z27kmem_slab_construct_objectsP11kmem_slab_sP12kmem_cache_s>
            target=cachep->usedSlabsHead;
    8000447c:	00098493          	mv	s1,s3
    80004480:	fa5ff06f          	j	80004424 <_Z28kmem_cache_alloc_constructorP12kmem_cache_s+0x98>
                cachep->usedSlabsHead=target->nextSlab;
    80004484:	0204b783          	ld	a5,32(s1)
    80004488:	00f93423          	sd	a5,8(s2)
    8000448c:	fd1ff06f          	j	8000445c <_Z28kmem_cache_alloc_constructorP12kmem_cache_s+0xd0>

0000000080004490 <_Z16kmem_cache_allocP12kmem_cache_s>:

void *kmem_cache_alloc(kmem_cache_t* cachep){
    80004490:	ff010113          	addi	sp,sp,-16
    80004494:	00113423          	sd	ra,8(sp)
    80004498:	00813023          	sd	s0,0(sp)
    8000449c:	01010413          	addi	s0,sp,16
    if(cachep->ctor!=0) return kmem_cache_alloc_constructor(cachep);
    800044a0:	02853783          	ld	a5,40(a0)
    800044a4:	00078e63          	beqz	a5,800044c0 <_Z16kmem_cache_allocP12kmem_cache_s+0x30>
    800044a8:	00000097          	auipc	ra,0x0
    800044ac:	ee4080e7          	jalr	-284(ra) # 8000438c <_Z28kmem_cache_alloc_constructorP12kmem_cache_s>
    else return kmem_cache_alloc_no_constructor(cachep);
}
    800044b0:	00813083          	ld	ra,8(sp)
    800044b4:	00013403          	ld	s0,0(sp)
    800044b8:	01010113          	addi	sp,sp,16
    800044bc:	00008067          	ret
    else return kmem_cache_alloc_no_constructor(cachep);
    800044c0:	00000097          	auipc	ra,0x0
    800044c4:	e2c080e7          	jalr	-468(ra) # 800042ec <_Z31kmem_cache_alloc_no_constructorP12kmem_cache_s>
    800044c8:	fe9ff06f          	j	800044b0 <_Z16kmem_cache_allocP12kmem_cache_s+0x20>

00000000800044cc <_Z15kmem_cache_freeP12kmem_cache_sPv>:

// Deallocate one object from cache
void kmem_cache_free(kmem_cache_t *cachep, void *objp)
{
    800044cc:	ff010113          	addi	sp,sp,-16
    800044d0:	00813423          	sd	s0,8(sp)
    800044d4:	01010413          	addi	s0,sp,16
    //look for the object amongst nonfull slabs
    kmem_slab_t* curr = cachep->usedSlabsHead;
    800044d8:	00853783          	ld	a5,8(a0)
    kmem_slab_t* prev = 0;
    800044dc:	00000613          	li	a2,0
    800044e0:	0180006f          	j	800044f8 <_Z15kmem_cache_freeP12kmem_cache_sPv+0x2c>
            int positionInSlab = ((char*)objp - (char*)curr->memory)/cachep->slotSize;
            setBitmapValue(curr->freeSlotsBitmap,positionInSlab,SLOT_FREE);
            curr->usedSlotsCount--;
            if(curr->usedSlotsCount==0){
                if(prev==0){
                    cachep->usedSlabsHead=curr->nextSlab;
    800044e4:	0207b703          	ld	a4,32(a5)
    800044e8:	00e53423          	sd	a4,8(a0)
    800044ec:	0840006f          	j	80004570 <_Z15kmem_cache_freeP12kmem_cache_sPv+0xa4>
                curr->nextSlab=cachep->emptySlabsHead;
                cachep->emptySlabsHead=curr;
            }
            return;
        }
        prev=curr;
    800044f0:	00078613          	mv	a2,a5
        curr=curr->nextSlab;
    800044f4:	0207b783          	ld	a5,32(a5)
    while(curr!=0){
    800044f8:	08078463          	beqz	a5,80004580 <_Z15kmem_cache_freeP12kmem_cache_sPv+0xb4>
        if(objp>curr->memory && objp<((char*)(curr->memory)+cachep->memorySize)){
    800044fc:	0087b703          	ld	a4,8(a5)
    80004500:	feb778e3          	bgeu	a4,a1,800044f0 <_Z15kmem_cache_freeP12kmem_cache_sPv+0x24>
    80004504:	04852683          	lw	a3,72(a0)
    80004508:	00d706b3          	add	a3,a4,a3
    8000450c:	fed5f2e3          	bgeu	a1,a3,800044f0 <_Z15kmem_cache_freeP12kmem_cache_sPv+0x24>
            int positionInSlab = ((char*)objp - (char*)curr->memory)/cachep->slotSize;
    80004510:	40e58733          	sub	a4,a1,a4
    80004514:	02053583          	ld	a1,32(a0)
    80004518:	02b75733          	divu	a4,a4,a1
            setBitmapValue(curr->freeSlotsBitmap,positionInSlab,SLOT_FREE);
    8000451c:	0187b683          	ld	a3,24(a5)
    int wordPosition = position/8;
    80004520:	41f7559b          	sraiw	a1,a4,0x1f
    80004524:	01d5d59b          	srliw	a1,a1,0x1d
    80004528:	00e5873b          	addw	a4,a1,a4
    8000452c:	4037581b          	sraiw	a6,a4,0x3
    int bitPosition = position%8;
    80004530:	00777713          	andi	a4,a4,7
    80004534:	40b7073b          	subw	a4,a4,a1
        bitmapStart[wordPosition] = bitmapStart[wordPosition] | (1<<bitPosition);
    80004538:	010686b3          	add	a3,a3,a6
    8000453c:	00068583          	lb	a1,0(a3)
    80004540:	00100813          	li	a6,1
    80004544:	00e8173b          	sllw	a4,a6,a4
    80004548:	00e5e733          	or	a4,a1,a4
    8000454c:	00e68023          	sb	a4,0(a3)
            curr->usedSlotsCount--;
    80004550:	0007a703          	lw	a4,0(a5)
    80004554:	fff7071b          	addiw	a4,a4,-1
    80004558:	0007069b          	sext.w	a3,a4
    8000455c:	00e7a023          	sw	a4,0(a5)
            if(curr->usedSlotsCount==0){
    80004560:	0a069c63          	bnez	a3,80004618 <_Z15kmem_cache_freeP12kmem_cache_sPv+0x14c>
                if(prev==0){
    80004564:	f80600e3          	beqz	a2,800044e4 <_Z15kmem_cache_freeP12kmem_cache_sPv+0x18>
                    prev->nextSlab=curr->nextSlab;
    80004568:	0207b703          	ld	a4,32(a5)
    8000456c:	02e63023          	sd	a4,32(a2)
                curr->nextSlab=cachep->emptySlabsHead;
    80004570:	00053703          	ld	a4,0(a0)
    80004574:	02e7b023          	sd	a4,32(a5)
                cachep->emptySlabsHead=curr;
    80004578:	00f53023          	sd	a5,0(a0)
            return;
    8000457c:	09c0006f          	j	80004618 <_Z15kmem_cache_freeP12kmem_cache_sPv+0x14c>
    }

    //amongst full slabs
    curr=cachep->fullSlabsHead;
    80004580:	01053703          	ld	a4,16(a0)
    prev=0;
    80004584:	0180006f          	j	8000459c <_Z15kmem_cache_freeP12kmem_cache_sPv+0xd0>
        if(objp>curr->memory && objp<((char*)(curr->memory)+cachep->memorySize)){
            int positionInSlab = ((char*)objp - (char*)curr->memory)/cachep->slotSize;
            setBitmapValue(curr->freeSlotsBitmap,positionInSlab,SLOT_FREE);
            curr->usedSlotsCount--;
            if(prev==0){
                cachep->fullSlabsHead=curr->nextSlab;
    80004588:	02073783          	ld	a5,32(a4)
    8000458c:	00f53823          	sd	a5,16(a0)
    80004590:	07c0006f          	j	8000460c <_Z15kmem_cache_freeP12kmem_cache_sPv+0x140>
            }
            curr->nextSlab=cachep->usedSlabsHead;
            cachep->usedSlabsHead=curr;
            return;
        }
        prev=curr;
    80004594:	00070793          	mv	a5,a4
        curr=curr->nextSlab;
    80004598:	02073703          	ld	a4,32(a4)
    while(curr!=0){
    8000459c:	06070e63          	beqz	a4,80004618 <_Z15kmem_cache_freeP12kmem_cache_sPv+0x14c>
        if(objp>curr->memory && objp<((char*)(curr->memory)+cachep->memorySize)){
    800045a0:	00873683          	ld	a3,8(a4)
    800045a4:	feb6f8e3          	bgeu	a3,a1,80004594 <_Z15kmem_cache_freeP12kmem_cache_sPv+0xc8>
    800045a8:	04852603          	lw	a2,72(a0)
    800045ac:	00c68633          	add	a2,a3,a2
    800045b0:	fec5f2e3          	bgeu	a1,a2,80004594 <_Z15kmem_cache_freeP12kmem_cache_sPv+0xc8>
            int positionInSlab = ((char*)objp - (char*)curr->memory)/cachep->slotSize;
    800045b4:	40d586b3          	sub	a3,a1,a3
    800045b8:	02053583          	ld	a1,32(a0)
    800045bc:	02b6d6b3          	divu	a3,a3,a1
            setBitmapValue(curr->freeSlotsBitmap,positionInSlab,SLOT_FREE);
    800045c0:	01873603          	ld	a2,24(a4)
    int wordPosition = position/8;
    800045c4:	41f6d59b          	sraiw	a1,a3,0x1f
    800045c8:	01d5d59b          	srliw	a1,a1,0x1d
    800045cc:	00d586bb          	addw	a3,a1,a3
    800045d0:	4036d81b          	sraiw	a6,a3,0x3
    int bitPosition = position%8;
    800045d4:	0076f693          	andi	a3,a3,7
    800045d8:	40b686bb          	subw	a3,a3,a1
        bitmapStart[wordPosition] = bitmapStart[wordPosition] | (1<<bitPosition);
    800045dc:	01060633          	add	a2,a2,a6
    800045e0:	00060583          	lb	a1,0(a2)
    800045e4:	00100813          	li	a6,1
    800045e8:	00d816bb          	sllw	a3,a6,a3
    800045ec:	00d5e6b3          	or	a3,a1,a3
    800045f0:	00d60023          	sb	a3,0(a2)
            curr->usedSlotsCount--;
    800045f4:	00072683          	lw	a3,0(a4)
    800045f8:	fff6869b          	addiw	a3,a3,-1
    800045fc:	00d72023          	sw	a3,0(a4)
            if(prev==0){
    80004600:	f80784e3          	beqz	a5,80004588 <_Z15kmem_cache_freeP12kmem_cache_sPv+0xbc>
                prev->nextSlab=curr->nextSlab;
    80004604:	02073683          	ld	a3,32(a4)
    80004608:	02d7b023          	sd	a3,32(a5)
            curr->nextSlab=cachep->usedSlabsHead;
    8000460c:	00853783          	ld	a5,8(a0)
    80004610:	02f73023          	sd	a5,32(a4)
            cachep->usedSlabsHead=curr;
    80004614:	00e53423          	sd	a4,8(a0)
    }
}
    80004618:	00813403          	ld	s0,8(sp)
    8000461c:	01010113          	addi	sp,sp,16
    80004620:	00008067          	ret

0000000080004624 <_Z7kmallocm>:

// Alloacate one small memory buffer
void *kmalloc(unsigned long size)
{
    80004624:	ff010113          	addi	sp,sp,-16
    80004628:	00113423          	sd	ra,8(sp)
    8000462c:	00813023          	sd	s0,0(sp)
    80004630:	01010413          	addi	s0,sp,16
    return bba_allocate(size);
    80004634:	ffffd097          	auipc	ra,0xffffd
    80004638:	3ec080e7          	jalr	1004(ra) # 80001a20 <_Z12bba_allocatem>
}
    8000463c:	00813083          	ld	ra,8(sp)
    80004640:	00013403          	ld	s0,0(sp)
    80004644:	01010113          	addi	sp,sp,16
    80004648:	00008067          	ret

000000008000464c <_Z5kfreePKv>:

// Deallocate one small memory buffer
void kfree(const void *objp)
{
    8000464c:	ff010113          	addi	sp,sp,-16
    80004650:	00113423          	sd	ra,8(sp)
    80004654:	00813023          	sd	s0,0(sp)
    80004658:	01010413          	addi	s0,sp,16
    bba_free_block(objp);
    8000465c:	ffffd097          	auipc	ra,0xffffd
    80004660:	68c080e7          	jalr	1676(ra) # 80001ce8 <_Z14bba_free_blockPKv>
}
    80004664:	00813083          	ld	ra,8(sp)
    80004668:	00013403          	ld	s0,0(sp)
    8000466c:	01010113          	addi	sp,sp,16
    80004670:	00008067          	ret

0000000080004674 <_Z17kmem_destroy_listP12kmem_cache_sP11kmem_slab_s>:

void kmem_destroy_list(kmem_cache_t* cachep,kmem_slab_t* head){
    if(head==0) return;
    80004674:	08058e63          	beqz	a1,80004710 <_Z17kmem_destroy_listP12kmem_cache_sP11kmem_slab_s+0x9c>
void kmem_destroy_list(kmem_cache_t* cachep,kmem_slab_t* head){
    80004678:	fd010113          	addi	sp,sp,-48
    8000467c:	02113423          	sd	ra,40(sp)
    80004680:	02813023          	sd	s0,32(sp)
    80004684:	00913c23          	sd	s1,24(sp)
    80004688:	01213823          	sd	s2,16(sp)
    8000468c:	01313423          	sd	s3,8(sp)
    80004690:	03010413          	addi	s0,sp,48
    80004694:	00050993          	mv	s3,a0
    80004698:	00058493          	mv	s1,a1
    kmem_slab_t *curr = head->nextSlab;
    8000469c:	0205b903          	ld	s2,32(a1)
    kmem_slab_t * prev = head;
    800046a0:	0440006f          	j	800046e4 <_Z17kmem_destroy_listP12kmem_cache_sP11kmem_slab_s+0x70>
    800046a4:	00090793          	mv	a5,s2
    800046a8:	0340006f          	j	800046dc <_Z17kmem_destroy_listP12kmem_cache_sP11kmem_slab_s+0x68>
    while (prev!=0){
        if(cachep->dtor!=0) kmem_slab_destoy_objects(prev,cachep);
    800046ac:	00098593          	mv	a1,s3
    800046b0:	00048513          	mv	a0,s1
    800046b4:	00000097          	auipc	ra,0x0
    800046b8:	830080e7          	jalr	-2000(ra) # 80003ee4 <_Z24kmem_slab_destoy_objectsP11kmem_slab_sP12kmem_cache_s>
        bba_free_block(prev->memory);
    800046bc:	0084b503          	ld	a0,8(s1)
    800046c0:	ffffd097          	auipc	ra,0xffffd
    800046c4:	628080e7          	jalr	1576(ra) # 80001ce8 <_Z14bba_free_blockPKv>
        bba_free_block(prev);
    800046c8:	00048513          	mv	a0,s1
    800046cc:	ffffd097          	auipc	ra,0xffffd
    800046d0:	61c080e7          	jalr	1564(ra) # 80001ce8 <_Z14bba_free_blockPKv>
        prev=curr;
        if(curr!=0) curr=curr->nextSlab;
    800046d4:	fc0908e3          	beqz	s2,800046a4 <_Z17kmem_destroy_listP12kmem_cache_sP11kmem_slab_s+0x30>
    800046d8:	02093783          	ld	a5,32(s2)
    800046dc:	00090493          	mv	s1,s2
    800046e0:	00078913          	mv	s2,a5
    while (prev!=0){
    800046e4:	00048863          	beqz	s1,800046f4 <_Z17kmem_destroy_listP12kmem_cache_sP11kmem_slab_s+0x80>
        if(cachep->dtor!=0) kmem_slab_destoy_objects(prev,cachep);
    800046e8:	0309b783          	ld	a5,48(s3)
    800046ec:	fc0790e3          	bnez	a5,800046ac <_Z17kmem_destroy_listP12kmem_cache_sP11kmem_slab_s+0x38>
    800046f0:	fcdff06f          	j	800046bc <_Z17kmem_destroy_listP12kmem_cache_sP11kmem_slab_s+0x48>
    }
}
    800046f4:	02813083          	ld	ra,40(sp)
    800046f8:	02013403          	ld	s0,32(sp)
    800046fc:	01813483          	ld	s1,24(sp)
    80004700:	01013903          	ld	s2,16(sp)
    80004704:	00813983          	ld	s3,8(sp)
    80004708:	03010113          	addi	sp,sp,48
    8000470c:	00008067          	ret
    80004710:	00008067          	ret

0000000080004714 <_Z18kmem_cache_destroyP12kmem_cache_s>:

// Deallocate cache
void kmem_cache_destroy(kmem_cache_t *cachep)
{
    80004714:	fe010113          	addi	sp,sp,-32
    80004718:	00113c23          	sd	ra,24(sp)
    8000471c:	00813823          	sd	s0,16(sp)
    80004720:	00913423          	sd	s1,8(sp)
    80004724:	02010413          	addi	s0,sp,32
    80004728:	00050493          	mv	s1,a0
    kmem_destroy_list(cachep,cachep->usedSlabsHead);
    8000472c:	00853583          	ld	a1,8(a0)
    80004730:	00000097          	auipc	ra,0x0
    80004734:	f44080e7          	jalr	-188(ra) # 80004674 <_Z17kmem_destroy_listP12kmem_cache_sP11kmem_slab_s>
    kmem_destroy_list(cachep,cachep->emptySlabsHead);
    80004738:	0004b583          	ld	a1,0(s1)
    8000473c:	00048513          	mv	a0,s1
    80004740:	00000097          	auipc	ra,0x0
    80004744:	f34080e7          	jalr	-204(ra) # 80004674 <_Z17kmem_destroy_listP12kmem_cache_sP11kmem_slab_s>
    kmem_destroy_list(cachep,cachep->fullSlabsHead);
    80004748:	0104b583          	ld	a1,16(s1)
    8000474c:	00048513          	mv	a0,s1
    80004750:	00000097          	auipc	ra,0x0
    80004754:	f24080e7          	jalr	-220(ra) # 80004674 <_Z17kmem_destroy_listP12kmem_cache_sP11kmem_slab_s>
    bba_free_block(cachep);
    80004758:	00048513          	mv	a0,s1
    8000475c:	ffffd097          	auipc	ra,0xffffd
    80004760:	58c080e7          	jalr	1420(ra) # 80001ce8 <_Z14bba_free_blockPKv>
}
    80004764:	01813083          	ld	ra,24(sp)
    80004768:	01013403          	ld	s0,16(sp)
    8000476c:	00813483          	ld	s1,8(sp)
    80004770:	02010113          	addi	sp,sp,32
    80004774:	00008067          	ret

0000000080004778 <_Z15kmem_cache_infoP12kmem_cache_s>:
{
    printf("\n Slab at addr %lx, %d used slots, %d initialized slots",  slab->memory, slab->usedSlotsCount, slab->initializedSlotsCount);
}
// Print cache info
void kmem_cache_info(kmem_cache_t *cachep)
{
    80004778:	fc010113          	addi	sp,sp,-64
    8000477c:	02113c23          	sd	ra,56(sp)
    80004780:	02813823          	sd	s0,48(sp)
    80004784:	02913423          	sd	s1,40(sp)
    80004788:	03213023          	sd	s2,32(sp)
    8000478c:	01313c23          	sd	s3,24(sp)
    80004790:	01413823          	sd	s4,16(sp)
    80004794:	01513423          	sd	s5,8(sp)
    80004798:	04010413          	addi	s0,sp,64
    8000479c:	00050a93          	mv	s5,a0
    int initObjCount=0, usedObjCount=0, slabsCount=0;
    printf("\n Cache '%s' has %d slots of size %d in each slab",cachep->name, cachep->slotsInSlab, cachep->slotSize);
    800047a0:	02053683          	ld	a3,32(a0)
    800047a4:	05052603          	lw	a2,80(a0)
    800047a8:	03850593          	addi	a1,a0,56
    800047ac:	00006517          	auipc	a0,0x6
    800047b0:	b1c50513          	addi	a0,a0,-1252 # 8000a2c8 <CONSOLE_STATUS+0x2b8>
    800047b4:	ffffe097          	auipc	ra,0xffffe
    800047b8:	a8c080e7          	jalr	-1396(ra) # 80002240 <_Z6printfPKcz>
    printf("\n Empty slabs:");
    800047bc:	00006517          	auipc	a0,0x6
    800047c0:	b4450513          	addi	a0,a0,-1212 # 8000a300 <CONSOLE_STATUS+0x2f0>
    800047c4:	ffffe097          	auipc	ra,0xffffe
    800047c8:	a7c080e7          	jalr	-1412(ra) # 80002240 <_Z6printfPKcz>
    kmem_slab_t * curr = cachep->emptySlabsHead;
    800047cc:	000ab483          	ld	s1,0(s5)
    int initObjCount=0, usedObjCount=0, slabsCount=0;
    800047d0:	00000a13          	li	s4,0
    800047d4:	00000913          	li	s2,0
    800047d8:	00000993          	li	s3,0
    while (curr!=0){
    800047dc:	02048e63          	beqz	s1,80004818 <_Z15kmem_cache_infoP12kmem_cache_s+0xa0>
    printf("\n Slab at addr %lx, %d used slots, %d initialized slots",  slab->memory, slab->usedSlotsCount, slab->initializedSlotsCount);
    800047e0:	0044a683          	lw	a3,4(s1)
    800047e4:	0004a603          	lw	a2,0(s1)
    800047e8:	0084b583          	ld	a1,8(s1)
    800047ec:	00006517          	auipc	a0,0x6
    800047f0:	b2450513          	addi	a0,a0,-1244 # 8000a310 <CONSOLE_STATUS+0x300>
    800047f4:	ffffe097          	auipc	ra,0xffffe
    800047f8:	a4c080e7          	jalr	-1460(ra) # 80002240 <_Z6printfPKcz>
        kmem_slab_info(curr);
        slabsCount++;
    800047fc:	001a0a1b          	addiw	s4,s4,1
        initObjCount+=curr->initializedSlotsCount;
    80004800:	0044a783          	lw	a5,4(s1)
    80004804:	013789bb          	addw	s3,a5,s3
        usedObjCount+=curr->usedSlotsCount;
    80004808:	0004a783          	lw	a5,0(s1)
    8000480c:	0127893b          	addw	s2,a5,s2
        curr=curr->nextSlab;
    80004810:	0204b483          	ld	s1,32(s1)
    while (curr!=0){
    80004814:	fc9ff06f          	j	800047dc <_Z15kmem_cache_infoP12kmem_cache_s+0x64>
    }
    printf("\n Full slabs:");
    80004818:	00006517          	auipc	a0,0x6
    8000481c:	b3050513          	addi	a0,a0,-1232 # 8000a348 <CONSOLE_STATUS+0x338>
    80004820:	ffffe097          	auipc	ra,0xffffe
    80004824:	a20080e7          	jalr	-1504(ra) # 80002240 <_Z6printfPKcz>
    curr = cachep->fullSlabsHead;
    80004828:	010ab483          	ld	s1,16(s5)
    while (curr!=0){
    8000482c:	02048e63          	beqz	s1,80004868 <_Z15kmem_cache_infoP12kmem_cache_s+0xf0>
    printf("\n Slab at addr %lx, %d used slots, %d initialized slots",  slab->memory, slab->usedSlotsCount, slab->initializedSlotsCount);
    80004830:	0044a683          	lw	a3,4(s1)
    80004834:	0004a603          	lw	a2,0(s1)
    80004838:	0084b583          	ld	a1,8(s1)
    8000483c:	00006517          	auipc	a0,0x6
    80004840:	ad450513          	addi	a0,a0,-1324 # 8000a310 <CONSOLE_STATUS+0x300>
    80004844:	ffffe097          	auipc	ra,0xffffe
    80004848:	9fc080e7          	jalr	-1540(ra) # 80002240 <_Z6printfPKcz>
        kmem_slab_info(curr);
        slabsCount++;
    8000484c:	001a0a1b          	addiw	s4,s4,1
        initObjCount+=curr->initializedSlotsCount;
    80004850:	0044a783          	lw	a5,4(s1)
    80004854:	013789bb          	addw	s3,a5,s3
        usedObjCount+=curr->usedSlotsCount;
    80004858:	0004a783          	lw	a5,0(s1)
    8000485c:	0127893b          	addw	s2,a5,s2
        curr=curr->nextSlab;
    80004860:	0204b483          	ld	s1,32(s1)
    while (curr!=0){
    80004864:	fc9ff06f          	j	8000482c <_Z15kmem_cache_infoP12kmem_cache_s+0xb4>
    }
    printf("\n Partially full slabs:");
    80004868:	00006517          	auipc	a0,0x6
    8000486c:	af050513          	addi	a0,a0,-1296 # 8000a358 <CONSOLE_STATUS+0x348>
    80004870:	ffffe097          	auipc	ra,0xffffe
    80004874:	9d0080e7          	jalr	-1584(ra) # 80002240 <_Z6printfPKcz>
    curr = cachep->usedSlabsHead;
    80004878:	008ab483          	ld	s1,8(s5)
    while (curr!=0){
    8000487c:	02048e63          	beqz	s1,800048b8 <_Z15kmem_cache_infoP12kmem_cache_s+0x140>
    printf("\n Slab at addr %lx, %d used slots, %d initialized slots",  slab->memory, slab->usedSlotsCount, slab->initializedSlotsCount);
    80004880:	0044a683          	lw	a3,4(s1)
    80004884:	0004a603          	lw	a2,0(s1)
    80004888:	0084b583          	ld	a1,8(s1)
    8000488c:	00006517          	auipc	a0,0x6
    80004890:	a8450513          	addi	a0,a0,-1404 # 8000a310 <CONSOLE_STATUS+0x300>
    80004894:	ffffe097          	auipc	ra,0xffffe
    80004898:	9ac080e7          	jalr	-1620(ra) # 80002240 <_Z6printfPKcz>
        kmem_slab_info(curr);
        slabsCount++;
    8000489c:	001a0a1b          	addiw	s4,s4,1
        initObjCount+=curr->initializedSlotsCount;
    800048a0:	0044a783          	lw	a5,4(s1)
    800048a4:	013789bb          	addw	s3,a5,s3
        usedObjCount+=curr->usedSlotsCount;
    800048a8:	0004a783          	lw	a5,0(s1)
    800048ac:	0127893b          	addw	s2,a5,s2
        curr=curr->nextSlab;
    800048b0:	0204b483          	ld	s1,32(s1)
    while (curr!=0){
    800048b4:	fc9ff06f          	j	8000487c <_Z15kmem_cache_infoP12kmem_cache_s+0x104>
    }
    printf("\n Total slabs: %d, total used slots: %d, total initialized slots: %d", slabsCount, usedObjCount,initObjCount);
    800048b8:	00098693          	mv	a3,s3
    800048bc:	00090613          	mv	a2,s2
    800048c0:	000a0593          	mv	a1,s4
    800048c4:	00006517          	auipc	a0,0x6
    800048c8:	aac50513          	addi	a0,a0,-1364 # 8000a370 <CONSOLE_STATUS+0x360>
    800048cc:	ffffe097          	auipc	ra,0xffffe
    800048d0:	974080e7          	jalr	-1676(ra) # 80002240 <_Z6printfPKcz>
    printf("\n-------------------------", usedObjCount,initObjCount);
    800048d4:	00098613          	mv	a2,s3
    800048d8:	00090593          	mv	a1,s2
    800048dc:	00006517          	auipc	a0,0x6
    800048e0:	adc50513          	addi	a0,a0,-1316 # 8000a3b8 <CONSOLE_STATUS+0x3a8>
    800048e4:	ffffe097          	auipc	ra,0xffffe
    800048e8:	95c080e7          	jalr	-1700(ra) # 80002240 <_Z6printfPKcz>
}
    800048ec:	03813083          	ld	ra,56(sp)
    800048f0:	03013403          	ld	s0,48(sp)
    800048f4:	02813483          	ld	s1,40(sp)
    800048f8:	02013903          	ld	s2,32(sp)
    800048fc:	01813983          	ld	s3,24(sp)
    80004900:	01013a03          	ld	s4,16(sp)
    80004904:	00813a83          	ld	s5,8(sp)
    80004908:	04010113          	addi	sp,sp,64
    8000490c:	00008067          	ret

0000000080004910 <_ZL16producerKeyboardPv>:
    sem_t wait;
};

static volatile int threadEnd = 0;

static void producerKeyboard(void *arg) {
    80004910:	fe010113          	addi	sp,sp,-32
    80004914:	00113c23          	sd	ra,24(sp)
    80004918:	00813823          	sd	s0,16(sp)
    8000491c:	00913423          	sd	s1,8(sp)
    80004920:	01213023          	sd	s2,0(sp)
    80004924:	02010413          	addi	s0,sp,32
    80004928:	00050493          	mv	s1,a0
    struct thread_data *data = (struct thread_data *) arg;

    int key;
    int i = 0;
    8000492c:	00000913          	li	s2,0
    80004930:	00c0006f          	j	8000493c <_ZL16producerKeyboardPv+0x2c>
    while ((key = getc()) != 13) {
        data->buffer->put(key);
        i++;

        if (i % (10 * data->id) == 0) {
            thread_dispatch();
    80004934:	ffffd097          	auipc	ra,0xffffd
    80004938:	a54080e7          	jalr	-1452(ra) # 80001388 <_Z15thread_dispatchv>
    while ((key = getc()) != 13) {
    8000493c:	ffffd097          	auipc	ra,0xffffd
    80004940:	c38080e7          	jalr	-968(ra) # 80001574 <_Z4getcv>
    80004944:	0005059b          	sext.w	a1,a0
    80004948:	00d00793          	li	a5,13
    8000494c:	02f58a63          	beq	a1,a5,80004980 <_ZL16producerKeyboardPv+0x70>
        data->buffer->put(key);
    80004950:	0084b503          	ld	a0,8(s1)
    80004954:	00003097          	auipc	ra,0x3
    80004958:	ec8080e7          	jalr	-312(ra) # 8000781c <_ZN6Buffer3putEi>
        i++;
    8000495c:	0019071b          	addiw	a4,s2,1
    80004960:	0007091b          	sext.w	s2,a4
        if (i % (10 * data->id) == 0) {
    80004964:	0004a683          	lw	a3,0(s1)
    80004968:	0026979b          	slliw	a5,a3,0x2
    8000496c:	00d787bb          	addw	a5,a5,a3
    80004970:	0017979b          	slliw	a5,a5,0x1
    80004974:	02f767bb          	remw	a5,a4,a5
    80004978:	fc0792e3          	bnez	a5,8000493c <_ZL16producerKeyboardPv+0x2c>
    8000497c:	fb9ff06f          	j	80004934 <_ZL16producerKeyboardPv+0x24>
        }
    }

    threadEnd = 1;
    80004980:	00100793          	li	a5,1
    80004984:	0000a717          	auipc	a4,0xa
    80004988:	0ef72e23          	sw	a5,252(a4) # 8000ea80 <_ZL9threadEnd>
    data->buffer->put('!');
    8000498c:	02100593          	li	a1,33
    80004990:	0084b503          	ld	a0,8(s1)
    80004994:	00003097          	auipc	ra,0x3
    80004998:	e88080e7          	jalr	-376(ra) # 8000781c <_ZN6Buffer3putEi>

    sem_signal(data->wait);
    8000499c:	0104b503          	ld	a0,16(s1)
    800049a0:	ffffd097          	auipc	ra,0xffffd
    800049a4:	b60080e7          	jalr	-1184(ra) # 80001500 <_Z10sem_signalP5sem_s>
}
    800049a8:	01813083          	ld	ra,24(sp)
    800049ac:	01013403          	ld	s0,16(sp)
    800049b0:	00813483          	ld	s1,8(sp)
    800049b4:	00013903          	ld	s2,0(sp)
    800049b8:	02010113          	addi	sp,sp,32
    800049bc:	00008067          	ret

00000000800049c0 <_ZL8producerPv>:

static void producer(void *arg) {
    800049c0:	fe010113          	addi	sp,sp,-32
    800049c4:	00113c23          	sd	ra,24(sp)
    800049c8:	00813823          	sd	s0,16(sp)
    800049cc:	00913423          	sd	s1,8(sp)
    800049d0:	01213023          	sd	s2,0(sp)
    800049d4:	02010413          	addi	s0,sp,32
    800049d8:	00050493          	mv	s1,a0
    struct thread_data *data = (struct thread_data *) arg;

    int i = 0;
    800049dc:	00000913          	li	s2,0
    800049e0:	00c0006f          	j	800049ec <_ZL8producerPv+0x2c>
    while (!threadEnd) {
        data->buffer->put(data->id + '0');
        i++;

        if (i % (10 * data->id) == 0) {
            thread_dispatch();
    800049e4:	ffffd097          	auipc	ra,0xffffd
    800049e8:	9a4080e7          	jalr	-1628(ra) # 80001388 <_Z15thread_dispatchv>
    while (!threadEnd) {
    800049ec:	0000a797          	auipc	a5,0xa
    800049f0:	0947a783          	lw	a5,148(a5) # 8000ea80 <_ZL9threadEnd>
    800049f4:	02079e63          	bnez	a5,80004a30 <_ZL8producerPv+0x70>
        data->buffer->put(data->id + '0');
    800049f8:	0004a583          	lw	a1,0(s1)
    800049fc:	0305859b          	addiw	a1,a1,48
    80004a00:	0084b503          	ld	a0,8(s1)
    80004a04:	00003097          	auipc	ra,0x3
    80004a08:	e18080e7          	jalr	-488(ra) # 8000781c <_ZN6Buffer3putEi>
        i++;
    80004a0c:	0019071b          	addiw	a4,s2,1
    80004a10:	0007091b          	sext.w	s2,a4
        if (i % (10 * data->id) == 0) {
    80004a14:	0004a683          	lw	a3,0(s1)
    80004a18:	0026979b          	slliw	a5,a3,0x2
    80004a1c:	00d787bb          	addw	a5,a5,a3
    80004a20:	0017979b          	slliw	a5,a5,0x1
    80004a24:	02f767bb          	remw	a5,a4,a5
    80004a28:	fc0792e3          	bnez	a5,800049ec <_ZL8producerPv+0x2c>
    80004a2c:	fb9ff06f          	j	800049e4 <_ZL8producerPv+0x24>
        }
    }

    sem_signal(data->wait);
    80004a30:	0104b503          	ld	a0,16(s1)
    80004a34:	ffffd097          	auipc	ra,0xffffd
    80004a38:	acc080e7          	jalr	-1332(ra) # 80001500 <_Z10sem_signalP5sem_s>
}
    80004a3c:	01813083          	ld	ra,24(sp)
    80004a40:	01013403          	ld	s0,16(sp)
    80004a44:	00813483          	ld	s1,8(sp)
    80004a48:	00013903          	ld	s2,0(sp)
    80004a4c:	02010113          	addi	sp,sp,32
    80004a50:	00008067          	ret

0000000080004a54 <_ZL8consumerPv>:

static void consumer(void *arg) {
    80004a54:	fd010113          	addi	sp,sp,-48
    80004a58:	02113423          	sd	ra,40(sp)
    80004a5c:	02813023          	sd	s0,32(sp)
    80004a60:	00913c23          	sd	s1,24(sp)
    80004a64:	01213823          	sd	s2,16(sp)
    80004a68:	01313423          	sd	s3,8(sp)
    80004a6c:	03010413          	addi	s0,sp,48
    80004a70:	00050913          	mv	s2,a0
    struct thread_data *data = (struct thread_data *) arg;

    int i = 0;
    80004a74:	00000993          	li	s3,0
    80004a78:	01c0006f          	j	80004a94 <_ZL8consumerPv+0x40>
        i++;

        putc(key);

        if (i % (5 * data->id) == 0) {
            thread_dispatch();
    80004a7c:	ffffd097          	auipc	ra,0xffffd
    80004a80:	90c080e7          	jalr	-1780(ra) # 80001388 <_Z15thread_dispatchv>
    80004a84:	0500006f          	j	80004ad4 <_ZL8consumerPv+0x80>
        }

        if (i % 80 == 0) {
            putc('\n');
    80004a88:	00a00513          	li	a0,10
    80004a8c:	ffffd097          	auipc	ra,0xffffd
    80004a90:	b24080e7          	jalr	-1244(ra) # 800015b0 <_Z4putcc>
    while (!threadEnd) {
    80004a94:	0000a797          	auipc	a5,0xa
    80004a98:	fec7a783          	lw	a5,-20(a5) # 8000ea80 <_ZL9threadEnd>
    80004a9c:	06079063          	bnez	a5,80004afc <_ZL8consumerPv+0xa8>
        int key = data->buffer->get();
    80004aa0:	00893503          	ld	a0,8(s2)
    80004aa4:	00003097          	auipc	ra,0x3
    80004aa8:	e08080e7          	jalr	-504(ra) # 800078ac <_ZN6Buffer3getEv>
        i++;
    80004aac:	0019849b          	addiw	s1,s3,1
    80004ab0:	0004899b          	sext.w	s3,s1
        putc(key);
    80004ab4:	0ff57513          	andi	a0,a0,255
    80004ab8:	ffffd097          	auipc	ra,0xffffd
    80004abc:	af8080e7          	jalr	-1288(ra) # 800015b0 <_Z4putcc>
        if (i % (5 * data->id) == 0) {
    80004ac0:	00092703          	lw	a4,0(s2)
    80004ac4:	0027179b          	slliw	a5,a4,0x2
    80004ac8:	00e787bb          	addw	a5,a5,a4
    80004acc:	02f4e7bb          	remw	a5,s1,a5
    80004ad0:	fa0786e3          	beqz	a5,80004a7c <_ZL8consumerPv+0x28>
        if (i % 80 == 0) {
    80004ad4:	05000793          	li	a5,80
    80004ad8:	02f4e4bb          	remw	s1,s1,a5
    80004adc:	fa049ce3          	bnez	s1,80004a94 <_ZL8consumerPv+0x40>
    80004ae0:	fa9ff06f          	j	80004a88 <_ZL8consumerPv+0x34>
        }
    }

    while (data->buffer->getCnt() > 0) {
        int key = data->buffer->get();
    80004ae4:	00893503          	ld	a0,8(s2)
    80004ae8:	00003097          	auipc	ra,0x3
    80004aec:	dc4080e7          	jalr	-572(ra) # 800078ac <_ZN6Buffer3getEv>
        putc(key);
    80004af0:	0ff57513          	andi	a0,a0,255
    80004af4:	ffffd097          	auipc	ra,0xffffd
    80004af8:	abc080e7          	jalr	-1348(ra) # 800015b0 <_Z4putcc>
    while (data->buffer->getCnt() > 0) {
    80004afc:	00893503          	ld	a0,8(s2)
    80004b00:	00003097          	auipc	ra,0x3
    80004b04:	e38080e7          	jalr	-456(ra) # 80007938 <_ZN6Buffer6getCntEv>
    80004b08:	fca04ee3          	bgtz	a0,80004ae4 <_ZL8consumerPv+0x90>
    }

    sem_signal(data->wait);
    80004b0c:	01093503          	ld	a0,16(s2)
    80004b10:	ffffd097          	auipc	ra,0xffffd
    80004b14:	9f0080e7          	jalr	-1552(ra) # 80001500 <_Z10sem_signalP5sem_s>
}
    80004b18:	02813083          	ld	ra,40(sp)
    80004b1c:	02013403          	ld	s0,32(sp)
    80004b20:	01813483          	ld	s1,24(sp)
    80004b24:	01013903          	ld	s2,16(sp)
    80004b28:	00813983          	ld	s3,8(sp)
    80004b2c:	03010113          	addi	sp,sp,48
    80004b30:	00008067          	ret

0000000080004b34 <_Z22producerConsumer_C_APIv>:

void producerConsumer_C_API() {
    80004b34:	f9010113          	addi	sp,sp,-112
    80004b38:	06113423          	sd	ra,104(sp)
    80004b3c:	06813023          	sd	s0,96(sp)
    80004b40:	04913c23          	sd	s1,88(sp)
    80004b44:	05213823          	sd	s2,80(sp)
    80004b48:	05313423          	sd	s3,72(sp)
    80004b4c:	05413023          	sd	s4,64(sp)
    80004b50:	03513c23          	sd	s5,56(sp)
    80004b54:	03613823          	sd	s6,48(sp)
    80004b58:	07010413          	addi	s0,sp,112
        sem_wait(waitForAll);
    }

    sem_close(waitForAll);

    delete buffer;
    80004b5c:	00010b13          	mv	s6,sp
    printString("Unesite broj proizvodjaca?\n");
    80004b60:	00006517          	auipc	a0,0x6
    80004b64:	87850513          	addi	a0,a0,-1928 # 8000a3d8 <CONSOLE_STATUS+0x3c8>
    80004b68:	ffffd097          	auipc	ra,0xffffd
    80004b6c:	344080e7          	jalr	836(ra) # 80001eac <_Z11printStringPKc>
    getString(input, 30);
    80004b70:	01e00593          	li	a1,30
    80004b74:	fa040493          	addi	s1,s0,-96
    80004b78:	00048513          	mv	a0,s1
    80004b7c:	ffffd097          	auipc	ra,0xffffd
    80004b80:	3b8080e7          	jalr	952(ra) # 80001f34 <_Z9getStringPci>
    threadNum = stringToInt(input);
    80004b84:	00048513          	mv	a0,s1
    80004b88:	ffffd097          	auipc	ra,0xffffd
    80004b8c:	484080e7          	jalr	1156(ra) # 8000200c <_Z11stringToIntPKc>
    80004b90:	00050913          	mv	s2,a0
    printString("Unesite velicinu bafera?\n");
    80004b94:	00006517          	auipc	a0,0x6
    80004b98:	86450513          	addi	a0,a0,-1948 # 8000a3f8 <CONSOLE_STATUS+0x3e8>
    80004b9c:	ffffd097          	auipc	ra,0xffffd
    80004ba0:	310080e7          	jalr	784(ra) # 80001eac <_Z11printStringPKc>
    getString(input, 30);
    80004ba4:	01e00593          	li	a1,30
    80004ba8:	00048513          	mv	a0,s1
    80004bac:	ffffd097          	auipc	ra,0xffffd
    80004bb0:	388080e7          	jalr	904(ra) # 80001f34 <_Z9getStringPci>
    n = stringToInt(input);
    80004bb4:	00048513          	mv	a0,s1
    80004bb8:	ffffd097          	auipc	ra,0xffffd
    80004bbc:	454080e7          	jalr	1108(ra) # 8000200c <_Z11stringToIntPKc>
    80004bc0:	00050493          	mv	s1,a0
    printString("Broj proizvodjaca "); printInt(threadNum);
    80004bc4:	00006517          	auipc	a0,0x6
    80004bc8:	85450513          	addi	a0,a0,-1964 # 8000a418 <CONSOLE_STATUS+0x408>
    80004bcc:	ffffd097          	auipc	ra,0xffffd
    80004bd0:	2e0080e7          	jalr	736(ra) # 80001eac <_Z11printStringPKc>
    80004bd4:	00000613          	li	a2,0
    80004bd8:	00a00593          	li	a1,10
    80004bdc:	00090513          	mv	a0,s2
    80004be0:	ffffd097          	auipc	ra,0xffffd
    80004be4:	47c080e7          	jalr	1148(ra) # 8000205c <_Z8printIntiii>
    printString(" i velicina bafera "); printInt(n);
    80004be8:	00006517          	auipc	a0,0x6
    80004bec:	84850513          	addi	a0,a0,-1976 # 8000a430 <CONSOLE_STATUS+0x420>
    80004bf0:	ffffd097          	auipc	ra,0xffffd
    80004bf4:	2bc080e7          	jalr	700(ra) # 80001eac <_Z11printStringPKc>
    80004bf8:	00000613          	li	a2,0
    80004bfc:	00a00593          	li	a1,10
    80004c00:	00048513          	mv	a0,s1
    80004c04:	ffffd097          	auipc	ra,0xffffd
    80004c08:	458080e7          	jalr	1112(ra) # 8000205c <_Z8printIntiii>
    printString(".\n");
    80004c0c:	00006517          	auipc	a0,0x6
    80004c10:	83c50513          	addi	a0,a0,-1988 # 8000a448 <CONSOLE_STATUS+0x438>
    80004c14:	ffffd097          	auipc	ra,0xffffd
    80004c18:	298080e7          	jalr	664(ra) # 80001eac <_Z11printStringPKc>
    if(threadNum > n) {
    80004c1c:	0324c463          	blt	s1,s2,80004c44 <_Z22producerConsumer_C_APIv+0x110>
    } else if (threadNum < 1) {
    80004c20:	03205c63          	blez	s2,80004c58 <_Z22producerConsumer_C_APIv+0x124>
    Buffer *buffer = new Buffer(n);
    80004c24:	03800513          	li	a0,56
    80004c28:	ffffe097          	auipc	ra,0xffffe
    80004c2c:	2b4080e7          	jalr	692(ra) # 80002edc <_Znwm>
    80004c30:	00050a13          	mv	s4,a0
    80004c34:	00048593          	mv	a1,s1
    80004c38:	00003097          	auipc	ra,0x3
    80004c3c:	b48080e7          	jalr	-1208(ra) # 80007780 <_ZN6BufferC1Ei>
    80004c40:	0300006f          	j	80004c70 <_Z22producerConsumer_C_APIv+0x13c>
        printString("Broj proizvodjaca ne sme biti manji od velicine bafera!\n");
    80004c44:	00006517          	auipc	a0,0x6
    80004c48:	80c50513          	addi	a0,a0,-2036 # 8000a450 <CONSOLE_STATUS+0x440>
    80004c4c:	ffffd097          	auipc	ra,0xffffd
    80004c50:	260080e7          	jalr	608(ra) # 80001eac <_Z11printStringPKc>
        return;
    80004c54:	0140006f          	j	80004c68 <_Z22producerConsumer_C_APIv+0x134>
        printString("Broj proizvodjaca mora biti veci od nula!\n");
    80004c58:	00006517          	auipc	a0,0x6
    80004c5c:	83850513          	addi	a0,a0,-1992 # 8000a490 <CONSOLE_STATUS+0x480>
    80004c60:	ffffd097          	auipc	ra,0xffffd
    80004c64:	24c080e7          	jalr	588(ra) # 80001eac <_Z11printStringPKc>
        return;
    80004c68:	000b0113          	mv	sp,s6
    80004c6c:	1500006f          	j	80004dbc <_Z22producerConsumer_C_APIv+0x288>
    sem_open(&waitForAll, 0);
    80004c70:	00000593          	li	a1,0
    80004c74:	0000a517          	auipc	a0,0xa
    80004c78:	e1450513          	addi	a0,a0,-492 # 8000ea88 <_ZL10waitForAll>
    80004c7c:	ffffc097          	auipc	ra,0xffffc
    80004c80:	7c0080e7          	jalr	1984(ra) # 8000143c <_Z8sem_openPP5sem_sj>
    thread_t threads[threadNum];
    80004c84:	00391793          	slli	a5,s2,0x3
    80004c88:	00f78793          	addi	a5,a5,15
    80004c8c:	ff07f793          	andi	a5,a5,-16
    80004c90:	40f10133          	sub	sp,sp,a5
    80004c94:	00010a93          	mv	s5,sp
    struct thread_data data[threadNum + 1];
    80004c98:	0019071b          	addiw	a4,s2,1
    80004c9c:	00171793          	slli	a5,a4,0x1
    80004ca0:	00e787b3          	add	a5,a5,a4
    80004ca4:	00379793          	slli	a5,a5,0x3
    80004ca8:	00f78793          	addi	a5,a5,15
    80004cac:	ff07f793          	andi	a5,a5,-16
    80004cb0:	40f10133          	sub	sp,sp,a5
    80004cb4:	00010993          	mv	s3,sp
    data[threadNum].id = threadNum;
    80004cb8:	00191613          	slli	a2,s2,0x1
    80004cbc:	012607b3          	add	a5,a2,s2
    80004cc0:	00379793          	slli	a5,a5,0x3
    80004cc4:	00f987b3          	add	a5,s3,a5
    80004cc8:	0127a023          	sw	s2,0(a5)
    data[threadNum].buffer = buffer;
    80004ccc:	0147b423          	sd	s4,8(a5)
    data[threadNum].wait = waitForAll;
    80004cd0:	0000a717          	auipc	a4,0xa
    80004cd4:	db873703          	ld	a4,-584(a4) # 8000ea88 <_ZL10waitForAll>
    80004cd8:	00e7b823          	sd	a4,16(a5)
    thread_create(&consumerThread, consumer, data + threadNum);
    80004cdc:	00078613          	mv	a2,a5
    80004ce0:	00000597          	auipc	a1,0x0
    80004ce4:	d7458593          	addi	a1,a1,-652 # 80004a54 <_ZL8consumerPv>
    80004ce8:	f9840513          	addi	a0,s0,-104
    80004cec:	ffffc097          	auipc	ra,0xffffc
    80004cf0:	614080e7          	jalr	1556(ra) # 80001300 <_Z13thread_createPP8thread_sPFvPvES2_>
    for (int i = 0; i < threadNum; i++) {
    80004cf4:	00000493          	li	s1,0
    80004cf8:	0280006f          	j	80004d20 <_Z22producerConsumer_C_APIv+0x1ec>
        thread_create(threads + i,
    80004cfc:	00000597          	auipc	a1,0x0
    80004d00:	c1458593          	addi	a1,a1,-1004 # 80004910 <_ZL16producerKeyboardPv>
                      data + i);
    80004d04:	00179613          	slli	a2,a5,0x1
    80004d08:	00f60633          	add	a2,a2,a5
    80004d0c:	00361613          	slli	a2,a2,0x3
        thread_create(threads + i,
    80004d10:	00c98633          	add	a2,s3,a2
    80004d14:	ffffc097          	auipc	ra,0xffffc
    80004d18:	5ec080e7          	jalr	1516(ra) # 80001300 <_Z13thread_createPP8thread_sPFvPvES2_>
    for (int i = 0; i < threadNum; i++) {
    80004d1c:	0014849b          	addiw	s1,s1,1
    80004d20:	0524d263          	bge	s1,s2,80004d64 <_Z22producerConsumer_C_APIv+0x230>
        data[i].id = i;
    80004d24:	00149793          	slli	a5,s1,0x1
    80004d28:	009787b3          	add	a5,a5,s1
    80004d2c:	00379793          	slli	a5,a5,0x3
    80004d30:	00f987b3          	add	a5,s3,a5
    80004d34:	0097a023          	sw	s1,0(a5)
        data[i].buffer = buffer;
    80004d38:	0147b423          	sd	s4,8(a5)
        data[i].wait = waitForAll;
    80004d3c:	0000a717          	auipc	a4,0xa
    80004d40:	d4c73703          	ld	a4,-692(a4) # 8000ea88 <_ZL10waitForAll>
    80004d44:	00e7b823          	sd	a4,16(a5)
        thread_create(threads + i,
    80004d48:	00048793          	mv	a5,s1
    80004d4c:	00349513          	slli	a0,s1,0x3
    80004d50:	00aa8533          	add	a0,s5,a0
    80004d54:	fa9054e3          	blez	s1,80004cfc <_Z22producerConsumer_C_APIv+0x1c8>
    80004d58:	00000597          	auipc	a1,0x0
    80004d5c:	c6858593          	addi	a1,a1,-920 # 800049c0 <_ZL8producerPv>
    80004d60:	fa5ff06f          	j	80004d04 <_Z22producerConsumer_C_APIv+0x1d0>
    thread_dispatch();
    80004d64:	ffffc097          	auipc	ra,0xffffc
    80004d68:	624080e7          	jalr	1572(ra) # 80001388 <_Z15thread_dispatchv>
    for (int i = 0; i <= threadNum; i++) {
    80004d6c:	00000493          	li	s1,0
    80004d70:	00994e63          	blt	s2,s1,80004d8c <_Z22producerConsumer_C_APIv+0x258>
        sem_wait(waitForAll);
    80004d74:	0000a517          	auipc	a0,0xa
    80004d78:	d1453503          	ld	a0,-748(a0) # 8000ea88 <_ZL10waitForAll>
    80004d7c:	ffffc097          	auipc	ra,0xffffc
    80004d80:	744080e7          	jalr	1860(ra) # 800014c0 <_Z8sem_waitP5sem_s>
    for (int i = 0; i <= threadNum; i++) {
    80004d84:	0014849b          	addiw	s1,s1,1
    80004d88:	fe9ff06f          	j	80004d70 <_Z22producerConsumer_C_APIv+0x23c>
    sem_close(waitForAll);
    80004d8c:	0000a517          	auipc	a0,0xa
    80004d90:	cfc53503          	ld	a0,-772(a0) # 8000ea88 <_ZL10waitForAll>
    80004d94:	ffffc097          	auipc	ra,0xffffc
    80004d98:	6ec080e7          	jalr	1772(ra) # 80001480 <_Z9sem_closeP5sem_s>
    delete buffer;
    80004d9c:	000a0e63          	beqz	s4,80004db8 <_Z22producerConsumer_C_APIv+0x284>
    80004da0:	000a0513          	mv	a0,s4
    80004da4:	00003097          	auipc	ra,0x3
    80004da8:	c1c080e7          	jalr	-996(ra) # 800079c0 <_ZN6BufferD1Ev>
    80004dac:	000a0513          	mv	a0,s4
    80004db0:	ffffe097          	auipc	ra,0xffffe
    80004db4:	154080e7          	jalr	340(ra) # 80002f04 <_ZdlPv>
    80004db8:	000b0113          	mv	sp,s6

}
    80004dbc:	f9040113          	addi	sp,s0,-112
    80004dc0:	06813083          	ld	ra,104(sp)
    80004dc4:	06013403          	ld	s0,96(sp)
    80004dc8:	05813483          	ld	s1,88(sp)
    80004dcc:	05013903          	ld	s2,80(sp)
    80004dd0:	04813983          	ld	s3,72(sp)
    80004dd4:	04013a03          	ld	s4,64(sp)
    80004dd8:	03813a83          	ld	s5,56(sp)
    80004ddc:	03013b03          	ld	s6,48(sp)
    80004de0:	07010113          	addi	sp,sp,112
    80004de4:	00008067          	ret
    80004de8:	00050493          	mv	s1,a0
    Buffer *buffer = new Buffer(n);
    80004dec:	000a0513          	mv	a0,s4
    80004df0:	ffffe097          	auipc	ra,0xffffe
    80004df4:	114080e7          	jalr	276(ra) # 80002f04 <_ZdlPv>
    80004df8:	00048513          	mv	a0,s1
    80004dfc:	0000b097          	auipc	ra,0xb
    80004e00:	d9c080e7          	jalr	-612(ra) # 8000fb98 <_Unwind_Resume>

0000000080004e04 <_ZL9fibonaccim>:
static volatile bool finishedA = false;
static volatile bool finishedB = false;
static volatile bool finishedC = false;
static volatile bool finishedD = false;

static uint64 fibonacci(uint64 n) {
    80004e04:	fe010113          	addi	sp,sp,-32
    80004e08:	00113c23          	sd	ra,24(sp)
    80004e0c:	00813823          	sd	s0,16(sp)
    80004e10:	00913423          	sd	s1,8(sp)
    80004e14:	01213023          	sd	s2,0(sp)
    80004e18:	02010413          	addi	s0,sp,32
    80004e1c:	00050493          	mv	s1,a0
    if (n == 0 || n == 1) { return n; }
    80004e20:	00100793          	li	a5,1
    80004e24:	02a7f863          	bgeu	a5,a0,80004e54 <_ZL9fibonaccim+0x50>
    if (n % 10 == 0) { thread_dispatch(); }
    80004e28:	00a00793          	li	a5,10
    80004e2c:	02f577b3          	remu	a5,a0,a5
    80004e30:	02078e63          	beqz	a5,80004e6c <_ZL9fibonaccim+0x68>
    return fibonacci(n - 1) + fibonacci(n - 2);
    80004e34:	fff48513          	addi	a0,s1,-1
    80004e38:	00000097          	auipc	ra,0x0
    80004e3c:	fcc080e7          	jalr	-52(ra) # 80004e04 <_ZL9fibonaccim>
    80004e40:	00050913          	mv	s2,a0
    80004e44:	ffe48513          	addi	a0,s1,-2
    80004e48:	00000097          	auipc	ra,0x0
    80004e4c:	fbc080e7          	jalr	-68(ra) # 80004e04 <_ZL9fibonaccim>
    80004e50:	00a90533          	add	a0,s2,a0
}
    80004e54:	01813083          	ld	ra,24(sp)
    80004e58:	01013403          	ld	s0,16(sp)
    80004e5c:	00813483          	ld	s1,8(sp)
    80004e60:	00013903          	ld	s2,0(sp)
    80004e64:	02010113          	addi	sp,sp,32
    80004e68:	00008067          	ret
    if (n % 10 == 0) { thread_dispatch(); }
    80004e6c:	ffffc097          	auipc	ra,0xffffc
    80004e70:	51c080e7          	jalr	1308(ra) # 80001388 <_Z15thread_dispatchv>
    80004e74:	fc1ff06f          	j	80004e34 <_ZL9fibonaccim+0x30>

0000000080004e78 <_ZN7WorkerA11workerBodyAEPv>:
    void run() override {
        workerBodyD(nullptr);
    }
};

void WorkerA::workerBodyA(void *arg) {
    80004e78:	fe010113          	addi	sp,sp,-32
    80004e7c:	00113c23          	sd	ra,24(sp)
    80004e80:	00813823          	sd	s0,16(sp)
    80004e84:	00913423          	sd	s1,8(sp)
    80004e88:	01213023          	sd	s2,0(sp)
    80004e8c:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 10; i++) {
    80004e90:	00000913          	li	s2,0
    80004e94:	0380006f          	j	80004ecc <_ZN7WorkerA11workerBodyAEPv+0x54>
        printString("A: i="); printInt(i); printString("\n");
        for (uint64 j = 0; j < 10000; j++) {
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
            thread_dispatch();
    80004e98:	ffffc097          	auipc	ra,0xffffc
    80004e9c:	4f0080e7          	jalr	1264(ra) # 80001388 <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++) {
    80004ea0:	00148493          	addi	s1,s1,1
    80004ea4:	000027b7          	lui	a5,0x2
    80004ea8:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    80004eac:	0097ee63          	bltu	a5,s1,80004ec8 <_ZN7WorkerA11workerBodyAEPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    80004eb0:	00000713          	li	a4,0
    80004eb4:	000077b7          	lui	a5,0x7
    80004eb8:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    80004ebc:	fce7eee3          	bltu	a5,a4,80004e98 <_ZN7WorkerA11workerBodyAEPv+0x20>
    80004ec0:	00170713          	addi	a4,a4,1
    80004ec4:	ff1ff06f          	j	80004eb4 <_ZN7WorkerA11workerBodyAEPv+0x3c>
    for (uint64 i = 0; i < 10; i++) {
    80004ec8:	00190913          	addi	s2,s2,1
    80004ecc:	00900793          	li	a5,9
    80004ed0:	0527e063          	bltu	a5,s2,80004f10 <_ZN7WorkerA11workerBodyAEPv+0x98>
        printString("A: i="); printInt(i); printString("\n");
    80004ed4:	00005517          	auipc	a0,0x5
    80004ed8:	5ec50513          	addi	a0,a0,1516 # 8000a4c0 <CONSOLE_STATUS+0x4b0>
    80004edc:	ffffd097          	auipc	ra,0xffffd
    80004ee0:	fd0080e7          	jalr	-48(ra) # 80001eac <_Z11printStringPKc>
    80004ee4:	00000613          	li	a2,0
    80004ee8:	00a00593          	li	a1,10
    80004eec:	0009051b          	sext.w	a0,s2
    80004ef0:	ffffd097          	auipc	ra,0xffffd
    80004ef4:	16c080e7          	jalr	364(ra) # 8000205c <_Z8printIntiii>
    80004ef8:	00006517          	auipc	a0,0x6
    80004efc:	81850513          	addi	a0,a0,-2024 # 8000a710 <CONSOLE_STATUS+0x700>
    80004f00:	ffffd097          	auipc	ra,0xffffd
    80004f04:	fac080e7          	jalr	-84(ra) # 80001eac <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    80004f08:	00000493          	li	s1,0
    80004f0c:	f99ff06f          	j	80004ea4 <_ZN7WorkerA11workerBodyAEPv+0x2c>
        }
    }
    printString("A finished!\n");
    80004f10:	00005517          	auipc	a0,0x5
    80004f14:	5b850513          	addi	a0,a0,1464 # 8000a4c8 <CONSOLE_STATUS+0x4b8>
    80004f18:	ffffd097          	auipc	ra,0xffffd
    80004f1c:	f94080e7          	jalr	-108(ra) # 80001eac <_Z11printStringPKc>
    finishedA = true;
    80004f20:	00100793          	li	a5,1
    80004f24:	0000a717          	auipc	a4,0xa
    80004f28:	b6f70623          	sb	a5,-1172(a4) # 8000ea90 <_ZL9finishedA>
}
    80004f2c:	01813083          	ld	ra,24(sp)
    80004f30:	01013403          	ld	s0,16(sp)
    80004f34:	00813483          	ld	s1,8(sp)
    80004f38:	00013903          	ld	s2,0(sp)
    80004f3c:	02010113          	addi	sp,sp,32
    80004f40:	00008067          	ret

0000000080004f44 <_ZN7WorkerB11workerBodyBEPv>:

void WorkerB::workerBodyB(void *arg) {
    80004f44:	fe010113          	addi	sp,sp,-32
    80004f48:	00113c23          	sd	ra,24(sp)
    80004f4c:	00813823          	sd	s0,16(sp)
    80004f50:	00913423          	sd	s1,8(sp)
    80004f54:	01213023          	sd	s2,0(sp)
    80004f58:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 16; i++) {
    80004f5c:	00000913          	li	s2,0
    80004f60:	0380006f          	j	80004f98 <_ZN7WorkerB11workerBodyBEPv+0x54>
        printString("B: i="); printInt(i); printString("\n");
        for (uint64 j = 0; j < 10000; j++) {
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
            thread_dispatch();
    80004f64:	ffffc097          	auipc	ra,0xffffc
    80004f68:	424080e7          	jalr	1060(ra) # 80001388 <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++) {
    80004f6c:	00148493          	addi	s1,s1,1
    80004f70:	000027b7          	lui	a5,0x2
    80004f74:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    80004f78:	0097ee63          	bltu	a5,s1,80004f94 <_ZN7WorkerB11workerBodyBEPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    80004f7c:	00000713          	li	a4,0
    80004f80:	000077b7          	lui	a5,0x7
    80004f84:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    80004f88:	fce7eee3          	bltu	a5,a4,80004f64 <_ZN7WorkerB11workerBodyBEPv+0x20>
    80004f8c:	00170713          	addi	a4,a4,1
    80004f90:	ff1ff06f          	j	80004f80 <_ZN7WorkerB11workerBodyBEPv+0x3c>
    for (uint64 i = 0; i < 16; i++) {
    80004f94:	00190913          	addi	s2,s2,1
    80004f98:	00f00793          	li	a5,15
    80004f9c:	0527e063          	bltu	a5,s2,80004fdc <_ZN7WorkerB11workerBodyBEPv+0x98>
        printString("B: i="); printInt(i); printString("\n");
    80004fa0:	00005517          	auipc	a0,0x5
    80004fa4:	53850513          	addi	a0,a0,1336 # 8000a4d8 <CONSOLE_STATUS+0x4c8>
    80004fa8:	ffffd097          	auipc	ra,0xffffd
    80004fac:	f04080e7          	jalr	-252(ra) # 80001eac <_Z11printStringPKc>
    80004fb0:	00000613          	li	a2,0
    80004fb4:	00a00593          	li	a1,10
    80004fb8:	0009051b          	sext.w	a0,s2
    80004fbc:	ffffd097          	auipc	ra,0xffffd
    80004fc0:	0a0080e7          	jalr	160(ra) # 8000205c <_Z8printIntiii>
    80004fc4:	00005517          	auipc	a0,0x5
    80004fc8:	74c50513          	addi	a0,a0,1868 # 8000a710 <CONSOLE_STATUS+0x700>
    80004fcc:	ffffd097          	auipc	ra,0xffffd
    80004fd0:	ee0080e7          	jalr	-288(ra) # 80001eac <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    80004fd4:	00000493          	li	s1,0
    80004fd8:	f99ff06f          	j	80004f70 <_ZN7WorkerB11workerBodyBEPv+0x2c>
        }
    }
    printString("B finished!\n");
    80004fdc:	00005517          	auipc	a0,0x5
    80004fe0:	50450513          	addi	a0,a0,1284 # 8000a4e0 <CONSOLE_STATUS+0x4d0>
    80004fe4:	ffffd097          	auipc	ra,0xffffd
    80004fe8:	ec8080e7          	jalr	-312(ra) # 80001eac <_Z11printStringPKc>
    finishedB = true;
    80004fec:	00100793          	li	a5,1
    80004ff0:	0000a717          	auipc	a4,0xa
    80004ff4:	aaf700a3          	sb	a5,-1375(a4) # 8000ea91 <_ZL9finishedB>
    thread_dispatch();
    80004ff8:	ffffc097          	auipc	ra,0xffffc
    80004ffc:	390080e7          	jalr	912(ra) # 80001388 <_Z15thread_dispatchv>
}
    80005000:	01813083          	ld	ra,24(sp)
    80005004:	01013403          	ld	s0,16(sp)
    80005008:	00813483          	ld	s1,8(sp)
    8000500c:	00013903          	ld	s2,0(sp)
    80005010:	02010113          	addi	sp,sp,32
    80005014:	00008067          	ret

0000000080005018 <_ZN7WorkerC11workerBodyCEPv>:

void WorkerC::workerBodyC(void *arg) {
    80005018:	fe010113          	addi	sp,sp,-32
    8000501c:	00113c23          	sd	ra,24(sp)
    80005020:	00813823          	sd	s0,16(sp)
    80005024:	00913423          	sd	s1,8(sp)
    80005028:	01213023          	sd	s2,0(sp)
    8000502c:	02010413          	addi	s0,sp,32
    uint8 i = 0;
    80005030:	00000493          	li	s1,0
    80005034:	0400006f          	j	80005074 <_ZN7WorkerC11workerBodyCEPv+0x5c>
    for (; i < 3; i++) {
        printString("C: i="); printInt(i); printString("\n");
    80005038:	00005517          	auipc	a0,0x5
    8000503c:	4b850513          	addi	a0,a0,1208 # 8000a4f0 <CONSOLE_STATUS+0x4e0>
    80005040:	ffffd097          	auipc	ra,0xffffd
    80005044:	e6c080e7          	jalr	-404(ra) # 80001eac <_Z11printStringPKc>
    80005048:	00000613          	li	a2,0
    8000504c:	00a00593          	li	a1,10
    80005050:	00048513          	mv	a0,s1
    80005054:	ffffd097          	auipc	ra,0xffffd
    80005058:	008080e7          	jalr	8(ra) # 8000205c <_Z8printIntiii>
    8000505c:	00005517          	auipc	a0,0x5
    80005060:	6b450513          	addi	a0,a0,1716 # 8000a710 <CONSOLE_STATUS+0x700>
    80005064:	ffffd097          	auipc	ra,0xffffd
    80005068:	e48080e7          	jalr	-440(ra) # 80001eac <_Z11printStringPKc>
    for (; i < 3; i++) {
    8000506c:	0014849b          	addiw	s1,s1,1
    80005070:	0ff4f493          	andi	s1,s1,255
    80005074:	00200793          	li	a5,2
    80005078:	fc97f0e3          	bgeu	a5,s1,80005038 <_ZN7WorkerC11workerBodyCEPv+0x20>
    }

    printString("C: dispatch\n");
    8000507c:	00005517          	auipc	a0,0x5
    80005080:	47c50513          	addi	a0,a0,1148 # 8000a4f8 <CONSOLE_STATUS+0x4e8>
    80005084:	ffffd097          	auipc	ra,0xffffd
    80005088:	e28080e7          	jalr	-472(ra) # 80001eac <_Z11printStringPKc>
    __asm__ ("li t1, 7");
    8000508c:	00700313          	li	t1,7
    thread_dispatch();
    80005090:	ffffc097          	auipc	ra,0xffffc
    80005094:	2f8080e7          	jalr	760(ra) # 80001388 <_Z15thread_dispatchv>

    uint64 t1 = 0;
    __asm__ ("mv %[t1], t1" : [t1] "=r"(t1));
    80005098:	00030913          	mv	s2,t1

    printString("C: t1="); printInt(t1); printString("\n");
    8000509c:	00005517          	auipc	a0,0x5
    800050a0:	46c50513          	addi	a0,a0,1132 # 8000a508 <CONSOLE_STATUS+0x4f8>
    800050a4:	ffffd097          	auipc	ra,0xffffd
    800050a8:	e08080e7          	jalr	-504(ra) # 80001eac <_Z11printStringPKc>
    800050ac:	00000613          	li	a2,0
    800050b0:	00a00593          	li	a1,10
    800050b4:	0009051b          	sext.w	a0,s2
    800050b8:	ffffd097          	auipc	ra,0xffffd
    800050bc:	fa4080e7          	jalr	-92(ra) # 8000205c <_Z8printIntiii>
    800050c0:	00005517          	auipc	a0,0x5
    800050c4:	65050513          	addi	a0,a0,1616 # 8000a710 <CONSOLE_STATUS+0x700>
    800050c8:	ffffd097          	auipc	ra,0xffffd
    800050cc:	de4080e7          	jalr	-540(ra) # 80001eac <_Z11printStringPKc>

    uint64 result = fibonacci(12);
    800050d0:	00c00513          	li	a0,12
    800050d4:	00000097          	auipc	ra,0x0
    800050d8:	d30080e7          	jalr	-720(ra) # 80004e04 <_ZL9fibonaccim>
    800050dc:	00050913          	mv	s2,a0
    printString("C: fibonaci="); printInt(result); printString("\n");
    800050e0:	00005517          	auipc	a0,0x5
    800050e4:	43050513          	addi	a0,a0,1072 # 8000a510 <CONSOLE_STATUS+0x500>
    800050e8:	ffffd097          	auipc	ra,0xffffd
    800050ec:	dc4080e7          	jalr	-572(ra) # 80001eac <_Z11printStringPKc>
    800050f0:	00000613          	li	a2,0
    800050f4:	00a00593          	li	a1,10
    800050f8:	0009051b          	sext.w	a0,s2
    800050fc:	ffffd097          	auipc	ra,0xffffd
    80005100:	f60080e7          	jalr	-160(ra) # 8000205c <_Z8printIntiii>
    80005104:	00005517          	auipc	a0,0x5
    80005108:	60c50513          	addi	a0,a0,1548 # 8000a710 <CONSOLE_STATUS+0x700>
    8000510c:	ffffd097          	auipc	ra,0xffffd
    80005110:	da0080e7          	jalr	-608(ra) # 80001eac <_Z11printStringPKc>
    80005114:	0400006f          	j	80005154 <_ZN7WorkerC11workerBodyCEPv+0x13c>

    for (; i < 6; i++) {
        printString("C: i="); printInt(i); printString("\n");
    80005118:	00005517          	auipc	a0,0x5
    8000511c:	3d850513          	addi	a0,a0,984 # 8000a4f0 <CONSOLE_STATUS+0x4e0>
    80005120:	ffffd097          	auipc	ra,0xffffd
    80005124:	d8c080e7          	jalr	-628(ra) # 80001eac <_Z11printStringPKc>
    80005128:	00000613          	li	a2,0
    8000512c:	00a00593          	li	a1,10
    80005130:	00048513          	mv	a0,s1
    80005134:	ffffd097          	auipc	ra,0xffffd
    80005138:	f28080e7          	jalr	-216(ra) # 8000205c <_Z8printIntiii>
    8000513c:	00005517          	auipc	a0,0x5
    80005140:	5d450513          	addi	a0,a0,1492 # 8000a710 <CONSOLE_STATUS+0x700>
    80005144:	ffffd097          	auipc	ra,0xffffd
    80005148:	d68080e7          	jalr	-664(ra) # 80001eac <_Z11printStringPKc>
    for (; i < 6; i++) {
    8000514c:	0014849b          	addiw	s1,s1,1
    80005150:	0ff4f493          	andi	s1,s1,255
    80005154:	00500793          	li	a5,5
    80005158:	fc97f0e3          	bgeu	a5,s1,80005118 <_ZN7WorkerC11workerBodyCEPv+0x100>
    }

    printString("A finished!\n");
    8000515c:	00005517          	auipc	a0,0x5
    80005160:	36c50513          	addi	a0,a0,876 # 8000a4c8 <CONSOLE_STATUS+0x4b8>
    80005164:	ffffd097          	auipc	ra,0xffffd
    80005168:	d48080e7          	jalr	-696(ra) # 80001eac <_Z11printStringPKc>
    finishedC = true;
    8000516c:	00100793          	li	a5,1
    80005170:	0000a717          	auipc	a4,0xa
    80005174:	92f70123          	sb	a5,-1758(a4) # 8000ea92 <_ZL9finishedC>
    thread_dispatch();
    80005178:	ffffc097          	auipc	ra,0xffffc
    8000517c:	210080e7          	jalr	528(ra) # 80001388 <_Z15thread_dispatchv>
}
    80005180:	01813083          	ld	ra,24(sp)
    80005184:	01013403          	ld	s0,16(sp)
    80005188:	00813483          	ld	s1,8(sp)
    8000518c:	00013903          	ld	s2,0(sp)
    80005190:	02010113          	addi	sp,sp,32
    80005194:	00008067          	ret

0000000080005198 <_ZN7WorkerD11workerBodyDEPv>:

void WorkerD::workerBodyD(void* arg) {
    80005198:	fe010113          	addi	sp,sp,-32
    8000519c:	00113c23          	sd	ra,24(sp)
    800051a0:	00813823          	sd	s0,16(sp)
    800051a4:	00913423          	sd	s1,8(sp)
    800051a8:	01213023          	sd	s2,0(sp)
    800051ac:	02010413          	addi	s0,sp,32
    uint8 i = 10;
    800051b0:	00a00493          	li	s1,10
    800051b4:	0400006f          	j	800051f4 <_ZN7WorkerD11workerBodyDEPv+0x5c>
    for (; i < 13; i++) {
        printString("D: i="); printInt(i); printString("\n");
    800051b8:	00005517          	auipc	a0,0x5
    800051bc:	36850513          	addi	a0,a0,872 # 8000a520 <CONSOLE_STATUS+0x510>
    800051c0:	ffffd097          	auipc	ra,0xffffd
    800051c4:	cec080e7          	jalr	-788(ra) # 80001eac <_Z11printStringPKc>
    800051c8:	00000613          	li	a2,0
    800051cc:	00a00593          	li	a1,10
    800051d0:	00048513          	mv	a0,s1
    800051d4:	ffffd097          	auipc	ra,0xffffd
    800051d8:	e88080e7          	jalr	-376(ra) # 8000205c <_Z8printIntiii>
    800051dc:	00005517          	auipc	a0,0x5
    800051e0:	53450513          	addi	a0,a0,1332 # 8000a710 <CONSOLE_STATUS+0x700>
    800051e4:	ffffd097          	auipc	ra,0xffffd
    800051e8:	cc8080e7          	jalr	-824(ra) # 80001eac <_Z11printStringPKc>
    for (; i < 13; i++) {
    800051ec:	0014849b          	addiw	s1,s1,1
    800051f0:	0ff4f493          	andi	s1,s1,255
    800051f4:	00c00793          	li	a5,12
    800051f8:	fc97f0e3          	bgeu	a5,s1,800051b8 <_ZN7WorkerD11workerBodyDEPv+0x20>
    }

    printString("D: dispatch\n");
    800051fc:	00005517          	auipc	a0,0x5
    80005200:	32c50513          	addi	a0,a0,812 # 8000a528 <CONSOLE_STATUS+0x518>
    80005204:	ffffd097          	auipc	ra,0xffffd
    80005208:	ca8080e7          	jalr	-856(ra) # 80001eac <_Z11printStringPKc>
    __asm__ ("li t1, 5");
    8000520c:	00500313          	li	t1,5
    thread_dispatch();
    80005210:	ffffc097          	auipc	ra,0xffffc
    80005214:	178080e7          	jalr	376(ra) # 80001388 <_Z15thread_dispatchv>

    uint64 result = fibonacci(16);
    80005218:	01000513          	li	a0,16
    8000521c:	00000097          	auipc	ra,0x0
    80005220:	be8080e7          	jalr	-1048(ra) # 80004e04 <_ZL9fibonaccim>
    80005224:	00050913          	mv	s2,a0
    printString("D: fibonaci="); printInt(result); printString("\n");
    80005228:	00005517          	auipc	a0,0x5
    8000522c:	31050513          	addi	a0,a0,784 # 8000a538 <CONSOLE_STATUS+0x528>
    80005230:	ffffd097          	auipc	ra,0xffffd
    80005234:	c7c080e7          	jalr	-900(ra) # 80001eac <_Z11printStringPKc>
    80005238:	00000613          	li	a2,0
    8000523c:	00a00593          	li	a1,10
    80005240:	0009051b          	sext.w	a0,s2
    80005244:	ffffd097          	auipc	ra,0xffffd
    80005248:	e18080e7          	jalr	-488(ra) # 8000205c <_Z8printIntiii>
    8000524c:	00005517          	auipc	a0,0x5
    80005250:	4c450513          	addi	a0,a0,1220 # 8000a710 <CONSOLE_STATUS+0x700>
    80005254:	ffffd097          	auipc	ra,0xffffd
    80005258:	c58080e7          	jalr	-936(ra) # 80001eac <_Z11printStringPKc>
    8000525c:	0400006f          	j	8000529c <_ZN7WorkerD11workerBodyDEPv+0x104>

    for (; i < 16; i++) {
        printString("D: i="); printInt(i); printString("\n");
    80005260:	00005517          	auipc	a0,0x5
    80005264:	2c050513          	addi	a0,a0,704 # 8000a520 <CONSOLE_STATUS+0x510>
    80005268:	ffffd097          	auipc	ra,0xffffd
    8000526c:	c44080e7          	jalr	-956(ra) # 80001eac <_Z11printStringPKc>
    80005270:	00000613          	li	a2,0
    80005274:	00a00593          	li	a1,10
    80005278:	00048513          	mv	a0,s1
    8000527c:	ffffd097          	auipc	ra,0xffffd
    80005280:	de0080e7          	jalr	-544(ra) # 8000205c <_Z8printIntiii>
    80005284:	00005517          	auipc	a0,0x5
    80005288:	48c50513          	addi	a0,a0,1164 # 8000a710 <CONSOLE_STATUS+0x700>
    8000528c:	ffffd097          	auipc	ra,0xffffd
    80005290:	c20080e7          	jalr	-992(ra) # 80001eac <_Z11printStringPKc>
    for (; i < 16; i++) {
    80005294:	0014849b          	addiw	s1,s1,1
    80005298:	0ff4f493          	andi	s1,s1,255
    8000529c:	00f00793          	li	a5,15
    800052a0:	fc97f0e3          	bgeu	a5,s1,80005260 <_ZN7WorkerD11workerBodyDEPv+0xc8>
    }

    printString("D finished!\n");
    800052a4:	00005517          	auipc	a0,0x5
    800052a8:	2a450513          	addi	a0,a0,676 # 8000a548 <CONSOLE_STATUS+0x538>
    800052ac:	ffffd097          	auipc	ra,0xffffd
    800052b0:	c00080e7          	jalr	-1024(ra) # 80001eac <_Z11printStringPKc>
    finishedD = true;
    800052b4:	00100793          	li	a5,1
    800052b8:	00009717          	auipc	a4,0x9
    800052bc:	7cf70da3          	sb	a5,2011(a4) # 8000ea93 <_ZL9finishedD>
    thread_dispatch();
    800052c0:	ffffc097          	auipc	ra,0xffffc
    800052c4:	0c8080e7          	jalr	200(ra) # 80001388 <_Z15thread_dispatchv>
}
    800052c8:	01813083          	ld	ra,24(sp)
    800052cc:	01013403          	ld	s0,16(sp)
    800052d0:	00813483          	ld	s1,8(sp)
    800052d4:	00013903          	ld	s2,0(sp)
    800052d8:	02010113          	addi	sp,sp,32
    800052dc:	00008067          	ret

00000000800052e0 <_Z20Threads_CPP_API_testv>:


void Threads_CPP_API_test() {
    800052e0:	fc010113          	addi	sp,sp,-64
    800052e4:	02113c23          	sd	ra,56(sp)
    800052e8:	02813823          	sd	s0,48(sp)
    800052ec:	02913423          	sd	s1,40(sp)
    800052f0:	04010413          	addi	s0,sp,64
    Thread* threads[4];

    threads[0] = new WorkerA();
    800052f4:	02000513          	li	a0,32
    800052f8:	ffffe097          	auipc	ra,0xffffe
    800052fc:	be4080e7          	jalr	-1052(ra) # 80002edc <_Znwm>
        static int sleep (uint64 time){
            return time_sleep(time);
        }
        protected:
        Thread (){
            body= nullptr;
    80005300:	00053823          	sd	zero,16(a0)
            arg= nullptr;
    80005304:	00053c23          	sd	zero,24(a0)
    WorkerA():Thread() {}
    80005308:	00008797          	auipc	a5,0x8
    8000530c:	83878793          	addi	a5,a5,-1992 # 8000cb40 <_ZTV7WorkerA+0x10>
    80005310:	00f53023          	sd	a5,0(a0)
    threads[0] = new WorkerA();
    80005314:	fca43023          	sd	a0,-64(s0)
    printString("ThreadA created\n");
    80005318:	00005517          	auipc	a0,0x5
    8000531c:	24050513          	addi	a0,a0,576 # 8000a558 <CONSOLE_STATUS+0x548>
    80005320:	ffffd097          	auipc	ra,0xffffd
    80005324:	b8c080e7          	jalr	-1140(ra) # 80001eac <_Z11printStringPKc>

    threads[1] = new WorkerB();
    80005328:	02000513          	li	a0,32
    8000532c:	ffffe097          	auipc	ra,0xffffe
    80005330:	bb0080e7          	jalr	-1104(ra) # 80002edc <_Znwm>
            body= nullptr;
    80005334:	00053823          	sd	zero,16(a0)
            arg= nullptr;
    80005338:	00053c23          	sd	zero,24(a0)
    WorkerB():Thread() {}
    8000533c:	00008797          	auipc	a5,0x8
    80005340:	82c78793          	addi	a5,a5,-2004 # 8000cb68 <_ZTV7WorkerB+0x10>
    80005344:	00f53023          	sd	a5,0(a0)
    threads[1] = new WorkerB();
    80005348:	fca43423          	sd	a0,-56(s0)
    printString("ThreadB created\n");
    8000534c:	00005517          	auipc	a0,0x5
    80005350:	22450513          	addi	a0,a0,548 # 8000a570 <CONSOLE_STATUS+0x560>
    80005354:	ffffd097          	auipc	ra,0xffffd
    80005358:	b58080e7          	jalr	-1192(ra) # 80001eac <_Z11printStringPKc>

    threads[2] = new WorkerC();
    8000535c:	02000513          	li	a0,32
    80005360:	ffffe097          	auipc	ra,0xffffe
    80005364:	b7c080e7          	jalr	-1156(ra) # 80002edc <_Znwm>
            body= nullptr;
    80005368:	00053823          	sd	zero,16(a0)
            arg= nullptr;
    8000536c:	00053c23          	sd	zero,24(a0)
    WorkerC():Thread() {}
    80005370:	00008797          	auipc	a5,0x8
    80005374:	82078793          	addi	a5,a5,-2016 # 8000cb90 <_ZTV7WorkerC+0x10>
    80005378:	00f53023          	sd	a5,0(a0)
    threads[2] = new WorkerC();
    8000537c:	fca43823          	sd	a0,-48(s0)
    printString("ThreadC created\n");
    80005380:	00005517          	auipc	a0,0x5
    80005384:	20850513          	addi	a0,a0,520 # 8000a588 <CONSOLE_STATUS+0x578>
    80005388:	ffffd097          	auipc	ra,0xffffd
    8000538c:	b24080e7          	jalr	-1244(ra) # 80001eac <_Z11printStringPKc>

    threads[3] = new WorkerD();
    80005390:	02000513          	li	a0,32
    80005394:	ffffe097          	auipc	ra,0xffffe
    80005398:	b48080e7          	jalr	-1208(ra) # 80002edc <_Znwm>
            body= nullptr;
    8000539c:	00053823          	sd	zero,16(a0)
            arg= nullptr;
    800053a0:	00053c23          	sd	zero,24(a0)
    WorkerD():Thread() {}
    800053a4:	00008797          	auipc	a5,0x8
    800053a8:	81478793          	addi	a5,a5,-2028 # 8000cbb8 <_ZTV7WorkerD+0x10>
    800053ac:	00f53023          	sd	a5,0(a0)
    threads[3] = new WorkerD();
    800053b0:	fca43c23          	sd	a0,-40(s0)
    printString("ThreadD created\n");
    800053b4:	00005517          	auipc	a0,0x5
    800053b8:	1ec50513          	addi	a0,a0,492 # 8000a5a0 <CONSOLE_STATUS+0x590>
    800053bc:	ffffd097          	auipc	ra,0xffffd
    800053c0:	af0080e7          	jalr	-1296(ra) # 80001eac <_Z11printStringPKc>

    for(int i=0; i<4; i++) {
    800053c4:	00000493          	li	s1,0
    800053c8:	0200006f          	j	800053e8 <_Z20Threads_CPP_API_testv+0x108>
            if(body== nullptr) return thread_create(&myHandle,&threadEntry, this);
    800053cc:	00050613          	mv	a2,a0
    800053d0:	ffffe597          	auipc	a1,0xffffe
    800053d4:	91058593          	addi	a1,a1,-1776 # 80002ce0 <_ZN6Thread11threadEntryEPv>
    800053d8:	00850513          	addi	a0,a0,8
    800053dc:	ffffc097          	auipc	ra,0xffffc
    800053e0:	f24080e7          	jalr	-220(ra) # 80001300 <_Z13thread_createPP8thread_sPFvPvES2_>
    800053e4:	0014849b          	addiw	s1,s1,1
    800053e8:	00300793          	li	a5,3
    800053ec:	0297cc63          	blt	a5,s1,80005424 <_Z20Threads_CPP_API_testv+0x144>
        threads[i]->start();
    800053f0:	00349793          	slli	a5,s1,0x3
    800053f4:	fe040713          	addi	a4,s0,-32
    800053f8:	00f707b3          	add	a5,a4,a5
    800053fc:	fe07b503          	ld	a0,-32(a5)
    80005400:	01053583          	ld	a1,16(a0)
    80005404:	fc0584e3          	beqz	a1,800053cc <_Z20Threads_CPP_API_testv+0xec>
            else return thread_create(&myHandle,body,arg);
    80005408:	01853603          	ld	a2,24(a0)
    8000540c:	00850513          	addi	a0,a0,8
    80005410:	ffffc097          	auipc	ra,0xffffc
    80005414:	ef0080e7          	jalr	-272(ra) # 80001300 <_Z13thread_createPP8thread_sPFvPvES2_>
    80005418:	fcdff06f          	j	800053e4 <_Z20Threads_CPP_API_testv+0x104>
            thread_dispatch();
    8000541c:	ffffc097          	auipc	ra,0xffffc
    80005420:	f6c080e7          	jalr	-148(ra) # 80001388 <_Z15thread_dispatchv>
    }

    while (!(finishedA && finishedB && finishedC && finishedD)) {
    80005424:	00009797          	auipc	a5,0x9
    80005428:	66c7c783          	lbu	a5,1644(a5) # 8000ea90 <_ZL9finishedA>
    8000542c:	fe0788e3          	beqz	a5,8000541c <_Z20Threads_CPP_API_testv+0x13c>
    80005430:	00009797          	auipc	a5,0x9
    80005434:	6617c783          	lbu	a5,1633(a5) # 8000ea91 <_ZL9finishedB>
    80005438:	fe0782e3          	beqz	a5,8000541c <_Z20Threads_CPP_API_testv+0x13c>
    8000543c:	00009797          	auipc	a5,0x9
    80005440:	6567c783          	lbu	a5,1622(a5) # 8000ea92 <_ZL9finishedC>
    80005444:	fc078ce3          	beqz	a5,8000541c <_Z20Threads_CPP_API_testv+0x13c>
    80005448:	00009797          	auipc	a5,0x9
    8000544c:	64b7c783          	lbu	a5,1611(a5) # 8000ea93 <_ZL9finishedD>
    80005450:	fc0786e3          	beqz	a5,8000541c <_Z20Threads_CPP_API_testv+0x13c>
    80005454:	fc040493          	addi	s1,s0,-64
    80005458:	0080006f          	j	80005460 <_Z20Threads_CPP_API_testv+0x180>
        Thread::dispatch();
    }

    for (auto thread: threads) { delete thread; }
    8000545c:	00848493          	addi	s1,s1,8
    80005460:	fe040793          	addi	a5,s0,-32
    80005464:	00f48e63          	beq	s1,a5,80005480 <_Z20Threads_CPP_API_testv+0x1a0>
    80005468:	0004b503          	ld	a0,0(s1)
    8000546c:	fe0508e3          	beqz	a0,8000545c <_Z20Threads_CPP_API_testv+0x17c>
    80005470:	00053783          	ld	a5,0(a0)
    80005474:	0087b783          	ld	a5,8(a5)
    80005478:	000780e7          	jalr	a5
    8000547c:	fe1ff06f          	j	8000545c <_Z20Threads_CPP_API_testv+0x17c>
}
    80005480:	03813083          	ld	ra,56(sp)
    80005484:	03013403          	ld	s0,48(sp)
    80005488:	02813483          	ld	s1,40(sp)
    8000548c:	04010113          	addi	sp,sp,64
    80005490:	00008067          	ret

0000000080005494 <_ZN7WorkerDD1Ev>:
class WorkerD: public Thread {
    80005494:	ff010113          	addi	sp,sp,-16
    80005498:	00813423          	sd	s0,8(sp)
    8000549c:	01010413          	addi	s0,sp,16
    800054a0:	00813403          	ld	s0,8(sp)
    800054a4:	01010113          	addi	sp,sp,16
    800054a8:	00008067          	ret

00000000800054ac <_ZN7WorkerCD1Ev>:
class WorkerC: public Thread {
    800054ac:	ff010113          	addi	sp,sp,-16
    800054b0:	00813423          	sd	s0,8(sp)
    800054b4:	01010413          	addi	s0,sp,16
    800054b8:	00813403          	ld	s0,8(sp)
    800054bc:	01010113          	addi	sp,sp,16
    800054c0:	00008067          	ret

00000000800054c4 <_ZN7WorkerBD1Ev>:
class WorkerB: public Thread {
    800054c4:	ff010113          	addi	sp,sp,-16
    800054c8:	00813423          	sd	s0,8(sp)
    800054cc:	01010413          	addi	s0,sp,16
    800054d0:	00813403          	ld	s0,8(sp)
    800054d4:	01010113          	addi	sp,sp,16
    800054d8:	00008067          	ret

00000000800054dc <_ZN7WorkerAD1Ev>:
class WorkerA: public Thread {
    800054dc:	ff010113          	addi	sp,sp,-16
    800054e0:	00813423          	sd	s0,8(sp)
    800054e4:	01010413          	addi	s0,sp,16
    800054e8:	00813403          	ld	s0,8(sp)
    800054ec:	01010113          	addi	sp,sp,16
    800054f0:	00008067          	ret

00000000800054f4 <_ZN7WorkerAD0Ev>:
    800054f4:	ff010113          	addi	sp,sp,-16
    800054f8:	00113423          	sd	ra,8(sp)
    800054fc:	00813023          	sd	s0,0(sp)
    80005500:	01010413          	addi	s0,sp,16
    80005504:	ffffe097          	auipc	ra,0xffffe
    80005508:	a00080e7          	jalr	-1536(ra) # 80002f04 <_ZdlPv>
    8000550c:	00813083          	ld	ra,8(sp)
    80005510:	00013403          	ld	s0,0(sp)
    80005514:	01010113          	addi	sp,sp,16
    80005518:	00008067          	ret

000000008000551c <_ZN7WorkerBD0Ev>:
class WorkerB: public Thread {
    8000551c:	ff010113          	addi	sp,sp,-16
    80005520:	00113423          	sd	ra,8(sp)
    80005524:	00813023          	sd	s0,0(sp)
    80005528:	01010413          	addi	s0,sp,16
    8000552c:	ffffe097          	auipc	ra,0xffffe
    80005530:	9d8080e7          	jalr	-1576(ra) # 80002f04 <_ZdlPv>
    80005534:	00813083          	ld	ra,8(sp)
    80005538:	00013403          	ld	s0,0(sp)
    8000553c:	01010113          	addi	sp,sp,16
    80005540:	00008067          	ret

0000000080005544 <_ZN7WorkerCD0Ev>:
class WorkerC: public Thread {
    80005544:	ff010113          	addi	sp,sp,-16
    80005548:	00113423          	sd	ra,8(sp)
    8000554c:	00813023          	sd	s0,0(sp)
    80005550:	01010413          	addi	s0,sp,16
    80005554:	ffffe097          	auipc	ra,0xffffe
    80005558:	9b0080e7          	jalr	-1616(ra) # 80002f04 <_ZdlPv>
    8000555c:	00813083          	ld	ra,8(sp)
    80005560:	00013403          	ld	s0,0(sp)
    80005564:	01010113          	addi	sp,sp,16
    80005568:	00008067          	ret

000000008000556c <_ZN7WorkerDD0Ev>:
class WorkerD: public Thread {
    8000556c:	ff010113          	addi	sp,sp,-16
    80005570:	00113423          	sd	ra,8(sp)
    80005574:	00813023          	sd	s0,0(sp)
    80005578:	01010413          	addi	s0,sp,16
    8000557c:	ffffe097          	auipc	ra,0xffffe
    80005580:	988080e7          	jalr	-1656(ra) # 80002f04 <_ZdlPv>
    80005584:	00813083          	ld	ra,8(sp)
    80005588:	00013403          	ld	s0,0(sp)
    8000558c:	01010113          	addi	sp,sp,16
    80005590:	00008067          	ret

0000000080005594 <_ZN7WorkerA3runEv>:
    void run() override {
    80005594:	ff010113          	addi	sp,sp,-16
    80005598:	00113423          	sd	ra,8(sp)
    8000559c:	00813023          	sd	s0,0(sp)
    800055a0:	01010413          	addi	s0,sp,16
        workerBodyA(nullptr);
    800055a4:	00000593          	li	a1,0
    800055a8:	00000097          	auipc	ra,0x0
    800055ac:	8d0080e7          	jalr	-1840(ra) # 80004e78 <_ZN7WorkerA11workerBodyAEPv>
    }
    800055b0:	00813083          	ld	ra,8(sp)
    800055b4:	00013403          	ld	s0,0(sp)
    800055b8:	01010113          	addi	sp,sp,16
    800055bc:	00008067          	ret

00000000800055c0 <_ZN7WorkerB3runEv>:
    void run() override {
    800055c0:	ff010113          	addi	sp,sp,-16
    800055c4:	00113423          	sd	ra,8(sp)
    800055c8:	00813023          	sd	s0,0(sp)
    800055cc:	01010413          	addi	s0,sp,16
        workerBodyB(nullptr);
    800055d0:	00000593          	li	a1,0
    800055d4:	00000097          	auipc	ra,0x0
    800055d8:	970080e7          	jalr	-1680(ra) # 80004f44 <_ZN7WorkerB11workerBodyBEPv>
    }
    800055dc:	00813083          	ld	ra,8(sp)
    800055e0:	00013403          	ld	s0,0(sp)
    800055e4:	01010113          	addi	sp,sp,16
    800055e8:	00008067          	ret

00000000800055ec <_ZN7WorkerC3runEv>:
    void run() override {
    800055ec:	ff010113          	addi	sp,sp,-16
    800055f0:	00113423          	sd	ra,8(sp)
    800055f4:	00813023          	sd	s0,0(sp)
    800055f8:	01010413          	addi	s0,sp,16
        workerBodyC(nullptr);
    800055fc:	00000593          	li	a1,0
    80005600:	00000097          	auipc	ra,0x0
    80005604:	a18080e7          	jalr	-1512(ra) # 80005018 <_ZN7WorkerC11workerBodyCEPv>
    }
    80005608:	00813083          	ld	ra,8(sp)
    8000560c:	00013403          	ld	s0,0(sp)
    80005610:	01010113          	addi	sp,sp,16
    80005614:	00008067          	ret

0000000080005618 <_ZN7WorkerD3runEv>:
    void run() override {
    80005618:	ff010113          	addi	sp,sp,-16
    8000561c:	00113423          	sd	ra,8(sp)
    80005620:	00813023          	sd	s0,0(sp)
    80005624:	01010413          	addi	s0,sp,16
        workerBodyD(nullptr);
    80005628:	00000593          	li	a1,0
    8000562c:	00000097          	auipc	ra,0x0
    80005630:	b6c080e7          	jalr	-1172(ra) # 80005198 <_ZN7WorkerD11workerBodyDEPv>
    }
    80005634:	00813083          	ld	ra,8(sp)
    80005638:	00013403          	ld	s0,0(sp)
    8000563c:	01010113          	addi	sp,sp,16
    80005640:	00008067          	ret

0000000080005644 <_Z20testConsumerProducerv>:

        td->sem->signal();
    }
};

void testConsumerProducer() {
    80005644:	f9010113          	addi	sp,sp,-112
    80005648:	06113423          	sd	ra,104(sp)
    8000564c:	06813023          	sd	s0,96(sp)
    80005650:	04913c23          	sd	s1,88(sp)
    80005654:	05213823          	sd	s2,80(sp)
    80005658:	05313423          	sd	s3,72(sp)
    8000565c:	05413023          	sd	s4,64(sp)
    80005660:	03513c23          	sd	s5,56(sp)
    80005664:	03613823          	sd	s6,48(sp)
    80005668:	03713423          	sd	s7,40(sp)
    8000566c:	03813023          	sd	s8,32(sp)
    80005670:	07010413          	addi	s0,sp,112
    delete waitForAll;
    for (int i = 0; i < threadNum; i++) {
        delete producers[i];
    }
    delete consumer;
    delete buffer;
    80005674:	00010c13          	mv	s8,sp
    printString("Unesite broj proizvodjaca?\n");
    80005678:	00005517          	auipc	a0,0x5
    8000567c:	d6050513          	addi	a0,a0,-672 # 8000a3d8 <CONSOLE_STATUS+0x3c8>
    80005680:	ffffd097          	auipc	ra,0xffffd
    80005684:	82c080e7          	jalr	-2004(ra) # 80001eac <_Z11printStringPKc>
    getString(input, 30);
    80005688:	01e00593          	li	a1,30
    8000568c:	f9040493          	addi	s1,s0,-112
    80005690:	00048513          	mv	a0,s1
    80005694:	ffffd097          	auipc	ra,0xffffd
    80005698:	8a0080e7          	jalr	-1888(ra) # 80001f34 <_Z9getStringPci>
    threadNum = stringToInt(input);
    8000569c:	00048513          	mv	a0,s1
    800056a0:	ffffd097          	auipc	ra,0xffffd
    800056a4:	96c080e7          	jalr	-1684(ra) # 8000200c <_Z11stringToIntPKc>
    800056a8:	00050993          	mv	s3,a0
    printString("Unesite velicinu bafera?\n");
    800056ac:	00005517          	auipc	a0,0x5
    800056b0:	d4c50513          	addi	a0,a0,-692 # 8000a3f8 <CONSOLE_STATUS+0x3e8>
    800056b4:	ffffc097          	auipc	ra,0xffffc
    800056b8:	7f8080e7          	jalr	2040(ra) # 80001eac <_Z11printStringPKc>
    getString(input, 30);
    800056bc:	01e00593          	li	a1,30
    800056c0:	00048513          	mv	a0,s1
    800056c4:	ffffd097          	auipc	ra,0xffffd
    800056c8:	870080e7          	jalr	-1936(ra) # 80001f34 <_Z9getStringPci>
    n = stringToInt(input);
    800056cc:	00048513          	mv	a0,s1
    800056d0:	ffffd097          	auipc	ra,0xffffd
    800056d4:	93c080e7          	jalr	-1732(ra) # 8000200c <_Z11stringToIntPKc>
    800056d8:	00050493          	mv	s1,a0
    printString("Broj proizvodjaca ");
    800056dc:	00005517          	auipc	a0,0x5
    800056e0:	d3c50513          	addi	a0,a0,-708 # 8000a418 <CONSOLE_STATUS+0x408>
    800056e4:	ffffc097          	auipc	ra,0xffffc
    800056e8:	7c8080e7          	jalr	1992(ra) # 80001eac <_Z11printStringPKc>
    printInt(threadNum);
    800056ec:	00000613          	li	a2,0
    800056f0:	00a00593          	li	a1,10
    800056f4:	00098513          	mv	a0,s3
    800056f8:	ffffd097          	auipc	ra,0xffffd
    800056fc:	964080e7          	jalr	-1692(ra) # 8000205c <_Z8printIntiii>
    printString(" i velicina bafera ");
    80005700:	00005517          	auipc	a0,0x5
    80005704:	d3050513          	addi	a0,a0,-720 # 8000a430 <CONSOLE_STATUS+0x420>
    80005708:	ffffc097          	auipc	ra,0xffffc
    8000570c:	7a4080e7          	jalr	1956(ra) # 80001eac <_Z11printStringPKc>
    printInt(n);
    80005710:	00000613          	li	a2,0
    80005714:	00a00593          	li	a1,10
    80005718:	00048513          	mv	a0,s1
    8000571c:	ffffd097          	auipc	ra,0xffffd
    80005720:	940080e7          	jalr	-1728(ra) # 8000205c <_Z8printIntiii>
    printString(".\n");
    80005724:	00005517          	auipc	a0,0x5
    80005728:	d2450513          	addi	a0,a0,-732 # 8000a448 <CONSOLE_STATUS+0x438>
    8000572c:	ffffc097          	auipc	ra,0xffffc
    80005730:	780080e7          	jalr	1920(ra) # 80001eac <_Z11printStringPKc>
    if (threadNum > n) {
    80005734:	0334c463          	blt	s1,s3,8000575c <_Z20testConsumerProducerv+0x118>
    } else if (threadNum < 1) {
    80005738:	03305c63          	blez	s3,80005770 <_Z20testConsumerProducerv+0x12c>
    BufferCPP *buffer = new BufferCPP(n);
    8000573c:	03800513          	li	a0,56
    80005740:	ffffd097          	auipc	ra,0xffffd
    80005744:	79c080e7          	jalr	1948(ra) # 80002edc <_Znwm>
    80005748:	00050a93          	mv	s5,a0
    8000574c:	00048593          	mv	a1,s1
    80005750:	00001097          	auipc	ra,0x1
    80005754:	360080e7          	jalr	864(ra) # 80006ab0 <_ZN9BufferCPPC1Ei>
    80005758:	0300006f          	j	80005788 <_Z20testConsumerProducerv+0x144>
        printString("Broj proizvodjaca ne sme biti manji od velicine bafera!\n");
    8000575c:	00005517          	auipc	a0,0x5
    80005760:	cf450513          	addi	a0,a0,-780 # 8000a450 <CONSOLE_STATUS+0x440>
    80005764:	ffffc097          	auipc	ra,0xffffc
    80005768:	748080e7          	jalr	1864(ra) # 80001eac <_Z11printStringPKc>
        return;
    8000576c:	0140006f          	j	80005780 <_Z20testConsumerProducerv+0x13c>
        printString("Broj proizvodjaca mora biti veci od nula!\n");
    80005770:	00005517          	auipc	a0,0x5
    80005774:	d2050513          	addi	a0,a0,-736 # 8000a490 <CONSOLE_STATUS+0x480>
    80005778:	ffffc097          	auipc	ra,0xffffc
    8000577c:	734080e7          	jalr	1844(ra) # 80001eac <_Z11printStringPKc>
        return;
    80005780:	000c0113          	mv	sp,s8
    80005784:	2780006f          	j	800059fc <_Z20testConsumerProducerv+0x3b8>
    waitForAll = new Semaphore(0);
    80005788:	01000513          	li	a0,16
    8000578c:	ffffd097          	auipc	ra,0xffffd
    80005790:	750080e7          	jalr	1872(ra) # 80002edc <_Znwm>
    80005794:	00050913          	mv	s2,a0
};


class Semaphore {
        public:
        Semaphore (unsigned init = 1){
    80005798:	00007797          	auipc	a5,0x7
    8000579c:	35078793          	addi	a5,a5,848 # 8000cae8 <_ZTV9Semaphore+0x10>
    800057a0:	00f53023          	sd	a5,0(a0)
            sem_open(&myHandle,init);
    800057a4:	00000593          	li	a1,0
    800057a8:	00850513          	addi	a0,a0,8
    800057ac:	ffffc097          	auipc	ra,0xffffc
    800057b0:	c90080e7          	jalr	-880(ra) # 8000143c <_Z8sem_openPP5sem_sj>
    800057b4:	00009797          	auipc	a5,0x9
    800057b8:	2f27b623          	sd	s2,748(a5) # 8000eaa0 <_ZL10waitForAll>
    Thread *producers[threadNum];
    800057bc:	00399793          	slli	a5,s3,0x3
    800057c0:	00f78793          	addi	a5,a5,15
    800057c4:	ff07f793          	andi	a5,a5,-16
    800057c8:	40f10133          	sub	sp,sp,a5
    800057cc:	00010a13          	mv	s4,sp
    thread_data threadData[threadNum + 1];
    800057d0:	0019871b          	addiw	a4,s3,1
    800057d4:	00171793          	slli	a5,a4,0x1
    800057d8:	00e787b3          	add	a5,a5,a4
    800057dc:	00379793          	slli	a5,a5,0x3
    800057e0:	00f78793          	addi	a5,a5,15
    800057e4:	ff07f793          	andi	a5,a5,-16
    800057e8:	40f10133          	sub	sp,sp,a5
    800057ec:	00010b13          	mv	s6,sp
    threadData[threadNum].id = threadNum;
    800057f0:	00199493          	slli	s1,s3,0x1
    800057f4:	013484b3          	add	s1,s1,s3
    800057f8:	00349493          	slli	s1,s1,0x3
    800057fc:	009b04b3          	add	s1,s6,s1
    80005800:	0134a023          	sw	s3,0(s1)
    threadData[threadNum].buffer = buffer;
    80005804:	0154b423          	sd	s5,8(s1)
    threadData[threadNum].sem = waitForAll;
    80005808:	0124b823          	sd	s2,16(s1)
    Thread *consumer = new Consumer(&threadData[threadNum]);
    8000580c:	02800513          	li	a0,40
    80005810:	ffffd097          	auipc	ra,0xffffd
    80005814:	6cc080e7          	jalr	1740(ra) # 80002edc <_Znwm>
    80005818:	00050b93          	mv	s7,a0
            body= nullptr;
    8000581c:	00053823          	sd	zero,16(a0)
            arg= nullptr;
    80005820:	00053c23          	sd	zero,24(a0)
    Consumer(thread_data *_td) : Thread(), td(_td) {}
    80005824:	00007797          	auipc	a5,0x7
    80005828:	40c78793          	addi	a5,a5,1036 # 8000cc30 <_ZTV8Consumer+0x10>
    8000582c:	00f53023          	sd	a5,0(a0)
    80005830:	02953023          	sd	s1,32(a0)
            if(body== nullptr) return thread_create(&myHandle,&threadEntry, this);
    80005834:	00050613          	mv	a2,a0
    80005838:	ffffd597          	auipc	a1,0xffffd
    8000583c:	4a858593          	addi	a1,a1,1192 # 80002ce0 <_ZN6Thread11threadEntryEPv>
    80005840:	00850513          	addi	a0,a0,8
    80005844:	ffffc097          	auipc	ra,0xffffc
    80005848:	abc080e7          	jalr	-1348(ra) # 80001300 <_Z13thread_createPP8thread_sPFvPvES2_>
    threadData[0].id = 0;
    8000584c:	000b2023          	sw	zero,0(s6)
    threadData[0].buffer = buffer;
    80005850:	015b3423          	sd	s5,8(s6)
    threadData[0].sem = waitForAll;
    80005854:	00009797          	auipc	a5,0x9
    80005858:	24c7b783          	ld	a5,588(a5) # 8000eaa0 <_ZL10waitForAll>
    8000585c:	00fb3823          	sd	a5,16(s6)
    producers[0] = new ProducerKeyborad(&threadData[0]);
    80005860:	02800513          	li	a0,40
    80005864:	ffffd097          	auipc	ra,0xffffd
    80005868:	678080e7          	jalr	1656(ra) # 80002edc <_Znwm>
            body= nullptr;
    8000586c:	00053823          	sd	zero,16(a0)
            arg= nullptr;
    80005870:	00053c23          	sd	zero,24(a0)
    ProducerKeyborad(thread_data *_td) : Thread(), td(_td) {}
    80005874:	00007797          	auipc	a5,0x7
    80005878:	36c78793          	addi	a5,a5,876 # 8000cbe0 <_ZTV16ProducerKeyborad+0x10>
    8000587c:	00f53023          	sd	a5,0(a0)
    80005880:	03653023          	sd	s6,32(a0)
    producers[0] = new ProducerKeyborad(&threadData[0]);
    80005884:	00aa3023          	sd	a0,0(s4)
            if(body== nullptr) return thread_create(&myHandle,&threadEntry, this);
    80005888:	01053583          	ld	a1,16(a0)
    8000588c:	00058e63          	beqz	a1,800058a8 <_Z20testConsumerProducerv+0x264>
            else return thread_create(&myHandle,body,arg);
    80005890:	01853603          	ld	a2,24(a0)
    80005894:	00850513          	addi	a0,a0,8
    80005898:	ffffc097          	auipc	ra,0xffffc
    8000589c:	a68080e7          	jalr	-1432(ra) # 80001300 <_Z13thread_createPP8thread_sPFvPvES2_>
    for (int i = 1; i < threadNum; i++) {
    800058a0:	00100913          	li	s2,1
    800058a4:	03c0006f          	j	800058e0 <_Z20testConsumerProducerv+0x29c>
            if(body== nullptr) return thread_create(&myHandle,&threadEntry, this);
    800058a8:	00050613          	mv	a2,a0
    800058ac:	ffffd597          	auipc	a1,0xffffd
    800058b0:	43458593          	addi	a1,a1,1076 # 80002ce0 <_ZN6Thread11threadEntryEPv>
    800058b4:	00850513          	addi	a0,a0,8
    800058b8:	ffffc097          	auipc	ra,0xffffc
    800058bc:	a48080e7          	jalr	-1464(ra) # 80001300 <_Z13thread_createPP8thread_sPFvPvES2_>
    800058c0:	fe1ff06f          	j	800058a0 <_Z20testConsumerProducerv+0x25c>
    800058c4:	00050613          	mv	a2,a0
    800058c8:	ffffd597          	auipc	a1,0xffffd
    800058cc:	41858593          	addi	a1,a1,1048 # 80002ce0 <_ZN6Thread11threadEntryEPv>
    800058d0:	00850513          	addi	a0,a0,8
    800058d4:	ffffc097          	auipc	ra,0xffffc
    800058d8:	a2c080e7          	jalr	-1492(ra) # 80001300 <_Z13thread_createPP8thread_sPFvPvES2_>
    800058dc:	0019091b          	addiw	s2,s2,1
    800058e0:	07395a63          	bge	s2,s3,80005954 <_Z20testConsumerProducerv+0x310>
        threadData[i].id = i;
    800058e4:	00191493          	slli	s1,s2,0x1
    800058e8:	012484b3          	add	s1,s1,s2
    800058ec:	00349493          	slli	s1,s1,0x3
    800058f0:	009b04b3          	add	s1,s6,s1
    800058f4:	0124a023          	sw	s2,0(s1)
        threadData[i].buffer = buffer;
    800058f8:	0154b423          	sd	s5,8(s1)
        threadData[i].sem = waitForAll;
    800058fc:	00009797          	auipc	a5,0x9
    80005900:	1a47b783          	ld	a5,420(a5) # 8000eaa0 <_ZL10waitForAll>
    80005904:	00f4b823          	sd	a5,16(s1)
        producers[i] = new Producer(&threadData[i]);
    80005908:	02800513          	li	a0,40
    8000590c:	ffffd097          	auipc	ra,0xffffd
    80005910:	5d0080e7          	jalr	1488(ra) # 80002edc <_Znwm>
            body= nullptr;
    80005914:	00053823          	sd	zero,16(a0)
            arg= nullptr;
    80005918:	00053c23          	sd	zero,24(a0)
    Producer(thread_data *_td) : Thread(), td(_td) {}
    8000591c:	00007797          	auipc	a5,0x7
    80005920:	2ec78793          	addi	a5,a5,748 # 8000cc08 <_ZTV8Producer+0x10>
    80005924:	00f53023          	sd	a5,0(a0)
    80005928:	02953023          	sd	s1,32(a0)
        producers[i] = new Producer(&threadData[i]);
    8000592c:	00391793          	slli	a5,s2,0x3
    80005930:	00fa07b3          	add	a5,s4,a5
    80005934:	00a7b023          	sd	a0,0(a5)
            if(body== nullptr) return thread_create(&myHandle,&threadEntry, this);
    80005938:	01053583          	ld	a1,16(a0)
    8000593c:	f80584e3          	beqz	a1,800058c4 <_Z20testConsumerProducerv+0x280>
            else return thread_create(&myHandle,body,arg);
    80005940:	01853603          	ld	a2,24(a0)
    80005944:	00850513          	addi	a0,a0,8
    80005948:	ffffc097          	auipc	ra,0xffffc
    8000594c:	9b8080e7          	jalr	-1608(ra) # 80001300 <_Z13thread_createPP8thread_sPFvPvES2_>
    80005950:	f8dff06f          	j	800058dc <_Z20testConsumerProducerv+0x298>
            thread_dispatch();
    80005954:	ffffc097          	auipc	ra,0xffffc
    80005958:	a34080e7          	jalr	-1484(ra) # 80001388 <_Z15thread_dispatchv>
    for (int i = 0; i <= threadNum; i++) {
    8000595c:	00000493          	li	s1,0
    80005960:	0299c063          	blt	s3,s1,80005980 <_Z20testConsumerProducerv+0x33c>
        }
        virtual ~Semaphore (){
            sem_close(myHandle);
        }
        int wait (){
            return sem_wait(myHandle);
    80005964:	00009797          	auipc	a5,0x9
    80005968:	13c7b783          	ld	a5,316(a5) # 8000eaa0 <_ZL10waitForAll>
    8000596c:	0087b503          	ld	a0,8(a5)
    80005970:	ffffc097          	auipc	ra,0xffffc
    80005974:	b50080e7          	jalr	-1200(ra) # 800014c0 <_Z8sem_waitP5sem_s>
    80005978:	0014849b          	addiw	s1,s1,1
    8000597c:	fe5ff06f          	j	80005960 <_Z20testConsumerProducerv+0x31c>
    delete waitForAll;
    80005980:	00009517          	auipc	a0,0x9
    80005984:	12053503          	ld	a0,288(a0) # 8000eaa0 <_ZL10waitForAll>
    80005988:	00050863          	beqz	a0,80005998 <_Z20testConsumerProducerv+0x354>
    8000598c:	00053783          	ld	a5,0(a0)
    80005990:	0087b783          	ld	a5,8(a5)
    80005994:	000780e7          	jalr	a5
    for (int i = 0; i <= threadNum; i++) {
    80005998:	00000493          	li	s1,0
    8000599c:	0080006f          	j	800059a4 <_Z20testConsumerProducerv+0x360>
    for (int i = 0; i < threadNum; i++) {
    800059a0:	0014849b          	addiw	s1,s1,1
    800059a4:	0334d263          	bge	s1,s3,800059c8 <_Z20testConsumerProducerv+0x384>
        delete producers[i];
    800059a8:	00349793          	slli	a5,s1,0x3
    800059ac:	00fa07b3          	add	a5,s4,a5
    800059b0:	0007b503          	ld	a0,0(a5)
    800059b4:	fe0506e3          	beqz	a0,800059a0 <_Z20testConsumerProducerv+0x35c>
    800059b8:	00053783          	ld	a5,0(a0)
    800059bc:	0087b783          	ld	a5,8(a5)
    800059c0:	000780e7          	jalr	a5
    800059c4:	fddff06f          	j	800059a0 <_Z20testConsumerProducerv+0x35c>
    delete consumer;
    800059c8:	000b8a63          	beqz	s7,800059dc <_Z20testConsumerProducerv+0x398>
    800059cc:	000bb783          	ld	a5,0(s7)
    800059d0:	0087b783          	ld	a5,8(a5)
    800059d4:	000b8513          	mv	a0,s7
    800059d8:	000780e7          	jalr	a5
    delete buffer;
    800059dc:	000a8e63          	beqz	s5,800059f8 <_Z20testConsumerProducerv+0x3b4>
    800059e0:	000a8513          	mv	a0,s5
    800059e4:	00001097          	auipc	ra,0x1
    800059e8:	434080e7          	jalr	1076(ra) # 80006e18 <_ZN9BufferCPPD1Ev>
    800059ec:	000a8513          	mv	a0,s5
    800059f0:	ffffd097          	auipc	ra,0xffffd
    800059f4:	514080e7          	jalr	1300(ra) # 80002f04 <_ZdlPv>
    800059f8:	000c0113          	mv	sp,s8
}
    800059fc:	f9040113          	addi	sp,s0,-112
    80005a00:	06813083          	ld	ra,104(sp)
    80005a04:	06013403          	ld	s0,96(sp)
    80005a08:	05813483          	ld	s1,88(sp)
    80005a0c:	05013903          	ld	s2,80(sp)
    80005a10:	04813983          	ld	s3,72(sp)
    80005a14:	04013a03          	ld	s4,64(sp)
    80005a18:	03813a83          	ld	s5,56(sp)
    80005a1c:	03013b03          	ld	s6,48(sp)
    80005a20:	02813b83          	ld	s7,40(sp)
    80005a24:	02013c03          	ld	s8,32(sp)
    80005a28:	07010113          	addi	sp,sp,112
    80005a2c:	00008067          	ret
    80005a30:	00050493          	mv	s1,a0
    BufferCPP *buffer = new BufferCPP(n);
    80005a34:	000a8513          	mv	a0,s5
    80005a38:	ffffd097          	auipc	ra,0xffffd
    80005a3c:	4cc080e7          	jalr	1228(ra) # 80002f04 <_ZdlPv>
    80005a40:	00048513          	mv	a0,s1
    80005a44:	0000a097          	auipc	ra,0xa
    80005a48:	154080e7          	jalr	340(ra) # 8000fb98 <_Unwind_Resume>
    80005a4c:	00050493          	mv	s1,a0
    waitForAll = new Semaphore(0);
    80005a50:	00090513          	mv	a0,s2
    80005a54:	ffffd097          	auipc	ra,0xffffd
    80005a58:	4b0080e7          	jalr	1200(ra) # 80002f04 <_ZdlPv>
    80005a5c:	00048513          	mv	a0,s1
    80005a60:	0000a097          	auipc	ra,0xa
    80005a64:	138080e7          	jalr	312(ra) # 8000fb98 <_Unwind_Resume>

0000000080005a68 <_ZN8ConsumerD1Ev>:
class Consumer : public Thread {
    80005a68:	ff010113          	addi	sp,sp,-16
    80005a6c:	00813423          	sd	s0,8(sp)
    80005a70:	01010413          	addi	s0,sp,16
    80005a74:	00813403          	ld	s0,8(sp)
    80005a78:	01010113          	addi	sp,sp,16
    80005a7c:	00008067          	ret

0000000080005a80 <_ZN8ProducerD1Ev>:
class Producer : public Thread {
    80005a80:	ff010113          	addi	sp,sp,-16
    80005a84:	00813423          	sd	s0,8(sp)
    80005a88:	01010413          	addi	s0,sp,16
    80005a8c:	00813403          	ld	s0,8(sp)
    80005a90:	01010113          	addi	sp,sp,16
    80005a94:	00008067          	ret

0000000080005a98 <_ZN16ProducerKeyboradD1Ev>:
class ProducerKeyborad : public Thread {
    80005a98:	ff010113          	addi	sp,sp,-16
    80005a9c:	00813423          	sd	s0,8(sp)
    80005aa0:	01010413          	addi	s0,sp,16
    80005aa4:	00813403          	ld	s0,8(sp)
    80005aa8:	01010113          	addi	sp,sp,16
    80005aac:	00008067          	ret

0000000080005ab0 <_ZN8ConsumerD0Ev>:
class Consumer : public Thread {
    80005ab0:	ff010113          	addi	sp,sp,-16
    80005ab4:	00113423          	sd	ra,8(sp)
    80005ab8:	00813023          	sd	s0,0(sp)
    80005abc:	01010413          	addi	s0,sp,16
    80005ac0:	ffffd097          	auipc	ra,0xffffd
    80005ac4:	444080e7          	jalr	1092(ra) # 80002f04 <_ZdlPv>
    80005ac8:	00813083          	ld	ra,8(sp)
    80005acc:	00013403          	ld	s0,0(sp)
    80005ad0:	01010113          	addi	sp,sp,16
    80005ad4:	00008067          	ret

0000000080005ad8 <_ZN16ProducerKeyboradD0Ev>:
class ProducerKeyborad : public Thread {
    80005ad8:	ff010113          	addi	sp,sp,-16
    80005adc:	00113423          	sd	ra,8(sp)
    80005ae0:	00813023          	sd	s0,0(sp)
    80005ae4:	01010413          	addi	s0,sp,16
    80005ae8:	ffffd097          	auipc	ra,0xffffd
    80005aec:	41c080e7          	jalr	1052(ra) # 80002f04 <_ZdlPv>
    80005af0:	00813083          	ld	ra,8(sp)
    80005af4:	00013403          	ld	s0,0(sp)
    80005af8:	01010113          	addi	sp,sp,16
    80005afc:	00008067          	ret

0000000080005b00 <_ZN8ProducerD0Ev>:
class Producer : public Thread {
    80005b00:	ff010113          	addi	sp,sp,-16
    80005b04:	00113423          	sd	ra,8(sp)
    80005b08:	00813023          	sd	s0,0(sp)
    80005b0c:	01010413          	addi	s0,sp,16
    80005b10:	ffffd097          	auipc	ra,0xffffd
    80005b14:	3f4080e7          	jalr	1012(ra) # 80002f04 <_ZdlPv>
    80005b18:	00813083          	ld	ra,8(sp)
    80005b1c:	00013403          	ld	s0,0(sp)
    80005b20:	01010113          	addi	sp,sp,16
    80005b24:	00008067          	ret

0000000080005b28 <_ZN8Consumer3runEv>:
    void run() override {
    80005b28:	fd010113          	addi	sp,sp,-48
    80005b2c:	02113423          	sd	ra,40(sp)
    80005b30:	02813023          	sd	s0,32(sp)
    80005b34:	00913c23          	sd	s1,24(sp)
    80005b38:	01213823          	sd	s2,16(sp)
    80005b3c:	01313423          	sd	s3,8(sp)
    80005b40:	03010413          	addi	s0,sp,48
    80005b44:	00050913          	mv	s2,a0
        int i = 0;
    80005b48:	00000993          	li	s3,0
    80005b4c:	0100006f          	j	80005b5c <_ZN8Consumer3runEv+0x34>
        public:
        static char getc (){
            return ::getc();
        }
        static void putc (char c){
            ::putc(c);
    80005b50:	00a00513          	li	a0,10
    80005b54:	ffffc097          	auipc	ra,0xffffc
    80005b58:	a5c080e7          	jalr	-1444(ra) # 800015b0 <_Z4putcc>
        while (!threadEnd) {
    80005b5c:	00009797          	auipc	a5,0x9
    80005b60:	f3c7a783          	lw	a5,-196(a5) # 8000ea98 <_ZL9threadEnd>
    80005b64:	04079a63          	bnez	a5,80005bb8 <_ZN8Consumer3runEv+0x90>
            int key = td->buffer->get();
    80005b68:	02093783          	ld	a5,32(s2)
    80005b6c:	0087b503          	ld	a0,8(a5)
    80005b70:	00001097          	auipc	ra,0x1
    80005b74:	174080e7          	jalr	372(ra) # 80006ce4 <_ZN9BufferCPP3getEv>
            i++;
    80005b78:	0019849b          	addiw	s1,s3,1
    80005b7c:	0004899b          	sext.w	s3,s1
    80005b80:	0ff57513          	andi	a0,a0,255
    80005b84:	ffffc097          	auipc	ra,0xffffc
    80005b88:	a2c080e7          	jalr	-1492(ra) # 800015b0 <_Z4putcc>
            if (i % 80 == 0) {
    80005b8c:	05000793          	li	a5,80
    80005b90:	02f4e4bb          	remw	s1,s1,a5
    80005b94:	fc0494e3          	bnez	s1,80005b5c <_ZN8Consumer3runEv+0x34>
    80005b98:	fb9ff06f          	j	80005b50 <_ZN8Consumer3runEv+0x28>
            int key = td->buffer->get();
    80005b9c:	02093783          	ld	a5,32(s2)
    80005ba0:	0087b503          	ld	a0,8(a5)
    80005ba4:	00001097          	auipc	ra,0x1
    80005ba8:	140080e7          	jalr	320(ra) # 80006ce4 <_ZN9BufferCPP3getEv>
    80005bac:	0ff57513          	andi	a0,a0,255
    80005bb0:	ffffc097          	auipc	ra,0xffffc
    80005bb4:	a00080e7          	jalr	-1536(ra) # 800015b0 <_Z4putcc>
        while (td->buffer->getCnt() > 0) {
    80005bb8:	02093783          	ld	a5,32(s2)
    80005bbc:	0087b503          	ld	a0,8(a5)
    80005bc0:	00001097          	auipc	ra,0x1
    80005bc4:	1c0080e7          	jalr	448(ra) # 80006d80 <_ZN9BufferCPP6getCntEv>
    80005bc8:	fca04ae3          	bgtz	a0,80005b9c <_ZN8Consumer3runEv+0x74>
        td->sem->signal();
    80005bcc:	02093783          	ld	a5,32(s2)
    80005bd0:	0107b783          	ld	a5,16(a5)
            return sem_signal(myHandle);
    80005bd4:	0087b503          	ld	a0,8(a5)
    80005bd8:	ffffc097          	auipc	ra,0xffffc
    80005bdc:	928080e7          	jalr	-1752(ra) # 80001500 <_Z10sem_signalP5sem_s>
    }
    80005be0:	02813083          	ld	ra,40(sp)
    80005be4:	02013403          	ld	s0,32(sp)
    80005be8:	01813483          	ld	s1,24(sp)
    80005bec:	01013903          	ld	s2,16(sp)
    80005bf0:	00813983          	ld	s3,8(sp)
    80005bf4:	03010113          	addi	sp,sp,48
    80005bf8:	00008067          	ret

0000000080005bfc <_ZN16ProducerKeyborad3runEv>:
    void run() override {
    80005bfc:	fe010113          	addi	sp,sp,-32
    80005c00:	00113c23          	sd	ra,24(sp)
    80005c04:	00813823          	sd	s0,16(sp)
    80005c08:	00913423          	sd	s1,8(sp)
    80005c0c:	02010413          	addi	s0,sp,32
    80005c10:	00050493          	mv	s1,a0
        while ((key = getc()) != 13) {
    80005c14:	ffffc097          	auipc	ra,0xffffc
    80005c18:	960080e7          	jalr	-1696(ra) # 80001574 <_Z4getcv>
    80005c1c:	0005059b          	sext.w	a1,a0
    80005c20:	00d00793          	li	a5,13
    80005c24:	00f58c63          	beq	a1,a5,80005c3c <_ZN16ProducerKeyborad3runEv+0x40>
            td->buffer->put(key);
    80005c28:	0204b783          	ld	a5,32(s1)
    80005c2c:	0087b503          	ld	a0,8(a5)
    80005c30:	00001097          	auipc	ra,0x1
    80005c34:	014080e7          	jalr	20(ra) # 80006c44 <_ZN9BufferCPP3putEi>
        while ((key = getc()) != 13) {
    80005c38:	fddff06f          	j	80005c14 <_ZN16ProducerKeyborad3runEv+0x18>
        threadEnd = 1;
    80005c3c:	00100793          	li	a5,1
    80005c40:	00009717          	auipc	a4,0x9
    80005c44:	e4f72c23          	sw	a5,-424(a4) # 8000ea98 <_ZL9threadEnd>
        td->buffer->put('!');
    80005c48:	0204b783          	ld	a5,32(s1)
    80005c4c:	02100593          	li	a1,33
    80005c50:	0087b503          	ld	a0,8(a5)
    80005c54:	00001097          	auipc	ra,0x1
    80005c58:	ff0080e7          	jalr	-16(ra) # 80006c44 <_ZN9BufferCPP3putEi>
        td->sem->signal();
    80005c5c:	0204b783          	ld	a5,32(s1)
    80005c60:	0107b783          	ld	a5,16(a5)
    80005c64:	0087b503          	ld	a0,8(a5)
    80005c68:	ffffc097          	auipc	ra,0xffffc
    80005c6c:	898080e7          	jalr	-1896(ra) # 80001500 <_Z10sem_signalP5sem_s>
    }
    80005c70:	01813083          	ld	ra,24(sp)
    80005c74:	01013403          	ld	s0,16(sp)
    80005c78:	00813483          	ld	s1,8(sp)
    80005c7c:	02010113          	addi	sp,sp,32
    80005c80:	00008067          	ret

0000000080005c84 <_ZN8Producer3runEv>:
    void run() override {
    80005c84:	fe010113          	addi	sp,sp,-32
    80005c88:	00113c23          	sd	ra,24(sp)
    80005c8c:	00813823          	sd	s0,16(sp)
    80005c90:	00913423          	sd	s1,8(sp)
    80005c94:	01213023          	sd	s2,0(sp)
    80005c98:	02010413          	addi	s0,sp,32
    80005c9c:	00050493          	mv	s1,a0
        int i = 0;
    80005ca0:	00000913          	li	s2,0
        while (!threadEnd) {
    80005ca4:	00009797          	auipc	a5,0x9
    80005ca8:	df47a783          	lw	a5,-524(a5) # 8000ea98 <_ZL9threadEnd>
    80005cac:	04079263          	bnez	a5,80005cf0 <_ZN8Producer3runEv+0x6c>
            td->buffer->put(td->id + '0');
    80005cb0:	0204b783          	ld	a5,32(s1)
    80005cb4:	0007a583          	lw	a1,0(a5)
    80005cb8:	0305859b          	addiw	a1,a1,48
    80005cbc:	0087b503          	ld	a0,8(a5)
    80005cc0:	00001097          	auipc	ra,0x1
    80005cc4:	f84080e7          	jalr	-124(ra) # 80006c44 <_ZN9BufferCPP3putEi>
            i++;
    80005cc8:	0019071b          	addiw	a4,s2,1
    80005ccc:	0007091b          	sext.w	s2,a4
            Thread::sleep((i + td->id) % 5);
    80005cd0:	0204b783          	ld	a5,32(s1)
    80005cd4:	0007a783          	lw	a5,0(a5)
    80005cd8:	00e787bb          	addw	a5,a5,a4
            return time_sleep(time);
    80005cdc:	00500513          	li	a0,5
    80005ce0:	02a7e53b          	remw	a0,a5,a0
    80005ce4:	ffffc097          	auipc	ra,0xffffc
    80005ce8:	85c080e7          	jalr	-1956(ra) # 80001540 <_Z10time_sleepm>
    80005cec:	fb9ff06f          	j	80005ca4 <_ZN8Producer3runEv+0x20>
        td->sem->signal();
    80005cf0:	0204b783          	ld	a5,32(s1)
    80005cf4:	0107b783          	ld	a5,16(a5)
            return sem_signal(myHandle);
    80005cf8:	0087b503          	ld	a0,8(a5)
    80005cfc:	ffffc097          	auipc	ra,0xffffc
    80005d00:	804080e7          	jalr	-2044(ra) # 80001500 <_Z10sem_signalP5sem_s>
    }
    80005d04:	01813083          	ld	ra,24(sp)
    80005d08:	01013403          	ld	s0,16(sp)
    80005d0c:	00813483          	ld	s1,8(sp)
    80005d10:	00013903          	ld	s2,0(sp)
    80005d14:	02010113          	addi	sp,sp,32
    80005d18:	00008067          	ret

0000000080005d1c <_ZL9fibonaccim>:
static volatile bool finishedA = false;
static volatile bool finishedB = false;
static volatile bool finishedC = false;
static volatile bool finishedD = false;

static uint64 fibonacci(uint64 n) {
    80005d1c:	fe010113          	addi	sp,sp,-32
    80005d20:	00113c23          	sd	ra,24(sp)
    80005d24:	00813823          	sd	s0,16(sp)
    80005d28:	00913423          	sd	s1,8(sp)
    80005d2c:	01213023          	sd	s2,0(sp)
    80005d30:	02010413          	addi	s0,sp,32
    80005d34:	00050493          	mv	s1,a0
    if (n == 0 || n == 1) { return n; }
    80005d38:	00100793          	li	a5,1
    80005d3c:	02a7f863          	bgeu	a5,a0,80005d6c <_ZL9fibonaccim+0x50>
    if (n % 10 == 0) { thread_dispatch(); }
    80005d40:	00a00793          	li	a5,10
    80005d44:	02f577b3          	remu	a5,a0,a5
    80005d48:	02078e63          	beqz	a5,80005d84 <_ZL9fibonaccim+0x68>
    return fibonacci(n - 1) + fibonacci(n - 2);
    80005d4c:	fff48513          	addi	a0,s1,-1
    80005d50:	00000097          	auipc	ra,0x0
    80005d54:	fcc080e7          	jalr	-52(ra) # 80005d1c <_ZL9fibonaccim>
    80005d58:	00050913          	mv	s2,a0
    80005d5c:	ffe48513          	addi	a0,s1,-2
    80005d60:	00000097          	auipc	ra,0x0
    80005d64:	fbc080e7          	jalr	-68(ra) # 80005d1c <_ZL9fibonaccim>
    80005d68:	00a90533          	add	a0,s2,a0
}
    80005d6c:	01813083          	ld	ra,24(sp)
    80005d70:	01013403          	ld	s0,16(sp)
    80005d74:	00813483          	ld	s1,8(sp)
    80005d78:	00013903          	ld	s2,0(sp)
    80005d7c:	02010113          	addi	sp,sp,32
    80005d80:	00008067          	ret
    if (n % 10 == 0) { thread_dispatch(); }
    80005d84:	ffffb097          	auipc	ra,0xffffb
    80005d88:	604080e7          	jalr	1540(ra) # 80001388 <_Z15thread_dispatchv>
    80005d8c:	fc1ff06f          	j	80005d4c <_ZL9fibonaccim+0x30>

0000000080005d90 <_ZL11workerBodyDPv>:
    printString("A finished!\n");
    finishedC = true;
    thread_dispatch();
}

static void workerBodyD(void* arg) {
    80005d90:	fe010113          	addi	sp,sp,-32
    80005d94:	00113c23          	sd	ra,24(sp)
    80005d98:	00813823          	sd	s0,16(sp)
    80005d9c:	00913423          	sd	s1,8(sp)
    80005da0:	01213023          	sd	s2,0(sp)
    80005da4:	02010413          	addi	s0,sp,32
    uint8 i = 10;
    80005da8:	00a00493          	li	s1,10
    80005dac:	0400006f          	j	80005dec <_ZL11workerBodyDPv+0x5c>
    for (; i < 13; i++) {
        printString("D: i="); printInt(i); printString("\n");
    80005db0:	00004517          	auipc	a0,0x4
    80005db4:	77050513          	addi	a0,a0,1904 # 8000a520 <CONSOLE_STATUS+0x510>
    80005db8:	ffffc097          	auipc	ra,0xffffc
    80005dbc:	0f4080e7          	jalr	244(ra) # 80001eac <_Z11printStringPKc>
    80005dc0:	00000613          	li	a2,0
    80005dc4:	00a00593          	li	a1,10
    80005dc8:	00048513          	mv	a0,s1
    80005dcc:	ffffc097          	auipc	ra,0xffffc
    80005dd0:	290080e7          	jalr	656(ra) # 8000205c <_Z8printIntiii>
    80005dd4:	00005517          	auipc	a0,0x5
    80005dd8:	93c50513          	addi	a0,a0,-1732 # 8000a710 <CONSOLE_STATUS+0x700>
    80005ddc:	ffffc097          	auipc	ra,0xffffc
    80005de0:	0d0080e7          	jalr	208(ra) # 80001eac <_Z11printStringPKc>
    for (; i < 13; i++) {
    80005de4:	0014849b          	addiw	s1,s1,1
    80005de8:	0ff4f493          	andi	s1,s1,255
    80005dec:	00c00793          	li	a5,12
    80005df0:	fc97f0e3          	bgeu	a5,s1,80005db0 <_ZL11workerBodyDPv+0x20>
    }

    printString("D: dispatch\n");
    80005df4:	00004517          	auipc	a0,0x4
    80005df8:	73450513          	addi	a0,a0,1844 # 8000a528 <CONSOLE_STATUS+0x518>
    80005dfc:	ffffc097          	auipc	ra,0xffffc
    80005e00:	0b0080e7          	jalr	176(ra) # 80001eac <_Z11printStringPKc>
    __asm__ ("li t1, 5");
    80005e04:	00500313          	li	t1,5
    thread_dispatch();
    80005e08:	ffffb097          	auipc	ra,0xffffb
    80005e0c:	580080e7          	jalr	1408(ra) # 80001388 <_Z15thread_dispatchv>

    uint64 result = fibonacci(16);
    80005e10:	01000513          	li	a0,16
    80005e14:	00000097          	auipc	ra,0x0
    80005e18:	f08080e7          	jalr	-248(ra) # 80005d1c <_ZL9fibonaccim>
    80005e1c:	00050913          	mv	s2,a0
    printString("D: fibonaci="); printInt(result); printString("\n");
    80005e20:	00004517          	auipc	a0,0x4
    80005e24:	71850513          	addi	a0,a0,1816 # 8000a538 <CONSOLE_STATUS+0x528>
    80005e28:	ffffc097          	auipc	ra,0xffffc
    80005e2c:	084080e7          	jalr	132(ra) # 80001eac <_Z11printStringPKc>
    80005e30:	00000613          	li	a2,0
    80005e34:	00a00593          	li	a1,10
    80005e38:	0009051b          	sext.w	a0,s2
    80005e3c:	ffffc097          	auipc	ra,0xffffc
    80005e40:	220080e7          	jalr	544(ra) # 8000205c <_Z8printIntiii>
    80005e44:	00005517          	auipc	a0,0x5
    80005e48:	8cc50513          	addi	a0,a0,-1844 # 8000a710 <CONSOLE_STATUS+0x700>
    80005e4c:	ffffc097          	auipc	ra,0xffffc
    80005e50:	060080e7          	jalr	96(ra) # 80001eac <_Z11printStringPKc>
    80005e54:	0400006f          	j	80005e94 <_ZL11workerBodyDPv+0x104>

    for (; i < 16; i++) {
        printString("D: i="); printInt(i); printString("\n");
    80005e58:	00004517          	auipc	a0,0x4
    80005e5c:	6c850513          	addi	a0,a0,1736 # 8000a520 <CONSOLE_STATUS+0x510>
    80005e60:	ffffc097          	auipc	ra,0xffffc
    80005e64:	04c080e7          	jalr	76(ra) # 80001eac <_Z11printStringPKc>
    80005e68:	00000613          	li	a2,0
    80005e6c:	00a00593          	li	a1,10
    80005e70:	00048513          	mv	a0,s1
    80005e74:	ffffc097          	auipc	ra,0xffffc
    80005e78:	1e8080e7          	jalr	488(ra) # 8000205c <_Z8printIntiii>
    80005e7c:	00005517          	auipc	a0,0x5
    80005e80:	89450513          	addi	a0,a0,-1900 # 8000a710 <CONSOLE_STATUS+0x700>
    80005e84:	ffffc097          	auipc	ra,0xffffc
    80005e88:	028080e7          	jalr	40(ra) # 80001eac <_Z11printStringPKc>
    for (; i < 16; i++) {
    80005e8c:	0014849b          	addiw	s1,s1,1
    80005e90:	0ff4f493          	andi	s1,s1,255
    80005e94:	00f00793          	li	a5,15
    80005e98:	fc97f0e3          	bgeu	a5,s1,80005e58 <_ZL11workerBodyDPv+0xc8>
    }

    printString("D finished!\n");
    80005e9c:	00004517          	auipc	a0,0x4
    80005ea0:	6ac50513          	addi	a0,a0,1708 # 8000a548 <CONSOLE_STATUS+0x538>
    80005ea4:	ffffc097          	auipc	ra,0xffffc
    80005ea8:	008080e7          	jalr	8(ra) # 80001eac <_Z11printStringPKc>
    finishedD = true;
    80005eac:	00100793          	li	a5,1
    80005eb0:	00009717          	auipc	a4,0x9
    80005eb4:	bef70c23          	sb	a5,-1032(a4) # 8000eaa8 <_ZL9finishedD>
    thread_dispatch();
    80005eb8:	ffffb097          	auipc	ra,0xffffb
    80005ebc:	4d0080e7          	jalr	1232(ra) # 80001388 <_Z15thread_dispatchv>
}
    80005ec0:	01813083          	ld	ra,24(sp)
    80005ec4:	01013403          	ld	s0,16(sp)
    80005ec8:	00813483          	ld	s1,8(sp)
    80005ecc:	00013903          	ld	s2,0(sp)
    80005ed0:	02010113          	addi	sp,sp,32
    80005ed4:	00008067          	ret

0000000080005ed8 <_ZL11workerBodyCPv>:
static void workerBodyC(void* arg) {
    80005ed8:	fe010113          	addi	sp,sp,-32
    80005edc:	00113c23          	sd	ra,24(sp)
    80005ee0:	00813823          	sd	s0,16(sp)
    80005ee4:	00913423          	sd	s1,8(sp)
    80005ee8:	01213023          	sd	s2,0(sp)
    80005eec:	02010413          	addi	s0,sp,32
    uint8 i = 0;
    80005ef0:	00000493          	li	s1,0
    80005ef4:	0400006f          	j	80005f34 <_ZL11workerBodyCPv+0x5c>
        printString("C: i="); printInt(i); printString("\n");
    80005ef8:	00004517          	auipc	a0,0x4
    80005efc:	5f850513          	addi	a0,a0,1528 # 8000a4f0 <CONSOLE_STATUS+0x4e0>
    80005f00:	ffffc097          	auipc	ra,0xffffc
    80005f04:	fac080e7          	jalr	-84(ra) # 80001eac <_Z11printStringPKc>
    80005f08:	00000613          	li	a2,0
    80005f0c:	00a00593          	li	a1,10
    80005f10:	00048513          	mv	a0,s1
    80005f14:	ffffc097          	auipc	ra,0xffffc
    80005f18:	148080e7          	jalr	328(ra) # 8000205c <_Z8printIntiii>
    80005f1c:	00004517          	auipc	a0,0x4
    80005f20:	7f450513          	addi	a0,a0,2036 # 8000a710 <CONSOLE_STATUS+0x700>
    80005f24:	ffffc097          	auipc	ra,0xffffc
    80005f28:	f88080e7          	jalr	-120(ra) # 80001eac <_Z11printStringPKc>
    for (; i < 3; i++) {
    80005f2c:	0014849b          	addiw	s1,s1,1
    80005f30:	0ff4f493          	andi	s1,s1,255
    80005f34:	00200793          	li	a5,2
    80005f38:	fc97f0e3          	bgeu	a5,s1,80005ef8 <_ZL11workerBodyCPv+0x20>
    printString("C: dispatch\n");
    80005f3c:	00004517          	auipc	a0,0x4
    80005f40:	5bc50513          	addi	a0,a0,1468 # 8000a4f8 <CONSOLE_STATUS+0x4e8>
    80005f44:	ffffc097          	auipc	ra,0xffffc
    80005f48:	f68080e7          	jalr	-152(ra) # 80001eac <_Z11printStringPKc>
    __asm__ ("li t1, 7");
    80005f4c:	00700313          	li	t1,7
    thread_dispatch();
    80005f50:	ffffb097          	auipc	ra,0xffffb
    80005f54:	438080e7          	jalr	1080(ra) # 80001388 <_Z15thread_dispatchv>
    __asm__ ("mv %[t1], t1" : [t1] "=r"(t1));
    80005f58:	00030913          	mv	s2,t1
    printString("C: t1="); printInt(t1); printString("\n");
    80005f5c:	00004517          	auipc	a0,0x4
    80005f60:	5ac50513          	addi	a0,a0,1452 # 8000a508 <CONSOLE_STATUS+0x4f8>
    80005f64:	ffffc097          	auipc	ra,0xffffc
    80005f68:	f48080e7          	jalr	-184(ra) # 80001eac <_Z11printStringPKc>
    80005f6c:	00000613          	li	a2,0
    80005f70:	00a00593          	li	a1,10
    80005f74:	0009051b          	sext.w	a0,s2
    80005f78:	ffffc097          	auipc	ra,0xffffc
    80005f7c:	0e4080e7          	jalr	228(ra) # 8000205c <_Z8printIntiii>
    80005f80:	00004517          	auipc	a0,0x4
    80005f84:	79050513          	addi	a0,a0,1936 # 8000a710 <CONSOLE_STATUS+0x700>
    80005f88:	ffffc097          	auipc	ra,0xffffc
    80005f8c:	f24080e7          	jalr	-220(ra) # 80001eac <_Z11printStringPKc>
    uint64 result = fibonacci(12);
    80005f90:	00c00513          	li	a0,12
    80005f94:	00000097          	auipc	ra,0x0
    80005f98:	d88080e7          	jalr	-632(ra) # 80005d1c <_ZL9fibonaccim>
    80005f9c:	00050913          	mv	s2,a0
    printString("C: fibonaci="); printInt(result); printString("\n");
    80005fa0:	00004517          	auipc	a0,0x4
    80005fa4:	57050513          	addi	a0,a0,1392 # 8000a510 <CONSOLE_STATUS+0x500>
    80005fa8:	ffffc097          	auipc	ra,0xffffc
    80005fac:	f04080e7          	jalr	-252(ra) # 80001eac <_Z11printStringPKc>
    80005fb0:	00000613          	li	a2,0
    80005fb4:	00a00593          	li	a1,10
    80005fb8:	0009051b          	sext.w	a0,s2
    80005fbc:	ffffc097          	auipc	ra,0xffffc
    80005fc0:	0a0080e7          	jalr	160(ra) # 8000205c <_Z8printIntiii>
    80005fc4:	00004517          	auipc	a0,0x4
    80005fc8:	74c50513          	addi	a0,a0,1868 # 8000a710 <CONSOLE_STATUS+0x700>
    80005fcc:	ffffc097          	auipc	ra,0xffffc
    80005fd0:	ee0080e7          	jalr	-288(ra) # 80001eac <_Z11printStringPKc>
    80005fd4:	0400006f          	j	80006014 <_ZL11workerBodyCPv+0x13c>
        printString("C: i="); printInt(i); printString("\n");
    80005fd8:	00004517          	auipc	a0,0x4
    80005fdc:	51850513          	addi	a0,a0,1304 # 8000a4f0 <CONSOLE_STATUS+0x4e0>
    80005fe0:	ffffc097          	auipc	ra,0xffffc
    80005fe4:	ecc080e7          	jalr	-308(ra) # 80001eac <_Z11printStringPKc>
    80005fe8:	00000613          	li	a2,0
    80005fec:	00a00593          	li	a1,10
    80005ff0:	00048513          	mv	a0,s1
    80005ff4:	ffffc097          	auipc	ra,0xffffc
    80005ff8:	068080e7          	jalr	104(ra) # 8000205c <_Z8printIntiii>
    80005ffc:	00004517          	auipc	a0,0x4
    80006000:	71450513          	addi	a0,a0,1812 # 8000a710 <CONSOLE_STATUS+0x700>
    80006004:	ffffc097          	auipc	ra,0xffffc
    80006008:	ea8080e7          	jalr	-344(ra) # 80001eac <_Z11printStringPKc>
    for (; i < 6; i++) {
    8000600c:	0014849b          	addiw	s1,s1,1
    80006010:	0ff4f493          	andi	s1,s1,255
    80006014:	00500793          	li	a5,5
    80006018:	fc97f0e3          	bgeu	a5,s1,80005fd8 <_ZL11workerBodyCPv+0x100>
    printString("A finished!\n");
    8000601c:	00004517          	auipc	a0,0x4
    80006020:	4ac50513          	addi	a0,a0,1196 # 8000a4c8 <CONSOLE_STATUS+0x4b8>
    80006024:	ffffc097          	auipc	ra,0xffffc
    80006028:	e88080e7          	jalr	-376(ra) # 80001eac <_Z11printStringPKc>
    finishedC = true;
    8000602c:	00100793          	li	a5,1
    80006030:	00009717          	auipc	a4,0x9
    80006034:	a6f70ca3          	sb	a5,-1415(a4) # 8000eaa9 <_ZL9finishedC>
    thread_dispatch();
    80006038:	ffffb097          	auipc	ra,0xffffb
    8000603c:	350080e7          	jalr	848(ra) # 80001388 <_Z15thread_dispatchv>
}
    80006040:	01813083          	ld	ra,24(sp)
    80006044:	01013403          	ld	s0,16(sp)
    80006048:	00813483          	ld	s1,8(sp)
    8000604c:	00013903          	ld	s2,0(sp)
    80006050:	02010113          	addi	sp,sp,32
    80006054:	00008067          	ret

0000000080006058 <_ZL11workerBodyBPv>:
static void workerBodyB(void* arg) {
    80006058:	fe010113          	addi	sp,sp,-32
    8000605c:	00113c23          	sd	ra,24(sp)
    80006060:	00813823          	sd	s0,16(sp)
    80006064:	00913423          	sd	s1,8(sp)
    80006068:	01213023          	sd	s2,0(sp)
    8000606c:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 16; i++) {
    80006070:	00000913          	li	s2,0
    80006074:	0380006f          	j	800060ac <_ZL11workerBodyBPv+0x54>
            thread_dispatch();
    80006078:	ffffb097          	auipc	ra,0xffffb
    8000607c:	310080e7          	jalr	784(ra) # 80001388 <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++) {
    80006080:	00148493          	addi	s1,s1,1
    80006084:	000027b7          	lui	a5,0x2
    80006088:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    8000608c:	0097ee63          	bltu	a5,s1,800060a8 <_ZL11workerBodyBPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    80006090:	00000713          	li	a4,0
    80006094:	000077b7          	lui	a5,0x7
    80006098:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    8000609c:	fce7eee3          	bltu	a5,a4,80006078 <_ZL11workerBodyBPv+0x20>
    800060a0:	00170713          	addi	a4,a4,1
    800060a4:	ff1ff06f          	j	80006094 <_ZL11workerBodyBPv+0x3c>
    for (uint64 i = 0; i < 16; i++) {
    800060a8:	00190913          	addi	s2,s2,1
    800060ac:	00f00793          	li	a5,15
    800060b0:	0527e063          	bltu	a5,s2,800060f0 <_ZL11workerBodyBPv+0x98>
        printString("B: i="); printInt(i); printString("\n");
    800060b4:	00004517          	auipc	a0,0x4
    800060b8:	42450513          	addi	a0,a0,1060 # 8000a4d8 <CONSOLE_STATUS+0x4c8>
    800060bc:	ffffc097          	auipc	ra,0xffffc
    800060c0:	df0080e7          	jalr	-528(ra) # 80001eac <_Z11printStringPKc>
    800060c4:	00000613          	li	a2,0
    800060c8:	00a00593          	li	a1,10
    800060cc:	0009051b          	sext.w	a0,s2
    800060d0:	ffffc097          	auipc	ra,0xffffc
    800060d4:	f8c080e7          	jalr	-116(ra) # 8000205c <_Z8printIntiii>
    800060d8:	00004517          	auipc	a0,0x4
    800060dc:	63850513          	addi	a0,a0,1592 # 8000a710 <CONSOLE_STATUS+0x700>
    800060e0:	ffffc097          	auipc	ra,0xffffc
    800060e4:	dcc080e7          	jalr	-564(ra) # 80001eac <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    800060e8:	00000493          	li	s1,0
    800060ec:	f99ff06f          	j	80006084 <_ZL11workerBodyBPv+0x2c>
    printString("B finished!\n");
    800060f0:	00004517          	auipc	a0,0x4
    800060f4:	3f050513          	addi	a0,a0,1008 # 8000a4e0 <CONSOLE_STATUS+0x4d0>
    800060f8:	ffffc097          	auipc	ra,0xffffc
    800060fc:	db4080e7          	jalr	-588(ra) # 80001eac <_Z11printStringPKc>
    finishedB = true;
    80006100:	00100793          	li	a5,1
    80006104:	00009717          	auipc	a4,0x9
    80006108:	9af70323          	sb	a5,-1626(a4) # 8000eaaa <_ZL9finishedB>
    thread_dispatch();
    8000610c:	ffffb097          	auipc	ra,0xffffb
    80006110:	27c080e7          	jalr	636(ra) # 80001388 <_Z15thread_dispatchv>
}
    80006114:	01813083          	ld	ra,24(sp)
    80006118:	01013403          	ld	s0,16(sp)
    8000611c:	00813483          	ld	s1,8(sp)
    80006120:	00013903          	ld	s2,0(sp)
    80006124:	02010113          	addi	sp,sp,32
    80006128:	00008067          	ret

000000008000612c <_ZL11workerBodyAPv>:
static void workerBodyA(void* arg) {
    8000612c:	fe010113          	addi	sp,sp,-32
    80006130:	00113c23          	sd	ra,24(sp)
    80006134:	00813823          	sd	s0,16(sp)
    80006138:	00913423          	sd	s1,8(sp)
    8000613c:	01213023          	sd	s2,0(sp)
    80006140:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 10; i++) {
    80006144:	00000913          	li	s2,0
    80006148:	0380006f          	j	80006180 <_ZL11workerBodyAPv+0x54>
            thread_dispatch();
    8000614c:	ffffb097          	auipc	ra,0xffffb
    80006150:	23c080e7          	jalr	572(ra) # 80001388 <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++) {
    80006154:	00148493          	addi	s1,s1,1
    80006158:	000027b7          	lui	a5,0x2
    8000615c:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    80006160:	0097ee63          	bltu	a5,s1,8000617c <_ZL11workerBodyAPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    80006164:	00000713          	li	a4,0
    80006168:	000077b7          	lui	a5,0x7
    8000616c:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    80006170:	fce7eee3          	bltu	a5,a4,8000614c <_ZL11workerBodyAPv+0x20>
    80006174:	00170713          	addi	a4,a4,1
    80006178:	ff1ff06f          	j	80006168 <_ZL11workerBodyAPv+0x3c>
    for (uint64 i = 0; i < 10; i++) {
    8000617c:	00190913          	addi	s2,s2,1
    80006180:	00900793          	li	a5,9
    80006184:	0527e063          	bltu	a5,s2,800061c4 <_ZL11workerBodyAPv+0x98>
        printString("A: i="); printInt(i); printString("\n");
    80006188:	00004517          	auipc	a0,0x4
    8000618c:	33850513          	addi	a0,a0,824 # 8000a4c0 <CONSOLE_STATUS+0x4b0>
    80006190:	ffffc097          	auipc	ra,0xffffc
    80006194:	d1c080e7          	jalr	-740(ra) # 80001eac <_Z11printStringPKc>
    80006198:	00000613          	li	a2,0
    8000619c:	00a00593          	li	a1,10
    800061a0:	0009051b          	sext.w	a0,s2
    800061a4:	ffffc097          	auipc	ra,0xffffc
    800061a8:	eb8080e7          	jalr	-328(ra) # 8000205c <_Z8printIntiii>
    800061ac:	00004517          	auipc	a0,0x4
    800061b0:	56450513          	addi	a0,a0,1380 # 8000a710 <CONSOLE_STATUS+0x700>
    800061b4:	ffffc097          	auipc	ra,0xffffc
    800061b8:	cf8080e7          	jalr	-776(ra) # 80001eac <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    800061bc:	00000493          	li	s1,0
    800061c0:	f99ff06f          	j	80006158 <_ZL11workerBodyAPv+0x2c>
    printString("A finished!\n");
    800061c4:	00004517          	auipc	a0,0x4
    800061c8:	30450513          	addi	a0,a0,772 # 8000a4c8 <CONSOLE_STATUS+0x4b8>
    800061cc:	ffffc097          	auipc	ra,0xffffc
    800061d0:	ce0080e7          	jalr	-800(ra) # 80001eac <_Z11printStringPKc>
    finishedA = true;
    800061d4:	00100793          	li	a5,1
    800061d8:	00009717          	auipc	a4,0x9
    800061dc:	8cf709a3          	sb	a5,-1837(a4) # 8000eaab <_ZL9finishedA>
}
    800061e0:	01813083          	ld	ra,24(sp)
    800061e4:	01013403          	ld	s0,16(sp)
    800061e8:	00813483          	ld	s1,8(sp)
    800061ec:	00013903          	ld	s2,0(sp)
    800061f0:	02010113          	addi	sp,sp,32
    800061f4:	00008067          	ret

00000000800061f8 <_Z18Threads_C_API_testv>:


void Threads_C_API_test() {
    800061f8:	fd010113          	addi	sp,sp,-48
    800061fc:	02113423          	sd	ra,40(sp)
    80006200:	02813023          	sd	s0,32(sp)
    80006204:	03010413          	addi	s0,sp,48
    thread_t threads[4];
    thread_create(&threads[0], workerBodyA, nullptr);
    80006208:	00000613          	li	a2,0
    8000620c:	00000597          	auipc	a1,0x0
    80006210:	f2058593          	addi	a1,a1,-224 # 8000612c <_ZL11workerBodyAPv>
    80006214:	fd040513          	addi	a0,s0,-48
    80006218:	ffffb097          	auipc	ra,0xffffb
    8000621c:	0e8080e7          	jalr	232(ra) # 80001300 <_Z13thread_createPP8thread_sPFvPvES2_>
    printString("ThreadA created\n");
    80006220:	00004517          	auipc	a0,0x4
    80006224:	33850513          	addi	a0,a0,824 # 8000a558 <CONSOLE_STATUS+0x548>
    80006228:	ffffc097          	auipc	ra,0xffffc
    8000622c:	c84080e7          	jalr	-892(ra) # 80001eac <_Z11printStringPKc>

    thread_create(&threads[1], workerBodyB, nullptr);
    80006230:	00000613          	li	a2,0
    80006234:	00000597          	auipc	a1,0x0
    80006238:	e2458593          	addi	a1,a1,-476 # 80006058 <_ZL11workerBodyBPv>
    8000623c:	fd840513          	addi	a0,s0,-40
    80006240:	ffffb097          	auipc	ra,0xffffb
    80006244:	0c0080e7          	jalr	192(ra) # 80001300 <_Z13thread_createPP8thread_sPFvPvES2_>
    printString("ThreadB created\n");
    80006248:	00004517          	auipc	a0,0x4
    8000624c:	32850513          	addi	a0,a0,808 # 8000a570 <CONSOLE_STATUS+0x560>
    80006250:	ffffc097          	auipc	ra,0xffffc
    80006254:	c5c080e7          	jalr	-932(ra) # 80001eac <_Z11printStringPKc>

    thread_create(&threads[2], workerBodyC, nullptr);
    80006258:	00000613          	li	a2,0
    8000625c:	00000597          	auipc	a1,0x0
    80006260:	c7c58593          	addi	a1,a1,-900 # 80005ed8 <_ZL11workerBodyCPv>
    80006264:	fe040513          	addi	a0,s0,-32
    80006268:	ffffb097          	auipc	ra,0xffffb
    8000626c:	098080e7          	jalr	152(ra) # 80001300 <_Z13thread_createPP8thread_sPFvPvES2_>
    printString("ThreadC created\n");
    80006270:	00004517          	auipc	a0,0x4
    80006274:	31850513          	addi	a0,a0,792 # 8000a588 <CONSOLE_STATUS+0x578>
    80006278:	ffffc097          	auipc	ra,0xffffc
    8000627c:	c34080e7          	jalr	-972(ra) # 80001eac <_Z11printStringPKc>

    thread_create(&threads[3], workerBodyD, nullptr);
    80006280:	00000613          	li	a2,0
    80006284:	00000597          	auipc	a1,0x0
    80006288:	b0c58593          	addi	a1,a1,-1268 # 80005d90 <_ZL11workerBodyDPv>
    8000628c:	fe840513          	addi	a0,s0,-24
    80006290:	ffffb097          	auipc	ra,0xffffb
    80006294:	070080e7          	jalr	112(ra) # 80001300 <_Z13thread_createPP8thread_sPFvPvES2_>
    printString("ThreadD created\n");
    80006298:	00004517          	auipc	a0,0x4
    8000629c:	30850513          	addi	a0,a0,776 # 8000a5a0 <CONSOLE_STATUS+0x590>
    800062a0:	ffffc097          	auipc	ra,0xffffc
    800062a4:	c0c080e7          	jalr	-1012(ra) # 80001eac <_Z11printStringPKc>
    800062a8:	00c0006f          	j	800062b4 <_Z18Threads_C_API_testv+0xbc>

    while (!(finishedA && finishedB && finishedC && finishedD)) {
        thread_dispatch();
    800062ac:	ffffb097          	auipc	ra,0xffffb
    800062b0:	0dc080e7          	jalr	220(ra) # 80001388 <_Z15thread_dispatchv>
    while (!(finishedA && finishedB && finishedC && finishedD)) {
    800062b4:	00008797          	auipc	a5,0x8
    800062b8:	7f77c783          	lbu	a5,2039(a5) # 8000eaab <_ZL9finishedA>
    800062bc:	fe0788e3          	beqz	a5,800062ac <_Z18Threads_C_API_testv+0xb4>
    800062c0:	00008797          	auipc	a5,0x8
    800062c4:	7ea7c783          	lbu	a5,2026(a5) # 8000eaaa <_ZL9finishedB>
    800062c8:	fe0782e3          	beqz	a5,800062ac <_Z18Threads_C_API_testv+0xb4>
    800062cc:	00008797          	auipc	a5,0x8
    800062d0:	7dd7c783          	lbu	a5,2013(a5) # 8000eaa9 <_ZL9finishedC>
    800062d4:	fc078ce3          	beqz	a5,800062ac <_Z18Threads_C_API_testv+0xb4>
    800062d8:	00008797          	auipc	a5,0x8
    800062dc:	7d07c783          	lbu	a5,2000(a5) # 8000eaa8 <_ZL9finishedD>
    800062e0:	fc0786e3          	beqz	a5,800062ac <_Z18Threads_C_API_testv+0xb4>
    }

}
    800062e4:	02813083          	ld	ra,40(sp)
    800062e8:	02013403          	ld	s0,32(sp)
    800062ec:	03010113          	addi	sp,sp,48
    800062f0:	00008067          	ret

00000000800062f4 <_ZN16ProducerKeyboard16producerKeyboardEPv>:
    void run() override {
        producerKeyboard(td);
    }
};

void ProducerKeyboard::producerKeyboard(void *arg) {
    800062f4:	fd010113          	addi	sp,sp,-48
    800062f8:	02113423          	sd	ra,40(sp)
    800062fc:	02813023          	sd	s0,32(sp)
    80006300:	00913c23          	sd	s1,24(sp)
    80006304:	01213823          	sd	s2,16(sp)
    80006308:	01313423          	sd	s3,8(sp)
    8000630c:	03010413          	addi	s0,sp,48
    80006310:	00050993          	mv	s3,a0
    80006314:	00058493          	mv	s1,a1
    struct thread_data *data = (struct thread_data *) arg;

    int key;
    int i = 0;
    80006318:	00000913          	li	s2,0
    8000631c:	00c0006f          	j	80006328 <_ZN16ProducerKeyboard16producerKeyboardEPv+0x34>
            thread_dispatch();
    80006320:	ffffb097          	auipc	ra,0xffffb
    80006324:	068080e7          	jalr	104(ra) # 80001388 <_Z15thread_dispatchv>
    while ((key = getc()) != 13) {
    80006328:	ffffb097          	auipc	ra,0xffffb
    8000632c:	24c080e7          	jalr	588(ra) # 80001574 <_Z4getcv>
    80006330:	0005059b          	sext.w	a1,a0
    80006334:	00d00793          	li	a5,13
    80006338:	02f58a63          	beq	a1,a5,8000636c <_ZN16ProducerKeyboard16producerKeyboardEPv+0x78>
        data->buffer->put(key);
    8000633c:	0084b503          	ld	a0,8(s1)
    80006340:	00001097          	auipc	ra,0x1
    80006344:	904080e7          	jalr	-1788(ra) # 80006c44 <_ZN9BufferCPP3putEi>
        i++;
    80006348:	0019071b          	addiw	a4,s2,1
    8000634c:	0007091b          	sext.w	s2,a4

        if (i % (10 * data->id) == 0) {
    80006350:	0004a683          	lw	a3,0(s1)
    80006354:	0026979b          	slliw	a5,a3,0x2
    80006358:	00d787bb          	addw	a5,a5,a3
    8000635c:	0017979b          	slliw	a5,a5,0x1
    80006360:	02f767bb          	remw	a5,a4,a5
    80006364:	fc0792e3          	bnez	a5,80006328 <_ZN16ProducerKeyboard16producerKeyboardEPv+0x34>
    80006368:	fb9ff06f          	j	80006320 <_ZN16ProducerKeyboard16producerKeyboardEPv+0x2c>
            Thread::dispatch();
        }
    }

    threadEnd = 1;
    8000636c:	00100793          	li	a5,1
    80006370:	00008717          	auipc	a4,0x8
    80006374:	74f72023          	sw	a5,1856(a4) # 8000eab0 <_ZL9threadEnd>
    td->buffer->put('!');
    80006378:	0209b783          	ld	a5,32(s3)
    8000637c:	02100593          	li	a1,33
    80006380:	0087b503          	ld	a0,8(a5)
    80006384:	00001097          	auipc	ra,0x1
    80006388:	8c0080e7          	jalr	-1856(ra) # 80006c44 <_ZN9BufferCPP3putEi>

    data->wait->signal();
    8000638c:	0104b783          	ld	a5,16(s1)
            return sem_signal(myHandle);
    80006390:	0087b503          	ld	a0,8(a5)
    80006394:	ffffb097          	auipc	ra,0xffffb
    80006398:	16c080e7          	jalr	364(ra) # 80001500 <_Z10sem_signalP5sem_s>
}
    8000639c:	02813083          	ld	ra,40(sp)
    800063a0:	02013403          	ld	s0,32(sp)
    800063a4:	01813483          	ld	s1,24(sp)
    800063a8:	01013903          	ld	s2,16(sp)
    800063ac:	00813983          	ld	s3,8(sp)
    800063b0:	03010113          	addi	sp,sp,48
    800063b4:	00008067          	ret

00000000800063b8 <_ZN12ProducerSync8producerEPv>:
    void run() override {
        producer(td);
    }
};

void ProducerSync::producer(void *arg) {
    800063b8:	fe010113          	addi	sp,sp,-32
    800063bc:	00113c23          	sd	ra,24(sp)
    800063c0:	00813823          	sd	s0,16(sp)
    800063c4:	00913423          	sd	s1,8(sp)
    800063c8:	01213023          	sd	s2,0(sp)
    800063cc:	02010413          	addi	s0,sp,32
    800063d0:	00058493          	mv	s1,a1
    struct thread_data *data = (struct thread_data *) arg;

    int i = 0;
    800063d4:	00000913          	li	s2,0
    800063d8:	00c0006f          	j	800063e4 <_ZN12ProducerSync8producerEPv+0x2c>
            thread_dispatch();
    800063dc:	ffffb097          	auipc	ra,0xffffb
    800063e0:	fac080e7          	jalr	-84(ra) # 80001388 <_Z15thread_dispatchv>
    while (!threadEnd) {
    800063e4:	00008797          	auipc	a5,0x8
    800063e8:	6cc7a783          	lw	a5,1740(a5) # 8000eab0 <_ZL9threadEnd>
    800063ec:	02079e63          	bnez	a5,80006428 <_ZN12ProducerSync8producerEPv+0x70>
        data->buffer->put(data->id + '0');
    800063f0:	0004a583          	lw	a1,0(s1)
    800063f4:	0305859b          	addiw	a1,a1,48
    800063f8:	0084b503          	ld	a0,8(s1)
    800063fc:	00001097          	auipc	ra,0x1
    80006400:	848080e7          	jalr	-1976(ra) # 80006c44 <_ZN9BufferCPP3putEi>
        i++;
    80006404:	0019071b          	addiw	a4,s2,1
    80006408:	0007091b          	sext.w	s2,a4

        if (i % (10 * data->id) == 0) {
    8000640c:	0004a683          	lw	a3,0(s1)
    80006410:	0026979b          	slliw	a5,a3,0x2
    80006414:	00d787bb          	addw	a5,a5,a3
    80006418:	0017979b          	slliw	a5,a5,0x1
    8000641c:	02f767bb          	remw	a5,a4,a5
    80006420:	fc0792e3          	bnez	a5,800063e4 <_ZN12ProducerSync8producerEPv+0x2c>
    80006424:	fb9ff06f          	j	800063dc <_ZN12ProducerSync8producerEPv+0x24>
            Thread::dispatch();
        }
    }

    data->wait->signal();
    80006428:	0104b783          	ld	a5,16(s1)
            return sem_signal(myHandle);
    8000642c:	0087b503          	ld	a0,8(a5)
    80006430:	ffffb097          	auipc	ra,0xffffb
    80006434:	0d0080e7          	jalr	208(ra) # 80001500 <_Z10sem_signalP5sem_s>
}
    80006438:	01813083          	ld	ra,24(sp)
    8000643c:	01013403          	ld	s0,16(sp)
    80006440:	00813483          	ld	s1,8(sp)
    80006444:	00013903          	ld	s2,0(sp)
    80006448:	02010113          	addi	sp,sp,32
    8000644c:	00008067          	ret

0000000080006450 <_ZN12ConsumerSync8consumerEPv>:
    void run() override {
        consumer(td);
    }
};

void ConsumerSync::consumer(void *arg) {
    80006450:	fd010113          	addi	sp,sp,-48
    80006454:	02113423          	sd	ra,40(sp)
    80006458:	02813023          	sd	s0,32(sp)
    8000645c:	00913c23          	sd	s1,24(sp)
    80006460:	01213823          	sd	s2,16(sp)
    80006464:	01313423          	sd	s3,8(sp)
    80006468:	01413023          	sd	s4,0(sp)
    8000646c:	03010413          	addi	s0,sp,48
    80006470:	00050993          	mv	s3,a0
    80006474:	00058913          	mv	s2,a1
    struct thread_data *data = (struct thread_data *) arg;

    int i = 0;
    80006478:	00000a13          	li	s4,0
    8000647c:	01c0006f          	j	80006498 <_ZN12ConsumerSync8consumerEPv+0x48>
            thread_dispatch();
    80006480:	ffffb097          	auipc	ra,0xffffb
    80006484:	f08080e7          	jalr	-248(ra) # 80001388 <_Z15thread_dispatchv>
        }
    80006488:	0500006f          	j	800064d8 <_ZN12ConsumerSync8consumerEPv+0x88>
        if (i % (5 * data->id) == 0) {
            Thread::dispatch();
        }

        if (i % 80 == 0) {
            putc('\n');
    8000648c:	00a00513          	li	a0,10
    80006490:	ffffb097          	auipc	ra,0xffffb
    80006494:	120080e7          	jalr	288(ra) # 800015b0 <_Z4putcc>
    while (!threadEnd) {
    80006498:	00008797          	auipc	a5,0x8
    8000649c:	6187a783          	lw	a5,1560(a5) # 8000eab0 <_ZL9threadEnd>
    800064a0:	06079263          	bnez	a5,80006504 <_ZN12ConsumerSync8consumerEPv+0xb4>
        int key = data->buffer->get();
    800064a4:	00893503          	ld	a0,8(s2)
    800064a8:	00001097          	auipc	ra,0x1
    800064ac:	83c080e7          	jalr	-1988(ra) # 80006ce4 <_ZN9BufferCPP3getEv>
        i++;
    800064b0:	001a049b          	addiw	s1,s4,1
    800064b4:	00048a1b          	sext.w	s4,s1
        putc(key);
    800064b8:	0ff57513          	andi	a0,a0,255
    800064bc:	ffffb097          	auipc	ra,0xffffb
    800064c0:	0f4080e7          	jalr	244(ra) # 800015b0 <_Z4putcc>
        if (i % (5 * data->id) == 0) {
    800064c4:	00092703          	lw	a4,0(s2)
    800064c8:	0027179b          	slliw	a5,a4,0x2
    800064cc:	00e787bb          	addw	a5,a5,a4
    800064d0:	02f4e7bb          	remw	a5,s1,a5
    800064d4:	fa0786e3          	beqz	a5,80006480 <_ZN12ConsumerSync8consumerEPv+0x30>
        if (i % 80 == 0) {
    800064d8:	05000793          	li	a5,80
    800064dc:	02f4e4bb          	remw	s1,s1,a5
    800064e0:	fa049ce3          	bnez	s1,80006498 <_ZN12ConsumerSync8consumerEPv+0x48>
    800064e4:	fa9ff06f          	j	8000648c <_ZN12ConsumerSync8consumerEPv+0x3c>
        }
    }


    while (td->buffer->getCnt() > 0) {
        int key = td->buffer->get();
    800064e8:	0209b783          	ld	a5,32(s3)
    800064ec:	0087b503          	ld	a0,8(a5)
    800064f0:	00000097          	auipc	ra,0x0
    800064f4:	7f4080e7          	jalr	2036(ra) # 80006ce4 <_ZN9BufferCPP3getEv>
            ::putc(c);
    800064f8:	0ff57513          	andi	a0,a0,255
    800064fc:	ffffb097          	auipc	ra,0xffffb
    80006500:	0b4080e7          	jalr	180(ra) # 800015b0 <_Z4putcc>
    while (td->buffer->getCnt() > 0) {
    80006504:	0209b783          	ld	a5,32(s3)
    80006508:	0087b503          	ld	a0,8(a5)
    8000650c:	00001097          	auipc	ra,0x1
    80006510:	874080e7          	jalr	-1932(ra) # 80006d80 <_ZN9BufferCPP6getCntEv>
    80006514:	fca04ae3          	bgtz	a0,800064e8 <_ZN12ConsumerSync8consumerEPv+0x98>
        Console::putc(key);
    }

    data->wait->signal();
    80006518:	01093783          	ld	a5,16(s2)
            return sem_signal(myHandle);
    8000651c:	0087b503          	ld	a0,8(a5)
    80006520:	ffffb097          	auipc	ra,0xffffb
    80006524:	fe0080e7          	jalr	-32(ra) # 80001500 <_Z10sem_signalP5sem_s>
}
    80006528:	02813083          	ld	ra,40(sp)
    8000652c:	02013403          	ld	s0,32(sp)
    80006530:	01813483          	ld	s1,24(sp)
    80006534:	01013903          	ld	s2,16(sp)
    80006538:	00813983          	ld	s3,8(sp)
    8000653c:	00013a03          	ld	s4,0(sp)
    80006540:	03010113          	addi	sp,sp,48
    80006544:	00008067          	ret

0000000080006548 <_Z29producerConsumer_CPP_Sync_APIv>:

void producerConsumer_CPP_Sync_API() {
    80006548:	f9010113          	addi	sp,sp,-112
    8000654c:	06113423          	sd	ra,104(sp)
    80006550:	06813023          	sd	s0,96(sp)
    80006554:	04913c23          	sd	s1,88(sp)
    80006558:	05213823          	sd	s2,80(sp)
    8000655c:	05313423          	sd	s3,72(sp)
    80006560:	05413023          	sd	s4,64(sp)
    80006564:	03513c23          	sd	s5,56(sp)
    80006568:	03613823          	sd	s6,48(sp)
    8000656c:	03713423          	sd	s7,40(sp)
    80006570:	03813023          	sd	s8,32(sp)
    80006574:	07010413          	addi	s0,sp,112
    for (int i = 0; i < threadNum; i++) {
        delete threads[i];
    }
    delete consumerThread;
    delete waitForAll;
    delete buffer;
    80006578:	00010b93          	mv	s7,sp
    printString("Unesite broj proizvodjaca?\n");
    8000657c:	00004517          	auipc	a0,0x4
    80006580:	e5c50513          	addi	a0,a0,-420 # 8000a3d8 <CONSOLE_STATUS+0x3c8>
    80006584:	ffffc097          	auipc	ra,0xffffc
    80006588:	928080e7          	jalr	-1752(ra) # 80001eac <_Z11printStringPKc>
    getString(input, 30);
    8000658c:	01e00593          	li	a1,30
    80006590:	f9040493          	addi	s1,s0,-112
    80006594:	00048513          	mv	a0,s1
    80006598:	ffffc097          	auipc	ra,0xffffc
    8000659c:	99c080e7          	jalr	-1636(ra) # 80001f34 <_Z9getStringPci>
    threadNum = stringToInt(input);
    800065a0:	00048513          	mv	a0,s1
    800065a4:	ffffc097          	auipc	ra,0xffffc
    800065a8:	a68080e7          	jalr	-1432(ra) # 8000200c <_Z11stringToIntPKc>
    800065ac:	00050913          	mv	s2,a0
    printString("Unesite velicinu bafera?\n");
    800065b0:	00004517          	auipc	a0,0x4
    800065b4:	e4850513          	addi	a0,a0,-440 # 8000a3f8 <CONSOLE_STATUS+0x3e8>
    800065b8:	ffffc097          	auipc	ra,0xffffc
    800065bc:	8f4080e7          	jalr	-1804(ra) # 80001eac <_Z11printStringPKc>
    getString(input, 30);
    800065c0:	01e00593          	li	a1,30
    800065c4:	00048513          	mv	a0,s1
    800065c8:	ffffc097          	auipc	ra,0xffffc
    800065cc:	96c080e7          	jalr	-1684(ra) # 80001f34 <_Z9getStringPci>
    n = stringToInt(input);
    800065d0:	00048513          	mv	a0,s1
    800065d4:	ffffc097          	auipc	ra,0xffffc
    800065d8:	a38080e7          	jalr	-1480(ra) # 8000200c <_Z11stringToIntPKc>
    800065dc:	00050493          	mv	s1,a0
    printString("Broj proizvodjaca "); printInt(threadNum);
    800065e0:	00004517          	auipc	a0,0x4
    800065e4:	e3850513          	addi	a0,a0,-456 # 8000a418 <CONSOLE_STATUS+0x408>
    800065e8:	ffffc097          	auipc	ra,0xffffc
    800065ec:	8c4080e7          	jalr	-1852(ra) # 80001eac <_Z11printStringPKc>
    800065f0:	00000613          	li	a2,0
    800065f4:	00a00593          	li	a1,10
    800065f8:	00090513          	mv	a0,s2
    800065fc:	ffffc097          	auipc	ra,0xffffc
    80006600:	a60080e7          	jalr	-1440(ra) # 8000205c <_Z8printIntiii>
    printString(" i velicina bafera "); printInt(n);
    80006604:	00004517          	auipc	a0,0x4
    80006608:	e2c50513          	addi	a0,a0,-468 # 8000a430 <CONSOLE_STATUS+0x420>
    8000660c:	ffffc097          	auipc	ra,0xffffc
    80006610:	8a0080e7          	jalr	-1888(ra) # 80001eac <_Z11printStringPKc>
    80006614:	00000613          	li	a2,0
    80006618:	00a00593          	li	a1,10
    8000661c:	00048513          	mv	a0,s1
    80006620:	ffffc097          	auipc	ra,0xffffc
    80006624:	a3c080e7          	jalr	-1476(ra) # 8000205c <_Z8printIntiii>
    printString(".\n");
    80006628:	00004517          	auipc	a0,0x4
    8000662c:	e2050513          	addi	a0,a0,-480 # 8000a448 <CONSOLE_STATUS+0x438>
    80006630:	ffffc097          	auipc	ra,0xffffc
    80006634:	87c080e7          	jalr	-1924(ra) # 80001eac <_Z11printStringPKc>
    if(threadNum > n) {
    80006638:	0324c463          	blt	s1,s2,80006660 <_Z29producerConsumer_CPP_Sync_APIv+0x118>
    } else if (threadNum < 1) {
    8000663c:	03205c63          	blez	s2,80006674 <_Z29producerConsumer_CPP_Sync_APIv+0x12c>
    BufferCPP *buffer = new BufferCPP(n);
    80006640:	03800513          	li	a0,56
    80006644:	ffffd097          	auipc	ra,0xffffd
    80006648:	898080e7          	jalr	-1896(ra) # 80002edc <_Znwm>
    8000664c:	00050a93          	mv	s5,a0
    80006650:	00048593          	mv	a1,s1
    80006654:	00000097          	auipc	ra,0x0
    80006658:	45c080e7          	jalr	1116(ra) # 80006ab0 <_ZN9BufferCPPC1Ei>
    8000665c:	0300006f          	j	8000668c <_Z29producerConsumer_CPP_Sync_APIv+0x144>
        printString("Broj proizvodjaca ne sme biti manji od velicine bafera!\n");
    80006660:	00004517          	auipc	a0,0x4
    80006664:	df050513          	addi	a0,a0,-528 # 8000a450 <CONSOLE_STATUS+0x440>
    80006668:	ffffc097          	auipc	ra,0xffffc
    8000666c:	844080e7          	jalr	-1980(ra) # 80001eac <_Z11printStringPKc>
        return;
    80006670:	0140006f          	j	80006684 <_Z29producerConsumer_CPP_Sync_APIv+0x13c>
        printString("Broj proizvodjaca mora biti veci od nula!\n");
    80006674:	00004517          	auipc	a0,0x4
    80006678:	e1c50513          	addi	a0,a0,-484 # 8000a490 <CONSOLE_STATUS+0x480>
    8000667c:	ffffc097          	auipc	ra,0xffffc
    80006680:	830080e7          	jalr	-2000(ra) # 80001eac <_Z11printStringPKc>
        return;
    80006684:	000b8113          	mv	sp,s7
    80006688:	2780006f          	j	80006900 <_Z29producerConsumer_CPP_Sync_APIv+0x3b8>
    waitForAll = new Semaphore(0);
    8000668c:	01000513          	li	a0,16
    80006690:	ffffd097          	auipc	ra,0xffffd
    80006694:	84c080e7          	jalr	-1972(ra) # 80002edc <_Znwm>
    80006698:	00050493          	mv	s1,a0
        Semaphore (unsigned init = 1){
    8000669c:	00006797          	auipc	a5,0x6
    800066a0:	44c78793          	addi	a5,a5,1100 # 8000cae8 <_ZTV9Semaphore+0x10>
    800066a4:	00f53023          	sd	a5,0(a0)
            sem_open(&myHandle,init);
    800066a8:	00000593          	li	a1,0
    800066ac:	00850513          	addi	a0,a0,8
    800066b0:	ffffb097          	auipc	ra,0xffffb
    800066b4:	d8c080e7          	jalr	-628(ra) # 8000143c <_Z8sem_openPP5sem_sj>
    800066b8:	00008797          	auipc	a5,0x8
    800066bc:	4097b023          	sd	s1,1024(a5) # 8000eab8 <_ZL10waitForAll>
    Thread* threads[threadNum];
    800066c0:	00391793          	slli	a5,s2,0x3
    800066c4:	00f78793          	addi	a5,a5,15
    800066c8:	ff07f793          	andi	a5,a5,-16
    800066cc:	40f10133          	sub	sp,sp,a5
    800066d0:	00010993          	mv	s3,sp
    struct thread_data data[threadNum + 1];
    800066d4:	0019071b          	addiw	a4,s2,1
    800066d8:	00171793          	slli	a5,a4,0x1
    800066dc:	00e787b3          	add	a5,a5,a4
    800066e0:	00379793          	slli	a5,a5,0x3
    800066e4:	00f78793          	addi	a5,a5,15
    800066e8:	ff07f793          	andi	a5,a5,-16
    800066ec:	40f10133          	sub	sp,sp,a5
    800066f0:	00010a13          	mv	s4,sp
    data[threadNum].id = threadNum;
    800066f4:	00191c13          	slli	s8,s2,0x1
    800066f8:	012c07b3          	add	a5,s8,s2
    800066fc:	00379793          	slli	a5,a5,0x3
    80006700:	00fa07b3          	add	a5,s4,a5
    80006704:	0127a023          	sw	s2,0(a5)
    data[threadNum].buffer = buffer;
    80006708:	0157b423          	sd	s5,8(a5)
    data[threadNum].wait = waitForAll;
    8000670c:	0097b823          	sd	s1,16(a5)
    consumerThread = new ConsumerSync(data+threadNum);
    80006710:	02800513          	li	a0,40
    80006714:	ffffc097          	auipc	ra,0xffffc
    80006718:	7c8080e7          	jalr	1992(ra) # 80002edc <_Znwm>
    8000671c:	00050b13          	mv	s6,a0
    80006720:	012c0c33          	add	s8,s8,s2
    80006724:	003c1c13          	slli	s8,s8,0x3
    80006728:	018a0c33          	add	s8,s4,s8
            body= nullptr;
    8000672c:	00053823          	sd	zero,16(a0)
            arg= nullptr;
    80006730:	00053c23          	sd	zero,24(a0)
    ConsumerSync(thread_data* _td):Thread(), td(_td) {}
    80006734:	00006797          	auipc	a5,0x6
    80006738:	57478793          	addi	a5,a5,1396 # 8000cca8 <_ZTV12ConsumerSync+0x10>
    8000673c:	00f53023          	sd	a5,0(a0)
    80006740:	03853023          	sd	s8,32(a0)
            if(body== nullptr) return thread_create(&myHandle,&threadEntry, this);
    80006744:	00050613          	mv	a2,a0
    80006748:	ffffc597          	auipc	a1,0xffffc
    8000674c:	59858593          	addi	a1,a1,1432 # 80002ce0 <_ZN6Thread11threadEntryEPv>
    80006750:	00850513          	addi	a0,a0,8
    80006754:	ffffb097          	auipc	ra,0xffffb
    80006758:	bac080e7          	jalr	-1108(ra) # 80001300 <_Z13thread_createPP8thread_sPFvPvES2_>
    for (int i = 0; i < threadNum; i++) {
    8000675c:	00000493          	li	s1,0
    80006760:	0640006f          	j	800067c4 <_Z29producerConsumer_CPP_Sync_APIv+0x27c>
            threads[i] = new ProducerKeyboard(data+i);
    80006764:	02800513          	li	a0,40
    80006768:	ffffc097          	auipc	ra,0xffffc
    8000676c:	774080e7          	jalr	1908(ra) # 80002edc <_Znwm>
    80006770:	00149793          	slli	a5,s1,0x1
    80006774:	009787b3          	add	a5,a5,s1
    80006778:	00379793          	slli	a5,a5,0x3
    8000677c:	00fa07b3          	add	a5,s4,a5
            body= nullptr;
    80006780:	00053823          	sd	zero,16(a0)
            arg= nullptr;
    80006784:	00053c23          	sd	zero,24(a0)
    ProducerKeyboard(thread_data* _td):Thread(), td(_td) {}
    80006788:	00006717          	auipc	a4,0x6
    8000678c:	4d070713          	addi	a4,a4,1232 # 8000cc58 <_ZTV16ProducerKeyboard+0x10>
    80006790:	00e53023          	sd	a4,0(a0)
    80006794:	02f53023          	sd	a5,32(a0)
            threads[i] = new ProducerKeyboard(data+i);
    80006798:	00349793          	slli	a5,s1,0x3
    8000679c:	00f987b3          	add	a5,s3,a5
    800067a0:	00a7b023          	sd	a0,0(a5)
    800067a4:	08c0006f          	j	80006830 <_Z29producerConsumer_CPP_Sync_APIv+0x2e8>
            if(body== nullptr) return thread_create(&myHandle,&threadEntry, this);
    800067a8:	00050613          	mv	a2,a0
    800067ac:	ffffc597          	auipc	a1,0xffffc
    800067b0:	53458593          	addi	a1,a1,1332 # 80002ce0 <_ZN6Thread11threadEntryEPv>
    800067b4:	00850513          	addi	a0,a0,8
    800067b8:	ffffb097          	auipc	ra,0xffffb
    800067bc:	b48080e7          	jalr	-1208(ra) # 80001300 <_Z13thread_createPP8thread_sPFvPvES2_>
    for (int i = 0; i < threadNum; i++) {
    800067c0:	0014849b          	addiw	s1,s1,1
    800067c4:	0924da63          	bge	s1,s2,80006858 <_Z29producerConsumer_CPP_Sync_APIv+0x310>
        data[i].id = i;
    800067c8:	00149793          	slli	a5,s1,0x1
    800067cc:	009787b3          	add	a5,a5,s1
    800067d0:	00379793          	slli	a5,a5,0x3
    800067d4:	00fa07b3          	add	a5,s4,a5
    800067d8:	0097a023          	sw	s1,0(a5)
        data[i].buffer = buffer;
    800067dc:	0157b423          	sd	s5,8(a5)
        data[i].wait = waitForAll;
    800067e0:	00008717          	auipc	a4,0x8
    800067e4:	2d873703          	ld	a4,728(a4) # 8000eab8 <_ZL10waitForAll>
    800067e8:	00e7b823          	sd	a4,16(a5)
        if(i>0) {
    800067ec:	f6905ce3          	blez	s1,80006764 <_Z29producerConsumer_CPP_Sync_APIv+0x21c>
            threads[i] = new ProducerSync(data+i);
    800067f0:	02800513          	li	a0,40
    800067f4:	ffffc097          	auipc	ra,0xffffc
    800067f8:	6e8080e7          	jalr	1768(ra) # 80002edc <_Znwm>
    800067fc:	00149793          	slli	a5,s1,0x1
    80006800:	009787b3          	add	a5,a5,s1
    80006804:	00379793          	slli	a5,a5,0x3
    80006808:	00fa07b3          	add	a5,s4,a5
            body= nullptr;
    8000680c:	00053823          	sd	zero,16(a0)
            arg= nullptr;
    80006810:	00053c23          	sd	zero,24(a0)
    ProducerSync(thread_data* _td):Thread(), td(_td) {}
    80006814:	00006717          	auipc	a4,0x6
    80006818:	46c70713          	addi	a4,a4,1132 # 8000cc80 <_ZTV12ProducerSync+0x10>
    8000681c:	00e53023          	sd	a4,0(a0)
    80006820:	02f53023          	sd	a5,32(a0)
            threads[i] = new ProducerSync(data+i);
    80006824:	00349793          	slli	a5,s1,0x3
    80006828:	00f987b3          	add	a5,s3,a5
    8000682c:	00a7b023          	sd	a0,0(a5)
        threads[i]->start();
    80006830:	00349793          	slli	a5,s1,0x3
    80006834:	00f987b3          	add	a5,s3,a5
    80006838:	0007b503          	ld	a0,0(a5)
            if(body== nullptr) return thread_create(&myHandle,&threadEntry, this);
    8000683c:	01053583          	ld	a1,16(a0)
    80006840:	f60584e3          	beqz	a1,800067a8 <_Z29producerConsumer_CPP_Sync_APIv+0x260>
            else return thread_create(&myHandle,body,arg);
    80006844:	01853603          	ld	a2,24(a0)
    80006848:	00850513          	addi	a0,a0,8
    8000684c:	ffffb097          	auipc	ra,0xffffb
    80006850:	ab4080e7          	jalr	-1356(ra) # 80001300 <_Z13thread_createPP8thread_sPFvPvES2_>
    80006854:	f6dff06f          	j	800067c0 <_Z29producerConsumer_CPP_Sync_APIv+0x278>
            thread_dispatch();
    80006858:	ffffb097          	auipc	ra,0xffffb
    8000685c:	b30080e7          	jalr	-1232(ra) # 80001388 <_Z15thread_dispatchv>
    for (int i = 0; i <= threadNum; i++) {
    80006860:	00000493          	li	s1,0
    80006864:	02994063          	blt	s2,s1,80006884 <_Z29producerConsumer_CPP_Sync_APIv+0x33c>
            return sem_wait(myHandle);
    80006868:	00008797          	auipc	a5,0x8
    8000686c:	2507b783          	ld	a5,592(a5) # 8000eab8 <_ZL10waitForAll>
    80006870:	0087b503          	ld	a0,8(a5)
    80006874:	ffffb097          	auipc	ra,0xffffb
    80006878:	c4c080e7          	jalr	-948(ra) # 800014c0 <_Z8sem_waitP5sem_s>
    8000687c:	0014849b          	addiw	s1,s1,1
    80006880:	fe5ff06f          	j	80006864 <_Z29producerConsumer_CPP_Sync_APIv+0x31c>
    for (int i = 0; i < threadNum; i++) {
    80006884:	00000493          	li	s1,0
    80006888:	0080006f          	j	80006890 <_Z29producerConsumer_CPP_Sync_APIv+0x348>
    8000688c:	0014849b          	addiw	s1,s1,1
    80006890:	0324d263          	bge	s1,s2,800068b4 <_Z29producerConsumer_CPP_Sync_APIv+0x36c>
        delete threads[i];
    80006894:	00349793          	slli	a5,s1,0x3
    80006898:	00f987b3          	add	a5,s3,a5
    8000689c:	0007b503          	ld	a0,0(a5)
    800068a0:	fe0506e3          	beqz	a0,8000688c <_Z29producerConsumer_CPP_Sync_APIv+0x344>
    800068a4:	00053783          	ld	a5,0(a0)
    800068a8:	0087b783          	ld	a5,8(a5)
    800068ac:	000780e7          	jalr	a5
    800068b0:	fddff06f          	j	8000688c <_Z29producerConsumer_CPP_Sync_APIv+0x344>
    delete consumerThread;
    800068b4:	000b0a63          	beqz	s6,800068c8 <_Z29producerConsumer_CPP_Sync_APIv+0x380>
    800068b8:	000b3783          	ld	a5,0(s6)
    800068bc:	0087b783          	ld	a5,8(a5)
    800068c0:	000b0513          	mv	a0,s6
    800068c4:	000780e7          	jalr	a5
    delete waitForAll;
    800068c8:	00008517          	auipc	a0,0x8
    800068cc:	1f053503          	ld	a0,496(a0) # 8000eab8 <_ZL10waitForAll>
    800068d0:	00050863          	beqz	a0,800068e0 <_Z29producerConsumer_CPP_Sync_APIv+0x398>
    800068d4:	00053783          	ld	a5,0(a0)
    800068d8:	0087b783          	ld	a5,8(a5)
    800068dc:	000780e7          	jalr	a5
    delete buffer;
    800068e0:	000a8e63          	beqz	s5,800068fc <_Z29producerConsumer_CPP_Sync_APIv+0x3b4>
    800068e4:	000a8513          	mv	a0,s5
    800068e8:	00000097          	auipc	ra,0x0
    800068ec:	530080e7          	jalr	1328(ra) # 80006e18 <_ZN9BufferCPPD1Ev>
    800068f0:	000a8513          	mv	a0,s5
    800068f4:	ffffc097          	auipc	ra,0xffffc
    800068f8:	610080e7          	jalr	1552(ra) # 80002f04 <_ZdlPv>
    800068fc:	000b8113          	mv	sp,s7

}
    80006900:	f9040113          	addi	sp,s0,-112
    80006904:	06813083          	ld	ra,104(sp)
    80006908:	06013403          	ld	s0,96(sp)
    8000690c:	05813483          	ld	s1,88(sp)
    80006910:	05013903          	ld	s2,80(sp)
    80006914:	04813983          	ld	s3,72(sp)
    80006918:	04013a03          	ld	s4,64(sp)
    8000691c:	03813a83          	ld	s5,56(sp)
    80006920:	03013b03          	ld	s6,48(sp)
    80006924:	02813b83          	ld	s7,40(sp)
    80006928:	02013c03          	ld	s8,32(sp)
    8000692c:	07010113          	addi	sp,sp,112
    80006930:	00008067          	ret
    80006934:	00050493          	mv	s1,a0
    BufferCPP *buffer = new BufferCPP(n);
    80006938:	000a8513          	mv	a0,s5
    8000693c:	ffffc097          	auipc	ra,0xffffc
    80006940:	5c8080e7          	jalr	1480(ra) # 80002f04 <_ZdlPv>
    80006944:	00048513          	mv	a0,s1
    80006948:	00009097          	auipc	ra,0x9
    8000694c:	250080e7          	jalr	592(ra) # 8000fb98 <_Unwind_Resume>
    80006950:	00050913          	mv	s2,a0
    waitForAll = new Semaphore(0);
    80006954:	00048513          	mv	a0,s1
    80006958:	ffffc097          	auipc	ra,0xffffc
    8000695c:	5ac080e7          	jalr	1452(ra) # 80002f04 <_ZdlPv>
    80006960:	00090513          	mv	a0,s2
    80006964:	00009097          	auipc	ra,0x9
    80006968:	234080e7          	jalr	564(ra) # 8000fb98 <_Unwind_Resume>

000000008000696c <_ZN12ConsumerSyncD1Ev>:
class ConsumerSync:public Thread {
    8000696c:	ff010113          	addi	sp,sp,-16
    80006970:	00813423          	sd	s0,8(sp)
    80006974:	01010413          	addi	s0,sp,16
    80006978:	00813403          	ld	s0,8(sp)
    8000697c:	01010113          	addi	sp,sp,16
    80006980:	00008067          	ret

0000000080006984 <_ZN12ProducerSyncD1Ev>:
class ProducerSync:public Thread {
    80006984:	ff010113          	addi	sp,sp,-16
    80006988:	00813423          	sd	s0,8(sp)
    8000698c:	01010413          	addi	s0,sp,16
    80006990:	00813403          	ld	s0,8(sp)
    80006994:	01010113          	addi	sp,sp,16
    80006998:	00008067          	ret

000000008000699c <_ZN16ProducerKeyboardD1Ev>:
class ProducerKeyboard:public Thread {
    8000699c:	ff010113          	addi	sp,sp,-16
    800069a0:	00813423          	sd	s0,8(sp)
    800069a4:	01010413          	addi	s0,sp,16
    800069a8:	00813403          	ld	s0,8(sp)
    800069ac:	01010113          	addi	sp,sp,16
    800069b0:	00008067          	ret

00000000800069b4 <_ZN12ConsumerSyncD0Ev>:
class ConsumerSync:public Thread {
    800069b4:	ff010113          	addi	sp,sp,-16
    800069b8:	00113423          	sd	ra,8(sp)
    800069bc:	00813023          	sd	s0,0(sp)
    800069c0:	01010413          	addi	s0,sp,16
    800069c4:	ffffc097          	auipc	ra,0xffffc
    800069c8:	540080e7          	jalr	1344(ra) # 80002f04 <_ZdlPv>
    800069cc:	00813083          	ld	ra,8(sp)
    800069d0:	00013403          	ld	s0,0(sp)
    800069d4:	01010113          	addi	sp,sp,16
    800069d8:	00008067          	ret

00000000800069dc <_ZN12ProducerSyncD0Ev>:
class ProducerSync:public Thread {
    800069dc:	ff010113          	addi	sp,sp,-16
    800069e0:	00113423          	sd	ra,8(sp)
    800069e4:	00813023          	sd	s0,0(sp)
    800069e8:	01010413          	addi	s0,sp,16
    800069ec:	ffffc097          	auipc	ra,0xffffc
    800069f0:	518080e7          	jalr	1304(ra) # 80002f04 <_ZdlPv>
    800069f4:	00813083          	ld	ra,8(sp)
    800069f8:	00013403          	ld	s0,0(sp)
    800069fc:	01010113          	addi	sp,sp,16
    80006a00:	00008067          	ret

0000000080006a04 <_ZN16ProducerKeyboardD0Ev>:
class ProducerKeyboard:public Thread {
    80006a04:	ff010113          	addi	sp,sp,-16
    80006a08:	00113423          	sd	ra,8(sp)
    80006a0c:	00813023          	sd	s0,0(sp)
    80006a10:	01010413          	addi	s0,sp,16
    80006a14:	ffffc097          	auipc	ra,0xffffc
    80006a18:	4f0080e7          	jalr	1264(ra) # 80002f04 <_ZdlPv>
    80006a1c:	00813083          	ld	ra,8(sp)
    80006a20:	00013403          	ld	s0,0(sp)
    80006a24:	01010113          	addi	sp,sp,16
    80006a28:	00008067          	ret

0000000080006a2c <_ZN16ProducerKeyboard3runEv>:
    void run() override {
    80006a2c:	ff010113          	addi	sp,sp,-16
    80006a30:	00113423          	sd	ra,8(sp)
    80006a34:	00813023          	sd	s0,0(sp)
    80006a38:	01010413          	addi	s0,sp,16
        producerKeyboard(td);
    80006a3c:	02053583          	ld	a1,32(a0)
    80006a40:	00000097          	auipc	ra,0x0
    80006a44:	8b4080e7          	jalr	-1868(ra) # 800062f4 <_ZN16ProducerKeyboard16producerKeyboardEPv>
    }
    80006a48:	00813083          	ld	ra,8(sp)
    80006a4c:	00013403          	ld	s0,0(sp)
    80006a50:	01010113          	addi	sp,sp,16
    80006a54:	00008067          	ret

0000000080006a58 <_ZN12ProducerSync3runEv>:
    void run() override {
    80006a58:	ff010113          	addi	sp,sp,-16
    80006a5c:	00113423          	sd	ra,8(sp)
    80006a60:	00813023          	sd	s0,0(sp)
    80006a64:	01010413          	addi	s0,sp,16
        producer(td);
    80006a68:	02053583          	ld	a1,32(a0)
    80006a6c:	00000097          	auipc	ra,0x0
    80006a70:	94c080e7          	jalr	-1716(ra) # 800063b8 <_ZN12ProducerSync8producerEPv>
    }
    80006a74:	00813083          	ld	ra,8(sp)
    80006a78:	00013403          	ld	s0,0(sp)
    80006a7c:	01010113          	addi	sp,sp,16
    80006a80:	00008067          	ret

0000000080006a84 <_ZN12ConsumerSync3runEv>:
    void run() override {
    80006a84:	ff010113          	addi	sp,sp,-16
    80006a88:	00113423          	sd	ra,8(sp)
    80006a8c:	00813023          	sd	s0,0(sp)
    80006a90:	01010413          	addi	s0,sp,16
        consumer(td);
    80006a94:	02053583          	ld	a1,32(a0)
    80006a98:	00000097          	auipc	ra,0x0
    80006a9c:	9b8080e7          	jalr	-1608(ra) # 80006450 <_ZN12ConsumerSync8consumerEPv>
    }
    80006aa0:	00813083          	ld	ra,8(sp)
    80006aa4:	00013403          	ld	s0,0(sp)
    80006aa8:	01010113          	addi	sp,sp,16
    80006aac:	00008067          	ret

0000000080006ab0 <_ZN9BufferCPPC1Ei>:
#include "buffer_CPP_API.hpp"

BufferCPP::BufferCPP(int _cap) : cap(_cap + 1), head(0), tail(0) {
    80006ab0:	fd010113          	addi	sp,sp,-48
    80006ab4:	02113423          	sd	ra,40(sp)
    80006ab8:	02813023          	sd	s0,32(sp)
    80006abc:	00913c23          	sd	s1,24(sp)
    80006ac0:	01213823          	sd	s2,16(sp)
    80006ac4:	01313423          	sd	s3,8(sp)
    80006ac8:	03010413          	addi	s0,sp,48
    80006acc:	00050493          	mv	s1,a0
    80006ad0:	00058993          	mv	s3,a1
    80006ad4:	0015879b          	addiw	a5,a1,1
    80006ad8:	0007851b          	sext.w	a0,a5
    80006adc:	00f4a023          	sw	a5,0(s1)
    80006ae0:	0004a823          	sw	zero,16(s1)
    80006ae4:	0004aa23          	sw	zero,20(s1)
    buffer = (int *)mem_alloc(sizeof(int) * cap);
    80006ae8:	00251513          	slli	a0,a0,0x2
    80006aec:	ffffa097          	auipc	ra,0xffffa
    80006af0:	794080e7          	jalr	1940(ra) # 80001280 <_Z9mem_allocm>
    80006af4:	00a4b423          	sd	a0,8(s1)
    itemAvailable = new Semaphore(0);
    80006af8:	01000513          	li	a0,16
    80006afc:	ffffc097          	auipc	ra,0xffffc
    80006b00:	3e0080e7          	jalr	992(ra) # 80002edc <_Znwm>
    80006b04:	00050913          	mv	s2,a0
        Semaphore (unsigned init = 1){
    80006b08:	00006797          	auipc	a5,0x6
    80006b0c:	fe078793          	addi	a5,a5,-32 # 8000cae8 <_ZTV9Semaphore+0x10>
    80006b10:	00f53023          	sd	a5,0(a0)
            sem_open(&myHandle,init);
    80006b14:	00000593          	li	a1,0
    80006b18:	00850513          	addi	a0,a0,8
    80006b1c:	ffffb097          	auipc	ra,0xffffb
    80006b20:	920080e7          	jalr	-1760(ra) # 8000143c <_Z8sem_openPP5sem_sj>
    80006b24:	0324b023          	sd	s2,32(s1)
    spaceAvailable = new Semaphore(_cap);
    80006b28:	01000513          	li	a0,16
    80006b2c:	ffffc097          	auipc	ra,0xffffc
    80006b30:	3b0080e7          	jalr	944(ra) # 80002edc <_Znwm>
    80006b34:	00050913          	mv	s2,a0
        Semaphore (unsigned init = 1){
    80006b38:	00006797          	auipc	a5,0x6
    80006b3c:	fb078793          	addi	a5,a5,-80 # 8000cae8 <_ZTV9Semaphore+0x10>
    80006b40:	00f53023          	sd	a5,0(a0)
            sem_open(&myHandle,init);
    80006b44:	00098593          	mv	a1,s3
    80006b48:	00850513          	addi	a0,a0,8
    80006b4c:	ffffb097          	auipc	ra,0xffffb
    80006b50:	8f0080e7          	jalr	-1808(ra) # 8000143c <_Z8sem_openPP5sem_sj>
    80006b54:	0124bc23          	sd	s2,24(s1)
    mutexHead = new Semaphore(1);
    80006b58:	01000513          	li	a0,16
    80006b5c:	ffffc097          	auipc	ra,0xffffc
    80006b60:	380080e7          	jalr	896(ra) # 80002edc <_Znwm>
    80006b64:	00050913          	mv	s2,a0
        Semaphore (unsigned init = 1){
    80006b68:	00006797          	auipc	a5,0x6
    80006b6c:	f8078793          	addi	a5,a5,-128 # 8000cae8 <_ZTV9Semaphore+0x10>
    80006b70:	00f53023          	sd	a5,0(a0)
            sem_open(&myHandle,init);
    80006b74:	00100593          	li	a1,1
    80006b78:	00850513          	addi	a0,a0,8
    80006b7c:	ffffb097          	auipc	ra,0xffffb
    80006b80:	8c0080e7          	jalr	-1856(ra) # 8000143c <_Z8sem_openPP5sem_sj>
    80006b84:	0324b423          	sd	s2,40(s1)
    mutexTail = new Semaphore(1);
    80006b88:	01000513          	li	a0,16
    80006b8c:	ffffc097          	auipc	ra,0xffffc
    80006b90:	350080e7          	jalr	848(ra) # 80002edc <_Znwm>
    80006b94:	00050913          	mv	s2,a0
        Semaphore (unsigned init = 1){
    80006b98:	00006797          	auipc	a5,0x6
    80006b9c:	f5078793          	addi	a5,a5,-176 # 8000cae8 <_ZTV9Semaphore+0x10>
    80006ba0:	00f53023          	sd	a5,0(a0)
            sem_open(&myHandle,init);
    80006ba4:	00100593          	li	a1,1
    80006ba8:	00850513          	addi	a0,a0,8
    80006bac:	ffffb097          	auipc	ra,0xffffb
    80006bb0:	890080e7          	jalr	-1904(ra) # 8000143c <_Z8sem_openPP5sem_sj>
    80006bb4:	0324b823          	sd	s2,48(s1)
}
    80006bb8:	02813083          	ld	ra,40(sp)
    80006bbc:	02013403          	ld	s0,32(sp)
    80006bc0:	01813483          	ld	s1,24(sp)
    80006bc4:	01013903          	ld	s2,16(sp)
    80006bc8:	00813983          	ld	s3,8(sp)
    80006bcc:	03010113          	addi	sp,sp,48
    80006bd0:	00008067          	ret
    80006bd4:	00050493          	mv	s1,a0
    itemAvailable = new Semaphore(0);
    80006bd8:	00090513          	mv	a0,s2
    80006bdc:	ffffc097          	auipc	ra,0xffffc
    80006be0:	328080e7          	jalr	808(ra) # 80002f04 <_ZdlPv>
    80006be4:	00048513          	mv	a0,s1
    80006be8:	00009097          	auipc	ra,0x9
    80006bec:	fb0080e7          	jalr	-80(ra) # 8000fb98 <_Unwind_Resume>
    80006bf0:	00050493          	mv	s1,a0
    spaceAvailable = new Semaphore(_cap);
    80006bf4:	00090513          	mv	a0,s2
    80006bf8:	ffffc097          	auipc	ra,0xffffc
    80006bfc:	30c080e7          	jalr	780(ra) # 80002f04 <_ZdlPv>
    80006c00:	00048513          	mv	a0,s1
    80006c04:	00009097          	auipc	ra,0x9
    80006c08:	f94080e7          	jalr	-108(ra) # 8000fb98 <_Unwind_Resume>
    80006c0c:	00050493          	mv	s1,a0
    mutexHead = new Semaphore(1);
    80006c10:	00090513          	mv	a0,s2
    80006c14:	ffffc097          	auipc	ra,0xffffc
    80006c18:	2f0080e7          	jalr	752(ra) # 80002f04 <_ZdlPv>
    80006c1c:	00048513          	mv	a0,s1
    80006c20:	00009097          	auipc	ra,0x9
    80006c24:	f78080e7          	jalr	-136(ra) # 8000fb98 <_Unwind_Resume>
    80006c28:	00050493          	mv	s1,a0
    mutexTail = new Semaphore(1);
    80006c2c:	00090513          	mv	a0,s2
    80006c30:	ffffc097          	auipc	ra,0xffffc
    80006c34:	2d4080e7          	jalr	724(ra) # 80002f04 <_ZdlPv>
    80006c38:	00048513          	mv	a0,s1
    80006c3c:	00009097          	auipc	ra,0x9
    80006c40:	f5c080e7          	jalr	-164(ra) # 8000fb98 <_Unwind_Resume>

0000000080006c44 <_ZN9BufferCPP3putEi>:
    delete mutexTail;
    delete mutexHead;

}

void BufferCPP::put(int val) {
    80006c44:	fe010113          	addi	sp,sp,-32
    80006c48:	00113c23          	sd	ra,24(sp)
    80006c4c:	00813823          	sd	s0,16(sp)
    80006c50:	00913423          	sd	s1,8(sp)
    80006c54:	01213023          	sd	s2,0(sp)
    80006c58:	02010413          	addi	s0,sp,32
    80006c5c:	00050493          	mv	s1,a0
    80006c60:	00058913          	mv	s2,a1
    spaceAvailable->wait();
    80006c64:	01853783          	ld	a5,24(a0)
            return sem_wait(myHandle);
    80006c68:	0087b503          	ld	a0,8(a5)
    80006c6c:	ffffb097          	auipc	ra,0xffffb
    80006c70:	854080e7          	jalr	-1964(ra) # 800014c0 <_Z8sem_waitP5sem_s>

    mutexTail->wait();
    80006c74:	0304b783          	ld	a5,48(s1)
    80006c78:	0087b503          	ld	a0,8(a5)
    80006c7c:	ffffb097          	auipc	ra,0xffffb
    80006c80:	844080e7          	jalr	-1980(ra) # 800014c0 <_Z8sem_waitP5sem_s>
    buffer[tail] = val;
    80006c84:	0084b783          	ld	a5,8(s1)
    80006c88:	0144a703          	lw	a4,20(s1)
    80006c8c:	00271713          	slli	a4,a4,0x2
    80006c90:	00e787b3          	add	a5,a5,a4
    80006c94:	0127a023          	sw	s2,0(a5)
    tail = (tail + 1) % cap;
    80006c98:	0144a783          	lw	a5,20(s1)
    80006c9c:	0017879b          	addiw	a5,a5,1
    80006ca0:	0004a703          	lw	a4,0(s1)
    80006ca4:	02e7e7bb          	remw	a5,a5,a4
    80006ca8:	00f4aa23          	sw	a5,20(s1)
    mutexTail->signal();
    80006cac:	0304b783          	ld	a5,48(s1)
            return sem_signal(myHandle);
    80006cb0:	0087b503          	ld	a0,8(a5)
    80006cb4:	ffffb097          	auipc	ra,0xffffb
    80006cb8:	84c080e7          	jalr	-1972(ra) # 80001500 <_Z10sem_signalP5sem_s>

    itemAvailable->signal();
    80006cbc:	0204b783          	ld	a5,32(s1)
    80006cc0:	0087b503          	ld	a0,8(a5)
    80006cc4:	ffffb097          	auipc	ra,0xffffb
    80006cc8:	83c080e7          	jalr	-1988(ra) # 80001500 <_Z10sem_signalP5sem_s>

}
    80006ccc:	01813083          	ld	ra,24(sp)
    80006cd0:	01013403          	ld	s0,16(sp)
    80006cd4:	00813483          	ld	s1,8(sp)
    80006cd8:	00013903          	ld	s2,0(sp)
    80006cdc:	02010113          	addi	sp,sp,32
    80006ce0:	00008067          	ret

0000000080006ce4 <_ZN9BufferCPP3getEv>:

int BufferCPP::get() {
    80006ce4:	fe010113          	addi	sp,sp,-32
    80006ce8:	00113c23          	sd	ra,24(sp)
    80006cec:	00813823          	sd	s0,16(sp)
    80006cf0:	00913423          	sd	s1,8(sp)
    80006cf4:	01213023          	sd	s2,0(sp)
    80006cf8:	02010413          	addi	s0,sp,32
    80006cfc:	00050493          	mv	s1,a0
    itemAvailable->wait();
    80006d00:	02053783          	ld	a5,32(a0)
            return sem_wait(myHandle);
    80006d04:	0087b503          	ld	a0,8(a5)
    80006d08:	ffffa097          	auipc	ra,0xffffa
    80006d0c:	7b8080e7          	jalr	1976(ra) # 800014c0 <_Z8sem_waitP5sem_s>

    mutexHead->wait();
    80006d10:	0284b783          	ld	a5,40(s1)
    80006d14:	0087b503          	ld	a0,8(a5)
    80006d18:	ffffa097          	auipc	ra,0xffffa
    80006d1c:	7a8080e7          	jalr	1960(ra) # 800014c0 <_Z8sem_waitP5sem_s>

    int ret = buffer[head];
    80006d20:	0084b703          	ld	a4,8(s1)
    80006d24:	0104a783          	lw	a5,16(s1)
    80006d28:	00279693          	slli	a3,a5,0x2
    80006d2c:	00d70733          	add	a4,a4,a3
    80006d30:	00072903          	lw	s2,0(a4)
    head = (head + 1) % cap;
    80006d34:	0017879b          	addiw	a5,a5,1
    80006d38:	0004a703          	lw	a4,0(s1)
    80006d3c:	02e7e7bb          	remw	a5,a5,a4
    80006d40:	00f4a823          	sw	a5,16(s1)
    mutexHead->signal();
    80006d44:	0284b783          	ld	a5,40(s1)
            return sem_signal(myHandle);
    80006d48:	0087b503          	ld	a0,8(a5)
    80006d4c:	ffffa097          	auipc	ra,0xffffa
    80006d50:	7b4080e7          	jalr	1972(ra) # 80001500 <_Z10sem_signalP5sem_s>

    spaceAvailable->signal();
    80006d54:	0184b783          	ld	a5,24(s1)
    80006d58:	0087b503          	ld	a0,8(a5)
    80006d5c:	ffffa097          	auipc	ra,0xffffa
    80006d60:	7a4080e7          	jalr	1956(ra) # 80001500 <_Z10sem_signalP5sem_s>

    return ret;
}
    80006d64:	00090513          	mv	a0,s2
    80006d68:	01813083          	ld	ra,24(sp)
    80006d6c:	01013403          	ld	s0,16(sp)
    80006d70:	00813483          	ld	s1,8(sp)
    80006d74:	00013903          	ld	s2,0(sp)
    80006d78:	02010113          	addi	sp,sp,32
    80006d7c:	00008067          	ret

0000000080006d80 <_ZN9BufferCPP6getCntEv>:

int BufferCPP::getCnt() {
    80006d80:	fe010113          	addi	sp,sp,-32
    80006d84:	00113c23          	sd	ra,24(sp)
    80006d88:	00813823          	sd	s0,16(sp)
    80006d8c:	00913423          	sd	s1,8(sp)
    80006d90:	01213023          	sd	s2,0(sp)
    80006d94:	02010413          	addi	s0,sp,32
    80006d98:	00050493          	mv	s1,a0
    int ret;

    mutexHead->wait();
    80006d9c:	02853783          	ld	a5,40(a0)
            return sem_wait(myHandle);
    80006da0:	0087b503          	ld	a0,8(a5)
    80006da4:	ffffa097          	auipc	ra,0xffffa
    80006da8:	71c080e7          	jalr	1820(ra) # 800014c0 <_Z8sem_waitP5sem_s>
    mutexTail->wait();
    80006dac:	0304b783          	ld	a5,48(s1)
    80006db0:	0087b503          	ld	a0,8(a5)
    80006db4:	ffffa097          	auipc	ra,0xffffa
    80006db8:	70c080e7          	jalr	1804(ra) # 800014c0 <_Z8sem_waitP5sem_s>

    if (tail >= head) {
    80006dbc:	0144a783          	lw	a5,20(s1)
    80006dc0:	0104a903          	lw	s2,16(s1)
    80006dc4:	0527c263          	blt	a5,s2,80006e08 <_ZN9BufferCPP6getCntEv+0x88>
        ret = tail - head;
    80006dc8:	4127893b          	subw	s2,a5,s2
    } else {
        ret = cap - head + tail;
    }

    mutexTail->signal();
    80006dcc:	0304b783          	ld	a5,48(s1)
            return sem_signal(myHandle);
    80006dd0:	0087b503          	ld	a0,8(a5)
    80006dd4:	ffffa097          	auipc	ra,0xffffa
    80006dd8:	72c080e7          	jalr	1836(ra) # 80001500 <_Z10sem_signalP5sem_s>
    mutexHead->signal();
    80006ddc:	0284b783          	ld	a5,40(s1)
    80006de0:	0087b503          	ld	a0,8(a5)
    80006de4:	ffffa097          	auipc	ra,0xffffa
    80006de8:	71c080e7          	jalr	1820(ra) # 80001500 <_Z10sem_signalP5sem_s>

    return ret;
}
    80006dec:	00090513          	mv	a0,s2
    80006df0:	01813083          	ld	ra,24(sp)
    80006df4:	01013403          	ld	s0,16(sp)
    80006df8:	00813483          	ld	s1,8(sp)
    80006dfc:	00013903          	ld	s2,0(sp)
    80006e00:	02010113          	addi	sp,sp,32
    80006e04:	00008067          	ret
        ret = cap - head + tail;
    80006e08:	0004a703          	lw	a4,0(s1)
    80006e0c:	4127093b          	subw	s2,a4,s2
    80006e10:	00f9093b          	addw	s2,s2,a5
    80006e14:	fb9ff06f          	j	80006dcc <_ZN9BufferCPP6getCntEv+0x4c>

0000000080006e18 <_ZN9BufferCPPD1Ev>:
BufferCPP::~BufferCPP() {
    80006e18:	fe010113          	addi	sp,sp,-32
    80006e1c:	00113c23          	sd	ra,24(sp)
    80006e20:	00813823          	sd	s0,16(sp)
    80006e24:	00913423          	sd	s1,8(sp)
    80006e28:	02010413          	addi	s0,sp,32
    80006e2c:	00050493          	mv	s1,a0
            ::putc(c);
    80006e30:	00a00513          	li	a0,10
    80006e34:	ffffa097          	auipc	ra,0xffffa
    80006e38:	77c080e7          	jalr	1916(ra) # 800015b0 <_Z4putcc>
    printString("Buffer deleted!\n");
    80006e3c:	00003517          	auipc	a0,0x3
    80006e40:	77c50513          	addi	a0,a0,1916 # 8000a5b8 <CONSOLE_STATUS+0x5a8>
    80006e44:	ffffb097          	auipc	ra,0xffffb
    80006e48:	068080e7          	jalr	104(ra) # 80001eac <_Z11printStringPKc>
    while (getCnt()) {
    80006e4c:	00048513          	mv	a0,s1
    80006e50:	00000097          	auipc	ra,0x0
    80006e54:	f30080e7          	jalr	-208(ra) # 80006d80 <_ZN9BufferCPP6getCntEv>
    80006e58:	02050c63          	beqz	a0,80006e90 <_ZN9BufferCPPD1Ev+0x78>
        char ch = buffer[head];
    80006e5c:	0084b783          	ld	a5,8(s1)
    80006e60:	0104a703          	lw	a4,16(s1)
    80006e64:	00271713          	slli	a4,a4,0x2
    80006e68:	00e787b3          	add	a5,a5,a4
    80006e6c:	0007c503          	lbu	a0,0(a5)
    80006e70:	ffffa097          	auipc	ra,0xffffa
    80006e74:	740080e7          	jalr	1856(ra) # 800015b0 <_Z4putcc>
        head = (head + 1) % cap;
    80006e78:	0104a783          	lw	a5,16(s1)
    80006e7c:	0017879b          	addiw	a5,a5,1
    80006e80:	0004a703          	lw	a4,0(s1)
    80006e84:	02e7e7bb          	remw	a5,a5,a4
    80006e88:	00f4a823          	sw	a5,16(s1)
    while (getCnt()) {
    80006e8c:	fc1ff06f          	j	80006e4c <_ZN9BufferCPPD1Ev+0x34>
    80006e90:	02100513          	li	a0,33
    80006e94:	ffffa097          	auipc	ra,0xffffa
    80006e98:	71c080e7          	jalr	1820(ra) # 800015b0 <_Z4putcc>
    80006e9c:	00a00513          	li	a0,10
    80006ea0:	ffffa097          	auipc	ra,0xffffa
    80006ea4:	710080e7          	jalr	1808(ra) # 800015b0 <_Z4putcc>
    mem_free(buffer);
    80006ea8:	0084b503          	ld	a0,8(s1)
    80006eac:	ffffa097          	auipc	ra,0xffffa
    80006eb0:	414080e7          	jalr	1044(ra) # 800012c0 <_Z8mem_freePv>
    delete itemAvailable;
    80006eb4:	0204b503          	ld	a0,32(s1)
    80006eb8:	00050863          	beqz	a0,80006ec8 <_ZN9BufferCPPD1Ev+0xb0>
    80006ebc:	00053783          	ld	a5,0(a0)
    80006ec0:	0087b783          	ld	a5,8(a5)
    80006ec4:	000780e7          	jalr	a5
    delete spaceAvailable;
    80006ec8:	0184b503          	ld	a0,24(s1)
    80006ecc:	00050863          	beqz	a0,80006edc <_ZN9BufferCPPD1Ev+0xc4>
    80006ed0:	00053783          	ld	a5,0(a0)
    80006ed4:	0087b783          	ld	a5,8(a5)
    80006ed8:	000780e7          	jalr	a5
    delete mutexTail;
    80006edc:	0304b503          	ld	a0,48(s1)
    80006ee0:	00050863          	beqz	a0,80006ef0 <_ZN9BufferCPPD1Ev+0xd8>
    80006ee4:	00053783          	ld	a5,0(a0)
    80006ee8:	0087b783          	ld	a5,8(a5)
    80006eec:	000780e7          	jalr	a5
    delete mutexHead;
    80006ef0:	0284b503          	ld	a0,40(s1)
    80006ef4:	00050863          	beqz	a0,80006f04 <_ZN9BufferCPPD1Ev+0xec>
    80006ef8:	00053783          	ld	a5,0(a0)
    80006efc:	0087b783          	ld	a5,8(a5)
    80006f00:	000780e7          	jalr	a5
}
    80006f04:	01813083          	ld	ra,24(sp)
    80006f08:	01013403          	ld	s0,16(sp)
    80006f0c:	00813483          	ld	s1,8(sp)
    80006f10:	02010113          	addi	sp,sp,32
    80006f14:	00008067          	ret

0000000080006f18 <_Z8userMainv>:
#include "../test/ConsumerProducer_CPP_API_test.hpp"
#include "System_Mode_test.hpp"

#endif

void userMain() {
    80006f18:	fe010113          	addi	sp,sp,-32
    80006f1c:	00113c23          	sd	ra,24(sp)
    80006f20:	00813823          	sd	s0,16(sp)
    80006f24:	00913423          	sd	s1,8(sp)
    80006f28:	02010413          	addi	s0,sp,32
    printString("Unesite broj testa? [1-7]\n");
    80006f2c:	00003517          	auipc	a0,0x3
    80006f30:	6a450513          	addi	a0,a0,1700 # 8000a5d0 <CONSOLE_STATUS+0x5c0>
    80006f34:	ffffb097          	auipc	ra,0xffffb
    80006f38:	f78080e7          	jalr	-136(ra) # 80001eac <_Z11printStringPKc>
    int test = getc() - '0';
    80006f3c:	ffffa097          	auipc	ra,0xffffa
    80006f40:	638080e7          	jalr	1592(ra) # 80001574 <_Z4getcv>
    80006f44:	fd05049b          	addiw	s1,a0,-48
    getc(); // Enter posle broja
    80006f48:	ffffa097          	auipc	ra,0xffffa
    80006f4c:	62c080e7          	jalr	1580(ra) # 80001574 <_Z4getcv>
            printString("Nije navedeno da je zadatak 4 implementiran\n");
            return;
        }
    }

    switch (test) {
    80006f50:	00700793          	li	a5,7
    80006f54:	1097e263          	bltu	a5,s1,80007058 <_Z8userMainv+0x140>
    80006f58:	00249493          	slli	s1,s1,0x2
    80006f5c:	00004717          	auipc	a4,0x4
    80006f60:	8cc70713          	addi	a4,a4,-1844 # 8000a828 <CONSOLE_STATUS+0x818>
    80006f64:	00e484b3          	add	s1,s1,a4
    80006f68:	0004a783          	lw	a5,0(s1)
    80006f6c:	00e787b3          	add	a5,a5,a4
    80006f70:	00078067          	jr	a5
        case 1:
#if LEVEL_2_IMPLEMENTED == 1
            Threads_C_API_test();
    80006f74:	fffff097          	auipc	ra,0xfffff
    80006f78:	284080e7          	jalr	644(ra) # 800061f8 <_Z18Threads_C_API_testv>
            printString("TEST 1 (zadatak 2, niti C API i sinhrona promena konteksta)\n");
    80006f7c:	00003517          	auipc	a0,0x3
    80006f80:	67450513          	addi	a0,a0,1652 # 8000a5f0 <CONSOLE_STATUS+0x5e0>
    80006f84:	ffffb097          	auipc	ra,0xffffb
    80006f88:	f28080e7          	jalr	-216(ra) # 80001eac <_Z11printStringPKc>
#endif
            break;
        default:
            printString("Niste uneli odgovarajuci broj za test\n");
    }
    80006f8c:	01813083          	ld	ra,24(sp)
    80006f90:	01013403          	ld	s0,16(sp)
    80006f94:	00813483          	ld	s1,8(sp)
    80006f98:	02010113          	addi	sp,sp,32
    80006f9c:	00008067          	ret
            Threads_CPP_API_test();
    80006fa0:	ffffe097          	auipc	ra,0xffffe
    80006fa4:	340080e7          	jalr	832(ra) # 800052e0 <_Z20Threads_CPP_API_testv>
            printString("TEST 2 (zadatak 2., niti CPP API i sinhrona promena konteksta)\n");
    80006fa8:	00003517          	auipc	a0,0x3
    80006fac:	68850513          	addi	a0,a0,1672 # 8000a630 <CONSOLE_STATUS+0x620>
    80006fb0:	ffffb097          	auipc	ra,0xffffb
    80006fb4:	efc080e7          	jalr	-260(ra) # 80001eac <_Z11printStringPKc>
            break;
    80006fb8:	fd5ff06f          	j	80006f8c <_Z8userMainv+0x74>
            producerConsumer_C_API();
    80006fbc:	ffffe097          	auipc	ra,0xffffe
    80006fc0:	b78080e7          	jalr	-1160(ra) # 80004b34 <_Z22producerConsumer_C_APIv>
            printString("TEST 3 (zadatak 3., kompletan C API sa semaforima, sinhrona promena konteksta)\n");
    80006fc4:	00003517          	auipc	a0,0x3
    80006fc8:	6ac50513          	addi	a0,a0,1708 # 8000a670 <CONSOLE_STATUS+0x660>
    80006fcc:	ffffb097          	auipc	ra,0xffffb
    80006fd0:	ee0080e7          	jalr	-288(ra) # 80001eac <_Z11printStringPKc>
            break;
    80006fd4:	fb9ff06f          	j	80006f8c <_Z8userMainv+0x74>
            producerConsumer_CPP_Sync_API();
    80006fd8:	fffff097          	auipc	ra,0xfffff
    80006fdc:	570080e7          	jalr	1392(ra) # 80006548 <_Z29producerConsumer_CPP_Sync_APIv>
            printString("TEST 4 (zadatak 3., kompletan CPP API sa semaforima, sinhrona promena konteksta)\n");
    80006fe0:	00003517          	auipc	a0,0x3
    80006fe4:	6e050513          	addi	a0,a0,1760 # 8000a6c0 <CONSOLE_STATUS+0x6b0>
    80006fe8:	ffffb097          	auipc	ra,0xffffb
    80006fec:	ec4080e7          	jalr	-316(ra) # 80001eac <_Z11printStringPKc>
            break;
    80006ff0:	f9dff06f          	j	80006f8c <_Z8userMainv+0x74>
            testSleeping();
    80006ff4:	00000097          	auipc	ra,0x0
    80006ff8:	11c080e7          	jalr	284(ra) # 80007110 <_Z12testSleepingv>
            printString("TEST 5 (zadatak 4., thread_sleep test C API)\n");
    80006ffc:	00003517          	auipc	a0,0x3
    80007000:	71c50513          	addi	a0,a0,1820 # 8000a718 <CONSOLE_STATUS+0x708>
    80007004:	ffffb097          	auipc	ra,0xffffb
    80007008:	ea8080e7          	jalr	-344(ra) # 80001eac <_Z11printStringPKc>
            break;
    8000700c:	f81ff06f          	j	80006f8c <_Z8userMainv+0x74>
            testConsumerProducer();
    80007010:	ffffe097          	auipc	ra,0xffffe
    80007014:	634080e7          	jalr	1588(ra) # 80005644 <_Z20testConsumerProducerv>
            printString("TEST 6 (zadatak 4. CPP API i asinhrona promena konteksta)\n");
    80007018:	00003517          	auipc	a0,0x3
    8000701c:	73050513          	addi	a0,a0,1840 # 8000a748 <CONSOLE_STATUS+0x738>
    80007020:	ffffb097          	auipc	ra,0xffffb
    80007024:	e8c080e7          	jalr	-372(ra) # 80001eac <_Z11printStringPKc>
            break;
    80007028:	f65ff06f          	j	80006f8c <_Z8userMainv+0x74>
            System_Mode_test();
    8000702c:	00000097          	auipc	ra,0x0
    80007030:	658080e7          	jalr	1624(ra) # 80007684 <_Z16System_Mode_testv>
            printString("Test se nije uspesno zavrsio\n");
    80007034:	00003517          	auipc	a0,0x3
    80007038:	75450513          	addi	a0,a0,1876 # 8000a788 <CONSOLE_STATUS+0x778>
    8000703c:	ffffb097          	auipc	ra,0xffffb
    80007040:	e70080e7          	jalr	-400(ra) # 80001eac <_Z11printStringPKc>
            printString("TEST 7 (zadatak 2., testiranje da li se korisnicki kod izvrsava u korisnickom rezimu)\n");
    80007044:	00003517          	auipc	a0,0x3
    80007048:	76450513          	addi	a0,a0,1892 # 8000a7a8 <CONSOLE_STATUS+0x798>
    8000704c:	ffffb097          	auipc	ra,0xffffb
    80007050:	e60080e7          	jalr	-416(ra) # 80001eac <_Z11printStringPKc>
            break;
    80007054:	f39ff06f          	j	80006f8c <_Z8userMainv+0x74>
            printString("Niste uneli odgovarajuci broj za test\n");
    80007058:	00003517          	auipc	a0,0x3
    8000705c:	7a850513          	addi	a0,a0,1960 # 8000a800 <CONSOLE_STATUS+0x7f0>
    80007060:	ffffb097          	auipc	ra,0xffffb
    80007064:	e4c080e7          	jalr	-436(ra) # 80001eac <_Z11printStringPKc>
    80007068:	f25ff06f          	j	80006f8c <_Z8userMainv+0x74>

000000008000706c <_ZL9sleepyRunPv>:

#include "../h/printing.hpp"

static volatile bool finished[2];

static void sleepyRun(void *arg) {
    8000706c:	fe010113          	addi	sp,sp,-32
    80007070:	00113c23          	sd	ra,24(sp)
    80007074:	00813823          	sd	s0,16(sp)
    80007078:	00913423          	sd	s1,8(sp)
    8000707c:	01213023          	sd	s2,0(sp)
    80007080:	02010413          	addi	s0,sp,32
    uint64 sleep_time = *((uint64 *) arg);
    80007084:	00053903          	ld	s2,0(a0)
    int i = 6;
    80007088:	00600493          	li	s1,6
    while (--i > 0) {
    8000708c:	fff4849b          	addiw	s1,s1,-1
    80007090:	04905463          	blez	s1,800070d8 <_ZL9sleepyRunPv+0x6c>

        printString("Hello ");
    80007094:	00003517          	auipc	a0,0x3
    80007098:	7b450513          	addi	a0,a0,1972 # 8000a848 <CONSOLE_STATUS+0x838>
    8000709c:	ffffb097          	auipc	ra,0xffffb
    800070a0:	e10080e7          	jalr	-496(ra) # 80001eac <_Z11printStringPKc>
        printInt(sleep_time);
    800070a4:	00000613          	li	a2,0
    800070a8:	00a00593          	li	a1,10
    800070ac:	0009051b          	sext.w	a0,s2
    800070b0:	ffffb097          	auipc	ra,0xffffb
    800070b4:	fac080e7          	jalr	-84(ra) # 8000205c <_Z8printIntiii>
        printString(" !\n");
    800070b8:	00003517          	auipc	a0,0x3
    800070bc:	79850513          	addi	a0,a0,1944 # 8000a850 <CONSOLE_STATUS+0x840>
    800070c0:	ffffb097          	auipc	ra,0xffffb
    800070c4:	dec080e7          	jalr	-532(ra) # 80001eac <_Z11printStringPKc>
        time_sleep(sleep_time);
    800070c8:	00090513          	mv	a0,s2
    800070cc:	ffffa097          	auipc	ra,0xffffa
    800070d0:	474080e7          	jalr	1140(ra) # 80001540 <_Z10time_sleepm>
    while (--i > 0) {
    800070d4:	fb9ff06f          	j	8000708c <_ZL9sleepyRunPv+0x20>
    }
    finished[sleep_time/10-1] = true;
    800070d8:	00a00793          	li	a5,10
    800070dc:	02f95933          	divu	s2,s2,a5
    800070e0:	fff90913          	addi	s2,s2,-1
    800070e4:	00008797          	auipc	a5,0x8
    800070e8:	9dc78793          	addi	a5,a5,-1572 # 8000eac0 <_ZL8finished>
    800070ec:	01278933          	add	s2,a5,s2
    800070f0:	00100793          	li	a5,1
    800070f4:	00f90023          	sb	a5,0(s2)
}
    800070f8:	01813083          	ld	ra,24(sp)
    800070fc:	01013403          	ld	s0,16(sp)
    80007100:	00813483          	ld	s1,8(sp)
    80007104:	00013903          	ld	s2,0(sp)
    80007108:	02010113          	addi	sp,sp,32
    8000710c:	00008067          	ret

0000000080007110 <_Z12testSleepingv>:

void testSleeping() {
    80007110:	fc010113          	addi	sp,sp,-64
    80007114:	02113c23          	sd	ra,56(sp)
    80007118:	02813823          	sd	s0,48(sp)
    8000711c:	02913423          	sd	s1,40(sp)
    80007120:	04010413          	addi	s0,sp,64
    const int sleepy_thread_count = 2;
    uint64 sleep_times[sleepy_thread_count] = {10, 20};
    80007124:	00a00793          	li	a5,10
    80007128:	fcf43823          	sd	a5,-48(s0)
    8000712c:	01400793          	li	a5,20
    80007130:	fcf43c23          	sd	a5,-40(s0)
    thread_t sleepyThread[sleepy_thread_count];

    for (int i = 0; i < sleepy_thread_count; i++) {
    80007134:	00000493          	li	s1,0
    80007138:	02c0006f          	j	80007164 <_Z12testSleepingv+0x54>
        thread_create(&sleepyThread[i], sleepyRun, sleep_times + i);
    8000713c:	00349793          	slli	a5,s1,0x3
    80007140:	fd040613          	addi	a2,s0,-48
    80007144:	00f60633          	add	a2,a2,a5
    80007148:	00000597          	auipc	a1,0x0
    8000714c:	f2458593          	addi	a1,a1,-220 # 8000706c <_ZL9sleepyRunPv>
    80007150:	fc040513          	addi	a0,s0,-64
    80007154:	00f50533          	add	a0,a0,a5
    80007158:	ffffa097          	auipc	ra,0xffffa
    8000715c:	1a8080e7          	jalr	424(ra) # 80001300 <_Z13thread_createPP8thread_sPFvPvES2_>
    for (int i = 0; i < sleepy_thread_count; i++) {
    80007160:	0014849b          	addiw	s1,s1,1
    80007164:	00100793          	li	a5,1
    80007168:	fc97dae3          	bge	a5,s1,8000713c <_Z12testSleepingv+0x2c>
    }

    while (!(finished[0] && finished[1])) {}
    8000716c:	00008797          	auipc	a5,0x8
    80007170:	9547c783          	lbu	a5,-1708(a5) # 8000eac0 <_ZL8finished>
    80007174:	fe078ce3          	beqz	a5,8000716c <_Z12testSleepingv+0x5c>
    80007178:	00008797          	auipc	a5,0x8
    8000717c:	9497c783          	lbu	a5,-1719(a5) # 8000eac1 <_ZL8finished+0x1>
    80007180:	fe0786e3          	beqz	a5,8000716c <_Z12testSleepingv+0x5c>
}
    80007184:	03813083          	ld	ra,56(sp)
    80007188:	03013403          	ld	s0,48(sp)
    8000718c:	02813483          	ld	s1,40(sp)
    80007190:	04010113          	addi	sp,sp,64
    80007194:	00008067          	ret

0000000080007198 <_ZL9fibonaccim>:
static volatile bool finishedA = false;
static volatile bool finishedB = false;
static volatile bool finishedC = false;
static volatile bool finishedD = false;

static uint64 fibonacci(uint64 n) {
    80007198:	fe010113          	addi	sp,sp,-32
    8000719c:	00113c23          	sd	ra,24(sp)
    800071a0:	00813823          	sd	s0,16(sp)
    800071a4:	00913423          	sd	s1,8(sp)
    800071a8:	01213023          	sd	s2,0(sp)
    800071ac:	02010413          	addi	s0,sp,32
    800071b0:	00050493          	mv	s1,a0
    if (n == 0 || n == 1) { return n; }
    800071b4:	00100793          	li	a5,1
    800071b8:	02a7f863          	bgeu	a5,a0,800071e8 <_ZL9fibonaccim+0x50>
    if (n % 10 == 0) { thread_dispatch(); }
    800071bc:	00a00793          	li	a5,10
    800071c0:	02f577b3          	remu	a5,a0,a5
    800071c4:	02078e63          	beqz	a5,80007200 <_ZL9fibonaccim+0x68>
    return fibonacci(n - 1) + fibonacci(n - 2);
    800071c8:	fff48513          	addi	a0,s1,-1
    800071cc:	00000097          	auipc	ra,0x0
    800071d0:	fcc080e7          	jalr	-52(ra) # 80007198 <_ZL9fibonaccim>
    800071d4:	00050913          	mv	s2,a0
    800071d8:	ffe48513          	addi	a0,s1,-2
    800071dc:	00000097          	auipc	ra,0x0
    800071e0:	fbc080e7          	jalr	-68(ra) # 80007198 <_ZL9fibonaccim>
    800071e4:	00a90533          	add	a0,s2,a0
}
    800071e8:	01813083          	ld	ra,24(sp)
    800071ec:	01013403          	ld	s0,16(sp)
    800071f0:	00813483          	ld	s1,8(sp)
    800071f4:	00013903          	ld	s2,0(sp)
    800071f8:	02010113          	addi	sp,sp,32
    800071fc:	00008067          	ret
    if (n % 10 == 0) { thread_dispatch(); }
    80007200:	ffffa097          	auipc	ra,0xffffa
    80007204:	188080e7          	jalr	392(ra) # 80001388 <_Z15thread_dispatchv>
    80007208:	fc1ff06f          	j	800071c8 <_ZL9fibonaccim+0x30>

000000008000720c <_ZL11workerBodyDPv>:
    printString("A finished!\n");
    finishedC = true;
    thread_dispatch();
}

static void workerBodyD(void* arg) {
    8000720c:	fe010113          	addi	sp,sp,-32
    80007210:	00113c23          	sd	ra,24(sp)
    80007214:	00813823          	sd	s0,16(sp)
    80007218:	00913423          	sd	s1,8(sp)
    8000721c:	01213023          	sd	s2,0(sp)
    80007220:	02010413          	addi	s0,sp,32
    uint8 i = 10;
    80007224:	00a00493          	li	s1,10
    80007228:	0400006f          	j	80007268 <_ZL11workerBodyDPv+0x5c>
    for (; i < 13; i++) {
        printString("D: i="); printInt(i); printString("\n");
    8000722c:	00003517          	auipc	a0,0x3
    80007230:	2f450513          	addi	a0,a0,756 # 8000a520 <CONSOLE_STATUS+0x510>
    80007234:	ffffb097          	auipc	ra,0xffffb
    80007238:	c78080e7          	jalr	-904(ra) # 80001eac <_Z11printStringPKc>
    8000723c:	00000613          	li	a2,0
    80007240:	00a00593          	li	a1,10
    80007244:	00048513          	mv	a0,s1
    80007248:	ffffb097          	auipc	ra,0xffffb
    8000724c:	e14080e7          	jalr	-492(ra) # 8000205c <_Z8printIntiii>
    80007250:	00003517          	auipc	a0,0x3
    80007254:	4c050513          	addi	a0,a0,1216 # 8000a710 <CONSOLE_STATUS+0x700>
    80007258:	ffffb097          	auipc	ra,0xffffb
    8000725c:	c54080e7          	jalr	-940(ra) # 80001eac <_Z11printStringPKc>
    for (; i < 13; i++) {
    80007260:	0014849b          	addiw	s1,s1,1
    80007264:	0ff4f493          	andi	s1,s1,255
    80007268:	00c00793          	li	a5,12
    8000726c:	fc97f0e3          	bgeu	a5,s1,8000722c <_ZL11workerBodyDPv+0x20>
    }

    printString("D: dispatch\n");
    80007270:	00003517          	auipc	a0,0x3
    80007274:	2b850513          	addi	a0,a0,696 # 8000a528 <CONSOLE_STATUS+0x518>
    80007278:	ffffb097          	auipc	ra,0xffffb
    8000727c:	c34080e7          	jalr	-972(ra) # 80001eac <_Z11printStringPKc>
    __asm__ ("li t1, 5");
    80007280:	00500313          	li	t1,5
    thread_dispatch();
    80007284:	ffffa097          	auipc	ra,0xffffa
    80007288:	104080e7          	jalr	260(ra) # 80001388 <_Z15thread_dispatchv>

    uint64 result = fibonacci(16);
    8000728c:	01000513          	li	a0,16
    80007290:	00000097          	auipc	ra,0x0
    80007294:	f08080e7          	jalr	-248(ra) # 80007198 <_ZL9fibonaccim>
    80007298:	00050913          	mv	s2,a0
    printString("D: fibonaci="); printInt(result); printString("\n");
    8000729c:	00003517          	auipc	a0,0x3
    800072a0:	29c50513          	addi	a0,a0,668 # 8000a538 <CONSOLE_STATUS+0x528>
    800072a4:	ffffb097          	auipc	ra,0xffffb
    800072a8:	c08080e7          	jalr	-1016(ra) # 80001eac <_Z11printStringPKc>
    800072ac:	00000613          	li	a2,0
    800072b0:	00a00593          	li	a1,10
    800072b4:	0009051b          	sext.w	a0,s2
    800072b8:	ffffb097          	auipc	ra,0xffffb
    800072bc:	da4080e7          	jalr	-604(ra) # 8000205c <_Z8printIntiii>
    800072c0:	00003517          	auipc	a0,0x3
    800072c4:	45050513          	addi	a0,a0,1104 # 8000a710 <CONSOLE_STATUS+0x700>
    800072c8:	ffffb097          	auipc	ra,0xffffb
    800072cc:	be4080e7          	jalr	-1052(ra) # 80001eac <_Z11printStringPKc>
    800072d0:	0400006f          	j	80007310 <_ZL11workerBodyDPv+0x104>

    for (; i < 16; i++) {
        printString("D: i="); printInt(i); printString("\n");
    800072d4:	00003517          	auipc	a0,0x3
    800072d8:	24c50513          	addi	a0,a0,588 # 8000a520 <CONSOLE_STATUS+0x510>
    800072dc:	ffffb097          	auipc	ra,0xffffb
    800072e0:	bd0080e7          	jalr	-1072(ra) # 80001eac <_Z11printStringPKc>
    800072e4:	00000613          	li	a2,0
    800072e8:	00a00593          	li	a1,10
    800072ec:	00048513          	mv	a0,s1
    800072f0:	ffffb097          	auipc	ra,0xffffb
    800072f4:	d6c080e7          	jalr	-660(ra) # 8000205c <_Z8printIntiii>
    800072f8:	00003517          	auipc	a0,0x3
    800072fc:	41850513          	addi	a0,a0,1048 # 8000a710 <CONSOLE_STATUS+0x700>
    80007300:	ffffb097          	auipc	ra,0xffffb
    80007304:	bac080e7          	jalr	-1108(ra) # 80001eac <_Z11printStringPKc>
    for (; i < 16; i++) {
    80007308:	0014849b          	addiw	s1,s1,1
    8000730c:	0ff4f493          	andi	s1,s1,255
    80007310:	00f00793          	li	a5,15
    80007314:	fc97f0e3          	bgeu	a5,s1,800072d4 <_ZL11workerBodyDPv+0xc8>
    }

    printString("D finished!\n");
    80007318:	00003517          	auipc	a0,0x3
    8000731c:	23050513          	addi	a0,a0,560 # 8000a548 <CONSOLE_STATUS+0x538>
    80007320:	ffffb097          	auipc	ra,0xffffb
    80007324:	b8c080e7          	jalr	-1140(ra) # 80001eac <_Z11printStringPKc>
    finishedD = true;
    80007328:	00100793          	li	a5,1
    8000732c:	00007717          	auipc	a4,0x7
    80007330:	78f70b23          	sb	a5,1942(a4) # 8000eac2 <_ZL9finishedD>
    thread_dispatch();
    80007334:	ffffa097          	auipc	ra,0xffffa
    80007338:	054080e7          	jalr	84(ra) # 80001388 <_Z15thread_dispatchv>
}
    8000733c:	01813083          	ld	ra,24(sp)
    80007340:	01013403          	ld	s0,16(sp)
    80007344:	00813483          	ld	s1,8(sp)
    80007348:	00013903          	ld	s2,0(sp)
    8000734c:	02010113          	addi	sp,sp,32
    80007350:	00008067          	ret

0000000080007354 <_ZL11workerBodyCPv>:
static void workerBodyC(void* arg) {
    80007354:	fe010113          	addi	sp,sp,-32
    80007358:	00113c23          	sd	ra,24(sp)
    8000735c:	00813823          	sd	s0,16(sp)
    80007360:	00913423          	sd	s1,8(sp)
    80007364:	01213023          	sd	s2,0(sp)
    80007368:	02010413          	addi	s0,sp,32
    uint8 i = 0;
    8000736c:	00000493          	li	s1,0
    80007370:	0400006f          	j	800073b0 <_ZL11workerBodyCPv+0x5c>
        printString("C: i="); printInt(i); printString("\n");
    80007374:	00003517          	auipc	a0,0x3
    80007378:	17c50513          	addi	a0,a0,380 # 8000a4f0 <CONSOLE_STATUS+0x4e0>
    8000737c:	ffffb097          	auipc	ra,0xffffb
    80007380:	b30080e7          	jalr	-1232(ra) # 80001eac <_Z11printStringPKc>
    80007384:	00000613          	li	a2,0
    80007388:	00a00593          	li	a1,10
    8000738c:	00048513          	mv	a0,s1
    80007390:	ffffb097          	auipc	ra,0xffffb
    80007394:	ccc080e7          	jalr	-820(ra) # 8000205c <_Z8printIntiii>
    80007398:	00003517          	auipc	a0,0x3
    8000739c:	37850513          	addi	a0,a0,888 # 8000a710 <CONSOLE_STATUS+0x700>
    800073a0:	ffffb097          	auipc	ra,0xffffb
    800073a4:	b0c080e7          	jalr	-1268(ra) # 80001eac <_Z11printStringPKc>
    for (; i < 3; i++) {
    800073a8:	0014849b          	addiw	s1,s1,1
    800073ac:	0ff4f493          	andi	s1,s1,255
    800073b0:	00200793          	li	a5,2
    800073b4:	fc97f0e3          	bgeu	a5,s1,80007374 <_ZL11workerBodyCPv+0x20>
    printString("C: dispatch\n");
    800073b8:	00003517          	auipc	a0,0x3
    800073bc:	14050513          	addi	a0,a0,320 # 8000a4f8 <CONSOLE_STATUS+0x4e8>
    800073c0:	ffffb097          	auipc	ra,0xffffb
    800073c4:	aec080e7          	jalr	-1300(ra) # 80001eac <_Z11printStringPKc>
    __asm__ ("li t1, 7");
    800073c8:	00700313          	li	t1,7
    thread_dispatch();
    800073cc:	ffffa097          	auipc	ra,0xffffa
    800073d0:	fbc080e7          	jalr	-68(ra) # 80001388 <_Z15thread_dispatchv>
    __asm__ ("mv %[t1], t1" : [t1] "=r"(t1));
    800073d4:	00030913          	mv	s2,t1
    printString("C: t1="); printInt(t1); printString("\n");
    800073d8:	00003517          	auipc	a0,0x3
    800073dc:	13050513          	addi	a0,a0,304 # 8000a508 <CONSOLE_STATUS+0x4f8>
    800073e0:	ffffb097          	auipc	ra,0xffffb
    800073e4:	acc080e7          	jalr	-1332(ra) # 80001eac <_Z11printStringPKc>
    800073e8:	00000613          	li	a2,0
    800073ec:	00a00593          	li	a1,10
    800073f0:	0009051b          	sext.w	a0,s2
    800073f4:	ffffb097          	auipc	ra,0xffffb
    800073f8:	c68080e7          	jalr	-920(ra) # 8000205c <_Z8printIntiii>
    800073fc:	00003517          	auipc	a0,0x3
    80007400:	31450513          	addi	a0,a0,788 # 8000a710 <CONSOLE_STATUS+0x700>
    80007404:	ffffb097          	auipc	ra,0xffffb
    80007408:	aa8080e7          	jalr	-1368(ra) # 80001eac <_Z11printStringPKc>
    uint64 result = fibonacci(12);
    8000740c:	00c00513          	li	a0,12
    80007410:	00000097          	auipc	ra,0x0
    80007414:	d88080e7          	jalr	-632(ra) # 80007198 <_ZL9fibonaccim>
    80007418:	00050913          	mv	s2,a0
    printString("C: fibonaci="); printInt(result); printString("\n");
    8000741c:	00003517          	auipc	a0,0x3
    80007420:	0f450513          	addi	a0,a0,244 # 8000a510 <CONSOLE_STATUS+0x500>
    80007424:	ffffb097          	auipc	ra,0xffffb
    80007428:	a88080e7          	jalr	-1400(ra) # 80001eac <_Z11printStringPKc>
    8000742c:	00000613          	li	a2,0
    80007430:	00a00593          	li	a1,10
    80007434:	0009051b          	sext.w	a0,s2
    80007438:	ffffb097          	auipc	ra,0xffffb
    8000743c:	c24080e7          	jalr	-988(ra) # 8000205c <_Z8printIntiii>
    80007440:	00003517          	auipc	a0,0x3
    80007444:	2d050513          	addi	a0,a0,720 # 8000a710 <CONSOLE_STATUS+0x700>
    80007448:	ffffb097          	auipc	ra,0xffffb
    8000744c:	a64080e7          	jalr	-1436(ra) # 80001eac <_Z11printStringPKc>
    80007450:	0400006f          	j	80007490 <_ZL11workerBodyCPv+0x13c>
        printString("C: i="); printInt(i); printString("\n");
    80007454:	00003517          	auipc	a0,0x3
    80007458:	09c50513          	addi	a0,a0,156 # 8000a4f0 <CONSOLE_STATUS+0x4e0>
    8000745c:	ffffb097          	auipc	ra,0xffffb
    80007460:	a50080e7          	jalr	-1456(ra) # 80001eac <_Z11printStringPKc>
    80007464:	00000613          	li	a2,0
    80007468:	00a00593          	li	a1,10
    8000746c:	00048513          	mv	a0,s1
    80007470:	ffffb097          	auipc	ra,0xffffb
    80007474:	bec080e7          	jalr	-1044(ra) # 8000205c <_Z8printIntiii>
    80007478:	00003517          	auipc	a0,0x3
    8000747c:	29850513          	addi	a0,a0,664 # 8000a710 <CONSOLE_STATUS+0x700>
    80007480:	ffffb097          	auipc	ra,0xffffb
    80007484:	a2c080e7          	jalr	-1492(ra) # 80001eac <_Z11printStringPKc>
    for (; i < 6; i++) {
    80007488:	0014849b          	addiw	s1,s1,1
    8000748c:	0ff4f493          	andi	s1,s1,255
    80007490:	00500793          	li	a5,5
    80007494:	fc97f0e3          	bgeu	a5,s1,80007454 <_ZL11workerBodyCPv+0x100>
    printString("A finished!\n");
    80007498:	00003517          	auipc	a0,0x3
    8000749c:	03050513          	addi	a0,a0,48 # 8000a4c8 <CONSOLE_STATUS+0x4b8>
    800074a0:	ffffb097          	auipc	ra,0xffffb
    800074a4:	a0c080e7          	jalr	-1524(ra) # 80001eac <_Z11printStringPKc>
    finishedC = true;
    800074a8:	00100793          	li	a5,1
    800074ac:	00007717          	auipc	a4,0x7
    800074b0:	60f70ba3          	sb	a5,1559(a4) # 8000eac3 <_ZL9finishedC>
    thread_dispatch();
    800074b4:	ffffa097          	auipc	ra,0xffffa
    800074b8:	ed4080e7          	jalr	-300(ra) # 80001388 <_Z15thread_dispatchv>
}
    800074bc:	01813083          	ld	ra,24(sp)
    800074c0:	01013403          	ld	s0,16(sp)
    800074c4:	00813483          	ld	s1,8(sp)
    800074c8:	00013903          	ld	s2,0(sp)
    800074cc:	02010113          	addi	sp,sp,32
    800074d0:	00008067          	ret

00000000800074d4 <_ZL11workerBodyBPv>:
static void workerBodyB(void* arg) {
    800074d4:	fe010113          	addi	sp,sp,-32
    800074d8:	00113c23          	sd	ra,24(sp)
    800074dc:	00813823          	sd	s0,16(sp)
    800074e0:	00913423          	sd	s1,8(sp)
    800074e4:	01213023          	sd	s2,0(sp)
    800074e8:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 16; i++) {
    800074ec:	00000913          	li	s2,0
    800074f0:	0400006f          	j	80007530 <_ZL11workerBodyBPv+0x5c>
            thread_dispatch();
    800074f4:	ffffa097          	auipc	ra,0xffffa
    800074f8:	e94080e7          	jalr	-364(ra) # 80001388 <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++) {
    800074fc:	00148493          	addi	s1,s1,1
    80007500:	000027b7          	lui	a5,0x2
    80007504:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    80007508:	0097ee63          	bltu	a5,s1,80007524 <_ZL11workerBodyBPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    8000750c:	00000713          	li	a4,0
    80007510:	000077b7          	lui	a5,0x7
    80007514:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    80007518:	fce7eee3          	bltu	a5,a4,800074f4 <_ZL11workerBodyBPv+0x20>
    8000751c:	00170713          	addi	a4,a4,1
    80007520:	ff1ff06f          	j	80007510 <_ZL11workerBodyBPv+0x3c>
        if (i == 10) {
    80007524:	00a00793          	li	a5,10
    80007528:	04f90663          	beq	s2,a5,80007574 <_ZL11workerBodyBPv+0xa0>
    for (uint64 i = 0; i < 16; i++) {
    8000752c:	00190913          	addi	s2,s2,1
    80007530:	00f00793          	li	a5,15
    80007534:	0527e463          	bltu	a5,s2,8000757c <_ZL11workerBodyBPv+0xa8>
        printString("B: i="); printInt(i); printString("\n");
    80007538:	00003517          	auipc	a0,0x3
    8000753c:	fa050513          	addi	a0,a0,-96 # 8000a4d8 <CONSOLE_STATUS+0x4c8>
    80007540:	ffffb097          	auipc	ra,0xffffb
    80007544:	96c080e7          	jalr	-1684(ra) # 80001eac <_Z11printStringPKc>
    80007548:	00000613          	li	a2,0
    8000754c:	00a00593          	li	a1,10
    80007550:	0009051b          	sext.w	a0,s2
    80007554:	ffffb097          	auipc	ra,0xffffb
    80007558:	b08080e7          	jalr	-1272(ra) # 8000205c <_Z8printIntiii>
    8000755c:	00003517          	auipc	a0,0x3
    80007560:	1b450513          	addi	a0,a0,436 # 8000a710 <CONSOLE_STATUS+0x700>
    80007564:	ffffb097          	auipc	ra,0xffffb
    80007568:	948080e7          	jalr	-1720(ra) # 80001eac <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    8000756c:	00000493          	li	s1,0
    80007570:	f91ff06f          	j	80007500 <_ZL11workerBodyBPv+0x2c>
            asm volatile("csrr t6, sepc");
    80007574:	14102ff3          	csrr	t6,sepc
    80007578:	fb5ff06f          	j	8000752c <_ZL11workerBodyBPv+0x58>
    printString("B finished!\n");
    8000757c:	00003517          	auipc	a0,0x3
    80007580:	f6450513          	addi	a0,a0,-156 # 8000a4e0 <CONSOLE_STATUS+0x4d0>
    80007584:	ffffb097          	auipc	ra,0xffffb
    80007588:	928080e7          	jalr	-1752(ra) # 80001eac <_Z11printStringPKc>
    finishedB = true;
    8000758c:	00100793          	li	a5,1
    80007590:	00007717          	auipc	a4,0x7
    80007594:	52f70a23          	sb	a5,1332(a4) # 8000eac4 <_ZL9finishedB>
    thread_dispatch();
    80007598:	ffffa097          	auipc	ra,0xffffa
    8000759c:	df0080e7          	jalr	-528(ra) # 80001388 <_Z15thread_dispatchv>
}
    800075a0:	01813083          	ld	ra,24(sp)
    800075a4:	01013403          	ld	s0,16(sp)
    800075a8:	00813483          	ld	s1,8(sp)
    800075ac:	00013903          	ld	s2,0(sp)
    800075b0:	02010113          	addi	sp,sp,32
    800075b4:	00008067          	ret

00000000800075b8 <_ZL11workerBodyAPv>:
static void workerBodyA(void* arg) {
    800075b8:	fe010113          	addi	sp,sp,-32
    800075bc:	00113c23          	sd	ra,24(sp)
    800075c0:	00813823          	sd	s0,16(sp)
    800075c4:	00913423          	sd	s1,8(sp)
    800075c8:	01213023          	sd	s2,0(sp)
    800075cc:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 10; i++) {
    800075d0:	00000913          	li	s2,0
    800075d4:	0380006f          	j	8000760c <_ZL11workerBodyAPv+0x54>
            thread_dispatch();
    800075d8:	ffffa097          	auipc	ra,0xffffa
    800075dc:	db0080e7          	jalr	-592(ra) # 80001388 <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++) {
    800075e0:	00148493          	addi	s1,s1,1
    800075e4:	000027b7          	lui	a5,0x2
    800075e8:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    800075ec:	0097ee63          	bltu	a5,s1,80007608 <_ZL11workerBodyAPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    800075f0:	00000713          	li	a4,0
    800075f4:	000077b7          	lui	a5,0x7
    800075f8:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    800075fc:	fce7eee3          	bltu	a5,a4,800075d8 <_ZL11workerBodyAPv+0x20>
    80007600:	00170713          	addi	a4,a4,1
    80007604:	ff1ff06f          	j	800075f4 <_ZL11workerBodyAPv+0x3c>
    for (uint64 i = 0; i < 10; i++) {
    80007608:	00190913          	addi	s2,s2,1
    8000760c:	00900793          	li	a5,9
    80007610:	0527e063          	bltu	a5,s2,80007650 <_ZL11workerBodyAPv+0x98>
        printString("A: i="); printInt(i); printString("\n");
    80007614:	00003517          	auipc	a0,0x3
    80007618:	eac50513          	addi	a0,a0,-340 # 8000a4c0 <CONSOLE_STATUS+0x4b0>
    8000761c:	ffffb097          	auipc	ra,0xffffb
    80007620:	890080e7          	jalr	-1904(ra) # 80001eac <_Z11printStringPKc>
    80007624:	00000613          	li	a2,0
    80007628:	00a00593          	li	a1,10
    8000762c:	0009051b          	sext.w	a0,s2
    80007630:	ffffb097          	auipc	ra,0xffffb
    80007634:	a2c080e7          	jalr	-1492(ra) # 8000205c <_Z8printIntiii>
    80007638:	00003517          	auipc	a0,0x3
    8000763c:	0d850513          	addi	a0,a0,216 # 8000a710 <CONSOLE_STATUS+0x700>
    80007640:	ffffb097          	auipc	ra,0xffffb
    80007644:	86c080e7          	jalr	-1940(ra) # 80001eac <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    80007648:	00000493          	li	s1,0
    8000764c:	f99ff06f          	j	800075e4 <_ZL11workerBodyAPv+0x2c>
    printString("A finished!\n");
    80007650:	00003517          	auipc	a0,0x3
    80007654:	e7850513          	addi	a0,a0,-392 # 8000a4c8 <CONSOLE_STATUS+0x4b8>
    80007658:	ffffb097          	auipc	ra,0xffffb
    8000765c:	854080e7          	jalr	-1964(ra) # 80001eac <_Z11printStringPKc>
    finishedA = true;
    80007660:	00100793          	li	a5,1
    80007664:	00007717          	auipc	a4,0x7
    80007668:	46f700a3          	sb	a5,1121(a4) # 8000eac5 <_ZL9finishedA>
}
    8000766c:	01813083          	ld	ra,24(sp)
    80007670:	01013403          	ld	s0,16(sp)
    80007674:	00813483          	ld	s1,8(sp)
    80007678:	00013903          	ld	s2,0(sp)
    8000767c:	02010113          	addi	sp,sp,32
    80007680:	00008067          	ret

0000000080007684 <_Z16System_Mode_testv>:


void System_Mode_test() {
    80007684:	fd010113          	addi	sp,sp,-48
    80007688:	02113423          	sd	ra,40(sp)
    8000768c:	02813023          	sd	s0,32(sp)
    80007690:	03010413          	addi	s0,sp,48
    thread_t threads[4];
    thread_create(&threads[0], workerBodyA, nullptr);
    80007694:	00000613          	li	a2,0
    80007698:	00000597          	auipc	a1,0x0
    8000769c:	f2058593          	addi	a1,a1,-224 # 800075b8 <_ZL11workerBodyAPv>
    800076a0:	fd040513          	addi	a0,s0,-48
    800076a4:	ffffa097          	auipc	ra,0xffffa
    800076a8:	c5c080e7          	jalr	-932(ra) # 80001300 <_Z13thread_createPP8thread_sPFvPvES2_>
    printString("ThreadA created\n");
    800076ac:	00003517          	auipc	a0,0x3
    800076b0:	eac50513          	addi	a0,a0,-340 # 8000a558 <CONSOLE_STATUS+0x548>
    800076b4:	ffffa097          	auipc	ra,0xffffa
    800076b8:	7f8080e7          	jalr	2040(ra) # 80001eac <_Z11printStringPKc>

    thread_create(&threads[1], workerBodyB, nullptr);
    800076bc:	00000613          	li	a2,0
    800076c0:	00000597          	auipc	a1,0x0
    800076c4:	e1458593          	addi	a1,a1,-492 # 800074d4 <_ZL11workerBodyBPv>
    800076c8:	fd840513          	addi	a0,s0,-40
    800076cc:	ffffa097          	auipc	ra,0xffffa
    800076d0:	c34080e7          	jalr	-972(ra) # 80001300 <_Z13thread_createPP8thread_sPFvPvES2_>
    printString("ThreadB created\n");
    800076d4:	00003517          	auipc	a0,0x3
    800076d8:	e9c50513          	addi	a0,a0,-356 # 8000a570 <CONSOLE_STATUS+0x560>
    800076dc:	ffffa097          	auipc	ra,0xffffa
    800076e0:	7d0080e7          	jalr	2000(ra) # 80001eac <_Z11printStringPKc>

    thread_create(&threads[2], workerBodyC, nullptr);
    800076e4:	00000613          	li	a2,0
    800076e8:	00000597          	auipc	a1,0x0
    800076ec:	c6c58593          	addi	a1,a1,-916 # 80007354 <_ZL11workerBodyCPv>
    800076f0:	fe040513          	addi	a0,s0,-32
    800076f4:	ffffa097          	auipc	ra,0xffffa
    800076f8:	c0c080e7          	jalr	-1012(ra) # 80001300 <_Z13thread_createPP8thread_sPFvPvES2_>
    printString("ThreadC created\n");
    800076fc:	00003517          	auipc	a0,0x3
    80007700:	e8c50513          	addi	a0,a0,-372 # 8000a588 <CONSOLE_STATUS+0x578>
    80007704:	ffffa097          	auipc	ra,0xffffa
    80007708:	7a8080e7          	jalr	1960(ra) # 80001eac <_Z11printStringPKc>

    thread_create(&threads[3], workerBodyD, nullptr);
    8000770c:	00000613          	li	a2,0
    80007710:	00000597          	auipc	a1,0x0
    80007714:	afc58593          	addi	a1,a1,-1284 # 8000720c <_ZL11workerBodyDPv>
    80007718:	fe840513          	addi	a0,s0,-24
    8000771c:	ffffa097          	auipc	ra,0xffffa
    80007720:	be4080e7          	jalr	-1052(ra) # 80001300 <_Z13thread_createPP8thread_sPFvPvES2_>
    printString("ThreadD created\n");
    80007724:	00003517          	auipc	a0,0x3
    80007728:	e7c50513          	addi	a0,a0,-388 # 8000a5a0 <CONSOLE_STATUS+0x590>
    8000772c:	ffffa097          	auipc	ra,0xffffa
    80007730:	780080e7          	jalr	1920(ra) # 80001eac <_Z11printStringPKc>
    80007734:	00c0006f          	j	80007740 <_Z16System_Mode_testv+0xbc>

    while (!(finishedA && finishedB && finishedC && finishedD)) {
        thread_dispatch();
    80007738:	ffffa097          	auipc	ra,0xffffa
    8000773c:	c50080e7          	jalr	-944(ra) # 80001388 <_Z15thread_dispatchv>
    while (!(finishedA && finishedB && finishedC && finishedD)) {
    80007740:	00007797          	auipc	a5,0x7
    80007744:	3857c783          	lbu	a5,901(a5) # 8000eac5 <_ZL9finishedA>
    80007748:	fe0788e3          	beqz	a5,80007738 <_Z16System_Mode_testv+0xb4>
    8000774c:	00007797          	auipc	a5,0x7
    80007750:	3787c783          	lbu	a5,888(a5) # 8000eac4 <_ZL9finishedB>
    80007754:	fe0782e3          	beqz	a5,80007738 <_Z16System_Mode_testv+0xb4>
    80007758:	00007797          	auipc	a5,0x7
    8000775c:	36b7c783          	lbu	a5,875(a5) # 8000eac3 <_ZL9finishedC>
    80007760:	fc078ce3          	beqz	a5,80007738 <_Z16System_Mode_testv+0xb4>
    80007764:	00007797          	auipc	a5,0x7
    80007768:	35e7c783          	lbu	a5,862(a5) # 8000eac2 <_ZL9finishedD>
    8000776c:	fc0786e3          	beqz	a5,80007738 <_Z16System_Mode_testv+0xb4>
    }

}
    80007770:	02813083          	ld	ra,40(sp)
    80007774:	02013403          	ld	s0,32(sp)
    80007778:	03010113          	addi	sp,sp,48
    8000777c:	00008067          	ret

0000000080007780 <_ZN6BufferC1Ei>:
#include "buffer.hpp"

Buffer::Buffer(int _cap) : cap(_cap + 1), head(0), tail(0) {
    80007780:	fe010113          	addi	sp,sp,-32
    80007784:	00113c23          	sd	ra,24(sp)
    80007788:	00813823          	sd	s0,16(sp)
    8000778c:	00913423          	sd	s1,8(sp)
    80007790:	01213023          	sd	s2,0(sp)
    80007794:	02010413          	addi	s0,sp,32
    80007798:	00050493          	mv	s1,a0
    8000779c:	00058913          	mv	s2,a1
    800077a0:	0015879b          	addiw	a5,a1,1
    800077a4:	0007851b          	sext.w	a0,a5
    800077a8:	00f4a023          	sw	a5,0(s1)
    800077ac:	0004a823          	sw	zero,16(s1)
    800077b0:	0004aa23          	sw	zero,20(s1)
    buffer = (int *)mem_alloc(sizeof(int) * cap);
    800077b4:	00251513          	slli	a0,a0,0x2
    800077b8:	ffffa097          	auipc	ra,0xffffa
    800077bc:	ac8080e7          	jalr	-1336(ra) # 80001280 <_Z9mem_allocm>
    800077c0:	00a4b423          	sd	a0,8(s1)
    sem_open(&itemAvailable, 0);
    800077c4:	00000593          	li	a1,0
    800077c8:	02048513          	addi	a0,s1,32
    800077cc:	ffffa097          	auipc	ra,0xffffa
    800077d0:	c70080e7          	jalr	-912(ra) # 8000143c <_Z8sem_openPP5sem_sj>
    sem_open(&spaceAvailable, _cap);
    800077d4:	00090593          	mv	a1,s2
    800077d8:	01848513          	addi	a0,s1,24
    800077dc:	ffffa097          	auipc	ra,0xffffa
    800077e0:	c60080e7          	jalr	-928(ra) # 8000143c <_Z8sem_openPP5sem_sj>
    sem_open(&mutexHead, 1);
    800077e4:	00100593          	li	a1,1
    800077e8:	02848513          	addi	a0,s1,40
    800077ec:	ffffa097          	auipc	ra,0xffffa
    800077f0:	c50080e7          	jalr	-944(ra) # 8000143c <_Z8sem_openPP5sem_sj>
    sem_open(&mutexTail, 1);
    800077f4:	00100593          	li	a1,1
    800077f8:	03048513          	addi	a0,s1,48
    800077fc:	ffffa097          	auipc	ra,0xffffa
    80007800:	c40080e7          	jalr	-960(ra) # 8000143c <_Z8sem_openPP5sem_sj>
}
    80007804:	01813083          	ld	ra,24(sp)
    80007808:	01013403          	ld	s0,16(sp)
    8000780c:	00813483          	ld	s1,8(sp)
    80007810:	00013903          	ld	s2,0(sp)
    80007814:	02010113          	addi	sp,sp,32
    80007818:	00008067          	ret

000000008000781c <_ZN6Buffer3putEi>:
    sem_close(spaceAvailable);
    sem_close(mutexTail);
    sem_close(mutexHead);
}

void Buffer::put(int val) {
    8000781c:	fe010113          	addi	sp,sp,-32
    80007820:	00113c23          	sd	ra,24(sp)
    80007824:	00813823          	sd	s0,16(sp)
    80007828:	00913423          	sd	s1,8(sp)
    8000782c:	01213023          	sd	s2,0(sp)
    80007830:	02010413          	addi	s0,sp,32
    80007834:	00050493          	mv	s1,a0
    80007838:	00058913          	mv	s2,a1
    sem_wait(spaceAvailable);
    8000783c:	01853503          	ld	a0,24(a0)
    80007840:	ffffa097          	auipc	ra,0xffffa
    80007844:	c80080e7          	jalr	-896(ra) # 800014c0 <_Z8sem_waitP5sem_s>

    sem_wait(mutexTail);
    80007848:	0304b503          	ld	a0,48(s1)
    8000784c:	ffffa097          	auipc	ra,0xffffa
    80007850:	c74080e7          	jalr	-908(ra) # 800014c0 <_Z8sem_waitP5sem_s>
    buffer[tail] = val;
    80007854:	0084b783          	ld	a5,8(s1)
    80007858:	0144a703          	lw	a4,20(s1)
    8000785c:	00271713          	slli	a4,a4,0x2
    80007860:	00e787b3          	add	a5,a5,a4
    80007864:	0127a023          	sw	s2,0(a5)
    tail = (tail + 1) % cap;
    80007868:	0144a783          	lw	a5,20(s1)
    8000786c:	0017879b          	addiw	a5,a5,1
    80007870:	0004a703          	lw	a4,0(s1)
    80007874:	02e7e7bb          	remw	a5,a5,a4
    80007878:	00f4aa23          	sw	a5,20(s1)
    sem_signal(mutexTail);
    8000787c:	0304b503          	ld	a0,48(s1)
    80007880:	ffffa097          	auipc	ra,0xffffa
    80007884:	c80080e7          	jalr	-896(ra) # 80001500 <_Z10sem_signalP5sem_s>

    sem_signal(itemAvailable);
    80007888:	0204b503          	ld	a0,32(s1)
    8000788c:	ffffa097          	auipc	ra,0xffffa
    80007890:	c74080e7          	jalr	-908(ra) # 80001500 <_Z10sem_signalP5sem_s>

}
    80007894:	01813083          	ld	ra,24(sp)
    80007898:	01013403          	ld	s0,16(sp)
    8000789c:	00813483          	ld	s1,8(sp)
    800078a0:	00013903          	ld	s2,0(sp)
    800078a4:	02010113          	addi	sp,sp,32
    800078a8:	00008067          	ret

00000000800078ac <_ZN6Buffer3getEv>:

int Buffer::get() {
    800078ac:	fe010113          	addi	sp,sp,-32
    800078b0:	00113c23          	sd	ra,24(sp)
    800078b4:	00813823          	sd	s0,16(sp)
    800078b8:	00913423          	sd	s1,8(sp)
    800078bc:	01213023          	sd	s2,0(sp)
    800078c0:	02010413          	addi	s0,sp,32
    800078c4:	00050493          	mv	s1,a0
    sem_wait(itemAvailable);
    800078c8:	02053503          	ld	a0,32(a0)
    800078cc:	ffffa097          	auipc	ra,0xffffa
    800078d0:	bf4080e7          	jalr	-1036(ra) # 800014c0 <_Z8sem_waitP5sem_s>

    sem_wait(mutexHead);
    800078d4:	0284b503          	ld	a0,40(s1)
    800078d8:	ffffa097          	auipc	ra,0xffffa
    800078dc:	be8080e7          	jalr	-1048(ra) # 800014c0 <_Z8sem_waitP5sem_s>

    int ret = buffer[head];
    800078e0:	0084b703          	ld	a4,8(s1)
    800078e4:	0104a783          	lw	a5,16(s1)
    800078e8:	00279693          	slli	a3,a5,0x2
    800078ec:	00d70733          	add	a4,a4,a3
    800078f0:	00072903          	lw	s2,0(a4)
    head = (head + 1) % cap;
    800078f4:	0017879b          	addiw	a5,a5,1
    800078f8:	0004a703          	lw	a4,0(s1)
    800078fc:	02e7e7bb          	remw	a5,a5,a4
    80007900:	00f4a823          	sw	a5,16(s1)
    sem_signal(mutexHead);
    80007904:	0284b503          	ld	a0,40(s1)
    80007908:	ffffa097          	auipc	ra,0xffffa
    8000790c:	bf8080e7          	jalr	-1032(ra) # 80001500 <_Z10sem_signalP5sem_s>

    sem_signal(spaceAvailable);
    80007910:	0184b503          	ld	a0,24(s1)
    80007914:	ffffa097          	auipc	ra,0xffffa
    80007918:	bec080e7          	jalr	-1044(ra) # 80001500 <_Z10sem_signalP5sem_s>

    return ret;
}
    8000791c:	00090513          	mv	a0,s2
    80007920:	01813083          	ld	ra,24(sp)
    80007924:	01013403          	ld	s0,16(sp)
    80007928:	00813483          	ld	s1,8(sp)
    8000792c:	00013903          	ld	s2,0(sp)
    80007930:	02010113          	addi	sp,sp,32
    80007934:	00008067          	ret

0000000080007938 <_ZN6Buffer6getCntEv>:

int Buffer::getCnt() {
    80007938:	fe010113          	addi	sp,sp,-32
    8000793c:	00113c23          	sd	ra,24(sp)
    80007940:	00813823          	sd	s0,16(sp)
    80007944:	00913423          	sd	s1,8(sp)
    80007948:	01213023          	sd	s2,0(sp)
    8000794c:	02010413          	addi	s0,sp,32
    80007950:	00050493          	mv	s1,a0
    int ret;

    sem_wait(mutexHead);
    80007954:	02853503          	ld	a0,40(a0)
    80007958:	ffffa097          	auipc	ra,0xffffa
    8000795c:	b68080e7          	jalr	-1176(ra) # 800014c0 <_Z8sem_waitP5sem_s>
    sem_wait(mutexTail);
    80007960:	0304b503          	ld	a0,48(s1)
    80007964:	ffffa097          	auipc	ra,0xffffa
    80007968:	b5c080e7          	jalr	-1188(ra) # 800014c0 <_Z8sem_waitP5sem_s>

    if (tail >= head) {
    8000796c:	0144a783          	lw	a5,20(s1)
    80007970:	0104a903          	lw	s2,16(s1)
    80007974:	0327ce63          	blt	a5,s2,800079b0 <_ZN6Buffer6getCntEv+0x78>
        ret = tail - head;
    80007978:	4127893b          	subw	s2,a5,s2
    } else {
        ret = cap - head + tail;
    }

    sem_signal(mutexTail);
    8000797c:	0304b503          	ld	a0,48(s1)
    80007980:	ffffa097          	auipc	ra,0xffffa
    80007984:	b80080e7          	jalr	-1152(ra) # 80001500 <_Z10sem_signalP5sem_s>
    sem_signal(mutexHead);
    80007988:	0284b503          	ld	a0,40(s1)
    8000798c:	ffffa097          	auipc	ra,0xffffa
    80007990:	b74080e7          	jalr	-1164(ra) # 80001500 <_Z10sem_signalP5sem_s>

    return ret;
}
    80007994:	00090513          	mv	a0,s2
    80007998:	01813083          	ld	ra,24(sp)
    8000799c:	01013403          	ld	s0,16(sp)
    800079a0:	00813483          	ld	s1,8(sp)
    800079a4:	00013903          	ld	s2,0(sp)
    800079a8:	02010113          	addi	sp,sp,32
    800079ac:	00008067          	ret
        ret = cap - head + tail;
    800079b0:	0004a703          	lw	a4,0(s1)
    800079b4:	4127093b          	subw	s2,a4,s2
    800079b8:	00f9093b          	addw	s2,s2,a5
    800079bc:	fc1ff06f          	j	8000797c <_ZN6Buffer6getCntEv+0x44>

00000000800079c0 <_ZN6BufferD1Ev>:
Buffer::~Buffer() {
    800079c0:	fe010113          	addi	sp,sp,-32
    800079c4:	00113c23          	sd	ra,24(sp)
    800079c8:	00813823          	sd	s0,16(sp)
    800079cc:	00913423          	sd	s1,8(sp)
    800079d0:	02010413          	addi	s0,sp,32
    800079d4:	00050493          	mv	s1,a0
    putc('\n');
    800079d8:	00a00513          	li	a0,10
    800079dc:	ffffa097          	auipc	ra,0xffffa
    800079e0:	bd4080e7          	jalr	-1068(ra) # 800015b0 <_Z4putcc>
    printString("Buffer deleted!\n");
    800079e4:	00003517          	auipc	a0,0x3
    800079e8:	bd450513          	addi	a0,a0,-1068 # 8000a5b8 <CONSOLE_STATUS+0x5a8>
    800079ec:	ffffa097          	auipc	ra,0xffffa
    800079f0:	4c0080e7          	jalr	1216(ra) # 80001eac <_Z11printStringPKc>
    while (getCnt() > 0) {
    800079f4:	00048513          	mv	a0,s1
    800079f8:	00000097          	auipc	ra,0x0
    800079fc:	f40080e7          	jalr	-192(ra) # 80007938 <_ZN6Buffer6getCntEv>
    80007a00:	02a05c63          	blez	a0,80007a38 <_ZN6BufferD1Ev+0x78>
        char ch = buffer[head];
    80007a04:	0084b783          	ld	a5,8(s1)
    80007a08:	0104a703          	lw	a4,16(s1)
    80007a0c:	00271713          	slli	a4,a4,0x2
    80007a10:	00e787b3          	add	a5,a5,a4
        putc(ch);
    80007a14:	0007c503          	lbu	a0,0(a5)
    80007a18:	ffffa097          	auipc	ra,0xffffa
    80007a1c:	b98080e7          	jalr	-1128(ra) # 800015b0 <_Z4putcc>
        head = (head + 1) % cap;
    80007a20:	0104a783          	lw	a5,16(s1)
    80007a24:	0017879b          	addiw	a5,a5,1
    80007a28:	0004a703          	lw	a4,0(s1)
    80007a2c:	02e7e7bb          	remw	a5,a5,a4
    80007a30:	00f4a823          	sw	a5,16(s1)
    while (getCnt() > 0) {
    80007a34:	fc1ff06f          	j	800079f4 <_ZN6BufferD1Ev+0x34>
    putc('!');
    80007a38:	02100513          	li	a0,33
    80007a3c:	ffffa097          	auipc	ra,0xffffa
    80007a40:	b74080e7          	jalr	-1164(ra) # 800015b0 <_Z4putcc>
    putc('\n');
    80007a44:	00a00513          	li	a0,10
    80007a48:	ffffa097          	auipc	ra,0xffffa
    80007a4c:	b68080e7          	jalr	-1176(ra) # 800015b0 <_Z4putcc>
    mem_free(buffer);
    80007a50:	0084b503          	ld	a0,8(s1)
    80007a54:	ffffa097          	auipc	ra,0xffffa
    80007a58:	86c080e7          	jalr	-1940(ra) # 800012c0 <_Z8mem_freePv>
    sem_close(itemAvailable);
    80007a5c:	0204b503          	ld	a0,32(s1)
    80007a60:	ffffa097          	auipc	ra,0xffffa
    80007a64:	a20080e7          	jalr	-1504(ra) # 80001480 <_Z9sem_closeP5sem_s>
    sem_close(spaceAvailable);
    80007a68:	0184b503          	ld	a0,24(s1)
    80007a6c:	ffffa097          	auipc	ra,0xffffa
    80007a70:	a14080e7          	jalr	-1516(ra) # 80001480 <_Z9sem_closeP5sem_s>
    sem_close(mutexTail);
    80007a74:	0304b503          	ld	a0,48(s1)
    80007a78:	ffffa097          	auipc	ra,0xffffa
    80007a7c:	a08080e7          	jalr	-1528(ra) # 80001480 <_Z9sem_closeP5sem_s>
    sem_close(mutexHead);
    80007a80:	0284b503          	ld	a0,40(s1)
    80007a84:	ffffa097          	auipc	ra,0xffffa
    80007a88:	9fc080e7          	jalr	-1540(ra) # 80001480 <_Z9sem_closeP5sem_s>
}
    80007a8c:	01813083          	ld	ra,24(sp)
    80007a90:	01013403          	ld	s0,16(sp)
    80007a94:	00813483          	ld	s1,8(sp)
    80007a98:	02010113          	addi	sp,sp,32
    80007a9c:	00008067          	ret

0000000080007aa0 <start>:
    80007aa0:	ff010113          	addi	sp,sp,-16
    80007aa4:	00813423          	sd	s0,8(sp)
    80007aa8:	01010413          	addi	s0,sp,16
    80007aac:	300027f3          	csrr	a5,mstatus
    80007ab0:	ffffe737          	lui	a4,0xffffe
    80007ab4:	7ff70713          	addi	a4,a4,2047 # ffffffffffffe7ff <end+0xffffffff7ffeeacf>
    80007ab8:	00e7f7b3          	and	a5,a5,a4
    80007abc:	00001737          	lui	a4,0x1
    80007ac0:	80070713          	addi	a4,a4,-2048 # 800 <_entry-0x7ffff800>
    80007ac4:	00e7e7b3          	or	a5,a5,a4
    80007ac8:	30079073          	csrw	mstatus,a5
    80007acc:	00000797          	auipc	a5,0x0
    80007ad0:	16078793          	addi	a5,a5,352 # 80007c2c <system_main>
    80007ad4:	34179073          	csrw	mepc,a5
    80007ad8:	00000793          	li	a5,0
    80007adc:	18079073          	csrw	satp,a5
    80007ae0:	000107b7          	lui	a5,0x10
    80007ae4:	fff78793          	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    80007ae8:	30279073          	csrw	medeleg,a5
    80007aec:	30379073          	csrw	mideleg,a5
    80007af0:	104027f3          	csrr	a5,sie
    80007af4:	2227e793          	ori	a5,a5,546
    80007af8:	10479073          	csrw	sie,a5
    80007afc:	fff00793          	li	a5,-1
    80007b00:	00a7d793          	srli	a5,a5,0xa
    80007b04:	3b079073          	csrw	pmpaddr0,a5
    80007b08:	00f00793          	li	a5,15
    80007b0c:	3a079073          	csrw	pmpcfg0,a5
    80007b10:	f14027f3          	csrr	a5,mhartid
    80007b14:	0200c737          	lui	a4,0x200c
    80007b18:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    80007b1c:	0007869b          	sext.w	a3,a5
    80007b20:	00269713          	slli	a4,a3,0x2
    80007b24:	000f4637          	lui	a2,0xf4
    80007b28:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    80007b2c:	00d70733          	add	a4,a4,a3
    80007b30:	0037979b          	slliw	a5,a5,0x3
    80007b34:	020046b7          	lui	a3,0x2004
    80007b38:	00d787b3          	add	a5,a5,a3
    80007b3c:	00c585b3          	add	a1,a1,a2
    80007b40:	00371693          	slli	a3,a4,0x3
    80007b44:	00007717          	auipc	a4,0x7
    80007b48:	f8c70713          	addi	a4,a4,-116 # 8000ead0 <timer_scratch>
    80007b4c:	00b7b023          	sd	a1,0(a5)
    80007b50:	00d70733          	add	a4,a4,a3
    80007b54:	00f73c23          	sd	a5,24(a4)
    80007b58:	02c73023          	sd	a2,32(a4)
    80007b5c:	34071073          	csrw	mscratch,a4
    80007b60:	00000797          	auipc	a5,0x0
    80007b64:	6e078793          	addi	a5,a5,1760 # 80008240 <timervec>
    80007b68:	30579073          	csrw	mtvec,a5
    80007b6c:	300027f3          	csrr	a5,mstatus
    80007b70:	0087e793          	ori	a5,a5,8
    80007b74:	30079073          	csrw	mstatus,a5
    80007b78:	304027f3          	csrr	a5,mie
    80007b7c:	0807e793          	ori	a5,a5,128
    80007b80:	30479073          	csrw	mie,a5
    80007b84:	f14027f3          	csrr	a5,mhartid
    80007b88:	0007879b          	sext.w	a5,a5
    80007b8c:	00078213          	mv	tp,a5
    80007b90:	30200073          	mret
    80007b94:	00813403          	ld	s0,8(sp)
    80007b98:	01010113          	addi	sp,sp,16
    80007b9c:	00008067          	ret

0000000080007ba0 <timerinit>:
    80007ba0:	ff010113          	addi	sp,sp,-16
    80007ba4:	00813423          	sd	s0,8(sp)
    80007ba8:	01010413          	addi	s0,sp,16
    80007bac:	f14027f3          	csrr	a5,mhartid
    80007bb0:	0200c737          	lui	a4,0x200c
    80007bb4:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    80007bb8:	0007869b          	sext.w	a3,a5
    80007bbc:	00269713          	slli	a4,a3,0x2
    80007bc0:	000f4637          	lui	a2,0xf4
    80007bc4:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    80007bc8:	00d70733          	add	a4,a4,a3
    80007bcc:	0037979b          	slliw	a5,a5,0x3
    80007bd0:	020046b7          	lui	a3,0x2004
    80007bd4:	00d787b3          	add	a5,a5,a3
    80007bd8:	00c585b3          	add	a1,a1,a2
    80007bdc:	00371693          	slli	a3,a4,0x3
    80007be0:	00007717          	auipc	a4,0x7
    80007be4:	ef070713          	addi	a4,a4,-272 # 8000ead0 <timer_scratch>
    80007be8:	00b7b023          	sd	a1,0(a5)
    80007bec:	00d70733          	add	a4,a4,a3
    80007bf0:	00f73c23          	sd	a5,24(a4)
    80007bf4:	02c73023          	sd	a2,32(a4)
    80007bf8:	34071073          	csrw	mscratch,a4
    80007bfc:	00000797          	auipc	a5,0x0
    80007c00:	64478793          	addi	a5,a5,1604 # 80008240 <timervec>
    80007c04:	30579073          	csrw	mtvec,a5
    80007c08:	300027f3          	csrr	a5,mstatus
    80007c0c:	0087e793          	ori	a5,a5,8
    80007c10:	30079073          	csrw	mstatus,a5
    80007c14:	304027f3          	csrr	a5,mie
    80007c18:	0807e793          	ori	a5,a5,128
    80007c1c:	30479073          	csrw	mie,a5
    80007c20:	00813403          	ld	s0,8(sp)
    80007c24:	01010113          	addi	sp,sp,16
    80007c28:	00008067          	ret

0000000080007c2c <system_main>:
    80007c2c:	fe010113          	addi	sp,sp,-32
    80007c30:	00813823          	sd	s0,16(sp)
    80007c34:	00913423          	sd	s1,8(sp)
    80007c38:	00113c23          	sd	ra,24(sp)
    80007c3c:	02010413          	addi	s0,sp,32
    80007c40:	00000097          	auipc	ra,0x0
    80007c44:	0c4080e7          	jalr	196(ra) # 80007d04 <cpuid>
    80007c48:	00005497          	auipc	s1,0x5
    80007c4c:	0d848493          	addi	s1,s1,216 # 8000cd20 <started>
    80007c50:	02050263          	beqz	a0,80007c74 <system_main+0x48>
    80007c54:	0004a783          	lw	a5,0(s1)
    80007c58:	0007879b          	sext.w	a5,a5
    80007c5c:	fe078ce3          	beqz	a5,80007c54 <system_main+0x28>
    80007c60:	0ff0000f          	fence
    80007c64:	00003517          	auipc	a0,0x3
    80007c68:	c2450513          	addi	a0,a0,-988 # 8000a888 <CONSOLE_STATUS+0x878>
    80007c6c:	00001097          	auipc	ra,0x1
    80007c70:	a70080e7          	jalr	-1424(ra) # 800086dc <panic>
    80007c74:	00001097          	auipc	ra,0x1
    80007c78:	9c4080e7          	jalr	-1596(ra) # 80008638 <consoleinit>
    80007c7c:	00001097          	auipc	ra,0x1
    80007c80:	150080e7          	jalr	336(ra) # 80008dcc <printfinit>
    80007c84:	00003517          	auipc	a0,0x3
    80007c88:	a8c50513          	addi	a0,a0,-1396 # 8000a710 <CONSOLE_STATUS+0x700>
    80007c8c:	00001097          	auipc	ra,0x1
    80007c90:	aac080e7          	jalr	-1364(ra) # 80008738 <__printf>
    80007c94:	00003517          	auipc	a0,0x3
    80007c98:	bc450513          	addi	a0,a0,-1084 # 8000a858 <CONSOLE_STATUS+0x848>
    80007c9c:	00001097          	auipc	ra,0x1
    80007ca0:	a9c080e7          	jalr	-1380(ra) # 80008738 <__printf>
    80007ca4:	00003517          	auipc	a0,0x3
    80007ca8:	a6c50513          	addi	a0,a0,-1428 # 8000a710 <CONSOLE_STATUS+0x700>
    80007cac:	00001097          	auipc	ra,0x1
    80007cb0:	a8c080e7          	jalr	-1396(ra) # 80008738 <__printf>
    80007cb4:	00001097          	auipc	ra,0x1
    80007cb8:	4a4080e7          	jalr	1188(ra) # 80009158 <kinit>
    80007cbc:	00000097          	auipc	ra,0x0
    80007cc0:	148080e7          	jalr	328(ra) # 80007e04 <trapinit>
    80007cc4:	00000097          	auipc	ra,0x0
    80007cc8:	16c080e7          	jalr	364(ra) # 80007e30 <trapinithart>
    80007ccc:	00000097          	auipc	ra,0x0
    80007cd0:	5b4080e7          	jalr	1460(ra) # 80008280 <plicinit>
    80007cd4:	00000097          	auipc	ra,0x0
    80007cd8:	5d4080e7          	jalr	1492(ra) # 800082a8 <plicinithart>
    80007cdc:	00000097          	auipc	ra,0x0
    80007ce0:	078080e7          	jalr	120(ra) # 80007d54 <userinit>
    80007ce4:	0ff0000f          	fence
    80007ce8:	00100793          	li	a5,1
    80007cec:	00003517          	auipc	a0,0x3
    80007cf0:	b8450513          	addi	a0,a0,-1148 # 8000a870 <CONSOLE_STATUS+0x860>
    80007cf4:	00f4a023          	sw	a5,0(s1)
    80007cf8:	00001097          	auipc	ra,0x1
    80007cfc:	a40080e7          	jalr	-1472(ra) # 80008738 <__printf>
    80007d00:	0000006f          	j	80007d00 <system_main+0xd4>

0000000080007d04 <cpuid>:
    80007d04:	ff010113          	addi	sp,sp,-16
    80007d08:	00813423          	sd	s0,8(sp)
    80007d0c:	01010413          	addi	s0,sp,16
    80007d10:	00020513          	mv	a0,tp
    80007d14:	00813403          	ld	s0,8(sp)
    80007d18:	0005051b          	sext.w	a0,a0
    80007d1c:	01010113          	addi	sp,sp,16
    80007d20:	00008067          	ret

0000000080007d24 <mycpu>:
    80007d24:	ff010113          	addi	sp,sp,-16
    80007d28:	00813423          	sd	s0,8(sp)
    80007d2c:	01010413          	addi	s0,sp,16
    80007d30:	00020793          	mv	a5,tp
    80007d34:	00813403          	ld	s0,8(sp)
    80007d38:	0007879b          	sext.w	a5,a5
    80007d3c:	00779793          	slli	a5,a5,0x7
    80007d40:	00008517          	auipc	a0,0x8
    80007d44:	dc050513          	addi	a0,a0,-576 # 8000fb00 <cpus>
    80007d48:	00f50533          	add	a0,a0,a5
    80007d4c:	01010113          	addi	sp,sp,16
    80007d50:	00008067          	ret

0000000080007d54 <userinit>:
    80007d54:	ff010113          	addi	sp,sp,-16
    80007d58:	00813423          	sd	s0,8(sp)
    80007d5c:	01010413          	addi	s0,sp,16
    80007d60:	00813403          	ld	s0,8(sp)
    80007d64:	01010113          	addi	sp,sp,16
    80007d68:	ffffb317          	auipc	t1,0xffffb
    80007d6c:	cc430067          	jr	-828(t1) # 80002a2c <main>

0000000080007d70 <either_copyout>:
    80007d70:	ff010113          	addi	sp,sp,-16
    80007d74:	00813023          	sd	s0,0(sp)
    80007d78:	00113423          	sd	ra,8(sp)
    80007d7c:	01010413          	addi	s0,sp,16
    80007d80:	02051663          	bnez	a0,80007dac <either_copyout+0x3c>
    80007d84:	00058513          	mv	a0,a1
    80007d88:	00060593          	mv	a1,a2
    80007d8c:	0006861b          	sext.w	a2,a3
    80007d90:	00002097          	auipc	ra,0x2
    80007d94:	c54080e7          	jalr	-940(ra) # 800099e4 <__memmove>
    80007d98:	00813083          	ld	ra,8(sp)
    80007d9c:	00013403          	ld	s0,0(sp)
    80007da0:	00000513          	li	a0,0
    80007da4:	01010113          	addi	sp,sp,16
    80007da8:	00008067          	ret
    80007dac:	00003517          	auipc	a0,0x3
    80007db0:	b0450513          	addi	a0,a0,-1276 # 8000a8b0 <CONSOLE_STATUS+0x8a0>
    80007db4:	00001097          	auipc	ra,0x1
    80007db8:	928080e7          	jalr	-1752(ra) # 800086dc <panic>

0000000080007dbc <either_copyin>:
    80007dbc:	ff010113          	addi	sp,sp,-16
    80007dc0:	00813023          	sd	s0,0(sp)
    80007dc4:	00113423          	sd	ra,8(sp)
    80007dc8:	01010413          	addi	s0,sp,16
    80007dcc:	02059463          	bnez	a1,80007df4 <either_copyin+0x38>
    80007dd0:	00060593          	mv	a1,a2
    80007dd4:	0006861b          	sext.w	a2,a3
    80007dd8:	00002097          	auipc	ra,0x2
    80007ddc:	c0c080e7          	jalr	-1012(ra) # 800099e4 <__memmove>
    80007de0:	00813083          	ld	ra,8(sp)
    80007de4:	00013403          	ld	s0,0(sp)
    80007de8:	00000513          	li	a0,0
    80007dec:	01010113          	addi	sp,sp,16
    80007df0:	00008067          	ret
    80007df4:	00003517          	auipc	a0,0x3
    80007df8:	ae450513          	addi	a0,a0,-1308 # 8000a8d8 <CONSOLE_STATUS+0x8c8>
    80007dfc:	00001097          	auipc	ra,0x1
    80007e00:	8e0080e7          	jalr	-1824(ra) # 800086dc <panic>

0000000080007e04 <trapinit>:
    80007e04:	ff010113          	addi	sp,sp,-16
    80007e08:	00813423          	sd	s0,8(sp)
    80007e0c:	01010413          	addi	s0,sp,16
    80007e10:	00813403          	ld	s0,8(sp)
    80007e14:	00003597          	auipc	a1,0x3
    80007e18:	aec58593          	addi	a1,a1,-1300 # 8000a900 <CONSOLE_STATUS+0x8f0>
    80007e1c:	00008517          	auipc	a0,0x8
    80007e20:	d6450513          	addi	a0,a0,-668 # 8000fb80 <tickslock>
    80007e24:	01010113          	addi	sp,sp,16
    80007e28:	00001317          	auipc	t1,0x1
    80007e2c:	5c030067          	jr	1472(t1) # 800093e8 <initlock>

0000000080007e30 <trapinithart>:
    80007e30:	ff010113          	addi	sp,sp,-16
    80007e34:	00813423          	sd	s0,8(sp)
    80007e38:	01010413          	addi	s0,sp,16
    80007e3c:	00000797          	auipc	a5,0x0
    80007e40:	2f478793          	addi	a5,a5,756 # 80008130 <kernelvec>
    80007e44:	10579073          	csrw	stvec,a5
    80007e48:	00813403          	ld	s0,8(sp)
    80007e4c:	01010113          	addi	sp,sp,16
    80007e50:	00008067          	ret

0000000080007e54 <usertrap>:
    80007e54:	ff010113          	addi	sp,sp,-16
    80007e58:	00813423          	sd	s0,8(sp)
    80007e5c:	01010413          	addi	s0,sp,16
    80007e60:	00813403          	ld	s0,8(sp)
    80007e64:	01010113          	addi	sp,sp,16
    80007e68:	00008067          	ret

0000000080007e6c <usertrapret>:
    80007e6c:	ff010113          	addi	sp,sp,-16
    80007e70:	00813423          	sd	s0,8(sp)
    80007e74:	01010413          	addi	s0,sp,16
    80007e78:	00813403          	ld	s0,8(sp)
    80007e7c:	01010113          	addi	sp,sp,16
    80007e80:	00008067          	ret

0000000080007e84 <kerneltrap>:
    80007e84:	fe010113          	addi	sp,sp,-32
    80007e88:	00813823          	sd	s0,16(sp)
    80007e8c:	00113c23          	sd	ra,24(sp)
    80007e90:	00913423          	sd	s1,8(sp)
    80007e94:	02010413          	addi	s0,sp,32
    80007e98:	142025f3          	csrr	a1,scause
    80007e9c:	100027f3          	csrr	a5,sstatus
    80007ea0:	0027f793          	andi	a5,a5,2
    80007ea4:	10079c63          	bnez	a5,80007fbc <kerneltrap+0x138>
    80007ea8:	142027f3          	csrr	a5,scause
    80007eac:	0207ce63          	bltz	a5,80007ee8 <kerneltrap+0x64>
    80007eb0:	00003517          	auipc	a0,0x3
    80007eb4:	a9850513          	addi	a0,a0,-1384 # 8000a948 <CONSOLE_STATUS+0x938>
    80007eb8:	00001097          	auipc	ra,0x1
    80007ebc:	880080e7          	jalr	-1920(ra) # 80008738 <__printf>
    80007ec0:	141025f3          	csrr	a1,sepc
    80007ec4:	14302673          	csrr	a2,stval
    80007ec8:	00003517          	auipc	a0,0x3
    80007ecc:	a9050513          	addi	a0,a0,-1392 # 8000a958 <CONSOLE_STATUS+0x948>
    80007ed0:	00001097          	auipc	ra,0x1
    80007ed4:	868080e7          	jalr	-1944(ra) # 80008738 <__printf>
    80007ed8:	00003517          	auipc	a0,0x3
    80007edc:	a9850513          	addi	a0,a0,-1384 # 8000a970 <CONSOLE_STATUS+0x960>
    80007ee0:	00000097          	auipc	ra,0x0
    80007ee4:	7fc080e7          	jalr	2044(ra) # 800086dc <panic>
    80007ee8:	0ff7f713          	andi	a4,a5,255
    80007eec:	00900693          	li	a3,9
    80007ef0:	04d70063          	beq	a4,a3,80007f30 <kerneltrap+0xac>
    80007ef4:	fff00713          	li	a4,-1
    80007ef8:	03f71713          	slli	a4,a4,0x3f
    80007efc:	00170713          	addi	a4,a4,1
    80007f00:	fae798e3          	bne	a5,a4,80007eb0 <kerneltrap+0x2c>
    80007f04:	00000097          	auipc	ra,0x0
    80007f08:	e00080e7          	jalr	-512(ra) # 80007d04 <cpuid>
    80007f0c:	06050663          	beqz	a0,80007f78 <kerneltrap+0xf4>
    80007f10:	144027f3          	csrr	a5,sip
    80007f14:	ffd7f793          	andi	a5,a5,-3
    80007f18:	14479073          	csrw	sip,a5
    80007f1c:	01813083          	ld	ra,24(sp)
    80007f20:	01013403          	ld	s0,16(sp)
    80007f24:	00813483          	ld	s1,8(sp)
    80007f28:	02010113          	addi	sp,sp,32
    80007f2c:	00008067          	ret
    80007f30:	00000097          	auipc	ra,0x0
    80007f34:	3c4080e7          	jalr	964(ra) # 800082f4 <plic_claim>
    80007f38:	00a00793          	li	a5,10
    80007f3c:	00050493          	mv	s1,a0
    80007f40:	06f50863          	beq	a0,a5,80007fb0 <kerneltrap+0x12c>
    80007f44:	fc050ce3          	beqz	a0,80007f1c <kerneltrap+0x98>
    80007f48:	00050593          	mv	a1,a0
    80007f4c:	00003517          	auipc	a0,0x3
    80007f50:	9dc50513          	addi	a0,a0,-1572 # 8000a928 <CONSOLE_STATUS+0x918>
    80007f54:	00000097          	auipc	ra,0x0
    80007f58:	7e4080e7          	jalr	2020(ra) # 80008738 <__printf>
    80007f5c:	01013403          	ld	s0,16(sp)
    80007f60:	01813083          	ld	ra,24(sp)
    80007f64:	00048513          	mv	a0,s1
    80007f68:	00813483          	ld	s1,8(sp)
    80007f6c:	02010113          	addi	sp,sp,32
    80007f70:	00000317          	auipc	t1,0x0
    80007f74:	3bc30067          	jr	956(t1) # 8000832c <plic_complete>
    80007f78:	00008517          	auipc	a0,0x8
    80007f7c:	c0850513          	addi	a0,a0,-1016 # 8000fb80 <tickslock>
    80007f80:	00001097          	auipc	ra,0x1
    80007f84:	48c080e7          	jalr	1164(ra) # 8000940c <acquire>
    80007f88:	00005717          	auipc	a4,0x5
    80007f8c:	d9c70713          	addi	a4,a4,-612 # 8000cd24 <ticks>
    80007f90:	00072783          	lw	a5,0(a4)
    80007f94:	00008517          	auipc	a0,0x8
    80007f98:	bec50513          	addi	a0,a0,-1044 # 8000fb80 <tickslock>
    80007f9c:	0017879b          	addiw	a5,a5,1
    80007fa0:	00f72023          	sw	a5,0(a4)
    80007fa4:	00001097          	auipc	ra,0x1
    80007fa8:	534080e7          	jalr	1332(ra) # 800094d8 <release>
    80007fac:	f65ff06f          	j	80007f10 <kerneltrap+0x8c>
    80007fb0:	00001097          	auipc	ra,0x1
    80007fb4:	090080e7          	jalr	144(ra) # 80009040 <uartintr>
    80007fb8:	fa5ff06f          	j	80007f5c <kerneltrap+0xd8>
    80007fbc:	00003517          	auipc	a0,0x3
    80007fc0:	94c50513          	addi	a0,a0,-1716 # 8000a908 <CONSOLE_STATUS+0x8f8>
    80007fc4:	00000097          	auipc	ra,0x0
    80007fc8:	718080e7          	jalr	1816(ra) # 800086dc <panic>

0000000080007fcc <clockintr>:
    80007fcc:	fe010113          	addi	sp,sp,-32
    80007fd0:	00813823          	sd	s0,16(sp)
    80007fd4:	00913423          	sd	s1,8(sp)
    80007fd8:	00113c23          	sd	ra,24(sp)
    80007fdc:	02010413          	addi	s0,sp,32
    80007fe0:	00008497          	auipc	s1,0x8
    80007fe4:	ba048493          	addi	s1,s1,-1120 # 8000fb80 <tickslock>
    80007fe8:	00048513          	mv	a0,s1
    80007fec:	00001097          	auipc	ra,0x1
    80007ff0:	420080e7          	jalr	1056(ra) # 8000940c <acquire>
    80007ff4:	00005717          	auipc	a4,0x5
    80007ff8:	d3070713          	addi	a4,a4,-720 # 8000cd24 <ticks>
    80007ffc:	00072783          	lw	a5,0(a4)
    80008000:	01013403          	ld	s0,16(sp)
    80008004:	01813083          	ld	ra,24(sp)
    80008008:	00048513          	mv	a0,s1
    8000800c:	0017879b          	addiw	a5,a5,1
    80008010:	00813483          	ld	s1,8(sp)
    80008014:	00f72023          	sw	a5,0(a4)
    80008018:	02010113          	addi	sp,sp,32
    8000801c:	00001317          	auipc	t1,0x1
    80008020:	4bc30067          	jr	1212(t1) # 800094d8 <release>

0000000080008024 <devintr>:
    80008024:	142027f3          	csrr	a5,scause
    80008028:	00000513          	li	a0,0
    8000802c:	0007c463          	bltz	a5,80008034 <devintr+0x10>
    80008030:	00008067          	ret
    80008034:	fe010113          	addi	sp,sp,-32
    80008038:	00813823          	sd	s0,16(sp)
    8000803c:	00113c23          	sd	ra,24(sp)
    80008040:	00913423          	sd	s1,8(sp)
    80008044:	02010413          	addi	s0,sp,32
    80008048:	0ff7f713          	andi	a4,a5,255
    8000804c:	00900693          	li	a3,9
    80008050:	04d70c63          	beq	a4,a3,800080a8 <devintr+0x84>
    80008054:	fff00713          	li	a4,-1
    80008058:	03f71713          	slli	a4,a4,0x3f
    8000805c:	00170713          	addi	a4,a4,1
    80008060:	00e78c63          	beq	a5,a4,80008078 <devintr+0x54>
    80008064:	01813083          	ld	ra,24(sp)
    80008068:	01013403          	ld	s0,16(sp)
    8000806c:	00813483          	ld	s1,8(sp)
    80008070:	02010113          	addi	sp,sp,32
    80008074:	00008067          	ret
    80008078:	00000097          	auipc	ra,0x0
    8000807c:	c8c080e7          	jalr	-884(ra) # 80007d04 <cpuid>
    80008080:	06050663          	beqz	a0,800080ec <devintr+0xc8>
    80008084:	144027f3          	csrr	a5,sip
    80008088:	ffd7f793          	andi	a5,a5,-3
    8000808c:	14479073          	csrw	sip,a5
    80008090:	01813083          	ld	ra,24(sp)
    80008094:	01013403          	ld	s0,16(sp)
    80008098:	00813483          	ld	s1,8(sp)
    8000809c:	00200513          	li	a0,2
    800080a0:	02010113          	addi	sp,sp,32
    800080a4:	00008067          	ret
    800080a8:	00000097          	auipc	ra,0x0
    800080ac:	24c080e7          	jalr	588(ra) # 800082f4 <plic_claim>
    800080b0:	00a00793          	li	a5,10
    800080b4:	00050493          	mv	s1,a0
    800080b8:	06f50663          	beq	a0,a5,80008124 <devintr+0x100>
    800080bc:	00100513          	li	a0,1
    800080c0:	fa0482e3          	beqz	s1,80008064 <devintr+0x40>
    800080c4:	00048593          	mv	a1,s1
    800080c8:	00003517          	auipc	a0,0x3
    800080cc:	86050513          	addi	a0,a0,-1952 # 8000a928 <CONSOLE_STATUS+0x918>
    800080d0:	00000097          	auipc	ra,0x0
    800080d4:	668080e7          	jalr	1640(ra) # 80008738 <__printf>
    800080d8:	00048513          	mv	a0,s1
    800080dc:	00000097          	auipc	ra,0x0
    800080e0:	250080e7          	jalr	592(ra) # 8000832c <plic_complete>
    800080e4:	00100513          	li	a0,1
    800080e8:	f7dff06f          	j	80008064 <devintr+0x40>
    800080ec:	00008517          	auipc	a0,0x8
    800080f0:	a9450513          	addi	a0,a0,-1388 # 8000fb80 <tickslock>
    800080f4:	00001097          	auipc	ra,0x1
    800080f8:	318080e7          	jalr	792(ra) # 8000940c <acquire>
    800080fc:	00005717          	auipc	a4,0x5
    80008100:	c2870713          	addi	a4,a4,-984 # 8000cd24 <ticks>
    80008104:	00072783          	lw	a5,0(a4)
    80008108:	00008517          	auipc	a0,0x8
    8000810c:	a7850513          	addi	a0,a0,-1416 # 8000fb80 <tickslock>
    80008110:	0017879b          	addiw	a5,a5,1
    80008114:	00f72023          	sw	a5,0(a4)
    80008118:	00001097          	auipc	ra,0x1
    8000811c:	3c0080e7          	jalr	960(ra) # 800094d8 <release>
    80008120:	f65ff06f          	j	80008084 <devintr+0x60>
    80008124:	00001097          	auipc	ra,0x1
    80008128:	f1c080e7          	jalr	-228(ra) # 80009040 <uartintr>
    8000812c:	fadff06f          	j	800080d8 <devintr+0xb4>

0000000080008130 <kernelvec>:
    80008130:	f0010113          	addi	sp,sp,-256
    80008134:	00113023          	sd	ra,0(sp)
    80008138:	00213423          	sd	sp,8(sp)
    8000813c:	00313823          	sd	gp,16(sp)
    80008140:	00413c23          	sd	tp,24(sp)
    80008144:	02513023          	sd	t0,32(sp)
    80008148:	02613423          	sd	t1,40(sp)
    8000814c:	02713823          	sd	t2,48(sp)
    80008150:	02813c23          	sd	s0,56(sp)
    80008154:	04913023          	sd	s1,64(sp)
    80008158:	04a13423          	sd	a0,72(sp)
    8000815c:	04b13823          	sd	a1,80(sp)
    80008160:	04c13c23          	sd	a2,88(sp)
    80008164:	06d13023          	sd	a3,96(sp)
    80008168:	06e13423          	sd	a4,104(sp)
    8000816c:	06f13823          	sd	a5,112(sp)
    80008170:	07013c23          	sd	a6,120(sp)
    80008174:	09113023          	sd	a7,128(sp)
    80008178:	09213423          	sd	s2,136(sp)
    8000817c:	09313823          	sd	s3,144(sp)
    80008180:	09413c23          	sd	s4,152(sp)
    80008184:	0b513023          	sd	s5,160(sp)
    80008188:	0b613423          	sd	s6,168(sp)
    8000818c:	0b713823          	sd	s7,176(sp)
    80008190:	0b813c23          	sd	s8,184(sp)
    80008194:	0d913023          	sd	s9,192(sp)
    80008198:	0da13423          	sd	s10,200(sp)
    8000819c:	0db13823          	sd	s11,208(sp)
    800081a0:	0dc13c23          	sd	t3,216(sp)
    800081a4:	0fd13023          	sd	t4,224(sp)
    800081a8:	0fe13423          	sd	t5,232(sp)
    800081ac:	0ff13823          	sd	t6,240(sp)
    800081b0:	cd5ff0ef          	jal	ra,80007e84 <kerneltrap>
    800081b4:	00013083          	ld	ra,0(sp)
    800081b8:	00813103          	ld	sp,8(sp)
    800081bc:	01013183          	ld	gp,16(sp)
    800081c0:	02013283          	ld	t0,32(sp)
    800081c4:	02813303          	ld	t1,40(sp)
    800081c8:	03013383          	ld	t2,48(sp)
    800081cc:	03813403          	ld	s0,56(sp)
    800081d0:	04013483          	ld	s1,64(sp)
    800081d4:	04813503          	ld	a0,72(sp)
    800081d8:	05013583          	ld	a1,80(sp)
    800081dc:	05813603          	ld	a2,88(sp)
    800081e0:	06013683          	ld	a3,96(sp)
    800081e4:	06813703          	ld	a4,104(sp)
    800081e8:	07013783          	ld	a5,112(sp)
    800081ec:	07813803          	ld	a6,120(sp)
    800081f0:	08013883          	ld	a7,128(sp)
    800081f4:	08813903          	ld	s2,136(sp)
    800081f8:	09013983          	ld	s3,144(sp)
    800081fc:	09813a03          	ld	s4,152(sp)
    80008200:	0a013a83          	ld	s5,160(sp)
    80008204:	0a813b03          	ld	s6,168(sp)
    80008208:	0b013b83          	ld	s7,176(sp)
    8000820c:	0b813c03          	ld	s8,184(sp)
    80008210:	0c013c83          	ld	s9,192(sp)
    80008214:	0c813d03          	ld	s10,200(sp)
    80008218:	0d013d83          	ld	s11,208(sp)
    8000821c:	0d813e03          	ld	t3,216(sp)
    80008220:	0e013e83          	ld	t4,224(sp)
    80008224:	0e813f03          	ld	t5,232(sp)
    80008228:	0f013f83          	ld	t6,240(sp)
    8000822c:	10010113          	addi	sp,sp,256
    80008230:	10200073          	sret
    80008234:	00000013          	nop
    80008238:	00000013          	nop
    8000823c:	00000013          	nop

0000000080008240 <timervec>:
    80008240:	34051573          	csrrw	a0,mscratch,a0
    80008244:	00b53023          	sd	a1,0(a0)
    80008248:	00c53423          	sd	a2,8(a0)
    8000824c:	00d53823          	sd	a3,16(a0)
    80008250:	01853583          	ld	a1,24(a0)
    80008254:	02053603          	ld	a2,32(a0)
    80008258:	0005b683          	ld	a3,0(a1)
    8000825c:	00c686b3          	add	a3,a3,a2
    80008260:	00d5b023          	sd	a3,0(a1)
    80008264:	00200593          	li	a1,2
    80008268:	14459073          	csrw	sip,a1
    8000826c:	01053683          	ld	a3,16(a0)
    80008270:	00853603          	ld	a2,8(a0)
    80008274:	00053583          	ld	a1,0(a0)
    80008278:	34051573          	csrrw	a0,mscratch,a0
    8000827c:	30200073          	mret

0000000080008280 <plicinit>:
    80008280:	ff010113          	addi	sp,sp,-16
    80008284:	00813423          	sd	s0,8(sp)
    80008288:	01010413          	addi	s0,sp,16
    8000828c:	00813403          	ld	s0,8(sp)
    80008290:	0c0007b7          	lui	a5,0xc000
    80008294:	00100713          	li	a4,1
    80008298:	02e7a423          	sw	a4,40(a5) # c000028 <_entry-0x73ffffd8>
    8000829c:	00e7a223          	sw	a4,4(a5)
    800082a0:	01010113          	addi	sp,sp,16
    800082a4:	00008067          	ret

00000000800082a8 <plicinithart>:
    800082a8:	ff010113          	addi	sp,sp,-16
    800082ac:	00813023          	sd	s0,0(sp)
    800082b0:	00113423          	sd	ra,8(sp)
    800082b4:	01010413          	addi	s0,sp,16
    800082b8:	00000097          	auipc	ra,0x0
    800082bc:	a4c080e7          	jalr	-1460(ra) # 80007d04 <cpuid>
    800082c0:	0085171b          	slliw	a4,a0,0x8
    800082c4:	0c0027b7          	lui	a5,0xc002
    800082c8:	00e787b3          	add	a5,a5,a4
    800082cc:	40200713          	li	a4,1026
    800082d0:	08e7a023          	sw	a4,128(a5) # c002080 <_entry-0x73ffdf80>
    800082d4:	00813083          	ld	ra,8(sp)
    800082d8:	00013403          	ld	s0,0(sp)
    800082dc:	00d5151b          	slliw	a0,a0,0xd
    800082e0:	0c2017b7          	lui	a5,0xc201
    800082e4:	00a78533          	add	a0,a5,a0
    800082e8:	00052023          	sw	zero,0(a0)
    800082ec:	01010113          	addi	sp,sp,16
    800082f0:	00008067          	ret

00000000800082f4 <plic_claim>:
    800082f4:	ff010113          	addi	sp,sp,-16
    800082f8:	00813023          	sd	s0,0(sp)
    800082fc:	00113423          	sd	ra,8(sp)
    80008300:	01010413          	addi	s0,sp,16
    80008304:	00000097          	auipc	ra,0x0
    80008308:	a00080e7          	jalr	-1536(ra) # 80007d04 <cpuid>
    8000830c:	00813083          	ld	ra,8(sp)
    80008310:	00013403          	ld	s0,0(sp)
    80008314:	00d5151b          	slliw	a0,a0,0xd
    80008318:	0c2017b7          	lui	a5,0xc201
    8000831c:	00a78533          	add	a0,a5,a0
    80008320:	00452503          	lw	a0,4(a0)
    80008324:	01010113          	addi	sp,sp,16
    80008328:	00008067          	ret

000000008000832c <plic_complete>:
    8000832c:	fe010113          	addi	sp,sp,-32
    80008330:	00813823          	sd	s0,16(sp)
    80008334:	00913423          	sd	s1,8(sp)
    80008338:	00113c23          	sd	ra,24(sp)
    8000833c:	02010413          	addi	s0,sp,32
    80008340:	00050493          	mv	s1,a0
    80008344:	00000097          	auipc	ra,0x0
    80008348:	9c0080e7          	jalr	-1600(ra) # 80007d04 <cpuid>
    8000834c:	01813083          	ld	ra,24(sp)
    80008350:	01013403          	ld	s0,16(sp)
    80008354:	00d5179b          	slliw	a5,a0,0xd
    80008358:	0c201737          	lui	a4,0xc201
    8000835c:	00f707b3          	add	a5,a4,a5
    80008360:	0097a223          	sw	s1,4(a5) # c201004 <_entry-0x73dfeffc>
    80008364:	00813483          	ld	s1,8(sp)
    80008368:	02010113          	addi	sp,sp,32
    8000836c:	00008067          	ret

0000000080008370 <consolewrite>:
    80008370:	fb010113          	addi	sp,sp,-80
    80008374:	04813023          	sd	s0,64(sp)
    80008378:	04113423          	sd	ra,72(sp)
    8000837c:	02913c23          	sd	s1,56(sp)
    80008380:	03213823          	sd	s2,48(sp)
    80008384:	03313423          	sd	s3,40(sp)
    80008388:	03413023          	sd	s4,32(sp)
    8000838c:	01513c23          	sd	s5,24(sp)
    80008390:	05010413          	addi	s0,sp,80
    80008394:	06c05c63          	blez	a2,8000840c <consolewrite+0x9c>
    80008398:	00060993          	mv	s3,a2
    8000839c:	00050a13          	mv	s4,a0
    800083a0:	00058493          	mv	s1,a1
    800083a4:	00000913          	li	s2,0
    800083a8:	fff00a93          	li	s5,-1
    800083ac:	01c0006f          	j	800083c8 <consolewrite+0x58>
    800083b0:	fbf44503          	lbu	a0,-65(s0)
    800083b4:	0019091b          	addiw	s2,s2,1
    800083b8:	00148493          	addi	s1,s1,1
    800083bc:	00001097          	auipc	ra,0x1
    800083c0:	a9c080e7          	jalr	-1380(ra) # 80008e58 <uartputc>
    800083c4:	03298063          	beq	s3,s2,800083e4 <consolewrite+0x74>
    800083c8:	00048613          	mv	a2,s1
    800083cc:	00100693          	li	a3,1
    800083d0:	000a0593          	mv	a1,s4
    800083d4:	fbf40513          	addi	a0,s0,-65
    800083d8:	00000097          	auipc	ra,0x0
    800083dc:	9e4080e7          	jalr	-1564(ra) # 80007dbc <either_copyin>
    800083e0:	fd5518e3          	bne	a0,s5,800083b0 <consolewrite+0x40>
    800083e4:	04813083          	ld	ra,72(sp)
    800083e8:	04013403          	ld	s0,64(sp)
    800083ec:	03813483          	ld	s1,56(sp)
    800083f0:	02813983          	ld	s3,40(sp)
    800083f4:	02013a03          	ld	s4,32(sp)
    800083f8:	01813a83          	ld	s5,24(sp)
    800083fc:	00090513          	mv	a0,s2
    80008400:	03013903          	ld	s2,48(sp)
    80008404:	05010113          	addi	sp,sp,80
    80008408:	00008067          	ret
    8000840c:	00000913          	li	s2,0
    80008410:	fd5ff06f          	j	800083e4 <consolewrite+0x74>

0000000080008414 <consoleread>:
    80008414:	f9010113          	addi	sp,sp,-112
    80008418:	06813023          	sd	s0,96(sp)
    8000841c:	04913c23          	sd	s1,88(sp)
    80008420:	05213823          	sd	s2,80(sp)
    80008424:	05313423          	sd	s3,72(sp)
    80008428:	05413023          	sd	s4,64(sp)
    8000842c:	03513c23          	sd	s5,56(sp)
    80008430:	03613823          	sd	s6,48(sp)
    80008434:	03713423          	sd	s7,40(sp)
    80008438:	03813023          	sd	s8,32(sp)
    8000843c:	06113423          	sd	ra,104(sp)
    80008440:	01913c23          	sd	s9,24(sp)
    80008444:	07010413          	addi	s0,sp,112
    80008448:	00060b93          	mv	s7,a2
    8000844c:	00050913          	mv	s2,a0
    80008450:	00058c13          	mv	s8,a1
    80008454:	00060b1b          	sext.w	s6,a2
    80008458:	00007497          	auipc	s1,0x7
    8000845c:	75048493          	addi	s1,s1,1872 # 8000fba8 <cons>
    80008460:	00400993          	li	s3,4
    80008464:	fff00a13          	li	s4,-1
    80008468:	00a00a93          	li	s5,10
    8000846c:	05705e63          	blez	s7,800084c8 <consoleread+0xb4>
    80008470:	09c4a703          	lw	a4,156(s1)
    80008474:	0984a783          	lw	a5,152(s1)
    80008478:	0007071b          	sext.w	a4,a4
    8000847c:	08e78463          	beq	a5,a4,80008504 <consoleread+0xf0>
    80008480:	07f7f713          	andi	a4,a5,127
    80008484:	00e48733          	add	a4,s1,a4
    80008488:	01874703          	lbu	a4,24(a4) # c201018 <_entry-0x73dfefe8>
    8000848c:	0017869b          	addiw	a3,a5,1
    80008490:	08d4ac23          	sw	a3,152(s1)
    80008494:	00070c9b          	sext.w	s9,a4
    80008498:	0b370663          	beq	a4,s3,80008544 <consoleread+0x130>
    8000849c:	00100693          	li	a3,1
    800084a0:	f9f40613          	addi	a2,s0,-97
    800084a4:	000c0593          	mv	a1,s8
    800084a8:	00090513          	mv	a0,s2
    800084ac:	f8e40fa3          	sb	a4,-97(s0)
    800084b0:	00000097          	auipc	ra,0x0
    800084b4:	8c0080e7          	jalr	-1856(ra) # 80007d70 <either_copyout>
    800084b8:	01450863          	beq	a0,s4,800084c8 <consoleread+0xb4>
    800084bc:	001c0c13          	addi	s8,s8,1
    800084c0:	fffb8b9b          	addiw	s7,s7,-1
    800084c4:	fb5c94e3          	bne	s9,s5,8000846c <consoleread+0x58>
    800084c8:	000b851b          	sext.w	a0,s7
    800084cc:	06813083          	ld	ra,104(sp)
    800084d0:	06013403          	ld	s0,96(sp)
    800084d4:	05813483          	ld	s1,88(sp)
    800084d8:	05013903          	ld	s2,80(sp)
    800084dc:	04813983          	ld	s3,72(sp)
    800084e0:	04013a03          	ld	s4,64(sp)
    800084e4:	03813a83          	ld	s5,56(sp)
    800084e8:	02813b83          	ld	s7,40(sp)
    800084ec:	02013c03          	ld	s8,32(sp)
    800084f0:	01813c83          	ld	s9,24(sp)
    800084f4:	40ab053b          	subw	a0,s6,a0
    800084f8:	03013b03          	ld	s6,48(sp)
    800084fc:	07010113          	addi	sp,sp,112
    80008500:	00008067          	ret
    80008504:	00001097          	auipc	ra,0x1
    80008508:	1d8080e7          	jalr	472(ra) # 800096dc <push_on>
    8000850c:	0984a703          	lw	a4,152(s1)
    80008510:	09c4a783          	lw	a5,156(s1)
    80008514:	0007879b          	sext.w	a5,a5
    80008518:	fef70ce3          	beq	a4,a5,80008510 <consoleread+0xfc>
    8000851c:	00001097          	auipc	ra,0x1
    80008520:	234080e7          	jalr	564(ra) # 80009750 <pop_on>
    80008524:	0984a783          	lw	a5,152(s1)
    80008528:	07f7f713          	andi	a4,a5,127
    8000852c:	00e48733          	add	a4,s1,a4
    80008530:	01874703          	lbu	a4,24(a4)
    80008534:	0017869b          	addiw	a3,a5,1
    80008538:	08d4ac23          	sw	a3,152(s1)
    8000853c:	00070c9b          	sext.w	s9,a4
    80008540:	f5371ee3          	bne	a4,s3,8000849c <consoleread+0x88>
    80008544:	000b851b          	sext.w	a0,s7
    80008548:	f96bf2e3          	bgeu	s7,s6,800084cc <consoleread+0xb8>
    8000854c:	08f4ac23          	sw	a5,152(s1)
    80008550:	f7dff06f          	j	800084cc <consoleread+0xb8>

0000000080008554 <consputc>:
    80008554:	10000793          	li	a5,256
    80008558:	00f50663          	beq	a0,a5,80008564 <consputc+0x10>
    8000855c:	00001317          	auipc	t1,0x1
    80008560:	9f430067          	jr	-1548(t1) # 80008f50 <uartputc_sync>
    80008564:	ff010113          	addi	sp,sp,-16
    80008568:	00113423          	sd	ra,8(sp)
    8000856c:	00813023          	sd	s0,0(sp)
    80008570:	01010413          	addi	s0,sp,16
    80008574:	00800513          	li	a0,8
    80008578:	00001097          	auipc	ra,0x1
    8000857c:	9d8080e7          	jalr	-1576(ra) # 80008f50 <uartputc_sync>
    80008580:	02000513          	li	a0,32
    80008584:	00001097          	auipc	ra,0x1
    80008588:	9cc080e7          	jalr	-1588(ra) # 80008f50 <uartputc_sync>
    8000858c:	00013403          	ld	s0,0(sp)
    80008590:	00813083          	ld	ra,8(sp)
    80008594:	00800513          	li	a0,8
    80008598:	01010113          	addi	sp,sp,16
    8000859c:	00001317          	auipc	t1,0x1
    800085a0:	9b430067          	jr	-1612(t1) # 80008f50 <uartputc_sync>

00000000800085a4 <consoleintr>:
    800085a4:	fe010113          	addi	sp,sp,-32
    800085a8:	00813823          	sd	s0,16(sp)
    800085ac:	00913423          	sd	s1,8(sp)
    800085b0:	01213023          	sd	s2,0(sp)
    800085b4:	00113c23          	sd	ra,24(sp)
    800085b8:	02010413          	addi	s0,sp,32
    800085bc:	00007917          	auipc	s2,0x7
    800085c0:	5ec90913          	addi	s2,s2,1516 # 8000fba8 <cons>
    800085c4:	00050493          	mv	s1,a0
    800085c8:	00090513          	mv	a0,s2
    800085cc:	00001097          	auipc	ra,0x1
    800085d0:	e40080e7          	jalr	-448(ra) # 8000940c <acquire>
    800085d4:	02048c63          	beqz	s1,8000860c <consoleintr+0x68>
    800085d8:	0a092783          	lw	a5,160(s2)
    800085dc:	09892703          	lw	a4,152(s2)
    800085e0:	07f00693          	li	a3,127
    800085e4:	40e7873b          	subw	a4,a5,a4
    800085e8:	02e6e263          	bltu	a3,a4,8000860c <consoleintr+0x68>
    800085ec:	00d00713          	li	a4,13
    800085f0:	04e48063          	beq	s1,a4,80008630 <consoleintr+0x8c>
    800085f4:	07f7f713          	andi	a4,a5,127
    800085f8:	00e90733          	add	a4,s2,a4
    800085fc:	0017879b          	addiw	a5,a5,1
    80008600:	0af92023          	sw	a5,160(s2)
    80008604:	00970c23          	sb	s1,24(a4)
    80008608:	08f92e23          	sw	a5,156(s2)
    8000860c:	01013403          	ld	s0,16(sp)
    80008610:	01813083          	ld	ra,24(sp)
    80008614:	00813483          	ld	s1,8(sp)
    80008618:	00013903          	ld	s2,0(sp)
    8000861c:	00007517          	auipc	a0,0x7
    80008620:	58c50513          	addi	a0,a0,1420 # 8000fba8 <cons>
    80008624:	02010113          	addi	sp,sp,32
    80008628:	00001317          	auipc	t1,0x1
    8000862c:	eb030067          	jr	-336(t1) # 800094d8 <release>
    80008630:	00a00493          	li	s1,10
    80008634:	fc1ff06f          	j	800085f4 <consoleintr+0x50>

0000000080008638 <consoleinit>:
    80008638:	fe010113          	addi	sp,sp,-32
    8000863c:	00113c23          	sd	ra,24(sp)
    80008640:	00813823          	sd	s0,16(sp)
    80008644:	00913423          	sd	s1,8(sp)
    80008648:	02010413          	addi	s0,sp,32
    8000864c:	00007497          	auipc	s1,0x7
    80008650:	55c48493          	addi	s1,s1,1372 # 8000fba8 <cons>
    80008654:	00048513          	mv	a0,s1
    80008658:	00002597          	auipc	a1,0x2
    8000865c:	32858593          	addi	a1,a1,808 # 8000a980 <CONSOLE_STATUS+0x970>
    80008660:	00001097          	auipc	ra,0x1
    80008664:	d88080e7          	jalr	-632(ra) # 800093e8 <initlock>
    80008668:	00000097          	auipc	ra,0x0
    8000866c:	7ac080e7          	jalr	1964(ra) # 80008e14 <uartinit>
    80008670:	01813083          	ld	ra,24(sp)
    80008674:	01013403          	ld	s0,16(sp)
    80008678:	00000797          	auipc	a5,0x0
    8000867c:	d9c78793          	addi	a5,a5,-612 # 80008414 <consoleread>
    80008680:	0af4bc23          	sd	a5,184(s1)
    80008684:	00000797          	auipc	a5,0x0
    80008688:	cec78793          	addi	a5,a5,-788 # 80008370 <consolewrite>
    8000868c:	0cf4b023          	sd	a5,192(s1)
    80008690:	00813483          	ld	s1,8(sp)
    80008694:	02010113          	addi	sp,sp,32
    80008698:	00008067          	ret

000000008000869c <console_read>:
    8000869c:	ff010113          	addi	sp,sp,-16
    800086a0:	00813423          	sd	s0,8(sp)
    800086a4:	01010413          	addi	s0,sp,16
    800086a8:	00813403          	ld	s0,8(sp)
    800086ac:	00007317          	auipc	t1,0x7
    800086b0:	5b433303          	ld	t1,1460(t1) # 8000fc60 <devsw+0x10>
    800086b4:	01010113          	addi	sp,sp,16
    800086b8:	00030067          	jr	t1

00000000800086bc <console_write>:
    800086bc:	ff010113          	addi	sp,sp,-16
    800086c0:	00813423          	sd	s0,8(sp)
    800086c4:	01010413          	addi	s0,sp,16
    800086c8:	00813403          	ld	s0,8(sp)
    800086cc:	00007317          	auipc	t1,0x7
    800086d0:	59c33303          	ld	t1,1436(t1) # 8000fc68 <devsw+0x18>
    800086d4:	01010113          	addi	sp,sp,16
    800086d8:	00030067          	jr	t1

00000000800086dc <panic>:
    800086dc:	fe010113          	addi	sp,sp,-32
    800086e0:	00113c23          	sd	ra,24(sp)
    800086e4:	00813823          	sd	s0,16(sp)
    800086e8:	00913423          	sd	s1,8(sp)
    800086ec:	02010413          	addi	s0,sp,32
    800086f0:	00050493          	mv	s1,a0
    800086f4:	00002517          	auipc	a0,0x2
    800086f8:	29450513          	addi	a0,a0,660 # 8000a988 <CONSOLE_STATUS+0x978>
    800086fc:	00007797          	auipc	a5,0x7
    80008700:	6007a623          	sw	zero,1548(a5) # 8000fd08 <pr+0x18>
    80008704:	00000097          	auipc	ra,0x0
    80008708:	034080e7          	jalr	52(ra) # 80008738 <__printf>
    8000870c:	00048513          	mv	a0,s1
    80008710:	00000097          	auipc	ra,0x0
    80008714:	028080e7          	jalr	40(ra) # 80008738 <__printf>
    80008718:	00002517          	auipc	a0,0x2
    8000871c:	ff850513          	addi	a0,a0,-8 # 8000a710 <CONSOLE_STATUS+0x700>
    80008720:	00000097          	auipc	ra,0x0
    80008724:	018080e7          	jalr	24(ra) # 80008738 <__printf>
    80008728:	00100793          	li	a5,1
    8000872c:	00004717          	auipc	a4,0x4
    80008730:	5ef72e23          	sw	a5,1532(a4) # 8000cd28 <panicked>
    80008734:	0000006f          	j	80008734 <panic+0x58>

0000000080008738 <__printf>:
    80008738:	f3010113          	addi	sp,sp,-208
    8000873c:	08813023          	sd	s0,128(sp)
    80008740:	07313423          	sd	s3,104(sp)
    80008744:	09010413          	addi	s0,sp,144
    80008748:	05813023          	sd	s8,64(sp)
    8000874c:	08113423          	sd	ra,136(sp)
    80008750:	06913c23          	sd	s1,120(sp)
    80008754:	07213823          	sd	s2,112(sp)
    80008758:	07413023          	sd	s4,96(sp)
    8000875c:	05513c23          	sd	s5,88(sp)
    80008760:	05613823          	sd	s6,80(sp)
    80008764:	05713423          	sd	s7,72(sp)
    80008768:	03913c23          	sd	s9,56(sp)
    8000876c:	03a13823          	sd	s10,48(sp)
    80008770:	03b13423          	sd	s11,40(sp)
    80008774:	00007317          	auipc	t1,0x7
    80008778:	57c30313          	addi	t1,t1,1404 # 8000fcf0 <pr>
    8000877c:	01832c03          	lw	s8,24(t1)
    80008780:	00b43423          	sd	a1,8(s0)
    80008784:	00c43823          	sd	a2,16(s0)
    80008788:	00d43c23          	sd	a3,24(s0)
    8000878c:	02e43023          	sd	a4,32(s0)
    80008790:	02f43423          	sd	a5,40(s0)
    80008794:	03043823          	sd	a6,48(s0)
    80008798:	03143c23          	sd	a7,56(s0)
    8000879c:	00050993          	mv	s3,a0
    800087a0:	4a0c1663          	bnez	s8,80008c4c <__printf+0x514>
    800087a4:	60098c63          	beqz	s3,80008dbc <__printf+0x684>
    800087a8:	0009c503          	lbu	a0,0(s3)
    800087ac:	00840793          	addi	a5,s0,8
    800087b0:	f6f43c23          	sd	a5,-136(s0)
    800087b4:	00000493          	li	s1,0
    800087b8:	22050063          	beqz	a0,800089d8 <__printf+0x2a0>
    800087bc:	00002a37          	lui	s4,0x2
    800087c0:	00018ab7          	lui	s5,0x18
    800087c4:	000f4b37          	lui	s6,0xf4
    800087c8:	00989bb7          	lui	s7,0x989
    800087cc:	70fa0a13          	addi	s4,s4,1807 # 270f <_entry-0x7fffd8f1>
    800087d0:	69fa8a93          	addi	s5,s5,1695 # 1869f <_entry-0x7ffe7961>
    800087d4:	23fb0b13          	addi	s6,s6,575 # f423f <_entry-0x7ff0bdc1>
    800087d8:	67fb8b93          	addi	s7,s7,1663 # 98967f <_entry-0x7f676981>
    800087dc:	00148c9b          	addiw	s9,s1,1
    800087e0:	02500793          	li	a5,37
    800087e4:	01998933          	add	s2,s3,s9
    800087e8:	38f51263          	bne	a0,a5,80008b6c <__printf+0x434>
    800087ec:	00094783          	lbu	a5,0(s2)
    800087f0:	00078c9b          	sext.w	s9,a5
    800087f4:	1e078263          	beqz	a5,800089d8 <__printf+0x2a0>
    800087f8:	0024849b          	addiw	s1,s1,2
    800087fc:	07000713          	li	a4,112
    80008800:	00998933          	add	s2,s3,s1
    80008804:	38e78a63          	beq	a5,a4,80008b98 <__printf+0x460>
    80008808:	20f76863          	bltu	a4,a5,80008a18 <__printf+0x2e0>
    8000880c:	42a78863          	beq	a5,a0,80008c3c <__printf+0x504>
    80008810:	06400713          	li	a4,100
    80008814:	40e79663          	bne	a5,a4,80008c20 <__printf+0x4e8>
    80008818:	f7843783          	ld	a5,-136(s0)
    8000881c:	0007a603          	lw	a2,0(a5)
    80008820:	00878793          	addi	a5,a5,8
    80008824:	f6f43c23          	sd	a5,-136(s0)
    80008828:	42064a63          	bltz	a2,80008c5c <__printf+0x524>
    8000882c:	00a00713          	li	a4,10
    80008830:	02e677bb          	remuw	a5,a2,a4
    80008834:	00002d97          	auipc	s11,0x2
    80008838:	17cd8d93          	addi	s11,s11,380 # 8000a9b0 <digits>
    8000883c:	00900593          	li	a1,9
    80008840:	0006051b          	sext.w	a0,a2
    80008844:	00000c93          	li	s9,0
    80008848:	02079793          	slli	a5,a5,0x20
    8000884c:	0207d793          	srli	a5,a5,0x20
    80008850:	00fd87b3          	add	a5,s11,a5
    80008854:	0007c783          	lbu	a5,0(a5)
    80008858:	02e656bb          	divuw	a3,a2,a4
    8000885c:	f8f40023          	sb	a5,-128(s0)
    80008860:	14c5d863          	bge	a1,a2,800089b0 <__printf+0x278>
    80008864:	06300593          	li	a1,99
    80008868:	00100c93          	li	s9,1
    8000886c:	02e6f7bb          	remuw	a5,a3,a4
    80008870:	02079793          	slli	a5,a5,0x20
    80008874:	0207d793          	srli	a5,a5,0x20
    80008878:	00fd87b3          	add	a5,s11,a5
    8000887c:	0007c783          	lbu	a5,0(a5)
    80008880:	02e6d73b          	divuw	a4,a3,a4
    80008884:	f8f400a3          	sb	a5,-127(s0)
    80008888:	12a5f463          	bgeu	a1,a0,800089b0 <__printf+0x278>
    8000888c:	00a00693          	li	a3,10
    80008890:	00900593          	li	a1,9
    80008894:	02d777bb          	remuw	a5,a4,a3
    80008898:	02079793          	slli	a5,a5,0x20
    8000889c:	0207d793          	srli	a5,a5,0x20
    800088a0:	00fd87b3          	add	a5,s11,a5
    800088a4:	0007c503          	lbu	a0,0(a5)
    800088a8:	02d757bb          	divuw	a5,a4,a3
    800088ac:	f8a40123          	sb	a0,-126(s0)
    800088b0:	48e5f263          	bgeu	a1,a4,80008d34 <__printf+0x5fc>
    800088b4:	06300513          	li	a0,99
    800088b8:	02d7f5bb          	remuw	a1,a5,a3
    800088bc:	02059593          	slli	a1,a1,0x20
    800088c0:	0205d593          	srli	a1,a1,0x20
    800088c4:	00bd85b3          	add	a1,s11,a1
    800088c8:	0005c583          	lbu	a1,0(a1)
    800088cc:	02d7d7bb          	divuw	a5,a5,a3
    800088d0:	f8b401a3          	sb	a1,-125(s0)
    800088d4:	48e57263          	bgeu	a0,a4,80008d58 <__printf+0x620>
    800088d8:	3e700513          	li	a0,999
    800088dc:	02d7f5bb          	remuw	a1,a5,a3
    800088e0:	02059593          	slli	a1,a1,0x20
    800088e4:	0205d593          	srli	a1,a1,0x20
    800088e8:	00bd85b3          	add	a1,s11,a1
    800088ec:	0005c583          	lbu	a1,0(a1)
    800088f0:	02d7d7bb          	divuw	a5,a5,a3
    800088f4:	f8b40223          	sb	a1,-124(s0)
    800088f8:	46e57663          	bgeu	a0,a4,80008d64 <__printf+0x62c>
    800088fc:	02d7f5bb          	remuw	a1,a5,a3
    80008900:	02059593          	slli	a1,a1,0x20
    80008904:	0205d593          	srli	a1,a1,0x20
    80008908:	00bd85b3          	add	a1,s11,a1
    8000890c:	0005c583          	lbu	a1,0(a1)
    80008910:	02d7d7bb          	divuw	a5,a5,a3
    80008914:	f8b402a3          	sb	a1,-123(s0)
    80008918:	46ea7863          	bgeu	s4,a4,80008d88 <__printf+0x650>
    8000891c:	02d7f5bb          	remuw	a1,a5,a3
    80008920:	02059593          	slli	a1,a1,0x20
    80008924:	0205d593          	srli	a1,a1,0x20
    80008928:	00bd85b3          	add	a1,s11,a1
    8000892c:	0005c583          	lbu	a1,0(a1)
    80008930:	02d7d7bb          	divuw	a5,a5,a3
    80008934:	f8b40323          	sb	a1,-122(s0)
    80008938:	3eeaf863          	bgeu	s5,a4,80008d28 <__printf+0x5f0>
    8000893c:	02d7f5bb          	remuw	a1,a5,a3
    80008940:	02059593          	slli	a1,a1,0x20
    80008944:	0205d593          	srli	a1,a1,0x20
    80008948:	00bd85b3          	add	a1,s11,a1
    8000894c:	0005c583          	lbu	a1,0(a1)
    80008950:	02d7d7bb          	divuw	a5,a5,a3
    80008954:	f8b403a3          	sb	a1,-121(s0)
    80008958:	42eb7e63          	bgeu	s6,a4,80008d94 <__printf+0x65c>
    8000895c:	02d7f5bb          	remuw	a1,a5,a3
    80008960:	02059593          	slli	a1,a1,0x20
    80008964:	0205d593          	srli	a1,a1,0x20
    80008968:	00bd85b3          	add	a1,s11,a1
    8000896c:	0005c583          	lbu	a1,0(a1)
    80008970:	02d7d7bb          	divuw	a5,a5,a3
    80008974:	f8b40423          	sb	a1,-120(s0)
    80008978:	42ebfc63          	bgeu	s7,a4,80008db0 <__printf+0x678>
    8000897c:	02079793          	slli	a5,a5,0x20
    80008980:	0207d793          	srli	a5,a5,0x20
    80008984:	00fd8db3          	add	s11,s11,a5
    80008988:	000dc703          	lbu	a4,0(s11)
    8000898c:	00a00793          	li	a5,10
    80008990:	00900c93          	li	s9,9
    80008994:	f8e404a3          	sb	a4,-119(s0)
    80008998:	00065c63          	bgez	a2,800089b0 <__printf+0x278>
    8000899c:	f9040713          	addi	a4,s0,-112
    800089a0:	00f70733          	add	a4,a4,a5
    800089a4:	02d00693          	li	a3,45
    800089a8:	fed70823          	sb	a3,-16(a4)
    800089ac:	00078c93          	mv	s9,a5
    800089b0:	f8040793          	addi	a5,s0,-128
    800089b4:	01978cb3          	add	s9,a5,s9
    800089b8:	f7f40d13          	addi	s10,s0,-129
    800089bc:	000cc503          	lbu	a0,0(s9)
    800089c0:	fffc8c93          	addi	s9,s9,-1
    800089c4:	00000097          	auipc	ra,0x0
    800089c8:	b90080e7          	jalr	-1136(ra) # 80008554 <consputc>
    800089cc:	ffac98e3          	bne	s9,s10,800089bc <__printf+0x284>
    800089d0:	00094503          	lbu	a0,0(s2)
    800089d4:	e00514e3          	bnez	a0,800087dc <__printf+0xa4>
    800089d8:	1a0c1663          	bnez	s8,80008b84 <__printf+0x44c>
    800089dc:	08813083          	ld	ra,136(sp)
    800089e0:	08013403          	ld	s0,128(sp)
    800089e4:	07813483          	ld	s1,120(sp)
    800089e8:	07013903          	ld	s2,112(sp)
    800089ec:	06813983          	ld	s3,104(sp)
    800089f0:	06013a03          	ld	s4,96(sp)
    800089f4:	05813a83          	ld	s5,88(sp)
    800089f8:	05013b03          	ld	s6,80(sp)
    800089fc:	04813b83          	ld	s7,72(sp)
    80008a00:	04013c03          	ld	s8,64(sp)
    80008a04:	03813c83          	ld	s9,56(sp)
    80008a08:	03013d03          	ld	s10,48(sp)
    80008a0c:	02813d83          	ld	s11,40(sp)
    80008a10:	0d010113          	addi	sp,sp,208
    80008a14:	00008067          	ret
    80008a18:	07300713          	li	a4,115
    80008a1c:	1ce78a63          	beq	a5,a4,80008bf0 <__printf+0x4b8>
    80008a20:	07800713          	li	a4,120
    80008a24:	1ee79e63          	bne	a5,a4,80008c20 <__printf+0x4e8>
    80008a28:	f7843783          	ld	a5,-136(s0)
    80008a2c:	0007a703          	lw	a4,0(a5)
    80008a30:	00878793          	addi	a5,a5,8
    80008a34:	f6f43c23          	sd	a5,-136(s0)
    80008a38:	28074263          	bltz	a4,80008cbc <__printf+0x584>
    80008a3c:	00002d97          	auipc	s11,0x2
    80008a40:	f74d8d93          	addi	s11,s11,-140 # 8000a9b0 <digits>
    80008a44:	00f77793          	andi	a5,a4,15
    80008a48:	00fd87b3          	add	a5,s11,a5
    80008a4c:	0007c683          	lbu	a3,0(a5)
    80008a50:	00f00613          	li	a2,15
    80008a54:	0007079b          	sext.w	a5,a4
    80008a58:	f8d40023          	sb	a3,-128(s0)
    80008a5c:	0047559b          	srliw	a1,a4,0x4
    80008a60:	0047569b          	srliw	a3,a4,0x4
    80008a64:	00000c93          	li	s9,0
    80008a68:	0ee65063          	bge	a2,a4,80008b48 <__printf+0x410>
    80008a6c:	00f6f693          	andi	a3,a3,15
    80008a70:	00dd86b3          	add	a3,s11,a3
    80008a74:	0006c683          	lbu	a3,0(a3) # 2004000 <_entry-0x7dffc000>
    80008a78:	0087d79b          	srliw	a5,a5,0x8
    80008a7c:	00100c93          	li	s9,1
    80008a80:	f8d400a3          	sb	a3,-127(s0)
    80008a84:	0cb67263          	bgeu	a2,a1,80008b48 <__printf+0x410>
    80008a88:	00f7f693          	andi	a3,a5,15
    80008a8c:	00dd86b3          	add	a3,s11,a3
    80008a90:	0006c583          	lbu	a1,0(a3)
    80008a94:	00f00613          	li	a2,15
    80008a98:	0047d69b          	srliw	a3,a5,0x4
    80008a9c:	f8b40123          	sb	a1,-126(s0)
    80008aa0:	0047d593          	srli	a1,a5,0x4
    80008aa4:	28f67e63          	bgeu	a2,a5,80008d40 <__printf+0x608>
    80008aa8:	00f6f693          	andi	a3,a3,15
    80008aac:	00dd86b3          	add	a3,s11,a3
    80008ab0:	0006c503          	lbu	a0,0(a3)
    80008ab4:	0087d813          	srli	a6,a5,0x8
    80008ab8:	0087d69b          	srliw	a3,a5,0x8
    80008abc:	f8a401a3          	sb	a0,-125(s0)
    80008ac0:	28b67663          	bgeu	a2,a1,80008d4c <__printf+0x614>
    80008ac4:	00f6f693          	andi	a3,a3,15
    80008ac8:	00dd86b3          	add	a3,s11,a3
    80008acc:	0006c583          	lbu	a1,0(a3)
    80008ad0:	00c7d513          	srli	a0,a5,0xc
    80008ad4:	00c7d69b          	srliw	a3,a5,0xc
    80008ad8:	f8b40223          	sb	a1,-124(s0)
    80008adc:	29067a63          	bgeu	a2,a6,80008d70 <__printf+0x638>
    80008ae0:	00f6f693          	andi	a3,a3,15
    80008ae4:	00dd86b3          	add	a3,s11,a3
    80008ae8:	0006c583          	lbu	a1,0(a3)
    80008aec:	0107d813          	srli	a6,a5,0x10
    80008af0:	0107d69b          	srliw	a3,a5,0x10
    80008af4:	f8b402a3          	sb	a1,-123(s0)
    80008af8:	28a67263          	bgeu	a2,a0,80008d7c <__printf+0x644>
    80008afc:	00f6f693          	andi	a3,a3,15
    80008b00:	00dd86b3          	add	a3,s11,a3
    80008b04:	0006c683          	lbu	a3,0(a3)
    80008b08:	0147d79b          	srliw	a5,a5,0x14
    80008b0c:	f8d40323          	sb	a3,-122(s0)
    80008b10:	21067663          	bgeu	a2,a6,80008d1c <__printf+0x5e4>
    80008b14:	02079793          	slli	a5,a5,0x20
    80008b18:	0207d793          	srli	a5,a5,0x20
    80008b1c:	00fd8db3          	add	s11,s11,a5
    80008b20:	000dc683          	lbu	a3,0(s11)
    80008b24:	00800793          	li	a5,8
    80008b28:	00700c93          	li	s9,7
    80008b2c:	f8d403a3          	sb	a3,-121(s0)
    80008b30:	00075c63          	bgez	a4,80008b48 <__printf+0x410>
    80008b34:	f9040713          	addi	a4,s0,-112
    80008b38:	00f70733          	add	a4,a4,a5
    80008b3c:	02d00693          	li	a3,45
    80008b40:	fed70823          	sb	a3,-16(a4)
    80008b44:	00078c93          	mv	s9,a5
    80008b48:	f8040793          	addi	a5,s0,-128
    80008b4c:	01978cb3          	add	s9,a5,s9
    80008b50:	f7f40d13          	addi	s10,s0,-129
    80008b54:	000cc503          	lbu	a0,0(s9)
    80008b58:	fffc8c93          	addi	s9,s9,-1
    80008b5c:	00000097          	auipc	ra,0x0
    80008b60:	9f8080e7          	jalr	-1544(ra) # 80008554 <consputc>
    80008b64:	ff9d18e3          	bne	s10,s9,80008b54 <__printf+0x41c>
    80008b68:	0100006f          	j	80008b78 <__printf+0x440>
    80008b6c:	00000097          	auipc	ra,0x0
    80008b70:	9e8080e7          	jalr	-1560(ra) # 80008554 <consputc>
    80008b74:	000c8493          	mv	s1,s9
    80008b78:	00094503          	lbu	a0,0(s2)
    80008b7c:	c60510e3          	bnez	a0,800087dc <__printf+0xa4>
    80008b80:	e40c0ee3          	beqz	s8,800089dc <__printf+0x2a4>
    80008b84:	00007517          	auipc	a0,0x7
    80008b88:	16c50513          	addi	a0,a0,364 # 8000fcf0 <pr>
    80008b8c:	00001097          	auipc	ra,0x1
    80008b90:	94c080e7          	jalr	-1716(ra) # 800094d8 <release>
    80008b94:	e49ff06f          	j	800089dc <__printf+0x2a4>
    80008b98:	f7843783          	ld	a5,-136(s0)
    80008b9c:	03000513          	li	a0,48
    80008ba0:	01000d13          	li	s10,16
    80008ba4:	00878713          	addi	a4,a5,8
    80008ba8:	0007bc83          	ld	s9,0(a5)
    80008bac:	f6e43c23          	sd	a4,-136(s0)
    80008bb0:	00000097          	auipc	ra,0x0
    80008bb4:	9a4080e7          	jalr	-1628(ra) # 80008554 <consputc>
    80008bb8:	07800513          	li	a0,120
    80008bbc:	00000097          	auipc	ra,0x0
    80008bc0:	998080e7          	jalr	-1640(ra) # 80008554 <consputc>
    80008bc4:	00002d97          	auipc	s11,0x2
    80008bc8:	decd8d93          	addi	s11,s11,-532 # 8000a9b0 <digits>
    80008bcc:	03ccd793          	srli	a5,s9,0x3c
    80008bd0:	00fd87b3          	add	a5,s11,a5
    80008bd4:	0007c503          	lbu	a0,0(a5)
    80008bd8:	fffd0d1b          	addiw	s10,s10,-1
    80008bdc:	004c9c93          	slli	s9,s9,0x4
    80008be0:	00000097          	auipc	ra,0x0
    80008be4:	974080e7          	jalr	-1676(ra) # 80008554 <consputc>
    80008be8:	fe0d12e3          	bnez	s10,80008bcc <__printf+0x494>
    80008bec:	f8dff06f          	j	80008b78 <__printf+0x440>
    80008bf0:	f7843783          	ld	a5,-136(s0)
    80008bf4:	0007bc83          	ld	s9,0(a5)
    80008bf8:	00878793          	addi	a5,a5,8
    80008bfc:	f6f43c23          	sd	a5,-136(s0)
    80008c00:	000c9a63          	bnez	s9,80008c14 <__printf+0x4dc>
    80008c04:	1080006f          	j	80008d0c <__printf+0x5d4>
    80008c08:	001c8c93          	addi	s9,s9,1
    80008c0c:	00000097          	auipc	ra,0x0
    80008c10:	948080e7          	jalr	-1720(ra) # 80008554 <consputc>
    80008c14:	000cc503          	lbu	a0,0(s9)
    80008c18:	fe0518e3          	bnez	a0,80008c08 <__printf+0x4d0>
    80008c1c:	f5dff06f          	j	80008b78 <__printf+0x440>
    80008c20:	02500513          	li	a0,37
    80008c24:	00000097          	auipc	ra,0x0
    80008c28:	930080e7          	jalr	-1744(ra) # 80008554 <consputc>
    80008c2c:	000c8513          	mv	a0,s9
    80008c30:	00000097          	auipc	ra,0x0
    80008c34:	924080e7          	jalr	-1756(ra) # 80008554 <consputc>
    80008c38:	f41ff06f          	j	80008b78 <__printf+0x440>
    80008c3c:	02500513          	li	a0,37
    80008c40:	00000097          	auipc	ra,0x0
    80008c44:	914080e7          	jalr	-1772(ra) # 80008554 <consputc>
    80008c48:	f31ff06f          	j	80008b78 <__printf+0x440>
    80008c4c:	00030513          	mv	a0,t1
    80008c50:	00000097          	auipc	ra,0x0
    80008c54:	7bc080e7          	jalr	1980(ra) # 8000940c <acquire>
    80008c58:	b4dff06f          	j	800087a4 <__printf+0x6c>
    80008c5c:	40c0053b          	negw	a0,a2
    80008c60:	00a00713          	li	a4,10
    80008c64:	02e576bb          	remuw	a3,a0,a4
    80008c68:	00002d97          	auipc	s11,0x2
    80008c6c:	d48d8d93          	addi	s11,s11,-696 # 8000a9b0 <digits>
    80008c70:	ff700593          	li	a1,-9
    80008c74:	02069693          	slli	a3,a3,0x20
    80008c78:	0206d693          	srli	a3,a3,0x20
    80008c7c:	00dd86b3          	add	a3,s11,a3
    80008c80:	0006c683          	lbu	a3,0(a3)
    80008c84:	02e557bb          	divuw	a5,a0,a4
    80008c88:	f8d40023          	sb	a3,-128(s0)
    80008c8c:	10b65e63          	bge	a2,a1,80008da8 <__printf+0x670>
    80008c90:	06300593          	li	a1,99
    80008c94:	02e7f6bb          	remuw	a3,a5,a4
    80008c98:	02069693          	slli	a3,a3,0x20
    80008c9c:	0206d693          	srli	a3,a3,0x20
    80008ca0:	00dd86b3          	add	a3,s11,a3
    80008ca4:	0006c683          	lbu	a3,0(a3)
    80008ca8:	02e7d73b          	divuw	a4,a5,a4
    80008cac:	00200793          	li	a5,2
    80008cb0:	f8d400a3          	sb	a3,-127(s0)
    80008cb4:	bca5ece3          	bltu	a1,a0,8000888c <__printf+0x154>
    80008cb8:	ce5ff06f          	j	8000899c <__printf+0x264>
    80008cbc:	40e007bb          	negw	a5,a4
    80008cc0:	00002d97          	auipc	s11,0x2
    80008cc4:	cf0d8d93          	addi	s11,s11,-784 # 8000a9b0 <digits>
    80008cc8:	00f7f693          	andi	a3,a5,15
    80008ccc:	00dd86b3          	add	a3,s11,a3
    80008cd0:	0006c583          	lbu	a1,0(a3)
    80008cd4:	ff100613          	li	a2,-15
    80008cd8:	0047d69b          	srliw	a3,a5,0x4
    80008cdc:	f8b40023          	sb	a1,-128(s0)
    80008ce0:	0047d59b          	srliw	a1,a5,0x4
    80008ce4:	0ac75e63          	bge	a4,a2,80008da0 <__printf+0x668>
    80008ce8:	00f6f693          	andi	a3,a3,15
    80008cec:	00dd86b3          	add	a3,s11,a3
    80008cf0:	0006c603          	lbu	a2,0(a3)
    80008cf4:	00f00693          	li	a3,15
    80008cf8:	0087d79b          	srliw	a5,a5,0x8
    80008cfc:	f8c400a3          	sb	a2,-127(s0)
    80008d00:	d8b6e4e3          	bltu	a3,a1,80008a88 <__printf+0x350>
    80008d04:	00200793          	li	a5,2
    80008d08:	e2dff06f          	j	80008b34 <__printf+0x3fc>
    80008d0c:	00002c97          	auipc	s9,0x2
    80008d10:	c84c8c93          	addi	s9,s9,-892 # 8000a990 <CONSOLE_STATUS+0x980>
    80008d14:	02800513          	li	a0,40
    80008d18:	ef1ff06f          	j	80008c08 <__printf+0x4d0>
    80008d1c:	00700793          	li	a5,7
    80008d20:	00600c93          	li	s9,6
    80008d24:	e0dff06f          	j	80008b30 <__printf+0x3f8>
    80008d28:	00700793          	li	a5,7
    80008d2c:	00600c93          	li	s9,6
    80008d30:	c69ff06f          	j	80008998 <__printf+0x260>
    80008d34:	00300793          	li	a5,3
    80008d38:	00200c93          	li	s9,2
    80008d3c:	c5dff06f          	j	80008998 <__printf+0x260>
    80008d40:	00300793          	li	a5,3
    80008d44:	00200c93          	li	s9,2
    80008d48:	de9ff06f          	j	80008b30 <__printf+0x3f8>
    80008d4c:	00400793          	li	a5,4
    80008d50:	00300c93          	li	s9,3
    80008d54:	dddff06f          	j	80008b30 <__printf+0x3f8>
    80008d58:	00400793          	li	a5,4
    80008d5c:	00300c93          	li	s9,3
    80008d60:	c39ff06f          	j	80008998 <__printf+0x260>
    80008d64:	00500793          	li	a5,5
    80008d68:	00400c93          	li	s9,4
    80008d6c:	c2dff06f          	j	80008998 <__printf+0x260>
    80008d70:	00500793          	li	a5,5
    80008d74:	00400c93          	li	s9,4
    80008d78:	db9ff06f          	j	80008b30 <__printf+0x3f8>
    80008d7c:	00600793          	li	a5,6
    80008d80:	00500c93          	li	s9,5
    80008d84:	dadff06f          	j	80008b30 <__printf+0x3f8>
    80008d88:	00600793          	li	a5,6
    80008d8c:	00500c93          	li	s9,5
    80008d90:	c09ff06f          	j	80008998 <__printf+0x260>
    80008d94:	00800793          	li	a5,8
    80008d98:	00700c93          	li	s9,7
    80008d9c:	bfdff06f          	j	80008998 <__printf+0x260>
    80008da0:	00100793          	li	a5,1
    80008da4:	d91ff06f          	j	80008b34 <__printf+0x3fc>
    80008da8:	00100793          	li	a5,1
    80008dac:	bf1ff06f          	j	8000899c <__printf+0x264>
    80008db0:	00900793          	li	a5,9
    80008db4:	00800c93          	li	s9,8
    80008db8:	be1ff06f          	j	80008998 <__printf+0x260>
    80008dbc:	00002517          	auipc	a0,0x2
    80008dc0:	bdc50513          	addi	a0,a0,-1060 # 8000a998 <CONSOLE_STATUS+0x988>
    80008dc4:	00000097          	auipc	ra,0x0
    80008dc8:	918080e7          	jalr	-1768(ra) # 800086dc <panic>

0000000080008dcc <printfinit>:
    80008dcc:	fe010113          	addi	sp,sp,-32
    80008dd0:	00813823          	sd	s0,16(sp)
    80008dd4:	00913423          	sd	s1,8(sp)
    80008dd8:	00113c23          	sd	ra,24(sp)
    80008ddc:	02010413          	addi	s0,sp,32
    80008de0:	00007497          	auipc	s1,0x7
    80008de4:	f1048493          	addi	s1,s1,-240 # 8000fcf0 <pr>
    80008de8:	00048513          	mv	a0,s1
    80008dec:	00002597          	auipc	a1,0x2
    80008df0:	bbc58593          	addi	a1,a1,-1092 # 8000a9a8 <CONSOLE_STATUS+0x998>
    80008df4:	00000097          	auipc	ra,0x0
    80008df8:	5f4080e7          	jalr	1524(ra) # 800093e8 <initlock>
    80008dfc:	01813083          	ld	ra,24(sp)
    80008e00:	01013403          	ld	s0,16(sp)
    80008e04:	0004ac23          	sw	zero,24(s1)
    80008e08:	00813483          	ld	s1,8(sp)
    80008e0c:	02010113          	addi	sp,sp,32
    80008e10:	00008067          	ret

0000000080008e14 <uartinit>:
    80008e14:	ff010113          	addi	sp,sp,-16
    80008e18:	00813423          	sd	s0,8(sp)
    80008e1c:	01010413          	addi	s0,sp,16
    80008e20:	100007b7          	lui	a5,0x10000
    80008e24:	000780a3          	sb	zero,1(a5) # 10000001 <_entry-0x6fffffff>
    80008e28:	f8000713          	li	a4,-128
    80008e2c:	00e781a3          	sb	a4,3(a5)
    80008e30:	00300713          	li	a4,3
    80008e34:	00e78023          	sb	a4,0(a5)
    80008e38:	000780a3          	sb	zero,1(a5)
    80008e3c:	00e781a3          	sb	a4,3(a5)
    80008e40:	00700693          	li	a3,7
    80008e44:	00d78123          	sb	a3,2(a5)
    80008e48:	00e780a3          	sb	a4,1(a5)
    80008e4c:	00813403          	ld	s0,8(sp)
    80008e50:	01010113          	addi	sp,sp,16
    80008e54:	00008067          	ret

0000000080008e58 <uartputc>:
    80008e58:	00004797          	auipc	a5,0x4
    80008e5c:	ed07a783          	lw	a5,-304(a5) # 8000cd28 <panicked>
    80008e60:	00078463          	beqz	a5,80008e68 <uartputc+0x10>
    80008e64:	0000006f          	j	80008e64 <uartputc+0xc>
    80008e68:	fd010113          	addi	sp,sp,-48
    80008e6c:	02813023          	sd	s0,32(sp)
    80008e70:	00913c23          	sd	s1,24(sp)
    80008e74:	01213823          	sd	s2,16(sp)
    80008e78:	01313423          	sd	s3,8(sp)
    80008e7c:	02113423          	sd	ra,40(sp)
    80008e80:	03010413          	addi	s0,sp,48
    80008e84:	00004917          	auipc	s2,0x4
    80008e88:	eac90913          	addi	s2,s2,-340 # 8000cd30 <uart_tx_r>
    80008e8c:	00093783          	ld	a5,0(s2)
    80008e90:	00004497          	auipc	s1,0x4
    80008e94:	ea848493          	addi	s1,s1,-344 # 8000cd38 <uart_tx_w>
    80008e98:	0004b703          	ld	a4,0(s1)
    80008e9c:	02078693          	addi	a3,a5,32
    80008ea0:	00050993          	mv	s3,a0
    80008ea4:	02e69c63          	bne	a3,a4,80008edc <uartputc+0x84>
    80008ea8:	00001097          	auipc	ra,0x1
    80008eac:	834080e7          	jalr	-1996(ra) # 800096dc <push_on>
    80008eb0:	00093783          	ld	a5,0(s2)
    80008eb4:	0004b703          	ld	a4,0(s1)
    80008eb8:	02078793          	addi	a5,a5,32
    80008ebc:	00e79463          	bne	a5,a4,80008ec4 <uartputc+0x6c>
    80008ec0:	0000006f          	j	80008ec0 <uartputc+0x68>
    80008ec4:	00001097          	auipc	ra,0x1
    80008ec8:	88c080e7          	jalr	-1908(ra) # 80009750 <pop_on>
    80008ecc:	00093783          	ld	a5,0(s2)
    80008ed0:	0004b703          	ld	a4,0(s1)
    80008ed4:	02078693          	addi	a3,a5,32
    80008ed8:	fce688e3          	beq	a3,a4,80008ea8 <uartputc+0x50>
    80008edc:	01f77693          	andi	a3,a4,31
    80008ee0:	00007597          	auipc	a1,0x7
    80008ee4:	e3058593          	addi	a1,a1,-464 # 8000fd10 <uart_tx_buf>
    80008ee8:	00d586b3          	add	a3,a1,a3
    80008eec:	00170713          	addi	a4,a4,1
    80008ef0:	01368023          	sb	s3,0(a3)
    80008ef4:	00e4b023          	sd	a4,0(s1)
    80008ef8:	10000637          	lui	a2,0x10000
    80008efc:	02f71063          	bne	a4,a5,80008f1c <uartputc+0xc4>
    80008f00:	0340006f          	j	80008f34 <uartputc+0xdc>
    80008f04:	00074703          	lbu	a4,0(a4)
    80008f08:	00f93023          	sd	a5,0(s2)
    80008f0c:	00e60023          	sb	a4,0(a2) # 10000000 <_entry-0x70000000>
    80008f10:	00093783          	ld	a5,0(s2)
    80008f14:	0004b703          	ld	a4,0(s1)
    80008f18:	00f70e63          	beq	a4,a5,80008f34 <uartputc+0xdc>
    80008f1c:	00564683          	lbu	a3,5(a2)
    80008f20:	01f7f713          	andi	a4,a5,31
    80008f24:	00e58733          	add	a4,a1,a4
    80008f28:	0206f693          	andi	a3,a3,32
    80008f2c:	00178793          	addi	a5,a5,1
    80008f30:	fc069ae3          	bnez	a3,80008f04 <uartputc+0xac>
    80008f34:	02813083          	ld	ra,40(sp)
    80008f38:	02013403          	ld	s0,32(sp)
    80008f3c:	01813483          	ld	s1,24(sp)
    80008f40:	01013903          	ld	s2,16(sp)
    80008f44:	00813983          	ld	s3,8(sp)
    80008f48:	03010113          	addi	sp,sp,48
    80008f4c:	00008067          	ret

0000000080008f50 <uartputc_sync>:
    80008f50:	ff010113          	addi	sp,sp,-16
    80008f54:	00813423          	sd	s0,8(sp)
    80008f58:	01010413          	addi	s0,sp,16
    80008f5c:	00004717          	auipc	a4,0x4
    80008f60:	dcc72703          	lw	a4,-564(a4) # 8000cd28 <panicked>
    80008f64:	02071663          	bnez	a4,80008f90 <uartputc_sync+0x40>
    80008f68:	00050793          	mv	a5,a0
    80008f6c:	100006b7          	lui	a3,0x10000
    80008f70:	0056c703          	lbu	a4,5(a3) # 10000005 <_entry-0x6ffffffb>
    80008f74:	02077713          	andi	a4,a4,32
    80008f78:	fe070ce3          	beqz	a4,80008f70 <uartputc_sync+0x20>
    80008f7c:	0ff7f793          	andi	a5,a5,255
    80008f80:	00f68023          	sb	a5,0(a3)
    80008f84:	00813403          	ld	s0,8(sp)
    80008f88:	01010113          	addi	sp,sp,16
    80008f8c:	00008067          	ret
    80008f90:	0000006f          	j	80008f90 <uartputc_sync+0x40>

0000000080008f94 <uartstart>:
    80008f94:	ff010113          	addi	sp,sp,-16
    80008f98:	00813423          	sd	s0,8(sp)
    80008f9c:	01010413          	addi	s0,sp,16
    80008fa0:	00004617          	auipc	a2,0x4
    80008fa4:	d9060613          	addi	a2,a2,-624 # 8000cd30 <uart_tx_r>
    80008fa8:	00004517          	auipc	a0,0x4
    80008fac:	d9050513          	addi	a0,a0,-624 # 8000cd38 <uart_tx_w>
    80008fb0:	00063783          	ld	a5,0(a2)
    80008fb4:	00053703          	ld	a4,0(a0)
    80008fb8:	04f70263          	beq	a4,a5,80008ffc <uartstart+0x68>
    80008fbc:	100005b7          	lui	a1,0x10000
    80008fc0:	00007817          	auipc	a6,0x7
    80008fc4:	d5080813          	addi	a6,a6,-688 # 8000fd10 <uart_tx_buf>
    80008fc8:	01c0006f          	j	80008fe4 <uartstart+0x50>
    80008fcc:	0006c703          	lbu	a4,0(a3)
    80008fd0:	00f63023          	sd	a5,0(a2)
    80008fd4:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    80008fd8:	00063783          	ld	a5,0(a2)
    80008fdc:	00053703          	ld	a4,0(a0)
    80008fe0:	00f70e63          	beq	a4,a5,80008ffc <uartstart+0x68>
    80008fe4:	01f7f713          	andi	a4,a5,31
    80008fe8:	00e806b3          	add	a3,a6,a4
    80008fec:	0055c703          	lbu	a4,5(a1)
    80008ff0:	00178793          	addi	a5,a5,1
    80008ff4:	02077713          	andi	a4,a4,32
    80008ff8:	fc071ae3          	bnez	a4,80008fcc <uartstart+0x38>
    80008ffc:	00813403          	ld	s0,8(sp)
    80009000:	01010113          	addi	sp,sp,16
    80009004:	00008067          	ret

0000000080009008 <uartgetc>:
    80009008:	ff010113          	addi	sp,sp,-16
    8000900c:	00813423          	sd	s0,8(sp)
    80009010:	01010413          	addi	s0,sp,16
    80009014:	10000737          	lui	a4,0x10000
    80009018:	00574783          	lbu	a5,5(a4) # 10000005 <_entry-0x6ffffffb>
    8000901c:	0017f793          	andi	a5,a5,1
    80009020:	00078c63          	beqz	a5,80009038 <uartgetc+0x30>
    80009024:	00074503          	lbu	a0,0(a4)
    80009028:	0ff57513          	andi	a0,a0,255
    8000902c:	00813403          	ld	s0,8(sp)
    80009030:	01010113          	addi	sp,sp,16
    80009034:	00008067          	ret
    80009038:	fff00513          	li	a0,-1
    8000903c:	ff1ff06f          	j	8000902c <uartgetc+0x24>

0000000080009040 <uartintr>:
    80009040:	100007b7          	lui	a5,0x10000
    80009044:	0057c783          	lbu	a5,5(a5) # 10000005 <_entry-0x6ffffffb>
    80009048:	0017f793          	andi	a5,a5,1
    8000904c:	0a078463          	beqz	a5,800090f4 <uartintr+0xb4>
    80009050:	fe010113          	addi	sp,sp,-32
    80009054:	00813823          	sd	s0,16(sp)
    80009058:	00913423          	sd	s1,8(sp)
    8000905c:	00113c23          	sd	ra,24(sp)
    80009060:	02010413          	addi	s0,sp,32
    80009064:	100004b7          	lui	s1,0x10000
    80009068:	0004c503          	lbu	a0,0(s1) # 10000000 <_entry-0x70000000>
    8000906c:	0ff57513          	andi	a0,a0,255
    80009070:	fffff097          	auipc	ra,0xfffff
    80009074:	534080e7          	jalr	1332(ra) # 800085a4 <consoleintr>
    80009078:	0054c783          	lbu	a5,5(s1)
    8000907c:	0017f793          	andi	a5,a5,1
    80009080:	fe0794e3          	bnez	a5,80009068 <uartintr+0x28>
    80009084:	00004617          	auipc	a2,0x4
    80009088:	cac60613          	addi	a2,a2,-852 # 8000cd30 <uart_tx_r>
    8000908c:	00004517          	auipc	a0,0x4
    80009090:	cac50513          	addi	a0,a0,-852 # 8000cd38 <uart_tx_w>
    80009094:	00063783          	ld	a5,0(a2)
    80009098:	00053703          	ld	a4,0(a0)
    8000909c:	04f70263          	beq	a4,a5,800090e0 <uartintr+0xa0>
    800090a0:	100005b7          	lui	a1,0x10000
    800090a4:	00007817          	auipc	a6,0x7
    800090a8:	c6c80813          	addi	a6,a6,-916 # 8000fd10 <uart_tx_buf>
    800090ac:	01c0006f          	j	800090c8 <uartintr+0x88>
    800090b0:	0006c703          	lbu	a4,0(a3)
    800090b4:	00f63023          	sd	a5,0(a2)
    800090b8:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    800090bc:	00063783          	ld	a5,0(a2)
    800090c0:	00053703          	ld	a4,0(a0)
    800090c4:	00f70e63          	beq	a4,a5,800090e0 <uartintr+0xa0>
    800090c8:	01f7f713          	andi	a4,a5,31
    800090cc:	00e806b3          	add	a3,a6,a4
    800090d0:	0055c703          	lbu	a4,5(a1)
    800090d4:	00178793          	addi	a5,a5,1
    800090d8:	02077713          	andi	a4,a4,32
    800090dc:	fc071ae3          	bnez	a4,800090b0 <uartintr+0x70>
    800090e0:	01813083          	ld	ra,24(sp)
    800090e4:	01013403          	ld	s0,16(sp)
    800090e8:	00813483          	ld	s1,8(sp)
    800090ec:	02010113          	addi	sp,sp,32
    800090f0:	00008067          	ret
    800090f4:	00004617          	auipc	a2,0x4
    800090f8:	c3c60613          	addi	a2,a2,-964 # 8000cd30 <uart_tx_r>
    800090fc:	00004517          	auipc	a0,0x4
    80009100:	c3c50513          	addi	a0,a0,-964 # 8000cd38 <uart_tx_w>
    80009104:	00063783          	ld	a5,0(a2)
    80009108:	00053703          	ld	a4,0(a0)
    8000910c:	04f70263          	beq	a4,a5,80009150 <uartintr+0x110>
    80009110:	100005b7          	lui	a1,0x10000
    80009114:	00007817          	auipc	a6,0x7
    80009118:	bfc80813          	addi	a6,a6,-1028 # 8000fd10 <uart_tx_buf>
    8000911c:	01c0006f          	j	80009138 <uartintr+0xf8>
    80009120:	0006c703          	lbu	a4,0(a3)
    80009124:	00f63023          	sd	a5,0(a2)
    80009128:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    8000912c:	00063783          	ld	a5,0(a2)
    80009130:	00053703          	ld	a4,0(a0)
    80009134:	02f70063          	beq	a4,a5,80009154 <uartintr+0x114>
    80009138:	01f7f713          	andi	a4,a5,31
    8000913c:	00e806b3          	add	a3,a6,a4
    80009140:	0055c703          	lbu	a4,5(a1)
    80009144:	00178793          	addi	a5,a5,1
    80009148:	02077713          	andi	a4,a4,32
    8000914c:	fc071ae3          	bnez	a4,80009120 <uartintr+0xe0>
    80009150:	00008067          	ret
    80009154:	00008067          	ret

0000000080009158 <kinit>:
    80009158:	fc010113          	addi	sp,sp,-64
    8000915c:	02913423          	sd	s1,40(sp)
    80009160:	fffff7b7          	lui	a5,0xfffff
    80009164:	00008497          	auipc	s1,0x8
    80009168:	bcb48493          	addi	s1,s1,-1077 # 80010d2f <end+0xfff>
    8000916c:	02813823          	sd	s0,48(sp)
    80009170:	01313c23          	sd	s3,24(sp)
    80009174:	00f4f4b3          	and	s1,s1,a5
    80009178:	02113c23          	sd	ra,56(sp)
    8000917c:	03213023          	sd	s2,32(sp)
    80009180:	01413823          	sd	s4,16(sp)
    80009184:	01513423          	sd	s5,8(sp)
    80009188:	04010413          	addi	s0,sp,64
    8000918c:	000017b7          	lui	a5,0x1
    80009190:	01100993          	li	s3,17
    80009194:	00f487b3          	add	a5,s1,a5
    80009198:	01b99993          	slli	s3,s3,0x1b
    8000919c:	06f9e063          	bltu	s3,a5,800091fc <kinit+0xa4>
    800091a0:	00007a97          	auipc	s5,0x7
    800091a4:	b90a8a93          	addi	s5,s5,-1136 # 8000fd30 <end>
    800091a8:	0754ec63          	bltu	s1,s5,80009220 <kinit+0xc8>
    800091ac:	0734fa63          	bgeu	s1,s3,80009220 <kinit+0xc8>
    800091b0:	00088a37          	lui	s4,0x88
    800091b4:	fffa0a13          	addi	s4,s4,-1 # 87fff <_entry-0x7ff78001>
    800091b8:	00004917          	auipc	s2,0x4
    800091bc:	b8890913          	addi	s2,s2,-1144 # 8000cd40 <kmem>
    800091c0:	00ca1a13          	slli	s4,s4,0xc
    800091c4:	0140006f          	j	800091d8 <kinit+0x80>
    800091c8:	000017b7          	lui	a5,0x1
    800091cc:	00f484b3          	add	s1,s1,a5
    800091d0:	0554e863          	bltu	s1,s5,80009220 <kinit+0xc8>
    800091d4:	0534f663          	bgeu	s1,s3,80009220 <kinit+0xc8>
    800091d8:	00001637          	lui	a2,0x1
    800091dc:	00100593          	li	a1,1
    800091e0:	00048513          	mv	a0,s1
    800091e4:	00000097          	auipc	ra,0x0
    800091e8:	5e4080e7          	jalr	1508(ra) # 800097c8 <__memset>
    800091ec:	00093783          	ld	a5,0(s2)
    800091f0:	00f4b023          	sd	a5,0(s1)
    800091f4:	00993023          	sd	s1,0(s2)
    800091f8:	fd4498e3          	bne	s1,s4,800091c8 <kinit+0x70>
    800091fc:	03813083          	ld	ra,56(sp)
    80009200:	03013403          	ld	s0,48(sp)
    80009204:	02813483          	ld	s1,40(sp)
    80009208:	02013903          	ld	s2,32(sp)
    8000920c:	01813983          	ld	s3,24(sp)
    80009210:	01013a03          	ld	s4,16(sp)
    80009214:	00813a83          	ld	s5,8(sp)
    80009218:	04010113          	addi	sp,sp,64
    8000921c:	00008067          	ret
    80009220:	00001517          	auipc	a0,0x1
    80009224:	7a850513          	addi	a0,a0,1960 # 8000a9c8 <digits+0x18>
    80009228:	fffff097          	auipc	ra,0xfffff
    8000922c:	4b4080e7          	jalr	1204(ra) # 800086dc <panic>

0000000080009230 <freerange>:
    80009230:	fc010113          	addi	sp,sp,-64
    80009234:	000017b7          	lui	a5,0x1
    80009238:	02913423          	sd	s1,40(sp)
    8000923c:	fff78493          	addi	s1,a5,-1 # fff <_entry-0x7ffff001>
    80009240:	009504b3          	add	s1,a0,s1
    80009244:	fffff537          	lui	a0,0xfffff
    80009248:	02813823          	sd	s0,48(sp)
    8000924c:	02113c23          	sd	ra,56(sp)
    80009250:	03213023          	sd	s2,32(sp)
    80009254:	01313c23          	sd	s3,24(sp)
    80009258:	01413823          	sd	s4,16(sp)
    8000925c:	01513423          	sd	s5,8(sp)
    80009260:	01613023          	sd	s6,0(sp)
    80009264:	04010413          	addi	s0,sp,64
    80009268:	00a4f4b3          	and	s1,s1,a0
    8000926c:	00f487b3          	add	a5,s1,a5
    80009270:	06f5e463          	bltu	a1,a5,800092d8 <freerange+0xa8>
    80009274:	00007a97          	auipc	s5,0x7
    80009278:	abca8a93          	addi	s5,s5,-1348 # 8000fd30 <end>
    8000927c:	0954e263          	bltu	s1,s5,80009300 <freerange+0xd0>
    80009280:	01100993          	li	s3,17
    80009284:	01b99993          	slli	s3,s3,0x1b
    80009288:	0734fc63          	bgeu	s1,s3,80009300 <freerange+0xd0>
    8000928c:	00058a13          	mv	s4,a1
    80009290:	00004917          	auipc	s2,0x4
    80009294:	ab090913          	addi	s2,s2,-1360 # 8000cd40 <kmem>
    80009298:	00002b37          	lui	s6,0x2
    8000929c:	0140006f          	j	800092b0 <freerange+0x80>
    800092a0:	000017b7          	lui	a5,0x1
    800092a4:	00f484b3          	add	s1,s1,a5
    800092a8:	0554ec63          	bltu	s1,s5,80009300 <freerange+0xd0>
    800092ac:	0534fa63          	bgeu	s1,s3,80009300 <freerange+0xd0>
    800092b0:	00001637          	lui	a2,0x1
    800092b4:	00100593          	li	a1,1
    800092b8:	00048513          	mv	a0,s1
    800092bc:	00000097          	auipc	ra,0x0
    800092c0:	50c080e7          	jalr	1292(ra) # 800097c8 <__memset>
    800092c4:	00093703          	ld	a4,0(s2)
    800092c8:	016487b3          	add	a5,s1,s6
    800092cc:	00e4b023          	sd	a4,0(s1)
    800092d0:	00993023          	sd	s1,0(s2)
    800092d4:	fcfa76e3          	bgeu	s4,a5,800092a0 <freerange+0x70>
    800092d8:	03813083          	ld	ra,56(sp)
    800092dc:	03013403          	ld	s0,48(sp)
    800092e0:	02813483          	ld	s1,40(sp)
    800092e4:	02013903          	ld	s2,32(sp)
    800092e8:	01813983          	ld	s3,24(sp)
    800092ec:	01013a03          	ld	s4,16(sp)
    800092f0:	00813a83          	ld	s5,8(sp)
    800092f4:	00013b03          	ld	s6,0(sp)
    800092f8:	04010113          	addi	sp,sp,64
    800092fc:	00008067          	ret
    80009300:	00001517          	auipc	a0,0x1
    80009304:	6c850513          	addi	a0,a0,1736 # 8000a9c8 <digits+0x18>
    80009308:	fffff097          	auipc	ra,0xfffff
    8000930c:	3d4080e7          	jalr	980(ra) # 800086dc <panic>

0000000080009310 <kfree>:
    80009310:	fe010113          	addi	sp,sp,-32
    80009314:	00813823          	sd	s0,16(sp)
    80009318:	00113c23          	sd	ra,24(sp)
    8000931c:	00913423          	sd	s1,8(sp)
    80009320:	02010413          	addi	s0,sp,32
    80009324:	03451793          	slli	a5,a0,0x34
    80009328:	04079c63          	bnez	a5,80009380 <kfree+0x70>
    8000932c:	00007797          	auipc	a5,0x7
    80009330:	a0478793          	addi	a5,a5,-1532 # 8000fd30 <end>
    80009334:	00050493          	mv	s1,a0
    80009338:	04f56463          	bltu	a0,a5,80009380 <kfree+0x70>
    8000933c:	01100793          	li	a5,17
    80009340:	01b79793          	slli	a5,a5,0x1b
    80009344:	02f57e63          	bgeu	a0,a5,80009380 <kfree+0x70>
    80009348:	00001637          	lui	a2,0x1
    8000934c:	00100593          	li	a1,1
    80009350:	00000097          	auipc	ra,0x0
    80009354:	478080e7          	jalr	1144(ra) # 800097c8 <__memset>
    80009358:	00004797          	auipc	a5,0x4
    8000935c:	9e878793          	addi	a5,a5,-1560 # 8000cd40 <kmem>
    80009360:	0007b703          	ld	a4,0(a5)
    80009364:	01813083          	ld	ra,24(sp)
    80009368:	01013403          	ld	s0,16(sp)
    8000936c:	00e4b023          	sd	a4,0(s1)
    80009370:	0097b023          	sd	s1,0(a5)
    80009374:	00813483          	ld	s1,8(sp)
    80009378:	02010113          	addi	sp,sp,32
    8000937c:	00008067          	ret
    80009380:	00001517          	auipc	a0,0x1
    80009384:	64850513          	addi	a0,a0,1608 # 8000a9c8 <digits+0x18>
    80009388:	fffff097          	auipc	ra,0xfffff
    8000938c:	354080e7          	jalr	852(ra) # 800086dc <panic>

0000000080009390 <kalloc>:
    80009390:	fe010113          	addi	sp,sp,-32
    80009394:	00813823          	sd	s0,16(sp)
    80009398:	00913423          	sd	s1,8(sp)
    8000939c:	00113c23          	sd	ra,24(sp)
    800093a0:	02010413          	addi	s0,sp,32
    800093a4:	00004797          	auipc	a5,0x4
    800093a8:	99c78793          	addi	a5,a5,-1636 # 8000cd40 <kmem>
    800093ac:	0007b483          	ld	s1,0(a5)
    800093b0:	02048063          	beqz	s1,800093d0 <kalloc+0x40>
    800093b4:	0004b703          	ld	a4,0(s1)
    800093b8:	00001637          	lui	a2,0x1
    800093bc:	00500593          	li	a1,5
    800093c0:	00048513          	mv	a0,s1
    800093c4:	00e7b023          	sd	a4,0(a5)
    800093c8:	00000097          	auipc	ra,0x0
    800093cc:	400080e7          	jalr	1024(ra) # 800097c8 <__memset>
    800093d0:	01813083          	ld	ra,24(sp)
    800093d4:	01013403          	ld	s0,16(sp)
    800093d8:	00048513          	mv	a0,s1
    800093dc:	00813483          	ld	s1,8(sp)
    800093e0:	02010113          	addi	sp,sp,32
    800093e4:	00008067          	ret

00000000800093e8 <initlock>:
    800093e8:	ff010113          	addi	sp,sp,-16
    800093ec:	00813423          	sd	s0,8(sp)
    800093f0:	01010413          	addi	s0,sp,16
    800093f4:	00813403          	ld	s0,8(sp)
    800093f8:	00b53423          	sd	a1,8(a0)
    800093fc:	00052023          	sw	zero,0(a0)
    80009400:	00053823          	sd	zero,16(a0)
    80009404:	01010113          	addi	sp,sp,16
    80009408:	00008067          	ret

000000008000940c <acquire>:
    8000940c:	fe010113          	addi	sp,sp,-32
    80009410:	00813823          	sd	s0,16(sp)
    80009414:	00913423          	sd	s1,8(sp)
    80009418:	00113c23          	sd	ra,24(sp)
    8000941c:	01213023          	sd	s2,0(sp)
    80009420:	02010413          	addi	s0,sp,32
    80009424:	00050493          	mv	s1,a0
    80009428:	10002973          	csrr	s2,sstatus
    8000942c:	100027f3          	csrr	a5,sstatus
    80009430:	ffd7f793          	andi	a5,a5,-3
    80009434:	10079073          	csrw	sstatus,a5
    80009438:	fffff097          	auipc	ra,0xfffff
    8000943c:	8ec080e7          	jalr	-1812(ra) # 80007d24 <mycpu>
    80009440:	07852783          	lw	a5,120(a0)
    80009444:	06078e63          	beqz	a5,800094c0 <acquire+0xb4>
    80009448:	fffff097          	auipc	ra,0xfffff
    8000944c:	8dc080e7          	jalr	-1828(ra) # 80007d24 <mycpu>
    80009450:	07852783          	lw	a5,120(a0)
    80009454:	0004a703          	lw	a4,0(s1)
    80009458:	0017879b          	addiw	a5,a5,1
    8000945c:	06f52c23          	sw	a5,120(a0)
    80009460:	04071063          	bnez	a4,800094a0 <acquire+0x94>
    80009464:	00100713          	li	a4,1
    80009468:	00070793          	mv	a5,a4
    8000946c:	0cf4a7af          	amoswap.w.aq	a5,a5,(s1)
    80009470:	0007879b          	sext.w	a5,a5
    80009474:	fe079ae3          	bnez	a5,80009468 <acquire+0x5c>
    80009478:	0ff0000f          	fence
    8000947c:	fffff097          	auipc	ra,0xfffff
    80009480:	8a8080e7          	jalr	-1880(ra) # 80007d24 <mycpu>
    80009484:	01813083          	ld	ra,24(sp)
    80009488:	01013403          	ld	s0,16(sp)
    8000948c:	00a4b823          	sd	a0,16(s1)
    80009490:	00013903          	ld	s2,0(sp)
    80009494:	00813483          	ld	s1,8(sp)
    80009498:	02010113          	addi	sp,sp,32
    8000949c:	00008067          	ret
    800094a0:	0104b903          	ld	s2,16(s1)
    800094a4:	fffff097          	auipc	ra,0xfffff
    800094a8:	880080e7          	jalr	-1920(ra) # 80007d24 <mycpu>
    800094ac:	faa91ce3          	bne	s2,a0,80009464 <acquire+0x58>
    800094b0:	00001517          	auipc	a0,0x1
    800094b4:	52050513          	addi	a0,a0,1312 # 8000a9d0 <digits+0x20>
    800094b8:	fffff097          	auipc	ra,0xfffff
    800094bc:	224080e7          	jalr	548(ra) # 800086dc <panic>
    800094c0:	00195913          	srli	s2,s2,0x1
    800094c4:	fffff097          	auipc	ra,0xfffff
    800094c8:	860080e7          	jalr	-1952(ra) # 80007d24 <mycpu>
    800094cc:	00197913          	andi	s2,s2,1
    800094d0:	07252e23          	sw	s2,124(a0)
    800094d4:	f75ff06f          	j	80009448 <acquire+0x3c>

00000000800094d8 <release>:
    800094d8:	fe010113          	addi	sp,sp,-32
    800094dc:	00813823          	sd	s0,16(sp)
    800094e0:	00113c23          	sd	ra,24(sp)
    800094e4:	00913423          	sd	s1,8(sp)
    800094e8:	01213023          	sd	s2,0(sp)
    800094ec:	02010413          	addi	s0,sp,32
    800094f0:	00052783          	lw	a5,0(a0)
    800094f4:	00079a63          	bnez	a5,80009508 <release+0x30>
    800094f8:	00001517          	auipc	a0,0x1
    800094fc:	4e050513          	addi	a0,a0,1248 # 8000a9d8 <digits+0x28>
    80009500:	fffff097          	auipc	ra,0xfffff
    80009504:	1dc080e7          	jalr	476(ra) # 800086dc <panic>
    80009508:	01053903          	ld	s2,16(a0)
    8000950c:	00050493          	mv	s1,a0
    80009510:	fffff097          	auipc	ra,0xfffff
    80009514:	814080e7          	jalr	-2028(ra) # 80007d24 <mycpu>
    80009518:	fea910e3          	bne	s2,a0,800094f8 <release+0x20>
    8000951c:	0004b823          	sd	zero,16(s1)
    80009520:	0ff0000f          	fence
    80009524:	0f50000f          	fence	iorw,ow
    80009528:	0804a02f          	amoswap.w	zero,zero,(s1)
    8000952c:	ffffe097          	auipc	ra,0xffffe
    80009530:	7f8080e7          	jalr	2040(ra) # 80007d24 <mycpu>
    80009534:	100027f3          	csrr	a5,sstatus
    80009538:	0027f793          	andi	a5,a5,2
    8000953c:	04079a63          	bnez	a5,80009590 <release+0xb8>
    80009540:	07852783          	lw	a5,120(a0)
    80009544:	02f05e63          	blez	a5,80009580 <release+0xa8>
    80009548:	fff7871b          	addiw	a4,a5,-1
    8000954c:	06e52c23          	sw	a4,120(a0)
    80009550:	00071c63          	bnez	a4,80009568 <release+0x90>
    80009554:	07c52783          	lw	a5,124(a0)
    80009558:	00078863          	beqz	a5,80009568 <release+0x90>
    8000955c:	100027f3          	csrr	a5,sstatus
    80009560:	0027e793          	ori	a5,a5,2
    80009564:	10079073          	csrw	sstatus,a5
    80009568:	01813083          	ld	ra,24(sp)
    8000956c:	01013403          	ld	s0,16(sp)
    80009570:	00813483          	ld	s1,8(sp)
    80009574:	00013903          	ld	s2,0(sp)
    80009578:	02010113          	addi	sp,sp,32
    8000957c:	00008067          	ret
    80009580:	00001517          	auipc	a0,0x1
    80009584:	47850513          	addi	a0,a0,1144 # 8000a9f8 <digits+0x48>
    80009588:	fffff097          	auipc	ra,0xfffff
    8000958c:	154080e7          	jalr	340(ra) # 800086dc <panic>
    80009590:	00001517          	auipc	a0,0x1
    80009594:	45050513          	addi	a0,a0,1104 # 8000a9e0 <digits+0x30>
    80009598:	fffff097          	auipc	ra,0xfffff
    8000959c:	144080e7          	jalr	324(ra) # 800086dc <panic>

00000000800095a0 <holding>:
    800095a0:	00052783          	lw	a5,0(a0)
    800095a4:	00079663          	bnez	a5,800095b0 <holding+0x10>
    800095a8:	00000513          	li	a0,0
    800095ac:	00008067          	ret
    800095b0:	fe010113          	addi	sp,sp,-32
    800095b4:	00813823          	sd	s0,16(sp)
    800095b8:	00913423          	sd	s1,8(sp)
    800095bc:	00113c23          	sd	ra,24(sp)
    800095c0:	02010413          	addi	s0,sp,32
    800095c4:	01053483          	ld	s1,16(a0)
    800095c8:	ffffe097          	auipc	ra,0xffffe
    800095cc:	75c080e7          	jalr	1884(ra) # 80007d24 <mycpu>
    800095d0:	01813083          	ld	ra,24(sp)
    800095d4:	01013403          	ld	s0,16(sp)
    800095d8:	40a48533          	sub	a0,s1,a0
    800095dc:	00153513          	seqz	a0,a0
    800095e0:	00813483          	ld	s1,8(sp)
    800095e4:	02010113          	addi	sp,sp,32
    800095e8:	00008067          	ret

00000000800095ec <push_off>:
    800095ec:	fe010113          	addi	sp,sp,-32
    800095f0:	00813823          	sd	s0,16(sp)
    800095f4:	00113c23          	sd	ra,24(sp)
    800095f8:	00913423          	sd	s1,8(sp)
    800095fc:	02010413          	addi	s0,sp,32
    80009600:	100024f3          	csrr	s1,sstatus
    80009604:	100027f3          	csrr	a5,sstatus
    80009608:	ffd7f793          	andi	a5,a5,-3
    8000960c:	10079073          	csrw	sstatus,a5
    80009610:	ffffe097          	auipc	ra,0xffffe
    80009614:	714080e7          	jalr	1812(ra) # 80007d24 <mycpu>
    80009618:	07852783          	lw	a5,120(a0)
    8000961c:	02078663          	beqz	a5,80009648 <push_off+0x5c>
    80009620:	ffffe097          	auipc	ra,0xffffe
    80009624:	704080e7          	jalr	1796(ra) # 80007d24 <mycpu>
    80009628:	07852783          	lw	a5,120(a0)
    8000962c:	01813083          	ld	ra,24(sp)
    80009630:	01013403          	ld	s0,16(sp)
    80009634:	0017879b          	addiw	a5,a5,1
    80009638:	06f52c23          	sw	a5,120(a0)
    8000963c:	00813483          	ld	s1,8(sp)
    80009640:	02010113          	addi	sp,sp,32
    80009644:	00008067          	ret
    80009648:	0014d493          	srli	s1,s1,0x1
    8000964c:	ffffe097          	auipc	ra,0xffffe
    80009650:	6d8080e7          	jalr	1752(ra) # 80007d24 <mycpu>
    80009654:	0014f493          	andi	s1,s1,1
    80009658:	06952e23          	sw	s1,124(a0)
    8000965c:	fc5ff06f          	j	80009620 <push_off+0x34>

0000000080009660 <pop_off>:
    80009660:	ff010113          	addi	sp,sp,-16
    80009664:	00813023          	sd	s0,0(sp)
    80009668:	00113423          	sd	ra,8(sp)
    8000966c:	01010413          	addi	s0,sp,16
    80009670:	ffffe097          	auipc	ra,0xffffe
    80009674:	6b4080e7          	jalr	1716(ra) # 80007d24 <mycpu>
    80009678:	100027f3          	csrr	a5,sstatus
    8000967c:	0027f793          	andi	a5,a5,2
    80009680:	04079663          	bnez	a5,800096cc <pop_off+0x6c>
    80009684:	07852783          	lw	a5,120(a0)
    80009688:	02f05a63          	blez	a5,800096bc <pop_off+0x5c>
    8000968c:	fff7871b          	addiw	a4,a5,-1
    80009690:	06e52c23          	sw	a4,120(a0)
    80009694:	00071c63          	bnez	a4,800096ac <pop_off+0x4c>
    80009698:	07c52783          	lw	a5,124(a0)
    8000969c:	00078863          	beqz	a5,800096ac <pop_off+0x4c>
    800096a0:	100027f3          	csrr	a5,sstatus
    800096a4:	0027e793          	ori	a5,a5,2
    800096a8:	10079073          	csrw	sstatus,a5
    800096ac:	00813083          	ld	ra,8(sp)
    800096b0:	00013403          	ld	s0,0(sp)
    800096b4:	01010113          	addi	sp,sp,16
    800096b8:	00008067          	ret
    800096bc:	00001517          	auipc	a0,0x1
    800096c0:	33c50513          	addi	a0,a0,828 # 8000a9f8 <digits+0x48>
    800096c4:	fffff097          	auipc	ra,0xfffff
    800096c8:	018080e7          	jalr	24(ra) # 800086dc <panic>
    800096cc:	00001517          	auipc	a0,0x1
    800096d0:	31450513          	addi	a0,a0,788 # 8000a9e0 <digits+0x30>
    800096d4:	fffff097          	auipc	ra,0xfffff
    800096d8:	008080e7          	jalr	8(ra) # 800086dc <panic>

00000000800096dc <push_on>:
    800096dc:	fe010113          	addi	sp,sp,-32
    800096e0:	00813823          	sd	s0,16(sp)
    800096e4:	00113c23          	sd	ra,24(sp)
    800096e8:	00913423          	sd	s1,8(sp)
    800096ec:	02010413          	addi	s0,sp,32
    800096f0:	100024f3          	csrr	s1,sstatus
    800096f4:	100027f3          	csrr	a5,sstatus
    800096f8:	0027e793          	ori	a5,a5,2
    800096fc:	10079073          	csrw	sstatus,a5
    80009700:	ffffe097          	auipc	ra,0xffffe
    80009704:	624080e7          	jalr	1572(ra) # 80007d24 <mycpu>
    80009708:	07852783          	lw	a5,120(a0)
    8000970c:	02078663          	beqz	a5,80009738 <push_on+0x5c>
    80009710:	ffffe097          	auipc	ra,0xffffe
    80009714:	614080e7          	jalr	1556(ra) # 80007d24 <mycpu>
    80009718:	07852783          	lw	a5,120(a0)
    8000971c:	01813083          	ld	ra,24(sp)
    80009720:	01013403          	ld	s0,16(sp)
    80009724:	0017879b          	addiw	a5,a5,1
    80009728:	06f52c23          	sw	a5,120(a0)
    8000972c:	00813483          	ld	s1,8(sp)
    80009730:	02010113          	addi	sp,sp,32
    80009734:	00008067          	ret
    80009738:	0014d493          	srli	s1,s1,0x1
    8000973c:	ffffe097          	auipc	ra,0xffffe
    80009740:	5e8080e7          	jalr	1512(ra) # 80007d24 <mycpu>
    80009744:	0014f493          	andi	s1,s1,1
    80009748:	06952e23          	sw	s1,124(a0)
    8000974c:	fc5ff06f          	j	80009710 <push_on+0x34>

0000000080009750 <pop_on>:
    80009750:	ff010113          	addi	sp,sp,-16
    80009754:	00813023          	sd	s0,0(sp)
    80009758:	00113423          	sd	ra,8(sp)
    8000975c:	01010413          	addi	s0,sp,16
    80009760:	ffffe097          	auipc	ra,0xffffe
    80009764:	5c4080e7          	jalr	1476(ra) # 80007d24 <mycpu>
    80009768:	100027f3          	csrr	a5,sstatus
    8000976c:	0027f793          	andi	a5,a5,2
    80009770:	04078463          	beqz	a5,800097b8 <pop_on+0x68>
    80009774:	07852783          	lw	a5,120(a0)
    80009778:	02f05863          	blez	a5,800097a8 <pop_on+0x58>
    8000977c:	fff7879b          	addiw	a5,a5,-1
    80009780:	06f52c23          	sw	a5,120(a0)
    80009784:	07853783          	ld	a5,120(a0)
    80009788:	00079863          	bnez	a5,80009798 <pop_on+0x48>
    8000978c:	100027f3          	csrr	a5,sstatus
    80009790:	ffd7f793          	andi	a5,a5,-3
    80009794:	10079073          	csrw	sstatus,a5
    80009798:	00813083          	ld	ra,8(sp)
    8000979c:	00013403          	ld	s0,0(sp)
    800097a0:	01010113          	addi	sp,sp,16
    800097a4:	00008067          	ret
    800097a8:	00001517          	auipc	a0,0x1
    800097ac:	27850513          	addi	a0,a0,632 # 8000aa20 <digits+0x70>
    800097b0:	fffff097          	auipc	ra,0xfffff
    800097b4:	f2c080e7          	jalr	-212(ra) # 800086dc <panic>
    800097b8:	00001517          	auipc	a0,0x1
    800097bc:	24850513          	addi	a0,a0,584 # 8000aa00 <digits+0x50>
    800097c0:	fffff097          	auipc	ra,0xfffff
    800097c4:	f1c080e7          	jalr	-228(ra) # 800086dc <panic>

00000000800097c8 <__memset>:
    800097c8:	ff010113          	addi	sp,sp,-16
    800097cc:	00813423          	sd	s0,8(sp)
    800097d0:	01010413          	addi	s0,sp,16
    800097d4:	1a060e63          	beqz	a2,80009990 <__memset+0x1c8>
    800097d8:	40a007b3          	neg	a5,a0
    800097dc:	0077f793          	andi	a5,a5,7
    800097e0:	00778693          	addi	a3,a5,7
    800097e4:	00b00813          	li	a6,11
    800097e8:	0ff5f593          	andi	a1,a1,255
    800097ec:	fff6071b          	addiw	a4,a2,-1
    800097f0:	1b06e663          	bltu	a3,a6,8000999c <__memset+0x1d4>
    800097f4:	1cd76463          	bltu	a4,a3,800099bc <__memset+0x1f4>
    800097f8:	1a078e63          	beqz	a5,800099b4 <__memset+0x1ec>
    800097fc:	00b50023          	sb	a1,0(a0)
    80009800:	00100713          	li	a4,1
    80009804:	1ae78463          	beq	a5,a4,800099ac <__memset+0x1e4>
    80009808:	00b500a3          	sb	a1,1(a0)
    8000980c:	00200713          	li	a4,2
    80009810:	1ae78a63          	beq	a5,a4,800099c4 <__memset+0x1fc>
    80009814:	00b50123          	sb	a1,2(a0)
    80009818:	00300713          	li	a4,3
    8000981c:	18e78463          	beq	a5,a4,800099a4 <__memset+0x1dc>
    80009820:	00b501a3          	sb	a1,3(a0)
    80009824:	00400713          	li	a4,4
    80009828:	1ae78263          	beq	a5,a4,800099cc <__memset+0x204>
    8000982c:	00b50223          	sb	a1,4(a0)
    80009830:	00500713          	li	a4,5
    80009834:	1ae78063          	beq	a5,a4,800099d4 <__memset+0x20c>
    80009838:	00b502a3          	sb	a1,5(a0)
    8000983c:	00700713          	li	a4,7
    80009840:	18e79e63          	bne	a5,a4,800099dc <__memset+0x214>
    80009844:	00b50323          	sb	a1,6(a0)
    80009848:	00700e93          	li	t4,7
    8000984c:	00859713          	slli	a4,a1,0x8
    80009850:	00e5e733          	or	a4,a1,a4
    80009854:	01059e13          	slli	t3,a1,0x10
    80009858:	01c76e33          	or	t3,a4,t3
    8000985c:	01859313          	slli	t1,a1,0x18
    80009860:	006e6333          	or	t1,t3,t1
    80009864:	02059893          	slli	a7,a1,0x20
    80009868:	40f60e3b          	subw	t3,a2,a5
    8000986c:	011368b3          	or	a7,t1,a7
    80009870:	02859813          	slli	a6,a1,0x28
    80009874:	0108e833          	or	a6,a7,a6
    80009878:	03059693          	slli	a3,a1,0x30
    8000987c:	003e589b          	srliw	a7,t3,0x3
    80009880:	00d866b3          	or	a3,a6,a3
    80009884:	03859713          	slli	a4,a1,0x38
    80009888:	00389813          	slli	a6,a7,0x3
    8000988c:	00f507b3          	add	a5,a0,a5
    80009890:	00e6e733          	or	a4,a3,a4
    80009894:	000e089b          	sext.w	a7,t3
    80009898:	00f806b3          	add	a3,a6,a5
    8000989c:	00e7b023          	sd	a4,0(a5)
    800098a0:	00878793          	addi	a5,a5,8
    800098a4:	fed79ce3          	bne	a5,a3,8000989c <__memset+0xd4>
    800098a8:	ff8e7793          	andi	a5,t3,-8
    800098ac:	0007871b          	sext.w	a4,a5
    800098b0:	01d787bb          	addw	a5,a5,t4
    800098b4:	0ce88e63          	beq	a7,a4,80009990 <__memset+0x1c8>
    800098b8:	00f50733          	add	a4,a0,a5
    800098bc:	00b70023          	sb	a1,0(a4)
    800098c0:	0017871b          	addiw	a4,a5,1
    800098c4:	0cc77663          	bgeu	a4,a2,80009990 <__memset+0x1c8>
    800098c8:	00e50733          	add	a4,a0,a4
    800098cc:	00b70023          	sb	a1,0(a4)
    800098d0:	0027871b          	addiw	a4,a5,2
    800098d4:	0ac77e63          	bgeu	a4,a2,80009990 <__memset+0x1c8>
    800098d8:	00e50733          	add	a4,a0,a4
    800098dc:	00b70023          	sb	a1,0(a4)
    800098e0:	0037871b          	addiw	a4,a5,3
    800098e4:	0ac77663          	bgeu	a4,a2,80009990 <__memset+0x1c8>
    800098e8:	00e50733          	add	a4,a0,a4
    800098ec:	00b70023          	sb	a1,0(a4)
    800098f0:	0047871b          	addiw	a4,a5,4
    800098f4:	08c77e63          	bgeu	a4,a2,80009990 <__memset+0x1c8>
    800098f8:	00e50733          	add	a4,a0,a4
    800098fc:	00b70023          	sb	a1,0(a4)
    80009900:	0057871b          	addiw	a4,a5,5
    80009904:	08c77663          	bgeu	a4,a2,80009990 <__memset+0x1c8>
    80009908:	00e50733          	add	a4,a0,a4
    8000990c:	00b70023          	sb	a1,0(a4)
    80009910:	0067871b          	addiw	a4,a5,6
    80009914:	06c77e63          	bgeu	a4,a2,80009990 <__memset+0x1c8>
    80009918:	00e50733          	add	a4,a0,a4
    8000991c:	00b70023          	sb	a1,0(a4)
    80009920:	0077871b          	addiw	a4,a5,7
    80009924:	06c77663          	bgeu	a4,a2,80009990 <__memset+0x1c8>
    80009928:	00e50733          	add	a4,a0,a4
    8000992c:	00b70023          	sb	a1,0(a4)
    80009930:	0087871b          	addiw	a4,a5,8
    80009934:	04c77e63          	bgeu	a4,a2,80009990 <__memset+0x1c8>
    80009938:	00e50733          	add	a4,a0,a4
    8000993c:	00b70023          	sb	a1,0(a4)
    80009940:	0097871b          	addiw	a4,a5,9
    80009944:	04c77663          	bgeu	a4,a2,80009990 <__memset+0x1c8>
    80009948:	00e50733          	add	a4,a0,a4
    8000994c:	00b70023          	sb	a1,0(a4)
    80009950:	00a7871b          	addiw	a4,a5,10
    80009954:	02c77e63          	bgeu	a4,a2,80009990 <__memset+0x1c8>
    80009958:	00e50733          	add	a4,a0,a4
    8000995c:	00b70023          	sb	a1,0(a4)
    80009960:	00b7871b          	addiw	a4,a5,11
    80009964:	02c77663          	bgeu	a4,a2,80009990 <__memset+0x1c8>
    80009968:	00e50733          	add	a4,a0,a4
    8000996c:	00b70023          	sb	a1,0(a4)
    80009970:	00c7871b          	addiw	a4,a5,12
    80009974:	00c77e63          	bgeu	a4,a2,80009990 <__memset+0x1c8>
    80009978:	00e50733          	add	a4,a0,a4
    8000997c:	00b70023          	sb	a1,0(a4)
    80009980:	00d7879b          	addiw	a5,a5,13
    80009984:	00c7f663          	bgeu	a5,a2,80009990 <__memset+0x1c8>
    80009988:	00f507b3          	add	a5,a0,a5
    8000998c:	00b78023          	sb	a1,0(a5)
    80009990:	00813403          	ld	s0,8(sp)
    80009994:	01010113          	addi	sp,sp,16
    80009998:	00008067          	ret
    8000999c:	00b00693          	li	a3,11
    800099a0:	e55ff06f          	j	800097f4 <__memset+0x2c>
    800099a4:	00300e93          	li	t4,3
    800099a8:	ea5ff06f          	j	8000984c <__memset+0x84>
    800099ac:	00100e93          	li	t4,1
    800099b0:	e9dff06f          	j	8000984c <__memset+0x84>
    800099b4:	00000e93          	li	t4,0
    800099b8:	e95ff06f          	j	8000984c <__memset+0x84>
    800099bc:	00000793          	li	a5,0
    800099c0:	ef9ff06f          	j	800098b8 <__memset+0xf0>
    800099c4:	00200e93          	li	t4,2
    800099c8:	e85ff06f          	j	8000984c <__memset+0x84>
    800099cc:	00400e93          	li	t4,4
    800099d0:	e7dff06f          	j	8000984c <__memset+0x84>
    800099d4:	00500e93          	li	t4,5
    800099d8:	e75ff06f          	j	8000984c <__memset+0x84>
    800099dc:	00600e93          	li	t4,6
    800099e0:	e6dff06f          	j	8000984c <__memset+0x84>

00000000800099e4 <__memmove>:
    800099e4:	ff010113          	addi	sp,sp,-16
    800099e8:	00813423          	sd	s0,8(sp)
    800099ec:	01010413          	addi	s0,sp,16
    800099f0:	0e060863          	beqz	a2,80009ae0 <__memmove+0xfc>
    800099f4:	fff6069b          	addiw	a3,a2,-1
    800099f8:	0006881b          	sext.w	a6,a3
    800099fc:	0ea5e863          	bltu	a1,a0,80009aec <__memmove+0x108>
    80009a00:	00758713          	addi	a4,a1,7
    80009a04:	00a5e7b3          	or	a5,a1,a0
    80009a08:	40a70733          	sub	a4,a4,a0
    80009a0c:	0077f793          	andi	a5,a5,7
    80009a10:	00f73713          	sltiu	a4,a4,15
    80009a14:	00174713          	xori	a4,a4,1
    80009a18:	0017b793          	seqz	a5,a5
    80009a1c:	00e7f7b3          	and	a5,a5,a4
    80009a20:	10078863          	beqz	a5,80009b30 <__memmove+0x14c>
    80009a24:	00900793          	li	a5,9
    80009a28:	1107f463          	bgeu	a5,a6,80009b30 <__memmove+0x14c>
    80009a2c:	0036581b          	srliw	a6,a2,0x3
    80009a30:	fff8081b          	addiw	a6,a6,-1
    80009a34:	02081813          	slli	a6,a6,0x20
    80009a38:	01d85893          	srli	a7,a6,0x1d
    80009a3c:	00858813          	addi	a6,a1,8
    80009a40:	00058793          	mv	a5,a1
    80009a44:	00050713          	mv	a4,a0
    80009a48:	01088833          	add	a6,a7,a6
    80009a4c:	0007b883          	ld	a7,0(a5)
    80009a50:	00878793          	addi	a5,a5,8
    80009a54:	00870713          	addi	a4,a4,8
    80009a58:	ff173c23          	sd	a7,-8(a4)
    80009a5c:	ff0798e3          	bne	a5,a6,80009a4c <__memmove+0x68>
    80009a60:	ff867713          	andi	a4,a2,-8
    80009a64:	02071793          	slli	a5,a4,0x20
    80009a68:	0207d793          	srli	a5,a5,0x20
    80009a6c:	00f585b3          	add	a1,a1,a5
    80009a70:	40e686bb          	subw	a3,a3,a4
    80009a74:	00f507b3          	add	a5,a0,a5
    80009a78:	06e60463          	beq	a2,a4,80009ae0 <__memmove+0xfc>
    80009a7c:	0005c703          	lbu	a4,0(a1)
    80009a80:	00e78023          	sb	a4,0(a5)
    80009a84:	04068e63          	beqz	a3,80009ae0 <__memmove+0xfc>
    80009a88:	0015c603          	lbu	a2,1(a1)
    80009a8c:	00100713          	li	a4,1
    80009a90:	00c780a3          	sb	a2,1(a5)
    80009a94:	04e68663          	beq	a3,a4,80009ae0 <__memmove+0xfc>
    80009a98:	0025c603          	lbu	a2,2(a1)
    80009a9c:	00200713          	li	a4,2
    80009aa0:	00c78123          	sb	a2,2(a5)
    80009aa4:	02e68e63          	beq	a3,a4,80009ae0 <__memmove+0xfc>
    80009aa8:	0035c603          	lbu	a2,3(a1)
    80009aac:	00300713          	li	a4,3
    80009ab0:	00c781a3          	sb	a2,3(a5)
    80009ab4:	02e68663          	beq	a3,a4,80009ae0 <__memmove+0xfc>
    80009ab8:	0045c603          	lbu	a2,4(a1)
    80009abc:	00400713          	li	a4,4
    80009ac0:	00c78223          	sb	a2,4(a5)
    80009ac4:	00e68e63          	beq	a3,a4,80009ae0 <__memmove+0xfc>
    80009ac8:	0055c603          	lbu	a2,5(a1)
    80009acc:	00500713          	li	a4,5
    80009ad0:	00c782a3          	sb	a2,5(a5)
    80009ad4:	00e68663          	beq	a3,a4,80009ae0 <__memmove+0xfc>
    80009ad8:	0065c703          	lbu	a4,6(a1)
    80009adc:	00e78323          	sb	a4,6(a5)
    80009ae0:	00813403          	ld	s0,8(sp)
    80009ae4:	01010113          	addi	sp,sp,16
    80009ae8:	00008067          	ret
    80009aec:	02061713          	slli	a4,a2,0x20
    80009af0:	02075713          	srli	a4,a4,0x20
    80009af4:	00e587b3          	add	a5,a1,a4
    80009af8:	f0f574e3          	bgeu	a0,a5,80009a00 <__memmove+0x1c>
    80009afc:	02069613          	slli	a2,a3,0x20
    80009b00:	02065613          	srli	a2,a2,0x20
    80009b04:	fff64613          	not	a2,a2
    80009b08:	00e50733          	add	a4,a0,a4
    80009b0c:	00c78633          	add	a2,a5,a2
    80009b10:	fff7c683          	lbu	a3,-1(a5)
    80009b14:	fff78793          	addi	a5,a5,-1
    80009b18:	fff70713          	addi	a4,a4,-1
    80009b1c:	00d70023          	sb	a3,0(a4)
    80009b20:	fec798e3          	bne	a5,a2,80009b10 <__memmove+0x12c>
    80009b24:	00813403          	ld	s0,8(sp)
    80009b28:	01010113          	addi	sp,sp,16
    80009b2c:	00008067          	ret
    80009b30:	02069713          	slli	a4,a3,0x20
    80009b34:	02075713          	srli	a4,a4,0x20
    80009b38:	00170713          	addi	a4,a4,1
    80009b3c:	00e50733          	add	a4,a0,a4
    80009b40:	00050793          	mv	a5,a0
    80009b44:	0005c683          	lbu	a3,0(a1)
    80009b48:	00178793          	addi	a5,a5,1
    80009b4c:	00158593          	addi	a1,a1,1
    80009b50:	fed78fa3          	sb	a3,-1(a5)
    80009b54:	fee798e3          	bne	a5,a4,80009b44 <__memmove+0x160>
    80009b58:	f89ff06f          	j	80009ae0 <__memmove+0xfc>
	...
