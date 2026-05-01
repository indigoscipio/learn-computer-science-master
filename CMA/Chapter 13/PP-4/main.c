 /*
CHAPTER 13: Strings

STRING LITERAL
"this is a string"
like racket but iwth \0 to seperate
we can't modifiy it - read only!

DONT change a string literal
char *p = "abc"
*p = 'd'

SINGLE CHAR STRING LITERAL
"a" vs 'a'

INITIALIZATION
just use a[unspeficied] = "STRING" for safety

CHAR VS ARR POINTER
*date = "June 13" -> cannot be modiifed - string literal!
date[] = "June 13" -> can be modified - make a copy

ILEGAL
str1 = "abc"
str2 = str1


'\0' is the same as 0 int
'\0' is FALSE
*p = *s2
if *p = '\0' this is treated as false

putchar -> can take string pointer or char
puts -> can take string literal or string piointer

pointer to string always give exactly one character
*p = "abc"
*p -> a'

STRCPY
replaces the destination with source
depends on the source lenght
if source < destination source wins.
can accept char memory address eg &str[4]
In C, strcpy (string copy) doesn't want the actual character data passed directly to it.
Instead, it needs to know where the data is.

STRCAT
finds the first null char ('\0') and replaces it with arg

INC C, a string and a pointer/address ARE THE SAME THING
char s1[] = "computer"
strcpy(q, s1)

String name = address of first char
strcpy, strlen, strcat all expect addresses, not characters



============================================

Programming Project 4
Write a program named reverse.c that echoes its command-line arguments in reverse
order. Running the program by typing

reverse void and null

should produce the following output:
null and void

*/

#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <ctype.h>
#include <string.h>

#define NUM_SUITS 4
#define NUM_RANKS 13


int main(int argc, char *argv[]){
    char **p; //first letter of each arg

    for(p=&argv[argc-1];p>=&argv[1];p--){
        printf("%s ",*p);
    }


    return 0;
}
