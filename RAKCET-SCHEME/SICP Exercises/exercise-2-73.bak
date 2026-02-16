#lang racket

; Constructors
; creates comples number with rectangular form (real and imaginary)
; Number Number -> ComplexNumber
(define (make-from-real-imag real imag)
  0
  )

; Creates complex number with polar form (magnitude & angle)
; Number Number -> ComplexNumber
(define (make-from-mag-ang mag ang)
  0
  )

; Selectors
; Ben's Part
(define (real-part-rectangular z) (car z))
(define (imag-part-rectangular z) (cdr z))
(define (magnitude-rectangular z)
  (sqrt (+ (sqr (real-part-rectangular z))
           (sqr (imag-part-rectangular z)))))
(define (angle-rectangular z)
  (atan (imag-part-rectangular z)
        (real-part-rectangular z)))
(define (make-from-real-imag-rectangular x y)
  (attach-tag 'rectangular (cons x y)))
(define (make-from-mag-ang-rectangular r a)
  (attach-tag 'rectangular
              (cons (* r (cos a)) (* r (sin a)))))

;Alyssa's Part
(define (real-part-polar z)
  (* (magnitude-polar z) (cos (angle-polar z))))
(define (imag-part-polar z)
  (* (magnitude-polar z) (sin (angle-polar z))))
(define (magnitude-polar z) (car z))
(define (angle-polar z) (cdr z))
(define (make-from-real-imag-polar x y)
  (attach-tag 'polar
              (cons (sqrt (+ (sqr x) (sqr y)))
                    (atan y x))))
(define (make-from-mag-ang-polar r a)
  (attach-tag 'polar (cons r a)))

; Math Operations
; ComplexNumber ComplexNumber -> ComplexNumber
(define (add-complex z1 z2)
  (make-from-real-imag (+ (real-part z1) (real-part z2) )
                      (+ (imag-part z1) (imag-part z2)) )
  )

(define (sub-complex z1 z2)
  (make-from-real-imag (- (real-part z1) (real-part z2) )
                      (- (imag-part z1) (imag-part z2)) )
  )

(define (mul-complex z1 z2)
  (make-from-mag-ang (* (magnitude z1) (magnitude z2) )
                     (+ (magnitude z1) (magnitude z2) ))
  )

(define (div-complex z1 z2)
  (make-from-mag-ang (/ (magnitude z1) (magnitude z2))
                     (- (angle z1) (angle z2) ))
  )


;Type Tags
(define (attach-tag type-tag contents)
  (cons type-tag contents)
  )

(define (type-tag datum)
  (cond [(pair? datum) (car datum)]
        [else (error "Bad tagged datum: TYPE-TAG" datum)])
  )

(define (contents datum)
  (cond [(pair? datum) (cdr datum)]
        [else (error "Bad tagged datum: CONTENTS" datum)])
  )

(define (rectangular? z)
  (eq? (type-tag z) 'rectangular)
  )

(define (polar? z)
  (eq? (type-tag z) 'polar)
  )


;TypeTag -> Number
(define (imag-part z)
  (cond [(rectangular? z) (real-part-rectangular (contents z))]
        [(polar? z) (real-part-polar (contents z))]
        [else (error "UNKNOWN TYPE: IMAG-PART" z)])
  )



;; Operation, type -> procedure
;; Dispatch table.
;; 
(define *op-table* (make-hash-table 'equal))

(define (put op type proc)
  (hash-table-put! *op-table* (list op type) proc))

(define (get op type)
  (hash-table-get *op-table* (list op type) '()))


(define (install-rectangular-package)
  ;; internal procedures
  (define (real-part z) (car z))
  (define (imag-part z) (cdr z))
  (define (make-from-real-imag x y) (cons x y))
  (define (magnitude z)
    (sqrt (+ (sqr (real-part z))
             (sqr (imag-part z)))))
  (define (angle z)
    (atan (imag-part z) (real-part z)))
  (define (make-from-mag-ang r a)
    (cons (* r (cos a)) (* r (sin a))))
  ;; interface to the rest of the system
  (define (tag x) (attach-tag 'rectangular x))
  (put 'real-part '(rectangular) real-part)
  (put 'imag-part '(rectangular) imag-part)
  (put 'magnitude '(rectangular) magnitude)
  (put 'angle '(rectangular) angle)
  (put 'make-from-real-imag 'rectangular
       (lambda (x y) (tag (make-from-real-imag x y))))
  (put 'make-from-mag-ang 'rectangular
       (lambda (r a) (tag (make-from-mag-ang r a))))
  'done)
