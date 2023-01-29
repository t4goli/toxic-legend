// Implements a dictionary's functionality

#include <ctype.h>
#include <stdbool.h>

#include "dictionary.h"

// Represents a node in a hash table
typedef struct node
{
    char word[LENGTH + 1];
    struct node *next;
}
node;

// TODO: Choose number of buckets in hash table
const unsigned int N = LENGTH;

// Hash table
node *table[N];

// Returns true if word is in dictionary, else false
bool check(const char *word)
{
    // TODO
    return false;
}

// Hashes word to a number
unsigned int hash(const char *word)
{
    // TODO: Improve this hash function
    return toupper(word[0]) - 'A';
}

// Loads dictionary into memory, returning true if successful, else false
bool load(const char *dictionary)
{
    FILE *intpr = fopen(dictionary, "r")
    if (intpr = NULL)
    {
        return false;
    }
    char *w;
    while (fscanf(intpr, "%s", word) != EOF)
    {
        node *n = malloc(sizeof(node));
        if (n == NULL)
        {
            return false;
        }
        strcpy(n->word, *w);
        int index = hash(n->word);
        if (table[index] == NULL)
        {
            table[index] = n;
        }
        else if (strcasecmp(n->word, table[index]->word) < 0)
        {
            n->next = table[index];
            table[index] = n;
        }
        else
        {
            for (node *pt = table[index]; ptr != NULL; ptr = ptr->next)
            {
                if (ptr->next == NULL)
                {
                    ptr->next = n;
                    break;
                }
                if (strcasecmp(n->word, ptr->next->word) < 0)
                {
                    n->next = ptr->next;
                    ptr->next = n;
                }
            }
        }

    }
}

// Returns number of words in dictionary if loaded, else 0 if not yet loaded
unsigned int size(void)
{
    // TODO
    return 0;
}

// Unloads dictionary from memory, returning true if successful, else false
bool unload(void)
{
    // TODO
    return false;
}
