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
Exercise 1
Section 15.1 listed several advantages of dividing a program into multiple source files.
a. describe several other advantage
b. describe some disadvantages

answer:
a. ok let me think the advantages here
- code more organized and easier to manage and even read. instead of having everything
in one main.h you seperate and divide into chunks.
- code more modular, like a lego puzzle piece. you need certain function or variable or libray,
just include it on the header.
- easy to scale - if you want to add new code feature just  add new library.
- seperate responsibility principle. if you want function that want to modify string or has something
to do with string just include like string.h or something.
- function reusability, if you have a function family lets say trigonometry function
you can just include in header like trig.h and use all trigonometry related function.
- seperate error - if one of the trig function is error then you know its coming from the trig.h header
just change it there no need to find other areas
- parallel development
- scoped/information hiding. some information can be hided through abstraction

b. now let me think about the disadvantages
- i guess it would be a small hassle if you are working in multiple .c file
and you have to type #include or include header everyime you need certain library.
- dependency confusion? if you have a file.c that has a .h that depends on other .h it would be hard
to find the source or error i think. espeicaly if the .h program like 'loops' include
- hmm i donthink i can find other disadvantage here. maybe when the .h becomes toomany and you
want to search for a certain function is locatied that would also be a hassle.
- more files to manage
- linker erors, inconsistency risk.

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



