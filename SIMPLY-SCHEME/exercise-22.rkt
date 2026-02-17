#lang simply-scheme

#|
(let ((port (open-output-file "songs")))
  (show '(all my loving) port)
  (show '(ticket to ride) port)
  (show '(martha my dear) port)
  (close-output-port port))
|#

#|
(let ((port (open-output-file "songs2")))
  (show-line '(all my loving) port)
  (show-line '(ticket to ride) port)
  (show-line '(martha my dear) port)
  (close-output-port port))
|#

(define in (open-input-file "dddbmt"))
(read-line in)

(define (lastfirst name)
  (se (word (last name) ",") (bl name)))

(define (process-grades line)
  (se (first line)
      "total:"
      (accumulate + (bf line))
      "average:"
      (/ (accumulate + (bf line))
         (count (bf line)))))

(define (file-map fn inname outname)
  (let ((inport (open-input-file inname))
        (outport (open-output-file outname))
        )
    (file-map-helper fn inport outport)
    (close-input-port inport)
    (close-output-port outport)
    'done
    )
  )

(define (file-map-helper fn inport outport)
  (let ((line (read-line inport)))
    (if (eof-object? line)
        'done
        (begin (show-line line outport)
               (file-map-helper fn inport outport)
               )
        )
    )
  )


#|
22.1 Write a concatenate procedure that takes two arguments: a list of names of input files, and one name for an 
output file. The procedure should copy all of the input files, in order, into the output file.

answer:
|#

#|
(define (concatenate-helper innames outport)
  ; for each line in in input, copy it ant write to ourport
  ; once it reaches oef, stop and go to the next input
  (cond [(empty? innames) 'done]
        [else (let* ((fst-inname (car innames))
                    (inport (open-input-file fst-inname))
                    )
                (begin (copy-file-to-port inport outport)
                       (close-input-port inport)
                       (concatenate-helper (cdr innames) outport)
                       )
                
                )]
        )
  )

(define (copy-file-to-port inport outport)
  (let ((line (read-line inport)))
    (cond [(eof-object? line) 'done]
          [else (begin (show-line line outport)
                       (copy-file-to-port inport outport)
                       ) ])
    )
  )

  (define (concatenate innames outname)
    (let ((outport (open-output-file outname)))
      (concatenate-helper innames outport)
      (close-output-port outport)
    'done
    )
  )
(concatenate '("input1" "input2" "input3")  "finaloutput.txt")
|#

; ==================================================

#|
Exercise 22.2
22.2 Write a procedure to count the number of lines in a file. It should take the filename as argument and return the 
number.
|#

; inport -> number
(define (count-lines-helper inport)
  (let ((line (read-line inport)))
    (cond [(eof-object? line) 0]
          [else (+ 1 (count-lines-helper inport))])
    )
  )


; string -> num
(define (count-lines inname)
  (let* ((inport (open-input-file inname))
        (result (count-lines-helper inport))
        )
    (close-input-port inport)
    result
    )
  )
(count-lines "input1")

; ==================================================

#|
22.3 Write a procedure to count the number of words in a file. It should take the filename as argument and return the 
number.
|#


; inport -> number
(define (count-words-helper inport)
  (let ((line (read-line inport)))
    (cond [(eof-object? line) 0]
          [else (+ (length line) (count-words-helper inport))])
    )
  )


; string -> num
(define (count-words inname)
  (let* ((inport (open-input-file inname))
        (result (count-words-helper inport))
        )
    (close-input-port inport)
    result
    )
  )
(count-words "input1")


; ==================================================

#|
22.4 Write a procedure to count the number of characters in a file, including space characters. It should take the 
filename as argument and return the number.
|#


(define (count-chars-helper inport)
    (let ((line (read-string inport)))
    (cond [(eof-object? line) 0]
          [else (+ (+ (count line) 1) (count-chars-helper inport))])
    )
  )

; string -> num
(define (count-chars inname)
  (let* ((inport (open-input-file inname))
         (result (count-chars-helper inport))
         )
    (close-input-port inport)
    result
    )
  )
;(count-chars "input1")

; ==================================================

#|
22.5 Write a procedure that copies an input file to an output file but eliminates multiple consecutive copies of the same 
line. That is, if the input file contains the lines
John Lennon
Paul McCartney
Paul McCartney
George Harrison
Paul McCartney
Ringo Starr
then the output file should contain
John Lennon
Paul McCartney
George Harrison
Paul McCartney
Ringo Starr
|#

; inport outport -> #void
(define (copy-unique-helper inport outport prev-line)
  (let ((line (read-line inport)))
    (cond [(eof-object? line) 'done]
          [(equal? line prev-line) (copy-unique-helper inport outport line) ] ;check if there's any duplicate, if so don't write it
          [else (begin (show-line line outport)
                       (copy-unique-helper inport outport line)
                       )] ;if not, just write it to the output
          )
    )
  )

; string string -> #void
(define (copy-unique inf outf)
  (let ((inport (open-input-file inf))
        (outport (open-output-file outf))
        )
    (copy-unique-helper inport outport '())
    (close-input-port inport)
    (close-output-port outport)
    'done
    )
  )

; ==================================================


#|
22.6 Write a lookup procedure that takes as arguments a filename and a word. The procedure should print (on the 
screen, not into another file) only those lines from the input file that include the chosen word.

answer:
|#

; inport word -> void
(define (lookup-helper inport wd)
  (let ((line (read-line inport)))
    (cond [(eof-object? line) 'done]
          [(member? wd line) (begin (show line)
                                    (lookup-helper inport wd)
                                    )]  ;found, return the line
          [else (lookup-helper inport wd)] ;keep finding until the line is exhausted
          )
    )
  )

;lookup:: string word -> void
(define (lookup inname wd)
  (let ((inport (open-input-file inname)))
    (lookup-helper inport wd)
    (close-input-port inport)
    )
  )

; ==================================================

#|
22.7 Write a page procedure that takes a filename as argument and prints the file a screenful at a time. Assume that a 
screen can fit 24 lines; your procedure should print 23 lines of the file and then a prompt message, and then wait for 
the user to enter a (probably empty) line. It should then print the most recent line from the file again (so that the user 
will see some overlap between screenfuls) and 22 more lines, and so on until the file ends.
|#

; a Screen is a listof line (max 24)

; void->word
(define (wait-for-input)
  (let ((input (read-line)))
    input
    ))

; show screen to the interpreter and returns the very last line
; inport number number word -> word
(define (show-screen inport counter line-count last-line)
  ; if its the first time (last line is empty), show 23 lines
  ; if its the second time, update last-line from last item of the previous one
  (let ((line (read-line inport)))
    (cond [(eof-object? line) last-line]
          [(empty? last-line) ] ;first time calling
          [(>= counter line-count) last-line]
          [else (begin (show-line line)
                       (show-screen inport (+ counter 1) line-count line)
                       )])
    )
  )

(define (page-helper inport counter)
  ; when it begins, show the first screen (line 1 - 23)
  ; after line 23 ask user for the input
  ; when input is received, go to the next screen with 1st line from last screen and remaining 22, repeat
  ; lets test show screen first
  (show-screen inport counter 23 '())
  #|
    (begin (show-screen ...)
           (wait-for-input ...)
           (page-helper ...)
           )
  |#
  )

; string -> void
(define (page inname)
    (let ((inport (open-input-file inname)))
    (page-helper inport 0) ;initialize with curr page 0
    (close-input-port inport)
    )
  )
(page "lots-of-lines") ; a sample file with Line 1\n, Line 2\n, ... Line 100 dummy text