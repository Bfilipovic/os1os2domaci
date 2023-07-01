#include "../h/kern_slab.hpp"
#include "../h/printing.hpp"

#define KMEM_SLAB_SIZE (1<<14)

#define SLOT_INITIALIZED (1)
#define SLOT_FREE (1)
#define SLOT_TAKEN (0)

#define SMALL_SIZE 64
#define LARGE_SIZE 256

#define SMALL_SLAB (1*BLOCK_SIZE)
#define MEDIUM_SLAB (2*BLOCK_SIZE)
#define LARGE_SLAB (4*BLOCK_SIZE)

#define ALLOCATION_CHUNK_SIZE 16

kmem_cache_t *kmem_cache_head;


void kmem_strcpy(char* dst, const char* src) {
    int i = 0;
    while (src[i] != '\0' && i < 15) {
        dst[i] = src[i];
        i++;
    }
    dst[i] = '\0';
}

void kmem_init(void *space, int block_num)
{
    bba_init((char*)space,(char*)space+block_num*BLOCK_SIZE);
    kmem_cache_head=0;
}

static inline int getBitmapValue(char* bitmapStart,int position){
    int wordPosition = position/8;
    return (bitmapStart[wordPosition]>>position)&1;
}

static inline void setBitmapValue(char* bitmapStart,int position,int value){
    int wordPosition = position/8;
    int bitPosition = position%8;
    if(value==0){
        bitmapStart[wordPosition] = bitmapStart[wordPosition] & (~(1<<bitPosition));
    }
    else {
        bitmapStart[wordPosition] = bitmapStart[wordPosition] | (1<<bitPosition);
    }
}

//creates a slab, adds it to cache list, initializes up to ALLOCATION_CHUNK_SIZE objs if needed
kmem_slab_t *kmem_slab_init(kmem_cache_t* cache)
{
    void* memory = bba_allocate(cache->memorySize);
    if(memory==0) return 0;

    int bitmapCharCount = (cache->slotsInSlab+8-1)/8;
    int descriptorSize = sizeof(kmem_slab_t) + bitmapCharCount*2;
    kmem_slab_t *slab = (kmem_slab_t*) bba_allocate(descriptorSize);
    if(slab==0){
        bba_free_block(memory);
        return 0;
    }

    slab->memory=memory;
    slab->freeSlotsBitmap = (char*)slab + sizeof(kmem_slab_t);
    slab->initializedSlotsBitmap = slab->freeSlotsBitmap + bitmapCharCount;
    slab->usedSlotsCount=0;
    slab->initializedSlotsCount=0;
    slab->nextSlab=0;


    //marks all slots as free, if ctor is provided initializes objects in slab, but no more than ALLOCATION_CHUNK_SIZE objects
    for (int i = 0; i < cache->slotsInSlab; i++) {
        char *curr = (char*)memory + i * cache->slotSize;
        if (cache->ctor!=0 && i < ALLOCATION_CHUNK_SIZE) {
            cache->ctor(curr);
            slab->initializedSlotsCount++;
            setBitmapValue(slab->initializedSlotsBitmap, i, SLOT_INITIALIZED);
        }
        setBitmapValue(slab->freeSlotsBitmap, i, SLOT_FREE);
    }

    return slab;
}

//creates cache with one empty slab
kmem_cache_t *kmem_cache_create(const char *name, unsigned long size,void (*ctor)(void *),void (*dtor)(void *))
{
    kmem_cache_t* cache = (kmem_cache_t*) bba_allocate(sizeof(kmem_cache_t));
    if(cache==0) return 0;

    if(size<SMALL_SIZE) cache->memorySize=SMALL_SLAB;
    else if(size<LARGE_SIZE) cache->memorySize=MEDIUM_SLAB;
    else cache->memorySize=LARGE_SLAB;

    cache->error=0;
    cache->slotsInSlab = cache->memorySize/size;
    cache->slotSize=size;
    cache->dtor=dtor;
    cache->ctor=ctor;
    cache->emptySlabsHead=0;
    cache->usedSlabsHead=0;
    cache->fullSlabsHead=0;
    kmem_strcpy(cache->name,name);

    kmem_slab_t * slab = kmem_slab_init(cache);
    if(slab==0){
        bba_free_block(cache);
        return 0;
    }
    cache->emptySlabsHead=slab;

    cache->nextCache=kmem_cache_head;
    kmem_cache_head=cache;
    return cache;
}

void kmem_slab_destoy_objects(kmem_slab_t* slab, kmem_cache_t* cache)
{
    for(int i=0;i < (cache->slotsInSlab) && (slab->initializedSlotsCount>0); i++){
       if(getBitmapValue(slab->initializedSlotsBitmap,i)==SLOT_INITIALIZED){
           cache->dtor((char*)(slab->memory)+i*cache->slotSize);
           slab->initializedSlotsCount--;
           if(slab->initializedSlotsCount==0) return;
       }
    }
}


