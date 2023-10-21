USE i210523_i210586_Assignment_2_CY_T_DB;

-- 6
SELECT C.CustomerID, C.CustomerName, COUNT(O.OrderID) AS PurchaseCount
FROM Customer AS C
JOIN Orders AS O ON C.CustomerID = O.Customer_ID
GROUP BY C.CustomerID, C.CustomerName, CAST(O.CreationTimeStamp AS DATE)
HAVING COUNT(O.OrderID) > 1
