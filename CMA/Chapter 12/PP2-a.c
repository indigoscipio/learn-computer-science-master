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
PP 2
( a) Write a program that reads a message,then checks whether it’s a palindrome (the letters
in the message are the same from left to right as from right to left):

Enter a message: He lived as a devil, eh?
Palindrome

Enter a message: Madam, I am Adam.
Not a palindrome

Ignore all characters that aren 't letters.Use integer variables to keep track of positionsin the
array.

( b) Revise the program to use pointers instead of integers to keep track of positions in the
array.

*/

#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <ctype.h>

void get_input(char a[], int *n){
    char ch;

    do{
        ch = getchar();
        if(isalpha(tolower(ch))){
            //store it
            a[*n] = tolower(ch);
            (*n)++;
        }
    }while(ch != '\n');
}

bool is_palindrome(char a[], int n){
    int left=0, right=n-1;

    while(left<right){
        if(a[left] == a[right]){
        //keep moving
        left++;
        right--;
    }else{
        return false;
    }
    }

    return true;
}


int main(void){
    char a[100];
    int n=0;

    // filter
    get_input(a,&n);


    // check
    if(is_palindrome(a,n)){
        printf("Palindrome");
    }else{
        printf("Not a palindrome");
    }


    printf("%d\n", n);
    for(int i=0; i<n; i++){
        printf("%c\n", a[i]);
    }

    return 0;
}
