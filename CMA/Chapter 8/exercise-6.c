#include <stdio.h>

/*
Exercise 6
Calculators, watches, and other electronic devices often rely on seven-segment displays for
numerical output. To form a digit,

such devices"turn on" some of the seven segments while
leaving others"off':

Suppose that we want to set up an array that remembers which segments should be"on" for
each digit. Let's number the segments as follows:

[top horizontal = 0, bottom horizontal= 3, mid horizontal = 6]
[top left= 5, bottom left =4]
[top right = 1, bottom right = 2]

Here's what the array might look like, with each row representing one digit:
const int segments [10] [7] = {{l, 1, 1, 1, 1, 1, 0}, ...};
I 've given you the first row of the initializer: fill in the rest.

{
{l, 1, 1, 1, 1, 1, 0}, //0
{0, 1, 1, 0, 0, 0, 0}, //1
{l, 1, 0, 1, 1, 0, 1}, //2
{l, 1, 1, 1, 0, 0, 1}, //3
{0, 1, 1, 0, 0, 1, 1}, //4
{l, 0, 1, 1, 0, 1, 1}, //5
{l, 0, 1, 1, 1, 1, 1}, //6
{l, 1, 1, 0, 0, 0, 0}, //7
{l, 1, 1, 1, 1, 1, 1}, //8
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
