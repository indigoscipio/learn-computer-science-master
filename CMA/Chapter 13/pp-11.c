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

Programming Project 11
Modify Programming Project 13 from Chapter 7 so that it includes the following function:

double compute_average_word_length(const char *sentence);

The function returns the average length of the words in the siring pointed to by sentence.


*/

#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <ctype.h>
#include <string.h>
#define N 100

double compute_average_word_length(const char*sentence){
    char prev_ch = ' ';
    int total_words = 0, total_letters = 0;
    double length = 0.0;

    while(*sentence!='\0'){
        if(*sentence != ' '){
            total_letters++;
        };
        if(*sentence != ' ' && prev_ch == ' '){
            total_words++;
        }

        prev_ch = *sentence;
        sentence++;
    }

    length = (double)total_letters/total_words;
    return length;
}

int main(void) {
    char sent[N];
    int i=0;
    char ch;

    printf("Enter a sentence: \n");

    do{
        ch = getchar();
        sent[i] = ch;
        i++;
    }while(ch != '\n');
    sent[i-1] = '\0';

    printf("%s", sent);
    printf("Average length is %.2f\n", compute_average_word_length(sent));


    return 0;
}

