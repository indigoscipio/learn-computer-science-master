
#include <stdio.h>
#include <stdbool.h>

/*
Exercise 14
The following function is supposed to return true if any element of the array a has the
value 0 and false ifall elements are nonzero. Sadly, it contains an error. Find the error and
show how to fix it:

bool has_zero(int a[], int n){
    int i;

    for(i=0; i<n; i++)
        if(a[i]==0)
            return true;
        else
            return false;
}


answer:
the function returns false as soon as it detects a nonzero number, so it doesn't hceck until the end

*/

#include <ctype.h>
#define N 8



bool has_zero(int a[], int n){
    int i;

    for(i=0; i<n; i++)
        if(a[i]==0)
            return true;
        else
            return false;
}





int main(void){
    int a[]={1,1,1,0};


    printf("%d", has_zero(a,4));

    return 0;
}

/*

*/
