---
name: prolog-dev
description: Develop and test the Prolog solutions for CS F301 Assignment 2 using the handout's SWI-Prolog constraints and grading conventions.
---

# Prolog development

## Language and constraints

- Use SWI-Prolog 9.x. In solution files, the only allowed libraries are `lists`, `apply`, `yall`, and `aggregate`.
- Do not use `assert` or `retract` (including variants), `b_setval/2`, `nb_setval/2`, initialization directives, or `halt/0` in solution files.

## Coding conventions

- Keep predicate names and arities specified by the handout. Use descriptive `lower_snake_case` for helpers.
- Give each predicate a header comment with `+` for inputs and `-` for outputs, followed by one sentence stating when the relation holds. For example, `% select_item(+Items, -Item) holds when Item is a member of Items.`
- Give each numbered clue its own `clue/2` clause, with the clue number as the first argument.

## Run and test

Run these commands from the repository root. Replace `<file>` with the solution path and `<goal>` with the predicate call.

```sh
swipl -q -f <file> -g main -t halt
swipl -q -f <file> -g "<goal>" -t halt
```

For each plunit test file, substitute its name below. The test file loads its corresponding solution from `../code/` and may use `library(plunit)`.

```sh
swipl -q -f none -s "66/tests/<test-file>.pl" -g run_tests -t halt
```

## Self-review before answering

- [ ] Check predicate names, arities, and argument order against the handout.
- [ ] Compare output with the required format, including line order, spaces, and punctuation.
- [ ] Verify text types with `string/1` or `atom/1` as appropriate. P2 equations are strings, and P1 person names are atoms.
- [ ] Check that predicates accepting lists terminate and behave as specified on empty and singleton inputs.
- [ ] Check that results follow from the inputs and constraints without hard-coded answers.
- [ ] Check that loading the file is silent and that calls produce only the specified output.

## Common AI failure modes

- **Negation on unbound variables.** Bind the values being tested before using `\+/1` so the goal checks the intended candidate.
- **Floating-point division.** Use integer division (`//`) after verifying the divisor is nonzero and the remainder is zero.
- **Missing exactness checks in nested division.** Apply the divisor and remainder checks at every division node in the expression tree.
- **Duplicate solutions.** Check that each solution has a single derivation. Collect results before deduplicating so repeated derivations are visible.
- **Incorrect parentheses on right operands.** For P2, parenthesize a right child operator of equal or lower precedence and a left child operator of lower precedence. Leave single numbers bare.
- **Printing atoms in place of returning strings.** Construct the P2 equation as an SWI-Prolog string and return it through the output argument.
- **Assuming uniqueness after finding one solution.** Count all solutions for the requested clue set before claiming uniqueness.
