// main.c
#include <stdio.h>
#include <stdbool.h>
#include  <stdlib.h>

/*
Exercise 19
Write a function that, when given a string as its argument, searches the following array of
structures fora matching command name, then calls the function associated with that name.

struct {
char *cmd_name;
void (*cmd_pointer)(void);
} file
{{"new",
_cmd[] =
{"open",
{"close",
new_cmd},
open cmd},
{"close all", clcse_all_cmd},
{"save",
{"save as",
{"save all",
{"print",
{"exit",
} ;
clcsecmd},
save_cmd},
save_as_cmd},
saveallcmd},
print_cmd},
exit
_cmd}


*/

void func(char *str){
    //loop through file cmd's command name and do strcomp
    // if it matches the command run the function
    // otherwise keep searching
    int i;
    for(i=0;i< (sizeof(file_cmd) / sizeof(file_cmd[0])) ; i++){
        if(strcmp(file_cmd[i].cmd_name, str) == 0){
            //run it
            file_cmd[i].cmd_pointer();
        }
    }

    // does not found
    return;
}

int compare_parts(const void *p, const void *q){
    const struct part *p1 = p;
    const struct part *q1 = q;

    if(p1->number < q1->number){
        return 1;
    }else if(p1->number == q1->number){
        return 0;
    }else{
        return -1;
    }
}

int main(void){
    printf("The sum is: %d", sum(square, 1, 10));

    return 0;
}

/*
struct node {int value; struct node *next;};
struct node *first = NULL;

*/
