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
if its int * -> move 4 byte when pointer is incremented
*/

/*
Exercise 1
Suppose that the following declarations are in effect:
int a[] = {5, 15, 34, 54, 14, 2, 52, 72};
int *p = &a[l] , *q = &a [5] ;
(a) What is the value of * (p+3 )?
(b) What is the value of * (q-3)?
(c) What is the value of q- p?
(d) Is the condition p < q true or false?
(e) Is the condition *p < *q true or false?

Answer:
ok so we have an arrya a with a few ints
and we assign pointer p to a[1] memory (value = 15) and pointer q to a[5] memory (value = 2)

a. *(p + 3)
since the first item is 15 we 'jump' 3 steps forward to , so 14

b. *(q - 3)
since pointer q starts with 2, it goes 3 steps back, so 34

c. q - p
this gets us the 'distance' between the address/index 5 and 1 -> 5 - 1 = 4 steps so ir return 4

d. since pointer p is 1st index and q is 5th index
therefore q > p or same as p < q so true

e. since value of *p is 15 and value of *q is 2
therefore *p > *q, so its false


*/

#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <ctype.h>

#define N 10

int main(void){
    int a[]={1,2,3,4,5};
    int *p = &a[1];
    int *q = &a[4];

    printf("%d", p-q );

    return 0;
}

