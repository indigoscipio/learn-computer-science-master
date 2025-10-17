#lang racket


; a Nucleotide is a 1string (char) of either of the following:
; #\A
; #\C
; #\G
; #\T

; A DNA is a sequence of nucleotides
; List-of-nucleotides
; "GATTACA", "ACTGGA"

; a Count is a pair of (Nucleotide Number)
; '(#\A . 20)

; a DNAResult is a list of counts of the whole nucleotide in ACGT sequence
; '((#\A . 10) (#\C . 2) (#\G . 5) (#\T . 10))

; A Counter is a 4-tuple: (A-count C-count G-count T-count)
; represented as a 4-element list
; List-of-Number, eg: '(3 1 1 2)

(define (is-nucleotide? c)
  (or (eq? c #\A)
      (eq? c #\C)
      (eq? c #\G)
      (eq? c #\T)
      )
  )

; Increments the counter tuple given a nucleotide
; Nucleotide Counter -> Counter
(define (update-count n counter)
  (let ((nuc-a (list-ref counter 0))
        (nuc-c (list-ref counter 1))
        (nuc-g (list-ref counter 2))
        (nuc-t (list-ref counter 3)))
    (cond [(eq? n #\A) (list (+ 1 nuc-a) nuc-c nuc-g nuc-t)] ;update index 0
          [(eq? n #\C) (list nuc-a (+ 1 nuc-c) nuc-g nuc-t)]
          [(eq? n #\G) (list nuc-a nuc-c (+ 1 nuc-g) nuc-t)]
          [(eq? n #\T) (list nuc-a nuc-c nuc-g (+ 1 nuc-t))]
          [else (error "Invalid Nucleotide: " n)])
    )
  )
;(update-count #\A '(1 2 3 4))

; DNA (List-of-nucleotides) -> DNAResult
(define (nucleotide-count dna)
  (let ((seq (string->list dna))
        (init-counter '(0 0 0 0))
        )

    
    (define (iter l acc)
      (cond [(empty? l) acc]
            [else (iter (cdr l) (update-count (car l) acc)) ])
      )

    ; build the result
    (let ((final-count (iter seq init-counter))
          (nucleotides (list #\A #\C #\G #\T))
          )
      (map cons nucleotides final-count)
      
      )

    ;using foldr
    (foldr update-count init-counter seq)
    
    )
  )

(nucleotide-count "")
(nucleotide-count "G")
(nucleotide-count "AAAA")
(nucleotide-count "GATTACA")
(nucleotide-count "XXXX")
