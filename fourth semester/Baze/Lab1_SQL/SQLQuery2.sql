create database [Moto GP];

CREATE TABLE Manufacturers(
	ManufacturerId INT PRIMARY KEY,
	ManufacturerName VARCHAR(50)
);

select * from Manufacturers

CREATE TABLE Teams(
	TeamId INT PRIMARY KEY,
	TeamName VARCHAR(75),
	Principal VARCHAR(50),
	BikeManufacturerId INT,
	FOREIGN KEY (BikeManufacturerId) references Manufacturers (ManufacturerId)
);

CREATE TABLE Riders(
  RiderId INT PRIMARY KEY,
  RiderName VARCHAR(75),
  Nationality VARCHAR(50),
  TeamId INT,
  FOREIGN KEY (TeamId) REFERENCES Teams(TeamId)
);

CREATE TABLE Races(
	RaceId INT PRIMARY KEY,
	RaceName VARCHAR(75),
	RaceDate DATE,
	Location VARCHAR(100)
);

CREATE TABLE RiderRaceParticipation(
	ParticipationId INT PRIMARY KEY,
	RaceId INT,
	RiderId INT,
	FOREIGN KEY (RaceId) REFERENCES Races(RaceId),
	FOREIGN KEY (RiderId) REFERENCES Riders(RiderId)
);

CREATE TABLE PreviousDriverChampions(
	PreviousDriverChampionId INT PRIMARY KEY,
	DriverName VARCHAR(100),
	WinningYear INT
);

CREATE TABLE PrevoiusConstructorChampions(
	PrevoiusConstructorChampionsId INT PRIMARY KEY,
	TeamName VARCHAR(100),
	WinningYear INT
);
CREATE TABLE Sponsors(
	SponsorId INT PRIMARY KEY,
	SponsorName VARCHAR(75),
	Amount DECIMAL(10,2)
); 

CREATE TABLE Sponsorships(
	SponsorshipId INT PRIMARY KEY,
	TeamId INT,
	SponsorId INT,
	StartDate DATE,
	EndDate DATE,
	Amount MONEY,
	FOREIGN KEY (TeamId) REFERENCES Teams(TeamId),
	FOREIGN KEY (SponsorId) REFERENCES Sponsors(SponsorId)
) 

CREATE TABLE CurrentYearDriverStandings(
	StandingId INT PRIMARY KEY,
	RiderId INT,
    Points INT,
    Position INT,
	FOREIGN KEY (RiderId) REFERENCES Riders(RiderId)
);

ALTER TABLE Manufacturers
ALTER COLUMN ManufacturerName VARCHAR(50) NOT NULL;

ALTER TABLE Teams
ALTER COLUMN TeamName VARCHAR(75) NOT NULL;

ALTER TABLE Teams
ALTER COLUMN Principal VARCHAR(50) NOT NULL;

ALTER TABLE Riders
ALTER COLUMN RiderName VARCHAR(75) NOT NULL;
ALTER TABLE Riders
ALTER COLUMN Nationality VARCHAR(50) NOT NULL;

ALTER TABLE Races
ALTER COLUMN RaceName VARCHAR(75) NOT NULL;
ALTER TABLE Races
ALTER COLUMN RaceDate DATE NOT NULL;
ALTER TABLE Races
ALTER COLUMN Location VARCHAR(100) NOT NULL;

ALTER TABLE Teams
ADD CONSTRAINT FK_BikeManufacturer
FOREIGN KEY (BikeManufacturerId) REFERENCES Manufacturers (ManufacturerId)
ON UPDATE CASCADE
ON DELETE SET NULL;

ALTER TABLE Riders
ADD CONSTRAINT FK_TeamId
FOREIGN KEY (TeamId) REFERENCES Teams (TeamId)
ON UPDATE CASCADE
ON DELETE SET NULL;

CREATE TABLE RaceStats (
    StatID INT PRIMARY KEY,
    RaceID INT,
    FastestLap VARCHAR(255),
    AverageSpeed DECIMAL(5, 2),
    FOREIGN KEY (RaceID) REFERENCES Races(RaceID)
);


