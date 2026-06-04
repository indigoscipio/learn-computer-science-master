#include <stdio.h>
#include <stdbool.h>

/*
Homework problem 2.35
Writeaprocedureint_shifts_are_arithmetic()thatyields1whenrunamachinethatusesarith
meticrightshiftsforint'sand0otherwise.Yourcodeshouldworkonamachinewithanywordsize.Test
yourcodeonseveralmachines.Writeandtestaprocedureunsigned_shifts_are_arithmetic()
thatdeterminestheformofshiftsusedforunsignedint's.
answer:
lets keep this simple
so we know
logical >> pad with zeores
arith >> pad with whatever the MSB is

*/

bool int_shifts_arithmetic(){

    return (~0 >> 1) == ~0;

}

bool unsigned_shifts_are_arithmetic(){
    return (~0U >> 1) == ~0U;
}


int main(void){
    return 0;
}
