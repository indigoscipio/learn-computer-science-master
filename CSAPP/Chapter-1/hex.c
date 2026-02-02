#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[]) {
    // We start at i = 1 because argv[0] is the name of the program itself
    for (int i = 1; i < argc; i++) {
        // atoi converts the string argument to an integer
        int val = atoi(argv[i]);
        printf("%d = 0x%x\n", val, val);
    }
    return 0;
}
