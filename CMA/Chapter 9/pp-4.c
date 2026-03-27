/*
PP16
Modify Programming Project 16 from Chapter 8 so that it includes the following functions:
void read_word (int counts [26] ) ;
bool equal_array (int countsl [26] , int counts2 [26] ) ;
main will call read _word twice, once for each of the two w'ords entered by the user. As it
reads a word, read word will use the letters in the word to update the counts array, as
described in the original project , (main will declare two arrays, one for each word. These
arrays are used to track how many times each letter occurs in the words.) main will then
call equal _array, passing it the two arrays, equalarray will return true if the ele
ments in the two arrays are identical (indicating that the words are anagrams) and false
otherwise

*/

#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <ctype.h>
#define N 26

void read_word(int counts[26]){
        char ch;
        int ch_idx;

        while((ch = getchar()) != '\n'){

        if(isalpha(ch)){
            ch = tolower(ch);
            ch_idx = ch - 'a';
            counts[ch_idx]++;
        }
    }

}

bool equal_array(int counts1[26], int counts2[26]){
    for(int j=0;j<26;j++){
        if(counts1[j] != counts2[j]){
            return false;
        }
    }
    return true;
}

int main(void) {
    int a1[N]={0};
    int a2[N]={0};

    printf("Enter first word: ");
    read_word(a1);
    printf("Enter second word: ");
    read_word(a2);

    if(equal_array(a1, a2)){
        printf("It's an anagram.");
    }else{
        printf("Not an anagram :(");
    }


    return 0;
}
