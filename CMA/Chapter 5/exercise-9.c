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

Exercise 9
Are the following if statements equivalent?If not. why not?

STATAMENT 1
if (score >= 90)
printf("A");
else if (score >= 80)
printf("B");
else if (score >= 70)
printf("C");
else if (score >= 60)
printf("D");
else
printf("F");

STATEMENT 2
if (score < 60)
printf("F");
else if (score < 70)
printf("D");
else if (score < 80)
printf("C");
else if (score < 90)
printf("B");
else
printf("A");

answer:
statement 1 does the check starting from checking if the score >= 90, from t here it filters the larger
and eventually the check on each elseif keeps getting smaller

statement 2 does the check stargin from < 60 so on each elseif the "filter" for larger and larger score

if we try score = 60
statement 1-> pass 1st if, 2nd, until it reaches 60 >= 60 which prints "D"
statement 2->pass through 1st if, goes to 2nd since 60 < 70 which also prints "D"

its basically the same jus the way the equality check is being arranged


*/

int main(void){
    int i,j;

    i = 1; j = 2;
    (i < j) ? -1 : (i > j) ? 1 : 0

    return 0;
}
