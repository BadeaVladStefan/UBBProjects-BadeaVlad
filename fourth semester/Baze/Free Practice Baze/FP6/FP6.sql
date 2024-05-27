--cages: id, serie, numar
--animals: id, nume, descriere, data de nsatere, cusca id (FK), specie id(FK)
--species: id, nume latin, nume romanesc, clasa
--janitors: id, nume, prenume, adresa
--CagesJanitors:id, cageId,JanitorId
--Class: id, name

create table Janitors(
	JanitorId int primary key,
	JanitorSurname varchar(50),
	JanitorFirstName varchar(50),
	JanitorAddress varchar(150)
);

create table Classes(
	ClassId int primary key,
	ClassName varchar(50)
);

create table Cages(
	CageId int primary key,
	JanitorId int foreign key references Janitors(JanitorId),
	CageSeries varchar(2),
	CageNumber int
);

create table Species(
	SpeciesId int primary key,
	ClassId int foreign key references Classes(ClassId),
	SpeciesLatinName varchar(50),
	SpeciesRomanianName varchar(50)
);

create table Animals(
	AnimalId int primary key,
	CageId int foreign key references Cages(CageId),
	SpeciesId int foreign key references Species(SpeciesId),
	AnimalName varchar(50),
	AnimalDescription varchar(250),
	AnimalDateOfBirth date
);

INSERT INTO Classes (ClassId, ClassName) VALUES
(1, 'Mammalia'),
(2, 'Aves'),
(3, 'Reptilia'),
(4, 'Amphibia'),
(5, 'Pisces');

INSERT INTO Species (SpeciesId, ClassId, SpeciesLatinName, SpeciesRomanianName) VALUES
(1, 1, 'Panthera leo', 'Leu'),
(2, 1, 'Elephas maximus', 'Elefant asiatic'),
(3, 2, 'Aquila chrysaetos', 'Vultur auriu'),
(4, 2, 'Sturnus vulgaris', 'Graur'),
(5, 3, 'Chelonia mydas', 'Țestoasă verde'),
(6, 3, 'Crocodylus niloticus', 'Crocodil de Nil'),
(7, 4, 'Rana temporaria', 'Broască de pădure'),
(8, 4, 'Bufo bufo', 'Broască râioasă'),
(9, 5, 'Salmo salar', 'Somon atlantic'),
(10, 5, 'Cyprinus carpio', 'Crap');
