CREATE PROCEDURE GetMaxQuantity()
	SELECT MAX(Quantity) FROM Orders;


-- the instructions ask for a ManageBooking() procedure but that doesn't exist in the course. I assume they mean CheckBooking()
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