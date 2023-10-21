USE i210523_i210586_Assignment_2_CY_T_DB;


-- 18
SELECT C.CustomerID, C.CustomerName, COUNT(DISTINCT P.ProductCatagory) AS TotalCatagoriesPurchased
FROM Customer AS C
JOIN Orders AS O ON C.CustomerID = O.Customer_ID
JOIN OrderItem AS OI ON O.OrderID = OI.Order_ID
JOIN Product AS P ON OI.Product_ID = P.ProductID
GROUP BY C.CustomerID, C.CustomerName
HAVING COUNT(DISTINCT P.ProductCatagory) = (SELECT COUNT(DISTINCT ProductCatagory) FROM Product)

