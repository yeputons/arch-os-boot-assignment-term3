#include "util.h"
#include "multiboot.h"
#include "video.h"

static const uint32_t MULTIBOOT_HEADER[]
__attribute__((section(".header"))) = {
    MB_MAGIC,
    MB_FLAGS,
    -MB_MAGIC - MB_FLAGS,
    0, 0, 0, 0, 0, // header info, unused
    '1', // mode_type, EGA-standard
    VIDEO_WIDTH,
    VIDEO_HEIGHT,
    0, // depth of video, no preference
};

void main(uint32_t magic, uint32_t mb_info) {
    video_init();
    if (magic != MB_ANSWER_MAGIC) {
        puts("Invalid multiboot magic received\n");
        return;
    }
    puts("Hello world!\nMultiboot is so cool!\n");
}
