/*
Exercise 2
 Thefollowing program outline showsonly function definitions and variable declarations,

 int b,c;

 void f(void){
    int b,d;
 }

 void g(int a){
    int c;
    {
        int a,d;
    }
 }

 int main(void){
    int c,d;
 }

 For each of the following scopes, list ail variable and parameter names visible in that scope.
If there’s more than one variable or parameter with the same name, indicate which one is
visible.

(a) The f function
(b) The g function
(c) The block in which a and d are declared
(d) The main function

answer:
a. inside f
we haev no param
we can access b (defined locally) and d (also local)
the b is only refering to the local var since block inside this function f (not the external var one)
also global var c
so b,c,d

b. inside g
we have a as the param
and then c (defined locally) - the c is local inside the function g, not the external c
also global var b
so a,b,c

c.
inside the block where a and d are declared
we can access the variable c (which is declared locally inside g, not the global var one)
then the two a,d itself declared inside that "naked" block {}.
however the "a" here refres to the local a inside the naked block instead of the param a since it gets "shadowed"
so a (local inside naked {}),c (local, declared inside function g), d (declared locally inside the naked {})

d. the main function
we have c - the c whose visible here refers to the local var instead of the global var
and d which is declared locally
and lastly the global var b
no params
so b (global var), c (not the external one) and d (local inside main)
also we can acces the function f and g inside main too


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
