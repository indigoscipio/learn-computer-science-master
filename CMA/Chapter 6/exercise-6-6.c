#include <stdio.h>

/*
LOOPS

while : checks cond before the body rund
do-while : checks cond after body runs
for : like while, but designed with how many times you wanna run it

for(xx) < here xx is called "controlling expression"

=============================================================

Exercise 6.6

translate the program fragment of exercise 1 into a single for statement
i = 1;
while (i <= 128) {
printf("%d ", i);
i *= 2;
}

answer:
*/

#include <stdio.h>

int main(void) {
    int i;

    /*
    //version 1
    for(i = 1; i <= 128; i *= 2){
    printf("%d ", i);
    }

    //version 2
    for(i = 1; i<=128;){
        printf("%d ", i);
        i*=2;
    }
    */

    //version 3
    for(i = 1; i<=128; printf("%d ", i), i*=2);


    return 0;
}
