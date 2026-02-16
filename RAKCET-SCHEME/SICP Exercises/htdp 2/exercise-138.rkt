;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise-138) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; A List-of-amounts is one of: 
; – '()
; – (cons PositiveNumber List-of-amounts)
(define sample-loa (cons 2141 (cons 999 (cons 55 (cons 22 '())))))



; List-of-amounts -> Number
; sum is a function that takes a list of amounts and computs its sum
(define (sum loa)
  (cond [(empty? loa) 0]
        ;check if it's a list, if so sum it with the previous amount
        [(cons? loa) (+ (first loa) (sum (rest loa))) ]
        )
  )
(sum sample-loa)