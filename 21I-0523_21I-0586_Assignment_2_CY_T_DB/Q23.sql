USE i210523_i210586_Assignment_2_CY_T_DB;


-- 23
SELECT
    p.ProductID,
    p.ProductName,
    p.ProductCatagory,
    ISNULL(oi.Quantity, 0) AS OrderQuantity,
    p.Price AS OrderPrice,
    ISNULL(oi.Quantity, 0) * p.Price AS TotalRevenue
FROM Product p
LEFT JOIN OrderItem oi ON p.ProductID = oi.Product_ID
WHERE p.ProductCatagory = 'Electronics'
    AND oi.Quantity BETWEEN 5 AND 10
ORDER BY TotalRevenue DESC;
