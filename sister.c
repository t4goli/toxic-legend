#include <cs50.h>
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

typedef struct
{
    string name;
    int votes;
}
candidate;
candidate candidates[1];

int candidate_count;
int main(void)
{
    string name = "hi";
    string s = "hi";
    candidates[0].name = "hi";
    candidates[0].votes = 0;
    if (strcmp(name, s))
    {
        printf("Same");
    }
    else
    {
        printf("Not");
    }
}
