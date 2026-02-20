#include <stdio.h>

/*
LOOPS

while : checks cond before the body rund
do-while : checks cond after body runs
for : like while, but designed with how many times you wanna run it

for(xx) < here xx is called "controlling expression"

=============================================================
PP3

Write a program that asks the user to enter a fraction, then reduces the fraction to lowest
terms:

Enter a fraction: 6/12
In lowest terms: 1/2

Hint: To reduce a fraction to lowest terms, first compute the GCD of the numerator and
denominator. Then divide both the numerator and denominator by the GCD.

*/

#include <stdio.h>

int main(void) {
    int num, denom, gcd, rem, simplified_num, simplified_denom;

    printf("Enter a fraction (a\b): \n");
    scanf("%d/%d", &num, &denom);

    int m = num, n = denom;
    // compute the gcd
    while(n != 0){
        rem = m % n;
        m = n;
        n = rem;
    }

    gcd = m;
    simplified_num = num / gcd;
    simplified_denom = denom / gcd;
    printf("In lowest terms: %d/%d", simplified_num, simplified_denom);


    return 0;
}
