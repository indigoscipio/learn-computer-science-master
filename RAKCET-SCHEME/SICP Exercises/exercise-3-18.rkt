#lang sicp


; Exercise 3.16
(define (count-pairs x)
  (if (not (pair? x))
      0
      (+ (count-pairs (car x))
         (count-pairs (cdr x))
         1)))

;(count-pairs (cons 3 (cons 4 (cons 7 '()))))

; show that this procedure is not correct
; and draw box and pointer


; lets say we call (count-pairs (cons 3 (cons 4 (cons 7 '()))))
; first, bind x = (cons 3 (cons 4 (cons 7 '())))
; x = [3 | *] -> [4 | *] -> [7 | null]

; inside count pairs, evaluate the conditionals.
; is (cons 3 (cons 4 (cons 7 '()))) not a pair? false - it's a pair
; run the recursion
; (+ (count-pairs 3)(count-pairs (' 4 7)) 1)
; (+ 0 (count-pairs (cons 4 (cons 7 '()))) 1)

; 2nd iteration
; new x = (cons 4 (cons 7 '()))
; is (cons 4 (cons 7 '())) not a apir? false - it's a pair
; run the recusrion
; (+ 0 (+ 0 (count-pairs (cons 7 '())) 1)) 1)

; and continues until the last item which is 7
; I'm not sure where the procedure goes wrong here??

#|
(count-pairs (cons (cons 'a 'b) (cons 'c 'd)))
(count-pairs '())

(define x (cons 'a 'b))
(define y (cons x (cons x '())))

; x = [a | *] -> [b | null]
; y = [x | *] -> [x | null]
; y = (cons '(a b) '(a b))
(count-pairs y)   ; returns 4
|#

; Bens' list is incorrect because it wanst designed for shared list
; using unshared list works but when its linked its counted twice


;Exercise 3.17
; List-of-Pairs -> Number
; counts the total number of pairs x
(define (count-pairs.v2 x)
  
  (let ((visited '()))
    (cond [(not (pair? x)) 0]
          [(memq x visited) 0]
          [else (set! visited (cons x visited))
                (+ (count-pairs.v2 (car x))
                   (count-pairs.v2 (cdr x))
                   1)
                ]
          )
    )
  #|
  (define (count-pairs-iter x visited)
    (cond [(not (pair? x)) 0]
          [(member x visited) 0]
          [else (let ((new-visited (cons x visited)))
                  (+ (count-pairs-iter (car x) new-visited )
                     (count-pairs-iter (cdr x) new-visited )
                     1)
                  ) ]
          )
    )
      |#
  ;initiate iter with pairs = x and visited = '()
  )


; Exercise 3.18

;; List-of-any -> Boolean
;; determines if a list contains a cycle using two pointers
(define (contains-cycle? x)
  (define (iter l seen)
    (cond [(null? l) #f]                          ; If the list is empty, no cycle.
          [(memq (car l) seen) #t]                ; If the element is already in seen, a cycle is detected.
          [else (iter (cdr l) (cons (car l) seen))] ; Otherwise, continue with the rest of the list and updated seen.
          )
    )
  (iter x '()))                                     ; Start the iteration with an empty 'seen' list.


; Test cases:
(contains-cycle? '(a b c d c))      ; Should return #f (no cycle)
(contains-cycle? '(a b c a b c a))  ; Should return #t (cycle exists)

