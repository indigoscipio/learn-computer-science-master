#include <stdio.h>
/*
For each of the following pairs of scanf format strings, indicate whether or not the two
strings are equivalent. If they’re not. show how they can be distinguished.
(a) "%d" vs " %d"
(b) "%d-%d-%d" vs "%d -%d -%d"
(c) "%f" vs "%f "
(d) "%f,%f" vs "%f, %f"

answer:

a. since the space is before the % when scanning its the same
b. this one id different because the 1st one it expects a digit then dash then digit
the 2nd one expects digit, then whitespace, then dash, etc
c. this one is different since theres a spacebar after the %
its trying to look for a spacebar after user enters a number
d. this is also difference in the 1st one it expects a comma after float
but 2nd one it expects comma + spacebar after
*/

int main(void){
    float x;

    scanf("%f ", &x);
    printf("%f", x);

    return 0;
}
