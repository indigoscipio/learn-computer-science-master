#lang racket

;; ------------------------------------------------------------
;; Data Definitions
;; ------------------------------------------------------------

;; An Expense is a Number (dollars spent)
;; A Trip is (listof Expense)
;; A TripList is (listof Trip)

;; ------------------------------------------------------------
;; Helpers
;; ------------------------------------------------------------

;; take : Nat (listof X) -> (listof X)
(define (take n xs)
  (cond [(zero? n) '()]
        [(null? xs) '()]
        [else (cons (car xs)
                    (take (sub1 n) (cdr xs)))]))

;; drop : Nat (listof X) -> (listof X)
(define (drop n xs)
  (cond [(zero? n) xs]
        [(null? xs) xs]
        [else (drop (sub1 n) (cdr xs))]))

;; ------------------------------------------------------------
;; Parsing
;; ------------------------------------------------------------

;; parse-trip : (listof Number) -> (list Trip (listof Number))
(define (parse-trip raw)
  (define n (car raw))
  (define donations (take n (cdr raw)))
  (define leftover (drop (add1 n) raw))
  (list donations leftover))

;; parse-trips : (listof Number) -> (listof Trip)
(define (parse-trips raw)
  (cond [(zero? (car raw)) '()]
        [else
         (define parsed (parse-trip raw))
         (define this-trip (car parsed))
         (define rest     (cadr parsed))
         (cons this-trip (parse-trips rest))]))

;; ------------------------------------------------------------
;; Money Helpers
;; ------------------------------------------------------------

;; avg : (listof Number) -> Number
(define (avg xs)
  (/ (apply + xs) (length xs)))

;; diff-below-avg : Number Number -> Number
(define (diff-below-avg x avg)
  (if (>= x avg) 0 (- avg x)))

;; truncate-money : Number -> Number
;; floors to 2 decimals: 11.999 ⇒ 11.99
(define (truncate-money n)
  (/ (floor (* n 100)) 100))

;; ------------------------------------------------------------
;; Core Exchange Calculation
;; ------------------------------------------------------------

;; calculate-trip : Trip -> Number
;; minimum exchange for one trip
(define (calculate-trip trip)
  (define a (avg trip))
  (define diffs (map (λ (t) (diff-below-avg t a)) trip))
  (truncate-money (apply + diffs)))

;; ------------------------------------------------------------
;; Formatting Output
;; ------------------------------------------------------------

;; money->string : Number -> String
(define (money->string n)
  (define s (real->decimal-string n 2))
  (string-append "$" s))

;; ------------------------------------------------------------
;; Main
;; ------------------------------------------------------------

;; calculate-trips : (listof Number) -> (listof String)
(define (calculate-trips raw)
  (define trips (parse-trips raw))
  (map (λ (trip) (money->string (calculate-trip trip)))
       trips))

;; ------------------------------------------------------------
;; Examples
;; ------------------------------------------------------------

(calculate-trips '(3 10.00 20.00 30.00 0))
(calculate-trips '(3 10.00 20.00 30.00
                   4 15.00 15.01 3.00 3.01
                   0))