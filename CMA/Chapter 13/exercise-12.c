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

Exercise 12
Write the following function:

void get_extension(const char *file_name, char *extension)

file_ namepoints toa stringcontaininga filename. The function should store the exten
sion on the file name inthe string pointed toby extension. For example ,ifthe tilename
is "memo ,txtthefunction will store "txt" inthe stringpointed toby extension. If
the file name doesn 't have an extension , the function should store an empty string (a single
nullcharacter )in the string pointed toby extension. Keep the functionas simple aspos

answer:
*/

#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <ctype.h>
#include <string.h>

#define N 100

void get_extension(const char *file_name, char *extension){
    //scan the word and extract the extension (ater dot)
        //if theres no dot/extension, store a null char instead
        // else store the extension into *ext pointer


    while(*file_name != '\0'){

        if(*file_name == '.'){
            file_name++;
            strcpy(extension, file_name);
            return;
        }

        file_name++;
    }

    strcpy(extension, "");
}


int main(void){
    char fn[]="memo.txt.zip";
    char ext[N]= "";

    get_extension(fn, ext);
    printf("%s", ext);

    return 0;
    }
