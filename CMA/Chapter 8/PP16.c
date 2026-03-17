/*
Write a program that tests whether two words are anagrams (permutations of the same let
ters):
Enter first word: smartest
Enter second word: mattress
The words are anagrams.
Enter first word: dumbest
Enter second word: stumble
The words are not anagrams.
Write a loop that reads the first word, character by character, using an array of 26 integers to
keep track of how many times each letter has been seen. (For example, after the word smart
est has been read, the array should contain the values 1 0 0 0 1 0 000 00 0 I 000 0 I 2 20
0 0 000. reflecting the fact that smartest contains one a.one e, one m, one /•, two < > ’s and
two rs.) Use another loop to read the second word, except this timedecrementing the corre
sponding array element as each letter is read. Both loops should ignore any characters that
aren’t letters, and both should treat upper-case letters in the same way as lower-case letters.
After the second word has been read, use a third loop to check whether all the elements in
the array are zero. If so. the words are anagrams. Hint: You may wish to use functions from
<ctype.h>, such as isalpha and tolower.

*/


#include <stdio.h>
#include <ctype.h>

int main(void) {
    char alphabet[26] = {'A','B','C','D','E','F','G','H','I','J','K','L',
                        'M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z'};
    char arr0[26] = {0}, arr1[26] = {0}, arr2[26] = {0};
    char ch;
    int i=0,j,k,m, ch_idx, is_anagram=1;

    printf("Enter first word: ");
    //put in arr0 to track the count
    while((ch = getchar()) != '\n'){

        // ignore all except for letteres
        if(isalpha(ch)){
            ch = tolower(ch);
            ch_idx = ch - 'a';
            arr0[ch_idx]++;
        }

    }

    //for quick test: print arr0
    for(j=0;j<26;j++){
        printf("%d", arr0[j]);
    }

    printf("Enter second word: ");
    //put in arr1 to track the count
    while((ch = getchar()) != '\n'){
        // ignore all except for letteres
        if(isalpha(ch)){
            ch = tolower(ch);
            ch_idx = ch - 'a';
            arr1[ch_idx]++;
        }
    }

    //for quick test: print arr0
    for(k=0;k<26;k++){
        printf("%d", arr1[k]);
    }

    //subtract both and check if its' all zeroes
    for(m=0;m<26;m++){
        //check each
        arr2[m] = arr0[m] - arr1[m];
        if(arr2[m] != 0){
            printf("The words are not anagrams");
            is_anagram = 0;
            break;
        }

    }

    if(is_anagram) printf("The words are anagrams.");


    return 0;
}
