PRAGMA foreign_keys = on;
BEGIN TRANSACTION;

DROP TABLE IF EXISTS AreaTrabalho;
DROP TABLE IF EXISTS Sala;
DROP TABLE IF EXISTS Gabinete;
DROP TABLE IF EXISTS Curso;
DROP TABLE IF EXISTS Estudante;
DROP TABLE IF EXISTS Prof;
DROP TABLE IF EXISTS Staff;
DROP TABLE IF EXISTS StaffAdminSala;
DROP TABLE IF EXISTS AreaCientifica;
DROP TABLE IF EXISTS SubArea;

CREATE TABLE AreaTrabalho (
	nome TEXT PRIMARY KEY
);

CREATE TABLE Sala (
	numero INTEGER PRIMARY KEY,
	numPCs INTEGER
);

CREATE TABLE Staff (
	staffID		INTEGER PRIMARY KEY,
	nome 		TEXT NOT NULL,
	numTele		INTEGER,
	dataNasc	DATE NOT NULL,
	morada		TEXT NOT NULL,
	areaTrab	TEXT NOT NULL,
	nif 		INTEGER UNIQUE,
	--localTrab 	INTEGER NOT NULL,
	FOREIGN KEY (areaTrab) REFERENCES AreaTrabalho(nome)
	--FOREIGN KEY (localTrab) REFERENCES Sala(numero)
);

CREATE TABLE StaffAdminSala (
	salaID		INTEGER PRIMARY KEY,
	staffID		INTEGER,
	FOREIGN KEY (staffID) REFERENCES Staff(staffID),
	FOREIGN KEY (salaID) REFERENCES Sala(numero)
);

CREATE TABLE Gabinete (
	numero  INTEGER PRIMARY KEY
);

CREATE TABLE Curso (
	codigo	INTEGER	PRIMARY KEY,
	nome 	TEXT NOT NULL,
	diretor INTEGER,
	FOREIGN KEY (diretor) REFERENCES Prof(profID)
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
	numTele		INTEGER,
	dataNasc	DATE NOT NULL,
	morada		TEXT NOT NULL,
	nif			INTEGER UNIQUE,
	numGabin	INTEGER,
	FOREIGN KEY (numGabin) REFERENCES Gabinete(numero)
);

CREATE TABLE AreaCientifica (
	areaID		INTEGER PRIMARY KEY,
	nome 		TEXT
);

CREATE TABLE SubArea (
	subID	INTEGER,
	supID	INTEGER,
	PRIMARY KEY (subID, supID),
	FOREIGN KEY (subID) REFERENCES AreaCientifica,
	FOREIGN KEY (supID) REFERENCES AreaCientifica
);



COMMIT TRANSACTION;
PRAGMA foreign_keys = on;