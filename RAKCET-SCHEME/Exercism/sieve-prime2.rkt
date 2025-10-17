#lang racket

; a PrimeNumber (PN) is a number
; > 1
; only divisible by 1 and itself

; Example: '(2 3 4 5)
; 2 is unmarked -> mark as prime -> mark its next multiple (4,6,8) as not prime
; 3 is unmarked -> mark as prime -> mark its next multiple (3,6,9) as not prime
; repeat

; generates a number from 2 to n
; Number Number -> List-of-number
(define (enumerate start end)
  (define (loop i acc)
    (cond [(> i end) (reverse acc)]
          [else (loop (+ 1 i) (cons i acc)) ])
    )

  (loop start '())
  )

; Number Number -> Boolean
; true if a is a multiple of b
(define (multiple-of? a b)
   (= (remainder a b) 0)
  )

; Number -> (List-of-PrimeNumber)
; finds all prime number equal or less than a given n
(define (sieve n)
  ; find the next unmarked number in your list (skip marked number)
  ; acc holds the Prime Number gathered so far.
  ; Number List-of-number List-of-PrimeNumber -> List-of-PrimeNumber
  (define (iter curr-num candidates acc)
    (cond [(null? candidates) (reverse acc)]
          [else (let* ((prime (car candidates))
                       (rest (cdr candidates))
                       (filtered (filter (lambda (x) (not (multiple-of? x prime)) ) rest))
                       )
                  (iter prime filtered (cons prime acc) )
                  ) ] ; else recurse and increase n
          )
    )
  (iter 2 (enumerate 2 n) '())
  )
(sieve 50)


