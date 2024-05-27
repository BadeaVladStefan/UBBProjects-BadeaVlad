--initial unirii
--1. T1-RC && T2-RC
--Unirii->Unirii->Cipariu->Gara C)
--2. T1-Snapshot && T2-RC -> Gara C)
--3. T1-RR && T2-RC -> B), C), D)


--Neighborhoods: Id, Name, Location
create table Neighborhoods(
	NeighborhoodId int primary key,
	NeighborhoodName varchar(50),
	NeighborhoodLocation varchar(250)
);

--MainResidents: Id, Name, PhoneNumber
create table MainResidents(
	MainResidentId int primary key,
	MainResidentName varchar(50),
	MainResidentPhoneNumber varchar(10)
);

--Homes: Id, Name, Address, NeighborhoodId, MainResidentId
create table SmartHomes(
	SmartHomeId int primary key,
	NeighborhoodId int foreign key references Neighborhoods(NeighborhoodId),
	MainResidentId int foreign key references MainResidents(MainResidentId),
	SmartHomeName varchar(50),
	SmartHomeAddress varchar(250)
);

--Devices: Id, Name
create table SmartDevices(
	SmartDeviceId int primary key,
	SmartDeviceName varchar(50)
);

--HomesDevices: Id, HomeId, DeviceId
create table HomesDevices(
	HomeDeviceId int primary key,
	SmartHomeId int foreign key references SmartHomes(SmartHomeId),
	SmartDeviceId int foreign key references SmartDevices(SmartDeviceId)
);

INSERT INTO Neighborhoods (NeighborhoodId, NeighborhoodName, NeighborhoodLocation) VALUES
(1, 'Neighborhood1', 'Location1'),
(2, 'Neighborhood2', 'Location2'),
(3, 'Neighborhood3', 'Location3');

INSERT INTO MainResidents (MainResidentId, MainResidentName, MainResidentPhoneNumber) VALUES
(1, 'Resident1', '1111111111'),
(2, 'Resident2', '2222222222'),
(3, 'Resident3', '3333333333');

INSERT INTO SmartHomes (SmartHomeId, NeighborhoodId, MainResidentId, SmartHomeName, SmartHomeAddress) VALUES
(1, 1, 1, 'Home1', 'Address1'),
(2, 2, 2, 'Home2', 'Address2'),
(3, 3, 3, 'Home3', 'Address3');


select * from SmartHomes
