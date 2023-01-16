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
    candidate[0].name = "hi";
    if (strcmp(name, candidate[0].name))
    {
        printf("Same");
    }
}
