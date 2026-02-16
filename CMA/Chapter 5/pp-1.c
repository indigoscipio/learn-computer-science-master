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


Write a program that calculates how many digits a number contains:

Enter a number: 374
The number 374 has 3 digits

You may assume that the number has no more than four digits.
Hint: Use if statements to test the number. For example,
if the number is between 0 and 9. it has one digit. If the num
ber is between 10 and 99. it has two digits.

*/

int main(void){
    int num_input, digits;

    printf("Enter a number: \n");
    scanf("%d", &num_input);

    /*If statement version
   if(num_input > 999){
    digits = 4;
   }else if (num_input > 99){
    digits = 3;
   }
    else if(num_input > 9){
    digits = 2;
    }
    else{
    digits = 1;
    }
    printf("The number %d has %d digits", num_input, digits);
    */

    /*Ternary version*/
    digits = (num_input > 999) ? 4 :
         (num_input > 99)  ? 3 :
         (num_input > 9)   ? 2 : 1;
    printf("The number %d has %d digits", num_input, digits);

    return 0;
}
