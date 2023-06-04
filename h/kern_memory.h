//
// Created by os on 5/25/23.
//

#ifndef OS1_KERN_MEMORY_H
#define OS1_KERN_MEMORY_H

struct mem_block;
void* kern_mem_alloc(int size);
int kern_mem_free(void* addr);
void kern_mem_init( void* heapStart,  void* end);
#endif //OS1_KERN_MEMORY_H
