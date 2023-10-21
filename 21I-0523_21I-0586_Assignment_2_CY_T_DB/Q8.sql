USE i210523_i210586_Assignment_2_CY_T_DB;

-- 8
SELECT C.CustomerID, C.CustomerName
FROM Customer AS C
LEFT JOIN Review AS R ON C.CustomerID = R.Customer_ID
WHERE R.ReviewID IS NULL;
