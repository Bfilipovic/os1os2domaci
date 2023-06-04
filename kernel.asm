
kernel:     file format elf64-littleriscv


Disassembly of section .text:

0000000080000000 <_entry>:
    80000000:	00004117          	auipc	sp,0x4
    80000004:	30013103          	ld	sp,768(sp) # 80004300 <_GLOBAL_OFFSET_TABLE_+0x10>
    80000008:	00001537          	lui	a0,0x1
    8000000c:	f14025f3          	csrr	a1,mhartid
    80000010:	00158593          	addi	a1,a1,1
    80000014:	02b50533          	mul	a0,a0,a1
    80000018:	00a10133          	add	sp,sp,a0
    8000001c:	3ed010ef          	jal	ra,80001c08 <start>

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
    80001084:	2ec000ef          	jal	ra,80001370 <handleSupervisorTrap>

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

0000000080001124 <kern_mem_alloc>:

mem_block_s * freeHead;


void* kern_mem_alloc(int sizeInBlocks)
{
    80001124:	ff010113          	addi	sp,sp,-16
    80001128:	00813423          	sd	s0,8(sp)
    8000112c:	01010413          	addi	s0,sp,16
    80001130:	00050693          	mv	a3,a0
    mem_block_s *curr = freeHead;
    80001134:	00003597          	auipc	a1,0x3
    80001138:	1ec5b583          	ld	a1,492(a1) # 80004320 <freeHead>
    8000113c:	00058513          	mv	a0,a1
    mem_block_s *prev = 0;
    80001140:	00000613          	li	a2,0

    while (curr){
    80001144:	0480006f          	j	8000118c <kern_mem_alloc+0x68>
        if(curr->sizeInBlocks==sizeInBlocks+1){
            if(curr==freeHead) freeHead=curr->next;
    80001148:	02b50063          	beq	a0,a1,80001168 <kern_mem_alloc+0x44>
            else prev->next = curr->next;
    8000114c:	00853783          	ld	a5,8(a0)
    80001150:	00f63423          	sd	a5,8(a2)
            curr->sizeInBlocks=sizeInBlocks+1;
    80001154:	00e52023          	sw	a4,0(a0)
            return (curr+MEM_BLOCK_SIZE);
    80001158:	40050513          	addi	a0,a0,1024
        prev=curr;
        curr=curr->next;
    }

    return 0;
}
    8000115c:	00813403          	ld	s0,8(sp)
    80001160:	01010113          	addi	sp,sp,16
    80001164:	00008067          	ret
            if(curr==freeHead) freeHead=curr->next;
    80001168:	00853783          	ld	a5,8(a0)
    8000116c:	00003697          	auipc	a3,0x3
    80001170:	1af6ba23          	sd	a5,436(a3) # 80004320 <freeHead>
    80001174:	fe1ff06f          	j	80001154 <kern_mem_alloc+0x30>
            if(curr==freeHead) freeHead=newFreeBlock;
    80001178:	00003797          	auipc	a5,0x3
    8000117c:	1ab7b423          	sd	a1,424(a5) # 80004320 <freeHead>
    80001180:	05c0006f          	j	800011dc <kern_mem_alloc+0xb8>
        prev=curr;
    80001184:	00050613          	mv	a2,a0
        curr=curr->next;
    80001188:	00853503          	ld	a0,8(a0)
    while (curr){
    8000118c:	fc0508e3          	beqz	a0,8000115c <kern_mem_alloc+0x38>
        if(curr->sizeInBlocks==sizeInBlocks+1){
    80001190:	00052783          	lw	a5,0(a0)
    80001194:	0016871b          	addiw	a4,a3,1
    80001198:	fae788e3          	beq	a5,a4,80001148 <kern_mem_alloc+0x24>
        else if(curr->sizeInBlocks>sizeInBlocks+1){
    8000119c:	fef754e3          	bge	a4,a5,80001184 <kern_mem_alloc+0x60>
            mem_block_s* newFreeBlock = curr+(sizeInBlocks+1)*MEM_BLOCK_SIZE;
    800011a0:	00a71593          	slli	a1,a4,0xa
    800011a4:	00b505b3          	add	a1,a0,a1
            newFreeBlock->sizeInBlocks = curr->sizeInBlocks-sizeInBlocks-1;
    800011a8:	40d787bb          	subw	a5,a5,a3
    800011ac:	fff7879b          	addiw	a5,a5,-1
    800011b0:	00f5a023          	sw	a5,0(a1)
            newFreeBlock->startingBlock=curr->startingBlock+sizeInBlocks+1;
    800011b4:	00452783          	lw	a5,4(a0)
    800011b8:	00d786bb          	addw	a3,a5,a3
    800011bc:	0016869b          	addiw	a3,a3,1
    800011c0:	00d5a223          	sw	a3,4(a1)
            newFreeBlock->next = curr->next;
    800011c4:	00853783          	ld	a5,8(a0)
    800011c8:	00f5b423          	sd	a5,8(a1)
            if(curr==freeHead) freeHead=newFreeBlock;
    800011cc:	00003797          	auipc	a5,0x3
    800011d0:	1547b783          	ld	a5,340(a5) # 80004320 <freeHead>
    800011d4:	faa782e3          	beq	a5,a0,80001178 <kern_mem_alloc+0x54>
            else prev->next=newFreeBlock;
    800011d8:	00b63423          	sd	a1,8(a2)
            curr->sizeInBlocks=sizeInBlocks+1;
    800011dc:	00e52023          	sw	a4,0(a0)
            return (curr+MEM_BLOCK_SIZE);
    800011e0:	40050513          	addi	a0,a0,1024
    800011e4:	f79ff06f          	j	8000115c <kern_mem_alloc+0x38>

00000000800011e8 <kern_mem_free>:

int kern_mem_free(void* addr)
{
    800011e8:	ff010113          	addi	sp,sp,-16
    800011ec:	00813423          	sd	s0,8(sp)
    800011f0:	01010413          	addi	s0,sp,16
    mem_block_s* freedBlock = (mem_block_s*) addr-MEM_BLOCK_SIZE;
    800011f4:	c0050713          	addi	a4,a0,-1024
    mem_block_s* curr=freeHead;
    800011f8:	00003797          	auipc	a5,0x3
    800011fc:	1287b783          	ld	a5,296(a5) # 80004320 <freeHead>
    mem_block_s * prev =0;
    80001200:	00000693          	li	a3,0

    while (curr<freedBlock && curr!=0){
    80001204:	00e7fa63          	bgeu	a5,a4,80001218 <kern_mem_free+0x30>
    80001208:	00078863          	beqz	a5,80001218 <kern_mem_free+0x30>
        prev=curr;
    8000120c:	00078693          	mv	a3,a5
        curr=curr->next;
    80001210:	0087b783          	ld	a5,8(a5)
    80001214:	ff1ff06f          	j	80001204 <kern_mem_free+0x1c>
    char* cfreedBlock = (char *)freedBlock;
    char* cprev = (char *)prev;
    char* ccurr = (char *)curr;
    */

    if(prev){
    80001218:	04068e63          	beqz	a3,80001274 <kern_mem_free+0x8c>
        if(prev->startingBlock+prev->sizeInBlocks==freedBlock->startingBlock){
    8000121c:	0046a603          	lw	a2,4(a3)
    80001220:	0006a583          	lw	a1,0(a3)
    80001224:	00b6063b          	addw	a2,a2,a1
    80001228:	c0452803          	lw	a6,-1020(a0)
    8000122c:	03060a63          	beq	a2,a6,80001260 <kern_mem_free+0x78>
            prev->sizeInBlocks+=freedBlock->sizeInBlocks;
            freedBlock=prev;
        } else {
            prev->next=freedBlock;
    80001230:	00e6b423          	sd	a4,8(a3)
        }
    }
    else freeHead=freedBlock;

    if(curr){
    80001234:	00078e63          	beqz	a5,80001250 <kern_mem_free+0x68>
        if(freedBlock->startingBlock+freedBlock->sizeInBlocks==curr->startingBlock){
    80001238:	00472683          	lw	a3,4(a4)
    8000123c:	00072603          	lw	a2,0(a4)
    80001240:	00c686bb          	addw	a3,a3,a2
    80001244:	0047a583          	lw	a1,4(a5)
    80001248:	02b68c63          	beq	a3,a1,80001280 <kern_mem_free+0x98>
            freedBlock->sizeInBlocks+=curr->sizeInBlocks;
            freedBlock->next=curr->next;
        } else{
          freedBlock->next=curr;
    8000124c:	00f73423          	sd	a5,8(a4)
        }
    }


    return 0;
}
    80001250:	00000513          	li	a0,0
    80001254:	00813403          	ld	s0,8(sp)
    80001258:	01010113          	addi	sp,sp,16
    8000125c:	00008067          	ret
            prev->sizeInBlocks+=freedBlock->sizeInBlocks;
    80001260:	c0052703          	lw	a4,-1024(a0)
    80001264:	00e585bb          	addw	a1,a1,a4
    80001268:	00b6a023          	sw	a1,0(a3)
            freedBlock=prev;
    8000126c:	00068713          	mv	a4,a3
    80001270:	fc5ff06f          	j	80001234 <kern_mem_free+0x4c>
    else freeHead=freedBlock;
    80001274:	00003697          	auipc	a3,0x3
    80001278:	0ae6b623          	sd	a4,172(a3) # 80004320 <freeHead>
    8000127c:	fb9ff06f          	j	80001234 <kern_mem_free+0x4c>
            freedBlock->sizeInBlocks+=curr->sizeInBlocks;
    80001280:	0007a683          	lw	a3,0(a5)
    80001284:	00d6063b          	addw	a2,a2,a3
    80001288:	00c72023          	sw	a2,0(a4)
            freedBlock->next=curr->next;
    8000128c:	0087b783          	ld	a5,8(a5)
    80001290:	00f73423          	sd	a5,8(a4)
    80001294:	fbdff06f          	j	80001250 <kern_mem_free+0x68>

0000000080001298 <kern_mem_init>:

void kern_mem_init(void* start, void* end)
{
    80001298:	ff010113          	addi	sp,sp,-16
    8000129c:	00813423          	sd	s0,8(sp)
    800012a0:	01010413          	addi	s0,sp,16
    unsigned long lstart = (unsigned long) start;
    unsigned long lend = (unsigned long) end;
    800012a4:	00058793          	mv	a5,a1

    if(lstart%MEM_BLOCK_SIZE>0) start =(void*) ((lstart/MEM_BLOCK_SIZE+1)*MEM_BLOCK_SIZE);
    800012a8:	03f57713          	andi	a4,a0,63
    800012ac:	00070863          	beqz	a4,800012bc <kern_mem_init+0x24>
    800012b0:	00655513          	srli	a0,a0,0x6
    800012b4:	00150513          	addi	a0,a0,1
    800012b8:	00651513          	slli	a0,a0,0x6
    if(lend%MEM_BLOCK_SIZE>0) end =(void*) ((lend/MEM_BLOCK_SIZE)*MEM_BLOCK_SIZE);
    800012bc:	03f7f713          	andi	a4,a5,63
    800012c0:	00070463          	beqz	a4,800012c8 <kern_mem_init+0x30>
    800012c4:	fc07f593          	andi	a1,a5,-64

    freeHead = (mem_block_s*)start;
    800012c8:	00003797          	auipc	a5,0x3
    800012cc:	05878793          	addi	a5,a5,88 # 80004320 <freeHead>
    800012d0:	00a7b023          	sd	a0,0(a5)
    freeHead->next=0;
    800012d4:	00053423          	sd	zero,8(a0)
    freeHead->startingBlock=0;
    800012d8:	00052223          	sw	zero,4(a0)
    freeHead->sizeInBlocks = (end-start)/MEM_BLOCK_SIZE;
    800012dc:	40a58533          	sub	a0,a1,a0
    800012e0:	00655513          	srli	a0,a0,0x6
    800012e4:	0007b783          	ld	a5,0(a5)
    800012e8:	00a7a023          	sw	a0,0(a5)
}
    800012ec:	00813403          	ld	s0,8(sp)
    800012f0:	01010113          	addi	sp,sp,16
    800012f4:	00008067          	ret

00000000800012f8 <kern_syscall>:

uint64 SYSTEM_TIME;


uint64 kern_syscall(enum SyscallNumber num, ...)
{
    800012f8:	fb010113          	addi	sp,sp,-80
    800012fc:	00813423          	sd	s0,8(sp)
    80001300:	01010413          	addi	s0,sp,16
    80001304:	00b43423          	sd	a1,8(s0)
    80001308:	00c43823          	sd	a2,16(s0)
    8000130c:	00d43c23          	sd	a3,24(s0)
    80001310:	02e43023          	sd	a4,32(s0)
    80001314:	02f43423          	sd	a5,40(s0)
    80001318:	03043823          	sd	a6,48(s0)
    8000131c:	03143c23          	sd	a7,56(s0)
    __asm__ volatile ("ecall");
    80001320:	00000073          	ecall
    return  running->syscall_retval;
}
    80001324:	00003797          	auipc	a5,0x3
    80001328:	0147b783          	ld	a5,20(a5) # 80004338 <running>
    8000132c:	0487b503          	ld	a0,72(a5)
    80001330:	00813403          	ld	s0,8(sp)
    80001334:	05010113          	addi	sp,sp,80
    80001338:	00008067          	ret

000000008000133c <kern_interrupt_init>:

void kern_interrupt_init()
{
    8000133c:	ff010113          	addi	sp,sp,-16
    80001340:	00813423          	sd	s0,8(sp)
    80001344:	01010413          	addi	s0,sp,16
    SYSTEM_TIME=0;
    80001348:	00003797          	auipc	a5,0x3
    8000134c:	fe07b423          	sd	zero,-24(a5) # 80004330 <SYSTEM_TIME>
    w_stvec((uint64) &supervisorTrap);
    80001350:	00000797          	auipc	a5,0x0
    80001354:	cb078793          	addi	a5,a5,-848 # 80001000 <supervisorTrap>
    return stvec;
}

inline void w_stvec(uint64 stvec)
{
    __asm__ volatile ("csrw stvec, %[stvec]" : : [stvec] "r"(stvec));
    80001358:	10579073          	csrw	stvec,a5
    __asm__ volatile ("csrw sip, %[sip]" : : [sip] "r"(sip));
}

inline void ms_sstatus(uint64 mask)
{
    __asm__ volatile ("csrs sstatus, %[mask]" : : [mask] "r"(mask));
    8000135c:	00200793          	li	a5,2
    80001360:	1007a073          	csrs	sstatus,a5
    ms_sstatus(SSTATUS_SIE);
}
    80001364:	00813403          	ld	s0,8(sp)
    80001368:	01010113          	addi	sp,sp,16
    8000136c:	00008067          	ret

0000000080001370 <handleSupervisorTrap>:


int time=0;

void handleSupervisorTrap()
{
    80001370:	fa010113          	addi	sp,sp,-96
    80001374:	04113c23          	sd	ra,88(sp)
    80001378:	04813823          	sd	s0,80(sp)
    8000137c:	06010413          	addi	s0,sp,96
    uint64  a0,a1,a2,a3,a4;
    __asm__ volatile ("mv %[a0], a0" : [a0] "=r"(a0));
    80001380:	00050793          	mv	a5,a0
    __asm__ volatile ("mv %[a1], a1" : [a1] "=r"(a1));
    80001384:	00058513          	mv	a0,a1
    __asm__ volatile ("mv %[a2], a2" : [a2] "=r"(a2));
    80001388:	00060593          	mv	a1,a2
    __asm__ volatile ("mv %[a3], a3" : [a3] "=r"(a3));
    8000138c:	00068613          	mv	a2,a3
    __asm__ volatile ("mv %[a4], a4" : [a4] "=r"(a4));
    80001390:	00070693          	mv	a3,a4
    __asm__ volatile ("csrr %[scause], scause" : [scause] "=r"(scause));
    80001394:	14202773          	csrr	a4,scause
    80001398:	fce43023          	sd	a4,-64(s0)
    return scause;
    8000139c:	fc043703          	ld	a4,-64(s0)
    uint64  scause = r_scause();
    if (scause == INTR_USER_ECALL || scause == INTR_KERNEL_ECALL)
    800013a0:	ff870893          	addi	a7,a4,-8
    800013a4:	00100813          	li	a6,1
    800013a8:	03187a63          	bgeu	a6,a7,800013dc <handleSupervisorTrap+0x6c>
                break;
            }
        }

    }
    else if (scause == INTR_TIMER)
    800013ac:	fff00793          	li	a5,-1
    800013b0:	03f79793          	slli	a5,a5,0x3f
    800013b4:	00178793          	addi	a5,a5,1
    800013b8:	10f70063          	beq	a4,a5,800014b8 <handleSupervisorTrap+0x148>
            w_sepc(v_sepc);
            running->endTime=SYSTEM_TIME+running->timeslice;
        }

    }
    else if (scause == INTR_CONSOLE)
    800013bc:	fff00793          	li	a5,-1
    800013c0:	03f79793          	slli	a5,a5,0x3f
    800013c4:	00978793          	addi	a5,a5,9
    800013c8:	1ef70063          	beq	a4,a5,800015a8 <handleSupervisorTrap+0x238>
    }
    else
    {
        // unexpected trap cause
    }
}
    800013cc:	05813083          	ld	ra,88(sp)
    800013d0:	05013403          	ld	s0,80(sp)
    800013d4:	06010113          	addi	sp,sp,96
    800013d8:	00008067          	ret
    __asm__ volatile ("csrr %[sepc], sepc" : [sepc] "=r"(sepc));
    800013dc:	14102773          	csrr	a4,sepc
    800013e0:	fce43423          	sd	a4,-56(s0)
    return sepc;
    800013e4:	fc843703          	ld	a4,-56(s0)
        uint64   sepc = r_sepc() + 4;
    800013e8:	00470713          	addi	a4,a4,4
    __asm__ volatile ("csrw sepc, %[sepc]" : : [sepc] "r"(sepc));
    800013ec:	14171073          	csrw	sepc,a4
        switch (syscall_num) {
    800013f0:	01100713          	li	a4,17
    800013f4:	0ae78663          	beq	a5,a4,800014a0 <handleSupervisorTrap+0x130>
    800013f8:	02f76663          	bltu	a4,a5,80001424 <handleSupervisorTrap+0xb4>
    800013fc:	00100713          	li	a4,1
    80001400:	08e78263          	beq	a5,a4,80001484 <handleSupervisorTrap+0x114>
    80001404:	00200713          	li	a4,2
    80001408:	fce792e3          	bne	a5,a4,800013cc <handleSupervisorTrap+0x5c>
                running->syscall_retval=(uint64) kern_mem_free((void*)addr);
    8000140c:	00000097          	auipc	ra,0x0
    80001410:	ddc080e7          	jalr	-548(ra) # 800011e8 <kern_mem_free>
    80001414:	00003797          	auipc	a5,0x3
    80001418:	f247b783          	ld	a5,-220(a5) # 80004338 <running>
    8000141c:	04a7b423          	sd	a0,72(a5)
                break;
    80001420:	fadff06f          	j	800013cc <handleSupervisorTrap+0x5c>
        switch (syscall_num) {
    80001424:	01300713          	li	a4,19
    80001428:	fae792e3          	bne	a5,a4,800013cc <handleSupervisorTrap+0x5c>
}

inline uint64 r_sstatus()
{
    uint64 volatile sstatus;
    __asm__ volatile ("csrr %[sstatus], sstatus" : [sstatus] "=r"(sstatus));
    8000142c:	100027f3          	csrr	a5,sstatus
    80001430:	fcf43c23          	sd	a5,-40(s0)
    return sstatus;
    80001434:	fd843783          	ld	a5,-40(s0)
                uint64 volatile sstatus = r_sstatus();
    80001438:	faf43023          	sd	a5,-96(s0)
    __asm__ volatile ("csrr %[sepc], sepc" : [sepc] "=r"(sepc));
    8000143c:	141027f3          	csrr	a5,sepc
    80001440:	fcf43823          	sd	a5,-48(s0)
    return sepc;
    80001444:	fd043783          	ld	a5,-48(s0)
                uint64 volatile v_sepc = r_sepc();
    80001448:	faf43423          	sd	a5,-88(s0)
                kern_thread_dispatch();
    8000144c:	00000097          	auipc	ra,0x0
    80001450:	344080e7          	jalr	836(ra) # 80001790 <kern_thread_dispatch>
                w_sstatus(sstatus);
    80001454:	fa043783          	ld	a5,-96(s0)
}

inline void w_sstatus(uint64 sstatus)
{
    __asm__ volatile ("csrw sstatus, %[sstatus]" : : [sstatus] "r"(sstatus));
    80001458:	10079073          	csrw	sstatus,a5
                w_sepc(v_sepc);
    8000145c:	fa843783          	ld	a5,-88(s0)
    __asm__ volatile ("csrw sepc, %[sepc]" : : [sepc] "r"(sepc));
    80001460:	14179073          	csrw	sepc,a5
                running->endTime=time+running->timeslice;
    80001464:	00003717          	auipc	a4,0x3
    80001468:	ed473703          	ld	a4,-300(a4) # 80004338 <running>
    8000146c:	03073683          	ld	a3,48(a4)
    80001470:	00003797          	auipc	a5,0x3
    80001474:	eb87a783          	lw	a5,-328(a5) # 80004328 <time>
    80001478:	00d787b3          	add	a5,a5,a3
    8000147c:	02f73c23          	sd	a5,56(a4)
                break;
    80001480:	f4dff06f          	j	800013cc <handleSupervisorTrap+0x5c>
                running->syscall_retval=(uint64)kern_mem_alloc(size);
    80001484:	0005051b          	sext.w	a0,a0
    80001488:	00000097          	auipc	ra,0x0
    8000148c:	c9c080e7          	jalr	-868(ra) # 80001124 <kern_mem_alloc>
    80001490:	00003797          	auipc	a5,0x3
    80001494:	ea87b783          	ld	a5,-344(a5) # 80004338 <running>
    80001498:	04a7b423          	sd	a0,72(a5)
                break;
    8000149c:	f31ff06f          	j	800013cc <handleSupervisorTrap+0x5c>
                running->syscall_retval=(uint64) kern_thread_create((thread_t*)handle,
    800014a0:	00000097          	auipc	ra,0x0
    800014a4:	364080e7          	jalr	868(ra) # 80001804 <kern_thread_create>
    800014a8:	00003797          	auipc	a5,0x3
    800014ac:	e907b783          	ld	a5,-368(a5) # 80004338 <running>
    800014b0:	04a7b423          	sd	a0,72(a5)
                break;
    800014b4:	f19ff06f          	j	800013cc <handleSupervisorTrap+0x5c>
        SYSTEM_TIME++;
    800014b8:	00003717          	auipc	a4,0x3
    800014bc:	e7870713          	addi	a4,a4,-392 # 80004330 <SYSTEM_TIME>
    800014c0:	00073783          	ld	a5,0(a4)
    800014c4:	00178793          	addi	a5,a5,1
    800014c8:	00f73023          	sd	a5,0(a4)
    __asm__ volatile ("csrc sip, %[mask]" : : [mask] "r"(mask));
    800014cc:	00200793          	li	a5,2
    800014d0:	1447b073          	csrc	sip,a5
        if(++time>=30){
    800014d4:	00003717          	auipc	a4,0x3
    800014d8:	e5470713          	addi	a4,a4,-428 # 80004328 <time>
    800014dc:	00072783          	lw	a5,0(a4)
    800014e0:	0017879b          	addiw	a5,a5,1
    800014e4:	0007869b          	sext.w	a3,a5
    800014e8:	00f72023          	sw	a5,0(a4)
    800014ec:	01d00793          	li	a5,29
    800014f0:	08d7cc63          	blt	a5,a3,80001588 <handleSupervisorTrap+0x218>
        time=time%30;
    800014f4:	00003717          	auipc	a4,0x3
    800014f8:	e3470713          	addi	a4,a4,-460 # 80004328 <time>
    800014fc:	00072783          	lw	a5,0(a4)
    80001500:	01e00693          	li	a3,30
    80001504:	02d7e7bb          	remw	a5,a5,a3
    80001508:	00f72023          	sw	a5,0(a4)
        if(SYSTEM_TIME>=running->endTime){
    8000150c:	00003797          	auipc	a5,0x3
    80001510:	e2c7b783          	ld	a5,-468(a5) # 80004338 <running>
    80001514:	0387b703          	ld	a4,56(a5)
    80001518:	00003797          	auipc	a5,0x3
    8000151c:	e187b783          	ld	a5,-488(a5) # 80004330 <SYSTEM_TIME>
    80001520:	eae7e6e3          	bltu	a5,a4,800013cc <handleSupervisorTrap+0x5c>
            __putc('!');
    80001524:	02100513          	li	a0,33
    80001528:	00002097          	auipc	ra,0x2
    8000152c:	7a4080e7          	jalr	1956(ra) # 80003ccc <__putc>
    __asm__ volatile ("csrr %[sstatus], sstatus" : [sstatus] "=r"(sstatus));
    80001530:	100027f3          	csrr	a5,sstatus
    80001534:	fef43423          	sd	a5,-24(s0)
    return sstatus;
    80001538:	fe843783          	ld	a5,-24(s0)
            uint64 volatile sstatus = r_sstatus();
    8000153c:	faf43823          	sd	a5,-80(s0)
    __asm__ volatile ("csrr %[sepc], sepc" : [sepc] "=r"(sepc));
    80001540:	141027f3          	csrr	a5,sepc
    80001544:	fef43023          	sd	a5,-32(s0)
    return sepc;
    80001548:	fe043783          	ld	a5,-32(s0)
            uint64 volatile v_sepc = r_sepc();
    8000154c:	faf43c23          	sd	a5,-72(s0)
            kern_thread_dispatch();
    80001550:	00000097          	auipc	ra,0x0
    80001554:	240080e7          	jalr	576(ra) # 80001790 <kern_thread_dispatch>
            w_sstatus(sstatus);
    80001558:	fb043783          	ld	a5,-80(s0)
    __asm__ volatile ("csrw sstatus, %[sstatus]" : : [sstatus] "r"(sstatus));
    8000155c:	10079073          	csrw	sstatus,a5
            w_sepc(v_sepc);
    80001560:	fb843783          	ld	a5,-72(s0)
    __asm__ volatile ("csrw sepc, %[sepc]" : : [sepc] "r"(sepc));
    80001564:	14179073          	csrw	sepc,a5
            running->endTime=SYSTEM_TIME+running->timeslice;
    80001568:	00003717          	auipc	a4,0x3
    8000156c:	dd073703          	ld	a4,-560(a4) # 80004338 <running>
    80001570:	03073783          	ld	a5,48(a4)
    80001574:	00003697          	auipc	a3,0x3
    80001578:	dbc6b683          	ld	a3,-580(a3) # 80004330 <SYSTEM_TIME>
    8000157c:	00d787b3          	add	a5,a5,a3
    80001580:	02f73c23          	sd	a5,56(a4)
    80001584:	e49ff06f          	j	800013cc <handleSupervisorTrap+0x5c>
            __putc('0'+running->id);
    80001588:	00003797          	auipc	a5,0x3
    8000158c:	db07b783          	ld	a5,-592(a5) # 80004338 <running>
    80001590:	0107b503          	ld	a0,16(a5)
    80001594:	0305051b          	addiw	a0,a0,48
    80001598:	0ff57513          	andi	a0,a0,255
    8000159c:	00002097          	auipc	ra,0x2
    800015a0:	730080e7          	jalr	1840(ra) # 80003ccc <__putc>
    800015a4:	f51ff06f          	j	800014f4 <handleSupervisorTrap+0x184>
        console_handler();
    800015a8:	00002097          	auipc	ra,0x2
    800015ac:	798080e7          	jalr	1944(ra) # 80003d40 <console_handler>
}
    800015b0:	e1dff06f          	j	800013cc <handleSupervisorTrap+0x5c>

00000000800015b4 <kern_thread_init>:
struct thread_s threads[MAX_THREADS];
static int id;
struct thread_s* running;

void kern_thread_init()
{
    800015b4:	ff010113          	addi	sp,sp,-16
    800015b8:	00813423          	sd	s0,8(sp)
    800015bc:	01010413          	addi	s0,sp,16
    id=0;
    800015c0:	00003797          	auipc	a5,0x3
    800015c4:	d807a023          	sw	zero,-640(a5) # 80004340 <id>
    for (int i=0;i<MAX_THREADS;i++){
    800015c8:	00000793          	li	a5,0
    800015cc:	0240006f          	j	800015f0 <kern_thread_init+0x3c>
        threads[i].status=UNUSED;
    800015d0:	00279713          	slli	a4,a5,0x2
    800015d4:	00f70733          	add	a4,a4,a5
    800015d8:	00471693          	slli	a3,a4,0x4
    800015dc:	00003717          	auipc	a4,0x3
    800015e0:	d9470713          	addi	a4,a4,-620 # 80004370 <threads>
    800015e4:	00d70733          	add	a4,a4,a3
    800015e8:	04072223          	sw	zero,68(a4)
    for (int i=0;i<MAX_THREADS;i++){
    800015ec:	0017879b          	addiw	a5,a5,1
    800015f0:	03f00713          	li	a4,63
    800015f4:	fcf75ee3          	bge	a4,a5,800015d0 <kern_thread_init+0x1c>
    }

    //set threads[0] as main thread
    threads[0].status=RUNNING;
    800015f8:	00003797          	auipc	a5,0x3
    800015fc:	d7878793          	addi	a5,a5,-648 # 80004370 <threads>
    80001600:	00100713          	li	a4,1
    80001604:	04e7a223          	sw	a4,68(a5)
    threads[0].id=0;
    80001608:	0007b823          	sd	zero,16(a5)
    threads[0].timeslice=DEFAULT_TIME_SLICE+2;
    8000160c:	00400713          	li	a4,4
    80001610:	02e7b823          	sd	a4,48(a5)
    threads[0].endTime=9999;
    80001614:	00002737          	lui	a4,0x2
    80001618:	70f70713          	addi	a4,a4,1807 # 270f <_entry-0x7fffd8f1>
    8000161c:	02e7bc23          	sd	a4,56(a5)
    running=&threads[0];
    80001620:	00003717          	auipc	a4,0x3
    80001624:	d0f73c23          	sd	a5,-744(a4) # 80004338 <running>
}
    80001628:	00813403          	ld	s0,8(sp)
    8000162c:	01010113          	addi	sp,sp,16
    80001630:	00008067          	ret

0000000080001634 <kern_scheduler_get>:

thread_t kern_scheduler_get()
{
    80001634:	ff010113          	addi	sp,sp,-16
    80001638:	00813423          	sd	s0,8(sp)
    8000163c:	01010413          	addi	s0,sp,16
    int num = running-threads;
    80001640:	00003517          	auipc	a0,0x3
    80001644:	cf853503          	ld	a0,-776(a0) # 80004338 <running>
    80001648:	00003797          	auipc	a5,0x3
    8000164c:	d2878793          	addi	a5,a5,-728 # 80004370 <threads>
    80001650:	40f507b3          	sub	a5,a0,a5
    80001654:	4047d793          	srai	a5,a5,0x4
    80001658:	00003717          	auipc	a4,0x3
    8000165c:	9a873703          	ld	a4,-1624(a4) # 80004000 <console_handler+0x2c0>
    80001660:	02e787bb          	mulw	a5,a5,a4
    for(int i=1;i<=MAX_THREADS;i++){
    80001664:	00100693          	li	a3,1
    80001668:	04000713          	li	a4,64
    8000166c:	06d74663          	blt	a4,a3,800016d8 <kern_scheduler_get+0xa4>
        num = (num+i)%MAX_THREADS;
    80001670:	00d787bb          	addw	a5,a5,a3
    80001674:	41f7d71b          	sraiw	a4,a5,0x1f
    80001678:	01a7571b          	srliw	a4,a4,0x1a
    8000167c:	00e787bb          	addw	a5,a5,a4
    80001680:	03f7f793          	andi	a5,a5,63
    80001684:	40e787bb          	subw	a5,a5,a4
        if(threads[num].status==READY) return &threads[num];
    80001688:	00279713          	slli	a4,a5,0x2
    8000168c:	00f70733          	add	a4,a4,a5
    80001690:	00471613          	slli	a2,a4,0x4
    80001694:	00003717          	auipc	a4,0x3
    80001698:	cdc70713          	addi	a4,a4,-804 # 80004370 <threads>
    8000169c:	00c70733          	add	a4,a4,a2
    800016a0:	04472603          	lw	a2,68(a4)
    800016a4:	00200713          	li	a4,2
    800016a8:	00e60663          	beq	a2,a4,800016b4 <kern_scheduler_get+0x80>
    for(int i=1;i<=MAX_THREADS;i++){
    800016ac:	0016869b          	addiw	a3,a3,1
    800016b0:	fb9ff06f          	j	80001668 <kern_scheduler_get+0x34>
        if(threads[num].status==READY) return &threads[num];
    800016b4:	00279713          	slli	a4,a5,0x2
    800016b8:	00f707b3          	add	a5,a4,a5
    800016bc:	00479513          	slli	a0,a5,0x4
    800016c0:	00003797          	auipc	a5,0x3
    800016c4:	cb078793          	addi	a5,a5,-848 # 80004370 <threads>
    800016c8:	00f50533          	add	a0,a0,a5
    }
    if(running->status==READY) return running;
    return 0;
}
    800016cc:	00813403          	ld	s0,8(sp)
    800016d0:	01010113          	addi	sp,sp,16
    800016d4:	00008067          	ret
    if(running->status==READY) return running;
    800016d8:	04452703          	lw	a4,68(a0)
    800016dc:	00200793          	li	a5,2
    800016e0:	fef706e3          	beq	a4,a5,800016cc <kern_scheduler_get+0x98>
    return 0;
    800016e4:	00000513          	li	a0,0
    800016e8:	fe5ff06f          	j	800016cc <kern_scheduler_get+0x98>

00000000800016ec <kern_thread_yield>:

void kern_thread_yield()
{
    800016ec:	ff010113          	addi	sp,sp,-16
    800016f0:	00113423          	sd	ra,8(sp)
    800016f4:	00813023          	sd	s0,0(sp)
    800016f8:	01010413          	addi	s0,sp,16
    kern_syscall(THREAD_DISPATCH);
    800016fc:	01300513          	li	a0,19
    80001700:	00000097          	auipc	ra,0x0
    80001704:	bf8080e7          	jalr	-1032(ra) # 800012f8 <kern_syscall>
}
    80001708:	00813083          	ld	ra,8(sp)
    8000170c:	00013403          	ld	s0,0(sp)
    80001710:	01010113          	addi	sp,sp,16
    80001714:	00008067          	ret

0000000080001718 <popSppSpie>:

//samo izlazi iz kernela i vraca se odakle je pozvana
void popSppSpie()
{
    80001718:	ff010113          	addi	sp,sp,-16
    8000171c:	00813423          	sd	s0,8(sp)
    80001720:	01010413          	addi	s0,sp,16
    __asm__ volatile("csrw sepc, ra"); //ovde dodaj izlazak iz privilegovanog moda
    80001724:	14109073          	csrw	sepc,ra
    __asm__ volatile("sret");
    80001728:	10200073          	sret
}
    8000172c:	00813403          	ld	s0,8(sp)
    80001730:	01010113          	addi	sp,sp,16
    80001734:	00008067          	ret

0000000080001738 <kern_thread_wrapper>:
        contextSwitch(old,running);
    }
}

void kern_thread_wrapper()
{
    80001738:	fe010113          	addi	sp,sp,-32
    8000173c:	00113c23          	sd	ra,24(sp)
    80001740:	00813823          	sd	s0,16(sp)
    80001744:	00913423          	sd	s1,8(sp)
    80001748:	02010413          	addi	s0,sp,32
    popSppSpie();
    8000174c:	00000097          	auipc	ra,0x0
    80001750:	fcc080e7          	jalr	-52(ra) # 80001718 <popSppSpie>
    running->body(running->arg);
    80001754:	00003497          	auipc	s1,0x3
    80001758:	be448493          	addi	s1,s1,-1052 # 80004338 <running>
    8000175c:	0004b783          	ld	a5,0(s1)
    80001760:	0187b703          	ld	a4,24(a5)
    80001764:	0207b503          	ld	a0,32(a5)
    80001768:	000700e7          	jalr	a4
    running->status=UNUSED;
    8000176c:	0004b783          	ld	a5,0(s1)
    80001770:	0407a223          	sw	zero,68(a5)
    kern_thread_yield();
    80001774:	00000097          	auipc	ra,0x0
    80001778:	f78080e7          	jalr	-136(ra) # 800016ec <kern_thread_yield>
}
    8000177c:	01813083          	ld	ra,24(sp)
    80001780:	01013403          	ld	s0,16(sp)
    80001784:	00813483          	ld	s1,8(sp)
    80001788:	02010113          	addi	sp,sp,32
    8000178c:	00008067          	ret

0000000080001790 <kern_thread_dispatch>:
{
    80001790:	fe010113          	addi	sp,sp,-32
    80001794:	00113c23          	sd	ra,24(sp)
    80001798:	00813823          	sd	s0,16(sp)
    8000179c:	00913423          	sd	s1,8(sp)
    800017a0:	01213023          	sd	s2,0(sp)
    800017a4:	02010413          	addi	s0,sp,32
    thread_t old = running;
    800017a8:	00003917          	auipc	s2,0x3
    800017ac:	b9090913          	addi	s2,s2,-1136 # 80004338 <running>
    800017b0:	00093483          	ld	s1,0(s2)
    running=kern_scheduler_get();
    800017b4:	00000097          	auipc	ra,0x0
    800017b8:	e80080e7          	jalr	-384(ra) # 80001634 <kern_scheduler_get>
    800017bc:	00a93023          	sd	a0,0(s2)
    if(old!=running){
    800017c0:	02950063          	beq	a0,s1,800017e0 <kern_thread_dispatch+0x50>
    800017c4:	00050593          	mv	a1,a0
        if(old->status==RUNNING) old->status=READY;
    800017c8:	0444a703          	lw	a4,68(s1)
    800017cc:	00100793          	li	a5,1
    800017d0:	02f70463          	beq	a4,a5,800017f8 <kern_thread_dispatch+0x68>
        contextSwitch(old,running);
    800017d4:	00048513          	mv	a0,s1
    800017d8:	00000097          	auipc	ra,0x0
    800017dc:	938080e7          	jalr	-1736(ra) # 80001110 <contextSwitch>
}
    800017e0:	01813083          	ld	ra,24(sp)
    800017e4:	01013403          	ld	s0,16(sp)
    800017e8:	00813483          	ld	s1,8(sp)
    800017ec:	00013903          	ld	s2,0(sp)
    800017f0:	02010113          	addi	sp,sp,32
    800017f4:	00008067          	ret
        if(old->status==RUNNING) old->status=READY;
    800017f8:	00200793          	li	a5,2
    800017fc:	04f4a223          	sw	a5,68(s1)
    80001800:	fd5ff06f          	j	800017d4 <kern_thread_dispatch+0x44>

0000000080001804 <kern_thread_create>:

int kern_thread_create(thread_t* handle, void(*start_routine)(void*), void* arg, void* stack_space)
{
    80001804:	ff010113          	addi	sp,sp,-16
    80001808:	00813423          	sd	s0,8(sp)
    8000180c:	01010413          	addi	s0,sp,16
    *handle=0;
    80001810:	00053023          	sd	zero,0(a0)
    thread_t t=&threads[0]; //dodela da bismo sklonili upozorenje
    for(int i=0;i<MAX_THREADS;i++){
    80001814:	00000713          	li	a4,0
    80001818:	03f00793          	li	a5,63
    8000181c:	0ae7c463          	blt	a5,a4,800018c4 <kern_thread_create+0xc0>
        if(threads[i].status==UNUSED){
    80001820:	00271793          	slli	a5,a4,0x2
    80001824:	00e787b3          	add	a5,a5,a4
    80001828:	00479793          	slli	a5,a5,0x4
    8000182c:	00003817          	auipc	a6,0x3
    80001830:	b4480813          	addi	a6,a6,-1212 # 80004370 <threads>
    80001834:	00f807b3          	add	a5,a6,a5
    80001838:	0447a783          	lw	a5,68(a5)
    8000183c:	00078663          	beqz	a5,80001848 <kern_thread_create+0x44>
    for(int i=0;i<MAX_THREADS;i++){
    80001840:	0017071b          	addiw	a4,a4,1
    80001844:	fd5ff06f          	j	80001818 <kern_thread_create+0x14>
            *handle=&threads[i];
    80001848:	00271793          	slli	a5,a4,0x2
    8000184c:	00e787b3          	add	a5,a5,a4
    80001850:	00479793          	slli	a5,a5,0x4
    80001854:	010787b3          	add	a5,a5,a6
    80001858:	00f53023          	sd	a5,0(a0)
            t=&threads[i];
            break;
        }
    }
    if(*handle==0) return -1;
    8000185c:	00053703          	ld	a4,0(a0)
    80001860:	06070863          	beqz	a4,800018d0 <kern_thread_create+0xcc>

    t->id=++id;
    80001864:	00003517          	auipc	a0,0x3
    80001868:	adc50513          	addi	a0,a0,-1316 # 80004340 <id>
    8000186c:	00052703          	lw	a4,0(a0)
    80001870:	0017071b          	addiw	a4,a4,1
    80001874:	0007081b          	sext.w	a6,a4
    80001878:	00e52023          	sw	a4,0(a0)
    8000187c:	0107b823          	sd	a6,16(a5)
    t->status=READY;
    80001880:	00200713          	li	a4,2
    80001884:	04e7a223          	sw	a4,68(a5)
    t->type=REGULAR;
    80001888:	0407a023          	sw	zero,64(a5)
    t->arg=arg;
    8000188c:	02c7b023          	sd	a2,32(a5)
    t->joined_tid=-1;
    80001890:	fff00713          	li	a4,-1
    80001894:	02e7b423          	sd	a4,40(a5)
    t->timeslice=DEFAULT_TIME_SLICE;
    80001898:	00200713          	li	a4,2
    8000189c:	02e7b823          	sd	a4,48(a5)
    t->body=start_routine;
    800018a0:	00b7bc23          	sd	a1,24(a5)
    t->sp = ((uint64)stack_space);
    800018a4:	00d7b423          	sd	a3,8(a5)
    t->ra=(uint64) &kern_thread_wrapper;
    800018a8:	00000717          	auipc	a4,0x0
    800018ac:	e9070713          	addi	a4,a4,-368 # 80001738 <kern_thread_wrapper>
    800018b0:	00e7b023          	sd	a4,0(a5)

    return 0;
    800018b4:	00000513          	li	a0,0
}
    800018b8:	00813403          	ld	s0,8(sp)
    800018bc:	01010113          	addi	sp,sp,16
    800018c0:	00008067          	ret
    thread_t t=&threads[0]; //dodela da bismo sklonili upozorenje
    800018c4:	00003797          	auipc	a5,0x3
    800018c8:	aac78793          	addi	a5,a5,-1364 # 80004370 <threads>
    800018cc:	f91ff06f          	j	8000185c <kern_thread_create+0x58>
    if(*handle==0) return -1;
    800018d0:	fff00513          	li	a0,-1
    800018d4:	fe5ff06f          	j	800018b8 <kern_thread_create+0xb4>

00000000800018d8 <mem_alloc>:
#include "../h/kern_reg_util.h"
#include "../h/kern_interrupts.h"

#include <stdarg.h>

void* mem_alloc (size_t size){
    800018d8:	ff010113          	addi	sp,sp,-16
    800018dc:	00113423          	sd	ra,8(sp)
    800018e0:	00813023          	sd	s0,0(sp)
    800018e4:	01010413          	addi	s0,sp,16
    uint64 blocks = (size+MEM_BLOCK_SIZE-1)/MEM_BLOCK_SIZE;
    800018e8:	03f50593          	addi	a1,a0,63
    return (void*)kern_syscall(MEM_ALLOC, blocks);
    800018ec:	0065d593          	srli	a1,a1,0x6
    800018f0:	00100513          	li	a0,1
    800018f4:	00000097          	auipc	ra,0x0
    800018f8:	a04080e7          	jalr	-1532(ra) # 800012f8 <kern_syscall>
}
    800018fc:	00813083          	ld	ra,8(sp)
    80001900:	00013403          	ld	s0,0(sp)
    80001904:	01010113          	addi	sp,sp,16
    80001908:	00008067          	ret

000000008000190c <mem_free>:

int mem_free (void* addr){
    8000190c:	ff010113          	addi	sp,sp,-16
    80001910:	00113423          	sd	ra,8(sp)
    80001914:	00813023          	sd	s0,0(sp)
    80001918:	01010413          	addi	s0,sp,16
    8000191c:	00050593          	mv	a1,a0
    return (int) kern_syscall(MEM_FREE,addr);
    80001920:	00200513          	li	a0,2
    80001924:	00000097          	auipc	ra,0x0
    80001928:	9d4080e7          	jalr	-1580(ra) # 800012f8 <kern_syscall>
}
    8000192c:	0005051b          	sext.w	a0,a0
    80001930:	00813083          	ld	ra,8(sp)
    80001934:	00013403          	ld	s0,0(sp)
    80001938:	01010113          	addi	sp,sp,16
    8000193c:	00008067          	ret

0000000080001940 <thread_create>:

struct thread_s;
typedef struct thread_s* thread_t;

int thread_create (thread_t* handle, void(*start_routine)(void*), void* arg)
{
    80001940:	fd010113          	addi	sp,sp,-48
    80001944:	02113423          	sd	ra,40(sp)
    80001948:	02813023          	sd	s0,32(sp)
    8000194c:	00913c23          	sd	s1,24(sp)
    80001950:	01213823          	sd	s2,16(sp)
    80001954:	01313423          	sd	s3,8(sp)
    80001958:	03010413          	addi	s0,sp,48
    8000195c:	00050493          	mv	s1,a0
    80001960:	00058913          	mv	s2,a1
    80001964:	00060993          	mv	s3,a2
    void * stack = mem_alloc(DEFAULT_STACK_SIZE);
    80001968:	00001537          	lui	a0,0x1
    8000196c:	00000097          	auipc	ra,0x0
    80001970:	f6c080e7          	jalr	-148(ra) # 800018d8 <mem_alloc>
    if(stack==0) return -1;
    80001974:	04050063          	beqz	a0,800019b4 <thread_create+0x74>
    80001978:	00050713          	mv	a4,a0
    return (int) kern_syscall(THREAD_CREATE,handle,start_routine,arg,stack);
    8000197c:	00098693          	mv	a3,s3
    80001980:	00090613          	mv	a2,s2
    80001984:	00048593          	mv	a1,s1
    80001988:	01100513          	li	a0,17
    8000198c:	00000097          	auipc	ra,0x0
    80001990:	96c080e7          	jalr	-1684(ra) # 800012f8 <kern_syscall>
    80001994:	0005051b          	sext.w	a0,a0
}
    80001998:	02813083          	ld	ra,40(sp)
    8000199c:	02013403          	ld	s0,32(sp)
    800019a0:	01813483          	ld	s1,24(sp)
    800019a4:	01013903          	ld	s2,16(sp)
    800019a8:	00813983          	ld	s3,8(sp)
    800019ac:	03010113          	addi	sp,sp,48
    800019b0:	00008067          	ret
    if(stack==0) return -1;
    800019b4:	fff00513          	li	a0,-1
    800019b8:	fe1ff06f          	j	80001998 <thread_create+0x58>

00000000800019bc <thread_dispatch>:

void thread_dispatch(){
    800019bc:	ff010113          	addi	sp,sp,-16
    800019c0:	00113423          	sd	ra,8(sp)
    800019c4:	00813023          	sd	s0,0(sp)
    800019c8:	01010413          	addi	s0,sp,16
    kern_syscall(THREAD_DISPATCH);
    800019cc:	01300513          	li	a0,19
    800019d0:	00000097          	auipc	ra,0x0
    800019d4:	928080e7          	jalr	-1752(ra) # 800012f8 <kern_syscall>
}
    800019d8:	00813083          	ld	ra,8(sp)
    800019dc:	00013403          	ld	s0,0(sp)
    800019e0:	01010113          	addi	sp,sp,16
    800019e4:	00008067          	ret

00000000800019e8 <_Z5bodyBPv>:
}

int g=0;

void bodyB(void* arg)
{
    800019e8:	fe010113          	addi	sp,sp,-32
    800019ec:	00113c23          	sd	ra,24(sp)
    800019f0:	00813823          	sd	s0,16(sp)
    800019f4:	00913423          	sd	s1,8(sp)
    800019f8:	02010413          	addi	s0,sp,32
    for(int i=0;i<15;i++){
    800019fc:	00000493          	li	s1,0
    80001a00:	0540006f          	j	80001a54 <_Z5bodyBPv+0x6c>
        __putc('b');
        for(int k=0;k<10000;k++){
            for(int m=0;m<1000;m++){
    80001a04:	0017071b          	addiw	a4,a4,1
    80001a08:	3e700793          	li	a5,999
    80001a0c:	02e7c663          	blt	a5,a4,80001a38 <_Z5bodyBPv+0x50>
                if((m*k)%1337==0) g++;
    80001a10:	02e607bb          	mulw	a5,a2,a4
    80001a14:	53900693          	li	a3,1337
    80001a18:	02d7e7bb          	remw	a5,a5,a3
    80001a1c:	fe0794e3          	bnez	a5,80001a04 <_Z5bodyBPv+0x1c>
    80001a20:	00004697          	auipc	a3,0x4
    80001a24:	d5068693          	addi	a3,a3,-688 # 80005770 <g>
    80001a28:	0006a783          	lw	a5,0(a3)
    80001a2c:	0017879b          	addiw	a5,a5,1
    80001a30:	00f6a023          	sw	a5,0(a3)
    80001a34:	fd1ff06f          	j	80001a04 <_Z5bodyBPv+0x1c>
        for(int k=0;k<10000;k++){
    80001a38:	0016061b          	addiw	a2,a2,1
    80001a3c:	000027b7          	lui	a5,0x2
    80001a40:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    80001a44:	00c7c663          	blt	a5,a2,80001a50 <_Z5bodyBPv+0x68>
            for(int m=0;m<1000;m++){
    80001a48:	00000713          	li	a4,0
    80001a4c:	fbdff06f          	j	80001a08 <_Z5bodyBPv+0x20>
    for(int i=0;i<15;i++){
    80001a50:	0014849b          	addiw	s1,s1,1
    80001a54:	00e00793          	li	a5,14
    80001a58:	0097cc63          	blt	a5,s1,80001a70 <_Z5bodyBPv+0x88>
        __putc('b');
    80001a5c:	06200513          	li	a0,98
    80001a60:	00002097          	auipc	ra,0x2
    80001a64:	26c080e7          	jalr	620(ra) # 80003ccc <__putc>
        for(int k=0;k<10000;k++){
    80001a68:	00000613          	li	a2,0
    80001a6c:	fd1ff06f          	j	80001a3c <_Z5bodyBPv+0x54>
            }
        }
    }
}
    80001a70:	01813083          	ld	ra,24(sp)
    80001a74:	01013403          	ld	s0,16(sp)
    80001a78:	00813483          	ld	s1,8(sp)
    80001a7c:	02010113          	addi	sp,sp,32
    80001a80:	00008067          	ret

0000000080001a84 <_Z5bodyAPv>:
{
    80001a84:	fe010113          	addi	sp,sp,-32
    80001a88:	00113c23          	sd	ra,24(sp)
    80001a8c:	00813823          	sd	s0,16(sp)
    80001a90:	00913423          	sd	s1,8(sp)
    80001a94:	02010413          	addi	s0,sp,32
    for(int i=0;i<10;i++){
    80001a98:	00000493          	li	s1,0
    80001a9c:	00900793          	li	a5,9
    80001aa0:	0297c063          	blt	a5,s1,80001ac0 <_Z5bodyAPv+0x3c>
        __putc('a');
    80001aa4:	06100513          	li	a0,97
    80001aa8:	00002097          	auipc	ra,0x2
    80001aac:	224080e7          	jalr	548(ra) # 80003ccc <__putc>
        thread_dispatch();
    80001ab0:	00000097          	auipc	ra,0x0
    80001ab4:	f0c080e7          	jalr	-244(ra) # 800019bc <thread_dispatch>
    for(int i=0;i<10;i++){
    80001ab8:	0014849b          	addiw	s1,s1,1
    80001abc:	fe1ff06f          	j	80001a9c <_Z5bodyAPv+0x18>
}
    80001ac0:	01813083          	ld	ra,24(sp)
    80001ac4:	01013403          	ld	s0,16(sp)
    80001ac8:	00813483          	ld	s1,8(sp)
    80001acc:	02010113          	addi	sp,sp,32
    80001ad0:	00008067          	ret

0000000080001ad4 <main>:


int main()
{
    80001ad4:	fd010113          	addi	sp,sp,-48
    80001ad8:	02113423          	sd	ra,40(sp)
    80001adc:	02813023          	sd	s0,32(sp)
    80001ae0:	00913c23          	sd	s1,24(sp)
    80001ae4:	03010413          	addi	s0,sp,48
    kern_thread_init();
    80001ae8:	00000097          	auipc	ra,0x0
    80001aec:	acc080e7          	jalr	-1332(ra) # 800015b4 <kern_thread_init>
    __putc('o');
    80001af0:	06f00513          	li	a0,111
    80001af4:	00002097          	auipc	ra,0x2
    80001af8:	1d8080e7          	jalr	472(ra) # 80003ccc <__putc>
    __putc('s');
    80001afc:	07300513          	li	a0,115
    80001b00:	00002097          	auipc	ra,0x2
    80001b04:	1cc080e7          	jalr	460(ra) # 80003ccc <__putc>
    __putc('1');
    80001b08:	03100513          	li	a0,49
    80001b0c:	00002097          	auipc	ra,0x2
    80001b10:	1c0080e7          	jalr	448(ra) # 80003ccc <__putc>
    //printstring("lalala");

    kern_mem_init((void*)HEAP_START_ADDR, (void*)HEAP_END_ADDR);
    80001b14:	00002797          	auipc	a5,0x2
    80001b18:	7f47b783          	ld	a5,2036(a5) # 80004308 <_GLOBAL_OFFSET_TABLE_+0x18>
    80001b1c:	0007b583          	ld	a1,0(a5)
    80001b20:	00002797          	auipc	a5,0x2
    80001b24:	7d87b783          	ld	a5,2008(a5) # 800042f8 <_GLOBAL_OFFSET_TABLE_+0x8>
    80001b28:	0007b503          	ld	a0,0(a5)
    80001b2c:	fffff097          	auipc	ra,0xfffff
    80001b30:	76c080e7          	jalr	1900(ra) # 80001298 <kern_mem_init>
    kern_interrupt_init();
    80001b34:	00000097          	auipc	ra,0x0
    80001b38:	808080e7          	jalr	-2040(ra) # 8000133c <kern_interrupt_init>

    a= mem_alloc(64);
    mem_free(a);
*/
    thread_t thrA, thrB;
    thread_create(&thrA,&bodyA,0);
    80001b3c:	00000613          	li	a2,0
    80001b40:	00000597          	auipc	a1,0x0
    80001b44:	f4458593          	addi	a1,a1,-188 # 80001a84 <_Z5bodyAPv>
    80001b48:	fd840513          	addi	a0,s0,-40
    80001b4c:	00000097          	auipc	ra,0x0
    80001b50:	df4080e7          	jalr	-524(ra) # 80001940 <thread_create>
    thread_create(&thrB,&bodyB,0);
    80001b54:	00000613          	li	a2,0
    80001b58:	00000597          	auipc	a1,0x0
    80001b5c:	e9058593          	addi	a1,a1,-368 # 800019e8 <_Z5bodyBPv>
    80001b60:	fd040513          	addi	a0,s0,-48
    80001b64:	00000097          	auipc	ra,0x0
    80001b68:	ddc080e7          	jalr	-548(ra) # 80001940 <thread_create>



    char chr = '0';
    80001b6c:	03000493          	li	s1,48
    while (1){
        __putc(chr++);
    80001b70:	00048513          	mv	a0,s1
    80001b74:	0014849b          	addiw	s1,s1,1
    80001b78:	0ff4f493          	andi	s1,s1,255
    80001b7c:	00002097          	auipc	ra,0x2
    80001b80:	150080e7          	jalr	336(ra) # 80003ccc <__putc>
        thread_dispatch();
    80001b84:	00000097          	auipc	ra,0x0
    80001b88:	e38080e7          	jalr	-456(ra) # 800019bc <thread_dispatch>
        if(thrA->status==UNUSED && thrB->status==UNUSED) break;
    80001b8c:	fd843783          	ld	a5,-40(s0)
    80001b90:	0447a783          	lw	a5,68(a5)
    80001b94:	fc079ee3          	bnez	a5,80001b70 <main+0x9c>
    80001b98:	fd043783          	ld	a5,-48(s0)
    80001b9c:	0447a783          	lw	a5,68(a5)
    80001ba0:	fc0798e3          	bnez	a5,80001b70 <main+0x9c>
    }

    __putc('E');
    80001ba4:	04500513          	li	a0,69
    80001ba8:	00002097          	auipc	ra,0x2
    80001bac:	124080e7          	jalr	292(ra) # 80003ccc <__putc>

    while(1);
    80001bb0:	0000006f          	j	80001bb0 <main+0xdc>

0000000080001bb4 <_Z11printstringPKc>:
//

#include "../h/strings.h"

void printstring(const char* string)
{
    80001bb4:	fe010113          	addi	sp,sp,-32
    80001bb8:	00113c23          	sd	ra,24(sp)
    80001bbc:	00813823          	sd	s0,16(sp)
    80001bc0:	00913423          	sd	s1,8(sp)
    80001bc4:	01213023          	sd	s2,0(sp)
    80001bc8:	02010413          	addi	s0,sp,32
    80001bcc:	00050913          	mv	s2,a0
    int i=0;
    80001bd0:	00000493          	li	s1,0
    while (string[i]){
    80001bd4:	009907b3          	add	a5,s2,s1
    80001bd8:	0007c503          	lbu	a0,0(a5)
    80001bdc:	00050a63          	beqz	a0,80001bf0 <_Z11printstringPKc+0x3c>
        __putc(string[i++]);
    80001be0:	0014849b          	addiw	s1,s1,1
    80001be4:	00002097          	auipc	ra,0x2
    80001be8:	0e8080e7          	jalr	232(ra) # 80003ccc <__putc>
    while (string[i]){
    80001bec:	fe9ff06f          	j	80001bd4 <_Z11printstringPKc+0x20>
    }
}
    80001bf0:	01813083          	ld	ra,24(sp)
    80001bf4:	01013403          	ld	s0,16(sp)
    80001bf8:	00813483          	ld	s1,8(sp)
    80001bfc:	00013903          	ld	s2,0(sp)
    80001c00:	02010113          	addi	sp,sp,32
    80001c04:	00008067          	ret

0000000080001c08 <start>:
    80001c08:	ff010113          	addi	sp,sp,-16
    80001c0c:	00813423          	sd	s0,8(sp)
    80001c10:	01010413          	addi	s0,sp,16
    80001c14:	300027f3          	csrr	a5,mstatus
    80001c18:	ffffe737          	lui	a4,0xffffe
    80001c1c:	7ff70713          	addi	a4,a4,2047 # ffffffffffffe7ff <end+0xffffffff7fff7e2f>
    80001c20:	00e7f7b3          	and	a5,a5,a4
    80001c24:	00001737          	lui	a4,0x1
    80001c28:	80070713          	addi	a4,a4,-2048 # 800 <_entry-0x7ffff800>
    80001c2c:	00e7e7b3          	or	a5,a5,a4
    80001c30:	30079073          	csrw	mstatus,a5
    80001c34:	00000797          	auipc	a5,0x0
    80001c38:	16078793          	addi	a5,a5,352 # 80001d94 <system_main>
    80001c3c:	34179073          	csrw	mepc,a5
    80001c40:	00000793          	li	a5,0
    80001c44:	18079073          	csrw	satp,a5
    80001c48:	000107b7          	lui	a5,0x10
    80001c4c:	fff78793          	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    80001c50:	30279073          	csrw	medeleg,a5
    80001c54:	30379073          	csrw	mideleg,a5
    80001c58:	104027f3          	csrr	a5,sie
    80001c5c:	2227e793          	ori	a5,a5,546
    80001c60:	10479073          	csrw	sie,a5
    80001c64:	fff00793          	li	a5,-1
    80001c68:	00a7d793          	srli	a5,a5,0xa
    80001c6c:	3b079073          	csrw	pmpaddr0,a5
    80001c70:	00f00793          	li	a5,15
    80001c74:	3a079073          	csrw	pmpcfg0,a5
    80001c78:	f14027f3          	csrr	a5,mhartid
    80001c7c:	0200c737          	lui	a4,0x200c
    80001c80:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    80001c84:	0007869b          	sext.w	a3,a5
    80001c88:	00269713          	slli	a4,a3,0x2
    80001c8c:	000f4637          	lui	a2,0xf4
    80001c90:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    80001c94:	00d70733          	add	a4,a4,a3
    80001c98:	0037979b          	slliw	a5,a5,0x3
    80001c9c:	020046b7          	lui	a3,0x2004
    80001ca0:	00d787b3          	add	a5,a5,a3
    80001ca4:	00c585b3          	add	a1,a1,a2
    80001ca8:	00371693          	slli	a3,a4,0x3
    80001cac:	00004717          	auipc	a4,0x4
    80001cb0:	ad470713          	addi	a4,a4,-1324 # 80005780 <timer_scratch>
    80001cb4:	00b7b023          	sd	a1,0(a5)
    80001cb8:	00d70733          	add	a4,a4,a3
    80001cbc:	00f73c23          	sd	a5,24(a4)
    80001cc0:	02c73023          	sd	a2,32(a4)
    80001cc4:	34071073          	csrw	mscratch,a4
    80001cc8:	00000797          	auipc	a5,0x0
    80001ccc:	6e878793          	addi	a5,a5,1768 # 800023b0 <timervec>
    80001cd0:	30579073          	csrw	mtvec,a5
    80001cd4:	300027f3          	csrr	a5,mstatus
    80001cd8:	0087e793          	ori	a5,a5,8
    80001cdc:	30079073          	csrw	mstatus,a5
    80001ce0:	304027f3          	csrr	a5,mie
    80001ce4:	0807e793          	ori	a5,a5,128
    80001ce8:	30479073          	csrw	mie,a5
    80001cec:	f14027f3          	csrr	a5,mhartid
    80001cf0:	0007879b          	sext.w	a5,a5
    80001cf4:	00078213          	mv	tp,a5
    80001cf8:	30200073          	mret
    80001cfc:	00813403          	ld	s0,8(sp)
    80001d00:	01010113          	addi	sp,sp,16
    80001d04:	00008067          	ret

0000000080001d08 <timerinit>:
    80001d08:	ff010113          	addi	sp,sp,-16
    80001d0c:	00813423          	sd	s0,8(sp)
    80001d10:	01010413          	addi	s0,sp,16
    80001d14:	f14027f3          	csrr	a5,mhartid
    80001d18:	0200c737          	lui	a4,0x200c
    80001d1c:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    80001d20:	0007869b          	sext.w	a3,a5
    80001d24:	00269713          	slli	a4,a3,0x2
    80001d28:	000f4637          	lui	a2,0xf4
    80001d2c:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    80001d30:	00d70733          	add	a4,a4,a3
    80001d34:	0037979b          	slliw	a5,a5,0x3
    80001d38:	020046b7          	lui	a3,0x2004
    80001d3c:	00d787b3          	add	a5,a5,a3
    80001d40:	00c585b3          	add	a1,a1,a2
    80001d44:	00371693          	slli	a3,a4,0x3
    80001d48:	00004717          	auipc	a4,0x4
    80001d4c:	a3870713          	addi	a4,a4,-1480 # 80005780 <timer_scratch>
    80001d50:	00b7b023          	sd	a1,0(a5)
    80001d54:	00d70733          	add	a4,a4,a3
    80001d58:	00f73c23          	sd	a5,24(a4)
    80001d5c:	02c73023          	sd	a2,32(a4)
    80001d60:	34071073          	csrw	mscratch,a4
    80001d64:	00000797          	auipc	a5,0x0
    80001d68:	64c78793          	addi	a5,a5,1612 # 800023b0 <timervec>
    80001d6c:	30579073          	csrw	mtvec,a5
    80001d70:	300027f3          	csrr	a5,mstatus
    80001d74:	0087e793          	ori	a5,a5,8
    80001d78:	30079073          	csrw	mstatus,a5
    80001d7c:	304027f3          	csrr	a5,mie
    80001d80:	0807e793          	ori	a5,a5,128
    80001d84:	30479073          	csrw	mie,a5
    80001d88:	00813403          	ld	s0,8(sp)
    80001d8c:	01010113          	addi	sp,sp,16
    80001d90:	00008067          	ret

0000000080001d94 <system_main>:
    80001d94:	fe010113          	addi	sp,sp,-32
    80001d98:	00813823          	sd	s0,16(sp)
    80001d9c:	00913423          	sd	s1,8(sp)
    80001da0:	00113c23          	sd	ra,24(sp)
    80001da4:	02010413          	addi	s0,sp,32
    80001da8:	00000097          	auipc	ra,0x0
    80001dac:	0c4080e7          	jalr	196(ra) # 80001e6c <cpuid>
    80001db0:	00002497          	auipc	s1,0x2
    80001db4:	59448493          	addi	s1,s1,1428 # 80004344 <started>
    80001db8:	02050263          	beqz	a0,80001ddc <system_main+0x48>
    80001dbc:	0004a783          	lw	a5,0(s1)
    80001dc0:	0007879b          	sext.w	a5,a5
    80001dc4:	fe078ce3          	beqz	a5,80001dbc <system_main+0x28>
    80001dc8:	0ff0000f          	fence
    80001dcc:	00002517          	auipc	a0,0x2
    80001dd0:	28450513          	addi	a0,a0,644 # 80004050 <CONSOLE_STATUS+0x38>
    80001dd4:	00001097          	auipc	ra,0x1
    80001dd8:	a78080e7          	jalr	-1416(ra) # 8000284c <panic>
    80001ddc:	00001097          	auipc	ra,0x1
    80001de0:	9cc080e7          	jalr	-1588(ra) # 800027a8 <consoleinit>
    80001de4:	00001097          	auipc	ra,0x1
    80001de8:	158080e7          	jalr	344(ra) # 80002f3c <printfinit>
    80001dec:	00002517          	auipc	a0,0x2
    80001df0:	34450513          	addi	a0,a0,836 # 80004130 <CONSOLE_STATUS+0x118>
    80001df4:	00001097          	auipc	ra,0x1
    80001df8:	ab4080e7          	jalr	-1356(ra) # 800028a8 <__printf>
    80001dfc:	00002517          	auipc	a0,0x2
    80001e00:	22450513          	addi	a0,a0,548 # 80004020 <CONSOLE_STATUS+0x8>
    80001e04:	00001097          	auipc	ra,0x1
    80001e08:	aa4080e7          	jalr	-1372(ra) # 800028a8 <__printf>
    80001e0c:	00002517          	auipc	a0,0x2
    80001e10:	32450513          	addi	a0,a0,804 # 80004130 <CONSOLE_STATUS+0x118>
    80001e14:	00001097          	auipc	ra,0x1
    80001e18:	a94080e7          	jalr	-1388(ra) # 800028a8 <__printf>
    80001e1c:	00001097          	auipc	ra,0x1
    80001e20:	4ac080e7          	jalr	1196(ra) # 800032c8 <kinit>
    80001e24:	00000097          	auipc	ra,0x0
    80001e28:	148080e7          	jalr	328(ra) # 80001f6c <trapinit>
    80001e2c:	00000097          	auipc	ra,0x0
    80001e30:	16c080e7          	jalr	364(ra) # 80001f98 <trapinithart>
    80001e34:	00000097          	auipc	ra,0x0
    80001e38:	5bc080e7          	jalr	1468(ra) # 800023f0 <plicinit>
    80001e3c:	00000097          	auipc	ra,0x0
    80001e40:	5dc080e7          	jalr	1500(ra) # 80002418 <plicinithart>
    80001e44:	00000097          	auipc	ra,0x0
    80001e48:	078080e7          	jalr	120(ra) # 80001ebc <userinit>
    80001e4c:	0ff0000f          	fence
    80001e50:	00100793          	li	a5,1
    80001e54:	00002517          	auipc	a0,0x2
    80001e58:	1e450513          	addi	a0,a0,484 # 80004038 <CONSOLE_STATUS+0x20>
    80001e5c:	00f4a023          	sw	a5,0(s1)
    80001e60:	00001097          	auipc	ra,0x1
    80001e64:	a48080e7          	jalr	-1464(ra) # 800028a8 <__printf>
    80001e68:	0000006f          	j	80001e68 <system_main+0xd4>

0000000080001e6c <cpuid>:
    80001e6c:	ff010113          	addi	sp,sp,-16
    80001e70:	00813423          	sd	s0,8(sp)
    80001e74:	01010413          	addi	s0,sp,16
    80001e78:	00020513          	mv	a0,tp
    80001e7c:	00813403          	ld	s0,8(sp)
    80001e80:	0005051b          	sext.w	a0,a0
    80001e84:	01010113          	addi	sp,sp,16
    80001e88:	00008067          	ret

0000000080001e8c <mycpu>:
    80001e8c:	ff010113          	addi	sp,sp,-16
    80001e90:	00813423          	sd	s0,8(sp)
    80001e94:	01010413          	addi	s0,sp,16
    80001e98:	00020793          	mv	a5,tp
    80001e9c:	00813403          	ld	s0,8(sp)
    80001ea0:	0007879b          	sext.w	a5,a5
    80001ea4:	00779793          	slli	a5,a5,0x7
    80001ea8:	00005517          	auipc	a0,0x5
    80001eac:	90850513          	addi	a0,a0,-1784 # 800067b0 <cpus>
    80001eb0:	00f50533          	add	a0,a0,a5
    80001eb4:	01010113          	addi	sp,sp,16
    80001eb8:	00008067          	ret

0000000080001ebc <userinit>:
    80001ebc:	ff010113          	addi	sp,sp,-16
    80001ec0:	00813423          	sd	s0,8(sp)
    80001ec4:	01010413          	addi	s0,sp,16
    80001ec8:	00813403          	ld	s0,8(sp)
    80001ecc:	01010113          	addi	sp,sp,16
    80001ed0:	00000317          	auipc	t1,0x0
    80001ed4:	c0430067          	jr	-1020(t1) # 80001ad4 <main>

0000000080001ed8 <either_copyout>:
    80001ed8:	ff010113          	addi	sp,sp,-16
    80001edc:	00813023          	sd	s0,0(sp)
    80001ee0:	00113423          	sd	ra,8(sp)
    80001ee4:	01010413          	addi	s0,sp,16
    80001ee8:	02051663          	bnez	a0,80001f14 <either_copyout+0x3c>
    80001eec:	00058513          	mv	a0,a1
    80001ef0:	00060593          	mv	a1,a2
    80001ef4:	0006861b          	sext.w	a2,a3
    80001ef8:	00002097          	auipc	ra,0x2
    80001efc:	c5c080e7          	jalr	-932(ra) # 80003b54 <__memmove>
    80001f00:	00813083          	ld	ra,8(sp)
    80001f04:	00013403          	ld	s0,0(sp)
    80001f08:	00000513          	li	a0,0
    80001f0c:	01010113          	addi	sp,sp,16
    80001f10:	00008067          	ret
    80001f14:	00002517          	auipc	a0,0x2
    80001f18:	16450513          	addi	a0,a0,356 # 80004078 <CONSOLE_STATUS+0x60>
    80001f1c:	00001097          	auipc	ra,0x1
    80001f20:	930080e7          	jalr	-1744(ra) # 8000284c <panic>

0000000080001f24 <either_copyin>:
    80001f24:	ff010113          	addi	sp,sp,-16
    80001f28:	00813023          	sd	s0,0(sp)
    80001f2c:	00113423          	sd	ra,8(sp)
    80001f30:	01010413          	addi	s0,sp,16
    80001f34:	02059463          	bnez	a1,80001f5c <either_copyin+0x38>
    80001f38:	00060593          	mv	a1,a2
    80001f3c:	0006861b          	sext.w	a2,a3
    80001f40:	00002097          	auipc	ra,0x2
    80001f44:	c14080e7          	jalr	-1004(ra) # 80003b54 <__memmove>
    80001f48:	00813083          	ld	ra,8(sp)
    80001f4c:	00013403          	ld	s0,0(sp)
    80001f50:	00000513          	li	a0,0
    80001f54:	01010113          	addi	sp,sp,16
    80001f58:	00008067          	ret
    80001f5c:	00002517          	auipc	a0,0x2
    80001f60:	14450513          	addi	a0,a0,324 # 800040a0 <CONSOLE_STATUS+0x88>
    80001f64:	00001097          	auipc	ra,0x1
    80001f68:	8e8080e7          	jalr	-1816(ra) # 8000284c <panic>

0000000080001f6c <trapinit>:
    80001f6c:	ff010113          	addi	sp,sp,-16
    80001f70:	00813423          	sd	s0,8(sp)
    80001f74:	01010413          	addi	s0,sp,16
    80001f78:	00813403          	ld	s0,8(sp)
    80001f7c:	00002597          	auipc	a1,0x2
    80001f80:	14c58593          	addi	a1,a1,332 # 800040c8 <CONSOLE_STATUS+0xb0>
    80001f84:	00005517          	auipc	a0,0x5
    80001f88:	8ac50513          	addi	a0,a0,-1876 # 80006830 <tickslock>
    80001f8c:	01010113          	addi	sp,sp,16
    80001f90:	00001317          	auipc	t1,0x1
    80001f94:	5c830067          	jr	1480(t1) # 80003558 <initlock>

0000000080001f98 <trapinithart>:
    80001f98:	ff010113          	addi	sp,sp,-16
    80001f9c:	00813423          	sd	s0,8(sp)
    80001fa0:	01010413          	addi	s0,sp,16
    80001fa4:	00000797          	auipc	a5,0x0
    80001fa8:	2fc78793          	addi	a5,a5,764 # 800022a0 <kernelvec>
    80001fac:	10579073          	csrw	stvec,a5
    80001fb0:	00813403          	ld	s0,8(sp)
    80001fb4:	01010113          	addi	sp,sp,16
    80001fb8:	00008067          	ret

0000000080001fbc <usertrap>:
    80001fbc:	ff010113          	addi	sp,sp,-16
    80001fc0:	00813423          	sd	s0,8(sp)
    80001fc4:	01010413          	addi	s0,sp,16
    80001fc8:	00813403          	ld	s0,8(sp)
    80001fcc:	01010113          	addi	sp,sp,16
    80001fd0:	00008067          	ret

0000000080001fd4 <usertrapret>:
    80001fd4:	ff010113          	addi	sp,sp,-16
    80001fd8:	00813423          	sd	s0,8(sp)
    80001fdc:	01010413          	addi	s0,sp,16
    80001fe0:	00813403          	ld	s0,8(sp)
    80001fe4:	01010113          	addi	sp,sp,16
    80001fe8:	00008067          	ret

0000000080001fec <kerneltrap>:
    80001fec:	fe010113          	addi	sp,sp,-32
    80001ff0:	00813823          	sd	s0,16(sp)
    80001ff4:	00113c23          	sd	ra,24(sp)
    80001ff8:	00913423          	sd	s1,8(sp)
    80001ffc:	02010413          	addi	s0,sp,32
    80002000:	142025f3          	csrr	a1,scause
    80002004:	100027f3          	csrr	a5,sstatus
    80002008:	0027f793          	andi	a5,a5,2
    8000200c:	10079c63          	bnez	a5,80002124 <kerneltrap+0x138>
    80002010:	142027f3          	csrr	a5,scause
    80002014:	0207ce63          	bltz	a5,80002050 <kerneltrap+0x64>
    80002018:	00002517          	auipc	a0,0x2
    8000201c:	0f850513          	addi	a0,a0,248 # 80004110 <CONSOLE_STATUS+0xf8>
    80002020:	00001097          	auipc	ra,0x1
    80002024:	888080e7          	jalr	-1912(ra) # 800028a8 <__printf>
    80002028:	141025f3          	csrr	a1,sepc
    8000202c:	14302673          	csrr	a2,stval
    80002030:	00002517          	auipc	a0,0x2
    80002034:	0f050513          	addi	a0,a0,240 # 80004120 <CONSOLE_STATUS+0x108>
    80002038:	00001097          	auipc	ra,0x1
    8000203c:	870080e7          	jalr	-1936(ra) # 800028a8 <__printf>
    80002040:	00002517          	auipc	a0,0x2
    80002044:	0f850513          	addi	a0,a0,248 # 80004138 <CONSOLE_STATUS+0x120>
    80002048:	00001097          	auipc	ra,0x1
    8000204c:	804080e7          	jalr	-2044(ra) # 8000284c <panic>
    80002050:	0ff7f713          	andi	a4,a5,255
    80002054:	00900693          	li	a3,9
    80002058:	04d70063          	beq	a4,a3,80002098 <kerneltrap+0xac>
    8000205c:	fff00713          	li	a4,-1
    80002060:	03f71713          	slli	a4,a4,0x3f
    80002064:	00170713          	addi	a4,a4,1
    80002068:	fae798e3          	bne	a5,a4,80002018 <kerneltrap+0x2c>
    8000206c:	00000097          	auipc	ra,0x0
    80002070:	e00080e7          	jalr	-512(ra) # 80001e6c <cpuid>
    80002074:	06050663          	beqz	a0,800020e0 <kerneltrap+0xf4>
    80002078:	144027f3          	csrr	a5,sip
    8000207c:	ffd7f793          	andi	a5,a5,-3
    80002080:	14479073          	csrw	sip,a5
    80002084:	01813083          	ld	ra,24(sp)
    80002088:	01013403          	ld	s0,16(sp)
    8000208c:	00813483          	ld	s1,8(sp)
    80002090:	02010113          	addi	sp,sp,32
    80002094:	00008067          	ret
    80002098:	00000097          	auipc	ra,0x0
    8000209c:	3cc080e7          	jalr	972(ra) # 80002464 <plic_claim>
    800020a0:	00a00793          	li	a5,10
    800020a4:	00050493          	mv	s1,a0
    800020a8:	06f50863          	beq	a0,a5,80002118 <kerneltrap+0x12c>
    800020ac:	fc050ce3          	beqz	a0,80002084 <kerneltrap+0x98>
    800020b0:	00050593          	mv	a1,a0
    800020b4:	00002517          	auipc	a0,0x2
    800020b8:	03c50513          	addi	a0,a0,60 # 800040f0 <CONSOLE_STATUS+0xd8>
    800020bc:	00000097          	auipc	ra,0x0
    800020c0:	7ec080e7          	jalr	2028(ra) # 800028a8 <__printf>
    800020c4:	01013403          	ld	s0,16(sp)
    800020c8:	01813083          	ld	ra,24(sp)
    800020cc:	00048513          	mv	a0,s1
    800020d0:	00813483          	ld	s1,8(sp)
    800020d4:	02010113          	addi	sp,sp,32
    800020d8:	00000317          	auipc	t1,0x0
    800020dc:	3c430067          	jr	964(t1) # 8000249c <plic_complete>
    800020e0:	00004517          	auipc	a0,0x4
    800020e4:	75050513          	addi	a0,a0,1872 # 80006830 <tickslock>
    800020e8:	00001097          	auipc	ra,0x1
    800020ec:	494080e7          	jalr	1172(ra) # 8000357c <acquire>
    800020f0:	00002717          	auipc	a4,0x2
    800020f4:	25870713          	addi	a4,a4,600 # 80004348 <ticks>
    800020f8:	00072783          	lw	a5,0(a4)
    800020fc:	00004517          	auipc	a0,0x4
    80002100:	73450513          	addi	a0,a0,1844 # 80006830 <tickslock>
    80002104:	0017879b          	addiw	a5,a5,1
    80002108:	00f72023          	sw	a5,0(a4)
    8000210c:	00001097          	auipc	ra,0x1
    80002110:	53c080e7          	jalr	1340(ra) # 80003648 <release>
    80002114:	f65ff06f          	j	80002078 <kerneltrap+0x8c>
    80002118:	00001097          	auipc	ra,0x1
    8000211c:	098080e7          	jalr	152(ra) # 800031b0 <uartintr>
    80002120:	fa5ff06f          	j	800020c4 <kerneltrap+0xd8>
    80002124:	00002517          	auipc	a0,0x2
    80002128:	fac50513          	addi	a0,a0,-84 # 800040d0 <CONSOLE_STATUS+0xb8>
    8000212c:	00000097          	auipc	ra,0x0
    80002130:	720080e7          	jalr	1824(ra) # 8000284c <panic>

0000000080002134 <clockintr>:
    80002134:	fe010113          	addi	sp,sp,-32
    80002138:	00813823          	sd	s0,16(sp)
    8000213c:	00913423          	sd	s1,8(sp)
    80002140:	00113c23          	sd	ra,24(sp)
    80002144:	02010413          	addi	s0,sp,32
    80002148:	00004497          	auipc	s1,0x4
    8000214c:	6e848493          	addi	s1,s1,1768 # 80006830 <tickslock>
    80002150:	00048513          	mv	a0,s1
    80002154:	00001097          	auipc	ra,0x1
    80002158:	428080e7          	jalr	1064(ra) # 8000357c <acquire>
    8000215c:	00002717          	auipc	a4,0x2
    80002160:	1ec70713          	addi	a4,a4,492 # 80004348 <ticks>
    80002164:	00072783          	lw	a5,0(a4)
    80002168:	01013403          	ld	s0,16(sp)
    8000216c:	01813083          	ld	ra,24(sp)
    80002170:	00048513          	mv	a0,s1
    80002174:	0017879b          	addiw	a5,a5,1
    80002178:	00813483          	ld	s1,8(sp)
    8000217c:	00f72023          	sw	a5,0(a4)
    80002180:	02010113          	addi	sp,sp,32
    80002184:	00001317          	auipc	t1,0x1
    80002188:	4c430067          	jr	1220(t1) # 80003648 <release>

000000008000218c <devintr>:
    8000218c:	142027f3          	csrr	a5,scause
    80002190:	00000513          	li	a0,0
    80002194:	0007c463          	bltz	a5,8000219c <devintr+0x10>
    80002198:	00008067          	ret
    8000219c:	fe010113          	addi	sp,sp,-32
    800021a0:	00813823          	sd	s0,16(sp)
    800021a4:	00113c23          	sd	ra,24(sp)
    800021a8:	00913423          	sd	s1,8(sp)
    800021ac:	02010413          	addi	s0,sp,32
    800021b0:	0ff7f713          	andi	a4,a5,255
    800021b4:	00900693          	li	a3,9
    800021b8:	04d70c63          	beq	a4,a3,80002210 <devintr+0x84>
    800021bc:	fff00713          	li	a4,-1
    800021c0:	03f71713          	slli	a4,a4,0x3f
    800021c4:	00170713          	addi	a4,a4,1
    800021c8:	00e78c63          	beq	a5,a4,800021e0 <devintr+0x54>
    800021cc:	01813083          	ld	ra,24(sp)
    800021d0:	01013403          	ld	s0,16(sp)
    800021d4:	00813483          	ld	s1,8(sp)
    800021d8:	02010113          	addi	sp,sp,32
    800021dc:	00008067          	ret
    800021e0:	00000097          	auipc	ra,0x0
    800021e4:	c8c080e7          	jalr	-884(ra) # 80001e6c <cpuid>
    800021e8:	06050663          	beqz	a0,80002254 <devintr+0xc8>
    800021ec:	144027f3          	csrr	a5,sip
    800021f0:	ffd7f793          	andi	a5,a5,-3
    800021f4:	14479073          	csrw	sip,a5
    800021f8:	01813083          	ld	ra,24(sp)
    800021fc:	01013403          	ld	s0,16(sp)
    80002200:	00813483          	ld	s1,8(sp)
    80002204:	00200513          	li	a0,2
    80002208:	02010113          	addi	sp,sp,32
    8000220c:	00008067          	ret
    80002210:	00000097          	auipc	ra,0x0
    80002214:	254080e7          	jalr	596(ra) # 80002464 <plic_claim>
    80002218:	00a00793          	li	a5,10
    8000221c:	00050493          	mv	s1,a0
    80002220:	06f50663          	beq	a0,a5,8000228c <devintr+0x100>
    80002224:	00100513          	li	a0,1
    80002228:	fa0482e3          	beqz	s1,800021cc <devintr+0x40>
    8000222c:	00048593          	mv	a1,s1
    80002230:	00002517          	auipc	a0,0x2
    80002234:	ec050513          	addi	a0,a0,-320 # 800040f0 <CONSOLE_STATUS+0xd8>
    80002238:	00000097          	auipc	ra,0x0
    8000223c:	670080e7          	jalr	1648(ra) # 800028a8 <__printf>
    80002240:	00048513          	mv	a0,s1
    80002244:	00000097          	auipc	ra,0x0
    80002248:	258080e7          	jalr	600(ra) # 8000249c <plic_complete>
    8000224c:	00100513          	li	a0,1
    80002250:	f7dff06f          	j	800021cc <devintr+0x40>
    80002254:	00004517          	auipc	a0,0x4
    80002258:	5dc50513          	addi	a0,a0,1500 # 80006830 <tickslock>
    8000225c:	00001097          	auipc	ra,0x1
    80002260:	320080e7          	jalr	800(ra) # 8000357c <acquire>
    80002264:	00002717          	auipc	a4,0x2
    80002268:	0e470713          	addi	a4,a4,228 # 80004348 <ticks>
    8000226c:	00072783          	lw	a5,0(a4)
    80002270:	00004517          	auipc	a0,0x4
    80002274:	5c050513          	addi	a0,a0,1472 # 80006830 <tickslock>
    80002278:	0017879b          	addiw	a5,a5,1
    8000227c:	00f72023          	sw	a5,0(a4)
    80002280:	00001097          	auipc	ra,0x1
    80002284:	3c8080e7          	jalr	968(ra) # 80003648 <release>
    80002288:	f65ff06f          	j	800021ec <devintr+0x60>
    8000228c:	00001097          	auipc	ra,0x1
    80002290:	f24080e7          	jalr	-220(ra) # 800031b0 <uartintr>
    80002294:	fadff06f          	j	80002240 <devintr+0xb4>
	...

00000000800022a0 <kernelvec>:
    800022a0:	f0010113          	addi	sp,sp,-256
    800022a4:	00113023          	sd	ra,0(sp)
    800022a8:	00213423          	sd	sp,8(sp)
    800022ac:	00313823          	sd	gp,16(sp)
    800022b0:	00413c23          	sd	tp,24(sp)
    800022b4:	02513023          	sd	t0,32(sp)
    800022b8:	02613423          	sd	t1,40(sp)
    800022bc:	02713823          	sd	t2,48(sp)
    800022c0:	02813c23          	sd	s0,56(sp)
    800022c4:	04913023          	sd	s1,64(sp)
    800022c8:	04a13423          	sd	a0,72(sp)
    800022cc:	04b13823          	sd	a1,80(sp)
    800022d0:	04c13c23          	sd	a2,88(sp)
    800022d4:	06d13023          	sd	a3,96(sp)
    800022d8:	06e13423          	sd	a4,104(sp)
    800022dc:	06f13823          	sd	a5,112(sp)
    800022e0:	07013c23          	sd	a6,120(sp)
    800022e4:	09113023          	sd	a7,128(sp)
    800022e8:	09213423          	sd	s2,136(sp)
    800022ec:	09313823          	sd	s3,144(sp)
    800022f0:	09413c23          	sd	s4,152(sp)
    800022f4:	0b513023          	sd	s5,160(sp)
    800022f8:	0b613423          	sd	s6,168(sp)
    800022fc:	0b713823          	sd	s7,176(sp)
    80002300:	0b813c23          	sd	s8,184(sp)
    80002304:	0d913023          	sd	s9,192(sp)
    80002308:	0da13423          	sd	s10,200(sp)
    8000230c:	0db13823          	sd	s11,208(sp)
    80002310:	0dc13c23          	sd	t3,216(sp)
    80002314:	0fd13023          	sd	t4,224(sp)
    80002318:	0fe13423          	sd	t5,232(sp)
    8000231c:	0ff13823          	sd	t6,240(sp)
    80002320:	ccdff0ef          	jal	ra,80001fec <kerneltrap>
    80002324:	00013083          	ld	ra,0(sp)
    80002328:	00813103          	ld	sp,8(sp)
    8000232c:	01013183          	ld	gp,16(sp)
    80002330:	02013283          	ld	t0,32(sp)
    80002334:	02813303          	ld	t1,40(sp)
    80002338:	03013383          	ld	t2,48(sp)
    8000233c:	03813403          	ld	s0,56(sp)
    80002340:	04013483          	ld	s1,64(sp)
    80002344:	04813503          	ld	a0,72(sp)
    80002348:	05013583          	ld	a1,80(sp)
    8000234c:	05813603          	ld	a2,88(sp)
    80002350:	06013683          	ld	a3,96(sp)
    80002354:	06813703          	ld	a4,104(sp)
    80002358:	07013783          	ld	a5,112(sp)
    8000235c:	07813803          	ld	a6,120(sp)
    80002360:	08013883          	ld	a7,128(sp)
    80002364:	08813903          	ld	s2,136(sp)
    80002368:	09013983          	ld	s3,144(sp)
    8000236c:	09813a03          	ld	s4,152(sp)
    80002370:	0a013a83          	ld	s5,160(sp)
    80002374:	0a813b03          	ld	s6,168(sp)
    80002378:	0b013b83          	ld	s7,176(sp)
    8000237c:	0b813c03          	ld	s8,184(sp)
    80002380:	0c013c83          	ld	s9,192(sp)
    80002384:	0c813d03          	ld	s10,200(sp)
    80002388:	0d013d83          	ld	s11,208(sp)
    8000238c:	0d813e03          	ld	t3,216(sp)
    80002390:	0e013e83          	ld	t4,224(sp)
    80002394:	0e813f03          	ld	t5,232(sp)
    80002398:	0f013f83          	ld	t6,240(sp)
    8000239c:	10010113          	addi	sp,sp,256
    800023a0:	10200073          	sret
    800023a4:	00000013          	nop
    800023a8:	00000013          	nop
    800023ac:	00000013          	nop

00000000800023b0 <timervec>:
    800023b0:	34051573          	csrrw	a0,mscratch,a0
    800023b4:	00b53023          	sd	a1,0(a0)
    800023b8:	00c53423          	sd	a2,8(a0)
    800023bc:	00d53823          	sd	a3,16(a0)
    800023c0:	01853583          	ld	a1,24(a0)
    800023c4:	02053603          	ld	a2,32(a0)
    800023c8:	0005b683          	ld	a3,0(a1)
    800023cc:	00c686b3          	add	a3,a3,a2
    800023d0:	00d5b023          	sd	a3,0(a1)
    800023d4:	00200593          	li	a1,2
    800023d8:	14459073          	csrw	sip,a1
    800023dc:	01053683          	ld	a3,16(a0)
    800023e0:	00853603          	ld	a2,8(a0)
    800023e4:	00053583          	ld	a1,0(a0)
    800023e8:	34051573          	csrrw	a0,mscratch,a0
    800023ec:	30200073          	mret

00000000800023f0 <plicinit>:
    800023f0:	ff010113          	addi	sp,sp,-16
    800023f4:	00813423          	sd	s0,8(sp)
    800023f8:	01010413          	addi	s0,sp,16
    800023fc:	00813403          	ld	s0,8(sp)
    80002400:	0c0007b7          	lui	a5,0xc000
    80002404:	00100713          	li	a4,1
    80002408:	02e7a423          	sw	a4,40(a5) # c000028 <_entry-0x73ffffd8>
    8000240c:	00e7a223          	sw	a4,4(a5)
    80002410:	01010113          	addi	sp,sp,16
    80002414:	00008067          	ret

0000000080002418 <plicinithart>:
    80002418:	ff010113          	addi	sp,sp,-16
    8000241c:	00813023          	sd	s0,0(sp)
    80002420:	00113423          	sd	ra,8(sp)
    80002424:	01010413          	addi	s0,sp,16
    80002428:	00000097          	auipc	ra,0x0
    8000242c:	a44080e7          	jalr	-1468(ra) # 80001e6c <cpuid>
    80002430:	0085171b          	slliw	a4,a0,0x8
    80002434:	0c0027b7          	lui	a5,0xc002
    80002438:	00e787b3          	add	a5,a5,a4
    8000243c:	40200713          	li	a4,1026
    80002440:	08e7a023          	sw	a4,128(a5) # c002080 <_entry-0x73ffdf80>
    80002444:	00813083          	ld	ra,8(sp)
    80002448:	00013403          	ld	s0,0(sp)
    8000244c:	00d5151b          	slliw	a0,a0,0xd
    80002450:	0c2017b7          	lui	a5,0xc201
    80002454:	00a78533          	add	a0,a5,a0
    80002458:	00052023          	sw	zero,0(a0)
    8000245c:	01010113          	addi	sp,sp,16
    80002460:	00008067          	ret

0000000080002464 <plic_claim>:
    80002464:	ff010113          	addi	sp,sp,-16
    80002468:	00813023          	sd	s0,0(sp)
    8000246c:	00113423          	sd	ra,8(sp)
    80002470:	01010413          	addi	s0,sp,16
    80002474:	00000097          	auipc	ra,0x0
    80002478:	9f8080e7          	jalr	-1544(ra) # 80001e6c <cpuid>
    8000247c:	00813083          	ld	ra,8(sp)
    80002480:	00013403          	ld	s0,0(sp)
    80002484:	00d5151b          	slliw	a0,a0,0xd
    80002488:	0c2017b7          	lui	a5,0xc201
    8000248c:	00a78533          	add	a0,a5,a0
    80002490:	00452503          	lw	a0,4(a0)
    80002494:	01010113          	addi	sp,sp,16
    80002498:	00008067          	ret

000000008000249c <plic_complete>:
    8000249c:	fe010113          	addi	sp,sp,-32
    800024a0:	00813823          	sd	s0,16(sp)
    800024a4:	00913423          	sd	s1,8(sp)
    800024a8:	00113c23          	sd	ra,24(sp)
    800024ac:	02010413          	addi	s0,sp,32
    800024b0:	00050493          	mv	s1,a0
    800024b4:	00000097          	auipc	ra,0x0
    800024b8:	9b8080e7          	jalr	-1608(ra) # 80001e6c <cpuid>
    800024bc:	01813083          	ld	ra,24(sp)
    800024c0:	01013403          	ld	s0,16(sp)
    800024c4:	00d5179b          	slliw	a5,a0,0xd
    800024c8:	0c201737          	lui	a4,0xc201
    800024cc:	00f707b3          	add	a5,a4,a5
    800024d0:	0097a223          	sw	s1,4(a5) # c201004 <_entry-0x73dfeffc>
    800024d4:	00813483          	ld	s1,8(sp)
    800024d8:	02010113          	addi	sp,sp,32
    800024dc:	00008067          	ret

00000000800024e0 <consolewrite>:
    800024e0:	fb010113          	addi	sp,sp,-80
    800024e4:	04813023          	sd	s0,64(sp)
    800024e8:	04113423          	sd	ra,72(sp)
    800024ec:	02913c23          	sd	s1,56(sp)
    800024f0:	03213823          	sd	s2,48(sp)
    800024f4:	03313423          	sd	s3,40(sp)
    800024f8:	03413023          	sd	s4,32(sp)
    800024fc:	01513c23          	sd	s5,24(sp)
    80002500:	05010413          	addi	s0,sp,80
    80002504:	06c05c63          	blez	a2,8000257c <consolewrite+0x9c>
    80002508:	00060993          	mv	s3,a2
    8000250c:	00050a13          	mv	s4,a0
    80002510:	00058493          	mv	s1,a1
    80002514:	00000913          	li	s2,0
    80002518:	fff00a93          	li	s5,-1
    8000251c:	01c0006f          	j	80002538 <consolewrite+0x58>
    80002520:	fbf44503          	lbu	a0,-65(s0)
    80002524:	0019091b          	addiw	s2,s2,1
    80002528:	00148493          	addi	s1,s1,1
    8000252c:	00001097          	auipc	ra,0x1
    80002530:	a9c080e7          	jalr	-1380(ra) # 80002fc8 <uartputc>
    80002534:	03298063          	beq	s3,s2,80002554 <consolewrite+0x74>
    80002538:	00048613          	mv	a2,s1
    8000253c:	00100693          	li	a3,1
    80002540:	000a0593          	mv	a1,s4
    80002544:	fbf40513          	addi	a0,s0,-65
    80002548:	00000097          	auipc	ra,0x0
    8000254c:	9dc080e7          	jalr	-1572(ra) # 80001f24 <either_copyin>
    80002550:	fd5518e3          	bne	a0,s5,80002520 <consolewrite+0x40>
    80002554:	04813083          	ld	ra,72(sp)
    80002558:	04013403          	ld	s0,64(sp)
    8000255c:	03813483          	ld	s1,56(sp)
    80002560:	02813983          	ld	s3,40(sp)
    80002564:	02013a03          	ld	s4,32(sp)
    80002568:	01813a83          	ld	s5,24(sp)
    8000256c:	00090513          	mv	a0,s2
    80002570:	03013903          	ld	s2,48(sp)
    80002574:	05010113          	addi	sp,sp,80
    80002578:	00008067          	ret
    8000257c:	00000913          	li	s2,0
    80002580:	fd5ff06f          	j	80002554 <consolewrite+0x74>

0000000080002584 <consoleread>:
    80002584:	f9010113          	addi	sp,sp,-112
    80002588:	06813023          	sd	s0,96(sp)
    8000258c:	04913c23          	sd	s1,88(sp)
    80002590:	05213823          	sd	s2,80(sp)
    80002594:	05313423          	sd	s3,72(sp)
    80002598:	05413023          	sd	s4,64(sp)
    8000259c:	03513c23          	sd	s5,56(sp)
    800025a0:	03613823          	sd	s6,48(sp)
    800025a4:	03713423          	sd	s7,40(sp)
    800025a8:	03813023          	sd	s8,32(sp)
    800025ac:	06113423          	sd	ra,104(sp)
    800025b0:	01913c23          	sd	s9,24(sp)
    800025b4:	07010413          	addi	s0,sp,112
    800025b8:	00060b93          	mv	s7,a2
    800025bc:	00050913          	mv	s2,a0
    800025c0:	00058c13          	mv	s8,a1
    800025c4:	00060b1b          	sext.w	s6,a2
    800025c8:	00004497          	auipc	s1,0x4
    800025cc:	28048493          	addi	s1,s1,640 # 80006848 <cons>
    800025d0:	00400993          	li	s3,4
    800025d4:	fff00a13          	li	s4,-1
    800025d8:	00a00a93          	li	s5,10
    800025dc:	05705e63          	blez	s7,80002638 <consoleread+0xb4>
    800025e0:	09c4a703          	lw	a4,156(s1)
    800025e4:	0984a783          	lw	a5,152(s1)
    800025e8:	0007071b          	sext.w	a4,a4
    800025ec:	08e78463          	beq	a5,a4,80002674 <consoleread+0xf0>
    800025f0:	07f7f713          	andi	a4,a5,127
    800025f4:	00e48733          	add	a4,s1,a4
    800025f8:	01874703          	lbu	a4,24(a4) # c201018 <_entry-0x73dfefe8>
    800025fc:	0017869b          	addiw	a3,a5,1
    80002600:	08d4ac23          	sw	a3,152(s1)
    80002604:	00070c9b          	sext.w	s9,a4
    80002608:	0b370663          	beq	a4,s3,800026b4 <consoleread+0x130>
    8000260c:	00100693          	li	a3,1
    80002610:	f9f40613          	addi	a2,s0,-97
    80002614:	000c0593          	mv	a1,s8
    80002618:	00090513          	mv	a0,s2
    8000261c:	f8e40fa3          	sb	a4,-97(s0)
    80002620:	00000097          	auipc	ra,0x0
    80002624:	8b8080e7          	jalr	-1864(ra) # 80001ed8 <either_copyout>
    80002628:	01450863          	beq	a0,s4,80002638 <consoleread+0xb4>
    8000262c:	001c0c13          	addi	s8,s8,1
    80002630:	fffb8b9b          	addiw	s7,s7,-1
    80002634:	fb5c94e3          	bne	s9,s5,800025dc <consoleread+0x58>
    80002638:	000b851b          	sext.w	a0,s7
    8000263c:	06813083          	ld	ra,104(sp)
    80002640:	06013403          	ld	s0,96(sp)
    80002644:	05813483          	ld	s1,88(sp)
    80002648:	05013903          	ld	s2,80(sp)
    8000264c:	04813983          	ld	s3,72(sp)
    80002650:	04013a03          	ld	s4,64(sp)
    80002654:	03813a83          	ld	s5,56(sp)
    80002658:	02813b83          	ld	s7,40(sp)
    8000265c:	02013c03          	ld	s8,32(sp)
    80002660:	01813c83          	ld	s9,24(sp)
    80002664:	40ab053b          	subw	a0,s6,a0
    80002668:	03013b03          	ld	s6,48(sp)
    8000266c:	07010113          	addi	sp,sp,112
    80002670:	00008067          	ret
    80002674:	00001097          	auipc	ra,0x1
    80002678:	1d8080e7          	jalr	472(ra) # 8000384c <push_on>
    8000267c:	0984a703          	lw	a4,152(s1)
    80002680:	09c4a783          	lw	a5,156(s1)
    80002684:	0007879b          	sext.w	a5,a5
    80002688:	fef70ce3          	beq	a4,a5,80002680 <consoleread+0xfc>
    8000268c:	00001097          	auipc	ra,0x1
    80002690:	234080e7          	jalr	564(ra) # 800038c0 <pop_on>
    80002694:	0984a783          	lw	a5,152(s1)
    80002698:	07f7f713          	andi	a4,a5,127
    8000269c:	00e48733          	add	a4,s1,a4
    800026a0:	01874703          	lbu	a4,24(a4)
    800026a4:	0017869b          	addiw	a3,a5,1
    800026a8:	08d4ac23          	sw	a3,152(s1)
    800026ac:	00070c9b          	sext.w	s9,a4
    800026b0:	f5371ee3          	bne	a4,s3,8000260c <consoleread+0x88>
    800026b4:	000b851b          	sext.w	a0,s7
    800026b8:	f96bf2e3          	bgeu	s7,s6,8000263c <consoleread+0xb8>
    800026bc:	08f4ac23          	sw	a5,152(s1)
    800026c0:	f7dff06f          	j	8000263c <consoleread+0xb8>

00000000800026c4 <consputc>:
    800026c4:	10000793          	li	a5,256
    800026c8:	00f50663          	beq	a0,a5,800026d4 <consputc+0x10>
    800026cc:	00001317          	auipc	t1,0x1
    800026d0:	9f430067          	jr	-1548(t1) # 800030c0 <uartputc_sync>
    800026d4:	ff010113          	addi	sp,sp,-16
    800026d8:	00113423          	sd	ra,8(sp)
    800026dc:	00813023          	sd	s0,0(sp)
    800026e0:	01010413          	addi	s0,sp,16
    800026e4:	00800513          	li	a0,8
    800026e8:	00001097          	auipc	ra,0x1
    800026ec:	9d8080e7          	jalr	-1576(ra) # 800030c0 <uartputc_sync>
    800026f0:	02000513          	li	a0,32
    800026f4:	00001097          	auipc	ra,0x1
    800026f8:	9cc080e7          	jalr	-1588(ra) # 800030c0 <uartputc_sync>
    800026fc:	00013403          	ld	s0,0(sp)
    80002700:	00813083          	ld	ra,8(sp)
    80002704:	00800513          	li	a0,8
    80002708:	01010113          	addi	sp,sp,16
    8000270c:	00001317          	auipc	t1,0x1
    80002710:	9b430067          	jr	-1612(t1) # 800030c0 <uartputc_sync>

0000000080002714 <consoleintr>:
    80002714:	fe010113          	addi	sp,sp,-32
    80002718:	00813823          	sd	s0,16(sp)
    8000271c:	00913423          	sd	s1,8(sp)
    80002720:	01213023          	sd	s2,0(sp)
    80002724:	00113c23          	sd	ra,24(sp)
    80002728:	02010413          	addi	s0,sp,32
    8000272c:	00004917          	auipc	s2,0x4
    80002730:	11c90913          	addi	s2,s2,284 # 80006848 <cons>
    80002734:	00050493          	mv	s1,a0
    80002738:	00090513          	mv	a0,s2
    8000273c:	00001097          	auipc	ra,0x1
    80002740:	e40080e7          	jalr	-448(ra) # 8000357c <acquire>
    80002744:	02048c63          	beqz	s1,8000277c <consoleintr+0x68>
    80002748:	0a092783          	lw	a5,160(s2)
    8000274c:	09892703          	lw	a4,152(s2)
    80002750:	07f00693          	li	a3,127
    80002754:	40e7873b          	subw	a4,a5,a4
    80002758:	02e6e263          	bltu	a3,a4,8000277c <consoleintr+0x68>
    8000275c:	00d00713          	li	a4,13
    80002760:	04e48063          	beq	s1,a4,800027a0 <consoleintr+0x8c>
    80002764:	07f7f713          	andi	a4,a5,127
    80002768:	00e90733          	add	a4,s2,a4
    8000276c:	0017879b          	addiw	a5,a5,1
    80002770:	0af92023          	sw	a5,160(s2)
    80002774:	00970c23          	sb	s1,24(a4)
    80002778:	08f92e23          	sw	a5,156(s2)
    8000277c:	01013403          	ld	s0,16(sp)
    80002780:	01813083          	ld	ra,24(sp)
    80002784:	00813483          	ld	s1,8(sp)
    80002788:	00013903          	ld	s2,0(sp)
    8000278c:	00004517          	auipc	a0,0x4
    80002790:	0bc50513          	addi	a0,a0,188 # 80006848 <cons>
    80002794:	02010113          	addi	sp,sp,32
    80002798:	00001317          	auipc	t1,0x1
    8000279c:	eb030067          	jr	-336(t1) # 80003648 <release>
    800027a0:	00a00493          	li	s1,10
    800027a4:	fc1ff06f          	j	80002764 <consoleintr+0x50>

00000000800027a8 <consoleinit>:
    800027a8:	fe010113          	addi	sp,sp,-32
    800027ac:	00113c23          	sd	ra,24(sp)
    800027b0:	00813823          	sd	s0,16(sp)
    800027b4:	00913423          	sd	s1,8(sp)
    800027b8:	02010413          	addi	s0,sp,32
    800027bc:	00004497          	auipc	s1,0x4
    800027c0:	08c48493          	addi	s1,s1,140 # 80006848 <cons>
    800027c4:	00048513          	mv	a0,s1
    800027c8:	00002597          	auipc	a1,0x2
    800027cc:	98058593          	addi	a1,a1,-1664 # 80004148 <CONSOLE_STATUS+0x130>
    800027d0:	00001097          	auipc	ra,0x1
    800027d4:	d88080e7          	jalr	-632(ra) # 80003558 <initlock>
    800027d8:	00000097          	auipc	ra,0x0
    800027dc:	7ac080e7          	jalr	1964(ra) # 80002f84 <uartinit>
    800027e0:	01813083          	ld	ra,24(sp)
    800027e4:	01013403          	ld	s0,16(sp)
    800027e8:	00000797          	auipc	a5,0x0
    800027ec:	d9c78793          	addi	a5,a5,-612 # 80002584 <consoleread>
    800027f0:	0af4bc23          	sd	a5,184(s1)
    800027f4:	00000797          	auipc	a5,0x0
    800027f8:	cec78793          	addi	a5,a5,-788 # 800024e0 <consolewrite>
    800027fc:	0cf4b023          	sd	a5,192(s1)
    80002800:	00813483          	ld	s1,8(sp)
    80002804:	02010113          	addi	sp,sp,32
    80002808:	00008067          	ret

000000008000280c <console_read>:
    8000280c:	ff010113          	addi	sp,sp,-16
    80002810:	00813423          	sd	s0,8(sp)
    80002814:	01010413          	addi	s0,sp,16
    80002818:	00813403          	ld	s0,8(sp)
    8000281c:	00004317          	auipc	t1,0x4
    80002820:	0e433303          	ld	t1,228(t1) # 80006900 <devsw+0x10>
    80002824:	01010113          	addi	sp,sp,16
    80002828:	00030067          	jr	t1

000000008000282c <console_write>:
    8000282c:	ff010113          	addi	sp,sp,-16
    80002830:	00813423          	sd	s0,8(sp)
    80002834:	01010413          	addi	s0,sp,16
    80002838:	00813403          	ld	s0,8(sp)
    8000283c:	00004317          	auipc	t1,0x4
    80002840:	0cc33303          	ld	t1,204(t1) # 80006908 <devsw+0x18>
    80002844:	01010113          	addi	sp,sp,16
    80002848:	00030067          	jr	t1

000000008000284c <panic>:
    8000284c:	fe010113          	addi	sp,sp,-32
    80002850:	00113c23          	sd	ra,24(sp)
    80002854:	00813823          	sd	s0,16(sp)
    80002858:	00913423          	sd	s1,8(sp)
    8000285c:	02010413          	addi	s0,sp,32
    80002860:	00050493          	mv	s1,a0
    80002864:	00002517          	auipc	a0,0x2
    80002868:	8ec50513          	addi	a0,a0,-1812 # 80004150 <CONSOLE_STATUS+0x138>
    8000286c:	00004797          	auipc	a5,0x4
    80002870:	1207ae23          	sw	zero,316(a5) # 800069a8 <pr+0x18>
    80002874:	00000097          	auipc	ra,0x0
    80002878:	034080e7          	jalr	52(ra) # 800028a8 <__printf>
    8000287c:	00048513          	mv	a0,s1
    80002880:	00000097          	auipc	ra,0x0
    80002884:	028080e7          	jalr	40(ra) # 800028a8 <__printf>
    80002888:	00002517          	auipc	a0,0x2
    8000288c:	8a850513          	addi	a0,a0,-1880 # 80004130 <CONSOLE_STATUS+0x118>
    80002890:	00000097          	auipc	ra,0x0
    80002894:	018080e7          	jalr	24(ra) # 800028a8 <__printf>
    80002898:	00100793          	li	a5,1
    8000289c:	00002717          	auipc	a4,0x2
    800028a0:	aaf72823          	sw	a5,-1360(a4) # 8000434c <panicked>
    800028a4:	0000006f          	j	800028a4 <panic+0x58>

00000000800028a8 <__printf>:
    800028a8:	f3010113          	addi	sp,sp,-208
    800028ac:	08813023          	sd	s0,128(sp)
    800028b0:	07313423          	sd	s3,104(sp)
    800028b4:	09010413          	addi	s0,sp,144
    800028b8:	05813023          	sd	s8,64(sp)
    800028bc:	08113423          	sd	ra,136(sp)
    800028c0:	06913c23          	sd	s1,120(sp)
    800028c4:	07213823          	sd	s2,112(sp)
    800028c8:	07413023          	sd	s4,96(sp)
    800028cc:	05513c23          	sd	s5,88(sp)
    800028d0:	05613823          	sd	s6,80(sp)
    800028d4:	05713423          	sd	s7,72(sp)
    800028d8:	03913c23          	sd	s9,56(sp)
    800028dc:	03a13823          	sd	s10,48(sp)
    800028e0:	03b13423          	sd	s11,40(sp)
    800028e4:	00004317          	auipc	t1,0x4
    800028e8:	0ac30313          	addi	t1,t1,172 # 80006990 <pr>
    800028ec:	01832c03          	lw	s8,24(t1)
    800028f0:	00b43423          	sd	a1,8(s0)
    800028f4:	00c43823          	sd	a2,16(s0)
    800028f8:	00d43c23          	sd	a3,24(s0)
    800028fc:	02e43023          	sd	a4,32(s0)
    80002900:	02f43423          	sd	a5,40(s0)
    80002904:	03043823          	sd	a6,48(s0)
    80002908:	03143c23          	sd	a7,56(s0)
    8000290c:	00050993          	mv	s3,a0
    80002910:	4a0c1663          	bnez	s8,80002dbc <__printf+0x514>
    80002914:	60098c63          	beqz	s3,80002f2c <__printf+0x684>
    80002918:	0009c503          	lbu	a0,0(s3)
    8000291c:	00840793          	addi	a5,s0,8
    80002920:	f6f43c23          	sd	a5,-136(s0)
    80002924:	00000493          	li	s1,0
    80002928:	22050063          	beqz	a0,80002b48 <__printf+0x2a0>
    8000292c:	00002a37          	lui	s4,0x2
    80002930:	00018ab7          	lui	s5,0x18
    80002934:	000f4b37          	lui	s6,0xf4
    80002938:	00989bb7          	lui	s7,0x989
    8000293c:	70fa0a13          	addi	s4,s4,1807 # 270f <_entry-0x7fffd8f1>
    80002940:	69fa8a93          	addi	s5,s5,1695 # 1869f <_entry-0x7ffe7961>
    80002944:	23fb0b13          	addi	s6,s6,575 # f423f <_entry-0x7ff0bdc1>
    80002948:	67fb8b93          	addi	s7,s7,1663 # 98967f <_entry-0x7f676981>
    8000294c:	00148c9b          	addiw	s9,s1,1
    80002950:	02500793          	li	a5,37
    80002954:	01998933          	add	s2,s3,s9
    80002958:	38f51263          	bne	a0,a5,80002cdc <__printf+0x434>
    8000295c:	00094783          	lbu	a5,0(s2)
    80002960:	00078c9b          	sext.w	s9,a5
    80002964:	1e078263          	beqz	a5,80002b48 <__printf+0x2a0>
    80002968:	0024849b          	addiw	s1,s1,2
    8000296c:	07000713          	li	a4,112
    80002970:	00998933          	add	s2,s3,s1
    80002974:	38e78a63          	beq	a5,a4,80002d08 <__printf+0x460>
    80002978:	20f76863          	bltu	a4,a5,80002b88 <__printf+0x2e0>
    8000297c:	42a78863          	beq	a5,a0,80002dac <__printf+0x504>
    80002980:	06400713          	li	a4,100
    80002984:	40e79663          	bne	a5,a4,80002d90 <__printf+0x4e8>
    80002988:	f7843783          	ld	a5,-136(s0)
    8000298c:	0007a603          	lw	a2,0(a5)
    80002990:	00878793          	addi	a5,a5,8
    80002994:	f6f43c23          	sd	a5,-136(s0)
    80002998:	42064a63          	bltz	a2,80002dcc <__printf+0x524>
    8000299c:	00a00713          	li	a4,10
    800029a0:	02e677bb          	remuw	a5,a2,a4
    800029a4:	00001d97          	auipc	s11,0x1
    800029a8:	7d4d8d93          	addi	s11,s11,2004 # 80004178 <digits>
    800029ac:	00900593          	li	a1,9
    800029b0:	0006051b          	sext.w	a0,a2
    800029b4:	00000c93          	li	s9,0
    800029b8:	02079793          	slli	a5,a5,0x20
    800029bc:	0207d793          	srli	a5,a5,0x20
    800029c0:	00fd87b3          	add	a5,s11,a5
    800029c4:	0007c783          	lbu	a5,0(a5)
    800029c8:	02e656bb          	divuw	a3,a2,a4
    800029cc:	f8f40023          	sb	a5,-128(s0)
    800029d0:	14c5d863          	bge	a1,a2,80002b20 <__printf+0x278>
    800029d4:	06300593          	li	a1,99
    800029d8:	00100c93          	li	s9,1
    800029dc:	02e6f7bb          	remuw	a5,a3,a4
    800029e0:	02079793          	slli	a5,a5,0x20
    800029e4:	0207d793          	srli	a5,a5,0x20
    800029e8:	00fd87b3          	add	a5,s11,a5
    800029ec:	0007c783          	lbu	a5,0(a5)
    800029f0:	02e6d73b          	divuw	a4,a3,a4
    800029f4:	f8f400a3          	sb	a5,-127(s0)
    800029f8:	12a5f463          	bgeu	a1,a0,80002b20 <__printf+0x278>
    800029fc:	00a00693          	li	a3,10
    80002a00:	00900593          	li	a1,9
    80002a04:	02d777bb          	remuw	a5,a4,a3
    80002a08:	02079793          	slli	a5,a5,0x20
    80002a0c:	0207d793          	srli	a5,a5,0x20
    80002a10:	00fd87b3          	add	a5,s11,a5
    80002a14:	0007c503          	lbu	a0,0(a5)
    80002a18:	02d757bb          	divuw	a5,a4,a3
    80002a1c:	f8a40123          	sb	a0,-126(s0)
    80002a20:	48e5f263          	bgeu	a1,a4,80002ea4 <__printf+0x5fc>
    80002a24:	06300513          	li	a0,99
    80002a28:	02d7f5bb          	remuw	a1,a5,a3
    80002a2c:	02059593          	slli	a1,a1,0x20
    80002a30:	0205d593          	srli	a1,a1,0x20
    80002a34:	00bd85b3          	add	a1,s11,a1
    80002a38:	0005c583          	lbu	a1,0(a1)
    80002a3c:	02d7d7bb          	divuw	a5,a5,a3
    80002a40:	f8b401a3          	sb	a1,-125(s0)
    80002a44:	48e57263          	bgeu	a0,a4,80002ec8 <__printf+0x620>
    80002a48:	3e700513          	li	a0,999
    80002a4c:	02d7f5bb          	remuw	a1,a5,a3
    80002a50:	02059593          	slli	a1,a1,0x20
    80002a54:	0205d593          	srli	a1,a1,0x20
    80002a58:	00bd85b3          	add	a1,s11,a1
    80002a5c:	0005c583          	lbu	a1,0(a1)
    80002a60:	02d7d7bb          	divuw	a5,a5,a3
    80002a64:	f8b40223          	sb	a1,-124(s0)
    80002a68:	46e57663          	bgeu	a0,a4,80002ed4 <__printf+0x62c>
    80002a6c:	02d7f5bb          	remuw	a1,a5,a3
    80002a70:	02059593          	slli	a1,a1,0x20
    80002a74:	0205d593          	srli	a1,a1,0x20
    80002a78:	00bd85b3          	add	a1,s11,a1
    80002a7c:	0005c583          	lbu	a1,0(a1)
    80002a80:	02d7d7bb          	divuw	a5,a5,a3
    80002a84:	f8b402a3          	sb	a1,-123(s0)
    80002a88:	46ea7863          	bgeu	s4,a4,80002ef8 <__printf+0x650>
    80002a8c:	02d7f5bb          	remuw	a1,a5,a3
    80002a90:	02059593          	slli	a1,a1,0x20
    80002a94:	0205d593          	srli	a1,a1,0x20
    80002a98:	00bd85b3          	add	a1,s11,a1
    80002a9c:	0005c583          	lbu	a1,0(a1)
    80002aa0:	02d7d7bb          	divuw	a5,a5,a3
    80002aa4:	f8b40323          	sb	a1,-122(s0)
    80002aa8:	3eeaf863          	bgeu	s5,a4,80002e98 <__printf+0x5f0>
    80002aac:	02d7f5bb          	remuw	a1,a5,a3
    80002ab0:	02059593          	slli	a1,a1,0x20
    80002ab4:	0205d593          	srli	a1,a1,0x20
    80002ab8:	00bd85b3          	add	a1,s11,a1
    80002abc:	0005c583          	lbu	a1,0(a1)
    80002ac0:	02d7d7bb          	divuw	a5,a5,a3
    80002ac4:	f8b403a3          	sb	a1,-121(s0)
    80002ac8:	42eb7e63          	bgeu	s6,a4,80002f04 <__printf+0x65c>
    80002acc:	02d7f5bb          	remuw	a1,a5,a3
    80002ad0:	02059593          	slli	a1,a1,0x20
    80002ad4:	0205d593          	srli	a1,a1,0x20
    80002ad8:	00bd85b3          	add	a1,s11,a1
    80002adc:	0005c583          	lbu	a1,0(a1)
    80002ae0:	02d7d7bb          	divuw	a5,a5,a3
    80002ae4:	f8b40423          	sb	a1,-120(s0)
    80002ae8:	42ebfc63          	bgeu	s7,a4,80002f20 <__printf+0x678>
    80002aec:	02079793          	slli	a5,a5,0x20
    80002af0:	0207d793          	srli	a5,a5,0x20
    80002af4:	00fd8db3          	add	s11,s11,a5
    80002af8:	000dc703          	lbu	a4,0(s11)
    80002afc:	00a00793          	li	a5,10
    80002b00:	00900c93          	li	s9,9
    80002b04:	f8e404a3          	sb	a4,-119(s0)
    80002b08:	00065c63          	bgez	a2,80002b20 <__printf+0x278>
    80002b0c:	f9040713          	addi	a4,s0,-112
    80002b10:	00f70733          	add	a4,a4,a5
    80002b14:	02d00693          	li	a3,45
    80002b18:	fed70823          	sb	a3,-16(a4)
    80002b1c:	00078c93          	mv	s9,a5
    80002b20:	f8040793          	addi	a5,s0,-128
    80002b24:	01978cb3          	add	s9,a5,s9
    80002b28:	f7f40d13          	addi	s10,s0,-129
    80002b2c:	000cc503          	lbu	a0,0(s9)
    80002b30:	fffc8c93          	addi	s9,s9,-1
    80002b34:	00000097          	auipc	ra,0x0
    80002b38:	b90080e7          	jalr	-1136(ra) # 800026c4 <consputc>
    80002b3c:	ffac98e3          	bne	s9,s10,80002b2c <__printf+0x284>
    80002b40:	00094503          	lbu	a0,0(s2)
    80002b44:	e00514e3          	bnez	a0,8000294c <__printf+0xa4>
    80002b48:	1a0c1663          	bnez	s8,80002cf4 <__printf+0x44c>
    80002b4c:	08813083          	ld	ra,136(sp)
    80002b50:	08013403          	ld	s0,128(sp)
    80002b54:	07813483          	ld	s1,120(sp)
    80002b58:	07013903          	ld	s2,112(sp)
    80002b5c:	06813983          	ld	s3,104(sp)
    80002b60:	06013a03          	ld	s4,96(sp)
    80002b64:	05813a83          	ld	s5,88(sp)
    80002b68:	05013b03          	ld	s6,80(sp)
    80002b6c:	04813b83          	ld	s7,72(sp)
    80002b70:	04013c03          	ld	s8,64(sp)
    80002b74:	03813c83          	ld	s9,56(sp)
    80002b78:	03013d03          	ld	s10,48(sp)
    80002b7c:	02813d83          	ld	s11,40(sp)
    80002b80:	0d010113          	addi	sp,sp,208
    80002b84:	00008067          	ret
    80002b88:	07300713          	li	a4,115
    80002b8c:	1ce78a63          	beq	a5,a4,80002d60 <__printf+0x4b8>
    80002b90:	07800713          	li	a4,120
    80002b94:	1ee79e63          	bne	a5,a4,80002d90 <__printf+0x4e8>
    80002b98:	f7843783          	ld	a5,-136(s0)
    80002b9c:	0007a703          	lw	a4,0(a5)
    80002ba0:	00878793          	addi	a5,a5,8
    80002ba4:	f6f43c23          	sd	a5,-136(s0)
    80002ba8:	28074263          	bltz	a4,80002e2c <__printf+0x584>
    80002bac:	00001d97          	auipc	s11,0x1
    80002bb0:	5ccd8d93          	addi	s11,s11,1484 # 80004178 <digits>
    80002bb4:	00f77793          	andi	a5,a4,15
    80002bb8:	00fd87b3          	add	a5,s11,a5
    80002bbc:	0007c683          	lbu	a3,0(a5)
    80002bc0:	00f00613          	li	a2,15
    80002bc4:	0007079b          	sext.w	a5,a4
    80002bc8:	f8d40023          	sb	a3,-128(s0)
    80002bcc:	0047559b          	srliw	a1,a4,0x4
    80002bd0:	0047569b          	srliw	a3,a4,0x4
    80002bd4:	00000c93          	li	s9,0
    80002bd8:	0ee65063          	bge	a2,a4,80002cb8 <__printf+0x410>
    80002bdc:	00f6f693          	andi	a3,a3,15
    80002be0:	00dd86b3          	add	a3,s11,a3
    80002be4:	0006c683          	lbu	a3,0(a3) # 2004000 <_entry-0x7dffc000>
    80002be8:	0087d79b          	srliw	a5,a5,0x8
    80002bec:	00100c93          	li	s9,1
    80002bf0:	f8d400a3          	sb	a3,-127(s0)
    80002bf4:	0cb67263          	bgeu	a2,a1,80002cb8 <__printf+0x410>
    80002bf8:	00f7f693          	andi	a3,a5,15
    80002bfc:	00dd86b3          	add	a3,s11,a3
    80002c00:	0006c583          	lbu	a1,0(a3)
    80002c04:	00f00613          	li	a2,15
    80002c08:	0047d69b          	srliw	a3,a5,0x4
    80002c0c:	f8b40123          	sb	a1,-126(s0)
    80002c10:	0047d593          	srli	a1,a5,0x4
    80002c14:	28f67e63          	bgeu	a2,a5,80002eb0 <__printf+0x608>
    80002c18:	00f6f693          	andi	a3,a3,15
    80002c1c:	00dd86b3          	add	a3,s11,a3
    80002c20:	0006c503          	lbu	a0,0(a3)
    80002c24:	0087d813          	srli	a6,a5,0x8
    80002c28:	0087d69b          	srliw	a3,a5,0x8
    80002c2c:	f8a401a3          	sb	a0,-125(s0)
    80002c30:	28b67663          	bgeu	a2,a1,80002ebc <__printf+0x614>
    80002c34:	00f6f693          	andi	a3,a3,15
    80002c38:	00dd86b3          	add	a3,s11,a3
    80002c3c:	0006c583          	lbu	a1,0(a3)
    80002c40:	00c7d513          	srli	a0,a5,0xc
    80002c44:	00c7d69b          	srliw	a3,a5,0xc
    80002c48:	f8b40223          	sb	a1,-124(s0)
    80002c4c:	29067a63          	bgeu	a2,a6,80002ee0 <__printf+0x638>
    80002c50:	00f6f693          	andi	a3,a3,15
    80002c54:	00dd86b3          	add	a3,s11,a3
    80002c58:	0006c583          	lbu	a1,0(a3)
    80002c5c:	0107d813          	srli	a6,a5,0x10
    80002c60:	0107d69b          	srliw	a3,a5,0x10
    80002c64:	f8b402a3          	sb	a1,-123(s0)
    80002c68:	28a67263          	bgeu	a2,a0,80002eec <__printf+0x644>
    80002c6c:	00f6f693          	andi	a3,a3,15
    80002c70:	00dd86b3          	add	a3,s11,a3
    80002c74:	0006c683          	lbu	a3,0(a3)
    80002c78:	0147d79b          	srliw	a5,a5,0x14
    80002c7c:	f8d40323          	sb	a3,-122(s0)
    80002c80:	21067663          	bgeu	a2,a6,80002e8c <__printf+0x5e4>
    80002c84:	02079793          	slli	a5,a5,0x20
    80002c88:	0207d793          	srli	a5,a5,0x20
    80002c8c:	00fd8db3          	add	s11,s11,a5
    80002c90:	000dc683          	lbu	a3,0(s11)
    80002c94:	00800793          	li	a5,8
    80002c98:	00700c93          	li	s9,7
    80002c9c:	f8d403a3          	sb	a3,-121(s0)
    80002ca0:	00075c63          	bgez	a4,80002cb8 <__printf+0x410>
    80002ca4:	f9040713          	addi	a4,s0,-112
    80002ca8:	00f70733          	add	a4,a4,a5
    80002cac:	02d00693          	li	a3,45
    80002cb0:	fed70823          	sb	a3,-16(a4)
    80002cb4:	00078c93          	mv	s9,a5
    80002cb8:	f8040793          	addi	a5,s0,-128
    80002cbc:	01978cb3          	add	s9,a5,s9
    80002cc0:	f7f40d13          	addi	s10,s0,-129
    80002cc4:	000cc503          	lbu	a0,0(s9)
    80002cc8:	fffc8c93          	addi	s9,s9,-1
    80002ccc:	00000097          	auipc	ra,0x0
    80002cd0:	9f8080e7          	jalr	-1544(ra) # 800026c4 <consputc>
    80002cd4:	ff9d18e3          	bne	s10,s9,80002cc4 <__printf+0x41c>
    80002cd8:	0100006f          	j	80002ce8 <__printf+0x440>
    80002cdc:	00000097          	auipc	ra,0x0
    80002ce0:	9e8080e7          	jalr	-1560(ra) # 800026c4 <consputc>
    80002ce4:	000c8493          	mv	s1,s9
    80002ce8:	00094503          	lbu	a0,0(s2)
    80002cec:	c60510e3          	bnez	a0,8000294c <__printf+0xa4>
    80002cf0:	e40c0ee3          	beqz	s8,80002b4c <__printf+0x2a4>
    80002cf4:	00004517          	auipc	a0,0x4
    80002cf8:	c9c50513          	addi	a0,a0,-868 # 80006990 <pr>
    80002cfc:	00001097          	auipc	ra,0x1
    80002d00:	94c080e7          	jalr	-1716(ra) # 80003648 <release>
    80002d04:	e49ff06f          	j	80002b4c <__printf+0x2a4>
    80002d08:	f7843783          	ld	a5,-136(s0)
    80002d0c:	03000513          	li	a0,48
    80002d10:	01000d13          	li	s10,16
    80002d14:	00878713          	addi	a4,a5,8
    80002d18:	0007bc83          	ld	s9,0(a5)
    80002d1c:	f6e43c23          	sd	a4,-136(s0)
    80002d20:	00000097          	auipc	ra,0x0
    80002d24:	9a4080e7          	jalr	-1628(ra) # 800026c4 <consputc>
    80002d28:	07800513          	li	a0,120
    80002d2c:	00000097          	auipc	ra,0x0
    80002d30:	998080e7          	jalr	-1640(ra) # 800026c4 <consputc>
    80002d34:	00001d97          	auipc	s11,0x1
    80002d38:	444d8d93          	addi	s11,s11,1092 # 80004178 <digits>
    80002d3c:	03ccd793          	srli	a5,s9,0x3c
    80002d40:	00fd87b3          	add	a5,s11,a5
    80002d44:	0007c503          	lbu	a0,0(a5)
    80002d48:	fffd0d1b          	addiw	s10,s10,-1
    80002d4c:	004c9c93          	slli	s9,s9,0x4
    80002d50:	00000097          	auipc	ra,0x0
    80002d54:	974080e7          	jalr	-1676(ra) # 800026c4 <consputc>
    80002d58:	fe0d12e3          	bnez	s10,80002d3c <__printf+0x494>
    80002d5c:	f8dff06f          	j	80002ce8 <__printf+0x440>
    80002d60:	f7843783          	ld	a5,-136(s0)
    80002d64:	0007bc83          	ld	s9,0(a5)
    80002d68:	00878793          	addi	a5,a5,8
    80002d6c:	f6f43c23          	sd	a5,-136(s0)
    80002d70:	000c9a63          	bnez	s9,80002d84 <__printf+0x4dc>
    80002d74:	1080006f          	j	80002e7c <__printf+0x5d4>
    80002d78:	001c8c93          	addi	s9,s9,1
    80002d7c:	00000097          	auipc	ra,0x0
    80002d80:	948080e7          	jalr	-1720(ra) # 800026c4 <consputc>
    80002d84:	000cc503          	lbu	a0,0(s9)
    80002d88:	fe0518e3          	bnez	a0,80002d78 <__printf+0x4d0>
    80002d8c:	f5dff06f          	j	80002ce8 <__printf+0x440>
    80002d90:	02500513          	li	a0,37
    80002d94:	00000097          	auipc	ra,0x0
    80002d98:	930080e7          	jalr	-1744(ra) # 800026c4 <consputc>
    80002d9c:	000c8513          	mv	a0,s9
    80002da0:	00000097          	auipc	ra,0x0
    80002da4:	924080e7          	jalr	-1756(ra) # 800026c4 <consputc>
    80002da8:	f41ff06f          	j	80002ce8 <__printf+0x440>
    80002dac:	02500513          	li	a0,37
    80002db0:	00000097          	auipc	ra,0x0
    80002db4:	914080e7          	jalr	-1772(ra) # 800026c4 <consputc>
    80002db8:	f31ff06f          	j	80002ce8 <__printf+0x440>
    80002dbc:	00030513          	mv	a0,t1
    80002dc0:	00000097          	auipc	ra,0x0
    80002dc4:	7bc080e7          	jalr	1980(ra) # 8000357c <acquire>
    80002dc8:	b4dff06f          	j	80002914 <__printf+0x6c>
    80002dcc:	40c0053b          	negw	a0,a2
    80002dd0:	00a00713          	li	a4,10
    80002dd4:	02e576bb          	remuw	a3,a0,a4
    80002dd8:	00001d97          	auipc	s11,0x1
    80002ddc:	3a0d8d93          	addi	s11,s11,928 # 80004178 <digits>
    80002de0:	ff700593          	li	a1,-9
    80002de4:	02069693          	slli	a3,a3,0x20
    80002de8:	0206d693          	srli	a3,a3,0x20
    80002dec:	00dd86b3          	add	a3,s11,a3
    80002df0:	0006c683          	lbu	a3,0(a3)
    80002df4:	02e557bb          	divuw	a5,a0,a4
    80002df8:	f8d40023          	sb	a3,-128(s0)
    80002dfc:	10b65e63          	bge	a2,a1,80002f18 <__printf+0x670>
    80002e00:	06300593          	li	a1,99
    80002e04:	02e7f6bb          	remuw	a3,a5,a4
    80002e08:	02069693          	slli	a3,a3,0x20
    80002e0c:	0206d693          	srli	a3,a3,0x20
    80002e10:	00dd86b3          	add	a3,s11,a3
    80002e14:	0006c683          	lbu	a3,0(a3)
    80002e18:	02e7d73b          	divuw	a4,a5,a4
    80002e1c:	00200793          	li	a5,2
    80002e20:	f8d400a3          	sb	a3,-127(s0)
    80002e24:	bca5ece3          	bltu	a1,a0,800029fc <__printf+0x154>
    80002e28:	ce5ff06f          	j	80002b0c <__printf+0x264>
    80002e2c:	40e007bb          	negw	a5,a4
    80002e30:	00001d97          	auipc	s11,0x1
    80002e34:	348d8d93          	addi	s11,s11,840 # 80004178 <digits>
    80002e38:	00f7f693          	andi	a3,a5,15
    80002e3c:	00dd86b3          	add	a3,s11,a3
    80002e40:	0006c583          	lbu	a1,0(a3)
    80002e44:	ff100613          	li	a2,-15
    80002e48:	0047d69b          	srliw	a3,a5,0x4
    80002e4c:	f8b40023          	sb	a1,-128(s0)
    80002e50:	0047d59b          	srliw	a1,a5,0x4
    80002e54:	0ac75e63          	bge	a4,a2,80002f10 <__printf+0x668>
    80002e58:	00f6f693          	andi	a3,a3,15
    80002e5c:	00dd86b3          	add	a3,s11,a3
    80002e60:	0006c603          	lbu	a2,0(a3)
    80002e64:	00f00693          	li	a3,15
    80002e68:	0087d79b          	srliw	a5,a5,0x8
    80002e6c:	f8c400a3          	sb	a2,-127(s0)
    80002e70:	d8b6e4e3          	bltu	a3,a1,80002bf8 <__printf+0x350>
    80002e74:	00200793          	li	a5,2
    80002e78:	e2dff06f          	j	80002ca4 <__printf+0x3fc>
    80002e7c:	00001c97          	auipc	s9,0x1
    80002e80:	2dcc8c93          	addi	s9,s9,732 # 80004158 <CONSOLE_STATUS+0x140>
    80002e84:	02800513          	li	a0,40
    80002e88:	ef1ff06f          	j	80002d78 <__printf+0x4d0>
    80002e8c:	00700793          	li	a5,7
    80002e90:	00600c93          	li	s9,6
    80002e94:	e0dff06f          	j	80002ca0 <__printf+0x3f8>
    80002e98:	00700793          	li	a5,7
    80002e9c:	00600c93          	li	s9,6
    80002ea0:	c69ff06f          	j	80002b08 <__printf+0x260>
    80002ea4:	00300793          	li	a5,3
    80002ea8:	00200c93          	li	s9,2
    80002eac:	c5dff06f          	j	80002b08 <__printf+0x260>
    80002eb0:	00300793          	li	a5,3
    80002eb4:	00200c93          	li	s9,2
    80002eb8:	de9ff06f          	j	80002ca0 <__printf+0x3f8>
    80002ebc:	00400793          	li	a5,4
    80002ec0:	00300c93          	li	s9,3
    80002ec4:	dddff06f          	j	80002ca0 <__printf+0x3f8>
    80002ec8:	00400793          	li	a5,4
    80002ecc:	00300c93          	li	s9,3
    80002ed0:	c39ff06f          	j	80002b08 <__printf+0x260>
    80002ed4:	00500793          	li	a5,5
    80002ed8:	00400c93          	li	s9,4
    80002edc:	c2dff06f          	j	80002b08 <__printf+0x260>
    80002ee0:	00500793          	li	a5,5
    80002ee4:	00400c93          	li	s9,4
    80002ee8:	db9ff06f          	j	80002ca0 <__printf+0x3f8>
    80002eec:	00600793          	li	a5,6
    80002ef0:	00500c93          	li	s9,5
    80002ef4:	dadff06f          	j	80002ca0 <__printf+0x3f8>
    80002ef8:	00600793          	li	a5,6
    80002efc:	00500c93          	li	s9,5
    80002f00:	c09ff06f          	j	80002b08 <__printf+0x260>
    80002f04:	00800793          	li	a5,8
    80002f08:	00700c93          	li	s9,7
    80002f0c:	bfdff06f          	j	80002b08 <__printf+0x260>
    80002f10:	00100793          	li	a5,1
    80002f14:	d91ff06f          	j	80002ca4 <__printf+0x3fc>
    80002f18:	00100793          	li	a5,1
    80002f1c:	bf1ff06f          	j	80002b0c <__printf+0x264>
    80002f20:	00900793          	li	a5,9
    80002f24:	00800c93          	li	s9,8
    80002f28:	be1ff06f          	j	80002b08 <__printf+0x260>
    80002f2c:	00001517          	auipc	a0,0x1
    80002f30:	23450513          	addi	a0,a0,564 # 80004160 <CONSOLE_STATUS+0x148>
    80002f34:	00000097          	auipc	ra,0x0
    80002f38:	918080e7          	jalr	-1768(ra) # 8000284c <panic>

0000000080002f3c <printfinit>:
    80002f3c:	fe010113          	addi	sp,sp,-32
    80002f40:	00813823          	sd	s0,16(sp)
    80002f44:	00913423          	sd	s1,8(sp)
    80002f48:	00113c23          	sd	ra,24(sp)
    80002f4c:	02010413          	addi	s0,sp,32
    80002f50:	00004497          	auipc	s1,0x4
    80002f54:	a4048493          	addi	s1,s1,-1472 # 80006990 <pr>
    80002f58:	00048513          	mv	a0,s1
    80002f5c:	00001597          	auipc	a1,0x1
    80002f60:	21458593          	addi	a1,a1,532 # 80004170 <CONSOLE_STATUS+0x158>
    80002f64:	00000097          	auipc	ra,0x0
    80002f68:	5f4080e7          	jalr	1524(ra) # 80003558 <initlock>
    80002f6c:	01813083          	ld	ra,24(sp)
    80002f70:	01013403          	ld	s0,16(sp)
    80002f74:	0004ac23          	sw	zero,24(s1)
    80002f78:	00813483          	ld	s1,8(sp)
    80002f7c:	02010113          	addi	sp,sp,32
    80002f80:	00008067          	ret

0000000080002f84 <uartinit>:
    80002f84:	ff010113          	addi	sp,sp,-16
    80002f88:	00813423          	sd	s0,8(sp)
    80002f8c:	01010413          	addi	s0,sp,16
    80002f90:	100007b7          	lui	a5,0x10000
    80002f94:	000780a3          	sb	zero,1(a5) # 10000001 <_entry-0x6fffffff>
    80002f98:	f8000713          	li	a4,-128
    80002f9c:	00e781a3          	sb	a4,3(a5)
    80002fa0:	00300713          	li	a4,3
    80002fa4:	00e78023          	sb	a4,0(a5)
    80002fa8:	000780a3          	sb	zero,1(a5)
    80002fac:	00e781a3          	sb	a4,3(a5)
    80002fb0:	00700693          	li	a3,7
    80002fb4:	00d78123          	sb	a3,2(a5)
    80002fb8:	00e780a3          	sb	a4,1(a5)
    80002fbc:	00813403          	ld	s0,8(sp)
    80002fc0:	01010113          	addi	sp,sp,16
    80002fc4:	00008067          	ret

0000000080002fc8 <uartputc>:
    80002fc8:	00001797          	auipc	a5,0x1
    80002fcc:	3847a783          	lw	a5,900(a5) # 8000434c <panicked>
    80002fd0:	00078463          	beqz	a5,80002fd8 <uartputc+0x10>
    80002fd4:	0000006f          	j	80002fd4 <uartputc+0xc>
    80002fd8:	fd010113          	addi	sp,sp,-48
    80002fdc:	02813023          	sd	s0,32(sp)
    80002fe0:	00913c23          	sd	s1,24(sp)
    80002fe4:	01213823          	sd	s2,16(sp)
    80002fe8:	01313423          	sd	s3,8(sp)
    80002fec:	02113423          	sd	ra,40(sp)
    80002ff0:	03010413          	addi	s0,sp,48
    80002ff4:	00001917          	auipc	s2,0x1
    80002ff8:	35c90913          	addi	s2,s2,860 # 80004350 <uart_tx_r>
    80002ffc:	00093783          	ld	a5,0(s2)
    80003000:	00001497          	auipc	s1,0x1
    80003004:	35848493          	addi	s1,s1,856 # 80004358 <uart_tx_w>
    80003008:	0004b703          	ld	a4,0(s1)
    8000300c:	02078693          	addi	a3,a5,32
    80003010:	00050993          	mv	s3,a0
    80003014:	02e69c63          	bne	a3,a4,8000304c <uartputc+0x84>
    80003018:	00001097          	auipc	ra,0x1
    8000301c:	834080e7          	jalr	-1996(ra) # 8000384c <push_on>
    80003020:	00093783          	ld	a5,0(s2)
    80003024:	0004b703          	ld	a4,0(s1)
    80003028:	02078793          	addi	a5,a5,32
    8000302c:	00e79463          	bne	a5,a4,80003034 <uartputc+0x6c>
    80003030:	0000006f          	j	80003030 <uartputc+0x68>
    80003034:	00001097          	auipc	ra,0x1
    80003038:	88c080e7          	jalr	-1908(ra) # 800038c0 <pop_on>
    8000303c:	00093783          	ld	a5,0(s2)
    80003040:	0004b703          	ld	a4,0(s1)
    80003044:	02078693          	addi	a3,a5,32
    80003048:	fce688e3          	beq	a3,a4,80003018 <uartputc+0x50>
    8000304c:	01f77693          	andi	a3,a4,31
    80003050:	00004597          	auipc	a1,0x4
    80003054:	96058593          	addi	a1,a1,-1696 # 800069b0 <uart_tx_buf>
    80003058:	00d586b3          	add	a3,a1,a3
    8000305c:	00170713          	addi	a4,a4,1
    80003060:	01368023          	sb	s3,0(a3)
    80003064:	00e4b023          	sd	a4,0(s1)
    80003068:	10000637          	lui	a2,0x10000
    8000306c:	02f71063          	bne	a4,a5,8000308c <uartputc+0xc4>
    80003070:	0340006f          	j	800030a4 <uartputc+0xdc>
    80003074:	00074703          	lbu	a4,0(a4)
    80003078:	00f93023          	sd	a5,0(s2)
    8000307c:	00e60023          	sb	a4,0(a2) # 10000000 <_entry-0x70000000>
    80003080:	00093783          	ld	a5,0(s2)
    80003084:	0004b703          	ld	a4,0(s1)
    80003088:	00f70e63          	beq	a4,a5,800030a4 <uartputc+0xdc>
    8000308c:	00564683          	lbu	a3,5(a2)
    80003090:	01f7f713          	andi	a4,a5,31
    80003094:	00e58733          	add	a4,a1,a4
    80003098:	0206f693          	andi	a3,a3,32
    8000309c:	00178793          	addi	a5,a5,1
    800030a0:	fc069ae3          	bnez	a3,80003074 <uartputc+0xac>
    800030a4:	02813083          	ld	ra,40(sp)
    800030a8:	02013403          	ld	s0,32(sp)
    800030ac:	01813483          	ld	s1,24(sp)
    800030b0:	01013903          	ld	s2,16(sp)
    800030b4:	00813983          	ld	s3,8(sp)
    800030b8:	03010113          	addi	sp,sp,48
    800030bc:	00008067          	ret

00000000800030c0 <uartputc_sync>:
    800030c0:	ff010113          	addi	sp,sp,-16
    800030c4:	00813423          	sd	s0,8(sp)
    800030c8:	01010413          	addi	s0,sp,16
    800030cc:	00001717          	auipc	a4,0x1
    800030d0:	28072703          	lw	a4,640(a4) # 8000434c <panicked>
    800030d4:	02071663          	bnez	a4,80003100 <uartputc_sync+0x40>
    800030d8:	00050793          	mv	a5,a0
    800030dc:	100006b7          	lui	a3,0x10000
    800030e0:	0056c703          	lbu	a4,5(a3) # 10000005 <_entry-0x6ffffffb>
    800030e4:	02077713          	andi	a4,a4,32
    800030e8:	fe070ce3          	beqz	a4,800030e0 <uartputc_sync+0x20>
    800030ec:	0ff7f793          	andi	a5,a5,255
    800030f0:	00f68023          	sb	a5,0(a3)
    800030f4:	00813403          	ld	s0,8(sp)
    800030f8:	01010113          	addi	sp,sp,16
    800030fc:	00008067          	ret
    80003100:	0000006f          	j	80003100 <uartputc_sync+0x40>

0000000080003104 <uartstart>:
    80003104:	ff010113          	addi	sp,sp,-16
    80003108:	00813423          	sd	s0,8(sp)
    8000310c:	01010413          	addi	s0,sp,16
    80003110:	00001617          	auipc	a2,0x1
    80003114:	24060613          	addi	a2,a2,576 # 80004350 <uart_tx_r>
    80003118:	00001517          	auipc	a0,0x1
    8000311c:	24050513          	addi	a0,a0,576 # 80004358 <uart_tx_w>
    80003120:	00063783          	ld	a5,0(a2)
    80003124:	00053703          	ld	a4,0(a0)
    80003128:	04f70263          	beq	a4,a5,8000316c <uartstart+0x68>
    8000312c:	100005b7          	lui	a1,0x10000
    80003130:	00004817          	auipc	a6,0x4
    80003134:	88080813          	addi	a6,a6,-1920 # 800069b0 <uart_tx_buf>
    80003138:	01c0006f          	j	80003154 <uartstart+0x50>
    8000313c:	0006c703          	lbu	a4,0(a3)
    80003140:	00f63023          	sd	a5,0(a2)
    80003144:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    80003148:	00063783          	ld	a5,0(a2)
    8000314c:	00053703          	ld	a4,0(a0)
    80003150:	00f70e63          	beq	a4,a5,8000316c <uartstart+0x68>
    80003154:	01f7f713          	andi	a4,a5,31
    80003158:	00e806b3          	add	a3,a6,a4
    8000315c:	0055c703          	lbu	a4,5(a1)
    80003160:	00178793          	addi	a5,a5,1
    80003164:	02077713          	andi	a4,a4,32
    80003168:	fc071ae3          	bnez	a4,8000313c <uartstart+0x38>
    8000316c:	00813403          	ld	s0,8(sp)
    80003170:	01010113          	addi	sp,sp,16
    80003174:	00008067          	ret

0000000080003178 <uartgetc>:
    80003178:	ff010113          	addi	sp,sp,-16
    8000317c:	00813423          	sd	s0,8(sp)
    80003180:	01010413          	addi	s0,sp,16
    80003184:	10000737          	lui	a4,0x10000
    80003188:	00574783          	lbu	a5,5(a4) # 10000005 <_entry-0x6ffffffb>
    8000318c:	0017f793          	andi	a5,a5,1
    80003190:	00078c63          	beqz	a5,800031a8 <uartgetc+0x30>
    80003194:	00074503          	lbu	a0,0(a4)
    80003198:	0ff57513          	andi	a0,a0,255
    8000319c:	00813403          	ld	s0,8(sp)
    800031a0:	01010113          	addi	sp,sp,16
    800031a4:	00008067          	ret
    800031a8:	fff00513          	li	a0,-1
    800031ac:	ff1ff06f          	j	8000319c <uartgetc+0x24>

00000000800031b0 <uartintr>:
    800031b0:	100007b7          	lui	a5,0x10000
    800031b4:	0057c783          	lbu	a5,5(a5) # 10000005 <_entry-0x6ffffffb>
    800031b8:	0017f793          	andi	a5,a5,1
    800031bc:	0a078463          	beqz	a5,80003264 <uartintr+0xb4>
    800031c0:	fe010113          	addi	sp,sp,-32
    800031c4:	00813823          	sd	s0,16(sp)
    800031c8:	00913423          	sd	s1,8(sp)
    800031cc:	00113c23          	sd	ra,24(sp)
    800031d0:	02010413          	addi	s0,sp,32
    800031d4:	100004b7          	lui	s1,0x10000
    800031d8:	0004c503          	lbu	a0,0(s1) # 10000000 <_entry-0x70000000>
    800031dc:	0ff57513          	andi	a0,a0,255
    800031e0:	fffff097          	auipc	ra,0xfffff
    800031e4:	534080e7          	jalr	1332(ra) # 80002714 <consoleintr>
    800031e8:	0054c783          	lbu	a5,5(s1)
    800031ec:	0017f793          	andi	a5,a5,1
    800031f0:	fe0794e3          	bnez	a5,800031d8 <uartintr+0x28>
    800031f4:	00001617          	auipc	a2,0x1
    800031f8:	15c60613          	addi	a2,a2,348 # 80004350 <uart_tx_r>
    800031fc:	00001517          	auipc	a0,0x1
    80003200:	15c50513          	addi	a0,a0,348 # 80004358 <uart_tx_w>
    80003204:	00063783          	ld	a5,0(a2)
    80003208:	00053703          	ld	a4,0(a0)
    8000320c:	04f70263          	beq	a4,a5,80003250 <uartintr+0xa0>
    80003210:	100005b7          	lui	a1,0x10000
    80003214:	00003817          	auipc	a6,0x3
    80003218:	79c80813          	addi	a6,a6,1948 # 800069b0 <uart_tx_buf>
    8000321c:	01c0006f          	j	80003238 <uartintr+0x88>
    80003220:	0006c703          	lbu	a4,0(a3)
    80003224:	00f63023          	sd	a5,0(a2)
    80003228:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    8000322c:	00063783          	ld	a5,0(a2)
    80003230:	00053703          	ld	a4,0(a0)
    80003234:	00f70e63          	beq	a4,a5,80003250 <uartintr+0xa0>
    80003238:	01f7f713          	andi	a4,a5,31
    8000323c:	00e806b3          	add	a3,a6,a4
    80003240:	0055c703          	lbu	a4,5(a1)
    80003244:	00178793          	addi	a5,a5,1
    80003248:	02077713          	andi	a4,a4,32
    8000324c:	fc071ae3          	bnez	a4,80003220 <uartintr+0x70>
    80003250:	01813083          	ld	ra,24(sp)
    80003254:	01013403          	ld	s0,16(sp)
    80003258:	00813483          	ld	s1,8(sp)
    8000325c:	02010113          	addi	sp,sp,32
    80003260:	00008067          	ret
    80003264:	00001617          	auipc	a2,0x1
    80003268:	0ec60613          	addi	a2,a2,236 # 80004350 <uart_tx_r>
    8000326c:	00001517          	auipc	a0,0x1
    80003270:	0ec50513          	addi	a0,a0,236 # 80004358 <uart_tx_w>
    80003274:	00063783          	ld	a5,0(a2)
    80003278:	00053703          	ld	a4,0(a0)
    8000327c:	04f70263          	beq	a4,a5,800032c0 <uartintr+0x110>
    80003280:	100005b7          	lui	a1,0x10000
    80003284:	00003817          	auipc	a6,0x3
    80003288:	72c80813          	addi	a6,a6,1836 # 800069b0 <uart_tx_buf>
    8000328c:	01c0006f          	j	800032a8 <uartintr+0xf8>
    80003290:	0006c703          	lbu	a4,0(a3)
    80003294:	00f63023          	sd	a5,0(a2)
    80003298:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    8000329c:	00063783          	ld	a5,0(a2)
    800032a0:	00053703          	ld	a4,0(a0)
    800032a4:	02f70063          	beq	a4,a5,800032c4 <uartintr+0x114>
    800032a8:	01f7f713          	andi	a4,a5,31
    800032ac:	00e806b3          	add	a3,a6,a4
    800032b0:	0055c703          	lbu	a4,5(a1)
    800032b4:	00178793          	addi	a5,a5,1
    800032b8:	02077713          	andi	a4,a4,32
    800032bc:	fc071ae3          	bnez	a4,80003290 <uartintr+0xe0>
    800032c0:	00008067          	ret
    800032c4:	00008067          	ret

00000000800032c8 <kinit>:
    800032c8:	fc010113          	addi	sp,sp,-64
    800032cc:	02913423          	sd	s1,40(sp)
    800032d0:	fffff7b7          	lui	a5,0xfffff
    800032d4:	00004497          	auipc	s1,0x4
    800032d8:	6fb48493          	addi	s1,s1,1787 # 800079cf <end+0xfff>
    800032dc:	02813823          	sd	s0,48(sp)
    800032e0:	01313c23          	sd	s3,24(sp)
    800032e4:	00f4f4b3          	and	s1,s1,a5
    800032e8:	02113c23          	sd	ra,56(sp)
    800032ec:	03213023          	sd	s2,32(sp)
    800032f0:	01413823          	sd	s4,16(sp)
    800032f4:	01513423          	sd	s5,8(sp)
    800032f8:	04010413          	addi	s0,sp,64
    800032fc:	000017b7          	lui	a5,0x1
    80003300:	01100993          	li	s3,17
    80003304:	00f487b3          	add	a5,s1,a5
    80003308:	01b99993          	slli	s3,s3,0x1b
    8000330c:	06f9e063          	bltu	s3,a5,8000336c <kinit+0xa4>
    80003310:	00003a97          	auipc	s5,0x3
    80003314:	6c0a8a93          	addi	s5,s5,1728 # 800069d0 <end>
    80003318:	0754ec63          	bltu	s1,s5,80003390 <kinit+0xc8>
    8000331c:	0734fa63          	bgeu	s1,s3,80003390 <kinit+0xc8>
    80003320:	00088a37          	lui	s4,0x88
    80003324:	fffa0a13          	addi	s4,s4,-1 # 87fff <_entry-0x7ff78001>
    80003328:	00001917          	auipc	s2,0x1
    8000332c:	03890913          	addi	s2,s2,56 # 80004360 <kmem>
    80003330:	00ca1a13          	slli	s4,s4,0xc
    80003334:	0140006f          	j	80003348 <kinit+0x80>
    80003338:	000017b7          	lui	a5,0x1
    8000333c:	00f484b3          	add	s1,s1,a5
    80003340:	0554e863          	bltu	s1,s5,80003390 <kinit+0xc8>
    80003344:	0534f663          	bgeu	s1,s3,80003390 <kinit+0xc8>
    80003348:	00001637          	lui	a2,0x1
    8000334c:	00100593          	li	a1,1
    80003350:	00048513          	mv	a0,s1
    80003354:	00000097          	auipc	ra,0x0
    80003358:	5e4080e7          	jalr	1508(ra) # 80003938 <__memset>
    8000335c:	00093783          	ld	a5,0(s2)
    80003360:	00f4b023          	sd	a5,0(s1)
    80003364:	00993023          	sd	s1,0(s2)
    80003368:	fd4498e3          	bne	s1,s4,80003338 <kinit+0x70>
    8000336c:	03813083          	ld	ra,56(sp)
    80003370:	03013403          	ld	s0,48(sp)
    80003374:	02813483          	ld	s1,40(sp)
    80003378:	02013903          	ld	s2,32(sp)
    8000337c:	01813983          	ld	s3,24(sp)
    80003380:	01013a03          	ld	s4,16(sp)
    80003384:	00813a83          	ld	s5,8(sp)
    80003388:	04010113          	addi	sp,sp,64
    8000338c:	00008067          	ret
    80003390:	00001517          	auipc	a0,0x1
    80003394:	e0050513          	addi	a0,a0,-512 # 80004190 <digits+0x18>
    80003398:	fffff097          	auipc	ra,0xfffff
    8000339c:	4b4080e7          	jalr	1204(ra) # 8000284c <panic>

00000000800033a0 <freerange>:
    800033a0:	fc010113          	addi	sp,sp,-64
    800033a4:	000017b7          	lui	a5,0x1
    800033a8:	02913423          	sd	s1,40(sp)
    800033ac:	fff78493          	addi	s1,a5,-1 # fff <_entry-0x7ffff001>
    800033b0:	009504b3          	add	s1,a0,s1
    800033b4:	fffff537          	lui	a0,0xfffff
    800033b8:	02813823          	sd	s0,48(sp)
    800033bc:	02113c23          	sd	ra,56(sp)
    800033c0:	03213023          	sd	s2,32(sp)
    800033c4:	01313c23          	sd	s3,24(sp)
    800033c8:	01413823          	sd	s4,16(sp)
    800033cc:	01513423          	sd	s5,8(sp)
    800033d0:	01613023          	sd	s6,0(sp)
    800033d4:	04010413          	addi	s0,sp,64
    800033d8:	00a4f4b3          	and	s1,s1,a0
    800033dc:	00f487b3          	add	a5,s1,a5
    800033e0:	06f5e463          	bltu	a1,a5,80003448 <freerange+0xa8>
    800033e4:	00003a97          	auipc	s5,0x3
    800033e8:	5eca8a93          	addi	s5,s5,1516 # 800069d0 <end>
    800033ec:	0954e263          	bltu	s1,s5,80003470 <freerange+0xd0>
    800033f0:	01100993          	li	s3,17
    800033f4:	01b99993          	slli	s3,s3,0x1b
    800033f8:	0734fc63          	bgeu	s1,s3,80003470 <freerange+0xd0>
    800033fc:	00058a13          	mv	s4,a1
    80003400:	00001917          	auipc	s2,0x1
    80003404:	f6090913          	addi	s2,s2,-160 # 80004360 <kmem>
    80003408:	00002b37          	lui	s6,0x2
    8000340c:	0140006f          	j	80003420 <freerange+0x80>
    80003410:	000017b7          	lui	a5,0x1
    80003414:	00f484b3          	add	s1,s1,a5
    80003418:	0554ec63          	bltu	s1,s5,80003470 <freerange+0xd0>
    8000341c:	0534fa63          	bgeu	s1,s3,80003470 <freerange+0xd0>
    80003420:	00001637          	lui	a2,0x1
    80003424:	00100593          	li	a1,1
    80003428:	00048513          	mv	a0,s1
    8000342c:	00000097          	auipc	ra,0x0
    80003430:	50c080e7          	jalr	1292(ra) # 80003938 <__memset>
    80003434:	00093703          	ld	a4,0(s2)
    80003438:	016487b3          	add	a5,s1,s6
    8000343c:	00e4b023          	sd	a4,0(s1)
    80003440:	00993023          	sd	s1,0(s2)
    80003444:	fcfa76e3          	bgeu	s4,a5,80003410 <freerange+0x70>
    80003448:	03813083          	ld	ra,56(sp)
    8000344c:	03013403          	ld	s0,48(sp)
    80003450:	02813483          	ld	s1,40(sp)
    80003454:	02013903          	ld	s2,32(sp)
    80003458:	01813983          	ld	s3,24(sp)
    8000345c:	01013a03          	ld	s4,16(sp)
    80003460:	00813a83          	ld	s5,8(sp)
    80003464:	00013b03          	ld	s6,0(sp)
    80003468:	04010113          	addi	sp,sp,64
    8000346c:	00008067          	ret
    80003470:	00001517          	auipc	a0,0x1
    80003474:	d2050513          	addi	a0,a0,-736 # 80004190 <digits+0x18>
    80003478:	fffff097          	auipc	ra,0xfffff
    8000347c:	3d4080e7          	jalr	980(ra) # 8000284c <panic>

0000000080003480 <kfree>:
    80003480:	fe010113          	addi	sp,sp,-32
    80003484:	00813823          	sd	s0,16(sp)
    80003488:	00113c23          	sd	ra,24(sp)
    8000348c:	00913423          	sd	s1,8(sp)
    80003490:	02010413          	addi	s0,sp,32
    80003494:	03451793          	slli	a5,a0,0x34
    80003498:	04079c63          	bnez	a5,800034f0 <kfree+0x70>
    8000349c:	00003797          	auipc	a5,0x3
    800034a0:	53478793          	addi	a5,a5,1332 # 800069d0 <end>
    800034a4:	00050493          	mv	s1,a0
    800034a8:	04f56463          	bltu	a0,a5,800034f0 <kfree+0x70>
    800034ac:	01100793          	li	a5,17
    800034b0:	01b79793          	slli	a5,a5,0x1b
    800034b4:	02f57e63          	bgeu	a0,a5,800034f0 <kfree+0x70>
    800034b8:	00001637          	lui	a2,0x1
    800034bc:	00100593          	li	a1,1
    800034c0:	00000097          	auipc	ra,0x0
    800034c4:	478080e7          	jalr	1144(ra) # 80003938 <__memset>
    800034c8:	00001797          	auipc	a5,0x1
    800034cc:	e9878793          	addi	a5,a5,-360 # 80004360 <kmem>
    800034d0:	0007b703          	ld	a4,0(a5)
    800034d4:	01813083          	ld	ra,24(sp)
    800034d8:	01013403          	ld	s0,16(sp)
    800034dc:	00e4b023          	sd	a4,0(s1)
    800034e0:	0097b023          	sd	s1,0(a5)
    800034e4:	00813483          	ld	s1,8(sp)
    800034e8:	02010113          	addi	sp,sp,32
    800034ec:	00008067          	ret
    800034f0:	00001517          	auipc	a0,0x1
    800034f4:	ca050513          	addi	a0,a0,-864 # 80004190 <digits+0x18>
    800034f8:	fffff097          	auipc	ra,0xfffff
    800034fc:	354080e7          	jalr	852(ra) # 8000284c <panic>

0000000080003500 <kalloc>:
    80003500:	fe010113          	addi	sp,sp,-32
    80003504:	00813823          	sd	s0,16(sp)
    80003508:	00913423          	sd	s1,8(sp)
    8000350c:	00113c23          	sd	ra,24(sp)
    80003510:	02010413          	addi	s0,sp,32
    80003514:	00001797          	auipc	a5,0x1
    80003518:	e4c78793          	addi	a5,a5,-436 # 80004360 <kmem>
    8000351c:	0007b483          	ld	s1,0(a5)
    80003520:	02048063          	beqz	s1,80003540 <kalloc+0x40>
    80003524:	0004b703          	ld	a4,0(s1)
    80003528:	00001637          	lui	a2,0x1
    8000352c:	00500593          	li	a1,5
    80003530:	00048513          	mv	a0,s1
    80003534:	00e7b023          	sd	a4,0(a5)
    80003538:	00000097          	auipc	ra,0x0
    8000353c:	400080e7          	jalr	1024(ra) # 80003938 <__memset>
    80003540:	01813083          	ld	ra,24(sp)
    80003544:	01013403          	ld	s0,16(sp)
    80003548:	00048513          	mv	a0,s1
    8000354c:	00813483          	ld	s1,8(sp)
    80003550:	02010113          	addi	sp,sp,32
    80003554:	00008067          	ret

0000000080003558 <initlock>:
    80003558:	ff010113          	addi	sp,sp,-16
    8000355c:	00813423          	sd	s0,8(sp)
    80003560:	01010413          	addi	s0,sp,16
    80003564:	00813403          	ld	s0,8(sp)
    80003568:	00b53423          	sd	a1,8(a0)
    8000356c:	00052023          	sw	zero,0(a0)
    80003570:	00053823          	sd	zero,16(a0)
    80003574:	01010113          	addi	sp,sp,16
    80003578:	00008067          	ret

000000008000357c <acquire>:
    8000357c:	fe010113          	addi	sp,sp,-32
    80003580:	00813823          	sd	s0,16(sp)
    80003584:	00913423          	sd	s1,8(sp)
    80003588:	00113c23          	sd	ra,24(sp)
    8000358c:	01213023          	sd	s2,0(sp)
    80003590:	02010413          	addi	s0,sp,32
    80003594:	00050493          	mv	s1,a0
    80003598:	10002973          	csrr	s2,sstatus
    8000359c:	100027f3          	csrr	a5,sstatus
    800035a0:	ffd7f793          	andi	a5,a5,-3
    800035a4:	10079073          	csrw	sstatus,a5
    800035a8:	fffff097          	auipc	ra,0xfffff
    800035ac:	8e4080e7          	jalr	-1820(ra) # 80001e8c <mycpu>
    800035b0:	07852783          	lw	a5,120(a0)
    800035b4:	06078e63          	beqz	a5,80003630 <acquire+0xb4>
    800035b8:	fffff097          	auipc	ra,0xfffff
    800035bc:	8d4080e7          	jalr	-1836(ra) # 80001e8c <mycpu>
    800035c0:	07852783          	lw	a5,120(a0)
    800035c4:	0004a703          	lw	a4,0(s1)
    800035c8:	0017879b          	addiw	a5,a5,1
    800035cc:	06f52c23          	sw	a5,120(a0)
    800035d0:	04071063          	bnez	a4,80003610 <acquire+0x94>
    800035d4:	00100713          	li	a4,1
    800035d8:	00070793          	mv	a5,a4
    800035dc:	0cf4a7af          	amoswap.w.aq	a5,a5,(s1)
    800035e0:	0007879b          	sext.w	a5,a5
    800035e4:	fe079ae3          	bnez	a5,800035d8 <acquire+0x5c>
    800035e8:	0ff0000f          	fence
    800035ec:	fffff097          	auipc	ra,0xfffff
    800035f0:	8a0080e7          	jalr	-1888(ra) # 80001e8c <mycpu>
    800035f4:	01813083          	ld	ra,24(sp)
    800035f8:	01013403          	ld	s0,16(sp)
    800035fc:	00a4b823          	sd	a0,16(s1)
    80003600:	00013903          	ld	s2,0(sp)
    80003604:	00813483          	ld	s1,8(sp)
    80003608:	02010113          	addi	sp,sp,32
    8000360c:	00008067          	ret
    80003610:	0104b903          	ld	s2,16(s1)
    80003614:	fffff097          	auipc	ra,0xfffff
    80003618:	878080e7          	jalr	-1928(ra) # 80001e8c <mycpu>
    8000361c:	faa91ce3          	bne	s2,a0,800035d4 <acquire+0x58>
    80003620:	00001517          	auipc	a0,0x1
    80003624:	b7850513          	addi	a0,a0,-1160 # 80004198 <digits+0x20>
    80003628:	fffff097          	auipc	ra,0xfffff
    8000362c:	224080e7          	jalr	548(ra) # 8000284c <panic>
    80003630:	00195913          	srli	s2,s2,0x1
    80003634:	fffff097          	auipc	ra,0xfffff
    80003638:	858080e7          	jalr	-1960(ra) # 80001e8c <mycpu>
    8000363c:	00197913          	andi	s2,s2,1
    80003640:	07252e23          	sw	s2,124(a0)
    80003644:	f75ff06f          	j	800035b8 <acquire+0x3c>

0000000080003648 <release>:
    80003648:	fe010113          	addi	sp,sp,-32
    8000364c:	00813823          	sd	s0,16(sp)
    80003650:	00113c23          	sd	ra,24(sp)
    80003654:	00913423          	sd	s1,8(sp)
    80003658:	01213023          	sd	s2,0(sp)
    8000365c:	02010413          	addi	s0,sp,32
    80003660:	00052783          	lw	a5,0(a0)
    80003664:	00079a63          	bnez	a5,80003678 <release+0x30>
    80003668:	00001517          	auipc	a0,0x1
    8000366c:	b3850513          	addi	a0,a0,-1224 # 800041a0 <digits+0x28>
    80003670:	fffff097          	auipc	ra,0xfffff
    80003674:	1dc080e7          	jalr	476(ra) # 8000284c <panic>
    80003678:	01053903          	ld	s2,16(a0)
    8000367c:	00050493          	mv	s1,a0
    80003680:	fffff097          	auipc	ra,0xfffff
    80003684:	80c080e7          	jalr	-2036(ra) # 80001e8c <mycpu>
    80003688:	fea910e3          	bne	s2,a0,80003668 <release+0x20>
    8000368c:	0004b823          	sd	zero,16(s1)
    80003690:	0ff0000f          	fence
    80003694:	0f50000f          	fence	iorw,ow
    80003698:	0804a02f          	amoswap.w	zero,zero,(s1)
    8000369c:	ffffe097          	auipc	ra,0xffffe
    800036a0:	7f0080e7          	jalr	2032(ra) # 80001e8c <mycpu>
    800036a4:	100027f3          	csrr	a5,sstatus
    800036a8:	0027f793          	andi	a5,a5,2
    800036ac:	04079a63          	bnez	a5,80003700 <release+0xb8>
    800036b0:	07852783          	lw	a5,120(a0)
    800036b4:	02f05e63          	blez	a5,800036f0 <release+0xa8>
    800036b8:	fff7871b          	addiw	a4,a5,-1
    800036bc:	06e52c23          	sw	a4,120(a0)
    800036c0:	00071c63          	bnez	a4,800036d8 <release+0x90>
    800036c4:	07c52783          	lw	a5,124(a0)
    800036c8:	00078863          	beqz	a5,800036d8 <release+0x90>
    800036cc:	100027f3          	csrr	a5,sstatus
    800036d0:	0027e793          	ori	a5,a5,2
    800036d4:	10079073          	csrw	sstatus,a5
    800036d8:	01813083          	ld	ra,24(sp)
    800036dc:	01013403          	ld	s0,16(sp)
    800036e0:	00813483          	ld	s1,8(sp)
    800036e4:	00013903          	ld	s2,0(sp)
    800036e8:	02010113          	addi	sp,sp,32
    800036ec:	00008067          	ret
    800036f0:	00001517          	auipc	a0,0x1
    800036f4:	ad050513          	addi	a0,a0,-1328 # 800041c0 <digits+0x48>
    800036f8:	fffff097          	auipc	ra,0xfffff
    800036fc:	154080e7          	jalr	340(ra) # 8000284c <panic>
    80003700:	00001517          	auipc	a0,0x1
    80003704:	aa850513          	addi	a0,a0,-1368 # 800041a8 <digits+0x30>
    80003708:	fffff097          	auipc	ra,0xfffff
    8000370c:	144080e7          	jalr	324(ra) # 8000284c <panic>

0000000080003710 <holding>:
    80003710:	00052783          	lw	a5,0(a0)
    80003714:	00079663          	bnez	a5,80003720 <holding+0x10>
    80003718:	00000513          	li	a0,0
    8000371c:	00008067          	ret
    80003720:	fe010113          	addi	sp,sp,-32
    80003724:	00813823          	sd	s0,16(sp)
    80003728:	00913423          	sd	s1,8(sp)
    8000372c:	00113c23          	sd	ra,24(sp)
    80003730:	02010413          	addi	s0,sp,32
    80003734:	01053483          	ld	s1,16(a0)
    80003738:	ffffe097          	auipc	ra,0xffffe
    8000373c:	754080e7          	jalr	1876(ra) # 80001e8c <mycpu>
    80003740:	01813083          	ld	ra,24(sp)
    80003744:	01013403          	ld	s0,16(sp)
    80003748:	40a48533          	sub	a0,s1,a0
    8000374c:	00153513          	seqz	a0,a0
    80003750:	00813483          	ld	s1,8(sp)
    80003754:	02010113          	addi	sp,sp,32
    80003758:	00008067          	ret

000000008000375c <push_off>:
    8000375c:	fe010113          	addi	sp,sp,-32
    80003760:	00813823          	sd	s0,16(sp)
    80003764:	00113c23          	sd	ra,24(sp)
    80003768:	00913423          	sd	s1,8(sp)
    8000376c:	02010413          	addi	s0,sp,32
    80003770:	100024f3          	csrr	s1,sstatus
    80003774:	100027f3          	csrr	a5,sstatus
    80003778:	ffd7f793          	andi	a5,a5,-3
    8000377c:	10079073          	csrw	sstatus,a5
    80003780:	ffffe097          	auipc	ra,0xffffe
    80003784:	70c080e7          	jalr	1804(ra) # 80001e8c <mycpu>
    80003788:	07852783          	lw	a5,120(a0)
    8000378c:	02078663          	beqz	a5,800037b8 <push_off+0x5c>
    80003790:	ffffe097          	auipc	ra,0xffffe
    80003794:	6fc080e7          	jalr	1788(ra) # 80001e8c <mycpu>
    80003798:	07852783          	lw	a5,120(a0)
    8000379c:	01813083          	ld	ra,24(sp)
    800037a0:	01013403          	ld	s0,16(sp)
    800037a4:	0017879b          	addiw	a5,a5,1
    800037a8:	06f52c23          	sw	a5,120(a0)
    800037ac:	00813483          	ld	s1,8(sp)
    800037b0:	02010113          	addi	sp,sp,32
    800037b4:	00008067          	ret
    800037b8:	0014d493          	srli	s1,s1,0x1
    800037bc:	ffffe097          	auipc	ra,0xffffe
    800037c0:	6d0080e7          	jalr	1744(ra) # 80001e8c <mycpu>
    800037c4:	0014f493          	andi	s1,s1,1
    800037c8:	06952e23          	sw	s1,124(a0)
    800037cc:	fc5ff06f          	j	80003790 <push_off+0x34>

00000000800037d0 <pop_off>:
    800037d0:	ff010113          	addi	sp,sp,-16
    800037d4:	00813023          	sd	s0,0(sp)
    800037d8:	00113423          	sd	ra,8(sp)
    800037dc:	01010413          	addi	s0,sp,16
    800037e0:	ffffe097          	auipc	ra,0xffffe
    800037e4:	6ac080e7          	jalr	1708(ra) # 80001e8c <mycpu>
    800037e8:	100027f3          	csrr	a5,sstatus
    800037ec:	0027f793          	andi	a5,a5,2
    800037f0:	04079663          	bnez	a5,8000383c <pop_off+0x6c>
    800037f4:	07852783          	lw	a5,120(a0)
    800037f8:	02f05a63          	blez	a5,8000382c <pop_off+0x5c>
    800037fc:	fff7871b          	addiw	a4,a5,-1
    80003800:	06e52c23          	sw	a4,120(a0)
    80003804:	00071c63          	bnez	a4,8000381c <pop_off+0x4c>
    80003808:	07c52783          	lw	a5,124(a0)
    8000380c:	00078863          	beqz	a5,8000381c <pop_off+0x4c>
    80003810:	100027f3          	csrr	a5,sstatus
    80003814:	0027e793          	ori	a5,a5,2
    80003818:	10079073          	csrw	sstatus,a5
    8000381c:	00813083          	ld	ra,8(sp)
    80003820:	00013403          	ld	s0,0(sp)
    80003824:	01010113          	addi	sp,sp,16
    80003828:	00008067          	ret
    8000382c:	00001517          	auipc	a0,0x1
    80003830:	99450513          	addi	a0,a0,-1644 # 800041c0 <digits+0x48>
    80003834:	fffff097          	auipc	ra,0xfffff
    80003838:	018080e7          	jalr	24(ra) # 8000284c <panic>
    8000383c:	00001517          	auipc	a0,0x1
    80003840:	96c50513          	addi	a0,a0,-1684 # 800041a8 <digits+0x30>
    80003844:	fffff097          	auipc	ra,0xfffff
    80003848:	008080e7          	jalr	8(ra) # 8000284c <panic>

000000008000384c <push_on>:
    8000384c:	fe010113          	addi	sp,sp,-32
    80003850:	00813823          	sd	s0,16(sp)
    80003854:	00113c23          	sd	ra,24(sp)
    80003858:	00913423          	sd	s1,8(sp)
    8000385c:	02010413          	addi	s0,sp,32
    80003860:	100024f3          	csrr	s1,sstatus
    80003864:	100027f3          	csrr	a5,sstatus
    80003868:	0027e793          	ori	a5,a5,2
    8000386c:	10079073          	csrw	sstatus,a5
    80003870:	ffffe097          	auipc	ra,0xffffe
    80003874:	61c080e7          	jalr	1564(ra) # 80001e8c <mycpu>
    80003878:	07852783          	lw	a5,120(a0)
    8000387c:	02078663          	beqz	a5,800038a8 <push_on+0x5c>
    80003880:	ffffe097          	auipc	ra,0xffffe
    80003884:	60c080e7          	jalr	1548(ra) # 80001e8c <mycpu>
    80003888:	07852783          	lw	a5,120(a0)
    8000388c:	01813083          	ld	ra,24(sp)
    80003890:	01013403          	ld	s0,16(sp)
    80003894:	0017879b          	addiw	a5,a5,1
    80003898:	06f52c23          	sw	a5,120(a0)
    8000389c:	00813483          	ld	s1,8(sp)
    800038a0:	02010113          	addi	sp,sp,32
    800038a4:	00008067          	ret
    800038a8:	0014d493          	srli	s1,s1,0x1
    800038ac:	ffffe097          	auipc	ra,0xffffe
    800038b0:	5e0080e7          	jalr	1504(ra) # 80001e8c <mycpu>
    800038b4:	0014f493          	andi	s1,s1,1
    800038b8:	06952e23          	sw	s1,124(a0)
    800038bc:	fc5ff06f          	j	80003880 <push_on+0x34>

00000000800038c0 <pop_on>:
    800038c0:	ff010113          	addi	sp,sp,-16
    800038c4:	00813023          	sd	s0,0(sp)
    800038c8:	00113423          	sd	ra,8(sp)
    800038cc:	01010413          	addi	s0,sp,16
    800038d0:	ffffe097          	auipc	ra,0xffffe
    800038d4:	5bc080e7          	jalr	1468(ra) # 80001e8c <mycpu>
    800038d8:	100027f3          	csrr	a5,sstatus
    800038dc:	0027f793          	andi	a5,a5,2
    800038e0:	04078463          	beqz	a5,80003928 <pop_on+0x68>
    800038e4:	07852783          	lw	a5,120(a0)
    800038e8:	02f05863          	blez	a5,80003918 <pop_on+0x58>
    800038ec:	fff7879b          	addiw	a5,a5,-1
    800038f0:	06f52c23          	sw	a5,120(a0)
    800038f4:	07853783          	ld	a5,120(a0)
    800038f8:	00079863          	bnez	a5,80003908 <pop_on+0x48>
    800038fc:	100027f3          	csrr	a5,sstatus
    80003900:	ffd7f793          	andi	a5,a5,-3
    80003904:	10079073          	csrw	sstatus,a5
    80003908:	00813083          	ld	ra,8(sp)
    8000390c:	00013403          	ld	s0,0(sp)
    80003910:	01010113          	addi	sp,sp,16
    80003914:	00008067          	ret
    80003918:	00001517          	auipc	a0,0x1
    8000391c:	8d050513          	addi	a0,a0,-1840 # 800041e8 <digits+0x70>
    80003920:	fffff097          	auipc	ra,0xfffff
    80003924:	f2c080e7          	jalr	-212(ra) # 8000284c <panic>
    80003928:	00001517          	auipc	a0,0x1
    8000392c:	8a050513          	addi	a0,a0,-1888 # 800041c8 <digits+0x50>
    80003930:	fffff097          	auipc	ra,0xfffff
    80003934:	f1c080e7          	jalr	-228(ra) # 8000284c <panic>

0000000080003938 <__memset>:
    80003938:	ff010113          	addi	sp,sp,-16
    8000393c:	00813423          	sd	s0,8(sp)
    80003940:	01010413          	addi	s0,sp,16
    80003944:	1a060e63          	beqz	a2,80003b00 <__memset+0x1c8>
    80003948:	40a007b3          	neg	a5,a0
    8000394c:	0077f793          	andi	a5,a5,7
    80003950:	00778693          	addi	a3,a5,7
    80003954:	00b00813          	li	a6,11
    80003958:	0ff5f593          	andi	a1,a1,255
    8000395c:	fff6071b          	addiw	a4,a2,-1
    80003960:	1b06e663          	bltu	a3,a6,80003b0c <__memset+0x1d4>
    80003964:	1cd76463          	bltu	a4,a3,80003b2c <__memset+0x1f4>
    80003968:	1a078e63          	beqz	a5,80003b24 <__memset+0x1ec>
    8000396c:	00b50023          	sb	a1,0(a0)
    80003970:	00100713          	li	a4,1
    80003974:	1ae78463          	beq	a5,a4,80003b1c <__memset+0x1e4>
    80003978:	00b500a3          	sb	a1,1(a0)
    8000397c:	00200713          	li	a4,2
    80003980:	1ae78a63          	beq	a5,a4,80003b34 <__memset+0x1fc>
    80003984:	00b50123          	sb	a1,2(a0)
    80003988:	00300713          	li	a4,3
    8000398c:	18e78463          	beq	a5,a4,80003b14 <__memset+0x1dc>
    80003990:	00b501a3          	sb	a1,3(a0)
    80003994:	00400713          	li	a4,4
    80003998:	1ae78263          	beq	a5,a4,80003b3c <__memset+0x204>
    8000399c:	00b50223          	sb	a1,4(a0)
    800039a0:	00500713          	li	a4,5
    800039a4:	1ae78063          	beq	a5,a4,80003b44 <__memset+0x20c>
    800039a8:	00b502a3          	sb	a1,5(a0)
    800039ac:	00700713          	li	a4,7
    800039b0:	18e79e63          	bne	a5,a4,80003b4c <__memset+0x214>
    800039b4:	00b50323          	sb	a1,6(a0)
    800039b8:	00700e93          	li	t4,7
    800039bc:	00859713          	slli	a4,a1,0x8
    800039c0:	00e5e733          	or	a4,a1,a4
    800039c4:	01059e13          	slli	t3,a1,0x10
    800039c8:	01c76e33          	or	t3,a4,t3
    800039cc:	01859313          	slli	t1,a1,0x18
    800039d0:	006e6333          	or	t1,t3,t1
    800039d4:	02059893          	slli	a7,a1,0x20
    800039d8:	40f60e3b          	subw	t3,a2,a5
    800039dc:	011368b3          	or	a7,t1,a7
    800039e0:	02859813          	slli	a6,a1,0x28
    800039e4:	0108e833          	or	a6,a7,a6
    800039e8:	03059693          	slli	a3,a1,0x30
    800039ec:	003e589b          	srliw	a7,t3,0x3
    800039f0:	00d866b3          	or	a3,a6,a3
    800039f4:	03859713          	slli	a4,a1,0x38
    800039f8:	00389813          	slli	a6,a7,0x3
    800039fc:	00f507b3          	add	a5,a0,a5
    80003a00:	00e6e733          	or	a4,a3,a4
    80003a04:	000e089b          	sext.w	a7,t3
    80003a08:	00f806b3          	add	a3,a6,a5
    80003a0c:	00e7b023          	sd	a4,0(a5)
    80003a10:	00878793          	addi	a5,a5,8
    80003a14:	fed79ce3          	bne	a5,a3,80003a0c <__memset+0xd4>
    80003a18:	ff8e7793          	andi	a5,t3,-8
    80003a1c:	0007871b          	sext.w	a4,a5
    80003a20:	01d787bb          	addw	a5,a5,t4
    80003a24:	0ce88e63          	beq	a7,a4,80003b00 <__memset+0x1c8>
    80003a28:	00f50733          	add	a4,a0,a5
    80003a2c:	00b70023          	sb	a1,0(a4)
    80003a30:	0017871b          	addiw	a4,a5,1
    80003a34:	0cc77663          	bgeu	a4,a2,80003b00 <__memset+0x1c8>
    80003a38:	00e50733          	add	a4,a0,a4
    80003a3c:	00b70023          	sb	a1,0(a4)
    80003a40:	0027871b          	addiw	a4,a5,2
    80003a44:	0ac77e63          	bgeu	a4,a2,80003b00 <__memset+0x1c8>
    80003a48:	00e50733          	add	a4,a0,a4
    80003a4c:	00b70023          	sb	a1,0(a4)
    80003a50:	0037871b          	addiw	a4,a5,3
    80003a54:	0ac77663          	bgeu	a4,a2,80003b00 <__memset+0x1c8>
    80003a58:	00e50733          	add	a4,a0,a4
    80003a5c:	00b70023          	sb	a1,0(a4)
    80003a60:	0047871b          	addiw	a4,a5,4
    80003a64:	08c77e63          	bgeu	a4,a2,80003b00 <__memset+0x1c8>
    80003a68:	00e50733          	add	a4,a0,a4
    80003a6c:	00b70023          	sb	a1,0(a4)
    80003a70:	0057871b          	addiw	a4,a5,5
    80003a74:	08c77663          	bgeu	a4,a2,80003b00 <__memset+0x1c8>
    80003a78:	00e50733          	add	a4,a0,a4
    80003a7c:	00b70023          	sb	a1,0(a4)
    80003a80:	0067871b          	addiw	a4,a5,6
    80003a84:	06c77e63          	bgeu	a4,a2,80003b00 <__memset+0x1c8>
    80003a88:	00e50733          	add	a4,a0,a4
    80003a8c:	00b70023          	sb	a1,0(a4)
    80003a90:	0077871b          	addiw	a4,a5,7
    80003a94:	06c77663          	bgeu	a4,a2,80003b00 <__memset+0x1c8>
    80003a98:	00e50733          	add	a4,a0,a4
    80003a9c:	00b70023          	sb	a1,0(a4)
    80003aa0:	0087871b          	addiw	a4,a5,8
    80003aa4:	04c77e63          	bgeu	a4,a2,80003b00 <__memset+0x1c8>
    80003aa8:	00e50733          	add	a4,a0,a4
    80003aac:	00b70023          	sb	a1,0(a4)
    80003ab0:	0097871b          	addiw	a4,a5,9
    80003ab4:	04c77663          	bgeu	a4,a2,80003b00 <__memset+0x1c8>
    80003ab8:	00e50733          	add	a4,a0,a4
    80003abc:	00b70023          	sb	a1,0(a4)
    80003ac0:	00a7871b          	addiw	a4,a5,10
    80003ac4:	02c77e63          	bgeu	a4,a2,80003b00 <__memset+0x1c8>
    80003ac8:	00e50733          	add	a4,a0,a4
    80003acc:	00b70023          	sb	a1,0(a4)
    80003ad0:	00b7871b          	addiw	a4,a5,11
    80003ad4:	02c77663          	bgeu	a4,a2,80003b00 <__memset+0x1c8>
    80003ad8:	00e50733          	add	a4,a0,a4
    80003adc:	00b70023          	sb	a1,0(a4)
    80003ae0:	00c7871b          	addiw	a4,a5,12
    80003ae4:	00c77e63          	bgeu	a4,a2,80003b00 <__memset+0x1c8>
    80003ae8:	00e50733          	add	a4,a0,a4
    80003aec:	00b70023          	sb	a1,0(a4)
    80003af0:	00d7879b          	addiw	a5,a5,13
    80003af4:	00c7f663          	bgeu	a5,a2,80003b00 <__memset+0x1c8>
    80003af8:	00f507b3          	add	a5,a0,a5
    80003afc:	00b78023          	sb	a1,0(a5)
    80003b00:	00813403          	ld	s0,8(sp)
    80003b04:	01010113          	addi	sp,sp,16
    80003b08:	00008067          	ret
    80003b0c:	00b00693          	li	a3,11
    80003b10:	e55ff06f          	j	80003964 <__memset+0x2c>
    80003b14:	00300e93          	li	t4,3
    80003b18:	ea5ff06f          	j	800039bc <__memset+0x84>
    80003b1c:	00100e93          	li	t4,1
    80003b20:	e9dff06f          	j	800039bc <__memset+0x84>
    80003b24:	00000e93          	li	t4,0
    80003b28:	e95ff06f          	j	800039bc <__memset+0x84>
    80003b2c:	00000793          	li	a5,0
    80003b30:	ef9ff06f          	j	80003a28 <__memset+0xf0>
    80003b34:	00200e93          	li	t4,2
    80003b38:	e85ff06f          	j	800039bc <__memset+0x84>
    80003b3c:	00400e93          	li	t4,4
    80003b40:	e7dff06f          	j	800039bc <__memset+0x84>
    80003b44:	00500e93          	li	t4,5
    80003b48:	e75ff06f          	j	800039bc <__memset+0x84>
    80003b4c:	00600e93          	li	t4,6
    80003b50:	e6dff06f          	j	800039bc <__memset+0x84>

0000000080003b54 <__memmove>:
    80003b54:	ff010113          	addi	sp,sp,-16
    80003b58:	00813423          	sd	s0,8(sp)
    80003b5c:	01010413          	addi	s0,sp,16
    80003b60:	0e060863          	beqz	a2,80003c50 <__memmove+0xfc>
    80003b64:	fff6069b          	addiw	a3,a2,-1
    80003b68:	0006881b          	sext.w	a6,a3
    80003b6c:	0ea5e863          	bltu	a1,a0,80003c5c <__memmove+0x108>
    80003b70:	00758713          	addi	a4,a1,7
    80003b74:	00a5e7b3          	or	a5,a1,a0
    80003b78:	40a70733          	sub	a4,a4,a0
    80003b7c:	0077f793          	andi	a5,a5,7
    80003b80:	00f73713          	sltiu	a4,a4,15
    80003b84:	00174713          	xori	a4,a4,1
    80003b88:	0017b793          	seqz	a5,a5
    80003b8c:	00e7f7b3          	and	a5,a5,a4
    80003b90:	10078863          	beqz	a5,80003ca0 <__memmove+0x14c>
    80003b94:	00900793          	li	a5,9
    80003b98:	1107f463          	bgeu	a5,a6,80003ca0 <__memmove+0x14c>
    80003b9c:	0036581b          	srliw	a6,a2,0x3
    80003ba0:	fff8081b          	addiw	a6,a6,-1
    80003ba4:	02081813          	slli	a6,a6,0x20
    80003ba8:	01d85893          	srli	a7,a6,0x1d
    80003bac:	00858813          	addi	a6,a1,8
    80003bb0:	00058793          	mv	a5,a1
    80003bb4:	00050713          	mv	a4,a0
    80003bb8:	01088833          	add	a6,a7,a6
    80003bbc:	0007b883          	ld	a7,0(a5)
    80003bc0:	00878793          	addi	a5,a5,8
    80003bc4:	00870713          	addi	a4,a4,8
    80003bc8:	ff173c23          	sd	a7,-8(a4)
    80003bcc:	ff0798e3          	bne	a5,a6,80003bbc <__memmove+0x68>
    80003bd0:	ff867713          	andi	a4,a2,-8
    80003bd4:	02071793          	slli	a5,a4,0x20
    80003bd8:	0207d793          	srli	a5,a5,0x20
    80003bdc:	00f585b3          	add	a1,a1,a5
    80003be0:	40e686bb          	subw	a3,a3,a4
    80003be4:	00f507b3          	add	a5,a0,a5
    80003be8:	06e60463          	beq	a2,a4,80003c50 <__memmove+0xfc>
    80003bec:	0005c703          	lbu	a4,0(a1)
    80003bf0:	00e78023          	sb	a4,0(a5)
    80003bf4:	04068e63          	beqz	a3,80003c50 <__memmove+0xfc>
    80003bf8:	0015c603          	lbu	a2,1(a1)
    80003bfc:	00100713          	li	a4,1
    80003c00:	00c780a3          	sb	a2,1(a5)
    80003c04:	04e68663          	beq	a3,a4,80003c50 <__memmove+0xfc>
    80003c08:	0025c603          	lbu	a2,2(a1)
    80003c0c:	00200713          	li	a4,2
    80003c10:	00c78123          	sb	a2,2(a5)
    80003c14:	02e68e63          	beq	a3,a4,80003c50 <__memmove+0xfc>
    80003c18:	0035c603          	lbu	a2,3(a1)
    80003c1c:	00300713          	li	a4,3
    80003c20:	00c781a3          	sb	a2,3(a5)
    80003c24:	02e68663          	beq	a3,a4,80003c50 <__memmove+0xfc>
    80003c28:	0045c603          	lbu	a2,4(a1)
    80003c2c:	00400713          	li	a4,4
    80003c30:	00c78223          	sb	a2,4(a5)
    80003c34:	00e68e63          	beq	a3,a4,80003c50 <__memmove+0xfc>
    80003c38:	0055c603          	lbu	a2,5(a1)
    80003c3c:	00500713          	li	a4,5
    80003c40:	00c782a3          	sb	a2,5(a5)
    80003c44:	00e68663          	beq	a3,a4,80003c50 <__memmove+0xfc>
    80003c48:	0065c703          	lbu	a4,6(a1)
    80003c4c:	00e78323          	sb	a4,6(a5)
    80003c50:	00813403          	ld	s0,8(sp)
    80003c54:	01010113          	addi	sp,sp,16
    80003c58:	00008067          	ret
    80003c5c:	02061713          	slli	a4,a2,0x20
    80003c60:	02075713          	srli	a4,a4,0x20
    80003c64:	00e587b3          	add	a5,a1,a4
    80003c68:	f0f574e3          	bgeu	a0,a5,80003b70 <__memmove+0x1c>
    80003c6c:	02069613          	slli	a2,a3,0x20
    80003c70:	02065613          	srli	a2,a2,0x20
    80003c74:	fff64613          	not	a2,a2
    80003c78:	00e50733          	add	a4,a0,a4
    80003c7c:	00c78633          	add	a2,a5,a2
    80003c80:	fff7c683          	lbu	a3,-1(a5)
    80003c84:	fff78793          	addi	a5,a5,-1
    80003c88:	fff70713          	addi	a4,a4,-1
    80003c8c:	00d70023          	sb	a3,0(a4)
    80003c90:	fec798e3          	bne	a5,a2,80003c80 <__memmove+0x12c>
    80003c94:	00813403          	ld	s0,8(sp)
    80003c98:	01010113          	addi	sp,sp,16
    80003c9c:	00008067          	ret
    80003ca0:	02069713          	slli	a4,a3,0x20
    80003ca4:	02075713          	srli	a4,a4,0x20
    80003ca8:	00170713          	addi	a4,a4,1
    80003cac:	00e50733          	add	a4,a0,a4
    80003cb0:	00050793          	mv	a5,a0
    80003cb4:	0005c683          	lbu	a3,0(a1)
    80003cb8:	00178793          	addi	a5,a5,1
    80003cbc:	00158593          	addi	a1,a1,1
    80003cc0:	fed78fa3          	sb	a3,-1(a5)
    80003cc4:	fee798e3          	bne	a5,a4,80003cb4 <__memmove+0x160>
    80003cc8:	f89ff06f          	j	80003c50 <__memmove+0xfc>

0000000080003ccc <__putc>:
    80003ccc:	fe010113          	addi	sp,sp,-32
    80003cd0:	00813823          	sd	s0,16(sp)
    80003cd4:	00113c23          	sd	ra,24(sp)
    80003cd8:	02010413          	addi	s0,sp,32
    80003cdc:	00050793          	mv	a5,a0
    80003ce0:	fef40593          	addi	a1,s0,-17
    80003ce4:	00100613          	li	a2,1
    80003ce8:	00000513          	li	a0,0
    80003cec:	fef407a3          	sb	a5,-17(s0)
    80003cf0:	fffff097          	auipc	ra,0xfffff
    80003cf4:	b3c080e7          	jalr	-1220(ra) # 8000282c <console_write>
    80003cf8:	01813083          	ld	ra,24(sp)
    80003cfc:	01013403          	ld	s0,16(sp)
    80003d00:	02010113          	addi	sp,sp,32
    80003d04:	00008067          	ret

0000000080003d08 <__getc>:
    80003d08:	fe010113          	addi	sp,sp,-32
    80003d0c:	00813823          	sd	s0,16(sp)
    80003d10:	00113c23          	sd	ra,24(sp)
    80003d14:	02010413          	addi	s0,sp,32
    80003d18:	fe840593          	addi	a1,s0,-24
    80003d1c:	00100613          	li	a2,1
    80003d20:	00000513          	li	a0,0
    80003d24:	fffff097          	auipc	ra,0xfffff
    80003d28:	ae8080e7          	jalr	-1304(ra) # 8000280c <console_read>
    80003d2c:	fe844503          	lbu	a0,-24(s0)
    80003d30:	01813083          	ld	ra,24(sp)
    80003d34:	01013403          	ld	s0,16(sp)
    80003d38:	02010113          	addi	sp,sp,32
    80003d3c:	00008067          	ret

0000000080003d40 <console_handler>:
    80003d40:	fe010113          	addi	sp,sp,-32
    80003d44:	00813823          	sd	s0,16(sp)
    80003d48:	00113c23          	sd	ra,24(sp)
    80003d4c:	00913423          	sd	s1,8(sp)
    80003d50:	02010413          	addi	s0,sp,32
    80003d54:	14202773          	csrr	a4,scause
    80003d58:	100027f3          	csrr	a5,sstatus
    80003d5c:	0027f793          	andi	a5,a5,2
    80003d60:	06079e63          	bnez	a5,80003ddc <console_handler+0x9c>
    80003d64:	00074c63          	bltz	a4,80003d7c <console_handler+0x3c>
    80003d68:	01813083          	ld	ra,24(sp)
    80003d6c:	01013403          	ld	s0,16(sp)
    80003d70:	00813483          	ld	s1,8(sp)
    80003d74:	02010113          	addi	sp,sp,32
    80003d78:	00008067          	ret
    80003d7c:	0ff77713          	andi	a4,a4,255
    80003d80:	00900793          	li	a5,9
    80003d84:	fef712e3          	bne	a4,a5,80003d68 <console_handler+0x28>
    80003d88:	ffffe097          	auipc	ra,0xffffe
    80003d8c:	6dc080e7          	jalr	1756(ra) # 80002464 <plic_claim>
    80003d90:	00a00793          	li	a5,10
    80003d94:	00050493          	mv	s1,a0
    80003d98:	02f50c63          	beq	a0,a5,80003dd0 <console_handler+0x90>
    80003d9c:	fc0506e3          	beqz	a0,80003d68 <console_handler+0x28>
    80003da0:	00050593          	mv	a1,a0
    80003da4:	00000517          	auipc	a0,0x0
    80003da8:	34c50513          	addi	a0,a0,844 # 800040f0 <CONSOLE_STATUS+0xd8>
    80003dac:	fffff097          	auipc	ra,0xfffff
    80003db0:	afc080e7          	jalr	-1284(ra) # 800028a8 <__printf>
    80003db4:	01013403          	ld	s0,16(sp)
    80003db8:	01813083          	ld	ra,24(sp)
    80003dbc:	00048513          	mv	a0,s1
    80003dc0:	00813483          	ld	s1,8(sp)
    80003dc4:	02010113          	addi	sp,sp,32
    80003dc8:	ffffe317          	auipc	t1,0xffffe
    80003dcc:	6d430067          	jr	1748(t1) # 8000249c <plic_complete>
    80003dd0:	fffff097          	auipc	ra,0xfffff
    80003dd4:	3e0080e7          	jalr	992(ra) # 800031b0 <uartintr>
    80003dd8:	fddff06f          	j	80003db4 <console_handler+0x74>
    80003ddc:	00000517          	auipc	a0,0x0
    80003de0:	41450513          	addi	a0,a0,1044 # 800041f0 <digits+0x78>
    80003de4:	fffff097          	auipc	ra,0xfffff
    80003de8:	a68080e7          	jalr	-1432(ra) # 8000284c <panic>
	...
