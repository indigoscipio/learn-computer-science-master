#include <stdio.h>

/*
LOOPS

while : checks cond before the body rund
do-while : checks cond after body runs
for : like while, but designed with how many times you wanna run it

for(xx) < here xx is called "controlling expression"

=============================================================

Exercise 6.14

 Find theerror in the following program fragment and fix it.

if (n %2 == 0);
    printf("n is even \n");

answer:
the mistake is including semicolon after the if() statement
the controling expression wont get checked and therefore the bottom will run regardless of the control expr

to fix it remove it
if(n % 2 == 0)
    printf("n is even\n");

*/

#include <stdio.h>

int main(void) {
    int n;

    for(n=2;m>0;m/=2,n++);

    return 0;
}
