 /*
CHAPTER 13: Strings

STRING LITERAL
"this is a string"
like racket but iwth \0 to seperate
we can't modifiy it - read only!

DONT change a string literal
char *p = "abc"
*p = 'd'

SINGLE CHAR STRING LITERAL
"a" vs 'a'

INITIALIZATION
just use a[unspeficied] = "STRING" for safety

CHAR VS ARR POINTER
*date = "June 13" -> cannot be modiifed - string literal!
date[] = "June 13" -> can be modified - make a copy

ILEGAL
str1 = "abc"
str2 = str1

'\0' is the same as 0 int
'\0' is FALSE
*p = *s2
if *p = '\0' this is treated as false

putchar -> can take string pointer or char
puts -> can take string literal or string piointer

pointer to string always give exactly one character
*p = "abc"
*p -> a'

STRCPY
replaces the destination with source
depends on the source lenght
if source < destination source wins.
can accept char memory address eg &str[4]
In C, strcpy (string copy) doesn't want the actual character data passed directly to it.
Instead, it needs to know where the data is.

STRCAT
finds the first null char ('\0') and replaces it with arg

INC C, a string and a pointer/address ARE THE SAME THING
char s1[] = "computer"
strcpy(q, s1)

String name = address of first char
strcpy, strlen, strcat all expect addresses, not characters



============================================
Programming Project 15
Modify Programming Project 6 from Chapter 10 so that it includes the following function:

int evaluate_RPN_expression(const char *expression);
The function returns the value of the RPN expression pointed to by expression.

from pp6
PP 6
Somecalculators (notably those from Hewlett-Packard) use a system of writing mathemati
cal expressions known as Reverse Polish Notation (RPN). In this notation, operators are
placed after their operands instead of between their operands. For example. I + 2 would be
written 1 2 + in RPN. and 1 + 2* 3 would be written I 23* +. RPN expressions can easily
be evaluated using a slack. The algorithm involves reading the operators and operands in an
expression from left to right, performing the following actions:
When an operand isencountered,
push it onto the stack.
When an operator is encountered,
pop its operands from the stack, perform the opera
tion on those operands, and then push the result onto the stack.
Write a program that evaluates RPN expressions.The operands will be single-digit integers.
The operators are +.-, *. /. and =. The = operator causes the top stack item to be displayed;
afterwards, the stack is cleared and the user is prompted to enter another expression. The
process continues until the user enters a character that is not an operator or operand:
Enter an RPN expression: 1 2 3 *
Value of expression: 7
Enter an RPN expression: 5 8 * 4 9
+
Value of expression:-8
Enter an RPN expression: g
' =
If the stack overflows, the program will display the message Expression is too com
plex and terminate. If the stack underflows (because of an expression such as 1 2 + +), the
program will display the message Not enough operands in expression and termi
nate. Hints: Incorporate the stack code from Section 10.2 into your program. Use
scanf(" %c",&ch)to read theoperators and operands.

asnwer:
*/

#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <ctype.h>
#include <string.h>
#define STACK_SIZE 100
#define N 100

int stack[STACK_SIZE];
int top = 0;

int evaluate_RPN_expression(const char *expression){
    int operand1, operand2;
    int result;

    while(*expression != '\0'){
    if (isdigit(*expression)) {
            push(*expression - '0');
        } else if (*expression == '+' || *expression == '-' || *expression == '*' || *expression == '/') {
            operand2 = pop();
            operand1 = pop();
            if      (*expression == '+') push(operand1 + operand2);
            else if (*expression == '-') push(operand1 - operand2);
            else if (*expression == '*') push(operand1 * operand2);
            else  push(operand1 / operand2);
        } else if (*expression == '=') {
            result = pop();
            top = 0;
        } else {
            break;
        }

        expression++;
    }

    return result;
}

void push(int value) {
    if (top == STACK_SIZE) {
        printf("Expression is too complex\n");
        exit(EXIT_FAILURE);
    }
    stack[top++] = value;
}

int pop(void) {
    if (top == 0) {
        printf("Not enough operands in expression\n");
        exit(EXIT_FAILURE);
    }
    return stack[--top];
}

int main(void) {
    char expr[N];
    int operand1, operand2;

    printf("Enter an RPN expression: ");

    fgets(expr, N, stdin);
    printf("Value: %d\n", evaluate_RPN_expression(expr));

    return 0;
}


