#include <stdio.h>
/*
CONVERSION SPECIFICATION
use % - liek a temporary placheolder

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
