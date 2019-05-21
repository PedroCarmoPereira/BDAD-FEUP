.mode columns
.headers on
.nullvalue NULL

SELECT P.nome
FROM Prof P
WHERE P.profID not in (
  SELECT S.profID
  FROM Prof S, ComissaoExecutiva E, ComissaoCientifica C, ComissaoAcompanhamento A
  WHERE S.profID = E.prof OR S.profID = C.prof OR S.profID = A.prof);
