#include <stdio.h>

/*
PRECEDENCE LEVEL
1. ++ --
2. unary + -
3. * / %
4. + -
5. = *= etc

PP 4
Write a program that reads an integer entered by the user and displays it in octal (base 8):

Enter a number between 0 and 32767: 1953
In octal, your number is: 03641

The output should be displayed using five digits,even if fewer digits are sufficient.
Hint: Toconvert the number to octal,
First divide it by 8; the remainder is the last digit of the octal number (1, in this case).
Then divide the original number by 8 and repeat the process to arrive at the next-to-last digit,
(printf is capable of displaying numbers in base 8.as we'll
see in Chapter 7. so there's actually an easier way to write this program.)

*/

int main(void){
    int input_d,d1,d2,d3,d4,d5;

    printf("Enter a number between 0 and 32767: \n");
    scanf("%d", &input_d);

    /*
    divide by 8
    the remainder the the las digit
    digive the original number by 8 and repeat the process to arrive at the next ot last digit
    */
    d1 = input_d % 8;
    d2 = ((input_d / 8) % 8);
    d3 = ((input_d / 64) % 8);
    d4 = ((input_d / 512) % 8);
    d5 = ((input_d / 4096) % 8);

    printf("In octal, your number is: %d%d%d%d%d \n", d5,d4,d3,d2,d1);

    return 0;
}
