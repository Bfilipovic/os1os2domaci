
kernel:     file format elf64-littleriscv


Disassembly of section .text:

0000000080000000 <_entry>:
    80000000:	00005117          	auipc	sp,0x5
    80000004:	62813103          	ld	sp,1576(sp) # 80005628 <_GLOBAL_OFFSET_TABLE_+0x10>
    80000008:	00001537          	lui	a0,0x1
    8000000c:	f14025f3          	csrr	a1,mhartid
    80000010:	00158593          	addi	a1,a1,1
    80000014:	02b50533          	mul	a0,a0,a1
    80000018:	00a10133          	add	sp,sp,a0
    8000001c:	145020ef          	jal	ra,80002960 <start>

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
    800010a8:	0b1000ef          	jal	ra,80001958 <handleInterrupt>

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
    800011b4:	508000ef          	jal	ra,800016bc <handleEcall>
    
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
    80001280:	42478793          	addi	a5,a5,1060 # 800056a0 <semaphores>
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
    800012d4:	3d070713          	addi	a4,a4,976 # 800056a0 <semaphores>
    800012d8:	00d70733          	add	a4,a4,a3
    800012dc:	00472683          	lw	a3,4(a4)
    800012e0:	00100713          	li	a4,1
    800012e4:	fce69ee3          	bne	a3,a4,800012c0 <kern_sem_open+0x14>
            semaphores[i].status=SEM_USED;
    800012e8:	00479793          	slli	a5,a5,0x4
    800012ec:	00004717          	auipc	a4,0x4
    800012f0:	3b470713          	addi	a4,a4,948 # 800056a0 <semaphores>
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
    id->val--;
    800013b8:	00052783          	lw	a5,0(a0)
    800013bc:	fff7879b          	addiw	a5,a5,-1
    800013c0:	00f52023          	sw	a5,0(a0)
    if(id->val<0){
    800013c4:	02079713          	slli	a4,a5,0x20
    800013c8:	00074663          	bltz	a4,800013d4 <kern_sem_wait+0x1c>
        w_sstatus(sstatus);
        w_sepc(v_sepc);
        return running->mailbox;
    }
    else {
        return 1;
    800013cc:	00100513          	li	a0,1
    }
}
    800013d0:	00008067          	ret
{
    800013d4:	fd010113          	addi	sp,sp,-48
    800013d8:	02113423          	sd	ra,40(sp)
    800013dc:	02813023          	sd	s0,32(sp)
    800013e0:	03010413          	addi	s0,sp,48
        running->status=SUSPENDED;
    800013e4:	00004697          	auipc	a3,0x4
    800013e8:	28c6b683          	ld	a3,652(a3) # 80005670 <running>
    800013ec:	00300793          	li	a5,3
    800013f0:	04f6a823          	sw	a5,80(a3)
        if(id->waiting_thread==0) id->waiting_thread=running;
    800013f4:	00853783          	ld	a5,8(a0)
    800013f8:	06078663          	beqz	a5,80001464 <kern_sem_wait+0xac>
            while (curr->sem_next!=0) curr=curr->sem_next;
    800013fc:	00078713          	mv	a4,a5
    80001400:	0587b783          	ld	a5,88(a5)
    80001404:	fe079ce3          	bnez	a5,800013fc <kern_sem_wait+0x44>
            curr->sem_next=running;
    80001408:	04d73c23          	sd	a3,88(a4)
        running->sem_next=0;
    8000140c:	0406bc23          	sd	zero,88(a3)
}

inline uint64 r_sstatus()
{
    uint64 volatile sstatus;
    __asm__ volatile ("csrr %[sstatus], sstatus" : [sstatus] "=r"(sstatus));
    80001410:	100027f3          	csrr	a5,sstatus
    80001414:	fef43423          	sd	a5,-24(s0)
    return sstatus;
    80001418:	fe843783          	ld	a5,-24(s0)
        uint64 volatile sstatus = r_sstatus();
    8000141c:	fcf43823          	sd	a5,-48(s0)
    __asm__ volatile ("csrr %[sepc], sepc" : [sepc] "=r"(sepc));
    80001420:	141027f3          	csrr	a5,sepc
    80001424:	fef43023          	sd	a5,-32(s0)
    return sepc;
    80001428:	fe043783          	ld	a5,-32(s0)
        uint64 volatile v_sepc = r_sepc();
    8000142c:	fcf43c23          	sd	a5,-40(s0)
        kern_thread_dispatch();
    80001430:	00001097          	auipc	ra,0x1
    80001434:	8b8080e7          	jalr	-1864(ra) # 80001ce8 <kern_thread_dispatch>
        w_sstatus(sstatus);
    80001438:	fd043783          	ld	a5,-48(s0)
}

inline void w_sstatus(uint64 sstatus)
{
    __asm__ volatile ("csrw sstatus, %[sstatus]" : : [sstatus] "r"(sstatus));
    8000143c:	10079073          	csrw	sstatus,a5
        w_sepc(v_sepc);
    80001440:	fd843783          	ld	a5,-40(s0)
    __asm__ volatile ("csrw sepc, %[sepc]" : : [sepc] "r"(sepc));
    80001444:	14179073          	csrw	sepc,a5
        return running->mailbox;
    80001448:	00004797          	auipc	a5,0x4
    8000144c:	2287b783          	ld	a5,552(a5) # 80005670 <running>
    80001450:	0487a503          	lw	a0,72(a5)
}
    80001454:	02813083          	ld	ra,40(sp)
    80001458:	02013403          	ld	s0,32(sp)
    8000145c:	03010113          	addi	sp,sp,48
    80001460:	00008067          	ret
        if(id->waiting_thread==0) id->waiting_thread=running;
    80001464:	00d53423          	sd	a3,8(a0)
    80001468:	fa5ff06f          	j	8000140c <kern_sem_wait+0x54>

000000008000146c <kern_mem_alloc>:

mem_block_s * freeHead;


void* kern_mem_alloc(int sizeInBlocks)
{
    8000146c:	ff010113          	addi	sp,sp,-16
    80001470:	00813423          	sd	s0,8(sp)
    80001474:	01010413          	addi	s0,sp,16
    80001478:	00050693          	mv	a3,a0
    mem_block_s *curr = freeHead;
    8000147c:	00004597          	auipc	a1,0x4
    80001480:	1dc5b583          	ld	a1,476(a1) # 80005658 <freeHead>
    80001484:	00058513          	mv	a0,a1
    mem_block_s *prev = 0;
    80001488:	00000613          	li	a2,0

    while (curr){
    8000148c:	0480006f          	j	800014d4 <kern_mem_alloc+0x68>
        if(curr->sizeInBlocks==sizeInBlocks+1){
            if(curr==freeHead) freeHead=curr->next;
    80001490:	02b50063          	beq	a0,a1,800014b0 <kern_mem_alloc+0x44>
            else prev->next = curr->next;
    80001494:	00853783          	ld	a5,8(a0)
    80001498:	00f63423          	sd	a5,8(a2)
            curr->sizeInBlocks=sizeInBlocks+1;
    8000149c:	00e52023          	sw	a4,0(a0)
            return (curr+MEM_BLOCK_SIZE);
    800014a0:	40050513          	addi	a0,a0,1024
        prev=curr;
        curr=curr->next;
    }

    return 0;
}
    800014a4:	00813403          	ld	s0,8(sp)
    800014a8:	01010113          	addi	sp,sp,16
    800014ac:	00008067          	ret
            if(curr==freeHead) freeHead=curr->next;
    800014b0:	00853783          	ld	a5,8(a0)
    800014b4:	00004697          	auipc	a3,0x4
    800014b8:	1af6b223          	sd	a5,420(a3) # 80005658 <freeHead>
    800014bc:	fe1ff06f          	j	8000149c <kern_mem_alloc+0x30>
            if(curr==freeHead) freeHead=newFreeBlock;
    800014c0:	00004797          	auipc	a5,0x4
    800014c4:	18b7bc23          	sd	a1,408(a5) # 80005658 <freeHead>
    800014c8:	05c0006f          	j	80001524 <kern_mem_alloc+0xb8>
        prev=curr;
    800014cc:	00050613          	mv	a2,a0
        curr=curr->next;
    800014d0:	00853503          	ld	a0,8(a0)
    while (curr){
    800014d4:	fc0508e3          	beqz	a0,800014a4 <kern_mem_alloc+0x38>
        if(curr->sizeInBlocks==sizeInBlocks+1){
    800014d8:	00052783          	lw	a5,0(a0)
    800014dc:	0016871b          	addiw	a4,a3,1
    800014e0:	fae788e3          	beq	a5,a4,80001490 <kern_mem_alloc+0x24>
        else if(curr->sizeInBlocks>sizeInBlocks+1){
    800014e4:	fef754e3          	bge	a4,a5,800014cc <kern_mem_alloc+0x60>
            mem_block_s* newFreeBlock = curr+(sizeInBlocks+1)*MEM_BLOCK_SIZE;
    800014e8:	00a71593          	slli	a1,a4,0xa
    800014ec:	00b505b3          	add	a1,a0,a1
            newFreeBlock->sizeInBlocks = curr->sizeInBlocks-sizeInBlocks-1;
    800014f0:	40d787bb          	subw	a5,a5,a3
    800014f4:	fff7879b          	addiw	a5,a5,-1
    800014f8:	00f5a023          	sw	a5,0(a1)
            newFreeBlock->startingBlock=curr->startingBlock+sizeInBlocks+1;
    800014fc:	00452783          	lw	a5,4(a0)
    80001500:	00d786bb          	addw	a3,a5,a3
    80001504:	0016869b          	addiw	a3,a3,1
    80001508:	00d5a223          	sw	a3,4(a1)
            newFreeBlock->next = curr->next;
    8000150c:	00853783          	ld	a5,8(a0)
    80001510:	00f5b423          	sd	a5,8(a1)
            if(curr==freeHead) freeHead=newFreeBlock;
    80001514:	00004797          	auipc	a5,0x4
    80001518:	1447b783          	ld	a5,324(a5) # 80005658 <freeHead>
    8000151c:	faa782e3          	beq	a5,a0,800014c0 <kern_mem_alloc+0x54>
            else prev->next=newFreeBlock;
    80001520:	00b63423          	sd	a1,8(a2)
            curr->sizeInBlocks=sizeInBlocks+1;
    80001524:	00e52023          	sw	a4,0(a0)
            return (curr+MEM_BLOCK_SIZE);
    80001528:	40050513          	addi	a0,a0,1024
    8000152c:	f79ff06f          	j	800014a4 <kern_mem_alloc+0x38>

0000000080001530 <kern_mem_free>:

int kern_mem_free(void* addr)
{
    80001530:	ff010113          	addi	sp,sp,-16
    80001534:	00813423          	sd	s0,8(sp)
    80001538:	01010413          	addi	s0,sp,16
    mem_block_s* freedBlock = (mem_block_s*) addr-MEM_BLOCK_SIZE;
    8000153c:	c0050713          	addi	a4,a0,-1024
    mem_block_s* curr=freeHead;
    80001540:	00004797          	auipc	a5,0x4
    80001544:	1187b783          	ld	a5,280(a5) # 80005658 <freeHead>
    mem_block_s * prev =0;
    80001548:	00000693          	li	a3,0

    while (curr<freedBlock && curr!=0){
    8000154c:	00e7fa63          	bgeu	a5,a4,80001560 <kern_mem_free+0x30>
    80001550:	00078863          	beqz	a5,80001560 <kern_mem_free+0x30>
        prev=curr;
    80001554:	00078693          	mv	a3,a5
        curr=curr->next;
    80001558:	0087b783          	ld	a5,8(a5)
    8000155c:	ff1ff06f          	j	8000154c <kern_mem_free+0x1c>
    char* cfreedBlock = (char *)freedBlock;
    char* cprev = (char *)prev;
    char* ccurr = (char *)curr;
    */

    if(prev){
    80001560:	04068e63          	beqz	a3,800015bc <kern_mem_free+0x8c>
        if(prev->startingBlock+prev->sizeInBlocks==freedBlock->startingBlock){
    80001564:	0046a603          	lw	a2,4(a3)
    80001568:	0006a583          	lw	a1,0(a3)
    8000156c:	00b6063b          	addw	a2,a2,a1
    80001570:	c0452803          	lw	a6,-1020(a0)
    80001574:	03060a63          	beq	a2,a6,800015a8 <kern_mem_free+0x78>
            prev->sizeInBlocks+=freedBlock->sizeInBlocks;
            freedBlock=prev;
        } else {
            prev->next=freedBlock;
    80001578:	00e6b423          	sd	a4,8(a3)
        }
    }
    else freeHead=freedBlock;

    if(curr){
    8000157c:	00078e63          	beqz	a5,80001598 <kern_mem_free+0x68>
        if(freedBlock->startingBlock+freedBlock->sizeInBlocks==curr->startingBlock){
    80001580:	00472683          	lw	a3,4(a4)
    80001584:	00072603          	lw	a2,0(a4)
    80001588:	00c686bb          	addw	a3,a3,a2
    8000158c:	0047a583          	lw	a1,4(a5)
    80001590:	02b68c63          	beq	a3,a1,800015c8 <kern_mem_free+0x98>
            freedBlock->sizeInBlocks+=curr->sizeInBlocks;
            freedBlock->next=curr->next;
        } else{
          freedBlock->next=curr;
    80001594:	00f73423          	sd	a5,8(a4)
        }
    }


    return 0;
}
    80001598:	00000513          	li	a0,0
    8000159c:	00813403          	ld	s0,8(sp)
    800015a0:	01010113          	addi	sp,sp,16
    800015a4:	00008067          	ret
            prev->sizeInBlocks+=freedBlock->sizeInBlocks;
    800015a8:	c0052703          	lw	a4,-1024(a0)
    800015ac:	00e585bb          	addw	a1,a1,a4
    800015b0:	00b6a023          	sw	a1,0(a3)
            freedBlock=prev;
    800015b4:	00068713          	mv	a4,a3
    800015b8:	fc5ff06f          	j	8000157c <kern_mem_free+0x4c>
    else freeHead=freedBlock;
    800015bc:	00004697          	auipc	a3,0x4
    800015c0:	08e6be23          	sd	a4,156(a3) # 80005658 <freeHead>
    800015c4:	fb9ff06f          	j	8000157c <kern_mem_free+0x4c>
            freedBlock->sizeInBlocks+=curr->sizeInBlocks;
    800015c8:	0007a683          	lw	a3,0(a5)
    800015cc:	00d6063b          	addw	a2,a2,a3
    800015d0:	00c72023          	sw	a2,0(a4)
            freedBlock->next=curr->next;
    800015d4:	0087b783          	ld	a5,8(a5)
    800015d8:	00f73423          	sd	a5,8(a4)
    800015dc:	fbdff06f          	j	80001598 <kern_mem_free+0x68>

00000000800015e0 <kern_mem_init>:

unsigned long ukupno_memorije;
void kern_mem_init(void* start, void* end)
{
    800015e0:	ff010113          	addi	sp,sp,-16
    800015e4:	00813423          	sd	s0,8(sp)
    800015e8:	01010413          	addi	s0,sp,16
    unsigned long lstart = (unsigned long) start;
    unsigned long lend = (unsigned long) end;
    800015ec:	00058793          	mv	a5,a1

    if(lstart%MEM_BLOCK_SIZE>0) start =(void*) ((lstart/MEM_BLOCK_SIZE+1)*MEM_BLOCK_SIZE);
    800015f0:	03f57713          	andi	a4,a0,63
    800015f4:	00070863          	beqz	a4,80001604 <kern_mem_init+0x24>
    800015f8:	00655513          	srli	a0,a0,0x6
    800015fc:	00150513          	addi	a0,a0,1
    80001600:	00651513          	slli	a0,a0,0x6
    if(lend%MEM_BLOCK_SIZE>0) end =(void*) ((lend/MEM_BLOCK_SIZE)*MEM_BLOCK_SIZE);
    80001604:	03f7f713          	andi	a4,a5,63
    80001608:	00070463          	beqz	a4,80001610 <kern_mem_init+0x30>
    8000160c:	fc07f593          	andi	a1,a5,-64

    freeHead = (mem_block_s*)start;
    80001610:	00004797          	auipc	a5,0x4
    80001614:	04878793          	addi	a5,a5,72 # 80005658 <freeHead>
    80001618:	00a7b023          	sd	a0,0(a5)
    freeHead->next=0;
    8000161c:	00053423          	sd	zero,8(a0)
    freeHead->startingBlock=0;
    80001620:	00052223          	sw	zero,4(a0)
    freeHead->sizeInBlocks = (end-start)/MEM_BLOCK_SIZE;
    80001624:	40a58533          	sub	a0,a1,a0
    80001628:	00655513          	srli	a0,a0,0x6
    8000162c:	0007b703          	ld	a4,0(a5)
    80001630:	00a72023          	sw	a0,0(a4)
    ukupno_memorije=freeHead->sizeInBlocks;
    80001634:	0007b783          	ld	a5,0(a5)
    80001638:	0007a783          	lw	a5,0(a5)
    8000163c:	00004717          	auipc	a4,0x4
    80001640:	00f73a23          	sd	a5,20(a4) # 80005650 <ukupno_memorije>
}
    80001644:	00813403          	ld	s0,8(sp)
    80001648:	01010113          	addi	sp,sp,16
    8000164c:	00008067          	ret

0000000080001650 <kern_syscall>:

uint64 SYSTEM_TIME;


void kern_syscall(enum SyscallNumber num, ...)
{
    80001650:	fb010113          	addi	sp,sp,-80
    80001654:	00813423          	sd	s0,8(sp)
    80001658:	01010413          	addi	s0,sp,16
    8000165c:	00b43423          	sd	a1,8(s0)
    80001660:	00c43823          	sd	a2,16(s0)
    80001664:	00d43c23          	sd	a3,24(s0)
    80001668:	02e43023          	sd	a4,32(s0)
    8000166c:	02f43423          	sd	a5,40(s0)
    80001670:	03043823          	sd	a6,48(s0)
    80001674:	03143c23          	sd	a7,56(s0)
    __asm__ volatile ("ecall");
    80001678:	00000073          	ecall
    return;
}
    8000167c:	00813403          	ld	s0,8(sp)
    80001680:	05010113          	addi	sp,sp,80
    80001684:	00008067          	ret

0000000080001688 <kern_interrupt_init>:

void kern_interrupt_init()
{
    80001688:	ff010113          	addi	sp,sp,-16
    8000168c:	00813423          	sd	s0,8(sp)
    80001690:	01010413          	addi	s0,sp,16
    SYSTEM_TIME=0;
    80001694:	00004797          	auipc	a5,0x4
    80001698:	fc07ba23          	sd	zero,-44(a5) # 80005668 <SYSTEM_TIME>
    w_stvec((uint64) &supervisorTrap);
    8000169c:	00000797          	auipc	a5,0x0
    800016a0:	96478793          	addi	a5,a5,-1692 # 80001000 <supervisorTrap>
    __asm__ volatile ("csrw stvec, %[stvec]" : : [stvec] "r"(stvec));
    800016a4:	10579073          	csrw	stvec,a5
    __asm__ volatile ("csrs sstatus, %[mask]" : : [mask] "r"(mask));
    800016a8:	00200793          	li	a5,2
    800016ac:	1007a073          	csrs	sstatus,a5
    ms_sstatus(SSTATUS_SIE);
}
    800016b0:	00813403          	ld	s0,8(sp)
    800016b4:	01010113          	addi	sp,sp,16
    800016b8:	00008067          	ret

00000000800016bc <handleEcall>:


int time=0;

void handleEcall(uint64 a0, uint64 a1, uint64 a2, uint64 a3, uint64 a4) {
    800016bc:	f7010113          	addi	sp,sp,-144
    800016c0:	08113423          	sd	ra,136(sp)
    800016c4:	08813023          	sd	s0,128(sp)
    800016c8:	06913c23          	sd	s1,120(sp)
    800016cc:	07213823          	sd	s2,112(sp)
    800016d0:	09010413          	addi	s0,sp,144
    800016d4:	00060913          	mv	s2,a2
    800016d8:	00068613          	mv	a2,a3
    __asm__ volatile ("csrr %[scause], scause" : [scause] "=r"(scause));
    800016dc:	142027f3          	csrr	a5,scause
    800016e0:	faf43023          	sd	a5,-96(s0)
    return scause;
    800016e4:	fa043783          	ld	a5,-96(s0)
    __asm__ volatile ("mv %[a2], a2" : [a2] "=r"(a2));
    __asm__ volatile ("mv %[a3], a3" : [a3] "=r"(a3));
    __asm__ volatile ("mv %[a4], a4" : [a4] "=r"(a4));
     */
    uint64 scause = r_scause();
    if (scause == INTR_USER_ECALL || scause == INTR_KERNEL_ECALL) {
    800016e8:	ff878793          	addi	a5,a5,-8
    800016ec:	00100693          	li	a3,1
    800016f0:	00f6fe63          	bgeu	a3,a5,8000170c <handleEcall+0x50>
            }


        }
    }
}
    800016f4:	08813083          	ld	ra,136(sp)
    800016f8:	08013403          	ld	s0,128(sp)
    800016fc:	07813483          	ld	s1,120(sp)
    80001700:	07013903          	ld	s2,112(sp)
    80001704:	09010113          	addi	sp,sp,144
    80001708:	00008067          	ret
    8000170c:	00058493          	mv	s1,a1
    __asm__ volatile ("csrr %[sepc], sepc" : [sepc] "=r"(sepc));
    80001710:	141027f3          	csrr	a5,sepc
    80001714:	faf43423          	sd	a5,-88(s0)
    return sepc;
    80001718:	fa843783          	ld	a5,-88(s0)
        uint64 sepc = r_sepc() + 4;
    8000171c:	00478793          	addi	a5,a5,4
    __asm__ volatile ("csrw sepc, %[sepc]" : : [sepc] "r"(sepc));
    80001720:	14179073          	csrw	sepc,a5
        switch (syscall_num) {
    80001724:	03100793          	li	a5,49
    80001728:	fca7e6e3          	bltu	a5,a0,800016f4 <handleEcall+0x38>
    8000172c:	00251513          	slli	a0,a0,0x2
    80001730:	00004697          	auipc	a3,0x4
    80001734:	8f068693          	addi	a3,a3,-1808 # 80005020 <CONSOLE_STATUS+0x8>
    80001738:	00d50533          	add	a0,a0,a3
    8000173c:	00052783          	lw	a5,0(a0)
    80001740:	00d787b3          	add	a5,a5,a3
    80001744:	00078067          	jr	a5
                retval = (uint64) kern_mem_alloc(size);
    80001748:	0005851b          	sext.w	a0,a1
    8000174c:	00000097          	auipc	ra,0x0
    80001750:	d20080e7          	jalr	-736(ra) # 8000146c <kern_mem_alloc>
    __asm__ volatile ("mv a0, %[value]" :: [value] "r"(value));
    80001754:	00050513          	mv	a0,a0
}
    80001758:	f9dff06f          	j	800016f4 <handleEcall+0x38>
                retval = (uint64) kern_mem_free((void *) addr);
    8000175c:	00058513          	mv	a0,a1
    80001760:	00000097          	auipc	ra,0x0
    80001764:	dd0080e7          	jalr	-560(ra) # 80001530 <kern_mem_free>
    __asm__ volatile ("mv a0, %[value]" :: [value] "r"(value));
    80001768:	00050513          	mv	a0,a0
}
    8000176c:	f89ff06f          	j	800016f4 <handleEcall+0x38>
                retval = (uint64) kern_thread_create((thread_t *) handle,
    80001770:	00070693          	mv	a3,a4
    80001774:	00090593          	mv	a1,s2
    80001778:	00048513          	mv	a0,s1
    8000177c:	00000097          	auipc	ra,0x0
    80001780:	6d8080e7          	jalr	1752(ra) # 80001e54 <kern_thread_create>
                (*(thread_t *) handle)->endTime = SYSTEM_TIME + DEFAULT_TIME_SLICE;
    80001784:	0004b703          	ld	a4,0(s1)
    80001788:	00004797          	auipc	a5,0x4
    8000178c:	ee07b783          	ld	a5,-288(a5) # 80005668 <SYSTEM_TIME>
    80001790:	00278793          	addi	a5,a5,2
    80001794:	02f73c23          	sd	a5,56(a4)
    __asm__ volatile ("mv a0, %[value]" :: [value] "r"(value));
    80001798:	00050513          	mv	a0,a0
}
    8000179c:	f59ff06f          	j	800016f4 <handleEcall+0x38>
    __asm__ volatile ("csrr %[sstatus], sstatus" : [sstatus] "=r"(sstatus));
    800017a0:	100027f3          	csrr	a5,sstatus
    800017a4:	faf43c23          	sd	a5,-72(s0)
    return sstatus;
    800017a8:	fb843783          	ld	a5,-72(s0)
                uint64 volatile sstatus = r_sstatus();
    800017ac:	f6f43823          	sd	a5,-144(s0)
    __asm__ volatile ("csrr %[sepc], sepc" : [sepc] "=r"(sepc));
    800017b0:	141027f3          	csrr	a5,sepc
    800017b4:	faf43823          	sd	a5,-80(s0)
    return sepc;
    800017b8:	fb043783          	ld	a5,-80(s0)
                uint64 volatile v_sepc = r_sepc();
    800017bc:	f6f43c23          	sd	a5,-136(s0)
                kern_thread_dispatch();
    800017c0:	00000097          	auipc	ra,0x0
    800017c4:	528080e7          	jalr	1320(ra) # 80001ce8 <kern_thread_dispatch>
                w_sstatus(sstatus);
    800017c8:	f7043783          	ld	a5,-144(s0)
    __asm__ volatile ("csrw sstatus, %[sstatus]" : : [sstatus] "r"(sstatus));
    800017cc:	10079073          	csrw	sstatus,a5
                w_sepc(v_sepc);
    800017d0:	f7843783          	ld	a5,-136(s0)
    __asm__ volatile ("csrw sepc, %[sepc]" : : [sepc] "r"(sepc));
    800017d4:	14179073          	csrw	sepc,a5
                running->endTime = time + running->timeslice;
    800017d8:	00004717          	auipc	a4,0x4
    800017dc:	e9873703          	ld	a4,-360(a4) # 80005670 <running>
    800017e0:	03073683          	ld	a3,48(a4)
    800017e4:	00004797          	auipc	a5,0x4
    800017e8:	e7c7a783          	lw	a5,-388(a5) # 80005660 <time>
    800017ec:	00d787b3          	add	a5,a5,a3
    800017f0:	02f73c23          	sd	a5,56(a4)
                break;
    800017f4:	f01ff06f          	j	800016f4 <handleEcall+0x38>
    __asm__ volatile ("csrr %[sstatus], sstatus" : [sstatus] "=r"(sstatus));
    800017f8:	100027f3          	csrr	a5,sstatus
    800017fc:	fcf43423          	sd	a5,-56(s0)
    return sstatus;
    80001800:	fc843783          	ld	a5,-56(s0)
                uint64 volatile sstatus = r_sstatus();
    80001804:	f8f43023          	sd	a5,-128(s0)
    __asm__ volatile ("csrr %[sepc], sepc" : [sepc] "=r"(sepc));
    80001808:	141027f3          	csrr	a5,sepc
    8000180c:	fcf43023          	sd	a5,-64(s0)
    return sepc;
    80001810:	fc043783          	ld	a5,-64(s0)
                uint64 volatile v_sepc = r_sepc();
    80001814:	f8f43423          	sd	a5,-120(s0)
                kern_thread_join(handle);
    80001818:	00058513          	mv	a0,a1
    8000181c:	00000097          	auipc	ra,0x0
    80001820:	71c080e7          	jalr	1820(ra) # 80001f38 <kern_thread_join>
                w_sstatus(sstatus);
    80001824:	f8043783          	ld	a5,-128(s0)
    __asm__ volatile ("csrw sstatus, %[sstatus]" : : [sstatus] "r"(sstatus));
    80001828:	10079073          	csrw	sstatus,a5
                w_sepc(v_sepc);
    8000182c:	f8843783          	ld	a5,-120(s0)
    __asm__ volatile ("csrw sepc, %[sepc]" : : [sepc] "r"(sepc));
    80001830:	14179073          	csrw	sepc,a5
                running->endTime = time + running->timeslice;
    80001834:	00004717          	auipc	a4,0x4
    80001838:	e3c73703          	ld	a4,-452(a4) # 80005670 <running>
    8000183c:	03073683          	ld	a3,48(a4)
    80001840:	00004797          	auipc	a5,0x4
    80001844:	e207a783          	lw	a5,-480(a5) # 80005660 <time>
    80001848:	00d787b3          	add	a5,a5,a3
    8000184c:	02f73c23          	sd	a5,56(a4)
                break;
    80001850:	ea5ff06f          	j	800016f4 <handleEcall+0x38>
                kern_thread_end_running();
    80001854:	00000097          	auipc	ra,0x0
    80001858:	510080e7          	jalr	1296(ra) # 80001d64 <kern_thread_end_running>
                retval = kern_sem_open(handle, init);
    8000185c:	0009059b          	sext.w	a1,s2
    80001860:	00048513          	mv	a0,s1
    80001864:	00000097          	auipc	ra,0x0
    80001868:	a48080e7          	jalr	-1464(ra) # 800012ac <kern_sem_open>
    __asm__ volatile ("mv a0, %[value]" :: [value] "r"(value));
    8000186c:	00050513          	mv	a0,a0
}
    80001870:	e85ff06f          	j	800016f4 <handleEcall+0x38>
                retval = kern_sem_close(handle);
    80001874:	00058513          	mv	a0,a1
    80001878:	00000097          	auipc	ra,0x0
    8000187c:	aa4080e7          	jalr	-1372(ra) # 8000131c <kern_sem_close>
    __asm__ volatile ("mv a0, %[value]" :: [value] "r"(value));
    80001880:	00050513          	mv	a0,a0
}
    80001884:	e71ff06f          	j	800016f4 <handleEcall+0x38>
                kern_sem_signal(handle);
    80001888:	00058513          	mv	a0,a1
    8000188c:	00000097          	auipc	ra,0x0
    80001890:	ae4080e7          	jalr	-1308(ra) # 80001370 <kern_sem_signal>
    __asm__ volatile ("mv a0, %[value]" :: [value] "r"(value));
    80001894:	00000793          	li	a5,0
    80001898:	00078513          	mv	a0,a5
}
    8000189c:	e59ff06f          	j	800016f4 <handleEcall+0x38>
                retval = kern_sem_wait(handle);
    800018a0:	00058513          	mv	a0,a1
    800018a4:	00000097          	auipc	ra,0x0
    800018a8:	b14080e7          	jalr	-1260(ra) # 800013b8 <kern_sem_wait>
                if (retval == 1) { //nije promenjen kontekst
    800018ac:	00100793          	li	a5,1
    800018b0:	02f50463          	beq	a0,a5,800018d8 <handleEcall+0x21c>
                    running->endTime = time + running->timeslice;
    800018b4:	00004717          	auipc	a4,0x4
    800018b8:	dbc73703          	ld	a4,-580(a4) # 80005670 <running>
    800018bc:	03073683          	ld	a3,48(a4)
    800018c0:	00004797          	auipc	a5,0x4
    800018c4:	da07a783          	lw	a5,-608(a5) # 80005660 <time>
    800018c8:	00d787b3          	add	a5,a5,a3
    800018cc:	02f73c23          	sd	a5,56(a4)
    __asm__ volatile ("mv a0, %[value]" :: [value] "r"(value));
    800018d0:	00050513          	mv	a0,a0
}
    800018d4:	e21ff06f          	j	800016f4 <handleEcall+0x38>
                    retval = 0;
    800018d8:	00000513          	li	a0,0
    800018dc:	ff5ff06f          	j	800018d0 <handleEcall+0x214>
                running->status = SLEEPING;
    800018e0:	00004917          	auipc	s2,0x4
    800018e4:	d9090913          	addi	s2,s2,-624 # 80005670 <running>
    800018e8:	00093783          	ld	a5,0(s2)
    800018ec:	00500713          	li	a4,5
    800018f0:	04e7a823          	sw	a4,80(a5)
                running->endTime = SYSTEM_TIME + period;
    800018f4:	00004717          	auipc	a4,0x4
    800018f8:	d7473703          	ld	a4,-652(a4) # 80005668 <SYSTEM_TIME>
    800018fc:	00e584b3          	add	s1,a1,a4
    80001900:	0297bc23          	sd	s1,56(a5)
    __asm__ volatile ("csrr %[sstatus], sstatus" : [sstatus] "=r"(sstatus));
    80001904:	100027f3          	csrr	a5,sstatus
    80001908:	fcf43c23          	sd	a5,-40(s0)
    return sstatus;
    8000190c:	fd843783          	ld	a5,-40(s0)
                uint64 volatile sstatus = r_sstatus();
    80001910:	f8f43823          	sd	a5,-112(s0)
    __asm__ volatile ("csrr %[sepc], sepc" : [sepc] "=r"(sepc));
    80001914:	141027f3          	csrr	a5,sepc
    80001918:	fcf43823          	sd	a5,-48(s0)
    return sepc;
    8000191c:	fd043783          	ld	a5,-48(s0)
                uint64 volatile v_sepc = r_sepc();
    80001920:	f8f43c23          	sd	a5,-104(s0)
                kern_thread_dispatch();
    80001924:	00000097          	auipc	ra,0x0
    80001928:	3c4080e7          	jalr	964(ra) # 80001ce8 <kern_thread_dispatch>
                w_sstatus(sstatus);
    8000192c:	f9043783          	ld	a5,-112(s0)
    __asm__ volatile ("csrw sstatus, %[sstatus]" : : [sstatus] "r"(sstatus));
    80001930:	10079073          	csrw	sstatus,a5
                w_sepc(v_sepc);
    80001934:	f9843783          	ld	a5,-104(s0)
    __asm__ volatile ("csrw sepc, %[sepc]" : : [sepc] "r"(sepc));
    80001938:	14179073          	csrw	sepc,a5
                running->endTime = time + running->timeslice;
    8000193c:	00093703          	ld	a4,0(s2)
    80001940:	03073683          	ld	a3,48(a4)
    80001944:	00004797          	auipc	a5,0x4
    80001948:	d1c7a783          	lw	a5,-740(a5) # 80005660 <time>
    8000194c:	00d787b3          	add	a5,a5,a3
    80001950:	02f73c23          	sd	a5,56(a4)
}
    80001954:	da1ff06f          	j	800016f4 <handleEcall+0x38>

