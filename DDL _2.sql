### Procedure (1)



USE HW;
DELIMITER //

CREATE PROCEDURE GetStallDetails(
    IN p_stall_id INT
)
BEGIN
  
    DECLARE staff_names TEXT;
    DECLARE item_details TEXT;

    -- Retrieve staff names for the stall
    SELECT GROUP_CONCAT(staff_name SEPARATOR ', ')
    INTO staff_names
    FROM staff
    WHERE stall_id = p_stall_id;

    SELECT GROUP_CONCAT(CONCAT(item_description, ' (', item_quantity, ' in stock)') SEPARATOR ', ')
    INTO item_details
    FROM inventory
    WHERE stall_id = p_stall_id;

    -- Display the results
    SELECT
        p_stall_id AS stall_id,
        staff_names AS staff,
        item_details AS inventory;
END //

DELIMITER ;


CALL GetStallDetails(1);




### Procedure (2)



Create PROCEDURE GetTotalRevenue
AS
BEGIN
SELECT
    e.expo_name,
    COALESCE(SUM(t.ticket_price), 0) AS total_revenue_in_$
FROM
    expo e
LEFT JOIN
    ticket t ON e.expo_id = t.expo_id
GROUP BY
    e.expo_name;
 END
 
Exec GetTotalRevenue 




### Procedure (3)



CREATE PROCEDURE AddDurationHoursColumnToExpoTable
AS
BEGIN
    -- Add the duration_hours column to the expo table
    ALTER TABLE expo
    ADD duration_hours AS dbo.CalculateExpoDurationHours(expo_start_datetime, expo_end_datetime);
END;
--executing the procedure that calls the UDF
EXEC AddDurationHoursColumnToExpoTable;

select * from expo e 




### Procedure (4)





CREATE PROCEDURE GetSponsorInfo
    @SponsorID NVARCHAR(255)
AS
BEGIN
    -- Declare variables to store data
    DECLARE @SponsorName NVARCHAR(255)
    DECLARE @RoleNames NVARCHAR(MAX)
 
    -- Retrieve data based on the provided Sponsor ID
    SELECT
        @SponsorName = s.Sponsor_Name,
        @RoleNames = STRING_AGG(sr.Role_Name, ', ') WITHIN GROUP (ORDER BY sr.Role_Name)
    FROM
        Sponsor s
    JOIN
        Sponsor_Role sr ON s.Sponsor_ID = sr.sponsor_id
    WHERE
        s.sponsor_id = @SponsorID
    GROUP BY
        s.sponsor_name
 
    -- Return the retrieved data
    SELECT
        SponsorName = @SponsorName,
        RoleNames = @RoleNames
END
-- execution of stored procedure
exec GetSponsorInfo @sponsorID = ''




### Procedure (5)




CREATE PROCEDURE GetAttendeeDetails
    @AttendeeID INT,
    @OutputName VARCHAR(255) OUTPUT,
    @OutputEmail VARCHAR(255) OUTPUT
AS
BEGIN
    SELECT @OutputName = Name, @OutputEmail = Email
    FROM Attendee
    WHERE AttendeeID = @AttendeeID;
END;




### Procedure (6)




CREATE PROCEDURE InsertPayment
    @Amount DECIMAL(10, 2),
    @Method VARCHAR(50),
    @Status VARCHAR(20)
AS
BEGIN
    INSERT INTO Payment (Amount, Method, Status)
    VALUES (@Amount, @Method, @Status);
END;



### View(1)


CREATE VIEW AttendeeView AS
SELECT AttendeeID, Name, Email, Phone
FROM Attendee;
-- Executing the Stored Procedure
EXEC InsertPayment @Amount = 50.00, @Method = 'Credit Card', @Status = 'Completed';
-- Table-level Check Constraint for Payment
ALTER TABLE Payment
ADD CONSTRAINT CHK_PaymentAmount
CHECK (Amount >= 0);
-- View for Payment
CREATE VIEW PaymentView AS
SELECT PaymentID, Amount, Method, Status
FROM Payment;


### View(2)

CREATE VIEW PanelArtistReport AS
SELECT 
    p.panel_id,
    p.expo_id,
    p.panel_start_time,
    p.panel_end_time,
    a.artist_name,
    a.genre
FROM 
    panel p
JOIN 
    artist a ON p.panel_id = a.panel_id
GO


### View(3)


CREATE VIEW view_stall_staff_aggregated AS
SELECT 
    s.stall_id,
    s.booth_number,
    s.stall_size,
    s.expo_id,
    COUNT(st.staff_id) AS total_staff,
    GROUP_CONCAT(st.staff_name SEPARATOR ', ') AS staff_names
FROM 
    stall s
LEFT JOIN 
    staff st ON s.stall_id = st.stall_id
