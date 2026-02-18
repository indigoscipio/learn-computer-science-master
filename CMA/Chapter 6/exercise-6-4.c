#include <stdio.h>

/*
LOOPS

while : checks cond before the body rund
do-while : checks cond after body runs
for : like while, but designed with how many times you wanna run it

for(xx) < here xx is called "controlling expression"

=============================================================

Exercise 6.4

 4. Whichoneof the followingstatements is not equivalent to the other two(assuming that the
loop bodies are the same)?

(a) for (i = 0; i < 10; i++)
(b) for (i = 0; i < 10; ++i)
(c) for (i = 0; i++ < 10;)


answer:
lets see, lets try to analyze/trace this one by one

a. this one inits i = 0 with i < 10 check
but increments i afterwards
1st call
i = 0
2nd call
i = 1
10th call
i = 9

b. same like a but here we increment i first/prefix
1st call
i = 0
2nd call
i = 1
this is the same as a but with prefix increment
a and b increments after the body runs


c. this one does not have an increment expression
so first call i = 0
checks if 0 < 10 then increment i to 1
this one increments the checks before the body run
since its being put inside the 2nd expr


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
