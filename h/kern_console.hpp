//
// Created by os on 6/8/23.
//

#ifndef OS1_KERN_CONSOLE_HPP
#define OS1_KERN_CONSOLE_HPP

void kern_console_init();
void kern_uart_handler();
int kern_console_getchar();
int kern_console_putchar(char c);
#endif //OS1_KERN_CONSOLE_HPP
