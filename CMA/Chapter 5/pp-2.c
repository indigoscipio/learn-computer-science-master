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

PP2
Write a program that asks the user for a 24-hour time,
then displays the time in 12-hour form:

Enter a 24-hour time: 21:11
Equivalent 12-hour time: 9:11 PM

Be careful not to display 12:00 as 0:00.
*/

int main(void){
    int h24,m24, h12;

    printf("Enter a 24 hour time: \n");
    scanf("%2d:%2d", &h24,&m24);

    /*
    to find h12, get the reminder when its divided by 12
    to find meridian, if h24 > 12, then it's PM
    00:00 -> 12 AM
    12:00 -> 12 PM
    24:00 -> 12 AM
    */
    h12 = (h24 % 12) == 0 ? 12 : (h24 % 12);
    printf("Equivalent 12 hour time: %d:%02d %s", h12,m24,(h24 >= 12 ? "PM" : "AM") );

    return 0;
}
