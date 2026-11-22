#lang racket/base

;; An empty remainder returns the count. Otherwise count its first element
;; and continue with the rest without descending into sublists.
(define (my-length lst)
  (let my-count ([remaining lst] [count 0])
    (if (null? remaining)
        count
        (my-count (cdr remaining) (+ count 1)))))
