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
implies:: λx.λy.((x y) true)
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
i. λx.λy.(and (not x) (not y))
ii. λx.λy.(not (or x y))

b
i. implies
ii. λx.λy.(implies (not y) (not x))

c
i. not
ii. λx.(not (not (not x))) 

d
i. implies
ii. λx.y.(not (and x (not y)))

e
i. equiv
ii. λx.λy.(and (implies x y) (implies y x))


answer:
===============
reference/note
implies:: λx.λy.((x y) true)
not:: λx.((x false) true) - simplified version
and:: λx.λy.((x y) false) - simplified version
or:: λx.λy.((x true) y) - simplified version
equiv:: λx.λy.((x y) ((y false) true))

a
FALSE FALSE
i.λx.λy.(and (not x) (not y))
apply args
((λx.λy.(and (not x) (not y)) false) false) =>
(λy.(and (not false) (not y)) false) =>
(and (not false) (not false))  =>
(and (λx.((x false) true) false) (λx.((x false) true) false)) =>

1st arg (not false)
(λx.((x false) true) false) =>
((false false) true) =>
true

2nd arg (not false) => true

(and true true) =>
((λx.λy.((x y) false) true) true) =>
((true true) false) =>
true

ii.
((λx.λy.(not (or x y)) false) false) =>
(not (or false false)) =>

(not (λx.λy.((x true) y) false false)) =>
(not ((false true) false)) =>
(not false) =>
(λx.((x false) true) false) =>
((false false) true)  =>
true

therefore both are equal

----- 

FALSE TRUE
i.
((λx.λy.(and (not x) (not y)) false) true) =>
(and (not false) (not true)) =>

(not false) =>
(λx.((x false) true) false) =>
((false false) true) =>
true

not true => ... => false

(and true false) =>
(λx.λy.((x y) false) true false) =>
((true false) false) =>
false


ii.
((λx.λy.(not (or x y)) false) true) =>
(not (or false true)) =>
(not (λx.λy.((x true) y) false true)) =>
(not ((false true) true)) =>
(not true) => ... => false

therefore two are equal.

-----

TRUE FALSE
i.
((λx.λy.(and (not x) (not y)) true) false) =>
(and (not true) (not false)) => ...
(and false true) => ... =>
false
 
ii.
((λx.λy.(not (or x y)) true) false) =>
(λy.(not (or true y)) false) =>
(not (or true false)) => ... =>
(not true) => ...
false

therefore two are equal.

-----

TRUE TRUE
i.
((λx.λy.(and (not x) (not y)) true) true) =>
(and (not true) (not true)) => ... =>
(and false false) =>
false

ii.
((λx.λy.(not (or x y)) true) true) =>
(λy.(not (or true y)) true) =>
(not (or true true)) => ... =>
(not true) =>
false

therefore the two are equal.


============================= end of a =============================

b
i. implies
ii. λx.λy.(implies (not y) (not x))

FALSE FALSE
i. ((λx.λy.((x y) true) false) false) =>
((false false) true) =>
true

ii. ((λx.λy.(implies (not y) (not x)) false) false) =>
(implies (not false) (not false)) => ...
(implies true true) =>
(λx.λy.((x y) true) true true) =>
((true true) true) =>
true

therefore the two are equal

-----

FALSE TRUE
i. ((λx.λy.((x y) true) false) true) =>
((false true) true) => 
true

ii. ((λx.λy.(implies (not y) (not x)) false) true) =>
(implies (not true) (not false)) => ...
(implies false true) => ...
(λx.λy.((x y) true) false true) => ...
((false true) true) => ...
true

therefore the two side are equal


-----

TRUE FALSE
i. ((λx.λy.((x y) true) true) false)
((true false) true) =>
false

ii. ((λx.λy.(implies (not y) (not x)) true) false) =>
(implies (not false) (not true)) => ...
(implies true false) =>
(λx.λy.((x y) true) true false) =>
((true false) true) =>
false

therefore the 2 are equal

-----

TRUE TRUE
i. ((λx.λy.((x y) true) true) true) =>
((true true) true) => true

ii. ((λx.λy.(implies (not y) (not x)) true) true) =>
(implies (not true) (not true)) =>
(implies false false) =>
(λx.λy.((x y) true) false false) =>
((false false) true) =>
true

therefore the 2 are equal


============================= end of b =============================

c
FALSE
i. (not false) =>
(λx.((x false) true) false) =>
((false false) true) =>
true

ii. (λx.(not (not (not x)))  false) =>
(not (not (not false))) =>
(not (not true)) =>
(not false) => ... =>
true

therefore the two are equal

-----


TRUE
i. (not true) =>
(λx.((x false) true) true) =>
((true false) true) => ...
false

ii. (λx.(not (not (not x))) true) =>
(not (not (not true))) =>
(not (not false)) =>
(not true) => ... =>
false

therefore the two are qual


============================= end of c =============================

d
FALSE FALSE
i. (implies false false) =>
(λx.λy.((x y) true) false false) =>
((false false) true) =>
true

ii. ((λx.y.(not (and x (not y))) false) false) =>
(not (and false (not false))) =>
(not (and false true)) => ... =>
(not false) => true

therefore the 2 is equal

-----

TRUE TRUE
i. (implies true true) =>
(λx.λy.((x y) true) true true) =>
((true true) true) =>
true

ii. ((λx.y.(not (and x (not y))) true) true) =>
(not (and true (not true))) =>
(not (and true false)) => ... =>
(not false) => true

therefore the 2 is equal

-----

TRUE FALSE
i. (implies true false) =>
(λx.λy.((x y) true) true false) =>
((true false) true) =>
false

