#lang racket

; A Record is an example database
; List-of-[List-of Number String]
(define record0 (list 1 "Johnny White"))
(define record1 (list 2 "Billie Goode"))
(define record2 (list 3 "Azusa Nakano"))

; A Database record is a List-of-Record
(define db-list (list record0 record1 record2))

; A Key is a Number


; Record -> Key
; Extracts the key of a record
(define (key record)
  (car record)
  )

; Key Database -> MaybeRecord (Record or #false)
(define (lookup given-key set-of-records)
  (cond ((null? set-of-records) false)
        ((equal? given-key (key (car set-of-records)))
         (car set-of-records))
        (else (lookup given-key (cdr set-of-records)))))
(lookup 1 db-list)

;exercise 2.66
; lookup procedure for the case where set of records is structured as binary tree
; ordered by the numerical value of the keys

; Number Tree Tree -> Tree
(define (make-tree entry left right)
  (list entry left right)
  )

; Tree -> Number
(define (entry tree) (car tree))

; Extracts the left branch of a tree
; Tree -> Tree
(define (left-branch tree) (cadr tree))


; Extracts the left branch of a tree
; Tree -> Tree
(define (right-branch tree) (caddr tree))


; A Database as tree data structure
(define db-tree
  (make-tree (list 5 "Midname Midlast")
             (make-tree (list 1 "First Last") '() '())
             (make-tree (list 9 "Lastname Final") '() '())))


; Key Tree -> MaybeRecord (Record or #f)
(define (lookup.v2 given-key set-of-records)
  (cond [(empty? set-of-records) #f]
        [(= given-key (key (entry set-of-records))) (entry set-of-records) ]
        [(< given-key (key (entry set-of-records))) (lookup.v2 given-key (left-branch set-of-records) ) ]
        [else (lookup.v2 given-key (right-branch set-of-records))]
        )
  )
(lookup.v2 5 db-tree)