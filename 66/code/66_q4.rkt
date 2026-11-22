#lang racket/base

;; An empty remainder returns the count. Otherwise count its first element
;; and continue with the rest without descending into sublists.
(define (my-length lst)
  (let my-count ([remaining lst] [count 0])
    (if (null? remaining)
        count
        (my-count (cdr remaining) (+ count 1)))))

;; An empty list returns the accumulator. Otherwise move the first value to
;; the front of the accumulator and continue with the rest.
(define (my-reverse values reversed)
  (if (null? values)
      reversed
      (my-reverse (cdr values) (cons (car values) reversed))))

;; Apply f to the first remaining element and collect its result, then recur.
;; When no elements remain, restore the original order.
(define (my-map f lst)
  (let my-collect ([remaining lst] [mapped-reversed '()])
    (if (null? remaining)
        (my-reverse mapped-reversed '())
        (my-collect (cdr remaining)
                    (cons (f (car remaining)) mapped-reversed)))))

;; Use the recursive inserter to prepend x to each list shorter than n.
(define (insert-if-short x lst n)
  ((make-inserter x (lambda (size) (< size n))) lst))

;; Return a function that inserts x where the predicate accepts a list's length.
(define (make-inserter x len-ok?)
  ;; Measure this list before recursing into its elements. An empty list has
  ;; no elements to update and is eligible when len-ok? accepts 0.
  (define (my-insert lst)
    (let* ([insert? (len-ok? (my-length lst))]
           [updated
            (my-map (lambda (element)
                      (if (or (null? element) (pair? element))
                          (my-insert element)
                          element))
                    lst)])
      (if insert?
          (cons x updated)
          updated)))
  my-insert)

;; Read the three inputs in order and print the recursively transformed list.
(define (print-insert-result)
  (let* ([x (read)]
         [lst (read)]
         [n (read)])
    (display (insert-if-short x lst n))
    (newline)))
