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
; EXERCISES
6.1
define a concatenation function for linear lists whose elements are atoms of the same type

|#
; list-of-x -> list-of-x -> list-of-x
(define (concat xs ys)
  ;recurse on xs, ys is the result
  (cond [(null? xs) ys]
        [else (cons (car xs) (concat (cdr xs) ys) )]
        )
  )
'(concat '() '()) ; '()
(concat '(1 2 3) '()) ; '(1 2 3)
(concat '() '(1 2 3)) ; '(1 2 3)
(concat '(1 2 3) '(4 5 6)) ;'(1 2 3 4 5 6)

#|
now to translate
in λ calc, it goes something like this
def concat xs ys
if isnil xs
then xs
else cons (head xs) (concat (tail xs) ys)
|#

; ==========================================================

#|
6.2
(a) Write a function which indicates whether or not a list starts with 
a sublist. For example: 
STARTS "The" ’"The cat sat on the mat." => TRUE 
STARTS ”A” "The cat sat on the mat.” => FALSE
|#


; main helper
; list-of-chars list-of-chars -> boolean
(define (starts-with1? l1 l2)
  (cond [(empty? l1) #t]
        [(empty? l2) #f]
        [(eq? (car l1) (car l2)) (starts-with1? (cdr l1) (cdr l2))]
        [else #f]
        )
  )

;; starts-with:: list-of-x -> list-of-x -> boolean
(define (starts-with? xs ys)
  (let ((xs-chars (string->list xs))
        (ys-chars (string->list ys))
        )
    (starts-with1? xs-chars ys-chars)    
    )
  )


(starts-with? "A" "The cat sat on the mat.")
(starts-with? "The" "The cat sat on the mat.")


#|
now to translate to λcalc
def starts-with xs ys
if isnil? xs
then #t
if isnil? ys
then #f
else if (equal? (head xs) (head ys))
     then (starts-with (tail xs) (tail ys))
     else #f

|#

;-----

#|
(b) Write a function which indicates whether or not a list contains a 
given sublist. For example: 
CONTAINS "the” "The cat sat on the mat.” => TRUE 
CONTAINS ”the" "All cats sit on all mats.” => FALSE
|#


    
; main helper; recurse on l1
(define (contains1 l1 l2)
  (cond [(empty? l2) #f]
        [(starts-with1? l1 l2) #t]
        [else (contains1 l1 (cdr l2))])
  )

(define (contains xs ys)
  (let ((xs-chars (string->list xs))
        (ys-chars (string->list ys)))
    (contains1 xs-chars ys-chars) 
    )
  )
(contains "the" "The cat sat on the mat.") ;t
(contains "the" "All cats sit on all mats.") ;f

#|
translating to λ calculus
def CONTAINS xs ys =
if isnil ys then false
elseif (start-with xs ys) then true
else (contains xs (tail ys))
|#

;-----

#|
(c) Write a function which counts how often a sublist appears in 
another list. For example: 
COUNT ”at” ”The cat sat on the mat." =>... => 3
|#


;recurse on l2
; list-of-x -> list-of-y -> number
(define (count1 l1 l2)
  (cond [(null? l2) 0]
        [(starts-with1? l1 l2) (+ 1 (count1 l1 (cdr l2)))]
        [else (count1 l1 (cdr l2))]
        )
  )

(define (count xs ys)
  (let ((xs-chars (string->list xs))
        (ys-chars (string->list ys)))    
    (count1 xs-chars ys-chars)
    )
  )
(count "at" "The cat sat on the mat.") ;should return 3

#|
now the λcalc version
def count xs ys
if isnil? ys
then zero
else if (starts-with? xs ys) then (+ 1 (count xs (tail ys)))
else (count xs (tail ys))
|#

;-----

#|
(d) Write a function which removes a sublist from the start of a list, 
assuming that you know that the sublist starts the list. For 
example: 
REMOVE "The ” ”The cat sat on the mat." => ”cat sat on the mat.”
|#

(define (remove xs ys)
  ; need to know the length of the sublist and drop the list by that amount
  ; or maybe im overcomplicating this?
  (let ((xs-chars (string->list xs))
        (ys-chars (string->list ys)))
    (define (remove1 l1 l2)
      (cond [(null? l1) l2]
            [else (remove1 (cdr l1) (cdr l2)) ]
            )
      )  
    (remove1 xs-chars ys-chars)
    )
  )
(remove "The" "The cat sat on the mat.") ; "cat sat on the mat."

#|
λcalc version

def remove xs ys
if isnil? xs
then ys
else (remove (tail xs) (tail ys))
|#

; -----

#|
(e) Write a function which deletes the first occurrence of a sublist in 
another list. For example: 
DELETE "sat" "The cat sat on the ma .” => "The cat on the mat.” 
DELETE ”lay" ”The cat sat on the mat.” => "The cat sat on the mat.”
|#

(define (delete xs ys)
    (let ((xs-chars (string->list xs))
        (ys-chars (string->list ys)))
      
    (define (delete1 l1 l2)
      )  
    (delete1 xs-chars ys-chars)
    )
  )

; ==========================================================

#|

|#

; ==========================================================

#|

|#

; ==========================================================
