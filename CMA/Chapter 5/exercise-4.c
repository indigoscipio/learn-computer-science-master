#include <stdio.h>

/*
PRECEDENCE LEVEL
1. Postfix/Unary: ++, --, !, +, -
2. Mult: *, /, %
3. Add: +, -
4. Relational: >, <, <=, >= (left associative)
5. Equality: ==, !=
6. Logical AND: &&
7. Logical OR: ||
8. Assignment: =, *=, +=, ==, !=, etc



(a) i = 3; j = 4; k = 5;
printf("%d ", i < j
printf("%d %d %d", i, j, k);
++j < k);
(b) i = 7; j = 8; k = 9;
printf("%d ", i
7 Sc& j++ < k);
printf("%d %d %d", i, j, k);
(C) i = 7; j = 8; k = 9;
printf("%d ", (i = j)||(j = k));
printf("%d %d %d", i, j, k);
(d) i = 1; j = 1; k = 1;
printf("%d ", 4+i ||++j && ++k);
printf("%d %d %d", i, j, k);

*/

int main(void){
    int i,j,k;

    /*
    The following program fragments illustrate the short-circuit behavior of logical expressions.
    Show' the output produced by each, assuming that i. j.and k are int variables.
    */

    /*
    PART A
    first do the postfix, then relational, then or ooperator last by precednece level
    so (i < j) || ((++j) < k) -> (3 < 4) || (++j < k) -> since 1st part is true OR stops evaluating the 2nd one
    so i = 3, j = 4, k = 5-> "3 4 5"

        i = 3; j = 4; k = 5;
    printf("%d ", i < j || ++j < k)
    printf("%d %d %d", i, j, k);
    */



    /*
    PART B
    first check 1st expr (i - 7) and check if istrue
    (7 - 7) = 0 so false which is the second printf
    so the rest of the expression is not being evaluated
    ijk stays as it is so third printf = 7,8,9

        i = 7; j = 8; k = 9;
    printf("%d ", i - 7 && j++ < k);
    printf("%d %d %d", i,j,k)
    */


    /*
    PART C
    first check the left side of or and check if its true
    this is an assignment that make i = 8
    8 || -> since 8 is nonzero its already trye. so second printf returns 1 and resto f hte expression iddn't checked
    so third printf prints 8,8,9

        i = 7; j = 8; k = 9;
    printf("%d ", (i = j)||(j = k));
    printf("%d %d %d", i, j, k);
    */


    /*
    PART D
    first do the left side
    ++i -> 2 || -> this is true so stop eval the rest, econd printf returns 1
    and third printf should be 2,1,1

    */
    i = 1; j = 1; k = 1;
    printf("%d ", ++i || ++j && ++k);
    printf("%d %d %d", i, j, k);

    return 0;
}
