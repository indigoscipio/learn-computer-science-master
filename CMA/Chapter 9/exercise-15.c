
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

    // find largest
    // find smallest
    double median = 0;

    if(x>=y){
        //x is not the smallest
        if(z>=x){
            median = x;
        }
        if(z<y){
            median=y;
        }
    }else{
        //y>x
        if(z>=x){
            median = x;
        }
        if(z<y){
            median=y;
        }
    }
    return median;

}


int main(void){
    int a[]={1,1,1,0};


    printf("%d", has_zero(a,4));

    return 0;
}

/*

*/
