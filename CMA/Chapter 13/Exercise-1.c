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

============================================

Exercise 1
The following function calls supposedly write a single new-line character, but some are
incorrect. Identify which calls don’t work and explain why.
a. printf ( "%c", '\n' )
b. printf ( "%c", "\n");
c. printf ( "%s" ,'\n');
d. printf ( "%s" ,"\n");
e. printf('\n');
f. printf( "\n");
g. putchar('\n');
h. putchar("\n");
i. puts('\n');
j. puts("\n");
k. puts("");

answer:
a. this prints a new line - correct
b. this is invalid type since %c expects character but we give it a string literal
c. here %s expect string but we give it a newline character. \n is the number 10 - printf looks at memory address 10, doesnt have that address
d. correct - string literal
e. incorrect, printf  first arg expects char pointer to string. gives address 10 but it doesnt exist
f. correct
g. correct
h. incorrect - putchar expects a char
i. incorrect - puts expects a str
j. incorect, puts automaticaly appends newline at the end so this one prints 2 new lines
k. correct

*/

#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <ctype.h>

int main(void){
    printf('\n');
    return 0;
}
