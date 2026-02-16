;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname exercise-217) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp")) #f)))
;Constants
(define GRID-SIZE 5)
(define WORLD-WIDTH 100)
(define WORLD-HEIGHT 100)
(define SNAKE-COLOR "red")
(define FOOD-COLOR "green")
(define SNAKE-IMG (circle GRID-SIZE "solid" SNAKE-COLOR))
(define FOOD-IMG (circle GRID-SIZE "solid" FOOD-COLOR))
(define EMPTY-SCENE (empty-scene WORLD-WIDTH WORLD-HEIGHT))

;A Tail is one of the following
; '()
; Posn List-of-Posns
;interpretation data structure for the snake's tail
(define sample-tail (list (make-posn 50 50) (make-posn 40 50) (make-posn 30 50)))

;A Snake is a struct
;make-snake Posn (head position) String (direction) List-of-posns (Tail)
;interpretation the data structure for the snake
(define-struct snake [h d t])

(define snake-init (make-snake (make-posn (/ WORLD-WIDTH 2) (/ WORLD-HEIGHT 2)) "right" '()))
(define sample-snake1 (make-snake (make-posn 20 50) "up" '()))
(define sample-snake2 (make-snake (make-posn 50 50) "down" '()))
(define sample-snake3 (make-snake (make-posn 10 10) "right" sample-tail))
(define sample-food-p (make-posn 10 10))

; A WorldState is a struct
; make-world Snake food-pos
(define-struct world [snake food-pos])
(define init-world (make-world sample-snake3 sample-food-p))

; Posn Posn -> Posn 
(define (food-check-create p candidate)
  (if (equal? p candidate) (food-create p) candidate))

; Posn -> Posn 
(define (food-create p)
  (food-check-create
     p (make-posn (random WORLD-WIDTH) (random WORLD-HEIGHT))))

 
;List-of-posns Image -> Image
;This function will take the tail (list of posn) and the current image (canvas) as arguments.
(define (render-tail lopsn img)
  (cond [(empty? lopsn) img]
        [else (place-image SNAKE-IMG (posn-x (first lopsn)) (posn-y (first lopsn)) (render-tail (rest lopsn) img))] )
  )

; WorldState -> Image
(define (render ws)
  (place-image FOOD-IMG (posn-x (world-food-pos ws)) (posn-y (world-food-pos ws))
               (place-image SNAKE-IMG (posn-x (snake-h (world-snake ws))) (posn-y (snake-h (world-snake ws)))
                            (render-tail (snake-t (world-snake ws)) EMPTY-SCENE)))
  
  )

;List-of-posns -> List-of-posns 
(define (remove-last-tail lopsn)
  (cond [(empty? lopsn) '()]
        [(empty? (rest lopsn)) '() ]
        [else (cons (first lopsn) (remove-last-tail (rest lopsn))) ]
        )
  )
;(remove-last-tail sample-tail)
;(empty? (rest (list (make-posn 40 50))))
;(empty?  (list (make-posn 40 50))) 


;is-food-eaten?
;checks the food's current position adn the snake's head current position.
; if thye're both the same, return true. otherwise false.
; Posn (Snake Head Pos) Posn (Food Pos) -> Boolean
(define (is-food-eaten? snake-p food-p)
  (equal? snake-p food-p)
  )
(is-food-eaten? (make-posn 10 10) (make-posn 10 10) )
 
; WorldState -> WorldState 
(define (tock ws)

  
  ;if it doesn't just move it normally
  
  (cond [(equal? (snake-d (world-snake ws)) "left")
         (make-world  (make-snake (make-posn (- (posn-x (snake-h (world-snake ws))) GRID-SIZE)(posn-y (snake-h (world-snake ws))))
                      "left"
                      (cons (snake-h (world-snake ws)) (remove-last-tail (snake-t (world-snake ws)) ))
                      )
                      
                     (world-food-pos ws))]
        
        [(equal? (snake-d (world-snake ws)) "right")
         (make-world (make-snake (make-posn (+ (posn-x (snake-h (world-snake ws))) GRID-SIZE) (posn-y (snake-h (world-snake ws))))
                     "right"
                     (cons (snake-h (world-snake ws)) (remove-last-tail (snake-t (world-snake ws)) )))
                     (world-food-pos ws))] 
        
        [(equal? (snake-d (world-snake ws)) "up")
         (make-world (make-snake (make-posn (posn-x (snake-h (world-snake ws))) (- (posn-y (snake-h (world-snake ws))) GRID-SIZE))
                      "up"
                      (cons (snake-h (world-snake ws)) (remove-last-tail (snake-t (world-snake ws)) )))
                     (world-food-pos ws))]
        
        [(equal? (snake-d (world-snake ws)) "down")
         (make-world (make-snake (make-posn (posn-x (snake-h (world-snake ws))) (+ (posn-y (snake-h (world-snake ws))) GRID-SIZE))
                      "down"
                      (cons (snake-h (world-snake ws)) (remove-last-tail (snake-t (world-snake ws)) )))
                      (world-food-pos ws))]
        [(equal? (snake-h (world-snake ws)) (world-food-pos ws))
         (make-world (make-snake (snake-h (world-snake ws)) (snake-d (world-snake ws)) (cons (snake-h (world-snake ws)) (snake-t (world-snake ws)) ) )
                     (food-create (snake-h (world-snake ws))))]
        [else ws])
  )
;(tock init-world)  

; WorldState String -> WorldState 
(define (change ws key)
  (cond
    [(key=? key "left")  (make-world (make-snake (snake-h (world-snake ws)) "left" (snake-t (world-snake ws))) (world-food-pos ws))]
    [(key=? key "right") (make-world (make-snake (snake-h (world-snake ws)) "right" (snake-t (world-snake ws)) ) (world-food-pos ws))]
    [(key=? key "up")    (make-world (make-snake (snake-h (world-snake ws)) "up" (snake-t (world-snake ws)) ) (world-food-pos ws))]
    [(key=? key "down")  (make-snake (snake-h (world-snake ws)) "down" (snake-t (world-snake ws)) ) ]
    [else ws]))
;(change sample-snake1 "right")

;WorldState -> Boolean
(define (end? ws)
  ;worm hits the wall
  (cond [(>= (posn-x (snake-h ws)) WORLD-WIDTH) #true] ; snake reaches right border
        [(<= (posn-x (snake-h ws)) 0) #true] ; snake reaches left border
        [(>= (posn-y (snake-h ws)) WORLD-HEIGHT) #true] ; snake reaches top border
        [(<= (posn-y (snake-h ws)) 0) #true]
        [(member? (snake-h ws) (snake-t ws) ) #true]
        [else #false])
  )



;WorldState -> Image
;renders the game over final image
(define (render-game-over ws)
  (place-image 
   (cond [(or (>= (posn-x (snake-h ws)) WORLD-WIDTH)
              (<= (posn-x (snake-h ws)) 0)
              (>= (posn-y (snake-h ws)) WORLD-HEIGHT)
              (<= (posn-y (snake-h ws)) 0))
          (text "Snake hit wall!" 12 "red")]
         [else (text "Snake ran into itself!" 12 "red")])
   (/ WORLD-WIDTH 2) 
   (/ WORLD-HEIGHT 2) 
   (render ws)))


(define (snake-main ws)
  (big-bang ws
    [on-tick tock .25] 
    [to-draw render]
    [on-key change]
    [stop-when end? render-game-over]
    )
  ) 
;(snake-main snake-init) 