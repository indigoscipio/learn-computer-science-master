/*
CHAPTER 10

Local Variables
a var declared inside the body of function is "local" to that function.

when a func is called it does
- automatic storage duration: lifespan rule applied to var declared in func
- block scope: visibility and lifetime of a var declared within curly braces

why block scope exits? for safety reasons, eg using same name for 2 different things
prevent "shaowing"

*/

#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <ctype.h>

//prototypes

int main(void) {
    return 0;
}
