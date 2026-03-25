
#include <stdio.h>
#include <stdbool.h>

/*
Exercise 13
Write the following function, which evaluates a chess position:
int evaluate_position(char board[8] [8] );

boardrepresentsaconfigurationof pieceson a chessboard, where the letters K.Q. R. B.N.
P represent White pieces, and the letters k. q. r. b. n. and p represent Black pieces,
evaluate position should sum the values of the White pieces (Q = 9. R = 5. B = 3.
N=3. P = I).

It should also sum the values of the Black pieces (done in a similar way). The
function will return the difference between the two numbers. This value will be positive if
White has an advantage in material and negative il Black has an advantage.

*/

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

/*

*/
