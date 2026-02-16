#lang racket

;exercise 2.33


(define (accumulate op initial sequence)
  (define (accumulate-helper sequence acc)
    (if (null? sequence)
        acc
        (accumulate-helper (cdr sequence) (op (car sequence) acc))))
  (accumulate-helper sequence initial))


;fill in missing expression of some basic list-manipulation operation as accumulations
;(define (map p sequence)
;  (accumulate (lambda (x y) ⟨??⟩) nil sequence))
(define (map p sequence)
  (accumulate (lambda (x y) (cons (p x) y) ) '() sequence))
(map sqr '(1 2 3))

;(define (append seq1 seq2)
; (accumulate cons (???) (???) ))
(define (append seq1 seq2)
  (accumulate cons seq2 (accumulate cons '() seq1))
  )

;(define (length sequence)
;  (accumulate <???> 0 sequence))
(define (length sequence)
  (accumulate (lambda (item acc) (+ 1 acc) ) 0 sequence)
  )

; Exercise 2.4

; Number List-of-Number -> Number
(define (horner-eval x coefficient-sequence)
  (accumulate (lambda (this-coeff higher-terms) (+ (* higher-terms x) this-coeff) ) 0 coefficient-sequence)
  )
(horner-eval 2 (list 1 3 0 5 0 1))

;exercise 2.35
; redefine count-leaves from section 2.2.2 as an accumulation