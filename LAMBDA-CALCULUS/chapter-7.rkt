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
Type Definition
Exhaustive - case by case/fixed
Growth - number

Pair into packs
5 -> (1, 5) where 1 could be the type for NUMBER
four steps

add 2 3

GENERAL STEPS
1. check both of their type args
2. extract the value from typed args
3. perform the untyped operattion
4. Reconstruct the pair (1, 5)

-----

MAKE OBJECT
(x,y) -> where x is the sticker and y is the container
basically just a way to create a pair
where the first item is the label, and 2nd one is a value

def make_obj type value = λs.(s type value)
or λtype.λvalue.λs.(s type value)
where s is the selector

def type obj = obj select_first or λobj.(obj select-first)
def value obj = obj select_second
def istype t obj = equal (type obj) t - the "bouncer"

-----

ERROR TYPE
if an operation receives error from previous step it should travel thrpugh

def error_type = zero

def MAKE_ERROR = make-obj error_type
λtype.λvalue.λs.(s type value) error_type =>
λvalue.λs.(s error_type value)


def ERROR = MAKE_ERROR error_type -> waiting for a value
λvalue.λs.(s error_type value) error_type =>
λs.(s error_type error_type)

def iserror = istype error_type
λt.λobj.(equal (type obj) t) error_type =>
λobj.(equal (type obj) error_type)

test with error object
iserror ERROR ==
λobj.(equal (type obj) error_type) ERROR =>
(equal (type ERROR) error_type)

type ERORR ==
λobj.(obj select_first) ERROR =>
(ERROR select_first) =>
λs.(s error_type error_type) select-first =>
(select-first error_type error_type) =>

... => true

-----

BOOLEAN TYPE

def bool_type = one

def MAKE_BOOL = make-obj bool_type
λtype.λvalue.λs.(s type value) bool_type =>
λvalue.λs.(s bool_type value)

def TRUE = MAKE_BOOL true
λvalue.λs.(s bool_type value) true =>
λs.(s bool_type true)

def FALSE = MAKE_BOOL false => λs.(s bool_type false)

def is bool = istype bool_type
λt.λobj.(equal (type obj) t) bool_type =>
λobj.(equal (type obj) bool_type)

isbool TRUE =
λobj.(equal (type obj) bool_type) true =>
(equal (type true) bool_type) =>

(equal (λobj.(obj select_first) true) bool_type) =>
(equal (true select_first) bool_type ) =>
(equal bool_type bool_type )

def BOOL_ERROR = MAKE_ERROR bool_type =>
λs.(s error_type bool_type)

example: typed NOT
def NOT x =
if isbool x
then MAKE_BOOL (not(value x))
else BOOL_ERROR

example: typed AND
def AND X Y
if and (isbool x) (isbool y)
then MAKE_BOOL (and (value x) (value y))
else BOOL_ERROR

-----

CONDITIONALS

def COND E1 E2 C =
if isbool C
then if value C
      then E1
      else E2
else BOOL_ERROR

-----

NUMBER TYPE
in untyped version, succ just add one
now it checks for 2 things

def numb_type = two
def MAKE_NUMB = make_obj numb_type => λvalue.λs.(s numb_type value)
def NUMB_ERROR = MAKE_ERROR numb_type => λs.(s error_type numb_type)
def isnumb = istype numb_type
def ISNUMB n = MAKE_BOOL (isnumb N)

def SUCC N =
if isnumb N
then MAKE_NUMB (succ (value n))
else NUMB_ERROR

def PRED N =
if isnumb N
then ifiszero (value N)
     then NUMB_ERROR
     else MAKE_NUMB ((value n) select_second)
else NUMB_ERROR

def ISZERO N =
if isnumb N
then MAKE_BOOL (iszero (value n))
else NUMB_ERROR

-----

CHARACTER TYPE

def char_type = four
def CHAR_ERROR = MAKE_ERROR char_type
def ischar = istype char_type
def ISCHAR C = MAKE_BOOL (ischar c)
def MAKE_CHAR = make_obj char-type


-----

TYPE IS INEFFICIENT
Public function - the bouncer at the door, checks input tpes
Private function (add1) - everything here is assumed safe, does computation quickly

-----

STATIC VS DYNAMIC
dynamic - check as you go (execution time) - eg lisp
static - catches before error happens (compilation time), chekc bfore program runs - eg c

-----

PATTERN MATCHING
like a physical mold/template
depends on the position of arugment, doesn't need complex logic
first match wins

IS_TEN 10 = true
IS_TEN X = false


|#

; =======================================

#|
NIL is a list
CONS H T is a list
if H is any object and T is a list

