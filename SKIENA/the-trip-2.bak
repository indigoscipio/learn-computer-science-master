#lang racket

; Input
; positive integer n, no of students

; Output
; total amount of money, in dollars and cents that must be exchanged to equalize the students costs

; get the average
; a = 10, b = 20, c = 30
; a needs +10, b needs +0, c needs -10


;; An Expense is a Number
;; representing money a student spent.

;; A Trip is a (listof Expense)
;; e.g., '(10.00 20.00 30.00)

;; TripList is a (listof Trip)

; Number List-of-x -> List-of-x
; returns the first n items from the list
(define (take n list)
  (cond [(null? list) '()]
        [(zero? n) '()]
        [else (cons (car list) (take (- n 1) (cdr list))) ]
        )
  )

; Number List-of-x -> List-of-x
; returns a list where the first n item is removed
(define (drop n list)
  (cond [(null? list) list] ;nothing else to drop
        [(zero? n) list]
        [else (drop (- n 1) (cdr list)) ]
        )
  )
;(drop 1 '(1 2 3 4 5 6)) ; return '(4 5 6)
;(drop 12 '(1 2 3 4 5 6))
;(drop 0 '(1 2 3 4))


;; parse-trip : (listof number) -> (listof number)
;; extract those n numbers as the trip's list of donations.
(define (parse-trip trip)
  ; base case: list is empty -> return empty '()
  ; case 1: one trip: return '((trip))
  ; case 2: more than one trip: return '((trip 1) (trip n+1))
  (let* ((n (if (null? trip) 0 (car trip)) )
         (donations (take n (cdr trip)))
         (rest (drop (+ 1 n) trip))
         )
    (list donations rest)
    )
  )
;(parse-trip '(3 10.00 20.00 30.00 0)) ; return '((10.00 20.00 30.00) (0))
;(parse-trip '(3 10.00 20.00 30.00 4 15.00 15.01 3.00 3.01 0) ) ; return '((10.00 20.00 30.00) (4 15.00 15.01 3.00 3.01 0))

; List-of-(list-of-numbers) -> List-of-list-of-numbers
; parse multiple trips, build the correct list on each iteration
(define (parse-trips trips)
  (cond [(zero? (car trips)) '()]
        [else (let* ((result (parse-trip trips))
                     (curr-trip (car result))
                     (leftover (cadr result))
                     )
                (cons curr-trip (parse-trips leftover) )
                )]
        )
  )
;(parse-trips '(3 10.00 20.00 30.00 0))
;(parse-trips '(3 10.00 20.00 30.00 4 15.00 15.01 3.00 3.01 0))

; given a list of numbers, calculate its average
(define (avg lon)
  (/ (foldr + 0 lon) (length lon))
  )


;; diff-below-average : Number Number -> Number (Positive)
;; how much x is below avg; return 0 if x >= avg
(define (diff-below-avg n avg)
  (if (>= n avg)
      0
      (abs (- n avg))
      )
  )
;(diff-below-avg 0 5)

;; calculate-trip : (listof Number) -> Number
;; Given one trip’s expenses, return min exchange.
(define (calculate-trip trip)
  (let* ((avg-val (avg trip))
        (diffs (map (lambda (t) (diff-below-avg t avg-val) ) trip))
        )
    (truncate-money (foldr +  0 diffs) )
    
    )
  )
;(calculate-trip '(10.00 20.00 30.00))

(define (truncate-money n)
  (/ (floor (* n 100)) 100))


;; calculate-trips : (listof Number) -> (listof Number)
;; Given the raw encoded input, return the result for each trip.
(define (calculate-trips trip)
  (let* ((expenses (parse-trips trip)))

    (map (lambda (n) (string-append "$" (real->decimal-string n 2)))
         (map calculate-trip expenses)
         )
    )
  )

(calculate-trips '(3 10.00 20.00 30.00 0))
(calculate-trips '(3 10.00 20.00 30.00 4 15.00 15.01 3.00 3.01 0))
