#include <cs50.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <time.h>

// each of our text files contains 1000 words
#define LISTSIZE 1000

// values for colors and score (EXACT == right letter, right place; CLOSE == right letter, wrong place; WRONG == wrong letter)
#define EXACT 2
#define CLOSE 1
#define WRONG 0

// ANSI color codes for boxed in letters
#define GREEN   "\e[38;2;255;255;255;1m\e[48;2;106;170;100;1m"
#define YELLOW  "\e[38;2;255;255;255;1m\e[48;2;201;180;88;1m"
#define RED     "\e[38;2;255;255;255;1m\e[48;2;220;20;60;1m"
#define RESET   "\e[0;39m"

// user-defined function prototypes

int main (void)
{
    int wordsize = 3;
    int score = 0;
    string guess = "pot";
    string choice = "lok";
    int status[wordsize];
    for (int i = 0; i < wordsize; i++)
    {
        status[i] = 0;
    }
    // compare guess to choice and score points as appropriate, storing points in status
    // TODO #5
    for (int i = 0; i < wordsize; i++)
    {
        for (int j = 0; j < wordsize; j++)
        {
            int k = guess[i];
            if (k == choice[j] && (i == j))
            {
                status[i] = EXACT;
                score += 2;
                break;
            }
            else if (k == choice[j])
            {
                status[i] = CLOSE;
                score +=1;
            }
            else
            {
                status[i] = WRONG;
            }
        }
        printf("%i", status[i]);
    }
    // HINTS
    // iterate over each letter of the guess
        // iterate over each letter of the choice
            // compare the current guess letter to the current choice letter
                // if they're the same position in the word, score EXACT points (green) and break so you don't compare that letter further
                // if it's in the word, but not the right spot, score CLOSE point (yellow)
        // keep track of the total score by adding each individual letter's score from above

}

