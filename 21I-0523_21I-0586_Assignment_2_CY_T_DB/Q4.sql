USE i210523_i210586_Assignment_2_CY_T_DB;


-- 4
SELECT TOP 5 Customer_ID, SUM(TotalAmount) AS TotalSpending
FROM Orders
GROUP BY Customer_ID
Order BY TotalSpending DESC