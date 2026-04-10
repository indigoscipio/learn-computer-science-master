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


& and * are inverses
& goes from variable -> address
* goes from address -> variable

----------------------------------------------------

Exercise 6
Write the following function:
void find_two_largest (int a [] , int n, int *largest, int *second_largest) ;

When passed an array a of length n.the function will search a for its largest and second
largest elements storing them in variables pointed to by largest and second_largest
respectiely



answer:
*/

#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <ctype.h>

#define N 5

void find_two_largest(int a[], int n, int *largest, int *second_largest){
    *largest = a[0];
    *second_largest = a[1];

    // initialization: compare the first 2
    if(*largest < *second_largest){
        int temp = *largest;
        *largest = *second_largest;
        *second_largest = temp;
    }

    // the main loop
    for(int i=2; i< n; i++){
        if(a[i] > *largest){
            *second_largest = *largest;
            *largest = a[i];
        }else if(a[i]> *second_largest){
            *second_largest = a[i];
        }
    }
}

// mutates big and small from main
int main(void){
    int a[N] = {1,2,3,4,5};
    int largest, second_largest;

    find_two_largest(a, N, &largest, &second_largest);
    printf("Largest: %d, Second Largest: %d\n", largest, second_largest);

    return 0;
}