int kmem_cache_shrink(kmem_cache_t *cachep)
{
    kmem_slab_t *curr = cachep->emptySlabsHead;
    kmem_slab_t *prev = 0;
    while (curr!=0){
        prev=curr;
        curr=curr->nextSlab;

        if(cachep->ctor!=0){
            kmem_slab_destoy_objects(prev,cachep);
        }

        bba_free_block(prev->memory);
        bba_free_block(prev);
    }

    cachep->emptySlabsHead=0;
    return 0;
}

//initialize up to ALLOCATION_CHUNK_SIZE objects in a given slab
void kmem_slab_construct_objects(kmem_slab_t *slab, kmem_cache_t *cache)
{
    int count=0;
    for(int i=0;i<cache->slotsInSlab;i++){
        if(getBitmapValue(slab->freeSlotsBitmap,i)==SLOT_FREE &&
           getBitmapValue(slab->initializedSlotsBitmap,i)!=SLOT_INITIALIZED)
        {
            cache->ctor((char*)(slab->memory)+i*cache->slotSize);
            slab->initializedSlotsCount++;
            setBitmapValue(slab->initializedSlotsBitmap,i,SLOT_INITIALIZED);
            count++;
            if(count==ALLOCATION_CHUNK_SIZE || slab->initializedSlotsCount==cache->slotsInSlab) return;
        }
    }
}



void* kmem_slab_get_free_object(kmem_slab_t *slab, kmem_cache_t *cache)
{
    int charCnt = (cache->slotsInSlab+8-1)/8;
    for(int i=0;i<charCnt;i++){
        char c = slab->freeSlotsBitmap[i];
        if(c==0) continue; //a quick way to check 8 slots at once
        int k = 0;
        while(k<8){
            if( ((c>>k)&1) == SLOT_FREE) break;
            k++;
        }

        slab->usedSlotsCount++;
        setBitmapValue(slab->freeSlotsBitmap,i*8+k,SLOT_TAKEN);
        return ((char*)slab->memory+(i*8+k)*cache->slotSize);
    }
    return 0;
}

void* kmem_slab_get_initialized_free_object(kmem_slab_t *slab, kmem_cache_t *cache)
{
    int charCnt = (cache->slotsInSlab+8-1)/8;
    for(int i=0;i<charCnt;i++){
        char c = (char)(slab->initializedSlotsBitmap[i]&slab->freeSlotsBitmap[i]);
        if(c==0) continue; //a quick way to check 8 slots at once
        int k = 0;
        while(k<8){
            if( (c&(1<<k)) == SLOT_INITIALIZED) break;
            k++;
        }

        slab->usedSlotsCount++;
        setBitmapValue(slab->freeSlotsBitmap,i*8+k,SLOT_TAKEN);
        return ((char*)slab->memory+(i*8+k)*cache->slotSize);
    }
    return 0;
}


void *kmem_cache_alloc_no_constructor(kmem_cache_t* cachep)
{
    if(cachep->usedSlabsHead==0){
        if(cachep->emptySlabsHead==0){
            cachep->usedSlabsHead = kmem_slab_init(cachep);
        }
        else {
            cachep->usedSlabsHead=cachep->emptySlabsHead;
            cachep->emptySlabsHead=cachep->emptySlabsHead->nextSlab;
        }
        return kmem_slab_get_free_object(cachep->usedSlabsHead,cachep);
    }
    else{
        void* result = kmem_slab_get_free_object(cachep->usedSlabsHead,cachep);
        kmem_slab_t* head = cachep->usedSlabsHead;
        //check if slab is full now
        if(head->usedSlotsCount==cachep->slotsInSlab){
            cachep->usedSlabsHead=head->nextSlab;
            head->nextSlab=cachep->fullSlabsHead;
            cachep->fullSlabsHead=head;
        }
        return result;
    }
}


void *kmem_cache_alloc_constructor(kmem_cache_t *cachep)
{
    if(cachep->usedSlabsHead==0){
        if(cachep->emptySlabsHead==0){
            cachep->usedSlabsHead = kmem_slab_init(cachep);
        }
        else {
            cachep->usedSlabsHead=cachep->emptySlabsHead;
            cachep->emptySlabsHead=cachep->emptySlabsHead->nextSlab;
        }
        return kmem_slab_get_initialized_free_object(cachep->usedSlabsHead,cachep);
    }
    else{
        kmem_slab_t* target = cachep->usedSlabsHead;
        while (target!=0){
            if(target->initializedSlotsCount>target->usedSlotsCount) break;
            target=target->nextSlab;
        }
        if(target==0){
            target=cachep->usedSlabsHead;
            kmem_slab_construct_objects(target,cachep);
        }
        void* result = kmem_slab_get_initialized_free_object(target,cachep);
        //if slab is full send it to the other list
        if(target->usedSlotsCount==cachep->slotsInSlab){
            if(target==cachep->usedSlabsHead){
                cachep->usedSlabsHead=target->nextSlab;
            }
            else{
                kmem_slab_t * prev = cachep->usedSlabsHead;
                while (prev->nextSlab!=target) prev=prev->nextSlab;
                prev->nextSlab=target->nextSlab;
            }
            target->nextSlab=cachep->fullSlabsHead;
            cachep->fullSlabsHead=target;
        }
        return result;
    }
}

