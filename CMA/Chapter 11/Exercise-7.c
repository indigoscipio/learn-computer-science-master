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

Exercise 7
Write the following function:


void split_date(int day_of_year, int year, int *month, int *day);

day of year is anintegerbetween I and366.specifyinga particular day within the year
designated by year,month and day point to variables in which the function will store the
equivalent month (I—12) and day within that month (I-3I).

answer:
*/

#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <ctype.h>

#define N 5

void split_date(int day_of_year, int year, int *month, int *day){
    int months_in_year[12] = {31,28,31,30,31,30,31,31,30,31,30,31};

    if( ((year % 4 == 0) && (year % 100 != 0)) || (year % 400 == 0) ){
            months_in_year[1] = 29;
    }

    for(int i=0; i < 12; i++){
        if(day_of_year > months_in_year[i]){
            //bigger than capacity
            day_of_year-=months_in_year[i];
            (*month)++;
        }else{
            break;
        }
    }

    *day = day_of_year;
}

// mutates big and small from main
int main(void){
    int day_of_year, year, month=1, day;

    day_of_year = 40;
    year = 2026;
    split_date(day_of_year, year, &month, &day);

    printf("Month: %d, Day: %d", month, day);

    return 0;
}
