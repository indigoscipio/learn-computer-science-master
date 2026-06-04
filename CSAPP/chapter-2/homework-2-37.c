#include <stdio.h>
#include <stdbool.h>

/*
Homework problem 2.37

Youjust started working for a company that is implementing a set of procedures to operate on a data structure
where four signed bytes are packed into a 32-bit unsigned. Bytes within the word are numbered from 0
(least significant) to 3 (most significant). You have been assigned the task of implementing a function for a
machine using two's complement arithmetic and arithmetic right shifts with the following prototype:

//Declaration of data type where 4 bytes are packed into an unsigned
typedef unsigned packed_t;
//Extract byte from word. Return as signed integer
int xbyte(packed_t word, int bytenum);
Your predecessor (who was fired for his incompetence) wrote the following code

//Failed attempt at xbyte
int xbyte(packed_t word, int bytenum){
    return (word >> (bytenum << 3)) & 0xFF;
}

a. what is wrong with this code?

b. give correct implementation of the function that uses only left and right shifts
along with one subtraction

answer:
ok so the data typedef packed t holds 4 byte into unsigned
so smth like 00 00 00 00 and packed_t is unsigned

we have a extract byte xbyte that takes
the packed_t word and bytnum which is an integer
this function extract the designated byte (0 - 3 im assuming?)
and extend it to be 32 bit integer

and the incorrect code lets analyze this
(word >> (bytenum << 3) ) & 0xFF

(bytenum << 3) -> shifts byte num 3 bits to the left
since bytenum is an integer (1 - 4) it holds like 32 bits so shifting 3 bits to the left
would multiply it by 2^3? not sure

next we have
word >>
here we perform another right shfiting oeprateion with whatever is the result from previous one

and finally we mask the bit with bitwise &
depending on the machine 0xFF thats 1111....

so im not quite sure whats wrong with the code here
maybe my analysis is wrong

word << ((3 - bytenum) << 3) >> 24


*/


int main(void){
    return 0;
}
