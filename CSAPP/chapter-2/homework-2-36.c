#include <stdio.h>
#include <stdbool.h>

/*
Homework problem 2.36

Youaregiventhetaskofwritingaprocedureint_size_is_32()thatyields1whenrunonamachine
forwhichanintis32bits,andyields0otherwise.Hereisafirstattempt:

1 //Thefollowingcodedoesnotrun properlyonsome machines
2 intbad_int_size_is_32()
3 {
4 //Setmostsignificantbit(msb)of 32-bitmachine
5 int set_msb= 1<< 31;
6 //Shiftpastmsbof 32-bitword
7 int beyond_msb=1 <<32;
8
9  //set_msbis nonzerowhenwordsize >=32
10 //beyond_msbiszerowhenwordsize <=32
11 returnset_msb&&!beyond_msb;
12 }

Whencompiled andrunona32-bit SUNSPARC,however, this procedure returns 0. Thefollowing compiler
message gives us an indication of the problem:
warning: left shift count >= width of type

a. In what way does our code fail to comply with the C standard?
b. modify the code to run properly on any machine for which ints are at least 32 bits
c. modify the code to run properly on any machine for which ints are at least 16 bits

answer:
ok lets analyze
set msb -> 1 << 31 so if we have 0000 .... 0001 , shift it 31 to the left it becomes 1000 .... 0000
maybe because we hard code 31 here? but the qquestion says the machine is 32 bit so i guess this is fine.

beyond msb -> 1 << 32 -> this basically just sets all bit to 0, but why even use bit shifting?
since we only have 32 word size

since modulo 32
it shifts by zero so it becomes zero

then at finally we do a double boolean and check
then gives the warning left shift count >= width of type
so i thin this has something to do with the fixed hardcoded here like << 32

since it becomes zero the beyond_msb alawys evaluates to true
and !beyond_msb always evaluate to false
since set_msb is true (nonzero) and !beyond_msdb is always false
therefore true && false evaluates to false.


*/

// PART B
int_size_is_32(){
    int set_msb = 1 << 31;

    int beyond_msb = (1 << 31) << 1; //in 32bit should evaluate to 0 (false)

    return set_msb && !beyond_msb;
}

// PART C
int_size_is_16(){
    int set_msb = 1 << 15;

    int beyond_msb = (1 << 15) << 1; //in 16bit should evaluate to 0 (false)

    return set_msb && !beyond_msb;
}

bool int_shifts_arithmetic(){

    return (~0 >> 1) == ~0;

}

bool unsigned_shifts_are_arithmetic(){
    return (~0U >> 1) == ~0U;
}


int main(void){
    return 0;
}
