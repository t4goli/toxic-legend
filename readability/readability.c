#include <cs50.h>
#include <stdio.h>
#include <math.h>

int count_letters(string text)
int count_words(string text)
int count_sentences(string text)



int main(void)
{
    string text = get_string("Text: ");
    int L = count_letters(text);
    int S = count_sentences(text);
    index = 0.0588 * L - 0.296 * S - 15.8;
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
            count += 2;
        }
    }
    return count;
}
