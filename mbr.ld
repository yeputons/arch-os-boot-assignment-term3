OUTPUT_FORMAT(binary)
OUTPUT_ARCH(i8086)
ENTRY(_start)

SECTIONS
{
    . = 0x7c00;
    .text : { *(.text) }
    .sig : AT(0x7DFE) { SHORT(0xAA55) }
}
