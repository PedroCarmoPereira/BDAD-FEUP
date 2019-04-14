import random

def idGen ():
  return str(random.randint (10**(13-1), (10**13)-1))

def telGen ():
  sec = [1, 2, 3, 6]

  return str(9) + str(sec[random.randint (0, 3)]) +str(random.randint (10**(7-1), (10**7)-1))

def nifGen ():
  return str(random.randint(10**(9-1), (10**9)-1))

def stf_dobGen ():
  return "'" + str(random.randint (1960, 1970)) + "-" + str(random.randint(1, 12)) + "-" + str(random.randint(1,31)) + "'"

def prf_dobGen ():
  return "'" + str(random.randint (1950, 1970)) + "-" + str(random.randint(1, 12)) + "-" + str(random.randint(1,31)) + "'"

def std_dobGen ():
  return "'" + str(random.randint (1996, 2000)) + "-" + str(random.randint(1, 12)) + "-" + str(random.randint(1,31)) + "'"

def regGen ():
  rnd = random.randint(0, 9) % 2
  if rnd == 0:
    return "1"
  else:
    return "0"

def valPGen():
  return str(round (random.uniform (10.0,20.0), 2))

def valNGen():
  return str(round (random.uniform (1.0,10.0), 2))

def valGen():
  if regGen() == 1:
    return valNGen()
  else:
    return valPGen()

class Staff:
  def __init__ (self, name, morada):
    self.id = idGen ()
    self.name = name
    self.numTele = telGen ()
    self.dob = stf_dobGen ()
    self.morada = morada
    self.nif = nifGen ()
  
  def toStr (self):
    return "INSERT INTO Staff VALUES (" + self.id + ", " + self.name + ", " + self.numTele + ", " + self.dob + ", " + self.morada + ", " + self.nif + ");\n"

class Gabinete:
    def __init__ (self, num):
      self.num = num

    def toStr (self):
      return "INSERT INTO Gabinete VALUES (" + self.num + ");\n"

class Prof:
  def __init__ (self, name, morada, gab):
    self.id = idGen ()
    self.name = name
    self.numTele = telGen ()
    self.dob = prf_dobGen ()
    self.morada = morada
    self.nif = nifGen ()
    if gab == None:
      self.gab = 'null'
    else:
      self.gab = str (gab.num)

  def toStr (self):
    return "INSERT INTO Prof VALUES (" + self.id + ", " + self.name + ", " + self.numTele + ", " + self.dob + ", " + self.morada + ", " + self.nif + ", " + self.gab + ");\n"

class Curso:
  def __init__ (self, name, prof):
    self.id = idGen ()
    self.name = name
    self.prof = str (prof.id)
  
  def toStr (self):
    return "INSERT INTO Curso VALUES (" + self.id + ", " + self.name + ", " + self.prof + ");\n"

class Leciona:
  def __init__ (self, prof, cur):
    self.prof = str (prof.id)
    self.curso = str (cur.id)

  def toStr (self):
    return "INSERT INTO Leciona VALUES (" + self.prof + ", " + self.curso + ");\n"

class StaffCurso:
  def __init__ (self, stf, cur):
    self.stf = str (stf.id)
    self.cur = str (cur.id)
  
  def toStr (self):
    return "INSERT INTO StaffDoCurso VALUES (" + self.stf + ", " + self.cur + ");\n" 

class Estudante:
  def __init__ (self, name, morada, cur):
    self.id = idGen ()
    self.name = name
    self.numTele = telGen ()
    self.dob = std_dobGen ()
    self.morada = morada
    self.regime = regGen ()
    self.cur = str (cur.id)
  
  def toStr (self):
    return "INSERT INTO Estudante VALUES (" + self.id + ", " + self.name + ", " + self.numTele + ", " + self.dob + ", " + self.morada + ", " + self.regime + ", " + self.cur + ");\n"

class Classificacao:
  def __init__ (self, std, cur):
    self.std = str (std.id)
    self.cur = str (cur.id)
    self.val = valGen ()
  
  def toStr (self):
    return "INSERT INTO Classificacao VALUES (" + self.std + ", " + self.cur + ", " + self.val + ");\n"

class Lab:
  def __init__ (self, name, prof):
    self.id = idGen ()
    self.name = name
    self.prof = str(prof.id)
  
  def toStr (self):
    return "INSERT INTO Lab VALUES (" + self.id + ", " + self.name + ", " + self.prof + ");\n"

class ProfLab:
  def __init__ (self, prof, lab):
    self.prof = str (prof.id)
    self.lab = str (lab.id)
  
  def toStr (self):
    return "INSERT INTO ProfAssocLab VALUES (" + self.prof + ", " + self.lab + ");\n"

