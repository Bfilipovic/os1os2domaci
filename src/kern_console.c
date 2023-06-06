//
// Created by os on 6/6/23.
//

#include "../h/kern_console.h"
#include "../h/kern_semaphore.h"


#define CONSOLE_BUFFER_SIZE 1024
struct {
    char input_buffer[CONSOLE_BUFFER_SIZE];
    char output_buffer[CONSOLE_BUFFER_SIZE];
    sem_t input_sem;
    sem_t output_sem;
    int input_put_cursor;
    int input_get_cursor;
    int output_put_cursor;
    int output_get_cursor;
} console_instance;

void kern_console_init()
{
    console_instance.input_put_cursor=0;
    console_instance.input_get_cursor=0;
    console_instance.output_put_cursor=0;
    console_instance.output_get_cursor=0;
    kern_sem_open(&console_instance.input_sem,0);
    kern_sem_open(&console_instance.output_sem,CONSOLE_BUFFER_SIZE);
}

void kern_console_putc()
{

}

