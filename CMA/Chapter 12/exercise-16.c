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
Exercise 16
Write a loop that prints the highest temperature in the temperatures array (see Exercise
14)for each day of the week. The loop body should call the find_largest function,
passing it one row of the array at a time.

*/

#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <ctype.h>
#define DAYS 7
#define HOURS 24

int find_largest(int a[], int n ){
    int *p, i, max;

    max = *a;
    for(p=a+1;p<a+n;p++){
        if(*p>max){
            max = *p;
        }
    }

    return max;
}


int main(void){
    int temperatures[DAYS][HOURS] = {
    {65, 64, 63, 63, 62, 62, 63, 65, 68, 70, 72, 75, 77, 78, 79, 80, 79, 77, 75, 72, 70, 68, 67, 66}, // Day 0
    {65, 64, 63, 62, 61, 61, 62, 64, 67, 69, 71, 74, 76, 77, 78, 78, 77, 75, 73, 71, 69, 67, 66, 65}, // Day 1
    {64, 63, 62, 62, 61, 61, 62, 63, 66, 68, 70, 73, 75, 76, 77, 78, 77, 75, 73, 71, 69, 67, 66, 65}, // Day 2
    {63, 62, 61, 61, 60, 60, 61, 63, 65, 67, 69, 72, 74, 75, 76, 77, 76, 74, 72, 70, 68, 66, 65, 64}, // Day 3
    {64, 63, 62, 62, 61, 61, 62, 64, 67, 69, 71, 74, 76, 77, 78, 79, 78, 76, 74, 72, 70, 68, 67, 66}, // Day 4
    {65, 64, 63, 63, 62, 62, 63, 66, 69, 71, 73, 76, 78, 79, 80, 81, 80, 78, 76, 74, 72, 70, 69, 68}, // Day 5
    {67, 66, 65, 65, 64, 64, 65, 68, 71, 73, 75, 78, 80, 81, 82, 83, 82, 80, 78, 76, 74, 72, 71, 70}  // Day 6
};
    int *p;

    // initialize with p points at row 0
    for(int i=0; i<DAYS; i++){
        // inner loop
        printf("Largest tmepearture in day %d is : %d\n", i+1, find_largest(temperatures[i], HOURS));
    }


    return 0;
}

