USE i210523_i210586_Assignment_2_CY_T_DB;


-- 3
	-- Retrieve Top Selling Products (This query is essential for e-commerce businesses to identify their top-selling products).
		SELECT P.ProductID, P.ProductName, SUM(OI.Quantity) AS TotalSold
		FROM OrderItem OI
		JOIN Product P ON OI.Product_ID = P.ProductID
		GROUP BY P.ProductID, P.ProductName

	-- Calculate Average Customer Order Value (It can be used to identify high-value customers and tailor marketing efforts accordingly).
		SELECT Customer_ID, AVG(TotalAmount) AS AvgOrderValue
		FROM Orders
		GROUP BY Customer_ID;

	--  Find Customers with Overdue Payments ( It helps in identifying customers with outstanding payments and facilitates debt collection and payment reminders).
		SELECT O.Customer_ID, SUM(P.Amount) AS TotalPaid
		FROM Orders AS O
		JOIN Payment AS P ON O.OrderID = P.Order_ID
		GROUP BY O.Customer_ID
		HAVING SUM(P.Amount) > 0;

	-- Calculate Product Review Ratings ( It provides insights into product quality and customer satisfaction. These ratings can be displayed on product pages to influence purchasing decisions).
		SELECT Product_ID, AVG(Rating) AS AvgRating
		FROM Review
		GROUP BY Product_ID;
