#lang racket

; Number -> [Symbol -> Number]
(define (make-circle r)
  (define (dispatch msg)
    (cond [(eq? msg 'area) (* pi r r)]
          [(eq? msg 'perimeter) (* 2 pi r)]
          [else (error "UNKNOWN MSG" msg) ]
          )
    )
  dispatch
  )

; Number Number -> [Symbol -> Number]
(define (make-from-real-imag x y)
  (define (dispatch op)
    (cond [(eq? op 'real-part) x]
          [(eq? op 'imag-part) y]
          [(eq? op 'magnitude) (sqrt (+ (sqr x) (sqr y) ))]
          [(eq? op 'angle) (atan y x)]
          [else (error "Unknown OP - make-from-real-imag" op)]
          )
    )
  dispatch
  )
(define smart-data (make-from-real-imag 3 5))
(smart-data 'real-part)


;exericse 2.75
;message passing style

; Number Number -> [Symbol Number]
; takes magnitude and angle, returns a smart complex number
(define (make-from-mag-ang r a)
  (define (dispatch op)
    (cond [(eq? op 'real-part) (* r (cos a))]
          [(eq? op 'imag-part) (* r (sin a))]
          [(eq? op 'magnitude) r]
          [(eq? op 'angle) a]
          [else (error "Unknown OP - make-from-mag-ang" op)])
    )
  dispatch
  )


;Exercise 2.73
;; Operation, type -> procedure
; make-hash creates a new mutable hash table
(define *op-table* (make-hash))


;; put : op type proc -> Void
;; store proc under key (list op type)
; hash-set! mutates the table
(define (put op type proc)
  (hash-set! *op-table* (list op type) proc))     


;; get : op type -> proc or #f
;; retrieve the procedure stored under (list op type)
; hash-ref looks up a key, returns default #f if absent
(define (get op type)
  (hash-ref *op-table* (list op type) #f))



(define (attach-tag type-tag contents)
  (cons type-tag contents))
(define (type-tag datum)
  (if (pair? datum)
      (car datum)
      (error "Bad tagged datum: TYPE-TAG" datum)))
(define (contents datum)
  (if (pair? datum)
      (cdr datum)
      (error "Bad tagged datum: CONTENTS" datum)))

                 


(define (install-polar-package)
  ;; internal procedures
  (define (magnitude z) (car z))
  (define (angle z) (cdr z))
  (define (make-from-mag-ang r a) (cons r a))
  (define (real-part z) (* (magnitude z) (cos (angle z))))
  (define (imag-part z) (* (magnitude z) (sin (angle z))))
  (define (make-from-real-imag x y)
    (cons (sqrt (+ (sqr x) (sqr y)))
          (atan y x)))
  ;; interface to the rest of the system
  (define (tag x) (attach-tag 'polar x))
  (put 'real-part '(polar) real-part)
  (put 'imag-part '(polar) imag-part)
  (put 'magnitude '(polar) magnitude)
  (put 'angle '(polar) angle)
  (put 'make-from-real-imag 'polar
       (lambda (x y) (tag (make-from-real-imag x y))))
  (put 'make-from-mag-ang 'polar
       (lambda (r a) (tag (make-from-mag-ang r a))))
  'done)

(install-polar-package)
(define real-part-polar (get 'real-part '(polar)))
(define make-from-mag-ang-polar (get 'make-from-mag-ang 'polar))
(define z (make-from-mag-ang-polar 5 0.5))  ; z is tagged with 'polar
(real-part-polar (contents z ))


; Apply Generic
(define (apply-generic op . args)
  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (if proc
          (apply proc (map contents args))
          (error "No method for these types: APPLY-GENERIC"
                 (list op type-tags))))))

(apply-generic 'real-part z)
