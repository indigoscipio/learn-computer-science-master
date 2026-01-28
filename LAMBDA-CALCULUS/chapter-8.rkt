#lang racket


;e1 : true branch, e2: false branch, c: the selector/decider -> comes at last
; cond:: λe1.λe2.λc.((c e1) e2)
(define lc-cond (λ (e1) (λ (e2) (λ (c) ((c e1) e2) ))) )

; identity:: λf.f
(define identity (λ(f) f))

; apply:: λf.λg.(f g)
(define apply (λ(f)
                (λ (g)
                  (f g))))

; select-first:: λf.λs.f
(define select-first (λ (f) (λ (s) f )))

; select-second:: λf.λs.s
(define select-second (λ (f) (λ (s) s )))

; self-apply:: λs(s s)
(define self-apply (λ (s) (s s) ))

; make-pair: λfirst.λsecond.λfunc((func first) second)
(define make-pair (λ (first) (lambda (second) (lambda (func) ((func first) second) ) ) ))


; not: X ? FALSE : TRUE
; not:: λx.(((cond false) true))
; not:: λx.((x false) true) - simplified version
(define lc-not (λ (x) (((lc-cond false) true) x)))

; and:: X ? Y : FALSE
; and:: λx.λy.(((cond y) false) x)
; and:: λx.λy.((x y) false) - simplified version
(define lc-and (λ (x) (λ (y) (((lc-cond y) false) x) )))

; or:: X ? TRUE : Y
; or:: λx.λy.(((cond true) y) x)
; or:: λx.λy.((x true) y) - simplified version
(define lc-or (λ (x) (λ (y) ((x true) y) ) ) )

; is-zero?:: λn.(n select-first)
(define is-zero? (lambda (n) (n select-first)))


; succ: λn.λs.((s false) n)
(define succ (λ (n) (λ (s) ((s false) n) ) ))

; pred: λn.(((iszero n) zero) (n select-second))
(define pred (λ x x))

; add2:: ...
(define add2 (λ (f) (λ (x) (λ (y) (if (is-zero? y) x (((f f) (succ x) (pred y))) ) )) ))

; recursive f : λf.(λs.f(s s) λs.f(s s))
(define recursive (λ (f) ((λ (s) (f (s s)) ) (λ (s) (f (s s)) ) ) ) )


#|
CHAPTER 8

TERMINATION & NORMAL FORM
normal form = λ expr that cannot be reduced further. example: λx.x λa.(a a) => λa.(a a)
redex form = λ eexpr that can still be reduced

states an expression can reach
weak head normal form
- λ whose body may be a redex. body can be reduced furhter
- computer stops at outrmost layer. if its a function it doesn't care what sinside the body
- i see a function, i'm done

head normal form:
- λ whose body whose body is not a redex. body may stil be a function app
- the perfectionist. goes inside function body and solves every redex until theres nothing to do



-----
NORMAL ORDER
ADD 1 (ADD 1 2)
doesn't see the (ADD 1 2) and doesn't calculate yet. just take the redex and copypaste when its needed
leftmost first

example: def SQUARE = X * X
SQUARE (3 + 4). this evaluates the (3 + 4) two times inside the body

downside: repeated calculation - just swap label without looking inside of it.
instead of solving 3 + 4 = 7, it just writes (3 + 4) ever single time a variable appears
upside: safety - it delays evaluation of applicaiton

-----
APPLICATIVE ORDER
ADD 1 (ADD 1 2)
sees 1 - already a value. sees (add 1 2) - math problem. solve it
innermost first
each arg is evaluated once

racket is applicative. but if has special form
(if #t 10 (/ 1 0))
(define (first-arg a b) a)
(first-arg 10 (/ 1 0))

-----

WHERE APPLICATIVE ORDER FAILS


|#
