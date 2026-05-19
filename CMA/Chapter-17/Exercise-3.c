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
Exercise 3
Write the following function

int *create array(int n, int initial_value);
The function should return a pointer to a dynamically allocated int array with n members,
each of which is initialized to initial_value. the reutrn type should be NULL if the array can't be allocated.

answer:
*/

int *create_array(int n, int initial_value){
    int *p;
    p = malloc(sizeof(int) * n);

    if(p == NULL){
        printf("Malloc returns null");
    }else{
        for(int i=0;i<n;i++){
            *(p+i) = initial_value;
        }
    }

    return p;
}



char *duplicate(char *str){
    char *p;
    p = malloc(strlen(str) + 1);

    if(p == NULL){
        printf("malloc returns null");
        return p;
    }else{
        return strcpy(p, str);
    }
}



void *my_malloc(size_t size){
    void *p;
    p = malloc(size);

    if(p == NULL){
        printf("Error: malloc returns a null pointer");
        exit(EXIT_FAILURE);
    }else{
        return p;
    }

}

int main(void){
    return 0;
}
