.mode columns
.headers on
.nullvalue NULL


SELECT avg(valor)
FROM Frequencia
WHERE Frequencia.estudante in
    (SELECT estudanteID 
    FROM Estudante, Curso 
    WHERE Estudante.curso = Curso.codigo
    AND Curso.nome ='Mestrado Integrado em Engenharia Informatica e Computacao');