class ComissExecutiva:
  def __init__ (self, prf):
    self.prf = []
    self.prf.append (str(prf.id))
  
  def addPrf (self, prf):
    self.prf.append (str(prf.id))
  
  def toStr (self, fp):
    for p in self.prf:
      fp.write("INSERT INTO ComissaoExecutiva VALUES (" + p + ");\n")
      
class ComissaoCientifica:
  def __init__ (self, cur):
    self.cur = str(cur.id)
    self.prf = []

  def addPrf (self, prf):
    self.prf.append (str (prf.id))
  
  def toStr (self, fp):
    for p in self.prf:
      fp.write ("INSERT INTO ComissaoCientifica VALUES (" + self.cur + ", " + p + ");\n")

class ComissaoAcompanhamento:
  def __init__ (self, cur):
    self.cur = str(cur.id)
    self.prf = []
    self.std = []
  
  def addPrf (self, prf):
    self.prf.append (str (prf.id))

  def addStd (self, std):
    self.std.append (str (std.id))

  def toStr (self, fp):
    for p in self.prf:
      fp.write ("INSERT INTO ComissaoAcompanhamento (codigoCurso, profID) VALUES (" + self.cur + ", " + p + ");\n")
    for s in self.std:
      fp.write ("INSERT INTO ComissaoAcompanhamento (codigoCurso, estudanteID) VALUES (" + self.cur + ", " + s + ");\n")     
    
class Nucleo:
  def __init__ (self, nome, sala):
    self.id = idGen ()
    self.nome = nome
    self.sala = sala
  
  def toStr (self):
    return "INSERT INTO Nucleo VALUES(" + self.id + ", " + self.nome + ", " + self.sala + ");\n"

class StdNuc:
  def __init__ (self, std, nuc):
    self.std = str (std.id)
    self.nuc = str (nuc.id)
  
  def toStr (self):
    return "INSERT INTO EstudanteNucleo VALUES(" + self.std + ", " + self.nuc + ");\n"


stf1 = Staff ("'Maria Idalina Gomes Silva'", "'Rua Jardim'")
stf2 = Staff ("'Marisa Isabel Magalhaes Brandao Silva'", "'Rua Armazens'")
stf3 = Staff ("'Pedro Miguel Carvalho da Silva'", "'Rua Oliveirinhas'")
stf4 = Staff ("'Sandra Maria Moura Pinto Pires'", "'Rua Tapada Marinha'")

stf = []
stf.append (stf1)
stf.append (stf2)
stf.append (stf3)
stf.append (stf4)

gab1 = Gabinete ("'I204'")
gab2 = Gabinete ("'I134'")
gab3 = Gabinete ("'I022'")
gab4 = Gabinete ("'I318'")
gab5 = Gabinete ("'I120'")
gab6 = Gabinete ("'I126'")
gab7 = Gabinete ("'I237'")
gab8 = Gabinete ("'I314'")
gab9 = Gabinete ("'I135'")
gab10 = Gabinete ("'I236'")

gab = []
gab.append (gab1)
gab.append (gab2)
gab.append (gab3)
gab.append (gab4)
gab.append (gab5)
gab.append (gab6)
gab.append (gab7)
gab.append (gab8)
gab.append (gab9)
gab.append (gab10)

prf1 = Prof ("'Joao Manuel Paiva Cardoso'", "'Rua Rampa Alta'", gab1)
prf2 = Prof ("'Carlos Manuel Milheiro de Oliveira Pinto Soares'", "'Rua Caminho Cruz'", gab2)
prf3 = Prof ("'Ademar Manuel Teixeira de Aguiar'", "'Rua Comercio'", gab3)
prf4 = Prof ("'Jorge Alves da Silva'", "'Travessa Choupelo'", gab4)
prf5 = Prof ("'Rosaldo José Fernandes Rossetti'", "'Rua Patrao Caramelho'", gab5)
prf6 = Prof ("'João Carlos Pascoal Faria'", "'Rua Parque Gondarim'", gab6)
prf7 = Prof ("'João Paulo de Castro Canas Ferreira'", "'Rua Pescador Bacalhoeiro'", gab7)
prf8 = Prof ("'Jorge Manuel Gomes Barbosa'", "'Rua Cortinhas Fonte'", gab8)
prf9 = Prof ("'Luís Paulo Gonçalves dos Reis'", "'Avenida Doutor Fernando Gomes'", None)
prf10 = Prof ("'Maria Cristina de Carvalho Alves Ribeiro'", "'Rua Nogueiras'", gab9)
prf11 = Prof ("'António José Duarte Araújo'", "'Rua Padua Correia'", gab10)
prf12 = Prof ("'José Manuel de Araújo Baptista Mendonça'", "'Rua Parque Gondarim'", None)

