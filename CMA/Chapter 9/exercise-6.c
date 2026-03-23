
#include <stdio.h>
#include <stdbool.h>

/*
Exercise 6
Write a function digit ( n, k) that returns the k'/!digit ( from the right) in n (a posi
tive integer). For example, digit ( 829, 1) returns 9. diqit ( 829, 2) returns 2. and
digit ( 829, 3) returns 8. If k is greater than the number of digits in n. have the func
tion return 0.

*/
int digit(int n,int k);
int num_digits(int n);

// assume k is positive int
int digit(int n, int k){

    if(k>num_digits(n)) return 0;

    if(k==1){
        return (n % 10);
    }
    return digit(n/10,k-1);
}

int num_digits(int n){
    if(n < 1){
        return n;
    }else{
        return (1 + num_digits(n / 10));
    }

}

int main(void){
    printf("%d\n", digit(829,1));
    printf("%d\n", digit(829,2));
    printf("%d\n", digit(829,3));
    printf("%d\n", digit(829,4));
    return 0;
}

/*
racket version
(cond []
      [])
*/

