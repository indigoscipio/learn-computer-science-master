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
PP6

Modify the qsort.cprogram of Section 9.6so that low. high,and middleare pointers
to array elements rather than integers. The split function will need to return a pointer,not
an integer.


#define N 10

void quicksort(int a[], int low, int high);
int split(int a[], int low, int high);

int main(void){

    int a[N], i;

    printf("Enter %d numbers to be sorted: ", N);

    for(i=0;i<N;i++){
        scanf("%d", &a[i]);
    }

    quicksort(a,0, N-1);

    printf("In sorted order: ");
    for(i=0;i<N;i++){
        printf("%d",a[i]);
    }
    printf("\n");

    return 0;
}


void quicksort(int a[], int low, int high){
    int middle;

    if (low >= high) return;

    middle = split(a,low,high);
    quicksort(a,low,middle-1);
    quicksort(a, middle + 1, high);


}

// picks pivot, moves everything smaller to the left
int split(int a[], int low, int high){
    int part_element = a[low];

    for (;;) {
        //find element smaller than pivot, skip big number thats already in plce
        while (low < high && part_element <= a[high])
        high-- ;
        if (low >= high) break;
        a[low++] = a[high];

        // find element larger than pivot, skip small number already in palce
        while (low < high && a[low] <= part_element)
        low++ ;
        if (low >= high) break;
        a[high--] = a[low];
    }

    a[high] = part_element;
    return high;
}




*/

#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <ctype.h>

#define N 10

void quicksort(int *low, int *high);
int *split(int *low, int *high);

int main(void){

    int a[N], i;

    printf("Enter %d numbers to be sorted: ", N);

    for(i=0;i<N;i++){
        scanf("%d", &a[i]);
    }

    quicksort(a, a+(N-1));

    printf("In sorted order: ");
    for(i=0;i<N;i++){
        printf("%d",a[i]);
    }
    printf("\n");

    return 0;
}


void quicksort(int *low, int *high){
    int *middle;

    if (low >= high) return;
    middle = split(low,high);
    quicksort(low,middle-1);
    quicksort(middle + 1, high);

}

// picks pivot, moves everything smaller to the left
int *split(int *low, int *high){
    int part_element = *low;

    for (;;) {
        //find element smaller than pivot, skip big number thats already in plce
        while (low < high && part_element <= *high)
        high-- ;
        if (low >= high) break;
        *low++ = *high;

        // find element larger than pivot, skip small number already in palce
        while (low < high && *low <= part_element)
        low++ ;
        if (low >= high) break;
        *high-- = *low;
    }

    *high = part_element;
    return high;
}


