#lang racket

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


;((select-first 122) 158)
;(select-second 122)
;(((make-pair 111) 123) select-first)


#|

Exercises
Analyse each of the following A expressions to clarify its structure. If 
the expression is a function, identify the bound variable and the 
body expression, and then analyse the body expression. If the 
expression is an application, identify the function and argument 
expressions, and then analyse the function and argument 
expressions:

ref: functions: λx.e
app: (E1 E2)

2.1
identify: function or application?
breakdown: bound variable & body expression


a. λa.(a λb.(b a))
b. λx.λy.λz.((z x) (z y))
c. (λf.λg(λh.(g h) f) λp.λq.p)
d. λfee.λfi.λfo.λfum.(fum (fo (fi fee)))
e. (λp.(λq.p λx(x p)) λi.λj.(j i))

answer:
a. λa.(a λb.(b a))
function or application? this is a function that takes a as arg
bound variable: a
body expression: (a λb.(b a))

(a λb.(b a))
type: application
function: a
argument: λb.(b a)

λb.(b a)
type: function
bound variable: b
body: (b a)

(b a)
type: application
function: b
arg: a

end

b.λx.λy.λz.((z x) (z y))
type: function
bound variable: x
body: λy.λz.((z x) (z y))

λy.λz.((z x) (z y))
type: function
bound variable: y
body: λz.((z x) (z y))

λz.((z x) (z y))
type: function
bound variable: z
body: ((z x) (z y))

((z x) (z y))
type: application
function: (z x)
argument: (z y)

(z x)
type: application
function: z
arg: x

(z y)
type: application
function: z
arg: y

end

==========================================

c.(λf.λg(λh.(g h) f) λp.λq.p)
type: application
function: λf.λg(λh.(g h) f)
arg: λp.λq.p

---

λf.λg(λh.(g h) f)
type: function
bound variable: f
body: λg(λh.(g h) f)

λg(λh.(g h) f)
type: function
bound var: g
body: (λh.(g h) f)

(λh.(g h) f)
type: application
function: λh.(g h)
argument: f

λh.(g h)
type: function
bound var: h
body: (g h)

(g h)
type: application
function: g
arg: h

done

--

λp.λq.p
type: function
bound variable: p
body: λq.p

λq.p
type: function
bound variable: q
body: p

done

==========================================

d. λfee.λfi.λfo.λfum.(fum (fo (fi fee)))
type: function
bound variable: fee
body: λfi.λfo.λfum.(fum (fo (fi fee)))

λfi.λfo.λfum.(fum (fo (fi fee)))
type: function
bound var: fi
body: λfo.λfum.(fum (fo (fi fee)))

λfo.λfum.(fum (fo (fi fee)))
type: Function
bound var: fo
body: λfum.(fum (fo (fi fee)))

λfum.(fum (fo (fi fee)))
type: function
bound var: fum
body: (fum (fo (fi fee)))

(fum (fo (fi fee)))
type: application
function: fum
arg: (fo (fi fee))

(fo (fi fee))
type: application
function: fo
arg: (fi fee)

(fi fee)
type: application
funcion: fi
arg: fee

end

==========================================

e. (λp.(λq.p λx.(x p)) λi.λj.(j i))
type: application
function: λp.(λq.p λx.(x p))
argument: λi.λj.(j i)

-----

λp.(λq.p λx.(x p))
type: function
bound var: p
body: (λq.p λx.(x p))

(λq.p λx.(x p))
type: application
function: λq.p
argument: λx.(x p)

λq.p
type: function
bound var: q
body: p

λx.(x p)
type: function
bound var: x
body: (x p)

(x p)
type: application
function: x
arg: p

end

-----

λi.λj.(j i)
type: function
bound var: i
body: λj.(j i)

 λj.(j i)
type: function
bound var: j
body: (j i)

(j i)
type: application
function: j
arg: i

end

===========================================


2.2 evaluate the following λexprs
a. ((λx.λy.(y x) λp.λq.p) λi.i)
b. (((λx.λy.λz.((x y) z) λf.λa.(f a)) λi.i) λj.j)
c. (λh.((λa.λf.(f a) h) h) λf.(f f)) 
d. ((λp.λq.(p q) (λx.x λa.λb.a)) λk.k)
e. (((λf.λg.λx.(f(g x)) λs.(s s)) λa.λb.b) λx.λy.x) 

