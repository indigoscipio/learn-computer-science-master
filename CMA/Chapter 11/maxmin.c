/*
CHAPTER 11 : POITNER

a special piece of paper that has a room number on it
POINTER HOLDS AN ADDRESS

WHY POINTER?
- efficiency
- shared resource/access

&: addres operator
where is it??
int i -> value is here
&i -> get the address/room number of i

*: indirection operator (dereference operator)
go there!! aka the magical peeking portal
Get the value of xx
follow the address writeen here

RULE OF THIMB: INITIALIZE BEFORE INDIRECTION
- declare (int *p)
- initialize (p = &i);
- access (*p)

j=*&i is equal to j = i;

*q = *p -> - is right associative

POINTER AS RETURN VALUE
int *max(int *a, int *b)

here the params *a and *b are't acting as dereference
but its part of type declaration

so when we call a or b it returns a pointer
when we do *a or *b inside the function it dereference and returns teh value

ROLE OF ASTERISK
in declaration: -> int *a -> defines variable type. a is a pointer.
in expr -> *a inside a body -> acts as a dereference -> peek inside and gets the value


*/

#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <ctype.h>

#define N 10

void max_min(int a[], int n, int *max, int *min);

//main: calls read_cards, analyze_hand and print_Result repeatedly
int main(void) {

    int b[N], i, big, small;

    printf("Enter %d numbers: ", N);
    for(i=0;i<N;i++){
        scanf("%d",&b[i]);
    }

    max_min(b,N,&big,&small);

    printf("Largest: %d\n", big);
    printf("Smallest: %d\n", small);

    return 0;
}

// mutates big and small from main
void max_min(int a[], int n, int *max, int *min){
    int i;

    // initialize max an min value to 1st item
    *max=*min=a[0];

    for(i=1;i<n;i++){
        //check if curr item exceeds max, if so update new max
        if(a[i]>*max){
            *max=a[i];
        }
        else if(a[i]<*min){
            *min=a[i];
        }
    }
}
