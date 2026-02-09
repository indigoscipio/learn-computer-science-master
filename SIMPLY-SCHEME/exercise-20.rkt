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
