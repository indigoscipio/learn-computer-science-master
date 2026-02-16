#lang sicp


(define memo-fib
  (memoize
   (lambda (n)
     (cond ((= n 0) 0)
           ((= n 1) 1)
           (else (+ (memo-fib (- n 1))
                    (memo-fib (- n 2)))))))
  )

(define (memoize f)
  (let ((table (make-table)))
    (lambda (x)
      (let ((previously-computed-result
             (lookup x table)))
        (or previously-computed-result
            (let ((result (f x)))
              (insert! x result table)
              result))))))



; exercise 3.27
; environment diagram breakdown

; (memo-fib 3)
; memo fib returns a lambda memoize with fibonacci procedure as the argument
; new procedure object is created, parent: global env
; global env: memo-fib, memoize
; evaluates (memoize fibonacci function) new E1 frame is created that binds (n = 3) inside the fibonacci function
; E1: n = 3, f = fibonacci procedure

; inside memoize
; we create a new let definition, E2 frame is created
; it returns a lambda function -> gets evaluated and new procedure object is created
; inside the lambda it stores x as a previously computed result
; then it checks if a previously computed result exists
; if so, ???

; explain why memo-fib computs the nth fibonacci number in a number of steps proportional to n
; in the original naive fibonacci function, every call calls 2 recursion
; fib 3 = fib 2 + fib 1, etc
; each call result isn't stored/cached and this wates computatino time

; would scheme still work if we had simply define memo-fib to be (memoize fib)
; ???