CREATE TABLE TeamPerformance (
    PerformanceID INT PRIMARY KEY,
    TeamID INT,
    SeasonYear INT,
    PointsEarned INT,
    Wins INT,
    PodiumFinishes INT,
    FOREIGN KEY (TeamID) REFERENCES Teams(TeamID)
);

-- Create Tires table
CREATE TABLE Tires (
    TId INT NOT NULL,
    ProducerName VARCHAR(100),
    Compound VARCHAR(100),
    Width INT,
    ManufacturerId INT,
    FOREIGN KEY (ManufacturerId) REFERENCES Manufacturers(ManufacturerId) ON DELETE NO ACTION
);

-- Update the Tires table insert
INSERT INTO Tires (TId, ManufacturerId, Compound, Width)
VALUES
    (1, 1, 'Soft', 20),         -- Michelin (ManufacturerId 1)
    (2, 2, 'Medium', 21),       -- Bridgestone (ManufacturerId 2)
    (3, 3, 'Hard', 22),         -- Pirelli (ManufacturerId 3)
    (4, 4, 'Soft', 20),         -- Dunlop (ManufacturerId 4)
    (5, 5, 'Medium', 21);       -- Metzeler (ManufacturerId 5)

-- Update the Tires table with producer names
UPDATE Tires
SET ProducerName = 
    CASE 
        WHEN ManufacturerId = 1 THEN 'Michelin'
        WHEN ManufacturerId = 2 THEN 'Bridgestone'
        WHEN ManufacturerId = 3 THEN 'Pirelli'
        WHEN ManufacturerId = 4 THEN 'Dunlop'
        WHEN ManufacturerId = 5 THEN 'Metzeler'
    END;



drop table Tires

ALTER TABLE RiderRaceParticipation
DROP CONSTRAINT PK_RiderRaceParticipation;


ALTER TABLE RiderRaceParticipation
ADD CONSTRAINT PK_RiderRaceParticipation 
PRIMARY KEY (RaceId, RiderId);
	

INSERT INTO Manufacturers (ManufacturerId, ManufacturerName)
VALUES 
    (1, 'Honda'),
    (2, 'Yamaha'),
    (3, 'Ducati'),
    (4, 'Suzuki'),
    (5, 'KTM');

	

INSERT INTO Teams (TeamId, TeamName, Principal, BikeManufacturerId)
VALUES 
    (1, 'Aprilia Racing', 'Massimo Rivola', 4),  
    (2, 'CryptoData RNF', 'Razlan Razali', 2),  
    (3, 'Ducatti Lenovo', 'Luigi Dalligna', 3),  
    (4, 'GasGas Factory', 'Matia Binnoto', 3),  
    (5, 'Gresini', 'Nadia Padovani', 5),  
    (6, 'LCR', 'Lucio Cecchinello', 1),
    (7, 'Monster Energy', 'Hervé Poncharal', 2),
    (8, 'Mooney VR46', 'Valentino Rossi', 3),
    (9, 'Repsol Honda', 'Alberto Puig', 3),
    (10, 'RedBull KTM', 'Pit Beirer', 5);


