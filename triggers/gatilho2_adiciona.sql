CREATE TRIGGER DiretorToCC
AFTER INSERT ON Curso
FOR EACH ROW
BEGIN
  INSERT INTO ComissaoCientifica VALUES (New.codigo, New.diretor);
END;