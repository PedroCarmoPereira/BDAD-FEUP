SELECT * FROM ComissaoCientifica;

INSERT INTO Curso VALUES (1122334455667, 'Mestrado Multimedia', 1351682894642);

SELECT * FROM Curso WHERE Curso.codigo = 1122334455667;
SELECT * FROM ComissaoCientifica C WHERE C.curso = 1122334455667;
