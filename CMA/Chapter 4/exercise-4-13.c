#include <stdio.h>
/*

PRECEDENCE LEVEL
1. ++ --
2. + -
3. * / %
4. + -
5. = *= etc

Only one of the expressions ++i and i++ is exactly the same as (i += 1) ; which is it?
Justify your answer.

answer:
ok lets try one by one
we know that i += 1 means i = i + 1
so it's basically increment whatever value i has with 1
the question is when does the incement happen?

++i - is is the same as (i += 1)?
in prefix we first increment the value and logs i
so if we have the value i = 2, if the compiler sees this it incrmeents first
to i=3 and logs the value it afterward

i++
here we just displays the current value but increment afterwards

in i = i + 1 we increment first, then save the value to i
so its quite similar to ++i - increment first, then log the value

*/

int main(void){
    int i,j,k;

    /*
Only one of the expressions ++i and i++ is exactly the same as (i += 1) ; which is it?
Justify your answer.
    */

    return 0;
}
