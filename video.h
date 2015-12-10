#ifndef _VIDEO_H
#define _VIDEO_H

#define VIDEO_WIDTH 80
#define VIDEO_HEIGHT 25

void video_init();
void clrscr();
void set_cursor(int row, int col);

void putchar(char c);
void puts(char *s);

#endif
