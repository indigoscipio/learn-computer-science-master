#ifndef LINE H
#define LINE H

/*
clear line: clears the current line
*/
void clear_line(void);

/*
add_word: adds word to the end of current line
if this is not the first word on the line, puts one space before word.
*/
void add_word(const char *word);


/*
space remaining: returns no of chars left in current lnie
*/
int space_remaining(void);

/*
write_line: writes current line with justification
*/
void write_line(void);

/*
flush line: writes the current line without justfication
if the line is empty, does nothing
*/
void flush_line(void);

#endif
