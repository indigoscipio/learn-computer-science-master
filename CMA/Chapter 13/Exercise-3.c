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

Exercise3
Suppose that we call scanf as follows:
scanf("%d%s%d" , &i, s, &j ) ;

if the user enters 12abc34 56def78. what will be the values of i. s, and j after the
call? (Assume that i and j are int variables and s is an array of characters.)

anaswer:
first %d -> grabs the number 12, finds a char, ends. store 12 to variable i. right now scanf is at 'abc..'
then the %s -> continue from previous, grabs whole list of chars until it reaches whitespace, so grabs 'abc34' -> sees white space, stop
stores the string "abc34". also adds '\0' at the end
the last %d -> continue from previous whitespace, ignore. finds 56 -> then efinds 'd' which is nt a integer. stops and store '56' to variable
j

so i = 12
j = 56
s = 'abc34'

*/

#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <ctype.h>

int main(void){
    int i, j;
    char s[];

    scanf("%d%s%d", &i, s, &j);

    return 0;
}
