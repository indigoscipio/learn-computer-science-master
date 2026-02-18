#include <stdio.h>

/*
LOOPS

while : checks cond before the body rund
do-while : checks cond after body runs
for : like while, but designed with how many times you wanna run it

for(xx) < here xx is called "controlling expression"

=============================================================

Exercise 6.5

Whichone of the following statements is notequivalent to the other two (assuming that the
loop bodies are the same)?

(a) while (i < 10) {...}
(b) for(; i < 10;) {...}
(c) do {} while (i < 10);

answer:
lets analyze this one by one

a. lets say i = 0 and we increment each call by 1
first call
0 < 10 -> true
1 < 10 -> true ...
10 < 10 -> false
executes the body

b. seems to be the same as a,
checks the test cond then runs the body
0 < 10 -> 1 < 10 -> 10 < 10? stops


c. this one since its do/while
we want to do the body first so depending on the body
this ons is difference since the check is executed after the body



answer:

*/

#include <stdio.h>

int main(void) {


    int i = 10;
    do{
        printf("T minus %d and counting\n", i);
        i--;
    } while(i > 0);


    return 0;
}
