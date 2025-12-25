#lang racket

; suppose h x y = f (g x y)
; which of the following function is true?
; h = f . g
; h x = f . (g x)
; h x y = (f . g) x y

#|
; answer:

ok so in the original question we have  h x y = f (g x y)
g is a function that takes 2 arguments, which si x and y
f is a function that takes 1 argument (the result of g(x y) )

h = f . g = (f.g)(z) = f(g(z))
the input of g must match the output of f
we know h takes 2 args x and y
but here g only takes 1 arg
therefore this would resut in error

h x = f . (g x)
let G = (g x)

h x = f . G
= (f . G)y
= f (G y)
= f (g x y)

h x y = (f . g) x y
here h expects 2 arguments
(f . g)(z) = (f(g z)) -> g expects 1 input
since in the original problem g expects 2 args this is a mis match

|#

; 2.62
; write down definition of cuntion wit htype num -> num
; which returns no well defined valeues

(define (xfunc n)
  (xfunc n)
  )


;2.63
; consider func halve = (div2). is it possible to specify a function f by the requirement
; f (halve x) = x?
; for all natural numbers x? give one function f that satisfies the equation:
; halve(f x) = x

; answer:
; lets check the reqruiement
; f (halve x) = x -> seems like a inverse function?

; let n = 3
; f (div 3 2) -> 1
; let n = 2
; f (div 2 2) -> 1
; since halve is not injective (many to one) it loses information
; and there can be no function that an undo the squashing

; second part
; halve(f x) = x
; just multiply it by 2

; let f x = 2*x
; halve(f 2) = 2
; halve(4) = 2
; 2 = 2

; 2.6.4
; show that the function (f . g) is strict if both f and g are strict
; answer:

; (f . g)(z)
; here g takes 1 argument and f takes argument the result of g(z)
; if f and g are both strict then we goes to g -> f
; since we know g i strict then the result of g(z) is bottom/undefined
; then when it goes to f, since we know f is also strict the result of f(g(x)) is also undefined/bottom

;2.6.5
; define operators of logical conjunction and disjunction using only the function cond
; draw up table showing their values for all possible args, well defined or otherwise

; AND
; True A True -> T
; True A False -> F
; False A True -> F
; False A False -> F
; Undefined A True -> Undefined
; Undefined A False -> Undefined
; True A Undefined -> Undefined
; False A Undefined -> Undefined
; Undefined A Undefined -> Undefined


(define (my-and a b)
  (cond [(eq? a #t) b]
        [(eq? a #f) #f]
        [else 'undefined])
  )

(define (my-or a b)
  ; case 1: a is true -> true
  ; case 2: a is false -> depends on b
  (cond [(eq? a #t) #t]
        [(eq? a #f) b]
        [else 'undefined]
        )
  )


;exercise
; 2.8.1

; suppose the function cost, subst and fix are defined by thefollowing:
; const x y = x
; subst f g x = f x (g x)
; fix f x = f (fix f) x
; deduce their types

#|
answer:
const x y = x
x :: t1
y :: t2

const :: (t1, t2) -> t1
const :: (a,b) -> a

2. subst f g x = f x (g x)
x :: t2
(g x) :: t3
g :: t2 -> t3
f :: t2 -> t3 -> t4
subst:: (t2 -> t3 -> t4) -> (t2 -> t3) -> t2 -> t4
subst:: (a -> b -> c) -> (a b) -> a -> c

3. fix f x = f (fix f) x
f (fix f) x :: tResult
x:: t1
f: (t1 -> tResult) t1 -> tResult
fix f: t1 -> tResult
fix: ((t1 -> tResult) t1 -> tResult) -> (t1 -> tResult)


2.82
show the indentity function id is equal to (subst const const)
where subst and const are as defined in previous question.
the function compose can also be expressed in terms of these functoins. how?

|#