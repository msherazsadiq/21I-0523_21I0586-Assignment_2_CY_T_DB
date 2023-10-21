USE i210523_i210586_Assignment_2_CY_T_DB;


-- 25
SELECT
    c.CustomerID,
    c.CustomerName,
    COUNT(o.OrderID) AS TotalOrdersPlaced
FROM Customer c
LEFT JOIN Orders o ON c.CustomerID = o.Customer_ID
GROUP BY c.CustomerID, c.CustomerName
HAVING COUNT(o.OrderID) > 5
ORDER BY TotalOrdersPlaced DESC;

