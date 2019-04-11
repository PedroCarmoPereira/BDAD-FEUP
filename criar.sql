PRAGMA foreign_keys = on;
BEGIN TRANSACTION;

DROP TABLE IF EXISTS Gabinete;
DROP TABLE IF EXISTS Curso;
DROP TABLE IF EXISTS Estudante;
DROP TABLE IF EXISTS Prof;
DROP TABLE IF EXISTS Staff;
DROP TABLE IF EXISTS StaffDoCurso;
DROP TABLE IF EXISTS Leciona;
DROP TABLE IF EXISTS Classificacao;
DROP TABLE IF EXISTS Lab;
DROP TABLE IF EXISTS ProfAssocLab;
DROP TABLE IF EXISTS ComissaoExecutiva;
DROP TABLE IF EXISTS ComissaoCientifica;
DROP TABLE IF EXISTS ComissaoAcompanhamento;
DROP TABLE IF EXISTS Nucleo;
DROP TABLE IF EXISTS EstudanteNucleo;


CREATE TABLE Staff (
	staffID		INTEGER PRIMARY KEY,
	nome 		TEXT NOT NULL,
	numTele		INTEGER NOT NULL,
	dataNasc	DATE NOT NULL,
	morada		TEXT NOT NULL,
	nif 		INTEGER UNIQUE,
);

CREATE TABLE Gabinete (
	numero  Text PRIMARY KEY
);

CREATE TABLE Curso (
	codigo	INTEGER	PRIMARY KEY,
	nome 	TEXT NOT NULL,
	diretor INTEGER,
	FOREIGN KEY (diretor) REFERENCES Prof(profID)
);

CREATE TABLE StaffDoCurso (
	staffID	INTEGER PRIMARY KEY,
	codigo	INTEGER,
	FOREIGN KEY (codigo) REFERENCES Curso(codigo),
	FOREIGN KEY (staffID) REFERENCES Staff(staffID)
);

CREATE TABLE Estudante (
	estudanteID	INTEGER PRIMARY KEY,
	nome 		TEXT NOT NULL,
	numTele		INTEGER,
	dataNasc	DATE NOT NULL,
	morada		TEXT NOT NULL,
	regimeTotal	BIT NOT NULL,
	codigoCurso	INTEGER,
	FOREIGN KEY (codigoCurso) REFERENCES Curso(codigo)
);

CREATE TABLE Prof (
	profID		INTEGER PRIMARY KEY,
	nome		TEXT NOT NULL,
	numTele		INTEGER NOT NULL,
	dataNasc	DATE NOT NULL,
	morada		TEXT NOT NULL,
	nif		INTEGER UNIQUE,
	numGabin	INTEGER,
	FOREIGN KEY (numGabin) REFERENCES Gabinete(numero)
);

CREATE TABLE Leciona  (
	profID INTEGER,
	codigoCurso INTEGER,
	PRIMARY KEY (profID, codigoCurso),
	FOREIGN KEY (profID) REFERENCES Prof(profID),
	FOREIGN KEY (codigoCurso) REFERENCES Curso(codigo)
);

CREATE TABLE Classificacao (
	estudanteID  INTEGER,
	codigoCurso INTEGER,
  valor INTEGER,
	PRIMARY KEY (estudanteID, codigoCurso),
	FOREIGN KEY (estudanteID) REFERENCES Estudante(estudanteID),
	FOREIGN KEY (codigoCurso) REFERENCES Curso(codigo)
);

CREATE TABLE Lab (
	labID INTEGER,
	nome Text Not NULL,
	profID INTEGER,
	PRIMARY KEY (labID, profID),
	FOREIGN KEY (profID) REFERENCES Prof(profID)
);

CREATE TABLE ProfAssocLab (
	profID INTEGER,
	labID INTEGER,
	PRIMARY KEY (profID, labID),
	FOREIGN KEY (profID) REFERENCES ProfAssocLab(profID),
	FOREIGN KEY (labID) REFERENCES Lab(labID)
);

CREATE TABLE ComissaoExecutiva (
	profID INTEGER PRIMARY KEY,
	FOREIGN KEY (profID) REFERENCES Prof(profID)
);

CREATE TABLE ComissaoCientifica (
	codigoCurso INTEGER,
	profID INTEGER,
	PRIMARY KEY (codigoCurso, profID),
	FOREIGN KEY (codigoCurso) REFERENCES Curso(codigo)
);

CREATE TABLE ComissaoAcompanhamento (
	codigoCurso INTEGER,
	estudanteID INTEGER,
	profID INTEGER,
	PRIMARY KEY (codigoCurso, estudanteID, profID),
	FOREIGN KEY (codigoCurso) REFERENCES Curso(codigo),
	FOREIGN KEY (estudanteID) REFERENCES Estudante(estudanteID),
	FOREIGN KEY (profID) REFERENCES Prof(profID)
);

CREATE TABLE Nucleo (
	nucleoID INTEGER PRIMARY KEY,
	nome Text NOT NULL,
	sala Text UNIQUE,
	FOREIGN KEY (nucleoID) REFERENCES Nucleo(nucleoID),
);

CREATE TABLE EstudanteNucleo (
	estudanteID INTEGER,
	nucleoID INTEGER,
	PRIMARY KEY (estudanteID, nucleoID),
	FOREIGN KEY (estudanteID) REFERENCES Estudante(estudanteID),
	FOREIGN KEY (nucleoID) REFERENCES Nucleo(nucleoID)
);

COMMIT TRANSACTION;
PRAGMA foreign_keys = on;
