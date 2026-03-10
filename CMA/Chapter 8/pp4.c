#include <stdio.h>

/*
PP4

Modify the reverse,
c program of Section 8.1 to use the expression (int)
(sizeof(a) / sizeof(a[0]))(orumacro with this value) for the array length


*/

#include <stdio.h>
#include <stdbool.h>
#define SIZE 10
#define N (int) (sizeof(a)/(sizeof(a[0])))

int main(void) {
    int a[SIZE], i;

    printf("Enter %d numbers: ", N);

    for(i = 0 ; i < N; i++){
        scanf("%d", &a[i]);
    }

    printf("In reverse order: \n");
    for(i = N - 1; i >= 0; i--){
        printf(" %d", a[i]);
    }
    printf("\n");

    return 0;
}
