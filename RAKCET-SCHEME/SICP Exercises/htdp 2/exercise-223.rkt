;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname exercise-223) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp")) #f)))
(define WIDTH 10) ; # of blocks, horizontally
(define HEIGHT 10)
(define SIZE 10) ; blocks are squares, Unit size = 0 - 9 (10 Units!)
(define SCENE-SIZE (* WIDTH SIZE))
(define SCENE (empty-scene SCENE-SIZE SCENE-SIZE) )
 
 
(define BLOCK ; red squares with black rims
  (overlay
   (square (- SIZE 1) "solid" "red")
   (square SIZE "outline" "black")))


; A Tetris is a structure:
;   (make-tetris Block Landscape)
(define-struct tetris [block landscape])
 

; A Block is a structure:
;   (make-block N N)
; (make-block x y) depicts a block whose left 
; corner is (* x SIZE) pixels from the left and
; (* y SIZE) pixels from the top;
; (make-tetris b0 (list b1 b2 ...)) means b0 is the
; dropping block, while b1, b2, and ... are resting
(define-struct block [x y])


; A Landscape is one of: 
; – '() 
; – (cons Block Landscape)


;sample definitions
(define sample-block1 (make-block 0 9))
(define sample-block2 (make-block 0 0))
(define sample-block3 (make-block 0 6))
(define sample-block4 (make-block 8 8))
(define block-init (make-block 0 0))
(define landscape-init '())
(define empty-landscape '())
(define sample-landscape1 (list sample-block2 sample-block3))
(define sample-landscape2 (list sample-block3 sample-block4 sample-block2))
(define sample-tetris1 (make-tetris sample-block1 sample-landscape1))
(define sample-tetris2 (make-tetris sample-block2 sample-landscape2))
(define sample-tetris3 (make-tetris sample-block1 empty-landscape))
(define tetris-init (make-tetris block-init landscape-init))

;List-of-blocks -> Image
(define (render-landscape lob) 
  (cond [(empty? lob) SCENE]
        [else (place-image BLOCK (+ (* (block-x (first lob)) SIZE) (/ WIDTH 2)) (+ (* (block-y (first lob)) SIZE) (/ WIDTH 2)) (render-landscape (rest lob)) )])
  )
;(render-landscape sample-landscape2) 

;Tetris (WorldState) -> Image 
(define (render ws)
  (place-image BLOCK (+ (* (block-x (tetris-block ws)) SIZE) (/ WIDTH 2))
               (+ (* (block-y (tetris-block ws)) SIZE) (/ WIDTH 2) )
               (render-landscape (tetris-landscape ws)) )
  )
;(render-landscape (tetris-landscape ws))
(render sample-tetris1)

;N -> N
; takes a current block and determines if it's placed more than the width of the canvas
; if so, start the x back to 0; else returns current block col 
(define (update-block-col n)
  (if (> n (- WIDTH 1))
      0
      n
      )
  )
;(update-block-col sample-block1) 

;WorldState -> World-State
;determines each clock tick of the worldstate 
(define (tock ws)  
  ;check if block has landed on the floor 
  ;or  if block has landed on member of landscape
  ;if so, add curr block to the list ofl andscapes and add next block's col by 1
  (cond [(or (member? (make-block (block-x (tetris-block ws)) (add1 (block-y (tetris-block ws)))) (tetris-landscape ws)) (>= (block-y (tetris-block ws)) (- HEIGHT 1)))
         (make-tetris (make-block (update-block-col (add1 (block-x (tetris-block ws)))) 0 )
                      (cons (make-block (block-x (tetris-block ws)) (block-y (tetris-block ws)) ) (tetris-landscape ws)) )]
        
        ;else drop the block on y-axis 
        [else (make-tetris (make-block (block-x (tetris-block ws)) (add1 (block-y (tetris-block ws)))) (tetris-landscape ws) )])

  )

(tock sample-tetris3) 

(define (change ws key)
  (cond [(key=? key "left") (if (> (block-x (tetris-block ws)) 0 )
                                (if (member? (make-block (sub1 (block-x (tetris-block ws)))
                                                         (block-y (tetris-block ws)))
                                             (tetris-landscape ws))
                                    ws  ; do nothing if the left cell is occupied
                                    (make-tetris (make-block (sub1 (block-x (tetris-block ws)))
                                                             (block-y (tetris-block ws)))
                                                 (tetris-landscape ws)))
                                                         ws )
                            ]
        [(key=? key "right") (if (< (block-x (tetris-block ws)) (- WIDTH 1))
                                 (if (member? (make-block (add1 (block-x (tetris-block ws)))
                                                          (block-y (tetris-block ws)))
                                              (tetris-landscape ws))
                                     ws  ; do nothing if the right cell is occupied
                                     (make-tetris (make-block (add1 (block-x (tetris-block ws)))
                                                              (block-y (tetris-block ws)))
                                                  (tetris-landscape ws)))
                                 ws)]
        [else ws])
  ) 

;Block -> Boolean
;checks if a block has touched the top of the canvas from a given lob
(define (block-reaches-top? lob)
  (cond [(empty? lob) #false] 
        [(<= (block-y (first lob)) 0) #true]
        [else (block-reaches-top? (rest lob))]
        ) 
  )
;(block-reaches-top? sample-landscape1)


;WorldState -> Boolean
(define (handle-game-end ws)
  (cond [(empty? (tetris-landscape ws)) #false]
        [else (block-reaches-top? (tetris-landscape ws)) ]
        )
  )

; List-of-block -> Number
(define (get-total-landscapes lob)
  (cond [(empty? lob) 0]
        [else (+ 1 (get-total-landscapes (rest lob))) ])
  )

;(handle-game-end sample-tetris1)
(define (get-final-score ws)
  (+ 1 (get-total-landscapes (tetris-landscape ws))))

(define (render-game-end ws)
  (place-image (text (string-append "End!Score" (number->string (get-final-score ws)) ) 12 "red") (/ SCENE-SIZE 2) (/ SCENE-SIZE 2) (render ws))
  )

;tetris-main
(define (tetris-main ws speed)
  (big-bang ws
    [on-tick tock speed]
    [to-draw render]
    [on-key change]
    [stop-when handle-game-end render-game-end]
    )
  )
(tetris-main tetris-init .1)
