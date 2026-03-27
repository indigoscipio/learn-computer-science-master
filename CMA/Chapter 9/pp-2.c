
#include <stdio.h>
#include <stdbool.h>

/*
PP2
Modify Programming Project 5 from Chapter 5 so that it uses a function to compute the
amount of income tax. When passed an amount of taxable income, the function will return
the tax due.
*/

#include <ctype.h>
#define N 5


float calculate_tax(float income){
    if(income<750.00){
        return (.01 * income);
    }else if(income <=2250.00){
        return (.02 * (income - 750.00)) + 7.50;
    }else if(income <=3750.00){
        return (.03 * (income - 2250.00)) + 37.50;
    }else if(income <=5250.00){
        return (.04 * (income - 3750.00)) + 82.50;
    }else if(income <=7000.00){
        return (.05 * (income - 5250.00)) + 142.50;
    }else{
        return (.06 * (income - 7000.00)) + 230.00;
    }
}

int main(void){
    float income;

    printf("Enter your $ income amount: ");
    scanf("%f", &income);

    printf("Tax due: $%.2f", calculate_tax(income));

    return 0;
}

/*

*/
