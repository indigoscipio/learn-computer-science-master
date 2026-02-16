#lang sicp

; data paths:
(data-paths
 (registers  ((name a)
              (buttons ((name a<-b) (source (register b)))))
             ((name b)
              (buttons ((name b<-t) (source (register t)))))
             ((name t)
              (buttons ((name t<-r) (source (operation rem))))))
 (operations  ((name rem) (inputs (register a) (register b)))
              ((name =) (inputs (register b) (constant 0))))
 )


; controller:
(controller
 test-b
 (test (op =) (reg b) (const 0))
 (branch (label gcd-done))
 (assign t (op rem) (reg a) (reg b))
 (assign a (reg b))
 (assign b (reg t))
 (goto (label test-b))
 gcd-done)

; Exercise 5.2
; Use the register-machine language to describe
; the iterative factorial machine of Exercise 5.1.

; answer
; Data Paths
(data-paths
 (registers  ((name product)
              (buttons
               ((name product<-1) (source (constant 1)))
               ((name product<-*counter-product) (source (operation *)))
               )
              )
             ((name counter)
              (buttons
               ((name counter<-1) (source (constant 1)))
               ((name counter<-+counter-1) (source (operation +)))
               )
              )
             ((name n) ))
 (operations  ((name >) (inputs (register counter) (register n)))
              ((name *) (inputs (register counter) (register product)))
              ((name +) (inputs (register counter) (constant 1)))
              )
 )

; Controllers
(controller
 (initialize)
 (assign product 1)
 (assign counter 1)
 (test-counter)
 (test (op >) (reg counter) (reg n))
 (branch (label done))
 (assign product (op *) (reg counter) (reg product))
 (assign counter (op +) (reg counter) (constant 1))
 (goto (label test-counter))
 (done) ;; halt with product = n!
 )

; ======================================

; Exercise 5.3
; design a machine to compute square roots using newton's method as described in section 1.1.7
; assume good enough and improve operations are available as primitives

(define (sqrt x)
  (define (good-enough? guess)
    (< (abs (- (square guess) x)) 0.001))
  (define (improve guess)
    (average guess (/ x guess)))
  (define (sqrt-iter guess)
    (if (good-enough? guess)
        guess
        (sqrt-iter (improve guess))))
  (sqrt-iter 1.0)
  )

; answer
; Data Paths
(data-paths
 (registers
  ((name x))   ; Input value
  ((name guess)) ; Current approximation
  ((name temp))  ; Temporary storage
  (operations
   ((name square) (inputs (register guess))) ; guess2
   ((name -) (inputs (op square) (register x))) ; guess2 - x
   ((name abs) (inputs (op -))) ; |guess2 - x|
   ((name <) (inputs (op abs) (const 0.001))) ; |...| < 0.001?
   ((name /) (inputs (register x) (register guess))) ; x / guess
   ((name average) (inputs (register guess) (register temp)))) ; (guess + temp)/2
  ))

 ; Controllers
 (controller
  start
  (assign guess (const 1.0)) ; guess = 1.0
  test-guess
  (assign temp (op square) (reg guess)) ; temp = guess2
  (assign temp (op -) (reg temp) (reg x)) ; temp = guess2 - x
  (assign temp (op abs) (reg temp)) ; temp = |guess2 - x|
  (test (op <) (reg temp) (const 0.001)) ; Is |...| < 0.001?
  (branch (label done)) ; If yes, done!
  (assign temp (op /) (reg x) (reg guess)) ; temp = x / guess
  (assign guess (op average) (reg guess) (reg temp)) ; guess = (guess + temp)/2
  (goto (label test-guess)) ; Repeat
  done
  (perform (op print) (reg guess))) ; Print √x

 