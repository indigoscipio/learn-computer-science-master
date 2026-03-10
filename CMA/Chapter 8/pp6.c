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

int main(void) {
    int arr_length = 0,i;
    char ch, curr_ch;

    printf("Enter your message: \n");

    // get the array length
    while(ch = getchar() != '\n'){
        arr_length++;
    }

    char chars[arr_length] = {0};

    for(i=0;i<arr_length;i++){
        curr_ch = toupper(ch);

        switch(){

        }
    }

    //scan the input
    //for each char store it in an array
    // run thruogh each array and do the logic check/translate

    return 0;
}
