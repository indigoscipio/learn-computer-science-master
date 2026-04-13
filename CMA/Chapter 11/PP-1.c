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

PP1
Modify Programming Project 7 fromChapter 2 so that it includes the following function:
void payamount(int dollars, int *twenties, int *tens,int *fives, int *ones);

The function determines the smallest number of$20.$10.$5,and $1 bills necessary to pay
the amount represented by the dollars parameter. The twenties parameter points toa
variable in which the function will store the number of S20 bills required. The tens,
fives,and onesparameters are similar.

answer:
*/

#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <ctype.h>

void pay_amount(int dollars, int *twenties, int *tens, int *fives, int * ones){

    *twenties = dollars / 20;
    dollars%=20;
    *tens = dollars / 10;
    dollars%=10;
    *fives = dollars / 5;
    dollars%=5;
    *ones = dollars;
}

int main(void){
    int dollars, twenties, tens, fives, ones;

    printf("Enter your dollar amount: ");
    scanf("%d", &dollars);

    pay_amount(dollars, &twenties, &tens, &fives, &ones);

    printf("$20 bills: %d\n", twenties);
    printf("$10 bills: %d\n", tens);
    printf("$5 bills: %d\n", fives);
    printf("$1 bills: %d\n", ones);

}

/*
FROM CHAPTER 2
int main(void){
    int amt, remaining_after_tens, remaining_after_fives, twenties, tens, fives, ones;

    printf("Enter your dollar amount: ");
    scanf("%d", &amt);

    twenties = (amt /20);
    tens = ((amt % 20) / 10);
    remaining_after_tens = ((amt % 20) % 10);
    fives = (remaining_after_tens / 5);
    remaining_after_fives = (((amt % 20) % 10) % 5);
    ones = remaining_after_fives;

    printf("$20 bills: %d\n", twenties);
    printf("$10 bills: %d\n", tens);
    printf("$5 bills: %d\n", fives);
    printf("$1 bills: %d\n", ones);

    return 0;
}
*/
