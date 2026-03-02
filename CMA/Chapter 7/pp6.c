#include <stdio.h>

/*
PP6

Write a program that prints the values of sizeof (int)
,sizeof (short),sizeof (long), sizeof (float), sizeof (double) and sizeof (long double).
*/


#include <stdio.h>
int main(void) {

    printf("Size of int is: %zu\n",sizeof(int));
    printf("Size of short is: %zu\n",sizeof(short));
    printf("Size of long is: %zu\n",sizeof(long));
    printf("Size of float is: %zu\n",sizeof(float));
    printf("Size of double is: %zu\n",sizeof(double));
    printf("Size of long double is: %zu\n",sizeof(long double));

    return 0;
}
