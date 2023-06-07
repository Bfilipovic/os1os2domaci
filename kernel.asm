
kernel:     file format elf64-littleriscv


Disassembly of section .text:

0000000080000000 <_entry>:
    80000000:	00005117          	auipc	sp,0x5
    80000004:	61813103          	ld	sp,1560(sp) # 80005618 <_GLOBAL_OFFSET_TABLE_+0x10>
    80000008:	00001537          	lui	a0,0x1
    8000000c:	f14025f3          	csrr	a1,mhartid
    80000010:	00158593          	addi	a1,a1,1
    80000014:	02b50533          	mul	a0,a0,a1
    80000018:	00a10133          	add	sp,sp,a0
    8000001c:	0f5020ef          	jal	ra,80002910 <start>

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
    800010a8:	0ad000ef          	jal	ra,80001954 <handleInterrupt>

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
    800011b4:	4c0000ef          	jal	ra,80001674 <handleEcall>
    
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

0000000080001260 <kern_sem_init>:
#define MAX_SEMAPHORES 256

struct sem_s semaphores[MAX_SEMAPHORES];

void kern_sem_init()
{
    80001260:	ff010113          	addi	sp,sp,-16
    80001264:	00813423          	sd	s0,8(sp)
    80001268:	01010413          	addi	s0,sp,16
    for(int i=0;i<MAX_SEMAPHORES;i++){
    8000126c:	00000713          	li	a4,0
    80001270:	0ff00793          	li	a5,255
    80001274:	02e7c663          	blt	a5,a4,800012a0 <kern_sem_init+0x40>
        semaphores[i].waiting_thread=0;
    80001278:	00471693          	slli	a3,a4,0x4
    8000127c:	00004797          	auipc	a5,0x4
    80001280:	41478793          	addi	a5,a5,1044 # 80005690 <semaphores>
    80001284:	00d787b3          	add	a5,a5,a3
    80001288:	0007b423          	sd	zero,8(a5)
        semaphores[i].val=0;
    8000128c:	0007a023          	sw	zero,0(a5)
        semaphores[i].status=SEM_UNUSED;
    80001290:	00100693          	li	a3,1
    80001294:	00d7a223          	sw	a3,4(a5)
    for(int i=0;i<MAX_SEMAPHORES;i++){
    80001298:	0017071b          	addiw	a4,a4,1
    8000129c:	fd5ff06f          	j	80001270 <kern_sem_init+0x10>
    }
}
    800012a0:	00813403          	ld	s0,8(sp)
    800012a4:	01010113          	addi	sp,sp,16
    800012a8:	00008067          	ret

00000000800012ac <kern_sem_open>:

int kern_sem_open (sem_t* handle, unsigned init)
{
    800012ac:	ff010113          	addi	sp,sp,-16
    800012b0:	00813423          	sd	s0,8(sp)
    800012b4:	01010413          	addi	s0,sp,16
    int res=-1;
    for(int i=0;i<MAX_SEMAPHORES;i++){
    800012b8:	00000793          	li	a5,0
    800012bc:	0080006f          	j	800012c4 <kern_sem_open+0x18>
    800012c0:	0017879b          	addiw	a5,a5,1
    800012c4:	0ff00713          	li	a4,255
    800012c8:	04f74663          	blt	a4,a5,80001314 <kern_sem_open+0x68>
        if(semaphores[i].status==SEM_UNUSED){
    800012cc:	00479693          	slli	a3,a5,0x4
    800012d0:	00004717          	auipc	a4,0x4
    800012d4:	3c070713          	addi	a4,a4,960 # 80005690 <semaphores>
    800012d8:	00d70733          	add	a4,a4,a3
    800012dc:	00472683          	lw	a3,4(a4)
    800012e0:	00100713          	li	a4,1
    800012e4:	fce69ee3          	bne	a3,a4,800012c0 <kern_sem_open+0x14>
            semaphores[i].status=SEM_USED;
    800012e8:	00479793          	slli	a5,a5,0x4
    800012ec:	00004717          	auipc	a4,0x4
    800012f0:	3a470713          	addi	a4,a4,932 # 80005690 <semaphores>
    800012f4:	00f707b3          	add	a5,a4,a5
    800012f8:	0007a223          	sw	zero,4(a5)
            semaphores[i].val=init;
    800012fc:	00b7a023          	sw	a1,0(a5)
            *handle=&semaphores[i];
    80001300:	00f53023          	sd	a5,0(a0)
            res++;
    80001304:	00000513          	li	a0,0
            break;
        }
    }
    return res;
}
    80001308:	00813403          	ld	s0,8(sp)
    8000130c:	01010113          	addi	sp,sp,16
    80001310:	00008067          	ret
    int res=-1;
    80001314:	fff00513          	li	a0,-1
    80001318:	ff1ff06f          	j	80001308 <kern_sem_open+0x5c>

000000008000131c <kern_sem_close>:

int kern_sem_close (sem_t handle)
{
    8000131c:	ff010113          	addi	sp,sp,-16
    80001320:	00813423          	sd	s0,8(sp)
    80001324:	01010413          	addi	s0,sp,16
    handle->status=UNUSED;
    80001328:	00052223          	sw	zero,4(a0)
    handle->val=0;
    8000132c:	00052023          	sw	zero,0(a0)
    if(handle->waiting_thread!=0){
    80001330:	00853783          	ld	a5,8(a0)
    80001334:	02079263          	bnez	a5,80001358 <kern_sem_close+0x3c>
    80001338:	0280006f          	j	80001360 <kern_sem_close+0x44>
        thread_t curr = handle->waiting_thread;
        while(curr){
            curr->mailbox=-2;
    8000133c:	ffe00713          	li	a4,-2
    80001340:	04e7b423          	sd	a4,72(a5)
            curr->status=READY;
    80001344:	00200713          	li	a4,2
    80001348:	04e7a823          	sw	a4,80(a5)
            thread_t prev=curr;
            curr=curr->sem_next;
    8000134c:	0587b703          	ld	a4,88(a5)
            prev->sem_next=0;
    80001350:	0407bc23          	sd	zero,88(a5)
            curr=curr->sem_next;
    80001354:	00070793          	mv	a5,a4
        while(curr){
    80001358:	fe0792e3          	bnez	a5,8000133c <kern_sem_close+0x20>
        }
        handle->waiting_thread=0;
    8000135c:	00053423          	sd	zero,8(a0)
    }
    return 0;
}
    80001360:	00000513          	li	a0,0
    80001364:	00813403          	ld	s0,8(sp)
    80001368:	01010113          	addi	sp,sp,16
    8000136c:	00008067          	ret

0000000080001370 <kern_sem_signal>:

void kern_sem_signal(sem_t id)
{
    80001370:	ff010113          	addi	sp,sp,-16
    80001374:	00813423          	sd	s0,8(sp)
    80001378:	01010413          	addi	s0,sp,16
    if(id->val>0 || id->waiting_thread==0) id->val++;
    8000137c:	00052783          	lw	a5,0(a0)
    80001380:	00f05c63          	blez	a5,80001398 <kern_sem_signal+0x28>
    80001384:	0017879b          	addiw	a5,a5,1
    80001388:	00f52023          	sw	a5,0(a0)
        thread_t woken = id->waiting_thread;
        id->waiting_thread=woken->sem_next;
        woken->mailbox=0;
        woken->status=READY;
    }
}
    8000138c:	00813403          	ld	s0,8(sp)
    80001390:	01010113          	addi	sp,sp,16
    80001394:	00008067          	ret
    if(id->val>0 || id->waiting_thread==0) id->val++;
    80001398:	00853703          	ld	a4,8(a0)
    8000139c:	fe0704e3          	beqz	a4,80001384 <kern_sem_signal+0x14>
        id->waiting_thread=woken->sem_next;
    800013a0:	05873783          	ld	a5,88(a4)
    800013a4:	00f53423          	sd	a5,8(a0)
        woken->mailbox=0;
    800013a8:	04073423          	sd	zero,72(a4)
        woken->status=READY;
    800013ac:	00200793          	li	a5,2
    800013b0:	04f72823          	sw	a5,80(a4)
}
    800013b4:	fd9ff06f          	j	8000138c <kern_sem_signal+0x1c>

00000000800013b8 <kern_sem_wait>:

int kern_sem_wait(sem_t id)
{
    800013b8:	ff010113          	addi	sp,sp,-16
    800013bc:	00813423          	sd	s0,8(sp)
    800013c0:	01010413          	addi	s0,sp,16
    id->val--;
    800013c4:	00052783          	lw	a5,0(a0)
    800013c8:	fff7879b          	addiw	a5,a5,-1
    800013cc:	00f52023          	sw	a5,0(a0)
    if(id->val<0){
    800013d0:	02079713          	slli	a4,a5,0x20
    800013d4:	00074a63          	bltz	a4,800013e8 <kern_sem_wait+0x30>
        }
        running->sem_next=0;
        return -1;
    }
    else {
        return 1;
    800013d8:	00100513          	li	a0,1
    }
}
    800013dc:	00813403          	ld	s0,8(sp)
    800013e0:	01010113          	addi	sp,sp,16
    800013e4:	00008067          	ret
        running->status=SUSPENDED;
    800013e8:	00004697          	auipc	a3,0x4
    800013ec:	2786b683          	ld	a3,632(a3) # 80005660 <running>
    800013f0:	00300793          	li	a5,3
    800013f4:	04f6a823          	sw	a5,80(a3)
        if(id->waiting_thread==0) id->waiting_thread=running;
    800013f8:	00853783          	ld	a5,8(a0)
    800013fc:	02078063          	beqz	a5,8000141c <kern_sem_wait+0x64>
            while (curr->sem_next!=0) curr=curr->sem_next;
    80001400:	00078713          	mv	a4,a5
    80001404:	0587b783          	ld	a5,88(a5)
    80001408:	fe079ce3          	bnez	a5,80001400 <kern_sem_wait+0x48>
            curr->sem_next=running;
    8000140c:	04d73c23          	sd	a3,88(a4)
        running->sem_next=0;
    80001410:	0406bc23          	sd	zero,88(a3)
        return -1;
    80001414:	fff00513          	li	a0,-1
    80001418:	fc5ff06f          	j	800013dc <kern_sem_wait+0x24>
        if(id->waiting_thread==0) id->waiting_thread=running;
    8000141c:	00d53423          	sd	a3,8(a0)
    80001420:	ff1ff06f          	j	80001410 <kern_sem_wait+0x58>

0000000080001424 <kern_mem_alloc>:

mem_block_s * freeHead;


void* kern_mem_alloc(int sizeInBlocks)
{
    80001424:	ff010113          	addi	sp,sp,-16
    80001428:	00813423          	sd	s0,8(sp)
    8000142c:	01010413          	addi	s0,sp,16
    80001430:	00050693          	mv	a3,a0
    mem_block_s *curr = freeHead;
    80001434:	00004597          	auipc	a1,0x4
    80001438:	2145b583          	ld	a1,532(a1) # 80005648 <freeHead>
    8000143c:	00058513          	mv	a0,a1
    mem_block_s *prev = 0;
    80001440:	00000613          	li	a2,0

    while (curr){
    80001444:	0480006f          	j	8000148c <kern_mem_alloc+0x68>
        if(curr->sizeInBlocks==sizeInBlocks+1){
            if(curr==freeHead) freeHead=curr->next;
    80001448:	02b50063          	beq	a0,a1,80001468 <kern_mem_alloc+0x44>
            else prev->next = curr->next;
    8000144c:	00853783          	ld	a5,8(a0)
    80001450:	00f63423          	sd	a5,8(a2)
            curr->sizeInBlocks=sizeInBlocks+1;
    80001454:	00e52023          	sw	a4,0(a0)
            return (curr+MEM_BLOCK_SIZE);
    80001458:	40050513          	addi	a0,a0,1024
        prev=curr;
        curr=curr->next;
    }

    return 0;
}
    8000145c:	00813403          	ld	s0,8(sp)
    80001460:	01010113          	addi	sp,sp,16
    80001464:	00008067          	ret
            if(curr==freeHead) freeHead=curr->next;
    80001468:	00853783          	ld	a5,8(a0)
    8000146c:	00004697          	auipc	a3,0x4
    80001470:	1cf6be23          	sd	a5,476(a3) # 80005648 <freeHead>
    80001474:	fe1ff06f          	j	80001454 <kern_mem_alloc+0x30>
            if(curr==freeHead) freeHead=newFreeBlock;
    80001478:	00004797          	auipc	a5,0x4
    8000147c:	1cb7b823          	sd	a1,464(a5) # 80005648 <freeHead>
    80001480:	05c0006f          	j	800014dc <kern_mem_alloc+0xb8>
        prev=curr;
    80001484:	00050613          	mv	a2,a0
        curr=curr->next;
    80001488:	00853503          	ld	a0,8(a0)
    while (curr){
    8000148c:	fc0508e3          	beqz	a0,8000145c <kern_mem_alloc+0x38>
        if(curr->sizeInBlocks==sizeInBlocks+1){
    80001490:	00052783          	lw	a5,0(a0)
    80001494:	0016871b          	addiw	a4,a3,1
    80001498:	fae788e3          	beq	a5,a4,80001448 <kern_mem_alloc+0x24>
        else if(curr->sizeInBlocks>sizeInBlocks+1){
    8000149c:	fef754e3          	bge	a4,a5,80001484 <kern_mem_alloc+0x60>
            mem_block_s* newFreeBlock = curr+(sizeInBlocks+1)*MEM_BLOCK_SIZE;
    800014a0:	00a71593          	slli	a1,a4,0xa
    800014a4:	00b505b3          	add	a1,a0,a1
            newFreeBlock->sizeInBlocks = curr->sizeInBlocks-sizeInBlocks-1;
    800014a8:	40d787bb          	subw	a5,a5,a3
    800014ac:	fff7879b          	addiw	a5,a5,-1
    800014b0:	00f5a023          	sw	a5,0(a1)
            newFreeBlock->startingBlock=curr->startingBlock+sizeInBlocks+1;
    800014b4:	00452783          	lw	a5,4(a0)
    800014b8:	00d786bb          	addw	a3,a5,a3
    800014bc:	0016869b          	addiw	a3,a3,1
    800014c0:	00d5a223          	sw	a3,4(a1)
            newFreeBlock->next = curr->next;
    800014c4:	00853783          	ld	a5,8(a0)
    800014c8:	00f5b423          	sd	a5,8(a1)
            if(curr==freeHead) freeHead=newFreeBlock;
    800014cc:	00004797          	auipc	a5,0x4
    800014d0:	17c7b783          	ld	a5,380(a5) # 80005648 <freeHead>
    800014d4:	faa782e3          	beq	a5,a0,80001478 <kern_mem_alloc+0x54>
            else prev->next=newFreeBlock;
    800014d8:	00b63423          	sd	a1,8(a2)
            curr->sizeInBlocks=sizeInBlocks+1;
    800014dc:	00e52023          	sw	a4,0(a0)
            return (curr+MEM_BLOCK_SIZE);
    800014e0:	40050513          	addi	a0,a0,1024
    800014e4:	f79ff06f          	j	8000145c <kern_mem_alloc+0x38>

00000000800014e8 <kern_mem_free>:

int kern_mem_free(void* addr)
{
    800014e8:	ff010113          	addi	sp,sp,-16
    800014ec:	00813423          	sd	s0,8(sp)
    800014f0:	01010413          	addi	s0,sp,16
    mem_block_s* freedBlock = (mem_block_s*) addr-MEM_BLOCK_SIZE;
    800014f4:	c0050713          	addi	a4,a0,-1024
    mem_block_s* curr=freeHead;
    800014f8:	00004797          	auipc	a5,0x4
    800014fc:	1507b783          	ld	a5,336(a5) # 80005648 <freeHead>
    mem_block_s * prev =0;
    80001500:	00000693          	li	a3,0

    while (curr<freedBlock && curr!=0){
    80001504:	00e7fa63          	bgeu	a5,a4,80001518 <kern_mem_free+0x30>
    80001508:	00078863          	beqz	a5,80001518 <kern_mem_free+0x30>
        prev=curr;
    8000150c:	00078693          	mv	a3,a5
        curr=curr->next;
    80001510:	0087b783          	ld	a5,8(a5)
    80001514:	ff1ff06f          	j	80001504 <kern_mem_free+0x1c>
    char* cfreedBlock = (char *)freedBlock;
    char* cprev = (char *)prev;
    char* ccurr = (char *)curr;
    */

    if(prev){
    80001518:	04068e63          	beqz	a3,80001574 <kern_mem_free+0x8c>
        if(prev->startingBlock+prev->sizeInBlocks==freedBlock->startingBlock){
    8000151c:	0046a603          	lw	a2,4(a3)
    80001520:	0006a583          	lw	a1,0(a3)
    80001524:	00b6063b          	addw	a2,a2,a1
    80001528:	c0452803          	lw	a6,-1020(a0)
    8000152c:	03060a63          	beq	a2,a6,80001560 <kern_mem_free+0x78>
            prev->sizeInBlocks+=freedBlock->sizeInBlocks;
            freedBlock=prev;
        } else {
            prev->next=freedBlock;
    80001530:	00e6b423          	sd	a4,8(a3)
        }
    }
    else freeHead=freedBlock;

    if(curr){
    80001534:	00078e63          	beqz	a5,80001550 <kern_mem_free+0x68>
        if(freedBlock->startingBlock+freedBlock->sizeInBlocks==curr->startingBlock){
    80001538:	00472683          	lw	a3,4(a4)
    8000153c:	00072603          	lw	a2,0(a4)
    80001540:	00c686bb          	addw	a3,a3,a2
    80001544:	0047a583          	lw	a1,4(a5)
    80001548:	02b68c63          	beq	a3,a1,80001580 <kern_mem_free+0x98>
            freedBlock->sizeInBlocks+=curr->sizeInBlocks;
            freedBlock->next=curr->next;
        } else{
          freedBlock->next=curr;
    8000154c:	00f73423          	sd	a5,8(a4)
        }
    }


    return 0;
}
    80001550:	00000513          	li	a0,0
    80001554:	00813403          	ld	s0,8(sp)
    80001558:	01010113          	addi	sp,sp,16
    8000155c:	00008067          	ret
            prev->sizeInBlocks+=freedBlock->sizeInBlocks;
    80001560:	c0052703          	lw	a4,-1024(a0)
    80001564:	00e585bb          	addw	a1,a1,a4
    80001568:	00b6a023          	sw	a1,0(a3)
            freedBlock=prev;
    8000156c:	00068713          	mv	a4,a3
    80001570:	fc5ff06f          	j	80001534 <kern_mem_free+0x4c>
    else freeHead=freedBlock;
    80001574:	00004697          	auipc	a3,0x4
    80001578:	0ce6ba23          	sd	a4,212(a3) # 80005648 <freeHead>
    8000157c:	fb9ff06f          	j	80001534 <kern_mem_free+0x4c>
            freedBlock->sizeInBlocks+=curr->sizeInBlocks;
    80001580:	0007a683          	lw	a3,0(a5)
    80001584:	00d6063b          	addw	a2,a2,a3
    80001588:	00c72023          	sw	a2,0(a4)
            freedBlock->next=curr->next;
    8000158c:	0087b783          	ld	a5,8(a5)
    80001590:	00f73423          	sd	a5,8(a4)
    80001594:	fbdff06f          	j	80001550 <kern_mem_free+0x68>

0000000080001598 <kern_mem_init>:

unsigned long ukupno_memorije;
void kern_mem_init(void* start, void* end)
{
    80001598:	ff010113          	addi	sp,sp,-16
    8000159c:	00813423          	sd	s0,8(sp)
    800015a0:	01010413          	addi	s0,sp,16
    unsigned long lstart = (unsigned long) start;
    unsigned long lend = (unsigned long) end;
    800015a4:	00058793          	mv	a5,a1

    if(lstart%MEM_BLOCK_SIZE>0) start =(void*) ((lstart/MEM_BLOCK_SIZE+1)*MEM_BLOCK_SIZE);
    800015a8:	03f57713          	andi	a4,a0,63
    800015ac:	00070863          	beqz	a4,800015bc <kern_mem_init+0x24>
    800015b0:	00655513          	srli	a0,a0,0x6
    800015b4:	00150513          	addi	a0,a0,1
    800015b8:	00651513          	slli	a0,a0,0x6
    if(lend%MEM_BLOCK_SIZE>0) end =(void*) ((lend/MEM_BLOCK_SIZE)*MEM_BLOCK_SIZE);
    800015bc:	03f7f713          	andi	a4,a5,63
    800015c0:	00070463          	beqz	a4,800015c8 <kern_mem_init+0x30>
    800015c4:	fc07f593          	andi	a1,a5,-64

    freeHead = (mem_block_s*)start;
    800015c8:	00004797          	auipc	a5,0x4
    800015cc:	08078793          	addi	a5,a5,128 # 80005648 <freeHead>
    800015d0:	00a7b023          	sd	a0,0(a5)
    freeHead->next=0;
    800015d4:	00053423          	sd	zero,8(a0)
    freeHead->startingBlock=0;
    800015d8:	00052223          	sw	zero,4(a0)
    freeHead->sizeInBlocks = (end-start)/MEM_BLOCK_SIZE;
    800015dc:	40a58533          	sub	a0,a1,a0
    800015e0:	00655513          	srli	a0,a0,0x6
    800015e4:	0007b703          	ld	a4,0(a5)
    800015e8:	00a72023          	sw	a0,0(a4)
    ukupno_memorije=freeHead->sizeInBlocks;
    800015ec:	0007b783          	ld	a5,0(a5)
    800015f0:	0007a783          	lw	a5,0(a5)
    800015f4:	00004717          	auipc	a4,0x4
    800015f8:	04f73623          	sd	a5,76(a4) # 80005640 <ukupno_memorije>
}
    800015fc:	00813403          	ld	s0,8(sp)
    80001600:	01010113          	addi	sp,sp,16
    80001604:	00008067          	ret

0000000080001608 <kern_syscall>:

uint64 SYSTEM_TIME;


void kern_syscall(enum SyscallNumber num, ...)
{
    80001608:	fb010113          	addi	sp,sp,-80
    8000160c:	00813423          	sd	s0,8(sp)
    80001610:	01010413          	addi	s0,sp,16
    80001614:	00b43423          	sd	a1,8(s0)
    80001618:	00c43823          	sd	a2,16(s0)
    8000161c:	00d43c23          	sd	a3,24(s0)
    80001620:	02e43023          	sd	a4,32(s0)
    80001624:	02f43423          	sd	a5,40(s0)
    80001628:	03043823          	sd	a6,48(s0)
    8000162c:	03143c23          	sd	a7,56(s0)
    __asm__ volatile ("ecall");
    80001630:	00000073          	ecall
    return;
}
    80001634:	00813403          	ld	s0,8(sp)
    80001638:	05010113          	addi	sp,sp,80
    8000163c:	00008067          	ret

0000000080001640 <kern_interrupt_init>:

void kern_interrupt_init()
{
    80001640:	ff010113          	addi	sp,sp,-16
    80001644:	00813423          	sd	s0,8(sp)
    80001648:	01010413          	addi	s0,sp,16
    SYSTEM_TIME=0;
    8000164c:	00004797          	auipc	a5,0x4
    80001650:	0007b623          	sd	zero,12(a5) # 80005658 <SYSTEM_TIME>
    w_stvec((uint64) &supervisorTrap);
    80001654:	00000797          	auipc	a5,0x0
    80001658:	9ac78793          	addi	a5,a5,-1620 # 80001000 <supervisorTrap>
    return stvec;
}

inline void w_stvec(uint64 stvec)
{
    __asm__ volatile ("csrw stvec, %[stvec]" : : [stvec] "r"(stvec));
    8000165c:	10579073          	csrw	stvec,a5
    __asm__ volatile ("csrw sip, %[sip]" : : [sip] "r"(sip));
}

inline void ms_sstatus(uint64 mask)
{
    __asm__ volatile ("csrs sstatus, %[mask]" : : [mask] "r"(mask));
    80001660:	00200793          	li	a5,2
    80001664:	1007a073          	csrs	sstatus,a5
    ms_sstatus(SSTATUS_SIE);
}
    80001668:	00813403          	ld	s0,8(sp)
    8000166c:	01010113          	addi	sp,sp,16
    80001670:	00008067          	ret

0000000080001674 <handleEcall>:


int time=0;

void handleEcall(uint64 a0, uint64 a1, uint64 a2, uint64 a3, uint64 a4) {
    80001674:	f5010113          	addi	sp,sp,-176
    80001678:	0a113423          	sd	ra,168(sp)
    8000167c:	0a813023          	sd	s0,160(sp)
    80001680:	08913c23          	sd	s1,152(sp)
    80001684:	09213823          	sd	s2,144(sp)
    80001688:	0b010413          	addi	s0,sp,176
    8000168c:	00060913          	mv	s2,a2
    80001690:	00068613          	mv	a2,a3
    __asm__ volatile ("csrr %[scause], scause" : [scause] "=r"(scause));
    80001694:	142027f3          	csrr	a5,scause
    80001698:	f8f43823          	sd	a5,-112(s0)
    return scause;
    8000169c:	f9043783          	ld	a5,-112(s0)
    __asm__ volatile ("mv %[a2], a2" : [a2] "=r"(a2));
    __asm__ volatile ("mv %[a3], a3" : [a3] "=r"(a3));
    __asm__ volatile ("mv %[a4], a4" : [a4] "=r"(a4));
     */
    uint64 scause = r_scause();
    if (scause == INTR_USER_ECALL || scause == INTR_KERNEL_ECALL) {
    800016a0:	ff878793          	addi	a5,a5,-8
    800016a4:	00100693          	li	a3,1
    800016a8:	00f6fe63          	bgeu	a3,a5,800016c4 <handleEcall+0x50>
            }


        }
    }
}
    800016ac:	0a813083          	ld	ra,168(sp)
    800016b0:	0a013403          	ld	s0,160(sp)
    800016b4:	09813483          	ld	s1,152(sp)
    800016b8:	09013903          	ld	s2,144(sp)
    800016bc:	0b010113          	addi	sp,sp,176
    800016c0:	00008067          	ret
    800016c4:	00058493          	mv	s1,a1
    __asm__ volatile ("csrr %[sepc], sepc" : [sepc] "=r"(sepc));
    800016c8:	141027f3          	csrr	a5,sepc
    800016cc:	f8f43c23          	sd	a5,-104(s0)
    return sepc;
    800016d0:	f9843783          	ld	a5,-104(s0)
        uint64 sepc = r_sepc() + 4;
    800016d4:	00478793          	addi	a5,a5,4
    __asm__ volatile ("csrw sepc, %[sepc]" : : [sepc] "r"(sepc));
    800016d8:	14179073          	csrw	sepc,a5
        switch (syscall_num) {
    800016dc:	03100793          	li	a5,49
    800016e0:	fca7e6e3          	bltu	a5,a0,800016ac <handleEcall+0x38>
    800016e4:	00251513          	slli	a0,a0,0x2
    800016e8:	00004697          	auipc	a3,0x4
    800016ec:	93868693          	addi	a3,a3,-1736 # 80005020 <CONSOLE_STATUS+0x8>
    800016f0:	00d50533          	add	a0,a0,a3
    800016f4:	00052783          	lw	a5,0(a0)
    800016f8:	00d787b3          	add	a5,a5,a3
    800016fc:	00078067          	jr	a5
                retval = (uint64) kern_mem_alloc(size);
    80001700:	0005851b          	sext.w	a0,a1
    80001704:	00000097          	auipc	ra,0x0
    80001708:	d20080e7          	jalr	-736(ra) # 80001424 <kern_mem_alloc>
    __asm__ volatile ("mv a0, %[value]" :: [value] "r"(value));
    8000170c:	00050513          	mv	a0,a0
}
    80001710:	f9dff06f          	j	800016ac <handleEcall+0x38>
                retval = (uint64) kern_mem_free((void *) addr);
    80001714:	00058513          	mv	a0,a1
    80001718:	00000097          	auipc	ra,0x0
    8000171c:	dd0080e7          	jalr	-560(ra) # 800014e8 <kern_mem_free>
    __asm__ volatile ("mv a0, %[value]" :: [value] "r"(value));
    80001720:	00050513          	mv	a0,a0
}
    80001724:	f89ff06f          	j	800016ac <handleEcall+0x38>
                retval = (uint64) kern_thread_create((thread_t *) handle,
    80001728:	00070693          	mv	a3,a4
    8000172c:	00090593          	mv	a1,s2
    80001730:	00048513          	mv	a0,s1
    80001734:	00000097          	auipc	ra,0x0
    80001738:	71c080e7          	jalr	1820(ra) # 80001e50 <kern_thread_create>
                (*(thread_t *) handle)->endTime = SYSTEM_TIME + DEFAULT_TIME_SLICE;
    8000173c:	0004b703          	ld	a4,0(s1)
    80001740:	00004797          	auipc	a5,0x4
    80001744:	f187b783          	ld	a5,-232(a5) # 80005658 <SYSTEM_TIME>
    80001748:	00278793          	addi	a5,a5,2
    8000174c:	02f73c23          	sd	a5,56(a4)
    __asm__ volatile ("mv a0, %[value]" :: [value] "r"(value));
    80001750:	00050513          	mv	a0,a0
}
    80001754:	f59ff06f          	j	800016ac <handleEcall+0x38>
}

inline uint64 r_sstatus()
{
    uint64 volatile sstatus;
    __asm__ volatile ("csrr %[sstatus], sstatus" : [sstatus] "=r"(sstatus));
    80001758:	100027f3          	csrr	a5,sstatus
    8000175c:	faf43423          	sd	a5,-88(s0)
    return sstatus;
    80001760:	fa843783          	ld	a5,-88(s0)
                uint64 volatile sstatus = r_sstatus();
    80001764:	f4f43823          	sd	a5,-176(s0)
    __asm__ volatile ("csrr %[sepc], sepc" : [sepc] "=r"(sepc));
    80001768:	141027f3          	csrr	a5,sepc
    8000176c:	faf43023          	sd	a5,-96(s0)
    return sepc;
    80001770:	fa043783          	ld	a5,-96(s0)
                uint64 volatile v_sepc = r_sepc();
    80001774:	f4f43c23          	sd	a5,-168(s0)
                kern_thread_dispatch();
    80001778:	00000097          	auipc	ra,0x0
    8000177c:	488080e7          	jalr	1160(ra) # 80001c00 <kern_thread_dispatch>
                w_sstatus(sstatus);
    80001780:	f5043783          	ld	a5,-176(s0)
}

inline void w_sstatus(uint64 sstatus)
{
    __asm__ volatile ("csrw sstatus, %[sstatus]" : : [sstatus] "r"(sstatus));
    80001784:	10079073          	csrw	sstatus,a5
                w_sepc(v_sepc);
    80001788:	f5843783          	ld	a5,-168(s0)
    __asm__ volatile ("csrw sepc, %[sepc]" : : [sepc] "r"(sepc));
    8000178c:	14179073          	csrw	sepc,a5
                running->endTime = time + running->timeslice;
    80001790:	00004717          	auipc	a4,0x4
    80001794:	ed073703          	ld	a4,-304(a4) # 80005660 <running>
    80001798:	03073683          	ld	a3,48(a4)
    8000179c:	00004797          	auipc	a5,0x4
    800017a0:	eb47a783          	lw	a5,-332(a5) # 80005650 <time>
    800017a4:	00d787b3          	add	a5,a5,a3
    800017a8:	02f73c23          	sd	a5,56(a4)
                break;
    800017ac:	f01ff06f          	j	800016ac <handleEcall+0x38>
    __asm__ volatile ("csrr %[sstatus], sstatus" : [sstatus] "=r"(sstatus));
    800017b0:	100027f3          	csrr	a5,sstatus
    800017b4:	faf43c23          	sd	a5,-72(s0)
    return sstatus;
    800017b8:	fb843783          	ld	a5,-72(s0)
                uint64 volatile sstatus = r_sstatus();
    800017bc:	f6f43023          	sd	a5,-160(s0)
    __asm__ volatile ("csrr %[sepc], sepc" : [sepc] "=r"(sepc));
    800017c0:	141027f3          	csrr	a5,sepc
    800017c4:	faf43823          	sd	a5,-80(s0)
    return sepc;
    800017c8:	fb043783          	ld	a5,-80(s0)
                uint64 volatile v_sepc = r_sepc();
    800017cc:	f6f43423          	sd	a5,-152(s0)
                kern_thread_join(handle);
    800017d0:	00058513          	mv	a0,a1
    800017d4:	00000097          	auipc	ra,0x0
    800017d8:	760080e7          	jalr	1888(ra) # 80001f34 <kern_thread_join>
                w_sstatus(sstatus);
    800017dc:	f6043783          	ld	a5,-160(s0)
    __asm__ volatile ("csrw sstatus, %[sstatus]" : : [sstatus] "r"(sstatus));
    800017e0:	10079073          	csrw	sstatus,a5
                w_sepc(v_sepc);
    800017e4:	f6843783          	ld	a5,-152(s0)
    __asm__ volatile ("csrw sepc, %[sepc]" : : [sepc] "r"(sepc));
    800017e8:	14179073          	csrw	sepc,a5
                running->endTime = time + running->timeslice;
    800017ec:	00004717          	auipc	a4,0x4
    800017f0:	e7473703          	ld	a4,-396(a4) # 80005660 <running>
    800017f4:	03073683          	ld	a3,48(a4)
    800017f8:	00004797          	auipc	a5,0x4
    800017fc:	e587a783          	lw	a5,-424(a5) # 80005650 <time>
    80001800:	00d787b3          	add	a5,a5,a3
    80001804:	02f73c23          	sd	a5,56(a4)
                break;
    80001808:	ea5ff06f          	j	800016ac <handleEcall+0x38>
                kern_thread_end_running();
    8000180c:	00000097          	auipc	ra,0x0
    80001810:	470080e7          	jalr	1136(ra) # 80001c7c <kern_thread_end_running>
                retval = kern_sem_open(handle, init);
    80001814:	0009059b          	sext.w	a1,s2
    80001818:	00048513          	mv	a0,s1
    8000181c:	00000097          	auipc	ra,0x0
    80001820:	a90080e7          	jalr	-1392(ra) # 800012ac <kern_sem_open>
    __asm__ volatile ("mv a0, %[value]" :: [value] "r"(value));
    80001824:	00050513          	mv	a0,a0
}
    80001828:	e85ff06f          	j	800016ac <handleEcall+0x38>
                retval = kern_sem_close(handle);
    8000182c:	00058513          	mv	a0,a1
    80001830:	00000097          	auipc	ra,0x0
    80001834:	aec080e7          	jalr	-1300(ra) # 8000131c <kern_sem_close>
    __asm__ volatile ("mv a0, %[value]" :: [value] "r"(value));
    80001838:	00050513          	mv	a0,a0
}
    8000183c:	e71ff06f          	j	800016ac <handleEcall+0x38>
                kern_sem_signal(handle);
    80001840:	00058513          	mv	a0,a1
    80001844:	00000097          	auipc	ra,0x0
    80001848:	b2c080e7          	jalr	-1236(ra) # 80001370 <kern_sem_signal>
    __asm__ volatile ("mv a0, %[value]" :: [value] "r"(value));
    8000184c:	00000793          	li	a5,0
    80001850:	00078513          	mv	a0,a5
}
    80001854:	e59ff06f          	j	800016ac <handleEcall+0x38>
                int res = kern_sem_wait(handle);
    80001858:	00058513          	mv	a0,a1
    8000185c:	00000097          	auipc	ra,0x0
    80001860:	b5c080e7          	jalr	-1188(ra) # 800013b8 <kern_sem_wait>
                if (res == 1) retval = 0;
    80001864:	00100793          	li	a5,1
    80001868:	00f51863          	bne	a0,a5,80001878 <handleEcall+0x204>
    8000186c:	00000793          	li	a5,0
    __asm__ volatile ("mv a0, %[value]" :: [value] "r"(value));
    80001870:	00078513          	mv	a0,a5
}
    80001874:	e39ff06f          	j	800016ac <handleEcall+0x38>
    __asm__ volatile ("csrr %[sstatus], sstatus" : [sstatus] "=r"(sstatus));
    80001878:	100027f3          	csrr	a5,sstatus
    8000187c:	fcf43423          	sd	a5,-56(s0)
    return sstatus;
    80001880:	fc843783          	ld	a5,-56(s0)
                    uint64 volatile sstatus = r_sstatus();
    80001884:	f6f43823          	sd	a5,-144(s0)
    __asm__ volatile ("csrr %[sepc], sepc" : [sepc] "=r"(sepc));
    80001888:	141027f3          	csrr	a5,sepc
    8000188c:	fcf43023          	sd	a5,-64(s0)
    return sepc;
    80001890:	fc043783          	ld	a5,-64(s0)
                    uint64 volatile v_sepc = r_sepc();
    80001894:	f6f43c23          	sd	a5,-136(s0)
                    kern_thread_dispatch();
    80001898:	00000097          	auipc	ra,0x0
    8000189c:	368080e7          	jalr	872(ra) # 80001c00 <kern_thread_dispatch>
                    w_sstatus(sstatus);
    800018a0:	f7043783          	ld	a5,-144(s0)
    __asm__ volatile ("csrw sstatus, %[sstatus]" : : [sstatus] "r"(sstatus));
    800018a4:	10079073          	csrw	sstatus,a5
                    w_sepc(v_sepc);
    800018a8:	f7843783          	ld	a5,-136(s0)
    __asm__ volatile ("csrw sepc, %[sepc]" : : [sepc] "r"(sepc));
    800018ac:	14179073          	csrw	sepc,a5
                    running->endTime = time + running->timeslice;
    800018b0:	00004797          	auipc	a5,0x4
    800018b4:	db07b783          	ld	a5,-592(a5) # 80005660 <running>
    800018b8:	0307b683          	ld	a3,48(a5)
    800018bc:	00004717          	auipc	a4,0x4
    800018c0:	d9472703          	lw	a4,-620(a4) # 80005650 <time>
    800018c4:	00d70733          	add	a4,a4,a3
    800018c8:	02e7bc23          	sd	a4,56(a5)
                    if (running->mailbox == 0) retval = 0;
    800018cc:	0487b783          	ld	a5,72(a5)
    800018d0:	fa0780e3          	beqz	a5,80001870 <handleEcall+0x1fc>
                    else retval = -1;
    800018d4:	fff00793          	li	a5,-1
    800018d8:	f99ff06f          	j	80001870 <handleEcall+0x1fc>
                running->status = SLEEPING;
    800018dc:	00004917          	auipc	s2,0x4
    800018e0:	d8490913          	addi	s2,s2,-636 # 80005660 <running>
    800018e4:	00093783          	ld	a5,0(s2)
    800018e8:	00500713          	li	a4,5
    800018ec:	04e7a823          	sw	a4,80(a5)
                running->endTime = SYSTEM_TIME + period;
    800018f0:	00004717          	auipc	a4,0x4
    800018f4:	d6873703          	ld	a4,-664(a4) # 80005658 <SYSTEM_TIME>
    800018f8:	00e584b3          	add	s1,a1,a4
    800018fc:	0297bc23          	sd	s1,56(a5)
    __asm__ volatile ("csrr %[sstatus], sstatus" : [sstatus] "=r"(sstatus));
    80001900:	100027f3          	csrr	a5,sstatus
    80001904:	fcf43c23          	sd	a5,-40(s0)
    return sstatus;
    80001908:	fd843783          	ld	a5,-40(s0)
                uint64 volatile sstatus = r_sstatus();
    8000190c:	f8f43023          	sd	a5,-128(s0)
    __asm__ volatile ("csrr %[sepc], sepc" : [sepc] "=r"(sepc));
    80001910:	141027f3          	csrr	a5,sepc
    80001914:	fcf43823          	sd	a5,-48(s0)
    return sepc;
    80001918:	fd043783          	ld	a5,-48(s0)
                uint64 volatile v_sepc = r_sepc();
    8000191c:	f8f43423          	sd	a5,-120(s0)
                kern_thread_dispatch();
    80001920:	00000097          	auipc	ra,0x0
    80001924:	2e0080e7          	jalr	736(ra) # 80001c00 <kern_thread_dispatch>
                w_sstatus(sstatus);
    80001928:	f8043783          	ld	a5,-128(s0)
    __asm__ volatile ("csrw sstatus, %[sstatus]" : : [sstatus] "r"(sstatus));
    8000192c:	10079073          	csrw	sstatus,a5
                w_sepc(v_sepc);
    80001930:	f8843783          	ld	a5,-120(s0)
    __asm__ volatile ("csrw sepc, %[sepc]" : : [sepc] "r"(sepc));
    80001934:	14179073          	csrw	sepc,a5
                running->endTime = time + running->timeslice;
    80001938:	00093703          	ld	a4,0(s2)
    8000193c:	03073683          	ld	a3,48(a4)
    80001940:	00004797          	auipc	a5,0x4
    80001944:	d107a783          	lw	a5,-752(a5) # 80005650 <time>
    80001948:	00d787b3          	add	a5,a5,a3
    8000194c:	02f73c23          	sd	a5,56(a4)
}
    80001950:	d5dff06f          	j	800016ac <handleEcall+0x38>

