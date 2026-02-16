;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname exercise-224b) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp")) #f)))
(define GRID-SIZE 5)
(define MISSILE-IMG (rectangle (/ GRID-SIZE 2) 10 "solid" "black"))
(define MISSILE-SPEED 1)
(define TANK-SPEED 2)
(define UFO-SPEED 5)
(define TANK-IMG (rectangle 15 5 "solid" "green" ))
(define UFO-IMG (triangle 10 "solid" "red"))
(define SCENE-WIDTH (* GRID-SIZE 20))
(define SCENE-HEIGHT (* GRID-SIZE 20))
(define SCENE (empty-scene SCENE-WIDTH SCENE-HEIGHT))
(define HIT-THRESHOLD 5)

; A UFO is a list of Posn. 
; interpretation (list (make-posn x y)(make-posn x y)) are the UFOs location 
; (using the top-down, left-to-right convention). It can either be '() or Posn List-of-posn
(define empty-ufo '())
(define sample-ufo1 (list (make-posn 25 25)))
(define sample-ufo2 (list (make-posn 25 25) (make-posn 10 10)))
(define sample-ufo3 (list (make-posn 10 10) (make-posn 50 10) (make-posn 90 10)))

 
(define-struct tank [loc vel])
; A Tank is a structure:
;   (make-tank Number Number). 
; interpretation (make-tank x dx) specifies the position:
; (x, HEIGHT) and the tank's speed: dx pixels/tick
; leftmost = 10, rightmost = 90
(define sample-tank (make-tank 90 TANK-SPEED))
 
; A Missile is a list of Posn. 
; interpretation (list posn1 posn2...)is the missile's positions
; an empty missle/missle not fired is an empty list '()
; '() or Posn List-of-Posn

(define missile-empty '())
(define missile-fired1 (list (make-posn 25 25)) )
(define missile-fired2 (list (make-posn 25 25) (make-posn 30 30)))
(define missile-fired3 (list (make-posn 20 20) (make-posn 10 0) (make-posn 10 -10)))

(define-struct si [ufo tank missile])
; si (space-invader) is a structure
;   (make-si UFO Tank MissileOrNot)
; interpretation represents the complete state of a
; space invader game
(define sample-si (make-si sample-ufo2 sample-tank missile-fired1 ))
(define si-init (make-si sample-ufo3 sample-tank missile-empty))


; UFO/Posn -> Image
(define (render-ufo ufo img)
  (place-image UFO-IMG (posn-x ufo) (posn-y ufo) img )
  )

;List-of-ufos/posns -> Image
(define (render-ufos lou img)
  (cond [(empty? lou) (place-image empty-image 0 0 img)]
        [else (place-image UFO-IMG (posn-x (first lou)) (posn-y (first lou)) (render-ufos (rest lou) img))])
  )
;(render-ufos sample-ufo3 SCENE) 
;(render-ufos empty-ufo SCENE)


;Euclidian distance calculation for checking if the missile hits ufo
(define (distance x1 y1 x2 y2)
  (sqrt (+ (sqr (- x1 x2)) (sqr (- y1 y2))))
  )

; Missiles/lopsn -> Image
(define (render-missiles lopsn img)
  (cond [(empty? lopsn) (place-image empty-image 0 0 img)] 
        [else  (place-image MISSILE-IMG (posn-x (first lopsn)) (posn-y (first lopsn)) (render-missiles (rest lopsn) img) ) ])
  )

;(render-missiles (list (make-posn 90 90)) SCENE)

; Tank -> Image
(define (render-tank tank img)
  (place-image TANK-IMG (tank-loc tank) (- SCENE-HEIGHT (image-height TANK-IMG)) img)
  ) 
;(render-tank sample-tank SCENE)


; WorldState (SI) -> Image 
; renders the given game state on top of BACKGROUND 
(define (si-render ws)
  ;render the tank
  (render-tank (si-tank ws)
               ;render the ufo
               (render-ufos (si-ufo ws)   
                           ;render the missile
                           (render-missiles (si-missile ws) SCENE) ) )
  )
(si-render sample-si)

(define (move-missile-up missile)
  (make-posn (posn-x missile) (- (posn-y missile) MISSILE-SPEED))
  )
;(fire-missile (make-posn 0 29))
 
; Lopsn -> Lopsn
; fire-missiles fire a list of missiles up in the y direction.
(define (fire-missiles lopsn)
  (cond [(empty? lopsn) '()]
        ;if the missile reaches top boundary, make it dissapear
        [(<= (posn-y (first lopsn)) 0 ) (fire-missiles (rest lopsn)) ]
        [else (cons (move-missile-up (first lopsn)) (fire-missiles (rest lopsn))) ])
  )
;(fire-missiles missile-fired3)


;Number -> Number 
(define (randomize-ufo-x-axis pos)
  (if (equal? (random 2) 0)
      (+ pos UFO-SPEED)
      (- pos UFO-SPEED))
  )

;UFO -> UFO
;takes a ufo and moves it by UFO-SPEED down of the x axis
(define (move-ufo ufo)
  (make-posn (randomize-ufo-x-axis (posn-x ufo)) (+ (posn-y ufo) UFO-SPEED) )
  )
;(move-ufo sample-ufo)

;List-of-ufos/posns -> List-of-Ufos/Posns
;moves each ufo down to the bottom of the canvas by ufo speed each tock
;and moves right and left randomly by each tock
(define (move-ufos lou)
  (cond [(empty? lou) '()]
        [else (cons (move-ufo (first lou)) (move-ufos (rest lou)) ) ])
  )
;(random UFO-SPEED)
;(move-ufos sample-ufo3)

;checks if a UFO is getting hit by a missile.
;if so, return true
(define (missiles-hit-ufo? lom ufo)
  (cond [(empty? lom) #false]
        [(<= (distance (posn-x ufo)
                       (posn-y ufo)
                       (posn-x (first lom))
                       (posn-y (first lom))
                       ) HIT-THRESHOLD) #true]
        [else (missiles-hit-ufo? (rest lom) ufo)])
  )


;List-of-missiles List-of-ufos -> List-of-ufos
(define (remove-destroyed-ufo lom lou)
  (cond [(empty? lou) '()]
        ;check if a ufo is getting hit, if so remove fhr first one
        [(missiles-hit-ufo? lom (first lou)) (remove-destroyed-ufo lom (rest lou)) ]
        ;else add first one
        [else (cons (first lou) (remove-destroyed-ufo lom (rest lou))) ])
  )
;(remove-destroyed-ufo missile-fired2 sample-ufo2)
 


; WorldState (SI) -> WorldState
(define (si-tock ws)
  (make-si (remove-destroyed-ufo (si-missile ws) (move-ufos (si-ufo ws)))
           (si-tank ws)
           (fire-missiles (si-missile ws))) 
  ;the ufo descends by 1 grid size
  )



; WorldState KeyEvent -> WorldState
(define (si-change ws k)
  
  (cond [(key=? "left" k)(make-si (si-ufo ws)
                                  (make-tank (- (tank-loc (si-tank ws)) (tank-vel (si-tank ws))) (tank-vel (si-tank ws)) )
                                  (si-missile ws))]
        [(key=? "right" k)(make-si (si-ufo ws)
                                   (make-tank (+ (tank-loc (si-tank ws)) (tank-vel (si-tank ws))) (tank-vel (si-tank ws)) )
                                   (si-missile ws))] 
        [(key=? " " k) (make-si (si-ufo ws)
                                (si-tank ws)
                                (cons (make-posn (tank-loc (si-tank ws)) (- SCENE-HEIGHT 10)) (si-missile ws)) )]

        [else ws]
        )

  )
;(si-change sample-si "left")
;(si-change sample-si "right")



; List-of-ufos/posns -> Boolean
;checks if all UFOs are destroyed. If so, return true; else false
(define (all-ufos-destroyed? lou)
  (if (empty? lou) #true #false)
  )

;checks if theres any UFO from a given list of LOU that reaches the bottom of the canvas
; if so, return true; else false
; List-of-ufos/Posns -> Boolean
(define (ufo-reaches-bottom? lou)
  (cond [(empty? lou) #false]
        [(>= (posn-y (first lou)) (- SCENE-HEIGHT GRID-SIZE)) #true]
        [else (ufo-reaches-bottom? (rest lou))])
  )
(ufo-reaches-bottom? sample-ufo2)


;determines the end state of the game
; WorldState -> WorldState
(define (si-end? ws)
  ;game ends when the UFO is hit by any of the missile
  ;or game ends when UFO reaches the bottom of the canvas
  (cond [(ufo-reaches-bottom? (si-ufo ws)) #true]
        ;check if missile hits ufo 
        [(all-ufos-destroyed? (si-ufo ws)) #true ]
        [else #false])
  )


(define (si-render-game-over ws)
  (cond [(ufo-reaches-bottom? (si-ufo ws)) (place-image (text "You Lose!" 16 "red") (/ SCENE-WIDTH 2) (/ SCENE-HEIGHT 2) (si-render ws))]
        ;check if missile hits ufo 
        [(all-ufos-destroyed? (si-ufo ws)) (place-image (text "You Win!!" 16 "green") (/ SCENE-WIDTH 2) (/ SCENE-HEIGHT 2) (si-render ws)) ]
        [else (si-render ws)])
  
  )


(define (si-prog ws)
  (big-bang ws
    [on-tick si-tock]
    [to-draw si-render]
    [on-key si-change]
    [stop-when si-end? si-render-game-over]
    )
  )
(si-prog si-init)

