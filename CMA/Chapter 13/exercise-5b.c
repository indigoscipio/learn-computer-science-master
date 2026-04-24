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

============================================

Exercise 5
a) Write a function named capitalize that capitalizes all letters in its argument. The
argument will be a null-terminated string containing arbitrary characters, not just letters.
Use array subscripting to access the characters in the string. Hint: Use the toupper func
tion to convert each character to upper-case.

b) Rewrite the capitalize function, this time using pointer arithmetic to access the
characters in the string.

answer:
*/

#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <ctype.h>

#define N 99

void capitalize(char *a){

    while(*a != '\0'){
        *a=toupper(*a);
        a++;
    }

}

int main(void){
    char wd[N] = "Hey there, folks!";

    capitalize(wd);
    printf("%s", wd);

    return 0;
}
