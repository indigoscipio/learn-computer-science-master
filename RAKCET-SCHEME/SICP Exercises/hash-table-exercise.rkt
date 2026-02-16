#lang racket


; Create a empty hash table
;; A Table is one of:
;; - '()
;; - (cons (cons Key Value) Table)
;; where Key = (list Symbol Symbol)   ; e.g., ('deriv '+)
;; and Value = Procedure
(define empty-table '())

; my hash table wihtout hash-set
; puts an item into the hash table
; Key Value Table -> Table
(define (my-put key value table)
  (cons (cons key value) table)
  )

(define my-table (my-put 'add1 (lambda (x) (+ x 1)) empty-table) )
(define my-table2 (my-put 'sub1 (lambda (x) (- x 1)) my-table) )
my-table2

; Key Table -> MaybeValue
(define (my-get key table)
  (cond [(empty? table) #f]
        [(eq? key (car (car table))) (cdr (car table))]
        [else (my-get key (cdr table))] ;check if first item's key matches given key
        )
  )
((my-get 'sub1 my-table2) 5)