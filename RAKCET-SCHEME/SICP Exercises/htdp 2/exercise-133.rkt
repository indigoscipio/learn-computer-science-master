;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise-133) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
(define (contains-flatt? alon)
  (cond [(empty? alon) #false ]
        ; check if it's a cons/list type
        [(cons? alon)
         ; check if first list contains the name
         ; check if the rest of the list contains the name 
         (or (string=? (first alon) "Flatt") (contains-flatt? (rest alon)) )]
        )
  )



(define sample-list (cons "Flatt" (cons "TEST" '())))
(define sample-list-2 (cons "Fagan"
  (cons "Findler"
    (cons "Fisler"
      (cons "Flanagan"
        (cons "Flatt"
          (cons "Felleisen"
            (cons "Friedman" '())))))))
)

(contains-flatt? sample-list-2)

