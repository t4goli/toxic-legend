#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>

int main(int argc, char *argv[])
{
    if (argc != 2)
    {
        printf("Usage: ./recover IMAGE\n");
        return 1;
    }
    char *f = argv[1];

    FILE *inptr = fopen(f, "r");
    if (f == NULL)
    {
        printf("Could not open %s.\n", f);
        return 1;
    }

    int z = 0;
    FILE *img = NULL;
    int l = 0;
    typedef uint8_t  BYTE;
    BYTE buffer[512];
    char *fn = malloc(4);
    while(fread(buffer, sizeof(uint8_t), 512, inptr) == 512)
    {
        if (buffer[0] == 0xff && buffer[1] == 0xd8 && buffer[2] == 0xff && (buffer[3] & 0xf0) == 0xe0)
        {
            img = fopen(fn, "w");
            if (z == 0)
            {
                sprintf(fn, "%03i.jpg", z);
                fwrite(buffer, sizeof(uint8_t), 512, img);
                l = 1;
            }
            else
            {
                fclose(img);
                z += 1;
                sprintf(fn, "%03i.jpg", z);
                img = fopen(fn, "w");
                fwrite(buffer, sizeof(uint8_t), 512, img);
            }
        }
        else
        {
            if (l != 0)
            {
                sprintf(fn, "%03i.jpg", z);
                fwrite(buffer, sizeof(uint8_t), 512, img);
            }
        }
    }
    free(fn);
    fclose(inptr);

}