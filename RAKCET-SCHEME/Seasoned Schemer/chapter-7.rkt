#lang racket

(define (lots n)
  (cond [(zero? n) '()]
        [else (cons 'egg (lots (sub1 n)))]
        )
  )

; Adds an atom to the end of the list
(define (add-at-end l)
  (cond [(empty? l) (cons 'added '())]
        [else (cons (car l) (add-at-end (cdr l)))])
  )

#|
(define (kons kar kdr)
  (lambda (selector) (selector kar kdr) )
  )
((lambda (a d) a) 6 2) 

(define (kar c)
  (c (lambda (a d) a))
  )

(define (kdr c)
   (c (lambda (a d) d)) 
  )
(kar (kons 6 2))
(kdr (kons 6 8))
|#

(define (bons kar)
  (let ((kdr '()))
    (lambda (selector) (selector (lambda (x) (set! kdr x)) kar kdr ))
    )
  )

(define (kar c)
  (c (lambda (a b c) b) )
  )

(define (kdr c)
  (c (lambda (a b c) c))
  )
(bons 'egg)

(define (set-kdr c x)
  ((c (lambda (a b c) a)) x)
  )

(define (kons a d)
  (let ((c (bons a)))
    (set-kdr c d)
    )
  )