INSERT INTO Riders (RiderId, RiderName, Nationality, TeamId)
VALUES (101, 'Francesco Bagnaia', 'Italy', 3); 
INSERT INTO Riders (RiderId, RiderName, Nationality, TeamId)
VALUES (102, 'Johann Zarco', 'France', 7);
INSERT INTO Riders (RiderId, RiderName, Nationality, TeamId)
VALUES (103, 'Marc Marquez', 'Spain', 9);
INSERT INTO Riders (RiderId, RiderName, Nationality, TeamId)
VALUES (104, 'Luca Marini', 'Italy', 8);
INSERT INTO Riders (RiderId, RiderName, Nationality, TeamId)
VALUES (105, 'Maverick Viñales', 'Spain', 1);
INSERT INTO Riders (RiderId, RiderName, Nationality, TeamId)
VALUES (106, 'Fabio Quartararo', 'France', 7);
INSERT INTO Riders (RiderId, RiderName, Nationality, TeamId)
VALUES (107, 'Franco Morbidelli', 'Italy', 7);
INSERT INTO Riders (RiderId, RiderName, Nationality, TeamId)
VALUES (108, 'Enea Bastianini', 'Italy', 3);
INSERT INTO Riders (RiderId, RiderName, Nationality, TeamId)
VALUES (109, 'Takaaki Nakagami', 'Japan', 6);
INSERT INTO Riders (RiderId, RiderName, Nationality, TeamId)
VALUES (110, 'Brad Binder', 'South Africa', 10);
INSERT INTO Riders (RiderId, RiderName, Nationality, TeamId)
VALUES (111, 'Joan Mir', 'Spain', 9);
INSERT INTO Riders (RiderId, RiderName, Nationality, TeamId)
VALUES (112, 'Aleix Espargaro', 'Spain', 1);
INSERT INTO Riders (RiderId, RiderName, Nationality, TeamId)
VALUES (113, 'Alex Rins', 'Spain', 6);
INSERT INTO Riders (RiderId, RiderName, Nationality, TeamId)
VALUES (114, 'Jack Miller', 'Australia', 10);
INSERT INTO Riders (RiderId, RiderName, Nationality, TeamId)
VALUES (115, 'Pol Espargaro', 'Spain', 4);
INSERT INTO Riders (RiderId, RiderName, Nationality, TeamId)
VALUES (116, 'Fabio Di Giannantonio', 'Italy', 5);
INSERT INTO Riders (RiderId, RiderName, Nationality, TeamId)
VALUES (117, 'Marco Bezzecchi', 'Italy', 8);
INSERT INTO Riders (RiderId, RiderName, Nationality, TeamId)
VALUES (118, 'Alex Marquez', 'Spain', 5);
INSERT INTO Riders (RiderId, RiderName, Nationality, TeamId)
VALUES (119, 'Miguel Oliveira', 'Portugal', 2);
INSERT INTO Riders (RiderId, RiderName, Nationality, TeamId)
VALUES (120, 'Jorge Martin', 'Spain', 4);

INSERT INTO Races (RaceId, RaceName, RaceDate, Location)
VALUES 
    (1, 'Grand Prix of Qatar', '2023-03-05', 'Losail International Circuit, Qatar'),
    (2, 'Grand Prix of Indonesia', '2023-03-19', 'Mandalika International Street Circuit, Indonesia'),
    (3, 'Grand Prix of Argentina', '2023-04-02', 'Termas de Río Hondo, Argentina'),
    (4, 'Grand Prix of the Americas', '2023-04-16', 'Circuit of the Americas, United States'),
    (5, 'Grand Prix of Spain', '2023-04-30', 'Circuito de Jerez, Spain'),
    (6, 'Grand Prix of France', '2023-05-14', 'Bugatti Circuit, Le Mans, France'),
    (7, 'Grand Prix of Italy', '2023-05-28', 'Mugello Circuit, Italy'),
    (8, 'Grand Prix of Catalunya', '2023-06-11', 'Circuit de Barcelona-Catalunya, Spain'),
    (9, 'Grand Prix of Germany', '2023-06-25', 'Sachsenring Circuit, Germany'),
    (10, 'Grand Prix of the Netherlands', '2023-07-02', 'TT Circuit Assen, Netherlands');

INSERT INTO RiderRaceParticipation (ParticipationId, RaceId, RiderId,Position)
VALUES 
    (1, 1, 101,3),
    (2, 1, 102,19),
    (3, 1, 103,1),
    (4, 2, 104,7),
    (5, 2, 105,15);

INSERT INTO PreviousDriverChampions (PreviousDriverChampionId, DriverName, WinningYear)
VALUES 
    (1, 'Valentino Rossi', 2009),
    (2, 'Marc Marquez', 2019),
    (3, 'Casey Stoner', 2011),
    (4, 'Jorge Lorenzo', 2010),
    (5, 'Nicky Hayden', 2006),
    (6, 'Mick Doohan', 1998),
    (7, 'Wayne Rainey', 1992),
    (8, 'Eddie Lawson', 1989),
    (9, 'Kenny Roberts', 1978),
    (10, 'Mike Hailwood', 1966);

INSERT INTO PrevoiusConstructorChampions (PrevoiusConstructorChampionsId, TeamName, WinningYear)
VALUES 
    (1, 'Ducati', 2020),
    (2, 'Yamaha', 2019),
    (3, 'Honda', 2018),
    (4, 'Suzuki', 2020),
    (5, 'KTM', 2020),
    (6, 'Aprilia', 2020),
    (7, 'Kawasaki', 1978),
    (8, 'MV Agusta', 1973),
    (9, 'Norton', 1967),
    (10, 'Benelli', 1970);

