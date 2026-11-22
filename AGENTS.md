# Working rules for AI agents

1. The assignment handout is `handout/assignment.pdf` (use `pdftotext` if needed). It is the specification; do not commit it.
2. Every request covers exactly one unit of work. Implement only the unit named in the request.
3. Follow `66/skills/prolog-dev/SKILL.md` for Prolog files and `66/skills/scheme-dev/SKILL.md` for Racket files.
4. After finishing a unit, run the relevant code or tests and state the result.
5. Append the request you received to the matching prompts file (`P1.md`, `P2.md`, `S1.md`, `S2.md` or `SETUP.md`) under a heading `## Prompt <number> — <unit>`, copied exactly as received inside a fenced text block, followed by a single `Result:` line describing the change and the test outcome. Never paraphrase or edit the request text.
6. Make exactly one commit per unit containing only the files for that unit plus the prompts file. Use an imperative commit message prefixed with the problem, e.g. `P1: implement clue/2 for clues 1-8`. Do not amend, rebase or rewrite history, do not change git config, and do not push.
