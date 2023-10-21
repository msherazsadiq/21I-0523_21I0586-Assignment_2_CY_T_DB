USE i210523_i210586_Assignment_2_CY_T_DB;


-- 14
SELECT C.CustomerID, C.CustomerName
FROM Customer AS C
WHERE (
    SELECT COUNT(DISTINCT P.ProductCatagory)
    FROM Orders AS O
    JOIN OrderItem AS OI ON O.OrderID = OI.Order_ID
    JOIN Product AS P ON OI.Product_ID = P.ProductID
    WHERE O.Customer_ID = C.CustomerID
) = (
    SELECT COUNT(DISTINCT ProductCatagory)
    FROM Product
);

