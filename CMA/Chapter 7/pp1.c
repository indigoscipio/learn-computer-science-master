#include <stdio.h>

/*
PP1
Thesquare2.c program of Section 6.3 will fail (usually by printing strange answers) if
i * iexceeds the maximum int value. Run the program and determine the smallest value
of n that causes failure. Try changing the type of i to short and running the program
again. (Don't forget to update the conversion specifications in the call of printf!)Then
try long.From these experiments, what can you conclude about the number of bits used to
store integer types on your machine?

answer:
since int i = around 2.1 billion signed
it wil fail when n reach sqrt 2.1 billion which is around ~45k or ~46k
causes overflow to negative number

changing int i to short i
it overflows at n = 181 (32761 -> change to -32412)
which makes sence since short only holds up to 32k signed

changing int i to long i
im not gonna try this on my machine but im guessing
it will overflow at 9 quintillion unsigned so its square root = n = around 3 billion

conclusion: number of bit matter when represnting how much value you want to show/hold

*/


#include <stdio.h>

int main(void) {
    long i;
    int n;

    printf("This program prints a table of squares.\n");
    printf("Enter number of entries in table: ");

    scanf("%d", &n);
    for (i = 1; i <= n; i++)
        printf("%10ld%10ld\n", i, i * i);

    return 0;
}
