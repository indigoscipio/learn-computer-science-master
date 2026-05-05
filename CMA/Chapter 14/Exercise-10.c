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

GOLDEN RULE OF PARAMETER PREPROCESSOR
wrap args in () - to protect  operator preecende on input
wrap epxr in () - protect associativity

*/


/*
Exercise 9
Write the following parameterized macros.

a. CHECK(x,y,n) -> has value 1 if both x and y fall between 0 and n-1 inclusive
b. MEDIAN(x,y,z) -> finds the median of x,y, and z
c. POLYNOMIAL(x) -> computes polynomial 3x^5 + 2x^4 + 5x^3 - x^2 + 7x - 6

answer:
a. #define CHECK(x,y,n) ( ((x) >= 0) && ((x) <= ((n)-1)) ) && ( ((y) >= 0) && ((y) <= ((n)-1)) ) ? 1 : 0
b. #define MEDIAN(x,y,z) (x >= y && x <= z || x >= z && x <= y) ? x :
(y >= x && y <= z || y >= z && y <= x) ? y : z
c. #define POLYNOMIAL(x) (x*(x*(x*(x*((3*x) + 2) + 5) - 1) + 7) - 6)



howdoi write exponent macro here

*/

#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <ctype.h>
#include <string.h>
#define NELEMS(a) (sizeof(a)/sizeof(a[0]))

int main(void){
    int a[5] = {0};

    printf("%d\n", NELEMS(a));

    return 0;
}



