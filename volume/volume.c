// Modifies the volume of an audio file

#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>

// Number of bytes in .wav header
const int HEADER_SIZE = 44;

int main(int argc, char *argv[])
{
    // Check command-line arguments
    if (argc != 4)
    {
        printf("Usage: ./volume input.wav output.wav factor\n");
        return 1;
    }

    // Open files and determine scaling factor
    FILE *input = fopen(argv[1], "r");
    if (input == NULL)
    {
        printf("Could not open file.\n");
        return 1;
    }

    FILE *output = fopen(argv[2], "w");
    if (output == NULL)
    {
        printf("Could not open file.\n");
        return 1;
    }

    float factor = atof(argv[3]);

    // TODO: Copy header from input file to output file
    uint8_t header[HEADER_SIZE];
    fread(&header[0], 2, 44, input);
    fwrite(&header[0], 2, 44, output);
    // TODO: Read samples from input file and write updated data to output file
    int16_t buffer;
    int s = 1;
    do
    {
        s = fread(&buffer, 2, 1, input);
        if (s != 0)
        {
            fwrite(&buffer, factor, 1, output);
        }
    }
    while (s != 0);
    // Close files
    fclose(input);
    fclose(output);
}
