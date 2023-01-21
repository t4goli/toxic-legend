#include "bmp.h"

// colorize image
void colorize(int height, int width, RGBTRIPLE image[height][width]);
{

    for (int i = 0; i < height; i++)
    {
        for (int j = 0; j < width; j++)
        {
            RGBTRIPLE p = image[i][j];
            p.rgbtRed = 3;
            p.rbgtGreen = 252;
            p.rgbtBlue = 132;
        }
    }
}

