#include <stdio.h>

/*

PP13
Write a program that calculates the average word length for a sentence:
Enter a sentence: It was deja vu all over again.
Average word length: 3.4
For simplicity, your program should consider a punctuation mark to be part of the word to
which it is attached. Display the average word length to one decimal place
*/


#include <stdio.h>

int main(void) {
    char ch, prev_ch = ' ';
    int total_words = 0, total_letters = 0;

    printf("Enter a sentence: \n");


    ch = getchar();
    while(ch != '\n'){
        if(ch != ' '){
            total_letters++;
        }

        //a words starts if ch is not a space and prev ch was a space
        if(ch != ' ' && prev_ch == ' '){
            total_words++;
        }

        prev_ch = ch;
        ch = getchar();
    }


    printf("Total letters: %d", total_letters);
    printf("Total words: %d", total_words);
    printf("Average length is %.2f", (float)total_letters / total_words);


    return 0;
}
