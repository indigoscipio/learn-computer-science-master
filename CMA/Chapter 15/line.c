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

#include <stdio.h>
#include <string.h>
#include "line.h"

#define MAX_LINE_LEN 60

char line[MAX_LINE_LEN + 1];
int line_len = 0;
int num_words = 0;

void clear_line(void)
{
    line[0] = '\0';
    line_len = 0;
    num_words = 0;
}

void add_word(const char *word)
{
    if (num_words > 0) {
        line[line_len] = ' ';
        line[line_len + 1] = '\0';
        line_len++;
    }

    strcat(line, word);
    line_len += strlen(word);
    num_words++;
}

int space_remaining(void)
{
    return MAX_LINE_LEN - line_len;
}

void write_line(void)
{
    int extra_spaces, spaces_to_insert, i, j;

    extra_spaces = MAX_LINE_LEN - line_len;

    for (i = 0; i < line_len; i++) {
        if (line[i] != ' ')
            putchar(line[i]);
        else {
            spaces_to_insert = extra_spaces / (num_words - 1);

            for (j = 1; j <= spaces_to_insert + 1; j++)
                putchar(' ');

            extra_spaces -= spaces_to_insert;
            num_words--;
        }
    }

    putchar('\n');
}

void flush_line(void)
{
    if (line_len > 0)
        puts(line);
}
