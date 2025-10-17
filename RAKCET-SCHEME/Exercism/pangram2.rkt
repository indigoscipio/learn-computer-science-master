#lang racket

(define alphabets
  "abcdefghijklmnopqrstuvwxyz"
  )

; a Phrase is  a string
; String -> Boolean
(define (pangram? phrase)
  (let ((phrase-seq (string->list (string-downcase phrase)))
        (alphabets-seq (string->list alphabets))
        )

    ; iteration 1, using accumulator
    ; acucmulate holds a list of seen letters: '(a b c ...)
    (define (iter l acc)
      (cond [(empty? l) (reverse acc)]
            [(member (car l) alphabets-seq) (if (member (car l) acc)
                                                (iter (cdr l) acc) ;ignore
                                                (iter (cdr l) (cons (car l) acc)) ;add it                                                
                                                ) ] ; add it to accumulator
            [else (iter (cdr l) acc)] ;skip it
            )
      )

    (let ((result     (foldr (lambda (char acc) (if (member char alphabets-seq)
                                                    (if (member char acc)
                                                        acc ;ignore it 
                                                        (cons char acc) ; add it
                                                        )
                                                    acc ;skip it
                                                    )) '() phrase-seq) ))
      (= (length result) 26)
      )

    ; build the unique list using foldr

    
    )
  )
(pangram? "five boxing wizards jump quickly at it")
(pangram? "the quick brown fox jumps over the lazy dog")
