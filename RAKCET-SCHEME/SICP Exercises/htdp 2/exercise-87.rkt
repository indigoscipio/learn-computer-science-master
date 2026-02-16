;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise-87) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
(define SCENE-WIDTH 200)
(define SCENE-HEIGHT 20)
(define TEXT-WIDTH 16)


; Editor is a structure
; interpretation it takes string and index
; (make-editor String Number)
;   - text is the entire text (String).
;   - cursor is the position of the cursor (Integer).
(define-struct editor [s i])
(define sample-editor (make-editor "Car" 0))


(define (string-remove-last str)
  (substring str 0 (- (string-length str) 1))
  )

(define (string-remove-first str)
  (substring str 1 (string-length str) )
  )

(define (string-first str)
  (string-ith str 0)
  )

(define (string-last str)
  (string-ith str (- (string-length str) 1))
  )

; Editor -> String

(define (edit ed ke)
 
  
  ;if ke is 1string, check for
  (if (= (string-length ke) 1)
      (cond
        ; handle backspace: decrease index by 1 and delete latest character of the string
        [(string=? ke "\b") (if (<= (editor-i ed) 0) ed ( make-editor (string-append 
   (substring (editor-s ed) 0 (- (editor-i ed) 1)) ; Left part
   (substring (editor-s ed) (editor-i ed)))  (- (editor-i ed) 1))) ]
        
        ;ignore tab or enter key
        [ (or (string=? "\t" ke) (string=? "\r" ke)) ed]

        ;else, add single character before the index
        [else (make-editor (string-append
                            (substring (editor-s ed) 0 (editor-i ed))
                            ke
                            (substring (editor-s ed) (editor-i ed)))
                           (+ (editor-i ed) 1)) ]       
            )
      
      ;else,
      (cond
        ;The cursor cannot move left if it's already at 0.
        [ (string=? ke "left")  (if (<= (editor-i ed) 0) ed (make-editor (editor-s ed) (- (editor-i ed) 1)) ) ]
        ;The cursor cannot move right if it's already at the end of the string.
        [(string=? ke "right") (if (>= (editor-i ed) (string-length (editor-s ed))) ed (make-editor (editor-s ed) (+ (editor-i ed) 1)))  ]
        [else ed]
            )
      )
  
  )

(edit sample-editor "\b")
(edit sample-editor "\t")
(edit sample-editor "\r")
(edit sample-editor "a")
(edit sample-editor "B")
(edit sample-editor "R")
(edit sample-editor "left")
(edit sample-editor "right")

;Editor -> Editor
;render function split the text based on the cursor position
(define (render ed)
  (overlay/align "left" "center"
            (beside 
               (text (substring (editor-s ed) 0 (editor-i ed)) TEXT-WIDTH "black")
               (rectangle 3 20 "solid" "red")
               (text (substring (editor-s ed) (editor-i ed) (string-length (editor-s ed)) ) TEXT-WIDTH "black")
             )
               (empty-scene SCENE-WIDTH SCENE-HEIGHT)
               )
  )
(render sample-editor)


(define (run ws)
  (big-bang ws
    [on-key edit]
    [to-draw render]
    )
  )
(run sample-editor)
