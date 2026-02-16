;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname exercise-225) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp")) #f)))
#|exercise 225: design a firefighting game;

The game is set in the western states where fires rage through vast forests.
It simulates an airborne fire-fighting effort. Specifically, the player acts as the pilot of an airplane
that drops loads of water on fires on the ground. The player controls the plane’s horizontal
movements and the release of water loads.

Your game software starts fires at random places on the ground.
You may wish to limit the number of fires, making them a function of how many fires are currently burning or other factors.
The purpose of the game is to extinguish all fires in a limited amount of time.
Hint Use an iterative design approach as illustrated in this chapter to create this game. |#

;Constants
(define GRID-SIZE 5)
(define FIRE-COUNT 5)
(define SCENE-WIDTH (* GRID-SIZE 20))
(define SCENE-HEIGHT (* GRID-SIZE 20))
(define PLANE-IMG (rectangle (* GRID-SIZE 4) (* GRID-SIZE 2) "solid" "green"))
(define PLANE-SPEED GRID-SIZE)
(define WATER-IMG (circle GRID-SIZE "solid" "blue"))
(define WATER-SPEED 5)
(define FIRE-IMG (triangle (* GRID-SIZE 2) "solid" "red"))
(define SCENE (empty-scene SCENE-WIDTH SCENE-HEIGHT ))
(define TIME-LIMIT 30)
(define HIT-THRESHOLD 5)

;a Plane is a struct
;make-plane Number (plane's x position) Number (plane's velocity)
; (make-plane 10 1) means plane is 10 distance away from the left and has 1 velocity
(define-struct plane [x-pos vel])
(define init-plane (make-plane (/ SCENE-WIDTH 2) PLANE-SPEED))

