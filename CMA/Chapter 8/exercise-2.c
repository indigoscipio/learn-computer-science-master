#include <stdio.h>

/*

Exercise 1

The Q&A section shows how to use a letter as an array subscript. Describe how to use a
digit ( in character form) as a subscript.



*/


#include <stdio.h>
#include <stdbool.h>

#define N 5

int main(void) {
    int a[5];

    a['b'-'a'] = 1;
    printf("%d", a['b'-'a']);

    return 0;
}
