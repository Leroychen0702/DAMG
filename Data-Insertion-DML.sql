--Inserting data into expo table
INSERT INTO expo (expo_id, expo_name, expo_location, expo_description, expo_start_datetime, expo_end_datetime)
VALUES (1, 'Comic-Con Day 1', 'Boston Convention Center Hall 1', 'The biggest nerd event of the year', '2023-11-25 10:00:00', '2023-11-25 18:00:00'),
  (2, 'Comic-Con Day 2', 'Boston Convention Center Hall 2', 'The biggest nerd event of the year', '2023-11-26 10:00:00', '2023-11-26 19:00:00');

--Inserting data into ticket table
INSERT INTO ticket (ticket_id, expo_id, attendee_id, ticket_type, ticket_price)
VALUES 
   (1, 1, 1, 'Super-fan', 100.00),   
    (2, 2, 2, 'Single Day-Saturday', 65.00),
    (3, 1, 3, 'Super-fan', 100.00),
    (4, 2,4, 'Single Day-Sunday', 65.00),
    (5, 1, 5, 'Super-fan', 100.00),
    (6, 2, 6, 'Single Day-Saturday', 65.00),
    (7, 1, 7, 'Super-fan', 100.00),
    (8, 2, 8, 'Single Day-Sunday', 65.00),
    (9, 1,9, 'Super-fan', 100.00),
    (10, 2, 10, 'Single Day-Saturday', 65.00),
    (11, 2, 11, 'Single Day-Saturday', 65.00);
   
--Inserting data into attendee table   
INSERT INTO Attendee (Attendee_ID, Attendee_Name, Attendee_Email, Attendee_DOB)
VALUES
(1, 'John Doe', 'john.doe@example.com', '1990-05-15'),
(2, 'Jane Smith', 'jane.smith@example.com', '1985-08-22'),
(3, 'Bob Johnson', 'bob.johnson@example.com', '1992-02-10'),
(4, 'Alice Johnson', 'alice.johnson@example.com', '1988-11-30'),
(5, 'Charlie Brown', 'charlie.brown@example.com', '1995-07-18'),
(6, 'Eva Martinez', 'eva.martinez@example.com', '1983-04-25'),
(7, 'Michael Wang', 'michael.wang@example.com', '1998-09-03'),
(8, 'Olivia Turner', 'olivia.turner@example.com', '1991-06-12'),
(9, 'David Lee', 'david.lee@example.com', '1997-03-08'),
(10, 'Sophia Garcia', 'sophia.garcia@example.com', '1989-12-14'),
(11, 'Gagan Jain', 'gagan.jain@example.com', '1989-12-14');

--Inserting data into payment table
INSERT INTO Payment (Payment_ID, Attendee_ID, Payment_Amount, Payment_Method, Payment_Date)
VALUES
(1, 1, 50.00, 'Credit Card', '2023-01-15'),
(2, 2, 25.00, 'Cash', '2023-02-20'),
(3, 3, 75.00, 'PayPal', '2023-03-10'),
(4, 4, 30.00, 'Credit Card', '2023-04-05'),
(5, 5, 40.00, 'Cash', '2023-05-12'),
(6, 6, 60.00, 'PayPal', '2023-06-18'),
(7,7, 25.00, 'Credit Card', '2023-07-25'),
(8, 8, 55.00, 'Cash', '2023-08-30'),
(9, 9, 70.00, 'PayPal', '2023-09-08'),
(10, 10, 45.00, 'Credit Card', '2023-10-14'),
(11, 11, 80.00, 'Cash', '2023-11-20');
 
--inserting data into stall table
INSERT INTO stall (stall_id, expo_id, booth_number, stall_size) VALUES 
(1, 1, 'A101', '10x10'),
(2, 2, 'A102', '10x10'),
(3, 1, 'A103', '10x15'),
(4, 2, 'B101', '10x20'),
(5, 1, 'B102', '10x10'),
(6, 2, 'C101', '10x15'),
(7, 1, 'C102', '20x20'),
(8, 2, 'D101', '15x15'),
(9, 1, 'D102', '10x10'),
(10, 2, 'E101', '10x20');

--inserting data into staff table
INSERT INTO staff (staff_id, stall_id, staff_name, staff_email) VALUES 
(1, 1, 'John Doe', 'johndoe@example.com'),
(2, 2, 'Jane Smith', 'janesmith@example.com'),
(3, 3, 'Alice Johnson', 'alicejohnson@example.com'),
(4, 4, 'Bob Brown', 'bobbrown@example.com'),
(5, 5, 'Charlie Davis', 'charliedavis@example.com'),
(6, 6, 'Diana Evans', 'dianaevans@example.com'),
(7, 7, 'Ethan Harris', 'ethanharris@example.com'),
(8, 8, 'Fiona King', 'fionaking@example.com'),
(9, 9, 'George Lee', 'georgelee@example.com'),
(10, 10, 'Hannah Martin', 'hannahmartin@example.com');

