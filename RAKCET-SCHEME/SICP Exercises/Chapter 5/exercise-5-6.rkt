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



; ======================================

; Exercise 5.4a
; Recursive exponentiation
(define (expt b n)
  (if (= n 0)
      1
      (* b (expt b (- n 1)))))

; Data paths
(data-paths
 (registers
  ((name b))
  ((name n))
  ((name result)) ;register that tholds the result
  ((name continue))
  )
 (operations
  ((name =) (inputs (register n) (constant 0)))
  ((name -) (inputs (register n) (constant 1)))
  ((name * (inputs (register b) (op expt))))
  )
 )

; controller
(controller
 start
 (assign continue (label exponential-done))

 exponential-loop
 (test  (op =) (reg n) (const 0))
 (branch (label base-case))
 ; setup recursive call, save n
 ; setup continue
 (save continue)
 (save n)
 (save b) ;register b is unchanged
 (assign n (op -) (register n) (const 1))
 (assign continue (label after-expt))
 (goto (label expt-loop))

 after-expt
 (restore n)
 (restore b)
 (restore continue)
 (assign result (op * (constant b) (register result) ))
 (goto (reg continue))

 base-case
 (assign result (const 1))
 (goto (reg continue))

 expt-done
 )

; ======================================

; Exercise 5.4b
; Iterative exponentiation
(define (expt b n)
  (define (expt-iter counter product)
    (if (= counter 0)
        product
        (expt-iter (- counter 1)
                   (* b product))))
  (expt-iter n 1))

; Data paths
(data-paths
 (registers
  ((name b))
  ((name n))
  ((name counter))
  ((name product))
  )
 (operations
  ((name =) (inputs (register counter) (constant 0)))
  ((name -) (inputs (register counter) (constant 1)))
  ((name *) (inputs (register b) (register product)))
  )
 )


; Controllers
(controller
 start
 (assign counter n)
 (assign product 1)
 
 expt-loop ;run (expt-iter)
 (test  (op =) (reg counter) (const 0))
 (branch (label base-case)) ; return product
 (assign counter (op -) (register counter) (const 1) )
 (assign product (op *) (register b) (register product))
 (goto (label expt-loop))

 expt-done
 )


; ======================================

; Exercise 5.5
; registers: n, val, continue
; stack: starts enoty

; initial state
; n=3, val = ?, continue - fact-done
; stack: []

; 1st call (fact-loop)
; test n = 1? false
; save continue = fact-done
; save n = 3
; update n = 2, continue = after-fact
; stack: [fact-done, 3]

; 2nd call (fact-loop)
; test n=1 ? false
; save continue = after-fact
; save n = 2
; update n =1, continue = after-fact
; stack: [after-fact, 2, fact-done, 3]

; base case (n=1)
; test n = 1? true
; assign val = 1
; jump to continue = after-fact
; stack: [after-fact, 2, fact-done, 3]

; first return (after-fact)
; restore n = 2
; restore continue = after fact
; compute val = 2 * 1 = 2
; jump to continue = after-fact
; stack: [fact-done, 3]

; second return (after-fact)
; restroe n = 3
; restore continue = fact-done
; compute val = 6
; jump to fact-done
; stack = []

; ======================================

; Exercise 5.6
; fib machine controller sequence has an extra save and extra restore
; which can b rmeoved to make a faster mahine
; what are these instructions?


(controller
 (assign continue (label fib-done))
 fib-loop
 (test (op <) (reg n) (const 2))
 (branch (label immediate-answer))
 ;; set up to compute Fib(n 1)
 (save continue)
 (assign continue (label afterfib-n-1))
 (save n)
 ; save old value of n
 (assign n (op-) (reg n) (const 1)) ; clobber n to n-1
 (goto (label fib-loop)) ; perform recursive call
 afterfib-n-1
 ; upon return, val contains Fib(n 1)
 (restore n)
 (restore continue)
 ;; set up to compute Fib(n 2)
 (assign n (op-) (reg n) (const 2))
 (save continue)
 (assign continue (label afterfib-n-2))
 (save val)
 ; save Fib(n 1)
 (goto (label fib-loop))
 afterfib-n-2
 (assign n (reg val))
 (restore val)
 ; upon return, val contains Fib(n 2)
 ; n now contains Fib(n 2)
 ; val now contains Fib(n 1)
 (restore continue)
 (assign val
         ; Fib(n 1) + Fib(n 2)
         (op +) (reg val) (reg n))
 (goto (reg continue))
 ; return to caller, answer is in
 val
 immediate-answer
 (assign val (reg n))
 (goto (reg continue))


 ; the 2nd (save n) and (restore continue) is unecessary
 ; becayse in the n-1 call the value of n is already saved