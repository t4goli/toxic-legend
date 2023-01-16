#include <cs50.h>
#include <stdio.h>
#include <string.h>

// Max number of candidates
#define MAX 9

// preferences[i][j] is number of voters who prefer i over j
int preferences[MAX][MAX];

// locked[i][j] means i is locked in over j
bool locked[MAX][MAX];

// Each pair has a winner, loser
typedef struct
{
    int winner;
    int loser;
}
pair;

// Array of candidates
string candidates[MAX];
pair pairs[MAX * (MAX - 1) / 2];

int pair_count;
int candidate_count;

// Function prototypes
bool vote(int rank, string name, int ranks[]);
void record_preferences(int ranks[]);
void add_pairs(void);
void sort_pairs(void);
void lock_pairs(void);
void print_winner(void);

int main(int argc, string argv[])
{
    int s;
    for (int i = 0; i < pair_count; i++)
    {
        s = 0;
        int t = pair_count;
        int y = pairs[i].winner;
        do
        {
            for (int j = 0; j < pair_count; j++)
            {
                if (pairs[j].loser == pairs[i].winner)
                {
                    y = pairs[j].winner;
                }
                if (y == pairs[i].loser)
                {
                    s = 4;
                }
                if (s == 4)
                {
                    break;
                }
            }
            t -= 1;
        }
        while (t > 0);

        if (s != 4)
        {
            locked[pairs[i].winner][pairs[i].loser] = true;
        }
    }
}
