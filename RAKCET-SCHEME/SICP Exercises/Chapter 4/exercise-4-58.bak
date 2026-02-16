#lang sicp

; Imperative
; How to do it
; Step by step
; square each 

; Declarative
; What is it?
; Describe it


; Normal programming languages
; the flow goes from input -> output

; Logic programing langauge (prolog)
; you describe what's true (the rules)
; and the systme tries to figure out all of the possibilities
; eg mostly filtering and gray out all of the possibilities

; Exercise 4.55

; give simple queries that retreive the following information from the data base

;1. all people supervised by Ben Bitdiddle
;2. the name & jobs of all people in the accounting division
;3. the names and addresses of all people who live in slumerville

;answer
;1. (supervisor ?x (Bitdiddle Ben))
;2. (job ?x (accounting . ?type))
;3. (address ?x (Slmmerville . ?type) )

; ======================

; exercise 4.56

; formulate compound queries that retreive the following informatino

;a. the names of all people who are supervised by Ben Bitdiddle, together with their addresses
;b. all people whose salary is less than ben bitdiddle's together with their salary and ben bitdidle's salary
;c. all people who are supervised by someone who is not in the computer division, together with the supervisor's name and job

; answer
a.
(and (supervisor ?person (Ben Bitdiddle))
     (address ?person ?where))

b.
(and (salary ?person ?amount)
     (salary (Bitdiddle Ben) ?ben-amount)
     (lisp-value < ?amount ?ben-amount))

c. (and (supervisor ?name ?supervisor)
        (not (job ?supervisor (computer . ?type))))

; ======================

; Sample Database
(address (Hacker Alyssa P) (Cambridge (Mass Ave) 78))
(job (Hacker Alyssa P) (computer programmer))
(salary (Hacker Alyssa P) 40000)
(supervisor (Hacker Alyssa P) (Bitdiddle Ben))
(and (salary ?person ?amount) (lisp-value > ?amount 30000))
(can-do-job (computer wizard) (computer programmer))

(supervisor ?x ?x)
(job (Bitdiddle Ben) (computer wizard))

; A rule is a template for generating new facts based on existing ones
; (rule conclusion body)

; exercise 4.57
; person 1 can replace person 2 if either:
; a) person 1 does the same job as person 2
; b) or someone who does person 1's job can also do person 2's job,
; and if person 1 and person 2 are not the same person
; give query that find the following using this rule

; a. all people who can replace Cy D. Fecy
; b. all people who can replace someone who is being paid more than they are, together with the two salaries

; answer:
; part aPerson1 Person2 -> ???
(rule (can-replace ?person1 ?person2)
      (and (or (and (job ?person1 ?job)
                    (job ?person2 ?job))
               (and (job ?person1 ?job1)
                    (job? ?person2 ?job2)
                    (can-do-job ?job1 ?job2)
                    )
               )
           (not (same ?person1 ?person2))
           )
      
      )
(can-replace ?someone (Cy D. Fect))


; part b
(rule (can-replace.v2 ?person1 ?person2)
      (and (can-replace ?person1 ?person2)
           (salary ?person1 ?amount1)
           (salary ?person2 ?amount2)
           (lisp-value > ?amount2 ?amount1) )


      )
(can-replace ?someone-being-replaced ?someone-replacing)
