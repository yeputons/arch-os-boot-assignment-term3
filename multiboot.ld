OUTPUT_FORMAT(elf32-i386)
OUTPUT_ARCH(i386)
ENTRY(entry_point)

SECTIONS
{
    .header : { .*(.header) }
    . = 1M;
    .text : { *(.entry) *(.text) }
    .data : { *(.data) }
    .rodata : { *(.rodata) }
    .bss : { *(.bss) }
}
