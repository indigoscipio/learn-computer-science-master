#include <stdio.h>
/*

PRECEDENCE LEVEL
1. ++ --
2. unary + -
3. * / %
4. + -
5. = *= etc

Give the values of i and j after each of the following expression statements has been exe
cuted. (Assume that i has the value 1 initially and j has the value 2.)

(a) i += j;
(b) i--;
(c) i * j / i;
(d) i % ++j;

answer:
a.
initially i = 1 and j =2.
then run i += j which is just i = i + j -> i = 1 + 2 -> i = 3
so now i = 3 and j = 2

b. initially i = 1 and j =2.
after we run i--, it shows "1" but the value i decrements to 0 afterward
so now i = 0 and j =2

c. initially i = 1 and j = 2
after we run i * j / i; which has multiple operations
first do (i * j) = 2 then divide by 1 so ((1 * 2) / 1) = (2 / 1) = 2
we don't have any assignment here so it just shows the arithmetic so the values i and j
are still i = 1 and j = 2

d. initally i = 1 and j = 2
then we run i % ++j;
we run the prefix increment first then the remainder so j = 3
1 % 3 = 0
so after we run the statement i is still 1 since we didn't assign but j = 3



*/

int main(void){
    int i,j,k;

    /*
Only one of the expressions ++i and i++ is exactly the same as (i += 1) ; which is it?
Justify your answer.
    */

    return 0;
}
