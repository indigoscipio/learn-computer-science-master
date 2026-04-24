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

Exercise 7
Suppose that str is an array of characters. Which one of the following statements is not
equivalent to the other three?

answer:
(a) *str = 0;
(b) str[0] = '\0';
(c) strcpy(str, "");
(d) strcat(str, "");

answer:
ok so we have str a[] = "some characters"
a. whre telling/modifying the first character of str to become 0 so empty char
b. since 0 and '\0' has the same char value and str[0] basicaly the same as *str then its the same as a
c. so here we copy an empty string which is just '\0', and copies into 1st position. the result is empty char
d. here we use concat to append our str with empty string. it finds the \0 and adds the second string so its basicaly just the original

*/

#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <ctype.h>
#include <string.h>

#define N 99

int main(void){
    char wd[N] = "gerry";

    *wd = 2;
    printf("%s", wd);

    return 0;
}
