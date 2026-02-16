;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise-147) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
;NEList-of-booleans is one of
;(cons Boolean '()) - a single boolean list
;(cons Boolean NEList-of-booleans): a list with one or more booleans


(define sample-neb (cons #false (cons #true (cons #false (cons #true '())))) )
(define single-neb (cons #false '()))


(define (all-true? neb)
  (cond 
    [(empty? (rest neb)) (first neb)] ; Base case: An empty list means all are true
    [(false? (first neb)) #false] ; If the first element is false, return #false
    [else (all-true? (rest neb))])) ; Recursively check the rest of the list



(define (one-true? neb)
  ; base case: return the last list if theres only 1 remaiing
  (cond [(empty? (rest neb)) (first neb)]
        ; if one of the item is true, stop and return true
        [(equal? (first neb) #true) #true ]
        ;otherwise loop
        [else (one-true? (rest neb))] )
  )
(one-true? sample-neb)