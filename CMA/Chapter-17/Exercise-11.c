// main.c
#include <stdio.h>
#include <stdbool.h>
#include  <stdlib.h>

/*
DYANAMIC STORAGE ALLOCATION
you can actually make storage during execution
normally with strings or arrays

MALLOC
malloc always returns void * (a generic empty pointer)
why? coz it has no idea what you're gonna return

void *malloc(size_t size)
string -> malloc(n+1)

HEAP VS STACK
heap -> is a block of memory - malloc, realloc and calloc lives here
stack -> standard variables live here - int, struct, arr, etc - system manages this area automatically

CALLOC
void * calloc(size_ t nmemb, size_ t size) ;
like malloc but it cleans the memory first
takes 2 information: num of items and size of each item

REALLOC
reallocates either by
- expanding the room
- moving to new room
void *realloc(void *ptr, size_t size);
1st arg: pointer to memory that you wanna resize (must be created malloc, realloc or calloc)
2nd arg: new totla size

FREE
void free(void *ptr)
just like realloc, this one must take poitner to memory created by alloc, realloc or calloc
you can also pass NULL

DANGLING POINTER
so after you do free(p)
if you try to use p it gives you unexpected behaviour coz its already cleaned
thats why you have to do p = NULL;

LINKED LIST
car = first->value
cdr = first->next
end of list = '() = NULL
dont forget to also update first (head pointer) everytime


*/

/*

Exercise 11
Write the following function:

int count_occurences(struct node *list, int n);

The list parameter points to a linked list; the function should return the number of times
that nappears in this list.Assume that the node structure is the one defined inSection 17.5.

answer:
lets keep it simple
*/

struct node {int value; struct node *next};
struct node *first = NULL;

int count_occurences(struct node *list, int n){
    //initialize a counter to 0
    //if current item's value matches n, increase the counter
    //otherwise 'recurse/cdr down to tne next one' until it reaches the end
    //finally reutrn the counter

    int counter = 0;
    struct node *p;
    for(p = list; p != NULL; p = p->next){
        if(p->value == n){
            counter++;
        }
    }
    return counter;
}

int main(void){


    return 0;
}
