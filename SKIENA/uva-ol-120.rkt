#lang racket

;; Reverses the first n elements of the list
(define (flip-top n lst)
  (append (reverse (take lst n)) (drop lst n)))

;; Returns the list minus the last element
(define (bl xs)
  (cond [(null? (cdr xs)) '()]
        [else (cons (car xs) (bl (cdr xs)))]))

(define (pancake-sort pancakes)
  (cond [(null? pancakes) '()]
        [(null? (cdr pancakes)) pancakes]
        [else (let* ([largest (apply max pancakes)]
                     [largest-idx (index-of pancakes largest)]
                     [n (length pancakes)])
                (cond
                  ;; Case 1: Largest is already at the bottom. 
                  ;; We sort the top (n-1) pancakes and then put the largest at the end.
                  [(equal? largest-idx (- n 1)) 
                   (append (pancake-sort (bl pancakes)) (list largest))]
                  
                  ;; Case 2: Largest is at the top. 
                  ;; Flip the whole stack to move it to the bottom.
                  [(equal? largest-idx 0) 
                   (pancake-sort (flip-top n pancakes))]
                  
                  ;; Case 3: Largest is in the middle. 
                  ;; Flip it to the top so Case 2 can handle it in the next step.
                  [else 
                   (pancake-sort (flip-top (+ largest-idx 1) pancakes))]))]))

;; Testing with your example
(pancake-sort '(5 1 2 3 4)) 
;; Output: '(1 2 3 4 5)