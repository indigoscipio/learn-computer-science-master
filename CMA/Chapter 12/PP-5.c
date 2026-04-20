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
PP5

Modify Programming Project 14 from Chapter 8so that it uses a pointer instead of an inte
ger to keep track of the current position in the array that contains the sentence.


*/

#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <ctype.h>

int main(void) {
    char ch_arr[50] = {0};
    char ch, terminating_char;
    int i=0,j,k, limit, start;

    printf("Enter a sentence: ");

    // store the chars in array
    while((ch = getchar()) != '\n'){

        //stop when it finds the terminating char
        if(ch == '.' || ch == '!' || ch == '?'){
            terminating_char = ch;
            break;
        }

        ch_arr[i] = ch;
        i++;
    }

    limit = i;
    //reverse traversal
    for(j=i;j>=0; j--){
        //encounter a space
        if(ch_arr[j] == ' '){

            // print each word, word starts at j+1
            for(k=j+1;k<limit;k++){
                printf("%c", ch_arr[k]);
            }
            printf(" ");
            limit = j;
        }else if(j==0){
            for(k=j;k<limit;k++){
                printf("%c",ch_arr[k]);
            }
        }

    }

    if(terminating_char){
        printf("%c", terminating_char);
    }

    printf("\n");
    printf("Reversal of sentence: ");


    return 0;
}
