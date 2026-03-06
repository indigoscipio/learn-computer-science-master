#include <stdio.h>

/*

Exercise 3

Write a declaration of an array named weekend containing seven bool values. Include an
initializer that makes the first and last values true; all other values should be false.

*/


#include <stdio.h>
#include <stdbool.h>

#define N 5

int main(void) {
    //bool weekend[7] = {true, false, false, false, false, false, true};
    // alternative way
    bool weekend[7] = {[0]=true,[6]=true};


    return 0;
}
