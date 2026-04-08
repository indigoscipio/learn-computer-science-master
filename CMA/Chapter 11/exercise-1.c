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

Exercise 1
If i is a variable and p points to i
which of the following expr are aliases for i?

a. *p
b. &p
c. *&p
d. &*p
e. *i
f. &i
g. *&i
h. &*i

answer:
we know i is a var and p points to i so smth like

small example
int i, *p; access
p = &i; initialize
*p; access
p=*&i is equal to p = i;

a. yes, its an alias  for i
b. no - this is the addrss of i
c. gives address to pointer p ->  derefnerce it -> back to p which is the address. so no
d. no, this one dereference first, then gets the address.
e. no, this  dereference i
f. no, this is the address of i not getting the value/rference of i
g. yes - get the address of i, dereference it and gets the value
h. no

*/

#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <ctype.h>

#define N 10

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
