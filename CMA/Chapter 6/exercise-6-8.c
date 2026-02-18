#include <stdio.h>

/*
LOOPS

while : checks cond before the body rund
do-while : checks cond after body runs
for : like while, but designed with how many times you wanna run it

for(xx) < here xx is called "controlling expression"

=============================================================

Exercise 6.6

translate the program fragment of exercise 2 into a single for statement
i = 9384;
do {
printf("%d ", i);
i /= 10;
} while (i > 0);


answer:
*/

#include <stdio.h>

int main(void) {
    int i;


    // version 1
    for(i = 9384; i > 0; i/=10){
        printf("%d ", i);
    }


    //version 2
    for(i = 9384; i > 0;){
        printf("%d ", i);
        i/=10;
    }


    //version 3
    for(i = 9384; i > 0; printf("%d ", i), i/=10);

    return 0;
}
