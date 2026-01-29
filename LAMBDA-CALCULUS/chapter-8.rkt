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
if we treat "if" as a normla function it fails
if x then 10 else (/ 1  0) - else case is evaluated as normal function

a language cannot always be 100% consistent - it must have special form
needs a bit of laziness. applicative order is imperfect

-----
DELAYING EVALUATION

standard arg = Steak = evaluated immediately
delayed arg = wrap into lambda = (lambda () Steak)

the secret: the thunk
function that doesn't take any argument (technicaly takes 1 arg but it ignores that arg)
this is how eager evaluation delays computation

cond λdummy.<true choice> λdummy.<false choice> <condition>

-----
TURING HALT & CHURCH
imagine you have a program that take a set of instruction that can detect other program:
- that program finishes a task and stop
- that program gets stuck in a loop

turing said that you can never write a program that can look at another program and tell you if
it will ever stop. like a prediction machine.

CHURCH-ROSSER I
every expression has a unique normal form
if expr is reduced using 2 different eval order and reductions terminate, the result are the same normal form
order of evaluation doesn't matter
2 + (3+4) - you will eventually finish

CHURCH-ROSSER II
if there is any way to reach the finish line, normal order will find it.

-----
INFINITE OBJECTS

constructing infinite list
numblist n = cons n (numblist (succ n))
in eager, the arg woud be calculated infinitely
in lazy, this works

-----
LAZY EVALUATION
a smart lazy. mix of eager + normal order evaluation
why its' smart
- keeps track of what's needed - stores in memory - no need to recalculate eveytime it appears again

|#


; =========================================

#|
EXERCISE 8.1
Evaluate the following expressions using normal order, applicative 
order and lazy evaluation. Explain any differences in the final result 
and the number of reductions in each case: 


a. λs.(s s) (λf.λa.(f a) λx.x λy.y)
b. λx.λy.x λx.x (λs.(s s) λs.(s s)) 
c. λa.(a a) (λf.λs.(f (s s)) λx.x)

answer:
a. λs.(s s) (λf.λa.(f a) λx.x λy.y)

APPLICATIVE
λs.(s s) -> cannot be evaluated
(λf.λa.(f a) λx.x λy.y) -> can be evaluated -> ... ->
(λa.(λx.x  a) λy.y) -> can be evaluated -> ... ->
(λx.x λy.y) -> evaluate ->
 λy.y -> normal form, cannot be evaluated further

now go up we have
λs.(s s) λy.y -> evaluate
(λy.y λy.y) ->
λy.y -> normal form, done
total, 5 reduction


NORMAL
only evaluate when needed
λs.(s s) (λf.λa.(f a) λx.x λy.y)

λs.(s s) (λf.λa.(f a) λx.x λy.y) -> dont calculate the arg yet
((λf.λa.(f a) λx.x λy.y) (λf.λa.(f a) λx.x λy.y))  -> sees function definition -> calculate now

focus on left side:
(λf.λa.(f a) λx.x λy.y) -> λa.(λx.x a) λy.y -> (λx.x  λy.y) -> λy.y

since its doesn't remember the result has to do recomputation for the argument side
(λf.λa.(f a) λx.x λy.y) -> λa.(λx.x a) λy.y -> (λx.x  λy.y) -> λy.y

go back up we have
(λy.y λy.y) -> λy.y
normal form - cannot be evaluated further


LAZY
smarter normal order, similar step to normal but it stores the computation
λs.(s s) (λf.λa.(f a) λx.x λy.y) ->

((λf.λa.(f a) λx.x λy.y) (λf.λa.(f a) λx.x λy.y))

left side
(λf.λa.(f a) λx.x λy.y) -> λa.(λx.x a) λy.y -> (λx.x  λy.y) -> λy.y

the difference here on the argument side it does not need to recompute again, since we have the result
so just replace it with λy.y

then go back up
(λy.y λy.y) -> λy.y
normal form - cannot be evaluated further


-----

b. λx.λy.x λx.x (λs.(s s) λs.(s s))

APPLICATIVE
λx.λy.x λx.x (λs.(s s) λs.(s s))
first sees λx.λy.x -> already at normal form
λx.x -> already at normal form
(λs.(s s) λs.(s s)) -> evaluates this
(λs.(s s) λs.(s s)) -> still can be evaluated, evaluate again ->
(λs.(s s)  λs.(s s)) -> ... -> this leads to an inifnite comptuation
therefore applicative order never halts for this one


NORMAL
λx.λy.x λx.x (λs.(s s) λs.(s s)) ->
this one doesn't compute the (λs.(s s) λs.(s s)) part yet since its not neede
so it sees λx.λy.x and just substitute x and y ->
λy.λx.x (λs.(s s) λs.(s s)) -> since y (the self recursion) is not needed
λx.x
normal form, cannot be evaluated further


LAZY
lazy behaves similar to normal
λx.λy.x λx.x (λs.(s s) λs.(s s)) -> doesn't calculate the (λs. (s s) ...) yet
just substitute into λy.λx.x (λs.(s s) λs.(s s)) ->
since y is not needed just return λx.x
normal form, cannot be evaluated further

-----

c
APPLICATIVE
λa.(a a) (λf.λs.(f (s s)) λx.x)
sees λa.(a a) -> already at normal form
go to (λf.λs.(f (s s)) λx.x) -> an application, tries to reduce it =>

λs.(λx.x (s s)) => sees the body and evaluate it
λs.(s s)
now go back, we have

λa.(a a) λs.(s s) => applies, replace a with λs
(λs.(s s) λs.(s s)) => stil can be evaluated further =>
(λs.(s s) λs.(s s)) => ... => again and again
therefore applicative order never halts


NORMAL
λa.(a a) (λf.λs.(f (s s)) λx.x) =>
doesnt even bother to evalute the (λf.λs.(f (s s)) λx.x) yet, just substitute it into body of a
((λf.λs.(f (s s)) λx.x) (λf.λs.(f (s s)) λx.x) ) => sees an application, now time to reduce, focus on 1st part (left)

feed the arg (right side) into left side's f
(λf.λs.(f (s s)) λx.x) with f = λx.x
λs.(λx.x (s s)) => evaluate again
λs.(s s) => normal form, cannot be evaluated further

now time to evaluate the argument side (similar process again repeated)
(λf.λs.(f (s s)) λx.x) with f = λx.x => ... => .... => λs.(s s)

now go back up. we now have
(λs.(s s) λs.(s s)) => evaluate
(λs.(s s) λs.(s s)) => ... again => ... again
therefore normal order does not halt


LAZY
the process is similar to normal order, however 
when it reaches this phase ((λf.λs.(f (s s)) λx.x) (λf.λs.(f (s s)) λx.x) )
it calculates the both only once instead of doing 2 evaluation
and when it goes back to (λs.(s s) λs.(s s)),

it would still result in an infinite loop


-----

|#
