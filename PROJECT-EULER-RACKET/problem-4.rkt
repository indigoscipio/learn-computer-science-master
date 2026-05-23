#lang racket

#|
PROBLEM 4: LARGEST PALINDROME PRODUCT

A palindromic number reads the same both ways. The largest palindrome made from the product of 2 two-digit numbers
is 9009 = 91 * 99

find the largest palindrome made from the product of two 3 digit numbers.
|#

;; is-palindrome?:: number -> boolean
; given a number, checks if its a palindrome
(define (is-palindrome? n)
  (let* ((lst1 (map (λ (char) (- (char->integer char) (char->integer #\0)) ) (string->list (number->string n))))
         (lst2 (reverse lst1))
         )
    (define (helper xs ys)
      (cond [(empty? xs) #t]
            [(not (equal? (car xs) (car ys))) #f]
            [else (helper (cdr xs) (cdr ys))])
      )
    (helper lst1 lst2)
    )
  )
(is-palindrome? 1111)

; given a product of 3 digit number, finds its largest palindrome product
(define (largest-palindrome-product)
  (define (helper i j max-so-far)
    (cond [(zero? i) max-so-far]
          [(< j 100) (helper (- i 1) 999 max-so-far)]
          [(is-palindrome? (* i j)) (if (> (* i j) max-so-far)
                                        (helper i (- j 1) (* i j))
                                        (helper i (- j 1) max-so-far)
                                        )]
          [else (helper i (- j 1) max-so-far)]
          )
    )
  (helper 999 999 0)
  )
(largest-palindrome-product)