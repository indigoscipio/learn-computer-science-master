#lang simply-scheme

; boring exercise;
; what values are printed whyn you type these expression on scheme?

(sentence 'I '(me mine)) ; '(I me mine)
(sentence '() '(is empty)) ; '(is empty)
(word '23 '45) ;'2345
(se '23 '45) ;'2345
(bf 'a)
(bf '(aye))
(count (first '(maggie mae)) )

;5.2 for each write a procedure of 2 args that when applied to sample arguments
; return the sample result

; (f1 '(a b c) '(d e f)) -> (B C D E)
(define (f1 arg1 arg2)
  (bl (bf (se '(a b c) '(d e f))))
  )

; (f2 '(a b c) '(d e f)) -> (B C D E AF)
(define (f2 arg1 arg2)
  (se (se (bf arg1) (bl arg2)) (word (first arg1) (last arg2)) )
  )
(f2 '(a b c) '(d e f))

; (f3 '(a b c) '(d e f)) -> '(A B C A B C)
(define (f3 arg1 arg2)
  (se arg1 arg1)
  )
(f3 '(a b c) '(d e f))

; (f4 '(a b c) '(d e f)) -> BE
(define (f4 arg1 arg2)
  (word (first (bf arg1)) (first (bf arg2))) 
  )
(f4 '(a b c) '(d e f))

; 5.3
; Explain the difference in meaning between (first 'mezzanine) and (first '(mezzanine)).
; first 'mezzanine -> looks at the input (list of chars) -> since m is the first item it outputs m
; first '(ezzanine) -> looks at the input (list of words) -> since mezzanine is the first word it outputs mezzanine

; 5.4
; Explain the difference between the two
; expressions (first (square 7)) and (first '(square 7)).
; (first (square 7)) -> evaluates sqr 7 -> which is number, then feed into first. result is error since first expects a list not a number
; (first '(square 7)) -> this one ist a list of chars with square and 7. outputs square sine its the first item on the list


;5.5
; explain diff between (word 'a 'b 'c) and (se 'a 'b 'c)
; word concatenates its raguments into a insgle word, so (word 'a ' b 'c) return the symbol 'abc concatenated
; while sentence appends each argumet into a  list so se a b c = '(a b c)

;5.7 Explain the difference between (bf 'x) and (butfirst '(x)).
; butfirst 'x -> since the input is a character/symbol it looks at the remainig character, which is none (empty string)
; so it returns empty string
; butfirst '(x) -> since hte input here is a list with 1 item, it tries to look at the rest of the item which is empty
; so ir returns empty l ist

; 5.8
; which of the following are lgal scheme sentence?


(se (word (bl (bl (first '(make a)))) ;ma
          (bf (bf (last '(baseball mitt))))) ;tt
    (word (first 'with) (bl (bl (bl (bl 'rigidly)))) ;wrig
          (first 'held) (first (bf 'stitches)))) ;ht
; matt wright

(se (word (bl (bl 'bring)) 'a (last 'clean)) ; bri a n
    (word (bl (last '(baseball hat))) (last 'for) (bl (bl 'very)) ; ha r ve
          (last (first '(sunny days))))) ;y
;(brian harvey)

; 5.10
; what kinds of argument can you give butfirst so it returns a word?
; just insert a word -> it will return another word
(butfirst 'hello)
(butfirst '(hello hey))

;5.12 Which of the functions first, last, butfirst, and butlast can return an empty word? For what 
; arguments? What about returning an empty sentence

; first and last can never return an empty word
; bl bf can return empty word

; 5.13
; what does "banana stand for?
; what is (first "banana) and why?
; it returns an error because "banana is a half quoted string and not a symbol
; first expects a word/symbol/list as argument

;5.14 Write a procedure third that selects the third letter of a word (or the third word of a sentence).
(define (third expr)
  (first (bf (bf expr)))
  )
(third '(a b c d))

(define (two-first a b)
  (word (first a) (first b))
  )
(two-first 'brain 'epstein)

(define (two-first-sent l)
  (word (first l) (first (bf l)) )
  )

before?

;5.20
(define (middle-names l)
  (se (bf (bl l)) )
  )

(= 3 4)