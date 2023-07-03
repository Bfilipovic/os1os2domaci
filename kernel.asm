
kernel:     file format elf64-littleriscv


Disassembly of section .text:

0000000080000000 <_entry>:
    80000000:	0000d117          	auipc	sp,0xd
    80000004:	c4813103          	ld	sp,-952(sp) # 8000cc48 <_GLOBAL_OFFSET_TABLE_+0x38>
    80000008:	00001537          	lui	a0,0x1
    8000000c:	f14025f3          	csrr	a1,mhartid
    80000010:	00158593          	addi	a1,a1,1
    80000014:	02b50533          	mul	a0,a0,a1
    80000018:	00a10133          	add	sp,sp,a0
    8000001c:	089070ef          	jal	ra,800078a4 <start>

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
    800010c8:	774020ef          	jal	ra,8000383c <handleInterrupt>

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
    800011d4:	3d8020ef          	jal	ra,800035ac <handleEcall>
    
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
    800012a0:	2d8080e7          	jalr	728(ra) # 80003574 <_Z12kern_syscall13SyscallNumberz>
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
    800012dc:	29c080e7          	jalr	668(ra) # 80003574 <_Z12kern_syscall13SyscallNumberz>
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
    80001350:	228080e7          	jalr	552(ra) # 80003574 <_Z12kern_syscall13SyscallNumberz>
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
    800013a0:	1d8080e7          	jalr	472(ra) # 80003574 <_Z12kern_syscall13SyscallNumberz>
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
    800013cc:	8687b783          	ld	a5,-1944(a5) # 8000cc30 <_GLOBAL_OFFSET_TABLE_+0x20>
    800013d0:	0007b783          	ld	a5,0(a5)
    800013d4:	0407b483          	ld	s1,64(a5)
    kern_syscall(THREAD_EXIT);
    800013d8:	01200513          	li	a0,18
    800013dc:	00002097          	auipc	ra,0x2
    800013e0:	198080e7          	jalr	408(ra) # 80003574 <_Z12kern_syscall13SyscallNumberz>
    kern_syscall(MEM_FREE,stack);
    800013e4:	00048593          	mv	a1,s1
    800013e8:	00200513          	li	a0,2
    800013ec:	00002097          	auipc	ra,0x2
    800013f0:	188080e7          	jalr	392(ra) # 80003574 <_Z12kern_syscall13SyscallNumberz>
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
    80001428:	150080e7          	jalr	336(ra) # 80003574 <_Z12kern_syscall13SyscallNumberz>
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
    8000145c:	11c080e7          	jalr	284(ra) # 80003574 <_Z12kern_syscall13SyscallNumberz>
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
    8000149c:	0dc080e7          	jalr	220(ra) # 80003574 <_Z12kern_syscall13SyscallNumberz>
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
    800014dc:	09c080e7          	jalr	156(ra) # 80003574 <_Z12kern_syscall13SyscallNumberz>
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
    8000151c:	05c080e7          	jalr	92(ra) # 80003574 <_Z12kern_syscall13SyscallNumberz>
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
    8000155c:	01c080e7          	jalr	28(ra) # 80003574 <_Z12kern_syscall13SyscallNumberz>
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
    8000158c:	fec080e7          	jalr	-20(ra) # 80003574 <_Z12kern_syscall13SyscallNumberz>
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
    800015cc:	fac080e7          	jalr	-84(ra) # 80003574 <_Z12kern_syscall13SyscallNumberz>
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
    800015f8:	6ac4b483          	ld	s1,1708(s1) # 8000cca0 <bba_allocatedBlocks>
    while (curr){
    800015fc:	04048263          	beqz	s1,80001640 <_Z26bba_print_used_blocks_infov+0x60>
        printf("\nBlock of size %d is allocated on addr start+%lx and its descriptor is located at start+%lx (%lx), ends at start+%lx", curr->n, curr->addr-buddyMemStart, (char*)curr-buddyMemStart,curr,curr->addr-buddyMemStart+(1<<curr->n));
    80001600:	0084a583          	lw	a1,8(s1)
    80001604:	0104b603          	ld	a2,16(s1)
    80001608:	0000b697          	auipc	a3,0xb
    8000160c:	6a06b683          	ld	a3,1696(a3) # 8000cca8 <buddyMemStart>
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
    80001690:	61c6b683          	ld	a3,1564(a3) # 8000cca8 <buddyMemStart>
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
    800016d0:	5d478793          	addi	a5,a5,1492 # 8000cca0 <bba_allocatedBlocks>
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
    80001748:	55c78793          	addi	a5,a5,1372 # 8000cca0 <bba_allocatedBlocks>
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
    80001768:	53c70713          	addi	a4,a4,1340 # 8000cca0 <bba_allocatedBlocks>
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
    800017ac:	4f878793          	addi	a5,a5,1272 # 8000cca0 <bba_allocatedBlocks>
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
    800017f0:	4b478793          	addi	a5,a5,1204 # 8000cca0 <bba_allocatedBlocks>
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
    80001808:	49c68693          	addi	a3,a3,1180 # 8000cca0 <bba_allocatedBlocks>
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
    800018e4:	3c078793          	addi	a5,a5,960 # 8000cca0 <bba_allocatedBlocks>
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
    80001920:	38478793          	addi	a5,a5,900 # 8000cca0 <bba_allocatedBlocks>
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
    80001958:	34c78793          	addi	a5,a5,844 # 8000cca0 <bba_allocatedBlocks>
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
    8000197c:	32870713          	addi	a4,a4,808 # 8000cca0 <bba_allocatedBlocks>
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
    800019c0:	2e468693          	addi	a3,a3,740 # 8000cca0 <bba_allocatedBlocks>
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
    80001aa4:	20098993          	addi	s3,s3,512 # 8000cca0 <bba_allocatedBlocks>
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
    80001b20:	18470713          	addi	a4,a4,388 # 8000cca0 <bba_allocatedBlocks>
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
    80001b78:	12c78793          	addi	a5,a5,300 # 8000cca0 <bba_allocatedBlocks>
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
    80001b94:	11078793          	addi	a5,a5,272 # 8000cca0 <bba_allocatedBlocks>
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
    80001c34:	07078793          	addi	a5,a5,112 # 8000cca0 <bba_allocatedBlocks>
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
    80001c74:	03053503          	ld	a0,48(a0) # 8000cca0 <bba_allocatedBlocks>
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
    80001ca8:	ffc7b783          	ld	a5,-4(a5) # 8000cca0 <bba_allocatedBlocks>
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
    80001ce0:	fcf73223          	sd	a5,-60(a4) # 8000cca0 <bba_allocatedBlocks>
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
    80001db0:	c5470713          	addi	a4,a4,-940 # 8000ca00 <digits>
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
    80001e74:	b9078793          	addi	a5,a5,-1136 # 8000ca00 <digits>
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
    80001ed0:	e7c50513          	addi	a0,a0,-388 # 8000cd48 <lockPrint>
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
    80001f10:	e3c50513          	addi	a0,a0,-452 # 8000cd48 <lockPrint>
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
    80001f68:	de450513          	addi	a0,a0,-540 # 8000cd48 <lockPrint>
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
    80001fd8:	d7450513          	addi	a0,a0,-652 # 8000cd48 <lockPrint>
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
    80002090:	cbc50513          	addi	a0,a0,-836 # 8000cd48 <lockPrint>
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
    800020dc:	92870713          	addi	a4,a4,-1752 # 8000ca00 <digits>
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
    80002150:	bfc50513          	addi	a0,a0,-1028 # 8000cd48 <lockPrint>
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
    800021a4:	ba850513          	addi	a0,a0,-1112 # 8000cd48 <lockPrint>
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
    800021ec:	81878793          	addi	a5,a5,-2024 # 8000ca00 <digits>
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
    80002218:	b3450513          	addi	a0,a0,-1228 # 8000cd48 <lockPrint>
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
    80002288:	ac450513          	addi	a0,a0,-1340 # 8000cd48 <lockPrint>
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
    800023e0:	96c50513          	addi	a0,a0,-1684 # 8000cd48 <lockPrint>
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
    80002420:	9345b583          	ld	a1,-1740(a1) # 8000cd50 <freeHead>
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
    80002458:	8ef6be23          	sd	a5,-1796(a3) # 8000cd50 <freeHead>
    8000245c:	fe1ff06f          	j	8000243c <_Z14kern_mem_alloci+0x30>
            if(curr==freeHead) freeHead=newFreeBlock;
    80002460:	0000b797          	auipc	a5,0xb
    80002464:	8eb7b823          	sd	a1,-1808(a5) # 8000cd50 <freeHead>
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
    800024b8:	89c7b783          	ld	a5,-1892(a5) # 8000cd50 <freeHead>
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
    800024e4:	8707b783          	ld	a5,-1936(a5) # 8000cd50 <freeHead>
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
    8000255c:	0000a697          	auipc	a3,0xa
    80002560:	7ee6ba23          	sd	a4,2036(a3) # 8000cd50 <freeHead>
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
    800025b0:	0000a797          	auipc	a5,0xa
    800025b4:	7a078793          	addi	a5,a5,1952 # 8000cd50 <freeHead>
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
    800025ec:	fe010113          	addi	sp,sp,-32
    800025f0:	00113c23          	sd	ra,24(sp)
    800025f4:	00813823          	sd	s0,16(sp)
    800025f8:	00913423          	sd	s1,8(sp)
    800025fc:	02010413          	addi	s0,sp,32
    console.input=(char*)kmalloc(BUFFER_SIZE*sizeof(char));
    80002600:	40000513          	li	a0,1024
    80002604:	00002097          	auipc	ra,0x2
    80002608:	d9c080e7          	jalr	-612(ra) # 800043a0 <_Z7kmallocm>
    8000260c:	0000a497          	auipc	s1,0xa
    80002610:	75448493          	addi	s1,s1,1876 # 8000cd60 <console>
    80002614:	00a4b023          	sd	a0,0(s1)
    console.output=(char*)kmalloc(BUFFER_SIZE*sizeof(char));
    80002618:	40000513          	li	a0,1024
    8000261c:	00002097          	auipc	ra,0x2
    80002620:	d84080e7          	jalr	-636(ra) # 800043a0 <_Z7kmallocm>
    80002624:	00a4b423          	sd	a0,8(s1)
    console.input_r=0;
    80002628:	0004a823          	sw	zero,16(s1)
    console.input_w=0;
    8000262c:	0004aa23          	sw	zero,20(s1)
    console.output_r=0;
    80002630:	0004ac23          	sw	zero,24(s1)
    console.input_w=0;
}
    80002634:	01813083          	ld	ra,24(sp)
    80002638:	01013403          	ld	s0,16(sp)
    8000263c:	00813483          	ld	s1,8(sp)
    80002640:	02010113          	addi	sp,sp,32
    80002644:	00008067          	ret

0000000080002648 <_Z12uart_getcharv>:

int uart_getchar(void)
{
    80002648:	ff010113          	addi	sp,sp,-16
    8000264c:	00813423          	sd	s0,8(sp)
    80002650:	01010413          	addi	s0,sp,16
    if((ReadReg(CONSOLE_STATUS) & CONSOLE_RX_STATUS_BIT)!=0){
    80002654:	0000a797          	auipc	a5,0xa
    80002658:	5cc7b783          	ld	a5,1484(a5) # 8000cc20 <_GLOBAL_OFFSET_TABLE_+0x10>
    8000265c:	0007b783          	ld	a5,0(a5)
    80002660:	0007c783          	lbu	a5,0(a5)
    80002664:	0017f793          	andi	a5,a5,1
    80002668:	02078263          	beqz	a5,8000268c <_Z12uart_getcharv+0x44>
        // input data is ready.
        return ReadReg(CONSOLE_RX_DATA);
    8000266c:	0000a797          	auipc	a5,0xa
    80002670:	5ac7b783          	ld	a5,1452(a5) # 8000cc18 <_GLOBAL_OFFSET_TABLE_+0x8>
    80002674:	0007b783          	ld	a5,0(a5)
    80002678:	0007c503          	lbu	a0,0(a5)
    8000267c:	0ff57513          	andi	a0,a0,255
    } else {
        return -1;
    }
}
    80002680:	00813403          	ld	s0,8(sp)
    80002684:	01010113          	addi	sp,sp,16
    80002688:	00008067          	ret
        return -1;
    8000268c:	fff00513          	li	a0,-1
    80002690:	ff1ff06f          	j	80002680 <_Z12uart_getcharv+0x38>

0000000080002694 <_Z12uart_putcharv>:

void uart_putchar()
{
    80002694:	ff010113          	addi	sp,sp,-16
    80002698:	00813423          	sd	s0,8(sp)
    8000269c:	01010413          	addi	s0,sp,16
    if(console.output_r==console.output_w) return;
    800026a0:	0000a717          	auipc	a4,0xa
    800026a4:	6c070713          	addi	a4,a4,1728 # 8000cd60 <console>
    800026a8:	01872783          	lw	a5,24(a4)
    800026ac:	01c72703          	lw	a4,28(a4)
    800026b0:	06e78063          	beq	a5,a4,80002710 <_Z12uart_putcharv+0x7c>

    if((ReadReg(CONSOLE_STATUS) & CONSOLE_TX_STATUS_BIT) == 0){
    800026b4:	0000a717          	auipc	a4,0xa
    800026b8:	56c73703          	ld	a4,1388(a4) # 8000cc20 <_GLOBAL_OFFSET_TABLE_+0x10>
    800026bc:	00073703          	ld	a4,0(a4)
    800026c0:	00074703          	lbu	a4,0(a4)
    800026c4:	0ff77713          	andi	a4,a4,255
    800026c8:	02077713          	andi	a4,a4,32
    800026cc:	04070263          	beqz	a4,80002710 <_Z12uart_putcharv+0x7c>
        return;
    }

    char c = console.output[(console.output_r++)%BUFFER_SIZE];
    800026d0:	0000a717          	auipc	a4,0xa
    800026d4:	69070713          	addi	a4,a4,1680 # 8000cd60 <console>
    800026d8:	00873683          	ld	a3,8(a4)
    800026dc:	0017861b          	addiw	a2,a5,1
    800026e0:	00c72c23          	sw	a2,24(a4)
    800026e4:	41f7d71b          	sraiw	a4,a5,0x1f
    800026e8:	0167571b          	srliw	a4,a4,0x16
    800026ec:	00f707bb          	addw	a5,a4,a5
    800026f0:	3ff7f793          	andi	a5,a5,1023
    800026f4:	40e787bb          	subw	a5,a5,a4
    800026f8:	00f687b3          	add	a5,a3,a5
    800026fc:	0007c703          	lbu	a4,0(a5)
    WriteReg(CONSOLE_TX_DATA,c);
    80002700:	0000a797          	auipc	a5,0xa
    80002704:	5407b783          	ld	a5,1344(a5) # 8000cc40 <_GLOBAL_OFFSET_TABLE_+0x30>
    80002708:	0007b783          	ld	a5,0(a5)
    8000270c:	00e78023          	sb	a4,0(a5)
}
    80002710:	00813403          	ld	s0,8(sp)
    80002714:	01010113          	addi	sp,sp,16
    80002718:	00008067          	ret

000000008000271c <_Z17kern_uart_handlerv>:

void kern_uart_handler()
{
    8000271c:	ff010113          	addi	sp,sp,-16
    80002720:	00113423          	sd	ra,8(sp)
    80002724:	00813023          	sd	s0,0(sp)
    80002728:	01010413          	addi	s0,sp,16
    while(1){
        int c = uart_getchar();
    8000272c:	00000097          	auipc	ra,0x0
    80002730:	f1c080e7          	jalr	-228(ra) # 80002648 <_Z12uart_getcharv>
        if(c==-1) break;
    80002734:	fff00793          	li	a5,-1
    80002738:	02f50e63          	beq	a0,a5,80002774 <_Z17kern_uart_handlerv+0x58>
        console.input[(console.input_w++)%BUFFER_SIZE]=c;
    8000273c:	0000a717          	auipc	a4,0xa
    80002740:	62470713          	addi	a4,a4,1572 # 8000cd60 <console>
    80002744:	00073683          	ld	a3,0(a4)
    80002748:	01472783          	lw	a5,20(a4)
    8000274c:	0017861b          	addiw	a2,a5,1
    80002750:	00c72a23          	sw	a2,20(a4)
    80002754:	41f7d71b          	sraiw	a4,a5,0x1f
    80002758:	0167571b          	srliw	a4,a4,0x16
    8000275c:	00f707bb          	addw	a5,a4,a5
    80002760:	3ff7f793          	andi	a5,a5,1023
    80002764:	40e787bb          	subw	a5,a5,a4
    80002768:	00f687b3          	add	a5,a3,a5
    8000276c:	00a78023          	sb	a0,0(a5)
    }
    80002770:	fbdff06f          	j	8000272c <_Z17kern_uart_handlerv+0x10>

    uart_putchar();
    80002774:	00000097          	auipc	ra,0x0
    80002778:	f20080e7          	jalr	-224(ra) # 80002694 <_Z12uart_putcharv>
}
    8000277c:	00813083          	ld	ra,8(sp)
    80002780:	00013403          	ld	s0,0(sp)
    80002784:	01010113          	addi	sp,sp,16
    80002788:	00008067          	ret

000000008000278c <_Z20kern_console_getcharv>:

int kern_console_getchar()
{
    8000278c:	ff010113          	addi	sp,sp,-16
    80002790:	00813423          	sd	s0,8(sp)
    80002794:	01010413          	addi	s0,sp,16
    if(console.input_r<console.input_w){
    80002798:	0000a717          	auipc	a4,0xa
    8000279c:	5c870713          	addi	a4,a4,1480 # 8000cd60 <console>
    800027a0:	01072783          	lw	a5,16(a4)
    800027a4:	01472703          	lw	a4,20(a4)
    800027a8:	04e7d063          	bge	a5,a4,800027e8 <_Z20kern_console_getcharv+0x5c>
        return console.input[(console.input_r++)%BUFFER_SIZE];
    800027ac:	0000a717          	auipc	a4,0xa
    800027b0:	5b470713          	addi	a4,a4,1460 # 8000cd60 <console>
    800027b4:	00073683          	ld	a3,0(a4)
    800027b8:	0017861b          	addiw	a2,a5,1
    800027bc:	00c72823          	sw	a2,16(a4)
    800027c0:	41f7d71b          	sraiw	a4,a5,0x1f
    800027c4:	0167571b          	srliw	a4,a4,0x16
    800027c8:	00f707bb          	addw	a5,a4,a5
    800027cc:	3ff7f793          	andi	a5,a5,1023
    800027d0:	40e787bb          	subw	a5,a5,a4
    800027d4:	00f687b3          	add	a5,a3,a5
    800027d8:	0007c503          	lbu	a0,0(a5)
    }
    else return -1;
}
    800027dc:	00813403          	ld	s0,8(sp)
    800027e0:	01010113          	addi	sp,sp,16
    800027e4:	00008067          	ret
    else return -1;
    800027e8:	fff00513          	li	a0,-1
    800027ec:	ff1ff06f          	j	800027dc <_Z20kern_console_getcharv+0x50>

00000000800027f0 <_Z20kern_console_putcharc>:

int kern_console_putchar(char c)
{
    800027f0:	ff010113          	addi	sp,sp,-16
    800027f4:	00813423          	sd	s0,8(sp)
    800027f8:	01010413          	addi	s0,sp,16
    if(ReadReg(CONSOLE_STATUS) & CONSOLE_TX_STATUS_BIT){
    800027fc:	0000a797          	auipc	a5,0xa
    80002800:	4247b783          	ld	a5,1060(a5) # 8000cc20 <_GLOBAL_OFFSET_TABLE_+0x10>
    80002804:	0007b783          	ld	a5,0(a5)
    80002808:	0007c783          	lbu	a5,0(a5)
    8000280c:	0ff7f793          	andi	a5,a5,255
    80002810:	0207f793          	andi	a5,a5,32
    80002814:	02078263          	beqz	a5,80002838 <_Z20kern_console_putcharc+0x48>
        WriteReg(CONSOLE_TX_DATA,c);
    80002818:	0000a797          	auipc	a5,0xa
    8000281c:	4287b783          	ld	a5,1064(a5) # 8000cc40 <_GLOBAL_OFFSET_TABLE_+0x30>
    80002820:	0007b783          	ld	a5,0(a5)
    80002824:	00a78023          	sb	a0,0(a5)
    }
    else{
        if(console.output_r-console.output_w>=BUFFER_SIZE) return -1;
        console.output[(console.output_w++)%BUFFER_SIZE]=c;
    }
    return 0;
    80002828:	00000513          	li	a0,0
}
    8000282c:	00813403          	ld	s0,8(sp)
    80002830:	01010113          	addi	sp,sp,16
    80002834:	00008067          	ret
        if(console.output_r-console.output_w>=BUFFER_SIZE) return -1;
    80002838:	0000a797          	auipc	a5,0xa
    8000283c:	52878793          	addi	a5,a5,1320 # 8000cd60 <console>
    80002840:	0187a703          	lw	a4,24(a5)
    80002844:	01c7a783          	lw	a5,28(a5)
    80002848:	40f7073b          	subw	a4,a4,a5
    8000284c:	3ff00693          	li	a3,1023
    80002850:	02e6ce63          	blt	a3,a4,8000288c <_Z20kern_console_putcharc+0x9c>
        console.output[(console.output_w++)%BUFFER_SIZE]=c;
    80002854:	0000a717          	auipc	a4,0xa
    80002858:	50c70713          	addi	a4,a4,1292 # 8000cd60 <console>
    8000285c:	00873683          	ld	a3,8(a4)
    80002860:	0017861b          	addiw	a2,a5,1
    80002864:	00c72e23          	sw	a2,28(a4)
    80002868:	41f7d71b          	sraiw	a4,a5,0x1f
    8000286c:	0167571b          	srliw	a4,a4,0x16
    80002870:	00f707bb          	addw	a5,a4,a5
    80002874:	3ff7f793          	andi	a5,a5,1023
    80002878:	40e787bb          	subw	a5,a5,a4
    8000287c:	00f687b3          	add	a5,a3,a5
    80002880:	00a78023          	sb	a0,0(a5)
    return 0;
    80002884:	00000513          	li	a0,0
    80002888:	fa5ff06f          	j	8000282c <_Z20kern_console_putcharc+0x3c>
        if(console.output_r-console.output_w>=BUFFER_SIZE) return -1;
    8000288c:	fff00513          	li	a0,-1
    80002890:	f9dff06f          	j	8000282c <_Z20kern_console_putcharc+0x3c>

0000000080002894 <_Z8bodyIdlePv>:

Semaphore* semTest;

int idleAlive=1;
void bodyIdle(void* arg){
    while(idleAlive){
    80002894:	0000a797          	auipc	a5,0xa
    80002898:	1847a783          	lw	a5,388(a5) # 8000ca18 <idleAlive>
    8000289c:	02078c63          	beqz	a5,800028d4 <_Z8bodyIdlePv+0x40>
void bodyIdle(void* arg){
    800028a0:	ff010113          	addi	sp,sp,-16
    800028a4:	00113423          	sd	ra,8(sp)
    800028a8:	00813023          	sd	s0,0(sp)
    800028ac:	01010413          	addi	s0,sp,16
        thread_dispatch();
    800028b0:	fffff097          	auipc	ra,0xfffff
    800028b4:	ad8080e7          	jalr	-1320(ra) # 80001388 <_Z15thread_dispatchv>
    while(idleAlive){
    800028b8:	0000a797          	auipc	a5,0xa
    800028bc:	1607a783          	lw	a5,352(a5) # 8000ca18 <idleAlive>
    800028c0:	fe0798e3          	bnez	a5,800028b0 <_Z8bodyIdlePv+0x1c>
    };
}
    800028c4:	00813083          	ld	ra,8(sp)
    800028c8:	00013403          	ld	s0,0(sp)
    800028cc:	01010113          	addi	sp,sp,16
    800028d0:	00008067          	ret
    800028d4:	00008067          	ret

00000000800028d8 <_Z5bodyCPv>:

void bodyC(void* arg)
{
    800028d8:	fe010113          	addi	sp,sp,-32
    800028dc:	00113c23          	sd	ra,24(sp)
    800028e0:	00813823          	sd	s0,16(sp)
    800028e4:	00913423          	sd	s1,8(sp)
    800028e8:	01213023          	sd	s2,0(sp)
    800028ec:	02010413          	addi	s0,sp,32
    800028f0:	00050913          	mv	s2,a0
    int counter=0;
    800028f4:	00000493          	li	s1,0
    char*c = (char*)arg;
    while(counter<10){
    800028f8:	00900793          	li	a5,9
    800028fc:	0297c263          	blt	a5,s1,80002920 <_Z5bodyCPv+0x48>
        //if(++counter>5) delete semTest;
        putc(*c);
    80002900:	00094503          	lbu	a0,0(s2)
    80002904:	fffff097          	auipc	ra,0xfffff
    80002908:	cac080e7          	jalr	-852(ra) # 800015b0 <_Z4putcc>
        time_sleep(1);
    8000290c:	00100513          	li	a0,1
    80002910:	fffff097          	auipc	ra,0xfffff
    80002914:	c30080e7          	jalr	-976(ra) # 80001540 <_Z10time_sleepm>
        counter++;
    80002918:	0014849b          	addiw	s1,s1,1
    while(counter<10){
    8000291c:	fddff06f          	j	800028f8 <_Z5bodyCPv+0x20>
    }
    counter++;
    //thread_exit();
}
    80002920:	01813083          	ld	ra,24(sp)
    80002924:	01013403          	ld	s0,16(sp)
    80002928:	00813483          	ld	s1,8(sp)
    8000292c:	00013903          	ld	s2,0(sp)
    80002930:	02010113          	addi	sp,sp,32
    80002934:	00008067          	ret

0000000080002938 <_Z5bodyAPv>:

void bodyA(void* arg)
{
    80002938:	fe010113          	addi	sp,sp,-32
    8000293c:	00113c23          	sd	ra,24(sp)
    80002940:	00813823          	sd	s0,16(sp)
    80002944:	00913423          	sd	s1,8(sp)
    80002948:	02010413          	addi	s0,sp,32
    char c = 'a';
    //if(semTest->wait()) c='A';
    for(int i=0;i<10;i++){
    8000294c:	00000493          	li	s1,0
    80002950:	0180006f          	j	80002968 <_Z5bodyAPv+0x30>
        putc(c);
        if(i==5) thread_exit();
    80002954:	fffff097          	auipc	ra,0xfffff
    80002958:	a60080e7          	jalr	-1440(ra) # 800013b4 <_Z11thread_exitv>
        thread_dispatch();
    8000295c:	fffff097          	auipc	ra,0xfffff
    80002960:	a2c080e7          	jalr	-1492(ra) # 80001388 <_Z15thread_dispatchv>
    for(int i=0;i<10;i++){
    80002964:	0014849b          	addiw	s1,s1,1
    80002968:	00900793          	li	a5,9
    8000296c:	0097ce63          	blt	a5,s1,80002988 <_Z5bodyAPv+0x50>
        putc(c);
    80002970:	06100513          	li	a0,97
    80002974:	fffff097          	auipc	ra,0xfffff
    80002978:	c3c080e7          	jalr	-964(ra) # 800015b0 <_Z4putcc>
        if(i==5) thread_exit();
    8000297c:	00500793          	li	a5,5
    80002980:	fcf49ee3          	bne	s1,a5,8000295c <_Z5bodyAPv+0x24>
    80002984:	fd1ff06f          	j	80002954 <_Z5bodyAPv+0x1c>
    }
}
    80002988:	01813083          	ld	ra,24(sp)
    8000298c:	01013403          	ld	s0,16(sp)
    80002990:	00813483          	ld	s1,8(sp)
    80002994:	02010113          	addi	sp,sp,32
    80002998:	00008067          	ret

000000008000299c <_Z5bodyBPv>:

int g=0;

char str[15] = "tesa legenda";
void bodyB(void* arg)
{
    8000299c:	fe010113          	addi	sp,sp,-32
    800029a0:	00113c23          	sd	ra,24(sp)
    800029a4:	00813823          	sd	s0,16(sp)
    800029a8:	00913423          	sd	s1,8(sp)
    800029ac:	02010413          	addi	s0,sp,32

    //time_sleep(10);
    for(int i=0;i<10;i++){
    800029b0:	00000493          	li	s1,0
    800029b4:	0540006f          	j	80002a08 <_Z5bodyBPv+0x6c>
        putc(str[i]);
        for(int k=0;k<10000;k++){
            for(int m=0;m<1000;m++){
    800029b8:	0017071b          	addiw	a4,a4,1
    800029bc:	3e700793          	li	a5,999
    800029c0:	02e7c663          	blt	a5,a4,800029ec <_Z5bodyBPv+0x50>
                if((m*k)%1337==0) g++;
    800029c4:	02e607bb          	mulw	a5,a2,a4
    800029c8:	53900693          	li	a3,1337
    800029cc:	02d7e7bb          	remw	a5,a5,a3
    800029d0:	fe0794e3          	bnez	a5,800029b8 <_Z5bodyBPv+0x1c>
    800029d4:	0000a697          	auipc	a3,0xa
    800029d8:	3ac68693          	addi	a3,a3,940 # 8000cd80 <g>
    800029dc:	0006a783          	lw	a5,0(a3)
    800029e0:	0017879b          	addiw	a5,a5,1
    800029e4:	00f6a023          	sw	a5,0(a3)
    800029e8:	fd1ff06f          	j	800029b8 <_Z5bodyBPv+0x1c>
        for(int k=0;k<10000;k++){
    800029ec:	0016061b          	addiw	a2,a2,1
    800029f0:	000027b7          	lui	a5,0x2
    800029f4:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    800029f8:	00c7c663          	blt	a5,a2,80002a04 <_Z5bodyBPv+0x68>
            for(int m=0;m<1000;m++){
    800029fc:	00000713          	li	a4,0
    80002a00:	fbdff06f          	j	800029bc <_Z5bodyBPv+0x20>
    for(int i=0;i<10;i++){
    80002a04:	0014849b          	addiw	s1,s1,1
    80002a08:	00900793          	li	a5,9
    80002a0c:	0297c263          	blt	a5,s1,80002a30 <_Z5bodyBPv+0x94>
        putc(str[i]);
    80002a10:	0000a797          	auipc	a5,0xa
    80002a14:	00878793          	addi	a5,a5,8 # 8000ca18 <idleAlive>
    80002a18:	009787b3          	add	a5,a5,s1
    80002a1c:	0087c503          	lbu	a0,8(a5)
    80002a20:	fffff097          	auipc	ra,0xfffff
    80002a24:	b90080e7          	jalr	-1136(ra) # 800015b0 <_Z4putcc>
        for(int k=0;k<10000;k++){
    80002a28:	00000613          	li	a2,0
    80002a2c:	fc5ff06f          	j	800029f0 <_Z5bodyBPv+0x54>
        }
        int wait (){
            return sem_wait(myHandle);
        }
        int signal (){
            return sem_signal(myHandle);
    80002a30:	0000a797          	auipc	a5,0xa
    80002a34:	3587b783          	ld	a5,856(a5) # 8000cd88 <semTest>
    80002a38:	0087b503          	ld	a0,8(a5)
    80002a3c:	fffff097          	auipc	ra,0xfffff
    80002a40:	ac4080e7          	jalr	-1340(ra) # 80001500 <_Z10sem_signalP5sem_s>
            }
        }
    }
    semTest->signal();
}
    80002a44:	01813083          	ld	ra,24(sp)
    80002a48:	01013403          	ld	s0,16(sp)
    80002a4c:	00813483          	ld	s1,8(sp)
    80002a50:	02010113          	addi	sp,sp,32
    80002a54:	00008067          	ret

0000000080002a58 <main>:
        putc(c++);
    }
};

int main()
{
    80002a58:	fd010113          	addi	sp,sp,-48
    80002a5c:	02113423          	sd	ra,40(sp)
    80002a60:	02813023          	sd	s0,32(sp)
    80002a64:	00913c23          	sd	s1,24(sp)
    80002a68:	01213823          	sd	s2,16(sp)
    80002a6c:	03010413          	addi	s0,sp,48
    char* buddy_start = (char*)HEAP_START_ADDR;
    80002a70:	0000a797          	auipc	a5,0xa
    80002a74:	1b87b783          	ld	a5,440(a5) # 8000cc28 <_GLOBAL_OFFSET_TABLE_+0x18>
    80002a78:	0007b503          	ld	a0,0(a5)
    uint64 memory_size = ((char *)HEAP_END_ADDR-(char *)HEAP_START_ADDR);
    80002a7c:	0000a917          	auipc	s2,0xa
    80002a80:	1d493903          	ld	s2,468(s2) # 8000cc50 <_GLOBAL_OFFSET_TABLE_+0x40>
    80002a84:	00093583          	ld	a1,0(s2)
    80002a88:	40a585b3          	sub	a1,a1,a0
    uint64 buddy_size_in_blocks = (memory_size/8)/BLOCK_SIZE+1;
    80002a8c:	00f5d593          	srli	a1,a1,0xf
    80002a90:	00158593          	addi	a1,a1,1
    char* buddy_end = buddy_start+buddy_size_in_blocks*BLOCK_SIZE;
    80002a94:	00c59493          	slli	s1,a1,0xc
    80002a98:	009504b3          	add	s1,a0,s1
    kmem_init(buddy_start,buddy_size_in_blocks);
    80002a9c:	0005859b          	sext.w	a1,a1
    80002aa0:	00001097          	auipc	ra,0x1
    80002aa4:	f00080e7          	jalr	-256(ra) # 800039a0 <_Z9kmem_initPvi>
    kern_mem_init((void*)buddy_end, (void*)HEAP_END_ADDR);
    80002aa8:	00093583          	ld	a1,0(s2)
    80002aac:	00048513          	mv	a0,s1
    80002ab0:	00000097          	auipc	ra,0x0
    80002ab4:	ad0080e7          	jalr	-1328(ra) # 80002580 <_Z13kern_mem_initPvS_>
    kern_thread_init();
    80002ab8:	00000097          	auipc	ra,0x0
    80002abc:	1f8080e7          	jalr	504(ra) # 80002cb0 <_Z16kern_thread_initv>

    kern_interrupt_init();
    80002ac0:	00001097          	auipc	ra,0x1
    80002ac4:	a80080e7          	jalr	-1408(ra) # 80003540 <_Z19kern_interrupt_initv>
    kern_sem_init();
    80002ac8:	00001097          	auipc	ra,0x1
    80002acc:	828080e7          	jalr	-2008(ra) # 800032f0 <_Z13kern_sem_initv>
    kern_console_init();
    80002ad0:	00000097          	auipc	ra,0x0
    80002ad4:	b1c080e7          	jalr	-1252(ra) # 800025ec <_Z17kern_console_initv>

    Thread* thrIdle = new Thread(&bodyIdle,0);
    80002ad8:	02000513          	li	a0,32
    80002adc:	00000097          	auipc	ra,0x0
    80002ae0:	104080e7          	jalr	260(ra) # 80002be0 <_Znwm>
        {
    80002ae4:	0000a797          	auipc	a5,0xa
    80002ae8:	f5c78793          	addi	a5,a5,-164 # 8000ca40 <_ZTV6Thread+0x10>
    80002aec:	00f53023          	sd	a5,0(a0)
            this->body=body;
    80002af0:	00000597          	auipc	a1,0x0
    80002af4:	da458593          	addi	a1,a1,-604 # 80002894 <_Z8bodyIdlePv>
    80002af8:	00b53823          	sd	a1,16(a0)
            this->arg=arg;
    80002afc:	00053c23          	sd	zero,24(a0)
    80002b00:	fca43c23          	sd	a0,-40(s0)
            else return thread_create(&myHandle,body,arg);
    80002b04:	00000613          	li	a2,0
    80002b08:	00850513          	addi	a0,a0,8
    80002b0c:	ffffe097          	auipc	ra,0xffffe
    80002b10:	7f4080e7          	jalr	2036(ra) # 80001300 <_Z13thread_createPP8thread_sPFvPvES2_>
    thrIdle->start();

    printf("Printf proba %d valjda radi %x, %p\n", &thrIdle, &thrIdle, &thrIdle);
    80002b14:	fd840593          	addi	a1,s0,-40
    80002b18:	00058693          	mv	a3,a1
    80002b1c:	00058613          	mv	a2,a1
    80002b20:	00007517          	auipc	a0,0x7
    80002b24:	66050513          	addi	a0,a0,1632 # 8000a180 <CONSOLE_STATUS+0x170>
    80002b28:	fffff097          	auipc	ra,0xfffff
    80002b2c:	718080e7          	jalr	1816(ra) # 80002240 <_Z6printfPKcz>
*/
    /*char x = getc();
    x=getc();
    x++;
    putc(x);*/
    userMain();
    80002b30:	00004097          	auipc	ra,0x4
    80002b34:	1ec080e7          	jalr	492(ra) # 80006d1c <_Z8userMainv>
    }

    pt->terminate();
    pt2->terminate();
    */
    idleAlive=0;
    80002b38:	0000a797          	auipc	a5,0xa
    80002b3c:	ee07a023          	sw	zero,-288(a5) # 8000ca18 <idleAlive>
    return 0;
    80002b40:	00000513          	li	a0,0
    80002b44:	02813083          	ld	ra,40(sp)
    80002b48:	02013403          	ld	s0,32(sp)
    80002b4c:	01813483          	ld	s1,24(sp)
    80002b50:	01013903          	ld	s2,16(sp)
    80002b54:	03010113          	addi	sp,sp,48
    80002b58:	00008067          	ret

0000000080002b5c <_ZN6ThreadD1Ev>:
        virtual ~Thread (){
    80002b5c:	ff010113          	addi	sp,sp,-16
    80002b60:	00813423          	sd	s0,8(sp)
    80002b64:	01010413          	addi	s0,sp,16
        }
    80002b68:	00813403          	ld	s0,8(sp)
    80002b6c:	01010113          	addi	sp,sp,16
    80002b70:	00008067          	ret

0000000080002b74 <_ZN6Thread3runEv>:
        virtual void run () {}
    80002b74:	ff010113          	addi	sp,sp,-16
    80002b78:	00813423          	sd	s0,8(sp)
    80002b7c:	01010413          	addi	s0,sp,16
    80002b80:	00813403          	ld	s0,8(sp)
    80002b84:	01010113          	addi	sp,sp,16
    80002b88:	00008067          	ret

0000000080002b8c <_ZN6Thread11threadEntryEPv>:
        static void threadEntry(void* arg){
    80002b8c:	ff010113          	addi	sp,sp,-16
    80002b90:	00113423          	sd	ra,8(sp)
    80002b94:	00813023          	sd	s0,0(sp)
    80002b98:	01010413          	addi	s0,sp,16
            self->run();
    80002b9c:	00053783          	ld	a5,0(a0)
    80002ba0:	0107b783          	ld	a5,16(a5)
    80002ba4:	000780e7          	jalr	a5
        }
    80002ba8:	00813083          	ld	ra,8(sp)
    80002bac:	00013403          	ld	s0,0(sp)
    80002bb0:	01010113          	addi	sp,sp,16
    80002bb4:	00008067          	ret

0000000080002bb8 <_ZN6ThreadD0Ev>:
        virtual ~Thread (){
    80002bb8:	ff010113          	addi	sp,sp,-16
    80002bbc:	00113423          	sd	ra,8(sp)
    80002bc0:	00813023          	sd	s0,0(sp)
    80002bc4:	01010413          	addi	s0,sp,16
        }
    80002bc8:	00000097          	auipc	ra,0x0
    80002bcc:	040080e7          	jalr	64(ra) # 80002c08 <_ZdlPv>
    80002bd0:	00813083          	ld	ra,8(sp)
    80002bd4:	00013403          	ld	s0,0(sp)
    80002bd8:	01010113          	addi	sp,sp,16
    80002bdc:	00008067          	ret

0000000080002be0 <_Znwm>:
// Created by os on 6/7/23.
//
#include "../h/syscall_cpp.hpp"


void* operator new(size_t size) {
    80002be0:	ff010113          	addi	sp,sp,-16
    80002be4:	00113423          	sd	ra,8(sp)
    80002be8:	00813023          	sd	s0,0(sp)
    80002bec:	01010413          	addi	s0,sp,16
    void* ptr = mem_alloc(size);
    80002bf0:	ffffe097          	auipc	ra,0xffffe
    80002bf4:	690080e7          	jalr	1680(ra) # 80001280 <_Z9mem_allocm>
    return ptr;
}
    80002bf8:	00813083          	ld	ra,8(sp)
    80002bfc:	00013403          	ld	s0,0(sp)
    80002c00:	01010113          	addi	sp,sp,16
    80002c04:	00008067          	ret

0000000080002c08 <_ZdlPv>:

void operator delete(void* ptr) {
    80002c08:	ff010113          	addi	sp,sp,-16
    80002c0c:	00113423          	sd	ra,8(sp)
    80002c10:	00813023          	sd	s0,0(sp)
    80002c14:	01010413          	addi	s0,sp,16
    mem_free(ptr);
    80002c18:	ffffe097          	auipc	ra,0xffffe
    80002c1c:	6a8080e7          	jalr	1704(ra) # 800012c0 <_Z8mem_freePv>
}
    80002c20:	00813083          	ld	ra,8(sp)
    80002c24:	00013403          	ld	s0,0(sp)
    80002c28:	01010113          	addi	sp,sp,16
    80002c2c:	00008067          	ret

0000000080002c30 <_Z16kern_thread_ctorPv>:
    thread_t sleeping_head;
} scheduler;

void kern_thread_yield();

void kern_thread_ctor(void* addr){
    80002c30:	ff010113          	addi	sp,sp,-16
    80002c34:	00813423          	sd	s0,8(sp)
    80002c38:	01010413          	addi	s0,sp,16
    thread_t t = (thread_t)addr;
    t->status=UNUSED;
    80002c3c:	04052823          	sw	zero,80(a0)
    t->stack_space=0;
    80002c40:	04053023          	sd	zero,64(a0)
    t->arg=0;
    80002c44:	02053023          	sd	zero,32(a0)
    t->joined_tid=-1;
    80002c48:	fff00793          	li	a5,-1
    80002c4c:	02f53423          	sd	a5,40(a0)
    t->timeslice=DEFAULT_TIME_SLICE;
    80002c50:	00200793          	li	a5,2
    80002c54:	02f53823          	sd	a5,48(a0)
    t->body=0;
    80002c58:	00053c23          	sd	zero,24(a0)
    t->stack_space = 0;
    t->sp =0;
    80002c5c:	00053423          	sd	zero,8(a0)
    t->ra=0;
    80002c60:	00053023          	sd	zero,0(a0)
    t->sem_next=0;
    80002c64:	04053c23          	sd	zero,88(a0)
    t->next_thread=0;
    80002c68:	06053023          	sd	zero,96(a0)
    t->mailbox=0;
    80002c6c:	04053423          	sd	zero,72(a0)
}
    80002c70:	00813403          	ld	s0,8(sp)
    80002c74:	01010113          	addi	sp,sp,16
    80002c78:	00008067          	ret

0000000080002c7c <_Z16kern_thread_dtorPv>:

void kern_thread_dtor(void* addr)
{
    80002c7c:	ff010113          	addi	sp,sp,-16
    80002c80:	00113423          	sd	ra,8(sp)
    80002c84:	00813023          	sd	s0,0(sp)
    80002c88:	01010413          	addi	s0,sp,16
    thread_t t = (thread_t)addr;
    printf("\n Destroying thread id=%d\n",t->id);
    80002c8c:	01053583          	ld	a1,16(a0)
    80002c90:	00007517          	auipc	a0,0x7
    80002c94:	51850513          	addi	a0,a0,1304 # 8000a1a8 <CONSOLE_STATUS+0x198>
    80002c98:	fffff097          	auipc	ra,0xfffff
    80002c9c:	5a8080e7          	jalr	1448(ra) # 80002240 <_Z6printfPKcz>
}
    80002ca0:	00813083          	ld	ra,8(sp)
    80002ca4:	00013403          	ld	s0,0(sp)
    80002ca8:	01010113          	addi	sp,sp,16
    80002cac:	00008067          	ret

0000000080002cb0 <_Z16kern_thread_initv>:
void kern_thread_init()
{
    80002cb0:	fe010113          	addi	sp,sp,-32
    80002cb4:	00113c23          	sd	ra,24(sp)
    80002cb8:	00813823          	sd	s0,16(sp)
    80002cbc:	00913423          	sd	s1,8(sp)
    80002cc0:	02010413          	addi	s0,sp,32
    threads_cache=kmem_cache_create("thread cache", sizeof(thread_s),kern_thread_ctor,kern_thread_dtor);
    80002cc4:	00000697          	auipc	a3,0x0
    80002cc8:	fb868693          	addi	a3,a3,-72 # 80002c7c <_Z16kern_thread_dtorPv>
    80002ccc:	00000617          	auipc	a2,0x0
    80002cd0:	f6460613          	addi	a2,a2,-156 # 80002c30 <_Z16kern_thread_ctorPv>
    80002cd4:	06800593          	li	a1,104
    80002cd8:	00007517          	auipc	a0,0x7
    80002cdc:	4f050513          	addi	a0,a0,1264 # 8000a1c8 <CONSOLE_STATUS+0x1b8>
    80002ce0:	00001097          	auipc	ra,0x1
    80002ce4:	e68080e7          	jalr	-408(ra) # 80003b48 <_Z17kmem_cache_createPKcmPFvPvES3_>
    80002ce8:	0000a497          	auipc	s1,0xa
    80002cec:	0a848493          	addi	s1,s1,168 # 8000cd90 <threads_cache>
    80002cf0:	00a4b023          	sd	a0,0(s1)
    id=0;
    80002cf4:	0004a423          	sw	zero,8(s1)
    for (int i=0;i<MAX_THREADS;i++){
        kthreads[i].status=UNUSED;
    }
    */
    //set main thread
    thread_t main_thread = (thread_t) kmem_cache_alloc(threads_cache);
    80002cf8:	00001097          	auipc	ra,0x1
    80002cfc:	514080e7          	jalr	1300(ra) # 8000420c <_Z16kmem_cache_allocP12kmem_cache_s>
    main_thread->status=RUNNING;
    80002d00:	00100793          	li	a5,1
    80002d04:	04f52823          	sw	a5,80(a0)
    main_thread->id=0;
    80002d08:	00053823          	sd	zero,16(a0)
    main_thread->timeslice=DEFAULT_TIME_SLICE+2;
    80002d0c:	00400793          	li	a5,4
    80002d10:	02f53823          	sd	a5,48(a0)
    main_thread->endTime=0;
    80002d14:	02053c23          	sd	zero,56(a0)
    main_thread->next_thread=0;
    80002d18:	06053023          	sd	zero,96(a0)
    running=main_thread;
    80002d1c:	00a4b823          	sd	a0,16(s1)
    scheduler.ready_head=0;
    80002d20:	0004bc23          	sd	zero,24(s1)
    scheduler.ready_tail=0;
    80002d24:	0204b023          	sd	zero,32(s1)
    scheduler.joined_head=0;
    80002d28:	0204b423          	sd	zero,40(s1)
    scheduler.sleeping_head=0;
    80002d2c:	0204b823          	sd	zero,48(s1)
}
    80002d30:	01813083          	ld	ra,24(sp)
    80002d34:	01013403          	ld	s0,16(sp)
    80002d38:	00813483          	ld	s1,8(sp)
    80002d3c:	02010113          	addi	sp,sp,32
    80002d40:	00008067          	ret

0000000080002d44 <_Z18kern_scheduler_putP8thread_s>:

void kern_scheduler_put(thread_t t)
{
    80002d44:	ff010113          	addi	sp,sp,-16
    80002d48:	00813423          	sd	s0,8(sp)
    80002d4c:	01010413          	addi	s0,sp,16
    t->status=READY;
    80002d50:	00200793          	li	a5,2
    80002d54:	04f52823          	sw	a5,80(a0)
    if(scheduler.ready_tail==0){
    80002d58:	0000a797          	auipc	a5,0xa
    80002d5c:	0587b783          	ld	a5,88(a5) # 8000cdb0 <scheduler+0x8>
    80002d60:	02078063          	beqz	a5,80002d80 <_Z18kern_scheduler_putP8thread_s+0x3c>
        scheduler.ready_tail=t;
        scheduler.ready_head=t;
    } else{
        scheduler.ready_tail->next_thread=t;
    80002d64:	06a7b023          	sd	a0,96(a5)
        scheduler.ready_tail=t;
    80002d68:	0000a797          	auipc	a5,0xa
    80002d6c:	04a7b423          	sd	a0,72(a5) # 8000cdb0 <scheduler+0x8>
    }
    t->next_thread=0;
    80002d70:	06053023          	sd	zero,96(a0)
}
    80002d74:	00813403          	ld	s0,8(sp)
    80002d78:	01010113          	addi	sp,sp,16
    80002d7c:	00008067          	ret
        scheduler.ready_tail=t;
    80002d80:	0000a797          	auipc	a5,0xa
    80002d84:	01078793          	addi	a5,a5,16 # 8000cd90 <threads_cache>
    80002d88:	02a7b023          	sd	a0,32(a5)
        scheduler.ready_head=t;
    80002d8c:	00a7bc23          	sd	a0,24(a5)
    80002d90:	fe1ff06f          	j	80002d70 <_Z18kern_scheduler_putP8thread_s+0x2c>

0000000080002d94 <_Z18kern_scheduler_getv>:

thread_t kern_scheduler_get()
{
    80002d94:	ff010113          	addi	sp,sp,-16
    80002d98:	00813423          	sd	s0,8(sp)
    80002d9c:	01010413          	addi	s0,sp,16
    if(scheduler.ready_head==0) return 0;
    80002da0:	0000a517          	auipc	a0,0xa
    80002da4:	00853503          	ld	a0,8(a0) # 8000cda8 <scheduler>
    80002da8:	02050063          	beqz	a0,80002dc8 <_Z18kern_scheduler_getv+0x34>
    thread_t t = scheduler.ready_head;
    scheduler.ready_head=scheduler.ready_head->next_thread;
    80002dac:	06053703          	ld	a4,96(a0)
    80002db0:	0000a797          	auipc	a5,0xa
    80002db4:	fe078793          	addi	a5,a5,-32 # 8000cd90 <threads_cache>
    80002db8:	00e7bc23          	sd	a4,24(a5)
    if(scheduler.ready_tail==t) scheduler.ready_tail=0;
    80002dbc:	0207b783          	ld	a5,32(a5)
    80002dc0:	00f50a63          	beq	a0,a5,80002dd4 <_Z18kern_scheduler_getv+0x40>
    t->next_thread=0;
    80002dc4:	06053023          	sd	zero,96(a0)
    return t;
}
    80002dc8:	00813403          	ld	s0,8(sp)
    80002dcc:	01010113          	addi	sp,sp,16
    80002dd0:	00008067          	ret
    if(scheduler.ready_tail==t) scheduler.ready_tail=0;
    80002dd4:	0000a797          	auipc	a5,0xa
    80002dd8:	fc07be23          	sd	zero,-36(a5) # 8000cdb0 <scheduler+0x8>
    80002ddc:	fe9ff06f          	j	80002dc4 <_Z18kern_scheduler_getv+0x30>

0000000080002de0 <_Z10popSppSpiev>:
    w_sepc(v_sepc);
}

//samo izlazi iz kernela i vraca se odakle je pozvana
void popSppSpie()
{
    80002de0:	ff010113          	addi	sp,sp,-16
    80002de4:	00813423          	sd	s0,8(sp)
    80002de8:	01010413          	addi	s0,sp,16
    __asm__ volatile("csrw sepc, ra"); //ovde dodaj izlazak iz privilegovanog moda
    80002dec:	14109073          	csrw	sepc,ra
    __asm__ volatile("csrc sstatus, %[mask]" : : [mask] "r"(1 << 8));
    80002df0:	10000793          	li	a5,256
    80002df4:	1007b073          	csrc	sstatus,a5
    __asm__ volatile("sret");
    80002df8:	10200073          	sret
}
    80002dfc:	00813403          	ld	s0,8(sp)
    80002e00:	01010113          	addi	sp,sp,16
    80002e04:	00008067          	ret

0000000080002e08 <_Z19kern_thread_wrapperv>:
        contextSwitch(old,running);
    }
}

void kern_thread_wrapper()
{
    80002e08:	ff010113          	addi	sp,sp,-16
    80002e0c:	00113423          	sd	ra,8(sp)
    80002e10:	00813023          	sd	s0,0(sp)
    80002e14:	01010413          	addi	s0,sp,16
    popSppSpie();
    80002e18:	00000097          	auipc	ra,0x0
    80002e1c:	fc8080e7          	jalr	-56(ra) # 80002de0 <_Z10popSppSpiev>
    running->body(running->arg);
    80002e20:	0000a797          	auipc	a5,0xa
    80002e24:	f807b783          	ld	a5,-128(a5) # 8000cda0 <running>
    80002e28:	0187b703          	ld	a4,24(a5)
    80002e2c:	0207b503          	ld	a0,32(a5)
    80002e30:	000700e7          	jalr	a4
    running->joined_tid=-1;
    for(int i=0;i<MAX_THREADS;i++){
        if(kthreads[i].status==JOINED && kthreads[i].joined_tid==running->id) kthreads[i].status=READY;
    }
*/
    thread_exit();
    80002e34:	ffffe097          	auipc	ra,0xffffe
    80002e38:	580080e7          	jalr	1408(ra) # 800013b4 <_Z11thread_exitv>
}
    80002e3c:	00813083          	ld	ra,8(sp)
    80002e40:	00013403          	ld	s0,0(sp)
    80002e44:	01010113          	addi	sp,sp,16
    80002e48:	00008067          	ret

0000000080002e4c <_Z17kern_thread_yieldv>:
{
    80002e4c:	fe010113          	addi	sp,sp,-32
    80002e50:	00113c23          	sd	ra,24(sp)
    80002e54:	00813823          	sd	s0,16(sp)
    80002e58:	00913423          	sd	s1,8(sp)
    80002e5c:	01213023          	sd	s2,0(sp)
    80002e60:	02010413          	addi	s0,sp,32
    thread_t old = running;
    80002e64:	0000a917          	auipc	s2,0xa
    80002e68:	f2c90913          	addi	s2,s2,-212 # 8000cd90 <threads_cache>
    80002e6c:	01093483          	ld	s1,16(s2)
    running=kern_scheduler_get();
    80002e70:	00000097          	auipc	ra,0x0
    80002e74:	f24080e7          	jalr	-220(ra) # 80002d94 <_Z18kern_scheduler_getv>
    80002e78:	00a93823          	sd	a0,16(s2)
    if(old!=running){
    80002e7c:	04950663          	beq	a0,s1,80002ec8 <_Z17kern_thread_yieldv+0x7c>
    80002e80:	00050593          	mv	a1,a0
        running->status=RUNNING;
    80002e84:	00100793          	li	a5,1
    80002e88:	04f52823          	sw	a5,80(a0)
        if(old->status==RUNNING) old->status=READY;
    80002e8c:	0504a703          	lw	a4,80(s1)
    80002e90:	00100793          	li	a5,1
    80002e94:	02f70463          	beq	a4,a5,80002ebc <_Z17kern_thread_yieldv+0x70>
        contextSwitch(old,running);
    80002e98:	00048513          	mv	a0,s1
    80002e9c:	ffffe097          	auipc	ra,0xffffe
    80002ea0:	3d0080e7          	jalr	976(ra) # 8000126c <contextSwitch>
}
    80002ea4:	01813083          	ld	ra,24(sp)
    80002ea8:	01013403          	ld	s0,16(sp)
    80002eac:	00813483          	ld	s1,8(sp)
    80002eb0:	00013903          	ld	s2,0(sp)
    80002eb4:	02010113          	addi	sp,sp,32
    80002eb8:	00008067          	ret
        if(old->status==RUNNING) old->status=READY;
    80002ebc:	00200793          	li	a5,2
    80002ec0:	04f4a823          	sw	a5,80(s1)
    80002ec4:	fd5ff06f          	j	80002e98 <_Z17kern_thread_yieldv+0x4c>
        old->status=RUNNING;
    80002ec8:	00100793          	li	a5,1
    80002ecc:	04f4a823          	sw	a5,80(s1)
}
    80002ed0:	fd5ff06f          	j	80002ea4 <_Z17kern_thread_yieldv+0x58>

0000000080002ed4 <_Z20kern_thread_dispatchv>:
{
    80002ed4:	fd010113          	addi	sp,sp,-48
    80002ed8:	02113423          	sd	ra,40(sp)
    80002edc:	02813023          	sd	s0,32(sp)
    80002ee0:	03010413          	addi	s0,sp,48
    kern_scheduler_put(running);
    80002ee4:	0000a517          	auipc	a0,0xa
    80002ee8:	ebc53503          	ld	a0,-324(a0) # 8000cda0 <running>
    80002eec:	00000097          	auipc	ra,0x0
    80002ef0:	e58080e7          	jalr	-424(ra) # 80002d44 <_Z18kern_scheduler_putP8thread_s>
}

inline uint64 r_sstatus()
{
    uint64 volatile sstatus;
    __asm__ volatile ("csrr %[sstatus], sstatus" : [sstatus] "=r"(sstatus));
    80002ef4:	100027f3          	csrr	a5,sstatus
    80002ef8:	fcf43c23          	sd	a5,-40(s0)
    return sstatus;
    80002efc:	fd843783          	ld	a5,-40(s0)
    uint64 volatile sstatus = r_sstatus();
    80002f00:	fef43423          	sd	a5,-24(s0)
    __asm__ volatile ("csrr %[sepc], sepc" : [sepc] "=r"(sepc));
    80002f04:	141027f3          	csrr	a5,sepc
    80002f08:	fcf43823          	sd	a5,-48(s0)
    return sepc;
    80002f0c:	fd043783          	ld	a5,-48(s0)
    uint64 volatile v_sepc = r_sepc();
    80002f10:	fef43023          	sd	a5,-32(s0)
    kern_thread_yield();
    80002f14:	00000097          	auipc	ra,0x0
    80002f18:	f38080e7          	jalr	-200(ra) # 80002e4c <_Z17kern_thread_yieldv>
    w_sstatus(sstatus);
    80002f1c:	fe843783          	ld	a5,-24(s0)
}

inline void w_sstatus(uint64 sstatus)
{
    __asm__ volatile ("csrw sstatus, %[sstatus]" : : [sstatus] "r"(sstatus));
    80002f20:	10079073          	csrw	sstatus,a5
    w_sepc(v_sepc);
    80002f24:	fe043783          	ld	a5,-32(s0)
    __asm__ volatile ("csrw sepc, %[sepc]" : : [sepc] "r"(sepc));
    80002f28:	14179073          	csrw	sepc,a5
}
    80002f2c:	02813083          	ld	ra,40(sp)
    80002f30:	02013403          	ld	s0,32(sp)
    80002f34:	03010113          	addi	sp,sp,48
    80002f38:	00008067          	ret

0000000080002f3c <_Z25kern_thread_resume_joinedm>:
{
    80002f3c:	fd010113          	addi	sp,sp,-48
    80002f40:	02113423          	sd	ra,40(sp)
    80002f44:	02813023          	sd	s0,32(sp)
    80002f48:	00913c23          	sd	s1,24(sp)
    80002f4c:	01213823          	sd	s2,16(sp)
    80002f50:	01313423          	sd	s3,8(sp)
    80002f54:	03010413          	addi	s0,sp,48
    80002f58:	00050993          	mv	s3,a0
    thread_t curr = scheduler.joined_head;
    80002f5c:	0000a517          	auipc	a0,0xa
    80002f60:	e5c53503          	ld	a0,-420(a0) # 8000cdb8 <scheduler+0x10>
    thread_t prev = 0;
    80002f64:	00000913          	li	s2,0
    80002f68:	00c0006f          	j	80002f74 <_Z25kern_thread_resume_joinedm+0x38>
            prev=curr;
    80002f6c:	00050913          	mv	s2,a0
    80002f70:	00048513          	mv	a0,s1
    while (curr!=0){
    80002f74:	02050863          	beqz	a0,80002fa4 <_Z25kern_thread_resume_joinedm+0x68>
        next=curr->next_thread;
    80002f78:	06053483          	ld	s1,96(a0)
        if(curr->joined_tid<=joined_tid){
    80002f7c:	02853783          	ld	a5,40(a0)
    80002f80:	fef9e6e3          	bltu	s3,a5,80002f6c <_Z25kern_thread_resume_joinedm+0x30>
            if(prev!=0){
    80002f84:	00090a63          	beqz	s2,80002f98 <_Z25kern_thread_resume_joinedm+0x5c>
                prev->next_thread=curr->next_thread;
    80002f88:	06993023          	sd	s1,96(s2)
            kern_scheduler_put(curr);
    80002f8c:	00000097          	auipc	ra,0x0
    80002f90:	db8080e7          	jalr	-584(ra) # 80002d44 <_Z18kern_scheduler_putP8thread_s>
    80002f94:	fddff06f          	j	80002f70 <_Z25kern_thread_resume_joinedm+0x34>
                scheduler.joined_head=curr->next_thread;
    80002f98:	0000a797          	auipc	a5,0xa
    80002f9c:	e297b023          	sd	s1,-480(a5) # 8000cdb8 <scheduler+0x10>
    80002fa0:	fedff06f          	j	80002f8c <_Z25kern_thread_resume_joinedm+0x50>
}
    80002fa4:	02813083          	ld	ra,40(sp)
    80002fa8:	02013403          	ld	s0,32(sp)
    80002fac:	01813483          	ld	s1,24(sp)
    80002fb0:	01013903          	ld	s2,16(sp)
    80002fb4:	00813983          	ld	s3,8(sp)
    80002fb8:	03010113          	addi	sp,sp,48
    80002fbc:	00008067          	ret

0000000080002fc0 <_Z23kern_thread_end_runningv>:
{
    80002fc0:	fe010113          	addi	sp,sp,-32
    80002fc4:	00113c23          	sd	ra,24(sp)
    80002fc8:	00813823          	sd	s0,16(sp)
    80002fcc:	00913423          	sd	s1,8(sp)
    80002fd0:	01213023          	sd	s2,0(sp)
    80002fd4:	02010413          	addi	s0,sp,32
    thread_t old = running;
    80002fd8:	0000a917          	auipc	s2,0xa
    80002fdc:	db890913          	addi	s2,s2,-584 # 8000cd90 <threads_cache>
    80002fe0:	01093483          	ld	s1,16(s2)
    old->status=UNUSED;
    80002fe4:	0404a823          	sw	zero,80(s1)
    kern_thread_resume_joined(old->id);
    80002fe8:	0104b503          	ld	a0,16(s1)
    80002fec:	00000097          	auipc	ra,0x0
    80002ff0:	f50080e7          	jalr	-176(ra) # 80002f3c <_Z25kern_thread_resume_joinedm>
    running=kern_scheduler_get();
    80002ff4:	00000097          	auipc	ra,0x0
    80002ff8:	da0080e7          	jalr	-608(ra) # 80002d94 <_Z18kern_scheduler_getv>
    80002ffc:	00a93823          	sd	a0,16(s2)
    if(old->stack_space!=0) kern_mem_free((void*)old->stack_space);
    80003000:	0404b503          	ld	a0,64(s1)
    80003004:	04051463          	bnez	a0,8000304c <_Z23kern_thread_end_runningv+0x8c>
    kmem_cache_free(threads_cache,old);
    80003008:	0000a917          	auipc	s2,0xa
    8000300c:	d8890913          	addi	s2,s2,-632 # 8000cd90 <threads_cache>
    80003010:	00048593          	mv	a1,s1
    80003014:	00093503          	ld	a0,0(s2)
    80003018:	00001097          	auipc	ra,0x1
    8000301c:	230080e7          	jalr	560(ra) # 80004248 <_Z15kmem_cache_freeP12kmem_cache_sPv>
    if(old!=running){
    80003020:	01093583          	ld	a1,16(s2)
    80003024:	00958863          	beq	a1,s1,80003034 <_Z23kern_thread_end_runningv+0x74>
        contextSwitch(old,running);
    80003028:	00048513          	mv	a0,s1
    8000302c:	ffffe097          	auipc	ra,0xffffe
    80003030:	240080e7          	jalr	576(ra) # 8000126c <contextSwitch>
}
    80003034:	01813083          	ld	ra,24(sp)
    80003038:	01013403          	ld	s0,16(sp)
    8000303c:	00813483          	ld	s1,8(sp)
    80003040:	00013903          	ld	s2,0(sp)
    80003044:	02010113          	addi	sp,sp,32
    80003048:	00008067          	ret
    if(old->stack_space!=0) kern_mem_free((void*)old->stack_space);
    8000304c:	fffff097          	auipc	ra,0xfffff
    80003050:	484080e7          	jalr	1156(ra) # 800024d0 <_Z13kern_mem_freePv>
    80003054:	fb5ff06f          	j	80003008 <_Z23kern_thread_end_runningv+0x48>

0000000080003058 <_Z18kern_thread_createPP8thread_sPFvPvES2_S2_>:

int kern_thread_create(thread_t* handle, void(*start_routine)(void*), void* arg, void* stack_space)
{
    80003058:	fd010113          	addi	sp,sp,-48
    8000305c:	02113423          	sd	ra,40(sp)
    80003060:	02813023          	sd	s0,32(sp)
    80003064:	00913c23          	sd	s1,24(sp)
    80003068:	01213823          	sd	s2,16(sp)
    8000306c:	01313423          	sd	s3,8(sp)
    80003070:	01413023          	sd	s4,0(sp)
    80003074:	03010413          	addi	s0,sp,48
    80003078:	00050913          	mv	s2,a0
    8000307c:	00058a13          	mv	s4,a1
    80003080:	00060993          	mv	s3,a2
    80003084:	00068493          	mv	s1,a3
    *handle=0;
    80003088:	00053023          	sd	zero,0(a0)
    thread_t t= (thread_t)kmem_cache_alloc(threads_cache);
    8000308c:	0000a517          	auipc	a0,0xa
    80003090:	d0453503          	ld	a0,-764(a0) # 8000cd90 <threads_cache>
    80003094:	00001097          	auipc	ra,0x1
    80003098:	178080e7          	jalr	376(ra) # 8000420c <_Z16kmem_cache_allocP12kmem_cache_s>
    if(t==0) return -1;
    8000309c:	08050c63          	beqz	a0,80003134 <_Z18kern_thread_createPP8thread_sPFvPvES2_S2_+0xdc>
    *handle=t;
    800030a0:	00a93023          	sd	a0,0(s2)

    t->id=++id;
    800030a4:	0000a717          	auipc	a4,0xa
    800030a8:	cec70713          	addi	a4,a4,-788 # 8000cd90 <threads_cache>
    800030ac:	00872783          	lw	a5,8(a4)
    800030b0:	0017879b          	addiw	a5,a5,1
    800030b4:	0007869b          	sext.w	a3,a5
    800030b8:	00f72423          	sw	a5,8(a4)
    800030bc:	00d53823          	sd	a3,16(a0)
    t->status=READY;
    800030c0:	00200793          	li	a5,2
    800030c4:	04f52823          	sw	a5,80(a0)
    t->arg=arg;
    800030c8:	03353023          	sd	s3,32(a0)
    t->joined_tid=-1;
    800030cc:	fff00793          	li	a5,-1
    800030d0:	02f53423          	sd	a5,40(a0)
    t->timeslice=DEFAULT_TIME_SLICE;
    800030d4:	00200793          	li	a5,2
    800030d8:	02f53823          	sd	a5,48(a0)
    t->body=start_routine;
    800030dc:	01453c23          	sd	s4,24(a0)
    t->stack_space = ((uint64)stack_space);
    800030e0:	04953023          	sd	s1,64(a0)
    t->sp = t->stack_space+(DEFAULT_STACK_SIZE);
    800030e4:	000016b7          	lui	a3,0x1
    800030e8:	00d484b3          	add	s1,s1,a3
    800030ec:	00953423          	sd	s1,8(a0)
    t->ra=(uint64) &kern_thread_wrapper;
    800030f0:	00000797          	auipc	a5,0x0
    800030f4:	d1878793          	addi	a5,a5,-744 # 80002e08 <_Z19kern_thread_wrapperv>
    800030f8:	00f53023          	sd	a5,0(a0)
    t->sem_next=0;
    800030fc:	04053c23          	sd	zero,88(a0)
    t->next_thread=0;
    80003100:	06053023          	sd	zero,96(a0)
    t->mailbox=0;
    80003104:	04053423          	sd	zero,72(a0)
    kern_scheduler_put(t);
    80003108:	00000097          	auipc	ra,0x0
    8000310c:	c3c080e7          	jalr	-964(ra) # 80002d44 <_Z18kern_scheduler_putP8thread_s>

    return 0;
    80003110:	00000513          	li	a0,0
}
    80003114:	02813083          	ld	ra,40(sp)
    80003118:	02013403          	ld	s0,32(sp)
    8000311c:	01813483          	ld	s1,24(sp)
    80003120:	01013903          	ld	s2,16(sp)
    80003124:	00813983          	ld	s3,8(sp)
    80003128:	00013a03          	ld	s4,0(sp)
    8000312c:	03010113          	addi	sp,sp,48
    80003130:	00008067          	ret
    if(t==0) return -1;
    80003134:	fff00513          	li	a0,-1
    80003138:	fddff06f          	j	80003114 <_Z18kern_thread_createPP8thread_sPFvPvES2_S2_+0xbc>

000000008000313c <_Z16kern_thread_joinP8thread_s>:

void kern_thread_join(thread_t handle)
{
    if(handle->status==UNUSED) return;
    8000313c:	05052783          	lw	a5,80(a0)
    80003140:	00079463          	bnez	a5,80003148 <_Z16kern_thread_joinP8thread_s+0xc>
    80003144:	00008067          	ret
{
    80003148:	fd010113          	addi	sp,sp,-48
    8000314c:	02113423          	sd	ra,40(sp)
    80003150:	02813023          	sd	s0,32(sp)
    80003154:	03010413          	addi	s0,sp,48
    running->joined_tid=handle->id;
    80003158:	0000a717          	auipc	a4,0xa
    8000315c:	c3870713          	addi	a4,a4,-968 # 8000cd90 <threads_cache>
    80003160:	01073783          	ld	a5,16(a4)
    80003164:	01053683          	ld	a3,16(a0)
    80003168:	02d7b423          	sd	a3,40(a5)
    running->status=JOINED;
    8000316c:	00400693          	li	a3,4
    80003170:	04d7a823          	sw	a3,80(a5)
    running->next_thread=scheduler.joined_head;
    80003174:	02873683          	ld	a3,40(a4)
    80003178:	06d7b023          	sd	a3,96(a5)
    scheduler.joined_head=running;
    8000317c:	02f73423          	sd	a5,40(a4)
    __asm__ volatile ("csrr %[sstatus], sstatus" : [sstatus] "=r"(sstatus));
    80003180:	100027f3          	csrr	a5,sstatus
    80003184:	fcf43c23          	sd	a5,-40(s0)
    return sstatus;
    80003188:	fd843783          	ld	a5,-40(s0)
    uint64 volatile sstatus = r_sstatus();
    8000318c:	fef43423          	sd	a5,-24(s0)
    __asm__ volatile ("csrr %[sepc], sepc" : [sepc] "=r"(sepc));
    80003190:	141027f3          	csrr	a5,sepc
    80003194:	fcf43823          	sd	a5,-48(s0)
    return sepc;
    80003198:	fd043783          	ld	a5,-48(s0)
    uint64 volatile v_sepc = r_sepc();
    8000319c:	fef43023          	sd	a5,-32(s0)
    kern_thread_yield();
    800031a0:	00000097          	auipc	ra,0x0
    800031a4:	cac080e7          	jalr	-852(ra) # 80002e4c <_Z17kern_thread_yieldv>
    w_sstatus(sstatus);
    800031a8:	fe843783          	ld	a5,-24(s0)
    __asm__ volatile ("csrw sstatus, %[sstatus]" : : [sstatus] "r"(sstatus));
    800031ac:	10079073          	csrw	sstatus,a5
    w_sepc(v_sepc);
    800031b0:	fe043783          	ld	a5,-32(s0)
    __asm__ volatile ("csrw sepc, %[sepc]" : : [sepc] "r"(sepc));
    800031b4:	14179073          	csrw	sepc,a5
}
    800031b8:	02813083          	ld	ra,40(sp)
    800031bc:	02013403          	ld	s0,32(sp)
    800031c0:	03010113          	addi	sp,sp,48
    800031c4:	00008067          	ret

00000000800031c8 <_Z18kern_thread_wakeupm>:

void kern_thread_wakeup(uint64 system_time)
{
    800031c8:	fd010113          	addi	sp,sp,-48
    800031cc:	02113423          	sd	ra,40(sp)
    800031d0:	02813023          	sd	s0,32(sp)
    800031d4:	00913c23          	sd	s1,24(sp)
    800031d8:	01213823          	sd	s2,16(sp)
    800031dc:	01313423          	sd	s3,8(sp)
    800031e0:	03010413          	addi	s0,sp,48
    800031e4:	00050993          	mv	s3,a0
    thread_t curr = scheduler.sleeping_head;
    800031e8:	0000a517          	auipc	a0,0xa
    800031ec:	bd853503          	ld	a0,-1064(a0) # 8000cdc0 <scheduler+0x18>
    thread_t prev = 0;
    800031f0:	00000913          	li	s2,0
    800031f4:	00c0006f          	j	80003200 <_Z18kern_thread_wakeupm+0x38>
            } else{
                scheduler.sleeping_head=curr->next_thread;
            }
            kern_scheduler_put(curr);
        } else{
            prev=curr;
    800031f8:	00050913          	mv	s2,a0
    800031fc:	00048513          	mv	a0,s1
    while (curr!=0){
    80003200:	02050863          	beqz	a0,80003230 <_Z18kern_thread_wakeupm+0x68>
        next=curr->next_thread;
    80003204:	06053483          	ld	s1,96(a0)
        if(curr->endTime<=system_time){
    80003208:	03853783          	ld	a5,56(a0)
    8000320c:	fef9e6e3          	bltu	s3,a5,800031f8 <_Z18kern_thread_wakeupm+0x30>
            if(prev!=0){
    80003210:	00090a63          	beqz	s2,80003224 <_Z18kern_thread_wakeupm+0x5c>
                prev->next_thread=curr->next_thread;
    80003214:	06993023          	sd	s1,96(s2)
            kern_scheduler_put(curr);
    80003218:	00000097          	auipc	ra,0x0
    8000321c:	b2c080e7          	jalr	-1236(ra) # 80002d44 <_Z18kern_scheduler_putP8thread_s>
    80003220:	fddff06f          	j	800031fc <_Z18kern_thread_wakeupm+0x34>
                scheduler.sleeping_head=curr->next_thread;
    80003224:	0000a797          	auipc	a5,0xa
    80003228:	b897be23          	sd	s1,-1124(a5) # 8000cdc0 <scheduler+0x18>
    8000322c:	fedff06f          	j	80003218 <_Z18kern_thread_wakeupm+0x50>
        }
        curr=next;
    }

}
    80003230:	02813083          	ld	ra,40(sp)
    80003234:	02013403          	ld	s0,32(sp)
    80003238:	01813483          	ld	s1,24(sp)
    8000323c:	01013903          	ld	s2,16(sp)
    80003240:	00813983          	ld	s3,8(sp)
    80003244:	03010113          	addi	sp,sp,48
    80003248:	00008067          	ret

000000008000324c <_Z17kern_thread_sleepm>:

void kern_thread_sleep(uint64 wakeTime)
{
    8000324c:	fd010113          	addi	sp,sp,-48
    80003250:	02113423          	sd	ra,40(sp)
    80003254:	02813023          	sd	s0,32(sp)
    80003258:	03010413          	addi	s0,sp,48
    running->status=SLEEPING;
    8000325c:	0000a717          	auipc	a4,0xa
    80003260:	b3470713          	addi	a4,a4,-1228 # 8000cd90 <threads_cache>
    80003264:	01073783          	ld	a5,16(a4)
    80003268:	00500693          	li	a3,5
    8000326c:	04d7a823          	sw	a3,80(a5)
    running->endTime=wakeTime;
    80003270:	02a7bc23          	sd	a0,56(a5)
    running->next_thread=scheduler.sleeping_head;
    80003274:	03073683          	ld	a3,48(a4)
    80003278:	06d7b023          	sd	a3,96(a5)
    scheduler.sleeping_head=running;
    8000327c:	02f73823          	sd	a5,48(a4)
    __asm__ volatile ("csrr %[sstatus], sstatus" : [sstatus] "=r"(sstatus));
    80003280:	100027f3          	csrr	a5,sstatus
    80003284:	fcf43c23          	sd	a5,-40(s0)
    return sstatus;
    80003288:	fd843783          	ld	a5,-40(s0)
    uint64 volatile sstatus = r_sstatus();
    8000328c:	fef43423          	sd	a5,-24(s0)
    __asm__ volatile ("csrr %[sepc], sepc" : [sepc] "=r"(sepc));
    80003290:	141027f3          	csrr	a5,sepc
    80003294:	fcf43823          	sd	a5,-48(s0)
    return sepc;
    80003298:	fd043783          	ld	a5,-48(s0)
    uint64 volatile v_sepc = r_sepc();
    8000329c:	fef43023          	sd	a5,-32(s0)
    kern_thread_yield();
    800032a0:	00000097          	auipc	ra,0x0
    800032a4:	bac080e7          	jalr	-1108(ra) # 80002e4c <_Z17kern_thread_yieldv>
    w_sstatus(sstatus);
    800032a8:	fe843783          	ld	a5,-24(s0)
    __asm__ volatile ("csrw sstatus, %[sstatus]" : : [sstatus] "r"(sstatus));
    800032ac:	10079073          	csrw	sstatus,a5
    w_sepc(v_sepc);
    800032b0:	fe043783          	ld	a5,-32(s0)
    __asm__ volatile ("csrw sepc, %[sepc]" : : [sepc] "r"(sepc));
    800032b4:	14179073          	csrw	sepc,a5
}
    800032b8:	02813083          	ld	ra,40(sp)
    800032bc:	02013403          	ld	s0,32(sp)
    800032c0:	03010113          	addi	sp,sp,48
    800032c4:	00008067          	ret

00000000800032c8 <_Z13kern_sem_ctorPv>:

struct sem_s semaphores[MAX_SEMAPHORES];
kmem_cache_t * semaphore_cache;

void kern_sem_ctor(void* addr)
{
    800032c8:	ff010113          	addi	sp,sp,-16
    800032cc:	00813423          	sd	s0,8(sp)
    800032d0:	01010413          	addi	s0,sp,16
    sem_t sem = (sem_t) addr;
    sem->status=SEM_UNUSED;
    800032d4:	00100793          	li	a5,1
    800032d8:	00f52223          	sw	a5,4(a0)
    sem->waiting_thread=0;
    800032dc:	00053423          	sd	zero,8(a0)
    sem->val=0;
    800032e0:	00052023          	sw	zero,0(a0)
}
    800032e4:	00813403          	ld	s0,8(sp)
    800032e8:	01010113          	addi	sp,sp,16
    800032ec:	00008067          	ret

00000000800032f0 <_Z13kern_sem_initv>:

void kern_sem_init()
{
    800032f0:	ff010113          	addi	sp,sp,-16
    800032f4:	00113423          	sd	ra,8(sp)
    800032f8:	00813023          	sd	s0,0(sp)
    800032fc:	01010413          	addi	s0,sp,16
    semaphore_cache = (kmem_cache_t*) kmem_cache_create("sem cache", sizeof(sem_s),kern_sem_ctor,0);
    80003300:	00000693          	li	a3,0
    80003304:	00000617          	auipc	a2,0x0
    80003308:	fc460613          	addi	a2,a2,-60 # 800032c8 <_Z13kern_sem_ctorPv>
    8000330c:	01000593          	li	a1,16
    80003310:	00007517          	auipc	a0,0x7
    80003314:	ec850513          	addi	a0,a0,-312 # 8000a1d8 <CONSOLE_STATUS+0x1c8>
    80003318:	00001097          	auipc	ra,0x1
    8000331c:	830080e7          	jalr	-2000(ra) # 80003b48 <_Z17kmem_cache_createPKcmPFvPvES3_>
    80003320:	0000a797          	auipc	a5,0xa
    80003324:	aaa7b423          	sd	a0,-1368(a5) # 8000cdc8 <semaphore_cache>

}
    80003328:	00813083          	ld	ra,8(sp)
    8000332c:	00013403          	ld	s0,0(sp)
    80003330:	01010113          	addi	sp,sp,16
    80003334:	00008067          	ret

0000000080003338 <_Z13kern_sem_openPP5sem_sj>:

int kern_sem_open (sem_t* handle, unsigned init)
{
    80003338:	fe010113          	addi	sp,sp,-32
    8000333c:	00113c23          	sd	ra,24(sp)
    80003340:	00813823          	sd	s0,16(sp)
    80003344:	00913423          	sd	s1,8(sp)
    80003348:	01213023          	sd	s2,0(sp)
    8000334c:	02010413          	addi	s0,sp,32
    80003350:	00050493          	mv	s1,a0
    80003354:	00058913          	mv	s2,a1
    sem_t sem=(sem_t) kmem_cache_alloc(semaphore_cache);
    80003358:	0000a517          	auipc	a0,0xa
    8000335c:	a7053503          	ld	a0,-1424(a0) # 8000cdc8 <semaphore_cache>
    80003360:	00001097          	auipc	ra,0x1
    80003364:	eac080e7          	jalr	-340(ra) # 8000420c <_Z16kmem_cache_allocP12kmem_cache_s>
    *handle=sem;
    80003368:	00a4b023          	sd	a0,0(s1)
    if(sem==0) return -1;
    8000336c:	02050463          	beqz	a0,80003394 <_Z13kern_sem_openPP5sem_sj+0x5c>
    sem->status=SEM_USED;
    80003370:	00052223          	sw	zero,4(a0)
    sem->val=init;
    80003374:	01252023          	sw	s2,0(a0)
    return 0;
    80003378:	00000513          	li	a0,0
}
    8000337c:	01813083          	ld	ra,24(sp)
    80003380:	01013403          	ld	s0,16(sp)
    80003384:	00813483          	ld	s1,8(sp)
    80003388:	00013903          	ld	s2,0(sp)
    8000338c:	02010113          	addi	sp,sp,32
    80003390:	00008067          	ret
    if(sem==0) return -1;
    80003394:	fff00513          	li	a0,-1
    80003398:	fe5ff06f          	j	8000337c <_Z13kern_sem_openPP5sem_sj+0x44>

000000008000339c <_Z14kern_sem_closeP5sem_s>:

int kern_sem_close (sem_t handle)
{
    8000339c:	fe010113          	addi	sp,sp,-32
    800033a0:	00113c23          	sd	ra,24(sp)
    800033a4:	00813823          	sd	s0,16(sp)
    800033a8:	00913423          	sd	s1,8(sp)
    800033ac:	01213023          	sd	s2,0(sp)
    800033b0:	02010413          	addi	s0,sp,32
    800033b4:	00050913          	mv	s2,a0
    handle->status=SEM_UNUSED;
    800033b8:	00100793          	li	a5,1
    800033bc:	00f52223          	sw	a5,4(a0)
    handle->val=0;
    800033c0:	00052023          	sw	zero,0(a0)
    if(handle->waiting_thread!=0){
    800033c4:	00853503          	ld	a0,8(a0)
    800033c8:	02051663          	bnez	a0,800033f4 <_Z14kern_sem_closeP5sem_s+0x58>
    800033cc:	0300006f          	j	800033fc <_Z14kern_sem_closeP5sem_s+0x60>
        thread_t curr = handle->waiting_thread;
        while(curr){
            curr->mailbox=-2;
    800033d0:	ffe00793          	li	a5,-2
    800033d4:	04f53423          	sd	a5,72(a0)
            curr->status=READY;
    800033d8:	00200793          	li	a5,2
    800033dc:	04f52823          	sw	a5,80(a0)
            thread_t prev=curr;
            curr=curr->sem_next;
    800033e0:	05853483          	ld	s1,88(a0)
            prev->sem_next=0;
    800033e4:	04053c23          	sd	zero,88(a0)
            kern_scheduler_put(prev);
    800033e8:	00000097          	auipc	ra,0x0
    800033ec:	95c080e7          	jalr	-1700(ra) # 80002d44 <_Z18kern_scheduler_putP8thread_s>
            curr=curr->sem_next;
    800033f0:	00048513          	mv	a0,s1
        while(curr){
    800033f4:	fc051ee3          	bnez	a0,800033d0 <_Z14kern_sem_closeP5sem_s+0x34>
        }
        handle->waiting_thread=0;
    800033f8:	00093423          	sd	zero,8(s2)
    }
    kmem_cache_free(semaphore_cache,handle);
    800033fc:	00090593          	mv	a1,s2
    80003400:	0000a517          	auipc	a0,0xa
    80003404:	9c853503          	ld	a0,-1592(a0) # 8000cdc8 <semaphore_cache>
    80003408:	00001097          	auipc	ra,0x1
    8000340c:	e40080e7          	jalr	-448(ra) # 80004248 <_Z15kmem_cache_freeP12kmem_cache_sPv>
    return 0;
}
    80003410:	00000513          	li	a0,0
    80003414:	01813083          	ld	ra,24(sp)
    80003418:	01013403          	ld	s0,16(sp)
    8000341c:	00813483          	ld	s1,8(sp)
    80003420:	00013903          	ld	s2,0(sp)
    80003424:	02010113          	addi	sp,sp,32
    80003428:	00008067          	ret

000000008000342c <_Z15kern_sem_signalP5sem_s>:

void kern_sem_signal(sem_t id)
{
    if(id->val>0 || id->waiting_thread==0) id->val++;
    8000342c:	00052783          	lw	a5,0(a0)
    80003430:	00f05863          	blez	a5,80003440 <_Z15kern_sem_signalP5sem_s+0x14>
    80003434:	0017879b          	addiw	a5,a5,1
    80003438:	00f52023          	sw	a5,0(a0)
    8000343c:	00008067          	ret
    80003440:	00853703          	ld	a4,8(a0)
    80003444:	fe0708e3          	beqz	a4,80003434 <_Z15kern_sem_signalP5sem_s+0x8>
{
    80003448:	ff010113          	addi	sp,sp,-16
    8000344c:	00113423          	sd	ra,8(sp)
    80003450:	00813023          	sd	s0,0(sp)
    80003454:	01010413          	addi	s0,sp,16
    else {
        thread_t woken = id->waiting_thread;
        id->waiting_thread=woken->sem_next;
    80003458:	05873783          	ld	a5,88(a4)
    8000345c:	00f53423          	sd	a5,8(a0)
        woken->mailbox=0;
    80003460:	04073423          	sd	zero,72(a4)
        woken->status=READY;
    80003464:	00200793          	li	a5,2
    80003468:	04f72823          	sw	a5,80(a4)
        kern_scheduler_put(woken);
    8000346c:	00070513          	mv	a0,a4
    80003470:	00000097          	auipc	ra,0x0
    80003474:	8d4080e7          	jalr	-1836(ra) # 80002d44 <_Z18kern_scheduler_putP8thread_s>
    }
}
    80003478:	00813083          	ld	ra,8(sp)
    8000347c:	00013403          	ld	s0,0(sp)
    80003480:	01010113          	addi	sp,sp,16
    80003484:	00008067          	ret

0000000080003488 <_Z13kern_sem_waitP5sem_s>:

int kern_sem_wait(sem_t id)
{
    if(id->val<=0){
    80003488:	00052783          	lw	a5,0(a0)
    8000348c:	00f05a63          	blez	a5,800034a0 <_Z13kern_sem_waitP5sem_s+0x18>
        w_sstatus(sstatus);
        w_sepc(v_sepc);
        return running->mailbox;
    }
    else {
        id->val--;
    80003490:	fff7879b          	addiw	a5,a5,-1
    80003494:	00f52023          	sw	a5,0(a0)
        return 1;
    80003498:	00100513          	li	a0,1
    }
}
    8000349c:	00008067          	ret
{
    800034a0:	fd010113          	addi	sp,sp,-48
    800034a4:	02113423          	sd	ra,40(sp)
    800034a8:	02813023          	sd	s0,32(sp)
    800034ac:	03010413          	addi	s0,sp,48
        running->status=SUSPENDED;
    800034b0:	00009797          	auipc	a5,0x9
    800034b4:	7807b783          	ld	a5,1920(a5) # 8000cc30 <_GLOBAL_OFFSET_TABLE_+0x20>
    800034b8:	0007b683          	ld	a3,0(a5)
    800034bc:	00300793          	li	a5,3
    800034c0:	04f6a823          	sw	a5,80(a3) # 1050 <_entry-0x7fffefb0>
        if(id->waiting_thread==0) id->waiting_thread=running;
    800034c4:	00853783          	ld	a5,8(a0)
    800034c8:	06078863          	beqz	a5,80003538 <_Z13kern_sem_waitP5sem_s+0xb0>
            while (curr->sem_next!=0) curr=curr->sem_next;
    800034cc:	00078713          	mv	a4,a5
    800034d0:	0587b783          	ld	a5,88(a5)
    800034d4:	fe079ce3          	bnez	a5,800034cc <_Z13kern_sem_waitP5sem_s+0x44>
            curr->sem_next=running;
    800034d8:	04d73c23          	sd	a3,88(a4)
        running->sem_next=0;
    800034dc:	0406bc23          	sd	zero,88(a3)
    __asm__ volatile ("csrr %[sstatus], sstatus" : [sstatus] "=r"(sstatus));
    800034e0:	100027f3          	csrr	a5,sstatus
    800034e4:	fef43423          	sd	a5,-24(s0)
    return sstatus;
    800034e8:	fe843783          	ld	a5,-24(s0)
        uint64 volatile sstatus = r_sstatus();
    800034ec:	fcf43823          	sd	a5,-48(s0)
    __asm__ volatile ("csrr %[sepc], sepc" : [sepc] "=r"(sepc));
    800034f0:	141027f3          	csrr	a5,sepc
    800034f4:	fef43023          	sd	a5,-32(s0)
    return sepc;
    800034f8:	fe043783          	ld	a5,-32(s0)
        uint64 volatile v_sepc = r_sepc();
    800034fc:	fcf43c23          	sd	a5,-40(s0)
        kern_thread_yield();
    80003500:	00000097          	auipc	ra,0x0
    80003504:	94c080e7          	jalr	-1716(ra) # 80002e4c <_Z17kern_thread_yieldv>
        w_sstatus(sstatus);
    80003508:	fd043783          	ld	a5,-48(s0)
    __asm__ volatile ("csrw sstatus, %[sstatus]" : : [sstatus] "r"(sstatus));
    8000350c:	10079073          	csrw	sstatus,a5
        w_sepc(v_sepc);
    80003510:	fd843783          	ld	a5,-40(s0)
    __asm__ volatile ("csrw sepc, %[sepc]" : : [sepc] "r"(sepc));
    80003514:	14179073          	csrw	sepc,a5
        return running->mailbox;
    80003518:	00009797          	auipc	a5,0x9
    8000351c:	7187b783          	ld	a5,1816(a5) # 8000cc30 <_GLOBAL_OFFSET_TABLE_+0x20>
    80003520:	0007b783          	ld	a5,0(a5)
    80003524:	0487a503          	lw	a0,72(a5)
}
    80003528:	02813083          	ld	ra,40(sp)
    8000352c:	02013403          	ld	s0,32(sp)
    80003530:	03010113          	addi	sp,sp,48
    80003534:	00008067          	ret
        if(id->waiting_thread==0) id->waiting_thread=running;
    80003538:	00d53423          	sd	a3,8(a0)
    8000353c:	fa1ff06f          	j	800034dc <_Z13kern_sem_waitP5sem_s+0x54>

0000000080003540 <_Z19kern_interrupt_initv>:
#ifdef __cplusplus
}
#endif

void kern_interrupt_init()
{
    80003540:	ff010113          	addi	sp,sp,-16
    80003544:	00813423          	sd	s0,8(sp)
    80003548:	01010413          	addi	s0,sp,16
    SYSTEM_TIME=0;
    8000354c:	0000b797          	auipc	a5,0xb
    80003550:	8807b223          	sd	zero,-1916(a5) # 8000ddd0 <SYSTEM_TIME>
    w_stvec((uint64) &supervisorTrap);
    80003554:	00009797          	auipc	a5,0x9
    80003558:	6e47b783          	ld	a5,1764(a5) # 8000cc38 <_GLOBAL_OFFSET_TABLE_+0x28>
    __asm__ volatile ("csrw stvec, %[stvec]" : : [stvec] "r"(stvec));
    8000355c:	10579073          	csrw	stvec,a5
    __asm__ volatile ("csrs sstatus, %[mask]" : : [mask] "r"(mask));
    80003560:	00200793          	li	a5,2
    80003564:	1007a073          	csrs	sstatus,a5
    ms_sstatus(SSTATUS_SIE);
}
    80003568:	00813403          	ld	s0,8(sp)
    8000356c:	01010113          	addi	sp,sp,16
    80003570:	00008067          	ret

0000000080003574 <_Z12kern_syscall13SyscallNumberz>:


void kern_syscall(enum SyscallNumber num, ...)
{
    80003574:	fb010113          	addi	sp,sp,-80
    80003578:	00813423          	sd	s0,8(sp)
    8000357c:	01010413          	addi	s0,sp,16
    80003580:	00b43423          	sd	a1,8(s0)
    80003584:	00c43823          	sd	a2,16(s0)
    80003588:	00d43c23          	sd	a3,24(s0)
    8000358c:	02e43023          	sd	a4,32(s0)
    80003590:	02f43423          	sd	a5,40(s0)
    80003594:	03043823          	sd	a6,48(s0)
    80003598:	03143c23          	sd	a7,56(s0)
    __asm__ volatile ("ecall");
    8000359c:	00000073          	ecall
    return;
}
    800035a0:	00813403          	ld	s0,8(sp)
    800035a4:	05010113          	addi	sp,sp,80
    800035a8:	00008067          	ret

00000000800035ac <handleEcall>:
#ifdef __cplusplus
extern "C" {
#endif


void handleEcall(uint64 a0, uint64 a1, uint64 a2, uint64 a3, uint64 a4) {
    800035ac:	fd010113          	addi	sp,sp,-48
    800035b0:	02113423          	sd	ra,40(sp)
    800035b4:	02813023          	sd	s0,32(sp)
    800035b8:	00913c23          	sd	s1,24(sp)
    800035bc:	01213823          	sd	s2,16(sp)
    800035c0:	03010413          	addi	s0,sp,48
    800035c4:	00060913          	mv	s2,a2
    800035c8:	00068613          	mv	a2,a3
    __asm__ volatile ("csrr %[scause], scause" : [scause] "=r"(scause));
    800035cc:	142027f3          	csrr	a5,scause
    800035d0:	fcf43823          	sd	a5,-48(s0)
    return scause;
    800035d4:	fd043783          	ld	a5,-48(s0)
    __asm__ volatile ("mv %[a2], a2" : [a2] "=r"(a2));
    __asm__ volatile ("mv %[a3], a3" : [a3] "=r"(a3));
    __asm__ volatile ("mv %[a4], a4" : [a4] "=r"(a4));
     */
    uint64 scause = r_scause();
    if (scause == INTR_USER_ECALL || scause == INTR_KERNEL_ECALL) {
    800035d8:	ff878793          	addi	a5,a5,-8
    800035dc:	00100693          	li	a3,1
    800035e0:	00f6fe63          	bgeu	a3,a5,800035fc <handleEcall+0x50>
            }


        }
    }
}
    800035e4:	02813083          	ld	ra,40(sp)
    800035e8:	02013403          	ld	s0,32(sp)
    800035ec:	01813483          	ld	s1,24(sp)
    800035f0:	01013903          	ld	s2,16(sp)
    800035f4:	03010113          	addi	sp,sp,48
    800035f8:	00008067          	ret
    800035fc:	00058493          	mv	s1,a1
    __asm__ volatile ("csrr %[sepc], sepc" : [sepc] "=r"(sepc));
    80003600:	141027f3          	csrr	a5,sepc
    80003604:	fcf43c23          	sd	a5,-40(s0)
    return sepc;
    80003608:	fd843783          	ld	a5,-40(s0)
        uint64 sepc = r_sepc() + 4;
    8000360c:	00478793          	addi	a5,a5,4
        uint64 time = SYSTEM_TIME;
    80003610:	0000a597          	auipc	a1,0xa
    80003614:	7c05b583          	ld	a1,1984(a1) # 8000ddd0 <SYSTEM_TIME>
    __asm__ volatile ("csrw sepc, %[sepc]" : : [sepc] "r"(sepc));
    80003618:	14179073          	csrw	sepc,a5
        switch (syscall_num) {
    8000361c:	04200793          	li	a5,66
    80003620:	fca7e2e3          	bltu	a5,a0,800035e4 <handleEcall+0x38>
    80003624:	00251513          	slli	a0,a0,0x2
    80003628:	00007697          	auipc	a3,0x7
    8000362c:	bbc68693          	addi	a3,a3,-1092 # 8000a1e4 <CONSOLE_STATUS+0x1d4>
    80003630:	00d50533          	add	a0,a0,a3
    80003634:	00052783          	lw	a5,0(a0)
    80003638:	00d787b3          	add	a5,a5,a3
    8000363c:	00078067          	jr	a5
                retval = (uint64) kern_mem_alloc(size);
    80003640:	0004851b          	sext.w	a0,s1
    80003644:	fffff097          	auipc	ra,0xfffff
    80003648:	dc8080e7          	jalr	-568(ra) # 8000240c <_Z14kern_mem_alloci>
    __asm__ volatile ("mv a0, %[value]" :: [value] "r"(value));
    8000364c:	00050513          	mv	a0,a0
}
    80003650:	f95ff06f          	j	800035e4 <handleEcall+0x38>
                retval = (uint64) kern_mem_free((void *) addr);
    80003654:	00048513          	mv	a0,s1
    80003658:	fffff097          	auipc	ra,0xfffff
    8000365c:	e78080e7          	jalr	-392(ra) # 800024d0 <_Z13kern_mem_freePv>
    __asm__ volatile ("mv a0, %[value]" :: [value] "r"(value));
    80003660:	00050513          	mv	a0,a0
}
    80003664:	f81ff06f          	j	800035e4 <handleEcall+0x38>
                retval = (uint64) kern_thread_create((thread_t *) handle,
    80003668:	00070693          	mv	a3,a4
    8000366c:	00090593          	mv	a1,s2
    80003670:	00048513          	mv	a0,s1
    80003674:	00000097          	auipc	ra,0x0
    80003678:	9e4080e7          	jalr	-1564(ra) # 80003058 <_Z18kern_thread_createPP8thread_sPFvPvES2_S2_>
                (*(thread_t *) handle)->endTime = SYSTEM_TIME + DEFAULT_TIME_SLICE;
    8000367c:	0004b703          	ld	a4,0(s1)
    80003680:	0000a797          	auipc	a5,0xa
    80003684:	7507b783          	ld	a5,1872(a5) # 8000ddd0 <SYSTEM_TIME>
    80003688:	00278793          	addi	a5,a5,2
    8000368c:	02f73c23          	sd	a5,56(a4)
    __asm__ volatile ("mv a0, %[value]" :: [value] "r"(value));
    80003690:	00050513          	mv	a0,a0
}
    80003694:	f51ff06f          	j	800035e4 <handleEcall+0x38>
                kern_thread_dispatch();
    80003698:	00000097          	auipc	ra,0x0
    8000369c:	83c080e7          	jalr	-1988(ra) # 80002ed4 <_Z20kern_thread_dispatchv>
                running->endTime = SYSTEM_TIME + running->timeslice;
    800036a0:	00009797          	auipc	a5,0x9
    800036a4:	5907b783          	ld	a5,1424(a5) # 8000cc30 <_GLOBAL_OFFSET_TABLE_+0x20>
    800036a8:	0007b703          	ld	a4,0(a5)
    800036ac:	03073783          	ld	a5,48(a4)
    800036b0:	0000a697          	auipc	a3,0xa
    800036b4:	7206b683          	ld	a3,1824(a3) # 8000ddd0 <SYSTEM_TIME>
    800036b8:	00d787b3          	add	a5,a5,a3
    800036bc:	02f73c23          	sd	a5,56(a4)
                break;
    800036c0:	f25ff06f          	j	800035e4 <handleEcall+0x38>
                kern_thread_join(handle);
    800036c4:	00048513          	mv	a0,s1
    800036c8:	00000097          	auipc	ra,0x0
    800036cc:	a74080e7          	jalr	-1420(ra) # 8000313c <_Z16kern_thread_joinP8thread_s>
                running->endTime = SYSTEM_TIME + running->timeslice;
    800036d0:	00009797          	auipc	a5,0x9
    800036d4:	5607b783          	ld	a5,1376(a5) # 8000cc30 <_GLOBAL_OFFSET_TABLE_+0x20>
    800036d8:	0007b703          	ld	a4,0(a5)
    800036dc:	03073783          	ld	a5,48(a4)
    800036e0:	0000a697          	auipc	a3,0xa
    800036e4:	6f06b683          	ld	a3,1776(a3) # 8000ddd0 <SYSTEM_TIME>
    800036e8:	00d787b3          	add	a5,a5,a3
    800036ec:	02f73c23          	sd	a5,56(a4)
                break;
    800036f0:	ef5ff06f          	j	800035e4 <handleEcall+0x38>
                kern_thread_end_running();
    800036f4:	00000097          	auipc	ra,0x0
    800036f8:	8cc080e7          	jalr	-1844(ra) # 80002fc0 <_Z23kern_thread_end_runningv>
                retval = kern_sem_open(handle, init);
    800036fc:	0009059b          	sext.w	a1,s2
    80003700:	00048513          	mv	a0,s1
    80003704:	00000097          	auipc	ra,0x0
    80003708:	c34080e7          	jalr	-972(ra) # 80003338 <_Z13kern_sem_openPP5sem_sj>
    __asm__ volatile ("mv a0, %[value]" :: [value] "r"(value));
    8000370c:	00050513          	mv	a0,a0
}
    80003710:	ed5ff06f          	j	800035e4 <handleEcall+0x38>
                retval = kern_sem_close(handle);
    80003714:	00048513          	mv	a0,s1
    80003718:	00000097          	auipc	ra,0x0
    8000371c:	c84080e7          	jalr	-892(ra) # 8000339c <_Z14kern_sem_closeP5sem_s>
    __asm__ volatile ("mv a0, %[value]" :: [value] "r"(value));
    80003720:	00050513          	mv	a0,a0
}
    80003724:	ec1ff06f          	j	800035e4 <handleEcall+0x38>
                kern_sem_signal(handle);
    80003728:	00048513          	mv	a0,s1
    8000372c:	00000097          	auipc	ra,0x0
    80003730:	d00080e7          	jalr	-768(ra) # 8000342c <_Z15kern_sem_signalP5sem_s>
    __asm__ volatile ("mv a0, %[value]" :: [value] "r"(value));
    80003734:	00000793          	li	a5,0
    80003738:	00078513          	mv	a0,a5
}
    8000373c:	ea9ff06f          	j	800035e4 <handleEcall+0x38>
                retval = kern_sem_wait(handle);
    80003740:	00048513          	mv	a0,s1
    80003744:	00000097          	auipc	ra,0x0
    80003748:	d44080e7          	jalr	-700(ra) # 80003488 <_Z13kern_sem_waitP5sem_s>
                if (retval == 1) { //nije promenjen kontekst
    8000374c:	00100793          	li	a5,1
    80003750:	02f50663          	beq	a0,a5,8000377c <handleEcall+0x1d0>
                    running->endTime = SYSTEM_TIME + running->timeslice;
    80003754:	00009797          	auipc	a5,0x9
    80003758:	4dc7b783          	ld	a5,1244(a5) # 8000cc30 <_GLOBAL_OFFSET_TABLE_+0x20>
    8000375c:	0007b703          	ld	a4,0(a5)
    80003760:	03073783          	ld	a5,48(a4)
    80003764:	0000a697          	auipc	a3,0xa
    80003768:	66c6b683          	ld	a3,1644(a3) # 8000ddd0 <SYSTEM_TIME>
    8000376c:	00d787b3          	add	a5,a5,a3
    80003770:	02f73c23          	sd	a5,56(a4)
    __asm__ volatile ("mv a0, %[value]" :: [value] "r"(value));
    80003774:	00050513          	mv	a0,a0
}
    80003778:	e6dff06f          	j	800035e4 <handleEcall+0x38>
                    retval = 0;
    8000377c:	00000513          	li	a0,0
    80003780:	ff5ff06f          	j	80003774 <handleEcall+0x1c8>
                kern_thread_sleep(wakeTime);
    80003784:	00958533          	add	a0,a1,s1
    80003788:	00000097          	auipc	ra,0x0
    8000378c:	ac4080e7          	jalr	-1340(ra) # 8000324c <_Z17kern_thread_sleepm>
                running->endTime=time+running->timeslice;
    80003790:	00009797          	auipc	a5,0x9
    80003794:	4a07b783          	ld	a5,1184(a5) # 8000cc30 <_GLOBAL_OFFSET_TABLE_+0x20>
    80003798:	0007b703          	ld	a4,0(a5)
    8000379c:	03073783          	ld	a5,48(a4)
    800037a0:	0000a697          	auipc	a3,0xa
    800037a4:	6306b683          	ld	a3,1584(a3) # 8000ddd0 <SYSTEM_TIME>
    800037a8:	00d787b3          	add	a5,a5,a3
    800037ac:	02f73c23          	sd	a5,56(a4)
                break;
    800037b0:	e35ff06f          	j	800035e4 <handleEcall+0x38>
                    c = kern_console_getchar();
    800037b4:	fffff097          	auipc	ra,0xfffff
    800037b8:	fd8080e7          	jalr	-40(ra) # 8000278c <_Z20kern_console_getcharv>
                    if(c==-1){
    800037bc:	fff00793          	li	a5,-1
    800037c0:	02f51863          	bne	a0,a5,800037f0 <handleEcall+0x244>
                        kern_thread_dispatch();
    800037c4:	fffff097          	auipc	ra,0xfffff
    800037c8:	710080e7          	jalr	1808(ra) # 80002ed4 <_Z20kern_thread_dispatchv>
                        running->endTime = SYSTEM_TIME + running->timeslice;
    800037cc:	00009797          	auipc	a5,0x9
    800037d0:	4647b783          	ld	a5,1124(a5) # 8000cc30 <_GLOBAL_OFFSET_TABLE_+0x20>
    800037d4:	0007b703          	ld	a4,0(a5)
    800037d8:	03073783          	ld	a5,48(a4)
    800037dc:	0000a697          	auipc	a3,0xa
    800037e0:	5f46b683          	ld	a3,1524(a3) # 8000ddd0 <SYSTEM_TIME>
    800037e4:	00d787b3          	add	a5,a5,a3
    800037e8:	02f73c23          	sd	a5,56(a4)
                    c = kern_console_getchar();
    800037ec:	fc9ff06f          	j	800037b4 <handleEcall+0x208>
    __asm__ volatile ("mv a0, %[value]" :: [value] "r"(value));
    800037f0:	00050513          	mv	a0,a0
}
    800037f4:	df1ff06f          	j	800035e4 <handleEcall+0x38>
                char c = a1;
    800037f8:	0ff4f493          	andi	s1,s1,255
                    res=kern_console_putchar(c);
    800037fc:	00048513          	mv	a0,s1
    80003800:	fffff097          	auipc	ra,0xfffff
    80003804:	ff0080e7          	jalr	-16(ra) # 800027f0 <_Z20kern_console_putcharc>
                    if(res==-1){
    80003808:	fff00793          	li	a5,-1
    8000380c:	dcf51ce3          	bne	a0,a5,800035e4 <handleEcall+0x38>
                        kern_thread_dispatch();
    80003810:	fffff097          	auipc	ra,0xfffff
    80003814:	6c4080e7          	jalr	1732(ra) # 80002ed4 <_Z20kern_thread_dispatchv>
                        running->endTime = SYSTEM_TIME + running->timeslice;
    80003818:	00009797          	auipc	a5,0x9
    8000381c:	4187b783          	ld	a5,1048(a5) # 8000cc30 <_GLOBAL_OFFSET_TABLE_+0x20>
    80003820:	0007b703          	ld	a4,0(a5)
    80003824:	03073783          	ld	a5,48(a4)
    80003828:	0000a697          	auipc	a3,0xa
    8000382c:	5a86b683          	ld	a3,1448(a3) # 8000ddd0 <SYSTEM_TIME>
    80003830:	00d787b3          	add	a5,a5,a3
    80003834:	02f73c23          	sd	a5,56(a4)
                    res=kern_console_putchar(c);
    80003838:	fc5ff06f          	j	800037fc <handleEcall+0x250>

000000008000383c <handleInterrupt>:
int counter=0;
#define BUFFER_SIZE 1024
char cbuf[BUFFER_SIZE];

void handleInterrupt()
{
    8000383c:	fd010113          	addi	sp,sp,-48
    80003840:	02113423          	sd	ra,40(sp)
    80003844:	02813023          	sd	s0,32(sp)
    80003848:	00913c23          	sd	s1,24(sp)
    8000384c:	03010413          	addi	s0,sp,48
    __asm__ volatile ("csrr %[scause], scause" : [scause] "=r"(scause));
    80003850:	142027f3          	csrr	a5,scause
    80003854:	fcf43c23          	sd	a5,-40(s0)
    return scause;
    80003858:	fd843703          	ld	a4,-40(s0)
    uint64 scause = r_scause();
    if (scause == INTR_TIMER)
    8000385c:	fff00793          	li	a5,-1
    80003860:	03f79793          	slli	a5,a5,0x3f
    80003864:	00178793          	addi	a5,a5,1
    80003868:	02f70863          	beq	a4,a5,80003898 <handleInterrupt+0x5c>
        if(SYSTEM_TIME>=running->endTime){
            kern_thread_dispatch();
            running->endTime=SYSTEM_TIME+running->timeslice;
        }
    }
    else if (scause == INTR_CONSOLE)
    8000386c:	fff00793          	li	a5,-1
    80003870:	03f79793          	slli	a5,a5,0x3f
    80003874:	00978793          	addi	a5,a5,9
    80003878:	08f70463          	beq	a4,a5,80003900 <handleInterrupt+0xc4>
            kern_uart_handler();
        }
        plic_complete(irq);
        // console_handler();
    }
    else if(scause == INTR_ILLEGAL_INSTRUCTION)
    8000387c:	00200793          	li	a5,2
    80003880:	0af70863          	beq	a4,a5,80003930 <handleInterrupt+0xf4>

    }
    else if(scause==INTR_ILLEGAL_ADDR_WR){

    }
}
    80003884:	02813083          	ld	ra,40(sp)
    80003888:	02013403          	ld	s0,32(sp)
    8000388c:	01813483          	ld	s1,24(sp)
    80003890:	03010113          	addi	sp,sp,48
    80003894:	00008067          	ret
        SYSTEM_TIME++;
    80003898:	0000a497          	auipc	s1,0xa
    8000389c:	53848493          	addi	s1,s1,1336 # 8000ddd0 <SYSTEM_TIME>
    800038a0:	0004b503          	ld	a0,0(s1)
    800038a4:	00150513          	addi	a0,a0,1
    800038a8:	00a4b023          	sd	a0,0(s1)
    __asm__ volatile ("csrc sip, %[mask]" : : [mask] "r"(mask));
    800038ac:	00200793          	li	a5,2
    800038b0:	1447b073          	csrc	sip,a5
        kern_thread_wakeup(SYSTEM_TIME);
    800038b4:	00000097          	auipc	ra,0x0
    800038b8:	914080e7          	jalr	-1772(ra) # 800031c8 <_Z18kern_thread_wakeupm>
        if(SYSTEM_TIME>=running->endTime){
    800038bc:	00009797          	auipc	a5,0x9
    800038c0:	3747b783          	ld	a5,884(a5) # 8000cc30 <_GLOBAL_OFFSET_TABLE_+0x20>
    800038c4:	0007b783          	ld	a5,0(a5)
    800038c8:	0387b703          	ld	a4,56(a5)
    800038cc:	0004b783          	ld	a5,0(s1)
    800038d0:	fae7eae3          	bltu	a5,a4,80003884 <handleInterrupt+0x48>
            kern_thread_dispatch();
    800038d4:	fffff097          	auipc	ra,0xfffff
    800038d8:	600080e7          	jalr	1536(ra) # 80002ed4 <_Z20kern_thread_dispatchv>
            running->endTime=SYSTEM_TIME+running->timeslice;
    800038dc:	00009797          	auipc	a5,0x9
    800038e0:	3547b783          	ld	a5,852(a5) # 8000cc30 <_GLOBAL_OFFSET_TABLE_+0x20>
    800038e4:	0007b703          	ld	a4,0(a5)
    800038e8:	03073783          	ld	a5,48(a4)
    800038ec:	0000a697          	auipc	a3,0xa
    800038f0:	4e46b683          	ld	a3,1252(a3) # 8000ddd0 <SYSTEM_TIME>
    800038f4:	00d787b3          	add	a5,a5,a3
    800038f8:	02f73c23          	sd	a5,56(a4)
    800038fc:	f89ff06f          	j	80003884 <handleInterrupt+0x48>
        int irq = plic_claim();
    80003900:	00005097          	auipc	ra,0x5
    80003904:	804080e7          	jalr	-2044(ra) # 80008104 <plic_claim>
    80003908:	00050493          	mv	s1,a0
        if(irq==CONSOLE_IRQ) {
    8000390c:	00a00793          	li	a5,10
    80003910:	00f50a63          	beq	a0,a5,80003924 <handleInterrupt+0xe8>
        plic_complete(irq);
    80003914:	00048513          	mv	a0,s1
    80003918:	00005097          	auipc	ra,0x5
    8000391c:	824080e7          	jalr	-2012(ra) # 8000813c <plic_complete>
    80003920:	f65ff06f          	j	80003884 <handleInterrupt+0x48>
            kern_uart_handler();
    80003924:	fffff097          	auipc	ra,0xfffff
    80003928:	df8080e7          	jalr	-520(ra) # 8000271c <_Z17kern_uart_handlerv>
    8000392c:	fe9ff06f          	j	80003914 <handleInterrupt+0xd8>
        kern_mem_free((void*)running->stack_space);
    80003930:	00009797          	auipc	a5,0x9
    80003934:	3007b783          	ld	a5,768(a5) # 8000cc30 <_GLOBAL_OFFSET_TABLE_+0x20>
    80003938:	0007b783          	ld	a5,0(a5)
    8000393c:	0407b503          	ld	a0,64(a5)
    80003940:	fffff097          	auipc	ra,0xfffff
    80003944:	b90080e7          	jalr	-1136(ra) # 800024d0 <_Z13kern_mem_freePv>
        kern_thread_end_running();
    80003948:	fffff097          	auipc	ra,0xfffff
    8000394c:	678080e7          	jalr	1656(ra) # 80002fc0 <_Z23kern_thread_end_runningv>
}
    80003950:	f35ff06f          	j	80003884 <handleInterrupt+0x48>

0000000080003954 <_Z11kmem_strcpyPcPKc>:
#define ALLOCATION_CHUNK_SIZE 16

kmem_cache_t *kmem_cache_head;


void kmem_strcpy(char* dst, const char* src) {
    80003954:	ff010113          	addi	sp,sp,-16
    80003958:	00813423          	sd	s0,8(sp)
    8000395c:	01010413          	addi	s0,sp,16
    int i = 0;
    80003960:	00000793          	li	a5,0
    while (src[i] != '\0' && i < 15) {
    80003964:	00078713          	mv	a4,a5
    80003968:	00f586b3          	add	a3,a1,a5
    8000396c:	0006c683          	lbu	a3,0(a3)
    80003970:	00068e63          	beqz	a3,8000398c <_Z11kmem_strcpyPcPKc+0x38>
    80003974:	00e00613          	li	a2,14
    80003978:	00f64a63          	blt	a2,a5,8000398c <_Z11kmem_strcpyPcPKc+0x38>
        dst[i] = src[i];
    8000397c:	00f50733          	add	a4,a0,a5
    80003980:	00d70023          	sb	a3,0(a4)
        i++;
    80003984:	0017879b          	addiw	a5,a5,1
    while (src[i] != '\0' && i < 15) {
    80003988:	fddff06f          	j	80003964 <_Z11kmem_strcpyPcPKc+0x10>
    }
    dst[i] = '\0';
    8000398c:	00e50533          	add	a0,a0,a4
    80003990:	00050023          	sb	zero,0(a0)
}
    80003994:	00813403          	ld	s0,8(sp)
    80003998:	01010113          	addi	sp,sp,16
    8000399c:	00008067          	ret

00000000800039a0 <_Z9kmem_initPvi>:

void kmem_init(void *space, int block_num)
{
    800039a0:	ff010113          	addi	sp,sp,-16
    800039a4:	00113423          	sd	ra,8(sp)
    800039a8:	00813023          	sd	s0,0(sp)
    800039ac:	01010413          	addi	s0,sp,16
    bba_init((char*)space,(char*)space+block_num*BLOCK_SIZE);
    800039b0:	00c5959b          	slliw	a1,a1,0xc
    800039b4:	00b505b3          	add	a1,a0,a1
    800039b8:	ffffe097          	auipc	ra,0xffffe
    800039bc:	d40080e7          	jalr	-704(ra) # 800016f8 <_Z8bba_initPcS_>
    kmem_cache_head=0;
    800039c0:	0000b797          	auipc	a5,0xb
    800039c4:	8207b023          	sd	zero,-2016(a5) # 8000e1e0 <kmem_cache_head>
}
    800039c8:	00813083          	ld	ra,8(sp)
    800039cc:	00013403          	ld	s0,0(sp)
    800039d0:	01010113          	addi	sp,sp,16
    800039d4:	00008067          	ret

00000000800039d8 <_Z14kmem_slab_initP12kmem_cache_s>:
    }
}

//creates a slab, adds it to cache list, initializes up to ALLOCATION_CHUNK_SIZE objs if needed
kmem_slab_t *kmem_slab_init(kmem_cache_t* cache)
{
    800039d8:	fd010113          	addi	sp,sp,-48
    800039dc:	02113423          	sd	ra,40(sp)
    800039e0:	02813023          	sd	s0,32(sp)
    800039e4:	00913c23          	sd	s1,24(sp)
    800039e8:	01213823          	sd	s2,16(sp)
    800039ec:	01313423          	sd	s3,8(sp)
    800039f0:	01413023          	sd	s4,0(sp)
    800039f4:	03010413          	addi	s0,sp,48
    800039f8:	00050913          	mv	s2,a0
    void* memory = bba_allocate(cache->memorySize);
    800039fc:	04852503          	lw	a0,72(a0)
    80003a00:	ffffe097          	auipc	ra,0xffffe
    80003a04:	020080e7          	jalr	32(ra) # 80001a20 <_Z12bba_allocatem>
    80003a08:	00050a13          	mv	s4,a0
    if(memory==0) return 0;
    80003a0c:	10050a63          	beqz	a0,80003b20 <_Z14kmem_slab_initP12kmem_cache_s+0x148>

    int bitmapCharCount = (cache->slotsInSlab+8-1)/8;
    80003a10:	05092503          	lw	a0,80(s2)
    80003a14:	0075079b          	addiw	a5,a0,7
    80003a18:	41f7d51b          	sraiw	a0,a5,0x1f
    80003a1c:	01d5551b          	srliw	a0,a0,0x1d
    80003a20:	00f5053b          	addw	a0,a0,a5
    80003a24:	4035551b          	sraiw	a0,a0,0x3
    80003a28:	0005049b          	sext.w	s1,a0
    int descriptorSize = sizeof(kmem_slab_t) + bitmapCharCount*2;
    80003a2c:	0015151b          	slliw	a0,a0,0x1
    kmem_slab_t *slab = (kmem_slab_t*) bba_allocate(descriptorSize);
    80003a30:	0285051b          	addiw	a0,a0,40
    80003a34:	ffffe097          	auipc	ra,0xffffe
    80003a38:	fec080e7          	jalr	-20(ra) # 80001a20 <_Z12bba_allocatem>
    80003a3c:	00050993          	mv	s3,a0
    if(slab==0){
    80003a40:	02050663          	beqz	a0,80003a6c <_Z14kmem_slab_initP12kmem_cache_s+0x94>
        bba_free_block(memory);
        return 0;
    }

    slab->memory=memory;
    80003a44:	01453423          	sd	s4,8(a0)
    slab->freeSlotsBitmap = (char*)slab + sizeof(kmem_slab_t);
    80003a48:	02850793          	addi	a5,a0,40
    80003a4c:	00f53c23          	sd	a5,24(a0)
    slab->initializedSlotsBitmap = slab->freeSlotsBitmap + bitmapCharCount;
    80003a50:	009787b3          	add	a5,a5,s1
    80003a54:	00f53823          	sd	a5,16(a0)
    slab->usedSlotsCount=0;
    80003a58:	00052023          	sw	zero,0(a0)
    slab->initializedSlotsCount=0;
    80003a5c:	00052223          	sw	zero,4(a0)
    slab->nextSlab=0;
    80003a60:	02053023          	sd	zero,32(a0)


    //marks all slots as free, if ctor is provided initializes objects in slab, but no more than ALLOCATION_CHUNK_SIZE objects
    for (int i = 0; i < cache->slotsInSlab; i++) {
    80003a64:	00000493          	li	s1,0
    80003a68:	04c0006f          	j	80003ab4 <_Z14kmem_slab_initP12kmem_cache_s+0xdc>
        bba_free_block(memory);
    80003a6c:	000a0513          	mv	a0,s4
    80003a70:	ffffe097          	auipc	ra,0xffffe
    80003a74:	278080e7          	jalr	632(ra) # 80001ce8 <_Z14bba_free_blockPKv>
        return 0;
    80003a78:	0ac0006f          	j	80003b24 <_Z14kmem_slab_initP12kmem_cache_s+0x14c>
        if (cache->ctor!=0 && i < ALLOCATION_CHUNK_SIZE) {
            cache->ctor(curr);
            slab->initializedSlotsCount++;
            setBitmapValue(slab->initializedSlotsBitmap, i, SLOT_INITIALIZED);
        }
        setBitmapValue(slab->freeSlotsBitmap, i, SLOT_FREE);
    80003a7c:	0189b703          	ld	a4,24(s3)
    int wordPosition = position/8;
    80003a80:	41f4d79b          	sraiw	a5,s1,0x1f
    80003a84:	01d7d69b          	srliw	a3,a5,0x1d
    80003a88:	009687bb          	addw	a5,a3,s1
    80003a8c:	4037d61b          	sraiw	a2,a5,0x3
    int bitPosition = position%8;
    80003a90:	0077f793          	andi	a5,a5,7
    80003a94:	40d787bb          	subw	a5,a5,a3
        bitmapStart[wordPosition] = bitmapStart[wordPosition] | (1<<bitPosition);
    80003a98:	00c70733          	add	a4,a4,a2
    80003a9c:	00070683          	lb	a3,0(a4)
    80003aa0:	00100613          	li	a2,1
    80003aa4:	00f617bb          	sllw	a5,a2,a5
    80003aa8:	00f6e7b3          	or	a5,a3,a5
    80003aac:	00f70023          	sb	a5,0(a4)
    for (int i = 0; i < cache->slotsInSlab; i++) {
    80003ab0:	0014849b          	addiw	s1,s1,1
    80003ab4:	05092783          	lw	a5,80(s2)
    80003ab8:	06f4d663          	bge	s1,a5,80003b24 <_Z14kmem_slab_initP12kmem_cache_s+0x14c>
        char *curr = (char*)memory + i * cache->slotSize;
    80003abc:	02093783          	ld	a5,32(s2)
    80003ac0:	02f487b3          	mul	a5,s1,a5
    80003ac4:	00fa0533          	add	a0,s4,a5
        if (cache->ctor!=0 && i < ALLOCATION_CHUNK_SIZE) {
    80003ac8:	02893783          	ld	a5,40(s2)
    80003acc:	fa0788e3          	beqz	a5,80003a7c <_Z14kmem_slab_initP12kmem_cache_s+0xa4>
    80003ad0:	00f00713          	li	a4,15
    80003ad4:	fa9744e3          	blt	a4,s1,80003a7c <_Z14kmem_slab_initP12kmem_cache_s+0xa4>
            cache->ctor(curr);
    80003ad8:	000780e7          	jalr	a5
            slab->initializedSlotsCount++;
    80003adc:	0049a783          	lw	a5,4(s3)
    80003ae0:	0017879b          	addiw	a5,a5,1
    80003ae4:	00f9a223          	sw	a5,4(s3)
            setBitmapValue(slab->initializedSlotsBitmap, i, SLOT_INITIALIZED);
    80003ae8:	0109b703          	ld	a4,16(s3)
    int wordPosition = position/8;
    80003aec:	41f4d79b          	sraiw	a5,s1,0x1f
    80003af0:	01d7d69b          	srliw	a3,a5,0x1d
    80003af4:	009687bb          	addw	a5,a3,s1
    80003af8:	4037d61b          	sraiw	a2,a5,0x3
    int bitPosition = position%8;
    80003afc:	0077f793          	andi	a5,a5,7
    80003b00:	40d787bb          	subw	a5,a5,a3
        bitmapStart[wordPosition] = bitmapStart[wordPosition] | (1<<bitPosition);
    80003b04:	00c70733          	add	a4,a4,a2
    80003b08:	00070683          	lb	a3,0(a4)
    80003b0c:	00100613          	li	a2,1
    80003b10:	00f617bb          	sllw	a5,a2,a5
    80003b14:	00f6e7b3          	or	a5,a3,a5
    80003b18:	00f70023          	sb	a5,0(a4)
    80003b1c:	f61ff06f          	j	80003a7c <_Z14kmem_slab_initP12kmem_cache_s+0xa4>
    if(memory==0) return 0;
    80003b20:	00050993          	mv	s3,a0
    }

    return slab;
}
    80003b24:	00098513          	mv	a0,s3
    80003b28:	02813083          	ld	ra,40(sp)
    80003b2c:	02013403          	ld	s0,32(sp)
    80003b30:	01813483          	ld	s1,24(sp)
    80003b34:	01013903          	ld	s2,16(sp)
    80003b38:	00813983          	ld	s3,8(sp)
    80003b3c:	00013a03          	ld	s4,0(sp)
    80003b40:	03010113          	addi	sp,sp,48
    80003b44:	00008067          	ret

0000000080003b48 <_Z17kmem_cache_createPKcmPFvPvES3_>:

//creates cache with one empty slab
kmem_cache_t *kmem_cache_create(const char *name, unsigned long size,void (*ctor)(void *),void (*dtor)(void *))
{
    80003b48:	fc010113          	addi	sp,sp,-64
    80003b4c:	02113c23          	sd	ra,56(sp)
    80003b50:	02813823          	sd	s0,48(sp)
    80003b54:	02913423          	sd	s1,40(sp)
    80003b58:	03213023          	sd	s2,32(sp)
    80003b5c:	01313c23          	sd	s3,24(sp)
    80003b60:	01413823          	sd	s4,16(sp)
    80003b64:	01513423          	sd	s5,8(sp)
    80003b68:	04010413          	addi	s0,sp,64
    80003b6c:	00050a93          	mv	s5,a0
    80003b70:	00058913          	mv	s2,a1
    80003b74:	00060a13          	mv	s4,a2
    80003b78:	00068993          	mv	s3,a3
    kmem_cache_t* cache = (kmem_cache_t*) bba_allocate(sizeof(kmem_cache_t));
    80003b7c:	05800513          	li	a0,88
    80003b80:	ffffe097          	auipc	ra,0xffffe
    80003b84:	ea0080e7          	jalr	-352(ra) # 80001a20 <_Z12bba_allocatem>
    80003b88:	00050493          	mv	s1,a0
    if(cache==0) return 0;
    80003b8c:	06050c63          	beqz	a0,80003c04 <_Z17kmem_cache_createPKcmPFvPvES3_+0xbc>

    if(size<SMALL_SIZE) cache->memorySize=SMALL_SLAB;
    80003b90:	03f00793          	li	a5,63
    80003b94:	0927ec63          	bltu	a5,s2,80003c2c <_Z17kmem_cache_createPKcmPFvPvES3_+0xe4>
    80003b98:	000017b7          	lui	a5,0x1
    80003b9c:	04f52423          	sw	a5,72(a0)
    else if(size<LARGE_SIZE) cache->memorySize=MEDIUM_SLAB;
    else cache->memorySize=LARGE_SLAB;

    cache->error=0;
    80003ba0:	0404a623          	sw	zero,76(s1)
    cache->slotsInSlab = cache->memorySize/size;
    80003ba4:	0484a783          	lw	a5,72(s1)
    80003ba8:	0327d7b3          	divu	a5,a5,s2
    80003bac:	04f4a823          	sw	a5,80(s1)
    cache->slotSize=size;
    80003bb0:	0324b023          	sd	s2,32(s1)
    cache->dtor=dtor;
    80003bb4:	0334b823          	sd	s3,48(s1)
    cache->ctor=ctor;
    80003bb8:	0344b423          	sd	s4,40(s1)
    cache->emptySlabsHead=0;
    80003bbc:	0004b023          	sd	zero,0(s1)
    cache->usedSlabsHead=0;
    80003bc0:	0004b423          	sd	zero,8(s1)
    cache->fullSlabsHead=0;
    80003bc4:	0004b823          	sd	zero,16(s1)
    kmem_strcpy(cache->name,name);
    80003bc8:	000a8593          	mv	a1,s5
    80003bcc:	03848513          	addi	a0,s1,56
    80003bd0:	00000097          	auipc	ra,0x0
    80003bd4:	d84080e7          	jalr	-636(ra) # 80003954 <_Z11kmem_strcpyPcPKc>

    kmem_slab_t * slab = kmem_slab_init(cache);
    80003bd8:	00048513          	mv	a0,s1
    80003bdc:	00000097          	auipc	ra,0x0
    80003be0:	dfc080e7          	jalr	-516(ra) # 800039d8 <_Z14kmem_slab_initP12kmem_cache_s>
    80003be4:	00050913          	mv	s2,a0
    if(slab==0){
    80003be8:	06050263          	beqz	a0,80003c4c <_Z17kmem_cache_createPKcmPFvPvES3_+0x104>
        bba_free_block(cache);
        return 0;
    }
    cache->emptySlabsHead=slab;
    80003bec:	00a4b023          	sd	a0,0(s1)

    cache->nextCache=kmem_cache_head;
    80003bf0:	0000a797          	auipc	a5,0xa
    80003bf4:	5f078793          	addi	a5,a5,1520 # 8000e1e0 <kmem_cache_head>
    80003bf8:	0007b703          	ld	a4,0(a5)
    80003bfc:	00e4bc23          	sd	a4,24(s1)
    kmem_cache_head=cache;
    80003c00:	0097b023          	sd	s1,0(a5)
    return cache;
}
    80003c04:	00048513          	mv	a0,s1
    80003c08:	03813083          	ld	ra,56(sp)
    80003c0c:	03013403          	ld	s0,48(sp)
    80003c10:	02813483          	ld	s1,40(sp)
    80003c14:	02013903          	ld	s2,32(sp)
    80003c18:	01813983          	ld	s3,24(sp)
    80003c1c:	01013a03          	ld	s4,16(sp)
    80003c20:	00813a83          	ld	s5,8(sp)
    80003c24:	04010113          	addi	sp,sp,64
    80003c28:	00008067          	ret
    else if(size<LARGE_SIZE) cache->memorySize=MEDIUM_SLAB;
    80003c2c:	0ff00793          	li	a5,255
    80003c30:	0127e863          	bltu	a5,s2,80003c40 <_Z17kmem_cache_createPKcmPFvPvES3_+0xf8>
    80003c34:	000027b7          	lui	a5,0x2
    80003c38:	04f52423          	sw	a5,72(a0)
    80003c3c:	f65ff06f          	j	80003ba0 <_Z17kmem_cache_createPKcmPFvPvES3_+0x58>
    else cache->memorySize=LARGE_SLAB;
    80003c40:	000047b7          	lui	a5,0x4
    80003c44:	04f52423          	sw	a5,72(a0)
    80003c48:	f59ff06f          	j	80003ba0 <_Z17kmem_cache_createPKcmPFvPvES3_+0x58>
        bba_free_block(cache);
    80003c4c:	00048513          	mv	a0,s1
    80003c50:	ffffe097          	auipc	ra,0xffffe
    80003c54:	098080e7          	jalr	152(ra) # 80001ce8 <_Z14bba_free_blockPKv>
        return 0;
    80003c58:	00090493          	mv	s1,s2
    80003c5c:	fa9ff06f          	j	80003c04 <_Z17kmem_cache_createPKcmPFvPvES3_+0xbc>

0000000080003c60 <_Z24kmem_slab_destoy_objectsP11kmem_slab_sP12kmem_cache_s>:

void kmem_slab_destoy_objects(kmem_slab_t* slab, kmem_cache_t* cache)
{
    80003c60:	fd010113          	addi	sp,sp,-48
    80003c64:	02113423          	sd	ra,40(sp)
    80003c68:	02813023          	sd	s0,32(sp)
    80003c6c:	00913c23          	sd	s1,24(sp)
    80003c70:	01213823          	sd	s2,16(sp)
    80003c74:	01313423          	sd	s3,8(sp)
    80003c78:	03010413          	addi	s0,sp,48
    80003c7c:	00050913          	mv	s2,a0
    80003c80:	00058993          	mv	s3,a1
    for(int i=0;i < (cache->slotsInSlab) && (slab->initializedSlotsCount>0); i++){
    80003c84:	00000493          	li	s1,0
    80003c88:	0080006f          	j	80003c90 <_Z24kmem_slab_destoy_objectsP11kmem_slab_sP12kmem_cache_s+0x30>
    80003c8c:	0014849b          	addiw	s1,s1,1
    80003c90:	0509a783          	lw	a5,80(s3)
    80003c94:	06f4d063          	bge	s1,a5,80003cf4 <_Z24kmem_slab_destoy_objectsP11kmem_slab_sP12kmem_cache_s+0x94>
    80003c98:	00492783          	lw	a5,4(s2)
    80003c9c:	04f05c63          	blez	a5,80003cf4 <_Z24kmem_slab_destoy_objectsP11kmem_slab_sP12kmem_cache_s+0x94>
       if(getBitmapValue(slab->initializedSlotsBitmap,i)==SLOT_INITIALIZED){
    80003ca0:	01093703          	ld	a4,16(s2)
    int wordPosition = position/8;
    80003ca4:	41f4d79b          	sraiw	a5,s1,0x1f
    80003ca8:	01d7d79b          	srliw	a5,a5,0x1d
    80003cac:	009787bb          	addw	a5,a5,s1
    80003cb0:	4037d79b          	sraiw	a5,a5,0x3
    return (bitmapStart[wordPosition]>>position)&1;
    80003cb4:	00f707b3          	add	a5,a4,a5
    80003cb8:	0007c783          	lbu	a5,0(a5) # 4000 <_entry-0x7fffc000>
    80003cbc:	4097d7bb          	sraw	a5,a5,s1
    80003cc0:	0017f793          	andi	a5,a5,1
       if(getBitmapValue(slab->initializedSlotsBitmap,i)==SLOT_INITIALIZED){
    80003cc4:	fc0784e3          	beqz	a5,80003c8c <_Z24kmem_slab_destoy_objectsP11kmem_slab_sP12kmem_cache_s+0x2c>
           cache->dtor((char*)(slab->memory)+i*cache->slotSize);
    80003cc8:	0309b703          	ld	a4,48(s3)
    80003ccc:	00893503          	ld	a0,8(s2)
    80003cd0:	0209b783          	ld	a5,32(s3)
    80003cd4:	02f487b3          	mul	a5,s1,a5
    80003cd8:	00f50533          	add	a0,a0,a5
    80003cdc:	000700e7          	jalr	a4
           slab->initializedSlotsCount--;
    80003ce0:	00492783          	lw	a5,4(s2)
    80003ce4:	fff7879b          	addiw	a5,a5,-1
    80003ce8:	0007871b          	sext.w	a4,a5
    80003cec:	00f92223          	sw	a5,4(s2)
           if(slab->initializedSlotsCount==0) return;
    80003cf0:	f8071ee3          	bnez	a4,80003c8c <_Z24kmem_slab_destoy_objectsP11kmem_slab_sP12kmem_cache_s+0x2c>
       }
    }
}
    80003cf4:	02813083          	ld	ra,40(sp)
    80003cf8:	02013403          	ld	s0,32(sp)
    80003cfc:	01813483          	ld	s1,24(sp)
    80003d00:	01013903          	ld	s2,16(sp)
    80003d04:	00813983          	ld	s3,8(sp)
    80003d08:	03010113          	addi	sp,sp,48
    80003d0c:	00008067          	ret

0000000080003d10 <_Z17kmem_cache_shrinkP12kmem_cache_s>:


int kmem_cache_shrink(kmem_cache_t *cachep)
{
    80003d10:	fd010113          	addi	sp,sp,-48
    80003d14:	02113423          	sd	ra,40(sp)
    80003d18:	02813023          	sd	s0,32(sp)
    80003d1c:	00913c23          	sd	s1,24(sp)
    80003d20:	01213823          	sd	s2,16(sp)
    80003d24:	01313423          	sd	s3,8(sp)
    80003d28:	03010413          	addi	s0,sp,48
    80003d2c:	00050913          	mv	s2,a0
    kmem_slab_t *curr = cachep->emptySlabsHead;
    80003d30:	00053483          	ld	s1,0(a0)
    kmem_slab_t *prev = 0;
    80003d34:	0300006f          	j	80003d64 <_Z17kmem_cache_shrinkP12kmem_cache_s+0x54>
    while (curr!=0){
        prev=curr;
        curr=curr->nextSlab;

        if(cachep->ctor!=0){
            kmem_slab_destoy_objects(prev,cachep);
    80003d38:	00090593          	mv	a1,s2
    80003d3c:	00048513          	mv	a0,s1
    80003d40:	00000097          	auipc	ra,0x0
    80003d44:	f20080e7          	jalr	-224(ra) # 80003c60 <_Z24kmem_slab_destoy_objectsP11kmem_slab_sP12kmem_cache_s>
        }

        bba_free_block(prev->memory);
    80003d48:	0084b503          	ld	a0,8(s1)
    80003d4c:	ffffe097          	auipc	ra,0xffffe
    80003d50:	f9c080e7          	jalr	-100(ra) # 80001ce8 <_Z14bba_free_blockPKv>
        bba_free_block(prev);
    80003d54:	00048513          	mv	a0,s1
    80003d58:	ffffe097          	auipc	ra,0xffffe
    80003d5c:	f90080e7          	jalr	-112(ra) # 80001ce8 <_Z14bba_free_blockPKv>
        curr=curr->nextSlab;
    80003d60:	00098493          	mv	s1,s3
    while (curr!=0){
    80003d64:	00048a63          	beqz	s1,80003d78 <_Z17kmem_cache_shrinkP12kmem_cache_s+0x68>
        curr=curr->nextSlab;
    80003d68:	0204b983          	ld	s3,32(s1)
        if(cachep->ctor!=0){
    80003d6c:	02893783          	ld	a5,40(s2)
    80003d70:	fc0794e3          	bnez	a5,80003d38 <_Z17kmem_cache_shrinkP12kmem_cache_s+0x28>
    80003d74:	fd5ff06f          	j	80003d48 <_Z17kmem_cache_shrinkP12kmem_cache_s+0x38>
    }

    cachep->emptySlabsHead=0;
    80003d78:	00093023          	sd	zero,0(s2)
    return 0;
}
    80003d7c:	00000513          	li	a0,0
    80003d80:	02813083          	ld	ra,40(sp)
    80003d84:	02013403          	ld	s0,32(sp)
    80003d88:	01813483          	ld	s1,24(sp)
    80003d8c:	01013903          	ld	s2,16(sp)
    80003d90:	00813983          	ld	s3,8(sp)
    80003d94:	03010113          	addi	sp,sp,48
    80003d98:	00008067          	ret

0000000080003d9c <_Z27kmem_slab_construct_objectsP11kmem_slab_sP12kmem_cache_s>:

//initialize up to ALLOCATION_CHUNK_SIZE objects in a given slab
void kmem_slab_construct_objects(kmem_slab_t *slab, kmem_cache_t *cache)
{
    80003d9c:	fc010113          	addi	sp,sp,-64
    80003da0:	02113c23          	sd	ra,56(sp)
    80003da4:	02813823          	sd	s0,48(sp)
    80003da8:	02913423          	sd	s1,40(sp)
    80003dac:	03213023          	sd	s2,32(sp)
    80003db0:	01313c23          	sd	s3,24(sp)
    80003db4:	01413823          	sd	s4,16(sp)
    80003db8:	01513423          	sd	s5,8(sp)
    80003dbc:	04010413          	addi	s0,sp,64
    80003dc0:	00050993          	mv	s3,a0
    80003dc4:	00058a13          	mv	s4,a1
    int count=0;
    for(int i=0;i<cache->slotsInSlab;i++){
    80003dc8:	00000913          	li	s2,0
    int count=0;
    80003dcc:	00000a93          	li	s5,0
    80003dd0:	0080006f          	j	80003dd8 <_Z27kmem_slab_construct_objectsP11kmem_slab_sP12kmem_cache_s+0x3c>
    for(int i=0;i<cache->slotsInSlab;i++){
    80003dd4:	0019091b          	addiw	s2,s2,1
    80003dd8:	050a2783          	lw	a5,80(s4)
    80003ddc:	0af95863          	bge	s2,a5,80003e8c <_Z27kmem_slab_construct_objectsP11kmem_slab_sP12kmem_cache_s+0xf0>
        if(getBitmapValue(slab->freeSlotsBitmap,i)==SLOT_FREE &&
    80003de0:	0189b783          	ld	a5,24(s3)
    int wordPosition = position/8;
    80003de4:	41f9549b          	sraiw	s1,s2,0x1f
    80003de8:	01d4d49b          	srliw	s1,s1,0x1d
    80003dec:	012484bb          	addw	s1,s1,s2
    80003df0:	4034d49b          	sraiw	s1,s1,0x3
    return (bitmapStart[wordPosition]>>position)&1;
    80003df4:	009787b3          	add	a5,a5,s1
    80003df8:	0007c783          	lbu	a5,0(a5)
    80003dfc:	4127d7bb          	sraw	a5,a5,s2
    80003e00:	0017f793          	andi	a5,a5,1
        if(getBitmapValue(slab->freeSlotsBitmap,i)==SLOT_FREE &&
    80003e04:	fc0788e3          	beqz	a5,80003dd4 <_Z27kmem_slab_construct_objectsP11kmem_slab_sP12kmem_cache_s+0x38>
           getBitmapValue(slab->initializedSlotsBitmap,i)!=SLOT_INITIALIZED)
    80003e08:	0109b783          	ld	a5,16(s3)
    return (bitmapStart[wordPosition]>>position)&1;
    80003e0c:	009787b3          	add	a5,a5,s1
    80003e10:	0007c783          	lbu	a5,0(a5)
    80003e14:	4127d7bb          	sraw	a5,a5,s2
    80003e18:	0017f793          	andi	a5,a5,1
        if(getBitmapValue(slab->freeSlotsBitmap,i)==SLOT_FREE &&
    80003e1c:	fa079ce3          	bnez	a5,80003dd4 <_Z27kmem_slab_construct_objectsP11kmem_slab_sP12kmem_cache_s+0x38>
        {
            cache->ctor((char*)(slab->memory)+i*cache->slotSize);
    80003e20:	028a3703          	ld	a4,40(s4)
    80003e24:	0089b503          	ld	a0,8(s3)
    80003e28:	020a3783          	ld	a5,32(s4)
    80003e2c:	02f907b3          	mul	a5,s2,a5
    80003e30:	00f50533          	add	a0,a0,a5
    80003e34:	000700e7          	jalr	a4
            slab->initializedSlotsCount++;
    80003e38:	0049a783          	lw	a5,4(s3)
    80003e3c:	0017879b          	addiw	a5,a5,1
    80003e40:	00f9a223          	sw	a5,4(s3)
            setBitmapValue(slab->initializedSlotsBitmap,i,SLOT_INITIALIZED);
    80003e44:	0109b703          	ld	a4,16(s3)
    int bitPosition = position%8;
    80003e48:	41f9579b          	sraiw	a5,s2,0x1f
    80003e4c:	01d7d69b          	srliw	a3,a5,0x1d
    80003e50:	012687bb          	addw	a5,a3,s2
    80003e54:	0077f793          	andi	a5,a5,7
    80003e58:	40d787bb          	subw	a5,a5,a3
        bitmapStart[wordPosition] = bitmapStart[wordPosition] | (1<<bitPosition);
    80003e5c:	009704b3          	add	s1,a4,s1
    80003e60:	00048703          	lb	a4,0(s1)
    80003e64:	00100693          	li	a3,1
    80003e68:	00f697bb          	sllw	a5,a3,a5
    80003e6c:	00f767b3          	or	a5,a4,a5
    80003e70:	00f48023          	sb	a5,0(s1)
            count++;
    80003e74:	001a8a9b          	addiw	s5,s5,1
            if(count==ALLOCATION_CHUNK_SIZE || slab->initializedSlotsCount==cache->slotsInSlab) return;
    80003e78:	01000793          	li	a5,16
    80003e7c:	00fa8863          	beq	s5,a5,80003e8c <_Z27kmem_slab_construct_objectsP11kmem_slab_sP12kmem_cache_s+0xf0>
    80003e80:	0049a703          	lw	a4,4(s3)
    80003e84:	050a2783          	lw	a5,80(s4)
    80003e88:	f4f716e3          	bne	a4,a5,80003dd4 <_Z27kmem_slab_construct_objectsP11kmem_slab_sP12kmem_cache_s+0x38>
        }
    }
}
    80003e8c:	03813083          	ld	ra,56(sp)
    80003e90:	03013403          	ld	s0,48(sp)
    80003e94:	02813483          	ld	s1,40(sp)
    80003e98:	02013903          	ld	s2,32(sp)
    80003e9c:	01813983          	ld	s3,24(sp)
    80003ea0:	01013a03          	ld	s4,16(sp)
    80003ea4:	00813a83          	ld	s5,8(sp)
    80003ea8:	04010113          	addi	sp,sp,64
    80003eac:	00008067          	ret

0000000080003eb0 <_Z25kmem_slab_get_free_objectP11kmem_slab_sP12kmem_cache_s>:



void* kmem_slab_get_free_object(kmem_slab_t *slab, kmem_cache_t *cache)
{
    80003eb0:	ff010113          	addi	sp,sp,-16
    80003eb4:	00813423          	sd	s0,8(sp)
    80003eb8:	01010413          	addi	s0,sp,16
    int charCnt = (cache->slotsInSlab+8-1)/8;
    80003ebc:	0505a783          	lw	a5,80(a1)
    80003ec0:	0077871b          	addiw	a4,a5,7
    80003ec4:	41f7579b          	sraiw	a5,a4,0x1f
    80003ec8:	01d7d79b          	srliw	a5,a5,0x1d
    80003ecc:	00e787bb          	addw	a5,a5,a4
    80003ed0:	4037d79b          	sraiw	a5,a5,0x3
    for(int i=0;i<charCnt;i++){
    80003ed4:	00000693          	li	a3,0
    80003ed8:	0af6d263          	bge	a3,a5,80003f7c <_Z25kmem_slab_get_free_objectP11kmem_slab_sP12kmem_cache_s+0xcc>
        char c = slab->freeSlotsBitmap[i];
    80003edc:	01853803          	ld	a6,24(a0)
    80003ee0:	00d80733          	add	a4,a6,a3
    80003ee4:	00074603          	lbu	a2,0(a4)
        if(c==0) continue; //a quick way to check 8 slots at once
    80003ee8:	02060263          	beqz	a2,80003f0c <_Z25kmem_slab_get_free_objectP11kmem_slab_sP12kmem_cache_s+0x5c>
        int k = 0;
    80003eec:	00000793          	li	a5,0
        while(k<8){
    80003ef0:	00700713          	li	a4,7
    80003ef4:	02f74063          	blt	a4,a5,80003f14 <_Z25kmem_slab_get_free_objectP11kmem_slab_sP12kmem_cache_s+0x64>
            if( ((c>>k)&1) == SLOT_FREE) break;
    80003ef8:	40f6573b          	sraw	a4,a2,a5
    80003efc:	00177713          	andi	a4,a4,1
    80003f00:	00071a63          	bnez	a4,80003f14 <_Z25kmem_slab_get_free_objectP11kmem_slab_sP12kmem_cache_s+0x64>
            k++;
    80003f04:	0017879b          	addiw	a5,a5,1
        while(k<8){
    80003f08:	fe9ff06f          	j	80003ef0 <_Z25kmem_slab_get_free_objectP11kmem_slab_sP12kmem_cache_s+0x40>
    for(int i=0;i<charCnt;i++){
    80003f0c:	0016869b          	addiw	a3,a3,1
    80003f10:	fc9ff06f          	j	80003ed8 <_Z25kmem_slab_get_free_objectP11kmem_slab_sP12kmem_cache_s+0x28>
        }

        slab->usedSlotsCount++;
    80003f14:	00052703          	lw	a4,0(a0)
    80003f18:	0017071b          	addiw	a4,a4,1
    80003f1c:	00e52023          	sw	a4,0(a0)
        setBitmapValue(slab->freeSlotsBitmap,i*8+k,SLOT_TAKEN);
    80003f20:	0036969b          	slliw	a3,a3,0x3
    80003f24:	00f687bb          	addw	a5,a3,a5
    80003f28:	0007869b          	sext.w	a3,a5
    int wordPosition = position/8;
    80003f2c:	41f7d71b          	sraiw	a4,a5,0x1f
    80003f30:	01d7571b          	srliw	a4,a4,0x1d
    80003f34:	00f707bb          	addw	a5,a4,a5
    80003f38:	4037d61b          	sraiw	a2,a5,0x3
    int bitPosition = position%8;
    80003f3c:	0077f793          	andi	a5,a5,7
    80003f40:	40e787bb          	subw	a5,a5,a4
        bitmapStart[wordPosition] = bitmapStart[wordPosition] & (~(1<<bitPosition));
    80003f44:	00c80833          	add	a6,a6,a2
    80003f48:	00080603          	lb	a2,0(a6)
    80003f4c:	00100713          	li	a4,1
    80003f50:	00f717bb          	sllw	a5,a4,a5
    80003f54:	fff7c793          	not	a5,a5
    80003f58:	00f677b3          	and	a5,a2,a5
    80003f5c:	00f80023          	sb	a5,0(a6)
        return ((char*)slab->memory+(i*8+k)*cache->slotSize);
    80003f60:	00853503          	ld	a0,8(a0)
    80003f64:	0205b783          	ld	a5,32(a1)
    80003f68:	02f687b3          	mul	a5,a3,a5
    80003f6c:	00f50533          	add	a0,a0,a5
    }
    return 0;
}
    80003f70:	00813403          	ld	s0,8(sp)
    80003f74:	01010113          	addi	sp,sp,16
    80003f78:	00008067          	ret
    return 0;
    80003f7c:	00000513          	li	a0,0
    80003f80:	ff1ff06f          	j	80003f70 <_Z25kmem_slab_get_free_objectP11kmem_slab_sP12kmem_cache_s+0xc0>

0000000080003f84 <_Z37kmem_slab_get_initialized_free_objectP11kmem_slab_sP12kmem_cache_s>:

void* kmem_slab_get_initialized_free_object(kmem_slab_t *slab, kmem_cache_t *cache)
{
    80003f84:	ff010113          	addi	sp,sp,-16
    80003f88:	00813423          	sd	s0,8(sp)
    80003f8c:	01010413          	addi	s0,sp,16
    int charCnt = (cache->slotsInSlab+8-1)/8;
    80003f90:	0505a783          	lw	a5,80(a1)
    80003f94:	0077871b          	addiw	a4,a5,7
    80003f98:	41f7579b          	sraiw	a5,a4,0x1f
    80003f9c:	01d7d79b          	srliw	a5,a5,0x1d
    80003fa0:	00e787bb          	addw	a5,a5,a4
    80003fa4:	4037d79b          	sraiw	a5,a5,0x3
    for(int i=0;i<charCnt;i++){
    80003fa8:	00000693          	li	a3,0
    80003fac:	0af6da63          	bge	a3,a5,80004060 <_Z37kmem_slab_get_initialized_free_objectP11kmem_slab_sP12kmem_cache_s+0xdc>
        char c = (char)(slab->initializedSlotsBitmap[i]&slab->freeSlotsBitmap[i]);
    80003fb0:	01053703          	ld	a4,16(a0)
    80003fb4:	00d70733          	add	a4,a4,a3
    80003fb8:	00074603          	lbu	a2,0(a4)
    80003fbc:	01853803          	ld	a6,24(a0)
    80003fc0:	00d80733          	add	a4,a6,a3
    80003fc4:	00074703          	lbu	a4,0(a4)
    80003fc8:	00e67633          	and	a2,a2,a4
        if(c==0) continue; //a quick way to check 8 slots at once
    80003fcc:	02060263          	beqz	a2,80003ff0 <_Z37kmem_slab_get_initialized_free_objectP11kmem_slab_sP12kmem_cache_s+0x6c>
        int k = 0;
    80003fd0:	00000793          	li	a5,0
        while(k<8){
    80003fd4:	00700713          	li	a4,7
    80003fd8:	02f74063          	blt	a4,a5,80003ff8 <_Z37kmem_slab_get_initialized_free_objectP11kmem_slab_sP12kmem_cache_s+0x74>
            if((c>>k)&SLOT_INITIALIZED) break;
    80003fdc:	40f6573b          	sraw	a4,a2,a5
    80003fe0:	00177713          	andi	a4,a4,1
    80003fe4:	00071a63          	bnez	a4,80003ff8 <_Z37kmem_slab_get_initialized_free_objectP11kmem_slab_sP12kmem_cache_s+0x74>
            k++;
    80003fe8:	0017879b          	addiw	a5,a5,1
        while(k<8){
    80003fec:	fe9ff06f          	j	80003fd4 <_Z37kmem_slab_get_initialized_free_objectP11kmem_slab_sP12kmem_cache_s+0x50>
    for(int i=0;i<charCnt;i++){
    80003ff0:	0016869b          	addiw	a3,a3,1
    80003ff4:	fb9ff06f          	j	80003fac <_Z37kmem_slab_get_initialized_free_objectP11kmem_slab_sP12kmem_cache_s+0x28>
        }

        slab->usedSlotsCount++;
    80003ff8:	00052703          	lw	a4,0(a0)
    80003ffc:	0017071b          	addiw	a4,a4,1
    80004000:	00e52023          	sw	a4,0(a0)
        setBitmapValue(slab->freeSlotsBitmap,i*8+k,SLOT_TAKEN);
    80004004:	0036969b          	slliw	a3,a3,0x3
    80004008:	00f687bb          	addw	a5,a3,a5
    8000400c:	0007869b          	sext.w	a3,a5
    int wordPosition = position/8;
    80004010:	41f7d71b          	sraiw	a4,a5,0x1f
    80004014:	01d7571b          	srliw	a4,a4,0x1d
    80004018:	00f707bb          	addw	a5,a4,a5
    8000401c:	4037d61b          	sraiw	a2,a5,0x3
    int bitPosition = position%8;
    80004020:	0077f793          	andi	a5,a5,7
    80004024:	40e787bb          	subw	a5,a5,a4
        bitmapStart[wordPosition] = bitmapStart[wordPosition] & (~(1<<bitPosition));
    80004028:	00c80833          	add	a6,a6,a2
    8000402c:	00080603          	lb	a2,0(a6)
    80004030:	00100713          	li	a4,1
    80004034:	00f717bb          	sllw	a5,a4,a5
    80004038:	fff7c793          	not	a5,a5
    8000403c:	00f677b3          	and	a5,a2,a5
    80004040:	00f80023          	sb	a5,0(a6)
        return ((char*)slab->memory+(i*8+k)*cache->slotSize);
    80004044:	00853503          	ld	a0,8(a0)
    80004048:	0205b783          	ld	a5,32(a1)
    8000404c:	02f687b3          	mul	a5,a3,a5
    80004050:	00f50533          	add	a0,a0,a5
    }
    return 0;
}
    80004054:	00813403          	ld	s0,8(sp)
    80004058:	01010113          	addi	sp,sp,16
    8000405c:	00008067          	ret
    return 0;
    80004060:	00000513          	li	a0,0
    80004064:	ff1ff06f          	j	80004054 <_Z37kmem_slab_get_initialized_free_objectP11kmem_slab_sP12kmem_cache_s+0xd0>

0000000080004068 <_Z31kmem_cache_alloc_no_constructorP12kmem_cache_s>:


void *kmem_cache_alloc_no_constructor(kmem_cache_t* cachep)
{
    80004068:	fe010113          	addi	sp,sp,-32
    8000406c:	00113c23          	sd	ra,24(sp)
    80004070:	00813823          	sd	s0,16(sp)
    80004074:	00913423          	sd	s1,8(sp)
    80004078:	02010413          	addi	s0,sp,32
    8000407c:	00050493          	mv	s1,a0
    if(cachep->usedSlabsHead==0){
    80004080:	00853503          	ld	a0,8(a0)
    80004084:	04051863          	bnez	a0,800040d4 <_Z31kmem_cache_alloc_no_constructorP12kmem_cache_s+0x6c>
        if(cachep->emptySlabsHead==0){
    80004088:	0004b783          	ld	a5,0(s1)
    8000408c:	02078a63          	beqz	a5,800040c0 <_Z31kmem_cache_alloc_no_constructorP12kmem_cache_s+0x58>
            cachep->usedSlabsHead = kmem_slab_init(cachep);
        }
        else {
            cachep->usedSlabsHead=cachep->emptySlabsHead;
    80004090:	00f4b423          	sd	a5,8(s1)
            cachep->emptySlabsHead=cachep->emptySlabsHead->nextSlab;
    80004094:	0207b783          	ld	a5,32(a5)
    80004098:	00f4b023          	sd	a5,0(s1)
        }
        return kmem_slab_get_free_object(cachep->usedSlabsHead,cachep);
    8000409c:	00048593          	mv	a1,s1
    800040a0:	0084b503          	ld	a0,8(s1)
    800040a4:	00000097          	auipc	ra,0x0
    800040a8:	e0c080e7          	jalr	-500(ra) # 80003eb0 <_Z25kmem_slab_get_free_objectP11kmem_slab_sP12kmem_cache_s>
            head->nextSlab=cachep->fullSlabsHead;
            cachep->fullSlabsHead=head;
        }
        return result;
    }
}
    800040ac:	01813083          	ld	ra,24(sp)
    800040b0:	01013403          	ld	s0,16(sp)
    800040b4:	00813483          	ld	s1,8(sp)
    800040b8:	02010113          	addi	sp,sp,32
    800040bc:	00008067          	ret
            cachep->usedSlabsHead = kmem_slab_init(cachep);
    800040c0:	00048513          	mv	a0,s1
    800040c4:	00000097          	auipc	ra,0x0
    800040c8:	914080e7          	jalr	-1772(ra) # 800039d8 <_Z14kmem_slab_initP12kmem_cache_s>
    800040cc:	00a4b423          	sd	a0,8(s1)
    800040d0:	fcdff06f          	j	8000409c <_Z31kmem_cache_alloc_no_constructorP12kmem_cache_s+0x34>
        void* result = kmem_slab_get_free_object(cachep->usedSlabsHead,cachep);
    800040d4:	00048593          	mv	a1,s1
    800040d8:	00000097          	auipc	ra,0x0
    800040dc:	dd8080e7          	jalr	-552(ra) # 80003eb0 <_Z25kmem_slab_get_free_objectP11kmem_slab_sP12kmem_cache_s>
        kmem_slab_t* head = cachep->usedSlabsHead;
    800040e0:	0084b783          	ld	a5,8(s1)
        if(head->usedSlotsCount==cachep->slotsInSlab){
    800040e4:	0007a683          	lw	a3,0(a5)
    800040e8:	0504a703          	lw	a4,80(s1)
    800040ec:	fce690e3          	bne	a3,a4,800040ac <_Z31kmem_cache_alloc_no_constructorP12kmem_cache_s+0x44>
            cachep->usedSlabsHead=head->nextSlab;
    800040f0:	0207b703          	ld	a4,32(a5)
    800040f4:	00e4b423          	sd	a4,8(s1)
            head->nextSlab=cachep->fullSlabsHead;
    800040f8:	0104b703          	ld	a4,16(s1)
    800040fc:	02e7b023          	sd	a4,32(a5)
            cachep->fullSlabsHead=head;
    80004100:	00f4b823          	sd	a5,16(s1)
        return result;
    80004104:	fa9ff06f          	j	800040ac <_Z31kmem_cache_alloc_no_constructorP12kmem_cache_s+0x44>

0000000080004108 <_Z28kmem_cache_alloc_constructorP12kmem_cache_s>:


void *kmem_cache_alloc_constructor(kmem_cache_t *cachep)
{
    80004108:	fd010113          	addi	sp,sp,-48
    8000410c:	02113423          	sd	ra,40(sp)
    80004110:	02813023          	sd	s0,32(sp)
    80004114:	00913c23          	sd	s1,24(sp)
    80004118:	01213823          	sd	s2,16(sp)
    8000411c:	01313423          	sd	s3,8(sp)
    80004120:	03010413          	addi	s0,sp,48
    80004124:	00050913          	mv	s2,a0
    if(cachep->usedSlabsHead==0){
    80004128:	00853983          	ld	s3,8(a0)
    8000412c:	02098063          	beqz	s3,8000414c <_Z28kmem_cache_alloc_constructorP12kmem_cache_s+0x44>
            cachep->emptySlabsHead=cachep->emptySlabsHead->nextSlab;
        }
        return kmem_slab_get_initialized_free_object(cachep->usedSlabsHead,cachep);
    }
    else{
        kmem_slab_t* target = cachep->usedSlabsHead;
    80004130:	00098493          	mv	s1,s3
        while (target!=0){
    80004134:	06048463          	beqz	s1,8000419c <_Z28kmem_cache_alloc_constructorP12kmem_cache_s+0x94>
            if(target->initializedSlotsCount>target->usedSlotsCount) break;
    80004138:	0044a703          	lw	a4,4(s1)
    8000413c:	0004a783          	lw	a5,0(s1)
    80004140:	04e7ce63          	blt	a5,a4,8000419c <_Z28kmem_cache_alloc_constructorP12kmem_cache_s+0x94>
            target=target->nextSlab;
    80004144:	0204b483          	ld	s1,32(s1)
        while (target!=0){
    80004148:	fedff06f          	j	80004134 <_Z28kmem_cache_alloc_constructorP12kmem_cache_s+0x2c>
        if(cachep->emptySlabsHead==0){
    8000414c:	00053783          	ld	a5,0(a0)
    80004150:	02078e63          	beqz	a5,8000418c <_Z28kmem_cache_alloc_constructorP12kmem_cache_s+0x84>
            cachep->usedSlabsHead=cachep->emptySlabsHead;
    80004154:	00f53423          	sd	a5,8(a0)
            cachep->emptySlabsHead=cachep->emptySlabsHead->nextSlab;
    80004158:	0207b783          	ld	a5,32(a5)
    8000415c:	00f53023          	sd	a5,0(a0)
        return kmem_slab_get_initialized_free_object(cachep->usedSlabsHead,cachep);
    80004160:	00090593          	mv	a1,s2
    80004164:	00893503          	ld	a0,8(s2)
    80004168:	00000097          	auipc	ra,0x0
    8000416c:	e1c080e7          	jalr	-484(ra) # 80003f84 <_Z37kmem_slab_get_initialized_free_objectP11kmem_slab_sP12kmem_cache_s>
            target->nextSlab=cachep->fullSlabsHead;
            cachep->fullSlabsHead=target;
        }
        return result;
    }
}
    80004170:	02813083          	ld	ra,40(sp)
    80004174:	02013403          	ld	s0,32(sp)
    80004178:	01813483          	ld	s1,24(sp)
    8000417c:	01013903          	ld	s2,16(sp)
    80004180:	00813983          	ld	s3,8(sp)
    80004184:	03010113          	addi	sp,sp,48
    80004188:	00008067          	ret
            cachep->usedSlabsHead = kmem_slab_init(cachep);
    8000418c:	00000097          	auipc	ra,0x0
    80004190:	84c080e7          	jalr	-1972(ra) # 800039d8 <_Z14kmem_slab_initP12kmem_cache_s>
    80004194:	00a93423          	sd	a0,8(s2)
    80004198:	fc9ff06f          	j	80004160 <_Z28kmem_cache_alloc_constructorP12kmem_cache_s+0x58>
        if(target==0){
    8000419c:	04048663          	beqz	s1,800041e8 <_Z28kmem_cache_alloc_constructorP12kmem_cache_s+0xe0>
        void* result = kmem_slab_get_initialized_free_object(target,cachep);
    800041a0:	00090593          	mv	a1,s2
    800041a4:	00048513          	mv	a0,s1
    800041a8:	00000097          	auipc	ra,0x0
    800041ac:	ddc080e7          	jalr	-548(ra) # 80003f84 <_Z37kmem_slab_get_initialized_free_objectP11kmem_slab_sP12kmem_cache_s>
        if(target->usedSlotsCount==cachep->slotsInSlab){
    800041b0:	0004a703          	lw	a4,0(s1)
    800041b4:	05092783          	lw	a5,80(s2)
    800041b8:	faf71ce3          	bne	a4,a5,80004170 <_Z28kmem_cache_alloc_constructorP12kmem_cache_s+0x68>
            if(target==cachep->usedSlabsHead){
    800041bc:	00893783          	ld	a5,8(s2)
    800041c0:	04978063          	beq	a5,s1,80004200 <_Z28kmem_cache_alloc_constructorP12kmem_cache_s+0xf8>
                while (prev->nextSlab!=target) prev=prev->nextSlab;
    800041c4:	00078713          	mv	a4,a5
    800041c8:	0207b783          	ld	a5,32(a5)
    800041cc:	fe979ce3          	bne	a5,s1,800041c4 <_Z28kmem_cache_alloc_constructorP12kmem_cache_s+0xbc>
                prev->nextSlab=target->nextSlab;
    800041d0:	0204b783          	ld	a5,32(s1)
    800041d4:	02f73023          	sd	a5,32(a4)
            target->nextSlab=cachep->fullSlabsHead;
    800041d8:	01093783          	ld	a5,16(s2)
    800041dc:	02f4b023          	sd	a5,32(s1)
            cachep->fullSlabsHead=target;
    800041e0:	00993823          	sd	s1,16(s2)
        return result;
    800041e4:	f8dff06f          	j	80004170 <_Z28kmem_cache_alloc_constructorP12kmem_cache_s+0x68>
            kmem_slab_construct_objects(target,cachep);
    800041e8:	00090593          	mv	a1,s2
    800041ec:	00098513          	mv	a0,s3
    800041f0:	00000097          	auipc	ra,0x0
    800041f4:	bac080e7          	jalr	-1108(ra) # 80003d9c <_Z27kmem_slab_construct_objectsP11kmem_slab_sP12kmem_cache_s>
            target=cachep->usedSlabsHead;
    800041f8:	00098493          	mv	s1,s3
    800041fc:	fa5ff06f          	j	800041a0 <_Z28kmem_cache_alloc_constructorP12kmem_cache_s+0x98>
                cachep->usedSlabsHead=target->nextSlab;
    80004200:	0204b783          	ld	a5,32(s1)
    80004204:	00f93423          	sd	a5,8(s2)
    80004208:	fd1ff06f          	j	800041d8 <_Z28kmem_cache_alloc_constructorP12kmem_cache_s+0xd0>

000000008000420c <_Z16kmem_cache_allocP12kmem_cache_s>:

void *kmem_cache_alloc(kmem_cache_t* cachep){
    8000420c:	ff010113          	addi	sp,sp,-16
    80004210:	00113423          	sd	ra,8(sp)
    80004214:	00813023          	sd	s0,0(sp)
    80004218:	01010413          	addi	s0,sp,16
    if(cachep->ctor!=0) return kmem_cache_alloc_constructor(cachep);
    8000421c:	02853783          	ld	a5,40(a0)
    80004220:	00078e63          	beqz	a5,8000423c <_Z16kmem_cache_allocP12kmem_cache_s+0x30>
    80004224:	00000097          	auipc	ra,0x0
    80004228:	ee4080e7          	jalr	-284(ra) # 80004108 <_Z28kmem_cache_alloc_constructorP12kmem_cache_s>
    else return kmem_cache_alloc_no_constructor(cachep);
}
    8000422c:	00813083          	ld	ra,8(sp)
    80004230:	00013403          	ld	s0,0(sp)
    80004234:	01010113          	addi	sp,sp,16
    80004238:	00008067          	ret
    else return kmem_cache_alloc_no_constructor(cachep);
    8000423c:	00000097          	auipc	ra,0x0
    80004240:	e2c080e7          	jalr	-468(ra) # 80004068 <_Z31kmem_cache_alloc_no_constructorP12kmem_cache_s>
    80004244:	fe9ff06f          	j	8000422c <_Z16kmem_cache_allocP12kmem_cache_s+0x20>

0000000080004248 <_Z15kmem_cache_freeP12kmem_cache_sPv>:

// Deallocate one object from cache
void kmem_cache_free(kmem_cache_t *cachep, void *objp)
{
    80004248:	ff010113          	addi	sp,sp,-16
    8000424c:	00813423          	sd	s0,8(sp)
    80004250:	01010413          	addi	s0,sp,16
    //look for the object amongst nonfull slabs
    kmem_slab_t* curr = cachep->usedSlabsHead;
    80004254:	00853783          	ld	a5,8(a0)
    kmem_slab_t* prev = 0;
    80004258:	00000613          	li	a2,0
    8000425c:	0180006f          	j	80004274 <_Z15kmem_cache_freeP12kmem_cache_sPv+0x2c>
            int positionInSlab = ((char*)objp - (char*)curr->memory)/cachep->slotSize;
            setBitmapValue(curr->freeSlotsBitmap,positionInSlab,SLOT_FREE);
            curr->usedSlotsCount--;
            if(curr->usedSlotsCount==0){
                if(prev==0){
                    cachep->usedSlabsHead=curr->nextSlab;
    80004260:	0207b703          	ld	a4,32(a5)
    80004264:	00e53423          	sd	a4,8(a0)
    80004268:	0840006f          	j	800042ec <_Z15kmem_cache_freeP12kmem_cache_sPv+0xa4>
                curr->nextSlab=cachep->emptySlabsHead;
                cachep->emptySlabsHead=curr;
            }
            return;
        }
        prev=curr;
    8000426c:	00078613          	mv	a2,a5
        curr=curr->nextSlab;
    80004270:	0207b783          	ld	a5,32(a5)
    while(curr!=0){
    80004274:	08078463          	beqz	a5,800042fc <_Z15kmem_cache_freeP12kmem_cache_sPv+0xb4>
        if(objp>curr->memory && objp<((char*)(curr->memory)+cachep->memorySize)){
    80004278:	0087b703          	ld	a4,8(a5)
    8000427c:	feb778e3          	bgeu	a4,a1,8000426c <_Z15kmem_cache_freeP12kmem_cache_sPv+0x24>
    80004280:	04852683          	lw	a3,72(a0)
    80004284:	00d706b3          	add	a3,a4,a3
    80004288:	fed5f2e3          	bgeu	a1,a3,8000426c <_Z15kmem_cache_freeP12kmem_cache_sPv+0x24>
            int positionInSlab = ((char*)objp - (char*)curr->memory)/cachep->slotSize;
    8000428c:	40e58733          	sub	a4,a1,a4
    80004290:	02053583          	ld	a1,32(a0)
    80004294:	02b75733          	divu	a4,a4,a1
            setBitmapValue(curr->freeSlotsBitmap,positionInSlab,SLOT_FREE);
    80004298:	0187b683          	ld	a3,24(a5)
    int wordPosition = position/8;
    8000429c:	41f7559b          	sraiw	a1,a4,0x1f
    800042a0:	01d5d59b          	srliw	a1,a1,0x1d
    800042a4:	00e5873b          	addw	a4,a1,a4
    800042a8:	4037581b          	sraiw	a6,a4,0x3
    int bitPosition = position%8;
    800042ac:	00777713          	andi	a4,a4,7
    800042b0:	40b7073b          	subw	a4,a4,a1
        bitmapStart[wordPosition] = bitmapStart[wordPosition] | (1<<bitPosition);
    800042b4:	010686b3          	add	a3,a3,a6
    800042b8:	00068583          	lb	a1,0(a3)
    800042bc:	00100813          	li	a6,1
    800042c0:	00e8173b          	sllw	a4,a6,a4
    800042c4:	00e5e733          	or	a4,a1,a4
    800042c8:	00e68023          	sb	a4,0(a3)
            curr->usedSlotsCount--;
    800042cc:	0007a703          	lw	a4,0(a5)
    800042d0:	fff7071b          	addiw	a4,a4,-1
    800042d4:	0007069b          	sext.w	a3,a4
    800042d8:	00e7a023          	sw	a4,0(a5)
            if(curr->usedSlotsCount==0){
    800042dc:	0a069c63          	bnez	a3,80004394 <_Z15kmem_cache_freeP12kmem_cache_sPv+0x14c>
                if(prev==0){
    800042e0:	f80600e3          	beqz	a2,80004260 <_Z15kmem_cache_freeP12kmem_cache_sPv+0x18>
                    prev->nextSlab=curr->nextSlab;
    800042e4:	0207b703          	ld	a4,32(a5)
    800042e8:	02e63023          	sd	a4,32(a2)
                curr->nextSlab=cachep->emptySlabsHead;
    800042ec:	00053703          	ld	a4,0(a0)
    800042f0:	02e7b023          	sd	a4,32(a5)
                cachep->emptySlabsHead=curr;
    800042f4:	00f53023          	sd	a5,0(a0)
            return;
    800042f8:	09c0006f          	j	80004394 <_Z15kmem_cache_freeP12kmem_cache_sPv+0x14c>
    }

    //amongst full slabs
    curr=cachep->fullSlabsHead;
    800042fc:	01053703          	ld	a4,16(a0)
    prev=0;
    80004300:	0180006f          	j	80004318 <_Z15kmem_cache_freeP12kmem_cache_sPv+0xd0>
        if(objp>curr->memory && objp<((char*)(curr->memory)+cachep->memorySize)){
            int positionInSlab = ((char*)objp - (char*)curr->memory)/cachep->slotSize;
            setBitmapValue(curr->freeSlotsBitmap,positionInSlab,SLOT_FREE);
            curr->usedSlotsCount--;
            if(prev==0){
                cachep->fullSlabsHead=curr->nextSlab;
    80004304:	02073783          	ld	a5,32(a4)
    80004308:	00f53823          	sd	a5,16(a0)
    8000430c:	07c0006f          	j	80004388 <_Z15kmem_cache_freeP12kmem_cache_sPv+0x140>
            }
            curr->nextSlab=cachep->usedSlabsHead;
            cachep->usedSlabsHead=curr;
            return;
        }
        prev=curr;
    80004310:	00070793          	mv	a5,a4
        curr=curr->nextSlab;
    80004314:	02073703          	ld	a4,32(a4)
    while(curr!=0){
    80004318:	06070e63          	beqz	a4,80004394 <_Z15kmem_cache_freeP12kmem_cache_sPv+0x14c>
        if(objp>curr->memory && objp<((char*)(curr->memory)+cachep->memorySize)){
    8000431c:	00873683          	ld	a3,8(a4)
    80004320:	feb6f8e3          	bgeu	a3,a1,80004310 <_Z15kmem_cache_freeP12kmem_cache_sPv+0xc8>
    80004324:	04852603          	lw	a2,72(a0)
    80004328:	00c68633          	add	a2,a3,a2
    8000432c:	fec5f2e3          	bgeu	a1,a2,80004310 <_Z15kmem_cache_freeP12kmem_cache_sPv+0xc8>
            int positionInSlab = ((char*)objp - (char*)curr->memory)/cachep->slotSize;
    80004330:	40d586b3          	sub	a3,a1,a3
    80004334:	02053583          	ld	a1,32(a0)
    80004338:	02b6d6b3          	divu	a3,a3,a1
            setBitmapValue(curr->freeSlotsBitmap,positionInSlab,SLOT_FREE);
    8000433c:	01873603          	ld	a2,24(a4)
    int wordPosition = position/8;
    80004340:	41f6d59b          	sraiw	a1,a3,0x1f
    80004344:	01d5d59b          	srliw	a1,a1,0x1d
    80004348:	00d586bb          	addw	a3,a1,a3
    8000434c:	4036d81b          	sraiw	a6,a3,0x3
    int bitPosition = position%8;
    80004350:	0076f693          	andi	a3,a3,7
    80004354:	40b686bb          	subw	a3,a3,a1
        bitmapStart[wordPosition] = bitmapStart[wordPosition] | (1<<bitPosition);
    80004358:	01060633          	add	a2,a2,a6
    8000435c:	00060583          	lb	a1,0(a2)
    80004360:	00100813          	li	a6,1
    80004364:	00d816bb          	sllw	a3,a6,a3
    80004368:	00d5e6b3          	or	a3,a1,a3
    8000436c:	00d60023          	sb	a3,0(a2)
            curr->usedSlotsCount--;
    80004370:	00072683          	lw	a3,0(a4)
    80004374:	fff6869b          	addiw	a3,a3,-1
    80004378:	00d72023          	sw	a3,0(a4)
            if(prev==0){
    8000437c:	f80784e3          	beqz	a5,80004304 <_Z15kmem_cache_freeP12kmem_cache_sPv+0xbc>
                prev->nextSlab=curr->nextSlab;
    80004380:	02073683          	ld	a3,32(a4)
    80004384:	02d7b023          	sd	a3,32(a5)
            curr->nextSlab=cachep->usedSlabsHead;
    80004388:	00853783          	ld	a5,8(a0)
    8000438c:	02f73023          	sd	a5,32(a4)
            cachep->usedSlabsHead=curr;
    80004390:	00e53423          	sd	a4,8(a0)
    }
}
    80004394:	00813403          	ld	s0,8(sp)
    80004398:	01010113          	addi	sp,sp,16
    8000439c:	00008067          	ret

00000000800043a0 <_Z7kmallocm>:

// Alloacate one small memory buffer
void *kmalloc(unsigned long size)
{
    800043a0:	ff010113          	addi	sp,sp,-16
    800043a4:	00113423          	sd	ra,8(sp)
    800043a8:	00813023          	sd	s0,0(sp)
    800043ac:	01010413          	addi	s0,sp,16
    return bba_allocate(size);
    800043b0:	ffffd097          	auipc	ra,0xffffd
    800043b4:	670080e7          	jalr	1648(ra) # 80001a20 <_Z12bba_allocatem>
}
    800043b8:	00813083          	ld	ra,8(sp)
    800043bc:	00013403          	ld	s0,0(sp)
    800043c0:	01010113          	addi	sp,sp,16
    800043c4:	00008067          	ret

00000000800043c8 <_Z5kfreePKv>:

// Deallocate one small memory buffer
void kfree(const void *objp)
{
    800043c8:	ff010113          	addi	sp,sp,-16
    800043cc:	00113423          	sd	ra,8(sp)
    800043d0:	00813023          	sd	s0,0(sp)
    800043d4:	01010413          	addi	s0,sp,16
    bba_free_block(objp);
    800043d8:	ffffe097          	auipc	ra,0xffffe
    800043dc:	910080e7          	jalr	-1776(ra) # 80001ce8 <_Z14bba_free_blockPKv>
}
    800043e0:	00813083          	ld	ra,8(sp)
    800043e4:	00013403          	ld	s0,0(sp)
    800043e8:	01010113          	addi	sp,sp,16
    800043ec:	00008067          	ret

00000000800043f0 <_Z17kmem_destroy_listP12kmem_cache_sP11kmem_slab_s>:

void kmem_destroy_list(kmem_cache_t* cachep,kmem_slab_t* head){
    if(head==0) return;
    800043f0:	08058e63          	beqz	a1,8000448c <_Z17kmem_destroy_listP12kmem_cache_sP11kmem_slab_s+0x9c>
void kmem_destroy_list(kmem_cache_t* cachep,kmem_slab_t* head){
    800043f4:	fd010113          	addi	sp,sp,-48
    800043f8:	02113423          	sd	ra,40(sp)
    800043fc:	02813023          	sd	s0,32(sp)
    80004400:	00913c23          	sd	s1,24(sp)
    80004404:	01213823          	sd	s2,16(sp)
    80004408:	01313423          	sd	s3,8(sp)
    8000440c:	03010413          	addi	s0,sp,48
    80004410:	00050993          	mv	s3,a0
    80004414:	00058493          	mv	s1,a1
    kmem_slab_t *curr = head->nextSlab;
    80004418:	0205b903          	ld	s2,32(a1)
    kmem_slab_t * prev = head;
    8000441c:	0440006f          	j	80004460 <_Z17kmem_destroy_listP12kmem_cache_sP11kmem_slab_s+0x70>
    80004420:	00090793          	mv	a5,s2
    80004424:	0340006f          	j	80004458 <_Z17kmem_destroy_listP12kmem_cache_sP11kmem_slab_s+0x68>
    while (prev!=0){
        if(cachep->dtor!=0) kmem_slab_destoy_objects(prev,cachep);
    80004428:	00098593          	mv	a1,s3
    8000442c:	00048513          	mv	a0,s1
    80004430:	00000097          	auipc	ra,0x0
    80004434:	830080e7          	jalr	-2000(ra) # 80003c60 <_Z24kmem_slab_destoy_objectsP11kmem_slab_sP12kmem_cache_s>
        bba_free_block(prev->memory);
    80004438:	0084b503          	ld	a0,8(s1)
    8000443c:	ffffe097          	auipc	ra,0xffffe
    80004440:	8ac080e7          	jalr	-1876(ra) # 80001ce8 <_Z14bba_free_blockPKv>
        bba_free_block(prev);
    80004444:	00048513          	mv	a0,s1
    80004448:	ffffe097          	auipc	ra,0xffffe
    8000444c:	8a0080e7          	jalr	-1888(ra) # 80001ce8 <_Z14bba_free_blockPKv>
        prev=curr;
        if(curr!=0) curr=curr->nextSlab;
    80004450:	fc0908e3          	beqz	s2,80004420 <_Z17kmem_destroy_listP12kmem_cache_sP11kmem_slab_s+0x30>
    80004454:	02093783          	ld	a5,32(s2)
    80004458:	00090493          	mv	s1,s2
    8000445c:	00078913          	mv	s2,a5
    while (prev!=0){
    80004460:	00048863          	beqz	s1,80004470 <_Z17kmem_destroy_listP12kmem_cache_sP11kmem_slab_s+0x80>
        if(cachep->dtor!=0) kmem_slab_destoy_objects(prev,cachep);
    80004464:	0309b783          	ld	a5,48(s3)
    80004468:	fc0790e3          	bnez	a5,80004428 <_Z17kmem_destroy_listP12kmem_cache_sP11kmem_slab_s+0x38>
    8000446c:	fcdff06f          	j	80004438 <_Z17kmem_destroy_listP12kmem_cache_sP11kmem_slab_s+0x48>
    }
}
    80004470:	02813083          	ld	ra,40(sp)
    80004474:	02013403          	ld	s0,32(sp)
    80004478:	01813483          	ld	s1,24(sp)
    8000447c:	01013903          	ld	s2,16(sp)
    80004480:	00813983          	ld	s3,8(sp)
    80004484:	03010113          	addi	sp,sp,48
    80004488:	00008067          	ret
    8000448c:	00008067          	ret

0000000080004490 <_Z18kmem_cache_destroyP12kmem_cache_s>:

// Deallocate cache
void kmem_cache_destroy(kmem_cache_t *cachep)
{
    80004490:	fe010113          	addi	sp,sp,-32
    80004494:	00113c23          	sd	ra,24(sp)
    80004498:	00813823          	sd	s0,16(sp)
    8000449c:	00913423          	sd	s1,8(sp)
    800044a0:	02010413          	addi	s0,sp,32
    800044a4:	00050493          	mv	s1,a0
    kmem_destroy_list(cachep,cachep->usedSlabsHead);
    800044a8:	00853583          	ld	a1,8(a0)
    800044ac:	00000097          	auipc	ra,0x0
    800044b0:	f44080e7          	jalr	-188(ra) # 800043f0 <_Z17kmem_destroy_listP12kmem_cache_sP11kmem_slab_s>
    kmem_destroy_list(cachep,cachep->emptySlabsHead);
    800044b4:	0004b583          	ld	a1,0(s1)
    800044b8:	00048513          	mv	a0,s1
    800044bc:	00000097          	auipc	ra,0x0
    800044c0:	f34080e7          	jalr	-204(ra) # 800043f0 <_Z17kmem_destroy_listP12kmem_cache_sP11kmem_slab_s>
    kmem_destroy_list(cachep,cachep->fullSlabsHead);
    800044c4:	0104b583          	ld	a1,16(s1)
    800044c8:	00048513          	mv	a0,s1
    800044cc:	00000097          	auipc	ra,0x0
    800044d0:	f24080e7          	jalr	-220(ra) # 800043f0 <_Z17kmem_destroy_listP12kmem_cache_sP11kmem_slab_s>
    bba_free_block(cachep);
    800044d4:	00048513          	mv	a0,s1
    800044d8:	ffffe097          	auipc	ra,0xffffe
    800044dc:	810080e7          	jalr	-2032(ra) # 80001ce8 <_Z14bba_free_blockPKv>
}
    800044e0:	01813083          	ld	ra,24(sp)
    800044e4:	01013403          	ld	s0,16(sp)
    800044e8:	00813483          	ld	s1,8(sp)
    800044ec:	02010113          	addi	sp,sp,32
    800044f0:	00008067          	ret

00000000800044f4 <_Z15kmem_cache_infoP12kmem_cache_s>:
{
    printf("\n Slab at addr %lx, %d used slots, %d initialized slots",  slab->memory, slab->usedSlotsCount, slab->initializedSlotsCount);
}
// Print cache info
void kmem_cache_info(kmem_cache_t *cachep)
{
    800044f4:	fc010113          	addi	sp,sp,-64
    800044f8:	02113c23          	sd	ra,56(sp)
    800044fc:	02813823          	sd	s0,48(sp)
    80004500:	02913423          	sd	s1,40(sp)
    80004504:	03213023          	sd	s2,32(sp)
    80004508:	01313c23          	sd	s3,24(sp)
    8000450c:	01413823          	sd	s4,16(sp)
    80004510:	01513423          	sd	s5,8(sp)
    80004514:	04010413          	addi	s0,sp,64
    80004518:	00050a93          	mv	s5,a0
    int initObjCount=0, usedObjCount=0, slabsCount=0;
    printf("\n Cache '%s' has %d slots of size %d in each slab",cachep->name, cachep->slotsInSlab, cachep->slotSize);
    8000451c:	02053683          	ld	a3,32(a0)
    80004520:	05052603          	lw	a2,80(a0)
    80004524:	03850593          	addi	a1,a0,56
    80004528:	00006517          	auipc	a0,0x6
    8000452c:	dc850513          	addi	a0,a0,-568 # 8000a2f0 <CONSOLE_STATUS+0x2e0>
    80004530:	ffffe097          	auipc	ra,0xffffe
    80004534:	d10080e7          	jalr	-752(ra) # 80002240 <_Z6printfPKcz>
    printf("\n Empty slabs:");
    80004538:	00006517          	auipc	a0,0x6
    8000453c:	df050513          	addi	a0,a0,-528 # 8000a328 <CONSOLE_STATUS+0x318>
    80004540:	ffffe097          	auipc	ra,0xffffe
    80004544:	d00080e7          	jalr	-768(ra) # 80002240 <_Z6printfPKcz>
    kmem_slab_t * curr = cachep->emptySlabsHead;
    80004548:	000ab483          	ld	s1,0(s5)
    int initObjCount=0, usedObjCount=0, slabsCount=0;
    8000454c:	00000a13          	li	s4,0
    80004550:	00000913          	li	s2,0
    80004554:	00000993          	li	s3,0
    while (curr!=0){
    80004558:	02048e63          	beqz	s1,80004594 <_Z15kmem_cache_infoP12kmem_cache_s+0xa0>
    printf("\n Slab at addr %lx, %d used slots, %d initialized slots",  slab->memory, slab->usedSlotsCount, slab->initializedSlotsCount);
    8000455c:	0044a683          	lw	a3,4(s1)
    80004560:	0004a603          	lw	a2,0(s1)
    80004564:	0084b583          	ld	a1,8(s1)
    80004568:	00006517          	auipc	a0,0x6
    8000456c:	dd050513          	addi	a0,a0,-560 # 8000a338 <CONSOLE_STATUS+0x328>
    80004570:	ffffe097          	auipc	ra,0xffffe
    80004574:	cd0080e7          	jalr	-816(ra) # 80002240 <_Z6printfPKcz>
        kmem_slab_info(curr);
        slabsCount++;
    80004578:	001a0a1b          	addiw	s4,s4,1
        initObjCount+=curr->initializedSlotsCount;
    8000457c:	0044a783          	lw	a5,4(s1)
    80004580:	013789bb          	addw	s3,a5,s3
        usedObjCount+=curr->usedSlotsCount;
    80004584:	0004a783          	lw	a5,0(s1)
    80004588:	0127893b          	addw	s2,a5,s2
        curr=curr->nextSlab;
    8000458c:	0204b483          	ld	s1,32(s1)
    while (curr!=0){
    80004590:	fc9ff06f          	j	80004558 <_Z15kmem_cache_infoP12kmem_cache_s+0x64>
    }
    printf("\n Full slabs:");
    80004594:	00006517          	auipc	a0,0x6
    80004598:	ddc50513          	addi	a0,a0,-548 # 8000a370 <CONSOLE_STATUS+0x360>
    8000459c:	ffffe097          	auipc	ra,0xffffe
    800045a0:	ca4080e7          	jalr	-860(ra) # 80002240 <_Z6printfPKcz>
    curr = cachep->fullSlabsHead;
    800045a4:	010ab483          	ld	s1,16(s5)
    while (curr!=0){
    800045a8:	02048e63          	beqz	s1,800045e4 <_Z15kmem_cache_infoP12kmem_cache_s+0xf0>
    printf("\n Slab at addr %lx, %d used slots, %d initialized slots",  slab->memory, slab->usedSlotsCount, slab->initializedSlotsCount);
    800045ac:	0044a683          	lw	a3,4(s1)
    800045b0:	0004a603          	lw	a2,0(s1)
    800045b4:	0084b583          	ld	a1,8(s1)
    800045b8:	00006517          	auipc	a0,0x6
    800045bc:	d8050513          	addi	a0,a0,-640 # 8000a338 <CONSOLE_STATUS+0x328>
    800045c0:	ffffe097          	auipc	ra,0xffffe
    800045c4:	c80080e7          	jalr	-896(ra) # 80002240 <_Z6printfPKcz>
        kmem_slab_info(curr);
        slabsCount++;
    800045c8:	001a0a1b          	addiw	s4,s4,1
        initObjCount+=curr->initializedSlotsCount;
    800045cc:	0044a783          	lw	a5,4(s1)
    800045d0:	013789bb          	addw	s3,a5,s3
        usedObjCount+=curr->usedSlotsCount;
    800045d4:	0004a783          	lw	a5,0(s1)
    800045d8:	0127893b          	addw	s2,a5,s2
        curr=curr->nextSlab;
    800045dc:	0204b483          	ld	s1,32(s1)
    while (curr!=0){
    800045e0:	fc9ff06f          	j	800045a8 <_Z15kmem_cache_infoP12kmem_cache_s+0xb4>
    }
    printf("\n Partially full slabs:");
    800045e4:	00006517          	auipc	a0,0x6
    800045e8:	d9c50513          	addi	a0,a0,-612 # 8000a380 <CONSOLE_STATUS+0x370>
    800045ec:	ffffe097          	auipc	ra,0xffffe
    800045f0:	c54080e7          	jalr	-940(ra) # 80002240 <_Z6printfPKcz>
    curr = cachep->usedSlabsHead;
    800045f4:	008ab483          	ld	s1,8(s5)
    while (curr!=0){
    800045f8:	02048e63          	beqz	s1,80004634 <_Z15kmem_cache_infoP12kmem_cache_s+0x140>
    printf("\n Slab at addr %lx, %d used slots, %d initialized slots",  slab->memory, slab->usedSlotsCount, slab->initializedSlotsCount);
    800045fc:	0044a683          	lw	a3,4(s1)
    80004600:	0004a603          	lw	a2,0(s1)
    80004604:	0084b583          	ld	a1,8(s1)
    80004608:	00006517          	auipc	a0,0x6
    8000460c:	d3050513          	addi	a0,a0,-720 # 8000a338 <CONSOLE_STATUS+0x328>
    80004610:	ffffe097          	auipc	ra,0xffffe
    80004614:	c30080e7          	jalr	-976(ra) # 80002240 <_Z6printfPKcz>
        kmem_slab_info(curr);
        slabsCount++;
    80004618:	001a0a1b          	addiw	s4,s4,1
        initObjCount+=curr->initializedSlotsCount;
    8000461c:	0044a783          	lw	a5,4(s1)
    80004620:	013789bb          	addw	s3,a5,s3
        usedObjCount+=curr->usedSlotsCount;
    80004624:	0004a783          	lw	a5,0(s1)
    80004628:	0127893b          	addw	s2,a5,s2
        curr=curr->nextSlab;
    8000462c:	0204b483          	ld	s1,32(s1)
    while (curr!=0){
    80004630:	fc9ff06f          	j	800045f8 <_Z15kmem_cache_infoP12kmem_cache_s+0x104>
    }
    printf("\n Total slabs: %d, total used slots: %d, total initialized slots: %d", slabsCount, usedObjCount,initObjCount);
    80004634:	00098693          	mv	a3,s3
    80004638:	00090613          	mv	a2,s2
    8000463c:	000a0593          	mv	a1,s4
    80004640:	00006517          	auipc	a0,0x6
    80004644:	d5850513          	addi	a0,a0,-680 # 8000a398 <CONSOLE_STATUS+0x388>
    80004648:	ffffe097          	auipc	ra,0xffffe
    8000464c:	bf8080e7          	jalr	-1032(ra) # 80002240 <_Z6printfPKcz>
    printf("\n-------------------------", usedObjCount,initObjCount);
    80004650:	00098613          	mv	a2,s3
    80004654:	00090593          	mv	a1,s2
    80004658:	00006517          	auipc	a0,0x6
    8000465c:	d8850513          	addi	a0,a0,-632 # 8000a3e0 <CONSOLE_STATUS+0x3d0>
    80004660:	ffffe097          	auipc	ra,0xffffe
    80004664:	be0080e7          	jalr	-1056(ra) # 80002240 <_Z6printfPKcz>
}
    80004668:	03813083          	ld	ra,56(sp)
    8000466c:	03013403          	ld	s0,48(sp)
    80004670:	02813483          	ld	s1,40(sp)
    80004674:	02013903          	ld	s2,32(sp)
    80004678:	01813983          	ld	s3,24(sp)
    8000467c:	01013a03          	ld	s4,16(sp)
    80004680:	00813a83          	ld	s5,8(sp)
    80004684:	04010113          	addi	sp,sp,64
    80004688:	00008067          	ret

000000008000468c <_ZL16producerKeyboardPv>:
    sem_t wait;
};

static volatile int threadEnd = 0;

static void producerKeyboard(void *arg) {
    8000468c:	fe010113          	addi	sp,sp,-32
    80004690:	00113c23          	sd	ra,24(sp)
    80004694:	00813823          	sd	s0,16(sp)
    80004698:	00913423          	sd	s1,8(sp)
    8000469c:	01213023          	sd	s2,0(sp)
    800046a0:	02010413          	addi	s0,sp,32
    800046a4:	00050493          	mv	s1,a0
    struct thread_data *data = (struct thread_data *) arg;

    int key;
    int i = 0;
    800046a8:	00000913          	li	s2,0
    800046ac:	00c0006f          	j	800046b8 <_ZL16producerKeyboardPv+0x2c>
    while ((key = getc()) != 13) {
        data->buffer->put(key);
        i++;

        if (i % (10 * data->id) == 0) {
            thread_dispatch();
    800046b0:	ffffd097          	auipc	ra,0xffffd
    800046b4:	cd8080e7          	jalr	-808(ra) # 80001388 <_Z15thread_dispatchv>
    while ((key = getc()) != 13) {
    800046b8:	ffffd097          	auipc	ra,0xffffd
    800046bc:	ebc080e7          	jalr	-324(ra) # 80001574 <_Z4getcv>
    800046c0:	0005059b          	sext.w	a1,a0
    800046c4:	00d00793          	li	a5,13
    800046c8:	02f58a63          	beq	a1,a5,800046fc <_ZL16producerKeyboardPv+0x70>
        data->buffer->put(key);
    800046cc:	0084b503          	ld	a0,8(s1)
    800046d0:	00003097          	auipc	ra,0x3
    800046d4:	f50080e7          	jalr	-176(ra) # 80007620 <_ZN6Buffer3putEi>
        i++;
    800046d8:	0019071b          	addiw	a4,s2,1
    800046dc:	0007091b          	sext.w	s2,a4
        if (i % (10 * data->id) == 0) {
    800046e0:	0004a683          	lw	a3,0(s1)
    800046e4:	0026979b          	slliw	a5,a3,0x2
    800046e8:	00d787bb          	addw	a5,a5,a3
    800046ec:	0017979b          	slliw	a5,a5,0x1
    800046f0:	02f767bb          	remw	a5,a4,a5
    800046f4:	fc0792e3          	bnez	a5,800046b8 <_ZL16producerKeyboardPv+0x2c>
    800046f8:	fb9ff06f          	j	800046b0 <_ZL16producerKeyboardPv+0x24>
        }
    }

    threadEnd = 1;
    800046fc:	00100793          	li	a5,1
    80004700:	0000a717          	auipc	a4,0xa
    80004704:	aef72423          	sw	a5,-1304(a4) # 8000e1e8 <_ZL9threadEnd>
    data->buffer->put('!');
    80004708:	02100593          	li	a1,33
    8000470c:	0084b503          	ld	a0,8(s1)
    80004710:	00003097          	auipc	ra,0x3
    80004714:	f10080e7          	jalr	-240(ra) # 80007620 <_ZN6Buffer3putEi>

    sem_signal(data->wait);
    80004718:	0104b503          	ld	a0,16(s1)
    8000471c:	ffffd097          	auipc	ra,0xffffd
    80004720:	de4080e7          	jalr	-540(ra) # 80001500 <_Z10sem_signalP5sem_s>
}
    80004724:	01813083          	ld	ra,24(sp)
    80004728:	01013403          	ld	s0,16(sp)
    8000472c:	00813483          	ld	s1,8(sp)
    80004730:	00013903          	ld	s2,0(sp)
    80004734:	02010113          	addi	sp,sp,32
    80004738:	00008067          	ret

000000008000473c <_ZL8producerPv>:

static void producer(void *arg) {
    8000473c:	fe010113          	addi	sp,sp,-32
    80004740:	00113c23          	sd	ra,24(sp)
    80004744:	00813823          	sd	s0,16(sp)
    80004748:	00913423          	sd	s1,8(sp)
    8000474c:	01213023          	sd	s2,0(sp)
    80004750:	02010413          	addi	s0,sp,32
    80004754:	00050493          	mv	s1,a0
    struct thread_data *data = (struct thread_data *) arg;

    int i = 0;
    80004758:	00000913          	li	s2,0
    8000475c:	00c0006f          	j	80004768 <_ZL8producerPv+0x2c>
    while (!threadEnd) {
        data->buffer->put(data->id + '0');
        i++;

        if (i % (10 * data->id) == 0) {
            thread_dispatch();
    80004760:	ffffd097          	auipc	ra,0xffffd
    80004764:	c28080e7          	jalr	-984(ra) # 80001388 <_Z15thread_dispatchv>
    while (!threadEnd) {
    80004768:	0000a797          	auipc	a5,0xa
    8000476c:	a807a783          	lw	a5,-1408(a5) # 8000e1e8 <_ZL9threadEnd>
    80004770:	02079e63          	bnez	a5,800047ac <_ZL8producerPv+0x70>
        data->buffer->put(data->id + '0');
    80004774:	0004a583          	lw	a1,0(s1)
    80004778:	0305859b          	addiw	a1,a1,48
    8000477c:	0084b503          	ld	a0,8(s1)
    80004780:	00003097          	auipc	ra,0x3
    80004784:	ea0080e7          	jalr	-352(ra) # 80007620 <_ZN6Buffer3putEi>
        i++;
    80004788:	0019071b          	addiw	a4,s2,1
    8000478c:	0007091b          	sext.w	s2,a4
        if (i % (10 * data->id) == 0) {
    80004790:	0004a683          	lw	a3,0(s1)
    80004794:	0026979b          	slliw	a5,a3,0x2
    80004798:	00d787bb          	addw	a5,a5,a3
    8000479c:	0017979b          	slliw	a5,a5,0x1
    800047a0:	02f767bb          	remw	a5,a4,a5
    800047a4:	fc0792e3          	bnez	a5,80004768 <_ZL8producerPv+0x2c>
    800047a8:	fb9ff06f          	j	80004760 <_ZL8producerPv+0x24>
        }
    }

    sem_signal(data->wait);
    800047ac:	0104b503          	ld	a0,16(s1)
    800047b0:	ffffd097          	auipc	ra,0xffffd
    800047b4:	d50080e7          	jalr	-688(ra) # 80001500 <_Z10sem_signalP5sem_s>
}
    800047b8:	01813083          	ld	ra,24(sp)
    800047bc:	01013403          	ld	s0,16(sp)
    800047c0:	00813483          	ld	s1,8(sp)
    800047c4:	00013903          	ld	s2,0(sp)
    800047c8:	02010113          	addi	sp,sp,32
    800047cc:	00008067          	ret

00000000800047d0 <_ZL8consumerPv>:

static void consumer(void *arg) {
    800047d0:	fd010113          	addi	sp,sp,-48
    800047d4:	02113423          	sd	ra,40(sp)
    800047d8:	02813023          	sd	s0,32(sp)
    800047dc:	00913c23          	sd	s1,24(sp)
    800047e0:	01213823          	sd	s2,16(sp)
    800047e4:	01313423          	sd	s3,8(sp)
    800047e8:	03010413          	addi	s0,sp,48
    800047ec:	00050913          	mv	s2,a0
    struct thread_data *data = (struct thread_data *) arg;

    int i = 0;
    800047f0:	00000993          	li	s3,0
    800047f4:	01c0006f          	j	80004810 <_ZL8consumerPv+0x40>
        i++;

        putc(key);

        if (i % (5 * data->id) == 0) {
            thread_dispatch();
    800047f8:	ffffd097          	auipc	ra,0xffffd
    800047fc:	b90080e7          	jalr	-1136(ra) # 80001388 <_Z15thread_dispatchv>
    80004800:	0500006f          	j	80004850 <_ZL8consumerPv+0x80>
        }

        if (i % 80 == 0) {
            putc('\n');
    80004804:	00a00513          	li	a0,10
    80004808:	ffffd097          	auipc	ra,0xffffd
    8000480c:	da8080e7          	jalr	-600(ra) # 800015b0 <_Z4putcc>
    while (!threadEnd) {
    80004810:	0000a797          	auipc	a5,0xa
    80004814:	9d87a783          	lw	a5,-1576(a5) # 8000e1e8 <_ZL9threadEnd>
    80004818:	06079063          	bnez	a5,80004878 <_ZL8consumerPv+0xa8>
        int key = data->buffer->get();
    8000481c:	00893503          	ld	a0,8(s2)
    80004820:	00003097          	auipc	ra,0x3
    80004824:	e90080e7          	jalr	-368(ra) # 800076b0 <_ZN6Buffer3getEv>
        i++;
    80004828:	0019849b          	addiw	s1,s3,1
    8000482c:	0004899b          	sext.w	s3,s1
        putc(key);
    80004830:	0ff57513          	andi	a0,a0,255
    80004834:	ffffd097          	auipc	ra,0xffffd
    80004838:	d7c080e7          	jalr	-644(ra) # 800015b0 <_Z4putcc>
        if (i % (5 * data->id) == 0) {
    8000483c:	00092703          	lw	a4,0(s2)
    80004840:	0027179b          	slliw	a5,a4,0x2
    80004844:	00e787bb          	addw	a5,a5,a4
    80004848:	02f4e7bb          	remw	a5,s1,a5
    8000484c:	fa0786e3          	beqz	a5,800047f8 <_ZL8consumerPv+0x28>
        if (i % 80 == 0) {
    80004850:	05000793          	li	a5,80
    80004854:	02f4e4bb          	remw	s1,s1,a5
    80004858:	fa049ce3          	bnez	s1,80004810 <_ZL8consumerPv+0x40>
    8000485c:	fa9ff06f          	j	80004804 <_ZL8consumerPv+0x34>
        }
    }

    while (data->buffer->getCnt() > 0) {
        int key = data->buffer->get();
    80004860:	00893503          	ld	a0,8(s2)
    80004864:	00003097          	auipc	ra,0x3
    80004868:	e4c080e7          	jalr	-436(ra) # 800076b0 <_ZN6Buffer3getEv>
        putc(key);
    8000486c:	0ff57513          	andi	a0,a0,255
    80004870:	ffffd097          	auipc	ra,0xffffd
    80004874:	d40080e7          	jalr	-704(ra) # 800015b0 <_Z4putcc>
    while (data->buffer->getCnt() > 0) {
    80004878:	00893503          	ld	a0,8(s2)
    8000487c:	00003097          	auipc	ra,0x3
    80004880:	ec0080e7          	jalr	-320(ra) # 8000773c <_ZN6Buffer6getCntEv>
    80004884:	fca04ee3          	bgtz	a0,80004860 <_ZL8consumerPv+0x90>
    }

    sem_signal(data->wait);
    80004888:	01093503          	ld	a0,16(s2)
    8000488c:	ffffd097          	auipc	ra,0xffffd
    80004890:	c74080e7          	jalr	-908(ra) # 80001500 <_Z10sem_signalP5sem_s>
}
    80004894:	02813083          	ld	ra,40(sp)
    80004898:	02013403          	ld	s0,32(sp)
    8000489c:	01813483          	ld	s1,24(sp)
    800048a0:	01013903          	ld	s2,16(sp)
    800048a4:	00813983          	ld	s3,8(sp)
    800048a8:	03010113          	addi	sp,sp,48
    800048ac:	00008067          	ret

00000000800048b0 <_Z22producerConsumer_C_APIv>:

void producerConsumer_C_API() {
    800048b0:	f9010113          	addi	sp,sp,-112
    800048b4:	06113423          	sd	ra,104(sp)
    800048b8:	06813023          	sd	s0,96(sp)
    800048bc:	04913c23          	sd	s1,88(sp)
    800048c0:	05213823          	sd	s2,80(sp)
    800048c4:	05313423          	sd	s3,72(sp)
    800048c8:	05413023          	sd	s4,64(sp)
    800048cc:	03513c23          	sd	s5,56(sp)
    800048d0:	03613823          	sd	s6,48(sp)
    800048d4:	07010413          	addi	s0,sp,112
        sem_wait(waitForAll);
    }

    sem_close(waitForAll);

    delete buffer;
    800048d8:	00010b13          	mv	s6,sp
    printString("Unesite broj proizvodjaca?\n");
    800048dc:	00006517          	auipc	a0,0x6
    800048e0:	b2450513          	addi	a0,a0,-1244 # 8000a400 <CONSOLE_STATUS+0x3f0>
    800048e4:	ffffd097          	auipc	ra,0xffffd
    800048e8:	5c8080e7          	jalr	1480(ra) # 80001eac <_Z11printStringPKc>
    getString(input, 30);
    800048ec:	01e00593          	li	a1,30
    800048f0:	fa040493          	addi	s1,s0,-96
    800048f4:	00048513          	mv	a0,s1
    800048f8:	ffffd097          	auipc	ra,0xffffd
    800048fc:	63c080e7          	jalr	1596(ra) # 80001f34 <_Z9getStringPci>
    threadNum = stringToInt(input);
    80004900:	00048513          	mv	a0,s1
    80004904:	ffffd097          	auipc	ra,0xffffd
    80004908:	708080e7          	jalr	1800(ra) # 8000200c <_Z11stringToIntPKc>
    8000490c:	00050913          	mv	s2,a0
    printString("Unesite velicinu bafera?\n");
    80004910:	00006517          	auipc	a0,0x6
    80004914:	b1050513          	addi	a0,a0,-1264 # 8000a420 <CONSOLE_STATUS+0x410>
    80004918:	ffffd097          	auipc	ra,0xffffd
    8000491c:	594080e7          	jalr	1428(ra) # 80001eac <_Z11printStringPKc>
    getString(input, 30);
    80004920:	01e00593          	li	a1,30
    80004924:	00048513          	mv	a0,s1
    80004928:	ffffd097          	auipc	ra,0xffffd
    8000492c:	60c080e7          	jalr	1548(ra) # 80001f34 <_Z9getStringPci>
    n = stringToInt(input);
    80004930:	00048513          	mv	a0,s1
    80004934:	ffffd097          	auipc	ra,0xffffd
    80004938:	6d8080e7          	jalr	1752(ra) # 8000200c <_Z11stringToIntPKc>
    8000493c:	00050493          	mv	s1,a0
    printString("Broj proizvodjaca "); printInt(threadNum);
    80004940:	00006517          	auipc	a0,0x6
    80004944:	b0050513          	addi	a0,a0,-1280 # 8000a440 <CONSOLE_STATUS+0x430>
    80004948:	ffffd097          	auipc	ra,0xffffd
    8000494c:	564080e7          	jalr	1380(ra) # 80001eac <_Z11printStringPKc>
    80004950:	00000613          	li	a2,0
    80004954:	00a00593          	li	a1,10
    80004958:	00090513          	mv	a0,s2
    8000495c:	ffffd097          	auipc	ra,0xffffd
    80004960:	700080e7          	jalr	1792(ra) # 8000205c <_Z8printIntiii>
    printString(" i velicina bafera "); printInt(n);
    80004964:	00006517          	auipc	a0,0x6
    80004968:	af450513          	addi	a0,a0,-1292 # 8000a458 <CONSOLE_STATUS+0x448>
    8000496c:	ffffd097          	auipc	ra,0xffffd
    80004970:	540080e7          	jalr	1344(ra) # 80001eac <_Z11printStringPKc>
    80004974:	00000613          	li	a2,0
    80004978:	00a00593          	li	a1,10
    8000497c:	00048513          	mv	a0,s1
    80004980:	ffffd097          	auipc	ra,0xffffd
    80004984:	6dc080e7          	jalr	1756(ra) # 8000205c <_Z8printIntiii>
    printString(".\n");
    80004988:	00006517          	auipc	a0,0x6
    8000498c:	ae850513          	addi	a0,a0,-1304 # 8000a470 <CONSOLE_STATUS+0x460>
    80004990:	ffffd097          	auipc	ra,0xffffd
    80004994:	51c080e7          	jalr	1308(ra) # 80001eac <_Z11printStringPKc>
    if(threadNum > n) {
    80004998:	0324c463          	blt	s1,s2,800049c0 <_Z22producerConsumer_C_APIv+0x110>
    } else if (threadNum < 1) {
    8000499c:	03205c63          	blez	s2,800049d4 <_Z22producerConsumer_C_APIv+0x124>
    Buffer *buffer = new Buffer(n);
    800049a0:	03800513          	li	a0,56
    800049a4:	ffffe097          	auipc	ra,0xffffe
    800049a8:	23c080e7          	jalr	572(ra) # 80002be0 <_Znwm>
    800049ac:	00050a13          	mv	s4,a0
    800049b0:	00048593          	mv	a1,s1
    800049b4:	00003097          	auipc	ra,0x3
    800049b8:	bd0080e7          	jalr	-1072(ra) # 80007584 <_ZN6BufferC1Ei>
    800049bc:	0300006f          	j	800049ec <_Z22producerConsumer_C_APIv+0x13c>
        printString("Broj proizvodjaca ne sme biti manji od velicine bafera!\n");
    800049c0:	00006517          	auipc	a0,0x6
    800049c4:	ab850513          	addi	a0,a0,-1352 # 8000a478 <CONSOLE_STATUS+0x468>
    800049c8:	ffffd097          	auipc	ra,0xffffd
    800049cc:	4e4080e7          	jalr	1252(ra) # 80001eac <_Z11printStringPKc>
        return;
    800049d0:	0140006f          	j	800049e4 <_Z22producerConsumer_C_APIv+0x134>
        printString("Broj proizvodjaca mora biti veci od nula!\n");
    800049d4:	00006517          	auipc	a0,0x6
    800049d8:	ae450513          	addi	a0,a0,-1308 # 8000a4b8 <CONSOLE_STATUS+0x4a8>
    800049dc:	ffffd097          	auipc	ra,0xffffd
    800049e0:	4d0080e7          	jalr	1232(ra) # 80001eac <_Z11printStringPKc>
        return;
    800049e4:	000b0113          	mv	sp,s6
    800049e8:	1500006f          	j	80004b38 <_Z22producerConsumer_C_APIv+0x288>
    sem_open(&waitForAll, 0);
    800049ec:	00000593          	li	a1,0
    800049f0:	0000a517          	auipc	a0,0xa
    800049f4:	80050513          	addi	a0,a0,-2048 # 8000e1f0 <_ZL10waitForAll>
    800049f8:	ffffd097          	auipc	ra,0xffffd
    800049fc:	a44080e7          	jalr	-1468(ra) # 8000143c <_Z8sem_openPP5sem_sj>
    thread_t threads[threadNum];
    80004a00:	00391793          	slli	a5,s2,0x3
    80004a04:	00f78793          	addi	a5,a5,15
    80004a08:	ff07f793          	andi	a5,a5,-16
    80004a0c:	40f10133          	sub	sp,sp,a5
    80004a10:	00010a93          	mv	s5,sp
    struct thread_data data[threadNum + 1];
    80004a14:	0019071b          	addiw	a4,s2,1
    80004a18:	00171793          	slli	a5,a4,0x1
    80004a1c:	00e787b3          	add	a5,a5,a4
    80004a20:	00379793          	slli	a5,a5,0x3
    80004a24:	00f78793          	addi	a5,a5,15
    80004a28:	ff07f793          	andi	a5,a5,-16
    80004a2c:	40f10133          	sub	sp,sp,a5
    80004a30:	00010993          	mv	s3,sp
    data[threadNum].id = threadNum;
    80004a34:	00191613          	slli	a2,s2,0x1
    80004a38:	012607b3          	add	a5,a2,s2
    80004a3c:	00379793          	slli	a5,a5,0x3
    80004a40:	00f987b3          	add	a5,s3,a5
    80004a44:	0127a023          	sw	s2,0(a5)
    data[threadNum].buffer = buffer;
    80004a48:	0147b423          	sd	s4,8(a5)
    data[threadNum].wait = waitForAll;
    80004a4c:	00009717          	auipc	a4,0x9
    80004a50:	7a473703          	ld	a4,1956(a4) # 8000e1f0 <_ZL10waitForAll>
    80004a54:	00e7b823          	sd	a4,16(a5)
    thread_create(&consumerThread, consumer, data + threadNum);
    80004a58:	00078613          	mv	a2,a5
    80004a5c:	00000597          	auipc	a1,0x0
    80004a60:	d7458593          	addi	a1,a1,-652 # 800047d0 <_ZL8consumerPv>
    80004a64:	f9840513          	addi	a0,s0,-104
    80004a68:	ffffd097          	auipc	ra,0xffffd
    80004a6c:	898080e7          	jalr	-1896(ra) # 80001300 <_Z13thread_createPP8thread_sPFvPvES2_>
    for (int i = 0; i < threadNum; i++) {
    80004a70:	00000493          	li	s1,0
    80004a74:	0280006f          	j	80004a9c <_Z22producerConsumer_C_APIv+0x1ec>
        thread_create(threads + i,
    80004a78:	00000597          	auipc	a1,0x0
    80004a7c:	c1458593          	addi	a1,a1,-1004 # 8000468c <_ZL16producerKeyboardPv>
                      data + i);
    80004a80:	00179613          	slli	a2,a5,0x1
    80004a84:	00f60633          	add	a2,a2,a5
    80004a88:	00361613          	slli	a2,a2,0x3
        thread_create(threads + i,
    80004a8c:	00c98633          	add	a2,s3,a2
    80004a90:	ffffd097          	auipc	ra,0xffffd
    80004a94:	870080e7          	jalr	-1936(ra) # 80001300 <_Z13thread_createPP8thread_sPFvPvES2_>
    for (int i = 0; i < threadNum; i++) {
    80004a98:	0014849b          	addiw	s1,s1,1
    80004a9c:	0524d263          	bge	s1,s2,80004ae0 <_Z22producerConsumer_C_APIv+0x230>
        data[i].id = i;
    80004aa0:	00149793          	slli	a5,s1,0x1
    80004aa4:	009787b3          	add	a5,a5,s1
    80004aa8:	00379793          	slli	a5,a5,0x3
    80004aac:	00f987b3          	add	a5,s3,a5
    80004ab0:	0097a023          	sw	s1,0(a5)
        data[i].buffer = buffer;
    80004ab4:	0147b423          	sd	s4,8(a5)
        data[i].wait = waitForAll;
    80004ab8:	00009717          	auipc	a4,0x9
    80004abc:	73873703          	ld	a4,1848(a4) # 8000e1f0 <_ZL10waitForAll>
    80004ac0:	00e7b823          	sd	a4,16(a5)
        thread_create(threads + i,
    80004ac4:	00048793          	mv	a5,s1
    80004ac8:	00349513          	slli	a0,s1,0x3
    80004acc:	00aa8533          	add	a0,s5,a0
    80004ad0:	fa9054e3          	blez	s1,80004a78 <_Z22producerConsumer_C_APIv+0x1c8>
    80004ad4:	00000597          	auipc	a1,0x0
    80004ad8:	c6858593          	addi	a1,a1,-920 # 8000473c <_ZL8producerPv>
    80004adc:	fa5ff06f          	j	80004a80 <_Z22producerConsumer_C_APIv+0x1d0>
    thread_dispatch();
    80004ae0:	ffffd097          	auipc	ra,0xffffd
    80004ae4:	8a8080e7          	jalr	-1880(ra) # 80001388 <_Z15thread_dispatchv>
    for (int i = 0; i <= threadNum; i++) {
    80004ae8:	00000493          	li	s1,0
    80004aec:	00994e63          	blt	s2,s1,80004b08 <_Z22producerConsumer_C_APIv+0x258>
        sem_wait(waitForAll);
    80004af0:	00009517          	auipc	a0,0x9
    80004af4:	70053503          	ld	a0,1792(a0) # 8000e1f0 <_ZL10waitForAll>
    80004af8:	ffffd097          	auipc	ra,0xffffd
    80004afc:	9c8080e7          	jalr	-1592(ra) # 800014c0 <_Z8sem_waitP5sem_s>
    for (int i = 0; i <= threadNum; i++) {
    80004b00:	0014849b          	addiw	s1,s1,1
    80004b04:	fe9ff06f          	j	80004aec <_Z22producerConsumer_C_APIv+0x23c>
    sem_close(waitForAll);
    80004b08:	00009517          	auipc	a0,0x9
    80004b0c:	6e853503          	ld	a0,1768(a0) # 8000e1f0 <_ZL10waitForAll>
    80004b10:	ffffd097          	auipc	ra,0xffffd
    80004b14:	970080e7          	jalr	-1680(ra) # 80001480 <_Z9sem_closeP5sem_s>
    delete buffer;
    80004b18:	000a0e63          	beqz	s4,80004b34 <_Z22producerConsumer_C_APIv+0x284>
    80004b1c:	000a0513          	mv	a0,s4
    80004b20:	00003097          	auipc	ra,0x3
    80004b24:	ca4080e7          	jalr	-860(ra) # 800077c4 <_ZN6BufferD1Ev>
    80004b28:	000a0513          	mv	a0,s4
    80004b2c:	ffffe097          	auipc	ra,0xffffe
    80004b30:	0dc080e7          	jalr	220(ra) # 80002c08 <_ZdlPv>
    80004b34:	000b0113          	mv	sp,s6

}
    80004b38:	f9040113          	addi	sp,s0,-112
    80004b3c:	06813083          	ld	ra,104(sp)
    80004b40:	06013403          	ld	s0,96(sp)
    80004b44:	05813483          	ld	s1,88(sp)
    80004b48:	05013903          	ld	s2,80(sp)
    80004b4c:	04813983          	ld	s3,72(sp)
    80004b50:	04013a03          	ld	s4,64(sp)
    80004b54:	03813a83          	ld	s5,56(sp)
    80004b58:	03013b03          	ld	s6,48(sp)
    80004b5c:	07010113          	addi	sp,sp,112
    80004b60:	00008067          	ret
    80004b64:	00050493          	mv	s1,a0
    Buffer *buffer = new Buffer(n);
    80004b68:	000a0513          	mv	a0,s4
    80004b6c:	ffffe097          	auipc	ra,0xffffe
    80004b70:	09c080e7          	jalr	156(ra) # 80002c08 <_ZdlPv>
    80004b74:	00048513          	mv	a0,s1
    80004b78:	0000a097          	auipc	ra,0xa
    80004b7c:	780080e7          	jalr	1920(ra) # 8000f2f8 <_Unwind_Resume>

0000000080004b80 <_ZL9fibonaccim>:
static volatile bool finishedA = false;
static volatile bool finishedB = false;
static volatile bool finishedC = false;
static volatile bool finishedD = false;

static uint64 fibonacci(uint64 n) {
    80004b80:	fe010113          	addi	sp,sp,-32
    80004b84:	00113c23          	sd	ra,24(sp)
    80004b88:	00813823          	sd	s0,16(sp)
    80004b8c:	00913423          	sd	s1,8(sp)
    80004b90:	01213023          	sd	s2,0(sp)
    80004b94:	02010413          	addi	s0,sp,32
    80004b98:	00050493          	mv	s1,a0
    if (n == 0 || n == 1) { return n; }
    80004b9c:	00100793          	li	a5,1
    80004ba0:	02a7f863          	bgeu	a5,a0,80004bd0 <_ZL9fibonaccim+0x50>
    if (n % 10 == 0) { thread_dispatch(); }
    80004ba4:	00a00793          	li	a5,10
    80004ba8:	02f577b3          	remu	a5,a0,a5
    80004bac:	02078e63          	beqz	a5,80004be8 <_ZL9fibonaccim+0x68>
    return fibonacci(n - 1) + fibonacci(n - 2);
    80004bb0:	fff48513          	addi	a0,s1,-1
    80004bb4:	00000097          	auipc	ra,0x0
    80004bb8:	fcc080e7          	jalr	-52(ra) # 80004b80 <_ZL9fibonaccim>
    80004bbc:	00050913          	mv	s2,a0
    80004bc0:	ffe48513          	addi	a0,s1,-2
    80004bc4:	00000097          	auipc	ra,0x0
    80004bc8:	fbc080e7          	jalr	-68(ra) # 80004b80 <_ZL9fibonaccim>
    80004bcc:	00a90533          	add	a0,s2,a0
}
    80004bd0:	01813083          	ld	ra,24(sp)
    80004bd4:	01013403          	ld	s0,16(sp)
    80004bd8:	00813483          	ld	s1,8(sp)
    80004bdc:	00013903          	ld	s2,0(sp)
    80004be0:	02010113          	addi	sp,sp,32
    80004be4:	00008067          	ret
    if (n % 10 == 0) { thread_dispatch(); }
    80004be8:	ffffc097          	auipc	ra,0xffffc
    80004bec:	7a0080e7          	jalr	1952(ra) # 80001388 <_Z15thread_dispatchv>
    80004bf0:	fc1ff06f          	j	80004bb0 <_ZL9fibonaccim+0x30>

0000000080004bf4 <_ZN7WorkerA11workerBodyAEPv>:
    void run() override {
        workerBodyD(nullptr);
    }
};

void WorkerA::workerBodyA(void *arg) {
    80004bf4:	fe010113          	addi	sp,sp,-32
    80004bf8:	00113c23          	sd	ra,24(sp)
    80004bfc:	00813823          	sd	s0,16(sp)
    80004c00:	00913423          	sd	s1,8(sp)
    80004c04:	01213023          	sd	s2,0(sp)
    80004c08:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 10; i++) {
    80004c0c:	00000913          	li	s2,0
    80004c10:	0380006f          	j	80004c48 <_ZN7WorkerA11workerBodyAEPv+0x54>
        printString("A: i="); printInt(i); printString("\n");
        for (uint64 j = 0; j < 10000; j++) {
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
            thread_dispatch();
    80004c14:	ffffc097          	auipc	ra,0xffffc
    80004c18:	774080e7          	jalr	1908(ra) # 80001388 <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++) {
    80004c1c:	00148493          	addi	s1,s1,1
    80004c20:	000027b7          	lui	a5,0x2
    80004c24:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    80004c28:	0097ee63          	bltu	a5,s1,80004c44 <_ZN7WorkerA11workerBodyAEPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    80004c2c:	00000713          	li	a4,0
    80004c30:	000077b7          	lui	a5,0x7
    80004c34:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    80004c38:	fce7eee3          	bltu	a5,a4,80004c14 <_ZN7WorkerA11workerBodyAEPv+0x20>
    80004c3c:	00170713          	addi	a4,a4,1
    80004c40:	ff1ff06f          	j	80004c30 <_ZN7WorkerA11workerBodyAEPv+0x3c>
    for (uint64 i = 0; i < 10; i++) {
    80004c44:	00190913          	addi	s2,s2,1
    80004c48:	00900793          	li	a5,9
    80004c4c:	0527e063          	bltu	a5,s2,80004c8c <_ZN7WorkerA11workerBodyAEPv+0x98>
        printString("A: i="); printInt(i); printString("\n");
    80004c50:	00006517          	auipc	a0,0x6
    80004c54:	89850513          	addi	a0,a0,-1896 # 8000a4e8 <CONSOLE_STATUS+0x4d8>
    80004c58:	ffffd097          	auipc	ra,0xffffd
    80004c5c:	254080e7          	jalr	596(ra) # 80001eac <_Z11printStringPKc>
    80004c60:	00000613          	li	a2,0
    80004c64:	00a00593          	li	a1,10
    80004c68:	0009051b          	sext.w	a0,s2
    80004c6c:	ffffd097          	auipc	ra,0xffffd
    80004c70:	3f0080e7          	jalr	1008(ra) # 8000205c <_Z8printIntiii>
    80004c74:	00006517          	auipc	a0,0x6
    80004c78:	ac450513          	addi	a0,a0,-1340 # 8000a738 <CONSOLE_STATUS+0x728>
    80004c7c:	ffffd097          	auipc	ra,0xffffd
    80004c80:	230080e7          	jalr	560(ra) # 80001eac <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    80004c84:	00000493          	li	s1,0
    80004c88:	f99ff06f          	j	80004c20 <_ZN7WorkerA11workerBodyAEPv+0x2c>
        }
    }
    printString("A finished!\n");
    80004c8c:	00006517          	auipc	a0,0x6
    80004c90:	86450513          	addi	a0,a0,-1948 # 8000a4f0 <CONSOLE_STATUS+0x4e0>
    80004c94:	ffffd097          	auipc	ra,0xffffd
    80004c98:	218080e7          	jalr	536(ra) # 80001eac <_Z11printStringPKc>
    finishedA = true;
    80004c9c:	00100793          	li	a5,1
    80004ca0:	00009717          	auipc	a4,0x9
    80004ca4:	54f70c23          	sb	a5,1368(a4) # 8000e1f8 <_ZL9finishedA>
}
    80004ca8:	01813083          	ld	ra,24(sp)
    80004cac:	01013403          	ld	s0,16(sp)
    80004cb0:	00813483          	ld	s1,8(sp)
    80004cb4:	00013903          	ld	s2,0(sp)
    80004cb8:	02010113          	addi	sp,sp,32
    80004cbc:	00008067          	ret

0000000080004cc0 <_ZN7WorkerB11workerBodyBEPv>:

void WorkerB::workerBodyB(void *arg) {
    80004cc0:	fe010113          	addi	sp,sp,-32
    80004cc4:	00113c23          	sd	ra,24(sp)
    80004cc8:	00813823          	sd	s0,16(sp)
    80004ccc:	00913423          	sd	s1,8(sp)
    80004cd0:	01213023          	sd	s2,0(sp)
    80004cd4:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 16; i++) {
    80004cd8:	00000913          	li	s2,0
    80004cdc:	0380006f          	j	80004d14 <_ZN7WorkerB11workerBodyBEPv+0x54>
        printString("B: i="); printInt(i); printString("\n");
        for (uint64 j = 0; j < 10000; j++) {
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
            thread_dispatch();
    80004ce0:	ffffc097          	auipc	ra,0xffffc
    80004ce4:	6a8080e7          	jalr	1704(ra) # 80001388 <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++) {
    80004ce8:	00148493          	addi	s1,s1,1
    80004cec:	000027b7          	lui	a5,0x2
    80004cf0:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    80004cf4:	0097ee63          	bltu	a5,s1,80004d10 <_ZN7WorkerB11workerBodyBEPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    80004cf8:	00000713          	li	a4,0
    80004cfc:	000077b7          	lui	a5,0x7
    80004d00:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    80004d04:	fce7eee3          	bltu	a5,a4,80004ce0 <_ZN7WorkerB11workerBodyBEPv+0x20>
    80004d08:	00170713          	addi	a4,a4,1
    80004d0c:	ff1ff06f          	j	80004cfc <_ZN7WorkerB11workerBodyBEPv+0x3c>
    for (uint64 i = 0; i < 16; i++) {
    80004d10:	00190913          	addi	s2,s2,1
    80004d14:	00f00793          	li	a5,15
    80004d18:	0527e063          	bltu	a5,s2,80004d58 <_ZN7WorkerB11workerBodyBEPv+0x98>
        printString("B: i="); printInt(i); printString("\n");
    80004d1c:	00005517          	auipc	a0,0x5
    80004d20:	7e450513          	addi	a0,a0,2020 # 8000a500 <CONSOLE_STATUS+0x4f0>
    80004d24:	ffffd097          	auipc	ra,0xffffd
    80004d28:	188080e7          	jalr	392(ra) # 80001eac <_Z11printStringPKc>
    80004d2c:	00000613          	li	a2,0
    80004d30:	00a00593          	li	a1,10
    80004d34:	0009051b          	sext.w	a0,s2
    80004d38:	ffffd097          	auipc	ra,0xffffd
    80004d3c:	324080e7          	jalr	804(ra) # 8000205c <_Z8printIntiii>
    80004d40:	00006517          	auipc	a0,0x6
    80004d44:	9f850513          	addi	a0,a0,-1544 # 8000a738 <CONSOLE_STATUS+0x728>
    80004d48:	ffffd097          	auipc	ra,0xffffd
    80004d4c:	164080e7          	jalr	356(ra) # 80001eac <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    80004d50:	00000493          	li	s1,0
    80004d54:	f99ff06f          	j	80004cec <_ZN7WorkerB11workerBodyBEPv+0x2c>
        }
    }
    printString("B finished!\n");
    80004d58:	00005517          	auipc	a0,0x5
    80004d5c:	7b050513          	addi	a0,a0,1968 # 8000a508 <CONSOLE_STATUS+0x4f8>
    80004d60:	ffffd097          	auipc	ra,0xffffd
    80004d64:	14c080e7          	jalr	332(ra) # 80001eac <_Z11printStringPKc>
    finishedB = true;
    80004d68:	00100793          	li	a5,1
    80004d6c:	00009717          	auipc	a4,0x9
    80004d70:	48f706a3          	sb	a5,1165(a4) # 8000e1f9 <_ZL9finishedB>
    thread_dispatch();
    80004d74:	ffffc097          	auipc	ra,0xffffc
    80004d78:	614080e7          	jalr	1556(ra) # 80001388 <_Z15thread_dispatchv>
}
    80004d7c:	01813083          	ld	ra,24(sp)
    80004d80:	01013403          	ld	s0,16(sp)
    80004d84:	00813483          	ld	s1,8(sp)
    80004d88:	00013903          	ld	s2,0(sp)
    80004d8c:	02010113          	addi	sp,sp,32
    80004d90:	00008067          	ret

0000000080004d94 <_ZN7WorkerC11workerBodyCEPv>:

void WorkerC::workerBodyC(void *arg) {
    80004d94:	fe010113          	addi	sp,sp,-32
    80004d98:	00113c23          	sd	ra,24(sp)
    80004d9c:	00813823          	sd	s0,16(sp)
    80004da0:	00913423          	sd	s1,8(sp)
    80004da4:	01213023          	sd	s2,0(sp)
    80004da8:	02010413          	addi	s0,sp,32
    uint8 i = 0;
    80004dac:	00000493          	li	s1,0
    80004db0:	0400006f          	j	80004df0 <_ZN7WorkerC11workerBodyCEPv+0x5c>
    for (; i < 3; i++) {
        printString("C: i="); printInt(i); printString("\n");
    80004db4:	00005517          	auipc	a0,0x5
    80004db8:	76450513          	addi	a0,a0,1892 # 8000a518 <CONSOLE_STATUS+0x508>
    80004dbc:	ffffd097          	auipc	ra,0xffffd
    80004dc0:	0f0080e7          	jalr	240(ra) # 80001eac <_Z11printStringPKc>
    80004dc4:	00000613          	li	a2,0
    80004dc8:	00a00593          	li	a1,10
    80004dcc:	00048513          	mv	a0,s1
    80004dd0:	ffffd097          	auipc	ra,0xffffd
    80004dd4:	28c080e7          	jalr	652(ra) # 8000205c <_Z8printIntiii>
    80004dd8:	00006517          	auipc	a0,0x6
    80004ddc:	96050513          	addi	a0,a0,-1696 # 8000a738 <CONSOLE_STATUS+0x728>
    80004de0:	ffffd097          	auipc	ra,0xffffd
    80004de4:	0cc080e7          	jalr	204(ra) # 80001eac <_Z11printStringPKc>
    for (; i < 3; i++) {
    80004de8:	0014849b          	addiw	s1,s1,1
    80004dec:	0ff4f493          	andi	s1,s1,255
    80004df0:	00200793          	li	a5,2
    80004df4:	fc97f0e3          	bgeu	a5,s1,80004db4 <_ZN7WorkerC11workerBodyCEPv+0x20>
    }

    printString("C: dispatch\n");
    80004df8:	00005517          	auipc	a0,0x5
    80004dfc:	72850513          	addi	a0,a0,1832 # 8000a520 <CONSOLE_STATUS+0x510>
    80004e00:	ffffd097          	auipc	ra,0xffffd
    80004e04:	0ac080e7          	jalr	172(ra) # 80001eac <_Z11printStringPKc>
    __asm__ ("li t1, 7");
    80004e08:	00700313          	li	t1,7
    thread_dispatch();
    80004e0c:	ffffc097          	auipc	ra,0xffffc
    80004e10:	57c080e7          	jalr	1404(ra) # 80001388 <_Z15thread_dispatchv>

    uint64 t1 = 0;
    __asm__ ("mv %[t1], t1" : [t1] "=r"(t1));
    80004e14:	00030913          	mv	s2,t1

    printString("C: t1="); printInt(t1); printString("\n");
    80004e18:	00005517          	auipc	a0,0x5
    80004e1c:	71850513          	addi	a0,a0,1816 # 8000a530 <CONSOLE_STATUS+0x520>
    80004e20:	ffffd097          	auipc	ra,0xffffd
    80004e24:	08c080e7          	jalr	140(ra) # 80001eac <_Z11printStringPKc>
    80004e28:	00000613          	li	a2,0
    80004e2c:	00a00593          	li	a1,10
    80004e30:	0009051b          	sext.w	a0,s2
    80004e34:	ffffd097          	auipc	ra,0xffffd
    80004e38:	228080e7          	jalr	552(ra) # 8000205c <_Z8printIntiii>
    80004e3c:	00006517          	auipc	a0,0x6
    80004e40:	8fc50513          	addi	a0,a0,-1796 # 8000a738 <CONSOLE_STATUS+0x728>
    80004e44:	ffffd097          	auipc	ra,0xffffd
    80004e48:	068080e7          	jalr	104(ra) # 80001eac <_Z11printStringPKc>

    uint64 result = fibonacci(12);
    80004e4c:	00c00513          	li	a0,12
    80004e50:	00000097          	auipc	ra,0x0
    80004e54:	d30080e7          	jalr	-720(ra) # 80004b80 <_ZL9fibonaccim>
    80004e58:	00050913          	mv	s2,a0
    printString("C: fibonaci="); printInt(result); printString("\n");
    80004e5c:	00005517          	auipc	a0,0x5
    80004e60:	6dc50513          	addi	a0,a0,1756 # 8000a538 <CONSOLE_STATUS+0x528>
    80004e64:	ffffd097          	auipc	ra,0xffffd
    80004e68:	048080e7          	jalr	72(ra) # 80001eac <_Z11printStringPKc>
    80004e6c:	00000613          	li	a2,0
    80004e70:	00a00593          	li	a1,10
    80004e74:	0009051b          	sext.w	a0,s2
    80004e78:	ffffd097          	auipc	ra,0xffffd
    80004e7c:	1e4080e7          	jalr	484(ra) # 8000205c <_Z8printIntiii>
    80004e80:	00006517          	auipc	a0,0x6
    80004e84:	8b850513          	addi	a0,a0,-1864 # 8000a738 <CONSOLE_STATUS+0x728>
    80004e88:	ffffd097          	auipc	ra,0xffffd
    80004e8c:	024080e7          	jalr	36(ra) # 80001eac <_Z11printStringPKc>
    80004e90:	0400006f          	j	80004ed0 <_ZN7WorkerC11workerBodyCEPv+0x13c>

    for (; i < 6; i++) {
        printString("C: i="); printInt(i); printString("\n");
    80004e94:	00005517          	auipc	a0,0x5
    80004e98:	68450513          	addi	a0,a0,1668 # 8000a518 <CONSOLE_STATUS+0x508>
    80004e9c:	ffffd097          	auipc	ra,0xffffd
    80004ea0:	010080e7          	jalr	16(ra) # 80001eac <_Z11printStringPKc>
    80004ea4:	00000613          	li	a2,0
    80004ea8:	00a00593          	li	a1,10
    80004eac:	00048513          	mv	a0,s1
    80004eb0:	ffffd097          	auipc	ra,0xffffd
    80004eb4:	1ac080e7          	jalr	428(ra) # 8000205c <_Z8printIntiii>
    80004eb8:	00006517          	auipc	a0,0x6
    80004ebc:	88050513          	addi	a0,a0,-1920 # 8000a738 <CONSOLE_STATUS+0x728>
    80004ec0:	ffffd097          	auipc	ra,0xffffd
    80004ec4:	fec080e7          	jalr	-20(ra) # 80001eac <_Z11printStringPKc>
    for (; i < 6; i++) {
    80004ec8:	0014849b          	addiw	s1,s1,1
    80004ecc:	0ff4f493          	andi	s1,s1,255
    80004ed0:	00500793          	li	a5,5
    80004ed4:	fc97f0e3          	bgeu	a5,s1,80004e94 <_ZN7WorkerC11workerBodyCEPv+0x100>
    }

    printString("A finished!\n");
    80004ed8:	00005517          	auipc	a0,0x5
    80004edc:	61850513          	addi	a0,a0,1560 # 8000a4f0 <CONSOLE_STATUS+0x4e0>
    80004ee0:	ffffd097          	auipc	ra,0xffffd
    80004ee4:	fcc080e7          	jalr	-52(ra) # 80001eac <_Z11printStringPKc>
    finishedC = true;
    80004ee8:	00100793          	li	a5,1
    80004eec:	00009717          	auipc	a4,0x9
    80004ef0:	30f70723          	sb	a5,782(a4) # 8000e1fa <_ZL9finishedC>
    thread_dispatch();
    80004ef4:	ffffc097          	auipc	ra,0xffffc
    80004ef8:	494080e7          	jalr	1172(ra) # 80001388 <_Z15thread_dispatchv>
}
    80004efc:	01813083          	ld	ra,24(sp)
    80004f00:	01013403          	ld	s0,16(sp)
    80004f04:	00813483          	ld	s1,8(sp)
    80004f08:	00013903          	ld	s2,0(sp)
    80004f0c:	02010113          	addi	sp,sp,32
    80004f10:	00008067          	ret

0000000080004f14 <_ZN7WorkerD11workerBodyDEPv>:

void WorkerD::workerBodyD(void* arg) {
    80004f14:	fe010113          	addi	sp,sp,-32
    80004f18:	00113c23          	sd	ra,24(sp)
    80004f1c:	00813823          	sd	s0,16(sp)
    80004f20:	00913423          	sd	s1,8(sp)
    80004f24:	01213023          	sd	s2,0(sp)
    80004f28:	02010413          	addi	s0,sp,32
    uint8 i = 10;
    80004f2c:	00a00493          	li	s1,10
    80004f30:	0400006f          	j	80004f70 <_ZN7WorkerD11workerBodyDEPv+0x5c>
    for (; i < 13; i++) {
        printString("D: i="); printInt(i); printString("\n");
    80004f34:	00005517          	auipc	a0,0x5
    80004f38:	61450513          	addi	a0,a0,1556 # 8000a548 <CONSOLE_STATUS+0x538>
    80004f3c:	ffffd097          	auipc	ra,0xffffd
    80004f40:	f70080e7          	jalr	-144(ra) # 80001eac <_Z11printStringPKc>
    80004f44:	00000613          	li	a2,0
    80004f48:	00a00593          	li	a1,10
    80004f4c:	00048513          	mv	a0,s1
    80004f50:	ffffd097          	auipc	ra,0xffffd
    80004f54:	10c080e7          	jalr	268(ra) # 8000205c <_Z8printIntiii>
    80004f58:	00005517          	auipc	a0,0x5
    80004f5c:	7e050513          	addi	a0,a0,2016 # 8000a738 <CONSOLE_STATUS+0x728>
    80004f60:	ffffd097          	auipc	ra,0xffffd
    80004f64:	f4c080e7          	jalr	-180(ra) # 80001eac <_Z11printStringPKc>
    for (; i < 13; i++) {
    80004f68:	0014849b          	addiw	s1,s1,1
    80004f6c:	0ff4f493          	andi	s1,s1,255
    80004f70:	00c00793          	li	a5,12
    80004f74:	fc97f0e3          	bgeu	a5,s1,80004f34 <_ZN7WorkerD11workerBodyDEPv+0x20>
    }

    printString("D: dispatch\n");
    80004f78:	00005517          	auipc	a0,0x5
    80004f7c:	5d850513          	addi	a0,a0,1496 # 8000a550 <CONSOLE_STATUS+0x540>
    80004f80:	ffffd097          	auipc	ra,0xffffd
    80004f84:	f2c080e7          	jalr	-212(ra) # 80001eac <_Z11printStringPKc>
    __asm__ ("li t1, 5");
    80004f88:	00500313          	li	t1,5
    thread_dispatch();
    80004f8c:	ffffc097          	auipc	ra,0xffffc
    80004f90:	3fc080e7          	jalr	1020(ra) # 80001388 <_Z15thread_dispatchv>

    uint64 result = fibonacci(16);
    80004f94:	01000513          	li	a0,16
    80004f98:	00000097          	auipc	ra,0x0
    80004f9c:	be8080e7          	jalr	-1048(ra) # 80004b80 <_ZL9fibonaccim>
    80004fa0:	00050913          	mv	s2,a0
    printString("D: fibonaci="); printInt(result); printString("\n");
    80004fa4:	00005517          	auipc	a0,0x5
    80004fa8:	5bc50513          	addi	a0,a0,1468 # 8000a560 <CONSOLE_STATUS+0x550>
    80004fac:	ffffd097          	auipc	ra,0xffffd
    80004fb0:	f00080e7          	jalr	-256(ra) # 80001eac <_Z11printStringPKc>
    80004fb4:	00000613          	li	a2,0
    80004fb8:	00a00593          	li	a1,10
    80004fbc:	0009051b          	sext.w	a0,s2
    80004fc0:	ffffd097          	auipc	ra,0xffffd
    80004fc4:	09c080e7          	jalr	156(ra) # 8000205c <_Z8printIntiii>
    80004fc8:	00005517          	auipc	a0,0x5
    80004fcc:	77050513          	addi	a0,a0,1904 # 8000a738 <CONSOLE_STATUS+0x728>
    80004fd0:	ffffd097          	auipc	ra,0xffffd
    80004fd4:	edc080e7          	jalr	-292(ra) # 80001eac <_Z11printStringPKc>
    80004fd8:	0400006f          	j	80005018 <_ZN7WorkerD11workerBodyDEPv+0x104>

    for (; i < 16; i++) {
        printString("D: i="); printInt(i); printString("\n");
    80004fdc:	00005517          	auipc	a0,0x5
    80004fe0:	56c50513          	addi	a0,a0,1388 # 8000a548 <CONSOLE_STATUS+0x538>
    80004fe4:	ffffd097          	auipc	ra,0xffffd
    80004fe8:	ec8080e7          	jalr	-312(ra) # 80001eac <_Z11printStringPKc>
    80004fec:	00000613          	li	a2,0
    80004ff0:	00a00593          	li	a1,10
    80004ff4:	00048513          	mv	a0,s1
    80004ff8:	ffffd097          	auipc	ra,0xffffd
    80004ffc:	064080e7          	jalr	100(ra) # 8000205c <_Z8printIntiii>
    80005000:	00005517          	auipc	a0,0x5
    80005004:	73850513          	addi	a0,a0,1848 # 8000a738 <CONSOLE_STATUS+0x728>
    80005008:	ffffd097          	auipc	ra,0xffffd
    8000500c:	ea4080e7          	jalr	-348(ra) # 80001eac <_Z11printStringPKc>
    for (; i < 16; i++) {
    80005010:	0014849b          	addiw	s1,s1,1
    80005014:	0ff4f493          	andi	s1,s1,255
    80005018:	00f00793          	li	a5,15
    8000501c:	fc97f0e3          	bgeu	a5,s1,80004fdc <_ZN7WorkerD11workerBodyDEPv+0xc8>
    }

    printString("D finished!\n");
    80005020:	00005517          	auipc	a0,0x5
    80005024:	55050513          	addi	a0,a0,1360 # 8000a570 <CONSOLE_STATUS+0x560>
    80005028:	ffffd097          	auipc	ra,0xffffd
    8000502c:	e84080e7          	jalr	-380(ra) # 80001eac <_Z11printStringPKc>
    finishedD = true;
    80005030:	00100793          	li	a5,1
    80005034:	00009717          	auipc	a4,0x9
    80005038:	1cf703a3          	sb	a5,455(a4) # 8000e1fb <_ZL9finishedD>
    thread_dispatch();
    8000503c:	ffffc097          	auipc	ra,0xffffc
    80005040:	34c080e7          	jalr	844(ra) # 80001388 <_Z15thread_dispatchv>
}
    80005044:	01813083          	ld	ra,24(sp)
    80005048:	01013403          	ld	s0,16(sp)
    8000504c:	00813483          	ld	s1,8(sp)
    80005050:	00013903          	ld	s2,0(sp)
    80005054:	02010113          	addi	sp,sp,32
    80005058:	00008067          	ret

000000008000505c <_Z20Threads_CPP_API_testv>:


void Threads_CPP_API_test() {
    8000505c:	fc010113          	addi	sp,sp,-64
    80005060:	02113c23          	sd	ra,56(sp)
    80005064:	02813823          	sd	s0,48(sp)
    80005068:	02913423          	sd	s1,40(sp)
    8000506c:	04010413          	addi	s0,sp,64
    Thread* threads[4];

    threads[0] = new WorkerA();
    80005070:	02000513          	li	a0,32
    80005074:	ffffe097          	auipc	ra,0xffffe
    80005078:	b6c080e7          	jalr	-1172(ra) # 80002be0 <_Znwm>
        static int sleep (uint64 time){
            return time_sleep(time);
        }
        protected:
        Thread (){
            body= nullptr;
    8000507c:	00053823          	sd	zero,16(a0)
            arg= nullptr;
    80005080:	00053c23          	sd	zero,24(a0)
    WorkerA():Thread() {}
    80005084:	00008797          	auipc	a5,0x8
    80005088:	9ec78793          	addi	a5,a5,-1556 # 8000ca70 <_ZTV7WorkerA+0x10>
    8000508c:	00f53023          	sd	a5,0(a0)
    threads[0] = new WorkerA();
    80005090:	fca43023          	sd	a0,-64(s0)
    printString("ThreadA created\n");
    80005094:	00005517          	auipc	a0,0x5
    80005098:	4ec50513          	addi	a0,a0,1260 # 8000a580 <CONSOLE_STATUS+0x570>
    8000509c:	ffffd097          	auipc	ra,0xffffd
    800050a0:	e10080e7          	jalr	-496(ra) # 80001eac <_Z11printStringPKc>

    threads[1] = new WorkerB();
    800050a4:	02000513          	li	a0,32
    800050a8:	ffffe097          	auipc	ra,0xffffe
    800050ac:	b38080e7          	jalr	-1224(ra) # 80002be0 <_Znwm>
            body= nullptr;
    800050b0:	00053823          	sd	zero,16(a0)
            arg= nullptr;
    800050b4:	00053c23          	sd	zero,24(a0)
    WorkerB():Thread() {}
    800050b8:	00008797          	auipc	a5,0x8
    800050bc:	9e078793          	addi	a5,a5,-1568 # 8000ca98 <_ZTV7WorkerB+0x10>
    800050c0:	00f53023          	sd	a5,0(a0)
    threads[1] = new WorkerB();
    800050c4:	fca43423          	sd	a0,-56(s0)
    printString("ThreadB created\n");
    800050c8:	00005517          	auipc	a0,0x5
    800050cc:	4d050513          	addi	a0,a0,1232 # 8000a598 <CONSOLE_STATUS+0x588>
    800050d0:	ffffd097          	auipc	ra,0xffffd
    800050d4:	ddc080e7          	jalr	-548(ra) # 80001eac <_Z11printStringPKc>

    threads[2] = new WorkerC();
    800050d8:	02000513          	li	a0,32
    800050dc:	ffffe097          	auipc	ra,0xffffe
    800050e0:	b04080e7          	jalr	-1276(ra) # 80002be0 <_Znwm>
            body= nullptr;
    800050e4:	00053823          	sd	zero,16(a0)
            arg= nullptr;
    800050e8:	00053c23          	sd	zero,24(a0)
    WorkerC():Thread() {}
    800050ec:	00008797          	auipc	a5,0x8
    800050f0:	9d478793          	addi	a5,a5,-1580 # 8000cac0 <_ZTV7WorkerC+0x10>
    800050f4:	00f53023          	sd	a5,0(a0)
    threads[2] = new WorkerC();
    800050f8:	fca43823          	sd	a0,-48(s0)
    printString("ThreadC created\n");
    800050fc:	00005517          	auipc	a0,0x5
    80005100:	4b450513          	addi	a0,a0,1204 # 8000a5b0 <CONSOLE_STATUS+0x5a0>
    80005104:	ffffd097          	auipc	ra,0xffffd
    80005108:	da8080e7          	jalr	-600(ra) # 80001eac <_Z11printStringPKc>

    threads[3] = new WorkerD();
    8000510c:	02000513          	li	a0,32
    80005110:	ffffe097          	auipc	ra,0xffffe
    80005114:	ad0080e7          	jalr	-1328(ra) # 80002be0 <_Znwm>
            body= nullptr;
    80005118:	00053823          	sd	zero,16(a0)
            arg= nullptr;
    8000511c:	00053c23          	sd	zero,24(a0)
    WorkerD():Thread() {}
    80005120:	00008797          	auipc	a5,0x8
    80005124:	9c878793          	addi	a5,a5,-1592 # 8000cae8 <_ZTV7WorkerD+0x10>
    80005128:	00f53023          	sd	a5,0(a0)
    threads[3] = new WorkerD();
    8000512c:	fca43c23          	sd	a0,-40(s0)
    printString("ThreadD created\n");
    80005130:	00005517          	auipc	a0,0x5
    80005134:	49850513          	addi	a0,a0,1176 # 8000a5c8 <CONSOLE_STATUS+0x5b8>
    80005138:	ffffd097          	auipc	ra,0xffffd
    8000513c:	d74080e7          	jalr	-652(ra) # 80001eac <_Z11printStringPKc>

    for(int i=0; i<4; i++) {
    80005140:	00000493          	li	s1,0
    80005144:	0200006f          	j	80005164 <_Z20Threads_CPP_API_testv+0x108>
            if(body== nullptr) return thread_create(&myHandle,&threadEntry, this);
    80005148:	00050613          	mv	a2,a0
    8000514c:	ffffe597          	auipc	a1,0xffffe
    80005150:	a4058593          	addi	a1,a1,-1472 # 80002b8c <_ZN6Thread11threadEntryEPv>
    80005154:	00850513          	addi	a0,a0,8
    80005158:	ffffc097          	auipc	ra,0xffffc
    8000515c:	1a8080e7          	jalr	424(ra) # 80001300 <_Z13thread_createPP8thread_sPFvPvES2_>
    80005160:	0014849b          	addiw	s1,s1,1
    80005164:	00300793          	li	a5,3
    80005168:	0297cc63          	blt	a5,s1,800051a0 <_Z20Threads_CPP_API_testv+0x144>
        threads[i]->start();
    8000516c:	00349793          	slli	a5,s1,0x3
    80005170:	fe040713          	addi	a4,s0,-32
    80005174:	00f707b3          	add	a5,a4,a5
    80005178:	fe07b503          	ld	a0,-32(a5)
    8000517c:	01053583          	ld	a1,16(a0)
    80005180:	fc0584e3          	beqz	a1,80005148 <_Z20Threads_CPP_API_testv+0xec>
            else return thread_create(&myHandle,body,arg);
    80005184:	01853603          	ld	a2,24(a0)
    80005188:	00850513          	addi	a0,a0,8
    8000518c:	ffffc097          	auipc	ra,0xffffc
    80005190:	174080e7          	jalr	372(ra) # 80001300 <_Z13thread_createPP8thread_sPFvPvES2_>
    80005194:	fcdff06f          	j	80005160 <_Z20Threads_CPP_API_testv+0x104>
            thread_dispatch();
    80005198:	ffffc097          	auipc	ra,0xffffc
    8000519c:	1f0080e7          	jalr	496(ra) # 80001388 <_Z15thread_dispatchv>
    }

    while (!(finishedA && finishedB && finishedC && finishedD)) {
    800051a0:	00009797          	auipc	a5,0x9
    800051a4:	0587c783          	lbu	a5,88(a5) # 8000e1f8 <_ZL9finishedA>
    800051a8:	fe0788e3          	beqz	a5,80005198 <_Z20Threads_CPP_API_testv+0x13c>
    800051ac:	00009797          	auipc	a5,0x9
    800051b0:	04d7c783          	lbu	a5,77(a5) # 8000e1f9 <_ZL9finishedB>
    800051b4:	fe0782e3          	beqz	a5,80005198 <_Z20Threads_CPP_API_testv+0x13c>
    800051b8:	00009797          	auipc	a5,0x9
    800051bc:	0427c783          	lbu	a5,66(a5) # 8000e1fa <_ZL9finishedC>
    800051c0:	fc078ce3          	beqz	a5,80005198 <_Z20Threads_CPP_API_testv+0x13c>
    800051c4:	00009797          	auipc	a5,0x9
    800051c8:	0377c783          	lbu	a5,55(a5) # 8000e1fb <_ZL9finishedD>
    800051cc:	fc0786e3          	beqz	a5,80005198 <_Z20Threads_CPP_API_testv+0x13c>
    800051d0:	fc040493          	addi	s1,s0,-64
    800051d4:	0080006f          	j	800051dc <_Z20Threads_CPP_API_testv+0x180>
        Thread::dispatch();
    }

    for (auto thread: threads) { delete thread; }
    800051d8:	00848493          	addi	s1,s1,8
    800051dc:	fe040793          	addi	a5,s0,-32
    800051e0:	00f48e63          	beq	s1,a5,800051fc <_Z20Threads_CPP_API_testv+0x1a0>
    800051e4:	0004b503          	ld	a0,0(s1)
    800051e8:	fe0508e3          	beqz	a0,800051d8 <_Z20Threads_CPP_API_testv+0x17c>
    800051ec:	00053783          	ld	a5,0(a0)
    800051f0:	0087b783          	ld	a5,8(a5)
    800051f4:	000780e7          	jalr	a5
    800051f8:	fe1ff06f          	j	800051d8 <_Z20Threads_CPP_API_testv+0x17c>
}
    800051fc:	03813083          	ld	ra,56(sp)
    80005200:	03013403          	ld	s0,48(sp)
    80005204:	02813483          	ld	s1,40(sp)
    80005208:	04010113          	addi	sp,sp,64
    8000520c:	00008067          	ret

0000000080005210 <_ZN7WorkerDD1Ev>:
class WorkerD: public Thread {
    80005210:	ff010113          	addi	sp,sp,-16
    80005214:	00813423          	sd	s0,8(sp)
    80005218:	01010413          	addi	s0,sp,16
    8000521c:	00813403          	ld	s0,8(sp)
    80005220:	01010113          	addi	sp,sp,16
    80005224:	00008067          	ret

0000000080005228 <_ZN7WorkerCD1Ev>:
class WorkerC: public Thread {
    80005228:	ff010113          	addi	sp,sp,-16
    8000522c:	00813423          	sd	s0,8(sp)
    80005230:	01010413          	addi	s0,sp,16
    80005234:	00813403          	ld	s0,8(sp)
    80005238:	01010113          	addi	sp,sp,16
    8000523c:	00008067          	ret

0000000080005240 <_ZN7WorkerBD1Ev>:
class WorkerB: public Thread {
    80005240:	ff010113          	addi	sp,sp,-16
    80005244:	00813423          	sd	s0,8(sp)
    80005248:	01010413          	addi	s0,sp,16
    8000524c:	00813403          	ld	s0,8(sp)
    80005250:	01010113          	addi	sp,sp,16
    80005254:	00008067          	ret

0000000080005258 <_ZN7WorkerAD1Ev>:
class WorkerA: public Thread {
    80005258:	ff010113          	addi	sp,sp,-16
    8000525c:	00813423          	sd	s0,8(sp)
    80005260:	01010413          	addi	s0,sp,16
    80005264:	00813403          	ld	s0,8(sp)
    80005268:	01010113          	addi	sp,sp,16
    8000526c:	00008067          	ret

0000000080005270 <_ZN7WorkerAD0Ev>:
    80005270:	ff010113          	addi	sp,sp,-16
    80005274:	00113423          	sd	ra,8(sp)
    80005278:	00813023          	sd	s0,0(sp)
    8000527c:	01010413          	addi	s0,sp,16
    80005280:	ffffe097          	auipc	ra,0xffffe
    80005284:	988080e7          	jalr	-1656(ra) # 80002c08 <_ZdlPv>
    80005288:	00813083          	ld	ra,8(sp)
    8000528c:	00013403          	ld	s0,0(sp)
    80005290:	01010113          	addi	sp,sp,16
    80005294:	00008067          	ret

0000000080005298 <_ZN7WorkerBD0Ev>:
class WorkerB: public Thread {
    80005298:	ff010113          	addi	sp,sp,-16
    8000529c:	00113423          	sd	ra,8(sp)
    800052a0:	00813023          	sd	s0,0(sp)
    800052a4:	01010413          	addi	s0,sp,16
    800052a8:	ffffe097          	auipc	ra,0xffffe
    800052ac:	960080e7          	jalr	-1696(ra) # 80002c08 <_ZdlPv>
    800052b0:	00813083          	ld	ra,8(sp)
    800052b4:	00013403          	ld	s0,0(sp)
    800052b8:	01010113          	addi	sp,sp,16
    800052bc:	00008067          	ret

00000000800052c0 <_ZN7WorkerCD0Ev>:
class WorkerC: public Thread {
    800052c0:	ff010113          	addi	sp,sp,-16
    800052c4:	00113423          	sd	ra,8(sp)
    800052c8:	00813023          	sd	s0,0(sp)
    800052cc:	01010413          	addi	s0,sp,16
    800052d0:	ffffe097          	auipc	ra,0xffffe
    800052d4:	938080e7          	jalr	-1736(ra) # 80002c08 <_ZdlPv>
    800052d8:	00813083          	ld	ra,8(sp)
    800052dc:	00013403          	ld	s0,0(sp)
    800052e0:	01010113          	addi	sp,sp,16
    800052e4:	00008067          	ret

00000000800052e8 <_ZN7WorkerDD0Ev>:
class WorkerD: public Thread {
    800052e8:	ff010113          	addi	sp,sp,-16
    800052ec:	00113423          	sd	ra,8(sp)
    800052f0:	00813023          	sd	s0,0(sp)
    800052f4:	01010413          	addi	s0,sp,16
    800052f8:	ffffe097          	auipc	ra,0xffffe
    800052fc:	910080e7          	jalr	-1776(ra) # 80002c08 <_ZdlPv>
    80005300:	00813083          	ld	ra,8(sp)
    80005304:	00013403          	ld	s0,0(sp)
    80005308:	01010113          	addi	sp,sp,16
    8000530c:	00008067          	ret

0000000080005310 <_ZN7WorkerA3runEv>:
    void run() override {
    80005310:	ff010113          	addi	sp,sp,-16
    80005314:	00113423          	sd	ra,8(sp)
    80005318:	00813023          	sd	s0,0(sp)
    8000531c:	01010413          	addi	s0,sp,16
        workerBodyA(nullptr);
    80005320:	00000593          	li	a1,0
    80005324:	00000097          	auipc	ra,0x0
    80005328:	8d0080e7          	jalr	-1840(ra) # 80004bf4 <_ZN7WorkerA11workerBodyAEPv>
    }
    8000532c:	00813083          	ld	ra,8(sp)
    80005330:	00013403          	ld	s0,0(sp)
    80005334:	01010113          	addi	sp,sp,16
    80005338:	00008067          	ret

000000008000533c <_ZN7WorkerB3runEv>:
    void run() override {
    8000533c:	ff010113          	addi	sp,sp,-16
    80005340:	00113423          	sd	ra,8(sp)
    80005344:	00813023          	sd	s0,0(sp)
    80005348:	01010413          	addi	s0,sp,16
        workerBodyB(nullptr);
    8000534c:	00000593          	li	a1,0
    80005350:	00000097          	auipc	ra,0x0
    80005354:	970080e7          	jalr	-1680(ra) # 80004cc0 <_ZN7WorkerB11workerBodyBEPv>
    }
    80005358:	00813083          	ld	ra,8(sp)
    8000535c:	00013403          	ld	s0,0(sp)
    80005360:	01010113          	addi	sp,sp,16
    80005364:	00008067          	ret

0000000080005368 <_ZN7WorkerC3runEv>:
    void run() override {
    80005368:	ff010113          	addi	sp,sp,-16
    8000536c:	00113423          	sd	ra,8(sp)
    80005370:	00813023          	sd	s0,0(sp)
    80005374:	01010413          	addi	s0,sp,16
        workerBodyC(nullptr);
    80005378:	00000593          	li	a1,0
    8000537c:	00000097          	auipc	ra,0x0
    80005380:	a18080e7          	jalr	-1512(ra) # 80004d94 <_ZN7WorkerC11workerBodyCEPv>
    }
    80005384:	00813083          	ld	ra,8(sp)
    80005388:	00013403          	ld	s0,0(sp)
    8000538c:	01010113          	addi	sp,sp,16
    80005390:	00008067          	ret

0000000080005394 <_ZN7WorkerD3runEv>:
    void run() override {
    80005394:	ff010113          	addi	sp,sp,-16
    80005398:	00113423          	sd	ra,8(sp)
    8000539c:	00813023          	sd	s0,0(sp)
    800053a0:	01010413          	addi	s0,sp,16
        workerBodyD(nullptr);
    800053a4:	00000593          	li	a1,0
    800053a8:	00000097          	auipc	ra,0x0
    800053ac:	b6c080e7          	jalr	-1172(ra) # 80004f14 <_ZN7WorkerD11workerBodyDEPv>
    }
    800053b0:	00813083          	ld	ra,8(sp)
    800053b4:	00013403          	ld	s0,0(sp)
    800053b8:	01010113          	addi	sp,sp,16
    800053bc:	00008067          	ret

00000000800053c0 <_Z20testConsumerProducerv>:

        td->sem->signal();
    }
};

void testConsumerProducer() {
    800053c0:	f9010113          	addi	sp,sp,-112
    800053c4:	06113423          	sd	ra,104(sp)
    800053c8:	06813023          	sd	s0,96(sp)
    800053cc:	04913c23          	sd	s1,88(sp)
    800053d0:	05213823          	sd	s2,80(sp)
    800053d4:	05313423          	sd	s3,72(sp)
    800053d8:	05413023          	sd	s4,64(sp)
    800053dc:	03513c23          	sd	s5,56(sp)
    800053e0:	03613823          	sd	s6,48(sp)
    800053e4:	03713423          	sd	s7,40(sp)
    800053e8:	03813023          	sd	s8,32(sp)
    800053ec:	07010413          	addi	s0,sp,112
    delete waitForAll;
    for (int i = 0; i < threadNum; i++) {
        delete producers[i];
    }
    delete consumer;
    delete buffer;
    800053f0:	00010c13          	mv	s8,sp
    printString("Unesite broj proizvodjaca?\n");
    800053f4:	00005517          	auipc	a0,0x5
    800053f8:	00c50513          	addi	a0,a0,12 # 8000a400 <CONSOLE_STATUS+0x3f0>
    800053fc:	ffffd097          	auipc	ra,0xffffd
    80005400:	ab0080e7          	jalr	-1360(ra) # 80001eac <_Z11printStringPKc>
    getString(input, 30);
    80005404:	01e00593          	li	a1,30
    80005408:	f9040493          	addi	s1,s0,-112
    8000540c:	00048513          	mv	a0,s1
    80005410:	ffffd097          	auipc	ra,0xffffd
    80005414:	b24080e7          	jalr	-1244(ra) # 80001f34 <_Z9getStringPci>
    threadNum = stringToInt(input);
    80005418:	00048513          	mv	a0,s1
    8000541c:	ffffd097          	auipc	ra,0xffffd
    80005420:	bf0080e7          	jalr	-1040(ra) # 8000200c <_Z11stringToIntPKc>
    80005424:	00050993          	mv	s3,a0
    printString("Unesite velicinu bafera?\n");
    80005428:	00005517          	auipc	a0,0x5
    8000542c:	ff850513          	addi	a0,a0,-8 # 8000a420 <CONSOLE_STATUS+0x410>
    80005430:	ffffd097          	auipc	ra,0xffffd
    80005434:	a7c080e7          	jalr	-1412(ra) # 80001eac <_Z11printStringPKc>
    getString(input, 30);
    80005438:	01e00593          	li	a1,30
    8000543c:	00048513          	mv	a0,s1
    80005440:	ffffd097          	auipc	ra,0xffffd
    80005444:	af4080e7          	jalr	-1292(ra) # 80001f34 <_Z9getStringPci>
    n = stringToInt(input);
    80005448:	00048513          	mv	a0,s1
    8000544c:	ffffd097          	auipc	ra,0xffffd
    80005450:	bc0080e7          	jalr	-1088(ra) # 8000200c <_Z11stringToIntPKc>
    80005454:	00050493          	mv	s1,a0
    printString("Broj proizvodjaca ");
    80005458:	00005517          	auipc	a0,0x5
    8000545c:	fe850513          	addi	a0,a0,-24 # 8000a440 <CONSOLE_STATUS+0x430>
    80005460:	ffffd097          	auipc	ra,0xffffd
    80005464:	a4c080e7          	jalr	-1460(ra) # 80001eac <_Z11printStringPKc>
    printInt(threadNum);
    80005468:	00000613          	li	a2,0
    8000546c:	00a00593          	li	a1,10
    80005470:	00098513          	mv	a0,s3
    80005474:	ffffd097          	auipc	ra,0xffffd
    80005478:	be8080e7          	jalr	-1048(ra) # 8000205c <_Z8printIntiii>
    printString(" i velicina bafera ");
    8000547c:	00005517          	auipc	a0,0x5
    80005480:	fdc50513          	addi	a0,a0,-36 # 8000a458 <CONSOLE_STATUS+0x448>
    80005484:	ffffd097          	auipc	ra,0xffffd
    80005488:	a28080e7          	jalr	-1496(ra) # 80001eac <_Z11printStringPKc>
    printInt(n);
    8000548c:	00000613          	li	a2,0
    80005490:	00a00593          	li	a1,10
    80005494:	00048513          	mv	a0,s1
    80005498:	ffffd097          	auipc	ra,0xffffd
    8000549c:	bc4080e7          	jalr	-1084(ra) # 8000205c <_Z8printIntiii>
    printString(".\n");
    800054a0:	00005517          	auipc	a0,0x5
    800054a4:	fd050513          	addi	a0,a0,-48 # 8000a470 <CONSOLE_STATUS+0x460>
    800054a8:	ffffd097          	auipc	ra,0xffffd
    800054ac:	a04080e7          	jalr	-1532(ra) # 80001eac <_Z11printStringPKc>
    if (threadNum > n) {
    800054b0:	0334c463          	blt	s1,s3,800054d8 <_Z20testConsumerProducerv+0x118>
    } else if (threadNum < 1) {
    800054b4:	03305c63          	blez	s3,800054ec <_Z20testConsumerProducerv+0x12c>
    BufferCPP *buffer = new BufferCPP(n);
    800054b8:	03800513          	li	a0,56
    800054bc:	ffffd097          	auipc	ra,0xffffd
    800054c0:	724080e7          	jalr	1828(ra) # 80002be0 <_Znwm>
    800054c4:	00050a93          	mv	s5,a0
    800054c8:	00048593          	mv	a1,s1
    800054cc:	00001097          	auipc	ra,0x1
    800054d0:	3e8080e7          	jalr	1000(ra) # 800068b4 <_ZN9BufferCPPC1Ei>
    800054d4:	0300006f          	j	80005504 <_Z20testConsumerProducerv+0x144>
        printString("Broj proizvodjaca ne sme biti manji od velicine bafera!\n");
    800054d8:	00005517          	auipc	a0,0x5
    800054dc:	fa050513          	addi	a0,a0,-96 # 8000a478 <CONSOLE_STATUS+0x468>
    800054e0:	ffffd097          	auipc	ra,0xffffd
    800054e4:	9cc080e7          	jalr	-1588(ra) # 80001eac <_Z11printStringPKc>
        return;
    800054e8:	0140006f          	j	800054fc <_Z20testConsumerProducerv+0x13c>
        printString("Broj proizvodjaca mora biti veci od nula!\n");
    800054ec:	00005517          	auipc	a0,0x5
    800054f0:	fcc50513          	addi	a0,a0,-52 # 8000a4b8 <CONSOLE_STATUS+0x4a8>
    800054f4:	ffffd097          	auipc	ra,0xffffd
    800054f8:	9b8080e7          	jalr	-1608(ra) # 80001eac <_Z11printStringPKc>
        return;
    800054fc:	000c0113          	mv	sp,s8
    80005500:	2780006f          	j	80005778 <_Z20testConsumerProducerv+0x3b8>
    waitForAll = new Semaphore(0);
    80005504:	01000513          	li	a0,16
    80005508:	ffffd097          	auipc	ra,0xffffd
    8000550c:	6d8080e7          	jalr	1752(ra) # 80002be0 <_Znwm>
    80005510:	00050913          	mv	s2,a0
};


class Semaphore {
        public:
        Semaphore (unsigned init = 1){
    80005514:	00007797          	auipc	a5,0x7
    80005518:	5fc78793          	addi	a5,a5,1532 # 8000cb10 <_ZTV9Semaphore+0x10>
    8000551c:	00f53023          	sd	a5,0(a0)
            sem_open(&myHandle,init);
    80005520:	00000593          	li	a1,0
    80005524:	00850513          	addi	a0,a0,8
    80005528:	ffffc097          	auipc	ra,0xffffc
    8000552c:	f14080e7          	jalr	-236(ra) # 8000143c <_Z8sem_openPP5sem_sj>
    80005530:	00009797          	auipc	a5,0x9
    80005534:	cd27bc23          	sd	s2,-808(a5) # 8000e208 <_ZL10waitForAll>
    Thread *producers[threadNum];
    80005538:	00399793          	slli	a5,s3,0x3
    8000553c:	00f78793          	addi	a5,a5,15
    80005540:	ff07f793          	andi	a5,a5,-16
    80005544:	40f10133          	sub	sp,sp,a5
    80005548:	00010a13          	mv	s4,sp
    thread_data threadData[threadNum + 1];
    8000554c:	0019871b          	addiw	a4,s3,1
    80005550:	00171793          	slli	a5,a4,0x1
    80005554:	00e787b3          	add	a5,a5,a4
    80005558:	00379793          	slli	a5,a5,0x3
    8000555c:	00f78793          	addi	a5,a5,15
    80005560:	ff07f793          	andi	a5,a5,-16
    80005564:	40f10133          	sub	sp,sp,a5
    80005568:	00010b13          	mv	s6,sp
    threadData[threadNum].id = threadNum;
    8000556c:	00199493          	slli	s1,s3,0x1
    80005570:	013484b3          	add	s1,s1,s3
    80005574:	00349493          	slli	s1,s1,0x3
    80005578:	009b04b3          	add	s1,s6,s1
    8000557c:	0134a023          	sw	s3,0(s1)
    threadData[threadNum].buffer = buffer;
    80005580:	0154b423          	sd	s5,8(s1)
    threadData[threadNum].sem = waitForAll;
    80005584:	0124b823          	sd	s2,16(s1)
    Thread *consumer = new Consumer(&threadData[threadNum]);
    80005588:	02800513          	li	a0,40
    8000558c:	ffffd097          	auipc	ra,0xffffd
    80005590:	654080e7          	jalr	1620(ra) # 80002be0 <_Znwm>
    80005594:	00050b93          	mv	s7,a0
            body= nullptr;
    80005598:	00053823          	sd	zero,16(a0)
            arg= nullptr;
    8000559c:	00053c23          	sd	zero,24(a0)
    Consumer(thread_data *_td) : Thread(), td(_td) {}
    800055a0:	00007797          	auipc	a5,0x7
    800055a4:	5e078793          	addi	a5,a5,1504 # 8000cb80 <_ZTV8Consumer+0x10>
    800055a8:	00f53023          	sd	a5,0(a0)
    800055ac:	02953023          	sd	s1,32(a0)
            if(body== nullptr) return thread_create(&myHandle,&threadEntry, this);
    800055b0:	00050613          	mv	a2,a0
    800055b4:	ffffd597          	auipc	a1,0xffffd
    800055b8:	5d858593          	addi	a1,a1,1496 # 80002b8c <_ZN6Thread11threadEntryEPv>
    800055bc:	00850513          	addi	a0,a0,8
    800055c0:	ffffc097          	auipc	ra,0xffffc
    800055c4:	d40080e7          	jalr	-704(ra) # 80001300 <_Z13thread_createPP8thread_sPFvPvES2_>
    threadData[0].id = 0;
    800055c8:	000b2023          	sw	zero,0(s6)
    threadData[0].buffer = buffer;
    800055cc:	015b3423          	sd	s5,8(s6)
    threadData[0].sem = waitForAll;
    800055d0:	00009797          	auipc	a5,0x9
    800055d4:	c387b783          	ld	a5,-968(a5) # 8000e208 <_ZL10waitForAll>
    800055d8:	00fb3823          	sd	a5,16(s6)
    producers[0] = new ProducerKeyborad(&threadData[0]);
    800055dc:	02800513          	li	a0,40
    800055e0:	ffffd097          	auipc	ra,0xffffd
    800055e4:	600080e7          	jalr	1536(ra) # 80002be0 <_Znwm>
            body= nullptr;
    800055e8:	00053823          	sd	zero,16(a0)
            arg= nullptr;
    800055ec:	00053c23          	sd	zero,24(a0)
    ProducerKeyborad(thread_data *_td) : Thread(), td(_td) {}
    800055f0:	00007797          	auipc	a5,0x7
    800055f4:	54078793          	addi	a5,a5,1344 # 8000cb30 <_ZTV16ProducerKeyborad+0x10>
    800055f8:	00f53023          	sd	a5,0(a0)
    800055fc:	03653023          	sd	s6,32(a0)
    producers[0] = new ProducerKeyborad(&threadData[0]);
    80005600:	00aa3023          	sd	a0,0(s4)
            if(body== nullptr) return thread_create(&myHandle,&threadEntry, this);
    80005604:	01053583          	ld	a1,16(a0)
    80005608:	00058e63          	beqz	a1,80005624 <_Z20testConsumerProducerv+0x264>
            else return thread_create(&myHandle,body,arg);
    8000560c:	01853603          	ld	a2,24(a0)
    80005610:	00850513          	addi	a0,a0,8
    80005614:	ffffc097          	auipc	ra,0xffffc
    80005618:	cec080e7          	jalr	-788(ra) # 80001300 <_Z13thread_createPP8thread_sPFvPvES2_>
    for (int i = 1; i < threadNum; i++) {
    8000561c:	00100913          	li	s2,1
    80005620:	03c0006f          	j	8000565c <_Z20testConsumerProducerv+0x29c>
            if(body== nullptr) return thread_create(&myHandle,&threadEntry, this);
    80005624:	00050613          	mv	a2,a0
    80005628:	ffffd597          	auipc	a1,0xffffd
    8000562c:	56458593          	addi	a1,a1,1380 # 80002b8c <_ZN6Thread11threadEntryEPv>
    80005630:	00850513          	addi	a0,a0,8
    80005634:	ffffc097          	auipc	ra,0xffffc
    80005638:	ccc080e7          	jalr	-820(ra) # 80001300 <_Z13thread_createPP8thread_sPFvPvES2_>
    8000563c:	fe1ff06f          	j	8000561c <_Z20testConsumerProducerv+0x25c>
    80005640:	00050613          	mv	a2,a0
    80005644:	ffffd597          	auipc	a1,0xffffd
    80005648:	54858593          	addi	a1,a1,1352 # 80002b8c <_ZN6Thread11threadEntryEPv>
    8000564c:	00850513          	addi	a0,a0,8
    80005650:	ffffc097          	auipc	ra,0xffffc
    80005654:	cb0080e7          	jalr	-848(ra) # 80001300 <_Z13thread_createPP8thread_sPFvPvES2_>
    80005658:	0019091b          	addiw	s2,s2,1
    8000565c:	07395a63          	bge	s2,s3,800056d0 <_Z20testConsumerProducerv+0x310>
        threadData[i].id = i;
    80005660:	00191493          	slli	s1,s2,0x1
    80005664:	012484b3          	add	s1,s1,s2
    80005668:	00349493          	slli	s1,s1,0x3
    8000566c:	009b04b3          	add	s1,s6,s1
    80005670:	0124a023          	sw	s2,0(s1)
        threadData[i].buffer = buffer;
    80005674:	0154b423          	sd	s5,8(s1)
        threadData[i].sem = waitForAll;
    80005678:	00009797          	auipc	a5,0x9
    8000567c:	b907b783          	ld	a5,-1136(a5) # 8000e208 <_ZL10waitForAll>
    80005680:	00f4b823          	sd	a5,16(s1)
        producers[i] = new Producer(&threadData[i]);
    80005684:	02800513          	li	a0,40
    80005688:	ffffd097          	auipc	ra,0xffffd
    8000568c:	558080e7          	jalr	1368(ra) # 80002be0 <_Znwm>
            body= nullptr;
    80005690:	00053823          	sd	zero,16(a0)
            arg= nullptr;
    80005694:	00053c23          	sd	zero,24(a0)
    Producer(thread_data *_td) : Thread(), td(_td) {}
    80005698:	00007797          	auipc	a5,0x7
    8000569c:	4c078793          	addi	a5,a5,1216 # 8000cb58 <_ZTV8Producer+0x10>
    800056a0:	00f53023          	sd	a5,0(a0)
    800056a4:	02953023          	sd	s1,32(a0)
        producers[i] = new Producer(&threadData[i]);
    800056a8:	00391793          	slli	a5,s2,0x3
    800056ac:	00fa07b3          	add	a5,s4,a5
    800056b0:	00a7b023          	sd	a0,0(a5)
            if(body== nullptr) return thread_create(&myHandle,&threadEntry, this);
    800056b4:	01053583          	ld	a1,16(a0)
    800056b8:	f80584e3          	beqz	a1,80005640 <_Z20testConsumerProducerv+0x280>
            else return thread_create(&myHandle,body,arg);
    800056bc:	01853603          	ld	a2,24(a0)
    800056c0:	00850513          	addi	a0,a0,8
    800056c4:	ffffc097          	auipc	ra,0xffffc
    800056c8:	c3c080e7          	jalr	-964(ra) # 80001300 <_Z13thread_createPP8thread_sPFvPvES2_>
    800056cc:	f8dff06f          	j	80005658 <_Z20testConsumerProducerv+0x298>
            thread_dispatch();
    800056d0:	ffffc097          	auipc	ra,0xffffc
    800056d4:	cb8080e7          	jalr	-840(ra) # 80001388 <_Z15thread_dispatchv>
    for (int i = 0; i <= threadNum; i++) {
    800056d8:	00000493          	li	s1,0
    800056dc:	0299c063          	blt	s3,s1,800056fc <_Z20testConsumerProducerv+0x33c>
        }
        virtual ~Semaphore (){
            sem_close(myHandle);
        }
        int wait (){
            return sem_wait(myHandle);
    800056e0:	00009797          	auipc	a5,0x9
    800056e4:	b287b783          	ld	a5,-1240(a5) # 8000e208 <_ZL10waitForAll>
    800056e8:	0087b503          	ld	a0,8(a5)
    800056ec:	ffffc097          	auipc	ra,0xffffc
    800056f0:	dd4080e7          	jalr	-556(ra) # 800014c0 <_Z8sem_waitP5sem_s>
    800056f4:	0014849b          	addiw	s1,s1,1
    800056f8:	fe5ff06f          	j	800056dc <_Z20testConsumerProducerv+0x31c>
    delete waitForAll;
    800056fc:	00009517          	auipc	a0,0x9
    80005700:	b0c53503          	ld	a0,-1268(a0) # 8000e208 <_ZL10waitForAll>
    80005704:	00050863          	beqz	a0,80005714 <_Z20testConsumerProducerv+0x354>
    80005708:	00053783          	ld	a5,0(a0)
    8000570c:	0087b783          	ld	a5,8(a5)
    80005710:	000780e7          	jalr	a5
    for (int i = 0; i <= threadNum; i++) {
    80005714:	00000493          	li	s1,0
    80005718:	0080006f          	j	80005720 <_Z20testConsumerProducerv+0x360>
    for (int i = 0; i < threadNum; i++) {
    8000571c:	0014849b          	addiw	s1,s1,1
    80005720:	0334d263          	bge	s1,s3,80005744 <_Z20testConsumerProducerv+0x384>
        delete producers[i];
    80005724:	00349793          	slli	a5,s1,0x3
    80005728:	00fa07b3          	add	a5,s4,a5
    8000572c:	0007b503          	ld	a0,0(a5)
    80005730:	fe0506e3          	beqz	a0,8000571c <_Z20testConsumerProducerv+0x35c>
    80005734:	00053783          	ld	a5,0(a0)
    80005738:	0087b783          	ld	a5,8(a5)
    8000573c:	000780e7          	jalr	a5
    80005740:	fddff06f          	j	8000571c <_Z20testConsumerProducerv+0x35c>
    delete consumer;
    80005744:	000b8a63          	beqz	s7,80005758 <_Z20testConsumerProducerv+0x398>
    80005748:	000bb783          	ld	a5,0(s7)
    8000574c:	0087b783          	ld	a5,8(a5)
    80005750:	000b8513          	mv	a0,s7
    80005754:	000780e7          	jalr	a5
    delete buffer;
    80005758:	000a8e63          	beqz	s5,80005774 <_Z20testConsumerProducerv+0x3b4>
    8000575c:	000a8513          	mv	a0,s5
    80005760:	00001097          	auipc	ra,0x1
    80005764:	4bc080e7          	jalr	1212(ra) # 80006c1c <_ZN9BufferCPPD1Ev>
    80005768:	000a8513          	mv	a0,s5
    8000576c:	ffffd097          	auipc	ra,0xffffd
    80005770:	49c080e7          	jalr	1180(ra) # 80002c08 <_ZdlPv>
    80005774:	000c0113          	mv	sp,s8
}
    80005778:	f9040113          	addi	sp,s0,-112
    8000577c:	06813083          	ld	ra,104(sp)
    80005780:	06013403          	ld	s0,96(sp)
    80005784:	05813483          	ld	s1,88(sp)
    80005788:	05013903          	ld	s2,80(sp)
    8000578c:	04813983          	ld	s3,72(sp)
    80005790:	04013a03          	ld	s4,64(sp)
    80005794:	03813a83          	ld	s5,56(sp)
    80005798:	03013b03          	ld	s6,48(sp)
    8000579c:	02813b83          	ld	s7,40(sp)
    800057a0:	02013c03          	ld	s8,32(sp)
    800057a4:	07010113          	addi	sp,sp,112
    800057a8:	00008067          	ret
    800057ac:	00050493          	mv	s1,a0
    BufferCPP *buffer = new BufferCPP(n);
    800057b0:	000a8513          	mv	a0,s5
    800057b4:	ffffd097          	auipc	ra,0xffffd
    800057b8:	454080e7          	jalr	1108(ra) # 80002c08 <_ZdlPv>
    800057bc:	00048513          	mv	a0,s1
    800057c0:	0000a097          	auipc	ra,0xa
    800057c4:	b38080e7          	jalr	-1224(ra) # 8000f2f8 <_Unwind_Resume>
    800057c8:	00050493          	mv	s1,a0
    waitForAll = new Semaphore(0);
    800057cc:	00090513          	mv	a0,s2
    800057d0:	ffffd097          	auipc	ra,0xffffd
    800057d4:	438080e7          	jalr	1080(ra) # 80002c08 <_ZdlPv>
    800057d8:	00048513          	mv	a0,s1
    800057dc:	0000a097          	auipc	ra,0xa
    800057e0:	b1c080e7          	jalr	-1252(ra) # 8000f2f8 <_Unwind_Resume>

00000000800057e4 <_ZN8ConsumerD1Ev>:
class Consumer : public Thread {
    800057e4:	ff010113          	addi	sp,sp,-16
    800057e8:	00813423          	sd	s0,8(sp)
    800057ec:	01010413          	addi	s0,sp,16
    800057f0:	00813403          	ld	s0,8(sp)
    800057f4:	01010113          	addi	sp,sp,16
    800057f8:	00008067          	ret

00000000800057fc <_ZN8ProducerD1Ev>:
class Producer : public Thread {
    800057fc:	ff010113          	addi	sp,sp,-16
    80005800:	00813423          	sd	s0,8(sp)
    80005804:	01010413          	addi	s0,sp,16
    80005808:	00813403          	ld	s0,8(sp)
    8000580c:	01010113          	addi	sp,sp,16
    80005810:	00008067          	ret

0000000080005814 <_ZN16ProducerKeyboradD1Ev>:
class ProducerKeyborad : public Thread {
    80005814:	ff010113          	addi	sp,sp,-16
    80005818:	00813423          	sd	s0,8(sp)
    8000581c:	01010413          	addi	s0,sp,16
    80005820:	00813403          	ld	s0,8(sp)
    80005824:	01010113          	addi	sp,sp,16
    80005828:	00008067          	ret

000000008000582c <_ZN8ConsumerD0Ev>:
class Consumer : public Thread {
    8000582c:	ff010113          	addi	sp,sp,-16
    80005830:	00113423          	sd	ra,8(sp)
    80005834:	00813023          	sd	s0,0(sp)
    80005838:	01010413          	addi	s0,sp,16
    8000583c:	ffffd097          	auipc	ra,0xffffd
    80005840:	3cc080e7          	jalr	972(ra) # 80002c08 <_ZdlPv>
    80005844:	00813083          	ld	ra,8(sp)
    80005848:	00013403          	ld	s0,0(sp)
    8000584c:	01010113          	addi	sp,sp,16
    80005850:	00008067          	ret

0000000080005854 <_ZN16ProducerKeyboradD0Ev>:
class ProducerKeyborad : public Thread {
    80005854:	ff010113          	addi	sp,sp,-16
    80005858:	00113423          	sd	ra,8(sp)
    8000585c:	00813023          	sd	s0,0(sp)
    80005860:	01010413          	addi	s0,sp,16
    80005864:	ffffd097          	auipc	ra,0xffffd
    80005868:	3a4080e7          	jalr	932(ra) # 80002c08 <_ZdlPv>
    8000586c:	00813083          	ld	ra,8(sp)
    80005870:	00013403          	ld	s0,0(sp)
    80005874:	01010113          	addi	sp,sp,16
    80005878:	00008067          	ret

000000008000587c <_ZN8ProducerD0Ev>:
class Producer : public Thread {
    8000587c:	ff010113          	addi	sp,sp,-16
    80005880:	00113423          	sd	ra,8(sp)
    80005884:	00813023          	sd	s0,0(sp)
    80005888:	01010413          	addi	s0,sp,16
    8000588c:	ffffd097          	auipc	ra,0xffffd
    80005890:	37c080e7          	jalr	892(ra) # 80002c08 <_ZdlPv>
    80005894:	00813083          	ld	ra,8(sp)
    80005898:	00013403          	ld	s0,0(sp)
    8000589c:	01010113          	addi	sp,sp,16
    800058a0:	00008067          	ret

00000000800058a4 <_ZN9SemaphoreD1Ev>:
        virtual ~Semaphore (){
    800058a4:	ff010113          	addi	sp,sp,-16
    800058a8:	00113423          	sd	ra,8(sp)
    800058ac:	00813023          	sd	s0,0(sp)
    800058b0:	01010413          	addi	s0,sp,16
    800058b4:	00007797          	auipc	a5,0x7
    800058b8:	25c78793          	addi	a5,a5,604 # 8000cb10 <_ZTV9Semaphore+0x10>
    800058bc:	00f53023          	sd	a5,0(a0)
            sem_close(myHandle);
    800058c0:	00853503          	ld	a0,8(a0)
    800058c4:	ffffc097          	auipc	ra,0xffffc
    800058c8:	bbc080e7          	jalr	-1092(ra) # 80001480 <_Z9sem_closeP5sem_s>
        }
    800058cc:	00813083          	ld	ra,8(sp)
    800058d0:	00013403          	ld	s0,0(sp)
    800058d4:	01010113          	addi	sp,sp,16
    800058d8:	00008067          	ret

00000000800058dc <_ZN9SemaphoreD0Ev>:
        virtual ~Semaphore (){
    800058dc:	fe010113          	addi	sp,sp,-32
    800058e0:	00113c23          	sd	ra,24(sp)
    800058e4:	00813823          	sd	s0,16(sp)
    800058e8:	00913423          	sd	s1,8(sp)
    800058ec:	02010413          	addi	s0,sp,32
    800058f0:	00050493          	mv	s1,a0
    800058f4:	00007797          	auipc	a5,0x7
    800058f8:	21c78793          	addi	a5,a5,540 # 8000cb10 <_ZTV9Semaphore+0x10>
    800058fc:	00f53023          	sd	a5,0(a0)
            sem_close(myHandle);
    80005900:	00853503          	ld	a0,8(a0)
    80005904:	ffffc097          	auipc	ra,0xffffc
    80005908:	b7c080e7          	jalr	-1156(ra) # 80001480 <_Z9sem_closeP5sem_s>
        }
    8000590c:	00048513          	mv	a0,s1
    80005910:	ffffd097          	auipc	ra,0xffffd
    80005914:	2f8080e7          	jalr	760(ra) # 80002c08 <_ZdlPv>
    80005918:	01813083          	ld	ra,24(sp)
    8000591c:	01013403          	ld	s0,16(sp)
    80005920:	00813483          	ld	s1,8(sp)
    80005924:	02010113          	addi	sp,sp,32
    80005928:	00008067          	ret

000000008000592c <_ZN8Consumer3runEv>:
    void run() override {
    8000592c:	fd010113          	addi	sp,sp,-48
    80005930:	02113423          	sd	ra,40(sp)
    80005934:	02813023          	sd	s0,32(sp)
    80005938:	00913c23          	sd	s1,24(sp)
    8000593c:	01213823          	sd	s2,16(sp)
    80005940:	01313423          	sd	s3,8(sp)
    80005944:	03010413          	addi	s0,sp,48
    80005948:	00050913          	mv	s2,a0
        int i = 0;
    8000594c:	00000993          	li	s3,0
    80005950:	0100006f          	j	80005960 <_ZN8Consumer3runEv+0x34>
        public:
        static char getc (){
            return ::getc();
        }
        static void putc (char c){
            ::putc(c);
    80005954:	00a00513          	li	a0,10
    80005958:	ffffc097          	auipc	ra,0xffffc
    8000595c:	c58080e7          	jalr	-936(ra) # 800015b0 <_Z4putcc>
        while (!threadEnd) {
    80005960:	00009797          	auipc	a5,0x9
    80005964:	8a07a783          	lw	a5,-1888(a5) # 8000e200 <_ZL9threadEnd>
    80005968:	04079a63          	bnez	a5,800059bc <_ZN8Consumer3runEv+0x90>
            int key = td->buffer->get();
    8000596c:	02093783          	ld	a5,32(s2)
    80005970:	0087b503          	ld	a0,8(a5)
    80005974:	00001097          	auipc	ra,0x1
    80005978:	174080e7          	jalr	372(ra) # 80006ae8 <_ZN9BufferCPP3getEv>
            i++;
    8000597c:	0019849b          	addiw	s1,s3,1
    80005980:	0004899b          	sext.w	s3,s1
    80005984:	0ff57513          	andi	a0,a0,255
    80005988:	ffffc097          	auipc	ra,0xffffc
    8000598c:	c28080e7          	jalr	-984(ra) # 800015b0 <_Z4putcc>
            if (i % 80 == 0) {
    80005990:	05000793          	li	a5,80
    80005994:	02f4e4bb          	remw	s1,s1,a5
    80005998:	fc0494e3          	bnez	s1,80005960 <_ZN8Consumer3runEv+0x34>
    8000599c:	fb9ff06f          	j	80005954 <_ZN8Consumer3runEv+0x28>
            int key = td->buffer->get();
    800059a0:	02093783          	ld	a5,32(s2)
    800059a4:	0087b503          	ld	a0,8(a5)
    800059a8:	00001097          	auipc	ra,0x1
    800059ac:	140080e7          	jalr	320(ra) # 80006ae8 <_ZN9BufferCPP3getEv>
    800059b0:	0ff57513          	andi	a0,a0,255
    800059b4:	ffffc097          	auipc	ra,0xffffc
    800059b8:	bfc080e7          	jalr	-1028(ra) # 800015b0 <_Z4putcc>
        while (td->buffer->getCnt() > 0) {
    800059bc:	02093783          	ld	a5,32(s2)
    800059c0:	0087b503          	ld	a0,8(a5)
    800059c4:	00001097          	auipc	ra,0x1
    800059c8:	1c0080e7          	jalr	448(ra) # 80006b84 <_ZN9BufferCPP6getCntEv>
    800059cc:	fca04ae3          	bgtz	a0,800059a0 <_ZN8Consumer3runEv+0x74>
        td->sem->signal();
    800059d0:	02093783          	ld	a5,32(s2)
    800059d4:	0107b783          	ld	a5,16(a5)
            return sem_signal(myHandle);
    800059d8:	0087b503          	ld	a0,8(a5)
    800059dc:	ffffc097          	auipc	ra,0xffffc
    800059e0:	b24080e7          	jalr	-1244(ra) # 80001500 <_Z10sem_signalP5sem_s>
    }
    800059e4:	02813083          	ld	ra,40(sp)
    800059e8:	02013403          	ld	s0,32(sp)
    800059ec:	01813483          	ld	s1,24(sp)
    800059f0:	01013903          	ld	s2,16(sp)
    800059f4:	00813983          	ld	s3,8(sp)
    800059f8:	03010113          	addi	sp,sp,48
    800059fc:	00008067          	ret

0000000080005a00 <_ZN16ProducerKeyborad3runEv>:
    void run() override {
    80005a00:	fe010113          	addi	sp,sp,-32
    80005a04:	00113c23          	sd	ra,24(sp)
    80005a08:	00813823          	sd	s0,16(sp)
    80005a0c:	00913423          	sd	s1,8(sp)
    80005a10:	02010413          	addi	s0,sp,32
    80005a14:	00050493          	mv	s1,a0
        while ((key = getc()) != 13) {
    80005a18:	ffffc097          	auipc	ra,0xffffc
    80005a1c:	b5c080e7          	jalr	-1188(ra) # 80001574 <_Z4getcv>
    80005a20:	0005059b          	sext.w	a1,a0
    80005a24:	00d00793          	li	a5,13
    80005a28:	00f58c63          	beq	a1,a5,80005a40 <_ZN16ProducerKeyborad3runEv+0x40>
            td->buffer->put(key);
    80005a2c:	0204b783          	ld	a5,32(s1)
    80005a30:	0087b503          	ld	a0,8(a5)
    80005a34:	00001097          	auipc	ra,0x1
    80005a38:	014080e7          	jalr	20(ra) # 80006a48 <_ZN9BufferCPP3putEi>
        while ((key = getc()) != 13) {
    80005a3c:	fddff06f          	j	80005a18 <_ZN16ProducerKeyborad3runEv+0x18>
        threadEnd = 1;
    80005a40:	00100793          	li	a5,1
    80005a44:	00008717          	auipc	a4,0x8
    80005a48:	7af72e23          	sw	a5,1980(a4) # 8000e200 <_ZL9threadEnd>
        td->buffer->put('!');
    80005a4c:	0204b783          	ld	a5,32(s1)
    80005a50:	02100593          	li	a1,33
    80005a54:	0087b503          	ld	a0,8(a5)
    80005a58:	00001097          	auipc	ra,0x1
    80005a5c:	ff0080e7          	jalr	-16(ra) # 80006a48 <_ZN9BufferCPP3putEi>
        td->sem->signal();
    80005a60:	0204b783          	ld	a5,32(s1)
    80005a64:	0107b783          	ld	a5,16(a5)
    80005a68:	0087b503          	ld	a0,8(a5)
    80005a6c:	ffffc097          	auipc	ra,0xffffc
    80005a70:	a94080e7          	jalr	-1388(ra) # 80001500 <_Z10sem_signalP5sem_s>
    }
    80005a74:	01813083          	ld	ra,24(sp)
    80005a78:	01013403          	ld	s0,16(sp)
    80005a7c:	00813483          	ld	s1,8(sp)
    80005a80:	02010113          	addi	sp,sp,32
    80005a84:	00008067          	ret

0000000080005a88 <_ZN8Producer3runEv>:
    void run() override {
    80005a88:	fe010113          	addi	sp,sp,-32
    80005a8c:	00113c23          	sd	ra,24(sp)
    80005a90:	00813823          	sd	s0,16(sp)
    80005a94:	00913423          	sd	s1,8(sp)
    80005a98:	01213023          	sd	s2,0(sp)
    80005a9c:	02010413          	addi	s0,sp,32
    80005aa0:	00050493          	mv	s1,a0
        int i = 0;
    80005aa4:	00000913          	li	s2,0
        while (!threadEnd) {
    80005aa8:	00008797          	auipc	a5,0x8
    80005aac:	7587a783          	lw	a5,1880(a5) # 8000e200 <_ZL9threadEnd>
    80005ab0:	04079263          	bnez	a5,80005af4 <_ZN8Producer3runEv+0x6c>
            td->buffer->put(td->id + '0');
    80005ab4:	0204b783          	ld	a5,32(s1)
    80005ab8:	0007a583          	lw	a1,0(a5)
    80005abc:	0305859b          	addiw	a1,a1,48
    80005ac0:	0087b503          	ld	a0,8(a5)
    80005ac4:	00001097          	auipc	ra,0x1
    80005ac8:	f84080e7          	jalr	-124(ra) # 80006a48 <_ZN9BufferCPP3putEi>
            i++;
    80005acc:	0019071b          	addiw	a4,s2,1
    80005ad0:	0007091b          	sext.w	s2,a4
            Thread::sleep((i + td->id) % 5);
    80005ad4:	0204b783          	ld	a5,32(s1)
    80005ad8:	0007a783          	lw	a5,0(a5)
    80005adc:	00e787bb          	addw	a5,a5,a4
            return time_sleep(time);
    80005ae0:	00500513          	li	a0,5
    80005ae4:	02a7e53b          	remw	a0,a5,a0
    80005ae8:	ffffc097          	auipc	ra,0xffffc
    80005aec:	a58080e7          	jalr	-1448(ra) # 80001540 <_Z10time_sleepm>
    80005af0:	fb9ff06f          	j	80005aa8 <_ZN8Producer3runEv+0x20>
        td->sem->signal();
    80005af4:	0204b783          	ld	a5,32(s1)
    80005af8:	0107b783          	ld	a5,16(a5)
            return sem_signal(myHandle);
    80005afc:	0087b503          	ld	a0,8(a5)
    80005b00:	ffffc097          	auipc	ra,0xffffc
    80005b04:	a00080e7          	jalr	-1536(ra) # 80001500 <_Z10sem_signalP5sem_s>
    }
    80005b08:	01813083          	ld	ra,24(sp)
    80005b0c:	01013403          	ld	s0,16(sp)
    80005b10:	00813483          	ld	s1,8(sp)
    80005b14:	00013903          	ld	s2,0(sp)
    80005b18:	02010113          	addi	sp,sp,32
    80005b1c:	00008067          	ret

0000000080005b20 <_ZL9fibonaccim>:
static volatile bool finishedA = false;
static volatile bool finishedB = false;
static volatile bool finishedC = false;
static volatile bool finishedD = false;

static uint64 fibonacci(uint64 n) {
    80005b20:	fe010113          	addi	sp,sp,-32
    80005b24:	00113c23          	sd	ra,24(sp)
    80005b28:	00813823          	sd	s0,16(sp)
    80005b2c:	00913423          	sd	s1,8(sp)
    80005b30:	01213023          	sd	s2,0(sp)
    80005b34:	02010413          	addi	s0,sp,32
    80005b38:	00050493          	mv	s1,a0
    if (n == 0 || n == 1) { return n; }
    80005b3c:	00100793          	li	a5,1
    80005b40:	02a7f863          	bgeu	a5,a0,80005b70 <_ZL9fibonaccim+0x50>
    if (n % 10 == 0) { thread_dispatch(); }
    80005b44:	00a00793          	li	a5,10
    80005b48:	02f577b3          	remu	a5,a0,a5
    80005b4c:	02078e63          	beqz	a5,80005b88 <_ZL9fibonaccim+0x68>
    return fibonacci(n - 1) + fibonacci(n - 2);
    80005b50:	fff48513          	addi	a0,s1,-1
    80005b54:	00000097          	auipc	ra,0x0
    80005b58:	fcc080e7          	jalr	-52(ra) # 80005b20 <_ZL9fibonaccim>
    80005b5c:	00050913          	mv	s2,a0
    80005b60:	ffe48513          	addi	a0,s1,-2
    80005b64:	00000097          	auipc	ra,0x0
    80005b68:	fbc080e7          	jalr	-68(ra) # 80005b20 <_ZL9fibonaccim>
    80005b6c:	00a90533          	add	a0,s2,a0
}
    80005b70:	01813083          	ld	ra,24(sp)
    80005b74:	01013403          	ld	s0,16(sp)
    80005b78:	00813483          	ld	s1,8(sp)
    80005b7c:	00013903          	ld	s2,0(sp)
    80005b80:	02010113          	addi	sp,sp,32
    80005b84:	00008067          	ret
    if (n % 10 == 0) { thread_dispatch(); }
    80005b88:	ffffc097          	auipc	ra,0xffffc
    80005b8c:	800080e7          	jalr	-2048(ra) # 80001388 <_Z15thread_dispatchv>
    80005b90:	fc1ff06f          	j	80005b50 <_ZL9fibonaccim+0x30>

0000000080005b94 <_ZL11workerBodyDPv>:
    printString("A finished!\n");
    finishedC = true;
    thread_dispatch();
}

static void workerBodyD(void* arg) {
    80005b94:	fe010113          	addi	sp,sp,-32
    80005b98:	00113c23          	sd	ra,24(sp)
    80005b9c:	00813823          	sd	s0,16(sp)
    80005ba0:	00913423          	sd	s1,8(sp)
    80005ba4:	01213023          	sd	s2,0(sp)
    80005ba8:	02010413          	addi	s0,sp,32
    uint8 i = 10;
    80005bac:	00a00493          	li	s1,10
    80005bb0:	0400006f          	j	80005bf0 <_ZL11workerBodyDPv+0x5c>
    for (; i < 13; i++) {
        printString("D: i="); printInt(i); printString("\n");
    80005bb4:	00005517          	auipc	a0,0x5
    80005bb8:	99450513          	addi	a0,a0,-1644 # 8000a548 <CONSOLE_STATUS+0x538>
    80005bbc:	ffffc097          	auipc	ra,0xffffc
    80005bc0:	2f0080e7          	jalr	752(ra) # 80001eac <_Z11printStringPKc>
    80005bc4:	00000613          	li	a2,0
    80005bc8:	00a00593          	li	a1,10
    80005bcc:	00048513          	mv	a0,s1
    80005bd0:	ffffc097          	auipc	ra,0xffffc
    80005bd4:	48c080e7          	jalr	1164(ra) # 8000205c <_Z8printIntiii>
    80005bd8:	00005517          	auipc	a0,0x5
    80005bdc:	b6050513          	addi	a0,a0,-1184 # 8000a738 <CONSOLE_STATUS+0x728>
    80005be0:	ffffc097          	auipc	ra,0xffffc
    80005be4:	2cc080e7          	jalr	716(ra) # 80001eac <_Z11printStringPKc>
    for (; i < 13; i++) {
    80005be8:	0014849b          	addiw	s1,s1,1
    80005bec:	0ff4f493          	andi	s1,s1,255
    80005bf0:	00c00793          	li	a5,12
    80005bf4:	fc97f0e3          	bgeu	a5,s1,80005bb4 <_ZL11workerBodyDPv+0x20>
    }

    printString("D: dispatch\n");
    80005bf8:	00005517          	auipc	a0,0x5
    80005bfc:	95850513          	addi	a0,a0,-1704 # 8000a550 <CONSOLE_STATUS+0x540>
    80005c00:	ffffc097          	auipc	ra,0xffffc
    80005c04:	2ac080e7          	jalr	684(ra) # 80001eac <_Z11printStringPKc>
    __asm__ ("li t1, 5");
    80005c08:	00500313          	li	t1,5
    thread_dispatch();
    80005c0c:	ffffb097          	auipc	ra,0xffffb
    80005c10:	77c080e7          	jalr	1916(ra) # 80001388 <_Z15thread_dispatchv>

    uint64 result = fibonacci(16);
    80005c14:	01000513          	li	a0,16
    80005c18:	00000097          	auipc	ra,0x0
    80005c1c:	f08080e7          	jalr	-248(ra) # 80005b20 <_ZL9fibonaccim>
    80005c20:	00050913          	mv	s2,a0
    printString("D: fibonaci="); printInt(result); printString("\n");
    80005c24:	00005517          	auipc	a0,0x5
    80005c28:	93c50513          	addi	a0,a0,-1732 # 8000a560 <CONSOLE_STATUS+0x550>
    80005c2c:	ffffc097          	auipc	ra,0xffffc
    80005c30:	280080e7          	jalr	640(ra) # 80001eac <_Z11printStringPKc>
    80005c34:	00000613          	li	a2,0
    80005c38:	00a00593          	li	a1,10
    80005c3c:	0009051b          	sext.w	a0,s2
    80005c40:	ffffc097          	auipc	ra,0xffffc
    80005c44:	41c080e7          	jalr	1052(ra) # 8000205c <_Z8printIntiii>
    80005c48:	00005517          	auipc	a0,0x5
    80005c4c:	af050513          	addi	a0,a0,-1296 # 8000a738 <CONSOLE_STATUS+0x728>
    80005c50:	ffffc097          	auipc	ra,0xffffc
    80005c54:	25c080e7          	jalr	604(ra) # 80001eac <_Z11printStringPKc>
    80005c58:	0400006f          	j	80005c98 <_ZL11workerBodyDPv+0x104>

    for (; i < 16; i++) {
        printString("D: i="); printInt(i); printString("\n");
    80005c5c:	00005517          	auipc	a0,0x5
    80005c60:	8ec50513          	addi	a0,a0,-1812 # 8000a548 <CONSOLE_STATUS+0x538>
    80005c64:	ffffc097          	auipc	ra,0xffffc
    80005c68:	248080e7          	jalr	584(ra) # 80001eac <_Z11printStringPKc>
    80005c6c:	00000613          	li	a2,0
    80005c70:	00a00593          	li	a1,10
    80005c74:	00048513          	mv	a0,s1
    80005c78:	ffffc097          	auipc	ra,0xffffc
    80005c7c:	3e4080e7          	jalr	996(ra) # 8000205c <_Z8printIntiii>
    80005c80:	00005517          	auipc	a0,0x5
    80005c84:	ab850513          	addi	a0,a0,-1352 # 8000a738 <CONSOLE_STATUS+0x728>
    80005c88:	ffffc097          	auipc	ra,0xffffc
    80005c8c:	224080e7          	jalr	548(ra) # 80001eac <_Z11printStringPKc>
    for (; i < 16; i++) {
    80005c90:	0014849b          	addiw	s1,s1,1
    80005c94:	0ff4f493          	andi	s1,s1,255
    80005c98:	00f00793          	li	a5,15
    80005c9c:	fc97f0e3          	bgeu	a5,s1,80005c5c <_ZL11workerBodyDPv+0xc8>
    }

    printString("D finished!\n");
    80005ca0:	00005517          	auipc	a0,0x5
    80005ca4:	8d050513          	addi	a0,a0,-1840 # 8000a570 <CONSOLE_STATUS+0x560>
    80005ca8:	ffffc097          	auipc	ra,0xffffc
    80005cac:	204080e7          	jalr	516(ra) # 80001eac <_Z11printStringPKc>
    finishedD = true;
    80005cb0:	00100793          	li	a5,1
    80005cb4:	00008717          	auipc	a4,0x8
    80005cb8:	54f70e23          	sb	a5,1372(a4) # 8000e210 <_ZL9finishedD>
    thread_dispatch();
    80005cbc:	ffffb097          	auipc	ra,0xffffb
    80005cc0:	6cc080e7          	jalr	1740(ra) # 80001388 <_Z15thread_dispatchv>
}
    80005cc4:	01813083          	ld	ra,24(sp)
    80005cc8:	01013403          	ld	s0,16(sp)
    80005ccc:	00813483          	ld	s1,8(sp)
    80005cd0:	00013903          	ld	s2,0(sp)
    80005cd4:	02010113          	addi	sp,sp,32
    80005cd8:	00008067          	ret

0000000080005cdc <_ZL11workerBodyCPv>:
static void workerBodyC(void* arg) {
    80005cdc:	fe010113          	addi	sp,sp,-32
    80005ce0:	00113c23          	sd	ra,24(sp)
    80005ce4:	00813823          	sd	s0,16(sp)
    80005ce8:	00913423          	sd	s1,8(sp)
    80005cec:	01213023          	sd	s2,0(sp)
    80005cf0:	02010413          	addi	s0,sp,32
    uint8 i = 0;
    80005cf4:	00000493          	li	s1,0
    80005cf8:	0400006f          	j	80005d38 <_ZL11workerBodyCPv+0x5c>
        printString("C: i="); printInt(i); printString("\n");
    80005cfc:	00005517          	auipc	a0,0x5
    80005d00:	81c50513          	addi	a0,a0,-2020 # 8000a518 <CONSOLE_STATUS+0x508>
    80005d04:	ffffc097          	auipc	ra,0xffffc
    80005d08:	1a8080e7          	jalr	424(ra) # 80001eac <_Z11printStringPKc>
    80005d0c:	00000613          	li	a2,0
    80005d10:	00a00593          	li	a1,10
    80005d14:	00048513          	mv	a0,s1
    80005d18:	ffffc097          	auipc	ra,0xffffc
    80005d1c:	344080e7          	jalr	836(ra) # 8000205c <_Z8printIntiii>
    80005d20:	00005517          	auipc	a0,0x5
    80005d24:	a1850513          	addi	a0,a0,-1512 # 8000a738 <CONSOLE_STATUS+0x728>
    80005d28:	ffffc097          	auipc	ra,0xffffc
    80005d2c:	184080e7          	jalr	388(ra) # 80001eac <_Z11printStringPKc>
    for (; i < 3; i++) {
    80005d30:	0014849b          	addiw	s1,s1,1
    80005d34:	0ff4f493          	andi	s1,s1,255
    80005d38:	00200793          	li	a5,2
    80005d3c:	fc97f0e3          	bgeu	a5,s1,80005cfc <_ZL11workerBodyCPv+0x20>
    printString("C: dispatch\n");
    80005d40:	00004517          	auipc	a0,0x4
    80005d44:	7e050513          	addi	a0,a0,2016 # 8000a520 <CONSOLE_STATUS+0x510>
    80005d48:	ffffc097          	auipc	ra,0xffffc
    80005d4c:	164080e7          	jalr	356(ra) # 80001eac <_Z11printStringPKc>
    __asm__ ("li t1, 7");
    80005d50:	00700313          	li	t1,7
    thread_dispatch();
    80005d54:	ffffb097          	auipc	ra,0xffffb
    80005d58:	634080e7          	jalr	1588(ra) # 80001388 <_Z15thread_dispatchv>
    __asm__ ("mv %[t1], t1" : [t1] "=r"(t1));
    80005d5c:	00030913          	mv	s2,t1
    printString("C: t1="); printInt(t1); printString("\n");
    80005d60:	00004517          	auipc	a0,0x4
    80005d64:	7d050513          	addi	a0,a0,2000 # 8000a530 <CONSOLE_STATUS+0x520>
    80005d68:	ffffc097          	auipc	ra,0xffffc
    80005d6c:	144080e7          	jalr	324(ra) # 80001eac <_Z11printStringPKc>
    80005d70:	00000613          	li	a2,0
    80005d74:	00a00593          	li	a1,10
    80005d78:	0009051b          	sext.w	a0,s2
    80005d7c:	ffffc097          	auipc	ra,0xffffc
    80005d80:	2e0080e7          	jalr	736(ra) # 8000205c <_Z8printIntiii>
    80005d84:	00005517          	auipc	a0,0x5
    80005d88:	9b450513          	addi	a0,a0,-1612 # 8000a738 <CONSOLE_STATUS+0x728>
    80005d8c:	ffffc097          	auipc	ra,0xffffc
    80005d90:	120080e7          	jalr	288(ra) # 80001eac <_Z11printStringPKc>
    uint64 result = fibonacci(12);
    80005d94:	00c00513          	li	a0,12
    80005d98:	00000097          	auipc	ra,0x0
    80005d9c:	d88080e7          	jalr	-632(ra) # 80005b20 <_ZL9fibonaccim>
    80005da0:	00050913          	mv	s2,a0
    printString("C: fibonaci="); printInt(result); printString("\n");
    80005da4:	00004517          	auipc	a0,0x4
    80005da8:	79450513          	addi	a0,a0,1940 # 8000a538 <CONSOLE_STATUS+0x528>
    80005dac:	ffffc097          	auipc	ra,0xffffc
    80005db0:	100080e7          	jalr	256(ra) # 80001eac <_Z11printStringPKc>
    80005db4:	00000613          	li	a2,0
    80005db8:	00a00593          	li	a1,10
    80005dbc:	0009051b          	sext.w	a0,s2
    80005dc0:	ffffc097          	auipc	ra,0xffffc
    80005dc4:	29c080e7          	jalr	668(ra) # 8000205c <_Z8printIntiii>
    80005dc8:	00005517          	auipc	a0,0x5
    80005dcc:	97050513          	addi	a0,a0,-1680 # 8000a738 <CONSOLE_STATUS+0x728>
    80005dd0:	ffffc097          	auipc	ra,0xffffc
    80005dd4:	0dc080e7          	jalr	220(ra) # 80001eac <_Z11printStringPKc>
    80005dd8:	0400006f          	j	80005e18 <_ZL11workerBodyCPv+0x13c>
        printString("C: i="); printInt(i); printString("\n");
    80005ddc:	00004517          	auipc	a0,0x4
    80005de0:	73c50513          	addi	a0,a0,1852 # 8000a518 <CONSOLE_STATUS+0x508>
    80005de4:	ffffc097          	auipc	ra,0xffffc
    80005de8:	0c8080e7          	jalr	200(ra) # 80001eac <_Z11printStringPKc>
    80005dec:	00000613          	li	a2,0
    80005df0:	00a00593          	li	a1,10
    80005df4:	00048513          	mv	a0,s1
    80005df8:	ffffc097          	auipc	ra,0xffffc
    80005dfc:	264080e7          	jalr	612(ra) # 8000205c <_Z8printIntiii>
    80005e00:	00005517          	auipc	a0,0x5
    80005e04:	93850513          	addi	a0,a0,-1736 # 8000a738 <CONSOLE_STATUS+0x728>
    80005e08:	ffffc097          	auipc	ra,0xffffc
    80005e0c:	0a4080e7          	jalr	164(ra) # 80001eac <_Z11printStringPKc>
    for (; i < 6; i++) {
    80005e10:	0014849b          	addiw	s1,s1,1
    80005e14:	0ff4f493          	andi	s1,s1,255
    80005e18:	00500793          	li	a5,5
    80005e1c:	fc97f0e3          	bgeu	a5,s1,80005ddc <_ZL11workerBodyCPv+0x100>
    printString("A finished!\n");
    80005e20:	00004517          	auipc	a0,0x4
    80005e24:	6d050513          	addi	a0,a0,1744 # 8000a4f0 <CONSOLE_STATUS+0x4e0>
    80005e28:	ffffc097          	auipc	ra,0xffffc
    80005e2c:	084080e7          	jalr	132(ra) # 80001eac <_Z11printStringPKc>
    finishedC = true;
    80005e30:	00100793          	li	a5,1
    80005e34:	00008717          	auipc	a4,0x8
    80005e38:	3cf70ea3          	sb	a5,989(a4) # 8000e211 <_ZL9finishedC>
    thread_dispatch();
    80005e3c:	ffffb097          	auipc	ra,0xffffb
    80005e40:	54c080e7          	jalr	1356(ra) # 80001388 <_Z15thread_dispatchv>
}
    80005e44:	01813083          	ld	ra,24(sp)
    80005e48:	01013403          	ld	s0,16(sp)
    80005e4c:	00813483          	ld	s1,8(sp)
    80005e50:	00013903          	ld	s2,0(sp)
    80005e54:	02010113          	addi	sp,sp,32
    80005e58:	00008067          	ret

0000000080005e5c <_ZL11workerBodyBPv>:
static void workerBodyB(void* arg) {
    80005e5c:	fe010113          	addi	sp,sp,-32
    80005e60:	00113c23          	sd	ra,24(sp)
    80005e64:	00813823          	sd	s0,16(sp)
    80005e68:	00913423          	sd	s1,8(sp)
    80005e6c:	01213023          	sd	s2,0(sp)
    80005e70:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 16; i++) {
    80005e74:	00000913          	li	s2,0
    80005e78:	0380006f          	j	80005eb0 <_ZL11workerBodyBPv+0x54>
            thread_dispatch();
    80005e7c:	ffffb097          	auipc	ra,0xffffb
    80005e80:	50c080e7          	jalr	1292(ra) # 80001388 <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++) {
    80005e84:	00148493          	addi	s1,s1,1
    80005e88:	000027b7          	lui	a5,0x2
    80005e8c:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    80005e90:	0097ee63          	bltu	a5,s1,80005eac <_ZL11workerBodyBPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    80005e94:	00000713          	li	a4,0
    80005e98:	000077b7          	lui	a5,0x7
    80005e9c:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    80005ea0:	fce7eee3          	bltu	a5,a4,80005e7c <_ZL11workerBodyBPv+0x20>
    80005ea4:	00170713          	addi	a4,a4,1
    80005ea8:	ff1ff06f          	j	80005e98 <_ZL11workerBodyBPv+0x3c>
    for (uint64 i = 0; i < 16; i++) {
    80005eac:	00190913          	addi	s2,s2,1
    80005eb0:	00f00793          	li	a5,15
    80005eb4:	0527e063          	bltu	a5,s2,80005ef4 <_ZL11workerBodyBPv+0x98>
        printString("B: i="); printInt(i); printString("\n");
    80005eb8:	00004517          	auipc	a0,0x4
    80005ebc:	64850513          	addi	a0,a0,1608 # 8000a500 <CONSOLE_STATUS+0x4f0>
    80005ec0:	ffffc097          	auipc	ra,0xffffc
    80005ec4:	fec080e7          	jalr	-20(ra) # 80001eac <_Z11printStringPKc>
    80005ec8:	00000613          	li	a2,0
    80005ecc:	00a00593          	li	a1,10
    80005ed0:	0009051b          	sext.w	a0,s2
    80005ed4:	ffffc097          	auipc	ra,0xffffc
    80005ed8:	188080e7          	jalr	392(ra) # 8000205c <_Z8printIntiii>
    80005edc:	00005517          	auipc	a0,0x5
    80005ee0:	85c50513          	addi	a0,a0,-1956 # 8000a738 <CONSOLE_STATUS+0x728>
    80005ee4:	ffffc097          	auipc	ra,0xffffc
    80005ee8:	fc8080e7          	jalr	-56(ra) # 80001eac <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    80005eec:	00000493          	li	s1,0
    80005ef0:	f99ff06f          	j	80005e88 <_ZL11workerBodyBPv+0x2c>
    printString("B finished!\n");
    80005ef4:	00004517          	auipc	a0,0x4
    80005ef8:	61450513          	addi	a0,a0,1556 # 8000a508 <CONSOLE_STATUS+0x4f8>
    80005efc:	ffffc097          	auipc	ra,0xffffc
    80005f00:	fb0080e7          	jalr	-80(ra) # 80001eac <_Z11printStringPKc>
    finishedB = true;
    80005f04:	00100793          	li	a5,1
    80005f08:	00008717          	auipc	a4,0x8
    80005f0c:	30f70523          	sb	a5,778(a4) # 8000e212 <_ZL9finishedB>
    thread_dispatch();
    80005f10:	ffffb097          	auipc	ra,0xffffb
    80005f14:	478080e7          	jalr	1144(ra) # 80001388 <_Z15thread_dispatchv>
}
    80005f18:	01813083          	ld	ra,24(sp)
    80005f1c:	01013403          	ld	s0,16(sp)
    80005f20:	00813483          	ld	s1,8(sp)
    80005f24:	00013903          	ld	s2,0(sp)
    80005f28:	02010113          	addi	sp,sp,32
    80005f2c:	00008067          	ret

0000000080005f30 <_ZL11workerBodyAPv>:
static void workerBodyA(void* arg) {
    80005f30:	fe010113          	addi	sp,sp,-32
    80005f34:	00113c23          	sd	ra,24(sp)
    80005f38:	00813823          	sd	s0,16(sp)
    80005f3c:	00913423          	sd	s1,8(sp)
    80005f40:	01213023          	sd	s2,0(sp)
    80005f44:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 10; i++) {
    80005f48:	00000913          	li	s2,0
    80005f4c:	0380006f          	j	80005f84 <_ZL11workerBodyAPv+0x54>
            thread_dispatch();
    80005f50:	ffffb097          	auipc	ra,0xffffb
    80005f54:	438080e7          	jalr	1080(ra) # 80001388 <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++) {
    80005f58:	00148493          	addi	s1,s1,1
    80005f5c:	000027b7          	lui	a5,0x2
    80005f60:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    80005f64:	0097ee63          	bltu	a5,s1,80005f80 <_ZL11workerBodyAPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    80005f68:	00000713          	li	a4,0
    80005f6c:	000077b7          	lui	a5,0x7
    80005f70:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    80005f74:	fce7eee3          	bltu	a5,a4,80005f50 <_ZL11workerBodyAPv+0x20>
    80005f78:	00170713          	addi	a4,a4,1
    80005f7c:	ff1ff06f          	j	80005f6c <_ZL11workerBodyAPv+0x3c>
    for (uint64 i = 0; i < 10; i++) {
    80005f80:	00190913          	addi	s2,s2,1
    80005f84:	00900793          	li	a5,9
    80005f88:	0527e063          	bltu	a5,s2,80005fc8 <_ZL11workerBodyAPv+0x98>
        printString("A: i="); printInt(i); printString("\n");
    80005f8c:	00004517          	auipc	a0,0x4
    80005f90:	55c50513          	addi	a0,a0,1372 # 8000a4e8 <CONSOLE_STATUS+0x4d8>
    80005f94:	ffffc097          	auipc	ra,0xffffc
    80005f98:	f18080e7          	jalr	-232(ra) # 80001eac <_Z11printStringPKc>
    80005f9c:	00000613          	li	a2,0
    80005fa0:	00a00593          	li	a1,10
    80005fa4:	0009051b          	sext.w	a0,s2
    80005fa8:	ffffc097          	auipc	ra,0xffffc
    80005fac:	0b4080e7          	jalr	180(ra) # 8000205c <_Z8printIntiii>
    80005fb0:	00004517          	auipc	a0,0x4
    80005fb4:	78850513          	addi	a0,a0,1928 # 8000a738 <CONSOLE_STATUS+0x728>
    80005fb8:	ffffc097          	auipc	ra,0xffffc
    80005fbc:	ef4080e7          	jalr	-268(ra) # 80001eac <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    80005fc0:	00000493          	li	s1,0
    80005fc4:	f99ff06f          	j	80005f5c <_ZL11workerBodyAPv+0x2c>
    printString("A finished!\n");
    80005fc8:	00004517          	auipc	a0,0x4
    80005fcc:	52850513          	addi	a0,a0,1320 # 8000a4f0 <CONSOLE_STATUS+0x4e0>
    80005fd0:	ffffc097          	auipc	ra,0xffffc
    80005fd4:	edc080e7          	jalr	-292(ra) # 80001eac <_Z11printStringPKc>
    finishedA = true;
    80005fd8:	00100793          	li	a5,1
    80005fdc:	00008717          	auipc	a4,0x8
    80005fe0:	22f70ba3          	sb	a5,567(a4) # 8000e213 <_ZL9finishedA>
}
    80005fe4:	01813083          	ld	ra,24(sp)
    80005fe8:	01013403          	ld	s0,16(sp)
    80005fec:	00813483          	ld	s1,8(sp)
    80005ff0:	00013903          	ld	s2,0(sp)
    80005ff4:	02010113          	addi	sp,sp,32
    80005ff8:	00008067          	ret

0000000080005ffc <_Z18Threads_C_API_testv>:


void Threads_C_API_test() {
    80005ffc:	fd010113          	addi	sp,sp,-48
    80006000:	02113423          	sd	ra,40(sp)
    80006004:	02813023          	sd	s0,32(sp)
    80006008:	03010413          	addi	s0,sp,48
    thread_t threads[4];
    thread_create(&threads[0], workerBodyA, nullptr);
    8000600c:	00000613          	li	a2,0
    80006010:	00000597          	auipc	a1,0x0
    80006014:	f2058593          	addi	a1,a1,-224 # 80005f30 <_ZL11workerBodyAPv>
    80006018:	fd040513          	addi	a0,s0,-48
    8000601c:	ffffb097          	auipc	ra,0xffffb
    80006020:	2e4080e7          	jalr	740(ra) # 80001300 <_Z13thread_createPP8thread_sPFvPvES2_>
    printString("ThreadA created\n");
    80006024:	00004517          	auipc	a0,0x4
    80006028:	55c50513          	addi	a0,a0,1372 # 8000a580 <CONSOLE_STATUS+0x570>
    8000602c:	ffffc097          	auipc	ra,0xffffc
    80006030:	e80080e7          	jalr	-384(ra) # 80001eac <_Z11printStringPKc>

    thread_create(&threads[1], workerBodyB, nullptr);
    80006034:	00000613          	li	a2,0
    80006038:	00000597          	auipc	a1,0x0
    8000603c:	e2458593          	addi	a1,a1,-476 # 80005e5c <_ZL11workerBodyBPv>
    80006040:	fd840513          	addi	a0,s0,-40
    80006044:	ffffb097          	auipc	ra,0xffffb
    80006048:	2bc080e7          	jalr	700(ra) # 80001300 <_Z13thread_createPP8thread_sPFvPvES2_>
    printString("ThreadB created\n");
    8000604c:	00004517          	auipc	a0,0x4
    80006050:	54c50513          	addi	a0,a0,1356 # 8000a598 <CONSOLE_STATUS+0x588>
    80006054:	ffffc097          	auipc	ra,0xffffc
    80006058:	e58080e7          	jalr	-424(ra) # 80001eac <_Z11printStringPKc>

    thread_create(&threads[2], workerBodyC, nullptr);
    8000605c:	00000613          	li	a2,0
    80006060:	00000597          	auipc	a1,0x0
    80006064:	c7c58593          	addi	a1,a1,-900 # 80005cdc <_ZL11workerBodyCPv>
    80006068:	fe040513          	addi	a0,s0,-32
    8000606c:	ffffb097          	auipc	ra,0xffffb
    80006070:	294080e7          	jalr	660(ra) # 80001300 <_Z13thread_createPP8thread_sPFvPvES2_>
    printString("ThreadC created\n");
    80006074:	00004517          	auipc	a0,0x4
    80006078:	53c50513          	addi	a0,a0,1340 # 8000a5b0 <CONSOLE_STATUS+0x5a0>
    8000607c:	ffffc097          	auipc	ra,0xffffc
    80006080:	e30080e7          	jalr	-464(ra) # 80001eac <_Z11printStringPKc>

    thread_create(&threads[3], workerBodyD, nullptr);
    80006084:	00000613          	li	a2,0
    80006088:	00000597          	auipc	a1,0x0
    8000608c:	b0c58593          	addi	a1,a1,-1268 # 80005b94 <_ZL11workerBodyDPv>
    80006090:	fe840513          	addi	a0,s0,-24
    80006094:	ffffb097          	auipc	ra,0xffffb
    80006098:	26c080e7          	jalr	620(ra) # 80001300 <_Z13thread_createPP8thread_sPFvPvES2_>
    printString("ThreadD created\n");
    8000609c:	00004517          	auipc	a0,0x4
    800060a0:	52c50513          	addi	a0,a0,1324 # 8000a5c8 <CONSOLE_STATUS+0x5b8>
    800060a4:	ffffc097          	auipc	ra,0xffffc
    800060a8:	e08080e7          	jalr	-504(ra) # 80001eac <_Z11printStringPKc>
    800060ac:	00c0006f          	j	800060b8 <_Z18Threads_C_API_testv+0xbc>

    while (!(finishedA && finishedB && finishedC && finishedD)) {
        thread_dispatch();
    800060b0:	ffffb097          	auipc	ra,0xffffb
    800060b4:	2d8080e7          	jalr	728(ra) # 80001388 <_Z15thread_dispatchv>
    while (!(finishedA && finishedB && finishedC && finishedD)) {
    800060b8:	00008797          	auipc	a5,0x8
    800060bc:	15b7c783          	lbu	a5,347(a5) # 8000e213 <_ZL9finishedA>
    800060c0:	fe0788e3          	beqz	a5,800060b0 <_Z18Threads_C_API_testv+0xb4>
    800060c4:	00008797          	auipc	a5,0x8
    800060c8:	14e7c783          	lbu	a5,334(a5) # 8000e212 <_ZL9finishedB>
    800060cc:	fe0782e3          	beqz	a5,800060b0 <_Z18Threads_C_API_testv+0xb4>
    800060d0:	00008797          	auipc	a5,0x8
    800060d4:	1417c783          	lbu	a5,321(a5) # 8000e211 <_ZL9finishedC>
    800060d8:	fc078ce3          	beqz	a5,800060b0 <_Z18Threads_C_API_testv+0xb4>
    800060dc:	00008797          	auipc	a5,0x8
    800060e0:	1347c783          	lbu	a5,308(a5) # 8000e210 <_ZL9finishedD>
    800060e4:	fc0786e3          	beqz	a5,800060b0 <_Z18Threads_C_API_testv+0xb4>
    }

}
    800060e8:	02813083          	ld	ra,40(sp)
    800060ec:	02013403          	ld	s0,32(sp)
    800060f0:	03010113          	addi	sp,sp,48
    800060f4:	00008067          	ret

00000000800060f8 <_ZN16ProducerKeyboard16producerKeyboardEPv>:
    void run() override {
        producerKeyboard(td);
    }
};

void ProducerKeyboard::producerKeyboard(void *arg) {
    800060f8:	fd010113          	addi	sp,sp,-48
    800060fc:	02113423          	sd	ra,40(sp)
    80006100:	02813023          	sd	s0,32(sp)
    80006104:	00913c23          	sd	s1,24(sp)
    80006108:	01213823          	sd	s2,16(sp)
    8000610c:	01313423          	sd	s3,8(sp)
    80006110:	03010413          	addi	s0,sp,48
    80006114:	00050993          	mv	s3,a0
    80006118:	00058493          	mv	s1,a1
    struct thread_data *data = (struct thread_data *) arg;

    int key;
    int i = 0;
    8000611c:	00000913          	li	s2,0
    80006120:	00c0006f          	j	8000612c <_ZN16ProducerKeyboard16producerKeyboardEPv+0x34>
            thread_dispatch();
    80006124:	ffffb097          	auipc	ra,0xffffb
    80006128:	264080e7          	jalr	612(ra) # 80001388 <_Z15thread_dispatchv>
    while ((key = getc()) != 13) {
    8000612c:	ffffb097          	auipc	ra,0xffffb
    80006130:	448080e7          	jalr	1096(ra) # 80001574 <_Z4getcv>
    80006134:	0005059b          	sext.w	a1,a0
    80006138:	00d00793          	li	a5,13
    8000613c:	02f58a63          	beq	a1,a5,80006170 <_ZN16ProducerKeyboard16producerKeyboardEPv+0x78>
        data->buffer->put(key);
    80006140:	0084b503          	ld	a0,8(s1)
    80006144:	00001097          	auipc	ra,0x1
    80006148:	904080e7          	jalr	-1788(ra) # 80006a48 <_ZN9BufferCPP3putEi>
        i++;
    8000614c:	0019071b          	addiw	a4,s2,1
    80006150:	0007091b          	sext.w	s2,a4

        if (i % (10 * data->id) == 0) {
    80006154:	0004a683          	lw	a3,0(s1)
    80006158:	0026979b          	slliw	a5,a3,0x2
    8000615c:	00d787bb          	addw	a5,a5,a3
    80006160:	0017979b          	slliw	a5,a5,0x1
    80006164:	02f767bb          	remw	a5,a4,a5
    80006168:	fc0792e3          	bnez	a5,8000612c <_ZN16ProducerKeyboard16producerKeyboardEPv+0x34>
    8000616c:	fb9ff06f          	j	80006124 <_ZN16ProducerKeyboard16producerKeyboardEPv+0x2c>
            Thread::dispatch();
        }
    }

    threadEnd = 1;
    80006170:	00100793          	li	a5,1
    80006174:	00008717          	auipc	a4,0x8
    80006178:	0af72223          	sw	a5,164(a4) # 8000e218 <_ZL9threadEnd>
    td->buffer->put('!');
    8000617c:	0209b783          	ld	a5,32(s3)
    80006180:	02100593          	li	a1,33
    80006184:	0087b503          	ld	a0,8(a5)
    80006188:	00001097          	auipc	ra,0x1
    8000618c:	8c0080e7          	jalr	-1856(ra) # 80006a48 <_ZN9BufferCPP3putEi>

    data->wait->signal();
    80006190:	0104b783          	ld	a5,16(s1)
            return sem_signal(myHandle);
    80006194:	0087b503          	ld	a0,8(a5)
    80006198:	ffffb097          	auipc	ra,0xffffb
    8000619c:	368080e7          	jalr	872(ra) # 80001500 <_Z10sem_signalP5sem_s>
}
    800061a0:	02813083          	ld	ra,40(sp)
    800061a4:	02013403          	ld	s0,32(sp)
    800061a8:	01813483          	ld	s1,24(sp)
    800061ac:	01013903          	ld	s2,16(sp)
    800061b0:	00813983          	ld	s3,8(sp)
    800061b4:	03010113          	addi	sp,sp,48
    800061b8:	00008067          	ret

00000000800061bc <_ZN12ProducerSync8producerEPv>:
    void run() override {
        producer(td);
    }
};

void ProducerSync::producer(void *arg) {
    800061bc:	fe010113          	addi	sp,sp,-32
    800061c0:	00113c23          	sd	ra,24(sp)
    800061c4:	00813823          	sd	s0,16(sp)
    800061c8:	00913423          	sd	s1,8(sp)
    800061cc:	01213023          	sd	s2,0(sp)
    800061d0:	02010413          	addi	s0,sp,32
    800061d4:	00058493          	mv	s1,a1
    struct thread_data *data = (struct thread_data *) arg;

    int i = 0;
    800061d8:	00000913          	li	s2,0
    800061dc:	00c0006f          	j	800061e8 <_ZN12ProducerSync8producerEPv+0x2c>
            thread_dispatch();
    800061e0:	ffffb097          	auipc	ra,0xffffb
    800061e4:	1a8080e7          	jalr	424(ra) # 80001388 <_Z15thread_dispatchv>
    while (!threadEnd) {
    800061e8:	00008797          	auipc	a5,0x8
    800061ec:	0307a783          	lw	a5,48(a5) # 8000e218 <_ZL9threadEnd>
    800061f0:	02079e63          	bnez	a5,8000622c <_ZN12ProducerSync8producerEPv+0x70>
        data->buffer->put(data->id + '0');
    800061f4:	0004a583          	lw	a1,0(s1)
    800061f8:	0305859b          	addiw	a1,a1,48
    800061fc:	0084b503          	ld	a0,8(s1)
    80006200:	00001097          	auipc	ra,0x1
    80006204:	848080e7          	jalr	-1976(ra) # 80006a48 <_ZN9BufferCPP3putEi>
        i++;
    80006208:	0019071b          	addiw	a4,s2,1
    8000620c:	0007091b          	sext.w	s2,a4

        if (i % (10 * data->id) == 0) {
    80006210:	0004a683          	lw	a3,0(s1)
    80006214:	0026979b          	slliw	a5,a3,0x2
    80006218:	00d787bb          	addw	a5,a5,a3
    8000621c:	0017979b          	slliw	a5,a5,0x1
    80006220:	02f767bb          	remw	a5,a4,a5
    80006224:	fc0792e3          	bnez	a5,800061e8 <_ZN12ProducerSync8producerEPv+0x2c>
    80006228:	fb9ff06f          	j	800061e0 <_ZN12ProducerSync8producerEPv+0x24>
            Thread::dispatch();
        }
    }

    data->wait->signal();
    8000622c:	0104b783          	ld	a5,16(s1)
            return sem_signal(myHandle);
    80006230:	0087b503          	ld	a0,8(a5)
    80006234:	ffffb097          	auipc	ra,0xffffb
    80006238:	2cc080e7          	jalr	716(ra) # 80001500 <_Z10sem_signalP5sem_s>
}
    8000623c:	01813083          	ld	ra,24(sp)
    80006240:	01013403          	ld	s0,16(sp)
    80006244:	00813483          	ld	s1,8(sp)
    80006248:	00013903          	ld	s2,0(sp)
    8000624c:	02010113          	addi	sp,sp,32
    80006250:	00008067          	ret

0000000080006254 <_ZN12ConsumerSync8consumerEPv>:
    void run() override {
        consumer(td);
    }
};

void ConsumerSync::consumer(void *arg) {
    80006254:	fd010113          	addi	sp,sp,-48
    80006258:	02113423          	sd	ra,40(sp)
    8000625c:	02813023          	sd	s0,32(sp)
    80006260:	00913c23          	sd	s1,24(sp)
    80006264:	01213823          	sd	s2,16(sp)
    80006268:	01313423          	sd	s3,8(sp)
    8000626c:	01413023          	sd	s4,0(sp)
    80006270:	03010413          	addi	s0,sp,48
    80006274:	00050993          	mv	s3,a0
    80006278:	00058913          	mv	s2,a1
    struct thread_data *data = (struct thread_data *) arg;

    int i = 0;
    8000627c:	00000a13          	li	s4,0
    80006280:	01c0006f          	j	8000629c <_ZN12ConsumerSync8consumerEPv+0x48>
            thread_dispatch();
    80006284:	ffffb097          	auipc	ra,0xffffb
    80006288:	104080e7          	jalr	260(ra) # 80001388 <_Z15thread_dispatchv>
        }
    8000628c:	0500006f          	j	800062dc <_ZN12ConsumerSync8consumerEPv+0x88>
        if (i % (5 * data->id) == 0) {
            Thread::dispatch();
        }

        if (i % 80 == 0) {
            putc('\n');
    80006290:	00a00513          	li	a0,10
    80006294:	ffffb097          	auipc	ra,0xffffb
    80006298:	31c080e7          	jalr	796(ra) # 800015b0 <_Z4putcc>
    while (!threadEnd) {
    8000629c:	00008797          	auipc	a5,0x8
    800062a0:	f7c7a783          	lw	a5,-132(a5) # 8000e218 <_ZL9threadEnd>
    800062a4:	06079263          	bnez	a5,80006308 <_ZN12ConsumerSync8consumerEPv+0xb4>
        int key = data->buffer->get();
    800062a8:	00893503          	ld	a0,8(s2)
    800062ac:	00001097          	auipc	ra,0x1
    800062b0:	83c080e7          	jalr	-1988(ra) # 80006ae8 <_ZN9BufferCPP3getEv>
        i++;
    800062b4:	001a049b          	addiw	s1,s4,1
    800062b8:	00048a1b          	sext.w	s4,s1
        putc(key);
    800062bc:	0ff57513          	andi	a0,a0,255
    800062c0:	ffffb097          	auipc	ra,0xffffb
    800062c4:	2f0080e7          	jalr	752(ra) # 800015b0 <_Z4putcc>
        if (i % (5 * data->id) == 0) {
    800062c8:	00092703          	lw	a4,0(s2)
    800062cc:	0027179b          	slliw	a5,a4,0x2
    800062d0:	00e787bb          	addw	a5,a5,a4
    800062d4:	02f4e7bb          	remw	a5,s1,a5
    800062d8:	fa0786e3          	beqz	a5,80006284 <_ZN12ConsumerSync8consumerEPv+0x30>
        if (i % 80 == 0) {
    800062dc:	05000793          	li	a5,80
    800062e0:	02f4e4bb          	remw	s1,s1,a5
    800062e4:	fa049ce3          	bnez	s1,8000629c <_ZN12ConsumerSync8consumerEPv+0x48>
    800062e8:	fa9ff06f          	j	80006290 <_ZN12ConsumerSync8consumerEPv+0x3c>
        }
    }


    while (td->buffer->getCnt() > 0) {
        int key = td->buffer->get();
    800062ec:	0209b783          	ld	a5,32(s3)
    800062f0:	0087b503          	ld	a0,8(a5)
    800062f4:	00000097          	auipc	ra,0x0
    800062f8:	7f4080e7          	jalr	2036(ra) # 80006ae8 <_ZN9BufferCPP3getEv>
            ::putc(c);
    800062fc:	0ff57513          	andi	a0,a0,255
    80006300:	ffffb097          	auipc	ra,0xffffb
    80006304:	2b0080e7          	jalr	688(ra) # 800015b0 <_Z4putcc>
    while (td->buffer->getCnt() > 0) {
    80006308:	0209b783          	ld	a5,32(s3)
    8000630c:	0087b503          	ld	a0,8(a5)
    80006310:	00001097          	auipc	ra,0x1
    80006314:	874080e7          	jalr	-1932(ra) # 80006b84 <_ZN9BufferCPP6getCntEv>
    80006318:	fca04ae3          	bgtz	a0,800062ec <_ZN12ConsumerSync8consumerEPv+0x98>
        Console::putc(key);
    }

    data->wait->signal();
    8000631c:	01093783          	ld	a5,16(s2)
            return sem_signal(myHandle);
    80006320:	0087b503          	ld	a0,8(a5)
    80006324:	ffffb097          	auipc	ra,0xffffb
    80006328:	1dc080e7          	jalr	476(ra) # 80001500 <_Z10sem_signalP5sem_s>
}
    8000632c:	02813083          	ld	ra,40(sp)
    80006330:	02013403          	ld	s0,32(sp)
    80006334:	01813483          	ld	s1,24(sp)
    80006338:	01013903          	ld	s2,16(sp)
    8000633c:	00813983          	ld	s3,8(sp)
    80006340:	00013a03          	ld	s4,0(sp)
    80006344:	03010113          	addi	sp,sp,48
    80006348:	00008067          	ret

000000008000634c <_Z29producerConsumer_CPP_Sync_APIv>:

void producerConsumer_CPP_Sync_API() {
    8000634c:	f9010113          	addi	sp,sp,-112
    80006350:	06113423          	sd	ra,104(sp)
    80006354:	06813023          	sd	s0,96(sp)
    80006358:	04913c23          	sd	s1,88(sp)
    8000635c:	05213823          	sd	s2,80(sp)
    80006360:	05313423          	sd	s3,72(sp)
    80006364:	05413023          	sd	s4,64(sp)
    80006368:	03513c23          	sd	s5,56(sp)
    8000636c:	03613823          	sd	s6,48(sp)
    80006370:	03713423          	sd	s7,40(sp)
    80006374:	03813023          	sd	s8,32(sp)
    80006378:	07010413          	addi	s0,sp,112
    for (int i = 0; i < threadNum; i++) {
        delete threads[i];
    }
    delete consumerThread;
    delete waitForAll;
    delete buffer;
    8000637c:	00010b93          	mv	s7,sp
    printString("Unesite broj proizvodjaca?\n");
    80006380:	00004517          	auipc	a0,0x4
    80006384:	08050513          	addi	a0,a0,128 # 8000a400 <CONSOLE_STATUS+0x3f0>
    80006388:	ffffc097          	auipc	ra,0xffffc
    8000638c:	b24080e7          	jalr	-1244(ra) # 80001eac <_Z11printStringPKc>
    getString(input, 30);
    80006390:	01e00593          	li	a1,30
    80006394:	f9040493          	addi	s1,s0,-112
    80006398:	00048513          	mv	a0,s1
    8000639c:	ffffc097          	auipc	ra,0xffffc
    800063a0:	b98080e7          	jalr	-1128(ra) # 80001f34 <_Z9getStringPci>
    threadNum = stringToInt(input);
    800063a4:	00048513          	mv	a0,s1
    800063a8:	ffffc097          	auipc	ra,0xffffc
    800063ac:	c64080e7          	jalr	-924(ra) # 8000200c <_Z11stringToIntPKc>
    800063b0:	00050913          	mv	s2,a0
    printString("Unesite velicinu bafera?\n");
    800063b4:	00004517          	auipc	a0,0x4
    800063b8:	06c50513          	addi	a0,a0,108 # 8000a420 <CONSOLE_STATUS+0x410>
    800063bc:	ffffc097          	auipc	ra,0xffffc
    800063c0:	af0080e7          	jalr	-1296(ra) # 80001eac <_Z11printStringPKc>
    getString(input, 30);
    800063c4:	01e00593          	li	a1,30
    800063c8:	00048513          	mv	a0,s1
    800063cc:	ffffc097          	auipc	ra,0xffffc
    800063d0:	b68080e7          	jalr	-1176(ra) # 80001f34 <_Z9getStringPci>
    n = stringToInt(input);
    800063d4:	00048513          	mv	a0,s1
    800063d8:	ffffc097          	auipc	ra,0xffffc
    800063dc:	c34080e7          	jalr	-972(ra) # 8000200c <_Z11stringToIntPKc>
    800063e0:	00050493          	mv	s1,a0
    printString("Broj proizvodjaca "); printInt(threadNum);
    800063e4:	00004517          	auipc	a0,0x4
    800063e8:	05c50513          	addi	a0,a0,92 # 8000a440 <CONSOLE_STATUS+0x430>
    800063ec:	ffffc097          	auipc	ra,0xffffc
    800063f0:	ac0080e7          	jalr	-1344(ra) # 80001eac <_Z11printStringPKc>
    800063f4:	00000613          	li	a2,0
    800063f8:	00a00593          	li	a1,10
    800063fc:	00090513          	mv	a0,s2
    80006400:	ffffc097          	auipc	ra,0xffffc
    80006404:	c5c080e7          	jalr	-932(ra) # 8000205c <_Z8printIntiii>
    printString(" i velicina bafera "); printInt(n);
    80006408:	00004517          	auipc	a0,0x4
    8000640c:	05050513          	addi	a0,a0,80 # 8000a458 <CONSOLE_STATUS+0x448>
    80006410:	ffffc097          	auipc	ra,0xffffc
    80006414:	a9c080e7          	jalr	-1380(ra) # 80001eac <_Z11printStringPKc>
    80006418:	00000613          	li	a2,0
    8000641c:	00a00593          	li	a1,10
    80006420:	00048513          	mv	a0,s1
    80006424:	ffffc097          	auipc	ra,0xffffc
    80006428:	c38080e7          	jalr	-968(ra) # 8000205c <_Z8printIntiii>
    printString(".\n");
    8000642c:	00004517          	auipc	a0,0x4
    80006430:	04450513          	addi	a0,a0,68 # 8000a470 <CONSOLE_STATUS+0x460>
    80006434:	ffffc097          	auipc	ra,0xffffc
    80006438:	a78080e7          	jalr	-1416(ra) # 80001eac <_Z11printStringPKc>
    if(threadNum > n) {
    8000643c:	0324c463          	blt	s1,s2,80006464 <_Z29producerConsumer_CPP_Sync_APIv+0x118>
    } else if (threadNum < 1) {
    80006440:	03205c63          	blez	s2,80006478 <_Z29producerConsumer_CPP_Sync_APIv+0x12c>
    BufferCPP *buffer = new BufferCPP(n);
    80006444:	03800513          	li	a0,56
    80006448:	ffffc097          	auipc	ra,0xffffc
    8000644c:	798080e7          	jalr	1944(ra) # 80002be0 <_Znwm>
    80006450:	00050a93          	mv	s5,a0
    80006454:	00048593          	mv	a1,s1
    80006458:	00000097          	auipc	ra,0x0
    8000645c:	45c080e7          	jalr	1116(ra) # 800068b4 <_ZN9BufferCPPC1Ei>
    80006460:	0300006f          	j	80006490 <_Z29producerConsumer_CPP_Sync_APIv+0x144>
        printString("Broj proizvodjaca ne sme biti manji od velicine bafera!\n");
    80006464:	00004517          	auipc	a0,0x4
    80006468:	01450513          	addi	a0,a0,20 # 8000a478 <CONSOLE_STATUS+0x468>
    8000646c:	ffffc097          	auipc	ra,0xffffc
    80006470:	a40080e7          	jalr	-1472(ra) # 80001eac <_Z11printStringPKc>
        return;
    80006474:	0140006f          	j	80006488 <_Z29producerConsumer_CPP_Sync_APIv+0x13c>
        printString("Broj proizvodjaca mora biti veci od nula!\n");
    80006478:	00004517          	auipc	a0,0x4
    8000647c:	04050513          	addi	a0,a0,64 # 8000a4b8 <CONSOLE_STATUS+0x4a8>
    80006480:	ffffc097          	auipc	ra,0xffffc
    80006484:	a2c080e7          	jalr	-1492(ra) # 80001eac <_Z11printStringPKc>
        return;
    80006488:	000b8113          	mv	sp,s7
    8000648c:	2780006f          	j	80006704 <_Z29producerConsumer_CPP_Sync_APIv+0x3b8>
    waitForAll = new Semaphore(0);
    80006490:	01000513          	li	a0,16
    80006494:	ffffc097          	auipc	ra,0xffffc
    80006498:	74c080e7          	jalr	1868(ra) # 80002be0 <_Znwm>
    8000649c:	00050493          	mv	s1,a0
        Semaphore (unsigned init = 1){
    800064a0:	00006797          	auipc	a5,0x6
    800064a4:	67078793          	addi	a5,a5,1648 # 8000cb10 <_ZTV9Semaphore+0x10>
    800064a8:	00f53023          	sd	a5,0(a0)
            sem_open(&myHandle,init);
    800064ac:	00000593          	li	a1,0
    800064b0:	00850513          	addi	a0,a0,8
    800064b4:	ffffb097          	auipc	ra,0xffffb
    800064b8:	f88080e7          	jalr	-120(ra) # 8000143c <_Z8sem_openPP5sem_sj>
    800064bc:	00008797          	auipc	a5,0x8
    800064c0:	d697b223          	sd	s1,-668(a5) # 8000e220 <_ZL10waitForAll>
    Thread* threads[threadNum];
    800064c4:	00391793          	slli	a5,s2,0x3
    800064c8:	00f78793          	addi	a5,a5,15
    800064cc:	ff07f793          	andi	a5,a5,-16
    800064d0:	40f10133          	sub	sp,sp,a5
    800064d4:	00010993          	mv	s3,sp
    struct thread_data data[threadNum + 1];
    800064d8:	0019071b          	addiw	a4,s2,1
    800064dc:	00171793          	slli	a5,a4,0x1
    800064e0:	00e787b3          	add	a5,a5,a4
    800064e4:	00379793          	slli	a5,a5,0x3
    800064e8:	00f78793          	addi	a5,a5,15
    800064ec:	ff07f793          	andi	a5,a5,-16
    800064f0:	40f10133          	sub	sp,sp,a5
    800064f4:	00010a13          	mv	s4,sp
    data[threadNum].id = threadNum;
    800064f8:	00191c13          	slli	s8,s2,0x1
    800064fc:	012c07b3          	add	a5,s8,s2
    80006500:	00379793          	slli	a5,a5,0x3
    80006504:	00fa07b3          	add	a5,s4,a5
    80006508:	0127a023          	sw	s2,0(a5)
    data[threadNum].buffer = buffer;
    8000650c:	0157b423          	sd	s5,8(a5)
    data[threadNum].wait = waitForAll;
    80006510:	0097b823          	sd	s1,16(a5)
    consumerThread = new ConsumerSync(data+threadNum);
    80006514:	02800513          	li	a0,40
    80006518:	ffffc097          	auipc	ra,0xffffc
    8000651c:	6c8080e7          	jalr	1736(ra) # 80002be0 <_Znwm>
    80006520:	00050b13          	mv	s6,a0
    80006524:	012c0c33          	add	s8,s8,s2
    80006528:	003c1c13          	slli	s8,s8,0x3
    8000652c:	018a0c33          	add	s8,s4,s8
            body= nullptr;
    80006530:	00053823          	sd	zero,16(a0)
            arg= nullptr;
    80006534:	00053c23          	sd	zero,24(a0)
    ConsumerSync(thread_data* _td):Thread(), td(_td) {}
    80006538:	00006797          	auipc	a5,0x6
    8000653c:	6c078793          	addi	a5,a5,1728 # 8000cbf8 <_ZTV12ConsumerSync+0x10>
    80006540:	00f53023          	sd	a5,0(a0)
    80006544:	03853023          	sd	s8,32(a0)
            if(body== nullptr) return thread_create(&myHandle,&threadEntry, this);
    80006548:	00050613          	mv	a2,a0
    8000654c:	ffffc597          	auipc	a1,0xffffc
    80006550:	64058593          	addi	a1,a1,1600 # 80002b8c <_ZN6Thread11threadEntryEPv>
    80006554:	00850513          	addi	a0,a0,8
    80006558:	ffffb097          	auipc	ra,0xffffb
    8000655c:	da8080e7          	jalr	-600(ra) # 80001300 <_Z13thread_createPP8thread_sPFvPvES2_>
    for (int i = 0; i < threadNum; i++) {
    80006560:	00000493          	li	s1,0
    80006564:	0640006f          	j	800065c8 <_Z29producerConsumer_CPP_Sync_APIv+0x27c>
            threads[i] = new ProducerKeyboard(data+i);
    80006568:	02800513          	li	a0,40
    8000656c:	ffffc097          	auipc	ra,0xffffc
    80006570:	674080e7          	jalr	1652(ra) # 80002be0 <_Znwm>
    80006574:	00149793          	slli	a5,s1,0x1
    80006578:	009787b3          	add	a5,a5,s1
    8000657c:	00379793          	slli	a5,a5,0x3
    80006580:	00fa07b3          	add	a5,s4,a5
            body= nullptr;
    80006584:	00053823          	sd	zero,16(a0)
            arg= nullptr;
    80006588:	00053c23          	sd	zero,24(a0)
    ProducerKeyboard(thread_data* _td):Thread(), td(_td) {}
    8000658c:	00006717          	auipc	a4,0x6
    80006590:	61c70713          	addi	a4,a4,1564 # 8000cba8 <_ZTV16ProducerKeyboard+0x10>
    80006594:	00e53023          	sd	a4,0(a0)
    80006598:	02f53023          	sd	a5,32(a0)
            threads[i] = new ProducerKeyboard(data+i);
    8000659c:	00349793          	slli	a5,s1,0x3
    800065a0:	00f987b3          	add	a5,s3,a5
    800065a4:	00a7b023          	sd	a0,0(a5)
    800065a8:	08c0006f          	j	80006634 <_Z29producerConsumer_CPP_Sync_APIv+0x2e8>
            if(body== nullptr) return thread_create(&myHandle,&threadEntry, this);
    800065ac:	00050613          	mv	a2,a0
    800065b0:	ffffc597          	auipc	a1,0xffffc
    800065b4:	5dc58593          	addi	a1,a1,1500 # 80002b8c <_ZN6Thread11threadEntryEPv>
    800065b8:	00850513          	addi	a0,a0,8
    800065bc:	ffffb097          	auipc	ra,0xffffb
    800065c0:	d44080e7          	jalr	-700(ra) # 80001300 <_Z13thread_createPP8thread_sPFvPvES2_>
    for (int i = 0; i < threadNum; i++) {
    800065c4:	0014849b          	addiw	s1,s1,1
    800065c8:	0924da63          	bge	s1,s2,8000665c <_Z29producerConsumer_CPP_Sync_APIv+0x310>
        data[i].id = i;
    800065cc:	00149793          	slli	a5,s1,0x1
    800065d0:	009787b3          	add	a5,a5,s1
    800065d4:	00379793          	slli	a5,a5,0x3
    800065d8:	00fa07b3          	add	a5,s4,a5
    800065dc:	0097a023          	sw	s1,0(a5)
        data[i].buffer = buffer;
    800065e0:	0157b423          	sd	s5,8(a5)
        data[i].wait = waitForAll;
    800065e4:	00008717          	auipc	a4,0x8
    800065e8:	c3c73703          	ld	a4,-964(a4) # 8000e220 <_ZL10waitForAll>
    800065ec:	00e7b823          	sd	a4,16(a5)
        if(i>0) {
    800065f0:	f6905ce3          	blez	s1,80006568 <_Z29producerConsumer_CPP_Sync_APIv+0x21c>
            threads[i] = new ProducerSync(data+i);
    800065f4:	02800513          	li	a0,40
    800065f8:	ffffc097          	auipc	ra,0xffffc
    800065fc:	5e8080e7          	jalr	1512(ra) # 80002be0 <_Znwm>
    80006600:	00149793          	slli	a5,s1,0x1
    80006604:	009787b3          	add	a5,a5,s1
    80006608:	00379793          	slli	a5,a5,0x3
    8000660c:	00fa07b3          	add	a5,s4,a5
            body= nullptr;
    80006610:	00053823          	sd	zero,16(a0)
            arg= nullptr;
    80006614:	00053c23          	sd	zero,24(a0)
    ProducerSync(thread_data* _td):Thread(), td(_td) {}
    80006618:	00006717          	auipc	a4,0x6
    8000661c:	5b870713          	addi	a4,a4,1464 # 8000cbd0 <_ZTV12ProducerSync+0x10>
    80006620:	00e53023          	sd	a4,0(a0)
    80006624:	02f53023          	sd	a5,32(a0)
            threads[i] = new ProducerSync(data+i);
    80006628:	00349793          	slli	a5,s1,0x3
    8000662c:	00f987b3          	add	a5,s3,a5
    80006630:	00a7b023          	sd	a0,0(a5)
        threads[i]->start();
    80006634:	00349793          	slli	a5,s1,0x3
    80006638:	00f987b3          	add	a5,s3,a5
    8000663c:	0007b503          	ld	a0,0(a5)
            if(body== nullptr) return thread_create(&myHandle,&threadEntry, this);
    80006640:	01053583          	ld	a1,16(a0)
    80006644:	f60584e3          	beqz	a1,800065ac <_Z29producerConsumer_CPP_Sync_APIv+0x260>
            else return thread_create(&myHandle,body,arg);
    80006648:	01853603          	ld	a2,24(a0)
    8000664c:	00850513          	addi	a0,a0,8
    80006650:	ffffb097          	auipc	ra,0xffffb
    80006654:	cb0080e7          	jalr	-848(ra) # 80001300 <_Z13thread_createPP8thread_sPFvPvES2_>
    80006658:	f6dff06f          	j	800065c4 <_Z29producerConsumer_CPP_Sync_APIv+0x278>
            thread_dispatch();
    8000665c:	ffffb097          	auipc	ra,0xffffb
    80006660:	d2c080e7          	jalr	-724(ra) # 80001388 <_Z15thread_dispatchv>
    for (int i = 0; i <= threadNum; i++) {
    80006664:	00000493          	li	s1,0
    80006668:	02994063          	blt	s2,s1,80006688 <_Z29producerConsumer_CPP_Sync_APIv+0x33c>
            return sem_wait(myHandle);
    8000666c:	00008797          	auipc	a5,0x8
    80006670:	bb47b783          	ld	a5,-1100(a5) # 8000e220 <_ZL10waitForAll>
    80006674:	0087b503          	ld	a0,8(a5)
    80006678:	ffffb097          	auipc	ra,0xffffb
    8000667c:	e48080e7          	jalr	-440(ra) # 800014c0 <_Z8sem_waitP5sem_s>
    80006680:	0014849b          	addiw	s1,s1,1
    80006684:	fe5ff06f          	j	80006668 <_Z29producerConsumer_CPP_Sync_APIv+0x31c>
    for (int i = 0; i < threadNum; i++) {
    80006688:	00000493          	li	s1,0
    8000668c:	0080006f          	j	80006694 <_Z29producerConsumer_CPP_Sync_APIv+0x348>
    80006690:	0014849b          	addiw	s1,s1,1
    80006694:	0324d263          	bge	s1,s2,800066b8 <_Z29producerConsumer_CPP_Sync_APIv+0x36c>
        delete threads[i];
    80006698:	00349793          	slli	a5,s1,0x3
    8000669c:	00f987b3          	add	a5,s3,a5
    800066a0:	0007b503          	ld	a0,0(a5)
    800066a4:	fe0506e3          	beqz	a0,80006690 <_Z29producerConsumer_CPP_Sync_APIv+0x344>
    800066a8:	00053783          	ld	a5,0(a0)
    800066ac:	0087b783          	ld	a5,8(a5)
    800066b0:	000780e7          	jalr	a5
    800066b4:	fddff06f          	j	80006690 <_Z29producerConsumer_CPP_Sync_APIv+0x344>
    delete consumerThread;
    800066b8:	000b0a63          	beqz	s6,800066cc <_Z29producerConsumer_CPP_Sync_APIv+0x380>
    800066bc:	000b3783          	ld	a5,0(s6)
    800066c0:	0087b783          	ld	a5,8(a5)
    800066c4:	000b0513          	mv	a0,s6
    800066c8:	000780e7          	jalr	a5
    delete waitForAll;
    800066cc:	00008517          	auipc	a0,0x8
    800066d0:	b5453503          	ld	a0,-1196(a0) # 8000e220 <_ZL10waitForAll>
    800066d4:	00050863          	beqz	a0,800066e4 <_Z29producerConsumer_CPP_Sync_APIv+0x398>
    800066d8:	00053783          	ld	a5,0(a0)
    800066dc:	0087b783          	ld	a5,8(a5)
    800066e0:	000780e7          	jalr	a5
    delete buffer;
    800066e4:	000a8e63          	beqz	s5,80006700 <_Z29producerConsumer_CPP_Sync_APIv+0x3b4>
    800066e8:	000a8513          	mv	a0,s5
    800066ec:	00000097          	auipc	ra,0x0
    800066f0:	530080e7          	jalr	1328(ra) # 80006c1c <_ZN9BufferCPPD1Ev>
    800066f4:	000a8513          	mv	a0,s5
    800066f8:	ffffc097          	auipc	ra,0xffffc
    800066fc:	510080e7          	jalr	1296(ra) # 80002c08 <_ZdlPv>
    80006700:	000b8113          	mv	sp,s7

}
    80006704:	f9040113          	addi	sp,s0,-112
    80006708:	06813083          	ld	ra,104(sp)
    8000670c:	06013403          	ld	s0,96(sp)
    80006710:	05813483          	ld	s1,88(sp)
    80006714:	05013903          	ld	s2,80(sp)
    80006718:	04813983          	ld	s3,72(sp)
    8000671c:	04013a03          	ld	s4,64(sp)
    80006720:	03813a83          	ld	s5,56(sp)
    80006724:	03013b03          	ld	s6,48(sp)
    80006728:	02813b83          	ld	s7,40(sp)
    8000672c:	02013c03          	ld	s8,32(sp)
    80006730:	07010113          	addi	sp,sp,112
    80006734:	00008067          	ret
    80006738:	00050493          	mv	s1,a0
    BufferCPP *buffer = new BufferCPP(n);
    8000673c:	000a8513          	mv	a0,s5
    80006740:	ffffc097          	auipc	ra,0xffffc
    80006744:	4c8080e7          	jalr	1224(ra) # 80002c08 <_ZdlPv>
    80006748:	00048513          	mv	a0,s1
    8000674c:	00009097          	auipc	ra,0x9
    80006750:	bac080e7          	jalr	-1108(ra) # 8000f2f8 <_Unwind_Resume>
    80006754:	00050913          	mv	s2,a0
    waitForAll = new Semaphore(0);
    80006758:	00048513          	mv	a0,s1
    8000675c:	ffffc097          	auipc	ra,0xffffc
    80006760:	4ac080e7          	jalr	1196(ra) # 80002c08 <_ZdlPv>
    80006764:	00090513          	mv	a0,s2
    80006768:	00009097          	auipc	ra,0x9
    8000676c:	b90080e7          	jalr	-1136(ra) # 8000f2f8 <_Unwind_Resume>

0000000080006770 <_ZN12ConsumerSyncD1Ev>:
class ConsumerSync:public Thread {
    80006770:	ff010113          	addi	sp,sp,-16
    80006774:	00813423          	sd	s0,8(sp)
    80006778:	01010413          	addi	s0,sp,16
    8000677c:	00813403          	ld	s0,8(sp)
    80006780:	01010113          	addi	sp,sp,16
    80006784:	00008067          	ret

0000000080006788 <_ZN12ProducerSyncD1Ev>:
class ProducerSync:public Thread {
    80006788:	ff010113          	addi	sp,sp,-16
    8000678c:	00813423          	sd	s0,8(sp)
    80006790:	01010413          	addi	s0,sp,16
    80006794:	00813403          	ld	s0,8(sp)
    80006798:	01010113          	addi	sp,sp,16
    8000679c:	00008067          	ret

00000000800067a0 <_ZN16ProducerKeyboardD1Ev>:
class ProducerKeyboard:public Thread {
    800067a0:	ff010113          	addi	sp,sp,-16
    800067a4:	00813423          	sd	s0,8(sp)
    800067a8:	01010413          	addi	s0,sp,16
    800067ac:	00813403          	ld	s0,8(sp)
    800067b0:	01010113          	addi	sp,sp,16
    800067b4:	00008067          	ret

00000000800067b8 <_ZN12ConsumerSyncD0Ev>:
class ConsumerSync:public Thread {
    800067b8:	ff010113          	addi	sp,sp,-16
    800067bc:	00113423          	sd	ra,8(sp)
    800067c0:	00813023          	sd	s0,0(sp)
    800067c4:	01010413          	addi	s0,sp,16
    800067c8:	ffffc097          	auipc	ra,0xffffc
    800067cc:	440080e7          	jalr	1088(ra) # 80002c08 <_ZdlPv>
    800067d0:	00813083          	ld	ra,8(sp)
    800067d4:	00013403          	ld	s0,0(sp)
    800067d8:	01010113          	addi	sp,sp,16
    800067dc:	00008067          	ret

00000000800067e0 <_ZN12ProducerSyncD0Ev>:
class ProducerSync:public Thread {
    800067e0:	ff010113          	addi	sp,sp,-16
    800067e4:	00113423          	sd	ra,8(sp)
    800067e8:	00813023          	sd	s0,0(sp)
    800067ec:	01010413          	addi	s0,sp,16
    800067f0:	ffffc097          	auipc	ra,0xffffc
    800067f4:	418080e7          	jalr	1048(ra) # 80002c08 <_ZdlPv>
    800067f8:	00813083          	ld	ra,8(sp)
    800067fc:	00013403          	ld	s0,0(sp)
    80006800:	01010113          	addi	sp,sp,16
    80006804:	00008067          	ret

0000000080006808 <_ZN16ProducerKeyboardD0Ev>:
class ProducerKeyboard:public Thread {
    80006808:	ff010113          	addi	sp,sp,-16
    8000680c:	00113423          	sd	ra,8(sp)
    80006810:	00813023          	sd	s0,0(sp)
    80006814:	01010413          	addi	s0,sp,16
    80006818:	ffffc097          	auipc	ra,0xffffc
    8000681c:	3f0080e7          	jalr	1008(ra) # 80002c08 <_ZdlPv>
    80006820:	00813083          	ld	ra,8(sp)
    80006824:	00013403          	ld	s0,0(sp)
    80006828:	01010113          	addi	sp,sp,16
    8000682c:	00008067          	ret

0000000080006830 <_ZN16ProducerKeyboard3runEv>:
    void run() override {
    80006830:	ff010113          	addi	sp,sp,-16
    80006834:	00113423          	sd	ra,8(sp)
    80006838:	00813023          	sd	s0,0(sp)
    8000683c:	01010413          	addi	s0,sp,16
        producerKeyboard(td);
    80006840:	02053583          	ld	a1,32(a0)
    80006844:	00000097          	auipc	ra,0x0
    80006848:	8b4080e7          	jalr	-1868(ra) # 800060f8 <_ZN16ProducerKeyboard16producerKeyboardEPv>
    }
    8000684c:	00813083          	ld	ra,8(sp)
    80006850:	00013403          	ld	s0,0(sp)
    80006854:	01010113          	addi	sp,sp,16
    80006858:	00008067          	ret

000000008000685c <_ZN12ProducerSync3runEv>:
    void run() override {
    8000685c:	ff010113          	addi	sp,sp,-16
    80006860:	00113423          	sd	ra,8(sp)
    80006864:	00813023          	sd	s0,0(sp)
    80006868:	01010413          	addi	s0,sp,16
        producer(td);
    8000686c:	02053583          	ld	a1,32(a0)
    80006870:	00000097          	auipc	ra,0x0
    80006874:	94c080e7          	jalr	-1716(ra) # 800061bc <_ZN12ProducerSync8producerEPv>
    }
    80006878:	00813083          	ld	ra,8(sp)
    8000687c:	00013403          	ld	s0,0(sp)
    80006880:	01010113          	addi	sp,sp,16
    80006884:	00008067          	ret

0000000080006888 <_ZN12ConsumerSync3runEv>:
    void run() override {
    80006888:	ff010113          	addi	sp,sp,-16
    8000688c:	00113423          	sd	ra,8(sp)
    80006890:	00813023          	sd	s0,0(sp)
    80006894:	01010413          	addi	s0,sp,16
        consumer(td);
    80006898:	02053583          	ld	a1,32(a0)
    8000689c:	00000097          	auipc	ra,0x0
    800068a0:	9b8080e7          	jalr	-1608(ra) # 80006254 <_ZN12ConsumerSync8consumerEPv>
    }
    800068a4:	00813083          	ld	ra,8(sp)
    800068a8:	00013403          	ld	s0,0(sp)
    800068ac:	01010113          	addi	sp,sp,16
    800068b0:	00008067          	ret

00000000800068b4 <_ZN9BufferCPPC1Ei>:
#include "buffer_CPP_API.hpp"

BufferCPP::BufferCPP(int _cap) : cap(_cap + 1), head(0), tail(0) {
    800068b4:	fd010113          	addi	sp,sp,-48
    800068b8:	02113423          	sd	ra,40(sp)
    800068bc:	02813023          	sd	s0,32(sp)
    800068c0:	00913c23          	sd	s1,24(sp)
    800068c4:	01213823          	sd	s2,16(sp)
    800068c8:	01313423          	sd	s3,8(sp)
    800068cc:	03010413          	addi	s0,sp,48
    800068d0:	00050493          	mv	s1,a0
    800068d4:	00058993          	mv	s3,a1
    800068d8:	0015879b          	addiw	a5,a1,1
    800068dc:	0007851b          	sext.w	a0,a5
    800068e0:	00f4a023          	sw	a5,0(s1)
    800068e4:	0004a823          	sw	zero,16(s1)
    800068e8:	0004aa23          	sw	zero,20(s1)
    buffer = (int *)mem_alloc(sizeof(int) * cap);
    800068ec:	00251513          	slli	a0,a0,0x2
    800068f0:	ffffb097          	auipc	ra,0xffffb
    800068f4:	990080e7          	jalr	-1648(ra) # 80001280 <_Z9mem_allocm>
    800068f8:	00a4b423          	sd	a0,8(s1)
    itemAvailable = new Semaphore(0);
    800068fc:	01000513          	li	a0,16
    80006900:	ffffc097          	auipc	ra,0xffffc
    80006904:	2e0080e7          	jalr	736(ra) # 80002be0 <_Znwm>
    80006908:	00050913          	mv	s2,a0
        Semaphore (unsigned init = 1){
    8000690c:	00006797          	auipc	a5,0x6
    80006910:	20478793          	addi	a5,a5,516 # 8000cb10 <_ZTV9Semaphore+0x10>
    80006914:	00f53023          	sd	a5,0(a0)
            sem_open(&myHandle,init);
    80006918:	00000593          	li	a1,0
    8000691c:	00850513          	addi	a0,a0,8
    80006920:	ffffb097          	auipc	ra,0xffffb
    80006924:	b1c080e7          	jalr	-1252(ra) # 8000143c <_Z8sem_openPP5sem_sj>
    80006928:	0324b023          	sd	s2,32(s1)
    spaceAvailable = new Semaphore(_cap);
    8000692c:	01000513          	li	a0,16
    80006930:	ffffc097          	auipc	ra,0xffffc
    80006934:	2b0080e7          	jalr	688(ra) # 80002be0 <_Znwm>
    80006938:	00050913          	mv	s2,a0
        Semaphore (unsigned init = 1){
    8000693c:	00006797          	auipc	a5,0x6
    80006940:	1d478793          	addi	a5,a5,468 # 8000cb10 <_ZTV9Semaphore+0x10>
    80006944:	00f53023          	sd	a5,0(a0)
            sem_open(&myHandle,init);
    80006948:	00098593          	mv	a1,s3
    8000694c:	00850513          	addi	a0,a0,8
    80006950:	ffffb097          	auipc	ra,0xffffb
    80006954:	aec080e7          	jalr	-1300(ra) # 8000143c <_Z8sem_openPP5sem_sj>
    80006958:	0124bc23          	sd	s2,24(s1)
    mutexHead = new Semaphore(1);
    8000695c:	01000513          	li	a0,16
    80006960:	ffffc097          	auipc	ra,0xffffc
    80006964:	280080e7          	jalr	640(ra) # 80002be0 <_Znwm>
    80006968:	00050913          	mv	s2,a0
        Semaphore (unsigned init = 1){
    8000696c:	00006797          	auipc	a5,0x6
    80006970:	1a478793          	addi	a5,a5,420 # 8000cb10 <_ZTV9Semaphore+0x10>
    80006974:	00f53023          	sd	a5,0(a0)
            sem_open(&myHandle,init);
    80006978:	00100593          	li	a1,1
    8000697c:	00850513          	addi	a0,a0,8
    80006980:	ffffb097          	auipc	ra,0xffffb
    80006984:	abc080e7          	jalr	-1348(ra) # 8000143c <_Z8sem_openPP5sem_sj>
    80006988:	0324b423          	sd	s2,40(s1)
    mutexTail = new Semaphore(1);
    8000698c:	01000513          	li	a0,16
    80006990:	ffffc097          	auipc	ra,0xffffc
    80006994:	250080e7          	jalr	592(ra) # 80002be0 <_Znwm>
    80006998:	00050913          	mv	s2,a0
        Semaphore (unsigned init = 1){
    8000699c:	00006797          	auipc	a5,0x6
    800069a0:	17478793          	addi	a5,a5,372 # 8000cb10 <_ZTV9Semaphore+0x10>
    800069a4:	00f53023          	sd	a5,0(a0)
            sem_open(&myHandle,init);
    800069a8:	00100593          	li	a1,1
    800069ac:	00850513          	addi	a0,a0,8
    800069b0:	ffffb097          	auipc	ra,0xffffb
    800069b4:	a8c080e7          	jalr	-1396(ra) # 8000143c <_Z8sem_openPP5sem_sj>
    800069b8:	0324b823          	sd	s2,48(s1)
}
    800069bc:	02813083          	ld	ra,40(sp)
    800069c0:	02013403          	ld	s0,32(sp)
    800069c4:	01813483          	ld	s1,24(sp)
    800069c8:	01013903          	ld	s2,16(sp)
    800069cc:	00813983          	ld	s3,8(sp)
    800069d0:	03010113          	addi	sp,sp,48
    800069d4:	00008067          	ret
    800069d8:	00050493          	mv	s1,a0
    itemAvailable = new Semaphore(0);
    800069dc:	00090513          	mv	a0,s2
    800069e0:	ffffc097          	auipc	ra,0xffffc
    800069e4:	228080e7          	jalr	552(ra) # 80002c08 <_ZdlPv>
    800069e8:	00048513          	mv	a0,s1
    800069ec:	00009097          	auipc	ra,0x9
    800069f0:	90c080e7          	jalr	-1780(ra) # 8000f2f8 <_Unwind_Resume>
    800069f4:	00050493          	mv	s1,a0
    spaceAvailable = new Semaphore(_cap);
    800069f8:	00090513          	mv	a0,s2
    800069fc:	ffffc097          	auipc	ra,0xffffc
    80006a00:	20c080e7          	jalr	524(ra) # 80002c08 <_ZdlPv>
    80006a04:	00048513          	mv	a0,s1
    80006a08:	00009097          	auipc	ra,0x9
    80006a0c:	8f0080e7          	jalr	-1808(ra) # 8000f2f8 <_Unwind_Resume>
    80006a10:	00050493          	mv	s1,a0
    mutexHead = new Semaphore(1);
    80006a14:	00090513          	mv	a0,s2
    80006a18:	ffffc097          	auipc	ra,0xffffc
    80006a1c:	1f0080e7          	jalr	496(ra) # 80002c08 <_ZdlPv>
    80006a20:	00048513          	mv	a0,s1
    80006a24:	00009097          	auipc	ra,0x9
    80006a28:	8d4080e7          	jalr	-1836(ra) # 8000f2f8 <_Unwind_Resume>
    80006a2c:	00050493          	mv	s1,a0
    mutexTail = new Semaphore(1);
    80006a30:	00090513          	mv	a0,s2
    80006a34:	ffffc097          	auipc	ra,0xffffc
    80006a38:	1d4080e7          	jalr	468(ra) # 80002c08 <_ZdlPv>
    80006a3c:	00048513          	mv	a0,s1
    80006a40:	00009097          	auipc	ra,0x9
    80006a44:	8b8080e7          	jalr	-1864(ra) # 8000f2f8 <_Unwind_Resume>

0000000080006a48 <_ZN9BufferCPP3putEi>:
    delete mutexTail;
    delete mutexHead;

}

void BufferCPP::put(int val) {
    80006a48:	fe010113          	addi	sp,sp,-32
    80006a4c:	00113c23          	sd	ra,24(sp)
    80006a50:	00813823          	sd	s0,16(sp)
    80006a54:	00913423          	sd	s1,8(sp)
    80006a58:	01213023          	sd	s2,0(sp)
    80006a5c:	02010413          	addi	s0,sp,32
    80006a60:	00050493          	mv	s1,a0
    80006a64:	00058913          	mv	s2,a1
    spaceAvailable->wait();
    80006a68:	01853783          	ld	a5,24(a0)
            return sem_wait(myHandle);
    80006a6c:	0087b503          	ld	a0,8(a5)
    80006a70:	ffffb097          	auipc	ra,0xffffb
    80006a74:	a50080e7          	jalr	-1456(ra) # 800014c0 <_Z8sem_waitP5sem_s>

    mutexTail->wait();
    80006a78:	0304b783          	ld	a5,48(s1)
    80006a7c:	0087b503          	ld	a0,8(a5)
    80006a80:	ffffb097          	auipc	ra,0xffffb
    80006a84:	a40080e7          	jalr	-1472(ra) # 800014c0 <_Z8sem_waitP5sem_s>
    buffer[tail] = val;
    80006a88:	0084b783          	ld	a5,8(s1)
    80006a8c:	0144a703          	lw	a4,20(s1)
    80006a90:	00271713          	slli	a4,a4,0x2
    80006a94:	00e787b3          	add	a5,a5,a4
    80006a98:	0127a023          	sw	s2,0(a5)
    tail = (tail + 1) % cap;
    80006a9c:	0144a783          	lw	a5,20(s1)
    80006aa0:	0017879b          	addiw	a5,a5,1
    80006aa4:	0004a703          	lw	a4,0(s1)
    80006aa8:	02e7e7bb          	remw	a5,a5,a4
    80006aac:	00f4aa23          	sw	a5,20(s1)
    mutexTail->signal();
    80006ab0:	0304b783          	ld	a5,48(s1)
            return sem_signal(myHandle);
    80006ab4:	0087b503          	ld	a0,8(a5)
    80006ab8:	ffffb097          	auipc	ra,0xffffb
    80006abc:	a48080e7          	jalr	-1464(ra) # 80001500 <_Z10sem_signalP5sem_s>

    itemAvailable->signal();
    80006ac0:	0204b783          	ld	a5,32(s1)
    80006ac4:	0087b503          	ld	a0,8(a5)
    80006ac8:	ffffb097          	auipc	ra,0xffffb
    80006acc:	a38080e7          	jalr	-1480(ra) # 80001500 <_Z10sem_signalP5sem_s>

}
    80006ad0:	01813083          	ld	ra,24(sp)
    80006ad4:	01013403          	ld	s0,16(sp)
    80006ad8:	00813483          	ld	s1,8(sp)
    80006adc:	00013903          	ld	s2,0(sp)
    80006ae0:	02010113          	addi	sp,sp,32
    80006ae4:	00008067          	ret

0000000080006ae8 <_ZN9BufferCPP3getEv>:

int BufferCPP::get() {
    80006ae8:	fe010113          	addi	sp,sp,-32
    80006aec:	00113c23          	sd	ra,24(sp)
    80006af0:	00813823          	sd	s0,16(sp)
    80006af4:	00913423          	sd	s1,8(sp)
    80006af8:	01213023          	sd	s2,0(sp)
    80006afc:	02010413          	addi	s0,sp,32
    80006b00:	00050493          	mv	s1,a0
    itemAvailable->wait();
    80006b04:	02053783          	ld	a5,32(a0)
            return sem_wait(myHandle);
    80006b08:	0087b503          	ld	a0,8(a5)
    80006b0c:	ffffb097          	auipc	ra,0xffffb
    80006b10:	9b4080e7          	jalr	-1612(ra) # 800014c0 <_Z8sem_waitP5sem_s>

    mutexHead->wait();
    80006b14:	0284b783          	ld	a5,40(s1)
    80006b18:	0087b503          	ld	a0,8(a5)
    80006b1c:	ffffb097          	auipc	ra,0xffffb
    80006b20:	9a4080e7          	jalr	-1628(ra) # 800014c0 <_Z8sem_waitP5sem_s>

    int ret = buffer[head];
    80006b24:	0084b703          	ld	a4,8(s1)
    80006b28:	0104a783          	lw	a5,16(s1)
    80006b2c:	00279693          	slli	a3,a5,0x2
    80006b30:	00d70733          	add	a4,a4,a3
    80006b34:	00072903          	lw	s2,0(a4)
    head = (head + 1) % cap;
    80006b38:	0017879b          	addiw	a5,a5,1
    80006b3c:	0004a703          	lw	a4,0(s1)
    80006b40:	02e7e7bb          	remw	a5,a5,a4
    80006b44:	00f4a823          	sw	a5,16(s1)
    mutexHead->signal();
    80006b48:	0284b783          	ld	a5,40(s1)
            return sem_signal(myHandle);
    80006b4c:	0087b503          	ld	a0,8(a5)
    80006b50:	ffffb097          	auipc	ra,0xffffb
    80006b54:	9b0080e7          	jalr	-1616(ra) # 80001500 <_Z10sem_signalP5sem_s>

    spaceAvailable->signal();
    80006b58:	0184b783          	ld	a5,24(s1)
    80006b5c:	0087b503          	ld	a0,8(a5)
    80006b60:	ffffb097          	auipc	ra,0xffffb
    80006b64:	9a0080e7          	jalr	-1632(ra) # 80001500 <_Z10sem_signalP5sem_s>

    return ret;
}
    80006b68:	00090513          	mv	a0,s2
    80006b6c:	01813083          	ld	ra,24(sp)
    80006b70:	01013403          	ld	s0,16(sp)
    80006b74:	00813483          	ld	s1,8(sp)
    80006b78:	00013903          	ld	s2,0(sp)
    80006b7c:	02010113          	addi	sp,sp,32
    80006b80:	00008067          	ret

0000000080006b84 <_ZN9BufferCPP6getCntEv>:

int BufferCPP::getCnt() {
    80006b84:	fe010113          	addi	sp,sp,-32
    80006b88:	00113c23          	sd	ra,24(sp)
    80006b8c:	00813823          	sd	s0,16(sp)
    80006b90:	00913423          	sd	s1,8(sp)
    80006b94:	01213023          	sd	s2,0(sp)
    80006b98:	02010413          	addi	s0,sp,32
    80006b9c:	00050493          	mv	s1,a0
    int ret;

    mutexHead->wait();
    80006ba0:	02853783          	ld	a5,40(a0)
            return sem_wait(myHandle);
    80006ba4:	0087b503          	ld	a0,8(a5)
    80006ba8:	ffffb097          	auipc	ra,0xffffb
    80006bac:	918080e7          	jalr	-1768(ra) # 800014c0 <_Z8sem_waitP5sem_s>
    mutexTail->wait();
    80006bb0:	0304b783          	ld	a5,48(s1)
    80006bb4:	0087b503          	ld	a0,8(a5)
    80006bb8:	ffffb097          	auipc	ra,0xffffb
    80006bbc:	908080e7          	jalr	-1784(ra) # 800014c0 <_Z8sem_waitP5sem_s>

    if (tail >= head) {
    80006bc0:	0144a783          	lw	a5,20(s1)
    80006bc4:	0104a903          	lw	s2,16(s1)
    80006bc8:	0527c263          	blt	a5,s2,80006c0c <_ZN9BufferCPP6getCntEv+0x88>
        ret = tail - head;
    80006bcc:	4127893b          	subw	s2,a5,s2
    } else {
        ret = cap - head + tail;
    }

    mutexTail->signal();
    80006bd0:	0304b783          	ld	a5,48(s1)
            return sem_signal(myHandle);
    80006bd4:	0087b503          	ld	a0,8(a5)
    80006bd8:	ffffb097          	auipc	ra,0xffffb
    80006bdc:	928080e7          	jalr	-1752(ra) # 80001500 <_Z10sem_signalP5sem_s>
    mutexHead->signal();
    80006be0:	0284b783          	ld	a5,40(s1)
    80006be4:	0087b503          	ld	a0,8(a5)
    80006be8:	ffffb097          	auipc	ra,0xffffb
    80006bec:	918080e7          	jalr	-1768(ra) # 80001500 <_Z10sem_signalP5sem_s>

    return ret;
}
    80006bf0:	00090513          	mv	a0,s2
    80006bf4:	01813083          	ld	ra,24(sp)
    80006bf8:	01013403          	ld	s0,16(sp)
    80006bfc:	00813483          	ld	s1,8(sp)
    80006c00:	00013903          	ld	s2,0(sp)
    80006c04:	02010113          	addi	sp,sp,32
    80006c08:	00008067          	ret
        ret = cap - head + tail;
    80006c0c:	0004a703          	lw	a4,0(s1)
    80006c10:	4127093b          	subw	s2,a4,s2
    80006c14:	00f9093b          	addw	s2,s2,a5
    80006c18:	fb9ff06f          	j	80006bd0 <_ZN9BufferCPP6getCntEv+0x4c>

0000000080006c1c <_ZN9BufferCPPD1Ev>:
BufferCPP::~BufferCPP() {
    80006c1c:	fe010113          	addi	sp,sp,-32
    80006c20:	00113c23          	sd	ra,24(sp)
    80006c24:	00813823          	sd	s0,16(sp)
    80006c28:	00913423          	sd	s1,8(sp)
    80006c2c:	02010413          	addi	s0,sp,32
    80006c30:	00050493          	mv	s1,a0
            ::putc(c);
    80006c34:	00a00513          	li	a0,10
    80006c38:	ffffb097          	auipc	ra,0xffffb
    80006c3c:	978080e7          	jalr	-1672(ra) # 800015b0 <_Z4putcc>
    printString("Buffer deleted!\n");
    80006c40:	00004517          	auipc	a0,0x4
    80006c44:	9a050513          	addi	a0,a0,-1632 # 8000a5e0 <CONSOLE_STATUS+0x5d0>
    80006c48:	ffffb097          	auipc	ra,0xffffb
    80006c4c:	264080e7          	jalr	612(ra) # 80001eac <_Z11printStringPKc>
    while (getCnt()) {
    80006c50:	00048513          	mv	a0,s1
    80006c54:	00000097          	auipc	ra,0x0
    80006c58:	f30080e7          	jalr	-208(ra) # 80006b84 <_ZN9BufferCPP6getCntEv>
    80006c5c:	02050c63          	beqz	a0,80006c94 <_ZN9BufferCPPD1Ev+0x78>
        char ch = buffer[head];
    80006c60:	0084b783          	ld	a5,8(s1)
    80006c64:	0104a703          	lw	a4,16(s1)
    80006c68:	00271713          	slli	a4,a4,0x2
    80006c6c:	00e787b3          	add	a5,a5,a4
    80006c70:	0007c503          	lbu	a0,0(a5)
    80006c74:	ffffb097          	auipc	ra,0xffffb
    80006c78:	93c080e7          	jalr	-1732(ra) # 800015b0 <_Z4putcc>
        head = (head + 1) % cap;
    80006c7c:	0104a783          	lw	a5,16(s1)
    80006c80:	0017879b          	addiw	a5,a5,1
    80006c84:	0004a703          	lw	a4,0(s1)
    80006c88:	02e7e7bb          	remw	a5,a5,a4
    80006c8c:	00f4a823          	sw	a5,16(s1)
    while (getCnt()) {
    80006c90:	fc1ff06f          	j	80006c50 <_ZN9BufferCPPD1Ev+0x34>
    80006c94:	02100513          	li	a0,33
    80006c98:	ffffb097          	auipc	ra,0xffffb
    80006c9c:	918080e7          	jalr	-1768(ra) # 800015b0 <_Z4putcc>
    80006ca0:	00a00513          	li	a0,10
    80006ca4:	ffffb097          	auipc	ra,0xffffb
    80006ca8:	90c080e7          	jalr	-1780(ra) # 800015b0 <_Z4putcc>
    mem_free(buffer);
    80006cac:	0084b503          	ld	a0,8(s1)
    80006cb0:	ffffa097          	auipc	ra,0xffffa
    80006cb4:	610080e7          	jalr	1552(ra) # 800012c0 <_Z8mem_freePv>
    delete itemAvailable;
    80006cb8:	0204b503          	ld	a0,32(s1)
    80006cbc:	00050863          	beqz	a0,80006ccc <_ZN9BufferCPPD1Ev+0xb0>
    80006cc0:	00053783          	ld	a5,0(a0)
    80006cc4:	0087b783          	ld	a5,8(a5)
    80006cc8:	000780e7          	jalr	a5
    delete spaceAvailable;
    80006ccc:	0184b503          	ld	a0,24(s1)
    80006cd0:	00050863          	beqz	a0,80006ce0 <_ZN9BufferCPPD1Ev+0xc4>
    80006cd4:	00053783          	ld	a5,0(a0)
    80006cd8:	0087b783          	ld	a5,8(a5)
    80006cdc:	000780e7          	jalr	a5
    delete mutexTail;
    80006ce0:	0304b503          	ld	a0,48(s1)
    80006ce4:	00050863          	beqz	a0,80006cf4 <_ZN9BufferCPPD1Ev+0xd8>
    80006ce8:	00053783          	ld	a5,0(a0)
    80006cec:	0087b783          	ld	a5,8(a5)
    80006cf0:	000780e7          	jalr	a5
    delete mutexHead;
    80006cf4:	0284b503          	ld	a0,40(s1)
    80006cf8:	00050863          	beqz	a0,80006d08 <_ZN9BufferCPPD1Ev+0xec>
    80006cfc:	00053783          	ld	a5,0(a0)
    80006d00:	0087b783          	ld	a5,8(a5)
    80006d04:	000780e7          	jalr	a5
}
    80006d08:	01813083          	ld	ra,24(sp)
    80006d0c:	01013403          	ld	s0,16(sp)
    80006d10:	00813483          	ld	s1,8(sp)
    80006d14:	02010113          	addi	sp,sp,32
    80006d18:	00008067          	ret

0000000080006d1c <_Z8userMainv>:
#include "../test/ConsumerProducer_CPP_API_test.hpp"
#include "System_Mode_test.hpp"

#endif

void userMain() {
    80006d1c:	fe010113          	addi	sp,sp,-32
    80006d20:	00113c23          	sd	ra,24(sp)
    80006d24:	00813823          	sd	s0,16(sp)
    80006d28:	00913423          	sd	s1,8(sp)
    80006d2c:	02010413          	addi	s0,sp,32
    printString("Unesite broj testa? [1-7]\n");
    80006d30:	00004517          	auipc	a0,0x4
    80006d34:	8c850513          	addi	a0,a0,-1848 # 8000a5f8 <CONSOLE_STATUS+0x5e8>
    80006d38:	ffffb097          	auipc	ra,0xffffb
    80006d3c:	174080e7          	jalr	372(ra) # 80001eac <_Z11printStringPKc>
    int test = getc() - '0';
    80006d40:	ffffb097          	auipc	ra,0xffffb
    80006d44:	834080e7          	jalr	-1996(ra) # 80001574 <_Z4getcv>
    80006d48:	fd05049b          	addiw	s1,a0,-48
    getc(); // Enter posle broja
    80006d4c:	ffffb097          	auipc	ra,0xffffb
    80006d50:	828080e7          	jalr	-2008(ra) # 80001574 <_Z4getcv>
            printString("Nije navedeno da je zadatak 4 implementiran\n");
            return;
        }
    }

    switch (test) {
    80006d54:	00700793          	li	a5,7
    80006d58:	1097e263          	bltu	a5,s1,80006e5c <_Z8userMainv+0x140>
    80006d5c:	00249493          	slli	s1,s1,0x2
    80006d60:	00004717          	auipc	a4,0x4
    80006d64:	af070713          	addi	a4,a4,-1296 # 8000a850 <CONSOLE_STATUS+0x840>
    80006d68:	00e484b3          	add	s1,s1,a4
    80006d6c:	0004a783          	lw	a5,0(s1)
    80006d70:	00e787b3          	add	a5,a5,a4
    80006d74:	00078067          	jr	a5
        case 1:
#if LEVEL_2_IMPLEMENTED == 1
            Threads_C_API_test();
    80006d78:	fffff097          	auipc	ra,0xfffff
    80006d7c:	284080e7          	jalr	644(ra) # 80005ffc <_Z18Threads_C_API_testv>
            printString("TEST 1 (zadatak 2, niti C API i sinhrona promena konteksta)\n");
    80006d80:	00004517          	auipc	a0,0x4
    80006d84:	89850513          	addi	a0,a0,-1896 # 8000a618 <CONSOLE_STATUS+0x608>
    80006d88:	ffffb097          	auipc	ra,0xffffb
    80006d8c:	124080e7          	jalr	292(ra) # 80001eac <_Z11printStringPKc>
#endif
            break;
        default:
            printString("Niste uneli odgovarajuci broj za test\n");
    }
    80006d90:	01813083          	ld	ra,24(sp)
    80006d94:	01013403          	ld	s0,16(sp)
    80006d98:	00813483          	ld	s1,8(sp)
    80006d9c:	02010113          	addi	sp,sp,32
    80006da0:	00008067          	ret
            Threads_CPP_API_test();
    80006da4:	ffffe097          	auipc	ra,0xffffe
    80006da8:	2b8080e7          	jalr	696(ra) # 8000505c <_Z20Threads_CPP_API_testv>
            printString("TEST 2 (zadatak 2., niti CPP API i sinhrona promena konteksta)\n");
    80006dac:	00004517          	auipc	a0,0x4
    80006db0:	8ac50513          	addi	a0,a0,-1876 # 8000a658 <CONSOLE_STATUS+0x648>
    80006db4:	ffffb097          	auipc	ra,0xffffb
    80006db8:	0f8080e7          	jalr	248(ra) # 80001eac <_Z11printStringPKc>
            break;
    80006dbc:	fd5ff06f          	j	80006d90 <_Z8userMainv+0x74>
            producerConsumer_C_API();
    80006dc0:	ffffe097          	auipc	ra,0xffffe
    80006dc4:	af0080e7          	jalr	-1296(ra) # 800048b0 <_Z22producerConsumer_C_APIv>
            printString("TEST 3 (zadatak 3., kompletan C API sa semaforima, sinhrona promena konteksta)\n");
    80006dc8:	00004517          	auipc	a0,0x4
    80006dcc:	8d050513          	addi	a0,a0,-1840 # 8000a698 <CONSOLE_STATUS+0x688>
    80006dd0:	ffffb097          	auipc	ra,0xffffb
    80006dd4:	0dc080e7          	jalr	220(ra) # 80001eac <_Z11printStringPKc>
            break;
    80006dd8:	fb9ff06f          	j	80006d90 <_Z8userMainv+0x74>
            producerConsumer_CPP_Sync_API();
    80006ddc:	fffff097          	auipc	ra,0xfffff
    80006de0:	570080e7          	jalr	1392(ra) # 8000634c <_Z29producerConsumer_CPP_Sync_APIv>
            printString("TEST 4 (zadatak 3., kompletan CPP API sa semaforima, sinhrona promena konteksta)\n");
    80006de4:	00004517          	auipc	a0,0x4
    80006de8:	90450513          	addi	a0,a0,-1788 # 8000a6e8 <CONSOLE_STATUS+0x6d8>
    80006dec:	ffffb097          	auipc	ra,0xffffb
    80006df0:	0c0080e7          	jalr	192(ra) # 80001eac <_Z11printStringPKc>
            break;
    80006df4:	f9dff06f          	j	80006d90 <_Z8userMainv+0x74>
            testSleeping();
    80006df8:	00000097          	auipc	ra,0x0
    80006dfc:	11c080e7          	jalr	284(ra) # 80006f14 <_Z12testSleepingv>
            printString("TEST 5 (zadatak 4., thread_sleep test C API)\n");
    80006e00:	00004517          	auipc	a0,0x4
    80006e04:	94050513          	addi	a0,a0,-1728 # 8000a740 <CONSOLE_STATUS+0x730>
    80006e08:	ffffb097          	auipc	ra,0xffffb
    80006e0c:	0a4080e7          	jalr	164(ra) # 80001eac <_Z11printStringPKc>
            break;
    80006e10:	f81ff06f          	j	80006d90 <_Z8userMainv+0x74>
            testConsumerProducer();
    80006e14:	ffffe097          	auipc	ra,0xffffe
    80006e18:	5ac080e7          	jalr	1452(ra) # 800053c0 <_Z20testConsumerProducerv>
            printString("TEST 6 (zadatak 4. CPP API i asinhrona promena konteksta)\n");
    80006e1c:	00004517          	auipc	a0,0x4
    80006e20:	95450513          	addi	a0,a0,-1708 # 8000a770 <CONSOLE_STATUS+0x760>
    80006e24:	ffffb097          	auipc	ra,0xffffb
    80006e28:	088080e7          	jalr	136(ra) # 80001eac <_Z11printStringPKc>
            break;
    80006e2c:	f65ff06f          	j	80006d90 <_Z8userMainv+0x74>
            System_Mode_test();
    80006e30:	00000097          	auipc	ra,0x0
    80006e34:	658080e7          	jalr	1624(ra) # 80007488 <_Z16System_Mode_testv>
            printString("Test se nije uspesno zavrsio\n");
    80006e38:	00004517          	auipc	a0,0x4
    80006e3c:	97850513          	addi	a0,a0,-1672 # 8000a7b0 <CONSOLE_STATUS+0x7a0>
    80006e40:	ffffb097          	auipc	ra,0xffffb
    80006e44:	06c080e7          	jalr	108(ra) # 80001eac <_Z11printStringPKc>
            printString("TEST 7 (zadatak 2., testiranje da li se korisnicki kod izvrsava u korisnickom rezimu)\n");
    80006e48:	00004517          	auipc	a0,0x4
    80006e4c:	98850513          	addi	a0,a0,-1656 # 8000a7d0 <CONSOLE_STATUS+0x7c0>
    80006e50:	ffffb097          	auipc	ra,0xffffb
    80006e54:	05c080e7          	jalr	92(ra) # 80001eac <_Z11printStringPKc>
            break;
    80006e58:	f39ff06f          	j	80006d90 <_Z8userMainv+0x74>
            printString("Niste uneli odgovarajuci broj za test\n");
    80006e5c:	00004517          	auipc	a0,0x4
    80006e60:	9cc50513          	addi	a0,a0,-1588 # 8000a828 <CONSOLE_STATUS+0x818>
    80006e64:	ffffb097          	auipc	ra,0xffffb
    80006e68:	048080e7          	jalr	72(ra) # 80001eac <_Z11printStringPKc>
    80006e6c:	f25ff06f          	j	80006d90 <_Z8userMainv+0x74>

0000000080006e70 <_ZL9sleepyRunPv>:

#include "../h/printing.hpp"

static volatile bool finished[2];

static void sleepyRun(void *arg) {
    80006e70:	fe010113          	addi	sp,sp,-32
    80006e74:	00113c23          	sd	ra,24(sp)
    80006e78:	00813823          	sd	s0,16(sp)
    80006e7c:	00913423          	sd	s1,8(sp)
    80006e80:	01213023          	sd	s2,0(sp)
    80006e84:	02010413          	addi	s0,sp,32
    uint64 sleep_time = *((uint64 *) arg);
    80006e88:	00053903          	ld	s2,0(a0)
    int i = 6;
    80006e8c:	00600493          	li	s1,6
    while (--i > 0) {
    80006e90:	fff4849b          	addiw	s1,s1,-1
    80006e94:	04905463          	blez	s1,80006edc <_ZL9sleepyRunPv+0x6c>

        printString("Hello ");
    80006e98:	00004517          	auipc	a0,0x4
    80006e9c:	9d850513          	addi	a0,a0,-1576 # 8000a870 <CONSOLE_STATUS+0x860>
    80006ea0:	ffffb097          	auipc	ra,0xffffb
    80006ea4:	00c080e7          	jalr	12(ra) # 80001eac <_Z11printStringPKc>
        printInt(sleep_time);
    80006ea8:	00000613          	li	a2,0
    80006eac:	00a00593          	li	a1,10
    80006eb0:	0009051b          	sext.w	a0,s2
    80006eb4:	ffffb097          	auipc	ra,0xffffb
    80006eb8:	1a8080e7          	jalr	424(ra) # 8000205c <_Z8printIntiii>
        printString(" !\n");
    80006ebc:	00004517          	auipc	a0,0x4
    80006ec0:	9bc50513          	addi	a0,a0,-1604 # 8000a878 <CONSOLE_STATUS+0x868>
    80006ec4:	ffffb097          	auipc	ra,0xffffb
    80006ec8:	fe8080e7          	jalr	-24(ra) # 80001eac <_Z11printStringPKc>
        time_sleep(sleep_time);
    80006ecc:	00090513          	mv	a0,s2
    80006ed0:	ffffa097          	auipc	ra,0xffffa
    80006ed4:	670080e7          	jalr	1648(ra) # 80001540 <_Z10time_sleepm>
    while (--i > 0) {
    80006ed8:	fb9ff06f          	j	80006e90 <_ZL9sleepyRunPv+0x20>
    }
    finished[sleep_time/10-1] = true;
    80006edc:	00a00793          	li	a5,10
    80006ee0:	02f95933          	divu	s2,s2,a5
    80006ee4:	fff90913          	addi	s2,s2,-1
    80006ee8:	00007797          	auipc	a5,0x7
    80006eec:	34078793          	addi	a5,a5,832 # 8000e228 <_ZL8finished>
    80006ef0:	01278933          	add	s2,a5,s2
    80006ef4:	00100793          	li	a5,1
    80006ef8:	00f90023          	sb	a5,0(s2)
}
    80006efc:	01813083          	ld	ra,24(sp)
    80006f00:	01013403          	ld	s0,16(sp)
    80006f04:	00813483          	ld	s1,8(sp)
    80006f08:	00013903          	ld	s2,0(sp)
    80006f0c:	02010113          	addi	sp,sp,32
    80006f10:	00008067          	ret

0000000080006f14 <_Z12testSleepingv>:

void testSleeping() {
    80006f14:	fc010113          	addi	sp,sp,-64
    80006f18:	02113c23          	sd	ra,56(sp)
    80006f1c:	02813823          	sd	s0,48(sp)
    80006f20:	02913423          	sd	s1,40(sp)
    80006f24:	04010413          	addi	s0,sp,64
    const int sleepy_thread_count = 2;
    uint64 sleep_times[sleepy_thread_count] = {10, 20};
    80006f28:	00a00793          	li	a5,10
    80006f2c:	fcf43823          	sd	a5,-48(s0)
    80006f30:	01400793          	li	a5,20
    80006f34:	fcf43c23          	sd	a5,-40(s0)
    thread_t sleepyThread[sleepy_thread_count];

    for (int i = 0; i < sleepy_thread_count; i++) {
    80006f38:	00000493          	li	s1,0
    80006f3c:	02c0006f          	j	80006f68 <_Z12testSleepingv+0x54>
        thread_create(&sleepyThread[i], sleepyRun, sleep_times + i);
    80006f40:	00349793          	slli	a5,s1,0x3
    80006f44:	fd040613          	addi	a2,s0,-48
    80006f48:	00f60633          	add	a2,a2,a5
    80006f4c:	00000597          	auipc	a1,0x0
    80006f50:	f2458593          	addi	a1,a1,-220 # 80006e70 <_ZL9sleepyRunPv>
    80006f54:	fc040513          	addi	a0,s0,-64
    80006f58:	00f50533          	add	a0,a0,a5
    80006f5c:	ffffa097          	auipc	ra,0xffffa
    80006f60:	3a4080e7          	jalr	932(ra) # 80001300 <_Z13thread_createPP8thread_sPFvPvES2_>
    for (int i = 0; i < sleepy_thread_count; i++) {
    80006f64:	0014849b          	addiw	s1,s1,1
    80006f68:	00100793          	li	a5,1
    80006f6c:	fc97dae3          	bge	a5,s1,80006f40 <_Z12testSleepingv+0x2c>
    }

    while (!(finished[0] && finished[1])) {}
    80006f70:	00007797          	auipc	a5,0x7
    80006f74:	2b87c783          	lbu	a5,696(a5) # 8000e228 <_ZL8finished>
    80006f78:	fe078ce3          	beqz	a5,80006f70 <_Z12testSleepingv+0x5c>
    80006f7c:	00007797          	auipc	a5,0x7
    80006f80:	2ad7c783          	lbu	a5,685(a5) # 8000e229 <_ZL8finished+0x1>
    80006f84:	fe0786e3          	beqz	a5,80006f70 <_Z12testSleepingv+0x5c>
}
    80006f88:	03813083          	ld	ra,56(sp)
    80006f8c:	03013403          	ld	s0,48(sp)
    80006f90:	02813483          	ld	s1,40(sp)
    80006f94:	04010113          	addi	sp,sp,64
    80006f98:	00008067          	ret

0000000080006f9c <_ZL9fibonaccim>:
static volatile bool finishedA = false;
static volatile bool finishedB = false;
static volatile bool finishedC = false;
static volatile bool finishedD = false;

static uint64 fibonacci(uint64 n) {
    80006f9c:	fe010113          	addi	sp,sp,-32
    80006fa0:	00113c23          	sd	ra,24(sp)
    80006fa4:	00813823          	sd	s0,16(sp)
    80006fa8:	00913423          	sd	s1,8(sp)
    80006fac:	01213023          	sd	s2,0(sp)
    80006fb0:	02010413          	addi	s0,sp,32
    80006fb4:	00050493          	mv	s1,a0
    if (n == 0 || n == 1) { return n; }
    80006fb8:	00100793          	li	a5,1
    80006fbc:	02a7f863          	bgeu	a5,a0,80006fec <_ZL9fibonaccim+0x50>
    if (n % 10 == 0) { thread_dispatch(); }
    80006fc0:	00a00793          	li	a5,10
    80006fc4:	02f577b3          	remu	a5,a0,a5
    80006fc8:	02078e63          	beqz	a5,80007004 <_ZL9fibonaccim+0x68>
    return fibonacci(n - 1) + fibonacci(n - 2);
    80006fcc:	fff48513          	addi	a0,s1,-1
    80006fd0:	00000097          	auipc	ra,0x0
    80006fd4:	fcc080e7          	jalr	-52(ra) # 80006f9c <_ZL9fibonaccim>
    80006fd8:	00050913          	mv	s2,a0
    80006fdc:	ffe48513          	addi	a0,s1,-2
    80006fe0:	00000097          	auipc	ra,0x0
    80006fe4:	fbc080e7          	jalr	-68(ra) # 80006f9c <_ZL9fibonaccim>
    80006fe8:	00a90533          	add	a0,s2,a0
}
    80006fec:	01813083          	ld	ra,24(sp)
    80006ff0:	01013403          	ld	s0,16(sp)
    80006ff4:	00813483          	ld	s1,8(sp)
    80006ff8:	00013903          	ld	s2,0(sp)
    80006ffc:	02010113          	addi	sp,sp,32
    80007000:	00008067          	ret
    if (n % 10 == 0) { thread_dispatch(); }
    80007004:	ffffa097          	auipc	ra,0xffffa
    80007008:	384080e7          	jalr	900(ra) # 80001388 <_Z15thread_dispatchv>
    8000700c:	fc1ff06f          	j	80006fcc <_ZL9fibonaccim+0x30>

0000000080007010 <_ZL11workerBodyDPv>:
    printString("A finished!\n");
    finishedC = true;
    thread_dispatch();
}

static void workerBodyD(void* arg) {
    80007010:	fe010113          	addi	sp,sp,-32
    80007014:	00113c23          	sd	ra,24(sp)
    80007018:	00813823          	sd	s0,16(sp)
    8000701c:	00913423          	sd	s1,8(sp)
    80007020:	01213023          	sd	s2,0(sp)
    80007024:	02010413          	addi	s0,sp,32
    uint8 i = 10;
    80007028:	00a00493          	li	s1,10
    8000702c:	0400006f          	j	8000706c <_ZL11workerBodyDPv+0x5c>
    for (; i < 13; i++) {
        printString("D: i="); printInt(i); printString("\n");
    80007030:	00003517          	auipc	a0,0x3
    80007034:	51850513          	addi	a0,a0,1304 # 8000a548 <CONSOLE_STATUS+0x538>
    80007038:	ffffb097          	auipc	ra,0xffffb
    8000703c:	e74080e7          	jalr	-396(ra) # 80001eac <_Z11printStringPKc>
    80007040:	00000613          	li	a2,0
    80007044:	00a00593          	li	a1,10
    80007048:	00048513          	mv	a0,s1
    8000704c:	ffffb097          	auipc	ra,0xffffb
    80007050:	010080e7          	jalr	16(ra) # 8000205c <_Z8printIntiii>
    80007054:	00003517          	auipc	a0,0x3
    80007058:	6e450513          	addi	a0,a0,1764 # 8000a738 <CONSOLE_STATUS+0x728>
    8000705c:	ffffb097          	auipc	ra,0xffffb
    80007060:	e50080e7          	jalr	-432(ra) # 80001eac <_Z11printStringPKc>
    for (; i < 13; i++) {
    80007064:	0014849b          	addiw	s1,s1,1
    80007068:	0ff4f493          	andi	s1,s1,255
    8000706c:	00c00793          	li	a5,12
    80007070:	fc97f0e3          	bgeu	a5,s1,80007030 <_ZL11workerBodyDPv+0x20>
    }

    printString("D: dispatch\n");
    80007074:	00003517          	auipc	a0,0x3
    80007078:	4dc50513          	addi	a0,a0,1244 # 8000a550 <CONSOLE_STATUS+0x540>
    8000707c:	ffffb097          	auipc	ra,0xffffb
    80007080:	e30080e7          	jalr	-464(ra) # 80001eac <_Z11printStringPKc>
    __asm__ ("li t1, 5");
    80007084:	00500313          	li	t1,5
    thread_dispatch();
    80007088:	ffffa097          	auipc	ra,0xffffa
    8000708c:	300080e7          	jalr	768(ra) # 80001388 <_Z15thread_dispatchv>

    uint64 result = fibonacci(16);
    80007090:	01000513          	li	a0,16
    80007094:	00000097          	auipc	ra,0x0
    80007098:	f08080e7          	jalr	-248(ra) # 80006f9c <_ZL9fibonaccim>
    8000709c:	00050913          	mv	s2,a0
    printString("D: fibonaci="); printInt(result); printString("\n");
    800070a0:	00003517          	auipc	a0,0x3
    800070a4:	4c050513          	addi	a0,a0,1216 # 8000a560 <CONSOLE_STATUS+0x550>
    800070a8:	ffffb097          	auipc	ra,0xffffb
    800070ac:	e04080e7          	jalr	-508(ra) # 80001eac <_Z11printStringPKc>
    800070b0:	00000613          	li	a2,0
    800070b4:	00a00593          	li	a1,10
    800070b8:	0009051b          	sext.w	a0,s2
    800070bc:	ffffb097          	auipc	ra,0xffffb
    800070c0:	fa0080e7          	jalr	-96(ra) # 8000205c <_Z8printIntiii>
    800070c4:	00003517          	auipc	a0,0x3
    800070c8:	67450513          	addi	a0,a0,1652 # 8000a738 <CONSOLE_STATUS+0x728>
    800070cc:	ffffb097          	auipc	ra,0xffffb
    800070d0:	de0080e7          	jalr	-544(ra) # 80001eac <_Z11printStringPKc>
    800070d4:	0400006f          	j	80007114 <_ZL11workerBodyDPv+0x104>

    for (; i < 16; i++) {
        printString("D: i="); printInt(i); printString("\n");
    800070d8:	00003517          	auipc	a0,0x3
    800070dc:	47050513          	addi	a0,a0,1136 # 8000a548 <CONSOLE_STATUS+0x538>
    800070e0:	ffffb097          	auipc	ra,0xffffb
    800070e4:	dcc080e7          	jalr	-564(ra) # 80001eac <_Z11printStringPKc>
    800070e8:	00000613          	li	a2,0
    800070ec:	00a00593          	li	a1,10
    800070f0:	00048513          	mv	a0,s1
    800070f4:	ffffb097          	auipc	ra,0xffffb
    800070f8:	f68080e7          	jalr	-152(ra) # 8000205c <_Z8printIntiii>
    800070fc:	00003517          	auipc	a0,0x3
    80007100:	63c50513          	addi	a0,a0,1596 # 8000a738 <CONSOLE_STATUS+0x728>
    80007104:	ffffb097          	auipc	ra,0xffffb
    80007108:	da8080e7          	jalr	-600(ra) # 80001eac <_Z11printStringPKc>
    for (; i < 16; i++) {
    8000710c:	0014849b          	addiw	s1,s1,1
    80007110:	0ff4f493          	andi	s1,s1,255
    80007114:	00f00793          	li	a5,15
    80007118:	fc97f0e3          	bgeu	a5,s1,800070d8 <_ZL11workerBodyDPv+0xc8>
    }

    printString("D finished!\n");
    8000711c:	00003517          	auipc	a0,0x3
    80007120:	45450513          	addi	a0,a0,1108 # 8000a570 <CONSOLE_STATUS+0x560>
    80007124:	ffffb097          	auipc	ra,0xffffb
    80007128:	d88080e7          	jalr	-632(ra) # 80001eac <_Z11printStringPKc>
    finishedD = true;
    8000712c:	00100793          	li	a5,1
    80007130:	00007717          	auipc	a4,0x7
    80007134:	0ef70d23          	sb	a5,250(a4) # 8000e22a <_ZL9finishedD>
    thread_dispatch();
    80007138:	ffffa097          	auipc	ra,0xffffa
    8000713c:	250080e7          	jalr	592(ra) # 80001388 <_Z15thread_dispatchv>
}
    80007140:	01813083          	ld	ra,24(sp)
    80007144:	01013403          	ld	s0,16(sp)
    80007148:	00813483          	ld	s1,8(sp)
    8000714c:	00013903          	ld	s2,0(sp)
    80007150:	02010113          	addi	sp,sp,32
    80007154:	00008067          	ret

0000000080007158 <_ZL11workerBodyCPv>:
static void workerBodyC(void* arg) {
    80007158:	fe010113          	addi	sp,sp,-32
    8000715c:	00113c23          	sd	ra,24(sp)
    80007160:	00813823          	sd	s0,16(sp)
    80007164:	00913423          	sd	s1,8(sp)
    80007168:	01213023          	sd	s2,0(sp)
    8000716c:	02010413          	addi	s0,sp,32
    uint8 i = 0;
    80007170:	00000493          	li	s1,0
    80007174:	0400006f          	j	800071b4 <_ZL11workerBodyCPv+0x5c>
        printString("C: i="); printInt(i); printString("\n");
    80007178:	00003517          	auipc	a0,0x3
    8000717c:	3a050513          	addi	a0,a0,928 # 8000a518 <CONSOLE_STATUS+0x508>
    80007180:	ffffb097          	auipc	ra,0xffffb
    80007184:	d2c080e7          	jalr	-724(ra) # 80001eac <_Z11printStringPKc>
    80007188:	00000613          	li	a2,0
    8000718c:	00a00593          	li	a1,10
    80007190:	00048513          	mv	a0,s1
    80007194:	ffffb097          	auipc	ra,0xffffb
    80007198:	ec8080e7          	jalr	-312(ra) # 8000205c <_Z8printIntiii>
    8000719c:	00003517          	auipc	a0,0x3
    800071a0:	59c50513          	addi	a0,a0,1436 # 8000a738 <CONSOLE_STATUS+0x728>
    800071a4:	ffffb097          	auipc	ra,0xffffb
    800071a8:	d08080e7          	jalr	-760(ra) # 80001eac <_Z11printStringPKc>
    for (; i < 3; i++) {
    800071ac:	0014849b          	addiw	s1,s1,1
    800071b0:	0ff4f493          	andi	s1,s1,255
    800071b4:	00200793          	li	a5,2
    800071b8:	fc97f0e3          	bgeu	a5,s1,80007178 <_ZL11workerBodyCPv+0x20>
    printString("C: dispatch\n");
    800071bc:	00003517          	auipc	a0,0x3
    800071c0:	36450513          	addi	a0,a0,868 # 8000a520 <CONSOLE_STATUS+0x510>
    800071c4:	ffffb097          	auipc	ra,0xffffb
    800071c8:	ce8080e7          	jalr	-792(ra) # 80001eac <_Z11printStringPKc>
    __asm__ ("li t1, 7");
    800071cc:	00700313          	li	t1,7
    thread_dispatch();
    800071d0:	ffffa097          	auipc	ra,0xffffa
    800071d4:	1b8080e7          	jalr	440(ra) # 80001388 <_Z15thread_dispatchv>
    __asm__ ("mv %[t1], t1" : [t1] "=r"(t1));
    800071d8:	00030913          	mv	s2,t1
    printString("C: t1="); printInt(t1); printString("\n");
    800071dc:	00003517          	auipc	a0,0x3
    800071e0:	35450513          	addi	a0,a0,852 # 8000a530 <CONSOLE_STATUS+0x520>
    800071e4:	ffffb097          	auipc	ra,0xffffb
    800071e8:	cc8080e7          	jalr	-824(ra) # 80001eac <_Z11printStringPKc>
    800071ec:	00000613          	li	a2,0
    800071f0:	00a00593          	li	a1,10
    800071f4:	0009051b          	sext.w	a0,s2
    800071f8:	ffffb097          	auipc	ra,0xffffb
    800071fc:	e64080e7          	jalr	-412(ra) # 8000205c <_Z8printIntiii>
    80007200:	00003517          	auipc	a0,0x3
    80007204:	53850513          	addi	a0,a0,1336 # 8000a738 <CONSOLE_STATUS+0x728>
    80007208:	ffffb097          	auipc	ra,0xffffb
    8000720c:	ca4080e7          	jalr	-860(ra) # 80001eac <_Z11printStringPKc>
    uint64 result = fibonacci(12);
    80007210:	00c00513          	li	a0,12
    80007214:	00000097          	auipc	ra,0x0
    80007218:	d88080e7          	jalr	-632(ra) # 80006f9c <_ZL9fibonaccim>
    8000721c:	00050913          	mv	s2,a0
    printString("C: fibonaci="); printInt(result); printString("\n");
    80007220:	00003517          	auipc	a0,0x3
    80007224:	31850513          	addi	a0,a0,792 # 8000a538 <CONSOLE_STATUS+0x528>
    80007228:	ffffb097          	auipc	ra,0xffffb
    8000722c:	c84080e7          	jalr	-892(ra) # 80001eac <_Z11printStringPKc>
    80007230:	00000613          	li	a2,0
    80007234:	00a00593          	li	a1,10
    80007238:	0009051b          	sext.w	a0,s2
    8000723c:	ffffb097          	auipc	ra,0xffffb
    80007240:	e20080e7          	jalr	-480(ra) # 8000205c <_Z8printIntiii>
    80007244:	00003517          	auipc	a0,0x3
    80007248:	4f450513          	addi	a0,a0,1268 # 8000a738 <CONSOLE_STATUS+0x728>
    8000724c:	ffffb097          	auipc	ra,0xffffb
    80007250:	c60080e7          	jalr	-928(ra) # 80001eac <_Z11printStringPKc>
    80007254:	0400006f          	j	80007294 <_ZL11workerBodyCPv+0x13c>
        printString("C: i="); printInt(i); printString("\n");
    80007258:	00003517          	auipc	a0,0x3
    8000725c:	2c050513          	addi	a0,a0,704 # 8000a518 <CONSOLE_STATUS+0x508>
    80007260:	ffffb097          	auipc	ra,0xffffb
    80007264:	c4c080e7          	jalr	-948(ra) # 80001eac <_Z11printStringPKc>
    80007268:	00000613          	li	a2,0
    8000726c:	00a00593          	li	a1,10
    80007270:	00048513          	mv	a0,s1
    80007274:	ffffb097          	auipc	ra,0xffffb
    80007278:	de8080e7          	jalr	-536(ra) # 8000205c <_Z8printIntiii>
    8000727c:	00003517          	auipc	a0,0x3
    80007280:	4bc50513          	addi	a0,a0,1212 # 8000a738 <CONSOLE_STATUS+0x728>
    80007284:	ffffb097          	auipc	ra,0xffffb
    80007288:	c28080e7          	jalr	-984(ra) # 80001eac <_Z11printStringPKc>
    for (; i < 6; i++) {
    8000728c:	0014849b          	addiw	s1,s1,1
    80007290:	0ff4f493          	andi	s1,s1,255
    80007294:	00500793          	li	a5,5
    80007298:	fc97f0e3          	bgeu	a5,s1,80007258 <_ZL11workerBodyCPv+0x100>
    printString("A finished!\n");
    8000729c:	00003517          	auipc	a0,0x3
    800072a0:	25450513          	addi	a0,a0,596 # 8000a4f0 <CONSOLE_STATUS+0x4e0>
    800072a4:	ffffb097          	auipc	ra,0xffffb
    800072a8:	c08080e7          	jalr	-1016(ra) # 80001eac <_Z11printStringPKc>
    finishedC = true;
    800072ac:	00100793          	li	a5,1
    800072b0:	00007717          	auipc	a4,0x7
    800072b4:	f6f70da3          	sb	a5,-133(a4) # 8000e22b <_ZL9finishedC>
    thread_dispatch();
    800072b8:	ffffa097          	auipc	ra,0xffffa
    800072bc:	0d0080e7          	jalr	208(ra) # 80001388 <_Z15thread_dispatchv>
}
    800072c0:	01813083          	ld	ra,24(sp)
    800072c4:	01013403          	ld	s0,16(sp)
    800072c8:	00813483          	ld	s1,8(sp)
    800072cc:	00013903          	ld	s2,0(sp)
    800072d0:	02010113          	addi	sp,sp,32
    800072d4:	00008067          	ret

00000000800072d8 <_ZL11workerBodyBPv>:
static void workerBodyB(void* arg) {
    800072d8:	fe010113          	addi	sp,sp,-32
    800072dc:	00113c23          	sd	ra,24(sp)
    800072e0:	00813823          	sd	s0,16(sp)
    800072e4:	00913423          	sd	s1,8(sp)
    800072e8:	01213023          	sd	s2,0(sp)
    800072ec:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 16; i++) {
    800072f0:	00000913          	li	s2,0
    800072f4:	0400006f          	j	80007334 <_ZL11workerBodyBPv+0x5c>
            thread_dispatch();
    800072f8:	ffffa097          	auipc	ra,0xffffa
    800072fc:	090080e7          	jalr	144(ra) # 80001388 <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++) {
    80007300:	00148493          	addi	s1,s1,1
    80007304:	000027b7          	lui	a5,0x2
    80007308:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    8000730c:	0097ee63          	bltu	a5,s1,80007328 <_ZL11workerBodyBPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    80007310:	00000713          	li	a4,0
    80007314:	000077b7          	lui	a5,0x7
    80007318:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    8000731c:	fce7eee3          	bltu	a5,a4,800072f8 <_ZL11workerBodyBPv+0x20>
    80007320:	00170713          	addi	a4,a4,1
    80007324:	ff1ff06f          	j	80007314 <_ZL11workerBodyBPv+0x3c>
        if (i == 10) {
    80007328:	00a00793          	li	a5,10
    8000732c:	04f90663          	beq	s2,a5,80007378 <_ZL11workerBodyBPv+0xa0>
    for (uint64 i = 0; i < 16; i++) {
    80007330:	00190913          	addi	s2,s2,1
    80007334:	00f00793          	li	a5,15
    80007338:	0527e463          	bltu	a5,s2,80007380 <_ZL11workerBodyBPv+0xa8>
        printString("B: i="); printInt(i); printString("\n");
    8000733c:	00003517          	auipc	a0,0x3
    80007340:	1c450513          	addi	a0,a0,452 # 8000a500 <CONSOLE_STATUS+0x4f0>
    80007344:	ffffb097          	auipc	ra,0xffffb
    80007348:	b68080e7          	jalr	-1176(ra) # 80001eac <_Z11printStringPKc>
    8000734c:	00000613          	li	a2,0
    80007350:	00a00593          	li	a1,10
    80007354:	0009051b          	sext.w	a0,s2
    80007358:	ffffb097          	auipc	ra,0xffffb
    8000735c:	d04080e7          	jalr	-764(ra) # 8000205c <_Z8printIntiii>
    80007360:	00003517          	auipc	a0,0x3
    80007364:	3d850513          	addi	a0,a0,984 # 8000a738 <CONSOLE_STATUS+0x728>
    80007368:	ffffb097          	auipc	ra,0xffffb
    8000736c:	b44080e7          	jalr	-1212(ra) # 80001eac <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    80007370:	00000493          	li	s1,0
    80007374:	f91ff06f          	j	80007304 <_ZL11workerBodyBPv+0x2c>
            asm volatile("csrr t6, sepc");
    80007378:	14102ff3          	csrr	t6,sepc
    8000737c:	fb5ff06f          	j	80007330 <_ZL11workerBodyBPv+0x58>
    printString("B finished!\n");
    80007380:	00003517          	auipc	a0,0x3
    80007384:	18850513          	addi	a0,a0,392 # 8000a508 <CONSOLE_STATUS+0x4f8>
    80007388:	ffffb097          	auipc	ra,0xffffb
    8000738c:	b24080e7          	jalr	-1244(ra) # 80001eac <_Z11printStringPKc>
    finishedB = true;
    80007390:	00100793          	li	a5,1
    80007394:	00007717          	auipc	a4,0x7
    80007398:	e8f70c23          	sb	a5,-360(a4) # 8000e22c <_ZL9finishedB>
    thread_dispatch();
    8000739c:	ffffa097          	auipc	ra,0xffffa
    800073a0:	fec080e7          	jalr	-20(ra) # 80001388 <_Z15thread_dispatchv>
}
    800073a4:	01813083          	ld	ra,24(sp)
    800073a8:	01013403          	ld	s0,16(sp)
    800073ac:	00813483          	ld	s1,8(sp)
    800073b0:	00013903          	ld	s2,0(sp)
    800073b4:	02010113          	addi	sp,sp,32
    800073b8:	00008067          	ret

00000000800073bc <_ZL11workerBodyAPv>:
static void workerBodyA(void* arg) {
    800073bc:	fe010113          	addi	sp,sp,-32
    800073c0:	00113c23          	sd	ra,24(sp)
    800073c4:	00813823          	sd	s0,16(sp)
    800073c8:	00913423          	sd	s1,8(sp)
    800073cc:	01213023          	sd	s2,0(sp)
    800073d0:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 10; i++) {
    800073d4:	00000913          	li	s2,0
    800073d8:	0380006f          	j	80007410 <_ZL11workerBodyAPv+0x54>
            thread_dispatch();
    800073dc:	ffffa097          	auipc	ra,0xffffa
    800073e0:	fac080e7          	jalr	-84(ra) # 80001388 <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++) {
    800073e4:	00148493          	addi	s1,s1,1
    800073e8:	000027b7          	lui	a5,0x2
    800073ec:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    800073f0:	0097ee63          	bltu	a5,s1,8000740c <_ZL11workerBodyAPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    800073f4:	00000713          	li	a4,0
    800073f8:	000077b7          	lui	a5,0x7
    800073fc:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    80007400:	fce7eee3          	bltu	a5,a4,800073dc <_ZL11workerBodyAPv+0x20>
    80007404:	00170713          	addi	a4,a4,1
    80007408:	ff1ff06f          	j	800073f8 <_ZL11workerBodyAPv+0x3c>
    for (uint64 i = 0; i < 10; i++) {
    8000740c:	00190913          	addi	s2,s2,1
    80007410:	00900793          	li	a5,9
    80007414:	0527e063          	bltu	a5,s2,80007454 <_ZL11workerBodyAPv+0x98>
        printString("A: i="); printInt(i); printString("\n");
    80007418:	00003517          	auipc	a0,0x3
    8000741c:	0d050513          	addi	a0,a0,208 # 8000a4e8 <CONSOLE_STATUS+0x4d8>
    80007420:	ffffb097          	auipc	ra,0xffffb
    80007424:	a8c080e7          	jalr	-1396(ra) # 80001eac <_Z11printStringPKc>
    80007428:	00000613          	li	a2,0
    8000742c:	00a00593          	li	a1,10
    80007430:	0009051b          	sext.w	a0,s2
    80007434:	ffffb097          	auipc	ra,0xffffb
    80007438:	c28080e7          	jalr	-984(ra) # 8000205c <_Z8printIntiii>
    8000743c:	00003517          	auipc	a0,0x3
    80007440:	2fc50513          	addi	a0,a0,764 # 8000a738 <CONSOLE_STATUS+0x728>
    80007444:	ffffb097          	auipc	ra,0xffffb
    80007448:	a68080e7          	jalr	-1432(ra) # 80001eac <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    8000744c:	00000493          	li	s1,0
    80007450:	f99ff06f          	j	800073e8 <_ZL11workerBodyAPv+0x2c>
    printString("A finished!\n");
    80007454:	00003517          	auipc	a0,0x3
    80007458:	09c50513          	addi	a0,a0,156 # 8000a4f0 <CONSOLE_STATUS+0x4e0>
    8000745c:	ffffb097          	auipc	ra,0xffffb
    80007460:	a50080e7          	jalr	-1456(ra) # 80001eac <_Z11printStringPKc>
    finishedA = true;
    80007464:	00100793          	li	a5,1
    80007468:	00007717          	auipc	a4,0x7
    8000746c:	dcf702a3          	sb	a5,-571(a4) # 8000e22d <_ZL9finishedA>
}
    80007470:	01813083          	ld	ra,24(sp)
    80007474:	01013403          	ld	s0,16(sp)
    80007478:	00813483          	ld	s1,8(sp)
    8000747c:	00013903          	ld	s2,0(sp)
    80007480:	02010113          	addi	sp,sp,32
    80007484:	00008067          	ret

0000000080007488 <_Z16System_Mode_testv>:


void System_Mode_test() {
    80007488:	fd010113          	addi	sp,sp,-48
    8000748c:	02113423          	sd	ra,40(sp)
    80007490:	02813023          	sd	s0,32(sp)
    80007494:	03010413          	addi	s0,sp,48
    thread_t threads[4];
    thread_create(&threads[0], workerBodyA, nullptr);
    80007498:	00000613          	li	a2,0
    8000749c:	00000597          	auipc	a1,0x0
    800074a0:	f2058593          	addi	a1,a1,-224 # 800073bc <_ZL11workerBodyAPv>
    800074a4:	fd040513          	addi	a0,s0,-48
    800074a8:	ffffa097          	auipc	ra,0xffffa
    800074ac:	e58080e7          	jalr	-424(ra) # 80001300 <_Z13thread_createPP8thread_sPFvPvES2_>
    printString("ThreadA created\n");
    800074b0:	00003517          	auipc	a0,0x3
    800074b4:	0d050513          	addi	a0,a0,208 # 8000a580 <CONSOLE_STATUS+0x570>
    800074b8:	ffffb097          	auipc	ra,0xffffb
    800074bc:	9f4080e7          	jalr	-1548(ra) # 80001eac <_Z11printStringPKc>

    thread_create(&threads[1], workerBodyB, nullptr);
    800074c0:	00000613          	li	a2,0
    800074c4:	00000597          	auipc	a1,0x0
    800074c8:	e1458593          	addi	a1,a1,-492 # 800072d8 <_ZL11workerBodyBPv>
    800074cc:	fd840513          	addi	a0,s0,-40
    800074d0:	ffffa097          	auipc	ra,0xffffa
    800074d4:	e30080e7          	jalr	-464(ra) # 80001300 <_Z13thread_createPP8thread_sPFvPvES2_>
    printString("ThreadB created\n");
    800074d8:	00003517          	auipc	a0,0x3
    800074dc:	0c050513          	addi	a0,a0,192 # 8000a598 <CONSOLE_STATUS+0x588>
    800074e0:	ffffb097          	auipc	ra,0xffffb
    800074e4:	9cc080e7          	jalr	-1588(ra) # 80001eac <_Z11printStringPKc>

    thread_create(&threads[2], workerBodyC, nullptr);
    800074e8:	00000613          	li	a2,0
    800074ec:	00000597          	auipc	a1,0x0
    800074f0:	c6c58593          	addi	a1,a1,-916 # 80007158 <_ZL11workerBodyCPv>
    800074f4:	fe040513          	addi	a0,s0,-32
    800074f8:	ffffa097          	auipc	ra,0xffffa
    800074fc:	e08080e7          	jalr	-504(ra) # 80001300 <_Z13thread_createPP8thread_sPFvPvES2_>
    printString("ThreadC created\n");
    80007500:	00003517          	auipc	a0,0x3
    80007504:	0b050513          	addi	a0,a0,176 # 8000a5b0 <CONSOLE_STATUS+0x5a0>
    80007508:	ffffb097          	auipc	ra,0xffffb
    8000750c:	9a4080e7          	jalr	-1628(ra) # 80001eac <_Z11printStringPKc>

    thread_create(&threads[3], workerBodyD, nullptr);
    80007510:	00000613          	li	a2,0
    80007514:	00000597          	auipc	a1,0x0
    80007518:	afc58593          	addi	a1,a1,-1284 # 80007010 <_ZL11workerBodyDPv>
    8000751c:	fe840513          	addi	a0,s0,-24
    80007520:	ffffa097          	auipc	ra,0xffffa
    80007524:	de0080e7          	jalr	-544(ra) # 80001300 <_Z13thread_createPP8thread_sPFvPvES2_>
    printString("ThreadD created\n");
    80007528:	00003517          	auipc	a0,0x3
    8000752c:	0a050513          	addi	a0,a0,160 # 8000a5c8 <CONSOLE_STATUS+0x5b8>
    80007530:	ffffb097          	auipc	ra,0xffffb
    80007534:	97c080e7          	jalr	-1668(ra) # 80001eac <_Z11printStringPKc>
    80007538:	00c0006f          	j	80007544 <_Z16System_Mode_testv+0xbc>

    while (!(finishedA && finishedB && finishedC && finishedD)) {
        thread_dispatch();
    8000753c:	ffffa097          	auipc	ra,0xffffa
    80007540:	e4c080e7          	jalr	-436(ra) # 80001388 <_Z15thread_dispatchv>
    while (!(finishedA && finishedB && finishedC && finishedD)) {
    80007544:	00007797          	auipc	a5,0x7
    80007548:	ce97c783          	lbu	a5,-791(a5) # 8000e22d <_ZL9finishedA>
    8000754c:	fe0788e3          	beqz	a5,8000753c <_Z16System_Mode_testv+0xb4>
    80007550:	00007797          	auipc	a5,0x7
    80007554:	cdc7c783          	lbu	a5,-804(a5) # 8000e22c <_ZL9finishedB>
    80007558:	fe0782e3          	beqz	a5,8000753c <_Z16System_Mode_testv+0xb4>
    8000755c:	00007797          	auipc	a5,0x7
    80007560:	ccf7c783          	lbu	a5,-817(a5) # 8000e22b <_ZL9finishedC>
    80007564:	fc078ce3          	beqz	a5,8000753c <_Z16System_Mode_testv+0xb4>
    80007568:	00007797          	auipc	a5,0x7
    8000756c:	cc27c783          	lbu	a5,-830(a5) # 8000e22a <_ZL9finishedD>
    80007570:	fc0786e3          	beqz	a5,8000753c <_Z16System_Mode_testv+0xb4>
    }

}
    80007574:	02813083          	ld	ra,40(sp)
    80007578:	02013403          	ld	s0,32(sp)
    8000757c:	03010113          	addi	sp,sp,48
    80007580:	00008067          	ret

0000000080007584 <_ZN6BufferC1Ei>:
#include "buffer.hpp"

Buffer::Buffer(int _cap) : cap(_cap + 1), head(0), tail(0) {
    80007584:	fe010113          	addi	sp,sp,-32
    80007588:	00113c23          	sd	ra,24(sp)
    8000758c:	00813823          	sd	s0,16(sp)
    80007590:	00913423          	sd	s1,8(sp)
    80007594:	01213023          	sd	s2,0(sp)
    80007598:	02010413          	addi	s0,sp,32
    8000759c:	00050493          	mv	s1,a0
    800075a0:	00058913          	mv	s2,a1
    800075a4:	0015879b          	addiw	a5,a1,1
    800075a8:	0007851b          	sext.w	a0,a5
    800075ac:	00f4a023          	sw	a5,0(s1)
    800075b0:	0004a823          	sw	zero,16(s1)
    800075b4:	0004aa23          	sw	zero,20(s1)
    buffer = (int *)mem_alloc(sizeof(int) * cap);
    800075b8:	00251513          	slli	a0,a0,0x2
    800075bc:	ffffa097          	auipc	ra,0xffffa
    800075c0:	cc4080e7          	jalr	-828(ra) # 80001280 <_Z9mem_allocm>
    800075c4:	00a4b423          	sd	a0,8(s1)
    sem_open(&itemAvailable, 0);
    800075c8:	00000593          	li	a1,0
    800075cc:	02048513          	addi	a0,s1,32
    800075d0:	ffffa097          	auipc	ra,0xffffa
    800075d4:	e6c080e7          	jalr	-404(ra) # 8000143c <_Z8sem_openPP5sem_sj>
    sem_open(&spaceAvailable, _cap);
    800075d8:	00090593          	mv	a1,s2
    800075dc:	01848513          	addi	a0,s1,24
    800075e0:	ffffa097          	auipc	ra,0xffffa
    800075e4:	e5c080e7          	jalr	-420(ra) # 8000143c <_Z8sem_openPP5sem_sj>
    sem_open(&mutexHead, 1);
    800075e8:	00100593          	li	a1,1
    800075ec:	02848513          	addi	a0,s1,40
    800075f0:	ffffa097          	auipc	ra,0xffffa
    800075f4:	e4c080e7          	jalr	-436(ra) # 8000143c <_Z8sem_openPP5sem_sj>
    sem_open(&mutexTail, 1);
    800075f8:	00100593          	li	a1,1
    800075fc:	03048513          	addi	a0,s1,48
    80007600:	ffffa097          	auipc	ra,0xffffa
    80007604:	e3c080e7          	jalr	-452(ra) # 8000143c <_Z8sem_openPP5sem_sj>
}
    80007608:	01813083          	ld	ra,24(sp)
    8000760c:	01013403          	ld	s0,16(sp)
    80007610:	00813483          	ld	s1,8(sp)
    80007614:	00013903          	ld	s2,0(sp)
    80007618:	02010113          	addi	sp,sp,32
    8000761c:	00008067          	ret

0000000080007620 <_ZN6Buffer3putEi>:
    sem_close(spaceAvailable);
    sem_close(mutexTail);
    sem_close(mutexHead);
}

void Buffer::put(int val) {
    80007620:	fe010113          	addi	sp,sp,-32
    80007624:	00113c23          	sd	ra,24(sp)
    80007628:	00813823          	sd	s0,16(sp)
    8000762c:	00913423          	sd	s1,8(sp)
    80007630:	01213023          	sd	s2,0(sp)
    80007634:	02010413          	addi	s0,sp,32
    80007638:	00050493          	mv	s1,a0
    8000763c:	00058913          	mv	s2,a1
    sem_wait(spaceAvailable);
    80007640:	01853503          	ld	a0,24(a0)
    80007644:	ffffa097          	auipc	ra,0xffffa
    80007648:	e7c080e7          	jalr	-388(ra) # 800014c0 <_Z8sem_waitP5sem_s>

    sem_wait(mutexTail);
    8000764c:	0304b503          	ld	a0,48(s1)
    80007650:	ffffa097          	auipc	ra,0xffffa
    80007654:	e70080e7          	jalr	-400(ra) # 800014c0 <_Z8sem_waitP5sem_s>
    buffer[tail] = val;
    80007658:	0084b783          	ld	a5,8(s1)
    8000765c:	0144a703          	lw	a4,20(s1)
    80007660:	00271713          	slli	a4,a4,0x2
    80007664:	00e787b3          	add	a5,a5,a4
    80007668:	0127a023          	sw	s2,0(a5)
    tail = (tail + 1) % cap;
    8000766c:	0144a783          	lw	a5,20(s1)
    80007670:	0017879b          	addiw	a5,a5,1
    80007674:	0004a703          	lw	a4,0(s1)
    80007678:	02e7e7bb          	remw	a5,a5,a4
    8000767c:	00f4aa23          	sw	a5,20(s1)
    sem_signal(mutexTail);
    80007680:	0304b503          	ld	a0,48(s1)
    80007684:	ffffa097          	auipc	ra,0xffffa
    80007688:	e7c080e7          	jalr	-388(ra) # 80001500 <_Z10sem_signalP5sem_s>

    sem_signal(itemAvailable);
    8000768c:	0204b503          	ld	a0,32(s1)
    80007690:	ffffa097          	auipc	ra,0xffffa
    80007694:	e70080e7          	jalr	-400(ra) # 80001500 <_Z10sem_signalP5sem_s>

}
    80007698:	01813083          	ld	ra,24(sp)
    8000769c:	01013403          	ld	s0,16(sp)
    800076a0:	00813483          	ld	s1,8(sp)
    800076a4:	00013903          	ld	s2,0(sp)
    800076a8:	02010113          	addi	sp,sp,32
    800076ac:	00008067          	ret

00000000800076b0 <_ZN6Buffer3getEv>:

int Buffer::get() {
    800076b0:	fe010113          	addi	sp,sp,-32
    800076b4:	00113c23          	sd	ra,24(sp)
    800076b8:	00813823          	sd	s0,16(sp)
    800076bc:	00913423          	sd	s1,8(sp)
    800076c0:	01213023          	sd	s2,0(sp)
    800076c4:	02010413          	addi	s0,sp,32
    800076c8:	00050493          	mv	s1,a0
    sem_wait(itemAvailable);
    800076cc:	02053503          	ld	a0,32(a0)
    800076d0:	ffffa097          	auipc	ra,0xffffa
    800076d4:	df0080e7          	jalr	-528(ra) # 800014c0 <_Z8sem_waitP5sem_s>

    sem_wait(mutexHead);
    800076d8:	0284b503          	ld	a0,40(s1)
    800076dc:	ffffa097          	auipc	ra,0xffffa
    800076e0:	de4080e7          	jalr	-540(ra) # 800014c0 <_Z8sem_waitP5sem_s>

    int ret = buffer[head];
    800076e4:	0084b703          	ld	a4,8(s1)
    800076e8:	0104a783          	lw	a5,16(s1)
    800076ec:	00279693          	slli	a3,a5,0x2
    800076f0:	00d70733          	add	a4,a4,a3
    800076f4:	00072903          	lw	s2,0(a4)
    head = (head + 1) % cap;
    800076f8:	0017879b          	addiw	a5,a5,1
    800076fc:	0004a703          	lw	a4,0(s1)
    80007700:	02e7e7bb          	remw	a5,a5,a4
    80007704:	00f4a823          	sw	a5,16(s1)
    sem_signal(mutexHead);
    80007708:	0284b503          	ld	a0,40(s1)
    8000770c:	ffffa097          	auipc	ra,0xffffa
    80007710:	df4080e7          	jalr	-524(ra) # 80001500 <_Z10sem_signalP5sem_s>

    sem_signal(spaceAvailable);
    80007714:	0184b503          	ld	a0,24(s1)
    80007718:	ffffa097          	auipc	ra,0xffffa
    8000771c:	de8080e7          	jalr	-536(ra) # 80001500 <_Z10sem_signalP5sem_s>

    return ret;
}
    80007720:	00090513          	mv	a0,s2
    80007724:	01813083          	ld	ra,24(sp)
    80007728:	01013403          	ld	s0,16(sp)
    8000772c:	00813483          	ld	s1,8(sp)
    80007730:	00013903          	ld	s2,0(sp)
    80007734:	02010113          	addi	sp,sp,32
    80007738:	00008067          	ret

000000008000773c <_ZN6Buffer6getCntEv>:

int Buffer::getCnt() {
    8000773c:	fe010113          	addi	sp,sp,-32
    80007740:	00113c23          	sd	ra,24(sp)
    80007744:	00813823          	sd	s0,16(sp)
    80007748:	00913423          	sd	s1,8(sp)
    8000774c:	01213023          	sd	s2,0(sp)
    80007750:	02010413          	addi	s0,sp,32
    80007754:	00050493          	mv	s1,a0
    int ret;

    sem_wait(mutexHead);
    80007758:	02853503          	ld	a0,40(a0)
    8000775c:	ffffa097          	auipc	ra,0xffffa
    80007760:	d64080e7          	jalr	-668(ra) # 800014c0 <_Z8sem_waitP5sem_s>
    sem_wait(mutexTail);
    80007764:	0304b503          	ld	a0,48(s1)
    80007768:	ffffa097          	auipc	ra,0xffffa
    8000776c:	d58080e7          	jalr	-680(ra) # 800014c0 <_Z8sem_waitP5sem_s>

    if (tail >= head) {
    80007770:	0144a783          	lw	a5,20(s1)
    80007774:	0104a903          	lw	s2,16(s1)
    80007778:	0327ce63          	blt	a5,s2,800077b4 <_ZN6Buffer6getCntEv+0x78>
        ret = tail - head;
    8000777c:	4127893b          	subw	s2,a5,s2
    } else {
        ret = cap - head + tail;
    }

    sem_signal(mutexTail);
    80007780:	0304b503          	ld	a0,48(s1)
    80007784:	ffffa097          	auipc	ra,0xffffa
    80007788:	d7c080e7          	jalr	-644(ra) # 80001500 <_Z10sem_signalP5sem_s>
    sem_signal(mutexHead);
    8000778c:	0284b503          	ld	a0,40(s1)
    80007790:	ffffa097          	auipc	ra,0xffffa
    80007794:	d70080e7          	jalr	-656(ra) # 80001500 <_Z10sem_signalP5sem_s>

    return ret;
}
    80007798:	00090513          	mv	a0,s2
    8000779c:	01813083          	ld	ra,24(sp)
    800077a0:	01013403          	ld	s0,16(sp)
    800077a4:	00813483          	ld	s1,8(sp)
    800077a8:	00013903          	ld	s2,0(sp)
    800077ac:	02010113          	addi	sp,sp,32
    800077b0:	00008067          	ret
        ret = cap - head + tail;
    800077b4:	0004a703          	lw	a4,0(s1)
    800077b8:	4127093b          	subw	s2,a4,s2
    800077bc:	00f9093b          	addw	s2,s2,a5
    800077c0:	fc1ff06f          	j	80007780 <_ZN6Buffer6getCntEv+0x44>

00000000800077c4 <_ZN6BufferD1Ev>:
Buffer::~Buffer() {
    800077c4:	fe010113          	addi	sp,sp,-32
    800077c8:	00113c23          	sd	ra,24(sp)
    800077cc:	00813823          	sd	s0,16(sp)
    800077d0:	00913423          	sd	s1,8(sp)
    800077d4:	02010413          	addi	s0,sp,32
    800077d8:	00050493          	mv	s1,a0
    putc('\n');
    800077dc:	00a00513          	li	a0,10
    800077e0:	ffffa097          	auipc	ra,0xffffa
    800077e4:	dd0080e7          	jalr	-560(ra) # 800015b0 <_Z4putcc>
    printString("Buffer deleted!\n");
    800077e8:	00003517          	auipc	a0,0x3
    800077ec:	df850513          	addi	a0,a0,-520 # 8000a5e0 <CONSOLE_STATUS+0x5d0>
    800077f0:	ffffa097          	auipc	ra,0xffffa
    800077f4:	6bc080e7          	jalr	1724(ra) # 80001eac <_Z11printStringPKc>
    while (getCnt() > 0) {
    800077f8:	00048513          	mv	a0,s1
    800077fc:	00000097          	auipc	ra,0x0
    80007800:	f40080e7          	jalr	-192(ra) # 8000773c <_ZN6Buffer6getCntEv>
    80007804:	02a05c63          	blez	a0,8000783c <_ZN6BufferD1Ev+0x78>
        char ch = buffer[head];
    80007808:	0084b783          	ld	a5,8(s1)
    8000780c:	0104a703          	lw	a4,16(s1)
    80007810:	00271713          	slli	a4,a4,0x2
    80007814:	00e787b3          	add	a5,a5,a4
        putc(ch);
    80007818:	0007c503          	lbu	a0,0(a5)
    8000781c:	ffffa097          	auipc	ra,0xffffa
    80007820:	d94080e7          	jalr	-620(ra) # 800015b0 <_Z4putcc>
        head = (head + 1) % cap;
    80007824:	0104a783          	lw	a5,16(s1)
    80007828:	0017879b          	addiw	a5,a5,1
    8000782c:	0004a703          	lw	a4,0(s1)
    80007830:	02e7e7bb          	remw	a5,a5,a4
    80007834:	00f4a823          	sw	a5,16(s1)
    while (getCnt() > 0) {
    80007838:	fc1ff06f          	j	800077f8 <_ZN6BufferD1Ev+0x34>
    putc('!');
    8000783c:	02100513          	li	a0,33
    80007840:	ffffa097          	auipc	ra,0xffffa
    80007844:	d70080e7          	jalr	-656(ra) # 800015b0 <_Z4putcc>
    putc('\n');
    80007848:	00a00513          	li	a0,10
    8000784c:	ffffa097          	auipc	ra,0xffffa
    80007850:	d64080e7          	jalr	-668(ra) # 800015b0 <_Z4putcc>
    mem_free(buffer);
    80007854:	0084b503          	ld	a0,8(s1)
    80007858:	ffffa097          	auipc	ra,0xffffa
    8000785c:	a68080e7          	jalr	-1432(ra) # 800012c0 <_Z8mem_freePv>
    sem_close(itemAvailable);
    80007860:	0204b503          	ld	a0,32(s1)
    80007864:	ffffa097          	auipc	ra,0xffffa
    80007868:	c1c080e7          	jalr	-996(ra) # 80001480 <_Z9sem_closeP5sem_s>
    sem_close(spaceAvailable);
    8000786c:	0184b503          	ld	a0,24(s1)
    80007870:	ffffa097          	auipc	ra,0xffffa
    80007874:	c10080e7          	jalr	-1008(ra) # 80001480 <_Z9sem_closeP5sem_s>
    sem_close(mutexTail);
    80007878:	0304b503          	ld	a0,48(s1)
    8000787c:	ffffa097          	auipc	ra,0xffffa
    80007880:	c04080e7          	jalr	-1020(ra) # 80001480 <_Z9sem_closeP5sem_s>
    sem_close(mutexHead);
    80007884:	0284b503          	ld	a0,40(s1)
    80007888:	ffffa097          	auipc	ra,0xffffa
    8000788c:	bf8080e7          	jalr	-1032(ra) # 80001480 <_Z9sem_closeP5sem_s>
}
    80007890:	01813083          	ld	ra,24(sp)
    80007894:	01013403          	ld	s0,16(sp)
    80007898:	00813483          	ld	s1,8(sp)
    8000789c:	02010113          	addi	sp,sp,32
    800078a0:	00008067          	ret

00000000800078a4 <start>:
    800078a4:	ff010113          	addi	sp,sp,-16
    800078a8:	00813423          	sd	s0,8(sp)
    800078ac:	01010413          	addi	s0,sp,16
    800078b0:	300027f3          	csrr	a5,mstatus
    800078b4:	ffffe737          	lui	a4,0xffffe
    800078b8:	7ff70713          	addi	a4,a4,2047 # ffffffffffffe7ff <end+0xffffffff7ffef36f>
    800078bc:	00e7f7b3          	and	a5,a5,a4
    800078c0:	00001737          	lui	a4,0x1
    800078c4:	80070713          	addi	a4,a4,-2048 # 800 <_entry-0x7ffff800>
    800078c8:	00e7e7b3          	or	a5,a5,a4
    800078cc:	30079073          	csrw	mstatus,a5
    800078d0:	00000797          	auipc	a5,0x0
    800078d4:	16078793          	addi	a5,a5,352 # 80007a30 <system_main>
    800078d8:	34179073          	csrw	mepc,a5
    800078dc:	00000793          	li	a5,0
    800078e0:	18079073          	csrw	satp,a5
    800078e4:	000107b7          	lui	a5,0x10
    800078e8:	fff78793          	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    800078ec:	30279073          	csrw	medeleg,a5
    800078f0:	30379073          	csrw	mideleg,a5
    800078f4:	104027f3          	csrr	a5,sie
    800078f8:	2227e793          	ori	a5,a5,546
    800078fc:	10479073          	csrw	sie,a5
    80007900:	fff00793          	li	a5,-1
    80007904:	00a7d793          	srli	a5,a5,0xa
    80007908:	3b079073          	csrw	pmpaddr0,a5
    8000790c:	00f00793          	li	a5,15
    80007910:	3a079073          	csrw	pmpcfg0,a5
    80007914:	f14027f3          	csrr	a5,mhartid
    80007918:	0200c737          	lui	a4,0x200c
    8000791c:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    80007920:	0007869b          	sext.w	a3,a5
    80007924:	00269713          	slli	a4,a3,0x2
    80007928:	000f4637          	lui	a2,0xf4
    8000792c:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    80007930:	00d70733          	add	a4,a4,a3
    80007934:	0037979b          	slliw	a5,a5,0x3
    80007938:	020046b7          	lui	a3,0x2004
    8000793c:	00d787b3          	add	a5,a5,a3
    80007940:	00c585b3          	add	a1,a1,a2
    80007944:	00371693          	slli	a3,a4,0x3
    80007948:	00007717          	auipc	a4,0x7
    8000794c:	8e870713          	addi	a4,a4,-1816 # 8000e230 <timer_scratch>
    80007950:	00b7b023          	sd	a1,0(a5)
    80007954:	00d70733          	add	a4,a4,a3
    80007958:	00f73c23          	sd	a5,24(a4)
    8000795c:	02c73023          	sd	a2,32(a4)
    80007960:	34071073          	csrw	mscratch,a4
    80007964:	00000797          	auipc	a5,0x0
    80007968:	6ec78793          	addi	a5,a5,1772 # 80008050 <timervec>
    8000796c:	30579073          	csrw	mtvec,a5
    80007970:	300027f3          	csrr	a5,mstatus
    80007974:	0087e793          	ori	a5,a5,8
    80007978:	30079073          	csrw	mstatus,a5
    8000797c:	304027f3          	csrr	a5,mie
    80007980:	0807e793          	ori	a5,a5,128
    80007984:	30479073          	csrw	mie,a5
    80007988:	f14027f3          	csrr	a5,mhartid
    8000798c:	0007879b          	sext.w	a5,a5
    80007990:	00078213          	mv	tp,a5
    80007994:	30200073          	mret
    80007998:	00813403          	ld	s0,8(sp)
    8000799c:	01010113          	addi	sp,sp,16
    800079a0:	00008067          	ret

00000000800079a4 <timerinit>:
    800079a4:	ff010113          	addi	sp,sp,-16
    800079a8:	00813423          	sd	s0,8(sp)
    800079ac:	01010413          	addi	s0,sp,16
    800079b0:	f14027f3          	csrr	a5,mhartid
    800079b4:	0200c737          	lui	a4,0x200c
    800079b8:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    800079bc:	0007869b          	sext.w	a3,a5
    800079c0:	00269713          	slli	a4,a3,0x2
    800079c4:	000f4637          	lui	a2,0xf4
    800079c8:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    800079cc:	00d70733          	add	a4,a4,a3
    800079d0:	0037979b          	slliw	a5,a5,0x3
    800079d4:	020046b7          	lui	a3,0x2004
    800079d8:	00d787b3          	add	a5,a5,a3
    800079dc:	00c585b3          	add	a1,a1,a2
    800079e0:	00371693          	slli	a3,a4,0x3
    800079e4:	00007717          	auipc	a4,0x7
    800079e8:	84c70713          	addi	a4,a4,-1972 # 8000e230 <timer_scratch>
    800079ec:	00b7b023          	sd	a1,0(a5)
    800079f0:	00d70733          	add	a4,a4,a3
    800079f4:	00f73c23          	sd	a5,24(a4)
    800079f8:	02c73023          	sd	a2,32(a4)
    800079fc:	34071073          	csrw	mscratch,a4
    80007a00:	00000797          	auipc	a5,0x0
    80007a04:	65078793          	addi	a5,a5,1616 # 80008050 <timervec>
    80007a08:	30579073          	csrw	mtvec,a5
    80007a0c:	300027f3          	csrr	a5,mstatus
    80007a10:	0087e793          	ori	a5,a5,8
    80007a14:	30079073          	csrw	mstatus,a5
    80007a18:	304027f3          	csrr	a5,mie
    80007a1c:	0807e793          	ori	a5,a5,128
    80007a20:	30479073          	csrw	mie,a5
    80007a24:	00813403          	ld	s0,8(sp)
    80007a28:	01010113          	addi	sp,sp,16
    80007a2c:	00008067          	ret

0000000080007a30 <system_main>:
    80007a30:	fe010113          	addi	sp,sp,-32
    80007a34:	00813823          	sd	s0,16(sp)
    80007a38:	00913423          	sd	s1,8(sp)
    80007a3c:	00113c23          	sd	ra,24(sp)
    80007a40:	02010413          	addi	s0,sp,32
    80007a44:	00000097          	auipc	ra,0x0
    80007a48:	0c4080e7          	jalr	196(ra) # 80007b08 <cpuid>
    80007a4c:	00005497          	auipc	s1,0x5
    80007a50:	22448493          	addi	s1,s1,548 # 8000cc70 <started>
    80007a54:	02050263          	beqz	a0,80007a78 <system_main+0x48>
    80007a58:	0004a783          	lw	a5,0(s1)
    80007a5c:	0007879b          	sext.w	a5,a5
    80007a60:	fe078ce3          	beqz	a5,80007a58 <system_main+0x28>
    80007a64:	0ff0000f          	fence
    80007a68:	00003517          	auipc	a0,0x3
    80007a6c:	e4850513          	addi	a0,a0,-440 # 8000a8b0 <CONSOLE_STATUS+0x8a0>
    80007a70:	00001097          	auipc	ra,0x1
    80007a74:	a7c080e7          	jalr	-1412(ra) # 800084ec <panic>
    80007a78:	00001097          	auipc	ra,0x1
    80007a7c:	9d0080e7          	jalr	-1584(ra) # 80008448 <consoleinit>
    80007a80:	00001097          	auipc	ra,0x1
    80007a84:	15c080e7          	jalr	348(ra) # 80008bdc <printfinit>
    80007a88:	00003517          	auipc	a0,0x3
    80007a8c:	cb050513          	addi	a0,a0,-848 # 8000a738 <CONSOLE_STATUS+0x728>
    80007a90:	00001097          	auipc	ra,0x1
    80007a94:	ab8080e7          	jalr	-1352(ra) # 80008548 <__printf>
    80007a98:	00003517          	auipc	a0,0x3
    80007a9c:	de850513          	addi	a0,a0,-536 # 8000a880 <CONSOLE_STATUS+0x870>
    80007aa0:	00001097          	auipc	ra,0x1
    80007aa4:	aa8080e7          	jalr	-1368(ra) # 80008548 <__printf>
    80007aa8:	00003517          	auipc	a0,0x3
    80007aac:	c9050513          	addi	a0,a0,-880 # 8000a738 <CONSOLE_STATUS+0x728>
    80007ab0:	00001097          	auipc	ra,0x1
    80007ab4:	a98080e7          	jalr	-1384(ra) # 80008548 <__printf>
    80007ab8:	00001097          	auipc	ra,0x1
    80007abc:	4b0080e7          	jalr	1200(ra) # 80008f68 <kinit>
    80007ac0:	00000097          	auipc	ra,0x0
    80007ac4:	148080e7          	jalr	328(ra) # 80007c08 <trapinit>
    80007ac8:	00000097          	auipc	ra,0x0
    80007acc:	16c080e7          	jalr	364(ra) # 80007c34 <trapinithart>
    80007ad0:	00000097          	auipc	ra,0x0
    80007ad4:	5c0080e7          	jalr	1472(ra) # 80008090 <plicinit>
    80007ad8:	00000097          	auipc	ra,0x0
    80007adc:	5e0080e7          	jalr	1504(ra) # 800080b8 <plicinithart>
    80007ae0:	00000097          	auipc	ra,0x0
    80007ae4:	078080e7          	jalr	120(ra) # 80007b58 <userinit>
    80007ae8:	0ff0000f          	fence
    80007aec:	00100793          	li	a5,1
    80007af0:	00003517          	auipc	a0,0x3
    80007af4:	da850513          	addi	a0,a0,-600 # 8000a898 <CONSOLE_STATUS+0x888>
    80007af8:	00f4a023          	sw	a5,0(s1)
    80007afc:	00001097          	auipc	ra,0x1
    80007b00:	a4c080e7          	jalr	-1460(ra) # 80008548 <__printf>
    80007b04:	0000006f          	j	80007b04 <system_main+0xd4>

0000000080007b08 <cpuid>:
    80007b08:	ff010113          	addi	sp,sp,-16
    80007b0c:	00813423          	sd	s0,8(sp)
    80007b10:	01010413          	addi	s0,sp,16
    80007b14:	00020513          	mv	a0,tp
    80007b18:	00813403          	ld	s0,8(sp)
    80007b1c:	0005051b          	sext.w	a0,a0
    80007b20:	01010113          	addi	sp,sp,16
    80007b24:	00008067          	ret

0000000080007b28 <mycpu>:
    80007b28:	ff010113          	addi	sp,sp,-16
    80007b2c:	00813423          	sd	s0,8(sp)
    80007b30:	01010413          	addi	s0,sp,16
    80007b34:	00020793          	mv	a5,tp
    80007b38:	00813403          	ld	s0,8(sp)
    80007b3c:	0007879b          	sext.w	a5,a5
    80007b40:	00779793          	slli	a5,a5,0x7
    80007b44:	00007517          	auipc	a0,0x7
    80007b48:	71c50513          	addi	a0,a0,1820 # 8000f260 <cpus>
    80007b4c:	00f50533          	add	a0,a0,a5
    80007b50:	01010113          	addi	sp,sp,16
    80007b54:	00008067          	ret

0000000080007b58 <userinit>:
    80007b58:	ff010113          	addi	sp,sp,-16
    80007b5c:	00813423          	sd	s0,8(sp)
    80007b60:	01010413          	addi	s0,sp,16
    80007b64:	00813403          	ld	s0,8(sp)
    80007b68:	01010113          	addi	sp,sp,16
    80007b6c:	ffffb317          	auipc	t1,0xffffb
    80007b70:	eec30067          	jr	-276(t1) # 80002a58 <main>

0000000080007b74 <either_copyout>:
    80007b74:	ff010113          	addi	sp,sp,-16
    80007b78:	00813023          	sd	s0,0(sp)
    80007b7c:	00113423          	sd	ra,8(sp)
    80007b80:	01010413          	addi	s0,sp,16
    80007b84:	02051663          	bnez	a0,80007bb0 <either_copyout+0x3c>
    80007b88:	00058513          	mv	a0,a1
    80007b8c:	00060593          	mv	a1,a2
    80007b90:	0006861b          	sext.w	a2,a3
    80007b94:	00002097          	auipc	ra,0x2
    80007b98:	c60080e7          	jalr	-928(ra) # 800097f4 <__memmove>
    80007b9c:	00813083          	ld	ra,8(sp)
    80007ba0:	00013403          	ld	s0,0(sp)
    80007ba4:	00000513          	li	a0,0
    80007ba8:	01010113          	addi	sp,sp,16
    80007bac:	00008067          	ret
    80007bb0:	00003517          	auipc	a0,0x3
    80007bb4:	d2850513          	addi	a0,a0,-728 # 8000a8d8 <CONSOLE_STATUS+0x8c8>
    80007bb8:	00001097          	auipc	ra,0x1
    80007bbc:	934080e7          	jalr	-1740(ra) # 800084ec <panic>

0000000080007bc0 <either_copyin>:
    80007bc0:	ff010113          	addi	sp,sp,-16
    80007bc4:	00813023          	sd	s0,0(sp)
    80007bc8:	00113423          	sd	ra,8(sp)
    80007bcc:	01010413          	addi	s0,sp,16
    80007bd0:	02059463          	bnez	a1,80007bf8 <either_copyin+0x38>
    80007bd4:	00060593          	mv	a1,a2
    80007bd8:	0006861b          	sext.w	a2,a3
    80007bdc:	00002097          	auipc	ra,0x2
    80007be0:	c18080e7          	jalr	-1000(ra) # 800097f4 <__memmove>
    80007be4:	00813083          	ld	ra,8(sp)
    80007be8:	00013403          	ld	s0,0(sp)
    80007bec:	00000513          	li	a0,0
    80007bf0:	01010113          	addi	sp,sp,16
    80007bf4:	00008067          	ret
    80007bf8:	00003517          	auipc	a0,0x3
    80007bfc:	d0850513          	addi	a0,a0,-760 # 8000a900 <CONSOLE_STATUS+0x8f0>
    80007c00:	00001097          	auipc	ra,0x1
    80007c04:	8ec080e7          	jalr	-1812(ra) # 800084ec <panic>

0000000080007c08 <trapinit>:
    80007c08:	ff010113          	addi	sp,sp,-16
    80007c0c:	00813423          	sd	s0,8(sp)
    80007c10:	01010413          	addi	s0,sp,16
    80007c14:	00813403          	ld	s0,8(sp)
    80007c18:	00003597          	auipc	a1,0x3
    80007c1c:	d1058593          	addi	a1,a1,-752 # 8000a928 <CONSOLE_STATUS+0x918>
    80007c20:	00007517          	auipc	a0,0x7
    80007c24:	6c050513          	addi	a0,a0,1728 # 8000f2e0 <tickslock>
    80007c28:	01010113          	addi	sp,sp,16
    80007c2c:	00001317          	auipc	t1,0x1
    80007c30:	5cc30067          	jr	1484(t1) # 800091f8 <initlock>

0000000080007c34 <trapinithart>:
    80007c34:	ff010113          	addi	sp,sp,-16
    80007c38:	00813423          	sd	s0,8(sp)
    80007c3c:	01010413          	addi	s0,sp,16
    80007c40:	00000797          	auipc	a5,0x0
    80007c44:	30078793          	addi	a5,a5,768 # 80007f40 <kernelvec>
    80007c48:	10579073          	csrw	stvec,a5
    80007c4c:	00813403          	ld	s0,8(sp)
    80007c50:	01010113          	addi	sp,sp,16
    80007c54:	00008067          	ret

0000000080007c58 <usertrap>:
    80007c58:	ff010113          	addi	sp,sp,-16
    80007c5c:	00813423          	sd	s0,8(sp)
    80007c60:	01010413          	addi	s0,sp,16
    80007c64:	00813403          	ld	s0,8(sp)
    80007c68:	01010113          	addi	sp,sp,16
    80007c6c:	00008067          	ret

0000000080007c70 <usertrapret>:
    80007c70:	ff010113          	addi	sp,sp,-16
    80007c74:	00813423          	sd	s0,8(sp)
    80007c78:	01010413          	addi	s0,sp,16
    80007c7c:	00813403          	ld	s0,8(sp)
    80007c80:	01010113          	addi	sp,sp,16
    80007c84:	00008067          	ret

0000000080007c88 <kerneltrap>:
    80007c88:	fe010113          	addi	sp,sp,-32
    80007c8c:	00813823          	sd	s0,16(sp)
    80007c90:	00113c23          	sd	ra,24(sp)
    80007c94:	00913423          	sd	s1,8(sp)
    80007c98:	02010413          	addi	s0,sp,32
    80007c9c:	142025f3          	csrr	a1,scause
    80007ca0:	100027f3          	csrr	a5,sstatus
    80007ca4:	0027f793          	andi	a5,a5,2
    80007ca8:	10079c63          	bnez	a5,80007dc0 <kerneltrap+0x138>
    80007cac:	142027f3          	csrr	a5,scause
    80007cb0:	0207ce63          	bltz	a5,80007cec <kerneltrap+0x64>
    80007cb4:	00003517          	auipc	a0,0x3
    80007cb8:	cbc50513          	addi	a0,a0,-836 # 8000a970 <CONSOLE_STATUS+0x960>
    80007cbc:	00001097          	auipc	ra,0x1
    80007cc0:	88c080e7          	jalr	-1908(ra) # 80008548 <__printf>
    80007cc4:	141025f3          	csrr	a1,sepc
    80007cc8:	14302673          	csrr	a2,stval
    80007ccc:	00003517          	auipc	a0,0x3
    80007cd0:	cb450513          	addi	a0,a0,-844 # 8000a980 <CONSOLE_STATUS+0x970>
    80007cd4:	00001097          	auipc	ra,0x1
    80007cd8:	874080e7          	jalr	-1932(ra) # 80008548 <__printf>
    80007cdc:	00003517          	auipc	a0,0x3
    80007ce0:	cbc50513          	addi	a0,a0,-836 # 8000a998 <CONSOLE_STATUS+0x988>
    80007ce4:	00001097          	auipc	ra,0x1
    80007ce8:	808080e7          	jalr	-2040(ra) # 800084ec <panic>
    80007cec:	0ff7f713          	andi	a4,a5,255
    80007cf0:	00900693          	li	a3,9
    80007cf4:	04d70063          	beq	a4,a3,80007d34 <kerneltrap+0xac>
    80007cf8:	fff00713          	li	a4,-1
    80007cfc:	03f71713          	slli	a4,a4,0x3f
    80007d00:	00170713          	addi	a4,a4,1
    80007d04:	fae798e3          	bne	a5,a4,80007cb4 <kerneltrap+0x2c>
    80007d08:	00000097          	auipc	ra,0x0
    80007d0c:	e00080e7          	jalr	-512(ra) # 80007b08 <cpuid>
    80007d10:	06050663          	beqz	a0,80007d7c <kerneltrap+0xf4>
    80007d14:	144027f3          	csrr	a5,sip
    80007d18:	ffd7f793          	andi	a5,a5,-3
    80007d1c:	14479073          	csrw	sip,a5
    80007d20:	01813083          	ld	ra,24(sp)
    80007d24:	01013403          	ld	s0,16(sp)
    80007d28:	00813483          	ld	s1,8(sp)
    80007d2c:	02010113          	addi	sp,sp,32
    80007d30:	00008067          	ret
    80007d34:	00000097          	auipc	ra,0x0
    80007d38:	3d0080e7          	jalr	976(ra) # 80008104 <plic_claim>
    80007d3c:	00a00793          	li	a5,10
    80007d40:	00050493          	mv	s1,a0
    80007d44:	06f50863          	beq	a0,a5,80007db4 <kerneltrap+0x12c>
    80007d48:	fc050ce3          	beqz	a0,80007d20 <kerneltrap+0x98>
    80007d4c:	00050593          	mv	a1,a0
    80007d50:	00003517          	auipc	a0,0x3
    80007d54:	c0050513          	addi	a0,a0,-1024 # 8000a950 <CONSOLE_STATUS+0x940>
    80007d58:	00000097          	auipc	ra,0x0
    80007d5c:	7f0080e7          	jalr	2032(ra) # 80008548 <__printf>
    80007d60:	01013403          	ld	s0,16(sp)
    80007d64:	01813083          	ld	ra,24(sp)
    80007d68:	00048513          	mv	a0,s1
    80007d6c:	00813483          	ld	s1,8(sp)
    80007d70:	02010113          	addi	sp,sp,32
    80007d74:	00000317          	auipc	t1,0x0
    80007d78:	3c830067          	jr	968(t1) # 8000813c <plic_complete>
    80007d7c:	00007517          	auipc	a0,0x7
    80007d80:	56450513          	addi	a0,a0,1380 # 8000f2e0 <tickslock>
    80007d84:	00001097          	auipc	ra,0x1
    80007d88:	498080e7          	jalr	1176(ra) # 8000921c <acquire>
    80007d8c:	00005717          	auipc	a4,0x5
    80007d90:	ee870713          	addi	a4,a4,-280 # 8000cc74 <ticks>
    80007d94:	00072783          	lw	a5,0(a4)
    80007d98:	00007517          	auipc	a0,0x7
    80007d9c:	54850513          	addi	a0,a0,1352 # 8000f2e0 <tickslock>
    80007da0:	0017879b          	addiw	a5,a5,1
    80007da4:	00f72023          	sw	a5,0(a4)
    80007da8:	00001097          	auipc	ra,0x1
    80007dac:	540080e7          	jalr	1344(ra) # 800092e8 <release>
    80007db0:	f65ff06f          	j	80007d14 <kerneltrap+0x8c>
    80007db4:	00001097          	auipc	ra,0x1
    80007db8:	09c080e7          	jalr	156(ra) # 80008e50 <uartintr>
    80007dbc:	fa5ff06f          	j	80007d60 <kerneltrap+0xd8>
    80007dc0:	00003517          	auipc	a0,0x3
    80007dc4:	b7050513          	addi	a0,a0,-1168 # 8000a930 <CONSOLE_STATUS+0x920>
    80007dc8:	00000097          	auipc	ra,0x0
    80007dcc:	724080e7          	jalr	1828(ra) # 800084ec <panic>

0000000080007dd0 <clockintr>:
    80007dd0:	fe010113          	addi	sp,sp,-32
    80007dd4:	00813823          	sd	s0,16(sp)
    80007dd8:	00913423          	sd	s1,8(sp)
    80007ddc:	00113c23          	sd	ra,24(sp)
    80007de0:	02010413          	addi	s0,sp,32
    80007de4:	00007497          	auipc	s1,0x7
    80007de8:	4fc48493          	addi	s1,s1,1276 # 8000f2e0 <tickslock>
    80007dec:	00048513          	mv	a0,s1
    80007df0:	00001097          	auipc	ra,0x1
    80007df4:	42c080e7          	jalr	1068(ra) # 8000921c <acquire>
    80007df8:	00005717          	auipc	a4,0x5
    80007dfc:	e7c70713          	addi	a4,a4,-388 # 8000cc74 <ticks>
    80007e00:	00072783          	lw	a5,0(a4)
    80007e04:	01013403          	ld	s0,16(sp)
    80007e08:	01813083          	ld	ra,24(sp)
    80007e0c:	00048513          	mv	a0,s1
    80007e10:	0017879b          	addiw	a5,a5,1
    80007e14:	00813483          	ld	s1,8(sp)
    80007e18:	00f72023          	sw	a5,0(a4)
    80007e1c:	02010113          	addi	sp,sp,32
    80007e20:	00001317          	auipc	t1,0x1
    80007e24:	4c830067          	jr	1224(t1) # 800092e8 <release>

0000000080007e28 <devintr>:
    80007e28:	142027f3          	csrr	a5,scause
    80007e2c:	00000513          	li	a0,0
    80007e30:	0007c463          	bltz	a5,80007e38 <devintr+0x10>
    80007e34:	00008067          	ret
    80007e38:	fe010113          	addi	sp,sp,-32
    80007e3c:	00813823          	sd	s0,16(sp)
    80007e40:	00113c23          	sd	ra,24(sp)
    80007e44:	00913423          	sd	s1,8(sp)
    80007e48:	02010413          	addi	s0,sp,32
    80007e4c:	0ff7f713          	andi	a4,a5,255
    80007e50:	00900693          	li	a3,9
    80007e54:	04d70c63          	beq	a4,a3,80007eac <devintr+0x84>
    80007e58:	fff00713          	li	a4,-1
    80007e5c:	03f71713          	slli	a4,a4,0x3f
    80007e60:	00170713          	addi	a4,a4,1
    80007e64:	00e78c63          	beq	a5,a4,80007e7c <devintr+0x54>
    80007e68:	01813083          	ld	ra,24(sp)
    80007e6c:	01013403          	ld	s0,16(sp)
    80007e70:	00813483          	ld	s1,8(sp)
    80007e74:	02010113          	addi	sp,sp,32
    80007e78:	00008067          	ret
    80007e7c:	00000097          	auipc	ra,0x0
    80007e80:	c8c080e7          	jalr	-884(ra) # 80007b08 <cpuid>
    80007e84:	06050663          	beqz	a0,80007ef0 <devintr+0xc8>
    80007e88:	144027f3          	csrr	a5,sip
    80007e8c:	ffd7f793          	andi	a5,a5,-3
    80007e90:	14479073          	csrw	sip,a5
    80007e94:	01813083          	ld	ra,24(sp)
    80007e98:	01013403          	ld	s0,16(sp)
    80007e9c:	00813483          	ld	s1,8(sp)
    80007ea0:	00200513          	li	a0,2
    80007ea4:	02010113          	addi	sp,sp,32
    80007ea8:	00008067          	ret
    80007eac:	00000097          	auipc	ra,0x0
    80007eb0:	258080e7          	jalr	600(ra) # 80008104 <plic_claim>
    80007eb4:	00a00793          	li	a5,10
    80007eb8:	00050493          	mv	s1,a0
    80007ebc:	06f50663          	beq	a0,a5,80007f28 <devintr+0x100>
    80007ec0:	00100513          	li	a0,1
    80007ec4:	fa0482e3          	beqz	s1,80007e68 <devintr+0x40>
    80007ec8:	00048593          	mv	a1,s1
    80007ecc:	00003517          	auipc	a0,0x3
    80007ed0:	a8450513          	addi	a0,a0,-1404 # 8000a950 <CONSOLE_STATUS+0x940>
    80007ed4:	00000097          	auipc	ra,0x0
    80007ed8:	674080e7          	jalr	1652(ra) # 80008548 <__printf>
    80007edc:	00048513          	mv	a0,s1
    80007ee0:	00000097          	auipc	ra,0x0
    80007ee4:	25c080e7          	jalr	604(ra) # 8000813c <plic_complete>
    80007ee8:	00100513          	li	a0,1
    80007eec:	f7dff06f          	j	80007e68 <devintr+0x40>
    80007ef0:	00007517          	auipc	a0,0x7
    80007ef4:	3f050513          	addi	a0,a0,1008 # 8000f2e0 <tickslock>
    80007ef8:	00001097          	auipc	ra,0x1
    80007efc:	324080e7          	jalr	804(ra) # 8000921c <acquire>
    80007f00:	00005717          	auipc	a4,0x5
    80007f04:	d7470713          	addi	a4,a4,-652 # 8000cc74 <ticks>
    80007f08:	00072783          	lw	a5,0(a4)
    80007f0c:	00007517          	auipc	a0,0x7
    80007f10:	3d450513          	addi	a0,a0,980 # 8000f2e0 <tickslock>
    80007f14:	0017879b          	addiw	a5,a5,1
    80007f18:	00f72023          	sw	a5,0(a4)
    80007f1c:	00001097          	auipc	ra,0x1
    80007f20:	3cc080e7          	jalr	972(ra) # 800092e8 <release>
    80007f24:	f65ff06f          	j	80007e88 <devintr+0x60>
    80007f28:	00001097          	auipc	ra,0x1
    80007f2c:	f28080e7          	jalr	-216(ra) # 80008e50 <uartintr>
    80007f30:	fadff06f          	j	80007edc <devintr+0xb4>
	...

0000000080007f40 <kernelvec>:
    80007f40:	f0010113          	addi	sp,sp,-256
    80007f44:	00113023          	sd	ra,0(sp)
    80007f48:	00213423          	sd	sp,8(sp)
    80007f4c:	00313823          	sd	gp,16(sp)
    80007f50:	00413c23          	sd	tp,24(sp)
    80007f54:	02513023          	sd	t0,32(sp)
    80007f58:	02613423          	sd	t1,40(sp)
    80007f5c:	02713823          	sd	t2,48(sp)
    80007f60:	02813c23          	sd	s0,56(sp)
    80007f64:	04913023          	sd	s1,64(sp)
    80007f68:	04a13423          	sd	a0,72(sp)
    80007f6c:	04b13823          	sd	a1,80(sp)
    80007f70:	04c13c23          	sd	a2,88(sp)
    80007f74:	06d13023          	sd	a3,96(sp)
    80007f78:	06e13423          	sd	a4,104(sp)
    80007f7c:	06f13823          	sd	a5,112(sp)
    80007f80:	07013c23          	sd	a6,120(sp)
    80007f84:	09113023          	sd	a7,128(sp)
    80007f88:	09213423          	sd	s2,136(sp)
    80007f8c:	09313823          	sd	s3,144(sp)
    80007f90:	09413c23          	sd	s4,152(sp)
    80007f94:	0b513023          	sd	s5,160(sp)
    80007f98:	0b613423          	sd	s6,168(sp)
    80007f9c:	0b713823          	sd	s7,176(sp)
    80007fa0:	0b813c23          	sd	s8,184(sp)
    80007fa4:	0d913023          	sd	s9,192(sp)
    80007fa8:	0da13423          	sd	s10,200(sp)
    80007fac:	0db13823          	sd	s11,208(sp)
    80007fb0:	0dc13c23          	sd	t3,216(sp)
    80007fb4:	0fd13023          	sd	t4,224(sp)
    80007fb8:	0fe13423          	sd	t5,232(sp)
    80007fbc:	0ff13823          	sd	t6,240(sp)
    80007fc0:	cc9ff0ef          	jal	ra,80007c88 <kerneltrap>
    80007fc4:	00013083          	ld	ra,0(sp)
    80007fc8:	00813103          	ld	sp,8(sp)
    80007fcc:	01013183          	ld	gp,16(sp)
    80007fd0:	02013283          	ld	t0,32(sp)
    80007fd4:	02813303          	ld	t1,40(sp)
    80007fd8:	03013383          	ld	t2,48(sp)
    80007fdc:	03813403          	ld	s0,56(sp)
    80007fe0:	04013483          	ld	s1,64(sp)
    80007fe4:	04813503          	ld	a0,72(sp)
    80007fe8:	05013583          	ld	a1,80(sp)
    80007fec:	05813603          	ld	a2,88(sp)
    80007ff0:	06013683          	ld	a3,96(sp)
    80007ff4:	06813703          	ld	a4,104(sp)
    80007ff8:	07013783          	ld	a5,112(sp)
    80007ffc:	07813803          	ld	a6,120(sp)
    80008000:	08013883          	ld	a7,128(sp)
    80008004:	08813903          	ld	s2,136(sp)
    80008008:	09013983          	ld	s3,144(sp)
    8000800c:	09813a03          	ld	s4,152(sp)
    80008010:	0a013a83          	ld	s5,160(sp)
    80008014:	0a813b03          	ld	s6,168(sp)
    80008018:	0b013b83          	ld	s7,176(sp)
    8000801c:	0b813c03          	ld	s8,184(sp)
    80008020:	0c013c83          	ld	s9,192(sp)
    80008024:	0c813d03          	ld	s10,200(sp)
    80008028:	0d013d83          	ld	s11,208(sp)
    8000802c:	0d813e03          	ld	t3,216(sp)
    80008030:	0e013e83          	ld	t4,224(sp)
    80008034:	0e813f03          	ld	t5,232(sp)
    80008038:	0f013f83          	ld	t6,240(sp)
    8000803c:	10010113          	addi	sp,sp,256
    80008040:	10200073          	sret
    80008044:	00000013          	nop
    80008048:	00000013          	nop
    8000804c:	00000013          	nop

0000000080008050 <timervec>:
    80008050:	34051573          	csrrw	a0,mscratch,a0
    80008054:	00b53023          	sd	a1,0(a0)
    80008058:	00c53423          	sd	a2,8(a0)
    8000805c:	00d53823          	sd	a3,16(a0)
    80008060:	01853583          	ld	a1,24(a0)
    80008064:	02053603          	ld	a2,32(a0)
    80008068:	0005b683          	ld	a3,0(a1)
    8000806c:	00c686b3          	add	a3,a3,a2
    80008070:	00d5b023          	sd	a3,0(a1)
    80008074:	00200593          	li	a1,2
    80008078:	14459073          	csrw	sip,a1
    8000807c:	01053683          	ld	a3,16(a0)
    80008080:	00853603          	ld	a2,8(a0)
    80008084:	00053583          	ld	a1,0(a0)
    80008088:	34051573          	csrrw	a0,mscratch,a0
    8000808c:	30200073          	mret

0000000080008090 <plicinit>:
    80008090:	ff010113          	addi	sp,sp,-16
    80008094:	00813423          	sd	s0,8(sp)
    80008098:	01010413          	addi	s0,sp,16
    8000809c:	00813403          	ld	s0,8(sp)
    800080a0:	0c0007b7          	lui	a5,0xc000
    800080a4:	00100713          	li	a4,1
    800080a8:	02e7a423          	sw	a4,40(a5) # c000028 <_entry-0x73ffffd8>
    800080ac:	00e7a223          	sw	a4,4(a5)
    800080b0:	01010113          	addi	sp,sp,16
    800080b4:	00008067          	ret

00000000800080b8 <plicinithart>:
    800080b8:	ff010113          	addi	sp,sp,-16
    800080bc:	00813023          	sd	s0,0(sp)
    800080c0:	00113423          	sd	ra,8(sp)
    800080c4:	01010413          	addi	s0,sp,16
    800080c8:	00000097          	auipc	ra,0x0
    800080cc:	a40080e7          	jalr	-1472(ra) # 80007b08 <cpuid>
    800080d0:	0085171b          	slliw	a4,a0,0x8
    800080d4:	0c0027b7          	lui	a5,0xc002
    800080d8:	00e787b3          	add	a5,a5,a4
    800080dc:	40200713          	li	a4,1026
    800080e0:	08e7a023          	sw	a4,128(a5) # c002080 <_entry-0x73ffdf80>
    800080e4:	00813083          	ld	ra,8(sp)
    800080e8:	00013403          	ld	s0,0(sp)
    800080ec:	00d5151b          	slliw	a0,a0,0xd
    800080f0:	0c2017b7          	lui	a5,0xc201
    800080f4:	00a78533          	add	a0,a5,a0
    800080f8:	00052023          	sw	zero,0(a0)
    800080fc:	01010113          	addi	sp,sp,16
    80008100:	00008067          	ret

0000000080008104 <plic_claim>:
    80008104:	ff010113          	addi	sp,sp,-16
    80008108:	00813023          	sd	s0,0(sp)
    8000810c:	00113423          	sd	ra,8(sp)
    80008110:	01010413          	addi	s0,sp,16
    80008114:	00000097          	auipc	ra,0x0
    80008118:	9f4080e7          	jalr	-1548(ra) # 80007b08 <cpuid>
    8000811c:	00813083          	ld	ra,8(sp)
    80008120:	00013403          	ld	s0,0(sp)
    80008124:	00d5151b          	slliw	a0,a0,0xd
    80008128:	0c2017b7          	lui	a5,0xc201
    8000812c:	00a78533          	add	a0,a5,a0
    80008130:	00452503          	lw	a0,4(a0)
    80008134:	01010113          	addi	sp,sp,16
    80008138:	00008067          	ret

000000008000813c <plic_complete>:
    8000813c:	fe010113          	addi	sp,sp,-32
    80008140:	00813823          	sd	s0,16(sp)
    80008144:	00913423          	sd	s1,8(sp)
    80008148:	00113c23          	sd	ra,24(sp)
    8000814c:	02010413          	addi	s0,sp,32
    80008150:	00050493          	mv	s1,a0
    80008154:	00000097          	auipc	ra,0x0
    80008158:	9b4080e7          	jalr	-1612(ra) # 80007b08 <cpuid>
    8000815c:	01813083          	ld	ra,24(sp)
    80008160:	01013403          	ld	s0,16(sp)
    80008164:	00d5179b          	slliw	a5,a0,0xd
    80008168:	0c201737          	lui	a4,0xc201
    8000816c:	00f707b3          	add	a5,a4,a5
    80008170:	0097a223          	sw	s1,4(a5) # c201004 <_entry-0x73dfeffc>
    80008174:	00813483          	ld	s1,8(sp)
    80008178:	02010113          	addi	sp,sp,32
    8000817c:	00008067          	ret

0000000080008180 <consolewrite>:
    80008180:	fb010113          	addi	sp,sp,-80
    80008184:	04813023          	sd	s0,64(sp)
    80008188:	04113423          	sd	ra,72(sp)
    8000818c:	02913c23          	sd	s1,56(sp)
    80008190:	03213823          	sd	s2,48(sp)
    80008194:	03313423          	sd	s3,40(sp)
    80008198:	03413023          	sd	s4,32(sp)
    8000819c:	01513c23          	sd	s5,24(sp)
    800081a0:	05010413          	addi	s0,sp,80
    800081a4:	06c05c63          	blez	a2,8000821c <consolewrite+0x9c>
    800081a8:	00060993          	mv	s3,a2
    800081ac:	00050a13          	mv	s4,a0
    800081b0:	00058493          	mv	s1,a1
    800081b4:	00000913          	li	s2,0
    800081b8:	fff00a93          	li	s5,-1
    800081bc:	01c0006f          	j	800081d8 <consolewrite+0x58>
    800081c0:	fbf44503          	lbu	a0,-65(s0)
    800081c4:	0019091b          	addiw	s2,s2,1
    800081c8:	00148493          	addi	s1,s1,1
    800081cc:	00001097          	auipc	ra,0x1
    800081d0:	a9c080e7          	jalr	-1380(ra) # 80008c68 <uartputc>
    800081d4:	03298063          	beq	s3,s2,800081f4 <consolewrite+0x74>
    800081d8:	00048613          	mv	a2,s1
    800081dc:	00100693          	li	a3,1
    800081e0:	000a0593          	mv	a1,s4
    800081e4:	fbf40513          	addi	a0,s0,-65
    800081e8:	00000097          	auipc	ra,0x0
    800081ec:	9d8080e7          	jalr	-1576(ra) # 80007bc0 <either_copyin>
    800081f0:	fd5518e3          	bne	a0,s5,800081c0 <consolewrite+0x40>
    800081f4:	04813083          	ld	ra,72(sp)
    800081f8:	04013403          	ld	s0,64(sp)
    800081fc:	03813483          	ld	s1,56(sp)
    80008200:	02813983          	ld	s3,40(sp)
    80008204:	02013a03          	ld	s4,32(sp)
    80008208:	01813a83          	ld	s5,24(sp)
    8000820c:	00090513          	mv	a0,s2
    80008210:	03013903          	ld	s2,48(sp)
    80008214:	05010113          	addi	sp,sp,80
    80008218:	00008067          	ret
    8000821c:	00000913          	li	s2,0
    80008220:	fd5ff06f          	j	800081f4 <consolewrite+0x74>

0000000080008224 <consoleread>:
    80008224:	f9010113          	addi	sp,sp,-112
    80008228:	06813023          	sd	s0,96(sp)
    8000822c:	04913c23          	sd	s1,88(sp)
    80008230:	05213823          	sd	s2,80(sp)
    80008234:	05313423          	sd	s3,72(sp)
    80008238:	05413023          	sd	s4,64(sp)
    8000823c:	03513c23          	sd	s5,56(sp)
    80008240:	03613823          	sd	s6,48(sp)
    80008244:	03713423          	sd	s7,40(sp)
    80008248:	03813023          	sd	s8,32(sp)
    8000824c:	06113423          	sd	ra,104(sp)
    80008250:	01913c23          	sd	s9,24(sp)
    80008254:	07010413          	addi	s0,sp,112
    80008258:	00060b93          	mv	s7,a2
    8000825c:	00050913          	mv	s2,a0
    80008260:	00058c13          	mv	s8,a1
    80008264:	00060b1b          	sext.w	s6,a2
    80008268:	00007497          	auipc	s1,0x7
    8000826c:	0a048493          	addi	s1,s1,160 # 8000f308 <cons>
    80008270:	00400993          	li	s3,4
    80008274:	fff00a13          	li	s4,-1
    80008278:	00a00a93          	li	s5,10
    8000827c:	05705e63          	blez	s7,800082d8 <consoleread+0xb4>
    80008280:	09c4a703          	lw	a4,156(s1)
    80008284:	0984a783          	lw	a5,152(s1)
    80008288:	0007071b          	sext.w	a4,a4
    8000828c:	08e78463          	beq	a5,a4,80008314 <consoleread+0xf0>
    80008290:	07f7f713          	andi	a4,a5,127
    80008294:	00e48733          	add	a4,s1,a4
    80008298:	01874703          	lbu	a4,24(a4) # c201018 <_entry-0x73dfefe8>
    8000829c:	0017869b          	addiw	a3,a5,1
    800082a0:	08d4ac23          	sw	a3,152(s1)
    800082a4:	00070c9b          	sext.w	s9,a4
    800082a8:	0b370663          	beq	a4,s3,80008354 <consoleread+0x130>
    800082ac:	00100693          	li	a3,1
    800082b0:	f9f40613          	addi	a2,s0,-97
    800082b4:	000c0593          	mv	a1,s8
    800082b8:	00090513          	mv	a0,s2
    800082bc:	f8e40fa3          	sb	a4,-97(s0)
    800082c0:	00000097          	auipc	ra,0x0
    800082c4:	8b4080e7          	jalr	-1868(ra) # 80007b74 <either_copyout>
    800082c8:	01450863          	beq	a0,s4,800082d8 <consoleread+0xb4>
    800082cc:	001c0c13          	addi	s8,s8,1
    800082d0:	fffb8b9b          	addiw	s7,s7,-1
    800082d4:	fb5c94e3          	bne	s9,s5,8000827c <consoleread+0x58>
    800082d8:	000b851b          	sext.w	a0,s7
    800082dc:	06813083          	ld	ra,104(sp)
    800082e0:	06013403          	ld	s0,96(sp)
    800082e4:	05813483          	ld	s1,88(sp)
    800082e8:	05013903          	ld	s2,80(sp)
    800082ec:	04813983          	ld	s3,72(sp)
    800082f0:	04013a03          	ld	s4,64(sp)
    800082f4:	03813a83          	ld	s5,56(sp)
    800082f8:	02813b83          	ld	s7,40(sp)
    800082fc:	02013c03          	ld	s8,32(sp)
    80008300:	01813c83          	ld	s9,24(sp)
    80008304:	40ab053b          	subw	a0,s6,a0
    80008308:	03013b03          	ld	s6,48(sp)
    8000830c:	07010113          	addi	sp,sp,112
    80008310:	00008067          	ret
    80008314:	00001097          	auipc	ra,0x1
    80008318:	1d8080e7          	jalr	472(ra) # 800094ec <push_on>
    8000831c:	0984a703          	lw	a4,152(s1)
    80008320:	09c4a783          	lw	a5,156(s1)
    80008324:	0007879b          	sext.w	a5,a5
    80008328:	fef70ce3          	beq	a4,a5,80008320 <consoleread+0xfc>
    8000832c:	00001097          	auipc	ra,0x1
    80008330:	234080e7          	jalr	564(ra) # 80009560 <pop_on>
    80008334:	0984a783          	lw	a5,152(s1)
    80008338:	07f7f713          	andi	a4,a5,127
    8000833c:	00e48733          	add	a4,s1,a4
    80008340:	01874703          	lbu	a4,24(a4)
    80008344:	0017869b          	addiw	a3,a5,1
    80008348:	08d4ac23          	sw	a3,152(s1)
    8000834c:	00070c9b          	sext.w	s9,a4
    80008350:	f5371ee3          	bne	a4,s3,800082ac <consoleread+0x88>
    80008354:	000b851b          	sext.w	a0,s7
    80008358:	f96bf2e3          	bgeu	s7,s6,800082dc <consoleread+0xb8>
    8000835c:	08f4ac23          	sw	a5,152(s1)
    80008360:	f7dff06f          	j	800082dc <consoleread+0xb8>

0000000080008364 <consputc>:
    80008364:	10000793          	li	a5,256
    80008368:	00f50663          	beq	a0,a5,80008374 <consputc+0x10>
    8000836c:	00001317          	auipc	t1,0x1
    80008370:	9f430067          	jr	-1548(t1) # 80008d60 <uartputc_sync>
    80008374:	ff010113          	addi	sp,sp,-16
    80008378:	00113423          	sd	ra,8(sp)
    8000837c:	00813023          	sd	s0,0(sp)
    80008380:	01010413          	addi	s0,sp,16
    80008384:	00800513          	li	a0,8
    80008388:	00001097          	auipc	ra,0x1
    8000838c:	9d8080e7          	jalr	-1576(ra) # 80008d60 <uartputc_sync>
    80008390:	02000513          	li	a0,32
    80008394:	00001097          	auipc	ra,0x1
    80008398:	9cc080e7          	jalr	-1588(ra) # 80008d60 <uartputc_sync>
    8000839c:	00013403          	ld	s0,0(sp)
    800083a0:	00813083          	ld	ra,8(sp)
    800083a4:	00800513          	li	a0,8
    800083a8:	01010113          	addi	sp,sp,16
    800083ac:	00001317          	auipc	t1,0x1
    800083b0:	9b430067          	jr	-1612(t1) # 80008d60 <uartputc_sync>

00000000800083b4 <consoleintr>:
    800083b4:	fe010113          	addi	sp,sp,-32
    800083b8:	00813823          	sd	s0,16(sp)
    800083bc:	00913423          	sd	s1,8(sp)
    800083c0:	01213023          	sd	s2,0(sp)
    800083c4:	00113c23          	sd	ra,24(sp)
    800083c8:	02010413          	addi	s0,sp,32
    800083cc:	00007917          	auipc	s2,0x7
    800083d0:	f3c90913          	addi	s2,s2,-196 # 8000f308 <cons>
    800083d4:	00050493          	mv	s1,a0
    800083d8:	00090513          	mv	a0,s2
    800083dc:	00001097          	auipc	ra,0x1
    800083e0:	e40080e7          	jalr	-448(ra) # 8000921c <acquire>
    800083e4:	02048c63          	beqz	s1,8000841c <consoleintr+0x68>
    800083e8:	0a092783          	lw	a5,160(s2)
    800083ec:	09892703          	lw	a4,152(s2)
    800083f0:	07f00693          	li	a3,127
    800083f4:	40e7873b          	subw	a4,a5,a4
    800083f8:	02e6e263          	bltu	a3,a4,8000841c <consoleintr+0x68>
    800083fc:	00d00713          	li	a4,13
    80008400:	04e48063          	beq	s1,a4,80008440 <consoleintr+0x8c>
    80008404:	07f7f713          	andi	a4,a5,127
    80008408:	00e90733          	add	a4,s2,a4
    8000840c:	0017879b          	addiw	a5,a5,1
    80008410:	0af92023          	sw	a5,160(s2)
    80008414:	00970c23          	sb	s1,24(a4)
    80008418:	08f92e23          	sw	a5,156(s2)
    8000841c:	01013403          	ld	s0,16(sp)
    80008420:	01813083          	ld	ra,24(sp)
    80008424:	00813483          	ld	s1,8(sp)
    80008428:	00013903          	ld	s2,0(sp)
    8000842c:	00007517          	auipc	a0,0x7
    80008430:	edc50513          	addi	a0,a0,-292 # 8000f308 <cons>
    80008434:	02010113          	addi	sp,sp,32
    80008438:	00001317          	auipc	t1,0x1
    8000843c:	eb030067          	jr	-336(t1) # 800092e8 <release>
    80008440:	00a00493          	li	s1,10
    80008444:	fc1ff06f          	j	80008404 <consoleintr+0x50>

0000000080008448 <consoleinit>:
    80008448:	fe010113          	addi	sp,sp,-32
    8000844c:	00113c23          	sd	ra,24(sp)
    80008450:	00813823          	sd	s0,16(sp)
    80008454:	00913423          	sd	s1,8(sp)
    80008458:	02010413          	addi	s0,sp,32
    8000845c:	00007497          	auipc	s1,0x7
    80008460:	eac48493          	addi	s1,s1,-340 # 8000f308 <cons>
    80008464:	00048513          	mv	a0,s1
    80008468:	00002597          	auipc	a1,0x2
    8000846c:	54058593          	addi	a1,a1,1344 # 8000a9a8 <CONSOLE_STATUS+0x998>
    80008470:	00001097          	auipc	ra,0x1
    80008474:	d88080e7          	jalr	-632(ra) # 800091f8 <initlock>
    80008478:	00000097          	auipc	ra,0x0
    8000847c:	7ac080e7          	jalr	1964(ra) # 80008c24 <uartinit>
    80008480:	01813083          	ld	ra,24(sp)
    80008484:	01013403          	ld	s0,16(sp)
    80008488:	00000797          	auipc	a5,0x0
    8000848c:	d9c78793          	addi	a5,a5,-612 # 80008224 <consoleread>
    80008490:	0af4bc23          	sd	a5,184(s1)
    80008494:	00000797          	auipc	a5,0x0
    80008498:	cec78793          	addi	a5,a5,-788 # 80008180 <consolewrite>
    8000849c:	0cf4b023          	sd	a5,192(s1)
    800084a0:	00813483          	ld	s1,8(sp)
    800084a4:	02010113          	addi	sp,sp,32
    800084a8:	00008067          	ret

00000000800084ac <console_read>:
    800084ac:	ff010113          	addi	sp,sp,-16
    800084b0:	00813423          	sd	s0,8(sp)
    800084b4:	01010413          	addi	s0,sp,16
    800084b8:	00813403          	ld	s0,8(sp)
    800084bc:	00007317          	auipc	t1,0x7
    800084c0:	f0433303          	ld	t1,-252(t1) # 8000f3c0 <devsw+0x10>
    800084c4:	01010113          	addi	sp,sp,16
    800084c8:	00030067          	jr	t1

00000000800084cc <console_write>:
    800084cc:	ff010113          	addi	sp,sp,-16
    800084d0:	00813423          	sd	s0,8(sp)
    800084d4:	01010413          	addi	s0,sp,16
    800084d8:	00813403          	ld	s0,8(sp)
    800084dc:	00007317          	auipc	t1,0x7
    800084e0:	eec33303          	ld	t1,-276(t1) # 8000f3c8 <devsw+0x18>
    800084e4:	01010113          	addi	sp,sp,16
    800084e8:	00030067          	jr	t1

00000000800084ec <panic>:
    800084ec:	fe010113          	addi	sp,sp,-32
    800084f0:	00113c23          	sd	ra,24(sp)
    800084f4:	00813823          	sd	s0,16(sp)
    800084f8:	00913423          	sd	s1,8(sp)
    800084fc:	02010413          	addi	s0,sp,32
    80008500:	00050493          	mv	s1,a0
    80008504:	00002517          	auipc	a0,0x2
    80008508:	4ac50513          	addi	a0,a0,1196 # 8000a9b0 <CONSOLE_STATUS+0x9a0>
    8000850c:	00007797          	auipc	a5,0x7
    80008510:	f407ae23          	sw	zero,-164(a5) # 8000f468 <pr+0x18>
    80008514:	00000097          	auipc	ra,0x0
    80008518:	034080e7          	jalr	52(ra) # 80008548 <__printf>
    8000851c:	00048513          	mv	a0,s1
    80008520:	00000097          	auipc	ra,0x0
    80008524:	028080e7          	jalr	40(ra) # 80008548 <__printf>
    80008528:	00002517          	auipc	a0,0x2
    8000852c:	21050513          	addi	a0,a0,528 # 8000a738 <CONSOLE_STATUS+0x728>
    80008530:	00000097          	auipc	ra,0x0
    80008534:	018080e7          	jalr	24(ra) # 80008548 <__printf>
    80008538:	00100793          	li	a5,1
    8000853c:	00004717          	auipc	a4,0x4
    80008540:	72f72e23          	sw	a5,1852(a4) # 8000cc78 <panicked>
    80008544:	0000006f          	j	80008544 <panic+0x58>

0000000080008548 <__printf>:
    80008548:	f3010113          	addi	sp,sp,-208
    8000854c:	08813023          	sd	s0,128(sp)
    80008550:	07313423          	sd	s3,104(sp)
    80008554:	09010413          	addi	s0,sp,144
    80008558:	05813023          	sd	s8,64(sp)
    8000855c:	08113423          	sd	ra,136(sp)
    80008560:	06913c23          	sd	s1,120(sp)
    80008564:	07213823          	sd	s2,112(sp)
    80008568:	07413023          	sd	s4,96(sp)
    8000856c:	05513c23          	sd	s5,88(sp)
    80008570:	05613823          	sd	s6,80(sp)
    80008574:	05713423          	sd	s7,72(sp)
    80008578:	03913c23          	sd	s9,56(sp)
    8000857c:	03a13823          	sd	s10,48(sp)
    80008580:	03b13423          	sd	s11,40(sp)
    80008584:	00007317          	auipc	t1,0x7
    80008588:	ecc30313          	addi	t1,t1,-308 # 8000f450 <pr>
    8000858c:	01832c03          	lw	s8,24(t1)
    80008590:	00b43423          	sd	a1,8(s0)
    80008594:	00c43823          	sd	a2,16(s0)
    80008598:	00d43c23          	sd	a3,24(s0)
    8000859c:	02e43023          	sd	a4,32(s0)
    800085a0:	02f43423          	sd	a5,40(s0)
    800085a4:	03043823          	sd	a6,48(s0)
    800085a8:	03143c23          	sd	a7,56(s0)
    800085ac:	00050993          	mv	s3,a0
    800085b0:	4a0c1663          	bnez	s8,80008a5c <__printf+0x514>
    800085b4:	60098c63          	beqz	s3,80008bcc <__printf+0x684>
    800085b8:	0009c503          	lbu	a0,0(s3)
    800085bc:	00840793          	addi	a5,s0,8
    800085c0:	f6f43c23          	sd	a5,-136(s0)
    800085c4:	00000493          	li	s1,0
    800085c8:	22050063          	beqz	a0,800087e8 <__printf+0x2a0>
    800085cc:	00002a37          	lui	s4,0x2
    800085d0:	00018ab7          	lui	s5,0x18
    800085d4:	000f4b37          	lui	s6,0xf4
    800085d8:	00989bb7          	lui	s7,0x989
    800085dc:	70fa0a13          	addi	s4,s4,1807 # 270f <_entry-0x7fffd8f1>
    800085e0:	69fa8a93          	addi	s5,s5,1695 # 1869f <_entry-0x7ffe7961>
    800085e4:	23fb0b13          	addi	s6,s6,575 # f423f <_entry-0x7ff0bdc1>
    800085e8:	67fb8b93          	addi	s7,s7,1663 # 98967f <_entry-0x7f676981>
    800085ec:	00148c9b          	addiw	s9,s1,1
    800085f0:	02500793          	li	a5,37
    800085f4:	01998933          	add	s2,s3,s9
    800085f8:	38f51263          	bne	a0,a5,8000897c <__printf+0x434>
    800085fc:	00094783          	lbu	a5,0(s2)
    80008600:	00078c9b          	sext.w	s9,a5
    80008604:	1e078263          	beqz	a5,800087e8 <__printf+0x2a0>
    80008608:	0024849b          	addiw	s1,s1,2
    8000860c:	07000713          	li	a4,112
    80008610:	00998933          	add	s2,s3,s1
    80008614:	38e78a63          	beq	a5,a4,800089a8 <__printf+0x460>
    80008618:	20f76863          	bltu	a4,a5,80008828 <__printf+0x2e0>
    8000861c:	42a78863          	beq	a5,a0,80008a4c <__printf+0x504>
    80008620:	06400713          	li	a4,100
    80008624:	40e79663          	bne	a5,a4,80008a30 <__printf+0x4e8>
    80008628:	f7843783          	ld	a5,-136(s0)
    8000862c:	0007a603          	lw	a2,0(a5)
    80008630:	00878793          	addi	a5,a5,8
    80008634:	f6f43c23          	sd	a5,-136(s0)
    80008638:	42064a63          	bltz	a2,80008a6c <__printf+0x524>
    8000863c:	00a00713          	li	a4,10
    80008640:	02e677bb          	remuw	a5,a2,a4
    80008644:	00002d97          	auipc	s11,0x2
    80008648:	394d8d93          	addi	s11,s11,916 # 8000a9d8 <digits>
    8000864c:	00900593          	li	a1,9
    80008650:	0006051b          	sext.w	a0,a2
    80008654:	00000c93          	li	s9,0
    80008658:	02079793          	slli	a5,a5,0x20
    8000865c:	0207d793          	srli	a5,a5,0x20
    80008660:	00fd87b3          	add	a5,s11,a5
    80008664:	0007c783          	lbu	a5,0(a5)
    80008668:	02e656bb          	divuw	a3,a2,a4
    8000866c:	f8f40023          	sb	a5,-128(s0)
    80008670:	14c5d863          	bge	a1,a2,800087c0 <__printf+0x278>
    80008674:	06300593          	li	a1,99
    80008678:	00100c93          	li	s9,1
    8000867c:	02e6f7bb          	remuw	a5,a3,a4
    80008680:	02079793          	slli	a5,a5,0x20
    80008684:	0207d793          	srli	a5,a5,0x20
    80008688:	00fd87b3          	add	a5,s11,a5
    8000868c:	0007c783          	lbu	a5,0(a5)
    80008690:	02e6d73b          	divuw	a4,a3,a4
    80008694:	f8f400a3          	sb	a5,-127(s0)
    80008698:	12a5f463          	bgeu	a1,a0,800087c0 <__printf+0x278>
    8000869c:	00a00693          	li	a3,10
    800086a0:	00900593          	li	a1,9
    800086a4:	02d777bb          	remuw	a5,a4,a3
    800086a8:	02079793          	slli	a5,a5,0x20
    800086ac:	0207d793          	srli	a5,a5,0x20
    800086b0:	00fd87b3          	add	a5,s11,a5
    800086b4:	0007c503          	lbu	a0,0(a5)
    800086b8:	02d757bb          	divuw	a5,a4,a3
    800086bc:	f8a40123          	sb	a0,-126(s0)
    800086c0:	48e5f263          	bgeu	a1,a4,80008b44 <__printf+0x5fc>
    800086c4:	06300513          	li	a0,99
    800086c8:	02d7f5bb          	remuw	a1,a5,a3
    800086cc:	02059593          	slli	a1,a1,0x20
    800086d0:	0205d593          	srli	a1,a1,0x20
    800086d4:	00bd85b3          	add	a1,s11,a1
    800086d8:	0005c583          	lbu	a1,0(a1)
    800086dc:	02d7d7bb          	divuw	a5,a5,a3
    800086e0:	f8b401a3          	sb	a1,-125(s0)
    800086e4:	48e57263          	bgeu	a0,a4,80008b68 <__printf+0x620>
    800086e8:	3e700513          	li	a0,999
    800086ec:	02d7f5bb          	remuw	a1,a5,a3
    800086f0:	02059593          	slli	a1,a1,0x20
    800086f4:	0205d593          	srli	a1,a1,0x20
    800086f8:	00bd85b3          	add	a1,s11,a1
    800086fc:	0005c583          	lbu	a1,0(a1)
    80008700:	02d7d7bb          	divuw	a5,a5,a3
    80008704:	f8b40223          	sb	a1,-124(s0)
    80008708:	46e57663          	bgeu	a0,a4,80008b74 <__printf+0x62c>
    8000870c:	02d7f5bb          	remuw	a1,a5,a3
    80008710:	02059593          	slli	a1,a1,0x20
    80008714:	0205d593          	srli	a1,a1,0x20
    80008718:	00bd85b3          	add	a1,s11,a1
    8000871c:	0005c583          	lbu	a1,0(a1)
    80008720:	02d7d7bb          	divuw	a5,a5,a3
    80008724:	f8b402a3          	sb	a1,-123(s0)
    80008728:	46ea7863          	bgeu	s4,a4,80008b98 <__printf+0x650>
    8000872c:	02d7f5bb          	remuw	a1,a5,a3
    80008730:	02059593          	slli	a1,a1,0x20
    80008734:	0205d593          	srli	a1,a1,0x20
    80008738:	00bd85b3          	add	a1,s11,a1
    8000873c:	0005c583          	lbu	a1,0(a1)
    80008740:	02d7d7bb          	divuw	a5,a5,a3
    80008744:	f8b40323          	sb	a1,-122(s0)
    80008748:	3eeaf863          	bgeu	s5,a4,80008b38 <__printf+0x5f0>
    8000874c:	02d7f5bb          	remuw	a1,a5,a3
    80008750:	02059593          	slli	a1,a1,0x20
    80008754:	0205d593          	srli	a1,a1,0x20
    80008758:	00bd85b3          	add	a1,s11,a1
    8000875c:	0005c583          	lbu	a1,0(a1)
    80008760:	02d7d7bb          	divuw	a5,a5,a3
    80008764:	f8b403a3          	sb	a1,-121(s0)
    80008768:	42eb7e63          	bgeu	s6,a4,80008ba4 <__printf+0x65c>
    8000876c:	02d7f5bb          	remuw	a1,a5,a3
    80008770:	02059593          	slli	a1,a1,0x20
    80008774:	0205d593          	srli	a1,a1,0x20
    80008778:	00bd85b3          	add	a1,s11,a1
    8000877c:	0005c583          	lbu	a1,0(a1)
    80008780:	02d7d7bb          	divuw	a5,a5,a3
    80008784:	f8b40423          	sb	a1,-120(s0)
    80008788:	42ebfc63          	bgeu	s7,a4,80008bc0 <__printf+0x678>
    8000878c:	02079793          	slli	a5,a5,0x20
    80008790:	0207d793          	srli	a5,a5,0x20
    80008794:	00fd8db3          	add	s11,s11,a5
    80008798:	000dc703          	lbu	a4,0(s11)
    8000879c:	00a00793          	li	a5,10
    800087a0:	00900c93          	li	s9,9
    800087a4:	f8e404a3          	sb	a4,-119(s0)
    800087a8:	00065c63          	bgez	a2,800087c0 <__printf+0x278>
    800087ac:	f9040713          	addi	a4,s0,-112
    800087b0:	00f70733          	add	a4,a4,a5
    800087b4:	02d00693          	li	a3,45
    800087b8:	fed70823          	sb	a3,-16(a4)
    800087bc:	00078c93          	mv	s9,a5
    800087c0:	f8040793          	addi	a5,s0,-128
    800087c4:	01978cb3          	add	s9,a5,s9
    800087c8:	f7f40d13          	addi	s10,s0,-129
    800087cc:	000cc503          	lbu	a0,0(s9)
    800087d0:	fffc8c93          	addi	s9,s9,-1
    800087d4:	00000097          	auipc	ra,0x0
    800087d8:	b90080e7          	jalr	-1136(ra) # 80008364 <consputc>
    800087dc:	ffac98e3          	bne	s9,s10,800087cc <__printf+0x284>
    800087e0:	00094503          	lbu	a0,0(s2)
    800087e4:	e00514e3          	bnez	a0,800085ec <__printf+0xa4>
    800087e8:	1a0c1663          	bnez	s8,80008994 <__printf+0x44c>
    800087ec:	08813083          	ld	ra,136(sp)
    800087f0:	08013403          	ld	s0,128(sp)
    800087f4:	07813483          	ld	s1,120(sp)
    800087f8:	07013903          	ld	s2,112(sp)
    800087fc:	06813983          	ld	s3,104(sp)
    80008800:	06013a03          	ld	s4,96(sp)
    80008804:	05813a83          	ld	s5,88(sp)
    80008808:	05013b03          	ld	s6,80(sp)
    8000880c:	04813b83          	ld	s7,72(sp)
    80008810:	04013c03          	ld	s8,64(sp)
    80008814:	03813c83          	ld	s9,56(sp)
    80008818:	03013d03          	ld	s10,48(sp)
    8000881c:	02813d83          	ld	s11,40(sp)
    80008820:	0d010113          	addi	sp,sp,208
    80008824:	00008067          	ret
    80008828:	07300713          	li	a4,115
    8000882c:	1ce78a63          	beq	a5,a4,80008a00 <__printf+0x4b8>
    80008830:	07800713          	li	a4,120
    80008834:	1ee79e63          	bne	a5,a4,80008a30 <__printf+0x4e8>
    80008838:	f7843783          	ld	a5,-136(s0)
    8000883c:	0007a703          	lw	a4,0(a5)
    80008840:	00878793          	addi	a5,a5,8
    80008844:	f6f43c23          	sd	a5,-136(s0)
    80008848:	28074263          	bltz	a4,80008acc <__printf+0x584>
    8000884c:	00002d97          	auipc	s11,0x2
    80008850:	18cd8d93          	addi	s11,s11,396 # 8000a9d8 <digits>
    80008854:	00f77793          	andi	a5,a4,15
    80008858:	00fd87b3          	add	a5,s11,a5
    8000885c:	0007c683          	lbu	a3,0(a5)
    80008860:	00f00613          	li	a2,15
    80008864:	0007079b          	sext.w	a5,a4
    80008868:	f8d40023          	sb	a3,-128(s0)
    8000886c:	0047559b          	srliw	a1,a4,0x4
    80008870:	0047569b          	srliw	a3,a4,0x4
    80008874:	00000c93          	li	s9,0
    80008878:	0ee65063          	bge	a2,a4,80008958 <__printf+0x410>
    8000887c:	00f6f693          	andi	a3,a3,15
    80008880:	00dd86b3          	add	a3,s11,a3
    80008884:	0006c683          	lbu	a3,0(a3) # 2004000 <_entry-0x7dffc000>
    80008888:	0087d79b          	srliw	a5,a5,0x8
    8000888c:	00100c93          	li	s9,1
    80008890:	f8d400a3          	sb	a3,-127(s0)
    80008894:	0cb67263          	bgeu	a2,a1,80008958 <__printf+0x410>
    80008898:	00f7f693          	andi	a3,a5,15
    8000889c:	00dd86b3          	add	a3,s11,a3
    800088a0:	0006c583          	lbu	a1,0(a3)
    800088a4:	00f00613          	li	a2,15
    800088a8:	0047d69b          	srliw	a3,a5,0x4
    800088ac:	f8b40123          	sb	a1,-126(s0)
    800088b0:	0047d593          	srli	a1,a5,0x4
    800088b4:	28f67e63          	bgeu	a2,a5,80008b50 <__printf+0x608>
    800088b8:	00f6f693          	andi	a3,a3,15
    800088bc:	00dd86b3          	add	a3,s11,a3
    800088c0:	0006c503          	lbu	a0,0(a3)
    800088c4:	0087d813          	srli	a6,a5,0x8
    800088c8:	0087d69b          	srliw	a3,a5,0x8
    800088cc:	f8a401a3          	sb	a0,-125(s0)
    800088d0:	28b67663          	bgeu	a2,a1,80008b5c <__printf+0x614>
    800088d4:	00f6f693          	andi	a3,a3,15
    800088d8:	00dd86b3          	add	a3,s11,a3
    800088dc:	0006c583          	lbu	a1,0(a3)
    800088e0:	00c7d513          	srli	a0,a5,0xc
    800088e4:	00c7d69b          	srliw	a3,a5,0xc
    800088e8:	f8b40223          	sb	a1,-124(s0)
    800088ec:	29067a63          	bgeu	a2,a6,80008b80 <__printf+0x638>
    800088f0:	00f6f693          	andi	a3,a3,15
    800088f4:	00dd86b3          	add	a3,s11,a3
    800088f8:	0006c583          	lbu	a1,0(a3)
    800088fc:	0107d813          	srli	a6,a5,0x10
    80008900:	0107d69b          	srliw	a3,a5,0x10
    80008904:	f8b402a3          	sb	a1,-123(s0)
    80008908:	28a67263          	bgeu	a2,a0,80008b8c <__printf+0x644>
    8000890c:	00f6f693          	andi	a3,a3,15
    80008910:	00dd86b3          	add	a3,s11,a3
    80008914:	0006c683          	lbu	a3,0(a3)
    80008918:	0147d79b          	srliw	a5,a5,0x14
    8000891c:	f8d40323          	sb	a3,-122(s0)
    80008920:	21067663          	bgeu	a2,a6,80008b2c <__printf+0x5e4>
    80008924:	02079793          	slli	a5,a5,0x20
    80008928:	0207d793          	srli	a5,a5,0x20
    8000892c:	00fd8db3          	add	s11,s11,a5
    80008930:	000dc683          	lbu	a3,0(s11)
    80008934:	00800793          	li	a5,8
    80008938:	00700c93          	li	s9,7
    8000893c:	f8d403a3          	sb	a3,-121(s0)
    80008940:	00075c63          	bgez	a4,80008958 <__printf+0x410>
    80008944:	f9040713          	addi	a4,s0,-112
    80008948:	00f70733          	add	a4,a4,a5
    8000894c:	02d00693          	li	a3,45
    80008950:	fed70823          	sb	a3,-16(a4)
    80008954:	00078c93          	mv	s9,a5
    80008958:	f8040793          	addi	a5,s0,-128
    8000895c:	01978cb3          	add	s9,a5,s9
    80008960:	f7f40d13          	addi	s10,s0,-129
    80008964:	000cc503          	lbu	a0,0(s9)
    80008968:	fffc8c93          	addi	s9,s9,-1
    8000896c:	00000097          	auipc	ra,0x0
    80008970:	9f8080e7          	jalr	-1544(ra) # 80008364 <consputc>
    80008974:	ff9d18e3          	bne	s10,s9,80008964 <__printf+0x41c>
    80008978:	0100006f          	j	80008988 <__printf+0x440>
    8000897c:	00000097          	auipc	ra,0x0
    80008980:	9e8080e7          	jalr	-1560(ra) # 80008364 <consputc>
    80008984:	000c8493          	mv	s1,s9
    80008988:	00094503          	lbu	a0,0(s2)
    8000898c:	c60510e3          	bnez	a0,800085ec <__printf+0xa4>
    80008990:	e40c0ee3          	beqz	s8,800087ec <__printf+0x2a4>
    80008994:	00007517          	auipc	a0,0x7
    80008998:	abc50513          	addi	a0,a0,-1348 # 8000f450 <pr>
    8000899c:	00001097          	auipc	ra,0x1
    800089a0:	94c080e7          	jalr	-1716(ra) # 800092e8 <release>
    800089a4:	e49ff06f          	j	800087ec <__printf+0x2a4>
    800089a8:	f7843783          	ld	a5,-136(s0)
    800089ac:	03000513          	li	a0,48
    800089b0:	01000d13          	li	s10,16
    800089b4:	00878713          	addi	a4,a5,8
    800089b8:	0007bc83          	ld	s9,0(a5)
    800089bc:	f6e43c23          	sd	a4,-136(s0)
    800089c0:	00000097          	auipc	ra,0x0
    800089c4:	9a4080e7          	jalr	-1628(ra) # 80008364 <consputc>
    800089c8:	07800513          	li	a0,120
    800089cc:	00000097          	auipc	ra,0x0
    800089d0:	998080e7          	jalr	-1640(ra) # 80008364 <consputc>
    800089d4:	00002d97          	auipc	s11,0x2
    800089d8:	004d8d93          	addi	s11,s11,4 # 8000a9d8 <digits>
    800089dc:	03ccd793          	srli	a5,s9,0x3c
    800089e0:	00fd87b3          	add	a5,s11,a5
    800089e4:	0007c503          	lbu	a0,0(a5)
    800089e8:	fffd0d1b          	addiw	s10,s10,-1
    800089ec:	004c9c93          	slli	s9,s9,0x4
    800089f0:	00000097          	auipc	ra,0x0
    800089f4:	974080e7          	jalr	-1676(ra) # 80008364 <consputc>
    800089f8:	fe0d12e3          	bnez	s10,800089dc <__printf+0x494>
    800089fc:	f8dff06f          	j	80008988 <__printf+0x440>
    80008a00:	f7843783          	ld	a5,-136(s0)
    80008a04:	0007bc83          	ld	s9,0(a5)
    80008a08:	00878793          	addi	a5,a5,8
    80008a0c:	f6f43c23          	sd	a5,-136(s0)
    80008a10:	000c9a63          	bnez	s9,80008a24 <__printf+0x4dc>
    80008a14:	1080006f          	j	80008b1c <__printf+0x5d4>
    80008a18:	001c8c93          	addi	s9,s9,1
    80008a1c:	00000097          	auipc	ra,0x0
    80008a20:	948080e7          	jalr	-1720(ra) # 80008364 <consputc>
    80008a24:	000cc503          	lbu	a0,0(s9)
    80008a28:	fe0518e3          	bnez	a0,80008a18 <__printf+0x4d0>
    80008a2c:	f5dff06f          	j	80008988 <__printf+0x440>
    80008a30:	02500513          	li	a0,37
    80008a34:	00000097          	auipc	ra,0x0
    80008a38:	930080e7          	jalr	-1744(ra) # 80008364 <consputc>
    80008a3c:	000c8513          	mv	a0,s9
    80008a40:	00000097          	auipc	ra,0x0
    80008a44:	924080e7          	jalr	-1756(ra) # 80008364 <consputc>
    80008a48:	f41ff06f          	j	80008988 <__printf+0x440>
    80008a4c:	02500513          	li	a0,37
    80008a50:	00000097          	auipc	ra,0x0
    80008a54:	914080e7          	jalr	-1772(ra) # 80008364 <consputc>
    80008a58:	f31ff06f          	j	80008988 <__printf+0x440>
    80008a5c:	00030513          	mv	a0,t1
    80008a60:	00000097          	auipc	ra,0x0
    80008a64:	7bc080e7          	jalr	1980(ra) # 8000921c <acquire>
    80008a68:	b4dff06f          	j	800085b4 <__printf+0x6c>
    80008a6c:	40c0053b          	negw	a0,a2
    80008a70:	00a00713          	li	a4,10
    80008a74:	02e576bb          	remuw	a3,a0,a4
    80008a78:	00002d97          	auipc	s11,0x2
    80008a7c:	f60d8d93          	addi	s11,s11,-160 # 8000a9d8 <digits>
    80008a80:	ff700593          	li	a1,-9
    80008a84:	02069693          	slli	a3,a3,0x20
    80008a88:	0206d693          	srli	a3,a3,0x20
    80008a8c:	00dd86b3          	add	a3,s11,a3
    80008a90:	0006c683          	lbu	a3,0(a3)
    80008a94:	02e557bb          	divuw	a5,a0,a4
    80008a98:	f8d40023          	sb	a3,-128(s0)
    80008a9c:	10b65e63          	bge	a2,a1,80008bb8 <__printf+0x670>
    80008aa0:	06300593          	li	a1,99
    80008aa4:	02e7f6bb          	remuw	a3,a5,a4
    80008aa8:	02069693          	slli	a3,a3,0x20
    80008aac:	0206d693          	srli	a3,a3,0x20
    80008ab0:	00dd86b3          	add	a3,s11,a3
    80008ab4:	0006c683          	lbu	a3,0(a3)
    80008ab8:	02e7d73b          	divuw	a4,a5,a4
    80008abc:	00200793          	li	a5,2
    80008ac0:	f8d400a3          	sb	a3,-127(s0)
    80008ac4:	bca5ece3          	bltu	a1,a0,8000869c <__printf+0x154>
    80008ac8:	ce5ff06f          	j	800087ac <__printf+0x264>
    80008acc:	40e007bb          	negw	a5,a4
    80008ad0:	00002d97          	auipc	s11,0x2
    80008ad4:	f08d8d93          	addi	s11,s11,-248 # 8000a9d8 <digits>
    80008ad8:	00f7f693          	andi	a3,a5,15
    80008adc:	00dd86b3          	add	a3,s11,a3
    80008ae0:	0006c583          	lbu	a1,0(a3)
    80008ae4:	ff100613          	li	a2,-15
    80008ae8:	0047d69b          	srliw	a3,a5,0x4
    80008aec:	f8b40023          	sb	a1,-128(s0)
    80008af0:	0047d59b          	srliw	a1,a5,0x4
    80008af4:	0ac75e63          	bge	a4,a2,80008bb0 <__printf+0x668>
    80008af8:	00f6f693          	andi	a3,a3,15
    80008afc:	00dd86b3          	add	a3,s11,a3
    80008b00:	0006c603          	lbu	a2,0(a3)
    80008b04:	00f00693          	li	a3,15
    80008b08:	0087d79b          	srliw	a5,a5,0x8
    80008b0c:	f8c400a3          	sb	a2,-127(s0)
    80008b10:	d8b6e4e3          	bltu	a3,a1,80008898 <__printf+0x350>
    80008b14:	00200793          	li	a5,2
    80008b18:	e2dff06f          	j	80008944 <__printf+0x3fc>
    80008b1c:	00002c97          	auipc	s9,0x2
    80008b20:	e9cc8c93          	addi	s9,s9,-356 # 8000a9b8 <CONSOLE_STATUS+0x9a8>
    80008b24:	02800513          	li	a0,40
    80008b28:	ef1ff06f          	j	80008a18 <__printf+0x4d0>
    80008b2c:	00700793          	li	a5,7
    80008b30:	00600c93          	li	s9,6
    80008b34:	e0dff06f          	j	80008940 <__printf+0x3f8>
    80008b38:	00700793          	li	a5,7
    80008b3c:	00600c93          	li	s9,6
    80008b40:	c69ff06f          	j	800087a8 <__printf+0x260>
    80008b44:	00300793          	li	a5,3
    80008b48:	00200c93          	li	s9,2
    80008b4c:	c5dff06f          	j	800087a8 <__printf+0x260>
    80008b50:	00300793          	li	a5,3
    80008b54:	00200c93          	li	s9,2
    80008b58:	de9ff06f          	j	80008940 <__printf+0x3f8>
    80008b5c:	00400793          	li	a5,4
    80008b60:	00300c93          	li	s9,3
    80008b64:	dddff06f          	j	80008940 <__printf+0x3f8>
    80008b68:	00400793          	li	a5,4
    80008b6c:	00300c93          	li	s9,3
    80008b70:	c39ff06f          	j	800087a8 <__printf+0x260>
    80008b74:	00500793          	li	a5,5
    80008b78:	00400c93          	li	s9,4
    80008b7c:	c2dff06f          	j	800087a8 <__printf+0x260>
    80008b80:	00500793          	li	a5,5
    80008b84:	00400c93          	li	s9,4
    80008b88:	db9ff06f          	j	80008940 <__printf+0x3f8>
    80008b8c:	00600793          	li	a5,6
    80008b90:	00500c93          	li	s9,5
    80008b94:	dadff06f          	j	80008940 <__printf+0x3f8>
    80008b98:	00600793          	li	a5,6
    80008b9c:	00500c93          	li	s9,5
    80008ba0:	c09ff06f          	j	800087a8 <__printf+0x260>
    80008ba4:	00800793          	li	a5,8
    80008ba8:	00700c93          	li	s9,7
    80008bac:	bfdff06f          	j	800087a8 <__printf+0x260>
    80008bb0:	00100793          	li	a5,1
    80008bb4:	d91ff06f          	j	80008944 <__printf+0x3fc>
    80008bb8:	00100793          	li	a5,1
    80008bbc:	bf1ff06f          	j	800087ac <__printf+0x264>
    80008bc0:	00900793          	li	a5,9
    80008bc4:	00800c93          	li	s9,8
    80008bc8:	be1ff06f          	j	800087a8 <__printf+0x260>
    80008bcc:	00002517          	auipc	a0,0x2
    80008bd0:	df450513          	addi	a0,a0,-524 # 8000a9c0 <CONSOLE_STATUS+0x9b0>
    80008bd4:	00000097          	auipc	ra,0x0
    80008bd8:	918080e7          	jalr	-1768(ra) # 800084ec <panic>

0000000080008bdc <printfinit>:
    80008bdc:	fe010113          	addi	sp,sp,-32
    80008be0:	00813823          	sd	s0,16(sp)
    80008be4:	00913423          	sd	s1,8(sp)
    80008be8:	00113c23          	sd	ra,24(sp)
    80008bec:	02010413          	addi	s0,sp,32
    80008bf0:	00007497          	auipc	s1,0x7
    80008bf4:	86048493          	addi	s1,s1,-1952 # 8000f450 <pr>
    80008bf8:	00048513          	mv	a0,s1
    80008bfc:	00002597          	auipc	a1,0x2
    80008c00:	dd458593          	addi	a1,a1,-556 # 8000a9d0 <CONSOLE_STATUS+0x9c0>
    80008c04:	00000097          	auipc	ra,0x0
    80008c08:	5f4080e7          	jalr	1524(ra) # 800091f8 <initlock>
    80008c0c:	01813083          	ld	ra,24(sp)
    80008c10:	01013403          	ld	s0,16(sp)
    80008c14:	0004ac23          	sw	zero,24(s1)
    80008c18:	00813483          	ld	s1,8(sp)
    80008c1c:	02010113          	addi	sp,sp,32
    80008c20:	00008067          	ret

0000000080008c24 <uartinit>:
    80008c24:	ff010113          	addi	sp,sp,-16
    80008c28:	00813423          	sd	s0,8(sp)
    80008c2c:	01010413          	addi	s0,sp,16
    80008c30:	100007b7          	lui	a5,0x10000
    80008c34:	000780a3          	sb	zero,1(a5) # 10000001 <_entry-0x6fffffff>
    80008c38:	f8000713          	li	a4,-128
    80008c3c:	00e781a3          	sb	a4,3(a5)
    80008c40:	00300713          	li	a4,3
    80008c44:	00e78023          	sb	a4,0(a5)
    80008c48:	000780a3          	sb	zero,1(a5)
    80008c4c:	00e781a3          	sb	a4,3(a5)
    80008c50:	00700693          	li	a3,7
    80008c54:	00d78123          	sb	a3,2(a5)
    80008c58:	00e780a3          	sb	a4,1(a5)
    80008c5c:	00813403          	ld	s0,8(sp)
    80008c60:	01010113          	addi	sp,sp,16
    80008c64:	00008067          	ret

0000000080008c68 <uartputc>:
    80008c68:	00004797          	auipc	a5,0x4
    80008c6c:	0107a783          	lw	a5,16(a5) # 8000cc78 <panicked>
    80008c70:	00078463          	beqz	a5,80008c78 <uartputc+0x10>
    80008c74:	0000006f          	j	80008c74 <uartputc+0xc>
    80008c78:	fd010113          	addi	sp,sp,-48
    80008c7c:	02813023          	sd	s0,32(sp)
    80008c80:	00913c23          	sd	s1,24(sp)
    80008c84:	01213823          	sd	s2,16(sp)
    80008c88:	01313423          	sd	s3,8(sp)
    80008c8c:	02113423          	sd	ra,40(sp)
    80008c90:	03010413          	addi	s0,sp,48
    80008c94:	00004917          	auipc	s2,0x4
    80008c98:	fec90913          	addi	s2,s2,-20 # 8000cc80 <uart_tx_r>
    80008c9c:	00093783          	ld	a5,0(s2)
    80008ca0:	00004497          	auipc	s1,0x4
    80008ca4:	fe848493          	addi	s1,s1,-24 # 8000cc88 <uart_tx_w>
    80008ca8:	0004b703          	ld	a4,0(s1)
    80008cac:	02078693          	addi	a3,a5,32
    80008cb0:	00050993          	mv	s3,a0
    80008cb4:	02e69c63          	bne	a3,a4,80008cec <uartputc+0x84>
    80008cb8:	00001097          	auipc	ra,0x1
    80008cbc:	834080e7          	jalr	-1996(ra) # 800094ec <push_on>
    80008cc0:	00093783          	ld	a5,0(s2)
    80008cc4:	0004b703          	ld	a4,0(s1)
    80008cc8:	02078793          	addi	a5,a5,32
    80008ccc:	00e79463          	bne	a5,a4,80008cd4 <uartputc+0x6c>
    80008cd0:	0000006f          	j	80008cd0 <uartputc+0x68>
    80008cd4:	00001097          	auipc	ra,0x1
    80008cd8:	88c080e7          	jalr	-1908(ra) # 80009560 <pop_on>
    80008cdc:	00093783          	ld	a5,0(s2)
    80008ce0:	0004b703          	ld	a4,0(s1)
    80008ce4:	02078693          	addi	a3,a5,32
    80008ce8:	fce688e3          	beq	a3,a4,80008cb8 <uartputc+0x50>
    80008cec:	01f77693          	andi	a3,a4,31
    80008cf0:	00006597          	auipc	a1,0x6
    80008cf4:	78058593          	addi	a1,a1,1920 # 8000f470 <uart_tx_buf>
    80008cf8:	00d586b3          	add	a3,a1,a3
    80008cfc:	00170713          	addi	a4,a4,1
    80008d00:	01368023          	sb	s3,0(a3)
    80008d04:	00e4b023          	sd	a4,0(s1)
    80008d08:	10000637          	lui	a2,0x10000
    80008d0c:	02f71063          	bne	a4,a5,80008d2c <uartputc+0xc4>
    80008d10:	0340006f          	j	80008d44 <uartputc+0xdc>
    80008d14:	00074703          	lbu	a4,0(a4)
    80008d18:	00f93023          	sd	a5,0(s2)
    80008d1c:	00e60023          	sb	a4,0(a2) # 10000000 <_entry-0x70000000>
    80008d20:	00093783          	ld	a5,0(s2)
    80008d24:	0004b703          	ld	a4,0(s1)
    80008d28:	00f70e63          	beq	a4,a5,80008d44 <uartputc+0xdc>
    80008d2c:	00564683          	lbu	a3,5(a2)
    80008d30:	01f7f713          	andi	a4,a5,31
    80008d34:	00e58733          	add	a4,a1,a4
    80008d38:	0206f693          	andi	a3,a3,32
    80008d3c:	00178793          	addi	a5,a5,1
    80008d40:	fc069ae3          	bnez	a3,80008d14 <uartputc+0xac>
    80008d44:	02813083          	ld	ra,40(sp)
    80008d48:	02013403          	ld	s0,32(sp)
    80008d4c:	01813483          	ld	s1,24(sp)
    80008d50:	01013903          	ld	s2,16(sp)
    80008d54:	00813983          	ld	s3,8(sp)
    80008d58:	03010113          	addi	sp,sp,48
    80008d5c:	00008067          	ret

0000000080008d60 <uartputc_sync>:
    80008d60:	ff010113          	addi	sp,sp,-16
    80008d64:	00813423          	sd	s0,8(sp)
    80008d68:	01010413          	addi	s0,sp,16
    80008d6c:	00004717          	auipc	a4,0x4
    80008d70:	f0c72703          	lw	a4,-244(a4) # 8000cc78 <panicked>
    80008d74:	02071663          	bnez	a4,80008da0 <uartputc_sync+0x40>
    80008d78:	00050793          	mv	a5,a0
    80008d7c:	100006b7          	lui	a3,0x10000
    80008d80:	0056c703          	lbu	a4,5(a3) # 10000005 <_entry-0x6ffffffb>
    80008d84:	02077713          	andi	a4,a4,32
    80008d88:	fe070ce3          	beqz	a4,80008d80 <uartputc_sync+0x20>
    80008d8c:	0ff7f793          	andi	a5,a5,255
    80008d90:	00f68023          	sb	a5,0(a3)
    80008d94:	00813403          	ld	s0,8(sp)
    80008d98:	01010113          	addi	sp,sp,16
    80008d9c:	00008067          	ret
    80008da0:	0000006f          	j	80008da0 <uartputc_sync+0x40>

0000000080008da4 <uartstart>:
    80008da4:	ff010113          	addi	sp,sp,-16
    80008da8:	00813423          	sd	s0,8(sp)
    80008dac:	01010413          	addi	s0,sp,16
    80008db0:	00004617          	auipc	a2,0x4
    80008db4:	ed060613          	addi	a2,a2,-304 # 8000cc80 <uart_tx_r>
    80008db8:	00004517          	auipc	a0,0x4
    80008dbc:	ed050513          	addi	a0,a0,-304 # 8000cc88 <uart_tx_w>
    80008dc0:	00063783          	ld	a5,0(a2)
    80008dc4:	00053703          	ld	a4,0(a0)
    80008dc8:	04f70263          	beq	a4,a5,80008e0c <uartstart+0x68>
    80008dcc:	100005b7          	lui	a1,0x10000
    80008dd0:	00006817          	auipc	a6,0x6
    80008dd4:	6a080813          	addi	a6,a6,1696 # 8000f470 <uart_tx_buf>
    80008dd8:	01c0006f          	j	80008df4 <uartstart+0x50>
    80008ddc:	0006c703          	lbu	a4,0(a3)
    80008de0:	00f63023          	sd	a5,0(a2)
    80008de4:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    80008de8:	00063783          	ld	a5,0(a2)
    80008dec:	00053703          	ld	a4,0(a0)
    80008df0:	00f70e63          	beq	a4,a5,80008e0c <uartstart+0x68>
    80008df4:	01f7f713          	andi	a4,a5,31
    80008df8:	00e806b3          	add	a3,a6,a4
    80008dfc:	0055c703          	lbu	a4,5(a1)
    80008e00:	00178793          	addi	a5,a5,1
    80008e04:	02077713          	andi	a4,a4,32
    80008e08:	fc071ae3          	bnez	a4,80008ddc <uartstart+0x38>
    80008e0c:	00813403          	ld	s0,8(sp)
    80008e10:	01010113          	addi	sp,sp,16
    80008e14:	00008067          	ret

0000000080008e18 <uartgetc>:
    80008e18:	ff010113          	addi	sp,sp,-16
    80008e1c:	00813423          	sd	s0,8(sp)
    80008e20:	01010413          	addi	s0,sp,16
    80008e24:	10000737          	lui	a4,0x10000
    80008e28:	00574783          	lbu	a5,5(a4) # 10000005 <_entry-0x6ffffffb>
    80008e2c:	0017f793          	andi	a5,a5,1
    80008e30:	00078c63          	beqz	a5,80008e48 <uartgetc+0x30>
    80008e34:	00074503          	lbu	a0,0(a4)
    80008e38:	0ff57513          	andi	a0,a0,255
    80008e3c:	00813403          	ld	s0,8(sp)
    80008e40:	01010113          	addi	sp,sp,16
    80008e44:	00008067          	ret
    80008e48:	fff00513          	li	a0,-1
    80008e4c:	ff1ff06f          	j	80008e3c <uartgetc+0x24>

0000000080008e50 <uartintr>:
    80008e50:	100007b7          	lui	a5,0x10000
    80008e54:	0057c783          	lbu	a5,5(a5) # 10000005 <_entry-0x6ffffffb>
    80008e58:	0017f793          	andi	a5,a5,1
    80008e5c:	0a078463          	beqz	a5,80008f04 <uartintr+0xb4>
    80008e60:	fe010113          	addi	sp,sp,-32
    80008e64:	00813823          	sd	s0,16(sp)
    80008e68:	00913423          	sd	s1,8(sp)
    80008e6c:	00113c23          	sd	ra,24(sp)
    80008e70:	02010413          	addi	s0,sp,32
    80008e74:	100004b7          	lui	s1,0x10000
    80008e78:	0004c503          	lbu	a0,0(s1) # 10000000 <_entry-0x70000000>
    80008e7c:	0ff57513          	andi	a0,a0,255
    80008e80:	fffff097          	auipc	ra,0xfffff
    80008e84:	534080e7          	jalr	1332(ra) # 800083b4 <consoleintr>
    80008e88:	0054c783          	lbu	a5,5(s1)
    80008e8c:	0017f793          	andi	a5,a5,1
    80008e90:	fe0794e3          	bnez	a5,80008e78 <uartintr+0x28>
    80008e94:	00004617          	auipc	a2,0x4
    80008e98:	dec60613          	addi	a2,a2,-532 # 8000cc80 <uart_tx_r>
    80008e9c:	00004517          	auipc	a0,0x4
    80008ea0:	dec50513          	addi	a0,a0,-532 # 8000cc88 <uart_tx_w>
    80008ea4:	00063783          	ld	a5,0(a2)
    80008ea8:	00053703          	ld	a4,0(a0)
    80008eac:	04f70263          	beq	a4,a5,80008ef0 <uartintr+0xa0>
    80008eb0:	100005b7          	lui	a1,0x10000
    80008eb4:	00006817          	auipc	a6,0x6
    80008eb8:	5bc80813          	addi	a6,a6,1468 # 8000f470 <uart_tx_buf>
    80008ebc:	01c0006f          	j	80008ed8 <uartintr+0x88>
    80008ec0:	0006c703          	lbu	a4,0(a3)
    80008ec4:	00f63023          	sd	a5,0(a2)
    80008ec8:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    80008ecc:	00063783          	ld	a5,0(a2)
    80008ed0:	00053703          	ld	a4,0(a0)
    80008ed4:	00f70e63          	beq	a4,a5,80008ef0 <uartintr+0xa0>
    80008ed8:	01f7f713          	andi	a4,a5,31
    80008edc:	00e806b3          	add	a3,a6,a4
    80008ee0:	0055c703          	lbu	a4,5(a1)
    80008ee4:	00178793          	addi	a5,a5,1
    80008ee8:	02077713          	andi	a4,a4,32
    80008eec:	fc071ae3          	bnez	a4,80008ec0 <uartintr+0x70>
    80008ef0:	01813083          	ld	ra,24(sp)
    80008ef4:	01013403          	ld	s0,16(sp)
    80008ef8:	00813483          	ld	s1,8(sp)
    80008efc:	02010113          	addi	sp,sp,32
    80008f00:	00008067          	ret
    80008f04:	00004617          	auipc	a2,0x4
    80008f08:	d7c60613          	addi	a2,a2,-644 # 8000cc80 <uart_tx_r>
    80008f0c:	00004517          	auipc	a0,0x4
    80008f10:	d7c50513          	addi	a0,a0,-644 # 8000cc88 <uart_tx_w>
    80008f14:	00063783          	ld	a5,0(a2)
    80008f18:	00053703          	ld	a4,0(a0)
    80008f1c:	04f70263          	beq	a4,a5,80008f60 <uartintr+0x110>
    80008f20:	100005b7          	lui	a1,0x10000
    80008f24:	00006817          	auipc	a6,0x6
    80008f28:	54c80813          	addi	a6,a6,1356 # 8000f470 <uart_tx_buf>
    80008f2c:	01c0006f          	j	80008f48 <uartintr+0xf8>
    80008f30:	0006c703          	lbu	a4,0(a3)
    80008f34:	00f63023          	sd	a5,0(a2)
    80008f38:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    80008f3c:	00063783          	ld	a5,0(a2)
    80008f40:	00053703          	ld	a4,0(a0)
    80008f44:	02f70063          	beq	a4,a5,80008f64 <uartintr+0x114>
    80008f48:	01f7f713          	andi	a4,a5,31
    80008f4c:	00e806b3          	add	a3,a6,a4
    80008f50:	0055c703          	lbu	a4,5(a1)
    80008f54:	00178793          	addi	a5,a5,1
    80008f58:	02077713          	andi	a4,a4,32
    80008f5c:	fc071ae3          	bnez	a4,80008f30 <uartintr+0xe0>
    80008f60:	00008067          	ret
    80008f64:	00008067          	ret

0000000080008f68 <kinit>:
    80008f68:	fc010113          	addi	sp,sp,-64
    80008f6c:	02913423          	sd	s1,40(sp)
    80008f70:	fffff7b7          	lui	a5,0xfffff
    80008f74:	00007497          	auipc	s1,0x7
    80008f78:	51b48493          	addi	s1,s1,1307 # 8001048f <end+0xfff>
    80008f7c:	02813823          	sd	s0,48(sp)
    80008f80:	01313c23          	sd	s3,24(sp)
    80008f84:	00f4f4b3          	and	s1,s1,a5
    80008f88:	02113c23          	sd	ra,56(sp)
    80008f8c:	03213023          	sd	s2,32(sp)
    80008f90:	01413823          	sd	s4,16(sp)
    80008f94:	01513423          	sd	s5,8(sp)
    80008f98:	04010413          	addi	s0,sp,64
    80008f9c:	000017b7          	lui	a5,0x1
    80008fa0:	01100993          	li	s3,17
    80008fa4:	00f487b3          	add	a5,s1,a5
    80008fa8:	01b99993          	slli	s3,s3,0x1b
    80008fac:	06f9e063          	bltu	s3,a5,8000900c <kinit+0xa4>
    80008fb0:	00006a97          	auipc	s5,0x6
    80008fb4:	4e0a8a93          	addi	s5,s5,1248 # 8000f490 <end>
    80008fb8:	0754ec63          	bltu	s1,s5,80009030 <kinit+0xc8>
    80008fbc:	0734fa63          	bgeu	s1,s3,80009030 <kinit+0xc8>
    80008fc0:	00088a37          	lui	s4,0x88
    80008fc4:	fffa0a13          	addi	s4,s4,-1 # 87fff <_entry-0x7ff78001>
    80008fc8:	00004917          	auipc	s2,0x4
    80008fcc:	cc890913          	addi	s2,s2,-824 # 8000cc90 <kmem>
    80008fd0:	00ca1a13          	slli	s4,s4,0xc
    80008fd4:	0140006f          	j	80008fe8 <kinit+0x80>
    80008fd8:	000017b7          	lui	a5,0x1
    80008fdc:	00f484b3          	add	s1,s1,a5
    80008fe0:	0554e863          	bltu	s1,s5,80009030 <kinit+0xc8>
    80008fe4:	0534f663          	bgeu	s1,s3,80009030 <kinit+0xc8>
    80008fe8:	00001637          	lui	a2,0x1
    80008fec:	00100593          	li	a1,1
    80008ff0:	00048513          	mv	a0,s1
    80008ff4:	00000097          	auipc	ra,0x0
    80008ff8:	5e4080e7          	jalr	1508(ra) # 800095d8 <__memset>
    80008ffc:	00093783          	ld	a5,0(s2)
    80009000:	00f4b023          	sd	a5,0(s1)
    80009004:	00993023          	sd	s1,0(s2)
    80009008:	fd4498e3          	bne	s1,s4,80008fd8 <kinit+0x70>
    8000900c:	03813083          	ld	ra,56(sp)
    80009010:	03013403          	ld	s0,48(sp)
    80009014:	02813483          	ld	s1,40(sp)
    80009018:	02013903          	ld	s2,32(sp)
    8000901c:	01813983          	ld	s3,24(sp)
    80009020:	01013a03          	ld	s4,16(sp)
    80009024:	00813a83          	ld	s5,8(sp)
    80009028:	04010113          	addi	sp,sp,64
    8000902c:	00008067          	ret
    80009030:	00002517          	auipc	a0,0x2
    80009034:	9c050513          	addi	a0,a0,-1600 # 8000a9f0 <digits+0x18>
    80009038:	fffff097          	auipc	ra,0xfffff
    8000903c:	4b4080e7          	jalr	1204(ra) # 800084ec <panic>

0000000080009040 <freerange>:
    80009040:	fc010113          	addi	sp,sp,-64
    80009044:	000017b7          	lui	a5,0x1
    80009048:	02913423          	sd	s1,40(sp)
    8000904c:	fff78493          	addi	s1,a5,-1 # fff <_entry-0x7ffff001>
    80009050:	009504b3          	add	s1,a0,s1
    80009054:	fffff537          	lui	a0,0xfffff
    80009058:	02813823          	sd	s0,48(sp)
    8000905c:	02113c23          	sd	ra,56(sp)
    80009060:	03213023          	sd	s2,32(sp)
    80009064:	01313c23          	sd	s3,24(sp)
    80009068:	01413823          	sd	s4,16(sp)
    8000906c:	01513423          	sd	s5,8(sp)
    80009070:	01613023          	sd	s6,0(sp)
    80009074:	04010413          	addi	s0,sp,64
    80009078:	00a4f4b3          	and	s1,s1,a0
    8000907c:	00f487b3          	add	a5,s1,a5
    80009080:	06f5e463          	bltu	a1,a5,800090e8 <freerange+0xa8>
    80009084:	00006a97          	auipc	s5,0x6
    80009088:	40ca8a93          	addi	s5,s5,1036 # 8000f490 <end>
    8000908c:	0954e263          	bltu	s1,s5,80009110 <freerange+0xd0>
    80009090:	01100993          	li	s3,17
    80009094:	01b99993          	slli	s3,s3,0x1b
    80009098:	0734fc63          	bgeu	s1,s3,80009110 <freerange+0xd0>
    8000909c:	00058a13          	mv	s4,a1
    800090a0:	00004917          	auipc	s2,0x4
    800090a4:	bf090913          	addi	s2,s2,-1040 # 8000cc90 <kmem>
    800090a8:	00002b37          	lui	s6,0x2
    800090ac:	0140006f          	j	800090c0 <freerange+0x80>
    800090b0:	000017b7          	lui	a5,0x1
    800090b4:	00f484b3          	add	s1,s1,a5
    800090b8:	0554ec63          	bltu	s1,s5,80009110 <freerange+0xd0>
    800090bc:	0534fa63          	bgeu	s1,s3,80009110 <freerange+0xd0>
    800090c0:	00001637          	lui	a2,0x1
    800090c4:	00100593          	li	a1,1
    800090c8:	00048513          	mv	a0,s1
    800090cc:	00000097          	auipc	ra,0x0
    800090d0:	50c080e7          	jalr	1292(ra) # 800095d8 <__memset>
    800090d4:	00093703          	ld	a4,0(s2)
    800090d8:	016487b3          	add	a5,s1,s6
    800090dc:	00e4b023          	sd	a4,0(s1)
    800090e0:	00993023          	sd	s1,0(s2)
    800090e4:	fcfa76e3          	bgeu	s4,a5,800090b0 <freerange+0x70>
    800090e8:	03813083          	ld	ra,56(sp)
    800090ec:	03013403          	ld	s0,48(sp)
    800090f0:	02813483          	ld	s1,40(sp)
    800090f4:	02013903          	ld	s2,32(sp)
    800090f8:	01813983          	ld	s3,24(sp)
    800090fc:	01013a03          	ld	s4,16(sp)
    80009100:	00813a83          	ld	s5,8(sp)
    80009104:	00013b03          	ld	s6,0(sp)
    80009108:	04010113          	addi	sp,sp,64
    8000910c:	00008067          	ret
    80009110:	00002517          	auipc	a0,0x2
    80009114:	8e050513          	addi	a0,a0,-1824 # 8000a9f0 <digits+0x18>
    80009118:	fffff097          	auipc	ra,0xfffff
    8000911c:	3d4080e7          	jalr	980(ra) # 800084ec <panic>

0000000080009120 <kfree>:
    80009120:	fe010113          	addi	sp,sp,-32
    80009124:	00813823          	sd	s0,16(sp)
    80009128:	00113c23          	sd	ra,24(sp)
    8000912c:	00913423          	sd	s1,8(sp)
    80009130:	02010413          	addi	s0,sp,32
    80009134:	03451793          	slli	a5,a0,0x34
    80009138:	04079c63          	bnez	a5,80009190 <kfree+0x70>
    8000913c:	00006797          	auipc	a5,0x6
    80009140:	35478793          	addi	a5,a5,852 # 8000f490 <end>
    80009144:	00050493          	mv	s1,a0
    80009148:	04f56463          	bltu	a0,a5,80009190 <kfree+0x70>
    8000914c:	01100793          	li	a5,17
    80009150:	01b79793          	slli	a5,a5,0x1b
    80009154:	02f57e63          	bgeu	a0,a5,80009190 <kfree+0x70>
    80009158:	00001637          	lui	a2,0x1
    8000915c:	00100593          	li	a1,1
    80009160:	00000097          	auipc	ra,0x0
    80009164:	478080e7          	jalr	1144(ra) # 800095d8 <__memset>
    80009168:	00004797          	auipc	a5,0x4
    8000916c:	b2878793          	addi	a5,a5,-1240 # 8000cc90 <kmem>
    80009170:	0007b703          	ld	a4,0(a5)
    80009174:	01813083          	ld	ra,24(sp)
    80009178:	01013403          	ld	s0,16(sp)
    8000917c:	00e4b023          	sd	a4,0(s1)
    80009180:	0097b023          	sd	s1,0(a5)
    80009184:	00813483          	ld	s1,8(sp)
    80009188:	02010113          	addi	sp,sp,32
    8000918c:	00008067          	ret
    80009190:	00002517          	auipc	a0,0x2
    80009194:	86050513          	addi	a0,a0,-1952 # 8000a9f0 <digits+0x18>
    80009198:	fffff097          	auipc	ra,0xfffff
    8000919c:	354080e7          	jalr	852(ra) # 800084ec <panic>

00000000800091a0 <kalloc>:
    800091a0:	fe010113          	addi	sp,sp,-32
    800091a4:	00813823          	sd	s0,16(sp)
    800091a8:	00913423          	sd	s1,8(sp)
    800091ac:	00113c23          	sd	ra,24(sp)
    800091b0:	02010413          	addi	s0,sp,32
    800091b4:	00004797          	auipc	a5,0x4
    800091b8:	adc78793          	addi	a5,a5,-1316 # 8000cc90 <kmem>
    800091bc:	0007b483          	ld	s1,0(a5)
    800091c0:	02048063          	beqz	s1,800091e0 <kalloc+0x40>
    800091c4:	0004b703          	ld	a4,0(s1)
    800091c8:	00001637          	lui	a2,0x1
    800091cc:	00500593          	li	a1,5
    800091d0:	00048513          	mv	a0,s1
    800091d4:	00e7b023          	sd	a4,0(a5)
    800091d8:	00000097          	auipc	ra,0x0
    800091dc:	400080e7          	jalr	1024(ra) # 800095d8 <__memset>
    800091e0:	01813083          	ld	ra,24(sp)
    800091e4:	01013403          	ld	s0,16(sp)
    800091e8:	00048513          	mv	a0,s1
    800091ec:	00813483          	ld	s1,8(sp)
    800091f0:	02010113          	addi	sp,sp,32
    800091f4:	00008067          	ret

00000000800091f8 <initlock>:
    800091f8:	ff010113          	addi	sp,sp,-16
    800091fc:	00813423          	sd	s0,8(sp)
    80009200:	01010413          	addi	s0,sp,16
    80009204:	00813403          	ld	s0,8(sp)
    80009208:	00b53423          	sd	a1,8(a0)
    8000920c:	00052023          	sw	zero,0(a0)
    80009210:	00053823          	sd	zero,16(a0)
    80009214:	01010113          	addi	sp,sp,16
    80009218:	00008067          	ret

000000008000921c <acquire>:
    8000921c:	fe010113          	addi	sp,sp,-32
    80009220:	00813823          	sd	s0,16(sp)
    80009224:	00913423          	sd	s1,8(sp)
    80009228:	00113c23          	sd	ra,24(sp)
    8000922c:	01213023          	sd	s2,0(sp)
    80009230:	02010413          	addi	s0,sp,32
    80009234:	00050493          	mv	s1,a0
    80009238:	10002973          	csrr	s2,sstatus
    8000923c:	100027f3          	csrr	a5,sstatus
    80009240:	ffd7f793          	andi	a5,a5,-3
    80009244:	10079073          	csrw	sstatus,a5
    80009248:	fffff097          	auipc	ra,0xfffff
    8000924c:	8e0080e7          	jalr	-1824(ra) # 80007b28 <mycpu>
    80009250:	07852783          	lw	a5,120(a0)
    80009254:	06078e63          	beqz	a5,800092d0 <acquire+0xb4>
    80009258:	fffff097          	auipc	ra,0xfffff
    8000925c:	8d0080e7          	jalr	-1840(ra) # 80007b28 <mycpu>
    80009260:	07852783          	lw	a5,120(a0)
    80009264:	0004a703          	lw	a4,0(s1)
    80009268:	0017879b          	addiw	a5,a5,1
    8000926c:	06f52c23          	sw	a5,120(a0)
    80009270:	04071063          	bnez	a4,800092b0 <acquire+0x94>
    80009274:	00100713          	li	a4,1
    80009278:	00070793          	mv	a5,a4
    8000927c:	0cf4a7af          	amoswap.w.aq	a5,a5,(s1)
    80009280:	0007879b          	sext.w	a5,a5
    80009284:	fe079ae3          	bnez	a5,80009278 <acquire+0x5c>
    80009288:	0ff0000f          	fence
    8000928c:	fffff097          	auipc	ra,0xfffff
    80009290:	89c080e7          	jalr	-1892(ra) # 80007b28 <mycpu>
    80009294:	01813083          	ld	ra,24(sp)
    80009298:	01013403          	ld	s0,16(sp)
    8000929c:	00a4b823          	sd	a0,16(s1)
    800092a0:	00013903          	ld	s2,0(sp)
    800092a4:	00813483          	ld	s1,8(sp)
    800092a8:	02010113          	addi	sp,sp,32
    800092ac:	00008067          	ret
    800092b0:	0104b903          	ld	s2,16(s1)
    800092b4:	fffff097          	auipc	ra,0xfffff
    800092b8:	874080e7          	jalr	-1932(ra) # 80007b28 <mycpu>
    800092bc:	faa91ce3          	bne	s2,a0,80009274 <acquire+0x58>
    800092c0:	00001517          	auipc	a0,0x1
    800092c4:	73850513          	addi	a0,a0,1848 # 8000a9f8 <digits+0x20>
    800092c8:	fffff097          	auipc	ra,0xfffff
    800092cc:	224080e7          	jalr	548(ra) # 800084ec <panic>
    800092d0:	00195913          	srli	s2,s2,0x1
    800092d4:	fffff097          	auipc	ra,0xfffff
    800092d8:	854080e7          	jalr	-1964(ra) # 80007b28 <mycpu>
    800092dc:	00197913          	andi	s2,s2,1
    800092e0:	07252e23          	sw	s2,124(a0)
    800092e4:	f75ff06f          	j	80009258 <acquire+0x3c>

00000000800092e8 <release>:
    800092e8:	fe010113          	addi	sp,sp,-32
    800092ec:	00813823          	sd	s0,16(sp)
    800092f0:	00113c23          	sd	ra,24(sp)
    800092f4:	00913423          	sd	s1,8(sp)
    800092f8:	01213023          	sd	s2,0(sp)
    800092fc:	02010413          	addi	s0,sp,32
    80009300:	00052783          	lw	a5,0(a0)
    80009304:	00079a63          	bnez	a5,80009318 <release+0x30>
    80009308:	00001517          	auipc	a0,0x1
    8000930c:	6f850513          	addi	a0,a0,1784 # 8000aa00 <digits+0x28>
    80009310:	fffff097          	auipc	ra,0xfffff
    80009314:	1dc080e7          	jalr	476(ra) # 800084ec <panic>
    80009318:	01053903          	ld	s2,16(a0)
    8000931c:	00050493          	mv	s1,a0
    80009320:	fffff097          	auipc	ra,0xfffff
    80009324:	808080e7          	jalr	-2040(ra) # 80007b28 <mycpu>
    80009328:	fea910e3          	bne	s2,a0,80009308 <release+0x20>
    8000932c:	0004b823          	sd	zero,16(s1)
    80009330:	0ff0000f          	fence
    80009334:	0f50000f          	fence	iorw,ow
    80009338:	0804a02f          	amoswap.w	zero,zero,(s1)
    8000933c:	ffffe097          	auipc	ra,0xffffe
    80009340:	7ec080e7          	jalr	2028(ra) # 80007b28 <mycpu>
    80009344:	100027f3          	csrr	a5,sstatus
    80009348:	0027f793          	andi	a5,a5,2
    8000934c:	04079a63          	bnez	a5,800093a0 <release+0xb8>
    80009350:	07852783          	lw	a5,120(a0)
    80009354:	02f05e63          	blez	a5,80009390 <release+0xa8>
    80009358:	fff7871b          	addiw	a4,a5,-1
    8000935c:	06e52c23          	sw	a4,120(a0)
    80009360:	00071c63          	bnez	a4,80009378 <release+0x90>
    80009364:	07c52783          	lw	a5,124(a0)
    80009368:	00078863          	beqz	a5,80009378 <release+0x90>
    8000936c:	100027f3          	csrr	a5,sstatus
    80009370:	0027e793          	ori	a5,a5,2
    80009374:	10079073          	csrw	sstatus,a5
    80009378:	01813083          	ld	ra,24(sp)
    8000937c:	01013403          	ld	s0,16(sp)
    80009380:	00813483          	ld	s1,8(sp)
    80009384:	00013903          	ld	s2,0(sp)
    80009388:	02010113          	addi	sp,sp,32
    8000938c:	00008067          	ret
    80009390:	00001517          	auipc	a0,0x1
    80009394:	69050513          	addi	a0,a0,1680 # 8000aa20 <digits+0x48>
    80009398:	fffff097          	auipc	ra,0xfffff
    8000939c:	154080e7          	jalr	340(ra) # 800084ec <panic>
    800093a0:	00001517          	auipc	a0,0x1
    800093a4:	66850513          	addi	a0,a0,1640 # 8000aa08 <digits+0x30>
    800093a8:	fffff097          	auipc	ra,0xfffff
    800093ac:	144080e7          	jalr	324(ra) # 800084ec <panic>

00000000800093b0 <holding>:
    800093b0:	00052783          	lw	a5,0(a0)
    800093b4:	00079663          	bnez	a5,800093c0 <holding+0x10>
    800093b8:	00000513          	li	a0,0
    800093bc:	00008067          	ret
    800093c0:	fe010113          	addi	sp,sp,-32
    800093c4:	00813823          	sd	s0,16(sp)
    800093c8:	00913423          	sd	s1,8(sp)
    800093cc:	00113c23          	sd	ra,24(sp)
    800093d0:	02010413          	addi	s0,sp,32
    800093d4:	01053483          	ld	s1,16(a0)
    800093d8:	ffffe097          	auipc	ra,0xffffe
    800093dc:	750080e7          	jalr	1872(ra) # 80007b28 <mycpu>
    800093e0:	01813083          	ld	ra,24(sp)
    800093e4:	01013403          	ld	s0,16(sp)
    800093e8:	40a48533          	sub	a0,s1,a0
    800093ec:	00153513          	seqz	a0,a0
    800093f0:	00813483          	ld	s1,8(sp)
    800093f4:	02010113          	addi	sp,sp,32
    800093f8:	00008067          	ret

00000000800093fc <push_off>:
    800093fc:	fe010113          	addi	sp,sp,-32
    80009400:	00813823          	sd	s0,16(sp)
    80009404:	00113c23          	sd	ra,24(sp)
    80009408:	00913423          	sd	s1,8(sp)
    8000940c:	02010413          	addi	s0,sp,32
    80009410:	100024f3          	csrr	s1,sstatus
    80009414:	100027f3          	csrr	a5,sstatus
    80009418:	ffd7f793          	andi	a5,a5,-3
    8000941c:	10079073          	csrw	sstatus,a5
    80009420:	ffffe097          	auipc	ra,0xffffe
    80009424:	708080e7          	jalr	1800(ra) # 80007b28 <mycpu>
    80009428:	07852783          	lw	a5,120(a0)
    8000942c:	02078663          	beqz	a5,80009458 <push_off+0x5c>
    80009430:	ffffe097          	auipc	ra,0xffffe
    80009434:	6f8080e7          	jalr	1784(ra) # 80007b28 <mycpu>
    80009438:	07852783          	lw	a5,120(a0)
    8000943c:	01813083          	ld	ra,24(sp)
    80009440:	01013403          	ld	s0,16(sp)
    80009444:	0017879b          	addiw	a5,a5,1
    80009448:	06f52c23          	sw	a5,120(a0)
    8000944c:	00813483          	ld	s1,8(sp)
    80009450:	02010113          	addi	sp,sp,32
    80009454:	00008067          	ret
    80009458:	0014d493          	srli	s1,s1,0x1
    8000945c:	ffffe097          	auipc	ra,0xffffe
    80009460:	6cc080e7          	jalr	1740(ra) # 80007b28 <mycpu>
    80009464:	0014f493          	andi	s1,s1,1
    80009468:	06952e23          	sw	s1,124(a0)
    8000946c:	fc5ff06f          	j	80009430 <push_off+0x34>

0000000080009470 <pop_off>:
    80009470:	ff010113          	addi	sp,sp,-16
    80009474:	00813023          	sd	s0,0(sp)
    80009478:	00113423          	sd	ra,8(sp)
    8000947c:	01010413          	addi	s0,sp,16
    80009480:	ffffe097          	auipc	ra,0xffffe
    80009484:	6a8080e7          	jalr	1704(ra) # 80007b28 <mycpu>
    80009488:	100027f3          	csrr	a5,sstatus
    8000948c:	0027f793          	andi	a5,a5,2
    80009490:	04079663          	bnez	a5,800094dc <pop_off+0x6c>
    80009494:	07852783          	lw	a5,120(a0)
    80009498:	02f05a63          	blez	a5,800094cc <pop_off+0x5c>
    8000949c:	fff7871b          	addiw	a4,a5,-1
    800094a0:	06e52c23          	sw	a4,120(a0)
    800094a4:	00071c63          	bnez	a4,800094bc <pop_off+0x4c>
    800094a8:	07c52783          	lw	a5,124(a0)
    800094ac:	00078863          	beqz	a5,800094bc <pop_off+0x4c>
    800094b0:	100027f3          	csrr	a5,sstatus
    800094b4:	0027e793          	ori	a5,a5,2
    800094b8:	10079073          	csrw	sstatus,a5
    800094bc:	00813083          	ld	ra,8(sp)
    800094c0:	00013403          	ld	s0,0(sp)
    800094c4:	01010113          	addi	sp,sp,16
    800094c8:	00008067          	ret
    800094cc:	00001517          	auipc	a0,0x1
    800094d0:	55450513          	addi	a0,a0,1364 # 8000aa20 <digits+0x48>
    800094d4:	fffff097          	auipc	ra,0xfffff
    800094d8:	018080e7          	jalr	24(ra) # 800084ec <panic>
    800094dc:	00001517          	auipc	a0,0x1
    800094e0:	52c50513          	addi	a0,a0,1324 # 8000aa08 <digits+0x30>
    800094e4:	fffff097          	auipc	ra,0xfffff
    800094e8:	008080e7          	jalr	8(ra) # 800084ec <panic>

00000000800094ec <push_on>:
    800094ec:	fe010113          	addi	sp,sp,-32
    800094f0:	00813823          	sd	s0,16(sp)
    800094f4:	00113c23          	sd	ra,24(sp)
    800094f8:	00913423          	sd	s1,8(sp)
    800094fc:	02010413          	addi	s0,sp,32
    80009500:	100024f3          	csrr	s1,sstatus
    80009504:	100027f3          	csrr	a5,sstatus
    80009508:	0027e793          	ori	a5,a5,2
    8000950c:	10079073          	csrw	sstatus,a5
    80009510:	ffffe097          	auipc	ra,0xffffe
    80009514:	618080e7          	jalr	1560(ra) # 80007b28 <mycpu>
    80009518:	07852783          	lw	a5,120(a0)
    8000951c:	02078663          	beqz	a5,80009548 <push_on+0x5c>
    80009520:	ffffe097          	auipc	ra,0xffffe
    80009524:	608080e7          	jalr	1544(ra) # 80007b28 <mycpu>
    80009528:	07852783          	lw	a5,120(a0)
    8000952c:	01813083          	ld	ra,24(sp)
    80009530:	01013403          	ld	s0,16(sp)
    80009534:	0017879b          	addiw	a5,a5,1
    80009538:	06f52c23          	sw	a5,120(a0)
    8000953c:	00813483          	ld	s1,8(sp)
    80009540:	02010113          	addi	sp,sp,32
    80009544:	00008067          	ret
    80009548:	0014d493          	srli	s1,s1,0x1
    8000954c:	ffffe097          	auipc	ra,0xffffe
    80009550:	5dc080e7          	jalr	1500(ra) # 80007b28 <mycpu>
    80009554:	0014f493          	andi	s1,s1,1
    80009558:	06952e23          	sw	s1,124(a0)
    8000955c:	fc5ff06f          	j	80009520 <push_on+0x34>

0000000080009560 <pop_on>:
    80009560:	ff010113          	addi	sp,sp,-16
    80009564:	00813023          	sd	s0,0(sp)
    80009568:	00113423          	sd	ra,8(sp)
    8000956c:	01010413          	addi	s0,sp,16
    80009570:	ffffe097          	auipc	ra,0xffffe
    80009574:	5b8080e7          	jalr	1464(ra) # 80007b28 <mycpu>
    80009578:	100027f3          	csrr	a5,sstatus
    8000957c:	0027f793          	andi	a5,a5,2
    80009580:	04078463          	beqz	a5,800095c8 <pop_on+0x68>
    80009584:	07852783          	lw	a5,120(a0)
    80009588:	02f05863          	blez	a5,800095b8 <pop_on+0x58>
    8000958c:	fff7879b          	addiw	a5,a5,-1
    80009590:	06f52c23          	sw	a5,120(a0)
    80009594:	07853783          	ld	a5,120(a0)
    80009598:	00079863          	bnez	a5,800095a8 <pop_on+0x48>
    8000959c:	100027f3          	csrr	a5,sstatus
    800095a0:	ffd7f793          	andi	a5,a5,-3
    800095a4:	10079073          	csrw	sstatus,a5
    800095a8:	00813083          	ld	ra,8(sp)
    800095ac:	00013403          	ld	s0,0(sp)
    800095b0:	01010113          	addi	sp,sp,16
    800095b4:	00008067          	ret
    800095b8:	00001517          	auipc	a0,0x1
    800095bc:	49050513          	addi	a0,a0,1168 # 8000aa48 <digits+0x70>
    800095c0:	fffff097          	auipc	ra,0xfffff
    800095c4:	f2c080e7          	jalr	-212(ra) # 800084ec <panic>
    800095c8:	00001517          	auipc	a0,0x1
    800095cc:	46050513          	addi	a0,a0,1120 # 8000aa28 <digits+0x50>
    800095d0:	fffff097          	auipc	ra,0xfffff
    800095d4:	f1c080e7          	jalr	-228(ra) # 800084ec <panic>

00000000800095d8 <__memset>:
    800095d8:	ff010113          	addi	sp,sp,-16
    800095dc:	00813423          	sd	s0,8(sp)
    800095e0:	01010413          	addi	s0,sp,16
    800095e4:	1a060e63          	beqz	a2,800097a0 <__memset+0x1c8>
    800095e8:	40a007b3          	neg	a5,a0
    800095ec:	0077f793          	andi	a5,a5,7
    800095f0:	00778693          	addi	a3,a5,7
    800095f4:	00b00813          	li	a6,11
    800095f8:	0ff5f593          	andi	a1,a1,255
    800095fc:	fff6071b          	addiw	a4,a2,-1
    80009600:	1b06e663          	bltu	a3,a6,800097ac <__memset+0x1d4>
    80009604:	1cd76463          	bltu	a4,a3,800097cc <__memset+0x1f4>
    80009608:	1a078e63          	beqz	a5,800097c4 <__memset+0x1ec>
    8000960c:	00b50023          	sb	a1,0(a0)
    80009610:	00100713          	li	a4,1
    80009614:	1ae78463          	beq	a5,a4,800097bc <__memset+0x1e4>
    80009618:	00b500a3          	sb	a1,1(a0)
    8000961c:	00200713          	li	a4,2
    80009620:	1ae78a63          	beq	a5,a4,800097d4 <__memset+0x1fc>
    80009624:	00b50123          	sb	a1,2(a0)
    80009628:	00300713          	li	a4,3
    8000962c:	18e78463          	beq	a5,a4,800097b4 <__memset+0x1dc>
    80009630:	00b501a3          	sb	a1,3(a0)
    80009634:	00400713          	li	a4,4
    80009638:	1ae78263          	beq	a5,a4,800097dc <__memset+0x204>
    8000963c:	00b50223          	sb	a1,4(a0)
    80009640:	00500713          	li	a4,5
    80009644:	1ae78063          	beq	a5,a4,800097e4 <__memset+0x20c>
    80009648:	00b502a3          	sb	a1,5(a0)
    8000964c:	00700713          	li	a4,7
    80009650:	18e79e63          	bne	a5,a4,800097ec <__memset+0x214>
    80009654:	00b50323          	sb	a1,6(a0)
    80009658:	00700e93          	li	t4,7
    8000965c:	00859713          	slli	a4,a1,0x8
    80009660:	00e5e733          	or	a4,a1,a4
    80009664:	01059e13          	slli	t3,a1,0x10
    80009668:	01c76e33          	or	t3,a4,t3
    8000966c:	01859313          	slli	t1,a1,0x18
    80009670:	006e6333          	or	t1,t3,t1
    80009674:	02059893          	slli	a7,a1,0x20
    80009678:	40f60e3b          	subw	t3,a2,a5
    8000967c:	011368b3          	or	a7,t1,a7
    80009680:	02859813          	slli	a6,a1,0x28
    80009684:	0108e833          	or	a6,a7,a6
    80009688:	03059693          	slli	a3,a1,0x30
    8000968c:	003e589b          	srliw	a7,t3,0x3
    80009690:	00d866b3          	or	a3,a6,a3
    80009694:	03859713          	slli	a4,a1,0x38
    80009698:	00389813          	slli	a6,a7,0x3
    8000969c:	00f507b3          	add	a5,a0,a5
    800096a0:	00e6e733          	or	a4,a3,a4
    800096a4:	000e089b          	sext.w	a7,t3
    800096a8:	00f806b3          	add	a3,a6,a5
    800096ac:	00e7b023          	sd	a4,0(a5)
    800096b0:	00878793          	addi	a5,a5,8
    800096b4:	fed79ce3          	bne	a5,a3,800096ac <__memset+0xd4>
    800096b8:	ff8e7793          	andi	a5,t3,-8
    800096bc:	0007871b          	sext.w	a4,a5
    800096c0:	01d787bb          	addw	a5,a5,t4
    800096c4:	0ce88e63          	beq	a7,a4,800097a0 <__memset+0x1c8>
    800096c8:	00f50733          	add	a4,a0,a5
    800096cc:	00b70023          	sb	a1,0(a4)
    800096d0:	0017871b          	addiw	a4,a5,1
    800096d4:	0cc77663          	bgeu	a4,a2,800097a0 <__memset+0x1c8>
    800096d8:	00e50733          	add	a4,a0,a4
    800096dc:	00b70023          	sb	a1,0(a4)
    800096e0:	0027871b          	addiw	a4,a5,2
    800096e4:	0ac77e63          	bgeu	a4,a2,800097a0 <__memset+0x1c8>
    800096e8:	00e50733          	add	a4,a0,a4
    800096ec:	00b70023          	sb	a1,0(a4)
    800096f0:	0037871b          	addiw	a4,a5,3
    800096f4:	0ac77663          	bgeu	a4,a2,800097a0 <__memset+0x1c8>
    800096f8:	00e50733          	add	a4,a0,a4
    800096fc:	00b70023          	sb	a1,0(a4)
    80009700:	0047871b          	addiw	a4,a5,4
    80009704:	08c77e63          	bgeu	a4,a2,800097a0 <__memset+0x1c8>
    80009708:	00e50733          	add	a4,a0,a4
    8000970c:	00b70023          	sb	a1,0(a4)
    80009710:	0057871b          	addiw	a4,a5,5
    80009714:	08c77663          	bgeu	a4,a2,800097a0 <__memset+0x1c8>
    80009718:	00e50733          	add	a4,a0,a4
    8000971c:	00b70023          	sb	a1,0(a4)
    80009720:	0067871b          	addiw	a4,a5,6
    80009724:	06c77e63          	bgeu	a4,a2,800097a0 <__memset+0x1c8>
    80009728:	00e50733          	add	a4,a0,a4
    8000972c:	00b70023          	sb	a1,0(a4)
    80009730:	0077871b          	addiw	a4,a5,7
    80009734:	06c77663          	bgeu	a4,a2,800097a0 <__memset+0x1c8>
    80009738:	00e50733          	add	a4,a0,a4
    8000973c:	00b70023          	sb	a1,0(a4)
    80009740:	0087871b          	addiw	a4,a5,8
    80009744:	04c77e63          	bgeu	a4,a2,800097a0 <__memset+0x1c8>
    80009748:	00e50733          	add	a4,a0,a4
    8000974c:	00b70023          	sb	a1,0(a4)
    80009750:	0097871b          	addiw	a4,a5,9
    80009754:	04c77663          	bgeu	a4,a2,800097a0 <__memset+0x1c8>
    80009758:	00e50733          	add	a4,a0,a4
    8000975c:	00b70023          	sb	a1,0(a4)
    80009760:	00a7871b          	addiw	a4,a5,10
    80009764:	02c77e63          	bgeu	a4,a2,800097a0 <__memset+0x1c8>
    80009768:	00e50733          	add	a4,a0,a4
    8000976c:	00b70023          	sb	a1,0(a4)
    80009770:	00b7871b          	addiw	a4,a5,11
    80009774:	02c77663          	bgeu	a4,a2,800097a0 <__memset+0x1c8>
    80009778:	00e50733          	add	a4,a0,a4
    8000977c:	00b70023          	sb	a1,0(a4)
    80009780:	00c7871b          	addiw	a4,a5,12
    80009784:	00c77e63          	bgeu	a4,a2,800097a0 <__memset+0x1c8>
    80009788:	00e50733          	add	a4,a0,a4
    8000978c:	00b70023          	sb	a1,0(a4)
    80009790:	00d7879b          	addiw	a5,a5,13
    80009794:	00c7f663          	bgeu	a5,a2,800097a0 <__memset+0x1c8>
    80009798:	00f507b3          	add	a5,a0,a5
    8000979c:	00b78023          	sb	a1,0(a5)
    800097a0:	00813403          	ld	s0,8(sp)
    800097a4:	01010113          	addi	sp,sp,16
    800097a8:	00008067          	ret
    800097ac:	00b00693          	li	a3,11
    800097b0:	e55ff06f          	j	80009604 <__memset+0x2c>
    800097b4:	00300e93          	li	t4,3
    800097b8:	ea5ff06f          	j	8000965c <__memset+0x84>
    800097bc:	00100e93          	li	t4,1
    800097c0:	e9dff06f          	j	8000965c <__memset+0x84>
    800097c4:	00000e93          	li	t4,0
    800097c8:	e95ff06f          	j	8000965c <__memset+0x84>
    800097cc:	00000793          	li	a5,0
    800097d0:	ef9ff06f          	j	800096c8 <__memset+0xf0>
    800097d4:	00200e93          	li	t4,2
    800097d8:	e85ff06f          	j	8000965c <__memset+0x84>
    800097dc:	00400e93          	li	t4,4
    800097e0:	e7dff06f          	j	8000965c <__memset+0x84>
    800097e4:	00500e93          	li	t4,5
    800097e8:	e75ff06f          	j	8000965c <__memset+0x84>
    800097ec:	00600e93          	li	t4,6
    800097f0:	e6dff06f          	j	8000965c <__memset+0x84>

00000000800097f4 <__memmove>:
    800097f4:	ff010113          	addi	sp,sp,-16
    800097f8:	00813423          	sd	s0,8(sp)
    800097fc:	01010413          	addi	s0,sp,16
    80009800:	0e060863          	beqz	a2,800098f0 <__memmove+0xfc>
    80009804:	fff6069b          	addiw	a3,a2,-1
    80009808:	0006881b          	sext.w	a6,a3
    8000980c:	0ea5e863          	bltu	a1,a0,800098fc <__memmove+0x108>
    80009810:	00758713          	addi	a4,a1,7
    80009814:	00a5e7b3          	or	a5,a1,a0
    80009818:	40a70733          	sub	a4,a4,a0
    8000981c:	0077f793          	andi	a5,a5,7
    80009820:	00f73713          	sltiu	a4,a4,15
    80009824:	00174713          	xori	a4,a4,1
    80009828:	0017b793          	seqz	a5,a5
    8000982c:	00e7f7b3          	and	a5,a5,a4
    80009830:	10078863          	beqz	a5,80009940 <__memmove+0x14c>
    80009834:	00900793          	li	a5,9
    80009838:	1107f463          	bgeu	a5,a6,80009940 <__memmove+0x14c>
    8000983c:	0036581b          	srliw	a6,a2,0x3
    80009840:	fff8081b          	addiw	a6,a6,-1
    80009844:	02081813          	slli	a6,a6,0x20
    80009848:	01d85893          	srli	a7,a6,0x1d
    8000984c:	00858813          	addi	a6,a1,8
    80009850:	00058793          	mv	a5,a1
    80009854:	00050713          	mv	a4,a0
    80009858:	01088833          	add	a6,a7,a6
    8000985c:	0007b883          	ld	a7,0(a5)
    80009860:	00878793          	addi	a5,a5,8
    80009864:	00870713          	addi	a4,a4,8
    80009868:	ff173c23          	sd	a7,-8(a4)
    8000986c:	ff0798e3          	bne	a5,a6,8000985c <__memmove+0x68>
    80009870:	ff867713          	andi	a4,a2,-8
    80009874:	02071793          	slli	a5,a4,0x20
    80009878:	0207d793          	srli	a5,a5,0x20
    8000987c:	00f585b3          	add	a1,a1,a5
    80009880:	40e686bb          	subw	a3,a3,a4
    80009884:	00f507b3          	add	a5,a0,a5
    80009888:	06e60463          	beq	a2,a4,800098f0 <__memmove+0xfc>
    8000988c:	0005c703          	lbu	a4,0(a1)
    80009890:	00e78023          	sb	a4,0(a5)
    80009894:	04068e63          	beqz	a3,800098f0 <__memmove+0xfc>
    80009898:	0015c603          	lbu	a2,1(a1)
    8000989c:	00100713          	li	a4,1
    800098a0:	00c780a3          	sb	a2,1(a5)
    800098a4:	04e68663          	beq	a3,a4,800098f0 <__memmove+0xfc>
    800098a8:	0025c603          	lbu	a2,2(a1)
    800098ac:	00200713          	li	a4,2
    800098b0:	00c78123          	sb	a2,2(a5)
    800098b4:	02e68e63          	beq	a3,a4,800098f0 <__memmove+0xfc>
    800098b8:	0035c603          	lbu	a2,3(a1)
    800098bc:	00300713          	li	a4,3
    800098c0:	00c781a3          	sb	a2,3(a5)
    800098c4:	02e68663          	beq	a3,a4,800098f0 <__memmove+0xfc>
    800098c8:	0045c603          	lbu	a2,4(a1)
    800098cc:	00400713          	li	a4,4
    800098d0:	00c78223          	sb	a2,4(a5)
    800098d4:	00e68e63          	beq	a3,a4,800098f0 <__memmove+0xfc>
    800098d8:	0055c603          	lbu	a2,5(a1)
    800098dc:	00500713          	li	a4,5
    800098e0:	00c782a3          	sb	a2,5(a5)
    800098e4:	00e68663          	beq	a3,a4,800098f0 <__memmove+0xfc>
    800098e8:	0065c703          	lbu	a4,6(a1)
    800098ec:	00e78323          	sb	a4,6(a5)
    800098f0:	00813403          	ld	s0,8(sp)
    800098f4:	01010113          	addi	sp,sp,16
    800098f8:	00008067          	ret
    800098fc:	02061713          	slli	a4,a2,0x20
    80009900:	02075713          	srli	a4,a4,0x20
    80009904:	00e587b3          	add	a5,a1,a4
    80009908:	f0f574e3          	bgeu	a0,a5,80009810 <__memmove+0x1c>
    8000990c:	02069613          	slli	a2,a3,0x20
    80009910:	02065613          	srli	a2,a2,0x20
    80009914:	fff64613          	not	a2,a2
    80009918:	00e50733          	add	a4,a0,a4
    8000991c:	00c78633          	add	a2,a5,a2
    80009920:	fff7c683          	lbu	a3,-1(a5)
    80009924:	fff78793          	addi	a5,a5,-1
    80009928:	fff70713          	addi	a4,a4,-1
    8000992c:	00d70023          	sb	a3,0(a4)
    80009930:	fec798e3          	bne	a5,a2,80009920 <__memmove+0x12c>
    80009934:	00813403          	ld	s0,8(sp)
    80009938:	01010113          	addi	sp,sp,16
    8000993c:	00008067          	ret
    80009940:	02069713          	slli	a4,a3,0x20
    80009944:	02075713          	srli	a4,a4,0x20
    80009948:	00170713          	addi	a4,a4,1
    8000994c:	00e50733          	add	a4,a0,a4
    80009950:	00050793          	mv	a5,a0
    80009954:	0005c683          	lbu	a3,0(a1)
    80009958:	00178793          	addi	a5,a5,1
    8000995c:	00158593          	addi	a1,a1,1
    80009960:	fed78fa3          	sb	a3,-1(a5)
    80009964:	fee798e3          	bne	a5,a4,80009954 <__memmove+0x160>
    80009968:	f89ff06f          	j	800098f0 <__memmove+0xfc>
	...