INSERT INTO Sponsors (SponsorId, SponsorName, Amount)
VALUES 
    (1, 'Red Bull', 1000000.00),
    (2, 'Monster Energy', 800000.00),
    (3, 'Shell', 500000.00),
    (4, 'Michelin', 750000.00),
    (5, 'DHL', 600000.00),
    (6, 'Tissot', 400000.00),
    (7, 'Pirelli', 700000.00);

INSERT INTO Sponsorships (SponsorshipId, TeamId, SponsorId, StartDate, EndDate, Amount)
VALUES 
    (11, 5, 6, '2023-03-10', '2023-12-31', 700000.00),
    (12, 6, 3, '2023-03-15', '2023-12-31', 800000.00),
    (13, 2, 4, '2023-03-20', '2023-12-31', 900000.00),
    (14, 1, 5, '2023-03-25', '2023-12-31', 600000.00),
    (15, 8, 2, '2023-03-30', '2023-12-31', 500000.00),
    (16, 10, 1, '2023-04-05', '2023-12-31', 400000.00),
    (17, 3, 7, '2023-04-10', '2023-12-31', 300000.00),
    (18, 9, 2, '2023-04-15', '2023-12-31', 800000.00),
    (19, 4, 3, '2023-04-20', '2023-12-31', 900000.00),
    (20, 7, 1, '2023-04-25', '2023-12-31', 1000000.00);

INSERT INTO CurrentYearDriverStandings (StandingId, RiderId, Points, Position)
VALUES 
    (1, 101, 45, 1),
    (2, 103, 37, 2),
    (3, 105, 30, 3),
    (4, 106, 28, 4),
    (5, 111, 26, 5),
    (6, 112, 24, 6),
    (7, 108, 22, 7),
    (8, 104, 20, 8),
    (9, 115, 18, 9),
    (10, 107, 16, 10);

INSERT INTO RaceStats (StatID, RaceID, FastestLap, AverageSpeed)
VALUES 
    (1, 1, 'Francesco Bagnaia', 170.25),
    (2, 2, 'Marc Marquez', 172.45),
    (3, 3, 'Fabio Quartararo', 168.78),
    (4, 4, 'Johann Zarco', 175.12),
    (5, 5, 'Maverick Viñales', 169.55),
    (6, 6, 'Marc Marquez', 170.89),
    (7, 7, 'Johann Zarco', 173.26),
    (8, 8, 'Francesco Bagnaia', 171.32),
    (9, 9, 'Marc Marquez', 172.77),
    (10, 10, 'Francesco Bagnaia', 169.92);

INSERT INTO TeamPerformance (PerformanceID, TeamID, SeasonYear, PointsEarned, Wins, PodiumFinishes)
VALUES 
    (1, 1, 2023, 120, 4, 8),
    (2, 2, 2023, 90, 2, 6),
    (3, 3, 2023, 150, 6, 10),
    (4, 4, 2023, 80, 1, 5),
    (5, 5, 2023, 110, 3, 7);

INSERT INTO TeamPerformance (PerformanceID, TeamID, SeasonYear, PointsEarned, Wins, PodiumFinishes)
VALUES
	(6, 1, 2021, 74, 5, 7),
	(7, 1, 2022 ,50, 2 , 10),
	(8, 2, 2022 ,100 ,10 ,16);
	
	
/* LAB 2 : */

/*
On the relational structure created for the first lab, write SQL statements that:

insert data – for at least 4 tables; at least one statement must violate referential integrity constraints;
update data – for at least 3 tables;
delete data – for at least 2 tables.
*/


INSERT INTO Teams (TeamId, TeamName, Principal, BikeManufacturerId) VALUES 
    (13, 'BMW Racing Team', 'John Doe', 70);  -- Violates referential integrity


INSERT INTO Manufacturers (ManufacturerId, ManufacturerName) VALUES 
    (6, 'BMW'),
    (7, 'Aprilia');

