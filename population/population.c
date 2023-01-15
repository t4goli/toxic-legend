#include <cs50.h>
#include <stdio.h>

int main(void)
{
    // TODO: Prompt for start size
    int pop;
    do
    {
        pop = get_int("Start size: ");
    }
    while (pop > 9);

    // TODO: Prompt for end size
    int end;
    do
    {
        end = get_int("End size: ");
    }
    while (end < pop);

    // TODO: Calculate number of years until we reach threshold
    int y = 0;
    while (pop < end)
    {
        pop = pop + (pop / 3) - (pop / 4);
        y++;
    }

    // TODO: Print number of years
    printf("Years: %i\n", y);
}
