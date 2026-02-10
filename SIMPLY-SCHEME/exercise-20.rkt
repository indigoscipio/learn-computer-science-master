#lang simply-scheme

(define (add-and-show x y)
  (show (+ x y))
  )

(define (effect x)
  (show x)
  'done
  )
(effect 8)

(define (value x)
  x
  )

(effect '(oh! darling))

(bf (effect '(oh! darling)))

(define (lots-of-effect x)
  (effect x)
  (effect x)
  (effect x))
(lots-of-effect '(1 2 3))

(define (lots-of-value x)
  (value x)
  (value x)
  (value x))
(lots-of-value 3)

(define (show-addition x y)
  (let ((fst (read))
        (sec (read)))
    (display fst)
    (display '+)
    (display sec)
    (display '=)
    (display (+ fst sec))
    )
  )


(define (echo)
  (display "what?")
  (let ((expr (read)))
    (if (equal? expr 'stop)
        'okay
        (echo)
        )
    )
  )

(define (game-critic)
  (read-line)
  (show "what's' your favorite games")
  (let ((answer (read-line)))
    (show (se "I like" answer))
    )
  )

#|
SQRT TABLE
|#
(define (sqrt-table nums)
  (if (null? nums)
      'done
      (begin (display (align (car nums) 7 1))
             (show (align (sqrt (car nums)) 10 5))
             (sqrt-table (cdr nums))
             )
      )
  )


#|
BORING EXERCISE

20.1 What happens when we evaluate the following expression? What is printed, and what is the return value? Try to 
figure it out in your head before you try it on the computer.
(cond ((= 2 3) (show '(lady madonna)) '(i call your name))
      ((< 2 3) (show '(the night before)) '(hello little girl))
      (else '(p.s. i love you)))

answer:
checks if 2 = 3 - false , skip the 1st cond
(< 2 3) cond is run - shows '(the night before) with final return value '(hellow little girl)

so its something like
'(the night before)
'(hello little girl)

|#

#|
20.3 Define show in terms of newline and display.
|#
(define (my-show x)
  (display x)
  (newline)
  )

; ========================================================

#|
20.4 Write a program that carries on a conversation like the following example.
What the user types is in boldface.
> (converse)
Hello, I'm the computer. What's your name? (B) Brian Harvey
Hi, Brian. How are you? (B) I'm fine.
Glad to hear it.
|#

(define (converse)
  (show "Hello, I'm the computer. What's your name?")
  (let ((name (read-line)) )
    (show-line (se "Hi," name "How are you?"))
        (let ((answer (read)))
          (show "Glad to hear it.")
          )
    )
  )

#|
20.5 Our name–table procedure uses a fixed width for the column containing the last names of the people in the 
argument list. Suppose that instead of liking British-invasion music you are into late romantic Russian composers:
> (name–table '((piotr tchaikovsky) (nicolay rimsky–korsakov)
                (sergei rachmaninov) (modest musorgsky)))
Alternatively, perhaps you like jazz:
> (name–table '((bill evans) (paul motian) (scott lefaro)))

original code
(define (name-table names)
  (if (null? names)
      'done
      (begin (display (align (cadar names) 11))
             (show (caar names))
             (name-table (cdr names)))))
|#

; answer:
; given a list of last names, gets its max count
; sentence -> number
(define (longest-name-count names)
  (apply max (map count names))
  )
(longest-name-count '(evane motian lefaro))
(longest-name-count '(tchaikovsky rimsky-korsakov rachmaninov musorgsky))

; note from the book: align takes 3 args: value to be displayed, width of col, decimal
(define (name-table names)
  (let* ((last-names (every cadr names))
         (max-count (longest-name-count last-names)))

    (define (name-table-helper names mx-count extra-space)
      (if (null? names)
          'done
          (begin (display (align (cadar names) (+ mx-count extra-space)))
                 (show (caar names))
                 (name-table-helper (cdr names) mx-count extra-space)))
      )
    
    (name-table-helper names max-count 2)
    )
  )
(name-table '((john lennon) (paul mccartney)
                            (george harrison) (ringo starr)))


#|
20.6 The procedure ask–user isn't robust. What happens if you type something that isn't a number, or isn't between 
1 and 9? Modify it to check that what the user types is a number between 1 and 9. If not, it should print a message and 
ask the user to try again.

from the book
(define (ask–question question)
  (show question)
  (let ((answer (read)))
    (cond ((equal? answer 'yes) #t)
          ((equal? answer 'no) #f)
          (else (show "Please answer yes or no.")
                (ask–question question)))))
|#

; answer:
#|
(define (ask-user position letter)
  (show (se "Patiently waiting for" letter "to move:"))
  (let ((user-input (read)))
    (if (and (number? user-input)
             (and (>= user-input 1) (<= user-input 9)) )
        ; do the move logic thing
        user-input
        ; else return error
        (begin (show "Invalid input, please try again")
               (ask-user position letter)
               )
        )
    )
  )
|#

#|
20.7 Another problem with ask–user is that it allows a user to request a square that isn't free. If the user does this, 
what happens? Fix ask–user to ensure that this can't happen.
|#
(define (ask-user position letter)
  (show (se "Patiently waiting for" letter "to move:"))
  (let ((user-input (read)))
    (if (and (number? user-input)
             (and (>= user-input 1) (<= user-input 9))
             (member? (item user-input position) "123456789")
             )
        ; do the move logic thing
        user-input
        ; else return error
        (begin (show "Invalid input, please try again")
               (ask-user position letter)
               )
        )
    )
  )

#|
20.8 At the end of the game, if the computer wins or ties, you never find out which square it chose for its final move. 
Modify the program to correct this. (Notice that this exercise requires you to make play–ttt–helper non
functional.)
|#