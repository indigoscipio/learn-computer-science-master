// main.c
#include <stdio.h>

/*
STRUCTURE

like (define-struct name (x y z)) in racket.

*/


int main(void) {
    struct {int number; int quantity;} thing;
    thing.number = 22;
    printf("%d", thing.number);

    return 0;
}
