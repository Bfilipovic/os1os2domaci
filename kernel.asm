
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
    8000001c:	0c5020ef          	jal	ra,800028e0 <start>

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

    call handleSupervisorTrap
    800010a8:	5cc000ef          	jal	ra,80001674 <handleSupervisorTrap>

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
    
    call handleSupervisorTrap
    800011b4:	4c0000ef          	jal	ra,80001674 <handleSupervisorTrap>
    
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

0000000080001674 <handleSupervisorTrap>:


int time=0;

void handleSupervisorTrap()
{
    80001674:	f3010113          	addi	sp,sp,-208
    80001678:	0c113423          	sd	ra,200(sp)
    8000167c:	0c813023          	sd	s0,192(sp)
    80001680:	0a913c23          	sd	s1,184(sp)
    80001684:	0b213823          	sd	s2,176(sp)
    80001688:	0d010413          	addi	s0,sp,208
    uint64  a0,a1,a2,a3,a4;
    __asm__ volatile ("mv %[a0], a0" : [a0] "=r"(a0));
    8000168c:	00050793          	mv	a5,a0
    __asm__ volatile ("mv %[a1], a1" : [a1] "=r"(a1));
    80001690:	00058493          	mv	s1,a1
    __asm__ volatile ("mv %[a2], a2" : [a2] "=r"(a2));
    80001694:	00060913          	mv	s2,a2
    __asm__ volatile ("mv %[a3], a3" : [a3] "=r"(a3));
    80001698:	00068613          	mv	a2,a3
    __asm__ volatile ("mv %[a4], a4" : [a4] "=r"(a4));
    8000169c:	00070693          	mv	a3,a4
    __asm__ volatile ("csrr %[scause], scause" : [scause] "=r"(scause));
    800016a0:	14202773          	csrr	a4,scause
    800016a4:	f8e43023          	sd	a4,-128(s0)
    return scause;
    800016a8:	f8043703          	ld	a4,-128(s0)
    uint64  scause = r_scause();
    if (scause == INTR_USER_ECALL || scause == INTR_KERNEL_ECALL)
    800016ac:	ff870513          	addi	a0,a4,-8
    800016b0:	00100593          	li	a1,1
    800016b4:	02a5fe63          	bgeu	a1,a0,800016f0 <handleSupervisorTrap+0x7c>
            }


        }
    }
    else if (scause == INTR_TIMER)
    800016b8:	fff00793          	li	a5,-1
    800016bc:	03f79793          	slli	a5,a5,0x3f
    800016c0:	00178793          	addi	a5,a5,1
    800016c4:	2af70a63          	beq	a4,a5,80001978 <handleSupervisorTrap+0x304>
            //__putc('0'+running->id);
            //__putc(')');
        }

    }
    else if (scause == INTR_CONSOLE)
    800016c8:	fff00793          	li	a5,-1
    800016cc:	03f79793          	slli	a5,a5,0x3f
    800016d0:	00978793          	addi	a5,a5,9
    800016d4:	32f70a63          	beq	a4,a5,80001a08 <handleSupervisorTrap+0x394>
    }
    else if(scause==INTR_ILLEGAL_ADDR_WR){

    }

}
    800016d8:	0c813083          	ld	ra,200(sp)
    800016dc:	0c013403          	ld	s0,192(sp)
    800016e0:	0b813483          	ld	s1,184(sp)
    800016e4:	0b013903          	ld	s2,176(sp)
    800016e8:	0d010113          	addi	sp,sp,208
    800016ec:	00008067          	ret
    __asm__ volatile ("csrr %[sepc], sepc" : [sepc] "=r"(sepc));
    800016f0:	14102773          	csrr	a4,sepc
    800016f4:	f8e43423          	sd	a4,-120(s0)
    return sepc;
    800016f8:	f8843703          	ld	a4,-120(s0)
        uint64   sepc = r_sepc() + 4;
    800016fc:	00470713          	addi	a4,a4,4
    __asm__ volatile ("csrw sepc, %[sepc]" : : [sepc] "r"(sepc));
    80001700:	14171073          	csrw	sepc,a4
        switch (syscall_num) {
    80001704:	03100713          	li	a4,49
    80001708:	fcf768e3          	bltu	a4,a5,800016d8 <handleSupervisorTrap+0x64>
    8000170c:	00279793          	slli	a5,a5,0x2
    80001710:	00004717          	auipc	a4,0x4
    80001714:	91070713          	addi	a4,a4,-1776 # 80005020 <CONSOLE_STATUS+0x8>
    80001718:	00e787b3          	add	a5,a5,a4
    8000171c:	0007a783          	lw	a5,0(a5)
    80001720:	00e787b3          	add	a5,a5,a4
    80001724:	00078067          	jr	a5
                retval=(uint64)kern_mem_alloc(size);
    80001728:	0004851b          	sext.w	a0,s1
    8000172c:	00000097          	auipc	ra,0x0
    80001730:	cf8080e7          	jalr	-776(ra) # 80001424 <kern_mem_alloc>
    __asm__ volatile ("mv a0, %[value]" :: [value] "r"(value));
    80001734:	00050513          	mv	a0,a0
}
    80001738:	fa1ff06f          	j	800016d8 <handleSupervisorTrap+0x64>
                retval=(uint64) kern_mem_free((void*)addr);
    8000173c:	00048513          	mv	a0,s1
    80001740:	00000097          	auipc	ra,0x0
    80001744:	da8080e7          	jalr	-600(ra) # 800014e8 <kern_mem_free>
    __asm__ volatile ("mv a0, %[value]" :: [value] "r"(value));
    80001748:	00050513          	mv	a0,a0
}
    8000174c:	f8dff06f          	j	800016d8 <handleSupervisorTrap+0x64>
                retval=(uint64) kern_thread_create((thread_t*)handle,
    80001750:	00090593          	mv	a1,s2
    80001754:	00048513          	mv	a0,s1
    80001758:	00000097          	auipc	ra,0x0
    8000175c:	6c8080e7          	jalr	1736(ra) # 80001e20 <kern_thread_create>
                (*(thread_t*)handle)->endTime=SYSTEM_TIME+DEFAULT_TIME_SLICE;
    80001760:	0004b703          	ld	a4,0(s1)
    80001764:	00004797          	auipc	a5,0x4
    80001768:	ef47b783          	ld	a5,-268(a5) # 80005658 <SYSTEM_TIME>
    8000176c:	00278793          	addi	a5,a5,2
    80001770:	02f73c23          	sd	a5,56(a4)
    __asm__ volatile ("mv a0, %[value]" :: [value] "r"(value));
    80001774:	00050513          	mv	a0,a0
}
    80001778:	f61ff06f          	j	800016d8 <handleSupervisorTrap+0x64>
}

inline uint64 r_sstatus()
{
    uint64 volatile sstatus;
    __asm__ volatile ("csrr %[sstatus], sstatus" : [sstatus] "=r"(sstatus));
    8000177c:	100027f3          	csrr	a5,sstatus
    80001780:	f8f43c23          	sd	a5,-104(s0)
    return sstatus;
    80001784:	f9843783          	ld	a5,-104(s0)
                uint64 volatile sstatus = r_sstatus();
    80001788:	f2f43823          	sd	a5,-208(s0)
    __asm__ volatile ("csrr %[sepc], sepc" : [sepc] "=r"(sepc));
    8000178c:	141027f3          	csrr	a5,sepc
    80001790:	f8f43823          	sd	a5,-112(s0)
    return sepc;
    80001794:	f9043783          	ld	a5,-112(s0)
                uint64 volatile v_sepc = r_sepc();
    80001798:	f2f43c23          	sd	a5,-200(s0)
                kern_thread_dispatch();
    8000179c:	00000097          	auipc	ra,0x0
    800017a0:	434080e7          	jalr	1076(ra) # 80001bd0 <kern_thread_dispatch>
                w_sstatus(sstatus);
    800017a4:	f3043783          	ld	a5,-208(s0)
}

