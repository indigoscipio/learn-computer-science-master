/*
Chapter 15

GROUP PROGRAM INTO MULTIPLE FILES
- compiled seperately
- reusable function

HEADER FILES
#include directive - just 'bring' other files into your current working file.
#include <library>
#include "filename/path"

SHARING MACRO DEFINITIONS
bool file -> boolean definitions
file 1 -> import boolean
file 2 -> import boolean

PROTOTYPE SHARING
if calling another function from different file
make sure to include directive from that file.

VARIABLE SHARING
int i does 2 things:
declare var -> i as a type of integer
define var -> allocate memory

extern seperate those

*/


/*

Exercise 2
Whichof the following should not be put in a header file? Why not?

a. function prototypes
b. function definitions.
c. macro definitions.
d. type definitions.

answer:
let me try to analyze this one by one.
a. im guessing you could put a function prototype ina .h file
you can just import that function into another file or main.c without defining the prototype
so yes i think this one is allowd

b. function definiitions
no you shoudl not define functio ndefinitions.
risk of linker error. if all 3 file do #include theres a risk of duplication .
linker would see 3 copies of funcion and confused "which one do i use/"

c. macro definitions
im not sure about this one. if you have one macro defined and in other file
you define the same macro theres a risk of duplicate macro, but you can just use the
#ifdef trick i think so its allowed? not sure

d. type definitions
im also not sure about this one. technicaly its alowed but need to be like consistent and centralized


*/

#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <ctype.h>
#include <string.h>

int main(void){
    return 0;
}



