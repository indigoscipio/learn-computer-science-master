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

Programming Project 1

Write a program that finds the“smallest” and “largest" in a seriesof words. After the user
enters the words, the program will determine which words would come first and last if the
words were listed in dictionary order. The program must stop accepting input when the user
enters a four-letter word. Assume that no word is more than 20 letters long. An interactive
session with the program might look like this

Enter word: dog
Enter word: zebra
Enter word: rabbit
Enter word: catfish
Enter word: walrus
Enter word: cat
Enter word: fish
Smallest word: cat
Largest word: zebra

Hint: Use two strings named smallest word and largest word to keep track of the
“smallest" and “largest” words entered so far. Each time the user enters a new word, use
strcmp tocompare it with smallest_word: if the new word is “smaller." use strcpy
to save it in smallest word. Do a similar comparison with largest_word. Use
strlen to determine when the user has enterd a four letter word

answer:
lets keep this simple


*/

#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <ctype.h>
#include <string.h>

#define N 20

int main(void){
    char smallest_wd[N]="", largest_wd[N]="";
    char wd[N]="";

    //main loop: get out when user enters 4 letter word
    do{
        printf("Enter word: ");
        scanf("%s", wd);
        printf("%s\n", wd); // for debug

        if(strlen(wd) == 4) break;

        //first word
        if(*smallest_wd == '\0') strcpy(smallest_wd, wd);
        if(*largest_wd == '\0') strcpy(largest_wd, wd);

        // check wd vs smallest + largest
            // if wd > largest_wd, update largest_wd
            // if wd < smallest_wd, update smallest wd

        if(strcmp(wd, smallest_wd) < 0){
            //wd comes early
            strcpy(smallest_wd, wd);
        }

        if(strcmp(wd, largest_wd) > 0){
            //wd is equal or come later
            strcpy(largest_wd, wd);
        }

    }while(strlen(wd) != 4);

    printf("Smallest word is: %s\n", smallest_wd);
    printf("Largest word is: %s\n", largest_wd);

    return 0;
    }
