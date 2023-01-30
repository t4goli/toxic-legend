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

// Dictionary Word Count
int wc = 0;

// Loads dictionary into memory, returning true if successful, else false
bool load(const char *dictionary)
{
    FILE *f = fopen(dictionary, "r");
    if (f == NULL)
    {
        fclose(f);
        return false;
    }

    char *w = malloc(N + 1);
    while (fscanf(f, "%s", w) != EOF)
    {
        node *n = malloc(sizeof(node));
        if (n == NULL)
        {
            fclose(f);
            free(n);
            return false;
        }
        strcpy(n->word, w);
        int z = hash(n->word);
        if (table[z] == NULL)
        {
            n->next = NULL;
            table[z] = n;
            wc++;
        }
        else
        {
            n->next = table[z];
            table[z] = n;
            wc++;
        }
    }
    fclose(f);
    free(w);
    return true;
}

// Returns number of words in dictionary if loaded, else 0 if not yet loaded
unsigned int size(void)
{
    return wc;
}

// Unloads dictionary from memory, returning true if successful, else false
bool unload(void)
{
    for (int i = 0; i <= N; i++)
    {
        node *ptr = table[i];
        while (ptr != NULL)
        {
            node *next = ptr->next;
            free(ptr);
            ptr = next;
        }
    }
    return true;
}
