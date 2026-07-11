#lang racket

; CHAPTER 10
; IMPLEMENTING PROGRAMMING LANGUAGES

; extended Backus–Naur form (EBNF)

;  APMSEisasymbol,anumber, astring, a boolean, or a list of PMSEs.

#|
Exercise 10.1

The categories number , string, and boolean are directly testable by the corre
sponding Scheme procedures number?, string?,andboolean?,but name does
not have an exact Scheme correlate. You will write one in this exercise.

a. Recall that the symbols lambda, quote, andif that are disallowed as names
because of their special usage in Micro-Scheme are called keywords. Write a
predicate keyword? that tests whether its argument is a keyword.
b. Write the predicate name?. You will need to use the built-in Scheme procedure
symbol?.

answer:
|#

; part a
(define (keyword? arg)
  (or (equal? arg 'lambda)
      (equal? arg 'quote)
      (equal? arg 'if))
  )

; part b
(define (name? arg)
  (and (symbol? arg)
       (not (keyword? arg))
       )
  )

#|

; Exercise 10.2

Even when a category is directly testable by Scheme, using EBNF to express it at a
more primitive level can help you appreciate the expressive power of EBNF. In this
exercise you will use EBNF to describe certain kinds of numbers—a small subset of
those allowed by Scheme.

a. Write a production for unsigned-integer . You can use the productions for digit
given above.

b. Next write productions for integer ;an integer may start with a- sign, a + sign,
or neither.

c. Finally, write productions for real-number , which are (possibly) signed numbers
that may have a decimal point. Note that if the real number has a decimal point,
there must be at least one digit to the left or to the right (or both) of the decimal
point. Thus, 43., .43, 43, 43.21, and 43.0 are all valid real numbers.

a.
unsigned-integer -> digit+

b.
integer -> -digit+ | +digit+ | unsigned-integer

c.
unsigned-decimal -> digit+.digit* | digit*.digit+ 
real-number -> integer | unsigned-decimal | -unsigned-decimal | +unsigned-decimal

|#


#|
Exercise 10.3

In Section 8.3 we considered expression trees for simple arithmetic expressions.
All such expressions are either numbers or lists having an operator (one of +,-,
*,or/) and two operands. Actually, there are three important variants, depending
on where the operator occurs: in the first position (prefix or Scheme notation),
the second position (infix or standard notation), or the third position (postfix, also
known as Reverse Polish notation, or RPN). Let’s consider how such expressions can
be specified using EBNF.

a. Write productions for arithmetic-prefix-expression.
b. Write productions for arithmetic-infix-expression.
c. Write productions for arithmetic-postfix-expression.
d.  As noted in Section 8.3, a postorder traversal of an expression tree re
sults in a list of the nodes that is identical to the language specified by
arithmetic-postfix-expression, except that subexpressions are not parenthesized.
Revise the productions for arithmetic-postfix-expression so that subexpressions
are not parenthesized. (The overall top-level expression needn’t be parenthesized
either.)

answer:

a.
arith-op -> + | - | * | /
operand -> number | arithmetic-prefix-expression
arithmetic-prefix-expression -> number | (arith-op operand operand)

b.
arith-op -> + | - | * | /
operand -> number | arithmetic-infix-expression
arithmetic-infix-expression ->  (operand arith-op operand) | number 

c.
arith-op -> + | - | * | /
operand -> number | arithmetic-postfix-expression
arithmetic-postfix-expression ->  (operand operand arith-op) | number 

d.
arith-op -> + | - | * | /
operand -> number | arithmetic-postfix-expression
arithmetic-postfix-expression ->  operand operand arith-op | number 



|#


#|
10.4
Our grammar for Micro-Scheme says that an (application) is of the form
((expression)+). Someauthors prefer to instead say that it is of the form
((expression)(expression)*)



answer:
ok let me understnad this
((expression)(expression)*) -> coz some functions can take no args

but in ((expression)+) -> it must take at least 1 args so its a rquirement

both are function defintion
both rqeuire the function name

(square 5) -> square is expr, 5 is expr
(ping) -> 1 epxr

theyre both 1 expr min
its about structure

|#


#|
10.6
Determinewhichof the followingPMSEs are syntactically validMicro-Scheme
expressionsandexplainwhy.

a. (if 3 1 5)
b. (lambda x (+ x 2))
c. (((a((b)))c))
d. (lambda (lambda) 3)
e. (lambda () lambda)
f. (lambda (x) (if (> x 0) x (- x) 0))
g. (lambda () x)
h. (lambda ())
i. (/)
j.  (#t #f)

answer:
ok from prev we have
digit -→ 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9
expression -→ name | constant | conditional | abstraction | application
constant -→ literal | quotation
literal -→ number | boolean | string
conditional -→ (if expression expression expression)
abstraction -→ (lambda (name*) expression)
quotation -→ (quote datum)
application -→ (expression )
name -→ any symbol allowed by the underlying Scheme except lambda, quote, and if
number -→ any number allowed by the underlying Scheme
string -→ any string allowed by the underlying Scheme
boolean -→ any boolean allowed by the underlying Scheme
datum -→ any datum allowed by the underlying Scheme

a. valid
b. invalid, x needs to be inside parentheiss
c. valid, a,b,c are name which is expr
d. inner lambda not valid cant be used as param
e. lambda inside outler lambda (body) not valid
f. if inside lambda not valid (4 exprs)
g. valid abstraction
h.  bo body inside lambda, ont valid
i. valid function app
j. valid, function app
|#

;====================================================================================


#|
Exercise 10.7
Why does the mutual recursion between syntax-ok? and the action procedures
eventually stop when we check the syntax of (if 3 1 5)? Why will it eventually
stop on any list-structured PMSE?

answer:
coz expr may contain another expr so it needs to be peeled of first until it eventually
reach the base case for expr eg number symbols boolean or str atomic values


Exercise 10.8
What happens if the PMSE being checked is the empty list?


|#


;====================================================================================


#|

Exercise 10.9
The action for ifs parses all three subexpressions into ASTs and passes the three
resulting ASTs to make-conditional-ast. Similarly, the action for lambda expres
sions parses the body. However, it doesn’t parse the parameters. Why not?

answer:
the param is a atomic value like name / var
no more layers to peel


|#
