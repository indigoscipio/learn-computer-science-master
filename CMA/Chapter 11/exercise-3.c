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

Exercise 3
The following function supposedly computes the sum and average of the numbers in the
array a. which has length n. avg and sum point to variables that the function should mod
ify. Unfortunately, the function contains several errors; find and correct them.

void avg_sum(double a[], int n, double *avg, double *sum){
    int i;
    sum = 0.0;

    for(i=0;i<n;i++){
        sum+=a[i];
    }
    avg=sum/n;

}

answer:
1. isn't sum a type of double pointer?
why are we assigning actual value instead of dereferencing it first?
it should be like *sum = 0.0;

2. inside the for loop, again we are just directly assigning the sum which is apointer
it should be *sum+=a[i]

3. then at the end of the function,
we assign avg which is a pointer/memory address instead of dereferencing it first
also again the sum
it should be *avg=*sum/n;

*/

#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <ctype.h>

#define N 10

void avg_sum(double a[], int n, double *avg, double *sum){
    int i;
    *sum = 0.0;

    for(i=0;i<n;i++){
        *sum+=a[i];
    }
    *avg=*sum/n;

}

// mutates big and small from main
int main(void){
    double a,b, *avg,*sum;
    double arr[3] = {9,3,4};
    avg = &a;
    sum = &b;

    avg_sum(arr,3,avg,sum);
    printf("%f", *avg);
    printf("%f", *sum);

    return 0;
}
