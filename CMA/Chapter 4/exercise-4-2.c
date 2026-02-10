#include <stdio.h>
/*

PRECEDENCE LEVEL
1. ++ --
2. + -
3. * / %
4. + -
5. = *= etc

2. If i and j arc positive integers,does (-i)/j always have the same valueas as -(i/j)? Jus
tify your answer.

answr:
ok lets try evaluating this step by step with small example
let i = 1, j = 2

first (-i)/j
evaluates the unary first, then do the division
-1 / 2 = -0.5 = 0

second -(i/j)
do the operation in the parenthesis first then do the unary negation
1/2 -> -(1/2) = -1/2 = -0.5 = 0

it seems they have an equal value if i and j are both positive integer



*/

int main(void){
    int i,j,k;

    /*
    i = 5;
    j = 3;
    printf("%d %d", i / j, i % j);
    */
    /*should be 1 2*/

    /*
    i = 2;
    j = 3;
    printf("%d", (i + 10) % j);
    */
    /* should be 12 % 3 = 0*/


    /*
    i = 7;
    j = 8;
    k = 9;
    printf("%d", (i + 10) % k / j);
    */
    /* should be 17 % 9 = 8, then 8 / 8 = 1*/


    i = 1;
    j = 2;
    k = 3;
    printf("%d", (i + 5) % (j + 2) / k);
    /* should be 6 % 4 / 3, so 2 / 3 = 0*/


    return 0;
}
