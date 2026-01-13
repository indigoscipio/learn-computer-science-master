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

apply recursive to mult1
f <'f' and copy> mult1 =>
mult1 <mult1 and copy> =>

(λf.λx.λy.
if iszero y
then zero
else add x (f x (pred y)) <mult1 and copy>) =>


if iszero y
then zero
else add x (<mult1 and copy> x (pred y))

(<mult1 and copy> x (pred y) =>

-----
def recursive f = (λs.(f (s s)) λs.(f (s s)))
-----

mult three two => ... =>
(λx.λy.
if iszero y
then zero
else add x ( (λs.(mult1 (s s)) λs.(mult1 (s s))) x (pred y)) three two) => ... =>

if iszero two
then zero
else add three (λs.(mult1 (s s)) λs.(mult1 (s s))) three (pred two)) => ... =>

add three (λs.(mult1 (s s)) λs.(mult1 (s s))) three (pred two)) ->
add three (mult1 (λs.(mult1 (s s)) λs.(mult1 (s s)))  three (pred two)) ==

add three
(λf.λx.λy.
if iszero y
then zero
else add x (f x (pred y)) (λs.(mult1 (s s)) λs.(mult1 (s s)))  three (pred two))


====== OPERATION - EXPONENTS ======
rec power x y
if iszero y
then one
else mult x (power x (pred y))

====== OPERATION - SUBTRACTION ======
rec sub x y
if iszero y
then x
else sub (pred x) (pred y)

====== OPERATION - COMPARISON ======
absolute difference
def abs-diff x y = add (sub x y) (sub y x)
def equal x y = iszero (abs-diff x y)

|#

(define (nat-sub x y)
  (cond [(<= x 0) 0]
        [(<= y 0) x]
        [else (nat-sub (- x 1) (- y 1 ))])
  )


; =========================================
; EXERCISES


#|
4.1
The following function finds the sum of the numbers between n and zero:


def sum1 f n = 
if iszero n 
then zero 
else add n (f (pred n))

def sum = recursive sum1

Evaluate: sum three

answer:
sum three =>
recursive sum1 three =>

we know recursive f = λf.(λs.f(s s) λs.f(s s))
so substitute

λf.(λs.f(s s) λs.f(s s)) sum1 three =>
(λs.sum1(s s) λs.sum1(s s)) three =>
sum1 (λs.sum1(s s) λs.sum1(s s)) three =>

(λf.λn.
if iszero n 
then zero 
else add n (f (pred n)) (λs.sum1(s s) λs.sum1(s s)) three) =>

if iszero three
then zero 
else add three ((λs.sum1(s s) λs.sum1(s s)) (pred three)) =>

zero is not three, so run the else case =>

add three ((λs.sum1(s s) λs.sum1(s s)) (pred three)) =>
add three ((λs.sum1(s s) λs.sum1(s s)) two) =>

add three sum1 λs.sum1(s s) λs.sum1(s s) two =>

add three
(λf.λn.
if iszero n 
then zero 
else add n (f (pred n)) (λs.sum1(s s) λs.sum1(s s)) two) =>

add three
if iszero two
then zero 
else add two ((λs.sum1(s s) λs.sum1(s s)) (pred two)) =>

two is not zero so run else case
add three
add two ((λs.sum1(s s) λs.sum1(s s)) (pred two)) =>

add two ((λs.sum1(s s) λs.sum1(s s)) one) => ...
repeat until

add three add two add one zero =>
six

; ==============================

4.2
write a function that finds the rpdouct of numbers between n and one

def prod 1 f n = ...
def prod = recursive prod1

so that
prod n
in λ calc is equivalent to
n * n-1 * n-2 * ... * 1
in normal arithmetic (there is no escape from 'factorial' ...)
evaluate: prod three

answer:

|#
; lets start with a racket function first since its easier to translate
(define (prod n)
  (cond [(<= n 1) 1]
        [else (* n (prod (- n 1))) ])
  )
(prod 1)

#|
def prod1 f n
if (or (iszero n) (iszero (pred n)))
then one
else (mult n (f (pred n)))

def prod = recursive prod1

now evaluate prod three =>
recursive prod1 three =>

we know recursive f = λf.(λs.f(s s) λs.f(s s))
so substitute

λf.(λs.f(s s) λs.f(s s)) prod1 three =>
(λs.prod1(s s) λs.prod1(s s)) three =>

since we know prod1 definition, subsittude

λf.λn.
if (or (iszero n) (iszero (pred n)))
then one
else (mult n (f (pred n))) (λs.prod1(s s)  λs.prod1(s s)) three =>

if (or (iszero three) (iszero (pred three)))
then one
else (mult three (f (pred three))) =>

since three is notzero and three is not one the else case runs
(mult three (f (pred three))) =>
(mult three (f two)) =>
(mult three ((λs.prod1(s s)  λs.prod1(s s)) two)) =>

focus on inside
((λs.prod1(s s)  λs.prod1(s s)) two) =>
prod1 (λs.prod1(s s) λs.prod1(s s)) two =>

λf.λn.
if (or (iszero n) (iszero (pred n)))
then one
else (mult n (f (pred n))) (λs.prod1(s s)  λs.prod1(s s)) two =>

if (or (iszero two) (iszero (pred two)))
then one
else (mult two ((λs.prod1(s s)  λs.prod1(s s)) one) =>

since two is not zero or one, run else case
(mult two ((λs.prod1(s s)  λs.prod1(s s)) one)

repeat the step again until we reach n =1
backing up we accumulate by then (mult three (mult two one)) =>

mult three one =>
three

...

; ==============================

4.3 write a function which finds the sum of applying a function fun to the numbers between n and zero
def fun_sum1 f n = ...
def fun_sum = recursive fun_sum1

for example, given the squaring function:
def sq x = mult x x

then fun_sum sq three
in λcalc is equivalent to 3^2 + 2^2 + 1^2 + 0^2
in arithmetic.

evaluate: fun_sum double three
given doubling function def double x = add x x

answer:
lets try to approach this in racket function first since its simpler


|#
(define (fun_sum1 f n)
  (cond [(zero? n) 0] ;since the range is between n and zero, stop when n is zero
        [else (+ (f n) (fun_sum1 f (- n 1)) ) ])
  )
(fun_sum1 sqr 3) ; should return 3^2 + 2^2 + 1^2 + 0^2 = 9+4+1+0 = 14

#|
now back to the λcalc definition

def fun_sum1 f fun n
if iszero? n
then zero
else (add (fun n) (f fun (pred n)))

def fun_sum = recursive fun_sum1

now for evaluation
fun_sum double three =>
recursive fun_sum1 double three =>

we know recursive f = λf.(λs.f(s s) λs.f(s s))
so substitute

λf.(λs.f(s s) λs.f(s s)) fun_sum1 double three =>
(λs.fun_sum1(s s) λs.fun_sum1(s s)) double three =>
fun_sum1 (λs.fun_sum1(s s) λs.fun_sum1(s s)) double three =>

we know the definition of sum1 is


...
|#