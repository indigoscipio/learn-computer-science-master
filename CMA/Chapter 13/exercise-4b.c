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

Exercise 4
Modify the read_line function in each of the following ways:


int read_line(char str[], int n){
    int ch, i = 0;

    while((ch = getchar()) != '\n'){
        if(i<n){
            str[i++] = ch;
        }
    }

    str[i]='\0';
    return i;
}


a. have it skip white space before beginning to store input characters.
b. Have it stop reading at the first white-space character. Hint: To determine whether or
not a character is white space, call the isspace function.
c.  Have it stop reading at the first new-line character, then store the new-line character in
the string.
d.  Have it leave behind characters that it doesn' t have room to store.

answer:
*/

#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <ctype.h>

#define N 99

int read_line(char str[], int n){
    int ch, i = 0;

    while( (ch = getchar()) != '\n'){
        if(i<n){
            if(isspace(ch)){
                break;
            }
            str[i++] = ch;
        }
    }

    str[i]='\0';
    return i;
}

int main(void){
    char wd[N];

   printf("%d", read_line(wd, N-1));

    return 0;
}
