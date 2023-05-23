#ifndef OS1_KERN_DEFS_H
#define OS1_KERN_DEFS_H

struct thread_s;
typedef struct thread_s* thread_t;

// kern_interrupts.c
void kern_interrupt_init();

// kern_memory.c
void* kern_mem_alloc(int size);
int kern_mem_free(void* addr);
void kern_mem_init( void* heapStart,  void* end);

#endif //OS1_KERN_DEFS_H
