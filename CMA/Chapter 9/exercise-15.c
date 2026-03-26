
#include <stdio.h>
#include <stdbool.h>

/*
Exercise 15
Thefollowing (rather confusing) function finds the median of three numbers. Rewrite the
function so that it has just one return statement.

double median(double x, double y, double z)
{
    if (x <= y)
        if (y <= z) return y;
        else if (x <= z)return z;
        else return x;
    if (z <= y) return y;
    if (x <= z) return x;
    return z;
}

*/

#include <ctype.h>
#define N 8

double median(double x, double y, double z){
    double median = 0;
    // find largest
    // find smallest
    //y is the median - x > y > z
    if((x>=y && y>=z) || (z>=y && y>=x)){
        median = y;
    }else if((y>=x && x>=z) || (z>=x && x>=y)){
        //x is in the middle
        median = x ;
    }else{
        median = z;
    }
    return median;
}


int main(void){
    int a[]={10,20,30};


    printf("%f", median(1.0,2.0,3.0));

    return 0;
}

/*

*/
