#lang simply-scheme

(define (square n) (* n n))

#|
9.1 what will scheme print? figure it out before try it on the compuer


(lambda (x) (+ (* x 3) 4))
; returns  a procedure/lambda

((lambda (x) (+ (* x 3) 4)) 10)
;34

(every (lambda (wd) (word (last wd) (bl wd)))
       '(any time at all))
;yan etim ta lal

((lambda (x) (+ x 3)) 10 15)
; error

|#

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

#|

9.2 Rewrite the following definitions so as to make the implicit lambda explicit.
1. (define (second stuff)
  (first (bf stuff)))
2. (define (make-adder num)
  (lambda (x) (+ num x)))

(lambda (stuff) (first (bf stuff)))
(((lambda (num) (lambda (x) (+ num x)) ) 3) 5)

|#

#|
9.3 What does this procedure do?
(define (let-it-be sent)
  (accumulate (lambda (x y) y) sent))

answer:
the procedure takes sent which is a list
example sent = '(1 2 3) or can be words
then insidie accum it checks

'(2 3) -> return 3
next call '(1 3) -> return 3

so it only retunrs the last thing in the list

|#

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

#|
real exercisel
9.4
The following program doesn't work. Why not? Fix it


(define (who sent)
  (every describe '(pete roger john keith)))

(define (describe person)
  (se person sent))

> (who '(sells out))
(pete sells out roger sells out john sells out keith sells out)

|#

; it doesn't work because the sent inside (describe person) is not defined and only exists within who
; to fix it just define replace describe proc as anonymous lambda

#|
(define (who sent)
  (every (lambda (person) (se person sent) ) '(pete roger john keith)))

(who '(sells out))
|#

; or alternatively make describe take 2 args


#|

In each of the following exercises, write the procedure in terms of lambda and higher-order functions. Do not use 
named helper procedures. If you've read Part IV, don't use recursion, either.

9.5 write prepend-every

> (prepend–every 's '(he aid he aid))
(SHE SAID SHE SAID)

> (prepend–every 'anti '(dote pasto gone body))
(ANTIDOTE ANTIPASTO ANTIGONE ANTIBODY)

|#

(define (prepend-every wd sent)
  (every (lambda (x) (word wd x) ) sent)
  )


#|

9.6 Write a procedure sentence–version that takes a function F as its argument and returns a function G. F 
should take a single word as argument. G should take a sentence as argument and return the sentence formed by 
applying F to each word of that argument.

|#

(define (sentence-version f)
  (lambda (sent) (every f sent) )
  )
((sentence-version first) '(if i fell))
((sentence-version square) '(8 2 4 6 ))

#|
9.7 Write a procedure called letterwords that takes as its arguments a letter and a sentence. It returns a sentence 
containing only those words from the argument sentence that contain the argument letter:

> (letterwords 'o '(got to get you into my life))
(GOT TO YOU INTO)

|#

(define (letterwords wd sent)
  (every (lambda ... ....) sent)
  )