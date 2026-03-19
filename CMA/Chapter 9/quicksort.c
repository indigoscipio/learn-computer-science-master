
#include <stdio.h>
#include <stdbool.h>

#define N 10

void quicksort(int a[], int low, int high);
int split(int a[], int low, int high);

int main(void){

    int a[N], i;

    printf("Enter %d numbers to be sorted: ", N);

    for(i=0;i<N;i++){
        scanf("%d", &a[i]);
    }

    quicksort(a,0, N-1);

    printf("In sorted order: ");
    for(i=0;i<N;i++){
        printf("%d",a[i]);
    }
    printf("\n");

    return 0;
}


void quicksort(int a[], int low, int high){
    int middle;

    if (low >= high) return;

    middle = split(a,low,high);
    quicksort(a,low,middle-1);
    quicksort(a, middle + 1, high);


}

// picks pivot, moves everything smaller to the left
int split(int a[], int low, int high){
    int part_element = a[low];

    for (;;) {
        //find element smaller than pivot, skip big number thats already in plce
        while (low < high && part_element <= a[high])
        high-- ;
        if (low >= high) break;
        a[low++] = a[high];

        // find element larger than pivot, skip small number already in palce
        while (low < high && a[low] <= part_element)
        low++ ;
        if (low >= high) break;
        a[high--] = a[low];
    }

    a[high] = part_element;
    return high;
}
