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

int compute_gcd(int a, int b){
    if(a == b){
        return a;
    }
    else if(a > b){
        return compute_gcd(a-b, b);
    }else{
        return compute_gcd(a, b-a);
    }
 }

// PART A
struct fraction reduce_fraction(struct fraction f){
    int gcd = compute_gcd(f.numerator, f.denominator);

    return (struct fraction) {f.numerator/gcd , f.denominator/gcd};
}

// PART B
// 1/2 + 3/4 -> 4/8 + 6/8
struct fraction add_fraction(struct fraction f1, struct fraction f2){

    int f1_new_numerator = f1.numerator * f2.denominator;
    int f2_new_numerator = f2.numerator * f1.denominator;
    int common_denominator = f1.denominator * f2.denominator;

    return reduce_fraction((struct fraction) {f1_new_numerator + f2_new_numerator, common_denominator});
}

// PART C
struct fraction subtract_fraction(struct fraction f1, struct fraction f2){

    int f1_new_numerator = f1.numerator * f2.denominator;
    int f2_new_numerator = f2.numerator * f1.denominator;
    int common_denominator = f1.denominator * f2.denominator;

    return reduce_fraction((struct fraction) {f1_new_numerator - f2_new_numerator, common_denominator});
}

// PART D
// 1/2 * 3/4 -> 3/8
struct fraction multiply_fraction(struct fraction f1, struct fraction f2){
    return reduce_fraction((struct fraction) {f1.numerator * f2.numerator, f1.denominator * f2.denominator});
}

// PART E
// 1/2 : 1/3 -> 1/2 * 3/1
struct fraction divide_fraction(struct fraction f1, struct fraction f2){
    // reverse f2's nominator with denominator
    // just multiply them manually
    struct fraction f2_inv = {f2.denominator, f2. numerator};

    return reduce_fraction(multiply_fraction(f1, f2_inv));

}


int main(void){
    printf("%d", compute_gcd(48,16));

    return 0;
}
