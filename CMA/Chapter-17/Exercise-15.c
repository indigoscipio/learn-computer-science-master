// main.c
#include <stdio.h>
#include <stdbool.h>
#include  <stdlib.h>

/*
Exercise 15

Show theoutput of the following program and explain what it does.

#include <stdio.h>

int f1(int (*f)(int)); ##ok so f1 is a function that takes a pointer to function (int -> int)
int f2(int i); ##another function that takes int

int main(void){
    printf("Answer: %d\n", f1(f2));
    return 0;
}

int f1(int (*f)(int)){
    int n = 0;
    while((*f)(n)) n++;
    return n;
}

inf f2(int i){
    return i * i + 1 - 12;
}

answer:

so in the main we just print ai integer
with f1(f2) ->

we know f1 is a function that takes a function
lets go inside f2 first or sholdi analyze f1 first?
in racket/scheme its the arg thats evaluated first but im not sure lets do f2

f2
takes int i and reutrn i*i+i-12
in this case what is i?


actually lets look at f1 first
we initialied n = 0
then while loop it runs f2 with arg n = 0

so lets go to f2 iwth i = 0
1st iter
0 * 0 + 0 - 12
returns -12 -> still truthy rihgt? continue

2nd iter
i = 1
1 * 1 + 1 - 12
-11

3rd iter
i = 2
2 * 2 + 2 - 12
4 + 2 - 12
6 - 12
-6

4th iter
i = 3
3 * 3 + 3 - 12
12 - 12
0 -> stop here at i = 3

back to f1
we return n = 3, f1 halts and back up to the main

it prints answer: 3





*/


struct node {int value; struct node *next;};
struct node *first = NULL;

void delete_from_list(struct node **list, int n){
    struct node *cur, *prev;

    for(cur = *list, prev = NULL; cur != NULL && cur->value != n; prev = cur, cur = cur->next){
        ;
    }

    if(cur == NULL){
        return;
    }if (prev == NULL){
        *list = *(list).next;
    }else{
        prev->next = curr->next;
    }
    free(cur);
}

int main(void){


    return 0;
}
