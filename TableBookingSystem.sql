INSERT INTO Bookings (BookingID, Date, TableNumber)
VALUES 
	(1, '2022-10-10', 5, 1),
	(2, '2022-11-12', 3, 3),
	(3, '2022-10-11', 2, 2),
    (4, '2022-10-13', 2, 1);

DELIMITER //
CREATE PROCEDURE CheckBooking(IN DateInput DATE, IN TableNumberInput INT)
	BEGIN
		DECLARE existsCount INT;
		SELECT COUNT(*) INTO existsCount FROM Bookings WHERE Date = DateInput AND TableNumber = TableNumberInput;
		IF existsCount > 0 THEN
			SELECT CONCAT('Table ', TableNumberInput, ' is already booked') AS 'Booking status';
		END IF;
    END // 
DELIMITER ;


DELIMITER //
CREATE PROCEDURE AddValidBooking(IN DateInput DATE, IN TableNumberInput INT)
	BEGIN
		DECLARE commit_flag BOOLEAN DEFAULT TRUE;
		DECLARE existingBooking INT;

		START TRANSACTION;
			SELECT COUNT(*) INTO existingBooking
            FROM Bookings 
            WHERE Date = DateInput AND TableNumber = TableNumberInput;
            
            IF existingBooking = 0 THEN 
				INSERT INTO Bookings (Date, TableNumber)
				VALUES (DateInput, TableNumberInput);
			ELSE 
				SET commit_flag = FALSE;
			END IF;
            
            IF commit_flag THEN
				COMMIT;
			ELSE 
				ROLLBACK;
                SELECT CONCAT('Table ', TableNumberInput, ' is already booked - booking cancelled') AS 'Booking status';
			END IF;
	END // 
DELIMITER ;


DELIMITER //
CREATE PROCEDURE AddBooking(BookingIDInput INT, CustomerIDInput INT, Date DATE, TableNumber INT)
	BEGIN
		INSERT INTO Bookings (BookingID, CustomerID, Date, TableNumber)
		VALUES (BookingIDInput, CustomerIDInput, Date, TableNumber);
		SELECT 'New booking added' AS Confirmation;
	END //
DELIMITER ;


DELIMITER //
CREATE PROCEDURE UpdateBooking(BookingIDInput INT, DateInput DATE)
	BEGIN
		UPDATE Bookings SET Date = DateInput
		WHERE BookingID = BookingIDInput;
		SELECT CONCAT('Booking ', BookingIDInput, ' updated') AS Confirmation;
	END //
DELIMITER ;


DELIMITER //
CREATE PROCEDURE CancelBooking(BookingIDInput INT)
	BEGIN
		DELETE FROM Bookings
		WHERE BookingID = BookingIDInput;
		SELECT CONCAT('Booking ', BookingIDInput, ' cancelled') AS Confirmation;
	END //
DELIMITER ;