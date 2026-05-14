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
Exercise 7

Assume that the fraction structure contains two members: numerator and denomi
nator (both of type int ). Write functions that perform the following operations on frac
tions:

a. Reduce the fraction f to lowest terms. Hint: To reduce a fraction to lowest terms, first
compute the greatest common divisor (GCD) of the numerator and denominator. Then
div ide both the numerator and denominator by the GCD.
b. add the fractions f1 and f2
c. subtract the fraction f2 from the fraction f1
d. multiply the fractions f1 and f2
e. divide the fraction f1 by the fraction f2

The fractions f , f1.and f 2 will be arguments of type struct fraction; each function
will return a value of type struct fraction. The fractions returned by the functions in
parts (b)-(e) should be reduced to lowest terms. Hint: You may use the function from part
(a) to help write the functions in parts (b-e).

answer:
lets keep it simple
*/

struct fraction {int numerator;
                 int denominator;
                 };




int main(void){

    return 0;
}
