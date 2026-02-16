#lang racket

; Atom List-of-atoms -> Boolean
(define (is-first? a lat)
  (cond [(empty? lat) #f]
        [else (eq? (car lat) a)])
  )

(is-first? 'atom '(of atom atom not atom))

#|
(define (is-first-b? a lat)
  (cond [(empty? lat) #f]
        [else (or (eq? (car lat) a) (two-in-a-row? lat))])
  )
|#


#|
; List-of-atoms -> BOolean
(define (two-in-a-row? lat)
  ; Iteration 1
  (cond [(empty? lat) #f]
        [else (is-first-b? (car lat) (cdr lat))]
        )

    #|
  ; Iteration 2, using accumlator
  (define (iter prev rest)
    (cond [(empty? rest) #f]
          [(eq? (car rest) prev) #t]
          [else (iter (car rest) (cdr rest))])
    )
  (if (empty? lat) #f (iter (car lat) (cdr lat)))
   |#

  )
(two-in-a-row? '(b a c a a))
|#

(define (two-in-a-row-b? prev lat)
  (cond [(null? lat) #f]
        [else (or (eq? (car lat) prev)
                  (two-in-a-row-b? (car lat) (cdr lat))) ])
  )

(define (two-in-a-row? lat)
  (cond [(null? lat) #f]
        [else (two-in-a-row-b? (car lat) (cdr lat))])
  )
#|
; sum is the accumulated/sum number seen so far
; List-of-numbers Number -> List-of-Number
(define (sum-of-prefixes-helper tup sum)

  ; iteration 1: structural recursion
  (cond [(empty? tup) '()]
        [else (cons (+ (car tup) sum )
                    (sum-of-prefixes-helper (cdr tup) (+ sum (car tup)))) ])


  ;iteration 2: iteration/accumulator
  ; accumulator creates list of numbers with sum accumulated so far
  ; List-of-number Number List-of-number -> List-of-number
  (define (iter l sum acc)
    (cond [(empty? l) (reverse acc)]
          [else (iter (cdr l) (+ sum (car l)) (cons (+ (car l) sum) acc) ) ])
    )
  (iter tup 0 '())


  ;Iteration 3: using foldr
  (foldr (lambda (n acc-fn(lambda (sum) (cons (+ sum n) (acc-fn (+ sum n)) ))  ) (lambda (sum) '()) tup) 0 )

  ; Iteration X: with xx
  )
(sum-of-prefixes-helper '(1 1 1) 0)


; List-of-numbers -> List-of-number
(define (sum-of-prefixes tup)
  (sum-of-prefixes-helper tup 0)
  )
|#

; The Eleventh Commandment
; use additional arguents when a function needs to know what other arguments to the function have been like so far

; takes non empty tup in which no number is greater than its own index
; returns a tup of the same length
; each number in the argument is treated as a backward index from its own position
; to a point earlier in the tup
; the result at each position is found by counting backward from the current position according ot this index
(define (scramble tup)
  0
  )

(define (pick n lat)
  (cond [(zero? (- n 1)) (car lat)]
        [else (pick (- n 1) (cdr lat))])
  )
(pick 2 '(item-one item-two item-three item-four))

(define (scramble-b tup rev-pre)
  00
  )