;a Water is a posn
;make-posn Number (water's x pos from left) Number (water's y pos from top)
(define empty-water '())
(define sample-water (make-posn 95 95))

;a Fire is a posn
;make-posn Number Number
;a List-of-fire is a list of fire '() or Fire List-of-fire
(define empty-lof '())
(define sample-lof (list (make-posn 10 10) (make-posn 95 95)))

;a Time is a Number
;interpretation determines the total duration remaining in seconds for the user to complete the game


;a FireFighter is a struct
;make-ff
(define-struct ff [plane water fire time])
(define sample-ff (make-ff init-plane sample-water sample-lof TIME-LIMIT))

;Euclidian distance calculation for collusion detection
(define (distance x1 y1 x2 y2)
  (sqrt (+ (sqr (- x1 x2)) (sqr (- y1 y2))))
  )

;Number -> List-of-fires
;generate random lof with list length of n with from 0 - SCENE WIDTH
(define (generate-random-lof n) 
  (cond [(equal? 0 n) '()]
        [else (cons (make-posn (+ GRID-SIZE (random 91)) (- SCENE-HEIGHT GRID-SIZE)) (generate-random-lof (sub1 n))) ])
  )
(define init-ff (make-ff init-plane empty-water (generate-random-lof FIRE-COUNT) TIME-LIMIT))


;Time -> Image
(define (render-time time img)
  (place-image (text (number->string (round time)) 12 "red") (* GRID-SIZE 2) (* GRID-SIZE 2) img)
  )

;Plane -> Image
(define (render-plane plane img)
  (place-image PLANE-IMG (plane-x-pos plane) (* GRID-SIZE 2) img)
  )

;Fire -> Image
(define (render-fire fire img)
 (place-image FIRE-IMG (posn-x fire) (posn-y fire) img) 
  )

 
;List-of-Fires -> Image
(define (render-lof lof img)
  (cond [(empty? lof) (place-image empty-image 0 0 img)]
        [else (render-fire (first lof) (render-lof (rest lof) img))]
        )
  )



(define (render-water water img)
  (cond [(empty? water) (place-image empty-image 0 0 img)]
        [else (place-image WATER-IMG (posn-x water) (posn-y water) img)])
  )


;WorldState (ff) -> Image
(define (ff-render ws)
  (render-time (ff-time ws) (render-plane (ff-plane ws)
                (render-water (ff-water ws) (render-lof (ff-fire ws) SCENE))))
  
  ;render the plane
  ;render the water 
  ;render the fire
  )
;(render-ff sample-ff)


;Water (posn) Plane -> Water (posn)
;drops water from the current plane's position
(define (drop-water water plane)
  (cond [(empty? water) (make-posn (plane-x-pos plane) (* GRID-SIZE 2))]
        [else water]) 
  )

;move water down to the bottom of the canvas
; Water -> Water
(define (move-water water)
  (cond [(empty? water) water]
        [(>= (posn-y water) (- SCENE-WIDTH GRID-SIZE)) '()]
        [else (make-posn (posn-x water) (+ (posn-y water) WATER-SPEED) )])
  )
 


(define (ff-change ws key)
  (cond [(key=? "left" key) (make-ff (make-plane (- (plane-x-pos (ff-plane ws)) (plane-vel (ff-plane ws))) (plane-vel (ff-plane ws)) )
                                     (ff-water ws)
                                     (ff-fire ws)
                                     (ff-time ws))]
        [(key=? "right" key) (make-ff (make-plane (+ (plane-x-pos (ff-plane ws)) (plane-vel (ff-plane ws))) (plane-vel (ff-plane ws)) )
                                      (ff-water ws)
                                      (ff-fire ws)
                                      (ff-time ws))]
        [(key=? " " key) (make-ff (ff-plane ws)
                                  (drop-water (ff-water ws) (ff-plane ws))
                                  (ff-fire ws)
                                  (ff-time ws))]
        [else ws]
        ))
;(ff-change init-ff "left")

;checks if a water hits a given lof
;if so, return true; else false
; Water Fire -> Boolean
(define (water-hits-fire? water fire)
  (cond [(empty? water) #false]
        [(<= (distance (posn-x water)
                    (posn-y water)
                    (posn-x fire)
                    (posn-y fire)
                    ) HIT-THRESHOLD) #true]
        [else #false])
  )
;(water-hits-fire? sample-water (make-posn 10 10))

;removes the extinguished fire
; Water List-of-fire -> List-of-fire
(define (remove-extinguished-fire water lof)
  (cond [(empty? lof) '()]
        [(water-hits-fire? water (first lof)) (remove-extinguished-fire water (rest lof))]
        [else (cons (first lof) (remove-extinguished-fire water (rest lof))) ])
  )

; List-of-fire -> Boolean
(define (all-fires-extinguished? lof)
  (if (empty? lof)
      #t
      #f
  ))

 
;WorldState -> WorldState 
(define (ff-tock ws)
  (make-ff (ff-plane ws) 
           (move-water (ff-water ws))
           ;check if water hits any lof
           (remove-extinguished-fire (ff-water ws) (ff-fire ws))
           (- (ff-time ws) 0.1))
  )

;WorldState -> WorldState
;handles how the game ends
(define (ff-end? ws)
  ;game ends if timer runs out (player loses)
  (cond [(zero? (ff-time ws)) #true]
        [(all-fires-extinguished? (ff-fire ws)) #true]
        [else #false])
  ;game ends if all lof are extinguisehd (player wins)
  )

;WorldState -> Image
(define (render-game-over ws)
  (cond [(zero? (ff-time ws)) (place-image (text "Time out" 20 "red") (/ SCENE-WIDTH 2) (/ SCENE-HEIGHT 2) (ff-render ws))] 
        [(all-fires-extinguished? (ff-fire ws)) (place-image (text "You Win!" 20 "green") (/ SCENE-WIDTH 2) (/ SCENE-HEIGHT 2) (ff-render ws))]
        [else (ff-render ws)])
  )

(define (ff-prog ws)
  (big-bang ws
    [on-tick ff-tock 0.1]
    [to-draw ff-render]
    [on-key ff-change]
    [stop-when ff-end? render-game-over]
    )
  )
(ff-prog init-ff)
