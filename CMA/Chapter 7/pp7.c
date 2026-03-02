#include <stdio.h>

/*
PP7

Modify Programming Project 6 from Chapter 3 so that the user may add, subtract, multiply,
or divide two fractions (by entering either + - * or / between the fractions).
*/


#include <stdio.h>
int main(void) {

    int num1, denom1, num2, denom2, result_num, result_denom;
    char op_sign;

    printf("Please enter two fractions seperated by a operator sign (+,-,*,/): \n");
    scanf("%d/%d%c%d/%d", &num1, &denom1, &op_sign, &num2, &denom2);

    if(op_sign == '+'){
        result_num = num1 * denom2 + num2 * denom1;
        result_denom = denom1 * denom2;
    }else if(op_sign == '-'){
        result_num = num1 * denom2 - num2 * denom1;
        result_denom = denom1 * denom2;
    }else if(op_sign == '*'){
        result_num = num1 * num2;
        result_denom = denom1 * denom2;
    }else{
        result_num = num1 * denom2;
        result_denom = denom1 * num2;
    }

    printf("your result is: %d/%d\n", result_num, result_denom);


    return 0;
}
