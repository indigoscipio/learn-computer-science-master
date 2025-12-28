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

7.2 put in the missing parenthesis