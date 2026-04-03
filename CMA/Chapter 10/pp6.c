/*
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

*/

#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <ctype.h>

#define STACK_SIZE 100

int contents[STACK_SIZE];
int top = 0;

void make_empty(void){
    top = 0;
}

bool is_empty(void){
    return top == 0;
}

bool is_full(void){
    return top == STACK_SIZE;
}

void push(char i){
    if(is_full()){
        printf("Stack Overflow");
        exit(EXIT_FAILURE);
    }else{
        contents[top++]=i;
    }
}

char pop(void){
    if(is_empty()){
        printf("Stack Underflow");
        exit(EXIT_FAILURE);
    }else{
        return contents[--top];
    }
}

//given two operands and an operator, evaluates an expression into a number
int evaluate(int left, int right, char operator){
    switch(operator){
                case '+': return left + right; break;
                case '*': return left * right; break;
                case '-': return left - right; break;
                case '/': return left / right; break;
                default: printf("Unknown Operator"); break;
            }
}

//main: calls read_cards, analyze_hand and print_Result repeatedly
int main(void) {
    char ch;
    int left, right;

    printf("Enter an RPN expression: ");

    do {
        scanf(" %c", &ch);

        if (isdigit(ch)) {
            push(ch - '0');
        } else if (ch == '=') {
            printf("Value of expression: %d\n", pop());
            make_empty();
            printf("Enter an RPN expression: ");
        } else if (ch == '+' || ch == '-' || ch == '*' || ch == '/') {
            if (top < 2) {
                printf("Not enough operands in expression\n");
                exit(EXIT_FAILURE);
            }
            right = pop();
            left  = pop();
            push(evaluate(left, right, ch));
        }
        // if ch is none of the above (like 'g'), the loop just ends

    } while (isdigit(ch) || ch == '+' || ch == '-' || ch == '*' || ch == '/' || ch == '=');

    return 0;
}
