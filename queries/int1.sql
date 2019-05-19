.mode columns
.headers on
.nullvalue NULL

SELECT nome, count(*) as numMemb
FROM Lab L JOIN ProfAssocLab P
ON L.labID = P.lab
GROUP BY labID
ORDER BY numMemb DESC;