#include <stdio.h>

/*
by default C uses signed integer

float = only 6 digits
double = upto 15 digits decimal

ASCII are just numbers
char a
a = 'a'

TYPES
Integral types
char
signed int
unsigned int

Floating
float
double

Type conversion
c always promote the lower one
c force signed -> unsigned conversion

Ranking System
ll int
l int
int
short int
char
bool

7.14
Use typedef tocreate types named Int8.Int16.and Int32. Define the types so that
they represent 8-bit. 16-bit. and 32-bit integers on your machine.

answer:


*/


#include <stdio.h>

int main(void) {
    typedef char Int8;
    typedef short Int16;
    typedef int Int32;



    printf("%d", sizeof(Int8)); //prits 1
    printf("%d", sizeof(Int16)); //prints 2
    printf("%d", sizeof(Int32)); //prints 4

    return 0;
}
