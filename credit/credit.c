#include <cs50.h>
#include <stdio.h>

int main(void)
{
    long num;
    do
    {
        num = get_long("Number: ");
    }
    while (num < 0);


    int length = 1;
    long pholder = num;

    for (long i = 1; i < pholder; i *= 10)
    {
        length++;
        pholder = num / 10;
    }

    int add;
    int sum;
    long q = 10;
    int plength;

    if (length % 2 == 1)
    {
        plength = length + 1;
    }
    else
    {
        plength = length;
    }
    for (int i = 0; i < (length / 2); i++)
    {
        add = ((num % (q * 10)) / q) * 2;
        printf("%i\n", add);
        printf("%i\n", sum);
        sum = sum + (add % 10) + (add / 10);
        q *= 100;
    }
    printf("%i\n", sum);
    for (int i = 0; i < (plength / 2); i++)
    {
        add = (num % (q * 10) / q);
        sum = sum + (add % 10) + (add / 10);
        q *= 100;
    }

    if (sum % 10 == 0)
    {
        if (num / 1000000000000000 == 4 || length == 13)
        {
            printf("VISA\n");
        }
        else if (length == 15 && (num / 10000000000000 == 34 || num / 10000000000000 == 37))
        {
            printf("AMEX\n");
        }
        else if (num / 100000000000000 > 50 && num / 100000000000000 < 56)
        {
            printf("MASTERCARD\n");
        }
        else
        {
            printf("INVALID\n");
        }

    }
    else
    {
        printf("INVALID\n");
    }
}