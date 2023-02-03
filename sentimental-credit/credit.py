# TODO
from cs50 import get_float

def main():
    length = 1
    pholder = get_num()
    i = 1
    while i < pholder:
        length += 1
        pholder / 10
        i *= 10
    if length % 2 == 1:
        plength = length + 1
    else:
        plength = length
    q = 10
    for i in range (length/2):
        add = ((num % (q * 10)) / q) * 2
        sum = sum + (add % 10) + (add / 10)
        q *= 100
    q = 1
    for i in range(plength/2):
        add = (num % (q * 10) / q)
        sum = sum + (add % 10) + (add / 10)
        q *= 100
    if sum % 10 == 0:
        if num / 1000000000000000 == 4 or length == 13:
            print("VISA")
        elif length == 15 and (num / 10000000000000 == 34 or num / 10000000000000 == 37):
            print("AMEX")
        elif num / 100000000000000 > 50 and num / 100000000000000 < 56:
            print("MASTERCARD")
        else:
            print("INVALID")
    else:
        print("INVALID")


def get_num():
    while True:
        num = get_float("Number: ")
        if num > 0:
            return num


main()

