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

Exercise 17
Write the following function:
bool testextension(const char *file_name, const char *extension);

file name points to a string containing a file name. The function should return true if
the file' s extension matches the string pointed to byextension, ignoring the case of let
ters. For example, the call test extension ("memo.txt ", "TXT") would return
true. Incorporate the “search for the end of a string" idiom into your function.

hint: use the toupper function to convert characters to uppercase before comparing them.

answer:
lets keeep this simple
*/

#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <ctype.h>
#include <string.h>

#define N 100


bool test_extension(const char *file_name, const char *extension){

    // scan fn and extract the its extension string (beginning after the dot)
    // compare that string to the extension pointer, ignoring the case
        // if they match, return true
        // else return false

    while(*file_name){
        if(*file_name == '.'){
            break;
        }
        file_name++;
    }

    if(*file_name == '\0'){
        return false;
    }else{
        file_name++;
    }

    while(*extension){
        if(toupper(*file_name) == toupper(*extension)){
            file_name++;
            extension++;
        }else{
            return false;
        }
    }

    return  *file_name == '\0' && *extension == '\0';

}


int main(void){
    char fn[N] = "memo.txt";
    char ext[N] = "TXT";

    printf("%d", test_extension(fn, ext));

    return 0;
    }