answer:
a. 
((λx.λy.(y x) λp.λq.p) λi.i) =>
(λy.(y λp.λq.p) λi.i) =>
(λi.i λp.λq.p) =>
λp.λq.p

end

b. ( ( (λx.λy.λz.((x y)z) λf.λa.(f a)) λi.i ) λj.j)
innermost
(λx.λy.λz.((x y)z) λf.λa.(f a)) =>
λy.λz.((λf.λa.(f a) y)z) =>
λy.λz.(λa.(y a) z) =>
λy.λz.(y z)

back up
( ( λy.λz.(y z) λi.i ) λj.j) =>

inner
λz.(λi.i z) =>
λz.z

back up
(λz.z λj.j) =>
λj.j

end

c. (λh.((λa.λf.(f a) h) h) λf.(f f))
inner
(λa.λf.(f a) h) =>
λf.(f h)

((λa.λf.(f a) h) h) =>
(λf.(f h) h) =>
(h h)

(λh.(h h) λf.(f f)) =>
(λf.(f f) λf.(f f)) =>
(λf.(f f) λf.(f f)) => ...

therefore it has no normal form

d. ((λp.λq.(p q) (λx.x λa.λb.a)) λk.k)
inner
(λp.λq.(p q) (λx.x λa.λb.a)) =>

arg
(λx.x λa.λb.a) =>
λa.λb.a

(λp.λq.(p q) (λx.x λa.λb.a)) =>
(λp.λq.(p q) λa.λb.a) =>
λq.(λa.λb.a q) =>
λq.λb.q

back up
(λq.λb.q λk.k) =>
λb.λk.k

e. ( ( (λf.λg.λx.(f(g x)) λs.(s s)) λa.λb.b) λx.λy.x)

inner application
(λf.λg.λx.(f(g x)) λs.(s s)) =>
λg.λx.(λs.(s s) (g x)) =>
λg.λx.((g x) (g x))

( (λf.λg.λx.(f(g x)) λs.(s s)) λa.λb.b) =>
(λg.λx.((g x) (g x)) λa.λb.b) =>
λx.((λa.λb.b x) (λa.λb.b x)) =>
λx.(λb.b λb.b) =>
λx.λb.b

(λx.λb.b λx.λy.x) =>
λb.b
b

end

===========================================


2.3
For each of the following pairs, show that function (i) is equivalent 
to the function resulting from expression (ii) by applying both to 
arbitrary arguments:

a.
1. identity
2. (apply (apply identity))

b.
1. apply
2. λx.λy.(((make-pair x) y) identity) 

c.
1. identity
2. (self-apply (self-apply select-second))

answer:

refrence
apply:: λf.λg.(f g)
identity:: λf.f
make-pair:: λf.λs.λfunc((func f) s)
self-apply:: λs(s s)
select-first:: λf.λs.f
select-second:: λf.λs.s


let arg = z

a.
1. (identity z) => (λf.f z) => z
2. (apply (apply identity)) =>
((apply (apply identity)) z)

inner part
(apply identity) =>
(λf.λg.(f g)  λf.f) =>
λg.(λf.f g)=>
λg.g

((apply λg.g) z) =>
inner part
(λf.λg.(f g) λg.g) =>
λg.(λg.g g) =>
λg.g

back up
((apply λg.g) z) =>
(λg.g z) =>
z

therefore 1 and 2 is equal

-----

b.
1. (apply z) =>
(λf.λg.(f g) z) =>
λg.(z g)


2. λx.λy.(((make-pair x) y) identity)
(λx.λy.(((make-pair x) y) identity) z) =>

inner part
make-pair:: λf.λs.λfunc((func f) s)
((make-pair x) y) ->
( (λf.λs.λfunc((func f)s) x) y) ->
(λs.λfunc.((func x)s) y) ->
λfunc.((func x)y)

back up
(((make-pair x) y) identity) z) =>
(λfunc.((func x)y) identity) =>
((identity x) y) =>

(λx.λy.((identity x) y) z) =>
λy.((identity z) y) =>
λy.((λf.f z) y) =>
λy.(z y)

therefore 1 and 2 is equal


|#
