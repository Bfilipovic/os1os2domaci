//
// Created by os on 5/18/23.
//

#include "../h/strings.h"

void printstring(const char* string)
{
    int i=0;
    while (string[i]){
        __putc(string[i++]);
    }
}
