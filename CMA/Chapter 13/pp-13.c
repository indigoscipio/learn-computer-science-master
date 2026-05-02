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
Programming Project 13
Modify Programming Project 15 from Chapter 8 (casesar cypher) so that it includes the following function:
void encrypt(char‘message, int shift);


The function expects message to point to a string containing the messageto be encrypted;
shiftrepresents theamount by which each letter in the message is to he shifted.


*/

#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <ctype.h>
#include <string.h>
#define N 100

void encrypt(char *message, int shift){

    while(*message){
        //uppercase
        if(isupper(*message)){
            *message = ((*message - 'A') + shift) % 26 + 'A';
        }else if(islower(*message)){
            //lowcase
            *message = ((*message - 'a') + shift) % 26 + 'a';
        }
        message++;
    }
}

int main(void) {
    char ch, message[N];
    int i=0, shift_amt=0;

    printf("Enter message to be encrypted: ");

    //store input in a array
    while((ch = getchar()) != '\n'){
        message[i] = ch;
        i++;
    }
    message[i]='\0';

    printf("Enter your shift value: ");
    scanf("%d", &shift_amt);

    encrypt(message,shift_amt);
    printf("%s", message);

    return 0;
}


