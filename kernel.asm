
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
    8000001c:	6f8020ef          	jal	ra,80002714 <start>

0000000080000020 <spin>:
    80000020:	0000006f          	j	80000020 <spin>
	...

0000000080001000 <supervisorTrap>:
.align 4
.global supervisorTrap
.type supervisorTrap @function
supervisorTrap:
    # push all registers to stack
    addi sp, sp, -256
    80001000:	f0010113          	addi	sp,sp,-256
    .irp index, 0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31
    sd x\index, \index * 8(sp)
    .endr
    80001004:	00013023          	sd	zero,0(sp)
    80001008:	00113423          	sd	ra,8(sp)
    8000100c:	00213823          	sd	sp,16(sp)
    80001010:	00313c23          	sd	gp,24(sp)
    80001014:	02413023          	sd	tp,32(sp)
    80001018:	02513423          	sd	t0,40(sp)
    8000101c:	02613823          	sd	t1,48(sp)
    80001020:	02713c23          	sd	t2,56(sp)
    80001024:	04813023          	sd	s0,64(sp)
    80001028:	04913423          	sd	s1,72(sp)
    8000102c:	04a13823          	sd	a0,80(sp)
    80001030:	04b13c23          	sd	a1,88(sp)
    80001034:	06c13023          	sd	a2,96(sp)
    80001038:	06d13423          	sd	a3,104(sp)
    8000103c:	06e13823          	sd	a4,112(sp)
    80001040:	06f13c23          	sd	a5,120(sp)
    80001044:	09013023          	sd	a6,128(sp)
    80001048:	09113423          	sd	a7,136(sp)
    8000104c:	09213823          	sd	s2,144(sp)
    80001050:	09313c23          	sd	s3,152(sp)
    80001054:	0b413023          	sd	s4,160(sp)
    80001058:	0b513423          	sd	s5,168(sp)
    8000105c:	0b613823          	sd	s6,176(sp)
    80001060:	0b713c23          	sd	s7,184(sp)
    80001064:	0d813023          	sd	s8,192(sp)
    80001068:	0d913423          	sd	s9,200(sp)
    8000106c:	0da13823          	sd	s10,208(sp)
    80001070:	0db13c23          	sd	s11,216(sp)
    80001074:	0fc13023          	sd	t3,224(sp)
    80001078:	0fd13423          	sd	t4,232(sp)
    8000107c:	0fe13823          	sd	t5,240(sp)
    80001080:	0ff13c23          	sd	t6,248(sp)

    call handleSupervisorTrap
    80001084:	4d0000ef          	jal	ra,80001554 <handleSupervisorTrap>

    # pop all registers from stack
    .irp index, 0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31
    ld x\index, \index * 8(sp)
    .endr
    80001088:	00013003          	ld	zero,0(sp)
    8000108c:	00813083          	ld	ra,8(sp)
    80001090:	01013103          	ld	sp,16(sp)
    80001094:	01813183          	ld	gp,24(sp)
    80001098:	02013203          	ld	tp,32(sp)
    8000109c:	02813283          	ld	t0,40(sp)
    800010a0:	03013303          	ld	t1,48(sp)
    800010a4:	03813383          	ld	t2,56(sp)
    800010a8:	04013403          	ld	s0,64(sp)
    800010ac:	04813483          	ld	s1,72(sp)
    800010b0:	05013503          	ld	a0,80(sp)
    800010b4:	05813583          	ld	a1,88(sp)
    800010b8:	06013603          	ld	a2,96(sp)
    800010bc:	06813683          	ld	a3,104(sp)
    800010c0:	07013703          	ld	a4,112(sp)
    800010c4:	07813783          	ld	a5,120(sp)
    800010c8:	08013803          	ld	a6,128(sp)
    800010cc:	08813883          	ld	a7,136(sp)
    800010d0:	09013903          	ld	s2,144(sp)
    800010d4:	09813983          	ld	s3,152(sp)
    800010d8:	0a013a03          	ld	s4,160(sp)
    800010dc:	0a813a83          	ld	s5,168(sp)
    800010e0:	0b013b03          	ld	s6,176(sp)
    800010e4:	0b813b83          	ld	s7,184(sp)
    800010e8:	0c013c03          	ld	s8,192(sp)
    800010ec:	0c813c83          	ld	s9,200(sp)
    800010f0:	0d013d03          	ld	s10,208(sp)
    800010f4:	0d813d83          	ld	s11,216(sp)
    800010f8:	0e013e03          	ld	t3,224(sp)
    800010fc:	0e813e83          	ld	t4,232(sp)
    80001100:	0f013f03          	ld	t5,240(sp)
    80001104:	0f813f83          	ld	t6,248(sp)
    addi sp, sp, 256
    80001108:	10010113          	addi	sp,sp,256

    sret
    8000110c:	10200073          	sret

0000000080001110 <contextSwitch>:
.global contextSwitch
.type contextSwitch, @function
contextSwitch:
    sd ra, 0 * 8(a0)
    80001110:	00153023          	sd	ra,0(a0) # 1000 <_entry-0x7ffff000>
    sd sp, 1 * 8(a0)
    80001114:	00253423          	sd	sp,8(a0)

    ld ra, 0 * 8(a1)
    80001118:	0005b083          	ld	ra,0(a1)
    ld sp, 1 * 8(a1)
    8000111c:	0085b103          	ld	sp,8(a1)

    80001120:	00008067          	ret

0000000080001124 <kern_sem_init>:
#define MAX_SEMAPHORES 256

struct sem_s semaphores[MAX_SEMAPHORES];

void kern_sem_init()
{
    80001124:	ff010113          	addi	sp,sp,-16
    80001128:	00813423          	sd	s0,8(sp)
    8000112c:	01010413          	addi	s0,sp,16
    for(int i=0;i<MAX_SEMAPHORES;i++){
    80001130:	00000713          	li	a4,0
    80001134:	0ff00793          	li	a5,255
    80001138:	02e7c663          	blt	a5,a4,80001164 <kern_sem_init+0x40>
        semaphores[i].waiting_thread=0;
    8000113c:	00471693          	slli	a3,a4,0x4
    80001140:	00004797          	auipc	a5,0x4
    80001144:	55078793          	addi	a5,a5,1360 # 80005690 <semaphores>
    80001148:	00d787b3          	add	a5,a5,a3
    8000114c:	0007b423          	sd	zero,8(a5)
        semaphores[i].val=0;
    80001150:	0007a023          	sw	zero,0(a5)
        semaphores[i].status=SEM_UNUSED;
    80001154:	00100693          	li	a3,1
    80001158:	00d7a223          	sw	a3,4(a5)
    for(int i=0;i<MAX_SEMAPHORES;i++){
    8000115c:	0017071b          	addiw	a4,a4,1
    80001160:	fd5ff06f          	j	80001134 <kern_sem_init+0x10>
    }
}
    80001164:	00813403          	ld	s0,8(sp)
    80001168:	01010113          	addi	sp,sp,16
    8000116c:	00008067          	ret

0000000080001170 <kern_sem_open>:

int kern_sem_open (sem_t* handle, unsigned init)
{
    80001170:	ff010113          	addi	sp,sp,-16
    80001174:	00813423          	sd	s0,8(sp)
    80001178:	01010413          	addi	s0,sp,16
    int res=-1;
    for(int i=0;i<MAX_SEMAPHORES;i++){
    8000117c:	00000793          	li	a5,0
    80001180:	0080006f          	j	80001188 <kern_sem_open+0x18>
    80001184:	0017879b          	addiw	a5,a5,1
    80001188:	0ff00713          	li	a4,255
    8000118c:	04f74663          	blt	a4,a5,800011d8 <kern_sem_open+0x68>
        if(semaphores[i].status==SEM_UNUSED){
    80001190:	00479693          	slli	a3,a5,0x4
    80001194:	00004717          	auipc	a4,0x4
    80001198:	4fc70713          	addi	a4,a4,1276 # 80005690 <semaphores>
    8000119c:	00d70733          	add	a4,a4,a3
    800011a0:	00472683          	lw	a3,4(a4)
    800011a4:	00100713          	li	a4,1
    800011a8:	fce69ee3          	bne	a3,a4,80001184 <kern_sem_open+0x14>
            semaphores[i].status=SEM_USED;
    800011ac:	00479793          	slli	a5,a5,0x4
    800011b0:	00004717          	auipc	a4,0x4
    800011b4:	4e070713          	addi	a4,a4,1248 # 80005690 <semaphores>
    800011b8:	00f707b3          	add	a5,a4,a5
    800011bc:	0007a223          	sw	zero,4(a5)
            semaphores[i].val=init;
    800011c0:	00b7a023          	sw	a1,0(a5)
            *handle=&semaphores[i];
    800011c4:	00f53023          	sd	a5,0(a0)
            res++;
    800011c8:	00000513          	li	a0,0
            break;
        }
    }
    return res;
}
    800011cc:	00813403          	ld	s0,8(sp)
    800011d0:	01010113          	addi	sp,sp,16
    800011d4:	00008067          	ret
    int res=-1;
    800011d8:	fff00513          	li	a0,-1
    800011dc:	ff1ff06f          	j	800011cc <kern_sem_open+0x5c>

00000000800011e0 <kern_sem_close>:

int kern_sem_close (sem_t handle)
{
    800011e0:	ff010113          	addi	sp,sp,-16
    800011e4:	00813423          	sd	s0,8(sp)
    800011e8:	01010413          	addi	s0,sp,16
    handle->status=UNUSED;
    800011ec:	00052223          	sw	zero,4(a0)
    handle->val=0;
    800011f0:	00052023          	sw	zero,0(a0)
    if(handle->waiting_thread!=0){
    800011f4:	00853783          	ld	a5,8(a0)
    800011f8:	02079263          	bnez	a5,8000121c <kern_sem_close+0x3c>
    800011fc:	0280006f          	j	80001224 <kern_sem_close+0x44>
        thread_t curr = handle->waiting_thread;
        while(curr){
            curr->syscall_retval=-2;
    80001200:	ffe00713          	li	a4,-2
    80001204:	04e7b023          	sd	a4,64(a5)
            curr->status=READY;
    80001208:	00200713          	li	a4,2
    8000120c:	04e7a823          	sw	a4,80(a5)
            thread_t prev=curr;
            curr=curr->sem_next;
    80001210:	0587b703          	ld	a4,88(a5)
            prev->sem_next=0;
    80001214:	0407bc23          	sd	zero,88(a5)
            curr=curr->sem_next;
    80001218:	00070793          	mv	a5,a4
        while(curr){
    8000121c:	fe0792e3          	bnez	a5,80001200 <kern_sem_close+0x20>
        }
        handle->waiting_thread=0;
    80001220:	00053423          	sd	zero,8(a0)
    }
    return 0;
}
    80001224:	00000513          	li	a0,0
    80001228:	00813403          	ld	s0,8(sp)
    8000122c:	01010113          	addi	sp,sp,16
    80001230:	00008067          	ret

0000000080001234 <kern_sem_signal>:

void kern_sem_signal(sem_t id)
{
    80001234:	ff010113          	addi	sp,sp,-16
    80001238:	00813423          	sd	s0,8(sp)
    8000123c:	01010413          	addi	s0,sp,16
    if(id->val>0 || id->waiting_thread==0) id->val++;
    80001240:	00052783          	lw	a5,0(a0)
    80001244:	00f05c63          	blez	a5,8000125c <kern_sem_signal+0x28>
    80001248:	0017879b          	addiw	a5,a5,1
    8000124c:	00f52023          	sw	a5,0(a0)
        thread_t woken = id->waiting_thread;
        id->waiting_thread=woken->sem_next;
        woken->syscall_retval=0;
        woken->status=READY;
    }
}
    80001250:	00813403          	ld	s0,8(sp)
    80001254:	01010113          	addi	sp,sp,16
    80001258:	00008067          	ret
    if(id->val>0 || id->waiting_thread==0) id->val++;
    8000125c:	00853703          	ld	a4,8(a0)
    80001260:	fe0704e3          	beqz	a4,80001248 <kern_sem_signal+0x14>
        id->waiting_thread=woken->sem_next;
    80001264:	05873783          	ld	a5,88(a4)
    80001268:	00f53423          	sd	a5,8(a0)
        woken->syscall_retval=0;
    8000126c:	04073023          	sd	zero,64(a4)
        woken->status=READY;
    80001270:	00200793          	li	a5,2
    80001274:	04f72823          	sw	a5,80(a4)
}
    80001278:	fd9ff06f          	j	80001250 <kern_sem_signal+0x1c>

000000008000127c <kern_sem_wait>:

int kern_sem_wait(sem_t id)
{
    8000127c:	ff010113          	addi	sp,sp,-16
    80001280:	00813423          	sd	s0,8(sp)
    80001284:	01010413          	addi	s0,sp,16
    id->val--;
    80001288:	00052783          	lw	a5,0(a0)
    8000128c:	fff7879b          	addiw	a5,a5,-1
    80001290:	00f52023          	sw	a5,0(a0)
    if(id->val<0){
    80001294:	02079713          	slli	a4,a5,0x20
    80001298:	00074a63          	bltz	a4,800012ac <kern_sem_wait+0x30>
        }
        running->sem_next=0;
        return -1;
    }
    else {
        return 1;
    8000129c:	00100513          	li	a0,1
    }
}
    800012a0:	00813403          	ld	s0,8(sp)
    800012a4:	01010113          	addi	sp,sp,16
    800012a8:	00008067          	ret
        running->status=SUSPENDED;
    800012ac:	00004697          	auipc	a3,0x4
    800012b0:	3b46b683          	ld	a3,948(a3) # 80005660 <running>
    800012b4:	00300793          	li	a5,3
    800012b8:	04f6a823          	sw	a5,80(a3)
        if(id->waiting_thread==0) id->waiting_thread=running;
    800012bc:	00853783          	ld	a5,8(a0)
    800012c0:	02078063          	beqz	a5,800012e0 <kern_sem_wait+0x64>
            while (curr->sem_next!=0) curr=curr->sem_next;
    800012c4:	00078713          	mv	a4,a5
    800012c8:	0587b783          	ld	a5,88(a5)
    800012cc:	fe079ce3          	bnez	a5,800012c4 <kern_sem_wait+0x48>
            curr->sem_next=running;
    800012d0:	04d73c23          	sd	a3,88(a4)
        running->sem_next=0;
    800012d4:	0406bc23          	sd	zero,88(a3)
        return -1;
    800012d8:	fff00513          	li	a0,-1
    800012dc:	fc5ff06f          	j	800012a0 <kern_sem_wait+0x24>
        if(id->waiting_thread==0) id->waiting_thread=running;
    800012e0:	00d53423          	sd	a3,8(a0)
    800012e4:	ff1ff06f          	j	800012d4 <kern_sem_wait+0x58>

00000000800012e8 <kern_mem_alloc>:

mem_block_s * freeHead;


