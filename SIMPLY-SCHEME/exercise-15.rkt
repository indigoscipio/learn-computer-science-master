#lang simply-scheme

(define (drop-once x xs)
  0
  )
(drop-once 3 '(1 2 3 4 5 3))

(define (find-smallest sent)
  (define (find-smallest1 curr-smallest sentence)
    (cond [(empty? sentence) curr-smallest]
          [else (let* ((fst (first sentence))
                       (rest (bf sentence))
                       )
                  (if (before? curr-smallest fst)
                      (find-smallest1 curr-smallest rest) ;keep it
                      (find-smallest1 fst rest ) ;update cur smallest
                      )
                  )]
          )
    )
  ; initialize
  (if (empty? sent) '() (find-smallest1 (first sent) (bf sent)))
  )
(find-smallest '(4))

; selection sort (sort of)
; ss-sort:: list-of-number -> list-of-number
(define (ss-sort xs)
  0
  ;temprary
  )
(ss-sort '(i wanna be your man))