#include <stdio.h>
/*

PRECEDENCE LEVEL
1. ++ --
2. unary + -
3. * / %
4. + -
5. = *= etc

Write a program that asks the user to enter a two-digit number, then prints the number with
its digits reversed. A session w ith the program should have the following appearance:
Enter a two-digit number: 2
_8
The reversal is: 82
Read the number using %d.then break it into two digits. Hint: If n is an integer, then n % 10


*/

int main(void){
    int digits, fst_d, sec_d;

    printf("Enter a two digit number: \n");
    scanf("%d", &digits);

    fst_d = (digits / 10);
    sec_d = ((digits % 10) * 10);
    printf("The reversal is: %d", sec_d + fst_d);

    return 0;
}
