#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[])
{
    if (argc != 2)
    {
        printf("Usage: ./recover IMAGE\n");
        return 2;
    }
    char *infile = argv[1];

    FILE *f = fopen(f, "r");
    if (f == NULL)
    {
        printf("Could not open %s.\n", f);
        return 4;
    }
}