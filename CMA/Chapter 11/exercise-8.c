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

Exercise 8


write the following function

int *find_largest(int a[], int n);

When passed an array a of lengthn. the function will return a pointer to the array’s largest
element.

answer:
*/

#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <ctype.h>

#define N 5

int *find_largest(int a[], int n){
    int *curr_largest_memory = &a[0];

    for(int i=1;i<n;i++){
        if(a[i]>curr_largest_value){
            curr_largest_memory = &a[i];
        }
    }

    return curr_largest_memory;
}

// mutates big and small from main
int main(void){
    int a[N] = {1,2,3,4,5};

    find_largest(a,N);
    printf("%d", *find_largest(a,N));

    return 0;
}
