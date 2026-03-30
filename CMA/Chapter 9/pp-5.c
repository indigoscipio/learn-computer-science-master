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

void create_magic_square(int n, char magic_square[n][n]){
    int row=0, col=n/2, next_col, next_row;

    //fill up first num
    magic_square[row][col] = 1;

    for(int num = 2; num <= n*n; num++){
        next_row = (row-1<0) ? n-1 : row-1;
        next_col = (col+1 >=n) ? 0 : col+1;

        if (magic_square[next_row][next_col] != 0) {
        next_row = (row + 1 >= n) ? 0 : row + 1;
        next_col = col;
        }

        magic_square[next_row][next_col] = num;
        row = next_row;
        col = next_col;
    }

}

void print_magic_square(int n, char magic_square[n][n]){
    for(int i=0;i<n;i++){
        for(int j=0; j<n;j++){
            printf("%02d  ",magic_square[i][j]);
        }
        printf("\n");
    }
}



int main(void) {
    int n;

    printf("Enter size of magic square: ");
    scanf("%d", &n);

    // fill up the array
    char a[n][n];
    for(int i=0;i<n;i++){
        for(int j=0;j<n;j++){
            a[i][j]=0;
        }
    }

    create_magic_square(n, a);
    print_magic_square(n,a);

    return 0;
}
