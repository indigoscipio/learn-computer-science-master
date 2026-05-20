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

Exercise 7
The following loop is supposed todelete allnodes from a linked list and release the memory
that they occupy. Unfortunately, the loop is incorrect. Explain what's wrong with it and
show how to fix the bug.

for (p = first; p != NULL; p = p- >next)
free(p);

answer:
ok let me  try to analyze this
so p is a pointer to the linked list here
the for loop initialized p = first
then the end conditions it stops when p reaches null
on each iteration it moves to the next one 'cdr'ing down

and on the body it frees the pointer p repeatedyl till the end
hmm let me see where this is incorrect
so you are inthe first item in the list, then free it
then move down, then free it
then move down then free it again
when we free the pointer if i remmeber hte value becomes unitialized? idont rememebr
so when it frees the current pointer it tries to move to the next iteration p = p-> next
however since p is already cleared it does not exist

*/

for (p = first; p != NULL;){
    //lets say the type is int
    int *temp;
    temp = p->next;
    free(p);
    p = temp;
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
