.mode columns
.headers on
.nullvalue NULL

SELECT P.nome as Prof, S.nome as Staff, P.dataNasc
FROM Prof P, Staff S
WHERE P.dataNasc = S.dataNasc;
--DIFERENCA?
SELECT P.nome as Prof, S.nome as Staff, P.dataNasc
FROM Prof P JOIN Staff S
ON P.dataNasc = S.dataNasc

-- Ha melhor maneira de fazer esta querry?
SELECT P1.nome as nome1, P2.nome as nome2, P1.dataNasc
FROM Prof P1, Prof P2
WHERE P1.dataNasc = P2.dataNasc AND P1.profID > P2.profID
UNION
SELECT P.nome as nome1, S.nome as nome2, P.dataNasc
FROM Prof P JOIN Staff S
ON P.dataNasc = S.dataNasc
UNION
SELECT S1.nome as nome1, S2.nome as nome2, S1.dataNasc
FROM Staff S1, Staff S2
WHERE S1.dataNasc = S2.dataNasc AND S1.staffID > S2.staffID
UNION
SELECT E1.nome as nome1, E2.nome as nome2, E1.dataNasc
FROM Estudante E1, Estudante E2
WHERE E1.dataNasc = E2.dataNasc AND E1.estudanteID > E2.estudanteID;
