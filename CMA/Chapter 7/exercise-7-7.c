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

7.6
for each folowing char escapes
give equivalent octal escape
assume that the character set is acii
yuo may wish to consult appendix E
which lists numerical code for ascii chars

a.\b
b.\n
c.\r
d.\t

a. we know b ascii is 98 int
backspace = 8
8:8=1rem0
1:8=0rem1
therefore \010

b. \n = 10 in int
10:8 = 1rem2
1:8 = 0rem1
therefore \012

c. r = 13
13:8 = 1rem5
1:8 = 0rem1
therefore \015

d. t = 9
9:8 = 1rem1
1:8 = 0rem1
therefore \011

*/


#include <stdio.h>

int main(void) {


    int n = 't';

    printf("%d", n);

    return 0;
}
