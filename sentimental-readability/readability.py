# TODO
from cs50 import get_string

def main():
    text = get_string("Text: ")
    W = count_words(text)
    L = (count_letters(text) * 100.0) / W
    S = (count_sentences(text) * 100.0) / W
    index = round(0.0588 * L - 0.296 * S - 15.8)

    if index > 0 and index < 17:
        print(f"Grade {index}")
    elif index < 1:
        print("Before Grade 1")
    elif index > 16:
        print("Grade 16+")


def count_letters(text):
    count = 0
    for i in range(len(text)):
        if ((ord(text[i]) > 64 and ord(text[i]) < 91)) or (ord(text[i]) > 96 and ord(text[i]) < 123):
            count += 1
    return count

def count_words(text):
    l = 0
    count = 0
    for i in range(len(text)):
        if ord(text[i]) == 32:
            if l == 0:
                count += 2
                l = 1
            else:
                count += 1
    return count

def count_sentences(text):
    count = 0
    for i in range(len(text)):
        if ord(text[i]) == 33 or ord(text[i]) == 63 or ord(text[i]) == 46:
            count += 1
    return count

main()