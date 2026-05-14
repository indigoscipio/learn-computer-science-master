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
Exercise 3
a. how how to declare a tag named complex for a structure with two members, real
and imaginary, of typedouble.
b. Use the complex tag to declare variables namedcl.c2.and c3.
c. Write a function named make complex that stores its two arguments (both of type
double) in acomplex structure, then returns the structure.
d. Write a function named add complex that adds the corresponding members of its
arguments (both complex structures), then returns the result (another complex structure).

answer:
lets keep it simple
*/



// PART A
struct complex {double real; double imaginary;};

// PART B
struct complex c1, c2 ,c3;

// PART C
struct complex make_complex(double real, double imaginary){
    struct complex new_complex;
    new_complex.real = real;
    new_complex.imaginary = imaginary;
    return new_complex;
}

// PART D
struct complex add_complex(struct complex a, struct complex b){
    return make_complex(a.real + b.real, a.imaginary + b.imaginary);
}


int main(void) {

    printf("%f", c1.real);

    return 0;
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
