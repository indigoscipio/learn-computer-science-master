;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise-514) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))
; A Lam is one of: 
; – a Symbol
; – (list 'λ (list Symbol) Lam)
; – (list Lam Lam)


;Lam -> Boolan
;Checks if a given x is a variable
(define (is-var? x)
  (symbol? x)
  )
;(is-var? 'g)

;Lam -> Boolean
(define (is-lam? f)
  (and (list? f)
       (equal? (first f) 'λ)
       (= (length (second f)) 1)
       (= (length f) 3) )
  )
(is-lam? (list 'λ (list 'x) 'y))


;Lam -> Boolean
;Checks if a is a function application
(define (is-app? a)
  (and (list? a) (= (length a) 2))
  )


;Lam -> List Symbol
;Extracts a function parameter from a λ expression
(define (λ-para f)
  (first(second f))
  )
;(λ-para (list 'λ '(a b) 'c))

;Lam -> Lam
;Extracts the body from a λ expression
(define (λ-body f)
  (third f)
  )
;(λ-body (list 'λ '(a b) 'c))

; Lam -> Lam
;extracts the function from an application
(define (app-fun a)
  (first a)
  )

; Lam -> Lam
; extracts the argument from an application
(define (app-arg a)
  (second a)
  )

; Lam -> List-of-Symbols
; Finds all lamda parameters in a given expressio n
(define (declarends f) 
  (cond [(is-var? f) '()]
        [(is-lam? f) (cons (λ-para f) (declarends (λ-body f) )  )]
        [(is-app? f) (append (declarends (app-fun f) ) (declarends (app-arg f) )) ]
        )
  ) 
;(declarends '(λ (x) x) )
;(declarends '(λ (x) (λ (y) y) ) )
;(declarends '( (λ (x) x) (λ (y) y) ) )




; Lam -> Lam 
(define (undeclareds le0)
  (local (; Lam [List-of Symbol] -> Lam
          ; accumulator declareds is a list of all λ 
          ; parameters on the path from le0 to le
          (define (undeclareds/a le declareds)
            (cond
              [(is-var? le)
               (if (member? le declareds) le '*undeclared)]
              [(is-lam? le)
               (local ((define para (λ-para le))
                       (define body (λ-body le))
                       (define newd (cons para declareds)))
                 (list 'λ (list para)
                   (undeclareds/a body newd)))]
              [(is-app? le)
               (local ((define fun (app-fun le))
                       (define arg (app-arg le)))
               (list (undeclareds/a fun declareds)
                     (undeclareds/a arg declareds)))])))
    (undeclareds/a le0 '())))
(undeclareds 'a)
(undeclareds '(λ (x) x) )
(undeclareds '( (λ (x) (x x)) (λ (y) (y y)) ))