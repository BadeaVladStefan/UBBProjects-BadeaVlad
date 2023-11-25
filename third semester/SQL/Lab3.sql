use [Moto GP]

/*
--VERSION TABLE:
create table versionTable(
	version int
)
--initial value
insert into versionTable values (1)

--PROCEDURE TABLE:
create table proceduresTable(
	fromVersion int,
	toVersion int,
	PRIMARY KEY (fromVersion,toVersion),
	procedureName VARCHAR(100)
)
insert into proceduresTable (fromVersion,toVersion,procedureName) values
(1,2,'modCol_SetWinningYearDriverToBigInt'),
(2,1,'unmodCol_SetWinningYearDriverToInt'),
(2,3,'addCol_AddAgeRiders'),
(3,2,'rmCol_RemoveAgeRiders'),
(3,4,'addDef_AddDefaultConstraintMoneySponsorships'),
(4,3,'rmDef_RemoveDefaultConstraintMoneySponsorships'),
(4,5,'addPK_AddPKToTires'),
(5,4,'dropPK_RemovePKFromTires'),
(5,6,'addCK_AddCandidateKeyToRiders'),
(6,5,'rmCK_RemoveCandidateKeyFromRiders'),
(6,7,'addFK_AddForeignKeyTires'),
(7,6,'rmFK_RemoveForeignKeyTires'),
(7,8,'addTb_AddTableLivery'),
(8,7,'rmTB_RemoveTableLivery');

select * from proceduresTable 
*/


--a.1 MODIFY THE TYPE OF A COLUMN 
--FROM TABLE PreviousDriverChampions set Winning Year To Big int
GO

CREATE OR ALTER PROCEDURE modCol_SetWinningYearDriverToBigInt
AS 
	Alter Table PreviousDriverChampions
	Alter COLUMN WinningYear BIGINT
GO
--a.2 REVERSE OPERATION : INT FROM BIG INT

CREATE OR ALTER PROCEDURE unmodCol_SetWinningYearDriverToInt
AS 
	ALTER TABLE PreviousDriverChampions
	ALTER COLUMN WinningYear INT
GO

--exec modCol_SetWinningYearDriverToBigInt
--exec unmodCol_SetWinningYearDriverToInt

--b.1 ADD COLUMN
-- ADD AGE COLUMN TO RIDERS TABLE

CREATE OR ALTER PROCEDURE addCol_AddAgeRiders
AS 
	ALTER TABLE Riders
		ADD age int
Go
--b.2 Reverse Operation drop age column
CREATE OR ALTER PROCEDURE rmCol_RemoveAgeRiders
AS 
	ALTER TABLE Riders
		DROP COLUMN age
GO

--exec addCol_AddAgeRiders
--SELECT * FROM Riders
--exec rmCol_RemoveAgeRiders

--C.1 ADD DEFAULT CONSTRAINT
--IN THE SPONSORSHIPS TABLE ADD DEFAULT CONSTRAINT FOR MONEY
CREATE OR ALTER PROCEDURE addDef_AddDefaultConstraintMoneySponsorships
AS 
	ALTER TABLE Sponsorships
	ADD CONSTRAINT default_amount
		DEFAULT 1000000 FOR Amount
GO

--C.2 Revers operation drop default constraint
CREATE OR ALTER PROCEDURE rmDef_RemoveDefaultConstraintMoneySponsorships
AS 
	ALTER TABLE Sponsorships
	DROP CONSTRAINT default_amount
GO

--exec addDef_AddDefaultConstraintMoneySponsorships
--exec rmDef_RemoveDefaultConstraintMoneySponsorships

--D.1 ADD PRIMARY KEY
-- ADD PK TO TIRES TABLE
CREATE OR ALTER PROCEDURE addPK_AddPKToTires
AS 
    ALTER TABLE Tires
	ADD CONSTRAINT pk_id PRIMARY KEY (TId)
