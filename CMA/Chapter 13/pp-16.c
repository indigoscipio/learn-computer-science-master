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
Programming Project 16
Modify Programming Project I from Chapter 12 so that it includes the following function:
void reverse(chat *message)

The function reverses the string pointed to by message. Hint: Use two pointers, one ini
tially pointing to the first character of the string and the other initially pointing to the last
character. Have the function reverse these characters and then move the pointers toward
eachother, repeating the process until the pointers meet.

reference (pp1 chapter 12)
Writeaprogram that reads a message, then prints the reversalof the message:
Enter a message: Don't get mad, get even.
Reversal is: .neve teg ,dam teg t1noD

asnwer: lets keepit simple
*/

#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <ctype.h>
#include <string.h>
#define STACK_SIZE 100
#define N 100

void reverse(char *message){
    char *p, *q, temp;
    p = message, q=&message[strlen(message)-1];

    while(p!=q){
        temp = *p; //store content of p to temp var
        *p = *q;
        *q = temp;

        p++;
        q--;
    }
}

int main(void){
    char a[N], ch;
    int i=0;

    printf("Enter a message: \n");

    //get the input
    while((ch=getchar())!='\n'){
        a[i]=ch;
        i++;
    }
    a[i]='\0';

    reverse(a);
    printf("%s", a);

    return 0;
}



