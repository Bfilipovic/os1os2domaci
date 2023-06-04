
kernel:     file format elf64-littleriscv


Disassembly of section .text:

0000000080000000 <_entry>:
    80000000:	00005117          	auipc	sp,0x5
    80000004:	3c013103          	ld	sp,960(sp) # 800053c0 <_GLOBAL_OFFSET_TABLE_+0x10>
    80000008:	00001537          	lui	a0,0x1
    8000000c:	f14025f3          	csrr	a1,mhartid
    80000010:	00158593          	addi	a1,a1,1
    80000014:	02b50533          	mul	a0,a0,a1
    80000018:	00a10133          	add	sp,sp,a0
    8000001c:	25c020ef          	jal	ra,80002278 <start>

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
    80001084:	4b0000ef          	jal	ra,80001534 <handleSupervisorTrap>

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
    80001144:	2f078793          	addi	a5,a5,752 # 80005430 <semaphores>
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
    80001198:	29c70713          	addi	a4,a4,668 # 80005430 <semaphores>
    8000119c:	00d70733          	add	a4,a4,a3
    800011a0:	00472683          	lw	a3,4(a4)
    800011a4:	00100713          	li	a4,1
    800011a8:	fce69ee3          	bne	a3,a4,80001184 <kern_sem_open+0x14>
            semaphores[i].status=SEM_USED;
    800011ac:	00479793          	slli	a5,a5,0x4
    800011b0:	00004717          	auipc	a4,0x4
    800011b4:	28070713          	addi	a4,a4,640 # 80005430 <semaphores>
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
    8000120c:	04e7a423          	sw	a4,72(a5)
            thread_t prev=curr;
            curr=curr->sem_next;
    80001210:	0507b703          	ld	a4,80(a5)
            prev->sem_next=0;
    80001214:	0407b823          	sd	zero,80(a5)
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
    80001264:	05073783          	ld	a5,80(a4)
    80001268:	00f53423          	sd	a5,8(a0)
        woken->syscall_retval=0;
    8000126c:	04073023          	sd	zero,64(a4)
        woken->status=READY;
    80001270:	00200793          	li	a5,2
    80001274:	04f72423          	sw	a5,72(a4)
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
    800012b0:	14c6b683          	ld	a3,332(a3) # 800053f8 <running>
    800012b4:	00300793          	li	a5,3
    800012b8:	04f6a423          	sw	a5,72(a3)
        if(id->waiting_thread==0) id->waiting_thread=running;
    800012bc:	00853783          	ld	a5,8(a0)
    800012c0:	02078063          	beqz	a5,800012e0 <kern_sem_wait+0x64>
            while (curr->sem_next!=0) curr=curr->sem_next;
    800012c4:	00078713          	mv	a4,a5
    800012c8:	0507b783          	ld	a5,80(a5)
    800012cc:	fe079ce3          	bnez	a5,800012c4 <kern_sem_wait+0x48>
            curr->sem_next=running;
    800012d0:	04d73823          	sd	a3,80(a4)
        running->sem_next=0;
    800012d4:	0406b823          	sd	zero,80(a3)
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
    800012fc:	0e85b583          	ld	a1,232(a1) # 800053e0 <freeHead>
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
    80001334:	0af6b823          	sd	a5,176(a3) # 800053e0 <freeHead>
    80001338:	fe1ff06f          	j	80001318 <kern_mem_alloc+0x30>
            if(curr==freeHead) freeHead=newFreeBlock;
    8000133c:	00004797          	auipc	a5,0x4
    80001340:	0ab7b223          	sd	a1,164(a5) # 800053e0 <freeHead>
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
    80001394:	0507b783          	ld	a5,80(a5) # 800053e0 <freeHead>
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
    800013c0:	0247b783          	ld	a5,36(a5) # 800053e0 <freeHead>
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
    8000143c:	fae6b423          	sd	a4,-88(a3) # 800053e0 <freeHead>
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
    80001490:	f5478793          	addi	a5,a5,-172 # 800053e0 <freeHead>
    80001494:	00a7b023          	sd	a0,0(a5)
    freeHead->next=0;
    80001498:	00053423          	sd	zero,8(a0)
    freeHead->startingBlock=0;
    8000149c:	00052223          	sw	zero,4(a0)
    freeHead->sizeInBlocks = (end-start)/MEM_BLOCK_SIZE;
    800014a0:	40a58533          	sub	a0,a1,a0
    800014a4:	00655513          	srli	a0,a0,0x6
    800014a8:	0007b783          	ld	a5,0(a5)
    800014ac:	00a7a023          	sw	a0,0(a5)
}
    800014b0:	00813403          	ld	s0,8(sp)
    800014b4:	01010113          	addi	sp,sp,16
    800014b8:	00008067          	ret

00000000800014bc <kern_syscall>:

uint64 SYSTEM_TIME;


uint64 kern_syscall(enum SyscallNumber num, ...)
{
    800014bc:	fb010113          	addi	sp,sp,-80
    800014c0:	00813423          	sd	s0,8(sp)
    800014c4:	01010413          	addi	s0,sp,16
    800014c8:	00b43423          	sd	a1,8(s0)
    800014cc:	00c43823          	sd	a2,16(s0)
    800014d0:	00d43c23          	sd	a3,24(s0)
    800014d4:	02e43023          	sd	a4,32(s0)
    800014d8:	02f43423          	sd	a5,40(s0)
    800014dc:	03043823          	sd	a6,48(s0)
    800014e0:	03143c23          	sd	a7,56(s0)
    __asm__ volatile ("ecall");
    800014e4:	00000073          	ecall
    return  running->syscall_retval;
}
    800014e8:	00004797          	auipc	a5,0x4
    800014ec:	f107b783          	ld	a5,-240(a5) # 800053f8 <running>
    800014f0:	0407b503          	ld	a0,64(a5)
    800014f4:	00813403          	ld	s0,8(sp)
    800014f8:	05010113          	addi	sp,sp,80
    800014fc:	00008067          	ret

0000000080001500 <kern_interrupt_init>:

void kern_interrupt_init()
{
    80001500:	ff010113          	addi	sp,sp,-16
    80001504:	00813423          	sd	s0,8(sp)
    80001508:	01010413          	addi	s0,sp,16
    SYSTEM_TIME=0;
    8000150c:	00004797          	auipc	a5,0x4
    80001510:	ee07b223          	sd	zero,-284(a5) # 800053f0 <SYSTEM_TIME>
    w_stvec((uint64) &supervisorTrap);
    80001514:	00000797          	auipc	a5,0x0
    80001518:	aec78793          	addi	a5,a5,-1300 # 80001000 <supervisorTrap>
    return stvec;
}

inline void w_stvec(uint64 stvec)
{
    __asm__ volatile ("csrw stvec, %[stvec]" : : [stvec] "r"(stvec));
    8000151c:	10579073          	csrw	stvec,a5
    __asm__ volatile ("csrw sip, %[sip]" : : [sip] "r"(sip));
}

inline void ms_sstatus(uint64 mask)
{
    __asm__ volatile ("csrs sstatus, %[mask]" : : [mask] "r"(mask));
    80001520:	00200793          	li	a5,2
    80001524:	1007a073          	csrs	sstatus,a5
    ms_sstatus(SSTATUS_SIE);
}
    80001528:	00813403          	ld	s0,8(sp)
    8000152c:	01010113          	addi	sp,sp,16
    80001530:	00008067          	ret

0000000080001534 <handleSupervisorTrap>:


int time=0;

