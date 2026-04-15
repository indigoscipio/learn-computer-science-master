/*
CHAPTER 12: Pointer & arrays

Arrays are secretly pointers
p++ -> add 4 byte to int to move on

*(p+i) is basically hte same as a[i]

POINTER ARITHMETIC
- add p + i
- subtract p - i
- subtract p - q

COMPARING POINTER
here the comparison compares the 'house number', not the actual value
p = &a[5]
q = &a[1]

p <= q false
p >= q true

ANONYMOUSE ARRAY
int *p = (int []){0,1,2};

* and ++
*p++ = j -> ++ attached to address
(*p)++ = j -> ++ attached to value

ARRAY NAME AS POINTER
int a[10]
*a=7 -> stores 7 into a[0];
*(a+1) = 12 -> stores 12 into a[1];
when you do a[i], it's just *(a+i) -> get the pointer/addres
and a + i is the same as &a[i]; -> get the value

THE ANCHOR
a is constant
when we do p = a; p++
*p should point to nextone
but the anchor does not move always stays at a[0]

THE SAME THING
for (p = a; p < a + N; p++)
for (p = &a[0], p < a[N]; p++)

PASSING ARRAY
when we pass array its not mutable
but if we pass value its just a copy

SKIPPING ROWS
p++ -> skip 10 units
is c int (*)[10]

MULTIDIMENSIONA LARRAY
(*p)[NUM_COLS]

pointer doesn't just hold address, it also holds the size
if its int * -> move 4 byte when pointer is incremen ted
*/

/*
Exercise 5

Suppose that a is a one-dimensional array and p is a pointer variable. Assuming that the
assignment p = a has just been performed, which of the following expressions are illegal
because of mismatched types? Of the remaining expressions, which are true (have a nonzero
value)?

(a) p == a[0]
(b) p == &a[0]
(c) *p == a[0]
(d) p[0] == a[0]

answer:
suppose int a[N], *p;
p = a; (or p = &a[0])

a. p == a[0]
this checks if pointer of p equals to the value of first item of array a
since pointer p holds memory to 1st item of array a its different to the actual value
therefore it's false/returns 0

b. p == &a[0]
checks if pointer p is equal to addres of first item in array a
since we assign p = a which is the same as &a[0], therefore it is true/returns 1

c. *p == a[0]
this one checks if the value that p points to is equal to the first item of array a
since p = a (&a[0]) it dereferences that value and get the 1st items value -> *(&a[0])
so this one istrue/returns 1


d. p[0] == a[0]
since p is a pointer reference to array a p[0] is the same as a[0]
so this is also returns true/1


*/

#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <ctype.h>


int main(void){
    int a[]={1,2,3,4,5}, *p;
    p = a;

    printf("%d", p[0] == a[0]);

    return 0;
}

