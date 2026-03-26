
#include <stdio.h>
#include <stdbool.h>

/*
Exercise 17
rewrite the fact function so that it 's no longer recursive

answer:
*/

#include <ctype.h>
#define N 8

int fact(int n){
    int result = 1;

    /*with for
    for(int i=n; i>0; i--){
        result*=i;
    }
    */

    //with while
    int i=n;
    while(i>0){
        result*=i;
        i--;
    }

    return result;
}

int main(void){


    printf("%d", fact(6));

    return 0;
}

/*

*/
