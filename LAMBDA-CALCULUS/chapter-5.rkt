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

; =======================================

5.1 evaluate fully the following expressions:
a. ISBOOL 3
b. ISNUMB FALSE
c. NOT 1
d. TRUE AND 2
e. 2 + TRUE

answer:
a.
we know the def isbool = istype bool_type
λt.λobj.(equal (type obj) t) bool_type =>
λobj.(equal (type obj) bool_type)

and def ISBOOL B = MAKE_BOOL (isbool B)

def MAKE_BOOL = make-obj bool_type
λtype.λvalue.λs.(s type value) bool_type =>
λvalue.λs.(s bool_type value)

def 3 = SUCC 2

so substitute
MAKE_BOOL (isbool 3)

focus on (isbool 3)
(isbool 3) =>
λobj.(equal (type obj) bool_type) 3 =>
(equal (type 3) bool_type) => ... =>
(equal numb_type bool_type) => ...
false

go back
MAKE_BOOL false
λvalue.λs.(s bool_type value) false =>
λs.(s bool_type false

-------

b. ISNUMB FALSE
we know the definition of the following
def isnumb = istype numb_type
def ISNUMB n = MAKE_BOOL (isnumb N)
def istype t obj = equal (type obj) t // the "bouncer"
or λt.λobj.(equal (type obj) t)
def FALSE = MAKE_BOOL false => λs.(s bool_type false)

so subtitute
ISNUMB FALSE
MAKE_BOOL (isnumb FALSE) =>
here the FALSE is a typed version of the boolean
inside (isnumb FALSE) =>
istype numb_type FALSE =>
λt.λobj.(equal (type obj) t) numb_type FALSE =>
(equal (type FALSE) numb_type) => ...

since type FALSE is a bool_type, we have
(equal bool_type numb_type) =>
false

go back
MAKE_BOOL false =>
λvalue.λs.(s bool_type value) false =>
λs.(s bool_type false)


-------
NOT 1

we have the definitions
def 1 = SUCC 0

def NOT x =
if isbool x
then MAKE_BOOL (not(value x))
else BOOL_ERROR

def MAKE_BOOL = make-obj bool_type
λtype.λvalue.λs.(s type value) bool_type =>
λvalue.λs.(s bool_type value)


we can substitute
NOT 1 =>

if isbool 1
then MAKE_BOOL (not(value 1))
else BOOL_ERROR =>

focus on (isbool 1) =>
λobj.(equal (type obj) bool_type) 1 =>
(equal (type 1) bool_type) =>
(equal ( λobj.(obj select-first) 1) bool_type )
(equal (1 select-first) bool_type) =>


since we know type 1 is a numb_type, therefore => ... =>
(equal numb_type bool_type)
this returns false
now go back the the cond and reutrn BOOL_ERROR =>

λs.(s error_type bool_type)

-------
d. TRUE AND 2

we know the definitions

def TRUE = MAKE_BOOL true
λvalue.λs.(s bool_type value) true =>
λs.(s bool_type true)

def AND X Y
if and (isbool x) (isbool y)
then MAKE_BOOL (and (value x) (value y))
else BOOL_ERROR

now substitute

AND TRUE 2 =>
if and (isbool TRUE) (isbool 2)
then MAKE_BOOL (and (value x) (value y))
else BOOL_ERROR =>

(isbool TRUE) =>
λobj.(equal (type obj) bool_type) TRUE =>
(equal (type true) bool_type) =>
(equal ( λobj.(obj select-first) true) bool_type) =>
(equal (true select-first) bool_type) =>
(equal (λs.(s bool_type true) select-first) bool_type) =>
(equal bool_type bool_type) => true

(isbool 2) =>
λobj.(equal (type obj) bool_type) 2 =>
(equal (type 2) bool_type) => ... =>
(equal (λobj.(obj select-first) 2) bool_type ) =>
(equal (2 select-first)  bool_type ) => ... =>
(equal numb_type bool_type) => false


since we know isbool true is returns true
and isbool 2 returns false,

the else cause is run
and return BOOL_ERROR =>
λs.(s error_type bool_type)

-------

e. 2 + TRUE
we know the definition of +


def + X Y
if both_numbs X Y
then MAKE_NUMB (add (value x) (value y))
else NUMB_ERROR

def both_numbs X Y = and (isnumb X) (isnumb Y)

substitute

if both_numbs 2 TRUE
then MAKE_NUMB (add (value 2) (value TRUE))
else NUMB_ERROR

run 1st check => both_numbs 2 TRUE =>

and (isnumb X) (isnumb Y) =>
and (isnumb 2) (isnumb TRUE) =>
since we know true is not a type of numb, it will return
and true false => false

so back in the if, we go to the else case and reutrn NUMB_ERROR
MAKE_ERROR numb_type =>

def MAKE_ERROR = make-obj error_type
λtype.λvalue.λs.(s type value) error_type =>
λvalue.λs.(s error_type value)

λs.(s error_type numb_type)

end



========================================

5.2
Signed numbers might be introduced as a new type with an extra 
layer of ‘pairing’ so that the value of a number is preceded by a 
boolean to indicate whether or not the number is positive or 
negative:

def signed_type = ...
def SIGN_ERROR = MAKE_ERROR signed_type
def POS = TRUE
def NEG = FALSE
def MAKE_SIGNED N SIGN = make_obj signed_type (make-obj SIGN N)

so:
+<number> == MAKE_SIGNED <number> POS
-<number> == MAKE_SIGNED <number> NED


for exampel;
+4 == MAKE_SIGNED 4 POS
-4 == MAKE_SIGNED 4 NEG

not that there are two representations for 0:
+0 == MAKE_SIGNED 0 POS
-0 == MAKE_SIGNED 0 NEG

a. define a tester and selector functions for signed numbers:

def issigned N = true if N is a signed number
def ISSIGNED N = TRUE if N Is a signed number
def sign N = N's sign as untyped number
def SIGN n = N's sign as typed number
def sign_value N = N's value as unsigned number
def VALUE n = N's value as signed number
def sign_iszero N = true if N is 0

show that your functions work for representaative positive
and negative values and 0

answer:

ok lets jsut do simpel exmaple
structure of -4 = (signed_type, [NEG, 4])
+4 = (signed_type, [POS,4])
so N = (signed_type, [POS, N])

lets start with issigned N
we know previously from
istype t obj = equal (type obj) t - the "bouncer"

so issigned N should be simliar
first, grab the label and

issigned N = equal (type N) signed_type
ISSIGNED N = MAKE_BOOL equal (type N) signed_type

sign_value N = value (value n)
VALUE N = MAKE_NUMB value (value n)

sign N = type (value N) - just get either pos/neg
SIGN N = MAKE_BOOL type (value N)

sign_iszero N = iszero (value (value N))

========================================
quick reference
def type obj = obj select_first or λobj.(obj select-first)
def value obj = obj select_second or λobj.(obj select-second)
def istype t obj = equal (type obj) t - the "bouncer"
def pair a b = λs.(s a b)

now trace an example

-4
sign_value 4
value (value (signed_type, (NEG, 4)) =>
value (λobj.(obj select-second) (signed_type, (NEG, 4)) =>
value ((signed_type, (NEG, 4) select-second) ) => ... =>
value (NEG, 4) => ... =>
λobj.(obj select-second) (NEG, 4) => ...
((NEG, 4) select-second) => ... by the definition of pair
(λs.(s NEG 4) select-second) =>
4

-----

sign -4
type (value (signed_type, (NEG, 4)) =>
type (λobj.(obj select-second) (signed_type, (NEG, 4))
type ((signed_type, (NEG, 4) select-second) ) => ... =>
type (NEG, 4) => ... =>
λobj.(obj select-first) (NEG, 4) =>
((NEG, 4) select-first) => ... => ... by defiinton of pair
(λs.(s NEG 4) select-first) =>
NEG

-----

sign_iszero? +0
iszero (value (value (signed_type, (POS, 0)) )) => ...
iszero (value (POS, 0)) => ... =>
iszero (λobj.(obj select-second) (POS, 0)) =>
iszero ((POS, 0) select-second) => ...
iszero (λs.(s POS 0) select-second) => ... 
iszero 0 => ...
true

========================================

b. define signed versions of ISZERO, SUCC and PRED:
def SIGN_ISZERO N = ...
def SIGN_SUCC N = ...
def SIGN_PRED N = ...

def SIGN_ISZERO N
if (issigned N)
then MAKE_BOOL (sign_iszero N) ;perform with untyped version
else SIGN_ERROR

def SIGN_SUCC N
if (sign n)
then MAKE_SIGNED (succ (sign_value n)) (sign n)
else MAKE_SIGNED (pred (sign_value n)) (sign n)

def SIGN_PRED N
if (sign n)
then MAKE_SIGNED (pred (sign_value n)) (sign n)
else MAKE_SIGNED (succ (sign_value n)) (sign n)


========================================
c. define a signed version of "+"
def SIGN_+ X Y = ...

show your function works fo representative positive and negative values and 0

answer:
same sign - just add
different sign - take sign of the larger one and subtract (subtract larger - smallest)
zero - stays the same

ill just do this roughly i dont wanna waste time in this
jst get the logic right thats the most important

def SIGN_+ X Y
if (SAME_SIGN X Y) ;check if the same sign
then (+ x y) ;just do the addition
else if (> (x value) (y value)) ;extract the larger magnitude
     then (- (x value) (y value) )
     else (- (y value) (x value))

|#