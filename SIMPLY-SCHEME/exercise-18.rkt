#lang simply-scheme

; TREES

(define (leaf? bt) (null? bt))
(define (make-node d c)
  (cons d c)
  )
(define (datum node)
  (car node))
(define (children node)
  (cdr node))

(define (leaf datum)
  (make-node datum '()))
(define (cities name–list)
  (map leaf name–list))

(define (count–leaves tree)
  (if (leaf? tree)
      1
      (count–leaves–in–forest (children tree))))

(define (count–leaves–in–forest forest)
  (if (null? forest)
      0
      (+ (count–leaves (car forest))
         (count–leaves–in–forest (cdr forest)))))

; coun leaves -> counts downward motion ⬇️
; count forest -> counts across motion ➡️



(define world-tree
  (make-node
  'world
  (list (make-node
         'italy
         (cities '(venezia riomaggiore firenze roma)))
        (make-node
         '(united states)
         (list (make-node
                'california
                (cities '(berkeley (san francisco) gilroy)))
               (make-node
                'massachusetts
                (cities '(cambridge amherst sudbury)))
               (make-node 'ohio (cities '(kent)))))
        (make-node 'zimbabwe (cities '(harare hwange)))
        (make-node 'china
                   (cities '(beijing shanghai guangzhou suzhou)))
        (make-node
         '(great britain)
         (list
          (make-node 'england (cities '(liverpool)))
          (make-node 'scotland
                     (cities '(edinburgh glasgow (gretna green))))
          (make-node 'wales (cities '(abergavenny)))))
         (make-node
          'australia
          (list
           (make-node 'victoria (cities '(melbourne)))
           (make-node '(new south wales) (cities '(sydney)))
           (make-node 'queensland
                      (cities '(cairns (port douglas))))))
         (make-node 'honduras (cities '(tegucigalpa))))))

(define (in-tree? place tree)
  (or (equal? place (datum tree))
      (in–forest? place (children tree))))
(define (in–forest? place forest)
  (if (null? forest)
      #f
      (or (in-tree? place (car forest))
          (in–forest? place (cdr forest)))))
(in-tree? 'abergavenny world-tree)



#|
EXERCISE
18.1 What does
((SAN FRANCISCO))
mean in the printout of world–tree? Why two sets of parentheses?

answer: san fransico hs a few cities: berkely and gilroy and san fransiso is a children

|#

; =============================================

#|
18.2 Suppose we change the definition of the tree constructor so that it uses list instead of cons:
(define (make–node datum children)
  (list datum children))
How do we have to change the selectors so that everything still works?

answer:
to extract the datm, stil use car
to extract the children, use cadr instead of cdr

|#

; =======================================

#|
18.3 Write depth, a procedure that takes a tree as argument and returns the largest number of nodes connected 
through parent-child links. That is, a leaf node has depth 1; a tree in which all the children of the root node are leaves 
has depth 2. Our world tree has depth 4 (because the longest path from the root to a leaf is, for example, world, 
country, state, city).

answer:
|#

(define (depth tree)
  (cond [(leaf? tree) 1]
        [else (+ 1 (depth-in-forest (children tree)))]
        )
  )

(define (depth-in-forest forest)
  (cond [(empty? forest) 0] ;no more subtree
        [else (max (depth (car forest))
                   (depth-in-forest (cdr forest)))]
        )
  )
(depth world-tree)


; ================================================

#|
18.4 Write count–nodes, a procedure that takes a tree as argument and returns the total number of nodes in the tree. 
(Earlier we counted the number of leaf nodes.)
|#

(define (count-nodes tree)
  (cond [(leaf? tree) 0]
        []
        )
  )

(define (count-forest forest)
  0
  ; if its a 
  )

(count-nodes world-tree)