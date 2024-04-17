#include <stdint.h>
#include <kernel/uart.h>
#include <common/stdio.h>

void kernel_main(uint32_t r0, uint32_t r1, uint32_t atags)
{
    (void) r0;
    (void) r1;
    (void) atags;

    uart_init();

    while (1) {
        putc(getc());
        putc('\n');
    }
}