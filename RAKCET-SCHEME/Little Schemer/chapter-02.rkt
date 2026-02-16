#lang racket

#|
True or false: (lat? l) 
where l is (Jack Sprat could eat no chicken fat)
answer: true because l is a list of atoms

True or false: (lat? l) 
where l is ((Jack) Sprat could eat no chicken fat)
answer: false because (jack) is no an atom and thereore l is not a list of atoms

True or false: (lat? l) where 
l is (Jack (Sprat could) eat no chicken fat)
answer: false because (sprat could) is not an atom

True or false: ( lat? l) 
where l is ()
answer: true because it does not contain a list

true or false: a lat is a list of atoms
answer: true

Write the function lat? using some, but not 
necessarily all, of the following functions: 
car cdr cons null? atom? and eq?
|#

(define lat? 
  (lambda (l) 
    (cond 
      ((null? l) #t ) 
      ((atom? (car l)) (lat? (cdr l))) 
      (else #f))))


what is the value of (lat? l)
where l is the argument (bacon and eggs)
answer: true because the list is a list of atoms

how do we determine the answer #t for the application (lat? l)
if l are each atoms it returns true

what is the first question asked by (lat? l)
null? l

what is the meaning of the cond-line
(null? l) #t where l is (bacon and eggs)
if thelist is empty then return true, bacon and eggs is noe empty

what is the next question?
(atom? car l...)

what is the meaning of the line
((atom? (car l)) (lat? (cdr l))) where l is (bacon and eggs)
first it checks if "bacon" is an atom
if so, run the procedure (lat? (and eggs))

what is the meaning of (lat? (cdr l))
is the rest of the list a list of atom?

what is the argument l for lat?
(and eggs)

what is the next question?
null? (and eggs)

What is the meaning of the line 
((null? l) #t ) 
where l is now (and eggs)
false

what is the next question?
((atom? (car l)) (lat? (cdr l)))

what is lat?
lat is a procedure that, given a list of s-expressions
check if each of them is an atom.
if so, return true. else (if it finds a list) return false.



; The first commandment
; always ask null? as the first question in expressing any function

what is the meaning of the ilne ((null? lat) #f)
where lat is (mashed potatoes and meat gravy)
null lat = false, (#f #f) ->

