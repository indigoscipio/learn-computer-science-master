
#include <stdio.h>
#include <stdbool.h>

/*
Exercise 18
Write a recursive version of the gcd function (see Exercise 3). Here’s the strategy to use for
computing gcd(m , n) : If n is 0, return m. Otherwise, call gcd recursively, passing n as
the first argument and m % n as the second


answer:
*/

#include <ctype.h>
#define N 8

int gcd(int m, int n){

    if(n==0){
        return m;
    }else{
        return gcd(n, m % n);
    }

}

int main(void){


    printf("%d", gcd(11,36));

    return 0;
}

/*

*/
