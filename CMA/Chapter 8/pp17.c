/*
Write a program that prints an n x n magic square (a square arrangement of the numbers
I. 2
tr in which the sums of the rows, columns, and diagonals are all the same). The
user will specify the value of n:
This program creates a magic square of a specified size.
The size must be an odd number between 1 and 99.
Enter size of magic square: 5
17 24 1 8 15
23
7 14 16
4
5
6 13 20 22
10 12 19 21 3
11 18 25 2 9
182
Chapter 8 Arrays
Store the magic square in a two-dimensional array. Stan by placing the number 1 in the mid
dle of row 0. Place each of the remaining numbers 2. 3
ir by moving upone row and
over one column. Any attempt to go outside the bounds of the array should “wrap around”
to the opposite side of the array. For example, instead of storing the next number in row-I ,
we would store it in row n-1 (the last row). Instead of storing the next number in column //
.
we would store it in column 0. If a particular array element is already occupied, put the
number directly below the previously stored number. If your compiler supports variable
length arrays,declare the array to have n rows and n columns. If not . declare the array to
have 99 rows and 99 columns.

*/


#include <stdio.h>
#include <ctype.h>

int main(void) {
    int n, row, col, next_col, next_row;

    printf("Enter size of magic square: ");
    scanf("%d", &n);

    // store in 2d array
    int m_square[99][99] = {0};

    // place 1 in the mid of row 0
    row = 0;
    col = n/2;
    m_square[row][col] = 1;

    for(int num = 2; num <= n*n; num++){
        next_row = (row-1<0) ? n-1 : row-1;
        next_col = (col+1 >=n) ? 0 : col+1;

        if (m_square[next_row][next_col] != 0) {
        next_row = (row + 1 >= n) ? 0 : row + 1;
        next_col = col;
        }

        m_square[next_row][next_col] = num;
        row = next_row;
        col = next_col;
    }

    //prints the table
    for(int i=0;i<n;i++){
        for(int j=0; j<n;j++){
            printf("%02d  ",m_square[i][j]);
        }
        printf("\n");
    }


    return 0;
}
