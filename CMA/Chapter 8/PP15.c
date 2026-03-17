/*
Oneof the oldest known encryption techniques is the Caesar cipher, attributed to Julius Cae
sar. It involves replacing each letter in a message with another letter that is a fixed number of
Programming Projects
181
positions later in the alphabet. (If the replacement would go past the letter Z. the cipher
"wraps around" to the beginning of the alphabet. For example, if each letter is replaced by
the letter two positions after it. then Y would be replaced by A.and Z would be replaced by
B. ) Write a program that encrypts a message using a Caesar cipher. The user will enter the
message to be encrypted and the shift amount (the number of positions by which letters
should be shifted):
Enter message to be encrypted: Go ahead, make my day.
Enter shift amount (1-25): 3
Encrypted message: Jr dkhdg, pdnh pb gdb.
Notice that the program can decrypt a message if the userenters 26 minus the original key:
Enter message to be encrypted: Jr dkhdg, pdnh pb gdb.
Enter shift amount (1-25): 23
Encrypted message: Go ahead, make my day.
You mayassume that the message does not exceed 80 characters.Characters other than let
ters should be left unchanged. Lower-case letters remain lower-case when encrypted, and
upper-case letters remain upper-case. Hint: To handle the wrap-around problem, use the
expression ((ch- 'A') + n) % 26 + 'A' to calculate the encrypted version of an upper
case letter, where ch stores the letter and n stores the shift amount. (You' ll need a similar
16.
17.
expression for lower-case letters.)
*/


#include <stdio.h>
#include <ctype.h>

// lets just do the encryption version for simplicify
int main(void) {
    char message[80] = {0}, encrypted_message[80] = {0};
    char ch, new_upcase, new_lowcase;
    int i=0,j,k, shift_amt, new_index;

    printf("Enter message to be encrypted: ");

    //store input in msg array
    while((ch=getchar())!='\n'){
        message[i] = ch;
        i++;
    }

    printf("Enter shift amount: ");
    scanf("%d", &shift_amt);

    //encryption
    for(j=0;j<i;j++){
        //uppercase
        if(isupper(message[j])){
            new_upcase = ((message[j] - 'A') + shift_amt) % 26 + 'A';
            encrypted_message[j] = new_upcase;
        }else if(islower(message[j])){
            //lowcase
            new_lowcase = ((message[j] - 'a') + shift_amt) % 26 + 'a';
            encrypted_message[j] = new_lowcase;
        }else{
            // keep as it is
            encrypted_message[j] = message[j];
        }
    }

    //print
    for(k=0;k<i;k++){
        printf("%c",encrypted_message[k]);
    }

    return 0;
}
