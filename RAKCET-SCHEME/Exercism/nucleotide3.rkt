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

(define (is-nucleotide? c)
  (or (eq? c #\A)
      (eq? c #\C)
      (eq? c #\G)
      (eq? c #\T)
      )
  )

; Increments the counter tuple given a nucleotide
; Nucleotide DNAResult -> DNAResult
(define (update-count n counter)
  (let ((result (assoc n counter) )
        )
    (if result
        (map (lambda (pair) (if (eq? (car pair) n)
                                (cons (car pair) (+ 1 (cdr pair))) ;update the counter
                                pair ;ignore
                                )
               
               ) counter)
        (error "invalid nucleotide:" n)
        )
    )
  )
(update-count #\A '((#\A . 0) (#\C . 0) (#\G . 0) (#\T . 0)))

; DNA (List-of-nucleotides) -> DNAResult
(define (nucleotide-count dna)
  (let ((seq (string->list dna))
        (init-result '((#\A . 0) (#\C . 0) (#\G . 0) (#\T . 0)))
        )
    (foldr update-count init-result seq)
    )
  )

(nucleotide-count "")
(nucleotide-count "G")
(nucleotide-count "AAAA")
(nucleotide-count "GATTACA")
(nucleotide-count "XXXX")
