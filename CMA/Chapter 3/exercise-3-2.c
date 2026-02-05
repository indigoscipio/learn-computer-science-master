#include <stdio.h>
/*
2. Writecalls ofprintf that display a float variable x in the following formats.
( a) Exponential notation: left-justified in a field of size8: one digit after the decimal point.
( b) Exponential notation; right-justified in a field of size 10: six digits after the decimal
point.
(c) Fixed decimal notation: left-justified in a field of size 8: three digits after the decimal
point.
(d) Fixed decimal notation; right-justified in a field of size 6: no digits after the decimal
point.
*/

int main(void){
    float x;

    printf ("%-8.1e", x);
    printf("%10.6e" , x);
    printf("%-8.3f", x);
    printf("%6.0f", x);

    return 0;
}
