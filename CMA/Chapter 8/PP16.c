/*
Write a program that tests whether two words are anagrams (permutations of the same let
ters):
Enter first word: smartest
Enter second word: mattress
The words are anagrams.
Enter first word: dumbest
Enter second word: stumble
The words are not anagrams.

Write a loop that reads the first word, character by character, using an array of 26 integers to
keep track of how many times each letter has been seen. (For example, after the word smart
est has been read, the array should contain the values 1 0 0 0 1 0 000 00 0 I 000 0 I 2 20
0 0 000. reflecting the fact that smartest contains one a.one e, one m, one /•, two < > ’s and
two rs.) Use another loop to read the second word, except this timedecrementing the corre
sponding array element as each letter is read. Both loops should ignore any characters that
aren’t letters, and both should treat upper-case letters in the same way as lower-case letters.
After the second word has been read, use a third loop to check whether all the elements in
the array are zero. If so. the words are anagrams. Hint: You may wish to use functions from
<ctype.h>, such as isalpha and tolower.

*/

#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#define STACK_SIZE 100

int stack[STACK_SIZE];
int top = 0;

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
    char ch;
    int operand1, operand2;

    printf("Enter an RPN expression: ");
    while (scanf(" %c", &ch) == 1) {
        if (isdigit(ch)) {
            push(ch - '0');
        } else if (ch == '+' || ch == '-' || ch == '*' || ch == '/') {
            operand2 = pop();
            operand1 = pop();
            if      (ch == '+') push(operand1 + operand2);
            else if (ch == '-') push(operand1 - operand2);
            else if (ch == '*') push(operand1 * operand2);
            else                push(operand1 / operand2);
        } else if (ch == '=') {
            printf("Value of expression: %d\n", pop());
            top = 0;
            printf("Enter an RPN expression: ");
        } else {
            break;
        }
    }
    return 0;
}
