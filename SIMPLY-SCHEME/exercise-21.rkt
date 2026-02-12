#lang simply-scheme

#|
(define (get-fn)
  (display "Functions: ")
  (read)
  )
|#

(define (get-arg)
  (display "Argument: ")
  (read)
  )

(define (get-args n)
  (if (= n 0)
      '()
      (let ((first (get-arg)))
        (cons (get-arg) (get-args (- n 1))))))

(define (show-answer answer)
  (newline)
  (display "The result is: ")
  (if (not answer)
      (show "#F")
      (show answer))
  (newline))
(show-answer "")


; ============================

(define (two–numbers? x y)
  (and (number? x) (number? y)))

; FUNCTIONs
(define *the–functions*     ;; partial listing
  (list (list '* * 2 (lambda (x y) (and (number? x) (number? y))))
        (list '+ + 2 (lambda (x y) (and (number? x) (number? y))))
        (list 'and (lambda (x y) (and x y)) 2
              (lambda (x y) (and (boolean? x) (boolean? y))))
        (list 'equal? equal? 2 (lambda (x y) #t))
        (list 'even? even? 1 integer?)
        (list 'word word 2 (lambda (x y) (and (word? x) (word? y))))))

#|
(define (scheme–procedure fn–name)
  (cadr (assoc fn–name *the–functions*)))
(define (arg–count fn–name)
  (caddr (assoc fn–name *the–functions*)))
(define (type–predicate fn–name)
  (cadddr (assoc fn–name *the–functions*)))
|#

(define (in–domain? args fn–name)
  (apply (type–predicate fn–name) args))


; =============================================

#|
21.1 The get–args procedure has a let that creates the variable first, and then that variable is used only once 
inside the body of the let. Why doesn't it just say the following?
(define (get–args n)
  (if (= n 0)
      '()
      (cons (get–arg) (get–args (– n 1)))))

answer:
cos of the order of evaluation, the evaluator doesn't know which one to do first
(get arg) or recurse first
by using let we force the evaluator to finish get arg first then save that result.

|#

; =============================================

#|
21.2 The domain-checking function for equal? is
(lambda (x y) #t)
This seems silly; it's a function of two arguments that ignores both arguments and always returns #t. Since we know 
ahead of time that the answer is #t, why won't it work to have equal?'s entry in the a-list be
(list 'equal? equal? 2 #t)

answer:
coz the type predicate expects a function instead of a boolean
when we call equal it needs to take the args then return true instead of just returning the obolean

|#

; =============================================

#|
21.3 Every time we want to know something about a function that the user typed in, such as its number of arguments 
or its domain-checking predicate, we have to do an assoc in *the–functions*. That's inefficient. Instead, 
rewrite the program so that get–fn returns a function's entry from the a-list, instead of just its name. Then rename the 
variable fn–name to fn–entry in the functions–loop procedure, and rewrite the selectors scheme
procedure, arg–count, and so on, so that they don't invoke assoc.

answer:
|#

(define (get-fn)
  (display "Functions: ")
  (let* ((fn-name (read))
        (fn-entry (assoc fn-name *the–functions*))
        )
    fn-entry
    )
  )

(define (scheme–procedure fn–entry)
  (cadr fn-entry))
(define (arg–count fn-entry)
  (caddr fn-entry))
(define (type–predicate fn-entry)
  (cadddr fn-entry))


(define (functions–loop)
  (let* ((fn–entry (get-fn))
         (fn-name (car fn-entry))
         )
    (if (equal? fn–name 'exit)
        "Thanks for using FUNCTIONS!"
        (let ((args (get-args (arg-count fn-entry))))
          (if (not (in–domain? args fn–entry))
              (show "Argument(s) not in domain.")
              (show–answer (apply (scheme–procedure fn–entry) args)))
          (functions–loop))))
  )




; =============================================

#|
21.4 Currently, the program always gives the message ''argument(s) not in domain" when you try to apply a function to 
bad arguments. Modify the program so that each record in *the–functions* also contains a specific out-of
domain message like "both arguments must be numbers," then modify functions to look up and print this error 
message along with "argument(s) not in domain."

answer:


|#

; =============================================

; =============================================

; =============================================

; =============================================