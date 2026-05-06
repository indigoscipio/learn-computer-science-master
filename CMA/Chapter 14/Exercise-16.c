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
Exercise 16
(C99) Assume that the following macro definitions are in effect:

#define IDENT(x) PRAGMA(ident #x)
#define PRAGMA (x) _Pragma(#x) -> #pragma something.

What will the following line look like after macro expansion?
IDENT (foo)

answer:
yeah imnotsure here what pragma does or what __pragma is i guess
based on thepaten maybe its a identity function that applies pragma with arg foo or something

#x stringizes a macro argument → foo becomes "foo"
_Pragma("something") = #pragma something but usable inside macros

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



