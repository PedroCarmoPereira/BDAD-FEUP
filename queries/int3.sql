.mode columns
.headers on
.nullvalue NULL

SELECT E.nome, F.valor
FROM Estudante E, Frequencia F
WHERE E.estudanteID in (
  SELECT S.estudanteID
  FROM Estudante S, Curso C
  WHERE C.nome = 'Mestrado Integrado em Engenharia Informatica e Computacao' AND C.codigo = S.curso) --Curso pode variar
AND E.estudanteID = F.estudante AND F.valor > 13	--Valor minimo de F.valor pode variar entre [0,20]
ORDER BY F.valor DESC;
