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
follow the address writeen here

RULE OF THIMB: INITIALIZE BEFORE INDIRECTION
- declare (int *p)
- initialize (p = &i);
- access (*p)

j=*&i is equal to j = i;

*q = *p -> - is right associative

*/

#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <ctype.h>

//main: calls read_cards, analyze_hand and print_Result repeatedly
int main(void) {
    int i=12;


    printf("%d", *p);

    return 0;
}
