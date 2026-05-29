#include <stdio.h>


// PROBLEM 2.22
/*
In the following code, we have omitted the definitions of constants M and N:
We compiled this code for particular values of M and N. The compiler optimized the multiplication and
division using the methods we have discussed. The following is a translation of the generated machine
code back into C:


answer:
ok so lets start to tackle this one by  one
we know M and N are mystery numbers
arith is a proc that takes ints x and y
in the body it initializes a result integer and set it to 0
then make it as return value. basically return the sum of x*m + y/n

then optarith is another proc that takes two integers x and y
we initialized t = x at the star;
then we shift x's bits 4 to the left and assign it
so t is a temp var to store original x. x now holds its bit value 4bit shifted to the left
and shifting value to the left means multiply by 2^4 -> so x . 6
then we do x-=t -> x = x - t -> new x = 16x - x = 15x
so multiplication is 15

then on the if statement
we check if y < 0 -> if true, increment y's value by 3 (add bias)
we know from the text that bias = 2^k - 1, k is 4 = 4-1 = 3
then next line y>>=2 -> shift y bits by 2 to theright and assign that value to y
so shifting bit to the right >>2 means division by 2^2 = division by 4
since it divides y by 4 therefore N is 4

so M = 15 and N = 4

*/

#define M /* Mystery number 1 */
#define N /* Mystery number 2 */

int arith(int x, int y){
    int result = 0;
    result = x*M + y/N; /* M and N are mystery numbers. */
    return result;
}

/* Translation of assembly code for arith */
int optarith(int x, int y){
    int t = x;
    x <<= 4;
    x-=t;

    if (y < 0) y += 3;
    y >>= 2; /* Arithmetic shift */
    return x+y;
}

int main(void){

    printf("%f\n",sum_elements(a,8));

    return 0;
}
