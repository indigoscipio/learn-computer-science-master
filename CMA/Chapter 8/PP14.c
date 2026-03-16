/*
PP14

Write a program that reverses the words in a sentence:

Enter a sentence: you can cage a swallow can't you?
Reversal of sentence: you can't swallow a cage can you?

Hint: Use a loop to read the characters one by one and store them in a one-dimensional
chararray. Have the loop stop at a period, question mark,
or exclamation point ( the "termi
nating character"), which is saved in a separate char variable. Then use a second loop to
search backward through the array for the beginning of the hist word. Print the last word,
then search backward for the next- lo-last word.
*/


#include <stdio.h>
#include <ctype.h>

int main(void) {
    char ch_arr[50] = {0};
    char ch, terminating_char;
    int i=0,j,k, limit, start;

    printf("Enter a sentence: ");

    // store the chars in array
    while((ch = getchar()) != '\n'){

        //stop when it finds the terminating char
        if(ch == '.' || ch == '!' || ch == '?'){
            terminating_char = ch;
            break;
        }

        ch_arr[i] = ch;
        i++;
    }

    limit = i;
    //reverse traversal
    for(j=i;j>=0; j--){
        //encounter a space
        if(ch_arr[j] == ' '){

            // print each word, word starts at j+1
            for(k=j+1;k<limit;k++){
                printf("%c", ch_arr[k]);
            }
            printf(" ");
            limit = j;
        }else if(j==0){
            for(k=j;k<limit;k++){
                printf("%c",ch_arr[k]);
            }
        }

    }

    if(terminating_char){
        printf("%c", terminating_char);
    }

    printf("\n");
    printf("Reversal of sentence: ");


    return 0;
}
