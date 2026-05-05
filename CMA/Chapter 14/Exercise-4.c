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
Exercise 4
Foreach of thefollowing macros, give an example that illustratesa problem with the macro
and show how to fix it.
a. #define AVG(x,y) (x-y) / 2
b. #define AREA(x,y) (x)*(y)

a. arg is not individualy wrapped in parnthesiss
example -> AVG(1+2, 3+4)
AVG(x,y) (1+2-3+4) / 2 -> 3-3+4 -> 4

corect version should be
#define AVG(x,y) (((x)-(y)) / 2)

b. the whole expression isnot wrapped in parentehsis
example -> x=3, y=-5

AVG is being put inside anothe expression
something like (2 * AVG + 3) -> (2 * 3 * -5 + 3) -> associativity error

corect version sould be
#define AREA(x,y) ((x)*(y))



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