void* kern_mem_alloc(int sizeInBlocks)
{
    800012e8:	ff010113          	addi	sp,sp,-16
    800012ec:	00813423          	sd	s0,8(sp)
    800012f0:	01010413          	addi	s0,sp,16
    800012f4:	00050693          	mv	a3,a0
    mem_block_s *curr = freeHead;
    800012f8:	00004597          	auipc	a1,0x4
    800012fc:	3505b583          	ld	a1,848(a1) # 80005648 <freeHead>
    80001300:	00058513          	mv	a0,a1
    mem_block_s *prev = 0;
    80001304:	00000613          	li	a2,0

    while (curr){
    80001308:	0480006f          	j	80001350 <kern_mem_alloc+0x68>
        if(curr->sizeInBlocks==sizeInBlocks+1){
            if(curr==freeHead) freeHead=curr->next;
    8000130c:	02b50063          	beq	a0,a1,8000132c <kern_mem_alloc+0x44>
            else prev->next = curr->next;
    80001310:	00853783          	ld	a5,8(a0)
    80001314:	00f63423          	sd	a5,8(a2)
            curr->sizeInBlocks=sizeInBlocks+1;
    80001318:	00e52023          	sw	a4,0(a0)
            return (curr+MEM_BLOCK_SIZE);
    8000131c:	40050513          	addi	a0,a0,1024
        prev=curr;
        curr=curr->next;
    }

    return 0;
}
    80001320:	00813403          	ld	s0,8(sp)
    80001324:	01010113          	addi	sp,sp,16
    80001328:	00008067          	ret
            if(curr==freeHead) freeHead=curr->next;
    8000132c:	00853783          	ld	a5,8(a0)
    80001330:	00004697          	auipc	a3,0x4
    80001334:	30f6bc23          	sd	a5,792(a3) # 80005648 <freeHead>
    80001338:	fe1ff06f          	j	80001318 <kern_mem_alloc+0x30>
            if(curr==freeHead) freeHead=newFreeBlock;
    8000133c:	00004797          	auipc	a5,0x4
    80001340:	30b7b623          	sd	a1,780(a5) # 80005648 <freeHead>
    80001344:	05c0006f          	j	800013a0 <kern_mem_alloc+0xb8>
        prev=curr;
    80001348:	00050613          	mv	a2,a0
        curr=curr->next;
    8000134c:	00853503          	ld	a0,8(a0)
    while (curr){
    80001350:	fc0508e3          	beqz	a0,80001320 <kern_mem_alloc+0x38>
        if(curr->sizeInBlocks==sizeInBlocks+1){
    80001354:	00052783          	lw	a5,0(a0)
    80001358:	0016871b          	addiw	a4,a3,1
    8000135c:	fae788e3          	beq	a5,a4,8000130c <kern_mem_alloc+0x24>
        else if(curr->sizeInBlocks>sizeInBlocks+1){
    80001360:	fef754e3          	bge	a4,a5,80001348 <kern_mem_alloc+0x60>
            mem_block_s* newFreeBlock = curr+(sizeInBlocks+1)*MEM_BLOCK_SIZE;
    80001364:	00a71593          	slli	a1,a4,0xa
    80001368:	00b505b3          	add	a1,a0,a1
            newFreeBlock->sizeInBlocks = curr->sizeInBlocks-sizeInBlocks-1;
    8000136c:	40d787bb          	subw	a5,a5,a3
    80001370:	fff7879b          	addiw	a5,a5,-1
    80001374:	00f5a023          	sw	a5,0(a1)
            newFreeBlock->startingBlock=curr->startingBlock+sizeInBlocks+1;
    80001378:	00452783          	lw	a5,4(a0)
    8000137c:	00d786bb          	addw	a3,a5,a3
    80001380:	0016869b          	addiw	a3,a3,1
    80001384:	00d5a223          	sw	a3,4(a1)
            newFreeBlock->next = curr->next;
    80001388:	00853783          	ld	a5,8(a0)
    8000138c:	00f5b423          	sd	a5,8(a1)
            if(curr==freeHead) freeHead=newFreeBlock;
    80001390:	00004797          	auipc	a5,0x4
    80001394:	2b87b783          	ld	a5,696(a5) # 80005648 <freeHead>
    80001398:	faa782e3          	beq	a5,a0,8000133c <kern_mem_alloc+0x54>
            else prev->next=newFreeBlock;
    8000139c:	00b63423          	sd	a1,8(a2)
            curr->sizeInBlocks=sizeInBlocks+1;
    800013a0:	00e52023          	sw	a4,0(a0)
            return (curr+MEM_BLOCK_SIZE);
    800013a4:	40050513          	addi	a0,a0,1024
    800013a8:	f79ff06f          	j	80001320 <kern_mem_alloc+0x38>

00000000800013ac <kern_mem_free>:

int kern_mem_free(void* addr)
{
    800013ac:	ff010113          	addi	sp,sp,-16
    800013b0:	00813423          	sd	s0,8(sp)
    800013b4:	01010413          	addi	s0,sp,16
    mem_block_s* freedBlock = (mem_block_s*) addr-MEM_BLOCK_SIZE;
    800013b8:	c0050713          	addi	a4,a0,-1024
    mem_block_s* curr=freeHead;
    800013bc:	00004797          	auipc	a5,0x4
    800013c0:	28c7b783          	ld	a5,652(a5) # 80005648 <freeHead>
    mem_block_s * prev =0;
    800013c4:	00000693          	li	a3,0

    while (curr<freedBlock && curr!=0){
    800013c8:	00e7fa63          	bgeu	a5,a4,800013dc <kern_mem_free+0x30>
    800013cc:	00078863          	beqz	a5,800013dc <kern_mem_free+0x30>
        prev=curr;
    800013d0:	00078693          	mv	a3,a5
        curr=curr->next;
    800013d4:	0087b783          	ld	a5,8(a5)
    800013d8:	ff1ff06f          	j	800013c8 <kern_mem_free+0x1c>
    char* cfreedBlock = (char *)freedBlock;
    char* cprev = (char *)prev;
    char* ccurr = (char *)curr;
    */

    if(prev){
    800013dc:	04068e63          	beqz	a3,80001438 <kern_mem_free+0x8c>
        if(prev->startingBlock+prev->sizeInBlocks==freedBlock->startingBlock){
    800013e0:	0046a603          	lw	a2,4(a3)
    800013e4:	0006a583          	lw	a1,0(a3)
    800013e8:	00b6063b          	addw	a2,a2,a1
    800013ec:	c0452803          	lw	a6,-1020(a0)
    800013f0:	03060a63          	beq	a2,a6,80001424 <kern_mem_free+0x78>
            prev->sizeInBlocks+=freedBlock->sizeInBlocks;
            freedBlock=prev;
        } else {
            prev->next=freedBlock;
    800013f4:	00e6b423          	sd	a4,8(a3)
        }
    }
    else freeHead=freedBlock;

    if(curr){
    800013f8:	00078e63          	beqz	a5,80001414 <kern_mem_free+0x68>
        if(freedBlock->startingBlock+freedBlock->sizeInBlocks==curr->startingBlock){
    800013fc:	00472683          	lw	a3,4(a4)
    80001400:	00072603          	lw	a2,0(a4)
    80001404:	00c686bb          	addw	a3,a3,a2
    80001408:	0047a583          	lw	a1,4(a5)
    8000140c:	02b68c63          	beq	a3,a1,80001444 <kern_mem_free+0x98>
            freedBlock->sizeInBlocks+=curr->sizeInBlocks;
            freedBlock->next=curr->next;
        } else{
          freedBlock->next=curr;
    80001410:	00f73423          	sd	a5,8(a4)
        }
    }


    return 0;
}
    80001414:	00000513          	li	a0,0
    80001418:	00813403          	ld	s0,8(sp)
    8000141c:	01010113          	addi	sp,sp,16
    80001420:	00008067          	ret
            prev->sizeInBlocks+=freedBlock->sizeInBlocks;
    80001424:	c0052703          	lw	a4,-1024(a0)
    80001428:	00e585bb          	addw	a1,a1,a4
    8000142c:	00b6a023          	sw	a1,0(a3)
            freedBlock=prev;
    80001430:	00068713          	mv	a4,a3
    80001434:	fc5ff06f          	j	800013f8 <kern_mem_free+0x4c>
    else freeHead=freedBlock;
    80001438:	00004697          	auipc	a3,0x4
    8000143c:	20e6b823          	sd	a4,528(a3) # 80005648 <freeHead>
    80001440:	fb9ff06f          	j	800013f8 <kern_mem_free+0x4c>
            freedBlock->sizeInBlocks+=curr->sizeInBlocks;
    80001444:	0007a683          	lw	a3,0(a5)
    80001448:	00d6063b          	addw	a2,a2,a3
    8000144c:	00c72023          	sw	a2,0(a4)
            freedBlock->next=curr->next;
    80001450:	0087b783          	ld	a5,8(a5)
    80001454:	00f73423          	sd	a5,8(a4)
    80001458:	fbdff06f          	j	80001414 <kern_mem_free+0x68>

000000008000145c <kern_mem_init>:

unsigned long ukupno_memorije;
void kern_mem_init(void* start, void* end)
{
    8000145c:	ff010113          	addi	sp,sp,-16
    80001460:	00813423          	sd	s0,8(sp)
    80001464:	01010413          	addi	s0,sp,16
    unsigned long lstart = (unsigned long) start;
    unsigned long lend = (unsigned long) end;
    80001468:	00058793          	mv	a5,a1

    if(lstart%MEM_BLOCK_SIZE>0) start =(void*) ((lstart/MEM_BLOCK_SIZE+1)*MEM_BLOCK_SIZE);
    8000146c:	03f57713          	andi	a4,a0,63
    80001470:	00070863          	beqz	a4,80001480 <kern_mem_init+0x24>
    80001474:	00655513          	srli	a0,a0,0x6
    80001478:	00150513          	addi	a0,a0,1
    8000147c:	00651513          	slli	a0,a0,0x6
    if(lend%MEM_BLOCK_SIZE>0) end =(void*) ((lend/MEM_BLOCK_SIZE)*MEM_BLOCK_SIZE);
    80001480:	03f7f713          	andi	a4,a5,63
    80001484:	00070463          	beqz	a4,8000148c <kern_mem_init+0x30>
    80001488:	fc07f593          	andi	a1,a5,-64

    freeHead = (mem_block_s*)start;
    8000148c:	00004797          	auipc	a5,0x4
    80001490:	1bc78793          	addi	a5,a5,444 # 80005648 <freeHead>
    80001494:	00a7b023          	sd	a0,0(a5)
    freeHead->next=0;
    80001498:	00053423          	sd	zero,8(a0)
    freeHead->startingBlock=0;
    8000149c:	00052223          	sw	zero,4(a0)
    freeHead->sizeInBlocks = (end-start)/MEM_BLOCK_SIZE;
    800014a0:	40a58533          	sub	a0,a1,a0
    800014a4:	00655513          	srli	a0,a0,0x6
    800014a8:	0007b703          	ld	a4,0(a5)
    800014ac:	00a72023          	sw	a0,0(a4)
    ukupno_memorije=freeHead->sizeInBlocks;
    800014b0:	0007b783          	ld	a5,0(a5)
    800014b4:	0007a783          	lw	a5,0(a5)
    800014b8:	00004717          	auipc	a4,0x4
    800014bc:	18f73423          	sd	a5,392(a4) # 80005640 <ukupno_memorije>
}
    800014c0:	00813403          	ld	s0,8(sp)
    800014c4:	01010113          	addi	sp,sp,16
    800014c8:	00008067          	ret

00000000800014cc <kern_syscall>:
    int output_cursor;
} console_instance;


uint64 kern_syscall(enum SyscallNumber num, ...)
{
    800014cc:	fb010113          	addi	sp,sp,-80
    800014d0:	00813423          	sd	s0,8(sp)
    800014d4:	01010413          	addi	s0,sp,16
    800014d8:	00b43423          	sd	a1,8(s0)
    800014dc:	00c43823          	sd	a2,16(s0)
    800014e0:	00d43c23          	sd	a3,24(s0)
    800014e4:	02e43023          	sd	a4,32(s0)
    800014e8:	02f43423          	sd	a5,40(s0)
    800014ec:	03043823          	sd	a6,48(s0)
    800014f0:	03143c23          	sd	a7,56(s0)
    __asm__ volatile ("ecall");
    800014f4:	00000073          	ecall
    return  running->syscall_retval;
}
    800014f8:	00004797          	auipc	a5,0x4
    800014fc:	1687b783          	ld	a5,360(a5) # 80005660 <running>
    80001500:	0407b503          	ld	a0,64(a5)
    80001504:	00813403          	ld	s0,8(sp)
    80001508:	05010113          	addi	sp,sp,80
    8000150c:	00008067          	ret

0000000080001510 <kern_interrupt_init>:

void kern_interrupt_init()
{
    80001510:	ff010113          	addi	sp,sp,-16
    80001514:	00813423          	sd	s0,8(sp)
    80001518:	01010413          	addi	s0,sp,16
    SYSTEM_TIME=0;
    8000151c:	00004797          	auipc	a5,0x4
    80001520:	1207be23          	sd	zero,316(a5) # 80005658 <SYSTEM_TIME>
    console_instance.input_cursor=0;
    80001524:	00006797          	auipc	a5,0x6
    80001528:	16c78793          	addi	a5,a5,364 # 80007690 <threads+0x7f8>
    8000152c:	8007a023          	sw	zero,-2048(a5)
    console_instance.output_cursor=0;
    80001530:	8007a223          	sw	zero,-2044(a5)
    w_stvec((uint64) &supervisorTrap);
    80001534:	00000797          	auipc	a5,0x0
    80001538:	acc78793          	addi	a5,a5,-1332 # 80001000 <supervisorTrap>
    return stvec;
}

inline void w_stvec(uint64 stvec)
{
    __asm__ volatile ("csrw stvec, %[stvec]" : : [stvec] "r"(stvec));
    8000153c:	10579073          	csrw	stvec,a5
    __asm__ volatile ("csrw sip, %[sip]" : : [sip] "r"(sip));
}

inline void ms_sstatus(uint64 mask)
{
    __asm__ volatile ("csrs sstatus, %[mask]" : : [mask] "r"(mask));
    80001540:	00200793          	li	a5,2
    80001544:	1007a073          	csrs	sstatus,a5
    ms_sstatus(SSTATUS_SIE);
}
    80001548:	00813403          	ld	s0,8(sp)
    8000154c:	01010113          	addi	sp,sp,16
    80001550:	00008067          	ret

0000000080001554 <handleSupervisorTrap>:


int time=0;

void handleSupervisorTrap()
{
    80001554:	f3010113          	addi	sp,sp,-208
    80001558:	0c113423          	sd	ra,200(sp)
    8000155c:	0c813023          	sd	s0,192(sp)
    80001560:	0a913c23          	sd	s1,184(sp)
    80001564:	0b213823          	sd	s2,176(sp)
    80001568:	0d010413          	addi	s0,sp,208
    uint64  a0,a1,a2,a3,a4;
    __asm__ volatile ("mv %[a0], a0" : [a0] "=r"(a0));
    8000156c:	00050793          	mv	a5,a0
    __asm__ volatile ("mv %[a1], a1" : [a1] "=r"(a1));
    80001570:	00058493          	mv	s1,a1
    __asm__ volatile ("mv %[a2], a2" : [a2] "=r"(a2));
    80001574:	00060913          	mv	s2,a2
    __asm__ volatile ("mv %[a3], a3" : [a3] "=r"(a3));
    80001578:	00068613          	mv	a2,a3
    __asm__ volatile ("mv %[a4], a4" : [a4] "=r"(a4));
    8000157c:	00070693          	mv	a3,a4
    __asm__ volatile ("csrr %[scause], scause" : [scause] "=r"(scause));
    80001580:	14202773          	csrr	a4,scause
    80001584:	f8e43023          	sd	a4,-128(s0)
    return scause;
    80001588:	f8043703          	ld	a4,-128(s0)
    uint64  scause = r_scause();
    if (scause == INTR_USER_ECALL || scause == INTR_KERNEL_ECALL)
    8000158c:	ff870513          	addi	a0,a4,-8
    80001590:	00100593          	li	a1,1
    80001594:	02a5fe63          	bgeu	a1,a0,800015d0 <handleSupervisorTrap+0x7c>


        }

    }
    else if (scause == INTR_TIMER)
    80001598:	fff00793          	li	a5,-1
    8000159c:	03f79793          	slli	a5,a5,0x3f
    800015a0:	00178793          	addi	a5,a5,1
    800015a4:	2cf70c63          	beq	a4,a5,8000187c <handleSupervisorTrap+0x328>
            //__putc('0'+running->id);
            //__putc(')');
        }

    }
    else if (scause == INTR_CONSOLE)
    800015a8:	fff00793          	li	a5,-1
    800015ac:	03f79793          	slli	a5,a5,0x3f
    800015b0:	00978793          	addi	a5,a5,9
    800015b4:	34f70c63          	beq	a4,a5,8000190c <handleSupervisorTrap+0x3b8>

    }
    else if(scause==INTR_ILLEGAL_ADDR_WR){

    }
}
    800015b8:	0c813083          	ld	ra,200(sp)
    800015bc:	0c013403          	ld	s0,192(sp)
    800015c0:	0b813483          	ld	s1,184(sp)
    800015c4:	0b013903          	ld	s2,176(sp)
    800015c8:	0d010113          	addi	sp,sp,208
    800015cc:	00008067          	ret
    __asm__ volatile ("csrr %[sepc], sepc" : [sepc] "=r"(sepc));
    800015d0:	14102773          	csrr	a4,sepc
    800015d4:	f8e43423          	sd	a4,-120(s0)
    return sepc;
    800015d8:	f8843703          	ld	a4,-120(s0)
        uint64   sepc = r_sepc() + 4;
    800015dc:	00470713          	addi	a4,a4,4
    __asm__ volatile ("csrw sepc, %[sepc]" : : [sepc] "r"(sepc));
    800015e0:	14171073          	csrw	sepc,a4
        switch (syscall_num) {
    800015e4:	03100713          	li	a4,49
    800015e8:	fcf768e3          	bltu	a4,a5,800015b8 <handleSupervisorTrap+0x64>
    800015ec:	00279793          	slli	a5,a5,0x2
    800015f0:	00004717          	auipc	a4,0x4
    800015f4:	a3070713          	addi	a4,a4,-1488 # 80005020 <CONSOLE_STATUS+0x8>
    800015f8:	00e787b3          	add	a5,a5,a4
    800015fc:	0007a783          	lw	a5,0(a5)
    80001600:	00e787b3          	add	a5,a5,a4
    80001604:	00078067          	jr	a5
                running->syscall_retval=(uint64)kern_mem_alloc(size);
    80001608:	0004851b          	sext.w	a0,s1
    8000160c:	00000097          	auipc	ra,0x0
    80001610:	cdc080e7          	jalr	-804(ra) # 800012e8 <kern_mem_alloc>
    80001614:	00004797          	auipc	a5,0x4
    80001618:	04c7b783          	ld	a5,76(a5) # 80005660 <running>
    8000161c:	04a7b023          	sd	a0,64(a5)
                break;
    80001620:	f99ff06f          	j	800015b8 <handleSupervisorTrap+0x64>
                running->syscall_retval=(uint64) kern_mem_free((void*)addr);
    80001624:	00048513          	mv	a0,s1
    80001628:	00000097          	auipc	ra,0x0
    8000162c:	d84080e7          	jalr	-636(ra) # 800013ac <kern_mem_free>
    80001630:	00004797          	auipc	a5,0x4
    80001634:	0307b783          	ld	a5,48(a5) # 80005660 <running>
    80001638:	04a7b023          	sd	a0,64(a5)
                break;
    8000163c:	f7dff06f          	j	800015b8 <handleSupervisorTrap+0x64>
                running->syscall_retval=(uint64) kern_thread_create((thread_t*)handle,
    80001640:	00090593          	mv	a1,s2
    80001644:	00048513          	mv	a0,s1
    80001648:	00000097          	auipc	ra,0x0
    8000164c:	6dc080e7          	jalr	1756(ra) # 80001d24 <kern_thread_create>
    80001650:	00004797          	auipc	a5,0x4
    80001654:	0107b783          	ld	a5,16(a5) # 80005660 <running>
    80001658:	04a7b023          	sd	a0,64(a5)
                (*(thread_t*)handle)->endTime=SYSTEM_TIME+DEFAULT_TIME_SLICE;
    8000165c:	0004b703          	ld	a4,0(s1)
    80001660:	00004797          	auipc	a5,0x4
    80001664:	ff87b783          	ld	a5,-8(a5) # 80005658 <SYSTEM_TIME>
    80001668:	00278793          	addi	a5,a5,2
    8000166c:	02f73c23          	sd	a5,56(a4)
                break;
    80001670:	f49ff06f          	j	800015b8 <handleSupervisorTrap+0x64>
}

inline uint64 r_sstatus()
{
    uint64 volatile sstatus;
    __asm__ volatile ("csrr %[sstatus], sstatus" : [sstatus] "=r"(sstatus));
    80001674:	100027f3          	csrr	a5,sstatus
    80001678:	f8f43c23          	sd	a5,-104(s0)
    return sstatus;
    8000167c:	f9843783          	ld	a5,-104(s0)
                uint64 volatile sstatus = r_sstatus();
    80001680:	f2f43823          	sd	a5,-208(s0)
    __asm__ volatile ("csrr %[sepc], sepc" : [sepc] "=r"(sepc));
    80001684:	141027f3          	csrr	a5,sepc
    80001688:	f8f43823          	sd	a5,-112(s0)
    return sepc;
    8000168c:	f9043783          	ld	a5,-112(s0)
                uint64 volatile v_sepc = r_sepc();
    80001690:	f2f43c23          	sd	a5,-200(s0)
                kern_thread_dispatch();
    80001694:	00000097          	auipc	ra,0x0
    80001698:	440080e7          	jalr	1088(ra) # 80001ad4 <kern_thread_dispatch>
                w_sstatus(sstatus);
    8000169c:	f3043783          	ld	a5,-208(s0)
}

inline void w_sstatus(uint64 sstatus)
{
    __asm__ volatile ("csrw sstatus, %[sstatus]" : : [sstatus] "r"(sstatus));
    800016a0:	10079073          	csrw	sstatus,a5
                w_sepc(v_sepc);
    800016a4:	f3843783          	ld	a5,-200(s0)
    __asm__ volatile ("csrw sepc, %[sepc]" : : [sepc] "r"(sepc));
    800016a8:	14179073          	csrw	sepc,a5
                running->endTime=time+running->timeslice;
    800016ac:	00004717          	auipc	a4,0x4
    800016b0:	fb473703          	ld	a4,-76(a4) # 80005660 <running>
    800016b4:	03073683          	ld	a3,48(a4)
    800016b8:	00004797          	auipc	a5,0x4
    800016bc:	f987a783          	lw	a5,-104(a5) # 80005650 <time>
    800016c0:	00d787b3          	add	a5,a5,a3
    800016c4:	02f73c23          	sd	a5,56(a4)
                break;
    800016c8:	ef1ff06f          	j	800015b8 <handleSupervisorTrap+0x64>
    __asm__ volatile ("csrr %[sstatus], sstatus" : [sstatus] "=r"(sstatus));
    800016cc:	100027f3          	csrr	a5,sstatus
    800016d0:	faf43423          	sd	a5,-88(s0)
    return sstatus;
    800016d4:	fa843783          	ld	a5,-88(s0)
                uint64 volatile sstatus = r_sstatus();
    800016d8:	f4f43023          	sd	a5,-192(s0)
    __asm__ volatile ("csrr %[sepc], sepc" : [sepc] "=r"(sepc));
    800016dc:	141027f3          	csrr	a5,sepc
    800016e0:	faf43023          	sd	a5,-96(s0)
    return sepc;
    800016e4:	fa043783          	ld	a5,-96(s0)
                uint64 volatile v_sepc = r_sepc();
    800016e8:	f4f43423          	sd	a5,-184(s0)
                kern_thread_join(handle);
    800016ec:	00048513          	mv	a0,s1
    800016f0:	00000097          	auipc	ra,0x0
    800016f4:	714080e7          	jalr	1812(ra) # 80001e04 <kern_thread_join>
                w_sstatus(sstatus);
    800016f8:	f4043783          	ld	a5,-192(s0)
    __asm__ volatile ("csrw sstatus, %[sstatus]" : : [sstatus] "r"(sstatus));
    800016fc:	10079073          	csrw	sstatus,a5
                w_sepc(v_sepc);
    80001700:	f4843783          	ld	a5,-184(s0)
    __asm__ volatile ("csrw sepc, %[sepc]" : : [sepc] "r"(sepc));
    80001704:	14179073          	csrw	sepc,a5
                running->endTime=time+running->timeslice;
    80001708:	00004717          	auipc	a4,0x4
    8000170c:	f5873703          	ld	a4,-168(a4) # 80005660 <running>
    80001710:	03073683          	ld	a3,48(a4)
    80001714:	00004797          	auipc	a5,0x4
    80001718:	f3c7a783          	lw	a5,-196(a5) # 80005650 <time>
    8000171c:	00d787b3          	add	a5,a5,a3
    80001720:	02f73c23          	sd	a5,56(a4)
                break;
    80001724:	e95ff06f          	j	800015b8 <handleSupervisorTrap+0x64>
                kern_thread_end_running();
    80001728:	00000097          	auipc	ra,0x0
    8000172c:	428080e7          	jalr	1064(ra) # 80001b50 <kern_thread_end_running>
                running->syscall_retval = kern_sem_open(handle,init);
    80001730:	0009059b          	sext.w	a1,s2
    80001734:	00048513          	mv	a0,s1
    80001738:	00000097          	auipc	ra,0x0
    8000173c:	a38080e7          	jalr	-1480(ra) # 80001170 <kern_sem_open>
    80001740:	00004797          	auipc	a5,0x4
    80001744:	f207b783          	ld	a5,-224(a5) # 80005660 <running>
    80001748:	04a7b023          	sd	a0,64(a5)
                break;
    8000174c:	e6dff06f          	j	800015b8 <handleSupervisorTrap+0x64>
                running->syscall_retval = kern_sem_close(handle);
    80001750:	00048513          	mv	a0,s1
    80001754:	00000097          	auipc	ra,0x0
    80001758:	a8c080e7          	jalr	-1396(ra) # 800011e0 <kern_sem_close>
    8000175c:	00004797          	auipc	a5,0x4
    80001760:	f047b783          	ld	a5,-252(a5) # 80005660 <running>
    80001764:	04a7b023          	sd	a0,64(a5)
                break;
    80001768:	e51ff06f          	j	800015b8 <handleSupervisorTrap+0x64>
                kern_sem_signal(handle);
    8000176c:	00048513          	mv	a0,s1
    80001770:	00000097          	auipc	ra,0x0
    80001774:	ac4080e7          	jalr	-1340(ra) # 80001234 <kern_sem_signal>
                running->syscall_retval=0;
    80001778:	00004797          	auipc	a5,0x4
    8000177c:	ee87b783          	ld	a5,-280(a5) # 80005660 <running>
    80001780:	0407b023          	sd	zero,64(a5)
                break;
    80001784:	e35ff06f          	j	800015b8 <handleSupervisorTrap+0x64>
                int res = kern_sem_wait(handle);
    80001788:	00048513          	mv	a0,s1
    8000178c:	00000097          	auipc	ra,0x0
    80001790:	af0080e7          	jalr	-1296(ra) # 8000127c <kern_sem_wait>
                if(res==1) running->syscall_retval=0;
    80001794:	00100793          	li	a5,1
    80001798:	00f51a63          	bne	a0,a5,800017ac <handleSupervisorTrap+0x258>
    8000179c:	00004797          	auipc	a5,0x4
    800017a0:	ec47b783          	ld	a5,-316(a5) # 80005660 <running>
    800017a4:	0407b023          	sd	zero,64(a5)
    800017a8:	e11ff06f          	j	800015b8 <handleSupervisorTrap+0x64>
    __asm__ volatile ("csrr %[sstatus], sstatus" : [sstatus] "=r"(sstatus));
    800017ac:	100027f3          	csrr	a5,sstatus
    800017b0:	faf43c23          	sd	a5,-72(s0)
    return sstatus;
    800017b4:	fb843783          	ld	a5,-72(s0)
                    uint64 volatile sstatus = r_sstatus();
    800017b8:	f4f43823          	sd	a5,-176(s0)
    __asm__ volatile ("csrr %[sepc], sepc" : [sepc] "=r"(sepc));
    800017bc:	141027f3          	csrr	a5,sepc
    800017c0:	faf43823          	sd	a5,-80(s0)
    return sepc;
    800017c4:	fb043783          	ld	a5,-80(s0)
                    uint64 volatile v_sepc = r_sepc();
    800017c8:	f4f43c23          	sd	a5,-168(s0)
                    kern_thread_dispatch();
    800017cc:	00000097          	auipc	ra,0x0
    800017d0:	308080e7          	jalr	776(ra) # 80001ad4 <kern_thread_dispatch>
                    w_sstatus(sstatus);
    800017d4:	f5043783          	ld	a5,-176(s0)
    __asm__ volatile ("csrw sstatus, %[sstatus]" : : [sstatus] "r"(sstatus));
    800017d8:	10079073          	csrw	sstatus,a5
                    w_sepc(v_sepc);
    800017dc:	f5843783          	ld	a5,-168(s0)
    __asm__ volatile ("csrw sepc, %[sepc]" : : [sepc] "r"(sepc));
    800017e0:	14179073          	csrw	sepc,a5
                    running->endTime=time+running->timeslice;
    800017e4:	00004717          	auipc	a4,0x4
    800017e8:	e7c73703          	ld	a4,-388(a4) # 80005660 <running>
    800017ec:	03073683          	ld	a3,48(a4)
    800017f0:	00004797          	auipc	a5,0x4
    800017f4:	e607a783          	lw	a5,-416(a5) # 80005650 <time>
    800017f8:	00d787b3          	add	a5,a5,a3
    800017fc:	02f73c23          	sd	a5,56(a4)
    80001800:	db9ff06f          	j	800015b8 <handleSupervisorTrap+0x64>
                running->status=SLEEPING;
    80001804:	00004917          	auipc	s2,0x4
    80001808:	e5c90913          	addi	s2,s2,-420 # 80005660 <running>
    8000180c:	00093783          	ld	a5,0(s2)
    80001810:	00500713          	li	a4,5
    80001814:	04e7a823          	sw	a4,80(a5)
                running->endTime=SYSTEM_TIME+period;
    80001818:	00004717          	auipc	a4,0x4
    8000181c:	e4073703          	ld	a4,-448(a4) # 80005658 <SYSTEM_TIME>
    80001820:	00e484b3          	add	s1,s1,a4
    80001824:	0297bc23          	sd	s1,56(a5)
    __asm__ volatile ("csrr %[sstatus], sstatus" : [sstatus] "=r"(sstatus));
    80001828:	100027f3          	csrr	a5,sstatus
    8000182c:	fcf43423          	sd	a5,-56(s0)
    return sstatus;
    80001830:	fc843783          	ld	a5,-56(s0)
                uint64 volatile sstatus = r_sstatus();
    80001834:	f6f43023          	sd	a5,-160(s0)
    __asm__ volatile ("csrr %[sepc], sepc" : [sepc] "=r"(sepc));
    80001838:	141027f3          	csrr	a5,sepc
    8000183c:	fcf43023          	sd	a5,-64(s0)
    return sepc;
    80001840:	fc043783          	ld	a5,-64(s0)
                uint64 volatile v_sepc = r_sepc();
    80001844:	f6f43423          	sd	a5,-152(s0)
                kern_thread_dispatch();
    80001848:	00000097          	auipc	ra,0x0
    8000184c:	28c080e7          	jalr	652(ra) # 80001ad4 <kern_thread_dispatch>
                w_sstatus(sstatus);
    80001850:	f6043783          	ld	a5,-160(s0)
    __asm__ volatile ("csrw sstatus, %[sstatus]" : : [sstatus] "r"(sstatus));
    80001854:	10079073          	csrw	sstatus,a5
                w_sepc(v_sepc);
    80001858:	f6843783          	ld	a5,-152(s0)
    __asm__ volatile ("csrw sepc, %[sepc]" : : [sepc] "r"(sepc));
    8000185c:	14179073          	csrw	sepc,a5
                running->endTime=time+running->timeslice;
    80001860:	00093703          	ld	a4,0(s2)
    80001864:	03073683          	ld	a3,48(a4)
    80001868:	00004797          	auipc	a5,0x4
    8000186c:	de87a783          	lw	a5,-536(a5) # 80005650 <time>
    80001870:	00d787b3          	add	a5,a5,a3
    80001874:	02f73c23          	sd	a5,56(a4)
    80001878:	d41ff06f          	j	800015b8 <handleSupervisorTrap+0x64>
        SYSTEM_TIME++;
    8000187c:	00004497          	auipc	s1,0x4
    80001880:	ddc48493          	addi	s1,s1,-548 # 80005658 <SYSTEM_TIME>
    80001884:	0004b503          	ld	a0,0(s1)
    80001888:	00150513          	addi	a0,a0,1
    8000188c:	00a4b023          	sd	a0,0(s1)
    __asm__ volatile ("csrc sip, %[mask]" : : [mask] "r"(mask));
    80001890:	00200793          	li	a5,2
    80001894:	1447b073          	csrc	sip,a5
        kern_thread_wakeup(SYSTEM_TIME);
    80001898:	00000097          	auipc	ra,0x0
    8000189c:	5b8080e7          	jalr	1464(ra) # 80001e50 <kern_thread_wakeup>
        if(SYSTEM_TIME>=running->endTime){
    800018a0:	00004797          	auipc	a5,0x4
    800018a4:	dc07b783          	ld	a5,-576(a5) # 80005660 <running>
    800018a8:	0387b703          	ld	a4,56(a5)
    800018ac:	0004b783          	ld	a5,0(s1)
    800018b0:	d0e7e4e3          	bltu	a5,a4,800015b8 <handleSupervisorTrap+0x64>
    __asm__ volatile ("csrr %[sstatus], sstatus" : [sstatus] "=r"(sstatus));
    800018b4:	100027f3          	csrr	a5,sstatus
    800018b8:	fcf43c23          	sd	a5,-40(s0)
    return sstatus;
    800018bc:	fd843783          	ld	a5,-40(s0)
            uint64 volatile sstatus = r_sstatus();
    800018c0:	f6f43823          	sd	a5,-144(s0)
    __asm__ volatile ("csrr %[sepc], sepc" : [sepc] "=r"(sepc));
    800018c4:	141027f3          	csrr	a5,sepc
    800018c8:	fcf43823          	sd	a5,-48(s0)
    return sepc;
    800018cc:	fd043783          	ld	a5,-48(s0)
            uint64 volatile v_sepc = r_sepc();
    800018d0:	f6f43c23          	sd	a5,-136(s0)
            kern_thread_dispatch();
    800018d4:	00000097          	auipc	ra,0x0
    800018d8:	200080e7          	jalr	512(ra) # 80001ad4 <kern_thread_dispatch>
            w_sstatus(sstatus);
    800018dc:	f7043783          	ld	a5,-144(s0)
    __asm__ volatile ("csrw sstatus, %[sstatus]" : : [sstatus] "r"(sstatus));
    800018e0:	10079073          	csrw	sstatus,a5
            w_sepc(v_sepc);
    800018e4:	f7843783          	ld	a5,-136(s0)
    __asm__ volatile ("csrw sepc, %[sepc]" : : [sepc] "r"(sepc));
    800018e8:	14179073          	csrw	sepc,a5
            running->endTime=SYSTEM_TIME+running->timeslice;
    800018ec:	00004717          	auipc	a4,0x4
    800018f0:	d7473703          	ld	a4,-652(a4) # 80005660 <running>
    800018f4:	03073783          	ld	a5,48(a4)
    800018f8:	00004697          	auipc	a3,0x4
    800018fc:	d606b683          	ld	a3,-672(a3) # 80005658 <SYSTEM_TIME>
    80001900:	00d787b3          	add	a5,a5,a3
    80001904:	02f73c23          	sd	a5,56(a4)
    80001908:	cb1ff06f          	j	800015b8 <handleSupervisorTrap+0x64>
        int i = plic_claim();
    8000190c:	00001097          	auipc	ra,0x1
    80001910:	668080e7          	jalr	1640(ra) # 80002f74 <plic_claim>
        if(i==10){
    80001914:	00a00793          	li	a5,10
    80001918:	00f50863          	beq	a0,a5,80001928 <handleSupervisorTrap+0x3d4>
        console_handler();
    8000191c:	00003097          	auipc	ra,0x3
    80001920:	f34080e7          	jalr	-204(ra) # 80004850 <console_handler>
}
    80001924:	c95ff06f          	j	800015b8 <handleSupervisorTrap+0x64>
            plic_complete(i);
    80001928:	00001097          	auipc	ra,0x1
    8000192c:	684080e7          	jalr	1668(ra) # 80002fac <plic_complete>
            i--;
    80001930:	fedff06f          	j	8000191c <handleSupervisorTrap+0x3c8>

0000000080001934 <kern_thread_init>:
struct thread_s threads[MAX_THREADS];
static int id;
struct thread_s* running;

void kern_thread_init()
{
    80001934:	ff010113          	addi	sp,sp,-16
    80001938:	00813423          	sd	s0,8(sp)
    8000193c:	01010413          	addi	s0,sp,16
    id=0;
    80001940:	00004797          	auipc	a5,0x4
    80001944:	d207a423          	sw	zero,-728(a5) # 80005668 <id>
    for (int i=0;i<MAX_THREADS;i++){
    80001948:	00000793          	li	a5,0
    8000194c:	0240006f          	j	80001970 <kern_thread_init+0x3c>
        threads[i].status=UNUSED;
    80001950:	00179713          	slli	a4,a5,0x1
    80001954:	00f70733          	add	a4,a4,a5
    80001958:	00571693          	slli	a3,a4,0x5
    8000195c:	00005717          	auipc	a4,0x5
    80001960:	53c70713          	addi	a4,a4,1340 # 80006e98 <threads>
    80001964:	00d70733          	add	a4,a4,a3
    80001968:	04072823          	sw	zero,80(a4)
    for (int i=0;i<MAX_THREADS;i++){
    8000196c:	0017879b          	addiw	a5,a5,1
    80001970:	03f00713          	li	a4,63
    80001974:	fcf75ee3          	bge	a4,a5,80001950 <kern_thread_init+0x1c>
    }

    //set threads[0] as main thread
    threads[0].status=RUNNING;
    80001978:	00005797          	auipc	a5,0x5
    8000197c:	52078793          	addi	a5,a5,1312 # 80006e98 <threads>
    80001980:	00100713          	li	a4,1
    80001984:	04e7a823          	sw	a4,80(a5)
    threads[0].id=0;
    80001988:	0007b823          	sd	zero,16(a5)
    threads[0].timeslice=DEFAULT_TIME_SLICE+2;
    8000198c:	00400713          	li	a4,4
    80001990:	02e7b823          	sd	a4,48(a5)
    threads[0].endTime=0;
    80001994:	0207bc23          	sd	zero,56(a5)
    running=&threads[0];
    80001998:	00004717          	auipc	a4,0x4
    8000199c:	ccf73423          	sd	a5,-824(a4) # 80005660 <running>
}
    800019a0:	00813403          	ld	s0,8(sp)
    800019a4:	01010113          	addi	sp,sp,16
    800019a8:	00008067          	ret

00000000800019ac <kern_scheduler_get>:

thread_t kern_scheduler_get()
{
    800019ac:	ff010113          	addi	sp,sp,-16
    800019b0:	00813423          	sd	s0,8(sp)
    800019b4:	01010413          	addi	s0,sp,16
    int num = running-threads;
    800019b8:	00004517          	auipc	a0,0x4
    800019bc:	ca853503          	ld	a0,-856(a0) # 80005660 <running>
    800019c0:	00005797          	auipc	a5,0x5
    800019c4:	4d878793          	addi	a5,a5,1240 # 80006e98 <threads>
    800019c8:	40f507b3          	sub	a5,a0,a5
    800019cc:	4057d793          	srai	a5,a5,0x5
    800019d0:	00003717          	auipc	a4,0x3
    800019d4:	63073703          	ld	a4,1584(a4) # 80005000 <console_handler+0x7b0>
    800019d8:	02e787bb          	mulw	a5,a5,a4
    for(int i=1;i<=MAX_THREADS;i++){
    800019dc:	00100693          	li	a3,1
    800019e0:	04000713          	li	a4,64
    800019e4:	06d74c63          	blt	a4,a3,80001a5c <kern_scheduler_get+0xb0>
        num = (num+i)%MAX_THREADS;
    800019e8:	00d787bb          	addw	a5,a5,a3
    800019ec:	41f7d71b          	sraiw	a4,a5,0x1f
    800019f0:	01a7571b          	srliw	a4,a4,0x1a
    800019f4:	00e787bb          	addw	a5,a5,a4
    800019f8:	03f7f793          	andi	a5,a5,63
    800019fc:	40e787bb          	subw	a5,a5,a4
        if(threads[num].status==READY){
    80001a00:	00179713          	slli	a4,a5,0x1
    80001a04:	00f70733          	add	a4,a4,a5
    80001a08:	00571613          	slli	a2,a4,0x5
    80001a0c:	00005717          	auipc	a4,0x5
    80001a10:	48c70713          	addi	a4,a4,1164 # 80006e98 <threads>
    80001a14:	00c70733          	add	a4,a4,a2
    80001a18:	05072603          	lw	a2,80(a4)
    80001a1c:	00200713          	li	a4,2
    80001a20:	00e60663          	beq	a2,a4,80001a2c <kern_scheduler_get+0x80>
    for(int i=1;i<=MAX_THREADS;i++){
    80001a24:	0016869b          	addiw	a3,a3,1
    80001a28:	fb9ff06f          	j	800019e0 <kern_scheduler_get+0x34>
            threads[num].status=RUNNING;
    80001a2c:	00005617          	auipc	a2,0x5
    80001a30:	46c60613          	addi	a2,a2,1132 # 80006e98 <threads>
    80001a34:	00179713          	slli	a4,a5,0x1
    80001a38:	00f705b3          	add	a1,a4,a5
    80001a3c:	00559693          	slli	a3,a1,0x5
    80001a40:	00d606b3          	add	a3,a2,a3
    80001a44:	00100593          	li	a1,1
    80001a48:	04b6a823          	sw	a1,80(a3)
            return &threads[num];
    80001a4c:	00068513          	mv	a0,a3
    if(running->status==READY || running->status==RUNNING) {
        running->status=RUNNING;
        return running;
    }
    return 0;
}
    80001a50:	00813403          	ld	s0,8(sp)
    80001a54:	01010113          	addi	sp,sp,16
    80001a58:	00008067          	ret
    if(running->status==READY || running->status==RUNNING) {
    80001a5c:	05052783          	lw	a5,80(a0)
    80001a60:	fff7879b          	addiw	a5,a5,-1
    80001a64:	00100713          	li	a4,1
    80001a68:	00f77663          	bgeu	a4,a5,80001a74 <kern_scheduler_get+0xc8>
    return 0;
    80001a6c:	00000513          	li	a0,0
    80001a70:	fe1ff06f          	j	80001a50 <kern_scheduler_get+0xa4>
        running->status=RUNNING;
    80001a74:	00100793          	li	a5,1
    80001a78:	04f52823          	sw	a5,80(a0)
        return running;
    80001a7c:	fd5ff06f          	j	80001a50 <kern_scheduler_get+0xa4>

0000000080001a80 <kern_thread_yield>:

void kern_thread_yield()
{
    80001a80:	ff010113          	addi	sp,sp,-16
    80001a84:	00113423          	sd	ra,8(sp)
    80001a88:	00813023          	sd	s0,0(sp)
    80001a8c:	01010413          	addi	s0,sp,16
    kern_syscall(THREAD_DISPATCH);
    80001a90:	01300513          	li	a0,19
    80001a94:	00000097          	auipc	ra,0x0
    80001a98:	a38080e7          	jalr	-1480(ra) # 800014cc <kern_syscall>
}
    80001a9c:	00813083          	ld	ra,8(sp)
    80001aa0:	00013403          	ld	s0,0(sp)
    80001aa4:	01010113          	addi	sp,sp,16
    80001aa8:	00008067          	ret

0000000080001aac <popSppSpie>:

//samo izlazi iz kernela i vraca se odakle je pozvana
void popSppSpie()
{
    80001aac:	ff010113          	addi	sp,sp,-16
    80001ab0:	00813423          	sd	s0,8(sp)
    80001ab4:	01010413          	addi	s0,sp,16
    __asm__ volatile("csrw sepc, ra"); //ovde dodaj izlazak iz privilegovanog moda
    80001ab8:	14109073          	csrw	sepc,ra
    __asm__ volatile("csrc sstatus, %[mask]" : : [mask] "r"(1 << 8));
    80001abc:	10000793          	li	a5,256
    80001ac0:	1007b073          	csrc	sstatus,a5
    __asm__ volatile("sret");
    80001ac4:	10200073          	sret
}
    80001ac8:	00813403          	ld	s0,8(sp)
    80001acc:	01010113          	addi	sp,sp,16
    80001ad0:	00008067          	ret

0000000080001ad4 <kern_thread_dispatch>:

extern void contextSwitch(thread_t old, thread_t new);

void kern_thread_dispatch()
{
    80001ad4:	fe010113          	addi	sp,sp,-32
    80001ad8:	00113c23          	sd	ra,24(sp)
    80001adc:	00813823          	sd	s0,16(sp)
    80001ae0:	00913423          	sd	s1,8(sp)
    80001ae4:	01213023          	sd	s2,0(sp)
    80001ae8:	02010413          	addi	s0,sp,32
    thread_t old = running;
    80001aec:	00004917          	auipc	s2,0x4
    80001af0:	b7490913          	addi	s2,s2,-1164 # 80005660 <running>
    80001af4:	00093483          	ld	s1,0(s2)
    running=kern_scheduler_get();
    80001af8:	00000097          	auipc	ra,0x0
    80001afc:	eb4080e7          	jalr	-332(ra) # 800019ac <kern_scheduler_get>
    80001b00:	00a93023          	sd	a0,0(s2)
    if(old!=running){
    80001b04:	02950463          	beq	a0,s1,80001b2c <kern_thread_dispatch+0x58>
    80001b08:	00050593          	mv	a1,a0
        running->status=RUNNING;
    80001b0c:	00100793          	li	a5,1
    80001b10:	04f52823          	sw	a5,80(a0)
        if(old->status==RUNNING) old->status=READY;
    80001b14:	0504a703          	lw	a4,80(s1)
    80001b18:	00100793          	li	a5,1
    80001b1c:	02f70463          	beq	a4,a5,80001b44 <kern_thread_dispatch+0x70>
        contextSwitch(old,running);
    80001b20:	00048513          	mv	a0,s1
    80001b24:	fffff097          	auipc	ra,0xfffff
    80001b28:	5ec080e7          	jalr	1516(ra) # 80001110 <contextSwitch>
    }
}
    80001b2c:	01813083          	ld	ra,24(sp)
    80001b30:	01013403          	ld	s0,16(sp)
    80001b34:	00813483          	ld	s1,8(sp)
    80001b38:	00013903          	ld	s2,0(sp)
    80001b3c:	02010113          	addi	sp,sp,32
    80001b40:	00008067          	ret
        if(old->status==RUNNING) old->status=READY;
    80001b44:	00200793          	li	a5,2
    80001b48:	04f4a823          	sw	a5,80(s1)
    80001b4c:	fd5ff06f          	j	80001b20 <kern_thread_dispatch+0x4c>

0000000080001b50 <kern_thread_end_running>:

void kern_thread_end_running()
{
    80001b50:	fe010113          	addi	sp,sp,-32
    80001b54:	00113c23          	sd	ra,24(sp)
    80001b58:	00813823          	sd	s0,16(sp)
    80001b5c:	00913423          	sd	s1,8(sp)
    80001b60:	02010413          	addi	s0,sp,32
    thread_t old = running;
    80001b64:	00004497          	auipc	s1,0x4
    80001b68:	afc4b483          	ld	s1,-1284(s1) # 80005660 <running>
    old->status=UNUSED;
    80001b6c:	0404a823          	sw	zero,80(s1)
    for(int i=0;i<MAX_THREADS;i++){
    80001b70:	00000713          	li	a4,0
    80001b74:	0080006f          	j	80001b7c <kern_thread_end_running+0x2c>
    80001b78:	0017071b          	addiw	a4,a4,1
    80001b7c:	03f00793          	li	a5,63
    80001b80:	06e7c863          	blt	a5,a4,80001bf0 <kern_thread_end_running+0xa0>
        if(threads[i].status==JOINED && threads[i].joined_tid==old->id) threads[i].status=READY;
    80001b84:	00171793          	slli	a5,a4,0x1
    80001b88:	00e787b3          	add	a5,a5,a4
    80001b8c:	00579793          	slli	a5,a5,0x5
    80001b90:	00005697          	auipc	a3,0x5
    80001b94:	30868693          	addi	a3,a3,776 # 80006e98 <threads>
    80001b98:	00f687b3          	add	a5,a3,a5
    80001b9c:	0507a683          	lw	a3,80(a5)
    80001ba0:	00400793          	li	a5,4
    80001ba4:	fcf69ae3          	bne	a3,a5,80001b78 <kern_thread_end_running+0x28>
    80001ba8:	00171793          	slli	a5,a4,0x1
    80001bac:	00e787b3          	add	a5,a5,a4
    80001bb0:	00579793          	slli	a5,a5,0x5
    80001bb4:	00005697          	auipc	a3,0x5
    80001bb8:	2e468693          	addi	a3,a3,740 # 80006e98 <threads>
    80001bbc:	00f687b3          	add	a5,a3,a5
    80001bc0:	0287b683          	ld	a3,40(a5)
    80001bc4:	0104b783          	ld	a5,16(s1)
    80001bc8:	faf698e3          	bne	a3,a5,80001b78 <kern_thread_end_running+0x28>
    80001bcc:	00171793          	slli	a5,a4,0x1
    80001bd0:	00e787b3          	add	a5,a5,a4
    80001bd4:	00579793          	slli	a5,a5,0x5
    80001bd8:	00005697          	auipc	a3,0x5
    80001bdc:	2c068693          	addi	a3,a3,704 # 80006e98 <threads>
    80001be0:	00f687b3          	add	a5,a3,a5
    80001be4:	00200693          	li	a3,2
    80001be8:	04d7a823          	sw	a3,80(a5)
    80001bec:	f8dff06f          	j	80001b78 <kern_thread_end_running+0x28>
    }
    running=kern_scheduler_get();
    80001bf0:	00000097          	auipc	ra,0x0
    80001bf4:	dbc080e7          	jalr	-580(ra) # 800019ac <kern_scheduler_get>
    80001bf8:	00004797          	auipc	a5,0x4
    80001bfc:	a6a7b423          	sd	a0,-1432(a5) # 80005660 <running>
    if(old->stack_space!=0) kern_mem_free((void*)old->stack_space);
    80001c00:	0484b503          	ld	a0,72(s1)
    80001c04:	02051863          	bnez	a0,80001c34 <kern_thread_end_running+0xe4>
    if(old!=running){
    80001c08:	00004597          	auipc	a1,0x4
    80001c0c:	a585b583          	ld	a1,-1448(a1) # 80005660 <running>
    80001c10:	00958863          	beq	a1,s1,80001c20 <kern_thread_end_running+0xd0>
        contextSwitch(old,running);
    80001c14:	00048513          	mv	a0,s1
    80001c18:	fffff097          	auipc	ra,0xfffff
    80001c1c:	4f8080e7          	jalr	1272(ra) # 80001110 <contextSwitch>
    }
}
    80001c20:	01813083          	ld	ra,24(sp)
    80001c24:	01013403          	ld	s0,16(sp)
    80001c28:	00813483          	ld	s1,8(sp)
    80001c2c:	02010113          	addi	sp,sp,32
    80001c30:	00008067          	ret
    if(old->stack_space!=0) kern_mem_free((void*)old->stack_space);
    80001c34:	fffff097          	auipc	ra,0xfffff
    80001c38:	778080e7          	jalr	1912(ra) # 800013ac <kern_mem_free>
    80001c3c:	fcdff06f          	j	80001c08 <kern_thread_end_running+0xb8>

0000000080001c40 <kern_thread_wrapper>:

void kern_thread_wrapper()
{
    80001c40:	fe010113          	addi	sp,sp,-32
    80001c44:	00113c23          	sd	ra,24(sp)
    80001c48:	00813823          	sd	s0,16(sp)
    80001c4c:	00913423          	sd	s1,8(sp)
    80001c50:	02010413          	addi	s0,sp,32
    popSppSpie();
    80001c54:	00000097          	auipc	ra,0x0
    80001c58:	e58080e7          	jalr	-424(ra) # 80001aac <popSppSpie>
    running->body(running->arg);
    80001c5c:	00004497          	auipc	s1,0x4
    80001c60:	a0448493          	addi	s1,s1,-1532 # 80005660 <running>
    80001c64:	0004b783          	ld	a5,0(s1)
    80001c68:	0187b703          	ld	a4,24(a5)
    80001c6c:	0207b503          	ld	a0,32(a5)
    80001c70:	000700e7          	jalr	a4
    running->status=UNUSED;
    80001c74:	0004b603          	ld	a2,0(s1)
    80001c78:	04062823          	sw	zero,80(a2)
    running->sem_next=0;
    80001c7c:	04063c23          	sd	zero,88(a2)
    running->joined_tid=-1;
    80001c80:	fff00793          	li	a5,-1
    80001c84:	02f63423          	sd	a5,40(a2)
    for(int i=0;i<MAX_THREADS;i++){
    80001c88:	00000793          	li	a5,0
    80001c8c:	0080006f          	j	80001c94 <kern_thread_wrapper+0x54>
    80001c90:	0017879b          	addiw	a5,a5,1
    80001c94:	03f00713          	li	a4,63
    80001c98:	06f74863          	blt	a4,a5,80001d08 <kern_thread_wrapper+0xc8>
        if(threads[i].status==JOINED && threads[i].joined_tid==running->id) threads[i].status=READY;
    80001c9c:	00179713          	slli	a4,a5,0x1
    80001ca0:	00f70733          	add	a4,a4,a5
    80001ca4:	00571693          	slli	a3,a4,0x5
    80001ca8:	00005717          	auipc	a4,0x5
    80001cac:	1f070713          	addi	a4,a4,496 # 80006e98 <threads>
    80001cb0:	00d70733          	add	a4,a4,a3
    80001cb4:	05072683          	lw	a3,80(a4)
    80001cb8:	00400713          	li	a4,4
    80001cbc:	fce69ae3          	bne	a3,a4,80001c90 <kern_thread_wrapper+0x50>
    80001cc0:	00179713          	slli	a4,a5,0x1
    80001cc4:	00f70733          	add	a4,a4,a5
    80001cc8:	00571693          	slli	a3,a4,0x5
    80001ccc:	00005717          	auipc	a4,0x5
    80001cd0:	1cc70713          	addi	a4,a4,460 # 80006e98 <threads>
    80001cd4:	00d70733          	add	a4,a4,a3
    80001cd8:	02873683          	ld	a3,40(a4)
    80001cdc:	01063703          	ld	a4,16(a2)
    80001ce0:	fae698e3          	bne	a3,a4,80001c90 <kern_thread_wrapper+0x50>
    80001ce4:	00179713          	slli	a4,a5,0x1
    80001ce8:	00f70733          	add	a4,a4,a5
    80001cec:	00571693          	slli	a3,a4,0x5
    80001cf0:	00005717          	auipc	a4,0x5
    80001cf4:	1a870713          	addi	a4,a4,424 # 80006e98 <threads>
    80001cf8:	00d70733          	add	a4,a4,a3
    80001cfc:	00200693          	li	a3,2
    80001d00:	04d72823          	sw	a3,80(a4)
    80001d04:	f8dff06f          	j	80001c90 <kern_thread_wrapper+0x50>
    }

    kern_thread_end_running();
    80001d08:	00000097          	auipc	ra,0x0
    80001d0c:	e48080e7          	jalr	-440(ra) # 80001b50 <kern_thread_end_running>
}
    80001d10:	01813083          	ld	ra,24(sp)
    80001d14:	01013403          	ld	s0,16(sp)
    80001d18:	00813483          	ld	s1,8(sp)
    80001d1c:	02010113          	addi	sp,sp,32
    80001d20:	00008067          	ret

0000000080001d24 <kern_thread_create>:

int kern_thread_create(thread_t* handle, void(*start_routine)(void*), void* arg, void* stack_space)
{
    80001d24:	ff010113          	addi	sp,sp,-16
    80001d28:	00813423          	sd	s0,8(sp)
    80001d2c:	01010413          	addi	s0,sp,16
    *handle=0;
    80001d30:	00053023          	sd	zero,0(a0)
    thread_t t=&threads[0]; //dodela da bismo sklonili upozorenje
    for(int i=0;i<MAX_THREADS;i++){
    80001d34:	00000713          	li	a4,0
    80001d38:	03f00793          	li	a5,63
    80001d3c:	0ae7ca63          	blt	a5,a4,80001df0 <kern_thread_create+0xcc>
        if(threads[i].status==UNUSED){
    80001d40:	00171793          	slli	a5,a4,0x1
    80001d44:	00e787b3          	add	a5,a5,a4
    80001d48:	00579793          	slli	a5,a5,0x5
    80001d4c:	00005817          	auipc	a6,0x5
    80001d50:	14c80813          	addi	a6,a6,332 # 80006e98 <threads>
    80001d54:	00f807b3          	add	a5,a6,a5
    80001d58:	0507a783          	lw	a5,80(a5)
    80001d5c:	00078663          	beqz	a5,80001d68 <kern_thread_create+0x44>
    for(int i=0;i<MAX_THREADS;i++){
    80001d60:	0017071b          	addiw	a4,a4,1
    80001d64:	fd5ff06f          	j	80001d38 <kern_thread_create+0x14>
            *handle=&threads[i];
    80001d68:	00171793          	slli	a5,a4,0x1
    80001d6c:	00e787b3          	add	a5,a5,a4
    80001d70:	00579793          	slli	a5,a5,0x5
    80001d74:	010787b3          	add	a5,a5,a6
    80001d78:	00f53023          	sd	a5,0(a0)
            t=&threads[i];
            break;
        }
    }
    if(*handle==0) return -1;
    80001d7c:	00053703          	ld	a4,0(a0)
    80001d80:	06070e63          	beqz	a4,80001dfc <kern_thread_create+0xd8>

    t->id=++id;
    80001d84:	00004517          	auipc	a0,0x4
    80001d88:	8e450513          	addi	a0,a0,-1820 # 80005668 <id>
    80001d8c:	00052703          	lw	a4,0(a0)
    80001d90:	0017071b          	addiw	a4,a4,1
    80001d94:	0007081b          	sext.w	a6,a4
    80001d98:	00e52023          	sw	a4,0(a0)
    80001d9c:	0107b823          	sd	a6,16(a5)
    t->status=READY;
    80001da0:	00200713          	li	a4,2
    80001da4:	04e7a823          	sw	a4,80(a5)
    t->arg=arg;
    80001da8:	02c7b023          	sd	a2,32(a5)
    t->joined_tid=-1;
    80001dac:	fff00713          	li	a4,-1
    80001db0:	02e7b423          	sd	a4,40(a5)
    t->timeslice=DEFAULT_TIME_SLICE;
    80001db4:	00200713          	li	a4,2
    80001db8:	02e7b823          	sd	a4,48(a5)
    t->body=start_routine;
    80001dbc:	00b7bc23          	sd	a1,24(a5)
    t->stack_space = ((uint64)stack_space);
    80001dc0:	04d7b423          	sd	a3,72(a5)
    t->sp = t->stack_space+(DEFAULT_STACK_SIZE);
    80001dc4:	00001737          	lui	a4,0x1
    80001dc8:	00e686b3          	add	a3,a3,a4
    80001dcc:	00d7b423          	sd	a3,8(a5)
    t->ra=(uint64) &kern_thread_wrapper;
    80001dd0:	00000717          	auipc	a4,0x0
    80001dd4:	e7070713          	addi	a4,a4,-400 # 80001c40 <kern_thread_wrapper>
    80001dd8:	00e7b023          	sd	a4,0(a5)
    t->sem_next=0;
    80001ddc:	0407bc23          	sd	zero,88(a5)

    return 0;
    80001de0:	00000513          	li	a0,0
}
    80001de4:	00813403          	ld	s0,8(sp)
    80001de8:	01010113          	addi	sp,sp,16
    80001dec:	00008067          	ret
    thread_t t=&threads[0]; //dodela da bismo sklonili upozorenje
    80001df0:	00005797          	auipc	a5,0x5
    80001df4:	0a878793          	addi	a5,a5,168 # 80006e98 <threads>
    80001df8:	f85ff06f          	j	80001d7c <kern_thread_create+0x58>
    if(*handle==0) return -1;
    80001dfc:	fff00513          	li	a0,-1
    80001e00:	fe5ff06f          	j	80001de4 <kern_thread_create+0xc0>

0000000080001e04 <kern_thread_join>:

void kern_thread_join(thread_t handle)
{
    if(handle->status==UNUSED) return;
    80001e04:	05052783          	lw	a5,80(a0)
    80001e08:	00079463          	bnez	a5,80001e10 <kern_thread_join+0xc>
    80001e0c:	00008067          	ret
{
    80001e10:	ff010113          	addi	sp,sp,-16
    80001e14:	00113423          	sd	ra,8(sp)
    80001e18:	00813023          	sd	s0,0(sp)
    80001e1c:	01010413          	addi	s0,sp,16
    running->joined_tid=handle->id;
    80001e20:	00004797          	auipc	a5,0x4
    80001e24:	8407b783          	ld	a5,-1984(a5) # 80005660 <running>
    80001e28:	01053703          	ld	a4,16(a0)
    80001e2c:	02e7b423          	sd	a4,40(a5)
    running->status=JOINED;
    80001e30:	00400713          	li	a4,4
    80001e34:	04e7a823          	sw	a4,80(a5)
    kern_thread_dispatch();
    80001e38:	00000097          	auipc	ra,0x0
    80001e3c:	c9c080e7          	jalr	-868(ra) # 80001ad4 <kern_thread_dispatch>
}
    80001e40:	00813083          	ld	ra,8(sp)
    80001e44:	00013403          	ld	s0,0(sp)
    80001e48:	01010113          	addi	sp,sp,16
    80001e4c:	00008067          	ret

0000000080001e50 <kern_thread_wakeup>:

void kern_thread_wakeup(uint64 system_time)
{
    80001e50:	ff010113          	addi	sp,sp,-16
    80001e54:	00813423          	sd	s0,8(sp)
    80001e58:	01010413          	addi	s0,sp,16
    for(int i=0;i<MAX_THREADS;i++){
    80001e5c:	00000793          	li	a5,0
    80001e60:	0080006f          	j	80001e68 <kern_thread_wakeup+0x18>
    80001e64:	0017879b          	addiw	a5,a5,1
    80001e68:	03f00713          	li	a4,63
    80001e6c:	06f74263          	blt	a4,a5,80001ed0 <kern_thread_wakeup+0x80>
        if(threads[i].status==SLEEPING && threads[i].endTime<system_time){
    80001e70:	00179713          	slli	a4,a5,0x1
    80001e74:	00f70733          	add	a4,a4,a5
    80001e78:	00571713          	slli	a4,a4,0x5
    80001e7c:	00005697          	auipc	a3,0x5
    80001e80:	01c68693          	addi	a3,a3,28 # 80006e98 <threads>
    80001e84:	00e68733          	add	a4,a3,a4
    80001e88:	05072683          	lw	a3,80(a4)
    80001e8c:	00500713          	li	a4,5
    80001e90:	fce69ae3          	bne	a3,a4,80001e64 <kern_thread_wakeup+0x14>
    80001e94:	00179713          	slli	a4,a5,0x1
    80001e98:	00f70733          	add	a4,a4,a5
    80001e9c:	00571713          	slli	a4,a4,0x5
    80001ea0:	00005697          	auipc	a3,0x5
    80001ea4:	ff868693          	addi	a3,a3,-8 # 80006e98 <threads>
    80001ea8:	00e68733          	add	a4,a3,a4
    80001eac:	03873703          	ld	a4,56(a4)
    80001eb0:	faa77ae3          	bgeu	a4,a0,80001e64 <kern_thread_wakeup+0x14>
            threads[i].status=READY;
    80001eb4:	00179713          	slli	a4,a5,0x1
    80001eb8:	00f70733          	add	a4,a4,a5
    80001ebc:	00571713          	slli	a4,a4,0x5
    80001ec0:	00e68733          	add	a4,a3,a4
    80001ec4:	00200693          	li	a3,2
    80001ec8:	04d72823          	sw	a3,80(a4)
    80001ecc:	f99ff06f          	j	80001e64 <kern_thread_wakeup+0x14>
        }
    }
}
    80001ed0:	00813403          	ld	s0,8(sp)
    80001ed4:	01010113          	addi	sp,sp,16
    80001ed8:	00008067          	ret

0000000080001edc <mem_alloc>:
#include "../h/kern_interrupts.h"

#include <stdarg.h>


void* mem_alloc (size_t size){
    80001edc:	ff010113          	addi	sp,sp,-16
    80001ee0:	00113423          	sd	ra,8(sp)
    80001ee4:	00813023          	sd	s0,0(sp)
    80001ee8:	01010413          	addi	s0,sp,16
    uint64 blocks = (size+MEM_BLOCK_SIZE-1)/MEM_BLOCK_SIZE;
    80001eec:	03f50593          	addi	a1,a0,63
    return (void*)kern_syscall(MEM_ALLOC, blocks);
    80001ef0:	0065d593          	srli	a1,a1,0x6
    80001ef4:	00100513          	li	a0,1
    80001ef8:	fffff097          	auipc	ra,0xfffff
    80001efc:	5d4080e7          	jalr	1492(ra) # 800014cc <kern_syscall>
}
    80001f00:	00813083          	ld	ra,8(sp)
    80001f04:	00013403          	ld	s0,0(sp)
    80001f08:	01010113          	addi	sp,sp,16
    80001f0c:	00008067          	ret

0000000080001f10 <mem_free>:

int mem_free (void* addr){
    80001f10:	ff010113          	addi	sp,sp,-16
    80001f14:	00113423          	sd	ra,8(sp)
    80001f18:	00813023          	sd	s0,0(sp)
    80001f1c:	01010413          	addi	s0,sp,16
    80001f20:	00050593          	mv	a1,a0
    return (int) kern_syscall(MEM_FREE,addr);
    80001f24:	00200513          	li	a0,2
    80001f28:	fffff097          	auipc	ra,0xfffff
    80001f2c:	5a4080e7          	jalr	1444(ra) # 800014cc <kern_syscall>
}
    80001f30:	0005051b          	sext.w	a0,a0
    80001f34:	00813083          	ld	ra,8(sp)
    80001f38:	00013403          	ld	s0,0(sp)
    80001f3c:	01010113          	addi	sp,sp,16
    80001f40:	00008067          	ret

0000000080001f44 <thread_create>:

struct thread_s;
typedef struct thread_s* thread_t;

int thread_create (thread_t* handle, void(*start_routine)(void*), void* arg)
{
    80001f44:	fd010113          	addi	sp,sp,-48
    80001f48:	02113423          	sd	ra,40(sp)
    80001f4c:	02813023          	sd	s0,32(sp)
    80001f50:	00913c23          	sd	s1,24(sp)
    80001f54:	01213823          	sd	s2,16(sp)
    80001f58:	01313423          	sd	s3,8(sp)
    80001f5c:	03010413          	addi	s0,sp,48
    80001f60:	00050493          	mv	s1,a0
    80001f64:	00058913          	mv	s2,a1
    80001f68:	00060993          	mv	s3,a2
    void * stack = mem_alloc(DEFAULT_STACK_SIZE);
    80001f6c:	00001537          	lui	a0,0x1
    80001f70:	00000097          	auipc	ra,0x0
    80001f74:	f6c080e7          	jalr	-148(ra) # 80001edc <mem_alloc>
    if(stack==0) return -1;
    80001f78:	04050063          	beqz	a0,80001fb8 <thread_create+0x74>
    80001f7c:	00050713          	mv	a4,a0
    return (int) kern_syscall(THREAD_CREATE,handle,start_routine,arg,stack);
    80001f80:	00098693          	mv	a3,s3
    80001f84:	00090613          	mv	a2,s2
    80001f88:	00048593          	mv	a1,s1
    80001f8c:	01100513          	li	a0,17
    80001f90:	fffff097          	auipc	ra,0xfffff
    80001f94:	53c080e7          	jalr	1340(ra) # 800014cc <kern_syscall>
    80001f98:	0005051b          	sext.w	a0,a0
}
    80001f9c:	02813083          	ld	ra,40(sp)
    80001fa0:	02013403          	ld	s0,32(sp)
    80001fa4:	01813483          	ld	s1,24(sp)
    80001fa8:	01013903          	ld	s2,16(sp)
    80001fac:	00813983          	ld	s3,8(sp)
    80001fb0:	03010113          	addi	sp,sp,48
    80001fb4:	00008067          	ret
    if(stack==0) return -1;
    80001fb8:	fff00513          	li	a0,-1
    80001fbc:	fe1ff06f          	j	80001f9c <thread_create+0x58>

0000000080001fc0 <thread_dispatch>:

void thread_dispatch(){
    80001fc0:	ff010113          	addi	sp,sp,-16
    80001fc4:	00113423          	sd	ra,8(sp)
    80001fc8:	00813023          	sd	s0,0(sp)
    80001fcc:	01010413          	addi	s0,sp,16
    kern_syscall(THREAD_DISPATCH);
    80001fd0:	01300513          	li	a0,19
    80001fd4:	fffff097          	auipc	ra,0xfffff
    80001fd8:	4f8080e7          	jalr	1272(ra) # 800014cc <kern_syscall>
}
    80001fdc:	00813083          	ld	ra,8(sp)
    80001fe0:	00013403          	ld	s0,0(sp)
    80001fe4:	01010113          	addi	sp,sp,16
    80001fe8:	00008067          	ret

0000000080001fec <thread_exit>:

int thread_exit ()
{
    80001fec:	fe010113          	addi	sp,sp,-32
    80001ff0:	00113c23          	sd	ra,24(sp)
    80001ff4:	00813823          	sd	s0,16(sp)
    80001ff8:	00913423          	sd	s1,8(sp)
    80001ffc:	02010413          	addi	s0,sp,32
    void* stack = (void*)running->stack_space;
    80002000:	00003797          	auipc	a5,0x3
    80002004:	6607b783          	ld	a5,1632(a5) # 80005660 <running>
    80002008:	0487b483          	ld	s1,72(a5)
    kern_syscall(THREAD_EXIT);
    8000200c:	01200513          	li	a0,18
    80002010:	fffff097          	auipc	ra,0xfffff
    80002014:	4bc080e7          	jalr	1212(ra) # 800014cc <kern_syscall>
    kern_syscall(MEM_FREE,stack);
    80002018:	00048593          	mv	a1,s1
    8000201c:	00200513          	li	a0,2
    80002020:	fffff097          	auipc	ra,0xfffff
    80002024:	4ac080e7          	jalr	1196(ra) # 800014cc <kern_syscall>
    return 0;
}
    80002028:	00000513          	li	a0,0
    8000202c:	01813083          	ld	ra,24(sp)
    80002030:	01013403          	ld	s0,16(sp)
    80002034:	00813483          	ld	s1,8(sp)
    80002038:	02010113          	addi	sp,sp,32
    8000203c:	00008067          	ret

0000000080002040 <thread_join>:

void thread_join(thread_t handle)
{
    80002040:	ff010113          	addi	sp,sp,-16
    80002044:	00113423          	sd	ra,8(sp)
    80002048:	00813023          	sd	s0,0(sp)
    8000204c:	01010413          	addi	s0,sp,16
    80002050:	00050593          	mv	a1,a0
    kern_syscall(THREAD_JOIN,handle);
    80002054:	01400513          	li	a0,20
    80002058:	fffff097          	auipc	ra,0xfffff
    8000205c:	474080e7          	jalr	1140(ra) # 800014cc <kern_syscall>
}
    80002060:	00813083          	ld	ra,8(sp)
    80002064:	00013403          	ld	s0,0(sp)
    80002068:	01010113          	addi	sp,sp,16
    8000206c:	00008067          	ret

0000000080002070 <sem_open>:

int sem_open (sem_t* handle, unsigned init)
{
    80002070:	ff010113          	addi	sp,sp,-16
    80002074:	00113423          	sd	ra,8(sp)
    80002078:	00813023          	sd	s0,0(sp)
    8000207c:	01010413          	addi	s0,sp,16
    80002080:	00058613          	mv	a2,a1
    return kern_syscall(SEM_OPEN,handle,init);
    80002084:	00050593          	mv	a1,a0
    80002088:	02100513          	li	a0,33
    8000208c:	fffff097          	auipc	ra,0xfffff
    80002090:	440080e7          	jalr	1088(ra) # 800014cc <kern_syscall>
}
    80002094:	0005051b          	sext.w	a0,a0
    80002098:	00813083          	ld	ra,8(sp)
    8000209c:	00013403          	ld	s0,0(sp)
    800020a0:	01010113          	addi	sp,sp,16
    800020a4:	00008067          	ret

00000000800020a8 <sem_close>:

int sem_close (sem_t handle)
{
    800020a8:	ff010113          	addi	sp,sp,-16
    800020ac:	00113423          	sd	ra,8(sp)
    800020b0:	00813023          	sd	s0,0(sp)
    800020b4:	01010413          	addi	s0,sp,16
    800020b8:	00050593          	mv	a1,a0
    return kern_syscall(SEM_CLOSE,handle);
    800020bc:	02200513          	li	a0,34
    800020c0:	fffff097          	auipc	ra,0xfffff
    800020c4:	40c080e7          	jalr	1036(ra) # 800014cc <kern_syscall>
}
    800020c8:	0005051b          	sext.w	a0,a0
    800020cc:	00813083          	ld	ra,8(sp)
    800020d0:	00013403          	ld	s0,0(sp)
    800020d4:	01010113          	addi	sp,sp,16
    800020d8:	00008067          	ret

00000000800020dc <sem_wait>:

int sem_wait (sem_t id)
{
    800020dc:	ff010113          	addi	sp,sp,-16
    800020e0:	00113423          	sd	ra,8(sp)
    800020e4:	00813023          	sd	s0,0(sp)
    800020e8:	01010413          	addi	s0,sp,16
    800020ec:	00050593          	mv	a1,a0
    return kern_syscall(SEM_WAIT,id);
    800020f0:	02300513          	li	a0,35
    800020f4:	fffff097          	auipc	ra,0xfffff
    800020f8:	3d8080e7          	jalr	984(ra) # 800014cc <kern_syscall>
}
    800020fc:	0005051b          	sext.w	a0,a0
    80002100:	00813083          	ld	ra,8(sp)
    80002104:	00013403          	ld	s0,0(sp)
    80002108:	01010113          	addi	sp,sp,16
    8000210c:	00008067          	ret

0000000080002110 <sem_signal>:

int sem_signal (sem_t id){
    80002110:	ff010113          	addi	sp,sp,-16
    80002114:	00113423          	sd	ra,8(sp)
    80002118:	00813023          	sd	s0,0(sp)
    8000211c:	01010413          	addi	s0,sp,16
    80002120:	00050593          	mv	a1,a0
    return kern_syscall(SEM_SIGNAL,id);
    80002124:	02400513          	li	a0,36
    80002128:	fffff097          	auipc	ra,0xfffff
    8000212c:	3a4080e7          	jalr	932(ra) # 800014cc <kern_syscall>
}
    80002130:	0005051b          	sext.w	a0,a0
    80002134:	00813083          	ld	ra,8(sp)
    80002138:	00013403          	ld	s0,0(sp)
    8000213c:	01010113          	addi	sp,sp,16
    80002140:	00008067          	ret

0000000080002144 <time_sleep>:

int time_sleep(unsigned long time){
    80002144:	ff010113          	addi	sp,sp,-16
    80002148:	00113423          	sd	ra,8(sp)
    8000214c:	00813023          	sd	s0,0(sp)
    80002150:	01010413          	addi	s0,sp,16
    80002154:	00050593          	mv	a1,a0
    kern_syscall(TIME_SLEEP,time);
    80002158:	03100513          	li	a0,49
    8000215c:	fffff097          	auipc	ra,0xfffff
    80002160:	370080e7          	jalr	880(ra) # 800014cc <kern_syscall>
    return 0;
    80002164:	00000513          	li	a0,0
    80002168:	00813083          	ld	ra,8(sp)
    8000216c:	00013403          	ld	s0,0(sp)
    80002170:	01010113          	addi	sp,sp,16
    80002174:	00008067          	ret

0000000080002178 <_Z8bodyIdlePv>:

Semaphore* semTest;

int idleAlive=1;
void bodyIdle(void* arg){
    while(idleAlive){
    80002178:	00003797          	auipc	a5,0x3
    8000217c:	4287a783          	lw	a5,1064(a5) # 800055a0 <idleAlive>
    80002180:	02078c63          	beqz	a5,800021b8 <_Z8bodyIdlePv+0x40>
void bodyIdle(void* arg){
    80002184:	ff010113          	addi	sp,sp,-16
    80002188:	00113423          	sd	ra,8(sp)
    8000218c:	00813023          	sd	s0,0(sp)
    80002190:	01010413          	addi	s0,sp,16
        thread_dispatch();
    80002194:	00000097          	auipc	ra,0x0
    80002198:	e2c080e7          	jalr	-468(ra) # 80001fc0 <thread_dispatch>
    while(idleAlive){
    8000219c:	00003797          	auipc	a5,0x3
    800021a0:	4047a783          	lw	a5,1028(a5) # 800055a0 <idleAlive>
    800021a4:	fe0798e3          	bnez	a5,80002194 <_Z8bodyIdlePv+0x1c>
    };
}
    800021a8:	00813083          	ld	ra,8(sp)
    800021ac:	00013403          	ld	s0,0(sp)
    800021b0:	01010113          	addi	sp,sp,16
    800021b4:	00008067          	ret
    800021b8:	00008067          	ret

00000000800021bc <_Z5bodyCPv>:

void bodyC(void* arg)
{
    800021bc:	fe010113          	addi	sp,sp,-32
    800021c0:	00113c23          	sd	ra,24(sp)
    800021c4:	00813823          	sd	s0,16(sp)
    800021c8:	00913423          	sd	s1,8(sp)
    800021cc:	01213023          	sd	s2,0(sp)
    800021d0:	02010413          	addi	s0,sp,32
    800021d4:	00050913          	mv	s2,a0
    int counter=0;
    800021d8:	00000493          	li	s1,0
    char*c = (char*)arg;
    while(counter<10){
    800021dc:	00900793          	li	a5,9
    800021e0:	0297c263          	blt	a5,s1,80002204 <_Z5bodyCPv+0x48>
        //if(++counter>5) delete semTest;
        __putc(*c);
    800021e4:	00094503          	lbu	a0,0(s2)
    800021e8:	00002097          	auipc	ra,0x2
    800021ec:	5f4080e7          	jalr	1524(ra) # 800047dc <__putc>
        time_sleep(5);
    800021f0:	00500513          	li	a0,5
    800021f4:	00000097          	auipc	ra,0x0
    800021f8:	f50080e7          	jalr	-176(ra) # 80002144 <time_sleep>
        counter++;
    800021fc:	0014849b          	addiw	s1,s1,1
    while(counter<10){
    80002200:	fddff06f          	j	800021dc <_Z5bodyCPv+0x20>
    }
}
    80002204:	01813083          	ld	ra,24(sp)
    80002208:	01013403          	ld	s0,16(sp)
    8000220c:	00813483          	ld	s1,8(sp)
    80002210:	00013903          	ld	s2,0(sp)
    80002214:	02010113          	addi	sp,sp,32
    80002218:	00008067          	ret

000000008000221c <_Z5bodyAPv>:

void bodyA(void* arg)
{
    8000221c:	fe010113          	addi	sp,sp,-32
    80002220:	00113c23          	sd	ra,24(sp)
    80002224:	00813823          	sd	s0,16(sp)
    80002228:	00913423          	sd	s1,8(sp)
    8000222c:	01213023          	sd	s2,0(sp)
    80002230:	02010413          	addi	s0,sp,32
        }
        virtual ~Semaphore (){
            sem_close(myHandle);
        }
        int wait (){
            return sem_wait(myHandle);
    80002234:	00006797          	auipc	a5,0x6
    80002238:	4647b783          	ld	a5,1124(a5) # 80008698 <semTest>
    8000223c:	0087b503          	ld	a0,8(a5)
    80002240:	00000097          	auipc	ra,0x0
    80002244:	e9c080e7          	jalr	-356(ra) # 800020dc <sem_wait>
    char c = 'a';
    if(semTest->wait()) c='A';
    80002248:	00051863          	bnez	a0,80002258 <_Z5bodyAPv+0x3c>
    char c = 'a';
    8000224c:	06100913          	li	s2,97
    for(int i=0;i<10;i++){
    80002250:	00000493          	li	s1,0
    80002254:	0200006f          	j	80002274 <_Z5bodyAPv+0x58>
    if(semTest->wait()) c='A';
    80002258:	04100913          	li	s2,65
    8000225c:	ff5ff06f          	j	80002250 <_Z5bodyAPv+0x34>
        __putc(c);
        if(i==5) thread_exit();
    80002260:	00000097          	auipc	ra,0x0
    80002264:	d8c080e7          	jalr	-628(ra) # 80001fec <thread_exit>
        thread_dispatch();
    80002268:	00000097          	auipc	ra,0x0
    8000226c:	d58080e7          	jalr	-680(ra) # 80001fc0 <thread_dispatch>
    for(int i=0;i<10;i++){
    80002270:	0014849b          	addiw	s1,s1,1
    80002274:	00900793          	li	a5,9
    80002278:	0097ce63          	blt	a5,s1,80002294 <_Z5bodyAPv+0x78>
        __putc(c);
    8000227c:	00090513          	mv	a0,s2
    80002280:	00002097          	auipc	ra,0x2
    80002284:	55c080e7          	jalr	1372(ra) # 800047dc <__putc>
        if(i==5) thread_exit();
    80002288:	00500793          	li	a5,5
    8000228c:	fcf49ee3          	bne	s1,a5,80002268 <_Z5bodyAPv+0x4c>
    80002290:	fd1ff06f          	j	80002260 <_Z5bodyAPv+0x44>
    }
}
    80002294:	01813083          	ld	ra,24(sp)
    80002298:	01013403          	ld	s0,16(sp)
    8000229c:	00813483          	ld	s1,8(sp)
    800022a0:	00013903          	ld	s2,0(sp)
    800022a4:	02010113          	addi	sp,sp,32
    800022a8:	00008067          	ret

00000000800022ac <_Z5bodyBPv>:

int g=0;

char str[15] = "tesa legenda";
void bodyB(void* arg)
{
    800022ac:	fe010113          	addi	sp,sp,-32
    800022b0:	00113c23          	sd	ra,24(sp)
    800022b4:	00813823          	sd	s0,16(sp)
    800022b8:	00913423          	sd	s1,8(sp)
    800022bc:	02010413          	addi	s0,sp,32
    time_sleep(10);
    800022c0:	00a00513          	li	a0,10
    800022c4:	00000097          	auipc	ra,0x0
    800022c8:	e80080e7          	jalr	-384(ra) # 80002144 <time_sleep>
    for(int i=0;i<15;i++){
    800022cc:	00000493          	li	s1,0
    800022d0:	0540006f          	j	80002324 <_Z5bodyBPv+0x78>
        __putc(str[i]);
        for(int k=0;k<10000;k++){
            for(int m=0;m<1000;m++){
    800022d4:	0017071b          	addiw	a4,a4,1
    800022d8:	3e700793          	li	a5,999
    800022dc:	02e7c663          	blt	a5,a4,80002308 <_Z5bodyBPv+0x5c>
                if((m*k)%1337==0) g++;
    800022e0:	02e607bb          	mulw	a5,a2,a4
    800022e4:	53900693          	li	a3,1337
    800022e8:	02d7e7bb          	remw	a5,a5,a3
    800022ec:	fe0794e3          	bnez	a5,800022d4 <_Z5bodyBPv+0x28>
    800022f0:	00006697          	auipc	a3,0x6
    800022f4:	3a868693          	addi	a3,a3,936 # 80008698 <semTest>
    800022f8:	0086a783          	lw	a5,8(a3)
    800022fc:	0017879b          	addiw	a5,a5,1
    80002300:	00f6a423          	sw	a5,8(a3)
    80002304:	fd1ff06f          	j	800022d4 <_Z5bodyBPv+0x28>
        for(int k=0;k<10000;k++){
    80002308:	0016061b          	addiw	a2,a2,1
    8000230c:	000027b7          	lui	a5,0x2
    80002310:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    80002314:	00c7c663          	blt	a5,a2,80002320 <_Z5bodyBPv+0x74>
            for(int m=0;m<1000;m++){
    80002318:	00000713          	li	a4,0
    8000231c:	fbdff06f          	j	800022d8 <_Z5bodyBPv+0x2c>
    for(int i=0;i<15;i++){
    80002320:	0014849b          	addiw	s1,s1,1
    80002324:	00e00793          	li	a5,14
    80002328:	0297c263          	blt	a5,s1,8000234c <_Z5bodyBPv+0xa0>
        __putc(str[i]);
    8000232c:	00003797          	auipc	a5,0x3
    80002330:	27478793          	addi	a5,a5,628 # 800055a0 <idleAlive>
    80002334:	009787b3          	add	a5,a5,s1
    80002338:	0087c503          	lbu	a0,8(a5)
    8000233c:	00002097          	auipc	ra,0x2
    80002340:	4a0080e7          	jalr	1184(ra) # 800047dc <__putc>
        for(int k=0;k<10000;k++){
    80002344:	00000613          	li	a2,0
    80002348:	fc5ff06f          	j	8000230c <_Z5bodyBPv+0x60>
        }
        int signal (){
            return sem_signal(myHandle);
    8000234c:	00006797          	auipc	a5,0x6
    80002350:	34c7b783          	ld	a5,844(a5) # 80008698 <semTest>
    80002354:	0087b503          	ld	a0,8(a5)
    80002358:	00000097          	auipc	ra,0x0
    8000235c:	db8080e7          	jalr	-584(ra) # 80002110 <sem_signal>
            }
        }
    }
    semTest->signal();
}
    80002360:	01813083          	ld	ra,24(sp)
    80002364:	01013403          	ld	s0,16(sp)
    80002368:	00813483          	ld	s1,8(sp)
    8000236c:	02010113          	addi	sp,sp,32
    80002370:	00008067          	ret

0000000080002374 <_Znwm>:
void* operator new(size_t size) {
    80002374:	ff010113          	addi	sp,sp,-16
    80002378:	00113423          	sd	ra,8(sp)
    8000237c:	00813023          	sd	s0,0(sp)
    80002380:	01010413          	addi	s0,sp,16
    void* ptr = mem_alloc(size);
    80002384:	00000097          	auipc	ra,0x0
    80002388:	b58080e7          	jalr	-1192(ra) # 80001edc <mem_alloc>
}
    8000238c:	00813083          	ld	ra,8(sp)
    80002390:	00013403          	ld	s0,0(sp)
    80002394:	01010113          	addi	sp,sp,16
    80002398:	00008067          	ret

000000008000239c <_ZdlPv>:
void operator delete(void* ptr) {
    8000239c:	ff010113          	addi	sp,sp,-16
    800023a0:	00113423          	sd	ra,8(sp)
    800023a4:	00813023          	sd	s0,0(sp)
    800023a8:	01010413          	addi	s0,sp,16
    mem_free(ptr);
    800023ac:	00000097          	auipc	ra,0x0
    800023b0:	b64080e7          	jalr	-1180(ra) # 80001f10 <mem_free>
}
    800023b4:	00813083          	ld	ra,8(sp)
    800023b8:	00013403          	ld	s0,0(sp)
    800023bc:	01010113          	addi	sp,sp,16
    800023c0:	00008067          	ret

00000000800023c4 <main>:


int main()
{
    800023c4:	fc010113          	addi	sp,sp,-64
    800023c8:	02113c23          	sd	ra,56(sp)
    800023cc:	02813823          	sd	s0,48(sp)
    800023d0:	02913423          	sd	s1,40(sp)
    800023d4:	03213023          	sd	s2,32(sp)
    800023d8:	01313c23          	sd	s3,24(sp)
    800023dc:	04010413          	addi	s0,sp,64
    kern_thread_init();
    800023e0:	fffff097          	auipc	ra,0xfffff
    800023e4:	554080e7          	jalr	1364(ra) # 80001934 <kern_thread_init>
    //printstring("lalala");

    kern_mem_init((void*)HEAP_START_ADDR, (void*)HEAP_END_ADDR);
    800023e8:	00003797          	auipc	a5,0x3
    800023ec:	2387b783          	ld	a5,568(a5) # 80005620 <_GLOBAL_OFFSET_TABLE_+0x18>
    800023f0:	0007b583          	ld	a1,0(a5)
    800023f4:	00003797          	auipc	a5,0x3
    800023f8:	21c7b783          	ld	a5,540(a5) # 80005610 <_GLOBAL_OFFSET_TABLE_+0x8>
    800023fc:	0007b503          	ld	a0,0(a5)
    80002400:	fffff097          	auipc	ra,0xfffff
    80002404:	05c080e7          	jalr	92(ra) # 8000145c <kern_mem_init>
    kern_interrupt_init();
    80002408:	fffff097          	auipc	ra,0xfffff
    8000240c:	108080e7          	jalr	264(ra) # 80001510 <kern_interrupt_init>
    kern_sem_init();
    80002410:	fffff097          	auipc	ra,0xfffff
    80002414:	d14080e7          	jalr	-748(ra) # 80001124 <kern_sem_init>

    Thread* thrIdle = new Thread(&bodyIdle,0);
    80002418:	02000513          	li	a0,32
    8000241c:	00000097          	auipc	ra,0x0
    80002420:	f58080e7          	jalr	-168(ra) # 80002374 <_Znwm>
        {
    80002424:	00003797          	auipc	a5,0x3
    80002428:	1a478793          	addi	a5,a5,420 # 800055c8 <_ZTV6Thread+0x10>
    8000242c:	00f53023          	sd	a5,0(a0) # 1000 <_entry-0x7ffff000>
            this->body=body;
    80002430:	00000597          	auipc	a1,0x0
    80002434:	d4858593          	addi	a1,a1,-696 # 80002178 <_Z8bodyIdlePv>
    80002438:	00b53823          	sd	a1,16(a0)
            this->arg=arg;
    8000243c:	00053c23          	sd	zero,24(a0)
            return thread_create(&myHandle,body,arg);
    80002440:	00000613          	li	a2,0
    80002444:	00850513          	addi	a0,a0,8
    80002448:	00000097          	auipc	ra,0x0
    8000244c:	afc080e7          	jalr	-1284(ra) # 80001f44 <thread_create>
    a= mem_alloc(64);
    mem_free(a);
    */


    semTest=new Semaphore(0);
    80002450:	01000513          	li	a0,16
    80002454:	00000097          	auipc	ra,0x0
    80002458:	f20080e7          	jalr	-224(ra) # 80002374 <_Znwm>
    8000245c:	00050493          	mv	s1,a0
        Semaphore (unsigned init = 1){
    80002460:	00003797          	auipc	a5,0x3
    80002464:	19078793          	addi	a5,a5,400 # 800055f0 <_ZTV9Semaphore+0x10>
    80002468:	00f53023          	sd	a5,0(a0)
            sem_open(&myHandle,init);
    8000246c:	00000593          	li	a1,0
    80002470:	00850513          	addi	a0,a0,8
    80002474:	00000097          	auipc	ra,0x0
    80002478:	bfc080e7          	jalr	-1028(ra) # 80002070 <sem_open>
    8000247c:	00006797          	auipc	a5,0x6
    80002480:	2097be23          	sd	s1,540(a5) # 80008698 <semTest>


    Thread *thrA = new Thread(&bodyA,0);
    80002484:	02000513          	li	a0,32
    80002488:	00000097          	auipc	ra,0x0
    8000248c:	eec080e7          	jalr	-276(ra) # 80002374 <_Znwm>
    80002490:	00050913          	mv	s2,a0
        {
    80002494:	00003997          	auipc	s3,0x3
    80002498:	13498993          	addi	s3,s3,308 # 800055c8 <_ZTV6Thread+0x10>
    8000249c:	01353023          	sd	s3,0(a0)
            this->body=body;
    800024a0:	00000797          	auipc	a5,0x0
    800024a4:	d7c78793          	addi	a5,a5,-644 # 8000221c <_Z5bodyAPv>
    800024a8:	00f53823          	sd	a5,16(a0)
            this->arg=arg;
    800024ac:	00053c23          	sd	zero,24(a0)
    Thread *thrB = new Thread(&bodyB,0);
    800024b0:	02000513          	li	a0,32
    800024b4:	00000097          	auipc	ra,0x0
    800024b8:	ec0080e7          	jalr	-320(ra) # 80002374 <_Znwm>
    800024bc:	00050493          	mv	s1,a0
        {
    800024c0:	01353023          	sd	s3,0(a0)
            this->body=body;
    800024c4:	00000797          	auipc	a5,0x0
    800024c8:	de878793          	addi	a5,a5,-536 # 800022ac <_Z5bodyBPv>
    800024cc:	00f53823          	sd	a5,16(a0)
            this->arg=arg;
    800024d0:	00053c23          	sd	zero,24(a0)
            return thread_create(&myHandle,body,arg);
    800024d4:	01893603          	ld	a2,24(s2)
    800024d8:	01093583          	ld	a1,16(s2)
    800024dc:	00890513          	addi	a0,s2,8
    800024e0:	00000097          	auipc	ra,0x0
    800024e4:	a64080e7          	jalr	-1436(ra) # 80001f44 <thread_create>
    800024e8:	0184b603          	ld	a2,24(s1)
    800024ec:	0104b583          	ld	a1,16(s1)
    800024f0:	00848513          	addi	a0,s1,8
    800024f4:	00000097          	auipc	ra,0x0
    800024f8:	a50080e7          	jalr	-1456(ra) # 80001f44 <thread_create>
    thrA->start();
    thrB->start();


    __putc('S');
    800024fc:	05300513          	li	a0,83
    80002500:	00002097          	auipc	ra,0x2
    80002504:	2dc080e7          	jalr	732(ra) # 800047dc <__putc>
            thread_join(myHandle);
    80002508:	0084b503          	ld	a0,8(s1)
    8000250c:	00000097          	auipc	ra,0x0
    80002510:	b34080e7          	jalr	-1228(ra) # 80002040 <thread_join>
    80002514:	00893503          	ld	a0,8(s2)
    80002518:	00000097          	auipc	ra,0x0
    8000251c:	b28080e7          	jalr	-1240(ra) # 80002040 <thread_join>
    80002520:	0084b503          	ld	a0,8(s1)
    80002524:	00000097          	auipc	ra,0x0
    80002528:	b1c080e7          	jalr	-1252(ra) # 80002040 <thread_join>
     thrA->join();
     thrB->join();

    char o='O';
    char c='M';
    c++;
    8000252c:	04e00793          	li	a5,78
    80002530:	fcf40723          	sb	a5,-50(s0)
    o++;
    80002534:	05000793          	li	a5,80
    80002538:	fcf407a3          	sb	a5,-49(s0)
    Thread* thrCobj = new Thread(bodyC, &o);
    8000253c:	02000513          	li	a0,32
    80002540:	00000097          	auipc	ra,0x0
    80002544:	e34080e7          	jalr	-460(ra) # 80002374 <_Znwm>
    80002548:	00050493          	mv	s1,a0
        {
    8000254c:	01353023          	sd	s3,0(a0)
            this->body=body;
    80002550:	00000917          	auipc	s2,0x0
    80002554:	c6c90913          	addi	s2,s2,-916 # 800021bc <_Z5bodyCPv>
    80002558:	01253823          	sd	s2,16(a0)
            this->arg=arg;
    8000255c:	fcf40613          	addi	a2,s0,-49
    80002560:	00c53c23          	sd	a2,24(a0)
            return thread_create(&myHandle,body,arg);
    80002564:	00090593          	mv	a1,s2
    80002568:	00850513          	addi	a0,a0,8
    8000256c:	00000097          	auipc	ra,0x0
    80002570:	9d8080e7          	jalr	-1576(ra) # 80001f44 <thread_create>
    thrCobj->start();


    thread_t thrC;
    thread_create(&thrC,bodyC,&c);
    80002574:	fce40613          	addi	a2,s0,-50
    80002578:	00090593          	mv	a1,s2
    8000257c:	fc040513          	addi	a0,s0,-64
    80002580:	00000097          	auipc	ra,0x0
    80002584:	9c4080e7          	jalr	-1596(ra) # 80001f44 <thread_create>
    thread_join(thrC);
    80002588:	fc043503          	ld	a0,-64(s0)
    8000258c:	00000097          	auipc	ra,0x0
    80002590:	ab4080e7          	jalr	-1356(ra) # 80002040 <thread_join>
            thread_join(myHandle);
    80002594:	0084b503          	ld	a0,8(s1)
    80002598:	00000097          	auipc	ra,0x0
    8000259c:	aa8080e7          	jalr	-1368(ra) # 80002040 <thread_join>
    //idleAlive=0;

    thrCobj->join();
    delete thrCobj;
    800025a0:	00048a63          	beqz	s1,800025b4 <main+0x1f0>
    800025a4:	0004b783          	ld	a5,0(s1)
    800025a8:	0087b783          	ld	a5,8(a5)
    800025ac:	00048513          	mv	a0,s1
    800025b0:	000780e7          	jalr	a5
    __putc('E');
    800025b4:	04500513          	li	a0,69
    800025b8:	00002097          	auipc	ra,0x2
    800025bc:	224080e7          	jalr	548(ra) # 800047dc <__putc>
    while(1);
    800025c0:	0000006f          	j	800025c0 <main+0x1fc>
    800025c4:	00050913          	mv	s2,a0
    semTest=new Semaphore(0);
    800025c8:	00048513          	mv	a0,s1
    800025cc:	00000097          	auipc	ra,0x0
    800025d0:	dd0080e7          	jalr	-560(ra) # 8000239c <_ZdlPv>
    800025d4:	00090513          	mv	a0,s2
    800025d8:	00007097          	auipc	ra,0x7
    800025dc:	1a0080e7          	jalr	416(ra) # 80009778 <_Unwind_Resume>

00000000800025e0 <_ZN6ThreadD1Ev>:
        virtual ~Thread (){
    800025e0:	ff010113          	addi	sp,sp,-16
    800025e4:	00813423          	sd	s0,8(sp)
    800025e8:	01010413          	addi	s0,sp,16
        }
    800025ec:	00813403          	ld	s0,8(sp)
    800025f0:	01010113          	addi	sp,sp,16
    800025f4:	00008067          	ret

00000000800025f8 <_ZN6Thread3runEv>:
        virtual void run () {}
    800025f8:	ff010113          	addi	sp,sp,-16
    800025fc:	00813423          	sd	s0,8(sp)
    80002600:	01010413          	addi	s0,sp,16
    80002604:	00813403          	ld	s0,8(sp)
    80002608:	01010113          	addi	sp,sp,16
    8000260c:	00008067          	ret

0000000080002610 <_ZN9SemaphoreD1Ev>:
        virtual ~Semaphore (){
    80002610:	ff010113          	addi	sp,sp,-16
    80002614:	00113423          	sd	ra,8(sp)
    80002618:	00813023          	sd	s0,0(sp)
    8000261c:	01010413          	addi	s0,sp,16
    80002620:	00003797          	auipc	a5,0x3
    80002624:	fd078793          	addi	a5,a5,-48 # 800055f0 <_ZTV9Semaphore+0x10>
    80002628:	00f53023          	sd	a5,0(a0)
            sem_close(myHandle);
    8000262c:	00853503          	ld	a0,8(a0)
    80002630:	00000097          	auipc	ra,0x0
    80002634:	a78080e7          	jalr	-1416(ra) # 800020a8 <sem_close>
        }
    80002638:	00813083          	ld	ra,8(sp)
    8000263c:	00013403          	ld	s0,0(sp)
    80002640:	01010113          	addi	sp,sp,16
    80002644:	00008067          	ret

0000000080002648 <_ZN9SemaphoreD0Ev>:
        virtual ~Semaphore (){
    80002648:	fe010113          	addi	sp,sp,-32
    8000264c:	00113c23          	sd	ra,24(sp)
    80002650:	00813823          	sd	s0,16(sp)
    80002654:	00913423          	sd	s1,8(sp)
    80002658:	02010413          	addi	s0,sp,32
    8000265c:	00050493          	mv	s1,a0
    80002660:	00003797          	auipc	a5,0x3
    80002664:	f9078793          	addi	a5,a5,-112 # 800055f0 <_ZTV9Semaphore+0x10>
    80002668:	00f53023          	sd	a5,0(a0)
            sem_close(myHandle);
    8000266c:	00853503          	ld	a0,8(a0)
    80002670:	00000097          	auipc	ra,0x0
    80002674:	a38080e7          	jalr	-1480(ra) # 800020a8 <sem_close>
        }
    80002678:	00048513          	mv	a0,s1
    8000267c:	00000097          	auipc	ra,0x0
    80002680:	d20080e7          	jalr	-736(ra) # 8000239c <_ZdlPv>
    80002684:	01813083          	ld	ra,24(sp)
    80002688:	01013403          	ld	s0,16(sp)
    8000268c:	00813483          	ld	s1,8(sp)
    80002690:	02010113          	addi	sp,sp,32
    80002694:	00008067          	ret

0000000080002698 <_ZN6ThreadD0Ev>:
        virtual ~Thread (){
    80002698:	ff010113          	addi	sp,sp,-16
    8000269c:	00113423          	sd	ra,8(sp)
    800026a0:	00813023          	sd	s0,0(sp)
    800026a4:	01010413          	addi	s0,sp,16
        }
    800026a8:	00000097          	auipc	ra,0x0
    800026ac:	cf4080e7          	jalr	-780(ra) # 8000239c <_ZdlPv>
    800026b0:	00813083          	ld	ra,8(sp)
    800026b4:	00013403          	ld	s0,0(sp)
    800026b8:	01010113          	addi	sp,sp,16
    800026bc:	00008067          	ret

00000000800026c0 <_Z11printstringPKc>:
//

#include "../h/strings.h"

void printstring(const char* string)
{
    800026c0:	fe010113          	addi	sp,sp,-32
    800026c4:	00113c23          	sd	ra,24(sp)
    800026c8:	00813823          	sd	s0,16(sp)
    800026cc:	00913423          	sd	s1,8(sp)
    800026d0:	01213023          	sd	s2,0(sp)
    800026d4:	02010413          	addi	s0,sp,32
    800026d8:	00050913          	mv	s2,a0
    int i=0;
    800026dc:	00000493          	li	s1,0
    while (string[i]){
    800026e0:	009907b3          	add	a5,s2,s1
    800026e4:	0007c503          	lbu	a0,0(a5)
    800026e8:	00050a63          	beqz	a0,800026fc <_Z11printstringPKc+0x3c>
        __putc(string[i++]);
    800026ec:	0014849b          	addiw	s1,s1,1
    800026f0:	00002097          	auipc	ra,0x2
    800026f4:	0ec080e7          	jalr	236(ra) # 800047dc <__putc>
    while (string[i]){
    800026f8:	fe9ff06f          	j	800026e0 <_Z11printstringPKc+0x20>
    }
}
    800026fc:	01813083          	ld	ra,24(sp)
    80002700:	01013403          	ld	s0,16(sp)
    80002704:	00813483          	ld	s1,8(sp)
    80002708:	00013903          	ld	s2,0(sp)
    8000270c:	02010113          	addi	sp,sp,32
    80002710:	00008067          	ret

0000000080002714 <start>:
    80002714:	ff010113          	addi	sp,sp,-16
    80002718:	00813423          	sd	s0,8(sp)
    8000271c:	01010413          	addi	s0,sp,16
    80002720:	300027f3          	csrr	a5,mstatus
    80002724:	ffffe737          	lui	a4,0xffffe
    80002728:	7ff70713          	addi	a4,a4,2047 # ffffffffffffe7ff <end+0xffffffff7fff4eef>
    8000272c:	00e7f7b3          	and	a5,a5,a4
    80002730:	00001737          	lui	a4,0x1
    80002734:	80070713          	addi	a4,a4,-2048 # 800 <_entry-0x7ffff800>
    80002738:	00e7e7b3          	or	a5,a5,a4
    8000273c:	30079073          	csrw	mstatus,a5
    80002740:	00000797          	auipc	a5,0x0
    80002744:	16078793          	addi	a5,a5,352 # 800028a0 <system_main>
    80002748:	34179073          	csrw	mepc,a5
    8000274c:	00000793          	li	a5,0
    80002750:	18079073          	csrw	satp,a5
    80002754:	000107b7          	lui	a5,0x10
    80002758:	fff78793          	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    8000275c:	30279073          	csrw	medeleg,a5
    80002760:	30379073          	csrw	mideleg,a5
    80002764:	104027f3          	csrr	a5,sie
    80002768:	2227e793          	ori	a5,a5,546
    8000276c:	10479073          	csrw	sie,a5
    80002770:	fff00793          	li	a5,-1
    80002774:	00a7d793          	srli	a5,a5,0xa
    80002778:	3b079073          	csrw	pmpaddr0,a5
    8000277c:	00f00793          	li	a5,15
    80002780:	3a079073          	csrw	pmpcfg0,a5
    80002784:	f14027f3          	csrr	a5,mhartid
    80002788:	0200c737          	lui	a4,0x200c
    8000278c:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    80002790:	0007869b          	sext.w	a3,a5
    80002794:	00269713          	slli	a4,a3,0x2
    80002798:	000f4637          	lui	a2,0xf4
    8000279c:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    800027a0:	00d70733          	add	a4,a4,a3
    800027a4:	0037979b          	slliw	a5,a5,0x3
    800027a8:	020046b7          	lui	a3,0x2004
    800027ac:	00d787b3          	add	a5,a5,a3
    800027b0:	00c585b3          	add	a1,a1,a2
    800027b4:	00371693          	slli	a3,a4,0x3
    800027b8:	00006717          	auipc	a4,0x6
    800027bc:	ef870713          	addi	a4,a4,-264 # 800086b0 <timer_scratch>
    800027c0:	00b7b023          	sd	a1,0(a5)
    800027c4:	00d70733          	add	a4,a4,a3
    800027c8:	00f73c23          	sd	a5,24(a4)
    800027cc:	02c73023          	sd	a2,32(a4)
    800027d0:	34071073          	csrw	mscratch,a4
    800027d4:	00000797          	auipc	a5,0x0
    800027d8:	6ec78793          	addi	a5,a5,1772 # 80002ec0 <timervec>
    800027dc:	30579073          	csrw	mtvec,a5
    800027e0:	300027f3          	csrr	a5,mstatus
    800027e4:	0087e793          	ori	a5,a5,8
    800027e8:	30079073          	csrw	mstatus,a5
    800027ec:	304027f3          	csrr	a5,mie
    800027f0:	0807e793          	ori	a5,a5,128
    800027f4:	30479073          	csrw	mie,a5
    800027f8:	f14027f3          	csrr	a5,mhartid
    800027fc:	0007879b          	sext.w	a5,a5
    80002800:	00078213          	mv	tp,a5
    80002804:	30200073          	mret
    80002808:	00813403          	ld	s0,8(sp)
    8000280c:	01010113          	addi	sp,sp,16
    80002810:	00008067          	ret

0000000080002814 <timerinit>:
    80002814:	ff010113          	addi	sp,sp,-16
    80002818:	00813423          	sd	s0,8(sp)
    8000281c:	01010413          	addi	s0,sp,16
    80002820:	f14027f3          	csrr	a5,mhartid
    80002824:	0200c737          	lui	a4,0x200c
    80002828:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    8000282c:	0007869b          	sext.w	a3,a5
    80002830:	00269713          	slli	a4,a3,0x2
    80002834:	000f4637          	lui	a2,0xf4
    80002838:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    8000283c:	00d70733          	add	a4,a4,a3
    80002840:	0037979b          	slliw	a5,a5,0x3
    80002844:	020046b7          	lui	a3,0x2004
    80002848:	00d787b3          	add	a5,a5,a3
    8000284c:	00c585b3          	add	a1,a1,a2
    80002850:	00371693          	slli	a3,a4,0x3
    80002854:	00006717          	auipc	a4,0x6
    80002858:	e5c70713          	addi	a4,a4,-420 # 800086b0 <timer_scratch>
    8000285c:	00b7b023          	sd	a1,0(a5)
    80002860:	00d70733          	add	a4,a4,a3
    80002864:	00f73c23          	sd	a5,24(a4)
    80002868:	02c73023          	sd	a2,32(a4)
    8000286c:	34071073          	csrw	mscratch,a4
    80002870:	00000797          	auipc	a5,0x0
    80002874:	65078793          	addi	a5,a5,1616 # 80002ec0 <timervec>
    80002878:	30579073          	csrw	mtvec,a5
    8000287c:	300027f3          	csrr	a5,mstatus
    80002880:	0087e793          	ori	a5,a5,8
    80002884:	30079073          	csrw	mstatus,a5
    80002888:	304027f3          	csrr	a5,mie
    8000288c:	0807e793          	ori	a5,a5,128
    80002890:	30479073          	csrw	mie,a5
    80002894:	00813403          	ld	s0,8(sp)
    80002898:	01010113          	addi	sp,sp,16
    8000289c:	00008067          	ret

00000000800028a0 <system_main>:
    800028a0:	fe010113          	addi	sp,sp,-32
    800028a4:	00813823          	sd	s0,16(sp)
    800028a8:	00913423          	sd	s1,8(sp)
    800028ac:	00113c23          	sd	ra,24(sp)
    800028b0:	02010413          	addi	s0,sp,32
    800028b4:	00000097          	auipc	ra,0x0
    800028b8:	0c4080e7          	jalr	196(ra) # 80002978 <cpuid>
    800028bc:	00003497          	auipc	s1,0x3
    800028c0:	db048493          	addi	s1,s1,-592 # 8000566c <started>
    800028c4:	02050263          	beqz	a0,800028e8 <system_main+0x48>
    800028c8:	0004a783          	lw	a5,0(s1)
    800028cc:	0007879b          	sext.w	a5,a5
    800028d0:	fe078ce3          	beqz	a5,800028c8 <system_main+0x28>
    800028d4:	0ff0000f          	fence
    800028d8:	00003517          	auipc	a0,0x3
    800028dc:	84050513          	addi	a0,a0,-1984 # 80005118 <CONSOLE_STATUS+0x100>
    800028e0:	00001097          	auipc	ra,0x1
    800028e4:	a7c080e7          	jalr	-1412(ra) # 8000335c <panic>
    800028e8:	00001097          	auipc	ra,0x1
    800028ec:	9d0080e7          	jalr	-1584(ra) # 800032b8 <consoleinit>
    800028f0:	00001097          	auipc	ra,0x1
    800028f4:	15c080e7          	jalr	348(ra) # 80003a4c <printfinit>
    800028f8:	00003517          	auipc	a0,0x3
    800028fc:	90050513          	addi	a0,a0,-1792 # 800051f8 <CONSOLE_STATUS+0x1e0>
    80002900:	00001097          	auipc	ra,0x1
    80002904:	ab8080e7          	jalr	-1352(ra) # 800033b8 <__printf>
    80002908:	00002517          	auipc	a0,0x2
    8000290c:	7e050513          	addi	a0,a0,2016 # 800050e8 <CONSOLE_STATUS+0xd0>
    80002910:	00001097          	auipc	ra,0x1
    80002914:	aa8080e7          	jalr	-1368(ra) # 800033b8 <__printf>
    80002918:	00003517          	auipc	a0,0x3
    8000291c:	8e050513          	addi	a0,a0,-1824 # 800051f8 <CONSOLE_STATUS+0x1e0>
    80002920:	00001097          	auipc	ra,0x1
    80002924:	a98080e7          	jalr	-1384(ra) # 800033b8 <__printf>
    80002928:	00001097          	auipc	ra,0x1
    8000292c:	4b0080e7          	jalr	1200(ra) # 80003dd8 <kinit>
    80002930:	00000097          	auipc	ra,0x0
    80002934:	148080e7          	jalr	328(ra) # 80002a78 <trapinit>
    80002938:	00000097          	auipc	ra,0x0
    8000293c:	16c080e7          	jalr	364(ra) # 80002aa4 <trapinithart>
    80002940:	00000097          	auipc	ra,0x0
    80002944:	5c0080e7          	jalr	1472(ra) # 80002f00 <plicinit>
    80002948:	00000097          	auipc	ra,0x0
    8000294c:	5e0080e7          	jalr	1504(ra) # 80002f28 <plicinithart>
    80002950:	00000097          	auipc	ra,0x0
    80002954:	078080e7          	jalr	120(ra) # 800029c8 <userinit>
    80002958:	0ff0000f          	fence
    8000295c:	00100793          	li	a5,1
    80002960:	00002517          	auipc	a0,0x2
    80002964:	7a050513          	addi	a0,a0,1952 # 80005100 <CONSOLE_STATUS+0xe8>
    80002968:	00f4a023          	sw	a5,0(s1)
    8000296c:	00001097          	auipc	ra,0x1
    80002970:	a4c080e7          	jalr	-1460(ra) # 800033b8 <__printf>
    80002974:	0000006f          	j	80002974 <system_main+0xd4>

0000000080002978 <cpuid>:
    80002978:	ff010113          	addi	sp,sp,-16
    8000297c:	00813423          	sd	s0,8(sp)
    80002980:	01010413          	addi	s0,sp,16
    80002984:	00020513          	mv	a0,tp
    80002988:	00813403          	ld	s0,8(sp)
    8000298c:	0005051b          	sext.w	a0,a0
    80002990:	01010113          	addi	sp,sp,16
    80002994:	00008067          	ret

0000000080002998 <mycpu>:
    80002998:	ff010113          	addi	sp,sp,-16
    8000299c:	00813423          	sd	s0,8(sp)
    800029a0:	01010413          	addi	s0,sp,16
    800029a4:	00020793          	mv	a5,tp
    800029a8:	00813403          	ld	s0,8(sp)
    800029ac:	0007879b          	sext.w	a5,a5
    800029b0:	00779793          	slli	a5,a5,0x7
    800029b4:	00007517          	auipc	a0,0x7
    800029b8:	d2c50513          	addi	a0,a0,-724 # 800096e0 <cpus>
    800029bc:	00f50533          	add	a0,a0,a5
    800029c0:	01010113          	addi	sp,sp,16
    800029c4:	00008067          	ret

00000000800029c8 <userinit>:
    800029c8:	ff010113          	addi	sp,sp,-16
    800029cc:	00813423          	sd	s0,8(sp)
    800029d0:	01010413          	addi	s0,sp,16
    800029d4:	00813403          	ld	s0,8(sp)
    800029d8:	01010113          	addi	sp,sp,16
    800029dc:	00000317          	auipc	t1,0x0
    800029e0:	9e830067          	jr	-1560(t1) # 800023c4 <main>

00000000800029e4 <either_copyout>:
    800029e4:	ff010113          	addi	sp,sp,-16
    800029e8:	00813023          	sd	s0,0(sp)
    800029ec:	00113423          	sd	ra,8(sp)
    800029f0:	01010413          	addi	s0,sp,16
    800029f4:	02051663          	bnez	a0,80002a20 <either_copyout+0x3c>
    800029f8:	00058513          	mv	a0,a1
    800029fc:	00060593          	mv	a1,a2
    80002a00:	0006861b          	sext.w	a2,a3
    80002a04:	00002097          	auipc	ra,0x2
    80002a08:	c60080e7          	jalr	-928(ra) # 80004664 <__memmove>
    80002a0c:	00813083          	ld	ra,8(sp)
    80002a10:	00013403          	ld	s0,0(sp)
    80002a14:	00000513          	li	a0,0
    80002a18:	01010113          	addi	sp,sp,16
    80002a1c:	00008067          	ret
    80002a20:	00002517          	auipc	a0,0x2
    80002a24:	72050513          	addi	a0,a0,1824 # 80005140 <CONSOLE_STATUS+0x128>
    80002a28:	00001097          	auipc	ra,0x1
    80002a2c:	934080e7          	jalr	-1740(ra) # 8000335c <panic>

0000000080002a30 <either_copyin>:
    80002a30:	ff010113          	addi	sp,sp,-16
    80002a34:	00813023          	sd	s0,0(sp)
    80002a38:	00113423          	sd	ra,8(sp)
    80002a3c:	01010413          	addi	s0,sp,16
    80002a40:	02059463          	bnez	a1,80002a68 <either_copyin+0x38>
    80002a44:	00060593          	mv	a1,a2
    80002a48:	0006861b          	sext.w	a2,a3
    80002a4c:	00002097          	auipc	ra,0x2
    80002a50:	c18080e7          	jalr	-1000(ra) # 80004664 <__memmove>
    80002a54:	00813083          	ld	ra,8(sp)
    80002a58:	00013403          	ld	s0,0(sp)
    80002a5c:	00000513          	li	a0,0
    80002a60:	01010113          	addi	sp,sp,16
    80002a64:	00008067          	ret
    80002a68:	00002517          	auipc	a0,0x2
    80002a6c:	70050513          	addi	a0,a0,1792 # 80005168 <CONSOLE_STATUS+0x150>
    80002a70:	00001097          	auipc	ra,0x1
    80002a74:	8ec080e7          	jalr	-1812(ra) # 8000335c <panic>

0000000080002a78 <trapinit>:
    80002a78:	ff010113          	addi	sp,sp,-16
    80002a7c:	00813423          	sd	s0,8(sp)
    80002a80:	01010413          	addi	s0,sp,16
    80002a84:	00813403          	ld	s0,8(sp)
    80002a88:	00002597          	auipc	a1,0x2
    80002a8c:	70858593          	addi	a1,a1,1800 # 80005190 <CONSOLE_STATUS+0x178>
    80002a90:	00007517          	auipc	a0,0x7
    80002a94:	cd050513          	addi	a0,a0,-816 # 80009760 <tickslock>
    80002a98:	01010113          	addi	sp,sp,16
    80002a9c:	00001317          	auipc	t1,0x1
    80002aa0:	5cc30067          	jr	1484(t1) # 80004068 <initlock>

0000000080002aa4 <trapinithart>:
    80002aa4:	ff010113          	addi	sp,sp,-16
    80002aa8:	00813423          	sd	s0,8(sp)
    80002aac:	01010413          	addi	s0,sp,16
    80002ab0:	00000797          	auipc	a5,0x0
    80002ab4:	30078793          	addi	a5,a5,768 # 80002db0 <kernelvec>
    80002ab8:	10579073          	csrw	stvec,a5
    80002abc:	00813403          	ld	s0,8(sp)
    80002ac0:	01010113          	addi	sp,sp,16
    80002ac4:	00008067          	ret

0000000080002ac8 <usertrap>:
    80002ac8:	ff010113          	addi	sp,sp,-16
    80002acc:	00813423          	sd	s0,8(sp)
    80002ad0:	01010413          	addi	s0,sp,16
    80002ad4:	00813403          	ld	s0,8(sp)
    80002ad8:	01010113          	addi	sp,sp,16
    80002adc:	00008067          	ret

0000000080002ae0 <usertrapret>:
    80002ae0:	ff010113          	addi	sp,sp,-16
    80002ae4:	00813423          	sd	s0,8(sp)
    80002ae8:	01010413          	addi	s0,sp,16
    80002aec:	00813403          	ld	s0,8(sp)
    80002af0:	01010113          	addi	sp,sp,16
    80002af4:	00008067          	ret

0000000080002af8 <kerneltrap>:
    80002af8:	fe010113          	addi	sp,sp,-32
    80002afc:	00813823          	sd	s0,16(sp)
    80002b00:	00113c23          	sd	ra,24(sp)
    80002b04:	00913423          	sd	s1,8(sp)
    80002b08:	02010413          	addi	s0,sp,32
    80002b0c:	142025f3          	csrr	a1,scause
    80002b10:	100027f3          	csrr	a5,sstatus
    80002b14:	0027f793          	andi	a5,a5,2
    80002b18:	10079c63          	bnez	a5,80002c30 <kerneltrap+0x138>
    80002b1c:	142027f3          	csrr	a5,scause
    80002b20:	0207ce63          	bltz	a5,80002b5c <kerneltrap+0x64>
    80002b24:	00002517          	auipc	a0,0x2
    80002b28:	6b450513          	addi	a0,a0,1716 # 800051d8 <CONSOLE_STATUS+0x1c0>
    80002b2c:	00001097          	auipc	ra,0x1
    80002b30:	88c080e7          	jalr	-1908(ra) # 800033b8 <__printf>
    80002b34:	141025f3          	csrr	a1,sepc
    80002b38:	14302673          	csrr	a2,stval
    80002b3c:	00002517          	auipc	a0,0x2
    80002b40:	6ac50513          	addi	a0,a0,1708 # 800051e8 <CONSOLE_STATUS+0x1d0>
    80002b44:	00001097          	auipc	ra,0x1
    80002b48:	874080e7          	jalr	-1932(ra) # 800033b8 <__printf>
    80002b4c:	00002517          	auipc	a0,0x2
    80002b50:	6b450513          	addi	a0,a0,1716 # 80005200 <CONSOLE_STATUS+0x1e8>
    80002b54:	00001097          	auipc	ra,0x1
    80002b58:	808080e7          	jalr	-2040(ra) # 8000335c <panic>
    80002b5c:	0ff7f713          	andi	a4,a5,255
    80002b60:	00900693          	li	a3,9
    80002b64:	04d70063          	beq	a4,a3,80002ba4 <kerneltrap+0xac>
    80002b68:	fff00713          	li	a4,-1
    80002b6c:	03f71713          	slli	a4,a4,0x3f
    80002b70:	00170713          	addi	a4,a4,1
    80002b74:	fae798e3          	bne	a5,a4,80002b24 <kerneltrap+0x2c>
    80002b78:	00000097          	auipc	ra,0x0
    80002b7c:	e00080e7          	jalr	-512(ra) # 80002978 <cpuid>
    80002b80:	06050663          	beqz	a0,80002bec <kerneltrap+0xf4>
    80002b84:	144027f3          	csrr	a5,sip
    80002b88:	ffd7f793          	andi	a5,a5,-3
    80002b8c:	14479073          	csrw	sip,a5
    80002b90:	01813083          	ld	ra,24(sp)
    80002b94:	01013403          	ld	s0,16(sp)
    80002b98:	00813483          	ld	s1,8(sp)
    80002b9c:	02010113          	addi	sp,sp,32
    80002ba0:	00008067          	ret
    80002ba4:	00000097          	auipc	ra,0x0
    80002ba8:	3d0080e7          	jalr	976(ra) # 80002f74 <plic_claim>
    80002bac:	00a00793          	li	a5,10
    80002bb0:	00050493          	mv	s1,a0
    80002bb4:	06f50863          	beq	a0,a5,80002c24 <kerneltrap+0x12c>
    80002bb8:	fc050ce3          	beqz	a0,80002b90 <kerneltrap+0x98>
    80002bbc:	00050593          	mv	a1,a0
    80002bc0:	00002517          	auipc	a0,0x2
    80002bc4:	5f850513          	addi	a0,a0,1528 # 800051b8 <CONSOLE_STATUS+0x1a0>
    80002bc8:	00000097          	auipc	ra,0x0
    80002bcc:	7f0080e7          	jalr	2032(ra) # 800033b8 <__printf>
    80002bd0:	01013403          	ld	s0,16(sp)
    80002bd4:	01813083          	ld	ra,24(sp)
    80002bd8:	00048513          	mv	a0,s1
    80002bdc:	00813483          	ld	s1,8(sp)
    80002be0:	02010113          	addi	sp,sp,32
    80002be4:	00000317          	auipc	t1,0x0
    80002be8:	3c830067          	jr	968(t1) # 80002fac <plic_complete>
    80002bec:	00007517          	auipc	a0,0x7
    80002bf0:	b7450513          	addi	a0,a0,-1164 # 80009760 <tickslock>
    80002bf4:	00001097          	auipc	ra,0x1
    80002bf8:	498080e7          	jalr	1176(ra) # 8000408c <acquire>
    80002bfc:	00003717          	auipc	a4,0x3
    80002c00:	a7470713          	addi	a4,a4,-1420 # 80005670 <ticks>
    80002c04:	00072783          	lw	a5,0(a4)
    80002c08:	00007517          	auipc	a0,0x7
    80002c0c:	b5850513          	addi	a0,a0,-1192 # 80009760 <tickslock>
    80002c10:	0017879b          	addiw	a5,a5,1
    80002c14:	00f72023          	sw	a5,0(a4)
    80002c18:	00001097          	auipc	ra,0x1
    80002c1c:	540080e7          	jalr	1344(ra) # 80004158 <release>
    80002c20:	f65ff06f          	j	80002b84 <kerneltrap+0x8c>
    80002c24:	00001097          	auipc	ra,0x1
    80002c28:	09c080e7          	jalr	156(ra) # 80003cc0 <uartintr>
    80002c2c:	fa5ff06f          	j	80002bd0 <kerneltrap+0xd8>
    80002c30:	00002517          	auipc	a0,0x2
    80002c34:	56850513          	addi	a0,a0,1384 # 80005198 <CONSOLE_STATUS+0x180>
    80002c38:	00000097          	auipc	ra,0x0
    80002c3c:	724080e7          	jalr	1828(ra) # 8000335c <panic>

0000000080002c40 <clockintr>:
    80002c40:	fe010113          	addi	sp,sp,-32
    80002c44:	00813823          	sd	s0,16(sp)
    80002c48:	00913423          	sd	s1,8(sp)
    80002c4c:	00113c23          	sd	ra,24(sp)
    80002c50:	02010413          	addi	s0,sp,32
    80002c54:	00007497          	auipc	s1,0x7
    80002c58:	b0c48493          	addi	s1,s1,-1268 # 80009760 <tickslock>
    80002c5c:	00048513          	mv	a0,s1
    80002c60:	00001097          	auipc	ra,0x1
    80002c64:	42c080e7          	jalr	1068(ra) # 8000408c <acquire>
    80002c68:	00003717          	auipc	a4,0x3
    80002c6c:	a0870713          	addi	a4,a4,-1528 # 80005670 <ticks>
    80002c70:	00072783          	lw	a5,0(a4)
    80002c74:	01013403          	ld	s0,16(sp)
    80002c78:	01813083          	ld	ra,24(sp)
    80002c7c:	00048513          	mv	a0,s1
    80002c80:	0017879b          	addiw	a5,a5,1
    80002c84:	00813483          	ld	s1,8(sp)
    80002c88:	00f72023          	sw	a5,0(a4)
    80002c8c:	02010113          	addi	sp,sp,32
    80002c90:	00001317          	auipc	t1,0x1
    80002c94:	4c830067          	jr	1224(t1) # 80004158 <release>

0000000080002c98 <devintr>:
    80002c98:	142027f3          	csrr	a5,scause
    80002c9c:	00000513          	li	a0,0
    80002ca0:	0007c463          	bltz	a5,80002ca8 <devintr+0x10>
    80002ca4:	00008067          	ret
    80002ca8:	fe010113          	addi	sp,sp,-32
    80002cac:	00813823          	sd	s0,16(sp)
    80002cb0:	00113c23          	sd	ra,24(sp)
    80002cb4:	00913423          	sd	s1,8(sp)
    80002cb8:	02010413          	addi	s0,sp,32
    80002cbc:	0ff7f713          	andi	a4,a5,255
    80002cc0:	00900693          	li	a3,9
    80002cc4:	04d70c63          	beq	a4,a3,80002d1c <devintr+0x84>
    80002cc8:	fff00713          	li	a4,-1
    80002ccc:	03f71713          	slli	a4,a4,0x3f
    80002cd0:	00170713          	addi	a4,a4,1
    80002cd4:	00e78c63          	beq	a5,a4,80002cec <devintr+0x54>
    80002cd8:	01813083          	ld	ra,24(sp)
    80002cdc:	01013403          	ld	s0,16(sp)
    80002ce0:	00813483          	ld	s1,8(sp)
    80002ce4:	02010113          	addi	sp,sp,32
    80002ce8:	00008067          	ret
    80002cec:	00000097          	auipc	ra,0x0
    80002cf0:	c8c080e7          	jalr	-884(ra) # 80002978 <cpuid>
    80002cf4:	06050663          	beqz	a0,80002d60 <devintr+0xc8>
    80002cf8:	144027f3          	csrr	a5,sip
    80002cfc:	ffd7f793          	andi	a5,a5,-3
    80002d00:	14479073          	csrw	sip,a5
    80002d04:	01813083          	ld	ra,24(sp)
    80002d08:	01013403          	ld	s0,16(sp)
    80002d0c:	00813483          	ld	s1,8(sp)
    80002d10:	00200513          	li	a0,2
    80002d14:	02010113          	addi	sp,sp,32
    80002d18:	00008067          	ret
    80002d1c:	00000097          	auipc	ra,0x0
    80002d20:	258080e7          	jalr	600(ra) # 80002f74 <plic_claim>
    80002d24:	00a00793          	li	a5,10
    80002d28:	00050493          	mv	s1,a0
    80002d2c:	06f50663          	beq	a0,a5,80002d98 <devintr+0x100>
    80002d30:	00100513          	li	a0,1
    80002d34:	fa0482e3          	beqz	s1,80002cd8 <devintr+0x40>
    80002d38:	00048593          	mv	a1,s1
    80002d3c:	00002517          	auipc	a0,0x2
    80002d40:	47c50513          	addi	a0,a0,1148 # 800051b8 <CONSOLE_STATUS+0x1a0>
    80002d44:	00000097          	auipc	ra,0x0
    80002d48:	674080e7          	jalr	1652(ra) # 800033b8 <__printf>
    80002d4c:	00048513          	mv	a0,s1
    80002d50:	00000097          	auipc	ra,0x0
    80002d54:	25c080e7          	jalr	604(ra) # 80002fac <plic_complete>
    80002d58:	00100513          	li	a0,1
    80002d5c:	f7dff06f          	j	80002cd8 <devintr+0x40>
    80002d60:	00007517          	auipc	a0,0x7
    80002d64:	a0050513          	addi	a0,a0,-1536 # 80009760 <tickslock>
    80002d68:	00001097          	auipc	ra,0x1
    80002d6c:	324080e7          	jalr	804(ra) # 8000408c <acquire>
    80002d70:	00003717          	auipc	a4,0x3
    80002d74:	90070713          	addi	a4,a4,-1792 # 80005670 <ticks>
    80002d78:	00072783          	lw	a5,0(a4)
    80002d7c:	00007517          	auipc	a0,0x7
    80002d80:	9e450513          	addi	a0,a0,-1564 # 80009760 <tickslock>
    80002d84:	0017879b          	addiw	a5,a5,1
    80002d88:	00f72023          	sw	a5,0(a4)
    80002d8c:	00001097          	auipc	ra,0x1
    80002d90:	3cc080e7          	jalr	972(ra) # 80004158 <release>
    80002d94:	f65ff06f          	j	80002cf8 <devintr+0x60>
    80002d98:	00001097          	auipc	ra,0x1
    80002d9c:	f28080e7          	jalr	-216(ra) # 80003cc0 <uartintr>
    80002da0:	fadff06f          	j	80002d4c <devintr+0xb4>
	...

0000000080002db0 <kernelvec>:
    80002db0:	f0010113          	addi	sp,sp,-256
    80002db4:	00113023          	sd	ra,0(sp)
    80002db8:	00213423          	sd	sp,8(sp)
    80002dbc:	00313823          	sd	gp,16(sp)
    80002dc0:	00413c23          	sd	tp,24(sp)
    80002dc4:	02513023          	sd	t0,32(sp)
    80002dc8:	02613423          	sd	t1,40(sp)
    80002dcc:	02713823          	sd	t2,48(sp)
    80002dd0:	02813c23          	sd	s0,56(sp)
    80002dd4:	04913023          	sd	s1,64(sp)
    80002dd8:	04a13423          	sd	a0,72(sp)
    80002ddc:	04b13823          	sd	a1,80(sp)
    80002de0:	04c13c23          	sd	a2,88(sp)
    80002de4:	06d13023          	sd	a3,96(sp)
    80002de8:	06e13423          	sd	a4,104(sp)
    80002dec:	06f13823          	sd	a5,112(sp)
    80002df0:	07013c23          	sd	a6,120(sp)
    80002df4:	09113023          	sd	a7,128(sp)
    80002df8:	09213423          	sd	s2,136(sp)
    80002dfc:	09313823          	sd	s3,144(sp)
    80002e00:	09413c23          	sd	s4,152(sp)
    80002e04:	0b513023          	sd	s5,160(sp)
    80002e08:	0b613423          	sd	s6,168(sp)
    80002e0c:	0b713823          	sd	s7,176(sp)
    80002e10:	0b813c23          	sd	s8,184(sp)
    80002e14:	0d913023          	sd	s9,192(sp)
    80002e18:	0da13423          	sd	s10,200(sp)
    80002e1c:	0db13823          	sd	s11,208(sp)
    80002e20:	0dc13c23          	sd	t3,216(sp)
    80002e24:	0fd13023          	sd	t4,224(sp)
    80002e28:	0fe13423          	sd	t5,232(sp)
    80002e2c:	0ff13823          	sd	t6,240(sp)
    80002e30:	cc9ff0ef          	jal	ra,80002af8 <kerneltrap>
    80002e34:	00013083          	ld	ra,0(sp)
    80002e38:	00813103          	ld	sp,8(sp)
    80002e3c:	01013183          	ld	gp,16(sp)
    80002e40:	02013283          	ld	t0,32(sp)
    80002e44:	02813303          	ld	t1,40(sp)
    80002e48:	03013383          	ld	t2,48(sp)
    80002e4c:	03813403          	ld	s0,56(sp)
    80002e50:	04013483          	ld	s1,64(sp)
    80002e54:	04813503          	ld	a0,72(sp)
    80002e58:	05013583          	ld	a1,80(sp)
    80002e5c:	05813603          	ld	a2,88(sp)
    80002e60:	06013683          	ld	a3,96(sp)
    80002e64:	06813703          	ld	a4,104(sp)
    80002e68:	07013783          	ld	a5,112(sp)
    80002e6c:	07813803          	ld	a6,120(sp)
    80002e70:	08013883          	ld	a7,128(sp)
    80002e74:	08813903          	ld	s2,136(sp)
    80002e78:	09013983          	ld	s3,144(sp)
    80002e7c:	09813a03          	ld	s4,152(sp)
    80002e80:	0a013a83          	ld	s5,160(sp)
    80002e84:	0a813b03          	ld	s6,168(sp)
    80002e88:	0b013b83          	ld	s7,176(sp)
    80002e8c:	0b813c03          	ld	s8,184(sp)
    80002e90:	0c013c83          	ld	s9,192(sp)
    80002e94:	0c813d03          	ld	s10,200(sp)
    80002e98:	0d013d83          	ld	s11,208(sp)
    80002e9c:	0d813e03          	ld	t3,216(sp)
    80002ea0:	0e013e83          	ld	t4,224(sp)
    80002ea4:	0e813f03          	ld	t5,232(sp)
    80002ea8:	0f013f83          	ld	t6,240(sp)
    80002eac:	10010113          	addi	sp,sp,256
    80002eb0:	10200073          	sret
    80002eb4:	00000013          	nop
    80002eb8:	00000013          	nop
    80002ebc:	00000013          	nop

0000000080002ec0 <timervec>:
    80002ec0:	34051573          	csrrw	a0,mscratch,a0
    80002ec4:	00b53023          	sd	a1,0(a0)
    80002ec8:	00c53423          	sd	a2,8(a0)
    80002ecc:	00d53823          	sd	a3,16(a0)
    80002ed0:	01853583          	ld	a1,24(a0)
    80002ed4:	02053603          	ld	a2,32(a0)
    80002ed8:	0005b683          	ld	a3,0(a1)
    80002edc:	00c686b3          	add	a3,a3,a2
    80002ee0:	00d5b023          	sd	a3,0(a1)
    80002ee4:	00200593          	li	a1,2
    80002ee8:	14459073          	csrw	sip,a1
    80002eec:	01053683          	ld	a3,16(a0)
    80002ef0:	00853603          	ld	a2,8(a0)
    80002ef4:	00053583          	ld	a1,0(a0)
    80002ef8:	34051573          	csrrw	a0,mscratch,a0
    80002efc:	30200073          	mret

0000000080002f00 <plicinit>:
    80002f00:	ff010113          	addi	sp,sp,-16
    80002f04:	00813423          	sd	s0,8(sp)
    80002f08:	01010413          	addi	s0,sp,16
    80002f0c:	00813403          	ld	s0,8(sp)
    80002f10:	0c0007b7          	lui	a5,0xc000
    80002f14:	00100713          	li	a4,1
    80002f18:	02e7a423          	sw	a4,40(a5) # c000028 <_entry-0x73ffffd8>
    80002f1c:	00e7a223          	sw	a4,4(a5)
    80002f20:	01010113          	addi	sp,sp,16
    80002f24:	00008067          	ret

0000000080002f28 <plicinithart>:
    80002f28:	ff010113          	addi	sp,sp,-16
    80002f2c:	00813023          	sd	s0,0(sp)
    80002f30:	00113423          	sd	ra,8(sp)
    80002f34:	01010413          	addi	s0,sp,16
    80002f38:	00000097          	auipc	ra,0x0
    80002f3c:	a40080e7          	jalr	-1472(ra) # 80002978 <cpuid>
    80002f40:	0085171b          	slliw	a4,a0,0x8
    80002f44:	0c0027b7          	lui	a5,0xc002
    80002f48:	00e787b3          	add	a5,a5,a4
    80002f4c:	40200713          	li	a4,1026
    80002f50:	08e7a023          	sw	a4,128(a5) # c002080 <_entry-0x73ffdf80>
    80002f54:	00813083          	ld	ra,8(sp)
    80002f58:	00013403          	ld	s0,0(sp)
    80002f5c:	00d5151b          	slliw	a0,a0,0xd
    80002f60:	0c2017b7          	lui	a5,0xc201
    80002f64:	00a78533          	add	a0,a5,a0
    80002f68:	00052023          	sw	zero,0(a0)
    80002f6c:	01010113          	addi	sp,sp,16
    80002f70:	00008067          	ret

0000000080002f74 <plic_claim>:
    80002f74:	ff010113          	addi	sp,sp,-16
    80002f78:	00813023          	sd	s0,0(sp)
    80002f7c:	00113423          	sd	ra,8(sp)
    80002f80:	01010413          	addi	s0,sp,16
    80002f84:	00000097          	auipc	ra,0x0
    80002f88:	9f4080e7          	jalr	-1548(ra) # 80002978 <cpuid>
    80002f8c:	00813083          	ld	ra,8(sp)
    80002f90:	00013403          	ld	s0,0(sp)
    80002f94:	00d5151b          	slliw	a0,a0,0xd
    80002f98:	0c2017b7          	lui	a5,0xc201
    80002f9c:	00a78533          	add	a0,a5,a0
    80002fa0:	00452503          	lw	a0,4(a0)
    80002fa4:	01010113          	addi	sp,sp,16
    80002fa8:	00008067          	ret

0000000080002fac <plic_complete>:
    80002fac:	fe010113          	addi	sp,sp,-32
    80002fb0:	00813823          	sd	s0,16(sp)
    80002fb4:	00913423          	sd	s1,8(sp)
    80002fb8:	00113c23          	sd	ra,24(sp)
    80002fbc:	02010413          	addi	s0,sp,32
    80002fc0:	00050493          	mv	s1,a0
    80002fc4:	00000097          	auipc	ra,0x0
    80002fc8:	9b4080e7          	jalr	-1612(ra) # 80002978 <cpuid>
    80002fcc:	01813083          	ld	ra,24(sp)
    80002fd0:	01013403          	ld	s0,16(sp)
    80002fd4:	00d5179b          	slliw	a5,a0,0xd
    80002fd8:	0c201737          	lui	a4,0xc201
    80002fdc:	00f707b3          	add	a5,a4,a5
    80002fe0:	0097a223          	sw	s1,4(a5) # c201004 <_entry-0x73dfeffc>
    80002fe4:	00813483          	ld	s1,8(sp)
    80002fe8:	02010113          	addi	sp,sp,32
    80002fec:	00008067          	ret

0000000080002ff0 <consolewrite>:
    80002ff0:	fb010113          	addi	sp,sp,-80
    80002ff4:	04813023          	sd	s0,64(sp)
    80002ff8:	04113423          	sd	ra,72(sp)
    80002ffc:	02913c23          	sd	s1,56(sp)
    80003000:	03213823          	sd	s2,48(sp)
    80003004:	03313423          	sd	s3,40(sp)
    80003008:	03413023          	sd	s4,32(sp)
    8000300c:	01513c23          	sd	s5,24(sp)
    80003010:	05010413          	addi	s0,sp,80
    80003014:	06c05c63          	blez	a2,8000308c <consolewrite+0x9c>
    80003018:	00060993          	mv	s3,a2
    8000301c:	00050a13          	mv	s4,a0
    80003020:	00058493          	mv	s1,a1
    80003024:	00000913          	li	s2,0
    80003028:	fff00a93          	li	s5,-1
    8000302c:	01c0006f          	j	80003048 <consolewrite+0x58>
    80003030:	fbf44503          	lbu	a0,-65(s0)
    80003034:	0019091b          	addiw	s2,s2,1
    80003038:	00148493          	addi	s1,s1,1
    8000303c:	00001097          	auipc	ra,0x1
    80003040:	a9c080e7          	jalr	-1380(ra) # 80003ad8 <uartputc>
    80003044:	03298063          	beq	s3,s2,80003064 <consolewrite+0x74>
    80003048:	00048613          	mv	a2,s1
    8000304c:	00100693          	li	a3,1
    80003050:	000a0593          	mv	a1,s4
    80003054:	fbf40513          	addi	a0,s0,-65
    80003058:	00000097          	auipc	ra,0x0
    8000305c:	9d8080e7          	jalr	-1576(ra) # 80002a30 <either_copyin>
    80003060:	fd5518e3          	bne	a0,s5,80003030 <consolewrite+0x40>
    80003064:	04813083          	ld	ra,72(sp)
    80003068:	04013403          	ld	s0,64(sp)
    8000306c:	03813483          	ld	s1,56(sp)
    80003070:	02813983          	ld	s3,40(sp)
    80003074:	02013a03          	ld	s4,32(sp)
    80003078:	01813a83          	ld	s5,24(sp)
    8000307c:	00090513          	mv	a0,s2
    80003080:	03013903          	ld	s2,48(sp)
    80003084:	05010113          	addi	sp,sp,80
    80003088:	00008067          	ret
    8000308c:	00000913          	li	s2,0
    80003090:	fd5ff06f          	j	80003064 <consolewrite+0x74>

0000000080003094 <consoleread>:
    80003094:	f9010113          	addi	sp,sp,-112
    80003098:	06813023          	sd	s0,96(sp)
    8000309c:	04913c23          	sd	s1,88(sp)
    800030a0:	05213823          	sd	s2,80(sp)
    800030a4:	05313423          	sd	s3,72(sp)
    800030a8:	05413023          	sd	s4,64(sp)
    800030ac:	03513c23          	sd	s5,56(sp)
    800030b0:	03613823          	sd	s6,48(sp)
    800030b4:	03713423          	sd	s7,40(sp)
    800030b8:	03813023          	sd	s8,32(sp)
    800030bc:	06113423          	sd	ra,104(sp)
    800030c0:	01913c23          	sd	s9,24(sp)
    800030c4:	07010413          	addi	s0,sp,112
    800030c8:	00060b93          	mv	s7,a2
    800030cc:	00050913          	mv	s2,a0
    800030d0:	00058c13          	mv	s8,a1
    800030d4:	00060b1b          	sext.w	s6,a2
    800030d8:	00006497          	auipc	s1,0x6
    800030dc:	6b048493          	addi	s1,s1,1712 # 80009788 <cons>
    800030e0:	00400993          	li	s3,4
    800030e4:	fff00a13          	li	s4,-1
    800030e8:	00a00a93          	li	s5,10
    800030ec:	05705e63          	blez	s7,80003148 <consoleread+0xb4>
    800030f0:	09c4a703          	lw	a4,156(s1)
    800030f4:	0984a783          	lw	a5,152(s1)
    800030f8:	0007071b          	sext.w	a4,a4
    800030fc:	08e78463          	beq	a5,a4,80003184 <consoleread+0xf0>
    80003100:	07f7f713          	andi	a4,a5,127
    80003104:	00e48733          	add	a4,s1,a4
    80003108:	01874703          	lbu	a4,24(a4) # c201018 <_entry-0x73dfefe8>
    8000310c:	0017869b          	addiw	a3,a5,1
    80003110:	08d4ac23          	sw	a3,152(s1)
    80003114:	00070c9b          	sext.w	s9,a4
    80003118:	0b370663          	beq	a4,s3,800031c4 <consoleread+0x130>
    8000311c:	00100693          	li	a3,1
    80003120:	f9f40613          	addi	a2,s0,-97
    80003124:	000c0593          	mv	a1,s8
    80003128:	00090513          	mv	a0,s2
    8000312c:	f8e40fa3          	sb	a4,-97(s0)
    80003130:	00000097          	auipc	ra,0x0
    80003134:	8b4080e7          	jalr	-1868(ra) # 800029e4 <either_copyout>
    80003138:	01450863          	beq	a0,s4,80003148 <consoleread+0xb4>
    8000313c:	001c0c13          	addi	s8,s8,1
    80003140:	fffb8b9b          	addiw	s7,s7,-1
    80003144:	fb5c94e3          	bne	s9,s5,800030ec <consoleread+0x58>
    80003148:	000b851b          	sext.w	a0,s7
    8000314c:	06813083          	ld	ra,104(sp)
    80003150:	06013403          	ld	s0,96(sp)
    80003154:	05813483          	ld	s1,88(sp)
    80003158:	05013903          	ld	s2,80(sp)
    8000315c:	04813983          	ld	s3,72(sp)
    80003160:	04013a03          	ld	s4,64(sp)
    80003164:	03813a83          	ld	s5,56(sp)
    80003168:	02813b83          	ld	s7,40(sp)
    8000316c:	02013c03          	ld	s8,32(sp)
    80003170:	01813c83          	ld	s9,24(sp)
    80003174:	40ab053b          	subw	a0,s6,a0
    80003178:	03013b03          	ld	s6,48(sp)
    8000317c:	07010113          	addi	sp,sp,112
    80003180:	00008067          	ret
    80003184:	00001097          	auipc	ra,0x1
    80003188:	1d8080e7          	jalr	472(ra) # 8000435c <push_on>
    8000318c:	0984a703          	lw	a4,152(s1)
    80003190:	09c4a783          	lw	a5,156(s1)
    80003194:	0007879b          	sext.w	a5,a5
    80003198:	fef70ce3          	beq	a4,a5,80003190 <consoleread+0xfc>
    8000319c:	00001097          	auipc	ra,0x1
    800031a0:	234080e7          	jalr	564(ra) # 800043d0 <pop_on>
    800031a4:	0984a783          	lw	a5,152(s1)
    800031a8:	07f7f713          	andi	a4,a5,127
    800031ac:	00e48733          	add	a4,s1,a4
    800031b0:	01874703          	lbu	a4,24(a4)
    800031b4:	0017869b          	addiw	a3,a5,1
    800031b8:	08d4ac23          	sw	a3,152(s1)
    800031bc:	00070c9b          	sext.w	s9,a4
    800031c0:	f5371ee3          	bne	a4,s3,8000311c <consoleread+0x88>
    800031c4:	000b851b          	sext.w	a0,s7
    800031c8:	f96bf2e3          	bgeu	s7,s6,8000314c <consoleread+0xb8>
    800031cc:	08f4ac23          	sw	a5,152(s1)
    800031d0:	f7dff06f          	j	8000314c <consoleread+0xb8>

00000000800031d4 <consputc>:
    800031d4:	10000793          	li	a5,256
    800031d8:	00f50663          	beq	a0,a5,800031e4 <consputc+0x10>
    800031dc:	00001317          	auipc	t1,0x1
    800031e0:	9f430067          	jr	-1548(t1) # 80003bd0 <uartputc_sync>
    800031e4:	ff010113          	addi	sp,sp,-16
    800031e8:	00113423          	sd	ra,8(sp)
    800031ec:	00813023          	sd	s0,0(sp)
    800031f0:	01010413          	addi	s0,sp,16
    800031f4:	00800513          	li	a0,8
    800031f8:	00001097          	auipc	ra,0x1
    800031fc:	9d8080e7          	jalr	-1576(ra) # 80003bd0 <uartputc_sync>
    80003200:	02000513          	li	a0,32
    80003204:	00001097          	auipc	ra,0x1
    80003208:	9cc080e7          	jalr	-1588(ra) # 80003bd0 <uartputc_sync>
    8000320c:	00013403          	ld	s0,0(sp)
    80003210:	00813083          	ld	ra,8(sp)
    80003214:	00800513          	li	a0,8
    80003218:	01010113          	addi	sp,sp,16
    8000321c:	00001317          	auipc	t1,0x1
    80003220:	9b430067          	jr	-1612(t1) # 80003bd0 <uartputc_sync>

0000000080003224 <consoleintr>:
    80003224:	fe010113          	addi	sp,sp,-32
    80003228:	00813823          	sd	s0,16(sp)
    8000322c:	00913423          	sd	s1,8(sp)
    80003230:	01213023          	sd	s2,0(sp)
    80003234:	00113c23          	sd	ra,24(sp)
    80003238:	02010413          	addi	s0,sp,32
    8000323c:	00006917          	auipc	s2,0x6
    80003240:	54c90913          	addi	s2,s2,1356 # 80009788 <cons>
    80003244:	00050493          	mv	s1,a0
    80003248:	00090513          	mv	a0,s2
    8000324c:	00001097          	auipc	ra,0x1
    80003250:	e40080e7          	jalr	-448(ra) # 8000408c <acquire>
    80003254:	02048c63          	beqz	s1,8000328c <consoleintr+0x68>
    80003258:	0a092783          	lw	a5,160(s2)
    8000325c:	09892703          	lw	a4,152(s2)
    80003260:	07f00693          	li	a3,127
    80003264:	40e7873b          	subw	a4,a5,a4
    80003268:	02e6e263          	bltu	a3,a4,8000328c <consoleintr+0x68>
    8000326c:	00d00713          	li	a4,13
    80003270:	04e48063          	beq	s1,a4,800032b0 <consoleintr+0x8c>
    80003274:	07f7f713          	andi	a4,a5,127
    80003278:	00e90733          	add	a4,s2,a4
    8000327c:	0017879b          	addiw	a5,a5,1
    80003280:	0af92023          	sw	a5,160(s2)
    80003284:	00970c23          	sb	s1,24(a4)
    80003288:	08f92e23          	sw	a5,156(s2)
    8000328c:	01013403          	ld	s0,16(sp)
    80003290:	01813083          	ld	ra,24(sp)
    80003294:	00813483          	ld	s1,8(sp)
    80003298:	00013903          	ld	s2,0(sp)
    8000329c:	00006517          	auipc	a0,0x6
    800032a0:	4ec50513          	addi	a0,a0,1260 # 80009788 <cons>
    800032a4:	02010113          	addi	sp,sp,32
    800032a8:	00001317          	auipc	t1,0x1
    800032ac:	eb030067          	jr	-336(t1) # 80004158 <release>
    800032b0:	00a00493          	li	s1,10
    800032b4:	fc1ff06f          	j	80003274 <consoleintr+0x50>

00000000800032b8 <consoleinit>:
    800032b8:	fe010113          	addi	sp,sp,-32
    800032bc:	00113c23          	sd	ra,24(sp)
    800032c0:	00813823          	sd	s0,16(sp)
    800032c4:	00913423          	sd	s1,8(sp)
    800032c8:	02010413          	addi	s0,sp,32
    800032cc:	00006497          	auipc	s1,0x6
    800032d0:	4bc48493          	addi	s1,s1,1212 # 80009788 <cons>
    800032d4:	00048513          	mv	a0,s1
    800032d8:	00002597          	auipc	a1,0x2
    800032dc:	f3858593          	addi	a1,a1,-200 # 80005210 <CONSOLE_STATUS+0x1f8>
    800032e0:	00001097          	auipc	ra,0x1
    800032e4:	d88080e7          	jalr	-632(ra) # 80004068 <initlock>
    800032e8:	00000097          	auipc	ra,0x0
    800032ec:	7ac080e7          	jalr	1964(ra) # 80003a94 <uartinit>
    800032f0:	01813083          	ld	ra,24(sp)
    800032f4:	01013403          	ld	s0,16(sp)
    800032f8:	00000797          	auipc	a5,0x0
    800032fc:	d9c78793          	addi	a5,a5,-612 # 80003094 <consoleread>
    80003300:	0af4bc23          	sd	a5,184(s1)
    80003304:	00000797          	auipc	a5,0x0
    80003308:	cec78793          	addi	a5,a5,-788 # 80002ff0 <consolewrite>
    8000330c:	0cf4b023          	sd	a5,192(s1)
    80003310:	00813483          	ld	s1,8(sp)
    80003314:	02010113          	addi	sp,sp,32
    80003318:	00008067          	ret

000000008000331c <console_read>:
    8000331c:	ff010113          	addi	sp,sp,-16
    80003320:	00813423          	sd	s0,8(sp)
    80003324:	01010413          	addi	s0,sp,16
    80003328:	00813403          	ld	s0,8(sp)
    8000332c:	00006317          	auipc	t1,0x6
    80003330:	51433303          	ld	t1,1300(t1) # 80009840 <devsw+0x10>
    80003334:	01010113          	addi	sp,sp,16
    80003338:	00030067          	jr	t1

000000008000333c <console_write>:
    8000333c:	ff010113          	addi	sp,sp,-16
    80003340:	00813423          	sd	s0,8(sp)
    80003344:	01010413          	addi	s0,sp,16
    80003348:	00813403          	ld	s0,8(sp)
    8000334c:	00006317          	auipc	t1,0x6
    80003350:	4fc33303          	ld	t1,1276(t1) # 80009848 <devsw+0x18>
    80003354:	01010113          	addi	sp,sp,16
    80003358:	00030067          	jr	t1

000000008000335c <panic>:
    8000335c:	fe010113          	addi	sp,sp,-32
    80003360:	00113c23          	sd	ra,24(sp)
    80003364:	00813823          	sd	s0,16(sp)
    80003368:	00913423          	sd	s1,8(sp)
    8000336c:	02010413          	addi	s0,sp,32
    80003370:	00050493          	mv	s1,a0
    80003374:	00002517          	auipc	a0,0x2
    80003378:	ea450513          	addi	a0,a0,-348 # 80005218 <CONSOLE_STATUS+0x200>
    8000337c:	00006797          	auipc	a5,0x6
    80003380:	5607a623          	sw	zero,1388(a5) # 800098e8 <pr+0x18>
    80003384:	00000097          	auipc	ra,0x0
    80003388:	034080e7          	jalr	52(ra) # 800033b8 <__printf>
    8000338c:	00048513          	mv	a0,s1
    80003390:	00000097          	auipc	ra,0x0
    80003394:	028080e7          	jalr	40(ra) # 800033b8 <__printf>
    80003398:	00002517          	auipc	a0,0x2
    8000339c:	e6050513          	addi	a0,a0,-416 # 800051f8 <CONSOLE_STATUS+0x1e0>
    800033a0:	00000097          	auipc	ra,0x0
    800033a4:	018080e7          	jalr	24(ra) # 800033b8 <__printf>
    800033a8:	00100793          	li	a5,1
    800033ac:	00002717          	auipc	a4,0x2
    800033b0:	2cf72423          	sw	a5,712(a4) # 80005674 <panicked>
    800033b4:	0000006f          	j	800033b4 <panic+0x58>

00000000800033b8 <__printf>:
    800033b8:	f3010113          	addi	sp,sp,-208
    800033bc:	08813023          	sd	s0,128(sp)
    800033c0:	07313423          	sd	s3,104(sp)
    800033c4:	09010413          	addi	s0,sp,144
    800033c8:	05813023          	sd	s8,64(sp)
    800033cc:	08113423          	sd	ra,136(sp)
    800033d0:	06913c23          	sd	s1,120(sp)
    800033d4:	07213823          	sd	s2,112(sp)
    800033d8:	07413023          	sd	s4,96(sp)
    800033dc:	05513c23          	sd	s5,88(sp)
    800033e0:	05613823          	sd	s6,80(sp)
    800033e4:	05713423          	sd	s7,72(sp)
    800033e8:	03913c23          	sd	s9,56(sp)
    800033ec:	03a13823          	sd	s10,48(sp)
    800033f0:	03b13423          	sd	s11,40(sp)
    800033f4:	00006317          	auipc	t1,0x6
    800033f8:	4dc30313          	addi	t1,t1,1244 # 800098d0 <pr>
    800033fc:	01832c03          	lw	s8,24(t1)
    80003400:	00b43423          	sd	a1,8(s0)
    80003404:	00c43823          	sd	a2,16(s0)
    80003408:	00d43c23          	sd	a3,24(s0)
    8000340c:	02e43023          	sd	a4,32(s0)
    80003410:	02f43423          	sd	a5,40(s0)
    80003414:	03043823          	sd	a6,48(s0)
    80003418:	03143c23          	sd	a7,56(s0)
    8000341c:	00050993          	mv	s3,a0
    80003420:	4a0c1663          	bnez	s8,800038cc <__printf+0x514>
    80003424:	60098c63          	beqz	s3,80003a3c <__printf+0x684>
    80003428:	0009c503          	lbu	a0,0(s3)
    8000342c:	00840793          	addi	a5,s0,8
    80003430:	f6f43c23          	sd	a5,-136(s0)
    80003434:	00000493          	li	s1,0
    80003438:	22050063          	beqz	a0,80003658 <__printf+0x2a0>
    8000343c:	00002a37          	lui	s4,0x2
    80003440:	00018ab7          	lui	s5,0x18
    80003444:	000f4b37          	lui	s6,0xf4
    80003448:	00989bb7          	lui	s7,0x989
    8000344c:	70fa0a13          	addi	s4,s4,1807 # 270f <_entry-0x7fffd8f1>
    80003450:	69fa8a93          	addi	s5,s5,1695 # 1869f <_entry-0x7ffe7961>
    80003454:	23fb0b13          	addi	s6,s6,575 # f423f <_entry-0x7ff0bdc1>
    80003458:	67fb8b93          	addi	s7,s7,1663 # 98967f <_entry-0x7f676981>
    8000345c:	00148c9b          	addiw	s9,s1,1
    80003460:	02500793          	li	a5,37
    80003464:	01998933          	add	s2,s3,s9
    80003468:	38f51263          	bne	a0,a5,800037ec <__printf+0x434>
    8000346c:	00094783          	lbu	a5,0(s2)
    80003470:	00078c9b          	sext.w	s9,a5
    80003474:	1e078263          	beqz	a5,80003658 <__printf+0x2a0>
    80003478:	0024849b          	addiw	s1,s1,2
    8000347c:	07000713          	li	a4,112
    80003480:	00998933          	add	s2,s3,s1
    80003484:	38e78a63          	beq	a5,a4,80003818 <__printf+0x460>
    80003488:	20f76863          	bltu	a4,a5,80003698 <__printf+0x2e0>
    8000348c:	42a78863          	beq	a5,a0,800038bc <__printf+0x504>
    80003490:	06400713          	li	a4,100
    80003494:	40e79663          	bne	a5,a4,800038a0 <__printf+0x4e8>
    80003498:	f7843783          	ld	a5,-136(s0)
    8000349c:	0007a603          	lw	a2,0(a5)
    800034a0:	00878793          	addi	a5,a5,8
    800034a4:	f6f43c23          	sd	a5,-136(s0)
    800034a8:	42064a63          	bltz	a2,800038dc <__printf+0x524>
    800034ac:	00a00713          	li	a4,10
    800034b0:	02e677bb          	remuw	a5,a2,a4
    800034b4:	00002d97          	auipc	s11,0x2
    800034b8:	d8cd8d93          	addi	s11,s11,-628 # 80005240 <digits>
    800034bc:	00900593          	li	a1,9
    800034c0:	0006051b          	sext.w	a0,a2
    800034c4:	00000c93          	li	s9,0
    800034c8:	02079793          	slli	a5,a5,0x20
    800034cc:	0207d793          	srli	a5,a5,0x20
    800034d0:	00fd87b3          	add	a5,s11,a5
    800034d4:	0007c783          	lbu	a5,0(a5)
    800034d8:	02e656bb          	divuw	a3,a2,a4
    800034dc:	f8f40023          	sb	a5,-128(s0)
    800034e0:	14c5d863          	bge	a1,a2,80003630 <__printf+0x278>
    800034e4:	06300593          	li	a1,99
    800034e8:	00100c93          	li	s9,1
    800034ec:	02e6f7bb          	remuw	a5,a3,a4
    800034f0:	02079793          	slli	a5,a5,0x20
    800034f4:	0207d793          	srli	a5,a5,0x20
    800034f8:	00fd87b3          	add	a5,s11,a5
    800034fc:	0007c783          	lbu	a5,0(a5)
    80003500:	02e6d73b          	divuw	a4,a3,a4
    80003504:	f8f400a3          	sb	a5,-127(s0)
    80003508:	12a5f463          	bgeu	a1,a0,80003630 <__printf+0x278>
    8000350c:	00a00693          	li	a3,10
    80003510:	00900593          	li	a1,9
    80003514:	02d777bb          	remuw	a5,a4,a3
    80003518:	02079793          	slli	a5,a5,0x20
    8000351c:	0207d793          	srli	a5,a5,0x20
    80003520:	00fd87b3          	add	a5,s11,a5
    80003524:	0007c503          	lbu	a0,0(a5)
    80003528:	02d757bb          	divuw	a5,a4,a3
    8000352c:	f8a40123          	sb	a0,-126(s0)
    80003530:	48e5f263          	bgeu	a1,a4,800039b4 <__printf+0x5fc>
    80003534:	06300513          	li	a0,99
    80003538:	02d7f5bb          	remuw	a1,a5,a3
    8000353c:	02059593          	slli	a1,a1,0x20
    80003540:	0205d593          	srli	a1,a1,0x20
    80003544:	00bd85b3          	add	a1,s11,a1
    80003548:	0005c583          	lbu	a1,0(a1)
    8000354c:	02d7d7bb          	divuw	a5,a5,a3
    80003550:	f8b401a3          	sb	a1,-125(s0)
    80003554:	48e57263          	bgeu	a0,a4,800039d8 <__printf+0x620>
    80003558:	3e700513          	li	a0,999
    8000355c:	02d7f5bb          	remuw	a1,a5,a3
    80003560:	02059593          	slli	a1,a1,0x20
    80003564:	0205d593          	srli	a1,a1,0x20
    80003568:	00bd85b3          	add	a1,s11,a1
    8000356c:	0005c583          	lbu	a1,0(a1)
    80003570:	02d7d7bb          	divuw	a5,a5,a3
    80003574:	f8b40223          	sb	a1,-124(s0)
    80003578:	46e57663          	bgeu	a0,a4,800039e4 <__printf+0x62c>
    8000357c:	02d7f5bb          	remuw	a1,a5,a3
    80003580:	02059593          	slli	a1,a1,0x20
    80003584:	0205d593          	srli	a1,a1,0x20
    80003588:	00bd85b3          	add	a1,s11,a1
    8000358c:	0005c583          	lbu	a1,0(a1)
    80003590:	02d7d7bb          	divuw	a5,a5,a3
    80003594:	f8b402a3          	sb	a1,-123(s0)
    80003598:	46ea7863          	bgeu	s4,a4,80003a08 <__printf+0x650>
    8000359c:	02d7f5bb          	remuw	a1,a5,a3
    800035a0:	02059593          	slli	a1,a1,0x20
    800035a4:	0205d593          	srli	a1,a1,0x20
    800035a8:	00bd85b3          	add	a1,s11,a1
    800035ac:	0005c583          	lbu	a1,0(a1)
    800035b0:	02d7d7bb          	divuw	a5,a5,a3
    800035b4:	f8b40323          	sb	a1,-122(s0)
    800035b8:	3eeaf863          	bgeu	s5,a4,800039a8 <__printf+0x5f0>
    800035bc:	02d7f5bb          	remuw	a1,a5,a3
    800035c0:	02059593          	slli	a1,a1,0x20
    800035c4:	0205d593          	srli	a1,a1,0x20
    800035c8:	00bd85b3          	add	a1,s11,a1
    800035cc:	0005c583          	lbu	a1,0(a1)
    800035d0:	02d7d7bb          	divuw	a5,a5,a3
    800035d4:	f8b403a3          	sb	a1,-121(s0)
    800035d8:	42eb7e63          	bgeu	s6,a4,80003a14 <__printf+0x65c>
    800035dc:	02d7f5bb          	remuw	a1,a5,a3
    800035e0:	02059593          	slli	a1,a1,0x20
    800035e4:	0205d593          	srli	a1,a1,0x20
    800035e8:	00bd85b3          	add	a1,s11,a1
    800035ec:	0005c583          	lbu	a1,0(a1)
    800035f0:	02d7d7bb          	divuw	a5,a5,a3
    800035f4:	f8b40423          	sb	a1,-120(s0)
    800035f8:	42ebfc63          	bgeu	s7,a4,80003a30 <__printf+0x678>
    800035fc:	02079793          	slli	a5,a5,0x20
    80003600:	0207d793          	srli	a5,a5,0x20
    80003604:	00fd8db3          	add	s11,s11,a5
    80003608:	000dc703          	lbu	a4,0(s11)
    8000360c:	00a00793          	li	a5,10
    80003610:	00900c93          	li	s9,9
    80003614:	f8e404a3          	sb	a4,-119(s0)
    80003618:	00065c63          	bgez	a2,80003630 <__printf+0x278>
    8000361c:	f9040713          	addi	a4,s0,-112
    80003620:	00f70733          	add	a4,a4,a5
    80003624:	02d00693          	li	a3,45
    80003628:	fed70823          	sb	a3,-16(a4)
    8000362c:	00078c93          	mv	s9,a5
    80003630:	f8040793          	addi	a5,s0,-128
    80003634:	01978cb3          	add	s9,a5,s9
    80003638:	f7f40d13          	addi	s10,s0,-129
    8000363c:	000cc503          	lbu	a0,0(s9)
    80003640:	fffc8c93          	addi	s9,s9,-1
    80003644:	00000097          	auipc	ra,0x0
    80003648:	b90080e7          	jalr	-1136(ra) # 800031d4 <consputc>
    8000364c:	ffac98e3          	bne	s9,s10,8000363c <__printf+0x284>
    80003650:	00094503          	lbu	a0,0(s2)
    80003654:	e00514e3          	bnez	a0,8000345c <__printf+0xa4>
    80003658:	1a0c1663          	bnez	s8,80003804 <__printf+0x44c>
    8000365c:	08813083          	ld	ra,136(sp)
    80003660:	08013403          	ld	s0,128(sp)
    80003664:	07813483          	ld	s1,120(sp)
    80003668:	07013903          	ld	s2,112(sp)
    8000366c:	06813983          	ld	s3,104(sp)
    80003670:	06013a03          	ld	s4,96(sp)
    80003674:	05813a83          	ld	s5,88(sp)
    80003678:	05013b03          	ld	s6,80(sp)
    8000367c:	04813b83          	ld	s7,72(sp)
    80003680:	04013c03          	ld	s8,64(sp)
    80003684:	03813c83          	ld	s9,56(sp)
    80003688:	03013d03          	ld	s10,48(sp)
    8000368c:	02813d83          	ld	s11,40(sp)
    80003690:	0d010113          	addi	sp,sp,208
    80003694:	00008067          	ret
    80003698:	07300713          	li	a4,115
    8000369c:	1ce78a63          	beq	a5,a4,80003870 <__printf+0x4b8>
    800036a0:	07800713          	li	a4,120
    800036a4:	1ee79e63          	bne	a5,a4,800038a0 <__printf+0x4e8>
    800036a8:	f7843783          	ld	a5,-136(s0)
    800036ac:	0007a703          	lw	a4,0(a5)
    800036b0:	00878793          	addi	a5,a5,8
    800036b4:	f6f43c23          	sd	a5,-136(s0)
    800036b8:	28074263          	bltz	a4,8000393c <__printf+0x584>
    800036bc:	00002d97          	auipc	s11,0x2
    800036c0:	b84d8d93          	addi	s11,s11,-1148 # 80005240 <digits>
    800036c4:	00f77793          	andi	a5,a4,15
    800036c8:	00fd87b3          	add	a5,s11,a5
    800036cc:	0007c683          	lbu	a3,0(a5)
    800036d0:	00f00613          	li	a2,15
    800036d4:	0007079b          	sext.w	a5,a4
    800036d8:	f8d40023          	sb	a3,-128(s0)
    800036dc:	0047559b          	srliw	a1,a4,0x4
    800036e0:	0047569b          	srliw	a3,a4,0x4
    800036e4:	00000c93          	li	s9,0
    800036e8:	0ee65063          	bge	a2,a4,800037c8 <__printf+0x410>
    800036ec:	00f6f693          	andi	a3,a3,15
    800036f0:	00dd86b3          	add	a3,s11,a3
    800036f4:	0006c683          	lbu	a3,0(a3) # 2004000 <_entry-0x7dffc000>
    800036f8:	0087d79b          	srliw	a5,a5,0x8
    800036fc:	00100c93          	li	s9,1
    80003700:	f8d400a3          	sb	a3,-127(s0)
    80003704:	0cb67263          	bgeu	a2,a1,800037c8 <__printf+0x410>
    80003708:	00f7f693          	andi	a3,a5,15
    8000370c:	00dd86b3          	add	a3,s11,a3
    80003710:	0006c583          	lbu	a1,0(a3)
    80003714:	00f00613          	li	a2,15
    80003718:	0047d69b          	srliw	a3,a5,0x4
    8000371c:	f8b40123          	sb	a1,-126(s0)
    80003720:	0047d593          	srli	a1,a5,0x4
    80003724:	28f67e63          	bgeu	a2,a5,800039c0 <__printf+0x608>
    80003728:	00f6f693          	andi	a3,a3,15
    8000372c:	00dd86b3          	add	a3,s11,a3
    80003730:	0006c503          	lbu	a0,0(a3)
    80003734:	0087d813          	srli	a6,a5,0x8
    80003738:	0087d69b          	srliw	a3,a5,0x8
    8000373c:	f8a401a3          	sb	a0,-125(s0)
    80003740:	28b67663          	bgeu	a2,a1,800039cc <__printf+0x614>
    80003744:	00f6f693          	andi	a3,a3,15
    80003748:	00dd86b3          	add	a3,s11,a3
    8000374c:	0006c583          	lbu	a1,0(a3)
    80003750:	00c7d513          	srli	a0,a5,0xc
    80003754:	00c7d69b          	srliw	a3,a5,0xc
    80003758:	f8b40223          	sb	a1,-124(s0)
    8000375c:	29067a63          	bgeu	a2,a6,800039f0 <__printf+0x638>
    80003760:	00f6f693          	andi	a3,a3,15
    80003764:	00dd86b3          	add	a3,s11,a3
    80003768:	0006c583          	lbu	a1,0(a3)
    8000376c:	0107d813          	srli	a6,a5,0x10
    80003770:	0107d69b          	srliw	a3,a5,0x10
    80003774:	f8b402a3          	sb	a1,-123(s0)
    80003778:	28a67263          	bgeu	a2,a0,800039fc <__printf+0x644>
    8000377c:	00f6f693          	andi	a3,a3,15
    80003780:	00dd86b3          	add	a3,s11,a3
    80003784:	0006c683          	lbu	a3,0(a3)
    80003788:	0147d79b          	srliw	a5,a5,0x14
    8000378c:	f8d40323          	sb	a3,-122(s0)
    80003790:	21067663          	bgeu	a2,a6,8000399c <__printf+0x5e4>
    80003794:	02079793          	slli	a5,a5,0x20
    80003798:	0207d793          	srli	a5,a5,0x20
    8000379c:	00fd8db3          	add	s11,s11,a5
    800037a0:	000dc683          	lbu	a3,0(s11)
    800037a4:	00800793          	li	a5,8
    800037a8:	00700c93          	li	s9,7
    800037ac:	f8d403a3          	sb	a3,-121(s0)
    800037b0:	00075c63          	bgez	a4,800037c8 <__printf+0x410>
    800037b4:	f9040713          	addi	a4,s0,-112
    800037b8:	00f70733          	add	a4,a4,a5
    800037bc:	02d00693          	li	a3,45
    800037c0:	fed70823          	sb	a3,-16(a4)
    800037c4:	00078c93          	mv	s9,a5
    800037c8:	f8040793          	addi	a5,s0,-128
    800037cc:	01978cb3          	add	s9,a5,s9
    800037d0:	f7f40d13          	addi	s10,s0,-129
    800037d4:	000cc503          	lbu	a0,0(s9)
    800037d8:	fffc8c93          	addi	s9,s9,-1
    800037dc:	00000097          	auipc	ra,0x0
    800037e0:	9f8080e7          	jalr	-1544(ra) # 800031d4 <consputc>
    800037e4:	ff9d18e3          	bne	s10,s9,800037d4 <__printf+0x41c>
    800037e8:	0100006f          	j	800037f8 <__printf+0x440>
    800037ec:	00000097          	auipc	ra,0x0
    800037f0:	9e8080e7          	jalr	-1560(ra) # 800031d4 <consputc>
    800037f4:	000c8493          	mv	s1,s9
    800037f8:	00094503          	lbu	a0,0(s2)
    800037fc:	c60510e3          	bnez	a0,8000345c <__printf+0xa4>
    80003800:	e40c0ee3          	beqz	s8,8000365c <__printf+0x2a4>
    80003804:	00006517          	auipc	a0,0x6
    80003808:	0cc50513          	addi	a0,a0,204 # 800098d0 <pr>
    8000380c:	00001097          	auipc	ra,0x1
    80003810:	94c080e7          	jalr	-1716(ra) # 80004158 <release>
    80003814:	e49ff06f          	j	8000365c <__printf+0x2a4>
    80003818:	f7843783          	ld	a5,-136(s0)
    8000381c:	03000513          	li	a0,48
    80003820:	01000d13          	li	s10,16
    80003824:	00878713          	addi	a4,a5,8
    80003828:	0007bc83          	ld	s9,0(a5)
    8000382c:	f6e43c23          	sd	a4,-136(s0)
    80003830:	00000097          	auipc	ra,0x0
    80003834:	9a4080e7          	jalr	-1628(ra) # 800031d4 <consputc>
    80003838:	07800513          	li	a0,120
    8000383c:	00000097          	auipc	ra,0x0
    80003840:	998080e7          	jalr	-1640(ra) # 800031d4 <consputc>
    80003844:	00002d97          	auipc	s11,0x2
    80003848:	9fcd8d93          	addi	s11,s11,-1540 # 80005240 <digits>
    8000384c:	03ccd793          	srli	a5,s9,0x3c
    80003850:	00fd87b3          	add	a5,s11,a5
    80003854:	0007c503          	lbu	a0,0(a5)
    80003858:	fffd0d1b          	addiw	s10,s10,-1
    8000385c:	004c9c93          	slli	s9,s9,0x4
    80003860:	00000097          	auipc	ra,0x0
    80003864:	974080e7          	jalr	-1676(ra) # 800031d4 <consputc>
    80003868:	fe0d12e3          	bnez	s10,8000384c <__printf+0x494>
    8000386c:	f8dff06f          	j	800037f8 <__printf+0x440>
    80003870:	f7843783          	ld	a5,-136(s0)
    80003874:	0007bc83          	ld	s9,0(a5)
    80003878:	00878793          	addi	a5,a5,8
    8000387c:	f6f43c23          	sd	a5,-136(s0)
    80003880:	000c9a63          	bnez	s9,80003894 <__printf+0x4dc>
    80003884:	1080006f          	j	8000398c <__printf+0x5d4>
    80003888:	001c8c93          	addi	s9,s9,1
    8000388c:	00000097          	auipc	ra,0x0
    80003890:	948080e7          	jalr	-1720(ra) # 800031d4 <consputc>
    80003894:	000cc503          	lbu	a0,0(s9)
    80003898:	fe0518e3          	bnez	a0,80003888 <__printf+0x4d0>
    8000389c:	f5dff06f          	j	800037f8 <__printf+0x440>
    800038a0:	02500513          	li	a0,37
    800038a4:	00000097          	auipc	ra,0x0
    800038a8:	930080e7          	jalr	-1744(ra) # 800031d4 <consputc>
    800038ac:	000c8513          	mv	a0,s9
    800038b0:	00000097          	auipc	ra,0x0
    800038b4:	924080e7          	jalr	-1756(ra) # 800031d4 <consputc>
    800038b8:	f41ff06f          	j	800037f8 <__printf+0x440>
    800038bc:	02500513          	li	a0,37
    800038c0:	00000097          	auipc	ra,0x0
    800038c4:	914080e7          	jalr	-1772(ra) # 800031d4 <consputc>
    800038c8:	f31ff06f          	j	800037f8 <__printf+0x440>
    800038cc:	00030513          	mv	a0,t1
    800038d0:	00000097          	auipc	ra,0x0
    800038d4:	7bc080e7          	jalr	1980(ra) # 8000408c <acquire>
    800038d8:	b4dff06f          	j	80003424 <__printf+0x6c>
    800038dc:	40c0053b          	negw	a0,a2
    800038e0:	00a00713          	li	a4,10
    800038e4:	02e576bb          	remuw	a3,a0,a4
    800038e8:	00002d97          	auipc	s11,0x2
    800038ec:	958d8d93          	addi	s11,s11,-1704 # 80005240 <digits>
    800038f0:	ff700593          	li	a1,-9
    800038f4:	02069693          	slli	a3,a3,0x20
    800038f8:	0206d693          	srli	a3,a3,0x20
    800038fc:	00dd86b3          	add	a3,s11,a3
    80003900:	0006c683          	lbu	a3,0(a3)
    80003904:	02e557bb          	divuw	a5,a0,a4
    80003908:	f8d40023          	sb	a3,-128(s0)
    8000390c:	10b65e63          	bge	a2,a1,80003a28 <__printf+0x670>
    80003910:	06300593          	li	a1,99
    80003914:	02e7f6bb          	remuw	a3,a5,a4
    80003918:	02069693          	slli	a3,a3,0x20
    8000391c:	0206d693          	srli	a3,a3,0x20
    80003920:	00dd86b3          	add	a3,s11,a3
    80003924:	0006c683          	lbu	a3,0(a3)
    80003928:	02e7d73b          	divuw	a4,a5,a4
    8000392c:	00200793          	li	a5,2
    80003930:	f8d400a3          	sb	a3,-127(s0)
    80003934:	bca5ece3          	bltu	a1,a0,8000350c <__printf+0x154>
    80003938:	ce5ff06f          	j	8000361c <__printf+0x264>
    8000393c:	40e007bb          	negw	a5,a4
    80003940:	00002d97          	auipc	s11,0x2
    80003944:	900d8d93          	addi	s11,s11,-1792 # 80005240 <digits>
    80003948:	00f7f693          	andi	a3,a5,15
    8000394c:	00dd86b3          	add	a3,s11,a3
    80003950:	0006c583          	lbu	a1,0(a3)
    80003954:	ff100613          	li	a2,-15
    80003958:	0047d69b          	srliw	a3,a5,0x4
    8000395c:	f8b40023          	sb	a1,-128(s0)
    80003960:	0047d59b          	srliw	a1,a5,0x4
    80003964:	0ac75e63          	bge	a4,a2,80003a20 <__printf+0x668>
    80003968:	00f6f693          	andi	a3,a3,15
    8000396c:	00dd86b3          	add	a3,s11,a3
    80003970:	0006c603          	lbu	a2,0(a3)
    80003974:	00f00693          	li	a3,15
    80003978:	0087d79b          	srliw	a5,a5,0x8
    8000397c:	f8c400a3          	sb	a2,-127(s0)
    80003980:	d8b6e4e3          	bltu	a3,a1,80003708 <__printf+0x350>
    80003984:	00200793          	li	a5,2
    80003988:	e2dff06f          	j	800037b4 <__printf+0x3fc>
    8000398c:	00002c97          	auipc	s9,0x2
    80003990:	894c8c93          	addi	s9,s9,-1900 # 80005220 <CONSOLE_STATUS+0x208>
    80003994:	02800513          	li	a0,40
    80003998:	ef1ff06f          	j	80003888 <__printf+0x4d0>
    8000399c:	00700793          	li	a5,7
    800039a0:	00600c93          	li	s9,6
    800039a4:	e0dff06f          	j	800037b0 <__printf+0x3f8>
    800039a8:	00700793          	li	a5,7
    800039ac:	00600c93          	li	s9,6
    800039b0:	c69ff06f          	j	80003618 <__printf+0x260>
    800039b4:	00300793          	li	a5,3
    800039b8:	00200c93          	li	s9,2
    800039bc:	c5dff06f          	j	80003618 <__printf+0x260>
    800039c0:	00300793          	li	a5,3
    800039c4:	00200c93          	li	s9,2
    800039c8:	de9ff06f          	j	800037b0 <__printf+0x3f8>
    800039cc:	00400793          	li	a5,4
    800039d0:	00300c93          	li	s9,3
    800039d4:	dddff06f          	j	800037b0 <__printf+0x3f8>
    800039d8:	00400793          	li	a5,4
    800039dc:	00300c93          	li	s9,3
    800039e0:	c39ff06f          	j	80003618 <__printf+0x260>
    800039e4:	00500793          	li	a5,5
    800039e8:	00400c93          	li	s9,4
    800039ec:	c2dff06f          	j	80003618 <__printf+0x260>
    800039f0:	00500793          	li	a5,5
    800039f4:	00400c93          	li	s9,4
    800039f8:	db9ff06f          	j	800037b0 <__printf+0x3f8>
    800039fc:	00600793          	li	a5,6
    80003a00:	00500c93          	li	s9,5
    80003a04:	dadff06f          	j	800037b0 <__printf+0x3f8>
    80003a08:	00600793          	li	a5,6
    80003a0c:	00500c93          	li	s9,5
    80003a10:	c09ff06f          	j	80003618 <__printf+0x260>
    80003a14:	00800793          	li	a5,8
    80003a18:	00700c93          	li	s9,7
    80003a1c:	bfdff06f          	j	80003618 <__printf+0x260>
    80003a20:	00100793          	li	a5,1
    80003a24:	d91ff06f          	j	800037b4 <__printf+0x3fc>
    80003a28:	00100793          	li	a5,1
    80003a2c:	bf1ff06f          	j	8000361c <__printf+0x264>
    80003a30:	00900793          	li	a5,9
    80003a34:	00800c93          	li	s9,8
    80003a38:	be1ff06f          	j	80003618 <__printf+0x260>
    80003a3c:	00001517          	auipc	a0,0x1
    80003a40:	7ec50513          	addi	a0,a0,2028 # 80005228 <CONSOLE_STATUS+0x210>
    80003a44:	00000097          	auipc	ra,0x0
    80003a48:	918080e7          	jalr	-1768(ra) # 8000335c <panic>

0000000080003a4c <printfinit>:
    80003a4c:	fe010113          	addi	sp,sp,-32
    80003a50:	00813823          	sd	s0,16(sp)
    80003a54:	00913423          	sd	s1,8(sp)
    80003a58:	00113c23          	sd	ra,24(sp)
    80003a5c:	02010413          	addi	s0,sp,32
    80003a60:	00006497          	auipc	s1,0x6
    80003a64:	e7048493          	addi	s1,s1,-400 # 800098d0 <pr>
    80003a68:	00048513          	mv	a0,s1
    80003a6c:	00001597          	auipc	a1,0x1
    80003a70:	7cc58593          	addi	a1,a1,1996 # 80005238 <CONSOLE_STATUS+0x220>
    80003a74:	00000097          	auipc	ra,0x0
    80003a78:	5f4080e7          	jalr	1524(ra) # 80004068 <initlock>
    80003a7c:	01813083          	ld	ra,24(sp)
    80003a80:	01013403          	ld	s0,16(sp)
    80003a84:	0004ac23          	sw	zero,24(s1)
    80003a88:	00813483          	ld	s1,8(sp)
    80003a8c:	02010113          	addi	sp,sp,32
    80003a90:	00008067          	ret

0000000080003a94 <uartinit>:
    80003a94:	ff010113          	addi	sp,sp,-16
    80003a98:	00813423          	sd	s0,8(sp)
    80003a9c:	01010413          	addi	s0,sp,16
    80003aa0:	100007b7          	lui	a5,0x10000
    80003aa4:	000780a3          	sb	zero,1(a5) # 10000001 <_entry-0x6fffffff>
    80003aa8:	f8000713          	li	a4,-128
    80003aac:	00e781a3          	sb	a4,3(a5)
    80003ab0:	00300713          	li	a4,3
    80003ab4:	00e78023          	sb	a4,0(a5)
    80003ab8:	000780a3          	sb	zero,1(a5)
    80003abc:	00e781a3          	sb	a4,3(a5)
    80003ac0:	00700693          	li	a3,7
    80003ac4:	00d78123          	sb	a3,2(a5)
    80003ac8:	00e780a3          	sb	a4,1(a5)
    80003acc:	00813403          	ld	s0,8(sp)
    80003ad0:	01010113          	addi	sp,sp,16
    80003ad4:	00008067          	ret

0000000080003ad8 <uartputc>:
    80003ad8:	00002797          	auipc	a5,0x2
    80003adc:	b9c7a783          	lw	a5,-1124(a5) # 80005674 <panicked>
    80003ae0:	00078463          	beqz	a5,80003ae8 <uartputc+0x10>
    80003ae4:	0000006f          	j	80003ae4 <uartputc+0xc>
    80003ae8:	fd010113          	addi	sp,sp,-48
    80003aec:	02813023          	sd	s0,32(sp)
    80003af0:	00913c23          	sd	s1,24(sp)
    80003af4:	01213823          	sd	s2,16(sp)
    80003af8:	01313423          	sd	s3,8(sp)
    80003afc:	02113423          	sd	ra,40(sp)
    80003b00:	03010413          	addi	s0,sp,48
    80003b04:	00002917          	auipc	s2,0x2
    80003b08:	b7490913          	addi	s2,s2,-1164 # 80005678 <uart_tx_r>
    80003b0c:	00093783          	ld	a5,0(s2)
    80003b10:	00002497          	auipc	s1,0x2
    80003b14:	b7048493          	addi	s1,s1,-1168 # 80005680 <uart_tx_w>
    80003b18:	0004b703          	ld	a4,0(s1)
    80003b1c:	02078693          	addi	a3,a5,32
    80003b20:	00050993          	mv	s3,a0
    80003b24:	02e69c63          	bne	a3,a4,80003b5c <uartputc+0x84>
    80003b28:	00001097          	auipc	ra,0x1
    80003b2c:	834080e7          	jalr	-1996(ra) # 8000435c <push_on>
    80003b30:	00093783          	ld	a5,0(s2)
    80003b34:	0004b703          	ld	a4,0(s1)
    80003b38:	02078793          	addi	a5,a5,32
    80003b3c:	00e79463          	bne	a5,a4,80003b44 <uartputc+0x6c>
    80003b40:	0000006f          	j	80003b40 <uartputc+0x68>
    80003b44:	00001097          	auipc	ra,0x1
    80003b48:	88c080e7          	jalr	-1908(ra) # 800043d0 <pop_on>
    80003b4c:	00093783          	ld	a5,0(s2)
    80003b50:	0004b703          	ld	a4,0(s1)
    80003b54:	02078693          	addi	a3,a5,32
    80003b58:	fce688e3          	beq	a3,a4,80003b28 <uartputc+0x50>
    80003b5c:	01f77693          	andi	a3,a4,31
    80003b60:	00006597          	auipc	a1,0x6
    80003b64:	d9058593          	addi	a1,a1,-624 # 800098f0 <uart_tx_buf>
    80003b68:	00d586b3          	add	a3,a1,a3
    80003b6c:	00170713          	addi	a4,a4,1
    80003b70:	01368023          	sb	s3,0(a3)
    80003b74:	00e4b023          	sd	a4,0(s1)
    80003b78:	10000637          	lui	a2,0x10000
    80003b7c:	02f71063          	bne	a4,a5,80003b9c <uartputc+0xc4>
    80003b80:	0340006f          	j	80003bb4 <uartputc+0xdc>
    80003b84:	00074703          	lbu	a4,0(a4)
    80003b88:	00f93023          	sd	a5,0(s2)
    80003b8c:	00e60023          	sb	a4,0(a2) # 10000000 <_entry-0x70000000>
    80003b90:	00093783          	ld	a5,0(s2)
    80003b94:	0004b703          	ld	a4,0(s1)
    80003b98:	00f70e63          	beq	a4,a5,80003bb4 <uartputc+0xdc>
    80003b9c:	00564683          	lbu	a3,5(a2)
    80003ba0:	01f7f713          	andi	a4,a5,31
    80003ba4:	00e58733          	add	a4,a1,a4
    80003ba8:	0206f693          	andi	a3,a3,32
    80003bac:	00178793          	addi	a5,a5,1
    80003bb0:	fc069ae3          	bnez	a3,80003b84 <uartputc+0xac>
    80003bb4:	02813083          	ld	ra,40(sp)
    80003bb8:	02013403          	ld	s0,32(sp)
    80003bbc:	01813483          	ld	s1,24(sp)
    80003bc0:	01013903          	ld	s2,16(sp)
    80003bc4:	00813983          	ld	s3,8(sp)
    80003bc8:	03010113          	addi	sp,sp,48
    80003bcc:	00008067          	ret

0000000080003bd0 <uartputc_sync>:
    80003bd0:	ff010113          	addi	sp,sp,-16
    80003bd4:	00813423          	sd	s0,8(sp)
    80003bd8:	01010413          	addi	s0,sp,16
    80003bdc:	00002717          	auipc	a4,0x2
    80003be0:	a9872703          	lw	a4,-1384(a4) # 80005674 <panicked>
    80003be4:	02071663          	bnez	a4,80003c10 <uartputc_sync+0x40>
    80003be8:	00050793          	mv	a5,a0
    80003bec:	100006b7          	lui	a3,0x10000
    80003bf0:	0056c703          	lbu	a4,5(a3) # 10000005 <_entry-0x6ffffffb>
    80003bf4:	02077713          	andi	a4,a4,32
    80003bf8:	fe070ce3          	beqz	a4,80003bf0 <uartputc_sync+0x20>
    80003bfc:	0ff7f793          	andi	a5,a5,255
    80003c00:	00f68023          	sb	a5,0(a3)
    80003c04:	00813403          	ld	s0,8(sp)
    80003c08:	01010113          	addi	sp,sp,16
    80003c0c:	00008067          	ret
    80003c10:	0000006f          	j	80003c10 <uartputc_sync+0x40>

0000000080003c14 <uartstart>:
    80003c14:	ff010113          	addi	sp,sp,-16
    80003c18:	00813423          	sd	s0,8(sp)
    80003c1c:	01010413          	addi	s0,sp,16
    80003c20:	00002617          	auipc	a2,0x2
    80003c24:	a5860613          	addi	a2,a2,-1448 # 80005678 <uart_tx_r>
    80003c28:	00002517          	auipc	a0,0x2
    80003c2c:	a5850513          	addi	a0,a0,-1448 # 80005680 <uart_tx_w>
    80003c30:	00063783          	ld	a5,0(a2)
    80003c34:	00053703          	ld	a4,0(a0)
    80003c38:	04f70263          	beq	a4,a5,80003c7c <uartstart+0x68>
    80003c3c:	100005b7          	lui	a1,0x10000
    80003c40:	00006817          	auipc	a6,0x6
    80003c44:	cb080813          	addi	a6,a6,-848 # 800098f0 <uart_tx_buf>
    80003c48:	01c0006f          	j	80003c64 <uartstart+0x50>
    80003c4c:	0006c703          	lbu	a4,0(a3)
    80003c50:	00f63023          	sd	a5,0(a2)
    80003c54:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    80003c58:	00063783          	ld	a5,0(a2)
    80003c5c:	00053703          	ld	a4,0(a0)
    80003c60:	00f70e63          	beq	a4,a5,80003c7c <uartstart+0x68>
    80003c64:	01f7f713          	andi	a4,a5,31
    80003c68:	00e806b3          	add	a3,a6,a4
    80003c6c:	0055c703          	lbu	a4,5(a1)
    80003c70:	00178793          	addi	a5,a5,1
    80003c74:	02077713          	andi	a4,a4,32
    80003c78:	fc071ae3          	bnez	a4,80003c4c <uartstart+0x38>
    80003c7c:	00813403          	ld	s0,8(sp)
    80003c80:	01010113          	addi	sp,sp,16
    80003c84:	00008067          	ret

0000000080003c88 <uartgetc>:
    80003c88:	ff010113          	addi	sp,sp,-16
    80003c8c:	00813423          	sd	s0,8(sp)
    80003c90:	01010413          	addi	s0,sp,16
    80003c94:	10000737          	lui	a4,0x10000
    80003c98:	00574783          	lbu	a5,5(a4) # 10000005 <_entry-0x6ffffffb>
    80003c9c:	0017f793          	andi	a5,a5,1
    80003ca0:	00078c63          	beqz	a5,80003cb8 <uartgetc+0x30>
    80003ca4:	00074503          	lbu	a0,0(a4)
    80003ca8:	0ff57513          	andi	a0,a0,255
    80003cac:	00813403          	ld	s0,8(sp)
    80003cb0:	01010113          	addi	sp,sp,16
    80003cb4:	00008067          	ret
    80003cb8:	fff00513          	li	a0,-1
    80003cbc:	ff1ff06f          	j	80003cac <uartgetc+0x24>

0000000080003cc0 <uartintr>:
    80003cc0:	100007b7          	lui	a5,0x10000
    80003cc4:	0057c783          	lbu	a5,5(a5) # 10000005 <_entry-0x6ffffffb>
    80003cc8:	0017f793          	andi	a5,a5,1
    80003ccc:	0a078463          	beqz	a5,80003d74 <uartintr+0xb4>
    80003cd0:	fe010113          	addi	sp,sp,-32
    80003cd4:	00813823          	sd	s0,16(sp)
    80003cd8:	00913423          	sd	s1,8(sp)
    80003cdc:	00113c23          	sd	ra,24(sp)
    80003ce0:	02010413          	addi	s0,sp,32
    80003ce4:	100004b7          	lui	s1,0x10000
    80003ce8:	0004c503          	lbu	a0,0(s1) # 10000000 <_entry-0x70000000>
    80003cec:	0ff57513          	andi	a0,a0,255
    80003cf0:	fffff097          	auipc	ra,0xfffff
    80003cf4:	534080e7          	jalr	1332(ra) # 80003224 <consoleintr>
    80003cf8:	0054c783          	lbu	a5,5(s1)
    80003cfc:	0017f793          	andi	a5,a5,1
    80003d00:	fe0794e3          	bnez	a5,80003ce8 <uartintr+0x28>
    80003d04:	00002617          	auipc	a2,0x2
    80003d08:	97460613          	addi	a2,a2,-1676 # 80005678 <uart_tx_r>
    80003d0c:	00002517          	auipc	a0,0x2
    80003d10:	97450513          	addi	a0,a0,-1676 # 80005680 <uart_tx_w>
    80003d14:	00063783          	ld	a5,0(a2)
    80003d18:	00053703          	ld	a4,0(a0)
    80003d1c:	04f70263          	beq	a4,a5,80003d60 <uartintr+0xa0>
    80003d20:	100005b7          	lui	a1,0x10000
    80003d24:	00006817          	auipc	a6,0x6
    80003d28:	bcc80813          	addi	a6,a6,-1076 # 800098f0 <uart_tx_buf>
    80003d2c:	01c0006f          	j	80003d48 <uartintr+0x88>
    80003d30:	0006c703          	lbu	a4,0(a3)
    80003d34:	00f63023          	sd	a5,0(a2)
    80003d38:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    80003d3c:	00063783          	ld	a5,0(a2)
    80003d40:	00053703          	ld	a4,0(a0)
    80003d44:	00f70e63          	beq	a4,a5,80003d60 <uartintr+0xa0>
    80003d48:	01f7f713          	andi	a4,a5,31
    80003d4c:	00e806b3          	add	a3,a6,a4
    80003d50:	0055c703          	lbu	a4,5(a1)
    80003d54:	00178793          	addi	a5,a5,1
    80003d58:	02077713          	andi	a4,a4,32
    80003d5c:	fc071ae3          	bnez	a4,80003d30 <uartintr+0x70>
    80003d60:	01813083          	ld	ra,24(sp)
    80003d64:	01013403          	ld	s0,16(sp)
    80003d68:	00813483          	ld	s1,8(sp)
    80003d6c:	02010113          	addi	sp,sp,32
    80003d70:	00008067          	ret
    80003d74:	00002617          	auipc	a2,0x2
    80003d78:	90460613          	addi	a2,a2,-1788 # 80005678 <uart_tx_r>
    80003d7c:	00002517          	auipc	a0,0x2
    80003d80:	90450513          	addi	a0,a0,-1788 # 80005680 <uart_tx_w>
    80003d84:	00063783          	ld	a5,0(a2)
    80003d88:	00053703          	ld	a4,0(a0)
    80003d8c:	04f70263          	beq	a4,a5,80003dd0 <uartintr+0x110>
    80003d90:	100005b7          	lui	a1,0x10000
    80003d94:	00006817          	auipc	a6,0x6
    80003d98:	b5c80813          	addi	a6,a6,-1188 # 800098f0 <uart_tx_buf>
    80003d9c:	01c0006f          	j	80003db8 <uartintr+0xf8>
    80003da0:	0006c703          	lbu	a4,0(a3)
    80003da4:	00f63023          	sd	a5,0(a2)
    80003da8:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    80003dac:	00063783          	ld	a5,0(a2)
    80003db0:	00053703          	ld	a4,0(a0)
    80003db4:	02f70063          	beq	a4,a5,80003dd4 <uartintr+0x114>
    80003db8:	01f7f713          	andi	a4,a5,31
    80003dbc:	00e806b3          	add	a3,a6,a4
    80003dc0:	0055c703          	lbu	a4,5(a1)
    80003dc4:	00178793          	addi	a5,a5,1
    80003dc8:	02077713          	andi	a4,a4,32
    80003dcc:	fc071ae3          	bnez	a4,80003da0 <uartintr+0xe0>
    80003dd0:	00008067          	ret
    80003dd4:	00008067          	ret

0000000080003dd8 <kinit>:
    80003dd8:	fc010113          	addi	sp,sp,-64
    80003ddc:	02913423          	sd	s1,40(sp)
    80003de0:	fffff7b7          	lui	a5,0xfffff
    80003de4:	00007497          	auipc	s1,0x7
    80003de8:	b2b48493          	addi	s1,s1,-1237 # 8000a90f <end+0xfff>
    80003dec:	02813823          	sd	s0,48(sp)
    80003df0:	01313c23          	sd	s3,24(sp)
    80003df4:	00f4f4b3          	and	s1,s1,a5
    80003df8:	02113c23          	sd	ra,56(sp)
    80003dfc:	03213023          	sd	s2,32(sp)
    80003e00:	01413823          	sd	s4,16(sp)
    80003e04:	01513423          	sd	s5,8(sp)
    80003e08:	04010413          	addi	s0,sp,64
    80003e0c:	000017b7          	lui	a5,0x1
    80003e10:	01100993          	li	s3,17
    80003e14:	00f487b3          	add	a5,s1,a5
    80003e18:	01b99993          	slli	s3,s3,0x1b
    80003e1c:	06f9e063          	bltu	s3,a5,80003e7c <kinit+0xa4>
    80003e20:	00006a97          	auipc	s5,0x6
    80003e24:	af0a8a93          	addi	s5,s5,-1296 # 80009910 <end>
    80003e28:	0754ec63          	bltu	s1,s5,80003ea0 <kinit+0xc8>
    80003e2c:	0734fa63          	bgeu	s1,s3,80003ea0 <kinit+0xc8>
    80003e30:	00088a37          	lui	s4,0x88
    80003e34:	fffa0a13          	addi	s4,s4,-1 # 87fff <_entry-0x7ff78001>
    80003e38:	00002917          	auipc	s2,0x2
    80003e3c:	85090913          	addi	s2,s2,-1968 # 80005688 <kmem>
    80003e40:	00ca1a13          	slli	s4,s4,0xc
    80003e44:	0140006f          	j	80003e58 <kinit+0x80>
    80003e48:	000017b7          	lui	a5,0x1
    80003e4c:	00f484b3          	add	s1,s1,a5
    80003e50:	0554e863          	bltu	s1,s5,80003ea0 <kinit+0xc8>
    80003e54:	0534f663          	bgeu	s1,s3,80003ea0 <kinit+0xc8>
    80003e58:	00001637          	lui	a2,0x1
    80003e5c:	00100593          	li	a1,1
    80003e60:	00048513          	mv	a0,s1
    80003e64:	00000097          	auipc	ra,0x0
    80003e68:	5e4080e7          	jalr	1508(ra) # 80004448 <__memset>
    80003e6c:	00093783          	ld	a5,0(s2)
    80003e70:	00f4b023          	sd	a5,0(s1)
    80003e74:	00993023          	sd	s1,0(s2)
    80003e78:	fd4498e3          	bne	s1,s4,80003e48 <kinit+0x70>
    80003e7c:	03813083          	ld	ra,56(sp)
    80003e80:	03013403          	ld	s0,48(sp)
    80003e84:	02813483          	ld	s1,40(sp)
    80003e88:	02013903          	ld	s2,32(sp)
    80003e8c:	01813983          	ld	s3,24(sp)
    80003e90:	01013a03          	ld	s4,16(sp)
    80003e94:	00813a83          	ld	s5,8(sp)
    80003e98:	04010113          	addi	sp,sp,64
    80003e9c:	00008067          	ret
    80003ea0:	00001517          	auipc	a0,0x1
    80003ea4:	3b850513          	addi	a0,a0,952 # 80005258 <digits+0x18>
    80003ea8:	fffff097          	auipc	ra,0xfffff
    80003eac:	4b4080e7          	jalr	1204(ra) # 8000335c <panic>

0000000080003eb0 <freerange>:
    80003eb0:	fc010113          	addi	sp,sp,-64
    80003eb4:	000017b7          	lui	a5,0x1
    80003eb8:	02913423          	sd	s1,40(sp)
    80003ebc:	fff78493          	addi	s1,a5,-1 # fff <_entry-0x7ffff001>
    80003ec0:	009504b3          	add	s1,a0,s1
    80003ec4:	fffff537          	lui	a0,0xfffff
    80003ec8:	02813823          	sd	s0,48(sp)
    80003ecc:	02113c23          	sd	ra,56(sp)
    80003ed0:	03213023          	sd	s2,32(sp)
    80003ed4:	01313c23          	sd	s3,24(sp)
    80003ed8:	01413823          	sd	s4,16(sp)
    80003edc:	01513423          	sd	s5,8(sp)
    80003ee0:	01613023          	sd	s6,0(sp)
    80003ee4:	04010413          	addi	s0,sp,64
    80003ee8:	00a4f4b3          	and	s1,s1,a0
    80003eec:	00f487b3          	add	a5,s1,a5
    80003ef0:	06f5e463          	bltu	a1,a5,80003f58 <freerange+0xa8>
    80003ef4:	00006a97          	auipc	s5,0x6
    80003ef8:	a1ca8a93          	addi	s5,s5,-1508 # 80009910 <end>
    80003efc:	0954e263          	bltu	s1,s5,80003f80 <freerange+0xd0>
    80003f00:	01100993          	li	s3,17
    80003f04:	01b99993          	slli	s3,s3,0x1b
    80003f08:	0734fc63          	bgeu	s1,s3,80003f80 <freerange+0xd0>
    80003f0c:	00058a13          	mv	s4,a1
    80003f10:	00001917          	auipc	s2,0x1
    80003f14:	77890913          	addi	s2,s2,1912 # 80005688 <kmem>
    80003f18:	00002b37          	lui	s6,0x2
    80003f1c:	0140006f          	j	80003f30 <freerange+0x80>
    80003f20:	000017b7          	lui	a5,0x1
    80003f24:	00f484b3          	add	s1,s1,a5
    80003f28:	0554ec63          	bltu	s1,s5,80003f80 <freerange+0xd0>
    80003f2c:	0534fa63          	bgeu	s1,s3,80003f80 <freerange+0xd0>
    80003f30:	00001637          	lui	a2,0x1
    80003f34:	00100593          	li	a1,1
    80003f38:	00048513          	mv	a0,s1
    80003f3c:	00000097          	auipc	ra,0x0
    80003f40:	50c080e7          	jalr	1292(ra) # 80004448 <__memset>
    80003f44:	00093703          	ld	a4,0(s2)
    80003f48:	016487b3          	add	a5,s1,s6
    80003f4c:	00e4b023          	sd	a4,0(s1)
    80003f50:	00993023          	sd	s1,0(s2)
    80003f54:	fcfa76e3          	bgeu	s4,a5,80003f20 <freerange+0x70>
    80003f58:	03813083          	ld	ra,56(sp)
    80003f5c:	03013403          	ld	s0,48(sp)
    80003f60:	02813483          	ld	s1,40(sp)
    80003f64:	02013903          	ld	s2,32(sp)
    80003f68:	01813983          	ld	s3,24(sp)
    80003f6c:	01013a03          	ld	s4,16(sp)
    80003f70:	00813a83          	ld	s5,8(sp)
    80003f74:	00013b03          	ld	s6,0(sp)
    80003f78:	04010113          	addi	sp,sp,64
    80003f7c:	00008067          	ret
    80003f80:	00001517          	auipc	a0,0x1
    80003f84:	2d850513          	addi	a0,a0,728 # 80005258 <digits+0x18>
    80003f88:	fffff097          	auipc	ra,0xfffff
    80003f8c:	3d4080e7          	jalr	980(ra) # 8000335c <panic>

0000000080003f90 <kfree>:
    80003f90:	fe010113          	addi	sp,sp,-32
    80003f94:	00813823          	sd	s0,16(sp)
    80003f98:	00113c23          	sd	ra,24(sp)
    80003f9c:	00913423          	sd	s1,8(sp)
    80003fa0:	02010413          	addi	s0,sp,32
    80003fa4:	03451793          	slli	a5,a0,0x34
    80003fa8:	04079c63          	bnez	a5,80004000 <kfree+0x70>
    80003fac:	00006797          	auipc	a5,0x6
    80003fb0:	96478793          	addi	a5,a5,-1692 # 80009910 <end>
    80003fb4:	00050493          	mv	s1,a0
    80003fb8:	04f56463          	bltu	a0,a5,80004000 <kfree+0x70>
    80003fbc:	01100793          	li	a5,17
    80003fc0:	01b79793          	slli	a5,a5,0x1b
    80003fc4:	02f57e63          	bgeu	a0,a5,80004000 <kfree+0x70>
    80003fc8:	00001637          	lui	a2,0x1
    80003fcc:	00100593          	li	a1,1
    80003fd0:	00000097          	auipc	ra,0x0
    80003fd4:	478080e7          	jalr	1144(ra) # 80004448 <__memset>
    80003fd8:	00001797          	auipc	a5,0x1
    80003fdc:	6b078793          	addi	a5,a5,1712 # 80005688 <kmem>
    80003fe0:	0007b703          	ld	a4,0(a5)
    80003fe4:	01813083          	ld	ra,24(sp)
    80003fe8:	01013403          	ld	s0,16(sp)
    80003fec:	00e4b023          	sd	a4,0(s1)
    80003ff0:	0097b023          	sd	s1,0(a5)
    80003ff4:	00813483          	ld	s1,8(sp)
    80003ff8:	02010113          	addi	sp,sp,32
    80003ffc:	00008067          	ret
    80004000:	00001517          	auipc	a0,0x1
    80004004:	25850513          	addi	a0,a0,600 # 80005258 <digits+0x18>
    80004008:	fffff097          	auipc	ra,0xfffff
    8000400c:	354080e7          	jalr	852(ra) # 8000335c <panic>

0000000080004010 <kalloc>:
    80004010:	fe010113          	addi	sp,sp,-32
    80004014:	00813823          	sd	s0,16(sp)
    80004018:	00913423          	sd	s1,8(sp)
    8000401c:	00113c23          	sd	ra,24(sp)
    80004020:	02010413          	addi	s0,sp,32
    80004024:	00001797          	auipc	a5,0x1
    80004028:	66478793          	addi	a5,a5,1636 # 80005688 <kmem>
    8000402c:	0007b483          	ld	s1,0(a5)
    80004030:	02048063          	beqz	s1,80004050 <kalloc+0x40>
    80004034:	0004b703          	ld	a4,0(s1)
    80004038:	00001637          	lui	a2,0x1
    8000403c:	00500593          	li	a1,5
    80004040:	00048513          	mv	a0,s1
    80004044:	00e7b023          	sd	a4,0(a5)
    80004048:	00000097          	auipc	ra,0x0
    8000404c:	400080e7          	jalr	1024(ra) # 80004448 <__memset>
    80004050:	01813083          	ld	ra,24(sp)
    80004054:	01013403          	ld	s0,16(sp)
    80004058:	00048513          	mv	a0,s1
    8000405c:	00813483          	ld	s1,8(sp)
    80004060:	02010113          	addi	sp,sp,32
    80004064:	00008067          	ret

0000000080004068 <initlock>:
    80004068:	ff010113          	addi	sp,sp,-16
    8000406c:	00813423          	sd	s0,8(sp)
    80004070:	01010413          	addi	s0,sp,16
    80004074:	00813403          	ld	s0,8(sp)
    80004078:	00b53423          	sd	a1,8(a0)
    8000407c:	00052023          	sw	zero,0(a0)
    80004080:	00053823          	sd	zero,16(a0)
    80004084:	01010113          	addi	sp,sp,16
    80004088:	00008067          	ret

000000008000408c <acquire>:
    8000408c:	fe010113          	addi	sp,sp,-32
    80004090:	00813823          	sd	s0,16(sp)
    80004094:	00913423          	sd	s1,8(sp)
    80004098:	00113c23          	sd	ra,24(sp)
    8000409c:	01213023          	sd	s2,0(sp)
    800040a0:	02010413          	addi	s0,sp,32
    800040a4:	00050493          	mv	s1,a0
    800040a8:	10002973          	csrr	s2,sstatus
    800040ac:	100027f3          	csrr	a5,sstatus
    800040b0:	ffd7f793          	andi	a5,a5,-3
    800040b4:	10079073          	csrw	sstatus,a5
    800040b8:	fffff097          	auipc	ra,0xfffff
    800040bc:	8e0080e7          	jalr	-1824(ra) # 80002998 <mycpu>
    800040c0:	07852783          	lw	a5,120(a0)
    800040c4:	06078e63          	beqz	a5,80004140 <acquire+0xb4>
    800040c8:	fffff097          	auipc	ra,0xfffff
    800040cc:	8d0080e7          	jalr	-1840(ra) # 80002998 <mycpu>
    800040d0:	07852783          	lw	a5,120(a0)
    800040d4:	0004a703          	lw	a4,0(s1)
    800040d8:	0017879b          	addiw	a5,a5,1
    800040dc:	06f52c23          	sw	a5,120(a0)
    800040e0:	04071063          	bnez	a4,80004120 <acquire+0x94>
    800040e4:	00100713          	li	a4,1
    800040e8:	00070793          	mv	a5,a4
    800040ec:	0cf4a7af          	amoswap.w.aq	a5,a5,(s1)
    800040f0:	0007879b          	sext.w	a5,a5
    800040f4:	fe079ae3          	bnez	a5,800040e8 <acquire+0x5c>
    800040f8:	0ff0000f          	fence
    800040fc:	fffff097          	auipc	ra,0xfffff
    80004100:	89c080e7          	jalr	-1892(ra) # 80002998 <mycpu>
    80004104:	01813083          	ld	ra,24(sp)
    80004108:	01013403          	ld	s0,16(sp)
    8000410c:	00a4b823          	sd	a0,16(s1)
    80004110:	00013903          	ld	s2,0(sp)
    80004114:	00813483          	ld	s1,8(sp)
    80004118:	02010113          	addi	sp,sp,32
    8000411c:	00008067          	ret
    80004120:	0104b903          	ld	s2,16(s1)
    80004124:	fffff097          	auipc	ra,0xfffff
    80004128:	874080e7          	jalr	-1932(ra) # 80002998 <mycpu>
    8000412c:	faa91ce3          	bne	s2,a0,800040e4 <acquire+0x58>
    80004130:	00001517          	auipc	a0,0x1
    80004134:	13050513          	addi	a0,a0,304 # 80005260 <digits+0x20>
    80004138:	fffff097          	auipc	ra,0xfffff
    8000413c:	224080e7          	jalr	548(ra) # 8000335c <panic>
    80004140:	00195913          	srli	s2,s2,0x1
    80004144:	fffff097          	auipc	ra,0xfffff
    80004148:	854080e7          	jalr	-1964(ra) # 80002998 <mycpu>
    8000414c:	00197913          	andi	s2,s2,1
    80004150:	07252e23          	sw	s2,124(a0)
    80004154:	f75ff06f          	j	800040c8 <acquire+0x3c>

0000000080004158 <release>:
    80004158:	fe010113          	addi	sp,sp,-32
    8000415c:	00813823          	sd	s0,16(sp)
    80004160:	00113c23          	sd	ra,24(sp)
    80004164:	00913423          	sd	s1,8(sp)
    80004168:	01213023          	sd	s2,0(sp)
    8000416c:	02010413          	addi	s0,sp,32
    80004170:	00052783          	lw	a5,0(a0)
    80004174:	00079a63          	bnez	a5,80004188 <release+0x30>
    80004178:	00001517          	auipc	a0,0x1
    8000417c:	0f050513          	addi	a0,a0,240 # 80005268 <digits+0x28>
    80004180:	fffff097          	auipc	ra,0xfffff
    80004184:	1dc080e7          	jalr	476(ra) # 8000335c <panic>
    80004188:	01053903          	ld	s2,16(a0)
    8000418c:	00050493          	mv	s1,a0
    80004190:	fffff097          	auipc	ra,0xfffff
    80004194:	808080e7          	jalr	-2040(ra) # 80002998 <mycpu>
    80004198:	fea910e3          	bne	s2,a0,80004178 <release+0x20>
    8000419c:	0004b823          	sd	zero,16(s1)
    800041a0:	0ff0000f          	fence
    800041a4:	0f50000f          	fence	iorw,ow
    800041a8:	0804a02f          	amoswap.w	zero,zero,(s1)
    800041ac:	ffffe097          	auipc	ra,0xffffe
    800041b0:	7ec080e7          	jalr	2028(ra) # 80002998 <mycpu>
    800041b4:	100027f3          	csrr	a5,sstatus
    800041b8:	0027f793          	andi	a5,a5,2
    800041bc:	04079a63          	bnez	a5,80004210 <release+0xb8>
    800041c0:	07852783          	lw	a5,120(a0)
    800041c4:	02f05e63          	blez	a5,80004200 <release+0xa8>
    800041c8:	fff7871b          	addiw	a4,a5,-1
    800041cc:	06e52c23          	sw	a4,120(a0)
    800041d0:	00071c63          	bnez	a4,800041e8 <release+0x90>
    800041d4:	07c52783          	lw	a5,124(a0)
    800041d8:	00078863          	beqz	a5,800041e8 <release+0x90>
    800041dc:	100027f3          	csrr	a5,sstatus
    800041e0:	0027e793          	ori	a5,a5,2
    800041e4:	10079073          	csrw	sstatus,a5
    800041e8:	01813083          	ld	ra,24(sp)
    800041ec:	01013403          	ld	s0,16(sp)
    800041f0:	00813483          	ld	s1,8(sp)
    800041f4:	00013903          	ld	s2,0(sp)
    800041f8:	02010113          	addi	sp,sp,32
    800041fc:	00008067          	ret
    80004200:	00001517          	auipc	a0,0x1
    80004204:	08850513          	addi	a0,a0,136 # 80005288 <digits+0x48>
    80004208:	fffff097          	auipc	ra,0xfffff
    8000420c:	154080e7          	jalr	340(ra) # 8000335c <panic>
    80004210:	00001517          	auipc	a0,0x1
    80004214:	06050513          	addi	a0,a0,96 # 80005270 <digits+0x30>
    80004218:	fffff097          	auipc	ra,0xfffff
    8000421c:	144080e7          	jalr	324(ra) # 8000335c <panic>

0000000080004220 <holding>:
    80004220:	00052783          	lw	a5,0(a0)
    80004224:	00079663          	bnez	a5,80004230 <holding+0x10>
    80004228:	00000513          	li	a0,0
    8000422c:	00008067          	ret
    80004230:	fe010113          	addi	sp,sp,-32
    80004234:	00813823          	sd	s0,16(sp)
    80004238:	00913423          	sd	s1,8(sp)
    8000423c:	00113c23          	sd	ra,24(sp)
    80004240:	02010413          	addi	s0,sp,32
    80004244:	01053483          	ld	s1,16(a0)
    80004248:	ffffe097          	auipc	ra,0xffffe
    8000424c:	750080e7          	jalr	1872(ra) # 80002998 <mycpu>
    80004250:	01813083          	ld	ra,24(sp)
    80004254:	01013403          	ld	s0,16(sp)
    80004258:	40a48533          	sub	a0,s1,a0
    8000425c:	00153513          	seqz	a0,a0
    80004260:	00813483          	ld	s1,8(sp)
    80004264:	02010113          	addi	sp,sp,32
    80004268:	00008067          	ret

000000008000426c <push_off>:
    8000426c:	fe010113          	addi	sp,sp,-32
    80004270:	00813823          	sd	s0,16(sp)
    80004274:	00113c23          	sd	ra,24(sp)
    80004278:	00913423          	sd	s1,8(sp)
    8000427c:	02010413          	addi	s0,sp,32
    80004280:	100024f3          	csrr	s1,sstatus
    80004284:	100027f3          	csrr	a5,sstatus
    80004288:	ffd7f793          	andi	a5,a5,-3
    8000428c:	10079073          	csrw	sstatus,a5
    80004290:	ffffe097          	auipc	ra,0xffffe
    80004294:	708080e7          	jalr	1800(ra) # 80002998 <mycpu>
    80004298:	07852783          	lw	a5,120(a0)
    8000429c:	02078663          	beqz	a5,800042c8 <push_off+0x5c>
    800042a0:	ffffe097          	auipc	ra,0xffffe
    800042a4:	6f8080e7          	jalr	1784(ra) # 80002998 <mycpu>
    800042a8:	07852783          	lw	a5,120(a0)
    800042ac:	01813083          	ld	ra,24(sp)
    800042b0:	01013403          	ld	s0,16(sp)
    800042b4:	0017879b          	addiw	a5,a5,1
    800042b8:	06f52c23          	sw	a5,120(a0)
    800042bc:	00813483          	ld	s1,8(sp)
    800042c0:	02010113          	addi	sp,sp,32
    800042c4:	00008067          	ret
    800042c8:	0014d493          	srli	s1,s1,0x1
    800042cc:	ffffe097          	auipc	ra,0xffffe
    800042d0:	6cc080e7          	jalr	1740(ra) # 80002998 <mycpu>
    800042d4:	0014f493          	andi	s1,s1,1
    800042d8:	06952e23          	sw	s1,124(a0)
    800042dc:	fc5ff06f          	j	800042a0 <push_off+0x34>

00000000800042e0 <pop_off>:
    800042e0:	ff010113          	addi	sp,sp,-16
    800042e4:	00813023          	sd	s0,0(sp)
    800042e8:	00113423          	sd	ra,8(sp)
    800042ec:	01010413          	addi	s0,sp,16
    800042f0:	ffffe097          	auipc	ra,0xffffe
    800042f4:	6a8080e7          	jalr	1704(ra) # 80002998 <mycpu>
    800042f8:	100027f3          	csrr	a5,sstatus
    800042fc:	0027f793          	andi	a5,a5,2
    80004300:	04079663          	bnez	a5,8000434c <pop_off+0x6c>
    80004304:	07852783          	lw	a5,120(a0)
    80004308:	02f05a63          	blez	a5,8000433c <pop_off+0x5c>
    8000430c:	fff7871b          	addiw	a4,a5,-1
    80004310:	06e52c23          	sw	a4,120(a0)
    80004314:	00071c63          	bnez	a4,8000432c <pop_off+0x4c>
    80004318:	07c52783          	lw	a5,124(a0)
    8000431c:	00078863          	beqz	a5,8000432c <pop_off+0x4c>
    80004320:	100027f3          	csrr	a5,sstatus
    80004324:	0027e793          	ori	a5,a5,2
    80004328:	10079073          	csrw	sstatus,a5
    8000432c:	00813083          	ld	ra,8(sp)
    80004330:	00013403          	ld	s0,0(sp)
    80004334:	01010113          	addi	sp,sp,16
    80004338:	00008067          	ret
    8000433c:	00001517          	auipc	a0,0x1
    80004340:	f4c50513          	addi	a0,a0,-180 # 80005288 <digits+0x48>
    80004344:	fffff097          	auipc	ra,0xfffff
    80004348:	018080e7          	jalr	24(ra) # 8000335c <panic>
    8000434c:	00001517          	auipc	a0,0x1
    80004350:	f2450513          	addi	a0,a0,-220 # 80005270 <digits+0x30>
    80004354:	fffff097          	auipc	ra,0xfffff
    80004358:	008080e7          	jalr	8(ra) # 8000335c <panic>

000000008000435c <push_on>:
    8000435c:	fe010113          	addi	sp,sp,-32
    80004360:	00813823          	sd	s0,16(sp)
    80004364:	00113c23          	sd	ra,24(sp)
    80004368:	00913423          	sd	s1,8(sp)
    8000436c:	02010413          	addi	s0,sp,32
    80004370:	100024f3          	csrr	s1,sstatus
    80004374:	100027f3          	csrr	a5,sstatus
    80004378:	0027e793          	ori	a5,a5,2
    8000437c:	10079073          	csrw	sstatus,a5
    80004380:	ffffe097          	auipc	ra,0xffffe
    80004384:	618080e7          	jalr	1560(ra) # 80002998 <mycpu>
    80004388:	07852783          	lw	a5,120(a0)
    8000438c:	02078663          	beqz	a5,800043b8 <push_on+0x5c>
    80004390:	ffffe097          	auipc	ra,0xffffe
    80004394:	608080e7          	jalr	1544(ra) # 80002998 <mycpu>
    80004398:	07852783          	lw	a5,120(a0)
    8000439c:	01813083          	ld	ra,24(sp)
    800043a0:	01013403          	ld	s0,16(sp)
    800043a4:	0017879b          	addiw	a5,a5,1
    800043a8:	06f52c23          	sw	a5,120(a0)
    800043ac:	00813483          	ld	s1,8(sp)
    800043b0:	02010113          	addi	sp,sp,32
    800043b4:	00008067          	ret
    800043b8:	0014d493          	srli	s1,s1,0x1
    800043bc:	ffffe097          	auipc	ra,0xffffe
    800043c0:	5dc080e7          	jalr	1500(ra) # 80002998 <mycpu>
    800043c4:	0014f493          	andi	s1,s1,1
    800043c8:	06952e23          	sw	s1,124(a0)
    800043cc:	fc5ff06f          	j	80004390 <push_on+0x34>

00000000800043d0 <pop_on>:
    800043d0:	ff010113          	addi	sp,sp,-16
    800043d4:	00813023          	sd	s0,0(sp)
    800043d8:	00113423          	sd	ra,8(sp)
    800043dc:	01010413          	addi	s0,sp,16
    800043e0:	ffffe097          	auipc	ra,0xffffe
    800043e4:	5b8080e7          	jalr	1464(ra) # 80002998 <mycpu>
    800043e8:	100027f3          	csrr	a5,sstatus
    800043ec:	0027f793          	andi	a5,a5,2
    800043f0:	04078463          	beqz	a5,80004438 <pop_on+0x68>
    800043f4:	07852783          	lw	a5,120(a0)
    800043f8:	02f05863          	blez	a5,80004428 <pop_on+0x58>
    800043fc:	fff7879b          	addiw	a5,a5,-1
    80004400:	06f52c23          	sw	a5,120(a0)
    80004404:	07853783          	ld	a5,120(a0)
    80004408:	00079863          	bnez	a5,80004418 <pop_on+0x48>
    8000440c:	100027f3          	csrr	a5,sstatus
    80004410:	ffd7f793          	andi	a5,a5,-3
    80004414:	10079073          	csrw	sstatus,a5
    80004418:	00813083          	ld	ra,8(sp)
    8000441c:	00013403          	ld	s0,0(sp)
    80004420:	01010113          	addi	sp,sp,16
    80004424:	00008067          	ret
    80004428:	00001517          	auipc	a0,0x1
    8000442c:	e8850513          	addi	a0,a0,-376 # 800052b0 <digits+0x70>
    80004430:	fffff097          	auipc	ra,0xfffff
    80004434:	f2c080e7          	jalr	-212(ra) # 8000335c <panic>
    80004438:	00001517          	auipc	a0,0x1
    8000443c:	e5850513          	addi	a0,a0,-424 # 80005290 <digits+0x50>
    80004440:	fffff097          	auipc	ra,0xfffff
    80004444:	f1c080e7          	jalr	-228(ra) # 8000335c <panic>

0000000080004448 <__memset>:
    80004448:	ff010113          	addi	sp,sp,-16
    8000444c:	00813423          	sd	s0,8(sp)
    80004450:	01010413          	addi	s0,sp,16
    80004454:	1a060e63          	beqz	a2,80004610 <__memset+0x1c8>
    80004458:	40a007b3          	neg	a5,a0
    8000445c:	0077f793          	andi	a5,a5,7
    80004460:	00778693          	addi	a3,a5,7
    80004464:	00b00813          	li	a6,11
    80004468:	0ff5f593          	andi	a1,a1,255
    8000446c:	fff6071b          	addiw	a4,a2,-1
    80004470:	1b06e663          	bltu	a3,a6,8000461c <__memset+0x1d4>
    80004474:	1cd76463          	bltu	a4,a3,8000463c <__memset+0x1f4>
    80004478:	1a078e63          	beqz	a5,80004634 <__memset+0x1ec>
    8000447c:	00b50023          	sb	a1,0(a0)
    80004480:	00100713          	li	a4,1
    80004484:	1ae78463          	beq	a5,a4,8000462c <__memset+0x1e4>
    80004488:	00b500a3          	sb	a1,1(a0)
    8000448c:	00200713          	li	a4,2
    80004490:	1ae78a63          	beq	a5,a4,80004644 <__memset+0x1fc>
    80004494:	00b50123          	sb	a1,2(a0)
    80004498:	00300713          	li	a4,3
    8000449c:	18e78463          	beq	a5,a4,80004624 <__memset+0x1dc>
    800044a0:	00b501a3          	sb	a1,3(a0)
    800044a4:	00400713          	li	a4,4
    800044a8:	1ae78263          	beq	a5,a4,8000464c <__memset+0x204>
    800044ac:	00b50223          	sb	a1,4(a0)
    800044b0:	00500713          	li	a4,5
    800044b4:	1ae78063          	beq	a5,a4,80004654 <__memset+0x20c>
    800044b8:	00b502a3          	sb	a1,5(a0)
    800044bc:	00700713          	li	a4,7
    800044c0:	18e79e63          	bne	a5,a4,8000465c <__memset+0x214>
    800044c4:	00b50323          	sb	a1,6(a0)
    800044c8:	00700e93          	li	t4,7
    800044cc:	00859713          	slli	a4,a1,0x8
    800044d0:	00e5e733          	or	a4,a1,a4
    800044d4:	01059e13          	slli	t3,a1,0x10
    800044d8:	01c76e33          	or	t3,a4,t3
    800044dc:	01859313          	slli	t1,a1,0x18
    800044e0:	006e6333          	or	t1,t3,t1
    800044e4:	02059893          	slli	a7,a1,0x20
    800044e8:	40f60e3b          	subw	t3,a2,a5
    800044ec:	011368b3          	or	a7,t1,a7
    800044f0:	02859813          	slli	a6,a1,0x28
    800044f4:	0108e833          	or	a6,a7,a6
    800044f8:	03059693          	slli	a3,a1,0x30
    800044fc:	003e589b          	srliw	a7,t3,0x3
    80004500:	00d866b3          	or	a3,a6,a3
    80004504:	03859713          	slli	a4,a1,0x38
    80004508:	00389813          	slli	a6,a7,0x3
    8000450c:	00f507b3          	add	a5,a0,a5
    80004510:	00e6e733          	or	a4,a3,a4
    80004514:	000e089b          	sext.w	a7,t3
    80004518:	00f806b3          	add	a3,a6,a5
    8000451c:	00e7b023          	sd	a4,0(a5)
    80004520:	00878793          	addi	a5,a5,8
    80004524:	fed79ce3          	bne	a5,a3,8000451c <__memset+0xd4>
    80004528:	ff8e7793          	andi	a5,t3,-8
    8000452c:	0007871b          	sext.w	a4,a5
    80004530:	01d787bb          	addw	a5,a5,t4
    80004534:	0ce88e63          	beq	a7,a4,80004610 <__memset+0x1c8>
    80004538:	00f50733          	add	a4,a0,a5
    8000453c:	00b70023          	sb	a1,0(a4)
    80004540:	0017871b          	addiw	a4,a5,1
    80004544:	0cc77663          	bgeu	a4,a2,80004610 <__memset+0x1c8>
    80004548:	00e50733          	add	a4,a0,a4
    8000454c:	00b70023          	sb	a1,0(a4)
    80004550:	0027871b          	addiw	a4,a5,2
    80004554:	0ac77e63          	bgeu	a4,a2,80004610 <__memset+0x1c8>
    80004558:	00e50733          	add	a4,a0,a4
    8000455c:	00b70023          	sb	a1,0(a4)
    80004560:	0037871b          	addiw	a4,a5,3
    80004564:	0ac77663          	bgeu	a4,a2,80004610 <__memset+0x1c8>
    80004568:	00e50733          	add	a4,a0,a4
    8000456c:	00b70023          	sb	a1,0(a4)
    80004570:	0047871b          	addiw	a4,a5,4
    80004574:	08c77e63          	bgeu	a4,a2,80004610 <__memset+0x1c8>
    80004578:	00e50733          	add	a4,a0,a4
    8000457c:	00b70023          	sb	a1,0(a4)
    80004580:	0057871b          	addiw	a4,a5,5
    80004584:	08c77663          	bgeu	a4,a2,80004610 <__memset+0x1c8>
    80004588:	00e50733          	add	a4,a0,a4
    8000458c:	00b70023          	sb	a1,0(a4)
    80004590:	0067871b          	addiw	a4,a5,6
    80004594:	06c77e63          	bgeu	a4,a2,80004610 <__memset+0x1c8>
    80004598:	00e50733          	add	a4,a0,a4
    8000459c:	00b70023          	sb	a1,0(a4)
    800045a0:	0077871b          	addiw	a4,a5,7
    800045a4:	06c77663          	bgeu	a4,a2,80004610 <__memset+0x1c8>
    800045a8:	00e50733          	add	a4,a0,a4
    800045ac:	00b70023          	sb	a1,0(a4)
    800045b0:	0087871b          	addiw	a4,a5,8
    800045b4:	04c77e63          	bgeu	a4,a2,80004610 <__memset+0x1c8>
    800045b8:	00e50733          	add	a4,a0,a4
    800045bc:	00b70023          	sb	a1,0(a4)
    800045c0:	0097871b          	addiw	a4,a5,9
    800045c4:	04c77663          	bgeu	a4,a2,80004610 <__memset+0x1c8>
    800045c8:	00e50733          	add	a4,a0,a4
    800045cc:	00b70023          	sb	a1,0(a4)
    800045d0:	00a7871b          	addiw	a4,a5,10
    800045d4:	02c77e63          	bgeu	a4,a2,80004610 <__memset+0x1c8>
    800045d8:	00e50733          	add	a4,a0,a4
    800045dc:	00b70023          	sb	a1,0(a4)
    800045e0:	00b7871b          	addiw	a4,a5,11
    800045e4:	02c77663          	bgeu	a4,a2,80004610 <__memset+0x1c8>
    800045e8:	00e50733          	add	a4,a0,a4
    800045ec:	00b70023          	sb	a1,0(a4)
    800045f0:	00c7871b          	addiw	a4,a5,12
    800045f4:	00c77e63          	bgeu	a4,a2,80004610 <__memset+0x1c8>
    800045f8:	00e50733          	add	a4,a0,a4
    800045fc:	00b70023          	sb	a1,0(a4)
    80004600:	00d7879b          	addiw	a5,a5,13
    80004604:	00c7f663          	bgeu	a5,a2,80004610 <__memset+0x1c8>
    80004608:	00f507b3          	add	a5,a0,a5
    8000460c:	00b78023          	sb	a1,0(a5)
    80004610:	00813403          	ld	s0,8(sp)
    80004614:	01010113          	addi	sp,sp,16
    80004618:	00008067          	ret
    8000461c:	00b00693          	li	a3,11
    80004620:	e55ff06f          	j	80004474 <__memset+0x2c>
    80004624:	00300e93          	li	t4,3
    80004628:	ea5ff06f          	j	800044cc <__memset+0x84>
    8000462c:	00100e93          	li	t4,1
    80004630:	e9dff06f          	j	800044cc <__memset+0x84>
    80004634:	00000e93          	li	t4,0
    80004638:	e95ff06f          	j	800044cc <__memset+0x84>
    8000463c:	00000793          	li	a5,0
    80004640:	ef9ff06f          	j	80004538 <__memset+0xf0>
    80004644:	00200e93          	li	t4,2
    80004648:	e85ff06f          	j	800044cc <__memset+0x84>
    8000464c:	00400e93          	li	t4,4
    80004650:	e7dff06f          	j	800044cc <__memset+0x84>
    80004654:	00500e93          	li	t4,5
    80004658:	e75ff06f          	j	800044cc <__memset+0x84>
    8000465c:	00600e93          	li	t4,6
    80004660:	e6dff06f          	j	800044cc <__memset+0x84>

0000000080004664 <__memmove>:
    80004664:	ff010113          	addi	sp,sp,-16
    80004668:	00813423          	sd	s0,8(sp)
    8000466c:	01010413          	addi	s0,sp,16
    80004670:	0e060863          	beqz	a2,80004760 <__memmove+0xfc>
    80004674:	fff6069b          	addiw	a3,a2,-1
    80004678:	0006881b          	sext.w	a6,a3
    8000467c:	0ea5e863          	bltu	a1,a0,8000476c <__memmove+0x108>
    80004680:	00758713          	addi	a4,a1,7
    80004684:	00a5e7b3          	or	a5,a1,a0
    80004688:	40a70733          	sub	a4,a4,a0
    8000468c:	0077f793          	andi	a5,a5,7
    80004690:	00f73713          	sltiu	a4,a4,15
    80004694:	00174713          	xori	a4,a4,1
    80004698:	0017b793          	seqz	a5,a5
    8000469c:	00e7f7b3          	and	a5,a5,a4
    800046a0:	10078863          	beqz	a5,800047b0 <__memmove+0x14c>
    800046a4:	00900793          	li	a5,9
    800046a8:	1107f463          	bgeu	a5,a6,800047b0 <__memmove+0x14c>
    800046ac:	0036581b          	srliw	a6,a2,0x3
    800046b0:	fff8081b          	addiw	a6,a6,-1
    800046b4:	02081813          	slli	a6,a6,0x20
    800046b8:	01d85893          	srli	a7,a6,0x1d
    800046bc:	00858813          	addi	a6,a1,8
    800046c0:	00058793          	mv	a5,a1
    800046c4:	00050713          	mv	a4,a0
    800046c8:	01088833          	add	a6,a7,a6
    800046cc:	0007b883          	ld	a7,0(a5)
    800046d0:	00878793          	addi	a5,a5,8
    800046d4:	00870713          	addi	a4,a4,8
    800046d8:	ff173c23          	sd	a7,-8(a4)
    800046dc:	ff0798e3          	bne	a5,a6,800046cc <__memmove+0x68>
    800046e0:	ff867713          	andi	a4,a2,-8
    800046e4:	02071793          	slli	a5,a4,0x20
    800046e8:	0207d793          	srli	a5,a5,0x20
    800046ec:	00f585b3          	add	a1,a1,a5
    800046f0:	40e686bb          	subw	a3,a3,a4
    800046f4:	00f507b3          	add	a5,a0,a5
    800046f8:	06e60463          	beq	a2,a4,80004760 <__memmove+0xfc>
    800046fc:	0005c703          	lbu	a4,0(a1)
    80004700:	00e78023          	sb	a4,0(a5)
    80004704:	04068e63          	beqz	a3,80004760 <__memmove+0xfc>
    80004708:	0015c603          	lbu	a2,1(a1)
    8000470c:	00100713          	li	a4,1
    80004710:	00c780a3          	sb	a2,1(a5)
    80004714:	04e68663          	beq	a3,a4,80004760 <__memmove+0xfc>
    80004718:	0025c603          	lbu	a2,2(a1)
    8000471c:	00200713          	li	a4,2
    80004720:	00c78123          	sb	a2,2(a5)
    80004724:	02e68e63          	beq	a3,a4,80004760 <__memmove+0xfc>
    80004728:	0035c603          	lbu	a2,3(a1)
    8000472c:	00300713          	li	a4,3
    80004730:	00c781a3          	sb	a2,3(a5)
    80004734:	02e68663          	beq	a3,a4,80004760 <__memmove+0xfc>
    80004738:	0045c603          	lbu	a2,4(a1)
    8000473c:	00400713          	li	a4,4
    80004740:	00c78223          	sb	a2,4(a5)
    80004744:	00e68e63          	beq	a3,a4,80004760 <__memmove+0xfc>
    80004748:	0055c603          	lbu	a2,5(a1)
    8000474c:	00500713          	li	a4,5
    80004750:	00c782a3          	sb	a2,5(a5)
    80004754:	00e68663          	beq	a3,a4,80004760 <__memmove+0xfc>
    80004758:	0065c703          	lbu	a4,6(a1)
    8000475c:	00e78323          	sb	a4,6(a5)
    80004760:	00813403          	ld	s0,8(sp)
    80004764:	01010113          	addi	sp,sp,16
    80004768:	00008067          	ret
    8000476c:	02061713          	slli	a4,a2,0x20
    80004770:	02075713          	srli	a4,a4,0x20
    80004774:	00e587b3          	add	a5,a1,a4
    80004778:	f0f574e3          	bgeu	a0,a5,80004680 <__memmove+0x1c>
    8000477c:	02069613          	slli	a2,a3,0x20
    80004780:	02065613          	srli	a2,a2,0x20
    80004784:	fff64613          	not	a2,a2
    80004788:	00e50733          	add	a4,a0,a4
    8000478c:	00c78633          	add	a2,a5,a2
    80004790:	fff7c683          	lbu	a3,-1(a5)
    80004794:	fff78793          	addi	a5,a5,-1
    80004798:	fff70713          	addi	a4,a4,-1
    8000479c:	00d70023          	sb	a3,0(a4)
    800047a0:	fec798e3          	bne	a5,a2,80004790 <__memmove+0x12c>
    800047a4:	00813403          	ld	s0,8(sp)
    800047a8:	01010113          	addi	sp,sp,16
    800047ac:	00008067          	ret
    800047b0:	02069713          	slli	a4,a3,0x20
    800047b4:	02075713          	srli	a4,a4,0x20
    800047b8:	00170713          	addi	a4,a4,1
    800047bc:	00e50733          	add	a4,a0,a4
    800047c0:	00050793          	mv	a5,a0
    800047c4:	0005c683          	lbu	a3,0(a1)
    800047c8:	00178793          	addi	a5,a5,1
    800047cc:	00158593          	addi	a1,a1,1
    800047d0:	fed78fa3          	sb	a3,-1(a5)
    800047d4:	fee798e3          	bne	a5,a4,800047c4 <__memmove+0x160>
    800047d8:	f89ff06f          	j	80004760 <__memmove+0xfc>

00000000800047dc <__putc>:
    800047dc:	fe010113          	addi	sp,sp,-32
    800047e0:	00813823          	sd	s0,16(sp)
    800047e4:	00113c23          	sd	ra,24(sp)
    800047e8:	02010413          	addi	s0,sp,32
    800047ec:	00050793          	mv	a5,a0
    800047f0:	fef40593          	addi	a1,s0,-17
    800047f4:	00100613          	li	a2,1
    800047f8:	00000513          	li	a0,0
    800047fc:	fef407a3          	sb	a5,-17(s0)
    80004800:	fffff097          	auipc	ra,0xfffff
    80004804:	b3c080e7          	jalr	-1220(ra) # 8000333c <console_write>
    80004808:	01813083          	ld	ra,24(sp)
    8000480c:	01013403          	ld	s0,16(sp)
    80004810:	02010113          	addi	sp,sp,32
    80004814:	00008067          	ret

0000000080004818 <__getc>:
    80004818:	fe010113          	addi	sp,sp,-32
    8000481c:	00813823          	sd	s0,16(sp)
    80004820:	00113c23          	sd	ra,24(sp)
    80004824:	02010413          	addi	s0,sp,32
    80004828:	fe840593          	addi	a1,s0,-24
    8000482c:	00100613          	li	a2,1
    80004830:	00000513          	li	a0,0
    80004834:	fffff097          	auipc	ra,0xfffff
    80004838:	ae8080e7          	jalr	-1304(ra) # 8000331c <console_read>
    8000483c:	fe844503          	lbu	a0,-24(s0)
    80004840:	01813083          	ld	ra,24(sp)
    80004844:	01013403          	ld	s0,16(sp)
    80004848:	02010113          	addi	sp,sp,32
    8000484c:	00008067          	ret

0000000080004850 <console_handler>:
    80004850:	fe010113          	addi	sp,sp,-32
    80004854:	00813823          	sd	s0,16(sp)
    80004858:	00113c23          	sd	ra,24(sp)
    8000485c:	00913423          	sd	s1,8(sp)
    80004860:	02010413          	addi	s0,sp,32
    80004864:	14202773          	csrr	a4,scause
    80004868:	100027f3          	csrr	a5,sstatus
    8000486c:	0027f793          	andi	a5,a5,2
    80004870:	06079e63          	bnez	a5,800048ec <console_handler+0x9c>
    80004874:	00074c63          	bltz	a4,8000488c <console_handler+0x3c>
    80004878:	01813083          	ld	ra,24(sp)
    8000487c:	01013403          	ld	s0,16(sp)
    80004880:	00813483          	ld	s1,8(sp)
    80004884:	02010113          	addi	sp,sp,32
    80004888:	00008067          	ret
    8000488c:	0ff77713          	andi	a4,a4,255
    80004890:	00900793          	li	a5,9
    80004894:	fef712e3          	bne	a4,a5,80004878 <console_handler+0x28>
    80004898:	ffffe097          	auipc	ra,0xffffe
    8000489c:	6dc080e7          	jalr	1756(ra) # 80002f74 <plic_claim>
    800048a0:	00a00793          	li	a5,10
    800048a4:	00050493          	mv	s1,a0
    800048a8:	02f50c63          	beq	a0,a5,800048e0 <console_handler+0x90>
    800048ac:	fc0506e3          	beqz	a0,80004878 <console_handler+0x28>
    800048b0:	00050593          	mv	a1,a0
    800048b4:	00001517          	auipc	a0,0x1
    800048b8:	90450513          	addi	a0,a0,-1788 # 800051b8 <CONSOLE_STATUS+0x1a0>
    800048bc:	fffff097          	auipc	ra,0xfffff
    800048c0:	afc080e7          	jalr	-1284(ra) # 800033b8 <__printf>
    800048c4:	01013403          	ld	s0,16(sp)
    800048c8:	01813083          	ld	ra,24(sp)
    800048cc:	00048513          	mv	a0,s1
    800048d0:	00813483          	ld	s1,8(sp)
    800048d4:	02010113          	addi	sp,sp,32
    800048d8:	ffffe317          	auipc	t1,0xffffe
    800048dc:	6d430067          	jr	1748(t1) # 80002fac <plic_complete>
    800048e0:	fffff097          	auipc	ra,0xfffff
    800048e4:	3e0080e7          	jalr	992(ra) # 80003cc0 <uartintr>
    800048e8:	fddff06f          	j	800048c4 <console_handler+0x74>
    800048ec:	00001517          	auipc	a0,0x1
    800048f0:	9cc50513          	addi	a0,a0,-1588 # 800052b8 <digits+0x78>
    800048f4:	fffff097          	auipc	ra,0xfffff
    800048f8:	a68080e7          	jalr	-1432(ra) # 8000335c <panic>
	...
