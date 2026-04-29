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

Exercise 13
what does the following program print?

#include <stdio.h>

int main(void){
    char s[] = "Hsjodi", *p;

    for (p=s; *p; p++){
        --*p
    }

    puts(s);

    return 0;
}


answer:
ok lets try to analyze this line by line

first we have a char arr "Hsjodi" and a char pointer *p.

next we have a loop with
pointer p initialies to s -> first letter = "H"
runs when the value of pointer p is true (nonzero), and on each iteration it increments its value by 1
so it runs until it hits the terminator \0

and inside that we do (*p) then --(*p), so get the actual value then decrement that value
so first letter = "H", and "H" - 1 is basically "G"
repeat to the next one ->
"s"-1=r
"j"-1=i
"o"-1=n
"d"-1=c
"i"-1=h

so the char array s[] now -> "Grinch"

finally we print the line with puts(s) -> prints "Grinch" and adds a newline at the end

*/

#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <ctype.h>
#include <string.h>

#define N 100

int main(void){

    puts("Hello niggas");

    return 0;
    }
