#include <stdio.h>
/*

PRECEDENCE LEVEL
1. ++ --
2. + -
3. * / %
4. + -
5. = *= etc

The algorithm forcomputing the UPC check digit ends with the following steps:
Subtract I from the total.
Compute the remainder when the adjusted total is divided by 10.
Subtract the remainder from 9.
It’s tempting to try to simplify the algorithm by using these steps instead:
Compute the remainder when the total is divided by 10.
Subtract the remainder from 10.
Why doesn't this technique work?

answer:
coz the UPC last dgit need to be a single digit
if we do % 10 it might end up with 2 digit
the subtract 1 method ensure when its a multiply of 10
the result stay within 0 - 9 range


*/

int main(void){
    int i,j,k;
    return 0;
}
