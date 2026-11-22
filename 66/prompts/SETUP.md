# Setup Prompts

## Prompt 1 — SETUP

```text
Set up the repository skeleton for CS F301 Assignment 2 (group 66). Create:\
\- 66/code/, 66/tests/, 66/skills/prolog-dev/, 66/skills/scheme-dev/, 66/prompts/ (use .gitkeep where a folder would otherwise be empty).\
\- 66/prompts/SETUP.md, P1.md, P2.md, S1.md, S2.md, each with a one-line title.\
\- A root .gitignore covering handout/, compiled/, \*.swp, .DS_Store and \_\_pycache\_\_/.\
\- A root README.md with the course title, the group ID, a members table (Venkatanaga Vaishnav Gadamsetty 2024A7PS0026H; Chaitrali Dharmadhikari 2024A7PS0133H) and the repository layout. Leave the "how to run" section as a TODO heading.\
\- A root AGENTS.md containing these working rules for any AI agent in this repository:\
&#x20; 1\. The assignment handout is handout/assignment.pdf (use pdftotext if needed). It is the specification; do not commit it.\
&#x20; 2\. Every request covers exactly one unit of work. Implement only the unit named in the request.\
&#x20; 3\. Follow 66/skills/prolog-dev/SKILL.md for Prolog files and 66/skills/scheme-dev/SKILL.md for Racket files.\
&#x20; 4\. After finishing a unit, run the relevant code or tests and state the result.\
&#x20; 5\. Append the request you received to the matching prompts file (P1.md, P2.md, S1.md, S2.md or SETUP.md) under a heading "## Prompt \<number> — \<unit>", copied exactly as received inside a fenced text block, followed by a single "Result:" line describing the change and the test outcome. Never paraphrase or edit the request text.\
&#x20; 6\. Make exactly one commit per unit containing only the files for that unit plus the prompts file. Use an imperative commit message prefixed with the problem, e.g. "P1: implement clue/2 for clues 1-8". Do not amend, rebase or rewrite history, do not change git config, and do not push.\
Do not write any solution code in this step. Then apply rules 5 and 6 to this request, logging it in SETUP.md.
```

Result: Created the group 66 repository skeleton. Verified all 12 setup files, the verbatim request log, and all five ignore patterns.

## Prompt 2 — Prolog skill

```text
Write 66/skills/prolog-dev/SKILL.md, the Prolog skill file required by Section 2 of the handout. Start with YAML front matter containing name: prolog-dev and a one-sentence description. The body must cover:\
\- Language and version: SWI-Prolog 9.x; allowed libraries lists, apply, yall, aggregate only; no assert/retract, b_setval/nb_setval, initialization directives or halt/0.\
\- Coding conventions: predicate naming, a header comment per predicate giving its mode (+/-) and a one-sentence declarative reading, one clause per numbered clue.\
\- How to run and test: the grader commands (swipl -q -f \<file> -g main -t halt and swipl -q -f \<file> -g "\<goal>" -t halt) and how to run the plunit test files in 66/tests/.\
\- A self-review checklist the assistant must apply before answering (names/arities, output format, strings vs atoms, termination on empty and singleton inputs, no hard-coded answers, no stray output).\
\- Known AI failure modes in Prolog (negation on unbound variables, floating-point division, missing exactness checks on nested division, duplicate solutions, wrong parenthesisation of same-precedence right operands, printing atoms instead of strings, assuming uniqueness without counting).\
Keep it under 80 lines.
```

Result: Added the 51-line Prolog skill. Front matter validation and smoke tests for both grader commands and the plunit command passed on SWI-Prolog 9.2.9.
