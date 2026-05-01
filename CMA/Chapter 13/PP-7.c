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

Programming Project 7
Modify Programming Project 11 from Chapter5 so that it uses arrays containing pointers to
strings instead of switch statements. For example, instead of using a switch statement
to print the word for the first digit, use the digit as an index into an array that contains the
strings " twenty", " thirty",
and so forth.

PP11 reference
Write a program that asks the user for a two-digit number,
then prints the English word for
the number:
Enter a two-digit number: 43
You entered the number forty-five.
Him: Break the number into twodigits. Use one switch statement to print the word for the
first digit (“twenty
.” "thirty,'' and so forth). Use a second switch statement to print the
word for the second digit. Don't forget that the numbers between 11 and 19 require special
treatment.


*/

#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <ctype.h>
#include <string.h>

#define NUM_SUITS 4
#define NUM_RANKS 13


int main(int argc, char *argv[]){
    char *tens[] = {"ten","twenty","thirty","fourty","fifty","sixty","seventy","eighty","ninety"};
    char *teens[] = {"eleven","twelve","thirteen","fourteen","fiveteen","sixteen","seventeen","eighteen","nineteen"};
    char *base[] = {"one","two","three","four","five","six","seven","eight","nine"};
    int t, b;

    printf("Enter a two digit number: \n");
    scanf("%1d%1d", &t,&b);


    if(t == 1){
        if(b==0) printf("%s", tens[t-1]);
        else printf("%s\n", teens[b-1]);
    }else if(t == 0){
        // base
        printf("%s\n", base[b-1]);
    }else{
        //tens
        if(b==0){
            printf("%s", tens[t-1]);
        }else{
            printf("%s %s\n", tens[t-1], base[b-1]);
        }
    }

    printf("Tens: %d\n Base: %d\n", t, b); //for debug

    return 0;
}

