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

Exercise 4
Assume that debug.hisa header filew ith thefollowing contents:

#ifdef DEBUG
#define PRINT_DEBUG(n) printf("Vale of " #n ": %d\n", n)
#else
#define PRINT_DEBUG(n)
#endif

let testdebug.c be the following source file:

#include <stdio.h>

#define DEBUG
#include "debug.h"

int main(void){
    int i=1,j=2,k=3;

    #ifdef DEBUG
        printf("Output if DEBUG is defined: \n");
    #else
        printf("Output if DEBUG is not defined: \n");
    #endif

    PRINT_DEBUG(i);
    PRINT_DEBUG(j);
    PRINT_DEBUG(k);
    PRINT_DEBUG(i + j);
    PRINT_DEBUG(2 * i + j - k);

    return 0;
}

a. what is the output when the programis executed?
b. what is the output if the #define directive is removed from the testbug.c?
c. explain why the output is in different parts in a and b
d. is it necessary for the DEBUG macro to be defined before debug.h is included in order
for PRINT_DEBUG to have the desired effect? justify your answer.

answer:
ok let me try to answer this i could be wrong here
a. lets say we executy testdebug.c
it defines DEBUG with nothing/no value, then opens the header debug.h
then inside debug.h since DEBUG is already defined even though has no value
it goes to the 1st case, so PRINT_DEBUG(n) ->  printf("Vale of " #n ": %d\n", n) is avaialbe

then into the main function,
we deifned a few ints then another macro
since we alredy have the macro DEBUG defined it goes to 1st case ->  printf("Output if DEBUG is defined: \n");

then finally the PRINT_DEBUG

PRINT_DEBUG(i) -> printf("Vale of " i ": 1\n", n); value of i is 1 - with # stringize operator so "i"
"the value of " #n "is xxx"
PRINT_DEBUG(j) -> same, value of  j is 2
PRINT_DEBUG(k) -> prints fvalue of k is 3
PRINT_DEBUG(i + j) -> prints value of i + j is 3
PRINT_DEBUG(2 * i + j - k) -> prints 2 * 1 + 2 - 3 -> 2 + 2 - 3 -> -3

b. ok lets assume #define directive is removed from testdebug.c
then when importing debug.h, since DEBUG is not defined yet it goes to the else case
different from the 1st part it goes to the PRINT_DEBUG(n), does not print anything at all - nothing

then on the main function afterward
since we dont have debug defined it goves to the else case
so printf("output if DEBUG is not defined:\n") and prints it.

the rest PRINT_DEBUG
PRINT_DEBUG(i) -> does not print anything at all, nothing

c. im guessing
the output is different because
in part a we already defined debug before we include the debug.h header
so order of operation plays a role here.
and in part b since our definition of DEBUG is removed, when we import
the debug header goes to the else case.

d. ok we alreayd know effect it will ahve if we remove the DEBUG deifntiion
yes the order matters. preprocessor reads from top to bottom and ONE PASS only.


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



