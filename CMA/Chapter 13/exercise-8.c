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


STRCAT
finds the first null char ('\0') and replaces it with arg




============================================

Exercise 8
What will be the value ofthe stringstr after the following statements have been executed?

strcpy(str, "tire-bouchon");
strepy(&str[4], "d-or-wi");
streat(str, "red?");

answer:
ok so lets say we have str = "" at first

strcpy(str, "tire-bouchon");
this one  copies the source to destination which is str


*/

#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <ctype.h>
#include <string.h>

#define N 99

int main(void){
    char wd[1] = "g";

    strcpy(wd, "tire-bouchon");
    printf("%s", wd);

    return 0;
}
