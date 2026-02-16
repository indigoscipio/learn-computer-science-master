#lang racket

#|
(define x (cons 'chicago (cons 'pizza '())))
(set! x 'skins)

(define (gourmet food)
  (cons food (cons x '()))
  )
(gourmet 'onion)
(set! x 'rings)
(gourmet 'onion)

(define (gourmand food)
  (set! x food)
  (cons food (cons x '()))
  )
(gourmand 'nigga)

(define (diner food)
  (set! x food)
  (cons 'milkshake (cons food '()))
  )
(diner 'egg)
(diner 'lol)

(define omnivore
  (let ((x 'minestrone))
    (lambda (food) (set! x food)
      (cons food (cons x '()))  )
    )
  )
(define (omnivore.v2 food)
  (let ((x 'minestrone))
    (set! x food)
    (cons food (cons x '()))
    )
  )
(omnivore 25)
(omnivore 55)
(omnivore.v2 25)
(omnivore.v2 55)

; Sixteenth commandment
; use set! only with names defined in (let...)s

(define food 'none)

(define (glutton x)
  (set! food x)
  (cons 'more (cons x (cons 'more (cons x '()))) )
  )
(glutton 'garlic)

; The eighteenth commandment
; use set! only when the value that x refers to is no longer needed

(define (chez-nous)
  (let ((a food))
    (set! food x)
    (set! x a)
    )
  )


(define (sweet-tooth food)
  (cons food (cons 'cake '()))
  )
(sweet-tooth 'sugar)

(define last 'angelfood)

(define (sweet-toothL food)
  (set! last food)
  (cons food (cons 'cake '()))
  )
(sweet-toothL 'strawberry)
(sweet-toothL 'carrot)
(sweet-toothL 'cheese)

(define ingredients '())
; like sweet tooth l but remembers the ingredient
(define (sweet-toothR food)
  (set! ingredients (cons food ingredients))
  )

|#

; Number -> List-of-x
(define (deep m)
  (cond [(zero? m) 'pizza]
        [else (cons (deep (sub1 m)) '())])
  )

(define Ns '())
(define Rs '())

(define (deepR m)
  (let ((result (deep m)))
    (set! Ns (cons m Ns))
    (set! Rs (cons result Rs))
    result
    )
  )
(deepR 3)
(deepR 0)
(deepR 1)
(deepR 5)


; The Nineteenth Commandment
; use (set! ...) to remember valuable things between two distinct uses of a function

(define (find n ns rs)

  #|
  (let* ((table (map (lambda (n r) (cons n r) ) ns rs))
         (result (assoc n table))
         )
    (if result (cdr (assoc n table)) #f)    
    )
  |#

  (letrec ((R (lambda (ns rs) (cond [(null? ns) #f]
                                    [(eq? (car ns) n) (car rs)]
                                    [else (R (cdr ns) (cdr rs) )]) )))
    (R ns rs)
    )
  
  )
(find 5 Ns Rs)

(define (deepM n)
  (cond [(member n Ns) (find n  Ns Rs)]
        [else (deepR n)])
  )

; Length using set
(define (length l)
  (let ((h (lambda (l) 0)))
    (set! h (L (lambda (arg) (h arg)))h)
    )
  )