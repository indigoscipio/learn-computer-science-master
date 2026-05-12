// main.c
#include <stdio.h>

/*
STRUCTURE

like (define-struct name (x y z)) in racket.

DESIGNATED INITIALIZER
.something{property = x, property1 = y};
+ it's order independence, doesn't care about order
+ smart default, if the property is not defined it will be ste to default (0)
+ unitialized are set o 0

STRUCT OEPRATORS
= -> assign (shallow copy)
Yes you can copy structs but not array why?
coz struct has a 'fixed' size

STRUCT VARIABLE VS STRUCT TAG
the recipe
struct part {...} -> don't build anything yet
struct part part1 -> ok build it now/build on the 'go'

COMPOUND LITERAL
print_part((struct part) {528, "Disk drive", 10})
- its temporary, "anonymous" and for one-off tasks.
- can also include designators

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
