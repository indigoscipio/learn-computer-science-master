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
Exercise 3
What will be the contents of the a array after the following statements areexecuted?
#define N 10

inc a [N]={1, 2, 3, 4, 5, 6, 7, 8, 9, 10};
int *p = &a[0] , *q=&a[N-l] , temp;

while (p < q){
    temp = *p;
    *p++ = *q;
    *q-- = temp;
}

answer:
lets analyze this one by one
we have array of 10 length which holds 1 - 10
then we have pointer p that holds address of 1st item (1),
another pointer q that holds the last one (10) and temp var that holds int

then int he loop, tests for condition condition
since ps index (0) is less than qs index (9) it starts the itaration

1st iter
temp = 1, *p = 0th index, *q = 9th index
*p++ = *q -> postfix, dereferenec pointer ps value, set that value of last item, increment ps pointer -> *p = 2nd index
so it now sets sthe value of 1 with 10
*q-- = temp; -> changes the last value with of array a temp which is 1 -> *q = 8th index
so the array swaps 1 and 10 basically

2nd iter
temp = 2, *p = 1st index, *q = 8th index
same thing again, store 2 to temp and swaps 9 with 2

loop ends when index p is equal or more than q so halfway through
basicaly what this does it 'reverses' the array through pointer arithmetic


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

