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
Exercise 7
Let GENERIC MAX be the following macro:
#define GENERIC_MAX(type)           \
type type##_max(type x, type y)     \
{                                   \
    return x > y ? x : y            \
}                                   \

a. show the preprocessor expansion of GENERIC_MAX(long)
b. explain why GENERIC_MAX doesn't work for  basic types such as unsigned long
c. describe a technique that would allow us to use GENERIC_MAX with basic types such as
unsigned long. int: don't change the definition of GENERIC_MAX

answer:
a. expansion. with macro arg = long
long long_max(long x, long y)
{
    return x > y ? x : y
}

b. it doesn't work because ifweuse 'unsigned long' as arg it becomes
unsigned long unsigned long_max(unsigned long x, unsigned long y)
{
    return x > y ? x : y
}
where unsigned <space> long_max is not a valid syntax/proper function

c. notsure about this one. im guessing if the type is morethan 2 word, just concat it using the ##?
actually wecan just use typedef here
typedef unsigned long ulong. and then pass ulong as the argument


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



