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
Exercise 12
Write the following function

void find_two_largest(const int *a, int n, int *largest, int *second_largest);


a points to an array of length n. The function searches the array for its largest and second
largest elements, storing them in the variables pointed to by largest and
second largest,respectively. Use pointer arithmetic—not subscripting—to visit array
elements.


*/

#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <ctype.h>
#define N 7

void find_two_largest(const int *a, int n, int *largest, int *second_largest){
    int *p;

    *largest = *a;
    *second_largest = *(a+1);

    //first check
    if(*second_largest>*largest){
        int temp = *largest;
        *largest=*second_largest;
        *second_largest=temp;
    }

    // rest of the check
    for(p=a+2;p<a+n;p++){
        if(*p > *largest){
            *second_largest = *largest;
            *largest = *p;
        }else if(*p > *second_largest){
            *second_largest = *p;
        }
    }
}


int main(void){
    const int a[N] = {1,2,3,4,5,6,7};
    int p,q;

    find_two_largest(a,N,&p,&q);
    printf("%d, %d", p,q);

    return 0;
}

