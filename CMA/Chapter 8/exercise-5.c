#include <stdio.h>

/*
Exercise 5
The Fibonacci numbers are 0, 1, 1.2. 3. 5. 8. 13
where each number is the sum of the
two preceding numbers. Write a program fragment that declares an array named
f ib numbers of length 40 and fills the array with the first 40 Fibonacci numbers. Hint:
Fill in the first two numbers individually, then use a loop to compute the remaining num
bers.
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
