// main.c
#include <stdio.h>

/*
Exercises

1. in  the following declarations, the x and y structures have members named x and y

struct { int x, y; } x;
struct { int x, y; } y;

Are these declarations legal on an individual basis? Could both declarations appear as
shown in a program? Justify your answer.

answer:

yes its legal

first one
x is a struct which has int x and y
2nd one is different struct
each live in seperate name spaces

*/

struct part {int number; int quantity;};

void print_part(struct part p){
    printf("Part number: %d", p.number);
    printf("Part quantity: %d", p.quantity);
}

struct part build_part(int num, int qty){
    struct part p;
    p.number = num;
    p.quantity = qty;
    return p;
};

int main(void) {

    struct part my_part, another_part;

    my_part.number = 555;
    my_part.quantity =123;

    print_part(my_part);
    another_part = build_part(444,4);
    print_part(another_part);

    return 0;
}
