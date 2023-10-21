USE i210523_i210586_Assignment_2_CY_T_DB;

-- 9
SELECT P.ProductID, P.ProductName, I.QuantityInStock
FROM Product AS P
JOIN Inventory AS I ON P.ProductID = I.Product_ID
WHERE I.QuantityInStock < (SELECT AVG(QuantityInStock) FROM Inventory);
