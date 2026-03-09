#include <stdio.h>

/*
Exercise 7
Usingthe shortcuts described in Section 8.2,shrink the initializer for the segmentsarray
(Exercise 6) as much as youcan.

conse int segments[10][7] = {
{l, 1, 1, 1, 1, 1, 0}, //0
{[1] = 1, [2] = 1}, //1
{l, 1, 0, 1, 1, 0, 1}, //2
{l, 1, 1, 1, 0, 0, 1}, //3
{[1]=1,[2]=1,[5]=1,[6]=1}, //4
{l, 0, 1, 1, 0, 1, 1}, //5
{l, 0, 1, 1, 1, 1, 1}, //6
{[0] = 1, [1] = 1, [2] = 1}, //7
{1}, //8
{l, 1, 1, 1, 0, 1, 1}, //9
}

*/


#include <stdio.h>
#include <stdbool.h>

#define N 40

int main(void) {
    int i, fib_numbers[N] = {[0]=0, [1]=1};

    //fill out the remaining with the previous two
    for(i=2; i<N; i++){
        fib_numbers[i] = fib_numbers[i-1] + fib_numbers[i-2];
    }

    //show the result
    for(i = 0; i< N; i++){
        printf("%d\n", fib_numbers[i]);
    }




    return 0;
}