GROUP BY 
    s.stall_id, s.booth_number, s.stall_size, s.expo_id;
    
    
 ### View(4)   
    
    
    
    
    
CREATE VIEW expo_ticket_count AS
SELECT
    e.expo_name,
    COUNT(t.ticket_id) AS ticket_count
FROM
    expo e
JOIN
    ticket t ON e.expo_id = t.expo_id
GROUP BY
    e.expo_name;
 SELECT * FROM expo_ticket_count;



### View(5)


create VIEW SponsorRoleView AS
SELECT role_id, sponsor_id, role_name
FROM sponsor_role
where len(role_name) < 25;


### View(6)

CREATE VIEW vw_sponsor_count AS
SELECT
    COUNT(sponsor_id) AS sponsor_count
FROM
    sponsor;


### Function 

CREATE FUNCTION dbo.CalculateExpoDurationHours (
    @startDateTime DATETIME,
    @endDateTime DATETIME
)
RETURNS INT
AS
BEGIN
    DECLARE @durationHours INT;

    SET @durationHours = DATEDIFF(HOUR, @startDateTime, @endDateTime);

    RETURN @durationHours;
END;


CREATE PROCEDURE AddDurationHoursColumnToExpoTable
AS
BEGIN
    -- Add the duration_hours column to the expo table
    ALTER TABLE expo
    ADD duration_hours AS dbo.CalculateExpoDurationHours(expo_start_datetime, expo_end_datetime);
END;
--executing the procedure that calls the UDF
EXEC AddDurationHoursColumnToExpoTable;

select * from expo e 



### Trigger(1)

CREATE TABLE log_table (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    event_message TEXT,
    event_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Creating a DML trigger for the 'stall' table

DELIMITER //
CREATE TRIGGER before_stall_insert
BEFORE INSERT ON stall
FOR EACH ROW
BEGIN
    -- Insert a log entry
    INSERT INTO log_table (event_message)
    VALUES (CONCAT('New stall inserted with ID: ', NEW.stall_id));
END //
DELIMITER ;


-- Inserting a new row into the 'stall' table
INSERT INTO stall (stall_id, expo_id, booth_number, stall_size)
VALUES (11, 1, 'F104', '10x10');


-- Checking log entries
SELECT * FROM log_table;



### Trigger(2)

CREATE TRIGGER EnsureUniqueEmail
ON artist
AFTER INSERT
AS
BEGIN
    IF EXISTS (SELECT 1 FROM inserted i WHERE EXISTS (
        SELECT 1 FROM artist a WHERE a.artist_email = i.artist_email AND a.artist_id <> i.artist_id
    ))
    BEGIN
        RAISERROR ('Duplicate email detected.', 16, 1);
        ROLLBACK TRANSACTION;
    END
END
GO



### UDF

CREATE FUNCTION GetPanelDuration(@start_time DATETIME, @end_time DATETIME)
RETURNS INT
AS
BEGIN
    RETURN DATEDIFF(MINUTE, @start_time, @end_time);
END
GO

--Then, add a computed column to the panel table using this function.
ALTER TABLE panel
ADD duration_minutes AS dbo.GetPanelDuration(panel_start_time, panel_end_time);
GO



### Non-clustered indexs



-- Non-clustered Index for Attendee on Email column
CREATE NONCLUSTERED INDEX IX_Attendee_Email
ON Attendee (Email);



-- Non-clustered Index for Exhibitor on Type column
CREATE NONCLUSTERED INDEX IX_Exhibitor_Type
ON Exhibitor (Type);



-- Non-clustered Index for Artist on Genre column
CREATE NONCLUSTERED INDEX IX_Artist_Genre
ON Artist (Genre);



-- Non-clustered Index for Panel on DateAndTime column
CREATE NONCLUSTERED INDEX IX_Panel_DateAndTime
ON Panel (DateAndTime);



-- Non-clustered Index for Venue on Capacity column
CREATE NONCLUSTERED INDEX IX_Venue_Capacity
ON Venue (Capacity);




-- Non-clustered Index for Inventory on Price column
CREATE NONCLUSTERED INDEX IX_Inventory_Price
ON Inventory (Price);



-- Non-clustered Index for EventOrganizer on Name column
CREATE NONCLUSTERED INDEX IX_EventOrganizer_Name
ON EventOrganizer (Name);



-- Non-clustered Index for Ticket on Type column
CREATE NONCLUSTERED INDEX IX_Ticket_Type
ON Ticket (Type);




-- Non-clustered Index for Schedule on DateAndTime column
CREATE NONCLUSTERED INDEX IX_Schedule_DateAndTime
ON Schedule (DateAndTime);



-- Non-clustered Index for Payment on Amount column
CREATE NONCLUSTERED INDEX IX_Payment_Amount
ON Payment (Amount);









