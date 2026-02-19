#include <stdio.h>

/*
LOOPS

while : checks cond before the body rund
do-while : checks cond after body runs
for : like while, but designed with how many times you wanna run it

for(xx) < here xx is called "controlling expression"

=============================================================

Exercise 6.8

Show how to replace a continue statement by an equivalent goto statement.


*/

#include <stdio.h>

int main(void) {
    int i = 0;

    //example simple counter that stops at 12
    while (i < 20) {
        if(i == 13){
        goto loop_done;
        }


        printf("%d ", i);
        i++;


        loop_done:
    }
    return 0;
}
