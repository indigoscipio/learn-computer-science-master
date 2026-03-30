/*
PP6
Write a function that computes the value of the following polynomial:
3x^5 + 2x^4 - 5x^3 - x^2 + 7x - 6

Write a program that asks the user to enter a value for.v.calls the function to compute the
value of the polynomial , and then displays the value returned by the function.

*/

#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <ctype.h>

long int expo(int base, int power){
    if(power == 0){
        return 1;
    }else{
        return base * expo(base, (power - 1));
    }
}


long int compute_poly(int x){
    return (3 * expo(x,5)) + (2 * expo(x,4)) - (5 * expo(x,3)) - expo(x,2) + (7 * x) - 6;
}

int main(void) {
    long int x;

    printf("Enter value for x: ");
    scanf("%ld",&x);

    printf("%d", expo(2,3));
    printf("The result is: %ld", compute_poly(x));

    return 0;
}
