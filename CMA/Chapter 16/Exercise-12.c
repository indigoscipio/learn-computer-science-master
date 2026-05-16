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
Exercise 12
Suppose that u is the following union:

union{
    double a;
    struct {
        char b[4];
        double c;
        int d;
    } e;
    char f[4];
} u;

If char valuesoccupy one byte, int values occupy four bytes, and double values occupy
eight bytes, how much space will a C compiler allocate for u? (Assume that the compiler
leaves no “holes" between members.)

answer:
ok another similar question to the previous ony
lets try to calculate this one by one

- union
    - double a -> 8byte
    - struct e -> total = 4+4+8 = 16 bytes;
        - char b[4] -> 1*4 = 4 byte;
        - double c -> 8 byte;
        - int d -> 4 byte;
    - char f[4] -> 1*4 = 4 bytes

since union holds the largest member
and the largeset here is struct e which occupies 16 bytes
therefore the c compiler will occupy 16 byte for the unionn u

*/




int main(void){

    printf("%d", abs(-8));

    return 0;
}