INSERT INTO Teams (TeamId, TeamName, Principal, BikeManufacturerId) VALUES 
    (11, 'Tech3 Racing', 'Hervé Poncharal', 2),
    (12, 'LCR Honda', 'Lucio Cecchinello', 1);

INSERT INTO Riders (RiderId, RiderName, Nationality, TeamId) VALUES 
    (121, 'Cal Crutchlow', 'Great Britain', 12),
    (122, 'Danilo Petrucci', 'Italy', 12);

INSERT INTO Races (RaceId, RaceName, RaceDate, Location) VALUES 
    (11, 'Grand Prix of Japan', '2023-07-16', 'Twin Ring Motegi, Japan'),
    (12, 'Grand Prix of Australia', '2023-10-22', 'Phillip Island, Australia');
INSERT INTO RiderRaceParticipation(ParticipationId,RaceId,RiderId,Position) Values
(6, 2, 101, 3);
INSERT INTO RiderRaceParticipation(ParticipationId,RaceId,RiderId,Position) VALUES
(7, 3, 105, 5);

UPDATE Teams
SET Principal = 'Lin Jarvis'
WHERE TeamName = 'LCR Honda';

UPDATE Riders
SET Nationality = 'United Kingdom'
WHERE RiderId = 121;

UPDATE Sponsorships
SET Amount = Amount * 1.1
WHERE SponsorId = 2;

UPDATE Riders
SET TeamId = 2
WHERE Nationality = 'France' AND TeamId IN (1, 3);

UPDATE TeamPerformance
SET PointsEarned = PointsEarned + 10
WHERE SeasonYear = 2023 AND NOT PointsEarned BETWEEN 90 AND 100;

DELETE FROM Riders
WHERE RiderId = 121;

DELETE FROM Sponsorships
WHERE SponsorshipId = 16;

/*
a. 2 queries with the union operation; use UNION [ALL] and OR;
*/

-- NAMES OF RIDERS FROM SPAIN OR ITALY
SELECT RiderName
FROM Riders
WHERE Nationality='Italy'
UNION ALL
SELECT RiderName
FROM Riders
WHERE Nationality = 'Spain'

-- THE ID OF RIDERS FROM SPAIN OR WITH POINTS > 25
SELECT RiderId
FROM Riders
WHERE Nationality = 'Spain'
   OR RiderId IN (
   SELECT RiderId
   FROM CurrentYearDriverStandings
   WHERE Points > 25
   );


/*
b. 2 queries with the intersection operation; use INTERSECT and IN;
*/

--SELECT THE IDS OF THE RIDERS THAT PARTICIPATED BOTH IN RACE 1 AND RACE 2
SELECT RiderId
FROM RiderRaceParticipation
WHERE RaceId = 1 
INTERSECT
SELECT RiderId
FROM RiderRaceParticipation
WHERE RaceId = 2


--RETRIVES THE ID OF RIDERS WHO PARTICIPATED IN RACE 1 OR RACE 3
SELECT RiderId
FROM RiderRaceParticipation
WHERE RaceId in (1,3)

/*
c. 2 queries with the difference operation; use EXCEPT and NOT IN;
*/

--RETRIVES THE IDS OF RIDERS WHO PARTICIPATED IN RACE 1 BUT NOT IN RACE 2
SELECT RiderId
FROM RiderRaceParticipation
WHERE RaceId = 1
EXCEPT 
SELECT RiderId
FROM RiderRaceParticipation
WHERE RaceId = 2

--SELECT ALL THE RIDERS THAT ARE NOT FROM SPAIN
SELECT R1.RiderName
FROM Riders R1
WHERE R1.RiderId NOT IN (
	SELECT R2.RiderId 
	FROM Riders R2
	WHERE R2.Nationality = 'Spain'
);

/*
d. 4 queries with INNER JOIN, LEFT JOIN, RIGHT JOIN, and FULL JOIN (one query per operator); one query will join at least 3 tables, while another one will join at least two many-to-many relationships;
*/

--RETRIVES RIDERNAME, TEAMNAME, MANUFACTURERNAME FOR EACH RIDER, ALONG WITH THEIR TEAM'S BIKE MANUFACTURER 
--JOINS 3 TABLES
SELECT Riders.RiderName, Teams.TeamName, Manufacturers.ManufacturerName
FROM Riders
INNER JOIN Teams ON Riders.TeamId = Teams.TeamId
INNER JOIN Manufacturers ON Teams.BikeManufacturerId = Manufacturers.ManufacturerId;

