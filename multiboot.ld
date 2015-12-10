OUTPUT_FORMAT(elf32-i386)
OUTPUT_ARCH(i386)
ENTRY(entry_point)

SECTIONS
{
    . = 1M;
    .text : { *(.entry) *(.header) *(.text) }
    .data : { *(.data) }
    .rodata : { *(.rodata) }
    .bss : { *(.bss) }
}
