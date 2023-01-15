#include <cs50.h>
#include <stdio.h>

int main(void)
{
    // gets name
    string name = get_string("Name: ");
    // prints name
    printf("hello, %s\n", name);
}