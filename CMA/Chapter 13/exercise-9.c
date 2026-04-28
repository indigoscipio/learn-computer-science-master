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

STRCAT
finds the first null char ('\0') and replaces it with arg




============================================

Exercise 9
What will be the value of the string si after the following statements have been executed?

strcpy(s1, "computer");
strcpy(s1, science);
if(strcmp(s1, s2) < 0){
    strcat(s1, s2)
}else{
    strcat(s2,s1)
}
s1[strlen(s1-6) = '\0'];

answer:
ok lets analyze this one by one
so the first 2 lines we have
s1 = "computer", s2 = "science"

then the if statment it checks using strcmp(s1, s2)
if negative -> str1 comes before str2
if positive -> str1 comes after str2
"computer" vs "science" -> 1st letter = "c" vs "s" -> c comes first, so this results in negative
goes into the 1st block -> strcat(s1,s2) -> so the new s1 becomes "computerscience"
and last line we go back 6 chars ot add a null char so "computers"
*/

#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <ctype.h>
#include <string.h>

#define N 99

int main(void){
    char s1[100] = "", s2[100]= "";

    strcpy(s1, "computer");
    strcpy(s2, "science");

    if(strcmp(s1, s2)< 0){
        strcat(s1,s2);
    }else{
        strcat(s2,s1);
    }
    s1[strlen(s1)-6] = '\0';

    printf("%s", s1);


    return 0;
    }
