.mode columns
.headers on
.nullvalue NULL

SELECT * FROM Frequencia;

INSERT INTO Estudante VALUES (1122334455667, 'Fernando Pessoa', 913141662, '10-02-1998',  'Rua do Mar', 2683216217156);

SELECT * FROM Frequencia WHERE Frequencia.estudante = 1122334455667;