void handleSupervisorTrap()
{
    80001534:	f5010113          	addi	sp,sp,-176
    80001538:	0a113423          	sd	ra,168(sp)
    8000153c:	0a813023          	sd	s0,160(sp)
    80001540:	08913c23          	sd	s1,152(sp)
    80001544:	09213823          	sd	s2,144(sp)
    80001548:	0b010413          	addi	s0,sp,176
    uint64  a0,a1,a2,a3,a4;
    __asm__ volatile ("mv %[a0], a0" : [a0] "=r"(a0));
    8000154c:	00050793          	mv	a5,a0
    __asm__ volatile ("mv %[a1], a1" : [a1] "=r"(a1));
    80001550:	00058493          	mv	s1,a1
    __asm__ volatile ("mv %[a2], a2" : [a2] "=r"(a2));
    80001554:	00060913          	mv	s2,a2
    __asm__ volatile ("mv %[a3], a3" : [a3] "=r"(a3));
    80001558:	00068613          	mv	a2,a3
    __asm__ volatile ("mv %[a4], a4" : [a4] "=r"(a4));
    8000155c:	00070693          	mv	a3,a4
    __asm__ volatile ("csrr %[scause], scause" : [scause] "=r"(scause));
    80001560:	14202773          	csrr	a4,scause
    80001564:	f8e43823          	sd	a4,-112(s0)
    return scause;
    80001568:	f9043703          	ld	a4,-112(s0)
    uint64  scause = r_scause();
    if (scause == INTR_USER_ECALL || scause == INTR_KERNEL_ECALL)
    8000156c:	ff870513          	addi	a0,a4,-8
    80001570:	00100593          	li	a1,1
    80001574:	02a5fe63          	bgeu	a1,a0,800015b0 <handleSupervisorTrap+0x7c>


        }

    }
    else if (scause == INTR_TIMER)
    80001578:	fff00793          	li	a5,-1
    8000157c:	03f79793          	slli	a5,a5,0x3f
    80001580:	00178793          	addi	a5,a5,1
    80001584:	26f70063          	beq	a4,a5,800017e4 <handleSupervisorTrap+0x2b0>
            //__putc('0'+running->id);
            //__putc(')');
        }

    }
    else if (scause == INTR_CONSOLE)
    80001588:	fff00793          	li	a5,-1
    8000158c:	03f79793          	slli	a5,a5,0x3f
    80001590:	00978793          	addi	a5,a5,9
    80001594:	2cf70a63          	beq	a4,a5,80001868 <handleSupervisorTrap+0x334>
    }
    else
    {
        // unexpected trap cause
    }
}
    80001598:	0a813083          	ld	ra,168(sp)
    8000159c:	0a013403          	ld	s0,160(sp)
    800015a0:	09813483          	ld	s1,152(sp)
    800015a4:	09013903          	ld	s2,144(sp)
    800015a8:	0b010113          	addi	sp,sp,176
    800015ac:	00008067          	ret
    __asm__ volatile ("csrr %[sepc], sepc" : [sepc] "=r"(sepc));
    800015b0:	14102773          	csrr	a4,sepc
    800015b4:	f8e43c23          	sd	a4,-104(s0)
    return sepc;
    800015b8:	f9843703          	ld	a4,-104(s0)
        uint64   sepc = r_sepc() + 4;
    800015bc:	00470713          	addi	a4,a4,4
    __asm__ volatile ("csrw sepc, %[sepc]" : : [sepc] "r"(sepc));
    800015c0:	14171073          	csrw	sepc,a4
        switch (syscall_num) {
    800015c4:	02400713          	li	a4,36
    800015c8:	fcf768e3          	bltu	a4,a5,80001598 <handleSupervisorTrap+0x64>
    800015cc:	00279793          	slli	a5,a5,0x2
    800015d0:	00004717          	auipc	a4,0x4
    800015d4:	a5070713          	addi	a4,a4,-1456 # 80005020 <CONSOLE_STATUS+0x8>
    800015d8:	00e787b3          	add	a5,a5,a4
    800015dc:	0007a783          	lw	a5,0(a5)
    800015e0:	00e787b3          	add	a5,a5,a4
    800015e4:	00078067          	jr	a5
                running->syscall_retval=(uint64)kern_mem_alloc(size);
    800015e8:	0004851b          	sext.w	a0,s1
    800015ec:	00000097          	auipc	ra,0x0
    800015f0:	cfc080e7          	jalr	-772(ra) # 800012e8 <kern_mem_alloc>
    800015f4:	00004797          	auipc	a5,0x4
    800015f8:	e047b783          	ld	a5,-508(a5) # 800053f8 <running>
    800015fc:	04a7b023          	sd	a0,64(a5)
                break;
    80001600:	f99ff06f          	j	80001598 <handleSupervisorTrap+0x64>
                running->syscall_retval=(uint64) kern_mem_free((void*)addr);
    80001604:	00048513          	mv	a0,s1
    80001608:	00000097          	auipc	ra,0x0
    8000160c:	da4080e7          	jalr	-604(ra) # 800013ac <kern_mem_free>
    80001610:	00004797          	auipc	a5,0x4
    80001614:	de87b783          	ld	a5,-536(a5) # 800053f8 <running>
    80001618:	04a7b023          	sd	a0,64(a5)
                break;
    8000161c:	f7dff06f          	j	80001598 <handleSupervisorTrap+0x64>
                running->syscall_retval=(uint64) kern_thread_create((thread_t*)handle,
    80001620:	00090593          	mv	a1,s2
    80001624:	00048513          	mv	a0,s1
    80001628:	00000097          	auipc	ra,0x0
    8000162c:	5f4080e7          	jalr	1524(ra) # 80001c1c <kern_thread_create>
    80001630:	00004797          	auipc	a5,0x4
    80001634:	dc87b783          	ld	a5,-568(a5) # 800053f8 <running>
    80001638:	04a7b023          	sd	a0,64(a5)
                (*(thread_t*)handle)->endTime=SYSTEM_TIME+DEFAULT_TIME_SLICE;
    8000163c:	0004b703          	ld	a4,0(s1)
    80001640:	00004797          	auipc	a5,0x4
    80001644:	db07b783          	ld	a5,-592(a5) # 800053f0 <SYSTEM_TIME>
    80001648:	00278793          	addi	a5,a5,2
    8000164c:	02f73c23          	sd	a5,56(a4)
                break;
    80001650:	f49ff06f          	j	80001598 <handleSupervisorTrap+0x64>
}

inline uint64 r_sstatus()
{
    uint64 volatile sstatus;
    __asm__ volatile ("csrr %[sstatus], sstatus" : [sstatus] "=r"(sstatus));
    80001654:	100027f3          	csrr	a5,sstatus
    80001658:	faf43423          	sd	a5,-88(s0)
    return sstatus;
    8000165c:	fa843783          	ld	a5,-88(s0)
                uint64 volatile sstatus = r_sstatus();
    80001660:	f4f43823          	sd	a5,-176(s0)
    __asm__ volatile ("csrr %[sepc], sepc" : [sepc] "=r"(sepc));
    80001664:	141027f3          	csrr	a5,sepc
    80001668:	faf43023          	sd	a5,-96(s0)
    return sepc;
    8000166c:	fa043783          	ld	a5,-96(s0)
                uint64 volatile v_sepc = r_sepc();
    80001670:	f4f43c23          	sd	a5,-168(s0)
                kern_thread_dispatch();
    80001674:	00000097          	auipc	ra,0x0
    80001678:	450080e7          	jalr	1104(ra) # 80001ac4 <kern_thread_dispatch>
                w_sstatus(sstatus);
    8000167c:	f5043783          	ld	a5,-176(s0)
}

inline void w_sstatus(uint64 sstatus)
{
    __asm__ volatile ("csrw sstatus, %[sstatus]" : : [sstatus] "r"(sstatus));
    80001680:	10079073          	csrw	sstatus,a5
                w_sepc(v_sepc);
    80001684:	f5843783          	ld	a5,-168(s0)
    __asm__ volatile ("csrw sepc, %[sepc]" : : [sepc] "r"(sepc));
    80001688:	14179073          	csrw	sepc,a5
                running->endTime=time+running->timeslice;
    8000168c:	00004717          	auipc	a4,0x4
    80001690:	d6c73703          	ld	a4,-660(a4) # 800053f8 <running>
    80001694:	03073683          	ld	a3,48(a4)
    80001698:	00004797          	auipc	a5,0x4
    8000169c:	d507a783          	lw	a5,-688(a5) # 800053e8 <time>
    800016a0:	00d787b3          	add	a5,a5,a3
    800016a4:	02f73c23          	sd	a5,56(a4)
                break;
    800016a8:	ef1ff06f          	j	80001598 <handleSupervisorTrap+0x64>
    __asm__ volatile ("csrr %[sstatus], sstatus" : [sstatus] "=r"(sstatus));
    800016ac:	100027f3          	csrr	a5,sstatus
    800016b0:	faf43c23          	sd	a5,-72(s0)
    return sstatus;
    800016b4:	fb843783          	ld	a5,-72(s0)
                uint64 volatile sstatus = r_sstatus();
    800016b8:	f6f43023          	sd	a5,-160(s0)
    __asm__ volatile ("csrr %[sepc], sepc" : [sepc] "=r"(sepc));
    800016bc:	141027f3          	csrr	a5,sepc
    800016c0:	faf43823          	sd	a5,-80(s0)
    return sepc;
    800016c4:	fb043783          	ld	a5,-80(s0)
                uint64 volatile v_sepc = r_sepc();
    800016c8:	f6f43423          	sd	a5,-152(s0)
                kern_thread_join(handle);
    800016cc:	00048513          	mv	a0,s1
    800016d0:	00000097          	auipc	ra,0x0
    800016d4:	618080e7          	jalr	1560(ra) # 80001ce8 <kern_thread_join>
                w_sstatus(sstatus);
    800016d8:	f6043783          	ld	a5,-160(s0)
    __asm__ volatile ("csrw sstatus, %[sstatus]" : : [sstatus] "r"(sstatus));
    800016dc:	10079073          	csrw	sstatus,a5
                w_sepc(v_sepc);
    800016e0:	f6843783          	ld	a5,-152(s0)
    __asm__ volatile ("csrw sepc, %[sepc]" : : [sepc] "r"(sepc));
    800016e4:	14179073          	csrw	sepc,a5
                running->endTime=time+running->timeslice;
    800016e8:	00004717          	auipc	a4,0x4
    800016ec:	d1073703          	ld	a4,-752(a4) # 800053f8 <running>
    800016f0:	03073683          	ld	a3,48(a4)
    800016f4:	00004797          	auipc	a5,0x4
    800016f8:	cf47a783          	lw	a5,-780(a5) # 800053e8 <time>
    800016fc:	00d787b3          	add	a5,a5,a3
    80001700:	02f73c23          	sd	a5,56(a4)
                break;
    80001704:	e95ff06f          	j	80001598 <handleSupervisorTrap+0x64>
                kern_thread_end_running();
    80001708:	00000097          	auipc	ra,0x0
    8000170c:	430080e7          	jalr	1072(ra) # 80001b38 <kern_thread_end_running>
                running->syscall_retval = kern_sem_open(handle,init);
    80001710:	0009059b          	sext.w	a1,s2
    80001714:	00048513          	mv	a0,s1
    80001718:	00000097          	auipc	ra,0x0
    8000171c:	a58080e7          	jalr	-1448(ra) # 80001170 <kern_sem_open>
    80001720:	00004797          	auipc	a5,0x4
    80001724:	cd87b783          	ld	a5,-808(a5) # 800053f8 <running>
    80001728:	04a7b023          	sd	a0,64(a5)
                break;
    8000172c:	e6dff06f          	j	80001598 <handleSupervisorTrap+0x64>
                running->syscall_retval = kern_sem_close(handle);
    80001730:	00048513          	mv	a0,s1
    80001734:	00000097          	auipc	ra,0x0
    80001738:	aac080e7          	jalr	-1364(ra) # 800011e0 <kern_sem_close>
    8000173c:	00004797          	auipc	a5,0x4
    80001740:	cbc7b783          	ld	a5,-836(a5) # 800053f8 <running>
    80001744:	04a7b023          	sd	a0,64(a5)
                break;
    80001748:	e51ff06f          	j	80001598 <handleSupervisorTrap+0x64>
                kern_sem_signal(handle);
    8000174c:	00048513          	mv	a0,s1
    80001750:	00000097          	auipc	ra,0x0
    80001754:	ae4080e7          	jalr	-1308(ra) # 80001234 <kern_sem_signal>
                running->syscall_retval=0;
    80001758:	00004797          	auipc	a5,0x4
    8000175c:	ca07b783          	ld	a5,-864(a5) # 800053f8 <running>
    80001760:	0407b023          	sd	zero,64(a5)
                break;
    80001764:	e35ff06f          	j	80001598 <handleSupervisorTrap+0x64>
                int res = kern_sem_wait(handle);
    80001768:	00048513          	mv	a0,s1
    8000176c:	00000097          	auipc	ra,0x0
    80001770:	b10080e7          	jalr	-1264(ra) # 8000127c <kern_sem_wait>
                if(res==1) running->syscall_retval=0;
    80001774:	00100793          	li	a5,1
    80001778:	00f51a63          	bne	a0,a5,8000178c <handleSupervisorTrap+0x258>
    8000177c:	00004797          	auipc	a5,0x4
    80001780:	c7c7b783          	ld	a5,-900(a5) # 800053f8 <running>
    80001784:	0407b023          	sd	zero,64(a5)
    80001788:	e11ff06f          	j	80001598 <handleSupervisorTrap+0x64>
    __asm__ volatile ("csrr %[sstatus], sstatus" : [sstatus] "=r"(sstatus));
    8000178c:	100027f3          	csrr	a5,sstatus
    80001790:	fcf43423          	sd	a5,-56(s0)
    return sstatus;
    80001794:	fc843783          	ld	a5,-56(s0)
                    uint64 volatile sstatus = r_sstatus();
    80001798:	f6f43823          	sd	a5,-144(s0)
    __asm__ volatile ("csrr %[sepc], sepc" : [sepc] "=r"(sepc));
    8000179c:	141027f3          	csrr	a5,sepc
    800017a0:	fcf43023          	sd	a5,-64(s0)
    return sepc;
    800017a4:	fc043783          	ld	a5,-64(s0)
                    uint64 volatile v_sepc = r_sepc();
    800017a8:	f6f43c23          	sd	a5,-136(s0)
                    kern_thread_dispatch();
    800017ac:	00000097          	auipc	ra,0x0
    800017b0:	318080e7          	jalr	792(ra) # 80001ac4 <kern_thread_dispatch>
                    w_sstatus(sstatus);
    800017b4:	f7043783          	ld	a5,-144(s0)
    __asm__ volatile ("csrw sstatus, %[sstatus]" : : [sstatus] "r"(sstatus));
    800017b8:	10079073          	csrw	sstatus,a5
                    w_sepc(v_sepc);
    800017bc:	f7843783          	ld	a5,-136(s0)
    __asm__ volatile ("csrw sepc, %[sepc]" : : [sepc] "r"(sepc));
    800017c0:	14179073          	csrw	sepc,a5
                    running->endTime=time+running->timeslice;
    800017c4:	00004717          	auipc	a4,0x4
    800017c8:	c3473703          	ld	a4,-972(a4) # 800053f8 <running>
    800017cc:	03073683          	ld	a3,48(a4)
    800017d0:	00004797          	auipc	a5,0x4
    800017d4:	c187a783          	lw	a5,-1000(a5) # 800053e8 <time>
    800017d8:	00d787b3          	add	a5,a5,a3
    800017dc:	02f73c23          	sd	a5,56(a4)
    800017e0:	db9ff06f          	j	80001598 <handleSupervisorTrap+0x64>
        SYSTEM_TIME++;
    800017e4:	00004717          	auipc	a4,0x4
    800017e8:	c0c70713          	addi	a4,a4,-1012 # 800053f0 <SYSTEM_TIME>
    800017ec:	00073783          	ld	a5,0(a4)
    800017f0:	00178793          	addi	a5,a5,1
    800017f4:	00f73023          	sd	a5,0(a4)
    __asm__ volatile ("csrc sip, %[mask]" : : [mask] "r"(mask));
    800017f8:	00200713          	li	a4,2
    800017fc:	14473073          	csrc	sip,a4
        if(SYSTEM_TIME>=running->endTime){
    80001800:	00004717          	auipc	a4,0x4
    80001804:	bf873703          	ld	a4,-1032(a4) # 800053f8 <running>
    80001808:	03873703          	ld	a4,56(a4)
    8000180c:	d8e7e6e3          	bltu	a5,a4,80001598 <handleSupervisorTrap+0x64>
    __asm__ volatile ("csrr %[sstatus], sstatus" : [sstatus] "=r"(sstatus));
    80001810:	100027f3          	csrr	a5,sstatus
    80001814:	fcf43c23          	sd	a5,-40(s0)
    return sstatus;
    80001818:	fd843783          	ld	a5,-40(s0)
            uint64 volatile sstatus = r_sstatus();
    8000181c:	f8f43023          	sd	a5,-128(s0)
    __asm__ volatile ("csrr %[sepc], sepc" : [sepc] "=r"(sepc));
    80001820:	141027f3          	csrr	a5,sepc
    80001824:	fcf43823          	sd	a5,-48(s0)
    return sepc;
    80001828:	fd043783          	ld	a5,-48(s0)
            uint64 volatile v_sepc = r_sepc();
    8000182c:	f8f43423          	sd	a5,-120(s0)
            kern_thread_dispatch();
    80001830:	00000097          	auipc	ra,0x0
    80001834:	294080e7          	jalr	660(ra) # 80001ac4 <kern_thread_dispatch>
            w_sstatus(sstatus);
    80001838:	f8043783          	ld	a5,-128(s0)
    __asm__ volatile ("csrw sstatus, %[sstatus]" : : [sstatus] "r"(sstatus));
    8000183c:	10079073          	csrw	sstatus,a5
            w_sepc(v_sepc);
    80001840:	f8843783          	ld	a5,-120(s0)
    __asm__ volatile ("csrw sepc, %[sepc]" : : [sepc] "r"(sepc));
    80001844:	14179073          	csrw	sepc,a5
            running->endTime=SYSTEM_TIME+running->timeslice;
    80001848:	00004717          	auipc	a4,0x4
    8000184c:	bb073703          	ld	a4,-1104(a4) # 800053f8 <running>
    80001850:	03073783          	ld	a5,48(a4)
    80001854:	00004697          	auipc	a3,0x4
    80001858:	b9c6b683          	ld	a3,-1124(a3) # 800053f0 <SYSTEM_TIME>
    8000185c:	00d787b3          	add	a5,a5,a3
    80001860:	02f73c23          	sd	a5,56(a4)
    80001864:	d35ff06f          	j	80001598 <handleSupervisorTrap+0x64>
        console_handler();
    80001868:	00003097          	auipc	ra,0x3
    8000186c:	b48080e7          	jalr	-1208(ra) # 800043b0 <console_handler>
}
    80001870:	d29ff06f          	j	80001598 <handleSupervisorTrap+0x64>

0000000080001874 <kern_thread_init>:
struct thread_s threads[MAX_THREADS];
static int id;
struct thread_s* running;

void kern_thread_init()
{
    80001874:	ff010113          	addi	sp,sp,-16
    80001878:	00813423          	sd	s0,8(sp)
    8000187c:	01010413          	addi	s0,sp,16
    id=0;
    80001880:	00004797          	auipc	a5,0x4
    80001884:	b807a023          	sw	zero,-1152(a5) # 80005400 <id>
    for (int i=0;i<MAX_THREADS;i++){
    80001888:	00000793          	li	a5,0
    8000188c:	0200006f          	j	800018ac <kern_thread_init+0x38>
        threads[i].status=UNUSED;
    80001890:	05800713          	li	a4,88
    80001894:	02e786b3          	mul	a3,a5,a4
    80001898:	00005717          	auipc	a4,0x5
    8000189c:	b9870713          	addi	a4,a4,-1128 # 80006430 <threads>
    800018a0:	00d70733          	add	a4,a4,a3
    800018a4:	04072423          	sw	zero,72(a4)
    for (int i=0;i<MAX_THREADS;i++){
    800018a8:	0017879b          	addiw	a5,a5,1
    800018ac:	03f00713          	li	a4,63
    800018b0:	fef750e3          	bge	a4,a5,80001890 <kern_thread_init+0x1c>
    }

    //set threads[0] as main thread
    threads[0].status=RUNNING;
    800018b4:	00005797          	auipc	a5,0x5
    800018b8:	b7c78793          	addi	a5,a5,-1156 # 80006430 <threads>
    800018bc:	00100713          	li	a4,1
    800018c0:	04e7a423          	sw	a4,72(a5)
    threads[0].id=0;
    800018c4:	0007b823          	sd	zero,16(a5)
    threads[0].timeslice=DEFAULT_TIME_SLICE+2;
    800018c8:	00400713          	li	a4,4
    800018cc:	02e7b823          	sd	a4,48(a5)
    threads[0].endTime=9999;
    800018d0:	00002737          	lui	a4,0x2
    800018d4:	70f70713          	addi	a4,a4,1807 # 270f <_entry-0x7fffd8f1>
    800018d8:	02e7bc23          	sd	a4,56(a5)
    running=&threads[0];
    800018dc:	00004717          	auipc	a4,0x4
    800018e0:	b0f73e23          	sd	a5,-1252(a4) # 800053f8 <running>
}
    800018e4:	00813403          	ld	s0,8(sp)
    800018e8:	01010113          	addi	sp,sp,16
    800018ec:	00008067          	ret

00000000800018f0 <kern_scheduler_get>:

thread_t kern_scheduler_get()
{
    800018f0:	ff010113          	addi	sp,sp,-16
    800018f4:	00813423          	sd	s0,8(sp)
    800018f8:	01010413          	addi	s0,sp,16
    int num = running-threads;
    800018fc:	00004517          	auipc	a0,0x4
    80001900:	afc53503          	ld	a0,-1284(a0) # 800053f8 <running>
    80001904:	00005797          	auipc	a5,0x5
    80001908:	b2c78793          	addi	a5,a5,-1236 # 80006430 <threads>
    8000190c:	40f507b3          	sub	a5,a0,a5
    80001910:	4037d793          	srai	a5,a5,0x3
    80001914:	00003717          	auipc	a4,0x3
    80001918:	6ec73703          	ld	a4,1772(a4) # 80005000 <console_handler+0xc50>
    8000191c:	02e787bb          	mulw	a5,a5,a4
    for(int i=1;i<=MAX_THREADS;i++){
    80001920:	00100613          	li	a2,1
    80001924:	04000713          	li	a4,64
    80001928:	06c74263          	blt	a4,a2,8000198c <kern_scheduler_get+0x9c>
        num = (num+i)%MAX_THREADS;
    8000192c:	00c787bb          	addw	a5,a5,a2
    80001930:	41f7d71b          	sraiw	a4,a5,0x1f
    80001934:	01a7571b          	srliw	a4,a4,0x1a
    80001938:	00e787bb          	addw	a5,a5,a4
    8000193c:	03f7f793          	andi	a5,a5,63
    80001940:	40e787bb          	subw	a5,a5,a4
        if(threads[num].status==READY) return &threads[num];
    80001944:	05800713          	li	a4,88
    80001948:	02e786b3          	mul	a3,a5,a4
    8000194c:	00005717          	auipc	a4,0x5
    80001950:	ae470713          	addi	a4,a4,-1308 # 80006430 <threads>
    80001954:	00d70733          	add	a4,a4,a3
    80001958:	04872683          	lw	a3,72(a4)
    8000195c:	00200713          	li	a4,2
    80001960:	00e68663          	beq	a3,a4,8000196c <kern_scheduler_get+0x7c>
    for(int i=1;i<=MAX_THREADS;i++){
    80001964:	0016061b          	addiw	a2,a2,1
    80001968:	fbdff06f          	j	80001924 <kern_scheduler_get+0x34>
        if(threads[num].status==READY) return &threads[num];
    8000196c:	05800513          	li	a0,88
    80001970:	02a787b3          	mul	a5,a5,a0
    80001974:	00005517          	auipc	a0,0x5
    80001978:	abc50513          	addi	a0,a0,-1348 # 80006430 <threads>
    8000197c:	00a78533          	add	a0,a5,a0
    }
    if(running->status==READY) return running;
    return 0;
}
    80001980:	00813403          	ld	s0,8(sp)
    80001984:	01010113          	addi	sp,sp,16
    80001988:	00008067          	ret
    if(running->status==READY) return running;
    8000198c:	04852703          	lw	a4,72(a0)
    80001990:	00200793          	li	a5,2
    80001994:	fef706e3          	beq	a4,a5,80001980 <kern_scheduler_get+0x90>
    return 0;
    80001998:	00000513          	li	a0,0
    8000199c:	fe5ff06f          	j	80001980 <kern_scheduler_get+0x90>

00000000800019a0 <kern_thread_yield>:

void kern_thread_yield()
{
    800019a0:	ff010113          	addi	sp,sp,-16
    800019a4:	00113423          	sd	ra,8(sp)
    800019a8:	00813023          	sd	s0,0(sp)
    800019ac:	01010413          	addi	s0,sp,16
    kern_syscall(THREAD_DISPATCH);
    800019b0:	01300513          	li	a0,19
    800019b4:	00000097          	auipc	ra,0x0
    800019b8:	b08080e7          	jalr	-1272(ra) # 800014bc <kern_syscall>
}
    800019bc:	00813083          	ld	ra,8(sp)
    800019c0:	00013403          	ld	s0,0(sp)
    800019c4:	01010113          	addi	sp,sp,16
    800019c8:	00008067          	ret

00000000800019cc <popSppSpie>:

//samo izlazi iz kernela i vraca se odakle je pozvana
void popSppSpie()
{
    800019cc:	ff010113          	addi	sp,sp,-16
    800019d0:	00813423          	sd	s0,8(sp)
    800019d4:	01010413          	addi	s0,sp,16
    __asm__ volatile("csrw sepc, ra"); //ovde dodaj izlazak iz privilegovanog moda
    800019d8:	14109073          	csrw	sepc,ra
    __asm__ volatile("sret");
    800019dc:	10200073          	sret
}
    800019e0:	00813403          	ld	s0,8(sp)
    800019e4:	01010113          	addi	sp,sp,16
    800019e8:	00008067          	ret

00000000800019ec <kern_thread_wrapper>:
        contextSwitch(old,running);
    }
}

void kern_thread_wrapper()
{
    800019ec:	fe010113          	addi	sp,sp,-32
    800019f0:	00113c23          	sd	ra,24(sp)
    800019f4:	00813823          	sd	s0,16(sp)
    800019f8:	00913423          	sd	s1,8(sp)
    800019fc:	02010413          	addi	s0,sp,32
    popSppSpie();
    80001a00:	00000097          	auipc	ra,0x0
    80001a04:	fcc080e7          	jalr	-52(ra) # 800019cc <popSppSpie>
    running->body(running->arg);
    80001a08:	00004497          	auipc	s1,0x4
    80001a0c:	9f048493          	addi	s1,s1,-1552 # 800053f8 <running>
    80001a10:	0004b783          	ld	a5,0(s1)
    80001a14:	0187b703          	ld	a4,24(a5)
    80001a18:	0207b503          	ld	a0,32(a5)
    80001a1c:	000700e7          	jalr	a4
    running->status=UNUSED;
    80001a20:	0004b603          	ld	a2,0(s1)
    80001a24:	04062423          	sw	zero,72(a2)
    running->sem_next=0;
    80001a28:	04063823          	sd	zero,80(a2)
    running->joined_tid=-1;
    80001a2c:	fff00793          	li	a5,-1
    80001a30:	02f63423          	sd	a5,40(a2)
    for(int i=0;i<MAX_THREADS;i++){
    80001a34:	00000793          	li	a5,0
    80001a38:	0080006f          	j	80001a40 <kern_thread_wrapper+0x54>
    80001a3c:	0017879b          	addiw	a5,a5,1
    80001a40:	03f00713          	li	a4,63
    80001a44:	06f74263          	blt	a4,a5,80001aa8 <kern_thread_wrapper+0xbc>
        if(threads[i].status==JOINED && threads[i].joined_tid==running->id) threads[i].status=READY;
    80001a48:	05800713          	li	a4,88
    80001a4c:	02e786b3          	mul	a3,a5,a4
    80001a50:	00005717          	auipc	a4,0x5
    80001a54:	9e070713          	addi	a4,a4,-1568 # 80006430 <threads>
    80001a58:	00d70733          	add	a4,a4,a3
    80001a5c:	04872683          	lw	a3,72(a4)
    80001a60:	00400713          	li	a4,4
    80001a64:	fce69ce3          	bne	a3,a4,80001a3c <kern_thread_wrapper+0x50>
    80001a68:	05800713          	li	a4,88
    80001a6c:	02e786b3          	mul	a3,a5,a4
    80001a70:	00005717          	auipc	a4,0x5
    80001a74:	9c070713          	addi	a4,a4,-1600 # 80006430 <threads>
    80001a78:	00d70733          	add	a4,a4,a3
    80001a7c:	02873683          	ld	a3,40(a4)
    80001a80:	01063703          	ld	a4,16(a2)
    80001a84:	fae69ce3          	bne	a3,a4,80001a3c <kern_thread_wrapper+0x50>
    80001a88:	05800713          	li	a4,88
    80001a8c:	02e786b3          	mul	a3,a5,a4
    80001a90:	00005717          	auipc	a4,0x5
    80001a94:	9a070713          	addi	a4,a4,-1632 # 80006430 <threads>
    80001a98:	00d70733          	add	a4,a4,a3
    80001a9c:	00200693          	li	a3,2
    80001aa0:	04d72423          	sw	a3,72(a4)
    80001aa4:	f99ff06f          	j	80001a3c <kern_thread_wrapper+0x50>
    }
    kern_thread_yield();
    80001aa8:	00000097          	auipc	ra,0x0
    80001aac:	ef8080e7          	jalr	-264(ra) # 800019a0 <kern_thread_yield>
}
    80001ab0:	01813083          	ld	ra,24(sp)
    80001ab4:	01013403          	ld	s0,16(sp)
    80001ab8:	00813483          	ld	s1,8(sp)
    80001abc:	02010113          	addi	sp,sp,32
    80001ac0:	00008067          	ret

0000000080001ac4 <kern_thread_dispatch>:
{
    80001ac4:	fe010113          	addi	sp,sp,-32
    80001ac8:	00113c23          	sd	ra,24(sp)
    80001acc:	00813823          	sd	s0,16(sp)
    80001ad0:	00913423          	sd	s1,8(sp)
    80001ad4:	01213023          	sd	s2,0(sp)
    80001ad8:	02010413          	addi	s0,sp,32
    thread_t old = running;
    80001adc:	00004917          	auipc	s2,0x4
    80001ae0:	91c90913          	addi	s2,s2,-1764 # 800053f8 <running>
    80001ae4:	00093483          	ld	s1,0(s2)
    running=kern_scheduler_get();
    80001ae8:	00000097          	auipc	ra,0x0
    80001aec:	e08080e7          	jalr	-504(ra) # 800018f0 <kern_scheduler_get>
    80001af0:	00a93023          	sd	a0,0(s2)
    if(old!=running){
    80001af4:	02950063          	beq	a0,s1,80001b14 <kern_thread_dispatch+0x50>
    80001af8:	00050593          	mv	a1,a0
        if(old->status==RUNNING) old->status=READY;
    80001afc:	0484a703          	lw	a4,72(s1)
    80001b00:	00100793          	li	a5,1
    80001b04:	02f70463          	beq	a4,a5,80001b2c <kern_thread_dispatch+0x68>
        contextSwitch(old,running);
    80001b08:	00048513          	mv	a0,s1
    80001b0c:	fffff097          	auipc	ra,0xfffff
    80001b10:	604080e7          	jalr	1540(ra) # 80001110 <contextSwitch>
}
    80001b14:	01813083          	ld	ra,24(sp)
    80001b18:	01013403          	ld	s0,16(sp)
    80001b1c:	00813483          	ld	s1,8(sp)
    80001b20:	00013903          	ld	s2,0(sp)
    80001b24:	02010113          	addi	sp,sp,32
    80001b28:	00008067          	ret
        if(old->status==RUNNING) old->status=READY;
    80001b2c:	00200793          	li	a5,2
    80001b30:	04f4a423          	sw	a5,72(s1)
    80001b34:	fd5ff06f          	j	80001b08 <kern_thread_dispatch+0x44>

0000000080001b38 <kern_thread_end_running>:
{
    80001b38:	fe010113          	addi	sp,sp,-32
    80001b3c:	00113c23          	sd	ra,24(sp)
    80001b40:	00813823          	sd	s0,16(sp)
    80001b44:	00913423          	sd	s1,8(sp)
    80001b48:	02010413          	addi	s0,sp,32
    thread_t old = running;
    80001b4c:	00004497          	auipc	s1,0x4
    80001b50:	8ac4b483          	ld	s1,-1876(s1) # 800053f8 <running>
    old->status=UNUSED;
    80001b54:	0404a423          	sw	zero,72(s1)
    for(int i=0;i<MAX_THREADS;i++){
    80001b58:	00000793          	li	a5,0
    80001b5c:	0080006f          	j	80001b64 <kern_thread_end_running+0x2c>
    80001b60:	0017879b          	addiw	a5,a5,1
    80001b64:	03f00713          	li	a4,63
    80001b68:	06f74263          	blt	a4,a5,80001bcc <kern_thread_end_running+0x94>
        if(threads[i].status==JOINED && threads[i].joined_tid==old->id) threads[i].status=READY;
    80001b6c:	05800713          	li	a4,88
    80001b70:	02e786b3          	mul	a3,a5,a4
    80001b74:	00005717          	auipc	a4,0x5
    80001b78:	8bc70713          	addi	a4,a4,-1860 # 80006430 <threads>
    80001b7c:	00d70733          	add	a4,a4,a3
    80001b80:	04872683          	lw	a3,72(a4)
    80001b84:	00400713          	li	a4,4
    80001b88:	fce69ce3          	bne	a3,a4,80001b60 <kern_thread_end_running+0x28>
    80001b8c:	05800713          	li	a4,88
    80001b90:	02e786b3          	mul	a3,a5,a4
    80001b94:	00005717          	auipc	a4,0x5
    80001b98:	89c70713          	addi	a4,a4,-1892 # 80006430 <threads>
    80001b9c:	00d70733          	add	a4,a4,a3
    80001ba0:	02873683          	ld	a3,40(a4)
    80001ba4:	0104b703          	ld	a4,16(s1)
    80001ba8:	fae69ce3          	bne	a3,a4,80001b60 <kern_thread_end_running+0x28>
    80001bac:	05800713          	li	a4,88
    80001bb0:	02e786b3          	mul	a3,a5,a4
    80001bb4:	00005717          	auipc	a4,0x5
    80001bb8:	87c70713          	addi	a4,a4,-1924 # 80006430 <threads>
    80001bbc:	00d70733          	add	a4,a4,a3
    80001bc0:	00200693          	li	a3,2
    80001bc4:	04d72423          	sw	a3,72(a4)
    80001bc8:	f99ff06f          	j	80001b60 <kern_thread_end_running+0x28>
    running=kern_scheduler_get();
    80001bcc:	00000097          	auipc	ra,0x0
    80001bd0:	d24080e7          	jalr	-732(ra) # 800018f0 <kern_scheduler_get>
    80001bd4:	00050593          	mv	a1,a0
    80001bd8:	00004797          	auipc	a5,0x4
    80001bdc:	82a7b023          	sd	a0,-2016(a5) # 800053f8 <running>
    if(old!=running){
    80001be0:	00950e63          	beq	a0,s1,80001bfc <kern_thread_end_running+0xc4>
        if(old->status==RUNNING) old->status=READY;
    80001be4:	0484a703          	lw	a4,72(s1)
    80001be8:	00100793          	li	a5,1
    80001bec:	02f70263          	beq	a4,a5,80001c10 <kern_thread_end_running+0xd8>
        contextSwitch(old,running);
    80001bf0:	00048513          	mv	a0,s1
    80001bf4:	fffff097          	auipc	ra,0xfffff
    80001bf8:	51c080e7          	jalr	1308(ra) # 80001110 <contextSwitch>
}
    80001bfc:	01813083          	ld	ra,24(sp)
    80001c00:	01013403          	ld	s0,16(sp)
    80001c04:	00813483          	ld	s1,8(sp)
    80001c08:	02010113          	addi	sp,sp,32
    80001c0c:	00008067          	ret
        if(old->status==RUNNING) old->status=READY;
    80001c10:	00200793          	li	a5,2
    80001c14:	04f4a423          	sw	a5,72(s1)
    80001c18:	fd9ff06f          	j	80001bf0 <kern_thread_end_running+0xb8>

0000000080001c1c <kern_thread_create>:

int kern_thread_create(thread_t* handle, void(*start_routine)(void*), void* arg, void* stack_space)
{
    80001c1c:	ff010113          	addi	sp,sp,-16
    80001c20:	00813423          	sd	s0,8(sp)
    80001c24:	01010413          	addi	s0,sp,16
    *handle=0;
    80001c28:	00053023          	sd	zero,0(a0)
    thread_t t=&threads[0]; //dodela da bismo sklonili upozorenje
    for(int i=0;i<MAX_THREADS;i++){
    80001c2c:	00000793          	li	a5,0
    80001c30:	03f00713          	li	a4,63
    80001c34:	0af74063          	blt	a4,a5,80001cd4 <kern_thread_create+0xb8>
        if(threads[i].status==UNUSED){
    80001c38:	05800713          	li	a4,88
    80001c3c:	02e78833          	mul	a6,a5,a4
    80001c40:	00004717          	auipc	a4,0x4
    80001c44:	7f070713          	addi	a4,a4,2032 # 80006430 <threads>
    80001c48:	01070733          	add	a4,a4,a6
    80001c4c:	04872703          	lw	a4,72(a4)
    80001c50:	00070663          	beqz	a4,80001c5c <kern_thread_create+0x40>
    for(int i=0;i<MAX_THREADS;i++){
    80001c54:	0017879b          	addiw	a5,a5,1
    80001c58:	fd9ff06f          	j	80001c30 <kern_thread_create+0x14>
            *handle=&threads[i];
    80001c5c:	00004717          	auipc	a4,0x4
    80001c60:	7d470713          	addi	a4,a4,2004 # 80006430 <threads>
    80001c64:	00e807b3          	add	a5,a6,a4
    80001c68:	00f53023          	sd	a5,0(a0)
            t=&threads[i];
            break;
        }
    }
    if(*handle==0) return -1;
    80001c6c:	00053703          	ld	a4,0(a0)
    80001c70:	06070863          	beqz	a4,80001ce0 <kern_thread_create+0xc4>

    t->id=++id;
    80001c74:	00003517          	auipc	a0,0x3
    80001c78:	78c50513          	addi	a0,a0,1932 # 80005400 <id>
    80001c7c:	00052703          	lw	a4,0(a0)
    80001c80:	0017071b          	addiw	a4,a4,1
    80001c84:	0007081b          	sext.w	a6,a4
    80001c88:	00e52023          	sw	a4,0(a0)
    80001c8c:	0107b823          	sd	a6,16(a5)
    t->status=READY;
    80001c90:	00200713          	li	a4,2
    80001c94:	04e7a423          	sw	a4,72(a5)
    t->arg=arg;
    80001c98:	02c7b023          	sd	a2,32(a5)
    t->joined_tid=-1;
    80001c9c:	fff00713          	li	a4,-1
    80001ca0:	02e7b423          	sd	a4,40(a5)
    t->timeslice=DEFAULT_TIME_SLICE;
    80001ca4:	00200713          	li	a4,2
    80001ca8:	02e7b823          	sd	a4,48(a5)
    t->body=start_routine;
    80001cac:	00b7bc23          	sd	a1,24(a5)
    t->sp = ((uint64)stack_space);
    80001cb0:	00d7b423          	sd	a3,8(a5)
    t->ra=(uint64) &kern_thread_wrapper;
    80001cb4:	00000717          	auipc	a4,0x0
    80001cb8:	d3870713          	addi	a4,a4,-712 # 800019ec <kern_thread_wrapper>
    80001cbc:	00e7b023          	sd	a4,0(a5)
    t->sem_next=0;
    80001cc0:	0407b823          	sd	zero,80(a5)

    return 0;
    80001cc4:	00000513          	li	a0,0
}
    80001cc8:	00813403          	ld	s0,8(sp)
    80001ccc:	01010113          	addi	sp,sp,16
    80001cd0:	00008067          	ret
    thread_t t=&threads[0]; //dodela da bismo sklonili upozorenje
    80001cd4:	00004797          	auipc	a5,0x4
    80001cd8:	75c78793          	addi	a5,a5,1884 # 80006430 <threads>
    80001cdc:	f91ff06f          	j	80001c6c <kern_thread_create+0x50>
    if(*handle==0) return -1;
    80001ce0:	fff00513          	li	a0,-1
    80001ce4:	fe5ff06f          	j	80001cc8 <kern_thread_create+0xac>

0000000080001ce8 <kern_thread_join>:

void kern_thread_join(thread_t handle)
{
    80001ce8:	ff010113          	addi	sp,sp,-16
    80001cec:	00113423          	sd	ra,8(sp)
    80001cf0:	00813023          	sd	s0,0(sp)
    80001cf4:	01010413          	addi	s0,sp,16
    running->joined_tid=handle->id;
    80001cf8:	00003797          	auipc	a5,0x3
    80001cfc:	7007b783          	ld	a5,1792(a5) # 800053f8 <running>
    80001d00:	01053703          	ld	a4,16(a0)
    80001d04:	02e7b423          	sd	a4,40(a5)
    running->status=JOINED;
    80001d08:	00400713          	li	a4,4
    80001d0c:	04e7a423          	sw	a4,72(a5)
    kern_thread_dispatch();
    80001d10:	00000097          	auipc	ra,0x0
    80001d14:	db4080e7          	jalr	-588(ra) # 80001ac4 <kern_thread_dispatch>
}
    80001d18:	00813083          	ld	ra,8(sp)
    80001d1c:	00013403          	ld	s0,0(sp)
    80001d20:	01010113          	addi	sp,sp,16
    80001d24:	00008067          	ret

0000000080001d28 <mem_alloc>:
#include "../h/kern_reg_util.h"
#include "../h/kern_interrupts.h"

#include <stdarg.h>

void* mem_alloc (size_t size){
    80001d28:	ff010113          	addi	sp,sp,-16
    80001d2c:	00113423          	sd	ra,8(sp)
    80001d30:	00813023          	sd	s0,0(sp)
    80001d34:	01010413          	addi	s0,sp,16
    uint64 blocks = (size+MEM_BLOCK_SIZE-1)/MEM_BLOCK_SIZE;
    80001d38:	03f50593          	addi	a1,a0,63
    return (void*)kern_syscall(MEM_ALLOC, blocks);
    80001d3c:	0065d593          	srli	a1,a1,0x6
    80001d40:	00100513          	li	a0,1
    80001d44:	fffff097          	auipc	ra,0xfffff
    80001d48:	778080e7          	jalr	1912(ra) # 800014bc <kern_syscall>
}
    80001d4c:	00813083          	ld	ra,8(sp)
    80001d50:	00013403          	ld	s0,0(sp)
    80001d54:	01010113          	addi	sp,sp,16
    80001d58:	00008067          	ret

0000000080001d5c <mem_free>:

int mem_free (void* addr){
    80001d5c:	ff010113          	addi	sp,sp,-16
    80001d60:	00113423          	sd	ra,8(sp)
    80001d64:	00813023          	sd	s0,0(sp)
    80001d68:	01010413          	addi	s0,sp,16
    80001d6c:	00050593          	mv	a1,a0
    return (int) kern_syscall(MEM_FREE,addr);
    80001d70:	00200513          	li	a0,2
    80001d74:	fffff097          	auipc	ra,0xfffff
    80001d78:	748080e7          	jalr	1864(ra) # 800014bc <kern_syscall>
}
    80001d7c:	0005051b          	sext.w	a0,a0
    80001d80:	00813083          	ld	ra,8(sp)
    80001d84:	00013403          	ld	s0,0(sp)
    80001d88:	01010113          	addi	sp,sp,16
    80001d8c:	00008067          	ret

0000000080001d90 <thread_create>:

struct thread_s;
typedef struct thread_s* thread_t;

int thread_create (thread_t* handle, void(*start_routine)(void*), void* arg)
{
    80001d90:	fd010113          	addi	sp,sp,-48
    80001d94:	02113423          	sd	ra,40(sp)
    80001d98:	02813023          	sd	s0,32(sp)
    80001d9c:	00913c23          	sd	s1,24(sp)
    80001da0:	01213823          	sd	s2,16(sp)
    80001da4:	01313423          	sd	s3,8(sp)
    80001da8:	03010413          	addi	s0,sp,48
    80001dac:	00050493          	mv	s1,a0
    80001db0:	00058913          	mv	s2,a1
    80001db4:	00060993          	mv	s3,a2
    void * stack = mem_alloc(DEFAULT_STACK_SIZE);
    80001db8:	00001537          	lui	a0,0x1
    80001dbc:	00000097          	auipc	ra,0x0
    80001dc0:	f6c080e7          	jalr	-148(ra) # 80001d28 <mem_alloc>
    if(stack==0) return -1;
    80001dc4:	04050063          	beqz	a0,80001e04 <thread_create+0x74>
    80001dc8:	00050713          	mv	a4,a0
    return (int) kern_syscall(THREAD_CREATE,handle,start_routine,arg,stack);
    80001dcc:	00098693          	mv	a3,s3
    80001dd0:	00090613          	mv	a2,s2
    80001dd4:	00048593          	mv	a1,s1
    80001dd8:	01100513          	li	a0,17
    80001ddc:	fffff097          	auipc	ra,0xfffff
    80001de0:	6e0080e7          	jalr	1760(ra) # 800014bc <kern_syscall>
    80001de4:	0005051b          	sext.w	a0,a0
}
    80001de8:	02813083          	ld	ra,40(sp)
    80001dec:	02013403          	ld	s0,32(sp)
    80001df0:	01813483          	ld	s1,24(sp)
    80001df4:	01013903          	ld	s2,16(sp)
    80001df8:	00813983          	ld	s3,8(sp)
    80001dfc:	03010113          	addi	sp,sp,48
    80001e00:	00008067          	ret
    if(stack==0) return -1;
    80001e04:	fff00513          	li	a0,-1
    80001e08:	fe1ff06f          	j	80001de8 <thread_create+0x58>

0000000080001e0c <thread_dispatch>:

void thread_dispatch(){
    80001e0c:	ff010113          	addi	sp,sp,-16
    80001e10:	00113423          	sd	ra,8(sp)
    80001e14:	00813023          	sd	s0,0(sp)
    80001e18:	01010413          	addi	s0,sp,16
    kern_syscall(THREAD_DISPATCH);
    80001e1c:	01300513          	li	a0,19
    80001e20:	fffff097          	auipc	ra,0xfffff
    80001e24:	69c080e7          	jalr	1692(ra) # 800014bc <kern_syscall>
}
    80001e28:	00813083          	ld	ra,8(sp)
    80001e2c:	00013403          	ld	s0,0(sp)
    80001e30:	01010113          	addi	sp,sp,16
    80001e34:	00008067          	ret

0000000080001e38 <thread_exit>:

int thread_exit ()
{
    80001e38:	ff010113          	addi	sp,sp,-16
    80001e3c:	00113423          	sd	ra,8(sp)
    80001e40:	00813023          	sd	s0,0(sp)
    80001e44:	01010413          	addi	s0,sp,16
    kern_syscall(THREAD_EXIT);
    80001e48:	01200513          	li	a0,18
    80001e4c:	fffff097          	auipc	ra,0xfffff
    80001e50:	670080e7          	jalr	1648(ra) # 800014bc <kern_syscall>
    return 0;
}
    80001e54:	00000513          	li	a0,0
    80001e58:	00813083          	ld	ra,8(sp)
    80001e5c:	00013403          	ld	s0,0(sp)
    80001e60:	01010113          	addi	sp,sp,16
    80001e64:	00008067          	ret

0000000080001e68 <thread_join>:

void thread_join(thread_t handle)
{
    80001e68:	ff010113          	addi	sp,sp,-16
    80001e6c:	00113423          	sd	ra,8(sp)
    80001e70:	00813023          	sd	s0,0(sp)
    80001e74:	01010413          	addi	s0,sp,16
    80001e78:	00050593          	mv	a1,a0
    kern_syscall(THREAD_JOIN,handle);
    80001e7c:	01400513          	li	a0,20
    80001e80:	fffff097          	auipc	ra,0xfffff
    80001e84:	63c080e7          	jalr	1596(ra) # 800014bc <kern_syscall>
}
    80001e88:	00813083          	ld	ra,8(sp)
    80001e8c:	00013403          	ld	s0,0(sp)
    80001e90:	01010113          	addi	sp,sp,16
    80001e94:	00008067          	ret

0000000080001e98 <sem_open>:

int sem_open (sem_t* handle, unsigned init)
{
    80001e98:	ff010113          	addi	sp,sp,-16
    80001e9c:	00113423          	sd	ra,8(sp)
    80001ea0:	00813023          	sd	s0,0(sp)
    80001ea4:	01010413          	addi	s0,sp,16
    80001ea8:	00058613          	mv	a2,a1
    return kern_syscall(SEM_OPEN,handle,init);
    80001eac:	00050593          	mv	a1,a0
    80001eb0:	02100513          	li	a0,33
    80001eb4:	fffff097          	auipc	ra,0xfffff
    80001eb8:	608080e7          	jalr	1544(ra) # 800014bc <kern_syscall>
}
    80001ebc:	0005051b          	sext.w	a0,a0
    80001ec0:	00813083          	ld	ra,8(sp)
    80001ec4:	00013403          	ld	s0,0(sp)
    80001ec8:	01010113          	addi	sp,sp,16
    80001ecc:	00008067          	ret

0000000080001ed0 <sem_close>:

int sem_close (sem_t handle)
{
    80001ed0:	ff010113          	addi	sp,sp,-16
    80001ed4:	00113423          	sd	ra,8(sp)
    80001ed8:	00813023          	sd	s0,0(sp)
    80001edc:	01010413          	addi	s0,sp,16
    80001ee0:	00050593          	mv	a1,a0
    return kern_syscall(SEM_CLOSE,handle);
    80001ee4:	02200513          	li	a0,34
    80001ee8:	fffff097          	auipc	ra,0xfffff
    80001eec:	5d4080e7          	jalr	1492(ra) # 800014bc <kern_syscall>
}
    80001ef0:	0005051b          	sext.w	a0,a0
    80001ef4:	00813083          	ld	ra,8(sp)
    80001ef8:	00013403          	ld	s0,0(sp)
    80001efc:	01010113          	addi	sp,sp,16
    80001f00:	00008067          	ret

0000000080001f04 <sem_wait>:

int sem_wait (sem_t id)
{
    80001f04:	ff010113          	addi	sp,sp,-16
    80001f08:	00113423          	sd	ra,8(sp)
    80001f0c:	00813023          	sd	s0,0(sp)
    80001f10:	01010413          	addi	s0,sp,16
    80001f14:	00050593          	mv	a1,a0
    return kern_syscall(SEM_WAIT,id);
    80001f18:	02300513          	li	a0,35
    80001f1c:	fffff097          	auipc	ra,0xfffff
    80001f20:	5a0080e7          	jalr	1440(ra) # 800014bc <kern_syscall>
}
    80001f24:	0005051b          	sext.w	a0,a0
    80001f28:	00813083          	ld	ra,8(sp)
    80001f2c:	00013403          	ld	s0,0(sp)
    80001f30:	01010113          	addi	sp,sp,16
    80001f34:	00008067          	ret

0000000080001f38 <sem_signal>:

int sem_signal (sem_t id){
    80001f38:	ff010113          	addi	sp,sp,-16
    80001f3c:	00113423          	sd	ra,8(sp)
    80001f40:	00813023          	sd	s0,0(sp)
    80001f44:	01010413          	addi	s0,sp,16
    80001f48:	00050593          	mv	a1,a0
    return kern_syscall(SEM_SIGNAL,id);
    80001f4c:	02400513          	li	a0,36
    80001f50:	fffff097          	auipc	ra,0xfffff
    80001f54:	56c080e7          	jalr	1388(ra) # 800014bc <kern_syscall>
}
    80001f58:	0005051b          	sext.w	a0,a0
    80001f5c:	00813083          	ld	ra,8(sp)
    80001f60:	00013403          	ld	s0,0(sp)
    80001f64:	01010113          	addi	sp,sp,16
    80001f68:	00008067          	ret

0000000080001f6c <_Z5bodyCPv>:
}

sem_t semtest;

void bodyC(void* arg)
{
    80001f6c:	fe010113          	addi	sp,sp,-32
    80001f70:	00113c23          	sd	ra,24(sp)
    80001f74:	00813823          	sd	s0,16(sp)
    80001f78:	00913423          	sd	s1,8(sp)
    80001f7c:	01213023          	sd	s2,0(sp)
    80001f80:	02010413          	addi	s0,sp,32
    80001f84:	00050913          	mv	s2,a0
    int counter=0;
    80001f88:	00000493          	li	s1,0
    80001f8c:	0180006f          	j	80001fa4 <_Z5bodyCPv+0x38>
    char*c = (char*)arg;
    while(1){
        if(++counter>5) sem_close(semtest);
        __putc(*c);
    80001f90:	00094503          	lbu	a0,0(s2)
    80001f94:	00002097          	auipc	ra,0x2
    80001f98:	3a8080e7          	jalr	936(ra) # 8000433c <__putc>
        thread_dispatch();
    80001f9c:	00000097          	auipc	ra,0x0
    80001fa0:	e70080e7          	jalr	-400(ra) # 80001e0c <thread_dispatch>
        if(++counter>5) sem_close(semtest);
    80001fa4:	0014849b          	addiw	s1,s1,1
    80001fa8:	00500793          	li	a5,5
    80001fac:	fe97d2e3          	bge	a5,s1,80001f90 <_Z5bodyCPv+0x24>
    80001fb0:	00006517          	auipc	a0,0x6
    80001fb4:	a8053503          	ld	a0,-1408(a0) # 80007a30 <semtest>
    80001fb8:	00000097          	auipc	ra,0x0
    80001fbc:	f18080e7          	jalr	-232(ra) # 80001ed0 <sem_close>
    80001fc0:	fd1ff06f          	j	80001f90 <_Z5bodyCPv+0x24>

0000000080001fc4 <_Z5bodyAPv>:
    }
}

void bodyA(void* arg)
{
    80001fc4:	fe010113          	addi	sp,sp,-32
    80001fc8:	00113c23          	sd	ra,24(sp)
    80001fcc:	00813823          	sd	s0,16(sp)
    80001fd0:	00913423          	sd	s1,8(sp)
    80001fd4:	01213023          	sd	s2,0(sp)
    80001fd8:	02010413          	addi	s0,sp,32
    char c = 'a';
    if(sem_wait(semtest)<0) c='A';
    80001fdc:	00006517          	auipc	a0,0x6
    80001fe0:	a5453503          	ld	a0,-1452(a0) # 80007a30 <semtest>
    80001fe4:	00000097          	auipc	ra,0x0
    80001fe8:	f20080e7          	jalr	-224(ra) # 80001f04 <sem_wait>
    80001fec:	00054863          	bltz	a0,80001ffc <_Z5bodyAPv+0x38>
    char c = 'a';
    80001ff0:	06100913          	li	s2,97
    for(int i=0;i<10;i++){
    80001ff4:	00000493          	li	s1,0
    80001ff8:	0200006f          	j	80002018 <_Z5bodyAPv+0x54>
    if(sem_wait(semtest)<0) c='A';
    80001ffc:	04100913          	li	s2,65
    80002000:	ff5ff06f          	j	80001ff4 <_Z5bodyAPv+0x30>
        __putc(c);
        if(i==2) thread_exit();
    80002004:	00000097          	auipc	ra,0x0
    80002008:	e34080e7          	jalr	-460(ra) # 80001e38 <thread_exit>
        thread_dispatch();
    8000200c:	00000097          	auipc	ra,0x0
    80002010:	e00080e7          	jalr	-512(ra) # 80001e0c <thread_dispatch>
    for(int i=0;i<10;i++){
    80002014:	0014849b          	addiw	s1,s1,1
    80002018:	00900793          	li	a5,9
    8000201c:	0097ce63          	blt	a5,s1,80002038 <_Z5bodyAPv+0x74>
        __putc(c);
    80002020:	00090513          	mv	a0,s2
    80002024:	00002097          	auipc	ra,0x2
    80002028:	318080e7          	jalr	792(ra) # 8000433c <__putc>
        if(i==2) thread_exit();
    8000202c:	00200793          	li	a5,2
    80002030:	fcf49ee3          	bne	s1,a5,8000200c <_Z5bodyAPv+0x48>
    80002034:	fd1ff06f          	j	80002004 <_Z5bodyAPv+0x40>
    }
}
    80002038:	01813083          	ld	ra,24(sp)
    8000203c:	01013403          	ld	s0,16(sp)
    80002040:	00813483          	ld	s1,8(sp)
    80002044:	00013903          	ld	s2,0(sp)
    80002048:	02010113          	addi	sp,sp,32
    8000204c:	00008067          	ret

0000000080002050 <_Z5bodyBPv>:

int g=0;

void bodyB(void* arg)
{
    80002050:	fe010113          	addi	sp,sp,-32
    80002054:	00113c23          	sd	ra,24(sp)
    80002058:	00813823          	sd	s0,16(sp)
    8000205c:	00913423          	sd	s1,8(sp)
    80002060:	02010413          	addi	s0,sp,32
    for(int i=0;i<15;i++){
    80002064:	00000493          	li	s1,0
    80002068:	0540006f          	j	800020bc <_Z5bodyBPv+0x6c>
        __putc('b');
        for(int k=0;k<10000;k++){
            for(int m=0;m<1000;m++){
    8000206c:	0017071b          	addiw	a4,a4,1
    80002070:	3e700793          	li	a5,999
    80002074:	02e7c663          	blt	a5,a4,800020a0 <_Z5bodyBPv+0x50>
                if((m*k)%1337==0) g++;
    80002078:	02e607bb          	mulw	a5,a2,a4
    8000207c:	53900693          	li	a3,1337
    80002080:	02d7e7bb          	remw	a5,a5,a3
    80002084:	fe0794e3          	bnez	a5,8000206c <_Z5bodyBPv+0x1c>
    80002088:	00006697          	auipc	a3,0x6
    8000208c:	9a868693          	addi	a3,a3,-1624 # 80007a30 <semtest>
    80002090:	0086a783          	lw	a5,8(a3)
    80002094:	0017879b          	addiw	a5,a5,1
    80002098:	00f6a423          	sw	a5,8(a3)
    8000209c:	fd1ff06f          	j	8000206c <_Z5bodyBPv+0x1c>
        for(int k=0;k<10000;k++){
    800020a0:	0016061b          	addiw	a2,a2,1
    800020a4:	000027b7          	lui	a5,0x2
    800020a8:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    800020ac:	00c7c663          	blt	a5,a2,800020b8 <_Z5bodyBPv+0x68>
            for(int m=0;m<1000;m++){
    800020b0:	00000713          	li	a4,0
    800020b4:	fbdff06f          	j	80002070 <_Z5bodyBPv+0x20>
    for(int i=0;i<15;i++){
    800020b8:	0014849b          	addiw	s1,s1,1
    800020bc:	00e00793          	li	a5,14
    800020c0:	0097cc63          	blt	a5,s1,800020d8 <_Z5bodyBPv+0x88>
        __putc('b');
    800020c4:	06200513          	li	a0,98
    800020c8:	00002097          	auipc	ra,0x2
    800020cc:	274080e7          	jalr	628(ra) # 8000433c <__putc>
        for(int k=0;k<10000;k++){
    800020d0:	00000613          	li	a2,0
    800020d4:	fd1ff06f          	j	800020a4 <_Z5bodyBPv+0x54>
            }
        }
    }
    sem_signal(semtest);
    800020d8:	00006517          	auipc	a0,0x6
    800020dc:	95853503          	ld	a0,-1704(a0) # 80007a30 <semtest>
    800020e0:	00000097          	auipc	ra,0x0
    800020e4:	e58080e7          	jalr	-424(ra) # 80001f38 <sem_signal>
}
    800020e8:	01813083          	ld	ra,24(sp)
    800020ec:	01013403          	ld	s0,16(sp)
    800020f0:	00813483          	ld	s1,8(sp)
    800020f4:	02010113          	addi	sp,sp,32
    800020f8:	00008067          	ret

00000000800020fc <main>:


int main()
{
    800020fc:	fc010113          	addi	sp,sp,-64
    80002100:	02113c23          	sd	ra,56(sp)
    80002104:	02813823          	sd	s0,48(sp)
    80002108:	02913423          	sd	s1,40(sp)
    8000210c:	04010413          	addi	s0,sp,64
    kern_thread_init();
    80002110:	fffff097          	auipc	ra,0xfffff
    80002114:	764080e7          	jalr	1892(ra) # 80001874 <kern_thread_init>
    //printstring("lalala");

    kern_mem_init((void*)HEAP_START_ADDR, (void*)HEAP_END_ADDR);
    80002118:	00003797          	auipc	a5,0x3
    8000211c:	2b07b783          	ld	a5,688(a5) # 800053c8 <_GLOBAL_OFFSET_TABLE_+0x18>
    80002120:	0007b583          	ld	a1,0(a5)
    80002124:	00003797          	auipc	a5,0x3
    80002128:	2947b783          	ld	a5,660(a5) # 800053b8 <_GLOBAL_OFFSET_TABLE_+0x8>
    8000212c:	0007b503          	ld	a0,0(a5)
    80002130:	fffff097          	auipc	ra,0xfffff
    80002134:	32c080e7          	jalr	812(ra) # 8000145c <kern_mem_init>
    kern_interrupt_init();
    80002138:	fffff097          	auipc	ra,0xfffff
    8000213c:	3c8080e7          	jalr	968(ra) # 80001500 <kern_interrupt_init>
    kern_sem_init();
    80002140:	fffff097          	auipc	ra,0xfffff
    80002144:	fe4080e7          	jalr	-28(ra) # 80001124 <kern_sem_init>

    a= mem_alloc(64);
    mem_free(a);
*/
    thread_t thrA, thrB, thrC;
    thread_create(&thrA,&bodyA,0);
    80002148:	00000613          	li	a2,0
    8000214c:	00000597          	auipc	a1,0x0
    80002150:	e7858593          	addi	a1,a1,-392 # 80001fc4 <_Z5bodyAPv>
    80002154:	fd840513          	addi	a0,s0,-40
    80002158:	00000097          	auipc	ra,0x0
    8000215c:	c38080e7          	jalr	-968(ra) # 80001d90 <thread_create>
    thread_create(&thrB,&bodyB,0);
    80002160:	00000613          	li	a2,0
    80002164:	00000597          	auipc	a1,0x0
    80002168:	eec58593          	addi	a1,a1,-276 # 80002050 <_Z5bodyBPv>
    8000216c:	fd040513          	addi	a0,s0,-48
    80002170:	00000097          	auipc	ra,0x0
    80002174:	c20080e7          	jalr	-992(ra) # 80001d90 <thread_create>

    sem_open(&semtest,0);
    80002178:	00000593          	li	a1,0
    8000217c:	00006517          	auipc	a0,0x6
    80002180:	8b450513          	addi	a0,a0,-1868 # 80007a30 <semtest>
    80002184:	00000097          	auipc	ra,0x0
    80002188:	d14080e7          	jalr	-748(ra) # 80001e98 <sem_open>

    char chr = '0';
    8000218c:	03000493          	li	s1,48
    while (1){
        __putc(chr++);
    80002190:	00048513          	mv	a0,s1
    80002194:	0014849b          	addiw	s1,s1,1
    80002198:	0ff4f493          	andi	s1,s1,255
    8000219c:	00002097          	auipc	ra,0x2
    800021a0:	1a0080e7          	jalr	416(ra) # 8000433c <__putc>
        thread_dispatch();
    800021a4:	00000097          	auipc	ra,0x0
    800021a8:	c68080e7          	jalr	-920(ra) # 80001e0c <thread_dispatch>
        if(thrB->status!=UNUSED) thread_join(thrB);
    800021ac:	fd043503          	ld	a0,-48(s0)
    800021b0:	04852783          	lw	a5,72(a0)
    800021b4:	06079263          	bnez	a5,80002218 <main+0x11c>
        if(thrA->status==UNUSED && thrB->status==UNUSED) break;
    800021b8:	fd843783          	ld	a5,-40(s0)
    800021bc:	0487a783          	lw	a5,72(a5)
    800021c0:	fc0798e3          	bnez	a5,80002190 <main+0x94>
    800021c4:	fd043783          	ld	a5,-48(s0)
    800021c8:	0487a783          	lw	a5,72(a5)
    800021cc:	fc0792e3          	bnez	a5,80002190 <main+0x94>
    }

    __putc('E');
    800021d0:	04500513          	li	a0,69
    800021d4:	00002097          	auipc	ra,0x2
    800021d8:	168080e7          	jalr	360(ra) # 8000433c <__putc>
    char c='M';
    800021dc:	04d00793          	li	a5,77
    800021e0:	fcf403a3          	sb	a5,-57(s0)
    thread_create(&thrC,&bodyC,&c);
    800021e4:	fc740613          	addi	a2,s0,-57
    800021e8:	00000597          	auipc	a1,0x0
    800021ec:	d8458593          	addi	a1,a1,-636 # 80001f6c <_Z5bodyCPv>
    800021f0:	fc840513          	addi	a0,s0,-56
    800021f4:	00000097          	auipc	ra,0x0
    800021f8:	b9c080e7          	jalr	-1124(ra) # 80001d90 <thread_create>
    thread_create(&thrA,&bodyA,0);
    800021fc:	00000613          	li	a2,0
    80002200:	00000597          	auipc	a1,0x0
    80002204:	dc458593          	addi	a1,a1,-572 # 80001fc4 <_Z5bodyAPv>
    80002208:	fd840513          	addi	a0,s0,-40
    8000220c:	00000097          	auipc	ra,0x0
    80002210:	b84080e7          	jalr	-1148(ra) # 80001d90 <thread_create>

    while(1);
    80002214:	0000006f          	j	80002214 <main+0x118>
        if(thrB->status!=UNUSED) thread_join(thrB);
    80002218:	00000097          	auipc	ra,0x0
    8000221c:	c50080e7          	jalr	-944(ra) # 80001e68 <thread_join>
    80002220:	f99ff06f          	j	800021b8 <main+0xbc>

0000000080002224 <_Z11printstringPKc>:
//

#include "../h/strings.h"

void printstring(const char* string)
{
    80002224:	fe010113          	addi	sp,sp,-32
    80002228:	00113c23          	sd	ra,24(sp)
    8000222c:	00813823          	sd	s0,16(sp)
    80002230:	00913423          	sd	s1,8(sp)
    80002234:	01213023          	sd	s2,0(sp)
    80002238:	02010413          	addi	s0,sp,32
    8000223c:	00050913          	mv	s2,a0
    int i=0;
    80002240:	00000493          	li	s1,0
    while (string[i]){
    80002244:	009907b3          	add	a5,s2,s1
    80002248:	0007c503          	lbu	a0,0(a5)
    8000224c:	00050a63          	beqz	a0,80002260 <_Z11printstringPKc+0x3c>
        __putc(string[i++]);
    80002250:	0014849b          	addiw	s1,s1,1
    80002254:	00002097          	auipc	ra,0x2
    80002258:	0e8080e7          	jalr	232(ra) # 8000433c <__putc>
    while (string[i]){
    8000225c:	fe9ff06f          	j	80002244 <_Z11printstringPKc+0x20>
    }
}
    80002260:	01813083          	ld	ra,24(sp)
    80002264:	01013403          	ld	s0,16(sp)
    80002268:	00813483          	ld	s1,8(sp)
    8000226c:	00013903          	ld	s2,0(sp)
    80002270:	02010113          	addi	sp,sp,32
    80002274:	00008067          	ret

0000000080002278 <start>:
    80002278:	ff010113          	addi	sp,sp,-16
    8000227c:	00813423          	sd	s0,8(sp)
    80002280:	01010413          	addi	s0,sp,16
    80002284:	300027f3          	csrr	a5,mstatus
    80002288:	ffffe737          	lui	a4,0xffffe
    8000228c:	7ff70713          	addi	a4,a4,2047 # ffffffffffffe7ff <end+0xffffffff7fff5b6f>
    80002290:	00e7f7b3          	and	a5,a5,a4
    80002294:	00001737          	lui	a4,0x1
    80002298:	80070713          	addi	a4,a4,-2048 # 800 <_entry-0x7ffff800>
    8000229c:	00e7e7b3          	or	a5,a5,a4
    800022a0:	30079073          	csrw	mstatus,a5
    800022a4:	00000797          	auipc	a5,0x0
    800022a8:	16078793          	addi	a5,a5,352 # 80002404 <system_main>
    800022ac:	34179073          	csrw	mepc,a5
    800022b0:	00000793          	li	a5,0
    800022b4:	18079073          	csrw	satp,a5
    800022b8:	000107b7          	lui	a5,0x10
    800022bc:	fff78793          	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    800022c0:	30279073          	csrw	medeleg,a5
    800022c4:	30379073          	csrw	mideleg,a5
    800022c8:	104027f3          	csrr	a5,sie
    800022cc:	2227e793          	ori	a5,a5,546
    800022d0:	10479073          	csrw	sie,a5
    800022d4:	fff00793          	li	a5,-1
    800022d8:	00a7d793          	srli	a5,a5,0xa
    800022dc:	3b079073          	csrw	pmpaddr0,a5
    800022e0:	00f00793          	li	a5,15
    800022e4:	3a079073          	csrw	pmpcfg0,a5
    800022e8:	f14027f3          	csrr	a5,mhartid
    800022ec:	0200c737          	lui	a4,0x200c
    800022f0:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    800022f4:	0007869b          	sext.w	a3,a5
    800022f8:	00269713          	slli	a4,a3,0x2
    800022fc:	000f4637          	lui	a2,0xf4
    80002300:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    80002304:	00d70733          	add	a4,a4,a3
    80002308:	0037979b          	slliw	a5,a5,0x3
    8000230c:	020046b7          	lui	a3,0x2004
    80002310:	00d787b3          	add	a5,a5,a3
    80002314:	00c585b3          	add	a1,a1,a2
    80002318:	00371693          	slli	a3,a4,0x3
    8000231c:	00005717          	auipc	a4,0x5
    80002320:	72470713          	addi	a4,a4,1828 # 80007a40 <timer_scratch>
    80002324:	00b7b023          	sd	a1,0(a5)
    80002328:	00d70733          	add	a4,a4,a3
    8000232c:	00f73c23          	sd	a5,24(a4)
    80002330:	02c73023          	sd	a2,32(a4)
    80002334:	34071073          	csrw	mscratch,a4
    80002338:	00000797          	auipc	a5,0x0
    8000233c:	6e878793          	addi	a5,a5,1768 # 80002a20 <timervec>
    80002340:	30579073          	csrw	mtvec,a5
    80002344:	300027f3          	csrr	a5,mstatus
    80002348:	0087e793          	ori	a5,a5,8
    8000234c:	30079073          	csrw	mstatus,a5
    80002350:	304027f3          	csrr	a5,mie
    80002354:	0807e793          	ori	a5,a5,128
    80002358:	30479073          	csrw	mie,a5
    8000235c:	f14027f3          	csrr	a5,mhartid
    80002360:	0007879b          	sext.w	a5,a5
    80002364:	00078213          	mv	tp,a5
    80002368:	30200073          	mret
    8000236c:	00813403          	ld	s0,8(sp)
    80002370:	01010113          	addi	sp,sp,16
    80002374:	00008067          	ret

0000000080002378 <timerinit>:
    80002378:	ff010113          	addi	sp,sp,-16
    8000237c:	00813423          	sd	s0,8(sp)
    80002380:	01010413          	addi	s0,sp,16
    80002384:	f14027f3          	csrr	a5,mhartid
    80002388:	0200c737          	lui	a4,0x200c
    8000238c:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    80002390:	0007869b          	sext.w	a3,a5
    80002394:	00269713          	slli	a4,a3,0x2
    80002398:	000f4637          	lui	a2,0xf4
    8000239c:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    800023a0:	00d70733          	add	a4,a4,a3
    800023a4:	0037979b          	slliw	a5,a5,0x3
    800023a8:	020046b7          	lui	a3,0x2004
    800023ac:	00d787b3          	add	a5,a5,a3
    800023b0:	00c585b3          	add	a1,a1,a2
    800023b4:	00371693          	slli	a3,a4,0x3
    800023b8:	00005717          	auipc	a4,0x5
    800023bc:	68870713          	addi	a4,a4,1672 # 80007a40 <timer_scratch>
    800023c0:	00b7b023          	sd	a1,0(a5)
    800023c4:	00d70733          	add	a4,a4,a3
    800023c8:	00f73c23          	sd	a5,24(a4)
    800023cc:	02c73023          	sd	a2,32(a4)
    800023d0:	34071073          	csrw	mscratch,a4
    800023d4:	00000797          	auipc	a5,0x0
    800023d8:	64c78793          	addi	a5,a5,1612 # 80002a20 <timervec>
    800023dc:	30579073          	csrw	mtvec,a5
    800023e0:	300027f3          	csrr	a5,mstatus
    800023e4:	0087e793          	ori	a5,a5,8
    800023e8:	30079073          	csrw	mstatus,a5
    800023ec:	304027f3          	csrr	a5,mie
    800023f0:	0807e793          	ori	a5,a5,128
    800023f4:	30479073          	csrw	mie,a5
    800023f8:	00813403          	ld	s0,8(sp)
    800023fc:	01010113          	addi	sp,sp,16
    80002400:	00008067          	ret

0000000080002404 <system_main>:
    80002404:	fe010113          	addi	sp,sp,-32
    80002408:	00813823          	sd	s0,16(sp)
    8000240c:	00913423          	sd	s1,8(sp)
    80002410:	00113c23          	sd	ra,24(sp)
    80002414:	02010413          	addi	s0,sp,32
    80002418:	00000097          	auipc	ra,0x0
    8000241c:	0c4080e7          	jalr	196(ra) # 800024dc <cpuid>
    80002420:	00003497          	auipc	s1,0x3
    80002424:	fe448493          	addi	s1,s1,-28 # 80005404 <started>
    80002428:	02050263          	beqz	a0,8000244c <system_main+0x48>
    8000242c:	0004a783          	lw	a5,0(s1)
    80002430:	0007879b          	sext.w	a5,a5
    80002434:	fe078ce3          	beqz	a5,8000242c <system_main+0x28>
    80002438:	0ff0000f          	fence
    8000243c:	00003517          	auipc	a0,0x3
    80002440:	cac50513          	addi	a0,a0,-852 # 800050e8 <CONSOLE_STATUS+0xd0>
    80002444:	00001097          	auipc	ra,0x1
    80002448:	a78080e7          	jalr	-1416(ra) # 80002ebc <panic>
    8000244c:	00001097          	auipc	ra,0x1
    80002450:	9cc080e7          	jalr	-1588(ra) # 80002e18 <consoleinit>
    80002454:	00001097          	auipc	ra,0x1
    80002458:	158080e7          	jalr	344(ra) # 800035ac <printfinit>
    8000245c:	00003517          	auipc	a0,0x3
    80002460:	d6c50513          	addi	a0,a0,-660 # 800051c8 <CONSOLE_STATUS+0x1b0>
    80002464:	00001097          	auipc	ra,0x1
    80002468:	ab4080e7          	jalr	-1356(ra) # 80002f18 <__printf>
    8000246c:	00003517          	auipc	a0,0x3
    80002470:	c4c50513          	addi	a0,a0,-948 # 800050b8 <CONSOLE_STATUS+0xa0>
    80002474:	00001097          	auipc	ra,0x1
    80002478:	aa4080e7          	jalr	-1372(ra) # 80002f18 <__printf>
    8000247c:	00003517          	auipc	a0,0x3
    80002480:	d4c50513          	addi	a0,a0,-692 # 800051c8 <CONSOLE_STATUS+0x1b0>
    80002484:	00001097          	auipc	ra,0x1
    80002488:	a94080e7          	jalr	-1388(ra) # 80002f18 <__printf>
    8000248c:	00001097          	auipc	ra,0x1
    80002490:	4ac080e7          	jalr	1196(ra) # 80003938 <kinit>
    80002494:	00000097          	auipc	ra,0x0
    80002498:	148080e7          	jalr	328(ra) # 800025dc <trapinit>
    8000249c:	00000097          	auipc	ra,0x0
    800024a0:	16c080e7          	jalr	364(ra) # 80002608 <trapinithart>
    800024a4:	00000097          	auipc	ra,0x0
    800024a8:	5bc080e7          	jalr	1468(ra) # 80002a60 <plicinit>
    800024ac:	00000097          	auipc	ra,0x0
    800024b0:	5dc080e7          	jalr	1500(ra) # 80002a88 <plicinithart>
    800024b4:	00000097          	auipc	ra,0x0
    800024b8:	078080e7          	jalr	120(ra) # 8000252c <userinit>
    800024bc:	0ff0000f          	fence
    800024c0:	00100793          	li	a5,1
    800024c4:	00003517          	auipc	a0,0x3
    800024c8:	c0c50513          	addi	a0,a0,-1012 # 800050d0 <CONSOLE_STATUS+0xb8>
    800024cc:	00f4a023          	sw	a5,0(s1)
    800024d0:	00001097          	auipc	ra,0x1
    800024d4:	a48080e7          	jalr	-1464(ra) # 80002f18 <__printf>
    800024d8:	0000006f          	j	800024d8 <system_main+0xd4>

00000000800024dc <cpuid>:
    800024dc:	ff010113          	addi	sp,sp,-16
    800024e0:	00813423          	sd	s0,8(sp)
    800024e4:	01010413          	addi	s0,sp,16
    800024e8:	00020513          	mv	a0,tp
    800024ec:	00813403          	ld	s0,8(sp)
    800024f0:	0005051b          	sext.w	a0,a0
    800024f4:	01010113          	addi	sp,sp,16
    800024f8:	00008067          	ret

00000000800024fc <mycpu>:
    800024fc:	ff010113          	addi	sp,sp,-16
    80002500:	00813423          	sd	s0,8(sp)
    80002504:	01010413          	addi	s0,sp,16
    80002508:	00020793          	mv	a5,tp
    8000250c:	00813403          	ld	s0,8(sp)
    80002510:	0007879b          	sext.w	a5,a5
    80002514:	00779793          	slli	a5,a5,0x7
    80002518:	00006517          	auipc	a0,0x6
    8000251c:	55850513          	addi	a0,a0,1368 # 80008a70 <cpus>
    80002520:	00f50533          	add	a0,a0,a5
    80002524:	01010113          	addi	sp,sp,16
    80002528:	00008067          	ret

000000008000252c <userinit>:
    8000252c:	ff010113          	addi	sp,sp,-16
    80002530:	00813423          	sd	s0,8(sp)
    80002534:	01010413          	addi	s0,sp,16
    80002538:	00813403          	ld	s0,8(sp)
    8000253c:	01010113          	addi	sp,sp,16
    80002540:	00000317          	auipc	t1,0x0
    80002544:	bbc30067          	jr	-1092(t1) # 800020fc <main>

0000000080002548 <either_copyout>:
    80002548:	ff010113          	addi	sp,sp,-16
    8000254c:	00813023          	sd	s0,0(sp)
    80002550:	00113423          	sd	ra,8(sp)
    80002554:	01010413          	addi	s0,sp,16
    80002558:	02051663          	bnez	a0,80002584 <either_copyout+0x3c>
    8000255c:	00058513          	mv	a0,a1
    80002560:	00060593          	mv	a1,a2
    80002564:	0006861b          	sext.w	a2,a3
    80002568:	00002097          	auipc	ra,0x2
    8000256c:	c5c080e7          	jalr	-932(ra) # 800041c4 <__memmove>
    80002570:	00813083          	ld	ra,8(sp)
    80002574:	00013403          	ld	s0,0(sp)
    80002578:	00000513          	li	a0,0
    8000257c:	01010113          	addi	sp,sp,16
    80002580:	00008067          	ret
    80002584:	00003517          	auipc	a0,0x3
    80002588:	b8c50513          	addi	a0,a0,-1140 # 80005110 <CONSOLE_STATUS+0xf8>
    8000258c:	00001097          	auipc	ra,0x1
    80002590:	930080e7          	jalr	-1744(ra) # 80002ebc <panic>

0000000080002594 <either_copyin>:
    80002594:	ff010113          	addi	sp,sp,-16
    80002598:	00813023          	sd	s0,0(sp)
    8000259c:	00113423          	sd	ra,8(sp)
    800025a0:	01010413          	addi	s0,sp,16
    800025a4:	02059463          	bnez	a1,800025cc <either_copyin+0x38>
    800025a8:	00060593          	mv	a1,a2
    800025ac:	0006861b          	sext.w	a2,a3
    800025b0:	00002097          	auipc	ra,0x2
    800025b4:	c14080e7          	jalr	-1004(ra) # 800041c4 <__memmove>
    800025b8:	00813083          	ld	ra,8(sp)
    800025bc:	00013403          	ld	s0,0(sp)
    800025c0:	00000513          	li	a0,0
    800025c4:	01010113          	addi	sp,sp,16
    800025c8:	00008067          	ret
    800025cc:	00003517          	auipc	a0,0x3
    800025d0:	b6c50513          	addi	a0,a0,-1172 # 80005138 <CONSOLE_STATUS+0x120>
    800025d4:	00001097          	auipc	ra,0x1
    800025d8:	8e8080e7          	jalr	-1816(ra) # 80002ebc <panic>

00000000800025dc <trapinit>:
    800025dc:	ff010113          	addi	sp,sp,-16
    800025e0:	00813423          	sd	s0,8(sp)
    800025e4:	01010413          	addi	s0,sp,16
    800025e8:	00813403          	ld	s0,8(sp)
    800025ec:	00003597          	auipc	a1,0x3
    800025f0:	b7458593          	addi	a1,a1,-1164 # 80005160 <CONSOLE_STATUS+0x148>
    800025f4:	00006517          	auipc	a0,0x6
    800025f8:	4fc50513          	addi	a0,a0,1276 # 80008af0 <tickslock>
    800025fc:	01010113          	addi	sp,sp,16
    80002600:	00001317          	auipc	t1,0x1
    80002604:	5c830067          	jr	1480(t1) # 80003bc8 <initlock>

0000000080002608 <trapinithart>:
    80002608:	ff010113          	addi	sp,sp,-16
    8000260c:	00813423          	sd	s0,8(sp)
    80002610:	01010413          	addi	s0,sp,16
    80002614:	00000797          	auipc	a5,0x0
    80002618:	2fc78793          	addi	a5,a5,764 # 80002910 <kernelvec>
    8000261c:	10579073          	csrw	stvec,a5
    80002620:	00813403          	ld	s0,8(sp)
    80002624:	01010113          	addi	sp,sp,16
    80002628:	00008067          	ret

000000008000262c <usertrap>:
    8000262c:	ff010113          	addi	sp,sp,-16
    80002630:	00813423          	sd	s0,8(sp)
    80002634:	01010413          	addi	s0,sp,16
    80002638:	00813403          	ld	s0,8(sp)
    8000263c:	01010113          	addi	sp,sp,16
    80002640:	00008067          	ret

0000000080002644 <usertrapret>:
    80002644:	ff010113          	addi	sp,sp,-16
    80002648:	00813423          	sd	s0,8(sp)
    8000264c:	01010413          	addi	s0,sp,16
    80002650:	00813403          	ld	s0,8(sp)
    80002654:	01010113          	addi	sp,sp,16
    80002658:	00008067          	ret

000000008000265c <kerneltrap>:
    8000265c:	fe010113          	addi	sp,sp,-32
    80002660:	00813823          	sd	s0,16(sp)
    80002664:	00113c23          	sd	ra,24(sp)
    80002668:	00913423          	sd	s1,8(sp)
    8000266c:	02010413          	addi	s0,sp,32
    80002670:	142025f3          	csrr	a1,scause
    80002674:	100027f3          	csrr	a5,sstatus
    80002678:	0027f793          	andi	a5,a5,2
    8000267c:	10079c63          	bnez	a5,80002794 <kerneltrap+0x138>
    80002680:	142027f3          	csrr	a5,scause
    80002684:	0207ce63          	bltz	a5,800026c0 <kerneltrap+0x64>
    80002688:	00003517          	auipc	a0,0x3
    8000268c:	b2050513          	addi	a0,a0,-1248 # 800051a8 <CONSOLE_STATUS+0x190>
    80002690:	00001097          	auipc	ra,0x1
    80002694:	888080e7          	jalr	-1912(ra) # 80002f18 <__printf>
    80002698:	141025f3          	csrr	a1,sepc
    8000269c:	14302673          	csrr	a2,stval
    800026a0:	00003517          	auipc	a0,0x3
    800026a4:	b1850513          	addi	a0,a0,-1256 # 800051b8 <CONSOLE_STATUS+0x1a0>
    800026a8:	00001097          	auipc	ra,0x1
    800026ac:	870080e7          	jalr	-1936(ra) # 80002f18 <__printf>
    800026b0:	00003517          	auipc	a0,0x3
    800026b4:	b2050513          	addi	a0,a0,-1248 # 800051d0 <CONSOLE_STATUS+0x1b8>
    800026b8:	00001097          	auipc	ra,0x1
    800026bc:	804080e7          	jalr	-2044(ra) # 80002ebc <panic>
    800026c0:	0ff7f713          	andi	a4,a5,255
    800026c4:	00900693          	li	a3,9
    800026c8:	04d70063          	beq	a4,a3,80002708 <kerneltrap+0xac>
    800026cc:	fff00713          	li	a4,-1
    800026d0:	03f71713          	slli	a4,a4,0x3f
    800026d4:	00170713          	addi	a4,a4,1
    800026d8:	fae798e3          	bne	a5,a4,80002688 <kerneltrap+0x2c>
    800026dc:	00000097          	auipc	ra,0x0
    800026e0:	e00080e7          	jalr	-512(ra) # 800024dc <cpuid>
    800026e4:	06050663          	beqz	a0,80002750 <kerneltrap+0xf4>
    800026e8:	144027f3          	csrr	a5,sip
    800026ec:	ffd7f793          	andi	a5,a5,-3
    800026f0:	14479073          	csrw	sip,a5
    800026f4:	01813083          	ld	ra,24(sp)
    800026f8:	01013403          	ld	s0,16(sp)
    800026fc:	00813483          	ld	s1,8(sp)
    80002700:	02010113          	addi	sp,sp,32
    80002704:	00008067          	ret
    80002708:	00000097          	auipc	ra,0x0
    8000270c:	3cc080e7          	jalr	972(ra) # 80002ad4 <plic_claim>
    80002710:	00a00793          	li	a5,10
    80002714:	00050493          	mv	s1,a0
    80002718:	06f50863          	beq	a0,a5,80002788 <kerneltrap+0x12c>
    8000271c:	fc050ce3          	beqz	a0,800026f4 <kerneltrap+0x98>
    80002720:	00050593          	mv	a1,a0
    80002724:	00003517          	auipc	a0,0x3
    80002728:	a6450513          	addi	a0,a0,-1436 # 80005188 <CONSOLE_STATUS+0x170>
    8000272c:	00000097          	auipc	ra,0x0
    80002730:	7ec080e7          	jalr	2028(ra) # 80002f18 <__printf>
    80002734:	01013403          	ld	s0,16(sp)
    80002738:	01813083          	ld	ra,24(sp)
    8000273c:	00048513          	mv	a0,s1
    80002740:	00813483          	ld	s1,8(sp)
    80002744:	02010113          	addi	sp,sp,32
    80002748:	00000317          	auipc	t1,0x0
    8000274c:	3c430067          	jr	964(t1) # 80002b0c <plic_complete>
    80002750:	00006517          	auipc	a0,0x6
    80002754:	3a050513          	addi	a0,a0,928 # 80008af0 <tickslock>
    80002758:	00001097          	auipc	ra,0x1
    8000275c:	494080e7          	jalr	1172(ra) # 80003bec <acquire>
    80002760:	00003717          	auipc	a4,0x3
    80002764:	ca870713          	addi	a4,a4,-856 # 80005408 <ticks>
    80002768:	00072783          	lw	a5,0(a4)
    8000276c:	00006517          	auipc	a0,0x6
    80002770:	38450513          	addi	a0,a0,900 # 80008af0 <tickslock>
    80002774:	0017879b          	addiw	a5,a5,1
    80002778:	00f72023          	sw	a5,0(a4)
    8000277c:	00001097          	auipc	ra,0x1
    80002780:	53c080e7          	jalr	1340(ra) # 80003cb8 <release>
    80002784:	f65ff06f          	j	800026e8 <kerneltrap+0x8c>
    80002788:	00001097          	auipc	ra,0x1
    8000278c:	098080e7          	jalr	152(ra) # 80003820 <uartintr>
    80002790:	fa5ff06f          	j	80002734 <kerneltrap+0xd8>
    80002794:	00003517          	auipc	a0,0x3
    80002798:	9d450513          	addi	a0,a0,-1580 # 80005168 <CONSOLE_STATUS+0x150>
    8000279c:	00000097          	auipc	ra,0x0
    800027a0:	720080e7          	jalr	1824(ra) # 80002ebc <panic>

00000000800027a4 <clockintr>:
    800027a4:	fe010113          	addi	sp,sp,-32
    800027a8:	00813823          	sd	s0,16(sp)
    800027ac:	00913423          	sd	s1,8(sp)
    800027b0:	00113c23          	sd	ra,24(sp)
    800027b4:	02010413          	addi	s0,sp,32
    800027b8:	00006497          	auipc	s1,0x6
    800027bc:	33848493          	addi	s1,s1,824 # 80008af0 <tickslock>
    800027c0:	00048513          	mv	a0,s1
    800027c4:	00001097          	auipc	ra,0x1
    800027c8:	428080e7          	jalr	1064(ra) # 80003bec <acquire>
    800027cc:	00003717          	auipc	a4,0x3
    800027d0:	c3c70713          	addi	a4,a4,-964 # 80005408 <ticks>
    800027d4:	00072783          	lw	a5,0(a4)
    800027d8:	01013403          	ld	s0,16(sp)
    800027dc:	01813083          	ld	ra,24(sp)
    800027e0:	00048513          	mv	a0,s1
    800027e4:	0017879b          	addiw	a5,a5,1
    800027e8:	00813483          	ld	s1,8(sp)
    800027ec:	00f72023          	sw	a5,0(a4)
    800027f0:	02010113          	addi	sp,sp,32
    800027f4:	00001317          	auipc	t1,0x1
    800027f8:	4c430067          	jr	1220(t1) # 80003cb8 <release>

00000000800027fc <devintr>:
    800027fc:	142027f3          	csrr	a5,scause
    80002800:	00000513          	li	a0,0
    80002804:	0007c463          	bltz	a5,8000280c <devintr+0x10>
    80002808:	00008067          	ret
    8000280c:	fe010113          	addi	sp,sp,-32
    80002810:	00813823          	sd	s0,16(sp)
    80002814:	00113c23          	sd	ra,24(sp)
    80002818:	00913423          	sd	s1,8(sp)
    8000281c:	02010413          	addi	s0,sp,32
    80002820:	0ff7f713          	andi	a4,a5,255
    80002824:	00900693          	li	a3,9
    80002828:	04d70c63          	beq	a4,a3,80002880 <devintr+0x84>
    8000282c:	fff00713          	li	a4,-1
    80002830:	03f71713          	slli	a4,a4,0x3f
    80002834:	00170713          	addi	a4,a4,1
    80002838:	00e78c63          	beq	a5,a4,80002850 <devintr+0x54>
    8000283c:	01813083          	ld	ra,24(sp)
    80002840:	01013403          	ld	s0,16(sp)
    80002844:	00813483          	ld	s1,8(sp)
    80002848:	02010113          	addi	sp,sp,32
    8000284c:	00008067          	ret
    80002850:	00000097          	auipc	ra,0x0
    80002854:	c8c080e7          	jalr	-884(ra) # 800024dc <cpuid>
    80002858:	06050663          	beqz	a0,800028c4 <devintr+0xc8>
    8000285c:	144027f3          	csrr	a5,sip
    80002860:	ffd7f793          	andi	a5,a5,-3
    80002864:	14479073          	csrw	sip,a5
    80002868:	01813083          	ld	ra,24(sp)
    8000286c:	01013403          	ld	s0,16(sp)
    80002870:	00813483          	ld	s1,8(sp)
    80002874:	00200513          	li	a0,2
    80002878:	02010113          	addi	sp,sp,32
    8000287c:	00008067          	ret
    80002880:	00000097          	auipc	ra,0x0
    80002884:	254080e7          	jalr	596(ra) # 80002ad4 <plic_claim>
    80002888:	00a00793          	li	a5,10
    8000288c:	00050493          	mv	s1,a0
    80002890:	06f50663          	beq	a0,a5,800028fc <devintr+0x100>
    80002894:	00100513          	li	a0,1
    80002898:	fa0482e3          	beqz	s1,8000283c <devintr+0x40>
    8000289c:	00048593          	mv	a1,s1
    800028a0:	00003517          	auipc	a0,0x3
    800028a4:	8e850513          	addi	a0,a0,-1816 # 80005188 <CONSOLE_STATUS+0x170>
    800028a8:	00000097          	auipc	ra,0x0
    800028ac:	670080e7          	jalr	1648(ra) # 80002f18 <__printf>
    800028b0:	00048513          	mv	a0,s1
    800028b4:	00000097          	auipc	ra,0x0
    800028b8:	258080e7          	jalr	600(ra) # 80002b0c <plic_complete>
    800028bc:	00100513          	li	a0,1
    800028c0:	f7dff06f          	j	8000283c <devintr+0x40>
    800028c4:	00006517          	auipc	a0,0x6
    800028c8:	22c50513          	addi	a0,a0,556 # 80008af0 <tickslock>
    800028cc:	00001097          	auipc	ra,0x1
    800028d0:	320080e7          	jalr	800(ra) # 80003bec <acquire>
    800028d4:	00003717          	auipc	a4,0x3
    800028d8:	b3470713          	addi	a4,a4,-1228 # 80005408 <ticks>
    800028dc:	00072783          	lw	a5,0(a4)
    800028e0:	00006517          	auipc	a0,0x6
    800028e4:	21050513          	addi	a0,a0,528 # 80008af0 <tickslock>
    800028e8:	0017879b          	addiw	a5,a5,1
    800028ec:	00f72023          	sw	a5,0(a4)
    800028f0:	00001097          	auipc	ra,0x1
    800028f4:	3c8080e7          	jalr	968(ra) # 80003cb8 <release>
    800028f8:	f65ff06f          	j	8000285c <devintr+0x60>
    800028fc:	00001097          	auipc	ra,0x1
    80002900:	f24080e7          	jalr	-220(ra) # 80003820 <uartintr>
    80002904:	fadff06f          	j	800028b0 <devintr+0xb4>
	...

0000000080002910 <kernelvec>:
    80002910:	f0010113          	addi	sp,sp,-256
    80002914:	00113023          	sd	ra,0(sp)
    80002918:	00213423          	sd	sp,8(sp)
    8000291c:	00313823          	sd	gp,16(sp)
    80002920:	00413c23          	sd	tp,24(sp)
    80002924:	02513023          	sd	t0,32(sp)
    80002928:	02613423          	sd	t1,40(sp)
    8000292c:	02713823          	sd	t2,48(sp)
    80002930:	02813c23          	sd	s0,56(sp)
    80002934:	04913023          	sd	s1,64(sp)
    80002938:	04a13423          	sd	a0,72(sp)
    8000293c:	04b13823          	sd	a1,80(sp)
    80002940:	04c13c23          	sd	a2,88(sp)
    80002944:	06d13023          	sd	a3,96(sp)
    80002948:	06e13423          	sd	a4,104(sp)
    8000294c:	06f13823          	sd	a5,112(sp)
    80002950:	07013c23          	sd	a6,120(sp)
    80002954:	09113023          	sd	a7,128(sp)
    80002958:	09213423          	sd	s2,136(sp)
    8000295c:	09313823          	sd	s3,144(sp)
    80002960:	09413c23          	sd	s4,152(sp)
    80002964:	0b513023          	sd	s5,160(sp)
    80002968:	0b613423          	sd	s6,168(sp)
    8000296c:	0b713823          	sd	s7,176(sp)
    80002970:	0b813c23          	sd	s8,184(sp)
    80002974:	0d913023          	sd	s9,192(sp)
    80002978:	0da13423          	sd	s10,200(sp)
    8000297c:	0db13823          	sd	s11,208(sp)
    80002980:	0dc13c23          	sd	t3,216(sp)
    80002984:	0fd13023          	sd	t4,224(sp)
    80002988:	0fe13423          	sd	t5,232(sp)
    8000298c:	0ff13823          	sd	t6,240(sp)
    80002990:	ccdff0ef          	jal	ra,8000265c <kerneltrap>
    80002994:	00013083          	ld	ra,0(sp)
    80002998:	00813103          	ld	sp,8(sp)
    8000299c:	01013183          	ld	gp,16(sp)
    800029a0:	02013283          	ld	t0,32(sp)
    800029a4:	02813303          	ld	t1,40(sp)
    800029a8:	03013383          	ld	t2,48(sp)
    800029ac:	03813403          	ld	s0,56(sp)
    800029b0:	04013483          	ld	s1,64(sp)
    800029b4:	04813503          	ld	a0,72(sp)
    800029b8:	05013583          	ld	a1,80(sp)
    800029bc:	05813603          	ld	a2,88(sp)
    800029c0:	06013683          	ld	a3,96(sp)
    800029c4:	06813703          	ld	a4,104(sp)
    800029c8:	07013783          	ld	a5,112(sp)
    800029cc:	07813803          	ld	a6,120(sp)
    800029d0:	08013883          	ld	a7,128(sp)
    800029d4:	08813903          	ld	s2,136(sp)
    800029d8:	09013983          	ld	s3,144(sp)
    800029dc:	09813a03          	ld	s4,152(sp)
    800029e0:	0a013a83          	ld	s5,160(sp)
    800029e4:	0a813b03          	ld	s6,168(sp)
    800029e8:	0b013b83          	ld	s7,176(sp)
    800029ec:	0b813c03          	ld	s8,184(sp)
    800029f0:	0c013c83          	ld	s9,192(sp)
    800029f4:	0c813d03          	ld	s10,200(sp)
    800029f8:	0d013d83          	ld	s11,208(sp)
    800029fc:	0d813e03          	ld	t3,216(sp)
    80002a00:	0e013e83          	ld	t4,224(sp)
    80002a04:	0e813f03          	ld	t5,232(sp)
    80002a08:	0f013f83          	ld	t6,240(sp)
    80002a0c:	10010113          	addi	sp,sp,256
    80002a10:	10200073          	sret
    80002a14:	00000013          	nop
    80002a18:	00000013          	nop
    80002a1c:	00000013          	nop

0000000080002a20 <timervec>:
    80002a20:	34051573          	csrrw	a0,mscratch,a0
    80002a24:	00b53023          	sd	a1,0(a0)
    80002a28:	00c53423          	sd	a2,8(a0)
    80002a2c:	00d53823          	sd	a3,16(a0)
    80002a30:	01853583          	ld	a1,24(a0)
    80002a34:	02053603          	ld	a2,32(a0)
    80002a38:	0005b683          	ld	a3,0(a1)
    80002a3c:	00c686b3          	add	a3,a3,a2
    80002a40:	00d5b023          	sd	a3,0(a1)
    80002a44:	00200593          	li	a1,2
    80002a48:	14459073          	csrw	sip,a1
    80002a4c:	01053683          	ld	a3,16(a0)
    80002a50:	00853603          	ld	a2,8(a0)
    80002a54:	00053583          	ld	a1,0(a0)
    80002a58:	34051573          	csrrw	a0,mscratch,a0
    80002a5c:	30200073          	mret

0000000080002a60 <plicinit>:
    80002a60:	ff010113          	addi	sp,sp,-16
    80002a64:	00813423          	sd	s0,8(sp)
    80002a68:	01010413          	addi	s0,sp,16
    80002a6c:	00813403          	ld	s0,8(sp)
    80002a70:	0c0007b7          	lui	a5,0xc000
    80002a74:	00100713          	li	a4,1
    80002a78:	02e7a423          	sw	a4,40(a5) # c000028 <_entry-0x73ffffd8>
    80002a7c:	00e7a223          	sw	a4,4(a5)
    80002a80:	01010113          	addi	sp,sp,16
    80002a84:	00008067          	ret

0000000080002a88 <plicinithart>:
    80002a88:	ff010113          	addi	sp,sp,-16
    80002a8c:	00813023          	sd	s0,0(sp)
    80002a90:	00113423          	sd	ra,8(sp)
    80002a94:	01010413          	addi	s0,sp,16
    80002a98:	00000097          	auipc	ra,0x0
    80002a9c:	a44080e7          	jalr	-1468(ra) # 800024dc <cpuid>
    80002aa0:	0085171b          	slliw	a4,a0,0x8
    80002aa4:	0c0027b7          	lui	a5,0xc002
    80002aa8:	00e787b3          	add	a5,a5,a4
    80002aac:	40200713          	li	a4,1026
    80002ab0:	08e7a023          	sw	a4,128(a5) # c002080 <_entry-0x73ffdf80>
    80002ab4:	00813083          	ld	ra,8(sp)
    80002ab8:	00013403          	ld	s0,0(sp)
    80002abc:	00d5151b          	slliw	a0,a0,0xd
    80002ac0:	0c2017b7          	lui	a5,0xc201
    80002ac4:	00a78533          	add	a0,a5,a0
    80002ac8:	00052023          	sw	zero,0(a0)
    80002acc:	01010113          	addi	sp,sp,16
    80002ad0:	00008067          	ret

0000000080002ad4 <plic_claim>:
    80002ad4:	ff010113          	addi	sp,sp,-16
    80002ad8:	00813023          	sd	s0,0(sp)
    80002adc:	00113423          	sd	ra,8(sp)
    80002ae0:	01010413          	addi	s0,sp,16
    80002ae4:	00000097          	auipc	ra,0x0
    80002ae8:	9f8080e7          	jalr	-1544(ra) # 800024dc <cpuid>
    80002aec:	00813083          	ld	ra,8(sp)
    80002af0:	00013403          	ld	s0,0(sp)
    80002af4:	00d5151b          	slliw	a0,a0,0xd
    80002af8:	0c2017b7          	lui	a5,0xc201
    80002afc:	00a78533          	add	a0,a5,a0
    80002b00:	00452503          	lw	a0,4(a0)
    80002b04:	01010113          	addi	sp,sp,16
    80002b08:	00008067          	ret

0000000080002b0c <plic_complete>:
    80002b0c:	fe010113          	addi	sp,sp,-32
    80002b10:	00813823          	sd	s0,16(sp)
    80002b14:	00913423          	sd	s1,8(sp)
    80002b18:	00113c23          	sd	ra,24(sp)
    80002b1c:	02010413          	addi	s0,sp,32
    80002b20:	00050493          	mv	s1,a0
    80002b24:	00000097          	auipc	ra,0x0
    80002b28:	9b8080e7          	jalr	-1608(ra) # 800024dc <cpuid>
    80002b2c:	01813083          	ld	ra,24(sp)
    80002b30:	01013403          	ld	s0,16(sp)
    80002b34:	00d5179b          	slliw	a5,a0,0xd
    80002b38:	0c201737          	lui	a4,0xc201
    80002b3c:	00f707b3          	add	a5,a4,a5
    80002b40:	0097a223          	sw	s1,4(a5) # c201004 <_entry-0x73dfeffc>
    80002b44:	00813483          	ld	s1,8(sp)
    80002b48:	02010113          	addi	sp,sp,32
    80002b4c:	00008067          	ret

0000000080002b50 <consolewrite>:
    80002b50:	fb010113          	addi	sp,sp,-80
    80002b54:	04813023          	sd	s0,64(sp)
    80002b58:	04113423          	sd	ra,72(sp)
    80002b5c:	02913c23          	sd	s1,56(sp)
    80002b60:	03213823          	sd	s2,48(sp)
    80002b64:	03313423          	sd	s3,40(sp)
    80002b68:	03413023          	sd	s4,32(sp)
    80002b6c:	01513c23          	sd	s5,24(sp)
    80002b70:	05010413          	addi	s0,sp,80
    80002b74:	06c05c63          	blez	a2,80002bec <consolewrite+0x9c>
    80002b78:	00060993          	mv	s3,a2
    80002b7c:	00050a13          	mv	s4,a0
    80002b80:	00058493          	mv	s1,a1
    80002b84:	00000913          	li	s2,0
    80002b88:	fff00a93          	li	s5,-1
    80002b8c:	01c0006f          	j	80002ba8 <consolewrite+0x58>
    80002b90:	fbf44503          	lbu	a0,-65(s0)
    80002b94:	0019091b          	addiw	s2,s2,1
    80002b98:	00148493          	addi	s1,s1,1
    80002b9c:	00001097          	auipc	ra,0x1
    80002ba0:	a9c080e7          	jalr	-1380(ra) # 80003638 <uartputc>
    80002ba4:	03298063          	beq	s3,s2,80002bc4 <consolewrite+0x74>
    80002ba8:	00048613          	mv	a2,s1
    80002bac:	00100693          	li	a3,1
    80002bb0:	000a0593          	mv	a1,s4
    80002bb4:	fbf40513          	addi	a0,s0,-65
    80002bb8:	00000097          	auipc	ra,0x0
    80002bbc:	9dc080e7          	jalr	-1572(ra) # 80002594 <either_copyin>
    80002bc0:	fd5518e3          	bne	a0,s5,80002b90 <consolewrite+0x40>
    80002bc4:	04813083          	ld	ra,72(sp)
    80002bc8:	04013403          	ld	s0,64(sp)
    80002bcc:	03813483          	ld	s1,56(sp)
    80002bd0:	02813983          	ld	s3,40(sp)
    80002bd4:	02013a03          	ld	s4,32(sp)
    80002bd8:	01813a83          	ld	s5,24(sp)
    80002bdc:	00090513          	mv	a0,s2
    80002be0:	03013903          	ld	s2,48(sp)
    80002be4:	05010113          	addi	sp,sp,80
    80002be8:	00008067          	ret
    80002bec:	00000913          	li	s2,0
    80002bf0:	fd5ff06f          	j	80002bc4 <consolewrite+0x74>

0000000080002bf4 <consoleread>:
    80002bf4:	f9010113          	addi	sp,sp,-112
    80002bf8:	06813023          	sd	s0,96(sp)
    80002bfc:	04913c23          	sd	s1,88(sp)
    80002c00:	05213823          	sd	s2,80(sp)
    80002c04:	05313423          	sd	s3,72(sp)
    80002c08:	05413023          	sd	s4,64(sp)
    80002c0c:	03513c23          	sd	s5,56(sp)
    80002c10:	03613823          	sd	s6,48(sp)
    80002c14:	03713423          	sd	s7,40(sp)
    80002c18:	03813023          	sd	s8,32(sp)
    80002c1c:	06113423          	sd	ra,104(sp)
    80002c20:	01913c23          	sd	s9,24(sp)
    80002c24:	07010413          	addi	s0,sp,112
    80002c28:	00060b93          	mv	s7,a2
    80002c2c:	00050913          	mv	s2,a0
    80002c30:	00058c13          	mv	s8,a1
    80002c34:	00060b1b          	sext.w	s6,a2
    80002c38:	00006497          	auipc	s1,0x6
    80002c3c:	ed048493          	addi	s1,s1,-304 # 80008b08 <cons>
    80002c40:	00400993          	li	s3,4
    80002c44:	fff00a13          	li	s4,-1
    80002c48:	00a00a93          	li	s5,10
    80002c4c:	05705e63          	blez	s7,80002ca8 <consoleread+0xb4>
    80002c50:	09c4a703          	lw	a4,156(s1)
    80002c54:	0984a783          	lw	a5,152(s1)
    80002c58:	0007071b          	sext.w	a4,a4
    80002c5c:	08e78463          	beq	a5,a4,80002ce4 <consoleread+0xf0>
    80002c60:	07f7f713          	andi	a4,a5,127
    80002c64:	00e48733          	add	a4,s1,a4
    80002c68:	01874703          	lbu	a4,24(a4) # c201018 <_entry-0x73dfefe8>
    80002c6c:	0017869b          	addiw	a3,a5,1
    80002c70:	08d4ac23          	sw	a3,152(s1)
    80002c74:	00070c9b          	sext.w	s9,a4
    80002c78:	0b370663          	beq	a4,s3,80002d24 <consoleread+0x130>
    80002c7c:	00100693          	li	a3,1
    80002c80:	f9f40613          	addi	a2,s0,-97
    80002c84:	000c0593          	mv	a1,s8
    80002c88:	00090513          	mv	a0,s2
    80002c8c:	f8e40fa3          	sb	a4,-97(s0)
    80002c90:	00000097          	auipc	ra,0x0
    80002c94:	8b8080e7          	jalr	-1864(ra) # 80002548 <either_copyout>
    80002c98:	01450863          	beq	a0,s4,80002ca8 <consoleread+0xb4>
    80002c9c:	001c0c13          	addi	s8,s8,1
    80002ca0:	fffb8b9b          	addiw	s7,s7,-1
    80002ca4:	fb5c94e3          	bne	s9,s5,80002c4c <consoleread+0x58>
    80002ca8:	000b851b          	sext.w	a0,s7
    80002cac:	06813083          	ld	ra,104(sp)
    80002cb0:	06013403          	ld	s0,96(sp)
    80002cb4:	05813483          	ld	s1,88(sp)
    80002cb8:	05013903          	ld	s2,80(sp)
    80002cbc:	04813983          	ld	s3,72(sp)
    80002cc0:	04013a03          	ld	s4,64(sp)
    80002cc4:	03813a83          	ld	s5,56(sp)
    80002cc8:	02813b83          	ld	s7,40(sp)
    80002ccc:	02013c03          	ld	s8,32(sp)
    80002cd0:	01813c83          	ld	s9,24(sp)
    80002cd4:	40ab053b          	subw	a0,s6,a0
    80002cd8:	03013b03          	ld	s6,48(sp)
    80002cdc:	07010113          	addi	sp,sp,112
    80002ce0:	00008067          	ret
    80002ce4:	00001097          	auipc	ra,0x1
    80002ce8:	1d8080e7          	jalr	472(ra) # 80003ebc <push_on>
    80002cec:	0984a703          	lw	a4,152(s1)
    80002cf0:	09c4a783          	lw	a5,156(s1)
    80002cf4:	0007879b          	sext.w	a5,a5
    80002cf8:	fef70ce3          	beq	a4,a5,80002cf0 <consoleread+0xfc>
    80002cfc:	00001097          	auipc	ra,0x1
    80002d00:	234080e7          	jalr	564(ra) # 80003f30 <pop_on>
    80002d04:	0984a783          	lw	a5,152(s1)
    80002d08:	07f7f713          	andi	a4,a5,127
    80002d0c:	00e48733          	add	a4,s1,a4
    80002d10:	01874703          	lbu	a4,24(a4)
    80002d14:	0017869b          	addiw	a3,a5,1
    80002d18:	08d4ac23          	sw	a3,152(s1)
    80002d1c:	00070c9b          	sext.w	s9,a4
    80002d20:	f5371ee3          	bne	a4,s3,80002c7c <consoleread+0x88>
    80002d24:	000b851b          	sext.w	a0,s7
    80002d28:	f96bf2e3          	bgeu	s7,s6,80002cac <consoleread+0xb8>
    80002d2c:	08f4ac23          	sw	a5,152(s1)
    80002d30:	f7dff06f          	j	80002cac <consoleread+0xb8>

0000000080002d34 <consputc>:
    80002d34:	10000793          	li	a5,256
    80002d38:	00f50663          	beq	a0,a5,80002d44 <consputc+0x10>
    80002d3c:	00001317          	auipc	t1,0x1
    80002d40:	9f430067          	jr	-1548(t1) # 80003730 <uartputc_sync>
    80002d44:	ff010113          	addi	sp,sp,-16
    80002d48:	00113423          	sd	ra,8(sp)
    80002d4c:	00813023          	sd	s0,0(sp)
    80002d50:	01010413          	addi	s0,sp,16
    80002d54:	00800513          	li	a0,8
    80002d58:	00001097          	auipc	ra,0x1
    80002d5c:	9d8080e7          	jalr	-1576(ra) # 80003730 <uartputc_sync>
    80002d60:	02000513          	li	a0,32
    80002d64:	00001097          	auipc	ra,0x1
    80002d68:	9cc080e7          	jalr	-1588(ra) # 80003730 <uartputc_sync>
    80002d6c:	00013403          	ld	s0,0(sp)
    80002d70:	00813083          	ld	ra,8(sp)
    80002d74:	00800513          	li	a0,8
    80002d78:	01010113          	addi	sp,sp,16
    80002d7c:	00001317          	auipc	t1,0x1
    80002d80:	9b430067          	jr	-1612(t1) # 80003730 <uartputc_sync>

0000000080002d84 <consoleintr>:
    80002d84:	fe010113          	addi	sp,sp,-32
    80002d88:	00813823          	sd	s0,16(sp)
    80002d8c:	00913423          	sd	s1,8(sp)
    80002d90:	01213023          	sd	s2,0(sp)
    80002d94:	00113c23          	sd	ra,24(sp)
    80002d98:	02010413          	addi	s0,sp,32
    80002d9c:	00006917          	auipc	s2,0x6
    80002da0:	d6c90913          	addi	s2,s2,-660 # 80008b08 <cons>
    80002da4:	00050493          	mv	s1,a0
    80002da8:	00090513          	mv	a0,s2
    80002dac:	00001097          	auipc	ra,0x1
    80002db0:	e40080e7          	jalr	-448(ra) # 80003bec <acquire>
    80002db4:	02048c63          	beqz	s1,80002dec <consoleintr+0x68>
    80002db8:	0a092783          	lw	a5,160(s2)
    80002dbc:	09892703          	lw	a4,152(s2)
    80002dc0:	07f00693          	li	a3,127
    80002dc4:	40e7873b          	subw	a4,a5,a4
    80002dc8:	02e6e263          	bltu	a3,a4,80002dec <consoleintr+0x68>
    80002dcc:	00d00713          	li	a4,13
    80002dd0:	04e48063          	beq	s1,a4,80002e10 <consoleintr+0x8c>
    80002dd4:	07f7f713          	andi	a4,a5,127
    80002dd8:	00e90733          	add	a4,s2,a4
    80002ddc:	0017879b          	addiw	a5,a5,1
    80002de0:	0af92023          	sw	a5,160(s2)
    80002de4:	00970c23          	sb	s1,24(a4)
    80002de8:	08f92e23          	sw	a5,156(s2)
    80002dec:	01013403          	ld	s0,16(sp)
    80002df0:	01813083          	ld	ra,24(sp)
    80002df4:	00813483          	ld	s1,8(sp)
    80002df8:	00013903          	ld	s2,0(sp)
    80002dfc:	00006517          	auipc	a0,0x6
    80002e00:	d0c50513          	addi	a0,a0,-756 # 80008b08 <cons>
    80002e04:	02010113          	addi	sp,sp,32
    80002e08:	00001317          	auipc	t1,0x1
    80002e0c:	eb030067          	jr	-336(t1) # 80003cb8 <release>
    80002e10:	00a00493          	li	s1,10
    80002e14:	fc1ff06f          	j	80002dd4 <consoleintr+0x50>

0000000080002e18 <consoleinit>:
    80002e18:	fe010113          	addi	sp,sp,-32
    80002e1c:	00113c23          	sd	ra,24(sp)
    80002e20:	00813823          	sd	s0,16(sp)
    80002e24:	00913423          	sd	s1,8(sp)
    80002e28:	02010413          	addi	s0,sp,32
    80002e2c:	00006497          	auipc	s1,0x6
    80002e30:	cdc48493          	addi	s1,s1,-804 # 80008b08 <cons>
    80002e34:	00048513          	mv	a0,s1
    80002e38:	00002597          	auipc	a1,0x2
    80002e3c:	3a858593          	addi	a1,a1,936 # 800051e0 <CONSOLE_STATUS+0x1c8>
    80002e40:	00001097          	auipc	ra,0x1
    80002e44:	d88080e7          	jalr	-632(ra) # 80003bc8 <initlock>
    80002e48:	00000097          	auipc	ra,0x0
    80002e4c:	7ac080e7          	jalr	1964(ra) # 800035f4 <uartinit>
    80002e50:	01813083          	ld	ra,24(sp)
    80002e54:	01013403          	ld	s0,16(sp)
    80002e58:	00000797          	auipc	a5,0x0
    80002e5c:	d9c78793          	addi	a5,a5,-612 # 80002bf4 <consoleread>
    80002e60:	0af4bc23          	sd	a5,184(s1)
    80002e64:	00000797          	auipc	a5,0x0
    80002e68:	cec78793          	addi	a5,a5,-788 # 80002b50 <consolewrite>
    80002e6c:	0cf4b023          	sd	a5,192(s1)
    80002e70:	00813483          	ld	s1,8(sp)
    80002e74:	02010113          	addi	sp,sp,32
    80002e78:	00008067          	ret

0000000080002e7c <console_read>:
    80002e7c:	ff010113          	addi	sp,sp,-16
    80002e80:	00813423          	sd	s0,8(sp)
    80002e84:	01010413          	addi	s0,sp,16
    80002e88:	00813403          	ld	s0,8(sp)
    80002e8c:	00006317          	auipc	t1,0x6
    80002e90:	d3433303          	ld	t1,-716(t1) # 80008bc0 <devsw+0x10>
    80002e94:	01010113          	addi	sp,sp,16
    80002e98:	00030067          	jr	t1

0000000080002e9c <console_write>:
    80002e9c:	ff010113          	addi	sp,sp,-16
    80002ea0:	00813423          	sd	s0,8(sp)
    80002ea4:	01010413          	addi	s0,sp,16
    80002ea8:	00813403          	ld	s0,8(sp)
    80002eac:	00006317          	auipc	t1,0x6
    80002eb0:	d1c33303          	ld	t1,-740(t1) # 80008bc8 <devsw+0x18>
    80002eb4:	01010113          	addi	sp,sp,16
    80002eb8:	00030067          	jr	t1

0000000080002ebc <panic>:
    80002ebc:	fe010113          	addi	sp,sp,-32
    80002ec0:	00113c23          	sd	ra,24(sp)
    80002ec4:	00813823          	sd	s0,16(sp)
    80002ec8:	00913423          	sd	s1,8(sp)
    80002ecc:	02010413          	addi	s0,sp,32
    80002ed0:	00050493          	mv	s1,a0
    80002ed4:	00002517          	auipc	a0,0x2
    80002ed8:	31450513          	addi	a0,a0,788 # 800051e8 <CONSOLE_STATUS+0x1d0>
    80002edc:	00006797          	auipc	a5,0x6
    80002ee0:	d807a623          	sw	zero,-628(a5) # 80008c68 <pr+0x18>
    80002ee4:	00000097          	auipc	ra,0x0
    80002ee8:	034080e7          	jalr	52(ra) # 80002f18 <__printf>
    80002eec:	00048513          	mv	a0,s1
    80002ef0:	00000097          	auipc	ra,0x0
    80002ef4:	028080e7          	jalr	40(ra) # 80002f18 <__printf>
    80002ef8:	00002517          	auipc	a0,0x2
    80002efc:	2d050513          	addi	a0,a0,720 # 800051c8 <CONSOLE_STATUS+0x1b0>
    80002f00:	00000097          	auipc	ra,0x0
    80002f04:	018080e7          	jalr	24(ra) # 80002f18 <__printf>
    80002f08:	00100793          	li	a5,1
    80002f0c:	00002717          	auipc	a4,0x2
    80002f10:	50f72023          	sw	a5,1280(a4) # 8000540c <panicked>
    80002f14:	0000006f          	j	80002f14 <panic+0x58>

0000000080002f18 <__printf>:
    80002f18:	f3010113          	addi	sp,sp,-208
    80002f1c:	08813023          	sd	s0,128(sp)
    80002f20:	07313423          	sd	s3,104(sp)
    80002f24:	09010413          	addi	s0,sp,144
    80002f28:	05813023          	sd	s8,64(sp)
    80002f2c:	08113423          	sd	ra,136(sp)
    80002f30:	06913c23          	sd	s1,120(sp)
    80002f34:	07213823          	sd	s2,112(sp)
    80002f38:	07413023          	sd	s4,96(sp)
    80002f3c:	05513c23          	sd	s5,88(sp)
    80002f40:	05613823          	sd	s6,80(sp)
    80002f44:	05713423          	sd	s7,72(sp)
    80002f48:	03913c23          	sd	s9,56(sp)
    80002f4c:	03a13823          	sd	s10,48(sp)
    80002f50:	03b13423          	sd	s11,40(sp)
    80002f54:	00006317          	auipc	t1,0x6
    80002f58:	cfc30313          	addi	t1,t1,-772 # 80008c50 <pr>
    80002f5c:	01832c03          	lw	s8,24(t1)
    80002f60:	00b43423          	sd	a1,8(s0)
    80002f64:	00c43823          	sd	a2,16(s0)
    80002f68:	00d43c23          	sd	a3,24(s0)
    80002f6c:	02e43023          	sd	a4,32(s0)
    80002f70:	02f43423          	sd	a5,40(s0)
    80002f74:	03043823          	sd	a6,48(s0)
    80002f78:	03143c23          	sd	a7,56(s0)
    80002f7c:	00050993          	mv	s3,a0
    80002f80:	4a0c1663          	bnez	s8,8000342c <__printf+0x514>
    80002f84:	60098c63          	beqz	s3,8000359c <__printf+0x684>
    80002f88:	0009c503          	lbu	a0,0(s3)
    80002f8c:	00840793          	addi	a5,s0,8
    80002f90:	f6f43c23          	sd	a5,-136(s0)
    80002f94:	00000493          	li	s1,0
    80002f98:	22050063          	beqz	a0,800031b8 <__printf+0x2a0>
    80002f9c:	00002a37          	lui	s4,0x2
    80002fa0:	00018ab7          	lui	s5,0x18
    80002fa4:	000f4b37          	lui	s6,0xf4
    80002fa8:	00989bb7          	lui	s7,0x989
    80002fac:	70fa0a13          	addi	s4,s4,1807 # 270f <_entry-0x7fffd8f1>
    80002fb0:	69fa8a93          	addi	s5,s5,1695 # 1869f <_entry-0x7ffe7961>
    80002fb4:	23fb0b13          	addi	s6,s6,575 # f423f <_entry-0x7ff0bdc1>
    80002fb8:	67fb8b93          	addi	s7,s7,1663 # 98967f <_entry-0x7f676981>
    80002fbc:	00148c9b          	addiw	s9,s1,1
    80002fc0:	02500793          	li	a5,37
    80002fc4:	01998933          	add	s2,s3,s9
    80002fc8:	38f51263          	bne	a0,a5,8000334c <__printf+0x434>
    80002fcc:	00094783          	lbu	a5,0(s2)
    80002fd0:	00078c9b          	sext.w	s9,a5
    80002fd4:	1e078263          	beqz	a5,800031b8 <__printf+0x2a0>
    80002fd8:	0024849b          	addiw	s1,s1,2
    80002fdc:	07000713          	li	a4,112
    80002fe0:	00998933          	add	s2,s3,s1
    80002fe4:	38e78a63          	beq	a5,a4,80003378 <__printf+0x460>
    80002fe8:	20f76863          	bltu	a4,a5,800031f8 <__printf+0x2e0>
    80002fec:	42a78863          	beq	a5,a0,8000341c <__printf+0x504>
    80002ff0:	06400713          	li	a4,100
    80002ff4:	40e79663          	bne	a5,a4,80003400 <__printf+0x4e8>
    80002ff8:	f7843783          	ld	a5,-136(s0)
    80002ffc:	0007a603          	lw	a2,0(a5)
    80003000:	00878793          	addi	a5,a5,8
    80003004:	f6f43c23          	sd	a5,-136(s0)
    80003008:	42064a63          	bltz	a2,8000343c <__printf+0x524>
    8000300c:	00a00713          	li	a4,10
    80003010:	02e677bb          	remuw	a5,a2,a4
    80003014:	00002d97          	auipc	s11,0x2
    80003018:	1fcd8d93          	addi	s11,s11,508 # 80005210 <digits>
    8000301c:	00900593          	li	a1,9
    80003020:	0006051b          	sext.w	a0,a2
    80003024:	00000c93          	li	s9,0
    80003028:	02079793          	slli	a5,a5,0x20
    8000302c:	0207d793          	srli	a5,a5,0x20
    80003030:	00fd87b3          	add	a5,s11,a5
    80003034:	0007c783          	lbu	a5,0(a5)
    80003038:	02e656bb          	divuw	a3,a2,a4
    8000303c:	f8f40023          	sb	a5,-128(s0)
    80003040:	14c5d863          	bge	a1,a2,80003190 <__printf+0x278>
    80003044:	06300593          	li	a1,99
    80003048:	00100c93          	li	s9,1
    8000304c:	02e6f7bb          	remuw	a5,a3,a4
    80003050:	02079793          	slli	a5,a5,0x20
    80003054:	0207d793          	srli	a5,a5,0x20
    80003058:	00fd87b3          	add	a5,s11,a5
    8000305c:	0007c783          	lbu	a5,0(a5)
    80003060:	02e6d73b          	divuw	a4,a3,a4
    80003064:	f8f400a3          	sb	a5,-127(s0)
    80003068:	12a5f463          	bgeu	a1,a0,80003190 <__printf+0x278>
    8000306c:	00a00693          	li	a3,10
    80003070:	00900593          	li	a1,9
    80003074:	02d777bb          	remuw	a5,a4,a3
    80003078:	02079793          	slli	a5,a5,0x20
    8000307c:	0207d793          	srli	a5,a5,0x20
    80003080:	00fd87b3          	add	a5,s11,a5
    80003084:	0007c503          	lbu	a0,0(a5)
    80003088:	02d757bb          	divuw	a5,a4,a3
    8000308c:	f8a40123          	sb	a0,-126(s0)
    80003090:	48e5f263          	bgeu	a1,a4,80003514 <__printf+0x5fc>
    80003094:	06300513          	li	a0,99
    80003098:	02d7f5bb          	remuw	a1,a5,a3
    8000309c:	02059593          	slli	a1,a1,0x20
    800030a0:	0205d593          	srli	a1,a1,0x20
    800030a4:	00bd85b3          	add	a1,s11,a1
    800030a8:	0005c583          	lbu	a1,0(a1)
    800030ac:	02d7d7bb          	divuw	a5,a5,a3
    800030b0:	f8b401a3          	sb	a1,-125(s0)
    800030b4:	48e57263          	bgeu	a0,a4,80003538 <__printf+0x620>
    800030b8:	3e700513          	li	a0,999
    800030bc:	02d7f5bb          	remuw	a1,a5,a3
    800030c0:	02059593          	slli	a1,a1,0x20
    800030c4:	0205d593          	srli	a1,a1,0x20
    800030c8:	00bd85b3          	add	a1,s11,a1
    800030cc:	0005c583          	lbu	a1,0(a1)
    800030d0:	02d7d7bb          	divuw	a5,a5,a3
    800030d4:	f8b40223          	sb	a1,-124(s0)
    800030d8:	46e57663          	bgeu	a0,a4,80003544 <__printf+0x62c>
    800030dc:	02d7f5bb          	remuw	a1,a5,a3
    800030e0:	02059593          	slli	a1,a1,0x20
    800030e4:	0205d593          	srli	a1,a1,0x20
    800030e8:	00bd85b3          	add	a1,s11,a1
    800030ec:	0005c583          	lbu	a1,0(a1)
    800030f0:	02d7d7bb          	divuw	a5,a5,a3
    800030f4:	f8b402a3          	sb	a1,-123(s0)
    800030f8:	46ea7863          	bgeu	s4,a4,80003568 <__printf+0x650>
    800030fc:	02d7f5bb          	remuw	a1,a5,a3
    80003100:	02059593          	slli	a1,a1,0x20
    80003104:	0205d593          	srli	a1,a1,0x20
    80003108:	00bd85b3          	add	a1,s11,a1
    8000310c:	0005c583          	lbu	a1,0(a1)
    80003110:	02d7d7bb          	divuw	a5,a5,a3
    80003114:	f8b40323          	sb	a1,-122(s0)
    80003118:	3eeaf863          	bgeu	s5,a4,80003508 <__printf+0x5f0>
    8000311c:	02d7f5bb          	remuw	a1,a5,a3
    80003120:	02059593          	slli	a1,a1,0x20
    80003124:	0205d593          	srli	a1,a1,0x20
    80003128:	00bd85b3          	add	a1,s11,a1
    8000312c:	0005c583          	lbu	a1,0(a1)
    80003130:	02d7d7bb          	divuw	a5,a5,a3
    80003134:	f8b403a3          	sb	a1,-121(s0)
    80003138:	42eb7e63          	bgeu	s6,a4,80003574 <__printf+0x65c>
    8000313c:	02d7f5bb          	remuw	a1,a5,a3
    80003140:	02059593          	slli	a1,a1,0x20
    80003144:	0205d593          	srli	a1,a1,0x20
    80003148:	00bd85b3          	add	a1,s11,a1
    8000314c:	0005c583          	lbu	a1,0(a1)
    80003150:	02d7d7bb          	divuw	a5,a5,a3
    80003154:	f8b40423          	sb	a1,-120(s0)
    80003158:	42ebfc63          	bgeu	s7,a4,80003590 <__printf+0x678>
    8000315c:	02079793          	slli	a5,a5,0x20
    80003160:	0207d793          	srli	a5,a5,0x20
    80003164:	00fd8db3          	add	s11,s11,a5
    80003168:	000dc703          	lbu	a4,0(s11)
    8000316c:	00a00793          	li	a5,10
    80003170:	00900c93          	li	s9,9
    80003174:	f8e404a3          	sb	a4,-119(s0)
    80003178:	00065c63          	bgez	a2,80003190 <__printf+0x278>
    8000317c:	f9040713          	addi	a4,s0,-112
    80003180:	00f70733          	add	a4,a4,a5
    80003184:	02d00693          	li	a3,45
    80003188:	fed70823          	sb	a3,-16(a4)
    8000318c:	00078c93          	mv	s9,a5
    80003190:	f8040793          	addi	a5,s0,-128
    80003194:	01978cb3          	add	s9,a5,s9
    80003198:	f7f40d13          	addi	s10,s0,-129
    8000319c:	000cc503          	lbu	a0,0(s9)
    800031a0:	fffc8c93          	addi	s9,s9,-1
    800031a4:	00000097          	auipc	ra,0x0
    800031a8:	b90080e7          	jalr	-1136(ra) # 80002d34 <consputc>
    800031ac:	ffac98e3          	bne	s9,s10,8000319c <__printf+0x284>
    800031b0:	00094503          	lbu	a0,0(s2)
    800031b4:	e00514e3          	bnez	a0,80002fbc <__printf+0xa4>
    800031b8:	1a0c1663          	bnez	s8,80003364 <__printf+0x44c>
    800031bc:	08813083          	ld	ra,136(sp)
    800031c0:	08013403          	ld	s0,128(sp)
    800031c4:	07813483          	ld	s1,120(sp)
    800031c8:	07013903          	ld	s2,112(sp)
    800031cc:	06813983          	ld	s3,104(sp)
    800031d0:	06013a03          	ld	s4,96(sp)
    800031d4:	05813a83          	ld	s5,88(sp)
    800031d8:	05013b03          	ld	s6,80(sp)
    800031dc:	04813b83          	ld	s7,72(sp)
    800031e0:	04013c03          	ld	s8,64(sp)
    800031e4:	03813c83          	ld	s9,56(sp)
    800031e8:	03013d03          	ld	s10,48(sp)
    800031ec:	02813d83          	ld	s11,40(sp)
    800031f0:	0d010113          	addi	sp,sp,208
    800031f4:	00008067          	ret
    800031f8:	07300713          	li	a4,115
    800031fc:	1ce78a63          	beq	a5,a4,800033d0 <__printf+0x4b8>
    80003200:	07800713          	li	a4,120
    80003204:	1ee79e63          	bne	a5,a4,80003400 <__printf+0x4e8>
    80003208:	f7843783          	ld	a5,-136(s0)
    8000320c:	0007a703          	lw	a4,0(a5)
    80003210:	00878793          	addi	a5,a5,8
    80003214:	f6f43c23          	sd	a5,-136(s0)
    80003218:	28074263          	bltz	a4,8000349c <__printf+0x584>
    8000321c:	00002d97          	auipc	s11,0x2
    80003220:	ff4d8d93          	addi	s11,s11,-12 # 80005210 <digits>
    80003224:	00f77793          	andi	a5,a4,15
    80003228:	00fd87b3          	add	a5,s11,a5
    8000322c:	0007c683          	lbu	a3,0(a5)
    80003230:	00f00613          	li	a2,15
    80003234:	0007079b          	sext.w	a5,a4
    80003238:	f8d40023          	sb	a3,-128(s0)
    8000323c:	0047559b          	srliw	a1,a4,0x4
    80003240:	0047569b          	srliw	a3,a4,0x4
    80003244:	00000c93          	li	s9,0
    80003248:	0ee65063          	bge	a2,a4,80003328 <__printf+0x410>
    8000324c:	00f6f693          	andi	a3,a3,15
    80003250:	00dd86b3          	add	a3,s11,a3
    80003254:	0006c683          	lbu	a3,0(a3) # 2004000 <_entry-0x7dffc000>
    80003258:	0087d79b          	srliw	a5,a5,0x8
    8000325c:	00100c93          	li	s9,1
    80003260:	f8d400a3          	sb	a3,-127(s0)
    80003264:	0cb67263          	bgeu	a2,a1,80003328 <__printf+0x410>
    80003268:	00f7f693          	andi	a3,a5,15
    8000326c:	00dd86b3          	add	a3,s11,a3
    80003270:	0006c583          	lbu	a1,0(a3)
    80003274:	00f00613          	li	a2,15
    80003278:	0047d69b          	srliw	a3,a5,0x4
    8000327c:	f8b40123          	sb	a1,-126(s0)
    80003280:	0047d593          	srli	a1,a5,0x4
    80003284:	28f67e63          	bgeu	a2,a5,80003520 <__printf+0x608>
    80003288:	00f6f693          	andi	a3,a3,15
    8000328c:	00dd86b3          	add	a3,s11,a3
    80003290:	0006c503          	lbu	a0,0(a3)
    80003294:	0087d813          	srli	a6,a5,0x8
    80003298:	0087d69b          	srliw	a3,a5,0x8
    8000329c:	f8a401a3          	sb	a0,-125(s0)
    800032a0:	28b67663          	bgeu	a2,a1,8000352c <__printf+0x614>
    800032a4:	00f6f693          	andi	a3,a3,15
    800032a8:	00dd86b3          	add	a3,s11,a3
    800032ac:	0006c583          	lbu	a1,0(a3)
    800032b0:	00c7d513          	srli	a0,a5,0xc
    800032b4:	00c7d69b          	srliw	a3,a5,0xc
    800032b8:	f8b40223          	sb	a1,-124(s0)
    800032bc:	29067a63          	bgeu	a2,a6,80003550 <__printf+0x638>
    800032c0:	00f6f693          	andi	a3,a3,15
    800032c4:	00dd86b3          	add	a3,s11,a3
    800032c8:	0006c583          	lbu	a1,0(a3)
    800032cc:	0107d813          	srli	a6,a5,0x10
    800032d0:	0107d69b          	srliw	a3,a5,0x10
    800032d4:	f8b402a3          	sb	a1,-123(s0)
    800032d8:	28a67263          	bgeu	a2,a0,8000355c <__printf+0x644>
    800032dc:	00f6f693          	andi	a3,a3,15
    800032e0:	00dd86b3          	add	a3,s11,a3
    800032e4:	0006c683          	lbu	a3,0(a3)
    800032e8:	0147d79b          	srliw	a5,a5,0x14
    800032ec:	f8d40323          	sb	a3,-122(s0)
    800032f0:	21067663          	bgeu	a2,a6,800034fc <__printf+0x5e4>
    800032f4:	02079793          	slli	a5,a5,0x20
    800032f8:	0207d793          	srli	a5,a5,0x20
    800032fc:	00fd8db3          	add	s11,s11,a5
    80003300:	000dc683          	lbu	a3,0(s11)
    80003304:	00800793          	li	a5,8
    80003308:	00700c93          	li	s9,7
    8000330c:	f8d403a3          	sb	a3,-121(s0)
    80003310:	00075c63          	bgez	a4,80003328 <__printf+0x410>
    80003314:	f9040713          	addi	a4,s0,-112
    80003318:	00f70733          	add	a4,a4,a5
    8000331c:	02d00693          	li	a3,45
    80003320:	fed70823          	sb	a3,-16(a4)
    80003324:	00078c93          	mv	s9,a5
    80003328:	f8040793          	addi	a5,s0,-128
    8000332c:	01978cb3          	add	s9,a5,s9
    80003330:	f7f40d13          	addi	s10,s0,-129
    80003334:	000cc503          	lbu	a0,0(s9)
    80003338:	fffc8c93          	addi	s9,s9,-1
    8000333c:	00000097          	auipc	ra,0x0
    80003340:	9f8080e7          	jalr	-1544(ra) # 80002d34 <consputc>
    80003344:	ff9d18e3          	bne	s10,s9,80003334 <__printf+0x41c>
    80003348:	0100006f          	j	80003358 <__printf+0x440>
    8000334c:	00000097          	auipc	ra,0x0
    80003350:	9e8080e7          	jalr	-1560(ra) # 80002d34 <consputc>
    80003354:	000c8493          	mv	s1,s9
    80003358:	00094503          	lbu	a0,0(s2)
    8000335c:	c60510e3          	bnez	a0,80002fbc <__printf+0xa4>
    80003360:	e40c0ee3          	beqz	s8,800031bc <__printf+0x2a4>
    80003364:	00006517          	auipc	a0,0x6
    80003368:	8ec50513          	addi	a0,a0,-1812 # 80008c50 <pr>
    8000336c:	00001097          	auipc	ra,0x1
    80003370:	94c080e7          	jalr	-1716(ra) # 80003cb8 <release>
    80003374:	e49ff06f          	j	800031bc <__printf+0x2a4>
    80003378:	f7843783          	ld	a5,-136(s0)
    8000337c:	03000513          	li	a0,48
    80003380:	01000d13          	li	s10,16
    80003384:	00878713          	addi	a4,a5,8
    80003388:	0007bc83          	ld	s9,0(a5)
    8000338c:	f6e43c23          	sd	a4,-136(s0)
    80003390:	00000097          	auipc	ra,0x0
    80003394:	9a4080e7          	jalr	-1628(ra) # 80002d34 <consputc>
    80003398:	07800513          	li	a0,120
    8000339c:	00000097          	auipc	ra,0x0
    800033a0:	998080e7          	jalr	-1640(ra) # 80002d34 <consputc>
    800033a4:	00002d97          	auipc	s11,0x2
    800033a8:	e6cd8d93          	addi	s11,s11,-404 # 80005210 <digits>
    800033ac:	03ccd793          	srli	a5,s9,0x3c
    800033b0:	00fd87b3          	add	a5,s11,a5
    800033b4:	0007c503          	lbu	a0,0(a5)
    800033b8:	fffd0d1b          	addiw	s10,s10,-1
    800033bc:	004c9c93          	slli	s9,s9,0x4
    800033c0:	00000097          	auipc	ra,0x0
    800033c4:	974080e7          	jalr	-1676(ra) # 80002d34 <consputc>
    800033c8:	fe0d12e3          	bnez	s10,800033ac <__printf+0x494>
    800033cc:	f8dff06f          	j	80003358 <__printf+0x440>
    800033d0:	f7843783          	ld	a5,-136(s0)
    800033d4:	0007bc83          	ld	s9,0(a5)
    800033d8:	00878793          	addi	a5,a5,8
    800033dc:	f6f43c23          	sd	a5,-136(s0)
    800033e0:	000c9a63          	bnez	s9,800033f4 <__printf+0x4dc>
    800033e4:	1080006f          	j	800034ec <__printf+0x5d4>
    800033e8:	001c8c93          	addi	s9,s9,1
    800033ec:	00000097          	auipc	ra,0x0
    800033f0:	948080e7          	jalr	-1720(ra) # 80002d34 <consputc>
    800033f4:	000cc503          	lbu	a0,0(s9)
    800033f8:	fe0518e3          	bnez	a0,800033e8 <__printf+0x4d0>
    800033fc:	f5dff06f          	j	80003358 <__printf+0x440>
    80003400:	02500513          	li	a0,37
    80003404:	00000097          	auipc	ra,0x0
    80003408:	930080e7          	jalr	-1744(ra) # 80002d34 <consputc>
    8000340c:	000c8513          	mv	a0,s9
    80003410:	00000097          	auipc	ra,0x0
    80003414:	924080e7          	jalr	-1756(ra) # 80002d34 <consputc>
    80003418:	f41ff06f          	j	80003358 <__printf+0x440>
    8000341c:	02500513          	li	a0,37
    80003420:	00000097          	auipc	ra,0x0
    80003424:	914080e7          	jalr	-1772(ra) # 80002d34 <consputc>
    80003428:	f31ff06f          	j	80003358 <__printf+0x440>
    8000342c:	00030513          	mv	a0,t1
    80003430:	00000097          	auipc	ra,0x0
    80003434:	7bc080e7          	jalr	1980(ra) # 80003bec <acquire>
    80003438:	b4dff06f          	j	80002f84 <__printf+0x6c>
    8000343c:	40c0053b          	negw	a0,a2
    80003440:	00a00713          	li	a4,10
    80003444:	02e576bb          	remuw	a3,a0,a4
    80003448:	00002d97          	auipc	s11,0x2
    8000344c:	dc8d8d93          	addi	s11,s11,-568 # 80005210 <digits>
    80003450:	ff700593          	li	a1,-9
    80003454:	02069693          	slli	a3,a3,0x20
    80003458:	0206d693          	srli	a3,a3,0x20
    8000345c:	00dd86b3          	add	a3,s11,a3
    80003460:	0006c683          	lbu	a3,0(a3)
    80003464:	02e557bb          	divuw	a5,a0,a4
    80003468:	f8d40023          	sb	a3,-128(s0)
    8000346c:	10b65e63          	bge	a2,a1,80003588 <__printf+0x670>
    80003470:	06300593          	li	a1,99
    80003474:	02e7f6bb          	remuw	a3,a5,a4
    80003478:	02069693          	slli	a3,a3,0x20
    8000347c:	0206d693          	srli	a3,a3,0x20
    80003480:	00dd86b3          	add	a3,s11,a3
    80003484:	0006c683          	lbu	a3,0(a3)
    80003488:	02e7d73b          	divuw	a4,a5,a4
    8000348c:	00200793          	li	a5,2
    80003490:	f8d400a3          	sb	a3,-127(s0)
    80003494:	bca5ece3          	bltu	a1,a0,8000306c <__printf+0x154>
    80003498:	ce5ff06f          	j	8000317c <__printf+0x264>
    8000349c:	40e007bb          	negw	a5,a4
    800034a0:	00002d97          	auipc	s11,0x2
    800034a4:	d70d8d93          	addi	s11,s11,-656 # 80005210 <digits>
    800034a8:	00f7f693          	andi	a3,a5,15
    800034ac:	00dd86b3          	add	a3,s11,a3
    800034b0:	0006c583          	lbu	a1,0(a3)
    800034b4:	ff100613          	li	a2,-15
    800034b8:	0047d69b          	srliw	a3,a5,0x4
    800034bc:	f8b40023          	sb	a1,-128(s0)
    800034c0:	0047d59b          	srliw	a1,a5,0x4
    800034c4:	0ac75e63          	bge	a4,a2,80003580 <__printf+0x668>
    800034c8:	00f6f693          	andi	a3,a3,15
    800034cc:	00dd86b3          	add	a3,s11,a3
    800034d0:	0006c603          	lbu	a2,0(a3)
    800034d4:	00f00693          	li	a3,15
    800034d8:	0087d79b          	srliw	a5,a5,0x8
    800034dc:	f8c400a3          	sb	a2,-127(s0)
    800034e0:	d8b6e4e3          	bltu	a3,a1,80003268 <__printf+0x350>
    800034e4:	00200793          	li	a5,2
    800034e8:	e2dff06f          	j	80003314 <__printf+0x3fc>
    800034ec:	00002c97          	auipc	s9,0x2
    800034f0:	d04c8c93          	addi	s9,s9,-764 # 800051f0 <CONSOLE_STATUS+0x1d8>
    800034f4:	02800513          	li	a0,40
    800034f8:	ef1ff06f          	j	800033e8 <__printf+0x4d0>
    800034fc:	00700793          	li	a5,7
    80003500:	00600c93          	li	s9,6
    80003504:	e0dff06f          	j	80003310 <__printf+0x3f8>
    80003508:	00700793          	li	a5,7
    8000350c:	00600c93          	li	s9,6
    80003510:	c69ff06f          	j	80003178 <__printf+0x260>
    80003514:	00300793          	li	a5,3
    80003518:	00200c93          	li	s9,2
    8000351c:	c5dff06f          	j	80003178 <__printf+0x260>
    80003520:	00300793          	li	a5,3
    80003524:	00200c93          	li	s9,2
    80003528:	de9ff06f          	j	80003310 <__printf+0x3f8>
    8000352c:	00400793          	li	a5,4
    80003530:	00300c93          	li	s9,3
    80003534:	dddff06f          	j	80003310 <__printf+0x3f8>
    80003538:	00400793          	li	a5,4
    8000353c:	00300c93          	li	s9,3
    80003540:	c39ff06f          	j	80003178 <__printf+0x260>
    80003544:	00500793          	li	a5,5
    80003548:	00400c93          	li	s9,4
    8000354c:	c2dff06f          	j	80003178 <__printf+0x260>
    80003550:	00500793          	li	a5,5
    80003554:	00400c93          	li	s9,4
    80003558:	db9ff06f          	j	80003310 <__printf+0x3f8>
    8000355c:	00600793          	li	a5,6
    80003560:	00500c93          	li	s9,5
    80003564:	dadff06f          	j	80003310 <__printf+0x3f8>
    80003568:	00600793          	li	a5,6
    8000356c:	00500c93          	li	s9,5
    80003570:	c09ff06f          	j	80003178 <__printf+0x260>
    80003574:	00800793          	li	a5,8
    80003578:	00700c93          	li	s9,7
    8000357c:	bfdff06f          	j	80003178 <__printf+0x260>
    80003580:	00100793          	li	a5,1
    80003584:	d91ff06f          	j	80003314 <__printf+0x3fc>
    80003588:	00100793          	li	a5,1
    8000358c:	bf1ff06f          	j	8000317c <__printf+0x264>
    80003590:	00900793          	li	a5,9
    80003594:	00800c93          	li	s9,8
    80003598:	be1ff06f          	j	80003178 <__printf+0x260>
    8000359c:	00002517          	auipc	a0,0x2
    800035a0:	c5c50513          	addi	a0,a0,-932 # 800051f8 <CONSOLE_STATUS+0x1e0>
    800035a4:	00000097          	auipc	ra,0x0
    800035a8:	918080e7          	jalr	-1768(ra) # 80002ebc <panic>

00000000800035ac <printfinit>:
    800035ac:	fe010113          	addi	sp,sp,-32
    800035b0:	00813823          	sd	s0,16(sp)
    800035b4:	00913423          	sd	s1,8(sp)
    800035b8:	00113c23          	sd	ra,24(sp)
    800035bc:	02010413          	addi	s0,sp,32
    800035c0:	00005497          	auipc	s1,0x5
    800035c4:	69048493          	addi	s1,s1,1680 # 80008c50 <pr>
    800035c8:	00048513          	mv	a0,s1
    800035cc:	00002597          	auipc	a1,0x2
    800035d0:	c3c58593          	addi	a1,a1,-964 # 80005208 <CONSOLE_STATUS+0x1f0>
    800035d4:	00000097          	auipc	ra,0x0
    800035d8:	5f4080e7          	jalr	1524(ra) # 80003bc8 <initlock>
    800035dc:	01813083          	ld	ra,24(sp)
    800035e0:	01013403          	ld	s0,16(sp)
    800035e4:	0004ac23          	sw	zero,24(s1)
    800035e8:	00813483          	ld	s1,8(sp)
    800035ec:	02010113          	addi	sp,sp,32
    800035f0:	00008067          	ret

00000000800035f4 <uartinit>:
    800035f4:	ff010113          	addi	sp,sp,-16
    800035f8:	00813423          	sd	s0,8(sp)
    800035fc:	01010413          	addi	s0,sp,16
    80003600:	100007b7          	lui	a5,0x10000
    80003604:	000780a3          	sb	zero,1(a5) # 10000001 <_entry-0x6fffffff>
    80003608:	f8000713          	li	a4,-128
    8000360c:	00e781a3          	sb	a4,3(a5)
    80003610:	00300713          	li	a4,3
    80003614:	00e78023          	sb	a4,0(a5)
    80003618:	000780a3          	sb	zero,1(a5)
    8000361c:	00e781a3          	sb	a4,3(a5)
    80003620:	00700693          	li	a3,7
    80003624:	00d78123          	sb	a3,2(a5)
    80003628:	00e780a3          	sb	a4,1(a5)
    8000362c:	00813403          	ld	s0,8(sp)
    80003630:	01010113          	addi	sp,sp,16
    80003634:	00008067          	ret

0000000080003638 <uartputc>:
    80003638:	00002797          	auipc	a5,0x2
    8000363c:	dd47a783          	lw	a5,-556(a5) # 8000540c <panicked>
    80003640:	00078463          	beqz	a5,80003648 <uartputc+0x10>
    80003644:	0000006f          	j	80003644 <uartputc+0xc>
    80003648:	fd010113          	addi	sp,sp,-48
    8000364c:	02813023          	sd	s0,32(sp)
    80003650:	00913c23          	sd	s1,24(sp)
    80003654:	01213823          	sd	s2,16(sp)
    80003658:	01313423          	sd	s3,8(sp)
    8000365c:	02113423          	sd	ra,40(sp)
    80003660:	03010413          	addi	s0,sp,48
    80003664:	00002917          	auipc	s2,0x2
    80003668:	dac90913          	addi	s2,s2,-596 # 80005410 <uart_tx_r>
    8000366c:	00093783          	ld	a5,0(s2)
    80003670:	00002497          	auipc	s1,0x2
    80003674:	da848493          	addi	s1,s1,-600 # 80005418 <uart_tx_w>
    80003678:	0004b703          	ld	a4,0(s1)
    8000367c:	02078693          	addi	a3,a5,32
    80003680:	00050993          	mv	s3,a0
    80003684:	02e69c63          	bne	a3,a4,800036bc <uartputc+0x84>
    80003688:	00001097          	auipc	ra,0x1
    8000368c:	834080e7          	jalr	-1996(ra) # 80003ebc <push_on>
    80003690:	00093783          	ld	a5,0(s2)
    80003694:	0004b703          	ld	a4,0(s1)
    80003698:	02078793          	addi	a5,a5,32
    8000369c:	00e79463          	bne	a5,a4,800036a4 <uartputc+0x6c>
    800036a0:	0000006f          	j	800036a0 <uartputc+0x68>
    800036a4:	00001097          	auipc	ra,0x1
    800036a8:	88c080e7          	jalr	-1908(ra) # 80003f30 <pop_on>
    800036ac:	00093783          	ld	a5,0(s2)
    800036b0:	0004b703          	ld	a4,0(s1)
    800036b4:	02078693          	addi	a3,a5,32
    800036b8:	fce688e3          	beq	a3,a4,80003688 <uartputc+0x50>
    800036bc:	01f77693          	andi	a3,a4,31
    800036c0:	00005597          	auipc	a1,0x5
    800036c4:	5b058593          	addi	a1,a1,1456 # 80008c70 <uart_tx_buf>
    800036c8:	00d586b3          	add	a3,a1,a3
    800036cc:	00170713          	addi	a4,a4,1
    800036d0:	01368023          	sb	s3,0(a3)
    800036d4:	00e4b023          	sd	a4,0(s1)
    800036d8:	10000637          	lui	a2,0x10000
    800036dc:	02f71063          	bne	a4,a5,800036fc <uartputc+0xc4>
    800036e0:	0340006f          	j	80003714 <uartputc+0xdc>
    800036e4:	00074703          	lbu	a4,0(a4)
    800036e8:	00f93023          	sd	a5,0(s2)
    800036ec:	00e60023          	sb	a4,0(a2) # 10000000 <_entry-0x70000000>
    800036f0:	00093783          	ld	a5,0(s2)
    800036f4:	0004b703          	ld	a4,0(s1)
    800036f8:	00f70e63          	beq	a4,a5,80003714 <uartputc+0xdc>
    800036fc:	00564683          	lbu	a3,5(a2)
    80003700:	01f7f713          	andi	a4,a5,31
    80003704:	00e58733          	add	a4,a1,a4
    80003708:	0206f693          	andi	a3,a3,32
    8000370c:	00178793          	addi	a5,a5,1
    80003710:	fc069ae3          	bnez	a3,800036e4 <uartputc+0xac>
    80003714:	02813083          	ld	ra,40(sp)
    80003718:	02013403          	ld	s0,32(sp)
    8000371c:	01813483          	ld	s1,24(sp)
    80003720:	01013903          	ld	s2,16(sp)
    80003724:	00813983          	ld	s3,8(sp)
    80003728:	03010113          	addi	sp,sp,48
    8000372c:	00008067          	ret

0000000080003730 <uartputc_sync>:
    80003730:	ff010113          	addi	sp,sp,-16
    80003734:	00813423          	sd	s0,8(sp)
    80003738:	01010413          	addi	s0,sp,16
    8000373c:	00002717          	auipc	a4,0x2
    80003740:	cd072703          	lw	a4,-816(a4) # 8000540c <panicked>
    80003744:	02071663          	bnez	a4,80003770 <uartputc_sync+0x40>
    80003748:	00050793          	mv	a5,a0
    8000374c:	100006b7          	lui	a3,0x10000
    80003750:	0056c703          	lbu	a4,5(a3) # 10000005 <_entry-0x6ffffffb>
    80003754:	02077713          	andi	a4,a4,32
    80003758:	fe070ce3          	beqz	a4,80003750 <uartputc_sync+0x20>
    8000375c:	0ff7f793          	andi	a5,a5,255
    80003760:	00f68023          	sb	a5,0(a3)
    80003764:	00813403          	ld	s0,8(sp)
    80003768:	01010113          	addi	sp,sp,16
    8000376c:	00008067          	ret
    80003770:	0000006f          	j	80003770 <uartputc_sync+0x40>

0000000080003774 <uartstart>:
    80003774:	ff010113          	addi	sp,sp,-16
    80003778:	00813423          	sd	s0,8(sp)
    8000377c:	01010413          	addi	s0,sp,16
    80003780:	00002617          	auipc	a2,0x2
    80003784:	c9060613          	addi	a2,a2,-880 # 80005410 <uart_tx_r>
    80003788:	00002517          	auipc	a0,0x2
    8000378c:	c9050513          	addi	a0,a0,-880 # 80005418 <uart_tx_w>
    80003790:	00063783          	ld	a5,0(a2)
    80003794:	00053703          	ld	a4,0(a0)
    80003798:	04f70263          	beq	a4,a5,800037dc <uartstart+0x68>
    8000379c:	100005b7          	lui	a1,0x10000
    800037a0:	00005817          	auipc	a6,0x5
    800037a4:	4d080813          	addi	a6,a6,1232 # 80008c70 <uart_tx_buf>
    800037a8:	01c0006f          	j	800037c4 <uartstart+0x50>
    800037ac:	0006c703          	lbu	a4,0(a3)
    800037b0:	00f63023          	sd	a5,0(a2)
    800037b4:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    800037b8:	00063783          	ld	a5,0(a2)
    800037bc:	00053703          	ld	a4,0(a0)
    800037c0:	00f70e63          	beq	a4,a5,800037dc <uartstart+0x68>
    800037c4:	01f7f713          	andi	a4,a5,31
    800037c8:	00e806b3          	add	a3,a6,a4
    800037cc:	0055c703          	lbu	a4,5(a1)
    800037d0:	00178793          	addi	a5,a5,1
    800037d4:	02077713          	andi	a4,a4,32
    800037d8:	fc071ae3          	bnez	a4,800037ac <uartstart+0x38>
    800037dc:	00813403          	ld	s0,8(sp)
    800037e0:	01010113          	addi	sp,sp,16
    800037e4:	00008067          	ret

00000000800037e8 <uartgetc>:
    800037e8:	ff010113          	addi	sp,sp,-16
    800037ec:	00813423          	sd	s0,8(sp)
    800037f0:	01010413          	addi	s0,sp,16
    800037f4:	10000737          	lui	a4,0x10000
    800037f8:	00574783          	lbu	a5,5(a4) # 10000005 <_entry-0x6ffffffb>
    800037fc:	0017f793          	andi	a5,a5,1
    80003800:	00078c63          	beqz	a5,80003818 <uartgetc+0x30>
    80003804:	00074503          	lbu	a0,0(a4)
    80003808:	0ff57513          	andi	a0,a0,255
    8000380c:	00813403          	ld	s0,8(sp)
    80003810:	01010113          	addi	sp,sp,16
    80003814:	00008067          	ret
    80003818:	fff00513          	li	a0,-1
    8000381c:	ff1ff06f          	j	8000380c <uartgetc+0x24>

0000000080003820 <uartintr>:
    80003820:	100007b7          	lui	a5,0x10000
    80003824:	0057c783          	lbu	a5,5(a5) # 10000005 <_entry-0x6ffffffb>
    80003828:	0017f793          	andi	a5,a5,1
    8000382c:	0a078463          	beqz	a5,800038d4 <uartintr+0xb4>
    80003830:	fe010113          	addi	sp,sp,-32
    80003834:	00813823          	sd	s0,16(sp)
    80003838:	00913423          	sd	s1,8(sp)
    8000383c:	00113c23          	sd	ra,24(sp)
    80003840:	02010413          	addi	s0,sp,32
    80003844:	100004b7          	lui	s1,0x10000
    80003848:	0004c503          	lbu	a0,0(s1) # 10000000 <_entry-0x70000000>
    8000384c:	0ff57513          	andi	a0,a0,255
    80003850:	fffff097          	auipc	ra,0xfffff
    80003854:	534080e7          	jalr	1332(ra) # 80002d84 <consoleintr>
    80003858:	0054c783          	lbu	a5,5(s1)
    8000385c:	0017f793          	andi	a5,a5,1
    80003860:	fe0794e3          	bnez	a5,80003848 <uartintr+0x28>
    80003864:	00002617          	auipc	a2,0x2
    80003868:	bac60613          	addi	a2,a2,-1108 # 80005410 <uart_tx_r>
    8000386c:	00002517          	auipc	a0,0x2
    80003870:	bac50513          	addi	a0,a0,-1108 # 80005418 <uart_tx_w>
    80003874:	00063783          	ld	a5,0(a2)
    80003878:	00053703          	ld	a4,0(a0)
    8000387c:	04f70263          	beq	a4,a5,800038c0 <uartintr+0xa0>
    80003880:	100005b7          	lui	a1,0x10000
    80003884:	00005817          	auipc	a6,0x5
    80003888:	3ec80813          	addi	a6,a6,1004 # 80008c70 <uart_tx_buf>
    8000388c:	01c0006f          	j	800038a8 <uartintr+0x88>
    80003890:	0006c703          	lbu	a4,0(a3)
    80003894:	00f63023          	sd	a5,0(a2)
    80003898:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    8000389c:	00063783          	ld	a5,0(a2)
    800038a0:	00053703          	ld	a4,0(a0)
    800038a4:	00f70e63          	beq	a4,a5,800038c0 <uartintr+0xa0>
    800038a8:	01f7f713          	andi	a4,a5,31
    800038ac:	00e806b3          	add	a3,a6,a4
    800038b0:	0055c703          	lbu	a4,5(a1)
    800038b4:	00178793          	addi	a5,a5,1
    800038b8:	02077713          	andi	a4,a4,32
    800038bc:	fc071ae3          	bnez	a4,80003890 <uartintr+0x70>
    800038c0:	01813083          	ld	ra,24(sp)
    800038c4:	01013403          	ld	s0,16(sp)
    800038c8:	00813483          	ld	s1,8(sp)
    800038cc:	02010113          	addi	sp,sp,32
    800038d0:	00008067          	ret
    800038d4:	00002617          	auipc	a2,0x2
    800038d8:	b3c60613          	addi	a2,a2,-1220 # 80005410 <uart_tx_r>
    800038dc:	00002517          	auipc	a0,0x2
    800038e0:	b3c50513          	addi	a0,a0,-1220 # 80005418 <uart_tx_w>
    800038e4:	00063783          	ld	a5,0(a2)
    800038e8:	00053703          	ld	a4,0(a0)
    800038ec:	04f70263          	beq	a4,a5,80003930 <uartintr+0x110>
    800038f0:	100005b7          	lui	a1,0x10000
    800038f4:	00005817          	auipc	a6,0x5
    800038f8:	37c80813          	addi	a6,a6,892 # 80008c70 <uart_tx_buf>
    800038fc:	01c0006f          	j	80003918 <uartintr+0xf8>
    80003900:	0006c703          	lbu	a4,0(a3)
    80003904:	00f63023          	sd	a5,0(a2)
    80003908:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    8000390c:	00063783          	ld	a5,0(a2)
    80003910:	00053703          	ld	a4,0(a0)
    80003914:	02f70063          	beq	a4,a5,80003934 <uartintr+0x114>
    80003918:	01f7f713          	andi	a4,a5,31
    8000391c:	00e806b3          	add	a3,a6,a4
    80003920:	0055c703          	lbu	a4,5(a1)
    80003924:	00178793          	addi	a5,a5,1
    80003928:	02077713          	andi	a4,a4,32
    8000392c:	fc071ae3          	bnez	a4,80003900 <uartintr+0xe0>
    80003930:	00008067          	ret
    80003934:	00008067          	ret

0000000080003938 <kinit>:
    80003938:	fc010113          	addi	sp,sp,-64
    8000393c:	02913423          	sd	s1,40(sp)
    80003940:	fffff7b7          	lui	a5,0xfffff
    80003944:	00006497          	auipc	s1,0x6
    80003948:	34b48493          	addi	s1,s1,843 # 80009c8f <end+0xfff>
    8000394c:	02813823          	sd	s0,48(sp)
    80003950:	01313c23          	sd	s3,24(sp)
    80003954:	00f4f4b3          	and	s1,s1,a5
    80003958:	02113c23          	sd	ra,56(sp)
    8000395c:	03213023          	sd	s2,32(sp)
    80003960:	01413823          	sd	s4,16(sp)
    80003964:	01513423          	sd	s5,8(sp)
    80003968:	04010413          	addi	s0,sp,64
    8000396c:	000017b7          	lui	a5,0x1
    80003970:	01100993          	li	s3,17
    80003974:	00f487b3          	add	a5,s1,a5
    80003978:	01b99993          	slli	s3,s3,0x1b
    8000397c:	06f9e063          	bltu	s3,a5,800039dc <kinit+0xa4>
    80003980:	00005a97          	auipc	s5,0x5
    80003984:	310a8a93          	addi	s5,s5,784 # 80008c90 <end>
    80003988:	0754ec63          	bltu	s1,s5,80003a00 <kinit+0xc8>
    8000398c:	0734fa63          	bgeu	s1,s3,80003a00 <kinit+0xc8>
    80003990:	00088a37          	lui	s4,0x88
    80003994:	fffa0a13          	addi	s4,s4,-1 # 87fff <_entry-0x7ff78001>
    80003998:	00002917          	auipc	s2,0x2
    8000399c:	a8890913          	addi	s2,s2,-1400 # 80005420 <kmem>
    800039a0:	00ca1a13          	slli	s4,s4,0xc
    800039a4:	0140006f          	j	800039b8 <kinit+0x80>
    800039a8:	000017b7          	lui	a5,0x1
    800039ac:	00f484b3          	add	s1,s1,a5
    800039b0:	0554e863          	bltu	s1,s5,80003a00 <kinit+0xc8>
    800039b4:	0534f663          	bgeu	s1,s3,80003a00 <kinit+0xc8>
    800039b8:	00001637          	lui	a2,0x1
    800039bc:	00100593          	li	a1,1
    800039c0:	00048513          	mv	a0,s1
    800039c4:	00000097          	auipc	ra,0x0
    800039c8:	5e4080e7          	jalr	1508(ra) # 80003fa8 <__memset>
    800039cc:	00093783          	ld	a5,0(s2)
    800039d0:	00f4b023          	sd	a5,0(s1)
    800039d4:	00993023          	sd	s1,0(s2)
    800039d8:	fd4498e3          	bne	s1,s4,800039a8 <kinit+0x70>
    800039dc:	03813083          	ld	ra,56(sp)
    800039e0:	03013403          	ld	s0,48(sp)
    800039e4:	02813483          	ld	s1,40(sp)
    800039e8:	02013903          	ld	s2,32(sp)
    800039ec:	01813983          	ld	s3,24(sp)
    800039f0:	01013a03          	ld	s4,16(sp)
    800039f4:	00813a83          	ld	s5,8(sp)
    800039f8:	04010113          	addi	sp,sp,64
    800039fc:	00008067          	ret
    80003a00:	00002517          	auipc	a0,0x2
    80003a04:	82850513          	addi	a0,a0,-2008 # 80005228 <digits+0x18>
    80003a08:	fffff097          	auipc	ra,0xfffff
    80003a0c:	4b4080e7          	jalr	1204(ra) # 80002ebc <panic>

0000000080003a10 <freerange>:
    80003a10:	fc010113          	addi	sp,sp,-64
    80003a14:	000017b7          	lui	a5,0x1
    80003a18:	02913423          	sd	s1,40(sp)
    80003a1c:	fff78493          	addi	s1,a5,-1 # fff <_entry-0x7ffff001>
    80003a20:	009504b3          	add	s1,a0,s1
    80003a24:	fffff537          	lui	a0,0xfffff
    80003a28:	02813823          	sd	s0,48(sp)
    80003a2c:	02113c23          	sd	ra,56(sp)
    80003a30:	03213023          	sd	s2,32(sp)
    80003a34:	01313c23          	sd	s3,24(sp)
    80003a38:	01413823          	sd	s4,16(sp)
    80003a3c:	01513423          	sd	s5,8(sp)
    80003a40:	01613023          	sd	s6,0(sp)
    80003a44:	04010413          	addi	s0,sp,64
    80003a48:	00a4f4b3          	and	s1,s1,a0
    80003a4c:	00f487b3          	add	a5,s1,a5
    80003a50:	06f5e463          	bltu	a1,a5,80003ab8 <freerange+0xa8>
    80003a54:	00005a97          	auipc	s5,0x5
    80003a58:	23ca8a93          	addi	s5,s5,572 # 80008c90 <end>
    80003a5c:	0954e263          	bltu	s1,s5,80003ae0 <freerange+0xd0>
    80003a60:	01100993          	li	s3,17
    80003a64:	01b99993          	slli	s3,s3,0x1b
    80003a68:	0734fc63          	bgeu	s1,s3,80003ae0 <freerange+0xd0>
    80003a6c:	00058a13          	mv	s4,a1
    80003a70:	00002917          	auipc	s2,0x2
    80003a74:	9b090913          	addi	s2,s2,-1616 # 80005420 <kmem>
    80003a78:	00002b37          	lui	s6,0x2
    80003a7c:	0140006f          	j	80003a90 <freerange+0x80>
    80003a80:	000017b7          	lui	a5,0x1
    80003a84:	00f484b3          	add	s1,s1,a5
    80003a88:	0554ec63          	bltu	s1,s5,80003ae0 <freerange+0xd0>
    80003a8c:	0534fa63          	bgeu	s1,s3,80003ae0 <freerange+0xd0>
    80003a90:	00001637          	lui	a2,0x1
    80003a94:	00100593          	li	a1,1
    80003a98:	00048513          	mv	a0,s1
    80003a9c:	00000097          	auipc	ra,0x0
    80003aa0:	50c080e7          	jalr	1292(ra) # 80003fa8 <__memset>
    80003aa4:	00093703          	ld	a4,0(s2)
    80003aa8:	016487b3          	add	a5,s1,s6
    80003aac:	00e4b023          	sd	a4,0(s1)
    80003ab0:	00993023          	sd	s1,0(s2)
    80003ab4:	fcfa76e3          	bgeu	s4,a5,80003a80 <freerange+0x70>
    80003ab8:	03813083          	ld	ra,56(sp)
    80003abc:	03013403          	ld	s0,48(sp)
    80003ac0:	02813483          	ld	s1,40(sp)
    80003ac4:	02013903          	ld	s2,32(sp)
    80003ac8:	01813983          	ld	s3,24(sp)
    80003acc:	01013a03          	ld	s4,16(sp)
    80003ad0:	00813a83          	ld	s5,8(sp)
    80003ad4:	00013b03          	ld	s6,0(sp)
    80003ad8:	04010113          	addi	sp,sp,64
    80003adc:	00008067          	ret
    80003ae0:	00001517          	auipc	a0,0x1
    80003ae4:	74850513          	addi	a0,a0,1864 # 80005228 <digits+0x18>
    80003ae8:	fffff097          	auipc	ra,0xfffff
    80003aec:	3d4080e7          	jalr	980(ra) # 80002ebc <panic>

0000000080003af0 <kfree>:
    80003af0:	fe010113          	addi	sp,sp,-32
    80003af4:	00813823          	sd	s0,16(sp)
    80003af8:	00113c23          	sd	ra,24(sp)
    80003afc:	00913423          	sd	s1,8(sp)
    80003b00:	02010413          	addi	s0,sp,32
    80003b04:	03451793          	slli	a5,a0,0x34
    80003b08:	04079c63          	bnez	a5,80003b60 <kfree+0x70>
    80003b0c:	00005797          	auipc	a5,0x5
    80003b10:	18478793          	addi	a5,a5,388 # 80008c90 <end>
    80003b14:	00050493          	mv	s1,a0
    80003b18:	04f56463          	bltu	a0,a5,80003b60 <kfree+0x70>
    80003b1c:	01100793          	li	a5,17
    80003b20:	01b79793          	slli	a5,a5,0x1b
    80003b24:	02f57e63          	bgeu	a0,a5,80003b60 <kfree+0x70>
    80003b28:	00001637          	lui	a2,0x1
    80003b2c:	00100593          	li	a1,1
    80003b30:	00000097          	auipc	ra,0x0
    80003b34:	478080e7          	jalr	1144(ra) # 80003fa8 <__memset>
    80003b38:	00002797          	auipc	a5,0x2
    80003b3c:	8e878793          	addi	a5,a5,-1816 # 80005420 <kmem>
    80003b40:	0007b703          	ld	a4,0(a5)
    80003b44:	01813083          	ld	ra,24(sp)
    80003b48:	01013403          	ld	s0,16(sp)
    80003b4c:	00e4b023          	sd	a4,0(s1)
    80003b50:	0097b023          	sd	s1,0(a5)
    80003b54:	00813483          	ld	s1,8(sp)
    80003b58:	02010113          	addi	sp,sp,32
    80003b5c:	00008067          	ret
    80003b60:	00001517          	auipc	a0,0x1
    80003b64:	6c850513          	addi	a0,a0,1736 # 80005228 <digits+0x18>
    80003b68:	fffff097          	auipc	ra,0xfffff
    80003b6c:	354080e7          	jalr	852(ra) # 80002ebc <panic>

0000000080003b70 <kalloc>:
    80003b70:	fe010113          	addi	sp,sp,-32
    80003b74:	00813823          	sd	s0,16(sp)
    80003b78:	00913423          	sd	s1,8(sp)
    80003b7c:	00113c23          	sd	ra,24(sp)
    80003b80:	02010413          	addi	s0,sp,32
    80003b84:	00002797          	auipc	a5,0x2
    80003b88:	89c78793          	addi	a5,a5,-1892 # 80005420 <kmem>
    80003b8c:	0007b483          	ld	s1,0(a5)
    80003b90:	02048063          	beqz	s1,80003bb0 <kalloc+0x40>
    80003b94:	0004b703          	ld	a4,0(s1)
    80003b98:	00001637          	lui	a2,0x1
    80003b9c:	00500593          	li	a1,5
    80003ba0:	00048513          	mv	a0,s1
    80003ba4:	00e7b023          	sd	a4,0(a5)
    80003ba8:	00000097          	auipc	ra,0x0
    80003bac:	400080e7          	jalr	1024(ra) # 80003fa8 <__memset>
    80003bb0:	01813083          	ld	ra,24(sp)
    80003bb4:	01013403          	ld	s0,16(sp)
    80003bb8:	00048513          	mv	a0,s1
    80003bbc:	00813483          	ld	s1,8(sp)
    80003bc0:	02010113          	addi	sp,sp,32
    80003bc4:	00008067          	ret

0000000080003bc8 <initlock>:
    80003bc8:	ff010113          	addi	sp,sp,-16
    80003bcc:	00813423          	sd	s0,8(sp)
    80003bd0:	01010413          	addi	s0,sp,16
    80003bd4:	00813403          	ld	s0,8(sp)
    80003bd8:	00b53423          	sd	a1,8(a0)
    80003bdc:	00052023          	sw	zero,0(a0)
    80003be0:	00053823          	sd	zero,16(a0)
    80003be4:	01010113          	addi	sp,sp,16
    80003be8:	00008067          	ret

0000000080003bec <acquire>:
    80003bec:	fe010113          	addi	sp,sp,-32
    80003bf0:	00813823          	sd	s0,16(sp)
    80003bf4:	00913423          	sd	s1,8(sp)
    80003bf8:	00113c23          	sd	ra,24(sp)
    80003bfc:	01213023          	sd	s2,0(sp)
    80003c00:	02010413          	addi	s0,sp,32
    80003c04:	00050493          	mv	s1,a0
    80003c08:	10002973          	csrr	s2,sstatus
    80003c0c:	100027f3          	csrr	a5,sstatus
    80003c10:	ffd7f793          	andi	a5,a5,-3
    80003c14:	10079073          	csrw	sstatus,a5
    80003c18:	fffff097          	auipc	ra,0xfffff
    80003c1c:	8e4080e7          	jalr	-1820(ra) # 800024fc <mycpu>
    80003c20:	07852783          	lw	a5,120(a0)
    80003c24:	06078e63          	beqz	a5,80003ca0 <acquire+0xb4>
    80003c28:	fffff097          	auipc	ra,0xfffff
    80003c2c:	8d4080e7          	jalr	-1836(ra) # 800024fc <mycpu>
    80003c30:	07852783          	lw	a5,120(a0)
    80003c34:	0004a703          	lw	a4,0(s1)
    80003c38:	0017879b          	addiw	a5,a5,1
    80003c3c:	06f52c23          	sw	a5,120(a0)
    80003c40:	04071063          	bnez	a4,80003c80 <acquire+0x94>
    80003c44:	00100713          	li	a4,1
    80003c48:	00070793          	mv	a5,a4
    80003c4c:	0cf4a7af          	amoswap.w.aq	a5,a5,(s1)
    80003c50:	0007879b          	sext.w	a5,a5
    80003c54:	fe079ae3          	bnez	a5,80003c48 <acquire+0x5c>
    80003c58:	0ff0000f          	fence
    80003c5c:	fffff097          	auipc	ra,0xfffff
    80003c60:	8a0080e7          	jalr	-1888(ra) # 800024fc <mycpu>
    80003c64:	01813083          	ld	ra,24(sp)
    80003c68:	01013403          	ld	s0,16(sp)
    80003c6c:	00a4b823          	sd	a0,16(s1)
    80003c70:	00013903          	ld	s2,0(sp)
    80003c74:	00813483          	ld	s1,8(sp)
    80003c78:	02010113          	addi	sp,sp,32
    80003c7c:	00008067          	ret
    80003c80:	0104b903          	ld	s2,16(s1)
    80003c84:	fffff097          	auipc	ra,0xfffff
    80003c88:	878080e7          	jalr	-1928(ra) # 800024fc <mycpu>
    80003c8c:	faa91ce3          	bne	s2,a0,80003c44 <acquire+0x58>
    80003c90:	00001517          	auipc	a0,0x1
    80003c94:	5a050513          	addi	a0,a0,1440 # 80005230 <digits+0x20>
    80003c98:	fffff097          	auipc	ra,0xfffff
    80003c9c:	224080e7          	jalr	548(ra) # 80002ebc <panic>
    80003ca0:	00195913          	srli	s2,s2,0x1
    80003ca4:	fffff097          	auipc	ra,0xfffff
    80003ca8:	858080e7          	jalr	-1960(ra) # 800024fc <mycpu>
    80003cac:	00197913          	andi	s2,s2,1
    80003cb0:	07252e23          	sw	s2,124(a0)
    80003cb4:	f75ff06f          	j	80003c28 <acquire+0x3c>

0000000080003cb8 <release>:
    80003cb8:	fe010113          	addi	sp,sp,-32
    80003cbc:	00813823          	sd	s0,16(sp)
    80003cc0:	00113c23          	sd	ra,24(sp)
    80003cc4:	00913423          	sd	s1,8(sp)
    80003cc8:	01213023          	sd	s2,0(sp)
    80003ccc:	02010413          	addi	s0,sp,32
    80003cd0:	00052783          	lw	a5,0(a0)
    80003cd4:	00079a63          	bnez	a5,80003ce8 <release+0x30>
    80003cd8:	00001517          	auipc	a0,0x1
    80003cdc:	56050513          	addi	a0,a0,1376 # 80005238 <digits+0x28>
    80003ce0:	fffff097          	auipc	ra,0xfffff
    80003ce4:	1dc080e7          	jalr	476(ra) # 80002ebc <panic>
    80003ce8:	01053903          	ld	s2,16(a0)
    80003cec:	00050493          	mv	s1,a0
    80003cf0:	fffff097          	auipc	ra,0xfffff
    80003cf4:	80c080e7          	jalr	-2036(ra) # 800024fc <mycpu>
    80003cf8:	fea910e3          	bne	s2,a0,80003cd8 <release+0x20>
    80003cfc:	0004b823          	sd	zero,16(s1)
    80003d00:	0ff0000f          	fence
    80003d04:	0f50000f          	fence	iorw,ow
    80003d08:	0804a02f          	amoswap.w	zero,zero,(s1)
    80003d0c:	ffffe097          	auipc	ra,0xffffe
    80003d10:	7f0080e7          	jalr	2032(ra) # 800024fc <mycpu>
    80003d14:	100027f3          	csrr	a5,sstatus
    80003d18:	0027f793          	andi	a5,a5,2
    80003d1c:	04079a63          	bnez	a5,80003d70 <release+0xb8>
    80003d20:	07852783          	lw	a5,120(a0)
    80003d24:	02f05e63          	blez	a5,80003d60 <release+0xa8>
    80003d28:	fff7871b          	addiw	a4,a5,-1
    80003d2c:	06e52c23          	sw	a4,120(a0)
    80003d30:	00071c63          	bnez	a4,80003d48 <release+0x90>
    80003d34:	07c52783          	lw	a5,124(a0)
    80003d38:	00078863          	beqz	a5,80003d48 <release+0x90>
    80003d3c:	100027f3          	csrr	a5,sstatus
    80003d40:	0027e793          	ori	a5,a5,2
    80003d44:	10079073          	csrw	sstatus,a5
    80003d48:	01813083          	ld	ra,24(sp)
    80003d4c:	01013403          	ld	s0,16(sp)
    80003d50:	00813483          	ld	s1,8(sp)
    80003d54:	00013903          	ld	s2,0(sp)
    80003d58:	02010113          	addi	sp,sp,32
    80003d5c:	00008067          	ret
    80003d60:	00001517          	auipc	a0,0x1
    80003d64:	4f850513          	addi	a0,a0,1272 # 80005258 <digits+0x48>
    80003d68:	fffff097          	auipc	ra,0xfffff
    80003d6c:	154080e7          	jalr	340(ra) # 80002ebc <panic>
    80003d70:	00001517          	auipc	a0,0x1
    80003d74:	4d050513          	addi	a0,a0,1232 # 80005240 <digits+0x30>
    80003d78:	fffff097          	auipc	ra,0xfffff
    80003d7c:	144080e7          	jalr	324(ra) # 80002ebc <panic>

0000000080003d80 <holding>:
    80003d80:	00052783          	lw	a5,0(a0)
    80003d84:	00079663          	bnez	a5,80003d90 <holding+0x10>
    80003d88:	00000513          	li	a0,0
    80003d8c:	00008067          	ret
    80003d90:	fe010113          	addi	sp,sp,-32
    80003d94:	00813823          	sd	s0,16(sp)
    80003d98:	00913423          	sd	s1,8(sp)
    80003d9c:	00113c23          	sd	ra,24(sp)
    80003da0:	02010413          	addi	s0,sp,32
    80003da4:	01053483          	ld	s1,16(a0)
    80003da8:	ffffe097          	auipc	ra,0xffffe
    80003dac:	754080e7          	jalr	1876(ra) # 800024fc <mycpu>
    80003db0:	01813083          	ld	ra,24(sp)
    80003db4:	01013403          	ld	s0,16(sp)
    80003db8:	40a48533          	sub	a0,s1,a0
    80003dbc:	00153513          	seqz	a0,a0
    80003dc0:	00813483          	ld	s1,8(sp)
    80003dc4:	02010113          	addi	sp,sp,32
    80003dc8:	00008067          	ret

0000000080003dcc <push_off>:
    80003dcc:	fe010113          	addi	sp,sp,-32
    80003dd0:	00813823          	sd	s0,16(sp)
    80003dd4:	00113c23          	sd	ra,24(sp)
    80003dd8:	00913423          	sd	s1,8(sp)
    80003ddc:	02010413          	addi	s0,sp,32
    80003de0:	100024f3          	csrr	s1,sstatus
    80003de4:	100027f3          	csrr	a5,sstatus
    80003de8:	ffd7f793          	andi	a5,a5,-3
    80003dec:	10079073          	csrw	sstatus,a5
    80003df0:	ffffe097          	auipc	ra,0xffffe
    80003df4:	70c080e7          	jalr	1804(ra) # 800024fc <mycpu>
    80003df8:	07852783          	lw	a5,120(a0)
    80003dfc:	02078663          	beqz	a5,80003e28 <push_off+0x5c>
    80003e00:	ffffe097          	auipc	ra,0xffffe
    80003e04:	6fc080e7          	jalr	1788(ra) # 800024fc <mycpu>
    80003e08:	07852783          	lw	a5,120(a0)
    80003e0c:	01813083          	ld	ra,24(sp)
    80003e10:	01013403          	ld	s0,16(sp)
    80003e14:	0017879b          	addiw	a5,a5,1
    80003e18:	06f52c23          	sw	a5,120(a0)
    80003e1c:	00813483          	ld	s1,8(sp)
    80003e20:	02010113          	addi	sp,sp,32
    80003e24:	00008067          	ret
    80003e28:	0014d493          	srli	s1,s1,0x1
    80003e2c:	ffffe097          	auipc	ra,0xffffe
    80003e30:	6d0080e7          	jalr	1744(ra) # 800024fc <mycpu>
    80003e34:	0014f493          	andi	s1,s1,1
    80003e38:	06952e23          	sw	s1,124(a0)
    80003e3c:	fc5ff06f          	j	80003e00 <push_off+0x34>

0000000080003e40 <pop_off>:
    80003e40:	ff010113          	addi	sp,sp,-16
    80003e44:	00813023          	sd	s0,0(sp)
    80003e48:	00113423          	sd	ra,8(sp)
    80003e4c:	01010413          	addi	s0,sp,16
    80003e50:	ffffe097          	auipc	ra,0xffffe
    80003e54:	6ac080e7          	jalr	1708(ra) # 800024fc <mycpu>
    80003e58:	100027f3          	csrr	a5,sstatus
    80003e5c:	0027f793          	andi	a5,a5,2
    80003e60:	04079663          	bnez	a5,80003eac <pop_off+0x6c>
    80003e64:	07852783          	lw	a5,120(a0)
    80003e68:	02f05a63          	blez	a5,80003e9c <pop_off+0x5c>
    80003e6c:	fff7871b          	addiw	a4,a5,-1
    80003e70:	06e52c23          	sw	a4,120(a0)
    80003e74:	00071c63          	bnez	a4,80003e8c <pop_off+0x4c>
    80003e78:	07c52783          	lw	a5,124(a0)
    80003e7c:	00078863          	beqz	a5,80003e8c <pop_off+0x4c>
    80003e80:	100027f3          	csrr	a5,sstatus
    80003e84:	0027e793          	ori	a5,a5,2
    80003e88:	10079073          	csrw	sstatus,a5
    80003e8c:	00813083          	ld	ra,8(sp)
    80003e90:	00013403          	ld	s0,0(sp)
    80003e94:	01010113          	addi	sp,sp,16
    80003e98:	00008067          	ret
    80003e9c:	00001517          	auipc	a0,0x1
    80003ea0:	3bc50513          	addi	a0,a0,956 # 80005258 <digits+0x48>
    80003ea4:	fffff097          	auipc	ra,0xfffff
    80003ea8:	018080e7          	jalr	24(ra) # 80002ebc <panic>
    80003eac:	00001517          	auipc	a0,0x1
    80003eb0:	39450513          	addi	a0,a0,916 # 80005240 <digits+0x30>
    80003eb4:	fffff097          	auipc	ra,0xfffff
    80003eb8:	008080e7          	jalr	8(ra) # 80002ebc <panic>

0000000080003ebc <push_on>:
    80003ebc:	fe010113          	addi	sp,sp,-32
    80003ec0:	00813823          	sd	s0,16(sp)
    80003ec4:	00113c23          	sd	ra,24(sp)
    80003ec8:	00913423          	sd	s1,8(sp)
    80003ecc:	02010413          	addi	s0,sp,32
    80003ed0:	100024f3          	csrr	s1,sstatus
    80003ed4:	100027f3          	csrr	a5,sstatus
    80003ed8:	0027e793          	ori	a5,a5,2
    80003edc:	10079073          	csrw	sstatus,a5
    80003ee0:	ffffe097          	auipc	ra,0xffffe
    80003ee4:	61c080e7          	jalr	1564(ra) # 800024fc <mycpu>
    80003ee8:	07852783          	lw	a5,120(a0)
    80003eec:	02078663          	beqz	a5,80003f18 <push_on+0x5c>
    80003ef0:	ffffe097          	auipc	ra,0xffffe
    80003ef4:	60c080e7          	jalr	1548(ra) # 800024fc <mycpu>
    80003ef8:	07852783          	lw	a5,120(a0)
    80003efc:	01813083          	ld	ra,24(sp)
    80003f00:	01013403          	ld	s0,16(sp)
    80003f04:	0017879b          	addiw	a5,a5,1
    80003f08:	06f52c23          	sw	a5,120(a0)
    80003f0c:	00813483          	ld	s1,8(sp)
    80003f10:	02010113          	addi	sp,sp,32
    80003f14:	00008067          	ret
    80003f18:	0014d493          	srli	s1,s1,0x1
    80003f1c:	ffffe097          	auipc	ra,0xffffe
    80003f20:	5e0080e7          	jalr	1504(ra) # 800024fc <mycpu>
    80003f24:	0014f493          	andi	s1,s1,1
    80003f28:	06952e23          	sw	s1,124(a0)
    80003f2c:	fc5ff06f          	j	80003ef0 <push_on+0x34>

0000000080003f30 <pop_on>:
    80003f30:	ff010113          	addi	sp,sp,-16
    80003f34:	00813023          	sd	s0,0(sp)
    80003f38:	00113423          	sd	ra,8(sp)
    80003f3c:	01010413          	addi	s0,sp,16
    80003f40:	ffffe097          	auipc	ra,0xffffe
    80003f44:	5bc080e7          	jalr	1468(ra) # 800024fc <mycpu>
    80003f48:	100027f3          	csrr	a5,sstatus
    80003f4c:	0027f793          	andi	a5,a5,2
    80003f50:	04078463          	beqz	a5,80003f98 <pop_on+0x68>
    80003f54:	07852783          	lw	a5,120(a0)
    80003f58:	02f05863          	blez	a5,80003f88 <pop_on+0x58>
    80003f5c:	fff7879b          	addiw	a5,a5,-1
    80003f60:	06f52c23          	sw	a5,120(a0)
    80003f64:	07853783          	ld	a5,120(a0)
    80003f68:	00079863          	bnez	a5,80003f78 <pop_on+0x48>
    80003f6c:	100027f3          	csrr	a5,sstatus
    80003f70:	ffd7f793          	andi	a5,a5,-3
    80003f74:	10079073          	csrw	sstatus,a5
    80003f78:	00813083          	ld	ra,8(sp)
    80003f7c:	00013403          	ld	s0,0(sp)
    80003f80:	01010113          	addi	sp,sp,16
    80003f84:	00008067          	ret
    80003f88:	00001517          	auipc	a0,0x1
    80003f8c:	2f850513          	addi	a0,a0,760 # 80005280 <digits+0x70>
    80003f90:	fffff097          	auipc	ra,0xfffff
    80003f94:	f2c080e7          	jalr	-212(ra) # 80002ebc <panic>
    80003f98:	00001517          	auipc	a0,0x1
    80003f9c:	2c850513          	addi	a0,a0,712 # 80005260 <digits+0x50>
    80003fa0:	fffff097          	auipc	ra,0xfffff
    80003fa4:	f1c080e7          	jalr	-228(ra) # 80002ebc <panic>

0000000080003fa8 <__memset>:
    80003fa8:	ff010113          	addi	sp,sp,-16
    80003fac:	00813423          	sd	s0,8(sp)
    80003fb0:	01010413          	addi	s0,sp,16
    80003fb4:	1a060e63          	beqz	a2,80004170 <__memset+0x1c8>
    80003fb8:	40a007b3          	neg	a5,a0
    80003fbc:	0077f793          	andi	a5,a5,7
    80003fc0:	00778693          	addi	a3,a5,7
    80003fc4:	00b00813          	li	a6,11
    80003fc8:	0ff5f593          	andi	a1,a1,255
    80003fcc:	fff6071b          	addiw	a4,a2,-1
    80003fd0:	1b06e663          	bltu	a3,a6,8000417c <__memset+0x1d4>
    80003fd4:	1cd76463          	bltu	a4,a3,8000419c <__memset+0x1f4>
    80003fd8:	1a078e63          	beqz	a5,80004194 <__memset+0x1ec>
    80003fdc:	00b50023          	sb	a1,0(a0)
    80003fe0:	00100713          	li	a4,1
    80003fe4:	1ae78463          	beq	a5,a4,8000418c <__memset+0x1e4>
    80003fe8:	00b500a3          	sb	a1,1(a0)
    80003fec:	00200713          	li	a4,2
    80003ff0:	1ae78a63          	beq	a5,a4,800041a4 <__memset+0x1fc>
    80003ff4:	00b50123          	sb	a1,2(a0)
    80003ff8:	00300713          	li	a4,3
    80003ffc:	18e78463          	beq	a5,a4,80004184 <__memset+0x1dc>
    80004000:	00b501a3          	sb	a1,3(a0)
    80004004:	00400713          	li	a4,4
    80004008:	1ae78263          	beq	a5,a4,800041ac <__memset+0x204>
    8000400c:	00b50223          	sb	a1,4(a0)
    80004010:	00500713          	li	a4,5
    80004014:	1ae78063          	beq	a5,a4,800041b4 <__memset+0x20c>
    80004018:	00b502a3          	sb	a1,5(a0)
    8000401c:	00700713          	li	a4,7
    80004020:	18e79e63          	bne	a5,a4,800041bc <__memset+0x214>
    80004024:	00b50323          	sb	a1,6(a0)
    80004028:	00700e93          	li	t4,7
    8000402c:	00859713          	slli	a4,a1,0x8
    80004030:	00e5e733          	or	a4,a1,a4
    80004034:	01059e13          	slli	t3,a1,0x10
    80004038:	01c76e33          	or	t3,a4,t3
    8000403c:	01859313          	slli	t1,a1,0x18
    80004040:	006e6333          	or	t1,t3,t1
    80004044:	02059893          	slli	a7,a1,0x20
    80004048:	40f60e3b          	subw	t3,a2,a5
    8000404c:	011368b3          	or	a7,t1,a7
    80004050:	02859813          	slli	a6,a1,0x28
    80004054:	0108e833          	or	a6,a7,a6
    80004058:	03059693          	slli	a3,a1,0x30
    8000405c:	003e589b          	srliw	a7,t3,0x3
    80004060:	00d866b3          	or	a3,a6,a3
    80004064:	03859713          	slli	a4,a1,0x38
    80004068:	00389813          	slli	a6,a7,0x3
    8000406c:	00f507b3          	add	a5,a0,a5
    80004070:	00e6e733          	or	a4,a3,a4
    80004074:	000e089b          	sext.w	a7,t3
    80004078:	00f806b3          	add	a3,a6,a5
    8000407c:	00e7b023          	sd	a4,0(a5)
    80004080:	00878793          	addi	a5,a5,8
    80004084:	fed79ce3          	bne	a5,a3,8000407c <__memset+0xd4>
    80004088:	ff8e7793          	andi	a5,t3,-8
    8000408c:	0007871b          	sext.w	a4,a5
    80004090:	01d787bb          	addw	a5,a5,t4
    80004094:	0ce88e63          	beq	a7,a4,80004170 <__memset+0x1c8>
    80004098:	00f50733          	add	a4,a0,a5
    8000409c:	00b70023          	sb	a1,0(a4)
    800040a0:	0017871b          	addiw	a4,a5,1
    800040a4:	0cc77663          	bgeu	a4,a2,80004170 <__memset+0x1c8>
    800040a8:	00e50733          	add	a4,a0,a4
    800040ac:	00b70023          	sb	a1,0(a4)
    800040b0:	0027871b          	addiw	a4,a5,2
    800040b4:	0ac77e63          	bgeu	a4,a2,80004170 <__memset+0x1c8>
    800040b8:	00e50733          	add	a4,a0,a4
    800040bc:	00b70023          	sb	a1,0(a4)
    800040c0:	0037871b          	addiw	a4,a5,3
    800040c4:	0ac77663          	bgeu	a4,a2,80004170 <__memset+0x1c8>
    800040c8:	00e50733          	add	a4,a0,a4
    800040cc:	00b70023          	sb	a1,0(a4)
    800040d0:	0047871b          	addiw	a4,a5,4
    800040d4:	08c77e63          	bgeu	a4,a2,80004170 <__memset+0x1c8>
    800040d8:	00e50733          	add	a4,a0,a4
    800040dc:	00b70023          	sb	a1,0(a4)
    800040e0:	0057871b          	addiw	a4,a5,5
    800040e4:	08c77663          	bgeu	a4,a2,80004170 <__memset+0x1c8>
    800040e8:	00e50733          	add	a4,a0,a4
    800040ec:	00b70023          	sb	a1,0(a4)
    800040f0:	0067871b          	addiw	a4,a5,6
    800040f4:	06c77e63          	bgeu	a4,a2,80004170 <__memset+0x1c8>
    800040f8:	00e50733          	add	a4,a0,a4
    800040fc:	00b70023          	sb	a1,0(a4)
    80004100:	0077871b          	addiw	a4,a5,7
    80004104:	06c77663          	bgeu	a4,a2,80004170 <__memset+0x1c8>
    80004108:	00e50733          	add	a4,a0,a4
    8000410c:	00b70023          	sb	a1,0(a4)
    80004110:	0087871b          	addiw	a4,a5,8
    80004114:	04c77e63          	bgeu	a4,a2,80004170 <__memset+0x1c8>
    80004118:	00e50733          	add	a4,a0,a4
    8000411c:	00b70023          	sb	a1,0(a4)
    80004120:	0097871b          	addiw	a4,a5,9
    80004124:	04c77663          	bgeu	a4,a2,80004170 <__memset+0x1c8>
    80004128:	00e50733          	add	a4,a0,a4
    8000412c:	00b70023          	sb	a1,0(a4)
    80004130:	00a7871b          	addiw	a4,a5,10
    80004134:	02c77e63          	bgeu	a4,a2,80004170 <__memset+0x1c8>
    80004138:	00e50733          	add	a4,a0,a4
    8000413c:	00b70023          	sb	a1,0(a4)
    80004140:	00b7871b          	addiw	a4,a5,11
    80004144:	02c77663          	bgeu	a4,a2,80004170 <__memset+0x1c8>
    80004148:	00e50733          	add	a4,a0,a4
    8000414c:	00b70023          	sb	a1,0(a4)
    80004150:	00c7871b          	addiw	a4,a5,12
    80004154:	00c77e63          	bgeu	a4,a2,80004170 <__memset+0x1c8>
    80004158:	00e50733          	add	a4,a0,a4
    8000415c:	00b70023          	sb	a1,0(a4)
    80004160:	00d7879b          	addiw	a5,a5,13
    80004164:	00c7f663          	bgeu	a5,a2,80004170 <__memset+0x1c8>
    80004168:	00f507b3          	add	a5,a0,a5
    8000416c:	00b78023          	sb	a1,0(a5)
    80004170:	00813403          	ld	s0,8(sp)
    80004174:	01010113          	addi	sp,sp,16
    80004178:	00008067          	ret
    8000417c:	00b00693          	li	a3,11
    80004180:	e55ff06f          	j	80003fd4 <__memset+0x2c>
    80004184:	00300e93          	li	t4,3
    80004188:	ea5ff06f          	j	8000402c <__memset+0x84>
    8000418c:	00100e93          	li	t4,1
    80004190:	e9dff06f          	j	8000402c <__memset+0x84>
    80004194:	00000e93          	li	t4,0
    80004198:	e95ff06f          	j	8000402c <__memset+0x84>
    8000419c:	00000793          	li	a5,0
    800041a0:	ef9ff06f          	j	80004098 <__memset+0xf0>
    800041a4:	00200e93          	li	t4,2
    800041a8:	e85ff06f          	j	8000402c <__memset+0x84>
    800041ac:	00400e93          	li	t4,4
    800041b0:	e7dff06f          	j	8000402c <__memset+0x84>
    800041b4:	00500e93          	li	t4,5
    800041b8:	e75ff06f          	j	8000402c <__memset+0x84>
    800041bc:	00600e93          	li	t4,6
    800041c0:	e6dff06f          	j	8000402c <__memset+0x84>

00000000800041c4 <__memmove>:
    800041c4:	ff010113          	addi	sp,sp,-16
    800041c8:	00813423          	sd	s0,8(sp)
    800041cc:	01010413          	addi	s0,sp,16
    800041d0:	0e060863          	beqz	a2,800042c0 <__memmove+0xfc>
    800041d4:	fff6069b          	addiw	a3,a2,-1
    800041d8:	0006881b          	sext.w	a6,a3
    800041dc:	0ea5e863          	bltu	a1,a0,800042cc <__memmove+0x108>
    800041e0:	00758713          	addi	a4,a1,7
    800041e4:	00a5e7b3          	or	a5,a1,a0
    800041e8:	40a70733          	sub	a4,a4,a0
    800041ec:	0077f793          	andi	a5,a5,7
    800041f0:	00f73713          	sltiu	a4,a4,15
    800041f4:	00174713          	xori	a4,a4,1
    800041f8:	0017b793          	seqz	a5,a5
    800041fc:	00e7f7b3          	and	a5,a5,a4
    80004200:	10078863          	beqz	a5,80004310 <__memmove+0x14c>
    80004204:	00900793          	li	a5,9
    80004208:	1107f463          	bgeu	a5,a6,80004310 <__memmove+0x14c>
    8000420c:	0036581b          	srliw	a6,a2,0x3
    80004210:	fff8081b          	addiw	a6,a6,-1
    80004214:	02081813          	slli	a6,a6,0x20
    80004218:	01d85893          	srli	a7,a6,0x1d
    8000421c:	00858813          	addi	a6,a1,8
    80004220:	00058793          	mv	a5,a1
    80004224:	00050713          	mv	a4,a0
    80004228:	01088833          	add	a6,a7,a6
    8000422c:	0007b883          	ld	a7,0(a5)
    80004230:	00878793          	addi	a5,a5,8
    80004234:	00870713          	addi	a4,a4,8
    80004238:	ff173c23          	sd	a7,-8(a4)
    8000423c:	ff0798e3          	bne	a5,a6,8000422c <__memmove+0x68>
    80004240:	ff867713          	andi	a4,a2,-8
    80004244:	02071793          	slli	a5,a4,0x20
    80004248:	0207d793          	srli	a5,a5,0x20
    8000424c:	00f585b3          	add	a1,a1,a5
    80004250:	40e686bb          	subw	a3,a3,a4
    80004254:	00f507b3          	add	a5,a0,a5
    80004258:	06e60463          	beq	a2,a4,800042c0 <__memmove+0xfc>
    8000425c:	0005c703          	lbu	a4,0(a1)
    80004260:	00e78023          	sb	a4,0(a5)
    80004264:	04068e63          	beqz	a3,800042c0 <__memmove+0xfc>
    80004268:	0015c603          	lbu	a2,1(a1)
    8000426c:	00100713          	li	a4,1
    80004270:	00c780a3          	sb	a2,1(a5)
    80004274:	04e68663          	beq	a3,a4,800042c0 <__memmove+0xfc>
    80004278:	0025c603          	lbu	a2,2(a1)
    8000427c:	00200713          	li	a4,2
    80004280:	00c78123          	sb	a2,2(a5)
    80004284:	02e68e63          	beq	a3,a4,800042c0 <__memmove+0xfc>
    80004288:	0035c603          	lbu	a2,3(a1)
    8000428c:	00300713          	li	a4,3
    80004290:	00c781a3          	sb	a2,3(a5)
    80004294:	02e68663          	beq	a3,a4,800042c0 <__memmove+0xfc>
    80004298:	0045c603          	lbu	a2,4(a1)
    8000429c:	00400713          	li	a4,4
    800042a0:	00c78223          	sb	a2,4(a5)
    800042a4:	00e68e63          	beq	a3,a4,800042c0 <__memmove+0xfc>
    800042a8:	0055c603          	lbu	a2,5(a1)
    800042ac:	00500713          	li	a4,5
    800042b0:	00c782a3          	sb	a2,5(a5)
    800042b4:	00e68663          	beq	a3,a4,800042c0 <__memmove+0xfc>
    800042b8:	0065c703          	lbu	a4,6(a1)
    800042bc:	00e78323          	sb	a4,6(a5)
    800042c0:	00813403          	ld	s0,8(sp)
    800042c4:	01010113          	addi	sp,sp,16
    800042c8:	00008067          	ret
    800042cc:	02061713          	slli	a4,a2,0x20
    800042d0:	02075713          	srli	a4,a4,0x20
    800042d4:	00e587b3          	add	a5,a1,a4
    800042d8:	f0f574e3          	bgeu	a0,a5,800041e0 <__memmove+0x1c>
    800042dc:	02069613          	slli	a2,a3,0x20
    800042e0:	02065613          	srli	a2,a2,0x20
    800042e4:	fff64613          	not	a2,a2
    800042e8:	00e50733          	add	a4,a0,a4
    800042ec:	00c78633          	add	a2,a5,a2
    800042f0:	fff7c683          	lbu	a3,-1(a5)
    800042f4:	fff78793          	addi	a5,a5,-1
    800042f8:	fff70713          	addi	a4,a4,-1
    800042fc:	00d70023          	sb	a3,0(a4)
    80004300:	fec798e3          	bne	a5,a2,800042f0 <__memmove+0x12c>
    80004304:	00813403          	ld	s0,8(sp)
    80004308:	01010113          	addi	sp,sp,16
    8000430c:	00008067          	ret
    80004310:	02069713          	slli	a4,a3,0x20
    80004314:	02075713          	srli	a4,a4,0x20
    80004318:	00170713          	addi	a4,a4,1
    8000431c:	00e50733          	add	a4,a0,a4
    80004320:	00050793          	mv	a5,a0
    80004324:	0005c683          	lbu	a3,0(a1)
    80004328:	00178793          	addi	a5,a5,1
    8000432c:	00158593          	addi	a1,a1,1
    80004330:	fed78fa3          	sb	a3,-1(a5)
    80004334:	fee798e3          	bne	a5,a4,80004324 <__memmove+0x160>
    80004338:	f89ff06f          	j	800042c0 <__memmove+0xfc>

000000008000433c <__putc>:
    8000433c:	fe010113          	addi	sp,sp,-32
    80004340:	00813823          	sd	s0,16(sp)
    80004344:	00113c23          	sd	ra,24(sp)
    80004348:	02010413          	addi	s0,sp,32
    8000434c:	00050793          	mv	a5,a0
    80004350:	fef40593          	addi	a1,s0,-17
    80004354:	00100613          	li	a2,1
    80004358:	00000513          	li	a0,0
    8000435c:	fef407a3          	sb	a5,-17(s0)
    80004360:	fffff097          	auipc	ra,0xfffff
    80004364:	b3c080e7          	jalr	-1220(ra) # 80002e9c <console_write>
    80004368:	01813083          	ld	ra,24(sp)
    8000436c:	01013403          	ld	s0,16(sp)
    80004370:	02010113          	addi	sp,sp,32
    80004374:	00008067          	ret

0000000080004378 <__getc>:
    80004378:	fe010113          	addi	sp,sp,-32
    8000437c:	00813823          	sd	s0,16(sp)
    80004380:	00113c23          	sd	ra,24(sp)
    80004384:	02010413          	addi	s0,sp,32
    80004388:	fe840593          	addi	a1,s0,-24
    8000438c:	00100613          	li	a2,1
    80004390:	00000513          	li	a0,0
    80004394:	fffff097          	auipc	ra,0xfffff
    80004398:	ae8080e7          	jalr	-1304(ra) # 80002e7c <console_read>
    8000439c:	fe844503          	lbu	a0,-24(s0)
    800043a0:	01813083          	ld	ra,24(sp)
    800043a4:	01013403          	ld	s0,16(sp)
    800043a8:	02010113          	addi	sp,sp,32
    800043ac:	00008067          	ret

00000000800043b0 <console_handler>:
    800043b0:	fe010113          	addi	sp,sp,-32
    800043b4:	00813823          	sd	s0,16(sp)
    800043b8:	00113c23          	sd	ra,24(sp)
    800043bc:	00913423          	sd	s1,8(sp)
    800043c0:	02010413          	addi	s0,sp,32
    800043c4:	14202773          	csrr	a4,scause
    800043c8:	100027f3          	csrr	a5,sstatus
    800043cc:	0027f793          	andi	a5,a5,2
    800043d0:	06079e63          	bnez	a5,8000444c <console_handler+0x9c>
    800043d4:	00074c63          	bltz	a4,800043ec <console_handler+0x3c>
    800043d8:	01813083          	ld	ra,24(sp)
    800043dc:	01013403          	ld	s0,16(sp)
    800043e0:	00813483          	ld	s1,8(sp)
    800043e4:	02010113          	addi	sp,sp,32
    800043e8:	00008067          	ret
    800043ec:	0ff77713          	andi	a4,a4,255
    800043f0:	00900793          	li	a5,9
    800043f4:	fef712e3          	bne	a4,a5,800043d8 <console_handler+0x28>
    800043f8:	ffffe097          	auipc	ra,0xffffe
    800043fc:	6dc080e7          	jalr	1756(ra) # 80002ad4 <plic_claim>
    80004400:	00a00793          	li	a5,10
    80004404:	00050493          	mv	s1,a0
    80004408:	02f50c63          	beq	a0,a5,80004440 <console_handler+0x90>
    8000440c:	fc0506e3          	beqz	a0,800043d8 <console_handler+0x28>
    80004410:	00050593          	mv	a1,a0
    80004414:	00001517          	auipc	a0,0x1
    80004418:	d7450513          	addi	a0,a0,-652 # 80005188 <CONSOLE_STATUS+0x170>
    8000441c:	fffff097          	auipc	ra,0xfffff
    80004420:	afc080e7          	jalr	-1284(ra) # 80002f18 <__printf>
    80004424:	01013403          	ld	s0,16(sp)
    80004428:	01813083          	ld	ra,24(sp)
    8000442c:	00048513          	mv	a0,s1
    80004430:	00813483          	ld	s1,8(sp)
    80004434:	02010113          	addi	sp,sp,32
    80004438:	ffffe317          	auipc	t1,0xffffe
    8000443c:	6d430067          	jr	1748(t1) # 80002b0c <plic_complete>
    80004440:	fffff097          	auipc	ra,0xfffff
    80004444:	3e0080e7          	jalr	992(ra) # 80003820 <uartintr>
    80004448:	fddff06f          	j	80004424 <console_handler+0x74>
    8000444c:	00001517          	auipc	a0,0x1
    80004450:	e3c50513          	addi	a0,a0,-452 # 80005288 <digits+0x78>
    80004454:	fffff097          	auipc	ra,0xfffff
    80004458:	a68080e7          	jalr	-1432(ra) # 80002ebc <panic>
	...
