#lang racket


(define (square x)
  (* x x)
  )


; PROCEDURE
;(square 5) ; which is a lambda
;"procedure object" is created which contained which is a pair
;the parameter it takes & the function body (the lambda text)
;the pointer to the environment where it was created in this case its global

;square - its a lambda procedures that takes x, finds it tn the global env
;5 - evaluates to 5
;then applies the procedure to 5


;first it creates a new frame say E1

;set this new frame parent to the global env where square was created (eg points to that env)
;then the frame binds the argument it calls to the parameter procedure (binds x = 5)
;then inside E1 it evaluates the body (* x x), and return the result and E1 is destroyed

; DEFINE
; finds the first frame in the current environment, where the frame was created
; adds new binding, if its already defined it replaces it

; key takeaway
; procedure call creates a new frame
; procedure remembers the environment it was created i
; variables iwth same name in diff frame don't conflict (eg shadowing)


; Example
#|
(define (square x)
  (* x x))
(define (sum-of-squares x y)
  (+ (square x) (square y)))
(define (f a)
  (sum-of-squares (+ a 1) (* a 2)))
(f 5)
|#

; calls to f with 5 as
; creates new frame E1
; inside  E1 it binds a (parameter of f) = 5
; then it evaluates (sum-of-squares (+ a 1) (* a 2))

; next we evaluate the subexpression sum-of-squares
; E1 has no binding for sum-of-squares
; it keeps finding sum-of-squares to the enclosing environment (the parent) in this case its the global environment is where it keeps sum-of-squares
; then it evaluates the other 2 subexpression (+ a 1) (* a 2) = (+ 5 1) (* 5 2) = (sum-of-squares 6 10)
; now we apply (sum-of-squares 6 10)

; new frame E2 is created from (sum-of-squares 6 10)
; parameterx x and y is bound to the argument x = 6, y = 10
; evaluates the function body (+ (square x) (square y)) and calls square

; new frame E3 is created
; square x - bounds x to 6
; evaluate the function body -> * 6 6

; new frame E4 is created
; square x - bounds x to 10
; evaluate the function body -> * 10 10


(define (factorial n)
  (if (= n 1) 1 (* n (factorial (- n 1))))
  )

; Linear Recursion version
; Lets say we call (factorial 4)
; First, procedure object is created which is a pair
; the parameter + function body
; and the pointer to the environment where the lambda was created (in this case global environment) -> #<procedure:factorial>

; Then it creates a new frame, say E1
; In this frame it sets its parent/points it to the global environment where (factorial n) was created, E1 has no binding for (factorial n)
; then the frame binds {n = 4} (its parameter/argument)
; then inside E1 it evaluates its function body (if (= n 1) 1 (* n (factorial (- n 1))))
; It checks wheter n = 1, since its still 4 the else cond is run, triggering a recursive call to (* n (factorial (- n 1)))
; And then it evaluates the subexpression to (* 4 (factorial (- 4 1))) = (* 4 (factorial 3))

; Then a new frame is created, say E2 
; within E2, (* 4 (factorial 3)) is evaluated (factorial applied to 3)
; and the process repeats again, it binds n = 3, and and then it goes with (* n (factorial 3))
; It looks for pointer where the lambda was created, evaluates the function body, and keeps decreasing n
; For every recursive call it creates a new frame and the process repeats

; ... Frame created, binding set, points to the global environment, etc.

; The process repeats until the base case is reached
; eg n = 1, once n reaches 1, the final calculation (eg all of the recursive calls are evaluated) is returned.
; Once its done, all of the previous frames are destroyed
; No frame share bindings (each n is independent)/isolated within its own frame


;Iterative version
(define (factorial n) (fact-iter 1 1 n))
(define (fact-iter product counter max-count)
  (if (> counter max-count)
      product
      (fact-iter (* counter product)
                 (+ counter 1)
                 max-count)))

; Lets say we call (factorial 4)
; First, the procedure object is created
; parameter + function body (lambda) and the pointer to the environment where the lambda was created (in this case the global env)
; Global Env: {#<procedure:factorial>, #<procedure:fact-fact-iter>}

; Inside of (factorial n)'s function body, (fact-iter 1 1 n) is evaluated
; A new frame is created, say E1
; inside E1, it tries to look for the lambda where fact-iter is created. In this case, its not within E1 but in the global variable
; Now it evaluates the subexpression (fact-iter 1 1 4)

; E2(fact-iter 1 1 4) is called
; Then inside E2, (fact-iter 1 1 4) binds to (fact-iter product counter max-count)
; it binds product = 1, counter =1, and max-count = 4
; Then the function body is evaluated
; In this case, (1 > 4) so its false, run the iterative procedure (fact-iter (* counter product) (+ counter 1) 4)
; Then it evaluates the subexpression to (fact-iter (* 1 1) (+ 1 1) 4) = (fact-iter 1 2 4)  

; E3(fact-iter 1 2 4) is called, 
; The process repeats again, inside E3, (fact-iter 1 2 4) binds to (fact-iter product counter max-count)
; It binds product = 1, counter = 2, max-count = 4
; then the function body is evaluated, recurses

;...

; the whole process repeats until the base case (> counter max-product) is reached
; Once the base case is reached, the final iterative procedure is evaluated, returning the final n result

;Recursive (factorial 6) creates 6 nested frames, each with its own n.
;Iterative (factorial 6) creates 7 flat frames, updating product and counter each time.