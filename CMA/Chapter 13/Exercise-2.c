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

Exercise 2
Supposethat p has been declared as follows:
char *p = "abc";
Which of the following function calls are legal? Show the output produced by each legal
call,and explain why the others are illegal.
(a) putchar(p) ;
(b) putchar(*p);
(c) puts(p);
(d) puts(*p);

answer:
ok so we have apointer p that points/holds the memory of the string literal "abc"
a. since p is a pointer address "abc" the type is different. it gives a junk value so not legal
b. since it points to the start of 'abc' -> grabs the first char -> so legla
c. since p is a string pointer this is legal
d. different type. *p points to address of abc, gets 'a' -> different type since puts expect string

*/

#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <ctype.h>

int main(void){
    char *p = "abc";
    printf("%c", *p);
    return 0;
}
