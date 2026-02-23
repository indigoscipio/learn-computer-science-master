#lang racket

#|
Exercise 4.7

4-7. [3] Outline a reasonable method of solving each of the following problems. Give
the order of the worst-case complexity of your methods.

(a) You are given a pile of thousands of telephone bills and thousands of checks
sent in to pay the bills. Find out who did not pay.

(b) You are given a list containing the title, author, call number and publisher of
all the books in a school library and another list of 30 publishers. Find out
how many of the books in the library were published by each company.

(c) You are given all the book checkout cards used in the campus library during
the past year, each of which contains the name of the person who took out
the book. Determine how many distinct people checked out at least one book.

answer:
a. i guess to find out who did not pay
naively we can just find for each bill search all checks but thats long

or we can pair each telephone bill with a check
smth like (cons bill . check)
to find out who didn't pay the value of bill does not equal check, so thatsa simple comparison operator
if the person didn't pay we can just make the check empty or false or something

sort -> linear scan (n log n + n) = O(n log n)

b.
ok so we have a list of title, author, call num, publisher of books.
another list is small

dont walk through each publisher one by one
walk once and keep a tally

hash table -> O(n)

c.
put each unique name in a lookup table/dictionary
same as a


|#