
#include <stdio.h>
#include <stdbool.h>

/*
Exercise 12
Write the following function:

double inner_product (double a [] , double b[] , int n);
The function shouldreturn a [0] * b [0 ] + a [l] * b [l] + ... +a [n-l] * b [n-l].

*/

#include <ctype.h>
#define N 5

double inner_product(double a[], double b[], int n){
    double sum = 0;

    for(int i=0;i<n;i++){
        sum+=a[i]*b[i];
    }

    return sum;
}

int main(void){
    double a[N] = {1.00,2.00,3.00,4.00,5.00};
    double b[N] = {10.00,9.00,8.00,7.00,6.00};


    printf("Result is: %f",inner_product(a,b,N));

    return 0;
}

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
