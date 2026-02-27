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

7.8
like exercise 7.7 but
IN HEXADECIMAL VERSION

a.\b
b.\n
c.\r
d.\t

a. we know b ascii is 98 int
backspace = 8
8 : 16 = 0rem8
threfore \x08

b. \n = 10 in int
10 : 16 = 0rem10
therefore \x0a

c. r = 13
13 : 16 = 0rem13
therefore \x0d


d. t = 9
9 : 16 = 0rem9
therefore \x09

*/


#include <stdio.h>

int main(void) {


    int n = 't';

    printf("%d", n);

    return 0;
}
