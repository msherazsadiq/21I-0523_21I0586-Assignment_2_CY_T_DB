USE i210523_i210586_Assignment_2_CY_T_DB;


-- 21
SELECT C.CustomerID, C.CustomerName, O.OrderID, O.OrderNumber, O.CreationTimeStamp AS OrderCreationTime, A.AddressLines AS ShippingAddress, A.AddressCity,
    A.AddressState, A.Country, A.ZipCode, OI.Quantity AS OrderItemQuantity, P.ProductName AS OrderItemProductName, P.Price AS OrderItemProductPrice
FROM Orders AS O
LEFT JOIN Customer AS C ON O.Customer_ID = C.CustomerID
LEFT JOIN Address AS A ON O.OrderID = A.Customer_ID
LEFT JOIN OrderItem AS OI ON o.OrderID = OI.Order_ID
LEFT JOIN Product AS P ON OI.Product_ID = P.ProductID
ORDER BY O.OrderID;

