
#include <stdio.h>
#include <stdbool.h>

/*
Exercise 8
Which of the following would be valid prototypes fora function that returns nothing and has
one double parameter?
(a) void f (double x);
(b) void f (double);
(c) void f (x);
(d) f(double x);

answer:
returns nothing
one double parameter

a. void f(double x);
this is valid

b. void(double);
stil valid for a prototype if we emit the parameter
and just do the type

c. void f(x);
im guessing this is not valid since it doesn't have the arg type defined
unlike b its not allowed to emit the arg type
compiler doesn't have any idea how muc hmemory to allocate or
what type of data it holds

d. f(double x)
im also gonna guess here this is not valid
sicnce it doesn't have a explicit void function return type before f(double x)

*/
int main(void){
    double x;

    x = f(83.55,12.88);
    printf("%d", x);

    return 0;
}

/*
racket version
(cond []
      [])
*/

