# P1.b — Solution count (Group 66)

## Original clues

```prolog
?- count_solutions([1,2,3,4,5,6,7,8], N).
N = 3.
```

The eight original clues allow three distinct assignments, so they do not determine a unique solution. Each cell lists the department, favorite language, and preferred project.

| Friend | Solution 1 | Solution 2 | Solution 3 |
| --- | --- | --- | --- |
| Alex | design, java, AI | design, java, embedded | testing, python, embedded |
| Ben | development, javascript, web | development, javascript, web | development, javascript, web |
| Carla | research, c++, data | testing, python, AI | design, java, AI |
| Dana | testing, python, embedded | research, c++, data | research, c++, data |

## Clue 9

The friend working in the testing department prefers the AI project.

Only solution 2 satisfies clue 9. Carla works in testing and prefers AI. In solutions 1 and 3, the person in testing prefers embedded.

```prolog
?- count_solutions([1,2,3,4,5,6,7,8,9], N).
N = 1.
```
