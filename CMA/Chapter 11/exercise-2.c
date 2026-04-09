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

Exercise 2
If i in an int variable and p and q are pointers to int
which os the following assignments are legal?

a. p = i;
b. *p = &i;
c. &p = q;
d. p = &q;
e. p = *&q;
f. p = q;
g. p = *q;
h. *p = q;
i. *p =*q;

answer:
ok we know int i, *p, *q;
p = &i;
q = &i;

a. p = i
we already set *p as pointer to i
this would assign the actual value of i to the pointer p, not legal


b.
*p = &i;
this assigns the memory address of i into the value that pointer p holds
not sure if its legal but its very dangerous so not legal i guess


c. &p = q;
this assigns q, which is &i (memory address of i) to memory address of p
not legal since & operation is right value?
&p is temporary value (address of p), &p is not a variable but a number


d. p = &q;
this one assigns the memory addres of pointer q to pointer p - pointer of a pointer
p is a pointer has a type of int *
&q is the address of a pointer
since we know pointer q holds the address of var i -> q = &i -> p = &(&i) ->
we try go get the  memory  address 'twice'?
i dont think this is legal


e. p = *&q
since we know p and q are both pointers that reference integer i
we assign address of pointer q -> dereference it
this is basically back at beginining since theyre both inverse
so p = q so its legal

f. p = q;
since p and q are both pointers that reference integer i
we assign pointer q to p which means its legal

g. p = *q;
here we assign pointer p to the value of pointer q
since we know *q is a reference to int i -> pointer p = value of i
p = i, but poitner should hold memory address instead of actual vlue so not legal

h. *p = q;
since we know p and q are both pointer that references int i
here we set *p which 'gets' the value that pointer p holds -> int i -> as  q which is a pointer
so i = q; but we know q is a pointer. so were just shoving memory address into integer, not legal;


i. *p = *q;
since we know p and q are both pointer that references to i
here we get the 'value' that pointer p holds -> &i -> int i
and set it to *q -> &i -> int i

so it would be the same thing as assigning int i to itself
i = i - legal but i think its kinda pointless?

*/

#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <ctype.h>

#define N 10

// mutates big and small from main
int main(void){
    int i = 999, *p,*q;
    p = &i;
    q = &i;

    printf("%d", *p);
    *p = *q;

    return 0;
}
