#include <stdio.h>
/*

PRECEDENCE LEVEL
1. ++ --
2. + -
3. * / %
4. + -
5. = *= etc


*/

int main(void){
    int i,j,k;

    /*
    Show the output produced by each of the following program fragments. Assume that i. j .
   and k are int variables.
    */
    /*
    PART A
    assign i = 1
    (i++ - 1) -> show i, then subtract it by 1 -> 1-1 = 0
    print "0"
    then increment i from the last ++
    next print should be 1+1 = 2
    so "0" -> "2"
    */
    i = 1;
    printf("%d ", i++ - 1);
    printf("%d", i) ;


    /*
    PART B
    1st line     i = 10; j = 5;
    first print -> show i = 10 (then increment next) - (increment j)
    so 10 - 6 = 4
    2nd print -> i = 11, j = 6
    */
    i = 10; j = 5;
    printf("%d ", i++ - ++j);
    printf("%d %d", i, j);

    /*
    PART C
    first line -> i = 7, j = 8
    1st print -> i = 7 (increment next) - 7 -> prints 0
    2nd print -> now i = 8 and j is still 7 -> 8,7
    */
    i = 7; j = 8;
    printf("%d ", i++ - --j)
    printf("%d %d", i, j);

    /*
    PART D
    first line -> i=3,j=4,k=5;
    1st print -> 2 operations, same precedence, do left first
    (i++ - j++) -> 3 - 4 (increment both i and j next) -> -1
    (-1 + --k) -> -1 + 4 -> result is 3

    2nd print ->
    i =4, j=5, k=4
    */
    i = 3; j = 4; k = 5;
    printf("%d ", i++ - j++ + --k);
    printf("%d %d %d", i, j, k);


    return 0;
}
