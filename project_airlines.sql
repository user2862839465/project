CREATE DATABASE AirportDB;
GO
USE AirportDB;
GO

CREATE TABLE Airports (
AirportID INT IDENTITY PRIMARY KEY,
Name NVARCHAR(100) NOT NULL,
City NVARCHAR(50) NOT NULL,
Country NVARCHAR(50) NOT NULL
);

CREATE TABLE Airlines (
AirlineID INT IDENTITY PRIMARY KEY,
Name NVARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE Aircrafts (
AircraftID INT IDENTITY PRIMARY KEY,
Model NVARCHAR(50) NOT NULL,
Capacity INT CHECK (Capacity BETWEEN 50 AND 300)
);

CREATE TABLE Passengers (
PassengerID INT IDENTITY PRIMARY KEY,
FirstName NVARCHAR(50) NOT NULL,
LastName NVARCHAR(50) NOT NULL,
Email NVARCHAR(100) UNIQUE
);

CREATE TABLE DiscountTypes (
DiscountID INT IDENTITY PRIMARY KEY,
Description NVARCHAR(50),
Percentage INT CHECK (Percentage BETWEEN 0 AND 70)
);

CREATE TABLE Flights (
FlightID INT IDENTITY PRIMARY KEY,
AirlineID INT NOT NULL,
AircraftID INT NOT NULL,
DepartureAirportID INT NOT NULL,
ArrivalAirportID INT NOT NULL,
DepartureTime DATETIME NOT NULL,
BasePrice DECIMAL(10,2) CHECK (BasePrice > 0),
FOREIGN KEY (AirlineID) REFERENCES Airlines(AirlineID),
FOREIGN KEY (AircraftID) REFERENCES Aircrafts(AircraftID),
FOREIGN KEY (DepartureAirportID) REFERENCES Airports(AirportID),
FOREIGN KEY (ArrivalAirportID) REFERENCES Airports(AirportID)
);

CREATE TABLE Seats (
SeatID INT IDENTITY PRIMARY KEY,
AircraftID INT NOT NULL,
SeatNumber NVARCHAR(5) NOT NULL,
FOREIGN KEY (AircraftID) REFERENCES Aircrafts(AircraftID)
);

CREATE TABLE BoardingPasses (
BoardingPassID INT IDENTITY PRIMARY KEY,
PassengerID INT NOT NULL,
FlightID INT NOT NULL,
SeatID INT NOT NULL UNIQUE,
DiscountID INT NOT NULL,
IssueDate DATETIME DEFAULT GETDATE(),
FOREIGN KEY (PassengerID) REFERENCES Passengers(PassengerID),
FOREIGN KEY (FlightID) REFERENCES Flights(FlightID),
FOREIGN KEY (SeatID) REFERENCES Seats(SeatID),
FOREIGN KEY (DiscountID) REFERENCES DiscountTypes(DiscountID)
);

INSERT INTO Airports (Name, City, Country) VALUES
('Sofia Airport','Sofia','Bulgaria'),
('Heathrow','London','UK'),
('Charles de Gaulle','Paris','France'),
('Schiphol','Amsterdam','Netherlands'),
('Frankfurt Airport','Frankfurt','Germany'),
('Madrid Barajas','Madrid','Spain'),
('Fiumicino','Rome','Italy'),
('Vienna Airport','Vienna','Austria'),
('Zurich Airport','Zurich','Switzerland'),
('Athens Airport','Athens','Greece'),
('Istanbul Airport','Istanbul','Turkey'),
('Dubai Airport','Dubai','UAE'),
('Doha Airport','Doha','Qatar'),
('JFK','New York','USA'),
('LAX','Los Angeles','USA'),
('Chicago O’Hare','Chicago','USA'),
('Toronto Pearson','Toronto','Canada'),
('Vancouver Airport','Vancouver','Canada'),
('Mexico City Airport','Mexico City','Mexico'),
('Sao Paulo GRU','Sao Paulo','Brazil'),
('Buenos Aires EZE','Buenos Aires','Argentina'),
('Lima Airport','Lima','Peru'),
('Bogota Airport','Bogota','Colombia'),
('Santiago Airport','Santiago','Chile'),
('Sydney Airport','Sydney','Australia'),
('Melbourne Airport','Melbourne','Australia'),
('Auckland Airport','Auckland','New Zealand'),
('Tokyo Narita','Tokyo','Japan'),
('Tokyo Haneda','Tokyo','Japan'),
('Seoul Incheon','Seoul','South Korea'),
('Beijing Capital','Beijing','China'),
('Shanghai Pudong','Shanghai','China'),
('Hong Kong Airport','Hong Kong','China'),
('Singapore Changi','Singapore','Singapore'),
('Bangkok Suvarnabhumi','Bangkok','Thailand'),
('Kuala Lumpur Airport','Kuala Lumpur','Malaysia'),
('Jakarta Airport','Jakarta','Indonesia'),
('Manila Airport','Manila','Philippines'),
('Delhi Airport','Delhi','India'),
('Mumbai Airport','Mumbai','India'),
('Karachi Airport','Karachi','Pakistan'),
('Cairo Airport','Cairo','Egypt'),
('Casablanca Airport','Casablanca','Morocco'),
('Johannesburg OR Tambo','Johannesburg','South Africa'),
('Cape Town Airport','Cape Town','South Africa'),
('Nairobi Airport','Nairobi','Kenya'),
('Tel Aviv Airport','Tel Aviv','Israel'),
('Riyadh Airport','Riyadh','Saudi Arabia'),
('Kuwait Airport','Kuwait City','Kuwait'),
('Tehran Airport','Tehran','Iran');

INSERT INTO Airlines (Name) VALUES
('Lufthansa'),
('Air France'),
('British Airways'),
('KLM'),
('Turkish Airlines'),
('Qatar Airways'),
('Emirates'),
('Ryanair'),
('Wizz Air'),
('easyJet'),
('American Airlines'),
('Delta Airlines'),
('United Airlines'),
('Air Canada'),
('LATAM'),
('Aeroflot'),
('Alitalia'),
('Austrian Airlines'),
('Swiss International'),
('SAS'),
('Airline Alpha'),
('Airline Beta'),
('Airline Gamma'),
('Airline Delta'),
('Airline Epsilon'),
('Airline Zeta'),
('Airline Omega'),
('Airline Nova'),
('Airline Sky'),
('Airline Jet'),
('Airline Sun'),
('Airline Star'),
('Airline Cloud'),
('Airline Falcon'),
('Airline Eagle'),
('Airline Horizon'),
('Airline Vector'),
('Airline Atlas'),
('Airline Prime'),
('Airline Global'),
('Airline Connect'),
('Airline Express'),
('Airline Union'),
('Airline World'),
('Airline Euro'),
('Airline Asia'),
('Airline Africa'),
('Airline America'),
('Airline Pacific'),
('Airline Atlantic');

INSERT INTO Aircrafts (Model, Capacity) VALUES
('Airbus A320',180),
('Airbus A321',220),
('Airbus A330',250),
('Airbus A350',300),
('Boeing 737-800',189),
('Boeing 737 MAX',210),
('Boeing 747',300),
('Boeing 777',280),
('Boeing 787 Dreamliner',260),
('Embraer E190',100),
('Bombardier Q400',80),
('ATR 72',70),
('CRJ-900',90),
('Airbus A220',130),
('Boeing 767',240),
('Boeing 757',200),
('Airbus A380',300),
('Comac C919',160),
('MC-21',180),
('Superjet 100',100),
('Model X1',120),
('Model X2',130),
('Model X3',140),
('Model X4',150),
('Model X5',160),
('Model X6',170),
('Model X7',180),
('Model X8',190),
('Model X9',200),
('Model X10',210),
('Model X11',220),
('Model X12',230),
('Model X13',240),
('Model X14',250),
('Model X15',260),
('Model X16',270),
('Model X17',280),
('Model X18',290),
('Model X19',300),
('Model X20',150),
('Model X21',160),
('Model X22',170),
('Model X23',180),
('Model X24',190),
('Model X25',200),
('Model X26',210),
('Model X27',220),
('Model X28',230),
('Model X29',240),
('Model X30',250);

INSERT INTO Passengers (FirstName, LastName, Email) VALUES
('Ivan','Petrov','ivan.petrov@mail.com'),
('Maria','Ivanova','maria.ivanova@mail.com'),
('Georgi','Georgiev','georgi.georgiev@mail.com'),
('Nikolay','Dimitrov','nikolay.dimitrov@mail.com'),
('Elena','Stoyanova','elena.stoyanova@mail.com'),
('Peter','Johnson','peter.johnson@mail.com'),
('Anna','Smith','anna.smith@mail.com'),
('John','Brown','john.brown@mail.com'),
('Michael','Miller','michael.miller@mail.com'),
('Emily','Wilson','emily.wilson@mail.com'),
('Dimitar','Nikolov','dimitar.nikolov@mail.com'),
('Stefan','Stefanov','stefan.stefanov@mail.com'),
('Krasimir','Kolev','krasimir.kolev@mail.com'),
('Veselin','Angelov','veselin.angelov@mail.com'),
('Plamen','Hristov','plamen.hristov@mail.com'),
('Radoslav','Petkov','radoslav.petkov@mail.com'),
('Borislav','Todorov','borislav.todorov@mail.com'),
('Kaloyan','Marinov','kaloyan.marinov@mail.com'),
('Todor','Iliev','todor.iliev@mail.com'),
('Hristo','Kostov','hristo.kostov@mail.com'),
('Alex','Martin','alex.martin@mail.com'),
('Daniel','Garcia','daniel.garcia@mail.com'),
('Carlos','Rodriguez','carlos.rodriguez@mail.com'),
('Luis','Fernandez','luis.fernandez@mail.com'),
('Javier','Lopez','javier.lopez@mail.com'),
('Miguel','Sanchez','miguel.sanchez@mail.com'),
('Sofia','Gonzalez','sofia.gonzalez@mail.com'),
('Isabella','Martinez','isabella.martinez@mail.com'),
('Lucia','Perez','lucia.perez@mail.com'),
('Paula','Ruiz','paula.ruiz@mail.com'),
('Jean','Dupont','jean.dupont@mail.com'),
('Pierre','Martin','pierre.martin@mail.com'),
('Luc','Bernard','luc.bernard@mail.com'),
('Antoine','Lefevre','antoine.lefevre@mail.com'),
('Camille','Moreau','camille.moreau@mail.com'),
('Chloe','Dubois','chloe.dubois@mail.com'),
('Julien','Laurent','julien.laurent@mail.com'),
('Thomas','Simon','thomas.simon@mail.com'),
('Emma','Michel','emma.michel@mail.com'),
('Laura','Garner','laura.garner@mail.com'),
('Oliver','Taylor','oliver.taylor@mail.com'),
('Harry','Moore','harry.moore@mail.com'),
('Jack','Anderson','jack.anderson@mail.com'),
('Jacob','Thomas','jacob.thomas@mail.com'),
('Charlie','Jackson','charlie.jackson@mail.com'),
('Amelia','White','amelia.white@mail.com'),
('Mia','Harris','mia.harris@mail.com'),
('Ella','Clark','ella.clark@mail.com'),
('Grace','Lewis','grace.lewis@mail.com'),
('Lily','Walker','lily.walker@mail.com'),
('Noah','Muller','noah.muller@mail.com'),
('Lukas','Schmidt','lukas.schmidt@mail.com'),
('Leon','Fischer','leon.fischer@mail.com'),
('Felix','Weber','felix.weber@mail.com'),
('Jonas','Becker','jonas.becker@mail.com'),
('Hannah','Keller','hannah.keller@mail.com'),
('Lena','Hoffmann','lena.hoffmann@mail.com'),
('Mia','Schulz','mia.schulz@mail.com'),
('Anna','Braun','anna.braun@mail.com'),
('Sophie','Vogel','sophie.vogel@mail.com'),
('Marco','Rossi','marco.rossi@mail.com'),
('Luca','Bianchi','luca.bianchi@mail.com'),
('Giulia','Romano','giulia.romano@mail.com'),
('Francesca','Gallo','francesca.gallo@mail.com'),
('Alessandro','Costa','alessandro.costa@mail.com'),
('Paolo','Conti','paolo.conti@mail.com'),
('Elisa','Ferrari','elisa.ferrari@mail.com'),
('Martina','Russo','martina.russo@mail.com'),
('Davide','Marchetti','davide.marchetti@mail.com'),
('Simone','DeLuca','simone.deluca@mail.com');

INSERT INTO Flights
(AirlineID, AircraftID, DepartureAirportID, ArrivalAirportID, DepartureTime, BasePrice)
VALUES
(1,1,1,2,DATEADD(DAY,1,GETDATE()),150),
(2,2,2,3,DATEADD(DAY,2,GETDATE()),160),
(3,3,3,4,DATEADD(DAY,3,GETDATE()),170),
(4,4,4,5,DATEADD(DAY,4,GETDATE()),180),
(5,5,5,6,DATEADD(DAY,5,GETDATE()),190),
(6,6,6,7,DATEADD(DAY,6,GETDATE()),200),
(7,7,7,8,DATEADD(DAY,7,GETDATE()),210),
(8,8,8,9,DATEADD(DAY,8,GETDATE()),220),
(9,9,9,10,DATEADD(DAY,9,GETDATE()),230),
(10,10,10,11,DATEADD(DAY,10,GETDATE()),240),
(11,11,11,12,DATEADD(DAY,11,GETDATE()),250),
(12,12,12,13,DATEADD(DAY,12,GETDATE()),260),
(13,13,13,14,DATEADD(DAY,13,GETDATE()),270),
(14,14,14,15,DATEADD(DAY,14,GETDATE()),280),
(15,15,15,16,DATEADD(DAY,15,GETDATE()),290),
(16,16,16,17,DATEADD(DAY,16,GETDATE()),300),
(17,17,17,18,DATEADD(DAY,17,GETDATE()),310),
(18,18,18,19,DATEADD(DAY,18,GETDATE()),320),
(19,19,19,20,DATEADD(DAY,19,GETDATE()),330),
(20,20,20,21,DATEADD(DAY,20,GETDATE()),340),
(21,21,21,22,DATEADD(DAY,21,GETDATE()),350),
(22,22,22,23,DATEADD(DAY,22,GETDATE()),360),
(23,23,23,24,DATEADD(DAY,23,GETDATE()),370),
(24,24,24,25,DATEADD(DAY,24,GETDATE()),380),
(25,25,25,26,DATEADD(DAY,25,GETDATE()),390),
(26,26,26,27,DATEADD(DAY,26,GETDATE()),400),
(27,27,27,28,DATEADD(DAY,27,GETDATE()),410),
(28,28,28,29,DATEADD(DAY,28,GETDATE()),420),
(29,29,29,30,DATEADD(DAY,29,GETDATE()),430),
(30,30,30,31,DATEADD(DAY,30,GETDATE()),440),
(31,31,31,32,DATEADD(DAY,31,GETDATE()),450),
(32,32,32,33,DATEADD(DAY,32,GETDATE()),460),
(33,33,33,34,DATEADD(DAY,33,GETDATE()),470),
(34,34,34,35,DATEADD(DAY,34,GETDATE()),480),
(35,35,35,36,DATEADD(DAY,35,GETDATE()),490),
(36,36,36,37,DATEADD(DAY,36,GETDATE()),500),
(37,37,37,38,DATEADD(DAY,37,GETDATE()),510),
(38,38,38,39,DATEADD(DAY,38,GETDATE()),520),
(39,39,39,40,DATEADD(DAY,39,GETDATE()),530),
(40,40,40,41,DATEADD(DAY,40,GETDATE()),540);

INSERT INTO Seats (AircraftID, SeatNumber) VALUES
(1,'A1'),(1,'A2'),
(2,'A1'),(2,'A2'),
(3,'A1'),(3,'A2'),
(4,'A1'),(4,'A2'),
(5,'A1'),(5,'A2'),
(6,'A1'),(6,'A2'),
(7,'A1'),(7,'A2'),
(8,'A1'),(8,'A2'),
(9,'A1'),(9,'A2'),
(10,'A1'),(10,'A2'),
(11,'A1'),(11,'A2'),
(12,'A1'),(12,'A2'),
(13,'A1'),(13,'A2'),
(14,'A1'),(14,'A2'),
(15,'A1'),(15,'A2'),
(16,'A1'),(16,'A2'),
(17,'A1'),(17,'A2'),
(18,'A1'),(18,'A2'),
(19,'A1'),(19,'A2'),
(20,'A1'),(20,'A2'),
(21,'A1'),(21,'A2'),
(22,'A1'),(22,'A2'),
(23,'A1'),(23,'A2'),
(24,'A1'),(24,'A2'),
(25,'A1'),(25,'A2'),
(26,'A1'),(26,'A2'),
(27,'A1'),(27,'A2'),
(28,'A1'),(28,'A2'),
(29,'A1'),(29,'A2'),
(30,'A1'),(30,'A2'),
(31,'A1'),(31,'A2'),
(32,'A1'),(32,'A2'),
(33,'A1'),(33,'A2'),
(34,'A1'),(34,'A2'),
(35,'A1'),(35,'A2'),
(36,'A1'),(36,'A2'),
(37,'A1'),(37,'A2'),
(38,'A1'),(38,'A2'),
(39,'A1'),(39,'A2'),
(40,'A1'),(40,'A2');

INSERT INTO DiscountTypes (Description, Percentage) VALUES
('No discount',0),
('Student',20),
('Senior',30),
('Promo',10),
('VIP',40),
('Child',50),
('Employee',60),
('Holiday',15),
('Loyalty',25),
('Special offer',35);

INSERT INTO BoardingPasses
(PassengerID, FlightID, SeatID, DiscountID, IssueDate)
VALUES
(1,1,1,1,GETDATE()),
(2,2,2,2,GETDATE()),
(3,3,3,3,GETDATE()),
(4,4,4,4,GETDATE()),
(5,5,5,5,GETDATE()),
(6,6,6,6,GETDATE()),
(7,7,7,7,GETDATE()),
(8,8,8,8,GETDATE()),
(9,9,9,9,GETDATE()),
(10,10,10,10,GETDATE()),
(11,11,11,1,GETDATE()),
(12,12,12,2,GETDATE()),
(13,13,13,3,GETDATE()),
(14,14,14,4,GETDATE()),
(15,15,15,5,GETDATE()),
(16,16,16,6,GETDATE()),
(17,17,17,7,GETDATE()),
(18,18,18,8,GETDATE()),
(19,19,19,9,GETDATE()),
(20,20,20,10,GETDATE()),
(21,21,21,1,GETDATE()),
(22,22,22,2,GETDATE()),
(23,23,23,3,GETDATE()),
(24,24,24,4,GETDATE()),
(25,25,25,5,GETDATE()),
(26,26,26,6,GETDATE()),
(27,27,27,7,GETDATE()),
(28,28,28,8,GETDATE()),
(29,29,29,9,GETDATE()),
(30,30,30,10,GETDATE()),
(31,31,31,1,GETDATE()),
(32,32,32,2,GETDATE()),
(33,33,33,3,GETDATE()),
(34,34,34,4,GETDATE()),
(35,35,35,5,GETDATE()),
(36,36,36,6,GETDATE()),
(37,37,37,7,GETDATE()),
(38,38,38,8,GETDATE()),
(39,39,39,9,GETDATE()),
(40,40,40,10,GETDATE());

CREATE FUNCTION dbo.fn_FinalPrice
(
@BasePrice DECIMAL(10,2),
@Discount INT
)
RETURNS DECIMAL(10,2)
AS
BEGIN
RETURN @BasePrice - (@BasePrice * @Discount / 100.0);
END;
GO


CREATE VIEW vw_PassengerFlights 
AS
SELECT p.FirstName, p.LastName, f.FlightID, a.Name AS Airline
FROM BoardingPasses bp
JOIN Passengers p ON bp.PassengerID = p.PassengerID
JOIN Flights f ON bp.FlightID = f.FlightID
JOIN Airlines a ON f.AirlineID = a.AirlineID;
GO

CREATE VIEW vw_DiscountUsage 
AS
SELECT d.Description, COUNT(*) AS UsedCount
FROM BoardingPasses bp
JOIN DiscountTypes d ON bp.DiscountID = d.DiscountID
GROUP BY d.Description;
GO

CREATE VIEW vw_PassengerFinalPrices AS
SELECT 
p.FirstName,
p.LastName,
f.FlightID,
dbo.fn_FinalPrice(f.BasePrice, d.Percentage) AS FinalPrice
FROM BoardingPasses bp
JOIN Passengers p ON bp.PassengerID = p.PassengerID
JOIN Flights f ON bp.FlightID = f.FlightID
JOIN DiscountTypes d ON bp.DiscountID = d.DiscountID;
GO

CREATE PROCEDURE sp_AddPassenger
@First NVARCHAR(50),
@Last NVARCHAR(50),
@Email NVARCHAR(100)
AS
BEGIN
INSERT INTO Passengers VALUES (@First,@Last,@Email);
END;
GO

CREATE PROCEDURE sp_FlightReport
@FlightID INT
AS
BEGIN
SELECT p.FirstName, p.LastName
FROM BoardingPasses bp
JOIN Passengers p ON bp.PassengerID = p.PassengerID
WHERE bp.FlightID = @FlightID;
END;
GO

SELECT * FROM Passengers;
SELECT * FROM Flights;
SELECT * FROM DiscountTypes;
SELECT AircraftID, COUNT(*) AS Passengers FROM Seats GROUP BY AircraftID;
SELECT FlightID, COUNT(*) AS AvgPrice FROM BoardingPasses GROUP BY FlightID;
SELECT DepartureAirportID, AVG(BasePrice) FROM Flights GROUP BY DepartureAirportID;
SELECT AirlineID, COUNT(*) AS FlightsCount FROM Flights GROUP BY AirlineID;

SELECT 
f.FlightID,
a.Name AS Airline,
COUNT(bp.PassengerID) AS PassengerCount
FROM Flights f
JOIN Airlines a ON f.AirlineID = a.AirlineID
JOIN BoardingPasses bp ON f.FlightID = bp.FlightID
GROUP BY f.FlightID, a.Name;

SELECT 
d.Description AS DiscountType,
AVG(dbo.fn_FinalPrice(f.BasePrice, d.Percentage)) AS AvgFinalPrice
FROM BoardingPasses bp
JOIN Flights f ON bp.FlightID = f.FlightID
JOIN DiscountTypes d ON bp.DiscountID = d.DiscountID
GROUP BY d.Description;

SELECT 
ap.Country,
COUNT(f.FlightID) AS FlightsCount
FROM Flights f
JOIN Airports ap ON f.DepartureAirportID = ap.AirportID
GROUP BY ap.Country;

SELECT 
a.Name AS Airline,
COUNT(bp.PassengerID) AS PassengerCount
FROM Airlines a
JOIN Flights f ON a.AirlineID = f.AirlineID
JOIN BoardingPasses bp ON f.FlightID = bp.FlightID
GROUP BY a.Name;

SELECT 
ac.Model AS AircraftModel,
AVG(f.BasePrice) AS AvgBasePrice
FROM Aircrafts ac
JOIN Flights f ON ac.AircraftID = f.AircraftID
GROUP BY ac.Model;

SELECT 
a.Name,
COUNT(f.FlightID) AS FlightsCount
FROM Airlines a
JOIN Flights f ON a.AirlineID = f.AirlineID
GROUP BY a.Name
HAVING COUNT(f.FlightID) > 0;

SELECT FirstName, LastName
FROM Passengers
WHERE PassengerID IN
(
SELECT bp.PassengerID
FROM BoardingPasses bp
JOIN DiscountTypes d ON bp.DiscountID = d.DiscountID
WHERE d.Percentage >
 (
SELECT AVG(Percentage)
FROM DiscountTypes
 )
);

SELECT *
FROM Flights f
WHERE f.BasePrice >
(
SELECT AVG(f2.BasePrice)
FROM Flights f2
WHERE f2.AirlineID = f.AirlineID
);



DECLARE @MinPrice DECIMAL(10,2) = 300;
SELECT 
p.FirstName,
p.LastName,
f.FlightID,
f.BasePrice
FROM BoardingPasses bp
JOIN Passengers p ON bp.PassengerID = p.PassengerID
JOIN Flights f ON bp.FlightID = f.FlightID
WHERE f.BasePrice >= @MinPrice;