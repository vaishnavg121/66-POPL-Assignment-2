#lang racket/base

;; An empty tree leaves the accumulator unchanged. A node adds its left subtree
;; and its own value before passing the accumulator to its right subtree.
(define (my-inorder-reversed tree values-reversed)
  (if (null? tree)
      values-reversed
      (let ([after-left (my-inorder-reversed (cadr tree) values-reversed)])
        (my-inorder-reversed (caddr tree) (cons (car tree) after-left)))))

;; An empty list returns the accumulator. Otherwise move the first value to
;; the front of the accumulator and continue with the rest.
(define (my-reverse values reversed)
  (if (null? values)
      reversed
      (my-reverse (cdr values) (cons (car values) reversed))))

;; Collect values recursively in inorder, then print the list on one line.
(define (print-inorder tree)
  (display (my-reverse (my-inorder-reversed tree '()) '()))
  (newline))

;; An empty tree leaves the accumulator unchanged. A node adds its own value
;; before visiting the left subtree, then passes the result to the right subtree.
(define (my-preorder-reversed tree values-reversed)
  (if (null? tree)
      values-reversed
      (let ([after-left (my-preorder-reversed (cadr tree)
                                             (cons (car tree) values-reversed))])
        (my-preorder-reversed (caddr tree) after-left))))

;; An empty tree leaves the accumulator unchanged. A node visits the left
;; and right subtrees in order before adding its own value.
(define (my-postorder-reversed tree values-reversed)
  (if (null? tree)
      values-reversed
      (let* ([after-left (my-postorder-reversed (cadr tree) values-reversed)]
             [after-right (my-postorder-reversed (caddr tree) after-left)])
        (cons (car tree) after-right))))

;; Print the recursively collected inorder, preorder, and postorder lists.
(define (print-all-traversals tree)
  (print-inorder tree)
  (display (my-reverse (my-preorder-reversed tree '()) '()))
  (newline)
  (display (my-reverse (my-postorder-reversed tree '()) '()))
  (newline))

;; An empty tree gives (0 0) and a leaf gives (1 1). For any other node,
;; visit each subtree once, left first, then combine their heights and counts.
(define (my-height-and-leaves tree)
  (cond
    [(null? tree) '(0 0)]
    [(and (null? (cadr tree)) (null? (caddr tree))) '(1 1)]
    [else
     (let* ([left (my-height-and-leaves (cadr tree))]
            [right (my-height-and-leaves (caddr tree))])
       (list (+ 1 (max (car left) (car right)))
             (+ (cadr left) (cadr right))))]))

;; Print the recursively computed height and leaf count as one list.
(define (print-height-and-leaves tree)
  (display (my-height-and-leaves tree))
  (newline))
