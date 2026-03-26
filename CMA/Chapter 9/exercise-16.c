
#include <stdio.h>
#include <stdbool.h>

/*
Exercise 16
Condense the fact function in the same way we condensed power

int fact(int n){
    if (n<=1)
        return 1;
    else
        return n * fact(n-1);
}

answer:
*/

#include <ctype.h>
#define N 8

int fact(int n){
    return n<=1 ? 1 : n * fact(n-1);
}

int main(void){


    printf("%d", fact(6));

    return 0;
}

/*

*/
