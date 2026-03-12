#include <stdio.h>

/*
PP8
Modify Programming Project 7 so that it prompts for five quiz grades for each of five stu
dents. then computes the total score and average score for each student, and the average
score, high score, and low score for each quiz.

*/


#include <stdio.h>
#include <stdbool.h>
#include <ctype.h>
#define N 5

int main(void) {
    // quiz grades = COLS
    // students = ROWS
    int arr[N][N] = {0};
    int row, col, total_row, total_col;
    int total_row_arr[N] = {0}, total_col_arr[N]={0};
    int i,j,k;
    int lq_score=0, hq_score=0;

    for(row=0;row<N;row++){
        total_row=0;
        printf("Enter student %d grades: ",row+1);
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

    // iterate through each student
    // calculate total score & avg score for each student
    for(i=0;i<N;i++){
        printf("Student %d total quiz score: %d\n", i+1, total_row_arr[i]);
        printf("Student %d average quiz score: %d\n", i+1, total_row_arr[i]/N);
    }

    printf("\n");
    // iterate through each quiz
    // calc avg score, high score, and low score

    for(j=0;j<N;j++){
        //outer loop: student row
        lq_score = arr[0][j];
        hq_score = arr[0][j];

        for(k=0;k<N;k++){
            if(arr[k][j] > hq_score){
                hq_score = arr[k][j];
            }

            if(arr[k][j] < lq_score){
                lq_score = arr[k][j];
            }
        }

        printf("Average quiz score: %d\n", (float) total_col_arr[j]/N);
        printf("High quiz score score: %d\n", hq_score);
        printf("Low quiz score: %d\n", lq_score);
    }



    return 0;
}
