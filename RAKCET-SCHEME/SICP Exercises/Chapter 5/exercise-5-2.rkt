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