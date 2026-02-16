;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise-101) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
(define WORLD-WIDTH 200)
(define WORLD-HEIGHT 300)
(define UFO-SIZE 15)
(define TANK-WIDTH 30)
(define TANK-HEIGHT 10)
(define MISSLE-WIDTH 5)
(define MISSLE-HEIGHT 10)
(define MISSLE-SPEED 5)
(define TANK-SPEED 5)
(define UFO-SPEED 1)
(define UFO-RANDOM-X-SPEED 1)
(define SCENE (rectangle WORLD-WIDTH WORLD-HEIGHT "outline" "black"))
(define UFO (triangle UFO-SIZE "solid" "red"))
(define TANK (rectangle TANK-WIDTH TANK-HEIGHT "solid" "green"))
(define MISSLE (rectangle MISSLE-WIDTH MISSLE-HEIGHT "solid" "black"))
(define HIT-THRESHOLD 10)



(define-struct tank [loc vel])
(define-struct sigs [ufo tank missile])
(define tank-sample (make-tank 25 3))
(define missle-sample (make-posn 15 88) )
(define sigs-sample (make-sigs (make-posn 88 48) (make-tank 25 3) #false))


(define (render-tank t s)
  (place-image TANK (tank-loc t) (- WORLD-HEIGHT (/ TANK-HEIGHT 2)) s)
  )


(define (render-ufo u s)
  (place-image UFO (posn-x u) (posn-y u) s)
  )

; MissileOrNot Image -> Image 
; adds an image of missile m to scene s 
(define (render-missle m s)
  (cond [(boolean? m) s]
        [(posn? m) (place-image MISSLE (posn-x m) (posn-y m) s)]
        )
  )

;Euclidian distance calculation
(define (distance x1 y1 x2 y2)
 (sqrt (+ (sqr (- x1 x2)) (sqr (- y1 y2))))
  )

;Number -> Number
;produces a number in the interval [0,n)
(define (generate-random-num n)
  (random n)
  )


; SIGS -> SIGS
;(make-tank (- (tank-loc (fired-tank si)) (tank-vel (fired-tank si))) (tank-vel (fired-tank si)))
(define (control si ke)
  (cond [(string=? ke "left") (make-sigs (sigs-ufo si)
                                         (make-tank (- (tank-loc (sigs-tank si)) (tank-vel (sigs-tank si))) (tank-vel (sigs-tank si)))
                                         (sigs-missile si)
                                         )]
        [(string=? ke "right") (make-sigs (sigs-ufo si)
                                          (make-tank (+ (tank-loc (sigs-tank si)) (tank-vel (sigs-tank si))) (tank-vel (sigs-tank si)))
                                          (sigs-missile si)) ]
        [(string=? ke " ") (make-sigs (sigs-ufo si)
                                      (sigs-tank si)
                                      ;if there's a missle fired, don't do anything
                                      (if (boolean? (sigs-missile si))
                                          (make-posn (tank-loc (sigs-tank si)) (- WORLD-HEIGHT TANK-HEIGHT))
                                          (sigs-missile si)
                                          )
                                      ;if the missle hasn't reached the top of the screen, don't fire any missile
                                      )]
        [else si]
        )
  )

;(control (make-sigs (make-posn 88 48) (make-tank 25 3) (make-posn 66 48)) "left")
;(control (make-sigs (make-posn 88 48) (make-tank 25 3) (make-posn 66 48)) "right")


;SpaceInvader -> SpaceInvader
(define (move-proper si delta)
   ;if ufo does not reach bottom of the screen, keep moving
  ;UFO moves to either the left or the right randomly

  (make-sigs (make-posn (+ (posn-x (sigs-ufo si)) (if (= (random 2) 0) (- delta) delta))
                        (+ (posn-y (sigs-ufo si)) UFO-SPEED))
             (make-tank (tank-loc (sigs-tank si)) (tank-vel (sigs-tank si)))
             (if (boolean? (sigs-missile si))
                 (sigs-missile si)
                 (if (<= (posn-y (sigs-missile si)) (/ MISSLE-HEIGHT 2))
                     #false
                     (make-posn (posn-x (sigs-missile si)) (- (posn-y (sigs-missile si)) MISSLE-SPEED) )
                     )
                 
                 )
             )
  
  )
;(move-proper (make-sigs (make-posn 88 48) (make-tank 25 3) #false) 5)
;(move-proper (make-sigs (make-posn 88 48) (make-tank 25 3) (make-posn 15 15)) 5)

(define (move si)
  (move-proper si (generate-random-num 5))
  )


(define (render si)
  (render-tank (sigs-tank si) (render-ufo (sigs-ufo si) (render-missle (sigs-missile si) SCENE)))
  )
;(render (make-sigs (make-posn 88 48) (make-tank 25 3) (make-posn 66 48) ))
;(render (make-sigs (make-posn 88 48) (make-tank 25 3) #false ))

;SpaceInvader -> Boolean
(define (si-game-over? si)
        ;check if the UFO lands - if so the game ends
  (cond [ (>= (posn-y (sigs-ufo si))  (- WORLD-HEIGHT (/ UFO-SIZE 2))) #t]
        ;if the missle hits the ufo, the game ends
        ;if the missle is not firing, return si

        [(and (posn? (sigs-missile si)) (<= (distance (posn-x (sigs-ufo si))
                        (posn-y (sigs-ufo si))
                        (posn-x (sigs-missile si))
                        (posn-y (sigs-missile si))
                        ) HIT-THRESHOLD))  #t]
        [else #f]
        )


  )

(define (si-render-final si)
  (if (si-game-over? si)
      (place-image (text "Game Over" 30 "red")
                   (/ WORLD-WIDTH 2) (/ WORLD-HEIGHT 2)
                   SCENE)
      (render si)
      )
  )



; A SIGS.v2 (short for SIGS version 2) is a structure:
;   (make-sigs UFO Tank MissileOrNot)
; interpretation represents the complete state of a
; space invader game
(define (main si)
  (big-bang si
    [on-tick move]
    [to-draw render]
    [on-key control]
    [stop-when si-game-over? si-render-final]
    )
  )
(main sigs-sample)