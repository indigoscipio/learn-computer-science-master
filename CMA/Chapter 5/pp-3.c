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

PP3
Modify the broker.c program of Section 5.2 by making both of the following changes:

(a) Ask the user to enter the number of shares and the price per share,
instead of the value of the trade.

(b) Add statements that compute the commission charged by a rival broker ($33 plus 3c per
share for fewer than 2000 shares; $33 plus 2c per share for 2000 shares or more).

Display the rival's commission as well as the commission charged by the original broker.

*/

int main(void){
    float num_of_shares, price_per_share, commission, rival_comission, value;

    printf("Enter number of shares: ");
    scanf("%f", &num_of_shares);

    printf("Enter price per share: ");
    scanf("%f", &price_per_share);

    value = price_per_share * num_of_shares;

    /*Rival Broker*/
    if (num_of_shares < 2000 ){
        rival_comission = 33.00f + (0.03f * num_of_shares);
    }else {rival_comission = 33.00f + (0.02f * num_of_shares);}

    /*Original Broker*/
    if (value < 2500.00f)
    commission = 30.00f + .017f * value;
    else if (value < 6250.00f)
    commission = 56.00f + .0066f * value;
    else if (value < 20000.00f)
    commission = 76.00f + .0034f * value;
    else if (value < 50000.00f)
    commission = 100.00f + .0022f * value;
    else if (value < 500000.00f)
    commission = 155.00f + .0011f * value;
    else
    commission = 255.00f + .0009f * value;

    if(commission < 39.00f)
    commission = 39.00f;

    printf("Rival comission: $%.2f\n", rival_comission);
    printf("Original Commission: $%.2f\n", commission);
    return 0;
}
