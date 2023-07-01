#ifndef BUDDYALLOCATOR_BUDDYALLOCATOR_H
#define BUDDYALLOCATOR_BUDDYALLOCATOR_H

#define MINBBSIZE (1<<5)
#define MAXBBSIZE (1<<17)


void bba_print_free_blocks_info();
void bba_print_used_blocks_info();
void bba_init(char* start, char *end);
void bba_split(int n);
void* bba_allocate(unsigned long size);
void bba_free_block(const void* addr);

#endif //BUDDYALLOCATOR_BUDDYALLOCATOR_H
