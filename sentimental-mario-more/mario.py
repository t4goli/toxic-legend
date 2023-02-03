# TODO
from cs50 import get_int

def main():
    num = get_height()
    for i in range(1, num + 1):
        for j in range(num - i, 0, -1):
            print(" ", end="")
        for l in range(i):
            print("#", end="")
        print("  ", end="")
        for k in range(i):
            print("#", end="")
        print()

def get_height():
    while True:
        num = get_int("Height: ")
        if num > 0 and num < 9:
            return num

main()
