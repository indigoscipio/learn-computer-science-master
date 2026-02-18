#include <stdio.h>

/*
LOOPS

while : checks cond before the body rund
do-while : checks cond after body runs
for : like while, but designed with how many times you wanna run it

for(xx) < here xx is called "controlling expression"


Exercise 6.1
What output does the folowing fragment produce?

i = 1;
while (i <= 128) {
printf("%d ", i);
i *= 2;
}

answer:
lets see, we start with the var i initialized to 1
and next a while loop which checks if i is lte 128
then in the body it prints i then multiplies it by 2

so first calll
1 <= 128? true
prints 1
increment new i = 1 * 2 = 2

2nd call
2 <= 128? true
prints 2
increment new i = 2 * 2 = 4

3nd call
4 <= 128? true
prints 4
increment new i = 4 * 2 = 8

4th call
8 <= 128? true
prints 8
increment new i = 8 * 2 = 16

continually until it i goes above 128
so it should print something like
1,2,4,8,16,32,64,128 which is a doubling number


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
