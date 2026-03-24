
#include <stdio.h>
#include <stdbool.h>

/*
Exercise 10

Write functions that return the following values. (Assume that a and n are parameters,
where a is an array of int values and n is the lengthof the array.)

a. the largest element in a
b. the average of all elements in a
c. the number of positive elements in a

answer:
*/

int funa(int a[],int n){
    int largest = a[0];
    for(int i=1;i<n;i++){
        if(a[i]>largest){
            largest=a[i];
        }
    }
    return largest;
}

float funb(int a[], int n){
    int sum = 0;
    for(int i=0;i<n;i++){
        sum+=a[i];
    }
    return (float)sum/n;
}

int func(int a[], int n){
    if(n<1){
        return 0;
    }else if(a[n-1] > 0){
        return (1 + func(a, n-1));
    }else{
        return func(a, n-1);
    }
}

int main(void){
    int a[7] = {-5,-1,1,2,3,4,5};

    printf("%d\n", funa(a,7));
    printf("%d\n", funb(a,7));
    printf("%d\n", func(a,7));

    return 0;
}

/*
racket version
(cond []
      [])
*/

