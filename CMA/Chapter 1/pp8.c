#include <stdio.h>
/*
PP7
Write a program that calculates the remaining balance on a loan after the first, second, and
third monthly payments:
Enter amount of loan: 20000.00
Enter interest rate: 6.0
Enter monthly payment: 386.66
Balance remaining after first payment: $19713.34
Balance remaining after second payment: $19425.25
Balance remaining after third payment: $19135.71
Display each balance with two digits after the decimal point. Hint: Each month, the balance
is decreased by the amount of the payment, but increased by the balance times the monthly
interest rate. To find the monthly interest rate, convert the interest rate entered by the user to
a percentage and divide it by 12.

*/

int main(void){
    float loan_amt, yearly_interest_rate, monthly_interest_rate, monthly_payment;

    printf("Enter amount of loan: ");
    scanf("%f", &loan_amt);

    printf("Enter interest rate: ");
    scanf("%f", &yearly_interest_rate);

    printf("Enter monthly payment: ");
    scanf("%f", &monthly_payment);

    /* Each month balance is dec by the amount of the payment*/
    monthly_interest_rate = ((yearly_interest_rate * 0.01) / 12);
    loan_amt = ((loan_amt + (monthly_interest_rate * loan_amt)) - monthly_payment);
    printf("Balance remaining after first paynemt: %.2f\n", loan_amt);
    loan_amt = ((loan_amt + (monthly_interest_rate * loan_amt)) - monthly_payment);
    printf("Balance remaining after first paynemt: %.2f\n", loan_amt);
    loan_amt = ((loan_amt + (monthly_interest_rate * loan_amt)) - monthly_payment);
    printf("Balance remaining after first paynemt: %.2f\n", loan_amt);
    return 0;
}
