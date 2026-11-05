CREATE TABLE Client (
Client_ID INT PRIMARY KEY,
Client_LName VARCHAR(20) NOT NULL,
Client_FName VARCHAR(20) NOT NULL,
Client_Phone VARCHAR(10) NOT NULL,
Client_Email VARCHAR(50) UNIQUE
);

CREATE TABLE Driver (
Driver_ID INT PRIMARY KEY,
Driver_FName VARCHAR(20) NOT NULL,
Driver_LName VARCHAR(20) NOT NULL,
License_Num  VARCHAR(20) NOT NULL UNIQUE
);

CREATE TABLE Route (
Route_ID INT PRIMARY KEY,
Route_Origin VARCHAR(100) NOT NULL,
Route_Destination VARCHAR(100) NOT NULL
);

CREATE TABLE Reservation (
Reservation_ID INT PRIMARY KEY,
Client_ID INT REFERENCES Client(Client_ID),
Route_ID INT REFERENCES Route(Route_ID),
Reservation_Date DATE NOT NULL,
Reservation_Cost DECIMAL(10,2) NOT NULL CHECK (Reservation_Cost >= 0)
);

CREATE TABLE Payment (
Payment_ID INT PRIMARY KEY,
Reservation_ID INT REFERENCES Reservation(Reservation_ID),
Payment_AmntMade DECIMAL(10,2) NOT NULL CHECK (Payment_AmntMade > 0)
);

CREATE TABLE Vehicle (
Vehicle_ID int PRIMARY KEY,
Vehicle_LicensePlate VARCHAR(7) NOT NULL UNIQUE,
Vehicle_Capacity INT NOT NULL CHECK (Vehicle_Capacity > 0),
Vehicle_Type VARCHAR(10) NOT NULL CHECK (Vehicle_Type IN ('Bus', 'Limo'))
);

CREATE TABLE Trip (
Trip_ID int PRIMARY KEY,
Vehicle_ID int REFERENCES Vehicle(Vehicle_ID),
Driver_ID int REFERENCES Driver(Driver_ID),
Reservation_ID int REFERENCES Reservation(Reservation_ID)
);

