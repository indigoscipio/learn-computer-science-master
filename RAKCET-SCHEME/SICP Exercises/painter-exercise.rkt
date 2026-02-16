#lang racket

(require sicp-pict)

(define wave einstein)
(define wave2 (beside wave (flip-vert wave)))

; Painter -> Painter
(define (flipped-pairs painter)
  (let ((painter2 (beside painter (flip-vert painter))))
    (below painter2 painter2)))



(define wave4 (flipped-pairs wave))


; Painter Number -> Painter
(define (right-split painter n)
  (cond [(= n 0) painter]
        [else (let (; smaller is a Painter
                    (smaller (right-split painter (sub1 n))))
                (beside painter (below smaller smaller))
                ) ])
  )
;(paint (right-split wave 3))

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
                  (top-left (beside up up))
                  (bottom-right (below right right))
                  (corner (corner-split painter (sub1 n)) )
                  )
            (beside (below painter top-left)
                    (below bottom-right corner))
              
            )])
)
(paint (corner-split wave 2))

(define (square-limit painter n)
  (let* ((quarter (corner-split painter n))
        (half (beside (flip-horiz quarter) quarter ))
        )
    (below (flip-vert half) half)
    )
  )
(paint (square-limit wave 4))