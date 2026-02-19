#include <stdio.h>

/*
LOOPS

while : checks cond before the body rund
do-while : checks cond after body runs
for : like while, but designed with how many times you wanna run it

for(xx) < here xx is called "controlling expression"

=============================================================

Exercise 6.8

Translate for statement of exercise 8 into an equivalent while statement.
you will need one statement in addition to the while loop itself.

for(i = 10; i >=1; i/=2){
    printf("%d, " i++)
}


*/

#include <stdio.h>

int main(void) {
    int i = 10;

    while (i >= 1) {
        printf("%d ", i++);
        i /= 2;
    }

    return 0;
}
