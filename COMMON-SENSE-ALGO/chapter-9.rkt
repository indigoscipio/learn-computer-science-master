#lang racket

; CHAPTER 9: STACKS & QUEUES
; aka LIFO
; stack is just a restricted version of an array

; ====================================

; Simple racket implementation

; a Stack is a list-of-any
; '(1 2 3 4 5 6)
; where the head/top is the car

; CONSTRUCTORS
; void -> Stack
(define (make-stack)
  '())

; MODIFIERS
; pop:: Stack -> Stack
(define (pop stack)
  (if (null? stack)
      (error "Stack is empty!")
      (cdr stack)
      )
  )

;push:: Any Stack -> Stack
(define (push item stack)
  (cons item stack)
  )

;read:: Stack -> Any
(define (read stack)
  (if (null? stack)
      (error "Stack is empty!")
      (car stack)
      )
  )

; Examples
(define stack0 (make-stack))
(push 'i (push 'h stack0))

; ==========================================

; LINTER

; a Bracket is a type of either
; {,[,(,),],}


; char -> boolean
(define (brackets? char)
  (or (char=? char #\()
      (char=? char #\))
      (char=? char #\{)
      (char=? char #\})
      (char=? char #\[)
      (char=? char #\])
      )
  )

; list-of-chars -> boolean
; opening bracket -> push to stack
; finds closing -> pop the stack
; if popped item doesnt match, error (does not match closing braec)
; if popped item but stack is empty, error (doesn't have coresponding opening)
; if poped item match -> continue
; if end of bracket and its null -> no error, otherwise theres opening without closing
(define (eval-brackets str)
  (let* ((chars (string->list str))
         (clean-chars (filter (λ (c) (brackets? c)) chars))
         (BRACKETS-ASSOC-LIST '(( #\( . #\)) (#\[ . #\]) (#\{ . #\}) ) ))

    (define (evaluate xs stack)
      (cond [(null? xs) (null? stack) ] ; check if stack is empty
            [else (let* ((curr-bracket (car xs))
                         (opening-bracket? (assoc curr-bracket BRACKETS-ASSOC-LIST)))

                    ; check if its opening or closing bracket
                    (if opening-bracket?
                        (evaluate (cdr xs) (cons (car xs) stack)) ;push to stack
                        (cond [(null? stack) #f]
                              [else (let* ((top-stack (car stack))
                                           (matches? (assoc top-stack BRACKETS-ASSOC-LIST))
                                           )

                                      (if (equal? curr-bracket (cdr matches?))
                                          (evaluate (cdr xs) (cdr stack) )
                                          #f
                                          )
                                      )]
                              )
                        )
                    )]
            )
      )
    (evaluate clean-chars '())
    
    )
  )
(eval-brackets "(var x = {y: [1,2,3]})")


; ================================================

; QUEUE

; a Queue is a list-of-any
; where front is the (car xs)

; make-queue
(define (make-queue)
  '())

; enqueue
; put at the back
(define (enqueue item queue)
  (append queue (list item))
  )
(enqueue 3 '(1 2))

; dequeue
; remove front
(define (dequeue queue)
  (if (null? queue)
      (error "Queue is empty")
      (cdr queue)
      )
  )

; read
; read front queue
(define (rd queue)
  (if (null? queue)
      (error "Queue is empty")
      (car queue)
      )
  )

; =============================================

; EXERCISES

#|
1.  If you were writing software for a call center that places callers on hold
and then assigns them to “the next available representative,” would you
use a stack or a queue?

answer:
hmm if we place callers on hold
so its only a choice between which representative?
it has to be a queue since the person whos on hold needs to be the
processed right? itslike ordering something from restaurant
you cant treat last one to be the first/LIFO cause that doesnt makesense

|#

; =============================================

#|
2. If you pushed numbers onto a stack in the following order: 1, 2, 3, 4, 5, 6,
and then popped two items, which number would you be able to read
from the stack?

answer:


|#