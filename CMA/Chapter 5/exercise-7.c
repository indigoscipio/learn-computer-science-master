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

Exercise 7
What does the following statement print if i has the value 17?
What does it print if i has the value-17?

printf("%d\n", i >= 0 ? i : -i);

answer:
if i = 17
first do the check 17 >= 0 which istrue, so it returns i which is 17 itself

if i = 017
the check fails since -17 >= 0 is false, so it returns the -(-17) which is 17

this looks like a abs operation


*/

int main(void){
    int i,j;

    i = 1; j = 2;
    (i < j) ? -1 : (i > j) ? 1 : 0

    return 0;
}
