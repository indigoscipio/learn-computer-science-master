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


; =============================

; Exercise 4.58
; define a rule that says a person is "big shot"
; in a division if the person works in the division but
; does not have a supervisor who works in the division


;answer:
(rule (big-shot ?person ?division)
      ; aperson is a big shot if
      ; they work in the division
      (and (job ?person (?divison . ?rest1) )
           ; and they do not have a supervisor who also works in that same division
           (not (and (supervisor ?person ?boss)
                     (job ?boss ?division . ?rest2))
                )

           )
      )

; =============================

; Exercise 4.59

(meeting accounting (Monday 9am))
(meeting administration (Monday 10am))
(meeting computer (Wednesday 3pm))
(meeting administration (Friday 1pm))

 (meeting whole-company (Wednesday 4pm))
(meeting <division> <day-and-time>)

;a. ben wants to query the data base fo all meetings that ocur that day
; what query should he use?

(meeting ?division (Friday . ?rest) )

; b. alyssa's rule: a persons meetings include
; all whole-company meetings + all meetings of that person's division
(rule (meeting-time ?person ?day-and-time)
      (or (meeting whole-company (?day-and-time . ?rest1))
          (and (job ?person (?division . rest2))
               (meeting ?division ?day-and-time))
           )
      )


; c. alyssas query
(meeting-time (Alyssa P.Hacker) (Monday 1pm))

; =============================

; Exercise 4.59

(lives-near ?person (Hacker Alyssa P))
(lives-near ?person-1 ?person-2)

(lives-near (Hacker Alyssa P) (Fect Cy D))
(lives-near (Fect Cy D) (Hacker Alyssa P))

(rule (lives-near ?person-1 ?person-2)
      (and (address ?person-1 (?town . ?rest-1))
           (address ?person-2 (?town . ?rest-2))
           (not (same ?person-1 ?person-2))
           (not (same ?person-2 ?person-1))
           ))

; answer:
; I think this is because of the (and) clasue, in the lives near code it compares
; and returns if person 1 and person 2 lives in the same town
; so in this case alysa and cy lives in the same town
; since alyssa passes the 1st (address ?person-1) and cy passes the (address ?person2)
; a way to lives-near that returns unique name:

; we define a new rule/conditionals if within all of the result, person 1and person2 is equal/repeating
; eg alysa is person1 and cy person2 and cy person1 or alyssa person2
; and then we filter the duplicate. I'm not sure how the code wil look though, maybe add the fourth not?


(rule (lives-near ?person-1 ?person-2)
      (and (address ?person-1 (?town . ?rest-1))
           (address ?person-2 (?town . ?rest-2))
           (not (same ?person-1 ?person-2))
           (not (same ?person-2 ?person-1))
           ))


; =============================

; Exercise 4.59
