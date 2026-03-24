
#include <stdio.h>
#include <stdbool.h>

/*
Exercise 12

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
#define N 5


float compute_GPA(char grades[],int n){
    int total=0;
    for(int i=0;i<n;i++){
        switch(grades[i]){
            case 'A':
            case 'a':
                total+=4;
                break;
            case 'B':
            case 'b':
                total+=3;
                break;
            case 'C':
            case 'c':
                total+=2;
                break;
            case 'D':
            case 'd':
                total+=1;
                break;
            default:
                total+=0;
                break;
        }
    }
    return (float)total/n;
}

int main(void){

    char grades[N] ={'A','B','C','D','A'};
int size = sizeof(grades) / sizeof(grades[0]);
    printf("The GPA is: %f\n", compute_GPA(grades, N));


    return 0;
}
