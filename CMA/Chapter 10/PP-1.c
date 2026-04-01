/*
Exercise 3
MoJify the stack example of Section 10.2 so that it stores characters instead of integers.
Next, add a main function that asks the user to enter a series of parentheses and/or braces,
then indicates whether or not they're properly nested:

Enter parentheses and/or braces: ((){}{()})
Parentheses/braces are nested properly

Hint: As the program reads characters, have it push each left parenthesis or left brace. When
it reads a right parenthesis or brace, have it pop the stack and check that the item popped is a
matching parenthesis or brace. (If not. the parentheses/braces aren’t nested properly.) When
the program reads the new-line character, have it check whether the stack is empty:if so. the
parentheses/braces are matched. If the stack isn7empty (or if stack_underf low is ever
called), the parenthcses/braces aren’ t matched. If stack overf low is called, have the
program print the messageStack overflow and terminate immediately

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
    }else{
        contents[top++]=i;
    }
}

char pop(void){
    if(is_empty()){
        printf("Stack Underflow");
    }else{
        return contents[--top];
    }
}

int main(void) {
    char ch;
    printf("Enter parentheses/or braces: ");

    while((ch = getchar()) != '\n'){

        if(ch == '{'  || ch == '('){
            push(ch);
        }else if(ch == '}' || ch == ')'){
            char opened = pop();

            //mismatch

            //underflow

        }

        //check recent char
            // if it encounters right brace, pop the matching pair
            // if it doesn't match with elft, then it's not nested
        //when it ends/scans newline check if the stack is empty
            // if so, braces are matched
            // else they aren't matched

    }

    return 0;
}
