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
        for (int j = 0; j < (width / 2); j++)
        {
            int b = image[i][j].rgbtBlue;
            int r = image[i][j].rgbtRed;
            int g = image[i][j].rgbtGreen;
            image[i][j] = image[i][width - (j + 1)];
            image[i][width - (j + 1)].rgbtBlue = b;
            image[i][width - (j + 1)].rgbtRed = r;
            image[i][width - (j + 1)].rgbtGreen = g;

        }
    }
    return;
}

// Blur image
void blur(int height, int width, RGBTRIPLE image[height][width])
{
    RGBTRIPLE p[height][width];
    for (int i = 0; i < height; i++)
    {
        for (int j = 0; j < width; j++)
        {
            int b = 0;
            int r = 0;
            int g = 0;
            int s = 0;
            for (int k = 0; k < height; k++)
            {
                for (int l = 0; l < width; l++)
                {
                    if ((i - k <= 1 && i - k >= -1) && (j - l <= 1 && j - l >= -1))
                    {
                        s += 1;
                        b += image[k][l].rgbtBlue;
                        r += image[k][l].rgbtRed;
                        g += image[k][l].rgbtGreen;
                    }
                }
            }
            p[i][j].rgbtBlue = (round)(b / (double)s);
            p[i][j].rgbtGreen = (round)(g / (double)s);
            p[i][j].rgbtRed = (round)(r / (double)s);
        }
    }
    for (int i = 0; i < height; i++)
    {
        for (int j = 0; j < width; j++)
        {
                image[i][j] = p[i][j];
        }
    }
    return;
}

// Detect edges
void edges(int height, int width, RGBTRIPLE image[height][width])
{
    RGBTRIPLE r[height][width];
    for (int i = 0; i < height; i++)
    {
        for (int j = 0; j < width; j++)
        {
            int Gxr = 0;
            int Gyr = 0;
            int Gxg = 0;
            int Gyg = 0;
            int Gxb = 0;
            int Gyb = 0;
            for (int k = 0; k < height; k++)
            {
                for (int l = 0; l < width; l++)
                {
                    if ((i - k <= 1 && i - k >= -1) && (j - l <= 1 && j - l >= -1))
                    {
                        if (i == k && (j - l == 1))
                        {
                            Gxr += -2 * image[k][l].rgbtRed;
                            Gyr += 0 * image[k][l].rgbtRed;
                            Gxb += -2 * image[k][l].rgbtBlue;
                            Gyb += 0 * image[k][l].rgbtBlue;
                            Gxg += -2 * image[k][l].rgbtGreen;
                            Gyg += 0 * image[k][l].rgbtGreen;
                        }
                        else if (i == k && l == j)
                        {
                            Gxr += 0 * image[k][l].rgbtRed;
                            Gyr += 0 * image[k][l].rgbtRed;
                            Gxb += 0 * image[k][l].rgbtBlue;
                            Gyb += 0 * image[k][l].rgbtBlue;
                            Gxg += 0 * image[k][l].rgbtGreen;
                            Gyg += 0 * image[k][l].rgbtGreen;
                        }
                        else if (i == k && (l - j == 1))
                        {
                            Gxr += 2 * image[k][l].rgbtRed;
                            Gyr += 0 * image[k][l].rgbtRed;
                            Gxb += 2 * image[k][l].rgbtBlue;
                            Gyb += 0 * image[k][l].rgbtBlue;
                            Gxg += 2 * image[k][l].rgbtGreen;
                            Gyg += 0 * image[k][l].rgbtGreen;
                        }
                        else if (j == l && (i - k == 1))
                        {
                            Gxr += 0 * image[k][l].rgbtRed;
                            Gyr += -2 * image[k][l].rgbtRed;
                            Gxb += 0 * image[k][l].rgbtBlue;
                            Gyb += -2 * image[k][l].rgbtBlue;
                            Gxg += 0 * image[k][l].rgbtGreen;
                            Gyg += -2 * image[k][l].rgbtGreen;
                        }
                        else if (j == l && (k - i == 1))
                        {
                            Gxr += 0 * image[k][l].rgbtRed;
                            Gyr += 2 * image[k][l].rgbtRed;
                            Gxb += 0 * image[k][l].rgbtBlue;
                            Gyb += 2 * image[k][l].rgbtBlue;
                            Gxg += 0 * image[k][l].rgbtGreen;
                            Gyg += 2 * image[k][l].rgbtGreen;
                        }
                        else
                        {
                            if (l < j && k < i)
                            {
                                Gxr += -1 * image[k][l].rgbtRed;
                                Gyr += -1 * image[k][l].rgbtRed;
                                Gxb += -1 * image[k][l].rgbtBlue;
                                Gyb += -1 * image[k][l].rgbtBlue;
                                Gxg += -1 * image[k][l].rgbtGreen;
                                Gyg += -1 * image[k][l].rgbtGreen;
                            }
                            else if (l > j && k < i)
                            {
                                Gxr += 1 * image[k][l].rgbtRed;
                                Gyr += -1 * image[k][l].rgbtRed;
                                Gxb += 1 * image[k][l].rgbtBlue;
                                Gyb += -1 * image[k][l].rgbtBlue;
                                Gxg += 1 * image[k][l].rgbtGreen;
                                Gyg += -1 * image[k][l].rgbtGreen;
                            }
                            else if (k > i && l < j)
                            {
                                Gxr += -1 * image[k][l].rgbtRed;
                                Gyr += 1 * image[k][l].rgbtRed;
                                Gxb += -1 * image[k][l].rgbtBlue;
                                Gyb += 1 * image[k][l].rgbtBlue;
                                Gxg += -1 * image[k][l].rgbtGreen;
                                Gyg += 1 * image[k][l].rgbtGreen;
                            }
                            else if (k > i && l > j)
                            {
                                Gxr += 1 * image[k][l].rgbtRed;
                                Gyr += 1 * image[k][l].rgbtRed;
                                Gxb += 1 * image[k][l].rgbtBlue;
                                Gyb += 1 * image[k][l].rgbtBlue;
                                Gxg += 1 * image[k][l].rgbtGreen;
                                Gyg += 1 * image[k][l].rgbtGreen;
                            }
                        }
                    }
                }
            }
            int Gr = sqrt(pow(Gxr, 2) + pow(Gyr, 2));
            int Gb = sqrt(pow(Gxb, 2) + pow(Gyb, 2));
            int Gg = sqrt(pow(Gxg, 2) + pow(Gyg, 2));
        }
    }
    return;
}
