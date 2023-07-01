#ifndef BUDDYALLOCATOR_SLAB_H
#define BUDDYALLOCATOR_SLAB_H
#include <stdlib.h>
#include "kern_buddyAllocator.hpp"

#define BLOCK_SIZE (4096)


//mali objekti dobijaju

struct kmem_cache_s;

typedef struct kmem_slab_s{
    int usedSlotsCount;
    int initializedSlotsCount;
    void* memory;
    char* initializedSlotsBitmap;
    char* freeSlotsBitmap;
    struct kmem_slab_s* nextSlab;
} kmem_slab_t;


typedef struct kmem_cache_s{
    kmem_slab_t * emptySlabsHead;
    kmem_slab_t * usedSlabsHead;
    kmem_slab_t * fullSlabsHead;
    struct kmem_cache_s* nextCache;
    unsigned long slotSize;
    void (*ctor) (void*);
    void (*dtor) (void*);
    char name[16];
    int memorySize;
    int error;
    int slotsInSlab;
} kmem_cache_t;


void kmem_init(void *space, int block_num);
kmem_cache_t *kmem_cache_create(const char *name, unsigned long size,
                                void (*ctor)(void *),
                                void (*dtor)(void *)); // Allocate cache
int kmem_cache_shrink(kmem_cache_t *cachep); // Shrink cache
void *kmem_cache_alloc(kmem_cache_t *cachep); // Allocate one object from cache
void kmem_cache_free(kmem_cache_t *cachep, void *objp); // Deallocate one object from cache
void *kmalloc(unsigned long size); // Alloacate one small memory buffer
void kfree(const void *objp); // Deallocate one small memory buffer
void kmem_cache_destroy(kmem_cache_t *cachep); // Deallocate cache
void kmem_cache_info(kmem_cache_t *cachep); // Print cache info
int kmem_cache_error(kmem_cache_t *cachep); // Print error message
#endif //BUDDYALLOCATOR_SLAB_H
