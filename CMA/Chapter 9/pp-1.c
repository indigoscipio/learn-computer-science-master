
#include <stdio.h>
#include <stdbool.h>

/*
PP1

Write a program that asks the user to enter a series of integers (which it stores in an array),
then sorts the integers by calling the function selection_sort. When given an array
with n elements, selection_sort must do the following:

1 . Search the array to find the largest element, then move it to the last position in the array.
2. Call itself recursively to sort the first n- I elements of the array

*/

#include <ctype.h>
#define N 5

int find_largest(int a[], int n){

    /*
    // with for
    int largest = a[0];
    for(int i=1;i<n;i++){
        if(a[i]>largest) largest=a[i];
    }
    return largest;
    */

    // with recursion
    if(n==1){
        return 0;
    }

    int max_idx = find_largest(a, n-1);
    if(a[max_idx]>a[n-1]){
        return max_idx;
    }else{
        return n-1;
    }
}

int selection_sort(int a[], int n){
    // find largest element
    int largest = find_largest(a,n);
    int tmp = a[n-1];
    // move it to last pos
    a[n-1] = largest;

    //recurse
    //selection_sort(a[], n-1);
    printf("%d\n", find_largest(a,n));
}

int main(void){

    printf("Enter a series of %d integers: ", N);

    int a[N] = {0};
    for(int i=0; i<N;i++){
        scanf("%d", &a[i]);
    }

    selection_sort(a,N);
    // sort it
    printf("Your sorted array is: ");




    return 0;
}

/*

*/
