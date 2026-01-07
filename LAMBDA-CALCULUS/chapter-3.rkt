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
<number> = zero ? zero : pred of <number> (peel of the layer)

pred:: λn.(((iszero n) zero) (n select-second))


SHORTHAND OPERATORS
def cond e1 e2 c = c e1 e2
def true first second = first
def false first second = second
def not x = x false true
def and x y = x y false
def or x y = x true y
def pred n =
if iszero n
then zero
else n select_second


|#

(define zero (λ (x) x))
(define succ (λ (n) (λ (s) ((s false) n) ) ))


#|
Exercises
3.1 The boolean operation implication is defined by the following 
truth table:

x
#f
#f
#t
#t

y
#f
#t
#f
#t

x implies y
#t
#t
#f
#t

define a λcalcluse representation for implication
def implies λx.λy...
show that the definition satisfies the truth table for all boolean values of x and y

answer:
ok so in implication from my understanding
if y is true x -> y is always true except for if x and y are false.

lets try to define this with cond first
def implies x y
if x is false
then #true
else y

so in lambda calculus we can represent this as
λx.λy.((x y) true)
; if x is true -> grab whatever y is
; if x is false -> then return true

now check if the definition satisfies
imples false false
((λx.λy.((x y) true) false) false) =>
(λy.((false y) true) false) =>
((false false) true) =>
((λf.λs.s false) true) =>
(λs.s true) =>
true

implies false true
((λx.λy.((x y) true) false) true) =>
(λy.((false y) true) true) =>
((false true) true) => ... =>
true

implies true false
((λx.λy.((x y) true) true) false) =>
(λy.((true y) true) false) =>
((true false) true) => ... =>
false

implies true true
((λx.λy.((x y) true) true) true) =>
(λy.((true y) true) true) =>
((true true) true)  => ... =>
true

----------------------

3.2
the boolean operation equivalence is defined by the following truth table

x   y   x equiv y
#f  #f  #t
#f  #t  #f
#t  #f  #f
#t  #t  #t

define a λ calc representation for equivalence
def equiv = λx.λy...
show the definition satisfies thetruth table for all boolean values of x and y

answer:
ok it seems that the case where x equiv y is true is when both x and y has the same boolean parity
(eg both returns false or both returns true)


and the time x equiv y returns false is whenever x is true and y is false
or x is false and y is true, in other words both x and y isn't of the same boolean (both true or both false)

so lets start with the conditionals first. we can define the shorthand as

def equiv x y
if x is true
then y
else (not y)


now for the lambda calculus representation
def equiv = λx.λy.((x y) (not y)) =>
λx.λy.((x y) (λx.(((cond false) true)) y)) =>
λx.λy.((x y) ((y false) true))



now check each one by one
EQUIV FALSE FALSE
((λx.λy.((x y) ((y false) true)) false) false) =>
(λy.((false y) ((y false) true))  false) =>
((false false) ((false false) true))   =>

application argument
((false false) true) =>
true

then finally
((false false) true) =>
true, matches table


EQUIV FALSE TRUE
((λx.λy.((x y) ((y false) true)) false) true) =>
(λy.((false y) ((y false) true))  true) =>
((false true) ((true false) true))  =>

application argument
((true false) true) =>
false

finally
((false true) false) =>
false, matches table


EQUIV TRUE FALSE
((λx.λy.((x y) ((y false) true)) true) false) =>
(λy.((true y) ((y false) true))  false) =>
((true false) ((false false) true)) =>

argument
((false false) true) =>
true

then finally
((true false) true) =>
false, matches tbale


EQUIV TRUE TRUE
((λx.λy.((x y) ((y false) true)) true) true) =>
(λy.((true y) ((y false) true))  true) =>
((true true) ((true false) true))  =>

argument
((true false) true) =>
false

((true true) false) =>
true, therefore matches

3.3
for each of the following pairs, show functions (i) and (ii) are equivalent for all
boolean values of their args
a
i. 
ii.

|#