0000000080001954 <handleInterrupt>:

void handleInterrupt()
{
    80001954:	fb010113          	addi	sp,sp,-80
    80001958:	04113423          	sd	ra,72(sp)
    8000195c:	04813023          	sd	s0,64(sp)
    80001960:	02913c23          	sd	s1,56(sp)
    80001964:	05010413          	addi	s0,sp,80
    __asm__ volatile ("csrr %[scause], scause" : [scause] "=r"(scause));
    80001968:	142027f3          	csrr	a5,scause
    8000196c:	fcf43423          	sd	a5,-56(s0)
    return scause;
    80001970:	fc843703          	ld	a4,-56(s0)
    uint64 scause = r_scause();
    if (scause == INTR_TIMER)
    80001974:	fff00793          	li	a5,-1
    80001978:	03f79793          	slli	a5,a5,0x3f
    8000197c:	00178793          	addi	a5,a5,1
    80001980:	02f70463          	beq	a4,a5,800019a8 <handleInterrupt+0x54>
            //__putc('0'+running->id);
            //__putc(')');
        }

    }
    else if (scause == INTR_CONSOLE)
    80001984:	fff00793          	li	a5,-1
    80001988:	03f79793          	slli	a5,a5,0x3f
    8000198c:	00978793          	addi	a5,a5,9
    80001990:	0af70463          	beq	a4,a5,80001a38 <handleInterrupt+0xe4>

    }
    else if(scause==INTR_ILLEGAL_ADDR_WR){

    }
}
    80001994:	04813083          	ld	ra,72(sp)
    80001998:	04013403          	ld	s0,64(sp)
    8000199c:	03813483          	ld	s1,56(sp)
    800019a0:	05010113          	addi	sp,sp,80
    800019a4:	00008067          	ret
        SYSTEM_TIME++;
    800019a8:	00004497          	auipc	s1,0x4
    800019ac:	cb048493          	addi	s1,s1,-848 # 80005658 <SYSTEM_TIME>
    800019b0:	0004b503          	ld	a0,0(s1)
    800019b4:	00150513          	addi	a0,a0,1
    800019b8:	00a4b023          	sd	a0,0(s1)
    __asm__ volatile ("csrc sip, %[mask]" : : [mask] "r"(mask));
    800019bc:	00200793          	li	a5,2
    800019c0:	1447b073          	csrc	sip,a5
        kern_thread_wakeup(SYSTEM_TIME);
    800019c4:	00000097          	auipc	ra,0x0
    800019c8:	5bc080e7          	jalr	1468(ra) # 80001f80 <kern_thread_wakeup>
        if(SYSTEM_TIME>=running->endTime){
    800019cc:	00004797          	auipc	a5,0x4
    800019d0:	c947b783          	ld	a5,-876(a5) # 80005660 <running>
    800019d4:	0387b703          	ld	a4,56(a5)
    800019d8:	0004b783          	ld	a5,0(s1)
    800019dc:	fae7ece3          	bltu	a5,a4,80001994 <handleInterrupt+0x40>
    __asm__ volatile ("csrr %[sstatus], sstatus" : [sstatus] "=r"(sstatus));
    800019e0:	100027f3          	csrr	a5,sstatus
    800019e4:	fcf43c23          	sd	a5,-40(s0)
    return sstatus;
    800019e8:	fd843783          	ld	a5,-40(s0)
            uint64 volatile sstatus = r_sstatus();
    800019ec:	faf43c23          	sd	a5,-72(s0)
    __asm__ volatile ("csrr %[sepc], sepc" : [sepc] "=r"(sepc));
    800019f0:	141027f3          	csrr	a5,sepc
    800019f4:	fcf43823          	sd	a5,-48(s0)
    return sepc;
    800019f8:	fd043783          	ld	a5,-48(s0)
            uint64 volatile v_sepc = r_sepc();
    800019fc:	fcf43023          	sd	a5,-64(s0)
            kern_thread_dispatch();
    80001a00:	00000097          	auipc	ra,0x0
    80001a04:	200080e7          	jalr	512(ra) # 80001c00 <kern_thread_dispatch>
            w_sstatus(sstatus);
    80001a08:	fb843783          	ld	a5,-72(s0)
    __asm__ volatile ("csrw sstatus, %[sstatus]" : : [sstatus] "r"(sstatus));
    80001a0c:	10079073          	csrw	sstatus,a5
            w_sepc(v_sepc);
    80001a10:	fc043783          	ld	a5,-64(s0)
    __asm__ volatile ("csrw sepc, %[sepc]" : : [sepc] "r"(sepc));
    80001a14:	14179073          	csrw	sepc,a5
            running->endTime=SYSTEM_TIME+running->timeslice;
    80001a18:	00004717          	auipc	a4,0x4
    80001a1c:	c4873703          	ld	a4,-952(a4) # 80005660 <running>
    80001a20:	03073783          	ld	a5,48(a4)
    80001a24:	00004697          	auipc	a3,0x4
    80001a28:	c346b683          	ld	a3,-972(a3) # 80005658 <SYSTEM_TIME>
    80001a2c:	00d787b3          	add	a5,a5,a3
    80001a30:	02f73c23          	sd	a5,56(a4)
    80001a34:	f61ff06f          	j	80001994 <handleInterrupt+0x40>
        int i = plic_claim();
    80001a38:	00001097          	auipc	ra,0x1
    80001a3c:	72c080e7          	jalr	1836(ra) # 80003164 <plic_claim>
        if(i==10){
    80001a40:	00a00793          	li	a5,10
    80001a44:	00f50863          	beq	a0,a5,80001a54 <handleInterrupt+0x100>
        console_handler();
    80001a48:	00003097          	auipc	ra,0x3
    80001a4c:	ff8080e7          	jalr	-8(ra) # 80004a40 <console_handler>
}
    80001a50:	f45ff06f          	j	80001994 <handleInterrupt+0x40>
            plic_complete(i);
    80001a54:	00001097          	auipc	ra,0x1
    80001a58:	748080e7          	jalr	1864(ra) # 8000319c <plic_complete>
            i--;
    80001a5c:	fedff06f          	j	80001a48 <handleInterrupt+0xf4>

0000000080001a60 <kern_thread_init>:
struct thread_s threads[MAX_THREADS];
static int id;
struct thread_s* running;

void kern_thread_init()
{
    80001a60:	ff010113          	addi	sp,sp,-16
    80001a64:	00813423          	sd	s0,8(sp)
    80001a68:	01010413          	addi	s0,sp,16
    id=0;
    80001a6c:	00004797          	auipc	a5,0x4
    80001a70:	be07ae23          	sw	zero,-1028(a5) # 80005668 <id>
    for (int i=0;i<MAX_THREADS;i++){
    80001a74:	00000793          	li	a5,0
    80001a78:	0240006f          	j	80001a9c <kern_thread_init+0x3c>
        threads[i].status=UNUSED;
    80001a7c:	00179713          	slli	a4,a5,0x1
    80001a80:	00f70733          	add	a4,a4,a5
    80001a84:	00571693          	slli	a3,a4,0x5
    80001a88:	00005717          	auipc	a4,0x5
    80001a8c:	c0870713          	addi	a4,a4,-1016 # 80006690 <threads>
    80001a90:	00d70733          	add	a4,a4,a3
    80001a94:	04072823          	sw	zero,80(a4)
    for (int i=0;i<MAX_THREADS;i++){
    80001a98:	0017879b          	addiw	a5,a5,1
    80001a9c:	03f00713          	li	a4,63
    80001aa0:	fcf75ee3          	bge	a4,a5,80001a7c <kern_thread_init+0x1c>
    }

    //set threads[0] as main thread
    threads[0].status=RUNNING;
    80001aa4:	00005797          	auipc	a5,0x5
    80001aa8:	bec78793          	addi	a5,a5,-1044 # 80006690 <threads>
    80001aac:	00100713          	li	a4,1
    80001ab0:	04e7a823          	sw	a4,80(a5)
    threads[0].id=0;
    80001ab4:	0007b823          	sd	zero,16(a5)
    threads[0].timeslice=DEFAULT_TIME_SLICE+2;
    80001ab8:	00400713          	li	a4,4
    80001abc:	02e7b823          	sd	a4,48(a5)
    threads[0].endTime=0;
    80001ac0:	0207bc23          	sd	zero,56(a5)
    running=&threads[0];
    80001ac4:	00004717          	auipc	a4,0x4
    80001ac8:	b8f73e23          	sd	a5,-1124(a4) # 80005660 <running>
}
    80001acc:	00813403          	ld	s0,8(sp)
    80001ad0:	01010113          	addi	sp,sp,16
    80001ad4:	00008067          	ret

0000000080001ad8 <kern_scheduler_get>:

thread_t kern_scheduler_get()
{
    80001ad8:	ff010113          	addi	sp,sp,-16
    80001adc:	00813423          	sd	s0,8(sp)
    80001ae0:	01010413          	addi	s0,sp,16
    int num = running-threads;
    80001ae4:	00004517          	auipc	a0,0x4
    80001ae8:	b7c53503          	ld	a0,-1156(a0) # 80005660 <running>
    80001aec:	00005797          	auipc	a5,0x5
    80001af0:	ba478793          	addi	a5,a5,-1116 # 80006690 <threads>
    80001af4:	40f507b3          	sub	a5,a0,a5
    80001af8:	4057d793          	srai	a5,a5,0x5
    80001afc:	00003717          	auipc	a4,0x3
    80001b00:	50473703          	ld	a4,1284(a4) # 80005000 <console_handler+0x5c0>
    80001b04:	02e787bb          	mulw	a5,a5,a4
    for(int i=1;i<=MAX_THREADS;i++){
    80001b08:	00100693          	li	a3,1
    80001b0c:	04000713          	li	a4,64
    80001b10:	06d74c63          	blt	a4,a3,80001b88 <kern_scheduler_get+0xb0>
        num = (num+i)%MAX_THREADS;
    80001b14:	00d787bb          	addw	a5,a5,a3
    80001b18:	41f7d71b          	sraiw	a4,a5,0x1f
    80001b1c:	01a7571b          	srliw	a4,a4,0x1a
    80001b20:	00e787bb          	addw	a5,a5,a4
    80001b24:	03f7f793          	andi	a5,a5,63
    80001b28:	40e787bb          	subw	a5,a5,a4
        if(threads[num].status==READY){
    80001b2c:	00179713          	slli	a4,a5,0x1
    80001b30:	00f70733          	add	a4,a4,a5
    80001b34:	00571613          	slli	a2,a4,0x5
    80001b38:	00005717          	auipc	a4,0x5
    80001b3c:	b5870713          	addi	a4,a4,-1192 # 80006690 <threads>
    80001b40:	00c70733          	add	a4,a4,a2
    80001b44:	05072603          	lw	a2,80(a4)
    80001b48:	00200713          	li	a4,2
    80001b4c:	00e60663          	beq	a2,a4,80001b58 <kern_scheduler_get+0x80>
    for(int i=1;i<=MAX_THREADS;i++){
    80001b50:	0016869b          	addiw	a3,a3,1
    80001b54:	fb9ff06f          	j	80001b0c <kern_scheduler_get+0x34>
            threads[num].status=RUNNING;
    80001b58:	00005617          	auipc	a2,0x5
    80001b5c:	b3860613          	addi	a2,a2,-1224 # 80006690 <threads>
    80001b60:	00179713          	slli	a4,a5,0x1
    80001b64:	00f705b3          	add	a1,a4,a5
    80001b68:	00559693          	slli	a3,a1,0x5
    80001b6c:	00d606b3          	add	a3,a2,a3
    80001b70:	00100593          	li	a1,1
    80001b74:	04b6a823          	sw	a1,80(a3)
            return &threads[num];
    80001b78:	00068513          	mv	a0,a3
    if(running->status==READY || running->status==RUNNING) {
        running->status=RUNNING;
        return running;
    }
    return 0;
}
    80001b7c:	00813403          	ld	s0,8(sp)
    80001b80:	01010113          	addi	sp,sp,16
    80001b84:	00008067          	ret
    if(running->status==READY || running->status==RUNNING) {
    80001b88:	05052783          	lw	a5,80(a0)
    80001b8c:	fff7879b          	addiw	a5,a5,-1
    80001b90:	00100713          	li	a4,1
    80001b94:	00f77663          	bgeu	a4,a5,80001ba0 <kern_scheduler_get+0xc8>
    return 0;
    80001b98:	00000513          	li	a0,0
    80001b9c:	fe1ff06f          	j	80001b7c <kern_scheduler_get+0xa4>
        running->status=RUNNING;
    80001ba0:	00100793          	li	a5,1
    80001ba4:	04f52823          	sw	a5,80(a0)
        return running;
    80001ba8:	fd5ff06f          	j	80001b7c <kern_scheduler_get+0xa4>

0000000080001bac <kern_thread_yield>:

void kern_thread_yield()
{
    80001bac:	ff010113          	addi	sp,sp,-16
    80001bb0:	00113423          	sd	ra,8(sp)
    80001bb4:	00813023          	sd	s0,0(sp)
    80001bb8:	01010413          	addi	s0,sp,16
    kern_syscall(THREAD_DISPATCH);
    80001bbc:	01300513          	li	a0,19
    80001bc0:	00000097          	auipc	ra,0x0
    80001bc4:	a48080e7          	jalr	-1464(ra) # 80001608 <kern_syscall>
}
    80001bc8:	00813083          	ld	ra,8(sp)
    80001bcc:	00013403          	ld	s0,0(sp)
    80001bd0:	01010113          	addi	sp,sp,16
    80001bd4:	00008067          	ret

0000000080001bd8 <popSppSpie>:

//samo izlazi iz kernela i vraca se odakle je pozvana
void popSppSpie()
{
    80001bd8:	ff010113          	addi	sp,sp,-16
    80001bdc:	00813423          	sd	s0,8(sp)
    80001be0:	01010413          	addi	s0,sp,16
    __asm__ volatile("csrw sepc, ra"); //ovde dodaj izlazak iz privilegovanog moda
    80001be4:	14109073          	csrw	sepc,ra
    __asm__ volatile("csrc sstatus, %[mask]" : : [mask] "r"(1 << 8));
    80001be8:	10000793          	li	a5,256
    80001bec:	1007b073          	csrc	sstatus,a5
    __asm__ volatile("sret");
    80001bf0:	10200073          	sret
}
    80001bf4:	00813403          	ld	s0,8(sp)
    80001bf8:	01010113          	addi	sp,sp,16
    80001bfc:	00008067          	ret

0000000080001c00 <kern_thread_dispatch>:

extern void contextSwitch(thread_t old, thread_t new);

void kern_thread_dispatch()
{
    80001c00:	fe010113          	addi	sp,sp,-32
    80001c04:	00113c23          	sd	ra,24(sp)
    80001c08:	00813823          	sd	s0,16(sp)
    80001c0c:	00913423          	sd	s1,8(sp)
    80001c10:	01213023          	sd	s2,0(sp)
    80001c14:	02010413          	addi	s0,sp,32
    thread_t old = running;
    80001c18:	00004917          	auipc	s2,0x4
    80001c1c:	a4890913          	addi	s2,s2,-1464 # 80005660 <running>
    80001c20:	00093483          	ld	s1,0(s2)
    running=kern_scheduler_get();
    80001c24:	00000097          	auipc	ra,0x0
    80001c28:	eb4080e7          	jalr	-332(ra) # 80001ad8 <kern_scheduler_get>
    80001c2c:	00a93023          	sd	a0,0(s2)
    if(old!=running){
    80001c30:	02950463          	beq	a0,s1,80001c58 <kern_thread_dispatch+0x58>
    80001c34:	00050593          	mv	a1,a0
        running->status=RUNNING;
    80001c38:	00100793          	li	a5,1
    80001c3c:	04f52823          	sw	a5,80(a0)
        if(old->status==RUNNING) old->status=READY;
    80001c40:	0504a703          	lw	a4,80(s1)
    80001c44:	00100793          	li	a5,1
    80001c48:	02f70463          	beq	a4,a5,80001c70 <kern_thread_dispatch+0x70>
        contextSwitch(old,running);
    80001c4c:	00048513          	mv	a0,s1
    80001c50:	fffff097          	auipc	ra,0xfffff
    80001c54:	5fc080e7          	jalr	1532(ra) # 8000124c <contextSwitch>
    }
}
    80001c58:	01813083          	ld	ra,24(sp)
    80001c5c:	01013403          	ld	s0,16(sp)
    80001c60:	00813483          	ld	s1,8(sp)
    80001c64:	00013903          	ld	s2,0(sp)
    80001c68:	02010113          	addi	sp,sp,32
    80001c6c:	00008067          	ret
        if(old->status==RUNNING) old->status=READY;
    80001c70:	00200793          	li	a5,2
    80001c74:	04f4a823          	sw	a5,80(s1)
    80001c78:	fd5ff06f          	j	80001c4c <kern_thread_dispatch+0x4c>

0000000080001c7c <kern_thread_end_running>:

void kern_thread_end_running()
{
    80001c7c:	fe010113          	addi	sp,sp,-32
    80001c80:	00113c23          	sd	ra,24(sp)
    80001c84:	00813823          	sd	s0,16(sp)
    80001c88:	00913423          	sd	s1,8(sp)
    80001c8c:	02010413          	addi	s0,sp,32
    thread_t old = running;
    80001c90:	00004497          	auipc	s1,0x4
    80001c94:	9d04b483          	ld	s1,-1584(s1) # 80005660 <running>
    old->status=UNUSED;
    80001c98:	0404a823          	sw	zero,80(s1)
    for(int i=0;i<MAX_THREADS;i++){
    80001c9c:	00000713          	li	a4,0
    80001ca0:	0080006f          	j	80001ca8 <kern_thread_end_running+0x2c>
    80001ca4:	0017071b          	addiw	a4,a4,1
    80001ca8:	03f00793          	li	a5,63
    80001cac:	06e7c863          	blt	a5,a4,80001d1c <kern_thread_end_running+0xa0>
        if(threads[i].status==JOINED && threads[i].joined_tid==old->id) threads[i].status=READY;
    80001cb0:	00171793          	slli	a5,a4,0x1
    80001cb4:	00e787b3          	add	a5,a5,a4
    80001cb8:	00579793          	slli	a5,a5,0x5
    80001cbc:	00005697          	auipc	a3,0x5
    80001cc0:	9d468693          	addi	a3,a3,-1580 # 80006690 <threads>
    80001cc4:	00f687b3          	add	a5,a3,a5
    80001cc8:	0507a683          	lw	a3,80(a5)
    80001ccc:	00400793          	li	a5,4
    80001cd0:	fcf69ae3          	bne	a3,a5,80001ca4 <kern_thread_end_running+0x28>
    80001cd4:	00171793          	slli	a5,a4,0x1
    80001cd8:	00e787b3          	add	a5,a5,a4
    80001cdc:	00579793          	slli	a5,a5,0x5
    80001ce0:	00005697          	auipc	a3,0x5
    80001ce4:	9b068693          	addi	a3,a3,-1616 # 80006690 <threads>
    80001ce8:	00f687b3          	add	a5,a3,a5
    80001cec:	0287b683          	ld	a3,40(a5)
    80001cf0:	0104b783          	ld	a5,16(s1)
    80001cf4:	faf698e3          	bne	a3,a5,80001ca4 <kern_thread_end_running+0x28>
    80001cf8:	00171793          	slli	a5,a4,0x1
    80001cfc:	00e787b3          	add	a5,a5,a4
    80001d00:	00579793          	slli	a5,a5,0x5
    80001d04:	00005697          	auipc	a3,0x5
    80001d08:	98c68693          	addi	a3,a3,-1652 # 80006690 <threads>
    80001d0c:	00f687b3          	add	a5,a3,a5
    80001d10:	00200693          	li	a3,2
    80001d14:	04d7a823          	sw	a3,80(a5)
    80001d18:	f8dff06f          	j	80001ca4 <kern_thread_end_running+0x28>
    }
    running=kern_scheduler_get();
    80001d1c:	00000097          	auipc	ra,0x0
    80001d20:	dbc080e7          	jalr	-580(ra) # 80001ad8 <kern_scheduler_get>
    80001d24:	00004797          	auipc	a5,0x4
    80001d28:	92a7be23          	sd	a0,-1732(a5) # 80005660 <running>
    if(old->stack_space!=0) kern_mem_free((void*)old->stack_space);
    80001d2c:	0404b503          	ld	a0,64(s1)
    80001d30:	02051863          	bnez	a0,80001d60 <kern_thread_end_running+0xe4>
    if(old!=running){
    80001d34:	00004597          	auipc	a1,0x4
    80001d38:	92c5b583          	ld	a1,-1748(a1) # 80005660 <running>
    80001d3c:	00958863          	beq	a1,s1,80001d4c <kern_thread_end_running+0xd0>
        contextSwitch(old,running);
    80001d40:	00048513          	mv	a0,s1
    80001d44:	fffff097          	auipc	ra,0xfffff
    80001d48:	508080e7          	jalr	1288(ra) # 8000124c <contextSwitch>
    }
}
    80001d4c:	01813083          	ld	ra,24(sp)
    80001d50:	01013403          	ld	s0,16(sp)
    80001d54:	00813483          	ld	s1,8(sp)
    80001d58:	02010113          	addi	sp,sp,32
    80001d5c:	00008067          	ret
    if(old->stack_space!=0) kern_mem_free((void*)old->stack_space);
    80001d60:	fffff097          	auipc	ra,0xfffff
    80001d64:	788080e7          	jalr	1928(ra) # 800014e8 <kern_mem_free>
    80001d68:	fcdff06f          	j	80001d34 <kern_thread_end_running+0xb8>

0000000080001d6c <kern_thread_wrapper>:

void kern_thread_wrapper()
{
    80001d6c:	fe010113          	addi	sp,sp,-32
    80001d70:	00113c23          	sd	ra,24(sp)
    80001d74:	00813823          	sd	s0,16(sp)
    80001d78:	00913423          	sd	s1,8(sp)
    80001d7c:	02010413          	addi	s0,sp,32
    popSppSpie();
    80001d80:	00000097          	auipc	ra,0x0
    80001d84:	e58080e7          	jalr	-424(ra) # 80001bd8 <popSppSpie>
    running->body(running->arg);
    80001d88:	00004497          	auipc	s1,0x4
    80001d8c:	8d848493          	addi	s1,s1,-1832 # 80005660 <running>
    80001d90:	0004b783          	ld	a5,0(s1)
    80001d94:	0187b703          	ld	a4,24(a5)
    80001d98:	0207b503          	ld	a0,32(a5)
    80001d9c:	000700e7          	jalr	a4
    running->status=UNUSED;
    80001da0:	0004b603          	ld	a2,0(s1)
    80001da4:	04062823          	sw	zero,80(a2)
    running->sem_next=0;
    80001da8:	04063c23          	sd	zero,88(a2)
    running->joined_tid=-1;
    80001dac:	fff00793          	li	a5,-1
    80001db0:	02f63423          	sd	a5,40(a2)
    for(int i=0;i<MAX_THREADS;i++){
    80001db4:	00000793          	li	a5,0
    80001db8:	0080006f          	j	80001dc0 <kern_thread_wrapper+0x54>
    80001dbc:	0017879b          	addiw	a5,a5,1
    80001dc0:	03f00713          	li	a4,63
    80001dc4:	06f74863          	blt	a4,a5,80001e34 <kern_thread_wrapper+0xc8>
        if(threads[i].status==JOINED && threads[i].joined_tid==running->id) threads[i].status=READY;
    80001dc8:	00179713          	slli	a4,a5,0x1
    80001dcc:	00f70733          	add	a4,a4,a5
    80001dd0:	00571693          	slli	a3,a4,0x5
    80001dd4:	00005717          	auipc	a4,0x5
    80001dd8:	8bc70713          	addi	a4,a4,-1860 # 80006690 <threads>
    80001ddc:	00d70733          	add	a4,a4,a3
    80001de0:	05072683          	lw	a3,80(a4)
    80001de4:	00400713          	li	a4,4
    80001de8:	fce69ae3          	bne	a3,a4,80001dbc <kern_thread_wrapper+0x50>
    80001dec:	00179713          	slli	a4,a5,0x1
    80001df0:	00f70733          	add	a4,a4,a5
    80001df4:	00571693          	slli	a3,a4,0x5
    80001df8:	00005717          	auipc	a4,0x5
    80001dfc:	89870713          	addi	a4,a4,-1896 # 80006690 <threads>
    80001e00:	00d70733          	add	a4,a4,a3
    80001e04:	02873683          	ld	a3,40(a4)
    80001e08:	01063703          	ld	a4,16(a2)
    80001e0c:	fae698e3          	bne	a3,a4,80001dbc <kern_thread_wrapper+0x50>
    80001e10:	00179713          	slli	a4,a5,0x1
    80001e14:	00f70733          	add	a4,a4,a5
    80001e18:	00571693          	slli	a3,a4,0x5
    80001e1c:	00005717          	auipc	a4,0x5
    80001e20:	87470713          	addi	a4,a4,-1932 # 80006690 <threads>
    80001e24:	00d70733          	add	a4,a4,a3
    80001e28:	00200693          	li	a3,2
    80001e2c:	04d72823          	sw	a3,80(a4)
    80001e30:	f8dff06f          	j	80001dbc <kern_thread_wrapper+0x50>
    }

    kern_thread_end_running();
    80001e34:	00000097          	auipc	ra,0x0
    80001e38:	e48080e7          	jalr	-440(ra) # 80001c7c <kern_thread_end_running>
}
    80001e3c:	01813083          	ld	ra,24(sp)
    80001e40:	01013403          	ld	s0,16(sp)
    80001e44:	00813483          	ld	s1,8(sp)
    80001e48:	02010113          	addi	sp,sp,32
    80001e4c:	00008067          	ret

0000000080001e50 <kern_thread_create>:

int kern_thread_create(thread_t* handle, void(*start_routine)(void*), void* arg, void* stack_space)
{
    80001e50:	ff010113          	addi	sp,sp,-16
    80001e54:	00813423          	sd	s0,8(sp)
    80001e58:	01010413          	addi	s0,sp,16
    *handle=0;
    80001e5c:	00053023          	sd	zero,0(a0)
    thread_t t=&threads[0]; //dodela da bismo sklonili upozorenje
    for(int i=0;i<MAX_THREADS;i++){
    80001e60:	00000713          	li	a4,0
    80001e64:	03f00793          	li	a5,63
    80001e68:	0ae7cc63          	blt	a5,a4,80001f20 <kern_thread_create+0xd0>
        if(threads[i].status==UNUSED){
    80001e6c:	00171793          	slli	a5,a4,0x1
    80001e70:	00e787b3          	add	a5,a5,a4
    80001e74:	00579793          	slli	a5,a5,0x5
    80001e78:	00005817          	auipc	a6,0x5
    80001e7c:	81880813          	addi	a6,a6,-2024 # 80006690 <threads>
    80001e80:	00f807b3          	add	a5,a6,a5
    80001e84:	0507a783          	lw	a5,80(a5)
    80001e88:	00078663          	beqz	a5,80001e94 <kern_thread_create+0x44>
    for(int i=0;i<MAX_THREADS;i++){
    80001e8c:	0017071b          	addiw	a4,a4,1
    80001e90:	fd5ff06f          	j	80001e64 <kern_thread_create+0x14>
            *handle=&threads[i];
    80001e94:	00171793          	slli	a5,a4,0x1
    80001e98:	00e787b3          	add	a5,a5,a4
    80001e9c:	00579793          	slli	a5,a5,0x5
    80001ea0:	010787b3          	add	a5,a5,a6
    80001ea4:	00f53023          	sd	a5,0(a0)
            t=&threads[i];
            break;
        }
    }
    if(*handle==0) return -1;
    80001ea8:	00053703          	ld	a4,0(a0)
    80001eac:	08070063          	beqz	a4,80001f2c <kern_thread_create+0xdc>

    t->id=++id;
    80001eb0:	00003517          	auipc	a0,0x3
    80001eb4:	7b850513          	addi	a0,a0,1976 # 80005668 <id>
    80001eb8:	00052703          	lw	a4,0(a0)
    80001ebc:	0017071b          	addiw	a4,a4,1
    80001ec0:	0007081b          	sext.w	a6,a4
    80001ec4:	00e52023          	sw	a4,0(a0)
    80001ec8:	0107b823          	sd	a6,16(a5)
    t->status=READY;
    80001ecc:	00200713          	li	a4,2
    80001ed0:	04e7a823          	sw	a4,80(a5)
    t->arg=arg;
    80001ed4:	02c7b023          	sd	a2,32(a5)
    t->joined_tid=-1;
    80001ed8:	fff00713          	li	a4,-1
    80001edc:	02e7b423          	sd	a4,40(a5)
    t->timeslice=DEFAULT_TIME_SLICE;
    80001ee0:	00200713          	li	a4,2
    80001ee4:	02e7b823          	sd	a4,48(a5)
    t->body=start_routine;
    80001ee8:	00b7bc23          	sd	a1,24(a5)
    t->stack_space = ((uint64)stack_space);
    80001eec:	04d7b023          	sd	a3,64(a5)
    t->sp = t->stack_space+(DEFAULT_STACK_SIZE);
    80001ef0:	00001737          	lui	a4,0x1
    80001ef4:	00e686b3          	add	a3,a3,a4
    80001ef8:	00d7b423          	sd	a3,8(a5)
    t->ra=(uint64) &kern_thread_wrapper;
    80001efc:	00000717          	auipc	a4,0x0
    80001f00:	e7070713          	addi	a4,a4,-400 # 80001d6c <kern_thread_wrapper>
    80001f04:	00e7b023          	sd	a4,0(a5)
    t->sem_next=0;
    80001f08:	0407bc23          	sd	zero,88(a5)
    t->mailbox=0;
    80001f0c:	0407b423          	sd	zero,72(a5)

    return 0;
    80001f10:	00000513          	li	a0,0
}
    80001f14:	00813403          	ld	s0,8(sp)
    80001f18:	01010113          	addi	sp,sp,16
    80001f1c:	00008067          	ret
    thread_t t=&threads[0]; //dodela da bismo sklonili upozorenje
    80001f20:	00004797          	auipc	a5,0x4
    80001f24:	77078793          	addi	a5,a5,1904 # 80006690 <threads>
    80001f28:	f81ff06f          	j	80001ea8 <kern_thread_create+0x58>
    if(*handle==0) return -1;
    80001f2c:	fff00513          	li	a0,-1
    80001f30:	fe5ff06f          	j	80001f14 <kern_thread_create+0xc4>

0000000080001f34 <kern_thread_join>:

void kern_thread_join(thread_t handle)
{
    if(handle->status==UNUSED) return;
    80001f34:	05052783          	lw	a5,80(a0)
    80001f38:	00079463          	bnez	a5,80001f40 <kern_thread_join+0xc>
    80001f3c:	00008067          	ret
{
    80001f40:	ff010113          	addi	sp,sp,-16
    80001f44:	00113423          	sd	ra,8(sp)
    80001f48:	00813023          	sd	s0,0(sp)
    80001f4c:	01010413          	addi	s0,sp,16
    running->joined_tid=handle->id;
    80001f50:	00003797          	auipc	a5,0x3
    80001f54:	7107b783          	ld	a5,1808(a5) # 80005660 <running>
    80001f58:	01053703          	ld	a4,16(a0)
    80001f5c:	02e7b423          	sd	a4,40(a5)
    running->status=JOINED;
    80001f60:	00400713          	li	a4,4
    80001f64:	04e7a823          	sw	a4,80(a5)
    kern_thread_dispatch();
    80001f68:	00000097          	auipc	ra,0x0
    80001f6c:	c98080e7          	jalr	-872(ra) # 80001c00 <kern_thread_dispatch>
}
    80001f70:	00813083          	ld	ra,8(sp)
    80001f74:	00013403          	ld	s0,0(sp)
    80001f78:	01010113          	addi	sp,sp,16
    80001f7c:	00008067          	ret

0000000080001f80 <kern_thread_wakeup>:

void kern_thread_wakeup(uint64 system_time)
{
    80001f80:	ff010113          	addi	sp,sp,-16
    80001f84:	00813423          	sd	s0,8(sp)
    80001f88:	01010413          	addi	s0,sp,16
    for(int i=0;i<MAX_THREADS;i++){
    80001f8c:	00000793          	li	a5,0
    80001f90:	0080006f          	j	80001f98 <kern_thread_wakeup+0x18>
    80001f94:	0017879b          	addiw	a5,a5,1
    80001f98:	03f00713          	li	a4,63
    80001f9c:	06f74263          	blt	a4,a5,80002000 <kern_thread_wakeup+0x80>
        if(threads[i].status==SLEEPING && threads[i].endTime<system_time){
    80001fa0:	00179713          	slli	a4,a5,0x1
    80001fa4:	00f70733          	add	a4,a4,a5
    80001fa8:	00571713          	slli	a4,a4,0x5
    80001fac:	00004697          	auipc	a3,0x4
    80001fb0:	6e468693          	addi	a3,a3,1764 # 80006690 <threads>
    80001fb4:	00e68733          	add	a4,a3,a4
    80001fb8:	05072683          	lw	a3,80(a4)
    80001fbc:	00500713          	li	a4,5
    80001fc0:	fce69ae3          	bne	a3,a4,80001f94 <kern_thread_wakeup+0x14>
    80001fc4:	00179713          	slli	a4,a5,0x1
    80001fc8:	00f70733          	add	a4,a4,a5
    80001fcc:	00571713          	slli	a4,a4,0x5
    80001fd0:	00004697          	auipc	a3,0x4
    80001fd4:	6c068693          	addi	a3,a3,1728 # 80006690 <threads>
    80001fd8:	00e68733          	add	a4,a3,a4
    80001fdc:	03873703          	ld	a4,56(a4)
    80001fe0:	faa77ae3          	bgeu	a4,a0,80001f94 <kern_thread_wakeup+0x14>
            threads[i].status=READY;
    80001fe4:	00179713          	slli	a4,a5,0x1
    80001fe8:	00f70733          	add	a4,a4,a5
    80001fec:	00571713          	slli	a4,a4,0x5
    80001ff0:	00e68733          	add	a4,a3,a4
    80001ff4:	00200693          	li	a3,2
    80001ff8:	04d72823          	sw	a3,80(a4)
    80001ffc:	f99ff06f          	j	80001f94 <kern_thread_wakeup+0x14>
        }
    }
}
    80002000:	00813403          	ld	s0,8(sp)
    80002004:	01010113          	addi	sp,sp,16
    80002008:	00008067          	ret

000000008000200c <mem_alloc>:
#include "../h/kern_interrupts.h"

#include <stdarg.h>


void* mem_alloc (size_t size){
    8000200c:	fe010113          	addi	sp,sp,-32
    80002010:	00113c23          	sd	ra,24(sp)
    80002014:	00813823          	sd	s0,16(sp)
    80002018:	02010413          	addi	s0,sp,32
    uint64 blocks = (size+MEM_BLOCK_SIZE-1)/MEM_BLOCK_SIZE;
    8000201c:	03f50593          	addi	a1,a0,63
    kern_syscall(MEM_ALLOC, blocks);
    80002020:	0065d593          	srli	a1,a1,0x6
    80002024:	00100513          	li	a0,1
    80002028:	fffff097          	auipc	ra,0xfffff
    8000202c:	5e0080e7          	jalr	1504(ra) # 80001608 <kern_syscall>
    __asm__ volatile ("mv %[a0], a0" : [a0] "=r"(a0));
    80002030:	00050793          	mv	a5,a0
    80002034:	fef43423          	sd	a5,-24(s0)
    return a0;
    80002038:	fe843503          	ld	a0,-24(s0)
    uint64 newBlockAddr = r_a0();
    return (void *) newBlockAddr;
}
    8000203c:	01813083          	ld	ra,24(sp)
    80002040:	01013403          	ld	s0,16(sp)
    80002044:	02010113          	addi	sp,sp,32
    80002048:	00008067          	ret

000000008000204c <mem_free>:

int mem_free (void* addr){
    8000204c:	fe010113          	addi	sp,sp,-32
    80002050:	00113c23          	sd	ra,24(sp)
    80002054:	00813823          	sd	s0,16(sp)
    80002058:	02010413          	addi	s0,sp,32
    8000205c:	00050593          	mv	a1,a0
    kern_syscall(MEM_FREE,addr);
    80002060:	00200513          	li	a0,2
    80002064:	fffff097          	auipc	ra,0xfffff
    80002068:	5a4080e7          	jalr	1444(ra) # 80001608 <kern_syscall>
    __asm__ volatile ("mv %[a0], a0" : [a0] "=r"(a0));
    8000206c:	00050793          	mv	a5,a0
    80002070:	fef43423          	sd	a5,-24(s0)
    return a0;
    80002074:	fe843503          	ld	a0,-24(s0)
    int res = (int) r_a0();
    return res;
}
    80002078:	0005051b          	sext.w	a0,a0
    8000207c:	01813083          	ld	ra,24(sp)
    80002080:	01013403          	ld	s0,16(sp)
    80002084:	02010113          	addi	sp,sp,32
    80002088:	00008067          	ret

000000008000208c <thread_create>:

struct thread_s;
typedef struct thread_s* thread_t;

int thread_create (thread_t* handle, void(*start_routine)(void*), void* arg)
{
    8000208c:	fc010113          	addi	sp,sp,-64
    80002090:	02113c23          	sd	ra,56(sp)
    80002094:	02813823          	sd	s0,48(sp)
    80002098:	02913423          	sd	s1,40(sp)
    8000209c:	03213023          	sd	s2,32(sp)
    800020a0:	01313c23          	sd	s3,24(sp)
    800020a4:	04010413          	addi	s0,sp,64
    800020a8:	00050493          	mv	s1,a0
    800020ac:	00058913          	mv	s2,a1
    800020b0:	00060993          	mv	s3,a2
    void * stack = mem_alloc(DEFAULT_STACK_SIZE);
    800020b4:	00001537          	lui	a0,0x1
    800020b8:	00000097          	auipc	ra,0x0
    800020bc:	f54080e7          	jalr	-172(ra) # 8000200c <mem_alloc>
    if(stack==0) return -1;
    800020c0:	04050663          	beqz	a0,8000210c <thread_create+0x80>
    800020c4:	00050713          	mv	a4,a0
    kern_syscall(THREAD_CREATE,handle,start_routine,arg,stack);
    800020c8:	00098693          	mv	a3,s3
    800020cc:	00090613          	mv	a2,s2
    800020d0:	00048593          	mv	a1,s1
    800020d4:	01100513          	li	a0,17
    800020d8:	fffff097          	auipc	ra,0xfffff
    800020dc:	530080e7          	jalr	1328(ra) # 80001608 <kern_syscall>
    __asm__ volatile ("mv %[a0], a0" : [a0] "=r"(a0));
    800020e0:	00050793          	mv	a5,a0
    800020e4:	fcf43423          	sd	a5,-56(s0)
    return a0;
    800020e8:	fc843503          	ld	a0,-56(s0)
    int res = r_a0();
    800020ec:	0005051b          	sext.w	a0,a0
    return res;
}
    800020f0:	03813083          	ld	ra,56(sp)
    800020f4:	03013403          	ld	s0,48(sp)
    800020f8:	02813483          	ld	s1,40(sp)
    800020fc:	02013903          	ld	s2,32(sp)
    80002100:	01813983          	ld	s3,24(sp)
    80002104:	04010113          	addi	sp,sp,64
    80002108:	00008067          	ret
    if(stack==0) return -1;
    8000210c:	fff00513          	li	a0,-1
    80002110:	fe1ff06f          	j	800020f0 <thread_create+0x64>

0000000080002114 <thread_dispatch>:

void thread_dispatch(){
    80002114:	ff010113          	addi	sp,sp,-16
    80002118:	00113423          	sd	ra,8(sp)
    8000211c:	00813023          	sd	s0,0(sp)
    80002120:	01010413          	addi	s0,sp,16
    kern_syscall(THREAD_DISPATCH);
    80002124:	01300513          	li	a0,19
    80002128:	fffff097          	auipc	ra,0xfffff
    8000212c:	4e0080e7          	jalr	1248(ra) # 80001608 <kern_syscall>
}
    80002130:	00813083          	ld	ra,8(sp)
    80002134:	00013403          	ld	s0,0(sp)
    80002138:	01010113          	addi	sp,sp,16
    8000213c:	00008067          	ret

0000000080002140 <thread_exit>:

int thread_exit ()
{
    80002140:	fe010113          	addi	sp,sp,-32
    80002144:	00113c23          	sd	ra,24(sp)
    80002148:	00813823          	sd	s0,16(sp)
    8000214c:	00913423          	sd	s1,8(sp)
    80002150:	02010413          	addi	s0,sp,32
    void* stack = (void*)running->stack_space;
    80002154:	00003797          	auipc	a5,0x3
    80002158:	50c7b783          	ld	a5,1292(a5) # 80005660 <running>
    8000215c:	0407b483          	ld	s1,64(a5)
    kern_syscall(THREAD_EXIT);
    80002160:	01200513          	li	a0,18
    80002164:	fffff097          	auipc	ra,0xfffff
    80002168:	4a4080e7          	jalr	1188(ra) # 80001608 <kern_syscall>
    kern_syscall(MEM_FREE,stack);
    8000216c:	00048593          	mv	a1,s1
    80002170:	00200513          	li	a0,2
    80002174:	fffff097          	auipc	ra,0xfffff
    80002178:	494080e7          	jalr	1172(ra) # 80001608 <kern_syscall>
    return 0;
}
    8000217c:	00000513          	li	a0,0
    80002180:	01813083          	ld	ra,24(sp)
    80002184:	01013403          	ld	s0,16(sp)
    80002188:	00813483          	ld	s1,8(sp)
    8000218c:	02010113          	addi	sp,sp,32
    80002190:	00008067          	ret

0000000080002194 <thread_join>:

void thread_join(thread_t handle)
{
    80002194:	ff010113          	addi	sp,sp,-16
    80002198:	00113423          	sd	ra,8(sp)
    8000219c:	00813023          	sd	s0,0(sp)
    800021a0:	01010413          	addi	s0,sp,16
    800021a4:	00050593          	mv	a1,a0
    kern_syscall(THREAD_JOIN,handle);
    800021a8:	01400513          	li	a0,20
    800021ac:	fffff097          	auipc	ra,0xfffff
    800021b0:	45c080e7          	jalr	1116(ra) # 80001608 <kern_syscall>
}
    800021b4:	00813083          	ld	ra,8(sp)
    800021b8:	00013403          	ld	s0,0(sp)
    800021bc:	01010113          	addi	sp,sp,16
    800021c0:	00008067          	ret

00000000800021c4 <sem_open>:

int sem_open (sem_t* handle, unsigned init)
{
    800021c4:	fe010113          	addi	sp,sp,-32
    800021c8:	00113c23          	sd	ra,24(sp)
    800021cc:	00813823          	sd	s0,16(sp)
    800021d0:	02010413          	addi	s0,sp,32
    800021d4:	00058613          	mv	a2,a1
    kern_syscall(SEM_OPEN,handle,init);
    800021d8:	00050593          	mv	a1,a0
    800021dc:	02100513          	li	a0,33
    800021e0:	fffff097          	auipc	ra,0xfffff
    800021e4:	428080e7          	jalr	1064(ra) # 80001608 <kern_syscall>
    __asm__ volatile ("mv %[a0], a0" : [a0] "=r"(a0));
    800021e8:	00050793          	mv	a5,a0
    800021ec:	fef43423          	sd	a5,-24(s0)
    return a0;
    800021f0:	fe843503          	ld	a0,-24(s0)
    int res = r_a0();
    return res;
}
    800021f4:	0005051b          	sext.w	a0,a0
    800021f8:	01813083          	ld	ra,24(sp)
    800021fc:	01013403          	ld	s0,16(sp)
    80002200:	02010113          	addi	sp,sp,32
    80002204:	00008067          	ret

0000000080002208 <sem_close>:

int sem_close (sem_t handle)
{
    80002208:	fe010113          	addi	sp,sp,-32
    8000220c:	00113c23          	sd	ra,24(sp)
    80002210:	00813823          	sd	s0,16(sp)
    80002214:	02010413          	addi	s0,sp,32
    80002218:	00050593          	mv	a1,a0
    kern_syscall(SEM_CLOSE,handle);
    8000221c:	02200513          	li	a0,34
    80002220:	fffff097          	auipc	ra,0xfffff
    80002224:	3e8080e7          	jalr	1000(ra) # 80001608 <kern_syscall>
    __asm__ volatile ("mv %[a0], a0" : [a0] "=r"(a0));
    80002228:	00050793          	mv	a5,a0
    8000222c:	fef43423          	sd	a5,-24(s0)
    return a0;
    80002230:	fe843503          	ld	a0,-24(s0)
    int res = r_a0();
    return res;
}
    80002234:	0005051b          	sext.w	a0,a0
    80002238:	01813083          	ld	ra,24(sp)
    8000223c:	01013403          	ld	s0,16(sp)
    80002240:	02010113          	addi	sp,sp,32
    80002244:	00008067          	ret

0000000080002248 <sem_wait>:

int sem_wait (sem_t id)
{
    80002248:	fe010113          	addi	sp,sp,-32
    8000224c:	00113c23          	sd	ra,24(sp)
    80002250:	00813823          	sd	s0,16(sp)
    80002254:	02010413          	addi	s0,sp,32
    80002258:	00050593          	mv	a1,a0
    kern_syscall(SEM_WAIT,id);
    8000225c:	02300513          	li	a0,35
    80002260:	fffff097          	auipc	ra,0xfffff
    80002264:	3a8080e7          	jalr	936(ra) # 80001608 <kern_syscall>
    __asm__ volatile ("mv %[a0], a0" : [a0] "=r"(a0));
    80002268:	00050793          	mv	a5,a0
    8000226c:	fef43423          	sd	a5,-24(s0)
    return a0;
    80002270:	fe843503          	ld	a0,-24(s0)
    int res = r_a0();
    return res;
}
    80002274:	0005051b          	sext.w	a0,a0
    80002278:	01813083          	ld	ra,24(sp)
    8000227c:	01013403          	ld	s0,16(sp)
    80002280:	02010113          	addi	sp,sp,32
    80002284:	00008067          	ret

0000000080002288 <sem_signal>:

int sem_signal (sem_t id){
    80002288:	fe010113          	addi	sp,sp,-32
    8000228c:	00113c23          	sd	ra,24(sp)
    80002290:	00813823          	sd	s0,16(sp)
    80002294:	02010413          	addi	s0,sp,32
    80002298:	00050593          	mv	a1,a0
    kern_syscall(SEM_SIGNAL,id);
    8000229c:	02400513          	li	a0,36
    800022a0:	fffff097          	auipc	ra,0xfffff
    800022a4:	368080e7          	jalr	872(ra) # 80001608 <kern_syscall>
    __asm__ volatile ("mv %[a0], a0" : [a0] "=r"(a0));
    800022a8:	00050793          	mv	a5,a0
    800022ac:	fef43423          	sd	a5,-24(s0)
    return a0;
    800022b0:	fe843503          	ld	a0,-24(s0)
    int res = r_a0();
    return res;
}
    800022b4:	0005051b          	sext.w	a0,a0
    800022b8:	01813083          	ld	ra,24(sp)
    800022bc:	01013403          	ld	s0,16(sp)
    800022c0:	02010113          	addi	sp,sp,32
    800022c4:	00008067          	ret

00000000800022c8 <time_sleep>:

int time_sleep(unsigned long time){
    800022c8:	ff010113          	addi	sp,sp,-16
    800022cc:	00113423          	sd	ra,8(sp)
    800022d0:	00813023          	sd	s0,0(sp)
    800022d4:	01010413          	addi	s0,sp,16
    800022d8:	00050593          	mv	a1,a0
    kern_syscall(TIME_SLEEP,time);
    800022dc:	03100513          	li	a0,49
    800022e0:	fffff097          	auipc	ra,0xfffff
    800022e4:	328080e7          	jalr	808(ra) # 80001608 <kern_syscall>
    return 0;
    800022e8:	00000513          	li	a0,0
    800022ec:	00813083          	ld	ra,8(sp)
    800022f0:	00013403          	ld	s0,0(sp)
    800022f4:	01010113          	addi	sp,sp,16
    800022f8:	00008067          	ret

00000000800022fc <kern_console_init>:
    int output_put_cursor;
    int output_get_cursor;
} console_instance;

void kern_console_init()
{
    800022fc:	ff010113          	addi	sp,sp,-16
    80002300:	00113423          	sd	ra,8(sp)
    80002304:	00813023          	sd	s0,0(sp)
    80002308:	01010413          	addi	s0,sp,16
    console_instance.input_put_cursor=0;
    8000230c:	00007797          	auipc	a5,0x7
    80002310:	b8478793          	addi	a5,a5,-1148 # 80008e90 <stack0+0x7a0>
    80002314:	8007a823          	sw	zero,-2032(a5)
    console_instance.input_get_cursor=0;
    80002318:	8007aa23          	sw	zero,-2028(a5)
    console_instance.output_put_cursor=0;
    8000231c:	8007ac23          	sw	zero,-2024(a5)
    console_instance.output_get_cursor=0;
    80002320:	8007ae23          	sw	zero,-2020(a5)
    kern_sem_open(&console_instance.input_sem,0);
    80002324:	00000593          	li	a1,0
    80002328:	00006517          	auipc	a0,0x6
    8000232c:	36850513          	addi	a0,a0,872 # 80008690 <console_instance+0x800>
    80002330:	fffff097          	auipc	ra,0xfffff
    80002334:	f7c080e7          	jalr	-132(ra) # 800012ac <kern_sem_open>
    kern_sem_open(&console_instance.output_sem,CONSOLE_BUFFER_SIZE);
    80002338:	40000593          	li	a1,1024
    8000233c:	00006517          	auipc	a0,0x6
    80002340:	35c50513          	addi	a0,a0,860 # 80008698 <console_instance+0x808>
    80002344:	fffff097          	auipc	ra,0xfffff
    80002348:	f68080e7          	jalr	-152(ra) # 800012ac <kern_sem_open>
}
    8000234c:	00813083          	ld	ra,8(sp)
    80002350:	00013403          	ld	s0,0(sp)
    80002354:	01010113          	addi	sp,sp,16
    80002358:	00008067          	ret

000000008000235c <kern_console_putc>:

void kern_console_putc()
{
    8000235c:	ff010113          	addi	sp,sp,-16
    80002360:	00813423          	sd	s0,8(sp)
    80002364:	01010413          	addi	s0,sp,16

}
    80002368:	00813403          	ld	s0,8(sp)
    8000236c:	01010113          	addi	sp,sp,16
    80002370:	00008067          	ret

0000000080002374 <_Z8bodyIdlePv>:

Semaphore* semTest;

int idleAlive=1;
void bodyIdle(void* arg){
    while(idleAlive){
    80002374:	00003797          	auipc	a5,0x3
    80002378:	22c7a783          	lw	a5,556(a5) # 800055a0 <idleAlive>
    8000237c:	02078c63          	beqz	a5,800023b4 <_Z8bodyIdlePv+0x40>
void bodyIdle(void* arg){
    80002380:	ff010113          	addi	sp,sp,-16
    80002384:	00113423          	sd	ra,8(sp)
    80002388:	00813023          	sd	s0,0(sp)
    8000238c:	01010413          	addi	s0,sp,16
        thread_dispatch();
    80002390:	00000097          	auipc	ra,0x0
    80002394:	d84080e7          	jalr	-636(ra) # 80002114 <thread_dispatch>
    while(idleAlive){
    80002398:	00003797          	auipc	a5,0x3
    8000239c:	2087a783          	lw	a5,520(a5) # 800055a0 <idleAlive>
    800023a0:	fe0798e3          	bnez	a5,80002390 <_Z8bodyIdlePv+0x1c>
    };
}
    800023a4:	00813083          	ld	ra,8(sp)
    800023a8:	00013403          	ld	s0,0(sp)
    800023ac:	01010113          	addi	sp,sp,16
    800023b0:	00008067          	ret
    800023b4:	00008067          	ret

00000000800023b8 <_Z5bodyCPv>:

void bodyC(void* arg)
{
    800023b8:	fe010113          	addi	sp,sp,-32
    800023bc:	00113c23          	sd	ra,24(sp)
    800023c0:	00813823          	sd	s0,16(sp)
    800023c4:	00913423          	sd	s1,8(sp)
    800023c8:	01213023          	sd	s2,0(sp)
    800023cc:	02010413          	addi	s0,sp,32
    800023d0:	00050913          	mv	s2,a0
    int counter=0;
    800023d4:	00000493          	li	s1,0
    char*c = (char*)arg;
    while(counter<10){
    800023d8:	00900793          	li	a5,9
    800023dc:	0297c263          	blt	a5,s1,80002400 <_Z5bodyCPv+0x48>
        //if(++counter>5) delete semTest;
        __putc(*c);
    800023e0:	00094503          	lbu	a0,0(s2)
    800023e4:	00002097          	auipc	ra,0x2
    800023e8:	5e8080e7          	jalr	1512(ra) # 800049cc <__putc>
        time_sleep(5);
    800023ec:	00500513          	li	a0,5
    800023f0:	00000097          	auipc	ra,0x0
    800023f4:	ed8080e7          	jalr	-296(ra) # 800022c8 <time_sleep>
        counter++;
    800023f8:	0014849b          	addiw	s1,s1,1
    while(counter<10){
    800023fc:	fddff06f          	j	800023d8 <_Z5bodyCPv+0x20>
    }
}
    80002400:	01813083          	ld	ra,24(sp)
    80002404:	01013403          	ld	s0,16(sp)
    80002408:	00813483          	ld	s1,8(sp)
    8000240c:	00013903          	ld	s2,0(sp)
    80002410:	02010113          	addi	sp,sp,32
    80002414:	00008067          	ret

0000000080002418 <_Z5bodyAPv>:

void bodyA(void* arg)
{
    80002418:	fe010113          	addi	sp,sp,-32
    8000241c:	00113c23          	sd	ra,24(sp)
    80002420:	00813823          	sd	s0,16(sp)
    80002424:	00913423          	sd	s1,8(sp)
    80002428:	01213023          	sd	s2,0(sp)
    8000242c:	02010413          	addi	s0,sp,32
        }
        virtual ~Semaphore (){
            sem_close(myHandle);
        }
        int wait (){
            return sem_wait(myHandle);
    80002430:	00006797          	auipc	a5,0x6
    80002434:	2807b783          	ld	a5,640(a5) # 800086b0 <semTest>
    80002438:	0087b503          	ld	a0,8(a5)
    8000243c:	00000097          	auipc	ra,0x0
    80002440:	e0c080e7          	jalr	-500(ra) # 80002248 <sem_wait>
    char c = 'a';
    if(semTest->wait()) c='A';
    80002444:	00051863          	bnez	a0,80002454 <_Z5bodyAPv+0x3c>
    char c = 'a';
    80002448:	06100913          	li	s2,97
    for(int i=0;i<10;i++){
    8000244c:	00000493          	li	s1,0
    80002450:	0200006f          	j	80002470 <_Z5bodyAPv+0x58>
    if(semTest->wait()) c='A';
    80002454:	04100913          	li	s2,65
    80002458:	ff5ff06f          	j	8000244c <_Z5bodyAPv+0x34>
        __putc(c);
        if(i==5) thread_exit();
    8000245c:	00000097          	auipc	ra,0x0
    80002460:	ce4080e7          	jalr	-796(ra) # 80002140 <thread_exit>
        thread_dispatch();
    80002464:	00000097          	auipc	ra,0x0
    80002468:	cb0080e7          	jalr	-848(ra) # 80002114 <thread_dispatch>
    for(int i=0;i<10;i++){
    8000246c:	0014849b          	addiw	s1,s1,1
    80002470:	00900793          	li	a5,9
    80002474:	0097ce63          	blt	a5,s1,80002490 <_Z5bodyAPv+0x78>
        __putc(c);
    80002478:	00090513          	mv	a0,s2
    8000247c:	00002097          	auipc	ra,0x2
    80002480:	550080e7          	jalr	1360(ra) # 800049cc <__putc>
        if(i==5) thread_exit();
    80002484:	00500793          	li	a5,5
    80002488:	fcf49ee3          	bne	s1,a5,80002464 <_Z5bodyAPv+0x4c>
    8000248c:	fd1ff06f          	j	8000245c <_Z5bodyAPv+0x44>
    }
}
    80002490:	01813083          	ld	ra,24(sp)
    80002494:	01013403          	ld	s0,16(sp)
    80002498:	00813483          	ld	s1,8(sp)
    8000249c:	00013903          	ld	s2,0(sp)
    800024a0:	02010113          	addi	sp,sp,32
    800024a4:	00008067          	ret

00000000800024a8 <_Z5bodyBPv>:

int g=0;

char str[15] = "tesa legenda";
void bodyB(void* arg)
{
    800024a8:	fe010113          	addi	sp,sp,-32
    800024ac:	00113c23          	sd	ra,24(sp)
    800024b0:	00813823          	sd	s0,16(sp)
    800024b4:	00913423          	sd	s1,8(sp)
    800024b8:	02010413          	addi	s0,sp,32
    time_sleep(10);
    800024bc:	00a00513          	li	a0,10
    800024c0:	00000097          	auipc	ra,0x0
    800024c4:	e08080e7          	jalr	-504(ra) # 800022c8 <time_sleep>
    for(int i=0;i<15;i++){
    800024c8:	00000493          	li	s1,0
    800024cc:	0540006f          	j	80002520 <_Z5bodyBPv+0x78>
        __putc(str[i]);
        for(int k=0;k<10000;k++){
            for(int m=0;m<1000;m++){
    800024d0:	0017071b          	addiw	a4,a4,1
    800024d4:	3e700793          	li	a5,999
    800024d8:	02e7c663          	blt	a5,a4,80002504 <_Z5bodyBPv+0x5c>
                if((m*k)%1337==0) g++;
    800024dc:	02e607bb          	mulw	a5,a2,a4
    800024e0:	53900693          	li	a3,1337
    800024e4:	02d7e7bb          	remw	a5,a5,a3
    800024e8:	fe0794e3          	bnez	a5,800024d0 <_Z5bodyBPv+0x28>
    800024ec:	00006697          	auipc	a3,0x6
    800024f0:	1c468693          	addi	a3,a3,452 # 800086b0 <semTest>
    800024f4:	0086a783          	lw	a5,8(a3)
    800024f8:	0017879b          	addiw	a5,a5,1
    800024fc:	00f6a423          	sw	a5,8(a3)
    80002500:	fd1ff06f          	j	800024d0 <_Z5bodyBPv+0x28>
        for(int k=0;k<10000;k++){
    80002504:	0016061b          	addiw	a2,a2,1
    80002508:	000027b7          	lui	a5,0x2
    8000250c:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    80002510:	00c7c663          	blt	a5,a2,8000251c <_Z5bodyBPv+0x74>
            for(int m=0;m<1000;m++){
    80002514:	00000713          	li	a4,0
    80002518:	fbdff06f          	j	800024d4 <_Z5bodyBPv+0x2c>
    for(int i=0;i<15;i++){
    8000251c:	0014849b          	addiw	s1,s1,1
    80002520:	00e00793          	li	a5,14
    80002524:	0297c263          	blt	a5,s1,80002548 <_Z5bodyBPv+0xa0>
        __putc(str[i]);
    80002528:	00003797          	auipc	a5,0x3
    8000252c:	07878793          	addi	a5,a5,120 # 800055a0 <idleAlive>
    80002530:	009787b3          	add	a5,a5,s1
    80002534:	0087c503          	lbu	a0,8(a5)
    80002538:	00002097          	auipc	ra,0x2
    8000253c:	494080e7          	jalr	1172(ra) # 800049cc <__putc>
        for(int k=0;k<10000;k++){
    80002540:	00000613          	li	a2,0
    80002544:	fc5ff06f          	j	80002508 <_Z5bodyBPv+0x60>
        }
        int signal (){
            return sem_signal(myHandle);
    80002548:	00006797          	auipc	a5,0x6
    8000254c:	1687b783          	ld	a5,360(a5) # 800086b0 <semTest>
    80002550:	0087b503          	ld	a0,8(a5)
    80002554:	00000097          	auipc	ra,0x0
    80002558:	d34080e7          	jalr	-716(ra) # 80002288 <sem_signal>
            }
        }
    }
    semTest->signal();
}
    8000255c:	01813083          	ld	ra,24(sp)
    80002560:	01013403          	ld	s0,16(sp)
    80002564:	00813483          	ld	s1,8(sp)
    80002568:	02010113          	addi	sp,sp,32
    8000256c:	00008067          	ret

0000000080002570 <_Znwm>:
void* operator new(size_t size) {
    80002570:	ff010113          	addi	sp,sp,-16
    80002574:	00113423          	sd	ra,8(sp)
    80002578:	00813023          	sd	s0,0(sp)
    8000257c:	01010413          	addi	s0,sp,16
    void* ptr = mem_alloc(size);
    80002580:	00000097          	auipc	ra,0x0
    80002584:	a8c080e7          	jalr	-1396(ra) # 8000200c <mem_alloc>
}
    80002588:	00813083          	ld	ra,8(sp)
    8000258c:	00013403          	ld	s0,0(sp)
    80002590:	01010113          	addi	sp,sp,16
    80002594:	00008067          	ret

0000000080002598 <_ZdlPv>:
void operator delete(void* ptr) {
    80002598:	ff010113          	addi	sp,sp,-16
    8000259c:	00113423          	sd	ra,8(sp)
    800025a0:	00813023          	sd	s0,0(sp)
    800025a4:	01010413          	addi	s0,sp,16
    mem_free(ptr);
    800025a8:	00000097          	auipc	ra,0x0
    800025ac:	aa4080e7          	jalr	-1372(ra) # 8000204c <mem_free>
}
    800025b0:	00813083          	ld	ra,8(sp)
    800025b4:	00013403          	ld	s0,0(sp)
    800025b8:	01010113          	addi	sp,sp,16
    800025bc:	00008067          	ret

00000000800025c0 <main>:


int main()
{
    800025c0:	fc010113          	addi	sp,sp,-64
    800025c4:	02113c23          	sd	ra,56(sp)
    800025c8:	02813823          	sd	s0,48(sp)
    800025cc:	02913423          	sd	s1,40(sp)
    800025d0:	03213023          	sd	s2,32(sp)
    800025d4:	01313c23          	sd	s3,24(sp)
    800025d8:	04010413          	addi	s0,sp,64
    kern_thread_init();
    800025dc:	fffff097          	auipc	ra,0xfffff
    800025e0:	484080e7          	jalr	1156(ra) # 80001a60 <kern_thread_init>
    //printstring("lalala");

    kern_mem_init((void*)HEAP_START_ADDR, (void*)HEAP_END_ADDR);
    800025e4:	00003797          	auipc	a5,0x3
    800025e8:	03c7b783          	ld	a5,60(a5) # 80005620 <_GLOBAL_OFFSET_TABLE_+0x18>
    800025ec:	0007b583          	ld	a1,0(a5)
    800025f0:	00003797          	auipc	a5,0x3
    800025f4:	0207b783          	ld	a5,32(a5) # 80005610 <_GLOBAL_OFFSET_TABLE_+0x8>
    800025f8:	0007b503          	ld	a0,0(a5)
    800025fc:	fffff097          	auipc	ra,0xfffff
    80002600:	f9c080e7          	jalr	-100(ra) # 80001598 <kern_mem_init>
    kern_interrupt_init();
    80002604:	fffff097          	auipc	ra,0xfffff
    80002608:	03c080e7          	jalr	60(ra) # 80001640 <kern_interrupt_init>
    kern_sem_init();
    8000260c:	fffff097          	auipc	ra,0xfffff
    80002610:	c54080e7          	jalr	-940(ra) # 80001260 <kern_sem_init>

    Thread* thrIdle = new Thread(&bodyIdle,0);
    80002614:	02000513          	li	a0,32
    80002618:	00000097          	auipc	ra,0x0
    8000261c:	f58080e7          	jalr	-168(ra) # 80002570 <_Znwm>
        {
    80002620:	00003797          	auipc	a5,0x3
    80002624:	fa878793          	addi	a5,a5,-88 # 800055c8 <_ZTV6Thread+0x10>
    80002628:	00f53023          	sd	a5,0(a0)
            this->body=body;
    8000262c:	00000597          	auipc	a1,0x0
    80002630:	d4858593          	addi	a1,a1,-696 # 80002374 <_Z8bodyIdlePv>
    80002634:	00b53823          	sd	a1,16(a0)
            this->arg=arg;
    80002638:	00053c23          	sd	zero,24(a0)
            return thread_create(&myHandle,body,arg);
    8000263c:	00000613          	li	a2,0
    80002640:	00850513          	addi	a0,a0,8
    80002644:	00000097          	auipc	ra,0x0
    80002648:	a48080e7          	jalr	-1464(ra) # 8000208c <thread_create>
    a= mem_alloc(64);
    mem_free(a);
    */


    semTest=new Semaphore(0);
    8000264c:	01000513          	li	a0,16
    80002650:	00000097          	auipc	ra,0x0
    80002654:	f20080e7          	jalr	-224(ra) # 80002570 <_Znwm>
    80002658:	00050493          	mv	s1,a0
        Semaphore (unsigned init = 1){
    8000265c:	00003797          	auipc	a5,0x3
    80002660:	f9478793          	addi	a5,a5,-108 # 800055f0 <_ZTV9Semaphore+0x10>
    80002664:	00f53023          	sd	a5,0(a0)
            sem_open(&myHandle,init);
    80002668:	00000593          	li	a1,0
    8000266c:	00850513          	addi	a0,a0,8
    80002670:	00000097          	auipc	ra,0x0
    80002674:	b54080e7          	jalr	-1196(ra) # 800021c4 <sem_open>
    80002678:	00006797          	auipc	a5,0x6
    8000267c:	0297bc23          	sd	s1,56(a5) # 800086b0 <semTest>
    Thread *thrA = new Thread(&bodyA,0);
    80002680:	02000513          	li	a0,32
    80002684:	00000097          	auipc	ra,0x0
    80002688:	eec080e7          	jalr	-276(ra) # 80002570 <_Znwm>
    8000268c:	00050913          	mv	s2,a0
        {
    80002690:	00003997          	auipc	s3,0x3
    80002694:	f3898993          	addi	s3,s3,-200 # 800055c8 <_ZTV6Thread+0x10>
    80002698:	01353023          	sd	s3,0(a0)
            this->body=body;
    8000269c:	00000797          	auipc	a5,0x0
    800026a0:	d7c78793          	addi	a5,a5,-644 # 80002418 <_Z5bodyAPv>
    800026a4:	00f53823          	sd	a5,16(a0)
            this->arg=arg;
    800026a8:	00053c23          	sd	zero,24(a0)
    Thread *thrB = new Thread(&bodyB,0);
    800026ac:	02000513          	li	a0,32
    800026b0:	00000097          	auipc	ra,0x0
    800026b4:	ec0080e7          	jalr	-320(ra) # 80002570 <_Znwm>
    800026b8:	00050493          	mv	s1,a0
        {
    800026bc:	01353023          	sd	s3,0(a0)
            this->body=body;
    800026c0:	00000797          	auipc	a5,0x0
    800026c4:	de878793          	addi	a5,a5,-536 # 800024a8 <_Z5bodyBPv>
    800026c8:	00f53823          	sd	a5,16(a0)
            this->arg=arg;
    800026cc:	00053c23          	sd	zero,24(a0)
            return thread_create(&myHandle,body,arg);
    800026d0:	01893603          	ld	a2,24(s2)
    800026d4:	01093583          	ld	a1,16(s2)
    800026d8:	00890513          	addi	a0,s2,8
    800026dc:	00000097          	auipc	ra,0x0
    800026e0:	9b0080e7          	jalr	-1616(ra) # 8000208c <thread_create>
    800026e4:	0184b603          	ld	a2,24(s1)
    800026e8:	0104b583          	ld	a1,16(s1)
    800026ec:	00848513          	addi	a0,s1,8
    800026f0:	00000097          	auipc	ra,0x0
    800026f4:	99c080e7          	jalr	-1636(ra) # 8000208c <thread_create>
    thrA->start();
    thrB->start();
    __putc('S');
    800026f8:	05300513          	li	a0,83
    800026fc:	00002097          	auipc	ra,0x2
    80002700:	2d0080e7          	jalr	720(ra) # 800049cc <__putc>
            thread_join(myHandle);
    80002704:	0084b503          	ld	a0,8(s1)
    80002708:	00000097          	auipc	ra,0x0
    8000270c:	a8c080e7          	jalr	-1396(ra) # 80002194 <thread_join>
    80002710:	00893503          	ld	a0,8(s2)
    80002714:	00000097          	auipc	ra,0x0
    80002718:	a80080e7          	jalr	-1408(ra) # 80002194 <thread_join>
    8000271c:	0084b503          	ld	a0,8(s1)
    80002720:	00000097          	auipc	ra,0x0
    80002724:	a74080e7          	jalr	-1420(ra) # 80002194 <thread_join>
    thrB->join();
    thrA->join();
    thrB->join();
    char o='O';
    char c='M';
    c++;
    80002728:	04e00793          	li	a5,78
    8000272c:	fcf40723          	sb	a5,-50(s0)
    o++;
    80002730:	05000793          	li	a5,80
    80002734:	fcf407a3          	sb	a5,-49(s0)
    Thread* thrCobj = new Thread(bodyC, &o);
    80002738:	02000513          	li	a0,32
    8000273c:	00000097          	auipc	ra,0x0
    80002740:	e34080e7          	jalr	-460(ra) # 80002570 <_Znwm>
    80002744:	00050493          	mv	s1,a0
        {
    80002748:	01353023          	sd	s3,0(a0)
            this->body=body;
    8000274c:	00000917          	auipc	s2,0x0
    80002750:	c6c90913          	addi	s2,s2,-916 # 800023b8 <_Z5bodyCPv>
    80002754:	01253823          	sd	s2,16(a0)
            this->arg=arg;
    80002758:	fcf40613          	addi	a2,s0,-49
    8000275c:	00c53c23          	sd	a2,24(a0)
            return thread_create(&myHandle,body,arg);
    80002760:	00090593          	mv	a1,s2
    80002764:	00850513          	addi	a0,a0,8
    80002768:	00000097          	auipc	ra,0x0
    8000276c:	924080e7          	jalr	-1756(ra) # 8000208c <thread_create>
    thrCobj->start();
    thread_t thrC;
    thread_create(&thrC,bodyC,&c);
    80002770:	fce40613          	addi	a2,s0,-50
    80002774:	00090593          	mv	a1,s2
    80002778:	fc040513          	addi	a0,s0,-64
    8000277c:	00000097          	auipc	ra,0x0
    80002780:	910080e7          	jalr	-1776(ra) # 8000208c <thread_create>
    thread_join(thrC);
    80002784:	fc043503          	ld	a0,-64(s0)
    80002788:	00000097          	auipc	ra,0x0
    8000278c:	a0c080e7          	jalr	-1524(ra) # 80002194 <thread_join>
            thread_join(myHandle);
    80002790:	0084b503          	ld	a0,8(s1)
    80002794:	00000097          	auipc	ra,0x0
    80002798:	a00080e7          	jalr	-1536(ra) # 80002194 <thread_join>
    //idleAlive=0;
    thrCobj->join();
    delete thrCobj;
    8000279c:	00048a63          	beqz	s1,800027b0 <main+0x1f0>
    800027a0:	0004b783          	ld	a5,0(s1)
    800027a4:	0087b783          	ld	a5,8(a5)
    800027a8:	00048513          	mv	a0,s1
    800027ac:	000780e7          	jalr	a5

    __putc('E');
    800027b0:	04500513          	li	a0,69
    800027b4:	00002097          	auipc	ra,0x2
    800027b8:	218080e7          	jalr	536(ra) # 800049cc <__putc>
    while(1);
    800027bc:	0000006f          	j	800027bc <main+0x1fc>
    800027c0:	00050913          	mv	s2,a0
    semTest=new Semaphore(0);
    800027c4:	00048513          	mv	a0,s1
    800027c8:	00000097          	auipc	ra,0x0
    800027cc:	dd0080e7          	jalr	-560(ra) # 80002598 <_ZdlPv>
    800027d0:	00090513          	mv	a0,s2
    800027d4:	00007097          	auipc	ra,0x7
    800027d8:	fb4080e7          	jalr	-76(ra) # 80009788 <_Unwind_Resume>

00000000800027dc <_ZN6ThreadD1Ev>:
        virtual ~Thread (){
    800027dc:	ff010113          	addi	sp,sp,-16
    800027e0:	00813423          	sd	s0,8(sp)
    800027e4:	01010413          	addi	s0,sp,16
        }
    800027e8:	00813403          	ld	s0,8(sp)
    800027ec:	01010113          	addi	sp,sp,16
    800027f0:	00008067          	ret

00000000800027f4 <_ZN6Thread3runEv>:
        virtual void run () {}
    800027f4:	ff010113          	addi	sp,sp,-16
    800027f8:	00813423          	sd	s0,8(sp)
    800027fc:	01010413          	addi	s0,sp,16
    80002800:	00813403          	ld	s0,8(sp)
    80002804:	01010113          	addi	sp,sp,16
    80002808:	00008067          	ret

000000008000280c <_ZN9SemaphoreD1Ev>:
        virtual ~Semaphore (){
    8000280c:	ff010113          	addi	sp,sp,-16
    80002810:	00113423          	sd	ra,8(sp)
    80002814:	00813023          	sd	s0,0(sp)
    80002818:	01010413          	addi	s0,sp,16
    8000281c:	00003797          	auipc	a5,0x3
    80002820:	dd478793          	addi	a5,a5,-556 # 800055f0 <_ZTV9Semaphore+0x10>
    80002824:	00f53023          	sd	a5,0(a0)
            sem_close(myHandle);
    80002828:	00853503          	ld	a0,8(a0)
    8000282c:	00000097          	auipc	ra,0x0
    80002830:	9dc080e7          	jalr	-1572(ra) # 80002208 <sem_close>
        }
    80002834:	00813083          	ld	ra,8(sp)
    80002838:	00013403          	ld	s0,0(sp)
    8000283c:	01010113          	addi	sp,sp,16
    80002840:	00008067          	ret

0000000080002844 <_ZN9SemaphoreD0Ev>:
        virtual ~Semaphore (){
    80002844:	fe010113          	addi	sp,sp,-32
    80002848:	00113c23          	sd	ra,24(sp)
    8000284c:	00813823          	sd	s0,16(sp)
    80002850:	00913423          	sd	s1,8(sp)
    80002854:	02010413          	addi	s0,sp,32
    80002858:	00050493          	mv	s1,a0
    8000285c:	00003797          	auipc	a5,0x3
    80002860:	d9478793          	addi	a5,a5,-620 # 800055f0 <_ZTV9Semaphore+0x10>
    80002864:	00f53023          	sd	a5,0(a0)
            sem_close(myHandle);
    80002868:	00853503          	ld	a0,8(a0)
    8000286c:	00000097          	auipc	ra,0x0
    80002870:	99c080e7          	jalr	-1636(ra) # 80002208 <sem_close>
        }
    80002874:	00048513          	mv	a0,s1
    80002878:	00000097          	auipc	ra,0x0
    8000287c:	d20080e7          	jalr	-736(ra) # 80002598 <_ZdlPv>
    80002880:	01813083          	ld	ra,24(sp)
    80002884:	01013403          	ld	s0,16(sp)
    80002888:	00813483          	ld	s1,8(sp)
    8000288c:	02010113          	addi	sp,sp,32
    80002890:	00008067          	ret

0000000080002894 <_ZN6ThreadD0Ev>:
        virtual ~Thread (){
    80002894:	ff010113          	addi	sp,sp,-16
    80002898:	00113423          	sd	ra,8(sp)
    8000289c:	00813023          	sd	s0,0(sp)
    800028a0:	01010413          	addi	s0,sp,16
        }
    800028a4:	00000097          	auipc	ra,0x0
    800028a8:	cf4080e7          	jalr	-780(ra) # 80002598 <_ZdlPv>
    800028ac:	00813083          	ld	ra,8(sp)
    800028b0:	00013403          	ld	s0,0(sp)
    800028b4:	01010113          	addi	sp,sp,16
    800028b8:	00008067          	ret

00000000800028bc <_Z11printstringPKc>:
//

#include "../h/strings.h"

void printstring(const char* string)
{
    800028bc:	fe010113          	addi	sp,sp,-32
    800028c0:	00113c23          	sd	ra,24(sp)
    800028c4:	00813823          	sd	s0,16(sp)
    800028c8:	00913423          	sd	s1,8(sp)
    800028cc:	01213023          	sd	s2,0(sp)
    800028d0:	02010413          	addi	s0,sp,32
    800028d4:	00050913          	mv	s2,a0
    int i=0;
    800028d8:	00000493          	li	s1,0
    while (string[i]){
    800028dc:	009907b3          	add	a5,s2,s1
    800028e0:	0007c503          	lbu	a0,0(a5)
    800028e4:	00050a63          	beqz	a0,800028f8 <_Z11printstringPKc+0x3c>
        __putc(string[i++]);
    800028e8:	0014849b          	addiw	s1,s1,1
    800028ec:	00002097          	auipc	ra,0x2
    800028f0:	0e0080e7          	jalr	224(ra) # 800049cc <__putc>
    while (string[i]){
    800028f4:	fe9ff06f          	j	800028dc <_Z11printstringPKc+0x20>
    }
}
    800028f8:	01813083          	ld	ra,24(sp)
    800028fc:	01013403          	ld	s0,16(sp)
    80002900:	00813483          	ld	s1,8(sp)
    80002904:	00013903          	ld	s2,0(sp)
    80002908:	02010113          	addi	sp,sp,32
    8000290c:	00008067          	ret

0000000080002910 <start>:
    80002910:	ff010113          	addi	sp,sp,-16
    80002914:	00813423          	sd	s0,8(sp)
    80002918:	01010413          	addi	s0,sp,16
    8000291c:	300027f3          	csrr	a5,mstatus
    80002920:	ffffe737          	lui	a4,0xffffe
    80002924:	7ff70713          	addi	a4,a4,2047 # ffffffffffffe7ff <end+0xffffffff7fff4edf>
    80002928:	00e7f7b3          	and	a5,a5,a4
    8000292c:	00001737          	lui	a4,0x1
    80002930:	80070713          	addi	a4,a4,-2048 # 800 <_entry-0x7ffff800>
    80002934:	00e7e7b3          	or	a5,a5,a4
    80002938:	30079073          	csrw	mstatus,a5
    8000293c:	00000797          	auipc	a5,0x0
    80002940:	16078793          	addi	a5,a5,352 # 80002a9c <system_main>
    80002944:	34179073          	csrw	mepc,a5
    80002948:	00000793          	li	a5,0
    8000294c:	18079073          	csrw	satp,a5
    80002950:	000107b7          	lui	a5,0x10
    80002954:	fff78793          	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    80002958:	30279073          	csrw	medeleg,a5
    8000295c:	30379073          	csrw	mideleg,a5
    80002960:	104027f3          	csrr	a5,sie
    80002964:	2227e793          	ori	a5,a5,546
    80002968:	10479073          	csrw	sie,a5
    8000296c:	fff00793          	li	a5,-1
    80002970:	00a7d793          	srli	a5,a5,0xa
    80002974:	3b079073          	csrw	pmpaddr0,a5
    80002978:	00f00793          	li	a5,15
    8000297c:	3a079073          	csrw	pmpcfg0,a5
    80002980:	f14027f3          	csrr	a5,mhartid
    80002984:	0200c737          	lui	a4,0x200c
    80002988:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    8000298c:	0007869b          	sext.w	a3,a5
    80002990:	00269713          	slli	a4,a3,0x2
    80002994:	000f4637          	lui	a2,0xf4
    80002998:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    8000299c:	00d70733          	add	a4,a4,a3
    800029a0:	0037979b          	slliw	a5,a5,0x3
    800029a4:	020046b7          	lui	a3,0x2004
    800029a8:	00d787b3          	add	a5,a5,a3
    800029ac:	00c585b3          	add	a1,a1,a2
    800029b0:	00371693          	slli	a3,a4,0x3
    800029b4:	00006717          	auipc	a4,0x6
    800029b8:	d0c70713          	addi	a4,a4,-756 # 800086c0 <timer_scratch>
    800029bc:	00b7b023          	sd	a1,0(a5)
    800029c0:	00d70733          	add	a4,a4,a3
    800029c4:	00f73c23          	sd	a5,24(a4)
    800029c8:	02c73023          	sd	a2,32(a4)
    800029cc:	34071073          	csrw	mscratch,a4
    800029d0:	00000797          	auipc	a5,0x0
    800029d4:	6e078793          	addi	a5,a5,1760 # 800030b0 <timervec>
    800029d8:	30579073          	csrw	mtvec,a5
    800029dc:	300027f3          	csrr	a5,mstatus
    800029e0:	0087e793          	ori	a5,a5,8
    800029e4:	30079073          	csrw	mstatus,a5
    800029e8:	304027f3          	csrr	a5,mie
    800029ec:	0807e793          	ori	a5,a5,128
    800029f0:	30479073          	csrw	mie,a5
    800029f4:	f14027f3          	csrr	a5,mhartid
    800029f8:	0007879b          	sext.w	a5,a5
    800029fc:	00078213          	mv	tp,a5
    80002a00:	30200073          	mret
    80002a04:	00813403          	ld	s0,8(sp)
    80002a08:	01010113          	addi	sp,sp,16
    80002a0c:	00008067          	ret

0000000080002a10 <timerinit>:
    80002a10:	ff010113          	addi	sp,sp,-16
    80002a14:	00813423          	sd	s0,8(sp)
    80002a18:	01010413          	addi	s0,sp,16
    80002a1c:	f14027f3          	csrr	a5,mhartid
    80002a20:	0200c737          	lui	a4,0x200c
    80002a24:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    80002a28:	0007869b          	sext.w	a3,a5
    80002a2c:	00269713          	slli	a4,a3,0x2
    80002a30:	000f4637          	lui	a2,0xf4
    80002a34:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    80002a38:	00d70733          	add	a4,a4,a3
    80002a3c:	0037979b          	slliw	a5,a5,0x3
    80002a40:	020046b7          	lui	a3,0x2004
    80002a44:	00d787b3          	add	a5,a5,a3
    80002a48:	00c585b3          	add	a1,a1,a2
    80002a4c:	00371693          	slli	a3,a4,0x3
    80002a50:	00006717          	auipc	a4,0x6
    80002a54:	c7070713          	addi	a4,a4,-912 # 800086c0 <timer_scratch>
    80002a58:	00b7b023          	sd	a1,0(a5)
    80002a5c:	00d70733          	add	a4,a4,a3
    80002a60:	00f73c23          	sd	a5,24(a4)
    80002a64:	02c73023          	sd	a2,32(a4)
    80002a68:	34071073          	csrw	mscratch,a4
    80002a6c:	00000797          	auipc	a5,0x0
    80002a70:	64478793          	addi	a5,a5,1604 # 800030b0 <timervec>
    80002a74:	30579073          	csrw	mtvec,a5
    80002a78:	300027f3          	csrr	a5,mstatus
    80002a7c:	0087e793          	ori	a5,a5,8
    80002a80:	30079073          	csrw	mstatus,a5
    80002a84:	304027f3          	csrr	a5,mie
    80002a88:	0807e793          	ori	a5,a5,128
    80002a8c:	30479073          	csrw	mie,a5
    80002a90:	00813403          	ld	s0,8(sp)
    80002a94:	01010113          	addi	sp,sp,16
    80002a98:	00008067          	ret

0000000080002a9c <system_main>:
    80002a9c:	fe010113          	addi	sp,sp,-32
    80002aa0:	00813823          	sd	s0,16(sp)
    80002aa4:	00913423          	sd	s1,8(sp)
    80002aa8:	00113c23          	sd	ra,24(sp)
    80002aac:	02010413          	addi	s0,sp,32
    80002ab0:	00000097          	auipc	ra,0x0
    80002ab4:	0c4080e7          	jalr	196(ra) # 80002b74 <cpuid>
    80002ab8:	00003497          	auipc	s1,0x3
    80002abc:	bb448493          	addi	s1,s1,-1100 # 8000566c <started>
    80002ac0:	02050263          	beqz	a0,80002ae4 <system_main+0x48>
    80002ac4:	0004a783          	lw	a5,0(s1)
    80002ac8:	0007879b          	sext.w	a5,a5
    80002acc:	fe078ce3          	beqz	a5,80002ac4 <system_main+0x28>
    80002ad0:	0ff0000f          	fence
    80002ad4:	00002517          	auipc	a0,0x2
    80002ad8:	64450513          	addi	a0,a0,1604 # 80005118 <CONSOLE_STATUS+0x100>
    80002adc:	00001097          	auipc	ra,0x1
    80002ae0:	a70080e7          	jalr	-1424(ra) # 8000354c <panic>
    80002ae4:	00001097          	auipc	ra,0x1
    80002ae8:	9c4080e7          	jalr	-1596(ra) # 800034a8 <consoleinit>
    80002aec:	00001097          	auipc	ra,0x1
    80002af0:	150080e7          	jalr	336(ra) # 80003c3c <printfinit>
    80002af4:	00002517          	auipc	a0,0x2
    80002af8:	70450513          	addi	a0,a0,1796 # 800051f8 <CONSOLE_STATUS+0x1e0>
    80002afc:	00001097          	auipc	ra,0x1
    80002b00:	aac080e7          	jalr	-1364(ra) # 800035a8 <__printf>
    80002b04:	00002517          	auipc	a0,0x2
    80002b08:	5e450513          	addi	a0,a0,1508 # 800050e8 <CONSOLE_STATUS+0xd0>
    80002b0c:	00001097          	auipc	ra,0x1
    80002b10:	a9c080e7          	jalr	-1380(ra) # 800035a8 <__printf>
    80002b14:	00002517          	auipc	a0,0x2
    80002b18:	6e450513          	addi	a0,a0,1764 # 800051f8 <CONSOLE_STATUS+0x1e0>
    80002b1c:	00001097          	auipc	ra,0x1
    80002b20:	a8c080e7          	jalr	-1396(ra) # 800035a8 <__printf>
    80002b24:	00001097          	auipc	ra,0x1
    80002b28:	4a4080e7          	jalr	1188(ra) # 80003fc8 <kinit>
    80002b2c:	00000097          	auipc	ra,0x0
    80002b30:	148080e7          	jalr	328(ra) # 80002c74 <trapinit>
    80002b34:	00000097          	auipc	ra,0x0
    80002b38:	16c080e7          	jalr	364(ra) # 80002ca0 <trapinithart>
    80002b3c:	00000097          	auipc	ra,0x0
    80002b40:	5b4080e7          	jalr	1460(ra) # 800030f0 <plicinit>
    80002b44:	00000097          	auipc	ra,0x0
    80002b48:	5d4080e7          	jalr	1492(ra) # 80003118 <plicinithart>
    80002b4c:	00000097          	auipc	ra,0x0
    80002b50:	078080e7          	jalr	120(ra) # 80002bc4 <userinit>
    80002b54:	0ff0000f          	fence
    80002b58:	00100793          	li	a5,1
    80002b5c:	00002517          	auipc	a0,0x2
    80002b60:	5a450513          	addi	a0,a0,1444 # 80005100 <CONSOLE_STATUS+0xe8>
    80002b64:	00f4a023          	sw	a5,0(s1)
    80002b68:	00001097          	auipc	ra,0x1
    80002b6c:	a40080e7          	jalr	-1472(ra) # 800035a8 <__printf>
    80002b70:	0000006f          	j	80002b70 <system_main+0xd4>

0000000080002b74 <cpuid>:
    80002b74:	ff010113          	addi	sp,sp,-16
    80002b78:	00813423          	sd	s0,8(sp)
    80002b7c:	01010413          	addi	s0,sp,16
    80002b80:	00020513          	mv	a0,tp
    80002b84:	00813403          	ld	s0,8(sp)
    80002b88:	0005051b          	sext.w	a0,a0
    80002b8c:	01010113          	addi	sp,sp,16
    80002b90:	00008067          	ret

0000000080002b94 <mycpu>:
    80002b94:	ff010113          	addi	sp,sp,-16
    80002b98:	00813423          	sd	s0,8(sp)
    80002b9c:	01010413          	addi	s0,sp,16
    80002ba0:	00020793          	mv	a5,tp
    80002ba4:	00813403          	ld	s0,8(sp)
    80002ba8:	0007879b          	sext.w	a5,a5
    80002bac:	00779793          	slli	a5,a5,0x7
    80002bb0:	00007517          	auipc	a0,0x7
    80002bb4:	b4050513          	addi	a0,a0,-1216 # 800096f0 <cpus>
    80002bb8:	00f50533          	add	a0,a0,a5
    80002bbc:	01010113          	addi	sp,sp,16
    80002bc0:	00008067          	ret

0000000080002bc4 <userinit>:
    80002bc4:	ff010113          	addi	sp,sp,-16
    80002bc8:	00813423          	sd	s0,8(sp)
    80002bcc:	01010413          	addi	s0,sp,16
    80002bd0:	00813403          	ld	s0,8(sp)
    80002bd4:	01010113          	addi	sp,sp,16
    80002bd8:	00000317          	auipc	t1,0x0
    80002bdc:	9e830067          	jr	-1560(t1) # 800025c0 <main>

0000000080002be0 <either_copyout>:
    80002be0:	ff010113          	addi	sp,sp,-16
    80002be4:	00813023          	sd	s0,0(sp)
    80002be8:	00113423          	sd	ra,8(sp)
    80002bec:	01010413          	addi	s0,sp,16
    80002bf0:	02051663          	bnez	a0,80002c1c <either_copyout+0x3c>
    80002bf4:	00058513          	mv	a0,a1
    80002bf8:	00060593          	mv	a1,a2
    80002bfc:	0006861b          	sext.w	a2,a3
    80002c00:	00002097          	auipc	ra,0x2
    80002c04:	c54080e7          	jalr	-940(ra) # 80004854 <__memmove>
    80002c08:	00813083          	ld	ra,8(sp)
    80002c0c:	00013403          	ld	s0,0(sp)
    80002c10:	00000513          	li	a0,0
    80002c14:	01010113          	addi	sp,sp,16
    80002c18:	00008067          	ret
    80002c1c:	00002517          	auipc	a0,0x2
    80002c20:	52450513          	addi	a0,a0,1316 # 80005140 <CONSOLE_STATUS+0x128>
    80002c24:	00001097          	auipc	ra,0x1
    80002c28:	928080e7          	jalr	-1752(ra) # 8000354c <panic>

0000000080002c2c <either_copyin>:
    80002c2c:	ff010113          	addi	sp,sp,-16
    80002c30:	00813023          	sd	s0,0(sp)
    80002c34:	00113423          	sd	ra,8(sp)
    80002c38:	01010413          	addi	s0,sp,16
    80002c3c:	02059463          	bnez	a1,80002c64 <either_copyin+0x38>
    80002c40:	00060593          	mv	a1,a2
    80002c44:	0006861b          	sext.w	a2,a3
    80002c48:	00002097          	auipc	ra,0x2
    80002c4c:	c0c080e7          	jalr	-1012(ra) # 80004854 <__memmove>
    80002c50:	00813083          	ld	ra,8(sp)
    80002c54:	00013403          	ld	s0,0(sp)
    80002c58:	00000513          	li	a0,0
    80002c5c:	01010113          	addi	sp,sp,16
    80002c60:	00008067          	ret
    80002c64:	00002517          	auipc	a0,0x2
    80002c68:	50450513          	addi	a0,a0,1284 # 80005168 <CONSOLE_STATUS+0x150>
    80002c6c:	00001097          	auipc	ra,0x1
    80002c70:	8e0080e7          	jalr	-1824(ra) # 8000354c <panic>

0000000080002c74 <trapinit>:
    80002c74:	ff010113          	addi	sp,sp,-16
    80002c78:	00813423          	sd	s0,8(sp)
    80002c7c:	01010413          	addi	s0,sp,16
    80002c80:	00813403          	ld	s0,8(sp)
    80002c84:	00002597          	auipc	a1,0x2
    80002c88:	50c58593          	addi	a1,a1,1292 # 80005190 <CONSOLE_STATUS+0x178>
    80002c8c:	00007517          	auipc	a0,0x7
    80002c90:	ae450513          	addi	a0,a0,-1308 # 80009770 <tickslock>
    80002c94:	01010113          	addi	sp,sp,16
    80002c98:	00001317          	auipc	t1,0x1
    80002c9c:	5c030067          	jr	1472(t1) # 80004258 <initlock>

0000000080002ca0 <trapinithart>:
    80002ca0:	ff010113          	addi	sp,sp,-16
    80002ca4:	00813423          	sd	s0,8(sp)
    80002ca8:	01010413          	addi	s0,sp,16
    80002cac:	00000797          	auipc	a5,0x0
    80002cb0:	2f478793          	addi	a5,a5,756 # 80002fa0 <kernelvec>
    80002cb4:	10579073          	csrw	stvec,a5
    80002cb8:	00813403          	ld	s0,8(sp)
    80002cbc:	01010113          	addi	sp,sp,16
    80002cc0:	00008067          	ret

0000000080002cc4 <usertrap>:
    80002cc4:	ff010113          	addi	sp,sp,-16
    80002cc8:	00813423          	sd	s0,8(sp)
    80002ccc:	01010413          	addi	s0,sp,16
    80002cd0:	00813403          	ld	s0,8(sp)
    80002cd4:	01010113          	addi	sp,sp,16
    80002cd8:	00008067          	ret

0000000080002cdc <usertrapret>:
    80002cdc:	ff010113          	addi	sp,sp,-16
    80002ce0:	00813423          	sd	s0,8(sp)
    80002ce4:	01010413          	addi	s0,sp,16
    80002ce8:	00813403          	ld	s0,8(sp)
    80002cec:	01010113          	addi	sp,sp,16
    80002cf0:	00008067          	ret

0000000080002cf4 <kerneltrap>:
    80002cf4:	fe010113          	addi	sp,sp,-32
    80002cf8:	00813823          	sd	s0,16(sp)
    80002cfc:	00113c23          	sd	ra,24(sp)
    80002d00:	00913423          	sd	s1,8(sp)
    80002d04:	02010413          	addi	s0,sp,32
    80002d08:	142025f3          	csrr	a1,scause
    80002d0c:	100027f3          	csrr	a5,sstatus
    80002d10:	0027f793          	andi	a5,a5,2
    80002d14:	10079c63          	bnez	a5,80002e2c <kerneltrap+0x138>
    80002d18:	142027f3          	csrr	a5,scause
    80002d1c:	0207ce63          	bltz	a5,80002d58 <kerneltrap+0x64>
    80002d20:	00002517          	auipc	a0,0x2
    80002d24:	4b850513          	addi	a0,a0,1208 # 800051d8 <CONSOLE_STATUS+0x1c0>
    80002d28:	00001097          	auipc	ra,0x1
    80002d2c:	880080e7          	jalr	-1920(ra) # 800035a8 <__printf>
    80002d30:	141025f3          	csrr	a1,sepc
    80002d34:	14302673          	csrr	a2,stval
    80002d38:	00002517          	auipc	a0,0x2
    80002d3c:	4b050513          	addi	a0,a0,1200 # 800051e8 <CONSOLE_STATUS+0x1d0>
    80002d40:	00001097          	auipc	ra,0x1
    80002d44:	868080e7          	jalr	-1944(ra) # 800035a8 <__printf>
    80002d48:	00002517          	auipc	a0,0x2
    80002d4c:	4b850513          	addi	a0,a0,1208 # 80005200 <CONSOLE_STATUS+0x1e8>
    80002d50:	00000097          	auipc	ra,0x0
    80002d54:	7fc080e7          	jalr	2044(ra) # 8000354c <panic>
    80002d58:	0ff7f713          	andi	a4,a5,255
    80002d5c:	00900693          	li	a3,9
    80002d60:	04d70063          	beq	a4,a3,80002da0 <kerneltrap+0xac>
    80002d64:	fff00713          	li	a4,-1
    80002d68:	03f71713          	slli	a4,a4,0x3f
    80002d6c:	00170713          	addi	a4,a4,1
    80002d70:	fae798e3          	bne	a5,a4,80002d20 <kerneltrap+0x2c>
    80002d74:	00000097          	auipc	ra,0x0
    80002d78:	e00080e7          	jalr	-512(ra) # 80002b74 <cpuid>
    80002d7c:	06050663          	beqz	a0,80002de8 <kerneltrap+0xf4>
    80002d80:	144027f3          	csrr	a5,sip
    80002d84:	ffd7f793          	andi	a5,a5,-3
    80002d88:	14479073          	csrw	sip,a5
    80002d8c:	01813083          	ld	ra,24(sp)
    80002d90:	01013403          	ld	s0,16(sp)
    80002d94:	00813483          	ld	s1,8(sp)
    80002d98:	02010113          	addi	sp,sp,32
    80002d9c:	00008067          	ret
    80002da0:	00000097          	auipc	ra,0x0
    80002da4:	3c4080e7          	jalr	964(ra) # 80003164 <plic_claim>
    80002da8:	00a00793          	li	a5,10
    80002dac:	00050493          	mv	s1,a0
    80002db0:	06f50863          	beq	a0,a5,80002e20 <kerneltrap+0x12c>
    80002db4:	fc050ce3          	beqz	a0,80002d8c <kerneltrap+0x98>
    80002db8:	00050593          	mv	a1,a0
    80002dbc:	00002517          	auipc	a0,0x2
    80002dc0:	3fc50513          	addi	a0,a0,1020 # 800051b8 <CONSOLE_STATUS+0x1a0>
    80002dc4:	00000097          	auipc	ra,0x0
    80002dc8:	7e4080e7          	jalr	2020(ra) # 800035a8 <__printf>
    80002dcc:	01013403          	ld	s0,16(sp)
    80002dd0:	01813083          	ld	ra,24(sp)
    80002dd4:	00048513          	mv	a0,s1
    80002dd8:	00813483          	ld	s1,8(sp)
    80002ddc:	02010113          	addi	sp,sp,32
    80002de0:	00000317          	auipc	t1,0x0
    80002de4:	3bc30067          	jr	956(t1) # 8000319c <plic_complete>
    80002de8:	00007517          	auipc	a0,0x7
    80002dec:	98850513          	addi	a0,a0,-1656 # 80009770 <tickslock>
    80002df0:	00001097          	auipc	ra,0x1
    80002df4:	48c080e7          	jalr	1164(ra) # 8000427c <acquire>
    80002df8:	00003717          	auipc	a4,0x3
    80002dfc:	87870713          	addi	a4,a4,-1928 # 80005670 <ticks>
    80002e00:	00072783          	lw	a5,0(a4)
    80002e04:	00007517          	auipc	a0,0x7
    80002e08:	96c50513          	addi	a0,a0,-1684 # 80009770 <tickslock>
    80002e0c:	0017879b          	addiw	a5,a5,1
    80002e10:	00f72023          	sw	a5,0(a4)
    80002e14:	00001097          	auipc	ra,0x1
    80002e18:	534080e7          	jalr	1332(ra) # 80004348 <release>
    80002e1c:	f65ff06f          	j	80002d80 <kerneltrap+0x8c>
    80002e20:	00001097          	auipc	ra,0x1
    80002e24:	090080e7          	jalr	144(ra) # 80003eb0 <uartintr>
    80002e28:	fa5ff06f          	j	80002dcc <kerneltrap+0xd8>
    80002e2c:	00002517          	auipc	a0,0x2
    80002e30:	36c50513          	addi	a0,a0,876 # 80005198 <CONSOLE_STATUS+0x180>
    80002e34:	00000097          	auipc	ra,0x0
    80002e38:	718080e7          	jalr	1816(ra) # 8000354c <panic>

0000000080002e3c <clockintr>:
    80002e3c:	fe010113          	addi	sp,sp,-32
    80002e40:	00813823          	sd	s0,16(sp)
    80002e44:	00913423          	sd	s1,8(sp)
    80002e48:	00113c23          	sd	ra,24(sp)
    80002e4c:	02010413          	addi	s0,sp,32
    80002e50:	00007497          	auipc	s1,0x7
    80002e54:	92048493          	addi	s1,s1,-1760 # 80009770 <tickslock>
    80002e58:	00048513          	mv	a0,s1
    80002e5c:	00001097          	auipc	ra,0x1
    80002e60:	420080e7          	jalr	1056(ra) # 8000427c <acquire>
    80002e64:	00003717          	auipc	a4,0x3
    80002e68:	80c70713          	addi	a4,a4,-2036 # 80005670 <ticks>
    80002e6c:	00072783          	lw	a5,0(a4)
    80002e70:	01013403          	ld	s0,16(sp)
    80002e74:	01813083          	ld	ra,24(sp)
    80002e78:	00048513          	mv	a0,s1
    80002e7c:	0017879b          	addiw	a5,a5,1
    80002e80:	00813483          	ld	s1,8(sp)
    80002e84:	00f72023          	sw	a5,0(a4)
    80002e88:	02010113          	addi	sp,sp,32
    80002e8c:	00001317          	auipc	t1,0x1
    80002e90:	4bc30067          	jr	1212(t1) # 80004348 <release>

0000000080002e94 <devintr>:
    80002e94:	142027f3          	csrr	a5,scause
    80002e98:	00000513          	li	a0,0
    80002e9c:	0007c463          	bltz	a5,80002ea4 <devintr+0x10>
    80002ea0:	00008067          	ret
    80002ea4:	fe010113          	addi	sp,sp,-32
    80002ea8:	00813823          	sd	s0,16(sp)
    80002eac:	00113c23          	sd	ra,24(sp)
    80002eb0:	00913423          	sd	s1,8(sp)
    80002eb4:	02010413          	addi	s0,sp,32
    80002eb8:	0ff7f713          	andi	a4,a5,255
    80002ebc:	00900693          	li	a3,9
    80002ec0:	04d70c63          	beq	a4,a3,80002f18 <devintr+0x84>
    80002ec4:	fff00713          	li	a4,-1
    80002ec8:	03f71713          	slli	a4,a4,0x3f
    80002ecc:	00170713          	addi	a4,a4,1
    80002ed0:	00e78c63          	beq	a5,a4,80002ee8 <devintr+0x54>
    80002ed4:	01813083          	ld	ra,24(sp)
    80002ed8:	01013403          	ld	s0,16(sp)
    80002edc:	00813483          	ld	s1,8(sp)
    80002ee0:	02010113          	addi	sp,sp,32
    80002ee4:	00008067          	ret
    80002ee8:	00000097          	auipc	ra,0x0
    80002eec:	c8c080e7          	jalr	-884(ra) # 80002b74 <cpuid>
    80002ef0:	06050663          	beqz	a0,80002f5c <devintr+0xc8>
    80002ef4:	144027f3          	csrr	a5,sip
    80002ef8:	ffd7f793          	andi	a5,a5,-3
    80002efc:	14479073          	csrw	sip,a5
    80002f00:	01813083          	ld	ra,24(sp)
    80002f04:	01013403          	ld	s0,16(sp)
    80002f08:	00813483          	ld	s1,8(sp)
    80002f0c:	00200513          	li	a0,2
    80002f10:	02010113          	addi	sp,sp,32
    80002f14:	00008067          	ret
    80002f18:	00000097          	auipc	ra,0x0
    80002f1c:	24c080e7          	jalr	588(ra) # 80003164 <plic_claim>
    80002f20:	00a00793          	li	a5,10
    80002f24:	00050493          	mv	s1,a0
    80002f28:	06f50663          	beq	a0,a5,80002f94 <devintr+0x100>
    80002f2c:	00100513          	li	a0,1
    80002f30:	fa0482e3          	beqz	s1,80002ed4 <devintr+0x40>
    80002f34:	00048593          	mv	a1,s1
    80002f38:	00002517          	auipc	a0,0x2
    80002f3c:	28050513          	addi	a0,a0,640 # 800051b8 <CONSOLE_STATUS+0x1a0>
    80002f40:	00000097          	auipc	ra,0x0
    80002f44:	668080e7          	jalr	1640(ra) # 800035a8 <__printf>
    80002f48:	00048513          	mv	a0,s1
    80002f4c:	00000097          	auipc	ra,0x0
    80002f50:	250080e7          	jalr	592(ra) # 8000319c <plic_complete>
    80002f54:	00100513          	li	a0,1
    80002f58:	f7dff06f          	j	80002ed4 <devintr+0x40>
    80002f5c:	00007517          	auipc	a0,0x7
    80002f60:	81450513          	addi	a0,a0,-2028 # 80009770 <tickslock>
    80002f64:	00001097          	auipc	ra,0x1
    80002f68:	318080e7          	jalr	792(ra) # 8000427c <acquire>
    80002f6c:	00002717          	auipc	a4,0x2
    80002f70:	70470713          	addi	a4,a4,1796 # 80005670 <ticks>
    80002f74:	00072783          	lw	a5,0(a4)
    80002f78:	00006517          	auipc	a0,0x6
    80002f7c:	7f850513          	addi	a0,a0,2040 # 80009770 <tickslock>
    80002f80:	0017879b          	addiw	a5,a5,1
    80002f84:	00f72023          	sw	a5,0(a4)
    80002f88:	00001097          	auipc	ra,0x1
    80002f8c:	3c0080e7          	jalr	960(ra) # 80004348 <release>
    80002f90:	f65ff06f          	j	80002ef4 <devintr+0x60>
    80002f94:	00001097          	auipc	ra,0x1
    80002f98:	f1c080e7          	jalr	-228(ra) # 80003eb0 <uartintr>
    80002f9c:	fadff06f          	j	80002f48 <devintr+0xb4>

0000000080002fa0 <kernelvec>:
    80002fa0:	f0010113          	addi	sp,sp,-256
    80002fa4:	00113023          	sd	ra,0(sp)
    80002fa8:	00213423          	sd	sp,8(sp)
    80002fac:	00313823          	sd	gp,16(sp)
    80002fb0:	00413c23          	sd	tp,24(sp)
    80002fb4:	02513023          	sd	t0,32(sp)
    80002fb8:	02613423          	sd	t1,40(sp)
    80002fbc:	02713823          	sd	t2,48(sp)
    80002fc0:	02813c23          	sd	s0,56(sp)
    80002fc4:	04913023          	sd	s1,64(sp)
    80002fc8:	04a13423          	sd	a0,72(sp)
    80002fcc:	04b13823          	sd	a1,80(sp)
    80002fd0:	04c13c23          	sd	a2,88(sp)
    80002fd4:	06d13023          	sd	a3,96(sp)
    80002fd8:	06e13423          	sd	a4,104(sp)
    80002fdc:	06f13823          	sd	a5,112(sp)
    80002fe0:	07013c23          	sd	a6,120(sp)
    80002fe4:	09113023          	sd	a7,128(sp)
    80002fe8:	09213423          	sd	s2,136(sp)
    80002fec:	09313823          	sd	s3,144(sp)
    80002ff0:	09413c23          	sd	s4,152(sp)
    80002ff4:	0b513023          	sd	s5,160(sp)
    80002ff8:	0b613423          	sd	s6,168(sp)
    80002ffc:	0b713823          	sd	s7,176(sp)
    80003000:	0b813c23          	sd	s8,184(sp)
    80003004:	0d913023          	sd	s9,192(sp)
    80003008:	0da13423          	sd	s10,200(sp)
    8000300c:	0db13823          	sd	s11,208(sp)
    80003010:	0dc13c23          	sd	t3,216(sp)
    80003014:	0fd13023          	sd	t4,224(sp)
    80003018:	0fe13423          	sd	t5,232(sp)
    8000301c:	0ff13823          	sd	t6,240(sp)
    80003020:	cd5ff0ef          	jal	ra,80002cf4 <kerneltrap>
    80003024:	00013083          	ld	ra,0(sp)
    80003028:	00813103          	ld	sp,8(sp)
    8000302c:	01013183          	ld	gp,16(sp)
    80003030:	02013283          	ld	t0,32(sp)
    80003034:	02813303          	ld	t1,40(sp)
    80003038:	03013383          	ld	t2,48(sp)
    8000303c:	03813403          	ld	s0,56(sp)
    80003040:	04013483          	ld	s1,64(sp)
    80003044:	04813503          	ld	a0,72(sp)
    80003048:	05013583          	ld	a1,80(sp)
    8000304c:	05813603          	ld	a2,88(sp)
    80003050:	06013683          	ld	a3,96(sp)
    80003054:	06813703          	ld	a4,104(sp)
    80003058:	07013783          	ld	a5,112(sp)
    8000305c:	07813803          	ld	a6,120(sp)
    80003060:	08013883          	ld	a7,128(sp)
    80003064:	08813903          	ld	s2,136(sp)
    80003068:	09013983          	ld	s3,144(sp)
    8000306c:	09813a03          	ld	s4,152(sp)
    80003070:	0a013a83          	ld	s5,160(sp)
    80003074:	0a813b03          	ld	s6,168(sp)
    80003078:	0b013b83          	ld	s7,176(sp)
    8000307c:	0b813c03          	ld	s8,184(sp)
    80003080:	0c013c83          	ld	s9,192(sp)
    80003084:	0c813d03          	ld	s10,200(sp)
    80003088:	0d013d83          	ld	s11,208(sp)
    8000308c:	0d813e03          	ld	t3,216(sp)
    80003090:	0e013e83          	ld	t4,224(sp)
    80003094:	0e813f03          	ld	t5,232(sp)
    80003098:	0f013f83          	ld	t6,240(sp)
    8000309c:	10010113          	addi	sp,sp,256
    800030a0:	10200073          	sret
    800030a4:	00000013          	nop
    800030a8:	00000013          	nop
    800030ac:	00000013          	nop

00000000800030b0 <timervec>:
    800030b0:	34051573          	csrrw	a0,mscratch,a0
    800030b4:	00b53023          	sd	a1,0(a0)
    800030b8:	00c53423          	sd	a2,8(a0)
    800030bc:	00d53823          	sd	a3,16(a0)
    800030c0:	01853583          	ld	a1,24(a0)
    800030c4:	02053603          	ld	a2,32(a0)
    800030c8:	0005b683          	ld	a3,0(a1)
    800030cc:	00c686b3          	add	a3,a3,a2
    800030d0:	00d5b023          	sd	a3,0(a1)
    800030d4:	00200593          	li	a1,2
    800030d8:	14459073          	csrw	sip,a1
    800030dc:	01053683          	ld	a3,16(a0)
    800030e0:	00853603          	ld	a2,8(a0)
    800030e4:	00053583          	ld	a1,0(a0)
    800030e8:	34051573          	csrrw	a0,mscratch,a0
    800030ec:	30200073          	mret

00000000800030f0 <plicinit>:
    800030f0:	ff010113          	addi	sp,sp,-16
    800030f4:	00813423          	sd	s0,8(sp)
    800030f8:	01010413          	addi	s0,sp,16
    800030fc:	00813403          	ld	s0,8(sp)
    80003100:	0c0007b7          	lui	a5,0xc000
    80003104:	00100713          	li	a4,1
    80003108:	02e7a423          	sw	a4,40(a5) # c000028 <_entry-0x73ffffd8>
    8000310c:	00e7a223          	sw	a4,4(a5)
    80003110:	01010113          	addi	sp,sp,16
    80003114:	00008067          	ret

0000000080003118 <plicinithart>:
    80003118:	ff010113          	addi	sp,sp,-16
    8000311c:	00813023          	sd	s0,0(sp)
    80003120:	00113423          	sd	ra,8(sp)
    80003124:	01010413          	addi	s0,sp,16
    80003128:	00000097          	auipc	ra,0x0
    8000312c:	a4c080e7          	jalr	-1460(ra) # 80002b74 <cpuid>
    80003130:	0085171b          	slliw	a4,a0,0x8
    80003134:	0c0027b7          	lui	a5,0xc002
    80003138:	00e787b3          	add	a5,a5,a4
    8000313c:	40200713          	li	a4,1026
    80003140:	08e7a023          	sw	a4,128(a5) # c002080 <_entry-0x73ffdf80>
    80003144:	00813083          	ld	ra,8(sp)
    80003148:	00013403          	ld	s0,0(sp)
    8000314c:	00d5151b          	slliw	a0,a0,0xd
    80003150:	0c2017b7          	lui	a5,0xc201
    80003154:	00a78533          	add	a0,a5,a0
    80003158:	00052023          	sw	zero,0(a0)
    8000315c:	01010113          	addi	sp,sp,16
    80003160:	00008067          	ret

0000000080003164 <plic_claim>:
    80003164:	ff010113          	addi	sp,sp,-16
    80003168:	00813023          	sd	s0,0(sp)
    8000316c:	00113423          	sd	ra,8(sp)
    80003170:	01010413          	addi	s0,sp,16
    80003174:	00000097          	auipc	ra,0x0
    80003178:	a00080e7          	jalr	-1536(ra) # 80002b74 <cpuid>
    8000317c:	00813083          	ld	ra,8(sp)
    80003180:	00013403          	ld	s0,0(sp)
    80003184:	00d5151b          	slliw	a0,a0,0xd
    80003188:	0c2017b7          	lui	a5,0xc201
    8000318c:	00a78533          	add	a0,a5,a0
    80003190:	00452503          	lw	a0,4(a0)
    80003194:	01010113          	addi	sp,sp,16
    80003198:	00008067          	ret

000000008000319c <plic_complete>:
    8000319c:	fe010113          	addi	sp,sp,-32
    800031a0:	00813823          	sd	s0,16(sp)
    800031a4:	00913423          	sd	s1,8(sp)
    800031a8:	00113c23          	sd	ra,24(sp)
    800031ac:	02010413          	addi	s0,sp,32
    800031b0:	00050493          	mv	s1,a0
    800031b4:	00000097          	auipc	ra,0x0
    800031b8:	9c0080e7          	jalr	-1600(ra) # 80002b74 <cpuid>
    800031bc:	01813083          	ld	ra,24(sp)
    800031c0:	01013403          	ld	s0,16(sp)
    800031c4:	00d5179b          	slliw	a5,a0,0xd
    800031c8:	0c201737          	lui	a4,0xc201
    800031cc:	00f707b3          	add	a5,a4,a5
    800031d0:	0097a223          	sw	s1,4(a5) # c201004 <_entry-0x73dfeffc>
    800031d4:	00813483          	ld	s1,8(sp)
    800031d8:	02010113          	addi	sp,sp,32
    800031dc:	00008067          	ret

00000000800031e0 <consolewrite>:
    800031e0:	fb010113          	addi	sp,sp,-80
    800031e4:	04813023          	sd	s0,64(sp)
    800031e8:	04113423          	sd	ra,72(sp)
    800031ec:	02913c23          	sd	s1,56(sp)
    800031f0:	03213823          	sd	s2,48(sp)
    800031f4:	03313423          	sd	s3,40(sp)
    800031f8:	03413023          	sd	s4,32(sp)
    800031fc:	01513c23          	sd	s5,24(sp)
    80003200:	05010413          	addi	s0,sp,80
    80003204:	06c05c63          	blez	a2,8000327c <consolewrite+0x9c>
    80003208:	00060993          	mv	s3,a2
    8000320c:	00050a13          	mv	s4,a0
    80003210:	00058493          	mv	s1,a1
    80003214:	00000913          	li	s2,0
    80003218:	fff00a93          	li	s5,-1
    8000321c:	01c0006f          	j	80003238 <consolewrite+0x58>
    80003220:	fbf44503          	lbu	a0,-65(s0)
    80003224:	0019091b          	addiw	s2,s2,1
    80003228:	00148493          	addi	s1,s1,1
    8000322c:	00001097          	auipc	ra,0x1
    80003230:	a9c080e7          	jalr	-1380(ra) # 80003cc8 <uartputc>
    80003234:	03298063          	beq	s3,s2,80003254 <consolewrite+0x74>
    80003238:	00048613          	mv	a2,s1
    8000323c:	00100693          	li	a3,1
    80003240:	000a0593          	mv	a1,s4
    80003244:	fbf40513          	addi	a0,s0,-65
    80003248:	00000097          	auipc	ra,0x0
    8000324c:	9e4080e7          	jalr	-1564(ra) # 80002c2c <either_copyin>
    80003250:	fd5518e3          	bne	a0,s5,80003220 <consolewrite+0x40>
    80003254:	04813083          	ld	ra,72(sp)
    80003258:	04013403          	ld	s0,64(sp)
    8000325c:	03813483          	ld	s1,56(sp)
    80003260:	02813983          	ld	s3,40(sp)
    80003264:	02013a03          	ld	s4,32(sp)
    80003268:	01813a83          	ld	s5,24(sp)
    8000326c:	00090513          	mv	a0,s2
    80003270:	03013903          	ld	s2,48(sp)
    80003274:	05010113          	addi	sp,sp,80
    80003278:	00008067          	ret
    8000327c:	00000913          	li	s2,0
    80003280:	fd5ff06f          	j	80003254 <consolewrite+0x74>

0000000080003284 <consoleread>:
    80003284:	f9010113          	addi	sp,sp,-112
    80003288:	06813023          	sd	s0,96(sp)
    8000328c:	04913c23          	sd	s1,88(sp)
    80003290:	05213823          	sd	s2,80(sp)
    80003294:	05313423          	sd	s3,72(sp)
    80003298:	05413023          	sd	s4,64(sp)
    8000329c:	03513c23          	sd	s5,56(sp)
    800032a0:	03613823          	sd	s6,48(sp)
    800032a4:	03713423          	sd	s7,40(sp)
    800032a8:	03813023          	sd	s8,32(sp)
    800032ac:	06113423          	sd	ra,104(sp)
    800032b0:	01913c23          	sd	s9,24(sp)
    800032b4:	07010413          	addi	s0,sp,112
    800032b8:	00060b93          	mv	s7,a2
    800032bc:	00050913          	mv	s2,a0
    800032c0:	00058c13          	mv	s8,a1
    800032c4:	00060b1b          	sext.w	s6,a2
    800032c8:	00006497          	auipc	s1,0x6
    800032cc:	4d048493          	addi	s1,s1,1232 # 80009798 <cons>
    800032d0:	00400993          	li	s3,4
    800032d4:	fff00a13          	li	s4,-1
    800032d8:	00a00a93          	li	s5,10
    800032dc:	05705e63          	blez	s7,80003338 <consoleread+0xb4>
    800032e0:	09c4a703          	lw	a4,156(s1)
    800032e4:	0984a783          	lw	a5,152(s1)
    800032e8:	0007071b          	sext.w	a4,a4
    800032ec:	08e78463          	beq	a5,a4,80003374 <consoleread+0xf0>
    800032f0:	07f7f713          	andi	a4,a5,127
    800032f4:	00e48733          	add	a4,s1,a4
    800032f8:	01874703          	lbu	a4,24(a4) # c201018 <_entry-0x73dfefe8>
    800032fc:	0017869b          	addiw	a3,a5,1
    80003300:	08d4ac23          	sw	a3,152(s1)
    80003304:	00070c9b          	sext.w	s9,a4
    80003308:	0b370663          	beq	a4,s3,800033b4 <consoleread+0x130>
    8000330c:	00100693          	li	a3,1
    80003310:	f9f40613          	addi	a2,s0,-97
    80003314:	000c0593          	mv	a1,s8
    80003318:	00090513          	mv	a0,s2
    8000331c:	f8e40fa3          	sb	a4,-97(s0)
    80003320:	00000097          	auipc	ra,0x0
    80003324:	8c0080e7          	jalr	-1856(ra) # 80002be0 <either_copyout>
    80003328:	01450863          	beq	a0,s4,80003338 <consoleread+0xb4>
    8000332c:	001c0c13          	addi	s8,s8,1
    80003330:	fffb8b9b          	addiw	s7,s7,-1
    80003334:	fb5c94e3          	bne	s9,s5,800032dc <consoleread+0x58>
    80003338:	000b851b          	sext.w	a0,s7
    8000333c:	06813083          	ld	ra,104(sp)
    80003340:	06013403          	ld	s0,96(sp)
    80003344:	05813483          	ld	s1,88(sp)
    80003348:	05013903          	ld	s2,80(sp)
    8000334c:	04813983          	ld	s3,72(sp)
    80003350:	04013a03          	ld	s4,64(sp)
    80003354:	03813a83          	ld	s5,56(sp)
    80003358:	02813b83          	ld	s7,40(sp)
    8000335c:	02013c03          	ld	s8,32(sp)
    80003360:	01813c83          	ld	s9,24(sp)
    80003364:	40ab053b          	subw	a0,s6,a0
    80003368:	03013b03          	ld	s6,48(sp)
    8000336c:	07010113          	addi	sp,sp,112
    80003370:	00008067          	ret
    80003374:	00001097          	auipc	ra,0x1
    80003378:	1d8080e7          	jalr	472(ra) # 8000454c <push_on>
    8000337c:	0984a703          	lw	a4,152(s1)
    80003380:	09c4a783          	lw	a5,156(s1)
    80003384:	0007879b          	sext.w	a5,a5
    80003388:	fef70ce3          	beq	a4,a5,80003380 <consoleread+0xfc>
    8000338c:	00001097          	auipc	ra,0x1
    80003390:	234080e7          	jalr	564(ra) # 800045c0 <pop_on>
    80003394:	0984a783          	lw	a5,152(s1)
    80003398:	07f7f713          	andi	a4,a5,127
    8000339c:	00e48733          	add	a4,s1,a4
    800033a0:	01874703          	lbu	a4,24(a4)
    800033a4:	0017869b          	addiw	a3,a5,1
    800033a8:	08d4ac23          	sw	a3,152(s1)
    800033ac:	00070c9b          	sext.w	s9,a4
    800033b0:	f5371ee3          	bne	a4,s3,8000330c <consoleread+0x88>
    800033b4:	000b851b          	sext.w	a0,s7
    800033b8:	f96bf2e3          	bgeu	s7,s6,8000333c <consoleread+0xb8>
    800033bc:	08f4ac23          	sw	a5,152(s1)
    800033c0:	f7dff06f          	j	8000333c <consoleread+0xb8>

00000000800033c4 <consputc>:
    800033c4:	10000793          	li	a5,256
    800033c8:	00f50663          	beq	a0,a5,800033d4 <consputc+0x10>
    800033cc:	00001317          	auipc	t1,0x1
    800033d0:	9f430067          	jr	-1548(t1) # 80003dc0 <uartputc_sync>
    800033d4:	ff010113          	addi	sp,sp,-16
    800033d8:	00113423          	sd	ra,8(sp)
    800033dc:	00813023          	sd	s0,0(sp)
    800033e0:	01010413          	addi	s0,sp,16
    800033e4:	00800513          	li	a0,8
    800033e8:	00001097          	auipc	ra,0x1
    800033ec:	9d8080e7          	jalr	-1576(ra) # 80003dc0 <uartputc_sync>
    800033f0:	02000513          	li	a0,32
    800033f4:	00001097          	auipc	ra,0x1
    800033f8:	9cc080e7          	jalr	-1588(ra) # 80003dc0 <uartputc_sync>
    800033fc:	00013403          	ld	s0,0(sp)
    80003400:	00813083          	ld	ra,8(sp)
    80003404:	00800513          	li	a0,8
    80003408:	01010113          	addi	sp,sp,16
    8000340c:	00001317          	auipc	t1,0x1
    80003410:	9b430067          	jr	-1612(t1) # 80003dc0 <uartputc_sync>

0000000080003414 <consoleintr>:
    80003414:	fe010113          	addi	sp,sp,-32
    80003418:	00813823          	sd	s0,16(sp)
    8000341c:	00913423          	sd	s1,8(sp)
    80003420:	01213023          	sd	s2,0(sp)
    80003424:	00113c23          	sd	ra,24(sp)
    80003428:	02010413          	addi	s0,sp,32
    8000342c:	00006917          	auipc	s2,0x6
    80003430:	36c90913          	addi	s2,s2,876 # 80009798 <cons>
    80003434:	00050493          	mv	s1,a0
    80003438:	00090513          	mv	a0,s2
    8000343c:	00001097          	auipc	ra,0x1
    80003440:	e40080e7          	jalr	-448(ra) # 8000427c <acquire>
    80003444:	02048c63          	beqz	s1,8000347c <consoleintr+0x68>
    80003448:	0a092783          	lw	a5,160(s2)
    8000344c:	09892703          	lw	a4,152(s2)
    80003450:	07f00693          	li	a3,127
    80003454:	40e7873b          	subw	a4,a5,a4
    80003458:	02e6e263          	bltu	a3,a4,8000347c <consoleintr+0x68>
    8000345c:	00d00713          	li	a4,13
    80003460:	04e48063          	beq	s1,a4,800034a0 <consoleintr+0x8c>
    80003464:	07f7f713          	andi	a4,a5,127
    80003468:	00e90733          	add	a4,s2,a4
    8000346c:	0017879b          	addiw	a5,a5,1
    80003470:	0af92023          	sw	a5,160(s2)
    80003474:	00970c23          	sb	s1,24(a4)
    80003478:	08f92e23          	sw	a5,156(s2)
    8000347c:	01013403          	ld	s0,16(sp)
    80003480:	01813083          	ld	ra,24(sp)
    80003484:	00813483          	ld	s1,8(sp)
    80003488:	00013903          	ld	s2,0(sp)
    8000348c:	00006517          	auipc	a0,0x6
    80003490:	30c50513          	addi	a0,a0,780 # 80009798 <cons>
    80003494:	02010113          	addi	sp,sp,32
    80003498:	00001317          	auipc	t1,0x1
    8000349c:	eb030067          	jr	-336(t1) # 80004348 <release>
    800034a0:	00a00493          	li	s1,10
    800034a4:	fc1ff06f          	j	80003464 <consoleintr+0x50>

00000000800034a8 <consoleinit>:
    800034a8:	fe010113          	addi	sp,sp,-32
    800034ac:	00113c23          	sd	ra,24(sp)
    800034b0:	00813823          	sd	s0,16(sp)
    800034b4:	00913423          	sd	s1,8(sp)
    800034b8:	02010413          	addi	s0,sp,32
    800034bc:	00006497          	auipc	s1,0x6
    800034c0:	2dc48493          	addi	s1,s1,732 # 80009798 <cons>
    800034c4:	00048513          	mv	a0,s1
    800034c8:	00002597          	auipc	a1,0x2
    800034cc:	d4858593          	addi	a1,a1,-696 # 80005210 <CONSOLE_STATUS+0x1f8>
    800034d0:	00001097          	auipc	ra,0x1
    800034d4:	d88080e7          	jalr	-632(ra) # 80004258 <initlock>
    800034d8:	00000097          	auipc	ra,0x0
    800034dc:	7ac080e7          	jalr	1964(ra) # 80003c84 <uartinit>
    800034e0:	01813083          	ld	ra,24(sp)
    800034e4:	01013403          	ld	s0,16(sp)
    800034e8:	00000797          	auipc	a5,0x0
    800034ec:	d9c78793          	addi	a5,a5,-612 # 80003284 <consoleread>
    800034f0:	0af4bc23          	sd	a5,184(s1)
    800034f4:	00000797          	auipc	a5,0x0
    800034f8:	cec78793          	addi	a5,a5,-788 # 800031e0 <consolewrite>
    800034fc:	0cf4b023          	sd	a5,192(s1)
    80003500:	00813483          	ld	s1,8(sp)
    80003504:	02010113          	addi	sp,sp,32
    80003508:	00008067          	ret

000000008000350c <console_read>:
    8000350c:	ff010113          	addi	sp,sp,-16
    80003510:	00813423          	sd	s0,8(sp)
    80003514:	01010413          	addi	s0,sp,16
    80003518:	00813403          	ld	s0,8(sp)
    8000351c:	00006317          	auipc	t1,0x6
    80003520:	33433303          	ld	t1,820(t1) # 80009850 <devsw+0x10>
    80003524:	01010113          	addi	sp,sp,16
    80003528:	00030067          	jr	t1

000000008000352c <console_write>:
    8000352c:	ff010113          	addi	sp,sp,-16
    80003530:	00813423          	sd	s0,8(sp)
    80003534:	01010413          	addi	s0,sp,16
    80003538:	00813403          	ld	s0,8(sp)
    8000353c:	00006317          	auipc	t1,0x6
    80003540:	31c33303          	ld	t1,796(t1) # 80009858 <devsw+0x18>
    80003544:	01010113          	addi	sp,sp,16
    80003548:	00030067          	jr	t1

000000008000354c <panic>:
    8000354c:	fe010113          	addi	sp,sp,-32
    80003550:	00113c23          	sd	ra,24(sp)
    80003554:	00813823          	sd	s0,16(sp)
    80003558:	00913423          	sd	s1,8(sp)
    8000355c:	02010413          	addi	s0,sp,32
    80003560:	00050493          	mv	s1,a0
    80003564:	00002517          	auipc	a0,0x2
    80003568:	cb450513          	addi	a0,a0,-844 # 80005218 <CONSOLE_STATUS+0x200>
    8000356c:	00006797          	auipc	a5,0x6
    80003570:	3807a623          	sw	zero,908(a5) # 800098f8 <pr+0x18>
    80003574:	00000097          	auipc	ra,0x0
    80003578:	034080e7          	jalr	52(ra) # 800035a8 <__printf>
    8000357c:	00048513          	mv	a0,s1
    80003580:	00000097          	auipc	ra,0x0
    80003584:	028080e7          	jalr	40(ra) # 800035a8 <__printf>
    80003588:	00002517          	auipc	a0,0x2
    8000358c:	c7050513          	addi	a0,a0,-912 # 800051f8 <CONSOLE_STATUS+0x1e0>
    80003590:	00000097          	auipc	ra,0x0
    80003594:	018080e7          	jalr	24(ra) # 800035a8 <__printf>
    80003598:	00100793          	li	a5,1
    8000359c:	00002717          	auipc	a4,0x2
    800035a0:	0cf72c23          	sw	a5,216(a4) # 80005674 <panicked>
    800035a4:	0000006f          	j	800035a4 <panic+0x58>

00000000800035a8 <__printf>:
    800035a8:	f3010113          	addi	sp,sp,-208
    800035ac:	08813023          	sd	s0,128(sp)
    800035b0:	07313423          	sd	s3,104(sp)
    800035b4:	09010413          	addi	s0,sp,144
    800035b8:	05813023          	sd	s8,64(sp)
    800035bc:	08113423          	sd	ra,136(sp)
    800035c0:	06913c23          	sd	s1,120(sp)
    800035c4:	07213823          	sd	s2,112(sp)
    800035c8:	07413023          	sd	s4,96(sp)
    800035cc:	05513c23          	sd	s5,88(sp)
    800035d0:	05613823          	sd	s6,80(sp)
    800035d4:	05713423          	sd	s7,72(sp)
    800035d8:	03913c23          	sd	s9,56(sp)
    800035dc:	03a13823          	sd	s10,48(sp)
    800035e0:	03b13423          	sd	s11,40(sp)
    800035e4:	00006317          	auipc	t1,0x6
    800035e8:	2fc30313          	addi	t1,t1,764 # 800098e0 <pr>
    800035ec:	01832c03          	lw	s8,24(t1)
    800035f0:	00b43423          	sd	a1,8(s0)
    800035f4:	00c43823          	sd	a2,16(s0)
    800035f8:	00d43c23          	sd	a3,24(s0)
    800035fc:	02e43023          	sd	a4,32(s0)
    80003600:	02f43423          	sd	a5,40(s0)
    80003604:	03043823          	sd	a6,48(s0)
    80003608:	03143c23          	sd	a7,56(s0)
    8000360c:	00050993          	mv	s3,a0
    80003610:	4a0c1663          	bnez	s8,80003abc <__printf+0x514>
    80003614:	60098c63          	beqz	s3,80003c2c <__printf+0x684>
    80003618:	0009c503          	lbu	a0,0(s3)
    8000361c:	00840793          	addi	a5,s0,8
    80003620:	f6f43c23          	sd	a5,-136(s0)
    80003624:	00000493          	li	s1,0
    80003628:	22050063          	beqz	a0,80003848 <__printf+0x2a0>
    8000362c:	00002a37          	lui	s4,0x2
    80003630:	00018ab7          	lui	s5,0x18
    80003634:	000f4b37          	lui	s6,0xf4
    80003638:	00989bb7          	lui	s7,0x989
    8000363c:	70fa0a13          	addi	s4,s4,1807 # 270f <_entry-0x7fffd8f1>
    80003640:	69fa8a93          	addi	s5,s5,1695 # 1869f <_entry-0x7ffe7961>
    80003644:	23fb0b13          	addi	s6,s6,575 # f423f <_entry-0x7ff0bdc1>
    80003648:	67fb8b93          	addi	s7,s7,1663 # 98967f <_entry-0x7f676981>
    8000364c:	00148c9b          	addiw	s9,s1,1
    80003650:	02500793          	li	a5,37
    80003654:	01998933          	add	s2,s3,s9
    80003658:	38f51263          	bne	a0,a5,800039dc <__printf+0x434>
    8000365c:	00094783          	lbu	a5,0(s2)
    80003660:	00078c9b          	sext.w	s9,a5
    80003664:	1e078263          	beqz	a5,80003848 <__printf+0x2a0>
    80003668:	0024849b          	addiw	s1,s1,2
    8000366c:	07000713          	li	a4,112
    80003670:	00998933          	add	s2,s3,s1
    80003674:	38e78a63          	beq	a5,a4,80003a08 <__printf+0x460>
    80003678:	20f76863          	bltu	a4,a5,80003888 <__printf+0x2e0>
    8000367c:	42a78863          	beq	a5,a0,80003aac <__printf+0x504>
    80003680:	06400713          	li	a4,100
    80003684:	40e79663          	bne	a5,a4,80003a90 <__printf+0x4e8>
    80003688:	f7843783          	ld	a5,-136(s0)
    8000368c:	0007a603          	lw	a2,0(a5)
    80003690:	00878793          	addi	a5,a5,8
    80003694:	f6f43c23          	sd	a5,-136(s0)
    80003698:	42064a63          	bltz	a2,80003acc <__printf+0x524>
    8000369c:	00a00713          	li	a4,10
    800036a0:	02e677bb          	remuw	a5,a2,a4
    800036a4:	00002d97          	auipc	s11,0x2
    800036a8:	b9cd8d93          	addi	s11,s11,-1124 # 80005240 <digits>
    800036ac:	00900593          	li	a1,9
    800036b0:	0006051b          	sext.w	a0,a2
    800036b4:	00000c93          	li	s9,0
    800036b8:	02079793          	slli	a5,a5,0x20
    800036bc:	0207d793          	srli	a5,a5,0x20
    800036c0:	00fd87b3          	add	a5,s11,a5
    800036c4:	0007c783          	lbu	a5,0(a5)
    800036c8:	02e656bb          	divuw	a3,a2,a4
    800036cc:	f8f40023          	sb	a5,-128(s0)
    800036d0:	14c5d863          	bge	a1,a2,80003820 <__printf+0x278>
    800036d4:	06300593          	li	a1,99
    800036d8:	00100c93          	li	s9,1
    800036dc:	02e6f7bb          	remuw	a5,a3,a4
    800036e0:	02079793          	slli	a5,a5,0x20
    800036e4:	0207d793          	srli	a5,a5,0x20
    800036e8:	00fd87b3          	add	a5,s11,a5
    800036ec:	0007c783          	lbu	a5,0(a5)
    800036f0:	02e6d73b          	divuw	a4,a3,a4
    800036f4:	f8f400a3          	sb	a5,-127(s0)
    800036f8:	12a5f463          	bgeu	a1,a0,80003820 <__printf+0x278>
    800036fc:	00a00693          	li	a3,10
    80003700:	00900593          	li	a1,9
    80003704:	02d777bb          	remuw	a5,a4,a3
    80003708:	02079793          	slli	a5,a5,0x20
    8000370c:	0207d793          	srli	a5,a5,0x20
    80003710:	00fd87b3          	add	a5,s11,a5
    80003714:	0007c503          	lbu	a0,0(a5)
    80003718:	02d757bb          	divuw	a5,a4,a3
    8000371c:	f8a40123          	sb	a0,-126(s0)
    80003720:	48e5f263          	bgeu	a1,a4,80003ba4 <__printf+0x5fc>
    80003724:	06300513          	li	a0,99
    80003728:	02d7f5bb          	remuw	a1,a5,a3
    8000372c:	02059593          	slli	a1,a1,0x20
    80003730:	0205d593          	srli	a1,a1,0x20
    80003734:	00bd85b3          	add	a1,s11,a1
    80003738:	0005c583          	lbu	a1,0(a1)
    8000373c:	02d7d7bb          	divuw	a5,a5,a3
    80003740:	f8b401a3          	sb	a1,-125(s0)
    80003744:	48e57263          	bgeu	a0,a4,80003bc8 <__printf+0x620>
    80003748:	3e700513          	li	a0,999
    8000374c:	02d7f5bb          	remuw	a1,a5,a3
    80003750:	02059593          	slli	a1,a1,0x20
    80003754:	0205d593          	srli	a1,a1,0x20
    80003758:	00bd85b3          	add	a1,s11,a1
    8000375c:	0005c583          	lbu	a1,0(a1)
    80003760:	02d7d7bb          	divuw	a5,a5,a3
    80003764:	f8b40223          	sb	a1,-124(s0)
    80003768:	46e57663          	bgeu	a0,a4,80003bd4 <__printf+0x62c>
    8000376c:	02d7f5bb          	remuw	a1,a5,a3
    80003770:	02059593          	slli	a1,a1,0x20
    80003774:	0205d593          	srli	a1,a1,0x20
    80003778:	00bd85b3          	add	a1,s11,a1
    8000377c:	0005c583          	lbu	a1,0(a1)
    80003780:	02d7d7bb          	divuw	a5,a5,a3
    80003784:	f8b402a3          	sb	a1,-123(s0)
    80003788:	46ea7863          	bgeu	s4,a4,80003bf8 <__printf+0x650>
    8000378c:	02d7f5bb          	remuw	a1,a5,a3
    80003790:	02059593          	slli	a1,a1,0x20
    80003794:	0205d593          	srli	a1,a1,0x20
    80003798:	00bd85b3          	add	a1,s11,a1
    8000379c:	0005c583          	lbu	a1,0(a1)
    800037a0:	02d7d7bb          	divuw	a5,a5,a3
    800037a4:	f8b40323          	sb	a1,-122(s0)
    800037a8:	3eeaf863          	bgeu	s5,a4,80003b98 <__printf+0x5f0>
    800037ac:	02d7f5bb          	remuw	a1,a5,a3
    800037b0:	02059593          	slli	a1,a1,0x20
    800037b4:	0205d593          	srli	a1,a1,0x20
    800037b8:	00bd85b3          	add	a1,s11,a1
    800037bc:	0005c583          	lbu	a1,0(a1)
    800037c0:	02d7d7bb          	divuw	a5,a5,a3
    800037c4:	f8b403a3          	sb	a1,-121(s0)
    800037c8:	42eb7e63          	bgeu	s6,a4,80003c04 <__printf+0x65c>
    800037cc:	02d7f5bb          	remuw	a1,a5,a3
    800037d0:	02059593          	slli	a1,a1,0x20
    800037d4:	0205d593          	srli	a1,a1,0x20
    800037d8:	00bd85b3          	add	a1,s11,a1
    800037dc:	0005c583          	lbu	a1,0(a1)
    800037e0:	02d7d7bb          	divuw	a5,a5,a3
    800037e4:	f8b40423          	sb	a1,-120(s0)
    800037e8:	42ebfc63          	bgeu	s7,a4,80003c20 <__printf+0x678>
    800037ec:	02079793          	slli	a5,a5,0x20
    800037f0:	0207d793          	srli	a5,a5,0x20
    800037f4:	00fd8db3          	add	s11,s11,a5
    800037f8:	000dc703          	lbu	a4,0(s11)
    800037fc:	00a00793          	li	a5,10
    80003800:	00900c93          	li	s9,9
    80003804:	f8e404a3          	sb	a4,-119(s0)
    80003808:	00065c63          	bgez	a2,80003820 <__printf+0x278>
    8000380c:	f9040713          	addi	a4,s0,-112
    80003810:	00f70733          	add	a4,a4,a5
    80003814:	02d00693          	li	a3,45
    80003818:	fed70823          	sb	a3,-16(a4)
    8000381c:	00078c93          	mv	s9,a5
    80003820:	f8040793          	addi	a5,s0,-128
    80003824:	01978cb3          	add	s9,a5,s9
    80003828:	f7f40d13          	addi	s10,s0,-129
    8000382c:	000cc503          	lbu	a0,0(s9)
    80003830:	fffc8c93          	addi	s9,s9,-1
    80003834:	00000097          	auipc	ra,0x0
    80003838:	b90080e7          	jalr	-1136(ra) # 800033c4 <consputc>
    8000383c:	ffac98e3          	bne	s9,s10,8000382c <__printf+0x284>
    80003840:	00094503          	lbu	a0,0(s2)
    80003844:	e00514e3          	bnez	a0,8000364c <__printf+0xa4>
    80003848:	1a0c1663          	bnez	s8,800039f4 <__printf+0x44c>
    8000384c:	08813083          	ld	ra,136(sp)
    80003850:	08013403          	ld	s0,128(sp)
    80003854:	07813483          	ld	s1,120(sp)
    80003858:	07013903          	ld	s2,112(sp)
    8000385c:	06813983          	ld	s3,104(sp)
    80003860:	06013a03          	ld	s4,96(sp)
    80003864:	05813a83          	ld	s5,88(sp)
    80003868:	05013b03          	ld	s6,80(sp)
    8000386c:	04813b83          	ld	s7,72(sp)
    80003870:	04013c03          	ld	s8,64(sp)
    80003874:	03813c83          	ld	s9,56(sp)
    80003878:	03013d03          	ld	s10,48(sp)
    8000387c:	02813d83          	ld	s11,40(sp)
    80003880:	0d010113          	addi	sp,sp,208
    80003884:	00008067          	ret
    80003888:	07300713          	li	a4,115
    8000388c:	1ce78a63          	beq	a5,a4,80003a60 <__printf+0x4b8>
    80003890:	07800713          	li	a4,120
    80003894:	1ee79e63          	bne	a5,a4,80003a90 <__printf+0x4e8>
    80003898:	f7843783          	ld	a5,-136(s0)
    8000389c:	0007a703          	lw	a4,0(a5)
    800038a0:	00878793          	addi	a5,a5,8
    800038a4:	f6f43c23          	sd	a5,-136(s0)
    800038a8:	28074263          	bltz	a4,80003b2c <__printf+0x584>
    800038ac:	00002d97          	auipc	s11,0x2
    800038b0:	994d8d93          	addi	s11,s11,-1644 # 80005240 <digits>
    800038b4:	00f77793          	andi	a5,a4,15
    800038b8:	00fd87b3          	add	a5,s11,a5
    800038bc:	0007c683          	lbu	a3,0(a5)
    800038c0:	00f00613          	li	a2,15
    800038c4:	0007079b          	sext.w	a5,a4
    800038c8:	f8d40023          	sb	a3,-128(s0)
    800038cc:	0047559b          	srliw	a1,a4,0x4
    800038d0:	0047569b          	srliw	a3,a4,0x4
    800038d4:	00000c93          	li	s9,0
    800038d8:	0ee65063          	bge	a2,a4,800039b8 <__printf+0x410>
    800038dc:	00f6f693          	andi	a3,a3,15
    800038e0:	00dd86b3          	add	a3,s11,a3
    800038e4:	0006c683          	lbu	a3,0(a3) # 2004000 <_entry-0x7dffc000>
    800038e8:	0087d79b          	srliw	a5,a5,0x8
    800038ec:	00100c93          	li	s9,1
    800038f0:	f8d400a3          	sb	a3,-127(s0)
    800038f4:	0cb67263          	bgeu	a2,a1,800039b8 <__printf+0x410>
    800038f8:	00f7f693          	andi	a3,a5,15
    800038fc:	00dd86b3          	add	a3,s11,a3
    80003900:	0006c583          	lbu	a1,0(a3)
    80003904:	00f00613          	li	a2,15
    80003908:	0047d69b          	srliw	a3,a5,0x4
    8000390c:	f8b40123          	sb	a1,-126(s0)
    80003910:	0047d593          	srli	a1,a5,0x4
    80003914:	28f67e63          	bgeu	a2,a5,80003bb0 <__printf+0x608>
    80003918:	00f6f693          	andi	a3,a3,15
    8000391c:	00dd86b3          	add	a3,s11,a3
    80003920:	0006c503          	lbu	a0,0(a3)
    80003924:	0087d813          	srli	a6,a5,0x8
    80003928:	0087d69b          	srliw	a3,a5,0x8
    8000392c:	f8a401a3          	sb	a0,-125(s0)
    80003930:	28b67663          	bgeu	a2,a1,80003bbc <__printf+0x614>
    80003934:	00f6f693          	andi	a3,a3,15
    80003938:	00dd86b3          	add	a3,s11,a3
    8000393c:	0006c583          	lbu	a1,0(a3)
    80003940:	00c7d513          	srli	a0,a5,0xc
    80003944:	00c7d69b          	srliw	a3,a5,0xc
    80003948:	f8b40223          	sb	a1,-124(s0)
    8000394c:	29067a63          	bgeu	a2,a6,80003be0 <__printf+0x638>
    80003950:	00f6f693          	andi	a3,a3,15
    80003954:	00dd86b3          	add	a3,s11,a3
    80003958:	0006c583          	lbu	a1,0(a3)
    8000395c:	0107d813          	srli	a6,a5,0x10
    80003960:	0107d69b          	srliw	a3,a5,0x10
    80003964:	f8b402a3          	sb	a1,-123(s0)
    80003968:	28a67263          	bgeu	a2,a0,80003bec <__printf+0x644>
    8000396c:	00f6f693          	andi	a3,a3,15
    80003970:	00dd86b3          	add	a3,s11,a3
    80003974:	0006c683          	lbu	a3,0(a3)
    80003978:	0147d79b          	srliw	a5,a5,0x14
    8000397c:	f8d40323          	sb	a3,-122(s0)
    80003980:	21067663          	bgeu	a2,a6,80003b8c <__printf+0x5e4>
    80003984:	02079793          	slli	a5,a5,0x20
    80003988:	0207d793          	srli	a5,a5,0x20
    8000398c:	00fd8db3          	add	s11,s11,a5
    80003990:	000dc683          	lbu	a3,0(s11)
    80003994:	00800793          	li	a5,8
    80003998:	00700c93          	li	s9,7
    8000399c:	f8d403a3          	sb	a3,-121(s0)
    800039a0:	00075c63          	bgez	a4,800039b8 <__printf+0x410>
    800039a4:	f9040713          	addi	a4,s0,-112
    800039a8:	00f70733          	add	a4,a4,a5
    800039ac:	02d00693          	li	a3,45
    800039b0:	fed70823          	sb	a3,-16(a4)
    800039b4:	00078c93          	mv	s9,a5
    800039b8:	f8040793          	addi	a5,s0,-128
    800039bc:	01978cb3          	add	s9,a5,s9
    800039c0:	f7f40d13          	addi	s10,s0,-129
    800039c4:	000cc503          	lbu	a0,0(s9)
    800039c8:	fffc8c93          	addi	s9,s9,-1
    800039cc:	00000097          	auipc	ra,0x0
    800039d0:	9f8080e7          	jalr	-1544(ra) # 800033c4 <consputc>
    800039d4:	ff9d18e3          	bne	s10,s9,800039c4 <__printf+0x41c>
    800039d8:	0100006f          	j	800039e8 <__printf+0x440>
    800039dc:	00000097          	auipc	ra,0x0
    800039e0:	9e8080e7          	jalr	-1560(ra) # 800033c4 <consputc>
    800039e4:	000c8493          	mv	s1,s9
    800039e8:	00094503          	lbu	a0,0(s2)
    800039ec:	c60510e3          	bnez	a0,8000364c <__printf+0xa4>
    800039f0:	e40c0ee3          	beqz	s8,8000384c <__printf+0x2a4>
    800039f4:	00006517          	auipc	a0,0x6
    800039f8:	eec50513          	addi	a0,a0,-276 # 800098e0 <pr>
    800039fc:	00001097          	auipc	ra,0x1
    80003a00:	94c080e7          	jalr	-1716(ra) # 80004348 <release>
    80003a04:	e49ff06f          	j	8000384c <__printf+0x2a4>
    80003a08:	f7843783          	ld	a5,-136(s0)
    80003a0c:	03000513          	li	a0,48
    80003a10:	01000d13          	li	s10,16
    80003a14:	00878713          	addi	a4,a5,8
    80003a18:	0007bc83          	ld	s9,0(a5)
    80003a1c:	f6e43c23          	sd	a4,-136(s0)
    80003a20:	00000097          	auipc	ra,0x0
    80003a24:	9a4080e7          	jalr	-1628(ra) # 800033c4 <consputc>
    80003a28:	07800513          	li	a0,120
    80003a2c:	00000097          	auipc	ra,0x0
    80003a30:	998080e7          	jalr	-1640(ra) # 800033c4 <consputc>
    80003a34:	00002d97          	auipc	s11,0x2
    80003a38:	80cd8d93          	addi	s11,s11,-2036 # 80005240 <digits>
    80003a3c:	03ccd793          	srli	a5,s9,0x3c
    80003a40:	00fd87b3          	add	a5,s11,a5
    80003a44:	0007c503          	lbu	a0,0(a5)
    80003a48:	fffd0d1b          	addiw	s10,s10,-1
    80003a4c:	004c9c93          	slli	s9,s9,0x4
    80003a50:	00000097          	auipc	ra,0x0
    80003a54:	974080e7          	jalr	-1676(ra) # 800033c4 <consputc>
    80003a58:	fe0d12e3          	bnez	s10,80003a3c <__printf+0x494>
    80003a5c:	f8dff06f          	j	800039e8 <__printf+0x440>
    80003a60:	f7843783          	ld	a5,-136(s0)
    80003a64:	0007bc83          	ld	s9,0(a5)
    80003a68:	00878793          	addi	a5,a5,8
    80003a6c:	f6f43c23          	sd	a5,-136(s0)
    80003a70:	000c9a63          	bnez	s9,80003a84 <__printf+0x4dc>
    80003a74:	1080006f          	j	80003b7c <__printf+0x5d4>
    80003a78:	001c8c93          	addi	s9,s9,1
    80003a7c:	00000097          	auipc	ra,0x0
    80003a80:	948080e7          	jalr	-1720(ra) # 800033c4 <consputc>
    80003a84:	000cc503          	lbu	a0,0(s9)
    80003a88:	fe0518e3          	bnez	a0,80003a78 <__printf+0x4d0>
    80003a8c:	f5dff06f          	j	800039e8 <__printf+0x440>
    80003a90:	02500513          	li	a0,37
    80003a94:	00000097          	auipc	ra,0x0
    80003a98:	930080e7          	jalr	-1744(ra) # 800033c4 <consputc>
    80003a9c:	000c8513          	mv	a0,s9
    80003aa0:	00000097          	auipc	ra,0x0
    80003aa4:	924080e7          	jalr	-1756(ra) # 800033c4 <consputc>
    80003aa8:	f41ff06f          	j	800039e8 <__printf+0x440>
    80003aac:	02500513          	li	a0,37
    80003ab0:	00000097          	auipc	ra,0x0
    80003ab4:	914080e7          	jalr	-1772(ra) # 800033c4 <consputc>
    80003ab8:	f31ff06f          	j	800039e8 <__printf+0x440>
    80003abc:	00030513          	mv	a0,t1
    80003ac0:	00000097          	auipc	ra,0x0
    80003ac4:	7bc080e7          	jalr	1980(ra) # 8000427c <acquire>
    80003ac8:	b4dff06f          	j	80003614 <__printf+0x6c>
    80003acc:	40c0053b          	negw	a0,a2
    80003ad0:	00a00713          	li	a4,10
    80003ad4:	02e576bb          	remuw	a3,a0,a4
    80003ad8:	00001d97          	auipc	s11,0x1
    80003adc:	768d8d93          	addi	s11,s11,1896 # 80005240 <digits>
    80003ae0:	ff700593          	li	a1,-9
    80003ae4:	02069693          	slli	a3,a3,0x20
    80003ae8:	0206d693          	srli	a3,a3,0x20
    80003aec:	00dd86b3          	add	a3,s11,a3
    80003af0:	0006c683          	lbu	a3,0(a3)
    80003af4:	02e557bb          	divuw	a5,a0,a4
    80003af8:	f8d40023          	sb	a3,-128(s0)
    80003afc:	10b65e63          	bge	a2,a1,80003c18 <__printf+0x670>
    80003b00:	06300593          	li	a1,99
    80003b04:	02e7f6bb          	remuw	a3,a5,a4
    80003b08:	02069693          	slli	a3,a3,0x20
    80003b0c:	0206d693          	srli	a3,a3,0x20
    80003b10:	00dd86b3          	add	a3,s11,a3
    80003b14:	0006c683          	lbu	a3,0(a3)
    80003b18:	02e7d73b          	divuw	a4,a5,a4
    80003b1c:	00200793          	li	a5,2
    80003b20:	f8d400a3          	sb	a3,-127(s0)
    80003b24:	bca5ece3          	bltu	a1,a0,800036fc <__printf+0x154>
    80003b28:	ce5ff06f          	j	8000380c <__printf+0x264>
    80003b2c:	40e007bb          	negw	a5,a4
    80003b30:	00001d97          	auipc	s11,0x1
    80003b34:	710d8d93          	addi	s11,s11,1808 # 80005240 <digits>
    80003b38:	00f7f693          	andi	a3,a5,15
    80003b3c:	00dd86b3          	add	a3,s11,a3
    80003b40:	0006c583          	lbu	a1,0(a3)
    80003b44:	ff100613          	li	a2,-15
    80003b48:	0047d69b          	srliw	a3,a5,0x4
    80003b4c:	f8b40023          	sb	a1,-128(s0)
    80003b50:	0047d59b          	srliw	a1,a5,0x4
    80003b54:	0ac75e63          	bge	a4,a2,80003c10 <__printf+0x668>
    80003b58:	00f6f693          	andi	a3,a3,15
    80003b5c:	00dd86b3          	add	a3,s11,a3
    80003b60:	0006c603          	lbu	a2,0(a3)
    80003b64:	00f00693          	li	a3,15
    80003b68:	0087d79b          	srliw	a5,a5,0x8
    80003b6c:	f8c400a3          	sb	a2,-127(s0)
    80003b70:	d8b6e4e3          	bltu	a3,a1,800038f8 <__printf+0x350>
    80003b74:	00200793          	li	a5,2
    80003b78:	e2dff06f          	j	800039a4 <__printf+0x3fc>
    80003b7c:	00001c97          	auipc	s9,0x1
    80003b80:	6a4c8c93          	addi	s9,s9,1700 # 80005220 <CONSOLE_STATUS+0x208>
    80003b84:	02800513          	li	a0,40
    80003b88:	ef1ff06f          	j	80003a78 <__printf+0x4d0>
    80003b8c:	00700793          	li	a5,7
    80003b90:	00600c93          	li	s9,6
    80003b94:	e0dff06f          	j	800039a0 <__printf+0x3f8>
    80003b98:	00700793          	li	a5,7
    80003b9c:	00600c93          	li	s9,6
    80003ba0:	c69ff06f          	j	80003808 <__printf+0x260>
    80003ba4:	00300793          	li	a5,3
    80003ba8:	00200c93          	li	s9,2
    80003bac:	c5dff06f          	j	80003808 <__printf+0x260>
    80003bb0:	00300793          	li	a5,3
    80003bb4:	00200c93          	li	s9,2
    80003bb8:	de9ff06f          	j	800039a0 <__printf+0x3f8>
    80003bbc:	00400793          	li	a5,4
    80003bc0:	00300c93          	li	s9,3
    80003bc4:	dddff06f          	j	800039a0 <__printf+0x3f8>
    80003bc8:	00400793          	li	a5,4
    80003bcc:	00300c93          	li	s9,3
    80003bd0:	c39ff06f          	j	80003808 <__printf+0x260>
    80003bd4:	00500793          	li	a5,5
    80003bd8:	00400c93          	li	s9,4
    80003bdc:	c2dff06f          	j	80003808 <__printf+0x260>
    80003be0:	00500793          	li	a5,5
    80003be4:	00400c93          	li	s9,4
    80003be8:	db9ff06f          	j	800039a0 <__printf+0x3f8>
    80003bec:	00600793          	li	a5,6
    80003bf0:	00500c93          	li	s9,5
    80003bf4:	dadff06f          	j	800039a0 <__printf+0x3f8>
    80003bf8:	00600793          	li	a5,6
    80003bfc:	00500c93          	li	s9,5
    80003c00:	c09ff06f          	j	80003808 <__printf+0x260>
    80003c04:	00800793          	li	a5,8
    80003c08:	00700c93          	li	s9,7
    80003c0c:	bfdff06f          	j	80003808 <__printf+0x260>
    80003c10:	00100793          	li	a5,1
    80003c14:	d91ff06f          	j	800039a4 <__printf+0x3fc>
    80003c18:	00100793          	li	a5,1
    80003c1c:	bf1ff06f          	j	8000380c <__printf+0x264>
    80003c20:	00900793          	li	a5,9
    80003c24:	00800c93          	li	s9,8
    80003c28:	be1ff06f          	j	80003808 <__printf+0x260>
    80003c2c:	00001517          	auipc	a0,0x1
    80003c30:	5fc50513          	addi	a0,a0,1532 # 80005228 <CONSOLE_STATUS+0x210>
    80003c34:	00000097          	auipc	ra,0x0
    80003c38:	918080e7          	jalr	-1768(ra) # 8000354c <panic>

0000000080003c3c <printfinit>:
    80003c3c:	fe010113          	addi	sp,sp,-32
    80003c40:	00813823          	sd	s0,16(sp)
    80003c44:	00913423          	sd	s1,8(sp)
    80003c48:	00113c23          	sd	ra,24(sp)
    80003c4c:	02010413          	addi	s0,sp,32
    80003c50:	00006497          	auipc	s1,0x6
    80003c54:	c9048493          	addi	s1,s1,-880 # 800098e0 <pr>
    80003c58:	00048513          	mv	a0,s1
    80003c5c:	00001597          	auipc	a1,0x1
    80003c60:	5dc58593          	addi	a1,a1,1500 # 80005238 <CONSOLE_STATUS+0x220>
    80003c64:	00000097          	auipc	ra,0x0
    80003c68:	5f4080e7          	jalr	1524(ra) # 80004258 <initlock>
    80003c6c:	01813083          	ld	ra,24(sp)
    80003c70:	01013403          	ld	s0,16(sp)
    80003c74:	0004ac23          	sw	zero,24(s1)
    80003c78:	00813483          	ld	s1,8(sp)
    80003c7c:	02010113          	addi	sp,sp,32
    80003c80:	00008067          	ret

0000000080003c84 <uartinit>:
    80003c84:	ff010113          	addi	sp,sp,-16
    80003c88:	00813423          	sd	s0,8(sp)
    80003c8c:	01010413          	addi	s0,sp,16
    80003c90:	100007b7          	lui	a5,0x10000
    80003c94:	000780a3          	sb	zero,1(a5) # 10000001 <_entry-0x6fffffff>
    80003c98:	f8000713          	li	a4,-128
    80003c9c:	00e781a3          	sb	a4,3(a5)
    80003ca0:	00300713          	li	a4,3
    80003ca4:	00e78023          	sb	a4,0(a5)
    80003ca8:	000780a3          	sb	zero,1(a5)
    80003cac:	00e781a3          	sb	a4,3(a5)
    80003cb0:	00700693          	li	a3,7
    80003cb4:	00d78123          	sb	a3,2(a5)
    80003cb8:	00e780a3          	sb	a4,1(a5)
    80003cbc:	00813403          	ld	s0,8(sp)
    80003cc0:	01010113          	addi	sp,sp,16
    80003cc4:	00008067          	ret

0000000080003cc8 <uartputc>:
    80003cc8:	00002797          	auipc	a5,0x2
    80003ccc:	9ac7a783          	lw	a5,-1620(a5) # 80005674 <panicked>
    80003cd0:	00078463          	beqz	a5,80003cd8 <uartputc+0x10>
    80003cd4:	0000006f          	j	80003cd4 <uartputc+0xc>
    80003cd8:	fd010113          	addi	sp,sp,-48
    80003cdc:	02813023          	sd	s0,32(sp)
    80003ce0:	00913c23          	sd	s1,24(sp)
    80003ce4:	01213823          	sd	s2,16(sp)
    80003ce8:	01313423          	sd	s3,8(sp)
    80003cec:	02113423          	sd	ra,40(sp)
    80003cf0:	03010413          	addi	s0,sp,48
    80003cf4:	00002917          	auipc	s2,0x2
    80003cf8:	98490913          	addi	s2,s2,-1660 # 80005678 <uart_tx_r>
    80003cfc:	00093783          	ld	a5,0(s2)
    80003d00:	00002497          	auipc	s1,0x2
    80003d04:	98048493          	addi	s1,s1,-1664 # 80005680 <uart_tx_w>
    80003d08:	0004b703          	ld	a4,0(s1)
    80003d0c:	02078693          	addi	a3,a5,32
    80003d10:	00050993          	mv	s3,a0
    80003d14:	02e69c63          	bne	a3,a4,80003d4c <uartputc+0x84>
    80003d18:	00001097          	auipc	ra,0x1
    80003d1c:	834080e7          	jalr	-1996(ra) # 8000454c <push_on>
    80003d20:	00093783          	ld	a5,0(s2)
    80003d24:	0004b703          	ld	a4,0(s1)
    80003d28:	02078793          	addi	a5,a5,32
    80003d2c:	00e79463          	bne	a5,a4,80003d34 <uartputc+0x6c>
    80003d30:	0000006f          	j	80003d30 <uartputc+0x68>
    80003d34:	00001097          	auipc	ra,0x1
    80003d38:	88c080e7          	jalr	-1908(ra) # 800045c0 <pop_on>
    80003d3c:	00093783          	ld	a5,0(s2)
    80003d40:	0004b703          	ld	a4,0(s1)
    80003d44:	02078693          	addi	a3,a5,32
    80003d48:	fce688e3          	beq	a3,a4,80003d18 <uartputc+0x50>
    80003d4c:	01f77693          	andi	a3,a4,31
    80003d50:	00006597          	auipc	a1,0x6
    80003d54:	bb058593          	addi	a1,a1,-1104 # 80009900 <uart_tx_buf>
    80003d58:	00d586b3          	add	a3,a1,a3
    80003d5c:	00170713          	addi	a4,a4,1
    80003d60:	01368023          	sb	s3,0(a3)
    80003d64:	00e4b023          	sd	a4,0(s1)
    80003d68:	10000637          	lui	a2,0x10000
    80003d6c:	02f71063          	bne	a4,a5,80003d8c <uartputc+0xc4>
    80003d70:	0340006f          	j	80003da4 <uartputc+0xdc>
    80003d74:	00074703          	lbu	a4,0(a4)
    80003d78:	00f93023          	sd	a5,0(s2)
    80003d7c:	00e60023          	sb	a4,0(a2) # 10000000 <_entry-0x70000000>
    80003d80:	00093783          	ld	a5,0(s2)
    80003d84:	0004b703          	ld	a4,0(s1)
    80003d88:	00f70e63          	beq	a4,a5,80003da4 <uartputc+0xdc>
    80003d8c:	00564683          	lbu	a3,5(a2)
    80003d90:	01f7f713          	andi	a4,a5,31
    80003d94:	00e58733          	add	a4,a1,a4
    80003d98:	0206f693          	andi	a3,a3,32
    80003d9c:	00178793          	addi	a5,a5,1
    80003da0:	fc069ae3          	bnez	a3,80003d74 <uartputc+0xac>
    80003da4:	02813083          	ld	ra,40(sp)
    80003da8:	02013403          	ld	s0,32(sp)
    80003dac:	01813483          	ld	s1,24(sp)
    80003db0:	01013903          	ld	s2,16(sp)
    80003db4:	00813983          	ld	s3,8(sp)
    80003db8:	03010113          	addi	sp,sp,48
    80003dbc:	00008067          	ret

0000000080003dc0 <uartputc_sync>:
    80003dc0:	ff010113          	addi	sp,sp,-16
    80003dc4:	00813423          	sd	s0,8(sp)
    80003dc8:	01010413          	addi	s0,sp,16
    80003dcc:	00002717          	auipc	a4,0x2
    80003dd0:	8a872703          	lw	a4,-1880(a4) # 80005674 <panicked>
    80003dd4:	02071663          	bnez	a4,80003e00 <uartputc_sync+0x40>
    80003dd8:	00050793          	mv	a5,a0
    80003ddc:	100006b7          	lui	a3,0x10000
    80003de0:	0056c703          	lbu	a4,5(a3) # 10000005 <_entry-0x6ffffffb>
    80003de4:	02077713          	andi	a4,a4,32
    80003de8:	fe070ce3          	beqz	a4,80003de0 <uartputc_sync+0x20>
    80003dec:	0ff7f793          	andi	a5,a5,255
    80003df0:	00f68023          	sb	a5,0(a3)
    80003df4:	00813403          	ld	s0,8(sp)
    80003df8:	01010113          	addi	sp,sp,16
    80003dfc:	00008067          	ret
    80003e00:	0000006f          	j	80003e00 <uartputc_sync+0x40>

0000000080003e04 <uartstart>:
    80003e04:	ff010113          	addi	sp,sp,-16
    80003e08:	00813423          	sd	s0,8(sp)
    80003e0c:	01010413          	addi	s0,sp,16
    80003e10:	00002617          	auipc	a2,0x2
    80003e14:	86860613          	addi	a2,a2,-1944 # 80005678 <uart_tx_r>
    80003e18:	00002517          	auipc	a0,0x2
    80003e1c:	86850513          	addi	a0,a0,-1944 # 80005680 <uart_tx_w>
    80003e20:	00063783          	ld	a5,0(a2)
    80003e24:	00053703          	ld	a4,0(a0)
    80003e28:	04f70263          	beq	a4,a5,80003e6c <uartstart+0x68>
    80003e2c:	100005b7          	lui	a1,0x10000
    80003e30:	00006817          	auipc	a6,0x6
    80003e34:	ad080813          	addi	a6,a6,-1328 # 80009900 <uart_tx_buf>
    80003e38:	01c0006f          	j	80003e54 <uartstart+0x50>
    80003e3c:	0006c703          	lbu	a4,0(a3)
    80003e40:	00f63023          	sd	a5,0(a2)
    80003e44:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    80003e48:	00063783          	ld	a5,0(a2)
    80003e4c:	00053703          	ld	a4,0(a0)
    80003e50:	00f70e63          	beq	a4,a5,80003e6c <uartstart+0x68>
    80003e54:	01f7f713          	andi	a4,a5,31
    80003e58:	00e806b3          	add	a3,a6,a4
    80003e5c:	0055c703          	lbu	a4,5(a1)
    80003e60:	00178793          	addi	a5,a5,1
    80003e64:	02077713          	andi	a4,a4,32
    80003e68:	fc071ae3          	bnez	a4,80003e3c <uartstart+0x38>
    80003e6c:	00813403          	ld	s0,8(sp)
    80003e70:	01010113          	addi	sp,sp,16
    80003e74:	00008067          	ret

0000000080003e78 <uartgetc>:
    80003e78:	ff010113          	addi	sp,sp,-16
    80003e7c:	00813423          	sd	s0,8(sp)
    80003e80:	01010413          	addi	s0,sp,16
    80003e84:	10000737          	lui	a4,0x10000
    80003e88:	00574783          	lbu	a5,5(a4) # 10000005 <_entry-0x6ffffffb>
    80003e8c:	0017f793          	andi	a5,a5,1
    80003e90:	00078c63          	beqz	a5,80003ea8 <uartgetc+0x30>
    80003e94:	00074503          	lbu	a0,0(a4)
    80003e98:	0ff57513          	andi	a0,a0,255
    80003e9c:	00813403          	ld	s0,8(sp)
    80003ea0:	01010113          	addi	sp,sp,16
    80003ea4:	00008067          	ret
    80003ea8:	fff00513          	li	a0,-1
    80003eac:	ff1ff06f          	j	80003e9c <uartgetc+0x24>

0000000080003eb0 <uartintr>:
    80003eb0:	100007b7          	lui	a5,0x10000
    80003eb4:	0057c783          	lbu	a5,5(a5) # 10000005 <_entry-0x6ffffffb>
    80003eb8:	0017f793          	andi	a5,a5,1
    80003ebc:	0a078463          	beqz	a5,80003f64 <uartintr+0xb4>
    80003ec0:	fe010113          	addi	sp,sp,-32
    80003ec4:	00813823          	sd	s0,16(sp)
    80003ec8:	00913423          	sd	s1,8(sp)
    80003ecc:	00113c23          	sd	ra,24(sp)
    80003ed0:	02010413          	addi	s0,sp,32
    80003ed4:	100004b7          	lui	s1,0x10000
    80003ed8:	0004c503          	lbu	a0,0(s1) # 10000000 <_entry-0x70000000>
    80003edc:	0ff57513          	andi	a0,a0,255
    80003ee0:	fffff097          	auipc	ra,0xfffff
    80003ee4:	534080e7          	jalr	1332(ra) # 80003414 <consoleintr>
    80003ee8:	0054c783          	lbu	a5,5(s1)
    80003eec:	0017f793          	andi	a5,a5,1
    80003ef0:	fe0794e3          	bnez	a5,80003ed8 <uartintr+0x28>
    80003ef4:	00001617          	auipc	a2,0x1
    80003ef8:	78460613          	addi	a2,a2,1924 # 80005678 <uart_tx_r>
    80003efc:	00001517          	auipc	a0,0x1
    80003f00:	78450513          	addi	a0,a0,1924 # 80005680 <uart_tx_w>
    80003f04:	00063783          	ld	a5,0(a2)
    80003f08:	00053703          	ld	a4,0(a0)
    80003f0c:	04f70263          	beq	a4,a5,80003f50 <uartintr+0xa0>
    80003f10:	100005b7          	lui	a1,0x10000
    80003f14:	00006817          	auipc	a6,0x6
    80003f18:	9ec80813          	addi	a6,a6,-1556 # 80009900 <uart_tx_buf>
    80003f1c:	01c0006f          	j	80003f38 <uartintr+0x88>
    80003f20:	0006c703          	lbu	a4,0(a3)
    80003f24:	00f63023          	sd	a5,0(a2)
    80003f28:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    80003f2c:	00063783          	ld	a5,0(a2)
    80003f30:	00053703          	ld	a4,0(a0)
    80003f34:	00f70e63          	beq	a4,a5,80003f50 <uartintr+0xa0>
    80003f38:	01f7f713          	andi	a4,a5,31
    80003f3c:	00e806b3          	add	a3,a6,a4
    80003f40:	0055c703          	lbu	a4,5(a1)
    80003f44:	00178793          	addi	a5,a5,1
    80003f48:	02077713          	andi	a4,a4,32
    80003f4c:	fc071ae3          	bnez	a4,80003f20 <uartintr+0x70>
    80003f50:	01813083          	ld	ra,24(sp)
    80003f54:	01013403          	ld	s0,16(sp)
    80003f58:	00813483          	ld	s1,8(sp)
    80003f5c:	02010113          	addi	sp,sp,32
    80003f60:	00008067          	ret
    80003f64:	00001617          	auipc	a2,0x1
    80003f68:	71460613          	addi	a2,a2,1812 # 80005678 <uart_tx_r>
    80003f6c:	00001517          	auipc	a0,0x1
    80003f70:	71450513          	addi	a0,a0,1812 # 80005680 <uart_tx_w>
    80003f74:	00063783          	ld	a5,0(a2)
    80003f78:	00053703          	ld	a4,0(a0)
    80003f7c:	04f70263          	beq	a4,a5,80003fc0 <uartintr+0x110>
    80003f80:	100005b7          	lui	a1,0x10000
    80003f84:	00006817          	auipc	a6,0x6
    80003f88:	97c80813          	addi	a6,a6,-1668 # 80009900 <uart_tx_buf>
    80003f8c:	01c0006f          	j	80003fa8 <uartintr+0xf8>
    80003f90:	0006c703          	lbu	a4,0(a3)
    80003f94:	00f63023          	sd	a5,0(a2)
    80003f98:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    80003f9c:	00063783          	ld	a5,0(a2)
    80003fa0:	00053703          	ld	a4,0(a0)
    80003fa4:	02f70063          	beq	a4,a5,80003fc4 <uartintr+0x114>
    80003fa8:	01f7f713          	andi	a4,a5,31
    80003fac:	00e806b3          	add	a3,a6,a4
    80003fb0:	0055c703          	lbu	a4,5(a1)
    80003fb4:	00178793          	addi	a5,a5,1
    80003fb8:	02077713          	andi	a4,a4,32
    80003fbc:	fc071ae3          	bnez	a4,80003f90 <uartintr+0xe0>
    80003fc0:	00008067          	ret
    80003fc4:	00008067          	ret

0000000080003fc8 <kinit>:
    80003fc8:	fc010113          	addi	sp,sp,-64
    80003fcc:	02913423          	sd	s1,40(sp)
    80003fd0:	fffff7b7          	lui	a5,0xfffff
    80003fd4:	00007497          	auipc	s1,0x7
    80003fd8:	94b48493          	addi	s1,s1,-1717 # 8000a91f <end+0xfff>
    80003fdc:	02813823          	sd	s0,48(sp)
    80003fe0:	01313c23          	sd	s3,24(sp)
    80003fe4:	00f4f4b3          	and	s1,s1,a5
    80003fe8:	02113c23          	sd	ra,56(sp)
    80003fec:	03213023          	sd	s2,32(sp)
    80003ff0:	01413823          	sd	s4,16(sp)
    80003ff4:	01513423          	sd	s5,8(sp)
    80003ff8:	04010413          	addi	s0,sp,64
    80003ffc:	000017b7          	lui	a5,0x1
    80004000:	01100993          	li	s3,17
    80004004:	00f487b3          	add	a5,s1,a5
    80004008:	01b99993          	slli	s3,s3,0x1b
    8000400c:	06f9e063          	bltu	s3,a5,8000406c <kinit+0xa4>
    80004010:	00006a97          	auipc	s5,0x6
    80004014:	910a8a93          	addi	s5,s5,-1776 # 80009920 <end>
    80004018:	0754ec63          	bltu	s1,s5,80004090 <kinit+0xc8>
    8000401c:	0734fa63          	bgeu	s1,s3,80004090 <kinit+0xc8>
    80004020:	00088a37          	lui	s4,0x88
    80004024:	fffa0a13          	addi	s4,s4,-1 # 87fff <_entry-0x7ff78001>
    80004028:	00001917          	auipc	s2,0x1
    8000402c:	66090913          	addi	s2,s2,1632 # 80005688 <kmem>
    80004030:	00ca1a13          	slli	s4,s4,0xc
    80004034:	0140006f          	j	80004048 <kinit+0x80>
    80004038:	000017b7          	lui	a5,0x1
    8000403c:	00f484b3          	add	s1,s1,a5
    80004040:	0554e863          	bltu	s1,s5,80004090 <kinit+0xc8>
    80004044:	0534f663          	bgeu	s1,s3,80004090 <kinit+0xc8>
    80004048:	00001637          	lui	a2,0x1
    8000404c:	00100593          	li	a1,1
    80004050:	00048513          	mv	a0,s1
    80004054:	00000097          	auipc	ra,0x0
    80004058:	5e4080e7          	jalr	1508(ra) # 80004638 <__memset>
    8000405c:	00093783          	ld	a5,0(s2)
    80004060:	00f4b023          	sd	a5,0(s1)
    80004064:	00993023          	sd	s1,0(s2)
    80004068:	fd4498e3          	bne	s1,s4,80004038 <kinit+0x70>
    8000406c:	03813083          	ld	ra,56(sp)
    80004070:	03013403          	ld	s0,48(sp)
    80004074:	02813483          	ld	s1,40(sp)
    80004078:	02013903          	ld	s2,32(sp)
    8000407c:	01813983          	ld	s3,24(sp)
    80004080:	01013a03          	ld	s4,16(sp)
    80004084:	00813a83          	ld	s5,8(sp)
    80004088:	04010113          	addi	sp,sp,64
    8000408c:	00008067          	ret
    80004090:	00001517          	auipc	a0,0x1
    80004094:	1c850513          	addi	a0,a0,456 # 80005258 <digits+0x18>
    80004098:	fffff097          	auipc	ra,0xfffff
    8000409c:	4b4080e7          	jalr	1204(ra) # 8000354c <panic>

00000000800040a0 <freerange>:
    800040a0:	fc010113          	addi	sp,sp,-64
    800040a4:	000017b7          	lui	a5,0x1
    800040a8:	02913423          	sd	s1,40(sp)
    800040ac:	fff78493          	addi	s1,a5,-1 # fff <_entry-0x7ffff001>
    800040b0:	009504b3          	add	s1,a0,s1
    800040b4:	fffff537          	lui	a0,0xfffff
    800040b8:	02813823          	sd	s0,48(sp)
    800040bc:	02113c23          	sd	ra,56(sp)
    800040c0:	03213023          	sd	s2,32(sp)
    800040c4:	01313c23          	sd	s3,24(sp)
    800040c8:	01413823          	sd	s4,16(sp)
    800040cc:	01513423          	sd	s5,8(sp)
    800040d0:	01613023          	sd	s6,0(sp)
    800040d4:	04010413          	addi	s0,sp,64
    800040d8:	00a4f4b3          	and	s1,s1,a0
    800040dc:	00f487b3          	add	a5,s1,a5
    800040e0:	06f5e463          	bltu	a1,a5,80004148 <freerange+0xa8>
    800040e4:	00006a97          	auipc	s5,0x6
    800040e8:	83ca8a93          	addi	s5,s5,-1988 # 80009920 <end>
    800040ec:	0954e263          	bltu	s1,s5,80004170 <freerange+0xd0>
    800040f0:	01100993          	li	s3,17
    800040f4:	01b99993          	slli	s3,s3,0x1b
    800040f8:	0734fc63          	bgeu	s1,s3,80004170 <freerange+0xd0>
    800040fc:	00058a13          	mv	s4,a1
    80004100:	00001917          	auipc	s2,0x1
    80004104:	58890913          	addi	s2,s2,1416 # 80005688 <kmem>
    80004108:	00002b37          	lui	s6,0x2
    8000410c:	0140006f          	j	80004120 <freerange+0x80>
    80004110:	000017b7          	lui	a5,0x1
    80004114:	00f484b3          	add	s1,s1,a5
    80004118:	0554ec63          	bltu	s1,s5,80004170 <freerange+0xd0>
    8000411c:	0534fa63          	bgeu	s1,s3,80004170 <freerange+0xd0>
    80004120:	00001637          	lui	a2,0x1
    80004124:	00100593          	li	a1,1
    80004128:	00048513          	mv	a0,s1
    8000412c:	00000097          	auipc	ra,0x0
    80004130:	50c080e7          	jalr	1292(ra) # 80004638 <__memset>
    80004134:	00093703          	ld	a4,0(s2)
    80004138:	016487b3          	add	a5,s1,s6
    8000413c:	00e4b023          	sd	a4,0(s1)
    80004140:	00993023          	sd	s1,0(s2)
    80004144:	fcfa76e3          	bgeu	s4,a5,80004110 <freerange+0x70>
    80004148:	03813083          	ld	ra,56(sp)
    8000414c:	03013403          	ld	s0,48(sp)
    80004150:	02813483          	ld	s1,40(sp)
    80004154:	02013903          	ld	s2,32(sp)
    80004158:	01813983          	ld	s3,24(sp)
    8000415c:	01013a03          	ld	s4,16(sp)
    80004160:	00813a83          	ld	s5,8(sp)
    80004164:	00013b03          	ld	s6,0(sp)
    80004168:	04010113          	addi	sp,sp,64
    8000416c:	00008067          	ret
    80004170:	00001517          	auipc	a0,0x1
    80004174:	0e850513          	addi	a0,a0,232 # 80005258 <digits+0x18>
    80004178:	fffff097          	auipc	ra,0xfffff
    8000417c:	3d4080e7          	jalr	980(ra) # 8000354c <panic>

0000000080004180 <kfree>:
    80004180:	fe010113          	addi	sp,sp,-32
    80004184:	00813823          	sd	s0,16(sp)
    80004188:	00113c23          	sd	ra,24(sp)
    8000418c:	00913423          	sd	s1,8(sp)
    80004190:	02010413          	addi	s0,sp,32
    80004194:	03451793          	slli	a5,a0,0x34
    80004198:	04079c63          	bnez	a5,800041f0 <kfree+0x70>
    8000419c:	00005797          	auipc	a5,0x5
    800041a0:	78478793          	addi	a5,a5,1924 # 80009920 <end>
    800041a4:	00050493          	mv	s1,a0
    800041a8:	04f56463          	bltu	a0,a5,800041f0 <kfree+0x70>
    800041ac:	01100793          	li	a5,17
    800041b0:	01b79793          	slli	a5,a5,0x1b
    800041b4:	02f57e63          	bgeu	a0,a5,800041f0 <kfree+0x70>
    800041b8:	00001637          	lui	a2,0x1
    800041bc:	00100593          	li	a1,1
    800041c0:	00000097          	auipc	ra,0x0
    800041c4:	478080e7          	jalr	1144(ra) # 80004638 <__memset>
    800041c8:	00001797          	auipc	a5,0x1
    800041cc:	4c078793          	addi	a5,a5,1216 # 80005688 <kmem>
    800041d0:	0007b703          	ld	a4,0(a5)
    800041d4:	01813083          	ld	ra,24(sp)
    800041d8:	01013403          	ld	s0,16(sp)
    800041dc:	00e4b023          	sd	a4,0(s1)
    800041e0:	0097b023          	sd	s1,0(a5)
    800041e4:	00813483          	ld	s1,8(sp)
    800041e8:	02010113          	addi	sp,sp,32
    800041ec:	00008067          	ret
    800041f0:	00001517          	auipc	a0,0x1
    800041f4:	06850513          	addi	a0,a0,104 # 80005258 <digits+0x18>
    800041f8:	fffff097          	auipc	ra,0xfffff
    800041fc:	354080e7          	jalr	852(ra) # 8000354c <panic>

0000000080004200 <kalloc>:
    80004200:	fe010113          	addi	sp,sp,-32
    80004204:	00813823          	sd	s0,16(sp)
    80004208:	00913423          	sd	s1,8(sp)
    8000420c:	00113c23          	sd	ra,24(sp)
    80004210:	02010413          	addi	s0,sp,32
    80004214:	00001797          	auipc	a5,0x1
    80004218:	47478793          	addi	a5,a5,1140 # 80005688 <kmem>
    8000421c:	0007b483          	ld	s1,0(a5)
    80004220:	02048063          	beqz	s1,80004240 <kalloc+0x40>
    80004224:	0004b703          	ld	a4,0(s1)
    80004228:	00001637          	lui	a2,0x1
    8000422c:	00500593          	li	a1,5
    80004230:	00048513          	mv	a0,s1
    80004234:	00e7b023          	sd	a4,0(a5)
    80004238:	00000097          	auipc	ra,0x0
    8000423c:	400080e7          	jalr	1024(ra) # 80004638 <__memset>
    80004240:	01813083          	ld	ra,24(sp)
    80004244:	01013403          	ld	s0,16(sp)
    80004248:	00048513          	mv	a0,s1
    8000424c:	00813483          	ld	s1,8(sp)
    80004250:	02010113          	addi	sp,sp,32
    80004254:	00008067          	ret

0000000080004258 <initlock>:
    80004258:	ff010113          	addi	sp,sp,-16
    8000425c:	00813423          	sd	s0,8(sp)
    80004260:	01010413          	addi	s0,sp,16
    80004264:	00813403          	ld	s0,8(sp)
    80004268:	00b53423          	sd	a1,8(a0)
    8000426c:	00052023          	sw	zero,0(a0)
    80004270:	00053823          	sd	zero,16(a0)
    80004274:	01010113          	addi	sp,sp,16
    80004278:	00008067          	ret

000000008000427c <acquire>:
    8000427c:	fe010113          	addi	sp,sp,-32
    80004280:	00813823          	sd	s0,16(sp)
    80004284:	00913423          	sd	s1,8(sp)
    80004288:	00113c23          	sd	ra,24(sp)
    8000428c:	01213023          	sd	s2,0(sp)
    80004290:	02010413          	addi	s0,sp,32
    80004294:	00050493          	mv	s1,a0
    80004298:	10002973          	csrr	s2,sstatus
    8000429c:	100027f3          	csrr	a5,sstatus
    800042a0:	ffd7f793          	andi	a5,a5,-3
    800042a4:	10079073          	csrw	sstatus,a5
    800042a8:	fffff097          	auipc	ra,0xfffff
    800042ac:	8ec080e7          	jalr	-1812(ra) # 80002b94 <mycpu>
    800042b0:	07852783          	lw	a5,120(a0)
    800042b4:	06078e63          	beqz	a5,80004330 <acquire+0xb4>
    800042b8:	fffff097          	auipc	ra,0xfffff
    800042bc:	8dc080e7          	jalr	-1828(ra) # 80002b94 <mycpu>
    800042c0:	07852783          	lw	a5,120(a0)
    800042c4:	0004a703          	lw	a4,0(s1)
    800042c8:	0017879b          	addiw	a5,a5,1
    800042cc:	06f52c23          	sw	a5,120(a0)
    800042d0:	04071063          	bnez	a4,80004310 <acquire+0x94>
    800042d4:	00100713          	li	a4,1
    800042d8:	00070793          	mv	a5,a4
    800042dc:	0cf4a7af          	amoswap.w.aq	a5,a5,(s1)
    800042e0:	0007879b          	sext.w	a5,a5
    800042e4:	fe079ae3          	bnez	a5,800042d8 <acquire+0x5c>
    800042e8:	0ff0000f          	fence
    800042ec:	fffff097          	auipc	ra,0xfffff
    800042f0:	8a8080e7          	jalr	-1880(ra) # 80002b94 <mycpu>
    800042f4:	01813083          	ld	ra,24(sp)
    800042f8:	01013403          	ld	s0,16(sp)
    800042fc:	00a4b823          	sd	a0,16(s1)
    80004300:	00013903          	ld	s2,0(sp)
    80004304:	00813483          	ld	s1,8(sp)
    80004308:	02010113          	addi	sp,sp,32
    8000430c:	00008067          	ret
    80004310:	0104b903          	ld	s2,16(s1)
    80004314:	fffff097          	auipc	ra,0xfffff
    80004318:	880080e7          	jalr	-1920(ra) # 80002b94 <mycpu>
    8000431c:	faa91ce3          	bne	s2,a0,800042d4 <acquire+0x58>
    80004320:	00001517          	auipc	a0,0x1
    80004324:	f4050513          	addi	a0,a0,-192 # 80005260 <digits+0x20>
    80004328:	fffff097          	auipc	ra,0xfffff
    8000432c:	224080e7          	jalr	548(ra) # 8000354c <panic>
    80004330:	00195913          	srli	s2,s2,0x1
    80004334:	fffff097          	auipc	ra,0xfffff
    80004338:	860080e7          	jalr	-1952(ra) # 80002b94 <mycpu>
    8000433c:	00197913          	andi	s2,s2,1
    80004340:	07252e23          	sw	s2,124(a0)
    80004344:	f75ff06f          	j	800042b8 <acquire+0x3c>

0000000080004348 <release>:
    80004348:	fe010113          	addi	sp,sp,-32
    8000434c:	00813823          	sd	s0,16(sp)
    80004350:	00113c23          	sd	ra,24(sp)
    80004354:	00913423          	sd	s1,8(sp)
    80004358:	01213023          	sd	s2,0(sp)
    8000435c:	02010413          	addi	s0,sp,32
    80004360:	00052783          	lw	a5,0(a0)
    80004364:	00079a63          	bnez	a5,80004378 <release+0x30>
    80004368:	00001517          	auipc	a0,0x1
    8000436c:	f0050513          	addi	a0,a0,-256 # 80005268 <digits+0x28>
    80004370:	fffff097          	auipc	ra,0xfffff
    80004374:	1dc080e7          	jalr	476(ra) # 8000354c <panic>
    80004378:	01053903          	ld	s2,16(a0)
    8000437c:	00050493          	mv	s1,a0
    80004380:	fffff097          	auipc	ra,0xfffff
    80004384:	814080e7          	jalr	-2028(ra) # 80002b94 <mycpu>
    80004388:	fea910e3          	bne	s2,a0,80004368 <release+0x20>
    8000438c:	0004b823          	sd	zero,16(s1)
    80004390:	0ff0000f          	fence
    80004394:	0f50000f          	fence	iorw,ow
    80004398:	0804a02f          	amoswap.w	zero,zero,(s1)
    8000439c:	ffffe097          	auipc	ra,0xffffe
    800043a0:	7f8080e7          	jalr	2040(ra) # 80002b94 <mycpu>
    800043a4:	100027f3          	csrr	a5,sstatus
    800043a8:	0027f793          	andi	a5,a5,2
    800043ac:	04079a63          	bnez	a5,80004400 <release+0xb8>
    800043b0:	07852783          	lw	a5,120(a0)
    800043b4:	02f05e63          	blez	a5,800043f0 <release+0xa8>
    800043b8:	fff7871b          	addiw	a4,a5,-1
    800043bc:	06e52c23          	sw	a4,120(a0)
    800043c0:	00071c63          	bnez	a4,800043d8 <release+0x90>
    800043c4:	07c52783          	lw	a5,124(a0)
    800043c8:	00078863          	beqz	a5,800043d8 <release+0x90>
    800043cc:	100027f3          	csrr	a5,sstatus
    800043d0:	0027e793          	ori	a5,a5,2
    800043d4:	10079073          	csrw	sstatus,a5
    800043d8:	01813083          	ld	ra,24(sp)
    800043dc:	01013403          	ld	s0,16(sp)
    800043e0:	00813483          	ld	s1,8(sp)
    800043e4:	00013903          	ld	s2,0(sp)
    800043e8:	02010113          	addi	sp,sp,32
    800043ec:	00008067          	ret
    800043f0:	00001517          	auipc	a0,0x1
    800043f4:	e9850513          	addi	a0,a0,-360 # 80005288 <digits+0x48>
    800043f8:	fffff097          	auipc	ra,0xfffff
    800043fc:	154080e7          	jalr	340(ra) # 8000354c <panic>
    80004400:	00001517          	auipc	a0,0x1
    80004404:	e7050513          	addi	a0,a0,-400 # 80005270 <digits+0x30>
    80004408:	fffff097          	auipc	ra,0xfffff
    8000440c:	144080e7          	jalr	324(ra) # 8000354c <panic>

0000000080004410 <holding>:
    80004410:	00052783          	lw	a5,0(a0)
    80004414:	00079663          	bnez	a5,80004420 <holding+0x10>
    80004418:	00000513          	li	a0,0
    8000441c:	00008067          	ret
    80004420:	fe010113          	addi	sp,sp,-32
    80004424:	00813823          	sd	s0,16(sp)
    80004428:	00913423          	sd	s1,8(sp)
    8000442c:	00113c23          	sd	ra,24(sp)
    80004430:	02010413          	addi	s0,sp,32
    80004434:	01053483          	ld	s1,16(a0)
    80004438:	ffffe097          	auipc	ra,0xffffe
    8000443c:	75c080e7          	jalr	1884(ra) # 80002b94 <mycpu>
    80004440:	01813083          	ld	ra,24(sp)
    80004444:	01013403          	ld	s0,16(sp)
    80004448:	40a48533          	sub	a0,s1,a0
    8000444c:	00153513          	seqz	a0,a0
    80004450:	00813483          	ld	s1,8(sp)
    80004454:	02010113          	addi	sp,sp,32
    80004458:	00008067          	ret

000000008000445c <push_off>:
    8000445c:	fe010113          	addi	sp,sp,-32
    80004460:	00813823          	sd	s0,16(sp)
    80004464:	00113c23          	sd	ra,24(sp)
    80004468:	00913423          	sd	s1,8(sp)
    8000446c:	02010413          	addi	s0,sp,32
    80004470:	100024f3          	csrr	s1,sstatus
    80004474:	100027f3          	csrr	a5,sstatus
    80004478:	ffd7f793          	andi	a5,a5,-3
    8000447c:	10079073          	csrw	sstatus,a5
    80004480:	ffffe097          	auipc	ra,0xffffe
    80004484:	714080e7          	jalr	1812(ra) # 80002b94 <mycpu>
    80004488:	07852783          	lw	a5,120(a0)
    8000448c:	02078663          	beqz	a5,800044b8 <push_off+0x5c>
    80004490:	ffffe097          	auipc	ra,0xffffe
    80004494:	704080e7          	jalr	1796(ra) # 80002b94 <mycpu>
    80004498:	07852783          	lw	a5,120(a0)
    8000449c:	01813083          	ld	ra,24(sp)
    800044a0:	01013403          	ld	s0,16(sp)
    800044a4:	0017879b          	addiw	a5,a5,1
    800044a8:	06f52c23          	sw	a5,120(a0)
    800044ac:	00813483          	ld	s1,8(sp)
    800044b0:	02010113          	addi	sp,sp,32
    800044b4:	00008067          	ret
    800044b8:	0014d493          	srli	s1,s1,0x1
    800044bc:	ffffe097          	auipc	ra,0xffffe
    800044c0:	6d8080e7          	jalr	1752(ra) # 80002b94 <mycpu>
    800044c4:	0014f493          	andi	s1,s1,1
    800044c8:	06952e23          	sw	s1,124(a0)
    800044cc:	fc5ff06f          	j	80004490 <push_off+0x34>

00000000800044d0 <pop_off>:
    800044d0:	ff010113          	addi	sp,sp,-16
    800044d4:	00813023          	sd	s0,0(sp)
    800044d8:	00113423          	sd	ra,8(sp)
    800044dc:	01010413          	addi	s0,sp,16
    800044e0:	ffffe097          	auipc	ra,0xffffe
    800044e4:	6b4080e7          	jalr	1716(ra) # 80002b94 <mycpu>
    800044e8:	100027f3          	csrr	a5,sstatus
    800044ec:	0027f793          	andi	a5,a5,2
    800044f0:	04079663          	bnez	a5,8000453c <pop_off+0x6c>
    800044f4:	07852783          	lw	a5,120(a0)
    800044f8:	02f05a63          	blez	a5,8000452c <pop_off+0x5c>
    800044fc:	fff7871b          	addiw	a4,a5,-1
    80004500:	06e52c23          	sw	a4,120(a0)
    80004504:	00071c63          	bnez	a4,8000451c <pop_off+0x4c>
    80004508:	07c52783          	lw	a5,124(a0)
    8000450c:	00078863          	beqz	a5,8000451c <pop_off+0x4c>
    80004510:	100027f3          	csrr	a5,sstatus
    80004514:	0027e793          	ori	a5,a5,2
    80004518:	10079073          	csrw	sstatus,a5
    8000451c:	00813083          	ld	ra,8(sp)
    80004520:	00013403          	ld	s0,0(sp)
    80004524:	01010113          	addi	sp,sp,16
    80004528:	00008067          	ret
    8000452c:	00001517          	auipc	a0,0x1
    80004530:	d5c50513          	addi	a0,a0,-676 # 80005288 <digits+0x48>
    80004534:	fffff097          	auipc	ra,0xfffff
    80004538:	018080e7          	jalr	24(ra) # 8000354c <panic>
    8000453c:	00001517          	auipc	a0,0x1
    80004540:	d3450513          	addi	a0,a0,-716 # 80005270 <digits+0x30>
    80004544:	fffff097          	auipc	ra,0xfffff
    80004548:	008080e7          	jalr	8(ra) # 8000354c <panic>

000000008000454c <push_on>:
    8000454c:	fe010113          	addi	sp,sp,-32
    80004550:	00813823          	sd	s0,16(sp)
    80004554:	00113c23          	sd	ra,24(sp)
    80004558:	00913423          	sd	s1,8(sp)
    8000455c:	02010413          	addi	s0,sp,32
    80004560:	100024f3          	csrr	s1,sstatus
    80004564:	100027f3          	csrr	a5,sstatus
    80004568:	0027e793          	ori	a5,a5,2
    8000456c:	10079073          	csrw	sstatus,a5
    80004570:	ffffe097          	auipc	ra,0xffffe
    80004574:	624080e7          	jalr	1572(ra) # 80002b94 <mycpu>
    80004578:	07852783          	lw	a5,120(a0)
    8000457c:	02078663          	beqz	a5,800045a8 <push_on+0x5c>
    80004580:	ffffe097          	auipc	ra,0xffffe
    80004584:	614080e7          	jalr	1556(ra) # 80002b94 <mycpu>
    80004588:	07852783          	lw	a5,120(a0)
    8000458c:	01813083          	ld	ra,24(sp)
    80004590:	01013403          	ld	s0,16(sp)
    80004594:	0017879b          	addiw	a5,a5,1
    80004598:	06f52c23          	sw	a5,120(a0)
    8000459c:	00813483          	ld	s1,8(sp)
    800045a0:	02010113          	addi	sp,sp,32
    800045a4:	00008067          	ret
    800045a8:	0014d493          	srli	s1,s1,0x1
    800045ac:	ffffe097          	auipc	ra,0xffffe
    800045b0:	5e8080e7          	jalr	1512(ra) # 80002b94 <mycpu>
    800045b4:	0014f493          	andi	s1,s1,1
    800045b8:	06952e23          	sw	s1,124(a0)
    800045bc:	fc5ff06f          	j	80004580 <push_on+0x34>

00000000800045c0 <pop_on>:
    800045c0:	ff010113          	addi	sp,sp,-16
    800045c4:	00813023          	sd	s0,0(sp)
    800045c8:	00113423          	sd	ra,8(sp)
    800045cc:	01010413          	addi	s0,sp,16
    800045d0:	ffffe097          	auipc	ra,0xffffe
    800045d4:	5c4080e7          	jalr	1476(ra) # 80002b94 <mycpu>
    800045d8:	100027f3          	csrr	a5,sstatus
    800045dc:	0027f793          	andi	a5,a5,2
    800045e0:	04078463          	beqz	a5,80004628 <pop_on+0x68>
    800045e4:	07852783          	lw	a5,120(a0)
    800045e8:	02f05863          	blez	a5,80004618 <pop_on+0x58>
    800045ec:	fff7879b          	addiw	a5,a5,-1
    800045f0:	06f52c23          	sw	a5,120(a0)
    800045f4:	07853783          	ld	a5,120(a0)
    800045f8:	00079863          	bnez	a5,80004608 <pop_on+0x48>
    800045fc:	100027f3          	csrr	a5,sstatus
    80004600:	ffd7f793          	andi	a5,a5,-3
    80004604:	10079073          	csrw	sstatus,a5
    80004608:	00813083          	ld	ra,8(sp)
    8000460c:	00013403          	ld	s0,0(sp)
    80004610:	01010113          	addi	sp,sp,16
    80004614:	00008067          	ret
    80004618:	00001517          	auipc	a0,0x1
    8000461c:	c9850513          	addi	a0,a0,-872 # 800052b0 <digits+0x70>
    80004620:	fffff097          	auipc	ra,0xfffff
    80004624:	f2c080e7          	jalr	-212(ra) # 8000354c <panic>
    80004628:	00001517          	auipc	a0,0x1
    8000462c:	c6850513          	addi	a0,a0,-920 # 80005290 <digits+0x50>
    80004630:	fffff097          	auipc	ra,0xfffff
    80004634:	f1c080e7          	jalr	-228(ra) # 8000354c <panic>

0000000080004638 <__memset>:
    80004638:	ff010113          	addi	sp,sp,-16
    8000463c:	00813423          	sd	s0,8(sp)
    80004640:	01010413          	addi	s0,sp,16
    80004644:	1a060e63          	beqz	a2,80004800 <__memset+0x1c8>
    80004648:	40a007b3          	neg	a5,a0
    8000464c:	0077f793          	andi	a5,a5,7
    80004650:	00778693          	addi	a3,a5,7
    80004654:	00b00813          	li	a6,11
    80004658:	0ff5f593          	andi	a1,a1,255
    8000465c:	fff6071b          	addiw	a4,a2,-1
    80004660:	1b06e663          	bltu	a3,a6,8000480c <__memset+0x1d4>
    80004664:	1cd76463          	bltu	a4,a3,8000482c <__memset+0x1f4>
    80004668:	1a078e63          	beqz	a5,80004824 <__memset+0x1ec>
    8000466c:	00b50023          	sb	a1,0(a0)
    80004670:	00100713          	li	a4,1
    80004674:	1ae78463          	beq	a5,a4,8000481c <__memset+0x1e4>
    80004678:	00b500a3          	sb	a1,1(a0)
    8000467c:	00200713          	li	a4,2
    80004680:	1ae78a63          	beq	a5,a4,80004834 <__memset+0x1fc>
    80004684:	00b50123          	sb	a1,2(a0)
    80004688:	00300713          	li	a4,3
    8000468c:	18e78463          	beq	a5,a4,80004814 <__memset+0x1dc>
    80004690:	00b501a3          	sb	a1,3(a0)
    80004694:	00400713          	li	a4,4
    80004698:	1ae78263          	beq	a5,a4,8000483c <__memset+0x204>
    8000469c:	00b50223          	sb	a1,4(a0)
    800046a0:	00500713          	li	a4,5
    800046a4:	1ae78063          	beq	a5,a4,80004844 <__memset+0x20c>
    800046a8:	00b502a3          	sb	a1,5(a0)
    800046ac:	00700713          	li	a4,7
    800046b0:	18e79e63          	bne	a5,a4,8000484c <__memset+0x214>
    800046b4:	00b50323          	sb	a1,6(a0)
    800046b8:	00700e93          	li	t4,7
    800046bc:	00859713          	slli	a4,a1,0x8
    800046c0:	00e5e733          	or	a4,a1,a4
    800046c4:	01059e13          	slli	t3,a1,0x10
    800046c8:	01c76e33          	or	t3,a4,t3
    800046cc:	01859313          	slli	t1,a1,0x18
    800046d0:	006e6333          	or	t1,t3,t1
    800046d4:	02059893          	slli	a7,a1,0x20
    800046d8:	40f60e3b          	subw	t3,a2,a5
    800046dc:	011368b3          	or	a7,t1,a7
    800046e0:	02859813          	slli	a6,a1,0x28
    800046e4:	0108e833          	or	a6,a7,a6
    800046e8:	03059693          	slli	a3,a1,0x30
    800046ec:	003e589b          	srliw	a7,t3,0x3
    800046f0:	00d866b3          	or	a3,a6,a3
    800046f4:	03859713          	slli	a4,a1,0x38
    800046f8:	00389813          	slli	a6,a7,0x3
    800046fc:	00f507b3          	add	a5,a0,a5
    80004700:	00e6e733          	or	a4,a3,a4
    80004704:	000e089b          	sext.w	a7,t3
    80004708:	00f806b3          	add	a3,a6,a5
    8000470c:	00e7b023          	sd	a4,0(a5)
    80004710:	00878793          	addi	a5,a5,8
    80004714:	fed79ce3          	bne	a5,a3,8000470c <__memset+0xd4>
    80004718:	ff8e7793          	andi	a5,t3,-8
    8000471c:	0007871b          	sext.w	a4,a5
    80004720:	01d787bb          	addw	a5,a5,t4
    80004724:	0ce88e63          	beq	a7,a4,80004800 <__memset+0x1c8>
    80004728:	00f50733          	add	a4,a0,a5
    8000472c:	00b70023          	sb	a1,0(a4)
    80004730:	0017871b          	addiw	a4,a5,1
    80004734:	0cc77663          	bgeu	a4,a2,80004800 <__memset+0x1c8>
    80004738:	00e50733          	add	a4,a0,a4
    8000473c:	00b70023          	sb	a1,0(a4)
    80004740:	0027871b          	addiw	a4,a5,2
    80004744:	0ac77e63          	bgeu	a4,a2,80004800 <__memset+0x1c8>
    80004748:	00e50733          	add	a4,a0,a4
    8000474c:	00b70023          	sb	a1,0(a4)
    80004750:	0037871b          	addiw	a4,a5,3
    80004754:	0ac77663          	bgeu	a4,a2,80004800 <__memset+0x1c8>
    80004758:	00e50733          	add	a4,a0,a4
    8000475c:	00b70023          	sb	a1,0(a4)
    80004760:	0047871b          	addiw	a4,a5,4
    80004764:	08c77e63          	bgeu	a4,a2,80004800 <__memset+0x1c8>
    80004768:	00e50733          	add	a4,a0,a4
    8000476c:	00b70023          	sb	a1,0(a4)
    80004770:	0057871b          	addiw	a4,a5,5
    80004774:	08c77663          	bgeu	a4,a2,80004800 <__memset+0x1c8>
    80004778:	00e50733          	add	a4,a0,a4
    8000477c:	00b70023          	sb	a1,0(a4)
    80004780:	0067871b          	addiw	a4,a5,6
    80004784:	06c77e63          	bgeu	a4,a2,80004800 <__memset+0x1c8>
    80004788:	00e50733          	add	a4,a0,a4
    8000478c:	00b70023          	sb	a1,0(a4)
    80004790:	0077871b          	addiw	a4,a5,7
    80004794:	06c77663          	bgeu	a4,a2,80004800 <__memset+0x1c8>
    80004798:	00e50733          	add	a4,a0,a4
    8000479c:	00b70023          	sb	a1,0(a4)
    800047a0:	0087871b          	addiw	a4,a5,8
    800047a4:	04c77e63          	bgeu	a4,a2,80004800 <__memset+0x1c8>
    800047a8:	00e50733          	add	a4,a0,a4
    800047ac:	00b70023          	sb	a1,0(a4)
    800047b0:	0097871b          	addiw	a4,a5,9
    800047b4:	04c77663          	bgeu	a4,a2,80004800 <__memset+0x1c8>
    800047b8:	00e50733          	add	a4,a0,a4
    800047bc:	00b70023          	sb	a1,0(a4)
    800047c0:	00a7871b          	addiw	a4,a5,10
    800047c4:	02c77e63          	bgeu	a4,a2,80004800 <__memset+0x1c8>
    800047c8:	00e50733          	add	a4,a0,a4
    800047cc:	00b70023          	sb	a1,0(a4)
    800047d0:	00b7871b          	addiw	a4,a5,11
    800047d4:	02c77663          	bgeu	a4,a2,80004800 <__memset+0x1c8>
    800047d8:	00e50733          	add	a4,a0,a4
    800047dc:	00b70023          	sb	a1,0(a4)
    800047e0:	00c7871b          	addiw	a4,a5,12
    800047e4:	00c77e63          	bgeu	a4,a2,80004800 <__memset+0x1c8>
    800047e8:	00e50733          	add	a4,a0,a4
    800047ec:	00b70023          	sb	a1,0(a4)
    800047f0:	00d7879b          	addiw	a5,a5,13
    800047f4:	00c7f663          	bgeu	a5,a2,80004800 <__memset+0x1c8>
    800047f8:	00f507b3          	add	a5,a0,a5
    800047fc:	00b78023          	sb	a1,0(a5)
    80004800:	00813403          	ld	s0,8(sp)
    80004804:	01010113          	addi	sp,sp,16
    80004808:	00008067          	ret
    8000480c:	00b00693          	li	a3,11
    80004810:	e55ff06f          	j	80004664 <__memset+0x2c>
    80004814:	00300e93          	li	t4,3
    80004818:	ea5ff06f          	j	800046bc <__memset+0x84>
    8000481c:	00100e93          	li	t4,1
    80004820:	e9dff06f          	j	800046bc <__memset+0x84>
    80004824:	00000e93          	li	t4,0
    80004828:	e95ff06f          	j	800046bc <__memset+0x84>
    8000482c:	00000793          	li	a5,0
    80004830:	ef9ff06f          	j	80004728 <__memset+0xf0>
    80004834:	00200e93          	li	t4,2
    80004838:	e85ff06f          	j	800046bc <__memset+0x84>
    8000483c:	00400e93          	li	t4,4
    80004840:	e7dff06f          	j	800046bc <__memset+0x84>
    80004844:	00500e93          	li	t4,5
    80004848:	e75ff06f          	j	800046bc <__memset+0x84>
    8000484c:	00600e93          	li	t4,6
    80004850:	e6dff06f          	j	800046bc <__memset+0x84>

0000000080004854 <__memmove>:
    80004854:	ff010113          	addi	sp,sp,-16
    80004858:	00813423          	sd	s0,8(sp)
    8000485c:	01010413          	addi	s0,sp,16
    80004860:	0e060863          	beqz	a2,80004950 <__memmove+0xfc>
    80004864:	fff6069b          	addiw	a3,a2,-1
    80004868:	0006881b          	sext.w	a6,a3
    8000486c:	0ea5e863          	bltu	a1,a0,8000495c <__memmove+0x108>
    80004870:	00758713          	addi	a4,a1,7
    80004874:	00a5e7b3          	or	a5,a1,a0
    80004878:	40a70733          	sub	a4,a4,a0
    8000487c:	0077f793          	andi	a5,a5,7
    80004880:	00f73713          	sltiu	a4,a4,15
    80004884:	00174713          	xori	a4,a4,1
    80004888:	0017b793          	seqz	a5,a5
    8000488c:	00e7f7b3          	and	a5,a5,a4
    80004890:	10078863          	beqz	a5,800049a0 <__memmove+0x14c>
    80004894:	00900793          	li	a5,9
    80004898:	1107f463          	bgeu	a5,a6,800049a0 <__memmove+0x14c>
    8000489c:	0036581b          	srliw	a6,a2,0x3
    800048a0:	fff8081b          	addiw	a6,a6,-1
    800048a4:	02081813          	slli	a6,a6,0x20
    800048a8:	01d85893          	srli	a7,a6,0x1d
    800048ac:	00858813          	addi	a6,a1,8
    800048b0:	00058793          	mv	a5,a1
    800048b4:	00050713          	mv	a4,a0
    800048b8:	01088833          	add	a6,a7,a6
    800048bc:	0007b883          	ld	a7,0(a5)
    800048c0:	00878793          	addi	a5,a5,8
    800048c4:	00870713          	addi	a4,a4,8
    800048c8:	ff173c23          	sd	a7,-8(a4)
    800048cc:	ff0798e3          	bne	a5,a6,800048bc <__memmove+0x68>
    800048d0:	ff867713          	andi	a4,a2,-8
    800048d4:	02071793          	slli	a5,a4,0x20
    800048d8:	0207d793          	srli	a5,a5,0x20
    800048dc:	00f585b3          	add	a1,a1,a5
    800048e0:	40e686bb          	subw	a3,a3,a4
    800048e4:	00f507b3          	add	a5,a0,a5
    800048e8:	06e60463          	beq	a2,a4,80004950 <__memmove+0xfc>
    800048ec:	0005c703          	lbu	a4,0(a1)
    800048f0:	00e78023          	sb	a4,0(a5)
    800048f4:	04068e63          	beqz	a3,80004950 <__memmove+0xfc>
    800048f8:	0015c603          	lbu	a2,1(a1)
    800048fc:	00100713          	li	a4,1
    80004900:	00c780a3          	sb	a2,1(a5)
    80004904:	04e68663          	beq	a3,a4,80004950 <__memmove+0xfc>
    80004908:	0025c603          	lbu	a2,2(a1)
    8000490c:	00200713          	li	a4,2
    80004910:	00c78123          	sb	a2,2(a5)
    80004914:	02e68e63          	beq	a3,a4,80004950 <__memmove+0xfc>
    80004918:	0035c603          	lbu	a2,3(a1)
    8000491c:	00300713          	li	a4,3
    80004920:	00c781a3          	sb	a2,3(a5)
    80004924:	02e68663          	beq	a3,a4,80004950 <__memmove+0xfc>
    80004928:	0045c603          	lbu	a2,4(a1)
    8000492c:	00400713          	li	a4,4
    80004930:	00c78223          	sb	a2,4(a5)
    80004934:	00e68e63          	beq	a3,a4,80004950 <__memmove+0xfc>
    80004938:	0055c603          	lbu	a2,5(a1)
    8000493c:	00500713          	li	a4,5
    80004940:	00c782a3          	sb	a2,5(a5)
    80004944:	00e68663          	beq	a3,a4,80004950 <__memmove+0xfc>
    80004948:	0065c703          	lbu	a4,6(a1)
    8000494c:	00e78323          	sb	a4,6(a5)
    80004950:	00813403          	ld	s0,8(sp)
    80004954:	01010113          	addi	sp,sp,16
    80004958:	00008067          	ret
    8000495c:	02061713          	slli	a4,a2,0x20
    80004960:	02075713          	srli	a4,a4,0x20
    80004964:	00e587b3          	add	a5,a1,a4
    80004968:	f0f574e3          	bgeu	a0,a5,80004870 <__memmove+0x1c>
    8000496c:	02069613          	slli	a2,a3,0x20
    80004970:	02065613          	srli	a2,a2,0x20
    80004974:	fff64613          	not	a2,a2
    80004978:	00e50733          	add	a4,a0,a4
    8000497c:	00c78633          	add	a2,a5,a2
    80004980:	fff7c683          	lbu	a3,-1(a5)
    80004984:	fff78793          	addi	a5,a5,-1
    80004988:	fff70713          	addi	a4,a4,-1
    8000498c:	00d70023          	sb	a3,0(a4)
    80004990:	fec798e3          	bne	a5,a2,80004980 <__memmove+0x12c>
    80004994:	00813403          	ld	s0,8(sp)
    80004998:	01010113          	addi	sp,sp,16
    8000499c:	00008067          	ret
    800049a0:	02069713          	slli	a4,a3,0x20
    800049a4:	02075713          	srli	a4,a4,0x20
    800049a8:	00170713          	addi	a4,a4,1
    800049ac:	00e50733          	add	a4,a0,a4
    800049b0:	00050793          	mv	a5,a0
    800049b4:	0005c683          	lbu	a3,0(a1)
    800049b8:	00178793          	addi	a5,a5,1
    800049bc:	00158593          	addi	a1,a1,1
    800049c0:	fed78fa3          	sb	a3,-1(a5)
    800049c4:	fee798e3          	bne	a5,a4,800049b4 <__memmove+0x160>
    800049c8:	f89ff06f          	j	80004950 <__memmove+0xfc>

00000000800049cc <__putc>:
    800049cc:	fe010113          	addi	sp,sp,-32
    800049d0:	00813823          	sd	s0,16(sp)
    800049d4:	00113c23          	sd	ra,24(sp)
    800049d8:	02010413          	addi	s0,sp,32
    800049dc:	00050793          	mv	a5,a0
    800049e0:	fef40593          	addi	a1,s0,-17
    800049e4:	00100613          	li	a2,1
    800049e8:	00000513          	li	a0,0
    800049ec:	fef407a3          	sb	a5,-17(s0)
    800049f0:	fffff097          	auipc	ra,0xfffff
    800049f4:	b3c080e7          	jalr	-1220(ra) # 8000352c <console_write>
    800049f8:	01813083          	ld	ra,24(sp)
    800049fc:	01013403          	ld	s0,16(sp)
    80004a00:	02010113          	addi	sp,sp,32
    80004a04:	00008067          	ret

0000000080004a08 <__getc>:
    80004a08:	fe010113          	addi	sp,sp,-32
    80004a0c:	00813823          	sd	s0,16(sp)
    80004a10:	00113c23          	sd	ra,24(sp)
    80004a14:	02010413          	addi	s0,sp,32
    80004a18:	fe840593          	addi	a1,s0,-24
    80004a1c:	00100613          	li	a2,1
    80004a20:	00000513          	li	a0,0
    80004a24:	fffff097          	auipc	ra,0xfffff
    80004a28:	ae8080e7          	jalr	-1304(ra) # 8000350c <console_read>
    80004a2c:	fe844503          	lbu	a0,-24(s0)
    80004a30:	01813083          	ld	ra,24(sp)
    80004a34:	01013403          	ld	s0,16(sp)
    80004a38:	02010113          	addi	sp,sp,32
    80004a3c:	00008067          	ret

0000000080004a40 <console_handler>:
    80004a40:	fe010113          	addi	sp,sp,-32
    80004a44:	00813823          	sd	s0,16(sp)
    80004a48:	00113c23          	sd	ra,24(sp)
    80004a4c:	00913423          	sd	s1,8(sp)
    80004a50:	02010413          	addi	s0,sp,32
    80004a54:	14202773          	csrr	a4,scause
    80004a58:	100027f3          	csrr	a5,sstatus
    80004a5c:	0027f793          	andi	a5,a5,2
    80004a60:	06079e63          	bnez	a5,80004adc <console_handler+0x9c>
    80004a64:	00074c63          	bltz	a4,80004a7c <console_handler+0x3c>
    80004a68:	01813083          	ld	ra,24(sp)
    80004a6c:	01013403          	ld	s0,16(sp)
    80004a70:	00813483          	ld	s1,8(sp)
    80004a74:	02010113          	addi	sp,sp,32
    80004a78:	00008067          	ret
    80004a7c:	0ff77713          	andi	a4,a4,255
    80004a80:	00900793          	li	a5,9
    80004a84:	fef712e3          	bne	a4,a5,80004a68 <console_handler+0x28>
    80004a88:	ffffe097          	auipc	ra,0xffffe
    80004a8c:	6dc080e7          	jalr	1756(ra) # 80003164 <plic_claim>
    80004a90:	00a00793          	li	a5,10
    80004a94:	00050493          	mv	s1,a0
    80004a98:	02f50c63          	beq	a0,a5,80004ad0 <console_handler+0x90>
    80004a9c:	fc0506e3          	beqz	a0,80004a68 <console_handler+0x28>
    80004aa0:	00050593          	mv	a1,a0
    80004aa4:	00000517          	auipc	a0,0x0
    80004aa8:	71450513          	addi	a0,a0,1812 # 800051b8 <CONSOLE_STATUS+0x1a0>
    80004aac:	fffff097          	auipc	ra,0xfffff
    80004ab0:	afc080e7          	jalr	-1284(ra) # 800035a8 <__printf>
    80004ab4:	01013403          	ld	s0,16(sp)
    80004ab8:	01813083          	ld	ra,24(sp)
    80004abc:	00048513          	mv	a0,s1
    80004ac0:	00813483          	ld	s1,8(sp)
    80004ac4:	02010113          	addi	sp,sp,32
    80004ac8:	ffffe317          	auipc	t1,0xffffe
    80004acc:	6d430067          	jr	1748(t1) # 8000319c <plic_complete>
    80004ad0:	fffff097          	auipc	ra,0xfffff
    80004ad4:	3e0080e7          	jalr	992(ra) # 80003eb0 <uartintr>
    80004ad8:	fddff06f          	j	80004ab4 <console_handler+0x74>
    80004adc:	00000517          	auipc	a0,0x0
    80004ae0:	7dc50513          	addi	a0,a0,2012 # 800052b8 <digits+0x78>
    80004ae4:	fffff097          	auipc	ra,0xfffff
    80004ae8:	a68080e7          	jalr	-1432(ra) # 8000354c <panic>
	...
