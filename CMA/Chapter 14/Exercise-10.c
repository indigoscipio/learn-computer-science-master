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
Exercise 10
Functions can often—but not always— be written as parameterized macros. Discuss what
characteristics of a function would make it unsuitable as a macro

answer:
ok so i know not all functions can be defined as macro even if so
some of them can behave unstably. now for a example and characterstics

if we have a standard square function then itshoud be no problem to be macro
#define SQR(n) ((n)*(n)) we can put this anywhere it will just evaulte to a number eventualy
as long as guarantees to take a number as an argument. we cant do "S" * "S"

so function that can evaluate number can be substited as macro easily
so i guess the type guarantee is the first one

but how about function that retunrs function? wait c is not like racket it cannot return function
let me see what if theres another example. how about function that performs side effect. yes this might be it

take standard printf
#define PRINT(ARG) printf("something", ARG) - thisone can only take fixed number of argment
which is counterintuitive whereas the generic printf("str", arg1,arg2, ..., argn) can take n amount of argument


another one is side effect lets take #define SQR(x++) ((x++) * (x++))
if theres a few ocurence of SQR, the macro will keep substituting and increment x++
however in a normal function, it is scoped so the increment will only happen inside the scope.
int sqrt(int n){return n * n;}
sqr(x++); this only happens once

next is recursive function
if we define recursive function in macro then a wihin that is another call to macro itself
macro cannot evaluate revusrive function. it will just expand forever, can detect no state change to the args.
functions have their own stack and local environment and scope. macro is just substitution. function is just evaluation.




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



