
#include <stdio.h>
#include <stdbool.h>

/*
Exercise 3
Write a function ged(m , n) that calculates the greatest common divisor of the integersm
and n. (Programming Project 2 in Chapter 6describes Euclid’s algorithm for computing the
GCD.)

*/


int gcd(int m, int n){
    int rem;
    while(n != 0){
        rem = m % n;
        m = n;
        n = rem;
    }
    return m;
}

int main(void){
    int m,n;

    printf("Enter two integers: \n");
    scanf("%d %d", &m, &n);
    printf("The greatest common divisor is: %d", gcd(m,n));


    return 0;
}