GO
--D.2 Reverse operation : drop PK
CREATE OR ALTER PROCEDURE dropPK_RemovePKFromTires
AS	
	ALTER TABLE Tires
	DROP CONSTRAINT IF EXISTS pk_id
GO

--SELECT * FROM Tires
--exec addPK_AddPKToTires
--exec dropPK_RemovePKFromTires

go
--E.1 ADD CANDIDATE KEY
--ADD CANDIDATE KEY TO RIDERS
CREATE OR ALTER PROCEDURE addCK_AddCandidateKeyToRiders
AS
	ALTER TABLE Riders
		ADD CONSTRAINT rider_ck UNIQUE (RiderName,Nationality)
GO

--E.2 Reverse operation drop CK
CREATE OR ALTER PROCEDURE rmCK_RemoveCandidateKeyFromRiders
AS	
	ALTER TABLE RIDERS
	DROP CONSTRAINT IF EXISTS rider_ck
GO

--exec addCK_AddCandidateKeyToRiders
--exec rmCK_RemoveCandidateKeyFromRiders

--F.1 ADD A FOREIGN KEY
--adds a foreign key to the tires table
CREATE OR ALTER PROCEDURE addFK_AddForeignKeyTires
AS 
BEGIN
	ALTER TABLE Tires
	ADD CONSTRAINT fk_tires
	FOREIGN KEY (ManufacturerId) REFERENCES Manufacturers(ManufacturerId) ON DELETE CASCADE;
END;
GO

--f.2Removes the fk
CREATE OR ALTER PROCEDURE rmFK_RemoveForeignKeyTires
AS
	ALTER TABLE Tires
		DROP CONSTRAINT IF EXISTS fk_tires
GO
	
--exec addFK_AddForeignKeyTires
--exec rmFK_RemoveForeignKeyTires

--G.1 add  a table
CREATE OR ALTER PROCEDURE addTb_AddTableLivery
AS 
	BEGIN 
	CREATE TABLE Livery(
	LId int PRIMARY KEY ,
	Producer VARCHAR(100),
	MainColor VARCHAR(100),
	);
	End
GO

--G.2 remove a table

CREATE OR ALTER PROCEDURE rmTB_RemoveTableLivery
AS 
	drop table Livery
go

--exec addTb_AddTableLivery
--exec rmTB_RemoveTableLivery

--Procedure used to change version
GO
CREATE OR ALTER PROCEDURE goToVersion(@newVersion int)
AS
	DECLARE @curr int
	DECLARE @procedureName varchar(100)
	SELECT @curr = version FROM versionTable

	IF @newVersion <= 0
		RAISERROR('Invalid version',10,1)

	IF @newVersion > (SELECT MAX(toVersion) FROM proceduresTable)
		RAISERROR('Invalid version',10,1)
	ELSE
	BEGIN
		IF @newVersion = @curr
			PRINT('Already on this version!');
			ELSE
			BEGIN
			IF @curr > @newVersion
			BEGIN
				WHILE @curr > @newVersion
				BEGIN
					SELECT @procedureName = procedureName from proceduresTable
					WHERE fromVersion = @curr AND toVersion = @curr - 1
					PRINT('Now Executing: '+ @procedureName)
					EXEC(@procedureName)
					SET @curr = @curr - 1
				END
			END
			IF @curr < @newVersion
			BEGIN
				WHILE @curr < @newVersion
					BEGIN
						SELECT @procedureName = procedureName FROM proceduresTable
						WHERE fromVersion = @curr AND toVersion = @curr + 1
						PRINT('executing: ' + @procedureName);
						EXEC (@procedureName)
						SET @curr = @curr + 1
					END
			END
		    UPDATE versionTable SET version = @newVersion
		END
	END
GO

exec goToVersion 0
exec goToVersion 1
exec goToVersion 2
exec goToVersion 3
exec goToVersion 4
exec goToVersion 5
exec goToVersion 6
exec goToVersion 7
exec goToVersion 8
exec goToVersion 9