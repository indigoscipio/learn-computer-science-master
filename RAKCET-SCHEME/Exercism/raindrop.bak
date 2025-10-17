#lang racket

; An Bracket either is the following:
; Brackets []
; Braces {}
; Parentheses ()

; Checks if a given char is an opening bracket
; Char -> MaybeChar
(define (is-open-bracket? char)
  (or (eq? char #\[)
      (eq? char #\()
      (eq? char #\{)
      )
  )

; checks if a given char is a closing bracket
; Char -> Boolean
(define (is-close-bracket? char)
  (or (eq? char #\])
      (eq? char #\))
      (eq? char #\})
      )
  )

; given a closing bracket, checks if target is a matching bracket
; Char Char -> Boolean
(define (is-bracket-match? closing-bracket target)
  (cond [(and (eq? closing-bracket #\])
              (eq? target #\[))  #t]
        [(and (eq? closing-bracket #\})
              (eq? target #\{))  #t]
        [(and (eq? closing-bracket #\))
              (eq? target #\())  #t]
        [else #f]
        )
  )


; Char List-of-char -> Maybe List-of-char
; Given a input character and the current stack,
; return the updated stack or #f to signal an unrecoverable mismatch.
(define (process-char char stack)
  (cond [(is-open-bracket? char) (cons char stack)]
        [(is-close-bracket? char) (if (null? stack)
                                      #f
                                      (if (is-bracket-match? char (car stack))
                                          (cdr stack) ;pop the stack
                                          #f ;fail
                                          )
                                      )]
        [else stack]
        )
  )

; String -> Boolean
; given a string, checks if an expression inside it is balanced with brackets.
(define (balanced? string)
  (let ((chars (string->list string)))

    ; acc represents current stack or failure state
    ; Char MaybeList-of-chars -> MaybeList-of-chars
    (let ((result 
           (foldl (lambda (char acc) (if acc
                                         (process-char char acc)
                                         #f
                                         ) ) '() chars)))
      (null? result)
      )    
    )
  )


#|
    ; List-of-chars List-of-chars -> Boolean
    ; acc is a stack that stores the list of opening brackets
    (define (iter l acc)
      (cond [(null? l) (null? acc)]
            [(is-open-bracket? (car l)) (iter (cdr l) (cons (car l) acc))]
            [(is-close-bracket? (car l)) (if (null? acc)
                                             #f
                                             (if (is-bracket-match? (car l) (car acc))
                                                 (iter (cdr l) (cdr acc)) ;pop the stack
                                                 #f ;fail
                                                 )
                                             ) ]
            [else (iter (cdr l) acc)]
            )
      )
    (iter chars '())
    |#


(balanced? "[[") ;unpaired brackets, #f
(balanced? "}{") ;wrong order bracket, #f
(balanced? "{]") ;wrong closing bracket, #f
(balanced? "{ }") ;true, with whitespace
(balanced? "{[])") ;#f
(balanced? "{[]}") ;#t
(balanced? "{}[]") ;#t
(balanced? "([{}({}[])])") ;#t
(balanced? "{[)][]}") ;#f
(balanced? "([{])"); #f
#|
|#