#include <stdio.h>

/*

PP11

Write a program that evaluates an expression:
Enter an expression: 1+2.5*3
Value of expression: 10.5

The operands in the expression are floating-point numbers; the operators are
+ - * and /.
The expression is evaluated from left to right (no operator takes precedence over any other operator).
*/


#include <stdio.h>

int main(void) {
    char ch, op = ' ';
    float result_so_far, next_value;


    printf("Enter expression: \n");
    scanf("%f", &result_so_far);

    while(op != '\n'){
        //get the operator
        op = getchar();

        if(op == '\n'){
            break;
        }

       //do math, update result so far
        //get the next number
        switch(op){
            case '+':
                scanf("%f", &next_value);
                result_so_far += next_value;
                break;
            case '-':
                scanf("%f", &next_value);
                result_so_far -= next_value;
                break;
            case '*':
                scanf("%f", &next_value);
                result_so_far *= next_value;
                break;
            case '/':
                scanf("%f", &next_value);
                result_so_far /= next_value;
                break;
            default:
                break;
        }

    }
    printf("The value of expression is: %f", result_so_far);

    return 0;
}
