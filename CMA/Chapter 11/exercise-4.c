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

Exercise 4

Writethefollowing function:

void swap(int *p, int *q);

When passed the addresses of two variables, swap should exchange the values of the vari
ables:

swap(&i, &j); Exchanges values of i and j

answer:
*/

#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <ctype.h>

void swap(int *p, int *q){
    int temp = *p;
    *p = *q;
    *q = temp;
}

// mutates big and small from main
int main(void){
    int i=0, j=5, *p,*q;
    p = &i;
    q = &j;

    printf("Before Swap: %d %d\n", *p, *q);
    swap(p, q);
    printf("After swap: %d %d\n", *p, *q);

    return 0;
}
