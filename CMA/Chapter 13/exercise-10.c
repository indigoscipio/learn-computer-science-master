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

Exercise 10
Thefollowing function supposedly creates an identical copy of a string. What’s wrong with
the function?

char *duplicate(const char *p){
    char *q;

    strcpy(q,p);
    return q;
}

answer:
ok so duplicate is a poitner type which takes a character pointer constant
and inside we declared q which is another pointer

then we perform strcpy(q,p) -> which copies the content of p into q
but we have declar char *q which is a char pointer first so its pointing at a random junk address
when we copy the content of p into q it goes to that random address

*/

#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <ctype.h>
#include <string.h>

#define N 99

char *duplicate(const char *p){
    char *q;
    strcpy(q,p);
    return q;
}

int main(void){
    char s1[] = "hello", s2[]= "world";

    printf("%s", *duplicate(s1));

    return 0;
    }
