#include <stdio.h>

/*
Exercise 11
Write a declaration for an 8 x 8 char array named chess_ board. Include an initializer
that puts the followingdata into the array (one character per array element):

r n b q k b n r
P P P P P P P P
  .   .   .   .
.   .   .   .
  .   .   .   .
.   .   .   .
P P P P P P P P
R N B Q K B N R

*/


#include <stdio.h>
#include <stdbool.h>
#define N 8

int main(void) {
    char chess_board[N][N] = {
                            {'r','n','b','q','k','b','n','r'},
                            {'p','p','p','p','p','p','p','p'},
                            {' ','.',' ','.',' ','.',' ','.'},
                            {'.',' ','.',' ','.',' ','.',' '},
                            {' ','.',' ','.',' ','.',' ','.'},
                            {'.',' ','.',' ','.',' ','.',' '},
                            {'P','P','P','P','P','P','P','P'},
                            {'R','N','B','Q','K','B','N','R'}};


    return 0;
}
