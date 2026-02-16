#lang sicp

; Exercise 4.64
(rule (outranked-by ?staff-person ?boss)
      (or (supervisor ?staff-person ?boss)
          (and (outranked-by ?middle-manager ?boss)
               (supervisor ?staff-person
                           ?middle-manager))))


(outranked-by (Bitdiddle Ben) ?who)
; why does it go into infinit loop?
; answer:
; apply outranked-by that binds ?staff-peron = (Bitdiddle Ben)
; and ?boss = ?who, the variable we're trying to find
; next, evaluate the "or" clause and inside it
; evaluates (supervisor ?staff-person ?boss)
; this finds any supervisors/boss that supervises Ben Bitdiddle
; the filtering continues -> next the (and ...), and inside it we evaluate
; the recursion (outranked-by ?middle-manager ?boss)
; evaluate the recursion with new binding -> ?staff-person = ?middle-manager, ?boss remains the same
; then the whole thing happen again infinitely



; the issue is that the code somehow switch the ordering of the (and ...) clause
; during the problem the ?middle-manager never gets reduced, it just binds ?staff-person = ?middle-manager infinitely
; in the wrong code above it recurse first without binding the variable for middle-manager
; the correct version should switch the recursion to

(and (supervisor ?staff-person ?middle-manager)
     (outranked-by ?middle-manager ?boss)
     )

; this way it binds the new ?middle-maanger first and reduces the person we're trying to query

; ========================================

; Exercise 4.65
(rule ⟨conclusion⟩ ⟨body⟩)

(rule (wheel ?person)
      (and (supervisor ?middle-manager ?person)
           (supervisor ?x ?middle-manager)))

; answer:
; why (wheel ?who) returns 4 items
; apply wheel with ?person = ?who
; then in the (and...) clause, it first finds all ?middle-managers that is being supervised by ?person (?who)
; then on the 2nd and input -> finds ?x that is being supervised by ?middle managers
; then it filters everything and returns the output

; the rule (wheel) takes a person type/assertion as input
; oliver is listed four times because ?who finds everyone, ?middle-manager, ?person, ?x
; so he has multiple combinations like for example has multiple underlings that supervises someone
; and so he gets outputted for each of those statement that is true, creating duplicates
; in conclusion the rule counts every valid path that proves someone is a wheel
; in olivers case he has multiple middle managers and that middle manager might manage multiple underlings


; ========================================

(rule (append-to-form () ?y ?y) )
(rule (append-to-form (?u . ?v) ?y (?u . ?z))
      (append-to-form ?v ?y ?z))

; Exercise 4.66

; to find the total salaries of all the computer programmers
(sum ?amount (and (job ?x (computer programmer))
                  (salary ?x ?amount)))

; ben's new system has the form
(accumulation-function ⟨variable⟩ ⟨query pattern⟩)

; why doesn't it work
; answer:
; because of the way query system work
; unline regular function its bidirectional and not unidirectional
; in a regular functional programming you can just create a accum where it takes a function (eg higher order function)
; you can't feed a function like sum or average or max
; because it will mess up the pattern matching/unification thing

; =============================================

; Exercise 4.68

; base case: when the original list is empty, return empty
(rule (reverse () ()))

; otherwise, remove the first item from original list and put it in front of the reversed list
(rule (reverse (?first . ?rest) ?reversed-list)
      (and (reverse ?rest ?rev-rest)
           (append-to-form rev-rest (?first) ?reversed-list )
           )
      )
(reverse (1 2 3) ?x) ; should return (3 2 1)
(reverse ?x (1 2 3)) ; should return (3 2 1)

; =============================================

; Exercise 4.69

