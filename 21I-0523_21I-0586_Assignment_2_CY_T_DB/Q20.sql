USE i210523_i210586_Assignment_2_CY_T_DB;


-- 20
SELECT TOP 3 P.ProductID, P.ProductName, SUM(oi.Quantity) AS TotalSales, R.ReviewID, R.Rating, R.Comment
FROM Product AS P
JOIN OrderItem AS OI ON P.ProductID = OI.Product_ID
LEFT JOIN Review AS R ON P.ProductID = R.Product_ID
GROUP BY P.ProductID, P.ProductName, R.ReviewID, R.Rating, R.Comment
ORDER BY TotalSales DESC;


