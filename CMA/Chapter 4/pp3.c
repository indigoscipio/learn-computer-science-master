#include <stdio.h>

/*
PRECEDENCE LEVEL
1. ++ --
2. unary + -
3. * / %
4. + -
5. = *= etc

PP 2
Rewrite the program in Programming Project 2 so that it prints the reversal of a three-digit
number without using arithmetic to split the number into digits. Hint: See the upc . c pro
gram of Section 4.1.
*/

int main(void){
    int d1,d2,d3;

    printf("Enter a three digit number: \n");
    scanf("%1d%1d%1d", &d1,&d2,&d3);

    printf("The reversal is: %d%d%d",d3,d2,d1);

    return 0;
}
