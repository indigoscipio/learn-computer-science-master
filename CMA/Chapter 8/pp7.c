#include <stdio.h>

/*
PP7
Write a program that reads a 5 x 5 array of integers and then prints the row sums and the
column sums:

Enter row 1: 8 3 9 0 10
Enter row 2: 3 5 17 1 1
Enter row 3: 2 8 6 23 1
Enter row 4: 15 7 3 2 9
Enter row 5: 6 14 2 6 0

Row totals: 30 27 40 36 28
Column totals: 34 37 37 32 21

*/


#include <stdio.h>
#include <stdbool.h>
#include <ctype.h>
#define N 5

int main(void) {
    int arr[N][N] = {0};
    int row, col, total_row, total_col;
    int total_row_arr[N] = {0}, total_col_arr[N]={0};
    int i,j;

    for(row=0;row<N;row++){
        total_row=0;
        printf("Enter row %d: ",row+1);
        // get the total row

        for(col=0;col<N;col++){
            //get the total col
            total_col=0;
            scanf("%d", &arr[row][col]);

            //sum each col bucket one at a time for each row
            total_col_arr[col]+=arr[row][col];

            total_row+=arr[row][col];
        }

        //end of row, sum the total row
        total_row_arr[row] = total_row;
    }

    printf("Row totals: ");
    for(i=0;i<N;i++){
        printf("%d ",total_row_arr[i]);
    }
    printf("\n");
    printf("Col totals: ");
    for(j=0;j<N;j++){
        printf("%d ",total_col_arr[j]);
    }

    return 0;
}
