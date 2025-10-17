#lang racket


; A DNA Sequence is a list of 1chars of either the following:
; #\G, #\A, #\C, #\T

; Assume the two sequences/strands are of equal list

; DNA-Sequence DNA-Sequence -> Number
(define (hamming-distance strand-a strand-b)
  (let ((seq-a (string->list strand-a))
        (seq-b (string->list strand-b))
        )

    ; DNA-Sequence DNA-Sequence -> Number
    ; initializes the humming counter with accumulator
    (define (count-distance a b acc)
      (cond [(or (null? a) (null? b)) acc]
            [(not (and (eq? (car a) (car b)))) (count-distance (cdr a) (cdr b) (+ 1 acc))]
            [else (count-distance (cdr a) (cdr b) acc)])
      )

    (if (not (= (length seq-a) (length seq-b)))
        (error "List is not of equal length")
        (count-distance seq-a seq-b 0)
        )

    )
  )

(hamming-distance "GGACGGATTCTG" "AGGACGGATTCT")