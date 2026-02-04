#include <stdio.h>
/*
PP7
Write a program that asks the user to enter a U.S. dollar amount and then shows how to pay
that amount using the smallest number of $20.$10. $5. and $1 bills:
Enter a dollar amount: 9
$20 bills: 4
$10 bills: 1
$5 bills: 0
$1 bills: 3
Programming Projects
Hint: Divide the amount by 20 to determine the number of $20 bills needed,
and then reduce
the amount by the total value of the $20 bills. Repeat for the other bill sizes. Be sure to use
integer values throughout, not floating-point numbers.
*/

int main(void){
    int amt, remaining_after_tens, remaining_after_fives, twenties, tens, fives, ones;

    printf("Enter your dollar amount: ");
    scanf("%d", &amt);

    twenties = (amt /20);
    tens = ((amt % 20) / 10);
    remaining_after_tens = ((amt % 20) % 10);
    fives = (remaining_after_tens / 5);
    remaining_after_fives = (((amt % 20) % 10) % 5);
    ones = remaining_after_fives;
    printf("$20 bills: %d\n", twenties);
    printf("$10 bills: %d\n", tens);
    printf("$5 bills: %d\n", fives);
    printf("$1 bills: %d\n", ones);
    return 0;
}
