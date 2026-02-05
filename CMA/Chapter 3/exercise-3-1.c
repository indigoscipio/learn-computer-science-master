#include <stdio.h>
/*
Exercise 3.1
Whai output do the following calls of printf produce?
(a) printf ("%6d,%4d", 86, 1040) ;
(b) printf ("%12.5e", 30.253) ;
(c) printf ("%. 4f ", 83.162) ;
(d) printf ("%-6.2g", .0000009979);


answer:
a.
1st -> 86
widh 6 total width so something like
so ••••86

2nd -> 1040
with 4 total width
so just 10400

so final result is
"••••86,1040"

b. the number is a float 30.253
the modifier
12 total width
5 decimal point
••30.2530e+1

c. 83.1620

d. left justified
6 total width
2 precision


*/

int main(void){

    printf ("%-6.2g", .0000009979);
    return 0;
}
