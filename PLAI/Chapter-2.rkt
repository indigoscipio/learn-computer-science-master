#lang plai-typed

(define-type MisspelledAnimal
[caml (humps : number)]
[yacc (height : number)])

(caml 2)
(yacc 10)

(define (get-info [a : MisspelledAnimal]) : number
  (type-case MisspelledAnimal a
    [caml (h) h]
    [yacc (ht) ht]))
(get-info (yacc 2))

(define (good? [ma : MisspelledAnimal]) : boolean
  (type-case MisspelledAnimal ma
    [caml (humps) (>= humps 2)]
    [yacc (height) (> height 2.1)]))
  
(define ma1 (caml 2))
(test (good? ma1) #t)
(test (good? ma1) #f) 