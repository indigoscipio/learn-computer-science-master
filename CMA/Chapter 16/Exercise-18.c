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
Exercise 18
a) Each square of a chessboard can hold one piece—a pawn, knight, bishop, rook, queen,
or king—or it may be empty. Each piece is either black or white. Define two enumerated
types: Piece, which has seven possible values (one of which is “empty"), and Color,
which has two.


b) Using the types from part (a),
define a structure type named Square that can store both
the type of a piece and its color

c) Using the Squax'
e type from part (b). declare an 8 x 8 array named board that can
store the entire contents of a chessboard.

d ) Add an initializer to the declaration in part (c) so that board's initial value corresponds
to the usual arrangement of pieces at the start of a chess game. A square that's not occupied
by a piece should havean “empty"piece value and the color black.

answer:
*/


//PART A
enum Piece {Pawn, Knight, Bishop, Rook, Queen, King, Empty};
enum Color {Black, White};

// PART B
struct Square {
    enum Piece type;
    enum Color color;
};


// PART C & D
// yeah part d is wayy to fuckin long
#define N 8
struct Square board[N][N] = {[0][0] = {Rook, White};
                             [0][1] = {Knight, White};
                             [2][2] = {Empty, Black};
};

int main(void){

    printf("%d", abs(-8));

    return 0;
}
