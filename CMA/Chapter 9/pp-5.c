/*
PP5
Modify Programming Project 17 from Chapter 8 so that it includes the following functions:
void create_magic_square (int n, char magic _square [n] [n] ) ;
void print _magic_square (int n, char magic_square[n] [n] ) ;
After obtaining the number // from the user, main will call create _magic_square.
passing it an /; x n array that is declared inside main. create
_magic_square will fill
the array with the numbers I. 2, ....ir as described in the original project,
main will then
call prmt_magic_square. which will display the array in the format described in the
original project. Note: If your compiler doesn’t support variable-length arrays, declare the
array in main to be 99 x 99 instead of;/ x n and use the following prototypes instead:
void create
_magic
_squdre (int n, char magic
_square[99] [99] ) ;
void print_magic_square (int n, char magic_square[99] [99] )


*/

#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <ctype.h>
#define N 99

void create_magic_square(int n, char magic_square[n][n]){
    int row, col, next_col, next_row;

    return;
}

void print_magic_square(int n, char magic_square[n][n]){
    return;
}



int main(void) {
    int n;

    printf("Enter size of magic square: ");
    scanf("%d", &n);

    int a[n][n];
    for(int i=0;i<n;i++){
        for(int j=0;j<n;j++){
            a[i][j]=0;
        }
    }
    create_magic_square(n, a);



    return 0;
}
