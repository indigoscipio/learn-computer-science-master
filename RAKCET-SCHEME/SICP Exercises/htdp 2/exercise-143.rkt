;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise-143) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))

 
; List-of-temperatures -> Number 
; adds up the temperatures on the given list 
(define (sum alot)
  (cond
    [(empty? alot) 0]
    [else (+ (first alot) (sum (rest alot)))]))


 
; List-of-temperatures -> Number 
; counts the temperatures on the given list 
(define (how-many alot)
  (cond [(empty? alot) 0]
        [else (+ (how-many (rest alot)) 1)]
        ))


; List-of-temperatures -> Number
; computes the average temperature 
(define (average alot)
  (/ (sum alot) (how-many alot)))

(define (checked-average alot)
  (if (empty? alot)
      (error "List cannot be empty!")
      (average alot))
  )

(define sample-alot (cons 1 (cons 2 (cons 3 '()))))
(define empty-alot '())

(checked-average sample-alot)