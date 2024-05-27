--ingredients: id, nume
--dishes: id, greutate, valoare

--ospatari: id, nume,
--bucatari:id, nume
--mese: id, nr locuri,

--comanda: id, ospatarid, bucatarid, masaid
--comandaPreparate: id, comandaid, dishid

--ingredientsDishes: id, IngredientId, DishId

create table Ingrediente(
	IngredientId int primary key,
	IngredientNume varchar(50)
);

create table Preparate(
	PreparatId int primary key,
	PreparatGreutate smallint,
	PreparatValoare int
);

create table IngredientePreparate(
	IngredientPreparatId int primary key,
	IngredientId int foreign key references Ingrediente(IngredientId),
	PreparatId int foreign key references Preparate(PreparatId)
);

create table Ospatari(
	OspatarId int primary key,
	OspatarNume varchar(50)
);

create table Bucatari(
	BucatarId int primary key,
	BucatarNume varchar(50)
);

create table Mese(
	MasaId int primary key,
	MasaLocuri smallint
);

create table Comenzi(
	ComandaId int primary key,
	OspatarId int foreign key references Ospatari(OspatarId),
	BucatarId int foreign key references Bucatari(BucatarId),
	MasaId int foreign key references Mese(MasaId)
);

create table PreparateComanda(
	PreparateComandaId int primary key,
	ComandaId int foreign key references Comenzi(ComandaId),
	PreparatId int foreign key references Preparate(PreparatId)
);

-- Insert sample data into Ingrediente
INSERT INTO Ingrediente (IngredientId, IngredientNume) VALUES
(1, 'Tomato'),
(2, 'Cheese'),
(3, 'Basil'),
(4, 'Chicken'),
(5, 'Garlic');

-- Insert sample data into Preparate
INSERT INTO Preparate (PreparatId, PreparatGreutate, PreparatValoare) VALUES
(1, 250, 30),
(2, 300, 45),
(3, 200, 25);

-- Insert sample data into IngredientePreparate
INSERT INTO IngredientePreparate (IngredientPreparatId, IngredientId, PreparatId) VALUES
(1, 1, 1),
(2, 2, 1),
(3, 3, 1),
(4, 4, 2),
(5, 5, 2),
(6, 1, 3);

-- Insert sample data into Ospatari
INSERT INTO Ospatari (OspatarId, OspatarNume) VALUES
(1, 'John'),
(2, 'Mary'),
(3, 'Alex');

-- Insert sample data into Bucatari
INSERT INTO Bucatari (BucatarId, BucatarNume) VALUES
(1, 'Chef A'),
(2, 'Chef B'),
(3, 'Chef C');

-- Insert sample data into Mese
INSERT INTO Mese (MasaId, MasaLocuri) VALUES
(1, 4),
(2, 2),
(3, 6);

-- Insert sample data into Comenzi
INSERT INTO Comenzi (ComandaId, OspatarId, BucatarId, MasaId) VALUES
(1, 1, 1, 1),
(2, 2, 2, 2),
(3, 3, 3, 3);

-- Insert sample data into PreparateComanda
INSERT INTO PreparateComanda (PreparateComandaId, ComandaId, PreparatId) VALUES
(1, 1, 1),
(2, 1, 2),
(3, 2, 1),
(4, 2, 3),
(5, 3, 2);
