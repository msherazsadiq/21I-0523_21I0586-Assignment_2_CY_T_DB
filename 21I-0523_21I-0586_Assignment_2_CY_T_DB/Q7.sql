USE i210523_i210586_Assignment_2_CY_T_DB;

-- 7
SELECT P.ProductCatagory, SUM(OI.Quantity * P.Price) AS TotalRevenue
FROM Product AS P
INNER JOIN OrderItem AS OI ON P.ProductID = OI.Product_ID
INNER JOIN Orders AS O ON OI.Order_ID = O.OrderID
GROUP BY P.ProductCatagory;
