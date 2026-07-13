#lang racket
(require 2htdp/universe 2htdp/image)

#|
; create helper ui text -> arrow up for large number, arrow downlower
; struct interval small big
(struct interval (small big) #:transparent)

(define HELP-TEXT (text "UP = larger, DOWN = smaller"
                        TEXT-SIZE
                        "blue"))
(define HELP-TEXT2 (text "Press = when your number is guessed,
q to quit"
                         TEXT-SIZE
                         "blue"))

; SCENE
(define MT-SCENE
  (place-image/align
   HELP-TEXT TEXT-X TEXT-UPPER-Y
   "left" "top"
   (place-image/align HELP-TEXT2 TEXT-X TEXT-LOWER-Y "left" "bottom" EMPTY-SCENE))
  )

; KEY EVENTS
(define (deal-with-guess w key)
  (cond [(key=? key "up") (bigger w)]
        [(key=? key "down") (smaller w)]
        [(key=? key "q") (stop-with w)]
        [(key=? key "=") (stop-with w)]
        [else w]
        )
  )

(define (smaller w)
  (interval (interval-small w)
            (max (interval-small w) (sub1 (guess w)))
            )
  )

(define (bigger w)
  (interval (min (interval-big w) (add1 (guess w))) (interval-big w))
  )

(define (guess w)
  (quotient (+ (interval-small w) (interval-big w) ) 2)
  )

(define (render w)
  (overlay (text (number->string (guess w)) TEXT-SIZE COLOR) MT-SCENE))

(define (render-last-scene w)
 (overlay (text "End" TEXT-SIZE COLOR) MT-SCENE))

(define (single? w)
 (= (interval-small w) (interval-big w)))
=
(define (start lower upper)
  (big-bang (interval lower upper)
    (on-key deal-with-guess)
    (to-draw render)
    (stop-when single? render-last-scene)
    )
  )
|#

; ==============
(define TRAIN (rectangle 40 16 "solid" "black"))

(define SCENE-WIDTH 256)
(define SCENE-HEIGHT 256)
(define TEXT-SIZE 16)
(define COLOR "red")
(define TEXT-X 0)
(define TEXT-UPPER-Y TEXT-SIZE)
(define TEXT-LOWER-Y (* TEXT-SIZE 8) )
(define EMPTY-SCENE (empty-scene SCENE-WIDTH SCENE-HEIGHT))


(define (move w)
  (if (>= w (+ SCENE-WIDTH 20))
      0
      (+ w 3)
      )
  )

(define (render w)
  (place-image TRAIN w (/ SCENE-HEIGHT 2) EMPTY-SCENE)
  )

; a state stores the trains x position
(big-bang 0
  (to-draw render)
  (on-tick move)
  )
