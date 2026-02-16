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


Write a single expression whose value is either-1, 0, or +1, depending on whether i is less
than, equal to,or greater than j. respectively

*/

int main(void){
    int i,j;

    i = 3; j=2;
    if(i < j){
        printf("-1");
    }else if (i == j){
        printf("0");
    }else {
        printf("1");
    }

    return 0;
}
