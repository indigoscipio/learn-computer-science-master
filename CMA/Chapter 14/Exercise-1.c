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

PARAMETERIZED MACRO
- less safe (no typecheck)
- cant take pointer
+ faster and more convenience, just define and replace

#define f(x y) ... ...

OPERATOR
# -> repalce arg, forprinting & debug
## - > the glue, joins 2 tokens together
good for generalizng code

ARGS
#define TEST(condition, ...) => ... can take arbitrary number of args

__FUNC__
for debug -> #define LOG_START() printf("Entering: %s\n", __func__)


#IF and #ENDIF
#if something
....
....
#endif


#ifdef & IFNDEF
*/


/*
Exercise 1
Write parameterized macros that compute the following values.

(a) The cube of x.
(b) The remainder when n is divided by 4.
(c) l if the product of x and y is less than 100. 0 otherwise.

do your macros always work? If not.describe what arguments would make them fail.

a. #define CUBE(x) ((x)*(x)*(x))
b.

answer:

*/

#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <ctype.h>
#include <string.h>
#define CUBE(x) ((x)*(x)*(x))

#define LOG_START() printf("Entering: %s\n", __func__)

int main(void){


    printf("%d", CUBE(8));

    return 0;
}



