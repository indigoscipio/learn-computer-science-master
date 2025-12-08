#lang racket

; a Parenthesis is either of the following:
; #\)
; #\(
; interpretaton represents the opening/closing parenthesis of a code expression

; a Parentheses is a list of parenthesis
; a Stack is a list of parenthesis

; ( -> push stack
; ) -> pop stack

; Parenthesis Stack -> Stack
; inserts a new item to the top of the stack
(define (push x stack)
  (cons x stack)
  )

; Stack -> Stack
; removes the most recent item from a stack
(define (pop stack)
  (cdr stack)
  )

; String -> Boolean
; “Given a string of parentheses, determine if the opening/closing is balanced”
(define (is-balanced? str)
  (define lop ( string->list str))
  ; if its empty: parentheses is balanced
  ; if its not empty: parenthesis is not balanced
  ; Parentheses Stack -> Boolean
  (define (loop list stack)
    (cond [(null? list) (if (null? stack) #t #f)] ; empty list, return true
          ; empty list but stack is not empty
          ; stack is empty
          [(eq? #\( (car list)) (loop (cdr list) (cons (car list) stack))] ; push to stack
          [(eq? #\) (car list)) (if (null? stack)
                                    #f
                                    (loop (cdr list) (cdr stack))
                                    ) ] ; pop/remove top stack
          [else (error "not a parenthesis")]
          )
    )
  ; initialize with empty stack and pos 0
  (loop lop '())
  )


; Test Cases
(is-balanced? "") ;empty input, should return true/vacuously true?
(is-balanced? "(())") ;nested balanced, return true
(is-balanced? "()()()") ;sequential, return true
(is-balanced? "())") ;false
(is-balanced? ")") ;false
(is-balanced? ")()") ;false
