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

#|
====== OPERATION - ADDITION ======

def add x y =
if iszero y
then x
else add (succ x) (pred y)

(add one two) =>
(add (succ one) (pred two)) =>
(add (succ (succ one)) (pred (pred two)) ) =>
(succ (succ one)) == three

how can a function call itself if it doesn't have a name yet?
hand out 2 things: the current work and the copy of instrunction for the next person
to "carry" the funcion's own code as an argument so it remembers

so the fix

def add2 f x y
if iszero y
then x
else f f (succ x)(pred y)

def add = add2 add2
whici is the same as
(add2 add2) - still waiting for the 2 rest arguments to be used

add one two ==
λx.λy.
if iszero y
then x
else (add2 add2 (succ x) (pred y) one two) =>
... =>

if iszero two
then one
else add2 add2 (succ one) (pred two) =>

λf.λx.λy.
if iszero y
then x
else (add2 add2 (succ x) (pred y) add2 (succ one) (pred two)) =>
...

if iszero (pred two)
then (succ one)
else add2 add2 (succ (succ one)) (pred (pred two)) =>

λf.λx.λy.
if iszero y
then x
else (add2 add2 (succ x) (pred y) add2 (succ (succ one)) (pred (pred two))) =>
...

if iszero (pred (pred two))
then (succ (succ one))
else add2 add2 (succ (succ (succ one))) (pred (pred (pred two))) =>

(succ (succ one)) == three

====== OPERATION - MULTIPLICATION ======

def mult x y
if iszero y
then zero
else add x (mult x (pred y))

mult three two => ... =>
add three (mult three (pred two)) -> ... ->
add three (add three (mult three (pred (pred two)))) ->
add three (add three zero) -> ... ->
add three three => ... =>
six

def mult1 f x y
if iszero y
then zero
else add x (f x (pred y))

def mult = recursive mult1

def recursive f = f <'f' and copy>

|#