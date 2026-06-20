#lang racket

#|
PROBLEM 24
LEXICOGRAPHIC PERMUTATIONS

A permutation is an ordered arrangement of objects
for example, 3124 is one possible permutation of the digits 1,2,3,4
if all permutations are listed numerically or alphabetically
we call it lexicographic order
the lexicographic permutations of 0,1,2 are:

012 021 102 120 201 210

what is the millionth lexicographic permutation of the digits 0,1,2,3,4,5,6,7,8,9?

answer:
ok so this is a permutation problem, im not very familiar with it but let me plan.
im also assuming its not zero based so 1st lexicographic = 012
lets start simple, with just 3 digit permutation first as the example (0,1,2)

approach
- generate all possible permutation of n digit
- sort those permutations
- then just do list-ref or lookup of that ordered list

im not sure if this is the best approach but let me try

|#

; given a nonzero digit d, generate all unordered possible permutation of 0 - d of that digit
; number -> list-of-list-of-number
; i dont remember how to generate permutation, ithink it used permute or prefix or smth
(define (generate-all-perm d)
  (let ((digit-list (range 0 d)))
    num-range
    )
  )
(generate-all-perm 1) ; 0,1 -> '((0 1)(1 0))
(generate-all-perm 2) ; 0,1,2 -> '((0 1 2)(0 2 1) ...)
(generate-all-perm 3) ; 0,1,2,3 -> '((0 1 2 3) (0 3 2 1) ...)

; given a number, returns its nth lexicographic permutations
; of the digit 0 - 9 (lets do 0-2 at first)
; number -> number
(define (lexicographic-permutations n)
  0
  )
(lexicographic-permutations 1) ;should return 012