;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise-12) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))

(define (cvolume x)
  (* x x x)
  )

(define (csurface x)
  (* 6 (* x x))
  )


(define (string-first string)
  (string-ref string 0)
  )


(define (string-last string)
  (string-ref string  (-  (string-length string) 1))

  
  )


(define (implies sunny friday)
  (or (not sunny) friday))

(define (image-area img)
  (* (image-width img) (image-height img))
  )

(define (image-classify img)
 (cond [(> (image-height img) (image-width img)) "TALL"]
       [(> (image-width img) (image-height img)) "WIDE"]
       [else "SQUARE"])
  )


(define (string-join str1 str2)
  (string-append str1 "_" str2)
  )


(define (string-insert str i)

  (if (string-whitespace? str)
      (error "Can't be empty")
        (if (or (< i 0) (> i (string-length str)))
      
      (error "String length exceeds i")
      
  
  (string-append 
  (substring str 0 i) "_" 
  (substring str i) )
      )
      )
  
  )

(define (string-delete str i)

    (if (string-whitespace? str)
      (error "Can't be empty")
        (if (or (< i 0) (> i (string-length str)))
      
      (error "String length exceeds i")
      
  
    
  (string-append
   (substring str 0 i)
   (substring str (+ i 1))
   )
      )
      )

  
  )

(string-delete " " 1)
