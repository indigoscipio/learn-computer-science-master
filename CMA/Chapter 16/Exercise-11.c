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
Exercise 11

Supposethat s is the following structure:

struct{
    double a;
    union{
        char b[4];
        double c;
        int d;
    } e;
    char f[4];
} s;

If char values occupy one byte,
int valuesoccupy four bytes, and double valuesoccupy
eight bytes, how much space will a C compiler allocate for s? (Assume that the compiler
leaves no “holes'* between members.)

answer:

ok let me try to answer this i'll probably get this wrong but let me justry
so we know
char = 1byte
int = 4byte
double = 8byte

the question's asking how much space will c allocate for s
lets try to calculate one by one

so s is a struct with first
- double a -> 8byte
- union -> 16byte
    - char b[4] -> 1*4 = 4 byte
    - double c -> 8 byte
    - int d -> 4 byte
- char f[4] -> 1*4 = 4 byte

so for the union total is like 4+8+4 = 16 byte but
im not sure about the union here but from what i understand it can share memory and transform
so it depends on the state of it being used/called.
but the union holds only the largest so far so 8 byte

so the total for the struct is
8+8+4 = 20 byte

*/




int main(void){

    printf("%d", abs(-8));

    return 0;
}
