#include <stdio.h>
/*
Show how to modify the addf rac.c program of Section 3.2 so that the user is allowed to
enter fractions that contain spaces before and after each / character.


*/

int main(void){
    int num1, denom1, num2, denom2, result_num, result_denom;

    printf("Please enter your first fraction: ");
    scanf("%d / %d", &num1, &denom1);


    printf("Please enter your second fraction: ");
    scanf("%d / %d", &num2, &denom2);

    result_num = num1 * denom2 + num2 * denom1;
    result_denom = denom1 * denom2;
    printf("your result is: %d/%d\n", result_num, result_denom);

    return 0;
}
