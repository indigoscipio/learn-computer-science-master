#include <stdio.h>
/*
CONVERSION SPECIFICATION
use % - liek a temporary placheolder
%m.px - m is the width
p is the precision, if its deicmal, how many deicmal pts
if its a integer, how many leading zero
by default c is right justified

HOW SCANF WORKS
is ther a sign?
are there digits (required)
is there decimal?
is there scientific notation?


*/

int main(void){
    int num1, denom1, num2, denom2, result_num, result_denom;

    printf("Please enter your first fraction: ");
    scanf("%d/%d", &num1, &denom1);


    printf("Please enter your second fraction: ");
    scanf("%d/%d", &num2, &denom2);

    result_num = num1 * denom2 + num2 * denom1;
    result_denom = denom1 * denom2;
    printf("your result is: %d/%d\n", result_num, result_denom);

    return 0;
}
