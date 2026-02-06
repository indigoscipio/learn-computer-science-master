#include <stdio.h>
/*
Write a program that prompts the user to enter a telephone number in the form (xxx) xxx
xxxx and then displays the number in the form xxx.xxx.xxx:
Enter phone number [(xxx) xxx-xxxx]: (404) 817-6900
You entered 404.817.6900
*/

int main(void){
    int first_num, second_num, third_num;

    printf("Enter phone number [(xxx) xxx-xxxx]: \n");
    scanf("(%d)%d-%d",&first_num,&second_num,&third_num);

    printf("You entered the number %d.%03d.%04d \n",first_num, second_num,third_num);

    return 0;
}
