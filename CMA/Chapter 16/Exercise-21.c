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
Exercise 21
What are the integer values of the enumeration constants in each of the following declara
tions?

a) enum {NUL, SOH, STX, ETX};
b) enum {VT = 11, FF, CR};
c) enum {SO = 14, SI, DLE, CAN = 24, EM};
d) enum {ENQ = 45, ACK, BEL, LF = 37, ETB, ESC};

answer:
a. nul -> 0
soh -> 1
stx -> 2
etx -> 3

b. vt -> 11
ff -> 12
cr -> 13

c. so -> 14
si -> 15
dle -> 16
can -> 24
em -> 25

d. enq -> 45
ack -> 46
bel -> 47
lf -> 37
etb -> 38
esc -> 39

*/

enum {NORTH, SOUTH, EAST, WEST} direction;


int main(void){

    printf("%d", abs(-8));

    return 0;
}
