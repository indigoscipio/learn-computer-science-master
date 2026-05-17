// main.c
#include <stdio.h>
#include <stdbool.h>

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
Exercise 20
Suppose that the direction variable is declared in the following way:
enum {NORTH, SOUTH, EAST, WEST} direction;

Let x and y be int variables. Write a switch statement that tests the value of direc
tion.incrementing x if direction is EAST,decrementing x if direction is WEST,
incrementing y if direction isSOUTH,and decrementingy if direction is NORTH.

answer:
lets keepit simple
*/

enum {NORTH, SOUTH, EAST, WEST} direction;

int x, y;
switch(direction){
    case NORTH: y--; break;
    case SOUTH: y++; break;
    case EAST: x++; break;
    case WEST: x--; break;
    default: break;
}


int main(void){

    printf("%d", abs(-8));

    return 0;
}
