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
;(map sqr '(1 2 3))

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
;(horner-eval 2 (list 1 3 0 5 0 1))

;exercise 2.35
; redefine count-leaves from section 2.2.2 as an accumulation
; A Tree is either of the following:
; A Number
; A List-of-Tree

; Tree -> Number
(define (count-leaves-old x)
  (cond ((null? x) 0)
        ((not (pair? x)) 1)
        (else (+ (count-leaves-old (car x))
                 (count-leaves-old (cdr x))))))

; List-of-[List-of-X] -> List-of-X
(define (enumerate-leaves t)
  (cond [(empty? t) '()]
        [(not (pair? t)) (list t) ]
        [else (append (enumerate-leaves (car t)) (enumerate-leaves (cdr t)) ) ]
        )
  )
;(enumerate-leaves '(1 2 3 (4 6 7) 5))

; Tree -> Number
(define (count-leaves t)
  (accumulate + 0 (map (lambda (subtree) (cond [(not(pair? subtree)) 1]
                                               [else (count-leaves subtree)]) ) t) )
  )
;(count-leaves '(1 (2 (3 4)) 5))

; [X -> Y] List-of-Y List-of-[List-of-X] -> List-of-Y
; computes the nth item in a list of lists and sums them together
(define (accumulate-n op init seqs)
  (cond [(empty? (car seqs)) '()]
        [else 
         (cons (accumulate op init (map (lambda (seq) (first seq) ) seqs) )
               (accumulate-n op init (map rest seqs))
               )
         ])
  )
(define list2 '( (1 2 3) (4 5 6) (5 6 7) ))
(map rest list2)
(accumulate-n + 0 '( (1 2 3) (4 5 6) (7 8 9) (10 11 12) )) ; should return (22 26 30)

;exercise 2.37