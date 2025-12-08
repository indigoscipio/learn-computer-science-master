#lang racket

; A Parenthesis is one of:
; - #\(
; - #\)
; Interpretation: represents opening/closing parenthesis

; A Stack is a [List-of (cons Parenthesis Number)]
; Interpretation: stack of parentheses with their positions

; A Result is one of:
; - #t
; - (cons #f Number)
; Interpretation: #t means balanced, (cons #f pos) means unbalanced at position pos

; String -> Result
; Given a string of parentheses, determine if opening/closing is balanced
; If unbalanced, return position of first offending parenthesis
(define (is-balanced? str)
  (define lop (string->list str))
  
  ; [List-of Parenthesis] Stack Number -> Result
  ; Process list of parentheses using stack, tracking position
  (define (loop list stack pos)
    (cond 
      ; End of input: check if stack is empty
      [(null? list) 
       (if (null? stack) 
           #t 
           ; Return position of first unmatched opening paren
           (cons #f (cdar stack)) )]
      
      ; Opening paren: push with its position
      [(eq? #\( (car list)) 
       (loop (cdr list) (cons (cons (car list) pos) stack) (+ 1 pos))]
      
      ; Closing paren: check for matching opening
      [(eq? #\) (car list)) 
       (if (null? stack)
           (cons #f pos)  ; No matching opening paren
           (loop (cdr list) (cdr stack) (+ 1 pos)))]
      
      ; Invalid character
      [else (error "not a parenthesis")]))
  
  (loop lop '() 0))

; Test Cases
(is-balanced? "")         ; #t - empty is vacuously balanced
(is-balanced? "(())")     ; #t - nested balanced
(is-balanced? "()()()")   ; #t - sequential balanced
(is-balanced? "((())())()") ; #t - complex balanced

(is-balanced? "())")      ; (cons #f 2) - extra closing at position 2
(is-balanced? ")")        ; (cons #f 0) - closing without opening at position 0
(is-balanced? ")()")      ; (cons #f 0) - closing before opening at position 0
(is-balanced? "((())")    ; (cons #f 0) - unmatched opening at position 0
(is-balanced? "(()(()")   ; (cons #f 3) - first unmatched opening at position 3