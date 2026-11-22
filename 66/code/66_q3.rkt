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
