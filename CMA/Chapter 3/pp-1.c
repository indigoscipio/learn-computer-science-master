#include <stdio.h>
/*
Write a program that accepts a date from the user in the form mm/dd/ yyyy and then dis
plays it in the form yyyymmdd:
Enter a date (mm/dd/yyyy): 2/17/2011
You entered the date 20110217


*/

int main(void){
    int m,d,y;

    printf("Please enter your date (mm/dd/yyyy): \n" );
    scanf("%d/%d/%d",&m,&d,&y);

    printf("You entered the date: %.4d%.2d%.2d",y,m,d);


    return 0;
}
