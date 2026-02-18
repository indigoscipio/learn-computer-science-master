#include <stdio.h>

/*
LOOPS

while : checks cond before the body rund
do-while : checks cond after body runs
for : like while, but designed with how many times you wanna run it

for(xx) < here xx is called "controlling expression"

=============================================================

Exercise 6.1
What output does the folowing fragment produce?

for (i = 5, j = i - 1;  i > 0, j > 0; --i, j = i - 1)
printf("%d ", i);


answer:
lets try to analyze this
first it initialize 2 variables

initialization
i = 5
j = i-1

then on the test
i > 0
j > 0

then on thestep
--i
j = i - 1

lets try to trace this
1st call
i = 5, j = 4
then checks i > 0? true, j > 0? true
the body runs.
prints i = 5
then decrement i = 4, decrement j = 3


2st call
i = 4, j = 3
then checks i > 0? true. j > 0? true
the body runs.
prints i = 4
then decrement i = 3, decrement j = 2

3st call
i = 3, j = 2
then checks i > 0? true. j > 0? true
the body runs.
prints i = 3
then decrement i = 2, decrement j = 1

4st call
i = 2, j = 1
then checks i > 0? true. j > 0? true
the body runs.
prints i = 2
then decrement i = 1, decrement j = 0

then finally we have
i = 1, j = 0
checks i > 0, j > 0 -> since it only care about rightmost it checks j>0 so 0 > 0 is false
and the loop stops

so it prints sometihng like 5 4 3 2


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