ii. ((λx.y.(not (and x (not y))) true) false) =>
(not (and true (not false))) =>
(not (and true true)) => ... =>
(not true) => false

therefore the 2 side is equal

-----

FALSE TRUE
i. (implies false true) =>
(λx.λy.((x y) true) false true) =>
((false true) true) =>
true


ii. ((λx.y.(not (and x (not y))) false) true) =>
(not (and false (not true))) =>
(not (and false false)) => ... =>
(not false) => true

therefore the 2 side is equal.



============================= end of d =============================

e
TRUE TRUE
i. (equiv true true) =>
((λx.λy.((x y) ((y false) true)) true) true) =>
((true true) ((true false) true)) =>
((true true) false ) ->
true

ii. ((λx.λy.(and (implies x y) (implies y x)) true) true) =>
(and (implies true true) (implies true true)) =>
(and true true) => ...
true

therefore the 2 sides are equal

-----

FALSE FALSE

i. (equiv false false) =>
((λx.λy.((x y) ((y false) true)) false) false) =>
((false false) ((false false) true)) =>
((false false) true ) ->
true


ii. ((λx.λy.(and (implies x y) (implies y x)) false) false) =>
(and (implies false false) (implies false false)) =>
(and true true) => ...
true

therefore the two sides is equal

-----

FALSE TRUE
i. (equiv false true) =>
((λx.λy.((x y) ((y false) true)) false) true) =>
((false true) ((true false) true)) =>
((false true) false ) ->
false

ii. ((λx.λy.(and (implies x y) (implies y x)) false) true) =>
(and (implies false true) (implies true false)) =>
(and true false) => ...
false

therefore the two side are equal


-----

TRUE FALSE
i. (equiv true false) =>
((λx.λy.((x y) ((y false) true)) true) false) =>
((true false) ((false false) true)) =>
((true false) true ) ->
false

ii. ((λx.λy.(and (implies x y) (implies y x)) true) false) =>
(and (implies true false) (implies false true)) =>
(and false true) => ...
false

therefore the 2sides are equal

============================= end of e =============================



3.4 show that
λx.(succ (pred x))

and

λx.(pred (succ x))

are equivalent for arbitrary nonzero integer args
explain why they are not equivalent for a zero argument

answer:
so here essentially the 1st one it extracts the sucessor then find the pred
and the 2nd one it finds sucessor and find the pred

so if we have nonzero number like 2
(succ 2) = 3 => (pred 3) = 2
(pred 2) = 1 => (succ 1) => 2
so the result should be the same 


let n = 1
1st one
(λx.(succ (pred x)) one) =>
(succ (pred one)) =>
(succ (λn.(((iszero n) zero) (n false))  one)) =>
(succ (((iszero one) zero) (one false)) ) => ... =>

(iszero one) =>
(one true) ->
(λs.((s false) zero) true) =>
((true false) zero)  =>
false

( (false zero) (one false)) ) =>
(one false) =>
(λs.((s false) zero) false) =>
((false false) zero) =>
zero

(succ zero) =>
( λn.λs.((s false) n) zero)
λs.((s false) zero) =>
one

-----

2nd one
(λx.(pred (succ x)) one) =>
(pred (succ one)) =>
(pred (λn.λs.((s false) n) one)) =>
(pred λs.((s false) one)) =>
(λn.(((iszero n) zero) (n select-second))  λs.((s false) one)) =>
(((iszero λs.((s false) one)) zero) (λs.((s false) one) select-second)) =>

left
( (iszero λs.((s false) one)) zero) =>

(λn.(n true) λs.((s false) one)) =>
(λs.((s false) one) true) =>
((true false) one) =>
false

(false zero) =>
false

((false zero) (two select-second)) =>
 (two select-second) =>
(λs.((s false) one) select-second) =>
((select-second false) one) =>
one

---


iszero:: λn.(n true)
zero:: λx.x
succ:: λn.λs.((s false) n)
pred:: λn.(((iszero n) zero) (n select-second)) 
one:: (succ zero) =>
(λn.λs.((s false) n) zero) =>
λs.((s false) zero)


now with n = 0

λx.(succ (pred x))
pred 0 = 0 -> succesor 0 = 1

λx.(pred (succ x))
succ 0 = 1 -> pred 1 = 0

successor wraps,
pred unwraps

1st one
(λx.(succ (pred x)) zero) =>
(succ (pred zero)) =>
(succ (λn.(((iszero n) zero) (n select-second)) zero) ) =>

(λn.(((iszero n) zero) (n select-second)) zero) =>

(((iszero zero) zero) (zero select-second)) =>

((iszero zero) zero)  =>
((λn.(n true) zero) zero) =>
((zero true)  zero) =>
(( λx.x true)  zero) =>
(true zero)

((true zero) (zero select-second)) =>
zero

(succ zero) =>
one

-----

2nd part
(λx.(pred (succ x)) zero) =>
(pred (succ zero)) =>
(pred (λn.λs.((s false) n) zero)) =>

right side
λs.((s false) zero) =>
one

(pred one) =>
(λn.(((iszero n) zero) (n select-second)) one) =>
(((iszero one) zero) (one select-second)) =>

we know one is not zero so
(iszero one) =>
(one true) =>
(λs.((s false) zero) true) =>
((true false) zero) =>
false

((false zero) (one select-second)) =>
((λf.λs.s zero) (one select-second)) =>
(λs.s (one select-second)) =>
(one select-second) =>
(λs.((s false) zero) select-second) =>
((false false) zero)  =>
zero


|#