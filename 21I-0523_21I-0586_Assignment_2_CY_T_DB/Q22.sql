USE i210523_i210586_Assignment_2_CY_T_DB;


-- 22
SELECT P.ProductCatagory, COUNT(P.ProductID) AS TotalProducts, SUM(ISNULL(OI.Quantity, 0) + ISNULL(INV.QuantityInStock, 0) * P.Price) AS TotalRevenue
FROM Product AS P
LEFT JOIN OrderItem AS OI ON P.ProductID = OI.Product_ID
LEFT JOIN Inventory AS INV ON P.ProductID = INV.Product_ID
GROUP BY P.ProductCatagory
ORDER BY TotalRevenue DESC;
