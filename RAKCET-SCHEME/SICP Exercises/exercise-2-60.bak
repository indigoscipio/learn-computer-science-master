#lang racket


; Any List-of-X -> Boolean
; Checks if x is an element of set
(define (element-of-set? x set)
  (cond [(empty? set) #f]
        [(equal? x (car set)) #t]
        [else (element-of-set? x (cdr set))]
        )
  )
;(element-of-set? 2 '(1 2 3 4 5 6))

; Any List-of-X -> List-of-Y
; Adjoins item x into set if its not included in the set
(define (adjoin-set x set)
  (cond [(element-of-set? x set) set]
        [else (cons x set)])
  )


; List-of-X List-of-X -> List-of-X
(define (intersection-set set1 set2)
  (cond [(or (empty? set1) (empty? set2)) '()]
        [(element-of-set? (car set1) set2) (cons (car set1) (intersection-set (cdr set1) set2))]
        [else (intersection-set (cdr set1) set2)]
        )
  )
(intersection-set '(1 2 3) '(3 4 5))

;exercise 2.59
; implement union-set operation

; List-of-X List-of-X -> List-of-X
(define (union-set set1 set2)
  (cond [(empty? set1) set2]
        [else (adjoin-set (car set1) (union-set (cdr set1) set2))]
        )
  )
(union-set '(1 2 3 4) '(4 5 6 7))
(union-set '() '(1 2 3))

;exercise 2.60
