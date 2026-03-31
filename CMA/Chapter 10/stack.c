/*
CHAPTER 10

Local Variables
a var declared inside the body of function is "local" to that function.

when a func is called it does
- automatic storage duration: lifespan rule applied to var declared in func
- block scope: visibility and lifetime of a var declared within curly braces

why block scope exits? for safety reasons, eg using same name for 2 different things
prevent "shaowing"

any var you declare inside func is automatic by defualt
unless specify keyword liek static

*/

#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <ctype.h>

//prototypes
#define STACK SIZE 100

int contnets[STACK_SIZE];
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

void push(int i){
    if(is_full()){
        stack_overflow();
    }else{
        contents[top++]=i;
    }
}

int main(void) {




    return 0;
}
