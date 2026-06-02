#include <stdio.h>




/*
Practice Problem 2.27:
Fill in the following macro definitions to generate the double-precision values +1, 1,and0.
#define POS_INFINITY
#define NEG_INFINITY
#define NEG_ZERO
#endif
You cannot use any include files (such as math.h), but you can make use of the fact that the largest
finite number that can be represented with double precision is around 1:8 10^308.

answer:
ok so we know positive infinity has like all expo bits to 1
negative infinite not sure, maybe just flip the sign bit to 1
and negative zero just flip the sign bit to 1 so

#define POS_INFINITY 1.8e308 * 10.00
#define NEG_INFINITY -1.8e308 * 10.00
#define NEG_ZERO -0.00

*/

#define POS_INFINITY
#define NEG_INFINITY
#define NEG_ZERO
#endif

int main(void){

    return 0;
}
