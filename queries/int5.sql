.mode columns
.headers on
.nullvalue NULL

SELECT valor AS 'classificação 10% pop. estudantil'
FROM Frequencia
ORDER BY valor ASC
LIMIT 1
OFFSET ( SELECT COUNT(*) FROM Frequencia) * 9/10 - 1;