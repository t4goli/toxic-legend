#include "bmp.h"

// colorize image
void colorize(int height, int width, RGBTRIPLE image[height][width]);
{
    for (int i = 0; i < height; i++)
    {
        for (int j = 0; j < width; j++)
        {
            RGBTRIPLE image[i][j].rgbtBlue = 3;
            RGBTRIPLE image[i][j].rgbtBlue = 252;
            RGBTRIPLE image[i][j].rgbtBlue = 132;
        }
    }
}

