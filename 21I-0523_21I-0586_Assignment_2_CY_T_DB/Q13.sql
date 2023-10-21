USE i210523_i210586_Assignment_2_CY_T_DB;

-- 13
SELECT DISTINCT C.CustomerID, C.CustomerName
FROM Customer AS C
INNER JOIN Orders AS O ON C.CustomerID = O.Customer_ID
WHERE O.CreationTimeStamp >= DATEADD(DAY, -30, GETDATE());
