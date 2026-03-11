#include <stdio.h>

/*
PP6
The prototypical Internet newbie is a fellow named BIFF, who has a unique way of writing
messages. Here's a typical BIFFcommunique:

H3Y DUD3, C 15 R1LLY COOL!!!!!!!!!!!
Write a “BIFF filter" that reads a message entered by the user and translates it into B 1FF
speak;

Enter message: Hey dude , C is rilly cool
In BIFF-speak: H3Y DUD3, C 15 RILLY COOL!!!!!!!!!!

Your program should convert the message to upper-case letters, substitute digits for certain
letters ( A —> 4, B —> 8, E —> 3, I -> 1, O -> 0, S —> 5).

and then append 10 or so exclamation marks.

Hint: Store the original message in an array of characters, then go back through the array,
translating and printing characters one by one.

*/


#include <stdio.h>
#include <stdbool.h>
#include <ctype.h>
#define N 100

int main(void) {
    int i=0, j;
    char ch, ch_array[N] = {0}, curr_char;

    printf("Enter your message: \n");

    // store each char in an array
    while((ch = getchar()) != '\n'){
        ch_array[i] = ch;
        i++;
    }

    for(j=0;j<i;j++){
        curr_char = toupper(ch_array[j]);
        switch(curr_char){
            case 'A':
                printf("4");
                break;
            case 'B':
                printf("8");
                break;
            case 'E':
                printf("3");
                break;
            case 'I':
                printf("1");
                break;
            case 'O':
                printf("0");
                break;
            case 'S':
                printf("5");
                break;
            default:
                printf("%c", curr_char);
        }
    }
    // append the exclamation marks at the end
    printf("!!!!!!!!!!");


    return 0;
}
