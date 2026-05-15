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


/*
Exercise 8

Let color be the following structure:

struct color{
    int red;
    int green;
    int blue;
}

a.  Write a declaration for a const variable named MAGENTA of type struct color
whose members have the values 255.0.and 255. respectively.

b. (c99) repeat part a but use designated initializer that doesn't specify the value
of green allowing it to default to 0

answer:
*/

struct color{
    int red;
    int green;
    int blue;
};

// PART A
const struct color MAGENTA = {255,0,255};

// PART B
const struct color MAGENTA = {.red = 255, .blue = 255};

int main(void){

    return 0;
}
