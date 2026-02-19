#include <stdio.h>

/*
LOOPS

while : checks cond before the body rund
do-while : checks cond after body runs
for : like while, but designed with how many times you wanna run it

for(xx) < here xx is called "controlling expression"

=============================================================

Exercise 6.11

The following “prime-testing" loop appeared in Section 6.4 as an example:

for(d = 2; d < n; d ++){
    if(n%d ==0){
        break;
    }
}

sum = 0;

This loop isn't very efficient. It's not necessary to divide n by all numbers between 2 and
n- I todetermine whether it’s prime. In fact, we need only check divisors up to the square
root of n. Modify the loop to take advantage of this fact. Hint: Don't try to compute the
square root of n; instead, compare d * d with n.

answer:
*/

#include <stdio.h>

int main(void) {
    int d;

    for(d = 2; (d * d) <= n; d++){
        if(n%d ==0){
            break;
        }
    }

    return 0;
}
