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
Exercise 9
Write the followingfunction:

double inner_product(const double *a, const double *b, int n);

a and b both point to arrays of length n. The function should return a[ 0] * b[0] +
a[l] * b[l] + ... + a[n-1] * b[n-1] . Use pointer arithmetic—not subscripting—to
visit array elements.


*/

#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <ctype.h>
#define N 7

double inner_product(const double *a, const double *b, int n){
    double *p, *q, sum;


    for(p=a,q=b;p<a+n;p++, q++){
        sum += *p * *q;
    }

    printf("Sum is: %lf", sum);
    return sum;
}

int main(void){
    double a[N] = {1,2,3,4,5,6,7};
    double b[N] = {1,2,3,4,5,6,7};

    inner_product(a,b, N);

    return 0;
}

