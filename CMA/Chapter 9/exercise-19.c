
#include <stdio.h>
#include <stdbool.h>

/*
Exercise 18
Consider the following "mystery" function:

void pb(int n){
    if(n!=0){
        pb(n/2);
        putchar('0' + n % 2);
    }
}

Trace the execution of the function by hand. Then write a program that calls the function,
passing it a number entered by the user. What does the function do?


answer:
lets trace first
say we call pb(3) -> n=3
calls pb(3/2) - pb(1)

inside pb(1) - n=1
calls pb(1/2) - pb(0)

inside pb(0)
since it's zero it does nothing and returns nothing

unfold up to pb1
puchar '0' + 1 % 2 -> putchar '0' + '1' -> prints 1

unfold up to pb3
puchar '0' + 3 % 2 -> putchar '0' + '1' -> prints 1

so prints '11'
end of stack


im guessing this has something todo with binary or something, so print binary


*/

#include <ctype.h>
#define N 8

void pb(int n){
    if(n!=0){
        pb(n/2);
        putchar('0' + n % 2);
    }
}


int main(void){


    pb(3);

    return 0;
}

/*

*/
