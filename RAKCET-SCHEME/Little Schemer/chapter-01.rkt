#lang racket

; The Little Schemer
; learning notes Chapter 1

; Is it true that this is an atom?
; atom -> true because its a string

; turkey -> true because its a string

; 174 -> true because its a number

; *abc$ -> true because its a string

; 'atom -> true because it is a symbol




; =====================



; S-expression is either
; An Atom
; A List of S-Expression

; An Atom is either of the following
; Number
; Symbol
; Boolean
; String

; A List is parenthesis containing 0 or more s-expression

; Every atom is an S-expression
; Every list of S-expressions is itself an S-expression


; '(xyz) is an S-expression because it is a list of symbols
; '((x y) z) is an S-expression because it is a nested list which is also an S-expression
; '(how are you) is an S-expression because it is a list of strings

; how many S-expressions are in this list?
; '(how are you doing so far)
; and what are they?
; answer: how, are, you, doing, so , far, so 6 total inside the list
; if the outer list counts, then it would be 7 total, including the the list (how are you doing so far)

; is it true that this is a list?
; '(((how) are) ((you) (doing so)) far)
; yes because it is enclosed by a parenthesis

; how many S-expressions are in the list
; '(((how) are) ((you) (doing so)) far)
; answer: 3 total in the list
; 1 -> ((how) are)
; 2 -> ((you) (doing so))
; 3 -> far

; is it true that this is a list?
; '()
; yes because it is enclosed by a parenthesis even though its empty

; Is it true that this is an atom?
; '()
; false, this is a list

; Is it true that this is a list?
; '(() () () ())
; True, because it's enclosed by a parenthesis which contained 4 empty lists inside

; =================================

; THE LAW OF CAR
; THE PRIMITIVE CAR IS DEFINED ONLY FOR NON-EMPTY LISTS

; What is the car of l
; where l is the argument
; (a b c)
; answer: the car of l is a

; what is the car of l where l is ((a b c) x y z)
; answer: (a b c)

; what is the car of l
; where l is hotdog
; undefined because hotdog is an atom
; you can't ask for car of an atom

; what is the car of l where l is '()
; empty because it's an empty list
; you cannot ask for car of an empty list

; What is the car of l where l is
; (((hotdogs)) (and) (pickle) relish)
; answer: ((hotdogs))


;What is (car (car l)) wherel is
;(((hotdogs)) (and))
;answer: (hotdogs)

;What is the cdr of l where l is (a b c)
; answer: '(b c)


;What is the cdr of l where l is
;((a b c) x y z)
; answer: '(x y z)

;What is the cdr of l where l is (hamburger)
; answer: an empty list '()

;What is (cdr l) where l is ((x) t r)
; answer: '(t r)

;What is (cdr a) where a is hotdogs
; undefined you cant ask cdr of an atom


; =================================

; THE LAW OF CDR
; THE PRIMITIVE CDR IS DEFINED ONLY FOR NON-EMPTY LISTS
; THE CDR OF ANY NON-EMPTY LIST IS ALWAYS ANOTHER LIST
; cdr always returns another list unless if its empty


; What is (car (cdr l)) where l is ((b) (x y) ((c )))
; answer: '(x y)

; What is (cdr (cdr l)) where l is ((b) (x y) ((c )))
; answer: '((c))

;What is (cdr (car l)) where l is (a (b (c )) d)
; car l = a
; car a = error
;therefore it returns an error since you cannot car an atom

; What does car take as an argument
; a non-empty list of X

; what does cdr take as an argument
; a non-empty list of X

; what is the cons of the atom a and the list l where
; a is peanut
; l is (butter and jelly)
; (cons a l) -> '(peanut butter and jelly)
; because cons adds an atom to the front of a list

; cons of s and l
; where s is (banana and)
; l is (peanut butter and jelly)
; (cons s l ) -> '((banana and) peanut butter and jelly)
; because cons adds an S-expression in front of a list

; what is (cons s l)
; whre s is ((help) this)
; and l is (is very ((hard) to learn))
; answer: '(((help) this) is very ((hard to learn)))


; what does cons take as an argument?
; a pair of S-expression and any list

; what is (cons s l)
; where s is (a b (c))
; and l is '()
; answer: '((a b (c)))

; what is (cons s l)
; where s is a
; and l is ()
; answer: '(a)

; what is (cons s l)
; where s is '((a b c))
; and l is b
; answer: error because 2nd argument to cons takes a list

; what is (cons s l)
; where s is a
; and l is b
; answer: error because 2nd argument to cons must be a list


; =================================

; THE LAW OF CONS
; THE PRIMITIVE CONS TAKES 2 ARGUMETNS
; 1ST ARG -> ANY
; 2ND ARG -> MUST BE ALIST
; CONS RETURNS A LIST


; What is (cons s (car l))
; were s is a
; and l is ((b) c d)
; (car l) = '(b)
; answer: '(a (b))

; what is (cons s (cdr l))
; s = a
; l = ((b) c d)
; answer: '(a c d)

; is it true that in the list l is the null list
; where l is '()
; yes because it is composed of zero s-expession

; what is (null? (quote ()))
; #t because (quote()) = '()

; is (null? l) true or false where
; l is (a b c)
; false because it is a list of s expressions

; is (null? a) true or false where a is spaghetti
; erorr because we canot use null to an atom

; =================================

; THE LAW OF NULL?
; THE PRIMITIVE NULL? CEHCKS IF A LIST IS EMPTY

; is it true or false that sis an atom
; where s is harry?
; answer: true because Harry is a string

; is (atom? s) true/false
; where s is harry
; true

; is atom? s true or false
; where s is (Harry had a heap of apples)
; no because this is a list

; how many arguments does atom? take and what are they
; atom takes one argument of any S-expr.

; is (atom? (car l)) true or false
; where l is (harry had a heap of apples)
; true becaue harry is an atom

; is (atom? cdr l) true or false
; where l is (harry had a heap of apples)
; answer: false because (had a heap of apples) is a list

; Is (atom? (cdr l)) true or false 
; where l is (Harry)
; false because an empty list is a not an atom

; Is (atom? (car (cdr l))) true or false 
; where l is (swing low sweet cherry oat)
; yes because low is an atom

; Is (atom? (car (cdr l))) true or false 
; where l is (swing (low sweet) cherry oat)
; now because (low sweet) is not a atom

;  True or false: a1 and a2 are the same atom 
; where a1 is Harry and a2 is Harry
; true

; Is ( eq?1 a1 a2) true or false 
; where a1 is Harry and a2 is Harry
; answer: true

;Is ( eq? a1 a2) true or false 
; where a1 is margarine and a2 is butter
; answer: false because they are not equal atoms

; how many args eq take
; two argument of any non-numeric atoms

;s ( eq? l1 l2) true or false 
;where l1 is () and l2 is (strawberry)
;false because they are lists

; Is ( eq? n1 n2) true or false 
; where n1 is 6 and n2 is 7
; false because they are atoms

; =================================

; THE LAW OF EQ
; THE PRIMITIVE EQ? TAKES TWO ARGUMENTS
; EACH MUST BE A NON-NUMERIC ATOM

Is ( eq? (car l) a ) true or false 
where l is (Mary had a little lamb chop) and a is Mary
answer: eq? Mary Mary is true

Is ( eq? (cdr l) a ) true or false 
where l is (soured milk) and a is milk
answer: eq? (milk) milk -> false because one is a list and another one is an atom

Is ( eq? (car l) (car (cdr l))) true or false 
where l is (beans beans we need jelly beans)
answer: eq? beans beans = true
