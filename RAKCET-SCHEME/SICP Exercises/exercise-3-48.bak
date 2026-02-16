#lang sicp


; () -> Serialized Procedure
(define (make-serializer)
  (let ((mutex (make-mutex) ))
    (lambda (p)(define (serialized-p . args)
                 ; acquire the mutex,
                 (mutex 'acquire)

                 ; runs the procedure to the list of arguments
                 (let ((val (apply p args)))
                   (mutex 'release)
                   val
                   )
                 )
      serialized-p
      )
    )
  )



(define (clear! cell) (set-car! cell false))


(define (make-mutex)
  ; A Cell is a one element list that holds true/false
  ; during initializaiton, a mutex's cell is set to false
  ; (list false) or (list true)
  (let ((cell (list false)))
    ; think of the mutext as a dispatch/message passing-style
    (define (the-mutex m)
      (cond [(eq? 'acquire) (if (test-and-set! cell)
                                (the-mutex 'acquire) ;if busy, retry
                                'ok ;if free, proceed
                                ) ]
            [(eq? 'release) (clear! cell)]
            )
      )
    the-mutex
    )
  )

 (define (test-and-set! cell)
 (if (car cell) true (begin (set-car! cell true) false)))



; Exercise 3.46
; test-and-set without making the operation atomic

; Problem: Another process can sneak in between these steps!

; answer:
; if we define test and set as non-atomic (as shown in the text above)
; when we change the value of the car cell
; there could ba another process that runs between the steps, they can see the value of car cell and might set the car cell to true, cuasing race condition/interweaving
; in the atomic version we avoid this
; and guarantees no operation will interfere in the middle of the operation.

; example
; test-and-set! cell0 (list false) -> P1
; test-and-set! cell0 (list false) -> P2
; both runs at the same time concurrently
; P1 checks if cell0 is true -> false
; evaluate (begin (set-car! cell true) false)
; but before setting cell0 to true, it is interupted by P2
; P2 now checks cell -> false
; sets cell0 to true and return false by P2
; P1 now resumes, setting cell0 to true, overwriting P2's set
; P1 also sets cell0 to true and returns false
; they both think they've acquired the mutex but only 1 shoudl have
; this violates mutual exclusion


; Exercise 3.47, part a
;; make-semaphore : Number -> (Symbol -> Void)
;; Given a max concurrent count, returns a dispatcher that supports:
;;   'acquire : tries to reserve one spot (waits if unavailable)
;;   'release : frees one reserved spot
(define (make-semaphore n)
  (let ((mutex (make-mutex))
        (count (list n))
        )

    (define (acquire)
      (mutex 'acquire)
      (cond [(> (car count) 0) (begin
                                 (set-car! count (sub1 (car count)))
                                 (mutex 'release)
                                 ) ]
            [else (begin (mutex 'release)
                         (retry-acquire)) ])
      )

    (define (release)
      (mutex 'acquire)
      (set-car! count (add1 (car count)))
      )
    
    (define (dispatch m)
      (cond [(eq? m 'acquire)  (acquire)]
            [(eq? m 'release) (release)]
            [else (error "Unknown Operation MAKE-SEMAPHORE" m)]
            )
      )
    )
  )


(define (make-mutex)
  ; A Cell is a one element list that holds true/false
  ; during initializaiton, a mutex's cell is set to false
  ; (list false) or (list true)
  (let ((cell (list false)))
    ; think of the mutext as a dispatch/message passing-style
    (define (the-mutex m)
      (cond [(eq? 'acquire) (if (test-and-set! cell)
                                (the-mutex 'acquire) ;if busy, retry
                                'ok ;if free, proceed
                                ) ]
            [(eq? 'release) (clear! cell)]
            )
      )
    the-mutex
    )
  )

(define (test-and-set! cell)
  (if (car cell) true (begin (set-car! cell true) false)))

; exercise 3.47, part B
(define (make-semaphore n)
  (let ((mutex (make-mutex)))
    (define (dispatch m)
      (cond [(eq? m 'acquire) ...]
            [(eq? m 'release) ...]
            [else (error "Unknown Operation MAKE-SEMAPHORE" m)]
            )
      )
    dispatch
    )

  )