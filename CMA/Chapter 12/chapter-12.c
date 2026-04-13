/*
CHAPTER 12: Pointer & arrays

Arrays are secretly pointers
p++ -> add 4 byte to int to move on

*(p+i) is basically hte same as a[i]

POINTER ARITHMETIC
- add p + i
- subtract p - i
- subtract p - q

*/

#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <ctype.h>

void reduce(int numerator, int denominator, int *reduced_numerator, int *reduced_denominator){
    int rem, gcd, m=numerator, n=denominator;

    while(n != 0){
        rem = m % n;
        m = n;
        n = rem;
    }
    gcd = m;

    *reduced_numerator = numerator/gcd;
    *reduced_denominator = denominator/gcd;

}

int main(void){
    int n,d,rn,rd;

    printf("Enter a fraction (a/b): \n");
    scanf("%d/%d", &n, &d);

    reduce(n,d,&rn,&rd);
    printf("Reduced fraction is: %d/%d", rn,rd);

    return 0;
}

