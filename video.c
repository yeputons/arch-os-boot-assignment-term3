#include "video.h"
#include "util.h"

#pragma pack(push, 1)
struct vga_char {
     uint8_t val;
     uint8_t fg:4, bg:3, unused:1;
};
#pragma pack(pop)

typedef struct vga_char vga_row[VIDEO_WIDTH];
static vga_row *video = (vga_row*)0xB8000;
static struct vga_char init = { 0, 7, 0, 0 };

static int cur_row, cur_col;

void clrscr() {
    for (int y = 0; y < VIDEO_HEIGHT; y++) {
        for (int x = 0; x < VIDEO_WIDTH; x++) {
            video[y][x] = init;
        }
    }
}

static void scroll() {
    for (int y = 0; y + 1 < VIDEO_HEIGHT; y++) {
        for (int x = 0; x < VIDEO_WIDTH; x++) {
            video[y][x] = video[y + 1][x];
        }
    }
    for (int x = 0; x < VIDEO_WIDTH; x++) {
        video[VIDEO_HEIGHT - 1][x] = init;
    }
}

void set_cursor(int row, int col) {
    cur_row = row;
    cur_col = col;
    int pos = row * VIDEO_WIDTH + col;
    outb(0x3D4, 14);
    outb(0x3D5, pos >> 8);
    outb(0x3D4, 15);
    outb(0x3D5, pos & 0xFF);
}

void video_init() {
    clrscr();
    set_cursor(0, 0);
}

static void newline() {
    cur_col = 0;
    if (++cur_row >= VIDEO_HEIGHT) {
        cur_row--;
        scroll();
    }
}

void putchar(char c) {
    if (c == '\n') {
        newline();
    } else {
        video[cur_row][cur_col].val = c;
        if (++cur_col >= VIDEO_WIDTH) {
            newline();
        }
    }
    set_cursor(cur_row, cur_col);
}

void puts(char *s) {
    while (*s) {
        putchar(*s);
        s++;
    }
}
