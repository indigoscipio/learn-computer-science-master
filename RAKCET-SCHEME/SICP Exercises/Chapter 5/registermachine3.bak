#lang sicp


; Exercise 5.8


start
(goto (label here))
here
(assign a (const 3))
(goto (label there))
here
(assign a (const 4))
(goto (label there))
there

; when control reaches here
; a will be 4


(define (extract-labels text)
  (if (null? text)
      (cons '() '())
      (let ((result (extract-labels (cdr text))))
        (let ((insts (car result)) (labels (cdr result)))
          (let ((next-inst (car text)))
            (if (symbol? next-inst)
                (if (assoc next-inst labels)
                    (error "Duplicate Label")
                    (cons insts
                          (cons (make-label-entry next-inst insts)
                                labels))
                    )
                (cons (cons (make-instruction next-inst) insts)
                      labels)
                )
            )
          )
        )
      )
  )