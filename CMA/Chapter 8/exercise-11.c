#include <stdio.h>

/*
Exercise 11
Write a program fragment that declares an 8 x 8 char array named checker boardand
then uses a loop to store the followingdata into the array (one character per array element):

B R B R B R B R
R B R B R B R B
B R B R B R B R
R B R B R B R B
B R B R B R B R
R B R B R B R B
B R B R B R B R
R B R B R B R B

Hint: The element in row /. column j.
shouldbe the letter B if i + j is an even number

*/


#include <stdio.h>
#include <stdbool.h>
#define N 8

int main(void) {
    char checker_board[N][N] = {0};
    int i,j;

    // outer loop/row
    for(i=0;i<N;i++){

        for(j=0;j<N;j++){
            // inner loop/col
            if((i+j) % 2 == 0){
                checker_board[i][j]='B';
                printf("%c ", checker_board[i][j]);
            }else{
                checker_board[i][j]='R';
                printf("%c ", checker_board[i][j]);
            }
        }
        printf("\n");
    }

    return 0;
}
