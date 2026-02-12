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

The following program fragments illustrate the logical operators. Show the output produced
by each, assuming that i. j.and k are int variables.
(a) i- 10; j = 5;
printf("%d", !i < j);
( b) i = 2; j = 1;
printf("%d", Mi + !j);
(C) i = 5; j = 0; k =-5;
printf("%d", i && j ||k);
(d) i = 1; j = 2; k = 3;
printf("%d", i < j || k);

*/

int main(void){
    int i,j,k;

    /*
    PART A
    first check the unary engation, then the relational <
    since i is nonzero its true. and the negation of that is false. so i = 0
    then 0 < 5 which is true so printf should return true/1

    i = 10; j = 5;
    printf("%d", !i < j);
    */

    /*
    PART B
    first chekc the unary negation first then sum
    !!i = !(!2) -> !(0) -> 1
    !j = !1 -> 0
    sum them 1 + 0 = 1
    so printf should reutrn "1"
    */
    i = 2; j = 1;
    printf("%d", !!i + !j);

    /*
    PART C
    do the logical and since it has higher precendece ifst
    so (i && j) || k -> (5 && 0) || -5 -> 0 || -5 -> true/1
    so printf should return "1"
    */
    i = 5; j = 0; k =-5;
    printf("%d", i && j ||k);

    /*
    PART D
    do the relational first then do the || since it has higher precedence
    so (1 < 2) || 3 -> 1 || 3 -> true/1
    so printf should return true/1
    */
    i = 1; j = 2; k = 3;
    printf("%d", i < j || k);


    return 0;
}
