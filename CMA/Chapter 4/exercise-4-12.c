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
    Show the output produced by each of the following program fragments. Assume that i and
    jare int variables.
    */
    /*
    PART A
    1st line -> assign i to 5
    2nd line we have multiple operators
    first do the ++ since it has higher precedence, then multiply, then do the subtract last
    j = 6 (prefix ++) * 3 - 2 -> 18 - 2 -> 16
    print should be something like "6, 16"
    */
    i = 5;
    j = ++i * 3 - 2;
    printf("%d %d", i, j);

    /*
    PART B
    first line -> asign j to 5
    2nd line we have mltiple oeprators
    first do the i++, then do the multiply, then the ubstraction last
    j = 3 - (2 * 5) -> increment i aftewards -> j = 3 - 10 -> j = -7
    by now i = 6 inctemented and j = -7
    so print should be something like "6, -7"
    */
    i = 5;
    j = 3 - 2 * i++;
    printf("%d %d", i, j);

    /*
    PART C
    first assign i =7
    next line multiple operation
    first do the postfix decrement, then multiply, then +
    j = (3 * 7) + 2 -> 21 + 2 = 23
    now decrement the i, i = 6
    and j = 23
    print should be something like "6, 23"
    */
    i = 7;
    j = 3 * i-- + 2;
    printf("%d %d", i, j);

    /*
    PART D

    */

    return 0;
}
