// main.c
#include <stdio.h>
#include <stdbool.h>
#include  <stdlib.h>

/*
Exercise 18
Modify the compare parts function so that parts are sorted with their numbers in
descending order.
*/

int compare_parts(const void *p, const void *q){
    const struct part *p1 = p;
    const struct part *q1 = q;

    if(p1->number < q1->number){
        return 1;
    }else if(p1->number == q1->number){
        return 0;
    }else{
        return -1;
    }
}

int main(void){
    printf("The sum is: %d", sum(square, 1, 10));

    return 0;
}

/*
struct node {int value; struct node *next;};
struct node *first = NULL;

*/
