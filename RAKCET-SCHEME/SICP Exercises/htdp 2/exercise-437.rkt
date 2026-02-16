;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise-437) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))

#|
(define (general P)
  (cond    [(trivial? P) (solve P)]
           [else (combine-solutions P (general(generate P)))]))
|#


; special engates each number on the given list of numbers
; special uppercases the given list of strings

#|
; case 1: special computes the length of its input
; List-of-X -> Number
(define (solve p)
  0
  )

(define (combine-solutions p r)
  (+ 1 r) 
  )

(define (special P)
  (cond    [(empty? P) (solve P)]
           [else (combine-solutions P (special (rest P)))])
  )
(special '(1 2 3 4))
|#

#|
; case 2: special negates each number on the given list of numbers, and
; List-of-number -> List-of-number (negated)
(define (solve p)
  '()
  )

(define (combine-solutions p r)
  (cons (- (first p)) r)
  )

(define (special P)
  (cond    [(empty? P) (solve P)]
           [else (combine-solutions P (special (rest P)))])
  )
(special '(1 2 3 4))
|#

#|
; case 3: special uppercases the given list of strings.
; List-of-string -> List-of-string (all uppercase)
(define (solve p)
  '()
  )

(define (combine-solutions p r)
  (cons (string-upcase (first p)) r)
  )

(define (special P)
  (cond    [(empty? P) (solve P)]
           [else (combine-solutions P (special (rest P)))])
  )
(special '("hello world"))
|#

; what i can conclude from these exercise
; you can combine generative and structural recursion (or put rest into another function)
