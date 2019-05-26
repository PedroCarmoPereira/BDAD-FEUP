.mode columns
.headers on
.nullvalue NULL

SELECT * FROM Lab;
SELECT * FROM ProfAssocLab;

INSERT INTO Lab VALUES (1122334455667, 'Laboratorio de Base de Dados', 3165960962473);

SELECT * FROM Lab WHERE Lab.labID = 1122334455667;
SELECT * FROM ProfAssocLab WHERE ProfAssocLab.lab = 1122334455667;
