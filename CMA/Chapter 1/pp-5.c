#include <stdio.h>
/*
PP5
Write a program that asks the user to enter a value for.v and then displays the value of die
following polynomial:
3x^5 + 2x^4 - 5x^3 - x^2 + 7x - 6
Hint: C doesn't have an exponentiation operator, so you'll need to multiply .v by itself
repeatedly in order to compute the powers of x.(For example, x * x * x is x cubed.)
*/

int main(void){
    float x;
    printf("Enter value for x: ");
    scanf("%f", &x);

    float xpow2 = (x * x);
    float xpow3 = (xpow2 * x);
    float xpow4 = (xpow3 * x);
    float xpow5 = (xpow4 * x);
    printf("Polynomial result is: %.2f", ((3.0f  * xpow5) + (2.0f * xpow4) - (5.0f * xpow3) - xpow2 + (7.0f * x) - 6.0f));
    return 0;
}
