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

Exercise 13
The following function is supposed to insert a new node into its proper place in an ordered
list, returning a pointer to the first node in the modified list. Unfortunately, the function
doesn't work correctly in all cases. Explain what's wrong with it and show how to llx it.
Assume that the node structure is the one defined in Section 17.5.

struct node *insert_into_ordered_list(struct node *list, struct node *new_node){
    struct node *cur = list, *prev = NULL;
    while(cur->value <= new_node->value){
        prev = cur;
        cur = cur->next;
    }

    if(prev == NULL){
        new_node->next = cur;
        return new_node;
    }

    prev->next=new_node;
    new_node->next = cur;

    return list;
}

answer:
ok lets try to analyze this ill probably get this wrong but let me try

so the function takes 2 things, the list and the new node that we wanna insert
inside it

we initialized cur = list and prev = NULL; the classic 2 pointer technique
then inside theres a while loop that checks if the curent value <= new node value
as long is its true move the prev pointer forward
and move the cur poitner forward

otherwise
the prev's 'cdr' becomes the new node
and the new node's 'cdr' become cur

then it returns the list

lets try smalexample in racket for intuition
if we have list '(1 2 3) and new node is '(4)

the while checks if 1 <= 4 -> true
move prev to 1, move cur to '(2 3)
next check if 2 <= 4
keep repeating until the while breaks since 4 s bigger than all if the list

at the point prev is the last item which is 3, and prev->next is nulll
prev->next = new_node 3 points to 4
new_node->next = cur; - 4 points to null, ocmpleting the list

there is no case when the list itself is empty
or when you want to insert to the front (first is < then the rest of the list)

*/

struct node {int value; struct node *next;};
struct node *first = NULL;

struct node *find_last(struct node *list, int n){

    struct node *p, *last_match = NULL;

    for(p = list; p != NULL;  p = p->next){
        if(p->value == n){
            last_match = p;
        }
    }

    return last_match;
}


int main(void){


    return 0;
}
