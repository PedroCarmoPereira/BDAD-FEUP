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
	staffID     INTEGER PRIMARY KEY,
	nome        TEXT NOT NULL,
	telemovel	  INTEGER NOT NULL CHECK (length (telemovel) = 9),
	dataNasc    DATE NOT NULL,
	morada      TEXT NOT NULL,
	nif         INTEGER UNIQUE NOT NULL CHECK (length (nif) = 9)
);

CREATE TABLE Estudante (
	estudanteID	  INTEGER PRIMARY KEY,
	nome 		      TEXT NOT NULL,
	telemovel		  INTEGER UNIQUE NOT NULL CHECK (length(telemovel) = 9),
	dataNasc	    DATE NOT NULL,
	morada		    TEXT NOT NULL,
	curso	        INTEGER,
	FOREIGN KEY (curso) REFERENCES Curso(codigo) ON DELETE SET NULL
);

CREATE TABLE Prof (
	profID      INTEGER PRIMARY KEY,
	nome        TEXT NOT NULL,
	telemovel   INTEGER UNIQUE NOT NULL CHECK (length (telemovel) = 9),
	dataNasc    DATE NOT NULL,
	morada      TEXT NOT NULL,
	nif         INTEGER UNIQUE CHECK (length (nif) = 9),
	numGabin    INTEGER,
	FOREIGN KEY (numGabin) REFERENCES Gabinete(numero) ON DELETE SET NULL
);

CREATE TABLE Gabinete (
	numero  Text PRIMARY KEY CHECK (length (numero) = 4)
);

CREATE TABLE Curso (
	codigo    INTEGER	PRIMARY KEY,
	nome      TEXT NOT NULL,
	diretor   INTEGER,
	FOREIGN KEY (diretor) REFERENCES Prof(profID) ON DELETE SET NULL
);

CREATE TABLE StaffDoCurso (
	staff       INTEGER PRIMARY KEY,
	curso   INTEGER,
	FOREIGN KEY (curso) REFERENCES Curso(codigo) ON DELETE CASCADE,
	FOREIGN KEY (staff) REFERENCES Staff(staffID) ON DELETE CASCADE
);

CREATE TABLE Leciona  (
	prof        INTEGER,
	curso   INTEGER,
	PRIMARY KEY (prof, curso),
	FOREIGN KEY (prof) REFERENCES Prof(profID) ON DELETE CASCADE,
	FOREIGN KEY (curso) REFERENCES Curso(codigo) ON DELETE CASCADE
);

CREATE TABLE Frequencia (
	estudante     INTEGER NOT NULL,
	curso         INTEGER NOT NULL,
  valor         REAL DEFAULT (0) CHECK (valor >= 0 and valor <= 20),
  regimeTotal   BIT NOT NULL,
	PRIMARY KEY (estudante, curso),
	FOREIGN KEY (estudante) REFERENCES Estudante(estudanteID) ON DELETE CASCADE,
	FOREIGN KEY (curso) REFERENCES Curso(codigo) ON DELETE CASCADE
);

CREATE TABLE Lab (
	labID          INTEGER UNIQUE,
	nome           Text Not NULL,
	coordenador    INTEGER,
	PRIMARY KEY (labID, coordenador),
	FOREIGN KEY (coordenador) REFERENCES Prof(profID) ON DELETE SET NULL
);

CREATE TABLE ProfAssocLab (
	prof  INTEGER,
	lab   INTEGER,
	PRIMARY KEY (prof, lab),
	FOREIGN KEY (prof) REFERENCES Prof(profID) ON DELETE CASCADE,
	FOREIGN KEY (lab) REFERENCES Lab(labID) ON DELETE CASCADE
);

CREATE TABLE ComissaoExecutiva (
	prof  INTEGER PRIMARY KEY,
	FOREIGN KEY (prof) REFERENCES Prof(profID) ON DELETE CASCADE
);

CREATE TABLE ComissaoCientifica (
	curso   INTEGER,
	prof    INTEGER,
	PRIMARY KEY (curso, prof),
	FOREIGN KEY (curso) REFERENCES Curso(codigo) ON DELETE CASCADE,
  FOREIGN KEY (prof) REFERENCES Prof(profID) ON DELETE SET NULL
);

CREATE TABLE ComissaoAcompanhamento (
	curso       INTEGER,
	estudante   INTEGER,
	prof        INTEGER,
	PRIMARY KEY (curso, estudante, prof),
	FOREIGN KEY (curso) REFERENCES Curso(codigo) ON DELETE CASCADE,
	FOREIGN KEY (estudante) REFERENCES Estudante(estudanteID) ON DELETE SET NULL,
	FOREIGN KEY (prof) REFERENCES Prof(profID) ON DELETE SET NULL
);

CREATE TABLE Nucleo (
	nucleoID  INTEGER PRIMARY KEY,
	nome      Text UNIQUE NOT NULL,
	sala      Text UNIQUE
);

CREATE TABLE EstudanteNucleo (
	estudante   INTEGER,
	nucleo      INTEGER,
	PRIMARY KEY (estudante, nucleo),
	FOREIGN KEY (estudante) REFERENCES Estudante(estudanteID) ON DELETE CASCADE,
	FOREIGN KEY (nucleo) REFERENCES Nucleo(nucleoID) ON DELETE CASCADE
);

COMMIT TRANSACTION;
PRAGMA foreign_keys = on;
