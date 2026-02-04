#include <stdio.h>
/*
PP 3
Write a program that asks the user to enter a dollars-and-cents amount, then displays the
amount with 5% tax added:
Enter an amount: 100.00
With tax added: $105.00
*/

int main(void){
    float amount;
    float tax = 0.05;


    printf("Enter your dollar amount: ");
    scanf("%f", &amount);

    printf("With tax added: %.2f", ((amount * tax) + amount) );
    return 0;
}
