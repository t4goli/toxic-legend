#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>

int main(int argc, char *argv[])
{
    if (argc != 2)
    {
        printf("Usage: ./recover IMAGE\n");
        return 2;
    }
    char *f = argv[1];

    FILE *inptr = fopen(f, "r");
    if (f == NULL)
    {
        printf("Could not open %s.\n", f);
        return 4;
    }

    int z = 1;
    typedef uint8_t  BYTE;
    BYTE buffer[512];
    while(fread(buffer, 1, 512, inptr) == 512)
    {
        if (buffer[0] == 0xff && buffer[1] == 0xd8 && buffer[2] == 0xff && (buffer[3] & 0xf0) == 0xe0)
        {
            if (z == 1)
            {
                char *fn = malloc(4);
                sprintf(fn, "%03i.jpg", z);
                FILE *img = fopen(fn, "w");
                fwrite(buffer, 1, 512, fn);
            }
            else
            {
                z += 1;
                fclose(fn);
                free(fn);
                char *fn = malloc(4);
                sprintf(fn, "%03i.jpg", z);
                FILE *img = fopen(fn, "w");
                fwrite(buffer, 1, 512, fn);
            }
        }
        else
        {
            if (z > 0)
            {
                sprintf(fn, "%03i.jpg", z);
                fwrite(buffer, 1, 512, fn);
            }
        }
    }
    fclose(fn);
    free(fn);
    fclose(inptr);

}