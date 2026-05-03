 /*
CHAPTER 14 : PREPROCESSOR

what does # do
it 'searches and repalce' occurences of that variable

3 main job:
DIRECTIVES
#include (file inclusion) - copy pasting entire content from antoher
#define (macro) - swap name
#if, #ifdef, etc - conditional compliation

why we needit?
- reusabiliy
- conssitency
- portability

it is dumb. it doesn't have any logic like the compiler
it just earch and replace stuff;

preprocessor -> CLEAN c code -> compiler

*/

#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <ctype.h>
#include <string.h>
#define STACK_SIZE 100
#define N 100



int main(void){
    int m, d, y;
    char *months[12] = {"January","February","March","April","May","June","July","August","September",
                        "October","November","December"};

    printf("Enter a date (mm/dd/yyyy): ");
    scanf("%2d/%2d/%4d", &m, &d, &y);

    printf("You entered the date: %s %d, %d", months[m-1],d,y);


    return 0;
}



