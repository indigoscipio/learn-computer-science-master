#lang simply-scheme

; PATTERN MATCHER

; * -> any number of words
; & -> any number of words (at least 1)
; ! -> exactly one word
; ? -> at most one word

; sent-equal?
(define (sent–equal? sent1 sent2)
  (cond ((empty? sent1)
         (empty? sent2))
        ((empty? sent2) #f)
        ((equal? (first sent1) (first sent2))
         (sent–equal? (bf sent1) (bf sent2)))
        (else #f)))

(define (match? pattern sent)                ;; first version: ! only
  (cond ((empty? pattern)(empty? sent))
        ((equal? (first pattern) '?)
         (if (empty? sent)
             (match? (bf pattern) '())
             (or (match? (bf pattern) (bf sent))
                 (match? (bf pattern) sent))))
        ((empty? sent) #f)
        ((equal? (first pattern) '!) (match? (bf pattern) (bf sent)))
        ((equal? (first pattern) (first sent)) (match? (bf pattern) (bf sent)))
        (else #f)))
(match? '(!) '(hey 1))

#|
EXERCISE 16
|#