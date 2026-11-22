---
name: scheme-dev
description: Develop and test the Scheme solutions for CS F301 Assignment 2 using the handout's Racket whitelist and grading conventions.
---

# Scheme development

## Language and constraints

- Use Racket 8.x. Start every solution file with `#lang racket/base` and follow it with definitions only. Keep the module free of top-level calls and silent on load.

### Allowed built-ins

- `define`, `lambda`, `let`, `let*`, `letrec`, named `let`, `if`, `cond` (with `else`), `and`, `or`, `not`, `begin`, and `quote` (written `'`).
- `cons`, `car`, `cdr`, `list`, and every composition of `car` and `cdr` up to four levels, such as `cadr`, `cddr`, `caddr`, `cdddr`, `cadddr`, and `cddddr`.
- `null?`, `pair?`, `eq?`, `assq`, and `assoc`.
- `+`, `-`, `*`, `<`, `>`, `<=`, `>=`, `=`, `max`, `display`, and `newline`.
- `read` is allowed only in S2.

### Forbidden in solution files

- All other built-ins, including `set!` and related mutation forms, vectors, hash tables, strings, and `do` and `for` loops.
- `length`, `append`, `reverse`, `map`, `filter`, `member`, `memq`, `list-ref`, `list-tail`, `displayln`, `equal?`, `zero?`, `provide`, and `require`.

## Coding conventions

- Preserve the required function names. Use `kebab-case` and prefix your own helpers with `my-`.
- Give every function a comment with its recursive reading, covering the base case and how smaller inputs produce the result.
- Pass all state through arguments. Use tail recursion where it is natural.

## Run and test

Run `racket <file>` from the repository root with the solution path. It must print nothing.

In `66/tests/`, use a test-only harness to load and call the unexported solution functions. The example below calls S1's `print-inorder`.

```racket
#lang racket/base
(require rackunit racket/port racket/runtime-path)
(define-runtime-path solution "../code/66_q3.rkt")

(module+ test
  (dynamic-require solution #f)
  (define print-inorder (eval 'print-inorder (module->namespace solution)))
  (check-equal? (with-output-to-string (lambda () (print-inorder '())))
                "()\n"))
```

Run `raco test "66/tests/<test-file>.rkt"` with the test file's name. For S2's `print-insert-result`, use `with-input-from-string` in the harness to supply `x`, `lst`, and `n` in that order.

## Self-review before answering

- [ ] Scan the solution for whitelist violations, including `read` in S1.
- [ ] For each printing call, check the specified line count and verify exactly one complete list per line, each ending in a newline.
- [ ] Test empty trees, empty top-level lists, and empty nested lists where applicable.
- [ ] Check that S1 visits the left subtree before the right subtree.
- [ ] Check that S2 bases each decision on the original number of immediate elements, including for the top-level list.
- [ ] Test S2 at nesting depth 100 and with lists 10,000 elements wide.

## Common AI failure modes

- **Sneaking in forbidden built-ins.** Scan helpers and edge-case branches as well as the main functions.
- **Quadratic append-based accumulation.** Avoid repeatedly copying a growing prefix. Build with `cons` and use a single pass to restore order if needed.
- **Measuring length after insertion.** Use each original list's length for its insertion decision.
- **Skipping the top-level or empty lists.** Apply the same eligibility rule to both.
- **Printing elements individually.** Pass the complete list to `display` and follow it with `newline`.
