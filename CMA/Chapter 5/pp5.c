#include <stdio.h>

/*
PRECEDENCE LEVEL
1. Postfix/Unary: ++, --, !, +, -
2. Mult: *, /, %
3. Add: +, -
4. Relational: >, <, <=, >= (left associative)
5. Equality: ==, !=
6. Logical AND: &&
7. Logical OR: ||
8. Assignment: =, *=, +=, ==, !=, etc

PP5
In one state,
single residents are subject to the following income tax:
Income
Not over $750
$750-$2,250
$2,250-53.750
$3,
750-55.250
$5.250-57.(MK)
Over $7,000
Amount of tax
I % of income
$7.50
$37.50 plus3%of amount over$2,250
plus 2% of amount over $750
$82.50 plus 4% of amount over $3,750
$142.50 plus 5% of amount over$5,250
$230.00 plus67c of amount over $7,000
Write a program that asks the user to enter the amount of taxable income, then displays the
tax due.
*/

int main(void){
    float income;

    printf("Enter your $ income amount: ");
    scanf("%f", &income);

    if(income<750.00){
        printf("Tax due: $%.2f", (.01 * income));
    }else if(income <=2250.00){
        printf("Tax due: $%.2f", (.02 * (income - 750.00)) + 7.50);
    }else if(income <=3750.00){
        printf("Tax due: $%.2f", (.03 * (income - 2250.00)) + 37.50);
    }else if(income <=5250.00){
        printf("Tax due: $%.2f", (.04 * (income - 3750.00)) + 82.50);
    }else if(income <=7000.00){
        printf("Tax due: $%.2f", (.05 * (income - 5250.00)) + 142.50);
    }else{
        printf("Tax due: $%.2f", (.06 * (income - 7000.00)) + 230.00);
    }

    return 0;
}
