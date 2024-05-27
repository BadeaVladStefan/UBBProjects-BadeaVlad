--pacienti: Id, nume, telefon
--Medici: Id, Nume
--Asistente: Id, Nume
--proceduri: Id, Valoare

--fise: Id, PacientId
--FisaProceduri: FiseId, ProceduraId, MedicId, AsistentaId


create table Pacienti(
	PacientId int primary key,
	PacientNume varchar(50),
	PacientTelefon varchar(50)
);

create table Medici(
	MedicId int primary key,
	MedicNume varchar(50)
);

create Table Asistente(
	AsistentaId int primary key,
	AsistentaNume varchar(50)
);

create table Proceduri(
	ProceduraId int primary key,
	ProceduraValoare int
);

create table Fise(
	FisaId int primary key,
	PacientId int foreign key references Pacienti(PacientId)
);

create table FisaProceduri(
	FisaProceduraId int primary key,
	ProceduraId int foreign key references Proceduri(ProceduraId),
	FisaId int foreign key references Fise(FisaId),
	MedicId int foreign key references Medici(MedicId),
	AsistentaId int foreign key references Asistente(AsistentaId)
);

INSERT INTO Pacienti (PacientId, PacientNume, PacientTelefon) VALUES
(1, 'Ion Popescu', '0745123456'),
(2, 'Maria Ionescu', '0745987654'),
(3, 'George Vasilescu', '0745567890');

INSERT INTO Medici (MedicId, MedicNume) VALUES
(1, 'Dr. Andrei Georgescu'),
(2, 'Dr. Elena Dumitrescu'),
(3, 'Dr. Mihai Preda');

INSERT INTO Asistente (AsistentaId, AsistentaNume) VALUES
(1, 'Asist. Ana Popa'),
(2, 'Asist. Ioana Marcu'),
(3, 'Asist. Laura Marin');

INSERT INTO Proceduri (ProceduraId, ProceduraValoare) VALUES
(1, 100),
(2, 200),
(3, 300);

INSERT INTO Fise (FisaId, PacientId) VALUES
(1, 1),
(2, 2),
(3, 3);

INSERT INTO FisaProceduri (FisaProceduraId, FisaId, ProceduraId, MedicId, AsistentaId) VALUES
(1, 1, 1, 1, 1),
(2, 1, 2, 2, 2),
(3, 2, 3, 3, 3),
(4, 3, 1, 1, 2),
(5, 3, 2, 2, 3);

