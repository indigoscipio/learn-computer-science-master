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

PP10
Using the switch statement,write a program that converts a numerical grade into a letter
grade:
Enter numerical grade: 84
Letter grade: B
Use the following grading scale: A = 90-100,B= 80-89,C= 70-79, D= 60-69, F= 0-59.
Print an error message if the grade is larger than 100 or less than 0. Hint: Break the grade
into two digits, then use a switch statement to test the ten's digit.
*/

#include <stdio.h>

int main(void) {
    int num_grade, tens, base;

    printf("Enter a numerical Grade: \n");
    scanf("%d", &num_grade);

    // break the digits
    if(num_grade > 100 || num_grade < 0){
        printf("Grade needs to be between 0 - 100");
    }else{
        base = num_grade % 10;
        tens = num_grade / 10;

        switch(tens){
            case 10:
            case 9: printf("A");
                    break;
            case 8: printf("B");
                break;
            case 7: printf("C");
                break;
            case 6: printf("D");
                break;
            default: printf("F");
                break;
        }

    }

    return 0;
}
