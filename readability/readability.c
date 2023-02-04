#include <cs50.h>
#include <stdio.h>
#include <math.h>
#include <string.h>

int count_letters(string text);
int count_words(string text);
int count_sentences(string text);



int main(void)
{
    string text = get_string("Text: ");
    int w = count_words(text);
    double L = (count_letters(text) * 100.0) / w;
    double S = (count_sentences(text) * 100.0) / w;
    int index = round(0.0588 * L - 0.296 * S - 15.8);

    if (index > 0 && index < 17)
    {
        printf("Grade %i\n", index);
    }
    else if (index < 1)
    {
        printf("Before Grade 1\n");
    }
    else if (index > 16)
    {
        printf("Grade 16+\n");
    }
}

int count_letters(string text)
{
    int count = 0;
    for (int i = 0; i < strlen(text); i++)
    {
        if ((text[i] > 64 && text[i] < 91) || (text[i] > 96 && text[i] < 123))
        {
            count++;
        }
    }
    return count;
}

int count_words(string text)
{
    int l = 0;
    int count = 0;
    for (int i = 0; i < strlen(text); i++)
    {
        if (text[i] == 32)
        {
            if (l == 0)
            {
                count += 2;
                l = 1;
            }
            else
            {
                count++;
            }
        }
    }
    return count;
}

int count_sentences(string text)
{
    int count = 0;
    for (int i = 0; i < strlen(text); i++)
    {
        if (text[i] == 33 || text[i] == 63 || text[i] == 46)
        {
            count += 1;
        }
    }
    return count;
}
