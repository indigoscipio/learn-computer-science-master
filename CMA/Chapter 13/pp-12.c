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

Programming Project 12
Modify Programming Project 14 from Chapter 8 so that it stores the words in a two
dimensional char array as it reads the sentence, with eachrow of the array storing a sin
gle word. Assume that the sentenee contains no more than 30 words and no word is more
than 20 characters long. Be sure to store a null character at the end of each word so that it
can be treated as a string.

from PP14 (reference)
Write a program that reverses the words in a sentence:
Enter a sentence: you can cage a swallow can't you? Reversal of sentence: you can't swallow a cage can you?
Hint: Use a loop to read the characters one by one and store them in a one-dimensional
chararray. Have the loop stop at a period, question mark,
or exclamation point ( the "termi nating character"), which is saved in a separate char variable. Then use a second loop to
search backward through the array for the beginning of the hist word. Print the last word,
then search backward for the next- lo-last word.
*/

#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <ctype.h>
#include <string.h>

#define WD_LEN 30
#define CH_LEN 20

int main(void) {
    char a[WD_LEN][CH_LEN], ch, terminating_char;
    int i=0, j=0;
    printf("Enter a sentence:\n");

    while((ch=getchar()) != '\n'){
        if(ch == '.' || ch == '!' || ch == '?'){
            terminating_char = ch;
            break;
        }

        if(ch!=' '){
            //start of word, store the whole word in the 2d array
            a[i][j] = ch;
            j++;
        }else{
            a[i][j]='\0';
            i++;
            j=0;
        }
    }
    a[i][j] = '\0';

    // outer loop - word
    for(;i>=0;i--){
        printf("%s ", a[i]);
    }

    printf("%c", terminating_char);

    return 0;
}


