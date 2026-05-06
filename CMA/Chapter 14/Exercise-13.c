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
Exercise 13
a) Show what the following program will look like after preprocessing. You may ignore
any lines added to the program as a result of including the <stdio.h> header.

b. what will be the output of this program?

#include <stdio.h>
#define N 100

void f(void);

int main(void){
    f();
    #ifdef N
    #undef N
    #endif
        return 0;
}

void f(void){
    #if defined(N)
        printf("N is %d\n", N);
    #else
        printf("N is undefined\n");
    #endif
}

answer:
after preprocessing i think the code willbe smth like this
imightbewrong here but the idea is the all macro definition is subtituted,
leavind it blank and ready to compile

#include <stdio.h> - becomes <blank>
#define N 100 - becomes <blank>

void f(void);

int main(void){
    f();
    #ifdef N  ; blank
    #undef N ; N here is defined as macro, N gets undefined.
    #endif   ; blank
        return 0;
}

void f(void){
    #if defined(N)
        printf("N is %d\n", N);
    #else
        printf("N is undefined\n"); since N is undefined, macro goes to else and substitute "N is undefined", the rest become blank
    #endif
}

b. so essentialy after preprocessing
f(void) only has one line, which is just is a function that prints "N" is undefined
and the main function just calls to f(), and reutnrs 0. all macros are subsituted

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



