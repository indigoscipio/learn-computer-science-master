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
    PART A
    i is 6
    next line we do two assignments
    lets eval (i += i) -> i = i + i -> i = 6 + 6 -> 1 = 12
    now i is assigned a new value, i = 12
    and assign j = 12
    so the result should be "12, 12"
    */
    i = 6;
    j = i += i;
    printf("%d %d", i, j);

    /*
    PART B
    i is 5
    next line we have multiple operations
    first is (i -= 2) -> i = i - 2 -> i = 5 - 2 -> i = 3
    so now i = 3
    next eval j -> 3 + 1 = 4
    so the result should be "3, 4"
    */
    i = 5;
    j = (i-= 2) + 1;
    printf("%d %d", i, j);


    /*
    PART C
    i is 7
    then next line we have multiple operations
    (i = 2.5) -> now i has a new value which is 2.5 but since we asumed ijk are integer i = 2
    next eval j = 6 + 2 = 8
    so it should print something like
    "2, 8"
    */
    i = 7;
    j = 6 + (i = 2.5);
    printf("%d %d", i, j);

    /*
    PART D
    first assign i = 2 and j = 8
    next lien we have multiple operations
    (i = 6) -> now i = 6
    (j = 3) -> now j = 3
    compute j -> j = 6 + 3 -> j = 9
    result should be something like "6, 9"
    */
     i = 2; j = 8;
    j = (i = 6) + (j = 3);
    printf("%d %d", i, j);

    return 0;
}
