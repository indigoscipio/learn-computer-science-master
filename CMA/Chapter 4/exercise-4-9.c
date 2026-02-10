#include <stdio.h>
/*

PRECEDENCE LEVEL
1. ++ --
2. + -
3. * / %
4. + -
5. = *= etc

Show the output produced by each of the following program fragments. Assume that i. j.
and k are int variables.


(e) i = 1; j = 2; k = 3;
i-= j-= k;
printf ("%d %d %d", if j, k) ;

(d) i = 2; j = 1; k = 0;
i *= j *= k;
printf ( "%d %d %d", i, j, k) ;


*/

int main(void){
    int i,j,k;

    /*PART A
    do the sum first then *=
    so i *= 9 -> i = 7 * 9 -> i = 63

    i = 7; j = 8;
    i *= j + 1;
    printf ("%d %d", i, j);
    */


    /*PART B
    right associative, do (j +=k) first then (i += (j += k))
    so j += 1 -> j = 2
    i += 2 -> i = 3
    print should be something like 3,2,1

    i = j = k = 1;
    i += j += k;
    printf ("%d %d %d", i, j, k);
    */

    /*
    PART C
    here its same, right associative since same asignment low priorty
    first do (j -= k) then (i -= (j -=k))
    so j -= 3 -> j = 2-3 -> j = -1
    next i -= -1 -> i = 1 - (-1) = 2
    so the result should be "2 -1 3"

        i = 1; j = 2; k = 3;
    i-= j-= k;
    printf ("%d %d %d", i, j, k) ;
    */

    /*
    PART D
    same as part c and d, right associative
    first do (j *= k), then do (i *= (j *= k))
    j *= 0 -> j = 1 * 0 -> j = 0
    i *= 0 -> i = 2 * 0 -> i = 0
    so the result should be "0 0 0"
    */
    i = 2; j = 1; k = 0;
    i *= j *= k;
    printf ( "%d %d %d", i, j, k);




    return 0;
}
