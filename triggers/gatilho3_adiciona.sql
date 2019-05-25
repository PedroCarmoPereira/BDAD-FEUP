CREATE TRIGGER EstInCA
AFTER INSERT ON Estudante
FOR EACH ROW
BEGIN
  INSERT INTO Frequencia (estudante, curso) VALUES (New.estudanteID, New.curso);
END;