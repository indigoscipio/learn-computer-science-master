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

PP3
Modify Programming Project 3 from Chapter 6 so that it includes the following function:
void reduce(int numerator, int denominator,
int *reduced_numerator,
int *reduced_denominator);
numerator and denominator are the numerator and denominator of a fraction,
reducednumerator and reduced denominator are pointers to variables in
which the function will store the num and denum of the fraction once it has been reduced to lowest terms.
answer:

*/

#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <ctype.h>

#define N 8

void reduce(int numerator, int denominator, int *reduced_numerator, int *reduced_denominator){
    int rem, gcd, m=numerator, n=denominator;

    while(n != 0){
        rem = m % n;
        m = n;
        n = rem;
    }
    gcd = m;

    *reduced_numerator = numerator/gcd;
    *reduced_denominator = denominator/gcd;

}

int main(void){
    int n,d,rn,rd;

    printf("Enter a fraction (a/b): \n");
    scanf("%d/%d", &n, &d);

    reduce(n,d,&rn,&rd);
    printf("Reduced fraction is: %d/%d", rn,rd);

    return 0;
}

/*

int main(void) {
    int num, denom, gcd, rem, simplified_num, simplified_denom;

    printf("Enter a fraction (a\b): \n");
    scanf("%d/%d", &num, &denom);

    int m = num, n = denom;
    // compute the gcd
    while(n != 0){
        rem = m % n;
        m = n;
        n = rem;
    }

    gcd = m;
    simplified_num = num / gcd;
    simplified_denom = denom / gcd;
    printf("In lowest terms: %d/%d", simplified_num, simplified_denom);


    return 0;
}
*/
