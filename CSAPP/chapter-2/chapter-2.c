#include <stdio.h>



// PROBLEM 2.8
int bis(int x, int m){
    //write expr in c that computes the effect of bit set
    // we can just use or here
    int result = x | m ;
    return result;
}

int bic(int x, int m){
    //write expr in c that computes the effect of bit clear
    int result = x & ~m;
    return result;
}

// PROBLEM 2.10
// write c expr that is equivalent to x == y. return 1 when x and y are equal and 0 otherwise

int is-equal(int x, int y){

}

int main(void){

    // PART A
    printf("%X\n", 0x98FDECBA | ~0xFF);

    // PART B
    // complement of least significant byte of x (BA)
    // all other bytes left unchanged
    printf("%X\n", 0x98FDECBA ^ 0xFF);

    // PART C
    // all but the lsbyte of x (00)
    // with the least significant byte set to 0
    printf("%X\n", 0x98FDECBA & ~0xFF);




    return 0;
}
