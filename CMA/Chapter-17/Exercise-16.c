// main.c
#include <stdio.h>
#include <stdbool.h>
#include  <stdlib.h>

/*
Exercise 16
Write the following function. The call sum (g, i, j) should return g ( i ) + ... + g ( j) . 3
int sum (int (*f)(int), int start, int end);

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
