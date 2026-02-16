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

PP4
Here's a simplified version of the Beaufort scale, which is used to estimate wind force:
Speed ( knots)
Less than 1
1-3
4-27
28-17
48-63
Above 63
Description
Calm
Light air
Breeze
Gale
Storm
Hurricane
Write a program that asks the user to enter a wind speed ( in knots), then displays the corre
sponding description.

*/

int main(void){
    int knot;

    printf("Enter wind speed (in knots): ");
    scanf("%d", &knot);

    if(knot<1){
        printf("Calm");
    }else if(knot <= 3){
        printf("Light air");
    }else if(knot <=27){
        printf("Breeze");
    }else if(knot <=47){
        printf("Gale");
    }else if(knot <=63){
        printf("Storm");
    }else{
        printf("Hurricane");
    }

    return 0;
}
