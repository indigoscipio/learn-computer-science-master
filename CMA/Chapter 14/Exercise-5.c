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
Exercise 5
Let TOUPPER be the following macro
#define TOUPPER (c) ( •a •<= (c) &&(c) <= 1 z 1? (c)- *a1+ ’A •: (c) )

Let s be a string and let i be an ir.t variable.Show the output produced by each of the fol
lowing program fragments.

(a) strcpy (s, "abed") ;
    i = 0;
    putchar (TOUPPER (s[++i])) ;


(b) strcpy(s, "0123") ;
    i = 0;
    putchar(TOUPPER(s[++i])) ;

answer:
sobasicaly the macro converts alphabetical ascii to uppercase with simple ternary operator, lets analyze onebyone
a. we have s = "abcd"
and i = 0
then inside putchar we have passin the toupper with arg (s[++i]) -> lets expand
'a' <= (s[++i]) && (s[++i]) <= 'z' ? (s[++i]) - 'a' + 'A' : (s[++i])
'a' is less than 'b' -> increment 1
'c' is less than 'z' -> increment
goes to 1st case -> increment 1 -> 'd' -> convert to uppercase 'D'


b. we have s = "0123"
and i=0;
then putchar call similar to a. same arg to putchar. same arg to toupper.
'a' <= (s[++i]) && (s[++i]) <= 'z' ? (s[++i]) - 'a' + 'A' : (s[++i])
a < 1? false. 2nd and skipped
goes to else case
increment again -> now becomes 2
prints '2'




b.


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



