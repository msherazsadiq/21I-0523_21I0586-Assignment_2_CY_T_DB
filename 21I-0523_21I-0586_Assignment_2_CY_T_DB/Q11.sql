USE i210523_i210586_Assignment_2_CY_T_DB;

-- 11
SELECT TOP 3 O.OrderID, O.OrderNumber, O.CreationTimeStamp, O.TotalAmount
FROM Orders AS O
INNER JOIN Customer AS C ON O.Customer_ID = C.CustomerID
WHERE C.CustomerID = 3  -- Replace ... with the specific customer's ID
ORDER BY O.CreationTimeStamp DESC;


