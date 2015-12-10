.code16
.global _start

_start:
	ljmp $0, $start

start:
    // initialize segments
 	movw $0, %ax
	movw %ax, %ds
    movw %ax, %ss
    movw stack_end, %sp
    movw $0xB800, %ax
	movw %ax, %es

    // Do the work 
    call clrscr
    
    movw $msg, %si
    movw $0, %di
    call print

end:
    jmp end

// No arguments
clrscr:
    push %ax
    push %cx
    push %di

    movw $0x0700, %ax
    movw $(25 * 80), %cx
    movw $0, %di
    rep stosw

    pop %di
    pop %cx
    pop %ax
    ret

// Arguments:
//   %si - first byte of zero-terminated string
//   %di - where to print in video memory
print:
    push %ax
    movb $0x07, %ah

print_loop:
    movb (%si), %al
    test %al, %al
    jz print_end

    movw %ax, %es:(%di)
    inc %si
    add $2, %di
    jmp print_loop

print_end:
    pop %ax
    ret

// Data
msg: .asciz "Hello World! from MBR"
stack: .zero 16
stack_end:

