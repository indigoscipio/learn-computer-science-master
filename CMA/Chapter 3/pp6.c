#include <stdio.h>
/*
Modify ihe addf rac.c program of Section 3.2 so that the userenters both fractionsat the
same time, separated by a plus sign:
Enter two fractions separated by a plus sign: 5/'6+3/4
The sum is 38/24
*/

int main(void){
    int num1, denom1, num2, denom2, result_num, result_denom;

    printf("Please enter two fractions seperated by a plus sign: \n");
    scanf("%d/%d+%d/%d", &num1, &denom1, &num2, &denom2);

    result_num = num1 * denom2 + num2 * denom1;
    result_denom = denom1 * denom2;
    printf("your result is: %d/%d\n", result_num, result_denom);

    return 0;
    }
