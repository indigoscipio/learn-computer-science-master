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
Exercise 4
Repeat Exercise 3, but this time using a type named Complex.
*/

// PART A
typedef struct {double real; double imaginary;} complex;

// PART B
complex c1, c2, c3;

// PART C
complex make_complex(double real, double imaginary){
    complex new_complex;
    new_complex.real = real;
    new_complex.imaginary = imaginary;
    return new_complex;
}

// PART D
complex add_complex(complex a, complex b){
    return make_complex(a.real + b.real, a.imaginary + b.imaginary);
}


/*
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
*/
