#define STACK_SIZE 0x4000

.section ".entry"
.global entry_point
entry_point:
    // Initialize the stack pointer
    movl $(stack + STACK_SIZE), %esp

    // Reset EFLAGS
    pushl $0
    popf 

    // Push the pointer to the Multiboot information structure
    pushl %ebx
    // Push the magic value
    pushl %eax

    call main

loop:
    hlt
    jmp loop

.comm stack, STACK_SIZE
