.mode columns
.headers on
.nullvalue NULL

SELECT E.estudanteID AS 'Estudantes de todos os Núcleos'
FROM Estudante E
WHERE (SELECT count(N.nucleo) FROM EstudanteNucleo N WHERE (N.estudante = E.estudanteID)) = (SELECT count(nucleoID) FROM Nucleo);