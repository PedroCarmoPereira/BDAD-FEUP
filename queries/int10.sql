.mode columns
.headers on
.nullvalue NULL

SELECT staffID, nome
FROM Staff
WHERE staffID in
    (SELECT staff
    FROM StaffDoCurso, Curso
    WHERE StaffDoCurso.curso = Curso.codigo
    AND Curso.nome = 'Mestrado Integrado em Engenharia Informatica e Computacao');