-- RETRIEVES RIDER NAME, RACE NAME, POSITION, TEAM NAME, AND SPONSOR NAME
-- 2 MANY-TO-MANY 
SELECT Riders.RiderName, Races.RaceName, RiderRaceParticipation.Position, Teams.TeamName,Sponsors.SponsorName   
FROM Riders
LEFT JOIN RiderRaceParticipation ON Riders.RiderId = RiderRaceParticipation.RiderId
LEFT JOIN Races ON RiderRaceParticipation.RaceId = Races.RaceId
LEFT JOIN Teams ON Riders.TeamId = Teams.TeamId
LEFT JOIN Sponsorships ON Teams.TeamId = Sponsorships.TeamId
LEFT JOIN Sponsors ON Sponsorships.SponsorId = Sponsors.SponsorId;


--RETRIVES THE DRIVERNAME AND TEAMNAME FOR DRIVER AND CONSTRUCTOR CHAMPIONS WHO WON LAST YEAR
SELECT PreviousDriverChampions.DriverName, PrevoiusConstructorChampions.TeamName
FROM PreviousDriverChampions
RIGHT JOIN PrevoiusConstructorChampions ON PreviousDriverChampions.WinningYear = PrevoiusConstructorChampions.WinningYear;

--RETRIVES THE DRIVERNAME AND TEAMNAME FOR ALL CHAMPIONS REGARDLESS OF WHETHER THEY WON IN THE SAME YEAD OR NOT
SELECT Drivers.DriverName, Constructors.TeamName
FROM PreviousDriverChampions AS Drivers
FULL JOIN PrevoiusConstructorChampions AS Constructors ON Drivers.WinningYear = Constructors.WinningYear;


/*
e. 2 queries with the IN operator and a subquery in the WHERE clause; in at least one case, the subquery must include a subquery in its own WHERE clause;
*/


--SUBQUERY TO GET THE TEAMIDS OF TEAMS WITH SPONSORSHIP FROM RED BULL
SELECT TeamId
FROM Sponsorships
WHERE SponsorId = (
    SELECT SponsorId
    FROM Sponsors
    WHERE SponsorName = 'Red Bull'
);

--QUERY TO RETRIVE THE TEAMNAME AND PRINCIPAL FOR TEAMS WITH A RED BULL SPONSORSHIP
SELECT TeamName, Principal
FROM Teams
WHERE TeamId IN (
    SELECT TeamId
    FROM Sponsorships
    WHERE SponsorId = (
        SELECT SponsorId
        FROM Sponsors
        WHERE SponsorName = 'Red Bull'
    )
);


--QUERY TO RETRIVE THE RIDERNAME AND NATIONALITY FOR RIDERS FROM TEAMS SPONSORED BY SHELL
SELECT RiderName, Nationality
FROM Riders
WHERE TeamId IN (
    SELECT TeamId
    FROM Sponsorships
    WHERE SponsorId = (
        SELECT SponsorId
        FROM Sponsors
        WHERE SponsorName = 'Shell'
    )
);


/*
f. 2 queries with the EXISTS operator and a subquery in the WHERE clause;
*/

-- RETRIVES RIDERS WHO PARTICIPATED IN A RACE
SELECT R.RiderName
FROM Riders R
WHERE EXISTS (
    SELECT RP.ParticipationId
    FROM RiderRaceParticipation RP
    WHERE RP.RiderId = R.RiderId
);

-- RETRIVES TEAMS WITH AT LEAST ONE SPONSORSHIP
SELECT T.TeamName
FROM Teams T
WHERE EXISTS (
    SELECT S.SponsorshipId
    FROM Sponsorships S
    WHERE S.TeamId = T.TeamId
);

/*
g. 2 queries with a subquery in the FROM clause;    
*/


--RETRIVES RIDERS WITH POINTS ABOVE AVERAGE
SELECT R.RiderName, CYDS.Points
FROM (
    SELECT RiderId, Points
    FROM CurrentYearDriverStandings
    WHERE Points > (
        SELECT AVG(Points)
        FROM CurrentYearDriverStandings
    )
) CYDS
JOIN Riders R ON CYDS.RiderId = R.RiderId;


