//
// Created by os on 4/12/23.
//
#include "../h/kern_buddyAllocator.hpp"
#include "../h/printing.hpp"

#define MINBBSIZE (1<<5)
#define MAXBBSIZE (1<<17)
#define DESCRIPTOR_SIZE 32


typedef struct bba_block {
    struct bba_block* next;
    int n;
    char* addr;
} bba_block_t;


bba_block_t* buddyBlocks[18];
bba_block_t* bba_allocatedBlocks;

char* buddyMemStart;
char* buddyMemEnd;


void bba_print_used_blocks_info()
{
    bba_block_t * curr = bba_allocatedBlocks;
    while (curr){
        printf("\nBlock of size %d is allocated on addr start+%lx and its descriptor is located at start+%lx (%lx), ends at start+%lx", curr->n, curr->addr-buddyMemStart, (char*)curr-buddyMemStart,curr,curr->addr-buddyMemStart+(1<<curr->n));
        curr=curr->next;
    }
}

void bba_print_free_blocks_info()
{
    printf("\n BLOCK INFO");
    for (int i=0;i<18;i++){
        bba_block_t* p = buddyBlocks[i];
        while (p!=0){
            printf("\n block of size %d (n=%d) at address start+%p (%p), ends at start+%p",(1<<i), i, (char*)p-buddyMemStart,p,(char*)p-buddyMemStart+(1<<i));
            p=p->next;
        }
    }
}
void bba_init(char* start, char *end)
{

    //printf("\noldStart: %ld", (long)start);
    if((long)start%MINBBSIZE!=0) start = (char*) (( ((long)start / MINBBSIZE) +1)*MINBBSIZE); //align start to MINBBSIZE
    if((long)end%MINBBSIZE!=0) end = (char*) (( ((long)end / MINBBSIZE) -1)*MINBBSIZE); //align end to MINBBSIZE
    //printf("\nstart: %ld", (long)start);
    //printf("\nend: %ld", (long)end);
    buddyMemStart=start;
    buddyMemEnd=end;

    printf("\nspace size=%d", end-start);

    for(int i=0;i<17;i++){
        buddyBlocks[i] = 0;
    }

    char* a = start;

    int allocatedSize = 0;
    while(a<end){
        //printf("\n a=%ld",(long)a);
        int n=5;
        while(a+(1<<n)<=end && n<18) n++; // maximum block size is 2^17
        n--;

        bba_block_t *newBlock = (bba_block_t*) a;
        newBlock->n=n;
        newBlock->next=buddyBlocks[n];
        buddyBlocks[n] = newBlock; //ulancavamo novi blok na pocetak liste

        //printf("\n n=%d, block of size %ld allocated at %ld",n,(1<<n), (long)a);
        allocatedSize+=(1<<n);
        a+=(1<<n);
    }


    printf("\nallocatedSize=%d\n",allocatedSize);
    //bba_print_free_blocks_info();
}

void bba_split(int n) //blok velicine n deli na 2 velicine n-1, ne alocira nista, ulancava oba nova bloka
{
    if(n==0) return;
    bba_block_t* addr = buddyBlocks[n];
    if(addr==0){
        printf("\ncant split block of size %d, there are no blocks of that size",n);
        return;
    }
    //printf("\nsplitting block of size %d into two smaller blocks...",n);
    buddyBlocks[n] = addr->next; //izbacujemo
    bba_block_t* half = (bba_block_t*) ((long )addr+(1<<(n-1))); //polovina starog bloka
    half->n=n-1;
    addr->n=n-1;
    half->next=buddyBlocks[n-1];
    addr->next=half;
    buddyBlocks[n-1]=addr;
}

//nalazi ili kreira i vraca blok velicine 2^n
bba_block_t * bba_get_block(int size)
{
    if(size<MINBBSIZE) size=MINBBSIZE;
    if(size>MAXBBSIZE) return 0;
    int n=5;
    while((1<<n)<size && n<18) n++;

    if(buddyBlocks[n]!=0){ //imamo blok tacno te velicine
        return buddyBlocks[n];
    }

    //nemamo blok te velicine, treba podeliti neki veci blok
    for(int i=n+1;i<18;i++){
        if(buddyBlocks[i]!=0){
            while(i>n){
                bba_split(i);
                i--;
            }
            //zavrsicemo sa dva bloka velicine n, vracamo onaj na manjoj adresi
            return buddyBlocks[n];
        }
    }

    return 0;
}

