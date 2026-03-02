#include <stdio.h>

/*
PP5

IntheSCRABBLECrosswordGame, players form words using small tiles, each containing
a letter and a face value. The face value varies from one letter to another, based on the let
ter’s rarity. ( Here are the face values: I: AEILNORSTU.2: DC
. , 3: BCMP.4: FHVWY.5: K.
X: JX. 10: QZ.) Write a program that computes the value of a word by summing the values
of its letters:
Enter a word: pitfall
Scrabble value: 12
Your program should allow any mixture of lower-case and upper-case letters in the word.
hint: use the toupper library function
*/


#include <stdio.h>
#include <ctype.h>

int main(void) {
    char ch;

    printf("Enter a phone numher: \n");
    ch = getchar();

    while(ch != '\n'){
        if(ch == 'A' || ch == 'B' || ch == 'C'){
            printf("%d", 2);
        }else if (ch == 'D' || ch == 'E' || ch == 'F'){
            printf("%d", 3);
        }else if (ch == 'G' || ch == 'H' || ch == 'I'){
            printf("%d", 4);
        }else if (ch == 'J' || ch == 'K' || ch == 'L'){
            printf("%d", 5);
        }else if (ch == 'M' || ch == 'N' || ch == 'O'){
            printf("%d", 6);
        }else if (ch == 'P' || ch == 'R' || ch == 'S'){
            printf("%d", 7);
        }else if (ch == 'T' || ch == 'U' || ch == 'V'){
            printf("%d", 8);
        }else if (ch == 'W' || ch == 'X' || ch == 'Y'){
            printf("%d", 9);
        }
        else{
            printf("%c", ch);
        }
        ch = getchar();
    }


    return 0;
}
