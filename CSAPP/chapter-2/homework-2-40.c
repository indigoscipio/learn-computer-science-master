#include <stdio.h>
#include <stdbool.h>

/*
Homework problem 2.40

Suppose we want to compute the complete 2w-bit representation of x y, where both x and y are unsigned,
on amachine for which data type unsignedisw bits. Thelow-order w bits ofthe product can be computed
with the expression x*y, so we only require a procedure with prototype

unsigned int unsigned_high_prod(unsigned x, unsigned y);

that computes the high-order w bits of x y for unsigned variables.
Wehave access to a library function with prototype:
int signed_high_prod(int x, int y);
that computes the high-order w bits of x y for the case where x and y are in two's complement form. Write
code calling this procedure to implement the function for unsigned arguments. Justify the correctness of
your solution.

[Hint:] Look at the relationship between the signed product x y and the unsigned product x0 y0 in the
derivation of Equation 2.18.
*/


int main(void){
    return 0;
}
