#include <stdio.h>
/*

PRECEDENCE LEVEL
1. ++ --
2. + -
3. * / %
4. + -
5. = *= etc

Show the output produced by each of the following program fragments. Assume that i. j,
and k are int variables.
(a) i = 5; j = 3;
printf ("%d %d", i / j, i % j);
(b) i- 2; j- 3;
printf ("%d", (i + 10) % j) ;
(c) i = 7; j = 8; k = 9;
printf ("%d", (i + 10) % k / j) ;
Exercises
(d) i = 1; j = 2; k = 3;
printf ( "%d", (i + 5) % ( j + 2) / k);

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
