#lang racket

; 1.2.1
; count the number of different ways that
; square(square(3+7)) can be reduced to normal form:

#|
1. evaluate outer square/procedure first
; ten every thing inside left to right
square(square(3+7))
= (square (3 + 7)) * (square (3 + 7))
= (square 10) * (square (3 + 7))
= (square 10) * (square 10)
= (10 * 10) * (square 10)
= (10 * 10) * (10 * 10)
= 100 * (10 * 10)
= 100 * 100
= 10000

= ((3 + 7) * (3 + 7)) * ((3 + 7) * (3 + 7))
= (10 * 10) * (10 * 10)
= 100 * 100 = 10000

2. reduce outer square, but evaluate right to left

3. reduce inner squrare, then argument first
square(square(3+7))
= square(square(10))
= square(10 * 10)
= square(100)
= (100 * 100)
= 10000

redex = reducible expression


=============================

consider the definition

three x = 3
in how many was can three (3 + 4) be reduced to normal form?

answer:
1. evaluate argument first
three(3+4) -> three(7) -> return 3
2. evaluate function first -> three x -> sees 3 -> return 3 (dont look inside x)

1.2.3
imagine a language of expr for representing integers defined by syntax rules
1. zero is an expr
2. if e is an expr, then so are (succ e) and (pred e)
an evaluator reduces expressions in this language by applying the following rules repeatedly until no longer possible

RULE
(succ (pred e)) => e (succ.1)
(pred (succ e)) => e (pred.1)

simplify the expression
(succ (pred (succ (pred (pred zero)))))

answer:

(succ (pred (succ (pred (pred zero))))) -> recude (succ (pred e))
(succ (pred (pred zero))) -> reduce (succ (pred e))
(pred zero) -> this is the normal form

a) initial expression contain two redexes, two reduction
- from inner
- from outer
 after the first reduction step, no branching occurs

prove that the process of reduction terminates for all given expression
since in each of the rule
each pair cancels
it will eventually lead to either:
- all pair exhausted: last expression is zero
- only one pair remaining: either (succ e) or (pred e)
in both cases it willeventually terminate

Let the size of an expression be the total number of succ and pred constructors it contains.
Each reduction step removes exactly one succ and one pred, so the size decreases by 2.
Size is a natural number (0 or positive). Natural numbers cannot decrease indefinitely.
Therefore, every reduction sequence must terminate at a normal form.

========================================

Suppose an extra syntactic rule is added
3) if e1 and e2 are expressions, then so is (add e1 e2)

(add zero e2) => e2
(add (succ e1) e2) => (succ (add e1 e2))
(add (pred e1) e2) => (pred (add e1 e2))

a. simplify the expression:
count no of different ways the reduction rules can be appleid to the above expr

(add (succ (pred zero)) zero)

answwer:


way 1: reduce outer add:
(add (succ (pred zero)) zero)
then branch
branch 1: reduce inner succ/pred first
(add zero zero)
zero -> normal form reached

branch 2: reduce inner succ/pred later
(add (succ (pred zero)) zero)
(succ (add (pred zero) zero))
(succ (pred (add zero zero)))
(succ (pred zero))
zero


way 2: reduce inner succ/pred first
(add zero zero)
zero -> normal form



b. do they always lead to same final reslut? prove reduction must awys terminate for any given initial expr.
hint: extend notion of expression size.
without the add rule the expression size is total node = either succ pred or zeor
but now the node type it adds add
in whichcever case add will evnetually reduce by the threee cases
(add zero e2) => e2 -> reduce add 1x
(add (succ e1) e2) => (succ (add e1 e2)) -> reduce add since (succ e1) need to be reduce
(add (pred e1) e2) => (pred (add e1 e2)) -> reduce add since (pred e1) need to be reduce
will eventually reach the base case

=======================================

1.2.4
Imagine a languagge of finite sequences 0 and 1
the rules for simplifying string in this languare are given by:

1. 1??x -> x1101
2. 0??x -> x00

? denoes  a single either 0 or 1
a. reduce thefollowing expression to canonical form:

1110
= 01101

10
= does not fit 1??x or rule 2
so its alreayd at canonical form

1110100
= 01001101 by rule 1
= 0110100 by rule 2
= 010000 by rule 2
= 00000 by rule 2
= 0000 by rule 2
= 000

b.
construct expr for which reduction process does not terminate
lets say tail begins with 1
1111 -> 11101 -> 011101 -> 10100 -> 001101 ->  10100 -> 001101 -> 10100 -> 001101 -> ..

tail begins with 0
1110 -> 01101 -> 0100 -> 000 -> 3 digit, therefore canonical
happens because the "x" part on the 2nd rule starts with "1"

0??x -> 1001 -> 11101 -> 10100 -< ...

|#

