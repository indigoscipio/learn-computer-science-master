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

SLECTION
IF, SWITCH

ITERATION
WHILE, DO, FOR

JUMP
BREAK, CONTINUE, GOTO


in C, 0 always represents false
any other number repreents true

Relational operator
<, >, <=, >=

Ternary Operator
its like mini if's for math expressions

*/

int main(void){
    int num;

    num = 5;
    if(num == 5)
        {
        printf("Nm is 5");
        num++;
        printf("%d", num);
        }
    else printf("num is not 5");

    return 0;
}
