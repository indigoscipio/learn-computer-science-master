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

Exercise 5
Suppose that a program consists of three source files - main.c, f1.c, and f2.c, plus
two header files,f1.h and f2.h.All three source files include f1.h. but only f1.c and
f2.c include f2.h. Write a makefile for this program, assuming that the compiler is gcc
and that the executable file is to be named demo.

answer:
yeah i have no idea how to do that im using codeblocks here lol i have no idea what makefileis

a) compile main.c, f1.c, f2.c → link all three → build demo
   (everything, since nothing exists)

b) recompile f1.c → relink → new demo

c) recompile main.c, f1.c → relink → new demo

d) recompile f1.c, f2.c → relink → new demo
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



