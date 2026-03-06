#include <stdio.h>

/*

Exercise 1

Wediscussed using the expression sizeof (a ) / sizeof (a [0] ) to calculate the num
ber of elements in an array. The expression sizeof (a ) / sizeof (/ ) , where t is the type
of a’s elements, would also work, hut it's considered an inferior technique. Why?

answer:
because the sizeof type returns a size_t which is unsigned or something like that
and sometimes it would cause error so its better to use the sizeof(array element)
coz theyre like the same "type family"

also its more eficient and save more time you dont have to change one by one
if you initialize with sizeof type
You have to remember to find every place in your code where you wrote that calculation.
You have to manually update it to sizeof(double).

*/


#include <stdio.h>
#include <stdbool.h>

#define N 5

int main(void) {
    0
    return 0;
}
