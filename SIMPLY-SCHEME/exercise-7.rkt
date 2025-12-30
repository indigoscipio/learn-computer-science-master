#lang simply-scheme

(define (vowel? x) (member x '(a e i o u)))

#|
7.1 The following procedure does some re

(define (gertrude wd)
  (se (if (vowel? (first wd)) 'an 'a)
      wd
      'is
      (if (vowel? (first wd)) 'an 'a)
      wd
      'is
      (if (vowel? (first wd)) 'an 'a)
      wd))

|#

(define (gertrude wd)
  (let ((handle-indef (if (vowel? (first wd)) 'an 'a)))
    (se  handle-indef
         wd 'is handle-indef
         wd 'is handle-indef
         wd)
    )
  )

(gertrude 'rose)
;(A ROSE IS A ROSE IS A ROSE)
(gertrude 'iguana)
;(AN IGUANA IS AN IGUANA IS AN IGUANA)

;7.2 put in the missing parenthesis

(let ((pi 3.14159)
      (pie '(lemon meringue))
      )
  (se 'pi 'is pi 'but 'pie 'is pie)
  )

;(PI IS 3.14159 BUT PIE IS LEMON MERINGUE)

; 7.3
; the following prog doesn't work why ? fix it
;(define (superlative adjective word)
;  (se (word adjective 'est) word)
;  )

; It's supposed to work like this:
; (superlative 'dumb 'exercise)
; (DUMBEST EXERCISE)

; the argument is word which is confused as a function call
; just change it to wd
(define (superlative adjective wd)
  (se (word adjective 'est) wd)
  )
(superlative 'dumb 'exercise)

;7.4 what does this proc do?
;explain how it manages to work
(define (sum-square a b)
  (let ((+ *)
        (* +))
    (* (+ a a) (+ b b))))

; answer:
; sum-squares take two numbers a and b and returns
; the sum of their squares or a^2 + b^2
;(sum-square 2 3) -> 4 * 9 = 13
; how it works is abit weird first it creates2 new operators
; + -> change into * so addition is now multiply
; * -> change into + so multiplication is now addition
; and the body of let it multiples a * a + b * b so like the name of the function, it sum two squares