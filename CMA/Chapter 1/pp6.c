#include <stdio.h>
/*
PP6
Wodify the program of Programming Project 5 so that the polynomial is evaluated using the
following formula:
((((3x + 2)x-5)x-1)x + 7)x-6)
Note that the modified program performs fewer multiplications. This technique for evaluat
ing polynomials is known as Horner's Rule.
*/

int main(void){
    float x;
    printf("Enter value for x: ");
    scanf("%f", &x);

    printf("Polynomial result is: %.2f", (((((3.0f * x + 2) * x - 5) * x - 1) * x + 7) * x - 6));
    return 0;
}
