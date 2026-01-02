#lang racket

; apply:: λf.λg.(f g)
(define apply (λ(f)
                (λ (g)
                  (f g))))

; select-first:: λf.λs.f
(define select-first (λ (f) (λ (s) f )))

; select-second:: λf.λs.s
(define select-second (λ (f) (λ (s) s )))

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


2.2 evaluate the following λexprs
a. ((λx.λy.(y x) λp.λq.p) λi.i)
b. (((λx.λy.λz.((x y) z) λf.λa.(f a)) λi.i) λj.j)
c. (λh.((λa.λf.(f a) h) h) λf.(f f)) 
d. ((Ap.xq.(p q) (Ax.x Aa.>\b.a)) Ak.k) 

|#

