
#include <stdio.h>
#include <stdbool.h>

/*
Exercise 7

Suppose that the function f has the following definition:
int f ( int a, int b) { . }
Which of the following statements are legal? (Assume that i has type int and x has type
double. )
(a) i = f (83, 12) ;
(b) x = f (83, 12) ;
(c) i = f (3.15, 9.28) ;
(d) x = f (3.15, 9.28) ;
(e) f (83, 12) ;
*/
int digit(int n,int k);
int num_digits(int n);


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

