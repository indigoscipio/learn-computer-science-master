/*
PP3
Modify Programming Project 9 from Chapter 8so that it includes the following functions:

void generate_random _walk (char walkflO] [10] ) ;
void print array (char walk [10] [10] ) ;
main first calls generate_random
_walk. which initializes the array to contain ' . '
characters and then replaces some of these characters by the letters A through Z. as
described in the original project,
main then calls print _array to display the array on

*/

#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#define N 10

void generate_random_walk(char walk[N][N]){
    //fill whole array with '.'
    for(int i=0; i<N;i++){
        for(int j=0;j<N;j++){
            walk[i][j] = '.';
        }
    }

    //replace with random walk value/logic for random walk
    walk[0][0] = 'A';
    int curr_col=0, curr_row=0, next_row, next_col, random_num;

    for(int i=1;i<26;i++){
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
                walk[next_row][next_col] == '.' ){


                walk[next_row][next_col]='A' + i;
                curr_col = next_col;
                curr_row = next_row;
                moved = true;
            }
            attempts++;
        }

        if(!moved) break;
    }
}

void print_array(char walk[][N]){
    //prints the result
    for(int i=0;i<N;i++){
        for(int j=0;j<N;j++){
            printf("%c ", walk[i][j]);
        }
        printf("\n");
    }
}

int main(void) {
    srand(time(NULL));
    char walk[N][N] = {0};
    generate_random_walk(walk);
    print_array(walk);


    return 0;
}
