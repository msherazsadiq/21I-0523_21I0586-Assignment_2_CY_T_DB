USE i210523_i210586_Assignment_2_CY_T_DB;


-- 17
SELECT TOP 5 O.OrderID, O.OrderNumber, O.CreationTimeStamp AS OrderCreationTime, C.CustomerID, C.CustomerName, C.ContactNo AS CustomerContactNo, 
	OI.Quantity AS OrderItemQuantity, P.ProductName AS OrderItemProductName, P.Price AS OrderItemProductPrice
FROM Orders AS O
JOIN Customer AS C ON O.Customer_ID = C.CustomerID
JOIN OrderItem AS OI ON O.OrderID = OI.Order_ID
JOIN Product AS P ON OI.Product_ID = P.ProductID
ORDER BY O.CreationTimeStamp DESC;

