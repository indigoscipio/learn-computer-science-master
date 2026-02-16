;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise-109) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
(define WORLD-WIDTH 100)
(define WORLD-HEIGHT 100)
(define SCENE (rectangle 100 100 "outline" "black"))
(define (RECTANGLE c) (rectangle 100 100 "solid" c))
(define EXPECTED-WORD "abcd")

;Guess is a struct
; make-guess (String String)
; State is only the following: "initial", "progress", "finished", "error"
; color corresponds to the four states above: initial = white, progress = yellow, finished = green, and error = red
(define-struct guess [state color current])
(define guess-sample (make-guess "initial" "white" 0))



(define (render ws)
  (place-image (RECTANGLE (guess-color ws)) (/ WORLD-WIDTH 2) (/ WORLD-HEIGHT 2) SCENE)
  )
(render guess-sample)


(define (change ws ke)
  ;INITIAL state - defauly state/game begins
  
  (cond
    ;PROGRESS state - first letter is types
    [(string=? ke "a") (make-guess "progress" "yellow" 1)]

    ; PROGRESS state - user types either B/C/D can be any particular order
    [(and (string=? (guess-state ws) "progress")

          (string=? (substring EXPECTED-WORD (guess-current ws) (+ (guess-current ws) 1)) ke) )

     ; if all of the expected worss are filled, change state to finished
     ; else still yellow and increment the guess to +1
     (if (>= (guess-current ws) (- (string-length EXPECTED-WORD) 1))
         (make-guess "finished" "green" (guess-current ws))
         (make-guess "progress" "yellow" (+ (guess-current ws) 1))
         )
     ]

    ; once ABCD is typed, trnsition to success sate
    [(string=? (guess-state ws) "finisehd") (make-guess (guess-state ws) "green" (guess-current ws))]

    ;otherwise give error
    [else (make-guess "error" "red" (guess-current ws) )]

        )
  
  ;finished state - this is when user has type all of the letters/final letter
  ;error state - this state happens if the user didn't type the first letter correctly
  ; or when the user typed the ltter incorrectly wihin the expect state
  )


#|

    [else (if (not (or (string=? ke "a") (string=? ke "b") (string=? ke "c") (string=? ke "d") )) 
              (make-guess "error" "red" )
              ws)]
|#


(define (guess-prog ws)
  (big-bang ws
    [to-draw render]
    [on-key change]
    )
  )
(guess-prog guess-sample)
