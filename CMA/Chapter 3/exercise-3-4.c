#include <stdio.h>
/*
Suppose that we call scanf as follows:
scanf ("%d%f%d", &i , &x, &j) ;
If the user enters
10.3 5 6
what will be the values of i. x. and j after the call?
(Assume that i and j are int variables and x isa float variable.)

answer:
i -> sees 10, then - sees dot. i = 10
x -> sees .3 -> sees space -> stops. x = 0.3
j -> sees 5 - sees space - stops. j = 5



*/

int main(void){
    float x;

    scanf("%f ", &x);
    printf("%f", x);

    return 0;
}
