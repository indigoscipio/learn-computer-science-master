#include <stdio.h>

/*
LOOPS

while : checks cond before the body rund
do-while : checks cond after body runs
for : like while, but designed with how many times you wanna run it

for(xx) < here xx is called "controlling expression"

=============================================================
PP11

The value ofthemathematical constant ecanbe expressed as an infiniteseries:
e = 1 + 1/1! + 1/2! + 1/3! +...

Write a program that approximates e by computing the value of
I +1/1 !+1 /2!+1 /3!+ ...+ \/n\

where n is an integer entered by the user.

answer:
simple trace
lets say n=3

i = 0
1/0! = 1/1 = 1

i=1
1/0! + 1/1! = 1 + 1 = 2

i = 2
1/0! + 1/1! + 1/2! = 1 + 1 + 1/2 = 2.5

i=3
1/0! + 1/1! + 1/2! + 1/3! = 1 + 1 + 0.5 + 0.167 = 2.667...

so basically the basic logic it loops n times
and in each loop you want to sum the previous calculation
this shouldnt be a problem in racket but lets try this

*/

#include <stdio.h>

int main(void) {
    int n, fact_counter, i;
    float total_sum = 1;

    printf("Enter your number: \n");
    scanf("%d", &n);

    fact_counter =  1;
    for(i=1; i<=n; i++){
        fact_counter *= i;
        total_sum += 1.0 / fact_counter;
    }

    printf("Your approximation is: %.2f", total_sum);

    return 0;
}