--TOTAL SPONSORSHIP AMOUNT FOR EACH TEAM
SELECT T.TeamName, TS.TotalSponsorshipAmount
FROM (
    SELECT TeamId, SUM(Amount) AS TotalSponsorshipAmount
    FROM Sponsorships
    GROUP BY TeamId
) TS
JOIN Teams T ON TS.TeamId = T.TeamId;


/*
h. 4 queries with the GROUP BY clause, 3 of which also contain the HAVING clause; 2 of the latter will also have a subquery in the HAVING clause; use the aggregation operators: COUNT, SUM, AVG, MIN, MAX;
*/

--RETRIVES THE TEAMID AND THE NUMBER OF RIDERS FOR EACH TEAM BIGGER OR EQUAL THEN 3
SELECT TeamId, COUNT(RiderId) AS NumberOfRiders
FROM Riders
GROUP BY TeamId
HAVING COUNT(RiderId) >= 3;

--CALCULATES THE AVERAGE POINTS EARNED BY EACH TEAMS AND RETRIVES THE ONES WITH AN AVERAGE OVER 100, ORDERED BY AVERAGE POINTS
SELECT TeamId, AVG(PointsEarned) AS AvgPoints
FROM TeamPerformance
GROUP BY TeamId
HAVING AVG(PointsEarned) > 100
ORDER BY AvgPoints DESC;


--TEAMS WITH THE MOST WINS IN 2023 COMPARED AGAINS THE AVERAGE NUMBER OF WINS
SELECT TeamId, MAX(Wins) AS MostWins
FROM TeamPerformance
WHERE SeasonYear = 2023
GROUP BY TeamId
HAVING MAX(Wins) > (
    SELECT AVG(Wins)
    FROM TeamPerformance
    WHERE SeasonYear = 2023
);

--FIND THE TEAMS WITH MORE THEN 1.2 THE AVERAGE POINTS EARNED BY TEAMS WITH AT LEAST 1 WIN
SELECT TeamID, AVG(PointsEarned) AS AvgPoints
FROM TeamPerformance
GROUP BY TeamID
HAVING AVG(PointsEarned) > 1.2 * (
    SELECT AVG(PointsEarned)
    FROM TeamPerformance
    WHERE Wins >= 1
);


/*
i. 4 queries using ANY and ALL to introduce a subquery in the WHERE clause (2 queries per operator); rewrite 2 of them with aggregation operators, and the other 2 with IN / [NOT] IN.
*/

--ALL SPOSORS WITH THE BIGGEST AMOUNT OF FUNDS

SELECT S1.SponsorName
FROM Sponsors S1
WHERE S1.Amount > ALL (
	SELECT S2.Amount
	FROM Sponsors S2
	WHERE S1.SponsorId != S2.SponsorId
);

SELECT S1.SponsorName
FROM Sponsors S1
WHERE S1.Amount IN (
    SELECT MAX(S2.Amount)
    FROM Sponsors S2
);


-- ALL RIDERS WITH RACE POSITION BETTER THAN 10
SELECT RRP.RiderId
FROM RiderRaceParticipation RRP
WHERE RRP.Position < ALL(
    SELECT RRP2.Position
    FROM RiderRaceParticipation RRP2
    WHERE RRP2.Position > 10
);

SELECT RRP.RiderId
FROM RiderRaceParticipation RRP
WHERE RRP.Position IN (
    SELECT RRP2.Position
    FROM RiderRaceParticipation RRP2
    WHERE RRP2.Position <= 10
);



--SOME TEAMS WITH PODIUM FINISHES ABOVE 5
SELECT TP1.TeamID
FROM TeamPerformance TP1
WHERE TP1.PodiumFinishes > ANY(
	SELECT TP2.PodiumFinishes
	FROM TeamPerformance TP2
	WHERE TP2.PodiumFinishes <=5
);


SELECT TP1.TeamID
FROM TeamPerformance TP1
WHERE TP1.PodiumFinishes > (
    SELECT MAX(TP2.PodiumFinishes)
    FROM TeamPerformance TP2
    WHERE TP2.PodiumFinishes <= 5
);




