#lang racket

; Rules
; A Number is a sequence of one or more (ASCII) digits
; symbols or punctuations is not a number
; "0", "42", "12345" are numbers.

; a Word is a sequence of one or more letters
; everything that's not a number is a word
; they are case insensitive, can be the following:
; built-in commands (+, -, *, /, dup, drop, swap, over)
; definition markers (:, ;)
; user-defined words (like "square")

; A Token is a String
; a number literal OR a word (builtin or user-defined)
; examples: "1 2 +", "dup", "+", ":"

; a Stack is a List-of-any
; example: '(1 2 3 * DUP)
; where the car (leftmost) is the top of the stack


; String ->
(define (is-number? token)
  (if (string->number token) #t #f)
  )

; Given a stack, pops the first n element
; Number List-of-tokens -> list-of-(Pair-of-number List-of-token)
; rebuild the list on each iteration
(define (pop n l)
  ; on each iteration, collect popped items
  (define (iter counter stack acc)
    (cond [(zero? counter) (list (reverse acc) stack)] ;stop and return the result
          [(null? stack) (list (reverse acc) stack)] ;return an empty list
          [else (iter (- counter 1) (cdr stack) (cons (car stack )acc) ) ] ;else pop it
          )
    )

  
  (if(> n (length l))
     (error "POP: Stack Underflow")
     (iter n l '())
     )  
  )
;(pop 1 '(1 2 5 8)) ;'((1) (2 5 8))
;(pop 2 '(7 5 3)) ;'((7 5) (3))

; a Dictionary is a list of user defined words
(define dictionary '(("square" ("dup" "*"))
                     ("double" ("dup" "+"))
                     ))


;(cons (cdr l) (list (car (reverse acc)) (cdr (reverse acc))) )

; list-of-tokens -> List-of-token Dictionary
; given a list of tokens remainig (starting with ":")
; it reutrns the updated dictionary and the list of tokens that come after that definition.
(define (parse-definition tokens dict)
  ; store the dict definition result in acc
  ; List-of-tokens -> Pair-of(List-of-token . Dictionary)
  (define (iter l acc)
    (cond [(null? l) (reverse acc)]
          [(string=? (car l) ";") (let ((definition (list (car (reverse acc)) (cdr (reverse acc))))
                                        (remaining-tokens  (cdr l))
                                        )
                                    (list remaining-tokens (append (list definition) dictionary))
                                    )  ] ; return the updated dictionary and rest of token
          [else (iter (cdr l) (cons (car l)  acc) )] ;else build the definition
          )
    )
  (iter (cdr tokens) '())
  )
;(parse-definition '(":" "dup-twice" "dup" "dup" ";" "1" "dup-twice") dictionary) ;should return '("1" "dup-twice")
;(forth '(": dup-twice dup dup ;" "1 dup-twice"))


; List-of-Token -> List-of-value
(define (forth program)
  (let ((tokens (apply append (map string-split (map string-downcase program)))))
    ; List-of-token
    (define (evaluate tokens stack dict)
      (cond [(null? tokens) stack] ;nothing to evaluate
            [else (let ((token (car tokens)))
                    (cond [(is-number? token)
                           (evaluate (cdr tokens) (cons (string->number token) stack) dict)]
                          [(string=? token "+") (apply-arithmetic-op + stack tokens dict) ]
                          [(string=? token "-") (apply-arithmetic-op - stack tokens dict) ]
                          [(string=? token "*") (apply-arithmetic-op * stack tokens dict) ]
                          [(string=? token "/") (apply-arithmetic-op quotient stack tokens dict)]
                          [(string=? token "drop")
                           (cond [(null? stack) (error "stack underflow")]
                                 [else (evaluate (cdr tokens) (cdr stack) dict)])
                           ]
                          [(string=? token "dup")
                           (cond [(null? stack) (error "stack underflow")]
                                 [else (evaluate (cdr tokens) (cons (car stack) stack) dict)])
                           ]
                          [(string=? token "swap")
                           (cond [(null? stack) (error "stack onderflow")]
                                 [else (let* ((pop-result (pop 2 stack))
                                             (args (car pop-result))
                                             (rem-stack (cadr pop-result))
                                             (curr-stack (cons (cadr args) (cons (car args) rem-stack)) )
                                             )
                                         (evaluate (cdr tokens) curr-stack dict)
                                         )])
                           ]
                          [(string=? token "over")
                           (cond [(null? stack) (error "stack underflow")]
                                 [else (let* ((pop-result (pop 2 stack))
                                              (args (car pop-result))
                                              (rem-stack (cadr pop-result))
                                              (curr-stack (cons (cadr args) (cons (car args) (cons (cadr args) rem-stack)) )  )
                                              )
                                         (evaluate (cdr tokens) curr-stack dict)
                                         )]
                                 )
                           ]
                         [(string=? token ":") (let* ((result (parse-definition tokens dict))
                                                      (new-dict (cadr result) )
                                                      (rem-tokens  (car result))
                                                     )
                                                 (evaluate rem-tokens stack new-dict)
                                                 )] ;user-defined words
                          [else (error "unknown token or not in definition")]
                          )
                    )]
            )
      )
    
    ; X->Y List-of-tokens List-of-token Dictionary
    (define (apply-arithmetic-op op stack tokens dict)
      (let*((pop-result (pop 2 stack))
            (args (car pop-result))
            (op-result (op (cadr args) (car args)))
            (curr-stack (cons op-result (cadr pop-result)))
            )
        (evaluate (cdr tokens) curr-stack dict)
        )
      )

    (evaluate tokens '() '())
    
    )
  )



(forth '("1 2 3 4 5")) ; => '(5 4 3 2 1)
(forth '("1 2 +")) ; => '(3)
(forth '("3 4 -")) ; => '(-1)
(forth '("2 4 *")) ; => '(8)
(forth '(": double dup + ;")) ;"5 Double"
(forth '("12 3 /")) ; => '(4)
(forth '("8 3 /")) ; => '(2)
(forth '("1 2 + 4 -")) ; => '(-1)
(forth '("2 4 * 3 /")) ; => '(2)
(forth '("1 dup")) ; => '(1 1)
(forth '("1 2 dup")) ; => '(2 2 1)
(forth '("1 drop")) ; => '()
(forth '("1 2 drop")) ; => '(1)
(forth '("1 2 swap")) ; => '(1 2)
(forth '("1 2 3 swap")) ; => '(2 3 1)
(forth '("1 2 over")) ; => '(1 2 1)
(forth '("1 2 3 over")) ; => '(2 3 2 1)
(forth '(": + * ;" "3 4 +")) ; => '(12)



#|
(forth '("+")) ; => ERROR
(forth '("1 +")) ; => ERROR
(forth '("-")) ; => ERROR
(forth '("1 -")) ; => ERROR
(forth '("drop")) ; => ERROR
|#




#|
(forth '("*")) ; => ERROR
(forth '("1 *")) ; => ERROR
(forth '("4 0 /")) ; => ERROR
(forth '("/")) ; => ERROR
(forth '("1 /")) ; => ERROR
(forth '("dup")) ; => ERROR
(forth '("swap")) ; => ERROR
(forth '("1 swap")) ; => ERROR
(forth '("over")) ; => ERROR
(forth '("1 over")) ; => ERROR
(forth '(": dup-twice dup dup ;" "1 dup-twice")) ; => '(1 1 1)
(forth '(": countup 1 2 3 ;" "countup")) ; => '(3 2 1)
(forth '(": foo dup ;" ": foo dup dup ;" "1 foo")) ; => '(1 1 1)
(forth '(": swap dup ;" "1 swap")) ; => '(1 1)

(forth '(": foo 5 ;" ": bar foo ;" ": foo 6 ;" "bar foo")) ; => '(6 5)
(forth '(": foo 10 ;" ": foo foo 1 + ;" "foo")) ; => '(11)
(forth '(": 1 2 ;")) ; => ERROR
(forth '("foo")) ; => ERROR
(forth '("1 DUP Dup dup")) ; => '(1 1 1 1)
(forth '("1 2 3 4 DROP Drop drop")) ; => '(1)
(forth '("1 2 SWAP 3 Swap 4 swap")) ; => '(1 4 3 2)
(forth '("1 2 OVER Over over")) ; => '(1 2 1 2 1)
(forth '(": foo dup ;" "1 FOO Foo foo")) ; => '(1 1 1 1)
(forth '(": SWAP DUP Dup dup ;" "1 swap")) ; => '(1 1 1 1)


                           #|
                           (let* ((result (pop 2 stack))
                                 (args (car result))
                                 (curr-stack (cons (- (cadr args) (car args)) (cadr result))))
                             ; perform the operation and update the stack
                             (evaluate (cdr tokens) curr-stack dict))
                           |#
|#
