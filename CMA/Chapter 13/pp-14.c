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
Programming Project 14
Modify ProgrammingProject lb from Chapter 8 so that it includes the following function:

bool are_anagrams(const char *wordl, const char *word2);

The functionreturns true ifthe strings pointed to by wordl and word2 are anagrams.

answer:lets keep it simple
*/

#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <ctype.h>
#include <string.h>
#define N 100
#define ALPHA_LEN 26

// checks if two words are anagram
bool are_anagrams(const char *word1, const char *word2){
    int count[26] = {0};
    char alphabet[26] = {'A','B','C','D','E','F','G','H','I','J','K','L',
                        'M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z'};

    //find the char index
    // ubstract the index

    //1st loop
    for()

    //2nd loop

    return true;
}

int main(void) {
    char wd1[N], wd2[N];
    char ch;
    int i=0;

    //store 1st word
     printf("Enter first word: ");
     while((ch = getchar()) != '\n'){
        if(isalpha(ch)){
            ch = tolower(ch);
            wd1[i] = ch;
            i++;
        }
     }
     wd1[i] = '\0';

     //store 1st word
     i=0;
      printf("Enter second word: ");
      while((ch = getchar()) != '\n'){
        if(isalpha(ch)){
            ch = tolower(ch);
            wd2[i] = ch;
            i++;
        }
     }
     wd2[i] = '\0';


    printf("%s %s", wd1, wd2);//for debug
    if(are_anagrams(wd1,wd2)){
        printf("Anagrams.");
    }else{
        printf("Not Anagrams.")
    }

    return 0;
}


