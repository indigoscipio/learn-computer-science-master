#lang racket


;e1 : true branch
;e2: false branch
;c: the selector/decider -> comes at last

; cond:: λe1.λe2.λc.((c e1) e2)
(define lc-cond (λ (e1) (λ (e2) (λ (c) ((c e1) e2) ))) )

; true:: select-first 
; false:: select-second

; identity function: λx.((x true) false)

; not:: λx.(((cond false) true) )
(define lc-not (λ (x) (((lc-cond false) true) x)))



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