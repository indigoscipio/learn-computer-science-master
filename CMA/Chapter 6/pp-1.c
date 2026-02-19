#include <stdio.h>

/*
LOOPS

while : checks cond before the body rund
do-while : checks cond after body runs
for : like while, but designed with how many times you wanna run it

for(xx) < here xx is called "controlling expression"

=============================================================
PP1
Write a program that finds the largest in a series of numbers entered by the user. The pro
gram must prompt the user to enter numbers one by one. When the user enters 0 or a nega
Enter a number: 60
Enter a number: 38.3
Enter a number: 4.89
Enter a number: 100.62
Enter a number: 75.2295
Enter a number: 0
tive number, the program must display the largest nonnegative number entered:
The largest number entered was 100.62
Notice that the numbers aren't necessarily integers.

*/

#include <stdio.h>

int main(void) {
    float input_num, largest_num = 0.0f;

    /*
    // with for
    for(;;){
        printf("Enter a number; \n");
        scanf("%f",&input_num);
         if(input_num <= 0){
             printf("Your largest number is %f\n", largest_num);
             break;
        }if(input_num > largest_num){
            largest_num = input_num;
        }
    }
    */

    /*
    //with while
    printf("Enter a number: \n");
    scanf("%f", &input_num);
    largest_num = input_num;

    while(input_num>0){
        if(input_num > largest_num){
            largest_num = input_num;
        }
        printf("Enter a number: \n");
        scanf("%f", &input_num);
    }
    printf("Your largest number is %f\n", largest_num);
    */

    //with do/while
    printf("Enter a number: \n");
    scanf("%f", &input_num);
    largest_num = input_num;
    do{
        if(input_num > largest_num){
            largest_num = input_num;
        }
        printf("Enter a number: \n");
        scanf("%f", &input_num);
    }while(input_num>0);
    printf("Your largest number is %.2f\n", largest_num);


    return 0;
}
