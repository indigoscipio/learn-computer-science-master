#include <stdio.h>
/*

PRECEDENCE LEVEL
1. ++ --
2. unary + -
3. * / %
4. + -
5. = *= etc

Supply parentheses to show how a Ccompiler would interpret each of the following expres
sions.

(a) a * b - c * d + e
(b) a / b % c / d
(c) - a - b + d - + d
(d) a * - b / c - d

answer:
a. (((a * b) - (c * d)) + e)
do the muilt, then since - and + have the same precende do left associatie whoever is first

b. (((a / b) % c) / d)
here since / and % have the same precende just do left associative whoever is first

c. ((((-a) - b) + d) - (+d))
do the unary - and + first then since + and - hae the same precedence do left associative

d. (((a * (-b)) / c) - d)
do unary first -> then mult and divide, then subtraction

*/

int main(void){
    int i,j,k;

    /*
Only one of the expressions ++i and i++ is exactly the same as (i += 1) ; which is it?
Justify your answer.
    */

    return 0;
}
