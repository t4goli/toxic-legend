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

    typedef uint8_t BYTE;
    uint8_t buffer[];
    while(fread(buffer, 1, 512, f) == 512)
    {
        if (buffer[0] == 0xff && buffer[1] == 0xd8 && bugger[2] == 0xff && (buffer[3] & 0xf0) == 0xe0)
        {
            
        }
    }
}