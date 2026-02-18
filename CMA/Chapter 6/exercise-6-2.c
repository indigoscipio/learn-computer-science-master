#include <stdio.h>

/*
LOOPS

while : checks cond before the body rund
do-while : checks cond after body runs
for : like while, but designed with how many times you wanna run it

for(xx) < here xx is called "controlling expression"


Exercise 6.1
What output does the folowing fragment produce?

i = 9384;
do {
printf("%d ", i);
i /= 10;
} while (i > 0);

answer
lets see, first we init i to 9384
then we have a do/while
inside the do we execute the body

init body run
prints 9384
then we perform division -> i = 9384 / 10 = 938

then it checks the while control expr
938 > 0 ? true

then 2nd call body
prints 938
then we perform division -> i = 938/ 10 = 93

then it checks the while control expr
93 > 0 ? true

then it checks the while control expr
93 > 0 ? true

then 3nd call body
prints 93
then we perform division -> i = 93/ 10 = 9

then it checks the while control expr
9 > 0 ? true

then 4nd call body
prints 9
then we perform division -> i = 9/ 10 = 0

finally it reaches 0 > 0 which is false so the do/whil stops
it prints something like

9384 938 93 9




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
