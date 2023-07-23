CREATE VIEW OrdersView AS
SELECT OrderID, Quantity, TotalCost 
FROM Orders
WHERE Quantity > 2;

SELECT * FROM OrdersView;


SELECT Customers.CustomerID, Customers.Name AS FullName, Orders.OrderID, Orders.TotalCost AS Cost, Menu.Name AS MenuName, MenuItems.Name AS CourseName
FROM Orders 
JOIN Customers ON Customers.CustomerID = Orders.CustomerID 
JOIN Menu ON Menu.MenuID = Orders.MenuID
JOIN MenuItems ON Menu.MenuItemID = MenuItems.MenuItemID
WHERE Orders.TotalCost > 150;


SELECT Name FROM Menu WHERE MenuID = ANY (SELECT MenuID FROM Orders WHERE Quantity > 2);


CREATE PROCEDURE GetMaxQuantity()
	SELECT MAX(Quantity) FROM Orders;

CALL GetMaxQuantity();


PREPARE GetOrderDetail FROM 'SELECT OrderID, Quantity, TotalCost FROM Orders WHERE CustomerID = ?';

SET @id = 1;
EXECUTE GetOrderDetail USING @id;


DELIMITER //
CREATE PROCEDURE CancelOrder(IN OrderIDInput INT)
	BEGIN
		DECLARE rows_affected INT;
		DELETE FROM Orders WHERE OrderID = OrderIDInput;
		SET rows_affected = ROW_COUNT();
		IF rows_affected = 1 THEN
			SELECT CONCAT('Order ', OrderIDInput, ' is cancelled') AS Confirmation;
		END IF;
	END //
DELIMITER ;

CALL CancelOrder(5);