HEAD NIL = LIST_ERROR
TAIL NIL = LIST_ERROR
def LIST_ERROR = MAKE_ERROR list_type
islist = istype list_type
def ISLIST_L = MAKE_BOOL (islist L)
def LIST = λs.(s list_type λs.(s <head> <tail>))
def MAKE_LIST = make_obj list_type
def isnil L =
if islist L
then iserror (HEAD L)
else false
def CONS H T =
if (islist T)
then MAKE_LIST λs.(s H T)
else LIST_ERROR

---
LIST LENGTH
def LENGTH L =
if ISNIL l
then 0
else SUCC(LENGTH (TAIL L))

---
LIST APPEND
APPEND NIL L = L
APPEND (CONS H T) L = CONS H (APPEND T L)

(define (lc-append l1 l2)
  (cond [(null? l1) l2]
        [else (cons (car l1) (lc-append (cdr l1) l2))])
  )

-----
LIST NOTATION

<expr1>::<expr2> == CONS <expr1> <expr2>
X::NIL = [x]
X::[Y] = [X,Y]
[<fisrt item>,<second item>] ==
(cons <first> (cons <second> '()))

-----
LIST DELETION
DELETE X = []
DELETE X (H::T) = T if <equal> X H

-----
LIST COMPARISON
LIST_EQUAL [] [] = true
LIST_EQUAL [] [H::T] = false
LIST_EQUAL [H::T] [] = false

-----
STRINGS
ISSTRING [] = true
ISSTRING (H::T) = ISCHAR H AND ISSTRING T

|#

; ==========================================================

#|

COMPOSITE VALUES
values that consistes of subvalues
[<forename>,<surname>]
[<item name>,<stock level>,<reorder level>]
[[<forename>,<surname>],<address>,<n>]

example: finding surname
(define (nfind name l)
  (cond [(null? l) '()]
        [(equal? name (cadr (car l))) (car (car l))]
        [else (nfind name (cdr l))]
        )
  )

-----

SELECTOR FUNCTIONS
functions that selects things
def FORENAME N = (head n)

-----

STRUCTURE MATCHING

def FORENAME [F,S] = F
def SURNAME [F,S] = S

(define P '(5 10))
(match P [(list x y) (+ x y)])

(define point '(10 20 30))
(define item '(a b c))
(match item [(list a b c) a])
(match point [(list x y z) (+ x y)])

(define (ncount n names)
  (match names
    ['() 0]
    [(cons (list f s) t) (if (equal? n f)
                             (+ 1 (ncount n t))
                             (ncount n t)
                             )])
  )
(ncount 'linda '((linda linda) (linda grey) (linda hey)))

-----

LOCAL DEFINITIONS
λ<name>.<body> <argument>

let <name> = <argument>
in <body>

<body>
where <name> = <argument>


(define (split xxs)
  (cond [(null? xxs) '(() ())]
        [else (let* ((fst (car xxs))
                     (fname (car (car xxs)))
                     (sname (cadr (car xxs)))
                     (split-rest (split (cdr xxs)))
                     (first-names (car split-rest))
                     (last-names (cadr split-rest))
                     )
                (list (cons fname first-names) (cons sname last-names) )
                )]
        )
  )
(split '((allan ape) (betty bat) (colin cat)))

; with pattern matching
(define (split-pm xxs)
  (match xxs
    ['() '(() ())]
    [(cons (list f s) rest) (let ((result (split-pm rest)))
                              (list (cons f (car result)) (cons s (cadr result)))
                              ) ]
    )
  )
(split-pm '((allan ape) (betty bat) (colin cat)))

-----

TREES
EMPTY is a bt
NODE ITEM L R is a bt
if L is a bt and R is a bt

def EMPTY = NIL
def ISEMPTY = ISNIL
def ITEM (NODE I L R) = I
def LEFT (NODE I L R) = L
def RIGHT (NODE I L R) = R

ITEM EMPTY = TREE_ERROR
LEFT EMPTY = TREE_ERROR
RIGHT EMPTY = TREE_ERROR

def ITEM EMPTY = LIST_ERROR
or ITEM [I,L,R] = I

-----

ADD ITEM TO TREE
TADD I EMPTY = NODE I EMPTY EMPTY
TADD I (NODE NI L R) = NODE NI (TADD I L) R if <less> I NI
TADD I (NODE NI L R) = NODE NI L (TADD I L) if NOT <less> I NI

(struct bt (item left right) #:transparent)
(define empty-bt '())
(define bt1 (bt 1 '() '()))
(define bt3 (bt 3 '() '()))
(define bt2 (bt 2 bt1 bt3))
 
(define (tadd item tree)
 (cond [(null? tree) (bt item '() '())] ;empty bt, not found
       [(< item (bt-item tree)) (bt (bt-item tree) (tadd item (bt-left tree)) (bt-right tree)) ]
       [else (bt (bt-item tree) (bt-left tree) (tadd item (bt-right tree)))]
       )
  )
(tadd 5 empty-bt)
(tadd 5 bt1)
(tadd 5 bt2)

-----

TRAVERSE TREE
TRAVERSE (NODE I L R) = APPEND (TRAVERSE L) (I :: (TRAVERSE R))
TRAVERSE EMPTY = []


-----

SEARCH TREE
TFIND V EMPTY = FALSE
TFIND V (NODE NV L R) = TRUE IF <equal> V NV
TFIND V (NODE NV L R) = TFIND V L if <less> V NV
TFIND V (NODE NV L R) = TFIND V R if NOT (<less> V NV)


-----

COMPOSITE TREE
CTADDLIST '((mark monkey) (graham goat) (james jaguar) (david duck))

-----


CURRIED VS UNCURRIED
barista analogy
curried -> needs 2 things: f(x,y) -> result
uncurried -> needs 1 thing, then 1 thing again: (f x) y or f x y

def curry f x y = f [x,y]
def uncurry = g [a,b] = g a b

---

PARTIAL APPLICATION
def istype t obj = equal t (type obj)
def isbool = istype bool_type

here isbool is a partial application thats waiting for the obj

|#

; ================================================================

#|
; exercise 7.1
The time of day might be represented as a list with three integer fields for hours, minutes and seconds: 
[<hours>,<minutes>,<seconds>]

For example: 
[17,35,42] == 17 hours 35 minutes 42 seconds 
Note that: 
24 hours == 0 hours 
1 hour == 60 minutes 
1 minute == 60 seconds

(a) Write functions to convert from a time of day to seconds and 
from seconds to a time of day. For example: 
TOO_SECS [2,30,25] => 9025
FROM_SECS 48975  => [13,36,151]

answer:
lets try to define the data structure first and then get the basic logic

|#

; a time of day is a list of number
; where h = 0 - 24, h = 0 - 60, and m = 0 - 60
(struct tod (h m s) #:transparent)
(define tod1 (tod 2 30 25))

;to-secs:: tod -> number
(define (to-secs time-of-day)
  ; convert the minute
  ; convert the hour
  ; add them with seconds
  (let* ((hour (tod-h time-of-day))
        (minute (tod-m time-of-day))
        (second (tod-s time-of-day))
        )
    (+ (* hour 3600) (* minute 60) second)
    )
  )

;from-secs:: number -> tod
(define (from-secs sec)
  ; sec above 60? minute
  ; sec above 3600? hour
  (let* ((hour (quotient sec 3600))
         (remaining-secs (- sec (* hour 3600)))
         (minute (quotient remaining-secs 60))
         (second (remainder remaining-secs 60))
         )
    (tod hour minute second)
    )
  )
;(from-secs 48975)


#|
(b) Write a function which increments the time of day by one 
second. For example: 
TICK [15,27,18] => [15,27,19] 
TICK [15,44,59] => [15,45,0]
TICK [15,59,59] => [16,0,0] 
TICK [23,59,59] => [0,0,0]
|#

(define (tick time-of-day)
  (let* ((tod-in-secs (to-secs time-of-day))
         (incremented-result (+ 1 tod-in-secs))
         )
    (from-secs (remainder incremented-result 86400))
    )
  )
(tick (tod 15 27 18))
(tick (tod 15 44 59))
(tick (tod 15 59 59))
(tick (tod 23 59 59))

#|
(c) In a shop, each transaction at a cash register is time stamped. 
Given a list of transaction details, where each is a string followed 
by a time of day, write a function which sorts them into ascending time order. For example:

TSORT [["coffee",[1 2,1 9,571], 
      [”bread”,[1 8,22,48]], 
      [”orange iuice”,[10,12,35]], 
      [”bananas”,[15,47,19]]] =>

      [["orange juice",[10,12,35]], 
      [”coffee",[12,19,57]], 
      [”bananas",[1 5,47,1 9]] 
      [”bread",[1 8,22,48]]] 

answer: lets define the data structure first,
then figure out the basic logic and sorting

|#

(struct transaction (name tod))
(define t1 (transaction "coffee" (tod 12 19 57)))
(define t2 (transaction "bread" (tod 18 22 48)))
(define t3 (transaction "orange juice" (tod 10 12 35)))
(define t4 (transaction "bananas" (tod 15 47 19)))

(define (transaction-before? t1 t2)
  
  )

(define (tsort xs)
  (cond [(null? xs) '()]
        [else (let ((fst-tsc-in-sec (to-secs (transaction-tod (first xs))))
                    (rest tsort (cdr xs))
                    )
                ; not sure what sort i should use
                fst-tsc-in-sec
                )])
  )
(tsort (list t1 t2 t3 t4))