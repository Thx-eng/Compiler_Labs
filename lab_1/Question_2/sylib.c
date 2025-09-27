// sylib.c
#include <stdio.h>

int getint() {
    int t;
    scanf("%d", &t);
    return t;
}

void putint(int a) {
    printf("%d\n", a);
}

void putch(int a) {
    printf("%c", a);
}