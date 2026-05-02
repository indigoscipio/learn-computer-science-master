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

Programming Project 10
Modify Programming Project 11 from Chapter 7 so that it includes the following function:

void reverse name(char *name) ;

The function expects name to point to a siring containing a first name followed by a last
name. It modifies the string so that the last name comes first, followed by a comma,a space,
the first initial, and a period. The original string may contain extra spaces before the first
name, between the first and last names, and after the last name.


*/

#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <ctype.h>
#include <string.h>
#define N 100


    void reverse_name(char *name){
        char result[N]= "";
        char *p;
        char initials[3];

        //get last name, start from the back and decrement until it hits a space
        //then combine it with first initial, followed by space.

        // skip spaces
        for(p=&name[strlen(name)-1];*p==' '; p--);
        *(p+1) = '\0';

        // scans char
        for(; *p != ' ';p--);

        p++;

        strcpy(result, p);
        strcat(result, ", ");

        //build the initials
        initials[0] = *name;
        initials[1] = '.';
        initials[2] = '\0';


        strcat(result, initials);
        printf("%s", result);
    }

int main(void) {
    char name[N];
    char ch;
    int i=0;

    printf("Enter your first and last name: \n");


    do{
        ch = getchar();
        name[i] = ch;
        i++;
    }while(ch != '\n');
    name[i-1] = '\0';

    reverse_name(name);
    //printf("%s\n", name); //for debug

    return 0;
}

