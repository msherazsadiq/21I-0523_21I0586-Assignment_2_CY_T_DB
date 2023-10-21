USE i210523_i210586_Assignment_2_CY_T_DB;


-- 15
SELECT s.SellerID, s.SellerName, COUNT(oi.Product_ID) AS TotalProductsSold
FROM Seller s
LEFT JOIN Product p ON s.SellerID = p.Seller_ID
LEFT JOIN OrderItem oi ON p.ProductID = oi.Product_ID
GROUP BY s.SellerID, s.SellerName
ORDER BY s.SellerID;

