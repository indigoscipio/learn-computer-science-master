#lang simply-scheme

#|
13.1 Trace the explode procedure from page 183 and invoke
(explode 'ape)
How many recursive calls were there? What were the arguments to each recursive call? Turn in a transcript showing 
the trace listing.
|#
(define (explode wd)
  (if (empty? wd)
      '()
      (se (first wd) (explode (bf wd))) ))
(trace explode)
(explode 'ape)

#|
since the base case is (explode e "")

the full evaloation is something like this
(explode ape)
(se a (explode pe))
...
(se a (se p (se e (explode ""))))
(se a (se p (se e '())))

base case reached -> unfoldss
(se a (se p '(e)))
(se a '(p e))
'(a p e)


13.2 How many pigl-specialist little people are involved in evaluating the following expression?
(pigl 'throughout)
What are their arguments and return values, and to whom does each give her result?


|#
(define (pigl wd)
  (if (member? (first wd) 'aeiou)
      (word wd 'ay)
      (pigl (word (bf wd) (first wd))) ))

#|
answer:
we can trace (pigl 'throughout) =>

(pigl (word 'hroughout 't)) -> 't is not a vowel, continue with new wd = 'hroughoutt
(pigl (word 'roughoutt 'h))  -> 'h is not a vowel, continue with new wd = 'roughoutth
...
(pigl (word 'oughoutt 'thr))  -> o is vowel, base case reached
(word 'oughutt 'thr) -> 'oughoutthray
|#

#|
(define (downup wd)
  (if (= (count wd) 1)
      (se wd)
      (se wd (downup (bl wd)) wd)))
|#


#|
13.3 Here is our first version of downup from Chapter 11. It doesn't work because it has no base case.
(define (downup wd)
  (se wd (downup (bl wd)) wd) )
> (downup 'toe)
ERROR: Invalid argument to BUTLAST: ""
Page 215
Explain what goes wrong to generate that error. In particular, why does Scheme try to take the butlast of an empty 
word

answer:
ok so first when we give (downup 'toe) it will run this
(se 'toe (downup 'to) 'toe) =>
(se 'toe (se 'to (downup 't) 'to) 'toe) =>
(se 'toe (se 'to (se 't (downup "") 't) 'to) 'toe) 

when it tries to evaluate (downup "")
and since it has no base case it tries to do
(se "" (downup (bl "")) "")

the error is from evaluating (bl "")
since bl takes a list, it cannot evaluate en empty string
so thats a wrong argument. so the whole thing is wrong thats why we need a base case
|#

#|
3.4 Here is a Scheme procedure that never finishes its job:
(define (forever n)
  (if (= n 0)
      1
      (+ 1 (forever n))))
Explain why it doesn't give any result. (If you try to trace it, make sure you know how to make your version of Scheme 
stop what it's doing and give you another prompt.)


answer:
lets trace with n = 1
(forever 1) =>
(+ 1 (forever 1)) =>
(+ 1 (+ 1 (forever 1))) =>
(+ 1 (+ 1 (+ 1 (forever 1)))) => ...

it runs forever because the value n never reaches = n 0
in other words it never decreases when recursing

|#

; REAL EXERCISES
#|
13.5 It may seem strange that there is one little person per invocation of a procedure, instead of just one little person 
per procedure. For certain problems, the person-per-procedure model would work fine.
Consider, for example, this invocation of pigl:
> (pigl 'prawn)
AWNPRAY
Suppose there were only one pigl specialist in the computer, named Patricia. Alonzo hires Patricia and gives her the 
argument prawn. She sees that it doesn't begin with a vowel, so she moves the first letter to the end, gets rawnp, and 
tries to pigl that. Again, it doesn't begin with a vowel, so she moves another letter to the end and gets awnpr. That 
does begin with a vowel, so she adds an ay, returning awnpray to Alonzo.
Nevertheless, this revised little-people model doesn't always work. Show how it fails to explain what happens in the 
evaluation of
(downup 'smile)

ocal variables and multiple invocations are so critical. Each little person acts like a "save point" in a
video game. When Donna hires David, she doesn't disappear; she just pauses.
Her desk still has the word 'smile on it, untouched and safely tucked away in memory.
|#
(define (downup wd)
  (if (= (count wd) 1)
      (se wd)
      (se wd (downup (bl wd)) wd)))
(downup 'smile)


#|
13.6 As part of computing (factorial 6), Scheme computes (factorial 2) and gets the answer 2. After 
Scheme gets that answer, how does it know what to do next?

answer:
it passed the result of factorial 2 (2) to its "upper" call
so (factorial 6) =>
(* 6 (factorial 5)) =>
(* 6 (* 5 (factorial 4))) => ...
(* 6 (* 5 (* 4 (* 3 (factorial 2))))) =>
since we know factorial 2 = 2 just substitue
(* 6 (* 5 (* 4 (* 3 2)))) =>
(* 6 (* 5 (* 4 6))) =>
(* 6 (* 5 24)) =>
(* 6 120) =>
720


|#
(define (factorial n)
  (cond [(= n 0) 1]
        [else (* n (factorial (- n 1))) ])
  )