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

; DNA (List-of-nucleotides) -> DNAResult
(define (nucleotide-count dna)
  (let ((seq (string->list dna)))
  
    ; build the list using accumulator
    ; List-of-X Nucleotide List-of-Y -> MaybeNumber
    (define (iter l n acc)
      (cond [(null? l) acc]
            [(not (is-nucleotide? (car l))) (error "Not a valid nucleotide:" (car l))]
            [(eq? (car l) n) (iter (cdr l) n (+ 1 acc)) ] ; add to the accumulator and recurse
            [else (iter (cdr l) n acc)]
            )
      )    
    (list (cons #\A (iter seq #\A 0))
          (cons #\C (iter seq #\C 0))
          (cons #\G (iter seq #\G 0))
          (cons #\T (iter seq #\T 0)))
    
    )
  )

(nucleotide-count "")
(nucleotide-count "G")
(nucleotide-count "AAAA")
(nucleotide-count "GATTACA")
(nucleotide-count "XXXX")
