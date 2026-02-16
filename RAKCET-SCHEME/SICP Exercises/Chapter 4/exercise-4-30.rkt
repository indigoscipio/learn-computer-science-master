#lang sicp


; Exercise 4.30

(for-each (lambda (x) (newline) (display x))
          (list 57 32 188))

;b


; exercise 4.30b
(define (p1 x)
  (set! x (cons x '(2)))
  x)

(define (p2 x)
  (define (p e)
    e
    x)
  (p (set! x (cons x '(2)))))

; (p1 1), original eval-sequence
(define (eval-sequence exps env)
  (cond ((last-exp? exps) (eval (first-exp exps) env))
        (else (eval (first-exp exps) env)
              (eval-sequence (rest-exps exps) env))))

; answer
; calls for (p1 1)
; binds x = 1
; sets x to (cons 1 '(2))
; returns x -> (cons 1 '(2)) ;not a compound procedure

; (p2 1), orginal eval-sequence
; calls for (p2 1)
; binds x = 1
; evaluates (p (set! x (cons x '(2))))
; checks for (p e) - a compound procedure
; binds e = (set! x (cons x '(2)))
; then inside (p e)
; performs e and returns x
; but set! never evaluated since the value is not needed (we only return x)
; so return value = 1


; (p1 1), cy eval-sequence
; the same as the original version because set! is forced by eval
; returns (cons 1 '(2))

; (p2 1), cy eval-sequence
; like the original version, but this time (set!) is evaluated since this version forces it
; so it runs set! and returns x both
; returns (cons 1 '(2))

; 4.30c

; answer:
; changing eval-sequence does not affect the beahviour of the example of part a (for each)
; because the first item is already forced even if you dont change the eval sequence
; (proc ..) -> evaluates ( application)
; the forcing happens because (newline) and (display) is primitive procedure so the side effect happens

; 4.30d
; answer
; I'm not sure, i like the simplicity of the original version where only the last expression is forced but the other is evaulated automaticall through proceure clals
; but in cy's approach where its explicit its much safer but forceful but it would defeat the purpose of lazy evaluation
; i think it depends on the meeds of the program at the end