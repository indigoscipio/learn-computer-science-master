#lang racket

; TRIES
; O(k) where k is the length of the word

; OP: TRIE SEARCH
; two purpose:
; 1. is the string a complete word?
; 2. is the string at least a word prefix (begining of a word)?

; HOW IT WORKS
; 1. set root = curr node
; 2. does curr node has a child for the curr char of search str?
; 3. if not -> done/done. if so, make that child the curr node,
; then go back to step #2
; 4. if string ends, it means we've found the search string.

; A Trie is a struct children end-word?
; where children is a hash and end-word is a boolean
(struct trie-node (children end-word?) #:transparent)

; A Word is a list of characters

(define node-t (trie-node (hash) #t)) ; 't' has no children, is a word
(define node-b (trie-node (hash) #t)) ; 'b' has no children, is a word
(define node-a  (trie-node (hash #\t node-t #\b node-b) 
                           #f)) ; 'a' points to 't' and 'b', not a word itself
(define node-c  (trie-node (hash #\a node-a) 
                           #f)) ; 'c' points to 'a'
(define sample-trie  (trie-node (hash #\c node-c) 
                                #f)) ; root points to 'c'
(define sample-target-word '(#\c #\a #\t))

; Trie (listof Characters) -> Trie or False
(define (search target-word trie)
  (cond [(null? target-word) trie ] ;found the search string
        [else (let* ((curr-char (car target-word))
                     (curr-child (trie-node-children trie))
                     (next-node (hash-ref curr-child curr-char #f)))

                (if next-node
                    ; children found - update curr node to child
                    (search (cdr target-word) next-node)
                    ; no children found/search failed
                    #f
                    )
                )]
        )
  
  )
(search sample-target-word sample-trie)

; ========================================

; INSERT
; does the word already exist in trie? if not, insert it.
; 1. initialize curr node/root node
; 2. iterate through search str
; 3. check if curr node has a child with that char as key?
; 4. if so, update curr node to become that child node,
; and repeat to step 2
; if not, create child node and update curr node to be new node
; repeat step 2
; when target word is empty add */finished to last node to indicate
; word is finished

; (listof Character) Trie -> Trie
(define (insert target-word trie)
  (cond [(null? target-word) (trie-node (trie-node-children trie) #t)]
        [else (let* ((curr-char (car target-word))
                    (curr-child (trie-node-children trie))
                    (next-node (hash-ref curr-child curr-char #f))
                    (updated-child (insert (cdr target-word)
                                           (or next-node
                                               (trie-node (hash) #f))))
                    )

                ; rebuild the trie on each recursion
                (trie-node (hash-set curr-child curr-char updated-child)
                           (trie-node-end-word? trie)
                           )
                
                )]
        )
  )
(insert '(#\c #\a #\n) sample-trie)
