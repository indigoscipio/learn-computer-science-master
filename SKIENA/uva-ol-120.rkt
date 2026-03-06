#lang racket

; PANCAKE SORT
;; given a list and n, reverse the first n elements.
(define (flip-top n lst)
  (append (reverse (take lst n)) (drop lst n))
  )
(flip-top 1 '(a b))
(flip-top 2 '(a b c))
(flip-top 3 '(a b c d e f))

; a stack is a list of number
; where pos 1 is the top and pos n is the bottom
(define (pancake-sort pancakes)
  (let* ((largest (apply max pancakes))
         (largest-idx (index-of pancakes largest))
         )
    (cond [(null? pancakes) '()] ;already sorted
          []
          )
    )
  ; find largest pancake
  ; move it to the bottom
  ; ignore that bottom and repeat the process
  
  )
(pancake-sort '(5 1 2 3 4)) ;