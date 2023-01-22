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
    fread(&header, sizeof(unit8_t), HEADER_SIZE, argv[1]);
    fwrite(&header, sizeof(unit8_t), HEADER_SIZE, argv[2]);
    // TODO: Read samples from input file and write updated data to output file
    int16_t buffer;
    int s = 1;
    do
    {
        s = fread(&buffer, sizeof(int16_t), 1, argv[1]);
        if (s != 0)
        {
            fwrite(&buffer, sizeof(int16_t), 1, argv[2]);
        }
    }
    while (s != 0);
    // Close files
    fclose(input);
    fclose(output);
}
