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
Write the following function:

void build_index_url(const char *domain, char *index_ url)
domain points toa string containing an Internet domain,such as "knking. com".The
function should add "http ://www ." to the beginning of this string and " /
index.html" to the end of the string,storing the result in the string pointed to by
index_ url. (In this example, the result will be "http://www.knking.com/
index.html".)You may assume that index url points to a variable that is long
enought tohold the resultingstring. Keep the functionas simple as possible by having ituse
the strcat and strcpy functions.


answer:
lets keep htis as simple as possible
*/

#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <ctype.h>
#include <string.h>

#define N 100

void build_index_url(const char *domain, char *index_url){
    // add http://... at the beginning
    // add /index_url at the end
    // store the result in the index_url pointer, keep it simple

    char proto[N] = "http://www.";
    char index[N] = "/index.html";

   strcat(proto, domain);
   strcat(proto, index);

   // copy the final string into index_url
   strcpy(index_url, proto);
}


int main(void){
    char domain[] = "google.com";
    char index_url[N] = "";

    build_index_url(domain, index_url);
    printf("%s", index_url);

    return 0;
    }
