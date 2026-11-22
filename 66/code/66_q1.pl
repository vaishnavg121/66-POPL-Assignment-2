% clue(+N, +Solution) holds when clue N is true in the given ground Solution.

% The friend who prefers the AI project does not work in research and is not Dana.
clue(1, Solution) :-
    member(p(Name, Dept, _, 'AI'), Solution),
    Dept \== research,
    Name \== 'Dana'.

% Alex does not work in development and does not prefer C++.
clue(2, Solution) :-
    member(p('Alex', Dept, Lang, _), Solution),
    Dept \== development,
    Lang \== 'c++'.

% The friend working in the testing department likes Python.
clue(3, Solution) :-
    member(p(_, testing, python, _), Solution).

% Ben prefers web projects and does not work in testing.
clue(4, Solution) :-
    member(p('Ben', Dept, _, web), Solution),
    Dept \== testing.

% The friend whose favorite language is Java works in the design department.
clue(5, Solution) :-
    member(p(_, design, java, _), Solution).

% Carla's project preference is not embedded, and her department is not development.
clue(6, Solution) :-
    member(p('Carla', Dept, _, Project), Solution),
    Project \== embedded,
    Dept \== development.

% Dana's favorite language is not Java, and she works in research or testing.
clue(7, Solution) :-
    member(p('Dana', Dept, Lang, _), Solution),
    Lang \== java,
    ( Dept == research
    ; Dept == testing
    ).

% The friend who prefers data projects works in research and does not use JavaScript.
clue(8, Solution) :-
    member(p(_, research, Lang, data), Solution),
    Lang \== javascript.
