#include <stdio.h>

/*

PP10
Write a program that counts the number of vowels (u. e. i.o. and u) in a sentence:
Enter a sentence: And that’s the way it is.
Your sentence contains 6 vowels

*/


#include <stdio.h>
#include <ctype.h>

int main(void) {
    int vowels = 0;
    char ch;

    printf("Enter a sentence: \n");

    do{
        ch = getchar();
        ch = toupper(ch);

        if(ch == 'A' || ch == 'I' || ch == 'U' || ch == 'E' ||ch == 'O' ){
            vowels+=1;
        }

    }while(ch != '\n');

    printf("Your sentence contains %d vowels.", vowels);

    return 0;
}
