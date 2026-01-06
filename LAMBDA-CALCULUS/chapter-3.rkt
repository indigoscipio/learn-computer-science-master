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





#|
OR
(((cond true) y) x) =>
(((λe1.λe2.λc.((c e1) e2) true) y) x) =>
((λe2.λc.((c true) e2) y) x) =>
(λc.((c true) y) x)  =>
((c true) y) =>
((x true) y)

((or false) true) =>
((λx.λy.((x true) y) false) true) =>
(λy.((false true) y) true) =>
((false true) true) =>
true
|#


#|
AND
λx.λy.(((cond y) false) x) =>

inner body
(((λe1.λe2.λc.((c e1) e2) y) false) x) =>
((λe2.λc.((c y) e2) false) x) =>
(λc.((c y) false) x) =>
((x y) false)

((and true) false) =>
((λx.λy.((x y) false) true) false) =>
(λy.((true y) false) false) =>
((true false) false) =>
((λf.λs.λf false) false) => ... =>
false
|#


#|
NOT
(((cond false) true) x) =>
(((λe1.λe2.λc.((c e1) e2) false) true) x) =>
((λe2.λc.((c false) e2) true) x) =>
(λc.((c false) true) x) =>
((x false) true)
|#



#|
cond:: λe1.λe2.λc.((c e1) e2)
((cond <exp1>) <exp2>) =>
(( λe1.λe2.λc.((c e1) e2) <exp1>) <exp2>) =>
(λe2.λc.((c <exp1>) e2) <exp2>) =>
λc.((c <exp1>) <exp2>)

apply with select-first
λc.((c <exp1>) <exp2>) select-first =>
<exp1>
|#



#|
NUMBERS

1 = successor of 0
2 = successor of 1, successor of (successor of 0)
3 = successor of 2, successor of (successor of 1), successor of (successor of (successor of 0))

one:: (succ zero)
two:: (succ one)
three: (succ two)
zero:: identity - λx.x
succ:: λn.λs.((s false) n)

one == (succ zero) ==
(λn.λs.((s false) n) zero) =>
λs.((s false) zero) =>

two == (succ one) =>
(λn.λs.((s false) n) one) =>
λs.((s false) one) =>
λs.((s false) λs.((s false) zero))

if its select first -> False
if its zero -> select-first -> true


iszero:: λn.(n select-first)
<number> = zero? zero : pred of <number> (peel of the layer)

pred:: λn.(((iszero n) zero) (n select-second))

|#

(define zero (λ (x) x))
(define succ (λ (n) (λ (s) ((s false) n) ) ))