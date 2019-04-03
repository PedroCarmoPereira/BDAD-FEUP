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
DROP TABLE IF EXISTS ProfArea;
DROP TABLE IF EXISTS StaffDoCurso;
DROP TABLE IF EXISTS CursoArea;
DROP TABLE IF EXISTS Leciona;
DROP TABLE IF EXISTS Classificacao;
DROP TABLE IF EXISTS Lab;
DROP TABLE IF EXISTS LabArea;
DROP TABLE IF EXISTS ProfAssocLab;
DROP TABLE IF EXISTS ComissaoExecutiva;
DROP TABLE IF EXISTS ComissaoCientifica;
DROP TABLE IF EXISTS ComissaoAcompanhamento;
DROP TABLE IF EXISTS Nucleo;
DROP TABLE IF EXISTS EstudanteNucleo;
DROP TABLE IF EXISTS Evento;
DROP TABLE IF EXISTS ProfOrganiza;
DROP TABLE IF EXISTS NucleoOrganiza;

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

CREATE TABLE AreaTrabalho (
	nome TEXT PRIMARY KEY
);

CREATE TABLE StaffAdminSala (
	salaID		INTEGER PRIMARY KEY,
	staffID		INTEGER,
	FOREIGN KEY (staffID) REFERENCES Staff(staffID),
	FOREIGN KEY (salaID) REFERENCES Sala(numero)
);

CREATE TABLE Sala (
	numero INTEGER PRIMARY KEY,
	numPCs INTEGER
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

CREATE TABLE StaffDoCurso (
	codigo	INTEGER PRIMARY KEY,
	staffID	INTEGER,
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

CREATE TABLE ProfArea (
	profID 	INTEGER,
	areaID	INTEGER,
	PRIMARY KEY (profID, areaID),
	FOREIGN KEY (profID) REFERENCES Prof(profID),
	FOREIGN KEY (areaID) REFERENCES AreaCientifica(areaID)
);

CREATE TABLE CursoArea (
	codigo 	INTEGER	PRIMARY KEY,
	areaID	INTEGER,
	FOREIGN KEY (codigo) REFERENCES Curso(codigo),
	FOREIGN KEY (areaID) REFERENCES AreaCientifica(areaID)
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

CREATE TABLE LabArea (
	labID INTEGER,
	areaID INTEGER,
	PRIMARY KEY (labID, areaID),
	FOREIGN KEY (labID) REFERENCES Lab(labID),
	FOREIGN KEY (areaID) REFERENCES AreaCientifica(areaID)
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
	salaID INTEGER,
	FOREIGN KEY (nucleoID) REFERENCES Nucleo(nucleoID),
	FOREIGN KEY (salaID) REFERENCES Sala(salaID)
);

CREATE TABLE EstudanteNucleo (
	estudanteID INTEGER,
	nucleoID INTEGER,
	PRIMARY KEY (estudanteID, nucleoID),
	FOREIGN KEY (estudanteID) REFERENCES Estudante(estudanteID),
	FOREIGN KEY (nucleoID) REFERENCES Nucleo(nucleoID)
);

CREATE TABLE Evento (
	eventoID INTEGER,
	nome Text NOT NULL,
	dataInit DATE NOT NULL,
	dataFim DATE NOT NULL,
	salaID INTEGER,
	PRIMARY KEY (eventoID, salaID),
	FOREIGN KEY (salaID) REFERENCES Sala(salaID)
);

CREATE TABLE ProfOrganiza (
	profID INTEGER,
	eventoID INTEGER,
	PRIMARY KEY (profID, eventoID),
	FOREIGN KEY (profID) REFERENCES Prof(profID),
	FOREIGN KEY (eventoID) REFERENCES Evento(eventoID)
);

CREATE TABLE NucleoOrganiza (
	eventoID INTEGER,
	nucleoID INTEGER,
	PRIMARY KEY (eventoID, nucleoID),
	FOREIGN KEY (eventoID) REFERENCES Evento(eventoID),
	FOREIGN KEY (nucleoID) REFERENCES Nucleo(nucleoID)
);

COMMIT TRANSACTION;
PRAGMA foreign_keys = on;
