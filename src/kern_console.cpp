//
// Created by os on 6/8/23.
//

#include "../h/kern_console.hpp"
#include "../lib/hw.h"
#include "../h/kern_slab.hpp"
#define BUFFER_SIZE 1024

#define Reg(reg) ((volatile unsigned char *)(reg))
#define ReadReg(reg) (*(Reg(reg)))
#define WriteReg(reg, v) (*(Reg(reg)) = (v))
struct {
    char* input;
    char* output;
    int input_r;
    int input_w;
    int output_r;
    int output_w;
} console;

void kern_console_init(){
    console.input=(char*)kmalloc(BUFFER_SIZE*sizeof(char));
    console.output=(char*)kmalloc(BUFFER_SIZE*sizeof(char));
    console.input_r=0;
    console.input_w=0;
    console.output_r=0;
    console.input_w=0;
}

int uart_getchar(void)
{
    if((ReadReg(CONSOLE_STATUS) & CONSOLE_RX_STATUS_BIT)!=0){
        // input data is ready.
        return ReadReg(CONSOLE_RX_DATA);
    } else {
        return -1;
    }
}

void uart_putchar()
{
    if(console.output_r==console.output_w) return;

    if((ReadReg(CONSOLE_STATUS) & CONSOLE_TX_STATUS_BIT) == 0){
        return;
    }

    char c = console.output[(console.output_r++)%BUFFER_SIZE];
    WriteReg(CONSOLE_TX_DATA,c);
}

void kern_uart_handler()
{
    while(1){
        int c = uart_getchar();
        if(c==-1) break;
        console.input[(console.input_w++)%BUFFER_SIZE]=c;
    }

    uart_putchar();
}

int kern_console_getchar()
{
    if(console.input_r<console.input_w){
        return console.input[(console.input_r++)%BUFFER_SIZE];
    }
    else return -1;
}

int kern_console_putchar(char c)
{
    if(ReadReg(CONSOLE_STATUS) & CONSOLE_TX_STATUS_BIT){
        WriteReg(CONSOLE_TX_DATA,c);
    }
    else{
        if(console.output_r-console.output_w>=BUFFER_SIZE) return -1;
        console.output[(console.output_w++)%BUFFER_SIZE]=c;
    }
    return 0;
}
