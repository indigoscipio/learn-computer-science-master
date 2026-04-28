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

Exercise 11
The Q&A section at the end of this chapter shows how the stremp function might he writ
12.
ten using array subscripting. Modify the function to use pointer arithmetic instead.

int strcmp(char *s, char *t){
    int i;

    for (i = 0; s[i] == t[i]; i++)
        if (s[i] == ’\0')
            return 0;
    return s[i]- t[i];
}

*/

#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <ctype.h>
//#include <string.h>

#define N 99

int strcmp(char *s, char *t){

    //start with 1st letter of s, compare with t
    for (; *s == *t; s++,t++)
        if (*s == '\0')
            return 0;

    return *s-*t;
}


int main(void){
    printf("%d", strcmp("a", "b"));

    return 0;
    }
