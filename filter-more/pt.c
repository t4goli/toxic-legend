#include <cs50.h>
#include <stdio.h>
#include <math.h>


int main(void)
{
    typedef struct
    {
    int  rgbtBlue;
    int  rgbtGreen;
    int  rgbtRed;
    } __attribute__((__packed__))
    RGBTRIPLE;
    int height = 4;
    int width = 4;
    RGBTRIPLE image[height][width];
    RGBTRIPLE r[height][width];
    image[0][0].rgbtRed = 0;
    image[0][0].rgbtGreen = 10;
    image[0][0].rgbtBlue = 25;
    image[0][1].rgbtRed = 0;
    image[0][1].rgbtGreen = 10;
    image[0][1].rgbtBlue = 30;
    image[0][2].rgbtRed = 40;
    image[0][2].rgbtGreen = 60;
    image[0][2].rgbtBlue = 80;
    image[0][3].rgbtRed = 50;
    image[0][3].rgbtGreen = 60;
    image[0][3].rgbtBlue = 80;

    image[1][0].rgbtRed = 20;
    image[1][0].rgbtGreen = 30;
    image[1][0].rgbtBlue = 90;
    image[1][1].rgbtRed = 30;
    image[1][1].rgbtGreen = 40;
    image[1][1].rgbtBlue = 100;
    image[1][2].rgbtRed = 80;
    image[1][2].rgbtGreen = 70;
    image[1][2].rgbtBlue = 90;
    image[1][3].rgbtRed = 80;
    image[1][3].rgbtGreen = 80;
    image[1][3].rgbtBlue = 90;

    image[2][0].rgbtRed = 20;
    image[2][0].rgbtGreen = 20;
    image[2][0].rgbtBlue = 40;
    image[2][1].rgbtRed = 30;
    image[2][1].rgbtGreen = 10;
    image[2][1].rgbtBlue = 30;
    image[2][2].rgbtRed = 50;
    image[2][2].rgbtGreen = 40;
    image[2][2].rgbtBlue = 10;
    image[2][3].rgbtRed = 50;
    image[2][3].rgbtGreen = 40;
    image[2][3].rgbtBlue = 100;

    image[3][0].rgbtRed = 50;
    image[3][0].rgbtGreen = 20;
    image[3][0].rgbtBlue = 40;
    image[3][1].rgbtRed = 50;
    image[3][1].rgbtGreen = 20;
    image[3][1].rgbtBlue = 40;
    image[3][2].rgbtRed = 50;
    image[3][2].rgbtGreen = 40;
    image[3][2].rgbtBlue = 80;
    image[3][3].rgbtRed = 50;
    image[3][3].rgbtGreen = 40;
    image[3][3].rgbtBlue = 80;

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
            int Gr = round(sqrt(pow(Gxr, 2) + pow(Gyr, 2)));
            int Gb = round(sqrt(pow(Gxb, 2) + pow(Gyb, 2)));
            int Gg = round(sqrt(pow(Gxg, 2) + pow(Gyg, 2)));
            if (Gr > 255)
            {
                Gr = 255;
            }
            else if (Gb > 255)
            {
                Gb = 255;
            }
            else if (Gg > 255)
            {
                Gg = 255;
            }
            r[i][j].rgbtRed = Gr;
            r[i][j].rgbtGreen = Gg;
            r[i][j].rgbtBlue = Gb;
        }
    }

    for (int i = 0; i < height; i++)
    {
        for (int j = 0; j < width; j++)
        {
            image[i][j] = r[i][j];
        }
    }
    
}