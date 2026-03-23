
#include <stdio.h>
#include <stdbool.h>

/*
Exercise 5
Write a function num_ digits( n) that returns the number of digits in n (a positive inte
ger). Hint: To determine the number of digits in a number n, divide it by l() repeatedly.
When n reaches 0. the number of divisions indicates how many digits n originally had
*/

int num_digits(int n){

    /*
    int total = 0;
    while(n != 0){
        total++;
        n/=10;
    }
    return total;*/

    //recursion version

    if(n < 1){
        return n;
    }else{
        return (1 + num_digits(n / 10));
    }

}

int main(void){
    int n;

    printf("Enter your number: ");
    scanf("%d", &n);

    printf("Number of digit is: %d",num_digits(n));


    return 0;
}
