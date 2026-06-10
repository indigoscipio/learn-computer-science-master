#include <stdio.h>
#include <stdbool.h>

/*
Homework Problem 2.48

bias = 2^k-1 - 1
e = E + Bias

1.01 * 2^2
significand (M) = 1 + f = 1.01 (1 + 1/4)
E (exponent) = 2
f (fraction) = 1/4
V (value) = 5
e = 2^k-1 + 1


b.
M = 1.1111...
E = n
V = M * 2^n


*/

bool float_ge(float x, float_y){
    unsigned ux = f2u(x);
    unsigned uy = f2u(y);

    //numbers have different signs
    //if x is positive then the statement is true

    // same sign
    // compare both which one iis larger

    // both numbers are negative



int main(void){
    return 0;
}
