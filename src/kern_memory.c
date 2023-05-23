//
// Created by os on 5/17/23.
//

#include "../h/kern_defs.h"
#include "../lib/hw.h"


typedef struct mem_block {
    int sizeInBlocks;
    int startingBlock;
    struct mem_block* next;
} mem_block_s;


mem_block_s * freeHead;


void* kern_mem_alloc(int sizeInBlocks)
{
    mem_block_s *curr = freeHead;
    mem_block_s *prev = 0;

    while (curr){
        if(curr->sizeInBlocks==sizeInBlocks+1){
            if(curr==freeHead) freeHead=curr->next;
            else prev->next = curr->next;
            curr->sizeInBlocks=sizeInBlocks+1;
            return (curr+MEM_BLOCK_SIZE);
        }
        else if(curr->sizeInBlocks>sizeInBlocks+1){
            mem_block_s* newFreeBlock = curr+(sizeInBlocks+1)*MEM_BLOCK_SIZE;
            newFreeBlock->sizeInBlocks = curr->sizeInBlocks-sizeInBlocks-1;
            newFreeBlock->startingBlock=curr->startingBlock+sizeInBlocks+1;
            newFreeBlock->next = curr->next;
            if(curr==freeHead) freeHead=newFreeBlock;
            else prev->next=newFreeBlock;
            curr->sizeInBlocks=sizeInBlocks+1;
            return (curr+MEM_BLOCK_SIZE);
        }
        prev=curr;
        curr=curr->next;
    }

    return 0;
}

int kern_mem_free(void* addr)
{
    mem_block_s* freedBlock = (mem_block_s*) addr-MEM_BLOCK_SIZE;
    mem_block_s* curr=freeHead;
    mem_block_s * prev =0;

    while (curr<freedBlock && curr!=0){
        prev=curr;
        curr=curr->next;
    }

    /*
    //kast radi lakse aritmetike
    char* cfreedBlock = (char *)freedBlock;
    char* cprev = (char *)prev;
    char* ccurr = (char *)curr;
    */

    if(prev){
        if(prev->startingBlock+prev->sizeInBlocks==freedBlock->startingBlock){
            prev->sizeInBlocks+=freedBlock->sizeInBlocks;
            freedBlock=prev;
        } else {
            prev->next=freedBlock;
        }
    }
    else freeHead=freedBlock;

    if(curr){
        if(freedBlock->startingBlock+freedBlock->sizeInBlocks==curr->startingBlock){
            freedBlock->sizeInBlocks+=curr->sizeInBlocks;
            freedBlock->next=curr->next;
        } else{
          freedBlock->next=curr;
        }
    }


    return 0;
}

void kern_mem_init(void* start, void* end)
{
    unsigned long lstart = (unsigned long) start;
    unsigned long lend = (unsigned long) end;

    if(lstart%MEM_BLOCK_SIZE>0) start =(void*) ((lstart/MEM_BLOCK_SIZE+1)*MEM_BLOCK_SIZE);
    if(lend%MEM_BLOCK_SIZE>0) end =(void*) ((lend/MEM_BLOCK_SIZE)*MEM_BLOCK_SIZE);

    freeHead = (mem_block_s*)start;
    freeHead->next=0;
    freeHead->startingBlock=0;
    freeHead->sizeInBlocks = (end-start)/MEM_BLOCK_SIZE;
}
