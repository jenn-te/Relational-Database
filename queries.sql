-- 1. All clients, even without reservations
SELECT c.Client_FName, c.Client_LName, r.Reservation_ID
FROM Client c
LEFT JOIN Reservation r USING (Client_ID);

-- 2. All clients with a reservation
SELECT c.Client_ID, c.Client_FName, c.Client_LName, r.Reservation_Date, r.Reservation_ID
FROM Client c
INNER JOIN Reservation r USING (Client_ID);

-- 3. Clients with more than one reservation
SELECT c.Client_ID, c.Client_FName, c.Client_LName, COUNT(r.Reservation_ID) AS ReservationCount
FROM Client c
INNER JOIN Reservation r USING (Client_ID)
GROUP BY c.Client_ID
HAVING COUNT(r.Reservation_ID) > 1;

-- 4. Avg reservation cost
SELECT AVG(Reservation_Cost) AS AvgCost
FROM Reservation;

-- 5. Clients whose reservation cost is above avg
SELECT c.Client_ID, c.Client_FName, c.Client_LName, r.Reservation_Cost
FROM Client c
JOIN Reservation r USING (Client_ID)
WHERE Client_ID IN (
    SELECT Client_ID FROM Reservation
    WHERE Reservation_Cost > (SELECT AVG(Reservation_Cost) FROM Reservation)
);

-- 6. Amount still owed on a reservation
SELECT Reservation_ID, Reservation_Cost - Payment_AmntMade AS AmntOwed
FROM Reservation
JOIN Payment USING (Reservation_ID);

-- 7. Total reservations per route
SELECT ro.Route_Origin, ro.Route_Destination, COUNT(r.Reservation_ID) AS TotalReservations
FROM Route ro
INNER JOIN Reservation r USING (Route_ID)
GROUP BY ro.Route_ID;

-- 8. Most popular route
SELECT ro.Route_Origin, ro.Route_Destination, COUNT(r.Reservation_ID) AS TotalReservations
FROM Route ro
INNER JOIN Reservation r USING (Route_ID)
GROUP BY ro.Route_ID
ORDER BY TotalReservations DESC
LIMIT 1;

-- 9. Drivers who have been on more than one trip
SELECT d.Driver_ID, d.Driver_FName, d.Driver_LName, COUNT(t.Trip_ID) AS TripCount
FROM Driver d
INNER JOIN Trip t USING (Driver_ID)
GROUP BY d.Driver_ID
HAVING TripCount > 1;

-- 10. Client booking history with route 
SELECT c.Client_ID, c.Client_FName, c.Client_LName, r.Reservation_ID, ro.Route_ID, ro.Route_Origin, ro.Route_Destination
FROM Client c
INNER JOIN Reservation r USING (Client_ID)
INNER JOIN Route ro USING (Route_ID)
ORDER BY c.Client_ID;



-- Views 

-- 1. Gives you all the information for a trip
CREATE VIEW TripRoster AS
SELECT t.Trip_ID,
r.Reservation_Date, 
v.Vehicle_Type, 
d.Driver_FName, d.Driver_LName,
ro.Route_Origin, ro.Route_Destination,
c.Client_FName, c.Client_LName
FROM Trip t
INNER JOIN Reservation r USING (Reservation_ID)
INNER JOIN Vehicle v USING (Vehicle_ID)
INNER JOIN Driver d USING (Driver_ID)
INNER JOIN Route ro USING (Route_ID)
INNER JOIN Client c USING (Client_ID);

-- 2. Shows a reservation and how much is owed on it
CREATE VIEW PaymentSummary AS
SELECT r.Reservation_ID,
c.Client_FName, c.Client_LName,
r.Reservation_Cost,
SUM(p.Payment_AmntMade) AS TotalPaid, -- since a client can make multiple payments (ex. reservation 1002, two payments of 400)
r.Reservation_Cost - SUM(p.Payment_AmntMade) AS Balance
FROM Reservation r
INNER JOIN Client c USING (Client_ID)
INNER JOIN Payment p USING (Reservation_ID)
GROUP BY r.Reservation_ID;


-- Transaction

BEGIN TRANSACTION; -- adding a new client, their reservation + trip info, and payment

INSERT INTO Client (Client_ID, Client_FName, Client_LName, Client_Phone)
VALUES(128, 'Daisy', 'Ox', '9099999999');

INSERT INTO Reservation (Reservation_ID, Client_ID, Route_ID, Reservation_Date, Reservation_Cost)
VALUES(1007, 128, 4, '2025-06-11', 950.00);

INSERT INTO Payment (Payment_ID, Reservation_ID, Payment_AmntMade)
VALUES (9, 1007, 100.00);

INSERT INTO Trip (Trip_ID, Vehicle_ID, Driver_ID, Reservation_ID)
VALUES (7, 4, 4,1007);

COMMIT;



BEGIN TRANSACTION;

UPDATE Payment -- updating how much they paid 
SET Payment_AmntMade = 300.00
WHERE Payment_ID = 9;

COMMIT;