--inserting data into inventory table
INSERT INTO inventory (inventory_id, stall_id, item_description, item_quantity) VALUES 
(1, 1, 'Smartphone Case - Black', 100),
(2, 2, 'Laptop Backpack - 15-inch', 150),
(3, 3, 'Wireless Bluetooth Earbuds', 200),
(4, 4, 'Stainless Steel Water Bottle', 250),
(5, 5, 'LED Desk Lamp - Adjustable', 300),
(6, 6, 'Home Theater Sound System', 350),
(7, 7, 'Digital Camera - 20MP', 400),
(8, 8, 'Coffee Maker - Programmable', 450),
(9, 9, 'Fitness Tracker Watch', 500),
(10, 10, 'Smart TV - 55-inch 4K', 550);
 
--Inserting data into panel table
INSERT INTO panel (panel_id, expo_id, panel_start_time, panel_end_time) VALUES 
(1, 101, '2023-01-01T10:00:00', '2023-01-01T11:00:00'),
(2, 102, '2023-01-02T12:00:00', '2023-01-02T13:00:00'),
(3, 103, '2023-01-03T14:00:00', '2023-01-03T15:00:00'),
(4, 104, '2023-01-04T16:00:00', '2023-01-04T17:00:00'),
(5, 105, '2023-01-05T18:00:00', '2023-01-05T19:00:00'),
(6, 106, '2023-01-06T20:00:00', '2023-01-06T21:00:00'),
(7, 107, '2023-01-07T22:00:00', '2023-01-07T23:00:00'),
(8, 108, '2023-01-08T08:00:00', '2023-01-08T09:00:00'),
(9, 109, '2023-01-09T10:00:00', '2023-01-09T11:00:00'),
(10, 110, '2023-01-10T12:00:00', '2023-01-10T13:00:00');

--Inserting data into artist table
INSERT INTO artist (artist_id, panel_id, artist_name, genre, artist_email, artist_phone) VALUES 
(1, 1, 'Evelyn Hart', 'Superhero', 'evelyn.hart@example.com', '123-456-7890'),
(2, 2, 'Leo Goodman', 'Fantasy', 'leo.goodman@example.com', '123-456-7891'),
(3, 3, 'Adrianne Low', 'Science Fiction', 'adrianne.low@example.com', '123-456-7892'),
(4, 4, 'Marcus Reid', 'Horror', 'marcus.reid@example.com', '123-456-7893'),
(5, 5, 'Tanya Burke', 'Mystery', 'tanya.burke@example.com', '123-456-7894'),
(6, 6, 'Samuel Tate', 'Thriller', 'samuel.tate@example.com', '123-456-7895'),
(7, 7, 'Christina Yang', 'Romance', 'christina.yang@example.com', '123-456-7896'),
(8, 8, 'Oscar Dunn', 'Adventure', 'oscar.dunn@example.com', '123-456-7897'),
(9, 9, 'Sophia Miles', 'Slice of Life', 'sophia.miles@example.com', '123-456-7898'),
(10, 10, 'Lucas Grant', 'Historical', 'lucas.grant@example.com', '123-456-7899');

--Inserting data into sponsor table
INSERT INTO sponsor (sponsor_id, role_id, expo_id, sponsor_name, sponsor_description)
VALUES
('SP1', 'RL1', 1, 'John Doe', 'Premier supporter providing top-level sponsorship'),
('SP2', 'RL2', 2, 'Jane Smith', 'Key collaborator with significant sponsorship'),
('SP3', 'RL3', 1, 'Mark Johnson', 'Valuable supporter contributing at a substantial level'),
('SP4', 'RL4', 2, 'Sarah White', ' Sponsors specific panels'),
('SP5', 'RL5', 1, 'Robert Lee', 'Supports and sponsors the cosplay competition'),
('SP6', 'RL6', 2, 'Emily Brown', ' Provides sponsorship for the VIP lounge'),
('SP7', 'RL7', 1, 'Michael Taylor', 'Supports the artist alley'),
('SP8', 'RL8', 2, 'Laura Davis', 'Sponsors interactive exhibits'),
('SP9', 'RL9', 1, 'Kevin Miller', 'Exclusive partner for event merchandise'),
('SP10', 'RL10', 2, 'Amanda Wilson', 'Hosts and sponsors the official after-party');


--inserting data into sponsor_role table
INSERT INTO sponsor_role(role_id,sponsor_id,role_name)
VALUES('RL1', 'SP1', 'Platinum Sponsor'),
('RL2', 'SP2', 'Gold Partner'),
('RL3', 'SP3', 'Silver Contributor'),
('RL4', 'SP4', 'Exclusive Panel Sponsor'),
('RL5', 'SP5', 'Cosplay Competition Sponsor'),
('RL6', 'SP6', 'VIP Lounge Sponsor'),
('RL7', 'SP7', 'Artist Alley Supporter'),
('RL8', 'SP8', 'Interactive Exhibit Sponsor'),
('RL9', 'SP9', 'Official Merchandise Partner'),
('RL10','SP10', 'After-Party Host');





    
    
    
    
    
    
    