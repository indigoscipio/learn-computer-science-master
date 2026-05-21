// main.c
#include <stdio.h>
#include <stdbool.h>
#include  <stdlib.h>

/*
Exercise 16
Let a be an array of 100 integers. Write a call of qsort that sorts only the lust 50elements
in a. (You don’t need to write the comparison function).

answer:


*/

int sum(int (*f)(int), int start, int end){
    int sum = 0;
    while(start<=end){
        sum+=f(start);
        start++;
    }
    return sum;
}

int square(int n){
    return n * n;
}

int main(void){
    printf("The sum is: %d", sum(square, 1, 10));

    return 0;
}

/*
struct node {int value; struct node *next;};
struct node *first = NULL;

*/
