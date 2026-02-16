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
Modify the upc.c program of Section 4.1 so that it checks whether a UPC is valid. After
the user enters a UPC. the program will display cither VALID or NOT VALID.
*/

#include <stdio.h>

#include <stdio.h>

int main(void) {
    int d, i1, i2, i3, i4, i5, j1, j2, j3, j4, j5, check_digit;
    int first_sum, second_sum, total, computed_check;

    printf("Enter the first (single) digit: ");
    scanf("%d", &d);
    printf("Enter first group of five digits: ");
    scanf("%d%d%d%d%d", &i1, &i2, &i3, &i4, &i5);
    printf("Enter second group of five digits: ");
    scanf("%d%d%d%d%d", &j1, &j2, &j3, &j4, &j5);
    printf("Enter the last (single) digit: ");
    scanf("%d", &check_digit);

    // Check if all inputs are valid single digits
    if ((d > 9 || d < 0) ||
        ((i1 > 9 || i1 < 0) || (i2 > 9 || i2 < 0) || (i3 > 9 || i3 < 0) ||
         (i4 > 9 || i4 < 0) || (i5 > 9 || i5 < 0)) ||
        ((j1 > 9 || j1 < 0) || (j2 > 9 || j2 < 0) || (j3 > 9 || j3 < 0) ||
         (j4 > 9 || j4 < 0) || (j5 > 9 || j5 < 0)) ||
        (check_digit > 9 || check_digit < 0)) {
        printf("NOT VALID\n");
    } else {
        // Compute the check digit
        first_sum = d + i2 + i4 + j1 + j3 + j5;
        second_sum = i1 + i3 + i5 + j2 + j4;
        total = 3 * first_sum + second_sum;
        computed_check = 9 - ((total - 1) % 10);

        // Verify if the entered check digit matches
        if (computed_check == check_digit) {
            printf("VALID\n");
        } else {
            printf("NOT VALID\n");
        }
    }

    return 0;
}
