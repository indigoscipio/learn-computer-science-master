;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise-508) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))


(define FONT-SIZE 16)
(define FONT-COLOR "black")
(define CURSOR (rectangle 2 20 "solid" "red"))
;CURSOR

; [List-of 1String] -> Image
; renders a string as an image for the editor 
(define (editor-text s)
  (text (implode s) FONT-SIZE FONT-COLOR))
(editor-text (explode "hello"))
(image-width (editor-text (explode "he")) )

; An Editor is a structure:
;   (make-editor [List-of 1String] [List-of 1String])
; interpretation if (make-editor p s) is the state of 
; an interactive editor, (reverse p) corresponds to
; the text to the left of the cursor and s to the
; text on the right
(define-struct editor [pre post])
(define sample-editor (make-editor '("h" "e" "y") '("!")) )

;List-of-1String Number -> Editor
; ed represents string in some Editor and x represents x coord of the mouse click
; produces Editor such that (1) p and s make up ed and (2) x is larger than the image p and smaller than
; the image of p extended with the first 1string on s (if any).
(define (split-structural ed x)
  (local (; List-of-String Number Editor -> Editor
          ; acc accumulates editor pre with x incremented on each call
          (define (split-structural/a ed0 x acc)
            (cond [(empty? ed0) (make-editor (reverse (editor-pre acc)) (editor-post acc))]
              [(>= (image-width (editor-text (editor-pre acc)) ) x )(make-editor (reverse (editor-pre acc)) (editor-post acc))] ;image width of editor exceeds x, return the editor seperated
                  [else (split-structural/a (rest ed0) x (make-editor (cons (first ed0) (editor-pre acc))
                                                               (rest ed0)))] ;recurse until editor exceeds height
                  )
            )
          )
    (split-structural/a ed x (make-editor '() ed))
    )
  )
(split-structural '("h" "e" "l" "l" "o") 18)