.section ".text.boot"

.global _start

_start:
    # CP15 is a coprocessor that handles control functions and provides status information.
    # This includes overall system control, cache configuration, memory management unit configuration
    # This coprocessor has c0-c16 main registers associated with it, these registers however cannot be
    # used in USR mode, so we use the MCR/MRC commands to get things done here.
    #   MCR - Move to Coprocessor from ARM register
    #   MRC - Move to ARM register from Coprocessor
    # Usage available here: https://developer.arm.com/documentation/ddi0360/f/control-coprocessor-cp15/summary-of-cp15-instructions

    # This reads the CPU ID register and stores it in r1. Since each core runs this
    # the value in r1 for each core is the ID of each core (0, 1, 2, 3).
    mrc p15, #0, r1, c0, c0, #5

    # (From what I can see) This is to limit the results to 0-3
    and r1, r1, #3

    # If r1 is not equal to 0 halt;                 
    cmp r1, #0
    bne halt

    # Moving the stack pointer to 0x8000, the C stack grows downward from here and
    # the kernel runs upward from here.
    mov sp, #0x8000

    # Loading the BSS section (where non-initialized C global variables are stored.)
    ldr r4, =__bss_start
    ldr r9, =__bss_end

    # Creating a continuous array of zeroed out registers.
    mov r5, #0
    mov r6, #0
    mov r7, #0
    mov r8, #0

    # b (the same as jmp) and 2f (to label 2 which occurs in the forward part of code)
    b       2f                          

1:
    # copy's the second operand value into the first one's location and then increments the first location.
    stmia r4!, {r5-r8}                  

2:
    # blo (branch if lesser than) and 1b (to label 1 in the backward part of the code)
    cmp r4, r9
    blo 1b                              

    # Move to the kernel main location.
    # An unconditional branch linking to a program-relative address
    ldr r3, =kernel_main
    blx r3                              

halt:
    # Turn CPU off, this can be woken up by an interrupt/explicit wake
    wfe                                 
    b halt