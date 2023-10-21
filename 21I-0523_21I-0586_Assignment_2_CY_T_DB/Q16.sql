USE i210523_i210586_Assignment_2_CY_T_DB;


-- 16
SELECT TOP 5 P.ProductID, P.ProductName, SUM(OI.Quantity) AS TotalSales
FROM Product AS P
JOIN OrderItem AS OI ON P.ProductID = OI.Product_ID
JOIN Orders AS O ON OI.Order_ID = O.OrderID
WHERE O.CreationTimeStamp >= DATEADD(MONTH, -1, GETDATE()) -- Filter orders from the last month
GROUP BY P.ProductID, P.ProductName
ORDER BY TotalSales DESC;

