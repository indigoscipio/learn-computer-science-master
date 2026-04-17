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

ARRAY DECAY
When passed into a functin, a[] is automatically treated as *a
decays into a pointer to its first element
you can perform a subscript coz a[i] = *(a+i)


*/

/*
Exercise 15
Write a loop that prints all temperature readings stored in rowi of the temperatures
array (see Exercise 14). Use a pointer to visit each element of therow.

&a[i][0] -> int * -> pointer to single int
a[i] -> int * (decay) ->

*/

#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <ctype.h>
#define DAYS 7
#define HOURS 24

bool search(const int a[], int n, int key){
    int *p;

    for(p=a; p<a+n;p++){
        if(key == *p){
            return true;
        }
    }

    return false;
}


int main(void){
    int temperatures[DAYS][HOURS] = {0}, *p, i=1;
    temperatures[1][7] = 32;


    // a[i] is basically the same as &a[i][0]
    for(p = temperatures[i];p<temperatures[i]+HOURS;p++){
        printf("%d", *p);
    }

    return 0;
}

