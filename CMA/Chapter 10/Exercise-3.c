/*
Exercise 3
Suppose that aprogram hasonly one function (main). How many different variables named
i could this program contain?

answer:
lets see

we can declare i in global var
then we can declare it inside main itself
if we have an if block we can also declare i
if we have a naked block inside main we can also declare it
but then we can create a block inside a block inside a block which is pointless but
basically unlimited way then?

*/

#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <ctype.h>

//prototypes
void g(void){
    int d;
    {
        int e;
        printf("10");
    }
}


int main(void) {

    g();
    return 0;
}
