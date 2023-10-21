USE i210523_i210586_Assignment_2_CY_T_DB;


-- 10
SELECT C.CustomerID, C.CustomerName, COUNT(O.OrderID) AS TotalOrders
FROM Customer AS C
JOIN Orders AS O ON c.CustomerID = O.Customer_ID
GROUP BY C.CustomerID, C.CustomerName
HAVING COUNT(O.OrderID) >= 5;



