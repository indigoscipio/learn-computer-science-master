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

Exercise 6
Write a function named censor that modifies a string by replacing every occurrence of
foo by xxx.Forexample, thestring "food fool" wouldbecome"xxxd xxxl". Make
the function as short as possible without sacrificing clarity.

answer:
*/

#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <ctype.h>

#define N 99

void censor(char a[]){
    int i=0;
    char ch;

    // check if 1st letter = f, 2nd = o, 3rd = o
    // if so replace them with xxx
    while(a[i]!='\0'){
        if(a[i] == 'f' && a[i+1] == 'o' && a[i+2] == 'o'){
            a[i] = 'x';
            a[i+1] = 'x';
            a[i+2] = 'x';
            i+=3;
        }else{
            i++;
        }
    }
}

int main(void){
    char wd[N] = "food fool foam foom!";

    censor(wd);
    printf("%s", wd);

    return 0;
}
