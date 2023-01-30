// Implements a dictionary's functionality

#include <ctype.h>
#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>
#include <string.h>
#include <strings.h>
#include <stdlib.h>
#include "dictionary.h"

// Represents a node in a hash table
typedef struct node
{
    char word[LENGTH + 1];
    struct node *next;
}
node;

// TODO: Choose number of buckets in hash table
const unsigned int N = LENGTH + 1;

// Hash table
node *table[N];

// Returns true if word is in dictionary, else false
bool check(const char *word)
{
    int nwl = strlen(word);
    for (node *ptr = table[nwl]; ptr != NULL; ptr = ptr->next)
    {
        if (strcasecmp(word, ptr->word) == 0)
        {
            return true;
        }
    }
    return false;
}

// Hashes word to a number
unsigned int hash(const char *word)
{
    int l = strlen(word);
    if (l < N)
    {
        return (strlen(word));
    }
    else
    {
        return l % N;
    }
}

int wordc = 0;

// Loads dictionary into memory, returning true if successful, else false
bool load(const char *dictionary)
{
    FILE *intpr = fopen(dictionary, "r");
    if (intpr == NULL)
    {
        return false;
    }

    char *w = malloc(N + 1);
    while (fscanf(intpr, "%s", w) != EOF)
    {
        node *n = malloc(sizeof(node));
        if (n == NULL)
        {
            return false;
        }
        strcpy(n->word, w);
        int z = hash(n->word);
        if (table[z] == NULL)
        {
            n->next = NULL;
            table[z] = n;
            wordc++;
        }
        else if (strcasecmp(n->word, table[z]->word) < 0)
        {
            n->next = table[z];
            table[z] = n;
            wordc++;
        }
        else
        {
            for (node *ptr = table[z]; ptr != NULL; ptr = ptr->next)
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
            wordc++;
        }
    }
    free(w);
    return true;
}

// Returns number of words in dictionary if loaded, else 0 if not yet loaded
unsigned int size(void)
{
    return wordc;
}

// Unloads dictionary from memory, returning true if successful, else false
bool unload(void)
{
    for (int i = 0; i <= N; i++)
    {
        node *temp = table[i];
        for (node *ptr = table[i]; ptr != NULL; ptr = ptr->next)
        {
            temp = ptr;
            free(temp);
        }
    }
    return true;
    return false;
}