inline void w_sstatus(uint64 sstatus)
{
    __asm__ volatile ("csrw sstatus, %[sstatus]" : : [sstatus] "r"(sstatus));
    800017a8:	10079073          	csrw	sstatus,a5
                w_sepc(v_sepc);
    800017ac:	f3843783          	ld	a5,-200(s0)
    __asm__ volatile ("csrw sepc, %[sepc]" : : [sepc] "r"(sepc));
    800017b0:	14179073          	csrw	sepc,a5
                running->endTime=time+running->timeslice;
    800017b4:	00004717          	auipc	a4,0x4
    800017b8:	eac73703          	ld	a4,-340(a4) # 80005660 <running>
    800017bc:	03073683          	ld	a3,48(a4)
    800017c0:	00004797          	auipc	a5,0x4
    800017c4:	e907a783          	lw	a5,-368(a5) # 80005650 <time>
    800017c8:	00d787b3          	add	a5,a5,a3
    800017cc:	02f73c23          	sd	a5,56(a4)
                break;
    800017d0:	f09ff06f          	j	800016d8 <handleSupervisorTrap+0x64>
    __asm__ volatile ("csrr %[sstatus], sstatus" : [sstatus] "=r"(sstatus));
    800017d4:	100027f3          	csrr	a5,sstatus
    800017d8:	faf43423          	sd	a5,-88(s0)
    return sstatus;
    800017dc:	fa843783          	ld	a5,-88(s0)
                uint64 volatile sstatus = r_sstatus();
    800017e0:	f4f43023          	sd	a5,-192(s0)
    __asm__ volatile ("csrr %[sepc], sepc" : [sepc] "=r"(sepc));
    800017e4:	141027f3          	csrr	a5,sepc
    800017e8:	faf43023          	sd	a5,-96(s0)
    return sepc;
    800017ec:	fa043783          	ld	a5,-96(s0)
                uint64 volatile v_sepc = r_sepc();
    800017f0:	f4f43423          	sd	a5,-184(s0)
                kern_thread_join(handle);
    800017f4:	00048513          	mv	a0,s1
    800017f8:	00000097          	auipc	ra,0x0
    800017fc:	70c080e7          	jalr	1804(ra) # 80001f04 <kern_thread_join>
                w_sstatus(sstatus);
    80001800:	f4043783          	ld	a5,-192(s0)
    __asm__ volatile ("csrw sstatus, %[sstatus]" : : [sstatus] "r"(sstatus));
    80001804:	10079073          	csrw	sstatus,a5
                w_sepc(v_sepc);
    80001808:	f4843783          	ld	a5,-184(s0)
    __asm__ volatile ("csrw sepc, %[sepc]" : : [sepc] "r"(sepc));
    8000180c:	14179073          	csrw	sepc,a5
                running->endTime=time+running->timeslice;
    80001810:	00004717          	auipc	a4,0x4
    80001814:	e5073703          	ld	a4,-432(a4) # 80005660 <running>
    80001818:	03073683          	ld	a3,48(a4)
    8000181c:	00004797          	auipc	a5,0x4
    80001820:	e347a783          	lw	a5,-460(a5) # 80005650 <time>
    80001824:	00d787b3          	add	a5,a5,a3
    80001828:	02f73c23          	sd	a5,56(a4)
                break;
    8000182c:	eadff06f          	j	800016d8 <handleSupervisorTrap+0x64>
                kern_thread_end_running();
    80001830:	00000097          	auipc	ra,0x0
    80001834:	41c080e7          	jalr	1052(ra) # 80001c4c <kern_thread_end_running>
                retval = kern_sem_open(handle,init);
    80001838:	0009059b          	sext.w	a1,s2
    8000183c:	00048513          	mv	a0,s1
    80001840:	00000097          	auipc	ra,0x0
    80001844:	a6c080e7          	jalr	-1428(ra) # 800012ac <kern_sem_open>
    __asm__ volatile ("mv a0, %[value]" :: [value] "r"(value));
    80001848:	00050513          	mv	a0,a0
}
    8000184c:	e8dff06f          	j	800016d8 <handleSupervisorTrap+0x64>
                retval = kern_sem_close(handle);
    80001850:	00048513          	mv	a0,s1
    80001854:	00000097          	auipc	ra,0x0
    80001858:	ac8080e7          	jalr	-1336(ra) # 8000131c <kern_sem_close>
    __asm__ volatile ("mv a0, %[value]" :: [value] "r"(value));
    8000185c:	00050513          	mv	a0,a0
}
    80001860:	e79ff06f          	j	800016d8 <handleSupervisorTrap+0x64>
                kern_sem_signal(handle);
    80001864:	00048513          	mv	a0,s1
    80001868:	00000097          	auipc	ra,0x0
    8000186c:	b08080e7          	jalr	-1272(ra) # 80001370 <kern_sem_signal>
    __asm__ volatile ("mv a0, %[value]" :: [value] "r"(value));
    80001870:	00000793          	li	a5,0
    80001874:	00078513          	mv	a0,a5
}
    80001878:	e61ff06f          	j	800016d8 <handleSupervisorTrap+0x64>
                int res = kern_sem_wait(handle);
    8000187c:	00048513          	mv	a0,s1
    80001880:	00000097          	auipc	ra,0x0
    80001884:	b38080e7          	jalr	-1224(ra) # 800013b8 <kern_sem_wait>
                if(res==1) retval=0;
    80001888:	00100793          	li	a5,1
    8000188c:	00f51863          	bne	a0,a5,8000189c <handleSupervisorTrap+0x228>
    80001890:	00000793          	li	a5,0
    __asm__ volatile ("mv a0, %[value]" :: [value] "r"(value));
    80001894:	00078513          	mv	a0,a5
}
    80001898:	e41ff06f          	j	800016d8 <handleSupervisorTrap+0x64>
    __asm__ volatile ("csrr %[sstatus], sstatus" : [sstatus] "=r"(sstatus));
    8000189c:	100027f3          	csrr	a5,sstatus
    800018a0:	faf43c23          	sd	a5,-72(s0)
    return sstatus;
    800018a4:	fb843783          	ld	a5,-72(s0)
                    uint64 volatile sstatus = r_sstatus();
    800018a8:	f4f43823          	sd	a5,-176(s0)
    __asm__ volatile ("csrr %[sepc], sepc" : [sepc] "=r"(sepc));
    800018ac:	141027f3          	csrr	a5,sepc
    800018b0:	faf43823          	sd	a5,-80(s0)
    return sepc;
    800018b4:	fb043783          	ld	a5,-80(s0)
                    uint64 volatile v_sepc = r_sepc();
    800018b8:	f4f43c23          	sd	a5,-168(s0)
                    kern_thread_dispatch();
    800018bc:	00000097          	auipc	ra,0x0
    800018c0:	314080e7          	jalr	788(ra) # 80001bd0 <kern_thread_dispatch>
                    w_sstatus(sstatus);
    800018c4:	f5043783          	ld	a5,-176(s0)
    __asm__ volatile ("csrw sstatus, %[sstatus]" : : [sstatus] "r"(sstatus));
    800018c8:	10079073          	csrw	sstatus,a5
                    w_sepc(v_sepc);
    800018cc:	f5843783          	ld	a5,-168(s0)
    __asm__ volatile ("csrw sepc, %[sepc]" : : [sepc] "r"(sepc));
    800018d0:	14179073          	csrw	sepc,a5
                    running->endTime=time+running->timeslice;
    800018d4:	00004797          	auipc	a5,0x4
    800018d8:	d8c7b783          	ld	a5,-628(a5) # 80005660 <running>
    800018dc:	0307b683          	ld	a3,48(a5)
    800018e0:	00004717          	auipc	a4,0x4
    800018e4:	d7072703          	lw	a4,-656(a4) # 80005650 <time>
    800018e8:	00d70733          	add	a4,a4,a3
    800018ec:	02e7bc23          	sd	a4,56(a5)
                    if(running->mailbox==0) retval = 0;
    800018f0:	0487b783          	ld	a5,72(a5)
    800018f4:	fa0780e3          	beqz	a5,80001894 <handleSupervisorTrap+0x220>
                    else retval=-1;
    800018f8:	fff00793          	li	a5,-1
    800018fc:	f99ff06f          	j	80001894 <handleSupervisorTrap+0x220>
                running->status=SLEEPING;
    80001900:	00004917          	auipc	s2,0x4
    80001904:	d6090913          	addi	s2,s2,-672 # 80005660 <running>
    80001908:	00093783          	ld	a5,0(s2)
    8000190c:	00500713          	li	a4,5
    80001910:	04e7a823          	sw	a4,80(a5)
                running->endTime=SYSTEM_TIME+period;
    80001914:	00004717          	auipc	a4,0x4
    80001918:	d4473703          	ld	a4,-700(a4) # 80005658 <SYSTEM_TIME>
    8000191c:	00e484b3          	add	s1,s1,a4
    80001920:	0297bc23          	sd	s1,56(a5)
    __asm__ volatile ("csrr %[sstatus], sstatus" : [sstatus] "=r"(sstatus));
    80001924:	100027f3          	csrr	a5,sstatus
    80001928:	fcf43423          	sd	a5,-56(s0)
    return sstatus;
    8000192c:	fc843783          	ld	a5,-56(s0)
                uint64 volatile sstatus = r_sstatus();
    80001930:	f6f43023          	sd	a5,-160(s0)
    __asm__ volatile ("csrr %[sepc], sepc" : [sepc] "=r"(sepc));
    80001934:	141027f3          	csrr	a5,sepc
    80001938:	fcf43023          	sd	a5,-64(s0)
    return sepc;
    8000193c:	fc043783          	ld	a5,-64(s0)
                uint64 volatile v_sepc = r_sepc();
    80001940:	f6f43423          	sd	a5,-152(s0)
                kern_thread_dispatch();
    80001944:	00000097          	auipc	ra,0x0
    80001948:	28c080e7          	jalr	652(ra) # 80001bd0 <kern_thread_dispatch>
                w_sstatus(sstatus);
    8000194c:	f6043783          	ld	a5,-160(s0)
    __asm__ volatile ("csrw sstatus, %[sstatus]" : : [sstatus] "r"(sstatus));
    80001950:	10079073          	csrw	sstatus,a5
                w_sepc(v_sepc);
    80001954:	f6843783          	ld	a5,-152(s0)
    __asm__ volatile ("csrw sepc, %[sepc]" : : [sepc] "r"(sepc));
    80001958:	14179073          	csrw	sepc,a5
                running->endTime=time+running->timeslice;
    8000195c:	00093703          	ld	a4,0(s2)
    80001960:	03073683          	ld	a3,48(a4)
    80001964:	00004797          	auipc	a5,0x4
    80001968:	cec7a783          	lw	a5,-788(a5) # 80005650 <time>
    8000196c:	00d787b3          	add	a5,a5,a3
    80001970:	02f73c23          	sd	a5,56(a4)
    80001974:	d65ff06f          	j	800016d8 <handleSupervisorTrap+0x64>
        SYSTEM_TIME++;
    80001978:	00004497          	auipc	s1,0x4
    8000197c:	ce048493          	addi	s1,s1,-800 # 80005658 <SYSTEM_TIME>
    80001980:	0004b503          	ld	a0,0(s1)
    80001984:	00150513          	addi	a0,a0,1
    80001988:	00a4b023          	sd	a0,0(s1)
    __asm__ volatile ("csrc sip, %[mask]" : : [mask] "r"(mask));
    8000198c:	00200793          	li	a5,2
    80001990:	1447b073          	csrc	sip,a5
        kern_thread_wakeup(SYSTEM_TIME);
    80001994:	00000097          	auipc	ra,0x0
    80001998:	5bc080e7          	jalr	1468(ra) # 80001f50 <kern_thread_wakeup>
        if(SYSTEM_TIME>=running->endTime){
    8000199c:	00004797          	auipc	a5,0x4
    800019a0:	cc47b783          	ld	a5,-828(a5) # 80005660 <running>
    800019a4:	0387b703          	ld	a4,56(a5)
    800019a8:	0004b783          	ld	a5,0(s1)
    800019ac:	d2e7e6e3          	bltu	a5,a4,800016d8 <handleSupervisorTrap+0x64>
    __asm__ volatile ("csrr %[sstatus], sstatus" : [sstatus] "=r"(sstatus));
    800019b0:	100027f3          	csrr	a5,sstatus
    800019b4:	fcf43c23          	sd	a5,-40(s0)
    return sstatus;
    800019b8:	fd843783          	ld	a5,-40(s0)
            uint64 volatile sstatus = r_sstatus();
    800019bc:	f6f43823          	sd	a5,-144(s0)
    __asm__ volatile ("csrr %[sepc], sepc" : [sepc] "=r"(sepc));
    800019c0:	141027f3          	csrr	a5,sepc
    800019c4:	fcf43823          	sd	a5,-48(s0)
    return sepc;
    800019c8:	fd043783          	ld	a5,-48(s0)
            uint64 volatile v_sepc = r_sepc();
    800019cc:	f6f43c23          	sd	a5,-136(s0)
            kern_thread_dispatch();
    800019d0:	00000097          	auipc	ra,0x0
    800019d4:	200080e7          	jalr	512(ra) # 80001bd0 <kern_thread_dispatch>
            w_sstatus(sstatus);
    800019d8:	f7043783          	ld	a5,-144(s0)
    __asm__ volatile ("csrw sstatus, %[sstatus]" : : [sstatus] "r"(sstatus));
    800019dc:	10079073          	csrw	sstatus,a5
            w_sepc(v_sepc);
    800019e0:	f7843783          	ld	a5,-136(s0)
    __asm__ volatile ("csrw sepc, %[sepc]" : : [sepc] "r"(sepc));
    800019e4:	14179073          	csrw	sepc,a5
            running->endTime=SYSTEM_TIME+running->timeslice;
    800019e8:	00004717          	auipc	a4,0x4
    800019ec:	c7873703          	ld	a4,-904(a4) # 80005660 <running>
    800019f0:	03073783          	ld	a5,48(a4)
    800019f4:	00004697          	auipc	a3,0x4
    800019f8:	c646b683          	ld	a3,-924(a3) # 80005658 <SYSTEM_TIME>
    800019fc:	00d787b3          	add	a5,a5,a3
    80001a00:	02f73c23          	sd	a5,56(a4)
    80001a04:	cd5ff06f          	j	800016d8 <handleSupervisorTrap+0x64>
        int i = plic_claim();
    80001a08:	00001097          	auipc	ra,0x1
    80001a0c:	72c080e7          	jalr	1836(ra) # 80003134 <plic_claim>
        if(i==10){
    80001a10:	00a00793          	li	a5,10
    80001a14:	00f50863          	beq	a0,a5,80001a24 <handleSupervisorTrap+0x3b0>
        console_handler();
    80001a18:	00003097          	auipc	ra,0x3
    80001a1c:	ff8080e7          	jalr	-8(ra) # 80004a10 <console_handler>
}
    80001a20:	cb9ff06f          	j	800016d8 <handleSupervisorTrap+0x64>
            plic_complete(i);
    80001a24:	00001097          	auipc	ra,0x1
    80001a28:	748080e7          	jalr	1864(ra) # 8000316c <plic_complete>
            i--;
    80001a2c:	fedff06f          	j	80001a18 <handleSupervisorTrap+0x3a4>

0000000080001a30 <kern_thread_init>:
struct thread_s threads[MAX_THREADS];
static int id;
struct thread_s* running;

void kern_thread_init()
{
    80001a30:	ff010113          	addi	sp,sp,-16
    80001a34:	00813423          	sd	s0,8(sp)
    80001a38:	01010413          	addi	s0,sp,16
    id=0;
    80001a3c:	00004797          	auipc	a5,0x4
    80001a40:	c207a623          	sw	zero,-980(a5) # 80005668 <id>
    for (int i=0;i<MAX_THREADS;i++){
    80001a44:	00000793          	li	a5,0
    80001a48:	0240006f          	j	80001a6c <kern_thread_init+0x3c>
        threads[i].status=UNUSED;
    80001a4c:	00179713          	slli	a4,a5,0x1
    80001a50:	00f70733          	add	a4,a4,a5
    80001a54:	00571693          	slli	a3,a4,0x5
    80001a58:	00005717          	auipc	a4,0x5
    80001a5c:	c3870713          	addi	a4,a4,-968 # 80006690 <threads>
    80001a60:	00d70733          	add	a4,a4,a3
    80001a64:	04072823          	sw	zero,80(a4)
    for (int i=0;i<MAX_THREADS;i++){
    80001a68:	0017879b          	addiw	a5,a5,1
    80001a6c:	03f00713          	li	a4,63
    80001a70:	fcf75ee3          	bge	a4,a5,80001a4c <kern_thread_init+0x1c>
    }

    //set threads[0] as main thread
    threads[0].status=RUNNING;
    80001a74:	00005797          	auipc	a5,0x5
    80001a78:	c1c78793          	addi	a5,a5,-996 # 80006690 <threads>
    80001a7c:	00100713          	li	a4,1
    80001a80:	04e7a823          	sw	a4,80(a5)
    threads[0].id=0;
    80001a84:	0007b823          	sd	zero,16(a5)
    threads[0].timeslice=DEFAULT_TIME_SLICE+2;
    80001a88:	00400713          	li	a4,4
    80001a8c:	02e7b823          	sd	a4,48(a5)
    threads[0].endTime=0;
    80001a90:	0207bc23          	sd	zero,56(a5)
    running=&threads[0];
    80001a94:	00004717          	auipc	a4,0x4
    80001a98:	bcf73623          	sd	a5,-1076(a4) # 80005660 <running>
}
    80001a9c:	00813403          	ld	s0,8(sp)
    80001aa0:	01010113          	addi	sp,sp,16
    80001aa4:	00008067          	ret

0000000080001aa8 <kern_scheduler_get>:

thread_t kern_scheduler_get()
{
    80001aa8:	ff010113          	addi	sp,sp,-16
    80001aac:	00813423          	sd	s0,8(sp)
    80001ab0:	01010413          	addi	s0,sp,16
    int num = running-threads;
    80001ab4:	00004517          	auipc	a0,0x4
    80001ab8:	bac53503          	ld	a0,-1108(a0) # 80005660 <running>
    80001abc:	00005797          	auipc	a5,0x5
    80001ac0:	bd478793          	addi	a5,a5,-1068 # 80006690 <threads>
    80001ac4:	40f507b3          	sub	a5,a0,a5
    80001ac8:	4057d793          	srai	a5,a5,0x5
    80001acc:	00003717          	auipc	a4,0x3
    80001ad0:	53473703          	ld	a4,1332(a4) # 80005000 <console_handler+0x5f0>
    80001ad4:	02e787bb          	mulw	a5,a5,a4
    for(int i=1;i<=MAX_THREADS;i++){
    80001ad8:	00100693          	li	a3,1
    80001adc:	04000713          	li	a4,64
    80001ae0:	06d74c63          	blt	a4,a3,80001b58 <kern_scheduler_get+0xb0>
        num = (num+i)%MAX_THREADS;
    80001ae4:	00d787bb          	addw	a5,a5,a3
    80001ae8:	41f7d71b          	sraiw	a4,a5,0x1f
    80001aec:	01a7571b          	srliw	a4,a4,0x1a
    80001af0:	00e787bb          	addw	a5,a5,a4
    80001af4:	03f7f793          	andi	a5,a5,63
    80001af8:	40e787bb          	subw	a5,a5,a4
        if(threads[num].status==READY){
    80001afc:	00179713          	slli	a4,a5,0x1
    80001b00:	00f70733          	add	a4,a4,a5
    80001b04:	00571613          	slli	a2,a4,0x5
    80001b08:	00005717          	auipc	a4,0x5
    80001b0c:	b8870713          	addi	a4,a4,-1144 # 80006690 <threads>
    80001b10:	00c70733          	add	a4,a4,a2
    80001b14:	05072603          	lw	a2,80(a4)
    80001b18:	00200713          	li	a4,2
    80001b1c:	00e60663          	beq	a2,a4,80001b28 <kern_scheduler_get+0x80>
    for(int i=1;i<=MAX_THREADS;i++){
    80001b20:	0016869b          	addiw	a3,a3,1
    80001b24:	fb9ff06f          	j	80001adc <kern_scheduler_get+0x34>
            threads[num].status=RUNNING;
    80001b28:	00005617          	auipc	a2,0x5
    80001b2c:	b6860613          	addi	a2,a2,-1176 # 80006690 <threads>
    80001b30:	00179713          	slli	a4,a5,0x1
    80001b34:	00f705b3          	add	a1,a4,a5
    80001b38:	00559693          	slli	a3,a1,0x5
    80001b3c:	00d606b3          	add	a3,a2,a3
    80001b40:	00100593          	li	a1,1
    80001b44:	04b6a823          	sw	a1,80(a3)
            return &threads[num];
    80001b48:	00068513          	mv	a0,a3
    if(running->status==READY || running->status==RUNNING) {
        running->status=RUNNING;
        return running;
    }
    return 0;
}
    80001b4c:	00813403          	ld	s0,8(sp)
    80001b50:	01010113          	addi	sp,sp,16
    80001b54:	00008067          	ret
    if(running->status==READY || running->status==RUNNING) {
    80001b58:	05052783          	lw	a5,80(a0)
    80001b5c:	fff7879b          	addiw	a5,a5,-1
    80001b60:	00100713          	li	a4,1
    80001b64:	00f77663          	bgeu	a4,a5,80001b70 <kern_scheduler_get+0xc8>
    return 0;
    80001b68:	00000513          	li	a0,0
    80001b6c:	fe1ff06f          	j	80001b4c <kern_scheduler_get+0xa4>
        running->status=RUNNING;
    80001b70:	00100793          	li	a5,1
    80001b74:	04f52823          	sw	a5,80(a0)
        return running;
    80001b78:	fd5ff06f          	j	80001b4c <kern_scheduler_get+0xa4>

0000000080001b7c <kern_thread_yield>:

void kern_thread_yield()
{
    80001b7c:	ff010113          	addi	sp,sp,-16
    80001b80:	00113423          	sd	ra,8(sp)
    80001b84:	00813023          	sd	s0,0(sp)
    80001b88:	01010413          	addi	s0,sp,16
    kern_syscall(THREAD_DISPATCH);
    80001b8c:	01300513          	li	a0,19
    80001b90:	00000097          	auipc	ra,0x0
    80001b94:	a78080e7          	jalr	-1416(ra) # 80001608 <kern_syscall>
}
    80001b98:	00813083          	ld	ra,8(sp)
    80001b9c:	00013403          	ld	s0,0(sp)
    80001ba0:	01010113          	addi	sp,sp,16
    80001ba4:	00008067          	ret

0000000080001ba8 <popSppSpie>:

//samo izlazi iz kernela i vraca se odakle je pozvana
void popSppSpie()
{
    80001ba8:	ff010113          	addi	sp,sp,-16
    80001bac:	00813423          	sd	s0,8(sp)
    80001bb0:	01010413          	addi	s0,sp,16
    __asm__ volatile("csrw sepc, ra"); //ovde dodaj izlazak iz privilegovanog moda
    80001bb4:	14109073          	csrw	sepc,ra
    __asm__ volatile("csrc sstatus, %[mask]" : : [mask] "r"(1 << 8));
    80001bb8:	10000793          	li	a5,256
    80001bbc:	1007b073          	csrc	sstatus,a5
    __asm__ volatile("sret");
    80001bc0:	10200073          	sret
}
    80001bc4:	00813403          	ld	s0,8(sp)
    80001bc8:	01010113          	addi	sp,sp,16
    80001bcc:	00008067          	ret

0000000080001bd0 <kern_thread_dispatch>:

extern void contextSwitch(thread_t old, thread_t new);

void kern_thread_dispatch()
{
    80001bd0:	fe010113          	addi	sp,sp,-32
    80001bd4:	00113c23          	sd	ra,24(sp)
    80001bd8:	00813823          	sd	s0,16(sp)
    80001bdc:	00913423          	sd	s1,8(sp)
    80001be0:	01213023          	sd	s2,0(sp)
    80001be4:	02010413          	addi	s0,sp,32
    thread_t old = running;
    80001be8:	00004917          	auipc	s2,0x4
    80001bec:	a7890913          	addi	s2,s2,-1416 # 80005660 <running>
    80001bf0:	00093483          	ld	s1,0(s2)
    running=kern_scheduler_get();
    80001bf4:	00000097          	auipc	ra,0x0
    80001bf8:	eb4080e7          	jalr	-332(ra) # 80001aa8 <kern_scheduler_get>
    80001bfc:	00a93023          	sd	a0,0(s2)
    if(old!=running){
    80001c00:	02950463          	beq	a0,s1,80001c28 <kern_thread_dispatch+0x58>
    80001c04:	00050593          	mv	a1,a0
        running->status=RUNNING;
    80001c08:	00100793          	li	a5,1
    80001c0c:	04f52823          	sw	a5,80(a0)
        if(old->status==RUNNING) old->status=READY;
    80001c10:	0504a703          	lw	a4,80(s1)
    80001c14:	00100793          	li	a5,1
    80001c18:	02f70463          	beq	a4,a5,80001c40 <kern_thread_dispatch+0x70>
        contextSwitch(old,running);
    80001c1c:	00048513          	mv	a0,s1
    80001c20:	fffff097          	auipc	ra,0xfffff
    80001c24:	62c080e7          	jalr	1580(ra) # 8000124c <contextSwitch>
    }
}
    80001c28:	01813083          	ld	ra,24(sp)
    80001c2c:	01013403          	ld	s0,16(sp)
    80001c30:	00813483          	ld	s1,8(sp)
    80001c34:	00013903          	ld	s2,0(sp)
    80001c38:	02010113          	addi	sp,sp,32
    80001c3c:	00008067          	ret
        if(old->status==RUNNING) old->status=READY;
    80001c40:	00200793          	li	a5,2
    80001c44:	04f4a823          	sw	a5,80(s1)
    80001c48:	fd5ff06f          	j	80001c1c <kern_thread_dispatch+0x4c>

0000000080001c4c <kern_thread_end_running>:

void kern_thread_end_running()
{
    80001c4c:	fe010113          	addi	sp,sp,-32
    80001c50:	00113c23          	sd	ra,24(sp)
    80001c54:	00813823          	sd	s0,16(sp)
    80001c58:	00913423          	sd	s1,8(sp)
    80001c5c:	02010413          	addi	s0,sp,32
    thread_t old = running;
    80001c60:	00004497          	auipc	s1,0x4
    80001c64:	a004b483          	ld	s1,-1536(s1) # 80005660 <running>
    old->status=UNUSED;
    80001c68:	0404a823          	sw	zero,80(s1)
    for(int i=0;i<MAX_THREADS;i++){
    80001c6c:	00000713          	li	a4,0
    80001c70:	0080006f          	j	80001c78 <kern_thread_end_running+0x2c>
    80001c74:	0017071b          	addiw	a4,a4,1
    80001c78:	03f00793          	li	a5,63
    80001c7c:	06e7c863          	blt	a5,a4,80001cec <kern_thread_end_running+0xa0>
        if(threads[i].status==JOINED && threads[i].joined_tid==old->id) threads[i].status=READY;
    80001c80:	00171793          	slli	a5,a4,0x1
    80001c84:	00e787b3          	add	a5,a5,a4
    80001c88:	00579793          	slli	a5,a5,0x5
    80001c8c:	00005697          	auipc	a3,0x5
    80001c90:	a0468693          	addi	a3,a3,-1532 # 80006690 <threads>
    80001c94:	00f687b3          	add	a5,a3,a5
    80001c98:	0507a683          	lw	a3,80(a5)
    80001c9c:	00400793          	li	a5,4
    80001ca0:	fcf69ae3          	bne	a3,a5,80001c74 <kern_thread_end_running+0x28>
    80001ca4:	00171793          	slli	a5,a4,0x1
    80001ca8:	00e787b3          	add	a5,a5,a4
    80001cac:	00579793          	slli	a5,a5,0x5
    80001cb0:	00005697          	auipc	a3,0x5
    80001cb4:	9e068693          	addi	a3,a3,-1568 # 80006690 <threads>
    80001cb8:	00f687b3          	add	a5,a3,a5
    80001cbc:	0287b683          	ld	a3,40(a5)
    80001cc0:	0104b783          	ld	a5,16(s1)
    80001cc4:	faf698e3          	bne	a3,a5,80001c74 <kern_thread_end_running+0x28>
    80001cc8:	00171793          	slli	a5,a4,0x1
    80001ccc:	00e787b3          	add	a5,a5,a4
    80001cd0:	00579793          	slli	a5,a5,0x5
    80001cd4:	00005697          	auipc	a3,0x5
    80001cd8:	9bc68693          	addi	a3,a3,-1604 # 80006690 <threads>
    80001cdc:	00f687b3          	add	a5,a3,a5
    80001ce0:	00200693          	li	a3,2
    80001ce4:	04d7a823          	sw	a3,80(a5)
    80001ce8:	f8dff06f          	j	80001c74 <kern_thread_end_running+0x28>
    }
    running=kern_scheduler_get();
    80001cec:	00000097          	auipc	ra,0x0
    80001cf0:	dbc080e7          	jalr	-580(ra) # 80001aa8 <kern_scheduler_get>
    80001cf4:	00004797          	auipc	a5,0x4
    80001cf8:	96a7b623          	sd	a0,-1684(a5) # 80005660 <running>
    if(old->stack_space!=0) kern_mem_free((void*)old->stack_space);
    80001cfc:	0404b503          	ld	a0,64(s1)
    80001d00:	02051863          	bnez	a0,80001d30 <kern_thread_end_running+0xe4>
    if(old!=running){
    80001d04:	00004597          	auipc	a1,0x4
    80001d08:	95c5b583          	ld	a1,-1700(a1) # 80005660 <running>
    80001d0c:	00958863          	beq	a1,s1,80001d1c <kern_thread_end_running+0xd0>
        contextSwitch(old,running);
    80001d10:	00048513          	mv	a0,s1
    80001d14:	fffff097          	auipc	ra,0xfffff
    80001d18:	538080e7          	jalr	1336(ra) # 8000124c <contextSwitch>
    }
}
    80001d1c:	01813083          	ld	ra,24(sp)
    80001d20:	01013403          	ld	s0,16(sp)
    80001d24:	00813483          	ld	s1,8(sp)
    80001d28:	02010113          	addi	sp,sp,32
    80001d2c:	00008067          	ret
    if(old->stack_space!=0) kern_mem_free((void*)old->stack_space);
    80001d30:	fffff097          	auipc	ra,0xfffff
    80001d34:	7b8080e7          	jalr	1976(ra) # 800014e8 <kern_mem_free>
    80001d38:	fcdff06f          	j	80001d04 <kern_thread_end_running+0xb8>

0000000080001d3c <kern_thread_wrapper>:

void kern_thread_wrapper()
{
    80001d3c:	fe010113          	addi	sp,sp,-32
    80001d40:	00113c23          	sd	ra,24(sp)
    80001d44:	00813823          	sd	s0,16(sp)
    80001d48:	00913423          	sd	s1,8(sp)
    80001d4c:	02010413          	addi	s0,sp,32
    popSppSpie();
    80001d50:	00000097          	auipc	ra,0x0
    80001d54:	e58080e7          	jalr	-424(ra) # 80001ba8 <popSppSpie>
    running->body(running->arg);
    80001d58:	00004497          	auipc	s1,0x4
    80001d5c:	90848493          	addi	s1,s1,-1784 # 80005660 <running>
    80001d60:	0004b783          	ld	a5,0(s1)
    80001d64:	0187b703          	ld	a4,24(a5)
    80001d68:	0207b503          	ld	a0,32(a5)
    80001d6c:	000700e7          	jalr	a4
    running->status=UNUSED;
    80001d70:	0004b603          	ld	a2,0(s1)
    80001d74:	04062823          	sw	zero,80(a2)
    running->sem_next=0;
    80001d78:	04063c23          	sd	zero,88(a2)
    running->joined_tid=-1;
    80001d7c:	fff00793          	li	a5,-1
    80001d80:	02f63423          	sd	a5,40(a2)
    for(int i=0;i<MAX_THREADS;i++){
    80001d84:	00000793          	li	a5,0
    80001d88:	0080006f          	j	80001d90 <kern_thread_wrapper+0x54>
    80001d8c:	0017879b          	addiw	a5,a5,1
    80001d90:	03f00713          	li	a4,63
    80001d94:	06f74863          	blt	a4,a5,80001e04 <kern_thread_wrapper+0xc8>
        if(threads[i].status==JOINED && threads[i].joined_tid==running->id) threads[i].status=READY;
    80001d98:	00179713          	slli	a4,a5,0x1
    80001d9c:	00f70733          	add	a4,a4,a5
    80001da0:	00571693          	slli	a3,a4,0x5
    80001da4:	00005717          	auipc	a4,0x5
    80001da8:	8ec70713          	addi	a4,a4,-1812 # 80006690 <threads>
    80001dac:	00d70733          	add	a4,a4,a3
    80001db0:	05072683          	lw	a3,80(a4)
    80001db4:	00400713          	li	a4,4
    80001db8:	fce69ae3          	bne	a3,a4,80001d8c <kern_thread_wrapper+0x50>
    80001dbc:	00179713          	slli	a4,a5,0x1
    80001dc0:	00f70733          	add	a4,a4,a5
    80001dc4:	00571693          	slli	a3,a4,0x5
    80001dc8:	00005717          	auipc	a4,0x5
    80001dcc:	8c870713          	addi	a4,a4,-1848 # 80006690 <threads>
    80001dd0:	00d70733          	add	a4,a4,a3
    80001dd4:	02873683          	ld	a3,40(a4)
    80001dd8:	01063703          	ld	a4,16(a2)
    80001ddc:	fae698e3          	bne	a3,a4,80001d8c <kern_thread_wrapper+0x50>
    80001de0:	00179713          	slli	a4,a5,0x1
    80001de4:	00f70733          	add	a4,a4,a5
    80001de8:	00571693          	slli	a3,a4,0x5
    80001dec:	00005717          	auipc	a4,0x5
    80001df0:	8a470713          	addi	a4,a4,-1884 # 80006690 <threads>
    80001df4:	00d70733          	add	a4,a4,a3
    80001df8:	00200693          	li	a3,2
    80001dfc:	04d72823          	sw	a3,80(a4)
    80001e00:	f8dff06f          	j	80001d8c <kern_thread_wrapper+0x50>
    }

    kern_thread_end_running();
    80001e04:	00000097          	auipc	ra,0x0
    80001e08:	e48080e7          	jalr	-440(ra) # 80001c4c <kern_thread_end_running>
}
    80001e0c:	01813083          	ld	ra,24(sp)
    80001e10:	01013403          	ld	s0,16(sp)
    80001e14:	00813483          	ld	s1,8(sp)
    80001e18:	02010113          	addi	sp,sp,32
    80001e1c:	00008067          	ret

0000000080001e20 <kern_thread_create>:

int kern_thread_create(thread_t* handle, void(*start_routine)(void*), void* arg, void* stack_space)
{
    80001e20:	ff010113          	addi	sp,sp,-16
    80001e24:	00813423          	sd	s0,8(sp)
    80001e28:	01010413          	addi	s0,sp,16
    *handle=0;
    80001e2c:	00053023          	sd	zero,0(a0)
    thread_t t=&threads[0]; //dodela da bismo sklonili upozorenje
    for(int i=0;i<MAX_THREADS;i++){
    80001e30:	00000713          	li	a4,0
    80001e34:	03f00793          	li	a5,63
    80001e38:	0ae7cc63          	blt	a5,a4,80001ef0 <kern_thread_create+0xd0>
        if(threads[i].status==UNUSED){
    80001e3c:	00171793          	slli	a5,a4,0x1
    80001e40:	00e787b3          	add	a5,a5,a4
    80001e44:	00579793          	slli	a5,a5,0x5
    80001e48:	00005817          	auipc	a6,0x5
    80001e4c:	84880813          	addi	a6,a6,-1976 # 80006690 <threads>
    80001e50:	00f807b3          	add	a5,a6,a5
    80001e54:	0507a783          	lw	a5,80(a5)
    80001e58:	00078663          	beqz	a5,80001e64 <kern_thread_create+0x44>
    for(int i=0;i<MAX_THREADS;i++){
    80001e5c:	0017071b          	addiw	a4,a4,1
    80001e60:	fd5ff06f          	j	80001e34 <kern_thread_create+0x14>
            *handle=&threads[i];
    80001e64:	00171793          	slli	a5,a4,0x1
    80001e68:	00e787b3          	add	a5,a5,a4
    80001e6c:	00579793          	slli	a5,a5,0x5
    80001e70:	010787b3          	add	a5,a5,a6
    80001e74:	00f53023          	sd	a5,0(a0)
            t=&threads[i];
            break;
        }
    }
    if(*handle==0) return -1;
    80001e78:	00053703          	ld	a4,0(a0)
    80001e7c:	08070063          	beqz	a4,80001efc <kern_thread_create+0xdc>

    t->id=++id;
    80001e80:	00003517          	auipc	a0,0x3
    80001e84:	7e850513          	addi	a0,a0,2024 # 80005668 <id>
    80001e88:	00052703          	lw	a4,0(a0)
    80001e8c:	0017071b          	addiw	a4,a4,1
    80001e90:	0007081b          	sext.w	a6,a4
    80001e94:	00e52023          	sw	a4,0(a0)
    80001e98:	0107b823          	sd	a6,16(a5)
    t->status=READY;
    80001e9c:	00200713          	li	a4,2
    80001ea0:	04e7a823          	sw	a4,80(a5)
    t->arg=arg;
    80001ea4:	02c7b023          	sd	a2,32(a5)
    t->joined_tid=-1;
    80001ea8:	fff00713          	li	a4,-1
    80001eac:	02e7b423          	sd	a4,40(a5)
    t->timeslice=DEFAULT_TIME_SLICE;
    80001eb0:	00200713          	li	a4,2
    80001eb4:	02e7b823          	sd	a4,48(a5)
    t->body=start_routine;
    80001eb8:	00b7bc23          	sd	a1,24(a5)
    t->stack_space = ((uint64)stack_space);
    80001ebc:	04d7b023          	sd	a3,64(a5)
    t->sp = t->stack_space+(DEFAULT_STACK_SIZE);
    80001ec0:	00001737          	lui	a4,0x1
    80001ec4:	00e686b3          	add	a3,a3,a4
    80001ec8:	00d7b423          	sd	a3,8(a5)
    t->ra=(uint64) &kern_thread_wrapper;
    80001ecc:	00000717          	auipc	a4,0x0
    80001ed0:	e7070713          	addi	a4,a4,-400 # 80001d3c <kern_thread_wrapper>
    80001ed4:	00e7b023          	sd	a4,0(a5)
    t->sem_next=0;
    80001ed8:	0407bc23          	sd	zero,88(a5)
    t->mailbox=0;
    80001edc:	0407b423          	sd	zero,72(a5)

    return 0;
    80001ee0:	00000513          	li	a0,0
}
    80001ee4:	00813403          	ld	s0,8(sp)
    80001ee8:	01010113          	addi	sp,sp,16
    80001eec:	00008067          	ret
    thread_t t=&threads[0]; //dodela da bismo sklonili upozorenje
    80001ef0:	00004797          	auipc	a5,0x4
    80001ef4:	7a078793          	addi	a5,a5,1952 # 80006690 <threads>
    80001ef8:	f81ff06f          	j	80001e78 <kern_thread_create+0x58>
    if(*handle==0) return -1;
    80001efc:	fff00513          	li	a0,-1
    80001f00:	fe5ff06f          	j	80001ee4 <kern_thread_create+0xc4>

0000000080001f04 <kern_thread_join>:

void kern_thread_join(thread_t handle)
{
    if(handle->status==UNUSED) return;
    80001f04:	05052783          	lw	a5,80(a0)
    80001f08:	00079463          	bnez	a5,80001f10 <kern_thread_join+0xc>
    80001f0c:	00008067          	ret
{
    80001f10:	ff010113          	addi	sp,sp,-16
    80001f14:	00113423          	sd	ra,8(sp)
    80001f18:	00813023          	sd	s0,0(sp)
    80001f1c:	01010413          	addi	s0,sp,16
    running->joined_tid=handle->id;
    80001f20:	00003797          	auipc	a5,0x3
    80001f24:	7407b783          	ld	a5,1856(a5) # 80005660 <running>
    80001f28:	01053703          	ld	a4,16(a0)
    80001f2c:	02e7b423          	sd	a4,40(a5)
    running->status=JOINED;
    80001f30:	00400713          	li	a4,4
    80001f34:	04e7a823          	sw	a4,80(a5)
    kern_thread_dispatch();
    80001f38:	00000097          	auipc	ra,0x0
    80001f3c:	c98080e7          	jalr	-872(ra) # 80001bd0 <kern_thread_dispatch>
}
    80001f40:	00813083          	ld	ra,8(sp)
    80001f44:	00013403          	ld	s0,0(sp)
    80001f48:	01010113          	addi	sp,sp,16
    80001f4c:	00008067          	ret

0000000080001f50 <kern_thread_wakeup>:

void kern_thread_wakeup(uint64 system_time)
{
    80001f50:	ff010113          	addi	sp,sp,-16
    80001f54:	00813423          	sd	s0,8(sp)
    80001f58:	01010413          	addi	s0,sp,16
    for(int i=0;i<MAX_THREADS;i++){
    80001f5c:	00000793          	li	a5,0
    80001f60:	0080006f          	j	80001f68 <kern_thread_wakeup+0x18>
    80001f64:	0017879b          	addiw	a5,a5,1
    80001f68:	03f00713          	li	a4,63
    80001f6c:	06f74263          	blt	a4,a5,80001fd0 <kern_thread_wakeup+0x80>
        if(threads[i].status==SLEEPING && threads[i].endTime<system_time){
    80001f70:	00179713          	slli	a4,a5,0x1
    80001f74:	00f70733          	add	a4,a4,a5
    80001f78:	00571713          	slli	a4,a4,0x5
    80001f7c:	00004697          	auipc	a3,0x4
    80001f80:	71468693          	addi	a3,a3,1812 # 80006690 <threads>
    80001f84:	00e68733          	add	a4,a3,a4
    80001f88:	05072683          	lw	a3,80(a4)
    80001f8c:	00500713          	li	a4,5
    80001f90:	fce69ae3          	bne	a3,a4,80001f64 <kern_thread_wakeup+0x14>
    80001f94:	00179713          	slli	a4,a5,0x1
    80001f98:	00f70733          	add	a4,a4,a5
    80001f9c:	00571713          	slli	a4,a4,0x5
    80001fa0:	00004697          	auipc	a3,0x4
    80001fa4:	6f068693          	addi	a3,a3,1776 # 80006690 <threads>
    80001fa8:	00e68733          	add	a4,a3,a4
    80001fac:	03873703          	ld	a4,56(a4)
    80001fb0:	faa77ae3          	bgeu	a4,a0,80001f64 <kern_thread_wakeup+0x14>
            threads[i].status=READY;
    80001fb4:	00179713          	slli	a4,a5,0x1
    80001fb8:	00f70733          	add	a4,a4,a5
    80001fbc:	00571713          	slli	a4,a4,0x5
    80001fc0:	00e68733          	add	a4,a3,a4
    80001fc4:	00200693          	li	a3,2
    80001fc8:	04d72823          	sw	a3,80(a4)
    80001fcc:	f99ff06f          	j	80001f64 <kern_thread_wakeup+0x14>
        }
    }
}
    80001fd0:	00813403          	ld	s0,8(sp)
    80001fd4:	01010113          	addi	sp,sp,16
    80001fd8:	00008067          	ret

0000000080001fdc <mem_alloc>:
#include "../h/kern_interrupts.h"

#include <stdarg.h>


void* mem_alloc (size_t size){
    80001fdc:	fe010113          	addi	sp,sp,-32
    80001fe0:	00113c23          	sd	ra,24(sp)
    80001fe4:	00813823          	sd	s0,16(sp)
    80001fe8:	02010413          	addi	s0,sp,32
    uint64 blocks = (size+MEM_BLOCK_SIZE-1)/MEM_BLOCK_SIZE;
    80001fec:	03f50593          	addi	a1,a0,63
    kern_syscall(MEM_ALLOC, blocks);
    80001ff0:	0065d593          	srli	a1,a1,0x6
    80001ff4:	00100513          	li	a0,1
    80001ff8:	fffff097          	auipc	ra,0xfffff
    80001ffc:	610080e7          	jalr	1552(ra) # 80001608 <kern_syscall>
    __asm__ volatile ("mv %[a0], a0" : [a0] "=r"(a0));
    80002000:	00050793          	mv	a5,a0
    80002004:	fef43423          	sd	a5,-24(s0)
    return a0;
    80002008:	fe843503          	ld	a0,-24(s0)
    uint64 newBlockAddr = r_a0();
    return (void *) newBlockAddr;
}
    8000200c:	01813083          	ld	ra,24(sp)
    80002010:	01013403          	ld	s0,16(sp)
    80002014:	02010113          	addi	sp,sp,32
    80002018:	00008067          	ret

000000008000201c <mem_free>:

int mem_free (void* addr){
    8000201c:	fe010113          	addi	sp,sp,-32
    80002020:	00113c23          	sd	ra,24(sp)
    80002024:	00813823          	sd	s0,16(sp)
    80002028:	02010413          	addi	s0,sp,32
    8000202c:	00050593          	mv	a1,a0
    kern_syscall(MEM_FREE,addr);
    80002030:	00200513          	li	a0,2
    80002034:	fffff097          	auipc	ra,0xfffff
    80002038:	5d4080e7          	jalr	1492(ra) # 80001608 <kern_syscall>
    __asm__ volatile ("mv %[a0], a0" : [a0] "=r"(a0));
    8000203c:	00050793          	mv	a5,a0
    80002040:	fef43423          	sd	a5,-24(s0)
    return a0;
    80002044:	fe843503          	ld	a0,-24(s0)
    int res = (int) r_a0();
    return res;
}
    80002048:	0005051b          	sext.w	a0,a0
    8000204c:	01813083          	ld	ra,24(sp)
    80002050:	01013403          	ld	s0,16(sp)
    80002054:	02010113          	addi	sp,sp,32
    80002058:	00008067          	ret

000000008000205c <thread_create>:

struct thread_s;
typedef struct thread_s* thread_t;

int thread_create (thread_t* handle, void(*start_routine)(void*), void* arg)
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
    void * stack = mem_alloc(DEFAULT_STACK_SIZE);
    80002084:	00001537          	lui	a0,0x1
    80002088:	00000097          	auipc	ra,0x0
    8000208c:	f54080e7          	jalr	-172(ra) # 80001fdc <mem_alloc>
    if(stack==0) return -1;
    80002090:	04050663          	beqz	a0,800020dc <thread_create+0x80>
    80002094:	00050713          	mv	a4,a0
    kern_syscall(THREAD_CREATE,handle,start_routine,arg,stack);
    80002098:	00098693          	mv	a3,s3
    8000209c:	00090613          	mv	a2,s2
    800020a0:	00048593          	mv	a1,s1
    800020a4:	01100513          	li	a0,17
    800020a8:	fffff097          	auipc	ra,0xfffff
    800020ac:	560080e7          	jalr	1376(ra) # 80001608 <kern_syscall>
    __asm__ volatile ("mv %[a0], a0" : [a0] "=r"(a0));
    800020b0:	00050793          	mv	a5,a0
    800020b4:	fcf43423          	sd	a5,-56(s0)
    return a0;
    800020b8:	fc843503          	ld	a0,-56(s0)
    int res = r_a0();
    800020bc:	0005051b          	sext.w	a0,a0
    return res;
}
    800020c0:	03813083          	ld	ra,56(sp)
    800020c4:	03013403          	ld	s0,48(sp)
    800020c8:	02813483          	ld	s1,40(sp)
    800020cc:	02013903          	ld	s2,32(sp)
    800020d0:	01813983          	ld	s3,24(sp)
    800020d4:	04010113          	addi	sp,sp,64
    800020d8:	00008067          	ret
    if(stack==0) return -1;
    800020dc:	fff00513          	li	a0,-1
    800020e0:	fe1ff06f          	j	800020c0 <thread_create+0x64>

00000000800020e4 <thread_dispatch>:

void thread_dispatch(){
    800020e4:	ff010113          	addi	sp,sp,-16
    800020e8:	00113423          	sd	ra,8(sp)
    800020ec:	00813023          	sd	s0,0(sp)
    800020f0:	01010413          	addi	s0,sp,16
    kern_syscall(THREAD_DISPATCH);
    800020f4:	01300513          	li	a0,19
    800020f8:	fffff097          	auipc	ra,0xfffff
    800020fc:	510080e7          	jalr	1296(ra) # 80001608 <kern_syscall>
}
    80002100:	00813083          	ld	ra,8(sp)
    80002104:	00013403          	ld	s0,0(sp)
    80002108:	01010113          	addi	sp,sp,16
    8000210c:	00008067          	ret

0000000080002110 <thread_exit>:

int thread_exit ()
{
    80002110:	fe010113          	addi	sp,sp,-32
    80002114:	00113c23          	sd	ra,24(sp)
    80002118:	00813823          	sd	s0,16(sp)
    8000211c:	00913423          	sd	s1,8(sp)
    80002120:	02010413          	addi	s0,sp,32
    void* stack = (void*)running->stack_space;
    80002124:	00003797          	auipc	a5,0x3
    80002128:	53c7b783          	ld	a5,1340(a5) # 80005660 <running>
    8000212c:	0407b483          	ld	s1,64(a5)
    kern_syscall(THREAD_EXIT);
    80002130:	01200513          	li	a0,18
    80002134:	fffff097          	auipc	ra,0xfffff
    80002138:	4d4080e7          	jalr	1236(ra) # 80001608 <kern_syscall>
    kern_syscall(MEM_FREE,stack);
    8000213c:	00048593          	mv	a1,s1
    80002140:	00200513          	li	a0,2
    80002144:	fffff097          	auipc	ra,0xfffff
    80002148:	4c4080e7          	jalr	1220(ra) # 80001608 <kern_syscall>
    return 0;
}
    8000214c:	00000513          	li	a0,0
    80002150:	01813083          	ld	ra,24(sp)
    80002154:	01013403          	ld	s0,16(sp)
    80002158:	00813483          	ld	s1,8(sp)
    8000215c:	02010113          	addi	sp,sp,32
    80002160:	00008067          	ret

0000000080002164 <thread_join>:

void thread_join(thread_t handle)
{
    80002164:	ff010113          	addi	sp,sp,-16
    80002168:	00113423          	sd	ra,8(sp)
    8000216c:	00813023          	sd	s0,0(sp)
    80002170:	01010413          	addi	s0,sp,16
    80002174:	00050593          	mv	a1,a0
    kern_syscall(THREAD_JOIN,handle);
    80002178:	01400513          	li	a0,20
    8000217c:	fffff097          	auipc	ra,0xfffff
    80002180:	48c080e7          	jalr	1164(ra) # 80001608 <kern_syscall>
}
    80002184:	00813083          	ld	ra,8(sp)
    80002188:	00013403          	ld	s0,0(sp)
    8000218c:	01010113          	addi	sp,sp,16
    80002190:	00008067          	ret

0000000080002194 <sem_open>:

int sem_open (sem_t* handle, unsigned init)
{
    80002194:	fe010113          	addi	sp,sp,-32
    80002198:	00113c23          	sd	ra,24(sp)
    8000219c:	00813823          	sd	s0,16(sp)
    800021a0:	02010413          	addi	s0,sp,32
    800021a4:	00058613          	mv	a2,a1
    kern_syscall(SEM_OPEN,handle,init);
    800021a8:	00050593          	mv	a1,a0
    800021ac:	02100513          	li	a0,33
    800021b0:	fffff097          	auipc	ra,0xfffff
    800021b4:	458080e7          	jalr	1112(ra) # 80001608 <kern_syscall>
    __asm__ volatile ("mv %[a0], a0" : [a0] "=r"(a0));
    800021b8:	00050793          	mv	a5,a0
    800021bc:	fef43423          	sd	a5,-24(s0)
    return a0;
    800021c0:	fe843503          	ld	a0,-24(s0)
    int res = r_a0();
    return res;
}
    800021c4:	0005051b          	sext.w	a0,a0
    800021c8:	01813083          	ld	ra,24(sp)
    800021cc:	01013403          	ld	s0,16(sp)
    800021d0:	02010113          	addi	sp,sp,32
    800021d4:	00008067          	ret

00000000800021d8 <sem_close>:

int sem_close (sem_t handle)
{
    800021d8:	fe010113          	addi	sp,sp,-32
    800021dc:	00113c23          	sd	ra,24(sp)
    800021e0:	00813823          	sd	s0,16(sp)
    800021e4:	02010413          	addi	s0,sp,32
    800021e8:	00050593          	mv	a1,a0
    kern_syscall(SEM_CLOSE,handle);
    800021ec:	02200513          	li	a0,34
    800021f0:	fffff097          	auipc	ra,0xfffff
    800021f4:	418080e7          	jalr	1048(ra) # 80001608 <kern_syscall>
    __asm__ volatile ("mv %[a0], a0" : [a0] "=r"(a0));
    800021f8:	00050793          	mv	a5,a0
    800021fc:	fef43423          	sd	a5,-24(s0)
    return a0;
    80002200:	fe843503          	ld	a0,-24(s0)
    int res = r_a0();
    return res;
}
    80002204:	0005051b          	sext.w	a0,a0
    80002208:	01813083          	ld	ra,24(sp)
    8000220c:	01013403          	ld	s0,16(sp)
    80002210:	02010113          	addi	sp,sp,32
    80002214:	00008067          	ret

0000000080002218 <sem_wait>:

int sem_wait (sem_t id)
{
    80002218:	fe010113          	addi	sp,sp,-32
    8000221c:	00113c23          	sd	ra,24(sp)
    80002220:	00813823          	sd	s0,16(sp)
    80002224:	02010413          	addi	s0,sp,32
    80002228:	00050593          	mv	a1,a0
    kern_syscall(SEM_WAIT,id);
    8000222c:	02300513          	li	a0,35
    80002230:	fffff097          	auipc	ra,0xfffff
    80002234:	3d8080e7          	jalr	984(ra) # 80001608 <kern_syscall>
    __asm__ volatile ("mv %[a0], a0" : [a0] "=r"(a0));
    80002238:	00050793          	mv	a5,a0
    8000223c:	fef43423          	sd	a5,-24(s0)
    return a0;
    80002240:	fe843503          	ld	a0,-24(s0)
    int res = r_a0();
    return res;
}
    80002244:	0005051b          	sext.w	a0,a0
    80002248:	01813083          	ld	ra,24(sp)
    8000224c:	01013403          	ld	s0,16(sp)
    80002250:	02010113          	addi	sp,sp,32
    80002254:	00008067          	ret

0000000080002258 <sem_signal>:

int sem_signal (sem_t id){
    80002258:	fe010113          	addi	sp,sp,-32
    8000225c:	00113c23          	sd	ra,24(sp)
    80002260:	00813823          	sd	s0,16(sp)
    80002264:	02010413          	addi	s0,sp,32
    80002268:	00050593          	mv	a1,a0
    kern_syscall(SEM_SIGNAL,id);
    8000226c:	02400513          	li	a0,36
    80002270:	fffff097          	auipc	ra,0xfffff
    80002274:	398080e7          	jalr	920(ra) # 80001608 <kern_syscall>
    __asm__ volatile ("mv %[a0], a0" : [a0] "=r"(a0));
    80002278:	00050793          	mv	a5,a0
    8000227c:	fef43423          	sd	a5,-24(s0)
    return a0;
    80002280:	fe843503          	ld	a0,-24(s0)
    int res = r_a0();
    return res;
}
    80002284:	0005051b          	sext.w	a0,a0
    80002288:	01813083          	ld	ra,24(sp)
    8000228c:	01013403          	ld	s0,16(sp)
    80002290:	02010113          	addi	sp,sp,32
    80002294:	00008067          	ret

0000000080002298 <time_sleep>:

int time_sleep(unsigned long time){
    80002298:	ff010113          	addi	sp,sp,-16
    8000229c:	00113423          	sd	ra,8(sp)
    800022a0:	00813023          	sd	s0,0(sp)
    800022a4:	01010413          	addi	s0,sp,16
    800022a8:	00050593          	mv	a1,a0
    kern_syscall(TIME_SLEEP,time);
    800022ac:	03100513          	li	a0,49
    800022b0:	fffff097          	auipc	ra,0xfffff
    800022b4:	358080e7          	jalr	856(ra) # 80001608 <kern_syscall>
    return 0;
    800022b8:	00000513          	li	a0,0
    800022bc:	00813083          	ld	ra,8(sp)
    800022c0:	00013403          	ld	s0,0(sp)
    800022c4:	01010113          	addi	sp,sp,16
    800022c8:	00008067          	ret

00000000800022cc <kern_console_init>:
    int output_put_cursor;
    int output_get_cursor;
} console_instance;

void kern_console_init()
{
    800022cc:	ff010113          	addi	sp,sp,-16
    800022d0:	00113423          	sd	ra,8(sp)
    800022d4:	00813023          	sd	s0,0(sp)
    800022d8:	01010413          	addi	s0,sp,16
    console_instance.input_put_cursor=0;
    800022dc:	00007797          	auipc	a5,0x7
    800022e0:	bb478793          	addi	a5,a5,-1100 # 80008e90 <stack0+0x7a0>
    800022e4:	8007a823          	sw	zero,-2032(a5)
    console_instance.input_get_cursor=0;
    800022e8:	8007aa23          	sw	zero,-2028(a5)
    console_instance.output_put_cursor=0;
    800022ec:	8007ac23          	sw	zero,-2024(a5)
    console_instance.output_get_cursor=0;
    800022f0:	8007ae23          	sw	zero,-2020(a5)
    kern_sem_open(&console_instance.input_sem,0);
    800022f4:	00000593          	li	a1,0
    800022f8:	00006517          	auipc	a0,0x6
    800022fc:	39850513          	addi	a0,a0,920 # 80008690 <console_instance+0x800>
    80002300:	fffff097          	auipc	ra,0xfffff
    80002304:	fac080e7          	jalr	-84(ra) # 800012ac <kern_sem_open>
    kern_sem_open(&console_instance.output_sem,CONSOLE_BUFFER_SIZE);
    80002308:	40000593          	li	a1,1024
    8000230c:	00006517          	auipc	a0,0x6
    80002310:	38c50513          	addi	a0,a0,908 # 80008698 <console_instance+0x808>
    80002314:	fffff097          	auipc	ra,0xfffff
    80002318:	f98080e7          	jalr	-104(ra) # 800012ac <kern_sem_open>
}
    8000231c:	00813083          	ld	ra,8(sp)
    80002320:	00013403          	ld	s0,0(sp)
    80002324:	01010113          	addi	sp,sp,16
    80002328:	00008067          	ret

000000008000232c <kern_console_putc>:

void kern_console_putc()
{
    8000232c:	ff010113          	addi	sp,sp,-16
    80002330:	00813423          	sd	s0,8(sp)
    80002334:	01010413          	addi	s0,sp,16

}
    80002338:	00813403          	ld	s0,8(sp)
    8000233c:	01010113          	addi	sp,sp,16
    80002340:	00008067          	ret

0000000080002344 <_Z8bodyIdlePv>:

Semaphore* semTest;

int idleAlive=1;
void bodyIdle(void* arg){
    while(idleAlive){
    80002344:	00003797          	auipc	a5,0x3
    80002348:	25c7a783          	lw	a5,604(a5) # 800055a0 <idleAlive>
    8000234c:	02078c63          	beqz	a5,80002384 <_Z8bodyIdlePv+0x40>
void bodyIdle(void* arg){
    80002350:	ff010113          	addi	sp,sp,-16
    80002354:	00113423          	sd	ra,8(sp)
    80002358:	00813023          	sd	s0,0(sp)
    8000235c:	01010413          	addi	s0,sp,16
        thread_dispatch();
    80002360:	00000097          	auipc	ra,0x0
    80002364:	d84080e7          	jalr	-636(ra) # 800020e4 <thread_dispatch>
    while(idleAlive){
    80002368:	00003797          	auipc	a5,0x3
    8000236c:	2387a783          	lw	a5,568(a5) # 800055a0 <idleAlive>
    80002370:	fe0798e3          	bnez	a5,80002360 <_Z8bodyIdlePv+0x1c>
    };
}
    80002374:	00813083          	ld	ra,8(sp)
    80002378:	00013403          	ld	s0,0(sp)
    8000237c:	01010113          	addi	sp,sp,16
    80002380:	00008067          	ret
    80002384:	00008067          	ret

0000000080002388 <_Z5bodyCPv>:

void bodyC(void* arg)
{
    80002388:	fe010113          	addi	sp,sp,-32
    8000238c:	00113c23          	sd	ra,24(sp)
    80002390:	00813823          	sd	s0,16(sp)
    80002394:	00913423          	sd	s1,8(sp)
    80002398:	01213023          	sd	s2,0(sp)
    8000239c:	02010413          	addi	s0,sp,32
    800023a0:	00050913          	mv	s2,a0
    int counter=0;
    800023a4:	00000493          	li	s1,0
    char*c = (char*)arg;
    while(counter<10){
    800023a8:	00900793          	li	a5,9
    800023ac:	0297c263          	blt	a5,s1,800023d0 <_Z5bodyCPv+0x48>
        //if(++counter>5) delete semTest;
        __putc(*c);
    800023b0:	00094503          	lbu	a0,0(s2)
    800023b4:	00002097          	auipc	ra,0x2
    800023b8:	5e8080e7          	jalr	1512(ra) # 8000499c <__putc>
        time_sleep(5);
    800023bc:	00500513          	li	a0,5
    800023c0:	00000097          	auipc	ra,0x0
    800023c4:	ed8080e7          	jalr	-296(ra) # 80002298 <time_sleep>
        counter++;
    800023c8:	0014849b          	addiw	s1,s1,1
    while(counter<10){
    800023cc:	fddff06f          	j	800023a8 <_Z5bodyCPv+0x20>
    }
}
    800023d0:	01813083          	ld	ra,24(sp)
    800023d4:	01013403          	ld	s0,16(sp)
    800023d8:	00813483          	ld	s1,8(sp)
    800023dc:	00013903          	ld	s2,0(sp)
    800023e0:	02010113          	addi	sp,sp,32
    800023e4:	00008067          	ret

00000000800023e8 <_Z5bodyAPv>:

void bodyA(void* arg)
{
    800023e8:	fe010113          	addi	sp,sp,-32
    800023ec:	00113c23          	sd	ra,24(sp)
    800023f0:	00813823          	sd	s0,16(sp)
    800023f4:	00913423          	sd	s1,8(sp)
    800023f8:	01213023          	sd	s2,0(sp)
    800023fc:	02010413          	addi	s0,sp,32
        }
        virtual ~Semaphore (){
            sem_close(myHandle);
        }
        int wait (){
            return sem_wait(myHandle);
    80002400:	00006797          	auipc	a5,0x6
    80002404:	2b07b783          	ld	a5,688(a5) # 800086b0 <semTest>
    80002408:	0087b503          	ld	a0,8(a5)
    8000240c:	00000097          	auipc	ra,0x0
    80002410:	e0c080e7          	jalr	-500(ra) # 80002218 <sem_wait>
    char c = 'a';
    if(semTest->wait()) c='A';
    80002414:	00051863          	bnez	a0,80002424 <_Z5bodyAPv+0x3c>
    char c = 'a';
    80002418:	06100913          	li	s2,97
    for(int i=0;i<10;i++){
    8000241c:	00000493          	li	s1,0
    80002420:	0200006f          	j	80002440 <_Z5bodyAPv+0x58>
    if(semTest->wait()) c='A';
    80002424:	04100913          	li	s2,65
    80002428:	ff5ff06f          	j	8000241c <_Z5bodyAPv+0x34>
        __putc(c);
        if(i==5) thread_exit();
    8000242c:	00000097          	auipc	ra,0x0
    80002430:	ce4080e7          	jalr	-796(ra) # 80002110 <thread_exit>
        thread_dispatch();
    80002434:	00000097          	auipc	ra,0x0
    80002438:	cb0080e7          	jalr	-848(ra) # 800020e4 <thread_dispatch>
    for(int i=0;i<10;i++){
    8000243c:	0014849b          	addiw	s1,s1,1
    80002440:	00900793          	li	a5,9
    80002444:	0097ce63          	blt	a5,s1,80002460 <_Z5bodyAPv+0x78>
        __putc(c);
    80002448:	00090513          	mv	a0,s2
    8000244c:	00002097          	auipc	ra,0x2
    80002450:	550080e7          	jalr	1360(ra) # 8000499c <__putc>
        if(i==5) thread_exit();
    80002454:	00500793          	li	a5,5
    80002458:	fcf49ee3          	bne	s1,a5,80002434 <_Z5bodyAPv+0x4c>
    8000245c:	fd1ff06f          	j	8000242c <_Z5bodyAPv+0x44>
    }
}
    80002460:	01813083          	ld	ra,24(sp)
    80002464:	01013403          	ld	s0,16(sp)
    80002468:	00813483          	ld	s1,8(sp)
    8000246c:	00013903          	ld	s2,0(sp)
    80002470:	02010113          	addi	sp,sp,32
    80002474:	00008067          	ret

0000000080002478 <_Z5bodyBPv>:

int g=0;

char str[15] = "tesa legenda";
void bodyB(void* arg)
{
    80002478:	fe010113          	addi	sp,sp,-32
    8000247c:	00113c23          	sd	ra,24(sp)
    80002480:	00813823          	sd	s0,16(sp)
    80002484:	00913423          	sd	s1,8(sp)
    80002488:	02010413          	addi	s0,sp,32
    time_sleep(10);
    8000248c:	00a00513          	li	a0,10
    80002490:	00000097          	auipc	ra,0x0
    80002494:	e08080e7          	jalr	-504(ra) # 80002298 <time_sleep>
    for(int i=0;i<15;i++){
    80002498:	00000493          	li	s1,0
    8000249c:	0540006f          	j	800024f0 <_Z5bodyBPv+0x78>
        __putc(str[i]);
        for(int k=0;k<10000;k++){
            for(int m=0;m<1000;m++){
    800024a0:	0017071b          	addiw	a4,a4,1
    800024a4:	3e700793          	li	a5,999
    800024a8:	02e7c663          	blt	a5,a4,800024d4 <_Z5bodyBPv+0x5c>
                if((m*k)%1337==0) g++;
    800024ac:	02e607bb          	mulw	a5,a2,a4
    800024b0:	53900693          	li	a3,1337
    800024b4:	02d7e7bb          	remw	a5,a5,a3
    800024b8:	fe0794e3          	bnez	a5,800024a0 <_Z5bodyBPv+0x28>
    800024bc:	00006697          	auipc	a3,0x6
    800024c0:	1f468693          	addi	a3,a3,500 # 800086b0 <semTest>
    800024c4:	0086a783          	lw	a5,8(a3)
    800024c8:	0017879b          	addiw	a5,a5,1
    800024cc:	00f6a423          	sw	a5,8(a3)
    800024d0:	fd1ff06f          	j	800024a0 <_Z5bodyBPv+0x28>
        for(int k=0;k<10000;k++){
    800024d4:	0016061b          	addiw	a2,a2,1
    800024d8:	000027b7          	lui	a5,0x2
    800024dc:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    800024e0:	00c7c663          	blt	a5,a2,800024ec <_Z5bodyBPv+0x74>
            for(int m=0;m<1000;m++){
    800024e4:	00000713          	li	a4,0
    800024e8:	fbdff06f          	j	800024a4 <_Z5bodyBPv+0x2c>
    for(int i=0;i<15;i++){
    800024ec:	0014849b          	addiw	s1,s1,1
    800024f0:	00e00793          	li	a5,14
    800024f4:	0297c263          	blt	a5,s1,80002518 <_Z5bodyBPv+0xa0>
        __putc(str[i]);
    800024f8:	00003797          	auipc	a5,0x3
    800024fc:	0a878793          	addi	a5,a5,168 # 800055a0 <idleAlive>
    80002500:	009787b3          	add	a5,a5,s1
    80002504:	0087c503          	lbu	a0,8(a5)
    80002508:	00002097          	auipc	ra,0x2
    8000250c:	494080e7          	jalr	1172(ra) # 8000499c <__putc>
        for(int k=0;k<10000;k++){
    80002510:	00000613          	li	a2,0
    80002514:	fc5ff06f          	j	800024d8 <_Z5bodyBPv+0x60>
        }
        int signal (){
            return sem_signal(myHandle);
    80002518:	00006797          	auipc	a5,0x6
    8000251c:	1987b783          	ld	a5,408(a5) # 800086b0 <semTest>
    80002520:	0087b503          	ld	a0,8(a5)
    80002524:	00000097          	auipc	ra,0x0
    80002528:	d34080e7          	jalr	-716(ra) # 80002258 <sem_signal>
            }
        }
    }
    semTest->signal();
}
    8000252c:	01813083          	ld	ra,24(sp)
    80002530:	01013403          	ld	s0,16(sp)
    80002534:	00813483          	ld	s1,8(sp)
    80002538:	02010113          	addi	sp,sp,32
    8000253c:	00008067          	ret

0000000080002540 <_Znwm>:
void* operator new(size_t size) {
    80002540:	ff010113          	addi	sp,sp,-16
    80002544:	00113423          	sd	ra,8(sp)
    80002548:	00813023          	sd	s0,0(sp)
    8000254c:	01010413          	addi	s0,sp,16
    void* ptr = mem_alloc(size);
    80002550:	00000097          	auipc	ra,0x0
    80002554:	a8c080e7          	jalr	-1396(ra) # 80001fdc <mem_alloc>
}
    80002558:	00813083          	ld	ra,8(sp)
    8000255c:	00013403          	ld	s0,0(sp)
    80002560:	01010113          	addi	sp,sp,16
    80002564:	00008067          	ret

0000000080002568 <_ZdlPv>:
void operator delete(void* ptr) {
    80002568:	ff010113          	addi	sp,sp,-16
    8000256c:	00113423          	sd	ra,8(sp)
    80002570:	00813023          	sd	s0,0(sp)
    80002574:	01010413          	addi	s0,sp,16
    mem_free(ptr);
    80002578:	00000097          	auipc	ra,0x0
    8000257c:	aa4080e7          	jalr	-1372(ra) # 8000201c <mem_free>
}
    80002580:	00813083          	ld	ra,8(sp)
    80002584:	00013403          	ld	s0,0(sp)
    80002588:	01010113          	addi	sp,sp,16
    8000258c:	00008067          	ret

0000000080002590 <main>:


int main()
{
    80002590:	fc010113          	addi	sp,sp,-64
    80002594:	02113c23          	sd	ra,56(sp)
    80002598:	02813823          	sd	s0,48(sp)
    8000259c:	02913423          	sd	s1,40(sp)
    800025a0:	03213023          	sd	s2,32(sp)
    800025a4:	01313c23          	sd	s3,24(sp)
    800025a8:	04010413          	addi	s0,sp,64
    kern_thread_init();
    800025ac:	fffff097          	auipc	ra,0xfffff
    800025b0:	484080e7          	jalr	1156(ra) # 80001a30 <kern_thread_init>
    //printstring("lalala");

    kern_mem_init((void*)HEAP_START_ADDR, (void*)HEAP_END_ADDR);
    800025b4:	00003797          	auipc	a5,0x3
    800025b8:	06c7b783          	ld	a5,108(a5) # 80005620 <_GLOBAL_OFFSET_TABLE_+0x18>
    800025bc:	0007b583          	ld	a1,0(a5)
    800025c0:	00003797          	auipc	a5,0x3
    800025c4:	0507b783          	ld	a5,80(a5) # 80005610 <_GLOBAL_OFFSET_TABLE_+0x8>
    800025c8:	0007b503          	ld	a0,0(a5)
    800025cc:	fffff097          	auipc	ra,0xfffff
    800025d0:	fcc080e7          	jalr	-52(ra) # 80001598 <kern_mem_init>
    kern_interrupt_init();
    800025d4:	fffff097          	auipc	ra,0xfffff
    800025d8:	06c080e7          	jalr	108(ra) # 80001640 <kern_interrupt_init>
    kern_sem_init();
    800025dc:	fffff097          	auipc	ra,0xfffff
    800025e0:	c84080e7          	jalr	-892(ra) # 80001260 <kern_sem_init>

    Thread* thrIdle = new Thread(&bodyIdle,0);
    800025e4:	02000513          	li	a0,32
    800025e8:	00000097          	auipc	ra,0x0
    800025ec:	f58080e7          	jalr	-168(ra) # 80002540 <_Znwm>
        {
    800025f0:	00003797          	auipc	a5,0x3
    800025f4:	fd878793          	addi	a5,a5,-40 # 800055c8 <_ZTV6Thread+0x10>
    800025f8:	00f53023          	sd	a5,0(a0)
            this->body=body;
    800025fc:	00000597          	auipc	a1,0x0
    80002600:	d4858593          	addi	a1,a1,-696 # 80002344 <_Z8bodyIdlePv>
    80002604:	00b53823          	sd	a1,16(a0)
            this->arg=arg;
    80002608:	00053c23          	sd	zero,24(a0)
            return thread_create(&myHandle,body,arg);
    8000260c:	00000613          	li	a2,0
    80002610:	00850513          	addi	a0,a0,8
    80002614:	00000097          	auipc	ra,0x0
    80002618:	a48080e7          	jalr	-1464(ra) # 8000205c <thread_create>
    a= mem_alloc(64);
    mem_free(a);
    */


    semTest=new Semaphore(0);
    8000261c:	01000513          	li	a0,16
    80002620:	00000097          	auipc	ra,0x0
    80002624:	f20080e7          	jalr	-224(ra) # 80002540 <_Znwm>
    80002628:	00050493          	mv	s1,a0
        Semaphore (unsigned init = 1){
    8000262c:	00003797          	auipc	a5,0x3
    80002630:	fc478793          	addi	a5,a5,-60 # 800055f0 <_ZTV9Semaphore+0x10>
    80002634:	00f53023          	sd	a5,0(a0)
            sem_open(&myHandle,init);
    80002638:	00000593          	li	a1,0
    8000263c:	00850513          	addi	a0,a0,8
    80002640:	00000097          	auipc	ra,0x0
    80002644:	b54080e7          	jalr	-1196(ra) # 80002194 <sem_open>
    80002648:	00006797          	auipc	a5,0x6
    8000264c:	0697b423          	sd	s1,104(a5) # 800086b0 <semTest>
    Thread *thrA = new Thread(&bodyA,0);
    80002650:	02000513          	li	a0,32
    80002654:	00000097          	auipc	ra,0x0
    80002658:	eec080e7          	jalr	-276(ra) # 80002540 <_Znwm>
    8000265c:	00050913          	mv	s2,a0
        {
    80002660:	00003997          	auipc	s3,0x3
    80002664:	f6898993          	addi	s3,s3,-152 # 800055c8 <_ZTV6Thread+0x10>
    80002668:	01353023          	sd	s3,0(a0)
            this->body=body;
    8000266c:	00000797          	auipc	a5,0x0
    80002670:	d7c78793          	addi	a5,a5,-644 # 800023e8 <_Z5bodyAPv>
    80002674:	00f53823          	sd	a5,16(a0)
            this->arg=arg;
    80002678:	00053c23          	sd	zero,24(a0)
    Thread *thrB = new Thread(&bodyB,0);
    8000267c:	02000513          	li	a0,32
    80002680:	00000097          	auipc	ra,0x0
    80002684:	ec0080e7          	jalr	-320(ra) # 80002540 <_Znwm>
    80002688:	00050493          	mv	s1,a0
        {
    8000268c:	01353023          	sd	s3,0(a0)
            this->body=body;
    80002690:	00000797          	auipc	a5,0x0
    80002694:	de878793          	addi	a5,a5,-536 # 80002478 <_Z5bodyBPv>
    80002698:	00f53823          	sd	a5,16(a0)
            this->arg=arg;
    8000269c:	00053c23          	sd	zero,24(a0)
            return thread_create(&myHandle,body,arg);
    800026a0:	01893603          	ld	a2,24(s2)
    800026a4:	01093583          	ld	a1,16(s2)
    800026a8:	00890513          	addi	a0,s2,8
    800026ac:	00000097          	auipc	ra,0x0
    800026b0:	9b0080e7          	jalr	-1616(ra) # 8000205c <thread_create>
    800026b4:	0184b603          	ld	a2,24(s1)
    800026b8:	0104b583          	ld	a1,16(s1)
    800026bc:	00848513          	addi	a0,s1,8
    800026c0:	00000097          	auipc	ra,0x0
    800026c4:	99c080e7          	jalr	-1636(ra) # 8000205c <thread_create>
    thrA->start();
    thrB->start();
    __putc('S');
    800026c8:	05300513          	li	a0,83
    800026cc:	00002097          	auipc	ra,0x2
    800026d0:	2d0080e7          	jalr	720(ra) # 8000499c <__putc>
            thread_join(myHandle);
    800026d4:	0084b503          	ld	a0,8(s1)
    800026d8:	00000097          	auipc	ra,0x0
    800026dc:	a8c080e7          	jalr	-1396(ra) # 80002164 <thread_join>
    800026e0:	00893503          	ld	a0,8(s2)
    800026e4:	00000097          	auipc	ra,0x0
    800026e8:	a80080e7          	jalr	-1408(ra) # 80002164 <thread_join>
    800026ec:	0084b503          	ld	a0,8(s1)
    800026f0:	00000097          	auipc	ra,0x0
    800026f4:	a74080e7          	jalr	-1420(ra) # 80002164 <thread_join>
    thrB->join();
    thrA->join();
    thrB->join();
    char o='O';
    char c='M';
    c++;
    800026f8:	04e00793          	li	a5,78
    800026fc:	fcf40723          	sb	a5,-50(s0)
    o++;
    80002700:	05000793          	li	a5,80
    80002704:	fcf407a3          	sb	a5,-49(s0)
    Thread* thrCobj = new Thread(bodyC, &o);
    80002708:	02000513          	li	a0,32
    8000270c:	00000097          	auipc	ra,0x0
    80002710:	e34080e7          	jalr	-460(ra) # 80002540 <_Znwm>
    80002714:	00050493          	mv	s1,a0
        {
    80002718:	01353023          	sd	s3,0(a0)
            this->body=body;
    8000271c:	00000917          	auipc	s2,0x0
    80002720:	c6c90913          	addi	s2,s2,-916 # 80002388 <_Z5bodyCPv>
    80002724:	01253823          	sd	s2,16(a0)
            this->arg=arg;
    80002728:	fcf40613          	addi	a2,s0,-49
    8000272c:	00c53c23          	sd	a2,24(a0)
            return thread_create(&myHandle,body,arg);
    80002730:	00090593          	mv	a1,s2
    80002734:	00850513          	addi	a0,a0,8
    80002738:	00000097          	auipc	ra,0x0
    8000273c:	924080e7          	jalr	-1756(ra) # 8000205c <thread_create>
    thrCobj->start();
    thread_t thrC;
    thread_create(&thrC,bodyC,&c);
    80002740:	fce40613          	addi	a2,s0,-50
    80002744:	00090593          	mv	a1,s2
    80002748:	fc040513          	addi	a0,s0,-64
    8000274c:	00000097          	auipc	ra,0x0
    80002750:	910080e7          	jalr	-1776(ra) # 8000205c <thread_create>
    thread_join(thrC);
    80002754:	fc043503          	ld	a0,-64(s0)
    80002758:	00000097          	auipc	ra,0x0
    8000275c:	a0c080e7          	jalr	-1524(ra) # 80002164 <thread_join>
            thread_join(myHandle);
    80002760:	0084b503          	ld	a0,8(s1)
    80002764:	00000097          	auipc	ra,0x0
    80002768:	a00080e7          	jalr	-1536(ra) # 80002164 <thread_join>
    //idleAlive=0;
    thrCobj->join();
    delete thrCobj;
    8000276c:	00048a63          	beqz	s1,80002780 <main+0x1f0>
    80002770:	0004b783          	ld	a5,0(s1)
    80002774:	0087b783          	ld	a5,8(a5)
    80002778:	00048513          	mv	a0,s1
    8000277c:	000780e7          	jalr	a5

    __putc('E');
    80002780:	04500513          	li	a0,69
    80002784:	00002097          	auipc	ra,0x2
    80002788:	218080e7          	jalr	536(ra) # 8000499c <__putc>
    while(1);
    8000278c:	0000006f          	j	8000278c <main+0x1fc>
    80002790:	00050913          	mv	s2,a0
    semTest=new Semaphore(0);
    80002794:	00048513          	mv	a0,s1
    80002798:	00000097          	auipc	ra,0x0
    8000279c:	dd0080e7          	jalr	-560(ra) # 80002568 <_ZdlPv>
    800027a0:	00090513          	mv	a0,s2
    800027a4:	00007097          	auipc	ra,0x7
    800027a8:	fe4080e7          	jalr	-28(ra) # 80009788 <_Unwind_Resume>

00000000800027ac <_ZN6ThreadD1Ev>:
        virtual ~Thread (){
    800027ac:	ff010113          	addi	sp,sp,-16
    800027b0:	00813423          	sd	s0,8(sp)
    800027b4:	01010413          	addi	s0,sp,16
        }
    800027b8:	00813403          	ld	s0,8(sp)
    800027bc:	01010113          	addi	sp,sp,16
    800027c0:	00008067          	ret

00000000800027c4 <_ZN6Thread3runEv>:
        virtual void run () {}
    800027c4:	ff010113          	addi	sp,sp,-16
    800027c8:	00813423          	sd	s0,8(sp)
    800027cc:	01010413          	addi	s0,sp,16
    800027d0:	00813403          	ld	s0,8(sp)
    800027d4:	01010113          	addi	sp,sp,16
    800027d8:	00008067          	ret

00000000800027dc <_ZN9SemaphoreD1Ev>:
        virtual ~Semaphore (){
    800027dc:	ff010113          	addi	sp,sp,-16
    800027e0:	00113423          	sd	ra,8(sp)
    800027e4:	00813023          	sd	s0,0(sp)
    800027e8:	01010413          	addi	s0,sp,16
    800027ec:	00003797          	auipc	a5,0x3
    800027f0:	e0478793          	addi	a5,a5,-508 # 800055f0 <_ZTV9Semaphore+0x10>
    800027f4:	00f53023          	sd	a5,0(a0)
            sem_close(myHandle);
    800027f8:	00853503          	ld	a0,8(a0)
    800027fc:	00000097          	auipc	ra,0x0
    80002800:	9dc080e7          	jalr	-1572(ra) # 800021d8 <sem_close>
        }
    80002804:	00813083          	ld	ra,8(sp)
    80002808:	00013403          	ld	s0,0(sp)
    8000280c:	01010113          	addi	sp,sp,16
    80002810:	00008067          	ret

0000000080002814 <_ZN9SemaphoreD0Ev>:
        virtual ~Semaphore (){
    80002814:	fe010113          	addi	sp,sp,-32
    80002818:	00113c23          	sd	ra,24(sp)
    8000281c:	00813823          	sd	s0,16(sp)
    80002820:	00913423          	sd	s1,8(sp)
    80002824:	02010413          	addi	s0,sp,32
    80002828:	00050493          	mv	s1,a0
    8000282c:	00003797          	auipc	a5,0x3
    80002830:	dc478793          	addi	a5,a5,-572 # 800055f0 <_ZTV9Semaphore+0x10>
    80002834:	00f53023          	sd	a5,0(a0)
            sem_close(myHandle);
    80002838:	00853503          	ld	a0,8(a0)
    8000283c:	00000097          	auipc	ra,0x0
    80002840:	99c080e7          	jalr	-1636(ra) # 800021d8 <sem_close>
        }
    80002844:	00048513          	mv	a0,s1
    80002848:	00000097          	auipc	ra,0x0
    8000284c:	d20080e7          	jalr	-736(ra) # 80002568 <_ZdlPv>
    80002850:	01813083          	ld	ra,24(sp)
    80002854:	01013403          	ld	s0,16(sp)
    80002858:	00813483          	ld	s1,8(sp)
    8000285c:	02010113          	addi	sp,sp,32
    80002860:	00008067          	ret

0000000080002864 <_ZN6ThreadD0Ev>:
        virtual ~Thread (){
    80002864:	ff010113          	addi	sp,sp,-16
    80002868:	00113423          	sd	ra,8(sp)
    8000286c:	00813023          	sd	s0,0(sp)
    80002870:	01010413          	addi	s0,sp,16
        }
    80002874:	00000097          	auipc	ra,0x0
    80002878:	cf4080e7          	jalr	-780(ra) # 80002568 <_ZdlPv>
    8000287c:	00813083          	ld	ra,8(sp)
    80002880:	00013403          	ld	s0,0(sp)
    80002884:	01010113          	addi	sp,sp,16
    80002888:	00008067          	ret

000000008000288c <_Z11printstringPKc>:
//

#include "../h/strings.h"

void printstring(const char* string)
{
    8000288c:	fe010113          	addi	sp,sp,-32
    80002890:	00113c23          	sd	ra,24(sp)
    80002894:	00813823          	sd	s0,16(sp)
    80002898:	00913423          	sd	s1,8(sp)
    8000289c:	01213023          	sd	s2,0(sp)
    800028a0:	02010413          	addi	s0,sp,32
    800028a4:	00050913          	mv	s2,a0
    int i=0;
    800028a8:	00000493          	li	s1,0
    while (string[i]){
    800028ac:	009907b3          	add	a5,s2,s1
    800028b0:	0007c503          	lbu	a0,0(a5)
    800028b4:	00050a63          	beqz	a0,800028c8 <_Z11printstringPKc+0x3c>
        __putc(string[i++]);
    800028b8:	0014849b          	addiw	s1,s1,1
    800028bc:	00002097          	auipc	ra,0x2
    800028c0:	0e0080e7          	jalr	224(ra) # 8000499c <__putc>
    while (string[i]){
    800028c4:	fe9ff06f          	j	800028ac <_Z11printstringPKc+0x20>
    }
}
    800028c8:	01813083          	ld	ra,24(sp)
    800028cc:	01013403          	ld	s0,16(sp)
    800028d0:	00813483          	ld	s1,8(sp)
    800028d4:	00013903          	ld	s2,0(sp)
    800028d8:	02010113          	addi	sp,sp,32
    800028dc:	00008067          	ret

00000000800028e0 <start>:
    800028e0:	ff010113          	addi	sp,sp,-16
    800028e4:	00813423          	sd	s0,8(sp)
    800028e8:	01010413          	addi	s0,sp,16
    800028ec:	300027f3          	csrr	a5,mstatus
    800028f0:	ffffe737          	lui	a4,0xffffe
    800028f4:	7ff70713          	addi	a4,a4,2047 # ffffffffffffe7ff <end+0xffffffff7fff4edf>
    800028f8:	00e7f7b3          	and	a5,a5,a4
    800028fc:	00001737          	lui	a4,0x1
    80002900:	80070713          	addi	a4,a4,-2048 # 800 <_entry-0x7ffff800>
    80002904:	00e7e7b3          	or	a5,a5,a4
    80002908:	30079073          	csrw	mstatus,a5
    8000290c:	00000797          	auipc	a5,0x0
    80002910:	16078793          	addi	a5,a5,352 # 80002a6c <system_main>
    80002914:	34179073          	csrw	mepc,a5
    80002918:	00000793          	li	a5,0
    8000291c:	18079073          	csrw	satp,a5
    80002920:	000107b7          	lui	a5,0x10
    80002924:	fff78793          	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    80002928:	30279073          	csrw	medeleg,a5
    8000292c:	30379073          	csrw	mideleg,a5
    80002930:	104027f3          	csrr	a5,sie
    80002934:	2227e793          	ori	a5,a5,546
    80002938:	10479073          	csrw	sie,a5
    8000293c:	fff00793          	li	a5,-1
    80002940:	00a7d793          	srli	a5,a5,0xa
    80002944:	3b079073          	csrw	pmpaddr0,a5
    80002948:	00f00793          	li	a5,15
    8000294c:	3a079073          	csrw	pmpcfg0,a5
    80002950:	f14027f3          	csrr	a5,mhartid
    80002954:	0200c737          	lui	a4,0x200c
    80002958:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    8000295c:	0007869b          	sext.w	a3,a5
    80002960:	00269713          	slli	a4,a3,0x2
    80002964:	000f4637          	lui	a2,0xf4
    80002968:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    8000296c:	00d70733          	add	a4,a4,a3
    80002970:	0037979b          	slliw	a5,a5,0x3
    80002974:	020046b7          	lui	a3,0x2004
    80002978:	00d787b3          	add	a5,a5,a3
    8000297c:	00c585b3          	add	a1,a1,a2
    80002980:	00371693          	slli	a3,a4,0x3
    80002984:	00006717          	auipc	a4,0x6
    80002988:	d3c70713          	addi	a4,a4,-708 # 800086c0 <timer_scratch>
    8000298c:	00b7b023          	sd	a1,0(a5)
    80002990:	00d70733          	add	a4,a4,a3
    80002994:	00f73c23          	sd	a5,24(a4)
    80002998:	02c73023          	sd	a2,32(a4)
    8000299c:	34071073          	csrw	mscratch,a4
    800029a0:	00000797          	auipc	a5,0x0
    800029a4:	6e078793          	addi	a5,a5,1760 # 80003080 <timervec>
    800029a8:	30579073          	csrw	mtvec,a5
    800029ac:	300027f3          	csrr	a5,mstatus
    800029b0:	0087e793          	ori	a5,a5,8
    800029b4:	30079073          	csrw	mstatus,a5
    800029b8:	304027f3          	csrr	a5,mie
    800029bc:	0807e793          	ori	a5,a5,128
    800029c0:	30479073          	csrw	mie,a5
    800029c4:	f14027f3          	csrr	a5,mhartid
    800029c8:	0007879b          	sext.w	a5,a5
    800029cc:	00078213          	mv	tp,a5
    800029d0:	30200073          	mret
    800029d4:	00813403          	ld	s0,8(sp)
    800029d8:	01010113          	addi	sp,sp,16
    800029dc:	00008067          	ret

00000000800029e0 <timerinit>:
    800029e0:	ff010113          	addi	sp,sp,-16
    800029e4:	00813423          	sd	s0,8(sp)
    800029e8:	01010413          	addi	s0,sp,16
    800029ec:	f14027f3          	csrr	a5,mhartid
    800029f0:	0200c737          	lui	a4,0x200c
    800029f4:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    800029f8:	0007869b          	sext.w	a3,a5
    800029fc:	00269713          	slli	a4,a3,0x2
    80002a00:	000f4637          	lui	a2,0xf4
    80002a04:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    80002a08:	00d70733          	add	a4,a4,a3
    80002a0c:	0037979b          	slliw	a5,a5,0x3
    80002a10:	020046b7          	lui	a3,0x2004
    80002a14:	00d787b3          	add	a5,a5,a3
    80002a18:	00c585b3          	add	a1,a1,a2
    80002a1c:	00371693          	slli	a3,a4,0x3
    80002a20:	00006717          	auipc	a4,0x6
    80002a24:	ca070713          	addi	a4,a4,-864 # 800086c0 <timer_scratch>
    80002a28:	00b7b023          	sd	a1,0(a5)
    80002a2c:	00d70733          	add	a4,a4,a3
    80002a30:	00f73c23          	sd	a5,24(a4)
    80002a34:	02c73023          	sd	a2,32(a4)
    80002a38:	34071073          	csrw	mscratch,a4
    80002a3c:	00000797          	auipc	a5,0x0
    80002a40:	64478793          	addi	a5,a5,1604 # 80003080 <timervec>
    80002a44:	30579073          	csrw	mtvec,a5
    80002a48:	300027f3          	csrr	a5,mstatus
    80002a4c:	0087e793          	ori	a5,a5,8
    80002a50:	30079073          	csrw	mstatus,a5
    80002a54:	304027f3          	csrr	a5,mie
    80002a58:	0807e793          	ori	a5,a5,128
    80002a5c:	30479073          	csrw	mie,a5
    80002a60:	00813403          	ld	s0,8(sp)
    80002a64:	01010113          	addi	sp,sp,16
    80002a68:	00008067          	ret

0000000080002a6c <system_main>:
    80002a6c:	fe010113          	addi	sp,sp,-32
    80002a70:	00813823          	sd	s0,16(sp)
    80002a74:	00913423          	sd	s1,8(sp)
    80002a78:	00113c23          	sd	ra,24(sp)
    80002a7c:	02010413          	addi	s0,sp,32
    80002a80:	00000097          	auipc	ra,0x0
    80002a84:	0c4080e7          	jalr	196(ra) # 80002b44 <cpuid>
    80002a88:	00003497          	auipc	s1,0x3
    80002a8c:	be448493          	addi	s1,s1,-1052 # 8000566c <started>
    80002a90:	02050263          	beqz	a0,80002ab4 <system_main+0x48>
    80002a94:	0004a783          	lw	a5,0(s1)
    80002a98:	0007879b          	sext.w	a5,a5
    80002a9c:	fe078ce3          	beqz	a5,80002a94 <system_main+0x28>
    80002aa0:	0ff0000f          	fence
    80002aa4:	00002517          	auipc	a0,0x2
    80002aa8:	67450513          	addi	a0,a0,1652 # 80005118 <CONSOLE_STATUS+0x100>
    80002aac:	00001097          	auipc	ra,0x1
    80002ab0:	a70080e7          	jalr	-1424(ra) # 8000351c <panic>
    80002ab4:	00001097          	auipc	ra,0x1
    80002ab8:	9c4080e7          	jalr	-1596(ra) # 80003478 <consoleinit>
    80002abc:	00001097          	auipc	ra,0x1
    80002ac0:	150080e7          	jalr	336(ra) # 80003c0c <printfinit>
    80002ac4:	00002517          	auipc	a0,0x2
    80002ac8:	73450513          	addi	a0,a0,1844 # 800051f8 <CONSOLE_STATUS+0x1e0>
    80002acc:	00001097          	auipc	ra,0x1
    80002ad0:	aac080e7          	jalr	-1364(ra) # 80003578 <__printf>
    80002ad4:	00002517          	auipc	a0,0x2
    80002ad8:	61450513          	addi	a0,a0,1556 # 800050e8 <CONSOLE_STATUS+0xd0>
    80002adc:	00001097          	auipc	ra,0x1
    80002ae0:	a9c080e7          	jalr	-1380(ra) # 80003578 <__printf>
    80002ae4:	00002517          	auipc	a0,0x2
    80002ae8:	71450513          	addi	a0,a0,1812 # 800051f8 <CONSOLE_STATUS+0x1e0>
    80002aec:	00001097          	auipc	ra,0x1
    80002af0:	a8c080e7          	jalr	-1396(ra) # 80003578 <__printf>
    80002af4:	00001097          	auipc	ra,0x1
    80002af8:	4a4080e7          	jalr	1188(ra) # 80003f98 <kinit>
    80002afc:	00000097          	auipc	ra,0x0
    80002b00:	148080e7          	jalr	328(ra) # 80002c44 <trapinit>
    80002b04:	00000097          	auipc	ra,0x0
    80002b08:	16c080e7          	jalr	364(ra) # 80002c70 <trapinithart>
    80002b0c:	00000097          	auipc	ra,0x0
    80002b10:	5b4080e7          	jalr	1460(ra) # 800030c0 <plicinit>
    80002b14:	00000097          	auipc	ra,0x0
    80002b18:	5d4080e7          	jalr	1492(ra) # 800030e8 <plicinithart>
    80002b1c:	00000097          	auipc	ra,0x0
    80002b20:	078080e7          	jalr	120(ra) # 80002b94 <userinit>
    80002b24:	0ff0000f          	fence
    80002b28:	00100793          	li	a5,1
    80002b2c:	00002517          	auipc	a0,0x2
    80002b30:	5d450513          	addi	a0,a0,1492 # 80005100 <CONSOLE_STATUS+0xe8>
    80002b34:	00f4a023          	sw	a5,0(s1)
    80002b38:	00001097          	auipc	ra,0x1
    80002b3c:	a40080e7          	jalr	-1472(ra) # 80003578 <__printf>
    80002b40:	0000006f          	j	80002b40 <system_main+0xd4>

0000000080002b44 <cpuid>:
    80002b44:	ff010113          	addi	sp,sp,-16
    80002b48:	00813423          	sd	s0,8(sp)
    80002b4c:	01010413          	addi	s0,sp,16
    80002b50:	00020513          	mv	a0,tp
    80002b54:	00813403          	ld	s0,8(sp)
    80002b58:	0005051b          	sext.w	a0,a0
    80002b5c:	01010113          	addi	sp,sp,16
    80002b60:	00008067          	ret

0000000080002b64 <mycpu>:
    80002b64:	ff010113          	addi	sp,sp,-16
    80002b68:	00813423          	sd	s0,8(sp)
    80002b6c:	01010413          	addi	s0,sp,16
    80002b70:	00020793          	mv	a5,tp
    80002b74:	00813403          	ld	s0,8(sp)
    80002b78:	0007879b          	sext.w	a5,a5
    80002b7c:	00779793          	slli	a5,a5,0x7
    80002b80:	00007517          	auipc	a0,0x7
    80002b84:	b7050513          	addi	a0,a0,-1168 # 800096f0 <cpus>
    80002b88:	00f50533          	add	a0,a0,a5
    80002b8c:	01010113          	addi	sp,sp,16
    80002b90:	00008067          	ret

0000000080002b94 <userinit>:
    80002b94:	ff010113          	addi	sp,sp,-16
    80002b98:	00813423          	sd	s0,8(sp)
    80002b9c:	01010413          	addi	s0,sp,16
    80002ba0:	00813403          	ld	s0,8(sp)
    80002ba4:	01010113          	addi	sp,sp,16
    80002ba8:	00000317          	auipc	t1,0x0
    80002bac:	9e830067          	jr	-1560(t1) # 80002590 <main>

0000000080002bb0 <either_copyout>:
    80002bb0:	ff010113          	addi	sp,sp,-16
    80002bb4:	00813023          	sd	s0,0(sp)
    80002bb8:	00113423          	sd	ra,8(sp)
    80002bbc:	01010413          	addi	s0,sp,16
    80002bc0:	02051663          	bnez	a0,80002bec <either_copyout+0x3c>
    80002bc4:	00058513          	mv	a0,a1
    80002bc8:	00060593          	mv	a1,a2
    80002bcc:	0006861b          	sext.w	a2,a3
    80002bd0:	00002097          	auipc	ra,0x2
    80002bd4:	c54080e7          	jalr	-940(ra) # 80004824 <__memmove>
    80002bd8:	00813083          	ld	ra,8(sp)
    80002bdc:	00013403          	ld	s0,0(sp)
    80002be0:	00000513          	li	a0,0
    80002be4:	01010113          	addi	sp,sp,16
    80002be8:	00008067          	ret
    80002bec:	00002517          	auipc	a0,0x2
    80002bf0:	55450513          	addi	a0,a0,1364 # 80005140 <CONSOLE_STATUS+0x128>
    80002bf4:	00001097          	auipc	ra,0x1
    80002bf8:	928080e7          	jalr	-1752(ra) # 8000351c <panic>

0000000080002bfc <either_copyin>:
    80002bfc:	ff010113          	addi	sp,sp,-16
    80002c00:	00813023          	sd	s0,0(sp)
    80002c04:	00113423          	sd	ra,8(sp)
    80002c08:	01010413          	addi	s0,sp,16
    80002c0c:	02059463          	bnez	a1,80002c34 <either_copyin+0x38>
    80002c10:	00060593          	mv	a1,a2
    80002c14:	0006861b          	sext.w	a2,a3
    80002c18:	00002097          	auipc	ra,0x2
    80002c1c:	c0c080e7          	jalr	-1012(ra) # 80004824 <__memmove>
    80002c20:	00813083          	ld	ra,8(sp)
    80002c24:	00013403          	ld	s0,0(sp)
    80002c28:	00000513          	li	a0,0
    80002c2c:	01010113          	addi	sp,sp,16
    80002c30:	00008067          	ret
    80002c34:	00002517          	auipc	a0,0x2
    80002c38:	53450513          	addi	a0,a0,1332 # 80005168 <CONSOLE_STATUS+0x150>
    80002c3c:	00001097          	auipc	ra,0x1
    80002c40:	8e0080e7          	jalr	-1824(ra) # 8000351c <panic>

0000000080002c44 <trapinit>:
    80002c44:	ff010113          	addi	sp,sp,-16
    80002c48:	00813423          	sd	s0,8(sp)
    80002c4c:	01010413          	addi	s0,sp,16
    80002c50:	00813403          	ld	s0,8(sp)
    80002c54:	00002597          	auipc	a1,0x2
    80002c58:	53c58593          	addi	a1,a1,1340 # 80005190 <CONSOLE_STATUS+0x178>
    80002c5c:	00007517          	auipc	a0,0x7
    80002c60:	b1450513          	addi	a0,a0,-1260 # 80009770 <tickslock>
    80002c64:	01010113          	addi	sp,sp,16
    80002c68:	00001317          	auipc	t1,0x1
    80002c6c:	5c030067          	jr	1472(t1) # 80004228 <initlock>

0000000080002c70 <trapinithart>:
    80002c70:	ff010113          	addi	sp,sp,-16
    80002c74:	00813423          	sd	s0,8(sp)
    80002c78:	01010413          	addi	s0,sp,16
    80002c7c:	00000797          	auipc	a5,0x0
    80002c80:	2f478793          	addi	a5,a5,756 # 80002f70 <kernelvec>
    80002c84:	10579073          	csrw	stvec,a5
    80002c88:	00813403          	ld	s0,8(sp)
    80002c8c:	01010113          	addi	sp,sp,16
    80002c90:	00008067          	ret

0000000080002c94 <usertrap>:
    80002c94:	ff010113          	addi	sp,sp,-16
    80002c98:	00813423          	sd	s0,8(sp)
    80002c9c:	01010413          	addi	s0,sp,16
    80002ca0:	00813403          	ld	s0,8(sp)
    80002ca4:	01010113          	addi	sp,sp,16
    80002ca8:	00008067          	ret

0000000080002cac <usertrapret>:
    80002cac:	ff010113          	addi	sp,sp,-16
    80002cb0:	00813423          	sd	s0,8(sp)
    80002cb4:	01010413          	addi	s0,sp,16
    80002cb8:	00813403          	ld	s0,8(sp)
    80002cbc:	01010113          	addi	sp,sp,16
    80002cc0:	00008067          	ret

0000000080002cc4 <kerneltrap>:
    80002cc4:	fe010113          	addi	sp,sp,-32
    80002cc8:	00813823          	sd	s0,16(sp)
    80002ccc:	00113c23          	sd	ra,24(sp)
    80002cd0:	00913423          	sd	s1,8(sp)
    80002cd4:	02010413          	addi	s0,sp,32
    80002cd8:	142025f3          	csrr	a1,scause
    80002cdc:	100027f3          	csrr	a5,sstatus
    80002ce0:	0027f793          	andi	a5,a5,2
    80002ce4:	10079c63          	bnez	a5,80002dfc <kerneltrap+0x138>
    80002ce8:	142027f3          	csrr	a5,scause
    80002cec:	0207ce63          	bltz	a5,80002d28 <kerneltrap+0x64>
    80002cf0:	00002517          	auipc	a0,0x2
    80002cf4:	4e850513          	addi	a0,a0,1256 # 800051d8 <CONSOLE_STATUS+0x1c0>
    80002cf8:	00001097          	auipc	ra,0x1
    80002cfc:	880080e7          	jalr	-1920(ra) # 80003578 <__printf>
    80002d00:	141025f3          	csrr	a1,sepc
    80002d04:	14302673          	csrr	a2,stval
    80002d08:	00002517          	auipc	a0,0x2
    80002d0c:	4e050513          	addi	a0,a0,1248 # 800051e8 <CONSOLE_STATUS+0x1d0>
    80002d10:	00001097          	auipc	ra,0x1
    80002d14:	868080e7          	jalr	-1944(ra) # 80003578 <__printf>
    80002d18:	00002517          	auipc	a0,0x2
    80002d1c:	4e850513          	addi	a0,a0,1256 # 80005200 <CONSOLE_STATUS+0x1e8>
    80002d20:	00000097          	auipc	ra,0x0
    80002d24:	7fc080e7          	jalr	2044(ra) # 8000351c <panic>
    80002d28:	0ff7f713          	andi	a4,a5,255
    80002d2c:	00900693          	li	a3,9
    80002d30:	04d70063          	beq	a4,a3,80002d70 <kerneltrap+0xac>
    80002d34:	fff00713          	li	a4,-1
    80002d38:	03f71713          	slli	a4,a4,0x3f
    80002d3c:	00170713          	addi	a4,a4,1
    80002d40:	fae798e3          	bne	a5,a4,80002cf0 <kerneltrap+0x2c>
    80002d44:	00000097          	auipc	ra,0x0
    80002d48:	e00080e7          	jalr	-512(ra) # 80002b44 <cpuid>
    80002d4c:	06050663          	beqz	a0,80002db8 <kerneltrap+0xf4>
    80002d50:	144027f3          	csrr	a5,sip
    80002d54:	ffd7f793          	andi	a5,a5,-3
    80002d58:	14479073          	csrw	sip,a5
    80002d5c:	01813083          	ld	ra,24(sp)
    80002d60:	01013403          	ld	s0,16(sp)
    80002d64:	00813483          	ld	s1,8(sp)
    80002d68:	02010113          	addi	sp,sp,32
    80002d6c:	00008067          	ret
    80002d70:	00000097          	auipc	ra,0x0
    80002d74:	3c4080e7          	jalr	964(ra) # 80003134 <plic_claim>
    80002d78:	00a00793          	li	a5,10
    80002d7c:	00050493          	mv	s1,a0
    80002d80:	06f50863          	beq	a0,a5,80002df0 <kerneltrap+0x12c>
    80002d84:	fc050ce3          	beqz	a0,80002d5c <kerneltrap+0x98>
    80002d88:	00050593          	mv	a1,a0
    80002d8c:	00002517          	auipc	a0,0x2
    80002d90:	42c50513          	addi	a0,a0,1068 # 800051b8 <CONSOLE_STATUS+0x1a0>
    80002d94:	00000097          	auipc	ra,0x0
    80002d98:	7e4080e7          	jalr	2020(ra) # 80003578 <__printf>
    80002d9c:	01013403          	ld	s0,16(sp)
    80002da0:	01813083          	ld	ra,24(sp)
    80002da4:	00048513          	mv	a0,s1
    80002da8:	00813483          	ld	s1,8(sp)
    80002dac:	02010113          	addi	sp,sp,32
    80002db0:	00000317          	auipc	t1,0x0
    80002db4:	3bc30067          	jr	956(t1) # 8000316c <plic_complete>
    80002db8:	00007517          	auipc	a0,0x7
    80002dbc:	9b850513          	addi	a0,a0,-1608 # 80009770 <tickslock>
    80002dc0:	00001097          	auipc	ra,0x1
    80002dc4:	48c080e7          	jalr	1164(ra) # 8000424c <acquire>
    80002dc8:	00003717          	auipc	a4,0x3
    80002dcc:	8a870713          	addi	a4,a4,-1880 # 80005670 <ticks>
    80002dd0:	00072783          	lw	a5,0(a4)
    80002dd4:	00007517          	auipc	a0,0x7
    80002dd8:	99c50513          	addi	a0,a0,-1636 # 80009770 <tickslock>
    80002ddc:	0017879b          	addiw	a5,a5,1
    80002de0:	00f72023          	sw	a5,0(a4)
    80002de4:	00001097          	auipc	ra,0x1
    80002de8:	534080e7          	jalr	1332(ra) # 80004318 <release>
    80002dec:	f65ff06f          	j	80002d50 <kerneltrap+0x8c>
    80002df0:	00001097          	auipc	ra,0x1
    80002df4:	090080e7          	jalr	144(ra) # 80003e80 <uartintr>
    80002df8:	fa5ff06f          	j	80002d9c <kerneltrap+0xd8>
    80002dfc:	00002517          	auipc	a0,0x2
    80002e00:	39c50513          	addi	a0,a0,924 # 80005198 <CONSOLE_STATUS+0x180>
    80002e04:	00000097          	auipc	ra,0x0
    80002e08:	718080e7          	jalr	1816(ra) # 8000351c <panic>

0000000080002e0c <clockintr>:
    80002e0c:	fe010113          	addi	sp,sp,-32
    80002e10:	00813823          	sd	s0,16(sp)
    80002e14:	00913423          	sd	s1,8(sp)
    80002e18:	00113c23          	sd	ra,24(sp)
    80002e1c:	02010413          	addi	s0,sp,32
    80002e20:	00007497          	auipc	s1,0x7
    80002e24:	95048493          	addi	s1,s1,-1712 # 80009770 <tickslock>
    80002e28:	00048513          	mv	a0,s1
    80002e2c:	00001097          	auipc	ra,0x1
    80002e30:	420080e7          	jalr	1056(ra) # 8000424c <acquire>
    80002e34:	00003717          	auipc	a4,0x3
    80002e38:	83c70713          	addi	a4,a4,-1988 # 80005670 <ticks>
    80002e3c:	00072783          	lw	a5,0(a4)
    80002e40:	01013403          	ld	s0,16(sp)
    80002e44:	01813083          	ld	ra,24(sp)
    80002e48:	00048513          	mv	a0,s1
    80002e4c:	0017879b          	addiw	a5,a5,1
    80002e50:	00813483          	ld	s1,8(sp)
    80002e54:	00f72023          	sw	a5,0(a4)
    80002e58:	02010113          	addi	sp,sp,32
    80002e5c:	00001317          	auipc	t1,0x1
    80002e60:	4bc30067          	jr	1212(t1) # 80004318 <release>

0000000080002e64 <devintr>:
    80002e64:	142027f3          	csrr	a5,scause
    80002e68:	00000513          	li	a0,0
    80002e6c:	0007c463          	bltz	a5,80002e74 <devintr+0x10>
    80002e70:	00008067          	ret
    80002e74:	fe010113          	addi	sp,sp,-32
    80002e78:	00813823          	sd	s0,16(sp)
    80002e7c:	00113c23          	sd	ra,24(sp)
    80002e80:	00913423          	sd	s1,8(sp)
    80002e84:	02010413          	addi	s0,sp,32
    80002e88:	0ff7f713          	andi	a4,a5,255
    80002e8c:	00900693          	li	a3,9
    80002e90:	04d70c63          	beq	a4,a3,80002ee8 <devintr+0x84>
    80002e94:	fff00713          	li	a4,-1
    80002e98:	03f71713          	slli	a4,a4,0x3f
    80002e9c:	00170713          	addi	a4,a4,1
    80002ea0:	00e78c63          	beq	a5,a4,80002eb8 <devintr+0x54>
    80002ea4:	01813083          	ld	ra,24(sp)
    80002ea8:	01013403          	ld	s0,16(sp)
    80002eac:	00813483          	ld	s1,8(sp)
    80002eb0:	02010113          	addi	sp,sp,32
    80002eb4:	00008067          	ret
    80002eb8:	00000097          	auipc	ra,0x0
    80002ebc:	c8c080e7          	jalr	-884(ra) # 80002b44 <cpuid>
    80002ec0:	06050663          	beqz	a0,80002f2c <devintr+0xc8>
    80002ec4:	144027f3          	csrr	a5,sip
    80002ec8:	ffd7f793          	andi	a5,a5,-3
    80002ecc:	14479073          	csrw	sip,a5
    80002ed0:	01813083          	ld	ra,24(sp)
    80002ed4:	01013403          	ld	s0,16(sp)
    80002ed8:	00813483          	ld	s1,8(sp)
    80002edc:	00200513          	li	a0,2
    80002ee0:	02010113          	addi	sp,sp,32
    80002ee4:	00008067          	ret
    80002ee8:	00000097          	auipc	ra,0x0
    80002eec:	24c080e7          	jalr	588(ra) # 80003134 <plic_claim>
    80002ef0:	00a00793          	li	a5,10
    80002ef4:	00050493          	mv	s1,a0
    80002ef8:	06f50663          	beq	a0,a5,80002f64 <devintr+0x100>
    80002efc:	00100513          	li	a0,1
    80002f00:	fa0482e3          	beqz	s1,80002ea4 <devintr+0x40>
    80002f04:	00048593          	mv	a1,s1
    80002f08:	00002517          	auipc	a0,0x2
    80002f0c:	2b050513          	addi	a0,a0,688 # 800051b8 <CONSOLE_STATUS+0x1a0>
    80002f10:	00000097          	auipc	ra,0x0
    80002f14:	668080e7          	jalr	1640(ra) # 80003578 <__printf>
    80002f18:	00048513          	mv	a0,s1
    80002f1c:	00000097          	auipc	ra,0x0
    80002f20:	250080e7          	jalr	592(ra) # 8000316c <plic_complete>
    80002f24:	00100513          	li	a0,1
    80002f28:	f7dff06f          	j	80002ea4 <devintr+0x40>
    80002f2c:	00007517          	auipc	a0,0x7
    80002f30:	84450513          	addi	a0,a0,-1980 # 80009770 <tickslock>
    80002f34:	00001097          	auipc	ra,0x1
    80002f38:	318080e7          	jalr	792(ra) # 8000424c <acquire>
    80002f3c:	00002717          	auipc	a4,0x2
    80002f40:	73470713          	addi	a4,a4,1844 # 80005670 <ticks>
    80002f44:	00072783          	lw	a5,0(a4)
    80002f48:	00007517          	auipc	a0,0x7
    80002f4c:	82850513          	addi	a0,a0,-2008 # 80009770 <tickslock>
    80002f50:	0017879b          	addiw	a5,a5,1
    80002f54:	00f72023          	sw	a5,0(a4)
    80002f58:	00001097          	auipc	ra,0x1
    80002f5c:	3c0080e7          	jalr	960(ra) # 80004318 <release>
    80002f60:	f65ff06f          	j	80002ec4 <devintr+0x60>
    80002f64:	00001097          	auipc	ra,0x1
    80002f68:	f1c080e7          	jalr	-228(ra) # 80003e80 <uartintr>
    80002f6c:	fadff06f          	j	80002f18 <devintr+0xb4>

0000000080002f70 <kernelvec>:
    80002f70:	f0010113          	addi	sp,sp,-256
    80002f74:	00113023          	sd	ra,0(sp)
    80002f78:	00213423          	sd	sp,8(sp)
    80002f7c:	00313823          	sd	gp,16(sp)
    80002f80:	00413c23          	sd	tp,24(sp)
    80002f84:	02513023          	sd	t0,32(sp)
    80002f88:	02613423          	sd	t1,40(sp)
    80002f8c:	02713823          	sd	t2,48(sp)
    80002f90:	02813c23          	sd	s0,56(sp)
    80002f94:	04913023          	sd	s1,64(sp)
    80002f98:	04a13423          	sd	a0,72(sp)
    80002f9c:	04b13823          	sd	a1,80(sp)
    80002fa0:	04c13c23          	sd	a2,88(sp)
    80002fa4:	06d13023          	sd	a3,96(sp)
    80002fa8:	06e13423          	sd	a4,104(sp)
    80002fac:	06f13823          	sd	a5,112(sp)
    80002fb0:	07013c23          	sd	a6,120(sp)
    80002fb4:	09113023          	sd	a7,128(sp)
    80002fb8:	09213423          	sd	s2,136(sp)
    80002fbc:	09313823          	sd	s3,144(sp)
    80002fc0:	09413c23          	sd	s4,152(sp)
    80002fc4:	0b513023          	sd	s5,160(sp)
    80002fc8:	0b613423          	sd	s6,168(sp)
    80002fcc:	0b713823          	sd	s7,176(sp)
    80002fd0:	0b813c23          	sd	s8,184(sp)
    80002fd4:	0d913023          	sd	s9,192(sp)
    80002fd8:	0da13423          	sd	s10,200(sp)
    80002fdc:	0db13823          	sd	s11,208(sp)
    80002fe0:	0dc13c23          	sd	t3,216(sp)
    80002fe4:	0fd13023          	sd	t4,224(sp)
    80002fe8:	0fe13423          	sd	t5,232(sp)
    80002fec:	0ff13823          	sd	t6,240(sp)
    80002ff0:	cd5ff0ef          	jal	ra,80002cc4 <kerneltrap>
    80002ff4:	00013083          	ld	ra,0(sp)
    80002ff8:	00813103          	ld	sp,8(sp)
    80002ffc:	01013183          	ld	gp,16(sp)
    80003000:	02013283          	ld	t0,32(sp)
    80003004:	02813303          	ld	t1,40(sp)
    80003008:	03013383          	ld	t2,48(sp)
    8000300c:	03813403          	ld	s0,56(sp)
    80003010:	04013483          	ld	s1,64(sp)
    80003014:	04813503          	ld	a0,72(sp)
    80003018:	05013583          	ld	a1,80(sp)
    8000301c:	05813603          	ld	a2,88(sp)
    80003020:	06013683          	ld	a3,96(sp)
    80003024:	06813703          	ld	a4,104(sp)
    80003028:	07013783          	ld	a5,112(sp)
    8000302c:	07813803          	ld	a6,120(sp)
    80003030:	08013883          	ld	a7,128(sp)
    80003034:	08813903          	ld	s2,136(sp)
    80003038:	09013983          	ld	s3,144(sp)
    8000303c:	09813a03          	ld	s4,152(sp)
    80003040:	0a013a83          	ld	s5,160(sp)
    80003044:	0a813b03          	ld	s6,168(sp)
    80003048:	0b013b83          	ld	s7,176(sp)
    8000304c:	0b813c03          	ld	s8,184(sp)
    80003050:	0c013c83          	ld	s9,192(sp)
    80003054:	0c813d03          	ld	s10,200(sp)
    80003058:	0d013d83          	ld	s11,208(sp)
    8000305c:	0d813e03          	ld	t3,216(sp)
    80003060:	0e013e83          	ld	t4,224(sp)
    80003064:	0e813f03          	ld	t5,232(sp)
    80003068:	0f013f83          	ld	t6,240(sp)
    8000306c:	10010113          	addi	sp,sp,256
    80003070:	10200073          	sret
    80003074:	00000013          	nop
    80003078:	00000013          	nop
    8000307c:	00000013          	nop

0000000080003080 <timervec>:
    80003080:	34051573          	csrrw	a0,mscratch,a0
    80003084:	00b53023          	sd	a1,0(a0)
    80003088:	00c53423          	sd	a2,8(a0)
    8000308c:	00d53823          	sd	a3,16(a0)
    80003090:	01853583          	ld	a1,24(a0)
    80003094:	02053603          	ld	a2,32(a0)
    80003098:	0005b683          	ld	a3,0(a1)
    8000309c:	00c686b3          	add	a3,a3,a2
    800030a0:	00d5b023          	sd	a3,0(a1)
    800030a4:	00200593          	li	a1,2
    800030a8:	14459073          	csrw	sip,a1
    800030ac:	01053683          	ld	a3,16(a0)
    800030b0:	00853603          	ld	a2,8(a0)
    800030b4:	00053583          	ld	a1,0(a0)
    800030b8:	34051573          	csrrw	a0,mscratch,a0
    800030bc:	30200073          	mret

00000000800030c0 <plicinit>:
    800030c0:	ff010113          	addi	sp,sp,-16
    800030c4:	00813423          	sd	s0,8(sp)
    800030c8:	01010413          	addi	s0,sp,16
    800030cc:	00813403          	ld	s0,8(sp)
    800030d0:	0c0007b7          	lui	a5,0xc000
    800030d4:	00100713          	li	a4,1
    800030d8:	02e7a423          	sw	a4,40(a5) # c000028 <_entry-0x73ffffd8>
    800030dc:	00e7a223          	sw	a4,4(a5)
    800030e0:	01010113          	addi	sp,sp,16
    800030e4:	00008067          	ret

00000000800030e8 <plicinithart>:
    800030e8:	ff010113          	addi	sp,sp,-16
    800030ec:	00813023          	sd	s0,0(sp)
    800030f0:	00113423          	sd	ra,8(sp)
    800030f4:	01010413          	addi	s0,sp,16
    800030f8:	00000097          	auipc	ra,0x0
    800030fc:	a4c080e7          	jalr	-1460(ra) # 80002b44 <cpuid>
    80003100:	0085171b          	slliw	a4,a0,0x8
    80003104:	0c0027b7          	lui	a5,0xc002
    80003108:	00e787b3          	add	a5,a5,a4
    8000310c:	40200713          	li	a4,1026
    80003110:	08e7a023          	sw	a4,128(a5) # c002080 <_entry-0x73ffdf80>
    80003114:	00813083          	ld	ra,8(sp)
    80003118:	00013403          	ld	s0,0(sp)
    8000311c:	00d5151b          	slliw	a0,a0,0xd
    80003120:	0c2017b7          	lui	a5,0xc201
    80003124:	00a78533          	add	a0,a5,a0
    80003128:	00052023          	sw	zero,0(a0)
    8000312c:	01010113          	addi	sp,sp,16
    80003130:	00008067          	ret

0000000080003134 <plic_claim>:
    80003134:	ff010113          	addi	sp,sp,-16
    80003138:	00813023          	sd	s0,0(sp)
    8000313c:	00113423          	sd	ra,8(sp)
    80003140:	01010413          	addi	s0,sp,16
    80003144:	00000097          	auipc	ra,0x0
    80003148:	a00080e7          	jalr	-1536(ra) # 80002b44 <cpuid>
    8000314c:	00813083          	ld	ra,8(sp)
    80003150:	00013403          	ld	s0,0(sp)
    80003154:	00d5151b          	slliw	a0,a0,0xd
    80003158:	0c2017b7          	lui	a5,0xc201
    8000315c:	00a78533          	add	a0,a5,a0
    80003160:	00452503          	lw	a0,4(a0)
    80003164:	01010113          	addi	sp,sp,16
    80003168:	00008067          	ret

000000008000316c <plic_complete>:
    8000316c:	fe010113          	addi	sp,sp,-32
    80003170:	00813823          	sd	s0,16(sp)
    80003174:	00913423          	sd	s1,8(sp)
    80003178:	00113c23          	sd	ra,24(sp)
    8000317c:	02010413          	addi	s0,sp,32
    80003180:	00050493          	mv	s1,a0
    80003184:	00000097          	auipc	ra,0x0
    80003188:	9c0080e7          	jalr	-1600(ra) # 80002b44 <cpuid>
    8000318c:	01813083          	ld	ra,24(sp)
    80003190:	01013403          	ld	s0,16(sp)
    80003194:	00d5179b          	slliw	a5,a0,0xd
    80003198:	0c201737          	lui	a4,0xc201
    8000319c:	00f707b3          	add	a5,a4,a5
    800031a0:	0097a223          	sw	s1,4(a5) # c201004 <_entry-0x73dfeffc>
    800031a4:	00813483          	ld	s1,8(sp)
    800031a8:	02010113          	addi	sp,sp,32
    800031ac:	00008067          	ret

00000000800031b0 <consolewrite>:
    800031b0:	fb010113          	addi	sp,sp,-80
    800031b4:	04813023          	sd	s0,64(sp)
    800031b8:	04113423          	sd	ra,72(sp)
    800031bc:	02913c23          	sd	s1,56(sp)
    800031c0:	03213823          	sd	s2,48(sp)
    800031c4:	03313423          	sd	s3,40(sp)
    800031c8:	03413023          	sd	s4,32(sp)
    800031cc:	01513c23          	sd	s5,24(sp)
    800031d0:	05010413          	addi	s0,sp,80
    800031d4:	06c05c63          	blez	a2,8000324c <consolewrite+0x9c>
    800031d8:	00060993          	mv	s3,a2
    800031dc:	00050a13          	mv	s4,a0
    800031e0:	00058493          	mv	s1,a1
    800031e4:	00000913          	li	s2,0
    800031e8:	fff00a93          	li	s5,-1
    800031ec:	01c0006f          	j	80003208 <consolewrite+0x58>
    800031f0:	fbf44503          	lbu	a0,-65(s0)
    800031f4:	0019091b          	addiw	s2,s2,1
    800031f8:	00148493          	addi	s1,s1,1
    800031fc:	00001097          	auipc	ra,0x1
    80003200:	a9c080e7          	jalr	-1380(ra) # 80003c98 <uartputc>
    80003204:	03298063          	beq	s3,s2,80003224 <consolewrite+0x74>
    80003208:	00048613          	mv	a2,s1
    8000320c:	00100693          	li	a3,1
    80003210:	000a0593          	mv	a1,s4
    80003214:	fbf40513          	addi	a0,s0,-65
    80003218:	00000097          	auipc	ra,0x0
    8000321c:	9e4080e7          	jalr	-1564(ra) # 80002bfc <either_copyin>
    80003220:	fd5518e3          	bne	a0,s5,800031f0 <consolewrite+0x40>
    80003224:	04813083          	ld	ra,72(sp)
    80003228:	04013403          	ld	s0,64(sp)
    8000322c:	03813483          	ld	s1,56(sp)
    80003230:	02813983          	ld	s3,40(sp)
    80003234:	02013a03          	ld	s4,32(sp)
    80003238:	01813a83          	ld	s5,24(sp)
    8000323c:	00090513          	mv	a0,s2
    80003240:	03013903          	ld	s2,48(sp)
    80003244:	05010113          	addi	sp,sp,80
    80003248:	00008067          	ret
    8000324c:	00000913          	li	s2,0
    80003250:	fd5ff06f          	j	80003224 <consolewrite+0x74>

0000000080003254 <consoleread>:
    80003254:	f9010113          	addi	sp,sp,-112
    80003258:	06813023          	sd	s0,96(sp)
    8000325c:	04913c23          	sd	s1,88(sp)
    80003260:	05213823          	sd	s2,80(sp)
    80003264:	05313423          	sd	s3,72(sp)
    80003268:	05413023          	sd	s4,64(sp)
    8000326c:	03513c23          	sd	s5,56(sp)
    80003270:	03613823          	sd	s6,48(sp)
    80003274:	03713423          	sd	s7,40(sp)
    80003278:	03813023          	sd	s8,32(sp)
    8000327c:	06113423          	sd	ra,104(sp)
    80003280:	01913c23          	sd	s9,24(sp)
    80003284:	07010413          	addi	s0,sp,112
    80003288:	00060b93          	mv	s7,a2
    8000328c:	00050913          	mv	s2,a0
    80003290:	00058c13          	mv	s8,a1
    80003294:	00060b1b          	sext.w	s6,a2
    80003298:	00006497          	auipc	s1,0x6
    8000329c:	50048493          	addi	s1,s1,1280 # 80009798 <cons>
    800032a0:	00400993          	li	s3,4
    800032a4:	fff00a13          	li	s4,-1
    800032a8:	00a00a93          	li	s5,10
    800032ac:	05705e63          	blez	s7,80003308 <consoleread+0xb4>
    800032b0:	09c4a703          	lw	a4,156(s1)
    800032b4:	0984a783          	lw	a5,152(s1)
    800032b8:	0007071b          	sext.w	a4,a4
    800032bc:	08e78463          	beq	a5,a4,80003344 <consoleread+0xf0>
    800032c0:	07f7f713          	andi	a4,a5,127
    800032c4:	00e48733          	add	a4,s1,a4
    800032c8:	01874703          	lbu	a4,24(a4) # c201018 <_entry-0x73dfefe8>
    800032cc:	0017869b          	addiw	a3,a5,1
    800032d0:	08d4ac23          	sw	a3,152(s1)
    800032d4:	00070c9b          	sext.w	s9,a4
    800032d8:	0b370663          	beq	a4,s3,80003384 <consoleread+0x130>
    800032dc:	00100693          	li	a3,1
    800032e0:	f9f40613          	addi	a2,s0,-97
    800032e4:	000c0593          	mv	a1,s8
    800032e8:	00090513          	mv	a0,s2
    800032ec:	f8e40fa3          	sb	a4,-97(s0)
    800032f0:	00000097          	auipc	ra,0x0
    800032f4:	8c0080e7          	jalr	-1856(ra) # 80002bb0 <either_copyout>
    800032f8:	01450863          	beq	a0,s4,80003308 <consoleread+0xb4>
    800032fc:	001c0c13          	addi	s8,s8,1
    80003300:	fffb8b9b          	addiw	s7,s7,-1
    80003304:	fb5c94e3          	bne	s9,s5,800032ac <consoleread+0x58>
    80003308:	000b851b          	sext.w	a0,s7
    8000330c:	06813083          	ld	ra,104(sp)
    80003310:	06013403          	ld	s0,96(sp)
    80003314:	05813483          	ld	s1,88(sp)
    80003318:	05013903          	ld	s2,80(sp)
    8000331c:	04813983          	ld	s3,72(sp)
    80003320:	04013a03          	ld	s4,64(sp)
    80003324:	03813a83          	ld	s5,56(sp)
    80003328:	02813b83          	ld	s7,40(sp)
    8000332c:	02013c03          	ld	s8,32(sp)
    80003330:	01813c83          	ld	s9,24(sp)
    80003334:	40ab053b          	subw	a0,s6,a0
    80003338:	03013b03          	ld	s6,48(sp)
    8000333c:	07010113          	addi	sp,sp,112
    80003340:	00008067          	ret
    80003344:	00001097          	auipc	ra,0x1
    80003348:	1d8080e7          	jalr	472(ra) # 8000451c <push_on>
    8000334c:	0984a703          	lw	a4,152(s1)
    80003350:	09c4a783          	lw	a5,156(s1)
    80003354:	0007879b          	sext.w	a5,a5
    80003358:	fef70ce3          	beq	a4,a5,80003350 <consoleread+0xfc>
    8000335c:	00001097          	auipc	ra,0x1
    80003360:	234080e7          	jalr	564(ra) # 80004590 <pop_on>
    80003364:	0984a783          	lw	a5,152(s1)
    80003368:	07f7f713          	andi	a4,a5,127
    8000336c:	00e48733          	add	a4,s1,a4
    80003370:	01874703          	lbu	a4,24(a4)
    80003374:	0017869b          	addiw	a3,a5,1
    80003378:	08d4ac23          	sw	a3,152(s1)
    8000337c:	00070c9b          	sext.w	s9,a4
    80003380:	f5371ee3          	bne	a4,s3,800032dc <consoleread+0x88>
    80003384:	000b851b          	sext.w	a0,s7
    80003388:	f96bf2e3          	bgeu	s7,s6,8000330c <consoleread+0xb8>
    8000338c:	08f4ac23          	sw	a5,152(s1)
    80003390:	f7dff06f          	j	8000330c <consoleread+0xb8>

0000000080003394 <consputc>:
    80003394:	10000793          	li	a5,256
    80003398:	00f50663          	beq	a0,a5,800033a4 <consputc+0x10>
    8000339c:	00001317          	auipc	t1,0x1
    800033a0:	9f430067          	jr	-1548(t1) # 80003d90 <uartputc_sync>
    800033a4:	ff010113          	addi	sp,sp,-16
    800033a8:	00113423          	sd	ra,8(sp)
    800033ac:	00813023          	sd	s0,0(sp)
    800033b0:	01010413          	addi	s0,sp,16
    800033b4:	00800513          	li	a0,8
    800033b8:	00001097          	auipc	ra,0x1
    800033bc:	9d8080e7          	jalr	-1576(ra) # 80003d90 <uartputc_sync>
    800033c0:	02000513          	li	a0,32
    800033c4:	00001097          	auipc	ra,0x1
    800033c8:	9cc080e7          	jalr	-1588(ra) # 80003d90 <uartputc_sync>
    800033cc:	00013403          	ld	s0,0(sp)
    800033d0:	00813083          	ld	ra,8(sp)
    800033d4:	00800513          	li	a0,8
    800033d8:	01010113          	addi	sp,sp,16
    800033dc:	00001317          	auipc	t1,0x1
    800033e0:	9b430067          	jr	-1612(t1) # 80003d90 <uartputc_sync>

00000000800033e4 <consoleintr>:
    800033e4:	fe010113          	addi	sp,sp,-32
    800033e8:	00813823          	sd	s0,16(sp)
    800033ec:	00913423          	sd	s1,8(sp)
    800033f0:	01213023          	sd	s2,0(sp)
    800033f4:	00113c23          	sd	ra,24(sp)
    800033f8:	02010413          	addi	s0,sp,32
    800033fc:	00006917          	auipc	s2,0x6
    80003400:	39c90913          	addi	s2,s2,924 # 80009798 <cons>
    80003404:	00050493          	mv	s1,a0
    80003408:	00090513          	mv	a0,s2
    8000340c:	00001097          	auipc	ra,0x1
    80003410:	e40080e7          	jalr	-448(ra) # 8000424c <acquire>
    80003414:	02048c63          	beqz	s1,8000344c <consoleintr+0x68>
    80003418:	0a092783          	lw	a5,160(s2)
    8000341c:	09892703          	lw	a4,152(s2)
    80003420:	07f00693          	li	a3,127
    80003424:	40e7873b          	subw	a4,a5,a4
    80003428:	02e6e263          	bltu	a3,a4,8000344c <consoleintr+0x68>
    8000342c:	00d00713          	li	a4,13
    80003430:	04e48063          	beq	s1,a4,80003470 <consoleintr+0x8c>
    80003434:	07f7f713          	andi	a4,a5,127
    80003438:	00e90733          	add	a4,s2,a4
    8000343c:	0017879b          	addiw	a5,a5,1
    80003440:	0af92023          	sw	a5,160(s2)
    80003444:	00970c23          	sb	s1,24(a4)
    80003448:	08f92e23          	sw	a5,156(s2)
    8000344c:	01013403          	ld	s0,16(sp)
    80003450:	01813083          	ld	ra,24(sp)
    80003454:	00813483          	ld	s1,8(sp)
    80003458:	00013903          	ld	s2,0(sp)
    8000345c:	00006517          	auipc	a0,0x6
    80003460:	33c50513          	addi	a0,a0,828 # 80009798 <cons>
    80003464:	02010113          	addi	sp,sp,32
    80003468:	00001317          	auipc	t1,0x1
    8000346c:	eb030067          	jr	-336(t1) # 80004318 <release>
    80003470:	00a00493          	li	s1,10
    80003474:	fc1ff06f          	j	80003434 <consoleintr+0x50>

0000000080003478 <consoleinit>:
    80003478:	fe010113          	addi	sp,sp,-32
    8000347c:	00113c23          	sd	ra,24(sp)
    80003480:	00813823          	sd	s0,16(sp)
    80003484:	00913423          	sd	s1,8(sp)
    80003488:	02010413          	addi	s0,sp,32
    8000348c:	00006497          	auipc	s1,0x6
    80003490:	30c48493          	addi	s1,s1,780 # 80009798 <cons>
    80003494:	00048513          	mv	a0,s1
    80003498:	00002597          	auipc	a1,0x2
    8000349c:	d7858593          	addi	a1,a1,-648 # 80005210 <CONSOLE_STATUS+0x1f8>
    800034a0:	00001097          	auipc	ra,0x1
    800034a4:	d88080e7          	jalr	-632(ra) # 80004228 <initlock>
    800034a8:	00000097          	auipc	ra,0x0
    800034ac:	7ac080e7          	jalr	1964(ra) # 80003c54 <uartinit>
    800034b0:	01813083          	ld	ra,24(sp)
    800034b4:	01013403          	ld	s0,16(sp)
    800034b8:	00000797          	auipc	a5,0x0
    800034bc:	d9c78793          	addi	a5,a5,-612 # 80003254 <consoleread>
    800034c0:	0af4bc23          	sd	a5,184(s1)
    800034c4:	00000797          	auipc	a5,0x0
    800034c8:	cec78793          	addi	a5,a5,-788 # 800031b0 <consolewrite>
    800034cc:	0cf4b023          	sd	a5,192(s1)
    800034d0:	00813483          	ld	s1,8(sp)
    800034d4:	02010113          	addi	sp,sp,32
    800034d8:	00008067          	ret

00000000800034dc <console_read>:
    800034dc:	ff010113          	addi	sp,sp,-16
    800034e0:	00813423          	sd	s0,8(sp)
    800034e4:	01010413          	addi	s0,sp,16
    800034e8:	00813403          	ld	s0,8(sp)
    800034ec:	00006317          	auipc	t1,0x6
    800034f0:	36433303          	ld	t1,868(t1) # 80009850 <devsw+0x10>
    800034f4:	01010113          	addi	sp,sp,16
    800034f8:	00030067          	jr	t1

00000000800034fc <console_write>:
    800034fc:	ff010113          	addi	sp,sp,-16
    80003500:	00813423          	sd	s0,8(sp)
    80003504:	01010413          	addi	s0,sp,16
    80003508:	00813403          	ld	s0,8(sp)
    8000350c:	00006317          	auipc	t1,0x6
    80003510:	34c33303          	ld	t1,844(t1) # 80009858 <devsw+0x18>
    80003514:	01010113          	addi	sp,sp,16
    80003518:	00030067          	jr	t1

000000008000351c <panic>:
    8000351c:	fe010113          	addi	sp,sp,-32
    80003520:	00113c23          	sd	ra,24(sp)
    80003524:	00813823          	sd	s0,16(sp)
    80003528:	00913423          	sd	s1,8(sp)
    8000352c:	02010413          	addi	s0,sp,32
    80003530:	00050493          	mv	s1,a0
    80003534:	00002517          	auipc	a0,0x2
    80003538:	ce450513          	addi	a0,a0,-796 # 80005218 <CONSOLE_STATUS+0x200>
    8000353c:	00006797          	auipc	a5,0x6
    80003540:	3a07ae23          	sw	zero,956(a5) # 800098f8 <pr+0x18>
    80003544:	00000097          	auipc	ra,0x0
    80003548:	034080e7          	jalr	52(ra) # 80003578 <__printf>
    8000354c:	00048513          	mv	a0,s1
    80003550:	00000097          	auipc	ra,0x0
    80003554:	028080e7          	jalr	40(ra) # 80003578 <__printf>
    80003558:	00002517          	auipc	a0,0x2
    8000355c:	ca050513          	addi	a0,a0,-864 # 800051f8 <CONSOLE_STATUS+0x1e0>
    80003560:	00000097          	auipc	ra,0x0
    80003564:	018080e7          	jalr	24(ra) # 80003578 <__printf>
    80003568:	00100793          	li	a5,1
    8000356c:	00002717          	auipc	a4,0x2
    80003570:	10f72423          	sw	a5,264(a4) # 80005674 <panicked>
    80003574:	0000006f          	j	80003574 <panic+0x58>

0000000080003578 <__printf>:
    80003578:	f3010113          	addi	sp,sp,-208
    8000357c:	08813023          	sd	s0,128(sp)
    80003580:	07313423          	sd	s3,104(sp)
    80003584:	09010413          	addi	s0,sp,144
    80003588:	05813023          	sd	s8,64(sp)
    8000358c:	08113423          	sd	ra,136(sp)
    80003590:	06913c23          	sd	s1,120(sp)
    80003594:	07213823          	sd	s2,112(sp)
    80003598:	07413023          	sd	s4,96(sp)
    8000359c:	05513c23          	sd	s5,88(sp)
    800035a0:	05613823          	sd	s6,80(sp)
    800035a4:	05713423          	sd	s7,72(sp)
    800035a8:	03913c23          	sd	s9,56(sp)
    800035ac:	03a13823          	sd	s10,48(sp)
    800035b0:	03b13423          	sd	s11,40(sp)
    800035b4:	00006317          	auipc	t1,0x6
    800035b8:	32c30313          	addi	t1,t1,812 # 800098e0 <pr>
    800035bc:	01832c03          	lw	s8,24(t1)
    800035c0:	00b43423          	sd	a1,8(s0)
    800035c4:	00c43823          	sd	a2,16(s0)
    800035c8:	00d43c23          	sd	a3,24(s0)
    800035cc:	02e43023          	sd	a4,32(s0)
    800035d0:	02f43423          	sd	a5,40(s0)
    800035d4:	03043823          	sd	a6,48(s0)
    800035d8:	03143c23          	sd	a7,56(s0)
    800035dc:	00050993          	mv	s3,a0
    800035e0:	4a0c1663          	bnez	s8,80003a8c <__printf+0x514>
    800035e4:	60098c63          	beqz	s3,80003bfc <__printf+0x684>
    800035e8:	0009c503          	lbu	a0,0(s3)
    800035ec:	00840793          	addi	a5,s0,8
    800035f0:	f6f43c23          	sd	a5,-136(s0)
    800035f4:	00000493          	li	s1,0
    800035f8:	22050063          	beqz	a0,80003818 <__printf+0x2a0>
    800035fc:	00002a37          	lui	s4,0x2
    80003600:	00018ab7          	lui	s5,0x18
    80003604:	000f4b37          	lui	s6,0xf4
    80003608:	00989bb7          	lui	s7,0x989
    8000360c:	70fa0a13          	addi	s4,s4,1807 # 270f <_entry-0x7fffd8f1>
    80003610:	69fa8a93          	addi	s5,s5,1695 # 1869f <_entry-0x7ffe7961>
    80003614:	23fb0b13          	addi	s6,s6,575 # f423f <_entry-0x7ff0bdc1>
    80003618:	67fb8b93          	addi	s7,s7,1663 # 98967f <_entry-0x7f676981>
    8000361c:	00148c9b          	addiw	s9,s1,1
    80003620:	02500793          	li	a5,37
    80003624:	01998933          	add	s2,s3,s9
    80003628:	38f51263          	bne	a0,a5,800039ac <__printf+0x434>
    8000362c:	00094783          	lbu	a5,0(s2)
    80003630:	00078c9b          	sext.w	s9,a5
    80003634:	1e078263          	beqz	a5,80003818 <__printf+0x2a0>
    80003638:	0024849b          	addiw	s1,s1,2
    8000363c:	07000713          	li	a4,112
    80003640:	00998933          	add	s2,s3,s1
    80003644:	38e78a63          	beq	a5,a4,800039d8 <__printf+0x460>
    80003648:	20f76863          	bltu	a4,a5,80003858 <__printf+0x2e0>
    8000364c:	42a78863          	beq	a5,a0,80003a7c <__printf+0x504>
    80003650:	06400713          	li	a4,100
    80003654:	40e79663          	bne	a5,a4,80003a60 <__printf+0x4e8>
    80003658:	f7843783          	ld	a5,-136(s0)
    8000365c:	0007a603          	lw	a2,0(a5)
    80003660:	00878793          	addi	a5,a5,8
    80003664:	f6f43c23          	sd	a5,-136(s0)
    80003668:	42064a63          	bltz	a2,80003a9c <__printf+0x524>
    8000366c:	00a00713          	li	a4,10
    80003670:	02e677bb          	remuw	a5,a2,a4
    80003674:	00002d97          	auipc	s11,0x2
    80003678:	bccd8d93          	addi	s11,s11,-1076 # 80005240 <digits>
    8000367c:	00900593          	li	a1,9
    80003680:	0006051b          	sext.w	a0,a2
    80003684:	00000c93          	li	s9,0
    80003688:	02079793          	slli	a5,a5,0x20
    8000368c:	0207d793          	srli	a5,a5,0x20
    80003690:	00fd87b3          	add	a5,s11,a5
    80003694:	0007c783          	lbu	a5,0(a5)
    80003698:	02e656bb          	divuw	a3,a2,a4
    8000369c:	f8f40023          	sb	a5,-128(s0)
    800036a0:	14c5d863          	bge	a1,a2,800037f0 <__printf+0x278>
    800036a4:	06300593          	li	a1,99
    800036a8:	00100c93          	li	s9,1
    800036ac:	02e6f7bb          	remuw	a5,a3,a4
    800036b0:	02079793          	slli	a5,a5,0x20
    800036b4:	0207d793          	srli	a5,a5,0x20
    800036b8:	00fd87b3          	add	a5,s11,a5
    800036bc:	0007c783          	lbu	a5,0(a5)
    800036c0:	02e6d73b          	divuw	a4,a3,a4
    800036c4:	f8f400a3          	sb	a5,-127(s0)
    800036c8:	12a5f463          	bgeu	a1,a0,800037f0 <__printf+0x278>
    800036cc:	00a00693          	li	a3,10
    800036d0:	00900593          	li	a1,9
    800036d4:	02d777bb          	remuw	a5,a4,a3
    800036d8:	02079793          	slli	a5,a5,0x20
    800036dc:	0207d793          	srli	a5,a5,0x20
    800036e0:	00fd87b3          	add	a5,s11,a5
    800036e4:	0007c503          	lbu	a0,0(a5)
    800036e8:	02d757bb          	divuw	a5,a4,a3
    800036ec:	f8a40123          	sb	a0,-126(s0)
    800036f0:	48e5f263          	bgeu	a1,a4,80003b74 <__printf+0x5fc>
    800036f4:	06300513          	li	a0,99
    800036f8:	02d7f5bb          	remuw	a1,a5,a3
    800036fc:	02059593          	slli	a1,a1,0x20
    80003700:	0205d593          	srli	a1,a1,0x20
    80003704:	00bd85b3          	add	a1,s11,a1
    80003708:	0005c583          	lbu	a1,0(a1)
    8000370c:	02d7d7bb          	divuw	a5,a5,a3
    80003710:	f8b401a3          	sb	a1,-125(s0)
    80003714:	48e57263          	bgeu	a0,a4,80003b98 <__printf+0x620>
    80003718:	3e700513          	li	a0,999
    8000371c:	02d7f5bb          	remuw	a1,a5,a3
    80003720:	02059593          	slli	a1,a1,0x20
    80003724:	0205d593          	srli	a1,a1,0x20
    80003728:	00bd85b3          	add	a1,s11,a1
    8000372c:	0005c583          	lbu	a1,0(a1)
    80003730:	02d7d7bb          	divuw	a5,a5,a3
    80003734:	f8b40223          	sb	a1,-124(s0)
    80003738:	46e57663          	bgeu	a0,a4,80003ba4 <__printf+0x62c>
    8000373c:	02d7f5bb          	remuw	a1,a5,a3
    80003740:	02059593          	slli	a1,a1,0x20
    80003744:	0205d593          	srli	a1,a1,0x20
    80003748:	00bd85b3          	add	a1,s11,a1
    8000374c:	0005c583          	lbu	a1,0(a1)
    80003750:	02d7d7bb          	divuw	a5,a5,a3
    80003754:	f8b402a3          	sb	a1,-123(s0)
    80003758:	46ea7863          	bgeu	s4,a4,80003bc8 <__printf+0x650>
    8000375c:	02d7f5bb          	remuw	a1,a5,a3
    80003760:	02059593          	slli	a1,a1,0x20
    80003764:	0205d593          	srli	a1,a1,0x20
    80003768:	00bd85b3          	add	a1,s11,a1
    8000376c:	0005c583          	lbu	a1,0(a1)
    80003770:	02d7d7bb          	divuw	a5,a5,a3
    80003774:	f8b40323          	sb	a1,-122(s0)
    80003778:	3eeaf863          	bgeu	s5,a4,80003b68 <__printf+0x5f0>
    8000377c:	02d7f5bb          	remuw	a1,a5,a3
    80003780:	02059593          	slli	a1,a1,0x20
    80003784:	0205d593          	srli	a1,a1,0x20
    80003788:	00bd85b3          	add	a1,s11,a1
    8000378c:	0005c583          	lbu	a1,0(a1)
    80003790:	02d7d7bb          	divuw	a5,a5,a3
    80003794:	f8b403a3          	sb	a1,-121(s0)
    80003798:	42eb7e63          	bgeu	s6,a4,80003bd4 <__printf+0x65c>
    8000379c:	02d7f5bb          	remuw	a1,a5,a3
    800037a0:	02059593          	slli	a1,a1,0x20
    800037a4:	0205d593          	srli	a1,a1,0x20
    800037a8:	00bd85b3          	add	a1,s11,a1
    800037ac:	0005c583          	lbu	a1,0(a1)
    800037b0:	02d7d7bb          	divuw	a5,a5,a3
    800037b4:	f8b40423          	sb	a1,-120(s0)
    800037b8:	42ebfc63          	bgeu	s7,a4,80003bf0 <__printf+0x678>
    800037bc:	02079793          	slli	a5,a5,0x20
    800037c0:	0207d793          	srli	a5,a5,0x20
    800037c4:	00fd8db3          	add	s11,s11,a5
    800037c8:	000dc703          	lbu	a4,0(s11)
    800037cc:	00a00793          	li	a5,10
    800037d0:	00900c93          	li	s9,9
    800037d4:	f8e404a3          	sb	a4,-119(s0)
    800037d8:	00065c63          	bgez	a2,800037f0 <__printf+0x278>
    800037dc:	f9040713          	addi	a4,s0,-112
    800037e0:	00f70733          	add	a4,a4,a5
    800037e4:	02d00693          	li	a3,45
    800037e8:	fed70823          	sb	a3,-16(a4)
    800037ec:	00078c93          	mv	s9,a5
    800037f0:	f8040793          	addi	a5,s0,-128
    800037f4:	01978cb3          	add	s9,a5,s9
    800037f8:	f7f40d13          	addi	s10,s0,-129
    800037fc:	000cc503          	lbu	a0,0(s9)
    80003800:	fffc8c93          	addi	s9,s9,-1
    80003804:	00000097          	auipc	ra,0x0
    80003808:	b90080e7          	jalr	-1136(ra) # 80003394 <consputc>
    8000380c:	ffac98e3          	bne	s9,s10,800037fc <__printf+0x284>
    80003810:	00094503          	lbu	a0,0(s2)
    80003814:	e00514e3          	bnez	a0,8000361c <__printf+0xa4>
    80003818:	1a0c1663          	bnez	s8,800039c4 <__printf+0x44c>
    8000381c:	08813083          	ld	ra,136(sp)
    80003820:	08013403          	ld	s0,128(sp)
    80003824:	07813483          	ld	s1,120(sp)
    80003828:	07013903          	ld	s2,112(sp)
    8000382c:	06813983          	ld	s3,104(sp)
    80003830:	06013a03          	ld	s4,96(sp)
    80003834:	05813a83          	ld	s5,88(sp)
    80003838:	05013b03          	ld	s6,80(sp)
    8000383c:	04813b83          	ld	s7,72(sp)
    80003840:	04013c03          	ld	s8,64(sp)
    80003844:	03813c83          	ld	s9,56(sp)
    80003848:	03013d03          	ld	s10,48(sp)
    8000384c:	02813d83          	ld	s11,40(sp)
    80003850:	0d010113          	addi	sp,sp,208
    80003854:	00008067          	ret
    80003858:	07300713          	li	a4,115
    8000385c:	1ce78a63          	beq	a5,a4,80003a30 <__printf+0x4b8>
    80003860:	07800713          	li	a4,120
    80003864:	1ee79e63          	bne	a5,a4,80003a60 <__printf+0x4e8>
    80003868:	f7843783          	ld	a5,-136(s0)
    8000386c:	0007a703          	lw	a4,0(a5)
    80003870:	00878793          	addi	a5,a5,8
    80003874:	f6f43c23          	sd	a5,-136(s0)
    80003878:	28074263          	bltz	a4,80003afc <__printf+0x584>
    8000387c:	00002d97          	auipc	s11,0x2
    80003880:	9c4d8d93          	addi	s11,s11,-1596 # 80005240 <digits>
    80003884:	00f77793          	andi	a5,a4,15
    80003888:	00fd87b3          	add	a5,s11,a5
    8000388c:	0007c683          	lbu	a3,0(a5)
    80003890:	00f00613          	li	a2,15
    80003894:	0007079b          	sext.w	a5,a4
    80003898:	f8d40023          	sb	a3,-128(s0)
    8000389c:	0047559b          	srliw	a1,a4,0x4
    800038a0:	0047569b          	srliw	a3,a4,0x4
    800038a4:	00000c93          	li	s9,0
    800038a8:	0ee65063          	bge	a2,a4,80003988 <__printf+0x410>
    800038ac:	00f6f693          	andi	a3,a3,15
    800038b0:	00dd86b3          	add	a3,s11,a3
    800038b4:	0006c683          	lbu	a3,0(a3) # 2004000 <_entry-0x7dffc000>
    800038b8:	0087d79b          	srliw	a5,a5,0x8
    800038bc:	00100c93          	li	s9,1
    800038c0:	f8d400a3          	sb	a3,-127(s0)
    800038c4:	0cb67263          	bgeu	a2,a1,80003988 <__printf+0x410>
    800038c8:	00f7f693          	andi	a3,a5,15
    800038cc:	00dd86b3          	add	a3,s11,a3
    800038d0:	0006c583          	lbu	a1,0(a3)
    800038d4:	00f00613          	li	a2,15
    800038d8:	0047d69b          	srliw	a3,a5,0x4
    800038dc:	f8b40123          	sb	a1,-126(s0)
    800038e0:	0047d593          	srli	a1,a5,0x4
    800038e4:	28f67e63          	bgeu	a2,a5,80003b80 <__printf+0x608>
    800038e8:	00f6f693          	andi	a3,a3,15
    800038ec:	00dd86b3          	add	a3,s11,a3
    800038f0:	0006c503          	lbu	a0,0(a3)
    800038f4:	0087d813          	srli	a6,a5,0x8
    800038f8:	0087d69b          	srliw	a3,a5,0x8
    800038fc:	f8a401a3          	sb	a0,-125(s0)
    80003900:	28b67663          	bgeu	a2,a1,80003b8c <__printf+0x614>
    80003904:	00f6f693          	andi	a3,a3,15
    80003908:	00dd86b3          	add	a3,s11,a3
    8000390c:	0006c583          	lbu	a1,0(a3)
    80003910:	00c7d513          	srli	a0,a5,0xc
    80003914:	00c7d69b          	srliw	a3,a5,0xc
    80003918:	f8b40223          	sb	a1,-124(s0)
    8000391c:	29067a63          	bgeu	a2,a6,80003bb0 <__printf+0x638>
    80003920:	00f6f693          	andi	a3,a3,15
    80003924:	00dd86b3          	add	a3,s11,a3
    80003928:	0006c583          	lbu	a1,0(a3)
    8000392c:	0107d813          	srli	a6,a5,0x10
    80003930:	0107d69b          	srliw	a3,a5,0x10
    80003934:	f8b402a3          	sb	a1,-123(s0)
    80003938:	28a67263          	bgeu	a2,a0,80003bbc <__printf+0x644>
    8000393c:	00f6f693          	andi	a3,a3,15
    80003940:	00dd86b3          	add	a3,s11,a3
    80003944:	0006c683          	lbu	a3,0(a3)
    80003948:	0147d79b          	srliw	a5,a5,0x14
    8000394c:	f8d40323          	sb	a3,-122(s0)
    80003950:	21067663          	bgeu	a2,a6,80003b5c <__printf+0x5e4>
    80003954:	02079793          	slli	a5,a5,0x20
    80003958:	0207d793          	srli	a5,a5,0x20
    8000395c:	00fd8db3          	add	s11,s11,a5
    80003960:	000dc683          	lbu	a3,0(s11)
    80003964:	00800793          	li	a5,8
    80003968:	00700c93          	li	s9,7
    8000396c:	f8d403a3          	sb	a3,-121(s0)
    80003970:	00075c63          	bgez	a4,80003988 <__printf+0x410>
    80003974:	f9040713          	addi	a4,s0,-112
    80003978:	00f70733          	add	a4,a4,a5
    8000397c:	02d00693          	li	a3,45
    80003980:	fed70823          	sb	a3,-16(a4)
    80003984:	00078c93          	mv	s9,a5
    80003988:	f8040793          	addi	a5,s0,-128
    8000398c:	01978cb3          	add	s9,a5,s9
    80003990:	f7f40d13          	addi	s10,s0,-129
    80003994:	000cc503          	lbu	a0,0(s9)
    80003998:	fffc8c93          	addi	s9,s9,-1
    8000399c:	00000097          	auipc	ra,0x0
    800039a0:	9f8080e7          	jalr	-1544(ra) # 80003394 <consputc>
    800039a4:	ff9d18e3          	bne	s10,s9,80003994 <__printf+0x41c>
    800039a8:	0100006f          	j	800039b8 <__printf+0x440>
    800039ac:	00000097          	auipc	ra,0x0
    800039b0:	9e8080e7          	jalr	-1560(ra) # 80003394 <consputc>
    800039b4:	000c8493          	mv	s1,s9
    800039b8:	00094503          	lbu	a0,0(s2)
    800039bc:	c60510e3          	bnez	a0,8000361c <__printf+0xa4>
    800039c0:	e40c0ee3          	beqz	s8,8000381c <__printf+0x2a4>
    800039c4:	00006517          	auipc	a0,0x6
    800039c8:	f1c50513          	addi	a0,a0,-228 # 800098e0 <pr>
    800039cc:	00001097          	auipc	ra,0x1
    800039d0:	94c080e7          	jalr	-1716(ra) # 80004318 <release>
    800039d4:	e49ff06f          	j	8000381c <__printf+0x2a4>
    800039d8:	f7843783          	ld	a5,-136(s0)
    800039dc:	03000513          	li	a0,48
    800039e0:	01000d13          	li	s10,16
    800039e4:	00878713          	addi	a4,a5,8
    800039e8:	0007bc83          	ld	s9,0(a5)
    800039ec:	f6e43c23          	sd	a4,-136(s0)
    800039f0:	00000097          	auipc	ra,0x0
    800039f4:	9a4080e7          	jalr	-1628(ra) # 80003394 <consputc>
    800039f8:	07800513          	li	a0,120
    800039fc:	00000097          	auipc	ra,0x0
    80003a00:	998080e7          	jalr	-1640(ra) # 80003394 <consputc>
    80003a04:	00002d97          	auipc	s11,0x2
    80003a08:	83cd8d93          	addi	s11,s11,-1988 # 80005240 <digits>
    80003a0c:	03ccd793          	srli	a5,s9,0x3c
    80003a10:	00fd87b3          	add	a5,s11,a5
    80003a14:	0007c503          	lbu	a0,0(a5)
    80003a18:	fffd0d1b          	addiw	s10,s10,-1
    80003a1c:	004c9c93          	slli	s9,s9,0x4
    80003a20:	00000097          	auipc	ra,0x0
    80003a24:	974080e7          	jalr	-1676(ra) # 80003394 <consputc>
    80003a28:	fe0d12e3          	bnez	s10,80003a0c <__printf+0x494>
    80003a2c:	f8dff06f          	j	800039b8 <__printf+0x440>
    80003a30:	f7843783          	ld	a5,-136(s0)
    80003a34:	0007bc83          	ld	s9,0(a5)
    80003a38:	00878793          	addi	a5,a5,8
    80003a3c:	f6f43c23          	sd	a5,-136(s0)
    80003a40:	000c9a63          	bnez	s9,80003a54 <__printf+0x4dc>
    80003a44:	1080006f          	j	80003b4c <__printf+0x5d4>
    80003a48:	001c8c93          	addi	s9,s9,1
    80003a4c:	00000097          	auipc	ra,0x0
    80003a50:	948080e7          	jalr	-1720(ra) # 80003394 <consputc>
    80003a54:	000cc503          	lbu	a0,0(s9)
    80003a58:	fe0518e3          	bnez	a0,80003a48 <__printf+0x4d0>
    80003a5c:	f5dff06f          	j	800039b8 <__printf+0x440>
    80003a60:	02500513          	li	a0,37
    80003a64:	00000097          	auipc	ra,0x0
    80003a68:	930080e7          	jalr	-1744(ra) # 80003394 <consputc>
    80003a6c:	000c8513          	mv	a0,s9
    80003a70:	00000097          	auipc	ra,0x0
    80003a74:	924080e7          	jalr	-1756(ra) # 80003394 <consputc>
    80003a78:	f41ff06f          	j	800039b8 <__printf+0x440>
    80003a7c:	02500513          	li	a0,37
    80003a80:	00000097          	auipc	ra,0x0
    80003a84:	914080e7          	jalr	-1772(ra) # 80003394 <consputc>
    80003a88:	f31ff06f          	j	800039b8 <__printf+0x440>
    80003a8c:	00030513          	mv	a0,t1
    80003a90:	00000097          	auipc	ra,0x0
    80003a94:	7bc080e7          	jalr	1980(ra) # 8000424c <acquire>
    80003a98:	b4dff06f          	j	800035e4 <__printf+0x6c>
    80003a9c:	40c0053b          	negw	a0,a2
    80003aa0:	00a00713          	li	a4,10
    80003aa4:	02e576bb          	remuw	a3,a0,a4
    80003aa8:	00001d97          	auipc	s11,0x1
    80003aac:	798d8d93          	addi	s11,s11,1944 # 80005240 <digits>
    80003ab0:	ff700593          	li	a1,-9
    80003ab4:	02069693          	slli	a3,a3,0x20
    80003ab8:	0206d693          	srli	a3,a3,0x20
    80003abc:	00dd86b3          	add	a3,s11,a3
    80003ac0:	0006c683          	lbu	a3,0(a3)
    80003ac4:	02e557bb          	divuw	a5,a0,a4
    80003ac8:	f8d40023          	sb	a3,-128(s0)
    80003acc:	10b65e63          	bge	a2,a1,80003be8 <__printf+0x670>
    80003ad0:	06300593          	li	a1,99
    80003ad4:	02e7f6bb          	remuw	a3,a5,a4
    80003ad8:	02069693          	slli	a3,a3,0x20
    80003adc:	0206d693          	srli	a3,a3,0x20
    80003ae0:	00dd86b3          	add	a3,s11,a3
    80003ae4:	0006c683          	lbu	a3,0(a3)
    80003ae8:	02e7d73b          	divuw	a4,a5,a4
    80003aec:	00200793          	li	a5,2
    80003af0:	f8d400a3          	sb	a3,-127(s0)
    80003af4:	bca5ece3          	bltu	a1,a0,800036cc <__printf+0x154>
    80003af8:	ce5ff06f          	j	800037dc <__printf+0x264>
    80003afc:	40e007bb          	negw	a5,a4
    80003b00:	00001d97          	auipc	s11,0x1
    80003b04:	740d8d93          	addi	s11,s11,1856 # 80005240 <digits>
    80003b08:	00f7f693          	andi	a3,a5,15
    80003b0c:	00dd86b3          	add	a3,s11,a3
    80003b10:	0006c583          	lbu	a1,0(a3)
    80003b14:	ff100613          	li	a2,-15
    80003b18:	0047d69b          	srliw	a3,a5,0x4
    80003b1c:	f8b40023          	sb	a1,-128(s0)
    80003b20:	0047d59b          	srliw	a1,a5,0x4
    80003b24:	0ac75e63          	bge	a4,a2,80003be0 <__printf+0x668>
    80003b28:	00f6f693          	andi	a3,a3,15
    80003b2c:	00dd86b3          	add	a3,s11,a3
    80003b30:	0006c603          	lbu	a2,0(a3)
    80003b34:	00f00693          	li	a3,15
    80003b38:	0087d79b          	srliw	a5,a5,0x8
    80003b3c:	f8c400a3          	sb	a2,-127(s0)
    80003b40:	d8b6e4e3          	bltu	a3,a1,800038c8 <__printf+0x350>
    80003b44:	00200793          	li	a5,2
    80003b48:	e2dff06f          	j	80003974 <__printf+0x3fc>
    80003b4c:	00001c97          	auipc	s9,0x1
    80003b50:	6d4c8c93          	addi	s9,s9,1748 # 80005220 <CONSOLE_STATUS+0x208>
    80003b54:	02800513          	li	a0,40
    80003b58:	ef1ff06f          	j	80003a48 <__printf+0x4d0>
    80003b5c:	00700793          	li	a5,7
    80003b60:	00600c93          	li	s9,6
    80003b64:	e0dff06f          	j	80003970 <__printf+0x3f8>
    80003b68:	00700793          	li	a5,7
    80003b6c:	00600c93          	li	s9,6
    80003b70:	c69ff06f          	j	800037d8 <__printf+0x260>
    80003b74:	00300793          	li	a5,3
    80003b78:	00200c93          	li	s9,2
    80003b7c:	c5dff06f          	j	800037d8 <__printf+0x260>
    80003b80:	00300793          	li	a5,3
    80003b84:	00200c93          	li	s9,2
    80003b88:	de9ff06f          	j	80003970 <__printf+0x3f8>
    80003b8c:	00400793          	li	a5,4
    80003b90:	00300c93          	li	s9,3
    80003b94:	dddff06f          	j	80003970 <__printf+0x3f8>
    80003b98:	00400793          	li	a5,4
    80003b9c:	00300c93          	li	s9,3
    80003ba0:	c39ff06f          	j	800037d8 <__printf+0x260>
    80003ba4:	00500793          	li	a5,5
    80003ba8:	00400c93          	li	s9,4
    80003bac:	c2dff06f          	j	800037d8 <__printf+0x260>
    80003bb0:	00500793          	li	a5,5
    80003bb4:	00400c93          	li	s9,4
    80003bb8:	db9ff06f          	j	80003970 <__printf+0x3f8>
    80003bbc:	00600793          	li	a5,6
    80003bc0:	00500c93          	li	s9,5
    80003bc4:	dadff06f          	j	80003970 <__printf+0x3f8>
    80003bc8:	00600793          	li	a5,6
    80003bcc:	00500c93          	li	s9,5
    80003bd0:	c09ff06f          	j	800037d8 <__printf+0x260>
    80003bd4:	00800793          	li	a5,8
    80003bd8:	00700c93          	li	s9,7
    80003bdc:	bfdff06f          	j	800037d8 <__printf+0x260>
    80003be0:	00100793          	li	a5,1
    80003be4:	d91ff06f          	j	80003974 <__printf+0x3fc>
    80003be8:	00100793          	li	a5,1
    80003bec:	bf1ff06f          	j	800037dc <__printf+0x264>
    80003bf0:	00900793          	li	a5,9
    80003bf4:	00800c93          	li	s9,8
    80003bf8:	be1ff06f          	j	800037d8 <__printf+0x260>
    80003bfc:	00001517          	auipc	a0,0x1
    80003c00:	62c50513          	addi	a0,a0,1580 # 80005228 <CONSOLE_STATUS+0x210>
    80003c04:	00000097          	auipc	ra,0x0
    80003c08:	918080e7          	jalr	-1768(ra) # 8000351c <panic>

0000000080003c0c <printfinit>:
    80003c0c:	fe010113          	addi	sp,sp,-32
    80003c10:	00813823          	sd	s0,16(sp)
    80003c14:	00913423          	sd	s1,8(sp)
    80003c18:	00113c23          	sd	ra,24(sp)
    80003c1c:	02010413          	addi	s0,sp,32
    80003c20:	00006497          	auipc	s1,0x6
    80003c24:	cc048493          	addi	s1,s1,-832 # 800098e0 <pr>
    80003c28:	00048513          	mv	a0,s1
    80003c2c:	00001597          	auipc	a1,0x1
    80003c30:	60c58593          	addi	a1,a1,1548 # 80005238 <CONSOLE_STATUS+0x220>
    80003c34:	00000097          	auipc	ra,0x0
    80003c38:	5f4080e7          	jalr	1524(ra) # 80004228 <initlock>
    80003c3c:	01813083          	ld	ra,24(sp)
    80003c40:	01013403          	ld	s0,16(sp)
    80003c44:	0004ac23          	sw	zero,24(s1)
    80003c48:	00813483          	ld	s1,8(sp)
    80003c4c:	02010113          	addi	sp,sp,32
    80003c50:	00008067          	ret

0000000080003c54 <uartinit>:
    80003c54:	ff010113          	addi	sp,sp,-16
    80003c58:	00813423          	sd	s0,8(sp)
    80003c5c:	01010413          	addi	s0,sp,16
    80003c60:	100007b7          	lui	a5,0x10000
    80003c64:	000780a3          	sb	zero,1(a5) # 10000001 <_entry-0x6fffffff>
    80003c68:	f8000713          	li	a4,-128
    80003c6c:	00e781a3          	sb	a4,3(a5)
    80003c70:	00300713          	li	a4,3
    80003c74:	00e78023          	sb	a4,0(a5)
    80003c78:	000780a3          	sb	zero,1(a5)
    80003c7c:	00e781a3          	sb	a4,3(a5)
    80003c80:	00700693          	li	a3,7
    80003c84:	00d78123          	sb	a3,2(a5)
    80003c88:	00e780a3          	sb	a4,1(a5)
    80003c8c:	00813403          	ld	s0,8(sp)
    80003c90:	01010113          	addi	sp,sp,16
    80003c94:	00008067          	ret

0000000080003c98 <uartputc>:
    80003c98:	00002797          	auipc	a5,0x2
    80003c9c:	9dc7a783          	lw	a5,-1572(a5) # 80005674 <panicked>
    80003ca0:	00078463          	beqz	a5,80003ca8 <uartputc+0x10>
    80003ca4:	0000006f          	j	80003ca4 <uartputc+0xc>
    80003ca8:	fd010113          	addi	sp,sp,-48
    80003cac:	02813023          	sd	s0,32(sp)
    80003cb0:	00913c23          	sd	s1,24(sp)
    80003cb4:	01213823          	sd	s2,16(sp)
    80003cb8:	01313423          	sd	s3,8(sp)
    80003cbc:	02113423          	sd	ra,40(sp)
    80003cc0:	03010413          	addi	s0,sp,48
    80003cc4:	00002917          	auipc	s2,0x2
    80003cc8:	9b490913          	addi	s2,s2,-1612 # 80005678 <uart_tx_r>
    80003ccc:	00093783          	ld	a5,0(s2)
    80003cd0:	00002497          	auipc	s1,0x2
    80003cd4:	9b048493          	addi	s1,s1,-1616 # 80005680 <uart_tx_w>
    80003cd8:	0004b703          	ld	a4,0(s1)
    80003cdc:	02078693          	addi	a3,a5,32
    80003ce0:	00050993          	mv	s3,a0
    80003ce4:	02e69c63          	bne	a3,a4,80003d1c <uartputc+0x84>
    80003ce8:	00001097          	auipc	ra,0x1
    80003cec:	834080e7          	jalr	-1996(ra) # 8000451c <push_on>
    80003cf0:	00093783          	ld	a5,0(s2)
    80003cf4:	0004b703          	ld	a4,0(s1)
    80003cf8:	02078793          	addi	a5,a5,32
    80003cfc:	00e79463          	bne	a5,a4,80003d04 <uartputc+0x6c>
    80003d00:	0000006f          	j	80003d00 <uartputc+0x68>
    80003d04:	00001097          	auipc	ra,0x1
    80003d08:	88c080e7          	jalr	-1908(ra) # 80004590 <pop_on>
    80003d0c:	00093783          	ld	a5,0(s2)
    80003d10:	0004b703          	ld	a4,0(s1)
    80003d14:	02078693          	addi	a3,a5,32
    80003d18:	fce688e3          	beq	a3,a4,80003ce8 <uartputc+0x50>
    80003d1c:	01f77693          	andi	a3,a4,31
    80003d20:	00006597          	auipc	a1,0x6
    80003d24:	be058593          	addi	a1,a1,-1056 # 80009900 <uart_tx_buf>
    80003d28:	00d586b3          	add	a3,a1,a3
    80003d2c:	00170713          	addi	a4,a4,1
    80003d30:	01368023          	sb	s3,0(a3)
    80003d34:	00e4b023          	sd	a4,0(s1)
    80003d38:	10000637          	lui	a2,0x10000
    80003d3c:	02f71063          	bne	a4,a5,80003d5c <uartputc+0xc4>
    80003d40:	0340006f          	j	80003d74 <uartputc+0xdc>
    80003d44:	00074703          	lbu	a4,0(a4)
    80003d48:	00f93023          	sd	a5,0(s2)
    80003d4c:	00e60023          	sb	a4,0(a2) # 10000000 <_entry-0x70000000>
    80003d50:	00093783          	ld	a5,0(s2)
    80003d54:	0004b703          	ld	a4,0(s1)
    80003d58:	00f70e63          	beq	a4,a5,80003d74 <uartputc+0xdc>
    80003d5c:	00564683          	lbu	a3,5(a2)
    80003d60:	01f7f713          	andi	a4,a5,31
    80003d64:	00e58733          	add	a4,a1,a4
    80003d68:	0206f693          	andi	a3,a3,32
    80003d6c:	00178793          	addi	a5,a5,1
    80003d70:	fc069ae3          	bnez	a3,80003d44 <uartputc+0xac>
    80003d74:	02813083          	ld	ra,40(sp)
    80003d78:	02013403          	ld	s0,32(sp)
    80003d7c:	01813483          	ld	s1,24(sp)
    80003d80:	01013903          	ld	s2,16(sp)
    80003d84:	00813983          	ld	s3,8(sp)
    80003d88:	03010113          	addi	sp,sp,48
    80003d8c:	00008067          	ret

0000000080003d90 <uartputc_sync>:
    80003d90:	ff010113          	addi	sp,sp,-16
    80003d94:	00813423          	sd	s0,8(sp)
    80003d98:	01010413          	addi	s0,sp,16
    80003d9c:	00002717          	auipc	a4,0x2
    80003da0:	8d872703          	lw	a4,-1832(a4) # 80005674 <panicked>
    80003da4:	02071663          	bnez	a4,80003dd0 <uartputc_sync+0x40>
    80003da8:	00050793          	mv	a5,a0
    80003dac:	100006b7          	lui	a3,0x10000
    80003db0:	0056c703          	lbu	a4,5(a3) # 10000005 <_entry-0x6ffffffb>
    80003db4:	02077713          	andi	a4,a4,32
    80003db8:	fe070ce3          	beqz	a4,80003db0 <uartputc_sync+0x20>
    80003dbc:	0ff7f793          	andi	a5,a5,255
    80003dc0:	00f68023          	sb	a5,0(a3)
    80003dc4:	00813403          	ld	s0,8(sp)
    80003dc8:	01010113          	addi	sp,sp,16
    80003dcc:	00008067          	ret
    80003dd0:	0000006f          	j	80003dd0 <uartputc_sync+0x40>

0000000080003dd4 <uartstart>:
    80003dd4:	ff010113          	addi	sp,sp,-16
    80003dd8:	00813423          	sd	s0,8(sp)
    80003ddc:	01010413          	addi	s0,sp,16
    80003de0:	00002617          	auipc	a2,0x2
    80003de4:	89860613          	addi	a2,a2,-1896 # 80005678 <uart_tx_r>
    80003de8:	00002517          	auipc	a0,0x2
    80003dec:	89850513          	addi	a0,a0,-1896 # 80005680 <uart_tx_w>
    80003df0:	00063783          	ld	a5,0(a2)
    80003df4:	00053703          	ld	a4,0(a0)
    80003df8:	04f70263          	beq	a4,a5,80003e3c <uartstart+0x68>
    80003dfc:	100005b7          	lui	a1,0x10000
    80003e00:	00006817          	auipc	a6,0x6
    80003e04:	b0080813          	addi	a6,a6,-1280 # 80009900 <uart_tx_buf>
    80003e08:	01c0006f          	j	80003e24 <uartstart+0x50>
    80003e0c:	0006c703          	lbu	a4,0(a3)
    80003e10:	00f63023          	sd	a5,0(a2)
    80003e14:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    80003e18:	00063783          	ld	a5,0(a2)
    80003e1c:	00053703          	ld	a4,0(a0)
    80003e20:	00f70e63          	beq	a4,a5,80003e3c <uartstart+0x68>
    80003e24:	01f7f713          	andi	a4,a5,31
    80003e28:	00e806b3          	add	a3,a6,a4
    80003e2c:	0055c703          	lbu	a4,5(a1)
    80003e30:	00178793          	addi	a5,a5,1
    80003e34:	02077713          	andi	a4,a4,32
    80003e38:	fc071ae3          	bnez	a4,80003e0c <uartstart+0x38>
    80003e3c:	00813403          	ld	s0,8(sp)
    80003e40:	01010113          	addi	sp,sp,16
    80003e44:	00008067          	ret

0000000080003e48 <uartgetc>:
    80003e48:	ff010113          	addi	sp,sp,-16
    80003e4c:	00813423          	sd	s0,8(sp)
    80003e50:	01010413          	addi	s0,sp,16
    80003e54:	10000737          	lui	a4,0x10000
    80003e58:	00574783          	lbu	a5,5(a4) # 10000005 <_entry-0x6ffffffb>
    80003e5c:	0017f793          	andi	a5,a5,1
    80003e60:	00078c63          	beqz	a5,80003e78 <uartgetc+0x30>
    80003e64:	00074503          	lbu	a0,0(a4)
    80003e68:	0ff57513          	andi	a0,a0,255
    80003e6c:	00813403          	ld	s0,8(sp)
    80003e70:	01010113          	addi	sp,sp,16
    80003e74:	00008067          	ret
    80003e78:	fff00513          	li	a0,-1
    80003e7c:	ff1ff06f          	j	80003e6c <uartgetc+0x24>

0000000080003e80 <uartintr>:
    80003e80:	100007b7          	lui	a5,0x10000
    80003e84:	0057c783          	lbu	a5,5(a5) # 10000005 <_entry-0x6ffffffb>
    80003e88:	0017f793          	andi	a5,a5,1
    80003e8c:	0a078463          	beqz	a5,80003f34 <uartintr+0xb4>
    80003e90:	fe010113          	addi	sp,sp,-32
    80003e94:	00813823          	sd	s0,16(sp)
    80003e98:	00913423          	sd	s1,8(sp)
    80003e9c:	00113c23          	sd	ra,24(sp)
    80003ea0:	02010413          	addi	s0,sp,32
    80003ea4:	100004b7          	lui	s1,0x10000
    80003ea8:	0004c503          	lbu	a0,0(s1) # 10000000 <_entry-0x70000000>
    80003eac:	0ff57513          	andi	a0,a0,255
    80003eb0:	fffff097          	auipc	ra,0xfffff
    80003eb4:	534080e7          	jalr	1332(ra) # 800033e4 <consoleintr>
    80003eb8:	0054c783          	lbu	a5,5(s1)
    80003ebc:	0017f793          	andi	a5,a5,1
    80003ec0:	fe0794e3          	bnez	a5,80003ea8 <uartintr+0x28>
    80003ec4:	00001617          	auipc	a2,0x1
    80003ec8:	7b460613          	addi	a2,a2,1972 # 80005678 <uart_tx_r>
    80003ecc:	00001517          	auipc	a0,0x1
    80003ed0:	7b450513          	addi	a0,a0,1972 # 80005680 <uart_tx_w>
    80003ed4:	00063783          	ld	a5,0(a2)
    80003ed8:	00053703          	ld	a4,0(a0)
    80003edc:	04f70263          	beq	a4,a5,80003f20 <uartintr+0xa0>
    80003ee0:	100005b7          	lui	a1,0x10000
    80003ee4:	00006817          	auipc	a6,0x6
    80003ee8:	a1c80813          	addi	a6,a6,-1508 # 80009900 <uart_tx_buf>
    80003eec:	01c0006f          	j	80003f08 <uartintr+0x88>
    80003ef0:	0006c703          	lbu	a4,0(a3)
    80003ef4:	00f63023          	sd	a5,0(a2)
    80003ef8:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    80003efc:	00063783          	ld	a5,0(a2)
    80003f00:	00053703          	ld	a4,0(a0)
    80003f04:	00f70e63          	beq	a4,a5,80003f20 <uartintr+0xa0>
    80003f08:	01f7f713          	andi	a4,a5,31
    80003f0c:	00e806b3          	add	a3,a6,a4
    80003f10:	0055c703          	lbu	a4,5(a1)
    80003f14:	00178793          	addi	a5,a5,1
    80003f18:	02077713          	andi	a4,a4,32
    80003f1c:	fc071ae3          	bnez	a4,80003ef0 <uartintr+0x70>
    80003f20:	01813083          	ld	ra,24(sp)
    80003f24:	01013403          	ld	s0,16(sp)
    80003f28:	00813483          	ld	s1,8(sp)
    80003f2c:	02010113          	addi	sp,sp,32
    80003f30:	00008067          	ret
    80003f34:	00001617          	auipc	a2,0x1
    80003f38:	74460613          	addi	a2,a2,1860 # 80005678 <uart_tx_r>
    80003f3c:	00001517          	auipc	a0,0x1
    80003f40:	74450513          	addi	a0,a0,1860 # 80005680 <uart_tx_w>
    80003f44:	00063783          	ld	a5,0(a2)
    80003f48:	00053703          	ld	a4,0(a0)
    80003f4c:	04f70263          	beq	a4,a5,80003f90 <uartintr+0x110>
    80003f50:	100005b7          	lui	a1,0x10000
    80003f54:	00006817          	auipc	a6,0x6
    80003f58:	9ac80813          	addi	a6,a6,-1620 # 80009900 <uart_tx_buf>
    80003f5c:	01c0006f          	j	80003f78 <uartintr+0xf8>
    80003f60:	0006c703          	lbu	a4,0(a3)
    80003f64:	00f63023          	sd	a5,0(a2)
    80003f68:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    80003f6c:	00063783          	ld	a5,0(a2)
    80003f70:	00053703          	ld	a4,0(a0)
    80003f74:	02f70063          	beq	a4,a5,80003f94 <uartintr+0x114>
    80003f78:	01f7f713          	andi	a4,a5,31
    80003f7c:	00e806b3          	add	a3,a6,a4
    80003f80:	0055c703          	lbu	a4,5(a1)
    80003f84:	00178793          	addi	a5,a5,1
    80003f88:	02077713          	andi	a4,a4,32
    80003f8c:	fc071ae3          	bnez	a4,80003f60 <uartintr+0xe0>
    80003f90:	00008067          	ret
    80003f94:	00008067          	ret

0000000080003f98 <kinit>:
    80003f98:	fc010113          	addi	sp,sp,-64
    80003f9c:	02913423          	sd	s1,40(sp)
    80003fa0:	fffff7b7          	lui	a5,0xfffff
    80003fa4:	00007497          	auipc	s1,0x7
    80003fa8:	97b48493          	addi	s1,s1,-1669 # 8000a91f <end+0xfff>
    80003fac:	02813823          	sd	s0,48(sp)
    80003fb0:	01313c23          	sd	s3,24(sp)
    80003fb4:	00f4f4b3          	and	s1,s1,a5
    80003fb8:	02113c23          	sd	ra,56(sp)
    80003fbc:	03213023          	sd	s2,32(sp)
    80003fc0:	01413823          	sd	s4,16(sp)
    80003fc4:	01513423          	sd	s5,8(sp)
    80003fc8:	04010413          	addi	s0,sp,64
    80003fcc:	000017b7          	lui	a5,0x1
    80003fd0:	01100993          	li	s3,17
    80003fd4:	00f487b3          	add	a5,s1,a5
    80003fd8:	01b99993          	slli	s3,s3,0x1b
    80003fdc:	06f9e063          	bltu	s3,a5,8000403c <kinit+0xa4>
    80003fe0:	00006a97          	auipc	s5,0x6
    80003fe4:	940a8a93          	addi	s5,s5,-1728 # 80009920 <end>
    80003fe8:	0754ec63          	bltu	s1,s5,80004060 <kinit+0xc8>
    80003fec:	0734fa63          	bgeu	s1,s3,80004060 <kinit+0xc8>
    80003ff0:	00088a37          	lui	s4,0x88
    80003ff4:	fffa0a13          	addi	s4,s4,-1 # 87fff <_entry-0x7ff78001>
    80003ff8:	00001917          	auipc	s2,0x1
    80003ffc:	69090913          	addi	s2,s2,1680 # 80005688 <kmem>
    80004000:	00ca1a13          	slli	s4,s4,0xc
    80004004:	0140006f          	j	80004018 <kinit+0x80>
    80004008:	000017b7          	lui	a5,0x1
    8000400c:	00f484b3          	add	s1,s1,a5
    80004010:	0554e863          	bltu	s1,s5,80004060 <kinit+0xc8>
    80004014:	0534f663          	bgeu	s1,s3,80004060 <kinit+0xc8>
    80004018:	00001637          	lui	a2,0x1
    8000401c:	00100593          	li	a1,1
    80004020:	00048513          	mv	a0,s1
    80004024:	00000097          	auipc	ra,0x0
    80004028:	5e4080e7          	jalr	1508(ra) # 80004608 <__memset>
    8000402c:	00093783          	ld	a5,0(s2)
    80004030:	00f4b023          	sd	a5,0(s1)
    80004034:	00993023          	sd	s1,0(s2)
    80004038:	fd4498e3          	bne	s1,s4,80004008 <kinit+0x70>
    8000403c:	03813083          	ld	ra,56(sp)
    80004040:	03013403          	ld	s0,48(sp)
    80004044:	02813483          	ld	s1,40(sp)
    80004048:	02013903          	ld	s2,32(sp)
    8000404c:	01813983          	ld	s3,24(sp)
    80004050:	01013a03          	ld	s4,16(sp)
    80004054:	00813a83          	ld	s5,8(sp)
    80004058:	04010113          	addi	sp,sp,64
    8000405c:	00008067          	ret
    80004060:	00001517          	auipc	a0,0x1
    80004064:	1f850513          	addi	a0,a0,504 # 80005258 <digits+0x18>
    80004068:	fffff097          	auipc	ra,0xfffff
    8000406c:	4b4080e7          	jalr	1204(ra) # 8000351c <panic>

0000000080004070 <freerange>:
    80004070:	fc010113          	addi	sp,sp,-64
    80004074:	000017b7          	lui	a5,0x1
    80004078:	02913423          	sd	s1,40(sp)
    8000407c:	fff78493          	addi	s1,a5,-1 # fff <_entry-0x7ffff001>
    80004080:	009504b3          	add	s1,a0,s1
    80004084:	fffff537          	lui	a0,0xfffff
    80004088:	02813823          	sd	s0,48(sp)
    8000408c:	02113c23          	sd	ra,56(sp)
    80004090:	03213023          	sd	s2,32(sp)
    80004094:	01313c23          	sd	s3,24(sp)
    80004098:	01413823          	sd	s4,16(sp)
    8000409c:	01513423          	sd	s5,8(sp)
    800040a0:	01613023          	sd	s6,0(sp)
    800040a4:	04010413          	addi	s0,sp,64
    800040a8:	00a4f4b3          	and	s1,s1,a0
    800040ac:	00f487b3          	add	a5,s1,a5
    800040b0:	06f5e463          	bltu	a1,a5,80004118 <freerange+0xa8>
    800040b4:	00006a97          	auipc	s5,0x6
    800040b8:	86ca8a93          	addi	s5,s5,-1940 # 80009920 <end>
    800040bc:	0954e263          	bltu	s1,s5,80004140 <freerange+0xd0>
    800040c0:	01100993          	li	s3,17
    800040c4:	01b99993          	slli	s3,s3,0x1b
    800040c8:	0734fc63          	bgeu	s1,s3,80004140 <freerange+0xd0>
    800040cc:	00058a13          	mv	s4,a1
    800040d0:	00001917          	auipc	s2,0x1
    800040d4:	5b890913          	addi	s2,s2,1464 # 80005688 <kmem>
    800040d8:	00002b37          	lui	s6,0x2
    800040dc:	0140006f          	j	800040f0 <freerange+0x80>
    800040e0:	000017b7          	lui	a5,0x1
    800040e4:	00f484b3          	add	s1,s1,a5
    800040e8:	0554ec63          	bltu	s1,s5,80004140 <freerange+0xd0>
    800040ec:	0534fa63          	bgeu	s1,s3,80004140 <freerange+0xd0>
    800040f0:	00001637          	lui	a2,0x1
    800040f4:	00100593          	li	a1,1
    800040f8:	00048513          	mv	a0,s1
    800040fc:	00000097          	auipc	ra,0x0
    80004100:	50c080e7          	jalr	1292(ra) # 80004608 <__memset>
    80004104:	00093703          	ld	a4,0(s2)
    80004108:	016487b3          	add	a5,s1,s6
    8000410c:	00e4b023          	sd	a4,0(s1)
    80004110:	00993023          	sd	s1,0(s2)
    80004114:	fcfa76e3          	bgeu	s4,a5,800040e0 <freerange+0x70>
    80004118:	03813083          	ld	ra,56(sp)
    8000411c:	03013403          	ld	s0,48(sp)
    80004120:	02813483          	ld	s1,40(sp)
    80004124:	02013903          	ld	s2,32(sp)
    80004128:	01813983          	ld	s3,24(sp)
    8000412c:	01013a03          	ld	s4,16(sp)
    80004130:	00813a83          	ld	s5,8(sp)
    80004134:	00013b03          	ld	s6,0(sp)
    80004138:	04010113          	addi	sp,sp,64
    8000413c:	00008067          	ret
    80004140:	00001517          	auipc	a0,0x1
    80004144:	11850513          	addi	a0,a0,280 # 80005258 <digits+0x18>
    80004148:	fffff097          	auipc	ra,0xfffff
    8000414c:	3d4080e7          	jalr	980(ra) # 8000351c <panic>

0000000080004150 <kfree>:
    80004150:	fe010113          	addi	sp,sp,-32
    80004154:	00813823          	sd	s0,16(sp)
    80004158:	00113c23          	sd	ra,24(sp)
    8000415c:	00913423          	sd	s1,8(sp)
    80004160:	02010413          	addi	s0,sp,32
    80004164:	03451793          	slli	a5,a0,0x34
    80004168:	04079c63          	bnez	a5,800041c0 <kfree+0x70>
    8000416c:	00005797          	auipc	a5,0x5
    80004170:	7b478793          	addi	a5,a5,1972 # 80009920 <end>
    80004174:	00050493          	mv	s1,a0
    80004178:	04f56463          	bltu	a0,a5,800041c0 <kfree+0x70>
    8000417c:	01100793          	li	a5,17
    80004180:	01b79793          	slli	a5,a5,0x1b
    80004184:	02f57e63          	bgeu	a0,a5,800041c0 <kfree+0x70>
    80004188:	00001637          	lui	a2,0x1
    8000418c:	00100593          	li	a1,1
    80004190:	00000097          	auipc	ra,0x0
    80004194:	478080e7          	jalr	1144(ra) # 80004608 <__memset>
    80004198:	00001797          	auipc	a5,0x1
    8000419c:	4f078793          	addi	a5,a5,1264 # 80005688 <kmem>
    800041a0:	0007b703          	ld	a4,0(a5)
    800041a4:	01813083          	ld	ra,24(sp)
    800041a8:	01013403          	ld	s0,16(sp)
    800041ac:	00e4b023          	sd	a4,0(s1)
    800041b0:	0097b023          	sd	s1,0(a5)
    800041b4:	00813483          	ld	s1,8(sp)
    800041b8:	02010113          	addi	sp,sp,32
    800041bc:	00008067          	ret
    800041c0:	00001517          	auipc	a0,0x1
    800041c4:	09850513          	addi	a0,a0,152 # 80005258 <digits+0x18>
    800041c8:	fffff097          	auipc	ra,0xfffff
    800041cc:	354080e7          	jalr	852(ra) # 8000351c <panic>

00000000800041d0 <kalloc>:
    800041d0:	fe010113          	addi	sp,sp,-32
    800041d4:	00813823          	sd	s0,16(sp)
    800041d8:	00913423          	sd	s1,8(sp)
    800041dc:	00113c23          	sd	ra,24(sp)
    800041e0:	02010413          	addi	s0,sp,32
    800041e4:	00001797          	auipc	a5,0x1
    800041e8:	4a478793          	addi	a5,a5,1188 # 80005688 <kmem>
    800041ec:	0007b483          	ld	s1,0(a5)
    800041f0:	02048063          	beqz	s1,80004210 <kalloc+0x40>
    800041f4:	0004b703          	ld	a4,0(s1)
    800041f8:	00001637          	lui	a2,0x1
    800041fc:	00500593          	li	a1,5
    80004200:	00048513          	mv	a0,s1
    80004204:	00e7b023          	sd	a4,0(a5)
    80004208:	00000097          	auipc	ra,0x0
    8000420c:	400080e7          	jalr	1024(ra) # 80004608 <__memset>
    80004210:	01813083          	ld	ra,24(sp)
    80004214:	01013403          	ld	s0,16(sp)
    80004218:	00048513          	mv	a0,s1
    8000421c:	00813483          	ld	s1,8(sp)
    80004220:	02010113          	addi	sp,sp,32
    80004224:	00008067          	ret

0000000080004228 <initlock>:
    80004228:	ff010113          	addi	sp,sp,-16
    8000422c:	00813423          	sd	s0,8(sp)
    80004230:	01010413          	addi	s0,sp,16
    80004234:	00813403          	ld	s0,8(sp)
    80004238:	00b53423          	sd	a1,8(a0)
    8000423c:	00052023          	sw	zero,0(a0)
    80004240:	00053823          	sd	zero,16(a0)
    80004244:	01010113          	addi	sp,sp,16
    80004248:	00008067          	ret

000000008000424c <acquire>:
    8000424c:	fe010113          	addi	sp,sp,-32
    80004250:	00813823          	sd	s0,16(sp)
    80004254:	00913423          	sd	s1,8(sp)
    80004258:	00113c23          	sd	ra,24(sp)
    8000425c:	01213023          	sd	s2,0(sp)
    80004260:	02010413          	addi	s0,sp,32
    80004264:	00050493          	mv	s1,a0
    80004268:	10002973          	csrr	s2,sstatus
    8000426c:	100027f3          	csrr	a5,sstatus
    80004270:	ffd7f793          	andi	a5,a5,-3
    80004274:	10079073          	csrw	sstatus,a5
    80004278:	fffff097          	auipc	ra,0xfffff
    8000427c:	8ec080e7          	jalr	-1812(ra) # 80002b64 <mycpu>
    80004280:	07852783          	lw	a5,120(a0)
    80004284:	06078e63          	beqz	a5,80004300 <acquire+0xb4>
    80004288:	fffff097          	auipc	ra,0xfffff
    8000428c:	8dc080e7          	jalr	-1828(ra) # 80002b64 <mycpu>
    80004290:	07852783          	lw	a5,120(a0)
    80004294:	0004a703          	lw	a4,0(s1)
    80004298:	0017879b          	addiw	a5,a5,1
    8000429c:	06f52c23          	sw	a5,120(a0)
    800042a0:	04071063          	bnez	a4,800042e0 <acquire+0x94>
    800042a4:	00100713          	li	a4,1
    800042a8:	00070793          	mv	a5,a4
    800042ac:	0cf4a7af          	amoswap.w.aq	a5,a5,(s1)
    800042b0:	0007879b          	sext.w	a5,a5
    800042b4:	fe079ae3          	bnez	a5,800042a8 <acquire+0x5c>
    800042b8:	0ff0000f          	fence
    800042bc:	fffff097          	auipc	ra,0xfffff
    800042c0:	8a8080e7          	jalr	-1880(ra) # 80002b64 <mycpu>
    800042c4:	01813083          	ld	ra,24(sp)
    800042c8:	01013403          	ld	s0,16(sp)
    800042cc:	00a4b823          	sd	a0,16(s1)
    800042d0:	00013903          	ld	s2,0(sp)
    800042d4:	00813483          	ld	s1,8(sp)
    800042d8:	02010113          	addi	sp,sp,32
    800042dc:	00008067          	ret
    800042e0:	0104b903          	ld	s2,16(s1)
    800042e4:	fffff097          	auipc	ra,0xfffff
    800042e8:	880080e7          	jalr	-1920(ra) # 80002b64 <mycpu>
    800042ec:	faa91ce3          	bne	s2,a0,800042a4 <acquire+0x58>
    800042f0:	00001517          	auipc	a0,0x1
    800042f4:	f7050513          	addi	a0,a0,-144 # 80005260 <digits+0x20>
    800042f8:	fffff097          	auipc	ra,0xfffff
    800042fc:	224080e7          	jalr	548(ra) # 8000351c <panic>
    80004300:	00195913          	srli	s2,s2,0x1
    80004304:	fffff097          	auipc	ra,0xfffff
    80004308:	860080e7          	jalr	-1952(ra) # 80002b64 <mycpu>
    8000430c:	00197913          	andi	s2,s2,1
    80004310:	07252e23          	sw	s2,124(a0)
    80004314:	f75ff06f          	j	80004288 <acquire+0x3c>

0000000080004318 <release>:
    80004318:	fe010113          	addi	sp,sp,-32
    8000431c:	00813823          	sd	s0,16(sp)
    80004320:	00113c23          	sd	ra,24(sp)
    80004324:	00913423          	sd	s1,8(sp)
    80004328:	01213023          	sd	s2,0(sp)
    8000432c:	02010413          	addi	s0,sp,32
    80004330:	00052783          	lw	a5,0(a0)
    80004334:	00079a63          	bnez	a5,80004348 <release+0x30>
    80004338:	00001517          	auipc	a0,0x1
    8000433c:	f3050513          	addi	a0,a0,-208 # 80005268 <digits+0x28>
    80004340:	fffff097          	auipc	ra,0xfffff
    80004344:	1dc080e7          	jalr	476(ra) # 8000351c <panic>
    80004348:	01053903          	ld	s2,16(a0)
    8000434c:	00050493          	mv	s1,a0
    80004350:	fffff097          	auipc	ra,0xfffff
    80004354:	814080e7          	jalr	-2028(ra) # 80002b64 <mycpu>
    80004358:	fea910e3          	bne	s2,a0,80004338 <release+0x20>
    8000435c:	0004b823          	sd	zero,16(s1)
    80004360:	0ff0000f          	fence
    80004364:	0f50000f          	fence	iorw,ow
    80004368:	0804a02f          	amoswap.w	zero,zero,(s1)
    8000436c:	ffffe097          	auipc	ra,0xffffe
    80004370:	7f8080e7          	jalr	2040(ra) # 80002b64 <mycpu>
    80004374:	100027f3          	csrr	a5,sstatus
    80004378:	0027f793          	andi	a5,a5,2
    8000437c:	04079a63          	bnez	a5,800043d0 <release+0xb8>
    80004380:	07852783          	lw	a5,120(a0)
    80004384:	02f05e63          	blez	a5,800043c0 <release+0xa8>
    80004388:	fff7871b          	addiw	a4,a5,-1
    8000438c:	06e52c23          	sw	a4,120(a0)
    80004390:	00071c63          	bnez	a4,800043a8 <release+0x90>
    80004394:	07c52783          	lw	a5,124(a0)
    80004398:	00078863          	beqz	a5,800043a8 <release+0x90>
    8000439c:	100027f3          	csrr	a5,sstatus
    800043a0:	0027e793          	ori	a5,a5,2
    800043a4:	10079073          	csrw	sstatus,a5
    800043a8:	01813083          	ld	ra,24(sp)
    800043ac:	01013403          	ld	s0,16(sp)
    800043b0:	00813483          	ld	s1,8(sp)
    800043b4:	00013903          	ld	s2,0(sp)
    800043b8:	02010113          	addi	sp,sp,32
    800043bc:	00008067          	ret
    800043c0:	00001517          	auipc	a0,0x1
    800043c4:	ec850513          	addi	a0,a0,-312 # 80005288 <digits+0x48>
    800043c8:	fffff097          	auipc	ra,0xfffff
    800043cc:	154080e7          	jalr	340(ra) # 8000351c <panic>
    800043d0:	00001517          	auipc	a0,0x1
    800043d4:	ea050513          	addi	a0,a0,-352 # 80005270 <digits+0x30>
    800043d8:	fffff097          	auipc	ra,0xfffff
    800043dc:	144080e7          	jalr	324(ra) # 8000351c <panic>

00000000800043e0 <holding>:
    800043e0:	00052783          	lw	a5,0(a0)
    800043e4:	00079663          	bnez	a5,800043f0 <holding+0x10>
    800043e8:	00000513          	li	a0,0
    800043ec:	00008067          	ret
    800043f0:	fe010113          	addi	sp,sp,-32
    800043f4:	00813823          	sd	s0,16(sp)
    800043f8:	00913423          	sd	s1,8(sp)
    800043fc:	00113c23          	sd	ra,24(sp)
    80004400:	02010413          	addi	s0,sp,32
    80004404:	01053483          	ld	s1,16(a0)
    80004408:	ffffe097          	auipc	ra,0xffffe
    8000440c:	75c080e7          	jalr	1884(ra) # 80002b64 <mycpu>
    80004410:	01813083          	ld	ra,24(sp)
    80004414:	01013403          	ld	s0,16(sp)
    80004418:	40a48533          	sub	a0,s1,a0
    8000441c:	00153513          	seqz	a0,a0
    80004420:	00813483          	ld	s1,8(sp)
    80004424:	02010113          	addi	sp,sp,32
    80004428:	00008067          	ret

000000008000442c <push_off>:
    8000442c:	fe010113          	addi	sp,sp,-32
    80004430:	00813823          	sd	s0,16(sp)
    80004434:	00113c23          	sd	ra,24(sp)
    80004438:	00913423          	sd	s1,8(sp)
    8000443c:	02010413          	addi	s0,sp,32
    80004440:	100024f3          	csrr	s1,sstatus
    80004444:	100027f3          	csrr	a5,sstatus
    80004448:	ffd7f793          	andi	a5,a5,-3
    8000444c:	10079073          	csrw	sstatus,a5
    80004450:	ffffe097          	auipc	ra,0xffffe
    80004454:	714080e7          	jalr	1812(ra) # 80002b64 <mycpu>
    80004458:	07852783          	lw	a5,120(a0)
    8000445c:	02078663          	beqz	a5,80004488 <push_off+0x5c>
    80004460:	ffffe097          	auipc	ra,0xffffe
    80004464:	704080e7          	jalr	1796(ra) # 80002b64 <mycpu>
    80004468:	07852783          	lw	a5,120(a0)
    8000446c:	01813083          	ld	ra,24(sp)
    80004470:	01013403          	ld	s0,16(sp)
    80004474:	0017879b          	addiw	a5,a5,1
    80004478:	06f52c23          	sw	a5,120(a0)
    8000447c:	00813483          	ld	s1,8(sp)
    80004480:	02010113          	addi	sp,sp,32
    80004484:	00008067          	ret
    80004488:	0014d493          	srli	s1,s1,0x1
    8000448c:	ffffe097          	auipc	ra,0xffffe
    80004490:	6d8080e7          	jalr	1752(ra) # 80002b64 <mycpu>
    80004494:	0014f493          	andi	s1,s1,1
    80004498:	06952e23          	sw	s1,124(a0)
    8000449c:	fc5ff06f          	j	80004460 <push_off+0x34>

00000000800044a0 <pop_off>:
    800044a0:	ff010113          	addi	sp,sp,-16
    800044a4:	00813023          	sd	s0,0(sp)
    800044a8:	00113423          	sd	ra,8(sp)
    800044ac:	01010413          	addi	s0,sp,16
    800044b0:	ffffe097          	auipc	ra,0xffffe
    800044b4:	6b4080e7          	jalr	1716(ra) # 80002b64 <mycpu>
    800044b8:	100027f3          	csrr	a5,sstatus
    800044bc:	0027f793          	andi	a5,a5,2
    800044c0:	04079663          	bnez	a5,8000450c <pop_off+0x6c>
    800044c4:	07852783          	lw	a5,120(a0)
    800044c8:	02f05a63          	blez	a5,800044fc <pop_off+0x5c>
    800044cc:	fff7871b          	addiw	a4,a5,-1
    800044d0:	06e52c23          	sw	a4,120(a0)
    800044d4:	00071c63          	bnez	a4,800044ec <pop_off+0x4c>
    800044d8:	07c52783          	lw	a5,124(a0)
    800044dc:	00078863          	beqz	a5,800044ec <pop_off+0x4c>
    800044e0:	100027f3          	csrr	a5,sstatus
    800044e4:	0027e793          	ori	a5,a5,2
    800044e8:	10079073          	csrw	sstatus,a5
    800044ec:	00813083          	ld	ra,8(sp)
    800044f0:	00013403          	ld	s0,0(sp)
    800044f4:	01010113          	addi	sp,sp,16
    800044f8:	00008067          	ret
    800044fc:	00001517          	auipc	a0,0x1
    80004500:	d8c50513          	addi	a0,a0,-628 # 80005288 <digits+0x48>
    80004504:	fffff097          	auipc	ra,0xfffff
    80004508:	018080e7          	jalr	24(ra) # 8000351c <panic>
    8000450c:	00001517          	auipc	a0,0x1
    80004510:	d6450513          	addi	a0,a0,-668 # 80005270 <digits+0x30>
    80004514:	fffff097          	auipc	ra,0xfffff
    80004518:	008080e7          	jalr	8(ra) # 8000351c <panic>

000000008000451c <push_on>:
    8000451c:	fe010113          	addi	sp,sp,-32
    80004520:	00813823          	sd	s0,16(sp)
    80004524:	00113c23          	sd	ra,24(sp)
    80004528:	00913423          	sd	s1,8(sp)
    8000452c:	02010413          	addi	s0,sp,32
    80004530:	100024f3          	csrr	s1,sstatus
    80004534:	100027f3          	csrr	a5,sstatus
    80004538:	0027e793          	ori	a5,a5,2
    8000453c:	10079073          	csrw	sstatus,a5
    80004540:	ffffe097          	auipc	ra,0xffffe
    80004544:	624080e7          	jalr	1572(ra) # 80002b64 <mycpu>
    80004548:	07852783          	lw	a5,120(a0)
    8000454c:	02078663          	beqz	a5,80004578 <push_on+0x5c>
    80004550:	ffffe097          	auipc	ra,0xffffe
    80004554:	614080e7          	jalr	1556(ra) # 80002b64 <mycpu>
    80004558:	07852783          	lw	a5,120(a0)
    8000455c:	01813083          	ld	ra,24(sp)
    80004560:	01013403          	ld	s0,16(sp)
    80004564:	0017879b          	addiw	a5,a5,1
    80004568:	06f52c23          	sw	a5,120(a0)
    8000456c:	00813483          	ld	s1,8(sp)
    80004570:	02010113          	addi	sp,sp,32
    80004574:	00008067          	ret
    80004578:	0014d493          	srli	s1,s1,0x1
    8000457c:	ffffe097          	auipc	ra,0xffffe
    80004580:	5e8080e7          	jalr	1512(ra) # 80002b64 <mycpu>
    80004584:	0014f493          	andi	s1,s1,1
    80004588:	06952e23          	sw	s1,124(a0)
    8000458c:	fc5ff06f          	j	80004550 <push_on+0x34>

0000000080004590 <pop_on>:
    80004590:	ff010113          	addi	sp,sp,-16
    80004594:	00813023          	sd	s0,0(sp)
    80004598:	00113423          	sd	ra,8(sp)
    8000459c:	01010413          	addi	s0,sp,16
    800045a0:	ffffe097          	auipc	ra,0xffffe
    800045a4:	5c4080e7          	jalr	1476(ra) # 80002b64 <mycpu>
    800045a8:	100027f3          	csrr	a5,sstatus
    800045ac:	0027f793          	andi	a5,a5,2
    800045b0:	04078463          	beqz	a5,800045f8 <pop_on+0x68>
    800045b4:	07852783          	lw	a5,120(a0)
    800045b8:	02f05863          	blez	a5,800045e8 <pop_on+0x58>
    800045bc:	fff7879b          	addiw	a5,a5,-1
    800045c0:	06f52c23          	sw	a5,120(a0)
    800045c4:	07853783          	ld	a5,120(a0)
    800045c8:	00079863          	bnez	a5,800045d8 <pop_on+0x48>
    800045cc:	100027f3          	csrr	a5,sstatus
    800045d0:	ffd7f793          	andi	a5,a5,-3
    800045d4:	10079073          	csrw	sstatus,a5
    800045d8:	00813083          	ld	ra,8(sp)
    800045dc:	00013403          	ld	s0,0(sp)
    800045e0:	01010113          	addi	sp,sp,16
    800045e4:	00008067          	ret
    800045e8:	00001517          	auipc	a0,0x1
    800045ec:	cc850513          	addi	a0,a0,-824 # 800052b0 <digits+0x70>
    800045f0:	fffff097          	auipc	ra,0xfffff
    800045f4:	f2c080e7          	jalr	-212(ra) # 8000351c <panic>
    800045f8:	00001517          	auipc	a0,0x1
    800045fc:	c9850513          	addi	a0,a0,-872 # 80005290 <digits+0x50>
    80004600:	fffff097          	auipc	ra,0xfffff
    80004604:	f1c080e7          	jalr	-228(ra) # 8000351c <panic>

0000000080004608 <__memset>:
    80004608:	ff010113          	addi	sp,sp,-16
    8000460c:	00813423          	sd	s0,8(sp)
    80004610:	01010413          	addi	s0,sp,16
    80004614:	1a060e63          	beqz	a2,800047d0 <__memset+0x1c8>
    80004618:	40a007b3          	neg	a5,a0
    8000461c:	0077f793          	andi	a5,a5,7
    80004620:	00778693          	addi	a3,a5,7
    80004624:	00b00813          	li	a6,11
    80004628:	0ff5f593          	andi	a1,a1,255
    8000462c:	fff6071b          	addiw	a4,a2,-1
    80004630:	1b06e663          	bltu	a3,a6,800047dc <__memset+0x1d4>
    80004634:	1cd76463          	bltu	a4,a3,800047fc <__memset+0x1f4>
    80004638:	1a078e63          	beqz	a5,800047f4 <__memset+0x1ec>
    8000463c:	00b50023          	sb	a1,0(a0)
    80004640:	00100713          	li	a4,1
    80004644:	1ae78463          	beq	a5,a4,800047ec <__memset+0x1e4>
    80004648:	00b500a3          	sb	a1,1(a0)
    8000464c:	00200713          	li	a4,2
    80004650:	1ae78a63          	beq	a5,a4,80004804 <__memset+0x1fc>
    80004654:	00b50123          	sb	a1,2(a0)
    80004658:	00300713          	li	a4,3
    8000465c:	18e78463          	beq	a5,a4,800047e4 <__memset+0x1dc>
    80004660:	00b501a3          	sb	a1,3(a0)
    80004664:	00400713          	li	a4,4
    80004668:	1ae78263          	beq	a5,a4,8000480c <__memset+0x204>
    8000466c:	00b50223          	sb	a1,4(a0)
    80004670:	00500713          	li	a4,5
    80004674:	1ae78063          	beq	a5,a4,80004814 <__memset+0x20c>
    80004678:	00b502a3          	sb	a1,5(a0)
    8000467c:	00700713          	li	a4,7
    80004680:	18e79e63          	bne	a5,a4,8000481c <__memset+0x214>
    80004684:	00b50323          	sb	a1,6(a0)
    80004688:	00700e93          	li	t4,7
    8000468c:	00859713          	slli	a4,a1,0x8
    80004690:	00e5e733          	or	a4,a1,a4
    80004694:	01059e13          	slli	t3,a1,0x10
    80004698:	01c76e33          	or	t3,a4,t3
    8000469c:	01859313          	slli	t1,a1,0x18
    800046a0:	006e6333          	or	t1,t3,t1
    800046a4:	02059893          	slli	a7,a1,0x20
    800046a8:	40f60e3b          	subw	t3,a2,a5
    800046ac:	011368b3          	or	a7,t1,a7
    800046b0:	02859813          	slli	a6,a1,0x28
    800046b4:	0108e833          	or	a6,a7,a6
    800046b8:	03059693          	slli	a3,a1,0x30
    800046bc:	003e589b          	srliw	a7,t3,0x3
    800046c0:	00d866b3          	or	a3,a6,a3
    800046c4:	03859713          	slli	a4,a1,0x38
    800046c8:	00389813          	slli	a6,a7,0x3
    800046cc:	00f507b3          	add	a5,a0,a5
    800046d0:	00e6e733          	or	a4,a3,a4
    800046d4:	000e089b          	sext.w	a7,t3
    800046d8:	00f806b3          	add	a3,a6,a5
    800046dc:	00e7b023          	sd	a4,0(a5)
    800046e0:	00878793          	addi	a5,a5,8
    800046e4:	fed79ce3          	bne	a5,a3,800046dc <__memset+0xd4>
    800046e8:	ff8e7793          	andi	a5,t3,-8
    800046ec:	0007871b          	sext.w	a4,a5
    800046f0:	01d787bb          	addw	a5,a5,t4
    800046f4:	0ce88e63          	beq	a7,a4,800047d0 <__memset+0x1c8>
    800046f8:	00f50733          	add	a4,a0,a5
    800046fc:	00b70023          	sb	a1,0(a4)
    80004700:	0017871b          	addiw	a4,a5,1
    80004704:	0cc77663          	bgeu	a4,a2,800047d0 <__memset+0x1c8>
    80004708:	00e50733          	add	a4,a0,a4
    8000470c:	00b70023          	sb	a1,0(a4)
    80004710:	0027871b          	addiw	a4,a5,2
    80004714:	0ac77e63          	bgeu	a4,a2,800047d0 <__memset+0x1c8>
    80004718:	00e50733          	add	a4,a0,a4
    8000471c:	00b70023          	sb	a1,0(a4)
    80004720:	0037871b          	addiw	a4,a5,3
    80004724:	0ac77663          	bgeu	a4,a2,800047d0 <__memset+0x1c8>
    80004728:	00e50733          	add	a4,a0,a4
    8000472c:	00b70023          	sb	a1,0(a4)
    80004730:	0047871b          	addiw	a4,a5,4
    80004734:	08c77e63          	bgeu	a4,a2,800047d0 <__memset+0x1c8>
    80004738:	00e50733          	add	a4,a0,a4
    8000473c:	00b70023          	sb	a1,0(a4)
    80004740:	0057871b          	addiw	a4,a5,5
    80004744:	08c77663          	bgeu	a4,a2,800047d0 <__memset+0x1c8>
    80004748:	00e50733          	add	a4,a0,a4
    8000474c:	00b70023          	sb	a1,0(a4)
    80004750:	0067871b          	addiw	a4,a5,6
    80004754:	06c77e63          	bgeu	a4,a2,800047d0 <__memset+0x1c8>
    80004758:	00e50733          	add	a4,a0,a4
    8000475c:	00b70023          	sb	a1,0(a4)
    80004760:	0077871b          	addiw	a4,a5,7
    80004764:	06c77663          	bgeu	a4,a2,800047d0 <__memset+0x1c8>
    80004768:	00e50733          	add	a4,a0,a4
    8000476c:	00b70023          	sb	a1,0(a4)
    80004770:	0087871b          	addiw	a4,a5,8
    80004774:	04c77e63          	bgeu	a4,a2,800047d0 <__memset+0x1c8>
    80004778:	00e50733          	add	a4,a0,a4
    8000477c:	00b70023          	sb	a1,0(a4)
    80004780:	0097871b          	addiw	a4,a5,9
    80004784:	04c77663          	bgeu	a4,a2,800047d0 <__memset+0x1c8>
    80004788:	00e50733          	add	a4,a0,a4
    8000478c:	00b70023          	sb	a1,0(a4)
    80004790:	00a7871b          	addiw	a4,a5,10
    80004794:	02c77e63          	bgeu	a4,a2,800047d0 <__memset+0x1c8>
    80004798:	00e50733          	add	a4,a0,a4
    8000479c:	00b70023          	sb	a1,0(a4)
    800047a0:	00b7871b          	addiw	a4,a5,11
    800047a4:	02c77663          	bgeu	a4,a2,800047d0 <__memset+0x1c8>
    800047a8:	00e50733          	add	a4,a0,a4
    800047ac:	00b70023          	sb	a1,0(a4)
    800047b0:	00c7871b          	addiw	a4,a5,12
    800047b4:	00c77e63          	bgeu	a4,a2,800047d0 <__memset+0x1c8>
    800047b8:	00e50733          	add	a4,a0,a4
    800047bc:	00b70023          	sb	a1,0(a4)
    800047c0:	00d7879b          	addiw	a5,a5,13
    800047c4:	00c7f663          	bgeu	a5,a2,800047d0 <__memset+0x1c8>
    800047c8:	00f507b3          	add	a5,a0,a5
    800047cc:	00b78023          	sb	a1,0(a5)
    800047d0:	00813403          	ld	s0,8(sp)
    800047d4:	01010113          	addi	sp,sp,16
    800047d8:	00008067          	ret
    800047dc:	00b00693          	li	a3,11
    800047e0:	e55ff06f          	j	80004634 <__memset+0x2c>
    800047e4:	00300e93          	li	t4,3
    800047e8:	ea5ff06f          	j	8000468c <__memset+0x84>
    800047ec:	00100e93          	li	t4,1
    800047f0:	e9dff06f          	j	8000468c <__memset+0x84>
    800047f4:	00000e93          	li	t4,0
    800047f8:	e95ff06f          	j	8000468c <__memset+0x84>
    800047fc:	00000793          	li	a5,0
    80004800:	ef9ff06f          	j	800046f8 <__memset+0xf0>
    80004804:	00200e93          	li	t4,2
    80004808:	e85ff06f          	j	8000468c <__memset+0x84>
    8000480c:	00400e93          	li	t4,4
    80004810:	e7dff06f          	j	8000468c <__memset+0x84>
    80004814:	00500e93          	li	t4,5
    80004818:	e75ff06f          	j	8000468c <__memset+0x84>
    8000481c:	00600e93          	li	t4,6
    80004820:	e6dff06f          	j	8000468c <__memset+0x84>

0000000080004824 <__memmove>:
    80004824:	ff010113          	addi	sp,sp,-16
    80004828:	00813423          	sd	s0,8(sp)
    8000482c:	01010413          	addi	s0,sp,16
    80004830:	0e060863          	beqz	a2,80004920 <__memmove+0xfc>
    80004834:	fff6069b          	addiw	a3,a2,-1
    80004838:	0006881b          	sext.w	a6,a3
    8000483c:	0ea5e863          	bltu	a1,a0,8000492c <__memmove+0x108>
    80004840:	00758713          	addi	a4,a1,7
    80004844:	00a5e7b3          	or	a5,a1,a0
    80004848:	40a70733          	sub	a4,a4,a0
    8000484c:	0077f793          	andi	a5,a5,7
    80004850:	00f73713          	sltiu	a4,a4,15
    80004854:	00174713          	xori	a4,a4,1
    80004858:	0017b793          	seqz	a5,a5
    8000485c:	00e7f7b3          	and	a5,a5,a4
    80004860:	10078863          	beqz	a5,80004970 <__memmove+0x14c>
    80004864:	00900793          	li	a5,9
    80004868:	1107f463          	bgeu	a5,a6,80004970 <__memmove+0x14c>
    8000486c:	0036581b          	srliw	a6,a2,0x3
    80004870:	fff8081b          	addiw	a6,a6,-1
    80004874:	02081813          	slli	a6,a6,0x20
    80004878:	01d85893          	srli	a7,a6,0x1d
    8000487c:	00858813          	addi	a6,a1,8
    80004880:	00058793          	mv	a5,a1
    80004884:	00050713          	mv	a4,a0
    80004888:	01088833          	add	a6,a7,a6
    8000488c:	0007b883          	ld	a7,0(a5)
    80004890:	00878793          	addi	a5,a5,8
    80004894:	00870713          	addi	a4,a4,8
    80004898:	ff173c23          	sd	a7,-8(a4)
    8000489c:	ff0798e3          	bne	a5,a6,8000488c <__memmove+0x68>
    800048a0:	ff867713          	andi	a4,a2,-8
    800048a4:	02071793          	slli	a5,a4,0x20
    800048a8:	0207d793          	srli	a5,a5,0x20
    800048ac:	00f585b3          	add	a1,a1,a5
    800048b0:	40e686bb          	subw	a3,a3,a4
    800048b4:	00f507b3          	add	a5,a0,a5
    800048b8:	06e60463          	beq	a2,a4,80004920 <__memmove+0xfc>
    800048bc:	0005c703          	lbu	a4,0(a1)
    800048c0:	00e78023          	sb	a4,0(a5)
    800048c4:	04068e63          	beqz	a3,80004920 <__memmove+0xfc>
    800048c8:	0015c603          	lbu	a2,1(a1)
    800048cc:	00100713          	li	a4,1
    800048d0:	00c780a3          	sb	a2,1(a5)
    800048d4:	04e68663          	beq	a3,a4,80004920 <__memmove+0xfc>
    800048d8:	0025c603          	lbu	a2,2(a1)
    800048dc:	00200713          	li	a4,2
    800048e0:	00c78123          	sb	a2,2(a5)
    800048e4:	02e68e63          	beq	a3,a4,80004920 <__memmove+0xfc>
    800048e8:	0035c603          	lbu	a2,3(a1)
    800048ec:	00300713          	li	a4,3
    800048f0:	00c781a3          	sb	a2,3(a5)
    800048f4:	02e68663          	beq	a3,a4,80004920 <__memmove+0xfc>
    800048f8:	0045c603          	lbu	a2,4(a1)
    800048fc:	00400713          	li	a4,4
    80004900:	00c78223          	sb	a2,4(a5)
    80004904:	00e68e63          	beq	a3,a4,80004920 <__memmove+0xfc>
    80004908:	0055c603          	lbu	a2,5(a1)
    8000490c:	00500713          	li	a4,5
    80004910:	00c782a3          	sb	a2,5(a5)
    80004914:	00e68663          	beq	a3,a4,80004920 <__memmove+0xfc>
    80004918:	0065c703          	lbu	a4,6(a1)
    8000491c:	00e78323          	sb	a4,6(a5)
    80004920:	00813403          	ld	s0,8(sp)
    80004924:	01010113          	addi	sp,sp,16
    80004928:	00008067          	ret
    8000492c:	02061713          	slli	a4,a2,0x20
    80004930:	02075713          	srli	a4,a4,0x20
    80004934:	00e587b3          	add	a5,a1,a4
    80004938:	f0f574e3          	bgeu	a0,a5,80004840 <__memmove+0x1c>
    8000493c:	02069613          	slli	a2,a3,0x20
    80004940:	02065613          	srli	a2,a2,0x20
    80004944:	fff64613          	not	a2,a2
    80004948:	00e50733          	add	a4,a0,a4
    8000494c:	00c78633          	add	a2,a5,a2
    80004950:	fff7c683          	lbu	a3,-1(a5)
    80004954:	fff78793          	addi	a5,a5,-1
    80004958:	fff70713          	addi	a4,a4,-1
    8000495c:	00d70023          	sb	a3,0(a4)
    80004960:	fec798e3          	bne	a5,a2,80004950 <__memmove+0x12c>
    80004964:	00813403          	ld	s0,8(sp)
    80004968:	01010113          	addi	sp,sp,16
    8000496c:	00008067          	ret
    80004970:	02069713          	slli	a4,a3,0x20
    80004974:	02075713          	srli	a4,a4,0x20
    80004978:	00170713          	addi	a4,a4,1
    8000497c:	00e50733          	add	a4,a0,a4
    80004980:	00050793          	mv	a5,a0
    80004984:	0005c683          	lbu	a3,0(a1)
    80004988:	00178793          	addi	a5,a5,1
    8000498c:	00158593          	addi	a1,a1,1
    80004990:	fed78fa3          	sb	a3,-1(a5)
    80004994:	fee798e3          	bne	a5,a4,80004984 <__memmove+0x160>
    80004998:	f89ff06f          	j	80004920 <__memmove+0xfc>

000000008000499c <__putc>:
    8000499c:	fe010113          	addi	sp,sp,-32
    800049a0:	00813823          	sd	s0,16(sp)
    800049a4:	00113c23          	sd	ra,24(sp)
    800049a8:	02010413          	addi	s0,sp,32
    800049ac:	00050793          	mv	a5,a0
    800049b0:	fef40593          	addi	a1,s0,-17
    800049b4:	00100613          	li	a2,1
    800049b8:	00000513          	li	a0,0
    800049bc:	fef407a3          	sb	a5,-17(s0)
    800049c0:	fffff097          	auipc	ra,0xfffff
    800049c4:	b3c080e7          	jalr	-1220(ra) # 800034fc <console_write>
    800049c8:	01813083          	ld	ra,24(sp)
    800049cc:	01013403          	ld	s0,16(sp)
    800049d0:	02010113          	addi	sp,sp,32
    800049d4:	00008067          	ret

00000000800049d8 <__getc>:
    800049d8:	fe010113          	addi	sp,sp,-32
    800049dc:	00813823          	sd	s0,16(sp)
    800049e0:	00113c23          	sd	ra,24(sp)
    800049e4:	02010413          	addi	s0,sp,32
    800049e8:	fe840593          	addi	a1,s0,-24
    800049ec:	00100613          	li	a2,1
    800049f0:	00000513          	li	a0,0
    800049f4:	fffff097          	auipc	ra,0xfffff
    800049f8:	ae8080e7          	jalr	-1304(ra) # 800034dc <console_read>
    800049fc:	fe844503          	lbu	a0,-24(s0)
    80004a00:	01813083          	ld	ra,24(sp)
    80004a04:	01013403          	ld	s0,16(sp)
    80004a08:	02010113          	addi	sp,sp,32
    80004a0c:	00008067          	ret

0000000080004a10 <console_handler>:
    80004a10:	fe010113          	addi	sp,sp,-32
    80004a14:	00813823          	sd	s0,16(sp)
    80004a18:	00113c23          	sd	ra,24(sp)
    80004a1c:	00913423          	sd	s1,8(sp)
    80004a20:	02010413          	addi	s0,sp,32
    80004a24:	14202773          	csrr	a4,scause
    80004a28:	100027f3          	csrr	a5,sstatus
    80004a2c:	0027f793          	andi	a5,a5,2
    80004a30:	06079e63          	bnez	a5,80004aac <console_handler+0x9c>
    80004a34:	00074c63          	bltz	a4,80004a4c <console_handler+0x3c>
    80004a38:	01813083          	ld	ra,24(sp)
    80004a3c:	01013403          	ld	s0,16(sp)
    80004a40:	00813483          	ld	s1,8(sp)
    80004a44:	02010113          	addi	sp,sp,32
    80004a48:	00008067          	ret
    80004a4c:	0ff77713          	andi	a4,a4,255
    80004a50:	00900793          	li	a5,9
    80004a54:	fef712e3          	bne	a4,a5,80004a38 <console_handler+0x28>
    80004a58:	ffffe097          	auipc	ra,0xffffe
    80004a5c:	6dc080e7          	jalr	1756(ra) # 80003134 <plic_claim>
    80004a60:	00a00793          	li	a5,10
    80004a64:	00050493          	mv	s1,a0
    80004a68:	02f50c63          	beq	a0,a5,80004aa0 <console_handler+0x90>
    80004a6c:	fc0506e3          	beqz	a0,80004a38 <console_handler+0x28>
    80004a70:	00050593          	mv	a1,a0
    80004a74:	00000517          	auipc	a0,0x0
    80004a78:	74450513          	addi	a0,a0,1860 # 800051b8 <CONSOLE_STATUS+0x1a0>
    80004a7c:	fffff097          	auipc	ra,0xfffff
    80004a80:	afc080e7          	jalr	-1284(ra) # 80003578 <__printf>
    80004a84:	01013403          	ld	s0,16(sp)
    80004a88:	01813083          	ld	ra,24(sp)
    80004a8c:	00048513          	mv	a0,s1
    80004a90:	00813483          	ld	s1,8(sp)
    80004a94:	02010113          	addi	sp,sp,32
    80004a98:	ffffe317          	auipc	t1,0xffffe
    80004a9c:	6d430067          	jr	1748(t1) # 8000316c <plic_complete>
    80004aa0:	fffff097          	auipc	ra,0xfffff
    80004aa4:	3e0080e7          	jalr	992(ra) # 80003e80 <uartintr>
    80004aa8:	fddff06f          	j	80004a84 <console_handler+0x74>
    80004aac:	00001517          	auipc	a0,0x1
    80004ab0:	80c50513          	addi	a0,a0,-2036 # 800052b8 <digits+0x78>
    80004ab4:	fffff097          	auipc	ra,0xfffff
    80004ab8:	a68080e7          	jalr	-1432(ra) # 8000351c <panic>
	...
