
kernel:     file format elf64-littleriscv


Disassembly of section .text:

0000000080000000 <_entry>:
    80000000:	0000d117          	auipc	sp,0xd
    80000004:	c1813103          	ld	sp,-1000(sp) # 8000cc18 <_GLOBAL_OFFSET_TABLE_+0x38>
    80000008:	00001537          	lui	a0,0x1
    8000000c:	f14025f3          	csrr	a1,mhartid
    80000010:	00158593          	addi	a1,a1,1
    80000014:	02b50533          	mul	a0,a0,a1
    80000018:	00a10133          	add	sp,sp,a0
    8000001c:	1c1070ef          	jal	ra,800079dc <start>

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
    800010c8:	0a5020ef          	jal	ra,8000396c <handleInterrupt>

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
    800011d4:	498020ef          	jal	ra,8000366c <handleEcall>
    
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
    800012a0:	398080e7          	jalr	920(ra) # 80003634 <_Z12kern_syscall13SyscallNumberz>
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
    800012dc:	35c080e7          	jalr	860(ra) # 80003634 <_Z12kern_syscall13SyscallNumberz>
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
    80001350:	2e8080e7          	jalr	744(ra) # 80003634 <_Z12kern_syscall13SyscallNumberz>
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
    800013a0:	298080e7          	jalr	664(ra) # 80003634 <_Z12kern_syscall13SyscallNumberz>
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
    800013cc:	8387b783          	ld	a5,-1992(a5) # 8000cc00 <_GLOBAL_OFFSET_TABLE_+0x20>
    800013d0:	0007b783          	ld	a5,0(a5)
    800013d4:	0407b483          	ld	s1,64(a5)
    kern_syscall(THREAD_EXIT);
    800013d8:	01200513          	li	a0,18
    800013dc:	00002097          	auipc	ra,0x2
    800013e0:	258080e7          	jalr	600(ra) # 80003634 <_Z12kern_syscall13SyscallNumberz>
    kern_syscall(MEM_FREE,stack);
    800013e4:	00048593          	mv	a1,s1
    800013e8:	00200513          	li	a0,2
    800013ec:	00002097          	auipc	ra,0x2
    800013f0:	248080e7          	jalr	584(ra) # 80003634 <_Z12kern_syscall13SyscallNumberz>
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
    80001428:	210080e7          	jalr	528(ra) # 80003634 <_Z12kern_syscall13SyscallNumberz>
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
    8000145c:	1dc080e7          	jalr	476(ra) # 80003634 <_Z12kern_syscall13SyscallNumberz>
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
    8000149c:	19c080e7          	jalr	412(ra) # 80003634 <_Z12kern_syscall13SyscallNumberz>
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
    800014dc:	15c080e7          	jalr	348(ra) # 80003634 <_Z12kern_syscall13SyscallNumberz>
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
    8000151c:	11c080e7          	jalr	284(ra) # 80003634 <_Z12kern_syscall13SyscallNumberz>
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
    8000155c:	0dc080e7          	jalr	220(ra) # 80003634 <_Z12kern_syscall13SyscallNumberz>
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
    8000158c:	0ac080e7          	jalr	172(ra) # 80003634 <_Z12kern_syscall13SyscallNumberz>
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
    800015cc:	06c080e7          	jalr	108(ra) # 80003634 <_Z12kern_syscall13SyscallNumberz>
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
    800015f8:	67c4b483          	ld	s1,1660(s1) # 8000cc70 <bba_allocatedBlocks>
    while (curr){
    800015fc:	04048263          	beqz	s1,80001640 <_Z26bba_print_used_blocks_infov+0x60>
        printf("\nBlock of size %d is allocated on addr start+%lx and its descriptor is located at start+%lx (%lx), ends at start+%lx", curr->n, curr->addr-buddyMemStart, (char*)curr-buddyMemStart,curr,curr->addr-buddyMemStart+(1<<curr->n));
    80001600:	0084a583          	lw	a1,8(s1)
    80001604:	0104b603          	ld	a2,16(s1)
    80001608:	0000b697          	auipc	a3,0xb
    8000160c:	6706b683          	ld	a3,1648(a3) # 8000cc78 <buddyMemStart>
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
    80001690:	5ec6b683          	ld	a3,1516(a3) # 8000cc78 <buddyMemStart>
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
    800016d0:	5a478793          	addi	a5,a5,1444 # 8000cc70 <bba_allocatedBlocks>
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
    8000175c:	51878793          	addi	a5,a5,1304 # 8000cc70 <bba_allocatedBlocks>
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
    80001790:	4e470713          	addi	a4,a4,1252 # 8000cc70 <bba_allocatedBlocks>
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
    800017dc:	49870713          	addi	a4,a4,1176 # 8000cc70 <bba_allocatedBlocks>
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
    80001844:	43078793          	addi	a5,a5,1072 # 8000cc70 <bba_allocatedBlocks>
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
    8000185c:	41868693          	addi	a3,a3,1048 # 8000cc70 <bba_allocatedBlocks>
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
    80001938:	33c78793          	addi	a5,a5,828 # 8000cc70 <bba_allocatedBlocks>
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
    80001974:	30078793          	addi	a5,a5,768 # 8000cc70 <bba_allocatedBlocks>
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
    800019ac:	2c878793          	addi	a5,a5,712 # 8000cc70 <bba_allocatedBlocks>
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
    800019d0:	2a470713          	addi	a4,a4,676 # 8000cc70 <bba_allocatedBlocks>
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
    80001a14:	26068693          	addi	a3,a3,608 # 8000cc70 <bba_allocatedBlocks>
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
    80001af8:	17c98993          	addi	s3,s3,380 # 8000cc70 <bba_allocatedBlocks>
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
    80001b74:	10070713          	addi	a4,a4,256 # 8000cc70 <bba_allocatedBlocks>
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
    80001bcc:	0a878793          	addi	a5,a5,168 # 8000cc70 <bba_allocatedBlocks>
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
    80001be8:	08c78793          	addi	a5,a5,140 # 8000cc70 <bba_allocatedBlocks>
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
    80001c88:	fec78793          	addi	a5,a5,-20 # 8000cc70 <bba_allocatedBlocks>
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
    80001cc8:	fac53503          	ld	a0,-84(a0) # 8000cc70 <bba_allocatedBlocks>
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
    80001cfc:	f787b783          	ld	a5,-136(a5) # 8000cc70 <bba_allocatedBlocks>
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
    80001d34:	f4f73023          	sd	a5,-192(a4) # 8000cc70 <bba_allocatedBlocks>
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
    80001e04:	ba070713          	addi	a4,a4,-1120 # 8000c9a0 <digits>
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
    80001ec8:	adc78793          	addi	a5,a5,-1316 # 8000c9a0 <digits>
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
    80001f24:	df850513          	addi	a0,a0,-520 # 8000cd18 <lockPrint>
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
    80001f64:	db850513          	addi	a0,a0,-584 # 8000cd18 <lockPrint>
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
    80001fbc:	d6050513          	addi	a0,a0,-672 # 8000cd18 <lockPrint>
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
    8000202c:	cf050513          	addi	a0,a0,-784 # 8000cd18 <lockPrint>
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
    800020e4:	c3850513          	addi	a0,a0,-968 # 8000cd18 <lockPrint>
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
    8000212c:	0000b717          	auipc	a4,0xb
    80002130:	87470713          	addi	a4,a4,-1932 # 8000c9a0 <digits>
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
    800021a4:	b7850513          	addi	a0,a0,-1160 # 8000cd18 <lockPrint>
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
    800021f8:	b2450513          	addi	a0,a0,-1244 # 8000cd18 <lockPrint>
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
    80002240:	76478793          	addi	a5,a5,1892 # 8000c9a0 <digits>
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
    8000226c:	ab050513          	addi	a0,a0,-1360 # 8000cd18 <lockPrint>
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
    800022dc:	a4050513          	addi	a0,a0,-1472 # 8000cd18 <lockPrint>
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
    80002434:	8e850513          	addi	a0,a0,-1816 # 8000cd18 <lockPrint>
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
    80002474:	8b05b583          	ld	a1,-1872(a1) # 8000cd20 <freeHead>
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
    800024a8:	0000b697          	auipc	a3,0xb
    800024ac:	86f6bc23          	sd	a5,-1928(a3) # 8000cd20 <freeHead>
    800024b0:	fe1ff06f          	j	80002490 <_Z14kern_mem_alloci+0x30>
            if(curr==freeHead) freeHead=newFreeBlock;
    800024b4:	0000b797          	auipc	a5,0xb
    800024b8:	86b7b623          	sd	a1,-1940(a5) # 8000cd20 <freeHead>
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
    80002508:	0000b797          	auipc	a5,0xb
    8000250c:	8187b783          	ld	a5,-2024(a5) # 8000cd20 <freeHead>
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
    80002538:	7ec7b783          	ld	a5,2028(a5) # 8000cd20 <freeHead>
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
    800025b4:	76e6b823          	sd	a4,1904(a3) # 8000cd20 <freeHead>
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
    80002608:	71c78793          	addi	a5,a5,1820 # 8000cd20 <freeHead>
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
    80002650:	6e478793          	addi	a5,a5,1764 # 8000dd30 <kthreads+0x7d0>
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
    8000267c:	5787b783          	ld	a5,1400(a5) # 8000cbf0 <_GLOBAL_OFFSET_TABLE_+0x10>
    80002680:	0007b783          	ld	a5,0(a5)
    80002684:	0007c783          	lbu	a5,0(a5)
    80002688:	0017f793          	andi	a5,a5,1
    8000268c:	02078263          	beqz	a5,800026b0 <_Z12uart_getcharv+0x44>
        // input data is ready.
        return ReadReg(CONSOLE_RX_DATA);
    80002690:	0000a797          	auipc	a5,0xa
    80002694:	5587b783          	ld	a5,1368(a5) # 8000cbe8 <_GLOBAL_OFFSET_TABLE_+0x8>
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
    800026c8:	66c70713          	addi	a4,a4,1644 # 8000dd30 <kthreads+0x7d0>
    800026cc:	80872783          	lw	a5,-2040(a4)
    800026d0:	80c72703          	lw	a4,-2036(a4)
    800026d4:	06e78063          	beq	a5,a4,80002734 <_Z12uart_putcharv+0x7c>

    if((ReadReg(CONSOLE_STATUS) & CONSOLE_TX_STATUS_BIT) == 0){
    800026d8:	0000a717          	auipc	a4,0xa
    800026dc:	51873703          	ld	a4,1304(a4) # 8000cbf0 <_GLOBAL_OFFSET_TABLE_+0x10>
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
    800026fc:	e4e6a023          	sw	a4,-448(a3) # 8000d538 <console+0x808>
    80002700:	41f7d71b          	sraiw	a4,a5,0x1f
    80002704:	0167571b          	srliw	a4,a4,0x16
    80002708:	00f707bb          	addw	a5,a4,a5
    8000270c:	3ff7f793          	andi	a5,a5,1023
    80002710:	40e787bb          	subw	a5,a5,a4
    80002714:	0000a717          	auipc	a4,0xa
    80002718:	61c70713          	addi	a4,a4,1564 # 8000cd30 <console>
    8000271c:	00f707b3          	add	a5,a4,a5
    80002720:	4007c703          	lbu	a4,1024(a5)
    WriteReg(CONSOLE_TX_DATA,c);
    80002724:	0000a797          	auipc	a5,0xa
    80002728:	4ec7b783          	ld	a5,1260(a5) # 8000cc10 <_GLOBAL_OFFSET_TABLE_+0x30>
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
    80002764:	5d070713          	addi	a4,a4,1488 # 8000dd30 <kthreads+0x7d0>
    80002768:	80472783          	lw	a5,-2044(a4)
    8000276c:	0017869b          	addiw	a3,a5,1
    80002770:	80d72223          	sw	a3,-2044(a4)
    80002774:	41f7d71b          	sraiw	a4,a5,0x1f
    80002778:	0167571b          	srliw	a4,a4,0x16
    8000277c:	00f707bb          	addw	a5,a4,a5
    80002780:	3ff7f793          	andi	a5,a5,1023
    80002784:	40e787bb          	subw	a5,a5,a4
    80002788:	0000a717          	auipc	a4,0xa
    8000278c:	5a870713          	addi	a4,a4,1448 # 8000cd30 <console>
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
    800027c4:	57070713          	addi	a4,a4,1392 # 8000dd30 <kthreads+0x7d0>
    800027c8:	80072783          	lw	a5,-2048(a4)
    800027cc:	80472703          	lw	a4,-2044(a4)
    800027d0:	04e7d063          	bge	a5,a4,80002810 <_Z20kern_console_getcharv+0x5c>
        return console.input[(console.input_r++)%BUFFER_SIZE];
    800027d4:	0017871b          	addiw	a4,a5,1
    800027d8:	0000b697          	auipc	a3,0xb
    800027dc:	d4e6ac23          	sw	a4,-680(a3) # 8000d530 <console+0x800>
    800027e0:	41f7d71b          	sraiw	a4,a5,0x1f
    800027e4:	0167571b          	srliw	a4,a4,0x16
    800027e8:	00f707bb          	addw	a5,a4,a5
    800027ec:	3ff7f793          	andi	a5,a5,1023
    800027f0:	40e787bb          	subw	a5,a5,a4
    800027f4:	0000a717          	auipc	a4,0xa
    800027f8:	53c70713          	addi	a4,a4,1340 # 8000cd30 <console>
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
    80002828:	3cc7b783          	ld	a5,972(a5) # 8000cbf0 <_GLOBAL_OFFSET_TABLE_+0x10>
    8000282c:	0007b783          	ld	a5,0(a5)
    80002830:	0007c783          	lbu	a5,0(a5)
    80002834:	0ff7f793          	andi	a5,a5,255
    80002838:	0207f793          	andi	a5,a5,32
    8000283c:	02078263          	beqz	a5,80002860 <_Z20kern_console_putcharc+0x48>
        WriteReg(CONSOLE_TX_DATA,c);
    80002840:	0000a797          	auipc	a5,0xa
    80002844:	3d07b783          	ld	a5,976(a5) # 8000cc10 <_GLOBAL_OFFSET_TABLE_+0x30>
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
    80002864:	4d078793          	addi	a5,a5,1232 # 8000dd30 <kthreads+0x7d0>
    80002868:	8087a703          	lw	a4,-2040(a5)
    8000286c:	80c7a783          	lw	a5,-2036(a5)
    80002870:	40f7073b          	subw	a4,a4,a5
    80002874:	3ff00693          	li	a3,1023
    80002878:	02e6ce63          	blt	a3,a4,800028b4 <_Z20kern_console_putcharc+0x9c>
        console.output[(console.output_w++)%BUFFER_SIZE]=c;
    8000287c:	0017871b          	addiw	a4,a5,1
    80002880:	0000b697          	auipc	a3,0xb
    80002884:	cae6ae23          	sw	a4,-836(a3) # 8000d53c <console+0x80c>
    80002888:	41f7d71b          	sraiw	a4,a5,0x1f
    8000288c:	0167571b          	srliw	a4,a4,0x16
    80002890:	00f707bb          	addw	a5,a4,a5
    80002894:	3ff7f793          	andi	a5,a5,1023
    80002898:	40e787bb          	subw	a5,a5,a4
    8000289c:	0000a717          	auipc	a4,0xa
    800028a0:	49470713          	addi	a4,a4,1172 # 8000cd30 <console>
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
    800028c0:	0fc7a783          	lw	a5,252(a5) # 8000c9b8 <idleAlive>
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
    800028e4:	0d87a783          	lw	a5,216(a5) # 8000c9b8 <idleAlive>
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
    80002a00:	b4468693          	addi	a3,a3,-1212 # 8000d540 <g>
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
    80002a3c:	f8078793          	addi	a5,a5,-128 # 8000c9b8 <idleAlive>
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
    80002a5c:	af07b783          	ld	a5,-1296(a5) # 8000d548 <semTest>
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
    80002a80:	fc010113          	addi	sp,sp,-64
    80002a84:	02113c23          	sd	ra,56(sp)
    80002a88:	02813823          	sd	s0,48(sp)
    80002a8c:	02913423          	sd	s1,40(sp)
    80002a90:	03213023          	sd	s2,32(sp)
    80002a94:	01313c23          	sd	s3,24(sp)
    80002a98:	04010413          	addi	s0,sp,64
    kern_thread_init();
    80002a9c:	00000097          	auipc	ra,0x0
    80002aa0:	378080e7          	jalr	888(ra) # 80002e14 <_Z16kern_thread_initv>

    kern_mem_init((void*)HEAP_START_ADDR, (void*)HEAP_END_ADDR);
    80002aa4:	0000a917          	auipc	s2,0xa
    80002aa8:	17c93903          	ld	s2,380(s2) # 8000cc20 <_GLOBAL_OFFSET_TABLE_+0x40>
    80002aac:	0000a497          	auipc	s1,0xa
    80002ab0:	14c4b483          	ld	s1,332(s1) # 8000cbf8 <_GLOBAL_OFFSET_TABLE_+0x18>
    80002ab4:	00093583          	ld	a1,0(s2)
    80002ab8:	0004b503          	ld	a0,0(s1)
    80002abc:	00000097          	auipc	ra,0x0
    80002ac0:	b18080e7          	jalr	-1256(ra) # 800025d4 <_Z13kern_mem_initPvS_>
    kern_interrupt_init();
    80002ac4:	00001097          	auipc	ra,0x1
    80002ac8:	b3c080e7          	jalr	-1220(ra) # 80003600 <_Z19kern_interrupt_initv>
    kern_sem_init();
    80002acc:	00001097          	auipc	ra,0x1
    80002ad0:	920080e7          	jalr	-1760(ra) # 800033ec <_Z13kern_sem_initv>
    kern_console_init();
    80002ad4:	00000097          	auipc	ra,0x0
    80002ad8:	b6c080e7          	jalr	-1172(ra) # 80002640 <_Z17kern_console_initv>

    Thread* thrIdle = new Thread(&bodyIdle,0);
    80002adc:	02000513          	li	a0,32
    80002ae0:	00000097          	auipc	ra,0x0
    80002ae4:	2e4080e7          	jalr	740(ra) # 80002dc4 <_Znwm>
        {
    80002ae8:	0000a717          	auipc	a4,0xa
    80002aec:	ef870713          	addi	a4,a4,-264 # 8000c9e0 <_ZTV6Thread+0x10>
    80002af0:	00e53023          	sd	a4,0(a0)
            this->body=body;
    80002af4:	00000717          	auipc	a4,0x0
    80002af8:	dc870713          	addi	a4,a4,-568 # 800028bc <_Z8bodyIdlePv>
    80002afc:	00e53823          	sd	a4,16(a0)
            this->arg=arg;
    80002b00:	00053c23          	sd	zero,24(a0)
    80002b04:	fca43423          	sd	a0,-56(s0)
    thrIdle->start();
    80002b08:	00000097          	auipc	ra,0x0
    80002b0c:	268080e7          	jalr	616(ra) # 80002d70 <_ZN6Thread5startEv>

    printf("Printf proba %d valjda radi %x, %p\n", &thrIdle, &thrIdle, &thrIdle);
    80002b10:	fc840593          	addi	a1,s0,-56
    80002b14:	00058693          	mv	a3,a1
    80002b18:	00058613          	mv	a2,a1
    80002b1c:	00007517          	auipc	a0,0x7
    80002b20:	68c50513          	addi	a0,a0,1676 # 8000a1a8 <CONSOLE_STATUS+0x198>
    80002b24:	fffff097          	auipc	ra,0xfffff
    80002b28:	770080e7          	jalr	1904(ra) # 80002294 <_Z6printfPKcz>
    bba_init((char*)HEAP_START_ADDR, (char*)HEAP_END_ADDR);
    80002b2c:	00093583          	ld	a1,0(s2)
    80002b30:	0004b503          	ld	a0,0(s1)
    80002b34:	fffff097          	auipc	ra,0xfffff
    80002b38:	bc4080e7          	jalr	-1084(ra) # 800016f8 <_Z8bba_initPcS_>
    x++;
    putc(x);*/
//    userMain();


    PeriodicTest* pt = new PeriodicTest(30, 'A');
    80002b3c:	03800513          	li	a0,56
    80002b40:	00000097          	auipc	ra,0x0
    80002b44:	284080e7          	jalr	644(ra) # 80002dc4 <_Znwm>
    80002b48:	00050993          	mv	s3,a0
            body= nullptr;
    80002b4c:	00053823          	sd	zero,16(a0)
            arg= nullptr;
    80002b50:	00053c23          	sd	zero,24(a0)
        this->period=period;
    80002b54:	01e00793          	li	a5,30
    80002b58:	02f53423          	sd	a5,40(a0)
        this->isThisPeriodicThreadTereminated=0;
    80002b5c:	02052023          	sw	zero,32(a0)
    PeriodicTest(uint64 period, char c) : PeriodicThread(period){
    80002b60:	0000a497          	auipc	s1,0xa
    80002b64:	ea848493          	addi	s1,s1,-344 # 8000ca08 <_ZTV12PeriodicTest+0x10>
    80002b68:	00953023          	sd	s1,0(a0)
        this->c = c;
    80002b6c:	04100793          	li	a5,65
    80002b70:	02f50823          	sb	a5,48(a0)
    PeriodicTest* pt2 = new PeriodicTest(10, 'a');
    80002b74:	03800513          	li	a0,56
    80002b78:	00000097          	auipc	ra,0x0
    80002b7c:	24c080e7          	jalr	588(ra) # 80002dc4 <_Znwm>
    80002b80:	00050913          	mv	s2,a0
            body= nullptr;
    80002b84:	00053823          	sd	zero,16(a0)
            arg= nullptr;
    80002b88:	00053c23          	sd	zero,24(a0)
        this->period=period;
    80002b8c:	00a00793          	li	a5,10
    80002b90:	02f53423          	sd	a5,40(a0)
        this->isThisPeriodicThreadTereminated=0;
    80002b94:	02052023          	sw	zero,32(a0)
    PeriodicTest(uint64 period, char c) : PeriodicThread(period){
    80002b98:	00953023          	sd	s1,0(a0)
        this->c = c;
    80002b9c:	06100793          	li	a5,97
    80002ba0:	02f50823          	sb	a5,48(a0)
    pt->start();
    80002ba4:	00098513          	mv	a0,s3
    80002ba8:	00000097          	auipc	ra,0x0
    80002bac:	1c8080e7          	jalr	456(ra) # 80002d70 <_ZN6Thread5startEv>
    pt2->start();
    80002bb0:	00090513          	mv	a0,s2
    80002bb4:	00000097          	auipc	ra,0x0
    80002bb8:	1bc080e7          	jalr	444(ra) # 80002d70 <_ZN6Thread5startEv>
    putc('E');
    80002bbc:	04500513          	li	a0,69
    80002bc0:	fffff097          	auipc	ra,0xfffff
    80002bc4:	9f0080e7          	jalr	-1552(ra) # 800015b0 <_Z4putcc>
    char x = 'm';
    80002bc8:	06d00493          	li	s1,109
    while (x!='x'){
    80002bcc:	07800793          	li	a5,120
    80002bd0:	00f48e63          	beq	s1,a5,80002bec <main+0x16c>
        x=getc();
    80002bd4:	fffff097          	auipc	ra,0xfffff
    80002bd8:	9a0080e7          	jalr	-1632(ra) # 80001574 <_Z4getcv>
    80002bdc:	00050493          	mv	s1,a0
        putc(x);
    80002be0:	fffff097          	auipc	ra,0xfffff
    80002be4:	9d0080e7          	jalr	-1584(ra) # 800015b0 <_Z4putcc>
    80002be8:	fe5ff06f          	j	80002bcc <main+0x14c>
        isThisPeriodicThreadTereminated=1;
    80002bec:	00100793          	li	a5,1
    80002bf0:	02f9a023          	sw	a5,32(s3)
    80002bf4:	02f92023          	sw	a5,32(s2)
    }

    pt->terminate();
    pt2->terminate();
    idleAlive=0;
    80002bf8:	0000a797          	auipc	a5,0xa
    80002bfc:	dc07a023          	sw	zero,-576(a5) # 8000c9b8 <idleAlive>
    return 0;
    80002c00:	00000513          	li	a0,0
    80002c04:	03813083          	ld	ra,56(sp)
    80002c08:	03013403          	ld	s0,48(sp)
    80002c0c:	02813483          	ld	s1,40(sp)
    80002c10:	02013903          	ld	s2,32(sp)
    80002c14:	01813983          	ld	s3,24(sp)
    80002c18:	04010113          	addi	sp,sp,64
    80002c1c:	00008067          	ret

0000000080002c20 <_ZN6ThreadD1Ev>:
        virtual ~Thread (){
    80002c20:	ff010113          	addi	sp,sp,-16
    80002c24:	00813423          	sd	s0,8(sp)
    80002c28:	01010413          	addi	s0,sp,16
        }
    80002c2c:	00813403          	ld	s0,8(sp)
    80002c30:	01010113          	addi	sp,sp,16
    80002c34:	00008067          	ret

0000000080002c38 <_ZN6Thread3runEv>:
        virtual void run () {}
    80002c38:	ff010113          	addi	sp,sp,-16
    80002c3c:	00813423          	sd	s0,8(sp)
    80002c40:	01010413          	addi	s0,sp,16
    80002c44:	00813403          	ld	s0,8(sp)
    80002c48:	01010113          	addi	sp,sp,16
    80002c4c:	00008067          	ret

0000000080002c50 <_ZN6Thread11threadEntryEPv>:
        static void threadEntry(void* arg){
    80002c50:	ff010113          	addi	sp,sp,-16
    80002c54:	00113423          	sd	ra,8(sp)
    80002c58:	00813023          	sd	s0,0(sp)
    80002c5c:	01010413          	addi	s0,sp,16
            self->run();
    80002c60:	00053783          	ld	a5,0(a0)
    80002c64:	0107b783          	ld	a5,16(a5)
    80002c68:	000780e7          	jalr	a5
        }
    80002c6c:	00813083          	ld	ra,8(sp)
    80002c70:	00013403          	ld	s0,0(sp)
    80002c74:	01010113          	addi	sp,sp,16
    80002c78:	00008067          	ret

0000000080002c7c <_ZN12PeriodicTestD1Ev>:
class PeriodicTest : public PeriodicThread {
    80002c7c:	ff010113          	addi	sp,sp,-16
    80002c80:	00813423          	sd	s0,8(sp)
    80002c84:	01010413          	addi	s0,sp,16
    80002c88:	00813403          	ld	s0,8(sp)
    80002c8c:	01010113          	addi	sp,sp,16
    80002c90:	00008067          	ret

0000000080002c94 <_ZN12PeriodicTest18periodicActivationEv>:
    void periodicActivation() override {
    80002c94:	ff010113          	addi	sp,sp,-16
    80002c98:	00113423          	sd	ra,8(sp)
    80002c9c:	00813023          	sd	s0,0(sp)
    80002ca0:	01010413          	addi	s0,sp,16
    80002ca4:	00050793          	mv	a5,a0
        putc(c++);
    80002ca8:	03054503          	lbu	a0,48(a0)
    80002cac:	0015071b          	addiw	a4,a0,1
    80002cb0:	02e78823          	sb	a4,48(a5)
    80002cb4:	fffff097          	auipc	ra,0xfffff
    80002cb8:	8fc080e7          	jalr	-1796(ra) # 800015b0 <_Z4putcc>
    }
    80002cbc:	00813083          	ld	ra,8(sp)
    80002cc0:	00013403          	ld	s0,0(sp)
    80002cc4:	01010113          	addi	sp,sp,16
    80002cc8:	00008067          	ret

0000000080002ccc <_ZN14PeriodicThread3runEv>:
    void run() override {
    80002ccc:	fe010113          	addi	sp,sp,-32
    80002cd0:	00113c23          	sd	ra,24(sp)
    80002cd4:	00813823          	sd	s0,16(sp)
    80002cd8:	00913423          	sd	s1,8(sp)
    80002cdc:	02010413          	addi	s0,sp,32
    80002ce0:	00050493          	mv	s1,a0
        while (isThisPeriodicThreadTereminated==0){
    80002ce4:	0204a783          	lw	a5,32(s1)
    80002ce8:	02079263          	bnez	a5,80002d0c <_ZN14PeriodicThread3runEv+0x40>
            periodicActivation();
    80002cec:	0004b783          	ld	a5,0(s1)
    80002cf0:	0187b783          	ld	a5,24(a5)
    80002cf4:	00048513          	mv	a0,s1
    80002cf8:	000780e7          	jalr	a5
            return time_sleep(time);
    80002cfc:	0284b503          	ld	a0,40(s1)
    80002d00:	fffff097          	auipc	ra,0xfffff
    80002d04:	840080e7          	jalr	-1984(ra) # 80001540 <_Z10time_sleepm>
    80002d08:	fddff06f          	j	80002ce4 <_ZN14PeriodicThread3runEv+0x18>
    }
    80002d0c:	01813083          	ld	ra,24(sp)
    80002d10:	01013403          	ld	s0,16(sp)
    80002d14:	00813483          	ld	s1,8(sp)
    80002d18:	02010113          	addi	sp,sp,32
    80002d1c:	00008067          	ret

0000000080002d20 <_ZN6ThreadD0Ev>:
        virtual ~Thread (){
    80002d20:	ff010113          	addi	sp,sp,-16
    80002d24:	00113423          	sd	ra,8(sp)
    80002d28:	00813023          	sd	s0,0(sp)
    80002d2c:	01010413          	addi	s0,sp,16
        }
    80002d30:	00000097          	auipc	ra,0x0
    80002d34:	0bc080e7          	jalr	188(ra) # 80002dec <_ZdlPv>
    80002d38:	00813083          	ld	ra,8(sp)
    80002d3c:	00013403          	ld	s0,0(sp)
    80002d40:	01010113          	addi	sp,sp,16
    80002d44:	00008067          	ret

0000000080002d48 <_ZN12PeriodicTestD0Ev>:
class PeriodicTest : public PeriodicThread {
    80002d48:	ff010113          	addi	sp,sp,-16
    80002d4c:	00113423          	sd	ra,8(sp)
    80002d50:	00813023          	sd	s0,0(sp)
    80002d54:	01010413          	addi	s0,sp,16
    80002d58:	00000097          	auipc	ra,0x0
    80002d5c:	094080e7          	jalr	148(ra) # 80002dec <_ZdlPv>
    80002d60:	00813083          	ld	ra,8(sp)
    80002d64:	00013403          	ld	s0,0(sp)
    80002d68:	01010113          	addi	sp,sp,16
    80002d6c:	00008067          	ret

0000000080002d70 <_ZN6Thread5startEv>:
        int start (){
    80002d70:	ff010113          	addi	sp,sp,-16
    80002d74:	00113423          	sd	ra,8(sp)
    80002d78:	00813023          	sd	s0,0(sp)
    80002d7c:	01010413          	addi	s0,sp,16
            if(body== nullptr) return thread_create(&myHandle,&threadEntry, this);
    80002d80:	01053583          	ld	a1,16(a0)
    80002d84:	02058263          	beqz	a1,80002da8 <_ZN6Thread5startEv+0x38>
            else return thread_create(&myHandle,body,arg);
    80002d88:	01853603          	ld	a2,24(a0)
    80002d8c:	00850513          	addi	a0,a0,8
    80002d90:	ffffe097          	auipc	ra,0xffffe
    80002d94:	570080e7          	jalr	1392(ra) # 80001300 <_Z13thread_createPP8thread_sPFvPvES2_>
        }
    80002d98:	00813083          	ld	ra,8(sp)
    80002d9c:	00013403          	ld	s0,0(sp)
    80002da0:	01010113          	addi	sp,sp,16
    80002da4:	00008067          	ret
            if(body== nullptr) return thread_create(&myHandle,&threadEntry, this);
    80002da8:	00050613          	mv	a2,a0
    80002dac:	00000597          	auipc	a1,0x0
    80002db0:	ea458593          	addi	a1,a1,-348 # 80002c50 <_ZN6Thread11threadEntryEPv>
    80002db4:	00850513          	addi	a0,a0,8
    80002db8:	ffffe097          	auipc	ra,0xffffe
    80002dbc:	548080e7          	jalr	1352(ra) # 80001300 <_Z13thread_createPP8thread_sPFvPvES2_>
    80002dc0:	fd9ff06f          	j	80002d98 <_ZN6Thread5startEv+0x28>

0000000080002dc4 <_Znwm>:
// Created by os on 6/7/23.
//
#include "../h/syscall_cpp.hpp"


void* operator new(size_t size) {
    80002dc4:	ff010113          	addi	sp,sp,-16
    80002dc8:	00113423          	sd	ra,8(sp)
    80002dcc:	00813023          	sd	s0,0(sp)
    80002dd0:	01010413          	addi	s0,sp,16
    void* ptr = mem_alloc(size);
    80002dd4:	ffffe097          	auipc	ra,0xffffe
    80002dd8:	4ac080e7          	jalr	1196(ra) # 80001280 <_Z9mem_allocm>
    return ptr;
}
    80002ddc:	00813083          	ld	ra,8(sp)
    80002de0:	00013403          	ld	s0,0(sp)
    80002de4:	01010113          	addi	sp,sp,16
    80002de8:	00008067          	ret

0000000080002dec <_ZdlPv>:

void operator delete(void* ptr) {
    80002dec:	ff010113          	addi	sp,sp,-16
    80002df0:	00113423          	sd	ra,8(sp)
    80002df4:	00813023          	sd	s0,0(sp)
    80002df8:	01010413          	addi	s0,sp,16
    mem_free(ptr);
    80002dfc:	ffffe097          	auipc	ra,0xffffe
    80002e00:	4c4080e7          	jalr	1220(ra) # 800012c0 <_Z8mem_freePv>
}
    80002e04:	00813083          	ld	ra,8(sp)
    80002e08:	00013403          	ld	s0,0(sp)
    80002e0c:	01010113          	addi	sp,sp,16
    80002e10:	00008067          	ret

0000000080002e14 <_Z16kern_thread_initv>:
static int id;
struct thread_s* running;

void kern_thread_yield();
void kern_thread_init()
{
    80002e14:	ff010113          	addi	sp,sp,-16
    80002e18:	00813423          	sd	s0,8(sp)
    80002e1c:	01010413          	addi	s0,sp,16
    id=0;
    80002e20:	0000a797          	auipc	a5,0xa
    80002e24:	7207a823          	sw	zero,1840(a5) # 8000d550 <_ZL2id>
    for (int i=0;i<MAX_THREADS;i++){
    80002e28:	00000793          	li	a5,0
    80002e2c:	03f00713          	li	a4,63
    80002e30:	02f74463          	blt	a4,a5,80002e58 <_Z16kern_thread_initv+0x44>
        kthreads[i].status=UNUSED;
    80002e34:	00179713          	slli	a4,a5,0x1
    80002e38:	00f70733          	add	a4,a4,a5
    80002e3c:	00571693          	slli	a3,a4,0x5
    80002e40:	0000a717          	auipc	a4,0xa
    80002e44:	72070713          	addi	a4,a4,1824 # 8000d560 <kthreads>
    80002e48:	00d70733          	add	a4,a4,a3
    80002e4c:	04072823          	sw	zero,80(a4)
    for (int i=0;i<MAX_THREADS;i++){
    80002e50:	0017879b          	addiw	a5,a5,1
    80002e54:	fd9ff06f          	j	80002e2c <_Z16kern_thread_initv+0x18>
    }

    //set kthreads[0] as main thread
    kthreads[0].status=RUNNING;
    80002e58:	0000a797          	auipc	a5,0xa
    80002e5c:	70878793          	addi	a5,a5,1800 # 8000d560 <kthreads>
    80002e60:	00100713          	li	a4,1
    80002e64:	04e7a823          	sw	a4,80(a5)
    kthreads[0].id=0;
    80002e68:	0007b823          	sd	zero,16(a5)
    kthreads[0].timeslice=DEFAULT_TIME_SLICE+2;
    80002e6c:	00400713          	li	a4,4
    80002e70:	02e7b823          	sd	a4,48(a5)
    kthreads[0].endTime=0;
    80002e74:	0207bc23          	sd	zero,56(a5)
    running=&kthreads[0];
    80002e78:	0000a717          	auipc	a4,0xa
    80002e7c:	6ef73023          	sd	a5,1760(a4) # 8000d558 <running>
}
    80002e80:	00813403          	ld	s0,8(sp)
    80002e84:	01010113          	addi	sp,sp,16
    80002e88:	00008067          	ret

0000000080002e8c <_Z18kern_scheduler_getv>:

thread_t kern_scheduler_get()
{
    80002e8c:	ff010113          	addi	sp,sp,-16
    80002e90:	00813423          	sd	s0,8(sp)
    80002e94:	01010413          	addi	s0,sp,16
    int num = running-kthreads;
    80002e98:	0000a517          	auipc	a0,0xa
    80002e9c:	6c053503          	ld	a0,1728(a0) # 8000d558 <running>
    80002ea0:	0000a797          	auipc	a5,0xa
    80002ea4:	6c078793          	addi	a5,a5,1728 # 8000d560 <kthreads>
    80002ea8:	40f507b3          	sub	a5,a0,a5
    80002eac:	4057d793          	srai	a5,a5,0x5
    80002eb0:	00007717          	auipc	a4,0x7
    80002eb4:	32073703          	ld	a4,800(a4) # 8000a1d0 <CONSOLE_STATUS+0x1c0>
    80002eb8:	02e787bb          	mulw	a5,a5,a4
    for(int i=1;i<=MAX_THREADS;i++){
    80002ebc:	00100693          	li	a3,1
    80002ec0:	04000713          	li	a4,64
    80002ec4:	06d74c63          	blt	a4,a3,80002f3c <_Z18kern_scheduler_getv+0xb0>
        num = (num+i)%MAX_THREADS;
    80002ec8:	00d787bb          	addw	a5,a5,a3
    80002ecc:	41f7d71b          	sraiw	a4,a5,0x1f
    80002ed0:	01a7571b          	srliw	a4,a4,0x1a
    80002ed4:	00e787bb          	addw	a5,a5,a4
    80002ed8:	03f7f793          	andi	a5,a5,63
    80002edc:	40e787bb          	subw	a5,a5,a4
        if(kthreads[num].status==READY){
    80002ee0:	00179713          	slli	a4,a5,0x1
    80002ee4:	00f70733          	add	a4,a4,a5
    80002ee8:	00571613          	slli	a2,a4,0x5
    80002eec:	0000a717          	auipc	a4,0xa
    80002ef0:	67470713          	addi	a4,a4,1652 # 8000d560 <kthreads>
    80002ef4:	00c70733          	add	a4,a4,a2
    80002ef8:	05072603          	lw	a2,80(a4)
    80002efc:	00200713          	li	a4,2
    80002f00:	00e60663          	beq	a2,a4,80002f0c <_Z18kern_scheduler_getv+0x80>
    for(int i=1;i<=MAX_THREADS;i++){
    80002f04:	0016869b          	addiw	a3,a3,1
    80002f08:	fb9ff06f          	j	80002ec0 <_Z18kern_scheduler_getv+0x34>
            kthreads[num].status=RUNNING;
    80002f0c:	0000a617          	auipc	a2,0xa
    80002f10:	65460613          	addi	a2,a2,1620 # 8000d560 <kthreads>
    80002f14:	00179713          	slli	a4,a5,0x1
    80002f18:	00f705b3          	add	a1,a4,a5
    80002f1c:	00559693          	slli	a3,a1,0x5
    80002f20:	00d606b3          	add	a3,a2,a3
    80002f24:	00100593          	li	a1,1
    80002f28:	04b6a823          	sw	a1,80(a3)
            return &kthreads[num];
    80002f2c:	00068513          	mv	a0,a3
    if(running->status==READY || running->status==RUNNING) {
        running->status=RUNNING;
        return running;
    }
    return 0;
}
    80002f30:	00813403          	ld	s0,8(sp)
    80002f34:	01010113          	addi	sp,sp,16
    80002f38:	00008067          	ret
    if(running->status==READY || running->status==RUNNING) {
    80002f3c:	05052783          	lw	a5,80(a0)
    80002f40:	fff7879b          	addiw	a5,a5,-1
    80002f44:	00100713          	li	a4,1
    80002f48:	00f77663          	bgeu	a4,a5,80002f54 <_Z18kern_scheduler_getv+0xc8>
    return 0;
    80002f4c:	00000513          	li	a0,0
    80002f50:	fe1ff06f          	j	80002f30 <_Z18kern_scheduler_getv+0xa4>
        running->status=RUNNING;
    80002f54:	00100793          	li	a5,1
    80002f58:	04f52823          	sw	a5,80(a0)
        return running;
    80002f5c:	fd5ff06f          	j	80002f30 <_Z18kern_scheduler_getv+0xa4>

0000000080002f60 <_Z10popSppSpiev>:
    w_sepc(v_sepc);
}

//samo izlazi iz kernela i vraca se odakle je pozvana
void popSppSpie()
{
    80002f60:	ff010113          	addi	sp,sp,-16
    80002f64:	00813423          	sd	s0,8(sp)
    80002f68:	01010413          	addi	s0,sp,16
    __asm__ volatile("csrw sepc, ra"); //ovde dodaj izlazak iz privilegovanog moda
    80002f6c:	14109073          	csrw	sepc,ra
    __asm__ volatile("csrc sstatus, %[mask]" : : [mask] "r"(1 << 8));
    80002f70:	10000793          	li	a5,256
    80002f74:	1007b073          	csrc	sstatus,a5
    __asm__ volatile("sret");
    80002f78:	10200073          	sret
}
    80002f7c:	00813403          	ld	s0,8(sp)
    80002f80:	01010113          	addi	sp,sp,16
    80002f84:	00008067          	ret

0000000080002f88 <_Z19kern_thread_wrapperv>:
        contextSwitch(old,running);
    }
}

void kern_thread_wrapper()
{
    80002f88:	fe010113          	addi	sp,sp,-32
    80002f8c:	00113c23          	sd	ra,24(sp)
    80002f90:	00813823          	sd	s0,16(sp)
    80002f94:	00913423          	sd	s1,8(sp)
    80002f98:	02010413          	addi	s0,sp,32
    popSppSpie();
    80002f9c:	00000097          	auipc	ra,0x0
    80002fa0:	fc4080e7          	jalr	-60(ra) # 80002f60 <_Z10popSppSpiev>
    running->body(running->arg);
    80002fa4:	0000a497          	auipc	s1,0xa
    80002fa8:	5ac48493          	addi	s1,s1,1452 # 8000d550 <_ZL2id>
    80002fac:	0084b783          	ld	a5,8(s1)
    80002fb0:	0187b703          	ld	a4,24(a5)
    80002fb4:	0207b503          	ld	a0,32(a5)
    80002fb8:	000700e7          	jalr	a4
    running->status=UNUSED;
    80002fbc:	0084b603          	ld	a2,8(s1)
    80002fc0:	04062823          	sw	zero,80(a2)
    running->sem_next=0;
    80002fc4:	04063c23          	sd	zero,88(a2)
    running->joined_tid=-1;
    80002fc8:	fff00793          	li	a5,-1
    80002fcc:	02f63423          	sd	a5,40(a2)
    for(int i=0;i<MAX_THREADS;i++){
    80002fd0:	00000793          	li	a5,0
    80002fd4:	0080006f          	j	80002fdc <_Z19kern_thread_wrapperv+0x54>
    80002fd8:	0017879b          	addiw	a5,a5,1
    80002fdc:	03f00713          	li	a4,63
    80002fe0:	06f74863          	blt	a4,a5,80003050 <_Z19kern_thread_wrapperv+0xc8>
        if(kthreads[i].status==JOINED && kthreads[i].joined_tid==running->id) kthreads[i].status=READY;
    80002fe4:	00179713          	slli	a4,a5,0x1
    80002fe8:	00f70733          	add	a4,a4,a5
    80002fec:	00571693          	slli	a3,a4,0x5
    80002ff0:	0000a717          	auipc	a4,0xa
    80002ff4:	57070713          	addi	a4,a4,1392 # 8000d560 <kthreads>
    80002ff8:	00d70733          	add	a4,a4,a3
    80002ffc:	05072683          	lw	a3,80(a4)
    80003000:	00400713          	li	a4,4
    80003004:	fce69ae3          	bne	a3,a4,80002fd8 <_Z19kern_thread_wrapperv+0x50>
    80003008:	00179713          	slli	a4,a5,0x1
    8000300c:	00f70733          	add	a4,a4,a5
    80003010:	00571693          	slli	a3,a4,0x5
    80003014:	0000a717          	auipc	a4,0xa
    80003018:	54c70713          	addi	a4,a4,1356 # 8000d560 <kthreads>
    8000301c:	00d70733          	add	a4,a4,a3
    80003020:	02873683          	ld	a3,40(a4)
    80003024:	01063703          	ld	a4,16(a2)
    80003028:	fae698e3          	bne	a3,a4,80002fd8 <_Z19kern_thread_wrapperv+0x50>
    8000302c:	00179713          	slli	a4,a5,0x1
    80003030:	00f70733          	add	a4,a4,a5
    80003034:	00571693          	slli	a3,a4,0x5
    80003038:	0000a717          	auipc	a4,0xa
    8000303c:	52870713          	addi	a4,a4,1320 # 8000d560 <kthreads>
    80003040:	00d70733          	add	a4,a4,a3
    80003044:	00200693          	li	a3,2
    80003048:	04d72823          	sw	a3,80(a4)
    8000304c:	f8dff06f          	j	80002fd8 <_Z19kern_thread_wrapperv+0x50>
    }

    thread_exit();
    80003050:	ffffe097          	auipc	ra,0xffffe
    80003054:	364080e7          	jalr	868(ra) # 800013b4 <_Z11thread_exitv>
}
    80003058:	01813083          	ld	ra,24(sp)
    8000305c:	01013403          	ld	s0,16(sp)
    80003060:	00813483          	ld	s1,8(sp)
    80003064:	02010113          	addi	sp,sp,32
    80003068:	00008067          	ret

000000008000306c <_Z17kern_thread_yieldv>:
{
    8000306c:	fe010113          	addi	sp,sp,-32
    80003070:	00113c23          	sd	ra,24(sp)
    80003074:	00813823          	sd	s0,16(sp)
    80003078:	00913423          	sd	s1,8(sp)
    8000307c:	01213023          	sd	s2,0(sp)
    80003080:	02010413          	addi	s0,sp,32
    thread_t old = running;
    80003084:	0000a917          	auipc	s2,0xa
    80003088:	4cc90913          	addi	s2,s2,1228 # 8000d550 <_ZL2id>
    8000308c:	00893483          	ld	s1,8(s2)
    running=kern_scheduler_get();
    80003090:	00000097          	auipc	ra,0x0
    80003094:	dfc080e7          	jalr	-516(ra) # 80002e8c <_Z18kern_scheduler_getv>
    80003098:	00a93423          	sd	a0,8(s2)
    if(old!=running){
    8000309c:	02950463          	beq	a0,s1,800030c4 <_Z17kern_thread_yieldv+0x58>
    800030a0:	00050593          	mv	a1,a0
        running->status=RUNNING;
    800030a4:	00100793          	li	a5,1
    800030a8:	04f52823          	sw	a5,80(a0)
        if(old->status==RUNNING) old->status=READY;
    800030ac:	0504a703          	lw	a4,80(s1)
    800030b0:	00100793          	li	a5,1
    800030b4:	02f70463          	beq	a4,a5,800030dc <_Z17kern_thread_yieldv+0x70>
        contextSwitch(old,running);
    800030b8:	00048513          	mv	a0,s1
    800030bc:	ffffe097          	auipc	ra,0xffffe
    800030c0:	1b0080e7          	jalr	432(ra) # 8000126c <contextSwitch>
}
    800030c4:	01813083          	ld	ra,24(sp)
    800030c8:	01013403          	ld	s0,16(sp)
    800030cc:	00813483          	ld	s1,8(sp)
    800030d0:	00013903          	ld	s2,0(sp)
    800030d4:	02010113          	addi	sp,sp,32
    800030d8:	00008067          	ret
        if(old->status==RUNNING) old->status=READY;
    800030dc:	00200793          	li	a5,2
    800030e0:	04f4a823          	sw	a5,80(s1)
    800030e4:	fd5ff06f          	j	800030b8 <_Z17kern_thread_yieldv+0x4c>

00000000800030e8 <_Z20kern_thread_dispatchv>:
{
    800030e8:	fd010113          	addi	sp,sp,-48
    800030ec:	02113423          	sd	ra,40(sp)
    800030f0:	02813023          	sd	s0,32(sp)
    800030f4:	03010413          	addi	s0,sp,48
}

inline uint64 r_sstatus()
{
    uint64 volatile sstatus;
    __asm__ volatile ("csrr %[sstatus], sstatus" : [sstatus] "=r"(sstatus));
    800030f8:	100027f3          	csrr	a5,sstatus
    800030fc:	fcf43c23          	sd	a5,-40(s0)
    return sstatus;
    80003100:	fd843783          	ld	a5,-40(s0)
    uint64 volatile sstatus = r_sstatus();
    80003104:	fef43423          	sd	a5,-24(s0)
    __asm__ volatile ("csrr %[sepc], sepc" : [sepc] "=r"(sepc));
    80003108:	141027f3          	csrr	a5,sepc
    8000310c:	fcf43823          	sd	a5,-48(s0)
    return sepc;
    80003110:	fd043783          	ld	a5,-48(s0)
    uint64 volatile v_sepc = r_sepc();
    80003114:	fef43023          	sd	a5,-32(s0)
    kern_thread_yield();
    80003118:	00000097          	auipc	ra,0x0
    8000311c:	f54080e7          	jalr	-172(ra) # 8000306c <_Z17kern_thread_yieldv>
    w_sstatus(sstatus);
    80003120:	fe843783          	ld	a5,-24(s0)
}

inline void w_sstatus(uint64 sstatus)
{
    __asm__ volatile ("csrw sstatus, %[sstatus]" : : [sstatus] "r"(sstatus));
    80003124:	10079073          	csrw	sstatus,a5
    w_sepc(v_sepc);
    80003128:	fe043783          	ld	a5,-32(s0)
    __asm__ volatile ("csrw sepc, %[sepc]" : : [sepc] "r"(sepc));
    8000312c:	14179073          	csrw	sepc,a5
}
    80003130:	02813083          	ld	ra,40(sp)
    80003134:	02013403          	ld	s0,32(sp)
    80003138:	03010113          	addi	sp,sp,48
    8000313c:	00008067          	ret

0000000080003140 <_Z23kern_thread_end_runningv>:
{
    80003140:	fe010113          	addi	sp,sp,-32
    80003144:	00113c23          	sd	ra,24(sp)
    80003148:	00813823          	sd	s0,16(sp)
    8000314c:	00913423          	sd	s1,8(sp)
    80003150:	02010413          	addi	s0,sp,32
    thread_t old = running;
    80003154:	0000a497          	auipc	s1,0xa
    80003158:	4044b483          	ld	s1,1028(s1) # 8000d558 <running>
    old->status=UNUSED;
    8000315c:	0404a823          	sw	zero,80(s1)
    for(int i=0;i<MAX_THREADS;i++){
    80003160:	00000713          	li	a4,0
    80003164:	0080006f          	j	8000316c <_Z23kern_thread_end_runningv+0x2c>
    80003168:	0017071b          	addiw	a4,a4,1
    8000316c:	03f00793          	li	a5,63
    80003170:	06e7c863          	blt	a5,a4,800031e0 <_Z23kern_thread_end_runningv+0xa0>
        if(kthreads[i].status==JOINED && kthreads[i].joined_tid==old->id) kthreads[i].status=READY;
    80003174:	00171793          	slli	a5,a4,0x1
    80003178:	00e787b3          	add	a5,a5,a4
    8000317c:	00579793          	slli	a5,a5,0x5
    80003180:	0000a697          	auipc	a3,0xa
    80003184:	3e068693          	addi	a3,a3,992 # 8000d560 <kthreads>
    80003188:	00f687b3          	add	a5,a3,a5
    8000318c:	0507a683          	lw	a3,80(a5)
    80003190:	00400793          	li	a5,4
    80003194:	fcf69ae3          	bne	a3,a5,80003168 <_Z23kern_thread_end_runningv+0x28>
    80003198:	00171793          	slli	a5,a4,0x1
    8000319c:	00e787b3          	add	a5,a5,a4
    800031a0:	00579793          	slli	a5,a5,0x5
    800031a4:	0000a697          	auipc	a3,0xa
    800031a8:	3bc68693          	addi	a3,a3,956 # 8000d560 <kthreads>
    800031ac:	00f687b3          	add	a5,a3,a5
    800031b0:	0287b683          	ld	a3,40(a5)
    800031b4:	0104b783          	ld	a5,16(s1)
    800031b8:	faf698e3          	bne	a3,a5,80003168 <_Z23kern_thread_end_runningv+0x28>
    800031bc:	00171793          	slli	a5,a4,0x1
    800031c0:	00e787b3          	add	a5,a5,a4
    800031c4:	00579793          	slli	a5,a5,0x5
    800031c8:	0000a697          	auipc	a3,0xa
    800031cc:	39868693          	addi	a3,a3,920 # 8000d560 <kthreads>
    800031d0:	00f687b3          	add	a5,a3,a5
    800031d4:	00200693          	li	a3,2
    800031d8:	04d7a823          	sw	a3,80(a5)
    800031dc:	f8dff06f          	j	80003168 <_Z23kern_thread_end_runningv+0x28>
    running=kern_scheduler_get();
    800031e0:	00000097          	auipc	ra,0x0
    800031e4:	cac080e7          	jalr	-852(ra) # 80002e8c <_Z18kern_scheduler_getv>
    800031e8:	0000a797          	auipc	a5,0xa
    800031ec:	36a7b823          	sd	a0,880(a5) # 8000d558 <running>
    if(old->stack_space!=0) kern_mem_free((void*)old->stack_space);
    800031f0:	0404b503          	ld	a0,64(s1)
    800031f4:	02051863          	bnez	a0,80003224 <_Z23kern_thread_end_runningv+0xe4>
    if(old!=running){
    800031f8:	0000a597          	auipc	a1,0xa
    800031fc:	3605b583          	ld	a1,864(a1) # 8000d558 <running>
    80003200:	00958863          	beq	a1,s1,80003210 <_Z23kern_thread_end_runningv+0xd0>
        contextSwitch(old,running);
    80003204:	00048513          	mv	a0,s1
    80003208:	ffffe097          	auipc	ra,0xffffe
    8000320c:	064080e7          	jalr	100(ra) # 8000126c <contextSwitch>
}
    80003210:	01813083          	ld	ra,24(sp)
    80003214:	01013403          	ld	s0,16(sp)
    80003218:	00813483          	ld	s1,8(sp)
    8000321c:	02010113          	addi	sp,sp,32
    80003220:	00008067          	ret
    if(old->stack_space!=0) kern_mem_free((void*)old->stack_space);
    80003224:	fffff097          	auipc	ra,0xfffff
    80003228:	300080e7          	jalr	768(ra) # 80002524 <_Z13kern_mem_freePv>
    8000322c:	fcdff06f          	j	800031f8 <_Z23kern_thread_end_runningv+0xb8>

0000000080003230 <_Z18kern_thread_createPP8thread_sPFvPvES2_S2_>:

int kern_thread_create(thread_t* handle, void(*start_routine)(void*), void* arg, void* stack_space)
{
    80003230:	ff010113          	addi	sp,sp,-16
    80003234:	00813423          	sd	s0,8(sp)
    80003238:	01010413          	addi	s0,sp,16
    *handle=0;
    8000323c:	00053023          	sd	zero,0(a0)
    thread_t t=&kthreads[0]; //dodela da bismo sklonili upozorenje
    for(int i=0;i<MAX_THREADS;i++){
    80003240:	00000713          	li	a4,0
    80003244:	03f00793          	li	a5,63
    80003248:	0ae7cc63          	blt	a5,a4,80003300 <_Z18kern_thread_createPP8thread_sPFvPvES2_S2_+0xd0>
        if(kthreads[i].status==UNUSED){
    8000324c:	00171793          	slli	a5,a4,0x1
    80003250:	00e787b3          	add	a5,a5,a4
    80003254:	00579793          	slli	a5,a5,0x5
    80003258:	0000a817          	auipc	a6,0xa
    8000325c:	30880813          	addi	a6,a6,776 # 8000d560 <kthreads>
    80003260:	00f807b3          	add	a5,a6,a5
    80003264:	0507a783          	lw	a5,80(a5)
    80003268:	00078663          	beqz	a5,80003274 <_Z18kern_thread_createPP8thread_sPFvPvES2_S2_+0x44>
    for(int i=0;i<MAX_THREADS;i++){
    8000326c:	0017071b          	addiw	a4,a4,1
    80003270:	fd5ff06f          	j	80003244 <_Z18kern_thread_createPP8thread_sPFvPvES2_S2_+0x14>
            *handle=&kthreads[i];
    80003274:	00171793          	slli	a5,a4,0x1
    80003278:	00e787b3          	add	a5,a5,a4
    8000327c:	00579793          	slli	a5,a5,0x5
    80003280:	010787b3          	add	a5,a5,a6
    80003284:	00f53023          	sd	a5,0(a0)
            t=&kthreads[i];
            break;
        }
    }
    if(*handle==0) return -1;
    80003288:	00053703          	ld	a4,0(a0)
    8000328c:	08070063          	beqz	a4,8000330c <_Z18kern_thread_createPP8thread_sPFvPvES2_S2_+0xdc>

    t->id=++id;
    80003290:	0000a517          	auipc	a0,0xa
    80003294:	2c050513          	addi	a0,a0,704 # 8000d550 <_ZL2id>
    80003298:	00052703          	lw	a4,0(a0)
    8000329c:	0017071b          	addiw	a4,a4,1
    800032a0:	0007081b          	sext.w	a6,a4
    800032a4:	00e52023          	sw	a4,0(a0)
    800032a8:	0107b823          	sd	a6,16(a5)
    t->status=READY;
    800032ac:	00200713          	li	a4,2
    800032b0:	04e7a823          	sw	a4,80(a5)
    t->arg=arg;
    800032b4:	02c7b023          	sd	a2,32(a5)
    t->joined_tid=-1;
    800032b8:	fff00713          	li	a4,-1
    800032bc:	02e7b423          	sd	a4,40(a5)
    t->timeslice=DEFAULT_TIME_SLICE;
    800032c0:	00200713          	li	a4,2
    800032c4:	02e7b823          	sd	a4,48(a5)
    t->body=start_routine;
    800032c8:	00b7bc23          	sd	a1,24(a5)
    t->stack_space = ((uint64)stack_space);
    800032cc:	04d7b023          	sd	a3,64(a5)
    t->sp = t->stack_space+(DEFAULT_STACK_SIZE);
    800032d0:	00001737          	lui	a4,0x1
    800032d4:	00e686b3          	add	a3,a3,a4
    800032d8:	00d7b423          	sd	a3,8(a5)
    t->ra=(uint64) &kern_thread_wrapper;
    800032dc:	00000717          	auipc	a4,0x0
    800032e0:	cac70713          	addi	a4,a4,-852 # 80002f88 <_Z19kern_thread_wrapperv>
    800032e4:	00e7b023          	sd	a4,0(a5)
    t->sem_next=0;
    800032e8:	0407bc23          	sd	zero,88(a5)
    t->mailbox=0;
    800032ec:	0407b423          	sd	zero,72(a5)

    return 0;
    800032f0:	00000513          	li	a0,0
}
    800032f4:	00813403          	ld	s0,8(sp)
    800032f8:	01010113          	addi	sp,sp,16
    800032fc:	00008067          	ret
    thread_t t=&kthreads[0]; //dodela da bismo sklonili upozorenje
    80003300:	0000a797          	auipc	a5,0xa
    80003304:	26078793          	addi	a5,a5,608 # 8000d560 <kthreads>
    80003308:	f81ff06f          	j	80003288 <_Z18kern_thread_createPP8thread_sPFvPvES2_S2_+0x58>
    if(*handle==0) return -1;
    8000330c:	fff00513          	li	a0,-1
    80003310:	fe5ff06f          	j	800032f4 <_Z18kern_thread_createPP8thread_sPFvPvES2_S2_+0xc4>

0000000080003314 <_Z16kern_thread_joinP8thread_s>:

void kern_thread_join(thread_t handle)
{
    if(handle->status==UNUSED) return;
    80003314:	05052783          	lw	a5,80(a0)
    80003318:	00079463          	bnez	a5,80003320 <_Z16kern_thread_joinP8thread_s+0xc>
    8000331c:	00008067          	ret
{
    80003320:	ff010113          	addi	sp,sp,-16
    80003324:	00113423          	sd	ra,8(sp)
    80003328:	00813023          	sd	s0,0(sp)
    8000332c:	01010413          	addi	s0,sp,16
    running->joined_tid=handle->id;
    80003330:	0000a797          	auipc	a5,0xa
    80003334:	2287b783          	ld	a5,552(a5) # 8000d558 <running>
    80003338:	01053703          	ld	a4,16(a0)
    8000333c:	02e7b423          	sd	a4,40(a5)
    running->status=JOINED;
    80003340:	00400713          	li	a4,4
    80003344:	04e7a823          	sw	a4,80(a5)
    kern_thread_yield();
    80003348:	00000097          	auipc	ra,0x0
    8000334c:	d24080e7          	jalr	-732(ra) # 8000306c <_Z17kern_thread_yieldv>
}
    80003350:	00813083          	ld	ra,8(sp)
    80003354:	00013403          	ld	s0,0(sp)
    80003358:	01010113          	addi	sp,sp,16
    8000335c:	00008067          	ret

0000000080003360 <_Z18kern_thread_wakeupm>:

void kern_thread_wakeup(uint64 system_time)
{
    80003360:	ff010113          	addi	sp,sp,-16
    80003364:	00813423          	sd	s0,8(sp)
    80003368:	01010413          	addi	s0,sp,16
    for(int i=0;i<MAX_THREADS;i++){
    8000336c:	00000793          	li	a5,0
    80003370:	0080006f          	j	80003378 <_Z18kern_thread_wakeupm+0x18>
    80003374:	0017879b          	addiw	a5,a5,1
    80003378:	03f00713          	li	a4,63
    8000337c:	06f74263          	blt	a4,a5,800033e0 <_Z18kern_thread_wakeupm+0x80>
        if(kthreads[i].status==SLEEPING && kthreads[i].endTime<system_time){
    80003380:	00179713          	slli	a4,a5,0x1
    80003384:	00f70733          	add	a4,a4,a5
    80003388:	00571713          	slli	a4,a4,0x5
    8000338c:	0000a697          	auipc	a3,0xa
    80003390:	1d468693          	addi	a3,a3,468 # 8000d560 <kthreads>
    80003394:	00e68733          	add	a4,a3,a4
    80003398:	05072683          	lw	a3,80(a4)
    8000339c:	00500713          	li	a4,5
    800033a0:	fce69ae3          	bne	a3,a4,80003374 <_Z18kern_thread_wakeupm+0x14>
    800033a4:	00179713          	slli	a4,a5,0x1
    800033a8:	00f70733          	add	a4,a4,a5
    800033ac:	00571713          	slli	a4,a4,0x5
    800033b0:	0000a697          	auipc	a3,0xa
    800033b4:	1b068693          	addi	a3,a3,432 # 8000d560 <kthreads>
    800033b8:	00e68733          	add	a4,a3,a4
    800033bc:	03873703          	ld	a4,56(a4)
    800033c0:	faa77ae3          	bgeu	a4,a0,80003374 <_Z18kern_thread_wakeupm+0x14>
            kthreads[i].status=READY;
    800033c4:	00179713          	slli	a4,a5,0x1
    800033c8:	00f70733          	add	a4,a4,a5
    800033cc:	00571713          	slli	a4,a4,0x5
    800033d0:	00e68733          	add	a4,a3,a4
    800033d4:	00200693          	li	a3,2
    800033d8:	04d72823          	sw	a3,80(a4)
    800033dc:	f99ff06f          	j	80003374 <_Z18kern_thread_wakeupm+0x14>
        }
    }
}
    800033e0:	00813403          	ld	s0,8(sp)
    800033e4:	01010113          	addi	sp,sp,16
    800033e8:	00008067          	ret

00000000800033ec <_Z13kern_sem_initv>:
#define MAX_SEMAPHORES 256

struct sem_s semaphores[MAX_SEMAPHORES];

void kern_sem_init()
{
    800033ec:	ff010113          	addi	sp,sp,-16
    800033f0:	00813423          	sd	s0,8(sp)
    800033f4:	01010413          	addi	s0,sp,16
    for(int i=0;i<MAX_SEMAPHORES;i++){
    800033f8:	00000713          	li	a4,0
    800033fc:	0ff00793          	li	a5,255
    80003400:	02e7c663          	blt	a5,a4,8000342c <_Z13kern_sem_initv+0x40>
        semaphores[i].waiting_thread=0;
    80003404:	00471693          	slli	a3,a4,0x4
    80003408:	0000c797          	auipc	a5,0xc
    8000340c:	95878793          	addi	a5,a5,-1704 # 8000ed60 <semaphores>
    80003410:	00d787b3          	add	a5,a5,a3
    80003414:	0007b423          	sd	zero,8(a5)
        semaphores[i].val=0;
    80003418:	0007a023          	sw	zero,0(a5)
        semaphores[i].status=SEM_UNUSED;
    8000341c:	00100693          	li	a3,1
    80003420:	00d7a223          	sw	a3,4(a5)
    for(int i=0;i<MAX_SEMAPHORES;i++){
    80003424:	0017071b          	addiw	a4,a4,1
    80003428:	fd5ff06f          	j	800033fc <_Z13kern_sem_initv+0x10>
    }
}
    8000342c:	00813403          	ld	s0,8(sp)
    80003430:	01010113          	addi	sp,sp,16
    80003434:	00008067          	ret

0000000080003438 <_Z13kern_sem_openPP5sem_sj>:

int kern_sem_open (sem_t* handle, unsigned init)
{
    80003438:	ff010113          	addi	sp,sp,-16
    8000343c:	00813423          	sd	s0,8(sp)
    80003440:	01010413          	addi	s0,sp,16
    int res=-1;
    for(int i=0;i<MAX_SEMAPHORES;i++){
    80003444:	00000793          	li	a5,0
    80003448:	0080006f          	j	80003450 <_Z13kern_sem_openPP5sem_sj+0x18>
    8000344c:	0017879b          	addiw	a5,a5,1
    80003450:	0ff00713          	li	a4,255
    80003454:	04f74663          	blt	a4,a5,800034a0 <_Z13kern_sem_openPP5sem_sj+0x68>
        if(semaphores[i].status==SEM_UNUSED){
    80003458:	00479693          	slli	a3,a5,0x4
    8000345c:	0000c717          	auipc	a4,0xc
    80003460:	90470713          	addi	a4,a4,-1788 # 8000ed60 <semaphores>
    80003464:	00d70733          	add	a4,a4,a3
    80003468:	00472683          	lw	a3,4(a4)
    8000346c:	00100713          	li	a4,1
    80003470:	fce69ee3          	bne	a3,a4,8000344c <_Z13kern_sem_openPP5sem_sj+0x14>
            semaphores[i].status=SEM_USED;
    80003474:	00479793          	slli	a5,a5,0x4
    80003478:	0000c717          	auipc	a4,0xc
    8000347c:	8e870713          	addi	a4,a4,-1816 # 8000ed60 <semaphores>
    80003480:	00f707b3          	add	a5,a4,a5
    80003484:	0007a223          	sw	zero,4(a5)
            semaphores[i].val=init;
    80003488:	00b7a023          	sw	a1,0(a5)
            *handle=&semaphores[i];
    8000348c:	00f53023          	sd	a5,0(a0)
            res++;
    80003490:	00000513          	li	a0,0
            break;
        }
    }
    return res;
}
    80003494:	00813403          	ld	s0,8(sp)
    80003498:	01010113          	addi	sp,sp,16
    8000349c:	00008067          	ret
    int res=-1;
    800034a0:	fff00513          	li	a0,-1
    800034a4:	ff1ff06f          	j	80003494 <_Z13kern_sem_openPP5sem_sj+0x5c>

00000000800034a8 <_Z14kern_sem_closeP5sem_s>:

int kern_sem_close (sem_t handle)
{
    800034a8:	ff010113          	addi	sp,sp,-16
    800034ac:	00813423          	sd	s0,8(sp)
    800034b0:	01010413          	addi	s0,sp,16
    handle->status=SEM_UNUSED;
    800034b4:	00100793          	li	a5,1
    800034b8:	00f52223          	sw	a5,4(a0)
    handle->val=0;
    800034bc:	00052023          	sw	zero,0(a0)
    if(handle->waiting_thread!=0){
    800034c0:	00853783          	ld	a5,8(a0)
    800034c4:	02079263          	bnez	a5,800034e8 <_Z14kern_sem_closeP5sem_s+0x40>
    800034c8:	0280006f          	j	800034f0 <_Z14kern_sem_closeP5sem_s+0x48>
        thread_t curr = handle->waiting_thread;
        while(curr){
            curr->mailbox=-2;
    800034cc:	ffe00713          	li	a4,-2
    800034d0:	04e7b423          	sd	a4,72(a5)
            curr->status=READY;
    800034d4:	00200713          	li	a4,2
    800034d8:	04e7a823          	sw	a4,80(a5)
            thread_t prev=curr;
            curr=curr->sem_next;
    800034dc:	0587b703          	ld	a4,88(a5)
            prev->sem_next=0;
    800034e0:	0407bc23          	sd	zero,88(a5)
            curr=curr->sem_next;
    800034e4:	00070793          	mv	a5,a4
        while(curr){
    800034e8:	fe0792e3          	bnez	a5,800034cc <_Z14kern_sem_closeP5sem_s+0x24>
        }
        handle->waiting_thread=0;
    800034ec:	00053423          	sd	zero,8(a0)
    }
    return 0;
}
    800034f0:	00000513          	li	a0,0
    800034f4:	00813403          	ld	s0,8(sp)
    800034f8:	01010113          	addi	sp,sp,16
    800034fc:	00008067          	ret

0000000080003500 <_Z15kern_sem_signalP5sem_s>:

void kern_sem_signal(sem_t id)
{
    80003500:	ff010113          	addi	sp,sp,-16
    80003504:	00813423          	sd	s0,8(sp)
    80003508:	01010413          	addi	s0,sp,16
    if(id->val>0 || id->waiting_thread==0) id->val++;
    8000350c:	00052783          	lw	a5,0(a0)
    80003510:	00f05c63          	blez	a5,80003528 <_Z15kern_sem_signalP5sem_s+0x28>
    80003514:	0017879b          	addiw	a5,a5,1
    80003518:	00f52023          	sw	a5,0(a0)
        thread_t woken = id->waiting_thread;
        id->waiting_thread=woken->sem_next;
        woken->mailbox=0;
        woken->status=READY;
    }
}
    8000351c:	00813403          	ld	s0,8(sp)
    80003520:	01010113          	addi	sp,sp,16
    80003524:	00008067          	ret
    if(id->val>0 || id->waiting_thread==0) id->val++;
    80003528:	00853703          	ld	a4,8(a0)
    8000352c:	fe0704e3          	beqz	a4,80003514 <_Z15kern_sem_signalP5sem_s+0x14>
        id->waiting_thread=woken->sem_next;
    80003530:	05873783          	ld	a5,88(a4)
    80003534:	00f53423          	sd	a5,8(a0)
        woken->mailbox=0;
    80003538:	04073423          	sd	zero,72(a4)
        woken->status=READY;
    8000353c:	00200793          	li	a5,2
    80003540:	04f72823          	sw	a5,80(a4)
}
    80003544:	fd9ff06f          	j	8000351c <_Z15kern_sem_signalP5sem_s+0x1c>

0000000080003548 <_Z13kern_sem_waitP5sem_s>:

int kern_sem_wait(sem_t id)
{
    if(id->val<=0){
    80003548:	00052783          	lw	a5,0(a0)
    8000354c:	00f05a63          	blez	a5,80003560 <_Z13kern_sem_waitP5sem_s+0x18>
        w_sstatus(sstatus);
        w_sepc(v_sepc);
        return running->mailbox;
    }
    else {
        id->val--;
    80003550:	fff7879b          	addiw	a5,a5,-1
    80003554:	00f52023          	sw	a5,0(a0)
        return 1;
    80003558:	00100513          	li	a0,1
    }
}
    8000355c:	00008067          	ret
{
    80003560:	fd010113          	addi	sp,sp,-48
    80003564:	02113423          	sd	ra,40(sp)
    80003568:	02813023          	sd	s0,32(sp)
    8000356c:	03010413          	addi	s0,sp,48
        running->status=SUSPENDED;
    80003570:	00009797          	auipc	a5,0x9
    80003574:	6907b783          	ld	a5,1680(a5) # 8000cc00 <_GLOBAL_OFFSET_TABLE_+0x20>
    80003578:	0007b683          	ld	a3,0(a5)
    8000357c:	00300793          	li	a5,3
    80003580:	04f6a823          	sw	a5,80(a3)
        if(id->waiting_thread==0) id->waiting_thread=running;
    80003584:	00853783          	ld	a5,8(a0)
    80003588:	06078863          	beqz	a5,800035f8 <_Z13kern_sem_waitP5sem_s+0xb0>
            while (curr->sem_next!=0) curr=curr->sem_next;
    8000358c:	00078713          	mv	a4,a5
    80003590:	0587b783          	ld	a5,88(a5)
    80003594:	fe079ce3          	bnez	a5,8000358c <_Z13kern_sem_waitP5sem_s+0x44>
            curr->sem_next=running;
    80003598:	04d73c23          	sd	a3,88(a4)
        running->sem_next=0;
    8000359c:	0406bc23          	sd	zero,88(a3)
    __asm__ volatile ("csrr %[sstatus], sstatus" : [sstatus] "=r"(sstatus));
    800035a0:	100027f3          	csrr	a5,sstatus
    800035a4:	fef43423          	sd	a5,-24(s0)
    return sstatus;
    800035a8:	fe843783          	ld	a5,-24(s0)
        uint64 volatile sstatus = r_sstatus();
    800035ac:	fcf43823          	sd	a5,-48(s0)
    __asm__ volatile ("csrr %[sepc], sepc" : [sepc] "=r"(sepc));
    800035b0:	141027f3          	csrr	a5,sepc
    800035b4:	fef43023          	sd	a5,-32(s0)
    return sepc;
    800035b8:	fe043783          	ld	a5,-32(s0)
        uint64 volatile v_sepc = r_sepc();
    800035bc:	fcf43c23          	sd	a5,-40(s0)
        kern_thread_dispatch();
    800035c0:	00000097          	auipc	ra,0x0
    800035c4:	b28080e7          	jalr	-1240(ra) # 800030e8 <_Z20kern_thread_dispatchv>
        w_sstatus(sstatus);
    800035c8:	fd043783          	ld	a5,-48(s0)
    __asm__ volatile ("csrw sstatus, %[sstatus]" : : [sstatus] "r"(sstatus));
    800035cc:	10079073          	csrw	sstatus,a5
        w_sepc(v_sepc);
    800035d0:	fd843783          	ld	a5,-40(s0)
    __asm__ volatile ("csrw sepc, %[sepc]" : : [sepc] "r"(sepc));
    800035d4:	14179073          	csrw	sepc,a5
        return running->mailbox;
    800035d8:	00009797          	auipc	a5,0x9
    800035dc:	6287b783          	ld	a5,1576(a5) # 8000cc00 <_GLOBAL_OFFSET_TABLE_+0x20>
    800035e0:	0007b783          	ld	a5,0(a5)
    800035e4:	0487a503          	lw	a0,72(a5)
}
    800035e8:	02813083          	ld	ra,40(sp)
    800035ec:	02013403          	ld	s0,32(sp)
    800035f0:	03010113          	addi	sp,sp,48
    800035f4:	00008067          	ret
        if(id->waiting_thread==0) id->waiting_thread=running;
    800035f8:	00d53423          	sd	a3,8(a0)
    800035fc:	fa1ff06f          	j	8000359c <_Z13kern_sem_waitP5sem_s+0x54>

0000000080003600 <_Z19kern_interrupt_initv>:
#ifdef __cplusplus
}
#endif

void kern_interrupt_init()
{
    80003600:	ff010113          	addi	sp,sp,-16
    80003604:	00813423          	sd	s0,8(sp)
    80003608:	01010413          	addi	s0,sp,16
    SYSTEM_TIME=0;
    8000360c:	0000c797          	auipc	a5,0xc
    80003610:	7407ba23          	sd	zero,1876(a5) # 8000fd60 <SYSTEM_TIME>
    w_stvec((uint64) &supervisorTrap);
    80003614:	00009797          	auipc	a5,0x9
    80003618:	5f47b783          	ld	a5,1524(a5) # 8000cc08 <_GLOBAL_OFFSET_TABLE_+0x28>
    __asm__ volatile ("csrw stvec, %[stvec]" : : [stvec] "r"(stvec));
    8000361c:	10579073          	csrw	stvec,a5
    __asm__ volatile ("csrs sstatus, %[mask]" : : [mask] "r"(mask));
    80003620:	00200793          	li	a5,2
    80003624:	1007a073          	csrs	sstatus,a5
    ms_sstatus(SSTATUS_SIE);
}
    80003628:	00813403          	ld	s0,8(sp)
    8000362c:	01010113          	addi	sp,sp,16
    80003630:	00008067          	ret

0000000080003634 <_Z12kern_syscall13SyscallNumberz>:


void kern_syscall(enum SyscallNumber num, ...)
{
    80003634:	fb010113          	addi	sp,sp,-80
    80003638:	00813423          	sd	s0,8(sp)
    8000363c:	01010413          	addi	s0,sp,16
    80003640:	00b43423          	sd	a1,8(s0)
    80003644:	00c43823          	sd	a2,16(s0)
    80003648:	00d43c23          	sd	a3,24(s0)
    8000364c:	02e43023          	sd	a4,32(s0)
    80003650:	02f43423          	sd	a5,40(s0)
    80003654:	03043823          	sd	a6,48(s0)
    80003658:	03143c23          	sd	a7,56(s0)
    __asm__ volatile ("ecall");
    8000365c:	00000073          	ecall
    return;
}
    80003660:	00813403          	ld	s0,8(sp)
    80003664:	05010113          	addi	sp,sp,80
    80003668:	00008067          	ret

000000008000366c <handleEcall>:
#ifdef __cplusplus
extern "C" {
#endif


void handleEcall(uint64 a0, uint64 a1, uint64 a2, uint64 a3, uint64 a4) {
    8000366c:	f9010113          	addi	sp,sp,-112
    80003670:	06113423          	sd	ra,104(sp)
    80003674:	06813023          	sd	s0,96(sp)
    80003678:	04913c23          	sd	s1,88(sp)
    8000367c:	05213823          	sd	s2,80(sp)
    80003680:	07010413          	addi	s0,sp,112
    80003684:	00060913          	mv	s2,a2
    80003688:	00068613          	mv	a2,a3
    __asm__ volatile ("csrr %[scause], scause" : [scause] "=r"(scause));
    8000368c:	142027f3          	csrr	a5,scause
    80003690:	faf43823          	sd	a5,-80(s0)
    return scause;
    80003694:	fb043783          	ld	a5,-80(s0)
    __asm__ volatile ("mv %[a2], a2" : [a2] "=r"(a2));
    __asm__ volatile ("mv %[a3], a3" : [a3] "=r"(a3));
    __asm__ volatile ("mv %[a4], a4" : [a4] "=r"(a4));
     */
    uint64 scause = r_scause();
    if (scause == INTR_USER_ECALL || scause == INTR_KERNEL_ECALL) {
    80003698:	ff878793          	addi	a5,a5,-8
    8000369c:	00100693          	li	a3,1
    800036a0:	00f6fe63          	bgeu	a3,a5,800036bc <handleEcall+0x50>
            }


        }
    }
}
    800036a4:	06813083          	ld	ra,104(sp)
    800036a8:	06013403          	ld	s0,96(sp)
    800036ac:	05813483          	ld	s1,88(sp)
    800036b0:	05013903          	ld	s2,80(sp)
    800036b4:	07010113          	addi	sp,sp,112
    800036b8:	00008067          	ret
    800036bc:	00058493          	mv	s1,a1
    __asm__ volatile ("csrr %[sepc], sepc" : [sepc] "=r"(sepc));
    800036c0:	141027f3          	csrr	a5,sepc
    800036c4:	faf43c23          	sd	a5,-72(s0)
    return sepc;
    800036c8:	fb843783          	ld	a5,-72(s0)
        uint64 sepc = r_sepc() + 4;
    800036cc:	00478793          	addi	a5,a5,4
        uint64 time = SYSTEM_TIME;
    800036d0:	0000c597          	auipc	a1,0xc
    800036d4:	6905b583          	ld	a1,1680(a1) # 8000fd60 <SYSTEM_TIME>
    __asm__ volatile ("csrw sepc, %[sepc]" : : [sepc] "r"(sepc));
    800036d8:	14179073          	csrw	sepc,a5
        switch (syscall_num) {
    800036dc:	04200793          	li	a5,66
    800036e0:	fca7e2e3          	bltu	a5,a0,800036a4 <handleEcall+0x38>
    800036e4:	00251513          	slli	a0,a0,0x2
    800036e8:	00007697          	auipc	a3,0x7
    800036ec:	af068693          	addi	a3,a3,-1296 # 8000a1d8 <CONSOLE_STATUS+0x1c8>
    800036f0:	00d50533          	add	a0,a0,a3
    800036f4:	00052783          	lw	a5,0(a0)
    800036f8:	00d787b3          	add	a5,a5,a3
    800036fc:	00078067          	jr	a5
                retval = (uint64) kern_mem_alloc(size);
    80003700:	0004851b          	sext.w	a0,s1
    80003704:	fffff097          	auipc	ra,0xfffff
    80003708:	d5c080e7          	jalr	-676(ra) # 80002460 <_Z14kern_mem_alloci>
    __asm__ volatile ("mv a0, %[value]" :: [value] "r"(value));
    8000370c:	00050513          	mv	a0,a0
}
    80003710:	f95ff06f          	j	800036a4 <handleEcall+0x38>
                retval = (uint64) kern_mem_free((void *) addr);
    80003714:	00048513          	mv	a0,s1
    80003718:	fffff097          	auipc	ra,0xfffff
    8000371c:	e0c080e7          	jalr	-500(ra) # 80002524 <_Z13kern_mem_freePv>
    __asm__ volatile ("mv a0, %[value]" :: [value] "r"(value));
    80003720:	00050513          	mv	a0,a0
}
    80003724:	f81ff06f          	j	800036a4 <handleEcall+0x38>
                retval = (uint64) kern_thread_create((thread_t *) handle,
    80003728:	00070693          	mv	a3,a4
    8000372c:	00090593          	mv	a1,s2
    80003730:	00048513          	mv	a0,s1
    80003734:	00000097          	auipc	ra,0x0
    80003738:	afc080e7          	jalr	-1284(ra) # 80003230 <_Z18kern_thread_createPP8thread_sPFvPvES2_S2_>
                (*(thread_t *) handle)->endTime = SYSTEM_TIME + DEFAULT_TIME_SLICE;
    8000373c:	0004b703          	ld	a4,0(s1)
    80003740:	0000c797          	auipc	a5,0xc
    80003744:	6207b783          	ld	a5,1568(a5) # 8000fd60 <SYSTEM_TIME>
    80003748:	00278793          	addi	a5,a5,2
    8000374c:	02f73c23          	sd	a5,56(a4)
    __asm__ volatile ("mv a0, %[value]" :: [value] "r"(value));
    80003750:	00050513          	mv	a0,a0
}
    80003754:	f51ff06f          	j	800036a4 <handleEcall+0x38>
                kern_thread_dispatch();
    80003758:	00000097          	auipc	ra,0x0
    8000375c:	990080e7          	jalr	-1648(ra) # 800030e8 <_Z20kern_thread_dispatchv>
                running->endTime = SYSTEM_TIME + running->timeslice;
    80003760:	00009797          	auipc	a5,0x9
    80003764:	4a07b783          	ld	a5,1184(a5) # 8000cc00 <_GLOBAL_OFFSET_TABLE_+0x20>
    80003768:	0007b703          	ld	a4,0(a5)
    8000376c:	03073783          	ld	a5,48(a4)
    80003770:	0000c697          	auipc	a3,0xc
    80003774:	5f06b683          	ld	a3,1520(a3) # 8000fd60 <SYSTEM_TIME>
    80003778:	00d787b3          	add	a5,a5,a3
    8000377c:	02f73c23          	sd	a5,56(a4)
                break;
    80003780:	f25ff06f          	j	800036a4 <handleEcall+0x38>
    __asm__ volatile ("csrr %[sstatus], sstatus" : [sstatus] "=r"(sstatus));
    80003784:	100027f3          	csrr	a5,sstatus
    80003788:	fcf43423          	sd	a5,-56(s0)
    return sstatus;
    8000378c:	fc843783          	ld	a5,-56(s0)
                uint64 volatile sstatus = r_sstatus();
    80003790:	f8f43823          	sd	a5,-112(s0)
    __asm__ volatile ("csrr %[sepc], sepc" : [sepc] "=r"(sepc));
    80003794:	141027f3          	csrr	a5,sepc
    80003798:	fcf43023          	sd	a5,-64(s0)
    return sepc;
    8000379c:	fc043783          	ld	a5,-64(s0)
                uint64 volatile v_sepc = r_sepc();
    800037a0:	f8f43c23          	sd	a5,-104(s0)
                kern_thread_join(handle);
    800037a4:	00048513          	mv	a0,s1
    800037a8:	00000097          	auipc	ra,0x0
    800037ac:	b6c080e7          	jalr	-1172(ra) # 80003314 <_Z16kern_thread_joinP8thread_s>
                w_sstatus(sstatus);
    800037b0:	f9043783          	ld	a5,-112(s0)
    __asm__ volatile ("csrw sstatus, %[sstatus]" : : [sstatus] "r"(sstatus));
    800037b4:	10079073          	csrw	sstatus,a5
                w_sepc(v_sepc);
    800037b8:	f9843783          	ld	a5,-104(s0)
    __asm__ volatile ("csrw sepc, %[sepc]" : : [sepc] "r"(sepc));
    800037bc:	14179073          	csrw	sepc,a5
                running->endTime = SYSTEM_TIME + running->timeslice;
    800037c0:	00009797          	auipc	a5,0x9
    800037c4:	4407b783          	ld	a5,1088(a5) # 8000cc00 <_GLOBAL_OFFSET_TABLE_+0x20>
    800037c8:	0007b703          	ld	a4,0(a5)
    800037cc:	03073783          	ld	a5,48(a4)
    800037d0:	0000c697          	auipc	a3,0xc
    800037d4:	5906b683          	ld	a3,1424(a3) # 8000fd60 <SYSTEM_TIME>
    800037d8:	00d787b3          	add	a5,a5,a3
    800037dc:	02f73c23          	sd	a5,56(a4)
                break;
    800037e0:	ec5ff06f          	j	800036a4 <handleEcall+0x38>
                kern_thread_end_running();
    800037e4:	00000097          	auipc	ra,0x0
    800037e8:	95c080e7          	jalr	-1700(ra) # 80003140 <_Z23kern_thread_end_runningv>
                retval = kern_sem_open(handle, init);
    800037ec:	0009059b          	sext.w	a1,s2
    800037f0:	00048513          	mv	a0,s1
    800037f4:	00000097          	auipc	ra,0x0
    800037f8:	c44080e7          	jalr	-956(ra) # 80003438 <_Z13kern_sem_openPP5sem_sj>
    __asm__ volatile ("mv a0, %[value]" :: [value] "r"(value));
    800037fc:	00050513          	mv	a0,a0
}
    80003800:	ea5ff06f          	j	800036a4 <handleEcall+0x38>
                retval = kern_sem_close(handle);
    80003804:	00048513          	mv	a0,s1
    80003808:	00000097          	auipc	ra,0x0
    8000380c:	ca0080e7          	jalr	-864(ra) # 800034a8 <_Z14kern_sem_closeP5sem_s>
    __asm__ volatile ("mv a0, %[value]" :: [value] "r"(value));
    80003810:	00050513          	mv	a0,a0
}
    80003814:	e91ff06f          	j	800036a4 <handleEcall+0x38>
                kern_sem_signal(handle);
    80003818:	00048513          	mv	a0,s1
    8000381c:	00000097          	auipc	ra,0x0
    80003820:	ce4080e7          	jalr	-796(ra) # 80003500 <_Z15kern_sem_signalP5sem_s>
    __asm__ volatile ("mv a0, %[value]" :: [value] "r"(value));
    80003824:	00000793          	li	a5,0
    80003828:	00078513          	mv	a0,a5
}
    8000382c:	e79ff06f          	j	800036a4 <handleEcall+0x38>
                retval = kern_sem_wait(handle);
    80003830:	00048513          	mv	a0,s1
    80003834:	00000097          	auipc	ra,0x0
    80003838:	d14080e7          	jalr	-748(ra) # 80003548 <_Z13kern_sem_waitP5sem_s>
                if (retval == 1) { //nije promenjen kontekst
    8000383c:	00100793          	li	a5,1
    80003840:	02f50663          	beq	a0,a5,8000386c <handleEcall+0x200>
                    running->endTime = SYSTEM_TIME + running->timeslice;
    80003844:	00009797          	auipc	a5,0x9
    80003848:	3bc7b783          	ld	a5,956(a5) # 8000cc00 <_GLOBAL_OFFSET_TABLE_+0x20>
    8000384c:	0007b703          	ld	a4,0(a5)
    80003850:	03073783          	ld	a5,48(a4)
    80003854:	0000c697          	auipc	a3,0xc
    80003858:	50c6b683          	ld	a3,1292(a3) # 8000fd60 <SYSTEM_TIME>
    8000385c:	00d787b3          	add	a5,a5,a3
    80003860:	02f73c23          	sd	a5,56(a4)
    __asm__ volatile ("mv a0, %[value]" :: [value] "r"(value));
    80003864:	00050513          	mv	a0,a0
}
    80003868:	e3dff06f          	j	800036a4 <handleEcall+0x38>
                    retval = 0;
    8000386c:	00000513          	li	a0,0
    80003870:	ff5ff06f          	j	80003864 <handleEcall+0x1f8>
                running->status = SLEEPING;
    80003874:	00009917          	auipc	s2,0x9
    80003878:	38c93903          	ld	s2,908(s2) # 8000cc00 <_GLOBAL_OFFSET_TABLE_+0x20>
    8000387c:	00093783          	ld	a5,0(s2)
    80003880:	00500713          	li	a4,5
    80003884:	04e7a823          	sw	a4,80(a5)
                running->endTime = SYSTEM_TIME + period;
    80003888:	009585b3          	add	a1,a1,s1
    8000388c:	02b7bc23          	sd	a1,56(a5)
    __asm__ volatile ("csrr %[sstatus], sstatus" : [sstatus] "=r"(sstatus));
    80003890:	100027f3          	csrr	a5,sstatus
    80003894:	fcf43c23          	sd	a5,-40(s0)
    return sstatus;
    80003898:	fd843783          	ld	a5,-40(s0)
                uint64 volatile sstatus = r_sstatus();
    8000389c:	faf43023          	sd	a5,-96(s0)
    __asm__ volatile ("csrr %[sepc], sepc" : [sepc] "=r"(sepc));
    800038a0:	141027f3          	csrr	a5,sepc
    800038a4:	fcf43823          	sd	a5,-48(s0)
    return sepc;
    800038a8:	fd043783          	ld	a5,-48(s0)
                uint64 volatile v_sepc = r_sepc();
    800038ac:	faf43423          	sd	a5,-88(s0)
                kern_thread_yield();
    800038b0:	fffff097          	auipc	ra,0xfffff
    800038b4:	7bc080e7          	jalr	1980(ra) # 8000306c <_Z17kern_thread_yieldv>
                w_sstatus(sstatus);
    800038b8:	fa043783          	ld	a5,-96(s0)
    __asm__ volatile ("csrw sstatus, %[sstatus]" : : [sstatus] "r"(sstatus));
    800038bc:	10079073          	csrw	sstatus,a5
                w_sepc(v_sepc);
    800038c0:	fa843783          	ld	a5,-88(s0)
    __asm__ volatile ("csrw sepc, %[sepc]" : : [sepc] "r"(sepc));
    800038c4:	14179073          	csrw	sepc,a5
                running->endTime=time+running->timeslice;
    800038c8:	00093703          	ld	a4,0(s2)
    800038cc:	03073783          	ld	a5,48(a4)
    800038d0:	0000c697          	auipc	a3,0xc
    800038d4:	4906b683          	ld	a3,1168(a3) # 8000fd60 <SYSTEM_TIME>
    800038d8:	00d787b3          	add	a5,a5,a3
    800038dc:	02f73c23          	sd	a5,56(a4)
                break;
    800038e0:	dc5ff06f          	j	800036a4 <handleEcall+0x38>
                    c = kern_console_getchar();
    800038e4:	fffff097          	auipc	ra,0xfffff
    800038e8:	ed0080e7          	jalr	-304(ra) # 800027b4 <_Z20kern_console_getcharv>
                    if(c==-1){
    800038ec:	fff00793          	li	a5,-1
    800038f0:	02f51863          	bne	a0,a5,80003920 <handleEcall+0x2b4>
                        kern_thread_dispatch();
    800038f4:	fffff097          	auipc	ra,0xfffff
    800038f8:	7f4080e7          	jalr	2036(ra) # 800030e8 <_Z20kern_thread_dispatchv>
                        running->endTime = SYSTEM_TIME + running->timeslice;
    800038fc:	00009797          	auipc	a5,0x9
    80003900:	3047b783          	ld	a5,772(a5) # 8000cc00 <_GLOBAL_OFFSET_TABLE_+0x20>
    80003904:	0007b703          	ld	a4,0(a5)
    80003908:	03073783          	ld	a5,48(a4)
    8000390c:	0000c697          	auipc	a3,0xc
    80003910:	4546b683          	ld	a3,1108(a3) # 8000fd60 <SYSTEM_TIME>
    80003914:	00d787b3          	add	a5,a5,a3
    80003918:	02f73c23          	sd	a5,56(a4)
                    c = kern_console_getchar();
    8000391c:	fc9ff06f          	j	800038e4 <handleEcall+0x278>
    __asm__ volatile ("mv a0, %[value]" :: [value] "r"(value));
    80003920:	00050513          	mv	a0,a0
}
    80003924:	d81ff06f          	j	800036a4 <handleEcall+0x38>
                char c = a1;
    80003928:	0ff4f493          	andi	s1,s1,255
                    res=kern_console_putchar(c);
    8000392c:	00048513          	mv	a0,s1
    80003930:	fffff097          	auipc	ra,0xfffff
    80003934:	ee8080e7          	jalr	-280(ra) # 80002818 <_Z20kern_console_putcharc>
                    if(res==-1){
    80003938:	fff00793          	li	a5,-1
    8000393c:	d6f514e3          	bne	a0,a5,800036a4 <handleEcall+0x38>
                        kern_thread_dispatch();
    80003940:	fffff097          	auipc	ra,0xfffff
    80003944:	7a8080e7          	jalr	1960(ra) # 800030e8 <_Z20kern_thread_dispatchv>
                        running->endTime = SYSTEM_TIME + running->timeslice;
    80003948:	00009797          	auipc	a5,0x9
    8000394c:	2b87b783          	ld	a5,696(a5) # 8000cc00 <_GLOBAL_OFFSET_TABLE_+0x20>
    80003950:	0007b703          	ld	a4,0(a5)
    80003954:	03073783          	ld	a5,48(a4)
    80003958:	0000c697          	auipc	a3,0xc
    8000395c:	4086b683          	ld	a3,1032(a3) # 8000fd60 <SYSTEM_TIME>
    80003960:	00d787b3          	add	a5,a5,a3
    80003964:	02f73c23          	sd	a5,56(a4)
                    res=kern_console_putchar(c);
    80003968:	fc5ff06f          	j	8000392c <handleEcall+0x2c0>

000000008000396c <handleInterrupt>:
int counter=0;
#define BUFFER_SIZE 1024
char cbuf[BUFFER_SIZE];

void handleInterrupt()
{
    8000396c:	fd010113          	addi	sp,sp,-48
    80003970:	02113423          	sd	ra,40(sp)
    80003974:	02813023          	sd	s0,32(sp)
    80003978:	00913c23          	sd	s1,24(sp)
    8000397c:	03010413          	addi	s0,sp,48
    __asm__ volatile ("csrr %[scause], scause" : [scause] "=r"(scause));
    80003980:	142027f3          	csrr	a5,scause
    80003984:	fcf43c23          	sd	a5,-40(s0)
    return scause;
    80003988:	fd843703          	ld	a4,-40(s0)
    uint64 scause = r_scause();
    if (scause == INTR_TIMER)
    8000398c:	fff00793          	li	a5,-1
    80003990:	03f79793          	slli	a5,a5,0x3f
    80003994:	00178793          	addi	a5,a5,1
    80003998:	02f70863          	beq	a4,a5,800039c8 <handleInterrupt+0x5c>
        if(SYSTEM_TIME>=running->endTime){
            kern_thread_dispatch();
            running->endTime=SYSTEM_TIME+running->timeslice;
        }
    }
    else if (scause == INTR_CONSOLE)
    8000399c:	fff00793          	li	a5,-1
    800039a0:	03f79793          	slli	a5,a5,0x3f
    800039a4:	00978793          	addi	a5,a5,9
    800039a8:	08f70463          	beq	a4,a5,80003a30 <handleInterrupt+0xc4>
            kern_uart_handler();
        }
        plic_complete(irq);
        // console_handler();
    }
    else if(scause == INTR_ILLEGAL_INSTRUCTION)
    800039ac:	00200793          	li	a5,2
    800039b0:	0af70863          	beq	a4,a5,80003a60 <handleInterrupt+0xf4>

    }
    else if(scause==INTR_ILLEGAL_ADDR_WR){

    }
}
    800039b4:	02813083          	ld	ra,40(sp)
    800039b8:	02013403          	ld	s0,32(sp)
    800039bc:	01813483          	ld	s1,24(sp)
    800039c0:	03010113          	addi	sp,sp,48
    800039c4:	00008067          	ret
        SYSTEM_TIME++;
    800039c8:	0000c497          	auipc	s1,0xc
    800039cc:	39848493          	addi	s1,s1,920 # 8000fd60 <SYSTEM_TIME>
    800039d0:	0004b503          	ld	a0,0(s1)
    800039d4:	00150513          	addi	a0,a0,1
    800039d8:	00a4b023          	sd	a0,0(s1)
    __asm__ volatile ("csrc sip, %[mask]" : : [mask] "r"(mask));
    800039dc:	00200793          	li	a5,2
    800039e0:	1447b073          	csrc	sip,a5
        kern_thread_wakeup(SYSTEM_TIME);
    800039e4:	00000097          	auipc	ra,0x0
    800039e8:	97c080e7          	jalr	-1668(ra) # 80003360 <_Z18kern_thread_wakeupm>
        if(SYSTEM_TIME>=running->endTime){
    800039ec:	00009797          	auipc	a5,0x9
    800039f0:	2147b783          	ld	a5,532(a5) # 8000cc00 <_GLOBAL_OFFSET_TABLE_+0x20>
    800039f4:	0007b783          	ld	a5,0(a5)
    800039f8:	0387b703          	ld	a4,56(a5)
    800039fc:	0004b783          	ld	a5,0(s1)
    80003a00:	fae7eae3          	bltu	a5,a4,800039b4 <handleInterrupt+0x48>
            kern_thread_dispatch();
    80003a04:	fffff097          	auipc	ra,0xfffff
    80003a08:	6e4080e7          	jalr	1764(ra) # 800030e8 <_Z20kern_thread_dispatchv>
            running->endTime=SYSTEM_TIME+running->timeslice;
    80003a0c:	00009797          	auipc	a5,0x9
    80003a10:	1f47b783          	ld	a5,500(a5) # 8000cc00 <_GLOBAL_OFFSET_TABLE_+0x20>
    80003a14:	0007b703          	ld	a4,0(a5)
    80003a18:	03073783          	ld	a5,48(a4)
    80003a1c:	0000c697          	auipc	a3,0xc
    80003a20:	3446b683          	ld	a3,836(a3) # 8000fd60 <SYSTEM_TIME>
    80003a24:	00d787b3          	add	a5,a5,a3
    80003a28:	02f73c23          	sd	a5,56(a4)
    80003a2c:	f89ff06f          	j	800039b4 <handleInterrupt+0x48>
        int irq = plic_claim();
    80003a30:	00005097          	auipc	ra,0x5
    80003a34:	804080e7          	jalr	-2044(ra) # 80008234 <plic_claim>
    80003a38:	00050493          	mv	s1,a0
        if(irq==CONSOLE_IRQ) {
    80003a3c:	00a00793          	li	a5,10
    80003a40:	00f50a63          	beq	a0,a5,80003a54 <handleInterrupt+0xe8>
        plic_complete(irq);
    80003a44:	00048513          	mv	a0,s1
    80003a48:	00005097          	auipc	ra,0x5
    80003a4c:	824080e7          	jalr	-2012(ra) # 8000826c <plic_complete>
    80003a50:	f65ff06f          	j	800039b4 <handleInterrupt+0x48>
            kern_uart_handler();
    80003a54:	fffff097          	auipc	ra,0xfffff
    80003a58:	cec080e7          	jalr	-788(ra) # 80002740 <_Z17kern_uart_handlerv>
    80003a5c:	fe9ff06f          	j	80003a44 <handleInterrupt+0xd8>
        kern_mem_free((void*)running->stack_space);
    80003a60:	00009797          	auipc	a5,0x9
    80003a64:	1a07b783          	ld	a5,416(a5) # 8000cc00 <_GLOBAL_OFFSET_TABLE_+0x20>
    80003a68:	0007b783          	ld	a5,0(a5)
    80003a6c:	0407b503          	ld	a0,64(a5)
    80003a70:	fffff097          	auipc	ra,0xfffff
    80003a74:	ab4080e7          	jalr	-1356(ra) # 80002524 <_Z13kern_mem_freePv>
        kern_thread_end_running();
    80003a78:	fffff097          	auipc	ra,0xfffff
    80003a7c:	6c8080e7          	jalr	1736(ra) # 80003140 <_Z23kern_thread_end_runningv>
}
    80003a80:	f35ff06f          	j	800039b4 <handleInterrupt+0x48>

0000000080003a84 <_Z11kmem_strcpyPcPKc>:
#define ALLOCATION_CHUNK_SIZE 16

kmem_cache_t *kmem_cache_head;


void kmem_strcpy(char* dst, const char* src) {
    80003a84:	ff010113          	addi	sp,sp,-16
    80003a88:	00813423          	sd	s0,8(sp)
    80003a8c:	01010413          	addi	s0,sp,16
    int i = 0;
    80003a90:	00000793          	li	a5,0
    while (src[i] != '\0' && i < 15) {
    80003a94:	00078713          	mv	a4,a5
    80003a98:	00f586b3          	add	a3,a1,a5
    80003a9c:	0006c683          	lbu	a3,0(a3)
    80003aa0:	00068e63          	beqz	a3,80003abc <_Z11kmem_strcpyPcPKc+0x38>
    80003aa4:	00e00613          	li	a2,14
    80003aa8:	00f64a63          	blt	a2,a5,80003abc <_Z11kmem_strcpyPcPKc+0x38>
        dst[i] = src[i];
    80003aac:	00f50733          	add	a4,a0,a5
    80003ab0:	00d70023          	sb	a3,0(a4)
        i++;
    80003ab4:	0017879b          	addiw	a5,a5,1
    while (src[i] != '\0' && i < 15) {
    80003ab8:	fddff06f          	j	80003a94 <_Z11kmem_strcpyPcPKc+0x10>
    }
    dst[i] = '\0';
    80003abc:	00e50533          	add	a0,a0,a4
    80003ac0:	00050023          	sb	zero,0(a0)
}
    80003ac4:	00813403          	ld	s0,8(sp)
    80003ac8:	01010113          	addi	sp,sp,16
    80003acc:	00008067          	ret

0000000080003ad0 <_Z9kmem_initPvi>:

void kmem_init(void *space, int block_num)
{
    80003ad0:	ff010113          	addi	sp,sp,-16
    80003ad4:	00113423          	sd	ra,8(sp)
    80003ad8:	00813023          	sd	s0,0(sp)
    80003adc:	01010413          	addi	s0,sp,16
    bba_init((char*)space,(char*)space+block_num*BLOCK_SIZE);
    80003ae0:	00c5959b          	slliw	a1,a1,0xc
    80003ae4:	00b505b3          	add	a1,a0,a1
    80003ae8:	ffffe097          	auipc	ra,0xffffe
    80003aec:	c10080e7          	jalr	-1008(ra) # 800016f8 <_Z8bba_initPcS_>
    kmem_cache_head=0;
    80003af0:	0000c797          	auipc	a5,0xc
    80003af4:	6807b023          	sd	zero,1664(a5) # 80010170 <kmem_cache_head>
}
    80003af8:	00813083          	ld	ra,8(sp)
    80003afc:	00013403          	ld	s0,0(sp)
    80003b00:	01010113          	addi	sp,sp,16
    80003b04:	00008067          	ret

0000000080003b08 <_Z14kmem_slab_initP12kmem_cache_s>:
    }
}

//creates a slab, adds it to cache list, initializes up to ALLOCATION_CHUNK_SIZE objs if needed
kmem_slab_t *kmem_slab_init(kmem_cache_t* cache)
{
    80003b08:	fd010113          	addi	sp,sp,-48
    80003b0c:	02113423          	sd	ra,40(sp)
    80003b10:	02813023          	sd	s0,32(sp)
    80003b14:	00913c23          	sd	s1,24(sp)
    80003b18:	01213823          	sd	s2,16(sp)
    80003b1c:	01313423          	sd	s3,8(sp)
    80003b20:	01413023          	sd	s4,0(sp)
    80003b24:	03010413          	addi	s0,sp,48
    80003b28:	00050913          	mv	s2,a0
    void* memory = bba_allocate(cache->memorySize);
    80003b2c:	04852503          	lw	a0,72(a0)
    80003b30:	ffffe097          	auipc	ra,0xffffe
    80003b34:	f44080e7          	jalr	-188(ra) # 80001a74 <_Z12bba_allocatem>
    80003b38:	00050a13          	mv	s4,a0
    if(memory==0) return 0;
    80003b3c:	10050a63          	beqz	a0,80003c50 <_Z14kmem_slab_initP12kmem_cache_s+0x148>

    int bitmapCharCount = (cache->slotsInSlab+8-1)/8;
    80003b40:	05092503          	lw	a0,80(s2)
    80003b44:	0075079b          	addiw	a5,a0,7
    80003b48:	41f7d51b          	sraiw	a0,a5,0x1f
    80003b4c:	01d5551b          	srliw	a0,a0,0x1d
    80003b50:	00f5053b          	addw	a0,a0,a5
    80003b54:	4035551b          	sraiw	a0,a0,0x3
    80003b58:	0005049b          	sext.w	s1,a0
    int descriptorSize = sizeof(kmem_slab_t) + bitmapCharCount*2;
    80003b5c:	0015151b          	slliw	a0,a0,0x1
    kmem_slab_t *slab = (kmem_slab_t*) bba_allocate(descriptorSize);
    80003b60:	0285051b          	addiw	a0,a0,40
    80003b64:	ffffe097          	auipc	ra,0xffffe
    80003b68:	f10080e7          	jalr	-240(ra) # 80001a74 <_Z12bba_allocatem>
    80003b6c:	00050993          	mv	s3,a0
    if(slab==0){
    80003b70:	02050663          	beqz	a0,80003b9c <_Z14kmem_slab_initP12kmem_cache_s+0x94>
        bba_free_block(memory);
        return 0;
    }

    slab->memory=memory;
    80003b74:	01453423          	sd	s4,8(a0)
    slab->freeSlotsBitmap = (char*)slab + sizeof(kmem_slab_t);
    80003b78:	02850793          	addi	a5,a0,40
    80003b7c:	00f53c23          	sd	a5,24(a0)
    slab->initializedSlotsBitmap = slab->freeSlotsBitmap + bitmapCharCount;
    80003b80:	009787b3          	add	a5,a5,s1
    80003b84:	00f53823          	sd	a5,16(a0)
    slab->usedSlotsCount=0;
    80003b88:	00052023          	sw	zero,0(a0)
    slab->initializedSlotsCount=0;
    80003b8c:	00052223          	sw	zero,4(a0)
    slab->nextSlab=0;
    80003b90:	02053023          	sd	zero,32(a0)


    //marks all slots as free, if ctor is provided initializes objects in slab, but no more than ALLOCATION_CHUNK_SIZE objects
    for (int i = 0; i < cache->slotsInSlab; i++) {
    80003b94:	00000493          	li	s1,0
    80003b98:	04c0006f          	j	80003be4 <_Z14kmem_slab_initP12kmem_cache_s+0xdc>
        bba_free_block(memory);
    80003b9c:	000a0513          	mv	a0,s4
    80003ba0:	ffffe097          	auipc	ra,0xffffe
    80003ba4:	19c080e7          	jalr	412(ra) # 80001d3c <_Z14bba_free_blockPKv>
        return 0;
    80003ba8:	0ac0006f          	j	80003c54 <_Z14kmem_slab_initP12kmem_cache_s+0x14c>
        if (cache->ctor!=0 && i < ALLOCATION_CHUNK_SIZE) {
            cache->ctor(curr);
            slab->initializedSlotsCount++;
            setBitmapValue(slab->initializedSlotsBitmap, i, SLOT_INITIALIZED);
        }
        setBitmapValue(slab->freeSlotsBitmap, i, SLOT_FREE);
    80003bac:	0189b703          	ld	a4,24(s3)
    int wordPosition = position/8;
    80003bb0:	41f4d79b          	sraiw	a5,s1,0x1f
    80003bb4:	01d7d69b          	srliw	a3,a5,0x1d
    80003bb8:	009687bb          	addw	a5,a3,s1
    80003bbc:	4037d61b          	sraiw	a2,a5,0x3
    int bitPosition = position%8;
    80003bc0:	0077f793          	andi	a5,a5,7
    80003bc4:	40d787bb          	subw	a5,a5,a3
        bitmapStart[wordPosition] = bitmapStart[wordPosition] | (1<<bitPosition);
    80003bc8:	00c70733          	add	a4,a4,a2
    80003bcc:	00070683          	lb	a3,0(a4)
    80003bd0:	00100613          	li	a2,1
    80003bd4:	00f617bb          	sllw	a5,a2,a5
    80003bd8:	00f6e7b3          	or	a5,a3,a5
    80003bdc:	00f70023          	sb	a5,0(a4)
    for (int i = 0; i < cache->slotsInSlab; i++) {
    80003be0:	0014849b          	addiw	s1,s1,1
    80003be4:	05092783          	lw	a5,80(s2)
    80003be8:	06f4d663          	bge	s1,a5,80003c54 <_Z14kmem_slab_initP12kmem_cache_s+0x14c>
        char *curr = (char*)memory + i * cache->slotSize;
    80003bec:	02093783          	ld	a5,32(s2)
    80003bf0:	02f487b3          	mul	a5,s1,a5
    80003bf4:	00fa0533          	add	a0,s4,a5
        if (cache->ctor!=0 && i < ALLOCATION_CHUNK_SIZE) {
    80003bf8:	02893783          	ld	a5,40(s2)
    80003bfc:	fa0788e3          	beqz	a5,80003bac <_Z14kmem_slab_initP12kmem_cache_s+0xa4>
    80003c00:	00f00713          	li	a4,15
    80003c04:	fa9744e3          	blt	a4,s1,80003bac <_Z14kmem_slab_initP12kmem_cache_s+0xa4>
            cache->ctor(curr);
    80003c08:	000780e7          	jalr	a5
            slab->initializedSlotsCount++;
    80003c0c:	0049a783          	lw	a5,4(s3)
    80003c10:	0017879b          	addiw	a5,a5,1
    80003c14:	00f9a223          	sw	a5,4(s3)
            setBitmapValue(slab->initializedSlotsBitmap, i, SLOT_INITIALIZED);
    80003c18:	0109b703          	ld	a4,16(s3)
    int wordPosition = position/8;
    80003c1c:	41f4d79b          	sraiw	a5,s1,0x1f
    80003c20:	01d7d69b          	srliw	a3,a5,0x1d
    80003c24:	009687bb          	addw	a5,a3,s1
    80003c28:	4037d61b          	sraiw	a2,a5,0x3
    int bitPosition = position%8;
    80003c2c:	0077f793          	andi	a5,a5,7
    80003c30:	40d787bb          	subw	a5,a5,a3
        bitmapStart[wordPosition] = bitmapStart[wordPosition] | (1<<bitPosition);
    80003c34:	00c70733          	add	a4,a4,a2
    80003c38:	00070683          	lb	a3,0(a4)
    80003c3c:	00100613          	li	a2,1
    80003c40:	00f617bb          	sllw	a5,a2,a5
    80003c44:	00f6e7b3          	or	a5,a3,a5
    80003c48:	00f70023          	sb	a5,0(a4)
    80003c4c:	f61ff06f          	j	80003bac <_Z14kmem_slab_initP12kmem_cache_s+0xa4>
    if(memory==0) return 0;
    80003c50:	00050993          	mv	s3,a0
    }

    return slab;
}
    80003c54:	00098513          	mv	a0,s3
    80003c58:	02813083          	ld	ra,40(sp)
    80003c5c:	02013403          	ld	s0,32(sp)
    80003c60:	01813483          	ld	s1,24(sp)
    80003c64:	01013903          	ld	s2,16(sp)
    80003c68:	00813983          	ld	s3,8(sp)
    80003c6c:	00013a03          	ld	s4,0(sp)
    80003c70:	03010113          	addi	sp,sp,48
    80003c74:	00008067          	ret

0000000080003c78 <_Z17kmem_cache_createPKcmPFvPvES3_>:

//creates cache with one empty slab
kmem_cache_t *kmem_cache_create(const char *name, unsigned long size,void (*ctor)(void *),void (*dtor)(void *))
{
    80003c78:	fc010113          	addi	sp,sp,-64
    80003c7c:	02113c23          	sd	ra,56(sp)
    80003c80:	02813823          	sd	s0,48(sp)
    80003c84:	02913423          	sd	s1,40(sp)
    80003c88:	03213023          	sd	s2,32(sp)
    80003c8c:	01313c23          	sd	s3,24(sp)
    80003c90:	01413823          	sd	s4,16(sp)
    80003c94:	01513423          	sd	s5,8(sp)
    80003c98:	04010413          	addi	s0,sp,64
    80003c9c:	00050a93          	mv	s5,a0
    80003ca0:	00058913          	mv	s2,a1
    80003ca4:	00060a13          	mv	s4,a2
    80003ca8:	00068993          	mv	s3,a3
    kmem_cache_t* cache = (kmem_cache_t*) bba_allocate(sizeof(kmem_cache_t));
    80003cac:	05800513          	li	a0,88
    80003cb0:	ffffe097          	auipc	ra,0xffffe
    80003cb4:	dc4080e7          	jalr	-572(ra) # 80001a74 <_Z12bba_allocatem>
    80003cb8:	00050493          	mv	s1,a0
    if(cache==0) return 0;
    80003cbc:	06050c63          	beqz	a0,80003d34 <_Z17kmem_cache_createPKcmPFvPvES3_+0xbc>

    if(size<SMALL_SIZE) cache->memorySize=SMALL_SLAB;
    80003cc0:	03f00793          	li	a5,63
    80003cc4:	0927ec63          	bltu	a5,s2,80003d5c <_Z17kmem_cache_createPKcmPFvPvES3_+0xe4>
    80003cc8:	000017b7          	lui	a5,0x1
    80003ccc:	04f52423          	sw	a5,72(a0)
    else if(size<LARGE_SIZE) cache->memorySize=MEDIUM_SLAB;
    else cache->memorySize=LARGE_SLAB;

    cache->error=0;
    80003cd0:	0404a623          	sw	zero,76(s1)
    cache->slotsInSlab = cache->memorySize/size;
    80003cd4:	0484a783          	lw	a5,72(s1)
    80003cd8:	0327d7b3          	divu	a5,a5,s2
    80003cdc:	04f4a823          	sw	a5,80(s1)
    cache->slotSize=size;
    80003ce0:	0324b023          	sd	s2,32(s1)
    cache->dtor=dtor;
    80003ce4:	0334b823          	sd	s3,48(s1)
    cache->ctor=ctor;
    80003ce8:	0344b423          	sd	s4,40(s1)
    cache->emptySlabsHead=0;
    80003cec:	0004b023          	sd	zero,0(s1)
    cache->usedSlabsHead=0;
    80003cf0:	0004b423          	sd	zero,8(s1)
    cache->fullSlabsHead=0;
    80003cf4:	0004b823          	sd	zero,16(s1)
    kmem_strcpy(cache->name,name);
    80003cf8:	000a8593          	mv	a1,s5
    80003cfc:	03848513          	addi	a0,s1,56
    80003d00:	00000097          	auipc	ra,0x0
    80003d04:	d84080e7          	jalr	-636(ra) # 80003a84 <_Z11kmem_strcpyPcPKc>

    kmem_slab_t * slab = kmem_slab_init(cache);
    80003d08:	00048513          	mv	a0,s1
    80003d0c:	00000097          	auipc	ra,0x0
    80003d10:	dfc080e7          	jalr	-516(ra) # 80003b08 <_Z14kmem_slab_initP12kmem_cache_s>
    80003d14:	00050913          	mv	s2,a0
    if(slab==0){
    80003d18:	06050263          	beqz	a0,80003d7c <_Z17kmem_cache_createPKcmPFvPvES3_+0x104>
        bba_free_block(cache);
        return 0;
    }
    cache->emptySlabsHead=slab;
    80003d1c:	00a4b023          	sd	a0,0(s1)

    cache->nextCache=kmem_cache_head;
    80003d20:	0000c797          	auipc	a5,0xc
    80003d24:	45078793          	addi	a5,a5,1104 # 80010170 <kmem_cache_head>
    80003d28:	0007b703          	ld	a4,0(a5)
    80003d2c:	00e4bc23          	sd	a4,24(s1)
    kmem_cache_head=cache;
    80003d30:	0097b023          	sd	s1,0(a5)
    return cache;
}
    80003d34:	00048513          	mv	a0,s1
    80003d38:	03813083          	ld	ra,56(sp)
    80003d3c:	03013403          	ld	s0,48(sp)
    80003d40:	02813483          	ld	s1,40(sp)
    80003d44:	02013903          	ld	s2,32(sp)
    80003d48:	01813983          	ld	s3,24(sp)
    80003d4c:	01013a03          	ld	s4,16(sp)
    80003d50:	00813a83          	ld	s5,8(sp)
    80003d54:	04010113          	addi	sp,sp,64
    80003d58:	00008067          	ret
    else if(size<LARGE_SIZE) cache->memorySize=MEDIUM_SLAB;
    80003d5c:	0ff00793          	li	a5,255
    80003d60:	0127e863          	bltu	a5,s2,80003d70 <_Z17kmem_cache_createPKcmPFvPvES3_+0xf8>
    80003d64:	000027b7          	lui	a5,0x2
    80003d68:	04f52423          	sw	a5,72(a0)
    80003d6c:	f65ff06f          	j	80003cd0 <_Z17kmem_cache_createPKcmPFvPvES3_+0x58>
    else cache->memorySize=LARGE_SLAB;
    80003d70:	000047b7          	lui	a5,0x4
    80003d74:	04f52423          	sw	a5,72(a0)
    80003d78:	f59ff06f          	j	80003cd0 <_Z17kmem_cache_createPKcmPFvPvES3_+0x58>
        bba_free_block(cache);
    80003d7c:	00048513          	mv	a0,s1
    80003d80:	ffffe097          	auipc	ra,0xffffe
    80003d84:	fbc080e7          	jalr	-68(ra) # 80001d3c <_Z14bba_free_blockPKv>
        return 0;
    80003d88:	00090493          	mv	s1,s2
    80003d8c:	fa9ff06f          	j	80003d34 <_Z17kmem_cache_createPKcmPFvPvES3_+0xbc>

0000000080003d90 <_Z24kmem_slab_destoy_objectsP11kmem_slab_sP12kmem_cache_s>:

void kmem_slab_destoy_objects(kmem_slab_t* slab, kmem_cache_t* cache)
{
    80003d90:	fd010113          	addi	sp,sp,-48
    80003d94:	02113423          	sd	ra,40(sp)
    80003d98:	02813023          	sd	s0,32(sp)
    80003d9c:	00913c23          	sd	s1,24(sp)
    80003da0:	01213823          	sd	s2,16(sp)
    80003da4:	01313423          	sd	s3,8(sp)
    80003da8:	03010413          	addi	s0,sp,48
    80003dac:	00050913          	mv	s2,a0
    80003db0:	00058993          	mv	s3,a1
    for(int i=0;i < (cache->slotsInSlab) && (slab->initializedSlotsCount>0); i++){
    80003db4:	00000493          	li	s1,0
    80003db8:	0080006f          	j	80003dc0 <_Z24kmem_slab_destoy_objectsP11kmem_slab_sP12kmem_cache_s+0x30>
    80003dbc:	0014849b          	addiw	s1,s1,1
    80003dc0:	0509a783          	lw	a5,80(s3)
    80003dc4:	06f4d063          	bge	s1,a5,80003e24 <_Z24kmem_slab_destoy_objectsP11kmem_slab_sP12kmem_cache_s+0x94>
    80003dc8:	00492783          	lw	a5,4(s2)
    80003dcc:	04f05c63          	blez	a5,80003e24 <_Z24kmem_slab_destoy_objectsP11kmem_slab_sP12kmem_cache_s+0x94>
       if(getBitmapValue(slab->initializedSlotsBitmap,i)==SLOT_INITIALIZED){
    80003dd0:	01093703          	ld	a4,16(s2)
    int wordPosition = position/8;
    80003dd4:	41f4d79b          	sraiw	a5,s1,0x1f
    80003dd8:	01d7d79b          	srliw	a5,a5,0x1d
    80003ddc:	009787bb          	addw	a5,a5,s1
    80003de0:	4037d79b          	sraiw	a5,a5,0x3
    return (bitmapStart[wordPosition]>>position)&1;
    80003de4:	00f707b3          	add	a5,a4,a5
    80003de8:	0007c783          	lbu	a5,0(a5) # 4000 <_entry-0x7fffc000>
    80003dec:	4097d7bb          	sraw	a5,a5,s1
    80003df0:	0017f793          	andi	a5,a5,1
       if(getBitmapValue(slab->initializedSlotsBitmap,i)==SLOT_INITIALIZED){
    80003df4:	fc0784e3          	beqz	a5,80003dbc <_Z24kmem_slab_destoy_objectsP11kmem_slab_sP12kmem_cache_s+0x2c>
           cache->dtor((char*)(slab->memory)+i*cache->slotSize);
    80003df8:	0309b703          	ld	a4,48(s3)
    80003dfc:	00893503          	ld	a0,8(s2)
    80003e00:	0209b783          	ld	a5,32(s3)
    80003e04:	02f487b3          	mul	a5,s1,a5
    80003e08:	00f50533          	add	a0,a0,a5
    80003e0c:	000700e7          	jalr	a4
           slab->initializedSlotsCount--;
    80003e10:	00492783          	lw	a5,4(s2)
    80003e14:	fff7879b          	addiw	a5,a5,-1
    80003e18:	0007871b          	sext.w	a4,a5
    80003e1c:	00f92223          	sw	a5,4(s2)
           if(slab->initializedSlotsCount==0) return;
    80003e20:	f8071ee3          	bnez	a4,80003dbc <_Z24kmem_slab_destoy_objectsP11kmem_slab_sP12kmem_cache_s+0x2c>
       }
    }
}
    80003e24:	02813083          	ld	ra,40(sp)
    80003e28:	02013403          	ld	s0,32(sp)
    80003e2c:	01813483          	ld	s1,24(sp)
    80003e30:	01013903          	ld	s2,16(sp)
    80003e34:	00813983          	ld	s3,8(sp)
    80003e38:	03010113          	addi	sp,sp,48
    80003e3c:	00008067          	ret

0000000080003e40 <_Z17kmem_cache_shrinkP12kmem_cache_s>:


int kmem_cache_shrink(kmem_cache_t *cachep)
{
    80003e40:	fd010113          	addi	sp,sp,-48
    80003e44:	02113423          	sd	ra,40(sp)
    80003e48:	02813023          	sd	s0,32(sp)
    80003e4c:	00913c23          	sd	s1,24(sp)
    80003e50:	01213823          	sd	s2,16(sp)
    80003e54:	01313423          	sd	s3,8(sp)
    80003e58:	03010413          	addi	s0,sp,48
    80003e5c:	00050913          	mv	s2,a0
    kmem_slab_t *curr = cachep->emptySlabsHead;
    80003e60:	00053483          	ld	s1,0(a0)
    kmem_slab_t *prev = 0;
    80003e64:	0300006f          	j	80003e94 <_Z17kmem_cache_shrinkP12kmem_cache_s+0x54>
    while (curr!=0){
        prev=curr;
        curr=curr->nextSlab;

        if(cachep->ctor!=0){
            kmem_slab_destoy_objects(prev,cachep);
    80003e68:	00090593          	mv	a1,s2
    80003e6c:	00048513          	mv	a0,s1
    80003e70:	00000097          	auipc	ra,0x0
    80003e74:	f20080e7          	jalr	-224(ra) # 80003d90 <_Z24kmem_slab_destoy_objectsP11kmem_slab_sP12kmem_cache_s>
        }

        bba_free_block(prev->memory);
    80003e78:	0084b503          	ld	a0,8(s1)
    80003e7c:	ffffe097          	auipc	ra,0xffffe
    80003e80:	ec0080e7          	jalr	-320(ra) # 80001d3c <_Z14bba_free_blockPKv>
        bba_free_block(prev);
    80003e84:	00048513          	mv	a0,s1
    80003e88:	ffffe097          	auipc	ra,0xffffe
    80003e8c:	eb4080e7          	jalr	-332(ra) # 80001d3c <_Z14bba_free_blockPKv>
        curr=curr->nextSlab;
    80003e90:	00098493          	mv	s1,s3
    while (curr!=0){
    80003e94:	00048a63          	beqz	s1,80003ea8 <_Z17kmem_cache_shrinkP12kmem_cache_s+0x68>
        curr=curr->nextSlab;
    80003e98:	0204b983          	ld	s3,32(s1)
        if(cachep->ctor!=0){
    80003e9c:	02893783          	ld	a5,40(s2)
    80003ea0:	fc0794e3          	bnez	a5,80003e68 <_Z17kmem_cache_shrinkP12kmem_cache_s+0x28>
    80003ea4:	fd5ff06f          	j	80003e78 <_Z17kmem_cache_shrinkP12kmem_cache_s+0x38>
    }

    cachep->emptySlabsHead=0;
    80003ea8:	00093023          	sd	zero,0(s2)
    return 0;
}
    80003eac:	00000513          	li	a0,0
    80003eb0:	02813083          	ld	ra,40(sp)
    80003eb4:	02013403          	ld	s0,32(sp)
    80003eb8:	01813483          	ld	s1,24(sp)
    80003ebc:	01013903          	ld	s2,16(sp)
    80003ec0:	00813983          	ld	s3,8(sp)
    80003ec4:	03010113          	addi	sp,sp,48
    80003ec8:	00008067          	ret

0000000080003ecc <_Z27kmem_slab_construct_objectsP11kmem_slab_sP12kmem_cache_s>:

//initialize up to ALLOCATION_CHUNK_SIZE objects in a given slab
void kmem_slab_construct_objects(kmem_slab_t *slab, kmem_cache_t *cache)
{
    80003ecc:	fc010113          	addi	sp,sp,-64
    80003ed0:	02113c23          	sd	ra,56(sp)
    80003ed4:	02813823          	sd	s0,48(sp)
    80003ed8:	02913423          	sd	s1,40(sp)
    80003edc:	03213023          	sd	s2,32(sp)
    80003ee0:	01313c23          	sd	s3,24(sp)
    80003ee4:	01413823          	sd	s4,16(sp)
    80003ee8:	01513423          	sd	s5,8(sp)
    80003eec:	04010413          	addi	s0,sp,64
    80003ef0:	00050993          	mv	s3,a0
    80003ef4:	00058a13          	mv	s4,a1
    int count=0;
    for(int i=0;i<cache->slotsInSlab;i++){
    80003ef8:	00000913          	li	s2,0
    int count=0;
    80003efc:	00000a93          	li	s5,0
    80003f00:	0080006f          	j	80003f08 <_Z27kmem_slab_construct_objectsP11kmem_slab_sP12kmem_cache_s+0x3c>
    for(int i=0;i<cache->slotsInSlab;i++){
    80003f04:	0019091b          	addiw	s2,s2,1
    80003f08:	050a2783          	lw	a5,80(s4)
    80003f0c:	0af95863          	bge	s2,a5,80003fbc <_Z27kmem_slab_construct_objectsP11kmem_slab_sP12kmem_cache_s+0xf0>
        if(getBitmapValue(slab->freeSlotsBitmap,i)==SLOT_FREE &&
    80003f10:	0189b783          	ld	a5,24(s3)
    int wordPosition = position/8;
    80003f14:	41f9549b          	sraiw	s1,s2,0x1f
    80003f18:	01d4d49b          	srliw	s1,s1,0x1d
    80003f1c:	012484bb          	addw	s1,s1,s2
    80003f20:	4034d49b          	sraiw	s1,s1,0x3
    return (bitmapStart[wordPosition]>>position)&1;
    80003f24:	009787b3          	add	a5,a5,s1
    80003f28:	0007c783          	lbu	a5,0(a5)
    80003f2c:	4127d7bb          	sraw	a5,a5,s2
    80003f30:	0017f793          	andi	a5,a5,1
        if(getBitmapValue(slab->freeSlotsBitmap,i)==SLOT_FREE &&
    80003f34:	fc0788e3          	beqz	a5,80003f04 <_Z27kmem_slab_construct_objectsP11kmem_slab_sP12kmem_cache_s+0x38>
           getBitmapValue(slab->initializedSlotsBitmap,i)!=SLOT_INITIALIZED)
    80003f38:	0109b783          	ld	a5,16(s3)
    return (bitmapStart[wordPosition]>>position)&1;
    80003f3c:	009787b3          	add	a5,a5,s1
    80003f40:	0007c783          	lbu	a5,0(a5)
    80003f44:	4127d7bb          	sraw	a5,a5,s2
    80003f48:	0017f793          	andi	a5,a5,1
        if(getBitmapValue(slab->freeSlotsBitmap,i)==SLOT_FREE &&
    80003f4c:	fa079ce3          	bnez	a5,80003f04 <_Z27kmem_slab_construct_objectsP11kmem_slab_sP12kmem_cache_s+0x38>
        {
            cache->ctor((char*)(slab->memory)+i*cache->slotSize);
    80003f50:	028a3703          	ld	a4,40(s4)
    80003f54:	0089b503          	ld	a0,8(s3)
    80003f58:	020a3783          	ld	a5,32(s4)
    80003f5c:	02f907b3          	mul	a5,s2,a5
    80003f60:	00f50533          	add	a0,a0,a5
    80003f64:	000700e7          	jalr	a4
            slab->initializedSlotsCount++;
    80003f68:	0049a783          	lw	a5,4(s3)
    80003f6c:	0017879b          	addiw	a5,a5,1
    80003f70:	00f9a223          	sw	a5,4(s3)
            setBitmapValue(slab->initializedSlotsBitmap,i,SLOT_INITIALIZED);
    80003f74:	0109b703          	ld	a4,16(s3)
    int bitPosition = position%8;
    80003f78:	41f9579b          	sraiw	a5,s2,0x1f
    80003f7c:	01d7d69b          	srliw	a3,a5,0x1d
    80003f80:	012687bb          	addw	a5,a3,s2
    80003f84:	0077f793          	andi	a5,a5,7
    80003f88:	40d787bb          	subw	a5,a5,a3
        bitmapStart[wordPosition] = bitmapStart[wordPosition] | (1<<bitPosition);
    80003f8c:	009704b3          	add	s1,a4,s1
    80003f90:	00048703          	lb	a4,0(s1)
    80003f94:	00100693          	li	a3,1
    80003f98:	00f697bb          	sllw	a5,a3,a5
    80003f9c:	00f767b3          	or	a5,a4,a5
    80003fa0:	00f48023          	sb	a5,0(s1)
            count++;
    80003fa4:	001a8a9b          	addiw	s5,s5,1
            if(count==ALLOCATION_CHUNK_SIZE || slab->initializedSlotsCount==cache->slotsInSlab) return;
    80003fa8:	01000793          	li	a5,16
    80003fac:	00fa8863          	beq	s5,a5,80003fbc <_Z27kmem_slab_construct_objectsP11kmem_slab_sP12kmem_cache_s+0xf0>
    80003fb0:	0049a703          	lw	a4,4(s3)
    80003fb4:	050a2783          	lw	a5,80(s4)
    80003fb8:	f4f716e3          	bne	a4,a5,80003f04 <_Z27kmem_slab_construct_objectsP11kmem_slab_sP12kmem_cache_s+0x38>
        }
    }
}
    80003fbc:	03813083          	ld	ra,56(sp)
    80003fc0:	03013403          	ld	s0,48(sp)
    80003fc4:	02813483          	ld	s1,40(sp)
    80003fc8:	02013903          	ld	s2,32(sp)
    80003fcc:	01813983          	ld	s3,24(sp)
    80003fd0:	01013a03          	ld	s4,16(sp)
    80003fd4:	00813a83          	ld	s5,8(sp)
    80003fd8:	04010113          	addi	sp,sp,64
    80003fdc:	00008067          	ret

0000000080003fe0 <_Z25kmem_slab_get_free_objectP11kmem_slab_sP12kmem_cache_s>:



void* kmem_slab_get_free_object(kmem_slab_t *slab, kmem_cache_t *cache)
{
    80003fe0:	ff010113          	addi	sp,sp,-16
    80003fe4:	00813423          	sd	s0,8(sp)
    80003fe8:	01010413          	addi	s0,sp,16
    int charCnt = (cache->slotsInSlab+8-1)/8;
    80003fec:	0505a783          	lw	a5,80(a1)
    80003ff0:	0077871b          	addiw	a4,a5,7
    80003ff4:	41f7579b          	sraiw	a5,a4,0x1f
    80003ff8:	01d7d79b          	srliw	a5,a5,0x1d
    80003ffc:	00e787bb          	addw	a5,a5,a4
    80004000:	4037d79b          	sraiw	a5,a5,0x3
    for(int i=0;i<charCnt;i++){
    80004004:	00000693          	li	a3,0
    80004008:	0af6d263          	bge	a3,a5,800040ac <_Z25kmem_slab_get_free_objectP11kmem_slab_sP12kmem_cache_s+0xcc>
        char c = slab->freeSlotsBitmap[i];
    8000400c:	01853803          	ld	a6,24(a0)
    80004010:	00d80733          	add	a4,a6,a3
    80004014:	00074603          	lbu	a2,0(a4)
        if(c==0) continue; //a quick way to check 8 slots at once
    80004018:	02060263          	beqz	a2,8000403c <_Z25kmem_slab_get_free_objectP11kmem_slab_sP12kmem_cache_s+0x5c>
        int k = 0;
    8000401c:	00000793          	li	a5,0
        while(k<8){
    80004020:	00700713          	li	a4,7
    80004024:	02f74063          	blt	a4,a5,80004044 <_Z25kmem_slab_get_free_objectP11kmem_slab_sP12kmem_cache_s+0x64>
            if( ((c>>k)&1) == SLOT_FREE) break;
    80004028:	40f6573b          	sraw	a4,a2,a5
    8000402c:	00177713          	andi	a4,a4,1
    80004030:	00071a63          	bnez	a4,80004044 <_Z25kmem_slab_get_free_objectP11kmem_slab_sP12kmem_cache_s+0x64>
            k++;
    80004034:	0017879b          	addiw	a5,a5,1
        while(k<8){
    80004038:	fe9ff06f          	j	80004020 <_Z25kmem_slab_get_free_objectP11kmem_slab_sP12kmem_cache_s+0x40>
    for(int i=0;i<charCnt;i++){
    8000403c:	0016869b          	addiw	a3,a3,1
    80004040:	fc9ff06f          	j	80004008 <_Z25kmem_slab_get_free_objectP11kmem_slab_sP12kmem_cache_s+0x28>
        }

        slab->usedSlotsCount++;
    80004044:	00052703          	lw	a4,0(a0)
    80004048:	0017071b          	addiw	a4,a4,1
    8000404c:	00e52023          	sw	a4,0(a0)
        setBitmapValue(slab->freeSlotsBitmap,i*8+k,SLOT_TAKEN);
    80004050:	0036969b          	slliw	a3,a3,0x3
    80004054:	00f687bb          	addw	a5,a3,a5
    80004058:	0007869b          	sext.w	a3,a5
    int wordPosition = position/8;
    8000405c:	41f7d71b          	sraiw	a4,a5,0x1f
    80004060:	01d7571b          	srliw	a4,a4,0x1d
    80004064:	00f707bb          	addw	a5,a4,a5
    80004068:	4037d61b          	sraiw	a2,a5,0x3
    int bitPosition = position%8;
    8000406c:	0077f793          	andi	a5,a5,7
    80004070:	40e787bb          	subw	a5,a5,a4
        bitmapStart[wordPosition] = bitmapStart[wordPosition] & (~(1<<bitPosition));
    80004074:	00c80833          	add	a6,a6,a2
    80004078:	00080603          	lb	a2,0(a6)
    8000407c:	00100713          	li	a4,1
    80004080:	00f717bb          	sllw	a5,a4,a5
    80004084:	fff7c793          	not	a5,a5
    80004088:	00f677b3          	and	a5,a2,a5
    8000408c:	00f80023          	sb	a5,0(a6)
        return ((char*)slab->memory+(i*8+k)*cache->slotSize);
    80004090:	00853503          	ld	a0,8(a0)
    80004094:	0205b783          	ld	a5,32(a1)
    80004098:	02f687b3          	mul	a5,a3,a5
    8000409c:	00f50533          	add	a0,a0,a5
    }
    return 0;
}
    800040a0:	00813403          	ld	s0,8(sp)
    800040a4:	01010113          	addi	sp,sp,16
    800040a8:	00008067          	ret
    return 0;
    800040ac:	00000513          	li	a0,0
    800040b0:	ff1ff06f          	j	800040a0 <_Z25kmem_slab_get_free_objectP11kmem_slab_sP12kmem_cache_s+0xc0>

00000000800040b4 <_Z37kmem_slab_get_initialized_free_objectP11kmem_slab_sP12kmem_cache_s>:

void* kmem_slab_get_initialized_free_object(kmem_slab_t *slab, kmem_cache_t *cache)
{
    800040b4:	ff010113          	addi	sp,sp,-16
    800040b8:	00813423          	sd	s0,8(sp)
    800040bc:	01010413          	addi	s0,sp,16
    int charCnt = (cache->slotsInSlab+8-1)/8;
    800040c0:	0505a783          	lw	a5,80(a1)
    800040c4:	0077871b          	addiw	a4,a5,7
    800040c8:	41f7579b          	sraiw	a5,a4,0x1f
    800040cc:	01d7d79b          	srliw	a5,a5,0x1d
    800040d0:	00e787bb          	addw	a5,a5,a4
    800040d4:	4037d79b          	sraiw	a5,a5,0x3
    for(int i=0;i<charCnt;i++){
    800040d8:	00000693          	li	a3,0
    800040dc:	0af6de63          	bge	a3,a5,80004198 <_Z37kmem_slab_get_initialized_free_objectP11kmem_slab_sP12kmem_cache_s+0xe4>
        char c = (char)(slab->initializedSlotsBitmap[i]&slab->freeSlotsBitmap[i]);
    800040e0:	01053703          	ld	a4,16(a0)
    800040e4:	00d70733          	add	a4,a4,a3
    800040e8:	00074603          	lbu	a2,0(a4)
    800040ec:	01853883          	ld	a7,24(a0)
    800040f0:	00d88733          	add	a4,a7,a3
    800040f4:	00074703          	lbu	a4,0(a4)
    800040f8:	00e67633          	and	a2,a2,a4
        if(c==0) continue; //a quick way to check 8 slots at once
    800040fc:	02060663          	beqz	a2,80004128 <_Z37kmem_slab_get_initialized_free_objectP11kmem_slab_sP12kmem_cache_s+0x74>
        int k = 0;
    80004100:	00000713          	li	a4,0
        while(k<8){
    80004104:	00700793          	li	a5,7
    80004108:	02e7c463          	blt	a5,a4,80004130 <_Z37kmem_slab_get_initialized_free_objectP11kmem_slab_sP12kmem_cache_s+0x7c>
            if( (c&(1<<k)) == SLOT_INITIALIZED) break;
    8000410c:	00100793          	li	a5,1
    80004110:	00e797bb          	sllw	a5,a5,a4
    80004114:	00f677b3          	and	a5,a2,a5
    80004118:	00100813          	li	a6,1
    8000411c:	01078a63          	beq	a5,a6,80004130 <_Z37kmem_slab_get_initialized_free_objectP11kmem_slab_sP12kmem_cache_s+0x7c>
            k++;
    80004120:	0017071b          	addiw	a4,a4,1
        while(k<8){
    80004124:	fe1ff06f          	j	80004104 <_Z37kmem_slab_get_initialized_free_objectP11kmem_slab_sP12kmem_cache_s+0x50>
    for(int i=0;i<charCnt;i++){
    80004128:	0016869b          	addiw	a3,a3,1
    8000412c:	fb1ff06f          	j	800040dc <_Z37kmem_slab_get_initialized_free_objectP11kmem_slab_sP12kmem_cache_s+0x28>
        }

        slab->usedSlotsCount++;
    80004130:	00052783          	lw	a5,0(a0)
    80004134:	0017879b          	addiw	a5,a5,1
    80004138:	00f52023          	sw	a5,0(a0)
        setBitmapValue(slab->freeSlotsBitmap,i*8+k,SLOT_TAKEN);
    8000413c:	0036969b          	slliw	a3,a3,0x3
    80004140:	00e6873b          	addw	a4,a3,a4
    80004144:	0007069b          	sext.w	a3,a4
    int wordPosition = position/8;
    80004148:	41f7579b          	sraiw	a5,a4,0x1f
    8000414c:	01d7d79b          	srliw	a5,a5,0x1d
    80004150:	00e7873b          	addw	a4,a5,a4
    80004154:	4037561b          	sraiw	a2,a4,0x3
    int bitPosition = position%8;
    80004158:	00777713          	andi	a4,a4,7
    8000415c:	40f7073b          	subw	a4,a4,a5
        bitmapStart[wordPosition] = bitmapStart[wordPosition] & (~(1<<bitPosition));
    80004160:	00c888b3          	add	a7,a7,a2
    80004164:	00088603          	lb	a2,0(a7)
    80004168:	00100793          	li	a5,1
    8000416c:	00e7973b          	sllw	a4,a5,a4
    80004170:	fff74713          	not	a4,a4
    80004174:	00e67733          	and	a4,a2,a4
    80004178:	00e88023          	sb	a4,0(a7)
        return ((char*)slab->memory+(i*8+k)*cache->slotSize);
    8000417c:	00853503          	ld	a0,8(a0)
    80004180:	0205b783          	ld	a5,32(a1)
    80004184:	02f687b3          	mul	a5,a3,a5
    80004188:	00f50533          	add	a0,a0,a5
    }
    return 0;
}
    8000418c:	00813403          	ld	s0,8(sp)
    80004190:	01010113          	addi	sp,sp,16
    80004194:	00008067          	ret
    return 0;
    80004198:	00000513          	li	a0,0
    8000419c:	ff1ff06f          	j	8000418c <_Z37kmem_slab_get_initialized_free_objectP11kmem_slab_sP12kmem_cache_s+0xd8>

00000000800041a0 <_Z31kmem_cache_alloc_no_constructorP12kmem_cache_s>:


void *kmem_cache_alloc_no_constructor(kmem_cache_t* cachep)
{
    800041a0:	fe010113          	addi	sp,sp,-32
    800041a4:	00113c23          	sd	ra,24(sp)
    800041a8:	00813823          	sd	s0,16(sp)
    800041ac:	00913423          	sd	s1,8(sp)
    800041b0:	02010413          	addi	s0,sp,32
    800041b4:	00050493          	mv	s1,a0
    if(cachep->usedSlabsHead==0){
    800041b8:	00853503          	ld	a0,8(a0)
    800041bc:	04051863          	bnez	a0,8000420c <_Z31kmem_cache_alloc_no_constructorP12kmem_cache_s+0x6c>
        if(cachep->emptySlabsHead==0){
    800041c0:	0004b783          	ld	a5,0(s1)
    800041c4:	02078a63          	beqz	a5,800041f8 <_Z31kmem_cache_alloc_no_constructorP12kmem_cache_s+0x58>
            cachep->usedSlabsHead = kmem_slab_init(cachep);
        }
        else {
            cachep->usedSlabsHead=cachep->emptySlabsHead;
    800041c8:	00f4b423          	sd	a5,8(s1)
            cachep->emptySlabsHead=cachep->emptySlabsHead->nextSlab;
    800041cc:	0207b783          	ld	a5,32(a5)
    800041d0:	00f4b023          	sd	a5,0(s1)
        }
        return kmem_slab_get_free_object(cachep->usedSlabsHead,cachep);
    800041d4:	00048593          	mv	a1,s1
    800041d8:	0084b503          	ld	a0,8(s1)
    800041dc:	00000097          	auipc	ra,0x0
    800041e0:	e04080e7          	jalr	-508(ra) # 80003fe0 <_Z25kmem_slab_get_free_objectP11kmem_slab_sP12kmem_cache_s>
            head->nextSlab=cachep->fullSlabsHead;
            cachep->fullSlabsHead=head;
        }
        return result;
    }
}
    800041e4:	01813083          	ld	ra,24(sp)
    800041e8:	01013403          	ld	s0,16(sp)
    800041ec:	00813483          	ld	s1,8(sp)
    800041f0:	02010113          	addi	sp,sp,32
    800041f4:	00008067          	ret
            cachep->usedSlabsHead = kmem_slab_init(cachep);
    800041f8:	00048513          	mv	a0,s1
    800041fc:	00000097          	auipc	ra,0x0
    80004200:	90c080e7          	jalr	-1780(ra) # 80003b08 <_Z14kmem_slab_initP12kmem_cache_s>
    80004204:	00a4b423          	sd	a0,8(s1)
    80004208:	fcdff06f          	j	800041d4 <_Z31kmem_cache_alloc_no_constructorP12kmem_cache_s+0x34>
        void* result = kmem_slab_get_free_object(cachep->usedSlabsHead,cachep);
    8000420c:	00048593          	mv	a1,s1
    80004210:	00000097          	auipc	ra,0x0
    80004214:	dd0080e7          	jalr	-560(ra) # 80003fe0 <_Z25kmem_slab_get_free_objectP11kmem_slab_sP12kmem_cache_s>
        kmem_slab_t* head = cachep->usedSlabsHead;
    80004218:	0084b783          	ld	a5,8(s1)
        if(head->usedSlotsCount==cachep->slotsInSlab){
    8000421c:	0007a683          	lw	a3,0(a5)
    80004220:	0504a703          	lw	a4,80(s1)
    80004224:	fce690e3          	bne	a3,a4,800041e4 <_Z31kmem_cache_alloc_no_constructorP12kmem_cache_s+0x44>
            cachep->usedSlabsHead=head->nextSlab;
    80004228:	0207b703          	ld	a4,32(a5)
    8000422c:	00e4b423          	sd	a4,8(s1)
            head->nextSlab=cachep->fullSlabsHead;
    80004230:	0104b703          	ld	a4,16(s1)
    80004234:	02e7b023          	sd	a4,32(a5)
            cachep->fullSlabsHead=head;
    80004238:	00f4b823          	sd	a5,16(s1)
        return result;
    8000423c:	fa9ff06f          	j	800041e4 <_Z31kmem_cache_alloc_no_constructorP12kmem_cache_s+0x44>

0000000080004240 <_Z28kmem_cache_alloc_constructorP12kmem_cache_s>:


void *kmem_cache_alloc_constructor(kmem_cache_t *cachep)
{
    80004240:	fd010113          	addi	sp,sp,-48
    80004244:	02113423          	sd	ra,40(sp)
    80004248:	02813023          	sd	s0,32(sp)
    8000424c:	00913c23          	sd	s1,24(sp)
    80004250:	01213823          	sd	s2,16(sp)
    80004254:	01313423          	sd	s3,8(sp)
    80004258:	03010413          	addi	s0,sp,48
    8000425c:	00050913          	mv	s2,a0
    if(cachep->usedSlabsHead==0){
    80004260:	00853983          	ld	s3,8(a0)
    80004264:	02098063          	beqz	s3,80004284 <_Z28kmem_cache_alloc_constructorP12kmem_cache_s+0x44>
            cachep->emptySlabsHead=cachep->emptySlabsHead->nextSlab;
        }
        return kmem_slab_get_initialized_free_object(cachep->usedSlabsHead,cachep);
    }
    else{
        kmem_slab_t* target = cachep->usedSlabsHead;
    80004268:	00098493          	mv	s1,s3
        while (target!=0){
    8000426c:	06048463          	beqz	s1,800042d4 <_Z28kmem_cache_alloc_constructorP12kmem_cache_s+0x94>
            if(target->initializedSlotsCount>target->usedSlotsCount) break;
    80004270:	0044a703          	lw	a4,4(s1)
    80004274:	0004a783          	lw	a5,0(s1)
    80004278:	04e7ce63          	blt	a5,a4,800042d4 <_Z28kmem_cache_alloc_constructorP12kmem_cache_s+0x94>
            target=target->nextSlab;
    8000427c:	0204b483          	ld	s1,32(s1)
        while (target!=0){
    80004280:	fedff06f          	j	8000426c <_Z28kmem_cache_alloc_constructorP12kmem_cache_s+0x2c>
        if(cachep->emptySlabsHead==0){
    80004284:	00053783          	ld	a5,0(a0)
    80004288:	02078e63          	beqz	a5,800042c4 <_Z28kmem_cache_alloc_constructorP12kmem_cache_s+0x84>
            cachep->usedSlabsHead=cachep->emptySlabsHead;
    8000428c:	00f53423          	sd	a5,8(a0)
            cachep->emptySlabsHead=cachep->emptySlabsHead->nextSlab;
    80004290:	0207b783          	ld	a5,32(a5)
    80004294:	00f53023          	sd	a5,0(a0)
        return kmem_slab_get_initialized_free_object(cachep->usedSlabsHead,cachep);
    80004298:	00090593          	mv	a1,s2
    8000429c:	00893503          	ld	a0,8(s2)
    800042a0:	00000097          	auipc	ra,0x0
    800042a4:	e14080e7          	jalr	-492(ra) # 800040b4 <_Z37kmem_slab_get_initialized_free_objectP11kmem_slab_sP12kmem_cache_s>
            target->nextSlab=cachep->fullSlabsHead;
            cachep->fullSlabsHead=target;
        }
        return result;
    }
}
    800042a8:	02813083          	ld	ra,40(sp)
    800042ac:	02013403          	ld	s0,32(sp)
    800042b0:	01813483          	ld	s1,24(sp)
    800042b4:	01013903          	ld	s2,16(sp)
    800042b8:	00813983          	ld	s3,8(sp)
    800042bc:	03010113          	addi	sp,sp,48
    800042c0:	00008067          	ret
            cachep->usedSlabsHead = kmem_slab_init(cachep);
    800042c4:	00000097          	auipc	ra,0x0
    800042c8:	844080e7          	jalr	-1980(ra) # 80003b08 <_Z14kmem_slab_initP12kmem_cache_s>
    800042cc:	00a93423          	sd	a0,8(s2)
    800042d0:	fc9ff06f          	j	80004298 <_Z28kmem_cache_alloc_constructorP12kmem_cache_s+0x58>
        if(target==0){
    800042d4:	04048663          	beqz	s1,80004320 <_Z28kmem_cache_alloc_constructorP12kmem_cache_s+0xe0>
        void* result = kmem_slab_get_initialized_free_object(target,cachep);
    800042d8:	00090593          	mv	a1,s2
    800042dc:	00048513          	mv	a0,s1
    800042e0:	00000097          	auipc	ra,0x0
    800042e4:	dd4080e7          	jalr	-556(ra) # 800040b4 <_Z37kmem_slab_get_initialized_free_objectP11kmem_slab_sP12kmem_cache_s>
        if(target->usedSlotsCount==cachep->slotsInSlab){
    800042e8:	0004a703          	lw	a4,0(s1)
    800042ec:	05092783          	lw	a5,80(s2)
    800042f0:	faf71ce3          	bne	a4,a5,800042a8 <_Z28kmem_cache_alloc_constructorP12kmem_cache_s+0x68>
            if(target==cachep->usedSlabsHead){
    800042f4:	00893783          	ld	a5,8(s2)
    800042f8:	04978063          	beq	a5,s1,80004338 <_Z28kmem_cache_alloc_constructorP12kmem_cache_s+0xf8>
                while (prev->nextSlab!=target) prev=prev->nextSlab;
    800042fc:	00078713          	mv	a4,a5
    80004300:	0207b783          	ld	a5,32(a5)
    80004304:	fe979ce3          	bne	a5,s1,800042fc <_Z28kmem_cache_alloc_constructorP12kmem_cache_s+0xbc>
                prev->nextSlab=target->nextSlab;
    80004308:	0204b783          	ld	a5,32(s1)
    8000430c:	02f73023          	sd	a5,32(a4)
            target->nextSlab=cachep->fullSlabsHead;
    80004310:	01093783          	ld	a5,16(s2)
    80004314:	02f4b023          	sd	a5,32(s1)
            cachep->fullSlabsHead=target;
    80004318:	00993823          	sd	s1,16(s2)
        return result;
    8000431c:	f8dff06f          	j	800042a8 <_Z28kmem_cache_alloc_constructorP12kmem_cache_s+0x68>
            kmem_slab_construct_objects(target,cachep);
    80004320:	00090593          	mv	a1,s2
    80004324:	00098513          	mv	a0,s3
    80004328:	00000097          	auipc	ra,0x0
    8000432c:	ba4080e7          	jalr	-1116(ra) # 80003ecc <_Z27kmem_slab_construct_objectsP11kmem_slab_sP12kmem_cache_s>
            target=cachep->usedSlabsHead;
    80004330:	00098493          	mv	s1,s3
    80004334:	fa5ff06f          	j	800042d8 <_Z28kmem_cache_alloc_constructorP12kmem_cache_s+0x98>
                cachep->usedSlabsHead=target->nextSlab;
    80004338:	0204b783          	ld	a5,32(s1)
    8000433c:	00f93423          	sd	a5,8(s2)
    80004340:	fd1ff06f          	j	80004310 <_Z28kmem_cache_alloc_constructorP12kmem_cache_s+0xd0>

0000000080004344 <_Z16kmem_cache_allocP12kmem_cache_s>:

void *kmem_cache_alloc(kmem_cache_t* cachep){
    80004344:	ff010113          	addi	sp,sp,-16
    80004348:	00113423          	sd	ra,8(sp)
    8000434c:	00813023          	sd	s0,0(sp)
    80004350:	01010413          	addi	s0,sp,16
    if(cachep->ctor!=0) return kmem_cache_alloc_constructor(cachep);
    80004354:	02853783          	ld	a5,40(a0)
    80004358:	00078e63          	beqz	a5,80004374 <_Z16kmem_cache_allocP12kmem_cache_s+0x30>
    8000435c:	00000097          	auipc	ra,0x0
    80004360:	ee4080e7          	jalr	-284(ra) # 80004240 <_Z28kmem_cache_alloc_constructorP12kmem_cache_s>
    else return kmem_cache_alloc_no_constructor(cachep);
}
    80004364:	00813083          	ld	ra,8(sp)
    80004368:	00013403          	ld	s0,0(sp)
    8000436c:	01010113          	addi	sp,sp,16
    80004370:	00008067          	ret
    else return kmem_cache_alloc_no_constructor(cachep);
    80004374:	00000097          	auipc	ra,0x0
    80004378:	e2c080e7          	jalr	-468(ra) # 800041a0 <_Z31kmem_cache_alloc_no_constructorP12kmem_cache_s>
    8000437c:	fe9ff06f          	j	80004364 <_Z16kmem_cache_allocP12kmem_cache_s+0x20>

0000000080004380 <_Z15kmem_cache_freeP12kmem_cache_sPv>:

// Deallocate one object from cache
void kmem_cache_free(kmem_cache_t *cachep, void *objp)
{
    80004380:	ff010113          	addi	sp,sp,-16
    80004384:	00813423          	sd	s0,8(sp)
    80004388:	01010413          	addi	s0,sp,16
    //look for the object amongst nonfull slabs
    kmem_slab_t* curr = cachep->usedSlabsHead;
    8000438c:	00853783          	ld	a5,8(a0)
    kmem_slab_t* prev = 0;
    80004390:	00000613          	li	a2,0
    80004394:	0180006f          	j	800043ac <_Z15kmem_cache_freeP12kmem_cache_sPv+0x2c>
            int positionInSlab = ((char*)objp - (char*)curr->memory)/cachep->slotSize;
            setBitmapValue(curr->freeSlotsBitmap,positionInSlab,SLOT_FREE);
            curr->usedSlotsCount--;
            if(curr->usedSlotsCount==0){
                if(prev==0){
                    cachep->usedSlabsHead=curr->nextSlab;
    80004398:	0207b703          	ld	a4,32(a5)
    8000439c:	00e53423          	sd	a4,8(a0)
    800043a0:	0840006f          	j	80004424 <_Z15kmem_cache_freeP12kmem_cache_sPv+0xa4>
                curr->nextSlab=cachep->emptySlabsHead;
                cachep->emptySlabsHead=curr;
            }
            return;
        }
        prev=curr;
    800043a4:	00078613          	mv	a2,a5
        curr=curr->nextSlab;
    800043a8:	0207b783          	ld	a5,32(a5)
    while(curr!=0){
    800043ac:	08078463          	beqz	a5,80004434 <_Z15kmem_cache_freeP12kmem_cache_sPv+0xb4>
        if(objp>curr->memory && objp<((char*)(curr->memory)+cachep->memorySize)){
    800043b0:	0087b703          	ld	a4,8(a5)
    800043b4:	feb778e3          	bgeu	a4,a1,800043a4 <_Z15kmem_cache_freeP12kmem_cache_sPv+0x24>
    800043b8:	04852683          	lw	a3,72(a0)
    800043bc:	00d706b3          	add	a3,a4,a3
    800043c0:	fed5f2e3          	bgeu	a1,a3,800043a4 <_Z15kmem_cache_freeP12kmem_cache_sPv+0x24>
            int positionInSlab = ((char*)objp - (char*)curr->memory)/cachep->slotSize;
    800043c4:	40e58733          	sub	a4,a1,a4
    800043c8:	02053583          	ld	a1,32(a0)
    800043cc:	02b75733          	divu	a4,a4,a1
            setBitmapValue(curr->freeSlotsBitmap,positionInSlab,SLOT_FREE);
    800043d0:	0187b683          	ld	a3,24(a5)
    int wordPosition = position/8;
    800043d4:	41f7559b          	sraiw	a1,a4,0x1f
    800043d8:	01d5d59b          	srliw	a1,a1,0x1d
    800043dc:	00e5873b          	addw	a4,a1,a4
    800043e0:	4037581b          	sraiw	a6,a4,0x3
    int bitPosition = position%8;
    800043e4:	00777713          	andi	a4,a4,7
    800043e8:	40b7073b          	subw	a4,a4,a1
        bitmapStart[wordPosition] = bitmapStart[wordPosition] | (1<<bitPosition);
    800043ec:	010686b3          	add	a3,a3,a6
    800043f0:	00068583          	lb	a1,0(a3)
    800043f4:	00100813          	li	a6,1
    800043f8:	00e8173b          	sllw	a4,a6,a4
    800043fc:	00e5e733          	or	a4,a1,a4
    80004400:	00e68023          	sb	a4,0(a3)
            curr->usedSlotsCount--;
    80004404:	0007a703          	lw	a4,0(a5)
    80004408:	fff7071b          	addiw	a4,a4,-1
    8000440c:	0007069b          	sext.w	a3,a4
    80004410:	00e7a023          	sw	a4,0(a5)
            if(curr->usedSlotsCount==0){
    80004414:	0a069c63          	bnez	a3,800044cc <_Z15kmem_cache_freeP12kmem_cache_sPv+0x14c>
                if(prev==0){
    80004418:	f80600e3          	beqz	a2,80004398 <_Z15kmem_cache_freeP12kmem_cache_sPv+0x18>
                    prev->nextSlab=curr->nextSlab;
    8000441c:	0207b703          	ld	a4,32(a5)
    80004420:	02e63023          	sd	a4,32(a2)
                curr->nextSlab=cachep->emptySlabsHead;
    80004424:	00053703          	ld	a4,0(a0)
    80004428:	02e7b023          	sd	a4,32(a5)
                cachep->emptySlabsHead=curr;
    8000442c:	00f53023          	sd	a5,0(a0)
            return;
    80004430:	09c0006f          	j	800044cc <_Z15kmem_cache_freeP12kmem_cache_sPv+0x14c>
    }

    //amongst full slabs
    curr=cachep->fullSlabsHead;
    80004434:	01053703          	ld	a4,16(a0)
    prev=0;
    80004438:	0180006f          	j	80004450 <_Z15kmem_cache_freeP12kmem_cache_sPv+0xd0>
        if(objp>curr->memory && objp<((char*)(curr->memory)+cachep->memorySize)){
            int positionInSlab = ((char*)objp - (char*)curr->memory)/cachep->slotSize;
            setBitmapValue(curr->freeSlotsBitmap,positionInSlab,SLOT_FREE);
            curr->usedSlotsCount--;
            if(prev==0){
                cachep->fullSlabsHead=curr->nextSlab;
    8000443c:	02073783          	ld	a5,32(a4)
    80004440:	00f53823          	sd	a5,16(a0)
    80004444:	07c0006f          	j	800044c0 <_Z15kmem_cache_freeP12kmem_cache_sPv+0x140>
            }
            curr->nextSlab=cachep->usedSlabsHead;
            cachep->usedSlabsHead=curr;
            return;
        }
        prev=curr;
    80004448:	00070793          	mv	a5,a4
        curr=curr->nextSlab;
    8000444c:	02073703          	ld	a4,32(a4)
    while(curr!=0){
    80004450:	06070e63          	beqz	a4,800044cc <_Z15kmem_cache_freeP12kmem_cache_sPv+0x14c>
        if(objp>curr->memory && objp<((char*)(curr->memory)+cachep->memorySize)){
    80004454:	00873683          	ld	a3,8(a4)
    80004458:	feb6f8e3          	bgeu	a3,a1,80004448 <_Z15kmem_cache_freeP12kmem_cache_sPv+0xc8>
    8000445c:	04852603          	lw	a2,72(a0)
    80004460:	00c68633          	add	a2,a3,a2
    80004464:	fec5f2e3          	bgeu	a1,a2,80004448 <_Z15kmem_cache_freeP12kmem_cache_sPv+0xc8>
            int positionInSlab = ((char*)objp - (char*)curr->memory)/cachep->slotSize;
    80004468:	40d586b3          	sub	a3,a1,a3
    8000446c:	02053583          	ld	a1,32(a0)
    80004470:	02b6d6b3          	divu	a3,a3,a1
            setBitmapValue(curr->freeSlotsBitmap,positionInSlab,SLOT_FREE);
    80004474:	01873603          	ld	a2,24(a4)
    int wordPosition = position/8;
    80004478:	41f6d59b          	sraiw	a1,a3,0x1f
    8000447c:	01d5d59b          	srliw	a1,a1,0x1d
    80004480:	00d586bb          	addw	a3,a1,a3
    80004484:	4036d81b          	sraiw	a6,a3,0x3
    int bitPosition = position%8;
    80004488:	0076f693          	andi	a3,a3,7
    8000448c:	40b686bb          	subw	a3,a3,a1
        bitmapStart[wordPosition] = bitmapStart[wordPosition] | (1<<bitPosition);
    80004490:	01060633          	add	a2,a2,a6
    80004494:	00060583          	lb	a1,0(a2)
    80004498:	00100813          	li	a6,1
    8000449c:	00d816bb          	sllw	a3,a6,a3
    800044a0:	00d5e6b3          	or	a3,a1,a3
    800044a4:	00d60023          	sb	a3,0(a2)
            curr->usedSlotsCount--;
    800044a8:	00072683          	lw	a3,0(a4)
    800044ac:	fff6869b          	addiw	a3,a3,-1
    800044b0:	00d72023          	sw	a3,0(a4)
            if(prev==0){
    800044b4:	f80784e3          	beqz	a5,8000443c <_Z15kmem_cache_freeP12kmem_cache_sPv+0xbc>
                prev->nextSlab=curr->nextSlab;
    800044b8:	02073683          	ld	a3,32(a4)
    800044bc:	02d7b023          	sd	a3,32(a5)
            curr->nextSlab=cachep->usedSlabsHead;
    800044c0:	00853783          	ld	a5,8(a0)
    800044c4:	02f73023          	sd	a5,32(a4)
            cachep->usedSlabsHead=curr;
    800044c8:	00e53423          	sd	a4,8(a0)
    }
}
    800044cc:	00813403          	ld	s0,8(sp)
    800044d0:	01010113          	addi	sp,sp,16
    800044d4:	00008067          	ret

00000000800044d8 <_Z7kmallocm>:

// Alloacate one small memory buffer
void *kmalloc(unsigned long size)
{
    800044d8:	ff010113          	addi	sp,sp,-16
    800044dc:	00113423          	sd	ra,8(sp)
    800044e0:	00813023          	sd	s0,0(sp)
    800044e4:	01010413          	addi	s0,sp,16
    return bba_allocate(size);
    800044e8:	ffffd097          	auipc	ra,0xffffd
    800044ec:	58c080e7          	jalr	1420(ra) # 80001a74 <_Z12bba_allocatem>
}
    800044f0:	00813083          	ld	ra,8(sp)
    800044f4:	00013403          	ld	s0,0(sp)
    800044f8:	01010113          	addi	sp,sp,16
    800044fc:	00008067          	ret

0000000080004500 <_Z5kfreePKv>:

// Deallocate one small memory buffer
void kfree(const void *objp)
{
    80004500:	ff010113          	addi	sp,sp,-16
    80004504:	00113423          	sd	ra,8(sp)
    80004508:	00813023          	sd	s0,0(sp)
    8000450c:	01010413          	addi	s0,sp,16
    bba_free_block(objp);
    80004510:	ffffe097          	auipc	ra,0xffffe
    80004514:	82c080e7          	jalr	-2004(ra) # 80001d3c <_Z14bba_free_blockPKv>
}
    80004518:	00813083          	ld	ra,8(sp)
    8000451c:	00013403          	ld	s0,0(sp)
    80004520:	01010113          	addi	sp,sp,16
    80004524:	00008067          	ret

0000000080004528 <_Z17kmem_destroy_listP12kmem_cache_sP11kmem_slab_s>:

void kmem_destroy_list(kmem_cache_t* cachep,kmem_slab_t* head){
    if(head==0) return;
    80004528:	08058e63          	beqz	a1,800045c4 <_Z17kmem_destroy_listP12kmem_cache_sP11kmem_slab_s+0x9c>
void kmem_destroy_list(kmem_cache_t* cachep,kmem_slab_t* head){
    8000452c:	fd010113          	addi	sp,sp,-48
    80004530:	02113423          	sd	ra,40(sp)
    80004534:	02813023          	sd	s0,32(sp)
    80004538:	00913c23          	sd	s1,24(sp)
    8000453c:	01213823          	sd	s2,16(sp)
    80004540:	01313423          	sd	s3,8(sp)
    80004544:	03010413          	addi	s0,sp,48
    80004548:	00050993          	mv	s3,a0
    8000454c:	00058493          	mv	s1,a1
    kmem_slab_t *curr = head->nextSlab;
    80004550:	0205b903          	ld	s2,32(a1)
    kmem_slab_t * prev = head;
    80004554:	0440006f          	j	80004598 <_Z17kmem_destroy_listP12kmem_cache_sP11kmem_slab_s+0x70>
    80004558:	00090793          	mv	a5,s2
    8000455c:	0340006f          	j	80004590 <_Z17kmem_destroy_listP12kmem_cache_sP11kmem_slab_s+0x68>
    while (prev!=0){
        if(cachep->dtor!=0) kmem_slab_destoy_objects(prev,cachep);
    80004560:	00098593          	mv	a1,s3
    80004564:	00048513          	mv	a0,s1
    80004568:	00000097          	auipc	ra,0x0
    8000456c:	828080e7          	jalr	-2008(ra) # 80003d90 <_Z24kmem_slab_destoy_objectsP11kmem_slab_sP12kmem_cache_s>
        bba_free_block(prev->memory);
    80004570:	0084b503          	ld	a0,8(s1)
    80004574:	ffffd097          	auipc	ra,0xffffd
    80004578:	7c8080e7          	jalr	1992(ra) # 80001d3c <_Z14bba_free_blockPKv>
        bba_free_block(prev);
    8000457c:	00048513          	mv	a0,s1
    80004580:	ffffd097          	auipc	ra,0xffffd
    80004584:	7bc080e7          	jalr	1980(ra) # 80001d3c <_Z14bba_free_blockPKv>
        prev=curr;
        if(curr!=0) curr=curr->nextSlab;
    80004588:	fc0908e3          	beqz	s2,80004558 <_Z17kmem_destroy_listP12kmem_cache_sP11kmem_slab_s+0x30>
    8000458c:	02093783          	ld	a5,32(s2)
    80004590:	00090493          	mv	s1,s2
    80004594:	00078913          	mv	s2,a5
    while (prev!=0){
    80004598:	00048863          	beqz	s1,800045a8 <_Z17kmem_destroy_listP12kmem_cache_sP11kmem_slab_s+0x80>
        if(cachep->dtor!=0) kmem_slab_destoy_objects(prev,cachep);
    8000459c:	0309b783          	ld	a5,48(s3)
    800045a0:	fc0790e3          	bnez	a5,80004560 <_Z17kmem_destroy_listP12kmem_cache_sP11kmem_slab_s+0x38>
    800045a4:	fcdff06f          	j	80004570 <_Z17kmem_destroy_listP12kmem_cache_sP11kmem_slab_s+0x48>
    }
}
    800045a8:	02813083          	ld	ra,40(sp)
    800045ac:	02013403          	ld	s0,32(sp)
    800045b0:	01813483          	ld	s1,24(sp)
    800045b4:	01013903          	ld	s2,16(sp)
    800045b8:	00813983          	ld	s3,8(sp)
    800045bc:	03010113          	addi	sp,sp,48
    800045c0:	00008067          	ret
    800045c4:	00008067          	ret

00000000800045c8 <_Z18kmem_cache_destroyP12kmem_cache_s>:

// Deallocate cache
void kmem_cache_destroy(kmem_cache_t *cachep)
{
    800045c8:	fe010113          	addi	sp,sp,-32
    800045cc:	00113c23          	sd	ra,24(sp)
    800045d0:	00813823          	sd	s0,16(sp)
    800045d4:	00913423          	sd	s1,8(sp)
    800045d8:	02010413          	addi	s0,sp,32
    800045dc:	00050493          	mv	s1,a0
    kmem_destroy_list(cachep,cachep->usedSlabsHead);
    800045e0:	00853583          	ld	a1,8(a0)
    800045e4:	00000097          	auipc	ra,0x0
    800045e8:	f44080e7          	jalr	-188(ra) # 80004528 <_Z17kmem_destroy_listP12kmem_cache_sP11kmem_slab_s>
    kmem_destroy_list(cachep,cachep->emptySlabsHead);
    800045ec:	0004b583          	ld	a1,0(s1)
    800045f0:	00048513          	mv	a0,s1
    800045f4:	00000097          	auipc	ra,0x0
    800045f8:	f34080e7          	jalr	-204(ra) # 80004528 <_Z17kmem_destroy_listP12kmem_cache_sP11kmem_slab_s>
    kmem_destroy_list(cachep,cachep->fullSlabsHead);
    800045fc:	0104b583          	ld	a1,16(s1)
    80004600:	00048513          	mv	a0,s1
    80004604:	00000097          	auipc	ra,0x0
    80004608:	f24080e7          	jalr	-220(ra) # 80004528 <_Z17kmem_destroy_listP12kmem_cache_sP11kmem_slab_s>
    bba_free_block(cachep);
    8000460c:	00048513          	mv	a0,s1
    80004610:	ffffd097          	auipc	ra,0xffffd
    80004614:	72c080e7          	jalr	1836(ra) # 80001d3c <_Z14bba_free_blockPKv>
}
    80004618:	01813083          	ld	ra,24(sp)
    8000461c:	01013403          	ld	s0,16(sp)
    80004620:	00813483          	ld	s1,8(sp)
    80004624:	02010113          	addi	sp,sp,32
    80004628:	00008067          	ret

000000008000462c <_Z15kmem_cache_infoP12kmem_cache_s>:
{
    printf("\n Slab at addr %lx, %d used slots, %d initialized slots",  slab->memory, slab->usedSlotsCount, slab->initializedSlotsCount);
}
// Print cache info
void kmem_cache_info(kmem_cache_t *cachep)
{
    8000462c:	fc010113          	addi	sp,sp,-64
    80004630:	02113c23          	sd	ra,56(sp)
    80004634:	02813823          	sd	s0,48(sp)
    80004638:	02913423          	sd	s1,40(sp)
    8000463c:	03213023          	sd	s2,32(sp)
    80004640:	01313c23          	sd	s3,24(sp)
    80004644:	01413823          	sd	s4,16(sp)
    80004648:	01513423          	sd	s5,8(sp)
    8000464c:	04010413          	addi	s0,sp,64
    80004650:	00050a93          	mv	s5,a0
    int initObjCount=0, usedObjCount=0, slabsCount=0;
    printf("\n Cache '%s' has %d slots of size %d in each slab",cachep->name, cachep->slotsInSlab, cachep->slotSize);
    80004654:	02053683          	ld	a3,32(a0)
    80004658:	05052603          	lw	a2,80(a0)
    8000465c:	03850593          	addi	a1,a0,56
    80004660:	00006517          	auipc	a0,0x6
    80004664:	c8850513          	addi	a0,a0,-888 # 8000a2e8 <CONSOLE_STATUS+0x2d8>
    80004668:	ffffe097          	auipc	ra,0xffffe
    8000466c:	c2c080e7          	jalr	-980(ra) # 80002294 <_Z6printfPKcz>
    printf("\n Empty slabs:");
    80004670:	00006517          	auipc	a0,0x6
    80004674:	cb050513          	addi	a0,a0,-848 # 8000a320 <CONSOLE_STATUS+0x310>
    80004678:	ffffe097          	auipc	ra,0xffffe
    8000467c:	c1c080e7          	jalr	-996(ra) # 80002294 <_Z6printfPKcz>
    kmem_slab_t * curr = cachep->emptySlabsHead;
    80004680:	000ab483          	ld	s1,0(s5)
    int initObjCount=0, usedObjCount=0, slabsCount=0;
    80004684:	00000a13          	li	s4,0
    80004688:	00000913          	li	s2,0
    8000468c:	00000993          	li	s3,0
    while (curr!=0){
    80004690:	02048e63          	beqz	s1,800046cc <_Z15kmem_cache_infoP12kmem_cache_s+0xa0>
    printf("\n Slab at addr %lx, %d used slots, %d initialized slots",  slab->memory, slab->usedSlotsCount, slab->initializedSlotsCount);
    80004694:	0044a683          	lw	a3,4(s1)
    80004698:	0004a603          	lw	a2,0(s1)
    8000469c:	0084b583          	ld	a1,8(s1)
    800046a0:	00006517          	auipc	a0,0x6
    800046a4:	c9050513          	addi	a0,a0,-880 # 8000a330 <CONSOLE_STATUS+0x320>
    800046a8:	ffffe097          	auipc	ra,0xffffe
    800046ac:	bec080e7          	jalr	-1044(ra) # 80002294 <_Z6printfPKcz>
        kmem_slab_info(curr);
        slabsCount++;
    800046b0:	001a0a1b          	addiw	s4,s4,1
        initObjCount+=curr->initializedSlotsCount;
    800046b4:	0044a783          	lw	a5,4(s1)
    800046b8:	013789bb          	addw	s3,a5,s3
        usedObjCount+=curr->usedSlotsCount;
    800046bc:	0004a783          	lw	a5,0(s1)
    800046c0:	0127893b          	addw	s2,a5,s2
        curr=curr->nextSlab;
    800046c4:	0204b483          	ld	s1,32(s1)
    while (curr!=0){
    800046c8:	fc9ff06f          	j	80004690 <_Z15kmem_cache_infoP12kmem_cache_s+0x64>
    }
    printf("\n Full slabs:");
    800046cc:	00006517          	auipc	a0,0x6
    800046d0:	c9c50513          	addi	a0,a0,-868 # 8000a368 <CONSOLE_STATUS+0x358>
    800046d4:	ffffe097          	auipc	ra,0xffffe
    800046d8:	bc0080e7          	jalr	-1088(ra) # 80002294 <_Z6printfPKcz>
    curr = cachep->fullSlabsHead;
    800046dc:	010ab483          	ld	s1,16(s5)
    while (curr!=0){
    800046e0:	02048e63          	beqz	s1,8000471c <_Z15kmem_cache_infoP12kmem_cache_s+0xf0>
    printf("\n Slab at addr %lx, %d used slots, %d initialized slots",  slab->memory, slab->usedSlotsCount, slab->initializedSlotsCount);
    800046e4:	0044a683          	lw	a3,4(s1)
    800046e8:	0004a603          	lw	a2,0(s1)
    800046ec:	0084b583          	ld	a1,8(s1)
    800046f0:	00006517          	auipc	a0,0x6
    800046f4:	c4050513          	addi	a0,a0,-960 # 8000a330 <CONSOLE_STATUS+0x320>
    800046f8:	ffffe097          	auipc	ra,0xffffe
    800046fc:	b9c080e7          	jalr	-1124(ra) # 80002294 <_Z6printfPKcz>
        kmem_slab_info(curr);
        slabsCount++;
    80004700:	001a0a1b          	addiw	s4,s4,1
        initObjCount+=curr->initializedSlotsCount;
    80004704:	0044a783          	lw	a5,4(s1)
    80004708:	013789bb          	addw	s3,a5,s3
        usedObjCount+=curr->usedSlotsCount;
    8000470c:	0004a783          	lw	a5,0(s1)
    80004710:	0127893b          	addw	s2,a5,s2
        curr=curr->nextSlab;
    80004714:	0204b483          	ld	s1,32(s1)
    while (curr!=0){
    80004718:	fc9ff06f          	j	800046e0 <_Z15kmem_cache_infoP12kmem_cache_s+0xb4>
    }
    printf("\n Partially full slabs:");
    8000471c:	00006517          	auipc	a0,0x6
    80004720:	c5c50513          	addi	a0,a0,-932 # 8000a378 <CONSOLE_STATUS+0x368>
    80004724:	ffffe097          	auipc	ra,0xffffe
    80004728:	b70080e7          	jalr	-1168(ra) # 80002294 <_Z6printfPKcz>
    curr = cachep->usedSlabsHead;
    8000472c:	008ab483          	ld	s1,8(s5)
    while (curr!=0){
    80004730:	02048e63          	beqz	s1,8000476c <_Z15kmem_cache_infoP12kmem_cache_s+0x140>
    printf("\n Slab at addr %lx, %d used slots, %d initialized slots",  slab->memory, slab->usedSlotsCount, slab->initializedSlotsCount);
    80004734:	0044a683          	lw	a3,4(s1)
    80004738:	0004a603          	lw	a2,0(s1)
    8000473c:	0084b583          	ld	a1,8(s1)
    80004740:	00006517          	auipc	a0,0x6
    80004744:	bf050513          	addi	a0,a0,-1040 # 8000a330 <CONSOLE_STATUS+0x320>
    80004748:	ffffe097          	auipc	ra,0xffffe
    8000474c:	b4c080e7          	jalr	-1204(ra) # 80002294 <_Z6printfPKcz>
        kmem_slab_info(curr);
        slabsCount++;
    80004750:	001a0a1b          	addiw	s4,s4,1
        initObjCount+=curr->initializedSlotsCount;
    80004754:	0044a783          	lw	a5,4(s1)
    80004758:	013789bb          	addw	s3,a5,s3
        usedObjCount+=curr->usedSlotsCount;
    8000475c:	0004a783          	lw	a5,0(s1)
    80004760:	0127893b          	addw	s2,a5,s2
        curr=curr->nextSlab;
    80004764:	0204b483          	ld	s1,32(s1)
    while (curr!=0){
    80004768:	fc9ff06f          	j	80004730 <_Z15kmem_cache_infoP12kmem_cache_s+0x104>
    }
    printf("\n Total slabs: %d, total used slots: %d, total initialized slots: %d", slabsCount, usedObjCount,initObjCount);
    8000476c:	00098693          	mv	a3,s3
    80004770:	00090613          	mv	a2,s2
    80004774:	000a0593          	mv	a1,s4
    80004778:	00006517          	auipc	a0,0x6
    8000477c:	c1850513          	addi	a0,a0,-1000 # 8000a390 <CONSOLE_STATUS+0x380>
    80004780:	ffffe097          	auipc	ra,0xffffe
    80004784:	b14080e7          	jalr	-1260(ra) # 80002294 <_Z6printfPKcz>
    printf("\n-------------------------", usedObjCount,initObjCount);
    80004788:	00098613          	mv	a2,s3
    8000478c:	00090593          	mv	a1,s2
    80004790:	00006517          	auipc	a0,0x6
    80004794:	c4850513          	addi	a0,a0,-952 # 8000a3d8 <CONSOLE_STATUS+0x3c8>
    80004798:	ffffe097          	auipc	ra,0xffffe
    8000479c:	afc080e7          	jalr	-1284(ra) # 80002294 <_Z6printfPKcz>
}
    800047a0:	03813083          	ld	ra,56(sp)
    800047a4:	03013403          	ld	s0,48(sp)
    800047a8:	02813483          	ld	s1,40(sp)
    800047ac:	02013903          	ld	s2,32(sp)
    800047b0:	01813983          	ld	s3,24(sp)
    800047b4:	01013a03          	ld	s4,16(sp)
    800047b8:	00813a83          	ld	s5,8(sp)
    800047bc:	04010113          	addi	sp,sp,64
    800047c0:	00008067          	ret

00000000800047c4 <_ZL16producerKeyboardPv>:
    sem_t wait;
};

static volatile int threadEnd = 0;

static void producerKeyboard(void *arg) {
    800047c4:	fe010113          	addi	sp,sp,-32
    800047c8:	00113c23          	sd	ra,24(sp)
    800047cc:	00813823          	sd	s0,16(sp)
    800047d0:	00913423          	sd	s1,8(sp)
    800047d4:	01213023          	sd	s2,0(sp)
    800047d8:	02010413          	addi	s0,sp,32
    800047dc:	00050493          	mv	s1,a0
    struct thread_data *data = (struct thread_data *) arg;

    int key;
    int i = 0;
    800047e0:	00000913          	li	s2,0
    800047e4:	00c0006f          	j	800047f0 <_ZL16producerKeyboardPv+0x2c>
    while ((key = getc()) != 13) {
        data->buffer->put(key);
        i++;

        if (i % (10 * data->id) == 0) {
            thread_dispatch();
    800047e8:	ffffd097          	auipc	ra,0xffffd
    800047ec:	ba0080e7          	jalr	-1120(ra) # 80001388 <_Z15thread_dispatchv>
    while ((key = getc()) != 13) {
    800047f0:	ffffd097          	auipc	ra,0xffffd
    800047f4:	d84080e7          	jalr	-636(ra) # 80001574 <_Z4getcv>
    800047f8:	0005059b          	sext.w	a1,a0
    800047fc:	00d00793          	li	a5,13
    80004800:	02f58a63          	beq	a1,a5,80004834 <_ZL16producerKeyboardPv+0x70>
        data->buffer->put(key);
    80004804:	0084b503          	ld	a0,8(s1)
    80004808:	00003097          	auipc	ra,0x3
    8000480c:	f50080e7          	jalr	-176(ra) # 80007758 <_ZN6Buffer3putEi>
        i++;
    80004810:	0019071b          	addiw	a4,s2,1
    80004814:	0007091b          	sext.w	s2,a4
        if (i % (10 * data->id) == 0) {
    80004818:	0004a683          	lw	a3,0(s1)
    8000481c:	0026979b          	slliw	a5,a3,0x2
    80004820:	00d787bb          	addw	a5,a5,a3
    80004824:	0017979b          	slliw	a5,a5,0x1
    80004828:	02f767bb          	remw	a5,a4,a5
    8000482c:	fc0792e3          	bnez	a5,800047f0 <_ZL16producerKeyboardPv+0x2c>
    80004830:	fb9ff06f          	j	800047e8 <_ZL16producerKeyboardPv+0x24>
        }
    }

    threadEnd = 1;
    80004834:	00100793          	li	a5,1
    80004838:	0000c717          	auipc	a4,0xc
    8000483c:	94f72023          	sw	a5,-1728(a4) # 80010178 <_ZL9threadEnd>
    data->buffer->put('!');
    80004840:	02100593          	li	a1,33
    80004844:	0084b503          	ld	a0,8(s1)
    80004848:	00003097          	auipc	ra,0x3
    8000484c:	f10080e7          	jalr	-240(ra) # 80007758 <_ZN6Buffer3putEi>

    sem_signal(data->wait);
    80004850:	0104b503          	ld	a0,16(s1)
    80004854:	ffffd097          	auipc	ra,0xffffd
    80004858:	cac080e7          	jalr	-852(ra) # 80001500 <_Z10sem_signalP5sem_s>
}
    8000485c:	01813083          	ld	ra,24(sp)
    80004860:	01013403          	ld	s0,16(sp)
    80004864:	00813483          	ld	s1,8(sp)
    80004868:	00013903          	ld	s2,0(sp)
    8000486c:	02010113          	addi	sp,sp,32
    80004870:	00008067          	ret

0000000080004874 <_ZL8producerPv>:

static void producer(void *arg) {
    80004874:	fe010113          	addi	sp,sp,-32
    80004878:	00113c23          	sd	ra,24(sp)
    8000487c:	00813823          	sd	s0,16(sp)
    80004880:	00913423          	sd	s1,8(sp)
    80004884:	01213023          	sd	s2,0(sp)
    80004888:	02010413          	addi	s0,sp,32
    8000488c:	00050493          	mv	s1,a0
    struct thread_data *data = (struct thread_data *) arg;

    int i = 0;
    80004890:	00000913          	li	s2,0
    80004894:	00c0006f          	j	800048a0 <_ZL8producerPv+0x2c>
    while (!threadEnd) {
        data->buffer->put(data->id + '0');
        i++;

        if (i % (10 * data->id) == 0) {
            thread_dispatch();
    80004898:	ffffd097          	auipc	ra,0xffffd
    8000489c:	af0080e7          	jalr	-1296(ra) # 80001388 <_Z15thread_dispatchv>
    while (!threadEnd) {
    800048a0:	0000c797          	auipc	a5,0xc
    800048a4:	8d87a783          	lw	a5,-1832(a5) # 80010178 <_ZL9threadEnd>
    800048a8:	02079e63          	bnez	a5,800048e4 <_ZL8producerPv+0x70>
        data->buffer->put(data->id + '0');
    800048ac:	0004a583          	lw	a1,0(s1)
    800048b0:	0305859b          	addiw	a1,a1,48
    800048b4:	0084b503          	ld	a0,8(s1)
    800048b8:	00003097          	auipc	ra,0x3
    800048bc:	ea0080e7          	jalr	-352(ra) # 80007758 <_ZN6Buffer3putEi>
        i++;
    800048c0:	0019071b          	addiw	a4,s2,1
    800048c4:	0007091b          	sext.w	s2,a4
        if (i % (10 * data->id) == 0) {
    800048c8:	0004a683          	lw	a3,0(s1)
    800048cc:	0026979b          	slliw	a5,a3,0x2
    800048d0:	00d787bb          	addw	a5,a5,a3
    800048d4:	0017979b          	slliw	a5,a5,0x1
    800048d8:	02f767bb          	remw	a5,a4,a5
    800048dc:	fc0792e3          	bnez	a5,800048a0 <_ZL8producerPv+0x2c>
    800048e0:	fb9ff06f          	j	80004898 <_ZL8producerPv+0x24>
        }
    }

    sem_signal(data->wait);
    800048e4:	0104b503          	ld	a0,16(s1)
    800048e8:	ffffd097          	auipc	ra,0xffffd
    800048ec:	c18080e7          	jalr	-1000(ra) # 80001500 <_Z10sem_signalP5sem_s>
}
    800048f0:	01813083          	ld	ra,24(sp)
    800048f4:	01013403          	ld	s0,16(sp)
    800048f8:	00813483          	ld	s1,8(sp)
    800048fc:	00013903          	ld	s2,0(sp)
    80004900:	02010113          	addi	sp,sp,32
    80004904:	00008067          	ret

0000000080004908 <_ZL8consumerPv>:

static void consumer(void *arg) {
    80004908:	fd010113          	addi	sp,sp,-48
    8000490c:	02113423          	sd	ra,40(sp)
    80004910:	02813023          	sd	s0,32(sp)
    80004914:	00913c23          	sd	s1,24(sp)
    80004918:	01213823          	sd	s2,16(sp)
    8000491c:	01313423          	sd	s3,8(sp)
    80004920:	03010413          	addi	s0,sp,48
    80004924:	00050913          	mv	s2,a0
    struct thread_data *data = (struct thread_data *) arg;

    int i = 0;
    80004928:	00000993          	li	s3,0
    8000492c:	01c0006f          	j	80004948 <_ZL8consumerPv+0x40>
        i++;

        putc(key);

        if (i % (5 * data->id) == 0) {
            thread_dispatch();
    80004930:	ffffd097          	auipc	ra,0xffffd
    80004934:	a58080e7          	jalr	-1448(ra) # 80001388 <_Z15thread_dispatchv>
    80004938:	0500006f          	j	80004988 <_ZL8consumerPv+0x80>
        }

        if (i % 80 == 0) {
            putc('\n');
    8000493c:	00a00513          	li	a0,10
    80004940:	ffffd097          	auipc	ra,0xffffd
    80004944:	c70080e7          	jalr	-912(ra) # 800015b0 <_Z4putcc>
    while (!threadEnd) {
    80004948:	0000c797          	auipc	a5,0xc
    8000494c:	8307a783          	lw	a5,-2000(a5) # 80010178 <_ZL9threadEnd>
    80004950:	06079063          	bnez	a5,800049b0 <_ZL8consumerPv+0xa8>
        int key = data->buffer->get();
    80004954:	00893503          	ld	a0,8(s2)
    80004958:	00003097          	auipc	ra,0x3
    8000495c:	e90080e7          	jalr	-368(ra) # 800077e8 <_ZN6Buffer3getEv>
        i++;
    80004960:	0019849b          	addiw	s1,s3,1
    80004964:	0004899b          	sext.w	s3,s1
        putc(key);
    80004968:	0ff57513          	andi	a0,a0,255
    8000496c:	ffffd097          	auipc	ra,0xffffd
    80004970:	c44080e7          	jalr	-956(ra) # 800015b0 <_Z4putcc>
        if (i % (5 * data->id) == 0) {
    80004974:	00092703          	lw	a4,0(s2)
    80004978:	0027179b          	slliw	a5,a4,0x2
    8000497c:	00e787bb          	addw	a5,a5,a4
    80004980:	02f4e7bb          	remw	a5,s1,a5
    80004984:	fa0786e3          	beqz	a5,80004930 <_ZL8consumerPv+0x28>
        if (i % 80 == 0) {
    80004988:	05000793          	li	a5,80
    8000498c:	02f4e4bb          	remw	s1,s1,a5
    80004990:	fa049ce3          	bnez	s1,80004948 <_ZL8consumerPv+0x40>
    80004994:	fa9ff06f          	j	8000493c <_ZL8consumerPv+0x34>
        }
    }

    while (data->buffer->getCnt() > 0) {
        int key = data->buffer->get();
    80004998:	00893503          	ld	a0,8(s2)
    8000499c:	00003097          	auipc	ra,0x3
    800049a0:	e4c080e7          	jalr	-436(ra) # 800077e8 <_ZN6Buffer3getEv>
        putc(key);
    800049a4:	0ff57513          	andi	a0,a0,255
    800049a8:	ffffd097          	auipc	ra,0xffffd
    800049ac:	c08080e7          	jalr	-1016(ra) # 800015b0 <_Z4putcc>
    while (data->buffer->getCnt() > 0) {
    800049b0:	00893503          	ld	a0,8(s2)
    800049b4:	00003097          	auipc	ra,0x3
    800049b8:	ec0080e7          	jalr	-320(ra) # 80007874 <_ZN6Buffer6getCntEv>
    800049bc:	fca04ee3          	bgtz	a0,80004998 <_ZL8consumerPv+0x90>
    }

    sem_signal(data->wait);
    800049c0:	01093503          	ld	a0,16(s2)
    800049c4:	ffffd097          	auipc	ra,0xffffd
    800049c8:	b3c080e7          	jalr	-1220(ra) # 80001500 <_Z10sem_signalP5sem_s>
}
    800049cc:	02813083          	ld	ra,40(sp)
    800049d0:	02013403          	ld	s0,32(sp)
    800049d4:	01813483          	ld	s1,24(sp)
    800049d8:	01013903          	ld	s2,16(sp)
    800049dc:	00813983          	ld	s3,8(sp)
    800049e0:	03010113          	addi	sp,sp,48
    800049e4:	00008067          	ret

00000000800049e8 <_Z22producerConsumer_C_APIv>:

void producerConsumer_C_API() {
    800049e8:	f9010113          	addi	sp,sp,-112
    800049ec:	06113423          	sd	ra,104(sp)
    800049f0:	06813023          	sd	s0,96(sp)
    800049f4:	04913c23          	sd	s1,88(sp)
    800049f8:	05213823          	sd	s2,80(sp)
    800049fc:	05313423          	sd	s3,72(sp)
    80004a00:	05413023          	sd	s4,64(sp)
    80004a04:	03513c23          	sd	s5,56(sp)
    80004a08:	03613823          	sd	s6,48(sp)
    80004a0c:	07010413          	addi	s0,sp,112
        sem_wait(waitForAll);
    }

    sem_close(waitForAll);

    delete buffer;
    80004a10:	00010b13          	mv	s6,sp
    printString("Unesite broj proizvodjaca?\n");
    80004a14:	00006517          	auipc	a0,0x6
    80004a18:	9e450513          	addi	a0,a0,-1564 # 8000a3f8 <CONSOLE_STATUS+0x3e8>
    80004a1c:	ffffd097          	auipc	ra,0xffffd
    80004a20:	4e4080e7          	jalr	1252(ra) # 80001f00 <_Z11printStringPKc>
    getString(input, 30);
    80004a24:	01e00593          	li	a1,30
    80004a28:	fa040493          	addi	s1,s0,-96
    80004a2c:	00048513          	mv	a0,s1
    80004a30:	ffffd097          	auipc	ra,0xffffd
    80004a34:	558080e7          	jalr	1368(ra) # 80001f88 <_Z9getStringPci>
    threadNum = stringToInt(input);
    80004a38:	00048513          	mv	a0,s1
    80004a3c:	ffffd097          	auipc	ra,0xffffd
    80004a40:	624080e7          	jalr	1572(ra) # 80002060 <_Z11stringToIntPKc>
    80004a44:	00050913          	mv	s2,a0
    printString("Unesite velicinu bafera?\n");
    80004a48:	00006517          	auipc	a0,0x6
    80004a4c:	9d050513          	addi	a0,a0,-1584 # 8000a418 <CONSOLE_STATUS+0x408>
    80004a50:	ffffd097          	auipc	ra,0xffffd
    80004a54:	4b0080e7          	jalr	1200(ra) # 80001f00 <_Z11printStringPKc>
    getString(input, 30);
    80004a58:	01e00593          	li	a1,30
    80004a5c:	00048513          	mv	a0,s1
    80004a60:	ffffd097          	auipc	ra,0xffffd
    80004a64:	528080e7          	jalr	1320(ra) # 80001f88 <_Z9getStringPci>
    n = stringToInt(input);
    80004a68:	00048513          	mv	a0,s1
    80004a6c:	ffffd097          	auipc	ra,0xffffd
    80004a70:	5f4080e7          	jalr	1524(ra) # 80002060 <_Z11stringToIntPKc>
    80004a74:	00050493          	mv	s1,a0
    printString("Broj proizvodjaca "); printInt(threadNum);
    80004a78:	00006517          	auipc	a0,0x6
    80004a7c:	9c050513          	addi	a0,a0,-1600 # 8000a438 <CONSOLE_STATUS+0x428>
    80004a80:	ffffd097          	auipc	ra,0xffffd
    80004a84:	480080e7          	jalr	1152(ra) # 80001f00 <_Z11printStringPKc>
    80004a88:	00000613          	li	a2,0
    80004a8c:	00a00593          	li	a1,10
    80004a90:	00090513          	mv	a0,s2
    80004a94:	ffffd097          	auipc	ra,0xffffd
    80004a98:	61c080e7          	jalr	1564(ra) # 800020b0 <_Z8printIntiii>
    printString(" i velicina bafera "); printInt(n);
    80004a9c:	00006517          	auipc	a0,0x6
    80004aa0:	9b450513          	addi	a0,a0,-1612 # 8000a450 <CONSOLE_STATUS+0x440>
    80004aa4:	ffffd097          	auipc	ra,0xffffd
    80004aa8:	45c080e7          	jalr	1116(ra) # 80001f00 <_Z11printStringPKc>
    80004aac:	00000613          	li	a2,0
    80004ab0:	00a00593          	li	a1,10
    80004ab4:	00048513          	mv	a0,s1
    80004ab8:	ffffd097          	auipc	ra,0xffffd
    80004abc:	5f8080e7          	jalr	1528(ra) # 800020b0 <_Z8printIntiii>
    printString(".\n");
    80004ac0:	00006517          	auipc	a0,0x6
    80004ac4:	9a850513          	addi	a0,a0,-1624 # 8000a468 <CONSOLE_STATUS+0x458>
    80004ac8:	ffffd097          	auipc	ra,0xffffd
    80004acc:	438080e7          	jalr	1080(ra) # 80001f00 <_Z11printStringPKc>
    if(threadNum > n) {
    80004ad0:	0324c463          	blt	s1,s2,80004af8 <_Z22producerConsumer_C_APIv+0x110>
    } else if (threadNum < 1) {
    80004ad4:	03205c63          	blez	s2,80004b0c <_Z22producerConsumer_C_APIv+0x124>
    Buffer *buffer = new Buffer(n);
    80004ad8:	03800513          	li	a0,56
    80004adc:	ffffe097          	auipc	ra,0xffffe
    80004ae0:	2e8080e7          	jalr	744(ra) # 80002dc4 <_Znwm>
    80004ae4:	00050a13          	mv	s4,a0
    80004ae8:	00048593          	mv	a1,s1
    80004aec:	00003097          	auipc	ra,0x3
    80004af0:	bd0080e7          	jalr	-1072(ra) # 800076bc <_ZN6BufferC1Ei>
    80004af4:	0300006f          	j	80004b24 <_Z22producerConsumer_C_APIv+0x13c>
        printString("Broj proizvodjaca ne sme biti manji od velicine bafera!\n");
    80004af8:	00006517          	auipc	a0,0x6
    80004afc:	97850513          	addi	a0,a0,-1672 # 8000a470 <CONSOLE_STATUS+0x460>
    80004b00:	ffffd097          	auipc	ra,0xffffd
    80004b04:	400080e7          	jalr	1024(ra) # 80001f00 <_Z11printStringPKc>
        return;
    80004b08:	0140006f          	j	80004b1c <_Z22producerConsumer_C_APIv+0x134>
        printString("Broj proizvodjaca mora biti veci od nula!\n");
    80004b0c:	00006517          	auipc	a0,0x6
    80004b10:	9a450513          	addi	a0,a0,-1628 # 8000a4b0 <CONSOLE_STATUS+0x4a0>
    80004b14:	ffffd097          	auipc	ra,0xffffd
    80004b18:	3ec080e7          	jalr	1004(ra) # 80001f00 <_Z11printStringPKc>
        return;
    80004b1c:	000b0113          	mv	sp,s6
    80004b20:	1500006f          	j	80004c70 <_Z22producerConsumer_C_APIv+0x288>
    sem_open(&waitForAll, 0);
    80004b24:	00000593          	li	a1,0
    80004b28:	0000b517          	auipc	a0,0xb
    80004b2c:	65850513          	addi	a0,a0,1624 # 80010180 <_ZL10waitForAll>
    80004b30:	ffffd097          	auipc	ra,0xffffd
    80004b34:	90c080e7          	jalr	-1780(ra) # 8000143c <_Z8sem_openPP5sem_sj>
    thread_t threads[threadNum];
    80004b38:	00391793          	slli	a5,s2,0x3
    80004b3c:	00f78793          	addi	a5,a5,15
    80004b40:	ff07f793          	andi	a5,a5,-16
    80004b44:	40f10133          	sub	sp,sp,a5
    80004b48:	00010a93          	mv	s5,sp
    struct thread_data data[threadNum + 1];
    80004b4c:	0019071b          	addiw	a4,s2,1
    80004b50:	00171793          	slli	a5,a4,0x1
    80004b54:	00e787b3          	add	a5,a5,a4
    80004b58:	00379793          	slli	a5,a5,0x3
    80004b5c:	00f78793          	addi	a5,a5,15
    80004b60:	ff07f793          	andi	a5,a5,-16
    80004b64:	40f10133          	sub	sp,sp,a5
    80004b68:	00010993          	mv	s3,sp
    data[threadNum].id = threadNum;
    80004b6c:	00191613          	slli	a2,s2,0x1
    80004b70:	012607b3          	add	a5,a2,s2
    80004b74:	00379793          	slli	a5,a5,0x3
    80004b78:	00f987b3          	add	a5,s3,a5
    80004b7c:	0127a023          	sw	s2,0(a5)
    data[threadNum].buffer = buffer;
    80004b80:	0147b423          	sd	s4,8(a5)
    data[threadNum].wait = waitForAll;
    80004b84:	0000b717          	auipc	a4,0xb
    80004b88:	5fc73703          	ld	a4,1532(a4) # 80010180 <_ZL10waitForAll>
    80004b8c:	00e7b823          	sd	a4,16(a5)
    thread_create(&consumerThread, consumer, data + threadNum);
    80004b90:	00078613          	mv	a2,a5
    80004b94:	00000597          	auipc	a1,0x0
    80004b98:	d7458593          	addi	a1,a1,-652 # 80004908 <_ZL8consumerPv>
    80004b9c:	f9840513          	addi	a0,s0,-104
    80004ba0:	ffffc097          	auipc	ra,0xffffc
    80004ba4:	760080e7          	jalr	1888(ra) # 80001300 <_Z13thread_createPP8thread_sPFvPvES2_>
    for (int i = 0; i < threadNum; i++) {
    80004ba8:	00000493          	li	s1,0
    80004bac:	0280006f          	j	80004bd4 <_Z22producerConsumer_C_APIv+0x1ec>
        thread_create(threads + i,
    80004bb0:	00000597          	auipc	a1,0x0
    80004bb4:	c1458593          	addi	a1,a1,-1004 # 800047c4 <_ZL16producerKeyboardPv>
                      data + i);
    80004bb8:	00179613          	slli	a2,a5,0x1
    80004bbc:	00f60633          	add	a2,a2,a5
    80004bc0:	00361613          	slli	a2,a2,0x3
        thread_create(threads + i,
    80004bc4:	00c98633          	add	a2,s3,a2
    80004bc8:	ffffc097          	auipc	ra,0xffffc
    80004bcc:	738080e7          	jalr	1848(ra) # 80001300 <_Z13thread_createPP8thread_sPFvPvES2_>
    for (int i = 0; i < threadNum; i++) {
    80004bd0:	0014849b          	addiw	s1,s1,1
    80004bd4:	0524d263          	bge	s1,s2,80004c18 <_Z22producerConsumer_C_APIv+0x230>
        data[i].id = i;
    80004bd8:	00149793          	slli	a5,s1,0x1
    80004bdc:	009787b3          	add	a5,a5,s1
    80004be0:	00379793          	slli	a5,a5,0x3
    80004be4:	00f987b3          	add	a5,s3,a5
    80004be8:	0097a023          	sw	s1,0(a5)
        data[i].buffer = buffer;
    80004bec:	0147b423          	sd	s4,8(a5)
        data[i].wait = waitForAll;
    80004bf0:	0000b717          	auipc	a4,0xb
    80004bf4:	59073703          	ld	a4,1424(a4) # 80010180 <_ZL10waitForAll>
    80004bf8:	00e7b823          	sd	a4,16(a5)
        thread_create(threads + i,
    80004bfc:	00048793          	mv	a5,s1
    80004c00:	00349513          	slli	a0,s1,0x3
    80004c04:	00aa8533          	add	a0,s5,a0
    80004c08:	fa9054e3          	blez	s1,80004bb0 <_Z22producerConsumer_C_APIv+0x1c8>
    80004c0c:	00000597          	auipc	a1,0x0
    80004c10:	c6858593          	addi	a1,a1,-920 # 80004874 <_ZL8producerPv>
    80004c14:	fa5ff06f          	j	80004bb8 <_Z22producerConsumer_C_APIv+0x1d0>
    thread_dispatch();
    80004c18:	ffffc097          	auipc	ra,0xffffc
    80004c1c:	770080e7          	jalr	1904(ra) # 80001388 <_Z15thread_dispatchv>
    for (int i = 0; i <= threadNum; i++) {
    80004c20:	00000493          	li	s1,0
    80004c24:	00994e63          	blt	s2,s1,80004c40 <_Z22producerConsumer_C_APIv+0x258>
        sem_wait(waitForAll);
    80004c28:	0000b517          	auipc	a0,0xb
    80004c2c:	55853503          	ld	a0,1368(a0) # 80010180 <_ZL10waitForAll>
    80004c30:	ffffd097          	auipc	ra,0xffffd
    80004c34:	890080e7          	jalr	-1904(ra) # 800014c0 <_Z8sem_waitP5sem_s>
    for (int i = 0; i <= threadNum; i++) {
    80004c38:	0014849b          	addiw	s1,s1,1
    80004c3c:	fe9ff06f          	j	80004c24 <_Z22producerConsumer_C_APIv+0x23c>
    sem_close(waitForAll);
    80004c40:	0000b517          	auipc	a0,0xb
    80004c44:	54053503          	ld	a0,1344(a0) # 80010180 <_ZL10waitForAll>
    80004c48:	ffffd097          	auipc	ra,0xffffd
    80004c4c:	838080e7          	jalr	-1992(ra) # 80001480 <_Z9sem_closeP5sem_s>
    delete buffer;
    80004c50:	000a0e63          	beqz	s4,80004c6c <_Z22producerConsumer_C_APIv+0x284>
    80004c54:	000a0513          	mv	a0,s4
    80004c58:	00003097          	auipc	ra,0x3
    80004c5c:	ca4080e7          	jalr	-860(ra) # 800078fc <_ZN6BufferD1Ev>
    80004c60:	000a0513          	mv	a0,s4
    80004c64:	ffffe097          	auipc	ra,0xffffe
    80004c68:	188080e7          	jalr	392(ra) # 80002dec <_ZdlPv>
    80004c6c:	000b0113          	mv	sp,s6

}
    80004c70:	f9040113          	addi	sp,s0,-112
    80004c74:	06813083          	ld	ra,104(sp)
    80004c78:	06013403          	ld	s0,96(sp)
    80004c7c:	05813483          	ld	s1,88(sp)
    80004c80:	05013903          	ld	s2,80(sp)
    80004c84:	04813983          	ld	s3,72(sp)
    80004c88:	04013a03          	ld	s4,64(sp)
    80004c8c:	03813a83          	ld	s5,56(sp)
    80004c90:	03013b03          	ld	s6,48(sp)
    80004c94:	07010113          	addi	sp,sp,112
    80004c98:	00008067          	ret
    80004c9c:	00050493          	mv	s1,a0
    Buffer *buffer = new Buffer(n);
    80004ca0:	000a0513          	mv	a0,s4
    80004ca4:	ffffe097          	auipc	ra,0xffffe
    80004ca8:	148080e7          	jalr	328(ra) # 80002dec <_ZdlPv>
    80004cac:	00048513          	mv	a0,s1
    80004cb0:	0000c097          	auipc	ra,0xc
    80004cb4:	5d8080e7          	jalr	1496(ra) # 80011288 <_Unwind_Resume>

0000000080004cb8 <_ZL9fibonaccim>:
static volatile bool finishedA = false;
static volatile bool finishedB = false;
static volatile bool finishedC = false;
static volatile bool finishedD = false;

static uint64 fibonacci(uint64 n) {
    80004cb8:	fe010113          	addi	sp,sp,-32
    80004cbc:	00113c23          	sd	ra,24(sp)
    80004cc0:	00813823          	sd	s0,16(sp)
    80004cc4:	00913423          	sd	s1,8(sp)
    80004cc8:	01213023          	sd	s2,0(sp)
    80004ccc:	02010413          	addi	s0,sp,32
    80004cd0:	00050493          	mv	s1,a0
    if (n == 0 || n == 1) { return n; }
    80004cd4:	00100793          	li	a5,1
    80004cd8:	02a7f863          	bgeu	a5,a0,80004d08 <_ZL9fibonaccim+0x50>
    if (n % 10 == 0) { thread_dispatch(); }
    80004cdc:	00a00793          	li	a5,10
    80004ce0:	02f577b3          	remu	a5,a0,a5
    80004ce4:	02078e63          	beqz	a5,80004d20 <_ZL9fibonaccim+0x68>
    return fibonacci(n - 1) + fibonacci(n - 2);
    80004ce8:	fff48513          	addi	a0,s1,-1
    80004cec:	00000097          	auipc	ra,0x0
    80004cf0:	fcc080e7          	jalr	-52(ra) # 80004cb8 <_ZL9fibonaccim>
    80004cf4:	00050913          	mv	s2,a0
    80004cf8:	ffe48513          	addi	a0,s1,-2
    80004cfc:	00000097          	auipc	ra,0x0
    80004d00:	fbc080e7          	jalr	-68(ra) # 80004cb8 <_ZL9fibonaccim>
    80004d04:	00a90533          	add	a0,s2,a0
}
    80004d08:	01813083          	ld	ra,24(sp)
    80004d0c:	01013403          	ld	s0,16(sp)
    80004d10:	00813483          	ld	s1,8(sp)
    80004d14:	00013903          	ld	s2,0(sp)
    80004d18:	02010113          	addi	sp,sp,32
    80004d1c:	00008067          	ret
    if (n % 10 == 0) { thread_dispatch(); }
    80004d20:	ffffc097          	auipc	ra,0xffffc
    80004d24:	668080e7          	jalr	1640(ra) # 80001388 <_Z15thread_dispatchv>
    80004d28:	fc1ff06f          	j	80004ce8 <_ZL9fibonaccim+0x30>

0000000080004d2c <_ZN7WorkerA11workerBodyAEPv>:
    void run() override {
        workerBodyD(nullptr);
    }
};

void WorkerA::workerBodyA(void *arg) {
    80004d2c:	fe010113          	addi	sp,sp,-32
    80004d30:	00113c23          	sd	ra,24(sp)
    80004d34:	00813823          	sd	s0,16(sp)
    80004d38:	00913423          	sd	s1,8(sp)
    80004d3c:	01213023          	sd	s2,0(sp)
    80004d40:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 10; i++) {
    80004d44:	00000913          	li	s2,0
    80004d48:	0380006f          	j	80004d80 <_ZN7WorkerA11workerBodyAEPv+0x54>
        printString("A: i="); printInt(i); printString("\n");
        for (uint64 j = 0; j < 10000; j++) {
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
            thread_dispatch();
    80004d4c:	ffffc097          	auipc	ra,0xffffc
    80004d50:	63c080e7          	jalr	1596(ra) # 80001388 <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++) {
    80004d54:	00148493          	addi	s1,s1,1
    80004d58:	000027b7          	lui	a5,0x2
    80004d5c:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    80004d60:	0097ee63          	bltu	a5,s1,80004d7c <_ZN7WorkerA11workerBodyAEPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    80004d64:	00000713          	li	a4,0
    80004d68:	000077b7          	lui	a5,0x7
    80004d6c:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    80004d70:	fce7eee3          	bltu	a5,a4,80004d4c <_ZN7WorkerA11workerBodyAEPv+0x20>
    80004d74:	00170713          	addi	a4,a4,1
    80004d78:	ff1ff06f          	j	80004d68 <_ZN7WorkerA11workerBodyAEPv+0x3c>
    for (uint64 i = 0; i < 10; i++) {
    80004d7c:	00190913          	addi	s2,s2,1
    80004d80:	00900793          	li	a5,9
    80004d84:	0527e063          	bltu	a5,s2,80004dc4 <_ZN7WorkerA11workerBodyAEPv+0x98>
        printString("A: i="); printInt(i); printString("\n");
    80004d88:	00005517          	auipc	a0,0x5
    80004d8c:	75850513          	addi	a0,a0,1880 # 8000a4e0 <CONSOLE_STATUS+0x4d0>
    80004d90:	ffffd097          	auipc	ra,0xffffd
    80004d94:	170080e7          	jalr	368(ra) # 80001f00 <_Z11printStringPKc>
    80004d98:	00000613          	li	a2,0
    80004d9c:	00a00593          	li	a1,10
    80004da0:	0009051b          	sext.w	a0,s2
    80004da4:	ffffd097          	auipc	ra,0xffffd
    80004da8:	30c080e7          	jalr	780(ra) # 800020b0 <_Z8printIntiii>
    80004dac:	00006517          	auipc	a0,0x6
    80004db0:	98450513          	addi	a0,a0,-1660 # 8000a730 <CONSOLE_STATUS+0x720>
    80004db4:	ffffd097          	auipc	ra,0xffffd
    80004db8:	14c080e7          	jalr	332(ra) # 80001f00 <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    80004dbc:	00000493          	li	s1,0
    80004dc0:	f99ff06f          	j	80004d58 <_ZN7WorkerA11workerBodyAEPv+0x2c>
        }
    }
    printString("A finished!\n");
    80004dc4:	00005517          	auipc	a0,0x5
    80004dc8:	72450513          	addi	a0,a0,1828 # 8000a4e8 <CONSOLE_STATUS+0x4d8>
    80004dcc:	ffffd097          	auipc	ra,0xffffd
    80004dd0:	134080e7          	jalr	308(ra) # 80001f00 <_Z11printStringPKc>
    finishedA = true;
    80004dd4:	00100793          	li	a5,1
    80004dd8:	0000b717          	auipc	a4,0xb
    80004ddc:	3af70823          	sb	a5,944(a4) # 80010188 <_ZL9finishedA>
}
    80004de0:	01813083          	ld	ra,24(sp)
    80004de4:	01013403          	ld	s0,16(sp)
    80004de8:	00813483          	ld	s1,8(sp)
    80004dec:	00013903          	ld	s2,0(sp)
    80004df0:	02010113          	addi	sp,sp,32
    80004df4:	00008067          	ret

0000000080004df8 <_ZN7WorkerB11workerBodyBEPv>:

void WorkerB::workerBodyB(void *arg) {
    80004df8:	fe010113          	addi	sp,sp,-32
    80004dfc:	00113c23          	sd	ra,24(sp)
    80004e00:	00813823          	sd	s0,16(sp)
    80004e04:	00913423          	sd	s1,8(sp)
    80004e08:	01213023          	sd	s2,0(sp)
    80004e0c:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 16; i++) {
    80004e10:	00000913          	li	s2,0
    80004e14:	0380006f          	j	80004e4c <_ZN7WorkerB11workerBodyBEPv+0x54>
        printString("B: i="); printInt(i); printString("\n");
        for (uint64 j = 0; j < 10000; j++) {
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
            thread_dispatch();
    80004e18:	ffffc097          	auipc	ra,0xffffc
    80004e1c:	570080e7          	jalr	1392(ra) # 80001388 <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++) {
    80004e20:	00148493          	addi	s1,s1,1
    80004e24:	000027b7          	lui	a5,0x2
    80004e28:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    80004e2c:	0097ee63          	bltu	a5,s1,80004e48 <_ZN7WorkerB11workerBodyBEPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    80004e30:	00000713          	li	a4,0
    80004e34:	000077b7          	lui	a5,0x7
    80004e38:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    80004e3c:	fce7eee3          	bltu	a5,a4,80004e18 <_ZN7WorkerB11workerBodyBEPv+0x20>
    80004e40:	00170713          	addi	a4,a4,1
    80004e44:	ff1ff06f          	j	80004e34 <_ZN7WorkerB11workerBodyBEPv+0x3c>
    for (uint64 i = 0; i < 16; i++) {
    80004e48:	00190913          	addi	s2,s2,1
    80004e4c:	00f00793          	li	a5,15
    80004e50:	0527e063          	bltu	a5,s2,80004e90 <_ZN7WorkerB11workerBodyBEPv+0x98>
        printString("B: i="); printInt(i); printString("\n");
    80004e54:	00005517          	auipc	a0,0x5
    80004e58:	6a450513          	addi	a0,a0,1700 # 8000a4f8 <CONSOLE_STATUS+0x4e8>
    80004e5c:	ffffd097          	auipc	ra,0xffffd
    80004e60:	0a4080e7          	jalr	164(ra) # 80001f00 <_Z11printStringPKc>
    80004e64:	00000613          	li	a2,0
    80004e68:	00a00593          	li	a1,10
    80004e6c:	0009051b          	sext.w	a0,s2
    80004e70:	ffffd097          	auipc	ra,0xffffd
    80004e74:	240080e7          	jalr	576(ra) # 800020b0 <_Z8printIntiii>
    80004e78:	00006517          	auipc	a0,0x6
    80004e7c:	8b850513          	addi	a0,a0,-1864 # 8000a730 <CONSOLE_STATUS+0x720>
    80004e80:	ffffd097          	auipc	ra,0xffffd
    80004e84:	080080e7          	jalr	128(ra) # 80001f00 <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    80004e88:	00000493          	li	s1,0
    80004e8c:	f99ff06f          	j	80004e24 <_ZN7WorkerB11workerBodyBEPv+0x2c>
        }
    }
    printString("B finished!\n");
    80004e90:	00005517          	auipc	a0,0x5
    80004e94:	67050513          	addi	a0,a0,1648 # 8000a500 <CONSOLE_STATUS+0x4f0>
    80004e98:	ffffd097          	auipc	ra,0xffffd
    80004e9c:	068080e7          	jalr	104(ra) # 80001f00 <_Z11printStringPKc>
    finishedB = true;
    80004ea0:	00100793          	li	a5,1
    80004ea4:	0000b717          	auipc	a4,0xb
    80004ea8:	2ef702a3          	sb	a5,741(a4) # 80010189 <_ZL9finishedB>
    thread_dispatch();
    80004eac:	ffffc097          	auipc	ra,0xffffc
    80004eb0:	4dc080e7          	jalr	1244(ra) # 80001388 <_Z15thread_dispatchv>
}
    80004eb4:	01813083          	ld	ra,24(sp)
    80004eb8:	01013403          	ld	s0,16(sp)
    80004ebc:	00813483          	ld	s1,8(sp)
    80004ec0:	00013903          	ld	s2,0(sp)
    80004ec4:	02010113          	addi	sp,sp,32
    80004ec8:	00008067          	ret

0000000080004ecc <_ZN7WorkerC11workerBodyCEPv>:

void WorkerC::workerBodyC(void *arg) {
    80004ecc:	fe010113          	addi	sp,sp,-32
    80004ed0:	00113c23          	sd	ra,24(sp)
    80004ed4:	00813823          	sd	s0,16(sp)
    80004ed8:	00913423          	sd	s1,8(sp)
    80004edc:	01213023          	sd	s2,0(sp)
    80004ee0:	02010413          	addi	s0,sp,32
    uint8 i = 0;
    80004ee4:	00000493          	li	s1,0
    80004ee8:	0400006f          	j	80004f28 <_ZN7WorkerC11workerBodyCEPv+0x5c>
    for (; i < 3; i++) {
        printString("C: i="); printInt(i); printString("\n");
    80004eec:	00005517          	auipc	a0,0x5
    80004ef0:	62450513          	addi	a0,a0,1572 # 8000a510 <CONSOLE_STATUS+0x500>
    80004ef4:	ffffd097          	auipc	ra,0xffffd
    80004ef8:	00c080e7          	jalr	12(ra) # 80001f00 <_Z11printStringPKc>
    80004efc:	00000613          	li	a2,0
    80004f00:	00a00593          	li	a1,10
    80004f04:	00048513          	mv	a0,s1
    80004f08:	ffffd097          	auipc	ra,0xffffd
    80004f0c:	1a8080e7          	jalr	424(ra) # 800020b0 <_Z8printIntiii>
    80004f10:	00006517          	auipc	a0,0x6
    80004f14:	82050513          	addi	a0,a0,-2016 # 8000a730 <CONSOLE_STATUS+0x720>
    80004f18:	ffffd097          	auipc	ra,0xffffd
    80004f1c:	fe8080e7          	jalr	-24(ra) # 80001f00 <_Z11printStringPKc>
    for (; i < 3; i++) {
    80004f20:	0014849b          	addiw	s1,s1,1
    80004f24:	0ff4f493          	andi	s1,s1,255
    80004f28:	00200793          	li	a5,2
    80004f2c:	fc97f0e3          	bgeu	a5,s1,80004eec <_ZN7WorkerC11workerBodyCEPv+0x20>
    }

    printString("C: dispatch\n");
    80004f30:	00005517          	auipc	a0,0x5
    80004f34:	5e850513          	addi	a0,a0,1512 # 8000a518 <CONSOLE_STATUS+0x508>
    80004f38:	ffffd097          	auipc	ra,0xffffd
    80004f3c:	fc8080e7          	jalr	-56(ra) # 80001f00 <_Z11printStringPKc>
    __asm__ ("li t1, 7");
    80004f40:	00700313          	li	t1,7
    thread_dispatch();
    80004f44:	ffffc097          	auipc	ra,0xffffc
    80004f48:	444080e7          	jalr	1092(ra) # 80001388 <_Z15thread_dispatchv>

    uint64 t1 = 0;
    __asm__ ("mv %[t1], t1" : [t1] "=r"(t1));
    80004f4c:	00030913          	mv	s2,t1

    printString("C: t1="); printInt(t1); printString("\n");
    80004f50:	00005517          	auipc	a0,0x5
    80004f54:	5d850513          	addi	a0,a0,1496 # 8000a528 <CONSOLE_STATUS+0x518>
    80004f58:	ffffd097          	auipc	ra,0xffffd
    80004f5c:	fa8080e7          	jalr	-88(ra) # 80001f00 <_Z11printStringPKc>
    80004f60:	00000613          	li	a2,0
    80004f64:	00a00593          	li	a1,10
    80004f68:	0009051b          	sext.w	a0,s2
    80004f6c:	ffffd097          	auipc	ra,0xffffd
    80004f70:	144080e7          	jalr	324(ra) # 800020b0 <_Z8printIntiii>
    80004f74:	00005517          	auipc	a0,0x5
    80004f78:	7bc50513          	addi	a0,a0,1980 # 8000a730 <CONSOLE_STATUS+0x720>
    80004f7c:	ffffd097          	auipc	ra,0xffffd
    80004f80:	f84080e7          	jalr	-124(ra) # 80001f00 <_Z11printStringPKc>

    uint64 result = fibonacci(12);
    80004f84:	00c00513          	li	a0,12
    80004f88:	00000097          	auipc	ra,0x0
    80004f8c:	d30080e7          	jalr	-720(ra) # 80004cb8 <_ZL9fibonaccim>
    80004f90:	00050913          	mv	s2,a0
    printString("C: fibonaci="); printInt(result); printString("\n");
    80004f94:	00005517          	auipc	a0,0x5
    80004f98:	59c50513          	addi	a0,a0,1436 # 8000a530 <CONSOLE_STATUS+0x520>
    80004f9c:	ffffd097          	auipc	ra,0xffffd
    80004fa0:	f64080e7          	jalr	-156(ra) # 80001f00 <_Z11printStringPKc>
    80004fa4:	00000613          	li	a2,0
    80004fa8:	00a00593          	li	a1,10
    80004fac:	0009051b          	sext.w	a0,s2
    80004fb0:	ffffd097          	auipc	ra,0xffffd
    80004fb4:	100080e7          	jalr	256(ra) # 800020b0 <_Z8printIntiii>
    80004fb8:	00005517          	auipc	a0,0x5
    80004fbc:	77850513          	addi	a0,a0,1912 # 8000a730 <CONSOLE_STATUS+0x720>
    80004fc0:	ffffd097          	auipc	ra,0xffffd
    80004fc4:	f40080e7          	jalr	-192(ra) # 80001f00 <_Z11printStringPKc>
    80004fc8:	0400006f          	j	80005008 <_ZN7WorkerC11workerBodyCEPv+0x13c>

    for (; i < 6; i++) {
        printString("C: i="); printInt(i); printString("\n");
    80004fcc:	00005517          	auipc	a0,0x5
    80004fd0:	54450513          	addi	a0,a0,1348 # 8000a510 <CONSOLE_STATUS+0x500>
    80004fd4:	ffffd097          	auipc	ra,0xffffd
    80004fd8:	f2c080e7          	jalr	-212(ra) # 80001f00 <_Z11printStringPKc>
    80004fdc:	00000613          	li	a2,0
    80004fe0:	00a00593          	li	a1,10
    80004fe4:	00048513          	mv	a0,s1
    80004fe8:	ffffd097          	auipc	ra,0xffffd
    80004fec:	0c8080e7          	jalr	200(ra) # 800020b0 <_Z8printIntiii>
    80004ff0:	00005517          	auipc	a0,0x5
    80004ff4:	74050513          	addi	a0,a0,1856 # 8000a730 <CONSOLE_STATUS+0x720>
    80004ff8:	ffffd097          	auipc	ra,0xffffd
    80004ffc:	f08080e7          	jalr	-248(ra) # 80001f00 <_Z11printStringPKc>
    for (; i < 6; i++) {
    80005000:	0014849b          	addiw	s1,s1,1
    80005004:	0ff4f493          	andi	s1,s1,255
    80005008:	00500793          	li	a5,5
    8000500c:	fc97f0e3          	bgeu	a5,s1,80004fcc <_ZN7WorkerC11workerBodyCEPv+0x100>
    }

    printString("A finished!\n");
    80005010:	00005517          	auipc	a0,0x5
    80005014:	4d850513          	addi	a0,a0,1240 # 8000a4e8 <CONSOLE_STATUS+0x4d8>
    80005018:	ffffd097          	auipc	ra,0xffffd
    8000501c:	ee8080e7          	jalr	-280(ra) # 80001f00 <_Z11printStringPKc>
    finishedC = true;
    80005020:	00100793          	li	a5,1
    80005024:	0000b717          	auipc	a4,0xb
    80005028:	16f70323          	sb	a5,358(a4) # 8001018a <_ZL9finishedC>
    thread_dispatch();
    8000502c:	ffffc097          	auipc	ra,0xffffc
    80005030:	35c080e7          	jalr	860(ra) # 80001388 <_Z15thread_dispatchv>
}
    80005034:	01813083          	ld	ra,24(sp)
    80005038:	01013403          	ld	s0,16(sp)
    8000503c:	00813483          	ld	s1,8(sp)
    80005040:	00013903          	ld	s2,0(sp)
    80005044:	02010113          	addi	sp,sp,32
    80005048:	00008067          	ret

000000008000504c <_ZN7WorkerD11workerBodyDEPv>:

void WorkerD::workerBodyD(void* arg) {
    8000504c:	fe010113          	addi	sp,sp,-32
    80005050:	00113c23          	sd	ra,24(sp)
    80005054:	00813823          	sd	s0,16(sp)
    80005058:	00913423          	sd	s1,8(sp)
    8000505c:	01213023          	sd	s2,0(sp)
    80005060:	02010413          	addi	s0,sp,32
    uint8 i = 10;
    80005064:	00a00493          	li	s1,10
    80005068:	0400006f          	j	800050a8 <_ZN7WorkerD11workerBodyDEPv+0x5c>
    for (; i < 13; i++) {
        printString("D: i="); printInt(i); printString("\n");
    8000506c:	00005517          	auipc	a0,0x5
    80005070:	4d450513          	addi	a0,a0,1236 # 8000a540 <CONSOLE_STATUS+0x530>
    80005074:	ffffd097          	auipc	ra,0xffffd
    80005078:	e8c080e7          	jalr	-372(ra) # 80001f00 <_Z11printStringPKc>
    8000507c:	00000613          	li	a2,0
    80005080:	00a00593          	li	a1,10
    80005084:	00048513          	mv	a0,s1
    80005088:	ffffd097          	auipc	ra,0xffffd
    8000508c:	028080e7          	jalr	40(ra) # 800020b0 <_Z8printIntiii>
    80005090:	00005517          	auipc	a0,0x5
    80005094:	6a050513          	addi	a0,a0,1696 # 8000a730 <CONSOLE_STATUS+0x720>
    80005098:	ffffd097          	auipc	ra,0xffffd
    8000509c:	e68080e7          	jalr	-408(ra) # 80001f00 <_Z11printStringPKc>
    for (; i < 13; i++) {
    800050a0:	0014849b          	addiw	s1,s1,1
    800050a4:	0ff4f493          	andi	s1,s1,255
    800050a8:	00c00793          	li	a5,12
    800050ac:	fc97f0e3          	bgeu	a5,s1,8000506c <_ZN7WorkerD11workerBodyDEPv+0x20>
    }

    printString("D: dispatch\n");
    800050b0:	00005517          	auipc	a0,0x5
    800050b4:	49850513          	addi	a0,a0,1176 # 8000a548 <CONSOLE_STATUS+0x538>
    800050b8:	ffffd097          	auipc	ra,0xffffd
    800050bc:	e48080e7          	jalr	-440(ra) # 80001f00 <_Z11printStringPKc>
    __asm__ ("li t1, 5");
    800050c0:	00500313          	li	t1,5
    thread_dispatch();
    800050c4:	ffffc097          	auipc	ra,0xffffc
    800050c8:	2c4080e7          	jalr	708(ra) # 80001388 <_Z15thread_dispatchv>

    uint64 result = fibonacci(16);
    800050cc:	01000513          	li	a0,16
    800050d0:	00000097          	auipc	ra,0x0
    800050d4:	be8080e7          	jalr	-1048(ra) # 80004cb8 <_ZL9fibonaccim>
    800050d8:	00050913          	mv	s2,a0
    printString("D: fibonaci="); printInt(result); printString("\n");
    800050dc:	00005517          	auipc	a0,0x5
    800050e0:	47c50513          	addi	a0,a0,1148 # 8000a558 <CONSOLE_STATUS+0x548>
    800050e4:	ffffd097          	auipc	ra,0xffffd
    800050e8:	e1c080e7          	jalr	-484(ra) # 80001f00 <_Z11printStringPKc>
    800050ec:	00000613          	li	a2,0
    800050f0:	00a00593          	li	a1,10
    800050f4:	0009051b          	sext.w	a0,s2
    800050f8:	ffffd097          	auipc	ra,0xffffd
    800050fc:	fb8080e7          	jalr	-72(ra) # 800020b0 <_Z8printIntiii>
    80005100:	00005517          	auipc	a0,0x5
    80005104:	63050513          	addi	a0,a0,1584 # 8000a730 <CONSOLE_STATUS+0x720>
    80005108:	ffffd097          	auipc	ra,0xffffd
    8000510c:	df8080e7          	jalr	-520(ra) # 80001f00 <_Z11printStringPKc>
    80005110:	0400006f          	j	80005150 <_ZN7WorkerD11workerBodyDEPv+0x104>

    for (; i < 16; i++) {
        printString("D: i="); printInt(i); printString("\n");
    80005114:	00005517          	auipc	a0,0x5
    80005118:	42c50513          	addi	a0,a0,1068 # 8000a540 <CONSOLE_STATUS+0x530>
    8000511c:	ffffd097          	auipc	ra,0xffffd
    80005120:	de4080e7          	jalr	-540(ra) # 80001f00 <_Z11printStringPKc>
    80005124:	00000613          	li	a2,0
    80005128:	00a00593          	li	a1,10
    8000512c:	00048513          	mv	a0,s1
    80005130:	ffffd097          	auipc	ra,0xffffd
    80005134:	f80080e7          	jalr	-128(ra) # 800020b0 <_Z8printIntiii>
    80005138:	00005517          	auipc	a0,0x5
    8000513c:	5f850513          	addi	a0,a0,1528 # 8000a730 <CONSOLE_STATUS+0x720>
    80005140:	ffffd097          	auipc	ra,0xffffd
    80005144:	dc0080e7          	jalr	-576(ra) # 80001f00 <_Z11printStringPKc>
    for (; i < 16; i++) {
    80005148:	0014849b          	addiw	s1,s1,1
    8000514c:	0ff4f493          	andi	s1,s1,255
    80005150:	00f00793          	li	a5,15
    80005154:	fc97f0e3          	bgeu	a5,s1,80005114 <_ZN7WorkerD11workerBodyDEPv+0xc8>
    }

    printString("D finished!\n");
    80005158:	00005517          	auipc	a0,0x5
    8000515c:	41050513          	addi	a0,a0,1040 # 8000a568 <CONSOLE_STATUS+0x558>
    80005160:	ffffd097          	auipc	ra,0xffffd
    80005164:	da0080e7          	jalr	-608(ra) # 80001f00 <_Z11printStringPKc>
    finishedD = true;
    80005168:	00100793          	li	a5,1
    8000516c:	0000b717          	auipc	a4,0xb
    80005170:	00f70fa3          	sb	a5,31(a4) # 8001018b <_ZL9finishedD>
    thread_dispatch();
    80005174:	ffffc097          	auipc	ra,0xffffc
    80005178:	214080e7          	jalr	532(ra) # 80001388 <_Z15thread_dispatchv>
}
    8000517c:	01813083          	ld	ra,24(sp)
    80005180:	01013403          	ld	s0,16(sp)
    80005184:	00813483          	ld	s1,8(sp)
    80005188:	00013903          	ld	s2,0(sp)
    8000518c:	02010113          	addi	sp,sp,32
    80005190:	00008067          	ret

0000000080005194 <_Z20Threads_CPP_API_testv>:


void Threads_CPP_API_test() {
    80005194:	fc010113          	addi	sp,sp,-64
    80005198:	02113c23          	sd	ra,56(sp)
    8000519c:	02813823          	sd	s0,48(sp)
    800051a0:	02913423          	sd	s1,40(sp)
    800051a4:	04010413          	addi	s0,sp,64
    Thread* threads[4];

    threads[0] = new WorkerA();
    800051a8:	02000513          	li	a0,32
    800051ac:	ffffe097          	auipc	ra,0xffffe
    800051b0:	c18080e7          	jalr	-1000(ra) # 80002dc4 <_Znwm>
        static int sleep (uint64 time){
            return time_sleep(time);
        }
        protected:
        Thread (){
            body= nullptr;
    800051b4:	00053823          	sd	zero,16(a0)
            arg= nullptr;
    800051b8:	00053c23          	sd	zero,24(a0)
    WorkerA():Thread() {}
    800051bc:	00008797          	auipc	a5,0x8
    800051c0:	88478793          	addi	a5,a5,-1916 # 8000ca40 <_ZTV7WorkerA+0x10>
    800051c4:	00f53023          	sd	a5,0(a0)
    threads[0] = new WorkerA();
    800051c8:	fca43023          	sd	a0,-64(s0)
    printString("ThreadA created\n");
    800051cc:	00005517          	auipc	a0,0x5
    800051d0:	3ac50513          	addi	a0,a0,940 # 8000a578 <CONSOLE_STATUS+0x568>
    800051d4:	ffffd097          	auipc	ra,0xffffd
    800051d8:	d2c080e7          	jalr	-724(ra) # 80001f00 <_Z11printStringPKc>

    threads[1] = new WorkerB();
    800051dc:	02000513          	li	a0,32
    800051e0:	ffffe097          	auipc	ra,0xffffe
    800051e4:	be4080e7          	jalr	-1052(ra) # 80002dc4 <_Znwm>
            body= nullptr;
    800051e8:	00053823          	sd	zero,16(a0)
            arg= nullptr;
    800051ec:	00053c23          	sd	zero,24(a0)
    WorkerB():Thread() {}
    800051f0:	00008797          	auipc	a5,0x8
    800051f4:	87878793          	addi	a5,a5,-1928 # 8000ca68 <_ZTV7WorkerB+0x10>
    800051f8:	00f53023          	sd	a5,0(a0)
    threads[1] = new WorkerB();
    800051fc:	fca43423          	sd	a0,-56(s0)
    printString("ThreadB created\n");
    80005200:	00005517          	auipc	a0,0x5
    80005204:	39050513          	addi	a0,a0,912 # 8000a590 <CONSOLE_STATUS+0x580>
    80005208:	ffffd097          	auipc	ra,0xffffd
    8000520c:	cf8080e7          	jalr	-776(ra) # 80001f00 <_Z11printStringPKc>

    threads[2] = new WorkerC();
    80005210:	02000513          	li	a0,32
    80005214:	ffffe097          	auipc	ra,0xffffe
    80005218:	bb0080e7          	jalr	-1104(ra) # 80002dc4 <_Znwm>
            body= nullptr;
    8000521c:	00053823          	sd	zero,16(a0)
            arg= nullptr;
    80005220:	00053c23          	sd	zero,24(a0)
    WorkerC():Thread() {}
    80005224:	00008797          	auipc	a5,0x8
    80005228:	86c78793          	addi	a5,a5,-1940 # 8000ca90 <_ZTV7WorkerC+0x10>
    8000522c:	00f53023          	sd	a5,0(a0)
    threads[2] = new WorkerC();
    80005230:	fca43823          	sd	a0,-48(s0)
    printString("ThreadC created\n");
    80005234:	00005517          	auipc	a0,0x5
    80005238:	37450513          	addi	a0,a0,884 # 8000a5a8 <CONSOLE_STATUS+0x598>
    8000523c:	ffffd097          	auipc	ra,0xffffd
    80005240:	cc4080e7          	jalr	-828(ra) # 80001f00 <_Z11printStringPKc>

    threads[3] = new WorkerD();
    80005244:	02000513          	li	a0,32
    80005248:	ffffe097          	auipc	ra,0xffffe
    8000524c:	b7c080e7          	jalr	-1156(ra) # 80002dc4 <_Znwm>
            body= nullptr;
    80005250:	00053823          	sd	zero,16(a0)
            arg= nullptr;
    80005254:	00053c23          	sd	zero,24(a0)
    WorkerD():Thread() {}
    80005258:	00008797          	auipc	a5,0x8
    8000525c:	86078793          	addi	a5,a5,-1952 # 8000cab8 <_ZTV7WorkerD+0x10>
    80005260:	00f53023          	sd	a5,0(a0)
    threads[3] = new WorkerD();
    80005264:	fca43c23          	sd	a0,-40(s0)
    printString("ThreadD created\n");
    80005268:	00005517          	auipc	a0,0x5
    8000526c:	35850513          	addi	a0,a0,856 # 8000a5c0 <CONSOLE_STATUS+0x5b0>
    80005270:	ffffd097          	auipc	ra,0xffffd
    80005274:	c90080e7          	jalr	-880(ra) # 80001f00 <_Z11printStringPKc>

    for(int i=0; i<4; i++) {
    80005278:	00000493          	li	s1,0
    8000527c:	0200006f          	j	8000529c <_Z20Threads_CPP_API_testv+0x108>
            if(body== nullptr) return thread_create(&myHandle,&threadEntry, this);
    80005280:	00050613          	mv	a2,a0
    80005284:	ffffe597          	auipc	a1,0xffffe
    80005288:	9cc58593          	addi	a1,a1,-1588 # 80002c50 <_ZN6Thread11threadEntryEPv>
    8000528c:	00850513          	addi	a0,a0,8
    80005290:	ffffc097          	auipc	ra,0xffffc
    80005294:	070080e7          	jalr	112(ra) # 80001300 <_Z13thread_createPP8thread_sPFvPvES2_>
    80005298:	0014849b          	addiw	s1,s1,1
    8000529c:	00300793          	li	a5,3
    800052a0:	0297cc63          	blt	a5,s1,800052d8 <_Z20Threads_CPP_API_testv+0x144>
        threads[i]->start();
    800052a4:	00349793          	slli	a5,s1,0x3
    800052a8:	fe040713          	addi	a4,s0,-32
    800052ac:	00f707b3          	add	a5,a4,a5
    800052b0:	fe07b503          	ld	a0,-32(a5)
    800052b4:	01053583          	ld	a1,16(a0)
    800052b8:	fc0584e3          	beqz	a1,80005280 <_Z20Threads_CPP_API_testv+0xec>
            else return thread_create(&myHandle,body,arg);
    800052bc:	01853603          	ld	a2,24(a0)
    800052c0:	00850513          	addi	a0,a0,8
    800052c4:	ffffc097          	auipc	ra,0xffffc
    800052c8:	03c080e7          	jalr	60(ra) # 80001300 <_Z13thread_createPP8thread_sPFvPvES2_>
    800052cc:	fcdff06f          	j	80005298 <_Z20Threads_CPP_API_testv+0x104>
            thread_dispatch();
    800052d0:	ffffc097          	auipc	ra,0xffffc
    800052d4:	0b8080e7          	jalr	184(ra) # 80001388 <_Z15thread_dispatchv>
    }

    while (!(finishedA && finishedB && finishedC && finishedD)) {
    800052d8:	0000b797          	auipc	a5,0xb
    800052dc:	eb07c783          	lbu	a5,-336(a5) # 80010188 <_ZL9finishedA>
    800052e0:	fe0788e3          	beqz	a5,800052d0 <_Z20Threads_CPP_API_testv+0x13c>
    800052e4:	0000b797          	auipc	a5,0xb
    800052e8:	ea57c783          	lbu	a5,-347(a5) # 80010189 <_ZL9finishedB>
    800052ec:	fe0782e3          	beqz	a5,800052d0 <_Z20Threads_CPP_API_testv+0x13c>
    800052f0:	0000b797          	auipc	a5,0xb
    800052f4:	e9a7c783          	lbu	a5,-358(a5) # 8001018a <_ZL9finishedC>
    800052f8:	fc078ce3          	beqz	a5,800052d0 <_Z20Threads_CPP_API_testv+0x13c>
    800052fc:	0000b797          	auipc	a5,0xb
    80005300:	e8f7c783          	lbu	a5,-369(a5) # 8001018b <_ZL9finishedD>
    80005304:	fc0786e3          	beqz	a5,800052d0 <_Z20Threads_CPP_API_testv+0x13c>
    80005308:	fc040493          	addi	s1,s0,-64
    8000530c:	0080006f          	j	80005314 <_Z20Threads_CPP_API_testv+0x180>
        Thread::dispatch();
    }

    for (auto thread: threads) { delete thread; }
    80005310:	00848493          	addi	s1,s1,8
    80005314:	fe040793          	addi	a5,s0,-32
    80005318:	00f48e63          	beq	s1,a5,80005334 <_Z20Threads_CPP_API_testv+0x1a0>
    8000531c:	0004b503          	ld	a0,0(s1)
    80005320:	fe0508e3          	beqz	a0,80005310 <_Z20Threads_CPP_API_testv+0x17c>
    80005324:	00053783          	ld	a5,0(a0)
    80005328:	0087b783          	ld	a5,8(a5)
    8000532c:	000780e7          	jalr	a5
    80005330:	fe1ff06f          	j	80005310 <_Z20Threads_CPP_API_testv+0x17c>
}
    80005334:	03813083          	ld	ra,56(sp)
    80005338:	03013403          	ld	s0,48(sp)
    8000533c:	02813483          	ld	s1,40(sp)
    80005340:	04010113          	addi	sp,sp,64
    80005344:	00008067          	ret

0000000080005348 <_ZN7WorkerDD1Ev>:
class WorkerD: public Thread {
    80005348:	ff010113          	addi	sp,sp,-16
    8000534c:	00813423          	sd	s0,8(sp)
    80005350:	01010413          	addi	s0,sp,16
    80005354:	00813403          	ld	s0,8(sp)
    80005358:	01010113          	addi	sp,sp,16
    8000535c:	00008067          	ret

0000000080005360 <_ZN7WorkerCD1Ev>:
class WorkerC: public Thread {
    80005360:	ff010113          	addi	sp,sp,-16
    80005364:	00813423          	sd	s0,8(sp)
    80005368:	01010413          	addi	s0,sp,16
    8000536c:	00813403          	ld	s0,8(sp)
    80005370:	01010113          	addi	sp,sp,16
    80005374:	00008067          	ret

0000000080005378 <_ZN7WorkerBD1Ev>:
class WorkerB: public Thread {
    80005378:	ff010113          	addi	sp,sp,-16
    8000537c:	00813423          	sd	s0,8(sp)
    80005380:	01010413          	addi	s0,sp,16
    80005384:	00813403          	ld	s0,8(sp)
    80005388:	01010113          	addi	sp,sp,16
    8000538c:	00008067          	ret

0000000080005390 <_ZN7WorkerAD1Ev>:
class WorkerA: public Thread {
    80005390:	ff010113          	addi	sp,sp,-16
    80005394:	00813423          	sd	s0,8(sp)
    80005398:	01010413          	addi	s0,sp,16
    8000539c:	00813403          	ld	s0,8(sp)
    800053a0:	01010113          	addi	sp,sp,16
    800053a4:	00008067          	ret

00000000800053a8 <_ZN7WorkerAD0Ev>:
    800053a8:	ff010113          	addi	sp,sp,-16
    800053ac:	00113423          	sd	ra,8(sp)
    800053b0:	00813023          	sd	s0,0(sp)
    800053b4:	01010413          	addi	s0,sp,16
    800053b8:	ffffe097          	auipc	ra,0xffffe
    800053bc:	a34080e7          	jalr	-1484(ra) # 80002dec <_ZdlPv>
    800053c0:	00813083          	ld	ra,8(sp)
    800053c4:	00013403          	ld	s0,0(sp)
    800053c8:	01010113          	addi	sp,sp,16
    800053cc:	00008067          	ret

00000000800053d0 <_ZN7WorkerBD0Ev>:
class WorkerB: public Thread {
    800053d0:	ff010113          	addi	sp,sp,-16
    800053d4:	00113423          	sd	ra,8(sp)
    800053d8:	00813023          	sd	s0,0(sp)
    800053dc:	01010413          	addi	s0,sp,16
    800053e0:	ffffe097          	auipc	ra,0xffffe
    800053e4:	a0c080e7          	jalr	-1524(ra) # 80002dec <_ZdlPv>
    800053e8:	00813083          	ld	ra,8(sp)
    800053ec:	00013403          	ld	s0,0(sp)
    800053f0:	01010113          	addi	sp,sp,16
    800053f4:	00008067          	ret

00000000800053f8 <_ZN7WorkerCD0Ev>:
class WorkerC: public Thread {
    800053f8:	ff010113          	addi	sp,sp,-16
    800053fc:	00113423          	sd	ra,8(sp)
    80005400:	00813023          	sd	s0,0(sp)
    80005404:	01010413          	addi	s0,sp,16
    80005408:	ffffe097          	auipc	ra,0xffffe
    8000540c:	9e4080e7          	jalr	-1564(ra) # 80002dec <_ZdlPv>
    80005410:	00813083          	ld	ra,8(sp)
    80005414:	00013403          	ld	s0,0(sp)
    80005418:	01010113          	addi	sp,sp,16
    8000541c:	00008067          	ret

0000000080005420 <_ZN7WorkerDD0Ev>:
class WorkerD: public Thread {
    80005420:	ff010113          	addi	sp,sp,-16
    80005424:	00113423          	sd	ra,8(sp)
    80005428:	00813023          	sd	s0,0(sp)
    8000542c:	01010413          	addi	s0,sp,16
    80005430:	ffffe097          	auipc	ra,0xffffe
    80005434:	9bc080e7          	jalr	-1604(ra) # 80002dec <_ZdlPv>
    80005438:	00813083          	ld	ra,8(sp)
    8000543c:	00013403          	ld	s0,0(sp)
    80005440:	01010113          	addi	sp,sp,16
    80005444:	00008067          	ret

0000000080005448 <_ZN7WorkerA3runEv>:
    void run() override {
    80005448:	ff010113          	addi	sp,sp,-16
    8000544c:	00113423          	sd	ra,8(sp)
    80005450:	00813023          	sd	s0,0(sp)
    80005454:	01010413          	addi	s0,sp,16
        workerBodyA(nullptr);
    80005458:	00000593          	li	a1,0
    8000545c:	00000097          	auipc	ra,0x0
    80005460:	8d0080e7          	jalr	-1840(ra) # 80004d2c <_ZN7WorkerA11workerBodyAEPv>
    }
    80005464:	00813083          	ld	ra,8(sp)
    80005468:	00013403          	ld	s0,0(sp)
    8000546c:	01010113          	addi	sp,sp,16
    80005470:	00008067          	ret

0000000080005474 <_ZN7WorkerB3runEv>:
    void run() override {
    80005474:	ff010113          	addi	sp,sp,-16
    80005478:	00113423          	sd	ra,8(sp)
    8000547c:	00813023          	sd	s0,0(sp)
    80005480:	01010413          	addi	s0,sp,16
        workerBodyB(nullptr);
    80005484:	00000593          	li	a1,0
    80005488:	00000097          	auipc	ra,0x0
    8000548c:	970080e7          	jalr	-1680(ra) # 80004df8 <_ZN7WorkerB11workerBodyBEPv>
    }
    80005490:	00813083          	ld	ra,8(sp)
    80005494:	00013403          	ld	s0,0(sp)
    80005498:	01010113          	addi	sp,sp,16
    8000549c:	00008067          	ret

00000000800054a0 <_ZN7WorkerC3runEv>:
    void run() override {
    800054a0:	ff010113          	addi	sp,sp,-16
    800054a4:	00113423          	sd	ra,8(sp)
    800054a8:	00813023          	sd	s0,0(sp)
    800054ac:	01010413          	addi	s0,sp,16
        workerBodyC(nullptr);
    800054b0:	00000593          	li	a1,0
    800054b4:	00000097          	auipc	ra,0x0
    800054b8:	a18080e7          	jalr	-1512(ra) # 80004ecc <_ZN7WorkerC11workerBodyCEPv>
    }
    800054bc:	00813083          	ld	ra,8(sp)
    800054c0:	00013403          	ld	s0,0(sp)
    800054c4:	01010113          	addi	sp,sp,16
    800054c8:	00008067          	ret

00000000800054cc <_ZN7WorkerD3runEv>:
    void run() override {
    800054cc:	ff010113          	addi	sp,sp,-16
    800054d0:	00113423          	sd	ra,8(sp)
    800054d4:	00813023          	sd	s0,0(sp)
    800054d8:	01010413          	addi	s0,sp,16
        workerBodyD(nullptr);
    800054dc:	00000593          	li	a1,0
    800054e0:	00000097          	auipc	ra,0x0
    800054e4:	b6c080e7          	jalr	-1172(ra) # 8000504c <_ZN7WorkerD11workerBodyDEPv>
    }
    800054e8:	00813083          	ld	ra,8(sp)
    800054ec:	00013403          	ld	s0,0(sp)
    800054f0:	01010113          	addi	sp,sp,16
    800054f4:	00008067          	ret

00000000800054f8 <_Z20testConsumerProducerv>:

        td->sem->signal();
    }
};

void testConsumerProducer() {
    800054f8:	f9010113          	addi	sp,sp,-112
    800054fc:	06113423          	sd	ra,104(sp)
    80005500:	06813023          	sd	s0,96(sp)
    80005504:	04913c23          	sd	s1,88(sp)
    80005508:	05213823          	sd	s2,80(sp)
    8000550c:	05313423          	sd	s3,72(sp)
    80005510:	05413023          	sd	s4,64(sp)
    80005514:	03513c23          	sd	s5,56(sp)
    80005518:	03613823          	sd	s6,48(sp)
    8000551c:	03713423          	sd	s7,40(sp)
    80005520:	03813023          	sd	s8,32(sp)
    80005524:	07010413          	addi	s0,sp,112
    delete waitForAll;
    for (int i = 0; i < threadNum; i++) {
        delete producers[i];
    }
    delete consumer;
    delete buffer;
    80005528:	00010c13          	mv	s8,sp
    printString("Unesite broj proizvodjaca?\n");
    8000552c:	00005517          	auipc	a0,0x5
    80005530:	ecc50513          	addi	a0,a0,-308 # 8000a3f8 <CONSOLE_STATUS+0x3e8>
    80005534:	ffffd097          	auipc	ra,0xffffd
    80005538:	9cc080e7          	jalr	-1588(ra) # 80001f00 <_Z11printStringPKc>
    getString(input, 30);
    8000553c:	01e00593          	li	a1,30
    80005540:	f9040493          	addi	s1,s0,-112
    80005544:	00048513          	mv	a0,s1
    80005548:	ffffd097          	auipc	ra,0xffffd
    8000554c:	a40080e7          	jalr	-1472(ra) # 80001f88 <_Z9getStringPci>
    threadNum = stringToInt(input);
    80005550:	00048513          	mv	a0,s1
    80005554:	ffffd097          	auipc	ra,0xffffd
    80005558:	b0c080e7          	jalr	-1268(ra) # 80002060 <_Z11stringToIntPKc>
    8000555c:	00050993          	mv	s3,a0
    printString("Unesite velicinu bafera?\n");
    80005560:	00005517          	auipc	a0,0x5
    80005564:	eb850513          	addi	a0,a0,-328 # 8000a418 <CONSOLE_STATUS+0x408>
    80005568:	ffffd097          	auipc	ra,0xffffd
    8000556c:	998080e7          	jalr	-1640(ra) # 80001f00 <_Z11printStringPKc>
    getString(input, 30);
    80005570:	01e00593          	li	a1,30
    80005574:	00048513          	mv	a0,s1
    80005578:	ffffd097          	auipc	ra,0xffffd
    8000557c:	a10080e7          	jalr	-1520(ra) # 80001f88 <_Z9getStringPci>
    n = stringToInt(input);
    80005580:	00048513          	mv	a0,s1
    80005584:	ffffd097          	auipc	ra,0xffffd
    80005588:	adc080e7          	jalr	-1316(ra) # 80002060 <_Z11stringToIntPKc>
    8000558c:	00050493          	mv	s1,a0
    printString("Broj proizvodjaca ");
    80005590:	00005517          	auipc	a0,0x5
    80005594:	ea850513          	addi	a0,a0,-344 # 8000a438 <CONSOLE_STATUS+0x428>
    80005598:	ffffd097          	auipc	ra,0xffffd
    8000559c:	968080e7          	jalr	-1688(ra) # 80001f00 <_Z11printStringPKc>
    printInt(threadNum);
    800055a0:	00000613          	li	a2,0
    800055a4:	00a00593          	li	a1,10
    800055a8:	00098513          	mv	a0,s3
    800055ac:	ffffd097          	auipc	ra,0xffffd
    800055b0:	b04080e7          	jalr	-1276(ra) # 800020b0 <_Z8printIntiii>
    printString(" i velicina bafera ");
    800055b4:	00005517          	auipc	a0,0x5
    800055b8:	e9c50513          	addi	a0,a0,-356 # 8000a450 <CONSOLE_STATUS+0x440>
    800055bc:	ffffd097          	auipc	ra,0xffffd
    800055c0:	944080e7          	jalr	-1724(ra) # 80001f00 <_Z11printStringPKc>
    printInt(n);
    800055c4:	00000613          	li	a2,0
    800055c8:	00a00593          	li	a1,10
    800055cc:	00048513          	mv	a0,s1
    800055d0:	ffffd097          	auipc	ra,0xffffd
    800055d4:	ae0080e7          	jalr	-1312(ra) # 800020b0 <_Z8printIntiii>
    printString(".\n");
    800055d8:	00005517          	auipc	a0,0x5
    800055dc:	e9050513          	addi	a0,a0,-368 # 8000a468 <CONSOLE_STATUS+0x458>
    800055e0:	ffffd097          	auipc	ra,0xffffd
    800055e4:	920080e7          	jalr	-1760(ra) # 80001f00 <_Z11printStringPKc>
    if (threadNum > n) {
    800055e8:	0334c463          	blt	s1,s3,80005610 <_Z20testConsumerProducerv+0x118>
    } else if (threadNum < 1) {
    800055ec:	03305c63          	blez	s3,80005624 <_Z20testConsumerProducerv+0x12c>
    BufferCPP *buffer = new BufferCPP(n);
    800055f0:	03800513          	li	a0,56
    800055f4:	ffffd097          	auipc	ra,0xffffd
    800055f8:	7d0080e7          	jalr	2000(ra) # 80002dc4 <_Znwm>
    800055fc:	00050a93          	mv	s5,a0
    80005600:	00048593          	mv	a1,s1
    80005604:	00001097          	auipc	ra,0x1
    80005608:	3e8080e7          	jalr	1000(ra) # 800069ec <_ZN9BufferCPPC1Ei>
    8000560c:	0300006f          	j	8000563c <_Z20testConsumerProducerv+0x144>
        printString("Broj proizvodjaca ne sme biti manji od velicine bafera!\n");
    80005610:	00005517          	auipc	a0,0x5
    80005614:	e6050513          	addi	a0,a0,-416 # 8000a470 <CONSOLE_STATUS+0x460>
    80005618:	ffffd097          	auipc	ra,0xffffd
    8000561c:	8e8080e7          	jalr	-1816(ra) # 80001f00 <_Z11printStringPKc>
        return;
    80005620:	0140006f          	j	80005634 <_Z20testConsumerProducerv+0x13c>
        printString("Broj proizvodjaca mora biti veci od nula!\n");
    80005624:	00005517          	auipc	a0,0x5
    80005628:	e8c50513          	addi	a0,a0,-372 # 8000a4b0 <CONSOLE_STATUS+0x4a0>
    8000562c:	ffffd097          	auipc	ra,0xffffd
    80005630:	8d4080e7          	jalr	-1836(ra) # 80001f00 <_Z11printStringPKc>
        return;
    80005634:	000c0113          	mv	sp,s8
    80005638:	2780006f          	j	800058b0 <_Z20testConsumerProducerv+0x3b8>
    waitForAll = new Semaphore(0);
    8000563c:	01000513          	li	a0,16
    80005640:	ffffd097          	auipc	ra,0xffffd
    80005644:	784080e7          	jalr	1924(ra) # 80002dc4 <_Znwm>
    80005648:	00050913          	mv	s2,a0
};


class Semaphore {
        public:
        Semaphore (unsigned init = 1){
    8000564c:	00007797          	auipc	a5,0x7
    80005650:	49478793          	addi	a5,a5,1172 # 8000cae0 <_ZTV9Semaphore+0x10>
    80005654:	00f53023          	sd	a5,0(a0)
            sem_open(&myHandle,init);
    80005658:	00000593          	li	a1,0
    8000565c:	00850513          	addi	a0,a0,8
    80005660:	ffffc097          	auipc	ra,0xffffc
    80005664:	ddc080e7          	jalr	-548(ra) # 8000143c <_Z8sem_openPP5sem_sj>
    80005668:	0000b797          	auipc	a5,0xb
    8000566c:	b327b823          	sd	s2,-1232(a5) # 80010198 <_ZL10waitForAll>
    Thread *producers[threadNum];
    80005670:	00399793          	slli	a5,s3,0x3
    80005674:	00f78793          	addi	a5,a5,15
    80005678:	ff07f793          	andi	a5,a5,-16
    8000567c:	40f10133          	sub	sp,sp,a5
    80005680:	00010a13          	mv	s4,sp
    thread_data threadData[threadNum + 1];
    80005684:	0019871b          	addiw	a4,s3,1
    80005688:	00171793          	slli	a5,a4,0x1
    8000568c:	00e787b3          	add	a5,a5,a4
    80005690:	00379793          	slli	a5,a5,0x3
    80005694:	00f78793          	addi	a5,a5,15
    80005698:	ff07f793          	andi	a5,a5,-16
    8000569c:	40f10133          	sub	sp,sp,a5
    800056a0:	00010b13          	mv	s6,sp
    threadData[threadNum].id = threadNum;
    800056a4:	00199493          	slli	s1,s3,0x1
    800056a8:	013484b3          	add	s1,s1,s3
    800056ac:	00349493          	slli	s1,s1,0x3
    800056b0:	009b04b3          	add	s1,s6,s1
    800056b4:	0134a023          	sw	s3,0(s1)
    threadData[threadNum].buffer = buffer;
    800056b8:	0154b423          	sd	s5,8(s1)
    threadData[threadNum].sem = waitForAll;
    800056bc:	0124b823          	sd	s2,16(s1)
    Thread *consumer = new Consumer(&threadData[threadNum]);
    800056c0:	02800513          	li	a0,40
    800056c4:	ffffd097          	auipc	ra,0xffffd
    800056c8:	700080e7          	jalr	1792(ra) # 80002dc4 <_Znwm>
    800056cc:	00050b93          	mv	s7,a0
            body= nullptr;
    800056d0:	00053823          	sd	zero,16(a0)
            arg= nullptr;
    800056d4:	00053c23          	sd	zero,24(a0)
    Consumer(thread_data *_td) : Thread(), td(_td) {}
    800056d8:	00007797          	auipc	a5,0x7
    800056dc:	47878793          	addi	a5,a5,1144 # 8000cb50 <_ZTV8Consumer+0x10>
    800056e0:	00f53023          	sd	a5,0(a0)
    800056e4:	02953023          	sd	s1,32(a0)
            if(body== nullptr) return thread_create(&myHandle,&threadEntry, this);
    800056e8:	00050613          	mv	a2,a0
    800056ec:	ffffd597          	auipc	a1,0xffffd
    800056f0:	56458593          	addi	a1,a1,1380 # 80002c50 <_ZN6Thread11threadEntryEPv>
    800056f4:	00850513          	addi	a0,a0,8
    800056f8:	ffffc097          	auipc	ra,0xffffc
    800056fc:	c08080e7          	jalr	-1016(ra) # 80001300 <_Z13thread_createPP8thread_sPFvPvES2_>
    threadData[0].id = 0;
    80005700:	000b2023          	sw	zero,0(s6)
    threadData[0].buffer = buffer;
    80005704:	015b3423          	sd	s5,8(s6)
    threadData[0].sem = waitForAll;
    80005708:	0000b797          	auipc	a5,0xb
    8000570c:	a907b783          	ld	a5,-1392(a5) # 80010198 <_ZL10waitForAll>
    80005710:	00fb3823          	sd	a5,16(s6)
    producers[0] = new ProducerKeyborad(&threadData[0]);
    80005714:	02800513          	li	a0,40
    80005718:	ffffd097          	auipc	ra,0xffffd
    8000571c:	6ac080e7          	jalr	1708(ra) # 80002dc4 <_Znwm>
            body= nullptr;
    80005720:	00053823          	sd	zero,16(a0)
            arg= nullptr;
    80005724:	00053c23          	sd	zero,24(a0)
    ProducerKeyborad(thread_data *_td) : Thread(), td(_td) {}
    80005728:	00007797          	auipc	a5,0x7
    8000572c:	3d878793          	addi	a5,a5,984 # 8000cb00 <_ZTV16ProducerKeyborad+0x10>
    80005730:	00f53023          	sd	a5,0(a0)
    80005734:	03653023          	sd	s6,32(a0)
    producers[0] = new ProducerKeyborad(&threadData[0]);
    80005738:	00aa3023          	sd	a0,0(s4)
            if(body== nullptr) return thread_create(&myHandle,&threadEntry, this);
    8000573c:	01053583          	ld	a1,16(a0)
    80005740:	00058e63          	beqz	a1,8000575c <_Z20testConsumerProducerv+0x264>
            else return thread_create(&myHandle,body,arg);
    80005744:	01853603          	ld	a2,24(a0)
    80005748:	00850513          	addi	a0,a0,8
    8000574c:	ffffc097          	auipc	ra,0xffffc
    80005750:	bb4080e7          	jalr	-1100(ra) # 80001300 <_Z13thread_createPP8thread_sPFvPvES2_>
    for (int i = 1; i < threadNum; i++) {
    80005754:	00100913          	li	s2,1
    80005758:	03c0006f          	j	80005794 <_Z20testConsumerProducerv+0x29c>
            if(body== nullptr) return thread_create(&myHandle,&threadEntry, this);
    8000575c:	00050613          	mv	a2,a0
    80005760:	ffffd597          	auipc	a1,0xffffd
    80005764:	4f058593          	addi	a1,a1,1264 # 80002c50 <_ZN6Thread11threadEntryEPv>
    80005768:	00850513          	addi	a0,a0,8
    8000576c:	ffffc097          	auipc	ra,0xffffc
    80005770:	b94080e7          	jalr	-1132(ra) # 80001300 <_Z13thread_createPP8thread_sPFvPvES2_>
    80005774:	fe1ff06f          	j	80005754 <_Z20testConsumerProducerv+0x25c>
    80005778:	00050613          	mv	a2,a0
    8000577c:	ffffd597          	auipc	a1,0xffffd
    80005780:	4d458593          	addi	a1,a1,1236 # 80002c50 <_ZN6Thread11threadEntryEPv>
    80005784:	00850513          	addi	a0,a0,8
    80005788:	ffffc097          	auipc	ra,0xffffc
    8000578c:	b78080e7          	jalr	-1160(ra) # 80001300 <_Z13thread_createPP8thread_sPFvPvES2_>
    80005790:	0019091b          	addiw	s2,s2,1
    80005794:	07395a63          	bge	s2,s3,80005808 <_Z20testConsumerProducerv+0x310>
        threadData[i].id = i;
    80005798:	00191493          	slli	s1,s2,0x1
    8000579c:	012484b3          	add	s1,s1,s2
    800057a0:	00349493          	slli	s1,s1,0x3
    800057a4:	009b04b3          	add	s1,s6,s1
    800057a8:	0124a023          	sw	s2,0(s1)
        threadData[i].buffer = buffer;
    800057ac:	0154b423          	sd	s5,8(s1)
        threadData[i].sem = waitForAll;
    800057b0:	0000b797          	auipc	a5,0xb
    800057b4:	9e87b783          	ld	a5,-1560(a5) # 80010198 <_ZL10waitForAll>
    800057b8:	00f4b823          	sd	a5,16(s1)
        producers[i] = new Producer(&threadData[i]);
    800057bc:	02800513          	li	a0,40
    800057c0:	ffffd097          	auipc	ra,0xffffd
    800057c4:	604080e7          	jalr	1540(ra) # 80002dc4 <_Znwm>
            body= nullptr;
    800057c8:	00053823          	sd	zero,16(a0)
            arg= nullptr;
    800057cc:	00053c23          	sd	zero,24(a0)
    Producer(thread_data *_td) : Thread(), td(_td) {}
    800057d0:	00007797          	auipc	a5,0x7
    800057d4:	35878793          	addi	a5,a5,856 # 8000cb28 <_ZTV8Producer+0x10>
    800057d8:	00f53023          	sd	a5,0(a0)
    800057dc:	02953023          	sd	s1,32(a0)
        producers[i] = new Producer(&threadData[i]);
    800057e0:	00391793          	slli	a5,s2,0x3
    800057e4:	00fa07b3          	add	a5,s4,a5
    800057e8:	00a7b023          	sd	a0,0(a5)
            if(body== nullptr) return thread_create(&myHandle,&threadEntry, this);
    800057ec:	01053583          	ld	a1,16(a0)
    800057f0:	f80584e3          	beqz	a1,80005778 <_Z20testConsumerProducerv+0x280>
            else return thread_create(&myHandle,body,arg);
    800057f4:	01853603          	ld	a2,24(a0)
    800057f8:	00850513          	addi	a0,a0,8
    800057fc:	ffffc097          	auipc	ra,0xffffc
    80005800:	b04080e7          	jalr	-1276(ra) # 80001300 <_Z13thread_createPP8thread_sPFvPvES2_>
    80005804:	f8dff06f          	j	80005790 <_Z20testConsumerProducerv+0x298>
            thread_dispatch();
    80005808:	ffffc097          	auipc	ra,0xffffc
    8000580c:	b80080e7          	jalr	-1152(ra) # 80001388 <_Z15thread_dispatchv>
    for (int i = 0; i <= threadNum; i++) {
    80005810:	00000493          	li	s1,0
    80005814:	0299c063          	blt	s3,s1,80005834 <_Z20testConsumerProducerv+0x33c>
        }
        virtual ~Semaphore (){
            sem_close(myHandle);
        }
        int wait (){
            return sem_wait(myHandle);
    80005818:	0000b797          	auipc	a5,0xb
    8000581c:	9807b783          	ld	a5,-1664(a5) # 80010198 <_ZL10waitForAll>
    80005820:	0087b503          	ld	a0,8(a5)
    80005824:	ffffc097          	auipc	ra,0xffffc
    80005828:	c9c080e7          	jalr	-868(ra) # 800014c0 <_Z8sem_waitP5sem_s>
    8000582c:	0014849b          	addiw	s1,s1,1
    80005830:	fe5ff06f          	j	80005814 <_Z20testConsumerProducerv+0x31c>
    delete waitForAll;
    80005834:	0000b517          	auipc	a0,0xb
    80005838:	96453503          	ld	a0,-1692(a0) # 80010198 <_ZL10waitForAll>
    8000583c:	00050863          	beqz	a0,8000584c <_Z20testConsumerProducerv+0x354>
    80005840:	00053783          	ld	a5,0(a0)
    80005844:	0087b783          	ld	a5,8(a5)
    80005848:	000780e7          	jalr	a5
    for (int i = 0; i <= threadNum; i++) {
    8000584c:	00000493          	li	s1,0
    80005850:	0080006f          	j	80005858 <_Z20testConsumerProducerv+0x360>
    for (int i = 0; i < threadNum; i++) {
    80005854:	0014849b          	addiw	s1,s1,1
    80005858:	0334d263          	bge	s1,s3,8000587c <_Z20testConsumerProducerv+0x384>
        delete producers[i];
    8000585c:	00349793          	slli	a5,s1,0x3
    80005860:	00fa07b3          	add	a5,s4,a5
    80005864:	0007b503          	ld	a0,0(a5)
    80005868:	fe0506e3          	beqz	a0,80005854 <_Z20testConsumerProducerv+0x35c>
    8000586c:	00053783          	ld	a5,0(a0)
    80005870:	0087b783          	ld	a5,8(a5)
    80005874:	000780e7          	jalr	a5
    80005878:	fddff06f          	j	80005854 <_Z20testConsumerProducerv+0x35c>
    delete consumer;
    8000587c:	000b8a63          	beqz	s7,80005890 <_Z20testConsumerProducerv+0x398>
    80005880:	000bb783          	ld	a5,0(s7)
    80005884:	0087b783          	ld	a5,8(a5)
    80005888:	000b8513          	mv	a0,s7
    8000588c:	000780e7          	jalr	a5
    delete buffer;
    80005890:	000a8e63          	beqz	s5,800058ac <_Z20testConsumerProducerv+0x3b4>
    80005894:	000a8513          	mv	a0,s5
    80005898:	00001097          	auipc	ra,0x1
    8000589c:	4bc080e7          	jalr	1212(ra) # 80006d54 <_ZN9BufferCPPD1Ev>
    800058a0:	000a8513          	mv	a0,s5
    800058a4:	ffffd097          	auipc	ra,0xffffd
    800058a8:	548080e7          	jalr	1352(ra) # 80002dec <_ZdlPv>
    800058ac:	000c0113          	mv	sp,s8
}
    800058b0:	f9040113          	addi	sp,s0,-112
    800058b4:	06813083          	ld	ra,104(sp)
    800058b8:	06013403          	ld	s0,96(sp)
    800058bc:	05813483          	ld	s1,88(sp)
    800058c0:	05013903          	ld	s2,80(sp)
    800058c4:	04813983          	ld	s3,72(sp)
    800058c8:	04013a03          	ld	s4,64(sp)
    800058cc:	03813a83          	ld	s5,56(sp)
    800058d0:	03013b03          	ld	s6,48(sp)
    800058d4:	02813b83          	ld	s7,40(sp)
    800058d8:	02013c03          	ld	s8,32(sp)
    800058dc:	07010113          	addi	sp,sp,112
    800058e0:	00008067          	ret
    800058e4:	00050493          	mv	s1,a0
    BufferCPP *buffer = new BufferCPP(n);
    800058e8:	000a8513          	mv	a0,s5
    800058ec:	ffffd097          	auipc	ra,0xffffd
    800058f0:	500080e7          	jalr	1280(ra) # 80002dec <_ZdlPv>
    800058f4:	00048513          	mv	a0,s1
    800058f8:	0000c097          	auipc	ra,0xc
    800058fc:	990080e7          	jalr	-1648(ra) # 80011288 <_Unwind_Resume>
    80005900:	00050493          	mv	s1,a0
    waitForAll = new Semaphore(0);
    80005904:	00090513          	mv	a0,s2
    80005908:	ffffd097          	auipc	ra,0xffffd
    8000590c:	4e4080e7          	jalr	1252(ra) # 80002dec <_ZdlPv>
    80005910:	00048513          	mv	a0,s1
    80005914:	0000c097          	auipc	ra,0xc
    80005918:	974080e7          	jalr	-1676(ra) # 80011288 <_Unwind_Resume>

000000008000591c <_ZN8ConsumerD1Ev>:
class Consumer : public Thread {
    8000591c:	ff010113          	addi	sp,sp,-16
    80005920:	00813423          	sd	s0,8(sp)
    80005924:	01010413          	addi	s0,sp,16
    80005928:	00813403          	ld	s0,8(sp)
    8000592c:	01010113          	addi	sp,sp,16
    80005930:	00008067          	ret

0000000080005934 <_ZN8ProducerD1Ev>:
class Producer : public Thread {
    80005934:	ff010113          	addi	sp,sp,-16
    80005938:	00813423          	sd	s0,8(sp)
    8000593c:	01010413          	addi	s0,sp,16
    80005940:	00813403          	ld	s0,8(sp)
    80005944:	01010113          	addi	sp,sp,16
    80005948:	00008067          	ret

000000008000594c <_ZN16ProducerKeyboradD1Ev>:
class ProducerKeyborad : public Thread {
    8000594c:	ff010113          	addi	sp,sp,-16
    80005950:	00813423          	sd	s0,8(sp)
    80005954:	01010413          	addi	s0,sp,16
    80005958:	00813403          	ld	s0,8(sp)
    8000595c:	01010113          	addi	sp,sp,16
    80005960:	00008067          	ret

0000000080005964 <_ZN8ConsumerD0Ev>:
class Consumer : public Thread {
    80005964:	ff010113          	addi	sp,sp,-16
    80005968:	00113423          	sd	ra,8(sp)
    8000596c:	00813023          	sd	s0,0(sp)
    80005970:	01010413          	addi	s0,sp,16
    80005974:	ffffd097          	auipc	ra,0xffffd
    80005978:	478080e7          	jalr	1144(ra) # 80002dec <_ZdlPv>
    8000597c:	00813083          	ld	ra,8(sp)
    80005980:	00013403          	ld	s0,0(sp)
    80005984:	01010113          	addi	sp,sp,16
    80005988:	00008067          	ret

000000008000598c <_ZN16ProducerKeyboradD0Ev>:
class ProducerKeyborad : public Thread {
    8000598c:	ff010113          	addi	sp,sp,-16
    80005990:	00113423          	sd	ra,8(sp)
    80005994:	00813023          	sd	s0,0(sp)
    80005998:	01010413          	addi	s0,sp,16
    8000599c:	ffffd097          	auipc	ra,0xffffd
    800059a0:	450080e7          	jalr	1104(ra) # 80002dec <_ZdlPv>
    800059a4:	00813083          	ld	ra,8(sp)
    800059a8:	00013403          	ld	s0,0(sp)
    800059ac:	01010113          	addi	sp,sp,16
    800059b0:	00008067          	ret

00000000800059b4 <_ZN8ProducerD0Ev>:
class Producer : public Thread {
    800059b4:	ff010113          	addi	sp,sp,-16
    800059b8:	00113423          	sd	ra,8(sp)
    800059bc:	00813023          	sd	s0,0(sp)
    800059c0:	01010413          	addi	s0,sp,16
    800059c4:	ffffd097          	auipc	ra,0xffffd
    800059c8:	428080e7          	jalr	1064(ra) # 80002dec <_ZdlPv>
    800059cc:	00813083          	ld	ra,8(sp)
    800059d0:	00013403          	ld	s0,0(sp)
    800059d4:	01010113          	addi	sp,sp,16
    800059d8:	00008067          	ret

00000000800059dc <_ZN9SemaphoreD1Ev>:
        virtual ~Semaphore (){
    800059dc:	ff010113          	addi	sp,sp,-16
    800059e0:	00113423          	sd	ra,8(sp)
    800059e4:	00813023          	sd	s0,0(sp)
    800059e8:	01010413          	addi	s0,sp,16
    800059ec:	00007797          	auipc	a5,0x7
    800059f0:	0f478793          	addi	a5,a5,244 # 8000cae0 <_ZTV9Semaphore+0x10>
    800059f4:	00f53023          	sd	a5,0(a0)
            sem_close(myHandle);
    800059f8:	00853503          	ld	a0,8(a0)
    800059fc:	ffffc097          	auipc	ra,0xffffc
    80005a00:	a84080e7          	jalr	-1404(ra) # 80001480 <_Z9sem_closeP5sem_s>
        }
    80005a04:	00813083          	ld	ra,8(sp)
    80005a08:	00013403          	ld	s0,0(sp)
    80005a0c:	01010113          	addi	sp,sp,16
    80005a10:	00008067          	ret

0000000080005a14 <_ZN9SemaphoreD0Ev>:
        virtual ~Semaphore (){
    80005a14:	fe010113          	addi	sp,sp,-32
    80005a18:	00113c23          	sd	ra,24(sp)
    80005a1c:	00813823          	sd	s0,16(sp)
    80005a20:	00913423          	sd	s1,8(sp)
    80005a24:	02010413          	addi	s0,sp,32
    80005a28:	00050493          	mv	s1,a0
    80005a2c:	00007797          	auipc	a5,0x7
    80005a30:	0b478793          	addi	a5,a5,180 # 8000cae0 <_ZTV9Semaphore+0x10>
    80005a34:	00f53023          	sd	a5,0(a0)
            sem_close(myHandle);
    80005a38:	00853503          	ld	a0,8(a0)
    80005a3c:	ffffc097          	auipc	ra,0xffffc
    80005a40:	a44080e7          	jalr	-1468(ra) # 80001480 <_Z9sem_closeP5sem_s>
        }
    80005a44:	00048513          	mv	a0,s1
    80005a48:	ffffd097          	auipc	ra,0xffffd
    80005a4c:	3a4080e7          	jalr	932(ra) # 80002dec <_ZdlPv>
    80005a50:	01813083          	ld	ra,24(sp)
    80005a54:	01013403          	ld	s0,16(sp)
    80005a58:	00813483          	ld	s1,8(sp)
    80005a5c:	02010113          	addi	sp,sp,32
    80005a60:	00008067          	ret

0000000080005a64 <_ZN8Consumer3runEv>:
    void run() override {
    80005a64:	fd010113          	addi	sp,sp,-48
    80005a68:	02113423          	sd	ra,40(sp)
    80005a6c:	02813023          	sd	s0,32(sp)
    80005a70:	00913c23          	sd	s1,24(sp)
    80005a74:	01213823          	sd	s2,16(sp)
    80005a78:	01313423          	sd	s3,8(sp)
    80005a7c:	03010413          	addi	s0,sp,48
    80005a80:	00050913          	mv	s2,a0
        int i = 0;
    80005a84:	00000993          	li	s3,0
    80005a88:	0100006f          	j	80005a98 <_ZN8Consumer3runEv+0x34>
        public:
        static char getc (){
            return ::getc();
        }
        static void putc (char c){
            ::putc(c);
    80005a8c:	00a00513          	li	a0,10
    80005a90:	ffffc097          	auipc	ra,0xffffc
    80005a94:	b20080e7          	jalr	-1248(ra) # 800015b0 <_Z4putcc>
        while (!threadEnd) {
    80005a98:	0000a797          	auipc	a5,0xa
    80005a9c:	6f87a783          	lw	a5,1784(a5) # 80010190 <_ZL9threadEnd>
    80005aa0:	04079a63          	bnez	a5,80005af4 <_ZN8Consumer3runEv+0x90>
            int key = td->buffer->get();
    80005aa4:	02093783          	ld	a5,32(s2)
    80005aa8:	0087b503          	ld	a0,8(a5)
    80005aac:	00001097          	auipc	ra,0x1
    80005ab0:	174080e7          	jalr	372(ra) # 80006c20 <_ZN9BufferCPP3getEv>
            i++;
    80005ab4:	0019849b          	addiw	s1,s3,1
    80005ab8:	0004899b          	sext.w	s3,s1
    80005abc:	0ff57513          	andi	a0,a0,255
    80005ac0:	ffffc097          	auipc	ra,0xffffc
    80005ac4:	af0080e7          	jalr	-1296(ra) # 800015b0 <_Z4putcc>
            if (i % 80 == 0) {
    80005ac8:	05000793          	li	a5,80
    80005acc:	02f4e4bb          	remw	s1,s1,a5
    80005ad0:	fc0494e3          	bnez	s1,80005a98 <_ZN8Consumer3runEv+0x34>
    80005ad4:	fb9ff06f          	j	80005a8c <_ZN8Consumer3runEv+0x28>
            int key = td->buffer->get();
    80005ad8:	02093783          	ld	a5,32(s2)
    80005adc:	0087b503          	ld	a0,8(a5)
    80005ae0:	00001097          	auipc	ra,0x1
    80005ae4:	140080e7          	jalr	320(ra) # 80006c20 <_ZN9BufferCPP3getEv>
    80005ae8:	0ff57513          	andi	a0,a0,255
    80005aec:	ffffc097          	auipc	ra,0xffffc
    80005af0:	ac4080e7          	jalr	-1340(ra) # 800015b0 <_Z4putcc>
        while (td->buffer->getCnt() > 0) {
    80005af4:	02093783          	ld	a5,32(s2)
    80005af8:	0087b503          	ld	a0,8(a5)
    80005afc:	00001097          	auipc	ra,0x1
    80005b00:	1c0080e7          	jalr	448(ra) # 80006cbc <_ZN9BufferCPP6getCntEv>
    80005b04:	fca04ae3          	bgtz	a0,80005ad8 <_ZN8Consumer3runEv+0x74>
        td->sem->signal();
    80005b08:	02093783          	ld	a5,32(s2)
    80005b0c:	0107b783          	ld	a5,16(a5)
            return sem_signal(myHandle);
    80005b10:	0087b503          	ld	a0,8(a5)
    80005b14:	ffffc097          	auipc	ra,0xffffc
    80005b18:	9ec080e7          	jalr	-1556(ra) # 80001500 <_Z10sem_signalP5sem_s>
    }
    80005b1c:	02813083          	ld	ra,40(sp)
    80005b20:	02013403          	ld	s0,32(sp)
    80005b24:	01813483          	ld	s1,24(sp)
    80005b28:	01013903          	ld	s2,16(sp)
    80005b2c:	00813983          	ld	s3,8(sp)
    80005b30:	03010113          	addi	sp,sp,48
    80005b34:	00008067          	ret

0000000080005b38 <_ZN16ProducerKeyborad3runEv>:
    void run() override {
    80005b38:	fe010113          	addi	sp,sp,-32
    80005b3c:	00113c23          	sd	ra,24(sp)
    80005b40:	00813823          	sd	s0,16(sp)
    80005b44:	00913423          	sd	s1,8(sp)
    80005b48:	02010413          	addi	s0,sp,32
    80005b4c:	00050493          	mv	s1,a0
        while ((key = getc()) != 13) {
    80005b50:	ffffc097          	auipc	ra,0xffffc
    80005b54:	a24080e7          	jalr	-1500(ra) # 80001574 <_Z4getcv>
    80005b58:	0005059b          	sext.w	a1,a0
    80005b5c:	00d00793          	li	a5,13
    80005b60:	00f58c63          	beq	a1,a5,80005b78 <_ZN16ProducerKeyborad3runEv+0x40>
            td->buffer->put(key);
    80005b64:	0204b783          	ld	a5,32(s1)
    80005b68:	0087b503          	ld	a0,8(a5)
    80005b6c:	00001097          	auipc	ra,0x1
    80005b70:	014080e7          	jalr	20(ra) # 80006b80 <_ZN9BufferCPP3putEi>
        while ((key = getc()) != 13) {
    80005b74:	fddff06f          	j	80005b50 <_ZN16ProducerKeyborad3runEv+0x18>
        threadEnd = 1;
    80005b78:	00100793          	li	a5,1
    80005b7c:	0000a717          	auipc	a4,0xa
    80005b80:	60f72a23          	sw	a5,1556(a4) # 80010190 <_ZL9threadEnd>
        td->buffer->put('!');
    80005b84:	0204b783          	ld	a5,32(s1)
    80005b88:	02100593          	li	a1,33
    80005b8c:	0087b503          	ld	a0,8(a5)
    80005b90:	00001097          	auipc	ra,0x1
    80005b94:	ff0080e7          	jalr	-16(ra) # 80006b80 <_ZN9BufferCPP3putEi>
        td->sem->signal();
    80005b98:	0204b783          	ld	a5,32(s1)
    80005b9c:	0107b783          	ld	a5,16(a5)
    80005ba0:	0087b503          	ld	a0,8(a5)
    80005ba4:	ffffc097          	auipc	ra,0xffffc
    80005ba8:	95c080e7          	jalr	-1700(ra) # 80001500 <_Z10sem_signalP5sem_s>
    }
    80005bac:	01813083          	ld	ra,24(sp)
    80005bb0:	01013403          	ld	s0,16(sp)
    80005bb4:	00813483          	ld	s1,8(sp)
    80005bb8:	02010113          	addi	sp,sp,32
    80005bbc:	00008067          	ret

0000000080005bc0 <_ZN8Producer3runEv>:
    void run() override {
    80005bc0:	fe010113          	addi	sp,sp,-32
    80005bc4:	00113c23          	sd	ra,24(sp)
    80005bc8:	00813823          	sd	s0,16(sp)
    80005bcc:	00913423          	sd	s1,8(sp)
    80005bd0:	01213023          	sd	s2,0(sp)
    80005bd4:	02010413          	addi	s0,sp,32
    80005bd8:	00050493          	mv	s1,a0
        int i = 0;
    80005bdc:	00000913          	li	s2,0
        while (!threadEnd) {
    80005be0:	0000a797          	auipc	a5,0xa
    80005be4:	5b07a783          	lw	a5,1456(a5) # 80010190 <_ZL9threadEnd>
    80005be8:	04079263          	bnez	a5,80005c2c <_ZN8Producer3runEv+0x6c>
            td->buffer->put(td->id + '0');
    80005bec:	0204b783          	ld	a5,32(s1)
    80005bf0:	0007a583          	lw	a1,0(a5)
    80005bf4:	0305859b          	addiw	a1,a1,48
    80005bf8:	0087b503          	ld	a0,8(a5)
    80005bfc:	00001097          	auipc	ra,0x1
    80005c00:	f84080e7          	jalr	-124(ra) # 80006b80 <_ZN9BufferCPP3putEi>
            i++;
    80005c04:	0019071b          	addiw	a4,s2,1
    80005c08:	0007091b          	sext.w	s2,a4
            Thread::sleep((i + td->id) % 5);
    80005c0c:	0204b783          	ld	a5,32(s1)
    80005c10:	0007a783          	lw	a5,0(a5)
    80005c14:	00e787bb          	addw	a5,a5,a4
            return time_sleep(time);
    80005c18:	00500513          	li	a0,5
    80005c1c:	02a7e53b          	remw	a0,a5,a0
    80005c20:	ffffc097          	auipc	ra,0xffffc
    80005c24:	920080e7          	jalr	-1760(ra) # 80001540 <_Z10time_sleepm>
    80005c28:	fb9ff06f          	j	80005be0 <_ZN8Producer3runEv+0x20>
        td->sem->signal();
    80005c2c:	0204b783          	ld	a5,32(s1)
    80005c30:	0107b783          	ld	a5,16(a5)
            return sem_signal(myHandle);
    80005c34:	0087b503          	ld	a0,8(a5)
    80005c38:	ffffc097          	auipc	ra,0xffffc
    80005c3c:	8c8080e7          	jalr	-1848(ra) # 80001500 <_Z10sem_signalP5sem_s>
    }
    80005c40:	01813083          	ld	ra,24(sp)
    80005c44:	01013403          	ld	s0,16(sp)
    80005c48:	00813483          	ld	s1,8(sp)
    80005c4c:	00013903          	ld	s2,0(sp)
    80005c50:	02010113          	addi	sp,sp,32
    80005c54:	00008067          	ret

0000000080005c58 <_ZL9fibonaccim>:
static volatile bool finishedA = false;
static volatile bool finishedB = false;
static volatile bool finishedC = false;
static volatile bool finishedD = false;

static uint64 fibonacci(uint64 n) {
    80005c58:	fe010113          	addi	sp,sp,-32
    80005c5c:	00113c23          	sd	ra,24(sp)
    80005c60:	00813823          	sd	s0,16(sp)
    80005c64:	00913423          	sd	s1,8(sp)
    80005c68:	01213023          	sd	s2,0(sp)
    80005c6c:	02010413          	addi	s0,sp,32
    80005c70:	00050493          	mv	s1,a0
    if (n == 0 || n == 1) { return n; }
    80005c74:	00100793          	li	a5,1
    80005c78:	02a7f863          	bgeu	a5,a0,80005ca8 <_ZL9fibonaccim+0x50>
    if (n % 10 == 0) { thread_dispatch(); }
    80005c7c:	00a00793          	li	a5,10
    80005c80:	02f577b3          	remu	a5,a0,a5
    80005c84:	02078e63          	beqz	a5,80005cc0 <_ZL9fibonaccim+0x68>
    return fibonacci(n - 1) + fibonacci(n - 2);
    80005c88:	fff48513          	addi	a0,s1,-1
    80005c8c:	00000097          	auipc	ra,0x0
    80005c90:	fcc080e7          	jalr	-52(ra) # 80005c58 <_ZL9fibonaccim>
    80005c94:	00050913          	mv	s2,a0
    80005c98:	ffe48513          	addi	a0,s1,-2
    80005c9c:	00000097          	auipc	ra,0x0
    80005ca0:	fbc080e7          	jalr	-68(ra) # 80005c58 <_ZL9fibonaccim>
    80005ca4:	00a90533          	add	a0,s2,a0
}
    80005ca8:	01813083          	ld	ra,24(sp)
    80005cac:	01013403          	ld	s0,16(sp)
    80005cb0:	00813483          	ld	s1,8(sp)
    80005cb4:	00013903          	ld	s2,0(sp)
    80005cb8:	02010113          	addi	sp,sp,32
    80005cbc:	00008067          	ret
    if (n % 10 == 0) { thread_dispatch(); }
    80005cc0:	ffffb097          	auipc	ra,0xffffb
    80005cc4:	6c8080e7          	jalr	1736(ra) # 80001388 <_Z15thread_dispatchv>
    80005cc8:	fc1ff06f          	j	80005c88 <_ZL9fibonaccim+0x30>

0000000080005ccc <_ZL11workerBodyDPv>:
    printString("A finished!\n");
    finishedC = true;
    thread_dispatch();
}

static void workerBodyD(void* arg) {
    80005ccc:	fe010113          	addi	sp,sp,-32
    80005cd0:	00113c23          	sd	ra,24(sp)
    80005cd4:	00813823          	sd	s0,16(sp)
    80005cd8:	00913423          	sd	s1,8(sp)
    80005cdc:	01213023          	sd	s2,0(sp)
    80005ce0:	02010413          	addi	s0,sp,32
    uint8 i = 10;
    80005ce4:	00a00493          	li	s1,10
    80005ce8:	0400006f          	j	80005d28 <_ZL11workerBodyDPv+0x5c>
    for (; i < 13; i++) {
        printString("D: i="); printInt(i); printString("\n");
    80005cec:	00005517          	auipc	a0,0x5
    80005cf0:	85450513          	addi	a0,a0,-1964 # 8000a540 <CONSOLE_STATUS+0x530>
    80005cf4:	ffffc097          	auipc	ra,0xffffc
    80005cf8:	20c080e7          	jalr	524(ra) # 80001f00 <_Z11printStringPKc>
    80005cfc:	00000613          	li	a2,0
    80005d00:	00a00593          	li	a1,10
    80005d04:	00048513          	mv	a0,s1
    80005d08:	ffffc097          	auipc	ra,0xffffc
    80005d0c:	3a8080e7          	jalr	936(ra) # 800020b0 <_Z8printIntiii>
    80005d10:	00005517          	auipc	a0,0x5
    80005d14:	a2050513          	addi	a0,a0,-1504 # 8000a730 <CONSOLE_STATUS+0x720>
    80005d18:	ffffc097          	auipc	ra,0xffffc
    80005d1c:	1e8080e7          	jalr	488(ra) # 80001f00 <_Z11printStringPKc>
    for (; i < 13; i++) {
    80005d20:	0014849b          	addiw	s1,s1,1
    80005d24:	0ff4f493          	andi	s1,s1,255
    80005d28:	00c00793          	li	a5,12
    80005d2c:	fc97f0e3          	bgeu	a5,s1,80005cec <_ZL11workerBodyDPv+0x20>
    }

    printString("D: dispatch\n");
    80005d30:	00005517          	auipc	a0,0x5
    80005d34:	81850513          	addi	a0,a0,-2024 # 8000a548 <CONSOLE_STATUS+0x538>
    80005d38:	ffffc097          	auipc	ra,0xffffc
    80005d3c:	1c8080e7          	jalr	456(ra) # 80001f00 <_Z11printStringPKc>
    __asm__ ("li t1, 5");
    80005d40:	00500313          	li	t1,5
    thread_dispatch();
    80005d44:	ffffb097          	auipc	ra,0xffffb
    80005d48:	644080e7          	jalr	1604(ra) # 80001388 <_Z15thread_dispatchv>

    uint64 result = fibonacci(16);
    80005d4c:	01000513          	li	a0,16
    80005d50:	00000097          	auipc	ra,0x0
    80005d54:	f08080e7          	jalr	-248(ra) # 80005c58 <_ZL9fibonaccim>
    80005d58:	00050913          	mv	s2,a0
    printString("D: fibonaci="); printInt(result); printString("\n");
    80005d5c:	00004517          	auipc	a0,0x4
    80005d60:	7fc50513          	addi	a0,a0,2044 # 8000a558 <CONSOLE_STATUS+0x548>
    80005d64:	ffffc097          	auipc	ra,0xffffc
    80005d68:	19c080e7          	jalr	412(ra) # 80001f00 <_Z11printStringPKc>
    80005d6c:	00000613          	li	a2,0
    80005d70:	00a00593          	li	a1,10
    80005d74:	0009051b          	sext.w	a0,s2
    80005d78:	ffffc097          	auipc	ra,0xffffc
    80005d7c:	338080e7          	jalr	824(ra) # 800020b0 <_Z8printIntiii>
    80005d80:	00005517          	auipc	a0,0x5
    80005d84:	9b050513          	addi	a0,a0,-1616 # 8000a730 <CONSOLE_STATUS+0x720>
    80005d88:	ffffc097          	auipc	ra,0xffffc
    80005d8c:	178080e7          	jalr	376(ra) # 80001f00 <_Z11printStringPKc>
    80005d90:	0400006f          	j	80005dd0 <_ZL11workerBodyDPv+0x104>

    for (; i < 16; i++) {
        printString("D: i="); printInt(i); printString("\n");
    80005d94:	00004517          	auipc	a0,0x4
    80005d98:	7ac50513          	addi	a0,a0,1964 # 8000a540 <CONSOLE_STATUS+0x530>
    80005d9c:	ffffc097          	auipc	ra,0xffffc
    80005da0:	164080e7          	jalr	356(ra) # 80001f00 <_Z11printStringPKc>
    80005da4:	00000613          	li	a2,0
    80005da8:	00a00593          	li	a1,10
    80005dac:	00048513          	mv	a0,s1
    80005db0:	ffffc097          	auipc	ra,0xffffc
    80005db4:	300080e7          	jalr	768(ra) # 800020b0 <_Z8printIntiii>
    80005db8:	00005517          	auipc	a0,0x5
    80005dbc:	97850513          	addi	a0,a0,-1672 # 8000a730 <CONSOLE_STATUS+0x720>
    80005dc0:	ffffc097          	auipc	ra,0xffffc
    80005dc4:	140080e7          	jalr	320(ra) # 80001f00 <_Z11printStringPKc>
    for (; i < 16; i++) {
    80005dc8:	0014849b          	addiw	s1,s1,1
    80005dcc:	0ff4f493          	andi	s1,s1,255
    80005dd0:	00f00793          	li	a5,15
    80005dd4:	fc97f0e3          	bgeu	a5,s1,80005d94 <_ZL11workerBodyDPv+0xc8>
    }

    printString("D finished!\n");
    80005dd8:	00004517          	auipc	a0,0x4
    80005ddc:	79050513          	addi	a0,a0,1936 # 8000a568 <CONSOLE_STATUS+0x558>
    80005de0:	ffffc097          	auipc	ra,0xffffc
    80005de4:	120080e7          	jalr	288(ra) # 80001f00 <_Z11printStringPKc>
    finishedD = true;
    80005de8:	00100793          	li	a5,1
    80005dec:	0000a717          	auipc	a4,0xa
    80005df0:	3af70a23          	sb	a5,948(a4) # 800101a0 <_ZL9finishedD>
    thread_dispatch();
    80005df4:	ffffb097          	auipc	ra,0xffffb
    80005df8:	594080e7          	jalr	1428(ra) # 80001388 <_Z15thread_dispatchv>
}
    80005dfc:	01813083          	ld	ra,24(sp)
    80005e00:	01013403          	ld	s0,16(sp)
    80005e04:	00813483          	ld	s1,8(sp)
    80005e08:	00013903          	ld	s2,0(sp)
    80005e0c:	02010113          	addi	sp,sp,32
    80005e10:	00008067          	ret

0000000080005e14 <_ZL11workerBodyCPv>:
static void workerBodyC(void* arg) {
    80005e14:	fe010113          	addi	sp,sp,-32
    80005e18:	00113c23          	sd	ra,24(sp)
    80005e1c:	00813823          	sd	s0,16(sp)
    80005e20:	00913423          	sd	s1,8(sp)
    80005e24:	01213023          	sd	s2,0(sp)
    80005e28:	02010413          	addi	s0,sp,32
    uint8 i = 0;
    80005e2c:	00000493          	li	s1,0
    80005e30:	0400006f          	j	80005e70 <_ZL11workerBodyCPv+0x5c>
        printString("C: i="); printInt(i); printString("\n");
    80005e34:	00004517          	auipc	a0,0x4
    80005e38:	6dc50513          	addi	a0,a0,1756 # 8000a510 <CONSOLE_STATUS+0x500>
    80005e3c:	ffffc097          	auipc	ra,0xffffc
    80005e40:	0c4080e7          	jalr	196(ra) # 80001f00 <_Z11printStringPKc>
    80005e44:	00000613          	li	a2,0
    80005e48:	00a00593          	li	a1,10
    80005e4c:	00048513          	mv	a0,s1
    80005e50:	ffffc097          	auipc	ra,0xffffc
    80005e54:	260080e7          	jalr	608(ra) # 800020b0 <_Z8printIntiii>
    80005e58:	00005517          	auipc	a0,0x5
    80005e5c:	8d850513          	addi	a0,a0,-1832 # 8000a730 <CONSOLE_STATUS+0x720>
    80005e60:	ffffc097          	auipc	ra,0xffffc
    80005e64:	0a0080e7          	jalr	160(ra) # 80001f00 <_Z11printStringPKc>
    for (; i < 3; i++) {
    80005e68:	0014849b          	addiw	s1,s1,1
    80005e6c:	0ff4f493          	andi	s1,s1,255
    80005e70:	00200793          	li	a5,2
    80005e74:	fc97f0e3          	bgeu	a5,s1,80005e34 <_ZL11workerBodyCPv+0x20>
    printString("C: dispatch\n");
    80005e78:	00004517          	auipc	a0,0x4
    80005e7c:	6a050513          	addi	a0,a0,1696 # 8000a518 <CONSOLE_STATUS+0x508>
    80005e80:	ffffc097          	auipc	ra,0xffffc
    80005e84:	080080e7          	jalr	128(ra) # 80001f00 <_Z11printStringPKc>
    __asm__ ("li t1, 7");
    80005e88:	00700313          	li	t1,7
    thread_dispatch();
    80005e8c:	ffffb097          	auipc	ra,0xffffb
    80005e90:	4fc080e7          	jalr	1276(ra) # 80001388 <_Z15thread_dispatchv>
    __asm__ ("mv %[t1], t1" : [t1] "=r"(t1));
    80005e94:	00030913          	mv	s2,t1
    printString("C: t1="); printInt(t1); printString("\n");
    80005e98:	00004517          	auipc	a0,0x4
    80005e9c:	69050513          	addi	a0,a0,1680 # 8000a528 <CONSOLE_STATUS+0x518>
    80005ea0:	ffffc097          	auipc	ra,0xffffc
    80005ea4:	060080e7          	jalr	96(ra) # 80001f00 <_Z11printStringPKc>
    80005ea8:	00000613          	li	a2,0
    80005eac:	00a00593          	li	a1,10
    80005eb0:	0009051b          	sext.w	a0,s2
    80005eb4:	ffffc097          	auipc	ra,0xffffc
    80005eb8:	1fc080e7          	jalr	508(ra) # 800020b0 <_Z8printIntiii>
    80005ebc:	00005517          	auipc	a0,0x5
    80005ec0:	87450513          	addi	a0,a0,-1932 # 8000a730 <CONSOLE_STATUS+0x720>
    80005ec4:	ffffc097          	auipc	ra,0xffffc
    80005ec8:	03c080e7          	jalr	60(ra) # 80001f00 <_Z11printStringPKc>
    uint64 result = fibonacci(12);
    80005ecc:	00c00513          	li	a0,12
    80005ed0:	00000097          	auipc	ra,0x0
    80005ed4:	d88080e7          	jalr	-632(ra) # 80005c58 <_ZL9fibonaccim>
    80005ed8:	00050913          	mv	s2,a0
    printString("C: fibonaci="); printInt(result); printString("\n");
    80005edc:	00004517          	auipc	a0,0x4
    80005ee0:	65450513          	addi	a0,a0,1620 # 8000a530 <CONSOLE_STATUS+0x520>
    80005ee4:	ffffc097          	auipc	ra,0xffffc
    80005ee8:	01c080e7          	jalr	28(ra) # 80001f00 <_Z11printStringPKc>
    80005eec:	00000613          	li	a2,0
    80005ef0:	00a00593          	li	a1,10
    80005ef4:	0009051b          	sext.w	a0,s2
    80005ef8:	ffffc097          	auipc	ra,0xffffc
    80005efc:	1b8080e7          	jalr	440(ra) # 800020b0 <_Z8printIntiii>
    80005f00:	00005517          	auipc	a0,0x5
    80005f04:	83050513          	addi	a0,a0,-2000 # 8000a730 <CONSOLE_STATUS+0x720>
    80005f08:	ffffc097          	auipc	ra,0xffffc
    80005f0c:	ff8080e7          	jalr	-8(ra) # 80001f00 <_Z11printStringPKc>
    80005f10:	0400006f          	j	80005f50 <_ZL11workerBodyCPv+0x13c>
        printString("C: i="); printInt(i); printString("\n");
    80005f14:	00004517          	auipc	a0,0x4
    80005f18:	5fc50513          	addi	a0,a0,1532 # 8000a510 <CONSOLE_STATUS+0x500>
    80005f1c:	ffffc097          	auipc	ra,0xffffc
    80005f20:	fe4080e7          	jalr	-28(ra) # 80001f00 <_Z11printStringPKc>
    80005f24:	00000613          	li	a2,0
    80005f28:	00a00593          	li	a1,10
    80005f2c:	00048513          	mv	a0,s1
    80005f30:	ffffc097          	auipc	ra,0xffffc
    80005f34:	180080e7          	jalr	384(ra) # 800020b0 <_Z8printIntiii>
    80005f38:	00004517          	auipc	a0,0x4
    80005f3c:	7f850513          	addi	a0,a0,2040 # 8000a730 <CONSOLE_STATUS+0x720>
    80005f40:	ffffc097          	auipc	ra,0xffffc
    80005f44:	fc0080e7          	jalr	-64(ra) # 80001f00 <_Z11printStringPKc>
    for (; i < 6; i++) {
    80005f48:	0014849b          	addiw	s1,s1,1
    80005f4c:	0ff4f493          	andi	s1,s1,255
    80005f50:	00500793          	li	a5,5
    80005f54:	fc97f0e3          	bgeu	a5,s1,80005f14 <_ZL11workerBodyCPv+0x100>
    printString("A finished!\n");
    80005f58:	00004517          	auipc	a0,0x4
    80005f5c:	59050513          	addi	a0,a0,1424 # 8000a4e8 <CONSOLE_STATUS+0x4d8>
    80005f60:	ffffc097          	auipc	ra,0xffffc
    80005f64:	fa0080e7          	jalr	-96(ra) # 80001f00 <_Z11printStringPKc>
    finishedC = true;
    80005f68:	00100793          	li	a5,1
    80005f6c:	0000a717          	auipc	a4,0xa
    80005f70:	22f70aa3          	sb	a5,565(a4) # 800101a1 <_ZL9finishedC>
    thread_dispatch();
    80005f74:	ffffb097          	auipc	ra,0xffffb
    80005f78:	414080e7          	jalr	1044(ra) # 80001388 <_Z15thread_dispatchv>
}
    80005f7c:	01813083          	ld	ra,24(sp)
    80005f80:	01013403          	ld	s0,16(sp)
    80005f84:	00813483          	ld	s1,8(sp)
    80005f88:	00013903          	ld	s2,0(sp)
    80005f8c:	02010113          	addi	sp,sp,32
    80005f90:	00008067          	ret

0000000080005f94 <_ZL11workerBodyBPv>:
static void workerBodyB(void* arg) {
    80005f94:	fe010113          	addi	sp,sp,-32
    80005f98:	00113c23          	sd	ra,24(sp)
    80005f9c:	00813823          	sd	s0,16(sp)
    80005fa0:	00913423          	sd	s1,8(sp)
    80005fa4:	01213023          	sd	s2,0(sp)
    80005fa8:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 16; i++) {
    80005fac:	00000913          	li	s2,0
    80005fb0:	0380006f          	j	80005fe8 <_ZL11workerBodyBPv+0x54>
            thread_dispatch();
    80005fb4:	ffffb097          	auipc	ra,0xffffb
    80005fb8:	3d4080e7          	jalr	980(ra) # 80001388 <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++) {
    80005fbc:	00148493          	addi	s1,s1,1
    80005fc0:	000027b7          	lui	a5,0x2
    80005fc4:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    80005fc8:	0097ee63          	bltu	a5,s1,80005fe4 <_ZL11workerBodyBPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    80005fcc:	00000713          	li	a4,0
    80005fd0:	000077b7          	lui	a5,0x7
    80005fd4:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    80005fd8:	fce7eee3          	bltu	a5,a4,80005fb4 <_ZL11workerBodyBPv+0x20>
    80005fdc:	00170713          	addi	a4,a4,1
    80005fe0:	ff1ff06f          	j	80005fd0 <_ZL11workerBodyBPv+0x3c>
    for (uint64 i = 0; i < 16; i++) {
    80005fe4:	00190913          	addi	s2,s2,1
    80005fe8:	00f00793          	li	a5,15
    80005fec:	0527e063          	bltu	a5,s2,8000602c <_ZL11workerBodyBPv+0x98>
        printString("B: i="); printInt(i); printString("\n");
    80005ff0:	00004517          	auipc	a0,0x4
    80005ff4:	50850513          	addi	a0,a0,1288 # 8000a4f8 <CONSOLE_STATUS+0x4e8>
    80005ff8:	ffffc097          	auipc	ra,0xffffc
    80005ffc:	f08080e7          	jalr	-248(ra) # 80001f00 <_Z11printStringPKc>
    80006000:	00000613          	li	a2,0
    80006004:	00a00593          	li	a1,10
    80006008:	0009051b          	sext.w	a0,s2
    8000600c:	ffffc097          	auipc	ra,0xffffc
    80006010:	0a4080e7          	jalr	164(ra) # 800020b0 <_Z8printIntiii>
    80006014:	00004517          	auipc	a0,0x4
    80006018:	71c50513          	addi	a0,a0,1820 # 8000a730 <CONSOLE_STATUS+0x720>
    8000601c:	ffffc097          	auipc	ra,0xffffc
    80006020:	ee4080e7          	jalr	-284(ra) # 80001f00 <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    80006024:	00000493          	li	s1,0
    80006028:	f99ff06f          	j	80005fc0 <_ZL11workerBodyBPv+0x2c>
    printString("B finished!\n");
    8000602c:	00004517          	auipc	a0,0x4
    80006030:	4d450513          	addi	a0,a0,1236 # 8000a500 <CONSOLE_STATUS+0x4f0>
    80006034:	ffffc097          	auipc	ra,0xffffc
    80006038:	ecc080e7          	jalr	-308(ra) # 80001f00 <_Z11printStringPKc>
    finishedB = true;
    8000603c:	00100793          	li	a5,1
    80006040:	0000a717          	auipc	a4,0xa
    80006044:	16f70123          	sb	a5,354(a4) # 800101a2 <_ZL9finishedB>
    thread_dispatch();
    80006048:	ffffb097          	auipc	ra,0xffffb
    8000604c:	340080e7          	jalr	832(ra) # 80001388 <_Z15thread_dispatchv>
}
    80006050:	01813083          	ld	ra,24(sp)
    80006054:	01013403          	ld	s0,16(sp)
    80006058:	00813483          	ld	s1,8(sp)
    8000605c:	00013903          	ld	s2,0(sp)
    80006060:	02010113          	addi	sp,sp,32
    80006064:	00008067          	ret

0000000080006068 <_ZL11workerBodyAPv>:
static void workerBodyA(void* arg) {
    80006068:	fe010113          	addi	sp,sp,-32
    8000606c:	00113c23          	sd	ra,24(sp)
    80006070:	00813823          	sd	s0,16(sp)
    80006074:	00913423          	sd	s1,8(sp)
    80006078:	01213023          	sd	s2,0(sp)
    8000607c:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 10; i++) {
    80006080:	00000913          	li	s2,0
    80006084:	0380006f          	j	800060bc <_ZL11workerBodyAPv+0x54>
            thread_dispatch();
    80006088:	ffffb097          	auipc	ra,0xffffb
    8000608c:	300080e7          	jalr	768(ra) # 80001388 <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++) {
    80006090:	00148493          	addi	s1,s1,1
    80006094:	000027b7          	lui	a5,0x2
    80006098:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    8000609c:	0097ee63          	bltu	a5,s1,800060b8 <_ZL11workerBodyAPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    800060a0:	00000713          	li	a4,0
    800060a4:	000077b7          	lui	a5,0x7
    800060a8:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    800060ac:	fce7eee3          	bltu	a5,a4,80006088 <_ZL11workerBodyAPv+0x20>
    800060b0:	00170713          	addi	a4,a4,1
    800060b4:	ff1ff06f          	j	800060a4 <_ZL11workerBodyAPv+0x3c>
    for (uint64 i = 0; i < 10; i++) {
    800060b8:	00190913          	addi	s2,s2,1
    800060bc:	00900793          	li	a5,9
    800060c0:	0527e063          	bltu	a5,s2,80006100 <_ZL11workerBodyAPv+0x98>
        printString("A: i="); printInt(i); printString("\n");
    800060c4:	00004517          	auipc	a0,0x4
    800060c8:	41c50513          	addi	a0,a0,1052 # 8000a4e0 <CONSOLE_STATUS+0x4d0>
    800060cc:	ffffc097          	auipc	ra,0xffffc
    800060d0:	e34080e7          	jalr	-460(ra) # 80001f00 <_Z11printStringPKc>
    800060d4:	00000613          	li	a2,0
    800060d8:	00a00593          	li	a1,10
    800060dc:	0009051b          	sext.w	a0,s2
    800060e0:	ffffc097          	auipc	ra,0xffffc
    800060e4:	fd0080e7          	jalr	-48(ra) # 800020b0 <_Z8printIntiii>
    800060e8:	00004517          	auipc	a0,0x4
    800060ec:	64850513          	addi	a0,a0,1608 # 8000a730 <CONSOLE_STATUS+0x720>
    800060f0:	ffffc097          	auipc	ra,0xffffc
    800060f4:	e10080e7          	jalr	-496(ra) # 80001f00 <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    800060f8:	00000493          	li	s1,0
    800060fc:	f99ff06f          	j	80006094 <_ZL11workerBodyAPv+0x2c>
    printString("A finished!\n");
    80006100:	00004517          	auipc	a0,0x4
    80006104:	3e850513          	addi	a0,a0,1000 # 8000a4e8 <CONSOLE_STATUS+0x4d8>
    80006108:	ffffc097          	auipc	ra,0xffffc
    8000610c:	df8080e7          	jalr	-520(ra) # 80001f00 <_Z11printStringPKc>
    finishedA = true;
    80006110:	00100793          	li	a5,1
    80006114:	0000a717          	auipc	a4,0xa
    80006118:	08f707a3          	sb	a5,143(a4) # 800101a3 <_ZL9finishedA>
}
    8000611c:	01813083          	ld	ra,24(sp)
    80006120:	01013403          	ld	s0,16(sp)
    80006124:	00813483          	ld	s1,8(sp)
    80006128:	00013903          	ld	s2,0(sp)
    8000612c:	02010113          	addi	sp,sp,32
    80006130:	00008067          	ret

0000000080006134 <_Z18Threads_C_API_testv>:


void Threads_C_API_test() {
    80006134:	fd010113          	addi	sp,sp,-48
    80006138:	02113423          	sd	ra,40(sp)
    8000613c:	02813023          	sd	s0,32(sp)
    80006140:	03010413          	addi	s0,sp,48
    thread_t threads[4];
    thread_create(&threads[0], workerBodyA, nullptr);
    80006144:	00000613          	li	a2,0
    80006148:	00000597          	auipc	a1,0x0
    8000614c:	f2058593          	addi	a1,a1,-224 # 80006068 <_ZL11workerBodyAPv>
    80006150:	fd040513          	addi	a0,s0,-48
    80006154:	ffffb097          	auipc	ra,0xffffb
    80006158:	1ac080e7          	jalr	428(ra) # 80001300 <_Z13thread_createPP8thread_sPFvPvES2_>
    printString("ThreadA created\n");
    8000615c:	00004517          	auipc	a0,0x4
    80006160:	41c50513          	addi	a0,a0,1052 # 8000a578 <CONSOLE_STATUS+0x568>
    80006164:	ffffc097          	auipc	ra,0xffffc
    80006168:	d9c080e7          	jalr	-612(ra) # 80001f00 <_Z11printStringPKc>

    thread_create(&threads[1], workerBodyB, nullptr);
    8000616c:	00000613          	li	a2,0
    80006170:	00000597          	auipc	a1,0x0
    80006174:	e2458593          	addi	a1,a1,-476 # 80005f94 <_ZL11workerBodyBPv>
    80006178:	fd840513          	addi	a0,s0,-40
    8000617c:	ffffb097          	auipc	ra,0xffffb
    80006180:	184080e7          	jalr	388(ra) # 80001300 <_Z13thread_createPP8thread_sPFvPvES2_>
    printString("ThreadB created\n");
    80006184:	00004517          	auipc	a0,0x4
    80006188:	40c50513          	addi	a0,a0,1036 # 8000a590 <CONSOLE_STATUS+0x580>
    8000618c:	ffffc097          	auipc	ra,0xffffc
    80006190:	d74080e7          	jalr	-652(ra) # 80001f00 <_Z11printStringPKc>

    thread_create(&threads[2], workerBodyC, nullptr);
    80006194:	00000613          	li	a2,0
    80006198:	00000597          	auipc	a1,0x0
    8000619c:	c7c58593          	addi	a1,a1,-900 # 80005e14 <_ZL11workerBodyCPv>
    800061a0:	fe040513          	addi	a0,s0,-32
    800061a4:	ffffb097          	auipc	ra,0xffffb
    800061a8:	15c080e7          	jalr	348(ra) # 80001300 <_Z13thread_createPP8thread_sPFvPvES2_>
    printString("ThreadC created\n");
    800061ac:	00004517          	auipc	a0,0x4
    800061b0:	3fc50513          	addi	a0,a0,1020 # 8000a5a8 <CONSOLE_STATUS+0x598>
    800061b4:	ffffc097          	auipc	ra,0xffffc
    800061b8:	d4c080e7          	jalr	-692(ra) # 80001f00 <_Z11printStringPKc>

    thread_create(&threads[3], workerBodyD, nullptr);
    800061bc:	00000613          	li	a2,0
    800061c0:	00000597          	auipc	a1,0x0
    800061c4:	b0c58593          	addi	a1,a1,-1268 # 80005ccc <_ZL11workerBodyDPv>
    800061c8:	fe840513          	addi	a0,s0,-24
    800061cc:	ffffb097          	auipc	ra,0xffffb
    800061d0:	134080e7          	jalr	308(ra) # 80001300 <_Z13thread_createPP8thread_sPFvPvES2_>
    printString("ThreadD created\n");
    800061d4:	00004517          	auipc	a0,0x4
    800061d8:	3ec50513          	addi	a0,a0,1004 # 8000a5c0 <CONSOLE_STATUS+0x5b0>
    800061dc:	ffffc097          	auipc	ra,0xffffc
    800061e0:	d24080e7          	jalr	-732(ra) # 80001f00 <_Z11printStringPKc>
    800061e4:	00c0006f          	j	800061f0 <_Z18Threads_C_API_testv+0xbc>

    while (!(finishedA && finishedB && finishedC && finishedD)) {
        thread_dispatch();
    800061e8:	ffffb097          	auipc	ra,0xffffb
    800061ec:	1a0080e7          	jalr	416(ra) # 80001388 <_Z15thread_dispatchv>
    while (!(finishedA && finishedB && finishedC && finishedD)) {
    800061f0:	0000a797          	auipc	a5,0xa
    800061f4:	fb37c783          	lbu	a5,-77(a5) # 800101a3 <_ZL9finishedA>
    800061f8:	fe0788e3          	beqz	a5,800061e8 <_Z18Threads_C_API_testv+0xb4>
    800061fc:	0000a797          	auipc	a5,0xa
    80006200:	fa67c783          	lbu	a5,-90(a5) # 800101a2 <_ZL9finishedB>
    80006204:	fe0782e3          	beqz	a5,800061e8 <_Z18Threads_C_API_testv+0xb4>
    80006208:	0000a797          	auipc	a5,0xa
    8000620c:	f997c783          	lbu	a5,-103(a5) # 800101a1 <_ZL9finishedC>
    80006210:	fc078ce3          	beqz	a5,800061e8 <_Z18Threads_C_API_testv+0xb4>
    80006214:	0000a797          	auipc	a5,0xa
    80006218:	f8c7c783          	lbu	a5,-116(a5) # 800101a0 <_ZL9finishedD>
    8000621c:	fc0786e3          	beqz	a5,800061e8 <_Z18Threads_C_API_testv+0xb4>
    }

}
    80006220:	02813083          	ld	ra,40(sp)
    80006224:	02013403          	ld	s0,32(sp)
    80006228:	03010113          	addi	sp,sp,48
    8000622c:	00008067          	ret

0000000080006230 <_ZN16ProducerKeyboard16producerKeyboardEPv>:
    void run() override {
        producerKeyboard(td);
    }
};

void ProducerKeyboard::producerKeyboard(void *arg) {
    80006230:	fd010113          	addi	sp,sp,-48
    80006234:	02113423          	sd	ra,40(sp)
    80006238:	02813023          	sd	s0,32(sp)
    8000623c:	00913c23          	sd	s1,24(sp)
    80006240:	01213823          	sd	s2,16(sp)
    80006244:	01313423          	sd	s3,8(sp)
    80006248:	03010413          	addi	s0,sp,48
    8000624c:	00050993          	mv	s3,a0
    80006250:	00058493          	mv	s1,a1
    struct thread_data *data = (struct thread_data *) arg;

    int key;
    int i = 0;
    80006254:	00000913          	li	s2,0
    80006258:	00c0006f          	j	80006264 <_ZN16ProducerKeyboard16producerKeyboardEPv+0x34>
            thread_dispatch();
    8000625c:	ffffb097          	auipc	ra,0xffffb
    80006260:	12c080e7          	jalr	300(ra) # 80001388 <_Z15thread_dispatchv>
    while ((key = getc()) != 13) {
    80006264:	ffffb097          	auipc	ra,0xffffb
    80006268:	310080e7          	jalr	784(ra) # 80001574 <_Z4getcv>
    8000626c:	0005059b          	sext.w	a1,a0
    80006270:	00d00793          	li	a5,13
    80006274:	02f58a63          	beq	a1,a5,800062a8 <_ZN16ProducerKeyboard16producerKeyboardEPv+0x78>
        data->buffer->put(key);
    80006278:	0084b503          	ld	a0,8(s1)
    8000627c:	00001097          	auipc	ra,0x1
    80006280:	904080e7          	jalr	-1788(ra) # 80006b80 <_ZN9BufferCPP3putEi>
        i++;
    80006284:	0019071b          	addiw	a4,s2,1
    80006288:	0007091b          	sext.w	s2,a4

        if (i % (10 * data->id) == 0) {
    8000628c:	0004a683          	lw	a3,0(s1)
    80006290:	0026979b          	slliw	a5,a3,0x2
    80006294:	00d787bb          	addw	a5,a5,a3
    80006298:	0017979b          	slliw	a5,a5,0x1
    8000629c:	02f767bb          	remw	a5,a4,a5
    800062a0:	fc0792e3          	bnez	a5,80006264 <_ZN16ProducerKeyboard16producerKeyboardEPv+0x34>
    800062a4:	fb9ff06f          	j	8000625c <_ZN16ProducerKeyboard16producerKeyboardEPv+0x2c>
            Thread::dispatch();
        }
    }

    threadEnd = 1;
    800062a8:	00100793          	li	a5,1
    800062ac:	0000a717          	auipc	a4,0xa
    800062b0:	eef72e23          	sw	a5,-260(a4) # 800101a8 <_ZL9threadEnd>
    td->buffer->put('!');
    800062b4:	0209b783          	ld	a5,32(s3)
    800062b8:	02100593          	li	a1,33
    800062bc:	0087b503          	ld	a0,8(a5)
    800062c0:	00001097          	auipc	ra,0x1
    800062c4:	8c0080e7          	jalr	-1856(ra) # 80006b80 <_ZN9BufferCPP3putEi>

    data->wait->signal();
    800062c8:	0104b783          	ld	a5,16(s1)
            return sem_signal(myHandle);
    800062cc:	0087b503          	ld	a0,8(a5)
    800062d0:	ffffb097          	auipc	ra,0xffffb
    800062d4:	230080e7          	jalr	560(ra) # 80001500 <_Z10sem_signalP5sem_s>
}
    800062d8:	02813083          	ld	ra,40(sp)
    800062dc:	02013403          	ld	s0,32(sp)
    800062e0:	01813483          	ld	s1,24(sp)
    800062e4:	01013903          	ld	s2,16(sp)
    800062e8:	00813983          	ld	s3,8(sp)
    800062ec:	03010113          	addi	sp,sp,48
    800062f0:	00008067          	ret

00000000800062f4 <_ZN12ProducerSync8producerEPv>:
    void run() override {
        producer(td);
    }
};

void ProducerSync::producer(void *arg) {
    800062f4:	fe010113          	addi	sp,sp,-32
    800062f8:	00113c23          	sd	ra,24(sp)
    800062fc:	00813823          	sd	s0,16(sp)
    80006300:	00913423          	sd	s1,8(sp)
    80006304:	01213023          	sd	s2,0(sp)
    80006308:	02010413          	addi	s0,sp,32
    8000630c:	00058493          	mv	s1,a1
    struct thread_data *data = (struct thread_data *) arg;

    int i = 0;
    80006310:	00000913          	li	s2,0
    80006314:	00c0006f          	j	80006320 <_ZN12ProducerSync8producerEPv+0x2c>
            thread_dispatch();
    80006318:	ffffb097          	auipc	ra,0xffffb
    8000631c:	070080e7          	jalr	112(ra) # 80001388 <_Z15thread_dispatchv>
    while (!threadEnd) {
    80006320:	0000a797          	auipc	a5,0xa
    80006324:	e887a783          	lw	a5,-376(a5) # 800101a8 <_ZL9threadEnd>
    80006328:	02079e63          	bnez	a5,80006364 <_ZN12ProducerSync8producerEPv+0x70>
        data->buffer->put(data->id + '0');
    8000632c:	0004a583          	lw	a1,0(s1)
    80006330:	0305859b          	addiw	a1,a1,48
    80006334:	0084b503          	ld	a0,8(s1)
    80006338:	00001097          	auipc	ra,0x1
    8000633c:	848080e7          	jalr	-1976(ra) # 80006b80 <_ZN9BufferCPP3putEi>
        i++;
    80006340:	0019071b          	addiw	a4,s2,1
    80006344:	0007091b          	sext.w	s2,a4

        if (i % (10 * data->id) == 0) {
    80006348:	0004a683          	lw	a3,0(s1)
    8000634c:	0026979b          	slliw	a5,a3,0x2
    80006350:	00d787bb          	addw	a5,a5,a3
    80006354:	0017979b          	slliw	a5,a5,0x1
    80006358:	02f767bb          	remw	a5,a4,a5
    8000635c:	fc0792e3          	bnez	a5,80006320 <_ZN12ProducerSync8producerEPv+0x2c>
    80006360:	fb9ff06f          	j	80006318 <_ZN12ProducerSync8producerEPv+0x24>
            Thread::dispatch();
        }
    }

    data->wait->signal();
    80006364:	0104b783          	ld	a5,16(s1)
            return sem_signal(myHandle);
    80006368:	0087b503          	ld	a0,8(a5)
    8000636c:	ffffb097          	auipc	ra,0xffffb
    80006370:	194080e7          	jalr	404(ra) # 80001500 <_Z10sem_signalP5sem_s>
}
    80006374:	01813083          	ld	ra,24(sp)
    80006378:	01013403          	ld	s0,16(sp)
    8000637c:	00813483          	ld	s1,8(sp)
    80006380:	00013903          	ld	s2,0(sp)
    80006384:	02010113          	addi	sp,sp,32
    80006388:	00008067          	ret

000000008000638c <_ZN12ConsumerSync8consumerEPv>:
    void run() override {
        consumer(td);
    }
};

void ConsumerSync::consumer(void *arg) {
    8000638c:	fd010113          	addi	sp,sp,-48
    80006390:	02113423          	sd	ra,40(sp)
    80006394:	02813023          	sd	s0,32(sp)
    80006398:	00913c23          	sd	s1,24(sp)
    8000639c:	01213823          	sd	s2,16(sp)
    800063a0:	01313423          	sd	s3,8(sp)
    800063a4:	01413023          	sd	s4,0(sp)
    800063a8:	03010413          	addi	s0,sp,48
    800063ac:	00050993          	mv	s3,a0
    800063b0:	00058913          	mv	s2,a1
    struct thread_data *data = (struct thread_data *) arg;

    int i = 0;
    800063b4:	00000a13          	li	s4,0
    800063b8:	01c0006f          	j	800063d4 <_ZN12ConsumerSync8consumerEPv+0x48>
            thread_dispatch();
    800063bc:	ffffb097          	auipc	ra,0xffffb
    800063c0:	fcc080e7          	jalr	-52(ra) # 80001388 <_Z15thread_dispatchv>
        }
    800063c4:	0500006f          	j	80006414 <_ZN12ConsumerSync8consumerEPv+0x88>
        if (i % (5 * data->id) == 0) {
            Thread::dispatch();
        }

        if (i % 80 == 0) {
            putc('\n');
    800063c8:	00a00513          	li	a0,10
    800063cc:	ffffb097          	auipc	ra,0xffffb
    800063d0:	1e4080e7          	jalr	484(ra) # 800015b0 <_Z4putcc>
    while (!threadEnd) {
    800063d4:	0000a797          	auipc	a5,0xa
    800063d8:	dd47a783          	lw	a5,-556(a5) # 800101a8 <_ZL9threadEnd>
    800063dc:	06079263          	bnez	a5,80006440 <_ZN12ConsumerSync8consumerEPv+0xb4>
        int key = data->buffer->get();
    800063e0:	00893503          	ld	a0,8(s2)
    800063e4:	00001097          	auipc	ra,0x1
    800063e8:	83c080e7          	jalr	-1988(ra) # 80006c20 <_ZN9BufferCPP3getEv>
        i++;
    800063ec:	001a049b          	addiw	s1,s4,1
    800063f0:	00048a1b          	sext.w	s4,s1
        putc(key);
    800063f4:	0ff57513          	andi	a0,a0,255
    800063f8:	ffffb097          	auipc	ra,0xffffb
    800063fc:	1b8080e7          	jalr	440(ra) # 800015b0 <_Z4putcc>
        if (i % (5 * data->id) == 0) {
    80006400:	00092703          	lw	a4,0(s2)
    80006404:	0027179b          	slliw	a5,a4,0x2
    80006408:	00e787bb          	addw	a5,a5,a4
    8000640c:	02f4e7bb          	remw	a5,s1,a5
    80006410:	fa0786e3          	beqz	a5,800063bc <_ZN12ConsumerSync8consumerEPv+0x30>
        if (i % 80 == 0) {
    80006414:	05000793          	li	a5,80
    80006418:	02f4e4bb          	remw	s1,s1,a5
    8000641c:	fa049ce3          	bnez	s1,800063d4 <_ZN12ConsumerSync8consumerEPv+0x48>
    80006420:	fa9ff06f          	j	800063c8 <_ZN12ConsumerSync8consumerEPv+0x3c>
        }
    }


    while (td->buffer->getCnt() > 0) {
        int key = td->buffer->get();
    80006424:	0209b783          	ld	a5,32(s3)
    80006428:	0087b503          	ld	a0,8(a5)
    8000642c:	00000097          	auipc	ra,0x0
    80006430:	7f4080e7          	jalr	2036(ra) # 80006c20 <_ZN9BufferCPP3getEv>
            ::putc(c);
    80006434:	0ff57513          	andi	a0,a0,255
    80006438:	ffffb097          	auipc	ra,0xffffb
    8000643c:	178080e7          	jalr	376(ra) # 800015b0 <_Z4putcc>
    while (td->buffer->getCnt() > 0) {
    80006440:	0209b783          	ld	a5,32(s3)
    80006444:	0087b503          	ld	a0,8(a5)
    80006448:	00001097          	auipc	ra,0x1
    8000644c:	874080e7          	jalr	-1932(ra) # 80006cbc <_ZN9BufferCPP6getCntEv>
    80006450:	fca04ae3          	bgtz	a0,80006424 <_ZN12ConsumerSync8consumerEPv+0x98>
        Console::putc(key);
    }

    data->wait->signal();
    80006454:	01093783          	ld	a5,16(s2)
            return sem_signal(myHandle);
    80006458:	0087b503          	ld	a0,8(a5)
    8000645c:	ffffb097          	auipc	ra,0xffffb
    80006460:	0a4080e7          	jalr	164(ra) # 80001500 <_Z10sem_signalP5sem_s>
}
    80006464:	02813083          	ld	ra,40(sp)
    80006468:	02013403          	ld	s0,32(sp)
    8000646c:	01813483          	ld	s1,24(sp)
    80006470:	01013903          	ld	s2,16(sp)
    80006474:	00813983          	ld	s3,8(sp)
    80006478:	00013a03          	ld	s4,0(sp)
    8000647c:	03010113          	addi	sp,sp,48
    80006480:	00008067          	ret

0000000080006484 <_Z29producerConsumer_CPP_Sync_APIv>:

void producerConsumer_CPP_Sync_API() {
    80006484:	f9010113          	addi	sp,sp,-112
    80006488:	06113423          	sd	ra,104(sp)
    8000648c:	06813023          	sd	s0,96(sp)
    80006490:	04913c23          	sd	s1,88(sp)
    80006494:	05213823          	sd	s2,80(sp)
    80006498:	05313423          	sd	s3,72(sp)
    8000649c:	05413023          	sd	s4,64(sp)
    800064a0:	03513c23          	sd	s5,56(sp)
    800064a4:	03613823          	sd	s6,48(sp)
    800064a8:	03713423          	sd	s7,40(sp)
    800064ac:	03813023          	sd	s8,32(sp)
    800064b0:	07010413          	addi	s0,sp,112
    for (int i = 0; i < threadNum; i++) {
        delete threads[i];
    }
    delete consumerThread;
    delete waitForAll;
    delete buffer;
    800064b4:	00010b93          	mv	s7,sp
    printString("Unesite broj proizvodjaca?\n");
    800064b8:	00004517          	auipc	a0,0x4
    800064bc:	f4050513          	addi	a0,a0,-192 # 8000a3f8 <CONSOLE_STATUS+0x3e8>
    800064c0:	ffffc097          	auipc	ra,0xffffc
    800064c4:	a40080e7          	jalr	-1472(ra) # 80001f00 <_Z11printStringPKc>
    getString(input, 30);
    800064c8:	01e00593          	li	a1,30
    800064cc:	f9040493          	addi	s1,s0,-112
    800064d0:	00048513          	mv	a0,s1
    800064d4:	ffffc097          	auipc	ra,0xffffc
    800064d8:	ab4080e7          	jalr	-1356(ra) # 80001f88 <_Z9getStringPci>
    threadNum = stringToInt(input);
    800064dc:	00048513          	mv	a0,s1
    800064e0:	ffffc097          	auipc	ra,0xffffc
    800064e4:	b80080e7          	jalr	-1152(ra) # 80002060 <_Z11stringToIntPKc>
    800064e8:	00050913          	mv	s2,a0
    printString("Unesite velicinu bafera?\n");
    800064ec:	00004517          	auipc	a0,0x4
    800064f0:	f2c50513          	addi	a0,a0,-212 # 8000a418 <CONSOLE_STATUS+0x408>
    800064f4:	ffffc097          	auipc	ra,0xffffc
    800064f8:	a0c080e7          	jalr	-1524(ra) # 80001f00 <_Z11printStringPKc>
    getString(input, 30);
    800064fc:	01e00593          	li	a1,30
    80006500:	00048513          	mv	a0,s1
    80006504:	ffffc097          	auipc	ra,0xffffc
    80006508:	a84080e7          	jalr	-1404(ra) # 80001f88 <_Z9getStringPci>
    n = stringToInt(input);
    8000650c:	00048513          	mv	a0,s1
    80006510:	ffffc097          	auipc	ra,0xffffc
    80006514:	b50080e7          	jalr	-1200(ra) # 80002060 <_Z11stringToIntPKc>
    80006518:	00050493          	mv	s1,a0
    printString("Broj proizvodjaca "); printInt(threadNum);
    8000651c:	00004517          	auipc	a0,0x4
    80006520:	f1c50513          	addi	a0,a0,-228 # 8000a438 <CONSOLE_STATUS+0x428>
    80006524:	ffffc097          	auipc	ra,0xffffc
    80006528:	9dc080e7          	jalr	-1572(ra) # 80001f00 <_Z11printStringPKc>
    8000652c:	00000613          	li	a2,0
    80006530:	00a00593          	li	a1,10
    80006534:	00090513          	mv	a0,s2
    80006538:	ffffc097          	auipc	ra,0xffffc
    8000653c:	b78080e7          	jalr	-1160(ra) # 800020b0 <_Z8printIntiii>
    printString(" i velicina bafera "); printInt(n);
    80006540:	00004517          	auipc	a0,0x4
    80006544:	f1050513          	addi	a0,a0,-240 # 8000a450 <CONSOLE_STATUS+0x440>
    80006548:	ffffc097          	auipc	ra,0xffffc
    8000654c:	9b8080e7          	jalr	-1608(ra) # 80001f00 <_Z11printStringPKc>
    80006550:	00000613          	li	a2,0
    80006554:	00a00593          	li	a1,10
    80006558:	00048513          	mv	a0,s1
    8000655c:	ffffc097          	auipc	ra,0xffffc
    80006560:	b54080e7          	jalr	-1196(ra) # 800020b0 <_Z8printIntiii>
    printString(".\n");
    80006564:	00004517          	auipc	a0,0x4
    80006568:	f0450513          	addi	a0,a0,-252 # 8000a468 <CONSOLE_STATUS+0x458>
    8000656c:	ffffc097          	auipc	ra,0xffffc
    80006570:	994080e7          	jalr	-1644(ra) # 80001f00 <_Z11printStringPKc>
    if(threadNum > n) {
    80006574:	0324c463          	blt	s1,s2,8000659c <_Z29producerConsumer_CPP_Sync_APIv+0x118>
    } else if (threadNum < 1) {
    80006578:	03205c63          	blez	s2,800065b0 <_Z29producerConsumer_CPP_Sync_APIv+0x12c>
    BufferCPP *buffer = new BufferCPP(n);
    8000657c:	03800513          	li	a0,56
    80006580:	ffffd097          	auipc	ra,0xffffd
    80006584:	844080e7          	jalr	-1980(ra) # 80002dc4 <_Znwm>
    80006588:	00050a93          	mv	s5,a0
    8000658c:	00048593          	mv	a1,s1
    80006590:	00000097          	auipc	ra,0x0
    80006594:	45c080e7          	jalr	1116(ra) # 800069ec <_ZN9BufferCPPC1Ei>
    80006598:	0300006f          	j	800065c8 <_Z29producerConsumer_CPP_Sync_APIv+0x144>
        printString("Broj proizvodjaca ne sme biti manji od velicine bafera!\n");
    8000659c:	00004517          	auipc	a0,0x4
    800065a0:	ed450513          	addi	a0,a0,-300 # 8000a470 <CONSOLE_STATUS+0x460>
    800065a4:	ffffc097          	auipc	ra,0xffffc
    800065a8:	95c080e7          	jalr	-1700(ra) # 80001f00 <_Z11printStringPKc>
        return;
    800065ac:	0140006f          	j	800065c0 <_Z29producerConsumer_CPP_Sync_APIv+0x13c>
        printString("Broj proizvodjaca mora biti veci od nula!\n");
    800065b0:	00004517          	auipc	a0,0x4
    800065b4:	f0050513          	addi	a0,a0,-256 # 8000a4b0 <CONSOLE_STATUS+0x4a0>
    800065b8:	ffffc097          	auipc	ra,0xffffc
    800065bc:	948080e7          	jalr	-1720(ra) # 80001f00 <_Z11printStringPKc>
        return;
    800065c0:	000b8113          	mv	sp,s7
    800065c4:	2780006f          	j	8000683c <_Z29producerConsumer_CPP_Sync_APIv+0x3b8>
    waitForAll = new Semaphore(0);
    800065c8:	01000513          	li	a0,16
    800065cc:	ffffc097          	auipc	ra,0xffffc
    800065d0:	7f8080e7          	jalr	2040(ra) # 80002dc4 <_Znwm>
    800065d4:	00050493          	mv	s1,a0
        Semaphore (unsigned init = 1){
    800065d8:	00006797          	auipc	a5,0x6
    800065dc:	50878793          	addi	a5,a5,1288 # 8000cae0 <_ZTV9Semaphore+0x10>
    800065e0:	00f53023          	sd	a5,0(a0)
            sem_open(&myHandle,init);
    800065e4:	00000593          	li	a1,0
    800065e8:	00850513          	addi	a0,a0,8
    800065ec:	ffffb097          	auipc	ra,0xffffb
    800065f0:	e50080e7          	jalr	-432(ra) # 8000143c <_Z8sem_openPP5sem_sj>
    800065f4:	0000a797          	auipc	a5,0xa
    800065f8:	ba97be23          	sd	s1,-1092(a5) # 800101b0 <_ZL10waitForAll>
    Thread* threads[threadNum];
    800065fc:	00391793          	slli	a5,s2,0x3
    80006600:	00f78793          	addi	a5,a5,15
    80006604:	ff07f793          	andi	a5,a5,-16
    80006608:	40f10133          	sub	sp,sp,a5
    8000660c:	00010993          	mv	s3,sp
    struct thread_data data[threadNum + 1];
    80006610:	0019071b          	addiw	a4,s2,1
    80006614:	00171793          	slli	a5,a4,0x1
    80006618:	00e787b3          	add	a5,a5,a4
    8000661c:	00379793          	slli	a5,a5,0x3
    80006620:	00f78793          	addi	a5,a5,15
    80006624:	ff07f793          	andi	a5,a5,-16
    80006628:	40f10133          	sub	sp,sp,a5
    8000662c:	00010a13          	mv	s4,sp
    data[threadNum].id = threadNum;
    80006630:	00191c13          	slli	s8,s2,0x1
    80006634:	012c07b3          	add	a5,s8,s2
    80006638:	00379793          	slli	a5,a5,0x3
    8000663c:	00fa07b3          	add	a5,s4,a5
    80006640:	0127a023          	sw	s2,0(a5)
    data[threadNum].buffer = buffer;
    80006644:	0157b423          	sd	s5,8(a5)
    data[threadNum].wait = waitForAll;
    80006648:	0097b823          	sd	s1,16(a5)
    consumerThread = new ConsumerSync(data+threadNum);
    8000664c:	02800513          	li	a0,40
    80006650:	ffffc097          	auipc	ra,0xffffc
    80006654:	774080e7          	jalr	1908(ra) # 80002dc4 <_Znwm>
    80006658:	00050b13          	mv	s6,a0
    8000665c:	012c0c33          	add	s8,s8,s2
    80006660:	003c1c13          	slli	s8,s8,0x3
    80006664:	018a0c33          	add	s8,s4,s8
            body= nullptr;
    80006668:	00053823          	sd	zero,16(a0)
            arg= nullptr;
    8000666c:	00053c23          	sd	zero,24(a0)
    ConsumerSync(thread_data* _td):Thread(), td(_td) {}
    80006670:	00006797          	auipc	a5,0x6
    80006674:	55878793          	addi	a5,a5,1368 # 8000cbc8 <_ZTV12ConsumerSync+0x10>
    80006678:	00f53023          	sd	a5,0(a0)
    8000667c:	03853023          	sd	s8,32(a0)
            if(body== nullptr) return thread_create(&myHandle,&threadEntry, this);
    80006680:	00050613          	mv	a2,a0
    80006684:	ffffc597          	auipc	a1,0xffffc
    80006688:	5cc58593          	addi	a1,a1,1484 # 80002c50 <_ZN6Thread11threadEntryEPv>
    8000668c:	00850513          	addi	a0,a0,8
    80006690:	ffffb097          	auipc	ra,0xffffb
    80006694:	c70080e7          	jalr	-912(ra) # 80001300 <_Z13thread_createPP8thread_sPFvPvES2_>
    for (int i = 0; i < threadNum; i++) {
    80006698:	00000493          	li	s1,0
    8000669c:	0640006f          	j	80006700 <_Z29producerConsumer_CPP_Sync_APIv+0x27c>
            threads[i] = new ProducerKeyboard(data+i);
    800066a0:	02800513          	li	a0,40
    800066a4:	ffffc097          	auipc	ra,0xffffc
    800066a8:	720080e7          	jalr	1824(ra) # 80002dc4 <_Znwm>
    800066ac:	00149793          	slli	a5,s1,0x1
    800066b0:	009787b3          	add	a5,a5,s1
    800066b4:	00379793          	slli	a5,a5,0x3
    800066b8:	00fa07b3          	add	a5,s4,a5
            body= nullptr;
    800066bc:	00053823          	sd	zero,16(a0)
            arg= nullptr;
    800066c0:	00053c23          	sd	zero,24(a0)
    ProducerKeyboard(thread_data* _td):Thread(), td(_td) {}
    800066c4:	00006717          	auipc	a4,0x6
    800066c8:	4b470713          	addi	a4,a4,1204 # 8000cb78 <_ZTV16ProducerKeyboard+0x10>
    800066cc:	00e53023          	sd	a4,0(a0)
    800066d0:	02f53023          	sd	a5,32(a0)
            threads[i] = new ProducerKeyboard(data+i);
    800066d4:	00349793          	slli	a5,s1,0x3
    800066d8:	00f987b3          	add	a5,s3,a5
    800066dc:	00a7b023          	sd	a0,0(a5)
    800066e0:	08c0006f          	j	8000676c <_Z29producerConsumer_CPP_Sync_APIv+0x2e8>
            if(body== nullptr) return thread_create(&myHandle,&threadEntry, this);
    800066e4:	00050613          	mv	a2,a0
    800066e8:	ffffc597          	auipc	a1,0xffffc
    800066ec:	56858593          	addi	a1,a1,1384 # 80002c50 <_ZN6Thread11threadEntryEPv>
    800066f0:	00850513          	addi	a0,a0,8
    800066f4:	ffffb097          	auipc	ra,0xffffb
    800066f8:	c0c080e7          	jalr	-1012(ra) # 80001300 <_Z13thread_createPP8thread_sPFvPvES2_>
    for (int i = 0; i < threadNum; i++) {
    800066fc:	0014849b          	addiw	s1,s1,1
    80006700:	0924da63          	bge	s1,s2,80006794 <_Z29producerConsumer_CPP_Sync_APIv+0x310>
        data[i].id = i;
    80006704:	00149793          	slli	a5,s1,0x1
    80006708:	009787b3          	add	a5,a5,s1
    8000670c:	00379793          	slli	a5,a5,0x3
    80006710:	00fa07b3          	add	a5,s4,a5
    80006714:	0097a023          	sw	s1,0(a5)
        data[i].buffer = buffer;
    80006718:	0157b423          	sd	s5,8(a5)
        data[i].wait = waitForAll;
    8000671c:	0000a717          	auipc	a4,0xa
    80006720:	a9473703          	ld	a4,-1388(a4) # 800101b0 <_ZL10waitForAll>
    80006724:	00e7b823          	sd	a4,16(a5)
        if(i>0) {
    80006728:	f6905ce3          	blez	s1,800066a0 <_Z29producerConsumer_CPP_Sync_APIv+0x21c>
            threads[i] = new ProducerSync(data+i);
    8000672c:	02800513          	li	a0,40
    80006730:	ffffc097          	auipc	ra,0xffffc
    80006734:	694080e7          	jalr	1684(ra) # 80002dc4 <_Znwm>
    80006738:	00149793          	slli	a5,s1,0x1
    8000673c:	009787b3          	add	a5,a5,s1
    80006740:	00379793          	slli	a5,a5,0x3
    80006744:	00fa07b3          	add	a5,s4,a5
            body= nullptr;
    80006748:	00053823          	sd	zero,16(a0)
            arg= nullptr;
    8000674c:	00053c23          	sd	zero,24(a0)
    ProducerSync(thread_data* _td):Thread(), td(_td) {}
    80006750:	00006717          	auipc	a4,0x6
    80006754:	45070713          	addi	a4,a4,1104 # 8000cba0 <_ZTV12ProducerSync+0x10>
    80006758:	00e53023          	sd	a4,0(a0)
    8000675c:	02f53023          	sd	a5,32(a0)
            threads[i] = new ProducerSync(data+i);
    80006760:	00349793          	slli	a5,s1,0x3
    80006764:	00f987b3          	add	a5,s3,a5
    80006768:	00a7b023          	sd	a0,0(a5)
        threads[i]->start();
    8000676c:	00349793          	slli	a5,s1,0x3
    80006770:	00f987b3          	add	a5,s3,a5
    80006774:	0007b503          	ld	a0,0(a5)
            if(body== nullptr) return thread_create(&myHandle,&threadEntry, this);
    80006778:	01053583          	ld	a1,16(a0)
    8000677c:	f60584e3          	beqz	a1,800066e4 <_Z29producerConsumer_CPP_Sync_APIv+0x260>
            else return thread_create(&myHandle,body,arg);
    80006780:	01853603          	ld	a2,24(a0)
    80006784:	00850513          	addi	a0,a0,8
    80006788:	ffffb097          	auipc	ra,0xffffb
    8000678c:	b78080e7          	jalr	-1160(ra) # 80001300 <_Z13thread_createPP8thread_sPFvPvES2_>
    80006790:	f6dff06f          	j	800066fc <_Z29producerConsumer_CPP_Sync_APIv+0x278>
            thread_dispatch();
    80006794:	ffffb097          	auipc	ra,0xffffb
    80006798:	bf4080e7          	jalr	-1036(ra) # 80001388 <_Z15thread_dispatchv>
    for (int i = 0; i <= threadNum; i++) {
    8000679c:	00000493          	li	s1,0
    800067a0:	02994063          	blt	s2,s1,800067c0 <_Z29producerConsumer_CPP_Sync_APIv+0x33c>
            return sem_wait(myHandle);
    800067a4:	0000a797          	auipc	a5,0xa
    800067a8:	a0c7b783          	ld	a5,-1524(a5) # 800101b0 <_ZL10waitForAll>
    800067ac:	0087b503          	ld	a0,8(a5)
    800067b0:	ffffb097          	auipc	ra,0xffffb
    800067b4:	d10080e7          	jalr	-752(ra) # 800014c0 <_Z8sem_waitP5sem_s>
    800067b8:	0014849b          	addiw	s1,s1,1
    800067bc:	fe5ff06f          	j	800067a0 <_Z29producerConsumer_CPP_Sync_APIv+0x31c>
    for (int i = 0; i < threadNum; i++) {
    800067c0:	00000493          	li	s1,0
    800067c4:	0080006f          	j	800067cc <_Z29producerConsumer_CPP_Sync_APIv+0x348>
    800067c8:	0014849b          	addiw	s1,s1,1
    800067cc:	0324d263          	bge	s1,s2,800067f0 <_Z29producerConsumer_CPP_Sync_APIv+0x36c>
        delete threads[i];
    800067d0:	00349793          	slli	a5,s1,0x3
    800067d4:	00f987b3          	add	a5,s3,a5
    800067d8:	0007b503          	ld	a0,0(a5)
    800067dc:	fe0506e3          	beqz	a0,800067c8 <_Z29producerConsumer_CPP_Sync_APIv+0x344>
    800067e0:	00053783          	ld	a5,0(a0)
    800067e4:	0087b783          	ld	a5,8(a5)
    800067e8:	000780e7          	jalr	a5
    800067ec:	fddff06f          	j	800067c8 <_Z29producerConsumer_CPP_Sync_APIv+0x344>
    delete consumerThread;
    800067f0:	000b0a63          	beqz	s6,80006804 <_Z29producerConsumer_CPP_Sync_APIv+0x380>
    800067f4:	000b3783          	ld	a5,0(s6)
    800067f8:	0087b783          	ld	a5,8(a5)
    800067fc:	000b0513          	mv	a0,s6
    80006800:	000780e7          	jalr	a5
    delete waitForAll;
    80006804:	0000a517          	auipc	a0,0xa
    80006808:	9ac53503          	ld	a0,-1620(a0) # 800101b0 <_ZL10waitForAll>
    8000680c:	00050863          	beqz	a0,8000681c <_Z29producerConsumer_CPP_Sync_APIv+0x398>
    80006810:	00053783          	ld	a5,0(a0)
    80006814:	0087b783          	ld	a5,8(a5)
    80006818:	000780e7          	jalr	a5
    delete buffer;
    8000681c:	000a8e63          	beqz	s5,80006838 <_Z29producerConsumer_CPP_Sync_APIv+0x3b4>
    80006820:	000a8513          	mv	a0,s5
    80006824:	00000097          	auipc	ra,0x0
    80006828:	530080e7          	jalr	1328(ra) # 80006d54 <_ZN9BufferCPPD1Ev>
    8000682c:	000a8513          	mv	a0,s5
    80006830:	ffffc097          	auipc	ra,0xffffc
    80006834:	5bc080e7          	jalr	1468(ra) # 80002dec <_ZdlPv>
    80006838:	000b8113          	mv	sp,s7

}
    8000683c:	f9040113          	addi	sp,s0,-112
    80006840:	06813083          	ld	ra,104(sp)
    80006844:	06013403          	ld	s0,96(sp)
    80006848:	05813483          	ld	s1,88(sp)
    8000684c:	05013903          	ld	s2,80(sp)
    80006850:	04813983          	ld	s3,72(sp)
    80006854:	04013a03          	ld	s4,64(sp)
    80006858:	03813a83          	ld	s5,56(sp)
    8000685c:	03013b03          	ld	s6,48(sp)
    80006860:	02813b83          	ld	s7,40(sp)
    80006864:	02013c03          	ld	s8,32(sp)
    80006868:	07010113          	addi	sp,sp,112
    8000686c:	00008067          	ret
    80006870:	00050493          	mv	s1,a0
    BufferCPP *buffer = new BufferCPP(n);
    80006874:	000a8513          	mv	a0,s5
    80006878:	ffffc097          	auipc	ra,0xffffc
    8000687c:	574080e7          	jalr	1396(ra) # 80002dec <_ZdlPv>
    80006880:	00048513          	mv	a0,s1
    80006884:	0000b097          	auipc	ra,0xb
    80006888:	a04080e7          	jalr	-1532(ra) # 80011288 <_Unwind_Resume>
    8000688c:	00050913          	mv	s2,a0
    waitForAll = new Semaphore(0);
    80006890:	00048513          	mv	a0,s1
    80006894:	ffffc097          	auipc	ra,0xffffc
    80006898:	558080e7          	jalr	1368(ra) # 80002dec <_ZdlPv>
    8000689c:	00090513          	mv	a0,s2
    800068a0:	0000b097          	auipc	ra,0xb
    800068a4:	9e8080e7          	jalr	-1560(ra) # 80011288 <_Unwind_Resume>

00000000800068a8 <_ZN12ConsumerSyncD1Ev>:
class ConsumerSync:public Thread {
    800068a8:	ff010113          	addi	sp,sp,-16
    800068ac:	00813423          	sd	s0,8(sp)
    800068b0:	01010413          	addi	s0,sp,16
    800068b4:	00813403          	ld	s0,8(sp)
    800068b8:	01010113          	addi	sp,sp,16
    800068bc:	00008067          	ret

00000000800068c0 <_ZN12ProducerSyncD1Ev>:
class ProducerSync:public Thread {
    800068c0:	ff010113          	addi	sp,sp,-16
    800068c4:	00813423          	sd	s0,8(sp)
    800068c8:	01010413          	addi	s0,sp,16
    800068cc:	00813403          	ld	s0,8(sp)
    800068d0:	01010113          	addi	sp,sp,16
    800068d4:	00008067          	ret

00000000800068d8 <_ZN16ProducerKeyboardD1Ev>:
class ProducerKeyboard:public Thread {
    800068d8:	ff010113          	addi	sp,sp,-16
    800068dc:	00813423          	sd	s0,8(sp)
    800068e0:	01010413          	addi	s0,sp,16
    800068e4:	00813403          	ld	s0,8(sp)
    800068e8:	01010113          	addi	sp,sp,16
    800068ec:	00008067          	ret

00000000800068f0 <_ZN12ConsumerSyncD0Ev>:
class ConsumerSync:public Thread {
    800068f0:	ff010113          	addi	sp,sp,-16
    800068f4:	00113423          	sd	ra,8(sp)
    800068f8:	00813023          	sd	s0,0(sp)
    800068fc:	01010413          	addi	s0,sp,16
    80006900:	ffffc097          	auipc	ra,0xffffc
    80006904:	4ec080e7          	jalr	1260(ra) # 80002dec <_ZdlPv>
    80006908:	00813083          	ld	ra,8(sp)
    8000690c:	00013403          	ld	s0,0(sp)
    80006910:	01010113          	addi	sp,sp,16
    80006914:	00008067          	ret

0000000080006918 <_ZN12ProducerSyncD0Ev>:
class ProducerSync:public Thread {
    80006918:	ff010113          	addi	sp,sp,-16
    8000691c:	00113423          	sd	ra,8(sp)
    80006920:	00813023          	sd	s0,0(sp)
    80006924:	01010413          	addi	s0,sp,16
    80006928:	ffffc097          	auipc	ra,0xffffc
    8000692c:	4c4080e7          	jalr	1220(ra) # 80002dec <_ZdlPv>
    80006930:	00813083          	ld	ra,8(sp)
    80006934:	00013403          	ld	s0,0(sp)
    80006938:	01010113          	addi	sp,sp,16
    8000693c:	00008067          	ret

0000000080006940 <_ZN16ProducerKeyboardD0Ev>:
class ProducerKeyboard:public Thread {
    80006940:	ff010113          	addi	sp,sp,-16
    80006944:	00113423          	sd	ra,8(sp)
    80006948:	00813023          	sd	s0,0(sp)
    8000694c:	01010413          	addi	s0,sp,16
    80006950:	ffffc097          	auipc	ra,0xffffc
    80006954:	49c080e7          	jalr	1180(ra) # 80002dec <_ZdlPv>
    80006958:	00813083          	ld	ra,8(sp)
    8000695c:	00013403          	ld	s0,0(sp)
    80006960:	01010113          	addi	sp,sp,16
    80006964:	00008067          	ret

0000000080006968 <_ZN16ProducerKeyboard3runEv>:
    void run() override {
    80006968:	ff010113          	addi	sp,sp,-16
    8000696c:	00113423          	sd	ra,8(sp)
    80006970:	00813023          	sd	s0,0(sp)
    80006974:	01010413          	addi	s0,sp,16
        producerKeyboard(td);
    80006978:	02053583          	ld	a1,32(a0)
    8000697c:	00000097          	auipc	ra,0x0
    80006980:	8b4080e7          	jalr	-1868(ra) # 80006230 <_ZN16ProducerKeyboard16producerKeyboardEPv>
    }
    80006984:	00813083          	ld	ra,8(sp)
    80006988:	00013403          	ld	s0,0(sp)
    8000698c:	01010113          	addi	sp,sp,16
    80006990:	00008067          	ret

0000000080006994 <_ZN12ProducerSync3runEv>:
    void run() override {
    80006994:	ff010113          	addi	sp,sp,-16
    80006998:	00113423          	sd	ra,8(sp)
    8000699c:	00813023          	sd	s0,0(sp)
    800069a0:	01010413          	addi	s0,sp,16
        producer(td);
    800069a4:	02053583          	ld	a1,32(a0)
    800069a8:	00000097          	auipc	ra,0x0
    800069ac:	94c080e7          	jalr	-1716(ra) # 800062f4 <_ZN12ProducerSync8producerEPv>
    }
    800069b0:	00813083          	ld	ra,8(sp)
    800069b4:	00013403          	ld	s0,0(sp)
    800069b8:	01010113          	addi	sp,sp,16
    800069bc:	00008067          	ret

00000000800069c0 <_ZN12ConsumerSync3runEv>:
    void run() override {
    800069c0:	ff010113          	addi	sp,sp,-16
    800069c4:	00113423          	sd	ra,8(sp)
    800069c8:	00813023          	sd	s0,0(sp)
    800069cc:	01010413          	addi	s0,sp,16
        consumer(td);
    800069d0:	02053583          	ld	a1,32(a0)
    800069d4:	00000097          	auipc	ra,0x0
    800069d8:	9b8080e7          	jalr	-1608(ra) # 8000638c <_ZN12ConsumerSync8consumerEPv>
    }
    800069dc:	00813083          	ld	ra,8(sp)
    800069e0:	00013403          	ld	s0,0(sp)
    800069e4:	01010113          	addi	sp,sp,16
    800069e8:	00008067          	ret

00000000800069ec <_ZN9BufferCPPC1Ei>:
#include "buffer_CPP_API.hpp"

BufferCPP::BufferCPP(int _cap) : cap(_cap + 1), head(0), tail(0) {
    800069ec:	fd010113          	addi	sp,sp,-48
    800069f0:	02113423          	sd	ra,40(sp)
    800069f4:	02813023          	sd	s0,32(sp)
    800069f8:	00913c23          	sd	s1,24(sp)
    800069fc:	01213823          	sd	s2,16(sp)
    80006a00:	01313423          	sd	s3,8(sp)
    80006a04:	03010413          	addi	s0,sp,48
    80006a08:	00050493          	mv	s1,a0
    80006a0c:	00058993          	mv	s3,a1
    80006a10:	0015879b          	addiw	a5,a1,1
    80006a14:	0007851b          	sext.w	a0,a5
    80006a18:	00f4a023          	sw	a5,0(s1)
    80006a1c:	0004a823          	sw	zero,16(s1)
    80006a20:	0004aa23          	sw	zero,20(s1)
    buffer = (int *)mem_alloc(sizeof(int) * cap);
    80006a24:	00251513          	slli	a0,a0,0x2
    80006a28:	ffffb097          	auipc	ra,0xffffb
    80006a2c:	858080e7          	jalr	-1960(ra) # 80001280 <_Z9mem_allocm>
    80006a30:	00a4b423          	sd	a0,8(s1)
    itemAvailable = new Semaphore(0);
    80006a34:	01000513          	li	a0,16
    80006a38:	ffffc097          	auipc	ra,0xffffc
    80006a3c:	38c080e7          	jalr	908(ra) # 80002dc4 <_Znwm>
    80006a40:	00050913          	mv	s2,a0
        Semaphore (unsigned init = 1){
    80006a44:	00006797          	auipc	a5,0x6
    80006a48:	09c78793          	addi	a5,a5,156 # 8000cae0 <_ZTV9Semaphore+0x10>
    80006a4c:	00f53023          	sd	a5,0(a0)
            sem_open(&myHandle,init);
    80006a50:	00000593          	li	a1,0
    80006a54:	00850513          	addi	a0,a0,8
    80006a58:	ffffb097          	auipc	ra,0xffffb
    80006a5c:	9e4080e7          	jalr	-1564(ra) # 8000143c <_Z8sem_openPP5sem_sj>
    80006a60:	0324b023          	sd	s2,32(s1)
    spaceAvailable = new Semaphore(_cap);
    80006a64:	01000513          	li	a0,16
    80006a68:	ffffc097          	auipc	ra,0xffffc
    80006a6c:	35c080e7          	jalr	860(ra) # 80002dc4 <_Znwm>
    80006a70:	00050913          	mv	s2,a0
        Semaphore (unsigned init = 1){
    80006a74:	00006797          	auipc	a5,0x6
    80006a78:	06c78793          	addi	a5,a5,108 # 8000cae0 <_ZTV9Semaphore+0x10>
    80006a7c:	00f53023          	sd	a5,0(a0)
            sem_open(&myHandle,init);
    80006a80:	00098593          	mv	a1,s3
    80006a84:	00850513          	addi	a0,a0,8
    80006a88:	ffffb097          	auipc	ra,0xffffb
    80006a8c:	9b4080e7          	jalr	-1612(ra) # 8000143c <_Z8sem_openPP5sem_sj>
    80006a90:	0124bc23          	sd	s2,24(s1)
    mutexHead = new Semaphore(1);
    80006a94:	01000513          	li	a0,16
    80006a98:	ffffc097          	auipc	ra,0xffffc
    80006a9c:	32c080e7          	jalr	812(ra) # 80002dc4 <_Znwm>
    80006aa0:	00050913          	mv	s2,a0
        Semaphore (unsigned init = 1){
    80006aa4:	00006797          	auipc	a5,0x6
    80006aa8:	03c78793          	addi	a5,a5,60 # 8000cae0 <_ZTV9Semaphore+0x10>
    80006aac:	00f53023          	sd	a5,0(a0)
            sem_open(&myHandle,init);
    80006ab0:	00100593          	li	a1,1
    80006ab4:	00850513          	addi	a0,a0,8
    80006ab8:	ffffb097          	auipc	ra,0xffffb
    80006abc:	984080e7          	jalr	-1660(ra) # 8000143c <_Z8sem_openPP5sem_sj>
    80006ac0:	0324b423          	sd	s2,40(s1)
    mutexTail = new Semaphore(1);
    80006ac4:	01000513          	li	a0,16
    80006ac8:	ffffc097          	auipc	ra,0xffffc
    80006acc:	2fc080e7          	jalr	764(ra) # 80002dc4 <_Znwm>
    80006ad0:	00050913          	mv	s2,a0
        Semaphore (unsigned init = 1){
    80006ad4:	00006797          	auipc	a5,0x6
    80006ad8:	00c78793          	addi	a5,a5,12 # 8000cae0 <_ZTV9Semaphore+0x10>
    80006adc:	00f53023          	sd	a5,0(a0)
            sem_open(&myHandle,init);
    80006ae0:	00100593          	li	a1,1
    80006ae4:	00850513          	addi	a0,a0,8
    80006ae8:	ffffb097          	auipc	ra,0xffffb
    80006aec:	954080e7          	jalr	-1708(ra) # 8000143c <_Z8sem_openPP5sem_sj>
    80006af0:	0324b823          	sd	s2,48(s1)
}
    80006af4:	02813083          	ld	ra,40(sp)
    80006af8:	02013403          	ld	s0,32(sp)
    80006afc:	01813483          	ld	s1,24(sp)
    80006b00:	01013903          	ld	s2,16(sp)
    80006b04:	00813983          	ld	s3,8(sp)
    80006b08:	03010113          	addi	sp,sp,48
    80006b0c:	00008067          	ret
    80006b10:	00050493          	mv	s1,a0
    itemAvailable = new Semaphore(0);
    80006b14:	00090513          	mv	a0,s2
    80006b18:	ffffc097          	auipc	ra,0xffffc
    80006b1c:	2d4080e7          	jalr	724(ra) # 80002dec <_ZdlPv>
    80006b20:	00048513          	mv	a0,s1
    80006b24:	0000a097          	auipc	ra,0xa
    80006b28:	764080e7          	jalr	1892(ra) # 80011288 <_Unwind_Resume>
    80006b2c:	00050493          	mv	s1,a0
    spaceAvailable = new Semaphore(_cap);
    80006b30:	00090513          	mv	a0,s2
    80006b34:	ffffc097          	auipc	ra,0xffffc
    80006b38:	2b8080e7          	jalr	696(ra) # 80002dec <_ZdlPv>
    80006b3c:	00048513          	mv	a0,s1
    80006b40:	0000a097          	auipc	ra,0xa
    80006b44:	748080e7          	jalr	1864(ra) # 80011288 <_Unwind_Resume>
    80006b48:	00050493          	mv	s1,a0
    mutexHead = new Semaphore(1);
    80006b4c:	00090513          	mv	a0,s2
    80006b50:	ffffc097          	auipc	ra,0xffffc
    80006b54:	29c080e7          	jalr	668(ra) # 80002dec <_ZdlPv>
    80006b58:	00048513          	mv	a0,s1
    80006b5c:	0000a097          	auipc	ra,0xa
    80006b60:	72c080e7          	jalr	1836(ra) # 80011288 <_Unwind_Resume>
    80006b64:	00050493          	mv	s1,a0
    mutexTail = new Semaphore(1);
    80006b68:	00090513          	mv	a0,s2
    80006b6c:	ffffc097          	auipc	ra,0xffffc
    80006b70:	280080e7          	jalr	640(ra) # 80002dec <_ZdlPv>
    80006b74:	00048513          	mv	a0,s1
    80006b78:	0000a097          	auipc	ra,0xa
    80006b7c:	710080e7          	jalr	1808(ra) # 80011288 <_Unwind_Resume>

0000000080006b80 <_ZN9BufferCPP3putEi>:
    delete mutexTail;
    delete mutexHead;

}

void BufferCPP::put(int val) {
    80006b80:	fe010113          	addi	sp,sp,-32
    80006b84:	00113c23          	sd	ra,24(sp)
    80006b88:	00813823          	sd	s0,16(sp)
    80006b8c:	00913423          	sd	s1,8(sp)
    80006b90:	01213023          	sd	s2,0(sp)
    80006b94:	02010413          	addi	s0,sp,32
    80006b98:	00050493          	mv	s1,a0
    80006b9c:	00058913          	mv	s2,a1
    spaceAvailable->wait();
    80006ba0:	01853783          	ld	a5,24(a0)
            return sem_wait(myHandle);
    80006ba4:	0087b503          	ld	a0,8(a5)
    80006ba8:	ffffb097          	auipc	ra,0xffffb
    80006bac:	918080e7          	jalr	-1768(ra) # 800014c0 <_Z8sem_waitP5sem_s>

    mutexTail->wait();
    80006bb0:	0304b783          	ld	a5,48(s1)
    80006bb4:	0087b503          	ld	a0,8(a5)
    80006bb8:	ffffb097          	auipc	ra,0xffffb
    80006bbc:	908080e7          	jalr	-1784(ra) # 800014c0 <_Z8sem_waitP5sem_s>
    buffer[tail] = val;
    80006bc0:	0084b783          	ld	a5,8(s1)
    80006bc4:	0144a703          	lw	a4,20(s1)
    80006bc8:	00271713          	slli	a4,a4,0x2
    80006bcc:	00e787b3          	add	a5,a5,a4
    80006bd0:	0127a023          	sw	s2,0(a5)
    tail = (tail + 1) % cap;
    80006bd4:	0144a783          	lw	a5,20(s1)
    80006bd8:	0017879b          	addiw	a5,a5,1
    80006bdc:	0004a703          	lw	a4,0(s1)
    80006be0:	02e7e7bb          	remw	a5,a5,a4
    80006be4:	00f4aa23          	sw	a5,20(s1)
    mutexTail->signal();
    80006be8:	0304b783          	ld	a5,48(s1)
            return sem_signal(myHandle);
    80006bec:	0087b503          	ld	a0,8(a5)
    80006bf0:	ffffb097          	auipc	ra,0xffffb
    80006bf4:	910080e7          	jalr	-1776(ra) # 80001500 <_Z10sem_signalP5sem_s>

    itemAvailable->signal();
    80006bf8:	0204b783          	ld	a5,32(s1)
    80006bfc:	0087b503          	ld	a0,8(a5)
    80006c00:	ffffb097          	auipc	ra,0xffffb
    80006c04:	900080e7          	jalr	-1792(ra) # 80001500 <_Z10sem_signalP5sem_s>

}
    80006c08:	01813083          	ld	ra,24(sp)
    80006c0c:	01013403          	ld	s0,16(sp)
    80006c10:	00813483          	ld	s1,8(sp)
    80006c14:	00013903          	ld	s2,0(sp)
    80006c18:	02010113          	addi	sp,sp,32
    80006c1c:	00008067          	ret

0000000080006c20 <_ZN9BufferCPP3getEv>:

int BufferCPP::get() {
    80006c20:	fe010113          	addi	sp,sp,-32
    80006c24:	00113c23          	sd	ra,24(sp)
    80006c28:	00813823          	sd	s0,16(sp)
    80006c2c:	00913423          	sd	s1,8(sp)
    80006c30:	01213023          	sd	s2,0(sp)
    80006c34:	02010413          	addi	s0,sp,32
    80006c38:	00050493          	mv	s1,a0
    itemAvailable->wait();
    80006c3c:	02053783          	ld	a5,32(a0)
            return sem_wait(myHandle);
    80006c40:	0087b503          	ld	a0,8(a5)
    80006c44:	ffffb097          	auipc	ra,0xffffb
    80006c48:	87c080e7          	jalr	-1924(ra) # 800014c0 <_Z8sem_waitP5sem_s>

    mutexHead->wait();
    80006c4c:	0284b783          	ld	a5,40(s1)
    80006c50:	0087b503          	ld	a0,8(a5)
    80006c54:	ffffb097          	auipc	ra,0xffffb
    80006c58:	86c080e7          	jalr	-1940(ra) # 800014c0 <_Z8sem_waitP5sem_s>

    int ret = buffer[head];
    80006c5c:	0084b703          	ld	a4,8(s1)
    80006c60:	0104a783          	lw	a5,16(s1)
    80006c64:	00279693          	slli	a3,a5,0x2
    80006c68:	00d70733          	add	a4,a4,a3
    80006c6c:	00072903          	lw	s2,0(a4)
    head = (head + 1) % cap;
    80006c70:	0017879b          	addiw	a5,a5,1
    80006c74:	0004a703          	lw	a4,0(s1)
    80006c78:	02e7e7bb          	remw	a5,a5,a4
    80006c7c:	00f4a823          	sw	a5,16(s1)
    mutexHead->signal();
    80006c80:	0284b783          	ld	a5,40(s1)
            return sem_signal(myHandle);
    80006c84:	0087b503          	ld	a0,8(a5)
    80006c88:	ffffb097          	auipc	ra,0xffffb
    80006c8c:	878080e7          	jalr	-1928(ra) # 80001500 <_Z10sem_signalP5sem_s>

    spaceAvailable->signal();
    80006c90:	0184b783          	ld	a5,24(s1)
    80006c94:	0087b503          	ld	a0,8(a5)
    80006c98:	ffffb097          	auipc	ra,0xffffb
    80006c9c:	868080e7          	jalr	-1944(ra) # 80001500 <_Z10sem_signalP5sem_s>

    return ret;
}
    80006ca0:	00090513          	mv	a0,s2
    80006ca4:	01813083          	ld	ra,24(sp)
    80006ca8:	01013403          	ld	s0,16(sp)
    80006cac:	00813483          	ld	s1,8(sp)
    80006cb0:	00013903          	ld	s2,0(sp)
    80006cb4:	02010113          	addi	sp,sp,32
    80006cb8:	00008067          	ret

0000000080006cbc <_ZN9BufferCPP6getCntEv>:

int BufferCPP::getCnt() {
    80006cbc:	fe010113          	addi	sp,sp,-32
    80006cc0:	00113c23          	sd	ra,24(sp)
    80006cc4:	00813823          	sd	s0,16(sp)
    80006cc8:	00913423          	sd	s1,8(sp)
    80006ccc:	01213023          	sd	s2,0(sp)
    80006cd0:	02010413          	addi	s0,sp,32
    80006cd4:	00050493          	mv	s1,a0
    int ret;

    mutexHead->wait();
    80006cd8:	02853783          	ld	a5,40(a0)
            return sem_wait(myHandle);
    80006cdc:	0087b503          	ld	a0,8(a5)
    80006ce0:	ffffa097          	auipc	ra,0xffffa
    80006ce4:	7e0080e7          	jalr	2016(ra) # 800014c0 <_Z8sem_waitP5sem_s>
    mutexTail->wait();
    80006ce8:	0304b783          	ld	a5,48(s1)
    80006cec:	0087b503          	ld	a0,8(a5)
    80006cf0:	ffffa097          	auipc	ra,0xffffa
    80006cf4:	7d0080e7          	jalr	2000(ra) # 800014c0 <_Z8sem_waitP5sem_s>

    if (tail >= head) {
    80006cf8:	0144a783          	lw	a5,20(s1)
    80006cfc:	0104a903          	lw	s2,16(s1)
    80006d00:	0527c263          	blt	a5,s2,80006d44 <_ZN9BufferCPP6getCntEv+0x88>
        ret = tail - head;
    80006d04:	4127893b          	subw	s2,a5,s2
    } else {
        ret = cap - head + tail;
    }

    mutexTail->signal();
    80006d08:	0304b783          	ld	a5,48(s1)
            return sem_signal(myHandle);
    80006d0c:	0087b503          	ld	a0,8(a5)
    80006d10:	ffffa097          	auipc	ra,0xffffa
    80006d14:	7f0080e7          	jalr	2032(ra) # 80001500 <_Z10sem_signalP5sem_s>
    mutexHead->signal();
    80006d18:	0284b783          	ld	a5,40(s1)
    80006d1c:	0087b503          	ld	a0,8(a5)
    80006d20:	ffffa097          	auipc	ra,0xffffa
    80006d24:	7e0080e7          	jalr	2016(ra) # 80001500 <_Z10sem_signalP5sem_s>

    return ret;
}
    80006d28:	00090513          	mv	a0,s2
    80006d2c:	01813083          	ld	ra,24(sp)
    80006d30:	01013403          	ld	s0,16(sp)
    80006d34:	00813483          	ld	s1,8(sp)
    80006d38:	00013903          	ld	s2,0(sp)
    80006d3c:	02010113          	addi	sp,sp,32
    80006d40:	00008067          	ret
        ret = cap - head + tail;
    80006d44:	0004a703          	lw	a4,0(s1)
    80006d48:	4127093b          	subw	s2,a4,s2
    80006d4c:	00f9093b          	addw	s2,s2,a5
    80006d50:	fb9ff06f          	j	80006d08 <_ZN9BufferCPP6getCntEv+0x4c>

0000000080006d54 <_ZN9BufferCPPD1Ev>:
BufferCPP::~BufferCPP() {
    80006d54:	fe010113          	addi	sp,sp,-32
    80006d58:	00113c23          	sd	ra,24(sp)
    80006d5c:	00813823          	sd	s0,16(sp)
    80006d60:	00913423          	sd	s1,8(sp)
    80006d64:	02010413          	addi	s0,sp,32
    80006d68:	00050493          	mv	s1,a0
            ::putc(c);
    80006d6c:	00a00513          	li	a0,10
    80006d70:	ffffb097          	auipc	ra,0xffffb
    80006d74:	840080e7          	jalr	-1984(ra) # 800015b0 <_Z4putcc>
    printString("Buffer deleted!\n");
    80006d78:	00004517          	auipc	a0,0x4
    80006d7c:	86050513          	addi	a0,a0,-1952 # 8000a5d8 <CONSOLE_STATUS+0x5c8>
    80006d80:	ffffb097          	auipc	ra,0xffffb
    80006d84:	180080e7          	jalr	384(ra) # 80001f00 <_Z11printStringPKc>
    while (getCnt()) {
    80006d88:	00048513          	mv	a0,s1
    80006d8c:	00000097          	auipc	ra,0x0
    80006d90:	f30080e7          	jalr	-208(ra) # 80006cbc <_ZN9BufferCPP6getCntEv>
    80006d94:	02050c63          	beqz	a0,80006dcc <_ZN9BufferCPPD1Ev+0x78>
        char ch = buffer[head];
    80006d98:	0084b783          	ld	a5,8(s1)
    80006d9c:	0104a703          	lw	a4,16(s1)
    80006da0:	00271713          	slli	a4,a4,0x2
    80006da4:	00e787b3          	add	a5,a5,a4
    80006da8:	0007c503          	lbu	a0,0(a5)
    80006dac:	ffffb097          	auipc	ra,0xffffb
    80006db0:	804080e7          	jalr	-2044(ra) # 800015b0 <_Z4putcc>
        head = (head + 1) % cap;
    80006db4:	0104a783          	lw	a5,16(s1)
    80006db8:	0017879b          	addiw	a5,a5,1
    80006dbc:	0004a703          	lw	a4,0(s1)
    80006dc0:	02e7e7bb          	remw	a5,a5,a4
    80006dc4:	00f4a823          	sw	a5,16(s1)
    while (getCnt()) {
    80006dc8:	fc1ff06f          	j	80006d88 <_ZN9BufferCPPD1Ev+0x34>
    80006dcc:	02100513          	li	a0,33
    80006dd0:	ffffa097          	auipc	ra,0xffffa
    80006dd4:	7e0080e7          	jalr	2016(ra) # 800015b0 <_Z4putcc>
    80006dd8:	00a00513          	li	a0,10
    80006ddc:	ffffa097          	auipc	ra,0xffffa
    80006de0:	7d4080e7          	jalr	2004(ra) # 800015b0 <_Z4putcc>
    mem_free(buffer);
    80006de4:	0084b503          	ld	a0,8(s1)
    80006de8:	ffffa097          	auipc	ra,0xffffa
    80006dec:	4d8080e7          	jalr	1240(ra) # 800012c0 <_Z8mem_freePv>
    delete itemAvailable;
    80006df0:	0204b503          	ld	a0,32(s1)
    80006df4:	00050863          	beqz	a0,80006e04 <_ZN9BufferCPPD1Ev+0xb0>
    80006df8:	00053783          	ld	a5,0(a0)
    80006dfc:	0087b783          	ld	a5,8(a5)
    80006e00:	000780e7          	jalr	a5
    delete spaceAvailable;
    80006e04:	0184b503          	ld	a0,24(s1)
    80006e08:	00050863          	beqz	a0,80006e18 <_ZN9BufferCPPD1Ev+0xc4>
    80006e0c:	00053783          	ld	a5,0(a0)
    80006e10:	0087b783          	ld	a5,8(a5)
    80006e14:	000780e7          	jalr	a5
    delete mutexTail;
    80006e18:	0304b503          	ld	a0,48(s1)
    80006e1c:	00050863          	beqz	a0,80006e2c <_ZN9BufferCPPD1Ev+0xd8>
    80006e20:	00053783          	ld	a5,0(a0)
    80006e24:	0087b783          	ld	a5,8(a5)
    80006e28:	000780e7          	jalr	a5
    delete mutexHead;
    80006e2c:	0284b503          	ld	a0,40(s1)
    80006e30:	00050863          	beqz	a0,80006e40 <_ZN9BufferCPPD1Ev+0xec>
    80006e34:	00053783          	ld	a5,0(a0)
    80006e38:	0087b783          	ld	a5,8(a5)
    80006e3c:	000780e7          	jalr	a5
}
    80006e40:	01813083          	ld	ra,24(sp)
    80006e44:	01013403          	ld	s0,16(sp)
    80006e48:	00813483          	ld	s1,8(sp)
    80006e4c:	02010113          	addi	sp,sp,32
    80006e50:	00008067          	ret

0000000080006e54 <_Z8userMainv>:
#include "../test/ConsumerProducer_CPP_API_test.hpp"
#include "System_Mode_test.hpp"

#endif

void userMain() {
    80006e54:	fe010113          	addi	sp,sp,-32
    80006e58:	00113c23          	sd	ra,24(sp)
    80006e5c:	00813823          	sd	s0,16(sp)
    80006e60:	00913423          	sd	s1,8(sp)
    80006e64:	02010413          	addi	s0,sp,32
    printString("Unesite broj testa? [1-7]\n");
    80006e68:	00003517          	auipc	a0,0x3
    80006e6c:	78850513          	addi	a0,a0,1928 # 8000a5f0 <CONSOLE_STATUS+0x5e0>
    80006e70:	ffffb097          	auipc	ra,0xffffb
    80006e74:	090080e7          	jalr	144(ra) # 80001f00 <_Z11printStringPKc>
    int test = getc() - '0';
    80006e78:	ffffa097          	auipc	ra,0xffffa
    80006e7c:	6fc080e7          	jalr	1788(ra) # 80001574 <_Z4getcv>
    80006e80:	fd05049b          	addiw	s1,a0,-48
    getc(); // Enter posle broja
    80006e84:	ffffa097          	auipc	ra,0xffffa
    80006e88:	6f0080e7          	jalr	1776(ra) # 80001574 <_Z4getcv>
            printString("Nije navedeno da je zadatak 4 implementiran\n");
            return;
        }
    }

    switch (test) {
    80006e8c:	00700793          	li	a5,7
    80006e90:	1097e263          	bltu	a5,s1,80006f94 <_Z8userMainv+0x140>
    80006e94:	00249493          	slli	s1,s1,0x2
    80006e98:	00004717          	auipc	a4,0x4
    80006e9c:	9b070713          	addi	a4,a4,-1616 # 8000a848 <CONSOLE_STATUS+0x838>
    80006ea0:	00e484b3          	add	s1,s1,a4
    80006ea4:	0004a783          	lw	a5,0(s1)
    80006ea8:	00e787b3          	add	a5,a5,a4
    80006eac:	00078067          	jr	a5
        case 1:
#if LEVEL_2_IMPLEMENTED == 1
            Threads_C_API_test();
    80006eb0:	fffff097          	auipc	ra,0xfffff
    80006eb4:	284080e7          	jalr	644(ra) # 80006134 <_Z18Threads_C_API_testv>
            printString("TEST 1 (zadatak 2, niti C API i sinhrona promena konteksta)\n");
    80006eb8:	00003517          	auipc	a0,0x3
    80006ebc:	75850513          	addi	a0,a0,1880 # 8000a610 <CONSOLE_STATUS+0x600>
    80006ec0:	ffffb097          	auipc	ra,0xffffb
    80006ec4:	040080e7          	jalr	64(ra) # 80001f00 <_Z11printStringPKc>
#endif
            break;
        default:
            printString("Niste uneli odgovarajuci broj za test\n");
    }
    80006ec8:	01813083          	ld	ra,24(sp)
    80006ecc:	01013403          	ld	s0,16(sp)
    80006ed0:	00813483          	ld	s1,8(sp)
    80006ed4:	02010113          	addi	sp,sp,32
    80006ed8:	00008067          	ret
            Threads_CPP_API_test();
    80006edc:	ffffe097          	auipc	ra,0xffffe
    80006ee0:	2b8080e7          	jalr	696(ra) # 80005194 <_Z20Threads_CPP_API_testv>
            printString("TEST 2 (zadatak 2., niti CPP API i sinhrona promena konteksta)\n");
    80006ee4:	00003517          	auipc	a0,0x3
    80006ee8:	76c50513          	addi	a0,a0,1900 # 8000a650 <CONSOLE_STATUS+0x640>
    80006eec:	ffffb097          	auipc	ra,0xffffb
    80006ef0:	014080e7          	jalr	20(ra) # 80001f00 <_Z11printStringPKc>
            break;
    80006ef4:	fd5ff06f          	j	80006ec8 <_Z8userMainv+0x74>
            producerConsumer_C_API();
    80006ef8:	ffffe097          	auipc	ra,0xffffe
    80006efc:	af0080e7          	jalr	-1296(ra) # 800049e8 <_Z22producerConsumer_C_APIv>
            printString("TEST 3 (zadatak 3., kompletan C API sa semaforima, sinhrona promena konteksta)\n");
    80006f00:	00003517          	auipc	a0,0x3
    80006f04:	79050513          	addi	a0,a0,1936 # 8000a690 <CONSOLE_STATUS+0x680>
    80006f08:	ffffb097          	auipc	ra,0xffffb
    80006f0c:	ff8080e7          	jalr	-8(ra) # 80001f00 <_Z11printStringPKc>
            break;
    80006f10:	fb9ff06f          	j	80006ec8 <_Z8userMainv+0x74>
            producerConsumer_CPP_Sync_API();
    80006f14:	fffff097          	auipc	ra,0xfffff
    80006f18:	570080e7          	jalr	1392(ra) # 80006484 <_Z29producerConsumer_CPP_Sync_APIv>
            printString("TEST 4 (zadatak 3., kompletan CPP API sa semaforima, sinhrona promena konteksta)\n");
    80006f1c:	00003517          	auipc	a0,0x3
    80006f20:	7c450513          	addi	a0,a0,1988 # 8000a6e0 <CONSOLE_STATUS+0x6d0>
    80006f24:	ffffb097          	auipc	ra,0xffffb
    80006f28:	fdc080e7          	jalr	-36(ra) # 80001f00 <_Z11printStringPKc>
            break;
    80006f2c:	f9dff06f          	j	80006ec8 <_Z8userMainv+0x74>
            testSleeping();
    80006f30:	00000097          	auipc	ra,0x0
    80006f34:	11c080e7          	jalr	284(ra) # 8000704c <_Z12testSleepingv>
            printString("TEST 5 (zadatak 4., thread_sleep test C API)\n");
    80006f38:	00004517          	auipc	a0,0x4
    80006f3c:	80050513          	addi	a0,a0,-2048 # 8000a738 <CONSOLE_STATUS+0x728>
    80006f40:	ffffb097          	auipc	ra,0xffffb
    80006f44:	fc0080e7          	jalr	-64(ra) # 80001f00 <_Z11printStringPKc>
            break;
    80006f48:	f81ff06f          	j	80006ec8 <_Z8userMainv+0x74>
            testConsumerProducer();
    80006f4c:	ffffe097          	auipc	ra,0xffffe
    80006f50:	5ac080e7          	jalr	1452(ra) # 800054f8 <_Z20testConsumerProducerv>
            printString("TEST 6 (zadatak 4. CPP API i asinhrona promena konteksta)\n");
    80006f54:	00004517          	auipc	a0,0x4
    80006f58:	81450513          	addi	a0,a0,-2028 # 8000a768 <CONSOLE_STATUS+0x758>
    80006f5c:	ffffb097          	auipc	ra,0xffffb
    80006f60:	fa4080e7          	jalr	-92(ra) # 80001f00 <_Z11printStringPKc>
            break;
    80006f64:	f65ff06f          	j	80006ec8 <_Z8userMainv+0x74>
            System_Mode_test();
    80006f68:	00000097          	auipc	ra,0x0
    80006f6c:	658080e7          	jalr	1624(ra) # 800075c0 <_Z16System_Mode_testv>
            printString("Test se nije uspesno zavrsio\n");
    80006f70:	00004517          	auipc	a0,0x4
    80006f74:	83850513          	addi	a0,a0,-1992 # 8000a7a8 <CONSOLE_STATUS+0x798>
    80006f78:	ffffb097          	auipc	ra,0xffffb
    80006f7c:	f88080e7          	jalr	-120(ra) # 80001f00 <_Z11printStringPKc>
            printString("TEST 7 (zadatak 2., testiranje da li se korisnicki kod izvrsava u korisnickom rezimu)\n");
    80006f80:	00004517          	auipc	a0,0x4
    80006f84:	84850513          	addi	a0,a0,-1976 # 8000a7c8 <CONSOLE_STATUS+0x7b8>
    80006f88:	ffffb097          	auipc	ra,0xffffb
    80006f8c:	f78080e7          	jalr	-136(ra) # 80001f00 <_Z11printStringPKc>
            break;
    80006f90:	f39ff06f          	j	80006ec8 <_Z8userMainv+0x74>
            printString("Niste uneli odgovarajuci broj za test\n");
    80006f94:	00004517          	auipc	a0,0x4
    80006f98:	88c50513          	addi	a0,a0,-1908 # 8000a820 <CONSOLE_STATUS+0x810>
    80006f9c:	ffffb097          	auipc	ra,0xffffb
    80006fa0:	f64080e7          	jalr	-156(ra) # 80001f00 <_Z11printStringPKc>
    80006fa4:	f25ff06f          	j	80006ec8 <_Z8userMainv+0x74>

0000000080006fa8 <_ZL9sleepyRunPv>:

#include "../h/printing.hpp"

static volatile bool finished[2];

static void sleepyRun(void *arg) {
    80006fa8:	fe010113          	addi	sp,sp,-32
    80006fac:	00113c23          	sd	ra,24(sp)
    80006fb0:	00813823          	sd	s0,16(sp)
    80006fb4:	00913423          	sd	s1,8(sp)
    80006fb8:	01213023          	sd	s2,0(sp)
    80006fbc:	02010413          	addi	s0,sp,32
    uint64 sleep_time = *((uint64 *) arg);
    80006fc0:	00053903          	ld	s2,0(a0)
    int i = 6;
    80006fc4:	00600493          	li	s1,6
    while (--i > 0) {
    80006fc8:	fff4849b          	addiw	s1,s1,-1
    80006fcc:	04905463          	blez	s1,80007014 <_ZL9sleepyRunPv+0x6c>

        printString("Hello ");
    80006fd0:	00004517          	auipc	a0,0x4
    80006fd4:	89850513          	addi	a0,a0,-1896 # 8000a868 <CONSOLE_STATUS+0x858>
    80006fd8:	ffffb097          	auipc	ra,0xffffb
    80006fdc:	f28080e7          	jalr	-216(ra) # 80001f00 <_Z11printStringPKc>
        printInt(sleep_time);
    80006fe0:	00000613          	li	a2,0
    80006fe4:	00a00593          	li	a1,10
    80006fe8:	0009051b          	sext.w	a0,s2
    80006fec:	ffffb097          	auipc	ra,0xffffb
    80006ff0:	0c4080e7          	jalr	196(ra) # 800020b0 <_Z8printIntiii>
        printString(" !\n");
    80006ff4:	00004517          	auipc	a0,0x4
    80006ff8:	87c50513          	addi	a0,a0,-1924 # 8000a870 <CONSOLE_STATUS+0x860>
    80006ffc:	ffffb097          	auipc	ra,0xffffb
    80007000:	f04080e7          	jalr	-252(ra) # 80001f00 <_Z11printStringPKc>
        time_sleep(sleep_time);
    80007004:	00090513          	mv	a0,s2
    80007008:	ffffa097          	auipc	ra,0xffffa
    8000700c:	538080e7          	jalr	1336(ra) # 80001540 <_Z10time_sleepm>
    while (--i > 0) {
    80007010:	fb9ff06f          	j	80006fc8 <_ZL9sleepyRunPv+0x20>
    }
    finished[sleep_time/10-1] = true;
    80007014:	00a00793          	li	a5,10
    80007018:	02f95933          	divu	s2,s2,a5
    8000701c:	fff90913          	addi	s2,s2,-1
    80007020:	00009797          	auipc	a5,0x9
    80007024:	19878793          	addi	a5,a5,408 # 800101b8 <_ZL8finished>
    80007028:	01278933          	add	s2,a5,s2
    8000702c:	00100793          	li	a5,1
    80007030:	00f90023          	sb	a5,0(s2)
}
    80007034:	01813083          	ld	ra,24(sp)
    80007038:	01013403          	ld	s0,16(sp)
    8000703c:	00813483          	ld	s1,8(sp)
    80007040:	00013903          	ld	s2,0(sp)
    80007044:	02010113          	addi	sp,sp,32
    80007048:	00008067          	ret

000000008000704c <_Z12testSleepingv>:

void testSleeping() {
    8000704c:	fc010113          	addi	sp,sp,-64
    80007050:	02113c23          	sd	ra,56(sp)
    80007054:	02813823          	sd	s0,48(sp)
    80007058:	02913423          	sd	s1,40(sp)
    8000705c:	04010413          	addi	s0,sp,64
    const int sleepy_thread_count = 2;
    uint64 sleep_times[sleepy_thread_count] = {10, 20};
    80007060:	00a00793          	li	a5,10
    80007064:	fcf43823          	sd	a5,-48(s0)
    80007068:	01400793          	li	a5,20
    8000706c:	fcf43c23          	sd	a5,-40(s0)
    thread_t sleepyThread[sleepy_thread_count];

    for (int i = 0; i < sleepy_thread_count; i++) {
    80007070:	00000493          	li	s1,0
    80007074:	02c0006f          	j	800070a0 <_Z12testSleepingv+0x54>
        thread_create(&sleepyThread[i], sleepyRun, sleep_times + i);
    80007078:	00349793          	slli	a5,s1,0x3
    8000707c:	fd040613          	addi	a2,s0,-48
    80007080:	00f60633          	add	a2,a2,a5
    80007084:	00000597          	auipc	a1,0x0
    80007088:	f2458593          	addi	a1,a1,-220 # 80006fa8 <_ZL9sleepyRunPv>
    8000708c:	fc040513          	addi	a0,s0,-64
    80007090:	00f50533          	add	a0,a0,a5
    80007094:	ffffa097          	auipc	ra,0xffffa
    80007098:	26c080e7          	jalr	620(ra) # 80001300 <_Z13thread_createPP8thread_sPFvPvES2_>
    for (int i = 0; i < sleepy_thread_count; i++) {
    8000709c:	0014849b          	addiw	s1,s1,1
    800070a0:	00100793          	li	a5,1
    800070a4:	fc97dae3          	bge	a5,s1,80007078 <_Z12testSleepingv+0x2c>
    }

    while (!(finished[0] && finished[1])) {}
    800070a8:	00009797          	auipc	a5,0x9
    800070ac:	1107c783          	lbu	a5,272(a5) # 800101b8 <_ZL8finished>
    800070b0:	fe078ce3          	beqz	a5,800070a8 <_Z12testSleepingv+0x5c>
    800070b4:	00009797          	auipc	a5,0x9
    800070b8:	1057c783          	lbu	a5,261(a5) # 800101b9 <_ZL8finished+0x1>
    800070bc:	fe0786e3          	beqz	a5,800070a8 <_Z12testSleepingv+0x5c>
}
    800070c0:	03813083          	ld	ra,56(sp)
    800070c4:	03013403          	ld	s0,48(sp)
    800070c8:	02813483          	ld	s1,40(sp)
    800070cc:	04010113          	addi	sp,sp,64
    800070d0:	00008067          	ret

00000000800070d4 <_ZL9fibonaccim>:
static volatile bool finishedA = false;
static volatile bool finishedB = false;
static volatile bool finishedC = false;
static volatile bool finishedD = false;

static uint64 fibonacci(uint64 n) {
    800070d4:	fe010113          	addi	sp,sp,-32
    800070d8:	00113c23          	sd	ra,24(sp)
    800070dc:	00813823          	sd	s0,16(sp)
    800070e0:	00913423          	sd	s1,8(sp)
    800070e4:	01213023          	sd	s2,0(sp)
    800070e8:	02010413          	addi	s0,sp,32
    800070ec:	00050493          	mv	s1,a0
    if (n == 0 || n == 1) { return n; }
    800070f0:	00100793          	li	a5,1
    800070f4:	02a7f863          	bgeu	a5,a0,80007124 <_ZL9fibonaccim+0x50>
    if (n % 10 == 0) { thread_dispatch(); }
    800070f8:	00a00793          	li	a5,10
    800070fc:	02f577b3          	remu	a5,a0,a5
    80007100:	02078e63          	beqz	a5,8000713c <_ZL9fibonaccim+0x68>
    return fibonacci(n - 1) + fibonacci(n - 2);
    80007104:	fff48513          	addi	a0,s1,-1
    80007108:	00000097          	auipc	ra,0x0
    8000710c:	fcc080e7          	jalr	-52(ra) # 800070d4 <_ZL9fibonaccim>
    80007110:	00050913          	mv	s2,a0
    80007114:	ffe48513          	addi	a0,s1,-2
    80007118:	00000097          	auipc	ra,0x0
    8000711c:	fbc080e7          	jalr	-68(ra) # 800070d4 <_ZL9fibonaccim>
    80007120:	00a90533          	add	a0,s2,a0
}
    80007124:	01813083          	ld	ra,24(sp)
    80007128:	01013403          	ld	s0,16(sp)
    8000712c:	00813483          	ld	s1,8(sp)
    80007130:	00013903          	ld	s2,0(sp)
    80007134:	02010113          	addi	sp,sp,32
    80007138:	00008067          	ret
    if (n % 10 == 0) { thread_dispatch(); }
    8000713c:	ffffa097          	auipc	ra,0xffffa
    80007140:	24c080e7          	jalr	588(ra) # 80001388 <_Z15thread_dispatchv>
    80007144:	fc1ff06f          	j	80007104 <_ZL9fibonaccim+0x30>

0000000080007148 <_ZL11workerBodyDPv>:
    printString("A finished!\n");
    finishedC = true;
    thread_dispatch();
}

static void workerBodyD(void* arg) {
    80007148:	fe010113          	addi	sp,sp,-32
    8000714c:	00113c23          	sd	ra,24(sp)
    80007150:	00813823          	sd	s0,16(sp)
    80007154:	00913423          	sd	s1,8(sp)
    80007158:	01213023          	sd	s2,0(sp)
    8000715c:	02010413          	addi	s0,sp,32
    uint8 i = 10;
    80007160:	00a00493          	li	s1,10
    80007164:	0400006f          	j	800071a4 <_ZL11workerBodyDPv+0x5c>
    for (; i < 13; i++) {
        printString("D: i="); printInt(i); printString("\n");
    80007168:	00003517          	auipc	a0,0x3
    8000716c:	3d850513          	addi	a0,a0,984 # 8000a540 <CONSOLE_STATUS+0x530>
    80007170:	ffffb097          	auipc	ra,0xffffb
    80007174:	d90080e7          	jalr	-624(ra) # 80001f00 <_Z11printStringPKc>
    80007178:	00000613          	li	a2,0
    8000717c:	00a00593          	li	a1,10
    80007180:	00048513          	mv	a0,s1
    80007184:	ffffb097          	auipc	ra,0xffffb
    80007188:	f2c080e7          	jalr	-212(ra) # 800020b0 <_Z8printIntiii>
    8000718c:	00003517          	auipc	a0,0x3
    80007190:	5a450513          	addi	a0,a0,1444 # 8000a730 <CONSOLE_STATUS+0x720>
    80007194:	ffffb097          	auipc	ra,0xffffb
    80007198:	d6c080e7          	jalr	-660(ra) # 80001f00 <_Z11printStringPKc>
    for (; i < 13; i++) {
    8000719c:	0014849b          	addiw	s1,s1,1
    800071a0:	0ff4f493          	andi	s1,s1,255
    800071a4:	00c00793          	li	a5,12
    800071a8:	fc97f0e3          	bgeu	a5,s1,80007168 <_ZL11workerBodyDPv+0x20>
    }

    printString("D: dispatch\n");
    800071ac:	00003517          	auipc	a0,0x3
    800071b0:	39c50513          	addi	a0,a0,924 # 8000a548 <CONSOLE_STATUS+0x538>
    800071b4:	ffffb097          	auipc	ra,0xffffb
    800071b8:	d4c080e7          	jalr	-692(ra) # 80001f00 <_Z11printStringPKc>
    __asm__ ("li t1, 5");
    800071bc:	00500313          	li	t1,5
    thread_dispatch();
    800071c0:	ffffa097          	auipc	ra,0xffffa
    800071c4:	1c8080e7          	jalr	456(ra) # 80001388 <_Z15thread_dispatchv>

    uint64 result = fibonacci(16);
    800071c8:	01000513          	li	a0,16
    800071cc:	00000097          	auipc	ra,0x0
    800071d0:	f08080e7          	jalr	-248(ra) # 800070d4 <_ZL9fibonaccim>
    800071d4:	00050913          	mv	s2,a0
    printString("D: fibonaci="); printInt(result); printString("\n");
    800071d8:	00003517          	auipc	a0,0x3
    800071dc:	38050513          	addi	a0,a0,896 # 8000a558 <CONSOLE_STATUS+0x548>
    800071e0:	ffffb097          	auipc	ra,0xffffb
    800071e4:	d20080e7          	jalr	-736(ra) # 80001f00 <_Z11printStringPKc>
    800071e8:	00000613          	li	a2,0
    800071ec:	00a00593          	li	a1,10
    800071f0:	0009051b          	sext.w	a0,s2
    800071f4:	ffffb097          	auipc	ra,0xffffb
    800071f8:	ebc080e7          	jalr	-324(ra) # 800020b0 <_Z8printIntiii>
    800071fc:	00003517          	auipc	a0,0x3
    80007200:	53450513          	addi	a0,a0,1332 # 8000a730 <CONSOLE_STATUS+0x720>
    80007204:	ffffb097          	auipc	ra,0xffffb
    80007208:	cfc080e7          	jalr	-772(ra) # 80001f00 <_Z11printStringPKc>
    8000720c:	0400006f          	j	8000724c <_ZL11workerBodyDPv+0x104>

    for (; i < 16; i++) {
        printString("D: i="); printInt(i); printString("\n");
    80007210:	00003517          	auipc	a0,0x3
    80007214:	33050513          	addi	a0,a0,816 # 8000a540 <CONSOLE_STATUS+0x530>
    80007218:	ffffb097          	auipc	ra,0xffffb
    8000721c:	ce8080e7          	jalr	-792(ra) # 80001f00 <_Z11printStringPKc>
    80007220:	00000613          	li	a2,0
    80007224:	00a00593          	li	a1,10
    80007228:	00048513          	mv	a0,s1
    8000722c:	ffffb097          	auipc	ra,0xffffb
    80007230:	e84080e7          	jalr	-380(ra) # 800020b0 <_Z8printIntiii>
    80007234:	00003517          	auipc	a0,0x3
    80007238:	4fc50513          	addi	a0,a0,1276 # 8000a730 <CONSOLE_STATUS+0x720>
    8000723c:	ffffb097          	auipc	ra,0xffffb
    80007240:	cc4080e7          	jalr	-828(ra) # 80001f00 <_Z11printStringPKc>
    for (; i < 16; i++) {
    80007244:	0014849b          	addiw	s1,s1,1
    80007248:	0ff4f493          	andi	s1,s1,255
    8000724c:	00f00793          	li	a5,15
    80007250:	fc97f0e3          	bgeu	a5,s1,80007210 <_ZL11workerBodyDPv+0xc8>
    }

    printString("D finished!\n");
    80007254:	00003517          	auipc	a0,0x3
    80007258:	31450513          	addi	a0,a0,788 # 8000a568 <CONSOLE_STATUS+0x558>
    8000725c:	ffffb097          	auipc	ra,0xffffb
    80007260:	ca4080e7          	jalr	-860(ra) # 80001f00 <_Z11printStringPKc>
    finishedD = true;
    80007264:	00100793          	li	a5,1
    80007268:	00009717          	auipc	a4,0x9
    8000726c:	f4f70923          	sb	a5,-174(a4) # 800101ba <_ZL9finishedD>
    thread_dispatch();
    80007270:	ffffa097          	auipc	ra,0xffffa
    80007274:	118080e7          	jalr	280(ra) # 80001388 <_Z15thread_dispatchv>
}
    80007278:	01813083          	ld	ra,24(sp)
    8000727c:	01013403          	ld	s0,16(sp)
    80007280:	00813483          	ld	s1,8(sp)
    80007284:	00013903          	ld	s2,0(sp)
    80007288:	02010113          	addi	sp,sp,32
    8000728c:	00008067          	ret

0000000080007290 <_ZL11workerBodyCPv>:
static void workerBodyC(void* arg) {
    80007290:	fe010113          	addi	sp,sp,-32
    80007294:	00113c23          	sd	ra,24(sp)
    80007298:	00813823          	sd	s0,16(sp)
    8000729c:	00913423          	sd	s1,8(sp)
    800072a0:	01213023          	sd	s2,0(sp)
    800072a4:	02010413          	addi	s0,sp,32
    uint8 i = 0;
    800072a8:	00000493          	li	s1,0
    800072ac:	0400006f          	j	800072ec <_ZL11workerBodyCPv+0x5c>
        printString("C: i="); printInt(i); printString("\n");
    800072b0:	00003517          	auipc	a0,0x3
    800072b4:	26050513          	addi	a0,a0,608 # 8000a510 <CONSOLE_STATUS+0x500>
    800072b8:	ffffb097          	auipc	ra,0xffffb
    800072bc:	c48080e7          	jalr	-952(ra) # 80001f00 <_Z11printStringPKc>
    800072c0:	00000613          	li	a2,0
    800072c4:	00a00593          	li	a1,10
    800072c8:	00048513          	mv	a0,s1
    800072cc:	ffffb097          	auipc	ra,0xffffb
    800072d0:	de4080e7          	jalr	-540(ra) # 800020b0 <_Z8printIntiii>
    800072d4:	00003517          	auipc	a0,0x3
    800072d8:	45c50513          	addi	a0,a0,1116 # 8000a730 <CONSOLE_STATUS+0x720>
    800072dc:	ffffb097          	auipc	ra,0xffffb
    800072e0:	c24080e7          	jalr	-988(ra) # 80001f00 <_Z11printStringPKc>
    for (; i < 3; i++) {
    800072e4:	0014849b          	addiw	s1,s1,1
    800072e8:	0ff4f493          	andi	s1,s1,255
    800072ec:	00200793          	li	a5,2
    800072f0:	fc97f0e3          	bgeu	a5,s1,800072b0 <_ZL11workerBodyCPv+0x20>
    printString("C: dispatch\n");
    800072f4:	00003517          	auipc	a0,0x3
    800072f8:	22450513          	addi	a0,a0,548 # 8000a518 <CONSOLE_STATUS+0x508>
    800072fc:	ffffb097          	auipc	ra,0xffffb
    80007300:	c04080e7          	jalr	-1020(ra) # 80001f00 <_Z11printStringPKc>
    __asm__ ("li t1, 7");
    80007304:	00700313          	li	t1,7
    thread_dispatch();
    80007308:	ffffa097          	auipc	ra,0xffffa
    8000730c:	080080e7          	jalr	128(ra) # 80001388 <_Z15thread_dispatchv>
    __asm__ ("mv %[t1], t1" : [t1] "=r"(t1));
    80007310:	00030913          	mv	s2,t1
    printString("C: t1="); printInt(t1); printString("\n");
    80007314:	00003517          	auipc	a0,0x3
    80007318:	21450513          	addi	a0,a0,532 # 8000a528 <CONSOLE_STATUS+0x518>
    8000731c:	ffffb097          	auipc	ra,0xffffb
    80007320:	be4080e7          	jalr	-1052(ra) # 80001f00 <_Z11printStringPKc>
    80007324:	00000613          	li	a2,0
    80007328:	00a00593          	li	a1,10
    8000732c:	0009051b          	sext.w	a0,s2
    80007330:	ffffb097          	auipc	ra,0xffffb
    80007334:	d80080e7          	jalr	-640(ra) # 800020b0 <_Z8printIntiii>
    80007338:	00003517          	auipc	a0,0x3
    8000733c:	3f850513          	addi	a0,a0,1016 # 8000a730 <CONSOLE_STATUS+0x720>
    80007340:	ffffb097          	auipc	ra,0xffffb
    80007344:	bc0080e7          	jalr	-1088(ra) # 80001f00 <_Z11printStringPKc>
    uint64 result = fibonacci(12);
    80007348:	00c00513          	li	a0,12
    8000734c:	00000097          	auipc	ra,0x0
    80007350:	d88080e7          	jalr	-632(ra) # 800070d4 <_ZL9fibonaccim>
    80007354:	00050913          	mv	s2,a0
    printString("C: fibonaci="); printInt(result); printString("\n");
    80007358:	00003517          	auipc	a0,0x3
    8000735c:	1d850513          	addi	a0,a0,472 # 8000a530 <CONSOLE_STATUS+0x520>
    80007360:	ffffb097          	auipc	ra,0xffffb
    80007364:	ba0080e7          	jalr	-1120(ra) # 80001f00 <_Z11printStringPKc>
    80007368:	00000613          	li	a2,0
    8000736c:	00a00593          	li	a1,10
    80007370:	0009051b          	sext.w	a0,s2
    80007374:	ffffb097          	auipc	ra,0xffffb
    80007378:	d3c080e7          	jalr	-708(ra) # 800020b0 <_Z8printIntiii>
    8000737c:	00003517          	auipc	a0,0x3
    80007380:	3b450513          	addi	a0,a0,948 # 8000a730 <CONSOLE_STATUS+0x720>
    80007384:	ffffb097          	auipc	ra,0xffffb
    80007388:	b7c080e7          	jalr	-1156(ra) # 80001f00 <_Z11printStringPKc>
    8000738c:	0400006f          	j	800073cc <_ZL11workerBodyCPv+0x13c>
        printString("C: i="); printInt(i); printString("\n");
    80007390:	00003517          	auipc	a0,0x3
    80007394:	18050513          	addi	a0,a0,384 # 8000a510 <CONSOLE_STATUS+0x500>
    80007398:	ffffb097          	auipc	ra,0xffffb
    8000739c:	b68080e7          	jalr	-1176(ra) # 80001f00 <_Z11printStringPKc>
    800073a0:	00000613          	li	a2,0
    800073a4:	00a00593          	li	a1,10
    800073a8:	00048513          	mv	a0,s1
    800073ac:	ffffb097          	auipc	ra,0xffffb
    800073b0:	d04080e7          	jalr	-764(ra) # 800020b0 <_Z8printIntiii>
    800073b4:	00003517          	auipc	a0,0x3
    800073b8:	37c50513          	addi	a0,a0,892 # 8000a730 <CONSOLE_STATUS+0x720>
    800073bc:	ffffb097          	auipc	ra,0xffffb
    800073c0:	b44080e7          	jalr	-1212(ra) # 80001f00 <_Z11printStringPKc>
    for (; i < 6; i++) {
    800073c4:	0014849b          	addiw	s1,s1,1
    800073c8:	0ff4f493          	andi	s1,s1,255
    800073cc:	00500793          	li	a5,5
    800073d0:	fc97f0e3          	bgeu	a5,s1,80007390 <_ZL11workerBodyCPv+0x100>
    printString("A finished!\n");
    800073d4:	00003517          	auipc	a0,0x3
    800073d8:	11450513          	addi	a0,a0,276 # 8000a4e8 <CONSOLE_STATUS+0x4d8>
    800073dc:	ffffb097          	auipc	ra,0xffffb
    800073e0:	b24080e7          	jalr	-1244(ra) # 80001f00 <_Z11printStringPKc>
    finishedC = true;
    800073e4:	00100793          	li	a5,1
    800073e8:	00009717          	auipc	a4,0x9
    800073ec:	dcf709a3          	sb	a5,-557(a4) # 800101bb <_ZL9finishedC>
    thread_dispatch();
    800073f0:	ffffa097          	auipc	ra,0xffffa
    800073f4:	f98080e7          	jalr	-104(ra) # 80001388 <_Z15thread_dispatchv>
}
    800073f8:	01813083          	ld	ra,24(sp)
    800073fc:	01013403          	ld	s0,16(sp)
    80007400:	00813483          	ld	s1,8(sp)
    80007404:	00013903          	ld	s2,0(sp)
    80007408:	02010113          	addi	sp,sp,32
    8000740c:	00008067          	ret

0000000080007410 <_ZL11workerBodyBPv>:
static void workerBodyB(void* arg) {
    80007410:	fe010113          	addi	sp,sp,-32
    80007414:	00113c23          	sd	ra,24(sp)
    80007418:	00813823          	sd	s0,16(sp)
    8000741c:	00913423          	sd	s1,8(sp)
    80007420:	01213023          	sd	s2,0(sp)
    80007424:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 16; i++) {
    80007428:	00000913          	li	s2,0
    8000742c:	0400006f          	j	8000746c <_ZL11workerBodyBPv+0x5c>
            thread_dispatch();
    80007430:	ffffa097          	auipc	ra,0xffffa
    80007434:	f58080e7          	jalr	-168(ra) # 80001388 <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++) {
    80007438:	00148493          	addi	s1,s1,1
    8000743c:	000027b7          	lui	a5,0x2
    80007440:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    80007444:	0097ee63          	bltu	a5,s1,80007460 <_ZL11workerBodyBPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    80007448:	00000713          	li	a4,0
    8000744c:	000077b7          	lui	a5,0x7
    80007450:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    80007454:	fce7eee3          	bltu	a5,a4,80007430 <_ZL11workerBodyBPv+0x20>
    80007458:	00170713          	addi	a4,a4,1
    8000745c:	ff1ff06f          	j	8000744c <_ZL11workerBodyBPv+0x3c>
        if (i == 10) {
    80007460:	00a00793          	li	a5,10
    80007464:	04f90663          	beq	s2,a5,800074b0 <_ZL11workerBodyBPv+0xa0>
    for (uint64 i = 0; i < 16; i++) {
    80007468:	00190913          	addi	s2,s2,1
    8000746c:	00f00793          	li	a5,15
    80007470:	0527e463          	bltu	a5,s2,800074b8 <_ZL11workerBodyBPv+0xa8>
        printString("B: i="); printInt(i); printString("\n");
    80007474:	00003517          	auipc	a0,0x3
    80007478:	08450513          	addi	a0,a0,132 # 8000a4f8 <CONSOLE_STATUS+0x4e8>
    8000747c:	ffffb097          	auipc	ra,0xffffb
    80007480:	a84080e7          	jalr	-1404(ra) # 80001f00 <_Z11printStringPKc>
    80007484:	00000613          	li	a2,0
    80007488:	00a00593          	li	a1,10
    8000748c:	0009051b          	sext.w	a0,s2
    80007490:	ffffb097          	auipc	ra,0xffffb
    80007494:	c20080e7          	jalr	-992(ra) # 800020b0 <_Z8printIntiii>
    80007498:	00003517          	auipc	a0,0x3
    8000749c:	29850513          	addi	a0,a0,664 # 8000a730 <CONSOLE_STATUS+0x720>
    800074a0:	ffffb097          	auipc	ra,0xffffb
    800074a4:	a60080e7          	jalr	-1440(ra) # 80001f00 <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    800074a8:	00000493          	li	s1,0
    800074ac:	f91ff06f          	j	8000743c <_ZL11workerBodyBPv+0x2c>
            asm volatile("csrr t6, sepc");
    800074b0:	14102ff3          	csrr	t6,sepc
    800074b4:	fb5ff06f          	j	80007468 <_ZL11workerBodyBPv+0x58>
    printString("B finished!\n");
    800074b8:	00003517          	auipc	a0,0x3
    800074bc:	04850513          	addi	a0,a0,72 # 8000a500 <CONSOLE_STATUS+0x4f0>
    800074c0:	ffffb097          	auipc	ra,0xffffb
    800074c4:	a40080e7          	jalr	-1472(ra) # 80001f00 <_Z11printStringPKc>
    finishedB = true;
    800074c8:	00100793          	li	a5,1
    800074cc:	00009717          	auipc	a4,0x9
    800074d0:	cef70823          	sb	a5,-784(a4) # 800101bc <_ZL9finishedB>
    thread_dispatch();
    800074d4:	ffffa097          	auipc	ra,0xffffa
    800074d8:	eb4080e7          	jalr	-332(ra) # 80001388 <_Z15thread_dispatchv>
}
    800074dc:	01813083          	ld	ra,24(sp)
    800074e0:	01013403          	ld	s0,16(sp)
    800074e4:	00813483          	ld	s1,8(sp)
    800074e8:	00013903          	ld	s2,0(sp)
    800074ec:	02010113          	addi	sp,sp,32
    800074f0:	00008067          	ret

00000000800074f4 <_ZL11workerBodyAPv>:
static void workerBodyA(void* arg) {
    800074f4:	fe010113          	addi	sp,sp,-32
    800074f8:	00113c23          	sd	ra,24(sp)
    800074fc:	00813823          	sd	s0,16(sp)
    80007500:	00913423          	sd	s1,8(sp)
    80007504:	01213023          	sd	s2,0(sp)
    80007508:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 10; i++) {
    8000750c:	00000913          	li	s2,0
    80007510:	0380006f          	j	80007548 <_ZL11workerBodyAPv+0x54>
            thread_dispatch();
    80007514:	ffffa097          	auipc	ra,0xffffa
    80007518:	e74080e7          	jalr	-396(ra) # 80001388 <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++) {
    8000751c:	00148493          	addi	s1,s1,1
    80007520:	000027b7          	lui	a5,0x2
    80007524:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    80007528:	0097ee63          	bltu	a5,s1,80007544 <_ZL11workerBodyAPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    8000752c:	00000713          	li	a4,0
    80007530:	000077b7          	lui	a5,0x7
    80007534:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    80007538:	fce7eee3          	bltu	a5,a4,80007514 <_ZL11workerBodyAPv+0x20>
    8000753c:	00170713          	addi	a4,a4,1
    80007540:	ff1ff06f          	j	80007530 <_ZL11workerBodyAPv+0x3c>
    for (uint64 i = 0; i < 10; i++) {
    80007544:	00190913          	addi	s2,s2,1
    80007548:	00900793          	li	a5,9
    8000754c:	0527e063          	bltu	a5,s2,8000758c <_ZL11workerBodyAPv+0x98>
        printString("A: i="); printInt(i); printString("\n");
    80007550:	00003517          	auipc	a0,0x3
    80007554:	f9050513          	addi	a0,a0,-112 # 8000a4e0 <CONSOLE_STATUS+0x4d0>
    80007558:	ffffb097          	auipc	ra,0xffffb
    8000755c:	9a8080e7          	jalr	-1624(ra) # 80001f00 <_Z11printStringPKc>
    80007560:	00000613          	li	a2,0
    80007564:	00a00593          	li	a1,10
    80007568:	0009051b          	sext.w	a0,s2
    8000756c:	ffffb097          	auipc	ra,0xffffb
    80007570:	b44080e7          	jalr	-1212(ra) # 800020b0 <_Z8printIntiii>
    80007574:	00003517          	auipc	a0,0x3
    80007578:	1bc50513          	addi	a0,a0,444 # 8000a730 <CONSOLE_STATUS+0x720>
    8000757c:	ffffb097          	auipc	ra,0xffffb
    80007580:	984080e7          	jalr	-1660(ra) # 80001f00 <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    80007584:	00000493          	li	s1,0
    80007588:	f99ff06f          	j	80007520 <_ZL11workerBodyAPv+0x2c>
    printString("A finished!\n");
    8000758c:	00003517          	auipc	a0,0x3
    80007590:	f5c50513          	addi	a0,a0,-164 # 8000a4e8 <CONSOLE_STATUS+0x4d8>
    80007594:	ffffb097          	auipc	ra,0xffffb
    80007598:	96c080e7          	jalr	-1684(ra) # 80001f00 <_Z11printStringPKc>
    finishedA = true;
    8000759c:	00100793          	li	a5,1
    800075a0:	00009717          	auipc	a4,0x9
    800075a4:	c0f70ea3          	sb	a5,-995(a4) # 800101bd <_ZL9finishedA>
}
    800075a8:	01813083          	ld	ra,24(sp)
    800075ac:	01013403          	ld	s0,16(sp)
    800075b0:	00813483          	ld	s1,8(sp)
    800075b4:	00013903          	ld	s2,0(sp)
    800075b8:	02010113          	addi	sp,sp,32
    800075bc:	00008067          	ret

00000000800075c0 <_Z16System_Mode_testv>:


void System_Mode_test() {
    800075c0:	fd010113          	addi	sp,sp,-48
    800075c4:	02113423          	sd	ra,40(sp)
    800075c8:	02813023          	sd	s0,32(sp)
    800075cc:	03010413          	addi	s0,sp,48
    thread_t threads[4];
    thread_create(&threads[0], workerBodyA, nullptr);
    800075d0:	00000613          	li	a2,0
    800075d4:	00000597          	auipc	a1,0x0
    800075d8:	f2058593          	addi	a1,a1,-224 # 800074f4 <_ZL11workerBodyAPv>
    800075dc:	fd040513          	addi	a0,s0,-48
    800075e0:	ffffa097          	auipc	ra,0xffffa
    800075e4:	d20080e7          	jalr	-736(ra) # 80001300 <_Z13thread_createPP8thread_sPFvPvES2_>
    printString("ThreadA created\n");
    800075e8:	00003517          	auipc	a0,0x3
    800075ec:	f9050513          	addi	a0,a0,-112 # 8000a578 <CONSOLE_STATUS+0x568>
    800075f0:	ffffb097          	auipc	ra,0xffffb
    800075f4:	910080e7          	jalr	-1776(ra) # 80001f00 <_Z11printStringPKc>

    thread_create(&threads[1], workerBodyB, nullptr);
    800075f8:	00000613          	li	a2,0
    800075fc:	00000597          	auipc	a1,0x0
    80007600:	e1458593          	addi	a1,a1,-492 # 80007410 <_ZL11workerBodyBPv>
    80007604:	fd840513          	addi	a0,s0,-40
    80007608:	ffffa097          	auipc	ra,0xffffa
    8000760c:	cf8080e7          	jalr	-776(ra) # 80001300 <_Z13thread_createPP8thread_sPFvPvES2_>
    printString("ThreadB created\n");
    80007610:	00003517          	auipc	a0,0x3
    80007614:	f8050513          	addi	a0,a0,-128 # 8000a590 <CONSOLE_STATUS+0x580>
    80007618:	ffffb097          	auipc	ra,0xffffb
    8000761c:	8e8080e7          	jalr	-1816(ra) # 80001f00 <_Z11printStringPKc>

    thread_create(&threads[2], workerBodyC, nullptr);
    80007620:	00000613          	li	a2,0
    80007624:	00000597          	auipc	a1,0x0
    80007628:	c6c58593          	addi	a1,a1,-916 # 80007290 <_ZL11workerBodyCPv>
    8000762c:	fe040513          	addi	a0,s0,-32
    80007630:	ffffa097          	auipc	ra,0xffffa
    80007634:	cd0080e7          	jalr	-816(ra) # 80001300 <_Z13thread_createPP8thread_sPFvPvES2_>
    printString("ThreadC created\n");
    80007638:	00003517          	auipc	a0,0x3
    8000763c:	f7050513          	addi	a0,a0,-144 # 8000a5a8 <CONSOLE_STATUS+0x598>
    80007640:	ffffb097          	auipc	ra,0xffffb
    80007644:	8c0080e7          	jalr	-1856(ra) # 80001f00 <_Z11printStringPKc>

    thread_create(&threads[3], workerBodyD, nullptr);
    80007648:	00000613          	li	a2,0
    8000764c:	00000597          	auipc	a1,0x0
    80007650:	afc58593          	addi	a1,a1,-1284 # 80007148 <_ZL11workerBodyDPv>
    80007654:	fe840513          	addi	a0,s0,-24
    80007658:	ffffa097          	auipc	ra,0xffffa
    8000765c:	ca8080e7          	jalr	-856(ra) # 80001300 <_Z13thread_createPP8thread_sPFvPvES2_>
    printString("ThreadD created\n");
    80007660:	00003517          	auipc	a0,0x3
    80007664:	f6050513          	addi	a0,a0,-160 # 8000a5c0 <CONSOLE_STATUS+0x5b0>
    80007668:	ffffb097          	auipc	ra,0xffffb
    8000766c:	898080e7          	jalr	-1896(ra) # 80001f00 <_Z11printStringPKc>
    80007670:	00c0006f          	j	8000767c <_Z16System_Mode_testv+0xbc>

    while (!(finishedA && finishedB && finishedC && finishedD)) {
        thread_dispatch();
    80007674:	ffffa097          	auipc	ra,0xffffa
    80007678:	d14080e7          	jalr	-748(ra) # 80001388 <_Z15thread_dispatchv>
    while (!(finishedA && finishedB && finishedC && finishedD)) {
    8000767c:	00009797          	auipc	a5,0x9
    80007680:	b417c783          	lbu	a5,-1215(a5) # 800101bd <_ZL9finishedA>
    80007684:	fe0788e3          	beqz	a5,80007674 <_Z16System_Mode_testv+0xb4>
    80007688:	00009797          	auipc	a5,0x9
    8000768c:	b347c783          	lbu	a5,-1228(a5) # 800101bc <_ZL9finishedB>
    80007690:	fe0782e3          	beqz	a5,80007674 <_Z16System_Mode_testv+0xb4>
    80007694:	00009797          	auipc	a5,0x9
    80007698:	b277c783          	lbu	a5,-1241(a5) # 800101bb <_ZL9finishedC>
    8000769c:	fc078ce3          	beqz	a5,80007674 <_Z16System_Mode_testv+0xb4>
    800076a0:	00009797          	auipc	a5,0x9
    800076a4:	b1a7c783          	lbu	a5,-1254(a5) # 800101ba <_ZL9finishedD>
    800076a8:	fc0786e3          	beqz	a5,80007674 <_Z16System_Mode_testv+0xb4>
    }

}
    800076ac:	02813083          	ld	ra,40(sp)
    800076b0:	02013403          	ld	s0,32(sp)
    800076b4:	03010113          	addi	sp,sp,48
    800076b8:	00008067          	ret

00000000800076bc <_ZN6BufferC1Ei>:
#include "buffer.hpp"

Buffer::Buffer(int _cap) : cap(_cap + 1), head(0), tail(0) {
    800076bc:	fe010113          	addi	sp,sp,-32
    800076c0:	00113c23          	sd	ra,24(sp)
    800076c4:	00813823          	sd	s0,16(sp)
    800076c8:	00913423          	sd	s1,8(sp)
    800076cc:	01213023          	sd	s2,0(sp)
    800076d0:	02010413          	addi	s0,sp,32
    800076d4:	00050493          	mv	s1,a0
    800076d8:	00058913          	mv	s2,a1
    800076dc:	0015879b          	addiw	a5,a1,1
    800076e0:	0007851b          	sext.w	a0,a5
    800076e4:	00f4a023          	sw	a5,0(s1)
    800076e8:	0004a823          	sw	zero,16(s1)
    800076ec:	0004aa23          	sw	zero,20(s1)
    buffer = (int *)mem_alloc(sizeof(int) * cap);
    800076f0:	00251513          	slli	a0,a0,0x2
    800076f4:	ffffa097          	auipc	ra,0xffffa
    800076f8:	b8c080e7          	jalr	-1140(ra) # 80001280 <_Z9mem_allocm>
    800076fc:	00a4b423          	sd	a0,8(s1)
    sem_open(&itemAvailable, 0);
    80007700:	00000593          	li	a1,0
    80007704:	02048513          	addi	a0,s1,32
    80007708:	ffffa097          	auipc	ra,0xffffa
    8000770c:	d34080e7          	jalr	-716(ra) # 8000143c <_Z8sem_openPP5sem_sj>
    sem_open(&spaceAvailable, _cap);
    80007710:	00090593          	mv	a1,s2
    80007714:	01848513          	addi	a0,s1,24
    80007718:	ffffa097          	auipc	ra,0xffffa
    8000771c:	d24080e7          	jalr	-732(ra) # 8000143c <_Z8sem_openPP5sem_sj>
    sem_open(&mutexHead, 1);
    80007720:	00100593          	li	a1,1
    80007724:	02848513          	addi	a0,s1,40
    80007728:	ffffa097          	auipc	ra,0xffffa
    8000772c:	d14080e7          	jalr	-748(ra) # 8000143c <_Z8sem_openPP5sem_sj>
    sem_open(&mutexTail, 1);
    80007730:	00100593          	li	a1,1
    80007734:	03048513          	addi	a0,s1,48
    80007738:	ffffa097          	auipc	ra,0xffffa
    8000773c:	d04080e7          	jalr	-764(ra) # 8000143c <_Z8sem_openPP5sem_sj>
}
    80007740:	01813083          	ld	ra,24(sp)
    80007744:	01013403          	ld	s0,16(sp)
    80007748:	00813483          	ld	s1,8(sp)
    8000774c:	00013903          	ld	s2,0(sp)
    80007750:	02010113          	addi	sp,sp,32
    80007754:	00008067          	ret

0000000080007758 <_ZN6Buffer3putEi>:
    sem_close(spaceAvailable);
    sem_close(mutexTail);
    sem_close(mutexHead);
}

void Buffer::put(int val) {
    80007758:	fe010113          	addi	sp,sp,-32
    8000775c:	00113c23          	sd	ra,24(sp)
    80007760:	00813823          	sd	s0,16(sp)
    80007764:	00913423          	sd	s1,8(sp)
    80007768:	01213023          	sd	s2,0(sp)
    8000776c:	02010413          	addi	s0,sp,32
    80007770:	00050493          	mv	s1,a0
    80007774:	00058913          	mv	s2,a1
    sem_wait(spaceAvailable);
    80007778:	01853503          	ld	a0,24(a0)
    8000777c:	ffffa097          	auipc	ra,0xffffa
    80007780:	d44080e7          	jalr	-700(ra) # 800014c0 <_Z8sem_waitP5sem_s>

    sem_wait(mutexTail);
    80007784:	0304b503          	ld	a0,48(s1)
    80007788:	ffffa097          	auipc	ra,0xffffa
    8000778c:	d38080e7          	jalr	-712(ra) # 800014c0 <_Z8sem_waitP5sem_s>
    buffer[tail] = val;
    80007790:	0084b783          	ld	a5,8(s1)
    80007794:	0144a703          	lw	a4,20(s1)
    80007798:	00271713          	slli	a4,a4,0x2
    8000779c:	00e787b3          	add	a5,a5,a4
    800077a0:	0127a023          	sw	s2,0(a5)
    tail = (tail + 1) % cap;
    800077a4:	0144a783          	lw	a5,20(s1)
    800077a8:	0017879b          	addiw	a5,a5,1
    800077ac:	0004a703          	lw	a4,0(s1)
    800077b0:	02e7e7bb          	remw	a5,a5,a4
    800077b4:	00f4aa23          	sw	a5,20(s1)
    sem_signal(mutexTail);
    800077b8:	0304b503          	ld	a0,48(s1)
    800077bc:	ffffa097          	auipc	ra,0xffffa
    800077c0:	d44080e7          	jalr	-700(ra) # 80001500 <_Z10sem_signalP5sem_s>

    sem_signal(itemAvailable);
    800077c4:	0204b503          	ld	a0,32(s1)
    800077c8:	ffffa097          	auipc	ra,0xffffa
    800077cc:	d38080e7          	jalr	-712(ra) # 80001500 <_Z10sem_signalP5sem_s>

}
    800077d0:	01813083          	ld	ra,24(sp)
    800077d4:	01013403          	ld	s0,16(sp)
    800077d8:	00813483          	ld	s1,8(sp)
    800077dc:	00013903          	ld	s2,0(sp)
    800077e0:	02010113          	addi	sp,sp,32
    800077e4:	00008067          	ret

00000000800077e8 <_ZN6Buffer3getEv>:

int Buffer::get() {
    800077e8:	fe010113          	addi	sp,sp,-32
    800077ec:	00113c23          	sd	ra,24(sp)
    800077f0:	00813823          	sd	s0,16(sp)
    800077f4:	00913423          	sd	s1,8(sp)
    800077f8:	01213023          	sd	s2,0(sp)
    800077fc:	02010413          	addi	s0,sp,32
    80007800:	00050493          	mv	s1,a0
    sem_wait(itemAvailable);
    80007804:	02053503          	ld	a0,32(a0)
    80007808:	ffffa097          	auipc	ra,0xffffa
    8000780c:	cb8080e7          	jalr	-840(ra) # 800014c0 <_Z8sem_waitP5sem_s>

    sem_wait(mutexHead);
    80007810:	0284b503          	ld	a0,40(s1)
    80007814:	ffffa097          	auipc	ra,0xffffa
    80007818:	cac080e7          	jalr	-852(ra) # 800014c0 <_Z8sem_waitP5sem_s>

    int ret = buffer[head];
    8000781c:	0084b703          	ld	a4,8(s1)
    80007820:	0104a783          	lw	a5,16(s1)
    80007824:	00279693          	slli	a3,a5,0x2
    80007828:	00d70733          	add	a4,a4,a3
    8000782c:	00072903          	lw	s2,0(a4)
    head = (head + 1) % cap;
    80007830:	0017879b          	addiw	a5,a5,1
    80007834:	0004a703          	lw	a4,0(s1)
    80007838:	02e7e7bb          	remw	a5,a5,a4
    8000783c:	00f4a823          	sw	a5,16(s1)
    sem_signal(mutexHead);
    80007840:	0284b503          	ld	a0,40(s1)
    80007844:	ffffa097          	auipc	ra,0xffffa
    80007848:	cbc080e7          	jalr	-836(ra) # 80001500 <_Z10sem_signalP5sem_s>

    sem_signal(spaceAvailable);
    8000784c:	0184b503          	ld	a0,24(s1)
    80007850:	ffffa097          	auipc	ra,0xffffa
    80007854:	cb0080e7          	jalr	-848(ra) # 80001500 <_Z10sem_signalP5sem_s>

    return ret;
}
    80007858:	00090513          	mv	a0,s2
    8000785c:	01813083          	ld	ra,24(sp)
    80007860:	01013403          	ld	s0,16(sp)
    80007864:	00813483          	ld	s1,8(sp)
    80007868:	00013903          	ld	s2,0(sp)
    8000786c:	02010113          	addi	sp,sp,32
    80007870:	00008067          	ret

0000000080007874 <_ZN6Buffer6getCntEv>:

int Buffer::getCnt() {
    80007874:	fe010113          	addi	sp,sp,-32
    80007878:	00113c23          	sd	ra,24(sp)
    8000787c:	00813823          	sd	s0,16(sp)
    80007880:	00913423          	sd	s1,8(sp)
    80007884:	01213023          	sd	s2,0(sp)
    80007888:	02010413          	addi	s0,sp,32
    8000788c:	00050493          	mv	s1,a0
    int ret;

    sem_wait(mutexHead);
    80007890:	02853503          	ld	a0,40(a0)
    80007894:	ffffa097          	auipc	ra,0xffffa
    80007898:	c2c080e7          	jalr	-980(ra) # 800014c0 <_Z8sem_waitP5sem_s>
    sem_wait(mutexTail);
    8000789c:	0304b503          	ld	a0,48(s1)
    800078a0:	ffffa097          	auipc	ra,0xffffa
    800078a4:	c20080e7          	jalr	-992(ra) # 800014c0 <_Z8sem_waitP5sem_s>

    if (tail >= head) {
    800078a8:	0144a783          	lw	a5,20(s1)
    800078ac:	0104a903          	lw	s2,16(s1)
    800078b0:	0327ce63          	blt	a5,s2,800078ec <_ZN6Buffer6getCntEv+0x78>
        ret = tail - head;
    800078b4:	4127893b          	subw	s2,a5,s2
    } else {
        ret = cap - head + tail;
    }

    sem_signal(mutexTail);
    800078b8:	0304b503          	ld	a0,48(s1)
    800078bc:	ffffa097          	auipc	ra,0xffffa
    800078c0:	c44080e7          	jalr	-956(ra) # 80001500 <_Z10sem_signalP5sem_s>
    sem_signal(mutexHead);
    800078c4:	0284b503          	ld	a0,40(s1)
    800078c8:	ffffa097          	auipc	ra,0xffffa
    800078cc:	c38080e7          	jalr	-968(ra) # 80001500 <_Z10sem_signalP5sem_s>

    return ret;
}
    800078d0:	00090513          	mv	a0,s2
    800078d4:	01813083          	ld	ra,24(sp)
    800078d8:	01013403          	ld	s0,16(sp)
    800078dc:	00813483          	ld	s1,8(sp)
    800078e0:	00013903          	ld	s2,0(sp)
    800078e4:	02010113          	addi	sp,sp,32
    800078e8:	00008067          	ret
        ret = cap - head + tail;
    800078ec:	0004a703          	lw	a4,0(s1)
    800078f0:	4127093b          	subw	s2,a4,s2
    800078f4:	00f9093b          	addw	s2,s2,a5
    800078f8:	fc1ff06f          	j	800078b8 <_ZN6Buffer6getCntEv+0x44>

00000000800078fc <_ZN6BufferD1Ev>:
Buffer::~Buffer() {
    800078fc:	fe010113          	addi	sp,sp,-32
    80007900:	00113c23          	sd	ra,24(sp)
    80007904:	00813823          	sd	s0,16(sp)
    80007908:	00913423          	sd	s1,8(sp)
    8000790c:	02010413          	addi	s0,sp,32
    80007910:	00050493          	mv	s1,a0
    putc('\n');
    80007914:	00a00513          	li	a0,10
    80007918:	ffffa097          	auipc	ra,0xffffa
    8000791c:	c98080e7          	jalr	-872(ra) # 800015b0 <_Z4putcc>
    printString("Buffer deleted!\n");
    80007920:	00003517          	auipc	a0,0x3
    80007924:	cb850513          	addi	a0,a0,-840 # 8000a5d8 <CONSOLE_STATUS+0x5c8>
    80007928:	ffffa097          	auipc	ra,0xffffa
    8000792c:	5d8080e7          	jalr	1496(ra) # 80001f00 <_Z11printStringPKc>
    while (getCnt() > 0) {
    80007930:	00048513          	mv	a0,s1
    80007934:	00000097          	auipc	ra,0x0
    80007938:	f40080e7          	jalr	-192(ra) # 80007874 <_ZN6Buffer6getCntEv>
    8000793c:	02a05c63          	blez	a0,80007974 <_ZN6BufferD1Ev+0x78>
        char ch = buffer[head];
    80007940:	0084b783          	ld	a5,8(s1)
    80007944:	0104a703          	lw	a4,16(s1)
    80007948:	00271713          	slli	a4,a4,0x2
    8000794c:	00e787b3          	add	a5,a5,a4
        putc(ch);
    80007950:	0007c503          	lbu	a0,0(a5)
    80007954:	ffffa097          	auipc	ra,0xffffa
    80007958:	c5c080e7          	jalr	-932(ra) # 800015b0 <_Z4putcc>
        head = (head + 1) % cap;
    8000795c:	0104a783          	lw	a5,16(s1)
    80007960:	0017879b          	addiw	a5,a5,1
    80007964:	0004a703          	lw	a4,0(s1)
    80007968:	02e7e7bb          	remw	a5,a5,a4
    8000796c:	00f4a823          	sw	a5,16(s1)
    while (getCnt() > 0) {
    80007970:	fc1ff06f          	j	80007930 <_ZN6BufferD1Ev+0x34>
    putc('!');
    80007974:	02100513          	li	a0,33
    80007978:	ffffa097          	auipc	ra,0xffffa
    8000797c:	c38080e7          	jalr	-968(ra) # 800015b0 <_Z4putcc>
    putc('\n');
    80007980:	00a00513          	li	a0,10
    80007984:	ffffa097          	auipc	ra,0xffffa
    80007988:	c2c080e7          	jalr	-980(ra) # 800015b0 <_Z4putcc>
    mem_free(buffer);
    8000798c:	0084b503          	ld	a0,8(s1)
    80007990:	ffffa097          	auipc	ra,0xffffa
    80007994:	930080e7          	jalr	-1744(ra) # 800012c0 <_Z8mem_freePv>
    sem_close(itemAvailable);
    80007998:	0204b503          	ld	a0,32(s1)
    8000799c:	ffffa097          	auipc	ra,0xffffa
    800079a0:	ae4080e7          	jalr	-1308(ra) # 80001480 <_Z9sem_closeP5sem_s>
    sem_close(spaceAvailable);
    800079a4:	0184b503          	ld	a0,24(s1)
    800079a8:	ffffa097          	auipc	ra,0xffffa
    800079ac:	ad8080e7          	jalr	-1320(ra) # 80001480 <_Z9sem_closeP5sem_s>
    sem_close(mutexTail);
    800079b0:	0304b503          	ld	a0,48(s1)
    800079b4:	ffffa097          	auipc	ra,0xffffa
    800079b8:	acc080e7          	jalr	-1332(ra) # 80001480 <_Z9sem_closeP5sem_s>
    sem_close(mutexHead);
    800079bc:	0284b503          	ld	a0,40(s1)
    800079c0:	ffffa097          	auipc	ra,0xffffa
    800079c4:	ac0080e7          	jalr	-1344(ra) # 80001480 <_Z9sem_closeP5sem_s>
}
    800079c8:	01813083          	ld	ra,24(sp)
    800079cc:	01013403          	ld	s0,16(sp)
    800079d0:	00813483          	ld	s1,8(sp)
    800079d4:	02010113          	addi	sp,sp,32
    800079d8:	00008067          	ret

00000000800079dc <start>:
    800079dc:	ff010113          	addi	sp,sp,-16
    800079e0:	00813423          	sd	s0,8(sp)
    800079e4:	01010413          	addi	s0,sp,16
    800079e8:	300027f3          	csrr	a5,mstatus
    800079ec:	ffffe737          	lui	a4,0xffffe
    800079f0:	7ff70713          	addi	a4,a4,2047 # ffffffffffffe7ff <end+0xffffffff7ffed3df>
    800079f4:	00e7f7b3          	and	a5,a5,a4
    800079f8:	00001737          	lui	a4,0x1
    800079fc:	80070713          	addi	a4,a4,-2048 # 800 <_entry-0x7ffff800>
    80007a00:	00e7e7b3          	or	a5,a5,a4
    80007a04:	30079073          	csrw	mstatus,a5
    80007a08:	00000797          	auipc	a5,0x0
    80007a0c:	16078793          	addi	a5,a5,352 # 80007b68 <system_main>
    80007a10:	34179073          	csrw	mepc,a5
    80007a14:	00000793          	li	a5,0
    80007a18:	18079073          	csrw	satp,a5
    80007a1c:	000107b7          	lui	a5,0x10
    80007a20:	fff78793          	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    80007a24:	30279073          	csrw	medeleg,a5
    80007a28:	30379073          	csrw	mideleg,a5
    80007a2c:	104027f3          	csrr	a5,sie
    80007a30:	2227e793          	ori	a5,a5,546
    80007a34:	10479073          	csrw	sie,a5
    80007a38:	fff00793          	li	a5,-1
    80007a3c:	00a7d793          	srli	a5,a5,0xa
    80007a40:	3b079073          	csrw	pmpaddr0,a5
    80007a44:	00f00793          	li	a5,15
    80007a48:	3a079073          	csrw	pmpcfg0,a5
    80007a4c:	f14027f3          	csrr	a5,mhartid
    80007a50:	0200c737          	lui	a4,0x200c
    80007a54:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    80007a58:	0007869b          	sext.w	a3,a5
    80007a5c:	00269713          	slli	a4,a3,0x2
    80007a60:	000f4637          	lui	a2,0xf4
    80007a64:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    80007a68:	00d70733          	add	a4,a4,a3
    80007a6c:	0037979b          	slliw	a5,a5,0x3
    80007a70:	020046b7          	lui	a3,0x2004
    80007a74:	00d787b3          	add	a5,a5,a3
    80007a78:	00c585b3          	add	a1,a1,a2
    80007a7c:	00371693          	slli	a3,a4,0x3
    80007a80:	00008717          	auipc	a4,0x8
    80007a84:	74070713          	addi	a4,a4,1856 # 800101c0 <timer_scratch>
    80007a88:	00b7b023          	sd	a1,0(a5)
    80007a8c:	00d70733          	add	a4,a4,a3
    80007a90:	00f73c23          	sd	a5,24(a4)
    80007a94:	02c73023          	sd	a2,32(a4)
    80007a98:	34071073          	csrw	mscratch,a4
    80007a9c:	00000797          	auipc	a5,0x0
    80007aa0:	6e478793          	addi	a5,a5,1764 # 80008180 <timervec>
    80007aa4:	30579073          	csrw	mtvec,a5
    80007aa8:	300027f3          	csrr	a5,mstatus
    80007aac:	0087e793          	ori	a5,a5,8
    80007ab0:	30079073          	csrw	mstatus,a5
    80007ab4:	304027f3          	csrr	a5,mie
    80007ab8:	0807e793          	ori	a5,a5,128
    80007abc:	30479073          	csrw	mie,a5
    80007ac0:	f14027f3          	csrr	a5,mhartid
    80007ac4:	0007879b          	sext.w	a5,a5
    80007ac8:	00078213          	mv	tp,a5
    80007acc:	30200073          	mret
    80007ad0:	00813403          	ld	s0,8(sp)
    80007ad4:	01010113          	addi	sp,sp,16
    80007ad8:	00008067          	ret

0000000080007adc <timerinit>:
    80007adc:	ff010113          	addi	sp,sp,-16
    80007ae0:	00813423          	sd	s0,8(sp)
    80007ae4:	01010413          	addi	s0,sp,16
    80007ae8:	f14027f3          	csrr	a5,mhartid
    80007aec:	0200c737          	lui	a4,0x200c
    80007af0:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    80007af4:	0007869b          	sext.w	a3,a5
    80007af8:	00269713          	slli	a4,a3,0x2
    80007afc:	000f4637          	lui	a2,0xf4
    80007b00:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    80007b04:	00d70733          	add	a4,a4,a3
    80007b08:	0037979b          	slliw	a5,a5,0x3
    80007b0c:	020046b7          	lui	a3,0x2004
    80007b10:	00d787b3          	add	a5,a5,a3
    80007b14:	00c585b3          	add	a1,a1,a2
    80007b18:	00371693          	slli	a3,a4,0x3
    80007b1c:	00008717          	auipc	a4,0x8
    80007b20:	6a470713          	addi	a4,a4,1700 # 800101c0 <timer_scratch>
    80007b24:	00b7b023          	sd	a1,0(a5)
    80007b28:	00d70733          	add	a4,a4,a3
    80007b2c:	00f73c23          	sd	a5,24(a4)
    80007b30:	02c73023          	sd	a2,32(a4)
    80007b34:	34071073          	csrw	mscratch,a4
    80007b38:	00000797          	auipc	a5,0x0
    80007b3c:	64878793          	addi	a5,a5,1608 # 80008180 <timervec>
    80007b40:	30579073          	csrw	mtvec,a5
    80007b44:	300027f3          	csrr	a5,mstatus
    80007b48:	0087e793          	ori	a5,a5,8
    80007b4c:	30079073          	csrw	mstatus,a5
    80007b50:	304027f3          	csrr	a5,mie
    80007b54:	0807e793          	ori	a5,a5,128
    80007b58:	30479073          	csrw	mie,a5
    80007b5c:	00813403          	ld	s0,8(sp)
    80007b60:	01010113          	addi	sp,sp,16
    80007b64:	00008067          	ret

0000000080007b68 <system_main>:
    80007b68:	fe010113          	addi	sp,sp,-32
    80007b6c:	00813823          	sd	s0,16(sp)
    80007b70:	00913423          	sd	s1,8(sp)
    80007b74:	00113c23          	sd	ra,24(sp)
    80007b78:	02010413          	addi	s0,sp,32
    80007b7c:	00000097          	auipc	ra,0x0
    80007b80:	0c4080e7          	jalr	196(ra) # 80007c40 <cpuid>
    80007b84:	00005497          	auipc	s1,0x5
    80007b88:	0bc48493          	addi	s1,s1,188 # 8000cc40 <started>
    80007b8c:	02050263          	beqz	a0,80007bb0 <system_main+0x48>
    80007b90:	0004a783          	lw	a5,0(s1)
    80007b94:	0007879b          	sext.w	a5,a5
    80007b98:	fe078ce3          	beqz	a5,80007b90 <system_main+0x28>
    80007b9c:	0ff0000f          	fence
    80007ba0:	00003517          	auipc	a0,0x3
    80007ba4:	d0850513          	addi	a0,a0,-760 # 8000a8a8 <CONSOLE_STATUS+0x898>
    80007ba8:	00001097          	auipc	ra,0x1
    80007bac:	a74080e7          	jalr	-1420(ra) # 8000861c <panic>
    80007bb0:	00001097          	auipc	ra,0x1
    80007bb4:	9c8080e7          	jalr	-1592(ra) # 80008578 <consoleinit>
    80007bb8:	00001097          	auipc	ra,0x1
    80007bbc:	154080e7          	jalr	340(ra) # 80008d0c <printfinit>
    80007bc0:	00003517          	auipc	a0,0x3
    80007bc4:	b7050513          	addi	a0,a0,-1168 # 8000a730 <CONSOLE_STATUS+0x720>
    80007bc8:	00001097          	auipc	ra,0x1
    80007bcc:	ab0080e7          	jalr	-1360(ra) # 80008678 <__printf>
    80007bd0:	00003517          	auipc	a0,0x3
    80007bd4:	ca850513          	addi	a0,a0,-856 # 8000a878 <CONSOLE_STATUS+0x868>
    80007bd8:	00001097          	auipc	ra,0x1
    80007bdc:	aa0080e7          	jalr	-1376(ra) # 80008678 <__printf>
    80007be0:	00003517          	auipc	a0,0x3
    80007be4:	b5050513          	addi	a0,a0,-1200 # 8000a730 <CONSOLE_STATUS+0x720>
    80007be8:	00001097          	auipc	ra,0x1
    80007bec:	a90080e7          	jalr	-1392(ra) # 80008678 <__printf>
    80007bf0:	00001097          	auipc	ra,0x1
    80007bf4:	4a8080e7          	jalr	1192(ra) # 80009098 <kinit>
    80007bf8:	00000097          	auipc	ra,0x0
    80007bfc:	148080e7          	jalr	328(ra) # 80007d40 <trapinit>
    80007c00:	00000097          	auipc	ra,0x0
    80007c04:	16c080e7          	jalr	364(ra) # 80007d6c <trapinithart>
    80007c08:	00000097          	auipc	ra,0x0
    80007c0c:	5b8080e7          	jalr	1464(ra) # 800081c0 <plicinit>
    80007c10:	00000097          	auipc	ra,0x0
    80007c14:	5d8080e7          	jalr	1496(ra) # 800081e8 <plicinithart>
    80007c18:	00000097          	auipc	ra,0x0
    80007c1c:	078080e7          	jalr	120(ra) # 80007c90 <userinit>
    80007c20:	0ff0000f          	fence
    80007c24:	00100793          	li	a5,1
    80007c28:	00003517          	auipc	a0,0x3
    80007c2c:	c6850513          	addi	a0,a0,-920 # 8000a890 <CONSOLE_STATUS+0x880>
    80007c30:	00f4a023          	sw	a5,0(s1)
    80007c34:	00001097          	auipc	ra,0x1
    80007c38:	a44080e7          	jalr	-1468(ra) # 80008678 <__printf>
    80007c3c:	0000006f          	j	80007c3c <system_main+0xd4>

0000000080007c40 <cpuid>:
    80007c40:	ff010113          	addi	sp,sp,-16
    80007c44:	00813423          	sd	s0,8(sp)
    80007c48:	01010413          	addi	s0,sp,16
    80007c4c:	00020513          	mv	a0,tp
    80007c50:	00813403          	ld	s0,8(sp)
    80007c54:	0005051b          	sext.w	a0,a0
    80007c58:	01010113          	addi	sp,sp,16
    80007c5c:	00008067          	ret

0000000080007c60 <mycpu>:
    80007c60:	ff010113          	addi	sp,sp,-16
    80007c64:	00813423          	sd	s0,8(sp)
    80007c68:	01010413          	addi	s0,sp,16
    80007c6c:	00020793          	mv	a5,tp
    80007c70:	00813403          	ld	s0,8(sp)
    80007c74:	0007879b          	sext.w	a5,a5
    80007c78:	00779793          	slli	a5,a5,0x7
    80007c7c:	00009517          	auipc	a0,0x9
    80007c80:	57450513          	addi	a0,a0,1396 # 800111f0 <cpus>
    80007c84:	00f50533          	add	a0,a0,a5
    80007c88:	01010113          	addi	sp,sp,16
    80007c8c:	00008067          	ret

0000000080007c90 <userinit>:
    80007c90:	ff010113          	addi	sp,sp,-16
    80007c94:	00813423          	sd	s0,8(sp)
    80007c98:	01010413          	addi	s0,sp,16
    80007c9c:	00813403          	ld	s0,8(sp)
    80007ca0:	01010113          	addi	sp,sp,16
    80007ca4:	ffffb317          	auipc	t1,0xffffb
    80007ca8:	ddc30067          	jr	-548(t1) # 80002a80 <main>

0000000080007cac <either_copyout>:
    80007cac:	ff010113          	addi	sp,sp,-16
    80007cb0:	00813023          	sd	s0,0(sp)
    80007cb4:	00113423          	sd	ra,8(sp)
    80007cb8:	01010413          	addi	s0,sp,16
    80007cbc:	02051663          	bnez	a0,80007ce8 <either_copyout+0x3c>
    80007cc0:	00058513          	mv	a0,a1
    80007cc4:	00060593          	mv	a1,a2
    80007cc8:	0006861b          	sext.w	a2,a3
    80007ccc:	00002097          	auipc	ra,0x2
    80007cd0:	c58080e7          	jalr	-936(ra) # 80009924 <__memmove>
    80007cd4:	00813083          	ld	ra,8(sp)
    80007cd8:	00013403          	ld	s0,0(sp)
    80007cdc:	00000513          	li	a0,0
    80007ce0:	01010113          	addi	sp,sp,16
    80007ce4:	00008067          	ret
    80007ce8:	00003517          	auipc	a0,0x3
    80007cec:	be850513          	addi	a0,a0,-1048 # 8000a8d0 <CONSOLE_STATUS+0x8c0>
    80007cf0:	00001097          	auipc	ra,0x1
    80007cf4:	92c080e7          	jalr	-1748(ra) # 8000861c <panic>

0000000080007cf8 <either_copyin>:
    80007cf8:	ff010113          	addi	sp,sp,-16
    80007cfc:	00813023          	sd	s0,0(sp)
    80007d00:	00113423          	sd	ra,8(sp)
    80007d04:	01010413          	addi	s0,sp,16
    80007d08:	02059463          	bnez	a1,80007d30 <either_copyin+0x38>
    80007d0c:	00060593          	mv	a1,a2
    80007d10:	0006861b          	sext.w	a2,a3
    80007d14:	00002097          	auipc	ra,0x2
    80007d18:	c10080e7          	jalr	-1008(ra) # 80009924 <__memmove>
    80007d1c:	00813083          	ld	ra,8(sp)
    80007d20:	00013403          	ld	s0,0(sp)
    80007d24:	00000513          	li	a0,0
    80007d28:	01010113          	addi	sp,sp,16
    80007d2c:	00008067          	ret
    80007d30:	00003517          	auipc	a0,0x3
    80007d34:	bc850513          	addi	a0,a0,-1080 # 8000a8f8 <CONSOLE_STATUS+0x8e8>
    80007d38:	00001097          	auipc	ra,0x1
    80007d3c:	8e4080e7          	jalr	-1820(ra) # 8000861c <panic>

0000000080007d40 <trapinit>:
    80007d40:	ff010113          	addi	sp,sp,-16
    80007d44:	00813423          	sd	s0,8(sp)
    80007d48:	01010413          	addi	s0,sp,16
    80007d4c:	00813403          	ld	s0,8(sp)
    80007d50:	00003597          	auipc	a1,0x3
    80007d54:	bd058593          	addi	a1,a1,-1072 # 8000a920 <CONSOLE_STATUS+0x910>
    80007d58:	00009517          	auipc	a0,0x9
    80007d5c:	51850513          	addi	a0,a0,1304 # 80011270 <tickslock>
    80007d60:	01010113          	addi	sp,sp,16
    80007d64:	00001317          	auipc	t1,0x1
    80007d68:	5c430067          	jr	1476(t1) # 80009328 <initlock>

0000000080007d6c <trapinithart>:
    80007d6c:	ff010113          	addi	sp,sp,-16
    80007d70:	00813423          	sd	s0,8(sp)
    80007d74:	01010413          	addi	s0,sp,16
    80007d78:	00000797          	auipc	a5,0x0
    80007d7c:	2f878793          	addi	a5,a5,760 # 80008070 <kernelvec>
    80007d80:	10579073          	csrw	stvec,a5
    80007d84:	00813403          	ld	s0,8(sp)
    80007d88:	01010113          	addi	sp,sp,16
    80007d8c:	00008067          	ret

0000000080007d90 <usertrap>:
    80007d90:	ff010113          	addi	sp,sp,-16
    80007d94:	00813423          	sd	s0,8(sp)
    80007d98:	01010413          	addi	s0,sp,16
    80007d9c:	00813403          	ld	s0,8(sp)
    80007da0:	01010113          	addi	sp,sp,16
    80007da4:	00008067          	ret

0000000080007da8 <usertrapret>:
    80007da8:	ff010113          	addi	sp,sp,-16
    80007dac:	00813423          	sd	s0,8(sp)
    80007db0:	01010413          	addi	s0,sp,16
    80007db4:	00813403          	ld	s0,8(sp)
    80007db8:	01010113          	addi	sp,sp,16
    80007dbc:	00008067          	ret

0000000080007dc0 <kerneltrap>:
    80007dc0:	fe010113          	addi	sp,sp,-32
    80007dc4:	00813823          	sd	s0,16(sp)
    80007dc8:	00113c23          	sd	ra,24(sp)
    80007dcc:	00913423          	sd	s1,8(sp)
    80007dd0:	02010413          	addi	s0,sp,32
    80007dd4:	142025f3          	csrr	a1,scause
    80007dd8:	100027f3          	csrr	a5,sstatus
    80007ddc:	0027f793          	andi	a5,a5,2
    80007de0:	10079c63          	bnez	a5,80007ef8 <kerneltrap+0x138>
    80007de4:	142027f3          	csrr	a5,scause
    80007de8:	0207ce63          	bltz	a5,80007e24 <kerneltrap+0x64>
    80007dec:	00003517          	auipc	a0,0x3
    80007df0:	b7c50513          	addi	a0,a0,-1156 # 8000a968 <CONSOLE_STATUS+0x958>
    80007df4:	00001097          	auipc	ra,0x1
    80007df8:	884080e7          	jalr	-1916(ra) # 80008678 <__printf>
    80007dfc:	141025f3          	csrr	a1,sepc
    80007e00:	14302673          	csrr	a2,stval
    80007e04:	00003517          	auipc	a0,0x3
    80007e08:	b7450513          	addi	a0,a0,-1164 # 8000a978 <CONSOLE_STATUS+0x968>
    80007e0c:	00001097          	auipc	ra,0x1
    80007e10:	86c080e7          	jalr	-1940(ra) # 80008678 <__printf>
    80007e14:	00003517          	auipc	a0,0x3
    80007e18:	b7c50513          	addi	a0,a0,-1156 # 8000a990 <CONSOLE_STATUS+0x980>
    80007e1c:	00001097          	auipc	ra,0x1
    80007e20:	800080e7          	jalr	-2048(ra) # 8000861c <panic>
    80007e24:	0ff7f713          	andi	a4,a5,255
    80007e28:	00900693          	li	a3,9
    80007e2c:	04d70063          	beq	a4,a3,80007e6c <kerneltrap+0xac>
    80007e30:	fff00713          	li	a4,-1
    80007e34:	03f71713          	slli	a4,a4,0x3f
    80007e38:	00170713          	addi	a4,a4,1
    80007e3c:	fae798e3          	bne	a5,a4,80007dec <kerneltrap+0x2c>
    80007e40:	00000097          	auipc	ra,0x0
    80007e44:	e00080e7          	jalr	-512(ra) # 80007c40 <cpuid>
    80007e48:	06050663          	beqz	a0,80007eb4 <kerneltrap+0xf4>
    80007e4c:	144027f3          	csrr	a5,sip
    80007e50:	ffd7f793          	andi	a5,a5,-3
    80007e54:	14479073          	csrw	sip,a5
    80007e58:	01813083          	ld	ra,24(sp)
    80007e5c:	01013403          	ld	s0,16(sp)
    80007e60:	00813483          	ld	s1,8(sp)
    80007e64:	02010113          	addi	sp,sp,32
    80007e68:	00008067          	ret
    80007e6c:	00000097          	auipc	ra,0x0
    80007e70:	3c8080e7          	jalr	968(ra) # 80008234 <plic_claim>
    80007e74:	00a00793          	li	a5,10
    80007e78:	00050493          	mv	s1,a0
    80007e7c:	06f50863          	beq	a0,a5,80007eec <kerneltrap+0x12c>
    80007e80:	fc050ce3          	beqz	a0,80007e58 <kerneltrap+0x98>
    80007e84:	00050593          	mv	a1,a0
    80007e88:	00003517          	auipc	a0,0x3
    80007e8c:	ac050513          	addi	a0,a0,-1344 # 8000a948 <CONSOLE_STATUS+0x938>
    80007e90:	00000097          	auipc	ra,0x0
    80007e94:	7e8080e7          	jalr	2024(ra) # 80008678 <__printf>
    80007e98:	01013403          	ld	s0,16(sp)
    80007e9c:	01813083          	ld	ra,24(sp)
    80007ea0:	00048513          	mv	a0,s1
    80007ea4:	00813483          	ld	s1,8(sp)
    80007ea8:	02010113          	addi	sp,sp,32
    80007eac:	00000317          	auipc	t1,0x0
    80007eb0:	3c030067          	jr	960(t1) # 8000826c <plic_complete>
    80007eb4:	00009517          	auipc	a0,0x9
    80007eb8:	3bc50513          	addi	a0,a0,956 # 80011270 <tickslock>
    80007ebc:	00001097          	auipc	ra,0x1
    80007ec0:	490080e7          	jalr	1168(ra) # 8000934c <acquire>
    80007ec4:	00005717          	auipc	a4,0x5
    80007ec8:	d8070713          	addi	a4,a4,-640 # 8000cc44 <ticks>
    80007ecc:	00072783          	lw	a5,0(a4)
    80007ed0:	00009517          	auipc	a0,0x9
    80007ed4:	3a050513          	addi	a0,a0,928 # 80011270 <tickslock>
    80007ed8:	0017879b          	addiw	a5,a5,1
    80007edc:	00f72023          	sw	a5,0(a4)
    80007ee0:	00001097          	auipc	ra,0x1
    80007ee4:	538080e7          	jalr	1336(ra) # 80009418 <release>
    80007ee8:	f65ff06f          	j	80007e4c <kerneltrap+0x8c>
    80007eec:	00001097          	auipc	ra,0x1
    80007ef0:	094080e7          	jalr	148(ra) # 80008f80 <uartintr>
    80007ef4:	fa5ff06f          	j	80007e98 <kerneltrap+0xd8>
    80007ef8:	00003517          	auipc	a0,0x3
    80007efc:	a3050513          	addi	a0,a0,-1488 # 8000a928 <CONSOLE_STATUS+0x918>
    80007f00:	00000097          	auipc	ra,0x0
    80007f04:	71c080e7          	jalr	1820(ra) # 8000861c <panic>

0000000080007f08 <clockintr>:
    80007f08:	fe010113          	addi	sp,sp,-32
    80007f0c:	00813823          	sd	s0,16(sp)
    80007f10:	00913423          	sd	s1,8(sp)
    80007f14:	00113c23          	sd	ra,24(sp)
    80007f18:	02010413          	addi	s0,sp,32
    80007f1c:	00009497          	auipc	s1,0x9
    80007f20:	35448493          	addi	s1,s1,852 # 80011270 <tickslock>
    80007f24:	00048513          	mv	a0,s1
    80007f28:	00001097          	auipc	ra,0x1
    80007f2c:	424080e7          	jalr	1060(ra) # 8000934c <acquire>
    80007f30:	00005717          	auipc	a4,0x5
    80007f34:	d1470713          	addi	a4,a4,-748 # 8000cc44 <ticks>
    80007f38:	00072783          	lw	a5,0(a4)
    80007f3c:	01013403          	ld	s0,16(sp)
    80007f40:	01813083          	ld	ra,24(sp)
    80007f44:	00048513          	mv	a0,s1
    80007f48:	0017879b          	addiw	a5,a5,1
    80007f4c:	00813483          	ld	s1,8(sp)
    80007f50:	00f72023          	sw	a5,0(a4)
    80007f54:	02010113          	addi	sp,sp,32
    80007f58:	00001317          	auipc	t1,0x1
    80007f5c:	4c030067          	jr	1216(t1) # 80009418 <release>

0000000080007f60 <devintr>:
    80007f60:	142027f3          	csrr	a5,scause
    80007f64:	00000513          	li	a0,0
    80007f68:	0007c463          	bltz	a5,80007f70 <devintr+0x10>
    80007f6c:	00008067          	ret
    80007f70:	fe010113          	addi	sp,sp,-32
    80007f74:	00813823          	sd	s0,16(sp)
    80007f78:	00113c23          	sd	ra,24(sp)
    80007f7c:	00913423          	sd	s1,8(sp)
    80007f80:	02010413          	addi	s0,sp,32
    80007f84:	0ff7f713          	andi	a4,a5,255
    80007f88:	00900693          	li	a3,9
    80007f8c:	04d70c63          	beq	a4,a3,80007fe4 <devintr+0x84>
    80007f90:	fff00713          	li	a4,-1
    80007f94:	03f71713          	slli	a4,a4,0x3f
    80007f98:	00170713          	addi	a4,a4,1
    80007f9c:	00e78c63          	beq	a5,a4,80007fb4 <devintr+0x54>
    80007fa0:	01813083          	ld	ra,24(sp)
    80007fa4:	01013403          	ld	s0,16(sp)
    80007fa8:	00813483          	ld	s1,8(sp)
    80007fac:	02010113          	addi	sp,sp,32
    80007fb0:	00008067          	ret
    80007fb4:	00000097          	auipc	ra,0x0
    80007fb8:	c8c080e7          	jalr	-884(ra) # 80007c40 <cpuid>
    80007fbc:	06050663          	beqz	a0,80008028 <devintr+0xc8>
    80007fc0:	144027f3          	csrr	a5,sip
    80007fc4:	ffd7f793          	andi	a5,a5,-3
    80007fc8:	14479073          	csrw	sip,a5
    80007fcc:	01813083          	ld	ra,24(sp)
    80007fd0:	01013403          	ld	s0,16(sp)
    80007fd4:	00813483          	ld	s1,8(sp)
    80007fd8:	00200513          	li	a0,2
    80007fdc:	02010113          	addi	sp,sp,32
    80007fe0:	00008067          	ret
    80007fe4:	00000097          	auipc	ra,0x0
    80007fe8:	250080e7          	jalr	592(ra) # 80008234 <plic_claim>
    80007fec:	00a00793          	li	a5,10
    80007ff0:	00050493          	mv	s1,a0
    80007ff4:	06f50663          	beq	a0,a5,80008060 <devintr+0x100>
    80007ff8:	00100513          	li	a0,1
    80007ffc:	fa0482e3          	beqz	s1,80007fa0 <devintr+0x40>
    80008000:	00048593          	mv	a1,s1
    80008004:	00003517          	auipc	a0,0x3
    80008008:	94450513          	addi	a0,a0,-1724 # 8000a948 <CONSOLE_STATUS+0x938>
    8000800c:	00000097          	auipc	ra,0x0
    80008010:	66c080e7          	jalr	1644(ra) # 80008678 <__printf>
    80008014:	00048513          	mv	a0,s1
    80008018:	00000097          	auipc	ra,0x0
    8000801c:	254080e7          	jalr	596(ra) # 8000826c <plic_complete>
    80008020:	00100513          	li	a0,1
    80008024:	f7dff06f          	j	80007fa0 <devintr+0x40>
    80008028:	00009517          	auipc	a0,0x9
    8000802c:	24850513          	addi	a0,a0,584 # 80011270 <tickslock>
    80008030:	00001097          	auipc	ra,0x1
    80008034:	31c080e7          	jalr	796(ra) # 8000934c <acquire>
    80008038:	00005717          	auipc	a4,0x5
    8000803c:	c0c70713          	addi	a4,a4,-1012 # 8000cc44 <ticks>
    80008040:	00072783          	lw	a5,0(a4)
    80008044:	00009517          	auipc	a0,0x9
    80008048:	22c50513          	addi	a0,a0,556 # 80011270 <tickslock>
    8000804c:	0017879b          	addiw	a5,a5,1
    80008050:	00f72023          	sw	a5,0(a4)
    80008054:	00001097          	auipc	ra,0x1
    80008058:	3c4080e7          	jalr	964(ra) # 80009418 <release>
    8000805c:	f65ff06f          	j	80007fc0 <devintr+0x60>
    80008060:	00001097          	auipc	ra,0x1
    80008064:	f20080e7          	jalr	-224(ra) # 80008f80 <uartintr>
    80008068:	fadff06f          	j	80008014 <devintr+0xb4>
    8000806c:	0000                	unimp
	...

0000000080008070 <kernelvec>:
    80008070:	f0010113          	addi	sp,sp,-256
    80008074:	00113023          	sd	ra,0(sp)
    80008078:	00213423          	sd	sp,8(sp)
    8000807c:	00313823          	sd	gp,16(sp)
    80008080:	00413c23          	sd	tp,24(sp)
    80008084:	02513023          	sd	t0,32(sp)
    80008088:	02613423          	sd	t1,40(sp)
    8000808c:	02713823          	sd	t2,48(sp)
    80008090:	02813c23          	sd	s0,56(sp)
    80008094:	04913023          	sd	s1,64(sp)
    80008098:	04a13423          	sd	a0,72(sp)
    8000809c:	04b13823          	sd	a1,80(sp)
    800080a0:	04c13c23          	sd	a2,88(sp)
    800080a4:	06d13023          	sd	a3,96(sp)
    800080a8:	06e13423          	sd	a4,104(sp)
    800080ac:	06f13823          	sd	a5,112(sp)
    800080b0:	07013c23          	sd	a6,120(sp)
    800080b4:	09113023          	sd	a7,128(sp)
    800080b8:	09213423          	sd	s2,136(sp)
    800080bc:	09313823          	sd	s3,144(sp)
    800080c0:	09413c23          	sd	s4,152(sp)
    800080c4:	0b513023          	sd	s5,160(sp)
    800080c8:	0b613423          	sd	s6,168(sp)
    800080cc:	0b713823          	sd	s7,176(sp)
    800080d0:	0b813c23          	sd	s8,184(sp)
    800080d4:	0d913023          	sd	s9,192(sp)
    800080d8:	0da13423          	sd	s10,200(sp)
    800080dc:	0db13823          	sd	s11,208(sp)
    800080e0:	0dc13c23          	sd	t3,216(sp)
    800080e4:	0fd13023          	sd	t4,224(sp)
    800080e8:	0fe13423          	sd	t5,232(sp)
    800080ec:	0ff13823          	sd	t6,240(sp)
    800080f0:	cd1ff0ef          	jal	ra,80007dc0 <kerneltrap>
    800080f4:	00013083          	ld	ra,0(sp)
    800080f8:	00813103          	ld	sp,8(sp)
    800080fc:	01013183          	ld	gp,16(sp)
    80008100:	02013283          	ld	t0,32(sp)
    80008104:	02813303          	ld	t1,40(sp)
    80008108:	03013383          	ld	t2,48(sp)
    8000810c:	03813403          	ld	s0,56(sp)
    80008110:	04013483          	ld	s1,64(sp)
    80008114:	04813503          	ld	a0,72(sp)
    80008118:	05013583          	ld	a1,80(sp)
    8000811c:	05813603          	ld	a2,88(sp)
    80008120:	06013683          	ld	a3,96(sp)
    80008124:	06813703          	ld	a4,104(sp)
    80008128:	07013783          	ld	a5,112(sp)
    8000812c:	07813803          	ld	a6,120(sp)
    80008130:	08013883          	ld	a7,128(sp)
    80008134:	08813903          	ld	s2,136(sp)
    80008138:	09013983          	ld	s3,144(sp)
    8000813c:	09813a03          	ld	s4,152(sp)
    80008140:	0a013a83          	ld	s5,160(sp)
    80008144:	0a813b03          	ld	s6,168(sp)
    80008148:	0b013b83          	ld	s7,176(sp)
    8000814c:	0b813c03          	ld	s8,184(sp)
    80008150:	0c013c83          	ld	s9,192(sp)
    80008154:	0c813d03          	ld	s10,200(sp)
    80008158:	0d013d83          	ld	s11,208(sp)
    8000815c:	0d813e03          	ld	t3,216(sp)
    80008160:	0e013e83          	ld	t4,224(sp)
    80008164:	0e813f03          	ld	t5,232(sp)
    80008168:	0f013f83          	ld	t6,240(sp)
    8000816c:	10010113          	addi	sp,sp,256
    80008170:	10200073          	sret
    80008174:	00000013          	nop
    80008178:	00000013          	nop
    8000817c:	00000013          	nop

0000000080008180 <timervec>:
    80008180:	34051573          	csrrw	a0,mscratch,a0
    80008184:	00b53023          	sd	a1,0(a0)
    80008188:	00c53423          	sd	a2,8(a0)
    8000818c:	00d53823          	sd	a3,16(a0)
    80008190:	01853583          	ld	a1,24(a0)
    80008194:	02053603          	ld	a2,32(a0)
    80008198:	0005b683          	ld	a3,0(a1)
    8000819c:	00c686b3          	add	a3,a3,a2
    800081a0:	00d5b023          	sd	a3,0(a1)
    800081a4:	00200593          	li	a1,2
    800081a8:	14459073          	csrw	sip,a1
    800081ac:	01053683          	ld	a3,16(a0)
    800081b0:	00853603          	ld	a2,8(a0)
    800081b4:	00053583          	ld	a1,0(a0)
    800081b8:	34051573          	csrrw	a0,mscratch,a0
    800081bc:	30200073          	mret

00000000800081c0 <plicinit>:
    800081c0:	ff010113          	addi	sp,sp,-16
    800081c4:	00813423          	sd	s0,8(sp)
    800081c8:	01010413          	addi	s0,sp,16
    800081cc:	00813403          	ld	s0,8(sp)
    800081d0:	0c0007b7          	lui	a5,0xc000
    800081d4:	00100713          	li	a4,1
    800081d8:	02e7a423          	sw	a4,40(a5) # c000028 <_entry-0x73ffffd8>
    800081dc:	00e7a223          	sw	a4,4(a5)
    800081e0:	01010113          	addi	sp,sp,16
    800081e4:	00008067          	ret

00000000800081e8 <plicinithart>:
    800081e8:	ff010113          	addi	sp,sp,-16
    800081ec:	00813023          	sd	s0,0(sp)
    800081f0:	00113423          	sd	ra,8(sp)
    800081f4:	01010413          	addi	s0,sp,16
    800081f8:	00000097          	auipc	ra,0x0
    800081fc:	a48080e7          	jalr	-1464(ra) # 80007c40 <cpuid>
    80008200:	0085171b          	slliw	a4,a0,0x8
    80008204:	0c0027b7          	lui	a5,0xc002
    80008208:	00e787b3          	add	a5,a5,a4
    8000820c:	40200713          	li	a4,1026
    80008210:	08e7a023          	sw	a4,128(a5) # c002080 <_entry-0x73ffdf80>
    80008214:	00813083          	ld	ra,8(sp)
    80008218:	00013403          	ld	s0,0(sp)
    8000821c:	00d5151b          	slliw	a0,a0,0xd
    80008220:	0c2017b7          	lui	a5,0xc201
    80008224:	00a78533          	add	a0,a5,a0
    80008228:	00052023          	sw	zero,0(a0)
    8000822c:	01010113          	addi	sp,sp,16
    80008230:	00008067          	ret

0000000080008234 <plic_claim>:
    80008234:	ff010113          	addi	sp,sp,-16
    80008238:	00813023          	sd	s0,0(sp)
    8000823c:	00113423          	sd	ra,8(sp)
    80008240:	01010413          	addi	s0,sp,16
    80008244:	00000097          	auipc	ra,0x0
    80008248:	9fc080e7          	jalr	-1540(ra) # 80007c40 <cpuid>
    8000824c:	00813083          	ld	ra,8(sp)
    80008250:	00013403          	ld	s0,0(sp)
    80008254:	00d5151b          	slliw	a0,a0,0xd
    80008258:	0c2017b7          	lui	a5,0xc201
    8000825c:	00a78533          	add	a0,a5,a0
    80008260:	00452503          	lw	a0,4(a0)
    80008264:	01010113          	addi	sp,sp,16
    80008268:	00008067          	ret

000000008000826c <plic_complete>:
    8000826c:	fe010113          	addi	sp,sp,-32
    80008270:	00813823          	sd	s0,16(sp)
    80008274:	00913423          	sd	s1,8(sp)
    80008278:	00113c23          	sd	ra,24(sp)
    8000827c:	02010413          	addi	s0,sp,32
    80008280:	00050493          	mv	s1,a0
    80008284:	00000097          	auipc	ra,0x0
    80008288:	9bc080e7          	jalr	-1604(ra) # 80007c40 <cpuid>
    8000828c:	01813083          	ld	ra,24(sp)
    80008290:	01013403          	ld	s0,16(sp)
    80008294:	00d5179b          	slliw	a5,a0,0xd
    80008298:	0c201737          	lui	a4,0xc201
    8000829c:	00f707b3          	add	a5,a4,a5
    800082a0:	0097a223          	sw	s1,4(a5) # c201004 <_entry-0x73dfeffc>
    800082a4:	00813483          	ld	s1,8(sp)
    800082a8:	02010113          	addi	sp,sp,32
    800082ac:	00008067          	ret

00000000800082b0 <consolewrite>:
    800082b0:	fb010113          	addi	sp,sp,-80
    800082b4:	04813023          	sd	s0,64(sp)
    800082b8:	04113423          	sd	ra,72(sp)
    800082bc:	02913c23          	sd	s1,56(sp)
    800082c0:	03213823          	sd	s2,48(sp)
    800082c4:	03313423          	sd	s3,40(sp)
    800082c8:	03413023          	sd	s4,32(sp)
    800082cc:	01513c23          	sd	s5,24(sp)
    800082d0:	05010413          	addi	s0,sp,80
    800082d4:	06c05c63          	blez	a2,8000834c <consolewrite+0x9c>
    800082d8:	00060993          	mv	s3,a2
    800082dc:	00050a13          	mv	s4,a0
    800082e0:	00058493          	mv	s1,a1
    800082e4:	00000913          	li	s2,0
    800082e8:	fff00a93          	li	s5,-1
    800082ec:	01c0006f          	j	80008308 <consolewrite+0x58>
    800082f0:	fbf44503          	lbu	a0,-65(s0)
    800082f4:	0019091b          	addiw	s2,s2,1
    800082f8:	00148493          	addi	s1,s1,1
    800082fc:	00001097          	auipc	ra,0x1
    80008300:	a9c080e7          	jalr	-1380(ra) # 80008d98 <uartputc>
    80008304:	03298063          	beq	s3,s2,80008324 <consolewrite+0x74>
    80008308:	00048613          	mv	a2,s1
    8000830c:	00100693          	li	a3,1
    80008310:	000a0593          	mv	a1,s4
    80008314:	fbf40513          	addi	a0,s0,-65
    80008318:	00000097          	auipc	ra,0x0
    8000831c:	9e0080e7          	jalr	-1568(ra) # 80007cf8 <either_copyin>
    80008320:	fd5518e3          	bne	a0,s5,800082f0 <consolewrite+0x40>
    80008324:	04813083          	ld	ra,72(sp)
    80008328:	04013403          	ld	s0,64(sp)
    8000832c:	03813483          	ld	s1,56(sp)
    80008330:	02813983          	ld	s3,40(sp)
    80008334:	02013a03          	ld	s4,32(sp)
    80008338:	01813a83          	ld	s5,24(sp)
    8000833c:	00090513          	mv	a0,s2
    80008340:	03013903          	ld	s2,48(sp)
    80008344:	05010113          	addi	sp,sp,80
    80008348:	00008067          	ret
    8000834c:	00000913          	li	s2,0
    80008350:	fd5ff06f          	j	80008324 <consolewrite+0x74>

0000000080008354 <consoleread>:
    80008354:	f9010113          	addi	sp,sp,-112
    80008358:	06813023          	sd	s0,96(sp)
    8000835c:	04913c23          	sd	s1,88(sp)
    80008360:	05213823          	sd	s2,80(sp)
    80008364:	05313423          	sd	s3,72(sp)
    80008368:	05413023          	sd	s4,64(sp)
    8000836c:	03513c23          	sd	s5,56(sp)
    80008370:	03613823          	sd	s6,48(sp)
    80008374:	03713423          	sd	s7,40(sp)
    80008378:	03813023          	sd	s8,32(sp)
    8000837c:	06113423          	sd	ra,104(sp)
    80008380:	01913c23          	sd	s9,24(sp)
    80008384:	07010413          	addi	s0,sp,112
    80008388:	00060b93          	mv	s7,a2
    8000838c:	00050913          	mv	s2,a0
    80008390:	00058c13          	mv	s8,a1
    80008394:	00060b1b          	sext.w	s6,a2
    80008398:	00009497          	auipc	s1,0x9
    8000839c:	f0048493          	addi	s1,s1,-256 # 80011298 <cons>
    800083a0:	00400993          	li	s3,4
    800083a4:	fff00a13          	li	s4,-1
    800083a8:	00a00a93          	li	s5,10
    800083ac:	05705e63          	blez	s7,80008408 <consoleread+0xb4>
    800083b0:	09c4a703          	lw	a4,156(s1)
    800083b4:	0984a783          	lw	a5,152(s1)
    800083b8:	0007071b          	sext.w	a4,a4
    800083bc:	08e78463          	beq	a5,a4,80008444 <consoleread+0xf0>
    800083c0:	07f7f713          	andi	a4,a5,127
    800083c4:	00e48733          	add	a4,s1,a4
    800083c8:	01874703          	lbu	a4,24(a4) # c201018 <_entry-0x73dfefe8>
    800083cc:	0017869b          	addiw	a3,a5,1
    800083d0:	08d4ac23          	sw	a3,152(s1)
    800083d4:	00070c9b          	sext.w	s9,a4
    800083d8:	0b370663          	beq	a4,s3,80008484 <consoleread+0x130>
    800083dc:	00100693          	li	a3,1
    800083e0:	f9f40613          	addi	a2,s0,-97
    800083e4:	000c0593          	mv	a1,s8
    800083e8:	00090513          	mv	a0,s2
    800083ec:	f8e40fa3          	sb	a4,-97(s0)
    800083f0:	00000097          	auipc	ra,0x0
    800083f4:	8bc080e7          	jalr	-1860(ra) # 80007cac <either_copyout>
    800083f8:	01450863          	beq	a0,s4,80008408 <consoleread+0xb4>
    800083fc:	001c0c13          	addi	s8,s8,1
    80008400:	fffb8b9b          	addiw	s7,s7,-1
    80008404:	fb5c94e3          	bne	s9,s5,800083ac <consoleread+0x58>
    80008408:	000b851b          	sext.w	a0,s7
    8000840c:	06813083          	ld	ra,104(sp)
    80008410:	06013403          	ld	s0,96(sp)
    80008414:	05813483          	ld	s1,88(sp)
    80008418:	05013903          	ld	s2,80(sp)
    8000841c:	04813983          	ld	s3,72(sp)
    80008420:	04013a03          	ld	s4,64(sp)
    80008424:	03813a83          	ld	s5,56(sp)
    80008428:	02813b83          	ld	s7,40(sp)
    8000842c:	02013c03          	ld	s8,32(sp)
    80008430:	01813c83          	ld	s9,24(sp)
    80008434:	40ab053b          	subw	a0,s6,a0
    80008438:	03013b03          	ld	s6,48(sp)
    8000843c:	07010113          	addi	sp,sp,112
    80008440:	00008067          	ret
    80008444:	00001097          	auipc	ra,0x1
    80008448:	1d8080e7          	jalr	472(ra) # 8000961c <push_on>
    8000844c:	0984a703          	lw	a4,152(s1)
    80008450:	09c4a783          	lw	a5,156(s1)
    80008454:	0007879b          	sext.w	a5,a5
    80008458:	fef70ce3          	beq	a4,a5,80008450 <consoleread+0xfc>
    8000845c:	00001097          	auipc	ra,0x1
    80008460:	234080e7          	jalr	564(ra) # 80009690 <pop_on>
    80008464:	0984a783          	lw	a5,152(s1)
    80008468:	07f7f713          	andi	a4,a5,127
    8000846c:	00e48733          	add	a4,s1,a4
    80008470:	01874703          	lbu	a4,24(a4)
    80008474:	0017869b          	addiw	a3,a5,1
    80008478:	08d4ac23          	sw	a3,152(s1)
    8000847c:	00070c9b          	sext.w	s9,a4
    80008480:	f5371ee3          	bne	a4,s3,800083dc <consoleread+0x88>
    80008484:	000b851b          	sext.w	a0,s7
    80008488:	f96bf2e3          	bgeu	s7,s6,8000840c <consoleread+0xb8>
    8000848c:	08f4ac23          	sw	a5,152(s1)
    80008490:	f7dff06f          	j	8000840c <consoleread+0xb8>

0000000080008494 <consputc>:
    80008494:	10000793          	li	a5,256
    80008498:	00f50663          	beq	a0,a5,800084a4 <consputc+0x10>
    8000849c:	00001317          	auipc	t1,0x1
    800084a0:	9f430067          	jr	-1548(t1) # 80008e90 <uartputc_sync>
    800084a4:	ff010113          	addi	sp,sp,-16
    800084a8:	00113423          	sd	ra,8(sp)
    800084ac:	00813023          	sd	s0,0(sp)
    800084b0:	01010413          	addi	s0,sp,16
    800084b4:	00800513          	li	a0,8
    800084b8:	00001097          	auipc	ra,0x1
    800084bc:	9d8080e7          	jalr	-1576(ra) # 80008e90 <uartputc_sync>
    800084c0:	02000513          	li	a0,32
    800084c4:	00001097          	auipc	ra,0x1
    800084c8:	9cc080e7          	jalr	-1588(ra) # 80008e90 <uartputc_sync>
    800084cc:	00013403          	ld	s0,0(sp)
    800084d0:	00813083          	ld	ra,8(sp)
    800084d4:	00800513          	li	a0,8
    800084d8:	01010113          	addi	sp,sp,16
    800084dc:	00001317          	auipc	t1,0x1
    800084e0:	9b430067          	jr	-1612(t1) # 80008e90 <uartputc_sync>

00000000800084e4 <consoleintr>:
    800084e4:	fe010113          	addi	sp,sp,-32
    800084e8:	00813823          	sd	s0,16(sp)
    800084ec:	00913423          	sd	s1,8(sp)
    800084f0:	01213023          	sd	s2,0(sp)
    800084f4:	00113c23          	sd	ra,24(sp)
    800084f8:	02010413          	addi	s0,sp,32
    800084fc:	00009917          	auipc	s2,0x9
    80008500:	d9c90913          	addi	s2,s2,-612 # 80011298 <cons>
    80008504:	00050493          	mv	s1,a0
    80008508:	00090513          	mv	a0,s2
    8000850c:	00001097          	auipc	ra,0x1
    80008510:	e40080e7          	jalr	-448(ra) # 8000934c <acquire>
    80008514:	02048c63          	beqz	s1,8000854c <consoleintr+0x68>
    80008518:	0a092783          	lw	a5,160(s2)
    8000851c:	09892703          	lw	a4,152(s2)
    80008520:	07f00693          	li	a3,127
    80008524:	40e7873b          	subw	a4,a5,a4
    80008528:	02e6e263          	bltu	a3,a4,8000854c <consoleintr+0x68>
    8000852c:	00d00713          	li	a4,13
    80008530:	04e48063          	beq	s1,a4,80008570 <consoleintr+0x8c>
    80008534:	07f7f713          	andi	a4,a5,127
    80008538:	00e90733          	add	a4,s2,a4
    8000853c:	0017879b          	addiw	a5,a5,1
    80008540:	0af92023          	sw	a5,160(s2)
    80008544:	00970c23          	sb	s1,24(a4)
    80008548:	08f92e23          	sw	a5,156(s2)
    8000854c:	01013403          	ld	s0,16(sp)
    80008550:	01813083          	ld	ra,24(sp)
    80008554:	00813483          	ld	s1,8(sp)
    80008558:	00013903          	ld	s2,0(sp)
    8000855c:	00009517          	auipc	a0,0x9
    80008560:	d3c50513          	addi	a0,a0,-708 # 80011298 <cons>
    80008564:	02010113          	addi	sp,sp,32
    80008568:	00001317          	auipc	t1,0x1
    8000856c:	eb030067          	jr	-336(t1) # 80009418 <release>
    80008570:	00a00493          	li	s1,10
    80008574:	fc1ff06f          	j	80008534 <consoleintr+0x50>

0000000080008578 <consoleinit>:
    80008578:	fe010113          	addi	sp,sp,-32
    8000857c:	00113c23          	sd	ra,24(sp)
    80008580:	00813823          	sd	s0,16(sp)
    80008584:	00913423          	sd	s1,8(sp)
    80008588:	02010413          	addi	s0,sp,32
    8000858c:	00009497          	auipc	s1,0x9
    80008590:	d0c48493          	addi	s1,s1,-756 # 80011298 <cons>
    80008594:	00048513          	mv	a0,s1
    80008598:	00002597          	auipc	a1,0x2
    8000859c:	40858593          	addi	a1,a1,1032 # 8000a9a0 <CONSOLE_STATUS+0x990>
    800085a0:	00001097          	auipc	ra,0x1
    800085a4:	d88080e7          	jalr	-632(ra) # 80009328 <initlock>
    800085a8:	00000097          	auipc	ra,0x0
    800085ac:	7ac080e7          	jalr	1964(ra) # 80008d54 <uartinit>
    800085b0:	01813083          	ld	ra,24(sp)
    800085b4:	01013403          	ld	s0,16(sp)
    800085b8:	00000797          	auipc	a5,0x0
    800085bc:	d9c78793          	addi	a5,a5,-612 # 80008354 <consoleread>
    800085c0:	0af4bc23          	sd	a5,184(s1)
    800085c4:	00000797          	auipc	a5,0x0
    800085c8:	cec78793          	addi	a5,a5,-788 # 800082b0 <consolewrite>
    800085cc:	0cf4b023          	sd	a5,192(s1)
    800085d0:	00813483          	ld	s1,8(sp)
    800085d4:	02010113          	addi	sp,sp,32
    800085d8:	00008067          	ret

00000000800085dc <console_read>:
    800085dc:	ff010113          	addi	sp,sp,-16
    800085e0:	00813423          	sd	s0,8(sp)
    800085e4:	01010413          	addi	s0,sp,16
    800085e8:	00813403          	ld	s0,8(sp)
    800085ec:	00009317          	auipc	t1,0x9
    800085f0:	d6433303          	ld	t1,-668(t1) # 80011350 <devsw+0x10>
    800085f4:	01010113          	addi	sp,sp,16
    800085f8:	00030067          	jr	t1

00000000800085fc <console_write>:
    800085fc:	ff010113          	addi	sp,sp,-16
    80008600:	00813423          	sd	s0,8(sp)
    80008604:	01010413          	addi	s0,sp,16
    80008608:	00813403          	ld	s0,8(sp)
    8000860c:	00009317          	auipc	t1,0x9
    80008610:	d4c33303          	ld	t1,-692(t1) # 80011358 <devsw+0x18>
    80008614:	01010113          	addi	sp,sp,16
    80008618:	00030067          	jr	t1

000000008000861c <panic>:
    8000861c:	fe010113          	addi	sp,sp,-32
    80008620:	00113c23          	sd	ra,24(sp)
    80008624:	00813823          	sd	s0,16(sp)
    80008628:	00913423          	sd	s1,8(sp)
    8000862c:	02010413          	addi	s0,sp,32
    80008630:	00050493          	mv	s1,a0
    80008634:	00002517          	auipc	a0,0x2
    80008638:	37450513          	addi	a0,a0,884 # 8000a9a8 <CONSOLE_STATUS+0x998>
    8000863c:	00009797          	auipc	a5,0x9
    80008640:	da07ae23          	sw	zero,-580(a5) # 800113f8 <pr+0x18>
    80008644:	00000097          	auipc	ra,0x0
    80008648:	034080e7          	jalr	52(ra) # 80008678 <__printf>
    8000864c:	00048513          	mv	a0,s1
    80008650:	00000097          	auipc	ra,0x0
    80008654:	028080e7          	jalr	40(ra) # 80008678 <__printf>
    80008658:	00002517          	auipc	a0,0x2
    8000865c:	0d850513          	addi	a0,a0,216 # 8000a730 <CONSOLE_STATUS+0x720>
    80008660:	00000097          	auipc	ra,0x0
    80008664:	018080e7          	jalr	24(ra) # 80008678 <__printf>
    80008668:	00100793          	li	a5,1
    8000866c:	00004717          	auipc	a4,0x4
    80008670:	5cf72e23          	sw	a5,1500(a4) # 8000cc48 <panicked>
    80008674:	0000006f          	j	80008674 <panic+0x58>

0000000080008678 <__printf>:
    80008678:	f3010113          	addi	sp,sp,-208
    8000867c:	08813023          	sd	s0,128(sp)
    80008680:	07313423          	sd	s3,104(sp)
    80008684:	09010413          	addi	s0,sp,144
    80008688:	05813023          	sd	s8,64(sp)
    8000868c:	08113423          	sd	ra,136(sp)
    80008690:	06913c23          	sd	s1,120(sp)
    80008694:	07213823          	sd	s2,112(sp)
    80008698:	07413023          	sd	s4,96(sp)
    8000869c:	05513c23          	sd	s5,88(sp)
    800086a0:	05613823          	sd	s6,80(sp)
    800086a4:	05713423          	sd	s7,72(sp)
    800086a8:	03913c23          	sd	s9,56(sp)
    800086ac:	03a13823          	sd	s10,48(sp)
    800086b0:	03b13423          	sd	s11,40(sp)
    800086b4:	00009317          	auipc	t1,0x9
    800086b8:	d2c30313          	addi	t1,t1,-724 # 800113e0 <pr>
    800086bc:	01832c03          	lw	s8,24(t1)
    800086c0:	00b43423          	sd	a1,8(s0)
    800086c4:	00c43823          	sd	a2,16(s0)
    800086c8:	00d43c23          	sd	a3,24(s0)
    800086cc:	02e43023          	sd	a4,32(s0)
    800086d0:	02f43423          	sd	a5,40(s0)
    800086d4:	03043823          	sd	a6,48(s0)
    800086d8:	03143c23          	sd	a7,56(s0)
    800086dc:	00050993          	mv	s3,a0
    800086e0:	4a0c1663          	bnez	s8,80008b8c <__printf+0x514>
    800086e4:	60098c63          	beqz	s3,80008cfc <__printf+0x684>
    800086e8:	0009c503          	lbu	a0,0(s3)
    800086ec:	00840793          	addi	a5,s0,8
    800086f0:	f6f43c23          	sd	a5,-136(s0)
    800086f4:	00000493          	li	s1,0
    800086f8:	22050063          	beqz	a0,80008918 <__printf+0x2a0>
    800086fc:	00002a37          	lui	s4,0x2
    80008700:	00018ab7          	lui	s5,0x18
    80008704:	000f4b37          	lui	s6,0xf4
    80008708:	00989bb7          	lui	s7,0x989
    8000870c:	70fa0a13          	addi	s4,s4,1807 # 270f <_entry-0x7fffd8f1>
    80008710:	69fa8a93          	addi	s5,s5,1695 # 1869f <_entry-0x7ffe7961>
    80008714:	23fb0b13          	addi	s6,s6,575 # f423f <_entry-0x7ff0bdc1>
    80008718:	67fb8b93          	addi	s7,s7,1663 # 98967f <_entry-0x7f676981>
    8000871c:	00148c9b          	addiw	s9,s1,1
    80008720:	02500793          	li	a5,37
    80008724:	01998933          	add	s2,s3,s9
    80008728:	38f51263          	bne	a0,a5,80008aac <__printf+0x434>
    8000872c:	00094783          	lbu	a5,0(s2)
    80008730:	00078c9b          	sext.w	s9,a5
    80008734:	1e078263          	beqz	a5,80008918 <__printf+0x2a0>
    80008738:	0024849b          	addiw	s1,s1,2
    8000873c:	07000713          	li	a4,112
    80008740:	00998933          	add	s2,s3,s1
    80008744:	38e78a63          	beq	a5,a4,80008ad8 <__printf+0x460>
    80008748:	20f76863          	bltu	a4,a5,80008958 <__printf+0x2e0>
    8000874c:	42a78863          	beq	a5,a0,80008b7c <__printf+0x504>
    80008750:	06400713          	li	a4,100
    80008754:	40e79663          	bne	a5,a4,80008b60 <__printf+0x4e8>
    80008758:	f7843783          	ld	a5,-136(s0)
    8000875c:	0007a603          	lw	a2,0(a5)
    80008760:	00878793          	addi	a5,a5,8
    80008764:	f6f43c23          	sd	a5,-136(s0)
    80008768:	42064a63          	bltz	a2,80008b9c <__printf+0x524>
    8000876c:	00a00713          	li	a4,10
    80008770:	02e677bb          	remuw	a5,a2,a4
    80008774:	00002d97          	auipc	s11,0x2
    80008778:	25cd8d93          	addi	s11,s11,604 # 8000a9d0 <digits>
    8000877c:	00900593          	li	a1,9
    80008780:	0006051b          	sext.w	a0,a2
    80008784:	00000c93          	li	s9,0
    80008788:	02079793          	slli	a5,a5,0x20
    8000878c:	0207d793          	srli	a5,a5,0x20
    80008790:	00fd87b3          	add	a5,s11,a5
    80008794:	0007c783          	lbu	a5,0(a5)
    80008798:	02e656bb          	divuw	a3,a2,a4
    8000879c:	f8f40023          	sb	a5,-128(s0)
    800087a0:	14c5d863          	bge	a1,a2,800088f0 <__printf+0x278>
    800087a4:	06300593          	li	a1,99
    800087a8:	00100c93          	li	s9,1
    800087ac:	02e6f7bb          	remuw	a5,a3,a4
    800087b0:	02079793          	slli	a5,a5,0x20
    800087b4:	0207d793          	srli	a5,a5,0x20
    800087b8:	00fd87b3          	add	a5,s11,a5
    800087bc:	0007c783          	lbu	a5,0(a5)
    800087c0:	02e6d73b          	divuw	a4,a3,a4
    800087c4:	f8f400a3          	sb	a5,-127(s0)
    800087c8:	12a5f463          	bgeu	a1,a0,800088f0 <__printf+0x278>
    800087cc:	00a00693          	li	a3,10
    800087d0:	00900593          	li	a1,9
    800087d4:	02d777bb          	remuw	a5,a4,a3
    800087d8:	02079793          	slli	a5,a5,0x20
    800087dc:	0207d793          	srli	a5,a5,0x20
    800087e0:	00fd87b3          	add	a5,s11,a5
    800087e4:	0007c503          	lbu	a0,0(a5)
    800087e8:	02d757bb          	divuw	a5,a4,a3
    800087ec:	f8a40123          	sb	a0,-126(s0)
    800087f0:	48e5f263          	bgeu	a1,a4,80008c74 <__printf+0x5fc>
    800087f4:	06300513          	li	a0,99
    800087f8:	02d7f5bb          	remuw	a1,a5,a3
    800087fc:	02059593          	slli	a1,a1,0x20
    80008800:	0205d593          	srli	a1,a1,0x20
    80008804:	00bd85b3          	add	a1,s11,a1
    80008808:	0005c583          	lbu	a1,0(a1)
    8000880c:	02d7d7bb          	divuw	a5,a5,a3
    80008810:	f8b401a3          	sb	a1,-125(s0)
    80008814:	48e57263          	bgeu	a0,a4,80008c98 <__printf+0x620>
    80008818:	3e700513          	li	a0,999
    8000881c:	02d7f5bb          	remuw	a1,a5,a3
    80008820:	02059593          	slli	a1,a1,0x20
    80008824:	0205d593          	srli	a1,a1,0x20
    80008828:	00bd85b3          	add	a1,s11,a1
    8000882c:	0005c583          	lbu	a1,0(a1)
    80008830:	02d7d7bb          	divuw	a5,a5,a3
    80008834:	f8b40223          	sb	a1,-124(s0)
    80008838:	46e57663          	bgeu	a0,a4,80008ca4 <__printf+0x62c>
    8000883c:	02d7f5bb          	remuw	a1,a5,a3
    80008840:	02059593          	slli	a1,a1,0x20
    80008844:	0205d593          	srli	a1,a1,0x20
    80008848:	00bd85b3          	add	a1,s11,a1
    8000884c:	0005c583          	lbu	a1,0(a1)
    80008850:	02d7d7bb          	divuw	a5,a5,a3
    80008854:	f8b402a3          	sb	a1,-123(s0)
    80008858:	46ea7863          	bgeu	s4,a4,80008cc8 <__printf+0x650>
    8000885c:	02d7f5bb          	remuw	a1,a5,a3
    80008860:	02059593          	slli	a1,a1,0x20
    80008864:	0205d593          	srli	a1,a1,0x20
    80008868:	00bd85b3          	add	a1,s11,a1
    8000886c:	0005c583          	lbu	a1,0(a1)
    80008870:	02d7d7bb          	divuw	a5,a5,a3
    80008874:	f8b40323          	sb	a1,-122(s0)
    80008878:	3eeaf863          	bgeu	s5,a4,80008c68 <__printf+0x5f0>
    8000887c:	02d7f5bb          	remuw	a1,a5,a3
    80008880:	02059593          	slli	a1,a1,0x20
    80008884:	0205d593          	srli	a1,a1,0x20
    80008888:	00bd85b3          	add	a1,s11,a1
    8000888c:	0005c583          	lbu	a1,0(a1)
    80008890:	02d7d7bb          	divuw	a5,a5,a3
    80008894:	f8b403a3          	sb	a1,-121(s0)
    80008898:	42eb7e63          	bgeu	s6,a4,80008cd4 <__printf+0x65c>
    8000889c:	02d7f5bb          	remuw	a1,a5,a3
    800088a0:	02059593          	slli	a1,a1,0x20
    800088a4:	0205d593          	srli	a1,a1,0x20
    800088a8:	00bd85b3          	add	a1,s11,a1
    800088ac:	0005c583          	lbu	a1,0(a1)
    800088b0:	02d7d7bb          	divuw	a5,a5,a3
    800088b4:	f8b40423          	sb	a1,-120(s0)
    800088b8:	42ebfc63          	bgeu	s7,a4,80008cf0 <__printf+0x678>
    800088bc:	02079793          	slli	a5,a5,0x20
    800088c0:	0207d793          	srli	a5,a5,0x20
    800088c4:	00fd8db3          	add	s11,s11,a5
    800088c8:	000dc703          	lbu	a4,0(s11)
    800088cc:	00a00793          	li	a5,10
    800088d0:	00900c93          	li	s9,9
    800088d4:	f8e404a3          	sb	a4,-119(s0)
    800088d8:	00065c63          	bgez	a2,800088f0 <__printf+0x278>
    800088dc:	f9040713          	addi	a4,s0,-112
    800088e0:	00f70733          	add	a4,a4,a5
    800088e4:	02d00693          	li	a3,45
    800088e8:	fed70823          	sb	a3,-16(a4)
    800088ec:	00078c93          	mv	s9,a5
    800088f0:	f8040793          	addi	a5,s0,-128
    800088f4:	01978cb3          	add	s9,a5,s9
    800088f8:	f7f40d13          	addi	s10,s0,-129
    800088fc:	000cc503          	lbu	a0,0(s9)
    80008900:	fffc8c93          	addi	s9,s9,-1
    80008904:	00000097          	auipc	ra,0x0
    80008908:	b90080e7          	jalr	-1136(ra) # 80008494 <consputc>
    8000890c:	ffac98e3          	bne	s9,s10,800088fc <__printf+0x284>
    80008910:	00094503          	lbu	a0,0(s2)
    80008914:	e00514e3          	bnez	a0,8000871c <__printf+0xa4>
    80008918:	1a0c1663          	bnez	s8,80008ac4 <__printf+0x44c>
    8000891c:	08813083          	ld	ra,136(sp)
    80008920:	08013403          	ld	s0,128(sp)
    80008924:	07813483          	ld	s1,120(sp)
    80008928:	07013903          	ld	s2,112(sp)
    8000892c:	06813983          	ld	s3,104(sp)
    80008930:	06013a03          	ld	s4,96(sp)
    80008934:	05813a83          	ld	s5,88(sp)
    80008938:	05013b03          	ld	s6,80(sp)
    8000893c:	04813b83          	ld	s7,72(sp)
    80008940:	04013c03          	ld	s8,64(sp)
    80008944:	03813c83          	ld	s9,56(sp)
    80008948:	03013d03          	ld	s10,48(sp)
    8000894c:	02813d83          	ld	s11,40(sp)
    80008950:	0d010113          	addi	sp,sp,208
    80008954:	00008067          	ret
    80008958:	07300713          	li	a4,115
    8000895c:	1ce78a63          	beq	a5,a4,80008b30 <__printf+0x4b8>
    80008960:	07800713          	li	a4,120
    80008964:	1ee79e63          	bne	a5,a4,80008b60 <__printf+0x4e8>
    80008968:	f7843783          	ld	a5,-136(s0)
    8000896c:	0007a703          	lw	a4,0(a5)
    80008970:	00878793          	addi	a5,a5,8
    80008974:	f6f43c23          	sd	a5,-136(s0)
    80008978:	28074263          	bltz	a4,80008bfc <__printf+0x584>
    8000897c:	00002d97          	auipc	s11,0x2
    80008980:	054d8d93          	addi	s11,s11,84 # 8000a9d0 <digits>
    80008984:	00f77793          	andi	a5,a4,15
    80008988:	00fd87b3          	add	a5,s11,a5
    8000898c:	0007c683          	lbu	a3,0(a5)
    80008990:	00f00613          	li	a2,15
    80008994:	0007079b          	sext.w	a5,a4
    80008998:	f8d40023          	sb	a3,-128(s0)
    8000899c:	0047559b          	srliw	a1,a4,0x4
    800089a0:	0047569b          	srliw	a3,a4,0x4
    800089a4:	00000c93          	li	s9,0
    800089a8:	0ee65063          	bge	a2,a4,80008a88 <__printf+0x410>
    800089ac:	00f6f693          	andi	a3,a3,15
    800089b0:	00dd86b3          	add	a3,s11,a3
    800089b4:	0006c683          	lbu	a3,0(a3) # 2004000 <_entry-0x7dffc000>
    800089b8:	0087d79b          	srliw	a5,a5,0x8
    800089bc:	00100c93          	li	s9,1
    800089c0:	f8d400a3          	sb	a3,-127(s0)
    800089c4:	0cb67263          	bgeu	a2,a1,80008a88 <__printf+0x410>
    800089c8:	00f7f693          	andi	a3,a5,15
    800089cc:	00dd86b3          	add	a3,s11,a3
    800089d0:	0006c583          	lbu	a1,0(a3)
    800089d4:	00f00613          	li	a2,15
    800089d8:	0047d69b          	srliw	a3,a5,0x4
    800089dc:	f8b40123          	sb	a1,-126(s0)
    800089e0:	0047d593          	srli	a1,a5,0x4
    800089e4:	28f67e63          	bgeu	a2,a5,80008c80 <__printf+0x608>
    800089e8:	00f6f693          	andi	a3,a3,15
    800089ec:	00dd86b3          	add	a3,s11,a3
    800089f0:	0006c503          	lbu	a0,0(a3)
    800089f4:	0087d813          	srli	a6,a5,0x8
    800089f8:	0087d69b          	srliw	a3,a5,0x8
    800089fc:	f8a401a3          	sb	a0,-125(s0)
    80008a00:	28b67663          	bgeu	a2,a1,80008c8c <__printf+0x614>
    80008a04:	00f6f693          	andi	a3,a3,15
    80008a08:	00dd86b3          	add	a3,s11,a3
    80008a0c:	0006c583          	lbu	a1,0(a3)
    80008a10:	00c7d513          	srli	a0,a5,0xc
    80008a14:	00c7d69b          	srliw	a3,a5,0xc
    80008a18:	f8b40223          	sb	a1,-124(s0)
    80008a1c:	29067a63          	bgeu	a2,a6,80008cb0 <__printf+0x638>
    80008a20:	00f6f693          	andi	a3,a3,15
    80008a24:	00dd86b3          	add	a3,s11,a3
    80008a28:	0006c583          	lbu	a1,0(a3)
    80008a2c:	0107d813          	srli	a6,a5,0x10
    80008a30:	0107d69b          	srliw	a3,a5,0x10
    80008a34:	f8b402a3          	sb	a1,-123(s0)
    80008a38:	28a67263          	bgeu	a2,a0,80008cbc <__printf+0x644>
    80008a3c:	00f6f693          	andi	a3,a3,15
    80008a40:	00dd86b3          	add	a3,s11,a3
    80008a44:	0006c683          	lbu	a3,0(a3)
    80008a48:	0147d79b          	srliw	a5,a5,0x14
    80008a4c:	f8d40323          	sb	a3,-122(s0)
    80008a50:	21067663          	bgeu	a2,a6,80008c5c <__printf+0x5e4>
    80008a54:	02079793          	slli	a5,a5,0x20
    80008a58:	0207d793          	srli	a5,a5,0x20
    80008a5c:	00fd8db3          	add	s11,s11,a5
    80008a60:	000dc683          	lbu	a3,0(s11)
    80008a64:	00800793          	li	a5,8
    80008a68:	00700c93          	li	s9,7
    80008a6c:	f8d403a3          	sb	a3,-121(s0)
    80008a70:	00075c63          	bgez	a4,80008a88 <__printf+0x410>
    80008a74:	f9040713          	addi	a4,s0,-112
    80008a78:	00f70733          	add	a4,a4,a5
    80008a7c:	02d00693          	li	a3,45
    80008a80:	fed70823          	sb	a3,-16(a4)
    80008a84:	00078c93          	mv	s9,a5
    80008a88:	f8040793          	addi	a5,s0,-128
    80008a8c:	01978cb3          	add	s9,a5,s9
    80008a90:	f7f40d13          	addi	s10,s0,-129
    80008a94:	000cc503          	lbu	a0,0(s9)
    80008a98:	fffc8c93          	addi	s9,s9,-1
    80008a9c:	00000097          	auipc	ra,0x0
    80008aa0:	9f8080e7          	jalr	-1544(ra) # 80008494 <consputc>
    80008aa4:	ff9d18e3          	bne	s10,s9,80008a94 <__printf+0x41c>
    80008aa8:	0100006f          	j	80008ab8 <__printf+0x440>
    80008aac:	00000097          	auipc	ra,0x0
    80008ab0:	9e8080e7          	jalr	-1560(ra) # 80008494 <consputc>
    80008ab4:	000c8493          	mv	s1,s9
    80008ab8:	00094503          	lbu	a0,0(s2)
    80008abc:	c60510e3          	bnez	a0,8000871c <__printf+0xa4>
    80008ac0:	e40c0ee3          	beqz	s8,8000891c <__printf+0x2a4>
    80008ac4:	00009517          	auipc	a0,0x9
    80008ac8:	91c50513          	addi	a0,a0,-1764 # 800113e0 <pr>
    80008acc:	00001097          	auipc	ra,0x1
    80008ad0:	94c080e7          	jalr	-1716(ra) # 80009418 <release>
    80008ad4:	e49ff06f          	j	8000891c <__printf+0x2a4>
    80008ad8:	f7843783          	ld	a5,-136(s0)
    80008adc:	03000513          	li	a0,48
    80008ae0:	01000d13          	li	s10,16
    80008ae4:	00878713          	addi	a4,a5,8
    80008ae8:	0007bc83          	ld	s9,0(a5)
    80008aec:	f6e43c23          	sd	a4,-136(s0)
    80008af0:	00000097          	auipc	ra,0x0
    80008af4:	9a4080e7          	jalr	-1628(ra) # 80008494 <consputc>
    80008af8:	07800513          	li	a0,120
    80008afc:	00000097          	auipc	ra,0x0
    80008b00:	998080e7          	jalr	-1640(ra) # 80008494 <consputc>
    80008b04:	00002d97          	auipc	s11,0x2
    80008b08:	eccd8d93          	addi	s11,s11,-308 # 8000a9d0 <digits>
    80008b0c:	03ccd793          	srli	a5,s9,0x3c
    80008b10:	00fd87b3          	add	a5,s11,a5
    80008b14:	0007c503          	lbu	a0,0(a5)
    80008b18:	fffd0d1b          	addiw	s10,s10,-1
    80008b1c:	004c9c93          	slli	s9,s9,0x4
    80008b20:	00000097          	auipc	ra,0x0
    80008b24:	974080e7          	jalr	-1676(ra) # 80008494 <consputc>
    80008b28:	fe0d12e3          	bnez	s10,80008b0c <__printf+0x494>
    80008b2c:	f8dff06f          	j	80008ab8 <__printf+0x440>
    80008b30:	f7843783          	ld	a5,-136(s0)
    80008b34:	0007bc83          	ld	s9,0(a5)
    80008b38:	00878793          	addi	a5,a5,8
    80008b3c:	f6f43c23          	sd	a5,-136(s0)
    80008b40:	000c9a63          	bnez	s9,80008b54 <__printf+0x4dc>
    80008b44:	1080006f          	j	80008c4c <__printf+0x5d4>
    80008b48:	001c8c93          	addi	s9,s9,1
    80008b4c:	00000097          	auipc	ra,0x0
    80008b50:	948080e7          	jalr	-1720(ra) # 80008494 <consputc>
    80008b54:	000cc503          	lbu	a0,0(s9)
    80008b58:	fe0518e3          	bnez	a0,80008b48 <__printf+0x4d0>
    80008b5c:	f5dff06f          	j	80008ab8 <__printf+0x440>
    80008b60:	02500513          	li	a0,37
    80008b64:	00000097          	auipc	ra,0x0
    80008b68:	930080e7          	jalr	-1744(ra) # 80008494 <consputc>
    80008b6c:	000c8513          	mv	a0,s9
    80008b70:	00000097          	auipc	ra,0x0
    80008b74:	924080e7          	jalr	-1756(ra) # 80008494 <consputc>
    80008b78:	f41ff06f          	j	80008ab8 <__printf+0x440>
    80008b7c:	02500513          	li	a0,37
    80008b80:	00000097          	auipc	ra,0x0
    80008b84:	914080e7          	jalr	-1772(ra) # 80008494 <consputc>
    80008b88:	f31ff06f          	j	80008ab8 <__printf+0x440>
    80008b8c:	00030513          	mv	a0,t1
    80008b90:	00000097          	auipc	ra,0x0
    80008b94:	7bc080e7          	jalr	1980(ra) # 8000934c <acquire>
    80008b98:	b4dff06f          	j	800086e4 <__printf+0x6c>
    80008b9c:	40c0053b          	negw	a0,a2
    80008ba0:	00a00713          	li	a4,10
    80008ba4:	02e576bb          	remuw	a3,a0,a4
    80008ba8:	00002d97          	auipc	s11,0x2
    80008bac:	e28d8d93          	addi	s11,s11,-472 # 8000a9d0 <digits>
    80008bb0:	ff700593          	li	a1,-9
    80008bb4:	02069693          	slli	a3,a3,0x20
    80008bb8:	0206d693          	srli	a3,a3,0x20
    80008bbc:	00dd86b3          	add	a3,s11,a3
    80008bc0:	0006c683          	lbu	a3,0(a3)
    80008bc4:	02e557bb          	divuw	a5,a0,a4
    80008bc8:	f8d40023          	sb	a3,-128(s0)
    80008bcc:	10b65e63          	bge	a2,a1,80008ce8 <__printf+0x670>
    80008bd0:	06300593          	li	a1,99
    80008bd4:	02e7f6bb          	remuw	a3,a5,a4
    80008bd8:	02069693          	slli	a3,a3,0x20
    80008bdc:	0206d693          	srli	a3,a3,0x20
    80008be0:	00dd86b3          	add	a3,s11,a3
    80008be4:	0006c683          	lbu	a3,0(a3)
    80008be8:	02e7d73b          	divuw	a4,a5,a4
    80008bec:	00200793          	li	a5,2
    80008bf0:	f8d400a3          	sb	a3,-127(s0)
    80008bf4:	bca5ece3          	bltu	a1,a0,800087cc <__printf+0x154>
    80008bf8:	ce5ff06f          	j	800088dc <__printf+0x264>
    80008bfc:	40e007bb          	negw	a5,a4
    80008c00:	00002d97          	auipc	s11,0x2
    80008c04:	dd0d8d93          	addi	s11,s11,-560 # 8000a9d0 <digits>
    80008c08:	00f7f693          	andi	a3,a5,15
    80008c0c:	00dd86b3          	add	a3,s11,a3
    80008c10:	0006c583          	lbu	a1,0(a3)
    80008c14:	ff100613          	li	a2,-15
    80008c18:	0047d69b          	srliw	a3,a5,0x4
    80008c1c:	f8b40023          	sb	a1,-128(s0)
    80008c20:	0047d59b          	srliw	a1,a5,0x4
    80008c24:	0ac75e63          	bge	a4,a2,80008ce0 <__printf+0x668>
    80008c28:	00f6f693          	andi	a3,a3,15
    80008c2c:	00dd86b3          	add	a3,s11,a3
    80008c30:	0006c603          	lbu	a2,0(a3)
    80008c34:	00f00693          	li	a3,15
    80008c38:	0087d79b          	srliw	a5,a5,0x8
    80008c3c:	f8c400a3          	sb	a2,-127(s0)
    80008c40:	d8b6e4e3          	bltu	a3,a1,800089c8 <__printf+0x350>
    80008c44:	00200793          	li	a5,2
    80008c48:	e2dff06f          	j	80008a74 <__printf+0x3fc>
    80008c4c:	00002c97          	auipc	s9,0x2
    80008c50:	d64c8c93          	addi	s9,s9,-668 # 8000a9b0 <CONSOLE_STATUS+0x9a0>
    80008c54:	02800513          	li	a0,40
    80008c58:	ef1ff06f          	j	80008b48 <__printf+0x4d0>
    80008c5c:	00700793          	li	a5,7
    80008c60:	00600c93          	li	s9,6
    80008c64:	e0dff06f          	j	80008a70 <__printf+0x3f8>
    80008c68:	00700793          	li	a5,7
    80008c6c:	00600c93          	li	s9,6
    80008c70:	c69ff06f          	j	800088d8 <__printf+0x260>
    80008c74:	00300793          	li	a5,3
    80008c78:	00200c93          	li	s9,2
    80008c7c:	c5dff06f          	j	800088d8 <__printf+0x260>
    80008c80:	00300793          	li	a5,3
    80008c84:	00200c93          	li	s9,2
    80008c88:	de9ff06f          	j	80008a70 <__printf+0x3f8>
    80008c8c:	00400793          	li	a5,4
    80008c90:	00300c93          	li	s9,3
    80008c94:	dddff06f          	j	80008a70 <__printf+0x3f8>
    80008c98:	00400793          	li	a5,4
    80008c9c:	00300c93          	li	s9,3
    80008ca0:	c39ff06f          	j	800088d8 <__printf+0x260>
    80008ca4:	00500793          	li	a5,5
    80008ca8:	00400c93          	li	s9,4
    80008cac:	c2dff06f          	j	800088d8 <__printf+0x260>
    80008cb0:	00500793          	li	a5,5
    80008cb4:	00400c93          	li	s9,4
    80008cb8:	db9ff06f          	j	80008a70 <__printf+0x3f8>
    80008cbc:	00600793          	li	a5,6
    80008cc0:	00500c93          	li	s9,5
    80008cc4:	dadff06f          	j	80008a70 <__printf+0x3f8>
    80008cc8:	00600793          	li	a5,6
    80008ccc:	00500c93          	li	s9,5
    80008cd0:	c09ff06f          	j	800088d8 <__printf+0x260>
    80008cd4:	00800793          	li	a5,8
    80008cd8:	00700c93          	li	s9,7
    80008cdc:	bfdff06f          	j	800088d8 <__printf+0x260>
    80008ce0:	00100793          	li	a5,1
    80008ce4:	d91ff06f          	j	80008a74 <__printf+0x3fc>
    80008ce8:	00100793          	li	a5,1
    80008cec:	bf1ff06f          	j	800088dc <__printf+0x264>
    80008cf0:	00900793          	li	a5,9
    80008cf4:	00800c93          	li	s9,8
    80008cf8:	be1ff06f          	j	800088d8 <__printf+0x260>
    80008cfc:	00002517          	auipc	a0,0x2
    80008d00:	cbc50513          	addi	a0,a0,-836 # 8000a9b8 <CONSOLE_STATUS+0x9a8>
    80008d04:	00000097          	auipc	ra,0x0
    80008d08:	918080e7          	jalr	-1768(ra) # 8000861c <panic>

0000000080008d0c <printfinit>:
    80008d0c:	fe010113          	addi	sp,sp,-32
    80008d10:	00813823          	sd	s0,16(sp)
    80008d14:	00913423          	sd	s1,8(sp)
    80008d18:	00113c23          	sd	ra,24(sp)
    80008d1c:	02010413          	addi	s0,sp,32
    80008d20:	00008497          	auipc	s1,0x8
    80008d24:	6c048493          	addi	s1,s1,1728 # 800113e0 <pr>
    80008d28:	00048513          	mv	a0,s1
    80008d2c:	00002597          	auipc	a1,0x2
    80008d30:	c9c58593          	addi	a1,a1,-868 # 8000a9c8 <CONSOLE_STATUS+0x9b8>
    80008d34:	00000097          	auipc	ra,0x0
    80008d38:	5f4080e7          	jalr	1524(ra) # 80009328 <initlock>
    80008d3c:	01813083          	ld	ra,24(sp)
    80008d40:	01013403          	ld	s0,16(sp)
    80008d44:	0004ac23          	sw	zero,24(s1)
    80008d48:	00813483          	ld	s1,8(sp)
    80008d4c:	02010113          	addi	sp,sp,32
    80008d50:	00008067          	ret

0000000080008d54 <uartinit>:
    80008d54:	ff010113          	addi	sp,sp,-16
    80008d58:	00813423          	sd	s0,8(sp)
    80008d5c:	01010413          	addi	s0,sp,16
    80008d60:	100007b7          	lui	a5,0x10000
    80008d64:	000780a3          	sb	zero,1(a5) # 10000001 <_entry-0x6fffffff>
    80008d68:	f8000713          	li	a4,-128
    80008d6c:	00e781a3          	sb	a4,3(a5)
    80008d70:	00300713          	li	a4,3
    80008d74:	00e78023          	sb	a4,0(a5)
    80008d78:	000780a3          	sb	zero,1(a5)
    80008d7c:	00e781a3          	sb	a4,3(a5)
    80008d80:	00700693          	li	a3,7
    80008d84:	00d78123          	sb	a3,2(a5)
    80008d88:	00e780a3          	sb	a4,1(a5)
    80008d8c:	00813403          	ld	s0,8(sp)
    80008d90:	01010113          	addi	sp,sp,16
    80008d94:	00008067          	ret

0000000080008d98 <uartputc>:
    80008d98:	00004797          	auipc	a5,0x4
    80008d9c:	eb07a783          	lw	a5,-336(a5) # 8000cc48 <panicked>
    80008da0:	00078463          	beqz	a5,80008da8 <uartputc+0x10>
    80008da4:	0000006f          	j	80008da4 <uartputc+0xc>
    80008da8:	fd010113          	addi	sp,sp,-48
    80008dac:	02813023          	sd	s0,32(sp)
    80008db0:	00913c23          	sd	s1,24(sp)
    80008db4:	01213823          	sd	s2,16(sp)
    80008db8:	01313423          	sd	s3,8(sp)
    80008dbc:	02113423          	sd	ra,40(sp)
    80008dc0:	03010413          	addi	s0,sp,48
    80008dc4:	00004917          	auipc	s2,0x4
    80008dc8:	e8c90913          	addi	s2,s2,-372 # 8000cc50 <uart_tx_r>
    80008dcc:	00093783          	ld	a5,0(s2)
    80008dd0:	00004497          	auipc	s1,0x4
    80008dd4:	e8848493          	addi	s1,s1,-376 # 8000cc58 <uart_tx_w>
    80008dd8:	0004b703          	ld	a4,0(s1)
    80008ddc:	02078693          	addi	a3,a5,32
    80008de0:	00050993          	mv	s3,a0
    80008de4:	02e69c63          	bne	a3,a4,80008e1c <uartputc+0x84>
    80008de8:	00001097          	auipc	ra,0x1
    80008dec:	834080e7          	jalr	-1996(ra) # 8000961c <push_on>
    80008df0:	00093783          	ld	a5,0(s2)
    80008df4:	0004b703          	ld	a4,0(s1)
    80008df8:	02078793          	addi	a5,a5,32
    80008dfc:	00e79463          	bne	a5,a4,80008e04 <uartputc+0x6c>
    80008e00:	0000006f          	j	80008e00 <uartputc+0x68>
    80008e04:	00001097          	auipc	ra,0x1
    80008e08:	88c080e7          	jalr	-1908(ra) # 80009690 <pop_on>
    80008e0c:	00093783          	ld	a5,0(s2)
    80008e10:	0004b703          	ld	a4,0(s1)
    80008e14:	02078693          	addi	a3,a5,32
    80008e18:	fce688e3          	beq	a3,a4,80008de8 <uartputc+0x50>
    80008e1c:	01f77693          	andi	a3,a4,31
    80008e20:	00008597          	auipc	a1,0x8
    80008e24:	5e058593          	addi	a1,a1,1504 # 80011400 <uart_tx_buf>
    80008e28:	00d586b3          	add	a3,a1,a3
    80008e2c:	00170713          	addi	a4,a4,1
    80008e30:	01368023          	sb	s3,0(a3)
    80008e34:	00e4b023          	sd	a4,0(s1)
    80008e38:	10000637          	lui	a2,0x10000
    80008e3c:	02f71063          	bne	a4,a5,80008e5c <uartputc+0xc4>
    80008e40:	0340006f          	j	80008e74 <uartputc+0xdc>
    80008e44:	00074703          	lbu	a4,0(a4)
    80008e48:	00f93023          	sd	a5,0(s2)
    80008e4c:	00e60023          	sb	a4,0(a2) # 10000000 <_entry-0x70000000>
    80008e50:	00093783          	ld	a5,0(s2)
    80008e54:	0004b703          	ld	a4,0(s1)
    80008e58:	00f70e63          	beq	a4,a5,80008e74 <uartputc+0xdc>
    80008e5c:	00564683          	lbu	a3,5(a2)
    80008e60:	01f7f713          	andi	a4,a5,31
    80008e64:	00e58733          	add	a4,a1,a4
    80008e68:	0206f693          	andi	a3,a3,32
    80008e6c:	00178793          	addi	a5,a5,1
    80008e70:	fc069ae3          	bnez	a3,80008e44 <uartputc+0xac>
    80008e74:	02813083          	ld	ra,40(sp)
    80008e78:	02013403          	ld	s0,32(sp)
    80008e7c:	01813483          	ld	s1,24(sp)
    80008e80:	01013903          	ld	s2,16(sp)
    80008e84:	00813983          	ld	s3,8(sp)
    80008e88:	03010113          	addi	sp,sp,48
    80008e8c:	00008067          	ret

0000000080008e90 <uartputc_sync>:
    80008e90:	ff010113          	addi	sp,sp,-16
    80008e94:	00813423          	sd	s0,8(sp)
    80008e98:	01010413          	addi	s0,sp,16
    80008e9c:	00004717          	auipc	a4,0x4
    80008ea0:	dac72703          	lw	a4,-596(a4) # 8000cc48 <panicked>
    80008ea4:	02071663          	bnez	a4,80008ed0 <uartputc_sync+0x40>
    80008ea8:	00050793          	mv	a5,a0
    80008eac:	100006b7          	lui	a3,0x10000
    80008eb0:	0056c703          	lbu	a4,5(a3) # 10000005 <_entry-0x6ffffffb>
    80008eb4:	02077713          	andi	a4,a4,32
    80008eb8:	fe070ce3          	beqz	a4,80008eb0 <uartputc_sync+0x20>
    80008ebc:	0ff7f793          	andi	a5,a5,255
    80008ec0:	00f68023          	sb	a5,0(a3)
    80008ec4:	00813403          	ld	s0,8(sp)
    80008ec8:	01010113          	addi	sp,sp,16
    80008ecc:	00008067          	ret
    80008ed0:	0000006f          	j	80008ed0 <uartputc_sync+0x40>

0000000080008ed4 <uartstart>:
    80008ed4:	ff010113          	addi	sp,sp,-16
    80008ed8:	00813423          	sd	s0,8(sp)
    80008edc:	01010413          	addi	s0,sp,16
    80008ee0:	00004617          	auipc	a2,0x4
    80008ee4:	d7060613          	addi	a2,a2,-656 # 8000cc50 <uart_tx_r>
    80008ee8:	00004517          	auipc	a0,0x4
    80008eec:	d7050513          	addi	a0,a0,-656 # 8000cc58 <uart_tx_w>
    80008ef0:	00063783          	ld	a5,0(a2)
    80008ef4:	00053703          	ld	a4,0(a0)
    80008ef8:	04f70263          	beq	a4,a5,80008f3c <uartstart+0x68>
    80008efc:	100005b7          	lui	a1,0x10000
    80008f00:	00008817          	auipc	a6,0x8
    80008f04:	50080813          	addi	a6,a6,1280 # 80011400 <uart_tx_buf>
    80008f08:	01c0006f          	j	80008f24 <uartstart+0x50>
    80008f0c:	0006c703          	lbu	a4,0(a3)
    80008f10:	00f63023          	sd	a5,0(a2)
    80008f14:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    80008f18:	00063783          	ld	a5,0(a2)
    80008f1c:	00053703          	ld	a4,0(a0)
    80008f20:	00f70e63          	beq	a4,a5,80008f3c <uartstart+0x68>
    80008f24:	01f7f713          	andi	a4,a5,31
    80008f28:	00e806b3          	add	a3,a6,a4
    80008f2c:	0055c703          	lbu	a4,5(a1)
    80008f30:	00178793          	addi	a5,a5,1
    80008f34:	02077713          	andi	a4,a4,32
    80008f38:	fc071ae3          	bnez	a4,80008f0c <uartstart+0x38>
    80008f3c:	00813403          	ld	s0,8(sp)
    80008f40:	01010113          	addi	sp,sp,16
    80008f44:	00008067          	ret

0000000080008f48 <uartgetc>:
    80008f48:	ff010113          	addi	sp,sp,-16
    80008f4c:	00813423          	sd	s0,8(sp)
    80008f50:	01010413          	addi	s0,sp,16
    80008f54:	10000737          	lui	a4,0x10000
    80008f58:	00574783          	lbu	a5,5(a4) # 10000005 <_entry-0x6ffffffb>
    80008f5c:	0017f793          	andi	a5,a5,1
    80008f60:	00078c63          	beqz	a5,80008f78 <uartgetc+0x30>
    80008f64:	00074503          	lbu	a0,0(a4)
    80008f68:	0ff57513          	andi	a0,a0,255
    80008f6c:	00813403          	ld	s0,8(sp)
    80008f70:	01010113          	addi	sp,sp,16
    80008f74:	00008067          	ret
    80008f78:	fff00513          	li	a0,-1
    80008f7c:	ff1ff06f          	j	80008f6c <uartgetc+0x24>

0000000080008f80 <uartintr>:
    80008f80:	100007b7          	lui	a5,0x10000
    80008f84:	0057c783          	lbu	a5,5(a5) # 10000005 <_entry-0x6ffffffb>
    80008f88:	0017f793          	andi	a5,a5,1
    80008f8c:	0a078463          	beqz	a5,80009034 <uartintr+0xb4>
    80008f90:	fe010113          	addi	sp,sp,-32
    80008f94:	00813823          	sd	s0,16(sp)
    80008f98:	00913423          	sd	s1,8(sp)
    80008f9c:	00113c23          	sd	ra,24(sp)
    80008fa0:	02010413          	addi	s0,sp,32
    80008fa4:	100004b7          	lui	s1,0x10000
    80008fa8:	0004c503          	lbu	a0,0(s1) # 10000000 <_entry-0x70000000>
    80008fac:	0ff57513          	andi	a0,a0,255
    80008fb0:	fffff097          	auipc	ra,0xfffff
    80008fb4:	534080e7          	jalr	1332(ra) # 800084e4 <consoleintr>
    80008fb8:	0054c783          	lbu	a5,5(s1)
    80008fbc:	0017f793          	andi	a5,a5,1
    80008fc0:	fe0794e3          	bnez	a5,80008fa8 <uartintr+0x28>
    80008fc4:	00004617          	auipc	a2,0x4
    80008fc8:	c8c60613          	addi	a2,a2,-884 # 8000cc50 <uart_tx_r>
    80008fcc:	00004517          	auipc	a0,0x4
    80008fd0:	c8c50513          	addi	a0,a0,-884 # 8000cc58 <uart_tx_w>
    80008fd4:	00063783          	ld	a5,0(a2)
    80008fd8:	00053703          	ld	a4,0(a0)
    80008fdc:	04f70263          	beq	a4,a5,80009020 <uartintr+0xa0>
    80008fe0:	100005b7          	lui	a1,0x10000
    80008fe4:	00008817          	auipc	a6,0x8
    80008fe8:	41c80813          	addi	a6,a6,1052 # 80011400 <uart_tx_buf>
    80008fec:	01c0006f          	j	80009008 <uartintr+0x88>
    80008ff0:	0006c703          	lbu	a4,0(a3)
    80008ff4:	00f63023          	sd	a5,0(a2)
    80008ff8:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    80008ffc:	00063783          	ld	a5,0(a2)
    80009000:	00053703          	ld	a4,0(a0)
    80009004:	00f70e63          	beq	a4,a5,80009020 <uartintr+0xa0>
    80009008:	01f7f713          	andi	a4,a5,31
    8000900c:	00e806b3          	add	a3,a6,a4
    80009010:	0055c703          	lbu	a4,5(a1)
    80009014:	00178793          	addi	a5,a5,1
    80009018:	02077713          	andi	a4,a4,32
    8000901c:	fc071ae3          	bnez	a4,80008ff0 <uartintr+0x70>
    80009020:	01813083          	ld	ra,24(sp)
    80009024:	01013403          	ld	s0,16(sp)
    80009028:	00813483          	ld	s1,8(sp)
    8000902c:	02010113          	addi	sp,sp,32
    80009030:	00008067          	ret
    80009034:	00004617          	auipc	a2,0x4
    80009038:	c1c60613          	addi	a2,a2,-996 # 8000cc50 <uart_tx_r>
    8000903c:	00004517          	auipc	a0,0x4
    80009040:	c1c50513          	addi	a0,a0,-996 # 8000cc58 <uart_tx_w>
    80009044:	00063783          	ld	a5,0(a2)
    80009048:	00053703          	ld	a4,0(a0)
    8000904c:	04f70263          	beq	a4,a5,80009090 <uartintr+0x110>
    80009050:	100005b7          	lui	a1,0x10000
    80009054:	00008817          	auipc	a6,0x8
    80009058:	3ac80813          	addi	a6,a6,940 # 80011400 <uart_tx_buf>
    8000905c:	01c0006f          	j	80009078 <uartintr+0xf8>
    80009060:	0006c703          	lbu	a4,0(a3)
    80009064:	00f63023          	sd	a5,0(a2)
    80009068:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    8000906c:	00063783          	ld	a5,0(a2)
    80009070:	00053703          	ld	a4,0(a0)
    80009074:	02f70063          	beq	a4,a5,80009094 <uartintr+0x114>
    80009078:	01f7f713          	andi	a4,a5,31
    8000907c:	00e806b3          	add	a3,a6,a4
    80009080:	0055c703          	lbu	a4,5(a1)
    80009084:	00178793          	addi	a5,a5,1
    80009088:	02077713          	andi	a4,a4,32
    8000908c:	fc071ae3          	bnez	a4,80009060 <uartintr+0xe0>
    80009090:	00008067          	ret
    80009094:	00008067          	ret

0000000080009098 <kinit>:
    80009098:	fc010113          	addi	sp,sp,-64
    8000909c:	02913423          	sd	s1,40(sp)
    800090a0:	fffff7b7          	lui	a5,0xfffff
    800090a4:	00009497          	auipc	s1,0x9
    800090a8:	37b48493          	addi	s1,s1,891 # 8001241f <end+0xfff>
    800090ac:	02813823          	sd	s0,48(sp)
    800090b0:	01313c23          	sd	s3,24(sp)
    800090b4:	00f4f4b3          	and	s1,s1,a5
    800090b8:	02113c23          	sd	ra,56(sp)
    800090bc:	03213023          	sd	s2,32(sp)
    800090c0:	01413823          	sd	s4,16(sp)
    800090c4:	01513423          	sd	s5,8(sp)
    800090c8:	04010413          	addi	s0,sp,64
    800090cc:	000017b7          	lui	a5,0x1
    800090d0:	01100993          	li	s3,17
    800090d4:	00f487b3          	add	a5,s1,a5
    800090d8:	01b99993          	slli	s3,s3,0x1b
    800090dc:	06f9e063          	bltu	s3,a5,8000913c <kinit+0xa4>
    800090e0:	00008a97          	auipc	s5,0x8
    800090e4:	340a8a93          	addi	s5,s5,832 # 80011420 <end>
    800090e8:	0754ec63          	bltu	s1,s5,80009160 <kinit+0xc8>
    800090ec:	0734fa63          	bgeu	s1,s3,80009160 <kinit+0xc8>
    800090f0:	00088a37          	lui	s4,0x88
    800090f4:	fffa0a13          	addi	s4,s4,-1 # 87fff <_entry-0x7ff78001>
    800090f8:	00004917          	auipc	s2,0x4
    800090fc:	b6890913          	addi	s2,s2,-1176 # 8000cc60 <kmem>
    80009100:	00ca1a13          	slli	s4,s4,0xc
    80009104:	0140006f          	j	80009118 <kinit+0x80>
    80009108:	000017b7          	lui	a5,0x1
    8000910c:	00f484b3          	add	s1,s1,a5
    80009110:	0554e863          	bltu	s1,s5,80009160 <kinit+0xc8>
    80009114:	0534f663          	bgeu	s1,s3,80009160 <kinit+0xc8>
    80009118:	00001637          	lui	a2,0x1
    8000911c:	00100593          	li	a1,1
    80009120:	00048513          	mv	a0,s1
    80009124:	00000097          	auipc	ra,0x0
    80009128:	5e4080e7          	jalr	1508(ra) # 80009708 <__memset>
    8000912c:	00093783          	ld	a5,0(s2)
    80009130:	00f4b023          	sd	a5,0(s1)
    80009134:	00993023          	sd	s1,0(s2)
    80009138:	fd4498e3          	bne	s1,s4,80009108 <kinit+0x70>
    8000913c:	03813083          	ld	ra,56(sp)
    80009140:	03013403          	ld	s0,48(sp)
    80009144:	02813483          	ld	s1,40(sp)
    80009148:	02013903          	ld	s2,32(sp)
    8000914c:	01813983          	ld	s3,24(sp)
    80009150:	01013a03          	ld	s4,16(sp)
    80009154:	00813a83          	ld	s5,8(sp)
    80009158:	04010113          	addi	sp,sp,64
    8000915c:	00008067          	ret
    80009160:	00002517          	auipc	a0,0x2
    80009164:	88850513          	addi	a0,a0,-1912 # 8000a9e8 <digits+0x18>
    80009168:	fffff097          	auipc	ra,0xfffff
    8000916c:	4b4080e7          	jalr	1204(ra) # 8000861c <panic>

0000000080009170 <freerange>:
    80009170:	fc010113          	addi	sp,sp,-64
    80009174:	000017b7          	lui	a5,0x1
    80009178:	02913423          	sd	s1,40(sp)
    8000917c:	fff78493          	addi	s1,a5,-1 # fff <_entry-0x7ffff001>
    80009180:	009504b3          	add	s1,a0,s1
    80009184:	fffff537          	lui	a0,0xfffff
    80009188:	02813823          	sd	s0,48(sp)
    8000918c:	02113c23          	sd	ra,56(sp)
    80009190:	03213023          	sd	s2,32(sp)
    80009194:	01313c23          	sd	s3,24(sp)
    80009198:	01413823          	sd	s4,16(sp)
    8000919c:	01513423          	sd	s5,8(sp)
    800091a0:	01613023          	sd	s6,0(sp)
    800091a4:	04010413          	addi	s0,sp,64
    800091a8:	00a4f4b3          	and	s1,s1,a0
    800091ac:	00f487b3          	add	a5,s1,a5
    800091b0:	06f5e463          	bltu	a1,a5,80009218 <freerange+0xa8>
    800091b4:	00008a97          	auipc	s5,0x8
    800091b8:	26ca8a93          	addi	s5,s5,620 # 80011420 <end>
    800091bc:	0954e263          	bltu	s1,s5,80009240 <freerange+0xd0>
    800091c0:	01100993          	li	s3,17
    800091c4:	01b99993          	slli	s3,s3,0x1b
    800091c8:	0734fc63          	bgeu	s1,s3,80009240 <freerange+0xd0>
    800091cc:	00058a13          	mv	s4,a1
    800091d0:	00004917          	auipc	s2,0x4
    800091d4:	a9090913          	addi	s2,s2,-1392 # 8000cc60 <kmem>
    800091d8:	00002b37          	lui	s6,0x2
    800091dc:	0140006f          	j	800091f0 <freerange+0x80>
    800091e0:	000017b7          	lui	a5,0x1
    800091e4:	00f484b3          	add	s1,s1,a5
    800091e8:	0554ec63          	bltu	s1,s5,80009240 <freerange+0xd0>
    800091ec:	0534fa63          	bgeu	s1,s3,80009240 <freerange+0xd0>
    800091f0:	00001637          	lui	a2,0x1
    800091f4:	00100593          	li	a1,1
    800091f8:	00048513          	mv	a0,s1
    800091fc:	00000097          	auipc	ra,0x0
    80009200:	50c080e7          	jalr	1292(ra) # 80009708 <__memset>
    80009204:	00093703          	ld	a4,0(s2)
    80009208:	016487b3          	add	a5,s1,s6
    8000920c:	00e4b023          	sd	a4,0(s1)
    80009210:	00993023          	sd	s1,0(s2)
    80009214:	fcfa76e3          	bgeu	s4,a5,800091e0 <freerange+0x70>
    80009218:	03813083          	ld	ra,56(sp)
    8000921c:	03013403          	ld	s0,48(sp)
    80009220:	02813483          	ld	s1,40(sp)
    80009224:	02013903          	ld	s2,32(sp)
    80009228:	01813983          	ld	s3,24(sp)
    8000922c:	01013a03          	ld	s4,16(sp)
    80009230:	00813a83          	ld	s5,8(sp)
    80009234:	00013b03          	ld	s6,0(sp)
    80009238:	04010113          	addi	sp,sp,64
    8000923c:	00008067          	ret
    80009240:	00001517          	auipc	a0,0x1
    80009244:	7a850513          	addi	a0,a0,1960 # 8000a9e8 <digits+0x18>
    80009248:	fffff097          	auipc	ra,0xfffff
    8000924c:	3d4080e7          	jalr	980(ra) # 8000861c <panic>

0000000080009250 <kfree>:
    80009250:	fe010113          	addi	sp,sp,-32
    80009254:	00813823          	sd	s0,16(sp)
    80009258:	00113c23          	sd	ra,24(sp)
    8000925c:	00913423          	sd	s1,8(sp)
    80009260:	02010413          	addi	s0,sp,32
    80009264:	03451793          	slli	a5,a0,0x34
    80009268:	04079c63          	bnez	a5,800092c0 <kfree+0x70>
    8000926c:	00008797          	auipc	a5,0x8
    80009270:	1b478793          	addi	a5,a5,436 # 80011420 <end>
    80009274:	00050493          	mv	s1,a0
    80009278:	04f56463          	bltu	a0,a5,800092c0 <kfree+0x70>
    8000927c:	01100793          	li	a5,17
    80009280:	01b79793          	slli	a5,a5,0x1b
    80009284:	02f57e63          	bgeu	a0,a5,800092c0 <kfree+0x70>
    80009288:	00001637          	lui	a2,0x1
    8000928c:	00100593          	li	a1,1
    80009290:	00000097          	auipc	ra,0x0
    80009294:	478080e7          	jalr	1144(ra) # 80009708 <__memset>
    80009298:	00004797          	auipc	a5,0x4
    8000929c:	9c878793          	addi	a5,a5,-1592 # 8000cc60 <kmem>
    800092a0:	0007b703          	ld	a4,0(a5)
    800092a4:	01813083          	ld	ra,24(sp)
    800092a8:	01013403          	ld	s0,16(sp)
    800092ac:	00e4b023          	sd	a4,0(s1)
    800092b0:	0097b023          	sd	s1,0(a5)
    800092b4:	00813483          	ld	s1,8(sp)
    800092b8:	02010113          	addi	sp,sp,32
    800092bc:	00008067          	ret
    800092c0:	00001517          	auipc	a0,0x1
    800092c4:	72850513          	addi	a0,a0,1832 # 8000a9e8 <digits+0x18>
    800092c8:	fffff097          	auipc	ra,0xfffff
    800092cc:	354080e7          	jalr	852(ra) # 8000861c <panic>

00000000800092d0 <kalloc>:
    800092d0:	fe010113          	addi	sp,sp,-32
    800092d4:	00813823          	sd	s0,16(sp)
    800092d8:	00913423          	sd	s1,8(sp)
    800092dc:	00113c23          	sd	ra,24(sp)
    800092e0:	02010413          	addi	s0,sp,32
    800092e4:	00004797          	auipc	a5,0x4
    800092e8:	97c78793          	addi	a5,a5,-1668 # 8000cc60 <kmem>
    800092ec:	0007b483          	ld	s1,0(a5)
    800092f0:	02048063          	beqz	s1,80009310 <kalloc+0x40>
    800092f4:	0004b703          	ld	a4,0(s1)
    800092f8:	00001637          	lui	a2,0x1
    800092fc:	00500593          	li	a1,5
    80009300:	00048513          	mv	a0,s1
    80009304:	00e7b023          	sd	a4,0(a5)
    80009308:	00000097          	auipc	ra,0x0
    8000930c:	400080e7          	jalr	1024(ra) # 80009708 <__memset>
    80009310:	01813083          	ld	ra,24(sp)
    80009314:	01013403          	ld	s0,16(sp)
    80009318:	00048513          	mv	a0,s1
    8000931c:	00813483          	ld	s1,8(sp)
    80009320:	02010113          	addi	sp,sp,32
    80009324:	00008067          	ret

0000000080009328 <initlock>:
    80009328:	ff010113          	addi	sp,sp,-16
    8000932c:	00813423          	sd	s0,8(sp)
    80009330:	01010413          	addi	s0,sp,16
    80009334:	00813403          	ld	s0,8(sp)
    80009338:	00b53423          	sd	a1,8(a0)
    8000933c:	00052023          	sw	zero,0(a0)
    80009340:	00053823          	sd	zero,16(a0)
    80009344:	01010113          	addi	sp,sp,16
    80009348:	00008067          	ret

000000008000934c <acquire>:
    8000934c:	fe010113          	addi	sp,sp,-32
    80009350:	00813823          	sd	s0,16(sp)
    80009354:	00913423          	sd	s1,8(sp)
    80009358:	00113c23          	sd	ra,24(sp)
    8000935c:	01213023          	sd	s2,0(sp)
    80009360:	02010413          	addi	s0,sp,32
    80009364:	00050493          	mv	s1,a0
    80009368:	10002973          	csrr	s2,sstatus
    8000936c:	100027f3          	csrr	a5,sstatus
    80009370:	ffd7f793          	andi	a5,a5,-3
    80009374:	10079073          	csrw	sstatus,a5
    80009378:	fffff097          	auipc	ra,0xfffff
    8000937c:	8e8080e7          	jalr	-1816(ra) # 80007c60 <mycpu>
    80009380:	07852783          	lw	a5,120(a0)
    80009384:	06078e63          	beqz	a5,80009400 <acquire+0xb4>
    80009388:	fffff097          	auipc	ra,0xfffff
    8000938c:	8d8080e7          	jalr	-1832(ra) # 80007c60 <mycpu>
    80009390:	07852783          	lw	a5,120(a0)
    80009394:	0004a703          	lw	a4,0(s1)
    80009398:	0017879b          	addiw	a5,a5,1
    8000939c:	06f52c23          	sw	a5,120(a0)
    800093a0:	04071063          	bnez	a4,800093e0 <acquire+0x94>
    800093a4:	00100713          	li	a4,1
    800093a8:	00070793          	mv	a5,a4
    800093ac:	0cf4a7af          	amoswap.w.aq	a5,a5,(s1)
    800093b0:	0007879b          	sext.w	a5,a5
    800093b4:	fe079ae3          	bnez	a5,800093a8 <acquire+0x5c>
    800093b8:	0ff0000f          	fence
    800093bc:	fffff097          	auipc	ra,0xfffff
    800093c0:	8a4080e7          	jalr	-1884(ra) # 80007c60 <mycpu>
    800093c4:	01813083          	ld	ra,24(sp)
    800093c8:	01013403          	ld	s0,16(sp)
    800093cc:	00a4b823          	sd	a0,16(s1)
    800093d0:	00013903          	ld	s2,0(sp)
    800093d4:	00813483          	ld	s1,8(sp)
    800093d8:	02010113          	addi	sp,sp,32
    800093dc:	00008067          	ret
    800093e0:	0104b903          	ld	s2,16(s1)
    800093e4:	fffff097          	auipc	ra,0xfffff
    800093e8:	87c080e7          	jalr	-1924(ra) # 80007c60 <mycpu>
    800093ec:	faa91ce3          	bne	s2,a0,800093a4 <acquire+0x58>
    800093f0:	00001517          	auipc	a0,0x1
    800093f4:	60050513          	addi	a0,a0,1536 # 8000a9f0 <digits+0x20>
    800093f8:	fffff097          	auipc	ra,0xfffff
    800093fc:	224080e7          	jalr	548(ra) # 8000861c <panic>
    80009400:	00195913          	srli	s2,s2,0x1
    80009404:	fffff097          	auipc	ra,0xfffff
    80009408:	85c080e7          	jalr	-1956(ra) # 80007c60 <mycpu>
    8000940c:	00197913          	andi	s2,s2,1
    80009410:	07252e23          	sw	s2,124(a0)
    80009414:	f75ff06f          	j	80009388 <acquire+0x3c>

0000000080009418 <release>:
    80009418:	fe010113          	addi	sp,sp,-32
    8000941c:	00813823          	sd	s0,16(sp)
    80009420:	00113c23          	sd	ra,24(sp)
    80009424:	00913423          	sd	s1,8(sp)
    80009428:	01213023          	sd	s2,0(sp)
    8000942c:	02010413          	addi	s0,sp,32
    80009430:	00052783          	lw	a5,0(a0)
    80009434:	00079a63          	bnez	a5,80009448 <release+0x30>
    80009438:	00001517          	auipc	a0,0x1
    8000943c:	5c050513          	addi	a0,a0,1472 # 8000a9f8 <digits+0x28>
    80009440:	fffff097          	auipc	ra,0xfffff
    80009444:	1dc080e7          	jalr	476(ra) # 8000861c <panic>
    80009448:	01053903          	ld	s2,16(a0)
    8000944c:	00050493          	mv	s1,a0
    80009450:	fffff097          	auipc	ra,0xfffff
    80009454:	810080e7          	jalr	-2032(ra) # 80007c60 <mycpu>
    80009458:	fea910e3          	bne	s2,a0,80009438 <release+0x20>
    8000945c:	0004b823          	sd	zero,16(s1)
    80009460:	0ff0000f          	fence
    80009464:	0f50000f          	fence	iorw,ow
    80009468:	0804a02f          	amoswap.w	zero,zero,(s1)
    8000946c:	ffffe097          	auipc	ra,0xffffe
    80009470:	7f4080e7          	jalr	2036(ra) # 80007c60 <mycpu>
    80009474:	100027f3          	csrr	a5,sstatus
    80009478:	0027f793          	andi	a5,a5,2
    8000947c:	04079a63          	bnez	a5,800094d0 <release+0xb8>
    80009480:	07852783          	lw	a5,120(a0)
    80009484:	02f05e63          	blez	a5,800094c0 <release+0xa8>
    80009488:	fff7871b          	addiw	a4,a5,-1
    8000948c:	06e52c23          	sw	a4,120(a0)
    80009490:	00071c63          	bnez	a4,800094a8 <release+0x90>
    80009494:	07c52783          	lw	a5,124(a0)
    80009498:	00078863          	beqz	a5,800094a8 <release+0x90>
    8000949c:	100027f3          	csrr	a5,sstatus
    800094a0:	0027e793          	ori	a5,a5,2
    800094a4:	10079073          	csrw	sstatus,a5
    800094a8:	01813083          	ld	ra,24(sp)
    800094ac:	01013403          	ld	s0,16(sp)
    800094b0:	00813483          	ld	s1,8(sp)
    800094b4:	00013903          	ld	s2,0(sp)
    800094b8:	02010113          	addi	sp,sp,32
    800094bc:	00008067          	ret
    800094c0:	00001517          	auipc	a0,0x1
    800094c4:	55850513          	addi	a0,a0,1368 # 8000aa18 <digits+0x48>
    800094c8:	fffff097          	auipc	ra,0xfffff
    800094cc:	154080e7          	jalr	340(ra) # 8000861c <panic>
    800094d0:	00001517          	auipc	a0,0x1
    800094d4:	53050513          	addi	a0,a0,1328 # 8000aa00 <digits+0x30>
    800094d8:	fffff097          	auipc	ra,0xfffff
    800094dc:	144080e7          	jalr	324(ra) # 8000861c <panic>

00000000800094e0 <holding>:
    800094e0:	00052783          	lw	a5,0(a0)
    800094e4:	00079663          	bnez	a5,800094f0 <holding+0x10>
    800094e8:	00000513          	li	a0,0
    800094ec:	00008067          	ret
    800094f0:	fe010113          	addi	sp,sp,-32
    800094f4:	00813823          	sd	s0,16(sp)
    800094f8:	00913423          	sd	s1,8(sp)
    800094fc:	00113c23          	sd	ra,24(sp)
    80009500:	02010413          	addi	s0,sp,32
    80009504:	01053483          	ld	s1,16(a0)
    80009508:	ffffe097          	auipc	ra,0xffffe
    8000950c:	758080e7          	jalr	1880(ra) # 80007c60 <mycpu>
    80009510:	01813083          	ld	ra,24(sp)
    80009514:	01013403          	ld	s0,16(sp)
    80009518:	40a48533          	sub	a0,s1,a0
    8000951c:	00153513          	seqz	a0,a0
    80009520:	00813483          	ld	s1,8(sp)
    80009524:	02010113          	addi	sp,sp,32
    80009528:	00008067          	ret

000000008000952c <push_off>:
    8000952c:	fe010113          	addi	sp,sp,-32
    80009530:	00813823          	sd	s0,16(sp)
    80009534:	00113c23          	sd	ra,24(sp)
    80009538:	00913423          	sd	s1,8(sp)
    8000953c:	02010413          	addi	s0,sp,32
    80009540:	100024f3          	csrr	s1,sstatus
    80009544:	100027f3          	csrr	a5,sstatus
    80009548:	ffd7f793          	andi	a5,a5,-3
    8000954c:	10079073          	csrw	sstatus,a5
    80009550:	ffffe097          	auipc	ra,0xffffe
    80009554:	710080e7          	jalr	1808(ra) # 80007c60 <mycpu>
    80009558:	07852783          	lw	a5,120(a0)
    8000955c:	02078663          	beqz	a5,80009588 <push_off+0x5c>
    80009560:	ffffe097          	auipc	ra,0xffffe
    80009564:	700080e7          	jalr	1792(ra) # 80007c60 <mycpu>
    80009568:	07852783          	lw	a5,120(a0)
    8000956c:	01813083          	ld	ra,24(sp)
    80009570:	01013403          	ld	s0,16(sp)
    80009574:	0017879b          	addiw	a5,a5,1
    80009578:	06f52c23          	sw	a5,120(a0)
    8000957c:	00813483          	ld	s1,8(sp)
    80009580:	02010113          	addi	sp,sp,32
    80009584:	00008067          	ret
    80009588:	0014d493          	srli	s1,s1,0x1
    8000958c:	ffffe097          	auipc	ra,0xffffe
    80009590:	6d4080e7          	jalr	1748(ra) # 80007c60 <mycpu>
    80009594:	0014f493          	andi	s1,s1,1
    80009598:	06952e23          	sw	s1,124(a0)
    8000959c:	fc5ff06f          	j	80009560 <push_off+0x34>

00000000800095a0 <pop_off>:
    800095a0:	ff010113          	addi	sp,sp,-16
    800095a4:	00813023          	sd	s0,0(sp)
    800095a8:	00113423          	sd	ra,8(sp)
    800095ac:	01010413          	addi	s0,sp,16
    800095b0:	ffffe097          	auipc	ra,0xffffe
    800095b4:	6b0080e7          	jalr	1712(ra) # 80007c60 <mycpu>
    800095b8:	100027f3          	csrr	a5,sstatus
    800095bc:	0027f793          	andi	a5,a5,2
    800095c0:	04079663          	bnez	a5,8000960c <pop_off+0x6c>
    800095c4:	07852783          	lw	a5,120(a0)
    800095c8:	02f05a63          	blez	a5,800095fc <pop_off+0x5c>
    800095cc:	fff7871b          	addiw	a4,a5,-1
    800095d0:	06e52c23          	sw	a4,120(a0)
    800095d4:	00071c63          	bnez	a4,800095ec <pop_off+0x4c>
    800095d8:	07c52783          	lw	a5,124(a0)
    800095dc:	00078863          	beqz	a5,800095ec <pop_off+0x4c>
    800095e0:	100027f3          	csrr	a5,sstatus
    800095e4:	0027e793          	ori	a5,a5,2
    800095e8:	10079073          	csrw	sstatus,a5
    800095ec:	00813083          	ld	ra,8(sp)
    800095f0:	00013403          	ld	s0,0(sp)
    800095f4:	01010113          	addi	sp,sp,16
    800095f8:	00008067          	ret
    800095fc:	00001517          	auipc	a0,0x1
    80009600:	41c50513          	addi	a0,a0,1052 # 8000aa18 <digits+0x48>
    80009604:	fffff097          	auipc	ra,0xfffff
    80009608:	018080e7          	jalr	24(ra) # 8000861c <panic>
    8000960c:	00001517          	auipc	a0,0x1
    80009610:	3f450513          	addi	a0,a0,1012 # 8000aa00 <digits+0x30>
    80009614:	fffff097          	auipc	ra,0xfffff
    80009618:	008080e7          	jalr	8(ra) # 8000861c <panic>

000000008000961c <push_on>:
    8000961c:	fe010113          	addi	sp,sp,-32
    80009620:	00813823          	sd	s0,16(sp)
    80009624:	00113c23          	sd	ra,24(sp)
    80009628:	00913423          	sd	s1,8(sp)
    8000962c:	02010413          	addi	s0,sp,32
    80009630:	100024f3          	csrr	s1,sstatus
    80009634:	100027f3          	csrr	a5,sstatus
    80009638:	0027e793          	ori	a5,a5,2
    8000963c:	10079073          	csrw	sstatus,a5
    80009640:	ffffe097          	auipc	ra,0xffffe
    80009644:	620080e7          	jalr	1568(ra) # 80007c60 <mycpu>
    80009648:	07852783          	lw	a5,120(a0)
    8000964c:	02078663          	beqz	a5,80009678 <push_on+0x5c>
    80009650:	ffffe097          	auipc	ra,0xffffe
    80009654:	610080e7          	jalr	1552(ra) # 80007c60 <mycpu>
    80009658:	07852783          	lw	a5,120(a0)
    8000965c:	01813083          	ld	ra,24(sp)
    80009660:	01013403          	ld	s0,16(sp)
    80009664:	0017879b          	addiw	a5,a5,1
    80009668:	06f52c23          	sw	a5,120(a0)
    8000966c:	00813483          	ld	s1,8(sp)
    80009670:	02010113          	addi	sp,sp,32
    80009674:	00008067          	ret
    80009678:	0014d493          	srli	s1,s1,0x1
    8000967c:	ffffe097          	auipc	ra,0xffffe
    80009680:	5e4080e7          	jalr	1508(ra) # 80007c60 <mycpu>
    80009684:	0014f493          	andi	s1,s1,1
    80009688:	06952e23          	sw	s1,124(a0)
    8000968c:	fc5ff06f          	j	80009650 <push_on+0x34>

0000000080009690 <pop_on>:
    80009690:	ff010113          	addi	sp,sp,-16
    80009694:	00813023          	sd	s0,0(sp)
    80009698:	00113423          	sd	ra,8(sp)
    8000969c:	01010413          	addi	s0,sp,16
    800096a0:	ffffe097          	auipc	ra,0xffffe
    800096a4:	5c0080e7          	jalr	1472(ra) # 80007c60 <mycpu>
    800096a8:	100027f3          	csrr	a5,sstatus
    800096ac:	0027f793          	andi	a5,a5,2
    800096b0:	04078463          	beqz	a5,800096f8 <pop_on+0x68>
    800096b4:	07852783          	lw	a5,120(a0)
    800096b8:	02f05863          	blez	a5,800096e8 <pop_on+0x58>
    800096bc:	fff7879b          	addiw	a5,a5,-1
    800096c0:	06f52c23          	sw	a5,120(a0)
    800096c4:	07853783          	ld	a5,120(a0)
    800096c8:	00079863          	bnez	a5,800096d8 <pop_on+0x48>
    800096cc:	100027f3          	csrr	a5,sstatus
    800096d0:	ffd7f793          	andi	a5,a5,-3
    800096d4:	10079073          	csrw	sstatus,a5
    800096d8:	00813083          	ld	ra,8(sp)
    800096dc:	00013403          	ld	s0,0(sp)
    800096e0:	01010113          	addi	sp,sp,16
    800096e4:	00008067          	ret
    800096e8:	00001517          	auipc	a0,0x1
    800096ec:	35850513          	addi	a0,a0,856 # 8000aa40 <digits+0x70>
    800096f0:	fffff097          	auipc	ra,0xfffff
    800096f4:	f2c080e7          	jalr	-212(ra) # 8000861c <panic>
    800096f8:	00001517          	auipc	a0,0x1
    800096fc:	32850513          	addi	a0,a0,808 # 8000aa20 <digits+0x50>
    80009700:	fffff097          	auipc	ra,0xfffff
    80009704:	f1c080e7          	jalr	-228(ra) # 8000861c <panic>

0000000080009708 <__memset>:
    80009708:	ff010113          	addi	sp,sp,-16
    8000970c:	00813423          	sd	s0,8(sp)
    80009710:	01010413          	addi	s0,sp,16
    80009714:	1a060e63          	beqz	a2,800098d0 <__memset+0x1c8>
    80009718:	40a007b3          	neg	a5,a0
    8000971c:	0077f793          	andi	a5,a5,7
    80009720:	00778693          	addi	a3,a5,7
    80009724:	00b00813          	li	a6,11
    80009728:	0ff5f593          	andi	a1,a1,255
    8000972c:	fff6071b          	addiw	a4,a2,-1
    80009730:	1b06e663          	bltu	a3,a6,800098dc <__memset+0x1d4>
    80009734:	1cd76463          	bltu	a4,a3,800098fc <__memset+0x1f4>
    80009738:	1a078e63          	beqz	a5,800098f4 <__memset+0x1ec>
    8000973c:	00b50023          	sb	a1,0(a0)
    80009740:	00100713          	li	a4,1
    80009744:	1ae78463          	beq	a5,a4,800098ec <__memset+0x1e4>
    80009748:	00b500a3          	sb	a1,1(a0)
    8000974c:	00200713          	li	a4,2
    80009750:	1ae78a63          	beq	a5,a4,80009904 <__memset+0x1fc>
    80009754:	00b50123          	sb	a1,2(a0)
    80009758:	00300713          	li	a4,3
    8000975c:	18e78463          	beq	a5,a4,800098e4 <__memset+0x1dc>
    80009760:	00b501a3          	sb	a1,3(a0)
    80009764:	00400713          	li	a4,4
    80009768:	1ae78263          	beq	a5,a4,8000990c <__memset+0x204>
    8000976c:	00b50223          	sb	a1,4(a0)
    80009770:	00500713          	li	a4,5
    80009774:	1ae78063          	beq	a5,a4,80009914 <__memset+0x20c>
    80009778:	00b502a3          	sb	a1,5(a0)
    8000977c:	00700713          	li	a4,7
    80009780:	18e79e63          	bne	a5,a4,8000991c <__memset+0x214>
    80009784:	00b50323          	sb	a1,6(a0)
    80009788:	00700e93          	li	t4,7
    8000978c:	00859713          	slli	a4,a1,0x8
    80009790:	00e5e733          	or	a4,a1,a4
    80009794:	01059e13          	slli	t3,a1,0x10
    80009798:	01c76e33          	or	t3,a4,t3
    8000979c:	01859313          	slli	t1,a1,0x18
    800097a0:	006e6333          	or	t1,t3,t1
    800097a4:	02059893          	slli	a7,a1,0x20
    800097a8:	40f60e3b          	subw	t3,a2,a5
    800097ac:	011368b3          	or	a7,t1,a7
    800097b0:	02859813          	slli	a6,a1,0x28
    800097b4:	0108e833          	or	a6,a7,a6
    800097b8:	03059693          	slli	a3,a1,0x30
    800097bc:	003e589b          	srliw	a7,t3,0x3
    800097c0:	00d866b3          	or	a3,a6,a3
    800097c4:	03859713          	slli	a4,a1,0x38
    800097c8:	00389813          	slli	a6,a7,0x3
    800097cc:	00f507b3          	add	a5,a0,a5
    800097d0:	00e6e733          	or	a4,a3,a4
    800097d4:	000e089b          	sext.w	a7,t3
    800097d8:	00f806b3          	add	a3,a6,a5
    800097dc:	00e7b023          	sd	a4,0(a5)
    800097e0:	00878793          	addi	a5,a5,8
    800097e4:	fed79ce3          	bne	a5,a3,800097dc <__memset+0xd4>
    800097e8:	ff8e7793          	andi	a5,t3,-8
    800097ec:	0007871b          	sext.w	a4,a5
    800097f0:	01d787bb          	addw	a5,a5,t4
    800097f4:	0ce88e63          	beq	a7,a4,800098d0 <__memset+0x1c8>
    800097f8:	00f50733          	add	a4,a0,a5
    800097fc:	00b70023          	sb	a1,0(a4)
    80009800:	0017871b          	addiw	a4,a5,1
    80009804:	0cc77663          	bgeu	a4,a2,800098d0 <__memset+0x1c8>
    80009808:	00e50733          	add	a4,a0,a4
    8000980c:	00b70023          	sb	a1,0(a4)
    80009810:	0027871b          	addiw	a4,a5,2
    80009814:	0ac77e63          	bgeu	a4,a2,800098d0 <__memset+0x1c8>
    80009818:	00e50733          	add	a4,a0,a4
    8000981c:	00b70023          	sb	a1,0(a4)
    80009820:	0037871b          	addiw	a4,a5,3
    80009824:	0ac77663          	bgeu	a4,a2,800098d0 <__memset+0x1c8>
    80009828:	00e50733          	add	a4,a0,a4
    8000982c:	00b70023          	sb	a1,0(a4)
    80009830:	0047871b          	addiw	a4,a5,4
    80009834:	08c77e63          	bgeu	a4,a2,800098d0 <__memset+0x1c8>
    80009838:	00e50733          	add	a4,a0,a4
    8000983c:	00b70023          	sb	a1,0(a4)
    80009840:	0057871b          	addiw	a4,a5,5
    80009844:	08c77663          	bgeu	a4,a2,800098d0 <__memset+0x1c8>
    80009848:	00e50733          	add	a4,a0,a4
    8000984c:	00b70023          	sb	a1,0(a4)
    80009850:	0067871b          	addiw	a4,a5,6
    80009854:	06c77e63          	bgeu	a4,a2,800098d0 <__memset+0x1c8>
    80009858:	00e50733          	add	a4,a0,a4
    8000985c:	00b70023          	sb	a1,0(a4)
    80009860:	0077871b          	addiw	a4,a5,7
    80009864:	06c77663          	bgeu	a4,a2,800098d0 <__memset+0x1c8>
    80009868:	00e50733          	add	a4,a0,a4
    8000986c:	00b70023          	sb	a1,0(a4)
    80009870:	0087871b          	addiw	a4,a5,8
    80009874:	04c77e63          	bgeu	a4,a2,800098d0 <__memset+0x1c8>
    80009878:	00e50733          	add	a4,a0,a4
    8000987c:	00b70023          	sb	a1,0(a4)
    80009880:	0097871b          	addiw	a4,a5,9
    80009884:	04c77663          	bgeu	a4,a2,800098d0 <__memset+0x1c8>
    80009888:	00e50733          	add	a4,a0,a4
    8000988c:	00b70023          	sb	a1,0(a4)
    80009890:	00a7871b          	addiw	a4,a5,10
    80009894:	02c77e63          	bgeu	a4,a2,800098d0 <__memset+0x1c8>
    80009898:	00e50733          	add	a4,a0,a4
    8000989c:	00b70023          	sb	a1,0(a4)
    800098a0:	00b7871b          	addiw	a4,a5,11
    800098a4:	02c77663          	bgeu	a4,a2,800098d0 <__memset+0x1c8>
    800098a8:	00e50733          	add	a4,a0,a4
    800098ac:	00b70023          	sb	a1,0(a4)
    800098b0:	00c7871b          	addiw	a4,a5,12
    800098b4:	00c77e63          	bgeu	a4,a2,800098d0 <__memset+0x1c8>
    800098b8:	00e50733          	add	a4,a0,a4
    800098bc:	00b70023          	sb	a1,0(a4)
    800098c0:	00d7879b          	addiw	a5,a5,13
    800098c4:	00c7f663          	bgeu	a5,a2,800098d0 <__memset+0x1c8>
    800098c8:	00f507b3          	add	a5,a0,a5
    800098cc:	00b78023          	sb	a1,0(a5)
    800098d0:	00813403          	ld	s0,8(sp)
    800098d4:	01010113          	addi	sp,sp,16
    800098d8:	00008067          	ret
    800098dc:	00b00693          	li	a3,11
    800098e0:	e55ff06f          	j	80009734 <__memset+0x2c>
    800098e4:	00300e93          	li	t4,3
    800098e8:	ea5ff06f          	j	8000978c <__memset+0x84>
    800098ec:	00100e93          	li	t4,1
    800098f0:	e9dff06f          	j	8000978c <__memset+0x84>
    800098f4:	00000e93          	li	t4,0
    800098f8:	e95ff06f          	j	8000978c <__memset+0x84>
    800098fc:	00000793          	li	a5,0
    80009900:	ef9ff06f          	j	800097f8 <__memset+0xf0>
    80009904:	00200e93          	li	t4,2
    80009908:	e85ff06f          	j	8000978c <__memset+0x84>
    8000990c:	00400e93          	li	t4,4
    80009910:	e7dff06f          	j	8000978c <__memset+0x84>
    80009914:	00500e93          	li	t4,5
    80009918:	e75ff06f          	j	8000978c <__memset+0x84>
    8000991c:	00600e93          	li	t4,6
    80009920:	e6dff06f          	j	8000978c <__memset+0x84>

0000000080009924 <__memmove>:
    80009924:	ff010113          	addi	sp,sp,-16
    80009928:	00813423          	sd	s0,8(sp)
    8000992c:	01010413          	addi	s0,sp,16
    80009930:	0e060863          	beqz	a2,80009a20 <__memmove+0xfc>
    80009934:	fff6069b          	addiw	a3,a2,-1
    80009938:	0006881b          	sext.w	a6,a3
    8000993c:	0ea5e863          	bltu	a1,a0,80009a2c <__memmove+0x108>
    80009940:	00758713          	addi	a4,a1,7
    80009944:	00a5e7b3          	or	a5,a1,a0
    80009948:	40a70733          	sub	a4,a4,a0
    8000994c:	0077f793          	andi	a5,a5,7
    80009950:	00f73713          	sltiu	a4,a4,15
    80009954:	00174713          	xori	a4,a4,1
    80009958:	0017b793          	seqz	a5,a5
    8000995c:	00e7f7b3          	and	a5,a5,a4
    80009960:	10078863          	beqz	a5,80009a70 <__memmove+0x14c>
    80009964:	00900793          	li	a5,9
    80009968:	1107f463          	bgeu	a5,a6,80009a70 <__memmove+0x14c>
    8000996c:	0036581b          	srliw	a6,a2,0x3
    80009970:	fff8081b          	addiw	a6,a6,-1
    80009974:	02081813          	slli	a6,a6,0x20
    80009978:	01d85893          	srli	a7,a6,0x1d
    8000997c:	00858813          	addi	a6,a1,8
    80009980:	00058793          	mv	a5,a1
    80009984:	00050713          	mv	a4,a0
    80009988:	01088833          	add	a6,a7,a6
    8000998c:	0007b883          	ld	a7,0(a5)
    80009990:	00878793          	addi	a5,a5,8
    80009994:	00870713          	addi	a4,a4,8
    80009998:	ff173c23          	sd	a7,-8(a4)
    8000999c:	ff0798e3          	bne	a5,a6,8000998c <__memmove+0x68>
    800099a0:	ff867713          	andi	a4,a2,-8
    800099a4:	02071793          	slli	a5,a4,0x20
    800099a8:	0207d793          	srli	a5,a5,0x20
    800099ac:	00f585b3          	add	a1,a1,a5
    800099b0:	40e686bb          	subw	a3,a3,a4
    800099b4:	00f507b3          	add	a5,a0,a5
    800099b8:	06e60463          	beq	a2,a4,80009a20 <__memmove+0xfc>
    800099bc:	0005c703          	lbu	a4,0(a1)
    800099c0:	00e78023          	sb	a4,0(a5)
    800099c4:	04068e63          	beqz	a3,80009a20 <__memmove+0xfc>
    800099c8:	0015c603          	lbu	a2,1(a1)
    800099cc:	00100713          	li	a4,1
    800099d0:	00c780a3          	sb	a2,1(a5)
    800099d4:	04e68663          	beq	a3,a4,80009a20 <__memmove+0xfc>
    800099d8:	0025c603          	lbu	a2,2(a1)
    800099dc:	00200713          	li	a4,2
    800099e0:	00c78123          	sb	a2,2(a5)
    800099e4:	02e68e63          	beq	a3,a4,80009a20 <__memmove+0xfc>
    800099e8:	0035c603          	lbu	a2,3(a1)
    800099ec:	00300713          	li	a4,3
    800099f0:	00c781a3          	sb	a2,3(a5)
    800099f4:	02e68663          	beq	a3,a4,80009a20 <__memmove+0xfc>
    800099f8:	0045c603          	lbu	a2,4(a1)
    800099fc:	00400713          	li	a4,4
    80009a00:	00c78223          	sb	a2,4(a5)
    80009a04:	00e68e63          	beq	a3,a4,80009a20 <__memmove+0xfc>
    80009a08:	0055c603          	lbu	a2,5(a1)
    80009a0c:	00500713          	li	a4,5
    80009a10:	00c782a3          	sb	a2,5(a5)
    80009a14:	00e68663          	beq	a3,a4,80009a20 <__memmove+0xfc>
    80009a18:	0065c703          	lbu	a4,6(a1)
    80009a1c:	00e78323          	sb	a4,6(a5)
    80009a20:	00813403          	ld	s0,8(sp)
    80009a24:	01010113          	addi	sp,sp,16
    80009a28:	00008067          	ret
    80009a2c:	02061713          	slli	a4,a2,0x20
    80009a30:	02075713          	srli	a4,a4,0x20
    80009a34:	00e587b3          	add	a5,a1,a4
    80009a38:	f0f574e3          	bgeu	a0,a5,80009940 <__memmove+0x1c>
    80009a3c:	02069613          	slli	a2,a3,0x20
    80009a40:	02065613          	srli	a2,a2,0x20
    80009a44:	fff64613          	not	a2,a2
    80009a48:	00e50733          	add	a4,a0,a4
    80009a4c:	00c78633          	add	a2,a5,a2
    80009a50:	fff7c683          	lbu	a3,-1(a5)
    80009a54:	fff78793          	addi	a5,a5,-1
    80009a58:	fff70713          	addi	a4,a4,-1
    80009a5c:	00d70023          	sb	a3,0(a4)
    80009a60:	fec798e3          	bne	a5,a2,80009a50 <__memmove+0x12c>
    80009a64:	00813403          	ld	s0,8(sp)
    80009a68:	01010113          	addi	sp,sp,16
    80009a6c:	00008067          	ret
    80009a70:	02069713          	slli	a4,a3,0x20
    80009a74:	02075713          	srli	a4,a4,0x20
    80009a78:	00170713          	addi	a4,a4,1
    80009a7c:	00e50733          	add	a4,a0,a4
    80009a80:	00050793          	mv	a5,a0
    80009a84:	0005c683          	lbu	a3,0(a1)
    80009a88:	00178793          	addi	a5,a5,1
    80009a8c:	00158593          	addi	a1,a1,1
    80009a90:	fed78fa3          	sb	a3,-1(a5)
    80009a94:	fee798e3          	bne	a5,a4,80009a84 <__memmove+0x160>
    80009a98:	f89ff06f          	j	80009a20 <__memmove+0xfc>
	...
