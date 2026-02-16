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
;(intersection-set '(1 2 3) '(3 4 5))

;exercise 2.59
; implement union-set operation

; List-of-X List-of-X -> List-of-X
(define (union-set set1 set2)
  (cond [(empty? set1) set2]
        [else (adjoin-set (car set1) (union-set (cdr set1) set2))]
        )
  )

;exercise 2.60
;Checks if x is an element of set
(define (element-of-set?.v2 x set)
  (cond [(empty? set) #f]
        [(equal? x (car set)) #t]
        [else (element-of-set?.v2 x (cdr set))]
        )
  )

; like adjoin-set but duplicate is allowed
; Any List-of-X -> List-of-Y
(define (adjoin-set.v2 x set)
  (cons x set)
  )

(define (intersection-set.v2 set1 set2)
  (cond [(or (empty? set1) (empty? set2)) '()]
        [(element-of-set?.v2 (car set1) set2) (cons (car set1) (intersection-set.v2 (cdr set1) set2))]
        [else (intersection-set.v2 (cdr set1) set2)]
        )
  )

(define (union-set.v2 set1 set2)
  (cond [(empty? set1) set2]
        [else (append set1 set2)]
        )
  )

; Number Set -> Set
(define (element-of-set?.v3 x set)
  (cond [(empty? set) #f]
        [(= x (car set))#t]
        [(< x (car set)) #f]
        [else (element-of-set?.v3 x (cdr set))]
        )
  )

(define (intersection-set.v3 set1 set2)
  (cond [(or (empty? set1) (empty? set2)) '()]
        [else (let ((x1 (car set1))
                    (x2 (car set2)))
                (cond [(= x1 x2) (cons x1 (intersection-set.v3 (cdr set1) (cdr set2))) ];if they are both equal, cdr set1 and set2
                      [(< x1 x2) (intersection-set.v3 (cdr set1) set2) ]; if x1 < x2, reduce x1
                      [(< x2 x1) (intersection-set.v3 set1 (cdr set2))]; if x2 < x1, reduce x2
                      )
                )]
        )
  )
(intersection-set.v3 '(1 2 3 4) '(3 4 5 6))