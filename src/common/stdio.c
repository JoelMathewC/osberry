#include <common/stdio.h>
#include <kernel/uart.h>

void putc(unsigned char c) {
    uart_putc(c);
}


unsigned char getc() {
    return uart_getc();
}


void puts(unsigned char* str) {
    for(int i=0; str[i] != '\0'; ++i){
        putc(str[i]);
    }
}

void gets(unsigned char* str, int length) {
    unsigned char c;
    int curr_index = 0;
    while((length - curr_index > 1) && ((c = getc()) != '\r')) {
        str[curr_index++] = c;
    }

    str[c == '\r' ? curr_index : length - 1] = '\0';
}

