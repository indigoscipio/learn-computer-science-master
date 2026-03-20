
#include <stdio.h>
#include <stdbool.h>

/*
Exercise 2

Writeafunction check( x, y, n) that returns l if both xand y fall between 0and n-I .
inclusive. The function should return 0otherwise. Assume that x. y. and n are all of type
int.

*/


int check(int x, int y, int n){
    if(x >= 0 && x <= n-1 && y >=0 && y <= n-1){
        return 1;
    }else{
        return 0;
    }

}

int main(void){
    printf("%d", check(0, -1, 1));

    return 0;
}
