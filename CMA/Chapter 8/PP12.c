/*
PP12
Modify Programming Project 5 from Chapter 7 so that the SCRABBLE values of the letters
are stored in an array.

Thearray will have 26elements,corresponding to the 26 letters of the
alphabet. Forexample,element 0of the array will store I (because the SCRABBLE value of
the letter A is 1 ) .element 1 of the array will store 3 (because the SCRABBLE value of the
letter B is 3) . and so forth. As each character of the input word is read, the program will use
the array todetermine the SCRABBLE value of that character. Use an array initializer to set
upthe array.
*/


#include <stdio.h>
#include <ctype.h>

int main(void) {
    char ch;
   int scrabble_scores[26] = {
    1, 3, 3, 2, 1, 4, 2, 4, 1, 8, 5, 1,
    3, 1, 1, 3, 10, 1, 1, 1, 1, 4, 4, 8, 4, 10};
    int score = 0, ch_idx = 0;

    printf("Enter a word to compute scrabble score: \n");

    do{
        ch = getchar();
        ch = toupper(ch);

        if (isalpha(ch)) {
            ch_idx = ch - 'A';
            score += scrabble_scores[ch_idx];
    }
    }while(ch != '\n');

    printf("Scrabble value is: %d\n", score);

    return 0;
}
