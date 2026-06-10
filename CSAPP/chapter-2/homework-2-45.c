#include <stdio.h>
#include <stdbool.h>

/*
Homework Problem 2.45

Assume we are running code on a 32-bit machine using two’s complement arithmetic for signed variables.
The variables are declared and initialized as follows:

int x = foo(); // Arbitrary value
int y = bar(); // Arbitrary value
unsigned ux = x;
unsigned uy = y;

For each of the following C expressions, either (1) argue that it is true (i.e., evaluates to 1) for all values of
x and y, or (2) give example values of x and y for which it is false (i.e., evaluates to 0.)

a. (x >= 0) || ((2*x) < 0)
b. (x & 7) != 7 || (x<<30 < 0)
c. (x*x)>=0
d.  x < 0 ||-x <= 0
e. x > 0 ||-x >= 0
f.  x*y == ux*uy
g.  ~x*y + uy*ux == -y

answer:
ok lets start one by one

a. (x >= 0) || ((2*x) < 0)
lhs
we know x an twos complement integer, so the value is somewhere between -2 and +2 bil
depending on the value, if x is zero or above then the statement will always be true

but if x is less than 0 need sto check the second cond  ((2*x) < 0)
here the 2*x if we use a small integer value since x will always be negative the statement wil alwys be true

but if x is like at the most minimum intenger (Tmin mabye -2 bilion) then multiplying i think would cause overflow?
so thats the same as shifting the bit left by 1 -> causing 33 bits -> then it would go to 0 < 0 which is false
so then it would become positiev -> the statement can be false

b. (x & 7) != 7 || (x<<30 < 0)
lets analyze this one by one
since we know x is an two complement integer, the value is somewhere between -2bil and +2 bill

LHS
(x & 7) != 7
so we have a bitwise operator here, 7 is smth like 0000 ... 0111
so this basically just masks the first 3 LSB

!= 7 -> then check if its not equal to 7, so if its equal to 7 it returns true
the first bits can be anything but
which means the only case thats false is that if its 7. if its 7 we need to check the RHS

(x<<30 < 0)

ok so here since we have x = 7 in 32bit we perform lshift by 30 place
it wuold overflow since we only have 32 slot
bit 0 -> 0 + 30 -> 30
bit 1 -> 1 + 30 -> 31
bit 2 -> 2 + 30 -> overflow/gets cut off

which means this would result in negative number which means its alwus true??


c. (x * x) >= 0
ok so lets focus on LHS frst, since x is int the value is from -2 to +2 bil

parity wise if x is negative it will alwys be positive
if its positive then it stays

but depending on the magnitude
if x is Tmin (-2 bil), we multiply it with another tmin
negative overflow -> true

if x is Tmax, we multiply again with tmax
tha would cause positive overflow -> becomes negative -> false

so something like x = 50.000 -> 50.000 x 50.000 = 2.5 million -> wraps around to be negative

d. x < 0 || -x <= 0
LHS
depending on x value here if x is negative it will be evaluated to true, doesn't need to eval the RHS

but if x is positive we need to eval the RHS

-x <= 0
so here we want to do a negation to the x
since x is positive technicaly negation will invert x to negative but lets check

basically negation in twos complement
1. flip all the bits (~x)
2. add 1

lets sthink of a conterexample case where its not -x <= 0
x = 1, lets simplify to 4bit
0001 -> 1110 -> 1111 -> becomes negative 1

negative 1 > 0 is false

e. x > 0 ||-x >= 0
x is pos -> LHS is true, whole statement is ture
x is zero/neg, lhs is false, needs to eval RHS

if x is zero then -0 >= 0 which is true

so negative
always land back to where its started so it will never be greater than 0

F. x*y == ux*uy
lhs
conterexample is where x/y is negative
in LHS since its two complement the result can be negative if its not overflowign
in rhs since the value is cast from negative to unisgned its giving a very big value instead
so they wont be equal

2 -> 0010
multiply by negative -> -2 -> 1110 -> convert to unsigned ->

g.  ~x*y + uy*ux == -y

-x-1 + x * y == -y

-1 * y == -y
-y == -y

threfore it will always be equal

~x = -x - x
ux * uy = x * x

answer:
*/

// PART A
unsigned sr1(unsigned x, int k){
    unsigned xsra = (int) x >> k;

    // arith shift
    // just pad with 0 ??

    return  ((1U << (31 - k)) << 1) - 1 & k;
}

//PART B
int sra (int x, int k){
    int xsr1 = (unsigned) x >> k;

    // find MSB
    // then pad it with that
}


int main(void){
    return 0;
}
