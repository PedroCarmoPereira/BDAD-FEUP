.mode columns
.headers on
.nullvalue NULL

SELECT P.nome
FROM Prof P, ComissaoCientifica C1, ComissaoCientifica C2
WHERE P.profID = C1.prof AND C1.prof = C2.prof AND C1.curso > C2.curso;