#include "helpers.h"
#include <math.h>

// Convert image to grayscale
void grayscale(int height, int width, RGBTRIPLE image[height][width])
{
    for (int i = 0; i < height; i++)
    {
        for (int j = 0; j < width; j++)
        {
            int k = (round)((image[i][j].rgbtRed + image[i][j].rgbtBlue + image[i][j].rgbtGreen) / 3.0);
            image[i][j].rgbtRed = k;
            image[i][j].rgbtGreen = k;
            image[i][j].rgbtBlue = k;
        }
    }
    return;
}

// Reflect image horizontally
void reflect(int height, int width, RGBTRIPLE image[height][width])
{
    for (int i = 0; i < height; i++)
    {
        for (int j = 0; j < (round)(width / 2); j++)
        {
            int b = image[i][j].rgbtBlue;
            int r = image[i][j].rgbtRed;
            int g = image[i][j].rgbtGreen;
            image[i][j].rgbtRed = image[i][width - j].rgbtRed;
            image[i][j].rgbtBlue = image[i][width - j].rgbtBlue;
            image[i][j].rgbtGreen = image[i][width - j].rgbtGreen;
            image[i][width - j].rgbtBlue = b;
            image[i][width - j].rgbtRed = r;
            image[i][width - j].rgbtGreen = g;

        }
    }
    return;
}

// Blur image
void blur(int height, int width, RGBTRIPLE image[height][width])
{
    for (int i = 0; i < height; i++)
    {
        for (int j = 0; j < width; j++)
        {
            int b = image[i][j].rgbtBlue;
            int r = image[i][j].rgbtRed;
            int g = image[i][j].rgbtGreen;
            int s = 1;
            for (int k = 0; k < height; k++)
            {
                for (int l = 0; l < width; l++)
                {
                    if ((i - k <= 1 || k - i <= 1) && (j - l <= 1 || l - j <= 1))
                    {
                        s += 1;
                        b += image[k][l].rgbtBlue;
                        r += image[k][l].rgbtRed;
                        g += image[k][l].rgbtGreen;
                    }
                }
            }
            image[i][j].rgbtBlue = (b / s);
            image[i][j].rgbtGreen = (g / s);
            image[i][j].rgbtRed = (r / s);
        }
    }
    return;
}

// Detect edges
void edges(int height, int width, RGBTRIPLE image[height][width])
{

    return;
}
