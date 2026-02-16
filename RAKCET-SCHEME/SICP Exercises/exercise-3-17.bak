#lang sicp


; Exercise 3.16
(define (count-pairs x)
  (if (not (pair? x))
      0
      (+ (count-pairs (car x))
         (count-pairs (cdr x))
         1)))

(count-pairs (cons 3 (cons 4 (cons 7 '()))))

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

(count-pairs (cons (cons 'a 'b) (cons 'c 'd)))
(count-pairs '())

(define x (cons 'a 'b))
(define y (cons x (cons x '())))

; x = [a | *] -> [b | null]
; y = [x | *] -> [x | null]
; y = (cons '(a b) '(a b))
(count-pairs y)   ; returns 4

; Bens' list is incorrect because it wanst designed for shared list
; using unshared list works but when its linked its counted twice