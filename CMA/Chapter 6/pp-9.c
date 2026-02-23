#include <stdio.h>

/*
LOOPS

while : checks cond before the body rund
do-while : checks cond after body runs
for : like while, but designed with how many times you wanna run it

for(xx) < here xx is called "controlling expression"

=============================================================
PP8

Programming Project 8 in Chapter 2 asked you to write a program that calculates the
remaining balance on a loan after the first, second, and third monthly payments.

Modify the program so that it also asks the user to enter the number of payments
and then displays the balance remaining after each of these payments.

*/

#include <stdio.h>

int main(void) {
    float loan_amount, yearly_interest_rate, monthly_interest_rate, monthly_payment;
    int number_of_payments;

    printf("Enter amount of loan: \n");
    scanf("%f", &loan_amount);

    printf("Enter Yearly Interest rate: \n");
    scanf("%f", &yearly_interest_rate);

    printf("Enter monthly payment: \n");
    scanf("%f", &monthly_payment);

    printf("Enter number of payments: \n");
    scanf("%d", &number_of_payments);

    int i;
    monthly_interest_rate = ((yearly_interest_rate * 0.01) / 12);
    for(i=1; i<=number_of_payments; i++){
        printf("Payment %d: ", i);
        loan_amount = ((loan_amount + (monthly_interest_rate * loan_amount)) - monthly_payment);
        printf("Balance remaining after payment: %.2f \n", loan_amount);
    }
    return 0;
}
