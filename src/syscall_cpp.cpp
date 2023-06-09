//
// Created by os on 6/7/23.
//
#include "../h/syscall_cpp.hpp"


void* operator new(size_t size) {
    void* ptr = mem_alloc(size);
    return ptr;
}

void operator delete(void* ptr) {
    mem_free(ptr);
}
