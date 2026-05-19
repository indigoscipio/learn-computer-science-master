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
Exercuse 1
Having to check the return value of malloc (or any other memory allocation function)
_malloc and ask it to allocate n bytes, it in
each time wc call it can he an annoyance. Write a function named my malloc that serves
as a “wrapper" for malloc. When wecall my
turn calls malloc, tests to make sure that malloc doesn’t return a null pointer, and then
returns the pointer from malloc. Have my
the program if malloc returns a null pointer.
_malloc print an error message and terminate

answer:
*/


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

    printf("%d", abs(-8));

    return 0;
}
