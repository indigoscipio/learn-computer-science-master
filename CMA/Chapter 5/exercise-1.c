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

The following program fragments illustrate the relational and equality operators. Show the
output produced by each, assuming that i, j. and k are int variables.
(a) i = 2; j = 3;
k = i * j == 6;
printf ("%d" , k) ;
( b) i = 5; j = 10; k = 1;
printf ( "%d" , k > i < j);
(C) i = 3; j = 2; k = 1;
printf ("%d" , i < j == j < k);
( d ) i = 3; j = 4; k = 5;
printf ("%d" , i % j + i < k) ;


*/

int main(void){
    int i,j,k;

    /*
    1st line - i = 2 , j = 3
    2nd line, multiple operations
    first do the mult then check euqality
    so k = (2 * 3) == 6 -> k = 6 == 6 -> k == 1 (true)
    so print should return "1"

    i = 2; j = 3;
    k = i * j == 6;
    printf ("%d", k) ;
    */


    /*
    PART B
    on the 2nd line, check euqliaty left associative so do
    (k > i) then ((k > i) < j) so
    (1 > 5) < j -> 0 < 10 -> true (1)
    so printf should return 1

    i = 5; j = 10; k = 1;
    printf ( "%d" , k > i < j);
    */

    /*
    PART C
    do the relational equality first hten do the == since it has lower precedence
    so (i < j) == (j < k) -> (3 < 2) == (2 < 1) -> 0 == 0 == 1
    so printf should reutrn true (1)

    i = 3; j = 2; k = 1;
    printf ("%d" , i < j == j < k);
    */

    /*
    PART D
    we have multiple oeprations here
    first do the %, then do the +, then do the <
    so it shol be (((3 % 4) + 3) < 5) -> ((3 + 3) < 5) -> (6 < 5) -> false/0
    so printf should be 0
    */
    i = 3; j = 4; k = 5;
    printf ("%d" , i % j + i < k) ;



    return 0;
}
