.mode columns
.headers on
.nullvalue NULL

SELECT P1.nome, P2.nome, P1.numGabin as gabinete
FROM Prof P1, Prof P2
WHERE P1.numGabin = P2.numGabin AND P1.profID > P2.profID;