void *kmem_cache_alloc(kmem_cache_t* cachep){
    if(cachep->ctor!=0) return kmem_cache_alloc_constructor(cachep);
    else return kmem_cache_alloc_no_constructor(cachep);
}

// Deallocate one object from cache
void kmem_cache_free(kmem_cache_t *cachep, void *objp)
{
    //look for the object amongst nonfull slabs
    kmem_slab_t* curr = cachep->usedSlabsHead;
    kmem_slab_t* prev = 0;
    while(curr!=0){
        if(objp>curr->memory && objp<((char*)(curr->memory)+cachep->memorySize)){
            int positionInSlab = ((char*)objp - (char*)curr->memory)/cachep->slotSize;
            setBitmapValue(curr->freeSlotsBitmap,positionInSlab,SLOT_FREE);
            curr->usedSlotsCount--;
            if(curr->usedSlotsCount==0){
                if(prev==0){
                    cachep->usedSlabsHead=curr->nextSlab;
                }
                else {
                    prev->nextSlab=curr->nextSlab;
                }
                curr->nextSlab=cachep->emptySlabsHead;
                cachep->emptySlabsHead=curr;
            }
            return;
        }
        prev=curr;
        curr=curr->nextSlab;
    }

    //amongst full slabs
    curr=cachep->fullSlabsHead;
    prev=0;
    while(curr!=0){
        if(objp>curr->memory && objp<((char*)(curr->memory)+cachep->memorySize)){
            int positionInSlab = ((char*)objp - (char*)curr->memory)/cachep->slotSize;
            setBitmapValue(curr->freeSlotsBitmap,positionInSlab,SLOT_FREE);
            curr->usedSlotsCount--;
            if(prev==0){
                cachep->fullSlabsHead=curr->nextSlab;
            }
            else {
                prev->nextSlab=curr->nextSlab;
            }
            curr->nextSlab=cachep->usedSlabsHead;
            cachep->usedSlabsHead=curr;
            return;
        }
        prev=curr;
        curr=curr->nextSlab;
    }
}

// Alloacate one small memory buffer
void *kmalloc(unsigned long size)
{
    return bba_allocate(size);
}

// Deallocate one small memory buffer
void kfree(const void *objp)
{
    bba_free_block(objp);
}

void kmem_destroy_list(kmem_cache_t* cachep,kmem_slab_t* head){
    if(head==0) return;
    kmem_slab_t *curr = head->nextSlab;
    kmem_slab_t * prev = head;
    while (prev!=0){
        if(cachep->dtor!=0) kmem_slab_destoy_objects(prev,cachep);
        bba_free_block(prev->memory);
        bba_free_block(prev);
        prev=curr;
        if(curr!=0) curr=curr->nextSlab;
    }
}

// Deallocate cache
void kmem_cache_destroy(kmem_cache_t *cachep)
{
    kmem_destroy_list(cachep,cachep->usedSlabsHead);
    kmem_destroy_list(cachep,cachep->emptySlabsHead);
    kmem_destroy_list(cachep,cachep->fullSlabsHead);
    bba_free_block(cachep);
}

static inline void kmem_slab_info(kmem_slab_t* slab)
{
    printf("\n Slab at addr %lx, %d used slots, %d initialized slots",  slab->memory, slab->usedSlotsCount, slab->initializedSlotsCount);
}
// Print cache info
void kmem_cache_info(kmem_cache_t *cachep)
{
    int initObjCount=0, usedObjCount=0, slabsCount=0;
    printf("\n Cache '%s' has %d slots of size %d in each slab",cachep->name, cachep->slotsInSlab, cachep->slotSize);
    printf("\n Empty slabs:");
    kmem_slab_t * curr = cachep->emptySlabsHead;
    while (curr!=0){
        kmem_slab_info(curr);
        slabsCount++;
        initObjCount+=curr->initializedSlotsCount;
        usedObjCount+=curr->usedSlotsCount;
        curr=curr->nextSlab;
    }
    printf("\n Full slabs:");
    curr = cachep->fullSlabsHead;
    while (curr!=0){
        kmem_slab_info(curr);
        slabsCount++;
        initObjCount+=curr->initializedSlotsCount;
        usedObjCount+=curr->usedSlotsCount;
        curr=curr->nextSlab;
    }
    printf("\n Partially full slabs:");
    curr = cachep->usedSlabsHead;
    while (curr!=0){
        kmem_slab_info(curr);
        slabsCount++;
        initObjCount+=curr->initializedSlotsCount;
        usedObjCount+=curr->usedSlotsCount;
        curr=curr->nextSlab;
    }
    printf("\n Total slabs: %d, total used slots: %d, total initialized slots: %d", slabsCount, usedObjCount,initObjCount);
    printf("\n-------------------------", usedObjCount,initObjCount);
}

int kmem_cache_error(kmem_cache_t *cachep); // Print error message

