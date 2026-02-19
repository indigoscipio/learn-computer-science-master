#include <stdio.h>

/*
LOOPS

while : checks cond before the body rund
do-while : checks cond after body runs
for : like while, but designed with how many times you wanna run it

for(xx) < here xx is called "controlling expression"

=============================================================

Exercise 6.11

Rewrite the follow ing loop so that its body is empty:

for(n=0; m>0; n++)
    m/=2;

answer:
for(n=0;m>0;m/=2,n++);
run the body then increment

*/

#include <stdio.h>

int main(void) {
    int n;

    for(n=2;m>0;m/=2,n++);

    return 0;
}
