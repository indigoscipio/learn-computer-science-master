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
Exercise 18
Wite the evaluate_position function described in Exercise 13 of Chapter 9. Use
pointer arithmetic—not subscripting—to visit array elements. Use a single loop instead of
nested loops

int evaluate_position(char board[][N]){
    int score=0;

    for(int i=0;i<N;i++){
        for(int j=0;j<N;j++){
            if (isupper(board[i][j])){
                score+=piece_score(board[i][j]);
            }

            if(islower(board[i][j])){
                score-=piece_score(board[i][j]);
            }
        }
    }
    return score;

    }
*/

#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <ctype.h>
#define N 8

// assume the piece is valid
int piece_score(char ch){
    switch(toupper(ch)){
        case 'Q':
            return 9;
        case 'R':
            return 5;
        case 'B':
            return 3;
        case 'N':
            return 3;
        case 'P':
            return 1;
        default:
            return 0;
    }
}

// given a chess board
int evaluate_position(char board[][N]){
    int score=0;
    char *p;

    for(p=board[0];p<board[0]+(N*N);p++){
        if(isupper(*p)){
            score+=piece_score(*p);
        }
        if(islower(*p)){
            score-=piece_score(*p);
        }
    }

    return score;

    }

int main(void){
    char board[N][N] = {' ',' ',' ',' ',' ',' ',' ',' ',
                        'Q','K',' ',' ',' ',' ',' ',' ',
                        ' ',' ',' ',' ',' ',' ',' ',' ',
                        ' ',' ',' ',' ',' ',' ',' ',' ',
                        ' ',' ',' ',' ',' ',' ',' ',' ',
                        ' ',' ',' ','k',' ',' ',' ',' ',
                        ' ',' ',' ',' ',' ','r',' ',' ',
                        ' ',' ',' ',' ',' ',' ',' ',' '};


    printf("%d", evaluate_position(board));

    return 0;
}
