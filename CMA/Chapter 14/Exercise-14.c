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
Exercise 14
Show what the following program will look like after preprocessing. Some lines of the pro
gram may cause compilation errors: find all such errors.
#define N = 10
#define INC(x) x+1
#define SUB (x,y) x-y
#define SQR(x) ((x)*(x))
#define CUBE(x) (SQR(x)*(x))
#define Ml(x,y) x##y
#define M2(x,y) #x #y

int main(void){
    int a[N, i, j, k, m;

    #ifdef N
        i = j;
    #else
        j = i;
    #endif

    i = 10 * INC(j);
    i = SUB(j,k);
    i = SQR(SQR(j));
    i = CUBE(j);
    i = M1(j,k);
    puts(M2(i,j));

    #undef SQR
        i = SQR(j);
    #define SQR;
        i = SQR(j);

    return 0;
}

answer: ok lets analyze step by step. i could be wrong or overcomplicate things here but let me try.

#define N = 10 -> legal but wrong. should be no =, just #define N 10.
#define INC(x) x+1 -> add parenthesis around arg and whole expr, so shouldbe INC(x) ((x) + 1)
#define SUB (x,y) x-y -> incorrect here should contain no space so shouldbe SUB(x,y). also need to include parens ((x)-(y))
#define SQR(x) ((x)*(x)) -> correct i think
#define CUBE(x) (SQR(x)*(x)) -> add parenthesis around SQR(x) tobesafer CUBE(x) ((SQR(x))*(x));
#define Ml(x,y) x##y -> note: glues two tokens together
#define M2(x,y) #x #y -> note: stringize the two args "x" "y" into two seperate string literals -> "xy"

int main(void){
    int a[N], i, j, k, m; ; ijkm has junk value

    #ifdef N
        i = j; since N is defined but incorrectly above, i = j after preprocessing. but its still defined.
    #else
        j = i;
    #endif

    i = 10 * INC(j); -> after preproc: i = 10 * j+1. incorect asociation
    i = SUB(j,k); -> defined incorectly above
    i = SQR(SQR(j)); -> afer preprocsing -> i = (((j)*(j)) * ((j)*(j)))
    i = CUBE(j); -> i = (SQR(j)*(j))
    i = M1(j,k); -> i = jk
    puts(M2(i,j)); -> puts(#i #j) -> puts("i" "j") -> puts("ij")

    #undef SQR
        i = SQR(j); after preprocessing -> SQR gets undefined
    #define SQR -> after preprocessing -> SQR becomes nothing.
        i = SQR(j); -> i = (j) -> basically still valid, just i = j
        ; putting () around vars just help control evaluation order and associativity.

    return 0;
}

#define N = 10 just defines N as = 10 -> when a[N] expands it becomes a[= 10] -> error

i = j; since N is defined but incorrectly above, i = j after preprocessing. but its still defined.

i = jk here jk is not defined it should be int



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



