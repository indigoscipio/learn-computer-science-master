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

Exercise 5

suppose that f and p are declared as follows:

struct{
    union{
        char a,b;
        int c;
    } d;
    int e[5];
} f, *p = &f;

which of the following statements are legal?

(a) p->b = ' ';
(b) p->e[3] = 10;
(c) (*p).d.a = '*';
(d) p->d->c = 20;

answer:
ok let me analyze one by one

a. here we use arrow operator to access p which is reference from f
since p is a pointer its allowed but
p-> b we dont have a 'b' inside the struct, only the int e and union d so i dont think this is legal
or in other words you are skipping al evel

b. here we use arrow operator to access the int array
we are changing the 4th index to 10 so its legal

c. here we are using the dereference to access p
then acess the struct d, then inside modify char a to '*'.
this islegal

d. this is not legal
the irst p-> d is correct but when you do -> c
since the c is a union you have to access it with the dot operator so
p->d.c = 20

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
    return 0;
}
