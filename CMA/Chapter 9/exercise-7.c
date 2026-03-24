
#include <stdio.h>
#include <stdbool.h>

/*
Exercise 7

Suppose that the function f has the following definition:
int f ( int a, int b) { ... }
Which of the following statements are legal? (Assume that i has type int and x has type
double. )
(a) i = f (83, 12) ;
(b) x = f (83, 12) ;
(c) i = f (3.15, 9.28) ;
(d) x = f (3.15, 9.28) ;
(e) f (83, 12) ;

answer
lets analyze one by one
a. i = f(83,12);
since the functino f is being fed 2 integers (83,12)
it follows the argument type so its legal.
it stores the result of the computation into i

b. here x is double but we assign into result of the function which is int
so its trying to assigne double = int
im guessing this is still legal but the result would be ocnverted to double

c. here we assign i to the result of f
we fed 2 floats into f which expects 2 ints
so im guessing it will get cut off so instead of 3.15 and 9.12 it will turn into
3 and 9. so itss still legal but the cmputation would be different/get cut off

d. same as c, but since f is expected to return int
so still legal but since x is double the reuslt of the function computation get cut off

e. here we dont have any sasignment just calling the function f
so its legal sice its passing 2 ints



*/
int f(int a, int b){
    return a + b;
}

int main(void){
    double x;

    x = f(83.55,12.88);
    printf("%d", x);

    return 0;
}

/*
racket version
(cond []
      [])
*/

