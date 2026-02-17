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

PP11
Write a program that asks the user for a two-digit number,
then prints the English word for
the number:
Enter a two-digit number: 4J3
You entered the number forty-five.
Him: Break the number into twodigits. Use one switch statement to print the word for the
first digit (“twenty
.” "thirty,'' and so forth). Use a second switch statement to print the
word for the second digit. Don't forget that the numbers between 11 and 19 require special
treatment.
*/

#include <stdio.h>

int main(void) {
    int num_input, tens, base;

    printf("Enter a two digit number: \n");
    scanf("%d", &num_input);

    tens = num_input / 10;
    base = num_input % 10;

    if(num_input > 10 && num_input < 20){
        switch(base){
        case 9:
            printf("Nineteen");
            break;
        case 8:
            printf("Eighteen");
            break;
        case 7:
            printf("Seventeen");
            break;
        case 6:
            printf("Sixteen");
            break;
        case 5:
            break;
        case 4:
            break;
        case 3:
            break;
        case 2:
            break;
        case 1:
            printf("Eleven");
            break;
        default:
            printf("Ten");
            break;
    }
    }else{
            switch(tens){
        case 9:
            printf("Ninety ");
            break;
        case 8:
            printf("Eighty ");
            break;
        case 7:
            break;
        case 6:
            break;
        case 5:
            break;
        case 4:
            break;
        case 3:
            break;
        case 2:
            break;
    }

    switch(base){
        case 9:
            printf("nine");
            break;
        case 8:
            printf("eight");
            break;
        case 7:
            printf("seven");
            break;
        case 6:
            printf("six");
            break;
        case 5:
            printf("five");
            break;
        case 4:
            printf("two");
            break;
        case 3:
            printf("three");
            break;
        case 2:
            printf("two");
            break;
        case 1:
            printf("one");
            break;
    }
    }



    return 0;
}
