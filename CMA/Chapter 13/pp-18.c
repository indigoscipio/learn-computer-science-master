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
Programming Project 18
Write a program that accepts a date from the user in the form mm/dd/yyyy and then dis
plays it in the form month dd, yyyy.wheremonth is the nameof the month:

Enter a date (mm/dd/yyyy): 2/17/2011
You entered the date February 17, 2011

store the month names in an array that contains pointers to strings.

answer:
lets keep it simple
*/

#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <ctype.h>
#include <string.h>
#define STACK_SIZE 100
#define N 100



int main(void){
    int m, d, y;
    char *months[12] = {"January","February","March","April","May","June","July","August","September",
                        "October","November","December"};

    printf("Enter a date (mm/dd/yyyy): ");
    scanf("%2d/%2d/%4d", &m, &d, &y);

    printf("You entered the date: %s %d, %d", months[m-1],d,y);


    return 0;
}



