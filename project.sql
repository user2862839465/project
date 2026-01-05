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


DECLARE @i INT;

/* Airports – 50 */
SET @i = 1;
WHILE @i <= 50
BEGIN
    INSERT INTO Airports VALUES
    ('Airport ' + CAST(@i AS NVARCHAR),
     'City ' + CAST(@i AS NVARCHAR),
     'Country');
    SET @i += 1;
END

/* Airlines – 50 */
SET @i = 1;
WHILE @i <= 50
BEGIN
    INSERT INTO Airlines VALUES ('Airline ' + CAST(@i AS NVARCHAR));
    SET @i += 1;
END

/* Aircrafts – 50 */
SET @i = 1;
WHILE @i <= 50
BEGIN
    INSERT INTO Aircrafts VALUES ('Model ' + CAST(@i AS NVARCHAR), 100 + @i);
    SET @i += 1;
END

/* DiscountTypes */
INSERT INTO DiscountTypes VALUES
('No discount',0),
('Student',20),
('Senior',30),
('Promo',10),
('VIP',40),
('Child',50),
('Employee',60),
('Holiday',15),
('Loyalty',25),
('Special',35);

/* Passengers – 100 */
SET @i = 1;
WHILE @i <= 100
BEGIN
    INSERT INTO Passengers VALUES
    ('Name' + CAST(@i AS NVARCHAR),
     'Surname' + CAST(@i AS NVARCHAR),
     'user' + CAST(@i AS NVARCHAR) + '@mail.com');
    SET @i += 1;
END

/* Flights – 50 */
SET @i = 1;
WHILE @i <= 50
BEGIN
    INSERT INTO Flights VALUES
    (@i, @i, @i,
     ((@i % 50) + 1),
     ((@i + 1) % 50 + 1),
     DATEADD(DAY,@i,GETDATE()),
     120 + @i * 3);
    SET @i += 1;
END

/* Seats – 100 */
SET @i = 1;
WHILE @i <= 100
BEGIN
    INSERT INTO Seats VALUES
    ((@i % 50) + 1, 'A' + CAST(@i AS NVARCHAR));
    SET @i += 1;
END

/* BoardingPasses – 100 */
SET @i = 1;
WHILE @i <= 100
BEGIN
    INSERT INTO BoardingPasses VALUES
    (@i,
     ((@i % 50) + 1),
     @i,
     ((@i % 10) + 1),
     GETDATE());
    SET @i += 1;
END


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

/* =========================================
   5. VIEWS
========================================= */

CREATE VIEW vw_PassengerFlights AS
SELECT p.FirstName, p.LastName, f.FlightID, a.Name AS Airline
FROM BoardingPasses bp
JOIN Passengers p ON bp.PassengerID = p.PassengerID
JOIN Flights f ON bp.FlightID = f.FlightID
JOIN Airlines a ON f.AirlineID = a.AirlineID;
GO

CREATE VIEW vw_DiscountUsage AS
SELECT d.Description, COUNT(*) AS UsedCount
FROM BoardingPasses bp
JOIN DiscountTypes d ON bp.DiscountID = d.DiscountID
GROUP BY d.Description;
GO

/* =========================================
   6. STORED PROCEDURES
========================================= */

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

/* =========================================
   7. ÇÀßÂÊÈ (ÏÎ ÊÐÈÒÅÐÈÈ)
========================================= */

/* 5 SELECT */
SELECT * FROM Passengers;
SELECT * FROM Flights;
SELECT * FROM Airports;
SELECT * FROM Airlines;
SELECT * FROM DiscountTypes;

/* 5 JOIN + GROUP BY */
SELECT AirlineID, COUNT(*) AS FlightsCount FROM Flights GROUP BY AirlineID;
SELECT DiscountID, COUNT(*) FROM BoardingPasses GROUP BY DiscountID;
SELECT AircraftID, COUNT(*) FROM Seats GROUP BY AircraftID;
SELECT FlightID, COUNT(*) FROM BoardingPasses GROUP BY FlightID;
SELECT DepartureAirportID, AVG(BasePrice) FROM Flights GROUP BY DepartureAirportID;

/* 2 Ïîäçàÿâêè */
SELECT * FROM Flights
WHERE BasePrice > (SELECT AVG(BasePrice) FROM Flights);

SELECT * FROM Passengers
WHERE PassengerID IN (SELECT PassengerID FROM BoardingPasses);

/* Ïàðàìåòðè÷íà çàÿâêà */
DECLARE @Flight INT = 10;
EXEC sp_FlightReport @Flight;
