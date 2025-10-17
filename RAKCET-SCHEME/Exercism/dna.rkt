#lang racket

; A DNA Sequence is a list of 1 chars: #\C #\G #\T #\A
; An RNA Sequence is a list of 1 chars: #\C #\G #\A #\U


; transcribe : Char -> Char
; transcribes a given 1string DNA into a RNA char
(define (transcribe dna)
  (cond [(equal? dna #\C) #\G]
        [(equal? dna #\G) #\C]
        [(equal? dna #\T) #\A]
        [else #\U]
        )
  )

; dna->rna : String -> String
(define (dna->rna dna)
  ; base case: return empty string if sequence is empty
  (let ((seq (string->list dna)))

    #|
    (define (build-list l)
      (cond [(null? l) '()]
            [else (cons (transcribe (car l))
                        (build-list (cdr l)))]
            )
      )
    (list->string (build-list seq))
    |#

     (list->string (map transcribe seq))
    
    )
  )

(dna->rna "A")
(dna->rna "ACGTGGTCTTAA")