#lang sicp

(define nouns '(noun student professor cat class))
(define verbs '(verb studies lectures eats sleeps))
(define articles '(article the a))
(define prepositions '(prep for to in by with))

(define (require p) (if (not p) (amb)))

; Sentence: noun phrase + verb phrase
(define (parse-sentence)
  (list 'sentence
        (parse-noun-phrase)
        (parse-word verbs)))

; Noun: article + noun / noun + prepositiional
(define (parse-noun-phrase)
  (define (maybe-extend noun-phrase)
    (amb noun-phrase
         (maybe-extend
          (list 'noun-phrase
                noun-phrase
                (parse-prepositional-phrase)))))
  (maybe-extend (parse-simple-noun-phrase)))

; Verb: verb/verb+prepositinoal
(define (parse-verb-phrase)
  (define (maybe-extend verb-phrase)
    (amb verb-phrase
         (maybe-extend
          (list 'verb-phrase
                verb-phrase
                (parse-prepositional-phrase)))))
  (maybe-extend (parse-word verbs)))

(define (parse-prepositional-phrase)
  (list 'prep-phrase
        (parse-word prepositions)
        (parse-noun-phrase)))

(define (parse-word word-list)
  (require (not (null? *unparsed*)))
  (require (memq (car *unparsed*) (cdr word-list)))
  (let ((found-word (car *unparsed*)))
    (set! *unparsed* (cdr *unparsed*))
    (list (car word-list) found-word))
  )

(define *unparsed* '())
(define (parse input)
  (set! *unparsed* input)
  (let ((sent (parse-sentence)))
    (require (null? *unparsed*)) sent))


(define (parse-simple-noun-phrase)
  (list 'simple-noun-phrase
        (parse-word articles)
        (parse-word nouns)))

(parse '(the student with the cat sleeps in the class))

; ========================================
; Exercise 4.45
; “The professor lectures to the student in the class with the cat.”

; Meaning 1: lectures to [the student in the class [with the cat]]
; Meaning 2: lectures to [the student [in [the class with the cat]]]
; Meaning 3: lectures [to the student] [in the class with the cat]
; Meaning 4: lectures [to the student in the class] [with the cat]
; Meaning 5: lectures [to the student] [in the class] [with the cat]

; ========================================
; Exercise 4.46
; The parser depends on left to right operand evaluation
; it builds the parse step by step in word order
; changing the order would mess up the whole / produce incorrect parse

; ========================================
; Exercise 4.47
; The parser depends on left to right operand evaluation
; it builds the parse step by step in word order
; changing the order would mess up the whole / produce incorrect parse

; ========================================
; Exercise 4.48
