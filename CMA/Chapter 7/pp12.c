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
    char ch, op;
    float result_so_far, next_value;


    printf("Enter expression: \n");
    scanf("%f", &result_so_far);
    while(op != '\n'){
        //look for operator
        scanf(" %c", &op);

        //read next number if there's an operator
        scanf("%f", &next_value);


        //do math, update result so far
        switch(op){
            case '+':
                result_so_far += next_value;
                break;
            case '-':
                result_so_far -= next_value;
                break;
            case '*':
                result_so_far *= next_value;
                break;
            case '/':
                result_so_far /= next_value;
                break;
            default:
                printf("Invalid Operator");
                break;
        }





        //otherwise exit
    }
    printf("The value of expression is: %f", result_so_far);

    return 0;
}
