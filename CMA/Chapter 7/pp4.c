#include <stdio.h>

/*
PP3

Write a program that translates an alphabetic phone number into numeric form:
Enter phone number: CALLATT
2255288
( In case you don't have a telephone nearby,
here are the letters on the keys: 2=ABC. 3=DEF.
4
=GHI. 5=JKL, 6=MNO.7=PRS. 8=TUV.9=WXY.) If the original phone number contains
nonalphabctic characters (digits or punctuation, for example), leave them unchanged:
1
Enter phone number: 1-800-COL-L.ECT-800-265-5328
You may assume that any letters entered by the user are upper case.

*/


#include <stdio.h>

int main(void) {
    char ch;

    printf("Enter a phone numher: \n");

    do{
        //for each character, translate to corresponding number
        ch = getchar();
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
    }while(ch != '\n');

    return 0;
}
