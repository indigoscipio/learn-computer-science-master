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

Exercise 15
let f be the following function:

int f(char *s, char *t){
    char *p1, *p2;

    for(p1=s;*p1;p1++){
        for(p2=t; *p2; p2++){
            if(*p1==*p2) break;
        }
        if(*p2 == '\0') break;
    }

    return p1-s;
}

a. what is the value of f("abcd", "babc")?
b. what is the value of f("abcd","bcd")?
c. in general, what value does f return when passed two string s and t?

answer:
lets analyse this one by one
a. f("abcd", "babc")
*s = "abcd", *t = "babc"

1st iteration
outer loop, *p initialized to sn stop when it reaches null char, increment on each iteration
loop through each letter of s -> "abcd" -> *p = "a" -> starts with "a"

inner loop -> loop throuch each letter of t -> "babc" -> "b"
"a" == "b" ? false, keep checking until there's a same letter as "a"
"a" == "a" ? true, break the loop

goes back ot he outer loop -> checks if *p2 == '\0' ? false
continues the outer loop

-----

2nd iteration
outer loop, char now = "b"

inner loop
starts with "b" again
"b" = "b" ? true, break out of the inner loop

goes back to outer
"b" == '\0' ? false, continue the loop

-----

3rd iteration
outer loop -> char = "c"

inner loop
starts with "b" again
"c" == "b" ? false
"c" == "a" ? false
"c" == "b" ? false
"c" == "c" ? true

goes back to the outer loop
checks if "c" == '\0' -> false, not a null char, loop continues

-----

4th iteration
outer loop -> char "d"

inner loop
starts with "b" again
"d" == "b" ? false
"d" == "a" ? false
"d" == "b" ? false
"d" == "c" ? false
no match found , increment p2 -> now '\0'
since its the null char it breaks from the whole loop

returns p1 - s
p1 stops at "d" -> which is index 3
and s is basically just index 0
so 3 - 0 = 3
it returns 3


b.f("abcd","bcd")
*s = "abcd", *t = "bcd"

1st iteration
outer loop -> char = "a"

inner loop
starts with "b"
"a" == "b" ? false
"a" == "c" ? false
"a" == "d" ? false. break. increment p2 to null char

goes back to the outer loop
checks if *p2 == '\0', true. the whole loop breaks.

return p1 which is at index 0 and s also 0
itreutrns 0


c. it returns how many characters from the beginning os s
are all found in t until hitting one that is not

counts how many characters at the start of string s exist within string t
Once it hits a character that isn't in t, it stops "taking" and returns the count.
*/

#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <ctype.h>
#include <string.h>

#define N 100

int main(void){

    puts("Hello niggas");

    return 0;
    }
