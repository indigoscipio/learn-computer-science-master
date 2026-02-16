;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise-160) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; Son
(define es '())
 
; Number Son -> Boolean
; is x in s
(define (in? x s)
  (member? x s))

(define sample-set (cons 1 (cons 1 (cons 3 '()))))
(member? 1 sample-set)

; Number Son.L -> Son.L
; removes x from s 
(define s1.L
  (cons 1 (cons 1 '())))
 
(check-expect
  (set-.L 1 s1.L) es)
 
(define (set-.L x s)
  (remove-all x s))


;set+.L = Number List-Of-String -> List-Of-String
;adds a number to a set
(define (set+.L x s)
  (cond [(empty? s) (cons x)]
        [(cons? s) (cons x s)])
  )
(set+.L 5555 sample-set)

(define (set+.R x s)
  (cond [(empty? s) (cons x)]
        [(member? x s) s]
        [else (cons x s)])
  )
(set+.L 1 sample-set)
(set+.R 1 sample-set)