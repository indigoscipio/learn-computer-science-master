;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise-165) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))

;convert-robot-to-r2d2 is a function that takes a string
;it checks wheter the input is "robot"
;if so, replace it with "r2d2", if false return that current string
(define (convert-robot-to-r2d2 s)
  (if (equal? s "robot")
      "r2d2"
      s)
  )

;substitute string replaces old string with a given new one
; String String -> String
(define (substitute-string new old curr)
  (if (equal? curr old) new old)
  )


;subst-robot consumes a list of toy descriptions (one word strings)
; and replaces ALL occurences of "robot" with "r2d2" - all other/unmatched descriptions remains the same
; List-of-toys -> List-of-toys
; List-of-toys can be either of the following:
; '()
; List-of-toys '()
(define (subst-robot lot)
  ; base case: if the list is empty return an empty list
  (cond [(empty? lot) '()]
        ;if "robot" is found within the list, replace robot with "r2d2"
        ;else recurse
        [else (cons (convert-robot-to-r2d2 (first lot)) (subst-robot (rest lot)) )]
        )
  )
 

(define empty-lot '())
(define sample-lot (cons "robot" (cons "anime girlbot" (cons "saber" (cons "robot" '())))))

(subst-robot empty-lot)
(subst-robot sample-lot)

;substitute consumes 2 strings, new and old and a list of strings
; it produces a new list of strings by substituting occurences of all old occurences with enw
(define (substitute new old los)
  (cond [(empty? los) '()]
        [else (cons (substitute-string new old (first los))
                    (substitute new old (rest los)))]
        )
  )


(substitute "r2d2" "robot" sample-lot)