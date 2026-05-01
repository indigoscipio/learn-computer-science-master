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

Programming Project 8
Modify Programming Project 5 from Chapter 7 so that it includes the following function:
int compute_scrabble_value( const char *word) ;
The function returns the SCRABBLE value of the siring pointed to by word



*/

#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <ctype.h>
#include <string.h>
#define N 100


// returns the scrabble value of the string pointed by word
int compute_scrabble_value(const char *word){
    int score = 0;

    // convert each letter to upcase
    // do the score logic
    // reutrn the score
    for(;*word!='\0';word++){
        switch(toupper(*word)){
            case 'A':
            case 'E':
            case 'I':
            case 'L':
            case 'N':
            case 'O':
            case 'R':
            case 'S':
            case 'T':
            case 'U':
                score += 1;
                break;
            case 'D':
            case 'G':
                score += 2;
                break;
            case 'B':
            case 'C':
            case 'M':
            case 'P':
                score += 3;
                break;
            case 'F':
            case 'H':
            case 'V':
            case 'W':
            case 'Y':
                score += 4;
                break;
            case 'K':
                score += 5;
                break;
            case 'J':
            case 'X':
                score += 8;
                break;
            case 'Q':
            case 'Z':
                score += 10;
                break;
            default:
                break;
        }
    }


    return score;
}

int main(void){
    char wd[N];

    printf("Enter a word to compute scrabble score: \n");
    scanf("%s", wd);
    printf("Scrabble value is: %d", compute_scrabble_value(wd));

    return 0;
}

