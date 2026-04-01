/*
CHAPTER 10

/ in c you can just create a "naked" standalone block

Exercise 1
Thefollowing program outline shows only function definitions and variable declarations,

int a;

void f(int b){
    int c;
}

void g(void){
    int d;
    {
        int e;
    }
}

int main(void){
    int f;
}

For each of the following scopes, list all variable and parameter names visible in that scope:
(a) The f function
(b) The g function
(c) The block in which e is declared
(d) The mainfunction

answer:
a. inside f
we have b as the parameter
we have the variable c declared
and of course we can access the gloval var a. so a,b,c

b. inside g
we dont have any param/void
inside it we declared d
and below it we created a new cope and declared e
d can't access e, but e can access d
also global var a is visible - so the only visible inside is d and a

c. block in which e is declared
inside this block we can access e,d, and a

d. main function
the only viisble is the int f and int a (global var)





*/

#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <ctype.h>

//prototypes
void g(void){
    int d;
    {
        int e;
        printf("10");
    }
}


int main(void) {

    g();
    return 0;
}