prf = []
prf.append (prf1)
prf.append (prf2)
prf.append (prf3)
prf.append (prf4)
prf.append (prf5)
prf.append (prf6)
prf.append (prf7)
prf.append (prf8)
prf.append (prf9)
prf.append (prf10)
prf.append (prf11)
prf.append (prf12)

cur1 = Curso ("'Mestrado Integrado em Engenharia Informatica e Computacao'", prf6)

lec = []
for p in prf:
  lec.append (Leciona (p, cur1))

stfcur = StaffCurso (stf1, cur1)

std1 = Estudante ("'Simao Pereira Oliveira'", "'Rua Cimo Vila'", cur1)
std2 = Estudante ("'Carlos Eduardo da Nova Duarte'", "'Rua Patrao Caramelho'", cur1)
std3 = Estudante ("'Pedro Maria Passos Ribeiro do Carmo Pereira'", "'Rua Cimo Vila'", cur1)
std4 = Estudante ("'Afonso Soares Mendonça'", "'Rua Luis Sardoeira'", cur1)
std5 = Estudante ("'Moises Pimenta Rocha'", "'Rua Costa'", cur1)
std6 = Estudante ("'Paulo Daniel da Silva Araujo'", "'Rua Cimo Vila'", cur1)
std7 = Estudante ("'Ana Teresa Silva'", "'Rua Nogueiras'", cur1)
std8 = Estudante ("'Andre Miguel Soares'", "'Rua Oliveirinhas'", cur1)
std9 = Estudante ("'Pedro Miguel Braga Lopes Moas'", "'Rua Nogueiras'", cur1)
std10 = Estudante ("'Diogo Peixoto Pereira'", "'Rua Ancora'", cur1)
std11 = Estudante ("'João Paulo Madureira Damas'", "'Rua Muro Bacalhoeiros'", cur1)

std = []
std.append (std1)
std.append (std2)
std.append (std3)
std.append (std4)
std.append (std5)
std.append (std6)
std.append (std7)
std.append (std8)
std.append (std9)
std.append (std10)
std.append (std11)

cla = []
for s in std:
  cla.append (Classificacao(s, cur1))

lb1 = Lab ("'Instituto de Engenharia de Sistemas e Computadores, Tecnologia e Ciencia'", prf12)

prfLab = []
for p in prf:
  prfLab.append (ProfLab (p, lb1))

ce = ComissExecutiva (prf1)
ce.addPrf (prf2)
ce.addPrf (prf3)
ce.addPrf (prf4)
ce.addPrf (prf5)

cf = ComissaoCientifica (cur1)
cf.addPrf (prf6)
cf.addPrf (prf7)
cf.addPrf (prf8)
cf.addPrf (prf9)
cf.addPrf (prf10)

ca = ComissaoAcompanhamento (cur1)
ca.addPrf (prf11)
ca.addPrf (prf6)
ca.addPrf (prf4)
ca.addStd (std10)
ca.addStd (std11)

nuc = Nucleo ("'Nucleo de Informatica da AEFEUP'", "'B315'")

stdNuc = StdNuc (std2, nuc)

fp = open ("povoar.sql", "w+")

fp.write ("PRAGMA foreign_keys = on;\n")

fp.write ("\n--STAFF\n")
for s in stf:
  fp.write (s.toStr())

fp.write ("\n--GABINETE\n")
for g in gab:
  fp.write (g.toStr())

fp.write ("\n--PROF\n")
for p in prf:
  fp.write (p.toStr())

fp.write ("\n--CURSO\n")
fp.write (cur1.toStr())

fp.write ("\n--LECIONA\n")
for l in lec:
  fp.write (l.toStr())

fp.write ("\n--STAFF_DO_CURSO\n")
fp.write (stfcur.toStr())

fp.write ("\n--ESTUDANTE\n")
for e in std:
  fp.write (e.toStr())

fp.write ("\n--CLASSIFICACAO\n")
for c in cla:
  fp.write (c.toStr())

fp.write ("\n--LAB\n")
fp.write (lb1.toStr())

fp.write ("\n--PROF_ASSOC_LAB\n")
for p in prfLab:
  fp.write (p.toStr())

fp.write ("\n--COMISSAO_EXECUTIVA\n")
ce.toStr (fp)

fp.write ("\n--COMISSAO_CIENTIFICA\n")
cf.toStr (fp)

fp.write ("\n--COMISSAO_ACOMPANHAMENTO\n")
ca.toStr (fp)

fp.write ("\n--NUCLEO\n")
fp.write (nuc.toStr())

fp.write ("\n--ESTUDANTE_NUCLEO\n")
fp.write (stdNuc.toStr())

fp.close()
