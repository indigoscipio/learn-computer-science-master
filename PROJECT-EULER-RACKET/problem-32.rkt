#lang racket

#|
Problem 32
Pandigital products

we shall say that n digit number is pandigital if it makes use of all the digits 
1 to n exactly one; for example, the 5 digit number 15234 is 1 - 5 pandigital

the product 7254 is unusual as the identity, 36*186 = 7254 containing
multiplicand, multiplier and product is 1 through 9 pandigital

find the sum of all products whose multiplicant/multiplier/product identity
can be written as a 1 - 9 pandigital


answer:
ok so let me understand the question
we wanna find sum of all products whose multiplicant/multiplier/product identity
can be written as 1 - 9 pandigital, like the example above

now we need to find the upper limit
on the example 39*186 = 7254
2d * 3d = 4d
so total digit must be 9
no digit can ever repeat -> 33 * 186 -> fails, not pandigital
not sure about the upper limit, the result digit can range here
and the multiplicant a and mult b can also range digit

additional hint says some product can be obtained in more than one way
39 * 186 = 186 * 39 so only keep this once

approach
- a hepler that checks if given a,b,n checks if they are pandigital
- a main function that calls helper 

The real question you should sit with:
What are the bounds of your search? You can't loop forever.
Think about: what's the maximum a product can be if the total digit count across
all three numbers must equal exactly 9?
That upper bound is the key to making the search finite.
Sit with that and see what you come up with!

❌ 1d . 1d = 7d -> 9.9 = 81 -> 2 digit
❌ 1d . 7d = 1d -> 9 . 9999999 -> impossible, result is 89.999.991
❌ 2d . 6d = 1d -> impossible
❌ 3d . 4d = 2d -> impossible -> 999 . 9999 cant be 2 digit
❌ 4d . 2d = 3d -> 9999 . 99 = 989901, 6 digits
3d . 2d = 4d -> 999 . 99 = 98901, maybe still in range? example has the same patern
1d . 4d = 4d -> 9 . 9999 -> 89991, possible, still within range
❌ 2d . 2d = 5d -> 99 . 99 -> 9801 -> too small
❌ 5d . 1d = 3d -> 99999 . 9 = 899991 -> too large


|#


; given an integer, returns a list of its digits
(define (int->digit-list int)
  (map (λ (c) (- (char->integer c)(char->integer #\0))) (string->list (number->string int)))
  )

; given a multiplicant a, multiplier b, and product n,
; checks if those numbers are pandigital 1-9
(define (is-pandigital? a b n)
  ; convert number to list, append them together and check for unique
  (let* ((digits-a (int->digit-list a))
         (digits-b (int->digit-list b))
         (digits-n (int->digit-list n))
         (flat-lst (append digits-a digits-b digits-n)))

    (define (helper lst)

      )

    
    )
  )
(is-pandigital? 39 186 7254)


#|
One thing to sit with before coding: what are the exact loop bounds for each pattern?
For example, for 1d × 4d = 4d, what does a range over? What does b range over?
And do you need to check the product's digit count explicitly,
or does the pandigital check already catch invalid ones?
|#

; main function
; void -> number
(define (pandigital-products)
  ; only collect the product, search space is 3d.2d = 4d and 1d.4d = 4d

  
  )