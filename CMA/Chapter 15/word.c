/*
Chapter 15

GROUP PROGRAM INTO MULTIPLE FILES
- compiled seperately
- reusable function

HEADER FILES
#include directive - just 'bring' other files into your current working file.
#include <library>
#include "filename/path"

SHARING MACRO DEFINITIONS
bool file -> boolean definitions
file 1 -> import boolean
file 2 -> import boolean

PROTOTYPE SHARING
if calling another function from different file
make sure to include directive from that file.

VARIABLE SHARING
int i does 2 things:
declare var -> i as a type of integer
define var -> allocate memory

extern seperate those

*/


/*
Programming Projects 1
The justify program of Section 15.3 justifies lines by inserting extra spaces between
words. The way the write
_linefunction currently works,
the words closer to the end of
a line tend to have slightly wider gaps between them than the words at the beginning. (For
example, the words closer to the end might have three spaces between them, while the
words closer to the beginning might be separated by only two spaces. ) Improve the program
by having write _line alternate between putting the larger gaps at the end of the line and
pulling them at the beginning of the line.


*/

#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <ctype.h>
#include <string.h>

#include <string.h>
#include "line.h"
#include "word.h"

#define MAX_WORD_LEN 20

#include <stdio.h>
#include "word.h"

int read_char(void)
{
    int ch = getchar();

    if (ch == '\n' || ch == '\t')
        return ' ';

    return ch;
}

void read_word(char *word, int len)
{
    int ch, pos = 0;

    while ((ch = read_char()) == ' ')
        ;

    while (ch != ' ' && ch != EOF) {
        if (pos < len)
            word[pos++] = ch;

        ch = read_char();
    }

    word[pos] = '\0';
}
