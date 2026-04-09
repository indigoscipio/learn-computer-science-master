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

Exercise 5
Write the following function:


void split_time (long total_sec, int *hr, int *min, int *sec) ;

total sec is a lime represented as the number of seconds since midnight, hr. min. and
sec are pointers to variables in which the function will store the equivalent time in hours
(0-23). minutes (0-59). and seconds (0-59) . respectively.

answer:
*/

#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <ctype.h>

void split_time(long total_sec, int *hr, int *min, int *sec){
    //hour
    *hr = total_sec / (60 * 60);

    //minute
    *min = (total_sec / 60) % 60;

    *sec = total_sec % 60;
}

// mutates big and small from main
int main(void){
    long total_sec = 16200;
    int h,m,s;
    split_time(total_sec, &h, &m, &s);
    printf("Hour: %d Minute: %d Second: %d\n", h, m, s);

    return 0;
}
