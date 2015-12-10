.PHONY: all run-multiboot run-mbr clean

SOURCES_MB=main entry video
TARGET_MB=multiboot

SOURCES_MBR=mbr
TARGET_MBR=mbr

CFLAGS=-nostdlib -nostdinc -ffreestanding -m32 -std=c99
ASFLAGS=-m32
LDFLAGS=-nostdlib
QEMU=qemu-system-i386

all: $(TARGET_MB) $(TARGET_MBR)

run-multiboot: $(TARGET_MB)
	$(QEMU) -kernel $< -vnc localhost:0

run-mbr: $(TARGET_MBR)
	$(QEMU) -hda $< -vnc localhost:0

$(TARGET_MB): $(SOURCES_MB:%=%.o)
	ld $(LDFLAGS) -Tmultiboot.ld -o $@ $^

$(TARGET_MBR): $(SOURCES_MBR:%=%.o)
	ld $(LDFLAGS) -Tmbr.ld -o $@ $^

%.o: %.c
	gcc -o $@ -c $(CFLAGS) $<

%.o: %.S
	gcc -o $@ -c $(ASFLAGS) $<

clean:
	rm $(TARGET_MB) $(TARGET_MBR) *.o

