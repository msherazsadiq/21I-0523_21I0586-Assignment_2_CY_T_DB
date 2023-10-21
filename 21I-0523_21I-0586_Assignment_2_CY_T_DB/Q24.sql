USE i210523_i210586_Assignment_2_CY_T_DB;


-- 24
SELECT
    p.ProductCatagory,
    COUNT(oi.Quantity) AS TotalProductsSold
FROM Product p
LEFT JOIN OrderItem oi ON p.ProductID = oi.Product_ID
GROUP BY p.ProductCatagory
HAVING COUNT(oi.Quantity) > 10
ORDER BY TotalProductsSold DESC;

