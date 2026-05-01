#include <stdio.h>
#include <string.h>
#include <ctype.h>

#define NUM_PLANETS 9

/*
Programming Project 6
Improve the planet .c program of Section 13.7 by having it ignore case when comparing
command-line arguments with strings in the planets array.

*/

// converts a string to a lowercase
void tolower_str(char *s){
    for(;*s!='\0';s++){
        *s = tolower(*s);
    }
}

int main(int argc, char *argv[])
{
    char *planets[] = {
        "mercury", "venus", "earth",
        "mars", "jupiter", "saturn",
        "uranus", "neptune", "pluto"
    };

    int i, j;

    for (i = 1; i < argc; i++) {
        //convert curr arg to lowercase
        tolower_str(argv[i]);

        for (j = 0; j < NUM_PLANETS; j++)
            if (strcmp(argv[i], planets[j]) == 0) {
                printf("%s is planet %d\n", argv[i], j + 1);
                break;
            }

        if (j == NUM_PLANETS)
            printf("%s is not a planet\n", argv[i]);
    }

    return 0;
}