int bba_can_allocate(int n)
{
    int index=0;

    //mozemo li smestiti blok
    for(int i=n;i<18;i++){
        if(buddyBlocks[i]!=0) {
            if(i>n) return 1;
            index=i;
            break;
        }
    }

    //za svakio alocirani blok pravimo i jedan mali blok (deskriptor) sa metapodacima - ovde proveravamo da li imamo
    // mesta i za taj mali blok
    for(int i=5;i<18;i++){
        if(buddyBlocks[i]!=0){
            if(i!=index || buddyBlocks[i]->next!=0) return 1;
        }
    }

    printf("\n alloc error - cant allocate");
    return 0;
}

void* bba_allocate(unsigned long size)
{

    if(size<MINBBSIZE) size=MINBBSIZE;
    if(size>MAXBBSIZE) return 0;
    int n=5;
    while((1UL<<n)<size && n<18) n++;


    if(bba_can_allocate(n)==0) return 0;

    bba_block_t *newBlock=0;
    bba_block_t *descriptor=0;

    newBlock = bba_get_block(size);
    buddyBlocks[n] = newBlock->next;

    descriptor = bba_get_block(sizeof(bba_block_t));
    buddyBlocks[5] = descriptor->next;


    //ulancavamo deskriptor
    descriptor->next=bba_allocatedBlocks;
    bba_allocatedBlocks=descriptor;
    descriptor->n=n;
    descriptor->addr=(char*)newBlock;

    return newBlock;

}

/*
 * ako moze da spoji, izlancava ukrupnjeni blok (prosledjeni blok nije ni bio ulancan ) i vraca adresu ukrupnjenog bloka, ako ne moze vraca null
 */
bba_block_t * bba_try_merge_single_block(bba_block_t* freedBlock, int n)
{
    long size = (1<<n);
    bba_block_t *curr = buddyBlocks[n];
    bba_block_t *prev=0;

    int odd = (((char*)freedBlock-buddyMemStart)/size)%2;

    while (curr!=0){
        if(odd==1 && (long)curr+size==(long)freedBlock){
            if(prev!=0) prev->next=curr->next;
            else buddyBlocks[n]=curr->next;
            return curr;
        }
        if(odd==0 && (long)curr-size==(long)freedBlock){
            if(prev!=0) prev->next=curr->next;
            else buddyBlocks[n]=curr->next;
            return freedBlock;
        }
        prev=curr;
        curr=curr->next;
    }
    return 0;
}

void bba_merge_blocks(bba_block_t* freedBlock, int n)
{
    bba_block_t * mergedBlock = 0;
    while (n<17){
        mergedBlock=bba_try_merge_single_block(freedBlock,n);
        if(mergedBlock==0){
            break;
        }
        n++;
        freedBlock=mergedBlock;
    }

    freedBlock->n=n;
    freedBlock->next=buddyBlocks[n];
    buddyBlocks[n]=freedBlock;
}

bba_block_t *bba_find_descriptor(const void*addr)
{
    bba_block_t *curr = bba_allocatedBlocks;
    while (curr){
        if(curr->addr==addr) return curr;
        curr=curr->next;
    }
    return 0;
}

void bba_unlink_descriptor(bba_block_t* descriptor){
    bba_block_t *curr = bba_allocatedBlocks;
    bba_block_t *prev = 0;
    while (curr!=descriptor){
        prev=curr;
        curr=curr->next;
    }
    if(prev!=0){
        prev->next=curr->next;
    } else{
        bba_allocatedBlocks=curr->next;
    }
}

void bba_free_block(const void* addr)
{
    bba_block_t * descriptor = bba_find_descriptor(addr);
    if(descriptor==0) printf("\nERROR (bba_free_block): Cant find descriptor");
    int n = descriptor->n;

    bba_block_t *freedBlock = (bba_block_t*) addr;
    bba_merge_blocks(freedBlock,n);

    bba_unlink_descriptor(descriptor);
    bba_merge_blocks(descriptor,5);
}
