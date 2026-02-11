#include <stdio.h>

/*
PRECEDENCE LEVEL
1. ++ --
2. unary + -
3. * / %
4. + -
5. = *= etc

PP 2
Extend the program in Programming Project I to handle tree digit numbers
*/

int main(void){
    int digits, base, tens, hundreds;

    printf("Enter a three digit number: \n");
    scanf("%d", &digits);

    /* 123
    hundred = 123 / 100 = 1
    tens = (123 - 100) / 10 = 2
    base = (123 - 100) % 10 = 3
    using the logic lets try to reverse

    now base = hundreds, hundreds = base and tens stays the same
    */
    hundreds = (digits / 100);
    tens = ((digits % 100) / 10) ;
    base = (digits % 10);
    printf("The reversal is: %d%d%d", base,tens,hundreds);

    return 0;
}
