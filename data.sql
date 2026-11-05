INSERT INTO Client (Client_ID, Client_LName, Client_FName, Client_Phone, Client_Email)
VALUES (123, 'Smith',    'John',   '9998887777', 'johnsmith@hotmail.com'),
(124, 'Zapata',   'Fatima', '1112223333', 'fzapata@outlook.com'),
(125, 'Jones',    'Eva',    '0891119990', 'evajo04@gmail.com'),
(126, 'Miller',   'Justin', '9087775555', 'millerjustin12@gmail.com'),
(127, 'Williams', 'Sarah',  '2016662222', 'sarahwill22@gmail.com');

INSERT INTO Route (Route_ID, Route_Origin, Route_Destination)
VALUES (1, 'Newark Libery Airport', 'Flushing'),
(2, 'Philadelphia', 'East Rutherford'),
(3, 'Long Branch', 'New Brunswick'),
(4, 'Sussex', 'Albany');

INSERT INTO Vehicle (Vehicle_ID, Vehicle_LicensePlate, Vehicle_Capacity, Vehicle_Type)
VALUES (1, 'BUS1234', 40, 'Bus'),
(2, 'LMO5678', 8,  'Limo'),
(3, 'BUS9012', 55, 'Bus'),
(4, 'LMO3456', 6,  'Limo');

INSERT INTO Driver (Driver_ID, Driver_FName, Driver_LName, License_Num)
VALUES (1, 'Carlos',  'Rivera',  'T-10001'),
(2, 'Diana',   'Chen',    'T-10002'),
(3, 'Marcus',  'Thompson','T-10003'),
(4, 'Priya',   'Patel',   'T-10004');

INSERT INTO Reservation (Reservation_ID, Client_ID, Route_ID, Reservation_Date, Reservation_Cost)
VALUES (1001, 123, 1, '2025-06-10', 450.00),
(1002, 124, 3, '2025-06-15', 800.00),
(1003, 125, 2, '2025-07-04', 300.00),
(1004, 126, 2, '2025-07-20', 650.00),
(1005, 127, 4, '2025-08-01', 950.00),
(1006, 124, 4, '2025-09-10', 950.00);

INSERT INTO Payment (Payment_ID, Reservation_ID, Payment_AmntMade)
VALUES (1, 1001, 450.00),
(2, 1002, 400.00),
(3, 1002, 400.00),
(4, 1003, 300.00),
(5, 1004, 650.00),
(6, 1005, 500.00),
(7, 1005, 450.00),
(8, 1006, 950.00);

INSERT INTO Trip (Trip_ID, Vehicle_ID, Driver_ID, Reservation_ID)
VALUES (1, 1, 1, 1001),
(2, 2, 2, 1002),
(3, 3, 3, 1003),
(4, 4, 4, 1004),
(5, 1, 2, 1005),
(6, 2, 3, 1006);