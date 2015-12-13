.PHONY: all run-multiboot run-mbr clean

SOURCES_MB=main entry video
TARGET_MB=multiboot

SOURCES_MBR=mbr
TARGET_MBR=mbr

CFLAGS=-nostdlib -nostdinc -ffreestanding -m32 -std=c99
ASFLAGS=-m32
LDFLAGS=-nostdlib
QEMU=qemu-system-i386
QEMUFLAGS=

all: $(TARGET_MB) $(TARGET_MBR)

run-multiboot: $(TARGET_MB)
	$(QEMU) -kernel $< $(QEMUFLAGS)

run-mbr: $(TARGET_MBR)
	$(QEMU) -hda $< $(QEMUFLAGS)

$(TARGET_MB): $(SOURCES_MB:%=%.o) multiboot.ld
	ld $(LDFLAGS) -Tmultiboot.ld -o $@ $(SOURCES_MB:%=%.o)

$(TARGET_MBR): $(SOURCES_MBR:%=%.o) mbr.ld
	ld $(LDFLAGS) -Tmbr.ld -o $@ $(SOURCES_MBR:%=%.o)

%.o: %.c
	gcc -o $@ -c $(CFLAGS) $<

%.o: %.S
	gcc -o $@ -c $(ASFLAGS) $<

clean:
	rm $(TARGET_MB) $(TARGET_MBR) *.o

