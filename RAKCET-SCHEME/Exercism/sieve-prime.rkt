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
  (cond [(> start end) '()]
        [else (cons start (enumerate (+ 1 start) end))])
  )

; generates multiples of p from p*2 up to max
; Number Number -> List-of-Number
(define (generate-multiples multiplier max)
  (define (iter n acc)
    (cond [(> (* multiplier n) max) (reverse acc)]
          [else (iter (+ 1 n) (cons (* multiplier n) acc) )])
    )
  (iter 2 '())    
  #|
  (filter (lambda (num) (not (= (remainder num multiplier) 0)) ) l)
  |#
  )
(generate-multiples 2 10)

; removes all items of l1 in l2
; List-of-Number List-of-Number -> List-of-Number
(define (remove-all l1 l2)
  (define (iter list acc)
    (cond [(null? list) (reverse acc)]
          [(member (car list) l1) (iter (cdr list) acc) ]
          [else (iter (cdr list) (cons (car list) acc)) ]
          )
    )
  (iter l2 '())
  )


; Number -> (List-of-PrimeNumber)
; finds all prime number equal or less than a given n
(define (sieve n)
  ; find the next unmarked number in your list (skip marked number)
  ; acc holds the Prime Number gathered so far.
  ; Number List-of-number List-of-PrimeNumber -> List-of-PrimeNumber
  (define (iter curr-num candidates acc)
    (cond [(null? candidates) (reverse acc)]
          [else (iter (car candidates)
                      (remove-all (generate-multiples (car candidates) n) (cdr candidates))
                      (cons (car candidates) acc) )] ; else recurse and increase n
          )
    )
  (iter 2 (enumerate 2 n) '())
  )
(sieve 50)

