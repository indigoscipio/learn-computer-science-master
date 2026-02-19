#include <stdio.h>

/*
LOOPS

while : checks cond before the body rund
do-while : checks cond after body runs
for : like while, but designed with how many times you wanna run it

for(xx) < here xx is called "controlling expression"

=============================================================

Exercise 6.11

What output does the following program fragment produce?

sum = 0;
for (i = 0; i < 10; i++) {
    if (i % 2)
        continue;
    sum += i;
}
printf("%d\n", sum);

answer:
lets analyze tehis step by step
first we init sum to 0

1st call: i = 0, sum = 0
0 < 10? true, body runs
inside body checks 0 % 2 = 2 -> 0/false
else case runs: sum = 0 + 0 = 0
increase i coz of the postfix so now i = 1

2nd call: i = 1, sum = 0
1 < 10? true, body runs
inside body checks 1 % 2 = 1/true
first case runs: continue, it skips the sum +=i
increment i = 2

3rd call: i = 2, sum = 0
2 < 10? true, body runs
inside body checks 2 % 2 = 0/false
else case runs: sum = 0 + 2 = 2
increment i = 3

4rd call: i = 3, sum = 2
3 < 10? true, body runs
inside body checks 3 % 2 = 1/true
first case runs: continue, it skips the sum +=i
increment i = 4

5th call: i = 4, sum = 2
4 < 10? true, body runs
inside body checks 4 % 2 = 0/false
else case runs: sum = 2 + 4 = 6
increment i = 5

6rd call: i = 5, sum = 6
5 < 10? true, body runs
inside body checks 5 % 2 = 1/true
first case runs: continue, it skips the sum +=i
increment i = 6

7th call: i = 6, sum = 6
6 < 10? true, body runs
inside body checks 6 % 2 = 0/false
else case runs: sum = 6 + 6 = 12
increment i = 7

8th call: i = 7, sum = 6
7 < 10? true, body runs
inside body checks 7 % 2 = 1/true
first case runs: continue, it skips the sum +=i
increment i = 8

following the patterns, it sums up all even numbers up to less than 10
0 + 2 + 4 + ... 8 = 20



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
