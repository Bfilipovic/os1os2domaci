
kernel:     file format elf64-littleriscv


Disassembly of section .text:

0000000080000000 <_entry>:
    80000000:	0000b117          	auipc	sp,0xb
    80000004:	23813103          	ld	sp,568(sp) # 8000b238 <_GLOBAL_OFFSET_TABLE_+0x38>
    80000008:	00001537          	lui	a0,0x1
    8000000c:	f14025f3          	csrr	a1,mhartid
    80000010:	00158593          	addi	a1,a1,1
    80000014:	02b50533          	mul	a0,a0,a1
    80000018:	00a10133          	add	sp,sp,a0
    8000001c:	789050ef          	jal	ra,80005fa4 <start>

0000000080000020 <spin>:
    80000020:	0000006f          	j	80000020 <spin>
	...

0000000080001000 <supervisorTrap>:
.align 4
.global supervisorTrap
.type supervisorTrap @function
supervisorTrap:

    addi sp, sp, -24
    80001000:	fe810113          	addi	sp,sp,-24
    sd t0, 0(sp)
    80001004:	00513023          	sd	t0,0(sp)
    sd t1, 8(sp)
    80001008:	00613423          	sd	t1,8(sp)
    sd t2, 16(sp)
    8000100c:	00713823          	sd	t2,16(sp)
    csrr t0, scause
    80001010:	142022f3          	csrr	t0,scause
    li t1, 8
    80001014:	00800313          	li	t1,8
    li t2, 9
    80001018:	00900393          	li	t2,9
    beq t0, t1, ecall
    8000101c:	10628c63          	beq	t0,t1,80001134 <ecall>
    beq t0, t2, ecall
    80001020:	10728a63          	beq	t0,t2,80001134 <ecall>

    # spoljasnji prekidi nemaju povratnu vrednost => cuvamo i a0 (x10)
    addi sp, sp, -256
    80001024:	f0010113          	addi	sp,sp,-256
    .irp index, 0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31
    sd x\index, \index * 8(sp)
    .endr
    80001028:	00013023          	sd	zero,0(sp)
    8000102c:	00113423          	sd	ra,8(sp)
    80001030:	00213823          	sd	sp,16(sp)
    80001034:	00313c23          	sd	gp,24(sp)
    80001038:	02413023          	sd	tp,32(sp)
    8000103c:	02513423          	sd	t0,40(sp)
    80001040:	02613823          	sd	t1,48(sp)
    80001044:	02713c23          	sd	t2,56(sp)
    80001048:	04813023          	sd	s0,64(sp)
    8000104c:	04913423          	sd	s1,72(sp)
    80001050:	04a13823          	sd	a0,80(sp)
    80001054:	04b13c23          	sd	a1,88(sp)
    80001058:	06c13023          	sd	a2,96(sp)
    8000105c:	06d13423          	sd	a3,104(sp)
    80001060:	06e13823          	sd	a4,112(sp)
    80001064:	06f13c23          	sd	a5,120(sp)
    80001068:	09013023          	sd	a6,128(sp)
    8000106c:	09113423          	sd	a7,136(sp)
    80001070:	09213823          	sd	s2,144(sp)
    80001074:	09313c23          	sd	s3,152(sp)
    80001078:	0b413023          	sd	s4,160(sp)
    8000107c:	0b513423          	sd	s5,168(sp)
    80001080:	0b613823          	sd	s6,176(sp)
    80001084:	0b713c23          	sd	s7,184(sp)
    80001088:	0d813023          	sd	s8,192(sp)
    8000108c:	0d913423          	sd	s9,200(sp)
    80001090:	0da13823          	sd	s10,208(sp)
    80001094:	0db13c23          	sd	s11,216(sp)
    80001098:	0fc13023          	sd	t3,224(sp)
    8000109c:	0fd13423          	sd	t4,232(sp)
    800010a0:	0fe13823          	sd	t5,240(sp)
    800010a4:	0ff13c23          	sd	t6,248(sp)

    call handleInterrupt
    800010a8:	0cd010ef          	jal	ra,80002974 <handleInterrupt>

    .irp index, 0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31
    ld x\index, \index * 8(sp)
    .endr
    800010ac:	00013003          	ld	zero,0(sp)
    800010b0:	00813083          	ld	ra,8(sp)
    800010b4:	01013103          	ld	sp,16(sp)
    800010b8:	01813183          	ld	gp,24(sp)
    800010bc:	02013203          	ld	tp,32(sp)
    800010c0:	02813283          	ld	t0,40(sp)
    800010c4:	03013303          	ld	t1,48(sp)
    800010c8:	03813383          	ld	t2,56(sp)
    800010cc:	04013403          	ld	s0,64(sp)
    800010d0:	04813483          	ld	s1,72(sp)
    800010d4:	05013503          	ld	a0,80(sp)
    800010d8:	05813583          	ld	a1,88(sp)
    800010dc:	06013603          	ld	a2,96(sp)
    800010e0:	06813683          	ld	a3,104(sp)
    800010e4:	07013703          	ld	a4,112(sp)
    800010e8:	07813783          	ld	a5,120(sp)
    800010ec:	08013803          	ld	a6,128(sp)
    800010f0:	08813883          	ld	a7,136(sp)
    800010f4:	09013903          	ld	s2,144(sp)
    800010f8:	09813983          	ld	s3,152(sp)
    800010fc:	0a013a03          	ld	s4,160(sp)
    80001100:	0a813a83          	ld	s5,168(sp)
    80001104:	0b013b03          	ld	s6,176(sp)
    80001108:	0b813b83          	ld	s7,184(sp)
    8000110c:	0c013c03          	ld	s8,192(sp)
    80001110:	0c813c83          	ld	s9,200(sp)
    80001114:	0d013d03          	ld	s10,208(sp)
    80001118:	0d813d83          	ld	s11,216(sp)
    8000111c:	0e013e03          	ld	t3,224(sp)
    80001120:	0e813e83          	ld	t4,232(sp)
    80001124:	0f013f03          	ld	t5,240(sp)
    80001128:	0f813f83          	ld	t6,248(sp)
    addi sp, sp, 256
    8000112c:	10010113          	addi	sp,sp,256

    j return
    80001130:	1080006f          	j	80001238 <return>

0000000080001134 <ecall>:

ecall:
    # If scause register is 8 or 9
    addi sp, sp, -256
    80001134:	f0010113          	addi	sp,sp,-256
    .irp index, 0,1,2,3,4,5,6,7,8,9,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31
    sd x\index, \index * 8(sp)
    .endr
    80001138:	00013023          	sd	zero,0(sp)
    8000113c:	00113423          	sd	ra,8(sp)
    80001140:	00213823          	sd	sp,16(sp)
    80001144:	00313c23          	sd	gp,24(sp)
    80001148:	02413023          	sd	tp,32(sp)
    8000114c:	02513423          	sd	t0,40(sp)
    80001150:	02613823          	sd	t1,48(sp)
    80001154:	02713c23          	sd	t2,56(sp)
    80001158:	04813023          	sd	s0,64(sp)
    8000115c:	04913423          	sd	s1,72(sp)
    80001160:	04b13c23          	sd	a1,88(sp)
    80001164:	06c13023          	sd	a2,96(sp)
    80001168:	06d13423          	sd	a3,104(sp)
    8000116c:	06e13823          	sd	a4,112(sp)
    80001170:	06f13c23          	sd	a5,120(sp)
    80001174:	09013023          	sd	a6,128(sp)
    80001178:	09113423          	sd	a7,136(sp)
    8000117c:	09213823          	sd	s2,144(sp)
    80001180:	09313c23          	sd	s3,152(sp)
    80001184:	0b413023          	sd	s4,160(sp)
    80001188:	0b513423          	sd	s5,168(sp)
    8000118c:	0b613823          	sd	s6,176(sp)
    80001190:	0b713c23          	sd	s7,184(sp)
    80001194:	0d813023          	sd	s8,192(sp)
    80001198:	0d913423          	sd	s9,200(sp)
    8000119c:	0da13823          	sd	s10,208(sp)
    800011a0:	0db13c23          	sd	s11,216(sp)
    800011a4:	0fc13023          	sd	t3,224(sp)
    800011a8:	0fd13423          	sd	t4,232(sp)
    800011ac:	0fe13823          	sd	t5,240(sp)
    800011b0:	0ff13c23          	sd	t6,248(sp)
    
    call handleEcall
    800011b4:	430010ef          	jal	ra,800025e4 <handleEcall>
    
    .irp index, 0,1,2,3,4,5,6,7,8,9,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31
    ld x\index, \index * 8(sp)
    .endr
    800011b8:	00013003          	ld	zero,0(sp)
    800011bc:	00813083          	ld	ra,8(sp)
    800011c0:	01013103          	ld	sp,16(sp)
    800011c4:	01813183          	ld	gp,24(sp)
    800011c8:	02013203          	ld	tp,32(sp)
    800011cc:	02813283          	ld	t0,40(sp)
    800011d0:	03013303          	ld	t1,48(sp)
    800011d4:	03813383          	ld	t2,56(sp)
    800011d8:	04013403          	ld	s0,64(sp)
    800011dc:	04813483          	ld	s1,72(sp)
    800011e0:	05813583          	ld	a1,88(sp)
    800011e4:	06013603          	ld	a2,96(sp)
    800011e8:	06813683          	ld	a3,104(sp)
    800011ec:	07013703          	ld	a4,112(sp)
    800011f0:	07813783          	ld	a5,120(sp)
    800011f4:	08013803          	ld	a6,128(sp)
    800011f8:	08813883          	ld	a7,136(sp)
    800011fc:	09013903          	ld	s2,144(sp)
    80001200:	09813983          	ld	s3,152(sp)
    80001204:	0a013a03          	ld	s4,160(sp)
    80001208:	0a813a83          	ld	s5,168(sp)
    8000120c:	0b013b03          	ld	s6,176(sp)
    80001210:	0b813b83          	ld	s7,184(sp)
    80001214:	0c013c03          	ld	s8,192(sp)
    80001218:	0c813c83          	ld	s9,200(sp)
    8000121c:	0d013d03          	ld	s10,208(sp)
    80001220:	0d813d83          	ld	s11,216(sp)
    80001224:	0e013e03          	ld	t3,224(sp)
    80001228:	0e813e83          	ld	t4,232(sp)
    8000122c:	0f013f03          	ld	t5,240(sp)
    80001230:	0f813f83          	ld	t6,248(sp)
    addi sp, sp, 256
    80001234:	10010113          	addi	sp,sp,256

0000000080001238 <return>:
    
    
return:
    ld t0, 0(sp)
    80001238:	00013283          	ld	t0,0(sp)
    ld t1, 8(sp)
    8000123c:	00813303          	ld	t1,8(sp)
    ld t2, 16(sp)
    80001240:	01013383          	ld	t2,16(sp)
    addi sp, sp, 24
    80001244:	01810113          	addi	sp,sp,24
    80001248:	10200073          	sret

000000008000124c <contextSwitch>:
.global contextSwitch
.type contextSwitch, @function
contextSwitch:
    sd ra, 0 * 8(a0)
    8000124c:	00153023          	sd	ra,0(a0) # 1000 <_entry-0x7ffff000>
    sd sp, 1 * 8(a0)
    80001250:	00253423          	sd	sp,8(a0)

    ld ra, 0 * 8(a1)
    80001254:	0005b083          	ld	ra,0(a1)
    ld sp, 1 * 8(a1)
    80001258:	0085b103          	ld	sp,8(a1)

    8000125c:	00008067          	ret

0000000080001260 <copy_and_swap>:
# a1 holds expected value
# a2 holds desired value
# a0 holds return value, 0 if successful, !0 otherwise
.global copy_and_swap
copy_and_swap:
    lr.w t0, (a0)          # Load original value.
    80001260:	100522af          	lr.w	t0,(a0)
    bne t0, a1, fail       # Doesn’t match, so fail.
    80001264:	00b29a63          	bne	t0,a1,80001278 <fail>
    sc.w t0, a2, (a0)      # Try to update.
    80001268:	18c522af          	sc.w	t0,a2,(a0)
    bnez t0, copy_and_swap # Retry if store-conditional failed.
    8000126c:	fe029ae3          	bnez	t0,80001260 <copy_and_swap>
    li a0, 0               # Set return to success.
    80001270:	00000513          	li	a0,0
    jr ra                  # Return.
    80001274:	00008067          	ret

0000000080001278 <fail>:
    fail:
    li a0, 1               # Set return to failure.
    80001278:	00100513          	li	a0,1
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
    8000129c:	00001097          	auipc	ra,0x1
    800012a0:	310080e7          	jalr	784(ra) # 800025ac <_Z12kern_syscall13SyscallNumberz>
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
    800012d8:	00001097          	auipc	ra,0x1
    800012dc:	2d4080e7          	jalr	724(ra) # 800025ac <_Z12kern_syscall13SyscallNumberz>
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
    8000134c:	00001097          	auipc	ra,0x1
    80001350:	260080e7          	jalr	608(ra) # 800025ac <_Z12kern_syscall13SyscallNumberz>
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
    8000139c:	00001097          	auipc	ra,0x1
    800013a0:	210080e7          	jalr	528(ra) # 800025ac <_Z12kern_syscall13SyscallNumberz>
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
    800013c8:	0000a797          	auipc	a5,0xa
    800013cc:	e587b783          	ld	a5,-424(a5) # 8000b220 <_GLOBAL_OFFSET_TABLE_+0x20>
    800013d0:	0007b783          	ld	a5,0(a5)
    800013d4:	0407b483          	ld	s1,64(a5)
    kern_syscall(THREAD_EXIT);
    800013d8:	01200513          	li	a0,18
    800013dc:	00001097          	auipc	ra,0x1
    800013e0:	1d0080e7          	jalr	464(ra) # 800025ac <_Z12kern_syscall13SyscallNumberz>
    kern_syscall(MEM_FREE,stack);
    800013e4:	00048593          	mv	a1,s1
    800013e8:	00200513          	li	a0,2
    800013ec:	00001097          	auipc	ra,0x1
    800013f0:	1c0080e7          	jalr	448(ra) # 800025ac <_Z12kern_syscall13SyscallNumberz>
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
    80001424:	00001097          	auipc	ra,0x1
    80001428:	188080e7          	jalr	392(ra) # 800025ac <_Z12kern_syscall13SyscallNumberz>
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
    80001458:	00001097          	auipc	ra,0x1
    8000145c:	154080e7          	jalr	340(ra) # 800025ac <_Z12kern_syscall13SyscallNumberz>
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
    80001498:	00001097          	auipc	ra,0x1
    8000149c:	114080e7          	jalr	276(ra) # 800025ac <_Z12kern_syscall13SyscallNumberz>
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
    800014d8:	00001097          	auipc	ra,0x1
    800014dc:	0d4080e7          	jalr	212(ra) # 800025ac <_Z12kern_syscall13SyscallNumberz>
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
    80001518:	00001097          	auipc	ra,0x1
    8000151c:	094080e7          	jalr	148(ra) # 800025ac <_Z12kern_syscall13SyscallNumberz>
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
    80001558:	00001097          	auipc	ra,0x1
    8000155c:	054080e7          	jalr	84(ra) # 800025ac <_Z12kern_syscall13SyscallNumberz>
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
    80001588:	00001097          	auipc	ra,0x1
    8000158c:	024080e7          	jalr	36(ra) # 800025ac <_Z12kern_syscall13SyscallNumberz>
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
    800015c8:	00001097          	auipc	ra,0x1
    800015cc:	fe4080e7          	jalr	-28(ra) # 800025ac <_Z12kern_syscall13SyscallNumberz>
}
    800015d0:	00813083          	ld	ra,8(sp)
    800015d4:	00013403          	ld	s0,0(sp)
    800015d8:	01010113          	addi	sp,sp,16
    800015dc:	00008067          	ret

00000000800015e0 <_Z14kern_mem_alloci>:

mem_block_s * freeHead;


void* kern_mem_alloc(int sizeInBlocks)
{
    800015e0:	ff010113          	addi	sp,sp,-16
    800015e4:	00813423          	sd	s0,8(sp)
    800015e8:	01010413          	addi	s0,sp,16
    800015ec:	00050693          	mv	a3,a0
    mem_block_s *curr = freeHead;
    800015f0:	0000a597          	auipc	a1,0xa
    800015f4:	ca05b583          	ld	a1,-864(a1) # 8000b290 <freeHead>
    800015f8:	00058513          	mv	a0,a1
    mem_block_s *prev = 0;
    800015fc:	00000613          	li	a2,0
    80001600:	0480006f          	j	80001648 <_Z14kern_mem_alloci+0x68>

    while (curr){
        if(curr->sizeInBlocks==sizeInBlocks+1){
            if(curr==freeHead) freeHead=curr->next;
    80001604:	02b50063          	beq	a0,a1,80001624 <_Z14kern_mem_alloci+0x44>
            else prev->next = curr->next;
    80001608:	00853783          	ld	a5,8(a0) # 1008 <_entry-0x7fffeff8>
    8000160c:	00f63423          	sd	a5,8(a2)
            curr->sizeInBlocks=sizeInBlocks+1;
    80001610:	00e52023          	sw	a4,0(a0)
            return (curr+MEM_BLOCK_SIZE);
    80001614:	40050513          	addi	a0,a0,1024
        prev=curr;
        curr=curr->next;
    }

    return 0;
}
    80001618:	00813403          	ld	s0,8(sp)
    8000161c:	01010113          	addi	sp,sp,16
    80001620:	00008067          	ret
            if(curr==freeHead) freeHead=curr->next;
    80001624:	00853783          	ld	a5,8(a0)
    80001628:	0000a697          	auipc	a3,0xa
    8000162c:	c6f6b423          	sd	a5,-920(a3) # 8000b290 <freeHead>
    80001630:	fe1ff06f          	j	80001610 <_Z14kern_mem_alloci+0x30>
            if(curr==freeHead) freeHead=newFreeBlock;
    80001634:	0000a797          	auipc	a5,0xa
    80001638:	c4b7be23          	sd	a1,-932(a5) # 8000b290 <freeHead>
    8000163c:	05c0006f          	j	80001698 <_Z14kern_mem_alloci+0xb8>
        prev=curr;
    80001640:	00050613          	mv	a2,a0
        curr=curr->next;
    80001644:	00853503          	ld	a0,8(a0)
    while (curr){
    80001648:	fc0508e3          	beqz	a0,80001618 <_Z14kern_mem_alloci+0x38>
        if(curr->sizeInBlocks==sizeInBlocks+1){
    8000164c:	00052783          	lw	a5,0(a0)
    80001650:	0016871b          	addiw	a4,a3,1
    80001654:	fae788e3          	beq	a5,a4,80001604 <_Z14kern_mem_alloci+0x24>
        else if(curr->sizeInBlocks>sizeInBlocks+1){
    80001658:	fef754e3          	bge	a4,a5,80001640 <_Z14kern_mem_alloci+0x60>
            mem_block_s* newFreeBlock = curr+(sizeInBlocks+1)*MEM_BLOCK_SIZE;
    8000165c:	00a71593          	slli	a1,a4,0xa
    80001660:	00b505b3          	add	a1,a0,a1
            newFreeBlock->sizeInBlocks = curr->sizeInBlocks-sizeInBlocks-1;
    80001664:	40d787bb          	subw	a5,a5,a3
    80001668:	fff7879b          	addiw	a5,a5,-1
    8000166c:	00f5a023          	sw	a5,0(a1)
            newFreeBlock->startingBlock=curr->startingBlock+sizeInBlocks+1;
    80001670:	00452783          	lw	a5,4(a0)
    80001674:	00d786bb          	addw	a3,a5,a3
    80001678:	0016869b          	addiw	a3,a3,1
    8000167c:	00d5a223          	sw	a3,4(a1)
            newFreeBlock->next = curr->next;
    80001680:	00853783          	ld	a5,8(a0)
    80001684:	00f5b423          	sd	a5,8(a1)
            if(curr==freeHead) freeHead=newFreeBlock;
    80001688:	0000a797          	auipc	a5,0xa
    8000168c:	c087b783          	ld	a5,-1016(a5) # 8000b290 <freeHead>
    80001690:	faa782e3          	beq	a5,a0,80001634 <_Z14kern_mem_alloci+0x54>
            else prev->next=newFreeBlock;
    80001694:	00b63423          	sd	a1,8(a2)
            curr->sizeInBlocks=sizeInBlocks+1;
    80001698:	00e52023          	sw	a4,0(a0)
            return (curr+MEM_BLOCK_SIZE);
    8000169c:	40050513          	addi	a0,a0,1024
    800016a0:	f79ff06f          	j	80001618 <_Z14kern_mem_alloci+0x38>

00000000800016a4 <_Z13kern_mem_freePv>:

int kern_mem_free(void* addr)
{
    800016a4:	ff010113          	addi	sp,sp,-16
    800016a8:	00813423          	sd	s0,8(sp)
    800016ac:	01010413          	addi	s0,sp,16
    mem_block_s* freedBlock = (mem_block_s*) addr-MEM_BLOCK_SIZE;
    800016b0:	c0050713          	addi	a4,a0,-1024
    mem_block_s* curr=freeHead;
    800016b4:	0000a797          	auipc	a5,0xa
    800016b8:	bdc7b783          	ld	a5,-1060(a5) # 8000b290 <freeHead>
    mem_block_s * prev =0;
    800016bc:	00000693          	li	a3,0

    while (curr<freedBlock && curr!=0){
    800016c0:	00e7fa63          	bgeu	a5,a4,800016d4 <_Z13kern_mem_freePv+0x30>
    800016c4:	00078863          	beqz	a5,800016d4 <_Z13kern_mem_freePv+0x30>
        prev=curr;
    800016c8:	00078693          	mv	a3,a5
        curr=curr->next;
    800016cc:	0087b783          	ld	a5,8(a5)
    while (curr<freedBlock && curr!=0){
    800016d0:	ff1ff06f          	j	800016c0 <_Z13kern_mem_freePv+0x1c>
    char* cfreedBlock = (char *)freedBlock;
    char* cprev = (char *)prev;
    char* ccurr = (char *)curr;
    */

    if(prev){
    800016d4:	04068e63          	beqz	a3,80001730 <_Z13kern_mem_freePv+0x8c>
        if(prev->startingBlock+prev->sizeInBlocks==freedBlock->startingBlock){
    800016d8:	0046a603          	lw	a2,4(a3)
    800016dc:	0006a583          	lw	a1,0(a3)
    800016e0:	00b6063b          	addw	a2,a2,a1
    800016e4:	c0452803          	lw	a6,-1020(a0)
    800016e8:	03060a63          	beq	a2,a6,8000171c <_Z13kern_mem_freePv+0x78>
            prev->sizeInBlocks+=freedBlock->sizeInBlocks;
            freedBlock=prev;
        } else {
            prev->next=freedBlock;
    800016ec:	00e6b423          	sd	a4,8(a3)
        }
    }
    else freeHead=freedBlock;

    if(curr){
    800016f0:	00078e63          	beqz	a5,8000170c <_Z13kern_mem_freePv+0x68>
        if(freedBlock->startingBlock+freedBlock->sizeInBlocks==curr->startingBlock){
    800016f4:	00472683          	lw	a3,4(a4)
    800016f8:	00072603          	lw	a2,0(a4)
    800016fc:	00c686bb          	addw	a3,a3,a2
    80001700:	0047a583          	lw	a1,4(a5)
    80001704:	02b68c63          	beq	a3,a1,8000173c <_Z13kern_mem_freePv+0x98>
            freedBlock->sizeInBlocks+=curr->sizeInBlocks;
            freedBlock->next=curr->next;
        } else{
          freedBlock->next=curr;
    80001708:	00f73423          	sd	a5,8(a4)
        }
    }


    return 0;
}
    8000170c:	00000513          	li	a0,0
    80001710:	00813403          	ld	s0,8(sp)
    80001714:	01010113          	addi	sp,sp,16
    80001718:	00008067          	ret
            prev->sizeInBlocks+=freedBlock->sizeInBlocks;
    8000171c:	c0052703          	lw	a4,-1024(a0)
    80001720:	00e585bb          	addw	a1,a1,a4
    80001724:	00b6a023          	sw	a1,0(a3)
            freedBlock=prev;
    80001728:	00068713          	mv	a4,a3
    8000172c:	fc5ff06f          	j	800016f0 <_Z13kern_mem_freePv+0x4c>
    else freeHead=freedBlock;
    80001730:	0000a697          	auipc	a3,0xa
    80001734:	b6e6b023          	sd	a4,-1184(a3) # 8000b290 <freeHead>
    80001738:	fb9ff06f          	j	800016f0 <_Z13kern_mem_freePv+0x4c>
            freedBlock->sizeInBlocks+=curr->sizeInBlocks;
    8000173c:	0007a683          	lw	a3,0(a5)
    80001740:	00d6063b          	addw	a2,a2,a3
    80001744:	00c72023          	sw	a2,0(a4)
            freedBlock->next=curr->next;
    80001748:	0087b783          	ld	a5,8(a5)
    8000174c:	00f73423          	sd	a5,8(a4)
    80001750:	fbdff06f          	j	8000170c <_Z13kern_mem_freePv+0x68>

0000000080001754 <_Z13kern_mem_initPvS_>:

unsigned long ukupno_memorije;
void kern_mem_init(void* start, void* end)
{
    80001754:	ff010113          	addi	sp,sp,-16
    80001758:	00813423          	sd	s0,8(sp)
    8000175c:	01010413          	addi	s0,sp,16
    unsigned long lstart = (unsigned long) start;
    unsigned long lend = (unsigned long) end;
    80001760:	00058793          	mv	a5,a1

    if(lstart%MEM_BLOCK_SIZE>0) start =(void*) ((lstart/MEM_BLOCK_SIZE+1)*MEM_BLOCK_SIZE);
    80001764:	03f57713          	andi	a4,a0,63
    80001768:	00070863          	beqz	a4,80001778 <_Z13kern_mem_initPvS_+0x24>
    8000176c:	00655513          	srli	a0,a0,0x6
    80001770:	00150513          	addi	a0,a0,1
    80001774:	00651513          	slli	a0,a0,0x6
    if(lend%MEM_BLOCK_SIZE>0) end =(void*) ((lend/MEM_BLOCK_SIZE)*MEM_BLOCK_SIZE);
    80001778:	03f7f713          	andi	a4,a5,63
    8000177c:	00070463          	beqz	a4,80001784 <_Z13kern_mem_initPvS_+0x30>
    80001780:	fc07f593          	andi	a1,a5,-64

    freeHead = (mem_block_s*)start;
    80001784:	0000a797          	auipc	a5,0xa
    80001788:	b0c78793          	addi	a5,a5,-1268 # 8000b290 <freeHead>
    8000178c:	00a7b023          	sd	a0,0(a5)
    freeHead->next=0;
    80001790:	00053423          	sd	zero,8(a0)
    freeHead->startingBlock=0;
    80001794:	00052223          	sw	zero,4(a0)
    freeHead->sizeInBlocks = ((uint64)end-(uint64)start)/MEM_BLOCK_SIZE;
    80001798:	40a58533          	sub	a0,a1,a0
    8000179c:	00655513          	srli	a0,a0,0x6
    800017a0:	0007b703          	ld	a4,0(a5)
    800017a4:	00a72023          	sw	a0,0(a4)
    ukupno_memorije=freeHead->sizeInBlocks;
    800017a8:	0007b703          	ld	a4,0(a5)
    800017ac:	00072703          	lw	a4,0(a4)
    800017b0:	00e7b423          	sd	a4,8(a5)
}
    800017b4:	00813403          	ld	s0,8(sp)
    800017b8:	01010113          	addi	sp,sp,16
    800017bc:	00008067          	ret

00000000800017c0 <_Z17kern_console_initv>:
    int input_w;
    int output_r;
    int output_w;
} console;

void kern_console_init(){
    800017c0:	ff010113          	addi	sp,sp,-16
    800017c4:	00813423          	sd	s0,8(sp)
    800017c8:	01010413          	addi	s0,sp,16
    console.input_r=0;
    800017cc:	0000b797          	auipc	a5,0xb
    800017d0:	ad478793          	addi	a5,a5,-1324 # 8000c2a0 <kthreads+0x7d0>
    800017d4:	8007a023          	sw	zero,-2048(a5)
    console.input_w=0;
    800017d8:	8007a223          	sw	zero,-2044(a5)
    console.output_r=0;
    800017dc:	8007a423          	sw	zero,-2040(a5)
    console.input_w=0;
}
    800017e0:	00813403          	ld	s0,8(sp)
    800017e4:	01010113          	addi	sp,sp,16
    800017e8:	00008067          	ret

00000000800017ec <_Z12uart_getcharv>:

int uart_getchar(void)
{
    800017ec:	ff010113          	addi	sp,sp,-16
    800017f0:	00813423          	sd	s0,8(sp)
    800017f4:	01010413          	addi	s0,sp,16
    if((ReadReg(CONSOLE_STATUS) & CONSOLE_RX_STATUS_BIT)!=0){
    800017f8:	0000a797          	auipc	a5,0xa
    800017fc:	a187b783          	ld	a5,-1512(a5) # 8000b210 <_GLOBAL_OFFSET_TABLE_+0x10>
    80001800:	0007b783          	ld	a5,0(a5)
    80001804:	0007c783          	lbu	a5,0(a5)
    80001808:	0017f793          	andi	a5,a5,1
    8000180c:	02078263          	beqz	a5,80001830 <_Z12uart_getcharv+0x44>
        // input data is ready.
        return ReadReg(CONSOLE_RX_DATA);
    80001810:	0000a797          	auipc	a5,0xa
    80001814:	9f87b783          	ld	a5,-1544(a5) # 8000b208 <_GLOBAL_OFFSET_TABLE_+0x8>
    80001818:	0007b783          	ld	a5,0(a5)
    8000181c:	0007c503          	lbu	a0,0(a5)
    80001820:	0ff57513          	andi	a0,a0,255
    } else {
        return -1;
    }
}
    80001824:	00813403          	ld	s0,8(sp)
    80001828:	01010113          	addi	sp,sp,16
    8000182c:	00008067          	ret
        return -1;
    80001830:	fff00513          	li	a0,-1
    80001834:	ff1ff06f          	j	80001824 <_Z12uart_getcharv+0x38>

0000000080001838 <_Z12uart_putcharv>:

void uart_putchar()
{
    80001838:	ff010113          	addi	sp,sp,-16
    8000183c:	00813423          	sd	s0,8(sp)
    80001840:	01010413          	addi	s0,sp,16
    if(console.output_r==console.output_w) return;
    80001844:	0000b717          	auipc	a4,0xb
    80001848:	a5c70713          	addi	a4,a4,-1444 # 8000c2a0 <kthreads+0x7d0>
    8000184c:	80872783          	lw	a5,-2040(a4)
    80001850:	80c72703          	lw	a4,-2036(a4)
    80001854:	06e78063          	beq	a5,a4,800018b4 <_Z12uart_putcharv+0x7c>

    if((ReadReg(CONSOLE_STATUS) & CONSOLE_TX_STATUS_BIT) == 0){
    80001858:	0000a717          	auipc	a4,0xa
    8000185c:	9b873703          	ld	a4,-1608(a4) # 8000b210 <_GLOBAL_OFFSET_TABLE_+0x10>
    80001860:	00073703          	ld	a4,0(a4)
    80001864:	00074703          	lbu	a4,0(a4)
    80001868:	0ff77713          	andi	a4,a4,255
    8000186c:	02077713          	andi	a4,a4,32
    80001870:	04070263          	beqz	a4,800018b4 <_Z12uart_putcharv+0x7c>
        return;
    }

    char c = console.output[(console.output_r++)%BUFFER_SIZE];
    80001874:	0017871b          	addiw	a4,a5,1
    80001878:	0000a697          	auipc	a3,0xa
    8000187c:	22e6a823          	sw	a4,560(a3) # 8000baa8 <console+0x808>
    80001880:	41f7d71b          	sraiw	a4,a5,0x1f
    80001884:	0167571b          	srliw	a4,a4,0x16
    80001888:	00f707bb          	addw	a5,a4,a5
    8000188c:	3ff7f793          	andi	a5,a5,1023
    80001890:	40e787bb          	subw	a5,a5,a4
    80001894:	0000a717          	auipc	a4,0xa
    80001898:	a0c70713          	addi	a4,a4,-1524 # 8000b2a0 <console>
    8000189c:	00f707b3          	add	a5,a4,a5
    800018a0:	4007c703          	lbu	a4,1024(a5)
    WriteReg(CONSOLE_TX_DATA,c);
    800018a4:	0000a797          	auipc	a5,0xa
    800018a8:	98c7b783          	ld	a5,-1652(a5) # 8000b230 <_GLOBAL_OFFSET_TABLE_+0x30>
    800018ac:	0007b783          	ld	a5,0(a5)
    800018b0:	00e78023          	sb	a4,0(a5)
}
    800018b4:	00813403          	ld	s0,8(sp)
    800018b8:	01010113          	addi	sp,sp,16
    800018bc:	00008067          	ret

00000000800018c0 <_Z17kern_uart_handlerv>:

void kern_uart_handler()
{
    800018c0:	ff010113          	addi	sp,sp,-16
    800018c4:	00113423          	sd	ra,8(sp)
    800018c8:	00813023          	sd	s0,0(sp)
    800018cc:	01010413          	addi	s0,sp,16
    while(1){
        int c = uart_getchar();
    800018d0:	00000097          	auipc	ra,0x0
    800018d4:	f1c080e7          	jalr	-228(ra) # 800017ec <_Z12uart_getcharv>
        if(c==-1) break;
    800018d8:	fff00793          	li	a5,-1
    800018dc:	04f50063          	beq	a0,a5,8000191c <_Z17kern_uart_handlerv+0x5c>
        console.input[(console.input_w++)%BUFFER_SIZE]=c;
    800018e0:	0000b717          	auipc	a4,0xb
    800018e4:	9c070713          	addi	a4,a4,-1600 # 8000c2a0 <kthreads+0x7d0>
    800018e8:	80472783          	lw	a5,-2044(a4)
    800018ec:	0017869b          	addiw	a3,a5,1
    800018f0:	80d72223          	sw	a3,-2044(a4)
    800018f4:	41f7d71b          	sraiw	a4,a5,0x1f
    800018f8:	0167571b          	srliw	a4,a4,0x16
    800018fc:	00f707bb          	addw	a5,a4,a5
    80001900:	3ff7f793          	andi	a5,a5,1023
    80001904:	40e787bb          	subw	a5,a5,a4
    80001908:	0000a717          	auipc	a4,0xa
    8000190c:	99870713          	addi	a4,a4,-1640 # 8000b2a0 <console>
    80001910:	00f707b3          	add	a5,a4,a5
    80001914:	00a78023          	sb	a0,0(a5)
    }
    80001918:	fb9ff06f          	j	800018d0 <_Z17kern_uart_handlerv+0x10>

    uart_putchar();
    8000191c:	00000097          	auipc	ra,0x0
    80001920:	f1c080e7          	jalr	-228(ra) # 80001838 <_Z12uart_putcharv>
}
    80001924:	00813083          	ld	ra,8(sp)
    80001928:	00013403          	ld	s0,0(sp)
    8000192c:	01010113          	addi	sp,sp,16
    80001930:	00008067          	ret

0000000080001934 <_Z20kern_console_getcharv>:

int kern_console_getchar()
{
    80001934:	ff010113          	addi	sp,sp,-16
    80001938:	00813423          	sd	s0,8(sp)
    8000193c:	01010413          	addi	s0,sp,16
    if(console.input_r<console.input_w){
    80001940:	0000b717          	auipc	a4,0xb
    80001944:	96070713          	addi	a4,a4,-1696 # 8000c2a0 <kthreads+0x7d0>
    80001948:	80072783          	lw	a5,-2048(a4)
    8000194c:	80472703          	lw	a4,-2044(a4)
    80001950:	04e7d063          	bge	a5,a4,80001990 <_Z20kern_console_getcharv+0x5c>
        return console.input[(console.input_r++)%BUFFER_SIZE];
    80001954:	0017871b          	addiw	a4,a5,1
    80001958:	0000a697          	auipc	a3,0xa
    8000195c:	14e6a423          	sw	a4,328(a3) # 8000baa0 <console+0x800>
    80001960:	41f7d71b          	sraiw	a4,a5,0x1f
    80001964:	0167571b          	srliw	a4,a4,0x16
    80001968:	00f707bb          	addw	a5,a4,a5
    8000196c:	3ff7f793          	andi	a5,a5,1023
    80001970:	40e787bb          	subw	a5,a5,a4
    80001974:	0000a717          	auipc	a4,0xa
    80001978:	92c70713          	addi	a4,a4,-1748 # 8000b2a0 <console>
    8000197c:	00f707b3          	add	a5,a4,a5
    80001980:	0007c503          	lbu	a0,0(a5)
    }
    else return -1;
}
    80001984:	00813403          	ld	s0,8(sp)
    80001988:	01010113          	addi	sp,sp,16
    8000198c:	00008067          	ret
    else return -1;
    80001990:	fff00513          	li	a0,-1
    80001994:	ff1ff06f          	j	80001984 <_Z20kern_console_getcharv+0x50>

0000000080001998 <_Z20kern_console_putcharc>:

int kern_console_putchar(char c)
{
    80001998:	ff010113          	addi	sp,sp,-16
    8000199c:	00813423          	sd	s0,8(sp)
    800019a0:	01010413          	addi	s0,sp,16
    if(ReadReg(CONSOLE_STATUS) & CONSOLE_TX_STATUS_BIT){
    800019a4:	0000a797          	auipc	a5,0xa
    800019a8:	86c7b783          	ld	a5,-1940(a5) # 8000b210 <_GLOBAL_OFFSET_TABLE_+0x10>
    800019ac:	0007b783          	ld	a5,0(a5)
    800019b0:	0007c783          	lbu	a5,0(a5)
    800019b4:	0ff7f793          	andi	a5,a5,255
    800019b8:	0207f793          	andi	a5,a5,32
    800019bc:	02078263          	beqz	a5,800019e0 <_Z20kern_console_putcharc+0x48>
        WriteReg(CONSOLE_TX_DATA,c);
    800019c0:	0000a797          	auipc	a5,0xa
    800019c4:	8707b783          	ld	a5,-1936(a5) # 8000b230 <_GLOBAL_OFFSET_TABLE_+0x30>
    800019c8:	0007b783          	ld	a5,0(a5)
    800019cc:	00a78023          	sb	a0,0(a5)
    }
    else{
        if(console.output_r-console.output_w>=BUFFER_SIZE) return -1;
        console.output[(console.output_w++)%BUFFER_SIZE]=c;
    }
    return 0;
    800019d0:	00000513          	li	a0,0
}
    800019d4:	00813403          	ld	s0,8(sp)
    800019d8:	01010113          	addi	sp,sp,16
    800019dc:	00008067          	ret
        if(console.output_r-console.output_w>=BUFFER_SIZE) return -1;
    800019e0:	0000b797          	auipc	a5,0xb
    800019e4:	8c078793          	addi	a5,a5,-1856 # 8000c2a0 <kthreads+0x7d0>
    800019e8:	8087a703          	lw	a4,-2040(a5)
    800019ec:	80c7a783          	lw	a5,-2036(a5)
    800019f0:	40f7073b          	subw	a4,a4,a5
    800019f4:	3ff00693          	li	a3,1023
    800019f8:	02e6ce63          	blt	a3,a4,80001a34 <_Z20kern_console_putcharc+0x9c>
        console.output[(console.output_w++)%BUFFER_SIZE]=c;
    800019fc:	0017871b          	addiw	a4,a5,1
    80001a00:	0000a697          	auipc	a3,0xa
    80001a04:	0ae6a623          	sw	a4,172(a3) # 8000baac <console+0x80c>
    80001a08:	41f7d71b          	sraiw	a4,a5,0x1f
    80001a0c:	0167571b          	srliw	a4,a4,0x16
    80001a10:	00f707bb          	addw	a5,a4,a5
    80001a14:	3ff7f793          	andi	a5,a5,1023
    80001a18:	40e787bb          	subw	a5,a5,a4
    80001a1c:	0000a717          	auipc	a4,0xa
    80001a20:	88470713          	addi	a4,a4,-1916 # 8000b2a0 <console>
    80001a24:	00f707b3          	add	a5,a4,a5
    80001a28:	40a78023          	sb	a0,1024(a5)
    return 0;
    80001a2c:	00000513          	li	a0,0
    80001a30:	fa5ff06f          	j	800019d4 <_Z20kern_console_putcharc+0x3c>
        if(console.output_r-console.output_w>=BUFFER_SIZE) return -1;
    80001a34:	fff00513          	li	a0,-1
    80001a38:	f9dff06f          	j	800019d4 <_Z20kern_console_putcharc+0x3c>

0000000080001a3c <_Z8bodyIdlePv>:

Semaphore* semTest;

int idleAlive=1;
void bodyIdle(void* arg){
    while(idleAlive){
    80001a3c:	00009797          	auipc	a5,0x9
    80001a40:	5b47a783          	lw	a5,1460(a5) # 8000aff0 <idleAlive>
    80001a44:	02078c63          	beqz	a5,80001a7c <_Z8bodyIdlePv+0x40>
void bodyIdle(void* arg){
    80001a48:	ff010113          	addi	sp,sp,-16
    80001a4c:	00113423          	sd	ra,8(sp)
    80001a50:	00813023          	sd	s0,0(sp)
    80001a54:	01010413          	addi	s0,sp,16
        thread_dispatch();
    80001a58:	00000097          	auipc	ra,0x0
    80001a5c:	930080e7          	jalr	-1744(ra) # 80001388 <_Z15thread_dispatchv>
    while(idleAlive){
    80001a60:	00009797          	auipc	a5,0x9
    80001a64:	5907a783          	lw	a5,1424(a5) # 8000aff0 <idleAlive>
    80001a68:	fe0798e3          	bnez	a5,80001a58 <_Z8bodyIdlePv+0x1c>
    };
}
    80001a6c:	00813083          	ld	ra,8(sp)
    80001a70:	00013403          	ld	s0,0(sp)
    80001a74:	01010113          	addi	sp,sp,16
    80001a78:	00008067          	ret
    80001a7c:	00008067          	ret

0000000080001a80 <_Z5bodyCPv>:

void bodyC(void* arg)
{
    80001a80:	fe010113          	addi	sp,sp,-32
    80001a84:	00113c23          	sd	ra,24(sp)
    80001a88:	00813823          	sd	s0,16(sp)
    80001a8c:	00913423          	sd	s1,8(sp)
    80001a90:	01213023          	sd	s2,0(sp)
    80001a94:	02010413          	addi	s0,sp,32
    80001a98:	00050913          	mv	s2,a0
    int counter=0;
    80001a9c:	00000493          	li	s1,0
    char*c = (char*)arg;
    while(counter<10){
    80001aa0:	00900793          	li	a5,9
    80001aa4:	0297c263          	blt	a5,s1,80001ac8 <_Z5bodyCPv+0x48>
        //if(++counter>5) delete semTest;
        putc(*c);
    80001aa8:	00094503          	lbu	a0,0(s2)
    80001aac:	00000097          	auipc	ra,0x0
    80001ab0:	b04080e7          	jalr	-1276(ra) # 800015b0 <_Z4putcc>
        time_sleep(1);
    80001ab4:	00100513          	li	a0,1
    80001ab8:	00000097          	auipc	ra,0x0
    80001abc:	a88080e7          	jalr	-1400(ra) # 80001540 <_Z10time_sleepm>
        counter++;
    80001ac0:	0014849b          	addiw	s1,s1,1
    while(counter<10){
    80001ac4:	fddff06f          	j	80001aa0 <_Z5bodyCPv+0x20>
    }
    counter++;
    //thread_exit();
}
    80001ac8:	01813083          	ld	ra,24(sp)
    80001acc:	01013403          	ld	s0,16(sp)
    80001ad0:	00813483          	ld	s1,8(sp)
    80001ad4:	00013903          	ld	s2,0(sp)
    80001ad8:	02010113          	addi	sp,sp,32
    80001adc:	00008067          	ret

0000000080001ae0 <_Z5bodyAPv>:

void bodyA(void* arg)
{
    80001ae0:	fe010113          	addi	sp,sp,-32
    80001ae4:	00113c23          	sd	ra,24(sp)
    80001ae8:	00813823          	sd	s0,16(sp)
    80001aec:	00913423          	sd	s1,8(sp)
    80001af0:	01213023          	sd	s2,0(sp)
    80001af4:	02010413          	addi	s0,sp,32
        }
        virtual ~Semaphore (){
            sem_close(myHandle);
        }
        int wait (){
            return sem_wait(myHandle);
    80001af8:	0000a797          	auipc	a5,0xa
    80001afc:	fb87b783          	ld	a5,-72(a5) # 8000bab0 <semTest>
    80001b00:	0087b503          	ld	a0,8(a5)
    80001b04:	00000097          	auipc	ra,0x0
    80001b08:	9bc080e7          	jalr	-1604(ra) # 800014c0 <_Z8sem_waitP5sem_s>
    char c = 'a';
    if(semTest->wait()) c='A';
    80001b0c:	00051863          	bnez	a0,80001b1c <_Z5bodyAPv+0x3c>
    char c = 'a';
    80001b10:	06100913          	li	s2,97
    for(int i=0;i<10;i++){
    80001b14:	00000493          	li	s1,0
    80001b18:	0200006f          	j	80001b38 <_Z5bodyAPv+0x58>
    if(semTest->wait()) c='A';
    80001b1c:	04100913          	li	s2,65
    80001b20:	ff5ff06f          	j	80001b14 <_Z5bodyAPv+0x34>
        putc(c);
        if(i==5) thread_exit();
    80001b24:	00000097          	auipc	ra,0x0
    80001b28:	890080e7          	jalr	-1904(ra) # 800013b4 <_Z11thread_exitv>
        thread_dispatch();
    80001b2c:	00000097          	auipc	ra,0x0
    80001b30:	85c080e7          	jalr	-1956(ra) # 80001388 <_Z15thread_dispatchv>
    for(int i=0;i<10;i++){
    80001b34:	0014849b          	addiw	s1,s1,1
    80001b38:	00900793          	li	a5,9
    80001b3c:	0097ce63          	blt	a5,s1,80001b58 <_Z5bodyAPv+0x78>
        putc(c);
    80001b40:	00090513          	mv	a0,s2
    80001b44:	00000097          	auipc	ra,0x0
    80001b48:	a6c080e7          	jalr	-1428(ra) # 800015b0 <_Z4putcc>
        if(i==5) thread_exit();
    80001b4c:	00500793          	li	a5,5
    80001b50:	fcf49ee3          	bne	s1,a5,80001b2c <_Z5bodyAPv+0x4c>
    80001b54:	fd1ff06f          	j	80001b24 <_Z5bodyAPv+0x44>
    }
}
    80001b58:	01813083          	ld	ra,24(sp)
    80001b5c:	01013403          	ld	s0,16(sp)
    80001b60:	00813483          	ld	s1,8(sp)
    80001b64:	00013903          	ld	s2,0(sp)
    80001b68:	02010113          	addi	sp,sp,32
    80001b6c:	00008067          	ret

0000000080001b70 <_Z5bodyBPv>:

int g=0;

char str[15] = "tesa legenda";
void bodyB(void* arg)
{
    80001b70:	fe010113          	addi	sp,sp,-32
    80001b74:	00113c23          	sd	ra,24(sp)
    80001b78:	00813823          	sd	s0,16(sp)
    80001b7c:	00913423          	sd	s1,8(sp)
    80001b80:	02010413          	addi	s0,sp,32

    time_sleep(10);
    80001b84:	00a00513          	li	a0,10
    80001b88:	00000097          	auipc	ra,0x0
    80001b8c:	9b8080e7          	jalr	-1608(ra) # 80001540 <_Z10time_sleepm>
    for(int i=0;i<4;i++){
    80001b90:	00000493          	li	s1,0
    80001b94:	0540006f          	j	80001be8 <_Z5bodyBPv+0x78>
        putc(str[i]);
        for(int k=0;k<10000;k++){
            for(int m=0;m<1000;m++){
    80001b98:	0017071b          	addiw	a4,a4,1
    80001b9c:	3e700793          	li	a5,999
    80001ba0:	02e7c663          	blt	a5,a4,80001bcc <_Z5bodyBPv+0x5c>
                if((m*k)%1337==0) g++;
    80001ba4:	02e607bb          	mulw	a5,a2,a4
    80001ba8:	53900693          	li	a3,1337
    80001bac:	02d7e7bb          	remw	a5,a5,a3
    80001bb0:	fe0794e3          	bnez	a5,80001b98 <_Z5bodyBPv+0x28>
    80001bb4:	0000a697          	auipc	a3,0xa
    80001bb8:	efc68693          	addi	a3,a3,-260 # 8000bab0 <semTest>
    80001bbc:	0086a783          	lw	a5,8(a3)
    80001bc0:	0017879b          	addiw	a5,a5,1
    80001bc4:	00f6a423          	sw	a5,8(a3)
    80001bc8:	fd1ff06f          	j	80001b98 <_Z5bodyBPv+0x28>
        for(int k=0;k<10000;k++){
    80001bcc:	0016061b          	addiw	a2,a2,1
    80001bd0:	000027b7          	lui	a5,0x2
    80001bd4:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    80001bd8:	00c7c663          	blt	a5,a2,80001be4 <_Z5bodyBPv+0x74>
            for(int m=0;m<1000;m++){
    80001bdc:	00000713          	li	a4,0
    80001be0:	fbdff06f          	j	80001b9c <_Z5bodyBPv+0x2c>
    for(int i=0;i<4;i++){
    80001be4:	0014849b          	addiw	s1,s1,1
    80001be8:	00300793          	li	a5,3
    80001bec:	0297c263          	blt	a5,s1,80001c10 <_Z5bodyBPv+0xa0>
        putc(str[i]);
    80001bf0:	00009797          	auipc	a5,0x9
    80001bf4:	40078793          	addi	a5,a5,1024 # 8000aff0 <idleAlive>
    80001bf8:	009787b3          	add	a5,a5,s1
    80001bfc:	0087c503          	lbu	a0,8(a5)
    80001c00:	00000097          	auipc	ra,0x0
    80001c04:	9b0080e7          	jalr	-1616(ra) # 800015b0 <_Z4putcc>
        for(int k=0;k<10000;k++){
    80001c08:	00000613          	li	a2,0
    80001c0c:	fc5ff06f          	j	80001bd0 <_Z5bodyBPv+0x60>
        }
        int signal (){
            return sem_signal(myHandle);
    80001c10:	0000a797          	auipc	a5,0xa
    80001c14:	ea07b783          	ld	a5,-352(a5) # 8000bab0 <semTest>
    80001c18:	0087b503          	ld	a0,8(a5)
    80001c1c:	00000097          	auipc	ra,0x0
    80001c20:	8e4080e7          	jalr	-1820(ra) # 80001500 <_Z10sem_signalP5sem_s>
            }
        }
    }
    semTest->signal();
}
    80001c24:	01813083          	ld	ra,24(sp)
    80001c28:	01013403          	ld	s0,16(sp)
    80001c2c:	00813483          	ld	s1,8(sp)
    80001c30:	02010113          	addi	sp,sp,32
    80001c34:	00008067          	ret

0000000080001c38 <main>:

extern void userMain();

int main()
{
    80001c38:	ff010113          	addi	sp,sp,-16
    80001c3c:	00113423          	sd	ra,8(sp)
    80001c40:	00813023          	sd	s0,0(sp)
    80001c44:	01010413          	addi	s0,sp,16
    kern_thread_init();
    80001c48:	00000097          	auipc	ra,0x0
    80001c4c:	170080e7          	jalr	368(ra) # 80001db8 <_Z16kern_thread_initv>
    //printstring("lalala");

    kern_mem_init((void*)HEAP_START_ADDR, (void*)HEAP_END_ADDR);
    80001c50:	00009797          	auipc	a5,0x9
    80001c54:	5f07b783          	ld	a5,1520(a5) # 8000b240 <_GLOBAL_OFFSET_TABLE_+0x40>
    80001c58:	0007b583          	ld	a1,0(a5)
    80001c5c:	00009797          	auipc	a5,0x9
    80001c60:	5bc7b783          	ld	a5,1468(a5) # 8000b218 <_GLOBAL_OFFSET_TABLE_+0x18>
    80001c64:	0007b503          	ld	a0,0(a5)
    80001c68:	00000097          	auipc	ra,0x0
    80001c6c:	aec080e7          	jalr	-1300(ra) # 80001754 <_Z13kern_mem_initPvS_>
    kern_interrupt_init();
    80001c70:	00001097          	auipc	ra,0x1
    80001c74:	908080e7          	jalr	-1784(ra) # 80002578 <_Z19kern_interrupt_initv>
    kern_sem_init();
    80001c78:	00000097          	auipc	ra,0x0
    80001c7c:	6ec080e7          	jalr	1772(ra) # 80002364 <_Z13kern_sem_initv>
    kern_console_init();
    80001c80:	00000097          	auipc	ra,0x0
    80001c84:	b40080e7          	jalr	-1216(ra) # 800017c0 <_Z17kern_console_initv>

    Thread* thrIdle = new Thread(&bodyIdle,0);
    80001c88:	02000513          	li	a0,32
    80001c8c:	00000097          	auipc	ra,0x0
    80001c90:	0dc080e7          	jalr	220(ra) # 80001d68 <_Znwm>
        {
    80001c94:	00009797          	auipc	a5,0x9
    80001c98:	38478793          	addi	a5,a5,900 # 8000b018 <_ZTV6Thread+0x10>
    80001c9c:	00f53023          	sd	a5,0(a0)
            this->body=body;
    80001ca0:	00000597          	auipc	a1,0x0
    80001ca4:	d9c58593          	addi	a1,a1,-612 # 80001a3c <_Z8bodyIdlePv>
    80001ca8:	00b53823          	sd	a1,16(a0)
            this->arg=arg;
    80001cac:	00053c23          	sd	zero,24(a0)
            else return thread_create(&myHandle,body,arg);
    80001cb0:	00000613          	li	a2,0
    80001cb4:	00850513          	addi	a0,a0,8
    80001cb8:	fffff097          	auipc	ra,0xfffff
    80001cbc:	648080e7          	jalr	1608(ra) # 80001300 <_Z13thread_createPP8thread_sPFvPvES2_>
*/
    /*char x = getc();
    x=getc();
    x++;
    putc(x);*/
    userMain();
    80001cc0:	00003097          	auipc	ra,0x3
    80001cc4:	75c080e7          	jalr	1884(ra) # 8000541c <_Z8userMainv>
    while (x!='x'){
        x=getc();
        putc(x);
    }
*/
    idleAlive=0;
    80001cc8:	00009797          	auipc	a5,0x9
    80001ccc:	3207a423          	sw	zero,808(a5) # 8000aff0 <idleAlive>
    return 0;
    80001cd0:	00000513          	li	a0,0
    80001cd4:	00813083          	ld	ra,8(sp)
    80001cd8:	00013403          	ld	s0,0(sp)
    80001cdc:	01010113          	addi	sp,sp,16
    80001ce0:	00008067          	ret

0000000080001ce4 <_ZN6ThreadD1Ev>:
        virtual ~Thread (){
    80001ce4:	ff010113          	addi	sp,sp,-16
    80001ce8:	00813423          	sd	s0,8(sp)
    80001cec:	01010413          	addi	s0,sp,16
        }
    80001cf0:	00813403          	ld	s0,8(sp)
    80001cf4:	01010113          	addi	sp,sp,16
    80001cf8:	00008067          	ret

0000000080001cfc <_ZN6Thread3runEv>:
        virtual void run () {}
    80001cfc:	ff010113          	addi	sp,sp,-16
    80001d00:	00813423          	sd	s0,8(sp)
    80001d04:	01010413          	addi	s0,sp,16
    80001d08:	00813403          	ld	s0,8(sp)
    80001d0c:	01010113          	addi	sp,sp,16
    80001d10:	00008067          	ret

0000000080001d14 <_ZN6Thread11threadEntryEPv>:
        static void threadEntry(void* arg){
    80001d14:	ff010113          	addi	sp,sp,-16
    80001d18:	00113423          	sd	ra,8(sp)
    80001d1c:	00813023          	sd	s0,0(sp)
    80001d20:	01010413          	addi	s0,sp,16
            self->run();
    80001d24:	00053783          	ld	a5,0(a0)
    80001d28:	0107b783          	ld	a5,16(a5)
    80001d2c:	000780e7          	jalr	a5
        }
    80001d30:	00813083          	ld	ra,8(sp)
    80001d34:	00013403          	ld	s0,0(sp)
    80001d38:	01010113          	addi	sp,sp,16
    80001d3c:	00008067          	ret

0000000080001d40 <_ZN6ThreadD0Ev>:
        virtual ~Thread (){
    80001d40:	ff010113          	addi	sp,sp,-16
    80001d44:	00113423          	sd	ra,8(sp)
    80001d48:	00813023          	sd	s0,0(sp)
    80001d4c:	01010413          	addi	s0,sp,16
        }
    80001d50:	00000097          	auipc	ra,0x0
    80001d54:	040080e7          	jalr	64(ra) # 80001d90 <_ZdlPv>
    80001d58:	00813083          	ld	ra,8(sp)
    80001d5c:	00013403          	ld	s0,0(sp)
    80001d60:	01010113          	addi	sp,sp,16
    80001d64:	00008067          	ret

0000000080001d68 <_Znwm>:
// Created by os on 6/7/23.
//
#include "../h/syscall_cpp.hpp"


void* operator new(size_t size) {
    80001d68:	ff010113          	addi	sp,sp,-16
    80001d6c:	00113423          	sd	ra,8(sp)
    80001d70:	00813023          	sd	s0,0(sp)
    80001d74:	01010413          	addi	s0,sp,16
    void* ptr = mem_alloc(size);
    80001d78:	fffff097          	auipc	ra,0xfffff
    80001d7c:	508080e7          	jalr	1288(ra) # 80001280 <_Z9mem_allocm>
    return ptr;
}
    80001d80:	00813083          	ld	ra,8(sp)
    80001d84:	00013403          	ld	s0,0(sp)
    80001d88:	01010113          	addi	sp,sp,16
    80001d8c:	00008067          	ret

0000000080001d90 <_ZdlPv>:

void operator delete(void* ptr) {
    80001d90:	ff010113          	addi	sp,sp,-16
    80001d94:	00113423          	sd	ra,8(sp)
    80001d98:	00813023          	sd	s0,0(sp)
    80001d9c:	01010413          	addi	s0,sp,16
    mem_free(ptr);
    80001da0:	fffff097          	auipc	ra,0xfffff
    80001da4:	520080e7          	jalr	1312(ra) # 800012c0 <_Z8mem_freePv>
}
    80001da8:	00813083          	ld	ra,8(sp)
    80001dac:	00013403          	ld	s0,0(sp)
    80001db0:	01010113          	addi	sp,sp,16
    80001db4:	00008067          	ret

0000000080001db8 <_Z16kern_thread_initv>:
struct thread_s kthreads[MAX_THREADS];
static int id;
struct thread_s* running;

void kern_thread_init()
{
    80001db8:	ff010113          	addi	sp,sp,-16
    80001dbc:	00813423          	sd	s0,8(sp)
    80001dc0:	01010413          	addi	s0,sp,16
    id=0;
    80001dc4:	0000a797          	auipc	a5,0xa
    80001dc8:	ce07ae23          	sw	zero,-772(a5) # 8000bac0 <_ZL2id>
    for (int i=0;i<MAX_THREADS;i++){
    80001dcc:	00000793          	li	a5,0
    80001dd0:	03f00713          	li	a4,63
    80001dd4:	02f74463          	blt	a4,a5,80001dfc <_Z16kern_thread_initv+0x44>
        kthreads[i].status=UNUSED;
    80001dd8:	00179713          	slli	a4,a5,0x1
    80001ddc:	00f70733          	add	a4,a4,a5
    80001de0:	00571693          	slli	a3,a4,0x5
    80001de4:	0000a717          	auipc	a4,0xa
    80001de8:	cec70713          	addi	a4,a4,-788 # 8000bad0 <kthreads>
    80001dec:	00d70733          	add	a4,a4,a3
    80001df0:	04072823          	sw	zero,80(a4)
    for (int i=0;i<MAX_THREADS;i++){
    80001df4:	0017879b          	addiw	a5,a5,1
    80001df8:	fd9ff06f          	j	80001dd0 <_Z16kern_thread_initv+0x18>
    }

    //set kthreads[0] as main thread
    kthreads[0].status=RUNNING;
    80001dfc:	0000a797          	auipc	a5,0xa
    80001e00:	cd478793          	addi	a5,a5,-812 # 8000bad0 <kthreads>
    80001e04:	00100713          	li	a4,1
    80001e08:	04e7a823          	sw	a4,80(a5)
    kthreads[0].id=0;
    80001e0c:	0007b823          	sd	zero,16(a5)
    kthreads[0].timeslice=DEFAULT_TIME_SLICE+2;
    80001e10:	00400713          	li	a4,4
    80001e14:	02e7b823          	sd	a4,48(a5)
    kthreads[0].endTime=0;
    80001e18:	0207bc23          	sd	zero,56(a5)
    running=&kthreads[0];
    80001e1c:	0000a717          	auipc	a4,0xa
    80001e20:	caf73623          	sd	a5,-852(a4) # 8000bac8 <running>
}
    80001e24:	00813403          	ld	s0,8(sp)
    80001e28:	01010113          	addi	sp,sp,16
    80001e2c:	00008067          	ret

0000000080001e30 <_Z18kern_scheduler_getv>:

thread_t kern_scheduler_get()
{
    80001e30:	ff010113          	addi	sp,sp,-16
    80001e34:	00813423          	sd	s0,8(sp)
    80001e38:	01010413          	addi	s0,sp,16
    int num = running-kthreads;
    80001e3c:	0000a517          	auipc	a0,0xa
    80001e40:	c8c53503          	ld	a0,-884(a0) # 8000bac8 <running>
    80001e44:	0000a797          	auipc	a5,0xa
    80001e48:	c8c78793          	addi	a5,a5,-884 # 8000bad0 <kthreads>
    80001e4c:	40f507b3          	sub	a5,a0,a5
    80001e50:	4057d793          	srai	a5,a5,0x5
    80001e54:	00007717          	auipc	a4,0x7
    80001e58:	1cc73703          	ld	a4,460(a4) # 80009020 <CONSOLE_STATUS+0x10>
    80001e5c:	02e787bb          	mulw	a5,a5,a4
    for(int i=1;i<=MAX_THREADS;i++){
    80001e60:	00100693          	li	a3,1
    80001e64:	04000713          	li	a4,64
    80001e68:	06d74c63          	blt	a4,a3,80001ee0 <_Z18kern_scheduler_getv+0xb0>
        num = (num+i)%MAX_THREADS;
    80001e6c:	00d787bb          	addw	a5,a5,a3
    80001e70:	41f7d71b          	sraiw	a4,a5,0x1f
    80001e74:	01a7571b          	srliw	a4,a4,0x1a
    80001e78:	00e787bb          	addw	a5,a5,a4
    80001e7c:	03f7f793          	andi	a5,a5,63
    80001e80:	40e787bb          	subw	a5,a5,a4
        if(kthreads[num].status==READY){
    80001e84:	00179713          	slli	a4,a5,0x1
    80001e88:	00f70733          	add	a4,a4,a5
    80001e8c:	00571613          	slli	a2,a4,0x5
    80001e90:	0000a717          	auipc	a4,0xa
    80001e94:	c4070713          	addi	a4,a4,-960 # 8000bad0 <kthreads>
    80001e98:	00c70733          	add	a4,a4,a2
    80001e9c:	05072603          	lw	a2,80(a4)
    80001ea0:	00200713          	li	a4,2
    80001ea4:	00e60663          	beq	a2,a4,80001eb0 <_Z18kern_scheduler_getv+0x80>
    for(int i=1;i<=MAX_THREADS;i++){
    80001ea8:	0016869b          	addiw	a3,a3,1
    80001eac:	fb9ff06f          	j	80001e64 <_Z18kern_scheduler_getv+0x34>
            kthreads[num].status=RUNNING;
    80001eb0:	0000a617          	auipc	a2,0xa
    80001eb4:	c2060613          	addi	a2,a2,-992 # 8000bad0 <kthreads>
    80001eb8:	00179713          	slli	a4,a5,0x1
    80001ebc:	00f705b3          	add	a1,a4,a5
    80001ec0:	00559693          	slli	a3,a1,0x5
    80001ec4:	00d606b3          	add	a3,a2,a3
    80001ec8:	00100593          	li	a1,1
    80001ecc:	04b6a823          	sw	a1,80(a3)
            return &kthreads[num];
    80001ed0:	00068513          	mv	a0,a3
    if(running->status==READY || running->status==RUNNING) {
        running->status=RUNNING;
        return running;
    }
    return 0;
}
    80001ed4:	00813403          	ld	s0,8(sp)
    80001ed8:	01010113          	addi	sp,sp,16
    80001edc:	00008067          	ret
    if(running->status==READY || running->status==RUNNING) {
    80001ee0:	05052783          	lw	a5,80(a0)
    80001ee4:	fff7879b          	addiw	a5,a5,-1
    80001ee8:	00100713          	li	a4,1
    80001eec:	00f77663          	bgeu	a4,a5,80001ef8 <_Z18kern_scheduler_getv+0xc8>
    return 0;
    80001ef0:	00000513          	li	a0,0
    80001ef4:	fe1ff06f          	j	80001ed4 <_Z18kern_scheduler_getv+0xa4>
        running->status=RUNNING;
    80001ef8:	00100793          	li	a5,1
    80001efc:	04f52823          	sw	a5,80(a0)
        return running;
    80001f00:	fd5ff06f          	j	80001ed4 <_Z18kern_scheduler_getv+0xa4>

0000000080001f04 <_Z17kern_thread_yieldv>:

void kern_thread_yield()
{
    80001f04:	ff010113          	addi	sp,sp,-16
    80001f08:	00113423          	sd	ra,8(sp)
    80001f0c:	00813023          	sd	s0,0(sp)
    80001f10:	01010413          	addi	s0,sp,16
    kern_syscall(THREAD_DISPATCH);
    80001f14:	01300513          	li	a0,19
    80001f18:	00000097          	auipc	ra,0x0
    80001f1c:	694080e7          	jalr	1684(ra) # 800025ac <_Z12kern_syscall13SyscallNumberz>
}
    80001f20:	00813083          	ld	ra,8(sp)
    80001f24:	00013403          	ld	s0,0(sp)
    80001f28:	01010113          	addi	sp,sp,16
    80001f2c:	00008067          	ret

0000000080001f30 <_Z10popSppSpiev>:

//samo izlazi iz kernela i vraca se odakle je pozvana
void popSppSpie()
{
    80001f30:	ff010113          	addi	sp,sp,-16
    80001f34:	00813423          	sd	s0,8(sp)
    80001f38:	01010413          	addi	s0,sp,16
    __asm__ volatile("csrw sepc, ra"); //ovde dodaj izlazak iz privilegovanog moda
    80001f3c:	14109073          	csrw	sepc,ra
    __asm__ volatile("csrc sstatus, %[mask]" : : [mask] "r"(1 << 8));
    80001f40:	10000793          	li	a5,256
    80001f44:	1007b073          	csrc	sstatus,a5
    __asm__ volatile("sret");
    80001f48:	10200073          	sret
}
    80001f4c:	00813403          	ld	s0,8(sp)
    80001f50:	01010113          	addi	sp,sp,16
    80001f54:	00008067          	ret

0000000080001f58 <_Z19kern_thread_wrapperv>:
        contextSwitch(old,running);
    }
}

void kern_thread_wrapper()
{
    80001f58:	fe010113          	addi	sp,sp,-32
    80001f5c:	00113c23          	sd	ra,24(sp)
    80001f60:	00813823          	sd	s0,16(sp)
    80001f64:	00913423          	sd	s1,8(sp)
    80001f68:	02010413          	addi	s0,sp,32
    popSppSpie();
    80001f6c:	00000097          	auipc	ra,0x0
    80001f70:	fc4080e7          	jalr	-60(ra) # 80001f30 <_Z10popSppSpiev>
    running->body(running->arg);
    80001f74:	0000a497          	auipc	s1,0xa
    80001f78:	b4c48493          	addi	s1,s1,-1204 # 8000bac0 <_ZL2id>
    80001f7c:	0084b783          	ld	a5,8(s1)
    80001f80:	0187b703          	ld	a4,24(a5)
    80001f84:	0207b503          	ld	a0,32(a5)
    80001f88:	000700e7          	jalr	a4
    running->status=UNUSED;
    80001f8c:	0084b603          	ld	a2,8(s1)
    80001f90:	04062823          	sw	zero,80(a2)
    running->sem_next=0;
    80001f94:	04063c23          	sd	zero,88(a2)
    running->joined_tid=-1;
    80001f98:	fff00793          	li	a5,-1
    80001f9c:	02f63423          	sd	a5,40(a2)
    for(int i=0;i<MAX_THREADS;i++){
    80001fa0:	00000793          	li	a5,0
    80001fa4:	0080006f          	j	80001fac <_Z19kern_thread_wrapperv+0x54>
    80001fa8:	0017879b          	addiw	a5,a5,1
    80001fac:	03f00713          	li	a4,63
    80001fb0:	06f74863          	blt	a4,a5,80002020 <_Z19kern_thread_wrapperv+0xc8>
        if(kthreads[i].status==JOINED && kthreads[i].joined_tid==running->id) kthreads[i].status=READY;
    80001fb4:	00179713          	slli	a4,a5,0x1
    80001fb8:	00f70733          	add	a4,a4,a5
    80001fbc:	00571693          	slli	a3,a4,0x5
    80001fc0:	0000a717          	auipc	a4,0xa
    80001fc4:	b1070713          	addi	a4,a4,-1264 # 8000bad0 <kthreads>
    80001fc8:	00d70733          	add	a4,a4,a3
    80001fcc:	05072683          	lw	a3,80(a4)
    80001fd0:	00400713          	li	a4,4
    80001fd4:	fce69ae3          	bne	a3,a4,80001fa8 <_Z19kern_thread_wrapperv+0x50>
    80001fd8:	00179713          	slli	a4,a5,0x1
    80001fdc:	00f70733          	add	a4,a4,a5
    80001fe0:	00571693          	slli	a3,a4,0x5
    80001fe4:	0000a717          	auipc	a4,0xa
    80001fe8:	aec70713          	addi	a4,a4,-1300 # 8000bad0 <kthreads>
    80001fec:	00d70733          	add	a4,a4,a3
    80001ff0:	02873683          	ld	a3,40(a4)
    80001ff4:	01063703          	ld	a4,16(a2)
    80001ff8:	fae698e3          	bne	a3,a4,80001fa8 <_Z19kern_thread_wrapperv+0x50>
    80001ffc:	00179713          	slli	a4,a5,0x1
    80002000:	00f70733          	add	a4,a4,a5
    80002004:	00571693          	slli	a3,a4,0x5
    80002008:	0000a717          	auipc	a4,0xa
    8000200c:	ac870713          	addi	a4,a4,-1336 # 8000bad0 <kthreads>
    80002010:	00d70733          	add	a4,a4,a3
    80002014:	00200693          	li	a3,2
    80002018:	04d72823          	sw	a3,80(a4)
    8000201c:	f8dff06f          	j	80001fa8 <_Z19kern_thread_wrapperv+0x50>
    }

    thread_exit();
    80002020:	fffff097          	auipc	ra,0xfffff
    80002024:	394080e7          	jalr	916(ra) # 800013b4 <_Z11thread_exitv>
}
    80002028:	01813083          	ld	ra,24(sp)
    8000202c:	01013403          	ld	s0,16(sp)
    80002030:	00813483          	ld	s1,8(sp)
    80002034:	02010113          	addi	sp,sp,32
    80002038:	00008067          	ret

000000008000203c <_Z20kern_thread_dispatchv>:
{
    8000203c:	fe010113          	addi	sp,sp,-32
    80002040:	00113c23          	sd	ra,24(sp)
    80002044:	00813823          	sd	s0,16(sp)
    80002048:	00913423          	sd	s1,8(sp)
    8000204c:	01213023          	sd	s2,0(sp)
    80002050:	02010413          	addi	s0,sp,32
    thread_t old = running;
    80002054:	0000a917          	auipc	s2,0xa
    80002058:	a6c90913          	addi	s2,s2,-1428 # 8000bac0 <_ZL2id>
    8000205c:	00893483          	ld	s1,8(s2)
    running=kern_scheduler_get();
    80002060:	00000097          	auipc	ra,0x0
    80002064:	dd0080e7          	jalr	-560(ra) # 80001e30 <_Z18kern_scheduler_getv>
    80002068:	00a93423          	sd	a0,8(s2)
    if(old!=running){
    8000206c:	02950463          	beq	a0,s1,80002094 <_Z20kern_thread_dispatchv+0x58>
    80002070:	00050593          	mv	a1,a0
        running->status=RUNNING;
    80002074:	00100793          	li	a5,1
    80002078:	04f52823          	sw	a5,80(a0)
        if(old->status==RUNNING) old->status=READY;
    8000207c:	0504a703          	lw	a4,80(s1)
    80002080:	00100793          	li	a5,1
    80002084:	02f70463          	beq	a4,a5,800020ac <_Z20kern_thread_dispatchv+0x70>
        contextSwitch(old,running);
    80002088:	00048513          	mv	a0,s1
    8000208c:	fffff097          	auipc	ra,0xfffff
    80002090:	1c0080e7          	jalr	448(ra) # 8000124c <contextSwitch>
}
    80002094:	01813083          	ld	ra,24(sp)
    80002098:	01013403          	ld	s0,16(sp)
    8000209c:	00813483          	ld	s1,8(sp)
    800020a0:	00013903          	ld	s2,0(sp)
    800020a4:	02010113          	addi	sp,sp,32
    800020a8:	00008067          	ret
        if(old->status==RUNNING) old->status=READY;
    800020ac:	00200793          	li	a5,2
    800020b0:	04f4a823          	sw	a5,80(s1)
    800020b4:	fd5ff06f          	j	80002088 <_Z20kern_thread_dispatchv+0x4c>

00000000800020b8 <_Z23kern_thread_end_runningv>:
{
    800020b8:	fe010113          	addi	sp,sp,-32
    800020bc:	00113c23          	sd	ra,24(sp)
    800020c0:	00813823          	sd	s0,16(sp)
    800020c4:	00913423          	sd	s1,8(sp)
    800020c8:	02010413          	addi	s0,sp,32
    thread_t old = running;
    800020cc:	0000a497          	auipc	s1,0xa
    800020d0:	9fc4b483          	ld	s1,-1540(s1) # 8000bac8 <running>
    old->status=UNUSED;
    800020d4:	0404a823          	sw	zero,80(s1)
    for(int i=0;i<MAX_THREADS;i++){
    800020d8:	00000713          	li	a4,0
    800020dc:	0080006f          	j	800020e4 <_Z23kern_thread_end_runningv+0x2c>
    800020e0:	0017071b          	addiw	a4,a4,1
    800020e4:	03f00793          	li	a5,63
    800020e8:	06e7c863          	blt	a5,a4,80002158 <_Z23kern_thread_end_runningv+0xa0>
        if(kthreads[i].status==JOINED && kthreads[i].joined_tid==old->id) kthreads[i].status=READY;
    800020ec:	00171793          	slli	a5,a4,0x1
    800020f0:	00e787b3          	add	a5,a5,a4
    800020f4:	00579793          	slli	a5,a5,0x5
    800020f8:	0000a697          	auipc	a3,0xa
    800020fc:	9d868693          	addi	a3,a3,-1576 # 8000bad0 <kthreads>
    80002100:	00f687b3          	add	a5,a3,a5
    80002104:	0507a683          	lw	a3,80(a5)
    80002108:	00400793          	li	a5,4
    8000210c:	fcf69ae3          	bne	a3,a5,800020e0 <_Z23kern_thread_end_runningv+0x28>
    80002110:	00171793          	slli	a5,a4,0x1
    80002114:	00e787b3          	add	a5,a5,a4
    80002118:	00579793          	slli	a5,a5,0x5
    8000211c:	0000a697          	auipc	a3,0xa
    80002120:	9b468693          	addi	a3,a3,-1612 # 8000bad0 <kthreads>
    80002124:	00f687b3          	add	a5,a3,a5
    80002128:	0287b683          	ld	a3,40(a5)
    8000212c:	0104b783          	ld	a5,16(s1)
    80002130:	faf698e3          	bne	a3,a5,800020e0 <_Z23kern_thread_end_runningv+0x28>
    80002134:	00171793          	slli	a5,a4,0x1
    80002138:	00e787b3          	add	a5,a5,a4
    8000213c:	00579793          	slli	a5,a5,0x5
    80002140:	0000a697          	auipc	a3,0xa
    80002144:	99068693          	addi	a3,a3,-1648 # 8000bad0 <kthreads>
    80002148:	00f687b3          	add	a5,a3,a5
    8000214c:	00200693          	li	a3,2
    80002150:	04d7a823          	sw	a3,80(a5)
    80002154:	f8dff06f          	j	800020e0 <_Z23kern_thread_end_runningv+0x28>
    running=kern_scheduler_get();
    80002158:	00000097          	auipc	ra,0x0
    8000215c:	cd8080e7          	jalr	-808(ra) # 80001e30 <_Z18kern_scheduler_getv>
    80002160:	0000a797          	auipc	a5,0xa
    80002164:	96a7b423          	sd	a0,-1688(a5) # 8000bac8 <running>
    if(old->stack_space!=0) kern_mem_free((void*)old->stack_space);
    80002168:	0404b503          	ld	a0,64(s1)
    8000216c:	02051863          	bnez	a0,8000219c <_Z23kern_thread_end_runningv+0xe4>
    if(old!=running){
    80002170:	0000a597          	auipc	a1,0xa
    80002174:	9585b583          	ld	a1,-1704(a1) # 8000bac8 <running>
    80002178:	00958863          	beq	a1,s1,80002188 <_Z23kern_thread_end_runningv+0xd0>
        contextSwitch(old,running);
    8000217c:	00048513          	mv	a0,s1
    80002180:	fffff097          	auipc	ra,0xfffff
    80002184:	0cc080e7          	jalr	204(ra) # 8000124c <contextSwitch>
}
    80002188:	01813083          	ld	ra,24(sp)
    8000218c:	01013403          	ld	s0,16(sp)
    80002190:	00813483          	ld	s1,8(sp)
    80002194:	02010113          	addi	sp,sp,32
    80002198:	00008067          	ret
    if(old->stack_space!=0) kern_mem_free((void*)old->stack_space);
    8000219c:	fffff097          	auipc	ra,0xfffff
    800021a0:	508080e7          	jalr	1288(ra) # 800016a4 <_Z13kern_mem_freePv>
    800021a4:	fcdff06f          	j	80002170 <_Z23kern_thread_end_runningv+0xb8>

00000000800021a8 <_Z18kern_thread_createPP8thread_sPFvPvES2_S2_>:

int kern_thread_create(thread_t* handle, void(*start_routine)(void*), void* arg, void* stack_space)
{
    800021a8:	ff010113          	addi	sp,sp,-16
    800021ac:	00813423          	sd	s0,8(sp)
    800021b0:	01010413          	addi	s0,sp,16
    *handle=0;
    800021b4:	00053023          	sd	zero,0(a0)
    thread_t t=&kthreads[0]; //dodela da bismo sklonili upozorenje
    for(int i=0;i<MAX_THREADS;i++){
    800021b8:	00000713          	li	a4,0
    800021bc:	03f00793          	li	a5,63
    800021c0:	0ae7cc63          	blt	a5,a4,80002278 <_Z18kern_thread_createPP8thread_sPFvPvES2_S2_+0xd0>
        if(kthreads[i].status==UNUSED){
    800021c4:	00171793          	slli	a5,a4,0x1
    800021c8:	00e787b3          	add	a5,a5,a4
    800021cc:	00579793          	slli	a5,a5,0x5
    800021d0:	0000a817          	auipc	a6,0xa
    800021d4:	90080813          	addi	a6,a6,-1792 # 8000bad0 <kthreads>
    800021d8:	00f807b3          	add	a5,a6,a5
    800021dc:	0507a783          	lw	a5,80(a5)
    800021e0:	00078663          	beqz	a5,800021ec <_Z18kern_thread_createPP8thread_sPFvPvES2_S2_+0x44>
    for(int i=0;i<MAX_THREADS;i++){
    800021e4:	0017071b          	addiw	a4,a4,1
    800021e8:	fd5ff06f          	j	800021bc <_Z18kern_thread_createPP8thread_sPFvPvES2_S2_+0x14>
            *handle=&kthreads[i];
    800021ec:	00171793          	slli	a5,a4,0x1
    800021f0:	00e787b3          	add	a5,a5,a4
    800021f4:	00579793          	slli	a5,a5,0x5
    800021f8:	010787b3          	add	a5,a5,a6
    800021fc:	00f53023          	sd	a5,0(a0)
            t=&kthreads[i];
            break;
        }
    }
    if(*handle==0) return -1;
    80002200:	00053703          	ld	a4,0(a0)
    80002204:	08070063          	beqz	a4,80002284 <_Z18kern_thread_createPP8thread_sPFvPvES2_S2_+0xdc>

    t->id=++id;
    80002208:	0000a517          	auipc	a0,0xa
    8000220c:	8b850513          	addi	a0,a0,-1864 # 8000bac0 <_ZL2id>
    80002210:	00052703          	lw	a4,0(a0)
    80002214:	0017071b          	addiw	a4,a4,1
    80002218:	0007081b          	sext.w	a6,a4
    8000221c:	00e52023          	sw	a4,0(a0)
    80002220:	0107b823          	sd	a6,16(a5)
    t->status=READY;
    80002224:	00200713          	li	a4,2
    80002228:	04e7a823          	sw	a4,80(a5)
    t->arg=arg;
    8000222c:	02c7b023          	sd	a2,32(a5)
    t->joined_tid=-1;
    80002230:	fff00713          	li	a4,-1
    80002234:	02e7b423          	sd	a4,40(a5)
    t->timeslice=DEFAULT_TIME_SLICE;
    80002238:	00200713          	li	a4,2
    8000223c:	02e7b823          	sd	a4,48(a5)
    t->body=start_routine;
    80002240:	00b7bc23          	sd	a1,24(a5)
    t->stack_space = ((uint64)stack_space);
    80002244:	04d7b023          	sd	a3,64(a5)
    t->sp = t->stack_space+(DEFAULT_STACK_SIZE);
    80002248:	00001737          	lui	a4,0x1
    8000224c:	00e686b3          	add	a3,a3,a4
    80002250:	00d7b423          	sd	a3,8(a5)
    t->ra=(uint64) &kern_thread_wrapper;
    80002254:	00000717          	auipc	a4,0x0
    80002258:	d0470713          	addi	a4,a4,-764 # 80001f58 <_Z19kern_thread_wrapperv>
    8000225c:	00e7b023          	sd	a4,0(a5)
    t->sem_next=0;
    80002260:	0407bc23          	sd	zero,88(a5)
    t->mailbox=0;
    80002264:	0407b423          	sd	zero,72(a5)

    return 0;
    80002268:	00000513          	li	a0,0
}
    8000226c:	00813403          	ld	s0,8(sp)
    80002270:	01010113          	addi	sp,sp,16
    80002274:	00008067          	ret
    thread_t t=&kthreads[0]; //dodela da bismo sklonili upozorenje
    80002278:	0000a797          	auipc	a5,0xa
    8000227c:	85878793          	addi	a5,a5,-1960 # 8000bad0 <kthreads>
    80002280:	f81ff06f          	j	80002200 <_Z18kern_thread_createPP8thread_sPFvPvES2_S2_+0x58>
    if(*handle==0) return -1;
    80002284:	fff00513          	li	a0,-1
    80002288:	fe5ff06f          	j	8000226c <_Z18kern_thread_createPP8thread_sPFvPvES2_S2_+0xc4>

000000008000228c <_Z16kern_thread_joinP8thread_s>:

void kern_thread_join(thread_t handle)
{
    if(handle->status==UNUSED) return;
    8000228c:	05052783          	lw	a5,80(a0)
    80002290:	00079463          	bnez	a5,80002298 <_Z16kern_thread_joinP8thread_s+0xc>
    80002294:	00008067          	ret
{
    80002298:	ff010113          	addi	sp,sp,-16
    8000229c:	00113423          	sd	ra,8(sp)
    800022a0:	00813023          	sd	s0,0(sp)
    800022a4:	01010413          	addi	s0,sp,16
    running->joined_tid=handle->id;
    800022a8:	0000a797          	auipc	a5,0xa
    800022ac:	8207b783          	ld	a5,-2016(a5) # 8000bac8 <running>
    800022b0:	01053703          	ld	a4,16(a0)
    800022b4:	02e7b423          	sd	a4,40(a5)
    running->status=JOINED;
    800022b8:	00400713          	li	a4,4
    800022bc:	04e7a823          	sw	a4,80(a5)
    kern_thread_dispatch();
    800022c0:	00000097          	auipc	ra,0x0
    800022c4:	d7c080e7          	jalr	-644(ra) # 8000203c <_Z20kern_thread_dispatchv>
}
    800022c8:	00813083          	ld	ra,8(sp)
    800022cc:	00013403          	ld	s0,0(sp)
    800022d0:	01010113          	addi	sp,sp,16
    800022d4:	00008067          	ret

00000000800022d8 <_Z18kern_thread_wakeupm>:

void kern_thread_wakeup(uint64 system_time)
{
    800022d8:	ff010113          	addi	sp,sp,-16
    800022dc:	00813423          	sd	s0,8(sp)
    800022e0:	01010413          	addi	s0,sp,16
    for(int i=0;i<MAX_THREADS;i++){
    800022e4:	00000793          	li	a5,0
    800022e8:	0080006f          	j	800022f0 <_Z18kern_thread_wakeupm+0x18>
    800022ec:	0017879b          	addiw	a5,a5,1
    800022f0:	03f00713          	li	a4,63
    800022f4:	06f74263          	blt	a4,a5,80002358 <_Z18kern_thread_wakeupm+0x80>
        if(kthreads[i].status==SLEEPING && kthreads[i].endTime<system_time){
    800022f8:	00179713          	slli	a4,a5,0x1
    800022fc:	00f70733          	add	a4,a4,a5
    80002300:	00571713          	slli	a4,a4,0x5
    80002304:	00009697          	auipc	a3,0x9
    80002308:	7cc68693          	addi	a3,a3,1996 # 8000bad0 <kthreads>
    8000230c:	00e68733          	add	a4,a3,a4
    80002310:	05072683          	lw	a3,80(a4)
    80002314:	00500713          	li	a4,5
    80002318:	fce69ae3          	bne	a3,a4,800022ec <_Z18kern_thread_wakeupm+0x14>
    8000231c:	00179713          	slli	a4,a5,0x1
    80002320:	00f70733          	add	a4,a4,a5
    80002324:	00571713          	slli	a4,a4,0x5
    80002328:	00009697          	auipc	a3,0x9
    8000232c:	7a868693          	addi	a3,a3,1960 # 8000bad0 <kthreads>
    80002330:	00e68733          	add	a4,a3,a4
    80002334:	03873703          	ld	a4,56(a4)
    80002338:	faa77ae3          	bgeu	a4,a0,800022ec <_Z18kern_thread_wakeupm+0x14>
            kthreads[i].status=READY;
    8000233c:	00179713          	slli	a4,a5,0x1
    80002340:	00f70733          	add	a4,a4,a5
    80002344:	00571713          	slli	a4,a4,0x5
    80002348:	00e68733          	add	a4,a3,a4
    8000234c:	00200693          	li	a3,2
    80002350:	04d72823          	sw	a3,80(a4)
    80002354:	f99ff06f          	j	800022ec <_Z18kern_thread_wakeupm+0x14>
        }
    }
}
    80002358:	00813403          	ld	s0,8(sp)
    8000235c:	01010113          	addi	sp,sp,16
    80002360:	00008067          	ret

0000000080002364 <_Z13kern_sem_initv>:
#define MAX_SEMAPHORES 256

struct sem_s semaphores[MAX_SEMAPHORES];

void kern_sem_init()
{
    80002364:	ff010113          	addi	sp,sp,-16
    80002368:	00813423          	sd	s0,8(sp)
    8000236c:	01010413          	addi	s0,sp,16
    for(int i=0;i<MAX_SEMAPHORES;i++){
    80002370:	00000713          	li	a4,0
    80002374:	0ff00793          	li	a5,255
    80002378:	02e7c663          	blt	a5,a4,800023a4 <_Z13kern_sem_initv+0x40>
        semaphores[i].waiting_thread=0;
    8000237c:	00471693          	slli	a3,a4,0x4
    80002380:	0000b797          	auipc	a5,0xb
    80002384:	f5078793          	addi	a5,a5,-176 # 8000d2d0 <semaphores>
    80002388:	00d787b3          	add	a5,a5,a3
    8000238c:	0007b423          	sd	zero,8(a5)
        semaphores[i].val=0;
    80002390:	0007a023          	sw	zero,0(a5)
        semaphores[i].status=SEM_UNUSED;
    80002394:	00100693          	li	a3,1
    80002398:	00d7a223          	sw	a3,4(a5)
    for(int i=0;i<MAX_SEMAPHORES;i++){
    8000239c:	0017071b          	addiw	a4,a4,1
    800023a0:	fd5ff06f          	j	80002374 <_Z13kern_sem_initv+0x10>
    }
}
    800023a4:	00813403          	ld	s0,8(sp)
    800023a8:	01010113          	addi	sp,sp,16
    800023ac:	00008067          	ret

00000000800023b0 <_Z13kern_sem_openPP5sem_sj>:

int kern_sem_open (sem_t* handle, unsigned init)
{
    800023b0:	ff010113          	addi	sp,sp,-16
    800023b4:	00813423          	sd	s0,8(sp)
    800023b8:	01010413          	addi	s0,sp,16
    int res=-1;
    for(int i=0;i<MAX_SEMAPHORES;i++){
    800023bc:	00000793          	li	a5,0
    800023c0:	0080006f          	j	800023c8 <_Z13kern_sem_openPP5sem_sj+0x18>
    800023c4:	0017879b          	addiw	a5,a5,1
    800023c8:	0ff00713          	li	a4,255
    800023cc:	04f74663          	blt	a4,a5,80002418 <_Z13kern_sem_openPP5sem_sj+0x68>
        if(semaphores[i].status==SEM_UNUSED){
    800023d0:	00479693          	slli	a3,a5,0x4
    800023d4:	0000b717          	auipc	a4,0xb
    800023d8:	efc70713          	addi	a4,a4,-260 # 8000d2d0 <semaphores>
    800023dc:	00d70733          	add	a4,a4,a3
    800023e0:	00472683          	lw	a3,4(a4)
    800023e4:	00100713          	li	a4,1
    800023e8:	fce69ee3          	bne	a3,a4,800023c4 <_Z13kern_sem_openPP5sem_sj+0x14>
            semaphores[i].status=SEM_USED;
    800023ec:	00479793          	slli	a5,a5,0x4
    800023f0:	0000b717          	auipc	a4,0xb
    800023f4:	ee070713          	addi	a4,a4,-288 # 8000d2d0 <semaphores>
    800023f8:	00f707b3          	add	a5,a4,a5
    800023fc:	0007a223          	sw	zero,4(a5)
            semaphores[i].val=init;
    80002400:	00b7a023          	sw	a1,0(a5)
            *handle=&semaphores[i];
    80002404:	00f53023          	sd	a5,0(a0)
            res++;
    80002408:	00000513          	li	a0,0
            break;
        }
    }
    return res;
}
    8000240c:	00813403          	ld	s0,8(sp)
    80002410:	01010113          	addi	sp,sp,16
    80002414:	00008067          	ret
    int res=-1;
    80002418:	fff00513          	li	a0,-1
    8000241c:	ff1ff06f          	j	8000240c <_Z13kern_sem_openPP5sem_sj+0x5c>

0000000080002420 <_Z14kern_sem_closeP5sem_s>:

int kern_sem_close (sem_t handle)
{
    80002420:	ff010113          	addi	sp,sp,-16
    80002424:	00813423          	sd	s0,8(sp)
    80002428:	01010413          	addi	s0,sp,16
    handle->status=SEM_UNUSED;
    8000242c:	00100793          	li	a5,1
    80002430:	00f52223          	sw	a5,4(a0)
    handle->val=0;
    80002434:	00052023          	sw	zero,0(a0)
    if(handle->waiting_thread!=0){
    80002438:	00853783          	ld	a5,8(a0)
    8000243c:	02079263          	bnez	a5,80002460 <_Z14kern_sem_closeP5sem_s+0x40>
    80002440:	0280006f          	j	80002468 <_Z14kern_sem_closeP5sem_s+0x48>
        thread_t curr = handle->waiting_thread;
        while(curr){
            curr->mailbox=-2;
    80002444:	ffe00713          	li	a4,-2
    80002448:	04e7b423          	sd	a4,72(a5)
            curr->status=READY;
    8000244c:	00200713          	li	a4,2
    80002450:	04e7a823          	sw	a4,80(a5)
            thread_t prev=curr;
            curr=curr->sem_next;
    80002454:	0587b703          	ld	a4,88(a5)
            prev->sem_next=0;
    80002458:	0407bc23          	sd	zero,88(a5)
            curr=curr->sem_next;
    8000245c:	00070793          	mv	a5,a4
        while(curr){
    80002460:	fe0792e3          	bnez	a5,80002444 <_Z14kern_sem_closeP5sem_s+0x24>
        }
        handle->waiting_thread=0;
    80002464:	00053423          	sd	zero,8(a0)
    }
    return 0;
}
    80002468:	00000513          	li	a0,0
    8000246c:	00813403          	ld	s0,8(sp)
    80002470:	01010113          	addi	sp,sp,16
    80002474:	00008067          	ret

0000000080002478 <_Z15kern_sem_signalP5sem_s>:

void kern_sem_signal(sem_t id)
{
    80002478:	ff010113          	addi	sp,sp,-16
    8000247c:	00813423          	sd	s0,8(sp)
    80002480:	01010413          	addi	s0,sp,16
    if(id->val>0 || id->waiting_thread==0) id->val++;
    80002484:	00052783          	lw	a5,0(a0)
    80002488:	00f05c63          	blez	a5,800024a0 <_Z15kern_sem_signalP5sem_s+0x28>
    8000248c:	0017879b          	addiw	a5,a5,1
    80002490:	00f52023          	sw	a5,0(a0)
        thread_t woken = id->waiting_thread;
        id->waiting_thread=woken->sem_next;
        woken->mailbox=0;
        woken->status=READY;
    }
}
    80002494:	00813403          	ld	s0,8(sp)
    80002498:	01010113          	addi	sp,sp,16
    8000249c:	00008067          	ret
    if(id->val>0 || id->waiting_thread==0) id->val++;
    800024a0:	00853703          	ld	a4,8(a0)
    800024a4:	fe0704e3          	beqz	a4,8000248c <_Z15kern_sem_signalP5sem_s+0x14>
        id->waiting_thread=woken->sem_next;
    800024a8:	05873783          	ld	a5,88(a4)
    800024ac:	00f53423          	sd	a5,8(a0)
        woken->mailbox=0;
    800024b0:	04073423          	sd	zero,72(a4)
        woken->status=READY;
    800024b4:	00200793          	li	a5,2
    800024b8:	04f72823          	sw	a5,80(a4)
}
    800024bc:	fd9ff06f          	j	80002494 <_Z15kern_sem_signalP5sem_s+0x1c>

00000000800024c0 <_Z13kern_sem_waitP5sem_s>:

int kern_sem_wait(sem_t id)
{
    if(id->val<=0){
    800024c0:	00052783          	lw	a5,0(a0)
    800024c4:	00f05a63          	blez	a5,800024d8 <_Z13kern_sem_waitP5sem_s+0x18>
        w_sstatus(sstatus);
        w_sepc(v_sepc);
        return running->mailbox;
    }
    else {
        id->val--;
    800024c8:	fff7879b          	addiw	a5,a5,-1
    800024cc:	00f52023          	sw	a5,0(a0)
        return 1;
    800024d0:	00100513          	li	a0,1
    }
}
    800024d4:	00008067          	ret
{
    800024d8:	fd010113          	addi	sp,sp,-48
    800024dc:	02113423          	sd	ra,40(sp)
    800024e0:	02813023          	sd	s0,32(sp)
    800024e4:	03010413          	addi	s0,sp,48
        running->status=SUSPENDED;
    800024e8:	00009797          	auipc	a5,0x9
    800024ec:	d387b783          	ld	a5,-712(a5) # 8000b220 <_GLOBAL_OFFSET_TABLE_+0x20>
    800024f0:	0007b683          	ld	a3,0(a5)
    800024f4:	00300793          	li	a5,3
    800024f8:	04f6a823          	sw	a5,80(a3)
        if(id->waiting_thread==0) id->waiting_thread=running;
    800024fc:	00853783          	ld	a5,8(a0)
    80002500:	06078863          	beqz	a5,80002570 <_Z13kern_sem_waitP5sem_s+0xb0>
            while (curr->sem_next!=0) curr=curr->sem_next;
    80002504:	00078713          	mv	a4,a5
    80002508:	0587b783          	ld	a5,88(a5)
    8000250c:	fe079ce3          	bnez	a5,80002504 <_Z13kern_sem_waitP5sem_s+0x44>
            curr->sem_next=running;
    80002510:	04d73c23          	sd	a3,88(a4)
        running->sem_next=0;
    80002514:	0406bc23          	sd	zero,88(a3)
}

inline uint64 r_sstatus()
{
    uint64 volatile sstatus;
    __asm__ volatile ("csrr %[sstatus], sstatus" : [sstatus] "=r"(sstatus));
    80002518:	100027f3          	csrr	a5,sstatus
    8000251c:	fef43423          	sd	a5,-24(s0)
    return sstatus;
    80002520:	fe843783          	ld	a5,-24(s0)
        uint64 volatile sstatus = r_sstatus();
    80002524:	fcf43823          	sd	a5,-48(s0)
    __asm__ volatile ("csrr %[sepc], sepc" : [sepc] "=r"(sepc));
    80002528:	141027f3          	csrr	a5,sepc
    8000252c:	fef43023          	sd	a5,-32(s0)
    return sepc;
    80002530:	fe043783          	ld	a5,-32(s0)
        uint64 volatile v_sepc = r_sepc();
    80002534:	fcf43c23          	sd	a5,-40(s0)
        kern_thread_dispatch();
    80002538:	00000097          	auipc	ra,0x0
    8000253c:	b04080e7          	jalr	-1276(ra) # 8000203c <_Z20kern_thread_dispatchv>
        w_sstatus(sstatus);
    80002540:	fd043783          	ld	a5,-48(s0)
}

inline void w_sstatus(uint64 sstatus)
{
    __asm__ volatile ("csrw sstatus, %[sstatus]" : : [sstatus] "r"(sstatus));
    80002544:	10079073          	csrw	sstatus,a5
        w_sepc(v_sepc);
    80002548:	fd843783          	ld	a5,-40(s0)
    __asm__ volatile ("csrw sepc, %[sepc]" : : [sepc] "r"(sepc));
    8000254c:	14179073          	csrw	sepc,a5
        return running->mailbox;
    80002550:	00009797          	auipc	a5,0x9
    80002554:	cd07b783          	ld	a5,-816(a5) # 8000b220 <_GLOBAL_OFFSET_TABLE_+0x20>
    80002558:	0007b783          	ld	a5,0(a5)
    8000255c:	0487a503          	lw	a0,72(a5)
}
    80002560:	02813083          	ld	ra,40(sp)
    80002564:	02013403          	ld	s0,32(sp)
    80002568:	03010113          	addi	sp,sp,48
    8000256c:	00008067          	ret
        if(id->waiting_thread==0) id->waiting_thread=running;
    80002570:	00d53423          	sd	a3,8(a0)
    80002574:	fa1ff06f          	j	80002514 <_Z13kern_sem_waitP5sem_s+0x54>

0000000080002578 <_Z19kern_interrupt_initv>:
#ifdef __cplusplus
}
#endif

void kern_interrupt_init()
{
    80002578:	ff010113          	addi	sp,sp,-16
    8000257c:	00813423          	sd	s0,8(sp)
    80002580:	01010413          	addi	s0,sp,16
    SYSTEM_TIME=0;
    80002584:	0000c797          	auipc	a5,0xc
    80002588:	d407b623          	sd	zero,-692(a5) # 8000e2d0 <SYSTEM_TIME>
    w_stvec((uint64) &supervisorTrap);
    8000258c:	00009797          	auipc	a5,0x9
    80002590:	c9c7b783          	ld	a5,-868(a5) # 8000b228 <_GLOBAL_OFFSET_TABLE_+0x28>
    __asm__ volatile ("csrw stvec, %[stvec]" : : [stvec] "r"(stvec));
    80002594:	10579073          	csrw	stvec,a5
    __asm__ volatile ("csrs sstatus, %[mask]" : : [mask] "r"(mask));
    80002598:	00200793          	li	a5,2
    8000259c:	1007a073          	csrs	sstatus,a5
    ms_sstatus(SSTATUS_SIE);
}
    800025a0:	00813403          	ld	s0,8(sp)
    800025a4:	01010113          	addi	sp,sp,16
    800025a8:	00008067          	ret

00000000800025ac <_Z12kern_syscall13SyscallNumberz>:


void kern_syscall(enum SyscallNumber num, ...)
{
    800025ac:	fb010113          	addi	sp,sp,-80
    800025b0:	00813423          	sd	s0,8(sp)
    800025b4:	01010413          	addi	s0,sp,16
    800025b8:	00b43423          	sd	a1,8(s0)
    800025bc:	00c43823          	sd	a2,16(s0)
    800025c0:	00d43c23          	sd	a3,24(s0)
    800025c4:	02e43023          	sd	a4,32(s0)
    800025c8:	02f43423          	sd	a5,40(s0)
    800025cc:	03043823          	sd	a6,48(s0)
    800025d0:	03143c23          	sd	a7,56(s0)
    __asm__ volatile ("ecall");
    800025d4:	00000073          	ecall
    return;
}
    800025d8:	00813403          	ld	s0,8(sp)
    800025dc:	05010113          	addi	sp,sp,80
    800025e0:	00008067          	ret

00000000800025e4 <handleEcall>:
#ifdef __cplusplus
extern "C" {
#endif


void handleEcall(uint64 a0, uint64 a1, uint64 a2, uint64 a3, uint64 a4) {
    800025e4:	f3010113          	addi	sp,sp,-208
    800025e8:	0c113423          	sd	ra,200(sp)
    800025ec:	0c813023          	sd	s0,192(sp)
    800025f0:	0a913c23          	sd	s1,184(sp)
    800025f4:	0b213823          	sd	s2,176(sp)
    800025f8:	0d010413          	addi	s0,sp,208
    800025fc:	00060913          	mv	s2,a2
    80002600:	00068613          	mv	a2,a3
    __asm__ volatile ("csrr %[scause], scause" : [scause] "=r"(scause));
    80002604:	142027f3          	csrr	a5,scause
    80002608:	f8f43023          	sd	a5,-128(s0)
    return scause;
    8000260c:	f8043783          	ld	a5,-128(s0)
    __asm__ volatile ("mv %[a2], a2" : [a2] "=r"(a2));
    __asm__ volatile ("mv %[a3], a3" : [a3] "=r"(a3));
    __asm__ volatile ("mv %[a4], a4" : [a4] "=r"(a4));
     */
    uint64 scause = r_scause();
    if (scause == INTR_USER_ECALL || scause == INTR_KERNEL_ECALL) {
    80002610:	ff878793          	addi	a5,a5,-8
    80002614:	00100693          	li	a3,1
    80002618:	00f6fe63          	bgeu	a3,a5,80002634 <handleEcall+0x50>
            }


        }
    }
}
    8000261c:	0c813083          	ld	ra,200(sp)
    80002620:	0c013403          	ld	s0,192(sp)
    80002624:	0b813483          	ld	s1,184(sp)
    80002628:	0b013903          	ld	s2,176(sp)
    8000262c:	0d010113          	addi	sp,sp,208
    80002630:	00008067          	ret
    80002634:	00058493          	mv	s1,a1
    __asm__ volatile ("csrr %[sepc], sepc" : [sepc] "=r"(sepc));
    80002638:	141027f3          	csrr	a5,sepc
    8000263c:	f8f43423          	sd	a5,-120(s0)
    return sepc;
    80002640:	f8843783          	ld	a5,-120(s0)
        uint64 sepc = r_sepc() + 4;
    80002644:	00478793          	addi	a5,a5,4
        uint64 time = SYSTEM_TIME;
    80002648:	0000c597          	auipc	a1,0xc
    8000264c:	c885b583          	ld	a1,-888(a1) # 8000e2d0 <SYSTEM_TIME>
    __asm__ volatile ("csrw sepc, %[sepc]" : : [sepc] "r"(sepc));
    80002650:	14179073          	csrw	sepc,a5
        switch (syscall_num) {
    80002654:	04200793          	li	a5,66
    80002658:	fca7e2e3          	bltu	a5,a0,8000261c <handleEcall+0x38>
    8000265c:	00251513          	slli	a0,a0,0x2
    80002660:	00007697          	auipc	a3,0x7
    80002664:	9c868693          	addi	a3,a3,-1592 # 80009028 <CONSOLE_STATUS+0x18>
    80002668:	00d50533          	add	a0,a0,a3
    8000266c:	00052783          	lw	a5,0(a0)
    80002670:	00d787b3          	add	a5,a5,a3
    80002674:	00078067          	jr	a5
                retval = (uint64) kern_mem_alloc(size);
    80002678:	0004851b          	sext.w	a0,s1
    8000267c:	fffff097          	auipc	ra,0xfffff
    80002680:	f64080e7          	jalr	-156(ra) # 800015e0 <_Z14kern_mem_alloci>
    __asm__ volatile ("mv a0, %[value]" :: [value] "r"(value));
    80002684:	00050513          	mv	a0,a0
}
    80002688:	f95ff06f          	j	8000261c <handleEcall+0x38>
                retval = (uint64) kern_mem_free((void *) addr);
    8000268c:	00048513          	mv	a0,s1
    80002690:	fffff097          	auipc	ra,0xfffff
    80002694:	014080e7          	jalr	20(ra) # 800016a4 <_Z13kern_mem_freePv>
    __asm__ volatile ("mv a0, %[value]" :: [value] "r"(value));
    80002698:	00050513          	mv	a0,a0
}
    8000269c:	f81ff06f          	j	8000261c <handleEcall+0x38>
                retval = (uint64) kern_thread_create((thread_t *) handle,
    800026a0:	00070693          	mv	a3,a4
    800026a4:	00090593          	mv	a1,s2
    800026a8:	00048513          	mv	a0,s1
    800026ac:	00000097          	auipc	ra,0x0
    800026b0:	afc080e7          	jalr	-1284(ra) # 800021a8 <_Z18kern_thread_createPP8thread_sPFvPvES2_S2_>
                (*(thread_t *) handle)->endTime = SYSTEM_TIME + DEFAULT_TIME_SLICE;
    800026b4:	0004b703          	ld	a4,0(s1)
    800026b8:	0000c797          	auipc	a5,0xc
    800026bc:	c187b783          	ld	a5,-1000(a5) # 8000e2d0 <SYSTEM_TIME>
    800026c0:	00278793          	addi	a5,a5,2
    800026c4:	02f73c23          	sd	a5,56(a4)
    __asm__ volatile ("mv a0, %[value]" :: [value] "r"(value));
    800026c8:	00050513          	mv	a0,a0
}
    800026cc:	f51ff06f          	j	8000261c <handleEcall+0x38>
    __asm__ volatile ("csrr %[sstatus], sstatus" : [sstatus] "=r"(sstatus));
    800026d0:	100027f3          	csrr	a5,sstatus
    800026d4:	f8f43c23          	sd	a5,-104(s0)
    return sstatus;
    800026d8:	f9843783          	ld	a5,-104(s0)
                uint64 volatile sstatus = r_sstatus();
    800026dc:	f2f43823          	sd	a5,-208(s0)
    __asm__ volatile ("csrr %[sepc], sepc" : [sepc] "=r"(sepc));
    800026e0:	141027f3          	csrr	a5,sepc
    800026e4:	f8f43823          	sd	a5,-112(s0)
    return sepc;
    800026e8:	f9043783          	ld	a5,-112(s0)
                uint64 volatile v_sepc = r_sepc();
    800026ec:	f2f43c23          	sd	a5,-200(s0)
                kern_thread_dispatch();
    800026f0:	00000097          	auipc	ra,0x0
    800026f4:	94c080e7          	jalr	-1716(ra) # 8000203c <_Z20kern_thread_dispatchv>
                w_sstatus(sstatus);
    800026f8:	f3043783          	ld	a5,-208(s0)
    __asm__ volatile ("csrw sstatus, %[sstatus]" : : [sstatus] "r"(sstatus));
    800026fc:	10079073          	csrw	sstatus,a5
                w_sepc(v_sepc);
    80002700:	f3843783          	ld	a5,-200(s0)
    __asm__ volatile ("csrw sepc, %[sepc]" : : [sepc] "r"(sepc));
    80002704:	14179073          	csrw	sepc,a5
                running->endTime = SYSTEM_TIME + running->timeslice;
    80002708:	00009797          	auipc	a5,0x9
    8000270c:	b187b783          	ld	a5,-1256(a5) # 8000b220 <_GLOBAL_OFFSET_TABLE_+0x20>
    80002710:	0007b703          	ld	a4,0(a5)
    80002714:	03073783          	ld	a5,48(a4)
    80002718:	0000c697          	auipc	a3,0xc
    8000271c:	bb86b683          	ld	a3,-1096(a3) # 8000e2d0 <SYSTEM_TIME>
    80002720:	00d787b3          	add	a5,a5,a3
    80002724:	02f73c23          	sd	a5,56(a4)
                break;
    80002728:	ef5ff06f          	j	8000261c <handleEcall+0x38>
    __asm__ volatile ("csrr %[sstatus], sstatus" : [sstatus] "=r"(sstatus));
    8000272c:	100027f3          	csrr	a5,sstatus
    80002730:	faf43423          	sd	a5,-88(s0)
    return sstatus;
    80002734:	fa843783          	ld	a5,-88(s0)
                uint64 volatile sstatus = r_sstatus();
    80002738:	f4f43023          	sd	a5,-192(s0)
    __asm__ volatile ("csrr %[sepc], sepc" : [sepc] "=r"(sepc));
    8000273c:	141027f3          	csrr	a5,sepc
    80002740:	faf43023          	sd	a5,-96(s0)
    return sepc;
    80002744:	fa043783          	ld	a5,-96(s0)
                uint64 volatile v_sepc = r_sepc();
    80002748:	f4f43423          	sd	a5,-184(s0)
                kern_thread_join(handle);
    8000274c:	00048513          	mv	a0,s1
    80002750:	00000097          	auipc	ra,0x0
    80002754:	b3c080e7          	jalr	-1220(ra) # 8000228c <_Z16kern_thread_joinP8thread_s>
                w_sstatus(sstatus);
    80002758:	f4043783          	ld	a5,-192(s0)
    __asm__ volatile ("csrw sstatus, %[sstatus]" : : [sstatus] "r"(sstatus));
    8000275c:	10079073          	csrw	sstatus,a5
                w_sepc(v_sepc);
    80002760:	f4843783          	ld	a5,-184(s0)
    __asm__ volatile ("csrw sepc, %[sepc]" : : [sepc] "r"(sepc));
    80002764:	14179073          	csrw	sepc,a5
                running->endTime = SYSTEM_TIME + running->timeslice;
    80002768:	00009797          	auipc	a5,0x9
    8000276c:	ab87b783          	ld	a5,-1352(a5) # 8000b220 <_GLOBAL_OFFSET_TABLE_+0x20>
    80002770:	0007b703          	ld	a4,0(a5)
    80002774:	03073783          	ld	a5,48(a4)
    80002778:	0000c697          	auipc	a3,0xc
    8000277c:	b586b683          	ld	a3,-1192(a3) # 8000e2d0 <SYSTEM_TIME>
    80002780:	00d787b3          	add	a5,a5,a3
    80002784:	02f73c23          	sd	a5,56(a4)
                break;
    80002788:	e95ff06f          	j	8000261c <handleEcall+0x38>
                kern_thread_end_running();
    8000278c:	00000097          	auipc	ra,0x0
    80002790:	92c080e7          	jalr	-1748(ra) # 800020b8 <_Z23kern_thread_end_runningv>
                retval = kern_sem_open(handle, init);
    80002794:	0009059b          	sext.w	a1,s2
    80002798:	00048513          	mv	a0,s1
    8000279c:	00000097          	auipc	ra,0x0
    800027a0:	c14080e7          	jalr	-1004(ra) # 800023b0 <_Z13kern_sem_openPP5sem_sj>
    __asm__ volatile ("mv a0, %[value]" :: [value] "r"(value));
    800027a4:	00050513          	mv	a0,a0
}
    800027a8:	e75ff06f          	j	8000261c <handleEcall+0x38>
                retval = kern_sem_close(handle);
    800027ac:	00048513          	mv	a0,s1
    800027b0:	00000097          	auipc	ra,0x0
    800027b4:	c70080e7          	jalr	-912(ra) # 80002420 <_Z14kern_sem_closeP5sem_s>
    __asm__ volatile ("mv a0, %[value]" :: [value] "r"(value));
    800027b8:	00050513          	mv	a0,a0
}
    800027bc:	e61ff06f          	j	8000261c <handleEcall+0x38>
                kern_sem_signal(handle);
    800027c0:	00048513          	mv	a0,s1
    800027c4:	00000097          	auipc	ra,0x0
    800027c8:	cb4080e7          	jalr	-844(ra) # 80002478 <_Z15kern_sem_signalP5sem_s>
    __asm__ volatile ("mv a0, %[value]" :: [value] "r"(value));
    800027cc:	00000793          	li	a5,0
    800027d0:	00078513          	mv	a0,a5
}
    800027d4:	e49ff06f          	j	8000261c <handleEcall+0x38>
                retval = kern_sem_wait(handle);
    800027d8:	00048513          	mv	a0,s1
    800027dc:	00000097          	auipc	ra,0x0
    800027e0:	ce4080e7          	jalr	-796(ra) # 800024c0 <_Z13kern_sem_waitP5sem_s>
                if (retval == 1) { //nije promenjen kontekst
    800027e4:	00100793          	li	a5,1
    800027e8:	02f50663          	beq	a0,a5,80002814 <handleEcall+0x230>
                    running->endTime = SYSTEM_TIME + running->timeslice;
    800027ec:	00009797          	auipc	a5,0x9
    800027f0:	a347b783          	ld	a5,-1484(a5) # 8000b220 <_GLOBAL_OFFSET_TABLE_+0x20>
    800027f4:	0007b703          	ld	a4,0(a5)
    800027f8:	03073783          	ld	a5,48(a4)
    800027fc:	0000c697          	auipc	a3,0xc
    80002800:	ad46b683          	ld	a3,-1324(a3) # 8000e2d0 <SYSTEM_TIME>
    80002804:	00d787b3          	add	a5,a5,a3
    80002808:	02f73c23          	sd	a5,56(a4)
    __asm__ volatile ("mv a0, %[value]" :: [value] "r"(value));
    8000280c:	00050513          	mv	a0,a0
}
    80002810:	e0dff06f          	j	8000261c <handleEcall+0x38>
                    retval = 0;
    80002814:	00000513          	li	a0,0
    80002818:	ff5ff06f          	j	8000280c <handleEcall+0x228>
                running->status = SLEEPING;
    8000281c:	00009917          	auipc	s2,0x9
    80002820:	a0493903          	ld	s2,-1532(s2) # 8000b220 <_GLOBAL_OFFSET_TABLE_+0x20>
    80002824:	00093783          	ld	a5,0(s2)
    80002828:	00500713          	li	a4,5
    8000282c:	04e7a823          	sw	a4,80(a5)
                running->endTime = SYSTEM_TIME + period;
    80002830:	009585b3          	add	a1,a1,s1
    80002834:	02b7bc23          	sd	a1,56(a5)
    __asm__ volatile ("csrr %[sstatus], sstatus" : [sstatus] "=r"(sstatus));
    80002838:	100027f3          	csrr	a5,sstatus
    8000283c:	faf43c23          	sd	a5,-72(s0)
    return sstatus;
    80002840:	fb843783          	ld	a5,-72(s0)
                uint64 volatile sstatus = r_sstatus();
    80002844:	f4f43823          	sd	a5,-176(s0)
    __asm__ volatile ("csrr %[sepc], sepc" : [sepc] "=r"(sepc));
    80002848:	141027f3          	csrr	a5,sepc
    8000284c:	faf43823          	sd	a5,-80(s0)
    return sepc;
    80002850:	fb043783          	ld	a5,-80(s0)
                uint64 volatile v_sepc = r_sepc();
    80002854:	f4f43c23          	sd	a5,-168(s0)
                kern_thread_dispatch();
    80002858:	fffff097          	auipc	ra,0xfffff
    8000285c:	7e4080e7          	jalr	2020(ra) # 8000203c <_Z20kern_thread_dispatchv>
                w_sstatus(sstatus);
    80002860:	f5043783          	ld	a5,-176(s0)
    __asm__ volatile ("csrw sstatus, %[sstatus]" : : [sstatus] "r"(sstatus));
    80002864:	10079073          	csrw	sstatus,a5
                w_sepc(v_sepc);
    80002868:	f5843783          	ld	a5,-168(s0)
    __asm__ volatile ("csrw sepc, %[sepc]" : : [sepc] "r"(sepc));
    8000286c:	14179073          	csrw	sepc,a5
                running->endTime=time+running->timeslice;
    80002870:	00093703          	ld	a4,0(s2)
    80002874:	03073783          	ld	a5,48(a4)
    80002878:	0000c697          	auipc	a3,0xc
    8000287c:	a586b683          	ld	a3,-1448(a3) # 8000e2d0 <SYSTEM_TIME>
    80002880:	00d787b3          	add	a5,a5,a3
    80002884:	02f73c23          	sd	a5,56(a4)
                break;
    80002888:	d95ff06f          	j	8000261c <handleEcall+0x38>
                    c = kern_console_getchar();
    8000288c:	fffff097          	auipc	ra,0xfffff
    80002890:	0a8080e7          	jalr	168(ra) # 80001934 <_Z20kern_console_getcharv>
                    if(c==-1){
    80002894:	fff00793          	li	a5,-1
    80002898:	06f51063          	bne	a0,a5,800028f8 <handleEcall+0x314>
    __asm__ volatile ("csrr %[sstatus], sstatus" : [sstatus] "=r"(sstatus));
    8000289c:	100027f3          	csrr	a5,sstatus
    800028a0:	fcf43423          	sd	a5,-56(s0)
    return sstatus;
    800028a4:	fc843783          	ld	a5,-56(s0)
                        uint64 volatile sstatus = r_sstatus();
    800028a8:	f6f43023          	sd	a5,-160(s0)
    __asm__ volatile ("csrr %[sepc], sepc" : [sepc] "=r"(sepc));
    800028ac:	141027f3          	csrr	a5,sepc
    800028b0:	fcf43023          	sd	a5,-64(s0)
    return sepc;
    800028b4:	fc043783          	ld	a5,-64(s0)
                        uint64 volatile v_sepc = r_sepc();
    800028b8:	f6f43423          	sd	a5,-152(s0)
                        kern_thread_dispatch();
    800028bc:	fffff097          	auipc	ra,0xfffff
    800028c0:	780080e7          	jalr	1920(ra) # 8000203c <_Z20kern_thread_dispatchv>
                        w_sstatus(sstatus);
    800028c4:	f6043783          	ld	a5,-160(s0)
    __asm__ volatile ("csrw sstatus, %[sstatus]" : : [sstatus] "r"(sstatus));
    800028c8:	10079073          	csrw	sstatus,a5
                        w_sepc(v_sepc);
    800028cc:	f6843783          	ld	a5,-152(s0)
    __asm__ volatile ("csrw sepc, %[sepc]" : : [sepc] "r"(sepc));
    800028d0:	14179073          	csrw	sepc,a5
                        running->endTime = SYSTEM_TIME + running->timeslice;
    800028d4:	00009797          	auipc	a5,0x9
    800028d8:	94c7b783          	ld	a5,-1716(a5) # 8000b220 <_GLOBAL_OFFSET_TABLE_+0x20>
    800028dc:	0007b703          	ld	a4,0(a5)
    800028e0:	03073783          	ld	a5,48(a4)
    800028e4:	0000c697          	auipc	a3,0xc
    800028e8:	9ec6b683          	ld	a3,-1556(a3) # 8000e2d0 <SYSTEM_TIME>
    800028ec:	00d787b3          	add	a5,a5,a3
    800028f0:	02f73c23          	sd	a5,56(a4)
                }
    800028f4:	f99ff06f          	j	8000288c <handleEcall+0x2a8>
    __asm__ volatile ("mv a0, %[value]" :: [value] "r"(value));
    800028f8:	00050513          	mv	a0,a0
}
    800028fc:	d21ff06f          	j	8000261c <handleEcall+0x38>
                char c = a1;
    80002900:	0ff4f493          	andi	s1,s1,255
                    res=kern_console_putchar(c);
    80002904:	00048513          	mv	a0,s1
    80002908:	fffff097          	auipc	ra,0xfffff
    8000290c:	090080e7          	jalr	144(ra) # 80001998 <_Z20kern_console_putcharc>
                    if(res==-1){
    80002910:	fff00793          	li	a5,-1
    80002914:	d0f514e3          	bne	a0,a5,8000261c <handleEcall+0x38>
    __asm__ volatile ("csrr %[sstatus], sstatus" : [sstatus] "=r"(sstatus));
    80002918:	100027f3          	csrr	a5,sstatus
    8000291c:	fcf43c23          	sd	a5,-40(s0)
    return sstatus;
    80002920:	fd843783          	ld	a5,-40(s0)
                        uint64 volatile sstatus = r_sstatus();
    80002924:	f6f43823          	sd	a5,-144(s0)
    __asm__ volatile ("csrr %[sepc], sepc" : [sepc] "=r"(sepc));
    80002928:	141027f3          	csrr	a5,sepc
    8000292c:	fcf43823          	sd	a5,-48(s0)
    return sepc;
    80002930:	fd043783          	ld	a5,-48(s0)
                        uint64 volatile v_sepc = r_sepc();
    80002934:	f6f43c23          	sd	a5,-136(s0)
                        kern_thread_dispatch();
    80002938:	fffff097          	auipc	ra,0xfffff
    8000293c:	704080e7          	jalr	1796(ra) # 8000203c <_Z20kern_thread_dispatchv>
                        w_sstatus(sstatus);
    80002940:	f7043783          	ld	a5,-144(s0)
    __asm__ volatile ("csrw sstatus, %[sstatus]" : : [sstatus] "r"(sstatus));
    80002944:	10079073          	csrw	sstatus,a5
                        w_sepc(v_sepc);
    80002948:	f7843783          	ld	a5,-136(s0)
    __asm__ volatile ("csrw sepc, %[sepc]" : : [sepc] "r"(sepc));
    8000294c:	14179073          	csrw	sepc,a5
                        running->endTime = SYSTEM_TIME + running->timeslice;
    80002950:	00009797          	auipc	a5,0x9
    80002954:	8d07b783          	ld	a5,-1840(a5) # 8000b220 <_GLOBAL_OFFSET_TABLE_+0x20>
    80002958:	0007b703          	ld	a4,0(a5)
    8000295c:	03073783          	ld	a5,48(a4)
    80002960:	0000c697          	auipc	a3,0xc
    80002964:	9706b683          	ld	a3,-1680(a3) # 8000e2d0 <SYSTEM_TIME>
    80002968:	00d787b3          	add	a5,a5,a3
    8000296c:	02f73c23          	sd	a5,56(a4)
                }
    80002970:	f95ff06f          	j	80002904 <handleEcall+0x320>

0000000080002974 <handleInterrupt>:
int counter=0;
#define BUFFER_SIZE 1024
char cbuf[BUFFER_SIZE];

void handleInterrupt()
{
    80002974:	fb010113          	addi	sp,sp,-80
    80002978:	04113423          	sd	ra,72(sp)
    8000297c:	04813023          	sd	s0,64(sp)
    80002980:	02913c23          	sd	s1,56(sp)
    80002984:	05010413          	addi	s0,sp,80
    __asm__ volatile ("csrr %[scause], scause" : [scause] "=r"(scause));
    80002988:	142027f3          	csrr	a5,scause
    8000298c:	fcf43423          	sd	a5,-56(s0)
    return scause;
    80002990:	fc843703          	ld	a4,-56(s0)
    uint64 scause = r_scause();
    if (scause == INTR_TIMER)
    80002994:	fff00793          	li	a5,-1
    80002998:	03f79793          	slli	a5,a5,0x3f
    8000299c:	00178793          	addi	a5,a5,1
    800029a0:	02f70863          	beq	a4,a5,800029d0 <handleInterrupt+0x5c>
            w_sstatus(sstatus);
            w_sepc(v_sepc);
            running->endTime=SYSTEM_TIME+running->timeslice;
        }
    }
    else if (scause == INTR_CONSOLE)
    800029a4:	fff00793          	li	a5,-1
    800029a8:	03f79793          	slli	a5,a5,0x3f
    800029ac:	00978793          	addi	a5,a5,9
    800029b0:	0af70c63          	beq	a4,a5,80002a68 <handleInterrupt+0xf4>
            kern_uart_handler();
        }
        plic_complete(irq);
        // console_handler();
    }
    else if(scause == INTR_ILLEGAL_INSTRUCTION)
    800029b4:	00200793          	li	a5,2
    800029b8:	0ef70063          	beq	a4,a5,80002a98 <handleInterrupt+0x124>

    }
    else if(scause==INTR_ILLEGAL_ADDR_WR){

    }
}
    800029bc:	04813083          	ld	ra,72(sp)
    800029c0:	04013403          	ld	s0,64(sp)
    800029c4:	03813483          	ld	s1,56(sp)
    800029c8:	05010113          	addi	sp,sp,80
    800029cc:	00008067          	ret
        SYSTEM_TIME++;
    800029d0:	0000c497          	auipc	s1,0xc
    800029d4:	90048493          	addi	s1,s1,-1792 # 8000e2d0 <SYSTEM_TIME>
    800029d8:	0004b503          	ld	a0,0(s1)
    800029dc:	00150513          	addi	a0,a0,1
    800029e0:	00a4b023          	sd	a0,0(s1)
    __asm__ volatile ("csrc sip, %[mask]" : : [mask] "r"(mask));
    800029e4:	00200793          	li	a5,2
    800029e8:	1447b073          	csrc	sip,a5
        kern_thread_wakeup(SYSTEM_TIME);
    800029ec:	00000097          	auipc	ra,0x0
    800029f0:	8ec080e7          	jalr	-1812(ra) # 800022d8 <_Z18kern_thread_wakeupm>
        if(SYSTEM_TIME>=running->endTime){
    800029f4:	00009797          	auipc	a5,0x9
    800029f8:	82c7b783          	ld	a5,-2004(a5) # 8000b220 <_GLOBAL_OFFSET_TABLE_+0x20>
    800029fc:	0007b783          	ld	a5,0(a5)
    80002a00:	0387b703          	ld	a4,56(a5)
    80002a04:	0004b783          	ld	a5,0(s1)
    80002a08:	fae7eae3          	bltu	a5,a4,800029bc <handleInterrupt+0x48>
    __asm__ volatile ("csrr %[sstatus], sstatus" : [sstatus] "=r"(sstatus));
    80002a0c:	100027f3          	csrr	a5,sstatus
    80002a10:	fcf43c23          	sd	a5,-40(s0)
    return sstatus;
    80002a14:	fd843783          	ld	a5,-40(s0)
            uint64 volatile sstatus = r_sstatus();
    80002a18:	faf43c23          	sd	a5,-72(s0)
    __asm__ volatile ("csrr %[sepc], sepc" : [sepc] "=r"(sepc));
    80002a1c:	141027f3          	csrr	a5,sepc
    80002a20:	fcf43823          	sd	a5,-48(s0)
    return sepc;
    80002a24:	fd043783          	ld	a5,-48(s0)
            uint64 volatile v_sepc = r_sepc();
    80002a28:	fcf43023          	sd	a5,-64(s0)
            kern_thread_dispatch();
    80002a2c:	fffff097          	auipc	ra,0xfffff
    80002a30:	610080e7          	jalr	1552(ra) # 8000203c <_Z20kern_thread_dispatchv>
            w_sstatus(sstatus);
    80002a34:	fb843783          	ld	a5,-72(s0)
    __asm__ volatile ("csrw sstatus, %[sstatus]" : : [sstatus] "r"(sstatus));
    80002a38:	10079073          	csrw	sstatus,a5
            w_sepc(v_sepc);
    80002a3c:	fc043783          	ld	a5,-64(s0)
    __asm__ volatile ("csrw sepc, %[sepc]" : : [sepc] "r"(sepc));
    80002a40:	14179073          	csrw	sepc,a5
            running->endTime=SYSTEM_TIME+running->timeslice;
    80002a44:	00008797          	auipc	a5,0x8
    80002a48:	7dc7b783          	ld	a5,2012(a5) # 8000b220 <_GLOBAL_OFFSET_TABLE_+0x20>
    80002a4c:	0007b703          	ld	a4,0(a5)
    80002a50:	03073783          	ld	a5,48(a4)
    80002a54:	0000c697          	auipc	a3,0xc
    80002a58:	87c6b683          	ld	a3,-1924(a3) # 8000e2d0 <SYSTEM_TIME>
    80002a5c:	00d787b3          	add	a5,a5,a3
    80002a60:	02f73c23          	sd	a5,56(a4)
    80002a64:	f59ff06f          	j	800029bc <handleInterrupt+0x48>
        int irq = plic_claim();
    80002a68:	00004097          	auipc	ra,0x4
    80002a6c:	d9c080e7          	jalr	-612(ra) # 80006804 <plic_claim>
    80002a70:	00050493          	mv	s1,a0
        if(irq==CONSOLE_IRQ) {
    80002a74:	00a00793          	li	a5,10
    80002a78:	00f50a63          	beq	a0,a5,80002a8c <handleInterrupt+0x118>
        plic_complete(irq);
    80002a7c:	00048513          	mv	a0,s1
    80002a80:	00004097          	auipc	ra,0x4
    80002a84:	dbc080e7          	jalr	-580(ra) # 8000683c <plic_complete>
    80002a88:	f35ff06f          	j	800029bc <handleInterrupt+0x48>
            kern_uart_handler();
    80002a8c:	fffff097          	auipc	ra,0xfffff
    80002a90:	e34080e7          	jalr	-460(ra) # 800018c0 <_Z17kern_uart_handlerv>
    80002a94:	fe9ff06f          	j	80002a7c <handleInterrupt+0x108>
        kern_mem_free((void*)running->stack_space);
    80002a98:	00008797          	auipc	a5,0x8
    80002a9c:	7887b783          	ld	a5,1928(a5) # 8000b220 <_GLOBAL_OFFSET_TABLE_+0x20>
    80002aa0:	0007b783          	ld	a5,0(a5)
    80002aa4:	0407b503          	ld	a0,64(a5)
    80002aa8:	fffff097          	auipc	ra,0xfffff
    80002aac:	bfc080e7          	jalr	-1028(ra) # 800016a4 <_Z13kern_mem_freePv>
        kern_thread_end_running();
    80002ab0:	fffff097          	auipc	ra,0xfffff
    80002ab4:	608080e7          	jalr	1544(ra) # 800020b8 <_Z23kern_thread_end_runningv>
}
    80002ab8:	f05ff06f          	j	800029bc <handleInterrupt+0x48>

0000000080002abc <_ZL16producerKeyboardPv>:
    sem_t wait;
};

static volatile int threadEnd = 0;

static void producerKeyboard(void *arg) {
    80002abc:	fe010113          	addi	sp,sp,-32
    80002ac0:	00113c23          	sd	ra,24(sp)
    80002ac4:	00813823          	sd	s0,16(sp)
    80002ac8:	00913423          	sd	s1,8(sp)
    80002acc:	01213023          	sd	s2,0(sp)
    80002ad0:	02010413          	addi	s0,sp,32
    80002ad4:	00050493          	mv	s1,a0
    struct thread_data *data = (struct thread_data *) arg;

    int key;
    int i = 0;
    80002ad8:	00000913          	li	s2,0
    80002adc:	00c0006f          	j	80002ae8 <_ZL16producerKeyboardPv+0x2c>
    while ((key = getc()) != 13) {
        data->buffer->put(key);
        i++;

        if (i % (10 * data->id) == 0) {
            thread_dispatch();
    80002ae0:	fffff097          	auipc	ra,0xfffff
    80002ae4:	8a8080e7          	jalr	-1880(ra) # 80001388 <_Z15thread_dispatchv>
    while ((key = getc()) != 13) {
    80002ae8:	fffff097          	auipc	ra,0xfffff
    80002aec:	a8c080e7          	jalr	-1396(ra) # 80001574 <_Z4getcv>
    80002af0:	0005059b          	sext.w	a1,a0
    80002af4:	00d00793          	li	a5,13
    80002af8:	02f58a63          	beq	a1,a5,80002b2c <_ZL16producerKeyboardPv+0x70>
        data->buffer->put(key);
    80002afc:	0084b503          	ld	a0,8(s1)
    80002b00:	00003097          	auipc	ra,0x3
    80002b04:	220080e7          	jalr	544(ra) # 80005d20 <_ZN6Buffer3putEi>
        i++;
    80002b08:	0019071b          	addiw	a4,s2,1
    80002b0c:	0007091b          	sext.w	s2,a4
        if (i % (10 * data->id) == 0) {
    80002b10:	0004a683          	lw	a3,0(s1)
    80002b14:	0026979b          	slliw	a5,a3,0x2
    80002b18:	00d787bb          	addw	a5,a5,a3
    80002b1c:	0017979b          	slliw	a5,a5,0x1
    80002b20:	02f767bb          	remw	a5,a4,a5
    80002b24:	fc0792e3          	bnez	a5,80002ae8 <_ZL16producerKeyboardPv+0x2c>
    80002b28:	fb9ff06f          	j	80002ae0 <_ZL16producerKeyboardPv+0x24>
        }
    }

    threadEnd = 1;
    80002b2c:	00100793          	li	a5,1
    80002b30:	0000c717          	auipc	a4,0xc
    80002b34:	baf72823          	sw	a5,-1104(a4) # 8000e6e0 <_ZL9threadEnd>
    data->buffer->put('!');
    80002b38:	02100593          	li	a1,33
    80002b3c:	0084b503          	ld	a0,8(s1)
    80002b40:	00003097          	auipc	ra,0x3
    80002b44:	1e0080e7          	jalr	480(ra) # 80005d20 <_ZN6Buffer3putEi>

    sem_signal(data->wait);
    80002b48:	0104b503          	ld	a0,16(s1)
    80002b4c:	fffff097          	auipc	ra,0xfffff
    80002b50:	9b4080e7          	jalr	-1612(ra) # 80001500 <_Z10sem_signalP5sem_s>
}
    80002b54:	01813083          	ld	ra,24(sp)
    80002b58:	01013403          	ld	s0,16(sp)
    80002b5c:	00813483          	ld	s1,8(sp)
    80002b60:	00013903          	ld	s2,0(sp)
    80002b64:	02010113          	addi	sp,sp,32
    80002b68:	00008067          	ret

0000000080002b6c <_ZL8producerPv>:

static void producer(void *arg) {
    80002b6c:	fe010113          	addi	sp,sp,-32
    80002b70:	00113c23          	sd	ra,24(sp)
    80002b74:	00813823          	sd	s0,16(sp)
    80002b78:	00913423          	sd	s1,8(sp)
    80002b7c:	01213023          	sd	s2,0(sp)
    80002b80:	02010413          	addi	s0,sp,32
    80002b84:	00050493          	mv	s1,a0
    struct thread_data *data = (struct thread_data *) arg;

    int i = 0;
    80002b88:	00000913          	li	s2,0
    80002b8c:	00c0006f          	j	80002b98 <_ZL8producerPv+0x2c>
    while (!threadEnd) {
        data->buffer->put(data->id + '0');
        i++;

        if (i % (10 * data->id) == 0) {
            thread_dispatch();
    80002b90:	ffffe097          	auipc	ra,0xffffe
    80002b94:	7f8080e7          	jalr	2040(ra) # 80001388 <_Z15thread_dispatchv>
    while (!threadEnd) {
    80002b98:	0000c797          	auipc	a5,0xc
    80002b9c:	b487a783          	lw	a5,-1208(a5) # 8000e6e0 <_ZL9threadEnd>
    80002ba0:	02079e63          	bnez	a5,80002bdc <_ZL8producerPv+0x70>
        data->buffer->put(data->id + '0');
    80002ba4:	0004a583          	lw	a1,0(s1)
    80002ba8:	0305859b          	addiw	a1,a1,48
    80002bac:	0084b503          	ld	a0,8(s1)
    80002bb0:	00003097          	auipc	ra,0x3
    80002bb4:	170080e7          	jalr	368(ra) # 80005d20 <_ZN6Buffer3putEi>
        i++;
    80002bb8:	0019071b          	addiw	a4,s2,1
    80002bbc:	0007091b          	sext.w	s2,a4
        if (i % (10 * data->id) == 0) {
    80002bc0:	0004a683          	lw	a3,0(s1)
    80002bc4:	0026979b          	slliw	a5,a3,0x2
    80002bc8:	00d787bb          	addw	a5,a5,a3
    80002bcc:	0017979b          	slliw	a5,a5,0x1
    80002bd0:	02f767bb          	remw	a5,a4,a5
    80002bd4:	fc0792e3          	bnez	a5,80002b98 <_ZL8producerPv+0x2c>
    80002bd8:	fb9ff06f          	j	80002b90 <_ZL8producerPv+0x24>
        }
    }

    sem_signal(data->wait);
    80002bdc:	0104b503          	ld	a0,16(s1)
    80002be0:	fffff097          	auipc	ra,0xfffff
    80002be4:	920080e7          	jalr	-1760(ra) # 80001500 <_Z10sem_signalP5sem_s>
}
    80002be8:	01813083          	ld	ra,24(sp)
    80002bec:	01013403          	ld	s0,16(sp)
    80002bf0:	00813483          	ld	s1,8(sp)
    80002bf4:	00013903          	ld	s2,0(sp)
    80002bf8:	02010113          	addi	sp,sp,32
    80002bfc:	00008067          	ret

0000000080002c00 <_ZL8consumerPv>:

static void consumer(void *arg) {
    80002c00:	fd010113          	addi	sp,sp,-48
    80002c04:	02113423          	sd	ra,40(sp)
    80002c08:	02813023          	sd	s0,32(sp)
    80002c0c:	00913c23          	sd	s1,24(sp)
    80002c10:	01213823          	sd	s2,16(sp)
    80002c14:	01313423          	sd	s3,8(sp)
    80002c18:	03010413          	addi	s0,sp,48
    80002c1c:	00050913          	mv	s2,a0
    struct thread_data *data = (struct thread_data *) arg;

    int i = 0;
    80002c20:	00000993          	li	s3,0
    80002c24:	01c0006f          	j	80002c40 <_ZL8consumerPv+0x40>
        i++;

        putc(key);

        if (i % (5 * data->id) == 0) {
            thread_dispatch();
    80002c28:	ffffe097          	auipc	ra,0xffffe
    80002c2c:	760080e7          	jalr	1888(ra) # 80001388 <_Z15thread_dispatchv>
    80002c30:	0500006f          	j	80002c80 <_ZL8consumerPv+0x80>
        }

        if (i % 80 == 0) {
            putc('\n');
    80002c34:	00a00513          	li	a0,10
    80002c38:	fffff097          	auipc	ra,0xfffff
    80002c3c:	978080e7          	jalr	-1672(ra) # 800015b0 <_Z4putcc>
    while (!threadEnd) {
    80002c40:	0000c797          	auipc	a5,0xc
    80002c44:	aa07a783          	lw	a5,-1376(a5) # 8000e6e0 <_ZL9threadEnd>
    80002c48:	06079063          	bnez	a5,80002ca8 <_ZL8consumerPv+0xa8>
        int key = data->buffer->get();
    80002c4c:	00893503          	ld	a0,8(s2)
    80002c50:	00003097          	auipc	ra,0x3
    80002c54:	160080e7          	jalr	352(ra) # 80005db0 <_ZN6Buffer3getEv>
        i++;
    80002c58:	0019849b          	addiw	s1,s3,1
    80002c5c:	0004899b          	sext.w	s3,s1
        putc(key);
    80002c60:	0ff57513          	andi	a0,a0,255
    80002c64:	fffff097          	auipc	ra,0xfffff
    80002c68:	94c080e7          	jalr	-1716(ra) # 800015b0 <_Z4putcc>
        if (i % (5 * data->id) == 0) {
    80002c6c:	00092703          	lw	a4,0(s2)
    80002c70:	0027179b          	slliw	a5,a4,0x2
    80002c74:	00e787bb          	addw	a5,a5,a4
    80002c78:	02f4e7bb          	remw	a5,s1,a5
    80002c7c:	fa0786e3          	beqz	a5,80002c28 <_ZL8consumerPv+0x28>
        if (i % 80 == 0) {
    80002c80:	05000793          	li	a5,80
    80002c84:	02f4e4bb          	remw	s1,s1,a5
    80002c88:	fa049ce3          	bnez	s1,80002c40 <_ZL8consumerPv+0x40>
    80002c8c:	fa9ff06f          	j	80002c34 <_ZL8consumerPv+0x34>
        }
    }

    while (data->buffer->getCnt() > 0) {
        int key = data->buffer->get();
    80002c90:	00893503          	ld	a0,8(s2)
    80002c94:	00003097          	auipc	ra,0x3
    80002c98:	11c080e7          	jalr	284(ra) # 80005db0 <_ZN6Buffer3getEv>
        putc(key);
    80002c9c:	0ff57513          	andi	a0,a0,255
    80002ca0:	fffff097          	auipc	ra,0xfffff
    80002ca4:	910080e7          	jalr	-1776(ra) # 800015b0 <_Z4putcc>
    while (data->buffer->getCnt() > 0) {
    80002ca8:	00893503          	ld	a0,8(s2)
    80002cac:	00003097          	auipc	ra,0x3
    80002cb0:	190080e7          	jalr	400(ra) # 80005e3c <_ZN6Buffer6getCntEv>
    80002cb4:	fca04ee3          	bgtz	a0,80002c90 <_ZL8consumerPv+0x90>
    }

    sem_signal(data->wait);
    80002cb8:	01093503          	ld	a0,16(s2)
    80002cbc:	fffff097          	auipc	ra,0xfffff
    80002cc0:	844080e7          	jalr	-1980(ra) # 80001500 <_Z10sem_signalP5sem_s>
}
    80002cc4:	02813083          	ld	ra,40(sp)
    80002cc8:	02013403          	ld	s0,32(sp)
    80002ccc:	01813483          	ld	s1,24(sp)
    80002cd0:	01013903          	ld	s2,16(sp)
    80002cd4:	00813983          	ld	s3,8(sp)
    80002cd8:	03010113          	addi	sp,sp,48
    80002cdc:	00008067          	ret

0000000080002ce0 <_Z22producerConsumer_C_APIv>:

void producerConsumer_C_API() {
    80002ce0:	f9010113          	addi	sp,sp,-112
    80002ce4:	06113423          	sd	ra,104(sp)
    80002ce8:	06813023          	sd	s0,96(sp)
    80002cec:	04913c23          	sd	s1,88(sp)
    80002cf0:	05213823          	sd	s2,80(sp)
    80002cf4:	05313423          	sd	s3,72(sp)
    80002cf8:	05413023          	sd	s4,64(sp)
    80002cfc:	03513c23          	sd	s5,56(sp)
    80002d00:	03613823          	sd	s6,48(sp)
    80002d04:	07010413          	addi	s0,sp,112
        sem_wait(waitForAll);
    }

    sem_close(waitForAll);

    delete buffer;
    80002d08:	00010b13          	mv	s6,sp
    printString("Unesite broj proizvodjaca?\n");
    80002d0c:	00006517          	auipc	a0,0x6
    80002d10:	42c50513          	addi	a0,a0,1068 # 80009138 <CONSOLE_STATUS+0x128>
    80002d14:	00002097          	auipc	ra,0x2
    80002d18:	fd0080e7          	jalr	-48(ra) # 80004ce4 <_Z11printStringPKc>
    getString(input, 30);
    80002d1c:	01e00593          	li	a1,30
    80002d20:	fa040493          	addi	s1,s0,-96
    80002d24:	00048513          	mv	a0,s1
    80002d28:	00002097          	auipc	ra,0x2
    80002d2c:	044080e7          	jalr	68(ra) # 80004d6c <_Z9getStringPci>
    threadNum = stringToInt(input);
    80002d30:	00048513          	mv	a0,s1
    80002d34:	00002097          	auipc	ra,0x2
    80002d38:	110080e7          	jalr	272(ra) # 80004e44 <_Z11stringToIntPKc>
    80002d3c:	00050913          	mv	s2,a0
    printString("Unesite velicinu bafera?\n");
    80002d40:	00006517          	auipc	a0,0x6
    80002d44:	41850513          	addi	a0,a0,1048 # 80009158 <CONSOLE_STATUS+0x148>
    80002d48:	00002097          	auipc	ra,0x2
    80002d4c:	f9c080e7          	jalr	-100(ra) # 80004ce4 <_Z11printStringPKc>
    getString(input, 30);
    80002d50:	01e00593          	li	a1,30
    80002d54:	00048513          	mv	a0,s1
    80002d58:	00002097          	auipc	ra,0x2
    80002d5c:	014080e7          	jalr	20(ra) # 80004d6c <_Z9getStringPci>
    n = stringToInt(input);
    80002d60:	00048513          	mv	a0,s1
    80002d64:	00002097          	auipc	ra,0x2
    80002d68:	0e0080e7          	jalr	224(ra) # 80004e44 <_Z11stringToIntPKc>
    80002d6c:	00050493          	mv	s1,a0
    printString("Broj proizvodjaca "); printInt(threadNum);
    80002d70:	00006517          	auipc	a0,0x6
    80002d74:	40850513          	addi	a0,a0,1032 # 80009178 <CONSOLE_STATUS+0x168>
    80002d78:	00002097          	auipc	ra,0x2
    80002d7c:	f6c080e7          	jalr	-148(ra) # 80004ce4 <_Z11printStringPKc>
    80002d80:	00000613          	li	a2,0
    80002d84:	00a00593          	li	a1,10
    80002d88:	00090513          	mv	a0,s2
    80002d8c:	00002097          	auipc	ra,0x2
    80002d90:	108080e7          	jalr	264(ra) # 80004e94 <_Z8printIntiii>
    printString(" i velicina bafera "); printInt(n);
    80002d94:	00006517          	auipc	a0,0x6
    80002d98:	3fc50513          	addi	a0,a0,1020 # 80009190 <CONSOLE_STATUS+0x180>
    80002d9c:	00002097          	auipc	ra,0x2
    80002da0:	f48080e7          	jalr	-184(ra) # 80004ce4 <_Z11printStringPKc>
    80002da4:	00000613          	li	a2,0
    80002da8:	00a00593          	li	a1,10
    80002dac:	00048513          	mv	a0,s1
    80002db0:	00002097          	auipc	ra,0x2
    80002db4:	0e4080e7          	jalr	228(ra) # 80004e94 <_Z8printIntiii>
    printString(".\n");
    80002db8:	00006517          	auipc	a0,0x6
    80002dbc:	3f050513          	addi	a0,a0,1008 # 800091a8 <CONSOLE_STATUS+0x198>
    80002dc0:	00002097          	auipc	ra,0x2
    80002dc4:	f24080e7          	jalr	-220(ra) # 80004ce4 <_Z11printStringPKc>
    if(threadNum > n) {
    80002dc8:	0324c463          	blt	s1,s2,80002df0 <_Z22producerConsumer_C_APIv+0x110>
    } else if (threadNum < 1) {
    80002dcc:	03205c63          	blez	s2,80002e04 <_Z22producerConsumer_C_APIv+0x124>
    Buffer *buffer = new Buffer(n);
    80002dd0:	03800513          	li	a0,56
    80002dd4:	fffff097          	auipc	ra,0xfffff
    80002dd8:	f94080e7          	jalr	-108(ra) # 80001d68 <_Znwm>
    80002ddc:	00050a13          	mv	s4,a0
    80002de0:	00048593          	mv	a1,s1
    80002de4:	00003097          	auipc	ra,0x3
    80002de8:	ea0080e7          	jalr	-352(ra) # 80005c84 <_ZN6BufferC1Ei>
    80002dec:	0300006f          	j	80002e1c <_Z22producerConsumer_C_APIv+0x13c>
        printString("Broj proizvodjaca ne sme biti manji od velicine bafera!\n");
    80002df0:	00006517          	auipc	a0,0x6
    80002df4:	3c050513          	addi	a0,a0,960 # 800091b0 <CONSOLE_STATUS+0x1a0>
    80002df8:	00002097          	auipc	ra,0x2
    80002dfc:	eec080e7          	jalr	-276(ra) # 80004ce4 <_Z11printStringPKc>
        return;
    80002e00:	0140006f          	j	80002e14 <_Z22producerConsumer_C_APIv+0x134>
        printString("Broj proizvodjaca mora biti veci od nula!\n");
    80002e04:	00006517          	auipc	a0,0x6
    80002e08:	3ec50513          	addi	a0,a0,1004 # 800091f0 <CONSOLE_STATUS+0x1e0>
    80002e0c:	00002097          	auipc	ra,0x2
    80002e10:	ed8080e7          	jalr	-296(ra) # 80004ce4 <_Z11printStringPKc>
        return;
    80002e14:	000b0113          	mv	sp,s6
    80002e18:	1500006f          	j	80002f68 <_Z22producerConsumer_C_APIv+0x288>
    sem_open(&waitForAll, 0);
    80002e1c:	00000593          	li	a1,0
    80002e20:	0000c517          	auipc	a0,0xc
    80002e24:	8c850513          	addi	a0,a0,-1848 # 8000e6e8 <_ZL10waitForAll>
    80002e28:	ffffe097          	auipc	ra,0xffffe
    80002e2c:	614080e7          	jalr	1556(ra) # 8000143c <_Z8sem_openPP5sem_sj>
    thread_t threads[threadNum];
    80002e30:	00391793          	slli	a5,s2,0x3
    80002e34:	00f78793          	addi	a5,a5,15
    80002e38:	ff07f793          	andi	a5,a5,-16
    80002e3c:	40f10133          	sub	sp,sp,a5
    80002e40:	00010a93          	mv	s5,sp
    struct thread_data data[threadNum + 1];
    80002e44:	0019071b          	addiw	a4,s2,1
    80002e48:	00171793          	slli	a5,a4,0x1
    80002e4c:	00e787b3          	add	a5,a5,a4
    80002e50:	00379793          	slli	a5,a5,0x3
    80002e54:	00f78793          	addi	a5,a5,15
    80002e58:	ff07f793          	andi	a5,a5,-16
    80002e5c:	40f10133          	sub	sp,sp,a5
    80002e60:	00010993          	mv	s3,sp
    data[threadNum].id = threadNum;
    80002e64:	00191613          	slli	a2,s2,0x1
    80002e68:	012607b3          	add	a5,a2,s2
    80002e6c:	00379793          	slli	a5,a5,0x3
    80002e70:	00f987b3          	add	a5,s3,a5
    80002e74:	0127a023          	sw	s2,0(a5)
    data[threadNum].buffer = buffer;
    80002e78:	0147b423          	sd	s4,8(a5)
    data[threadNum].wait = waitForAll;
    80002e7c:	0000c717          	auipc	a4,0xc
    80002e80:	86c73703          	ld	a4,-1940(a4) # 8000e6e8 <_ZL10waitForAll>
    80002e84:	00e7b823          	sd	a4,16(a5)
    thread_create(&consumerThread, consumer, data + threadNum);
    80002e88:	00078613          	mv	a2,a5
    80002e8c:	00000597          	auipc	a1,0x0
    80002e90:	d7458593          	addi	a1,a1,-652 # 80002c00 <_ZL8consumerPv>
    80002e94:	f9840513          	addi	a0,s0,-104
    80002e98:	ffffe097          	auipc	ra,0xffffe
    80002e9c:	468080e7          	jalr	1128(ra) # 80001300 <_Z13thread_createPP8thread_sPFvPvES2_>
    for (int i = 0; i < threadNum; i++) {
    80002ea0:	00000493          	li	s1,0
    80002ea4:	0280006f          	j	80002ecc <_Z22producerConsumer_C_APIv+0x1ec>
        thread_create(threads + i,
    80002ea8:	00000597          	auipc	a1,0x0
    80002eac:	c1458593          	addi	a1,a1,-1004 # 80002abc <_ZL16producerKeyboardPv>
                      data + i);
    80002eb0:	00179613          	slli	a2,a5,0x1
    80002eb4:	00f60633          	add	a2,a2,a5
    80002eb8:	00361613          	slli	a2,a2,0x3
        thread_create(threads + i,
    80002ebc:	00c98633          	add	a2,s3,a2
    80002ec0:	ffffe097          	auipc	ra,0xffffe
    80002ec4:	440080e7          	jalr	1088(ra) # 80001300 <_Z13thread_createPP8thread_sPFvPvES2_>
    for (int i = 0; i < threadNum; i++) {
    80002ec8:	0014849b          	addiw	s1,s1,1
    80002ecc:	0524d263          	bge	s1,s2,80002f10 <_Z22producerConsumer_C_APIv+0x230>
        data[i].id = i;
    80002ed0:	00149793          	slli	a5,s1,0x1
    80002ed4:	009787b3          	add	a5,a5,s1
    80002ed8:	00379793          	slli	a5,a5,0x3
    80002edc:	00f987b3          	add	a5,s3,a5
    80002ee0:	0097a023          	sw	s1,0(a5)
        data[i].buffer = buffer;
    80002ee4:	0147b423          	sd	s4,8(a5)
        data[i].wait = waitForAll;
    80002ee8:	0000c717          	auipc	a4,0xc
    80002eec:	80073703          	ld	a4,-2048(a4) # 8000e6e8 <_ZL10waitForAll>
    80002ef0:	00e7b823          	sd	a4,16(a5)
        thread_create(threads + i,
    80002ef4:	00048793          	mv	a5,s1
    80002ef8:	00349513          	slli	a0,s1,0x3
    80002efc:	00aa8533          	add	a0,s5,a0
    80002f00:	fa9054e3          	blez	s1,80002ea8 <_Z22producerConsumer_C_APIv+0x1c8>
    80002f04:	00000597          	auipc	a1,0x0
    80002f08:	c6858593          	addi	a1,a1,-920 # 80002b6c <_ZL8producerPv>
    80002f0c:	fa5ff06f          	j	80002eb0 <_Z22producerConsumer_C_APIv+0x1d0>
    thread_dispatch();
    80002f10:	ffffe097          	auipc	ra,0xffffe
    80002f14:	478080e7          	jalr	1144(ra) # 80001388 <_Z15thread_dispatchv>
    for (int i = 0; i <= threadNum; i++) {
    80002f18:	00000493          	li	s1,0
    80002f1c:	00994e63          	blt	s2,s1,80002f38 <_Z22producerConsumer_C_APIv+0x258>
        sem_wait(waitForAll);
    80002f20:	0000b517          	auipc	a0,0xb
    80002f24:	7c853503          	ld	a0,1992(a0) # 8000e6e8 <_ZL10waitForAll>
    80002f28:	ffffe097          	auipc	ra,0xffffe
    80002f2c:	598080e7          	jalr	1432(ra) # 800014c0 <_Z8sem_waitP5sem_s>
    for (int i = 0; i <= threadNum; i++) {
    80002f30:	0014849b          	addiw	s1,s1,1
    80002f34:	fe9ff06f          	j	80002f1c <_Z22producerConsumer_C_APIv+0x23c>
    sem_close(waitForAll);
    80002f38:	0000b517          	auipc	a0,0xb
    80002f3c:	7b053503          	ld	a0,1968(a0) # 8000e6e8 <_ZL10waitForAll>
    80002f40:	ffffe097          	auipc	ra,0xffffe
    80002f44:	540080e7          	jalr	1344(ra) # 80001480 <_Z9sem_closeP5sem_s>
    delete buffer;
    80002f48:	000a0e63          	beqz	s4,80002f64 <_Z22producerConsumer_C_APIv+0x284>
    80002f4c:	000a0513          	mv	a0,s4
    80002f50:	00003097          	auipc	ra,0x3
    80002f54:	f74080e7          	jalr	-140(ra) # 80005ec4 <_ZN6BufferD1Ev>
    80002f58:	000a0513          	mv	a0,s4
    80002f5c:	fffff097          	auipc	ra,0xfffff
    80002f60:	e34080e7          	jalr	-460(ra) # 80001d90 <_ZdlPv>
    80002f64:	000b0113          	mv	sp,s6

}
    80002f68:	f9040113          	addi	sp,s0,-112
    80002f6c:	06813083          	ld	ra,104(sp)
    80002f70:	06013403          	ld	s0,96(sp)
    80002f74:	05813483          	ld	s1,88(sp)
    80002f78:	05013903          	ld	s2,80(sp)
    80002f7c:	04813983          	ld	s3,72(sp)
    80002f80:	04013a03          	ld	s4,64(sp)
    80002f84:	03813a83          	ld	s5,56(sp)
    80002f88:	03013b03          	ld	s6,48(sp)
    80002f8c:	07010113          	addi	sp,sp,112
    80002f90:	00008067          	ret
    80002f94:	00050493          	mv	s1,a0
    Buffer *buffer = new Buffer(n);
    80002f98:	000a0513          	mv	a0,s4
    80002f9c:	fffff097          	auipc	ra,0xfffff
    80002fa0:	df4080e7          	jalr	-524(ra) # 80001d90 <_ZdlPv>
    80002fa4:	00048513          	mv	a0,s1
    80002fa8:	0000d097          	auipc	ra,0xd
    80002fac:	850080e7          	jalr	-1968(ra) # 8000f7f8 <_Unwind_Resume>

0000000080002fb0 <_ZL9fibonaccim>:
static volatile bool finishedA = false;
static volatile bool finishedB = false;
static volatile bool finishedC = false;
static volatile bool finishedD = false;

static uint64 fibonacci(uint64 n) {
    80002fb0:	fe010113          	addi	sp,sp,-32
    80002fb4:	00113c23          	sd	ra,24(sp)
    80002fb8:	00813823          	sd	s0,16(sp)
    80002fbc:	00913423          	sd	s1,8(sp)
    80002fc0:	01213023          	sd	s2,0(sp)
    80002fc4:	02010413          	addi	s0,sp,32
    80002fc8:	00050493          	mv	s1,a0
    if (n == 0 || n == 1) { return n; }
    80002fcc:	00100793          	li	a5,1
    80002fd0:	02a7f863          	bgeu	a5,a0,80003000 <_ZL9fibonaccim+0x50>
    if (n % 10 == 0) { thread_dispatch(); }
    80002fd4:	00a00793          	li	a5,10
    80002fd8:	02f577b3          	remu	a5,a0,a5
    80002fdc:	02078e63          	beqz	a5,80003018 <_ZL9fibonaccim+0x68>
    return fibonacci(n - 1) + fibonacci(n - 2);
    80002fe0:	fff48513          	addi	a0,s1,-1
    80002fe4:	00000097          	auipc	ra,0x0
    80002fe8:	fcc080e7          	jalr	-52(ra) # 80002fb0 <_ZL9fibonaccim>
    80002fec:	00050913          	mv	s2,a0
    80002ff0:	ffe48513          	addi	a0,s1,-2
    80002ff4:	00000097          	auipc	ra,0x0
    80002ff8:	fbc080e7          	jalr	-68(ra) # 80002fb0 <_ZL9fibonaccim>
    80002ffc:	00a90533          	add	a0,s2,a0
}
    80003000:	01813083          	ld	ra,24(sp)
    80003004:	01013403          	ld	s0,16(sp)
    80003008:	00813483          	ld	s1,8(sp)
    8000300c:	00013903          	ld	s2,0(sp)
    80003010:	02010113          	addi	sp,sp,32
    80003014:	00008067          	ret
    if (n % 10 == 0) { thread_dispatch(); }
    80003018:	ffffe097          	auipc	ra,0xffffe
    8000301c:	370080e7          	jalr	880(ra) # 80001388 <_Z15thread_dispatchv>
    80003020:	fc1ff06f          	j	80002fe0 <_ZL9fibonaccim+0x30>

0000000080003024 <_ZN7WorkerA11workerBodyAEPv>:
    void run() override {
        workerBodyD(nullptr);
    }
};

void WorkerA::workerBodyA(void *arg) {
    80003024:	fe010113          	addi	sp,sp,-32
    80003028:	00113c23          	sd	ra,24(sp)
    8000302c:	00813823          	sd	s0,16(sp)
    80003030:	00913423          	sd	s1,8(sp)
    80003034:	01213023          	sd	s2,0(sp)
    80003038:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 10; i++) {
    8000303c:	00000913          	li	s2,0
    80003040:	0380006f          	j	80003078 <_ZN7WorkerA11workerBodyAEPv+0x54>
        printString("A: i="); printInt(i); printString("\n");
        for (uint64 j = 0; j < 10000; j++) {
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
            thread_dispatch();
    80003044:	ffffe097          	auipc	ra,0xffffe
    80003048:	344080e7          	jalr	836(ra) # 80001388 <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++) {
    8000304c:	00148493          	addi	s1,s1,1
    80003050:	000027b7          	lui	a5,0x2
    80003054:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    80003058:	0097ee63          	bltu	a5,s1,80003074 <_ZN7WorkerA11workerBodyAEPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    8000305c:	00000713          	li	a4,0
    80003060:	000077b7          	lui	a5,0x7
    80003064:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    80003068:	fce7eee3          	bltu	a5,a4,80003044 <_ZN7WorkerA11workerBodyAEPv+0x20>
    8000306c:	00170713          	addi	a4,a4,1
    80003070:	ff1ff06f          	j	80003060 <_ZN7WorkerA11workerBodyAEPv+0x3c>
    for (uint64 i = 0; i < 10; i++) {
    80003074:	00190913          	addi	s2,s2,1
    80003078:	00900793          	li	a5,9
    8000307c:	0527e063          	bltu	a5,s2,800030bc <_ZN7WorkerA11workerBodyAEPv+0x98>
        printString("A: i="); printInt(i); printString("\n");
    80003080:	00006517          	auipc	a0,0x6
    80003084:	1a050513          	addi	a0,a0,416 # 80009220 <CONSOLE_STATUS+0x210>
    80003088:	00002097          	auipc	ra,0x2
    8000308c:	c5c080e7          	jalr	-932(ra) # 80004ce4 <_Z11printStringPKc>
    80003090:	00000613          	li	a2,0
    80003094:	00a00593          	li	a1,10
    80003098:	0009051b          	sext.w	a0,s2
    8000309c:	00002097          	auipc	ra,0x2
    800030a0:	df8080e7          	jalr	-520(ra) # 80004e94 <_Z8printIntiii>
    800030a4:	00006517          	auipc	a0,0x6
    800030a8:	3cc50513          	addi	a0,a0,972 # 80009470 <CONSOLE_STATUS+0x460>
    800030ac:	00002097          	auipc	ra,0x2
    800030b0:	c38080e7          	jalr	-968(ra) # 80004ce4 <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    800030b4:	00000493          	li	s1,0
    800030b8:	f99ff06f          	j	80003050 <_ZN7WorkerA11workerBodyAEPv+0x2c>
        }
    }
    printString("A finished!\n");
    800030bc:	00006517          	auipc	a0,0x6
    800030c0:	16c50513          	addi	a0,a0,364 # 80009228 <CONSOLE_STATUS+0x218>
    800030c4:	00002097          	auipc	ra,0x2
    800030c8:	c20080e7          	jalr	-992(ra) # 80004ce4 <_Z11printStringPKc>
    finishedA = true;
    800030cc:	00100793          	li	a5,1
    800030d0:	0000b717          	auipc	a4,0xb
    800030d4:	62f70023          	sb	a5,1568(a4) # 8000e6f0 <_ZL9finishedA>
}
    800030d8:	01813083          	ld	ra,24(sp)
    800030dc:	01013403          	ld	s0,16(sp)
    800030e0:	00813483          	ld	s1,8(sp)
    800030e4:	00013903          	ld	s2,0(sp)
    800030e8:	02010113          	addi	sp,sp,32
    800030ec:	00008067          	ret

00000000800030f0 <_ZN7WorkerB11workerBodyBEPv>:

void WorkerB::workerBodyB(void *arg) {
    800030f0:	fe010113          	addi	sp,sp,-32
    800030f4:	00113c23          	sd	ra,24(sp)
    800030f8:	00813823          	sd	s0,16(sp)
    800030fc:	00913423          	sd	s1,8(sp)
    80003100:	01213023          	sd	s2,0(sp)
    80003104:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 16; i++) {
    80003108:	00000913          	li	s2,0
    8000310c:	0380006f          	j	80003144 <_ZN7WorkerB11workerBodyBEPv+0x54>
        printString("B: i="); printInt(i); printString("\n");
        for (uint64 j = 0; j < 10000; j++) {
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
            thread_dispatch();
    80003110:	ffffe097          	auipc	ra,0xffffe
    80003114:	278080e7          	jalr	632(ra) # 80001388 <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++) {
    80003118:	00148493          	addi	s1,s1,1
    8000311c:	000027b7          	lui	a5,0x2
    80003120:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    80003124:	0097ee63          	bltu	a5,s1,80003140 <_ZN7WorkerB11workerBodyBEPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    80003128:	00000713          	li	a4,0
    8000312c:	000077b7          	lui	a5,0x7
    80003130:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    80003134:	fce7eee3          	bltu	a5,a4,80003110 <_ZN7WorkerB11workerBodyBEPv+0x20>
    80003138:	00170713          	addi	a4,a4,1
    8000313c:	ff1ff06f          	j	8000312c <_ZN7WorkerB11workerBodyBEPv+0x3c>
    for (uint64 i = 0; i < 16; i++) {
    80003140:	00190913          	addi	s2,s2,1
    80003144:	00f00793          	li	a5,15
    80003148:	0527e063          	bltu	a5,s2,80003188 <_ZN7WorkerB11workerBodyBEPv+0x98>
        printString("B: i="); printInt(i); printString("\n");
    8000314c:	00006517          	auipc	a0,0x6
    80003150:	0ec50513          	addi	a0,a0,236 # 80009238 <CONSOLE_STATUS+0x228>
    80003154:	00002097          	auipc	ra,0x2
    80003158:	b90080e7          	jalr	-1136(ra) # 80004ce4 <_Z11printStringPKc>
    8000315c:	00000613          	li	a2,0
    80003160:	00a00593          	li	a1,10
    80003164:	0009051b          	sext.w	a0,s2
    80003168:	00002097          	auipc	ra,0x2
    8000316c:	d2c080e7          	jalr	-724(ra) # 80004e94 <_Z8printIntiii>
    80003170:	00006517          	auipc	a0,0x6
    80003174:	30050513          	addi	a0,a0,768 # 80009470 <CONSOLE_STATUS+0x460>
    80003178:	00002097          	auipc	ra,0x2
    8000317c:	b6c080e7          	jalr	-1172(ra) # 80004ce4 <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    80003180:	00000493          	li	s1,0
    80003184:	f99ff06f          	j	8000311c <_ZN7WorkerB11workerBodyBEPv+0x2c>
        }
    }
    printString("B finished!\n");
    80003188:	00006517          	auipc	a0,0x6
    8000318c:	0b850513          	addi	a0,a0,184 # 80009240 <CONSOLE_STATUS+0x230>
    80003190:	00002097          	auipc	ra,0x2
    80003194:	b54080e7          	jalr	-1196(ra) # 80004ce4 <_Z11printStringPKc>
    finishedB = true;
    80003198:	00100793          	li	a5,1
    8000319c:	0000b717          	auipc	a4,0xb
    800031a0:	54f70aa3          	sb	a5,1365(a4) # 8000e6f1 <_ZL9finishedB>
    thread_dispatch();
    800031a4:	ffffe097          	auipc	ra,0xffffe
    800031a8:	1e4080e7          	jalr	484(ra) # 80001388 <_Z15thread_dispatchv>
}
    800031ac:	01813083          	ld	ra,24(sp)
    800031b0:	01013403          	ld	s0,16(sp)
    800031b4:	00813483          	ld	s1,8(sp)
    800031b8:	00013903          	ld	s2,0(sp)
    800031bc:	02010113          	addi	sp,sp,32
    800031c0:	00008067          	ret

00000000800031c4 <_ZN7WorkerC11workerBodyCEPv>:

void WorkerC::workerBodyC(void *arg) {
    800031c4:	fe010113          	addi	sp,sp,-32
    800031c8:	00113c23          	sd	ra,24(sp)
    800031cc:	00813823          	sd	s0,16(sp)
    800031d0:	00913423          	sd	s1,8(sp)
    800031d4:	01213023          	sd	s2,0(sp)
    800031d8:	02010413          	addi	s0,sp,32
    uint8 i = 0;
    800031dc:	00000493          	li	s1,0
    800031e0:	0400006f          	j	80003220 <_ZN7WorkerC11workerBodyCEPv+0x5c>
    for (; i < 3; i++) {
        printString("C: i="); printInt(i); printString("\n");
    800031e4:	00006517          	auipc	a0,0x6
    800031e8:	06c50513          	addi	a0,a0,108 # 80009250 <CONSOLE_STATUS+0x240>
    800031ec:	00002097          	auipc	ra,0x2
    800031f0:	af8080e7          	jalr	-1288(ra) # 80004ce4 <_Z11printStringPKc>
    800031f4:	00000613          	li	a2,0
    800031f8:	00a00593          	li	a1,10
    800031fc:	00048513          	mv	a0,s1
    80003200:	00002097          	auipc	ra,0x2
    80003204:	c94080e7          	jalr	-876(ra) # 80004e94 <_Z8printIntiii>
    80003208:	00006517          	auipc	a0,0x6
    8000320c:	26850513          	addi	a0,a0,616 # 80009470 <CONSOLE_STATUS+0x460>
    80003210:	00002097          	auipc	ra,0x2
    80003214:	ad4080e7          	jalr	-1324(ra) # 80004ce4 <_Z11printStringPKc>
    for (; i < 3; i++) {
    80003218:	0014849b          	addiw	s1,s1,1
    8000321c:	0ff4f493          	andi	s1,s1,255
    80003220:	00200793          	li	a5,2
    80003224:	fc97f0e3          	bgeu	a5,s1,800031e4 <_ZN7WorkerC11workerBodyCEPv+0x20>
    }

    printString("C: dispatch\n");
    80003228:	00006517          	auipc	a0,0x6
    8000322c:	03050513          	addi	a0,a0,48 # 80009258 <CONSOLE_STATUS+0x248>
    80003230:	00002097          	auipc	ra,0x2
    80003234:	ab4080e7          	jalr	-1356(ra) # 80004ce4 <_Z11printStringPKc>
    __asm__ ("li t1, 7");
    80003238:	00700313          	li	t1,7
    thread_dispatch();
    8000323c:	ffffe097          	auipc	ra,0xffffe
    80003240:	14c080e7          	jalr	332(ra) # 80001388 <_Z15thread_dispatchv>

    uint64 t1 = 0;
    __asm__ ("mv %[t1], t1" : [t1] "=r"(t1));
    80003244:	00030913          	mv	s2,t1

    printString("C: t1="); printInt(t1); printString("\n");
    80003248:	00006517          	auipc	a0,0x6
    8000324c:	02050513          	addi	a0,a0,32 # 80009268 <CONSOLE_STATUS+0x258>
    80003250:	00002097          	auipc	ra,0x2
    80003254:	a94080e7          	jalr	-1388(ra) # 80004ce4 <_Z11printStringPKc>
    80003258:	00000613          	li	a2,0
    8000325c:	00a00593          	li	a1,10
    80003260:	0009051b          	sext.w	a0,s2
    80003264:	00002097          	auipc	ra,0x2
    80003268:	c30080e7          	jalr	-976(ra) # 80004e94 <_Z8printIntiii>
    8000326c:	00006517          	auipc	a0,0x6
    80003270:	20450513          	addi	a0,a0,516 # 80009470 <CONSOLE_STATUS+0x460>
    80003274:	00002097          	auipc	ra,0x2
    80003278:	a70080e7          	jalr	-1424(ra) # 80004ce4 <_Z11printStringPKc>

    uint64 result = fibonacci(12);
    8000327c:	00c00513          	li	a0,12
    80003280:	00000097          	auipc	ra,0x0
    80003284:	d30080e7          	jalr	-720(ra) # 80002fb0 <_ZL9fibonaccim>
    80003288:	00050913          	mv	s2,a0
    printString("C: fibonaci="); printInt(result); printString("\n");
    8000328c:	00006517          	auipc	a0,0x6
    80003290:	fe450513          	addi	a0,a0,-28 # 80009270 <CONSOLE_STATUS+0x260>
    80003294:	00002097          	auipc	ra,0x2
    80003298:	a50080e7          	jalr	-1456(ra) # 80004ce4 <_Z11printStringPKc>
    8000329c:	00000613          	li	a2,0
    800032a0:	00a00593          	li	a1,10
    800032a4:	0009051b          	sext.w	a0,s2
    800032a8:	00002097          	auipc	ra,0x2
    800032ac:	bec080e7          	jalr	-1044(ra) # 80004e94 <_Z8printIntiii>
    800032b0:	00006517          	auipc	a0,0x6
    800032b4:	1c050513          	addi	a0,a0,448 # 80009470 <CONSOLE_STATUS+0x460>
    800032b8:	00002097          	auipc	ra,0x2
    800032bc:	a2c080e7          	jalr	-1492(ra) # 80004ce4 <_Z11printStringPKc>
    800032c0:	0400006f          	j	80003300 <_ZN7WorkerC11workerBodyCEPv+0x13c>

    for (; i < 6; i++) {
        printString("C: i="); printInt(i); printString("\n");
    800032c4:	00006517          	auipc	a0,0x6
    800032c8:	f8c50513          	addi	a0,a0,-116 # 80009250 <CONSOLE_STATUS+0x240>
    800032cc:	00002097          	auipc	ra,0x2
    800032d0:	a18080e7          	jalr	-1512(ra) # 80004ce4 <_Z11printStringPKc>
    800032d4:	00000613          	li	a2,0
    800032d8:	00a00593          	li	a1,10
    800032dc:	00048513          	mv	a0,s1
    800032e0:	00002097          	auipc	ra,0x2
    800032e4:	bb4080e7          	jalr	-1100(ra) # 80004e94 <_Z8printIntiii>
    800032e8:	00006517          	auipc	a0,0x6
    800032ec:	18850513          	addi	a0,a0,392 # 80009470 <CONSOLE_STATUS+0x460>
    800032f0:	00002097          	auipc	ra,0x2
    800032f4:	9f4080e7          	jalr	-1548(ra) # 80004ce4 <_Z11printStringPKc>
    for (; i < 6; i++) {
    800032f8:	0014849b          	addiw	s1,s1,1
    800032fc:	0ff4f493          	andi	s1,s1,255
    80003300:	00500793          	li	a5,5
    80003304:	fc97f0e3          	bgeu	a5,s1,800032c4 <_ZN7WorkerC11workerBodyCEPv+0x100>
    }

    printString("A finished!\n");
    80003308:	00006517          	auipc	a0,0x6
    8000330c:	f2050513          	addi	a0,a0,-224 # 80009228 <CONSOLE_STATUS+0x218>
    80003310:	00002097          	auipc	ra,0x2
    80003314:	9d4080e7          	jalr	-1580(ra) # 80004ce4 <_Z11printStringPKc>
    finishedC = true;
    80003318:	00100793          	li	a5,1
    8000331c:	0000b717          	auipc	a4,0xb
    80003320:	3cf70b23          	sb	a5,982(a4) # 8000e6f2 <_ZL9finishedC>
    thread_dispatch();
    80003324:	ffffe097          	auipc	ra,0xffffe
    80003328:	064080e7          	jalr	100(ra) # 80001388 <_Z15thread_dispatchv>
}
    8000332c:	01813083          	ld	ra,24(sp)
    80003330:	01013403          	ld	s0,16(sp)
    80003334:	00813483          	ld	s1,8(sp)
    80003338:	00013903          	ld	s2,0(sp)
    8000333c:	02010113          	addi	sp,sp,32
    80003340:	00008067          	ret

0000000080003344 <_ZN7WorkerD11workerBodyDEPv>:

void WorkerD::workerBodyD(void* arg) {
    80003344:	fe010113          	addi	sp,sp,-32
    80003348:	00113c23          	sd	ra,24(sp)
    8000334c:	00813823          	sd	s0,16(sp)
    80003350:	00913423          	sd	s1,8(sp)
    80003354:	01213023          	sd	s2,0(sp)
    80003358:	02010413          	addi	s0,sp,32
    uint8 i = 10;
    8000335c:	00a00493          	li	s1,10
    80003360:	0400006f          	j	800033a0 <_ZN7WorkerD11workerBodyDEPv+0x5c>
    for (; i < 13; i++) {
        printString("D: i="); printInt(i); printString("\n");
    80003364:	00006517          	auipc	a0,0x6
    80003368:	f1c50513          	addi	a0,a0,-228 # 80009280 <CONSOLE_STATUS+0x270>
    8000336c:	00002097          	auipc	ra,0x2
    80003370:	978080e7          	jalr	-1672(ra) # 80004ce4 <_Z11printStringPKc>
    80003374:	00000613          	li	a2,0
    80003378:	00a00593          	li	a1,10
    8000337c:	00048513          	mv	a0,s1
    80003380:	00002097          	auipc	ra,0x2
    80003384:	b14080e7          	jalr	-1260(ra) # 80004e94 <_Z8printIntiii>
    80003388:	00006517          	auipc	a0,0x6
    8000338c:	0e850513          	addi	a0,a0,232 # 80009470 <CONSOLE_STATUS+0x460>
    80003390:	00002097          	auipc	ra,0x2
    80003394:	954080e7          	jalr	-1708(ra) # 80004ce4 <_Z11printStringPKc>
    for (; i < 13; i++) {
    80003398:	0014849b          	addiw	s1,s1,1
    8000339c:	0ff4f493          	andi	s1,s1,255
    800033a0:	00c00793          	li	a5,12
    800033a4:	fc97f0e3          	bgeu	a5,s1,80003364 <_ZN7WorkerD11workerBodyDEPv+0x20>
    }

    printString("D: dispatch\n");
    800033a8:	00006517          	auipc	a0,0x6
    800033ac:	ee050513          	addi	a0,a0,-288 # 80009288 <CONSOLE_STATUS+0x278>
    800033b0:	00002097          	auipc	ra,0x2
    800033b4:	934080e7          	jalr	-1740(ra) # 80004ce4 <_Z11printStringPKc>
    __asm__ ("li t1, 5");
    800033b8:	00500313          	li	t1,5
    thread_dispatch();
    800033bc:	ffffe097          	auipc	ra,0xffffe
    800033c0:	fcc080e7          	jalr	-52(ra) # 80001388 <_Z15thread_dispatchv>

    uint64 result = fibonacci(16);
    800033c4:	01000513          	li	a0,16
    800033c8:	00000097          	auipc	ra,0x0
    800033cc:	be8080e7          	jalr	-1048(ra) # 80002fb0 <_ZL9fibonaccim>
    800033d0:	00050913          	mv	s2,a0
    printString("D: fibonaci="); printInt(result); printString("\n");
    800033d4:	00006517          	auipc	a0,0x6
    800033d8:	ec450513          	addi	a0,a0,-316 # 80009298 <CONSOLE_STATUS+0x288>
    800033dc:	00002097          	auipc	ra,0x2
    800033e0:	908080e7          	jalr	-1784(ra) # 80004ce4 <_Z11printStringPKc>
    800033e4:	00000613          	li	a2,0
    800033e8:	00a00593          	li	a1,10
    800033ec:	0009051b          	sext.w	a0,s2
    800033f0:	00002097          	auipc	ra,0x2
    800033f4:	aa4080e7          	jalr	-1372(ra) # 80004e94 <_Z8printIntiii>
    800033f8:	00006517          	auipc	a0,0x6
    800033fc:	07850513          	addi	a0,a0,120 # 80009470 <CONSOLE_STATUS+0x460>
    80003400:	00002097          	auipc	ra,0x2
    80003404:	8e4080e7          	jalr	-1820(ra) # 80004ce4 <_Z11printStringPKc>
    80003408:	0400006f          	j	80003448 <_ZN7WorkerD11workerBodyDEPv+0x104>

    for (; i < 16; i++) {
        printString("D: i="); printInt(i); printString("\n");
    8000340c:	00006517          	auipc	a0,0x6
    80003410:	e7450513          	addi	a0,a0,-396 # 80009280 <CONSOLE_STATUS+0x270>
    80003414:	00002097          	auipc	ra,0x2
    80003418:	8d0080e7          	jalr	-1840(ra) # 80004ce4 <_Z11printStringPKc>
    8000341c:	00000613          	li	a2,0
    80003420:	00a00593          	li	a1,10
    80003424:	00048513          	mv	a0,s1
    80003428:	00002097          	auipc	ra,0x2
    8000342c:	a6c080e7          	jalr	-1428(ra) # 80004e94 <_Z8printIntiii>
    80003430:	00006517          	auipc	a0,0x6
    80003434:	04050513          	addi	a0,a0,64 # 80009470 <CONSOLE_STATUS+0x460>
    80003438:	00002097          	auipc	ra,0x2
    8000343c:	8ac080e7          	jalr	-1876(ra) # 80004ce4 <_Z11printStringPKc>
    for (; i < 16; i++) {
    80003440:	0014849b          	addiw	s1,s1,1
    80003444:	0ff4f493          	andi	s1,s1,255
    80003448:	00f00793          	li	a5,15
    8000344c:	fc97f0e3          	bgeu	a5,s1,8000340c <_ZN7WorkerD11workerBodyDEPv+0xc8>
    }

    printString("D finished!\n");
    80003450:	00006517          	auipc	a0,0x6
    80003454:	e5850513          	addi	a0,a0,-424 # 800092a8 <CONSOLE_STATUS+0x298>
    80003458:	00002097          	auipc	ra,0x2
    8000345c:	88c080e7          	jalr	-1908(ra) # 80004ce4 <_Z11printStringPKc>
    finishedD = true;
    80003460:	00100793          	li	a5,1
    80003464:	0000b717          	auipc	a4,0xb
    80003468:	28f707a3          	sb	a5,655(a4) # 8000e6f3 <_ZL9finishedD>
    thread_dispatch();
    8000346c:	ffffe097          	auipc	ra,0xffffe
    80003470:	f1c080e7          	jalr	-228(ra) # 80001388 <_Z15thread_dispatchv>
}
    80003474:	01813083          	ld	ra,24(sp)
    80003478:	01013403          	ld	s0,16(sp)
    8000347c:	00813483          	ld	s1,8(sp)
    80003480:	00013903          	ld	s2,0(sp)
    80003484:	02010113          	addi	sp,sp,32
    80003488:	00008067          	ret

000000008000348c <_Z20Threads_CPP_API_testv>:


void Threads_CPP_API_test() {
    8000348c:	fc010113          	addi	sp,sp,-64
    80003490:	02113c23          	sd	ra,56(sp)
    80003494:	02813823          	sd	s0,48(sp)
    80003498:	02913423          	sd	s1,40(sp)
    8000349c:	04010413          	addi	s0,sp,64
    Thread* threads[4];

    threads[0] = new WorkerA();
    800034a0:	02000513          	li	a0,32
    800034a4:	fffff097          	auipc	ra,0xfffff
    800034a8:	8c4080e7          	jalr	-1852(ra) # 80001d68 <_Znwm>
        static int sleep (time_t time){
            return time_sleep(time);
        }
        protected:
        Thread (){
            body= nullptr;
    800034ac:	00053823          	sd	zero,16(a0)
            arg= nullptr;
    800034b0:	00053c23          	sd	zero,24(a0)
    WorkerA():Thread() {}
    800034b4:	00008797          	auipc	a5,0x8
    800034b8:	b9478793          	addi	a5,a5,-1132 # 8000b048 <_ZTV7WorkerA+0x10>
    800034bc:	00f53023          	sd	a5,0(a0)
    threads[0] = new WorkerA();
    800034c0:	fca43023          	sd	a0,-64(s0)
    printString("ThreadA created\n");
    800034c4:	00006517          	auipc	a0,0x6
    800034c8:	df450513          	addi	a0,a0,-524 # 800092b8 <CONSOLE_STATUS+0x2a8>
    800034cc:	00002097          	auipc	ra,0x2
    800034d0:	818080e7          	jalr	-2024(ra) # 80004ce4 <_Z11printStringPKc>

    threads[1] = new WorkerB();
    800034d4:	02000513          	li	a0,32
    800034d8:	fffff097          	auipc	ra,0xfffff
    800034dc:	890080e7          	jalr	-1904(ra) # 80001d68 <_Znwm>
            body= nullptr;
    800034e0:	00053823          	sd	zero,16(a0)
            arg= nullptr;
    800034e4:	00053c23          	sd	zero,24(a0)
    WorkerB():Thread() {}
    800034e8:	00008797          	auipc	a5,0x8
    800034ec:	b8878793          	addi	a5,a5,-1144 # 8000b070 <_ZTV7WorkerB+0x10>
    800034f0:	00f53023          	sd	a5,0(a0)
    threads[1] = new WorkerB();
    800034f4:	fca43423          	sd	a0,-56(s0)
    printString("ThreadB created\n");
    800034f8:	00006517          	auipc	a0,0x6
    800034fc:	dd850513          	addi	a0,a0,-552 # 800092d0 <CONSOLE_STATUS+0x2c0>
    80003500:	00001097          	auipc	ra,0x1
    80003504:	7e4080e7          	jalr	2020(ra) # 80004ce4 <_Z11printStringPKc>

    threads[2] = new WorkerC();
    80003508:	02000513          	li	a0,32
    8000350c:	fffff097          	auipc	ra,0xfffff
    80003510:	85c080e7          	jalr	-1956(ra) # 80001d68 <_Znwm>
            body= nullptr;
    80003514:	00053823          	sd	zero,16(a0)
            arg= nullptr;
    80003518:	00053c23          	sd	zero,24(a0)
    WorkerC():Thread() {}
    8000351c:	00008797          	auipc	a5,0x8
    80003520:	b7c78793          	addi	a5,a5,-1156 # 8000b098 <_ZTV7WorkerC+0x10>
    80003524:	00f53023          	sd	a5,0(a0)
    threads[2] = new WorkerC();
    80003528:	fca43823          	sd	a0,-48(s0)
    printString("ThreadC created\n");
    8000352c:	00006517          	auipc	a0,0x6
    80003530:	dbc50513          	addi	a0,a0,-580 # 800092e8 <CONSOLE_STATUS+0x2d8>
    80003534:	00001097          	auipc	ra,0x1
    80003538:	7b0080e7          	jalr	1968(ra) # 80004ce4 <_Z11printStringPKc>

    threads[3] = new WorkerD();
    8000353c:	02000513          	li	a0,32
    80003540:	fffff097          	auipc	ra,0xfffff
    80003544:	828080e7          	jalr	-2008(ra) # 80001d68 <_Znwm>
            body= nullptr;
    80003548:	00053823          	sd	zero,16(a0)
            arg= nullptr;
    8000354c:	00053c23          	sd	zero,24(a0)
    WorkerD():Thread() {}
    80003550:	00008797          	auipc	a5,0x8
    80003554:	b7078793          	addi	a5,a5,-1168 # 8000b0c0 <_ZTV7WorkerD+0x10>
    80003558:	00f53023          	sd	a5,0(a0)
    threads[3] = new WorkerD();
    8000355c:	fca43c23          	sd	a0,-40(s0)
    printString("ThreadD created\n");
    80003560:	00006517          	auipc	a0,0x6
    80003564:	da050513          	addi	a0,a0,-608 # 80009300 <CONSOLE_STATUS+0x2f0>
    80003568:	00001097          	auipc	ra,0x1
    8000356c:	77c080e7          	jalr	1916(ra) # 80004ce4 <_Z11printStringPKc>

    for(int i=0; i<4; i++) {
    80003570:	00000493          	li	s1,0
    80003574:	0200006f          	j	80003594 <_Z20Threads_CPP_API_testv+0x108>
            if(body== nullptr) return thread_create(&myHandle,&threadEntry, this);
    80003578:	00050613          	mv	a2,a0
    8000357c:	ffffe597          	auipc	a1,0xffffe
    80003580:	79858593          	addi	a1,a1,1944 # 80001d14 <_ZN6Thread11threadEntryEPv>
    80003584:	00850513          	addi	a0,a0,8
    80003588:	ffffe097          	auipc	ra,0xffffe
    8000358c:	d78080e7          	jalr	-648(ra) # 80001300 <_Z13thread_createPP8thread_sPFvPvES2_>
    80003590:	0014849b          	addiw	s1,s1,1
    80003594:	00300793          	li	a5,3
    80003598:	0297cc63          	blt	a5,s1,800035d0 <_Z20Threads_CPP_API_testv+0x144>
        threads[i]->start();
    8000359c:	00349793          	slli	a5,s1,0x3
    800035a0:	fe040713          	addi	a4,s0,-32
    800035a4:	00f707b3          	add	a5,a4,a5
    800035a8:	fe07b503          	ld	a0,-32(a5)
    800035ac:	01053583          	ld	a1,16(a0)
    800035b0:	fc0584e3          	beqz	a1,80003578 <_Z20Threads_CPP_API_testv+0xec>
            else return thread_create(&myHandle,body,arg);
    800035b4:	01853603          	ld	a2,24(a0)
    800035b8:	00850513          	addi	a0,a0,8
    800035bc:	ffffe097          	auipc	ra,0xffffe
    800035c0:	d44080e7          	jalr	-700(ra) # 80001300 <_Z13thread_createPP8thread_sPFvPvES2_>
    800035c4:	fcdff06f          	j	80003590 <_Z20Threads_CPP_API_testv+0x104>
            thread_dispatch();
    800035c8:	ffffe097          	auipc	ra,0xffffe
    800035cc:	dc0080e7          	jalr	-576(ra) # 80001388 <_Z15thread_dispatchv>
    }

    while (!(finishedA && finishedB && finishedC && finishedD)) {
    800035d0:	0000b797          	auipc	a5,0xb
    800035d4:	1207c783          	lbu	a5,288(a5) # 8000e6f0 <_ZL9finishedA>
    800035d8:	fe0788e3          	beqz	a5,800035c8 <_Z20Threads_CPP_API_testv+0x13c>
    800035dc:	0000b797          	auipc	a5,0xb
    800035e0:	1157c783          	lbu	a5,277(a5) # 8000e6f1 <_ZL9finishedB>
    800035e4:	fe0782e3          	beqz	a5,800035c8 <_Z20Threads_CPP_API_testv+0x13c>
    800035e8:	0000b797          	auipc	a5,0xb
    800035ec:	10a7c783          	lbu	a5,266(a5) # 8000e6f2 <_ZL9finishedC>
    800035f0:	fc078ce3          	beqz	a5,800035c8 <_Z20Threads_CPP_API_testv+0x13c>
    800035f4:	0000b797          	auipc	a5,0xb
    800035f8:	0ff7c783          	lbu	a5,255(a5) # 8000e6f3 <_ZL9finishedD>
    800035fc:	fc0786e3          	beqz	a5,800035c8 <_Z20Threads_CPP_API_testv+0x13c>
    80003600:	fc040493          	addi	s1,s0,-64
    80003604:	0080006f          	j	8000360c <_Z20Threads_CPP_API_testv+0x180>
        Thread::dispatch();
    }

    for (auto thread: threads) { delete thread; }
    80003608:	00848493          	addi	s1,s1,8
    8000360c:	fe040793          	addi	a5,s0,-32
    80003610:	00f48e63          	beq	s1,a5,8000362c <_Z20Threads_CPP_API_testv+0x1a0>
    80003614:	0004b503          	ld	a0,0(s1)
    80003618:	fe0508e3          	beqz	a0,80003608 <_Z20Threads_CPP_API_testv+0x17c>
    8000361c:	00053783          	ld	a5,0(a0)
    80003620:	0087b783          	ld	a5,8(a5)
    80003624:	000780e7          	jalr	a5
    80003628:	fe1ff06f          	j	80003608 <_Z20Threads_CPP_API_testv+0x17c>
}
    8000362c:	03813083          	ld	ra,56(sp)
    80003630:	03013403          	ld	s0,48(sp)
    80003634:	02813483          	ld	s1,40(sp)
    80003638:	04010113          	addi	sp,sp,64
    8000363c:	00008067          	ret

0000000080003640 <_ZN7WorkerDD1Ev>:
class WorkerD: public Thread {
    80003640:	ff010113          	addi	sp,sp,-16
    80003644:	00813423          	sd	s0,8(sp)
    80003648:	01010413          	addi	s0,sp,16
    8000364c:	00813403          	ld	s0,8(sp)
    80003650:	01010113          	addi	sp,sp,16
    80003654:	00008067          	ret

0000000080003658 <_ZN7WorkerCD1Ev>:
class WorkerC: public Thread {
    80003658:	ff010113          	addi	sp,sp,-16
    8000365c:	00813423          	sd	s0,8(sp)
    80003660:	01010413          	addi	s0,sp,16
    80003664:	00813403          	ld	s0,8(sp)
    80003668:	01010113          	addi	sp,sp,16
    8000366c:	00008067          	ret

0000000080003670 <_ZN7WorkerBD1Ev>:
class WorkerB: public Thread {
    80003670:	ff010113          	addi	sp,sp,-16
    80003674:	00813423          	sd	s0,8(sp)
    80003678:	01010413          	addi	s0,sp,16
    8000367c:	00813403          	ld	s0,8(sp)
    80003680:	01010113          	addi	sp,sp,16
    80003684:	00008067          	ret

0000000080003688 <_ZN7WorkerAD1Ev>:
class WorkerA: public Thread {
    80003688:	ff010113          	addi	sp,sp,-16
    8000368c:	00813423          	sd	s0,8(sp)
    80003690:	01010413          	addi	s0,sp,16
    80003694:	00813403          	ld	s0,8(sp)
    80003698:	01010113          	addi	sp,sp,16
    8000369c:	00008067          	ret

00000000800036a0 <_ZN7WorkerAD0Ev>:
    800036a0:	ff010113          	addi	sp,sp,-16
    800036a4:	00113423          	sd	ra,8(sp)
    800036a8:	00813023          	sd	s0,0(sp)
    800036ac:	01010413          	addi	s0,sp,16
    800036b0:	ffffe097          	auipc	ra,0xffffe
    800036b4:	6e0080e7          	jalr	1760(ra) # 80001d90 <_ZdlPv>
    800036b8:	00813083          	ld	ra,8(sp)
    800036bc:	00013403          	ld	s0,0(sp)
    800036c0:	01010113          	addi	sp,sp,16
    800036c4:	00008067          	ret

00000000800036c8 <_ZN7WorkerBD0Ev>:
class WorkerB: public Thread {
    800036c8:	ff010113          	addi	sp,sp,-16
    800036cc:	00113423          	sd	ra,8(sp)
    800036d0:	00813023          	sd	s0,0(sp)
    800036d4:	01010413          	addi	s0,sp,16
    800036d8:	ffffe097          	auipc	ra,0xffffe
    800036dc:	6b8080e7          	jalr	1720(ra) # 80001d90 <_ZdlPv>
    800036e0:	00813083          	ld	ra,8(sp)
    800036e4:	00013403          	ld	s0,0(sp)
    800036e8:	01010113          	addi	sp,sp,16
    800036ec:	00008067          	ret

00000000800036f0 <_ZN7WorkerCD0Ev>:
class WorkerC: public Thread {
    800036f0:	ff010113          	addi	sp,sp,-16
    800036f4:	00113423          	sd	ra,8(sp)
    800036f8:	00813023          	sd	s0,0(sp)
    800036fc:	01010413          	addi	s0,sp,16
    80003700:	ffffe097          	auipc	ra,0xffffe
    80003704:	690080e7          	jalr	1680(ra) # 80001d90 <_ZdlPv>
    80003708:	00813083          	ld	ra,8(sp)
    8000370c:	00013403          	ld	s0,0(sp)
    80003710:	01010113          	addi	sp,sp,16
    80003714:	00008067          	ret

0000000080003718 <_ZN7WorkerDD0Ev>:
class WorkerD: public Thread {
    80003718:	ff010113          	addi	sp,sp,-16
    8000371c:	00113423          	sd	ra,8(sp)
    80003720:	00813023          	sd	s0,0(sp)
    80003724:	01010413          	addi	s0,sp,16
    80003728:	ffffe097          	auipc	ra,0xffffe
    8000372c:	668080e7          	jalr	1640(ra) # 80001d90 <_ZdlPv>
    80003730:	00813083          	ld	ra,8(sp)
    80003734:	00013403          	ld	s0,0(sp)
    80003738:	01010113          	addi	sp,sp,16
    8000373c:	00008067          	ret

0000000080003740 <_ZN7WorkerA3runEv>:
    void run() override {
    80003740:	ff010113          	addi	sp,sp,-16
    80003744:	00113423          	sd	ra,8(sp)
    80003748:	00813023          	sd	s0,0(sp)
    8000374c:	01010413          	addi	s0,sp,16
        workerBodyA(nullptr);
    80003750:	00000593          	li	a1,0
    80003754:	00000097          	auipc	ra,0x0
    80003758:	8d0080e7          	jalr	-1840(ra) # 80003024 <_ZN7WorkerA11workerBodyAEPv>
    }
    8000375c:	00813083          	ld	ra,8(sp)
    80003760:	00013403          	ld	s0,0(sp)
    80003764:	01010113          	addi	sp,sp,16
    80003768:	00008067          	ret

000000008000376c <_ZN7WorkerB3runEv>:
    void run() override {
    8000376c:	ff010113          	addi	sp,sp,-16
    80003770:	00113423          	sd	ra,8(sp)
    80003774:	00813023          	sd	s0,0(sp)
    80003778:	01010413          	addi	s0,sp,16
        workerBodyB(nullptr);
    8000377c:	00000593          	li	a1,0
    80003780:	00000097          	auipc	ra,0x0
    80003784:	970080e7          	jalr	-1680(ra) # 800030f0 <_ZN7WorkerB11workerBodyBEPv>
    }
    80003788:	00813083          	ld	ra,8(sp)
    8000378c:	00013403          	ld	s0,0(sp)
    80003790:	01010113          	addi	sp,sp,16
    80003794:	00008067          	ret

0000000080003798 <_ZN7WorkerC3runEv>:
    void run() override {
    80003798:	ff010113          	addi	sp,sp,-16
    8000379c:	00113423          	sd	ra,8(sp)
    800037a0:	00813023          	sd	s0,0(sp)
    800037a4:	01010413          	addi	s0,sp,16
        workerBodyC(nullptr);
    800037a8:	00000593          	li	a1,0
    800037ac:	00000097          	auipc	ra,0x0
    800037b0:	a18080e7          	jalr	-1512(ra) # 800031c4 <_ZN7WorkerC11workerBodyCEPv>
    }
    800037b4:	00813083          	ld	ra,8(sp)
    800037b8:	00013403          	ld	s0,0(sp)
    800037bc:	01010113          	addi	sp,sp,16
    800037c0:	00008067          	ret

00000000800037c4 <_ZN7WorkerD3runEv>:
    void run() override {
    800037c4:	ff010113          	addi	sp,sp,-16
    800037c8:	00113423          	sd	ra,8(sp)
    800037cc:	00813023          	sd	s0,0(sp)
    800037d0:	01010413          	addi	s0,sp,16
        workerBodyD(nullptr);
    800037d4:	00000593          	li	a1,0
    800037d8:	00000097          	auipc	ra,0x0
    800037dc:	b6c080e7          	jalr	-1172(ra) # 80003344 <_ZN7WorkerD11workerBodyDEPv>
    }
    800037e0:	00813083          	ld	ra,8(sp)
    800037e4:	00013403          	ld	s0,0(sp)
    800037e8:	01010113          	addi	sp,sp,16
    800037ec:	00008067          	ret

00000000800037f0 <_Z20testConsumerProducerv>:

        td->sem->signal();
    }
};

void testConsumerProducer() {
    800037f0:	f9010113          	addi	sp,sp,-112
    800037f4:	06113423          	sd	ra,104(sp)
    800037f8:	06813023          	sd	s0,96(sp)
    800037fc:	04913c23          	sd	s1,88(sp)
    80003800:	05213823          	sd	s2,80(sp)
    80003804:	05313423          	sd	s3,72(sp)
    80003808:	05413023          	sd	s4,64(sp)
    8000380c:	03513c23          	sd	s5,56(sp)
    80003810:	03613823          	sd	s6,48(sp)
    80003814:	03713423          	sd	s7,40(sp)
    80003818:	03813023          	sd	s8,32(sp)
    8000381c:	07010413          	addi	s0,sp,112
    delete waitForAll;
    for (int i = 0; i < threadNum; i++) {
        delete producers[i];
    }
    delete consumer;
    delete buffer;
    80003820:	00010c13          	mv	s8,sp
    printString("Unesite broj proizvodjaca?\n");
    80003824:	00006517          	auipc	a0,0x6
    80003828:	91450513          	addi	a0,a0,-1772 # 80009138 <CONSOLE_STATUS+0x128>
    8000382c:	00001097          	auipc	ra,0x1
    80003830:	4b8080e7          	jalr	1208(ra) # 80004ce4 <_Z11printStringPKc>
    getString(input, 30);
    80003834:	01e00593          	li	a1,30
    80003838:	f9040493          	addi	s1,s0,-112
    8000383c:	00048513          	mv	a0,s1
    80003840:	00001097          	auipc	ra,0x1
    80003844:	52c080e7          	jalr	1324(ra) # 80004d6c <_Z9getStringPci>
    threadNum = stringToInt(input);
    80003848:	00048513          	mv	a0,s1
    8000384c:	00001097          	auipc	ra,0x1
    80003850:	5f8080e7          	jalr	1528(ra) # 80004e44 <_Z11stringToIntPKc>
    80003854:	00050993          	mv	s3,a0
    printString("Unesite velicinu bafera?\n");
    80003858:	00006517          	auipc	a0,0x6
    8000385c:	90050513          	addi	a0,a0,-1792 # 80009158 <CONSOLE_STATUS+0x148>
    80003860:	00001097          	auipc	ra,0x1
    80003864:	484080e7          	jalr	1156(ra) # 80004ce4 <_Z11printStringPKc>
    getString(input, 30);
    80003868:	01e00593          	li	a1,30
    8000386c:	00048513          	mv	a0,s1
    80003870:	00001097          	auipc	ra,0x1
    80003874:	4fc080e7          	jalr	1276(ra) # 80004d6c <_Z9getStringPci>
    n = stringToInt(input);
    80003878:	00048513          	mv	a0,s1
    8000387c:	00001097          	auipc	ra,0x1
    80003880:	5c8080e7          	jalr	1480(ra) # 80004e44 <_Z11stringToIntPKc>
    80003884:	00050493          	mv	s1,a0
    printString("Broj proizvodjaca ");
    80003888:	00006517          	auipc	a0,0x6
    8000388c:	8f050513          	addi	a0,a0,-1808 # 80009178 <CONSOLE_STATUS+0x168>
    80003890:	00001097          	auipc	ra,0x1
    80003894:	454080e7          	jalr	1108(ra) # 80004ce4 <_Z11printStringPKc>
    printInt(threadNum);
    80003898:	00000613          	li	a2,0
    8000389c:	00a00593          	li	a1,10
    800038a0:	00098513          	mv	a0,s3
    800038a4:	00001097          	auipc	ra,0x1
    800038a8:	5f0080e7          	jalr	1520(ra) # 80004e94 <_Z8printIntiii>
    printString(" i velicina bafera ");
    800038ac:	00006517          	auipc	a0,0x6
    800038b0:	8e450513          	addi	a0,a0,-1820 # 80009190 <CONSOLE_STATUS+0x180>
    800038b4:	00001097          	auipc	ra,0x1
    800038b8:	430080e7          	jalr	1072(ra) # 80004ce4 <_Z11printStringPKc>
    printInt(n);
    800038bc:	00000613          	li	a2,0
    800038c0:	00a00593          	li	a1,10
    800038c4:	00048513          	mv	a0,s1
    800038c8:	00001097          	auipc	ra,0x1
    800038cc:	5cc080e7          	jalr	1484(ra) # 80004e94 <_Z8printIntiii>
    printString(".\n");
    800038d0:	00006517          	auipc	a0,0x6
    800038d4:	8d850513          	addi	a0,a0,-1832 # 800091a8 <CONSOLE_STATUS+0x198>
    800038d8:	00001097          	auipc	ra,0x1
    800038dc:	40c080e7          	jalr	1036(ra) # 80004ce4 <_Z11printStringPKc>
    if (threadNum > n) {
    800038e0:	0334c463          	blt	s1,s3,80003908 <_Z20testConsumerProducerv+0x118>
    } else if (threadNum < 1) {
    800038e4:	03305c63          	blez	s3,8000391c <_Z20testConsumerProducerv+0x12c>
    BufferCPP *buffer = new BufferCPP(n);
    800038e8:	03800513          	li	a0,56
    800038ec:	ffffe097          	auipc	ra,0xffffe
    800038f0:	47c080e7          	jalr	1148(ra) # 80001d68 <_Znwm>
    800038f4:	00050a93          	mv	s5,a0
    800038f8:	00048593          	mv	a1,s1
    800038fc:	00001097          	auipc	ra,0x1
    80003900:	6b8080e7          	jalr	1720(ra) # 80004fb4 <_ZN9BufferCPPC1Ei>
    80003904:	0300006f          	j	80003934 <_Z20testConsumerProducerv+0x144>
        printString("Broj proizvodjaca ne sme biti manji od velicine bafera!\n");
    80003908:	00006517          	auipc	a0,0x6
    8000390c:	8a850513          	addi	a0,a0,-1880 # 800091b0 <CONSOLE_STATUS+0x1a0>
    80003910:	00001097          	auipc	ra,0x1
    80003914:	3d4080e7          	jalr	980(ra) # 80004ce4 <_Z11printStringPKc>
        return;
    80003918:	0140006f          	j	8000392c <_Z20testConsumerProducerv+0x13c>
        printString("Broj proizvodjaca mora biti veci od nula!\n");
    8000391c:	00006517          	auipc	a0,0x6
    80003920:	8d450513          	addi	a0,a0,-1836 # 800091f0 <CONSOLE_STATUS+0x1e0>
    80003924:	00001097          	auipc	ra,0x1
    80003928:	3c0080e7          	jalr	960(ra) # 80004ce4 <_Z11printStringPKc>
        return;
    8000392c:	000c0113          	mv	sp,s8
    80003930:	2780006f          	j	80003ba8 <_Z20testConsumerProducerv+0x3b8>
    waitForAll = new Semaphore(0);
    80003934:	01000513          	li	a0,16
    80003938:	ffffe097          	auipc	ra,0xffffe
    8000393c:	430080e7          	jalr	1072(ra) # 80001d68 <_Znwm>
    80003940:	00050913          	mv	s2,a0
        void (*body)(void*); void* arg;
};

class Semaphore {
        public:
        Semaphore (unsigned init = 1){
    80003944:	00007797          	auipc	a5,0x7
    80003948:	7a478793          	addi	a5,a5,1956 # 8000b0e8 <_ZTV9Semaphore+0x10>
    8000394c:	00f53023          	sd	a5,0(a0)
            sem_open(&myHandle,init);
    80003950:	00000593          	li	a1,0
    80003954:	00850513          	addi	a0,a0,8
    80003958:	ffffe097          	auipc	ra,0xffffe
    8000395c:	ae4080e7          	jalr	-1308(ra) # 8000143c <_Z8sem_openPP5sem_sj>
    80003960:	0000b797          	auipc	a5,0xb
    80003964:	db27b023          	sd	s2,-608(a5) # 8000e700 <_ZL10waitForAll>
    Thread *producers[threadNum];
    80003968:	00399793          	slli	a5,s3,0x3
    8000396c:	00f78793          	addi	a5,a5,15
    80003970:	ff07f793          	andi	a5,a5,-16
    80003974:	40f10133          	sub	sp,sp,a5
    80003978:	00010a13          	mv	s4,sp
    thread_data threadData[threadNum + 1];
    8000397c:	0019871b          	addiw	a4,s3,1
    80003980:	00171793          	slli	a5,a4,0x1
    80003984:	00e787b3          	add	a5,a5,a4
    80003988:	00379793          	slli	a5,a5,0x3
    8000398c:	00f78793          	addi	a5,a5,15
    80003990:	ff07f793          	andi	a5,a5,-16
    80003994:	40f10133          	sub	sp,sp,a5
    80003998:	00010b13          	mv	s6,sp
    threadData[threadNum].id = threadNum;
    8000399c:	00199493          	slli	s1,s3,0x1
    800039a0:	013484b3          	add	s1,s1,s3
    800039a4:	00349493          	slli	s1,s1,0x3
    800039a8:	009b04b3          	add	s1,s6,s1
    800039ac:	0134a023          	sw	s3,0(s1)
    threadData[threadNum].buffer = buffer;
    800039b0:	0154b423          	sd	s5,8(s1)
    threadData[threadNum].sem = waitForAll;
    800039b4:	0124b823          	sd	s2,16(s1)
    Thread *consumer = new Consumer(&threadData[threadNum]);
    800039b8:	02800513          	li	a0,40
    800039bc:	ffffe097          	auipc	ra,0xffffe
    800039c0:	3ac080e7          	jalr	940(ra) # 80001d68 <_Znwm>
    800039c4:	00050b93          	mv	s7,a0
            body= nullptr;
    800039c8:	00053823          	sd	zero,16(a0)
            arg= nullptr;
    800039cc:	00053c23          	sd	zero,24(a0)
    Consumer(thread_data *_td) : Thread(), td(_td) {}
    800039d0:	00007797          	auipc	a5,0x7
    800039d4:	78878793          	addi	a5,a5,1928 # 8000b158 <_ZTV8Consumer+0x10>
    800039d8:	00f53023          	sd	a5,0(a0)
    800039dc:	02953023          	sd	s1,32(a0)
            if(body== nullptr) return thread_create(&myHandle,&threadEntry, this);
    800039e0:	00050613          	mv	a2,a0
    800039e4:	ffffe597          	auipc	a1,0xffffe
    800039e8:	33058593          	addi	a1,a1,816 # 80001d14 <_ZN6Thread11threadEntryEPv>
    800039ec:	00850513          	addi	a0,a0,8
    800039f0:	ffffe097          	auipc	ra,0xffffe
    800039f4:	910080e7          	jalr	-1776(ra) # 80001300 <_Z13thread_createPP8thread_sPFvPvES2_>
    threadData[0].id = 0;
    800039f8:	000b2023          	sw	zero,0(s6)
    threadData[0].buffer = buffer;
    800039fc:	015b3423          	sd	s5,8(s6)
    threadData[0].sem = waitForAll;
    80003a00:	0000b797          	auipc	a5,0xb
    80003a04:	d007b783          	ld	a5,-768(a5) # 8000e700 <_ZL10waitForAll>
    80003a08:	00fb3823          	sd	a5,16(s6)
    producers[0] = new ProducerKeyborad(&threadData[0]);
    80003a0c:	02800513          	li	a0,40
    80003a10:	ffffe097          	auipc	ra,0xffffe
    80003a14:	358080e7          	jalr	856(ra) # 80001d68 <_Znwm>
            body= nullptr;
    80003a18:	00053823          	sd	zero,16(a0)
            arg= nullptr;
    80003a1c:	00053c23          	sd	zero,24(a0)
    ProducerKeyborad(thread_data *_td) : Thread(), td(_td) {}
    80003a20:	00007797          	auipc	a5,0x7
    80003a24:	6e878793          	addi	a5,a5,1768 # 8000b108 <_ZTV16ProducerKeyborad+0x10>
    80003a28:	00f53023          	sd	a5,0(a0)
    80003a2c:	03653023          	sd	s6,32(a0)
    producers[0] = new ProducerKeyborad(&threadData[0]);
    80003a30:	00aa3023          	sd	a0,0(s4)
            if(body== nullptr) return thread_create(&myHandle,&threadEntry, this);
    80003a34:	01053583          	ld	a1,16(a0)
    80003a38:	00058e63          	beqz	a1,80003a54 <_Z20testConsumerProducerv+0x264>
            else return thread_create(&myHandle,body,arg);
    80003a3c:	01853603          	ld	a2,24(a0)
    80003a40:	00850513          	addi	a0,a0,8
    80003a44:	ffffe097          	auipc	ra,0xffffe
    80003a48:	8bc080e7          	jalr	-1860(ra) # 80001300 <_Z13thread_createPP8thread_sPFvPvES2_>
    for (int i = 1; i < threadNum; i++) {
    80003a4c:	00100913          	li	s2,1
    80003a50:	03c0006f          	j	80003a8c <_Z20testConsumerProducerv+0x29c>
            if(body== nullptr) return thread_create(&myHandle,&threadEntry, this);
    80003a54:	00050613          	mv	a2,a0
    80003a58:	ffffe597          	auipc	a1,0xffffe
    80003a5c:	2bc58593          	addi	a1,a1,700 # 80001d14 <_ZN6Thread11threadEntryEPv>
    80003a60:	00850513          	addi	a0,a0,8
    80003a64:	ffffe097          	auipc	ra,0xffffe
    80003a68:	89c080e7          	jalr	-1892(ra) # 80001300 <_Z13thread_createPP8thread_sPFvPvES2_>
    80003a6c:	fe1ff06f          	j	80003a4c <_Z20testConsumerProducerv+0x25c>
    80003a70:	00050613          	mv	a2,a0
    80003a74:	ffffe597          	auipc	a1,0xffffe
    80003a78:	2a058593          	addi	a1,a1,672 # 80001d14 <_ZN6Thread11threadEntryEPv>
    80003a7c:	00850513          	addi	a0,a0,8
    80003a80:	ffffe097          	auipc	ra,0xffffe
    80003a84:	880080e7          	jalr	-1920(ra) # 80001300 <_Z13thread_createPP8thread_sPFvPvES2_>
    80003a88:	0019091b          	addiw	s2,s2,1
    80003a8c:	07395a63          	bge	s2,s3,80003b00 <_Z20testConsumerProducerv+0x310>
        threadData[i].id = i;
    80003a90:	00191493          	slli	s1,s2,0x1
    80003a94:	012484b3          	add	s1,s1,s2
    80003a98:	00349493          	slli	s1,s1,0x3
    80003a9c:	009b04b3          	add	s1,s6,s1
    80003aa0:	0124a023          	sw	s2,0(s1)
        threadData[i].buffer = buffer;
    80003aa4:	0154b423          	sd	s5,8(s1)
        threadData[i].sem = waitForAll;
    80003aa8:	0000b797          	auipc	a5,0xb
    80003aac:	c587b783          	ld	a5,-936(a5) # 8000e700 <_ZL10waitForAll>
    80003ab0:	00f4b823          	sd	a5,16(s1)
        producers[i] = new Producer(&threadData[i]);
    80003ab4:	02800513          	li	a0,40
    80003ab8:	ffffe097          	auipc	ra,0xffffe
    80003abc:	2b0080e7          	jalr	688(ra) # 80001d68 <_Znwm>
            body= nullptr;
    80003ac0:	00053823          	sd	zero,16(a0)
            arg= nullptr;
    80003ac4:	00053c23          	sd	zero,24(a0)
    Producer(thread_data *_td) : Thread(), td(_td) {}
    80003ac8:	00007797          	auipc	a5,0x7
    80003acc:	66878793          	addi	a5,a5,1640 # 8000b130 <_ZTV8Producer+0x10>
    80003ad0:	00f53023          	sd	a5,0(a0)
    80003ad4:	02953023          	sd	s1,32(a0)
        producers[i] = new Producer(&threadData[i]);
    80003ad8:	00391793          	slli	a5,s2,0x3
    80003adc:	00fa07b3          	add	a5,s4,a5
    80003ae0:	00a7b023          	sd	a0,0(a5)
            if(body== nullptr) return thread_create(&myHandle,&threadEntry, this);
    80003ae4:	01053583          	ld	a1,16(a0)
    80003ae8:	f80584e3          	beqz	a1,80003a70 <_Z20testConsumerProducerv+0x280>
            else return thread_create(&myHandle,body,arg);
    80003aec:	01853603          	ld	a2,24(a0)
    80003af0:	00850513          	addi	a0,a0,8
    80003af4:	ffffe097          	auipc	ra,0xffffe
    80003af8:	80c080e7          	jalr	-2036(ra) # 80001300 <_Z13thread_createPP8thread_sPFvPvES2_>
    80003afc:	f8dff06f          	j	80003a88 <_Z20testConsumerProducerv+0x298>
            thread_dispatch();
    80003b00:	ffffe097          	auipc	ra,0xffffe
    80003b04:	888080e7          	jalr	-1912(ra) # 80001388 <_Z15thread_dispatchv>
    for (int i = 0; i <= threadNum; i++) {
    80003b08:	00000493          	li	s1,0
    80003b0c:	0299c063          	blt	s3,s1,80003b2c <_Z20testConsumerProducerv+0x33c>
        }
        virtual ~Semaphore (){
            sem_close(myHandle);
        }
        int wait (){
            return sem_wait(myHandle);
    80003b10:	0000b797          	auipc	a5,0xb
    80003b14:	bf07b783          	ld	a5,-1040(a5) # 8000e700 <_ZL10waitForAll>
    80003b18:	0087b503          	ld	a0,8(a5)
    80003b1c:	ffffe097          	auipc	ra,0xffffe
    80003b20:	9a4080e7          	jalr	-1628(ra) # 800014c0 <_Z8sem_waitP5sem_s>
    80003b24:	0014849b          	addiw	s1,s1,1
    80003b28:	fe5ff06f          	j	80003b0c <_Z20testConsumerProducerv+0x31c>
    delete waitForAll;
    80003b2c:	0000b517          	auipc	a0,0xb
    80003b30:	bd453503          	ld	a0,-1068(a0) # 8000e700 <_ZL10waitForAll>
    80003b34:	00050863          	beqz	a0,80003b44 <_Z20testConsumerProducerv+0x354>
    80003b38:	00053783          	ld	a5,0(a0)
    80003b3c:	0087b783          	ld	a5,8(a5)
    80003b40:	000780e7          	jalr	a5
    for (int i = 0; i <= threadNum; i++) {
    80003b44:	00000493          	li	s1,0
    80003b48:	0080006f          	j	80003b50 <_Z20testConsumerProducerv+0x360>
    for (int i = 0; i < threadNum; i++) {
    80003b4c:	0014849b          	addiw	s1,s1,1
    80003b50:	0334d263          	bge	s1,s3,80003b74 <_Z20testConsumerProducerv+0x384>
        delete producers[i];
    80003b54:	00349793          	slli	a5,s1,0x3
    80003b58:	00fa07b3          	add	a5,s4,a5
    80003b5c:	0007b503          	ld	a0,0(a5)
    80003b60:	fe0506e3          	beqz	a0,80003b4c <_Z20testConsumerProducerv+0x35c>
    80003b64:	00053783          	ld	a5,0(a0)
    80003b68:	0087b783          	ld	a5,8(a5)
    80003b6c:	000780e7          	jalr	a5
    80003b70:	fddff06f          	j	80003b4c <_Z20testConsumerProducerv+0x35c>
    delete consumer;
    80003b74:	000b8a63          	beqz	s7,80003b88 <_Z20testConsumerProducerv+0x398>
    80003b78:	000bb783          	ld	a5,0(s7)
    80003b7c:	0087b783          	ld	a5,8(a5)
    80003b80:	000b8513          	mv	a0,s7
    80003b84:	000780e7          	jalr	a5
    delete buffer;
    80003b88:	000a8e63          	beqz	s5,80003ba4 <_Z20testConsumerProducerv+0x3b4>
    80003b8c:	000a8513          	mv	a0,s5
    80003b90:	00001097          	auipc	ra,0x1
    80003b94:	78c080e7          	jalr	1932(ra) # 8000531c <_ZN9BufferCPPD1Ev>
    80003b98:	000a8513          	mv	a0,s5
    80003b9c:	ffffe097          	auipc	ra,0xffffe
    80003ba0:	1f4080e7          	jalr	500(ra) # 80001d90 <_ZdlPv>
    80003ba4:	000c0113          	mv	sp,s8
}
    80003ba8:	f9040113          	addi	sp,s0,-112
    80003bac:	06813083          	ld	ra,104(sp)
    80003bb0:	06013403          	ld	s0,96(sp)
    80003bb4:	05813483          	ld	s1,88(sp)
    80003bb8:	05013903          	ld	s2,80(sp)
    80003bbc:	04813983          	ld	s3,72(sp)
    80003bc0:	04013a03          	ld	s4,64(sp)
    80003bc4:	03813a83          	ld	s5,56(sp)
    80003bc8:	03013b03          	ld	s6,48(sp)
    80003bcc:	02813b83          	ld	s7,40(sp)
    80003bd0:	02013c03          	ld	s8,32(sp)
    80003bd4:	07010113          	addi	sp,sp,112
    80003bd8:	00008067          	ret
    80003bdc:	00050493          	mv	s1,a0
    BufferCPP *buffer = new BufferCPP(n);
    80003be0:	000a8513          	mv	a0,s5
    80003be4:	ffffe097          	auipc	ra,0xffffe
    80003be8:	1ac080e7          	jalr	428(ra) # 80001d90 <_ZdlPv>
    80003bec:	00048513          	mv	a0,s1
    80003bf0:	0000c097          	auipc	ra,0xc
    80003bf4:	c08080e7          	jalr	-1016(ra) # 8000f7f8 <_Unwind_Resume>
    80003bf8:	00050493          	mv	s1,a0
    waitForAll = new Semaphore(0);
    80003bfc:	00090513          	mv	a0,s2
    80003c00:	ffffe097          	auipc	ra,0xffffe
    80003c04:	190080e7          	jalr	400(ra) # 80001d90 <_ZdlPv>
    80003c08:	00048513          	mv	a0,s1
    80003c0c:	0000c097          	auipc	ra,0xc
    80003c10:	bec080e7          	jalr	-1044(ra) # 8000f7f8 <_Unwind_Resume>

0000000080003c14 <_ZN8ConsumerD1Ev>:
class Consumer : public Thread {
    80003c14:	ff010113          	addi	sp,sp,-16
    80003c18:	00813423          	sd	s0,8(sp)
    80003c1c:	01010413          	addi	s0,sp,16
    80003c20:	00813403          	ld	s0,8(sp)
    80003c24:	01010113          	addi	sp,sp,16
    80003c28:	00008067          	ret

0000000080003c2c <_ZN8ProducerD1Ev>:
class Producer : public Thread {
    80003c2c:	ff010113          	addi	sp,sp,-16
    80003c30:	00813423          	sd	s0,8(sp)
    80003c34:	01010413          	addi	s0,sp,16
    80003c38:	00813403          	ld	s0,8(sp)
    80003c3c:	01010113          	addi	sp,sp,16
    80003c40:	00008067          	ret

0000000080003c44 <_ZN16ProducerKeyboradD1Ev>:
class ProducerKeyborad : public Thread {
    80003c44:	ff010113          	addi	sp,sp,-16
    80003c48:	00813423          	sd	s0,8(sp)
    80003c4c:	01010413          	addi	s0,sp,16
    80003c50:	00813403          	ld	s0,8(sp)
    80003c54:	01010113          	addi	sp,sp,16
    80003c58:	00008067          	ret

0000000080003c5c <_ZN8ConsumerD0Ev>:
class Consumer : public Thread {
    80003c5c:	ff010113          	addi	sp,sp,-16
    80003c60:	00113423          	sd	ra,8(sp)
    80003c64:	00813023          	sd	s0,0(sp)
    80003c68:	01010413          	addi	s0,sp,16
    80003c6c:	ffffe097          	auipc	ra,0xffffe
    80003c70:	124080e7          	jalr	292(ra) # 80001d90 <_ZdlPv>
    80003c74:	00813083          	ld	ra,8(sp)
    80003c78:	00013403          	ld	s0,0(sp)
    80003c7c:	01010113          	addi	sp,sp,16
    80003c80:	00008067          	ret

0000000080003c84 <_ZN16ProducerKeyboradD0Ev>:
class ProducerKeyborad : public Thread {
    80003c84:	ff010113          	addi	sp,sp,-16
    80003c88:	00113423          	sd	ra,8(sp)
    80003c8c:	00813023          	sd	s0,0(sp)
    80003c90:	01010413          	addi	s0,sp,16
    80003c94:	ffffe097          	auipc	ra,0xffffe
    80003c98:	0fc080e7          	jalr	252(ra) # 80001d90 <_ZdlPv>
    80003c9c:	00813083          	ld	ra,8(sp)
    80003ca0:	00013403          	ld	s0,0(sp)
    80003ca4:	01010113          	addi	sp,sp,16
    80003ca8:	00008067          	ret

0000000080003cac <_ZN8ProducerD0Ev>:
class Producer : public Thread {
    80003cac:	ff010113          	addi	sp,sp,-16
    80003cb0:	00113423          	sd	ra,8(sp)
    80003cb4:	00813023          	sd	s0,0(sp)
    80003cb8:	01010413          	addi	s0,sp,16
    80003cbc:	ffffe097          	auipc	ra,0xffffe
    80003cc0:	0d4080e7          	jalr	212(ra) # 80001d90 <_ZdlPv>
    80003cc4:	00813083          	ld	ra,8(sp)
    80003cc8:	00013403          	ld	s0,0(sp)
    80003ccc:	01010113          	addi	sp,sp,16
    80003cd0:	00008067          	ret

0000000080003cd4 <_ZN9SemaphoreD1Ev>:
        virtual ~Semaphore (){
    80003cd4:	ff010113          	addi	sp,sp,-16
    80003cd8:	00113423          	sd	ra,8(sp)
    80003cdc:	00813023          	sd	s0,0(sp)
    80003ce0:	01010413          	addi	s0,sp,16
    80003ce4:	00007797          	auipc	a5,0x7
    80003ce8:	40478793          	addi	a5,a5,1028 # 8000b0e8 <_ZTV9Semaphore+0x10>
    80003cec:	00f53023          	sd	a5,0(a0)
            sem_close(myHandle);
    80003cf0:	00853503          	ld	a0,8(a0)
    80003cf4:	ffffd097          	auipc	ra,0xffffd
    80003cf8:	78c080e7          	jalr	1932(ra) # 80001480 <_Z9sem_closeP5sem_s>
        }
    80003cfc:	00813083          	ld	ra,8(sp)
    80003d00:	00013403          	ld	s0,0(sp)
    80003d04:	01010113          	addi	sp,sp,16
    80003d08:	00008067          	ret

0000000080003d0c <_ZN9SemaphoreD0Ev>:
        virtual ~Semaphore (){
    80003d0c:	fe010113          	addi	sp,sp,-32
    80003d10:	00113c23          	sd	ra,24(sp)
    80003d14:	00813823          	sd	s0,16(sp)
    80003d18:	00913423          	sd	s1,8(sp)
    80003d1c:	02010413          	addi	s0,sp,32
    80003d20:	00050493          	mv	s1,a0
    80003d24:	00007797          	auipc	a5,0x7
    80003d28:	3c478793          	addi	a5,a5,964 # 8000b0e8 <_ZTV9Semaphore+0x10>
    80003d2c:	00f53023          	sd	a5,0(a0)
            sem_close(myHandle);
    80003d30:	00853503          	ld	a0,8(a0)
    80003d34:	ffffd097          	auipc	ra,0xffffd
    80003d38:	74c080e7          	jalr	1868(ra) # 80001480 <_Z9sem_closeP5sem_s>
        }
    80003d3c:	00048513          	mv	a0,s1
    80003d40:	ffffe097          	auipc	ra,0xffffe
    80003d44:	050080e7          	jalr	80(ra) # 80001d90 <_ZdlPv>
    80003d48:	01813083          	ld	ra,24(sp)
    80003d4c:	01013403          	ld	s0,16(sp)
    80003d50:	00813483          	ld	s1,8(sp)
    80003d54:	02010113          	addi	sp,sp,32
    80003d58:	00008067          	ret

0000000080003d5c <_ZN8Consumer3runEv>:
    void run() override {
    80003d5c:	fd010113          	addi	sp,sp,-48
    80003d60:	02113423          	sd	ra,40(sp)
    80003d64:	02813023          	sd	s0,32(sp)
    80003d68:	00913c23          	sd	s1,24(sp)
    80003d6c:	01213823          	sd	s2,16(sp)
    80003d70:	01313423          	sd	s3,8(sp)
    80003d74:	03010413          	addi	s0,sp,48
    80003d78:	00050913          	mv	s2,a0
        int i = 0;
    80003d7c:	00000993          	li	s3,0
    80003d80:	0100006f          	j	80003d90 <_ZN8Consumer3runEv+0x34>
        public:
        static char getc (){
            return ::getc();
        }
        static void putc (char c){
            ::putc(c);
    80003d84:	00a00513          	li	a0,10
    80003d88:	00004097          	auipc	ra,0x4
    80003d8c:	2e4080e7          	jalr	740(ra) # 8000806c <__putc>
        while (!threadEnd) {
    80003d90:	0000b797          	auipc	a5,0xb
    80003d94:	9687a783          	lw	a5,-1688(a5) # 8000e6f8 <_ZL9threadEnd>
    80003d98:	04079a63          	bnez	a5,80003dec <_ZN8Consumer3runEv+0x90>
            int key = td->buffer->get();
    80003d9c:	02093783          	ld	a5,32(s2)
    80003da0:	0087b503          	ld	a0,8(a5)
    80003da4:	00001097          	auipc	ra,0x1
    80003da8:	444080e7          	jalr	1092(ra) # 800051e8 <_ZN9BufferCPP3getEv>
            i++;
    80003dac:	0019849b          	addiw	s1,s3,1
    80003db0:	0004899b          	sext.w	s3,s1
    80003db4:	0ff57513          	andi	a0,a0,255
    80003db8:	00004097          	auipc	ra,0x4
    80003dbc:	2b4080e7          	jalr	692(ra) # 8000806c <__putc>
            if (i % 80 == 0) {
    80003dc0:	05000793          	li	a5,80
    80003dc4:	02f4e4bb          	remw	s1,s1,a5
    80003dc8:	fc0494e3          	bnez	s1,80003d90 <_ZN8Consumer3runEv+0x34>
    80003dcc:	fb9ff06f          	j	80003d84 <_ZN8Consumer3runEv+0x28>
            int key = td->buffer->get();
    80003dd0:	02093783          	ld	a5,32(s2)
    80003dd4:	0087b503          	ld	a0,8(a5)
    80003dd8:	00001097          	auipc	ra,0x1
    80003ddc:	410080e7          	jalr	1040(ra) # 800051e8 <_ZN9BufferCPP3getEv>
    80003de0:	0ff57513          	andi	a0,a0,255
    80003de4:	00004097          	auipc	ra,0x4
    80003de8:	288080e7          	jalr	648(ra) # 8000806c <__putc>
        while (td->buffer->getCnt() > 0) {
    80003dec:	02093783          	ld	a5,32(s2)
    80003df0:	0087b503          	ld	a0,8(a5)
    80003df4:	00001097          	auipc	ra,0x1
    80003df8:	490080e7          	jalr	1168(ra) # 80005284 <_ZN9BufferCPP6getCntEv>
    80003dfc:	fca04ae3          	bgtz	a0,80003dd0 <_ZN8Consumer3runEv+0x74>
        td->sem->signal();
    80003e00:	02093783          	ld	a5,32(s2)
    80003e04:	0107b783          	ld	a5,16(a5)
            return sem_signal(myHandle);
    80003e08:	0087b503          	ld	a0,8(a5)
    80003e0c:	ffffd097          	auipc	ra,0xffffd
    80003e10:	6f4080e7          	jalr	1780(ra) # 80001500 <_Z10sem_signalP5sem_s>
    }
    80003e14:	02813083          	ld	ra,40(sp)
    80003e18:	02013403          	ld	s0,32(sp)
    80003e1c:	01813483          	ld	s1,24(sp)
    80003e20:	01013903          	ld	s2,16(sp)
    80003e24:	00813983          	ld	s3,8(sp)
    80003e28:	03010113          	addi	sp,sp,48
    80003e2c:	00008067          	ret

0000000080003e30 <_ZN16ProducerKeyborad3runEv>:
    void run() override {
    80003e30:	fe010113          	addi	sp,sp,-32
    80003e34:	00113c23          	sd	ra,24(sp)
    80003e38:	00813823          	sd	s0,16(sp)
    80003e3c:	00913423          	sd	s1,8(sp)
    80003e40:	02010413          	addi	s0,sp,32
    80003e44:	00050493          	mv	s1,a0
        while ((key = getc()) != 13) {
    80003e48:	ffffd097          	auipc	ra,0xffffd
    80003e4c:	72c080e7          	jalr	1836(ra) # 80001574 <_Z4getcv>
    80003e50:	0005059b          	sext.w	a1,a0
    80003e54:	00d00793          	li	a5,13
    80003e58:	00f58c63          	beq	a1,a5,80003e70 <_ZN16ProducerKeyborad3runEv+0x40>
            td->buffer->put(key);
    80003e5c:	0204b783          	ld	a5,32(s1)
    80003e60:	0087b503          	ld	a0,8(a5)
    80003e64:	00001097          	auipc	ra,0x1
    80003e68:	2e4080e7          	jalr	740(ra) # 80005148 <_ZN9BufferCPP3putEi>
        while ((key = getc()) != 13) {
    80003e6c:	fddff06f          	j	80003e48 <_ZN16ProducerKeyborad3runEv+0x18>
        threadEnd = 1;
    80003e70:	00100793          	li	a5,1
    80003e74:	0000b717          	auipc	a4,0xb
    80003e78:	88f72223          	sw	a5,-1916(a4) # 8000e6f8 <_ZL9threadEnd>
        td->buffer->put('!');
    80003e7c:	0204b783          	ld	a5,32(s1)
    80003e80:	02100593          	li	a1,33
    80003e84:	0087b503          	ld	a0,8(a5)
    80003e88:	00001097          	auipc	ra,0x1
    80003e8c:	2c0080e7          	jalr	704(ra) # 80005148 <_ZN9BufferCPP3putEi>
        td->sem->signal();
    80003e90:	0204b783          	ld	a5,32(s1)
    80003e94:	0107b783          	ld	a5,16(a5)
    80003e98:	0087b503          	ld	a0,8(a5)
    80003e9c:	ffffd097          	auipc	ra,0xffffd
    80003ea0:	664080e7          	jalr	1636(ra) # 80001500 <_Z10sem_signalP5sem_s>
    }
    80003ea4:	01813083          	ld	ra,24(sp)
    80003ea8:	01013403          	ld	s0,16(sp)
    80003eac:	00813483          	ld	s1,8(sp)
    80003eb0:	02010113          	addi	sp,sp,32
    80003eb4:	00008067          	ret

0000000080003eb8 <_ZN8Producer3runEv>:
    void run() override {
    80003eb8:	fe010113          	addi	sp,sp,-32
    80003ebc:	00113c23          	sd	ra,24(sp)
    80003ec0:	00813823          	sd	s0,16(sp)
    80003ec4:	00913423          	sd	s1,8(sp)
    80003ec8:	01213023          	sd	s2,0(sp)
    80003ecc:	02010413          	addi	s0,sp,32
    80003ed0:	00050493          	mv	s1,a0
        int i = 0;
    80003ed4:	00000913          	li	s2,0
        while (!threadEnd) {
    80003ed8:	0000b797          	auipc	a5,0xb
    80003edc:	8207a783          	lw	a5,-2016(a5) # 8000e6f8 <_ZL9threadEnd>
    80003ee0:	04079263          	bnez	a5,80003f24 <_ZN8Producer3runEv+0x6c>
            td->buffer->put(td->id + '0');
    80003ee4:	0204b783          	ld	a5,32(s1)
    80003ee8:	0007a583          	lw	a1,0(a5)
    80003eec:	0305859b          	addiw	a1,a1,48
    80003ef0:	0087b503          	ld	a0,8(a5)
    80003ef4:	00001097          	auipc	ra,0x1
    80003ef8:	254080e7          	jalr	596(ra) # 80005148 <_ZN9BufferCPP3putEi>
            i++;
    80003efc:	0019071b          	addiw	a4,s2,1
    80003f00:	0007091b          	sext.w	s2,a4
            Thread::sleep((i + td->id) % 5);
    80003f04:	0204b783          	ld	a5,32(s1)
    80003f08:	0007a783          	lw	a5,0(a5)
    80003f0c:	00e787bb          	addw	a5,a5,a4
            return time_sleep(time);
    80003f10:	00500513          	li	a0,5
    80003f14:	02a7e53b          	remw	a0,a5,a0
    80003f18:	ffffd097          	auipc	ra,0xffffd
    80003f1c:	628080e7          	jalr	1576(ra) # 80001540 <_Z10time_sleepm>
    80003f20:	fb9ff06f          	j	80003ed8 <_ZN8Producer3runEv+0x20>
        td->sem->signal();
    80003f24:	0204b783          	ld	a5,32(s1)
    80003f28:	0107b783          	ld	a5,16(a5)
            return sem_signal(myHandle);
    80003f2c:	0087b503          	ld	a0,8(a5)
    80003f30:	ffffd097          	auipc	ra,0xffffd
    80003f34:	5d0080e7          	jalr	1488(ra) # 80001500 <_Z10sem_signalP5sem_s>
    }
    80003f38:	01813083          	ld	ra,24(sp)
    80003f3c:	01013403          	ld	s0,16(sp)
    80003f40:	00813483          	ld	s1,8(sp)
    80003f44:	00013903          	ld	s2,0(sp)
    80003f48:	02010113          	addi	sp,sp,32
    80003f4c:	00008067          	ret

0000000080003f50 <_ZL9fibonaccim>:
static volatile bool finishedA = false;
static volatile bool finishedB = false;
static volatile bool finishedC = false;
static volatile bool finishedD = false;

static uint64 fibonacci(uint64 n) {
    80003f50:	fe010113          	addi	sp,sp,-32
    80003f54:	00113c23          	sd	ra,24(sp)
    80003f58:	00813823          	sd	s0,16(sp)
    80003f5c:	00913423          	sd	s1,8(sp)
    80003f60:	01213023          	sd	s2,0(sp)
    80003f64:	02010413          	addi	s0,sp,32
    80003f68:	00050493          	mv	s1,a0
    if (n == 0 || n == 1) { return n; }
    80003f6c:	00100793          	li	a5,1
    80003f70:	02a7f863          	bgeu	a5,a0,80003fa0 <_ZL9fibonaccim+0x50>
    if (n % 10 == 0) { thread_dispatch(); }
    80003f74:	00a00793          	li	a5,10
    80003f78:	02f577b3          	remu	a5,a0,a5
    80003f7c:	02078e63          	beqz	a5,80003fb8 <_ZL9fibonaccim+0x68>
    return fibonacci(n - 1) + fibonacci(n - 2);
    80003f80:	fff48513          	addi	a0,s1,-1
    80003f84:	00000097          	auipc	ra,0x0
    80003f88:	fcc080e7          	jalr	-52(ra) # 80003f50 <_ZL9fibonaccim>
    80003f8c:	00050913          	mv	s2,a0
    80003f90:	ffe48513          	addi	a0,s1,-2
    80003f94:	00000097          	auipc	ra,0x0
    80003f98:	fbc080e7          	jalr	-68(ra) # 80003f50 <_ZL9fibonaccim>
    80003f9c:	00a90533          	add	a0,s2,a0
}
    80003fa0:	01813083          	ld	ra,24(sp)
    80003fa4:	01013403          	ld	s0,16(sp)
    80003fa8:	00813483          	ld	s1,8(sp)
    80003fac:	00013903          	ld	s2,0(sp)
    80003fb0:	02010113          	addi	sp,sp,32
    80003fb4:	00008067          	ret
    if (n % 10 == 0) { thread_dispatch(); }
    80003fb8:	ffffd097          	auipc	ra,0xffffd
    80003fbc:	3d0080e7          	jalr	976(ra) # 80001388 <_Z15thread_dispatchv>
    80003fc0:	fc1ff06f          	j	80003f80 <_ZL9fibonaccim+0x30>

0000000080003fc4 <_ZL11workerBodyDPv>:
    printString("A finished!\n");
    finishedC = true;
    thread_dispatch();
}

static void workerBodyD(void* arg) {
    80003fc4:	fe010113          	addi	sp,sp,-32
    80003fc8:	00113c23          	sd	ra,24(sp)
    80003fcc:	00813823          	sd	s0,16(sp)
    80003fd0:	00913423          	sd	s1,8(sp)
    80003fd4:	01213023          	sd	s2,0(sp)
    80003fd8:	02010413          	addi	s0,sp,32
    uint8 i = 10;
    80003fdc:	00a00493          	li	s1,10
    80003fe0:	0400006f          	j	80004020 <_ZL11workerBodyDPv+0x5c>
    for (; i < 13; i++) {
        printString("D: i="); printInt(i); printString("\n");
    80003fe4:	00005517          	auipc	a0,0x5
    80003fe8:	29c50513          	addi	a0,a0,668 # 80009280 <CONSOLE_STATUS+0x270>
    80003fec:	00001097          	auipc	ra,0x1
    80003ff0:	cf8080e7          	jalr	-776(ra) # 80004ce4 <_Z11printStringPKc>
    80003ff4:	00000613          	li	a2,0
    80003ff8:	00a00593          	li	a1,10
    80003ffc:	00048513          	mv	a0,s1
    80004000:	00001097          	auipc	ra,0x1
    80004004:	e94080e7          	jalr	-364(ra) # 80004e94 <_Z8printIntiii>
    80004008:	00005517          	auipc	a0,0x5
    8000400c:	46850513          	addi	a0,a0,1128 # 80009470 <CONSOLE_STATUS+0x460>
    80004010:	00001097          	auipc	ra,0x1
    80004014:	cd4080e7          	jalr	-812(ra) # 80004ce4 <_Z11printStringPKc>
    for (; i < 13; i++) {
    80004018:	0014849b          	addiw	s1,s1,1
    8000401c:	0ff4f493          	andi	s1,s1,255
    80004020:	00c00793          	li	a5,12
    80004024:	fc97f0e3          	bgeu	a5,s1,80003fe4 <_ZL11workerBodyDPv+0x20>
    }

    printString("D: dispatch\n");
    80004028:	00005517          	auipc	a0,0x5
    8000402c:	26050513          	addi	a0,a0,608 # 80009288 <CONSOLE_STATUS+0x278>
    80004030:	00001097          	auipc	ra,0x1
    80004034:	cb4080e7          	jalr	-844(ra) # 80004ce4 <_Z11printStringPKc>
    __asm__ ("li t1, 5");
    80004038:	00500313          	li	t1,5
    thread_dispatch();
    8000403c:	ffffd097          	auipc	ra,0xffffd
    80004040:	34c080e7          	jalr	844(ra) # 80001388 <_Z15thread_dispatchv>

    uint64 result = fibonacci(16);
    80004044:	01000513          	li	a0,16
    80004048:	00000097          	auipc	ra,0x0
    8000404c:	f08080e7          	jalr	-248(ra) # 80003f50 <_ZL9fibonaccim>
    80004050:	00050913          	mv	s2,a0
    printString("D: fibonaci="); printInt(result); printString("\n");
    80004054:	00005517          	auipc	a0,0x5
    80004058:	24450513          	addi	a0,a0,580 # 80009298 <CONSOLE_STATUS+0x288>
    8000405c:	00001097          	auipc	ra,0x1
    80004060:	c88080e7          	jalr	-888(ra) # 80004ce4 <_Z11printStringPKc>
    80004064:	00000613          	li	a2,0
    80004068:	00a00593          	li	a1,10
    8000406c:	0009051b          	sext.w	a0,s2
    80004070:	00001097          	auipc	ra,0x1
    80004074:	e24080e7          	jalr	-476(ra) # 80004e94 <_Z8printIntiii>
    80004078:	00005517          	auipc	a0,0x5
    8000407c:	3f850513          	addi	a0,a0,1016 # 80009470 <CONSOLE_STATUS+0x460>
    80004080:	00001097          	auipc	ra,0x1
    80004084:	c64080e7          	jalr	-924(ra) # 80004ce4 <_Z11printStringPKc>
    80004088:	0400006f          	j	800040c8 <_ZL11workerBodyDPv+0x104>

    for (; i < 16; i++) {
        printString("D: i="); printInt(i); printString("\n");
    8000408c:	00005517          	auipc	a0,0x5
    80004090:	1f450513          	addi	a0,a0,500 # 80009280 <CONSOLE_STATUS+0x270>
    80004094:	00001097          	auipc	ra,0x1
    80004098:	c50080e7          	jalr	-944(ra) # 80004ce4 <_Z11printStringPKc>
    8000409c:	00000613          	li	a2,0
    800040a0:	00a00593          	li	a1,10
    800040a4:	00048513          	mv	a0,s1
    800040a8:	00001097          	auipc	ra,0x1
    800040ac:	dec080e7          	jalr	-532(ra) # 80004e94 <_Z8printIntiii>
    800040b0:	00005517          	auipc	a0,0x5
    800040b4:	3c050513          	addi	a0,a0,960 # 80009470 <CONSOLE_STATUS+0x460>
    800040b8:	00001097          	auipc	ra,0x1
    800040bc:	c2c080e7          	jalr	-980(ra) # 80004ce4 <_Z11printStringPKc>
    for (; i < 16; i++) {
    800040c0:	0014849b          	addiw	s1,s1,1
    800040c4:	0ff4f493          	andi	s1,s1,255
    800040c8:	00f00793          	li	a5,15
    800040cc:	fc97f0e3          	bgeu	a5,s1,8000408c <_ZL11workerBodyDPv+0xc8>
    }

    printString("D finished!\n");
    800040d0:	00005517          	auipc	a0,0x5
    800040d4:	1d850513          	addi	a0,a0,472 # 800092a8 <CONSOLE_STATUS+0x298>
    800040d8:	00001097          	auipc	ra,0x1
    800040dc:	c0c080e7          	jalr	-1012(ra) # 80004ce4 <_Z11printStringPKc>
    finishedD = true;
    800040e0:	00100793          	li	a5,1
    800040e4:	0000a717          	auipc	a4,0xa
    800040e8:	62f70223          	sb	a5,1572(a4) # 8000e708 <_ZL9finishedD>
    thread_dispatch();
    800040ec:	ffffd097          	auipc	ra,0xffffd
    800040f0:	29c080e7          	jalr	668(ra) # 80001388 <_Z15thread_dispatchv>
}
    800040f4:	01813083          	ld	ra,24(sp)
    800040f8:	01013403          	ld	s0,16(sp)
    800040fc:	00813483          	ld	s1,8(sp)
    80004100:	00013903          	ld	s2,0(sp)
    80004104:	02010113          	addi	sp,sp,32
    80004108:	00008067          	ret

000000008000410c <_ZL11workerBodyCPv>:
static void workerBodyC(void* arg) {
    8000410c:	fe010113          	addi	sp,sp,-32
    80004110:	00113c23          	sd	ra,24(sp)
    80004114:	00813823          	sd	s0,16(sp)
    80004118:	00913423          	sd	s1,8(sp)
    8000411c:	01213023          	sd	s2,0(sp)
    80004120:	02010413          	addi	s0,sp,32
    uint8 i = 0;
    80004124:	00000493          	li	s1,0
    80004128:	0400006f          	j	80004168 <_ZL11workerBodyCPv+0x5c>
        printString("C: i="); printInt(i); printString("\n");
    8000412c:	00005517          	auipc	a0,0x5
    80004130:	12450513          	addi	a0,a0,292 # 80009250 <CONSOLE_STATUS+0x240>
    80004134:	00001097          	auipc	ra,0x1
    80004138:	bb0080e7          	jalr	-1104(ra) # 80004ce4 <_Z11printStringPKc>
    8000413c:	00000613          	li	a2,0
    80004140:	00a00593          	li	a1,10
    80004144:	00048513          	mv	a0,s1
    80004148:	00001097          	auipc	ra,0x1
    8000414c:	d4c080e7          	jalr	-692(ra) # 80004e94 <_Z8printIntiii>
    80004150:	00005517          	auipc	a0,0x5
    80004154:	32050513          	addi	a0,a0,800 # 80009470 <CONSOLE_STATUS+0x460>
    80004158:	00001097          	auipc	ra,0x1
    8000415c:	b8c080e7          	jalr	-1140(ra) # 80004ce4 <_Z11printStringPKc>
    for (; i < 3; i++) {
    80004160:	0014849b          	addiw	s1,s1,1
    80004164:	0ff4f493          	andi	s1,s1,255
    80004168:	00200793          	li	a5,2
    8000416c:	fc97f0e3          	bgeu	a5,s1,8000412c <_ZL11workerBodyCPv+0x20>
    printString("C: dispatch\n");
    80004170:	00005517          	auipc	a0,0x5
    80004174:	0e850513          	addi	a0,a0,232 # 80009258 <CONSOLE_STATUS+0x248>
    80004178:	00001097          	auipc	ra,0x1
    8000417c:	b6c080e7          	jalr	-1172(ra) # 80004ce4 <_Z11printStringPKc>
    __asm__ ("li t1, 7");
    80004180:	00700313          	li	t1,7
    thread_dispatch();
    80004184:	ffffd097          	auipc	ra,0xffffd
    80004188:	204080e7          	jalr	516(ra) # 80001388 <_Z15thread_dispatchv>
    __asm__ ("mv %[t1], t1" : [t1] "=r"(t1));
    8000418c:	00030913          	mv	s2,t1
    printString("C: t1="); printInt(t1); printString("\n");
    80004190:	00005517          	auipc	a0,0x5
    80004194:	0d850513          	addi	a0,a0,216 # 80009268 <CONSOLE_STATUS+0x258>
    80004198:	00001097          	auipc	ra,0x1
    8000419c:	b4c080e7          	jalr	-1204(ra) # 80004ce4 <_Z11printStringPKc>
    800041a0:	00000613          	li	a2,0
    800041a4:	00a00593          	li	a1,10
    800041a8:	0009051b          	sext.w	a0,s2
    800041ac:	00001097          	auipc	ra,0x1
    800041b0:	ce8080e7          	jalr	-792(ra) # 80004e94 <_Z8printIntiii>
    800041b4:	00005517          	auipc	a0,0x5
    800041b8:	2bc50513          	addi	a0,a0,700 # 80009470 <CONSOLE_STATUS+0x460>
    800041bc:	00001097          	auipc	ra,0x1
    800041c0:	b28080e7          	jalr	-1240(ra) # 80004ce4 <_Z11printStringPKc>
    uint64 result = fibonacci(12);
    800041c4:	00c00513          	li	a0,12
    800041c8:	00000097          	auipc	ra,0x0
    800041cc:	d88080e7          	jalr	-632(ra) # 80003f50 <_ZL9fibonaccim>
    800041d0:	00050913          	mv	s2,a0
    printString("C: fibonaci="); printInt(result); printString("\n");
    800041d4:	00005517          	auipc	a0,0x5
    800041d8:	09c50513          	addi	a0,a0,156 # 80009270 <CONSOLE_STATUS+0x260>
    800041dc:	00001097          	auipc	ra,0x1
    800041e0:	b08080e7          	jalr	-1272(ra) # 80004ce4 <_Z11printStringPKc>
    800041e4:	00000613          	li	a2,0
    800041e8:	00a00593          	li	a1,10
    800041ec:	0009051b          	sext.w	a0,s2
    800041f0:	00001097          	auipc	ra,0x1
    800041f4:	ca4080e7          	jalr	-860(ra) # 80004e94 <_Z8printIntiii>
    800041f8:	00005517          	auipc	a0,0x5
    800041fc:	27850513          	addi	a0,a0,632 # 80009470 <CONSOLE_STATUS+0x460>
    80004200:	00001097          	auipc	ra,0x1
    80004204:	ae4080e7          	jalr	-1308(ra) # 80004ce4 <_Z11printStringPKc>
    80004208:	0400006f          	j	80004248 <_ZL11workerBodyCPv+0x13c>
        printString("C: i="); printInt(i); printString("\n");
    8000420c:	00005517          	auipc	a0,0x5
    80004210:	04450513          	addi	a0,a0,68 # 80009250 <CONSOLE_STATUS+0x240>
    80004214:	00001097          	auipc	ra,0x1
    80004218:	ad0080e7          	jalr	-1328(ra) # 80004ce4 <_Z11printStringPKc>
    8000421c:	00000613          	li	a2,0
    80004220:	00a00593          	li	a1,10
    80004224:	00048513          	mv	a0,s1
    80004228:	00001097          	auipc	ra,0x1
    8000422c:	c6c080e7          	jalr	-916(ra) # 80004e94 <_Z8printIntiii>
    80004230:	00005517          	auipc	a0,0x5
    80004234:	24050513          	addi	a0,a0,576 # 80009470 <CONSOLE_STATUS+0x460>
    80004238:	00001097          	auipc	ra,0x1
    8000423c:	aac080e7          	jalr	-1364(ra) # 80004ce4 <_Z11printStringPKc>
    for (; i < 6; i++) {
    80004240:	0014849b          	addiw	s1,s1,1
    80004244:	0ff4f493          	andi	s1,s1,255
    80004248:	00500793          	li	a5,5
    8000424c:	fc97f0e3          	bgeu	a5,s1,8000420c <_ZL11workerBodyCPv+0x100>
    printString("A finished!\n");
    80004250:	00005517          	auipc	a0,0x5
    80004254:	fd850513          	addi	a0,a0,-40 # 80009228 <CONSOLE_STATUS+0x218>
    80004258:	00001097          	auipc	ra,0x1
    8000425c:	a8c080e7          	jalr	-1396(ra) # 80004ce4 <_Z11printStringPKc>
    finishedC = true;
    80004260:	00100793          	li	a5,1
    80004264:	0000a717          	auipc	a4,0xa
    80004268:	4af702a3          	sb	a5,1189(a4) # 8000e709 <_ZL9finishedC>
    thread_dispatch();
    8000426c:	ffffd097          	auipc	ra,0xffffd
    80004270:	11c080e7          	jalr	284(ra) # 80001388 <_Z15thread_dispatchv>
}
    80004274:	01813083          	ld	ra,24(sp)
    80004278:	01013403          	ld	s0,16(sp)
    8000427c:	00813483          	ld	s1,8(sp)
    80004280:	00013903          	ld	s2,0(sp)
    80004284:	02010113          	addi	sp,sp,32
    80004288:	00008067          	ret

000000008000428c <_ZL11workerBodyBPv>:
static void workerBodyB(void* arg) {
    8000428c:	fe010113          	addi	sp,sp,-32
    80004290:	00113c23          	sd	ra,24(sp)
    80004294:	00813823          	sd	s0,16(sp)
    80004298:	00913423          	sd	s1,8(sp)
    8000429c:	01213023          	sd	s2,0(sp)
    800042a0:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 16; i++) {
    800042a4:	00000913          	li	s2,0
    800042a8:	0380006f          	j	800042e0 <_ZL11workerBodyBPv+0x54>
            thread_dispatch();
    800042ac:	ffffd097          	auipc	ra,0xffffd
    800042b0:	0dc080e7          	jalr	220(ra) # 80001388 <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++) {
    800042b4:	00148493          	addi	s1,s1,1
    800042b8:	000027b7          	lui	a5,0x2
    800042bc:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    800042c0:	0097ee63          	bltu	a5,s1,800042dc <_ZL11workerBodyBPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    800042c4:	00000713          	li	a4,0
    800042c8:	000077b7          	lui	a5,0x7
    800042cc:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    800042d0:	fce7eee3          	bltu	a5,a4,800042ac <_ZL11workerBodyBPv+0x20>
    800042d4:	00170713          	addi	a4,a4,1
    800042d8:	ff1ff06f          	j	800042c8 <_ZL11workerBodyBPv+0x3c>
    for (uint64 i = 0; i < 16; i++) {
    800042dc:	00190913          	addi	s2,s2,1
    800042e0:	00f00793          	li	a5,15
    800042e4:	0527e063          	bltu	a5,s2,80004324 <_ZL11workerBodyBPv+0x98>
        printString("B: i="); printInt(i); printString("\n");
    800042e8:	00005517          	auipc	a0,0x5
    800042ec:	f5050513          	addi	a0,a0,-176 # 80009238 <CONSOLE_STATUS+0x228>
    800042f0:	00001097          	auipc	ra,0x1
    800042f4:	9f4080e7          	jalr	-1548(ra) # 80004ce4 <_Z11printStringPKc>
    800042f8:	00000613          	li	a2,0
    800042fc:	00a00593          	li	a1,10
    80004300:	0009051b          	sext.w	a0,s2
    80004304:	00001097          	auipc	ra,0x1
    80004308:	b90080e7          	jalr	-1136(ra) # 80004e94 <_Z8printIntiii>
    8000430c:	00005517          	auipc	a0,0x5
    80004310:	16450513          	addi	a0,a0,356 # 80009470 <CONSOLE_STATUS+0x460>
    80004314:	00001097          	auipc	ra,0x1
    80004318:	9d0080e7          	jalr	-1584(ra) # 80004ce4 <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    8000431c:	00000493          	li	s1,0
    80004320:	f99ff06f          	j	800042b8 <_ZL11workerBodyBPv+0x2c>
    printString("B finished!\n");
    80004324:	00005517          	auipc	a0,0x5
    80004328:	f1c50513          	addi	a0,a0,-228 # 80009240 <CONSOLE_STATUS+0x230>
    8000432c:	00001097          	auipc	ra,0x1
    80004330:	9b8080e7          	jalr	-1608(ra) # 80004ce4 <_Z11printStringPKc>
    finishedB = true;
    80004334:	00100793          	li	a5,1
    80004338:	0000a717          	auipc	a4,0xa
    8000433c:	3cf70923          	sb	a5,978(a4) # 8000e70a <_ZL9finishedB>
    thread_dispatch();
    80004340:	ffffd097          	auipc	ra,0xffffd
    80004344:	048080e7          	jalr	72(ra) # 80001388 <_Z15thread_dispatchv>
}
    80004348:	01813083          	ld	ra,24(sp)
    8000434c:	01013403          	ld	s0,16(sp)
    80004350:	00813483          	ld	s1,8(sp)
    80004354:	00013903          	ld	s2,0(sp)
    80004358:	02010113          	addi	sp,sp,32
    8000435c:	00008067          	ret

0000000080004360 <_ZL11workerBodyAPv>:
static void workerBodyA(void* arg) {
    80004360:	fe010113          	addi	sp,sp,-32
    80004364:	00113c23          	sd	ra,24(sp)
    80004368:	00813823          	sd	s0,16(sp)
    8000436c:	00913423          	sd	s1,8(sp)
    80004370:	01213023          	sd	s2,0(sp)
    80004374:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 10; i++) {
    80004378:	00000913          	li	s2,0
    8000437c:	0380006f          	j	800043b4 <_ZL11workerBodyAPv+0x54>
            thread_dispatch();
    80004380:	ffffd097          	auipc	ra,0xffffd
    80004384:	008080e7          	jalr	8(ra) # 80001388 <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++) {
    80004388:	00148493          	addi	s1,s1,1
    8000438c:	000027b7          	lui	a5,0x2
    80004390:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    80004394:	0097ee63          	bltu	a5,s1,800043b0 <_ZL11workerBodyAPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    80004398:	00000713          	li	a4,0
    8000439c:	000077b7          	lui	a5,0x7
    800043a0:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    800043a4:	fce7eee3          	bltu	a5,a4,80004380 <_ZL11workerBodyAPv+0x20>
    800043a8:	00170713          	addi	a4,a4,1
    800043ac:	ff1ff06f          	j	8000439c <_ZL11workerBodyAPv+0x3c>
    for (uint64 i = 0; i < 10; i++) {
    800043b0:	00190913          	addi	s2,s2,1
    800043b4:	00900793          	li	a5,9
    800043b8:	0527e063          	bltu	a5,s2,800043f8 <_ZL11workerBodyAPv+0x98>
        printString("A: i="); printInt(i); printString("\n");
    800043bc:	00005517          	auipc	a0,0x5
    800043c0:	e6450513          	addi	a0,a0,-412 # 80009220 <CONSOLE_STATUS+0x210>
    800043c4:	00001097          	auipc	ra,0x1
    800043c8:	920080e7          	jalr	-1760(ra) # 80004ce4 <_Z11printStringPKc>
    800043cc:	00000613          	li	a2,0
    800043d0:	00a00593          	li	a1,10
    800043d4:	0009051b          	sext.w	a0,s2
    800043d8:	00001097          	auipc	ra,0x1
    800043dc:	abc080e7          	jalr	-1348(ra) # 80004e94 <_Z8printIntiii>
    800043e0:	00005517          	auipc	a0,0x5
    800043e4:	09050513          	addi	a0,a0,144 # 80009470 <CONSOLE_STATUS+0x460>
    800043e8:	00001097          	auipc	ra,0x1
    800043ec:	8fc080e7          	jalr	-1796(ra) # 80004ce4 <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    800043f0:	00000493          	li	s1,0
    800043f4:	f99ff06f          	j	8000438c <_ZL11workerBodyAPv+0x2c>
    printString("A finished!\n");
    800043f8:	00005517          	auipc	a0,0x5
    800043fc:	e3050513          	addi	a0,a0,-464 # 80009228 <CONSOLE_STATUS+0x218>
    80004400:	00001097          	auipc	ra,0x1
    80004404:	8e4080e7          	jalr	-1820(ra) # 80004ce4 <_Z11printStringPKc>
    finishedA = true;
    80004408:	00100793          	li	a5,1
    8000440c:	0000a717          	auipc	a4,0xa
    80004410:	2ef70fa3          	sb	a5,767(a4) # 8000e70b <_ZL9finishedA>
}
    80004414:	01813083          	ld	ra,24(sp)
    80004418:	01013403          	ld	s0,16(sp)
    8000441c:	00813483          	ld	s1,8(sp)
    80004420:	00013903          	ld	s2,0(sp)
    80004424:	02010113          	addi	sp,sp,32
    80004428:	00008067          	ret

000000008000442c <_Z18Threads_C_API_testv>:


void Threads_C_API_test() {
    8000442c:	fd010113          	addi	sp,sp,-48
    80004430:	02113423          	sd	ra,40(sp)
    80004434:	02813023          	sd	s0,32(sp)
    80004438:	03010413          	addi	s0,sp,48
    thread_t threads[4];
    thread_create(&threads[0], workerBodyA, nullptr);
    8000443c:	00000613          	li	a2,0
    80004440:	00000597          	auipc	a1,0x0
    80004444:	f2058593          	addi	a1,a1,-224 # 80004360 <_ZL11workerBodyAPv>
    80004448:	fd040513          	addi	a0,s0,-48
    8000444c:	ffffd097          	auipc	ra,0xffffd
    80004450:	eb4080e7          	jalr	-332(ra) # 80001300 <_Z13thread_createPP8thread_sPFvPvES2_>
    printString("ThreadA created\n");
    80004454:	00005517          	auipc	a0,0x5
    80004458:	e6450513          	addi	a0,a0,-412 # 800092b8 <CONSOLE_STATUS+0x2a8>
    8000445c:	00001097          	auipc	ra,0x1
    80004460:	888080e7          	jalr	-1912(ra) # 80004ce4 <_Z11printStringPKc>

    thread_create(&threads[1], workerBodyB, nullptr);
    80004464:	00000613          	li	a2,0
    80004468:	00000597          	auipc	a1,0x0
    8000446c:	e2458593          	addi	a1,a1,-476 # 8000428c <_ZL11workerBodyBPv>
    80004470:	fd840513          	addi	a0,s0,-40
    80004474:	ffffd097          	auipc	ra,0xffffd
    80004478:	e8c080e7          	jalr	-372(ra) # 80001300 <_Z13thread_createPP8thread_sPFvPvES2_>
    printString("ThreadB created\n");
    8000447c:	00005517          	auipc	a0,0x5
    80004480:	e5450513          	addi	a0,a0,-428 # 800092d0 <CONSOLE_STATUS+0x2c0>
    80004484:	00001097          	auipc	ra,0x1
    80004488:	860080e7          	jalr	-1952(ra) # 80004ce4 <_Z11printStringPKc>

    thread_create(&threads[2], workerBodyC, nullptr);
    8000448c:	00000613          	li	a2,0
    80004490:	00000597          	auipc	a1,0x0
    80004494:	c7c58593          	addi	a1,a1,-900 # 8000410c <_ZL11workerBodyCPv>
    80004498:	fe040513          	addi	a0,s0,-32
    8000449c:	ffffd097          	auipc	ra,0xffffd
    800044a0:	e64080e7          	jalr	-412(ra) # 80001300 <_Z13thread_createPP8thread_sPFvPvES2_>
    printString("ThreadC created\n");
    800044a4:	00005517          	auipc	a0,0x5
    800044a8:	e4450513          	addi	a0,a0,-444 # 800092e8 <CONSOLE_STATUS+0x2d8>
    800044ac:	00001097          	auipc	ra,0x1
    800044b0:	838080e7          	jalr	-1992(ra) # 80004ce4 <_Z11printStringPKc>

    thread_create(&threads[3], workerBodyD, nullptr);
    800044b4:	00000613          	li	a2,0
    800044b8:	00000597          	auipc	a1,0x0
    800044bc:	b0c58593          	addi	a1,a1,-1268 # 80003fc4 <_ZL11workerBodyDPv>
    800044c0:	fe840513          	addi	a0,s0,-24
    800044c4:	ffffd097          	auipc	ra,0xffffd
    800044c8:	e3c080e7          	jalr	-452(ra) # 80001300 <_Z13thread_createPP8thread_sPFvPvES2_>
    printString("ThreadD created\n");
    800044cc:	00005517          	auipc	a0,0x5
    800044d0:	e3450513          	addi	a0,a0,-460 # 80009300 <CONSOLE_STATUS+0x2f0>
    800044d4:	00001097          	auipc	ra,0x1
    800044d8:	810080e7          	jalr	-2032(ra) # 80004ce4 <_Z11printStringPKc>
    800044dc:	00c0006f          	j	800044e8 <_Z18Threads_C_API_testv+0xbc>

    while (!(finishedA && finishedB && finishedC && finishedD)) {
        thread_dispatch();
    800044e0:	ffffd097          	auipc	ra,0xffffd
    800044e4:	ea8080e7          	jalr	-344(ra) # 80001388 <_Z15thread_dispatchv>
    while (!(finishedA && finishedB && finishedC && finishedD)) {
    800044e8:	0000a797          	auipc	a5,0xa
    800044ec:	2237c783          	lbu	a5,547(a5) # 8000e70b <_ZL9finishedA>
    800044f0:	fe0788e3          	beqz	a5,800044e0 <_Z18Threads_C_API_testv+0xb4>
    800044f4:	0000a797          	auipc	a5,0xa
    800044f8:	2167c783          	lbu	a5,534(a5) # 8000e70a <_ZL9finishedB>
    800044fc:	fe0782e3          	beqz	a5,800044e0 <_Z18Threads_C_API_testv+0xb4>
    80004500:	0000a797          	auipc	a5,0xa
    80004504:	2097c783          	lbu	a5,521(a5) # 8000e709 <_ZL9finishedC>
    80004508:	fc078ce3          	beqz	a5,800044e0 <_Z18Threads_C_API_testv+0xb4>
    8000450c:	0000a797          	auipc	a5,0xa
    80004510:	1fc7c783          	lbu	a5,508(a5) # 8000e708 <_ZL9finishedD>
    80004514:	fc0786e3          	beqz	a5,800044e0 <_Z18Threads_C_API_testv+0xb4>
    }

}
    80004518:	02813083          	ld	ra,40(sp)
    8000451c:	02013403          	ld	s0,32(sp)
    80004520:	03010113          	addi	sp,sp,48
    80004524:	00008067          	ret

0000000080004528 <_ZN16ProducerKeyboard16producerKeyboardEPv>:
    void run() override {
        producerKeyboard(td);
    }
};

void ProducerKeyboard::producerKeyboard(void *arg) {
    80004528:	fd010113          	addi	sp,sp,-48
    8000452c:	02113423          	sd	ra,40(sp)
    80004530:	02813023          	sd	s0,32(sp)
    80004534:	00913c23          	sd	s1,24(sp)
    80004538:	01213823          	sd	s2,16(sp)
    8000453c:	01313423          	sd	s3,8(sp)
    80004540:	03010413          	addi	s0,sp,48
    80004544:	00050993          	mv	s3,a0
    80004548:	00058493          	mv	s1,a1
    struct thread_data *data = (struct thread_data *) arg;

    int key;
    int i = 0;
    8000454c:	00000913          	li	s2,0
    80004550:	00c0006f          	j	8000455c <_ZN16ProducerKeyboard16producerKeyboardEPv+0x34>
            thread_dispatch();
    80004554:	ffffd097          	auipc	ra,0xffffd
    80004558:	e34080e7          	jalr	-460(ra) # 80001388 <_Z15thread_dispatchv>
    while ((key = getc()) != 13) {
    8000455c:	ffffd097          	auipc	ra,0xffffd
    80004560:	018080e7          	jalr	24(ra) # 80001574 <_Z4getcv>
    80004564:	0005059b          	sext.w	a1,a0
    80004568:	00d00793          	li	a5,13
    8000456c:	02f58a63          	beq	a1,a5,800045a0 <_ZN16ProducerKeyboard16producerKeyboardEPv+0x78>
        data->buffer->put(key);
    80004570:	0084b503          	ld	a0,8(s1)
    80004574:	00001097          	auipc	ra,0x1
    80004578:	bd4080e7          	jalr	-1068(ra) # 80005148 <_ZN9BufferCPP3putEi>
        i++;
    8000457c:	0019071b          	addiw	a4,s2,1
    80004580:	0007091b          	sext.w	s2,a4

        if (i % (10 * data->id) == 0) {
    80004584:	0004a683          	lw	a3,0(s1)
    80004588:	0026979b          	slliw	a5,a3,0x2
    8000458c:	00d787bb          	addw	a5,a5,a3
    80004590:	0017979b          	slliw	a5,a5,0x1
    80004594:	02f767bb          	remw	a5,a4,a5
    80004598:	fc0792e3          	bnez	a5,8000455c <_ZN16ProducerKeyboard16producerKeyboardEPv+0x34>
    8000459c:	fb9ff06f          	j	80004554 <_ZN16ProducerKeyboard16producerKeyboardEPv+0x2c>
            Thread::dispatch();
        }
    }

    threadEnd = 1;
    800045a0:	00100793          	li	a5,1
    800045a4:	0000a717          	auipc	a4,0xa
    800045a8:	16f72623          	sw	a5,364(a4) # 8000e710 <_ZL9threadEnd>
    td->buffer->put('!');
    800045ac:	0209b783          	ld	a5,32(s3)
    800045b0:	02100593          	li	a1,33
    800045b4:	0087b503          	ld	a0,8(a5)
    800045b8:	00001097          	auipc	ra,0x1
    800045bc:	b90080e7          	jalr	-1136(ra) # 80005148 <_ZN9BufferCPP3putEi>

    data->wait->signal();
    800045c0:	0104b783          	ld	a5,16(s1)
            return sem_signal(myHandle);
    800045c4:	0087b503          	ld	a0,8(a5)
    800045c8:	ffffd097          	auipc	ra,0xffffd
    800045cc:	f38080e7          	jalr	-200(ra) # 80001500 <_Z10sem_signalP5sem_s>
}
    800045d0:	02813083          	ld	ra,40(sp)
    800045d4:	02013403          	ld	s0,32(sp)
    800045d8:	01813483          	ld	s1,24(sp)
    800045dc:	01013903          	ld	s2,16(sp)
    800045e0:	00813983          	ld	s3,8(sp)
    800045e4:	03010113          	addi	sp,sp,48
    800045e8:	00008067          	ret

00000000800045ec <_ZN12ProducerSync8producerEPv>:
    void run() override {
        producer(td);
    }
};

void ProducerSync::producer(void *arg) {
    800045ec:	fe010113          	addi	sp,sp,-32
    800045f0:	00113c23          	sd	ra,24(sp)
    800045f4:	00813823          	sd	s0,16(sp)
    800045f8:	00913423          	sd	s1,8(sp)
    800045fc:	01213023          	sd	s2,0(sp)
    80004600:	02010413          	addi	s0,sp,32
    80004604:	00058493          	mv	s1,a1
    struct thread_data *data = (struct thread_data *) arg;

    int i = 0;
    80004608:	00000913          	li	s2,0
    8000460c:	00c0006f          	j	80004618 <_ZN12ProducerSync8producerEPv+0x2c>
            thread_dispatch();
    80004610:	ffffd097          	auipc	ra,0xffffd
    80004614:	d78080e7          	jalr	-648(ra) # 80001388 <_Z15thread_dispatchv>
    while (!threadEnd) {
    80004618:	0000a797          	auipc	a5,0xa
    8000461c:	0f87a783          	lw	a5,248(a5) # 8000e710 <_ZL9threadEnd>
    80004620:	02079e63          	bnez	a5,8000465c <_ZN12ProducerSync8producerEPv+0x70>
        data->buffer->put(data->id + '0');
    80004624:	0004a583          	lw	a1,0(s1)
    80004628:	0305859b          	addiw	a1,a1,48
    8000462c:	0084b503          	ld	a0,8(s1)
    80004630:	00001097          	auipc	ra,0x1
    80004634:	b18080e7          	jalr	-1256(ra) # 80005148 <_ZN9BufferCPP3putEi>
        i++;
    80004638:	0019071b          	addiw	a4,s2,1
    8000463c:	0007091b          	sext.w	s2,a4

        if (i % (10 * data->id) == 0) {
    80004640:	0004a683          	lw	a3,0(s1)
    80004644:	0026979b          	slliw	a5,a3,0x2
    80004648:	00d787bb          	addw	a5,a5,a3
    8000464c:	0017979b          	slliw	a5,a5,0x1
    80004650:	02f767bb          	remw	a5,a4,a5
    80004654:	fc0792e3          	bnez	a5,80004618 <_ZN12ProducerSync8producerEPv+0x2c>
    80004658:	fb9ff06f          	j	80004610 <_ZN12ProducerSync8producerEPv+0x24>
            Thread::dispatch();
        }
    }

    data->wait->signal();
    8000465c:	0104b783          	ld	a5,16(s1)
            return sem_signal(myHandle);
    80004660:	0087b503          	ld	a0,8(a5)
    80004664:	ffffd097          	auipc	ra,0xffffd
    80004668:	e9c080e7          	jalr	-356(ra) # 80001500 <_Z10sem_signalP5sem_s>
}
    8000466c:	01813083          	ld	ra,24(sp)
    80004670:	01013403          	ld	s0,16(sp)
    80004674:	00813483          	ld	s1,8(sp)
    80004678:	00013903          	ld	s2,0(sp)
    8000467c:	02010113          	addi	sp,sp,32
    80004680:	00008067          	ret

0000000080004684 <_ZN12ConsumerSync8consumerEPv>:
    void run() override {
        consumer(td);
    }
};

void ConsumerSync::consumer(void *arg) {
    80004684:	fd010113          	addi	sp,sp,-48
    80004688:	02113423          	sd	ra,40(sp)
    8000468c:	02813023          	sd	s0,32(sp)
    80004690:	00913c23          	sd	s1,24(sp)
    80004694:	01213823          	sd	s2,16(sp)
    80004698:	01313423          	sd	s3,8(sp)
    8000469c:	01413023          	sd	s4,0(sp)
    800046a0:	03010413          	addi	s0,sp,48
    800046a4:	00050993          	mv	s3,a0
    800046a8:	00058913          	mv	s2,a1
    struct thread_data *data = (struct thread_data *) arg;

    int i = 0;
    800046ac:	00000a13          	li	s4,0
    800046b0:	01c0006f          	j	800046cc <_ZN12ConsumerSync8consumerEPv+0x48>
            thread_dispatch();
    800046b4:	ffffd097          	auipc	ra,0xffffd
    800046b8:	cd4080e7          	jalr	-812(ra) # 80001388 <_Z15thread_dispatchv>
        }
    800046bc:	0500006f          	j	8000470c <_ZN12ConsumerSync8consumerEPv+0x88>
        if (i % (5 * data->id) == 0) {
            Thread::dispatch();
        }

        if (i % 80 == 0) {
            putc('\n');
    800046c0:	00a00513          	li	a0,10
    800046c4:	ffffd097          	auipc	ra,0xffffd
    800046c8:	eec080e7          	jalr	-276(ra) # 800015b0 <_Z4putcc>
    while (!threadEnd) {
    800046cc:	0000a797          	auipc	a5,0xa
    800046d0:	0447a783          	lw	a5,68(a5) # 8000e710 <_ZL9threadEnd>
    800046d4:	06079263          	bnez	a5,80004738 <_ZN12ConsumerSync8consumerEPv+0xb4>
        int key = data->buffer->get();
    800046d8:	00893503          	ld	a0,8(s2)
    800046dc:	00001097          	auipc	ra,0x1
    800046e0:	b0c080e7          	jalr	-1268(ra) # 800051e8 <_ZN9BufferCPP3getEv>
        i++;
    800046e4:	001a049b          	addiw	s1,s4,1
    800046e8:	00048a1b          	sext.w	s4,s1
        putc(key);
    800046ec:	0ff57513          	andi	a0,a0,255
    800046f0:	ffffd097          	auipc	ra,0xffffd
    800046f4:	ec0080e7          	jalr	-320(ra) # 800015b0 <_Z4putcc>
        if (i % (5 * data->id) == 0) {
    800046f8:	00092703          	lw	a4,0(s2)
    800046fc:	0027179b          	slliw	a5,a4,0x2
    80004700:	00e787bb          	addw	a5,a5,a4
    80004704:	02f4e7bb          	remw	a5,s1,a5
    80004708:	fa0786e3          	beqz	a5,800046b4 <_ZN12ConsumerSync8consumerEPv+0x30>
        if (i % 80 == 0) {
    8000470c:	05000793          	li	a5,80
    80004710:	02f4e4bb          	remw	s1,s1,a5
    80004714:	fa049ce3          	bnez	s1,800046cc <_ZN12ConsumerSync8consumerEPv+0x48>
    80004718:	fa9ff06f          	j	800046c0 <_ZN12ConsumerSync8consumerEPv+0x3c>
        }
    }


    while (td->buffer->getCnt() > 0) {
        int key = td->buffer->get();
    8000471c:	0209b783          	ld	a5,32(s3)
    80004720:	0087b503          	ld	a0,8(a5)
    80004724:	00001097          	auipc	ra,0x1
    80004728:	ac4080e7          	jalr	-1340(ra) # 800051e8 <_ZN9BufferCPP3getEv>
            ::putc(c);
    8000472c:	0ff57513          	andi	a0,a0,255
    80004730:	ffffd097          	auipc	ra,0xffffd
    80004734:	e80080e7          	jalr	-384(ra) # 800015b0 <_Z4putcc>
    while (td->buffer->getCnt() > 0) {
    80004738:	0209b783          	ld	a5,32(s3)
    8000473c:	0087b503          	ld	a0,8(a5)
    80004740:	00001097          	auipc	ra,0x1
    80004744:	b44080e7          	jalr	-1212(ra) # 80005284 <_ZN9BufferCPP6getCntEv>
    80004748:	fca04ae3          	bgtz	a0,8000471c <_ZN12ConsumerSync8consumerEPv+0x98>
        Console::putc(key);
    }

    data->wait->signal();
    8000474c:	01093783          	ld	a5,16(s2)
            return sem_signal(myHandle);
    80004750:	0087b503          	ld	a0,8(a5)
    80004754:	ffffd097          	auipc	ra,0xffffd
    80004758:	dac080e7          	jalr	-596(ra) # 80001500 <_Z10sem_signalP5sem_s>
}
    8000475c:	02813083          	ld	ra,40(sp)
    80004760:	02013403          	ld	s0,32(sp)
    80004764:	01813483          	ld	s1,24(sp)
    80004768:	01013903          	ld	s2,16(sp)
    8000476c:	00813983          	ld	s3,8(sp)
    80004770:	00013a03          	ld	s4,0(sp)
    80004774:	03010113          	addi	sp,sp,48
    80004778:	00008067          	ret

000000008000477c <_Z29producerConsumer_CPP_Sync_APIv>:

void producerConsumer_CPP_Sync_API() {
    8000477c:	f9010113          	addi	sp,sp,-112
    80004780:	06113423          	sd	ra,104(sp)
    80004784:	06813023          	sd	s0,96(sp)
    80004788:	04913c23          	sd	s1,88(sp)
    8000478c:	05213823          	sd	s2,80(sp)
    80004790:	05313423          	sd	s3,72(sp)
    80004794:	05413023          	sd	s4,64(sp)
    80004798:	03513c23          	sd	s5,56(sp)
    8000479c:	03613823          	sd	s6,48(sp)
    800047a0:	03713423          	sd	s7,40(sp)
    800047a4:	03813023          	sd	s8,32(sp)
    800047a8:	07010413          	addi	s0,sp,112
    for (int i = 0; i < threadNum; i++) {
        delete threads[i];
    }
    delete consumerThread;
    delete waitForAll;
    delete buffer;
    800047ac:	00010b93          	mv	s7,sp
    printString("Unesite broj proizvodjaca?\n");
    800047b0:	00005517          	auipc	a0,0x5
    800047b4:	98850513          	addi	a0,a0,-1656 # 80009138 <CONSOLE_STATUS+0x128>
    800047b8:	00000097          	auipc	ra,0x0
    800047bc:	52c080e7          	jalr	1324(ra) # 80004ce4 <_Z11printStringPKc>
    getString(input, 30);
    800047c0:	01e00593          	li	a1,30
    800047c4:	f9040493          	addi	s1,s0,-112
    800047c8:	00048513          	mv	a0,s1
    800047cc:	00000097          	auipc	ra,0x0
    800047d0:	5a0080e7          	jalr	1440(ra) # 80004d6c <_Z9getStringPci>
    threadNum = stringToInt(input);
    800047d4:	00048513          	mv	a0,s1
    800047d8:	00000097          	auipc	ra,0x0
    800047dc:	66c080e7          	jalr	1644(ra) # 80004e44 <_Z11stringToIntPKc>
    800047e0:	00050913          	mv	s2,a0
    printString("Unesite velicinu bafera?\n");
    800047e4:	00005517          	auipc	a0,0x5
    800047e8:	97450513          	addi	a0,a0,-1676 # 80009158 <CONSOLE_STATUS+0x148>
    800047ec:	00000097          	auipc	ra,0x0
    800047f0:	4f8080e7          	jalr	1272(ra) # 80004ce4 <_Z11printStringPKc>
    getString(input, 30);
    800047f4:	01e00593          	li	a1,30
    800047f8:	00048513          	mv	a0,s1
    800047fc:	00000097          	auipc	ra,0x0
    80004800:	570080e7          	jalr	1392(ra) # 80004d6c <_Z9getStringPci>
    n = stringToInt(input);
    80004804:	00048513          	mv	a0,s1
    80004808:	00000097          	auipc	ra,0x0
    8000480c:	63c080e7          	jalr	1596(ra) # 80004e44 <_Z11stringToIntPKc>
    80004810:	00050493          	mv	s1,a0
    printString("Broj proizvodjaca "); printInt(threadNum);
    80004814:	00005517          	auipc	a0,0x5
    80004818:	96450513          	addi	a0,a0,-1692 # 80009178 <CONSOLE_STATUS+0x168>
    8000481c:	00000097          	auipc	ra,0x0
    80004820:	4c8080e7          	jalr	1224(ra) # 80004ce4 <_Z11printStringPKc>
    80004824:	00000613          	li	a2,0
    80004828:	00a00593          	li	a1,10
    8000482c:	00090513          	mv	a0,s2
    80004830:	00000097          	auipc	ra,0x0
    80004834:	664080e7          	jalr	1636(ra) # 80004e94 <_Z8printIntiii>
    printString(" i velicina bafera "); printInt(n);
    80004838:	00005517          	auipc	a0,0x5
    8000483c:	95850513          	addi	a0,a0,-1704 # 80009190 <CONSOLE_STATUS+0x180>
    80004840:	00000097          	auipc	ra,0x0
    80004844:	4a4080e7          	jalr	1188(ra) # 80004ce4 <_Z11printStringPKc>
    80004848:	00000613          	li	a2,0
    8000484c:	00a00593          	li	a1,10
    80004850:	00048513          	mv	a0,s1
    80004854:	00000097          	auipc	ra,0x0
    80004858:	640080e7          	jalr	1600(ra) # 80004e94 <_Z8printIntiii>
    printString(".\n");
    8000485c:	00005517          	auipc	a0,0x5
    80004860:	94c50513          	addi	a0,a0,-1716 # 800091a8 <CONSOLE_STATUS+0x198>
    80004864:	00000097          	auipc	ra,0x0
    80004868:	480080e7          	jalr	1152(ra) # 80004ce4 <_Z11printStringPKc>
    if(threadNum > n) {
    8000486c:	0324c463          	blt	s1,s2,80004894 <_Z29producerConsumer_CPP_Sync_APIv+0x118>
    } else if (threadNum < 1) {
    80004870:	03205c63          	blez	s2,800048a8 <_Z29producerConsumer_CPP_Sync_APIv+0x12c>
    BufferCPP *buffer = new BufferCPP(n);
    80004874:	03800513          	li	a0,56
    80004878:	ffffd097          	auipc	ra,0xffffd
    8000487c:	4f0080e7          	jalr	1264(ra) # 80001d68 <_Znwm>
    80004880:	00050a93          	mv	s5,a0
    80004884:	00048593          	mv	a1,s1
    80004888:	00000097          	auipc	ra,0x0
    8000488c:	72c080e7          	jalr	1836(ra) # 80004fb4 <_ZN9BufferCPPC1Ei>
    80004890:	0300006f          	j	800048c0 <_Z29producerConsumer_CPP_Sync_APIv+0x144>
        printString("Broj proizvodjaca ne sme biti manji od velicine bafera!\n");
    80004894:	00005517          	auipc	a0,0x5
    80004898:	91c50513          	addi	a0,a0,-1764 # 800091b0 <CONSOLE_STATUS+0x1a0>
    8000489c:	00000097          	auipc	ra,0x0
    800048a0:	448080e7          	jalr	1096(ra) # 80004ce4 <_Z11printStringPKc>
        return;
    800048a4:	0140006f          	j	800048b8 <_Z29producerConsumer_CPP_Sync_APIv+0x13c>
        printString("Broj proizvodjaca mora biti veci od nula!\n");
    800048a8:	00005517          	auipc	a0,0x5
    800048ac:	94850513          	addi	a0,a0,-1720 # 800091f0 <CONSOLE_STATUS+0x1e0>
    800048b0:	00000097          	auipc	ra,0x0
    800048b4:	434080e7          	jalr	1076(ra) # 80004ce4 <_Z11printStringPKc>
        return;
    800048b8:	000b8113          	mv	sp,s7
    800048bc:	2780006f          	j	80004b34 <_Z29producerConsumer_CPP_Sync_APIv+0x3b8>
    waitForAll = new Semaphore(0);
    800048c0:	01000513          	li	a0,16
    800048c4:	ffffd097          	auipc	ra,0xffffd
    800048c8:	4a4080e7          	jalr	1188(ra) # 80001d68 <_Znwm>
    800048cc:	00050493          	mv	s1,a0
        Semaphore (unsigned init = 1){
    800048d0:	00007797          	auipc	a5,0x7
    800048d4:	81878793          	addi	a5,a5,-2024 # 8000b0e8 <_ZTV9Semaphore+0x10>
    800048d8:	00f53023          	sd	a5,0(a0)
            sem_open(&myHandle,init);
    800048dc:	00000593          	li	a1,0
    800048e0:	00850513          	addi	a0,a0,8
    800048e4:	ffffd097          	auipc	ra,0xffffd
    800048e8:	b58080e7          	jalr	-1192(ra) # 8000143c <_Z8sem_openPP5sem_sj>
    800048ec:	0000a797          	auipc	a5,0xa
    800048f0:	e297b623          	sd	s1,-468(a5) # 8000e718 <_ZL10waitForAll>
    Thread* threads[threadNum];
    800048f4:	00391793          	slli	a5,s2,0x3
    800048f8:	00f78793          	addi	a5,a5,15
    800048fc:	ff07f793          	andi	a5,a5,-16
    80004900:	40f10133          	sub	sp,sp,a5
    80004904:	00010993          	mv	s3,sp
    struct thread_data data[threadNum + 1];
    80004908:	0019071b          	addiw	a4,s2,1
    8000490c:	00171793          	slli	a5,a4,0x1
    80004910:	00e787b3          	add	a5,a5,a4
    80004914:	00379793          	slli	a5,a5,0x3
    80004918:	00f78793          	addi	a5,a5,15
    8000491c:	ff07f793          	andi	a5,a5,-16
    80004920:	40f10133          	sub	sp,sp,a5
    80004924:	00010a13          	mv	s4,sp
    data[threadNum].id = threadNum;
    80004928:	00191c13          	slli	s8,s2,0x1
    8000492c:	012c07b3          	add	a5,s8,s2
    80004930:	00379793          	slli	a5,a5,0x3
    80004934:	00fa07b3          	add	a5,s4,a5
    80004938:	0127a023          	sw	s2,0(a5)
    data[threadNum].buffer = buffer;
    8000493c:	0157b423          	sd	s5,8(a5)
    data[threadNum].wait = waitForAll;
    80004940:	0097b823          	sd	s1,16(a5)
    consumerThread = new ConsumerSync(data+threadNum);
    80004944:	02800513          	li	a0,40
    80004948:	ffffd097          	auipc	ra,0xffffd
    8000494c:	420080e7          	jalr	1056(ra) # 80001d68 <_Znwm>
    80004950:	00050b13          	mv	s6,a0
    80004954:	012c0c33          	add	s8,s8,s2
    80004958:	003c1c13          	slli	s8,s8,0x3
    8000495c:	018a0c33          	add	s8,s4,s8
            body= nullptr;
    80004960:	00053823          	sd	zero,16(a0)
            arg= nullptr;
    80004964:	00053c23          	sd	zero,24(a0)
    ConsumerSync(thread_data* _td):Thread(), td(_td) {}
    80004968:	00007797          	auipc	a5,0x7
    8000496c:	86878793          	addi	a5,a5,-1944 # 8000b1d0 <_ZTV12ConsumerSync+0x10>
    80004970:	00f53023          	sd	a5,0(a0)
    80004974:	03853023          	sd	s8,32(a0)
            if(body== nullptr) return thread_create(&myHandle,&threadEntry, this);
    80004978:	00050613          	mv	a2,a0
    8000497c:	ffffd597          	auipc	a1,0xffffd
    80004980:	39858593          	addi	a1,a1,920 # 80001d14 <_ZN6Thread11threadEntryEPv>
    80004984:	00850513          	addi	a0,a0,8
    80004988:	ffffd097          	auipc	ra,0xffffd
    8000498c:	978080e7          	jalr	-1672(ra) # 80001300 <_Z13thread_createPP8thread_sPFvPvES2_>
    for (int i = 0; i < threadNum; i++) {
    80004990:	00000493          	li	s1,0
    80004994:	0640006f          	j	800049f8 <_Z29producerConsumer_CPP_Sync_APIv+0x27c>
            threads[i] = new ProducerKeyboard(data+i);
    80004998:	02800513          	li	a0,40
    8000499c:	ffffd097          	auipc	ra,0xffffd
    800049a0:	3cc080e7          	jalr	972(ra) # 80001d68 <_Znwm>
    800049a4:	00149793          	slli	a5,s1,0x1
    800049a8:	009787b3          	add	a5,a5,s1
    800049ac:	00379793          	slli	a5,a5,0x3
    800049b0:	00fa07b3          	add	a5,s4,a5
            body= nullptr;
    800049b4:	00053823          	sd	zero,16(a0)
            arg= nullptr;
    800049b8:	00053c23          	sd	zero,24(a0)
    ProducerKeyboard(thread_data* _td):Thread(), td(_td) {}
    800049bc:	00006717          	auipc	a4,0x6
    800049c0:	7c470713          	addi	a4,a4,1988 # 8000b180 <_ZTV16ProducerKeyboard+0x10>
    800049c4:	00e53023          	sd	a4,0(a0)
    800049c8:	02f53023          	sd	a5,32(a0)
            threads[i] = new ProducerKeyboard(data+i);
    800049cc:	00349793          	slli	a5,s1,0x3
    800049d0:	00f987b3          	add	a5,s3,a5
    800049d4:	00a7b023          	sd	a0,0(a5)
    800049d8:	08c0006f          	j	80004a64 <_Z29producerConsumer_CPP_Sync_APIv+0x2e8>
            if(body== nullptr) return thread_create(&myHandle,&threadEntry, this);
    800049dc:	00050613          	mv	a2,a0
    800049e0:	ffffd597          	auipc	a1,0xffffd
    800049e4:	33458593          	addi	a1,a1,820 # 80001d14 <_ZN6Thread11threadEntryEPv>
    800049e8:	00850513          	addi	a0,a0,8
    800049ec:	ffffd097          	auipc	ra,0xffffd
    800049f0:	914080e7          	jalr	-1772(ra) # 80001300 <_Z13thread_createPP8thread_sPFvPvES2_>
    for (int i = 0; i < threadNum; i++) {
    800049f4:	0014849b          	addiw	s1,s1,1
    800049f8:	0924da63          	bge	s1,s2,80004a8c <_Z29producerConsumer_CPP_Sync_APIv+0x310>
        data[i].id = i;
    800049fc:	00149793          	slli	a5,s1,0x1
    80004a00:	009787b3          	add	a5,a5,s1
    80004a04:	00379793          	slli	a5,a5,0x3
    80004a08:	00fa07b3          	add	a5,s4,a5
    80004a0c:	0097a023          	sw	s1,0(a5)
        data[i].buffer = buffer;
    80004a10:	0157b423          	sd	s5,8(a5)
        data[i].wait = waitForAll;
    80004a14:	0000a717          	auipc	a4,0xa
    80004a18:	d0473703          	ld	a4,-764(a4) # 8000e718 <_ZL10waitForAll>
    80004a1c:	00e7b823          	sd	a4,16(a5)
        if(i>0) {
    80004a20:	f6905ce3          	blez	s1,80004998 <_Z29producerConsumer_CPP_Sync_APIv+0x21c>
            threads[i] = new ProducerSync(data+i);
    80004a24:	02800513          	li	a0,40
    80004a28:	ffffd097          	auipc	ra,0xffffd
    80004a2c:	340080e7          	jalr	832(ra) # 80001d68 <_Znwm>
    80004a30:	00149793          	slli	a5,s1,0x1
    80004a34:	009787b3          	add	a5,a5,s1
    80004a38:	00379793          	slli	a5,a5,0x3
    80004a3c:	00fa07b3          	add	a5,s4,a5
            body= nullptr;
    80004a40:	00053823          	sd	zero,16(a0)
            arg= nullptr;
    80004a44:	00053c23          	sd	zero,24(a0)
    ProducerSync(thread_data* _td):Thread(), td(_td) {}
    80004a48:	00006717          	auipc	a4,0x6
    80004a4c:	76070713          	addi	a4,a4,1888 # 8000b1a8 <_ZTV12ProducerSync+0x10>
    80004a50:	00e53023          	sd	a4,0(a0)
    80004a54:	02f53023          	sd	a5,32(a0)
            threads[i] = new ProducerSync(data+i);
    80004a58:	00349793          	slli	a5,s1,0x3
    80004a5c:	00f987b3          	add	a5,s3,a5
    80004a60:	00a7b023          	sd	a0,0(a5)
        threads[i]->start();
    80004a64:	00349793          	slli	a5,s1,0x3
    80004a68:	00f987b3          	add	a5,s3,a5
    80004a6c:	0007b503          	ld	a0,0(a5)
            if(body== nullptr) return thread_create(&myHandle,&threadEntry, this);
    80004a70:	01053583          	ld	a1,16(a0)
    80004a74:	f60584e3          	beqz	a1,800049dc <_Z29producerConsumer_CPP_Sync_APIv+0x260>
            else return thread_create(&myHandle,body,arg);
    80004a78:	01853603          	ld	a2,24(a0)
    80004a7c:	00850513          	addi	a0,a0,8
    80004a80:	ffffd097          	auipc	ra,0xffffd
    80004a84:	880080e7          	jalr	-1920(ra) # 80001300 <_Z13thread_createPP8thread_sPFvPvES2_>
    80004a88:	f6dff06f          	j	800049f4 <_Z29producerConsumer_CPP_Sync_APIv+0x278>
            thread_dispatch();
    80004a8c:	ffffd097          	auipc	ra,0xffffd
    80004a90:	8fc080e7          	jalr	-1796(ra) # 80001388 <_Z15thread_dispatchv>
    for (int i = 0; i <= threadNum; i++) {
    80004a94:	00000493          	li	s1,0
    80004a98:	02994063          	blt	s2,s1,80004ab8 <_Z29producerConsumer_CPP_Sync_APIv+0x33c>
            return sem_wait(myHandle);
    80004a9c:	0000a797          	auipc	a5,0xa
    80004aa0:	c7c7b783          	ld	a5,-900(a5) # 8000e718 <_ZL10waitForAll>
    80004aa4:	0087b503          	ld	a0,8(a5)
    80004aa8:	ffffd097          	auipc	ra,0xffffd
    80004aac:	a18080e7          	jalr	-1512(ra) # 800014c0 <_Z8sem_waitP5sem_s>
    80004ab0:	0014849b          	addiw	s1,s1,1
    80004ab4:	fe5ff06f          	j	80004a98 <_Z29producerConsumer_CPP_Sync_APIv+0x31c>
    for (int i = 0; i < threadNum; i++) {
    80004ab8:	00000493          	li	s1,0
    80004abc:	0080006f          	j	80004ac4 <_Z29producerConsumer_CPP_Sync_APIv+0x348>
    80004ac0:	0014849b          	addiw	s1,s1,1
    80004ac4:	0324d263          	bge	s1,s2,80004ae8 <_Z29producerConsumer_CPP_Sync_APIv+0x36c>
        delete threads[i];
    80004ac8:	00349793          	slli	a5,s1,0x3
    80004acc:	00f987b3          	add	a5,s3,a5
    80004ad0:	0007b503          	ld	a0,0(a5)
    80004ad4:	fe0506e3          	beqz	a0,80004ac0 <_Z29producerConsumer_CPP_Sync_APIv+0x344>
    80004ad8:	00053783          	ld	a5,0(a0)
    80004adc:	0087b783          	ld	a5,8(a5)
    80004ae0:	000780e7          	jalr	a5
    80004ae4:	fddff06f          	j	80004ac0 <_Z29producerConsumer_CPP_Sync_APIv+0x344>
    delete consumerThread;
    80004ae8:	000b0a63          	beqz	s6,80004afc <_Z29producerConsumer_CPP_Sync_APIv+0x380>
    80004aec:	000b3783          	ld	a5,0(s6)
    80004af0:	0087b783          	ld	a5,8(a5)
    80004af4:	000b0513          	mv	a0,s6
    80004af8:	000780e7          	jalr	a5
    delete waitForAll;
    80004afc:	0000a517          	auipc	a0,0xa
    80004b00:	c1c53503          	ld	a0,-996(a0) # 8000e718 <_ZL10waitForAll>
    80004b04:	00050863          	beqz	a0,80004b14 <_Z29producerConsumer_CPP_Sync_APIv+0x398>
    80004b08:	00053783          	ld	a5,0(a0)
    80004b0c:	0087b783          	ld	a5,8(a5)
    80004b10:	000780e7          	jalr	a5
    delete buffer;
    80004b14:	000a8e63          	beqz	s5,80004b30 <_Z29producerConsumer_CPP_Sync_APIv+0x3b4>
    80004b18:	000a8513          	mv	a0,s5
    80004b1c:	00001097          	auipc	ra,0x1
    80004b20:	800080e7          	jalr	-2048(ra) # 8000531c <_ZN9BufferCPPD1Ev>
    80004b24:	000a8513          	mv	a0,s5
    80004b28:	ffffd097          	auipc	ra,0xffffd
    80004b2c:	268080e7          	jalr	616(ra) # 80001d90 <_ZdlPv>
    80004b30:	000b8113          	mv	sp,s7

}
    80004b34:	f9040113          	addi	sp,s0,-112
    80004b38:	06813083          	ld	ra,104(sp)
    80004b3c:	06013403          	ld	s0,96(sp)
    80004b40:	05813483          	ld	s1,88(sp)
    80004b44:	05013903          	ld	s2,80(sp)
    80004b48:	04813983          	ld	s3,72(sp)
    80004b4c:	04013a03          	ld	s4,64(sp)
    80004b50:	03813a83          	ld	s5,56(sp)
    80004b54:	03013b03          	ld	s6,48(sp)
    80004b58:	02813b83          	ld	s7,40(sp)
    80004b5c:	02013c03          	ld	s8,32(sp)
    80004b60:	07010113          	addi	sp,sp,112
    80004b64:	00008067          	ret
    80004b68:	00050493          	mv	s1,a0
    BufferCPP *buffer = new BufferCPP(n);
    80004b6c:	000a8513          	mv	a0,s5
    80004b70:	ffffd097          	auipc	ra,0xffffd
    80004b74:	220080e7          	jalr	544(ra) # 80001d90 <_ZdlPv>
    80004b78:	00048513          	mv	a0,s1
    80004b7c:	0000b097          	auipc	ra,0xb
    80004b80:	c7c080e7          	jalr	-900(ra) # 8000f7f8 <_Unwind_Resume>
    80004b84:	00050913          	mv	s2,a0
    waitForAll = new Semaphore(0);
    80004b88:	00048513          	mv	a0,s1
    80004b8c:	ffffd097          	auipc	ra,0xffffd
    80004b90:	204080e7          	jalr	516(ra) # 80001d90 <_ZdlPv>
    80004b94:	00090513          	mv	a0,s2
    80004b98:	0000b097          	auipc	ra,0xb
    80004b9c:	c60080e7          	jalr	-928(ra) # 8000f7f8 <_Unwind_Resume>

0000000080004ba0 <_ZN12ConsumerSyncD1Ev>:
class ConsumerSync:public Thread {
    80004ba0:	ff010113          	addi	sp,sp,-16
    80004ba4:	00813423          	sd	s0,8(sp)
    80004ba8:	01010413          	addi	s0,sp,16
    80004bac:	00813403          	ld	s0,8(sp)
    80004bb0:	01010113          	addi	sp,sp,16
    80004bb4:	00008067          	ret

0000000080004bb8 <_ZN12ProducerSyncD1Ev>:
class ProducerSync:public Thread {
    80004bb8:	ff010113          	addi	sp,sp,-16
    80004bbc:	00813423          	sd	s0,8(sp)
    80004bc0:	01010413          	addi	s0,sp,16
    80004bc4:	00813403          	ld	s0,8(sp)
    80004bc8:	01010113          	addi	sp,sp,16
    80004bcc:	00008067          	ret

0000000080004bd0 <_ZN16ProducerKeyboardD1Ev>:
class ProducerKeyboard:public Thread {
    80004bd0:	ff010113          	addi	sp,sp,-16
    80004bd4:	00813423          	sd	s0,8(sp)
    80004bd8:	01010413          	addi	s0,sp,16
    80004bdc:	00813403          	ld	s0,8(sp)
    80004be0:	01010113          	addi	sp,sp,16
    80004be4:	00008067          	ret

0000000080004be8 <_ZN12ConsumerSyncD0Ev>:
class ConsumerSync:public Thread {
    80004be8:	ff010113          	addi	sp,sp,-16
    80004bec:	00113423          	sd	ra,8(sp)
    80004bf0:	00813023          	sd	s0,0(sp)
    80004bf4:	01010413          	addi	s0,sp,16
    80004bf8:	ffffd097          	auipc	ra,0xffffd
    80004bfc:	198080e7          	jalr	408(ra) # 80001d90 <_ZdlPv>
    80004c00:	00813083          	ld	ra,8(sp)
    80004c04:	00013403          	ld	s0,0(sp)
    80004c08:	01010113          	addi	sp,sp,16
    80004c0c:	00008067          	ret

0000000080004c10 <_ZN12ProducerSyncD0Ev>:
class ProducerSync:public Thread {
    80004c10:	ff010113          	addi	sp,sp,-16
    80004c14:	00113423          	sd	ra,8(sp)
    80004c18:	00813023          	sd	s0,0(sp)
    80004c1c:	01010413          	addi	s0,sp,16
    80004c20:	ffffd097          	auipc	ra,0xffffd
    80004c24:	170080e7          	jalr	368(ra) # 80001d90 <_ZdlPv>
    80004c28:	00813083          	ld	ra,8(sp)
    80004c2c:	00013403          	ld	s0,0(sp)
    80004c30:	01010113          	addi	sp,sp,16
    80004c34:	00008067          	ret

0000000080004c38 <_ZN16ProducerKeyboardD0Ev>:
class ProducerKeyboard:public Thread {
    80004c38:	ff010113          	addi	sp,sp,-16
    80004c3c:	00113423          	sd	ra,8(sp)
    80004c40:	00813023          	sd	s0,0(sp)
    80004c44:	01010413          	addi	s0,sp,16
    80004c48:	ffffd097          	auipc	ra,0xffffd
    80004c4c:	148080e7          	jalr	328(ra) # 80001d90 <_ZdlPv>
    80004c50:	00813083          	ld	ra,8(sp)
    80004c54:	00013403          	ld	s0,0(sp)
    80004c58:	01010113          	addi	sp,sp,16
    80004c5c:	00008067          	ret

0000000080004c60 <_ZN16ProducerKeyboard3runEv>:
    void run() override {
    80004c60:	ff010113          	addi	sp,sp,-16
    80004c64:	00113423          	sd	ra,8(sp)
    80004c68:	00813023          	sd	s0,0(sp)
    80004c6c:	01010413          	addi	s0,sp,16
        producerKeyboard(td);
    80004c70:	02053583          	ld	a1,32(a0)
    80004c74:	00000097          	auipc	ra,0x0
    80004c78:	8b4080e7          	jalr	-1868(ra) # 80004528 <_ZN16ProducerKeyboard16producerKeyboardEPv>
    }
    80004c7c:	00813083          	ld	ra,8(sp)
    80004c80:	00013403          	ld	s0,0(sp)
    80004c84:	01010113          	addi	sp,sp,16
    80004c88:	00008067          	ret

0000000080004c8c <_ZN12ProducerSync3runEv>:
    void run() override {
    80004c8c:	ff010113          	addi	sp,sp,-16
    80004c90:	00113423          	sd	ra,8(sp)
    80004c94:	00813023          	sd	s0,0(sp)
    80004c98:	01010413          	addi	s0,sp,16
        producer(td);
    80004c9c:	02053583          	ld	a1,32(a0)
    80004ca0:	00000097          	auipc	ra,0x0
    80004ca4:	94c080e7          	jalr	-1716(ra) # 800045ec <_ZN12ProducerSync8producerEPv>
    }
    80004ca8:	00813083          	ld	ra,8(sp)
    80004cac:	00013403          	ld	s0,0(sp)
    80004cb0:	01010113          	addi	sp,sp,16
    80004cb4:	00008067          	ret

0000000080004cb8 <_ZN12ConsumerSync3runEv>:
    void run() override {
    80004cb8:	ff010113          	addi	sp,sp,-16
    80004cbc:	00113423          	sd	ra,8(sp)
    80004cc0:	00813023          	sd	s0,0(sp)
    80004cc4:	01010413          	addi	s0,sp,16
        consumer(td);
    80004cc8:	02053583          	ld	a1,32(a0)
    80004ccc:	00000097          	auipc	ra,0x0
    80004cd0:	9b8080e7          	jalr	-1608(ra) # 80004684 <_ZN12ConsumerSync8consumerEPv>
    }
    80004cd4:	00813083          	ld	ra,8(sp)
    80004cd8:	00013403          	ld	s0,0(sp)
    80004cdc:	01010113          	addi	sp,sp,16
    80004ce0:	00008067          	ret

0000000080004ce4 <_Z11printStringPKc>:

#define LOCK() while(copy_and_swap(lockPrint, 0, 1)) thread_dispatch()
#define UNLOCK() while(copy_and_swap(lockPrint, 1, 0))

void printString(char const *string)
{
    80004ce4:	fe010113          	addi	sp,sp,-32
    80004ce8:	00113c23          	sd	ra,24(sp)
    80004cec:	00813823          	sd	s0,16(sp)
    80004cf0:	00913423          	sd	s1,8(sp)
    80004cf4:	02010413          	addi	s0,sp,32
    80004cf8:	00050493          	mv	s1,a0
    LOCK();
    80004cfc:	00100613          	li	a2,1
    80004d00:	00000593          	li	a1,0
    80004d04:	0000a517          	auipc	a0,0xa
    80004d08:	a1c50513          	addi	a0,a0,-1508 # 8000e720 <lockPrint>
    80004d0c:	ffffc097          	auipc	ra,0xffffc
    80004d10:	554080e7          	jalr	1364(ra) # 80001260 <copy_and_swap>
    80004d14:	00050863          	beqz	a0,80004d24 <_Z11printStringPKc+0x40>
    80004d18:	ffffc097          	auipc	ra,0xffffc
    80004d1c:	670080e7          	jalr	1648(ra) # 80001388 <_Z15thread_dispatchv>
    80004d20:	fddff06f          	j	80004cfc <_Z11printStringPKc+0x18>
    while (*string != '\0')
    80004d24:	0004c503          	lbu	a0,0(s1)
    80004d28:	00050a63          	beqz	a0,80004d3c <_Z11printStringPKc+0x58>
    {
        putc(*string);
    80004d2c:	ffffd097          	auipc	ra,0xffffd
    80004d30:	884080e7          	jalr	-1916(ra) # 800015b0 <_Z4putcc>
        string++;
    80004d34:	00148493          	addi	s1,s1,1
    while (*string != '\0')
    80004d38:	fedff06f          	j	80004d24 <_Z11printStringPKc+0x40>
    }
    UNLOCK();
    80004d3c:	00000613          	li	a2,0
    80004d40:	00100593          	li	a1,1
    80004d44:	0000a517          	auipc	a0,0xa
    80004d48:	9dc50513          	addi	a0,a0,-1572 # 8000e720 <lockPrint>
    80004d4c:	ffffc097          	auipc	ra,0xffffc
    80004d50:	514080e7          	jalr	1300(ra) # 80001260 <copy_and_swap>
    80004d54:	fe0514e3          	bnez	a0,80004d3c <_Z11printStringPKc+0x58>
}
    80004d58:	01813083          	ld	ra,24(sp)
    80004d5c:	01013403          	ld	s0,16(sp)
    80004d60:	00813483          	ld	s1,8(sp)
    80004d64:	02010113          	addi	sp,sp,32
    80004d68:	00008067          	ret

0000000080004d6c <_Z9getStringPci>:

char* getString(char *buf, int max) {
    80004d6c:	fd010113          	addi	sp,sp,-48
    80004d70:	02113423          	sd	ra,40(sp)
    80004d74:	02813023          	sd	s0,32(sp)
    80004d78:	00913c23          	sd	s1,24(sp)
    80004d7c:	01213823          	sd	s2,16(sp)
    80004d80:	01313423          	sd	s3,8(sp)
    80004d84:	01413023          	sd	s4,0(sp)
    80004d88:	03010413          	addi	s0,sp,48
    80004d8c:	00050993          	mv	s3,a0
    80004d90:	00058a13          	mv	s4,a1
    LOCK();
    80004d94:	00100613          	li	a2,1
    80004d98:	00000593          	li	a1,0
    80004d9c:	0000a517          	auipc	a0,0xa
    80004da0:	98450513          	addi	a0,a0,-1660 # 8000e720 <lockPrint>
    80004da4:	ffffc097          	auipc	ra,0xffffc
    80004da8:	4bc080e7          	jalr	1212(ra) # 80001260 <copy_and_swap>
    80004dac:	00050863          	beqz	a0,80004dbc <_Z9getStringPci+0x50>
    80004db0:	ffffc097          	auipc	ra,0xffffc
    80004db4:	5d8080e7          	jalr	1496(ra) # 80001388 <_Z15thread_dispatchv>
    80004db8:	fddff06f          	j	80004d94 <_Z9getStringPci+0x28>
    int i, cc;
    char c;

    for(i=0; i+1 < max; ){
    80004dbc:	00000913          	li	s2,0
    80004dc0:	00090493          	mv	s1,s2
    80004dc4:	0019091b          	addiw	s2,s2,1
    80004dc8:	03495a63          	bge	s2,s4,80004dfc <_Z9getStringPci+0x90>
        cc = getc();
    80004dcc:	ffffc097          	auipc	ra,0xffffc
    80004dd0:	7a8080e7          	jalr	1960(ra) # 80001574 <_Z4getcv>
        if(cc < 1)
    80004dd4:	02050463          	beqz	a0,80004dfc <_Z9getStringPci+0x90>
            break;
        c = cc;
        buf[i++] = c;
    80004dd8:	009984b3          	add	s1,s3,s1
    80004ddc:	00a48023          	sb	a0,0(s1)
        if(c == '\n' || c == '\r')
    80004de0:	00a00793          	li	a5,10
    80004de4:	00f50a63          	beq	a0,a5,80004df8 <_Z9getStringPci+0x8c>
    80004de8:	00d00793          	li	a5,13
    80004dec:	fcf51ae3          	bne	a0,a5,80004dc0 <_Z9getStringPci+0x54>
        buf[i++] = c;
    80004df0:	00090493          	mv	s1,s2
    80004df4:	0080006f          	j	80004dfc <_Z9getStringPci+0x90>
    80004df8:	00090493          	mv	s1,s2
            break;
    }
    buf[i] = '\0';
    80004dfc:	009984b3          	add	s1,s3,s1
    80004e00:	00048023          	sb	zero,0(s1)

    UNLOCK();
    80004e04:	00000613          	li	a2,0
    80004e08:	00100593          	li	a1,1
    80004e0c:	0000a517          	auipc	a0,0xa
    80004e10:	91450513          	addi	a0,a0,-1772 # 8000e720 <lockPrint>
    80004e14:	ffffc097          	auipc	ra,0xffffc
    80004e18:	44c080e7          	jalr	1100(ra) # 80001260 <copy_and_swap>
    80004e1c:	fe0514e3          	bnez	a0,80004e04 <_Z9getStringPci+0x98>
    return buf;
}
    80004e20:	00098513          	mv	a0,s3
    80004e24:	02813083          	ld	ra,40(sp)
    80004e28:	02013403          	ld	s0,32(sp)
    80004e2c:	01813483          	ld	s1,24(sp)
    80004e30:	01013903          	ld	s2,16(sp)
    80004e34:	00813983          	ld	s3,8(sp)
    80004e38:	00013a03          	ld	s4,0(sp)
    80004e3c:	03010113          	addi	sp,sp,48
    80004e40:	00008067          	ret

0000000080004e44 <_Z11stringToIntPKc>:

int stringToInt(const char *s) {
    80004e44:	ff010113          	addi	sp,sp,-16
    80004e48:	00813423          	sd	s0,8(sp)
    80004e4c:	01010413          	addi	s0,sp,16
    80004e50:	00050693          	mv	a3,a0
    int n;

    n = 0;
    80004e54:	00000513          	li	a0,0
    while ('0' <= *s && *s <= '9')
    80004e58:	0006c603          	lbu	a2,0(a3)
    80004e5c:	fd06071b          	addiw	a4,a2,-48
    80004e60:	0ff77713          	andi	a4,a4,255
    80004e64:	00900793          	li	a5,9
    80004e68:	02e7e063          	bltu	a5,a4,80004e88 <_Z11stringToIntPKc+0x44>
        n = n * 10 + *s++ - '0';
    80004e6c:	0025179b          	slliw	a5,a0,0x2
    80004e70:	00a787bb          	addw	a5,a5,a0
    80004e74:	0017979b          	slliw	a5,a5,0x1
    80004e78:	00168693          	addi	a3,a3,1
    80004e7c:	00c787bb          	addw	a5,a5,a2
    80004e80:	fd07851b          	addiw	a0,a5,-48
    while ('0' <= *s && *s <= '9')
    80004e84:	fd5ff06f          	j	80004e58 <_Z11stringToIntPKc+0x14>
    return n;
}
    80004e88:	00813403          	ld	s0,8(sp)
    80004e8c:	01010113          	addi	sp,sp,16
    80004e90:	00008067          	ret

0000000080004e94 <_Z8printIntiii>:

char digits[] = "0123456789ABCDEF";

void printInt(int xx, int base, int sgn)
{
    80004e94:	fc010113          	addi	sp,sp,-64
    80004e98:	02113c23          	sd	ra,56(sp)
    80004e9c:	02813823          	sd	s0,48(sp)
    80004ea0:	02913423          	sd	s1,40(sp)
    80004ea4:	03213023          	sd	s2,32(sp)
    80004ea8:	01313c23          	sd	s3,24(sp)
    80004eac:	04010413          	addi	s0,sp,64
    80004eb0:	00050493          	mv	s1,a0
    80004eb4:	00058913          	mv	s2,a1
    80004eb8:	00060993          	mv	s3,a2
    LOCK();
    80004ebc:	00100613          	li	a2,1
    80004ec0:	00000593          	li	a1,0
    80004ec4:	0000a517          	auipc	a0,0xa
    80004ec8:	85c50513          	addi	a0,a0,-1956 # 8000e720 <lockPrint>
    80004ecc:	ffffc097          	auipc	ra,0xffffc
    80004ed0:	394080e7          	jalr	916(ra) # 80001260 <copy_and_swap>
    80004ed4:	00050863          	beqz	a0,80004ee4 <_Z8printIntiii+0x50>
    80004ed8:	ffffc097          	auipc	ra,0xffffc
    80004edc:	4b0080e7          	jalr	1200(ra) # 80001388 <_Z15thread_dispatchv>
    80004ee0:	fddff06f          	j	80004ebc <_Z8printIntiii+0x28>
    char buf[16];
    int i, neg;
    uint x;

    neg = 0;
    if(sgn && xx < 0){
    80004ee4:	00098463          	beqz	s3,80004eec <_Z8printIntiii+0x58>
    80004ee8:	0804c463          	bltz	s1,80004f70 <_Z8printIntiii+0xdc>
        neg = 1;
        x = -xx;
    } else {
        x = xx;
    80004eec:	0004851b          	sext.w	a0,s1
    neg = 0;
    80004ef0:	00000593          	li	a1,0
    }

    i = 0;
    80004ef4:	00000493          	li	s1,0
    do{
        buf[i++] = digits[x % base];
    80004ef8:	0009079b          	sext.w	a5,s2
    80004efc:	0325773b          	remuw	a4,a0,s2
    80004f00:	00048613          	mv	a2,s1
    80004f04:	0014849b          	addiw	s1,s1,1
    80004f08:	02071693          	slli	a3,a4,0x20
    80004f0c:	0206d693          	srli	a3,a3,0x20
    80004f10:	00006717          	auipc	a4,0x6
    80004f14:	2d870713          	addi	a4,a4,728 # 8000b1e8 <digits>
    80004f18:	00d70733          	add	a4,a4,a3
    80004f1c:	00074683          	lbu	a3,0(a4)
    80004f20:	fd040713          	addi	a4,s0,-48
    80004f24:	00c70733          	add	a4,a4,a2
    80004f28:	fed70823          	sb	a3,-16(a4)
    }while((x /= base) != 0);
    80004f2c:	0005071b          	sext.w	a4,a0
    80004f30:	0325553b          	divuw	a0,a0,s2
    80004f34:	fcf772e3          	bgeu	a4,a5,80004ef8 <_Z8printIntiii+0x64>
    if(neg)
    80004f38:	00058c63          	beqz	a1,80004f50 <_Z8printIntiii+0xbc>
        buf[i++] = '-';
    80004f3c:	fd040793          	addi	a5,s0,-48
    80004f40:	009784b3          	add	s1,a5,s1
    80004f44:	02d00793          	li	a5,45
    80004f48:	fef48823          	sb	a5,-16(s1)
    80004f4c:	0026049b          	addiw	s1,a2,2

    while(--i >= 0)
    80004f50:	fff4849b          	addiw	s1,s1,-1
    80004f54:	0204c463          	bltz	s1,80004f7c <_Z8printIntiii+0xe8>
        putc(buf[i]);
    80004f58:	fd040793          	addi	a5,s0,-48
    80004f5c:	009787b3          	add	a5,a5,s1
    80004f60:	ff07c503          	lbu	a0,-16(a5)
    80004f64:	ffffc097          	auipc	ra,0xffffc
    80004f68:	64c080e7          	jalr	1612(ra) # 800015b0 <_Z4putcc>
    80004f6c:	fe5ff06f          	j	80004f50 <_Z8printIntiii+0xbc>
        x = -xx;
    80004f70:	4090053b          	negw	a0,s1
        neg = 1;
    80004f74:	00100593          	li	a1,1
        x = -xx;
    80004f78:	f7dff06f          	j	80004ef4 <_Z8printIntiii+0x60>

    UNLOCK();
    80004f7c:	00000613          	li	a2,0
    80004f80:	00100593          	li	a1,1
    80004f84:	00009517          	auipc	a0,0x9
    80004f88:	79c50513          	addi	a0,a0,1948 # 8000e720 <lockPrint>
    80004f8c:	ffffc097          	auipc	ra,0xffffc
    80004f90:	2d4080e7          	jalr	724(ra) # 80001260 <copy_and_swap>
    80004f94:	fe0514e3          	bnez	a0,80004f7c <_Z8printIntiii+0xe8>
    80004f98:	03813083          	ld	ra,56(sp)
    80004f9c:	03013403          	ld	s0,48(sp)
    80004fa0:	02813483          	ld	s1,40(sp)
    80004fa4:	02013903          	ld	s2,32(sp)
    80004fa8:	01813983          	ld	s3,24(sp)
    80004fac:	04010113          	addi	sp,sp,64
    80004fb0:	00008067          	ret

0000000080004fb4 <_ZN9BufferCPPC1Ei>:
#include "buffer_CPP_API.hpp"

BufferCPP::BufferCPP(int _cap) : cap(_cap + 1), head(0), tail(0) {
    80004fb4:	fd010113          	addi	sp,sp,-48
    80004fb8:	02113423          	sd	ra,40(sp)
    80004fbc:	02813023          	sd	s0,32(sp)
    80004fc0:	00913c23          	sd	s1,24(sp)
    80004fc4:	01213823          	sd	s2,16(sp)
    80004fc8:	01313423          	sd	s3,8(sp)
    80004fcc:	03010413          	addi	s0,sp,48
    80004fd0:	00050493          	mv	s1,a0
    80004fd4:	00058993          	mv	s3,a1
    80004fd8:	0015879b          	addiw	a5,a1,1
    80004fdc:	0007851b          	sext.w	a0,a5
    80004fe0:	00f4a023          	sw	a5,0(s1)
    80004fe4:	0004a823          	sw	zero,16(s1)
    80004fe8:	0004aa23          	sw	zero,20(s1)
    buffer = (int *)mem_alloc(sizeof(int) * cap);
    80004fec:	00251513          	slli	a0,a0,0x2
    80004ff0:	ffffc097          	auipc	ra,0xffffc
    80004ff4:	290080e7          	jalr	656(ra) # 80001280 <_Z9mem_allocm>
    80004ff8:	00a4b423          	sd	a0,8(s1)
    itemAvailable = new Semaphore(0);
    80004ffc:	01000513          	li	a0,16
    80005000:	ffffd097          	auipc	ra,0xffffd
    80005004:	d68080e7          	jalr	-664(ra) # 80001d68 <_Znwm>
    80005008:	00050913          	mv	s2,a0
        Semaphore (unsigned init = 1){
    8000500c:	00006797          	auipc	a5,0x6
    80005010:	0dc78793          	addi	a5,a5,220 # 8000b0e8 <_ZTV9Semaphore+0x10>
    80005014:	00f53023          	sd	a5,0(a0)
            sem_open(&myHandle,init);
    80005018:	00000593          	li	a1,0
    8000501c:	00850513          	addi	a0,a0,8
    80005020:	ffffc097          	auipc	ra,0xffffc
    80005024:	41c080e7          	jalr	1052(ra) # 8000143c <_Z8sem_openPP5sem_sj>
    80005028:	0324b023          	sd	s2,32(s1)
    spaceAvailable = new Semaphore(_cap);
    8000502c:	01000513          	li	a0,16
    80005030:	ffffd097          	auipc	ra,0xffffd
    80005034:	d38080e7          	jalr	-712(ra) # 80001d68 <_Znwm>
    80005038:	00050913          	mv	s2,a0
        Semaphore (unsigned init = 1){
    8000503c:	00006797          	auipc	a5,0x6
    80005040:	0ac78793          	addi	a5,a5,172 # 8000b0e8 <_ZTV9Semaphore+0x10>
    80005044:	00f53023          	sd	a5,0(a0)
            sem_open(&myHandle,init);
    80005048:	00098593          	mv	a1,s3
    8000504c:	00850513          	addi	a0,a0,8
    80005050:	ffffc097          	auipc	ra,0xffffc
    80005054:	3ec080e7          	jalr	1004(ra) # 8000143c <_Z8sem_openPP5sem_sj>
    80005058:	0124bc23          	sd	s2,24(s1)
    mutexHead = new Semaphore(1);
    8000505c:	01000513          	li	a0,16
    80005060:	ffffd097          	auipc	ra,0xffffd
    80005064:	d08080e7          	jalr	-760(ra) # 80001d68 <_Znwm>
    80005068:	00050913          	mv	s2,a0
        Semaphore (unsigned init = 1){
    8000506c:	00006797          	auipc	a5,0x6
    80005070:	07c78793          	addi	a5,a5,124 # 8000b0e8 <_ZTV9Semaphore+0x10>
    80005074:	00f53023          	sd	a5,0(a0)
            sem_open(&myHandle,init);
    80005078:	00100593          	li	a1,1
    8000507c:	00850513          	addi	a0,a0,8
    80005080:	ffffc097          	auipc	ra,0xffffc
    80005084:	3bc080e7          	jalr	956(ra) # 8000143c <_Z8sem_openPP5sem_sj>
    80005088:	0324b423          	sd	s2,40(s1)
    mutexTail = new Semaphore(1);
    8000508c:	01000513          	li	a0,16
    80005090:	ffffd097          	auipc	ra,0xffffd
    80005094:	cd8080e7          	jalr	-808(ra) # 80001d68 <_Znwm>
    80005098:	00050913          	mv	s2,a0
        Semaphore (unsigned init = 1){
    8000509c:	00006797          	auipc	a5,0x6
    800050a0:	04c78793          	addi	a5,a5,76 # 8000b0e8 <_ZTV9Semaphore+0x10>
    800050a4:	00f53023          	sd	a5,0(a0)
            sem_open(&myHandle,init);
    800050a8:	00100593          	li	a1,1
    800050ac:	00850513          	addi	a0,a0,8
    800050b0:	ffffc097          	auipc	ra,0xffffc
    800050b4:	38c080e7          	jalr	908(ra) # 8000143c <_Z8sem_openPP5sem_sj>
    800050b8:	0324b823          	sd	s2,48(s1)
}
    800050bc:	02813083          	ld	ra,40(sp)
    800050c0:	02013403          	ld	s0,32(sp)
    800050c4:	01813483          	ld	s1,24(sp)
    800050c8:	01013903          	ld	s2,16(sp)
    800050cc:	00813983          	ld	s3,8(sp)
    800050d0:	03010113          	addi	sp,sp,48
    800050d4:	00008067          	ret
    800050d8:	00050493          	mv	s1,a0
    itemAvailable = new Semaphore(0);
    800050dc:	00090513          	mv	a0,s2
    800050e0:	ffffd097          	auipc	ra,0xffffd
    800050e4:	cb0080e7          	jalr	-848(ra) # 80001d90 <_ZdlPv>
    800050e8:	00048513          	mv	a0,s1
    800050ec:	0000a097          	auipc	ra,0xa
    800050f0:	70c080e7          	jalr	1804(ra) # 8000f7f8 <_Unwind_Resume>
    800050f4:	00050493          	mv	s1,a0
    spaceAvailable = new Semaphore(_cap);
    800050f8:	00090513          	mv	a0,s2
    800050fc:	ffffd097          	auipc	ra,0xffffd
    80005100:	c94080e7          	jalr	-876(ra) # 80001d90 <_ZdlPv>
    80005104:	00048513          	mv	a0,s1
    80005108:	0000a097          	auipc	ra,0xa
    8000510c:	6f0080e7          	jalr	1776(ra) # 8000f7f8 <_Unwind_Resume>
    80005110:	00050493          	mv	s1,a0
    mutexHead = new Semaphore(1);
    80005114:	00090513          	mv	a0,s2
    80005118:	ffffd097          	auipc	ra,0xffffd
    8000511c:	c78080e7          	jalr	-904(ra) # 80001d90 <_ZdlPv>
    80005120:	00048513          	mv	a0,s1
    80005124:	0000a097          	auipc	ra,0xa
    80005128:	6d4080e7          	jalr	1748(ra) # 8000f7f8 <_Unwind_Resume>
    8000512c:	00050493          	mv	s1,a0
    mutexTail = new Semaphore(1);
    80005130:	00090513          	mv	a0,s2
    80005134:	ffffd097          	auipc	ra,0xffffd
    80005138:	c5c080e7          	jalr	-932(ra) # 80001d90 <_ZdlPv>
    8000513c:	00048513          	mv	a0,s1
    80005140:	0000a097          	auipc	ra,0xa
    80005144:	6b8080e7          	jalr	1720(ra) # 8000f7f8 <_Unwind_Resume>

0000000080005148 <_ZN9BufferCPP3putEi>:
    delete mutexTail;
    delete mutexHead;

}

void BufferCPP::put(int val) {
    80005148:	fe010113          	addi	sp,sp,-32
    8000514c:	00113c23          	sd	ra,24(sp)
    80005150:	00813823          	sd	s0,16(sp)
    80005154:	00913423          	sd	s1,8(sp)
    80005158:	01213023          	sd	s2,0(sp)
    8000515c:	02010413          	addi	s0,sp,32
    80005160:	00050493          	mv	s1,a0
    80005164:	00058913          	mv	s2,a1
    spaceAvailable->wait();
    80005168:	01853783          	ld	a5,24(a0)
            return sem_wait(myHandle);
    8000516c:	0087b503          	ld	a0,8(a5)
    80005170:	ffffc097          	auipc	ra,0xffffc
    80005174:	350080e7          	jalr	848(ra) # 800014c0 <_Z8sem_waitP5sem_s>

    mutexTail->wait();
    80005178:	0304b783          	ld	a5,48(s1)
    8000517c:	0087b503          	ld	a0,8(a5)
    80005180:	ffffc097          	auipc	ra,0xffffc
    80005184:	340080e7          	jalr	832(ra) # 800014c0 <_Z8sem_waitP5sem_s>
    buffer[tail] = val;
    80005188:	0084b783          	ld	a5,8(s1)
    8000518c:	0144a703          	lw	a4,20(s1)
    80005190:	00271713          	slli	a4,a4,0x2
    80005194:	00e787b3          	add	a5,a5,a4
    80005198:	0127a023          	sw	s2,0(a5)
    tail = (tail + 1) % cap;
    8000519c:	0144a783          	lw	a5,20(s1)
    800051a0:	0017879b          	addiw	a5,a5,1
    800051a4:	0004a703          	lw	a4,0(s1)
    800051a8:	02e7e7bb          	remw	a5,a5,a4
    800051ac:	00f4aa23          	sw	a5,20(s1)
    mutexTail->signal();
    800051b0:	0304b783          	ld	a5,48(s1)
            return sem_signal(myHandle);
    800051b4:	0087b503          	ld	a0,8(a5)
    800051b8:	ffffc097          	auipc	ra,0xffffc
    800051bc:	348080e7          	jalr	840(ra) # 80001500 <_Z10sem_signalP5sem_s>

    itemAvailable->signal();
    800051c0:	0204b783          	ld	a5,32(s1)
    800051c4:	0087b503          	ld	a0,8(a5)
    800051c8:	ffffc097          	auipc	ra,0xffffc
    800051cc:	338080e7          	jalr	824(ra) # 80001500 <_Z10sem_signalP5sem_s>

}
    800051d0:	01813083          	ld	ra,24(sp)
    800051d4:	01013403          	ld	s0,16(sp)
    800051d8:	00813483          	ld	s1,8(sp)
    800051dc:	00013903          	ld	s2,0(sp)
    800051e0:	02010113          	addi	sp,sp,32
    800051e4:	00008067          	ret

00000000800051e8 <_ZN9BufferCPP3getEv>:

int BufferCPP::get() {
    800051e8:	fe010113          	addi	sp,sp,-32
    800051ec:	00113c23          	sd	ra,24(sp)
    800051f0:	00813823          	sd	s0,16(sp)
    800051f4:	00913423          	sd	s1,8(sp)
    800051f8:	01213023          	sd	s2,0(sp)
    800051fc:	02010413          	addi	s0,sp,32
    80005200:	00050493          	mv	s1,a0
    itemAvailable->wait();
    80005204:	02053783          	ld	a5,32(a0)
            return sem_wait(myHandle);
    80005208:	0087b503          	ld	a0,8(a5)
    8000520c:	ffffc097          	auipc	ra,0xffffc
    80005210:	2b4080e7          	jalr	692(ra) # 800014c0 <_Z8sem_waitP5sem_s>

    mutexHead->wait();
    80005214:	0284b783          	ld	a5,40(s1)
    80005218:	0087b503          	ld	a0,8(a5)
    8000521c:	ffffc097          	auipc	ra,0xffffc
    80005220:	2a4080e7          	jalr	676(ra) # 800014c0 <_Z8sem_waitP5sem_s>

    int ret = buffer[head];
    80005224:	0084b703          	ld	a4,8(s1)
    80005228:	0104a783          	lw	a5,16(s1)
    8000522c:	00279693          	slli	a3,a5,0x2
    80005230:	00d70733          	add	a4,a4,a3
    80005234:	00072903          	lw	s2,0(a4)
    head = (head + 1) % cap;
    80005238:	0017879b          	addiw	a5,a5,1
    8000523c:	0004a703          	lw	a4,0(s1)
    80005240:	02e7e7bb          	remw	a5,a5,a4
    80005244:	00f4a823          	sw	a5,16(s1)
    mutexHead->signal();
    80005248:	0284b783          	ld	a5,40(s1)
            return sem_signal(myHandle);
    8000524c:	0087b503          	ld	a0,8(a5)
    80005250:	ffffc097          	auipc	ra,0xffffc
    80005254:	2b0080e7          	jalr	688(ra) # 80001500 <_Z10sem_signalP5sem_s>

    spaceAvailable->signal();
    80005258:	0184b783          	ld	a5,24(s1)
    8000525c:	0087b503          	ld	a0,8(a5)
    80005260:	ffffc097          	auipc	ra,0xffffc
    80005264:	2a0080e7          	jalr	672(ra) # 80001500 <_Z10sem_signalP5sem_s>

    return ret;
}
    80005268:	00090513          	mv	a0,s2
    8000526c:	01813083          	ld	ra,24(sp)
    80005270:	01013403          	ld	s0,16(sp)
    80005274:	00813483          	ld	s1,8(sp)
    80005278:	00013903          	ld	s2,0(sp)
    8000527c:	02010113          	addi	sp,sp,32
    80005280:	00008067          	ret

0000000080005284 <_ZN9BufferCPP6getCntEv>:

int BufferCPP::getCnt() {
    80005284:	fe010113          	addi	sp,sp,-32
    80005288:	00113c23          	sd	ra,24(sp)
    8000528c:	00813823          	sd	s0,16(sp)
    80005290:	00913423          	sd	s1,8(sp)
    80005294:	01213023          	sd	s2,0(sp)
    80005298:	02010413          	addi	s0,sp,32
    8000529c:	00050493          	mv	s1,a0
    int ret;

    mutexHead->wait();
    800052a0:	02853783          	ld	a5,40(a0)
            return sem_wait(myHandle);
    800052a4:	0087b503          	ld	a0,8(a5)
    800052a8:	ffffc097          	auipc	ra,0xffffc
    800052ac:	218080e7          	jalr	536(ra) # 800014c0 <_Z8sem_waitP5sem_s>
    mutexTail->wait();
    800052b0:	0304b783          	ld	a5,48(s1)
    800052b4:	0087b503          	ld	a0,8(a5)
    800052b8:	ffffc097          	auipc	ra,0xffffc
    800052bc:	208080e7          	jalr	520(ra) # 800014c0 <_Z8sem_waitP5sem_s>

    if (tail >= head) {
    800052c0:	0144a783          	lw	a5,20(s1)
    800052c4:	0104a903          	lw	s2,16(s1)
    800052c8:	0527c263          	blt	a5,s2,8000530c <_ZN9BufferCPP6getCntEv+0x88>
        ret = tail - head;
    800052cc:	4127893b          	subw	s2,a5,s2
    } else {
        ret = cap - head + tail;
    }

    mutexTail->signal();
    800052d0:	0304b783          	ld	a5,48(s1)
            return sem_signal(myHandle);
    800052d4:	0087b503          	ld	a0,8(a5)
    800052d8:	ffffc097          	auipc	ra,0xffffc
    800052dc:	228080e7          	jalr	552(ra) # 80001500 <_Z10sem_signalP5sem_s>
    mutexHead->signal();
    800052e0:	0284b783          	ld	a5,40(s1)
    800052e4:	0087b503          	ld	a0,8(a5)
    800052e8:	ffffc097          	auipc	ra,0xffffc
    800052ec:	218080e7          	jalr	536(ra) # 80001500 <_Z10sem_signalP5sem_s>

    return ret;
}
    800052f0:	00090513          	mv	a0,s2
    800052f4:	01813083          	ld	ra,24(sp)
    800052f8:	01013403          	ld	s0,16(sp)
    800052fc:	00813483          	ld	s1,8(sp)
    80005300:	00013903          	ld	s2,0(sp)
    80005304:	02010113          	addi	sp,sp,32
    80005308:	00008067          	ret
        ret = cap - head + tail;
    8000530c:	0004a703          	lw	a4,0(s1)
    80005310:	4127093b          	subw	s2,a4,s2
    80005314:	00f9093b          	addw	s2,s2,a5
    80005318:	fb9ff06f          	j	800052d0 <_ZN9BufferCPP6getCntEv+0x4c>

000000008000531c <_ZN9BufferCPPD1Ev>:
BufferCPP::~BufferCPP() {
    8000531c:	fe010113          	addi	sp,sp,-32
    80005320:	00113c23          	sd	ra,24(sp)
    80005324:	00813823          	sd	s0,16(sp)
    80005328:	00913423          	sd	s1,8(sp)
    8000532c:	02010413          	addi	s0,sp,32
    80005330:	00050493          	mv	s1,a0
            ::putc(c);
    80005334:	00a00513          	li	a0,10
    80005338:	00003097          	auipc	ra,0x3
    8000533c:	d34080e7          	jalr	-716(ra) # 8000806c <__putc>
    printString("Buffer deleted!\n");
    80005340:	00004517          	auipc	a0,0x4
    80005344:	fd850513          	addi	a0,a0,-40 # 80009318 <CONSOLE_STATUS+0x308>
    80005348:	00000097          	auipc	ra,0x0
    8000534c:	99c080e7          	jalr	-1636(ra) # 80004ce4 <_Z11printStringPKc>
    while (getCnt()) {
    80005350:	00048513          	mv	a0,s1
    80005354:	00000097          	auipc	ra,0x0
    80005358:	f30080e7          	jalr	-208(ra) # 80005284 <_ZN9BufferCPP6getCntEv>
    8000535c:	02050c63          	beqz	a0,80005394 <_ZN9BufferCPPD1Ev+0x78>
        char ch = buffer[head];
    80005360:	0084b783          	ld	a5,8(s1)
    80005364:	0104a703          	lw	a4,16(s1)
    80005368:	00271713          	slli	a4,a4,0x2
    8000536c:	00e787b3          	add	a5,a5,a4
    80005370:	0007c503          	lbu	a0,0(a5)
    80005374:	00003097          	auipc	ra,0x3
    80005378:	cf8080e7          	jalr	-776(ra) # 8000806c <__putc>
        head = (head + 1) % cap;
    8000537c:	0104a783          	lw	a5,16(s1)
    80005380:	0017879b          	addiw	a5,a5,1
    80005384:	0004a703          	lw	a4,0(s1)
    80005388:	02e7e7bb          	remw	a5,a5,a4
    8000538c:	00f4a823          	sw	a5,16(s1)
    while (getCnt()) {
    80005390:	fc1ff06f          	j	80005350 <_ZN9BufferCPPD1Ev+0x34>
    80005394:	02100513          	li	a0,33
    80005398:	00003097          	auipc	ra,0x3
    8000539c:	cd4080e7          	jalr	-812(ra) # 8000806c <__putc>
    800053a0:	00a00513          	li	a0,10
    800053a4:	00003097          	auipc	ra,0x3
    800053a8:	cc8080e7          	jalr	-824(ra) # 8000806c <__putc>
    mem_free(buffer);
    800053ac:	0084b503          	ld	a0,8(s1)
    800053b0:	ffffc097          	auipc	ra,0xffffc
    800053b4:	f10080e7          	jalr	-240(ra) # 800012c0 <_Z8mem_freePv>
    delete itemAvailable;
    800053b8:	0204b503          	ld	a0,32(s1)
    800053bc:	00050863          	beqz	a0,800053cc <_ZN9BufferCPPD1Ev+0xb0>
    800053c0:	00053783          	ld	a5,0(a0)
    800053c4:	0087b783          	ld	a5,8(a5)
    800053c8:	000780e7          	jalr	a5
    delete spaceAvailable;
    800053cc:	0184b503          	ld	a0,24(s1)
    800053d0:	00050863          	beqz	a0,800053e0 <_ZN9BufferCPPD1Ev+0xc4>
    800053d4:	00053783          	ld	a5,0(a0)
    800053d8:	0087b783          	ld	a5,8(a5)
    800053dc:	000780e7          	jalr	a5
    delete mutexTail;
    800053e0:	0304b503          	ld	a0,48(s1)
    800053e4:	00050863          	beqz	a0,800053f4 <_ZN9BufferCPPD1Ev+0xd8>
    800053e8:	00053783          	ld	a5,0(a0)
    800053ec:	0087b783          	ld	a5,8(a5)
    800053f0:	000780e7          	jalr	a5
    delete mutexHead;
    800053f4:	0284b503          	ld	a0,40(s1)
    800053f8:	00050863          	beqz	a0,80005408 <_ZN9BufferCPPD1Ev+0xec>
    800053fc:	00053783          	ld	a5,0(a0)
    80005400:	0087b783          	ld	a5,8(a5)
    80005404:	000780e7          	jalr	a5
}
    80005408:	01813083          	ld	ra,24(sp)
    8000540c:	01013403          	ld	s0,16(sp)
    80005410:	00813483          	ld	s1,8(sp)
    80005414:	02010113          	addi	sp,sp,32
    80005418:	00008067          	ret

000000008000541c <_Z8userMainv>:
#include "../test/ConsumerProducer_CPP_API_test.hpp"
#include "System_Mode_test.hpp"

#endif

void userMain() {
    8000541c:	fe010113          	addi	sp,sp,-32
    80005420:	00113c23          	sd	ra,24(sp)
    80005424:	00813823          	sd	s0,16(sp)
    80005428:	00913423          	sd	s1,8(sp)
    8000542c:	02010413          	addi	s0,sp,32
    printString("Unesite broj testa? [1-7]\n");
    80005430:	00004517          	auipc	a0,0x4
    80005434:	f0050513          	addi	a0,a0,-256 # 80009330 <CONSOLE_STATUS+0x320>
    80005438:	00000097          	auipc	ra,0x0
    8000543c:	8ac080e7          	jalr	-1876(ra) # 80004ce4 <_Z11printStringPKc>
    int test = getc() - '0';
    80005440:	ffffc097          	auipc	ra,0xffffc
    80005444:	134080e7          	jalr	308(ra) # 80001574 <_Z4getcv>
    80005448:	fd05049b          	addiw	s1,a0,-48
    getc(); // Enter posle broja
    8000544c:	ffffc097          	auipc	ra,0xffffc
    80005450:	128080e7          	jalr	296(ra) # 80001574 <_Z4getcv>
            printString("Nije navedeno da je zadatak 4 implementiran\n");
            return;
        }
    }

    switch (test) {
    80005454:	00700793          	li	a5,7
    80005458:	1097e263          	bltu	a5,s1,8000555c <_Z8userMainv+0x140>
    8000545c:	00249493          	slli	s1,s1,0x2
    80005460:	00004717          	auipc	a4,0x4
    80005464:	12870713          	addi	a4,a4,296 # 80009588 <CONSOLE_STATUS+0x578>
    80005468:	00e484b3          	add	s1,s1,a4
    8000546c:	0004a783          	lw	a5,0(s1)
    80005470:	00e787b3          	add	a5,a5,a4
    80005474:	00078067          	jr	a5
        case 1:
#if LEVEL_2_IMPLEMENTED == 1
            Threads_C_API_test();
    80005478:	fffff097          	auipc	ra,0xfffff
    8000547c:	fb4080e7          	jalr	-76(ra) # 8000442c <_Z18Threads_C_API_testv>
            printString("TEST 1 (zadatak 2, niti C API i sinhrona promena konteksta)\n");
    80005480:	00004517          	auipc	a0,0x4
    80005484:	ed050513          	addi	a0,a0,-304 # 80009350 <CONSOLE_STATUS+0x340>
    80005488:	00000097          	auipc	ra,0x0
    8000548c:	85c080e7          	jalr	-1956(ra) # 80004ce4 <_Z11printStringPKc>
#endif
            break;
        default:
            printString("Niste uneli odgovarajuci broj za test\n");
    }
    80005490:	01813083          	ld	ra,24(sp)
    80005494:	01013403          	ld	s0,16(sp)
    80005498:	00813483          	ld	s1,8(sp)
    8000549c:	02010113          	addi	sp,sp,32
    800054a0:	00008067          	ret
            Threads_CPP_API_test();
    800054a4:	ffffe097          	auipc	ra,0xffffe
    800054a8:	fe8080e7          	jalr	-24(ra) # 8000348c <_Z20Threads_CPP_API_testv>
            printString("TEST 2 (zadatak 2., niti CPP API i sinhrona promena konteksta)\n");
    800054ac:	00004517          	auipc	a0,0x4
    800054b0:	ee450513          	addi	a0,a0,-284 # 80009390 <CONSOLE_STATUS+0x380>
    800054b4:	00000097          	auipc	ra,0x0
    800054b8:	830080e7          	jalr	-2000(ra) # 80004ce4 <_Z11printStringPKc>
            break;
    800054bc:	fd5ff06f          	j	80005490 <_Z8userMainv+0x74>
            producerConsumer_C_API();
    800054c0:	ffffe097          	auipc	ra,0xffffe
    800054c4:	820080e7          	jalr	-2016(ra) # 80002ce0 <_Z22producerConsumer_C_APIv>
            printString("TEST 3 (zadatak 3., kompletan C API sa semaforima, sinhrona promena konteksta)\n");
    800054c8:	00004517          	auipc	a0,0x4
    800054cc:	f0850513          	addi	a0,a0,-248 # 800093d0 <CONSOLE_STATUS+0x3c0>
    800054d0:	00000097          	auipc	ra,0x0
    800054d4:	814080e7          	jalr	-2028(ra) # 80004ce4 <_Z11printStringPKc>
            break;
    800054d8:	fb9ff06f          	j	80005490 <_Z8userMainv+0x74>
            producerConsumer_CPP_Sync_API();
    800054dc:	fffff097          	auipc	ra,0xfffff
    800054e0:	2a0080e7          	jalr	672(ra) # 8000477c <_Z29producerConsumer_CPP_Sync_APIv>
            printString("TEST 4 (zadatak 3., kompletan CPP API sa semaforima, sinhrona promena konteksta)\n");
    800054e4:	00004517          	auipc	a0,0x4
    800054e8:	f3c50513          	addi	a0,a0,-196 # 80009420 <CONSOLE_STATUS+0x410>
    800054ec:	fffff097          	auipc	ra,0xfffff
    800054f0:	7f8080e7          	jalr	2040(ra) # 80004ce4 <_Z11printStringPKc>
            break;
    800054f4:	f9dff06f          	j	80005490 <_Z8userMainv+0x74>
            testSleeping();
    800054f8:	00000097          	auipc	ra,0x0
    800054fc:	11c080e7          	jalr	284(ra) # 80005614 <_Z12testSleepingv>
            printString("TEST 5 (zadatak 4., thread_sleep test C API)\n");
    80005500:	00004517          	auipc	a0,0x4
    80005504:	f7850513          	addi	a0,a0,-136 # 80009478 <CONSOLE_STATUS+0x468>
    80005508:	fffff097          	auipc	ra,0xfffff
    8000550c:	7dc080e7          	jalr	2012(ra) # 80004ce4 <_Z11printStringPKc>
            break;
    80005510:	f81ff06f          	j	80005490 <_Z8userMainv+0x74>
            testConsumerProducer();
    80005514:	ffffe097          	auipc	ra,0xffffe
    80005518:	2dc080e7          	jalr	732(ra) # 800037f0 <_Z20testConsumerProducerv>
            printString("TEST 6 (zadatak 4. CPP API i asinhrona promena konteksta)\n");
    8000551c:	00004517          	auipc	a0,0x4
    80005520:	f8c50513          	addi	a0,a0,-116 # 800094a8 <CONSOLE_STATUS+0x498>
    80005524:	fffff097          	auipc	ra,0xfffff
    80005528:	7c0080e7          	jalr	1984(ra) # 80004ce4 <_Z11printStringPKc>
            break;
    8000552c:	f65ff06f          	j	80005490 <_Z8userMainv+0x74>
            System_Mode_test();
    80005530:	00000097          	auipc	ra,0x0
    80005534:	658080e7          	jalr	1624(ra) # 80005b88 <_Z16System_Mode_testv>
            printString("Test se nije uspesno zavrsio\n");
    80005538:	00004517          	auipc	a0,0x4
    8000553c:	fb050513          	addi	a0,a0,-80 # 800094e8 <CONSOLE_STATUS+0x4d8>
    80005540:	fffff097          	auipc	ra,0xfffff
    80005544:	7a4080e7          	jalr	1956(ra) # 80004ce4 <_Z11printStringPKc>
            printString("TEST 7 (zadatak 2., testiranje da li se korisnicki kod izvrsava u korisnickom rezimu)\n");
    80005548:	00004517          	auipc	a0,0x4
    8000554c:	fc050513          	addi	a0,a0,-64 # 80009508 <CONSOLE_STATUS+0x4f8>
    80005550:	fffff097          	auipc	ra,0xfffff
    80005554:	794080e7          	jalr	1940(ra) # 80004ce4 <_Z11printStringPKc>
            break;
    80005558:	f39ff06f          	j	80005490 <_Z8userMainv+0x74>
            printString("Niste uneli odgovarajuci broj za test\n");
    8000555c:	00004517          	auipc	a0,0x4
    80005560:	00450513          	addi	a0,a0,4 # 80009560 <CONSOLE_STATUS+0x550>
    80005564:	fffff097          	auipc	ra,0xfffff
    80005568:	780080e7          	jalr	1920(ra) # 80004ce4 <_Z11printStringPKc>
    8000556c:	f25ff06f          	j	80005490 <_Z8userMainv+0x74>

0000000080005570 <_ZL9sleepyRunPv>:

#include "printing.hpp"

static volatile bool finished[2];

static void sleepyRun(void *arg) {
    80005570:	fe010113          	addi	sp,sp,-32
    80005574:	00113c23          	sd	ra,24(sp)
    80005578:	00813823          	sd	s0,16(sp)
    8000557c:	00913423          	sd	s1,8(sp)
    80005580:	01213023          	sd	s2,0(sp)
    80005584:	02010413          	addi	s0,sp,32
    time_t sleep_time = *((time_t *) arg);
    80005588:	00053903          	ld	s2,0(a0)
    int i = 6;
    8000558c:	00600493          	li	s1,6
    while (--i > 0) {
    80005590:	fff4849b          	addiw	s1,s1,-1
    80005594:	04905463          	blez	s1,800055dc <_ZL9sleepyRunPv+0x6c>

        printString("Hello ");
    80005598:	00004517          	auipc	a0,0x4
    8000559c:	01050513          	addi	a0,a0,16 # 800095a8 <CONSOLE_STATUS+0x598>
    800055a0:	fffff097          	auipc	ra,0xfffff
    800055a4:	744080e7          	jalr	1860(ra) # 80004ce4 <_Z11printStringPKc>
        printInt(sleep_time);
    800055a8:	00000613          	li	a2,0
    800055ac:	00a00593          	li	a1,10
    800055b0:	0009051b          	sext.w	a0,s2
    800055b4:	00000097          	auipc	ra,0x0
    800055b8:	8e0080e7          	jalr	-1824(ra) # 80004e94 <_Z8printIntiii>
        printString(" !\n");
    800055bc:	00004517          	auipc	a0,0x4
    800055c0:	ff450513          	addi	a0,a0,-12 # 800095b0 <CONSOLE_STATUS+0x5a0>
    800055c4:	fffff097          	auipc	ra,0xfffff
    800055c8:	720080e7          	jalr	1824(ra) # 80004ce4 <_Z11printStringPKc>
        time_sleep(sleep_time);
    800055cc:	00090513          	mv	a0,s2
    800055d0:	ffffc097          	auipc	ra,0xffffc
    800055d4:	f70080e7          	jalr	-144(ra) # 80001540 <_Z10time_sleepm>
    while (--i > 0) {
    800055d8:	fb9ff06f          	j	80005590 <_ZL9sleepyRunPv+0x20>
    }
    finished[sleep_time/10-1] = true;
    800055dc:	00a00793          	li	a5,10
    800055e0:	02f95933          	divu	s2,s2,a5
    800055e4:	fff90913          	addi	s2,s2,-1
    800055e8:	00009797          	auipc	a5,0x9
    800055ec:	14078793          	addi	a5,a5,320 # 8000e728 <_ZL8finished>
    800055f0:	01278933          	add	s2,a5,s2
    800055f4:	00100793          	li	a5,1
    800055f8:	00f90023          	sb	a5,0(s2)
}
    800055fc:	01813083          	ld	ra,24(sp)
    80005600:	01013403          	ld	s0,16(sp)
    80005604:	00813483          	ld	s1,8(sp)
    80005608:	00013903          	ld	s2,0(sp)
    8000560c:	02010113          	addi	sp,sp,32
    80005610:	00008067          	ret

0000000080005614 <_Z12testSleepingv>:

void testSleeping() {
    80005614:	fc010113          	addi	sp,sp,-64
    80005618:	02113c23          	sd	ra,56(sp)
    8000561c:	02813823          	sd	s0,48(sp)
    80005620:	02913423          	sd	s1,40(sp)
    80005624:	04010413          	addi	s0,sp,64
    const int sleepy_thread_count = 2;
    time_t sleep_times[sleepy_thread_count] = {10, 20};
    80005628:	00a00793          	li	a5,10
    8000562c:	fcf43823          	sd	a5,-48(s0)
    80005630:	01400793          	li	a5,20
    80005634:	fcf43c23          	sd	a5,-40(s0)
    thread_t sleepyThread[sleepy_thread_count];

    for (int i = 0; i < sleepy_thread_count; i++) {
    80005638:	00000493          	li	s1,0
    8000563c:	02c0006f          	j	80005668 <_Z12testSleepingv+0x54>
        thread_create(&sleepyThread[i], sleepyRun, sleep_times + i);
    80005640:	00349793          	slli	a5,s1,0x3
    80005644:	fd040613          	addi	a2,s0,-48
    80005648:	00f60633          	add	a2,a2,a5
    8000564c:	00000597          	auipc	a1,0x0
    80005650:	f2458593          	addi	a1,a1,-220 # 80005570 <_ZL9sleepyRunPv>
    80005654:	fc040513          	addi	a0,s0,-64
    80005658:	00f50533          	add	a0,a0,a5
    8000565c:	ffffc097          	auipc	ra,0xffffc
    80005660:	ca4080e7          	jalr	-860(ra) # 80001300 <_Z13thread_createPP8thread_sPFvPvES2_>
    for (int i = 0; i < sleepy_thread_count; i++) {
    80005664:	0014849b          	addiw	s1,s1,1
    80005668:	00100793          	li	a5,1
    8000566c:	fc97dae3          	bge	a5,s1,80005640 <_Z12testSleepingv+0x2c>
    }

    while (!(finished[0] && finished[1])) {}
    80005670:	00009797          	auipc	a5,0x9
    80005674:	0b87c783          	lbu	a5,184(a5) # 8000e728 <_ZL8finished>
    80005678:	fe078ce3          	beqz	a5,80005670 <_Z12testSleepingv+0x5c>
    8000567c:	00009797          	auipc	a5,0x9
    80005680:	0ad7c783          	lbu	a5,173(a5) # 8000e729 <_ZL8finished+0x1>
    80005684:	fe0786e3          	beqz	a5,80005670 <_Z12testSleepingv+0x5c>
}
    80005688:	03813083          	ld	ra,56(sp)
    8000568c:	03013403          	ld	s0,48(sp)
    80005690:	02813483          	ld	s1,40(sp)
    80005694:	04010113          	addi	sp,sp,64
    80005698:	00008067          	ret

000000008000569c <_ZL9fibonaccim>:
static volatile bool finishedA = false;
static volatile bool finishedB = false;
static volatile bool finishedC = false;
static volatile bool finishedD = false;

static uint64 fibonacci(uint64 n) {
    8000569c:	fe010113          	addi	sp,sp,-32
    800056a0:	00113c23          	sd	ra,24(sp)
    800056a4:	00813823          	sd	s0,16(sp)
    800056a8:	00913423          	sd	s1,8(sp)
    800056ac:	01213023          	sd	s2,0(sp)
    800056b0:	02010413          	addi	s0,sp,32
    800056b4:	00050493          	mv	s1,a0
    if (n == 0 || n == 1) { return n; }
    800056b8:	00100793          	li	a5,1
    800056bc:	02a7f863          	bgeu	a5,a0,800056ec <_ZL9fibonaccim+0x50>
    if (n % 10 == 0) { thread_dispatch(); }
    800056c0:	00a00793          	li	a5,10
    800056c4:	02f577b3          	remu	a5,a0,a5
    800056c8:	02078e63          	beqz	a5,80005704 <_ZL9fibonaccim+0x68>
    return fibonacci(n - 1) + fibonacci(n - 2);
    800056cc:	fff48513          	addi	a0,s1,-1
    800056d0:	00000097          	auipc	ra,0x0
    800056d4:	fcc080e7          	jalr	-52(ra) # 8000569c <_ZL9fibonaccim>
    800056d8:	00050913          	mv	s2,a0
    800056dc:	ffe48513          	addi	a0,s1,-2
    800056e0:	00000097          	auipc	ra,0x0
    800056e4:	fbc080e7          	jalr	-68(ra) # 8000569c <_ZL9fibonaccim>
    800056e8:	00a90533          	add	a0,s2,a0
}
    800056ec:	01813083          	ld	ra,24(sp)
    800056f0:	01013403          	ld	s0,16(sp)
    800056f4:	00813483          	ld	s1,8(sp)
    800056f8:	00013903          	ld	s2,0(sp)
    800056fc:	02010113          	addi	sp,sp,32
    80005700:	00008067          	ret
    if (n % 10 == 0) { thread_dispatch(); }
    80005704:	ffffc097          	auipc	ra,0xffffc
    80005708:	c84080e7          	jalr	-892(ra) # 80001388 <_Z15thread_dispatchv>
    8000570c:	fc1ff06f          	j	800056cc <_ZL9fibonaccim+0x30>

0000000080005710 <_ZL11workerBodyDPv>:
    printString("A finished!\n");
    finishedC = true;
    thread_dispatch();
}

static void workerBodyD(void* arg) {
    80005710:	fe010113          	addi	sp,sp,-32
    80005714:	00113c23          	sd	ra,24(sp)
    80005718:	00813823          	sd	s0,16(sp)
    8000571c:	00913423          	sd	s1,8(sp)
    80005720:	01213023          	sd	s2,0(sp)
    80005724:	02010413          	addi	s0,sp,32
    uint8 i = 10;
    80005728:	00a00493          	li	s1,10
    8000572c:	0400006f          	j	8000576c <_ZL11workerBodyDPv+0x5c>
    for (; i < 13; i++) {
        printString("D: i="); printInt(i); printString("\n");
    80005730:	00004517          	auipc	a0,0x4
    80005734:	b5050513          	addi	a0,a0,-1200 # 80009280 <CONSOLE_STATUS+0x270>
    80005738:	fffff097          	auipc	ra,0xfffff
    8000573c:	5ac080e7          	jalr	1452(ra) # 80004ce4 <_Z11printStringPKc>
    80005740:	00000613          	li	a2,0
    80005744:	00a00593          	li	a1,10
    80005748:	00048513          	mv	a0,s1
    8000574c:	fffff097          	auipc	ra,0xfffff
    80005750:	748080e7          	jalr	1864(ra) # 80004e94 <_Z8printIntiii>
    80005754:	00004517          	auipc	a0,0x4
    80005758:	d1c50513          	addi	a0,a0,-740 # 80009470 <CONSOLE_STATUS+0x460>
    8000575c:	fffff097          	auipc	ra,0xfffff
    80005760:	588080e7          	jalr	1416(ra) # 80004ce4 <_Z11printStringPKc>
    for (; i < 13; i++) {
    80005764:	0014849b          	addiw	s1,s1,1
    80005768:	0ff4f493          	andi	s1,s1,255
    8000576c:	00c00793          	li	a5,12
    80005770:	fc97f0e3          	bgeu	a5,s1,80005730 <_ZL11workerBodyDPv+0x20>
    }

    printString("D: dispatch\n");
    80005774:	00004517          	auipc	a0,0x4
    80005778:	b1450513          	addi	a0,a0,-1260 # 80009288 <CONSOLE_STATUS+0x278>
    8000577c:	fffff097          	auipc	ra,0xfffff
    80005780:	568080e7          	jalr	1384(ra) # 80004ce4 <_Z11printStringPKc>
    __asm__ ("li t1, 5");
    80005784:	00500313          	li	t1,5
    thread_dispatch();
    80005788:	ffffc097          	auipc	ra,0xffffc
    8000578c:	c00080e7          	jalr	-1024(ra) # 80001388 <_Z15thread_dispatchv>

    uint64 result = fibonacci(16);
    80005790:	01000513          	li	a0,16
    80005794:	00000097          	auipc	ra,0x0
    80005798:	f08080e7          	jalr	-248(ra) # 8000569c <_ZL9fibonaccim>
    8000579c:	00050913          	mv	s2,a0
    printString("D: fibonaci="); printInt(result); printString("\n");
    800057a0:	00004517          	auipc	a0,0x4
    800057a4:	af850513          	addi	a0,a0,-1288 # 80009298 <CONSOLE_STATUS+0x288>
    800057a8:	fffff097          	auipc	ra,0xfffff
    800057ac:	53c080e7          	jalr	1340(ra) # 80004ce4 <_Z11printStringPKc>
    800057b0:	00000613          	li	a2,0
    800057b4:	00a00593          	li	a1,10
    800057b8:	0009051b          	sext.w	a0,s2
    800057bc:	fffff097          	auipc	ra,0xfffff
    800057c0:	6d8080e7          	jalr	1752(ra) # 80004e94 <_Z8printIntiii>
    800057c4:	00004517          	auipc	a0,0x4
    800057c8:	cac50513          	addi	a0,a0,-852 # 80009470 <CONSOLE_STATUS+0x460>
    800057cc:	fffff097          	auipc	ra,0xfffff
    800057d0:	518080e7          	jalr	1304(ra) # 80004ce4 <_Z11printStringPKc>
    800057d4:	0400006f          	j	80005814 <_ZL11workerBodyDPv+0x104>

    for (; i < 16; i++) {
        printString("D: i="); printInt(i); printString("\n");
    800057d8:	00004517          	auipc	a0,0x4
    800057dc:	aa850513          	addi	a0,a0,-1368 # 80009280 <CONSOLE_STATUS+0x270>
    800057e0:	fffff097          	auipc	ra,0xfffff
    800057e4:	504080e7          	jalr	1284(ra) # 80004ce4 <_Z11printStringPKc>
    800057e8:	00000613          	li	a2,0
    800057ec:	00a00593          	li	a1,10
    800057f0:	00048513          	mv	a0,s1
    800057f4:	fffff097          	auipc	ra,0xfffff
    800057f8:	6a0080e7          	jalr	1696(ra) # 80004e94 <_Z8printIntiii>
    800057fc:	00004517          	auipc	a0,0x4
    80005800:	c7450513          	addi	a0,a0,-908 # 80009470 <CONSOLE_STATUS+0x460>
    80005804:	fffff097          	auipc	ra,0xfffff
    80005808:	4e0080e7          	jalr	1248(ra) # 80004ce4 <_Z11printStringPKc>
    for (; i < 16; i++) {
    8000580c:	0014849b          	addiw	s1,s1,1
    80005810:	0ff4f493          	andi	s1,s1,255
    80005814:	00f00793          	li	a5,15
    80005818:	fc97f0e3          	bgeu	a5,s1,800057d8 <_ZL11workerBodyDPv+0xc8>
    }

    printString("D finished!\n");
    8000581c:	00004517          	auipc	a0,0x4
    80005820:	a8c50513          	addi	a0,a0,-1396 # 800092a8 <CONSOLE_STATUS+0x298>
    80005824:	fffff097          	auipc	ra,0xfffff
    80005828:	4c0080e7          	jalr	1216(ra) # 80004ce4 <_Z11printStringPKc>
    finishedD = true;
    8000582c:	00100793          	li	a5,1
    80005830:	00009717          	auipc	a4,0x9
    80005834:	eef70d23          	sb	a5,-262(a4) # 8000e72a <_ZL9finishedD>
    thread_dispatch();
    80005838:	ffffc097          	auipc	ra,0xffffc
    8000583c:	b50080e7          	jalr	-1200(ra) # 80001388 <_Z15thread_dispatchv>
}
    80005840:	01813083          	ld	ra,24(sp)
    80005844:	01013403          	ld	s0,16(sp)
    80005848:	00813483          	ld	s1,8(sp)
    8000584c:	00013903          	ld	s2,0(sp)
    80005850:	02010113          	addi	sp,sp,32
    80005854:	00008067          	ret

0000000080005858 <_ZL11workerBodyCPv>:
static void workerBodyC(void* arg) {
    80005858:	fe010113          	addi	sp,sp,-32
    8000585c:	00113c23          	sd	ra,24(sp)
    80005860:	00813823          	sd	s0,16(sp)
    80005864:	00913423          	sd	s1,8(sp)
    80005868:	01213023          	sd	s2,0(sp)
    8000586c:	02010413          	addi	s0,sp,32
    uint8 i = 0;
    80005870:	00000493          	li	s1,0
    80005874:	0400006f          	j	800058b4 <_ZL11workerBodyCPv+0x5c>
        printString("C: i="); printInt(i); printString("\n");
    80005878:	00004517          	auipc	a0,0x4
    8000587c:	9d850513          	addi	a0,a0,-1576 # 80009250 <CONSOLE_STATUS+0x240>
    80005880:	fffff097          	auipc	ra,0xfffff
    80005884:	464080e7          	jalr	1124(ra) # 80004ce4 <_Z11printStringPKc>
    80005888:	00000613          	li	a2,0
    8000588c:	00a00593          	li	a1,10
    80005890:	00048513          	mv	a0,s1
    80005894:	fffff097          	auipc	ra,0xfffff
    80005898:	600080e7          	jalr	1536(ra) # 80004e94 <_Z8printIntiii>
    8000589c:	00004517          	auipc	a0,0x4
    800058a0:	bd450513          	addi	a0,a0,-1068 # 80009470 <CONSOLE_STATUS+0x460>
    800058a4:	fffff097          	auipc	ra,0xfffff
    800058a8:	440080e7          	jalr	1088(ra) # 80004ce4 <_Z11printStringPKc>
    for (; i < 3; i++) {
    800058ac:	0014849b          	addiw	s1,s1,1
    800058b0:	0ff4f493          	andi	s1,s1,255
    800058b4:	00200793          	li	a5,2
    800058b8:	fc97f0e3          	bgeu	a5,s1,80005878 <_ZL11workerBodyCPv+0x20>
    printString("C: dispatch\n");
    800058bc:	00004517          	auipc	a0,0x4
    800058c0:	99c50513          	addi	a0,a0,-1636 # 80009258 <CONSOLE_STATUS+0x248>
    800058c4:	fffff097          	auipc	ra,0xfffff
    800058c8:	420080e7          	jalr	1056(ra) # 80004ce4 <_Z11printStringPKc>
    __asm__ ("li t1, 7");
    800058cc:	00700313          	li	t1,7
    thread_dispatch();
    800058d0:	ffffc097          	auipc	ra,0xffffc
    800058d4:	ab8080e7          	jalr	-1352(ra) # 80001388 <_Z15thread_dispatchv>
    __asm__ ("mv %[t1], t1" : [t1] "=r"(t1));
    800058d8:	00030913          	mv	s2,t1
    printString("C: t1="); printInt(t1); printString("\n");
    800058dc:	00004517          	auipc	a0,0x4
    800058e0:	98c50513          	addi	a0,a0,-1652 # 80009268 <CONSOLE_STATUS+0x258>
    800058e4:	fffff097          	auipc	ra,0xfffff
    800058e8:	400080e7          	jalr	1024(ra) # 80004ce4 <_Z11printStringPKc>
    800058ec:	00000613          	li	a2,0
    800058f0:	00a00593          	li	a1,10
    800058f4:	0009051b          	sext.w	a0,s2
    800058f8:	fffff097          	auipc	ra,0xfffff
    800058fc:	59c080e7          	jalr	1436(ra) # 80004e94 <_Z8printIntiii>
    80005900:	00004517          	auipc	a0,0x4
    80005904:	b7050513          	addi	a0,a0,-1168 # 80009470 <CONSOLE_STATUS+0x460>
    80005908:	fffff097          	auipc	ra,0xfffff
    8000590c:	3dc080e7          	jalr	988(ra) # 80004ce4 <_Z11printStringPKc>
    uint64 result = fibonacci(12);
    80005910:	00c00513          	li	a0,12
    80005914:	00000097          	auipc	ra,0x0
    80005918:	d88080e7          	jalr	-632(ra) # 8000569c <_ZL9fibonaccim>
    8000591c:	00050913          	mv	s2,a0
    printString("C: fibonaci="); printInt(result); printString("\n");
    80005920:	00004517          	auipc	a0,0x4
    80005924:	95050513          	addi	a0,a0,-1712 # 80009270 <CONSOLE_STATUS+0x260>
    80005928:	fffff097          	auipc	ra,0xfffff
    8000592c:	3bc080e7          	jalr	956(ra) # 80004ce4 <_Z11printStringPKc>
    80005930:	00000613          	li	a2,0
    80005934:	00a00593          	li	a1,10
    80005938:	0009051b          	sext.w	a0,s2
    8000593c:	fffff097          	auipc	ra,0xfffff
    80005940:	558080e7          	jalr	1368(ra) # 80004e94 <_Z8printIntiii>
    80005944:	00004517          	auipc	a0,0x4
    80005948:	b2c50513          	addi	a0,a0,-1236 # 80009470 <CONSOLE_STATUS+0x460>
    8000594c:	fffff097          	auipc	ra,0xfffff
    80005950:	398080e7          	jalr	920(ra) # 80004ce4 <_Z11printStringPKc>
    80005954:	0400006f          	j	80005994 <_ZL11workerBodyCPv+0x13c>
        printString("C: i="); printInt(i); printString("\n");
    80005958:	00004517          	auipc	a0,0x4
    8000595c:	8f850513          	addi	a0,a0,-1800 # 80009250 <CONSOLE_STATUS+0x240>
    80005960:	fffff097          	auipc	ra,0xfffff
    80005964:	384080e7          	jalr	900(ra) # 80004ce4 <_Z11printStringPKc>
    80005968:	00000613          	li	a2,0
    8000596c:	00a00593          	li	a1,10
    80005970:	00048513          	mv	a0,s1
    80005974:	fffff097          	auipc	ra,0xfffff
    80005978:	520080e7          	jalr	1312(ra) # 80004e94 <_Z8printIntiii>
    8000597c:	00004517          	auipc	a0,0x4
    80005980:	af450513          	addi	a0,a0,-1292 # 80009470 <CONSOLE_STATUS+0x460>
    80005984:	fffff097          	auipc	ra,0xfffff
    80005988:	360080e7          	jalr	864(ra) # 80004ce4 <_Z11printStringPKc>
    for (; i < 6; i++) {
    8000598c:	0014849b          	addiw	s1,s1,1
    80005990:	0ff4f493          	andi	s1,s1,255
    80005994:	00500793          	li	a5,5
    80005998:	fc97f0e3          	bgeu	a5,s1,80005958 <_ZL11workerBodyCPv+0x100>
    printString("A finished!\n");
    8000599c:	00004517          	auipc	a0,0x4
    800059a0:	88c50513          	addi	a0,a0,-1908 # 80009228 <CONSOLE_STATUS+0x218>
    800059a4:	fffff097          	auipc	ra,0xfffff
    800059a8:	340080e7          	jalr	832(ra) # 80004ce4 <_Z11printStringPKc>
    finishedC = true;
    800059ac:	00100793          	li	a5,1
    800059b0:	00009717          	auipc	a4,0x9
    800059b4:	d6f70da3          	sb	a5,-645(a4) # 8000e72b <_ZL9finishedC>
    thread_dispatch();
    800059b8:	ffffc097          	auipc	ra,0xffffc
    800059bc:	9d0080e7          	jalr	-1584(ra) # 80001388 <_Z15thread_dispatchv>
}
    800059c0:	01813083          	ld	ra,24(sp)
    800059c4:	01013403          	ld	s0,16(sp)
    800059c8:	00813483          	ld	s1,8(sp)
    800059cc:	00013903          	ld	s2,0(sp)
    800059d0:	02010113          	addi	sp,sp,32
    800059d4:	00008067          	ret

00000000800059d8 <_ZL11workerBodyBPv>:
static void workerBodyB(void* arg) {
    800059d8:	fe010113          	addi	sp,sp,-32
    800059dc:	00113c23          	sd	ra,24(sp)
    800059e0:	00813823          	sd	s0,16(sp)
    800059e4:	00913423          	sd	s1,8(sp)
    800059e8:	01213023          	sd	s2,0(sp)
    800059ec:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 16; i++) {
    800059f0:	00000913          	li	s2,0
    800059f4:	0400006f          	j	80005a34 <_ZL11workerBodyBPv+0x5c>
            thread_dispatch();
    800059f8:	ffffc097          	auipc	ra,0xffffc
    800059fc:	990080e7          	jalr	-1648(ra) # 80001388 <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++) {
    80005a00:	00148493          	addi	s1,s1,1
    80005a04:	000027b7          	lui	a5,0x2
    80005a08:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    80005a0c:	0097ee63          	bltu	a5,s1,80005a28 <_ZL11workerBodyBPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    80005a10:	00000713          	li	a4,0
    80005a14:	000077b7          	lui	a5,0x7
    80005a18:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    80005a1c:	fce7eee3          	bltu	a5,a4,800059f8 <_ZL11workerBodyBPv+0x20>
    80005a20:	00170713          	addi	a4,a4,1
    80005a24:	ff1ff06f          	j	80005a14 <_ZL11workerBodyBPv+0x3c>
        if (i == 10) {
    80005a28:	00a00793          	li	a5,10
    80005a2c:	04f90663          	beq	s2,a5,80005a78 <_ZL11workerBodyBPv+0xa0>
    for (uint64 i = 0; i < 16; i++) {
    80005a30:	00190913          	addi	s2,s2,1
    80005a34:	00f00793          	li	a5,15
    80005a38:	0527e463          	bltu	a5,s2,80005a80 <_ZL11workerBodyBPv+0xa8>
        printString("B: i="); printInt(i); printString("\n");
    80005a3c:	00003517          	auipc	a0,0x3
    80005a40:	7fc50513          	addi	a0,a0,2044 # 80009238 <CONSOLE_STATUS+0x228>
    80005a44:	fffff097          	auipc	ra,0xfffff
    80005a48:	2a0080e7          	jalr	672(ra) # 80004ce4 <_Z11printStringPKc>
    80005a4c:	00000613          	li	a2,0
    80005a50:	00a00593          	li	a1,10
    80005a54:	0009051b          	sext.w	a0,s2
    80005a58:	fffff097          	auipc	ra,0xfffff
    80005a5c:	43c080e7          	jalr	1084(ra) # 80004e94 <_Z8printIntiii>
    80005a60:	00004517          	auipc	a0,0x4
    80005a64:	a1050513          	addi	a0,a0,-1520 # 80009470 <CONSOLE_STATUS+0x460>
    80005a68:	fffff097          	auipc	ra,0xfffff
    80005a6c:	27c080e7          	jalr	636(ra) # 80004ce4 <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    80005a70:	00000493          	li	s1,0
    80005a74:	f91ff06f          	j	80005a04 <_ZL11workerBodyBPv+0x2c>
            asm volatile("csrr t6, sepc");
    80005a78:	14102ff3          	csrr	t6,sepc
    80005a7c:	fb5ff06f          	j	80005a30 <_ZL11workerBodyBPv+0x58>
    printString("B finished!\n");
    80005a80:	00003517          	auipc	a0,0x3
    80005a84:	7c050513          	addi	a0,a0,1984 # 80009240 <CONSOLE_STATUS+0x230>
    80005a88:	fffff097          	auipc	ra,0xfffff
    80005a8c:	25c080e7          	jalr	604(ra) # 80004ce4 <_Z11printStringPKc>
    finishedB = true;
    80005a90:	00100793          	li	a5,1
    80005a94:	00009717          	auipc	a4,0x9
    80005a98:	c8f70c23          	sb	a5,-872(a4) # 8000e72c <_ZL9finishedB>
    thread_dispatch();
    80005a9c:	ffffc097          	auipc	ra,0xffffc
    80005aa0:	8ec080e7          	jalr	-1812(ra) # 80001388 <_Z15thread_dispatchv>
}
    80005aa4:	01813083          	ld	ra,24(sp)
    80005aa8:	01013403          	ld	s0,16(sp)
    80005aac:	00813483          	ld	s1,8(sp)
    80005ab0:	00013903          	ld	s2,0(sp)
    80005ab4:	02010113          	addi	sp,sp,32
    80005ab8:	00008067          	ret

0000000080005abc <_ZL11workerBodyAPv>:
static void workerBodyA(void* arg) {
    80005abc:	fe010113          	addi	sp,sp,-32
    80005ac0:	00113c23          	sd	ra,24(sp)
    80005ac4:	00813823          	sd	s0,16(sp)
    80005ac8:	00913423          	sd	s1,8(sp)
    80005acc:	01213023          	sd	s2,0(sp)
    80005ad0:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 10; i++) {
    80005ad4:	00000913          	li	s2,0
    80005ad8:	0380006f          	j	80005b10 <_ZL11workerBodyAPv+0x54>
            thread_dispatch();
    80005adc:	ffffc097          	auipc	ra,0xffffc
    80005ae0:	8ac080e7          	jalr	-1876(ra) # 80001388 <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++) {
    80005ae4:	00148493          	addi	s1,s1,1
    80005ae8:	000027b7          	lui	a5,0x2
    80005aec:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    80005af0:	0097ee63          	bltu	a5,s1,80005b0c <_ZL11workerBodyAPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    80005af4:	00000713          	li	a4,0
    80005af8:	000077b7          	lui	a5,0x7
    80005afc:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    80005b00:	fce7eee3          	bltu	a5,a4,80005adc <_ZL11workerBodyAPv+0x20>
    80005b04:	00170713          	addi	a4,a4,1
    80005b08:	ff1ff06f          	j	80005af8 <_ZL11workerBodyAPv+0x3c>
    for (uint64 i = 0; i < 10; i++) {
    80005b0c:	00190913          	addi	s2,s2,1
    80005b10:	00900793          	li	a5,9
    80005b14:	0527e063          	bltu	a5,s2,80005b54 <_ZL11workerBodyAPv+0x98>
        printString("A: i="); printInt(i); printString("\n");
    80005b18:	00003517          	auipc	a0,0x3
    80005b1c:	70850513          	addi	a0,a0,1800 # 80009220 <CONSOLE_STATUS+0x210>
    80005b20:	fffff097          	auipc	ra,0xfffff
    80005b24:	1c4080e7          	jalr	452(ra) # 80004ce4 <_Z11printStringPKc>
    80005b28:	00000613          	li	a2,0
    80005b2c:	00a00593          	li	a1,10
    80005b30:	0009051b          	sext.w	a0,s2
    80005b34:	fffff097          	auipc	ra,0xfffff
    80005b38:	360080e7          	jalr	864(ra) # 80004e94 <_Z8printIntiii>
    80005b3c:	00004517          	auipc	a0,0x4
    80005b40:	93450513          	addi	a0,a0,-1740 # 80009470 <CONSOLE_STATUS+0x460>
    80005b44:	fffff097          	auipc	ra,0xfffff
    80005b48:	1a0080e7          	jalr	416(ra) # 80004ce4 <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    80005b4c:	00000493          	li	s1,0
    80005b50:	f99ff06f          	j	80005ae8 <_ZL11workerBodyAPv+0x2c>
    printString("A finished!\n");
    80005b54:	00003517          	auipc	a0,0x3
    80005b58:	6d450513          	addi	a0,a0,1748 # 80009228 <CONSOLE_STATUS+0x218>
    80005b5c:	fffff097          	auipc	ra,0xfffff
    80005b60:	188080e7          	jalr	392(ra) # 80004ce4 <_Z11printStringPKc>
    finishedA = true;
    80005b64:	00100793          	li	a5,1
    80005b68:	00009717          	auipc	a4,0x9
    80005b6c:	bcf702a3          	sb	a5,-1083(a4) # 8000e72d <_ZL9finishedA>
}
    80005b70:	01813083          	ld	ra,24(sp)
    80005b74:	01013403          	ld	s0,16(sp)
    80005b78:	00813483          	ld	s1,8(sp)
    80005b7c:	00013903          	ld	s2,0(sp)
    80005b80:	02010113          	addi	sp,sp,32
    80005b84:	00008067          	ret

0000000080005b88 <_Z16System_Mode_testv>:


void System_Mode_test() {
    80005b88:	fd010113          	addi	sp,sp,-48
    80005b8c:	02113423          	sd	ra,40(sp)
    80005b90:	02813023          	sd	s0,32(sp)
    80005b94:	03010413          	addi	s0,sp,48
    thread_t threads[4];
    thread_create(&threads[0], workerBodyA, nullptr);
    80005b98:	00000613          	li	a2,0
    80005b9c:	00000597          	auipc	a1,0x0
    80005ba0:	f2058593          	addi	a1,a1,-224 # 80005abc <_ZL11workerBodyAPv>
    80005ba4:	fd040513          	addi	a0,s0,-48
    80005ba8:	ffffb097          	auipc	ra,0xffffb
    80005bac:	758080e7          	jalr	1880(ra) # 80001300 <_Z13thread_createPP8thread_sPFvPvES2_>
    printString("ThreadA created\n");
    80005bb0:	00003517          	auipc	a0,0x3
    80005bb4:	70850513          	addi	a0,a0,1800 # 800092b8 <CONSOLE_STATUS+0x2a8>
    80005bb8:	fffff097          	auipc	ra,0xfffff
    80005bbc:	12c080e7          	jalr	300(ra) # 80004ce4 <_Z11printStringPKc>

    thread_create(&threads[1], workerBodyB, nullptr);
    80005bc0:	00000613          	li	a2,0
    80005bc4:	00000597          	auipc	a1,0x0
    80005bc8:	e1458593          	addi	a1,a1,-492 # 800059d8 <_ZL11workerBodyBPv>
    80005bcc:	fd840513          	addi	a0,s0,-40
    80005bd0:	ffffb097          	auipc	ra,0xffffb
    80005bd4:	730080e7          	jalr	1840(ra) # 80001300 <_Z13thread_createPP8thread_sPFvPvES2_>
    printString("ThreadB created\n");
    80005bd8:	00003517          	auipc	a0,0x3
    80005bdc:	6f850513          	addi	a0,a0,1784 # 800092d0 <CONSOLE_STATUS+0x2c0>
    80005be0:	fffff097          	auipc	ra,0xfffff
    80005be4:	104080e7          	jalr	260(ra) # 80004ce4 <_Z11printStringPKc>

    thread_create(&threads[2], workerBodyC, nullptr);
    80005be8:	00000613          	li	a2,0
    80005bec:	00000597          	auipc	a1,0x0
    80005bf0:	c6c58593          	addi	a1,a1,-916 # 80005858 <_ZL11workerBodyCPv>
    80005bf4:	fe040513          	addi	a0,s0,-32
    80005bf8:	ffffb097          	auipc	ra,0xffffb
    80005bfc:	708080e7          	jalr	1800(ra) # 80001300 <_Z13thread_createPP8thread_sPFvPvES2_>
    printString("ThreadC created\n");
    80005c00:	00003517          	auipc	a0,0x3
    80005c04:	6e850513          	addi	a0,a0,1768 # 800092e8 <CONSOLE_STATUS+0x2d8>
    80005c08:	fffff097          	auipc	ra,0xfffff
    80005c0c:	0dc080e7          	jalr	220(ra) # 80004ce4 <_Z11printStringPKc>

    thread_create(&threads[3], workerBodyD, nullptr);
    80005c10:	00000613          	li	a2,0
    80005c14:	00000597          	auipc	a1,0x0
    80005c18:	afc58593          	addi	a1,a1,-1284 # 80005710 <_ZL11workerBodyDPv>
    80005c1c:	fe840513          	addi	a0,s0,-24
    80005c20:	ffffb097          	auipc	ra,0xffffb
    80005c24:	6e0080e7          	jalr	1760(ra) # 80001300 <_Z13thread_createPP8thread_sPFvPvES2_>
    printString("ThreadD created\n");
    80005c28:	00003517          	auipc	a0,0x3
    80005c2c:	6d850513          	addi	a0,a0,1752 # 80009300 <CONSOLE_STATUS+0x2f0>
    80005c30:	fffff097          	auipc	ra,0xfffff
    80005c34:	0b4080e7          	jalr	180(ra) # 80004ce4 <_Z11printStringPKc>
    80005c38:	00c0006f          	j	80005c44 <_Z16System_Mode_testv+0xbc>

    while (!(finishedA && finishedB && finishedC && finishedD)) {
        thread_dispatch();
    80005c3c:	ffffb097          	auipc	ra,0xffffb
    80005c40:	74c080e7          	jalr	1868(ra) # 80001388 <_Z15thread_dispatchv>
    while (!(finishedA && finishedB && finishedC && finishedD)) {
    80005c44:	00009797          	auipc	a5,0x9
    80005c48:	ae97c783          	lbu	a5,-1303(a5) # 8000e72d <_ZL9finishedA>
    80005c4c:	fe0788e3          	beqz	a5,80005c3c <_Z16System_Mode_testv+0xb4>
    80005c50:	00009797          	auipc	a5,0x9
    80005c54:	adc7c783          	lbu	a5,-1316(a5) # 8000e72c <_ZL9finishedB>
    80005c58:	fe0782e3          	beqz	a5,80005c3c <_Z16System_Mode_testv+0xb4>
    80005c5c:	00009797          	auipc	a5,0x9
    80005c60:	acf7c783          	lbu	a5,-1329(a5) # 8000e72b <_ZL9finishedC>
    80005c64:	fc078ce3          	beqz	a5,80005c3c <_Z16System_Mode_testv+0xb4>
    80005c68:	00009797          	auipc	a5,0x9
    80005c6c:	ac27c783          	lbu	a5,-1342(a5) # 8000e72a <_ZL9finishedD>
    80005c70:	fc0786e3          	beqz	a5,80005c3c <_Z16System_Mode_testv+0xb4>
    }

}
    80005c74:	02813083          	ld	ra,40(sp)
    80005c78:	02013403          	ld	s0,32(sp)
    80005c7c:	03010113          	addi	sp,sp,48
    80005c80:	00008067          	ret

0000000080005c84 <_ZN6BufferC1Ei>:
#include "buffer.hpp"

Buffer::Buffer(int _cap) : cap(_cap + 1), head(0), tail(0) {
    80005c84:	fe010113          	addi	sp,sp,-32
    80005c88:	00113c23          	sd	ra,24(sp)
    80005c8c:	00813823          	sd	s0,16(sp)
    80005c90:	00913423          	sd	s1,8(sp)
    80005c94:	01213023          	sd	s2,0(sp)
    80005c98:	02010413          	addi	s0,sp,32
    80005c9c:	00050493          	mv	s1,a0
    80005ca0:	00058913          	mv	s2,a1
    80005ca4:	0015879b          	addiw	a5,a1,1
    80005ca8:	0007851b          	sext.w	a0,a5
    80005cac:	00f4a023          	sw	a5,0(s1)
    80005cb0:	0004a823          	sw	zero,16(s1)
    80005cb4:	0004aa23          	sw	zero,20(s1)
    buffer = (int *)mem_alloc(sizeof(int) * cap);
    80005cb8:	00251513          	slli	a0,a0,0x2
    80005cbc:	ffffb097          	auipc	ra,0xffffb
    80005cc0:	5c4080e7          	jalr	1476(ra) # 80001280 <_Z9mem_allocm>
    80005cc4:	00a4b423          	sd	a0,8(s1)
    sem_open(&itemAvailable, 0);
    80005cc8:	00000593          	li	a1,0
    80005ccc:	02048513          	addi	a0,s1,32
    80005cd0:	ffffb097          	auipc	ra,0xffffb
    80005cd4:	76c080e7          	jalr	1900(ra) # 8000143c <_Z8sem_openPP5sem_sj>
    sem_open(&spaceAvailable, _cap);
    80005cd8:	00090593          	mv	a1,s2
    80005cdc:	01848513          	addi	a0,s1,24
    80005ce0:	ffffb097          	auipc	ra,0xffffb
    80005ce4:	75c080e7          	jalr	1884(ra) # 8000143c <_Z8sem_openPP5sem_sj>
    sem_open(&mutexHead, 1);
    80005ce8:	00100593          	li	a1,1
    80005cec:	02848513          	addi	a0,s1,40
    80005cf0:	ffffb097          	auipc	ra,0xffffb
    80005cf4:	74c080e7          	jalr	1868(ra) # 8000143c <_Z8sem_openPP5sem_sj>
    sem_open(&mutexTail, 1);
    80005cf8:	00100593          	li	a1,1
    80005cfc:	03048513          	addi	a0,s1,48
    80005d00:	ffffb097          	auipc	ra,0xffffb
    80005d04:	73c080e7          	jalr	1852(ra) # 8000143c <_Z8sem_openPP5sem_sj>
}
    80005d08:	01813083          	ld	ra,24(sp)
    80005d0c:	01013403          	ld	s0,16(sp)
    80005d10:	00813483          	ld	s1,8(sp)
    80005d14:	00013903          	ld	s2,0(sp)
    80005d18:	02010113          	addi	sp,sp,32
    80005d1c:	00008067          	ret

0000000080005d20 <_ZN6Buffer3putEi>:
    sem_close(spaceAvailable);
    sem_close(mutexTail);
    sem_close(mutexHead);
}

void Buffer::put(int val) {
    80005d20:	fe010113          	addi	sp,sp,-32
    80005d24:	00113c23          	sd	ra,24(sp)
    80005d28:	00813823          	sd	s0,16(sp)
    80005d2c:	00913423          	sd	s1,8(sp)
    80005d30:	01213023          	sd	s2,0(sp)
    80005d34:	02010413          	addi	s0,sp,32
    80005d38:	00050493          	mv	s1,a0
    80005d3c:	00058913          	mv	s2,a1
    sem_wait(spaceAvailable);
    80005d40:	01853503          	ld	a0,24(a0)
    80005d44:	ffffb097          	auipc	ra,0xffffb
    80005d48:	77c080e7          	jalr	1916(ra) # 800014c0 <_Z8sem_waitP5sem_s>

    sem_wait(mutexTail);
    80005d4c:	0304b503          	ld	a0,48(s1)
    80005d50:	ffffb097          	auipc	ra,0xffffb
    80005d54:	770080e7          	jalr	1904(ra) # 800014c0 <_Z8sem_waitP5sem_s>
    buffer[tail] = val;
    80005d58:	0084b783          	ld	a5,8(s1)
    80005d5c:	0144a703          	lw	a4,20(s1)
    80005d60:	00271713          	slli	a4,a4,0x2
    80005d64:	00e787b3          	add	a5,a5,a4
    80005d68:	0127a023          	sw	s2,0(a5)
    tail = (tail + 1) % cap;
    80005d6c:	0144a783          	lw	a5,20(s1)
    80005d70:	0017879b          	addiw	a5,a5,1
    80005d74:	0004a703          	lw	a4,0(s1)
    80005d78:	02e7e7bb          	remw	a5,a5,a4
    80005d7c:	00f4aa23          	sw	a5,20(s1)
    sem_signal(mutexTail);
    80005d80:	0304b503          	ld	a0,48(s1)
    80005d84:	ffffb097          	auipc	ra,0xffffb
    80005d88:	77c080e7          	jalr	1916(ra) # 80001500 <_Z10sem_signalP5sem_s>

    sem_signal(itemAvailable);
    80005d8c:	0204b503          	ld	a0,32(s1)
    80005d90:	ffffb097          	auipc	ra,0xffffb
    80005d94:	770080e7          	jalr	1904(ra) # 80001500 <_Z10sem_signalP5sem_s>

}
    80005d98:	01813083          	ld	ra,24(sp)
    80005d9c:	01013403          	ld	s0,16(sp)
    80005da0:	00813483          	ld	s1,8(sp)
    80005da4:	00013903          	ld	s2,0(sp)
    80005da8:	02010113          	addi	sp,sp,32
    80005dac:	00008067          	ret

0000000080005db0 <_ZN6Buffer3getEv>:

int Buffer::get() {
    80005db0:	fe010113          	addi	sp,sp,-32
    80005db4:	00113c23          	sd	ra,24(sp)
    80005db8:	00813823          	sd	s0,16(sp)
    80005dbc:	00913423          	sd	s1,8(sp)
    80005dc0:	01213023          	sd	s2,0(sp)
    80005dc4:	02010413          	addi	s0,sp,32
    80005dc8:	00050493          	mv	s1,a0
    sem_wait(itemAvailable);
    80005dcc:	02053503          	ld	a0,32(a0)
    80005dd0:	ffffb097          	auipc	ra,0xffffb
    80005dd4:	6f0080e7          	jalr	1776(ra) # 800014c0 <_Z8sem_waitP5sem_s>

    sem_wait(mutexHead);
    80005dd8:	0284b503          	ld	a0,40(s1)
    80005ddc:	ffffb097          	auipc	ra,0xffffb
    80005de0:	6e4080e7          	jalr	1764(ra) # 800014c0 <_Z8sem_waitP5sem_s>

    int ret = buffer[head];
    80005de4:	0084b703          	ld	a4,8(s1)
    80005de8:	0104a783          	lw	a5,16(s1)
    80005dec:	00279693          	slli	a3,a5,0x2
    80005df0:	00d70733          	add	a4,a4,a3
    80005df4:	00072903          	lw	s2,0(a4)
    head = (head + 1) % cap;
    80005df8:	0017879b          	addiw	a5,a5,1
    80005dfc:	0004a703          	lw	a4,0(s1)
    80005e00:	02e7e7bb          	remw	a5,a5,a4
    80005e04:	00f4a823          	sw	a5,16(s1)
    sem_signal(mutexHead);
    80005e08:	0284b503          	ld	a0,40(s1)
    80005e0c:	ffffb097          	auipc	ra,0xffffb
    80005e10:	6f4080e7          	jalr	1780(ra) # 80001500 <_Z10sem_signalP5sem_s>

    sem_signal(spaceAvailable);
    80005e14:	0184b503          	ld	a0,24(s1)
    80005e18:	ffffb097          	auipc	ra,0xffffb
    80005e1c:	6e8080e7          	jalr	1768(ra) # 80001500 <_Z10sem_signalP5sem_s>

    return ret;
}
    80005e20:	00090513          	mv	a0,s2
    80005e24:	01813083          	ld	ra,24(sp)
    80005e28:	01013403          	ld	s0,16(sp)
    80005e2c:	00813483          	ld	s1,8(sp)
    80005e30:	00013903          	ld	s2,0(sp)
    80005e34:	02010113          	addi	sp,sp,32
    80005e38:	00008067          	ret

0000000080005e3c <_ZN6Buffer6getCntEv>:

int Buffer::getCnt() {
    80005e3c:	fe010113          	addi	sp,sp,-32
    80005e40:	00113c23          	sd	ra,24(sp)
    80005e44:	00813823          	sd	s0,16(sp)
    80005e48:	00913423          	sd	s1,8(sp)
    80005e4c:	01213023          	sd	s2,0(sp)
    80005e50:	02010413          	addi	s0,sp,32
    80005e54:	00050493          	mv	s1,a0
    int ret;

    sem_wait(mutexHead);
    80005e58:	02853503          	ld	a0,40(a0)
    80005e5c:	ffffb097          	auipc	ra,0xffffb
    80005e60:	664080e7          	jalr	1636(ra) # 800014c0 <_Z8sem_waitP5sem_s>
    sem_wait(mutexTail);
    80005e64:	0304b503          	ld	a0,48(s1)
    80005e68:	ffffb097          	auipc	ra,0xffffb
    80005e6c:	658080e7          	jalr	1624(ra) # 800014c0 <_Z8sem_waitP5sem_s>

    if (tail >= head) {
    80005e70:	0144a783          	lw	a5,20(s1)
    80005e74:	0104a903          	lw	s2,16(s1)
    80005e78:	0327ce63          	blt	a5,s2,80005eb4 <_ZN6Buffer6getCntEv+0x78>
        ret = tail - head;
    80005e7c:	4127893b          	subw	s2,a5,s2
    } else {
        ret = cap - head + tail;
    }

    sem_signal(mutexTail);
    80005e80:	0304b503          	ld	a0,48(s1)
    80005e84:	ffffb097          	auipc	ra,0xffffb
    80005e88:	67c080e7          	jalr	1660(ra) # 80001500 <_Z10sem_signalP5sem_s>
    sem_signal(mutexHead);
    80005e8c:	0284b503          	ld	a0,40(s1)
    80005e90:	ffffb097          	auipc	ra,0xffffb
    80005e94:	670080e7          	jalr	1648(ra) # 80001500 <_Z10sem_signalP5sem_s>

    return ret;
}
    80005e98:	00090513          	mv	a0,s2
    80005e9c:	01813083          	ld	ra,24(sp)
    80005ea0:	01013403          	ld	s0,16(sp)
    80005ea4:	00813483          	ld	s1,8(sp)
    80005ea8:	00013903          	ld	s2,0(sp)
    80005eac:	02010113          	addi	sp,sp,32
    80005eb0:	00008067          	ret
        ret = cap - head + tail;
    80005eb4:	0004a703          	lw	a4,0(s1)
    80005eb8:	4127093b          	subw	s2,a4,s2
    80005ebc:	00f9093b          	addw	s2,s2,a5
    80005ec0:	fc1ff06f          	j	80005e80 <_ZN6Buffer6getCntEv+0x44>

0000000080005ec4 <_ZN6BufferD1Ev>:
Buffer::~Buffer() {
    80005ec4:	fe010113          	addi	sp,sp,-32
    80005ec8:	00113c23          	sd	ra,24(sp)
    80005ecc:	00813823          	sd	s0,16(sp)
    80005ed0:	00913423          	sd	s1,8(sp)
    80005ed4:	02010413          	addi	s0,sp,32
    80005ed8:	00050493          	mv	s1,a0
    putc('\n');
    80005edc:	00a00513          	li	a0,10
    80005ee0:	ffffb097          	auipc	ra,0xffffb
    80005ee4:	6d0080e7          	jalr	1744(ra) # 800015b0 <_Z4putcc>
    printString("Buffer deleted!\n");
    80005ee8:	00003517          	auipc	a0,0x3
    80005eec:	43050513          	addi	a0,a0,1072 # 80009318 <CONSOLE_STATUS+0x308>
    80005ef0:	fffff097          	auipc	ra,0xfffff
    80005ef4:	df4080e7          	jalr	-524(ra) # 80004ce4 <_Z11printStringPKc>
    while (getCnt() > 0) {
    80005ef8:	00048513          	mv	a0,s1
    80005efc:	00000097          	auipc	ra,0x0
    80005f00:	f40080e7          	jalr	-192(ra) # 80005e3c <_ZN6Buffer6getCntEv>
    80005f04:	02a05c63          	blez	a0,80005f3c <_ZN6BufferD1Ev+0x78>
        char ch = buffer[head];
    80005f08:	0084b783          	ld	a5,8(s1)
    80005f0c:	0104a703          	lw	a4,16(s1)
    80005f10:	00271713          	slli	a4,a4,0x2
    80005f14:	00e787b3          	add	a5,a5,a4
        putc(ch);
    80005f18:	0007c503          	lbu	a0,0(a5)
    80005f1c:	ffffb097          	auipc	ra,0xffffb
    80005f20:	694080e7          	jalr	1684(ra) # 800015b0 <_Z4putcc>
        head = (head + 1) % cap;
    80005f24:	0104a783          	lw	a5,16(s1)
    80005f28:	0017879b          	addiw	a5,a5,1
    80005f2c:	0004a703          	lw	a4,0(s1)
    80005f30:	02e7e7bb          	remw	a5,a5,a4
    80005f34:	00f4a823          	sw	a5,16(s1)
    while (getCnt() > 0) {
    80005f38:	fc1ff06f          	j	80005ef8 <_ZN6BufferD1Ev+0x34>
    putc('!');
    80005f3c:	02100513          	li	a0,33
    80005f40:	ffffb097          	auipc	ra,0xffffb
    80005f44:	670080e7          	jalr	1648(ra) # 800015b0 <_Z4putcc>
    putc('\n');
    80005f48:	00a00513          	li	a0,10
    80005f4c:	ffffb097          	auipc	ra,0xffffb
    80005f50:	664080e7          	jalr	1636(ra) # 800015b0 <_Z4putcc>
    mem_free(buffer);
    80005f54:	0084b503          	ld	a0,8(s1)
    80005f58:	ffffb097          	auipc	ra,0xffffb
    80005f5c:	368080e7          	jalr	872(ra) # 800012c0 <_Z8mem_freePv>
    sem_close(itemAvailable);
    80005f60:	0204b503          	ld	a0,32(s1)
    80005f64:	ffffb097          	auipc	ra,0xffffb
    80005f68:	51c080e7          	jalr	1308(ra) # 80001480 <_Z9sem_closeP5sem_s>
    sem_close(spaceAvailable);
    80005f6c:	0184b503          	ld	a0,24(s1)
    80005f70:	ffffb097          	auipc	ra,0xffffb
    80005f74:	510080e7          	jalr	1296(ra) # 80001480 <_Z9sem_closeP5sem_s>
    sem_close(mutexTail);
    80005f78:	0304b503          	ld	a0,48(s1)
    80005f7c:	ffffb097          	auipc	ra,0xffffb
    80005f80:	504080e7          	jalr	1284(ra) # 80001480 <_Z9sem_closeP5sem_s>
    sem_close(mutexHead);
    80005f84:	0284b503          	ld	a0,40(s1)
    80005f88:	ffffb097          	auipc	ra,0xffffb
    80005f8c:	4f8080e7          	jalr	1272(ra) # 80001480 <_Z9sem_closeP5sem_s>
}
    80005f90:	01813083          	ld	ra,24(sp)
    80005f94:	01013403          	ld	s0,16(sp)
    80005f98:	00813483          	ld	s1,8(sp)
    80005f9c:	02010113          	addi	sp,sp,32
    80005fa0:	00008067          	ret

0000000080005fa4 <start>:
    80005fa4:	ff010113          	addi	sp,sp,-16
    80005fa8:	00813423          	sd	s0,8(sp)
    80005fac:	01010413          	addi	s0,sp,16
    80005fb0:	300027f3          	csrr	a5,mstatus
    80005fb4:	ffffe737          	lui	a4,0xffffe
    80005fb8:	7ff70713          	addi	a4,a4,2047 # ffffffffffffe7ff <end+0xffffffff7ffeee6f>
    80005fbc:	00e7f7b3          	and	a5,a5,a4
    80005fc0:	00001737          	lui	a4,0x1
    80005fc4:	80070713          	addi	a4,a4,-2048 # 800 <_entry-0x7ffff800>
    80005fc8:	00e7e7b3          	or	a5,a5,a4
    80005fcc:	30079073          	csrw	mstatus,a5
    80005fd0:	00000797          	auipc	a5,0x0
    80005fd4:	16078793          	addi	a5,a5,352 # 80006130 <system_main>
    80005fd8:	34179073          	csrw	mepc,a5
    80005fdc:	00000793          	li	a5,0
    80005fe0:	18079073          	csrw	satp,a5
    80005fe4:	000107b7          	lui	a5,0x10
    80005fe8:	fff78793          	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    80005fec:	30279073          	csrw	medeleg,a5
    80005ff0:	30379073          	csrw	mideleg,a5
    80005ff4:	104027f3          	csrr	a5,sie
    80005ff8:	2227e793          	ori	a5,a5,546
    80005ffc:	10479073          	csrw	sie,a5
    80006000:	fff00793          	li	a5,-1
    80006004:	00a7d793          	srli	a5,a5,0xa
    80006008:	3b079073          	csrw	pmpaddr0,a5
    8000600c:	00f00793          	li	a5,15
    80006010:	3a079073          	csrw	pmpcfg0,a5
    80006014:	f14027f3          	csrr	a5,mhartid
    80006018:	0200c737          	lui	a4,0x200c
    8000601c:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    80006020:	0007869b          	sext.w	a3,a5
    80006024:	00269713          	slli	a4,a3,0x2
    80006028:	000f4637          	lui	a2,0xf4
    8000602c:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    80006030:	00d70733          	add	a4,a4,a3
    80006034:	0037979b          	slliw	a5,a5,0x3
    80006038:	020046b7          	lui	a3,0x2004
    8000603c:	00d787b3          	add	a5,a5,a3
    80006040:	00c585b3          	add	a1,a1,a2
    80006044:	00371693          	slli	a3,a4,0x3
    80006048:	00008717          	auipc	a4,0x8
    8000604c:	6e870713          	addi	a4,a4,1768 # 8000e730 <timer_scratch>
    80006050:	00b7b023          	sd	a1,0(a5)
    80006054:	00d70733          	add	a4,a4,a3
    80006058:	00f73c23          	sd	a5,24(a4)
    8000605c:	02c73023          	sd	a2,32(a4)
    80006060:	34071073          	csrw	mscratch,a4
    80006064:	00000797          	auipc	a5,0x0
    80006068:	6ec78793          	addi	a5,a5,1772 # 80006750 <timervec>
    8000606c:	30579073          	csrw	mtvec,a5
    80006070:	300027f3          	csrr	a5,mstatus
    80006074:	0087e793          	ori	a5,a5,8
    80006078:	30079073          	csrw	mstatus,a5
    8000607c:	304027f3          	csrr	a5,mie
    80006080:	0807e793          	ori	a5,a5,128
    80006084:	30479073          	csrw	mie,a5
    80006088:	f14027f3          	csrr	a5,mhartid
    8000608c:	0007879b          	sext.w	a5,a5
    80006090:	00078213          	mv	tp,a5
    80006094:	30200073          	mret
    80006098:	00813403          	ld	s0,8(sp)
    8000609c:	01010113          	addi	sp,sp,16
    800060a0:	00008067          	ret

00000000800060a4 <timerinit>:
    800060a4:	ff010113          	addi	sp,sp,-16
    800060a8:	00813423          	sd	s0,8(sp)
    800060ac:	01010413          	addi	s0,sp,16
    800060b0:	f14027f3          	csrr	a5,mhartid
    800060b4:	0200c737          	lui	a4,0x200c
    800060b8:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    800060bc:	0007869b          	sext.w	a3,a5
    800060c0:	00269713          	slli	a4,a3,0x2
    800060c4:	000f4637          	lui	a2,0xf4
    800060c8:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    800060cc:	00d70733          	add	a4,a4,a3
    800060d0:	0037979b          	slliw	a5,a5,0x3
    800060d4:	020046b7          	lui	a3,0x2004
    800060d8:	00d787b3          	add	a5,a5,a3
    800060dc:	00c585b3          	add	a1,a1,a2
    800060e0:	00371693          	slli	a3,a4,0x3
    800060e4:	00008717          	auipc	a4,0x8
    800060e8:	64c70713          	addi	a4,a4,1612 # 8000e730 <timer_scratch>
    800060ec:	00b7b023          	sd	a1,0(a5)
    800060f0:	00d70733          	add	a4,a4,a3
    800060f4:	00f73c23          	sd	a5,24(a4)
    800060f8:	02c73023          	sd	a2,32(a4)
    800060fc:	34071073          	csrw	mscratch,a4
    80006100:	00000797          	auipc	a5,0x0
    80006104:	65078793          	addi	a5,a5,1616 # 80006750 <timervec>
    80006108:	30579073          	csrw	mtvec,a5
    8000610c:	300027f3          	csrr	a5,mstatus
    80006110:	0087e793          	ori	a5,a5,8
    80006114:	30079073          	csrw	mstatus,a5
    80006118:	304027f3          	csrr	a5,mie
    8000611c:	0807e793          	ori	a5,a5,128
    80006120:	30479073          	csrw	mie,a5
    80006124:	00813403          	ld	s0,8(sp)
    80006128:	01010113          	addi	sp,sp,16
    8000612c:	00008067          	ret

0000000080006130 <system_main>:
    80006130:	fe010113          	addi	sp,sp,-32
    80006134:	00813823          	sd	s0,16(sp)
    80006138:	00913423          	sd	s1,8(sp)
    8000613c:	00113c23          	sd	ra,24(sp)
    80006140:	02010413          	addi	s0,sp,32
    80006144:	00000097          	auipc	ra,0x0
    80006148:	0c4080e7          	jalr	196(ra) # 80006208 <cpuid>
    8000614c:	00005497          	auipc	s1,0x5
    80006150:	11448493          	addi	s1,s1,276 # 8000b260 <started>
    80006154:	02050263          	beqz	a0,80006178 <system_main+0x48>
    80006158:	0004a783          	lw	a5,0(s1)
    8000615c:	0007879b          	sext.w	a5,a5
    80006160:	fe078ce3          	beqz	a5,80006158 <system_main+0x28>
    80006164:	0ff0000f          	fence
    80006168:	00003517          	auipc	a0,0x3
    8000616c:	48050513          	addi	a0,a0,1152 # 800095e8 <CONSOLE_STATUS+0x5d8>
    80006170:	00001097          	auipc	ra,0x1
    80006174:	a7c080e7          	jalr	-1412(ra) # 80006bec <panic>
    80006178:	00001097          	auipc	ra,0x1
    8000617c:	9d0080e7          	jalr	-1584(ra) # 80006b48 <consoleinit>
    80006180:	00001097          	auipc	ra,0x1
    80006184:	15c080e7          	jalr	348(ra) # 800072dc <printfinit>
    80006188:	00003517          	auipc	a0,0x3
    8000618c:	2e850513          	addi	a0,a0,744 # 80009470 <CONSOLE_STATUS+0x460>
    80006190:	00001097          	auipc	ra,0x1
    80006194:	ab8080e7          	jalr	-1352(ra) # 80006c48 <__printf>
    80006198:	00003517          	auipc	a0,0x3
    8000619c:	42050513          	addi	a0,a0,1056 # 800095b8 <CONSOLE_STATUS+0x5a8>
    800061a0:	00001097          	auipc	ra,0x1
    800061a4:	aa8080e7          	jalr	-1368(ra) # 80006c48 <__printf>
    800061a8:	00003517          	auipc	a0,0x3
    800061ac:	2c850513          	addi	a0,a0,712 # 80009470 <CONSOLE_STATUS+0x460>
    800061b0:	00001097          	auipc	ra,0x1
    800061b4:	a98080e7          	jalr	-1384(ra) # 80006c48 <__printf>
    800061b8:	00001097          	auipc	ra,0x1
    800061bc:	4b0080e7          	jalr	1200(ra) # 80007668 <kinit>
    800061c0:	00000097          	auipc	ra,0x0
    800061c4:	148080e7          	jalr	328(ra) # 80006308 <trapinit>
    800061c8:	00000097          	auipc	ra,0x0
    800061cc:	16c080e7          	jalr	364(ra) # 80006334 <trapinithart>
    800061d0:	00000097          	auipc	ra,0x0
    800061d4:	5c0080e7          	jalr	1472(ra) # 80006790 <plicinit>
    800061d8:	00000097          	auipc	ra,0x0
    800061dc:	5e0080e7          	jalr	1504(ra) # 800067b8 <plicinithart>
    800061e0:	00000097          	auipc	ra,0x0
    800061e4:	078080e7          	jalr	120(ra) # 80006258 <userinit>
    800061e8:	0ff0000f          	fence
    800061ec:	00100793          	li	a5,1
    800061f0:	00003517          	auipc	a0,0x3
    800061f4:	3e050513          	addi	a0,a0,992 # 800095d0 <CONSOLE_STATUS+0x5c0>
    800061f8:	00f4a023          	sw	a5,0(s1)
    800061fc:	00001097          	auipc	ra,0x1
    80006200:	a4c080e7          	jalr	-1460(ra) # 80006c48 <__printf>
    80006204:	0000006f          	j	80006204 <system_main+0xd4>

0000000080006208 <cpuid>:
    80006208:	ff010113          	addi	sp,sp,-16
    8000620c:	00813423          	sd	s0,8(sp)
    80006210:	01010413          	addi	s0,sp,16
    80006214:	00020513          	mv	a0,tp
    80006218:	00813403          	ld	s0,8(sp)
    8000621c:	0005051b          	sext.w	a0,a0
    80006220:	01010113          	addi	sp,sp,16
    80006224:	00008067          	ret

0000000080006228 <mycpu>:
    80006228:	ff010113          	addi	sp,sp,-16
    8000622c:	00813423          	sd	s0,8(sp)
    80006230:	01010413          	addi	s0,sp,16
    80006234:	00020793          	mv	a5,tp
    80006238:	00813403          	ld	s0,8(sp)
    8000623c:	0007879b          	sext.w	a5,a5
    80006240:	00779793          	slli	a5,a5,0x7
    80006244:	00009517          	auipc	a0,0x9
    80006248:	51c50513          	addi	a0,a0,1308 # 8000f760 <cpus>
    8000624c:	00f50533          	add	a0,a0,a5
    80006250:	01010113          	addi	sp,sp,16
    80006254:	00008067          	ret

0000000080006258 <userinit>:
    80006258:	ff010113          	addi	sp,sp,-16
    8000625c:	00813423          	sd	s0,8(sp)
    80006260:	01010413          	addi	s0,sp,16
    80006264:	00813403          	ld	s0,8(sp)
    80006268:	01010113          	addi	sp,sp,16
    8000626c:	ffffc317          	auipc	t1,0xffffc
    80006270:	9cc30067          	jr	-1588(t1) # 80001c38 <main>

0000000080006274 <either_copyout>:
    80006274:	ff010113          	addi	sp,sp,-16
    80006278:	00813023          	sd	s0,0(sp)
    8000627c:	00113423          	sd	ra,8(sp)
    80006280:	01010413          	addi	s0,sp,16
    80006284:	02051663          	bnez	a0,800062b0 <either_copyout+0x3c>
    80006288:	00058513          	mv	a0,a1
    8000628c:	00060593          	mv	a1,a2
    80006290:	0006861b          	sext.w	a2,a3
    80006294:	00002097          	auipc	ra,0x2
    80006298:	c60080e7          	jalr	-928(ra) # 80007ef4 <__memmove>
    8000629c:	00813083          	ld	ra,8(sp)
    800062a0:	00013403          	ld	s0,0(sp)
    800062a4:	00000513          	li	a0,0
    800062a8:	01010113          	addi	sp,sp,16
    800062ac:	00008067          	ret
    800062b0:	00003517          	auipc	a0,0x3
    800062b4:	36050513          	addi	a0,a0,864 # 80009610 <CONSOLE_STATUS+0x600>
    800062b8:	00001097          	auipc	ra,0x1
    800062bc:	934080e7          	jalr	-1740(ra) # 80006bec <panic>

00000000800062c0 <either_copyin>:
    800062c0:	ff010113          	addi	sp,sp,-16
    800062c4:	00813023          	sd	s0,0(sp)
    800062c8:	00113423          	sd	ra,8(sp)
    800062cc:	01010413          	addi	s0,sp,16
    800062d0:	02059463          	bnez	a1,800062f8 <either_copyin+0x38>
    800062d4:	00060593          	mv	a1,a2
    800062d8:	0006861b          	sext.w	a2,a3
    800062dc:	00002097          	auipc	ra,0x2
    800062e0:	c18080e7          	jalr	-1000(ra) # 80007ef4 <__memmove>
    800062e4:	00813083          	ld	ra,8(sp)
    800062e8:	00013403          	ld	s0,0(sp)
    800062ec:	00000513          	li	a0,0
    800062f0:	01010113          	addi	sp,sp,16
    800062f4:	00008067          	ret
    800062f8:	00003517          	auipc	a0,0x3
    800062fc:	34050513          	addi	a0,a0,832 # 80009638 <CONSOLE_STATUS+0x628>
    80006300:	00001097          	auipc	ra,0x1
    80006304:	8ec080e7          	jalr	-1812(ra) # 80006bec <panic>

0000000080006308 <trapinit>:
    80006308:	ff010113          	addi	sp,sp,-16
    8000630c:	00813423          	sd	s0,8(sp)
    80006310:	01010413          	addi	s0,sp,16
    80006314:	00813403          	ld	s0,8(sp)
    80006318:	00003597          	auipc	a1,0x3
    8000631c:	34858593          	addi	a1,a1,840 # 80009660 <CONSOLE_STATUS+0x650>
    80006320:	00009517          	auipc	a0,0x9
    80006324:	4c050513          	addi	a0,a0,1216 # 8000f7e0 <tickslock>
    80006328:	01010113          	addi	sp,sp,16
    8000632c:	00001317          	auipc	t1,0x1
    80006330:	5cc30067          	jr	1484(t1) # 800078f8 <initlock>

0000000080006334 <trapinithart>:
    80006334:	ff010113          	addi	sp,sp,-16
    80006338:	00813423          	sd	s0,8(sp)
    8000633c:	01010413          	addi	s0,sp,16
    80006340:	00000797          	auipc	a5,0x0
    80006344:	30078793          	addi	a5,a5,768 # 80006640 <kernelvec>
    80006348:	10579073          	csrw	stvec,a5
    8000634c:	00813403          	ld	s0,8(sp)
    80006350:	01010113          	addi	sp,sp,16
    80006354:	00008067          	ret

0000000080006358 <usertrap>:
    80006358:	ff010113          	addi	sp,sp,-16
    8000635c:	00813423          	sd	s0,8(sp)
    80006360:	01010413          	addi	s0,sp,16
    80006364:	00813403          	ld	s0,8(sp)
    80006368:	01010113          	addi	sp,sp,16
    8000636c:	00008067          	ret

0000000080006370 <usertrapret>:
    80006370:	ff010113          	addi	sp,sp,-16
    80006374:	00813423          	sd	s0,8(sp)
    80006378:	01010413          	addi	s0,sp,16
    8000637c:	00813403          	ld	s0,8(sp)
    80006380:	01010113          	addi	sp,sp,16
    80006384:	00008067          	ret

0000000080006388 <kerneltrap>:
    80006388:	fe010113          	addi	sp,sp,-32
    8000638c:	00813823          	sd	s0,16(sp)
    80006390:	00113c23          	sd	ra,24(sp)
    80006394:	00913423          	sd	s1,8(sp)
    80006398:	02010413          	addi	s0,sp,32
    8000639c:	142025f3          	csrr	a1,scause
    800063a0:	100027f3          	csrr	a5,sstatus
    800063a4:	0027f793          	andi	a5,a5,2
    800063a8:	10079c63          	bnez	a5,800064c0 <kerneltrap+0x138>
    800063ac:	142027f3          	csrr	a5,scause
    800063b0:	0207ce63          	bltz	a5,800063ec <kerneltrap+0x64>
    800063b4:	00003517          	auipc	a0,0x3
    800063b8:	2f450513          	addi	a0,a0,756 # 800096a8 <CONSOLE_STATUS+0x698>
    800063bc:	00001097          	auipc	ra,0x1
    800063c0:	88c080e7          	jalr	-1908(ra) # 80006c48 <__printf>
    800063c4:	141025f3          	csrr	a1,sepc
    800063c8:	14302673          	csrr	a2,stval
    800063cc:	00003517          	auipc	a0,0x3
    800063d0:	2ec50513          	addi	a0,a0,748 # 800096b8 <CONSOLE_STATUS+0x6a8>
    800063d4:	00001097          	auipc	ra,0x1
    800063d8:	874080e7          	jalr	-1932(ra) # 80006c48 <__printf>
    800063dc:	00003517          	auipc	a0,0x3
    800063e0:	2f450513          	addi	a0,a0,756 # 800096d0 <CONSOLE_STATUS+0x6c0>
    800063e4:	00001097          	auipc	ra,0x1
    800063e8:	808080e7          	jalr	-2040(ra) # 80006bec <panic>
    800063ec:	0ff7f713          	andi	a4,a5,255
    800063f0:	00900693          	li	a3,9
    800063f4:	04d70063          	beq	a4,a3,80006434 <kerneltrap+0xac>
    800063f8:	fff00713          	li	a4,-1
    800063fc:	03f71713          	slli	a4,a4,0x3f
    80006400:	00170713          	addi	a4,a4,1
    80006404:	fae798e3          	bne	a5,a4,800063b4 <kerneltrap+0x2c>
    80006408:	00000097          	auipc	ra,0x0
    8000640c:	e00080e7          	jalr	-512(ra) # 80006208 <cpuid>
    80006410:	06050663          	beqz	a0,8000647c <kerneltrap+0xf4>
    80006414:	144027f3          	csrr	a5,sip
    80006418:	ffd7f793          	andi	a5,a5,-3
    8000641c:	14479073          	csrw	sip,a5
    80006420:	01813083          	ld	ra,24(sp)
    80006424:	01013403          	ld	s0,16(sp)
    80006428:	00813483          	ld	s1,8(sp)
    8000642c:	02010113          	addi	sp,sp,32
    80006430:	00008067          	ret
    80006434:	00000097          	auipc	ra,0x0
    80006438:	3d0080e7          	jalr	976(ra) # 80006804 <plic_claim>
    8000643c:	00a00793          	li	a5,10
    80006440:	00050493          	mv	s1,a0
    80006444:	06f50863          	beq	a0,a5,800064b4 <kerneltrap+0x12c>
    80006448:	fc050ce3          	beqz	a0,80006420 <kerneltrap+0x98>
    8000644c:	00050593          	mv	a1,a0
    80006450:	00003517          	auipc	a0,0x3
    80006454:	23850513          	addi	a0,a0,568 # 80009688 <CONSOLE_STATUS+0x678>
    80006458:	00000097          	auipc	ra,0x0
    8000645c:	7f0080e7          	jalr	2032(ra) # 80006c48 <__printf>
    80006460:	01013403          	ld	s0,16(sp)
    80006464:	01813083          	ld	ra,24(sp)
    80006468:	00048513          	mv	a0,s1
    8000646c:	00813483          	ld	s1,8(sp)
    80006470:	02010113          	addi	sp,sp,32
    80006474:	00000317          	auipc	t1,0x0
    80006478:	3c830067          	jr	968(t1) # 8000683c <plic_complete>
    8000647c:	00009517          	auipc	a0,0x9
    80006480:	36450513          	addi	a0,a0,868 # 8000f7e0 <tickslock>
    80006484:	00001097          	auipc	ra,0x1
    80006488:	498080e7          	jalr	1176(ra) # 8000791c <acquire>
    8000648c:	00005717          	auipc	a4,0x5
    80006490:	dd870713          	addi	a4,a4,-552 # 8000b264 <ticks>
    80006494:	00072783          	lw	a5,0(a4)
    80006498:	00009517          	auipc	a0,0x9
    8000649c:	34850513          	addi	a0,a0,840 # 8000f7e0 <tickslock>
    800064a0:	0017879b          	addiw	a5,a5,1
    800064a4:	00f72023          	sw	a5,0(a4)
    800064a8:	00001097          	auipc	ra,0x1
    800064ac:	540080e7          	jalr	1344(ra) # 800079e8 <release>
    800064b0:	f65ff06f          	j	80006414 <kerneltrap+0x8c>
    800064b4:	00001097          	auipc	ra,0x1
    800064b8:	09c080e7          	jalr	156(ra) # 80007550 <uartintr>
    800064bc:	fa5ff06f          	j	80006460 <kerneltrap+0xd8>
    800064c0:	00003517          	auipc	a0,0x3
    800064c4:	1a850513          	addi	a0,a0,424 # 80009668 <CONSOLE_STATUS+0x658>
    800064c8:	00000097          	auipc	ra,0x0
    800064cc:	724080e7          	jalr	1828(ra) # 80006bec <panic>

00000000800064d0 <clockintr>:
    800064d0:	fe010113          	addi	sp,sp,-32
    800064d4:	00813823          	sd	s0,16(sp)
    800064d8:	00913423          	sd	s1,8(sp)
    800064dc:	00113c23          	sd	ra,24(sp)
    800064e0:	02010413          	addi	s0,sp,32
    800064e4:	00009497          	auipc	s1,0x9
    800064e8:	2fc48493          	addi	s1,s1,764 # 8000f7e0 <tickslock>
    800064ec:	00048513          	mv	a0,s1
    800064f0:	00001097          	auipc	ra,0x1
    800064f4:	42c080e7          	jalr	1068(ra) # 8000791c <acquire>
    800064f8:	00005717          	auipc	a4,0x5
    800064fc:	d6c70713          	addi	a4,a4,-660 # 8000b264 <ticks>
    80006500:	00072783          	lw	a5,0(a4)
    80006504:	01013403          	ld	s0,16(sp)
    80006508:	01813083          	ld	ra,24(sp)
    8000650c:	00048513          	mv	a0,s1
    80006510:	0017879b          	addiw	a5,a5,1
    80006514:	00813483          	ld	s1,8(sp)
    80006518:	00f72023          	sw	a5,0(a4)
    8000651c:	02010113          	addi	sp,sp,32
    80006520:	00001317          	auipc	t1,0x1
    80006524:	4c830067          	jr	1224(t1) # 800079e8 <release>

0000000080006528 <devintr>:
    80006528:	142027f3          	csrr	a5,scause
    8000652c:	00000513          	li	a0,0
    80006530:	0007c463          	bltz	a5,80006538 <devintr+0x10>
    80006534:	00008067          	ret
    80006538:	fe010113          	addi	sp,sp,-32
    8000653c:	00813823          	sd	s0,16(sp)
    80006540:	00113c23          	sd	ra,24(sp)
    80006544:	00913423          	sd	s1,8(sp)
    80006548:	02010413          	addi	s0,sp,32
    8000654c:	0ff7f713          	andi	a4,a5,255
    80006550:	00900693          	li	a3,9
    80006554:	04d70c63          	beq	a4,a3,800065ac <devintr+0x84>
    80006558:	fff00713          	li	a4,-1
    8000655c:	03f71713          	slli	a4,a4,0x3f
    80006560:	00170713          	addi	a4,a4,1
    80006564:	00e78c63          	beq	a5,a4,8000657c <devintr+0x54>
    80006568:	01813083          	ld	ra,24(sp)
    8000656c:	01013403          	ld	s0,16(sp)
    80006570:	00813483          	ld	s1,8(sp)
    80006574:	02010113          	addi	sp,sp,32
    80006578:	00008067          	ret
    8000657c:	00000097          	auipc	ra,0x0
    80006580:	c8c080e7          	jalr	-884(ra) # 80006208 <cpuid>
    80006584:	06050663          	beqz	a0,800065f0 <devintr+0xc8>
    80006588:	144027f3          	csrr	a5,sip
    8000658c:	ffd7f793          	andi	a5,a5,-3
    80006590:	14479073          	csrw	sip,a5
    80006594:	01813083          	ld	ra,24(sp)
    80006598:	01013403          	ld	s0,16(sp)
    8000659c:	00813483          	ld	s1,8(sp)
    800065a0:	00200513          	li	a0,2
    800065a4:	02010113          	addi	sp,sp,32
    800065a8:	00008067          	ret
    800065ac:	00000097          	auipc	ra,0x0
    800065b0:	258080e7          	jalr	600(ra) # 80006804 <plic_claim>
    800065b4:	00a00793          	li	a5,10
    800065b8:	00050493          	mv	s1,a0
    800065bc:	06f50663          	beq	a0,a5,80006628 <devintr+0x100>
    800065c0:	00100513          	li	a0,1
    800065c4:	fa0482e3          	beqz	s1,80006568 <devintr+0x40>
    800065c8:	00048593          	mv	a1,s1
    800065cc:	00003517          	auipc	a0,0x3
    800065d0:	0bc50513          	addi	a0,a0,188 # 80009688 <CONSOLE_STATUS+0x678>
    800065d4:	00000097          	auipc	ra,0x0
    800065d8:	674080e7          	jalr	1652(ra) # 80006c48 <__printf>
    800065dc:	00048513          	mv	a0,s1
    800065e0:	00000097          	auipc	ra,0x0
    800065e4:	25c080e7          	jalr	604(ra) # 8000683c <plic_complete>
    800065e8:	00100513          	li	a0,1
    800065ec:	f7dff06f          	j	80006568 <devintr+0x40>
    800065f0:	00009517          	auipc	a0,0x9
    800065f4:	1f050513          	addi	a0,a0,496 # 8000f7e0 <tickslock>
    800065f8:	00001097          	auipc	ra,0x1
    800065fc:	324080e7          	jalr	804(ra) # 8000791c <acquire>
    80006600:	00005717          	auipc	a4,0x5
    80006604:	c6470713          	addi	a4,a4,-924 # 8000b264 <ticks>
    80006608:	00072783          	lw	a5,0(a4)
    8000660c:	00009517          	auipc	a0,0x9
    80006610:	1d450513          	addi	a0,a0,468 # 8000f7e0 <tickslock>
    80006614:	0017879b          	addiw	a5,a5,1
    80006618:	00f72023          	sw	a5,0(a4)
    8000661c:	00001097          	auipc	ra,0x1
    80006620:	3cc080e7          	jalr	972(ra) # 800079e8 <release>
    80006624:	f65ff06f          	j	80006588 <devintr+0x60>
    80006628:	00001097          	auipc	ra,0x1
    8000662c:	f28080e7          	jalr	-216(ra) # 80007550 <uartintr>
    80006630:	fadff06f          	j	800065dc <devintr+0xb4>
	...

0000000080006640 <kernelvec>:
    80006640:	f0010113          	addi	sp,sp,-256
    80006644:	00113023          	sd	ra,0(sp)
    80006648:	00213423          	sd	sp,8(sp)
    8000664c:	00313823          	sd	gp,16(sp)
    80006650:	00413c23          	sd	tp,24(sp)
    80006654:	02513023          	sd	t0,32(sp)
    80006658:	02613423          	sd	t1,40(sp)
    8000665c:	02713823          	sd	t2,48(sp)
    80006660:	02813c23          	sd	s0,56(sp)
    80006664:	04913023          	sd	s1,64(sp)
    80006668:	04a13423          	sd	a0,72(sp)
    8000666c:	04b13823          	sd	a1,80(sp)
    80006670:	04c13c23          	sd	a2,88(sp)
    80006674:	06d13023          	sd	a3,96(sp)
    80006678:	06e13423          	sd	a4,104(sp)
    8000667c:	06f13823          	sd	a5,112(sp)
    80006680:	07013c23          	sd	a6,120(sp)
    80006684:	09113023          	sd	a7,128(sp)
    80006688:	09213423          	sd	s2,136(sp)
    8000668c:	09313823          	sd	s3,144(sp)
    80006690:	09413c23          	sd	s4,152(sp)
    80006694:	0b513023          	sd	s5,160(sp)
    80006698:	0b613423          	sd	s6,168(sp)
    8000669c:	0b713823          	sd	s7,176(sp)
    800066a0:	0b813c23          	sd	s8,184(sp)
    800066a4:	0d913023          	sd	s9,192(sp)
    800066a8:	0da13423          	sd	s10,200(sp)
    800066ac:	0db13823          	sd	s11,208(sp)
    800066b0:	0dc13c23          	sd	t3,216(sp)
    800066b4:	0fd13023          	sd	t4,224(sp)
    800066b8:	0fe13423          	sd	t5,232(sp)
    800066bc:	0ff13823          	sd	t6,240(sp)
    800066c0:	cc9ff0ef          	jal	ra,80006388 <kerneltrap>
    800066c4:	00013083          	ld	ra,0(sp)
    800066c8:	00813103          	ld	sp,8(sp)
    800066cc:	01013183          	ld	gp,16(sp)
    800066d0:	02013283          	ld	t0,32(sp)
    800066d4:	02813303          	ld	t1,40(sp)
    800066d8:	03013383          	ld	t2,48(sp)
    800066dc:	03813403          	ld	s0,56(sp)
    800066e0:	04013483          	ld	s1,64(sp)
    800066e4:	04813503          	ld	a0,72(sp)
    800066e8:	05013583          	ld	a1,80(sp)
    800066ec:	05813603          	ld	a2,88(sp)
    800066f0:	06013683          	ld	a3,96(sp)
    800066f4:	06813703          	ld	a4,104(sp)
    800066f8:	07013783          	ld	a5,112(sp)
    800066fc:	07813803          	ld	a6,120(sp)
    80006700:	08013883          	ld	a7,128(sp)
    80006704:	08813903          	ld	s2,136(sp)
    80006708:	09013983          	ld	s3,144(sp)
    8000670c:	09813a03          	ld	s4,152(sp)
    80006710:	0a013a83          	ld	s5,160(sp)
    80006714:	0a813b03          	ld	s6,168(sp)
    80006718:	0b013b83          	ld	s7,176(sp)
    8000671c:	0b813c03          	ld	s8,184(sp)
    80006720:	0c013c83          	ld	s9,192(sp)
    80006724:	0c813d03          	ld	s10,200(sp)
    80006728:	0d013d83          	ld	s11,208(sp)
    8000672c:	0d813e03          	ld	t3,216(sp)
    80006730:	0e013e83          	ld	t4,224(sp)
    80006734:	0e813f03          	ld	t5,232(sp)
    80006738:	0f013f83          	ld	t6,240(sp)
    8000673c:	10010113          	addi	sp,sp,256
    80006740:	10200073          	sret
    80006744:	00000013          	nop
    80006748:	00000013          	nop
    8000674c:	00000013          	nop

0000000080006750 <timervec>:
    80006750:	34051573          	csrrw	a0,mscratch,a0
    80006754:	00b53023          	sd	a1,0(a0)
    80006758:	00c53423          	sd	a2,8(a0)
    8000675c:	00d53823          	sd	a3,16(a0)
    80006760:	01853583          	ld	a1,24(a0)
    80006764:	02053603          	ld	a2,32(a0)
    80006768:	0005b683          	ld	a3,0(a1)
    8000676c:	00c686b3          	add	a3,a3,a2
    80006770:	00d5b023          	sd	a3,0(a1)
    80006774:	00200593          	li	a1,2
    80006778:	14459073          	csrw	sip,a1
    8000677c:	01053683          	ld	a3,16(a0)
    80006780:	00853603          	ld	a2,8(a0)
    80006784:	00053583          	ld	a1,0(a0)
    80006788:	34051573          	csrrw	a0,mscratch,a0
    8000678c:	30200073          	mret

0000000080006790 <plicinit>:
    80006790:	ff010113          	addi	sp,sp,-16
    80006794:	00813423          	sd	s0,8(sp)
    80006798:	01010413          	addi	s0,sp,16
    8000679c:	00813403          	ld	s0,8(sp)
    800067a0:	0c0007b7          	lui	a5,0xc000
    800067a4:	00100713          	li	a4,1
    800067a8:	02e7a423          	sw	a4,40(a5) # c000028 <_entry-0x73ffffd8>
    800067ac:	00e7a223          	sw	a4,4(a5)
    800067b0:	01010113          	addi	sp,sp,16
    800067b4:	00008067          	ret

00000000800067b8 <plicinithart>:
    800067b8:	ff010113          	addi	sp,sp,-16
    800067bc:	00813023          	sd	s0,0(sp)
    800067c0:	00113423          	sd	ra,8(sp)
    800067c4:	01010413          	addi	s0,sp,16
    800067c8:	00000097          	auipc	ra,0x0
    800067cc:	a40080e7          	jalr	-1472(ra) # 80006208 <cpuid>
    800067d0:	0085171b          	slliw	a4,a0,0x8
    800067d4:	0c0027b7          	lui	a5,0xc002
    800067d8:	00e787b3          	add	a5,a5,a4
    800067dc:	40200713          	li	a4,1026
    800067e0:	08e7a023          	sw	a4,128(a5) # c002080 <_entry-0x73ffdf80>
    800067e4:	00813083          	ld	ra,8(sp)
    800067e8:	00013403          	ld	s0,0(sp)
    800067ec:	00d5151b          	slliw	a0,a0,0xd
    800067f0:	0c2017b7          	lui	a5,0xc201
    800067f4:	00a78533          	add	a0,a5,a0
    800067f8:	00052023          	sw	zero,0(a0)
    800067fc:	01010113          	addi	sp,sp,16
    80006800:	00008067          	ret

0000000080006804 <plic_claim>:
    80006804:	ff010113          	addi	sp,sp,-16
    80006808:	00813023          	sd	s0,0(sp)
    8000680c:	00113423          	sd	ra,8(sp)
    80006810:	01010413          	addi	s0,sp,16
    80006814:	00000097          	auipc	ra,0x0
    80006818:	9f4080e7          	jalr	-1548(ra) # 80006208 <cpuid>
    8000681c:	00813083          	ld	ra,8(sp)
    80006820:	00013403          	ld	s0,0(sp)
    80006824:	00d5151b          	slliw	a0,a0,0xd
    80006828:	0c2017b7          	lui	a5,0xc201
    8000682c:	00a78533          	add	a0,a5,a0
    80006830:	00452503          	lw	a0,4(a0)
    80006834:	01010113          	addi	sp,sp,16
    80006838:	00008067          	ret

000000008000683c <plic_complete>:
    8000683c:	fe010113          	addi	sp,sp,-32
    80006840:	00813823          	sd	s0,16(sp)
    80006844:	00913423          	sd	s1,8(sp)
    80006848:	00113c23          	sd	ra,24(sp)
    8000684c:	02010413          	addi	s0,sp,32
    80006850:	00050493          	mv	s1,a0
    80006854:	00000097          	auipc	ra,0x0
    80006858:	9b4080e7          	jalr	-1612(ra) # 80006208 <cpuid>
    8000685c:	01813083          	ld	ra,24(sp)
    80006860:	01013403          	ld	s0,16(sp)
    80006864:	00d5179b          	slliw	a5,a0,0xd
    80006868:	0c201737          	lui	a4,0xc201
    8000686c:	00f707b3          	add	a5,a4,a5
    80006870:	0097a223          	sw	s1,4(a5) # c201004 <_entry-0x73dfeffc>
    80006874:	00813483          	ld	s1,8(sp)
    80006878:	02010113          	addi	sp,sp,32
    8000687c:	00008067          	ret

0000000080006880 <consolewrite>:
    80006880:	fb010113          	addi	sp,sp,-80
    80006884:	04813023          	sd	s0,64(sp)
    80006888:	04113423          	sd	ra,72(sp)
    8000688c:	02913c23          	sd	s1,56(sp)
    80006890:	03213823          	sd	s2,48(sp)
    80006894:	03313423          	sd	s3,40(sp)
    80006898:	03413023          	sd	s4,32(sp)
    8000689c:	01513c23          	sd	s5,24(sp)
    800068a0:	05010413          	addi	s0,sp,80
    800068a4:	06c05c63          	blez	a2,8000691c <consolewrite+0x9c>
    800068a8:	00060993          	mv	s3,a2
    800068ac:	00050a13          	mv	s4,a0
    800068b0:	00058493          	mv	s1,a1
    800068b4:	00000913          	li	s2,0
    800068b8:	fff00a93          	li	s5,-1
    800068bc:	01c0006f          	j	800068d8 <consolewrite+0x58>
    800068c0:	fbf44503          	lbu	a0,-65(s0)
    800068c4:	0019091b          	addiw	s2,s2,1
    800068c8:	00148493          	addi	s1,s1,1
    800068cc:	00001097          	auipc	ra,0x1
    800068d0:	a9c080e7          	jalr	-1380(ra) # 80007368 <uartputc>
    800068d4:	03298063          	beq	s3,s2,800068f4 <consolewrite+0x74>
    800068d8:	00048613          	mv	a2,s1
    800068dc:	00100693          	li	a3,1
    800068e0:	000a0593          	mv	a1,s4
    800068e4:	fbf40513          	addi	a0,s0,-65
    800068e8:	00000097          	auipc	ra,0x0
    800068ec:	9d8080e7          	jalr	-1576(ra) # 800062c0 <either_copyin>
    800068f0:	fd5518e3          	bne	a0,s5,800068c0 <consolewrite+0x40>
    800068f4:	04813083          	ld	ra,72(sp)
    800068f8:	04013403          	ld	s0,64(sp)
    800068fc:	03813483          	ld	s1,56(sp)
    80006900:	02813983          	ld	s3,40(sp)
    80006904:	02013a03          	ld	s4,32(sp)
    80006908:	01813a83          	ld	s5,24(sp)
    8000690c:	00090513          	mv	a0,s2
    80006910:	03013903          	ld	s2,48(sp)
    80006914:	05010113          	addi	sp,sp,80
    80006918:	00008067          	ret
    8000691c:	00000913          	li	s2,0
    80006920:	fd5ff06f          	j	800068f4 <consolewrite+0x74>

0000000080006924 <consoleread>:
    80006924:	f9010113          	addi	sp,sp,-112
    80006928:	06813023          	sd	s0,96(sp)
    8000692c:	04913c23          	sd	s1,88(sp)
    80006930:	05213823          	sd	s2,80(sp)
    80006934:	05313423          	sd	s3,72(sp)
    80006938:	05413023          	sd	s4,64(sp)
    8000693c:	03513c23          	sd	s5,56(sp)
    80006940:	03613823          	sd	s6,48(sp)
    80006944:	03713423          	sd	s7,40(sp)
    80006948:	03813023          	sd	s8,32(sp)
    8000694c:	06113423          	sd	ra,104(sp)
    80006950:	01913c23          	sd	s9,24(sp)
    80006954:	07010413          	addi	s0,sp,112
    80006958:	00060b93          	mv	s7,a2
    8000695c:	00050913          	mv	s2,a0
    80006960:	00058c13          	mv	s8,a1
    80006964:	00060b1b          	sext.w	s6,a2
    80006968:	00009497          	auipc	s1,0x9
    8000696c:	ea048493          	addi	s1,s1,-352 # 8000f808 <cons>
    80006970:	00400993          	li	s3,4
    80006974:	fff00a13          	li	s4,-1
    80006978:	00a00a93          	li	s5,10
    8000697c:	05705e63          	blez	s7,800069d8 <consoleread+0xb4>
    80006980:	09c4a703          	lw	a4,156(s1)
    80006984:	0984a783          	lw	a5,152(s1)
    80006988:	0007071b          	sext.w	a4,a4
    8000698c:	08e78463          	beq	a5,a4,80006a14 <consoleread+0xf0>
    80006990:	07f7f713          	andi	a4,a5,127
    80006994:	00e48733          	add	a4,s1,a4
    80006998:	01874703          	lbu	a4,24(a4) # c201018 <_entry-0x73dfefe8>
    8000699c:	0017869b          	addiw	a3,a5,1
    800069a0:	08d4ac23          	sw	a3,152(s1)
    800069a4:	00070c9b          	sext.w	s9,a4
    800069a8:	0b370663          	beq	a4,s3,80006a54 <consoleread+0x130>
    800069ac:	00100693          	li	a3,1
    800069b0:	f9f40613          	addi	a2,s0,-97
    800069b4:	000c0593          	mv	a1,s8
    800069b8:	00090513          	mv	a0,s2
    800069bc:	f8e40fa3          	sb	a4,-97(s0)
    800069c0:	00000097          	auipc	ra,0x0
    800069c4:	8b4080e7          	jalr	-1868(ra) # 80006274 <either_copyout>
    800069c8:	01450863          	beq	a0,s4,800069d8 <consoleread+0xb4>
    800069cc:	001c0c13          	addi	s8,s8,1
    800069d0:	fffb8b9b          	addiw	s7,s7,-1
    800069d4:	fb5c94e3          	bne	s9,s5,8000697c <consoleread+0x58>
    800069d8:	000b851b          	sext.w	a0,s7
    800069dc:	06813083          	ld	ra,104(sp)
    800069e0:	06013403          	ld	s0,96(sp)
    800069e4:	05813483          	ld	s1,88(sp)
    800069e8:	05013903          	ld	s2,80(sp)
    800069ec:	04813983          	ld	s3,72(sp)
    800069f0:	04013a03          	ld	s4,64(sp)
    800069f4:	03813a83          	ld	s5,56(sp)
    800069f8:	02813b83          	ld	s7,40(sp)
    800069fc:	02013c03          	ld	s8,32(sp)
    80006a00:	01813c83          	ld	s9,24(sp)
    80006a04:	40ab053b          	subw	a0,s6,a0
    80006a08:	03013b03          	ld	s6,48(sp)
    80006a0c:	07010113          	addi	sp,sp,112
    80006a10:	00008067          	ret
    80006a14:	00001097          	auipc	ra,0x1
    80006a18:	1d8080e7          	jalr	472(ra) # 80007bec <push_on>
    80006a1c:	0984a703          	lw	a4,152(s1)
    80006a20:	09c4a783          	lw	a5,156(s1)
    80006a24:	0007879b          	sext.w	a5,a5
    80006a28:	fef70ce3          	beq	a4,a5,80006a20 <consoleread+0xfc>
    80006a2c:	00001097          	auipc	ra,0x1
    80006a30:	234080e7          	jalr	564(ra) # 80007c60 <pop_on>
    80006a34:	0984a783          	lw	a5,152(s1)
    80006a38:	07f7f713          	andi	a4,a5,127
    80006a3c:	00e48733          	add	a4,s1,a4
    80006a40:	01874703          	lbu	a4,24(a4)
    80006a44:	0017869b          	addiw	a3,a5,1
    80006a48:	08d4ac23          	sw	a3,152(s1)
    80006a4c:	00070c9b          	sext.w	s9,a4
    80006a50:	f5371ee3          	bne	a4,s3,800069ac <consoleread+0x88>
    80006a54:	000b851b          	sext.w	a0,s7
    80006a58:	f96bf2e3          	bgeu	s7,s6,800069dc <consoleread+0xb8>
    80006a5c:	08f4ac23          	sw	a5,152(s1)
    80006a60:	f7dff06f          	j	800069dc <consoleread+0xb8>

0000000080006a64 <consputc>:
    80006a64:	10000793          	li	a5,256
    80006a68:	00f50663          	beq	a0,a5,80006a74 <consputc+0x10>
    80006a6c:	00001317          	auipc	t1,0x1
    80006a70:	9f430067          	jr	-1548(t1) # 80007460 <uartputc_sync>
    80006a74:	ff010113          	addi	sp,sp,-16
    80006a78:	00113423          	sd	ra,8(sp)
    80006a7c:	00813023          	sd	s0,0(sp)
    80006a80:	01010413          	addi	s0,sp,16
    80006a84:	00800513          	li	a0,8
    80006a88:	00001097          	auipc	ra,0x1
    80006a8c:	9d8080e7          	jalr	-1576(ra) # 80007460 <uartputc_sync>
    80006a90:	02000513          	li	a0,32
    80006a94:	00001097          	auipc	ra,0x1
    80006a98:	9cc080e7          	jalr	-1588(ra) # 80007460 <uartputc_sync>
    80006a9c:	00013403          	ld	s0,0(sp)
    80006aa0:	00813083          	ld	ra,8(sp)
    80006aa4:	00800513          	li	a0,8
    80006aa8:	01010113          	addi	sp,sp,16
    80006aac:	00001317          	auipc	t1,0x1
    80006ab0:	9b430067          	jr	-1612(t1) # 80007460 <uartputc_sync>

0000000080006ab4 <consoleintr>:
    80006ab4:	fe010113          	addi	sp,sp,-32
    80006ab8:	00813823          	sd	s0,16(sp)
    80006abc:	00913423          	sd	s1,8(sp)
    80006ac0:	01213023          	sd	s2,0(sp)
    80006ac4:	00113c23          	sd	ra,24(sp)
    80006ac8:	02010413          	addi	s0,sp,32
    80006acc:	00009917          	auipc	s2,0x9
    80006ad0:	d3c90913          	addi	s2,s2,-708 # 8000f808 <cons>
    80006ad4:	00050493          	mv	s1,a0
    80006ad8:	00090513          	mv	a0,s2
    80006adc:	00001097          	auipc	ra,0x1
    80006ae0:	e40080e7          	jalr	-448(ra) # 8000791c <acquire>
    80006ae4:	02048c63          	beqz	s1,80006b1c <consoleintr+0x68>
    80006ae8:	0a092783          	lw	a5,160(s2)
    80006aec:	09892703          	lw	a4,152(s2)
    80006af0:	07f00693          	li	a3,127
    80006af4:	40e7873b          	subw	a4,a5,a4
    80006af8:	02e6e263          	bltu	a3,a4,80006b1c <consoleintr+0x68>
    80006afc:	00d00713          	li	a4,13
    80006b00:	04e48063          	beq	s1,a4,80006b40 <consoleintr+0x8c>
    80006b04:	07f7f713          	andi	a4,a5,127
    80006b08:	00e90733          	add	a4,s2,a4
    80006b0c:	0017879b          	addiw	a5,a5,1
    80006b10:	0af92023          	sw	a5,160(s2)
    80006b14:	00970c23          	sb	s1,24(a4)
    80006b18:	08f92e23          	sw	a5,156(s2)
    80006b1c:	01013403          	ld	s0,16(sp)
    80006b20:	01813083          	ld	ra,24(sp)
    80006b24:	00813483          	ld	s1,8(sp)
    80006b28:	00013903          	ld	s2,0(sp)
    80006b2c:	00009517          	auipc	a0,0x9
    80006b30:	cdc50513          	addi	a0,a0,-804 # 8000f808 <cons>
    80006b34:	02010113          	addi	sp,sp,32
    80006b38:	00001317          	auipc	t1,0x1
    80006b3c:	eb030067          	jr	-336(t1) # 800079e8 <release>
    80006b40:	00a00493          	li	s1,10
    80006b44:	fc1ff06f          	j	80006b04 <consoleintr+0x50>

0000000080006b48 <consoleinit>:
    80006b48:	fe010113          	addi	sp,sp,-32
    80006b4c:	00113c23          	sd	ra,24(sp)
    80006b50:	00813823          	sd	s0,16(sp)
    80006b54:	00913423          	sd	s1,8(sp)
    80006b58:	02010413          	addi	s0,sp,32
    80006b5c:	00009497          	auipc	s1,0x9
    80006b60:	cac48493          	addi	s1,s1,-852 # 8000f808 <cons>
    80006b64:	00048513          	mv	a0,s1
    80006b68:	00003597          	auipc	a1,0x3
    80006b6c:	b7858593          	addi	a1,a1,-1160 # 800096e0 <CONSOLE_STATUS+0x6d0>
    80006b70:	00001097          	auipc	ra,0x1
    80006b74:	d88080e7          	jalr	-632(ra) # 800078f8 <initlock>
    80006b78:	00000097          	auipc	ra,0x0
    80006b7c:	7ac080e7          	jalr	1964(ra) # 80007324 <uartinit>
    80006b80:	01813083          	ld	ra,24(sp)
    80006b84:	01013403          	ld	s0,16(sp)
    80006b88:	00000797          	auipc	a5,0x0
    80006b8c:	d9c78793          	addi	a5,a5,-612 # 80006924 <consoleread>
    80006b90:	0af4bc23          	sd	a5,184(s1)
    80006b94:	00000797          	auipc	a5,0x0
    80006b98:	cec78793          	addi	a5,a5,-788 # 80006880 <consolewrite>
    80006b9c:	0cf4b023          	sd	a5,192(s1)
    80006ba0:	00813483          	ld	s1,8(sp)
    80006ba4:	02010113          	addi	sp,sp,32
    80006ba8:	00008067          	ret

0000000080006bac <console_read>:
    80006bac:	ff010113          	addi	sp,sp,-16
    80006bb0:	00813423          	sd	s0,8(sp)
    80006bb4:	01010413          	addi	s0,sp,16
    80006bb8:	00813403          	ld	s0,8(sp)
    80006bbc:	00009317          	auipc	t1,0x9
    80006bc0:	d0433303          	ld	t1,-764(t1) # 8000f8c0 <devsw+0x10>
    80006bc4:	01010113          	addi	sp,sp,16
    80006bc8:	00030067          	jr	t1

0000000080006bcc <console_write>:
    80006bcc:	ff010113          	addi	sp,sp,-16
    80006bd0:	00813423          	sd	s0,8(sp)
    80006bd4:	01010413          	addi	s0,sp,16
    80006bd8:	00813403          	ld	s0,8(sp)
    80006bdc:	00009317          	auipc	t1,0x9
    80006be0:	cec33303          	ld	t1,-788(t1) # 8000f8c8 <devsw+0x18>
    80006be4:	01010113          	addi	sp,sp,16
    80006be8:	00030067          	jr	t1

0000000080006bec <panic>:
    80006bec:	fe010113          	addi	sp,sp,-32
    80006bf0:	00113c23          	sd	ra,24(sp)
    80006bf4:	00813823          	sd	s0,16(sp)
    80006bf8:	00913423          	sd	s1,8(sp)
    80006bfc:	02010413          	addi	s0,sp,32
    80006c00:	00050493          	mv	s1,a0
    80006c04:	00003517          	auipc	a0,0x3
    80006c08:	ae450513          	addi	a0,a0,-1308 # 800096e8 <CONSOLE_STATUS+0x6d8>
    80006c0c:	00009797          	auipc	a5,0x9
    80006c10:	d407ae23          	sw	zero,-676(a5) # 8000f968 <pr+0x18>
    80006c14:	00000097          	auipc	ra,0x0
    80006c18:	034080e7          	jalr	52(ra) # 80006c48 <__printf>
    80006c1c:	00048513          	mv	a0,s1
    80006c20:	00000097          	auipc	ra,0x0
    80006c24:	028080e7          	jalr	40(ra) # 80006c48 <__printf>
    80006c28:	00003517          	auipc	a0,0x3
    80006c2c:	84850513          	addi	a0,a0,-1976 # 80009470 <CONSOLE_STATUS+0x460>
    80006c30:	00000097          	auipc	ra,0x0
    80006c34:	018080e7          	jalr	24(ra) # 80006c48 <__printf>
    80006c38:	00100793          	li	a5,1
    80006c3c:	00004717          	auipc	a4,0x4
    80006c40:	62f72623          	sw	a5,1580(a4) # 8000b268 <panicked>
    80006c44:	0000006f          	j	80006c44 <panic+0x58>

0000000080006c48 <__printf>:
    80006c48:	f3010113          	addi	sp,sp,-208
    80006c4c:	08813023          	sd	s0,128(sp)
    80006c50:	07313423          	sd	s3,104(sp)
    80006c54:	09010413          	addi	s0,sp,144
    80006c58:	05813023          	sd	s8,64(sp)
    80006c5c:	08113423          	sd	ra,136(sp)
    80006c60:	06913c23          	sd	s1,120(sp)
    80006c64:	07213823          	sd	s2,112(sp)
    80006c68:	07413023          	sd	s4,96(sp)
    80006c6c:	05513c23          	sd	s5,88(sp)
    80006c70:	05613823          	sd	s6,80(sp)
    80006c74:	05713423          	sd	s7,72(sp)
    80006c78:	03913c23          	sd	s9,56(sp)
    80006c7c:	03a13823          	sd	s10,48(sp)
    80006c80:	03b13423          	sd	s11,40(sp)
    80006c84:	00009317          	auipc	t1,0x9
    80006c88:	ccc30313          	addi	t1,t1,-820 # 8000f950 <pr>
    80006c8c:	01832c03          	lw	s8,24(t1)
    80006c90:	00b43423          	sd	a1,8(s0)
    80006c94:	00c43823          	sd	a2,16(s0)
    80006c98:	00d43c23          	sd	a3,24(s0)
    80006c9c:	02e43023          	sd	a4,32(s0)
    80006ca0:	02f43423          	sd	a5,40(s0)
    80006ca4:	03043823          	sd	a6,48(s0)
    80006ca8:	03143c23          	sd	a7,56(s0)
    80006cac:	00050993          	mv	s3,a0
    80006cb0:	4a0c1663          	bnez	s8,8000715c <__printf+0x514>
    80006cb4:	60098c63          	beqz	s3,800072cc <__printf+0x684>
    80006cb8:	0009c503          	lbu	a0,0(s3)
    80006cbc:	00840793          	addi	a5,s0,8
    80006cc0:	f6f43c23          	sd	a5,-136(s0)
    80006cc4:	00000493          	li	s1,0
    80006cc8:	22050063          	beqz	a0,80006ee8 <__printf+0x2a0>
    80006ccc:	00002a37          	lui	s4,0x2
    80006cd0:	00018ab7          	lui	s5,0x18
    80006cd4:	000f4b37          	lui	s6,0xf4
    80006cd8:	00989bb7          	lui	s7,0x989
    80006cdc:	70fa0a13          	addi	s4,s4,1807 # 270f <_entry-0x7fffd8f1>
    80006ce0:	69fa8a93          	addi	s5,s5,1695 # 1869f <_entry-0x7ffe7961>
    80006ce4:	23fb0b13          	addi	s6,s6,575 # f423f <_entry-0x7ff0bdc1>
    80006ce8:	67fb8b93          	addi	s7,s7,1663 # 98967f <_entry-0x7f676981>
    80006cec:	00148c9b          	addiw	s9,s1,1
    80006cf0:	02500793          	li	a5,37
    80006cf4:	01998933          	add	s2,s3,s9
    80006cf8:	38f51263          	bne	a0,a5,8000707c <__printf+0x434>
    80006cfc:	00094783          	lbu	a5,0(s2)
    80006d00:	00078c9b          	sext.w	s9,a5
    80006d04:	1e078263          	beqz	a5,80006ee8 <__printf+0x2a0>
    80006d08:	0024849b          	addiw	s1,s1,2
    80006d0c:	07000713          	li	a4,112
    80006d10:	00998933          	add	s2,s3,s1
    80006d14:	38e78a63          	beq	a5,a4,800070a8 <__printf+0x460>
    80006d18:	20f76863          	bltu	a4,a5,80006f28 <__printf+0x2e0>
    80006d1c:	42a78863          	beq	a5,a0,8000714c <__printf+0x504>
    80006d20:	06400713          	li	a4,100
    80006d24:	40e79663          	bne	a5,a4,80007130 <__printf+0x4e8>
    80006d28:	f7843783          	ld	a5,-136(s0)
    80006d2c:	0007a603          	lw	a2,0(a5)
    80006d30:	00878793          	addi	a5,a5,8
    80006d34:	f6f43c23          	sd	a5,-136(s0)
    80006d38:	42064a63          	bltz	a2,8000716c <__printf+0x524>
    80006d3c:	00a00713          	li	a4,10
    80006d40:	02e677bb          	remuw	a5,a2,a4
    80006d44:	00003d97          	auipc	s11,0x3
    80006d48:	9ccd8d93          	addi	s11,s11,-1588 # 80009710 <digits>
    80006d4c:	00900593          	li	a1,9
    80006d50:	0006051b          	sext.w	a0,a2
    80006d54:	00000c93          	li	s9,0
    80006d58:	02079793          	slli	a5,a5,0x20
    80006d5c:	0207d793          	srli	a5,a5,0x20
    80006d60:	00fd87b3          	add	a5,s11,a5
    80006d64:	0007c783          	lbu	a5,0(a5)
    80006d68:	02e656bb          	divuw	a3,a2,a4
    80006d6c:	f8f40023          	sb	a5,-128(s0)
    80006d70:	14c5d863          	bge	a1,a2,80006ec0 <__printf+0x278>
    80006d74:	06300593          	li	a1,99
    80006d78:	00100c93          	li	s9,1
    80006d7c:	02e6f7bb          	remuw	a5,a3,a4
    80006d80:	02079793          	slli	a5,a5,0x20
    80006d84:	0207d793          	srli	a5,a5,0x20
    80006d88:	00fd87b3          	add	a5,s11,a5
    80006d8c:	0007c783          	lbu	a5,0(a5)
    80006d90:	02e6d73b          	divuw	a4,a3,a4
    80006d94:	f8f400a3          	sb	a5,-127(s0)
    80006d98:	12a5f463          	bgeu	a1,a0,80006ec0 <__printf+0x278>
    80006d9c:	00a00693          	li	a3,10
    80006da0:	00900593          	li	a1,9
    80006da4:	02d777bb          	remuw	a5,a4,a3
    80006da8:	02079793          	slli	a5,a5,0x20
    80006dac:	0207d793          	srli	a5,a5,0x20
    80006db0:	00fd87b3          	add	a5,s11,a5
    80006db4:	0007c503          	lbu	a0,0(a5)
    80006db8:	02d757bb          	divuw	a5,a4,a3
    80006dbc:	f8a40123          	sb	a0,-126(s0)
    80006dc0:	48e5f263          	bgeu	a1,a4,80007244 <__printf+0x5fc>
    80006dc4:	06300513          	li	a0,99
    80006dc8:	02d7f5bb          	remuw	a1,a5,a3
    80006dcc:	02059593          	slli	a1,a1,0x20
    80006dd0:	0205d593          	srli	a1,a1,0x20
    80006dd4:	00bd85b3          	add	a1,s11,a1
    80006dd8:	0005c583          	lbu	a1,0(a1)
    80006ddc:	02d7d7bb          	divuw	a5,a5,a3
    80006de0:	f8b401a3          	sb	a1,-125(s0)
    80006de4:	48e57263          	bgeu	a0,a4,80007268 <__printf+0x620>
    80006de8:	3e700513          	li	a0,999
    80006dec:	02d7f5bb          	remuw	a1,a5,a3
    80006df0:	02059593          	slli	a1,a1,0x20
    80006df4:	0205d593          	srli	a1,a1,0x20
    80006df8:	00bd85b3          	add	a1,s11,a1
    80006dfc:	0005c583          	lbu	a1,0(a1)
    80006e00:	02d7d7bb          	divuw	a5,a5,a3
    80006e04:	f8b40223          	sb	a1,-124(s0)
    80006e08:	46e57663          	bgeu	a0,a4,80007274 <__printf+0x62c>
    80006e0c:	02d7f5bb          	remuw	a1,a5,a3
    80006e10:	02059593          	slli	a1,a1,0x20
    80006e14:	0205d593          	srli	a1,a1,0x20
    80006e18:	00bd85b3          	add	a1,s11,a1
    80006e1c:	0005c583          	lbu	a1,0(a1)
    80006e20:	02d7d7bb          	divuw	a5,a5,a3
    80006e24:	f8b402a3          	sb	a1,-123(s0)
    80006e28:	46ea7863          	bgeu	s4,a4,80007298 <__printf+0x650>
    80006e2c:	02d7f5bb          	remuw	a1,a5,a3
    80006e30:	02059593          	slli	a1,a1,0x20
    80006e34:	0205d593          	srli	a1,a1,0x20
    80006e38:	00bd85b3          	add	a1,s11,a1
    80006e3c:	0005c583          	lbu	a1,0(a1)
    80006e40:	02d7d7bb          	divuw	a5,a5,a3
    80006e44:	f8b40323          	sb	a1,-122(s0)
    80006e48:	3eeaf863          	bgeu	s5,a4,80007238 <__printf+0x5f0>
    80006e4c:	02d7f5bb          	remuw	a1,a5,a3
    80006e50:	02059593          	slli	a1,a1,0x20
    80006e54:	0205d593          	srli	a1,a1,0x20
    80006e58:	00bd85b3          	add	a1,s11,a1
    80006e5c:	0005c583          	lbu	a1,0(a1)
    80006e60:	02d7d7bb          	divuw	a5,a5,a3
    80006e64:	f8b403a3          	sb	a1,-121(s0)
    80006e68:	42eb7e63          	bgeu	s6,a4,800072a4 <__printf+0x65c>
    80006e6c:	02d7f5bb          	remuw	a1,a5,a3
    80006e70:	02059593          	slli	a1,a1,0x20
    80006e74:	0205d593          	srli	a1,a1,0x20
    80006e78:	00bd85b3          	add	a1,s11,a1
    80006e7c:	0005c583          	lbu	a1,0(a1)
    80006e80:	02d7d7bb          	divuw	a5,a5,a3
    80006e84:	f8b40423          	sb	a1,-120(s0)
    80006e88:	42ebfc63          	bgeu	s7,a4,800072c0 <__printf+0x678>
    80006e8c:	02079793          	slli	a5,a5,0x20
    80006e90:	0207d793          	srli	a5,a5,0x20
    80006e94:	00fd8db3          	add	s11,s11,a5
    80006e98:	000dc703          	lbu	a4,0(s11)
    80006e9c:	00a00793          	li	a5,10
    80006ea0:	00900c93          	li	s9,9
    80006ea4:	f8e404a3          	sb	a4,-119(s0)
    80006ea8:	00065c63          	bgez	a2,80006ec0 <__printf+0x278>
    80006eac:	f9040713          	addi	a4,s0,-112
    80006eb0:	00f70733          	add	a4,a4,a5
    80006eb4:	02d00693          	li	a3,45
    80006eb8:	fed70823          	sb	a3,-16(a4)
    80006ebc:	00078c93          	mv	s9,a5
    80006ec0:	f8040793          	addi	a5,s0,-128
    80006ec4:	01978cb3          	add	s9,a5,s9
    80006ec8:	f7f40d13          	addi	s10,s0,-129
    80006ecc:	000cc503          	lbu	a0,0(s9)
    80006ed0:	fffc8c93          	addi	s9,s9,-1
    80006ed4:	00000097          	auipc	ra,0x0
    80006ed8:	b90080e7          	jalr	-1136(ra) # 80006a64 <consputc>
    80006edc:	ffac98e3          	bne	s9,s10,80006ecc <__printf+0x284>
    80006ee0:	00094503          	lbu	a0,0(s2)
    80006ee4:	e00514e3          	bnez	a0,80006cec <__printf+0xa4>
    80006ee8:	1a0c1663          	bnez	s8,80007094 <__printf+0x44c>
    80006eec:	08813083          	ld	ra,136(sp)
    80006ef0:	08013403          	ld	s0,128(sp)
    80006ef4:	07813483          	ld	s1,120(sp)
    80006ef8:	07013903          	ld	s2,112(sp)
    80006efc:	06813983          	ld	s3,104(sp)
    80006f00:	06013a03          	ld	s4,96(sp)
    80006f04:	05813a83          	ld	s5,88(sp)
    80006f08:	05013b03          	ld	s6,80(sp)
    80006f0c:	04813b83          	ld	s7,72(sp)
    80006f10:	04013c03          	ld	s8,64(sp)
    80006f14:	03813c83          	ld	s9,56(sp)
    80006f18:	03013d03          	ld	s10,48(sp)
    80006f1c:	02813d83          	ld	s11,40(sp)
    80006f20:	0d010113          	addi	sp,sp,208
    80006f24:	00008067          	ret
    80006f28:	07300713          	li	a4,115
    80006f2c:	1ce78a63          	beq	a5,a4,80007100 <__printf+0x4b8>
    80006f30:	07800713          	li	a4,120
    80006f34:	1ee79e63          	bne	a5,a4,80007130 <__printf+0x4e8>
    80006f38:	f7843783          	ld	a5,-136(s0)
    80006f3c:	0007a703          	lw	a4,0(a5)
    80006f40:	00878793          	addi	a5,a5,8
    80006f44:	f6f43c23          	sd	a5,-136(s0)
    80006f48:	28074263          	bltz	a4,800071cc <__printf+0x584>
    80006f4c:	00002d97          	auipc	s11,0x2
    80006f50:	7c4d8d93          	addi	s11,s11,1988 # 80009710 <digits>
    80006f54:	00f77793          	andi	a5,a4,15
    80006f58:	00fd87b3          	add	a5,s11,a5
    80006f5c:	0007c683          	lbu	a3,0(a5)
    80006f60:	00f00613          	li	a2,15
    80006f64:	0007079b          	sext.w	a5,a4
    80006f68:	f8d40023          	sb	a3,-128(s0)
    80006f6c:	0047559b          	srliw	a1,a4,0x4
    80006f70:	0047569b          	srliw	a3,a4,0x4
    80006f74:	00000c93          	li	s9,0
    80006f78:	0ee65063          	bge	a2,a4,80007058 <__printf+0x410>
    80006f7c:	00f6f693          	andi	a3,a3,15
    80006f80:	00dd86b3          	add	a3,s11,a3
    80006f84:	0006c683          	lbu	a3,0(a3) # 2004000 <_entry-0x7dffc000>
    80006f88:	0087d79b          	srliw	a5,a5,0x8
    80006f8c:	00100c93          	li	s9,1
    80006f90:	f8d400a3          	sb	a3,-127(s0)
    80006f94:	0cb67263          	bgeu	a2,a1,80007058 <__printf+0x410>
    80006f98:	00f7f693          	andi	a3,a5,15
    80006f9c:	00dd86b3          	add	a3,s11,a3
    80006fa0:	0006c583          	lbu	a1,0(a3)
    80006fa4:	00f00613          	li	a2,15
    80006fa8:	0047d69b          	srliw	a3,a5,0x4
    80006fac:	f8b40123          	sb	a1,-126(s0)
    80006fb0:	0047d593          	srli	a1,a5,0x4
    80006fb4:	28f67e63          	bgeu	a2,a5,80007250 <__printf+0x608>
    80006fb8:	00f6f693          	andi	a3,a3,15
    80006fbc:	00dd86b3          	add	a3,s11,a3
    80006fc0:	0006c503          	lbu	a0,0(a3)
    80006fc4:	0087d813          	srli	a6,a5,0x8
    80006fc8:	0087d69b          	srliw	a3,a5,0x8
    80006fcc:	f8a401a3          	sb	a0,-125(s0)
    80006fd0:	28b67663          	bgeu	a2,a1,8000725c <__printf+0x614>
    80006fd4:	00f6f693          	andi	a3,a3,15
    80006fd8:	00dd86b3          	add	a3,s11,a3
    80006fdc:	0006c583          	lbu	a1,0(a3)
    80006fe0:	00c7d513          	srli	a0,a5,0xc
    80006fe4:	00c7d69b          	srliw	a3,a5,0xc
    80006fe8:	f8b40223          	sb	a1,-124(s0)
    80006fec:	29067a63          	bgeu	a2,a6,80007280 <__printf+0x638>
    80006ff0:	00f6f693          	andi	a3,a3,15
    80006ff4:	00dd86b3          	add	a3,s11,a3
    80006ff8:	0006c583          	lbu	a1,0(a3)
    80006ffc:	0107d813          	srli	a6,a5,0x10
    80007000:	0107d69b          	srliw	a3,a5,0x10
    80007004:	f8b402a3          	sb	a1,-123(s0)
    80007008:	28a67263          	bgeu	a2,a0,8000728c <__printf+0x644>
    8000700c:	00f6f693          	andi	a3,a3,15
    80007010:	00dd86b3          	add	a3,s11,a3
    80007014:	0006c683          	lbu	a3,0(a3)
    80007018:	0147d79b          	srliw	a5,a5,0x14
    8000701c:	f8d40323          	sb	a3,-122(s0)
    80007020:	21067663          	bgeu	a2,a6,8000722c <__printf+0x5e4>
    80007024:	02079793          	slli	a5,a5,0x20
    80007028:	0207d793          	srli	a5,a5,0x20
    8000702c:	00fd8db3          	add	s11,s11,a5
    80007030:	000dc683          	lbu	a3,0(s11)
    80007034:	00800793          	li	a5,8
    80007038:	00700c93          	li	s9,7
    8000703c:	f8d403a3          	sb	a3,-121(s0)
    80007040:	00075c63          	bgez	a4,80007058 <__printf+0x410>
    80007044:	f9040713          	addi	a4,s0,-112
    80007048:	00f70733          	add	a4,a4,a5
    8000704c:	02d00693          	li	a3,45
    80007050:	fed70823          	sb	a3,-16(a4)
    80007054:	00078c93          	mv	s9,a5
    80007058:	f8040793          	addi	a5,s0,-128
    8000705c:	01978cb3          	add	s9,a5,s9
    80007060:	f7f40d13          	addi	s10,s0,-129
    80007064:	000cc503          	lbu	a0,0(s9)
    80007068:	fffc8c93          	addi	s9,s9,-1
    8000706c:	00000097          	auipc	ra,0x0
    80007070:	9f8080e7          	jalr	-1544(ra) # 80006a64 <consputc>
    80007074:	ff9d18e3          	bne	s10,s9,80007064 <__printf+0x41c>
    80007078:	0100006f          	j	80007088 <__printf+0x440>
    8000707c:	00000097          	auipc	ra,0x0
    80007080:	9e8080e7          	jalr	-1560(ra) # 80006a64 <consputc>
    80007084:	000c8493          	mv	s1,s9
    80007088:	00094503          	lbu	a0,0(s2)
    8000708c:	c60510e3          	bnez	a0,80006cec <__printf+0xa4>
    80007090:	e40c0ee3          	beqz	s8,80006eec <__printf+0x2a4>
    80007094:	00009517          	auipc	a0,0x9
    80007098:	8bc50513          	addi	a0,a0,-1860 # 8000f950 <pr>
    8000709c:	00001097          	auipc	ra,0x1
    800070a0:	94c080e7          	jalr	-1716(ra) # 800079e8 <release>
    800070a4:	e49ff06f          	j	80006eec <__printf+0x2a4>
    800070a8:	f7843783          	ld	a5,-136(s0)
    800070ac:	03000513          	li	a0,48
    800070b0:	01000d13          	li	s10,16
    800070b4:	00878713          	addi	a4,a5,8
    800070b8:	0007bc83          	ld	s9,0(a5)
    800070bc:	f6e43c23          	sd	a4,-136(s0)
    800070c0:	00000097          	auipc	ra,0x0
    800070c4:	9a4080e7          	jalr	-1628(ra) # 80006a64 <consputc>
    800070c8:	07800513          	li	a0,120
    800070cc:	00000097          	auipc	ra,0x0
    800070d0:	998080e7          	jalr	-1640(ra) # 80006a64 <consputc>
    800070d4:	00002d97          	auipc	s11,0x2
    800070d8:	63cd8d93          	addi	s11,s11,1596 # 80009710 <digits>
    800070dc:	03ccd793          	srli	a5,s9,0x3c
    800070e0:	00fd87b3          	add	a5,s11,a5
    800070e4:	0007c503          	lbu	a0,0(a5)
    800070e8:	fffd0d1b          	addiw	s10,s10,-1
    800070ec:	004c9c93          	slli	s9,s9,0x4
    800070f0:	00000097          	auipc	ra,0x0
    800070f4:	974080e7          	jalr	-1676(ra) # 80006a64 <consputc>
    800070f8:	fe0d12e3          	bnez	s10,800070dc <__printf+0x494>
    800070fc:	f8dff06f          	j	80007088 <__printf+0x440>
    80007100:	f7843783          	ld	a5,-136(s0)
    80007104:	0007bc83          	ld	s9,0(a5)
    80007108:	00878793          	addi	a5,a5,8
    8000710c:	f6f43c23          	sd	a5,-136(s0)
    80007110:	000c9a63          	bnez	s9,80007124 <__printf+0x4dc>
    80007114:	1080006f          	j	8000721c <__printf+0x5d4>
    80007118:	001c8c93          	addi	s9,s9,1
    8000711c:	00000097          	auipc	ra,0x0
    80007120:	948080e7          	jalr	-1720(ra) # 80006a64 <consputc>
    80007124:	000cc503          	lbu	a0,0(s9)
    80007128:	fe0518e3          	bnez	a0,80007118 <__printf+0x4d0>
    8000712c:	f5dff06f          	j	80007088 <__printf+0x440>
    80007130:	02500513          	li	a0,37
    80007134:	00000097          	auipc	ra,0x0
    80007138:	930080e7          	jalr	-1744(ra) # 80006a64 <consputc>
    8000713c:	000c8513          	mv	a0,s9
    80007140:	00000097          	auipc	ra,0x0
    80007144:	924080e7          	jalr	-1756(ra) # 80006a64 <consputc>
    80007148:	f41ff06f          	j	80007088 <__printf+0x440>
    8000714c:	02500513          	li	a0,37
    80007150:	00000097          	auipc	ra,0x0
    80007154:	914080e7          	jalr	-1772(ra) # 80006a64 <consputc>
    80007158:	f31ff06f          	j	80007088 <__printf+0x440>
    8000715c:	00030513          	mv	a0,t1
    80007160:	00000097          	auipc	ra,0x0
    80007164:	7bc080e7          	jalr	1980(ra) # 8000791c <acquire>
    80007168:	b4dff06f          	j	80006cb4 <__printf+0x6c>
    8000716c:	40c0053b          	negw	a0,a2
    80007170:	00a00713          	li	a4,10
    80007174:	02e576bb          	remuw	a3,a0,a4
    80007178:	00002d97          	auipc	s11,0x2
    8000717c:	598d8d93          	addi	s11,s11,1432 # 80009710 <digits>
    80007180:	ff700593          	li	a1,-9
    80007184:	02069693          	slli	a3,a3,0x20
    80007188:	0206d693          	srli	a3,a3,0x20
    8000718c:	00dd86b3          	add	a3,s11,a3
    80007190:	0006c683          	lbu	a3,0(a3)
    80007194:	02e557bb          	divuw	a5,a0,a4
    80007198:	f8d40023          	sb	a3,-128(s0)
    8000719c:	10b65e63          	bge	a2,a1,800072b8 <__printf+0x670>
    800071a0:	06300593          	li	a1,99
    800071a4:	02e7f6bb          	remuw	a3,a5,a4
    800071a8:	02069693          	slli	a3,a3,0x20
    800071ac:	0206d693          	srli	a3,a3,0x20
    800071b0:	00dd86b3          	add	a3,s11,a3
    800071b4:	0006c683          	lbu	a3,0(a3)
    800071b8:	02e7d73b          	divuw	a4,a5,a4
    800071bc:	00200793          	li	a5,2
    800071c0:	f8d400a3          	sb	a3,-127(s0)
    800071c4:	bca5ece3          	bltu	a1,a0,80006d9c <__printf+0x154>
    800071c8:	ce5ff06f          	j	80006eac <__printf+0x264>
    800071cc:	40e007bb          	negw	a5,a4
    800071d0:	00002d97          	auipc	s11,0x2
    800071d4:	540d8d93          	addi	s11,s11,1344 # 80009710 <digits>
    800071d8:	00f7f693          	andi	a3,a5,15
    800071dc:	00dd86b3          	add	a3,s11,a3
    800071e0:	0006c583          	lbu	a1,0(a3)
    800071e4:	ff100613          	li	a2,-15
    800071e8:	0047d69b          	srliw	a3,a5,0x4
    800071ec:	f8b40023          	sb	a1,-128(s0)
    800071f0:	0047d59b          	srliw	a1,a5,0x4
    800071f4:	0ac75e63          	bge	a4,a2,800072b0 <__printf+0x668>
    800071f8:	00f6f693          	andi	a3,a3,15
    800071fc:	00dd86b3          	add	a3,s11,a3
    80007200:	0006c603          	lbu	a2,0(a3)
    80007204:	00f00693          	li	a3,15
    80007208:	0087d79b          	srliw	a5,a5,0x8
    8000720c:	f8c400a3          	sb	a2,-127(s0)
    80007210:	d8b6e4e3          	bltu	a3,a1,80006f98 <__printf+0x350>
    80007214:	00200793          	li	a5,2
    80007218:	e2dff06f          	j	80007044 <__printf+0x3fc>
    8000721c:	00002c97          	auipc	s9,0x2
    80007220:	4d4c8c93          	addi	s9,s9,1236 # 800096f0 <CONSOLE_STATUS+0x6e0>
    80007224:	02800513          	li	a0,40
    80007228:	ef1ff06f          	j	80007118 <__printf+0x4d0>
    8000722c:	00700793          	li	a5,7
    80007230:	00600c93          	li	s9,6
    80007234:	e0dff06f          	j	80007040 <__printf+0x3f8>
    80007238:	00700793          	li	a5,7
    8000723c:	00600c93          	li	s9,6
    80007240:	c69ff06f          	j	80006ea8 <__printf+0x260>
    80007244:	00300793          	li	a5,3
    80007248:	00200c93          	li	s9,2
    8000724c:	c5dff06f          	j	80006ea8 <__printf+0x260>
    80007250:	00300793          	li	a5,3
    80007254:	00200c93          	li	s9,2
    80007258:	de9ff06f          	j	80007040 <__printf+0x3f8>
    8000725c:	00400793          	li	a5,4
    80007260:	00300c93          	li	s9,3
    80007264:	dddff06f          	j	80007040 <__printf+0x3f8>
    80007268:	00400793          	li	a5,4
    8000726c:	00300c93          	li	s9,3
    80007270:	c39ff06f          	j	80006ea8 <__printf+0x260>
    80007274:	00500793          	li	a5,5
    80007278:	00400c93          	li	s9,4
    8000727c:	c2dff06f          	j	80006ea8 <__printf+0x260>
    80007280:	00500793          	li	a5,5
    80007284:	00400c93          	li	s9,4
    80007288:	db9ff06f          	j	80007040 <__printf+0x3f8>
    8000728c:	00600793          	li	a5,6
    80007290:	00500c93          	li	s9,5
    80007294:	dadff06f          	j	80007040 <__printf+0x3f8>
    80007298:	00600793          	li	a5,6
    8000729c:	00500c93          	li	s9,5
    800072a0:	c09ff06f          	j	80006ea8 <__printf+0x260>
    800072a4:	00800793          	li	a5,8
    800072a8:	00700c93          	li	s9,7
    800072ac:	bfdff06f          	j	80006ea8 <__printf+0x260>
    800072b0:	00100793          	li	a5,1
    800072b4:	d91ff06f          	j	80007044 <__printf+0x3fc>
    800072b8:	00100793          	li	a5,1
    800072bc:	bf1ff06f          	j	80006eac <__printf+0x264>
    800072c0:	00900793          	li	a5,9
    800072c4:	00800c93          	li	s9,8
    800072c8:	be1ff06f          	j	80006ea8 <__printf+0x260>
    800072cc:	00002517          	auipc	a0,0x2
    800072d0:	42c50513          	addi	a0,a0,1068 # 800096f8 <CONSOLE_STATUS+0x6e8>
    800072d4:	00000097          	auipc	ra,0x0
    800072d8:	918080e7          	jalr	-1768(ra) # 80006bec <panic>

00000000800072dc <printfinit>:
    800072dc:	fe010113          	addi	sp,sp,-32
    800072e0:	00813823          	sd	s0,16(sp)
    800072e4:	00913423          	sd	s1,8(sp)
    800072e8:	00113c23          	sd	ra,24(sp)
    800072ec:	02010413          	addi	s0,sp,32
    800072f0:	00008497          	auipc	s1,0x8
    800072f4:	66048493          	addi	s1,s1,1632 # 8000f950 <pr>
    800072f8:	00048513          	mv	a0,s1
    800072fc:	00002597          	auipc	a1,0x2
    80007300:	40c58593          	addi	a1,a1,1036 # 80009708 <CONSOLE_STATUS+0x6f8>
    80007304:	00000097          	auipc	ra,0x0
    80007308:	5f4080e7          	jalr	1524(ra) # 800078f8 <initlock>
    8000730c:	01813083          	ld	ra,24(sp)
    80007310:	01013403          	ld	s0,16(sp)
    80007314:	0004ac23          	sw	zero,24(s1)
    80007318:	00813483          	ld	s1,8(sp)
    8000731c:	02010113          	addi	sp,sp,32
    80007320:	00008067          	ret

0000000080007324 <uartinit>:
    80007324:	ff010113          	addi	sp,sp,-16
    80007328:	00813423          	sd	s0,8(sp)
    8000732c:	01010413          	addi	s0,sp,16
    80007330:	100007b7          	lui	a5,0x10000
    80007334:	000780a3          	sb	zero,1(a5) # 10000001 <_entry-0x6fffffff>
    80007338:	f8000713          	li	a4,-128
    8000733c:	00e781a3          	sb	a4,3(a5)
    80007340:	00300713          	li	a4,3
    80007344:	00e78023          	sb	a4,0(a5)
    80007348:	000780a3          	sb	zero,1(a5)
    8000734c:	00e781a3          	sb	a4,3(a5)
    80007350:	00700693          	li	a3,7
    80007354:	00d78123          	sb	a3,2(a5)
    80007358:	00e780a3          	sb	a4,1(a5)
    8000735c:	00813403          	ld	s0,8(sp)
    80007360:	01010113          	addi	sp,sp,16
    80007364:	00008067          	ret

0000000080007368 <uartputc>:
    80007368:	00004797          	auipc	a5,0x4
    8000736c:	f007a783          	lw	a5,-256(a5) # 8000b268 <panicked>
    80007370:	00078463          	beqz	a5,80007378 <uartputc+0x10>
    80007374:	0000006f          	j	80007374 <uartputc+0xc>
    80007378:	fd010113          	addi	sp,sp,-48
    8000737c:	02813023          	sd	s0,32(sp)
    80007380:	00913c23          	sd	s1,24(sp)
    80007384:	01213823          	sd	s2,16(sp)
    80007388:	01313423          	sd	s3,8(sp)
    8000738c:	02113423          	sd	ra,40(sp)
    80007390:	03010413          	addi	s0,sp,48
    80007394:	00004917          	auipc	s2,0x4
    80007398:	edc90913          	addi	s2,s2,-292 # 8000b270 <uart_tx_r>
    8000739c:	00093783          	ld	a5,0(s2)
    800073a0:	00004497          	auipc	s1,0x4
    800073a4:	ed848493          	addi	s1,s1,-296 # 8000b278 <uart_tx_w>
    800073a8:	0004b703          	ld	a4,0(s1)
    800073ac:	02078693          	addi	a3,a5,32
    800073b0:	00050993          	mv	s3,a0
    800073b4:	02e69c63          	bne	a3,a4,800073ec <uartputc+0x84>
    800073b8:	00001097          	auipc	ra,0x1
    800073bc:	834080e7          	jalr	-1996(ra) # 80007bec <push_on>
    800073c0:	00093783          	ld	a5,0(s2)
    800073c4:	0004b703          	ld	a4,0(s1)
    800073c8:	02078793          	addi	a5,a5,32
    800073cc:	00e79463          	bne	a5,a4,800073d4 <uartputc+0x6c>
    800073d0:	0000006f          	j	800073d0 <uartputc+0x68>
    800073d4:	00001097          	auipc	ra,0x1
    800073d8:	88c080e7          	jalr	-1908(ra) # 80007c60 <pop_on>
    800073dc:	00093783          	ld	a5,0(s2)
    800073e0:	0004b703          	ld	a4,0(s1)
    800073e4:	02078693          	addi	a3,a5,32
    800073e8:	fce688e3          	beq	a3,a4,800073b8 <uartputc+0x50>
    800073ec:	01f77693          	andi	a3,a4,31
    800073f0:	00008597          	auipc	a1,0x8
    800073f4:	58058593          	addi	a1,a1,1408 # 8000f970 <uart_tx_buf>
    800073f8:	00d586b3          	add	a3,a1,a3
    800073fc:	00170713          	addi	a4,a4,1
    80007400:	01368023          	sb	s3,0(a3)
    80007404:	00e4b023          	sd	a4,0(s1)
    80007408:	10000637          	lui	a2,0x10000
    8000740c:	02f71063          	bne	a4,a5,8000742c <uartputc+0xc4>
    80007410:	0340006f          	j	80007444 <uartputc+0xdc>
    80007414:	00074703          	lbu	a4,0(a4)
    80007418:	00f93023          	sd	a5,0(s2)
    8000741c:	00e60023          	sb	a4,0(a2) # 10000000 <_entry-0x70000000>
    80007420:	00093783          	ld	a5,0(s2)
    80007424:	0004b703          	ld	a4,0(s1)
    80007428:	00f70e63          	beq	a4,a5,80007444 <uartputc+0xdc>
    8000742c:	00564683          	lbu	a3,5(a2)
    80007430:	01f7f713          	andi	a4,a5,31
    80007434:	00e58733          	add	a4,a1,a4
    80007438:	0206f693          	andi	a3,a3,32
    8000743c:	00178793          	addi	a5,a5,1
    80007440:	fc069ae3          	bnez	a3,80007414 <uartputc+0xac>
    80007444:	02813083          	ld	ra,40(sp)
    80007448:	02013403          	ld	s0,32(sp)
    8000744c:	01813483          	ld	s1,24(sp)
    80007450:	01013903          	ld	s2,16(sp)
    80007454:	00813983          	ld	s3,8(sp)
    80007458:	03010113          	addi	sp,sp,48
    8000745c:	00008067          	ret

0000000080007460 <uartputc_sync>:
    80007460:	ff010113          	addi	sp,sp,-16
    80007464:	00813423          	sd	s0,8(sp)
    80007468:	01010413          	addi	s0,sp,16
    8000746c:	00004717          	auipc	a4,0x4
    80007470:	dfc72703          	lw	a4,-516(a4) # 8000b268 <panicked>
    80007474:	02071663          	bnez	a4,800074a0 <uartputc_sync+0x40>
    80007478:	00050793          	mv	a5,a0
    8000747c:	100006b7          	lui	a3,0x10000
    80007480:	0056c703          	lbu	a4,5(a3) # 10000005 <_entry-0x6ffffffb>
    80007484:	02077713          	andi	a4,a4,32
    80007488:	fe070ce3          	beqz	a4,80007480 <uartputc_sync+0x20>
    8000748c:	0ff7f793          	andi	a5,a5,255
    80007490:	00f68023          	sb	a5,0(a3)
    80007494:	00813403          	ld	s0,8(sp)
    80007498:	01010113          	addi	sp,sp,16
    8000749c:	00008067          	ret
    800074a0:	0000006f          	j	800074a0 <uartputc_sync+0x40>

00000000800074a4 <uartstart>:
    800074a4:	ff010113          	addi	sp,sp,-16
    800074a8:	00813423          	sd	s0,8(sp)
    800074ac:	01010413          	addi	s0,sp,16
    800074b0:	00004617          	auipc	a2,0x4
    800074b4:	dc060613          	addi	a2,a2,-576 # 8000b270 <uart_tx_r>
    800074b8:	00004517          	auipc	a0,0x4
    800074bc:	dc050513          	addi	a0,a0,-576 # 8000b278 <uart_tx_w>
    800074c0:	00063783          	ld	a5,0(a2)
    800074c4:	00053703          	ld	a4,0(a0)
    800074c8:	04f70263          	beq	a4,a5,8000750c <uartstart+0x68>
    800074cc:	100005b7          	lui	a1,0x10000
    800074d0:	00008817          	auipc	a6,0x8
    800074d4:	4a080813          	addi	a6,a6,1184 # 8000f970 <uart_tx_buf>
    800074d8:	01c0006f          	j	800074f4 <uartstart+0x50>
    800074dc:	0006c703          	lbu	a4,0(a3)
    800074e0:	00f63023          	sd	a5,0(a2)
    800074e4:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    800074e8:	00063783          	ld	a5,0(a2)
    800074ec:	00053703          	ld	a4,0(a0)
    800074f0:	00f70e63          	beq	a4,a5,8000750c <uartstart+0x68>
    800074f4:	01f7f713          	andi	a4,a5,31
    800074f8:	00e806b3          	add	a3,a6,a4
    800074fc:	0055c703          	lbu	a4,5(a1)
    80007500:	00178793          	addi	a5,a5,1
    80007504:	02077713          	andi	a4,a4,32
    80007508:	fc071ae3          	bnez	a4,800074dc <uartstart+0x38>
    8000750c:	00813403          	ld	s0,8(sp)
    80007510:	01010113          	addi	sp,sp,16
    80007514:	00008067          	ret

0000000080007518 <uartgetc>:
    80007518:	ff010113          	addi	sp,sp,-16
    8000751c:	00813423          	sd	s0,8(sp)
    80007520:	01010413          	addi	s0,sp,16
    80007524:	10000737          	lui	a4,0x10000
    80007528:	00574783          	lbu	a5,5(a4) # 10000005 <_entry-0x6ffffffb>
    8000752c:	0017f793          	andi	a5,a5,1
    80007530:	00078c63          	beqz	a5,80007548 <uartgetc+0x30>
    80007534:	00074503          	lbu	a0,0(a4)
    80007538:	0ff57513          	andi	a0,a0,255
    8000753c:	00813403          	ld	s0,8(sp)
    80007540:	01010113          	addi	sp,sp,16
    80007544:	00008067          	ret
    80007548:	fff00513          	li	a0,-1
    8000754c:	ff1ff06f          	j	8000753c <uartgetc+0x24>

0000000080007550 <uartintr>:
    80007550:	100007b7          	lui	a5,0x10000
    80007554:	0057c783          	lbu	a5,5(a5) # 10000005 <_entry-0x6ffffffb>
    80007558:	0017f793          	andi	a5,a5,1
    8000755c:	0a078463          	beqz	a5,80007604 <uartintr+0xb4>
    80007560:	fe010113          	addi	sp,sp,-32
    80007564:	00813823          	sd	s0,16(sp)
    80007568:	00913423          	sd	s1,8(sp)
    8000756c:	00113c23          	sd	ra,24(sp)
    80007570:	02010413          	addi	s0,sp,32
    80007574:	100004b7          	lui	s1,0x10000
    80007578:	0004c503          	lbu	a0,0(s1) # 10000000 <_entry-0x70000000>
    8000757c:	0ff57513          	andi	a0,a0,255
    80007580:	fffff097          	auipc	ra,0xfffff
    80007584:	534080e7          	jalr	1332(ra) # 80006ab4 <consoleintr>
    80007588:	0054c783          	lbu	a5,5(s1)
    8000758c:	0017f793          	andi	a5,a5,1
    80007590:	fe0794e3          	bnez	a5,80007578 <uartintr+0x28>
    80007594:	00004617          	auipc	a2,0x4
    80007598:	cdc60613          	addi	a2,a2,-804 # 8000b270 <uart_tx_r>
    8000759c:	00004517          	auipc	a0,0x4
    800075a0:	cdc50513          	addi	a0,a0,-804 # 8000b278 <uart_tx_w>
    800075a4:	00063783          	ld	a5,0(a2)
    800075a8:	00053703          	ld	a4,0(a0)
    800075ac:	04f70263          	beq	a4,a5,800075f0 <uartintr+0xa0>
    800075b0:	100005b7          	lui	a1,0x10000
    800075b4:	00008817          	auipc	a6,0x8
    800075b8:	3bc80813          	addi	a6,a6,956 # 8000f970 <uart_tx_buf>
    800075bc:	01c0006f          	j	800075d8 <uartintr+0x88>
    800075c0:	0006c703          	lbu	a4,0(a3)
    800075c4:	00f63023          	sd	a5,0(a2)
    800075c8:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    800075cc:	00063783          	ld	a5,0(a2)
    800075d0:	00053703          	ld	a4,0(a0)
    800075d4:	00f70e63          	beq	a4,a5,800075f0 <uartintr+0xa0>
    800075d8:	01f7f713          	andi	a4,a5,31
    800075dc:	00e806b3          	add	a3,a6,a4
    800075e0:	0055c703          	lbu	a4,5(a1)
    800075e4:	00178793          	addi	a5,a5,1
    800075e8:	02077713          	andi	a4,a4,32
    800075ec:	fc071ae3          	bnez	a4,800075c0 <uartintr+0x70>
    800075f0:	01813083          	ld	ra,24(sp)
    800075f4:	01013403          	ld	s0,16(sp)
    800075f8:	00813483          	ld	s1,8(sp)
    800075fc:	02010113          	addi	sp,sp,32
    80007600:	00008067          	ret
    80007604:	00004617          	auipc	a2,0x4
    80007608:	c6c60613          	addi	a2,a2,-916 # 8000b270 <uart_tx_r>
    8000760c:	00004517          	auipc	a0,0x4
    80007610:	c6c50513          	addi	a0,a0,-916 # 8000b278 <uart_tx_w>
    80007614:	00063783          	ld	a5,0(a2)
    80007618:	00053703          	ld	a4,0(a0)
    8000761c:	04f70263          	beq	a4,a5,80007660 <uartintr+0x110>
    80007620:	100005b7          	lui	a1,0x10000
    80007624:	00008817          	auipc	a6,0x8
    80007628:	34c80813          	addi	a6,a6,844 # 8000f970 <uart_tx_buf>
    8000762c:	01c0006f          	j	80007648 <uartintr+0xf8>
    80007630:	0006c703          	lbu	a4,0(a3)
    80007634:	00f63023          	sd	a5,0(a2)
    80007638:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    8000763c:	00063783          	ld	a5,0(a2)
    80007640:	00053703          	ld	a4,0(a0)
    80007644:	02f70063          	beq	a4,a5,80007664 <uartintr+0x114>
    80007648:	01f7f713          	andi	a4,a5,31
    8000764c:	00e806b3          	add	a3,a6,a4
    80007650:	0055c703          	lbu	a4,5(a1)
    80007654:	00178793          	addi	a5,a5,1
    80007658:	02077713          	andi	a4,a4,32
    8000765c:	fc071ae3          	bnez	a4,80007630 <uartintr+0xe0>
    80007660:	00008067          	ret
    80007664:	00008067          	ret

0000000080007668 <kinit>:
    80007668:	fc010113          	addi	sp,sp,-64
    8000766c:	02913423          	sd	s1,40(sp)
    80007670:	fffff7b7          	lui	a5,0xfffff
    80007674:	00009497          	auipc	s1,0x9
    80007678:	31b48493          	addi	s1,s1,795 # 8001098f <end+0xfff>
    8000767c:	02813823          	sd	s0,48(sp)
    80007680:	01313c23          	sd	s3,24(sp)
    80007684:	00f4f4b3          	and	s1,s1,a5
    80007688:	02113c23          	sd	ra,56(sp)
    8000768c:	03213023          	sd	s2,32(sp)
    80007690:	01413823          	sd	s4,16(sp)
    80007694:	01513423          	sd	s5,8(sp)
    80007698:	04010413          	addi	s0,sp,64
    8000769c:	000017b7          	lui	a5,0x1
    800076a0:	01100993          	li	s3,17
    800076a4:	00f487b3          	add	a5,s1,a5
    800076a8:	01b99993          	slli	s3,s3,0x1b
    800076ac:	06f9e063          	bltu	s3,a5,8000770c <kinit+0xa4>
    800076b0:	00008a97          	auipc	s5,0x8
    800076b4:	2e0a8a93          	addi	s5,s5,736 # 8000f990 <end>
    800076b8:	0754ec63          	bltu	s1,s5,80007730 <kinit+0xc8>
    800076bc:	0734fa63          	bgeu	s1,s3,80007730 <kinit+0xc8>
    800076c0:	00088a37          	lui	s4,0x88
    800076c4:	fffa0a13          	addi	s4,s4,-1 # 87fff <_entry-0x7ff78001>
    800076c8:	00004917          	auipc	s2,0x4
    800076cc:	bb890913          	addi	s2,s2,-1096 # 8000b280 <kmem>
    800076d0:	00ca1a13          	slli	s4,s4,0xc
    800076d4:	0140006f          	j	800076e8 <kinit+0x80>
    800076d8:	000017b7          	lui	a5,0x1
    800076dc:	00f484b3          	add	s1,s1,a5
    800076e0:	0554e863          	bltu	s1,s5,80007730 <kinit+0xc8>
    800076e4:	0534f663          	bgeu	s1,s3,80007730 <kinit+0xc8>
    800076e8:	00001637          	lui	a2,0x1
    800076ec:	00100593          	li	a1,1
    800076f0:	00048513          	mv	a0,s1
    800076f4:	00000097          	auipc	ra,0x0
    800076f8:	5e4080e7          	jalr	1508(ra) # 80007cd8 <__memset>
    800076fc:	00093783          	ld	a5,0(s2)
    80007700:	00f4b023          	sd	a5,0(s1)
    80007704:	00993023          	sd	s1,0(s2)
    80007708:	fd4498e3          	bne	s1,s4,800076d8 <kinit+0x70>
    8000770c:	03813083          	ld	ra,56(sp)
    80007710:	03013403          	ld	s0,48(sp)
    80007714:	02813483          	ld	s1,40(sp)
    80007718:	02013903          	ld	s2,32(sp)
    8000771c:	01813983          	ld	s3,24(sp)
    80007720:	01013a03          	ld	s4,16(sp)
    80007724:	00813a83          	ld	s5,8(sp)
    80007728:	04010113          	addi	sp,sp,64
    8000772c:	00008067          	ret
    80007730:	00002517          	auipc	a0,0x2
    80007734:	ff850513          	addi	a0,a0,-8 # 80009728 <digits+0x18>
    80007738:	fffff097          	auipc	ra,0xfffff
    8000773c:	4b4080e7          	jalr	1204(ra) # 80006bec <panic>

0000000080007740 <freerange>:
    80007740:	fc010113          	addi	sp,sp,-64
    80007744:	000017b7          	lui	a5,0x1
    80007748:	02913423          	sd	s1,40(sp)
    8000774c:	fff78493          	addi	s1,a5,-1 # fff <_entry-0x7ffff001>
    80007750:	009504b3          	add	s1,a0,s1
    80007754:	fffff537          	lui	a0,0xfffff
    80007758:	02813823          	sd	s0,48(sp)
    8000775c:	02113c23          	sd	ra,56(sp)
    80007760:	03213023          	sd	s2,32(sp)
    80007764:	01313c23          	sd	s3,24(sp)
    80007768:	01413823          	sd	s4,16(sp)
    8000776c:	01513423          	sd	s5,8(sp)
    80007770:	01613023          	sd	s6,0(sp)
    80007774:	04010413          	addi	s0,sp,64
    80007778:	00a4f4b3          	and	s1,s1,a0
    8000777c:	00f487b3          	add	a5,s1,a5
    80007780:	06f5e463          	bltu	a1,a5,800077e8 <freerange+0xa8>
    80007784:	00008a97          	auipc	s5,0x8
    80007788:	20ca8a93          	addi	s5,s5,524 # 8000f990 <end>
    8000778c:	0954e263          	bltu	s1,s5,80007810 <freerange+0xd0>
    80007790:	01100993          	li	s3,17
    80007794:	01b99993          	slli	s3,s3,0x1b
    80007798:	0734fc63          	bgeu	s1,s3,80007810 <freerange+0xd0>
    8000779c:	00058a13          	mv	s4,a1
    800077a0:	00004917          	auipc	s2,0x4
    800077a4:	ae090913          	addi	s2,s2,-1312 # 8000b280 <kmem>
    800077a8:	00002b37          	lui	s6,0x2
    800077ac:	0140006f          	j	800077c0 <freerange+0x80>
    800077b0:	000017b7          	lui	a5,0x1
    800077b4:	00f484b3          	add	s1,s1,a5
    800077b8:	0554ec63          	bltu	s1,s5,80007810 <freerange+0xd0>
    800077bc:	0534fa63          	bgeu	s1,s3,80007810 <freerange+0xd0>
    800077c0:	00001637          	lui	a2,0x1
    800077c4:	00100593          	li	a1,1
    800077c8:	00048513          	mv	a0,s1
    800077cc:	00000097          	auipc	ra,0x0
    800077d0:	50c080e7          	jalr	1292(ra) # 80007cd8 <__memset>
    800077d4:	00093703          	ld	a4,0(s2)
    800077d8:	016487b3          	add	a5,s1,s6
    800077dc:	00e4b023          	sd	a4,0(s1)
    800077e0:	00993023          	sd	s1,0(s2)
    800077e4:	fcfa76e3          	bgeu	s4,a5,800077b0 <freerange+0x70>
    800077e8:	03813083          	ld	ra,56(sp)
    800077ec:	03013403          	ld	s0,48(sp)
    800077f0:	02813483          	ld	s1,40(sp)
    800077f4:	02013903          	ld	s2,32(sp)
    800077f8:	01813983          	ld	s3,24(sp)
    800077fc:	01013a03          	ld	s4,16(sp)
    80007800:	00813a83          	ld	s5,8(sp)
    80007804:	00013b03          	ld	s6,0(sp)
    80007808:	04010113          	addi	sp,sp,64
    8000780c:	00008067          	ret
    80007810:	00002517          	auipc	a0,0x2
    80007814:	f1850513          	addi	a0,a0,-232 # 80009728 <digits+0x18>
    80007818:	fffff097          	auipc	ra,0xfffff
    8000781c:	3d4080e7          	jalr	980(ra) # 80006bec <panic>

0000000080007820 <kfree>:
    80007820:	fe010113          	addi	sp,sp,-32
    80007824:	00813823          	sd	s0,16(sp)
    80007828:	00113c23          	sd	ra,24(sp)
    8000782c:	00913423          	sd	s1,8(sp)
    80007830:	02010413          	addi	s0,sp,32
    80007834:	03451793          	slli	a5,a0,0x34
    80007838:	04079c63          	bnez	a5,80007890 <kfree+0x70>
    8000783c:	00008797          	auipc	a5,0x8
    80007840:	15478793          	addi	a5,a5,340 # 8000f990 <end>
    80007844:	00050493          	mv	s1,a0
    80007848:	04f56463          	bltu	a0,a5,80007890 <kfree+0x70>
    8000784c:	01100793          	li	a5,17
    80007850:	01b79793          	slli	a5,a5,0x1b
    80007854:	02f57e63          	bgeu	a0,a5,80007890 <kfree+0x70>
    80007858:	00001637          	lui	a2,0x1
    8000785c:	00100593          	li	a1,1
    80007860:	00000097          	auipc	ra,0x0
    80007864:	478080e7          	jalr	1144(ra) # 80007cd8 <__memset>
    80007868:	00004797          	auipc	a5,0x4
    8000786c:	a1878793          	addi	a5,a5,-1512 # 8000b280 <kmem>
    80007870:	0007b703          	ld	a4,0(a5)
    80007874:	01813083          	ld	ra,24(sp)
    80007878:	01013403          	ld	s0,16(sp)
    8000787c:	00e4b023          	sd	a4,0(s1)
    80007880:	0097b023          	sd	s1,0(a5)
    80007884:	00813483          	ld	s1,8(sp)
    80007888:	02010113          	addi	sp,sp,32
    8000788c:	00008067          	ret
    80007890:	00002517          	auipc	a0,0x2
    80007894:	e9850513          	addi	a0,a0,-360 # 80009728 <digits+0x18>
    80007898:	fffff097          	auipc	ra,0xfffff
    8000789c:	354080e7          	jalr	852(ra) # 80006bec <panic>

00000000800078a0 <kalloc>:
    800078a0:	fe010113          	addi	sp,sp,-32
    800078a4:	00813823          	sd	s0,16(sp)
    800078a8:	00913423          	sd	s1,8(sp)
    800078ac:	00113c23          	sd	ra,24(sp)
    800078b0:	02010413          	addi	s0,sp,32
    800078b4:	00004797          	auipc	a5,0x4
    800078b8:	9cc78793          	addi	a5,a5,-1588 # 8000b280 <kmem>
    800078bc:	0007b483          	ld	s1,0(a5)
    800078c0:	02048063          	beqz	s1,800078e0 <kalloc+0x40>
    800078c4:	0004b703          	ld	a4,0(s1)
    800078c8:	00001637          	lui	a2,0x1
    800078cc:	00500593          	li	a1,5
    800078d0:	00048513          	mv	a0,s1
    800078d4:	00e7b023          	sd	a4,0(a5)
    800078d8:	00000097          	auipc	ra,0x0
    800078dc:	400080e7          	jalr	1024(ra) # 80007cd8 <__memset>
    800078e0:	01813083          	ld	ra,24(sp)
    800078e4:	01013403          	ld	s0,16(sp)
    800078e8:	00048513          	mv	a0,s1
    800078ec:	00813483          	ld	s1,8(sp)
    800078f0:	02010113          	addi	sp,sp,32
    800078f4:	00008067          	ret

00000000800078f8 <initlock>:
    800078f8:	ff010113          	addi	sp,sp,-16
    800078fc:	00813423          	sd	s0,8(sp)
    80007900:	01010413          	addi	s0,sp,16
    80007904:	00813403          	ld	s0,8(sp)
    80007908:	00b53423          	sd	a1,8(a0)
    8000790c:	00052023          	sw	zero,0(a0)
    80007910:	00053823          	sd	zero,16(a0)
    80007914:	01010113          	addi	sp,sp,16
    80007918:	00008067          	ret

000000008000791c <acquire>:
    8000791c:	fe010113          	addi	sp,sp,-32
    80007920:	00813823          	sd	s0,16(sp)
    80007924:	00913423          	sd	s1,8(sp)
    80007928:	00113c23          	sd	ra,24(sp)
    8000792c:	01213023          	sd	s2,0(sp)
    80007930:	02010413          	addi	s0,sp,32
    80007934:	00050493          	mv	s1,a0
    80007938:	10002973          	csrr	s2,sstatus
    8000793c:	100027f3          	csrr	a5,sstatus
    80007940:	ffd7f793          	andi	a5,a5,-3
    80007944:	10079073          	csrw	sstatus,a5
    80007948:	fffff097          	auipc	ra,0xfffff
    8000794c:	8e0080e7          	jalr	-1824(ra) # 80006228 <mycpu>
    80007950:	07852783          	lw	a5,120(a0)
    80007954:	06078e63          	beqz	a5,800079d0 <acquire+0xb4>
    80007958:	fffff097          	auipc	ra,0xfffff
    8000795c:	8d0080e7          	jalr	-1840(ra) # 80006228 <mycpu>
    80007960:	07852783          	lw	a5,120(a0)
    80007964:	0004a703          	lw	a4,0(s1)
    80007968:	0017879b          	addiw	a5,a5,1
    8000796c:	06f52c23          	sw	a5,120(a0)
    80007970:	04071063          	bnez	a4,800079b0 <acquire+0x94>
    80007974:	00100713          	li	a4,1
    80007978:	00070793          	mv	a5,a4
    8000797c:	0cf4a7af          	amoswap.w.aq	a5,a5,(s1)
    80007980:	0007879b          	sext.w	a5,a5
    80007984:	fe079ae3          	bnez	a5,80007978 <acquire+0x5c>
    80007988:	0ff0000f          	fence
    8000798c:	fffff097          	auipc	ra,0xfffff
    80007990:	89c080e7          	jalr	-1892(ra) # 80006228 <mycpu>
    80007994:	01813083          	ld	ra,24(sp)
    80007998:	01013403          	ld	s0,16(sp)
    8000799c:	00a4b823          	sd	a0,16(s1)
    800079a0:	00013903          	ld	s2,0(sp)
    800079a4:	00813483          	ld	s1,8(sp)
    800079a8:	02010113          	addi	sp,sp,32
    800079ac:	00008067          	ret
    800079b0:	0104b903          	ld	s2,16(s1)
    800079b4:	fffff097          	auipc	ra,0xfffff
    800079b8:	874080e7          	jalr	-1932(ra) # 80006228 <mycpu>
    800079bc:	faa91ce3          	bne	s2,a0,80007974 <acquire+0x58>
    800079c0:	00002517          	auipc	a0,0x2
    800079c4:	d7050513          	addi	a0,a0,-656 # 80009730 <digits+0x20>
    800079c8:	fffff097          	auipc	ra,0xfffff
    800079cc:	224080e7          	jalr	548(ra) # 80006bec <panic>
    800079d0:	00195913          	srli	s2,s2,0x1
    800079d4:	fffff097          	auipc	ra,0xfffff
    800079d8:	854080e7          	jalr	-1964(ra) # 80006228 <mycpu>
    800079dc:	00197913          	andi	s2,s2,1
    800079e0:	07252e23          	sw	s2,124(a0)
    800079e4:	f75ff06f          	j	80007958 <acquire+0x3c>

00000000800079e8 <release>:
    800079e8:	fe010113          	addi	sp,sp,-32
    800079ec:	00813823          	sd	s0,16(sp)
    800079f0:	00113c23          	sd	ra,24(sp)
    800079f4:	00913423          	sd	s1,8(sp)
    800079f8:	01213023          	sd	s2,0(sp)
    800079fc:	02010413          	addi	s0,sp,32
    80007a00:	00052783          	lw	a5,0(a0)
    80007a04:	00079a63          	bnez	a5,80007a18 <release+0x30>
    80007a08:	00002517          	auipc	a0,0x2
    80007a0c:	d3050513          	addi	a0,a0,-720 # 80009738 <digits+0x28>
    80007a10:	fffff097          	auipc	ra,0xfffff
    80007a14:	1dc080e7          	jalr	476(ra) # 80006bec <panic>
    80007a18:	01053903          	ld	s2,16(a0)
    80007a1c:	00050493          	mv	s1,a0
    80007a20:	fffff097          	auipc	ra,0xfffff
    80007a24:	808080e7          	jalr	-2040(ra) # 80006228 <mycpu>
    80007a28:	fea910e3          	bne	s2,a0,80007a08 <release+0x20>
    80007a2c:	0004b823          	sd	zero,16(s1)
    80007a30:	0ff0000f          	fence
    80007a34:	0f50000f          	fence	iorw,ow
    80007a38:	0804a02f          	amoswap.w	zero,zero,(s1)
    80007a3c:	ffffe097          	auipc	ra,0xffffe
    80007a40:	7ec080e7          	jalr	2028(ra) # 80006228 <mycpu>
    80007a44:	100027f3          	csrr	a5,sstatus
    80007a48:	0027f793          	andi	a5,a5,2
    80007a4c:	04079a63          	bnez	a5,80007aa0 <release+0xb8>
    80007a50:	07852783          	lw	a5,120(a0)
    80007a54:	02f05e63          	blez	a5,80007a90 <release+0xa8>
    80007a58:	fff7871b          	addiw	a4,a5,-1
    80007a5c:	06e52c23          	sw	a4,120(a0)
    80007a60:	00071c63          	bnez	a4,80007a78 <release+0x90>
    80007a64:	07c52783          	lw	a5,124(a0)
    80007a68:	00078863          	beqz	a5,80007a78 <release+0x90>
    80007a6c:	100027f3          	csrr	a5,sstatus
    80007a70:	0027e793          	ori	a5,a5,2
    80007a74:	10079073          	csrw	sstatus,a5
    80007a78:	01813083          	ld	ra,24(sp)
    80007a7c:	01013403          	ld	s0,16(sp)
    80007a80:	00813483          	ld	s1,8(sp)
    80007a84:	00013903          	ld	s2,0(sp)
    80007a88:	02010113          	addi	sp,sp,32
    80007a8c:	00008067          	ret
    80007a90:	00002517          	auipc	a0,0x2
    80007a94:	cc850513          	addi	a0,a0,-824 # 80009758 <digits+0x48>
    80007a98:	fffff097          	auipc	ra,0xfffff
    80007a9c:	154080e7          	jalr	340(ra) # 80006bec <panic>
    80007aa0:	00002517          	auipc	a0,0x2
    80007aa4:	ca050513          	addi	a0,a0,-864 # 80009740 <digits+0x30>
    80007aa8:	fffff097          	auipc	ra,0xfffff
    80007aac:	144080e7          	jalr	324(ra) # 80006bec <panic>

0000000080007ab0 <holding>:
    80007ab0:	00052783          	lw	a5,0(a0)
    80007ab4:	00079663          	bnez	a5,80007ac0 <holding+0x10>
    80007ab8:	00000513          	li	a0,0
    80007abc:	00008067          	ret
    80007ac0:	fe010113          	addi	sp,sp,-32
    80007ac4:	00813823          	sd	s0,16(sp)
    80007ac8:	00913423          	sd	s1,8(sp)
    80007acc:	00113c23          	sd	ra,24(sp)
    80007ad0:	02010413          	addi	s0,sp,32
    80007ad4:	01053483          	ld	s1,16(a0)
    80007ad8:	ffffe097          	auipc	ra,0xffffe
    80007adc:	750080e7          	jalr	1872(ra) # 80006228 <mycpu>
    80007ae0:	01813083          	ld	ra,24(sp)
    80007ae4:	01013403          	ld	s0,16(sp)
    80007ae8:	40a48533          	sub	a0,s1,a0
    80007aec:	00153513          	seqz	a0,a0
    80007af0:	00813483          	ld	s1,8(sp)
    80007af4:	02010113          	addi	sp,sp,32
    80007af8:	00008067          	ret

0000000080007afc <push_off>:
    80007afc:	fe010113          	addi	sp,sp,-32
    80007b00:	00813823          	sd	s0,16(sp)
    80007b04:	00113c23          	sd	ra,24(sp)
    80007b08:	00913423          	sd	s1,8(sp)
    80007b0c:	02010413          	addi	s0,sp,32
    80007b10:	100024f3          	csrr	s1,sstatus
    80007b14:	100027f3          	csrr	a5,sstatus
    80007b18:	ffd7f793          	andi	a5,a5,-3
    80007b1c:	10079073          	csrw	sstatus,a5
    80007b20:	ffffe097          	auipc	ra,0xffffe
    80007b24:	708080e7          	jalr	1800(ra) # 80006228 <mycpu>
    80007b28:	07852783          	lw	a5,120(a0)
    80007b2c:	02078663          	beqz	a5,80007b58 <push_off+0x5c>
    80007b30:	ffffe097          	auipc	ra,0xffffe
    80007b34:	6f8080e7          	jalr	1784(ra) # 80006228 <mycpu>
    80007b38:	07852783          	lw	a5,120(a0)
    80007b3c:	01813083          	ld	ra,24(sp)
    80007b40:	01013403          	ld	s0,16(sp)
    80007b44:	0017879b          	addiw	a5,a5,1
    80007b48:	06f52c23          	sw	a5,120(a0)
    80007b4c:	00813483          	ld	s1,8(sp)
    80007b50:	02010113          	addi	sp,sp,32
    80007b54:	00008067          	ret
    80007b58:	0014d493          	srli	s1,s1,0x1
    80007b5c:	ffffe097          	auipc	ra,0xffffe
    80007b60:	6cc080e7          	jalr	1740(ra) # 80006228 <mycpu>
    80007b64:	0014f493          	andi	s1,s1,1
    80007b68:	06952e23          	sw	s1,124(a0)
    80007b6c:	fc5ff06f          	j	80007b30 <push_off+0x34>

0000000080007b70 <pop_off>:
    80007b70:	ff010113          	addi	sp,sp,-16
    80007b74:	00813023          	sd	s0,0(sp)
    80007b78:	00113423          	sd	ra,8(sp)
    80007b7c:	01010413          	addi	s0,sp,16
    80007b80:	ffffe097          	auipc	ra,0xffffe
    80007b84:	6a8080e7          	jalr	1704(ra) # 80006228 <mycpu>
    80007b88:	100027f3          	csrr	a5,sstatus
    80007b8c:	0027f793          	andi	a5,a5,2
    80007b90:	04079663          	bnez	a5,80007bdc <pop_off+0x6c>
    80007b94:	07852783          	lw	a5,120(a0)
    80007b98:	02f05a63          	blez	a5,80007bcc <pop_off+0x5c>
    80007b9c:	fff7871b          	addiw	a4,a5,-1
    80007ba0:	06e52c23          	sw	a4,120(a0)
    80007ba4:	00071c63          	bnez	a4,80007bbc <pop_off+0x4c>
    80007ba8:	07c52783          	lw	a5,124(a0)
    80007bac:	00078863          	beqz	a5,80007bbc <pop_off+0x4c>
    80007bb0:	100027f3          	csrr	a5,sstatus
    80007bb4:	0027e793          	ori	a5,a5,2
    80007bb8:	10079073          	csrw	sstatus,a5
    80007bbc:	00813083          	ld	ra,8(sp)
    80007bc0:	00013403          	ld	s0,0(sp)
    80007bc4:	01010113          	addi	sp,sp,16
    80007bc8:	00008067          	ret
    80007bcc:	00002517          	auipc	a0,0x2
    80007bd0:	b8c50513          	addi	a0,a0,-1140 # 80009758 <digits+0x48>
    80007bd4:	fffff097          	auipc	ra,0xfffff
    80007bd8:	018080e7          	jalr	24(ra) # 80006bec <panic>
    80007bdc:	00002517          	auipc	a0,0x2
    80007be0:	b6450513          	addi	a0,a0,-1180 # 80009740 <digits+0x30>
    80007be4:	fffff097          	auipc	ra,0xfffff
    80007be8:	008080e7          	jalr	8(ra) # 80006bec <panic>

0000000080007bec <push_on>:
    80007bec:	fe010113          	addi	sp,sp,-32
    80007bf0:	00813823          	sd	s0,16(sp)
    80007bf4:	00113c23          	sd	ra,24(sp)
    80007bf8:	00913423          	sd	s1,8(sp)
    80007bfc:	02010413          	addi	s0,sp,32
    80007c00:	100024f3          	csrr	s1,sstatus
    80007c04:	100027f3          	csrr	a5,sstatus
    80007c08:	0027e793          	ori	a5,a5,2
    80007c0c:	10079073          	csrw	sstatus,a5
    80007c10:	ffffe097          	auipc	ra,0xffffe
    80007c14:	618080e7          	jalr	1560(ra) # 80006228 <mycpu>
    80007c18:	07852783          	lw	a5,120(a0)
    80007c1c:	02078663          	beqz	a5,80007c48 <push_on+0x5c>
    80007c20:	ffffe097          	auipc	ra,0xffffe
    80007c24:	608080e7          	jalr	1544(ra) # 80006228 <mycpu>
    80007c28:	07852783          	lw	a5,120(a0)
    80007c2c:	01813083          	ld	ra,24(sp)
    80007c30:	01013403          	ld	s0,16(sp)
    80007c34:	0017879b          	addiw	a5,a5,1
    80007c38:	06f52c23          	sw	a5,120(a0)
    80007c3c:	00813483          	ld	s1,8(sp)
    80007c40:	02010113          	addi	sp,sp,32
    80007c44:	00008067          	ret
    80007c48:	0014d493          	srli	s1,s1,0x1
    80007c4c:	ffffe097          	auipc	ra,0xffffe
    80007c50:	5dc080e7          	jalr	1500(ra) # 80006228 <mycpu>
    80007c54:	0014f493          	andi	s1,s1,1
    80007c58:	06952e23          	sw	s1,124(a0)
    80007c5c:	fc5ff06f          	j	80007c20 <push_on+0x34>

0000000080007c60 <pop_on>:
    80007c60:	ff010113          	addi	sp,sp,-16
    80007c64:	00813023          	sd	s0,0(sp)
    80007c68:	00113423          	sd	ra,8(sp)
    80007c6c:	01010413          	addi	s0,sp,16
    80007c70:	ffffe097          	auipc	ra,0xffffe
    80007c74:	5b8080e7          	jalr	1464(ra) # 80006228 <mycpu>
    80007c78:	100027f3          	csrr	a5,sstatus
    80007c7c:	0027f793          	andi	a5,a5,2
    80007c80:	04078463          	beqz	a5,80007cc8 <pop_on+0x68>
    80007c84:	07852783          	lw	a5,120(a0)
    80007c88:	02f05863          	blez	a5,80007cb8 <pop_on+0x58>
    80007c8c:	fff7879b          	addiw	a5,a5,-1
    80007c90:	06f52c23          	sw	a5,120(a0)
    80007c94:	07853783          	ld	a5,120(a0)
    80007c98:	00079863          	bnez	a5,80007ca8 <pop_on+0x48>
    80007c9c:	100027f3          	csrr	a5,sstatus
    80007ca0:	ffd7f793          	andi	a5,a5,-3
    80007ca4:	10079073          	csrw	sstatus,a5
    80007ca8:	00813083          	ld	ra,8(sp)
    80007cac:	00013403          	ld	s0,0(sp)
    80007cb0:	01010113          	addi	sp,sp,16
    80007cb4:	00008067          	ret
    80007cb8:	00002517          	auipc	a0,0x2
    80007cbc:	ac850513          	addi	a0,a0,-1336 # 80009780 <digits+0x70>
    80007cc0:	fffff097          	auipc	ra,0xfffff
    80007cc4:	f2c080e7          	jalr	-212(ra) # 80006bec <panic>
    80007cc8:	00002517          	auipc	a0,0x2
    80007ccc:	a9850513          	addi	a0,a0,-1384 # 80009760 <digits+0x50>
    80007cd0:	fffff097          	auipc	ra,0xfffff
    80007cd4:	f1c080e7          	jalr	-228(ra) # 80006bec <panic>

0000000080007cd8 <__memset>:
    80007cd8:	ff010113          	addi	sp,sp,-16
    80007cdc:	00813423          	sd	s0,8(sp)
    80007ce0:	01010413          	addi	s0,sp,16
    80007ce4:	1a060e63          	beqz	a2,80007ea0 <__memset+0x1c8>
    80007ce8:	40a007b3          	neg	a5,a0
    80007cec:	0077f793          	andi	a5,a5,7
    80007cf0:	00778693          	addi	a3,a5,7
    80007cf4:	00b00813          	li	a6,11
    80007cf8:	0ff5f593          	andi	a1,a1,255
    80007cfc:	fff6071b          	addiw	a4,a2,-1
    80007d00:	1b06e663          	bltu	a3,a6,80007eac <__memset+0x1d4>
    80007d04:	1cd76463          	bltu	a4,a3,80007ecc <__memset+0x1f4>
    80007d08:	1a078e63          	beqz	a5,80007ec4 <__memset+0x1ec>
    80007d0c:	00b50023          	sb	a1,0(a0)
    80007d10:	00100713          	li	a4,1
    80007d14:	1ae78463          	beq	a5,a4,80007ebc <__memset+0x1e4>
    80007d18:	00b500a3          	sb	a1,1(a0)
    80007d1c:	00200713          	li	a4,2
    80007d20:	1ae78a63          	beq	a5,a4,80007ed4 <__memset+0x1fc>
    80007d24:	00b50123          	sb	a1,2(a0)
    80007d28:	00300713          	li	a4,3
    80007d2c:	18e78463          	beq	a5,a4,80007eb4 <__memset+0x1dc>
    80007d30:	00b501a3          	sb	a1,3(a0)
    80007d34:	00400713          	li	a4,4
    80007d38:	1ae78263          	beq	a5,a4,80007edc <__memset+0x204>
    80007d3c:	00b50223          	sb	a1,4(a0)
    80007d40:	00500713          	li	a4,5
    80007d44:	1ae78063          	beq	a5,a4,80007ee4 <__memset+0x20c>
    80007d48:	00b502a3          	sb	a1,5(a0)
    80007d4c:	00700713          	li	a4,7
    80007d50:	18e79e63          	bne	a5,a4,80007eec <__memset+0x214>
    80007d54:	00b50323          	sb	a1,6(a0)
    80007d58:	00700e93          	li	t4,7
    80007d5c:	00859713          	slli	a4,a1,0x8
    80007d60:	00e5e733          	or	a4,a1,a4
    80007d64:	01059e13          	slli	t3,a1,0x10
    80007d68:	01c76e33          	or	t3,a4,t3
    80007d6c:	01859313          	slli	t1,a1,0x18
    80007d70:	006e6333          	or	t1,t3,t1
    80007d74:	02059893          	slli	a7,a1,0x20
    80007d78:	40f60e3b          	subw	t3,a2,a5
    80007d7c:	011368b3          	or	a7,t1,a7
    80007d80:	02859813          	slli	a6,a1,0x28
    80007d84:	0108e833          	or	a6,a7,a6
    80007d88:	03059693          	slli	a3,a1,0x30
    80007d8c:	003e589b          	srliw	a7,t3,0x3
    80007d90:	00d866b3          	or	a3,a6,a3
    80007d94:	03859713          	slli	a4,a1,0x38
    80007d98:	00389813          	slli	a6,a7,0x3
    80007d9c:	00f507b3          	add	a5,a0,a5
    80007da0:	00e6e733          	or	a4,a3,a4
    80007da4:	000e089b          	sext.w	a7,t3
    80007da8:	00f806b3          	add	a3,a6,a5
    80007dac:	00e7b023          	sd	a4,0(a5)
    80007db0:	00878793          	addi	a5,a5,8
    80007db4:	fed79ce3          	bne	a5,a3,80007dac <__memset+0xd4>
    80007db8:	ff8e7793          	andi	a5,t3,-8
    80007dbc:	0007871b          	sext.w	a4,a5
    80007dc0:	01d787bb          	addw	a5,a5,t4
    80007dc4:	0ce88e63          	beq	a7,a4,80007ea0 <__memset+0x1c8>
    80007dc8:	00f50733          	add	a4,a0,a5
    80007dcc:	00b70023          	sb	a1,0(a4)
    80007dd0:	0017871b          	addiw	a4,a5,1
    80007dd4:	0cc77663          	bgeu	a4,a2,80007ea0 <__memset+0x1c8>
    80007dd8:	00e50733          	add	a4,a0,a4
    80007ddc:	00b70023          	sb	a1,0(a4)
    80007de0:	0027871b          	addiw	a4,a5,2
    80007de4:	0ac77e63          	bgeu	a4,a2,80007ea0 <__memset+0x1c8>
    80007de8:	00e50733          	add	a4,a0,a4
    80007dec:	00b70023          	sb	a1,0(a4)
    80007df0:	0037871b          	addiw	a4,a5,3
    80007df4:	0ac77663          	bgeu	a4,a2,80007ea0 <__memset+0x1c8>
    80007df8:	00e50733          	add	a4,a0,a4
    80007dfc:	00b70023          	sb	a1,0(a4)
    80007e00:	0047871b          	addiw	a4,a5,4
    80007e04:	08c77e63          	bgeu	a4,a2,80007ea0 <__memset+0x1c8>
    80007e08:	00e50733          	add	a4,a0,a4
    80007e0c:	00b70023          	sb	a1,0(a4)
    80007e10:	0057871b          	addiw	a4,a5,5
    80007e14:	08c77663          	bgeu	a4,a2,80007ea0 <__memset+0x1c8>
    80007e18:	00e50733          	add	a4,a0,a4
    80007e1c:	00b70023          	sb	a1,0(a4)
    80007e20:	0067871b          	addiw	a4,a5,6
    80007e24:	06c77e63          	bgeu	a4,a2,80007ea0 <__memset+0x1c8>
    80007e28:	00e50733          	add	a4,a0,a4
    80007e2c:	00b70023          	sb	a1,0(a4)
    80007e30:	0077871b          	addiw	a4,a5,7
    80007e34:	06c77663          	bgeu	a4,a2,80007ea0 <__memset+0x1c8>
    80007e38:	00e50733          	add	a4,a0,a4
    80007e3c:	00b70023          	sb	a1,0(a4)
    80007e40:	0087871b          	addiw	a4,a5,8
    80007e44:	04c77e63          	bgeu	a4,a2,80007ea0 <__memset+0x1c8>
    80007e48:	00e50733          	add	a4,a0,a4
    80007e4c:	00b70023          	sb	a1,0(a4)
    80007e50:	0097871b          	addiw	a4,a5,9
    80007e54:	04c77663          	bgeu	a4,a2,80007ea0 <__memset+0x1c8>
    80007e58:	00e50733          	add	a4,a0,a4
    80007e5c:	00b70023          	sb	a1,0(a4)
    80007e60:	00a7871b          	addiw	a4,a5,10
    80007e64:	02c77e63          	bgeu	a4,a2,80007ea0 <__memset+0x1c8>
    80007e68:	00e50733          	add	a4,a0,a4
    80007e6c:	00b70023          	sb	a1,0(a4)
    80007e70:	00b7871b          	addiw	a4,a5,11
    80007e74:	02c77663          	bgeu	a4,a2,80007ea0 <__memset+0x1c8>
    80007e78:	00e50733          	add	a4,a0,a4
    80007e7c:	00b70023          	sb	a1,0(a4)
    80007e80:	00c7871b          	addiw	a4,a5,12
    80007e84:	00c77e63          	bgeu	a4,a2,80007ea0 <__memset+0x1c8>
    80007e88:	00e50733          	add	a4,a0,a4
    80007e8c:	00b70023          	sb	a1,0(a4)
    80007e90:	00d7879b          	addiw	a5,a5,13
    80007e94:	00c7f663          	bgeu	a5,a2,80007ea0 <__memset+0x1c8>
    80007e98:	00f507b3          	add	a5,a0,a5
    80007e9c:	00b78023          	sb	a1,0(a5)
    80007ea0:	00813403          	ld	s0,8(sp)
    80007ea4:	01010113          	addi	sp,sp,16
    80007ea8:	00008067          	ret
    80007eac:	00b00693          	li	a3,11
    80007eb0:	e55ff06f          	j	80007d04 <__memset+0x2c>
    80007eb4:	00300e93          	li	t4,3
    80007eb8:	ea5ff06f          	j	80007d5c <__memset+0x84>
    80007ebc:	00100e93          	li	t4,1
    80007ec0:	e9dff06f          	j	80007d5c <__memset+0x84>
    80007ec4:	00000e93          	li	t4,0
    80007ec8:	e95ff06f          	j	80007d5c <__memset+0x84>
    80007ecc:	00000793          	li	a5,0
    80007ed0:	ef9ff06f          	j	80007dc8 <__memset+0xf0>
    80007ed4:	00200e93          	li	t4,2
    80007ed8:	e85ff06f          	j	80007d5c <__memset+0x84>
    80007edc:	00400e93          	li	t4,4
    80007ee0:	e7dff06f          	j	80007d5c <__memset+0x84>
    80007ee4:	00500e93          	li	t4,5
    80007ee8:	e75ff06f          	j	80007d5c <__memset+0x84>
    80007eec:	00600e93          	li	t4,6
    80007ef0:	e6dff06f          	j	80007d5c <__memset+0x84>

0000000080007ef4 <__memmove>:
    80007ef4:	ff010113          	addi	sp,sp,-16
    80007ef8:	00813423          	sd	s0,8(sp)
    80007efc:	01010413          	addi	s0,sp,16
    80007f00:	0e060863          	beqz	a2,80007ff0 <__memmove+0xfc>
    80007f04:	fff6069b          	addiw	a3,a2,-1
    80007f08:	0006881b          	sext.w	a6,a3
    80007f0c:	0ea5e863          	bltu	a1,a0,80007ffc <__memmove+0x108>
    80007f10:	00758713          	addi	a4,a1,7
    80007f14:	00a5e7b3          	or	a5,a1,a0
    80007f18:	40a70733          	sub	a4,a4,a0
    80007f1c:	0077f793          	andi	a5,a5,7
    80007f20:	00f73713          	sltiu	a4,a4,15
    80007f24:	00174713          	xori	a4,a4,1
    80007f28:	0017b793          	seqz	a5,a5
    80007f2c:	00e7f7b3          	and	a5,a5,a4
    80007f30:	10078863          	beqz	a5,80008040 <__memmove+0x14c>
    80007f34:	00900793          	li	a5,9
    80007f38:	1107f463          	bgeu	a5,a6,80008040 <__memmove+0x14c>
    80007f3c:	0036581b          	srliw	a6,a2,0x3
    80007f40:	fff8081b          	addiw	a6,a6,-1
    80007f44:	02081813          	slli	a6,a6,0x20
    80007f48:	01d85893          	srli	a7,a6,0x1d
    80007f4c:	00858813          	addi	a6,a1,8
    80007f50:	00058793          	mv	a5,a1
    80007f54:	00050713          	mv	a4,a0
    80007f58:	01088833          	add	a6,a7,a6
    80007f5c:	0007b883          	ld	a7,0(a5)
    80007f60:	00878793          	addi	a5,a5,8
    80007f64:	00870713          	addi	a4,a4,8
    80007f68:	ff173c23          	sd	a7,-8(a4)
    80007f6c:	ff0798e3          	bne	a5,a6,80007f5c <__memmove+0x68>
    80007f70:	ff867713          	andi	a4,a2,-8
    80007f74:	02071793          	slli	a5,a4,0x20
    80007f78:	0207d793          	srli	a5,a5,0x20
    80007f7c:	00f585b3          	add	a1,a1,a5
    80007f80:	40e686bb          	subw	a3,a3,a4
    80007f84:	00f507b3          	add	a5,a0,a5
    80007f88:	06e60463          	beq	a2,a4,80007ff0 <__memmove+0xfc>
    80007f8c:	0005c703          	lbu	a4,0(a1)
    80007f90:	00e78023          	sb	a4,0(a5)
    80007f94:	04068e63          	beqz	a3,80007ff0 <__memmove+0xfc>
    80007f98:	0015c603          	lbu	a2,1(a1)
    80007f9c:	00100713          	li	a4,1
    80007fa0:	00c780a3          	sb	a2,1(a5)
    80007fa4:	04e68663          	beq	a3,a4,80007ff0 <__memmove+0xfc>
    80007fa8:	0025c603          	lbu	a2,2(a1)
    80007fac:	00200713          	li	a4,2
    80007fb0:	00c78123          	sb	a2,2(a5)
    80007fb4:	02e68e63          	beq	a3,a4,80007ff0 <__memmove+0xfc>
    80007fb8:	0035c603          	lbu	a2,3(a1)
    80007fbc:	00300713          	li	a4,3
    80007fc0:	00c781a3          	sb	a2,3(a5)
    80007fc4:	02e68663          	beq	a3,a4,80007ff0 <__memmove+0xfc>
    80007fc8:	0045c603          	lbu	a2,4(a1)
    80007fcc:	00400713          	li	a4,4
    80007fd0:	00c78223          	sb	a2,4(a5)
    80007fd4:	00e68e63          	beq	a3,a4,80007ff0 <__memmove+0xfc>
    80007fd8:	0055c603          	lbu	a2,5(a1)
    80007fdc:	00500713          	li	a4,5
    80007fe0:	00c782a3          	sb	a2,5(a5)
    80007fe4:	00e68663          	beq	a3,a4,80007ff0 <__memmove+0xfc>
    80007fe8:	0065c703          	lbu	a4,6(a1)
    80007fec:	00e78323          	sb	a4,6(a5)
    80007ff0:	00813403          	ld	s0,8(sp)
    80007ff4:	01010113          	addi	sp,sp,16
    80007ff8:	00008067          	ret
    80007ffc:	02061713          	slli	a4,a2,0x20
    80008000:	02075713          	srli	a4,a4,0x20
    80008004:	00e587b3          	add	a5,a1,a4
    80008008:	f0f574e3          	bgeu	a0,a5,80007f10 <__memmove+0x1c>
    8000800c:	02069613          	slli	a2,a3,0x20
    80008010:	02065613          	srli	a2,a2,0x20
    80008014:	fff64613          	not	a2,a2
    80008018:	00e50733          	add	a4,a0,a4
    8000801c:	00c78633          	add	a2,a5,a2
    80008020:	fff7c683          	lbu	a3,-1(a5)
    80008024:	fff78793          	addi	a5,a5,-1
    80008028:	fff70713          	addi	a4,a4,-1
    8000802c:	00d70023          	sb	a3,0(a4)
    80008030:	fec798e3          	bne	a5,a2,80008020 <__memmove+0x12c>
    80008034:	00813403          	ld	s0,8(sp)
    80008038:	01010113          	addi	sp,sp,16
    8000803c:	00008067          	ret
    80008040:	02069713          	slli	a4,a3,0x20
    80008044:	02075713          	srli	a4,a4,0x20
    80008048:	00170713          	addi	a4,a4,1
    8000804c:	00e50733          	add	a4,a0,a4
    80008050:	00050793          	mv	a5,a0
    80008054:	0005c683          	lbu	a3,0(a1)
    80008058:	00178793          	addi	a5,a5,1
    8000805c:	00158593          	addi	a1,a1,1
    80008060:	fed78fa3          	sb	a3,-1(a5)
    80008064:	fee798e3          	bne	a5,a4,80008054 <__memmove+0x160>
    80008068:	f89ff06f          	j	80007ff0 <__memmove+0xfc>

000000008000806c <__putc>:
    8000806c:	fe010113          	addi	sp,sp,-32
    80008070:	00813823          	sd	s0,16(sp)
    80008074:	00113c23          	sd	ra,24(sp)
    80008078:	02010413          	addi	s0,sp,32
    8000807c:	00050793          	mv	a5,a0
    80008080:	fef40593          	addi	a1,s0,-17
    80008084:	00100613          	li	a2,1
    80008088:	00000513          	li	a0,0
    8000808c:	fef407a3          	sb	a5,-17(s0)
    80008090:	fffff097          	auipc	ra,0xfffff
    80008094:	b3c080e7          	jalr	-1220(ra) # 80006bcc <console_write>
    80008098:	01813083          	ld	ra,24(sp)
    8000809c:	01013403          	ld	s0,16(sp)
    800080a0:	02010113          	addi	sp,sp,32
    800080a4:	00008067          	ret

00000000800080a8 <__getc>:
    800080a8:	fe010113          	addi	sp,sp,-32
    800080ac:	00813823          	sd	s0,16(sp)
    800080b0:	00113c23          	sd	ra,24(sp)
    800080b4:	02010413          	addi	s0,sp,32
    800080b8:	fe840593          	addi	a1,s0,-24
    800080bc:	00100613          	li	a2,1
    800080c0:	00000513          	li	a0,0
    800080c4:	fffff097          	auipc	ra,0xfffff
    800080c8:	ae8080e7          	jalr	-1304(ra) # 80006bac <console_read>
    800080cc:	fe844503          	lbu	a0,-24(s0)
    800080d0:	01813083          	ld	ra,24(sp)
    800080d4:	01013403          	ld	s0,16(sp)
    800080d8:	02010113          	addi	sp,sp,32
    800080dc:	00008067          	ret

00000000800080e0 <console_handler>:
    800080e0:	fe010113          	addi	sp,sp,-32
    800080e4:	00813823          	sd	s0,16(sp)
    800080e8:	00113c23          	sd	ra,24(sp)
    800080ec:	00913423          	sd	s1,8(sp)
    800080f0:	02010413          	addi	s0,sp,32
    800080f4:	14202773          	csrr	a4,scause
    800080f8:	100027f3          	csrr	a5,sstatus
    800080fc:	0027f793          	andi	a5,a5,2
    80008100:	06079e63          	bnez	a5,8000817c <console_handler+0x9c>
    80008104:	00074c63          	bltz	a4,8000811c <console_handler+0x3c>
    80008108:	01813083          	ld	ra,24(sp)
    8000810c:	01013403          	ld	s0,16(sp)
    80008110:	00813483          	ld	s1,8(sp)
    80008114:	02010113          	addi	sp,sp,32
    80008118:	00008067          	ret
    8000811c:	0ff77713          	andi	a4,a4,255
    80008120:	00900793          	li	a5,9
    80008124:	fef712e3          	bne	a4,a5,80008108 <console_handler+0x28>
    80008128:	ffffe097          	auipc	ra,0xffffe
    8000812c:	6dc080e7          	jalr	1756(ra) # 80006804 <plic_claim>
    80008130:	00a00793          	li	a5,10
    80008134:	00050493          	mv	s1,a0
    80008138:	02f50c63          	beq	a0,a5,80008170 <console_handler+0x90>
    8000813c:	fc0506e3          	beqz	a0,80008108 <console_handler+0x28>
    80008140:	00050593          	mv	a1,a0
    80008144:	00001517          	auipc	a0,0x1
    80008148:	54450513          	addi	a0,a0,1348 # 80009688 <CONSOLE_STATUS+0x678>
    8000814c:	fffff097          	auipc	ra,0xfffff
    80008150:	afc080e7          	jalr	-1284(ra) # 80006c48 <__printf>
    80008154:	01013403          	ld	s0,16(sp)
    80008158:	01813083          	ld	ra,24(sp)
    8000815c:	00048513          	mv	a0,s1
    80008160:	00813483          	ld	s1,8(sp)
    80008164:	02010113          	addi	sp,sp,32
    80008168:	ffffe317          	auipc	t1,0xffffe
    8000816c:	6d430067          	jr	1748(t1) # 8000683c <plic_complete>
    80008170:	fffff097          	auipc	ra,0xfffff
    80008174:	3e0080e7          	jalr	992(ra) # 80007550 <uartintr>
    80008178:	fddff06f          	j	80008154 <console_handler+0x74>
    8000817c:	00001517          	auipc	a0,0x1
    80008180:	60c50513          	addi	a0,a0,1548 # 80009788 <digits+0x78>
    80008184:	fffff097          	auipc	ra,0xfffff
    80008188:	a68080e7          	jalr	-1432(ra) # 80006bec <panic>
	...
