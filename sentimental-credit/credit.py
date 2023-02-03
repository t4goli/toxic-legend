# TODO
from cs50 import get_int

def main():
    length = 1
    pholder = get_num()
    for i in range(1, pholder, *10):
        length += 1
        pholder / 10
    if length % 2 is 1:
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
    if sum % 10 is 0:
        if num / 1000000000000000 is 4 or length is 13:
            print("VISA")
        elif length is 15 and (num / 10000000000000 is 34 or num / 10000000000000 is 37):
            print("AMEX")
        elif num / 100000000000000 > 50 and num / 100000000000000 < 56:
            print("MASTERCARD")
        else:
            print("INVALID")
    else:
        print("INVALID")


def get_num():
    while True:
        num = get_int()
        if num > 0:
            return num


main()

