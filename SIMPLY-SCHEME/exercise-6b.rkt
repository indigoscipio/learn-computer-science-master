#lang simply-scheme

#|
;601
(define (square n) (* n n))

(cond (empty? 3) (square 7)
      (else 9))
; returns 3, since everything that isn't #f is handeled as #t

(or #f #f #f #t)
; #t

(and #f #f #f #t)
;#f

(or (= 2 3) (= 4 3))
; #f

(not #f)
;#t

(or (not (= 2 3)) (= 4 3))
;#t

(or (and (= 2 3) (= 3 3)) (and (< 2 3) (< 3 4)))
;#t

(define (sign number)
  (cond [(> number 0)'positive]
        [(= number 0) 'zero]
        [else 'negative])
  )
|#

;==========================

;6.5 Write a procedure european–time to convert a time from
;American AM/PM notation into European 24-hour 
;notation. Also write american–time, which does the opposite:

; List-of Number Symbol (AM/PM)
(define (european-time time)
  ; check the meridian. if it's am -> 0 - 12. if its pm -> 13 - 23 
  (cond [(and (equal? (car time) 12) (equal? (cadr time) 'am)) 24]
        [(equal? (cadr time) 'pm) (+ (remainder (car time) 12) 12)]
        [else (remainder (car time) 12)])
  )
(european-time '(8 am)) ; 8
(european-time '(4 pm)) ;16
(european-time '(12 am)) ; 24

; Number -> (listof Number Symbol)
(define (american-time time)
  (cond [(< time 12) 
         (se (if (= (remainder time 12) 0) 12 (remainder time 12)) 
             'am)]
        [else 
         (se (if (= (remainder time 12) 0) 12 (remainder time 12)) 
             'pm)]))
(american-time -421) ; 9 PM
(american-time 12) ;12 PM