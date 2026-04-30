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

Exercise 18
Write the following function:
void remove_filename(char *url)

url points to a string containing a URL (Uniform Resource Locator) that ends with a file
name (such as "http: // www.knking. com/index .html "). The function should
modify the string by removing the file name and the preceding slash. (In this example, the
result will be "http: // www.knking .com".) Incorporate the"search for the end of a
string" idiom into your function. Hint: Have the function replace the last slash in the string
by a null character.


*/

#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <ctype.h>
#include <string.h>

#define N 100

void remove_filename(char *url){
    //search each char
    //find remove the last slash
    //extract the string
    char *p = url;

    while(*p) p++;

    while(p!=url){
        if(*p == '/'){
            *p = '\0';
            break;
        }
        p--;
    }
}


int main(void){
    char url[N] = "http://www.knking.com/index.html";

    remove_filename(url);
    printf("%s", url);

    return 0;
    }
