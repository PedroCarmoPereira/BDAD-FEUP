.mode columns
.headers on
.nullvalue NULL

SELECT avg(F.valor), N.nome
FROM Frequencia F, Nucleo N
WHERE F.estudante in (SELECT estudante FROM EstudanteNucleo WHERE N.nucleoID = EstudanteNucleo.nucleo)
GROUP BY N.nome
UNION
SELECT avg(F.valor), 'Nenhum Nucleo'
FROM Frequencia F
WHERE F.estudante not in (SELECT estudante FROM EstudanteNucleo WHERE F.estudante = EstudanteNucleo.estudante);