#lang sicp




;Exercise 3.19

;; List-of-any -> Boolean
;; Detects if the list contains a cycle using constant space
(define (contains-cycle? x)
  (define (iter slow fast)
    (cond [(or (null? fast) (null? (cdr fast))) #f]
          [(eq? slow fast) #t]
          [else (iter (cdr slow) (cdr (cdr fast)))]
          )) ;; Move slow one step, fast two steps

  (if (or (null? x) (null? (cdr x)))
      #f
      (iter x (cdr x))
      )

  )  ;; Start both pointers at the head of the list


; Test cases:
(define cycle-test (list 'a 'b 'c))
(contains-cycle? cycle-test)
(set-cdr! (cddr cycle-test) cycle-test)  ; Make 'c' point back to 'a'
(contains-cycle? cycle-test)