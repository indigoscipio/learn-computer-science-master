#include <stdio.h>

/*
PP9
Write a program that generates a “random walk" across a 10 x 10 array. The array will con
tain characters (all ' . ’ initially). The program must randomly “walk" from element to ele
ment, always going up. down. left, or right by one element. The elements visited by the
program will be labeled with the letters A through Z, in the order visited. Here's an example
of the desired output:

A . . . . . . . . .
B C D . . . . . . .
. F E . . . . . . .
H G . . . . . . . .
I . . . . . . . . .
J . . . . . . . Z .
K . . R S T U V Y .
L M P Q . . . W X .
. N O . . . . . . .
. . . . . . . . . .

Hint: Use the srand and rand functions (see deal.c)to generate random numbers.
After generating a number, look at its remainder when divided by 4. There are four possible
values for the remainder—0. 1. 2.and 3—indicating the direction of the next move. Before
performing a move, check that (a) it won’t go outside the array, and (b) it doesn’t take us to
an element that already has a letter assigned. II 'either condition is violated , try moving in
another direction. If all four directions are blocked , the program must terminate. Here’s an
example of premature termination:

A B G H I . . . . .
. C F . J K . . . .
. D E . M L . . . .
. . . . N O . . . .
. . W X Y P Q . . .
. . V U T S R . . .
. . . . . . . . . .
. . . . . . . . . .
. . . . . . . . . .


Y is blocked on all four sides,so there’s no place to put Z.

*/


#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#define N 10

int main(void) {
    int i,j,k, random_num;
    bool is_valid_arr[4] = {0};
    char arr[N][N] = {{'.','.','.','.','.','.','.','.','.','.'},
                    {'.','.','.','.','.','.','.','.','.','.'},
                    {'.','.','.','.','.','.','.','.','.','.'},
                    {'.','.','.','.','.','.','.','.','.','.'},
                    {'.','.','.','.','.','.','.','.','.','.'},
                    {'.','.','.','.','.','.','.','.','.','.'},
                    {'.','.','.','.','.','.','.','.','.','.'},
                    {'.','.','.','.','.','.','.','.','.','.'},
                    {'.','.','.','.','.','.','.','.','.','.'},
                    {'.','.','.','.','.','.','.','.','.','.'}};

    char alphabets[26] = {'A','B','C','D','E','F','G',
                        'H','I','J','K','L','M','N','O',
                        'P','Q','R','S','T','U',
                        'V','W','X','Y','Z'};


    //start from top left
    arr[0][0] = alphabets[i];
    int curr_col=0, curr_row=0, next_row, next_col;

    for(i=1;i<26;i++){
        bool moved = false;
        int attempts = 0;

        while(!moved && attempts < 100){
            random_num = rand() % 4;

            next_row = curr_row;
            next_col = curr_col;

            switch(random_num){
                case 0:
                    next_row = curr_row - 1;
                    break;
                case 1:
                    next_col = curr_col + 1;
                    break;
                case 2:
                    next_row = curr_row + 1;
                    break;
                case 3:
                    next_col = curr_col - 1;
                    break;
            }

            if((next_row >= 0 && next_row < 10) &&
                (next_col >=0 && next_col < 10)&&
                arr[next_row][next_col] == '.' ){


                arr[next_row][next_col]=alphabets[i];
                curr_col = next_col;
                curr_row = next_row;
                moved = true;
            }

            attempts++;
        }

        if(!moved) break;
    }

    for(j=0;j<N;j++){
        for(k=0;k<N;k++){
            printf("%c ", arr[j][k]);
        }
        printf("\n");
    }


    return 0;
}
