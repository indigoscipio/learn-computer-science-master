#lang racket

(require sicp-pict)

(define wave einstein)
(define wave2 (beside wave (flip-vert wave)))

; Painter -> Painter
(define (flipped-pairs painter)
  (let ((painter2 (beside painter (flip-vert painter))))
    (below painter2 painter2)))
;(define wave4 (flipped-pairs wave))


; Painter Number -> Painter
(define (right-split painter n)
  (cond [(= n 0) painter]
        [else (let (; smaller is a Painter
                    (smaller (right-split painter (sub1 n))))
                (beside painter (below smaller smaller))
                ) ])
  )
;(paint (right-split wave 3))

;exercise 2.44
(define (up-split painter n)
  (cond [(= n 0) painter]
        [else (let ((smaller (up-split painter (sub1 n))))
                (below painter (beside smaller smaller))
                ) ])
  )
;(paint (up-split wave 3))

(define (corner-split painter n)
  (cond [(= n 0) painter]
        [else (let* ((up (up-split painter (sub1 n)))
                     (right (right-split painter (sub1 n)))
                     (top-left (beside right right))
                     (bottom-right (below right right))
                     (corner (corner-split painter (sub1 n)) )
                     )
                (beside (below painter top-left)
                        (below bottom-right corner))
              
                )])
  )
;(paint (corner-split wave 2))

(define (square-limit painter n)
  (let* ((quarter (corner-split painter n))
         (half (beside (flip-horiz quarter) quarter ))
         )
    (below half (flip-horiz half) )
    )
  )
(paint (square-limit wave 4))

;(Painter -> Painter) (Painter -> Painter) (Painter -> Painter) (Painter -> Painter) -> (Painter -> Painter)
(define (square-of-four tl tr bl br)
  (lambda (painter) (let ((top (beside (tl painter) (tr painter)))
                          (bottom (beside (bl painter) (br painter)))
                          )
                      (below bottom top)
                      ))
  )
;(paint ((square-of-four flip-vert flip-horiz flip-horiz flip-vert) (corner-split wave 2)))

(define (flipped-pairs.v2 painter)
  (square-of-four identity flip-vert identity flip-vert)
  )

(define (square-limit.v2 painter n)
  (let ((combine4 (square-of-four flip-horiz flip-vert rotate180 flip-vert) ))
    (combine4 (corner-split painter n) )
    ))

;exercise 2.45
; right-split and up-split can be expressed as instances of general splitting operation
; define proc split with the property that evaluating proc right-spilt and up-split with the same behaviours
; as the ones already defined

#|
(define (right-split painter n)
  (cond [(= n 0) painter]
        [else (let (; smaller is a Painter
                    (smaller (right-split painter (sub1 n))))
                (beside painter (below smaller smaller))
                ) ])
  )
|#

; (Painter Painter -> Painter) (Painter Painter -> Painter) -> (Painter Number -> Painter)
(define (split p1 p2)
  (lambda (painter n) (cond [(= n 0) painter]
                            [else (let ((smaller ((split p1 p2) painter (sub1 n)) ))
                                    (p1 painter (p2 smaller smaller))
                                    ) ]) )
  )
;(paint ((split beside below) wave 3))
;(paint ((split below beside) wave 3))



;(define right-split.v2 (split beside below))
;(define up-split.v2 (split below beside))
