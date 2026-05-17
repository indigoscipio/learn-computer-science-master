// main.c
#include <stdio.h>
#include <stdbool.h>

/*
STRUCTURE
like (define-struct name (x y z)) in racket.

DESIGNATED INITIALIZER
.something{property = x, property1 = y};
+ it's order independence, doesn't care about order
+ smart default, if the property is not defined it will be ste to default (0)
+ unitialized are set o 0

STRUCT OEPRATORS
= -> assign (shallow copy)
Yes you can copy structs but not array why?
coz struct has a 'fixed' size

STRUCT VARIABLE VS STRUCT TAG
the recipe
struct part {...} -> don't build anything yet
struct part part1 -> ok build it now/build on the 'go'

COMPOUND LITERAL
print_part((struct part) {528, "Disk drive", 10})
- its temporary, "anonymous" and for one-off tasks.
- can also include designators
*/


/*
Exercise 22
Let chess piecesbe the followingenumeration
answer:

enum chess_pieces {KING, QUEEN, ROOK, BISHOP, KNIGHT, PAWN};

a.Write a declaration (including an initializer) for a constant array of integers named
piece_value that stores the numbers 200.9.5.3.3.and I.representing the value ofeach
chess piece, from king to pawn. (The king's value is actually infinite,since "capturing" the
king (checkmate) ends the game,but some chess-playing software assigns the king a large
value such as 200.)

b) (C99) Repeat part (a), but use a designated initializer to initialize the array. Use the enu
meration constants in chess_pieces as subscripts in the designators.{Hint: See the last
question in Q&A for an example.)


*/

enum chess_pieces {KING, QUEEN, ROOK, BISHOP, KNIGHT, PAWN};

// PART A
const int piece_values[6] = {200,9,5,3,3,1};

// PART B
const int piece_values[6] = {[KING]=200,[QUEEN]=9,[ROOK]=5,[BISHOP]=3,[KNIGHT]=3,[PAWN]=1};



int main(void){

    printf("%d", abs(-8));

    return 0;
}
