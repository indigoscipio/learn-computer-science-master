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

Exercise 3
Wesaw that writing? include <file> instead of #include " file" may not work if file is
onethat we 've written. Would there be any problem with writing of if include <file> if file is a system header?


answer:
ok so my understanding is that
#include <stdio.h> -> looks in system folder
#include "myfile.h" -> looks in folder, then system

so yes it will work using "stdio.h".
but the cons
- it waste time -> searches local file, then system library
- its misleading, <> should be used for system library


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



