#include <stdio.h>

/*
LOOPS

while : checks cond before the body rund
do-while : checks cond after body runs
for : like while, but designed with how many times you wanna run it

for(xx) < here xx is called "controlling expression"

=============================================================

Exercise 6.8

What output does the following for statement produce?
for(i = 10; i >=1; i/=2){
    printf("%d, " i++)
}

answer:
lets evaluate this step by step
inside the for

1st call - 1 = 10;
next check if i >=1? true, body runs
prints 10, then increment i = 11 afterwards coz of the postfix ++
next 3rd expr -> i = i / 2 -> i = 11 / 2 = 5

2nd call - i = 5
next check if i >=1? true, body runs
prints 5, then increment i = 6 afterwards coz of the postfix ++
next 3rd expr -> i = i / 2 -> i = 6 / 2 = 3

3rd call - i = 3
next check if i >=1? true, body runs
prints 3, then increment i = 4 afterwards coz of the postfix ++
next 3rd expr -> i = i / 2 -> i = 4 / 2 = 2

4th call - i = 2
next check if i >=1? true, body runs
prints 2, then increment i = 3 afterwards coz of the postfix ++
next 3rd expr -> i = i / 2 -> i = 3 / 2 = 1

5 call - i = 1
next check if i >=1? true, body runs
prints 1, then increment i = 2 afterwards coz of the postfix ++
next 3rd expr -> i = i / 2 -> i = 2 / 2 = 1

hmm this seems to print infinite 1s

10 5 3 2 1 1 1 ...

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
