#lang simply-scheme

(append '(2 3) '((2 3) () 4 5))

; use list only when you know how many leements are there in your complete list



#|
17.1 What will Scheme print in response to each of the following expressions?
Try to figure it out in your head before 
you try it on the computer.
(car '(Rod Chris Colin Hugh Paul))
(cadr '(Rod Chris Colin Hugh Paul))
(cdr '(Rod Chris Colin Hugh Paul))
(car 'Rod)
(cons '(Rod Argent) '(Chris White))
(append '(Rod Argent) '(Chris White))
(list '(Rod Argent) '(Chris White))
(caadr '((Rod Argent) (Chris White)
           (Colin Blunstone) (Hugh Grundy) (Paul Atkinson)))
(assoc 'Colin '((Rod Argent) (Chris White)
                  (Colin Blunstone) (Hugh Grundy) (Paul Atkinson)))
(assoc 'Argent '((Rod Argent) (Chris White)
                   (Colin Blunstone) (Hugh Grundy) (Paul Atkinson)))

answer:
(car '(Rod Chris Colin Hugh Paul)) ; rod
(cadr '(Rod Chris Colin Hugh Paul)) ;chris
(cdr '(Rod Chris Colin Hugh Paul)) ;'(chris colin uhgh paul)
; (car 'Rod) ; error not a list
(cons '(Rod Argent) '(Chris White)) ; ((rod argent) christ white)
(append '(Rod Argent) '(Chris White)) ;(rod argent chris whtie)
(list '(Rod Argent) '(Chris White)) ;'((rod argent)(chris white))
(caadr '((Rod Argent) (Chris White)(Colin Blunstone) (Hugh Grundy) (Paul Atkinson))) ;chris
(assoc 'Colin '((Rod Argent) (Chris White) (Colin Blunstone) (Hugh Grundy) (Paul Atkinson))) ;colin bluntstone
(assoc 'Argent '((Rod Argent) (Chris White) (Colin Blunstone) (Hugh Grundy) (Paul Atkinson))) ;#f
|#

; =======================================

#|
17.2 For each of the following examples, write a procedure of two arguments that, when applied to the sample 
arguments, returns the sample result. Your procedures may not include any quoted data.
Page 300
> (f1 '(a b c) '(d e f))
((B C D))
> (f2 '(a b c) '(d e f))
((B C) E)
> (f3 '(a b c) '(d e f))
(A B C A B C)
> (f4 '(a b c) '(d e f))
((A D) (B C E F))
|#
(define (f1 se1 se2)
  (list (list (cadr se1) (last se1) (car se2)))
  )
(f1 '(a b c) '(d e f))

(define (f2 se1 se2)
  (list (cdr se1) (cadr se2))
  )
(f2 '(a b c) '(d e f))

(define (f3 se1 se2)
  (append se1 se1)
  )
(f3 '(a b c) '(d e f))

(define (f4 se1 se2)
  (list (list (car se1) (car se2)) (append (cdr se1) (cdr se2)))
  )
(f4 '(a b c) '(d e f))

; =======================================

#|
17.3 Describe the value returned by this invocation of map:
> (map (lambda (x) (lambda (y) (+ x y))) '(1 2 3 4))
|#

((car (map (lambda (x) (lambda (y) (+ x y))) '(1 2 3 4))) 10)
; binds x = 1, then inside return another function that waits for another number
; so it seems like adding function that waits for y? 
; returns a list function that awais for argument y and adds that with x


; =======================================

; REAL EXERCISE

#|
17.4 Describe the result of calling the following procedure with a list as its argument.
(See if you can figure it out before you try it.)

(define (mystery lst)
  (mystery–helper lst '()))

(define (mystery–helper lst other)
  (if (null? lst)
      other
      (mystery–helper (cdr lst) (cons (car lst) other))))

answer:
its a list rebuilding function where mysery helper
it other stores the accumulated list/result in reversed order
everytime mystery helper runs it stores the first item in the list into tother
and recurse with decreased list

|#


; =============================================

#|
17.5 Here's a procedure that takes two numbers as arguments and returns whichever number is larger:

(define (max2 a b)
  (if (> b a) b a))

Use max2 to implement max, a procedure that takes one or more
numeric arguments and returns the largest of them
|#
(define (max2 a b)
  (if (> b a) b a))

(define (my-max fst-arg . rest-args)
  (cond [(empty? rest-args) fst-arg]
        [else (apply my-max (cons (max2 fst-arg (car rest-args)) (cdr rest-args)))]
        )
  )
(my-max 1 2 3 8 7 -55 11)

; ===================================================

#|
17.6 Implement append using car, cdr, and cons.
(Note: The built-in append can take any number of arguments.
First write a version that accepts only two arguments.
Then, optionally, try to write a version that takes any number.)
|#

(define (append-car se1 se2)
  ; recurse through se1, store result inse 2
  (cond [(empty? se1) se2]
        [(empty? se2) se1]
        [else (cons (car se1) (append-car (cdr se1) se2))]
        )
  )
(append-car '() '(a b c)) ;'(a b c)
(append-car '(a b c) '()) ;'(a b c)
(append-car '(a b c) '(d e f)) ;'(a b c d e f)

(define (append-car-anyargs . args)
  (cond [(empty? args) '()]
        [(empty? (cdr args)) (car args)] ;one item left, just return that item
        [else (let ((fst (car args))
                    (sec (cadr args))
                    (rest (cddr args))
                    )
                (apply append-car-anyargs (cons (append-car fst sec) rest))
                ) ]
        )
  )
(append-car-anyargs '() '(a b c)) ;'(a b c)
(append-car-anyargs '() '()) ;'()
(append-car-anyargs '()) ;'()
(append-car-anyargs '(a b) '(d e) '(g h)); '(a b c d e f g)


#|
17.7 Append may remind you of sentence. They're similar, except that append works only with lists as 
arguments, whereas sentence will accept words as well as lists. Implement sentence using append.
(Note: The built-in sentence can take any number of arguments. First write a version that accepts
only two arguments. Then, optionally, try to write a version that takes any number.
Also, you don't have to worry about the error checking that the real sentence does.)
|#

; word/list word/list -> list-of-x
(define (my-sentence xs ys)

(cond []
      [])
  )