--RETRIEVE THE TEAMID FOR TEAMS WITH WINS GREATER THAN ALL TEAMS WITH PODIUMFINISHES LESS THAN OR EQUAL TO 5
SELECT TP1.TeamID
FROM TeamPerformance TP1
WHERE TP1.Wins > ALL (
    SELECT TP2.Wins
    FROM TeamPerformance TP2
    WHERE TP2.PodiumFinishes <= 5
);

SELECT TP1.TeamID
FROM TeamPerformance TP1
WHERE TP1.Wins > (
    SELECT MIN(TP2.Wins)
    FROM TeamPerformance TP2
    WHERE TP2.PodiumFinishes <= 5
);


-- RETRIEVE THE TEAMID FOR TEAMS WITH WINS GREATER THAN ALL TEAMS WITH PODIUMFINISHES LESS THAN OR EQUAL TO 5
SELECT TP1.TeamID
FROM TeamPerformance TP1
WHERE TP1.Wins > ANY (
    SELECT TP2.Wins
    FROM TeamPerformance TP2
    WHERE TP2.PodiumFinishes >= 5
);

SELECT TP1.TeamID
FROM TeamPerformance TP1
WHERE TP1.Wins > (
    SELECT MIN(TP2.Wins)
    FROM TeamPerformance TP2
    WHERE TP2.PodiumFinishes >= 5
);


--Find teams with wins greater than or equal to the maximum wins of any team with wins less than 3
SELECT TP1.TeamID
FROM TeamPerformance TP1
WHERE TP1.Wins >= ANY(
    SELECT TP2.Wins
    FROM TeamPerformance TP2
    WHERE TP2.Wins < 3
);

SELECT TP1.TeamID
FROM TeamPerformance TP1
JOIN (
    SELECT MAX(Wins) as MaxWins
    FROM TeamPerformance
    WHERE Wins < 3
) TP2
ON TP1.Wins >= TP2.MaxWins;



-- CALCULATES THE TOTAL AMOUNT SPONSORED FOR EACH TEAM
SELECT TeamId, SUM(Amount) AS TotalSponsorshipAmount
FROM Sponsorships
GROUP BY TeamId;

-- CALCULATES AVERAGE SPEED FOR EACH RACE
SELECT RaceID, AVG(AverageSpeed) AS AverageRaceSpeed
FROM RaceStats
GROUP BY RaceID;


-- RETRIEVES DISTINCT LOCATIONS OF ALL RACES
SELECT DISTINCT Location
FROM Races;

-- RETRIEVES RIDERID AND THEIR POINTS, ORDERED BY POINTS IN DESCENDING ORDER
SELECT RiderId, Points
FROM CurrentYearDriverStandings
ORDER BY Points DESC;

-- RETRIEVES TOP 5 RIDERS WITH THE HIGHEST POINTS
SELECT TOP 5 RiderId, Points
FROM CurrentYearDriverStandings
ORDER BY Points DESC;


--CORECTURI

-- Update the Principal of teams that currently have a NULL Principal
UPDATE Teams
SET Principal = 'To Be Assigned'
WHERE Principal IS NULL;

UPDATE Riders
SET RiderName = 'Peco Bagnaia'
WHERE RiderName LIKE '%Francesco Bagnaia%';

SELECT TeamID, SeasonYear, (SUM(PointsEarned) * 1.5) AS AdjustedTotalPoints 
FROM TeamPerformance 
GROUP BY TeamID, SeasonYear;

SELECT TeamID, AVG(PointsEarned / 5.0) AS AvgPointsPerRace 
FROM TeamPerformance 
GROUP BY TeamID;

SELECT StatID, RaceID, (AverageSpeed + 10) AS AdjustedAvgSpeed 
FROM RaceStats;




SELECT * FROM Manufacturers
SELECT * FROM Teams
SELECT * FROM Riders
SELECT * FROM Races
SELECT * FROM RiderRaceParticipation
SELECT * FROM PreviousDriverChampions
SELECT * FROM PrevoiusConstructorChampions
SELECT * FROM Sponsors
SELECT * FROM Sponsorships 
SELECT * FROM CurrentYearDriverStandings   
SELECT * FROM RaceStats
SELECT * FROM TeamPerformance
SELECT * FROM Tires



