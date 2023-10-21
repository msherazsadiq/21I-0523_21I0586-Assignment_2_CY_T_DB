USE i210523_i210586_Assignment_2_CY_T_DB;


-- 19
SELECT P.ProductID, P.ProductName, P.ProductCatagory, I.QuantityInStock, AVG(R.Rating) AS AverageCategoryRating
FROM Product AS P
LEFT JOIN Review AS R ON P.ProductID = R.Product_ID
JOIN Inventory AS I ON p.ProductID = I.Product_ID
WHERE R.ReviewID IS NULL AND I.QuantityInStock > 0
GROUP BY P.ProductID, P.ProductName, P.ProductCatagory, I.QuantityInStock;