0000000080001958 <handleInterrupt>:

void handleInterrupt()
{
    80001958:	fb010113          	addi	sp,sp,-80
    8000195c:	04113423          	sd	ra,72(sp)
    80001960:	04813023          	sd	s0,64(sp)
    80001964:	02913c23          	sd	s1,56(sp)
    80001968:	05010413          	addi	s0,sp,80
    __asm__ volatile ("csrr %[scause], scause" : [scause] "=r"(scause));
    8000196c:	142027f3          	csrr	a5,scause
    80001970:	fcf43423          	sd	a5,-56(s0)
    return scause;
    80001974:	fc843703          	ld	a4,-56(s0)
    uint64 scause = r_scause();
    if (scause == INTR_TIMER)
    80001978:	fff00793          	li	a5,-1
    8000197c:	03f79793          	slli	a5,a5,0x3f
    80001980:	00178793          	addi	a5,a5,1
    80001984:	02f70463          	beq	a4,a5,800019ac <handleInterrupt+0x54>
            //__putc('0'+running->id);
            //__putc(')');
        }

    }
    else if (scause == INTR_CONSOLE)
    80001988:	fff00793          	li	a5,-1
    8000198c:	03f79793          	slli	a5,a5,0x3f
    80001990:	00978793          	addi	a5,a5,9
    80001994:	0af70463          	beq	a4,a5,80001a3c <handleInterrupt+0xe4>

    }
    else if(scause==INTR_ILLEGAL_ADDR_WR){

    }
}
    80001998:	04813083          	ld	ra,72(sp)
    8000199c:	04013403          	ld	s0,64(sp)
    800019a0:	03813483          	ld	s1,56(sp)
    800019a4:	05010113          	addi	sp,sp,80
    800019a8:	00008067          	ret
        SYSTEM_TIME++;
    800019ac:	00004497          	auipc	s1,0x4
    800019b0:	cbc48493          	addi	s1,s1,-836 # 80005668 <SYSTEM_TIME>
    800019b4:	0004b503          	ld	a0,0(s1)
    800019b8:	00150513          	addi	a0,a0,1
    800019bc:	00a4b023          	sd	a0,0(s1)
    __asm__ volatile ("csrc sip, %[mask]" : : [mask] "r"(mask));
    800019c0:	00200793          	li	a5,2
    800019c4:	1447b073          	csrc	sip,a5
        kern_thread_wakeup(SYSTEM_TIME);
    800019c8:	00000097          	auipc	ra,0x0
    800019cc:	5bc080e7          	jalr	1468(ra) # 80001f84 <kern_thread_wakeup>
        if(SYSTEM_TIME>=running->endTime){
    800019d0:	00004797          	auipc	a5,0x4
    800019d4:	ca07b783          	ld	a5,-864(a5) # 80005670 <running>
    800019d8:	0387b703          	ld	a4,56(a5)
    800019dc:	0004b783          	ld	a5,0(s1)
    800019e0:	fae7ece3          	bltu	a5,a4,80001998 <handleInterrupt+0x40>
    __asm__ volatile ("csrr %[sstatus], sstatus" : [sstatus] "=r"(sstatus));
    800019e4:	100027f3          	csrr	a5,sstatus
    800019e8:	fcf43c23          	sd	a5,-40(s0)
    return sstatus;
    800019ec:	fd843783          	ld	a5,-40(s0)
            uint64 volatile sstatus = r_sstatus();
    800019f0:	faf43c23          	sd	a5,-72(s0)
    __asm__ volatile ("csrr %[sepc], sepc" : [sepc] "=r"(sepc));
    800019f4:	141027f3          	csrr	a5,sepc
    800019f8:	fcf43823          	sd	a5,-48(s0)
    return sepc;
    800019fc:	fd043783          	ld	a5,-48(s0)
            uint64 volatile v_sepc = r_sepc();
    80001a00:	fcf43023          	sd	a5,-64(s0)
            kern_thread_dispatch();
    80001a04:	00000097          	auipc	ra,0x0
    80001a08:	2e4080e7          	jalr	740(ra) # 80001ce8 <kern_thread_dispatch>
            w_sstatus(sstatus);
    80001a0c:	fb843783          	ld	a5,-72(s0)
    __asm__ volatile ("csrw sstatus, %[sstatus]" : : [sstatus] "r"(sstatus));
    80001a10:	10079073          	csrw	sstatus,a5
            w_sepc(v_sepc);
    80001a14:	fc043783          	ld	a5,-64(s0)
    __asm__ volatile ("csrw sepc, %[sepc]" : : [sepc] "r"(sepc));
    80001a18:	14179073          	csrw	sepc,a5
            running->endTime=SYSTEM_TIME+running->timeslice;
    80001a1c:	00004717          	auipc	a4,0x4
    80001a20:	c5473703          	ld	a4,-940(a4) # 80005670 <running>
    80001a24:	03073783          	ld	a5,48(a4)
    80001a28:	00004697          	auipc	a3,0x4
    80001a2c:	c406b683          	ld	a3,-960(a3) # 80005668 <SYSTEM_TIME>
    80001a30:	00d787b3          	add	a5,a5,a3
    80001a34:	02f73c23          	sd	a5,56(a4)
    80001a38:	f61ff06f          	j	80001998 <handleInterrupt+0x40>
        int i = plic_claim();
    80001a3c:	00001097          	auipc	ra,0x1
    80001a40:	778080e7          	jalr	1912(ra) # 800031b4 <plic_claim>
        if(i==10){
    80001a44:	00a00793          	li	a5,10
    80001a48:	00f50863          	beq	a0,a5,80001a58 <handleInterrupt+0x100>
        console_handler();
    80001a4c:	00003097          	auipc	ra,0x3
    80001a50:	044080e7          	jalr	68(ra) # 80004a90 <console_handler>
}
    80001a54:	f45ff06f          	j	80001998 <handleInterrupt+0x40>
            plic_complete(i);
    80001a58:	00001097          	auipc	ra,0x1
    80001a5c:	794080e7          	jalr	1940(ra) # 800031ec <plic_complete>
            i--;
    80001a60:	fedff06f          	j	80001a4c <handleInterrupt+0xf4>

0000000080001a64 <kern_thread_init>:
struct thread_s threads[MAX_THREADS];
static int id;
struct thread_s* running;

void kern_thread_init()
{
    80001a64:	ff010113          	addi	sp,sp,-16
    80001a68:	00813423          	sd	s0,8(sp)
    80001a6c:	01010413          	addi	s0,sp,16
    id=0;
    80001a70:	00004797          	auipc	a5,0x4
    80001a74:	c007a423          	sw	zero,-1016(a5) # 80005678 <id>
    for (int i=0;i<MAX_THREADS;i++){
    80001a78:	00000793          	li	a5,0
    80001a7c:	0240006f          	j	80001aa0 <kern_thread_init+0x3c>
        threads[i].status=UNUSED;
    80001a80:	00179713          	slli	a4,a5,0x1
    80001a84:	00f70733          	add	a4,a4,a5
    80001a88:	00571693          	slli	a3,a4,0x5
    80001a8c:	00005717          	auipc	a4,0x5
    80001a90:	c1470713          	addi	a4,a4,-1004 # 800066a0 <threads>
    80001a94:	00d70733          	add	a4,a4,a3
    80001a98:	04072823          	sw	zero,80(a4)
    for (int i=0;i<MAX_THREADS;i++){
    80001a9c:	0017879b          	addiw	a5,a5,1
    80001aa0:	03f00713          	li	a4,63
    80001aa4:	fcf75ee3          	bge	a4,a5,80001a80 <kern_thread_init+0x1c>
    }

    //set threads[0] as main thread
    threads[0].status=RUNNING;
    80001aa8:	00005797          	auipc	a5,0x5
    80001aac:	bf878793          	addi	a5,a5,-1032 # 800066a0 <threads>
    80001ab0:	00100713          	li	a4,1
    80001ab4:	04e7a823          	sw	a4,80(a5)
    threads[0].id=0;
    80001ab8:	0007b823          	sd	zero,16(a5)
    threads[0].timeslice=DEFAULT_TIME_SLICE+2;
    80001abc:	00400713          	li	a4,4
    80001ac0:	02e7b823          	sd	a4,48(a5)
    threads[0].endTime=0;
    80001ac4:	0207bc23          	sd	zero,56(a5)
    running=&threads[0];
    80001ac8:	00004717          	auipc	a4,0x4
    80001acc:	baf73423          	sd	a5,-1112(a4) # 80005670 <running>
}
    80001ad0:	00813403          	ld	s0,8(sp)
    80001ad4:	01010113          	addi	sp,sp,16
    80001ad8:	00008067          	ret

0000000080001adc <kern_scheduler_get>:

thread_t kern_scheduler_get()
{
    80001adc:	ff010113          	addi	sp,sp,-16
    80001ae0:	00813423          	sd	s0,8(sp)
    80001ae4:	01010413          	addi	s0,sp,16
    int num = running-threads;
    80001ae8:	00004517          	auipc	a0,0x4
    80001aec:	b8853503          	ld	a0,-1144(a0) # 80005670 <running>
    80001af0:	00005797          	auipc	a5,0x5
    80001af4:	bb078793          	addi	a5,a5,-1104 # 800066a0 <threads>
    80001af8:	40f507b3          	sub	a5,a0,a5
    80001afc:	4057d793          	srai	a5,a5,0x5
    80001b00:	00003717          	auipc	a4,0x3
    80001b04:	50073703          	ld	a4,1280(a4) # 80005000 <console_handler+0x570>
    80001b08:	02e787bb          	mulw	a5,a5,a4
    for(int i=1;i<=MAX_THREADS;i++){
    80001b0c:	00100693          	li	a3,1
    80001b10:	04000713          	li	a4,64
    80001b14:	06d74c63          	blt	a4,a3,80001b8c <kern_scheduler_get+0xb0>
        num = (num+i)%MAX_THREADS;
    80001b18:	00d787bb          	addw	a5,a5,a3
    80001b1c:	41f7d71b          	sraiw	a4,a5,0x1f
    80001b20:	01a7571b          	srliw	a4,a4,0x1a
    80001b24:	00e787bb          	addw	a5,a5,a4
    80001b28:	03f7f793          	andi	a5,a5,63
    80001b2c:	40e787bb          	subw	a5,a5,a4
        if(threads[num].status==READY){
    80001b30:	00179713          	slli	a4,a5,0x1
    80001b34:	00f70733          	add	a4,a4,a5
    80001b38:	00571613          	slli	a2,a4,0x5
    80001b3c:	00005717          	auipc	a4,0x5
    80001b40:	b6470713          	addi	a4,a4,-1180 # 800066a0 <threads>
    80001b44:	00c70733          	add	a4,a4,a2
    80001b48:	05072603          	lw	a2,80(a4)
    80001b4c:	00200713          	li	a4,2
    80001b50:	00e60663          	beq	a2,a4,80001b5c <kern_scheduler_get+0x80>
    for(int i=1;i<=MAX_THREADS;i++){
    80001b54:	0016869b          	addiw	a3,a3,1
    80001b58:	fb9ff06f          	j	80001b10 <kern_scheduler_get+0x34>
            threads[num].status=RUNNING;
    80001b5c:	00005617          	auipc	a2,0x5
    80001b60:	b4460613          	addi	a2,a2,-1212 # 800066a0 <threads>
    80001b64:	00179713          	slli	a4,a5,0x1
    80001b68:	00f705b3          	add	a1,a4,a5
    80001b6c:	00559693          	slli	a3,a1,0x5
    80001b70:	00d606b3          	add	a3,a2,a3
    80001b74:	00100593          	li	a1,1
    80001b78:	04b6a823          	sw	a1,80(a3)
            return &threads[num];
    80001b7c:	00068513          	mv	a0,a3
    if(running->status==READY || running->status==RUNNING) {
        running->status=RUNNING;
        return running;
    }
    return 0;
}
    80001b80:	00813403          	ld	s0,8(sp)
    80001b84:	01010113          	addi	sp,sp,16
    80001b88:	00008067          	ret
    if(running->status==READY || running->status==RUNNING) {
    80001b8c:	05052783          	lw	a5,80(a0)
    80001b90:	fff7879b          	addiw	a5,a5,-1
    80001b94:	00100713          	li	a4,1
    80001b98:	00f77663          	bgeu	a4,a5,80001ba4 <kern_scheduler_get+0xc8>
    return 0;
    80001b9c:	00000513          	li	a0,0
    80001ba0:	fe1ff06f          	j	80001b80 <kern_scheduler_get+0xa4>
        running->status=RUNNING;
    80001ba4:	00100793          	li	a5,1
    80001ba8:	04f52823          	sw	a5,80(a0)
        return running;
    80001bac:	fd5ff06f          	j	80001b80 <kern_scheduler_get+0xa4>

0000000080001bb0 <kern_thread_yield>:

void kern_thread_yield()
{
    80001bb0:	ff010113          	addi	sp,sp,-16
    80001bb4:	00113423          	sd	ra,8(sp)
    80001bb8:	00813023          	sd	s0,0(sp)
    80001bbc:	01010413          	addi	s0,sp,16
    kern_syscall(THREAD_DISPATCH);
    80001bc0:	01300513          	li	a0,19
    80001bc4:	00000097          	auipc	ra,0x0
    80001bc8:	a8c080e7          	jalr	-1396(ra) # 80001650 <kern_syscall>
}
    80001bcc:	00813083          	ld	ra,8(sp)
    80001bd0:	00013403          	ld	s0,0(sp)
    80001bd4:	01010113          	addi	sp,sp,16
    80001bd8:	00008067          	ret

0000000080001bdc <popSppSpie>:

//samo izlazi iz kernela i vraca se odakle je pozvana
void popSppSpie()
{
    80001bdc:	ff010113          	addi	sp,sp,-16
    80001be0:	00813423          	sd	s0,8(sp)
    80001be4:	01010413          	addi	s0,sp,16
    __asm__ volatile("csrw sepc, ra"); //ovde dodaj izlazak iz privilegovanog moda
    80001be8:	14109073          	csrw	sepc,ra
    __asm__ volatile("csrc sstatus, %[mask]" : : [mask] "r"(1 << 8));
    80001bec:	10000793          	li	a5,256
    80001bf0:	1007b073          	csrc	sstatus,a5
    __asm__ volatile("sret");
    80001bf4:	10200073          	sret
}
    80001bf8:	00813403          	ld	s0,8(sp)
    80001bfc:	01010113          	addi	sp,sp,16
    80001c00:	00008067          	ret

0000000080001c04 <kern_thread_wrapper>:
        contextSwitch(old,running);
    }
}

void kern_thread_wrapper()
{
    80001c04:	fe010113          	addi	sp,sp,-32
    80001c08:	00113c23          	sd	ra,24(sp)
    80001c0c:	00813823          	sd	s0,16(sp)
    80001c10:	00913423          	sd	s1,8(sp)
    80001c14:	02010413          	addi	s0,sp,32
    popSppSpie();
    80001c18:	00000097          	auipc	ra,0x0
    80001c1c:	fc4080e7          	jalr	-60(ra) # 80001bdc <popSppSpie>
    running->body(running->arg);
    80001c20:	00004497          	auipc	s1,0x4
    80001c24:	a5048493          	addi	s1,s1,-1456 # 80005670 <running>
    80001c28:	0004b783          	ld	a5,0(s1)
    80001c2c:	0187b703          	ld	a4,24(a5)
    80001c30:	0207b503          	ld	a0,32(a5)
    80001c34:	000700e7          	jalr	a4
    running->status=UNUSED;
    80001c38:	0004b603          	ld	a2,0(s1)
    80001c3c:	04062823          	sw	zero,80(a2)
    running->sem_next=0;
    80001c40:	04063c23          	sd	zero,88(a2)
    running->joined_tid=-1;
    80001c44:	fff00793          	li	a5,-1
    80001c48:	02f63423          	sd	a5,40(a2)
    for(int i=0;i<MAX_THREADS;i++){
    80001c4c:	00000793          	li	a5,0
    80001c50:	0080006f          	j	80001c58 <kern_thread_wrapper+0x54>
    80001c54:	0017879b          	addiw	a5,a5,1
    80001c58:	03f00713          	li	a4,63
    80001c5c:	06f74863          	blt	a4,a5,80001ccc <kern_thread_wrapper+0xc8>
        if(threads[i].status==JOINED && threads[i].joined_tid==running->id) threads[i].status=READY;
    80001c60:	00179713          	slli	a4,a5,0x1
    80001c64:	00f70733          	add	a4,a4,a5
    80001c68:	00571693          	slli	a3,a4,0x5
    80001c6c:	00005717          	auipc	a4,0x5
    80001c70:	a3470713          	addi	a4,a4,-1484 # 800066a0 <threads>
    80001c74:	00d70733          	add	a4,a4,a3
    80001c78:	05072683          	lw	a3,80(a4)
    80001c7c:	00400713          	li	a4,4
    80001c80:	fce69ae3          	bne	a3,a4,80001c54 <kern_thread_wrapper+0x50>
    80001c84:	00179713          	slli	a4,a5,0x1
    80001c88:	00f70733          	add	a4,a4,a5
    80001c8c:	00571693          	slli	a3,a4,0x5
    80001c90:	00005717          	auipc	a4,0x5
    80001c94:	a1070713          	addi	a4,a4,-1520 # 800066a0 <threads>
    80001c98:	00d70733          	add	a4,a4,a3
    80001c9c:	02873683          	ld	a3,40(a4)
    80001ca0:	01063703          	ld	a4,16(a2)
    80001ca4:	fae698e3          	bne	a3,a4,80001c54 <kern_thread_wrapper+0x50>
    80001ca8:	00179713          	slli	a4,a5,0x1
    80001cac:	00f70733          	add	a4,a4,a5
    80001cb0:	00571693          	slli	a3,a4,0x5
    80001cb4:	00005717          	auipc	a4,0x5
    80001cb8:	9ec70713          	addi	a4,a4,-1556 # 800066a0 <threads>
    80001cbc:	00d70733          	add	a4,a4,a3
    80001cc0:	00200693          	li	a3,2
    80001cc4:	04d72823          	sw	a3,80(a4)
    80001cc8:	f8dff06f          	j	80001c54 <kern_thread_wrapper+0x50>
    }

    thread_exit();
    80001ccc:	00000097          	auipc	ra,0x0
    80001cd0:	478080e7          	jalr	1144(ra) # 80002144 <thread_exit>
}
    80001cd4:	01813083          	ld	ra,24(sp)
    80001cd8:	01013403          	ld	s0,16(sp)
    80001cdc:	00813483          	ld	s1,8(sp)
    80001ce0:	02010113          	addi	sp,sp,32
    80001ce4:	00008067          	ret

0000000080001ce8 <kern_thread_dispatch>:
{
    80001ce8:	fe010113          	addi	sp,sp,-32
    80001cec:	00113c23          	sd	ra,24(sp)
    80001cf0:	00813823          	sd	s0,16(sp)
    80001cf4:	00913423          	sd	s1,8(sp)
    80001cf8:	01213023          	sd	s2,0(sp)
    80001cfc:	02010413          	addi	s0,sp,32
    thread_t old = running;
    80001d00:	00004917          	auipc	s2,0x4
    80001d04:	97090913          	addi	s2,s2,-1680 # 80005670 <running>
    80001d08:	00093483          	ld	s1,0(s2)
    running=kern_scheduler_get();
    80001d0c:	00000097          	auipc	ra,0x0
    80001d10:	dd0080e7          	jalr	-560(ra) # 80001adc <kern_scheduler_get>
    80001d14:	00a93023          	sd	a0,0(s2)
    if(old!=running){
    80001d18:	02950463          	beq	a0,s1,80001d40 <kern_thread_dispatch+0x58>
    80001d1c:	00050593          	mv	a1,a0
        running->status=RUNNING;
    80001d20:	00100793          	li	a5,1
    80001d24:	04f52823          	sw	a5,80(a0)
        if(old->status==RUNNING) old->status=READY;
    80001d28:	0504a703          	lw	a4,80(s1)
    80001d2c:	00100793          	li	a5,1
    80001d30:	02f70463          	beq	a4,a5,80001d58 <kern_thread_dispatch+0x70>
        contextSwitch(old,running);
    80001d34:	00048513          	mv	a0,s1
    80001d38:	fffff097          	auipc	ra,0xfffff
    80001d3c:	514080e7          	jalr	1300(ra) # 8000124c <contextSwitch>
}
    80001d40:	01813083          	ld	ra,24(sp)
    80001d44:	01013403          	ld	s0,16(sp)
    80001d48:	00813483          	ld	s1,8(sp)
    80001d4c:	00013903          	ld	s2,0(sp)
    80001d50:	02010113          	addi	sp,sp,32
    80001d54:	00008067          	ret
        if(old->status==RUNNING) old->status=READY;
    80001d58:	00200793          	li	a5,2
    80001d5c:	04f4a823          	sw	a5,80(s1)
    80001d60:	fd5ff06f          	j	80001d34 <kern_thread_dispatch+0x4c>

0000000080001d64 <kern_thread_end_running>:
{
    80001d64:	fe010113          	addi	sp,sp,-32
    80001d68:	00113c23          	sd	ra,24(sp)
    80001d6c:	00813823          	sd	s0,16(sp)
    80001d70:	00913423          	sd	s1,8(sp)
    80001d74:	02010413          	addi	s0,sp,32
    thread_t old = running;
    80001d78:	00004497          	auipc	s1,0x4
    80001d7c:	8f84b483          	ld	s1,-1800(s1) # 80005670 <running>
    old->status=UNUSED;
    80001d80:	0404a823          	sw	zero,80(s1)
    for(int i=0;i<MAX_THREADS;i++){
    80001d84:	00000713          	li	a4,0
    80001d88:	0080006f          	j	80001d90 <kern_thread_end_running+0x2c>
    80001d8c:	0017071b          	addiw	a4,a4,1
    80001d90:	03f00793          	li	a5,63
    80001d94:	06e7c863          	blt	a5,a4,80001e04 <kern_thread_end_running+0xa0>
        if(threads[i].status==JOINED && threads[i].joined_tid==old->id) threads[i].status=READY;
    80001d98:	00171793          	slli	a5,a4,0x1
    80001d9c:	00e787b3          	add	a5,a5,a4
    80001da0:	00579793          	slli	a5,a5,0x5
    80001da4:	00005697          	auipc	a3,0x5
    80001da8:	8fc68693          	addi	a3,a3,-1796 # 800066a0 <threads>
    80001dac:	00f687b3          	add	a5,a3,a5
    80001db0:	0507a683          	lw	a3,80(a5)
    80001db4:	00400793          	li	a5,4
    80001db8:	fcf69ae3          	bne	a3,a5,80001d8c <kern_thread_end_running+0x28>
    80001dbc:	00171793          	slli	a5,a4,0x1
    80001dc0:	00e787b3          	add	a5,a5,a4
    80001dc4:	00579793          	slli	a5,a5,0x5
    80001dc8:	00005697          	auipc	a3,0x5
    80001dcc:	8d868693          	addi	a3,a3,-1832 # 800066a0 <threads>
    80001dd0:	00f687b3          	add	a5,a3,a5
    80001dd4:	0287b683          	ld	a3,40(a5)
    80001dd8:	0104b783          	ld	a5,16(s1)
    80001ddc:	faf698e3          	bne	a3,a5,80001d8c <kern_thread_end_running+0x28>
    80001de0:	00171793          	slli	a5,a4,0x1
    80001de4:	00e787b3          	add	a5,a5,a4
    80001de8:	00579793          	slli	a5,a5,0x5
    80001dec:	00005697          	auipc	a3,0x5
    80001df0:	8b468693          	addi	a3,a3,-1868 # 800066a0 <threads>
    80001df4:	00f687b3          	add	a5,a3,a5
    80001df8:	00200693          	li	a3,2
    80001dfc:	04d7a823          	sw	a3,80(a5)
    80001e00:	f8dff06f          	j	80001d8c <kern_thread_end_running+0x28>
    running=kern_scheduler_get();
    80001e04:	00000097          	auipc	ra,0x0
    80001e08:	cd8080e7          	jalr	-808(ra) # 80001adc <kern_scheduler_get>
    80001e0c:	00004797          	auipc	a5,0x4
    80001e10:	86a7b223          	sd	a0,-1948(a5) # 80005670 <running>
    if(old->stack_space!=0) kern_mem_free((void*)old->stack_space);
    80001e14:	0404b503          	ld	a0,64(s1)
    80001e18:	02051863          	bnez	a0,80001e48 <kern_thread_end_running+0xe4>
    if(old!=running){
    80001e1c:	00004597          	auipc	a1,0x4
    80001e20:	8545b583          	ld	a1,-1964(a1) # 80005670 <running>
    80001e24:	00958863          	beq	a1,s1,80001e34 <kern_thread_end_running+0xd0>
        contextSwitch(old,running);
    80001e28:	00048513          	mv	a0,s1
    80001e2c:	fffff097          	auipc	ra,0xfffff
    80001e30:	420080e7          	jalr	1056(ra) # 8000124c <contextSwitch>
}
    80001e34:	01813083          	ld	ra,24(sp)
    80001e38:	01013403          	ld	s0,16(sp)
    80001e3c:	00813483          	ld	s1,8(sp)
    80001e40:	02010113          	addi	sp,sp,32
    80001e44:	00008067          	ret
    if(old->stack_space!=0) kern_mem_free((void*)old->stack_space);
    80001e48:	fffff097          	auipc	ra,0xfffff
    80001e4c:	6e8080e7          	jalr	1768(ra) # 80001530 <kern_mem_free>
    80001e50:	fcdff06f          	j	80001e1c <kern_thread_end_running+0xb8>

0000000080001e54 <kern_thread_create>:

int kern_thread_create(thread_t* handle, void(*start_routine)(void*), void* arg, void* stack_space)
{
    80001e54:	ff010113          	addi	sp,sp,-16
    80001e58:	00813423          	sd	s0,8(sp)
    80001e5c:	01010413          	addi	s0,sp,16
    *handle=0;
    80001e60:	00053023          	sd	zero,0(a0)
    thread_t t=&threads[0]; //dodela da bismo sklonili upozorenje
    for(int i=0;i<MAX_THREADS;i++){
    80001e64:	00000713          	li	a4,0
    80001e68:	03f00793          	li	a5,63
    80001e6c:	0ae7cc63          	blt	a5,a4,80001f24 <kern_thread_create+0xd0>
        if(threads[i].status==UNUSED){
    80001e70:	00171793          	slli	a5,a4,0x1
    80001e74:	00e787b3          	add	a5,a5,a4
    80001e78:	00579793          	slli	a5,a5,0x5
    80001e7c:	00005817          	auipc	a6,0x5
    80001e80:	82480813          	addi	a6,a6,-2012 # 800066a0 <threads>
    80001e84:	00f807b3          	add	a5,a6,a5
    80001e88:	0507a783          	lw	a5,80(a5)
    80001e8c:	00078663          	beqz	a5,80001e98 <kern_thread_create+0x44>
    for(int i=0;i<MAX_THREADS;i++){
    80001e90:	0017071b          	addiw	a4,a4,1
    80001e94:	fd5ff06f          	j	80001e68 <kern_thread_create+0x14>
            *handle=&threads[i];
    80001e98:	00171793          	slli	a5,a4,0x1
    80001e9c:	00e787b3          	add	a5,a5,a4
    80001ea0:	00579793          	slli	a5,a5,0x5
    80001ea4:	010787b3          	add	a5,a5,a6
    80001ea8:	00f53023          	sd	a5,0(a0)
            t=&threads[i];
            break;
        }
    }
    if(*handle==0) return -1;
    80001eac:	00053703          	ld	a4,0(a0)
    80001eb0:	08070063          	beqz	a4,80001f30 <kern_thread_create+0xdc>

    t->id=++id;
    80001eb4:	00003517          	auipc	a0,0x3
    80001eb8:	7c450513          	addi	a0,a0,1988 # 80005678 <id>
    80001ebc:	00052703          	lw	a4,0(a0)
    80001ec0:	0017071b          	addiw	a4,a4,1
    80001ec4:	0007081b          	sext.w	a6,a4
    80001ec8:	00e52023          	sw	a4,0(a0)
    80001ecc:	0107b823          	sd	a6,16(a5)
    t->status=READY;
    80001ed0:	00200713          	li	a4,2
    80001ed4:	04e7a823          	sw	a4,80(a5)
    t->arg=arg;
    80001ed8:	02c7b023          	sd	a2,32(a5)
    t->joined_tid=-1;
    80001edc:	fff00713          	li	a4,-1
    80001ee0:	02e7b423          	sd	a4,40(a5)
    t->timeslice=DEFAULT_TIME_SLICE;
    80001ee4:	00200713          	li	a4,2
    80001ee8:	02e7b823          	sd	a4,48(a5)
    t->body=start_routine;
    80001eec:	00b7bc23          	sd	a1,24(a5)
    t->stack_space = ((uint64)stack_space);
    80001ef0:	04d7b023          	sd	a3,64(a5)
    t->sp = t->stack_space+(DEFAULT_STACK_SIZE);
    80001ef4:	00001737          	lui	a4,0x1
    80001ef8:	00e686b3          	add	a3,a3,a4
    80001efc:	00d7b423          	sd	a3,8(a5)
    t->ra=(uint64) &kern_thread_wrapper;
    80001f00:	00000717          	auipc	a4,0x0
    80001f04:	d0470713          	addi	a4,a4,-764 # 80001c04 <kern_thread_wrapper>
    80001f08:	00e7b023          	sd	a4,0(a5)
    t->sem_next=0;
    80001f0c:	0407bc23          	sd	zero,88(a5)
    t->mailbox=0;
    80001f10:	0407b423          	sd	zero,72(a5)

    return 0;
    80001f14:	00000513          	li	a0,0
}
    80001f18:	00813403          	ld	s0,8(sp)
    80001f1c:	01010113          	addi	sp,sp,16
    80001f20:	00008067          	ret
    thread_t t=&threads[0]; //dodela da bismo sklonili upozorenje
    80001f24:	00004797          	auipc	a5,0x4
    80001f28:	77c78793          	addi	a5,a5,1916 # 800066a0 <threads>
    80001f2c:	f81ff06f          	j	80001eac <kern_thread_create+0x58>
    if(*handle==0) return -1;
    80001f30:	fff00513          	li	a0,-1
    80001f34:	fe5ff06f          	j	80001f18 <kern_thread_create+0xc4>

0000000080001f38 <kern_thread_join>:

void kern_thread_join(thread_t handle)
{
    if(handle->status==UNUSED) return;
    80001f38:	05052783          	lw	a5,80(a0)
    80001f3c:	00079463          	bnez	a5,80001f44 <kern_thread_join+0xc>
    80001f40:	00008067          	ret
{
    80001f44:	ff010113          	addi	sp,sp,-16
    80001f48:	00113423          	sd	ra,8(sp)
    80001f4c:	00813023          	sd	s0,0(sp)
    80001f50:	01010413          	addi	s0,sp,16
    running->joined_tid=handle->id;
    80001f54:	00003797          	auipc	a5,0x3
    80001f58:	71c7b783          	ld	a5,1820(a5) # 80005670 <running>
    80001f5c:	01053703          	ld	a4,16(a0)
    80001f60:	02e7b423          	sd	a4,40(a5)
    running->status=JOINED;
    80001f64:	00400713          	li	a4,4
    80001f68:	04e7a823          	sw	a4,80(a5)
    kern_thread_dispatch();
    80001f6c:	00000097          	auipc	ra,0x0
    80001f70:	d7c080e7          	jalr	-644(ra) # 80001ce8 <kern_thread_dispatch>
}
    80001f74:	00813083          	ld	ra,8(sp)
    80001f78:	00013403          	ld	s0,0(sp)
    80001f7c:	01010113          	addi	sp,sp,16
    80001f80:	00008067          	ret

0000000080001f84 <kern_thread_wakeup>:

void kern_thread_wakeup(uint64 system_time)
{
    80001f84:	ff010113          	addi	sp,sp,-16
    80001f88:	00813423          	sd	s0,8(sp)
    80001f8c:	01010413          	addi	s0,sp,16
    for(int i=0;i<MAX_THREADS;i++){
    80001f90:	00000793          	li	a5,0
    80001f94:	0080006f          	j	80001f9c <kern_thread_wakeup+0x18>
    80001f98:	0017879b          	addiw	a5,a5,1
    80001f9c:	03f00713          	li	a4,63
    80001fa0:	06f74263          	blt	a4,a5,80002004 <kern_thread_wakeup+0x80>
        if(threads[i].status==SLEEPING && threads[i].endTime<system_time){
    80001fa4:	00179713          	slli	a4,a5,0x1
    80001fa8:	00f70733          	add	a4,a4,a5
    80001fac:	00571713          	slli	a4,a4,0x5
    80001fb0:	00004697          	auipc	a3,0x4
    80001fb4:	6f068693          	addi	a3,a3,1776 # 800066a0 <threads>
    80001fb8:	00e68733          	add	a4,a3,a4
    80001fbc:	05072683          	lw	a3,80(a4)
    80001fc0:	00500713          	li	a4,5
    80001fc4:	fce69ae3          	bne	a3,a4,80001f98 <kern_thread_wakeup+0x14>
    80001fc8:	00179713          	slli	a4,a5,0x1
    80001fcc:	00f70733          	add	a4,a4,a5
    80001fd0:	00571713          	slli	a4,a4,0x5
    80001fd4:	00004697          	auipc	a3,0x4
    80001fd8:	6cc68693          	addi	a3,a3,1740 # 800066a0 <threads>
    80001fdc:	00e68733          	add	a4,a3,a4
    80001fe0:	03873703          	ld	a4,56(a4)
    80001fe4:	faa77ae3          	bgeu	a4,a0,80001f98 <kern_thread_wakeup+0x14>
            threads[i].status=READY;
    80001fe8:	00179713          	slli	a4,a5,0x1
    80001fec:	00f70733          	add	a4,a4,a5
    80001ff0:	00571713          	slli	a4,a4,0x5
    80001ff4:	00e68733          	add	a4,a3,a4
    80001ff8:	00200693          	li	a3,2
    80001ffc:	04d72823          	sw	a3,80(a4)
    80002000:	f99ff06f          	j	80001f98 <kern_thread_wakeup+0x14>
        }
    }
}
    80002004:	00813403          	ld	s0,8(sp)
    80002008:	01010113          	addi	sp,sp,16
    8000200c:	00008067          	ret

0000000080002010 <mem_alloc>:
#include "../h/kern_interrupts.h"

#include <stdarg.h>


void* mem_alloc (size_t size){
    80002010:	fe010113          	addi	sp,sp,-32
    80002014:	00113c23          	sd	ra,24(sp)
    80002018:	00813823          	sd	s0,16(sp)
    8000201c:	02010413          	addi	s0,sp,32
    uint64 blocks = (size+MEM_BLOCK_SIZE-1)/MEM_BLOCK_SIZE;
    80002020:	03f50593          	addi	a1,a0,63
    kern_syscall(MEM_ALLOC, blocks);
    80002024:	0065d593          	srli	a1,a1,0x6
    80002028:	00100513          	li	a0,1
    8000202c:	fffff097          	auipc	ra,0xfffff
    80002030:	624080e7          	jalr	1572(ra) # 80001650 <kern_syscall>
    __asm__ volatile ("mv %[a0], a0" : [a0] "=r"(a0));
    80002034:	00050793          	mv	a5,a0
    80002038:	fef43423          	sd	a5,-24(s0)
    return a0;
    8000203c:	fe843503          	ld	a0,-24(s0)
    uint64 newBlockAddr = r_a0();
    return (void *) newBlockAddr;
}
    80002040:	01813083          	ld	ra,24(sp)
    80002044:	01013403          	ld	s0,16(sp)
    80002048:	02010113          	addi	sp,sp,32
    8000204c:	00008067          	ret

0000000080002050 <mem_free>:

int mem_free (void* addr){
    80002050:	fe010113          	addi	sp,sp,-32
    80002054:	00113c23          	sd	ra,24(sp)
    80002058:	00813823          	sd	s0,16(sp)
    8000205c:	02010413          	addi	s0,sp,32
    80002060:	00050593          	mv	a1,a0
    kern_syscall(MEM_FREE,addr);
    80002064:	00200513          	li	a0,2
    80002068:	fffff097          	auipc	ra,0xfffff
    8000206c:	5e8080e7          	jalr	1512(ra) # 80001650 <kern_syscall>
    __asm__ volatile ("mv %[a0], a0" : [a0] "=r"(a0));
    80002070:	00050793          	mv	a5,a0
    80002074:	fef43423          	sd	a5,-24(s0)
    return a0;
    80002078:	fe843503          	ld	a0,-24(s0)
    int res = (int) r_a0();
    return res;
}
    8000207c:	0005051b          	sext.w	a0,a0
    80002080:	01813083          	ld	ra,24(sp)
    80002084:	01013403          	ld	s0,16(sp)
    80002088:	02010113          	addi	sp,sp,32
    8000208c:	00008067          	ret

0000000080002090 <thread_create>:

struct thread_s;
typedef struct thread_s* thread_t;

int thread_create (thread_t* handle, void(*start_routine)(void*), void* arg)
{
    80002090:	fc010113          	addi	sp,sp,-64
    80002094:	02113c23          	sd	ra,56(sp)
    80002098:	02813823          	sd	s0,48(sp)
    8000209c:	02913423          	sd	s1,40(sp)
    800020a0:	03213023          	sd	s2,32(sp)
    800020a4:	01313c23          	sd	s3,24(sp)
    800020a8:	04010413          	addi	s0,sp,64
    800020ac:	00050493          	mv	s1,a0
    800020b0:	00058913          	mv	s2,a1
    800020b4:	00060993          	mv	s3,a2
    void * stack = mem_alloc(DEFAULT_STACK_SIZE);
    800020b8:	00001537          	lui	a0,0x1
    800020bc:	00000097          	auipc	ra,0x0
    800020c0:	f54080e7          	jalr	-172(ra) # 80002010 <mem_alloc>
    if(stack==0) return -1;
    800020c4:	04050663          	beqz	a0,80002110 <thread_create+0x80>
    800020c8:	00050713          	mv	a4,a0
    kern_syscall(THREAD_CREATE,handle,start_routine,arg,stack);
    800020cc:	00098693          	mv	a3,s3
    800020d0:	00090613          	mv	a2,s2
    800020d4:	00048593          	mv	a1,s1
    800020d8:	01100513          	li	a0,17
    800020dc:	fffff097          	auipc	ra,0xfffff
    800020e0:	574080e7          	jalr	1396(ra) # 80001650 <kern_syscall>
    __asm__ volatile ("mv %[a0], a0" : [a0] "=r"(a0));
    800020e4:	00050793          	mv	a5,a0
    800020e8:	fcf43423          	sd	a5,-56(s0)
    return a0;
    800020ec:	fc843503          	ld	a0,-56(s0)
    int res = r_a0();
    800020f0:	0005051b          	sext.w	a0,a0
    return res;
}
    800020f4:	03813083          	ld	ra,56(sp)
    800020f8:	03013403          	ld	s0,48(sp)
    800020fc:	02813483          	ld	s1,40(sp)
    80002100:	02013903          	ld	s2,32(sp)
    80002104:	01813983          	ld	s3,24(sp)
    80002108:	04010113          	addi	sp,sp,64
    8000210c:	00008067          	ret
    if(stack==0) return -1;
    80002110:	fff00513          	li	a0,-1
    80002114:	fe1ff06f          	j	800020f4 <thread_create+0x64>

0000000080002118 <thread_dispatch>:

void thread_dispatch(){
    80002118:	ff010113          	addi	sp,sp,-16
    8000211c:	00113423          	sd	ra,8(sp)
    80002120:	00813023          	sd	s0,0(sp)
    80002124:	01010413          	addi	s0,sp,16
    kern_syscall(THREAD_DISPATCH);
    80002128:	01300513          	li	a0,19
    8000212c:	fffff097          	auipc	ra,0xfffff
    80002130:	524080e7          	jalr	1316(ra) # 80001650 <kern_syscall>
}
    80002134:	00813083          	ld	ra,8(sp)
    80002138:	00013403          	ld	s0,0(sp)
    8000213c:	01010113          	addi	sp,sp,16
    80002140:	00008067          	ret

0000000080002144 <thread_exit>:

int thread_exit ()
{
    80002144:	fe010113          	addi	sp,sp,-32
    80002148:	00113c23          	sd	ra,24(sp)
    8000214c:	00813823          	sd	s0,16(sp)
    80002150:	00913423          	sd	s1,8(sp)
    80002154:	02010413          	addi	s0,sp,32
    void* stack = (void*)running->stack_space;
    80002158:	00003797          	auipc	a5,0x3
    8000215c:	5187b783          	ld	a5,1304(a5) # 80005670 <running>
    80002160:	0407b483          	ld	s1,64(a5)
    kern_syscall(THREAD_EXIT);
    80002164:	01200513          	li	a0,18
    80002168:	fffff097          	auipc	ra,0xfffff
    8000216c:	4e8080e7          	jalr	1256(ra) # 80001650 <kern_syscall>
    kern_syscall(MEM_FREE,stack);
    80002170:	00048593          	mv	a1,s1
    80002174:	00200513          	li	a0,2
    80002178:	fffff097          	auipc	ra,0xfffff
    8000217c:	4d8080e7          	jalr	1240(ra) # 80001650 <kern_syscall>
    return 0;
}
    80002180:	00000513          	li	a0,0
    80002184:	01813083          	ld	ra,24(sp)
    80002188:	01013403          	ld	s0,16(sp)
    8000218c:	00813483          	ld	s1,8(sp)
    80002190:	02010113          	addi	sp,sp,32
    80002194:	00008067          	ret

0000000080002198 <thread_join>:

void thread_join(thread_t handle)
{
    80002198:	ff010113          	addi	sp,sp,-16
    8000219c:	00113423          	sd	ra,8(sp)
    800021a0:	00813023          	sd	s0,0(sp)
    800021a4:	01010413          	addi	s0,sp,16
    800021a8:	00050593          	mv	a1,a0
    kern_syscall(THREAD_JOIN,handle);
    800021ac:	01400513          	li	a0,20
    800021b0:	fffff097          	auipc	ra,0xfffff
    800021b4:	4a0080e7          	jalr	1184(ra) # 80001650 <kern_syscall>
}
    800021b8:	00813083          	ld	ra,8(sp)
    800021bc:	00013403          	ld	s0,0(sp)
    800021c0:	01010113          	addi	sp,sp,16
    800021c4:	00008067          	ret

00000000800021c8 <sem_open>:

int sem_open (sem_t* handle, unsigned init)
{
    800021c8:	fe010113          	addi	sp,sp,-32
    800021cc:	00113c23          	sd	ra,24(sp)
    800021d0:	00813823          	sd	s0,16(sp)
    800021d4:	02010413          	addi	s0,sp,32
    800021d8:	00058613          	mv	a2,a1
    kern_syscall(SEM_OPEN,handle,init);
    800021dc:	00050593          	mv	a1,a0
    800021e0:	02100513          	li	a0,33
    800021e4:	fffff097          	auipc	ra,0xfffff
    800021e8:	46c080e7          	jalr	1132(ra) # 80001650 <kern_syscall>
    __asm__ volatile ("mv %[a0], a0" : [a0] "=r"(a0));
    800021ec:	00050793          	mv	a5,a0
    800021f0:	fef43423          	sd	a5,-24(s0)
    return a0;
    800021f4:	fe843503          	ld	a0,-24(s0)
    int res = r_a0();
    return res;
}
    800021f8:	0005051b          	sext.w	a0,a0
    800021fc:	01813083          	ld	ra,24(sp)
    80002200:	01013403          	ld	s0,16(sp)
    80002204:	02010113          	addi	sp,sp,32
    80002208:	00008067          	ret

000000008000220c <sem_close>:

int sem_close (sem_t handle)
{
    8000220c:	fe010113          	addi	sp,sp,-32
    80002210:	00113c23          	sd	ra,24(sp)
    80002214:	00813823          	sd	s0,16(sp)
    80002218:	02010413          	addi	s0,sp,32
    8000221c:	00050593          	mv	a1,a0
    kern_syscall(SEM_CLOSE,handle);
    80002220:	02200513          	li	a0,34
    80002224:	fffff097          	auipc	ra,0xfffff
    80002228:	42c080e7          	jalr	1068(ra) # 80001650 <kern_syscall>
    __asm__ volatile ("mv %[a0], a0" : [a0] "=r"(a0));
    8000222c:	00050793          	mv	a5,a0
    80002230:	fef43423          	sd	a5,-24(s0)
    return a0;
    80002234:	fe843503          	ld	a0,-24(s0)
    int res = r_a0();
    return res;
}
    80002238:	0005051b          	sext.w	a0,a0
    8000223c:	01813083          	ld	ra,24(sp)
    80002240:	01013403          	ld	s0,16(sp)
    80002244:	02010113          	addi	sp,sp,32
    80002248:	00008067          	ret

000000008000224c <sem_wait>:

int sem_wait (sem_t id)
{
    8000224c:	fe010113          	addi	sp,sp,-32
    80002250:	00113c23          	sd	ra,24(sp)
    80002254:	00813823          	sd	s0,16(sp)
    80002258:	02010413          	addi	s0,sp,32
    8000225c:	00050593          	mv	a1,a0
    kern_syscall(SEM_WAIT,id);
    80002260:	02300513          	li	a0,35
    80002264:	fffff097          	auipc	ra,0xfffff
    80002268:	3ec080e7          	jalr	1004(ra) # 80001650 <kern_syscall>
    __asm__ volatile ("mv %[a0], a0" : [a0] "=r"(a0));
    8000226c:	00050793          	mv	a5,a0
    80002270:	fef43423          	sd	a5,-24(s0)
    return a0;
    80002274:	fe843503          	ld	a0,-24(s0)
    int res = r_a0();
    return res;
}
    80002278:	0005051b          	sext.w	a0,a0
    8000227c:	01813083          	ld	ra,24(sp)
    80002280:	01013403          	ld	s0,16(sp)
    80002284:	02010113          	addi	sp,sp,32
    80002288:	00008067          	ret

000000008000228c <sem_signal>:

int sem_signal (sem_t id){
    8000228c:	fe010113          	addi	sp,sp,-32
    80002290:	00113c23          	sd	ra,24(sp)
    80002294:	00813823          	sd	s0,16(sp)
    80002298:	02010413          	addi	s0,sp,32
    8000229c:	00050593          	mv	a1,a0
    kern_syscall(SEM_SIGNAL,id);
    800022a0:	02400513          	li	a0,36
    800022a4:	fffff097          	auipc	ra,0xfffff
    800022a8:	3ac080e7          	jalr	940(ra) # 80001650 <kern_syscall>
    __asm__ volatile ("mv %[a0], a0" : [a0] "=r"(a0));
    800022ac:	00050793          	mv	a5,a0
    800022b0:	fef43423          	sd	a5,-24(s0)
    return a0;
    800022b4:	fe843503          	ld	a0,-24(s0)
    int res = r_a0();
    return res;
}
    800022b8:	0005051b          	sext.w	a0,a0
    800022bc:	01813083          	ld	ra,24(sp)
    800022c0:	01013403          	ld	s0,16(sp)
    800022c4:	02010113          	addi	sp,sp,32
    800022c8:	00008067          	ret

00000000800022cc <time_sleep>:

int time_sleep(unsigned long time){
    800022cc:	ff010113          	addi	sp,sp,-16
    800022d0:	00113423          	sd	ra,8(sp)
    800022d4:	00813023          	sd	s0,0(sp)
    800022d8:	01010413          	addi	s0,sp,16
    800022dc:	00050593          	mv	a1,a0
    kern_syscall(TIME_SLEEP,time);
    800022e0:	03100513          	li	a0,49
    800022e4:	fffff097          	auipc	ra,0xfffff
    800022e8:	36c080e7          	jalr	876(ra) # 80001650 <kern_syscall>
    return 0;
    800022ec:	00000513          	li	a0,0
    800022f0:	00813083          	ld	ra,8(sp)
    800022f4:	00013403          	ld	s0,0(sp)
    800022f8:	01010113          	addi	sp,sp,16
    800022fc:	00008067          	ret

0000000080002300 <kern_console_init>:
    int output_put_cursor;
    int output_get_cursor;
} console_instance;

void kern_console_init()
{
    80002300:	ff010113          	addi	sp,sp,-16
    80002304:	00113423          	sd	ra,8(sp)
    80002308:	00813023          	sd	s0,0(sp)
    8000230c:	01010413          	addi	s0,sp,16
    console_instance.input_put_cursor=0;
    80002310:	00007797          	auipc	a5,0x7
    80002314:	b9078793          	addi	a5,a5,-1136 # 80008ea0 <stack0+0x7a0>
    80002318:	8007a823          	sw	zero,-2032(a5)
    console_instance.input_get_cursor=0;
    8000231c:	8007aa23          	sw	zero,-2028(a5)
    console_instance.output_put_cursor=0;
    80002320:	8007ac23          	sw	zero,-2024(a5)
    console_instance.output_get_cursor=0;
    80002324:	8007ae23          	sw	zero,-2020(a5)
    kern_sem_open(&console_instance.input_sem,0);
    80002328:	00000593          	li	a1,0
    8000232c:	00006517          	auipc	a0,0x6
    80002330:	37450513          	addi	a0,a0,884 # 800086a0 <console_instance+0x800>
    80002334:	fffff097          	auipc	ra,0xfffff
    80002338:	f78080e7          	jalr	-136(ra) # 800012ac <kern_sem_open>
    kern_sem_open(&console_instance.output_sem,CONSOLE_BUFFER_SIZE);
    8000233c:	40000593          	li	a1,1024
    80002340:	00006517          	auipc	a0,0x6
    80002344:	36850513          	addi	a0,a0,872 # 800086a8 <console_instance+0x808>
    80002348:	fffff097          	auipc	ra,0xfffff
    8000234c:	f64080e7          	jalr	-156(ra) # 800012ac <kern_sem_open>
}
    80002350:	00813083          	ld	ra,8(sp)
    80002354:	00013403          	ld	s0,0(sp)
    80002358:	01010113          	addi	sp,sp,16
    8000235c:	00008067          	ret

0000000080002360 <kern_console_putc>:

void kern_console_putc()
{
    80002360:	ff010113          	addi	sp,sp,-16
    80002364:	00813423          	sd	s0,8(sp)
    80002368:	01010413          	addi	s0,sp,16

}
    8000236c:	00813403          	ld	s0,8(sp)
    80002370:	01010113          	addi	sp,sp,16
    80002374:	00008067          	ret

0000000080002378 <_Z8bodyIdlePv>:

Semaphore* semTest;

int idleAlive=1;
void bodyIdle(void* arg){
    while(idleAlive){
    80002378:	00003797          	auipc	a5,0x3
    8000237c:	2387a783          	lw	a5,568(a5) # 800055b0 <idleAlive>
    80002380:	02078c63          	beqz	a5,800023b8 <_Z8bodyIdlePv+0x40>
void bodyIdle(void* arg){
    80002384:	ff010113          	addi	sp,sp,-16
    80002388:	00113423          	sd	ra,8(sp)
    8000238c:	00813023          	sd	s0,0(sp)
    80002390:	01010413          	addi	s0,sp,16
        thread_dispatch();
    80002394:	00000097          	auipc	ra,0x0
    80002398:	d84080e7          	jalr	-636(ra) # 80002118 <thread_dispatch>
    while(idleAlive){
    8000239c:	00003797          	auipc	a5,0x3
    800023a0:	2147a783          	lw	a5,532(a5) # 800055b0 <idleAlive>
    800023a4:	fe0798e3          	bnez	a5,80002394 <_Z8bodyIdlePv+0x1c>
    };
}
    800023a8:	00813083          	ld	ra,8(sp)
    800023ac:	00013403          	ld	s0,0(sp)
    800023b0:	01010113          	addi	sp,sp,16
    800023b4:	00008067          	ret
    800023b8:	00008067          	ret

00000000800023bc <_Z5bodyCPv>:

void bodyC(void* arg)
{
    800023bc:	fe010113          	addi	sp,sp,-32
    800023c0:	00113c23          	sd	ra,24(sp)
    800023c4:	00813823          	sd	s0,16(sp)
    800023c8:	00913423          	sd	s1,8(sp)
    800023cc:	01213023          	sd	s2,0(sp)
    800023d0:	02010413          	addi	s0,sp,32
    800023d4:	00050913          	mv	s2,a0
    int counter=0;
    800023d8:	00000493          	li	s1,0
    char*c = (char*)arg;
    while(counter<10){
    800023dc:	00900793          	li	a5,9
    800023e0:	0297c263          	blt	a5,s1,80002404 <_Z5bodyCPv+0x48>
        //if(++counter>5) delete semTest;
        __putc(*c);
    800023e4:	00094503          	lbu	a0,0(s2)
    800023e8:	00002097          	auipc	ra,0x2
    800023ec:	634080e7          	jalr	1588(ra) # 80004a1c <__putc>
        time_sleep(1);
    800023f0:	00100513          	li	a0,1
    800023f4:	00000097          	auipc	ra,0x0
    800023f8:	ed8080e7          	jalr	-296(ra) # 800022cc <time_sleep>
        counter++;
    800023fc:	0014849b          	addiw	s1,s1,1
    while(counter<10){
    80002400:	fddff06f          	j	800023dc <_Z5bodyCPv+0x20>
    }
    counter++;
    //thread_exit();
}
    80002404:	01813083          	ld	ra,24(sp)
    80002408:	01013403          	ld	s0,16(sp)
    8000240c:	00813483          	ld	s1,8(sp)
    80002410:	00013903          	ld	s2,0(sp)
    80002414:	02010113          	addi	sp,sp,32
    80002418:	00008067          	ret

000000008000241c <_Z5bodyAPv>:

void bodyA(void* arg)
{
    8000241c:	fe010113          	addi	sp,sp,-32
    80002420:	00113c23          	sd	ra,24(sp)
    80002424:	00813823          	sd	s0,16(sp)
    80002428:	00913423          	sd	s1,8(sp)
    8000242c:	01213023          	sd	s2,0(sp)
    80002430:	02010413          	addi	s0,sp,32
        }
        virtual ~Semaphore (){
            sem_close(myHandle);
        }
        int wait (){
            return sem_wait(myHandle);
    80002434:	00006797          	auipc	a5,0x6
    80002438:	28c7b783          	ld	a5,652(a5) # 800086c0 <semTest>
    8000243c:	0087b503          	ld	a0,8(a5)
    80002440:	00000097          	auipc	ra,0x0
    80002444:	e0c080e7          	jalr	-500(ra) # 8000224c <sem_wait>
    char c = 'a';
    if(semTest->wait()) c='A';
    80002448:	00051863          	bnez	a0,80002458 <_Z5bodyAPv+0x3c>
    char c = 'a';
    8000244c:	06100913          	li	s2,97
    for(int i=0;i<10;i++){
    80002450:	00000493          	li	s1,0
    80002454:	0200006f          	j	80002474 <_Z5bodyAPv+0x58>
    if(semTest->wait()) c='A';
    80002458:	04100913          	li	s2,65
    8000245c:	ff5ff06f          	j	80002450 <_Z5bodyAPv+0x34>
        __putc(c);
        if(i==5) thread_exit();
    80002460:	00000097          	auipc	ra,0x0
    80002464:	ce4080e7          	jalr	-796(ra) # 80002144 <thread_exit>
        thread_dispatch();
    80002468:	00000097          	auipc	ra,0x0
    8000246c:	cb0080e7          	jalr	-848(ra) # 80002118 <thread_dispatch>
    for(int i=0;i<10;i++){
    80002470:	0014849b          	addiw	s1,s1,1
    80002474:	00900793          	li	a5,9
    80002478:	0097ce63          	blt	a5,s1,80002494 <_Z5bodyAPv+0x78>
        __putc(c);
    8000247c:	00090513          	mv	a0,s2
    80002480:	00002097          	auipc	ra,0x2
    80002484:	59c080e7          	jalr	1436(ra) # 80004a1c <__putc>
        if(i==5) thread_exit();
    80002488:	00500793          	li	a5,5
    8000248c:	fcf49ee3          	bne	s1,a5,80002468 <_Z5bodyAPv+0x4c>
    80002490:	fd1ff06f          	j	80002460 <_Z5bodyAPv+0x44>
    }
}
    80002494:	01813083          	ld	ra,24(sp)
    80002498:	01013403          	ld	s0,16(sp)
    8000249c:	00813483          	ld	s1,8(sp)
    800024a0:	00013903          	ld	s2,0(sp)
    800024a4:	02010113          	addi	sp,sp,32
    800024a8:	00008067          	ret

00000000800024ac <_Z5bodyBPv>:

int g=0;

char str[15] = "tesa legenda";
void bodyB(void* arg)
{
    800024ac:	fe010113          	addi	sp,sp,-32
    800024b0:	00113c23          	sd	ra,24(sp)
    800024b4:	00813823          	sd	s0,16(sp)
    800024b8:	00913423          	sd	s1,8(sp)
    800024bc:	02010413          	addi	s0,sp,32

    time_sleep(10);
    800024c0:	00a00513          	li	a0,10
    800024c4:	00000097          	auipc	ra,0x0
    800024c8:	e08080e7          	jalr	-504(ra) # 800022cc <time_sleep>
    for(int i=0;i<4;i++){
    800024cc:	00000493          	li	s1,0
    800024d0:	0540006f          	j	80002524 <_Z5bodyBPv+0x78>
        __putc(str[i]);
        for(int k=0;k<10000;k++){
            for(int m=0;m<1000;m++){
    800024d4:	0017071b          	addiw	a4,a4,1
    800024d8:	3e700793          	li	a5,999
    800024dc:	02e7c663          	blt	a5,a4,80002508 <_Z5bodyBPv+0x5c>
                if((m*k)%1337==0) g++;
    800024e0:	02e607bb          	mulw	a5,a2,a4
    800024e4:	53900693          	li	a3,1337
    800024e8:	02d7e7bb          	remw	a5,a5,a3
    800024ec:	fe0794e3          	bnez	a5,800024d4 <_Z5bodyBPv+0x28>
    800024f0:	00006697          	auipc	a3,0x6
    800024f4:	1d068693          	addi	a3,a3,464 # 800086c0 <semTest>
    800024f8:	0086a783          	lw	a5,8(a3)
    800024fc:	0017879b          	addiw	a5,a5,1
    80002500:	00f6a423          	sw	a5,8(a3)
    80002504:	fd1ff06f          	j	800024d4 <_Z5bodyBPv+0x28>
        for(int k=0;k<10000;k++){
    80002508:	0016061b          	addiw	a2,a2,1
    8000250c:	000027b7          	lui	a5,0x2
    80002510:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    80002514:	00c7c663          	blt	a5,a2,80002520 <_Z5bodyBPv+0x74>
            for(int m=0;m<1000;m++){
    80002518:	00000713          	li	a4,0
    8000251c:	fbdff06f          	j	800024d8 <_Z5bodyBPv+0x2c>
    for(int i=0;i<4;i++){
    80002520:	0014849b          	addiw	s1,s1,1
    80002524:	00300793          	li	a5,3
    80002528:	0297c263          	blt	a5,s1,8000254c <_Z5bodyBPv+0xa0>
        __putc(str[i]);
    8000252c:	00003797          	auipc	a5,0x3
    80002530:	08478793          	addi	a5,a5,132 # 800055b0 <idleAlive>
    80002534:	009787b3          	add	a5,a5,s1
    80002538:	0087c503          	lbu	a0,8(a5)
    8000253c:	00002097          	auipc	ra,0x2
    80002540:	4e0080e7          	jalr	1248(ra) # 80004a1c <__putc>
        for(int k=0;k<10000;k++){
    80002544:	00000613          	li	a2,0
    80002548:	fc5ff06f          	j	8000250c <_Z5bodyBPv+0x60>
        }
        int signal (){
            return sem_signal(myHandle);
    8000254c:	00006797          	auipc	a5,0x6
    80002550:	1747b783          	ld	a5,372(a5) # 800086c0 <semTest>
    80002554:	0087b503          	ld	a0,8(a5)
    80002558:	00000097          	auipc	ra,0x0
    8000255c:	d34080e7          	jalr	-716(ra) # 8000228c <sem_signal>
            }
        }
    }
    semTest->signal();
}
    80002560:	01813083          	ld	ra,24(sp)
    80002564:	01013403          	ld	s0,16(sp)
    80002568:	00813483          	ld	s1,8(sp)
    8000256c:	02010113          	addi	sp,sp,32
    80002570:	00008067          	ret

0000000080002574 <_Znwm>:
void* operator new(size_t size) {
    80002574:	ff010113          	addi	sp,sp,-16
    80002578:	00113423          	sd	ra,8(sp)
    8000257c:	00813023          	sd	s0,0(sp)
    80002580:	01010413          	addi	s0,sp,16
    void* ptr = mem_alloc(size);
    80002584:	00000097          	auipc	ra,0x0
    80002588:	a8c080e7          	jalr	-1396(ra) # 80002010 <mem_alloc>
}
    8000258c:	00813083          	ld	ra,8(sp)
    80002590:	00013403          	ld	s0,0(sp)
    80002594:	01010113          	addi	sp,sp,16
    80002598:	00008067          	ret

000000008000259c <_ZdlPv>:
void operator delete(void* ptr) {
    8000259c:	ff010113          	addi	sp,sp,-16
    800025a0:	00113423          	sd	ra,8(sp)
    800025a4:	00813023          	sd	s0,0(sp)
    800025a8:	01010413          	addi	s0,sp,16
    mem_free(ptr);
    800025ac:	00000097          	auipc	ra,0x0
    800025b0:	aa4080e7          	jalr	-1372(ra) # 80002050 <mem_free>
}
    800025b4:	00813083          	ld	ra,8(sp)
    800025b8:	00013403          	ld	s0,0(sp)
    800025bc:	01010113          	addi	sp,sp,16
    800025c0:	00008067          	ret

00000000800025c4 <main>:


int main()
{
    800025c4:	fc010113          	addi	sp,sp,-64
    800025c8:	02113c23          	sd	ra,56(sp)
    800025cc:	02813823          	sd	s0,48(sp)
    800025d0:	02913423          	sd	s1,40(sp)
    800025d4:	03213023          	sd	s2,32(sp)
    800025d8:	01313c23          	sd	s3,24(sp)
    800025dc:	01413823          	sd	s4,16(sp)
    800025e0:	04010413          	addi	s0,sp,64
    kern_thread_init();
    800025e4:	fffff097          	auipc	ra,0xfffff
    800025e8:	480080e7          	jalr	1152(ra) # 80001a64 <kern_thread_init>
    //printstring("lalala");

    kern_mem_init((void*)HEAP_START_ADDR, (void*)HEAP_END_ADDR);
    800025ec:	00003797          	auipc	a5,0x3
    800025f0:	0447b783          	ld	a5,68(a5) # 80005630 <_GLOBAL_OFFSET_TABLE_+0x18>
    800025f4:	0007b583          	ld	a1,0(a5)
    800025f8:	00003797          	auipc	a5,0x3
    800025fc:	0287b783          	ld	a5,40(a5) # 80005620 <_GLOBAL_OFFSET_TABLE_+0x8>
    80002600:	0007b503          	ld	a0,0(a5)
    80002604:	fffff097          	auipc	ra,0xfffff
    80002608:	fdc080e7          	jalr	-36(ra) # 800015e0 <kern_mem_init>
    kern_interrupt_init();
    8000260c:	fffff097          	auipc	ra,0xfffff
    80002610:	07c080e7          	jalr	124(ra) # 80001688 <kern_interrupt_init>
    kern_sem_init();
    80002614:	fffff097          	auipc	ra,0xfffff
    80002618:	c4c080e7          	jalr	-948(ra) # 80001260 <kern_sem_init>

    Thread* thrIdle = new Thread(&bodyIdle,0);
    8000261c:	02000513          	li	a0,32
    80002620:	00000097          	auipc	ra,0x0
    80002624:	f54080e7          	jalr	-172(ra) # 80002574 <_Znwm>
        {
    80002628:	00003797          	auipc	a5,0x3
    8000262c:	fb078793          	addi	a5,a5,-80 # 800055d8 <_ZTV6Thread+0x10>
    80002630:	00f53023          	sd	a5,0(a0)
            this->body=body;
    80002634:	00000597          	auipc	a1,0x0
    80002638:	d4458593          	addi	a1,a1,-700 # 80002378 <_Z8bodyIdlePv>
    8000263c:	00b53823          	sd	a1,16(a0)
            this->arg=arg;
    80002640:	00053c23          	sd	zero,24(a0)
            return thread_create(&myHandle,body,arg);
    80002644:	00000613          	li	a2,0
    80002648:	00850513          	addi	a0,a0,8
    8000264c:	00000097          	auipc	ra,0x0
    80002650:	a44080e7          	jalr	-1468(ra) # 80002090 <thread_create>
    a= mem_alloc(64);
    mem_free(a);
    */


    semTest=new Semaphore(0);
    80002654:	01000513          	li	a0,16
    80002658:	00000097          	auipc	ra,0x0
    8000265c:	f1c080e7          	jalr	-228(ra) # 80002574 <_Znwm>
    80002660:	00050493          	mv	s1,a0
        Semaphore (unsigned init = 1){
    80002664:	00003797          	auipc	a5,0x3
    80002668:	f9c78793          	addi	a5,a5,-100 # 80005600 <_ZTV9Semaphore+0x10>
    8000266c:	00f53023          	sd	a5,0(a0)
            sem_open(&myHandle,init);
    80002670:	00000593          	li	a1,0
    80002674:	00850513          	addi	a0,a0,8
    80002678:	00000097          	auipc	ra,0x0
    8000267c:	b50080e7          	jalr	-1200(ra) # 800021c8 <sem_open>
    80002680:	00006797          	auipc	a5,0x6
    80002684:	0497b023          	sd	s1,64(a5) # 800086c0 <semTest>
    Thread *thrA = new Thread(&bodyA,0);
    80002688:	02000513          	li	a0,32
    8000268c:	00000097          	auipc	ra,0x0
    80002690:	ee8080e7          	jalr	-280(ra) # 80002574 <_Znwm>
    80002694:	00050913          	mv	s2,a0
        {
    80002698:	00003997          	auipc	s3,0x3
    8000269c:	f4098993          	addi	s3,s3,-192 # 800055d8 <_ZTV6Thread+0x10>
    800026a0:	01353023          	sd	s3,0(a0)
            this->body=body;
    800026a4:	00000797          	auipc	a5,0x0
    800026a8:	d7878793          	addi	a5,a5,-648 # 8000241c <_Z5bodyAPv>
    800026ac:	00f53823          	sd	a5,16(a0)
            this->arg=arg;
    800026b0:	00053c23          	sd	zero,24(a0)
    Thread *thrB = new Thread(&bodyB,0);
    800026b4:	02000513          	li	a0,32
    800026b8:	00000097          	auipc	ra,0x0
    800026bc:	ebc080e7          	jalr	-324(ra) # 80002574 <_Znwm>
    800026c0:	00050493          	mv	s1,a0
        {
    800026c4:	01353023          	sd	s3,0(a0)
            this->body=body;
    800026c8:	00000597          	auipc	a1,0x0
    800026cc:	de458593          	addi	a1,a1,-540 # 800024ac <_Z5bodyBPv>
    800026d0:	00b53823          	sd	a1,16(a0)
            this->arg=arg;
    800026d4:	00053c23          	sd	zero,24(a0)
            return thread_create(&myHandle,body,arg);
    800026d8:	00850a13          	addi	s4,a0,8
    800026dc:	00000613          	li	a2,0
    800026e0:	000a0513          	mv	a0,s4
    800026e4:	00000097          	auipc	ra,0x0
    800026e8:	9ac080e7          	jalr	-1620(ra) # 80002090 <thread_create>
    800026ec:	01893603          	ld	a2,24(s2)
    800026f0:	01093583          	ld	a1,16(s2)
    800026f4:	00890513          	addi	a0,s2,8
    800026f8:	00000097          	auipc	ra,0x0
    800026fc:	998080e7          	jalr	-1640(ra) # 80002090 <thread_create>
    thrB->start();
    thrA->start();
    __putc('S');
    80002700:	05300513          	li	a0,83
    80002704:	00002097          	auipc	ra,0x2
    80002708:	318080e7          	jalr	792(ra) # 80004a1c <__putc>
            thread_join(myHandle);
    8000270c:	0084b503          	ld	a0,8(s1)
    80002710:	00000097          	auipc	ra,0x0
    80002714:	a88080e7          	jalr	-1400(ra) # 80002198 <thread_join>
    80002718:	00893503          	ld	a0,8(s2)
    8000271c:	00000097          	auipc	ra,0x0
    80002720:	a7c080e7          	jalr	-1412(ra) # 80002198 <thread_join>
    80002724:	0084b503          	ld	a0,8(s1)
    80002728:	00000097          	auipc	ra,0x0
    8000272c:	a70080e7          	jalr	-1424(ra) # 80002198 <thread_join>
    thrB->join();
    thrA->join();
    thrB->join();
    char o='O';
    char c='M';
    c++;
    80002730:	04e00793          	li	a5,78
    80002734:	fcf40723          	sb	a5,-50(s0)
    o++;
    80002738:	05000793          	li	a5,80
    8000273c:	fcf407a3          	sb	a5,-49(s0)
    thread_t thrC;
    thread_create(&thrC,&bodyC,&o);
    80002740:	fcf40613          	addi	a2,s0,-49
    80002744:	00000597          	auipc	a1,0x0
    80002748:	c7858593          	addi	a1,a1,-904 # 800023bc <_Z5bodyCPv>
    8000274c:	fc040513          	addi	a0,s0,-64
    80002750:	00000097          	auipc	ra,0x0
    80002754:	940080e7          	jalr	-1728(ra) # 80002090 <thread_create>
    thread_join(thrC);
    80002758:	fc043503          	ld	a0,-64(s0)
    8000275c:	00000097          	auipc	ra,0x0
    80002760:	a3c080e7          	jalr	-1476(ra) # 80002198 <thread_join>
    Thread *thrCobj = new Thread(&bodyC,&c);
    80002764:	02000513          	li	a0,32
    80002768:	00000097          	auipc	ra,0x0
    8000276c:	e0c080e7          	jalr	-500(ra) # 80002574 <_Znwm>
    80002770:	00050913          	mv	s2,a0
        {
    80002774:	01353023          	sd	s3,0(a0)
            this->body=body;
    80002778:	00000597          	auipc	a1,0x0
    8000277c:	c4458593          	addi	a1,a1,-956 # 800023bc <_Z5bodyCPv>
    80002780:	00b53823          	sd	a1,16(a0)
            this->arg=arg;
    80002784:	fce40613          	addi	a2,s0,-50
    80002788:	00c53c23          	sd	a2,24(a0)
            return thread_create(&myHandle,body,arg);
    8000278c:	00850513          	addi	a0,a0,8
    80002790:	00000097          	auipc	ra,0x0
    80002794:	900080e7          	jalr	-1792(ra) # 80002090 <thread_create>
            thread_join(myHandle);
    80002798:	00893503          	ld	a0,8(s2)
    8000279c:	00000097          	auipc	ra,0x0
    800027a0:	9fc080e7          	jalr	-1540(ra) # 80002198 <thread_join>
    thrCobj->start();
    thrCobj->join();
    delete thrCobj;
    800027a4:	00090a63          	beqz	s2,800027b8 <main+0x1f4>
    800027a8:	00093783          	ld	a5,0(s2)
    800027ac:	0087b783          	ld	a5,8(a5)
    800027b0:	00090513          	mv	a0,s2
    800027b4:	000780e7          	jalr	a5
            return thread_create(&myHandle,body,arg);
    800027b8:	0184b603          	ld	a2,24(s1)
    800027bc:	0104b583          	ld	a1,16(s1)
    800027c0:	000a0513          	mv	a0,s4
    800027c4:	00000097          	auipc	ra,0x0
    800027c8:	8cc080e7          	jalr	-1844(ra) # 80002090 <thread_create>
            thread_join(myHandle);
    800027cc:	0084b503          	ld	a0,8(s1)
    800027d0:	00000097          	auipc	ra,0x0
    800027d4:	9c8080e7          	jalr	-1592(ra) # 80002198 <thread_join>
    thrB->start();
    thrB->join();
    __putc('E');
    800027d8:	04500513          	li	a0,69
    800027dc:	00002097          	auipc	ra,0x2
    800027e0:	240080e7          	jalr	576(ra) # 80004a1c <__putc>
    //while(1);
    idleAlive=0;
    800027e4:	00003797          	auipc	a5,0x3
    800027e8:	dc07a623          	sw	zero,-564(a5) # 800055b0 <idleAlive>
    return 0;
    800027ec:	00000513          	li	a0,0
    800027f0:	03813083          	ld	ra,56(sp)
    800027f4:	03013403          	ld	s0,48(sp)
    800027f8:	02813483          	ld	s1,40(sp)
    800027fc:	02013903          	ld	s2,32(sp)
    80002800:	01813983          	ld	s3,24(sp)
    80002804:	01013a03          	ld	s4,16(sp)
    80002808:	04010113          	addi	sp,sp,64
    8000280c:	00008067          	ret
    80002810:	00050913          	mv	s2,a0
    semTest=new Semaphore(0);
    80002814:	00048513          	mv	a0,s1
    80002818:	00000097          	auipc	ra,0x0
    8000281c:	d84080e7          	jalr	-636(ra) # 8000259c <_ZdlPv>
    80002820:	00090513          	mv	a0,s2
    80002824:	00007097          	auipc	ra,0x7
    80002828:	f74080e7          	jalr	-140(ra) # 80009798 <_Unwind_Resume>

000000008000282c <_ZN6ThreadD1Ev>:
        virtual ~Thread (){
    8000282c:	ff010113          	addi	sp,sp,-16
    80002830:	00813423          	sd	s0,8(sp)
    80002834:	01010413          	addi	s0,sp,16
        }
    80002838:	00813403          	ld	s0,8(sp)
    8000283c:	01010113          	addi	sp,sp,16
    80002840:	00008067          	ret

0000000080002844 <_ZN6Thread3runEv>:
        virtual void run () {}
    80002844:	ff010113          	addi	sp,sp,-16
    80002848:	00813423          	sd	s0,8(sp)
    8000284c:	01010413          	addi	s0,sp,16
    80002850:	00813403          	ld	s0,8(sp)
    80002854:	01010113          	addi	sp,sp,16
    80002858:	00008067          	ret

000000008000285c <_ZN9SemaphoreD1Ev>:
        virtual ~Semaphore (){
    8000285c:	ff010113          	addi	sp,sp,-16
    80002860:	00113423          	sd	ra,8(sp)
    80002864:	00813023          	sd	s0,0(sp)
    80002868:	01010413          	addi	s0,sp,16
    8000286c:	00003797          	auipc	a5,0x3
    80002870:	d9478793          	addi	a5,a5,-620 # 80005600 <_ZTV9Semaphore+0x10>
    80002874:	00f53023          	sd	a5,0(a0)
            sem_close(myHandle);
    80002878:	00853503          	ld	a0,8(a0)
    8000287c:	00000097          	auipc	ra,0x0
    80002880:	990080e7          	jalr	-1648(ra) # 8000220c <sem_close>
        }
    80002884:	00813083          	ld	ra,8(sp)
    80002888:	00013403          	ld	s0,0(sp)
    8000288c:	01010113          	addi	sp,sp,16
    80002890:	00008067          	ret

0000000080002894 <_ZN9SemaphoreD0Ev>:
        virtual ~Semaphore (){
    80002894:	fe010113          	addi	sp,sp,-32
    80002898:	00113c23          	sd	ra,24(sp)
    8000289c:	00813823          	sd	s0,16(sp)
    800028a0:	00913423          	sd	s1,8(sp)
    800028a4:	02010413          	addi	s0,sp,32
    800028a8:	00050493          	mv	s1,a0
    800028ac:	00003797          	auipc	a5,0x3
    800028b0:	d5478793          	addi	a5,a5,-684 # 80005600 <_ZTV9Semaphore+0x10>
    800028b4:	00f53023          	sd	a5,0(a0)
            sem_close(myHandle);
    800028b8:	00853503          	ld	a0,8(a0)
    800028bc:	00000097          	auipc	ra,0x0
    800028c0:	950080e7          	jalr	-1712(ra) # 8000220c <sem_close>
        }
    800028c4:	00048513          	mv	a0,s1
    800028c8:	00000097          	auipc	ra,0x0
    800028cc:	cd4080e7          	jalr	-812(ra) # 8000259c <_ZdlPv>
    800028d0:	01813083          	ld	ra,24(sp)
    800028d4:	01013403          	ld	s0,16(sp)
    800028d8:	00813483          	ld	s1,8(sp)
    800028dc:	02010113          	addi	sp,sp,32
    800028e0:	00008067          	ret

00000000800028e4 <_ZN6ThreadD0Ev>:
        virtual ~Thread (){
    800028e4:	ff010113          	addi	sp,sp,-16
    800028e8:	00113423          	sd	ra,8(sp)
    800028ec:	00813023          	sd	s0,0(sp)
    800028f0:	01010413          	addi	s0,sp,16
        }
    800028f4:	00000097          	auipc	ra,0x0
    800028f8:	ca8080e7          	jalr	-856(ra) # 8000259c <_ZdlPv>
    800028fc:	00813083          	ld	ra,8(sp)
    80002900:	00013403          	ld	s0,0(sp)
    80002904:	01010113          	addi	sp,sp,16
    80002908:	00008067          	ret

000000008000290c <_Z11printstringPKc>:
//

#include "../h/strings.h"

void printstring(const char* string)
{
    8000290c:	fe010113          	addi	sp,sp,-32
    80002910:	00113c23          	sd	ra,24(sp)
    80002914:	00813823          	sd	s0,16(sp)
    80002918:	00913423          	sd	s1,8(sp)
    8000291c:	01213023          	sd	s2,0(sp)
    80002920:	02010413          	addi	s0,sp,32
    80002924:	00050913          	mv	s2,a0
    int i=0;
    80002928:	00000493          	li	s1,0
    while (string[i]){
    8000292c:	009907b3          	add	a5,s2,s1
    80002930:	0007c503          	lbu	a0,0(a5)
    80002934:	00050a63          	beqz	a0,80002948 <_Z11printstringPKc+0x3c>
        __putc(string[i++]);
    80002938:	0014849b          	addiw	s1,s1,1
    8000293c:	00002097          	auipc	ra,0x2
    80002940:	0e0080e7          	jalr	224(ra) # 80004a1c <__putc>
    while (string[i]){
    80002944:	fe9ff06f          	j	8000292c <_Z11printstringPKc+0x20>
    }
}
    80002948:	01813083          	ld	ra,24(sp)
    8000294c:	01013403          	ld	s0,16(sp)
    80002950:	00813483          	ld	s1,8(sp)
    80002954:	00013903          	ld	s2,0(sp)
    80002958:	02010113          	addi	sp,sp,32
    8000295c:	00008067          	ret

0000000080002960 <start>:
    80002960:	ff010113          	addi	sp,sp,-16
    80002964:	00813423          	sd	s0,8(sp)
    80002968:	01010413          	addi	s0,sp,16
    8000296c:	300027f3          	csrr	a5,mstatus
    80002970:	ffffe737          	lui	a4,0xffffe
    80002974:	7ff70713          	addi	a4,a4,2047 # ffffffffffffe7ff <end+0xffffffff7fff4ecf>
    80002978:	00e7f7b3          	and	a5,a5,a4
    8000297c:	00001737          	lui	a4,0x1
    80002980:	80070713          	addi	a4,a4,-2048 # 800 <_entry-0x7ffff800>
    80002984:	00e7e7b3          	or	a5,a5,a4
    80002988:	30079073          	csrw	mstatus,a5
    8000298c:	00000797          	auipc	a5,0x0
    80002990:	16078793          	addi	a5,a5,352 # 80002aec <system_main>
    80002994:	34179073          	csrw	mepc,a5
    80002998:	00000793          	li	a5,0
    8000299c:	18079073          	csrw	satp,a5
    800029a0:	000107b7          	lui	a5,0x10
    800029a4:	fff78793          	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    800029a8:	30279073          	csrw	medeleg,a5
    800029ac:	30379073          	csrw	mideleg,a5
    800029b0:	104027f3          	csrr	a5,sie
    800029b4:	2227e793          	ori	a5,a5,546
    800029b8:	10479073          	csrw	sie,a5
    800029bc:	fff00793          	li	a5,-1
    800029c0:	00a7d793          	srli	a5,a5,0xa
    800029c4:	3b079073          	csrw	pmpaddr0,a5
    800029c8:	00f00793          	li	a5,15
    800029cc:	3a079073          	csrw	pmpcfg0,a5
    800029d0:	f14027f3          	csrr	a5,mhartid
    800029d4:	0200c737          	lui	a4,0x200c
    800029d8:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    800029dc:	0007869b          	sext.w	a3,a5
    800029e0:	00269713          	slli	a4,a3,0x2
    800029e4:	000f4637          	lui	a2,0xf4
    800029e8:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    800029ec:	00d70733          	add	a4,a4,a3
    800029f0:	0037979b          	slliw	a5,a5,0x3
    800029f4:	020046b7          	lui	a3,0x2004
    800029f8:	00d787b3          	add	a5,a5,a3
    800029fc:	00c585b3          	add	a1,a1,a2
    80002a00:	00371693          	slli	a3,a4,0x3
    80002a04:	00006717          	auipc	a4,0x6
    80002a08:	ccc70713          	addi	a4,a4,-820 # 800086d0 <timer_scratch>
    80002a0c:	00b7b023          	sd	a1,0(a5)
    80002a10:	00d70733          	add	a4,a4,a3
    80002a14:	00f73c23          	sd	a5,24(a4)
    80002a18:	02c73023          	sd	a2,32(a4)
    80002a1c:	34071073          	csrw	mscratch,a4
    80002a20:	00000797          	auipc	a5,0x0
    80002a24:	6e078793          	addi	a5,a5,1760 # 80003100 <timervec>
    80002a28:	30579073          	csrw	mtvec,a5
    80002a2c:	300027f3          	csrr	a5,mstatus
    80002a30:	0087e793          	ori	a5,a5,8
    80002a34:	30079073          	csrw	mstatus,a5
    80002a38:	304027f3          	csrr	a5,mie
    80002a3c:	0807e793          	ori	a5,a5,128
    80002a40:	30479073          	csrw	mie,a5
    80002a44:	f14027f3          	csrr	a5,mhartid
    80002a48:	0007879b          	sext.w	a5,a5
    80002a4c:	00078213          	mv	tp,a5
    80002a50:	30200073          	mret
    80002a54:	00813403          	ld	s0,8(sp)
    80002a58:	01010113          	addi	sp,sp,16
    80002a5c:	00008067          	ret

0000000080002a60 <timerinit>:
    80002a60:	ff010113          	addi	sp,sp,-16
    80002a64:	00813423          	sd	s0,8(sp)
    80002a68:	01010413          	addi	s0,sp,16
    80002a6c:	f14027f3          	csrr	a5,mhartid
    80002a70:	0200c737          	lui	a4,0x200c
    80002a74:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    80002a78:	0007869b          	sext.w	a3,a5
    80002a7c:	00269713          	slli	a4,a3,0x2
    80002a80:	000f4637          	lui	a2,0xf4
    80002a84:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    80002a88:	00d70733          	add	a4,a4,a3
    80002a8c:	0037979b          	slliw	a5,a5,0x3
    80002a90:	020046b7          	lui	a3,0x2004
    80002a94:	00d787b3          	add	a5,a5,a3
    80002a98:	00c585b3          	add	a1,a1,a2
    80002a9c:	00371693          	slli	a3,a4,0x3
    80002aa0:	00006717          	auipc	a4,0x6
    80002aa4:	c3070713          	addi	a4,a4,-976 # 800086d0 <timer_scratch>
    80002aa8:	00b7b023          	sd	a1,0(a5)
    80002aac:	00d70733          	add	a4,a4,a3
    80002ab0:	00f73c23          	sd	a5,24(a4)
    80002ab4:	02c73023          	sd	a2,32(a4)
    80002ab8:	34071073          	csrw	mscratch,a4
    80002abc:	00000797          	auipc	a5,0x0
    80002ac0:	64478793          	addi	a5,a5,1604 # 80003100 <timervec>
    80002ac4:	30579073          	csrw	mtvec,a5
    80002ac8:	300027f3          	csrr	a5,mstatus
    80002acc:	0087e793          	ori	a5,a5,8
    80002ad0:	30079073          	csrw	mstatus,a5
    80002ad4:	304027f3          	csrr	a5,mie
    80002ad8:	0807e793          	ori	a5,a5,128
    80002adc:	30479073          	csrw	mie,a5
    80002ae0:	00813403          	ld	s0,8(sp)
    80002ae4:	01010113          	addi	sp,sp,16
    80002ae8:	00008067          	ret

0000000080002aec <system_main>:
    80002aec:	fe010113          	addi	sp,sp,-32
    80002af0:	00813823          	sd	s0,16(sp)
    80002af4:	00913423          	sd	s1,8(sp)
    80002af8:	00113c23          	sd	ra,24(sp)
    80002afc:	02010413          	addi	s0,sp,32
    80002b00:	00000097          	auipc	ra,0x0
    80002b04:	0c4080e7          	jalr	196(ra) # 80002bc4 <cpuid>
    80002b08:	00003497          	auipc	s1,0x3
    80002b0c:	b7448493          	addi	s1,s1,-1164 # 8000567c <started>
    80002b10:	02050263          	beqz	a0,80002b34 <system_main+0x48>
    80002b14:	0004a783          	lw	a5,0(s1)
    80002b18:	0007879b          	sext.w	a5,a5
    80002b1c:	fe078ce3          	beqz	a5,80002b14 <system_main+0x28>
    80002b20:	0ff0000f          	fence
    80002b24:	00002517          	auipc	a0,0x2
    80002b28:	5f450513          	addi	a0,a0,1524 # 80005118 <CONSOLE_STATUS+0x100>
    80002b2c:	00001097          	auipc	ra,0x1
    80002b30:	a70080e7          	jalr	-1424(ra) # 8000359c <panic>
    80002b34:	00001097          	auipc	ra,0x1
    80002b38:	9c4080e7          	jalr	-1596(ra) # 800034f8 <consoleinit>
    80002b3c:	00001097          	auipc	ra,0x1
    80002b40:	150080e7          	jalr	336(ra) # 80003c8c <printfinit>
    80002b44:	00002517          	auipc	a0,0x2
    80002b48:	6b450513          	addi	a0,a0,1716 # 800051f8 <CONSOLE_STATUS+0x1e0>
    80002b4c:	00001097          	auipc	ra,0x1
    80002b50:	aac080e7          	jalr	-1364(ra) # 800035f8 <__printf>
    80002b54:	00002517          	auipc	a0,0x2
    80002b58:	59450513          	addi	a0,a0,1428 # 800050e8 <CONSOLE_STATUS+0xd0>
    80002b5c:	00001097          	auipc	ra,0x1
    80002b60:	a9c080e7          	jalr	-1380(ra) # 800035f8 <__printf>
    80002b64:	00002517          	auipc	a0,0x2
    80002b68:	69450513          	addi	a0,a0,1684 # 800051f8 <CONSOLE_STATUS+0x1e0>
    80002b6c:	00001097          	auipc	ra,0x1
    80002b70:	a8c080e7          	jalr	-1396(ra) # 800035f8 <__printf>
    80002b74:	00001097          	auipc	ra,0x1
    80002b78:	4a4080e7          	jalr	1188(ra) # 80004018 <kinit>
    80002b7c:	00000097          	auipc	ra,0x0
    80002b80:	148080e7          	jalr	328(ra) # 80002cc4 <trapinit>
    80002b84:	00000097          	auipc	ra,0x0
    80002b88:	16c080e7          	jalr	364(ra) # 80002cf0 <trapinithart>
    80002b8c:	00000097          	auipc	ra,0x0
    80002b90:	5b4080e7          	jalr	1460(ra) # 80003140 <plicinit>
    80002b94:	00000097          	auipc	ra,0x0
    80002b98:	5d4080e7          	jalr	1492(ra) # 80003168 <plicinithart>
    80002b9c:	00000097          	auipc	ra,0x0
    80002ba0:	078080e7          	jalr	120(ra) # 80002c14 <userinit>
    80002ba4:	0ff0000f          	fence
    80002ba8:	00100793          	li	a5,1
    80002bac:	00002517          	auipc	a0,0x2
    80002bb0:	55450513          	addi	a0,a0,1364 # 80005100 <CONSOLE_STATUS+0xe8>
    80002bb4:	00f4a023          	sw	a5,0(s1)
    80002bb8:	00001097          	auipc	ra,0x1
    80002bbc:	a40080e7          	jalr	-1472(ra) # 800035f8 <__printf>
    80002bc0:	0000006f          	j	80002bc0 <system_main+0xd4>

0000000080002bc4 <cpuid>:
    80002bc4:	ff010113          	addi	sp,sp,-16
    80002bc8:	00813423          	sd	s0,8(sp)
    80002bcc:	01010413          	addi	s0,sp,16
    80002bd0:	00020513          	mv	a0,tp
    80002bd4:	00813403          	ld	s0,8(sp)
    80002bd8:	0005051b          	sext.w	a0,a0
    80002bdc:	01010113          	addi	sp,sp,16
    80002be0:	00008067          	ret

0000000080002be4 <mycpu>:
    80002be4:	ff010113          	addi	sp,sp,-16
    80002be8:	00813423          	sd	s0,8(sp)
    80002bec:	01010413          	addi	s0,sp,16
    80002bf0:	00020793          	mv	a5,tp
    80002bf4:	00813403          	ld	s0,8(sp)
    80002bf8:	0007879b          	sext.w	a5,a5
    80002bfc:	00779793          	slli	a5,a5,0x7
    80002c00:	00007517          	auipc	a0,0x7
    80002c04:	b0050513          	addi	a0,a0,-1280 # 80009700 <cpus>
    80002c08:	00f50533          	add	a0,a0,a5
    80002c0c:	01010113          	addi	sp,sp,16
    80002c10:	00008067          	ret

0000000080002c14 <userinit>:
    80002c14:	ff010113          	addi	sp,sp,-16
    80002c18:	00813423          	sd	s0,8(sp)
    80002c1c:	01010413          	addi	s0,sp,16
    80002c20:	00813403          	ld	s0,8(sp)
    80002c24:	01010113          	addi	sp,sp,16
    80002c28:	00000317          	auipc	t1,0x0
    80002c2c:	99c30067          	jr	-1636(t1) # 800025c4 <main>

0000000080002c30 <either_copyout>:
    80002c30:	ff010113          	addi	sp,sp,-16
    80002c34:	00813023          	sd	s0,0(sp)
    80002c38:	00113423          	sd	ra,8(sp)
    80002c3c:	01010413          	addi	s0,sp,16
    80002c40:	02051663          	bnez	a0,80002c6c <either_copyout+0x3c>
    80002c44:	00058513          	mv	a0,a1
    80002c48:	00060593          	mv	a1,a2
    80002c4c:	0006861b          	sext.w	a2,a3
    80002c50:	00002097          	auipc	ra,0x2
    80002c54:	c54080e7          	jalr	-940(ra) # 800048a4 <__memmove>
    80002c58:	00813083          	ld	ra,8(sp)
    80002c5c:	00013403          	ld	s0,0(sp)
    80002c60:	00000513          	li	a0,0
    80002c64:	01010113          	addi	sp,sp,16
    80002c68:	00008067          	ret
    80002c6c:	00002517          	auipc	a0,0x2
    80002c70:	4d450513          	addi	a0,a0,1236 # 80005140 <CONSOLE_STATUS+0x128>
    80002c74:	00001097          	auipc	ra,0x1
    80002c78:	928080e7          	jalr	-1752(ra) # 8000359c <panic>

0000000080002c7c <either_copyin>:
    80002c7c:	ff010113          	addi	sp,sp,-16
    80002c80:	00813023          	sd	s0,0(sp)
    80002c84:	00113423          	sd	ra,8(sp)
    80002c88:	01010413          	addi	s0,sp,16
    80002c8c:	02059463          	bnez	a1,80002cb4 <either_copyin+0x38>
    80002c90:	00060593          	mv	a1,a2
    80002c94:	0006861b          	sext.w	a2,a3
    80002c98:	00002097          	auipc	ra,0x2
    80002c9c:	c0c080e7          	jalr	-1012(ra) # 800048a4 <__memmove>
    80002ca0:	00813083          	ld	ra,8(sp)
    80002ca4:	00013403          	ld	s0,0(sp)
    80002ca8:	00000513          	li	a0,0
    80002cac:	01010113          	addi	sp,sp,16
    80002cb0:	00008067          	ret
    80002cb4:	00002517          	auipc	a0,0x2
    80002cb8:	4b450513          	addi	a0,a0,1204 # 80005168 <CONSOLE_STATUS+0x150>
    80002cbc:	00001097          	auipc	ra,0x1
    80002cc0:	8e0080e7          	jalr	-1824(ra) # 8000359c <panic>

0000000080002cc4 <trapinit>:
    80002cc4:	ff010113          	addi	sp,sp,-16
    80002cc8:	00813423          	sd	s0,8(sp)
    80002ccc:	01010413          	addi	s0,sp,16
    80002cd0:	00813403          	ld	s0,8(sp)
    80002cd4:	00002597          	auipc	a1,0x2
    80002cd8:	4bc58593          	addi	a1,a1,1212 # 80005190 <CONSOLE_STATUS+0x178>
    80002cdc:	00007517          	auipc	a0,0x7
    80002ce0:	aa450513          	addi	a0,a0,-1372 # 80009780 <tickslock>
    80002ce4:	01010113          	addi	sp,sp,16
    80002ce8:	00001317          	auipc	t1,0x1
    80002cec:	5c030067          	jr	1472(t1) # 800042a8 <initlock>

0000000080002cf0 <trapinithart>:
    80002cf0:	ff010113          	addi	sp,sp,-16
    80002cf4:	00813423          	sd	s0,8(sp)
    80002cf8:	01010413          	addi	s0,sp,16
    80002cfc:	00000797          	auipc	a5,0x0
    80002d00:	2f478793          	addi	a5,a5,756 # 80002ff0 <kernelvec>
    80002d04:	10579073          	csrw	stvec,a5
    80002d08:	00813403          	ld	s0,8(sp)
    80002d0c:	01010113          	addi	sp,sp,16
    80002d10:	00008067          	ret

0000000080002d14 <usertrap>:
    80002d14:	ff010113          	addi	sp,sp,-16
    80002d18:	00813423          	sd	s0,8(sp)
    80002d1c:	01010413          	addi	s0,sp,16
    80002d20:	00813403          	ld	s0,8(sp)
    80002d24:	01010113          	addi	sp,sp,16
    80002d28:	00008067          	ret

0000000080002d2c <usertrapret>:
    80002d2c:	ff010113          	addi	sp,sp,-16
    80002d30:	00813423          	sd	s0,8(sp)
    80002d34:	01010413          	addi	s0,sp,16
    80002d38:	00813403          	ld	s0,8(sp)
    80002d3c:	01010113          	addi	sp,sp,16
    80002d40:	00008067          	ret

0000000080002d44 <kerneltrap>:
    80002d44:	fe010113          	addi	sp,sp,-32
    80002d48:	00813823          	sd	s0,16(sp)
    80002d4c:	00113c23          	sd	ra,24(sp)
    80002d50:	00913423          	sd	s1,8(sp)
    80002d54:	02010413          	addi	s0,sp,32
    80002d58:	142025f3          	csrr	a1,scause
    80002d5c:	100027f3          	csrr	a5,sstatus
    80002d60:	0027f793          	andi	a5,a5,2
    80002d64:	10079c63          	bnez	a5,80002e7c <kerneltrap+0x138>
    80002d68:	142027f3          	csrr	a5,scause
    80002d6c:	0207ce63          	bltz	a5,80002da8 <kerneltrap+0x64>
    80002d70:	00002517          	auipc	a0,0x2
    80002d74:	46850513          	addi	a0,a0,1128 # 800051d8 <CONSOLE_STATUS+0x1c0>
    80002d78:	00001097          	auipc	ra,0x1
    80002d7c:	880080e7          	jalr	-1920(ra) # 800035f8 <__printf>
    80002d80:	141025f3          	csrr	a1,sepc
    80002d84:	14302673          	csrr	a2,stval
    80002d88:	00002517          	auipc	a0,0x2
    80002d8c:	46050513          	addi	a0,a0,1120 # 800051e8 <CONSOLE_STATUS+0x1d0>
    80002d90:	00001097          	auipc	ra,0x1
    80002d94:	868080e7          	jalr	-1944(ra) # 800035f8 <__printf>
    80002d98:	00002517          	auipc	a0,0x2
    80002d9c:	46850513          	addi	a0,a0,1128 # 80005200 <CONSOLE_STATUS+0x1e8>
    80002da0:	00000097          	auipc	ra,0x0
    80002da4:	7fc080e7          	jalr	2044(ra) # 8000359c <panic>
    80002da8:	0ff7f713          	andi	a4,a5,255
    80002dac:	00900693          	li	a3,9
    80002db0:	04d70063          	beq	a4,a3,80002df0 <kerneltrap+0xac>
    80002db4:	fff00713          	li	a4,-1
    80002db8:	03f71713          	slli	a4,a4,0x3f
    80002dbc:	00170713          	addi	a4,a4,1
    80002dc0:	fae798e3          	bne	a5,a4,80002d70 <kerneltrap+0x2c>
    80002dc4:	00000097          	auipc	ra,0x0
    80002dc8:	e00080e7          	jalr	-512(ra) # 80002bc4 <cpuid>
    80002dcc:	06050663          	beqz	a0,80002e38 <kerneltrap+0xf4>
    80002dd0:	144027f3          	csrr	a5,sip
    80002dd4:	ffd7f793          	andi	a5,a5,-3
    80002dd8:	14479073          	csrw	sip,a5
    80002ddc:	01813083          	ld	ra,24(sp)
    80002de0:	01013403          	ld	s0,16(sp)
    80002de4:	00813483          	ld	s1,8(sp)
    80002de8:	02010113          	addi	sp,sp,32
    80002dec:	00008067          	ret
    80002df0:	00000097          	auipc	ra,0x0
    80002df4:	3c4080e7          	jalr	964(ra) # 800031b4 <plic_claim>
    80002df8:	00a00793          	li	a5,10
    80002dfc:	00050493          	mv	s1,a0
    80002e00:	06f50863          	beq	a0,a5,80002e70 <kerneltrap+0x12c>
    80002e04:	fc050ce3          	beqz	a0,80002ddc <kerneltrap+0x98>
    80002e08:	00050593          	mv	a1,a0
    80002e0c:	00002517          	auipc	a0,0x2
    80002e10:	3ac50513          	addi	a0,a0,940 # 800051b8 <CONSOLE_STATUS+0x1a0>
    80002e14:	00000097          	auipc	ra,0x0
    80002e18:	7e4080e7          	jalr	2020(ra) # 800035f8 <__printf>
    80002e1c:	01013403          	ld	s0,16(sp)
    80002e20:	01813083          	ld	ra,24(sp)
    80002e24:	00048513          	mv	a0,s1
    80002e28:	00813483          	ld	s1,8(sp)
    80002e2c:	02010113          	addi	sp,sp,32
    80002e30:	00000317          	auipc	t1,0x0
    80002e34:	3bc30067          	jr	956(t1) # 800031ec <plic_complete>
    80002e38:	00007517          	auipc	a0,0x7
    80002e3c:	94850513          	addi	a0,a0,-1720 # 80009780 <tickslock>
    80002e40:	00001097          	auipc	ra,0x1
    80002e44:	48c080e7          	jalr	1164(ra) # 800042cc <acquire>
    80002e48:	00003717          	auipc	a4,0x3
    80002e4c:	83870713          	addi	a4,a4,-1992 # 80005680 <ticks>
    80002e50:	00072783          	lw	a5,0(a4)
    80002e54:	00007517          	auipc	a0,0x7
    80002e58:	92c50513          	addi	a0,a0,-1748 # 80009780 <tickslock>
    80002e5c:	0017879b          	addiw	a5,a5,1
    80002e60:	00f72023          	sw	a5,0(a4)
    80002e64:	00001097          	auipc	ra,0x1
    80002e68:	534080e7          	jalr	1332(ra) # 80004398 <release>
    80002e6c:	f65ff06f          	j	80002dd0 <kerneltrap+0x8c>
    80002e70:	00001097          	auipc	ra,0x1
    80002e74:	090080e7          	jalr	144(ra) # 80003f00 <uartintr>
    80002e78:	fa5ff06f          	j	80002e1c <kerneltrap+0xd8>
    80002e7c:	00002517          	auipc	a0,0x2
    80002e80:	31c50513          	addi	a0,a0,796 # 80005198 <CONSOLE_STATUS+0x180>
    80002e84:	00000097          	auipc	ra,0x0
    80002e88:	718080e7          	jalr	1816(ra) # 8000359c <panic>

0000000080002e8c <clockintr>:
    80002e8c:	fe010113          	addi	sp,sp,-32
    80002e90:	00813823          	sd	s0,16(sp)
    80002e94:	00913423          	sd	s1,8(sp)
    80002e98:	00113c23          	sd	ra,24(sp)
    80002e9c:	02010413          	addi	s0,sp,32
    80002ea0:	00007497          	auipc	s1,0x7
    80002ea4:	8e048493          	addi	s1,s1,-1824 # 80009780 <tickslock>
    80002ea8:	00048513          	mv	a0,s1
    80002eac:	00001097          	auipc	ra,0x1
    80002eb0:	420080e7          	jalr	1056(ra) # 800042cc <acquire>
    80002eb4:	00002717          	auipc	a4,0x2
    80002eb8:	7cc70713          	addi	a4,a4,1996 # 80005680 <ticks>
    80002ebc:	00072783          	lw	a5,0(a4)
    80002ec0:	01013403          	ld	s0,16(sp)
    80002ec4:	01813083          	ld	ra,24(sp)
    80002ec8:	00048513          	mv	a0,s1
    80002ecc:	0017879b          	addiw	a5,a5,1
    80002ed0:	00813483          	ld	s1,8(sp)
    80002ed4:	00f72023          	sw	a5,0(a4)
    80002ed8:	02010113          	addi	sp,sp,32
    80002edc:	00001317          	auipc	t1,0x1
    80002ee0:	4bc30067          	jr	1212(t1) # 80004398 <release>

0000000080002ee4 <devintr>:
    80002ee4:	142027f3          	csrr	a5,scause
    80002ee8:	00000513          	li	a0,0
    80002eec:	0007c463          	bltz	a5,80002ef4 <devintr+0x10>
    80002ef0:	00008067          	ret
    80002ef4:	fe010113          	addi	sp,sp,-32
    80002ef8:	00813823          	sd	s0,16(sp)
    80002efc:	00113c23          	sd	ra,24(sp)
    80002f00:	00913423          	sd	s1,8(sp)
    80002f04:	02010413          	addi	s0,sp,32
    80002f08:	0ff7f713          	andi	a4,a5,255
    80002f0c:	00900693          	li	a3,9
    80002f10:	04d70c63          	beq	a4,a3,80002f68 <devintr+0x84>
    80002f14:	fff00713          	li	a4,-1
    80002f18:	03f71713          	slli	a4,a4,0x3f
    80002f1c:	00170713          	addi	a4,a4,1
    80002f20:	00e78c63          	beq	a5,a4,80002f38 <devintr+0x54>
    80002f24:	01813083          	ld	ra,24(sp)
    80002f28:	01013403          	ld	s0,16(sp)
    80002f2c:	00813483          	ld	s1,8(sp)
    80002f30:	02010113          	addi	sp,sp,32
    80002f34:	00008067          	ret
    80002f38:	00000097          	auipc	ra,0x0
    80002f3c:	c8c080e7          	jalr	-884(ra) # 80002bc4 <cpuid>
    80002f40:	06050663          	beqz	a0,80002fac <devintr+0xc8>
    80002f44:	144027f3          	csrr	a5,sip
    80002f48:	ffd7f793          	andi	a5,a5,-3
    80002f4c:	14479073          	csrw	sip,a5
    80002f50:	01813083          	ld	ra,24(sp)
    80002f54:	01013403          	ld	s0,16(sp)
    80002f58:	00813483          	ld	s1,8(sp)
    80002f5c:	00200513          	li	a0,2
    80002f60:	02010113          	addi	sp,sp,32
    80002f64:	00008067          	ret
    80002f68:	00000097          	auipc	ra,0x0
    80002f6c:	24c080e7          	jalr	588(ra) # 800031b4 <plic_claim>
    80002f70:	00a00793          	li	a5,10
    80002f74:	00050493          	mv	s1,a0
    80002f78:	06f50663          	beq	a0,a5,80002fe4 <devintr+0x100>
    80002f7c:	00100513          	li	a0,1
    80002f80:	fa0482e3          	beqz	s1,80002f24 <devintr+0x40>
    80002f84:	00048593          	mv	a1,s1
    80002f88:	00002517          	auipc	a0,0x2
    80002f8c:	23050513          	addi	a0,a0,560 # 800051b8 <CONSOLE_STATUS+0x1a0>
    80002f90:	00000097          	auipc	ra,0x0
    80002f94:	668080e7          	jalr	1640(ra) # 800035f8 <__printf>
    80002f98:	00048513          	mv	a0,s1
    80002f9c:	00000097          	auipc	ra,0x0
    80002fa0:	250080e7          	jalr	592(ra) # 800031ec <plic_complete>
    80002fa4:	00100513          	li	a0,1
    80002fa8:	f7dff06f          	j	80002f24 <devintr+0x40>
    80002fac:	00006517          	auipc	a0,0x6
    80002fb0:	7d450513          	addi	a0,a0,2004 # 80009780 <tickslock>
    80002fb4:	00001097          	auipc	ra,0x1
    80002fb8:	318080e7          	jalr	792(ra) # 800042cc <acquire>
    80002fbc:	00002717          	auipc	a4,0x2
    80002fc0:	6c470713          	addi	a4,a4,1732 # 80005680 <ticks>
    80002fc4:	00072783          	lw	a5,0(a4)
    80002fc8:	00006517          	auipc	a0,0x6
    80002fcc:	7b850513          	addi	a0,a0,1976 # 80009780 <tickslock>
    80002fd0:	0017879b          	addiw	a5,a5,1
    80002fd4:	00f72023          	sw	a5,0(a4)
    80002fd8:	00001097          	auipc	ra,0x1
    80002fdc:	3c0080e7          	jalr	960(ra) # 80004398 <release>
    80002fe0:	f65ff06f          	j	80002f44 <devintr+0x60>
    80002fe4:	00001097          	auipc	ra,0x1
    80002fe8:	f1c080e7          	jalr	-228(ra) # 80003f00 <uartintr>
    80002fec:	fadff06f          	j	80002f98 <devintr+0xb4>

0000000080002ff0 <kernelvec>:
    80002ff0:	f0010113          	addi	sp,sp,-256
    80002ff4:	00113023          	sd	ra,0(sp)
    80002ff8:	00213423          	sd	sp,8(sp)
    80002ffc:	00313823          	sd	gp,16(sp)
    80003000:	00413c23          	sd	tp,24(sp)
    80003004:	02513023          	sd	t0,32(sp)
    80003008:	02613423          	sd	t1,40(sp)
    8000300c:	02713823          	sd	t2,48(sp)
    80003010:	02813c23          	sd	s0,56(sp)
    80003014:	04913023          	sd	s1,64(sp)
    80003018:	04a13423          	sd	a0,72(sp)
    8000301c:	04b13823          	sd	a1,80(sp)
    80003020:	04c13c23          	sd	a2,88(sp)
    80003024:	06d13023          	sd	a3,96(sp)
    80003028:	06e13423          	sd	a4,104(sp)
    8000302c:	06f13823          	sd	a5,112(sp)
    80003030:	07013c23          	sd	a6,120(sp)
    80003034:	09113023          	sd	a7,128(sp)
    80003038:	09213423          	sd	s2,136(sp)
    8000303c:	09313823          	sd	s3,144(sp)
    80003040:	09413c23          	sd	s4,152(sp)
    80003044:	0b513023          	sd	s5,160(sp)
    80003048:	0b613423          	sd	s6,168(sp)
    8000304c:	0b713823          	sd	s7,176(sp)
    80003050:	0b813c23          	sd	s8,184(sp)
    80003054:	0d913023          	sd	s9,192(sp)
    80003058:	0da13423          	sd	s10,200(sp)
    8000305c:	0db13823          	sd	s11,208(sp)
    80003060:	0dc13c23          	sd	t3,216(sp)
    80003064:	0fd13023          	sd	t4,224(sp)
    80003068:	0fe13423          	sd	t5,232(sp)
    8000306c:	0ff13823          	sd	t6,240(sp)
    80003070:	cd5ff0ef          	jal	ra,80002d44 <kerneltrap>
    80003074:	00013083          	ld	ra,0(sp)
    80003078:	00813103          	ld	sp,8(sp)
    8000307c:	01013183          	ld	gp,16(sp)
    80003080:	02013283          	ld	t0,32(sp)
    80003084:	02813303          	ld	t1,40(sp)
    80003088:	03013383          	ld	t2,48(sp)
    8000308c:	03813403          	ld	s0,56(sp)
    80003090:	04013483          	ld	s1,64(sp)
    80003094:	04813503          	ld	a0,72(sp)
    80003098:	05013583          	ld	a1,80(sp)
    8000309c:	05813603          	ld	a2,88(sp)
    800030a0:	06013683          	ld	a3,96(sp)
    800030a4:	06813703          	ld	a4,104(sp)
    800030a8:	07013783          	ld	a5,112(sp)
    800030ac:	07813803          	ld	a6,120(sp)
    800030b0:	08013883          	ld	a7,128(sp)
    800030b4:	08813903          	ld	s2,136(sp)
    800030b8:	09013983          	ld	s3,144(sp)
    800030bc:	09813a03          	ld	s4,152(sp)
    800030c0:	0a013a83          	ld	s5,160(sp)
    800030c4:	0a813b03          	ld	s6,168(sp)
    800030c8:	0b013b83          	ld	s7,176(sp)
    800030cc:	0b813c03          	ld	s8,184(sp)
    800030d0:	0c013c83          	ld	s9,192(sp)
    800030d4:	0c813d03          	ld	s10,200(sp)
    800030d8:	0d013d83          	ld	s11,208(sp)
    800030dc:	0d813e03          	ld	t3,216(sp)
    800030e0:	0e013e83          	ld	t4,224(sp)
    800030e4:	0e813f03          	ld	t5,232(sp)
    800030e8:	0f013f83          	ld	t6,240(sp)
    800030ec:	10010113          	addi	sp,sp,256
    800030f0:	10200073          	sret
    800030f4:	00000013          	nop
    800030f8:	00000013          	nop
    800030fc:	00000013          	nop

0000000080003100 <timervec>:
    80003100:	34051573          	csrrw	a0,mscratch,a0
    80003104:	00b53023          	sd	a1,0(a0)
    80003108:	00c53423          	sd	a2,8(a0)
    8000310c:	00d53823          	sd	a3,16(a0)
    80003110:	01853583          	ld	a1,24(a0)
    80003114:	02053603          	ld	a2,32(a0)
    80003118:	0005b683          	ld	a3,0(a1)
    8000311c:	00c686b3          	add	a3,a3,a2
    80003120:	00d5b023          	sd	a3,0(a1)
    80003124:	00200593          	li	a1,2
    80003128:	14459073          	csrw	sip,a1
    8000312c:	01053683          	ld	a3,16(a0)
    80003130:	00853603          	ld	a2,8(a0)
    80003134:	00053583          	ld	a1,0(a0)
    80003138:	34051573          	csrrw	a0,mscratch,a0
    8000313c:	30200073          	mret

0000000080003140 <plicinit>:
    80003140:	ff010113          	addi	sp,sp,-16
    80003144:	00813423          	sd	s0,8(sp)
    80003148:	01010413          	addi	s0,sp,16
    8000314c:	00813403          	ld	s0,8(sp)
    80003150:	0c0007b7          	lui	a5,0xc000
    80003154:	00100713          	li	a4,1
    80003158:	02e7a423          	sw	a4,40(a5) # c000028 <_entry-0x73ffffd8>
    8000315c:	00e7a223          	sw	a4,4(a5)
    80003160:	01010113          	addi	sp,sp,16
    80003164:	00008067          	ret

0000000080003168 <plicinithart>:
    80003168:	ff010113          	addi	sp,sp,-16
    8000316c:	00813023          	sd	s0,0(sp)
    80003170:	00113423          	sd	ra,8(sp)
    80003174:	01010413          	addi	s0,sp,16
    80003178:	00000097          	auipc	ra,0x0
    8000317c:	a4c080e7          	jalr	-1460(ra) # 80002bc4 <cpuid>
    80003180:	0085171b          	slliw	a4,a0,0x8
    80003184:	0c0027b7          	lui	a5,0xc002
    80003188:	00e787b3          	add	a5,a5,a4
    8000318c:	40200713          	li	a4,1026
    80003190:	08e7a023          	sw	a4,128(a5) # c002080 <_entry-0x73ffdf80>
    80003194:	00813083          	ld	ra,8(sp)
    80003198:	00013403          	ld	s0,0(sp)
    8000319c:	00d5151b          	slliw	a0,a0,0xd
    800031a0:	0c2017b7          	lui	a5,0xc201
    800031a4:	00a78533          	add	a0,a5,a0
    800031a8:	00052023          	sw	zero,0(a0)
    800031ac:	01010113          	addi	sp,sp,16
    800031b0:	00008067          	ret

00000000800031b4 <plic_claim>:
    800031b4:	ff010113          	addi	sp,sp,-16
    800031b8:	00813023          	sd	s0,0(sp)
    800031bc:	00113423          	sd	ra,8(sp)
    800031c0:	01010413          	addi	s0,sp,16
    800031c4:	00000097          	auipc	ra,0x0
    800031c8:	a00080e7          	jalr	-1536(ra) # 80002bc4 <cpuid>
    800031cc:	00813083          	ld	ra,8(sp)
    800031d0:	00013403          	ld	s0,0(sp)
    800031d4:	00d5151b          	slliw	a0,a0,0xd
    800031d8:	0c2017b7          	lui	a5,0xc201
    800031dc:	00a78533          	add	a0,a5,a0
    800031e0:	00452503          	lw	a0,4(a0)
    800031e4:	01010113          	addi	sp,sp,16
    800031e8:	00008067          	ret

00000000800031ec <plic_complete>:
    800031ec:	fe010113          	addi	sp,sp,-32
    800031f0:	00813823          	sd	s0,16(sp)
    800031f4:	00913423          	sd	s1,8(sp)
    800031f8:	00113c23          	sd	ra,24(sp)
    800031fc:	02010413          	addi	s0,sp,32
    80003200:	00050493          	mv	s1,a0
    80003204:	00000097          	auipc	ra,0x0
    80003208:	9c0080e7          	jalr	-1600(ra) # 80002bc4 <cpuid>
    8000320c:	01813083          	ld	ra,24(sp)
    80003210:	01013403          	ld	s0,16(sp)
    80003214:	00d5179b          	slliw	a5,a0,0xd
    80003218:	0c201737          	lui	a4,0xc201
    8000321c:	00f707b3          	add	a5,a4,a5
    80003220:	0097a223          	sw	s1,4(a5) # c201004 <_entry-0x73dfeffc>
    80003224:	00813483          	ld	s1,8(sp)
    80003228:	02010113          	addi	sp,sp,32
    8000322c:	00008067          	ret

0000000080003230 <consolewrite>:
    80003230:	fb010113          	addi	sp,sp,-80
    80003234:	04813023          	sd	s0,64(sp)
    80003238:	04113423          	sd	ra,72(sp)
    8000323c:	02913c23          	sd	s1,56(sp)
    80003240:	03213823          	sd	s2,48(sp)
    80003244:	03313423          	sd	s3,40(sp)
    80003248:	03413023          	sd	s4,32(sp)
    8000324c:	01513c23          	sd	s5,24(sp)
    80003250:	05010413          	addi	s0,sp,80
    80003254:	06c05c63          	blez	a2,800032cc <consolewrite+0x9c>
    80003258:	00060993          	mv	s3,a2
    8000325c:	00050a13          	mv	s4,a0
    80003260:	00058493          	mv	s1,a1
    80003264:	00000913          	li	s2,0
    80003268:	fff00a93          	li	s5,-1
    8000326c:	01c0006f          	j	80003288 <consolewrite+0x58>
    80003270:	fbf44503          	lbu	a0,-65(s0)
    80003274:	0019091b          	addiw	s2,s2,1
    80003278:	00148493          	addi	s1,s1,1
    8000327c:	00001097          	auipc	ra,0x1
    80003280:	a9c080e7          	jalr	-1380(ra) # 80003d18 <uartputc>
    80003284:	03298063          	beq	s3,s2,800032a4 <consolewrite+0x74>
    80003288:	00048613          	mv	a2,s1
    8000328c:	00100693          	li	a3,1
    80003290:	000a0593          	mv	a1,s4
    80003294:	fbf40513          	addi	a0,s0,-65
    80003298:	00000097          	auipc	ra,0x0
    8000329c:	9e4080e7          	jalr	-1564(ra) # 80002c7c <either_copyin>
    800032a0:	fd5518e3          	bne	a0,s5,80003270 <consolewrite+0x40>
    800032a4:	04813083          	ld	ra,72(sp)
    800032a8:	04013403          	ld	s0,64(sp)
    800032ac:	03813483          	ld	s1,56(sp)
    800032b0:	02813983          	ld	s3,40(sp)
    800032b4:	02013a03          	ld	s4,32(sp)
    800032b8:	01813a83          	ld	s5,24(sp)
    800032bc:	00090513          	mv	a0,s2
    800032c0:	03013903          	ld	s2,48(sp)
    800032c4:	05010113          	addi	sp,sp,80
    800032c8:	00008067          	ret
    800032cc:	00000913          	li	s2,0
    800032d0:	fd5ff06f          	j	800032a4 <consolewrite+0x74>

00000000800032d4 <consoleread>:
    800032d4:	f9010113          	addi	sp,sp,-112
    800032d8:	06813023          	sd	s0,96(sp)
    800032dc:	04913c23          	sd	s1,88(sp)
    800032e0:	05213823          	sd	s2,80(sp)
    800032e4:	05313423          	sd	s3,72(sp)
    800032e8:	05413023          	sd	s4,64(sp)
    800032ec:	03513c23          	sd	s5,56(sp)
    800032f0:	03613823          	sd	s6,48(sp)
    800032f4:	03713423          	sd	s7,40(sp)
    800032f8:	03813023          	sd	s8,32(sp)
    800032fc:	06113423          	sd	ra,104(sp)
    80003300:	01913c23          	sd	s9,24(sp)
    80003304:	07010413          	addi	s0,sp,112
    80003308:	00060b93          	mv	s7,a2
    8000330c:	00050913          	mv	s2,a0
    80003310:	00058c13          	mv	s8,a1
    80003314:	00060b1b          	sext.w	s6,a2
    80003318:	00006497          	auipc	s1,0x6
    8000331c:	49048493          	addi	s1,s1,1168 # 800097a8 <cons>
    80003320:	00400993          	li	s3,4
    80003324:	fff00a13          	li	s4,-1
    80003328:	00a00a93          	li	s5,10
    8000332c:	05705e63          	blez	s7,80003388 <consoleread+0xb4>
    80003330:	09c4a703          	lw	a4,156(s1)
    80003334:	0984a783          	lw	a5,152(s1)
    80003338:	0007071b          	sext.w	a4,a4
    8000333c:	08e78463          	beq	a5,a4,800033c4 <consoleread+0xf0>
    80003340:	07f7f713          	andi	a4,a5,127
    80003344:	00e48733          	add	a4,s1,a4
    80003348:	01874703          	lbu	a4,24(a4) # c201018 <_entry-0x73dfefe8>
    8000334c:	0017869b          	addiw	a3,a5,1
    80003350:	08d4ac23          	sw	a3,152(s1)
    80003354:	00070c9b          	sext.w	s9,a4
    80003358:	0b370663          	beq	a4,s3,80003404 <consoleread+0x130>
    8000335c:	00100693          	li	a3,1
    80003360:	f9f40613          	addi	a2,s0,-97
    80003364:	000c0593          	mv	a1,s8
    80003368:	00090513          	mv	a0,s2
    8000336c:	f8e40fa3          	sb	a4,-97(s0)
    80003370:	00000097          	auipc	ra,0x0
    80003374:	8c0080e7          	jalr	-1856(ra) # 80002c30 <either_copyout>
    80003378:	01450863          	beq	a0,s4,80003388 <consoleread+0xb4>
    8000337c:	001c0c13          	addi	s8,s8,1
    80003380:	fffb8b9b          	addiw	s7,s7,-1
    80003384:	fb5c94e3          	bne	s9,s5,8000332c <consoleread+0x58>
    80003388:	000b851b          	sext.w	a0,s7
    8000338c:	06813083          	ld	ra,104(sp)
    80003390:	06013403          	ld	s0,96(sp)
    80003394:	05813483          	ld	s1,88(sp)
    80003398:	05013903          	ld	s2,80(sp)
    8000339c:	04813983          	ld	s3,72(sp)
    800033a0:	04013a03          	ld	s4,64(sp)
    800033a4:	03813a83          	ld	s5,56(sp)
    800033a8:	02813b83          	ld	s7,40(sp)
    800033ac:	02013c03          	ld	s8,32(sp)
    800033b0:	01813c83          	ld	s9,24(sp)
    800033b4:	40ab053b          	subw	a0,s6,a0
    800033b8:	03013b03          	ld	s6,48(sp)
    800033bc:	07010113          	addi	sp,sp,112
    800033c0:	00008067          	ret
    800033c4:	00001097          	auipc	ra,0x1
    800033c8:	1d8080e7          	jalr	472(ra) # 8000459c <push_on>
    800033cc:	0984a703          	lw	a4,152(s1)
    800033d0:	09c4a783          	lw	a5,156(s1)
    800033d4:	0007879b          	sext.w	a5,a5
    800033d8:	fef70ce3          	beq	a4,a5,800033d0 <consoleread+0xfc>
    800033dc:	00001097          	auipc	ra,0x1
    800033e0:	234080e7          	jalr	564(ra) # 80004610 <pop_on>
    800033e4:	0984a783          	lw	a5,152(s1)
    800033e8:	07f7f713          	andi	a4,a5,127
    800033ec:	00e48733          	add	a4,s1,a4
    800033f0:	01874703          	lbu	a4,24(a4)
    800033f4:	0017869b          	addiw	a3,a5,1
    800033f8:	08d4ac23          	sw	a3,152(s1)
    800033fc:	00070c9b          	sext.w	s9,a4
    80003400:	f5371ee3          	bne	a4,s3,8000335c <consoleread+0x88>
    80003404:	000b851b          	sext.w	a0,s7
    80003408:	f96bf2e3          	bgeu	s7,s6,8000338c <consoleread+0xb8>
    8000340c:	08f4ac23          	sw	a5,152(s1)
    80003410:	f7dff06f          	j	8000338c <consoleread+0xb8>

0000000080003414 <consputc>:
    80003414:	10000793          	li	a5,256
    80003418:	00f50663          	beq	a0,a5,80003424 <consputc+0x10>
    8000341c:	00001317          	auipc	t1,0x1
    80003420:	9f430067          	jr	-1548(t1) # 80003e10 <uartputc_sync>
    80003424:	ff010113          	addi	sp,sp,-16
    80003428:	00113423          	sd	ra,8(sp)
    8000342c:	00813023          	sd	s0,0(sp)
    80003430:	01010413          	addi	s0,sp,16
    80003434:	00800513          	li	a0,8
    80003438:	00001097          	auipc	ra,0x1
    8000343c:	9d8080e7          	jalr	-1576(ra) # 80003e10 <uartputc_sync>
    80003440:	02000513          	li	a0,32
    80003444:	00001097          	auipc	ra,0x1
    80003448:	9cc080e7          	jalr	-1588(ra) # 80003e10 <uartputc_sync>
    8000344c:	00013403          	ld	s0,0(sp)
    80003450:	00813083          	ld	ra,8(sp)
    80003454:	00800513          	li	a0,8
    80003458:	01010113          	addi	sp,sp,16
    8000345c:	00001317          	auipc	t1,0x1
    80003460:	9b430067          	jr	-1612(t1) # 80003e10 <uartputc_sync>

0000000080003464 <consoleintr>:
    80003464:	fe010113          	addi	sp,sp,-32
    80003468:	00813823          	sd	s0,16(sp)
    8000346c:	00913423          	sd	s1,8(sp)
    80003470:	01213023          	sd	s2,0(sp)
    80003474:	00113c23          	sd	ra,24(sp)
    80003478:	02010413          	addi	s0,sp,32
    8000347c:	00006917          	auipc	s2,0x6
    80003480:	32c90913          	addi	s2,s2,812 # 800097a8 <cons>
    80003484:	00050493          	mv	s1,a0
    80003488:	00090513          	mv	a0,s2
    8000348c:	00001097          	auipc	ra,0x1
    80003490:	e40080e7          	jalr	-448(ra) # 800042cc <acquire>
    80003494:	02048c63          	beqz	s1,800034cc <consoleintr+0x68>
    80003498:	0a092783          	lw	a5,160(s2)
    8000349c:	09892703          	lw	a4,152(s2)
    800034a0:	07f00693          	li	a3,127
    800034a4:	40e7873b          	subw	a4,a5,a4
    800034a8:	02e6e263          	bltu	a3,a4,800034cc <consoleintr+0x68>
    800034ac:	00d00713          	li	a4,13
    800034b0:	04e48063          	beq	s1,a4,800034f0 <consoleintr+0x8c>
    800034b4:	07f7f713          	andi	a4,a5,127
    800034b8:	00e90733          	add	a4,s2,a4
    800034bc:	0017879b          	addiw	a5,a5,1
    800034c0:	0af92023          	sw	a5,160(s2)
    800034c4:	00970c23          	sb	s1,24(a4)
    800034c8:	08f92e23          	sw	a5,156(s2)
    800034cc:	01013403          	ld	s0,16(sp)
    800034d0:	01813083          	ld	ra,24(sp)
    800034d4:	00813483          	ld	s1,8(sp)
    800034d8:	00013903          	ld	s2,0(sp)
    800034dc:	00006517          	auipc	a0,0x6
    800034e0:	2cc50513          	addi	a0,a0,716 # 800097a8 <cons>
    800034e4:	02010113          	addi	sp,sp,32
    800034e8:	00001317          	auipc	t1,0x1
    800034ec:	eb030067          	jr	-336(t1) # 80004398 <release>
    800034f0:	00a00493          	li	s1,10
    800034f4:	fc1ff06f          	j	800034b4 <consoleintr+0x50>

00000000800034f8 <consoleinit>:
    800034f8:	fe010113          	addi	sp,sp,-32
    800034fc:	00113c23          	sd	ra,24(sp)
    80003500:	00813823          	sd	s0,16(sp)
    80003504:	00913423          	sd	s1,8(sp)
    80003508:	02010413          	addi	s0,sp,32
    8000350c:	00006497          	auipc	s1,0x6
    80003510:	29c48493          	addi	s1,s1,668 # 800097a8 <cons>
    80003514:	00048513          	mv	a0,s1
    80003518:	00002597          	auipc	a1,0x2
    8000351c:	cf858593          	addi	a1,a1,-776 # 80005210 <CONSOLE_STATUS+0x1f8>
    80003520:	00001097          	auipc	ra,0x1
    80003524:	d88080e7          	jalr	-632(ra) # 800042a8 <initlock>
    80003528:	00000097          	auipc	ra,0x0
    8000352c:	7ac080e7          	jalr	1964(ra) # 80003cd4 <uartinit>
    80003530:	01813083          	ld	ra,24(sp)
    80003534:	01013403          	ld	s0,16(sp)
    80003538:	00000797          	auipc	a5,0x0
    8000353c:	d9c78793          	addi	a5,a5,-612 # 800032d4 <consoleread>
    80003540:	0af4bc23          	sd	a5,184(s1)
    80003544:	00000797          	auipc	a5,0x0
    80003548:	cec78793          	addi	a5,a5,-788 # 80003230 <consolewrite>
    8000354c:	0cf4b023          	sd	a5,192(s1)
    80003550:	00813483          	ld	s1,8(sp)
    80003554:	02010113          	addi	sp,sp,32
    80003558:	00008067          	ret

000000008000355c <console_read>:
    8000355c:	ff010113          	addi	sp,sp,-16
    80003560:	00813423          	sd	s0,8(sp)
    80003564:	01010413          	addi	s0,sp,16
    80003568:	00813403          	ld	s0,8(sp)
    8000356c:	00006317          	auipc	t1,0x6
    80003570:	2f433303          	ld	t1,756(t1) # 80009860 <devsw+0x10>
    80003574:	01010113          	addi	sp,sp,16
    80003578:	00030067          	jr	t1

000000008000357c <console_write>:
    8000357c:	ff010113          	addi	sp,sp,-16
    80003580:	00813423          	sd	s0,8(sp)
    80003584:	01010413          	addi	s0,sp,16
    80003588:	00813403          	ld	s0,8(sp)
    8000358c:	00006317          	auipc	t1,0x6
    80003590:	2dc33303          	ld	t1,732(t1) # 80009868 <devsw+0x18>
    80003594:	01010113          	addi	sp,sp,16
    80003598:	00030067          	jr	t1

000000008000359c <panic>:
    8000359c:	fe010113          	addi	sp,sp,-32
    800035a0:	00113c23          	sd	ra,24(sp)
    800035a4:	00813823          	sd	s0,16(sp)
    800035a8:	00913423          	sd	s1,8(sp)
    800035ac:	02010413          	addi	s0,sp,32
    800035b0:	00050493          	mv	s1,a0
    800035b4:	00002517          	auipc	a0,0x2
    800035b8:	c6450513          	addi	a0,a0,-924 # 80005218 <CONSOLE_STATUS+0x200>
    800035bc:	00006797          	auipc	a5,0x6
    800035c0:	3407a623          	sw	zero,844(a5) # 80009908 <pr+0x18>
    800035c4:	00000097          	auipc	ra,0x0
    800035c8:	034080e7          	jalr	52(ra) # 800035f8 <__printf>
    800035cc:	00048513          	mv	a0,s1
    800035d0:	00000097          	auipc	ra,0x0
    800035d4:	028080e7          	jalr	40(ra) # 800035f8 <__printf>
    800035d8:	00002517          	auipc	a0,0x2
    800035dc:	c2050513          	addi	a0,a0,-992 # 800051f8 <CONSOLE_STATUS+0x1e0>
    800035e0:	00000097          	auipc	ra,0x0
    800035e4:	018080e7          	jalr	24(ra) # 800035f8 <__printf>
    800035e8:	00100793          	li	a5,1
    800035ec:	00002717          	auipc	a4,0x2
    800035f0:	08f72c23          	sw	a5,152(a4) # 80005684 <panicked>
    800035f4:	0000006f          	j	800035f4 <panic+0x58>

00000000800035f8 <__printf>:
    800035f8:	f3010113          	addi	sp,sp,-208
    800035fc:	08813023          	sd	s0,128(sp)
    80003600:	07313423          	sd	s3,104(sp)
    80003604:	09010413          	addi	s0,sp,144
    80003608:	05813023          	sd	s8,64(sp)
    8000360c:	08113423          	sd	ra,136(sp)
    80003610:	06913c23          	sd	s1,120(sp)
    80003614:	07213823          	sd	s2,112(sp)
    80003618:	07413023          	sd	s4,96(sp)
    8000361c:	05513c23          	sd	s5,88(sp)
    80003620:	05613823          	sd	s6,80(sp)
    80003624:	05713423          	sd	s7,72(sp)
    80003628:	03913c23          	sd	s9,56(sp)
    8000362c:	03a13823          	sd	s10,48(sp)
    80003630:	03b13423          	sd	s11,40(sp)
    80003634:	00006317          	auipc	t1,0x6
    80003638:	2bc30313          	addi	t1,t1,700 # 800098f0 <pr>
    8000363c:	01832c03          	lw	s8,24(t1)
    80003640:	00b43423          	sd	a1,8(s0)
    80003644:	00c43823          	sd	a2,16(s0)
    80003648:	00d43c23          	sd	a3,24(s0)
    8000364c:	02e43023          	sd	a4,32(s0)
    80003650:	02f43423          	sd	a5,40(s0)
    80003654:	03043823          	sd	a6,48(s0)
    80003658:	03143c23          	sd	a7,56(s0)
    8000365c:	00050993          	mv	s3,a0
    80003660:	4a0c1663          	bnez	s8,80003b0c <__printf+0x514>
    80003664:	60098c63          	beqz	s3,80003c7c <__printf+0x684>
    80003668:	0009c503          	lbu	a0,0(s3)
    8000366c:	00840793          	addi	a5,s0,8
    80003670:	f6f43c23          	sd	a5,-136(s0)
    80003674:	00000493          	li	s1,0
    80003678:	22050063          	beqz	a0,80003898 <__printf+0x2a0>
    8000367c:	00002a37          	lui	s4,0x2
    80003680:	00018ab7          	lui	s5,0x18
    80003684:	000f4b37          	lui	s6,0xf4
    80003688:	00989bb7          	lui	s7,0x989
    8000368c:	70fa0a13          	addi	s4,s4,1807 # 270f <_entry-0x7fffd8f1>
    80003690:	69fa8a93          	addi	s5,s5,1695 # 1869f <_entry-0x7ffe7961>
    80003694:	23fb0b13          	addi	s6,s6,575 # f423f <_entry-0x7ff0bdc1>
    80003698:	67fb8b93          	addi	s7,s7,1663 # 98967f <_entry-0x7f676981>
    8000369c:	00148c9b          	addiw	s9,s1,1
    800036a0:	02500793          	li	a5,37
    800036a4:	01998933          	add	s2,s3,s9
    800036a8:	38f51263          	bne	a0,a5,80003a2c <__printf+0x434>
    800036ac:	00094783          	lbu	a5,0(s2)
    800036b0:	00078c9b          	sext.w	s9,a5
    800036b4:	1e078263          	beqz	a5,80003898 <__printf+0x2a0>
    800036b8:	0024849b          	addiw	s1,s1,2
    800036bc:	07000713          	li	a4,112
    800036c0:	00998933          	add	s2,s3,s1
    800036c4:	38e78a63          	beq	a5,a4,80003a58 <__printf+0x460>
    800036c8:	20f76863          	bltu	a4,a5,800038d8 <__printf+0x2e0>
    800036cc:	42a78863          	beq	a5,a0,80003afc <__printf+0x504>
    800036d0:	06400713          	li	a4,100
    800036d4:	40e79663          	bne	a5,a4,80003ae0 <__printf+0x4e8>
    800036d8:	f7843783          	ld	a5,-136(s0)
    800036dc:	0007a603          	lw	a2,0(a5)
    800036e0:	00878793          	addi	a5,a5,8
    800036e4:	f6f43c23          	sd	a5,-136(s0)
    800036e8:	42064a63          	bltz	a2,80003b1c <__printf+0x524>
    800036ec:	00a00713          	li	a4,10
    800036f0:	02e677bb          	remuw	a5,a2,a4
    800036f4:	00002d97          	auipc	s11,0x2
    800036f8:	b4cd8d93          	addi	s11,s11,-1204 # 80005240 <digits>
    800036fc:	00900593          	li	a1,9
    80003700:	0006051b          	sext.w	a0,a2
    80003704:	00000c93          	li	s9,0
    80003708:	02079793          	slli	a5,a5,0x20
    8000370c:	0207d793          	srli	a5,a5,0x20
    80003710:	00fd87b3          	add	a5,s11,a5
    80003714:	0007c783          	lbu	a5,0(a5)
    80003718:	02e656bb          	divuw	a3,a2,a4
    8000371c:	f8f40023          	sb	a5,-128(s0)
    80003720:	14c5d863          	bge	a1,a2,80003870 <__printf+0x278>
    80003724:	06300593          	li	a1,99
    80003728:	00100c93          	li	s9,1
    8000372c:	02e6f7bb          	remuw	a5,a3,a4
    80003730:	02079793          	slli	a5,a5,0x20
    80003734:	0207d793          	srli	a5,a5,0x20
    80003738:	00fd87b3          	add	a5,s11,a5
    8000373c:	0007c783          	lbu	a5,0(a5)
    80003740:	02e6d73b          	divuw	a4,a3,a4
    80003744:	f8f400a3          	sb	a5,-127(s0)
    80003748:	12a5f463          	bgeu	a1,a0,80003870 <__printf+0x278>
    8000374c:	00a00693          	li	a3,10
    80003750:	00900593          	li	a1,9
    80003754:	02d777bb          	remuw	a5,a4,a3
    80003758:	02079793          	slli	a5,a5,0x20
    8000375c:	0207d793          	srli	a5,a5,0x20
    80003760:	00fd87b3          	add	a5,s11,a5
    80003764:	0007c503          	lbu	a0,0(a5)
    80003768:	02d757bb          	divuw	a5,a4,a3
    8000376c:	f8a40123          	sb	a0,-126(s0)
    80003770:	48e5f263          	bgeu	a1,a4,80003bf4 <__printf+0x5fc>
    80003774:	06300513          	li	a0,99
    80003778:	02d7f5bb          	remuw	a1,a5,a3
    8000377c:	02059593          	slli	a1,a1,0x20
    80003780:	0205d593          	srli	a1,a1,0x20
    80003784:	00bd85b3          	add	a1,s11,a1
    80003788:	0005c583          	lbu	a1,0(a1)
    8000378c:	02d7d7bb          	divuw	a5,a5,a3
    80003790:	f8b401a3          	sb	a1,-125(s0)
    80003794:	48e57263          	bgeu	a0,a4,80003c18 <__printf+0x620>
    80003798:	3e700513          	li	a0,999
    8000379c:	02d7f5bb          	remuw	a1,a5,a3
    800037a0:	02059593          	slli	a1,a1,0x20
    800037a4:	0205d593          	srli	a1,a1,0x20
    800037a8:	00bd85b3          	add	a1,s11,a1
    800037ac:	0005c583          	lbu	a1,0(a1)
    800037b0:	02d7d7bb          	divuw	a5,a5,a3
    800037b4:	f8b40223          	sb	a1,-124(s0)
    800037b8:	46e57663          	bgeu	a0,a4,80003c24 <__printf+0x62c>
    800037bc:	02d7f5bb          	remuw	a1,a5,a3
    800037c0:	02059593          	slli	a1,a1,0x20
    800037c4:	0205d593          	srli	a1,a1,0x20
    800037c8:	00bd85b3          	add	a1,s11,a1
    800037cc:	0005c583          	lbu	a1,0(a1)
    800037d0:	02d7d7bb          	divuw	a5,a5,a3
    800037d4:	f8b402a3          	sb	a1,-123(s0)
    800037d8:	46ea7863          	bgeu	s4,a4,80003c48 <__printf+0x650>
    800037dc:	02d7f5bb          	remuw	a1,a5,a3
    800037e0:	02059593          	slli	a1,a1,0x20
    800037e4:	0205d593          	srli	a1,a1,0x20
    800037e8:	00bd85b3          	add	a1,s11,a1
    800037ec:	0005c583          	lbu	a1,0(a1)
    800037f0:	02d7d7bb          	divuw	a5,a5,a3
    800037f4:	f8b40323          	sb	a1,-122(s0)
    800037f8:	3eeaf863          	bgeu	s5,a4,80003be8 <__printf+0x5f0>
    800037fc:	02d7f5bb          	remuw	a1,a5,a3
    80003800:	02059593          	slli	a1,a1,0x20
    80003804:	0205d593          	srli	a1,a1,0x20
    80003808:	00bd85b3          	add	a1,s11,a1
    8000380c:	0005c583          	lbu	a1,0(a1)
    80003810:	02d7d7bb          	divuw	a5,a5,a3
    80003814:	f8b403a3          	sb	a1,-121(s0)
    80003818:	42eb7e63          	bgeu	s6,a4,80003c54 <__printf+0x65c>
    8000381c:	02d7f5bb          	remuw	a1,a5,a3
    80003820:	02059593          	slli	a1,a1,0x20
    80003824:	0205d593          	srli	a1,a1,0x20
    80003828:	00bd85b3          	add	a1,s11,a1
    8000382c:	0005c583          	lbu	a1,0(a1)
    80003830:	02d7d7bb          	divuw	a5,a5,a3
    80003834:	f8b40423          	sb	a1,-120(s0)
    80003838:	42ebfc63          	bgeu	s7,a4,80003c70 <__printf+0x678>
    8000383c:	02079793          	slli	a5,a5,0x20
    80003840:	0207d793          	srli	a5,a5,0x20
    80003844:	00fd8db3          	add	s11,s11,a5
    80003848:	000dc703          	lbu	a4,0(s11)
    8000384c:	00a00793          	li	a5,10
    80003850:	00900c93          	li	s9,9
    80003854:	f8e404a3          	sb	a4,-119(s0)
    80003858:	00065c63          	bgez	a2,80003870 <__printf+0x278>
    8000385c:	f9040713          	addi	a4,s0,-112
    80003860:	00f70733          	add	a4,a4,a5
    80003864:	02d00693          	li	a3,45
    80003868:	fed70823          	sb	a3,-16(a4)
    8000386c:	00078c93          	mv	s9,a5
    80003870:	f8040793          	addi	a5,s0,-128
    80003874:	01978cb3          	add	s9,a5,s9
    80003878:	f7f40d13          	addi	s10,s0,-129
    8000387c:	000cc503          	lbu	a0,0(s9)
    80003880:	fffc8c93          	addi	s9,s9,-1
    80003884:	00000097          	auipc	ra,0x0
    80003888:	b90080e7          	jalr	-1136(ra) # 80003414 <consputc>
    8000388c:	ffac98e3          	bne	s9,s10,8000387c <__printf+0x284>
    80003890:	00094503          	lbu	a0,0(s2)
    80003894:	e00514e3          	bnez	a0,8000369c <__printf+0xa4>
    80003898:	1a0c1663          	bnez	s8,80003a44 <__printf+0x44c>
    8000389c:	08813083          	ld	ra,136(sp)
    800038a0:	08013403          	ld	s0,128(sp)
    800038a4:	07813483          	ld	s1,120(sp)
    800038a8:	07013903          	ld	s2,112(sp)
    800038ac:	06813983          	ld	s3,104(sp)
    800038b0:	06013a03          	ld	s4,96(sp)
    800038b4:	05813a83          	ld	s5,88(sp)
    800038b8:	05013b03          	ld	s6,80(sp)
    800038bc:	04813b83          	ld	s7,72(sp)
    800038c0:	04013c03          	ld	s8,64(sp)
    800038c4:	03813c83          	ld	s9,56(sp)
    800038c8:	03013d03          	ld	s10,48(sp)
    800038cc:	02813d83          	ld	s11,40(sp)
    800038d0:	0d010113          	addi	sp,sp,208
    800038d4:	00008067          	ret
    800038d8:	07300713          	li	a4,115
    800038dc:	1ce78a63          	beq	a5,a4,80003ab0 <__printf+0x4b8>
    800038e0:	07800713          	li	a4,120
    800038e4:	1ee79e63          	bne	a5,a4,80003ae0 <__printf+0x4e8>
    800038e8:	f7843783          	ld	a5,-136(s0)
    800038ec:	0007a703          	lw	a4,0(a5)
    800038f0:	00878793          	addi	a5,a5,8
    800038f4:	f6f43c23          	sd	a5,-136(s0)
    800038f8:	28074263          	bltz	a4,80003b7c <__printf+0x584>
    800038fc:	00002d97          	auipc	s11,0x2
    80003900:	944d8d93          	addi	s11,s11,-1724 # 80005240 <digits>
    80003904:	00f77793          	andi	a5,a4,15
    80003908:	00fd87b3          	add	a5,s11,a5
    8000390c:	0007c683          	lbu	a3,0(a5)
    80003910:	00f00613          	li	a2,15
    80003914:	0007079b          	sext.w	a5,a4
    80003918:	f8d40023          	sb	a3,-128(s0)
    8000391c:	0047559b          	srliw	a1,a4,0x4
    80003920:	0047569b          	srliw	a3,a4,0x4
    80003924:	00000c93          	li	s9,0
    80003928:	0ee65063          	bge	a2,a4,80003a08 <__printf+0x410>
    8000392c:	00f6f693          	andi	a3,a3,15
    80003930:	00dd86b3          	add	a3,s11,a3
    80003934:	0006c683          	lbu	a3,0(a3) # 2004000 <_entry-0x7dffc000>
    80003938:	0087d79b          	srliw	a5,a5,0x8
    8000393c:	00100c93          	li	s9,1
    80003940:	f8d400a3          	sb	a3,-127(s0)
    80003944:	0cb67263          	bgeu	a2,a1,80003a08 <__printf+0x410>
    80003948:	00f7f693          	andi	a3,a5,15
    8000394c:	00dd86b3          	add	a3,s11,a3
    80003950:	0006c583          	lbu	a1,0(a3)
    80003954:	00f00613          	li	a2,15
    80003958:	0047d69b          	srliw	a3,a5,0x4
    8000395c:	f8b40123          	sb	a1,-126(s0)
    80003960:	0047d593          	srli	a1,a5,0x4
    80003964:	28f67e63          	bgeu	a2,a5,80003c00 <__printf+0x608>
    80003968:	00f6f693          	andi	a3,a3,15
    8000396c:	00dd86b3          	add	a3,s11,a3
    80003970:	0006c503          	lbu	a0,0(a3)
    80003974:	0087d813          	srli	a6,a5,0x8
    80003978:	0087d69b          	srliw	a3,a5,0x8
    8000397c:	f8a401a3          	sb	a0,-125(s0)
    80003980:	28b67663          	bgeu	a2,a1,80003c0c <__printf+0x614>
    80003984:	00f6f693          	andi	a3,a3,15
    80003988:	00dd86b3          	add	a3,s11,a3
    8000398c:	0006c583          	lbu	a1,0(a3)
    80003990:	00c7d513          	srli	a0,a5,0xc
    80003994:	00c7d69b          	srliw	a3,a5,0xc
    80003998:	f8b40223          	sb	a1,-124(s0)
    8000399c:	29067a63          	bgeu	a2,a6,80003c30 <__printf+0x638>
    800039a0:	00f6f693          	andi	a3,a3,15
    800039a4:	00dd86b3          	add	a3,s11,a3
    800039a8:	0006c583          	lbu	a1,0(a3)
    800039ac:	0107d813          	srli	a6,a5,0x10
    800039b0:	0107d69b          	srliw	a3,a5,0x10
    800039b4:	f8b402a3          	sb	a1,-123(s0)
    800039b8:	28a67263          	bgeu	a2,a0,80003c3c <__printf+0x644>
    800039bc:	00f6f693          	andi	a3,a3,15
    800039c0:	00dd86b3          	add	a3,s11,a3
    800039c4:	0006c683          	lbu	a3,0(a3)
    800039c8:	0147d79b          	srliw	a5,a5,0x14
    800039cc:	f8d40323          	sb	a3,-122(s0)
    800039d0:	21067663          	bgeu	a2,a6,80003bdc <__printf+0x5e4>
    800039d4:	02079793          	slli	a5,a5,0x20
    800039d8:	0207d793          	srli	a5,a5,0x20
    800039dc:	00fd8db3          	add	s11,s11,a5
    800039e0:	000dc683          	lbu	a3,0(s11)
    800039e4:	00800793          	li	a5,8
    800039e8:	00700c93          	li	s9,7
    800039ec:	f8d403a3          	sb	a3,-121(s0)
    800039f0:	00075c63          	bgez	a4,80003a08 <__printf+0x410>
    800039f4:	f9040713          	addi	a4,s0,-112
    800039f8:	00f70733          	add	a4,a4,a5
    800039fc:	02d00693          	li	a3,45
    80003a00:	fed70823          	sb	a3,-16(a4)
    80003a04:	00078c93          	mv	s9,a5
    80003a08:	f8040793          	addi	a5,s0,-128
    80003a0c:	01978cb3          	add	s9,a5,s9
    80003a10:	f7f40d13          	addi	s10,s0,-129
    80003a14:	000cc503          	lbu	a0,0(s9)
    80003a18:	fffc8c93          	addi	s9,s9,-1
    80003a1c:	00000097          	auipc	ra,0x0
    80003a20:	9f8080e7          	jalr	-1544(ra) # 80003414 <consputc>
    80003a24:	ff9d18e3          	bne	s10,s9,80003a14 <__printf+0x41c>
    80003a28:	0100006f          	j	80003a38 <__printf+0x440>
    80003a2c:	00000097          	auipc	ra,0x0
    80003a30:	9e8080e7          	jalr	-1560(ra) # 80003414 <consputc>
    80003a34:	000c8493          	mv	s1,s9
    80003a38:	00094503          	lbu	a0,0(s2)
    80003a3c:	c60510e3          	bnez	a0,8000369c <__printf+0xa4>
    80003a40:	e40c0ee3          	beqz	s8,8000389c <__printf+0x2a4>
    80003a44:	00006517          	auipc	a0,0x6
    80003a48:	eac50513          	addi	a0,a0,-340 # 800098f0 <pr>
    80003a4c:	00001097          	auipc	ra,0x1
    80003a50:	94c080e7          	jalr	-1716(ra) # 80004398 <release>
    80003a54:	e49ff06f          	j	8000389c <__printf+0x2a4>
    80003a58:	f7843783          	ld	a5,-136(s0)
    80003a5c:	03000513          	li	a0,48
    80003a60:	01000d13          	li	s10,16
    80003a64:	00878713          	addi	a4,a5,8
    80003a68:	0007bc83          	ld	s9,0(a5)
    80003a6c:	f6e43c23          	sd	a4,-136(s0)
    80003a70:	00000097          	auipc	ra,0x0
    80003a74:	9a4080e7          	jalr	-1628(ra) # 80003414 <consputc>
    80003a78:	07800513          	li	a0,120
    80003a7c:	00000097          	auipc	ra,0x0
    80003a80:	998080e7          	jalr	-1640(ra) # 80003414 <consputc>
    80003a84:	00001d97          	auipc	s11,0x1
    80003a88:	7bcd8d93          	addi	s11,s11,1980 # 80005240 <digits>
    80003a8c:	03ccd793          	srli	a5,s9,0x3c
    80003a90:	00fd87b3          	add	a5,s11,a5
    80003a94:	0007c503          	lbu	a0,0(a5)
    80003a98:	fffd0d1b          	addiw	s10,s10,-1
    80003a9c:	004c9c93          	slli	s9,s9,0x4
    80003aa0:	00000097          	auipc	ra,0x0
    80003aa4:	974080e7          	jalr	-1676(ra) # 80003414 <consputc>
    80003aa8:	fe0d12e3          	bnez	s10,80003a8c <__printf+0x494>
    80003aac:	f8dff06f          	j	80003a38 <__printf+0x440>
    80003ab0:	f7843783          	ld	a5,-136(s0)
    80003ab4:	0007bc83          	ld	s9,0(a5)
    80003ab8:	00878793          	addi	a5,a5,8
    80003abc:	f6f43c23          	sd	a5,-136(s0)
    80003ac0:	000c9a63          	bnez	s9,80003ad4 <__printf+0x4dc>
    80003ac4:	1080006f          	j	80003bcc <__printf+0x5d4>
    80003ac8:	001c8c93          	addi	s9,s9,1
    80003acc:	00000097          	auipc	ra,0x0
    80003ad0:	948080e7          	jalr	-1720(ra) # 80003414 <consputc>
    80003ad4:	000cc503          	lbu	a0,0(s9)
    80003ad8:	fe0518e3          	bnez	a0,80003ac8 <__printf+0x4d0>
    80003adc:	f5dff06f          	j	80003a38 <__printf+0x440>
    80003ae0:	02500513          	li	a0,37
    80003ae4:	00000097          	auipc	ra,0x0
    80003ae8:	930080e7          	jalr	-1744(ra) # 80003414 <consputc>
    80003aec:	000c8513          	mv	a0,s9
    80003af0:	00000097          	auipc	ra,0x0
    80003af4:	924080e7          	jalr	-1756(ra) # 80003414 <consputc>
    80003af8:	f41ff06f          	j	80003a38 <__printf+0x440>
    80003afc:	02500513          	li	a0,37
    80003b00:	00000097          	auipc	ra,0x0
    80003b04:	914080e7          	jalr	-1772(ra) # 80003414 <consputc>
    80003b08:	f31ff06f          	j	80003a38 <__printf+0x440>
    80003b0c:	00030513          	mv	a0,t1
    80003b10:	00000097          	auipc	ra,0x0
    80003b14:	7bc080e7          	jalr	1980(ra) # 800042cc <acquire>
    80003b18:	b4dff06f          	j	80003664 <__printf+0x6c>
    80003b1c:	40c0053b          	negw	a0,a2
    80003b20:	00a00713          	li	a4,10
    80003b24:	02e576bb          	remuw	a3,a0,a4
    80003b28:	00001d97          	auipc	s11,0x1
    80003b2c:	718d8d93          	addi	s11,s11,1816 # 80005240 <digits>
    80003b30:	ff700593          	li	a1,-9
    80003b34:	02069693          	slli	a3,a3,0x20
    80003b38:	0206d693          	srli	a3,a3,0x20
    80003b3c:	00dd86b3          	add	a3,s11,a3
    80003b40:	0006c683          	lbu	a3,0(a3)
    80003b44:	02e557bb          	divuw	a5,a0,a4
    80003b48:	f8d40023          	sb	a3,-128(s0)
    80003b4c:	10b65e63          	bge	a2,a1,80003c68 <__printf+0x670>
    80003b50:	06300593          	li	a1,99
    80003b54:	02e7f6bb          	remuw	a3,a5,a4
    80003b58:	02069693          	slli	a3,a3,0x20
    80003b5c:	0206d693          	srli	a3,a3,0x20
    80003b60:	00dd86b3          	add	a3,s11,a3
    80003b64:	0006c683          	lbu	a3,0(a3)
    80003b68:	02e7d73b          	divuw	a4,a5,a4
    80003b6c:	00200793          	li	a5,2
    80003b70:	f8d400a3          	sb	a3,-127(s0)
    80003b74:	bca5ece3          	bltu	a1,a0,8000374c <__printf+0x154>
    80003b78:	ce5ff06f          	j	8000385c <__printf+0x264>
    80003b7c:	40e007bb          	negw	a5,a4
    80003b80:	00001d97          	auipc	s11,0x1
    80003b84:	6c0d8d93          	addi	s11,s11,1728 # 80005240 <digits>
    80003b88:	00f7f693          	andi	a3,a5,15
    80003b8c:	00dd86b3          	add	a3,s11,a3
    80003b90:	0006c583          	lbu	a1,0(a3)
    80003b94:	ff100613          	li	a2,-15
    80003b98:	0047d69b          	srliw	a3,a5,0x4
    80003b9c:	f8b40023          	sb	a1,-128(s0)
    80003ba0:	0047d59b          	srliw	a1,a5,0x4
    80003ba4:	0ac75e63          	bge	a4,a2,80003c60 <__printf+0x668>
    80003ba8:	00f6f693          	andi	a3,a3,15
    80003bac:	00dd86b3          	add	a3,s11,a3
    80003bb0:	0006c603          	lbu	a2,0(a3)
    80003bb4:	00f00693          	li	a3,15
    80003bb8:	0087d79b          	srliw	a5,a5,0x8
    80003bbc:	f8c400a3          	sb	a2,-127(s0)
    80003bc0:	d8b6e4e3          	bltu	a3,a1,80003948 <__printf+0x350>
    80003bc4:	00200793          	li	a5,2
    80003bc8:	e2dff06f          	j	800039f4 <__printf+0x3fc>
    80003bcc:	00001c97          	auipc	s9,0x1
    80003bd0:	654c8c93          	addi	s9,s9,1620 # 80005220 <CONSOLE_STATUS+0x208>
    80003bd4:	02800513          	li	a0,40
    80003bd8:	ef1ff06f          	j	80003ac8 <__printf+0x4d0>
    80003bdc:	00700793          	li	a5,7
    80003be0:	00600c93          	li	s9,6
    80003be4:	e0dff06f          	j	800039f0 <__printf+0x3f8>
    80003be8:	00700793          	li	a5,7
    80003bec:	00600c93          	li	s9,6
    80003bf0:	c69ff06f          	j	80003858 <__printf+0x260>
    80003bf4:	00300793          	li	a5,3
    80003bf8:	00200c93          	li	s9,2
    80003bfc:	c5dff06f          	j	80003858 <__printf+0x260>
    80003c00:	00300793          	li	a5,3
    80003c04:	00200c93          	li	s9,2
    80003c08:	de9ff06f          	j	800039f0 <__printf+0x3f8>
    80003c0c:	00400793          	li	a5,4
    80003c10:	00300c93          	li	s9,3
    80003c14:	dddff06f          	j	800039f0 <__printf+0x3f8>
    80003c18:	00400793          	li	a5,4
    80003c1c:	00300c93          	li	s9,3
    80003c20:	c39ff06f          	j	80003858 <__printf+0x260>
    80003c24:	00500793          	li	a5,5
    80003c28:	00400c93          	li	s9,4
    80003c2c:	c2dff06f          	j	80003858 <__printf+0x260>
    80003c30:	00500793          	li	a5,5
    80003c34:	00400c93          	li	s9,4
    80003c38:	db9ff06f          	j	800039f0 <__printf+0x3f8>
    80003c3c:	00600793          	li	a5,6
    80003c40:	00500c93          	li	s9,5
    80003c44:	dadff06f          	j	800039f0 <__printf+0x3f8>
    80003c48:	00600793          	li	a5,6
    80003c4c:	00500c93          	li	s9,5
    80003c50:	c09ff06f          	j	80003858 <__printf+0x260>
    80003c54:	00800793          	li	a5,8
    80003c58:	00700c93          	li	s9,7
    80003c5c:	bfdff06f          	j	80003858 <__printf+0x260>
    80003c60:	00100793          	li	a5,1
    80003c64:	d91ff06f          	j	800039f4 <__printf+0x3fc>
    80003c68:	00100793          	li	a5,1
    80003c6c:	bf1ff06f          	j	8000385c <__printf+0x264>
    80003c70:	00900793          	li	a5,9
    80003c74:	00800c93          	li	s9,8
    80003c78:	be1ff06f          	j	80003858 <__printf+0x260>
    80003c7c:	00001517          	auipc	a0,0x1
    80003c80:	5ac50513          	addi	a0,a0,1452 # 80005228 <CONSOLE_STATUS+0x210>
    80003c84:	00000097          	auipc	ra,0x0
    80003c88:	918080e7          	jalr	-1768(ra) # 8000359c <panic>

0000000080003c8c <printfinit>:
    80003c8c:	fe010113          	addi	sp,sp,-32
    80003c90:	00813823          	sd	s0,16(sp)
    80003c94:	00913423          	sd	s1,8(sp)
    80003c98:	00113c23          	sd	ra,24(sp)
    80003c9c:	02010413          	addi	s0,sp,32
    80003ca0:	00006497          	auipc	s1,0x6
    80003ca4:	c5048493          	addi	s1,s1,-944 # 800098f0 <pr>
    80003ca8:	00048513          	mv	a0,s1
    80003cac:	00001597          	auipc	a1,0x1
    80003cb0:	58c58593          	addi	a1,a1,1420 # 80005238 <CONSOLE_STATUS+0x220>
    80003cb4:	00000097          	auipc	ra,0x0
    80003cb8:	5f4080e7          	jalr	1524(ra) # 800042a8 <initlock>
    80003cbc:	01813083          	ld	ra,24(sp)
    80003cc0:	01013403          	ld	s0,16(sp)
    80003cc4:	0004ac23          	sw	zero,24(s1)
    80003cc8:	00813483          	ld	s1,8(sp)
    80003ccc:	02010113          	addi	sp,sp,32
    80003cd0:	00008067          	ret

0000000080003cd4 <uartinit>:
    80003cd4:	ff010113          	addi	sp,sp,-16
    80003cd8:	00813423          	sd	s0,8(sp)
    80003cdc:	01010413          	addi	s0,sp,16
    80003ce0:	100007b7          	lui	a5,0x10000
    80003ce4:	000780a3          	sb	zero,1(a5) # 10000001 <_entry-0x6fffffff>
    80003ce8:	f8000713          	li	a4,-128
    80003cec:	00e781a3          	sb	a4,3(a5)
    80003cf0:	00300713          	li	a4,3
    80003cf4:	00e78023          	sb	a4,0(a5)
    80003cf8:	000780a3          	sb	zero,1(a5)
    80003cfc:	00e781a3          	sb	a4,3(a5)
    80003d00:	00700693          	li	a3,7
    80003d04:	00d78123          	sb	a3,2(a5)
    80003d08:	00e780a3          	sb	a4,1(a5)
    80003d0c:	00813403          	ld	s0,8(sp)
    80003d10:	01010113          	addi	sp,sp,16
    80003d14:	00008067          	ret

0000000080003d18 <uartputc>:
    80003d18:	00002797          	auipc	a5,0x2
    80003d1c:	96c7a783          	lw	a5,-1684(a5) # 80005684 <panicked>
    80003d20:	00078463          	beqz	a5,80003d28 <uartputc+0x10>
    80003d24:	0000006f          	j	80003d24 <uartputc+0xc>
    80003d28:	fd010113          	addi	sp,sp,-48
    80003d2c:	02813023          	sd	s0,32(sp)
    80003d30:	00913c23          	sd	s1,24(sp)
    80003d34:	01213823          	sd	s2,16(sp)
    80003d38:	01313423          	sd	s3,8(sp)
    80003d3c:	02113423          	sd	ra,40(sp)
    80003d40:	03010413          	addi	s0,sp,48
    80003d44:	00002917          	auipc	s2,0x2
    80003d48:	94490913          	addi	s2,s2,-1724 # 80005688 <uart_tx_r>
    80003d4c:	00093783          	ld	a5,0(s2)
    80003d50:	00002497          	auipc	s1,0x2
    80003d54:	94048493          	addi	s1,s1,-1728 # 80005690 <uart_tx_w>
    80003d58:	0004b703          	ld	a4,0(s1)
    80003d5c:	02078693          	addi	a3,a5,32
    80003d60:	00050993          	mv	s3,a0
    80003d64:	02e69c63          	bne	a3,a4,80003d9c <uartputc+0x84>
    80003d68:	00001097          	auipc	ra,0x1
    80003d6c:	834080e7          	jalr	-1996(ra) # 8000459c <push_on>
    80003d70:	00093783          	ld	a5,0(s2)
    80003d74:	0004b703          	ld	a4,0(s1)
    80003d78:	02078793          	addi	a5,a5,32
    80003d7c:	00e79463          	bne	a5,a4,80003d84 <uartputc+0x6c>
    80003d80:	0000006f          	j	80003d80 <uartputc+0x68>
    80003d84:	00001097          	auipc	ra,0x1
    80003d88:	88c080e7          	jalr	-1908(ra) # 80004610 <pop_on>
    80003d8c:	00093783          	ld	a5,0(s2)
    80003d90:	0004b703          	ld	a4,0(s1)
    80003d94:	02078693          	addi	a3,a5,32
    80003d98:	fce688e3          	beq	a3,a4,80003d68 <uartputc+0x50>
    80003d9c:	01f77693          	andi	a3,a4,31
    80003da0:	00006597          	auipc	a1,0x6
    80003da4:	b7058593          	addi	a1,a1,-1168 # 80009910 <uart_tx_buf>
    80003da8:	00d586b3          	add	a3,a1,a3
    80003dac:	00170713          	addi	a4,a4,1
    80003db0:	01368023          	sb	s3,0(a3)
    80003db4:	00e4b023          	sd	a4,0(s1)
    80003db8:	10000637          	lui	a2,0x10000
    80003dbc:	02f71063          	bne	a4,a5,80003ddc <uartputc+0xc4>
    80003dc0:	0340006f          	j	80003df4 <uartputc+0xdc>
    80003dc4:	00074703          	lbu	a4,0(a4)
    80003dc8:	00f93023          	sd	a5,0(s2)
    80003dcc:	00e60023          	sb	a4,0(a2) # 10000000 <_entry-0x70000000>
    80003dd0:	00093783          	ld	a5,0(s2)
    80003dd4:	0004b703          	ld	a4,0(s1)
    80003dd8:	00f70e63          	beq	a4,a5,80003df4 <uartputc+0xdc>
    80003ddc:	00564683          	lbu	a3,5(a2)
    80003de0:	01f7f713          	andi	a4,a5,31
    80003de4:	00e58733          	add	a4,a1,a4
    80003de8:	0206f693          	andi	a3,a3,32
    80003dec:	00178793          	addi	a5,a5,1
    80003df0:	fc069ae3          	bnez	a3,80003dc4 <uartputc+0xac>
    80003df4:	02813083          	ld	ra,40(sp)
    80003df8:	02013403          	ld	s0,32(sp)
    80003dfc:	01813483          	ld	s1,24(sp)
    80003e00:	01013903          	ld	s2,16(sp)
    80003e04:	00813983          	ld	s3,8(sp)
    80003e08:	03010113          	addi	sp,sp,48
    80003e0c:	00008067          	ret

0000000080003e10 <uartputc_sync>:
    80003e10:	ff010113          	addi	sp,sp,-16
    80003e14:	00813423          	sd	s0,8(sp)
    80003e18:	01010413          	addi	s0,sp,16
    80003e1c:	00002717          	auipc	a4,0x2
    80003e20:	86872703          	lw	a4,-1944(a4) # 80005684 <panicked>
    80003e24:	02071663          	bnez	a4,80003e50 <uartputc_sync+0x40>
    80003e28:	00050793          	mv	a5,a0
    80003e2c:	100006b7          	lui	a3,0x10000
    80003e30:	0056c703          	lbu	a4,5(a3) # 10000005 <_entry-0x6ffffffb>
    80003e34:	02077713          	andi	a4,a4,32
    80003e38:	fe070ce3          	beqz	a4,80003e30 <uartputc_sync+0x20>
    80003e3c:	0ff7f793          	andi	a5,a5,255
    80003e40:	00f68023          	sb	a5,0(a3)
    80003e44:	00813403          	ld	s0,8(sp)
    80003e48:	01010113          	addi	sp,sp,16
    80003e4c:	00008067          	ret
    80003e50:	0000006f          	j	80003e50 <uartputc_sync+0x40>

0000000080003e54 <uartstart>:
    80003e54:	ff010113          	addi	sp,sp,-16
    80003e58:	00813423          	sd	s0,8(sp)
    80003e5c:	01010413          	addi	s0,sp,16
    80003e60:	00002617          	auipc	a2,0x2
    80003e64:	82860613          	addi	a2,a2,-2008 # 80005688 <uart_tx_r>
    80003e68:	00002517          	auipc	a0,0x2
    80003e6c:	82850513          	addi	a0,a0,-2008 # 80005690 <uart_tx_w>
    80003e70:	00063783          	ld	a5,0(a2)
    80003e74:	00053703          	ld	a4,0(a0)
    80003e78:	04f70263          	beq	a4,a5,80003ebc <uartstart+0x68>
    80003e7c:	100005b7          	lui	a1,0x10000
    80003e80:	00006817          	auipc	a6,0x6
    80003e84:	a9080813          	addi	a6,a6,-1392 # 80009910 <uart_tx_buf>
    80003e88:	01c0006f          	j	80003ea4 <uartstart+0x50>
    80003e8c:	0006c703          	lbu	a4,0(a3)
    80003e90:	00f63023          	sd	a5,0(a2)
    80003e94:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    80003e98:	00063783          	ld	a5,0(a2)
    80003e9c:	00053703          	ld	a4,0(a0)
    80003ea0:	00f70e63          	beq	a4,a5,80003ebc <uartstart+0x68>
    80003ea4:	01f7f713          	andi	a4,a5,31
    80003ea8:	00e806b3          	add	a3,a6,a4
    80003eac:	0055c703          	lbu	a4,5(a1)
    80003eb0:	00178793          	addi	a5,a5,1
    80003eb4:	02077713          	andi	a4,a4,32
    80003eb8:	fc071ae3          	bnez	a4,80003e8c <uartstart+0x38>
    80003ebc:	00813403          	ld	s0,8(sp)
    80003ec0:	01010113          	addi	sp,sp,16
    80003ec4:	00008067          	ret

0000000080003ec8 <uartgetc>:
    80003ec8:	ff010113          	addi	sp,sp,-16
    80003ecc:	00813423          	sd	s0,8(sp)
    80003ed0:	01010413          	addi	s0,sp,16
    80003ed4:	10000737          	lui	a4,0x10000
    80003ed8:	00574783          	lbu	a5,5(a4) # 10000005 <_entry-0x6ffffffb>
    80003edc:	0017f793          	andi	a5,a5,1
    80003ee0:	00078c63          	beqz	a5,80003ef8 <uartgetc+0x30>
    80003ee4:	00074503          	lbu	a0,0(a4)
    80003ee8:	0ff57513          	andi	a0,a0,255
    80003eec:	00813403          	ld	s0,8(sp)
    80003ef0:	01010113          	addi	sp,sp,16
    80003ef4:	00008067          	ret
    80003ef8:	fff00513          	li	a0,-1
    80003efc:	ff1ff06f          	j	80003eec <uartgetc+0x24>

0000000080003f00 <uartintr>:
    80003f00:	100007b7          	lui	a5,0x10000
    80003f04:	0057c783          	lbu	a5,5(a5) # 10000005 <_entry-0x6ffffffb>
    80003f08:	0017f793          	andi	a5,a5,1
    80003f0c:	0a078463          	beqz	a5,80003fb4 <uartintr+0xb4>
    80003f10:	fe010113          	addi	sp,sp,-32
    80003f14:	00813823          	sd	s0,16(sp)
    80003f18:	00913423          	sd	s1,8(sp)
    80003f1c:	00113c23          	sd	ra,24(sp)
    80003f20:	02010413          	addi	s0,sp,32
    80003f24:	100004b7          	lui	s1,0x10000
    80003f28:	0004c503          	lbu	a0,0(s1) # 10000000 <_entry-0x70000000>
    80003f2c:	0ff57513          	andi	a0,a0,255
    80003f30:	fffff097          	auipc	ra,0xfffff
    80003f34:	534080e7          	jalr	1332(ra) # 80003464 <consoleintr>
    80003f38:	0054c783          	lbu	a5,5(s1)
    80003f3c:	0017f793          	andi	a5,a5,1
    80003f40:	fe0794e3          	bnez	a5,80003f28 <uartintr+0x28>
    80003f44:	00001617          	auipc	a2,0x1
    80003f48:	74460613          	addi	a2,a2,1860 # 80005688 <uart_tx_r>
    80003f4c:	00001517          	auipc	a0,0x1
    80003f50:	74450513          	addi	a0,a0,1860 # 80005690 <uart_tx_w>
    80003f54:	00063783          	ld	a5,0(a2)
    80003f58:	00053703          	ld	a4,0(a0)
    80003f5c:	04f70263          	beq	a4,a5,80003fa0 <uartintr+0xa0>
    80003f60:	100005b7          	lui	a1,0x10000
    80003f64:	00006817          	auipc	a6,0x6
    80003f68:	9ac80813          	addi	a6,a6,-1620 # 80009910 <uart_tx_buf>
    80003f6c:	01c0006f          	j	80003f88 <uartintr+0x88>
    80003f70:	0006c703          	lbu	a4,0(a3)
    80003f74:	00f63023          	sd	a5,0(a2)
    80003f78:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    80003f7c:	00063783          	ld	a5,0(a2)
    80003f80:	00053703          	ld	a4,0(a0)
    80003f84:	00f70e63          	beq	a4,a5,80003fa0 <uartintr+0xa0>
    80003f88:	01f7f713          	andi	a4,a5,31
    80003f8c:	00e806b3          	add	a3,a6,a4
    80003f90:	0055c703          	lbu	a4,5(a1)
    80003f94:	00178793          	addi	a5,a5,1
    80003f98:	02077713          	andi	a4,a4,32
    80003f9c:	fc071ae3          	bnez	a4,80003f70 <uartintr+0x70>
    80003fa0:	01813083          	ld	ra,24(sp)
    80003fa4:	01013403          	ld	s0,16(sp)
    80003fa8:	00813483          	ld	s1,8(sp)
    80003fac:	02010113          	addi	sp,sp,32
    80003fb0:	00008067          	ret
    80003fb4:	00001617          	auipc	a2,0x1
    80003fb8:	6d460613          	addi	a2,a2,1748 # 80005688 <uart_tx_r>
    80003fbc:	00001517          	auipc	a0,0x1
    80003fc0:	6d450513          	addi	a0,a0,1748 # 80005690 <uart_tx_w>
    80003fc4:	00063783          	ld	a5,0(a2)
    80003fc8:	00053703          	ld	a4,0(a0)
    80003fcc:	04f70263          	beq	a4,a5,80004010 <uartintr+0x110>
    80003fd0:	100005b7          	lui	a1,0x10000
    80003fd4:	00006817          	auipc	a6,0x6
    80003fd8:	93c80813          	addi	a6,a6,-1732 # 80009910 <uart_tx_buf>
    80003fdc:	01c0006f          	j	80003ff8 <uartintr+0xf8>
    80003fe0:	0006c703          	lbu	a4,0(a3)
    80003fe4:	00f63023          	sd	a5,0(a2)
    80003fe8:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    80003fec:	00063783          	ld	a5,0(a2)
    80003ff0:	00053703          	ld	a4,0(a0)
    80003ff4:	02f70063          	beq	a4,a5,80004014 <uartintr+0x114>
    80003ff8:	01f7f713          	andi	a4,a5,31
    80003ffc:	00e806b3          	add	a3,a6,a4
    80004000:	0055c703          	lbu	a4,5(a1)
    80004004:	00178793          	addi	a5,a5,1
    80004008:	02077713          	andi	a4,a4,32
    8000400c:	fc071ae3          	bnez	a4,80003fe0 <uartintr+0xe0>
    80004010:	00008067          	ret
    80004014:	00008067          	ret

0000000080004018 <kinit>:
    80004018:	fc010113          	addi	sp,sp,-64
    8000401c:	02913423          	sd	s1,40(sp)
    80004020:	fffff7b7          	lui	a5,0xfffff
    80004024:	00007497          	auipc	s1,0x7
    80004028:	90b48493          	addi	s1,s1,-1781 # 8000a92f <end+0xfff>
    8000402c:	02813823          	sd	s0,48(sp)
    80004030:	01313c23          	sd	s3,24(sp)
    80004034:	00f4f4b3          	and	s1,s1,a5
    80004038:	02113c23          	sd	ra,56(sp)
    8000403c:	03213023          	sd	s2,32(sp)
    80004040:	01413823          	sd	s4,16(sp)
    80004044:	01513423          	sd	s5,8(sp)
    80004048:	04010413          	addi	s0,sp,64
    8000404c:	000017b7          	lui	a5,0x1
    80004050:	01100993          	li	s3,17
    80004054:	00f487b3          	add	a5,s1,a5
    80004058:	01b99993          	slli	s3,s3,0x1b
    8000405c:	06f9e063          	bltu	s3,a5,800040bc <kinit+0xa4>
    80004060:	00006a97          	auipc	s5,0x6
    80004064:	8d0a8a93          	addi	s5,s5,-1840 # 80009930 <end>
    80004068:	0754ec63          	bltu	s1,s5,800040e0 <kinit+0xc8>
    8000406c:	0734fa63          	bgeu	s1,s3,800040e0 <kinit+0xc8>
    80004070:	00088a37          	lui	s4,0x88
    80004074:	fffa0a13          	addi	s4,s4,-1 # 87fff <_entry-0x7ff78001>
    80004078:	00001917          	auipc	s2,0x1
    8000407c:	62090913          	addi	s2,s2,1568 # 80005698 <kmem>
    80004080:	00ca1a13          	slli	s4,s4,0xc
    80004084:	0140006f          	j	80004098 <kinit+0x80>
    80004088:	000017b7          	lui	a5,0x1
    8000408c:	00f484b3          	add	s1,s1,a5
    80004090:	0554e863          	bltu	s1,s5,800040e0 <kinit+0xc8>
    80004094:	0534f663          	bgeu	s1,s3,800040e0 <kinit+0xc8>
    80004098:	00001637          	lui	a2,0x1
    8000409c:	00100593          	li	a1,1
    800040a0:	00048513          	mv	a0,s1
    800040a4:	00000097          	auipc	ra,0x0
    800040a8:	5e4080e7          	jalr	1508(ra) # 80004688 <__memset>
    800040ac:	00093783          	ld	a5,0(s2)
    800040b0:	00f4b023          	sd	a5,0(s1)
    800040b4:	00993023          	sd	s1,0(s2)
    800040b8:	fd4498e3          	bne	s1,s4,80004088 <kinit+0x70>
    800040bc:	03813083          	ld	ra,56(sp)
    800040c0:	03013403          	ld	s0,48(sp)
    800040c4:	02813483          	ld	s1,40(sp)
    800040c8:	02013903          	ld	s2,32(sp)
    800040cc:	01813983          	ld	s3,24(sp)
    800040d0:	01013a03          	ld	s4,16(sp)
    800040d4:	00813a83          	ld	s5,8(sp)
    800040d8:	04010113          	addi	sp,sp,64
    800040dc:	00008067          	ret
    800040e0:	00001517          	auipc	a0,0x1
    800040e4:	17850513          	addi	a0,a0,376 # 80005258 <digits+0x18>
    800040e8:	fffff097          	auipc	ra,0xfffff
    800040ec:	4b4080e7          	jalr	1204(ra) # 8000359c <panic>

00000000800040f0 <freerange>:
    800040f0:	fc010113          	addi	sp,sp,-64
    800040f4:	000017b7          	lui	a5,0x1
    800040f8:	02913423          	sd	s1,40(sp)
    800040fc:	fff78493          	addi	s1,a5,-1 # fff <_entry-0x7ffff001>
    80004100:	009504b3          	add	s1,a0,s1
    80004104:	fffff537          	lui	a0,0xfffff
    80004108:	02813823          	sd	s0,48(sp)
    8000410c:	02113c23          	sd	ra,56(sp)
    80004110:	03213023          	sd	s2,32(sp)
    80004114:	01313c23          	sd	s3,24(sp)
    80004118:	01413823          	sd	s4,16(sp)
    8000411c:	01513423          	sd	s5,8(sp)
    80004120:	01613023          	sd	s6,0(sp)
    80004124:	04010413          	addi	s0,sp,64
    80004128:	00a4f4b3          	and	s1,s1,a0
    8000412c:	00f487b3          	add	a5,s1,a5
    80004130:	06f5e463          	bltu	a1,a5,80004198 <freerange+0xa8>
    80004134:	00005a97          	auipc	s5,0x5
    80004138:	7fca8a93          	addi	s5,s5,2044 # 80009930 <end>
    8000413c:	0954e263          	bltu	s1,s5,800041c0 <freerange+0xd0>
    80004140:	01100993          	li	s3,17
    80004144:	01b99993          	slli	s3,s3,0x1b
    80004148:	0734fc63          	bgeu	s1,s3,800041c0 <freerange+0xd0>
    8000414c:	00058a13          	mv	s4,a1
    80004150:	00001917          	auipc	s2,0x1
    80004154:	54890913          	addi	s2,s2,1352 # 80005698 <kmem>
    80004158:	00002b37          	lui	s6,0x2
    8000415c:	0140006f          	j	80004170 <freerange+0x80>
    80004160:	000017b7          	lui	a5,0x1
    80004164:	00f484b3          	add	s1,s1,a5
    80004168:	0554ec63          	bltu	s1,s5,800041c0 <freerange+0xd0>
    8000416c:	0534fa63          	bgeu	s1,s3,800041c0 <freerange+0xd0>
    80004170:	00001637          	lui	a2,0x1
    80004174:	00100593          	li	a1,1
    80004178:	00048513          	mv	a0,s1
    8000417c:	00000097          	auipc	ra,0x0
    80004180:	50c080e7          	jalr	1292(ra) # 80004688 <__memset>
    80004184:	00093703          	ld	a4,0(s2)
    80004188:	016487b3          	add	a5,s1,s6
    8000418c:	00e4b023          	sd	a4,0(s1)
    80004190:	00993023          	sd	s1,0(s2)
    80004194:	fcfa76e3          	bgeu	s4,a5,80004160 <freerange+0x70>
    80004198:	03813083          	ld	ra,56(sp)
    8000419c:	03013403          	ld	s0,48(sp)
    800041a0:	02813483          	ld	s1,40(sp)
    800041a4:	02013903          	ld	s2,32(sp)
    800041a8:	01813983          	ld	s3,24(sp)
    800041ac:	01013a03          	ld	s4,16(sp)
    800041b0:	00813a83          	ld	s5,8(sp)
    800041b4:	00013b03          	ld	s6,0(sp)
    800041b8:	04010113          	addi	sp,sp,64
    800041bc:	00008067          	ret
    800041c0:	00001517          	auipc	a0,0x1
    800041c4:	09850513          	addi	a0,a0,152 # 80005258 <digits+0x18>
    800041c8:	fffff097          	auipc	ra,0xfffff
    800041cc:	3d4080e7          	jalr	980(ra) # 8000359c <panic>

00000000800041d0 <kfree>:
    800041d0:	fe010113          	addi	sp,sp,-32
    800041d4:	00813823          	sd	s0,16(sp)
    800041d8:	00113c23          	sd	ra,24(sp)
    800041dc:	00913423          	sd	s1,8(sp)
    800041e0:	02010413          	addi	s0,sp,32
    800041e4:	03451793          	slli	a5,a0,0x34
    800041e8:	04079c63          	bnez	a5,80004240 <kfree+0x70>
    800041ec:	00005797          	auipc	a5,0x5
    800041f0:	74478793          	addi	a5,a5,1860 # 80009930 <end>
    800041f4:	00050493          	mv	s1,a0
    800041f8:	04f56463          	bltu	a0,a5,80004240 <kfree+0x70>
    800041fc:	01100793          	li	a5,17
    80004200:	01b79793          	slli	a5,a5,0x1b
    80004204:	02f57e63          	bgeu	a0,a5,80004240 <kfree+0x70>
    80004208:	00001637          	lui	a2,0x1
    8000420c:	00100593          	li	a1,1
    80004210:	00000097          	auipc	ra,0x0
    80004214:	478080e7          	jalr	1144(ra) # 80004688 <__memset>
    80004218:	00001797          	auipc	a5,0x1
    8000421c:	48078793          	addi	a5,a5,1152 # 80005698 <kmem>
    80004220:	0007b703          	ld	a4,0(a5)
    80004224:	01813083          	ld	ra,24(sp)
    80004228:	01013403          	ld	s0,16(sp)
    8000422c:	00e4b023          	sd	a4,0(s1)
    80004230:	0097b023          	sd	s1,0(a5)
    80004234:	00813483          	ld	s1,8(sp)
    80004238:	02010113          	addi	sp,sp,32
    8000423c:	00008067          	ret
    80004240:	00001517          	auipc	a0,0x1
    80004244:	01850513          	addi	a0,a0,24 # 80005258 <digits+0x18>
    80004248:	fffff097          	auipc	ra,0xfffff
    8000424c:	354080e7          	jalr	852(ra) # 8000359c <panic>

0000000080004250 <kalloc>:
    80004250:	fe010113          	addi	sp,sp,-32
    80004254:	00813823          	sd	s0,16(sp)
    80004258:	00913423          	sd	s1,8(sp)
    8000425c:	00113c23          	sd	ra,24(sp)
    80004260:	02010413          	addi	s0,sp,32
    80004264:	00001797          	auipc	a5,0x1
    80004268:	43478793          	addi	a5,a5,1076 # 80005698 <kmem>
    8000426c:	0007b483          	ld	s1,0(a5)
    80004270:	02048063          	beqz	s1,80004290 <kalloc+0x40>
    80004274:	0004b703          	ld	a4,0(s1)
    80004278:	00001637          	lui	a2,0x1
    8000427c:	00500593          	li	a1,5
    80004280:	00048513          	mv	a0,s1
    80004284:	00e7b023          	sd	a4,0(a5)
    80004288:	00000097          	auipc	ra,0x0
    8000428c:	400080e7          	jalr	1024(ra) # 80004688 <__memset>
    80004290:	01813083          	ld	ra,24(sp)
    80004294:	01013403          	ld	s0,16(sp)
    80004298:	00048513          	mv	a0,s1
    8000429c:	00813483          	ld	s1,8(sp)
    800042a0:	02010113          	addi	sp,sp,32
    800042a4:	00008067          	ret

00000000800042a8 <initlock>:
    800042a8:	ff010113          	addi	sp,sp,-16
    800042ac:	00813423          	sd	s0,8(sp)
    800042b0:	01010413          	addi	s0,sp,16
    800042b4:	00813403          	ld	s0,8(sp)
    800042b8:	00b53423          	sd	a1,8(a0)
    800042bc:	00052023          	sw	zero,0(a0)
    800042c0:	00053823          	sd	zero,16(a0)
    800042c4:	01010113          	addi	sp,sp,16
    800042c8:	00008067          	ret

00000000800042cc <acquire>:
    800042cc:	fe010113          	addi	sp,sp,-32
    800042d0:	00813823          	sd	s0,16(sp)
    800042d4:	00913423          	sd	s1,8(sp)
    800042d8:	00113c23          	sd	ra,24(sp)
    800042dc:	01213023          	sd	s2,0(sp)
    800042e0:	02010413          	addi	s0,sp,32
    800042e4:	00050493          	mv	s1,a0
    800042e8:	10002973          	csrr	s2,sstatus
    800042ec:	100027f3          	csrr	a5,sstatus
    800042f0:	ffd7f793          	andi	a5,a5,-3
    800042f4:	10079073          	csrw	sstatus,a5
    800042f8:	fffff097          	auipc	ra,0xfffff
    800042fc:	8ec080e7          	jalr	-1812(ra) # 80002be4 <mycpu>
    80004300:	07852783          	lw	a5,120(a0)
    80004304:	06078e63          	beqz	a5,80004380 <acquire+0xb4>
    80004308:	fffff097          	auipc	ra,0xfffff
    8000430c:	8dc080e7          	jalr	-1828(ra) # 80002be4 <mycpu>
    80004310:	07852783          	lw	a5,120(a0)
    80004314:	0004a703          	lw	a4,0(s1)
    80004318:	0017879b          	addiw	a5,a5,1
    8000431c:	06f52c23          	sw	a5,120(a0)
    80004320:	04071063          	bnez	a4,80004360 <acquire+0x94>
    80004324:	00100713          	li	a4,1
    80004328:	00070793          	mv	a5,a4
    8000432c:	0cf4a7af          	amoswap.w.aq	a5,a5,(s1)
    80004330:	0007879b          	sext.w	a5,a5
    80004334:	fe079ae3          	bnez	a5,80004328 <acquire+0x5c>
    80004338:	0ff0000f          	fence
    8000433c:	fffff097          	auipc	ra,0xfffff
    80004340:	8a8080e7          	jalr	-1880(ra) # 80002be4 <mycpu>
    80004344:	01813083          	ld	ra,24(sp)
    80004348:	01013403          	ld	s0,16(sp)
    8000434c:	00a4b823          	sd	a0,16(s1)
    80004350:	00013903          	ld	s2,0(sp)
    80004354:	00813483          	ld	s1,8(sp)
    80004358:	02010113          	addi	sp,sp,32
    8000435c:	00008067          	ret
    80004360:	0104b903          	ld	s2,16(s1)
    80004364:	fffff097          	auipc	ra,0xfffff
    80004368:	880080e7          	jalr	-1920(ra) # 80002be4 <mycpu>
    8000436c:	faa91ce3          	bne	s2,a0,80004324 <acquire+0x58>
    80004370:	00001517          	auipc	a0,0x1
    80004374:	ef050513          	addi	a0,a0,-272 # 80005260 <digits+0x20>
    80004378:	fffff097          	auipc	ra,0xfffff
    8000437c:	224080e7          	jalr	548(ra) # 8000359c <panic>
    80004380:	00195913          	srli	s2,s2,0x1
    80004384:	fffff097          	auipc	ra,0xfffff
    80004388:	860080e7          	jalr	-1952(ra) # 80002be4 <mycpu>
    8000438c:	00197913          	andi	s2,s2,1
    80004390:	07252e23          	sw	s2,124(a0)
    80004394:	f75ff06f          	j	80004308 <acquire+0x3c>

0000000080004398 <release>:
    80004398:	fe010113          	addi	sp,sp,-32
    8000439c:	00813823          	sd	s0,16(sp)
    800043a0:	00113c23          	sd	ra,24(sp)
    800043a4:	00913423          	sd	s1,8(sp)
    800043a8:	01213023          	sd	s2,0(sp)
    800043ac:	02010413          	addi	s0,sp,32
    800043b0:	00052783          	lw	a5,0(a0)
    800043b4:	00079a63          	bnez	a5,800043c8 <release+0x30>
    800043b8:	00001517          	auipc	a0,0x1
    800043bc:	eb050513          	addi	a0,a0,-336 # 80005268 <digits+0x28>
    800043c0:	fffff097          	auipc	ra,0xfffff
    800043c4:	1dc080e7          	jalr	476(ra) # 8000359c <panic>
    800043c8:	01053903          	ld	s2,16(a0)
    800043cc:	00050493          	mv	s1,a0
    800043d0:	fffff097          	auipc	ra,0xfffff
    800043d4:	814080e7          	jalr	-2028(ra) # 80002be4 <mycpu>
    800043d8:	fea910e3          	bne	s2,a0,800043b8 <release+0x20>
    800043dc:	0004b823          	sd	zero,16(s1)
    800043e0:	0ff0000f          	fence
    800043e4:	0f50000f          	fence	iorw,ow
    800043e8:	0804a02f          	amoswap.w	zero,zero,(s1)
    800043ec:	ffffe097          	auipc	ra,0xffffe
    800043f0:	7f8080e7          	jalr	2040(ra) # 80002be4 <mycpu>
    800043f4:	100027f3          	csrr	a5,sstatus
    800043f8:	0027f793          	andi	a5,a5,2
    800043fc:	04079a63          	bnez	a5,80004450 <release+0xb8>
    80004400:	07852783          	lw	a5,120(a0)
    80004404:	02f05e63          	blez	a5,80004440 <release+0xa8>
    80004408:	fff7871b          	addiw	a4,a5,-1
    8000440c:	06e52c23          	sw	a4,120(a0)
    80004410:	00071c63          	bnez	a4,80004428 <release+0x90>
    80004414:	07c52783          	lw	a5,124(a0)
    80004418:	00078863          	beqz	a5,80004428 <release+0x90>
    8000441c:	100027f3          	csrr	a5,sstatus
    80004420:	0027e793          	ori	a5,a5,2
    80004424:	10079073          	csrw	sstatus,a5
    80004428:	01813083          	ld	ra,24(sp)
    8000442c:	01013403          	ld	s0,16(sp)
    80004430:	00813483          	ld	s1,8(sp)
    80004434:	00013903          	ld	s2,0(sp)
    80004438:	02010113          	addi	sp,sp,32
    8000443c:	00008067          	ret
    80004440:	00001517          	auipc	a0,0x1
    80004444:	e4850513          	addi	a0,a0,-440 # 80005288 <digits+0x48>
    80004448:	fffff097          	auipc	ra,0xfffff
    8000444c:	154080e7          	jalr	340(ra) # 8000359c <panic>
    80004450:	00001517          	auipc	a0,0x1
    80004454:	e2050513          	addi	a0,a0,-480 # 80005270 <digits+0x30>
    80004458:	fffff097          	auipc	ra,0xfffff
    8000445c:	144080e7          	jalr	324(ra) # 8000359c <panic>

0000000080004460 <holding>:
    80004460:	00052783          	lw	a5,0(a0)
    80004464:	00079663          	bnez	a5,80004470 <holding+0x10>
    80004468:	00000513          	li	a0,0
    8000446c:	00008067          	ret
    80004470:	fe010113          	addi	sp,sp,-32
    80004474:	00813823          	sd	s0,16(sp)
    80004478:	00913423          	sd	s1,8(sp)
    8000447c:	00113c23          	sd	ra,24(sp)
    80004480:	02010413          	addi	s0,sp,32
    80004484:	01053483          	ld	s1,16(a0)
    80004488:	ffffe097          	auipc	ra,0xffffe
    8000448c:	75c080e7          	jalr	1884(ra) # 80002be4 <mycpu>
    80004490:	01813083          	ld	ra,24(sp)
    80004494:	01013403          	ld	s0,16(sp)
    80004498:	40a48533          	sub	a0,s1,a0
    8000449c:	00153513          	seqz	a0,a0
    800044a0:	00813483          	ld	s1,8(sp)
    800044a4:	02010113          	addi	sp,sp,32
    800044a8:	00008067          	ret

00000000800044ac <push_off>:
    800044ac:	fe010113          	addi	sp,sp,-32
    800044b0:	00813823          	sd	s0,16(sp)
    800044b4:	00113c23          	sd	ra,24(sp)
    800044b8:	00913423          	sd	s1,8(sp)
    800044bc:	02010413          	addi	s0,sp,32
    800044c0:	100024f3          	csrr	s1,sstatus
    800044c4:	100027f3          	csrr	a5,sstatus
    800044c8:	ffd7f793          	andi	a5,a5,-3
    800044cc:	10079073          	csrw	sstatus,a5
    800044d0:	ffffe097          	auipc	ra,0xffffe
    800044d4:	714080e7          	jalr	1812(ra) # 80002be4 <mycpu>
    800044d8:	07852783          	lw	a5,120(a0)
    800044dc:	02078663          	beqz	a5,80004508 <push_off+0x5c>
    800044e0:	ffffe097          	auipc	ra,0xffffe
    800044e4:	704080e7          	jalr	1796(ra) # 80002be4 <mycpu>
    800044e8:	07852783          	lw	a5,120(a0)
    800044ec:	01813083          	ld	ra,24(sp)
    800044f0:	01013403          	ld	s0,16(sp)
    800044f4:	0017879b          	addiw	a5,a5,1
    800044f8:	06f52c23          	sw	a5,120(a0)
    800044fc:	00813483          	ld	s1,8(sp)
    80004500:	02010113          	addi	sp,sp,32
    80004504:	00008067          	ret
    80004508:	0014d493          	srli	s1,s1,0x1
    8000450c:	ffffe097          	auipc	ra,0xffffe
    80004510:	6d8080e7          	jalr	1752(ra) # 80002be4 <mycpu>
    80004514:	0014f493          	andi	s1,s1,1
    80004518:	06952e23          	sw	s1,124(a0)
    8000451c:	fc5ff06f          	j	800044e0 <push_off+0x34>

0000000080004520 <pop_off>:
    80004520:	ff010113          	addi	sp,sp,-16
    80004524:	00813023          	sd	s0,0(sp)
    80004528:	00113423          	sd	ra,8(sp)
    8000452c:	01010413          	addi	s0,sp,16
    80004530:	ffffe097          	auipc	ra,0xffffe
    80004534:	6b4080e7          	jalr	1716(ra) # 80002be4 <mycpu>
    80004538:	100027f3          	csrr	a5,sstatus
    8000453c:	0027f793          	andi	a5,a5,2
    80004540:	04079663          	bnez	a5,8000458c <pop_off+0x6c>
    80004544:	07852783          	lw	a5,120(a0)
    80004548:	02f05a63          	blez	a5,8000457c <pop_off+0x5c>
    8000454c:	fff7871b          	addiw	a4,a5,-1
    80004550:	06e52c23          	sw	a4,120(a0)
    80004554:	00071c63          	bnez	a4,8000456c <pop_off+0x4c>
    80004558:	07c52783          	lw	a5,124(a0)
    8000455c:	00078863          	beqz	a5,8000456c <pop_off+0x4c>
    80004560:	100027f3          	csrr	a5,sstatus
    80004564:	0027e793          	ori	a5,a5,2
    80004568:	10079073          	csrw	sstatus,a5
    8000456c:	00813083          	ld	ra,8(sp)
    80004570:	00013403          	ld	s0,0(sp)
    80004574:	01010113          	addi	sp,sp,16
    80004578:	00008067          	ret
    8000457c:	00001517          	auipc	a0,0x1
    80004580:	d0c50513          	addi	a0,a0,-756 # 80005288 <digits+0x48>
    80004584:	fffff097          	auipc	ra,0xfffff
    80004588:	018080e7          	jalr	24(ra) # 8000359c <panic>
    8000458c:	00001517          	auipc	a0,0x1
    80004590:	ce450513          	addi	a0,a0,-796 # 80005270 <digits+0x30>
    80004594:	fffff097          	auipc	ra,0xfffff
    80004598:	008080e7          	jalr	8(ra) # 8000359c <panic>

000000008000459c <push_on>:
    8000459c:	fe010113          	addi	sp,sp,-32
    800045a0:	00813823          	sd	s0,16(sp)
    800045a4:	00113c23          	sd	ra,24(sp)
    800045a8:	00913423          	sd	s1,8(sp)
    800045ac:	02010413          	addi	s0,sp,32
    800045b0:	100024f3          	csrr	s1,sstatus
    800045b4:	100027f3          	csrr	a5,sstatus
    800045b8:	0027e793          	ori	a5,a5,2
    800045bc:	10079073          	csrw	sstatus,a5
    800045c0:	ffffe097          	auipc	ra,0xffffe
    800045c4:	624080e7          	jalr	1572(ra) # 80002be4 <mycpu>
    800045c8:	07852783          	lw	a5,120(a0)
    800045cc:	02078663          	beqz	a5,800045f8 <push_on+0x5c>
    800045d0:	ffffe097          	auipc	ra,0xffffe
    800045d4:	614080e7          	jalr	1556(ra) # 80002be4 <mycpu>
    800045d8:	07852783          	lw	a5,120(a0)
    800045dc:	01813083          	ld	ra,24(sp)
    800045e0:	01013403          	ld	s0,16(sp)
    800045e4:	0017879b          	addiw	a5,a5,1
    800045e8:	06f52c23          	sw	a5,120(a0)
    800045ec:	00813483          	ld	s1,8(sp)
    800045f0:	02010113          	addi	sp,sp,32
    800045f4:	00008067          	ret
    800045f8:	0014d493          	srli	s1,s1,0x1
    800045fc:	ffffe097          	auipc	ra,0xffffe
    80004600:	5e8080e7          	jalr	1512(ra) # 80002be4 <mycpu>
    80004604:	0014f493          	andi	s1,s1,1
    80004608:	06952e23          	sw	s1,124(a0)
    8000460c:	fc5ff06f          	j	800045d0 <push_on+0x34>

0000000080004610 <pop_on>:
    80004610:	ff010113          	addi	sp,sp,-16
    80004614:	00813023          	sd	s0,0(sp)
    80004618:	00113423          	sd	ra,8(sp)
    8000461c:	01010413          	addi	s0,sp,16
    80004620:	ffffe097          	auipc	ra,0xffffe
    80004624:	5c4080e7          	jalr	1476(ra) # 80002be4 <mycpu>
    80004628:	100027f3          	csrr	a5,sstatus
    8000462c:	0027f793          	andi	a5,a5,2
    80004630:	04078463          	beqz	a5,80004678 <pop_on+0x68>
    80004634:	07852783          	lw	a5,120(a0)
    80004638:	02f05863          	blez	a5,80004668 <pop_on+0x58>
    8000463c:	fff7879b          	addiw	a5,a5,-1
    80004640:	06f52c23          	sw	a5,120(a0)
    80004644:	07853783          	ld	a5,120(a0)
    80004648:	00079863          	bnez	a5,80004658 <pop_on+0x48>
    8000464c:	100027f3          	csrr	a5,sstatus
    80004650:	ffd7f793          	andi	a5,a5,-3
    80004654:	10079073          	csrw	sstatus,a5
    80004658:	00813083          	ld	ra,8(sp)
    8000465c:	00013403          	ld	s0,0(sp)
    80004660:	01010113          	addi	sp,sp,16
    80004664:	00008067          	ret
    80004668:	00001517          	auipc	a0,0x1
    8000466c:	c4850513          	addi	a0,a0,-952 # 800052b0 <digits+0x70>
    80004670:	fffff097          	auipc	ra,0xfffff
    80004674:	f2c080e7          	jalr	-212(ra) # 8000359c <panic>
    80004678:	00001517          	auipc	a0,0x1
    8000467c:	c1850513          	addi	a0,a0,-1000 # 80005290 <digits+0x50>
    80004680:	fffff097          	auipc	ra,0xfffff
    80004684:	f1c080e7          	jalr	-228(ra) # 8000359c <panic>

0000000080004688 <__memset>:
    80004688:	ff010113          	addi	sp,sp,-16
    8000468c:	00813423          	sd	s0,8(sp)
    80004690:	01010413          	addi	s0,sp,16
    80004694:	1a060e63          	beqz	a2,80004850 <__memset+0x1c8>
    80004698:	40a007b3          	neg	a5,a0
    8000469c:	0077f793          	andi	a5,a5,7
    800046a0:	00778693          	addi	a3,a5,7
    800046a4:	00b00813          	li	a6,11
    800046a8:	0ff5f593          	andi	a1,a1,255
    800046ac:	fff6071b          	addiw	a4,a2,-1
    800046b0:	1b06e663          	bltu	a3,a6,8000485c <__memset+0x1d4>
    800046b4:	1cd76463          	bltu	a4,a3,8000487c <__memset+0x1f4>
    800046b8:	1a078e63          	beqz	a5,80004874 <__memset+0x1ec>
    800046bc:	00b50023          	sb	a1,0(a0)
    800046c0:	00100713          	li	a4,1
    800046c4:	1ae78463          	beq	a5,a4,8000486c <__memset+0x1e4>
    800046c8:	00b500a3          	sb	a1,1(a0)
    800046cc:	00200713          	li	a4,2
    800046d0:	1ae78a63          	beq	a5,a4,80004884 <__memset+0x1fc>
    800046d4:	00b50123          	sb	a1,2(a0)
    800046d8:	00300713          	li	a4,3
    800046dc:	18e78463          	beq	a5,a4,80004864 <__memset+0x1dc>
    800046e0:	00b501a3          	sb	a1,3(a0)
    800046e4:	00400713          	li	a4,4
    800046e8:	1ae78263          	beq	a5,a4,8000488c <__memset+0x204>
    800046ec:	00b50223          	sb	a1,4(a0)
    800046f0:	00500713          	li	a4,5
    800046f4:	1ae78063          	beq	a5,a4,80004894 <__memset+0x20c>
    800046f8:	00b502a3          	sb	a1,5(a0)
    800046fc:	00700713          	li	a4,7
    80004700:	18e79e63          	bne	a5,a4,8000489c <__memset+0x214>
    80004704:	00b50323          	sb	a1,6(a0)
    80004708:	00700e93          	li	t4,7
    8000470c:	00859713          	slli	a4,a1,0x8
    80004710:	00e5e733          	or	a4,a1,a4
    80004714:	01059e13          	slli	t3,a1,0x10
    80004718:	01c76e33          	or	t3,a4,t3
    8000471c:	01859313          	slli	t1,a1,0x18
    80004720:	006e6333          	or	t1,t3,t1
    80004724:	02059893          	slli	a7,a1,0x20
    80004728:	40f60e3b          	subw	t3,a2,a5
    8000472c:	011368b3          	or	a7,t1,a7
    80004730:	02859813          	slli	a6,a1,0x28
    80004734:	0108e833          	or	a6,a7,a6
    80004738:	03059693          	slli	a3,a1,0x30
    8000473c:	003e589b          	srliw	a7,t3,0x3
    80004740:	00d866b3          	or	a3,a6,a3
    80004744:	03859713          	slli	a4,a1,0x38
    80004748:	00389813          	slli	a6,a7,0x3
    8000474c:	00f507b3          	add	a5,a0,a5
    80004750:	00e6e733          	or	a4,a3,a4
    80004754:	000e089b          	sext.w	a7,t3
    80004758:	00f806b3          	add	a3,a6,a5
    8000475c:	00e7b023          	sd	a4,0(a5)
    80004760:	00878793          	addi	a5,a5,8
    80004764:	fed79ce3          	bne	a5,a3,8000475c <__memset+0xd4>
    80004768:	ff8e7793          	andi	a5,t3,-8
    8000476c:	0007871b          	sext.w	a4,a5
    80004770:	01d787bb          	addw	a5,a5,t4
    80004774:	0ce88e63          	beq	a7,a4,80004850 <__memset+0x1c8>
    80004778:	00f50733          	add	a4,a0,a5
    8000477c:	00b70023          	sb	a1,0(a4)
    80004780:	0017871b          	addiw	a4,a5,1
    80004784:	0cc77663          	bgeu	a4,a2,80004850 <__memset+0x1c8>
    80004788:	00e50733          	add	a4,a0,a4
    8000478c:	00b70023          	sb	a1,0(a4)
    80004790:	0027871b          	addiw	a4,a5,2
    80004794:	0ac77e63          	bgeu	a4,a2,80004850 <__memset+0x1c8>
    80004798:	00e50733          	add	a4,a0,a4
    8000479c:	00b70023          	sb	a1,0(a4)
    800047a0:	0037871b          	addiw	a4,a5,3
    800047a4:	0ac77663          	bgeu	a4,a2,80004850 <__memset+0x1c8>
    800047a8:	00e50733          	add	a4,a0,a4
    800047ac:	00b70023          	sb	a1,0(a4)
    800047b0:	0047871b          	addiw	a4,a5,4
    800047b4:	08c77e63          	bgeu	a4,a2,80004850 <__memset+0x1c8>
    800047b8:	00e50733          	add	a4,a0,a4
    800047bc:	00b70023          	sb	a1,0(a4)
    800047c0:	0057871b          	addiw	a4,a5,5
    800047c4:	08c77663          	bgeu	a4,a2,80004850 <__memset+0x1c8>
    800047c8:	00e50733          	add	a4,a0,a4
    800047cc:	00b70023          	sb	a1,0(a4)
    800047d0:	0067871b          	addiw	a4,a5,6
    800047d4:	06c77e63          	bgeu	a4,a2,80004850 <__memset+0x1c8>
    800047d8:	00e50733          	add	a4,a0,a4
    800047dc:	00b70023          	sb	a1,0(a4)
    800047e0:	0077871b          	addiw	a4,a5,7
    800047e4:	06c77663          	bgeu	a4,a2,80004850 <__memset+0x1c8>
    800047e8:	00e50733          	add	a4,a0,a4
    800047ec:	00b70023          	sb	a1,0(a4)
    800047f0:	0087871b          	addiw	a4,a5,8
    800047f4:	04c77e63          	bgeu	a4,a2,80004850 <__memset+0x1c8>
    800047f8:	00e50733          	add	a4,a0,a4
    800047fc:	00b70023          	sb	a1,0(a4)
    80004800:	0097871b          	addiw	a4,a5,9
    80004804:	04c77663          	bgeu	a4,a2,80004850 <__memset+0x1c8>
    80004808:	00e50733          	add	a4,a0,a4
    8000480c:	00b70023          	sb	a1,0(a4)
    80004810:	00a7871b          	addiw	a4,a5,10
    80004814:	02c77e63          	bgeu	a4,a2,80004850 <__memset+0x1c8>
    80004818:	00e50733          	add	a4,a0,a4
    8000481c:	00b70023          	sb	a1,0(a4)
    80004820:	00b7871b          	addiw	a4,a5,11
    80004824:	02c77663          	bgeu	a4,a2,80004850 <__memset+0x1c8>
    80004828:	00e50733          	add	a4,a0,a4
    8000482c:	00b70023          	sb	a1,0(a4)
    80004830:	00c7871b          	addiw	a4,a5,12
    80004834:	00c77e63          	bgeu	a4,a2,80004850 <__memset+0x1c8>
    80004838:	00e50733          	add	a4,a0,a4
    8000483c:	00b70023          	sb	a1,0(a4)
    80004840:	00d7879b          	addiw	a5,a5,13
    80004844:	00c7f663          	bgeu	a5,a2,80004850 <__memset+0x1c8>
    80004848:	00f507b3          	add	a5,a0,a5
    8000484c:	00b78023          	sb	a1,0(a5)
    80004850:	00813403          	ld	s0,8(sp)
    80004854:	01010113          	addi	sp,sp,16
    80004858:	00008067          	ret
    8000485c:	00b00693          	li	a3,11
    80004860:	e55ff06f          	j	800046b4 <__memset+0x2c>
    80004864:	00300e93          	li	t4,3
    80004868:	ea5ff06f          	j	8000470c <__memset+0x84>
    8000486c:	00100e93          	li	t4,1
    80004870:	e9dff06f          	j	8000470c <__memset+0x84>
    80004874:	00000e93          	li	t4,0
    80004878:	e95ff06f          	j	8000470c <__memset+0x84>
    8000487c:	00000793          	li	a5,0
    80004880:	ef9ff06f          	j	80004778 <__memset+0xf0>
    80004884:	00200e93          	li	t4,2
    80004888:	e85ff06f          	j	8000470c <__memset+0x84>
    8000488c:	00400e93          	li	t4,4
    80004890:	e7dff06f          	j	8000470c <__memset+0x84>
    80004894:	00500e93          	li	t4,5
    80004898:	e75ff06f          	j	8000470c <__memset+0x84>
    8000489c:	00600e93          	li	t4,6
    800048a0:	e6dff06f          	j	8000470c <__memset+0x84>

00000000800048a4 <__memmove>:
    800048a4:	ff010113          	addi	sp,sp,-16
    800048a8:	00813423          	sd	s0,8(sp)
    800048ac:	01010413          	addi	s0,sp,16
    800048b0:	0e060863          	beqz	a2,800049a0 <__memmove+0xfc>
    800048b4:	fff6069b          	addiw	a3,a2,-1
    800048b8:	0006881b          	sext.w	a6,a3
    800048bc:	0ea5e863          	bltu	a1,a0,800049ac <__memmove+0x108>
    800048c0:	00758713          	addi	a4,a1,7
    800048c4:	00a5e7b3          	or	a5,a1,a0
    800048c8:	40a70733          	sub	a4,a4,a0
    800048cc:	0077f793          	andi	a5,a5,7
    800048d0:	00f73713          	sltiu	a4,a4,15
    800048d4:	00174713          	xori	a4,a4,1
    800048d8:	0017b793          	seqz	a5,a5
    800048dc:	00e7f7b3          	and	a5,a5,a4
    800048e0:	10078863          	beqz	a5,800049f0 <__memmove+0x14c>
    800048e4:	00900793          	li	a5,9
    800048e8:	1107f463          	bgeu	a5,a6,800049f0 <__memmove+0x14c>
    800048ec:	0036581b          	srliw	a6,a2,0x3
    800048f0:	fff8081b          	addiw	a6,a6,-1
    800048f4:	02081813          	slli	a6,a6,0x20
    800048f8:	01d85893          	srli	a7,a6,0x1d
    800048fc:	00858813          	addi	a6,a1,8
    80004900:	00058793          	mv	a5,a1
    80004904:	00050713          	mv	a4,a0
    80004908:	01088833          	add	a6,a7,a6
    8000490c:	0007b883          	ld	a7,0(a5)
    80004910:	00878793          	addi	a5,a5,8
    80004914:	00870713          	addi	a4,a4,8
    80004918:	ff173c23          	sd	a7,-8(a4)
    8000491c:	ff0798e3          	bne	a5,a6,8000490c <__memmove+0x68>
    80004920:	ff867713          	andi	a4,a2,-8
    80004924:	02071793          	slli	a5,a4,0x20
    80004928:	0207d793          	srli	a5,a5,0x20
    8000492c:	00f585b3          	add	a1,a1,a5
    80004930:	40e686bb          	subw	a3,a3,a4
    80004934:	00f507b3          	add	a5,a0,a5
    80004938:	06e60463          	beq	a2,a4,800049a0 <__memmove+0xfc>
    8000493c:	0005c703          	lbu	a4,0(a1)
    80004940:	00e78023          	sb	a4,0(a5)
    80004944:	04068e63          	beqz	a3,800049a0 <__memmove+0xfc>
    80004948:	0015c603          	lbu	a2,1(a1)
    8000494c:	00100713          	li	a4,1
    80004950:	00c780a3          	sb	a2,1(a5)
    80004954:	04e68663          	beq	a3,a4,800049a0 <__memmove+0xfc>
    80004958:	0025c603          	lbu	a2,2(a1)
    8000495c:	00200713          	li	a4,2
    80004960:	00c78123          	sb	a2,2(a5)
    80004964:	02e68e63          	beq	a3,a4,800049a0 <__memmove+0xfc>
    80004968:	0035c603          	lbu	a2,3(a1)
    8000496c:	00300713          	li	a4,3
    80004970:	00c781a3          	sb	a2,3(a5)
    80004974:	02e68663          	beq	a3,a4,800049a0 <__memmove+0xfc>
    80004978:	0045c603          	lbu	a2,4(a1)
    8000497c:	00400713          	li	a4,4
    80004980:	00c78223          	sb	a2,4(a5)
    80004984:	00e68e63          	beq	a3,a4,800049a0 <__memmove+0xfc>
    80004988:	0055c603          	lbu	a2,5(a1)
    8000498c:	00500713          	li	a4,5
    80004990:	00c782a3          	sb	a2,5(a5)
    80004994:	00e68663          	beq	a3,a4,800049a0 <__memmove+0xfc>
    80004998:	0065c703          	lbu	a4,6(a1)
    8000499c:	00e78323          	sb	a4,6(a5)
    800049a0:	00813403          	ld	s0,8(sp)
    800049a4:	01010113          	addi	sp,sp,16
    800049a8:	00008067          	ret
    800049ac:	02061713          	slli	a4,a2,0x20
    800049b0:	02075713          	srli	a4,a4,0x20
    800049b4:	00e587b3          	add	a5,a1,a4
    800049b8:	f0f574e3          	bgeu	a0,a5,800048c0 <__memmove+0x1c>
    800049bc:	02069613          	slli	a2,a3,0x20
    800049c0:	02065613          	srli	a2,a2,0x20
    800049c4:	fff64613          	not	a2,a2
    800049c8:	00e50733          	add	a4,a0,a4
    800049cc:	00c78633          	add	a2,a5,a2
    800049d0:	fff7c683          	lbu	a3,-1(a5)
    800049d4:	fff78793          	addi	a5,a5,-1
    800049d8:	fff70713          	addi	a4,a4,-1
    800049dc:	00d70023          	sb	a3,0(a4)
    800049e0:	fec798e3          	bne	a5,a2,800049d0 <__memmove+0x12c>
    800049e4:	00813403          	ld	s0,8(sp)
    800049e8:	01010113          	addi	sp,sp,16
    800049ec:	00008067          	ret
    800049f0:	02069713          	slli	a4,a3,0x20
    800049f4:	02075713          	srli	a4,a4,0x20
    800049f8:	00170713          	addi	a4,a4,1
    800049fc:	00e50733          	add	a4,a0,a4
    80004a00:	00050793          	mv	a5,a0
    80004a04:	0005c683          	lbu	a3,0(a1)
    80004a08:	00178793          	addi	a5,a5,1
    80004a0c:	00158593          	addi	a1,a1,1
    80004a10:	fed78fa3          	sb	a3,-1(a5)
    80004a14:	fee798e3          	bne	a5,a4,80004a04 <__memmove+0x160>
    80004a18:	f89ff06f          	j	800049a0 <__memmove+0xfc>

0000000080004a1c <__putc>:
    80004a1c:	fe010113          	addi	sp,sp,-32
    80004a20:	00813823          	sd	s0,16(sp)
    80004a24:	00113c23          	sd	ra,24(sp)
    80004a28:	02010413          	addi	s0,sp,32
    80004a2c:	00050793          	mv	a5,a0
    80004a30:	fef40593          	addi	a1,s0,-17
    80004a34:	00100613          	li	a2,1
    80004a38:	00000513          	li	a0,0
    80004a3c:	fef407a3          	sb	a5,-17(s0)
    80004a40:	fffff097          	auipc	ra,0xfffff
    80004a44:	b3c080e7          	jalr	-1220(ra) # 8000357c <console_write>
    80004a48:	01813083          	ld	ra,24(sp)
    80004a4c:	01013403          	ld	s0,16(sp)
    80004a50:	02010113          	addi	sp,sp,32
    80004a54:	00008067          	ret

0000000080004a58 <__getc>:
    80004a58:	fe010113          	addi	sp,sp,-32
    80004a5c:	00813823          	sd	s0,16(sp)
    80004a60:	00113c23          	sd	ra,24(sp)
    80004a64:	02010413          	addi	s0,sp,32
    80004a68:	fe840593          	addi	a1,s0,-24
    80004a6c:	00100613          	li	a2,1
    80004a70:	00000513          	li	a0,0
    80004a74:	fffff097          	auipc	ra,0xfffff
    80004a78:	ae8080e7          	jalr	-1304(ra) # 8000355c <console_read>
    80004a7c:	fe844503          	lbu	a0,-24(s0)
    80004a80:	01813083          	ld	ra,24(sp)
    80004a84:	01013403          	ld	s0,16(sp)
    80004a88:	02010113          	addi	sp,sp,32
    80004a8c:	00008067          	ret

0000000080004a90 <console_handler>:
    80004a90:	fe010113          	addi	sp,sp,-32
    80004a94:	00813823          	sd	s0,16(sp)
    80004a98:	00113c23          	sd	ra,24(sp)
    80004a9c:	00913423          	sd	s1,8(sp)
    80004aa0:	02010413          	addi	s0,sp,32
    80004aa4:	14202773          	csrr	a4,scause
    80004aa8:	100027f3          	csrr	a5,sstatus
    80004aac:	0027f793          	andi	a5,a5,2
    80004ab0:	06079e63          	bnez	a5,80004b2c <console_handler+0x9c>
    80004ab4:	00074c63          	bltz	a4,80004acc <console_handler+0x3c>
    80004ab8:	01813083          	ld	ra,24(sp)
    80004abc:	01013403          	ld	s0,16(sp)
    80004ac0:	00813483          	ld	s1,8(sp)
    80004ac4:	02010113          	addi	sp,sp,32
    80004ac8:	00008067          	ret
    80004acc:	0ff77713          	andi	a4,a4,255
    80004ad0:	00900793          	li	a5,9
    80004ad4:	fef712e3          	bne	a4,a5,80004ab8 <console_handler+0x28>
    80004ad8:	ffffe097          	auipc	ra,0xffffe
    80004adc:	6dc080e7          	jalr	1756(ra) # 800031b4 <plic_claim>
    80004ae0:	00a00793          	li	a5,10
    80004ae4:	00050493          	mv	s1,a0
    80004ae8:	02f50c63          	beq	a0,a5,80004b20 <console_handler+0x90>
    80004aec:	fc0506e3          	beqz	a0,80004ab8 <console_handler+0x28>
    80004af0:	00050593          	mv	a1,a0
    80004af4:	00000517          	auipc	a0,0x0
    80004af8:	6c450513          	addi	a0,a0,1732 # 800051b8 <CONSOLE_STATUS+0x1a0>
    80004afc:	fffff097          	auipc	ra,0xfffff
    80004b00:	afc080e7          	jalr	-1284(ra) # 800035f8 <__printf>
    80004b04:	01013403          	ld	s0,16(sp)
    80004b08:	01813083          	ld	ra,24(sp)
    80004b0c:	00048513          	mv	a0,s1
    80004b10:	00813483          	ld	s1,8(sp)
    80004b14:	02010113          	addi	sp,sp,32
    80004b18:	ffffe317          	auipc	t1,0xffffe
    80004b1c:	6d430067          	jr	1748(t1) # 800031ec <plic_complete>
    80004b20:	fffff097          	auipc	ra,0xfffff
    80004b24:	3e0080e7          	jalr	992(ra) # 80003f00 <uartintr>
    80004b28:	fddff06f          	j	80004b04 <console_handler+0x74>
    80004b2c:	00000517          	auipc	a0,0x0
    80004b30:	78c50513          	addi	a0,a0,1932 # 800052b8 <digits+0x78>
    80004b34:	fffff097          	auipc	ra,0xfffff
    80004b38:	a68080e7          	jalr	-1432(ra) # 8000359c <panic>
	...
