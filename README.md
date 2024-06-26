# 21I-0523_21I0586-Assignment_2_CY_T_DB

<h3>ERD Explanation</h3>
We can create an Entity-Relationship Diagram (ERD) to visualize the relationships between the entities and their attributes in the e-commerce system. Here's a simplified ERD representation of the system:<br>

 <img align = "right" width = "500" height = "300" src = "https://github.com/msherazsadiq/21I-0523_21I0586-Assignment_2_CY_T_DB/assets/148572780/0440b0fa-cb66-4807-8c40-f8891e691c6f">
  
<br>**Let's break down the components of this ERD:**<br><br>
**1. Entities**:<br>
<ul>
  <li>Seller: Identified by a unique ID.</li>
  <li>Customer: Identified by a unique ID.</li>
  <li>Product: Each product has distinct attributes.</li>
  <li>Order: Has unique identifiers, order numbers, creation timestamps, and total amounts.</li>
  <li>OrderItem: Links to both the order and the respective product, tracking individual items in an order.</li>
  <li>ShoppingCart: Identified by a unique ID and is managed for each customer.</li>
  <li>CartItem: Links to the cart and the product, tracking the items in a customer's cart.</li>
  <li>Payment: Stores payment information, including unique identifiers, payment methods, amounts, creation timestamps, and references to the corresponding order.</li>
  <li>Review: Customers can leave reviews for products, with each review identified uniquely and linked to the product and customer.</li>
  <li>Address: Manages customer addresses, associated with customer IDs, and includes address details (address lines, city, state, zip code, country), with flags       indicating billing and/or shipping addresses.</li>
  <li>Inventory: Contains unique identifiers for each inventory record, references the associated product, tracks the quantity in stock, and includes a timestamp for the last stock update. It also includes attributes like the reorder threshold and the unit cost incurred by the seller for each unit of the product.</li>
</ul>
   
**2. Relationships:**<br>
<ul>
  <li>Seller contributes Product to the platform.</li>
  <li>Customer can create Order and also add products to their ShoppingCart.</li>
  <li>Each Order is associated with a Customer through foreign keys.</li>
  <li>Order has a one-to-many relationship with Order, tracking the individual items within an order.</li>
  <li>ShoppingCart is managed for each Customer, and it has a one-to-many relationship with Cart, tracking the items in a customer's cart.</li>
  <li>Payment is associated with an Order, indicating which payment is related to which order.</li>
  <li>Review is linked to both the Product and the Customer who left the review.</li>
  <li>Address is associated with a Customer, allowing customers to have multiple addresses (billing and/or shipping).</li>
  <li>Inventory references the Product, tracking the quantity in stock, and includes additional attributes related to inventory management.</li>
  
</ul>

This ERD provides a clear overview of the relationships between various entities in the e-commerce system, enabling a visual representation of how the data is structured and related within the system.

<h3>Q3. Write 4 Queries Other than this and write their Importance in the Comments why do you think they are important and where can they be used?</h3>
<ol>
  <li><b>Retrieve Top Selling Products</b> <br> This query is essential for e-commerce businesses to identify their top-selling products.</li>
  <li><b>Calculate Average Customer Order Value</b> <br> It can be used to identify high-value customers and tailor marketing efforts accordingly.</li>
  <li><b>Find Customers with Overdue Payments</b> <br> It helps in identifying customers with outstanding payments and facilitates debt collection and payment reminders.</li>
  <li><b>Calculate Product Review Ratings</b> <br> It provides insights into product quality and customer satisfaction. These ratings can be displayed on product pages to influence purchasing decisions.</li>
</ol>

<h3>Q4. List the top 5 customers who spent the most money</h3>
<img align = "right" width = "200" height = "100" src = "https://github.com/msherazsadiq/21I-0523_21I0586-Assignment_2_CY_T_DB/assets/148572780/2637444b-47bb-47d9-b046-af38f836ed38">

    SELECT TOP 5 Customer_ID, SUM(TotalAmount) AS TotalSpending
    FROM Orders
    GROUP BY Customer_ID
    Order BY TotalSpending DESC  

<ul>
  <li><b>Challenges</b><br>  Understanding the use of aggregate functions and GROUP BY clause </li>
  <li><b>Solution</b><br>  The GROUP BY clause is used to divide the rows into groups based on the specified column(s). In this query, SUM(TotalAmount) calculates the total spending for each customer, and GROUP BY Customer_ID groups the rows by customer ID. </li>
</ul>

<h3>Q5. Retrieve products with the highest average ratings </h3>
<img align = "right" width = "200" height = "100" src = "https://github.com/msherazsadiq/21I-0523_21I0586-Assignment_2_CY_T_DB/assets/148572780/6bead384-ae82-4e98-a3ac-69af292c6497">

    SELECT Product_ID, AVG(Rating) AS AverageRating
    FROM Review
    GROUP BY Product_ID
    HAVING AVG(Rating) = (SELECT MAX(AverageRating) 
    FROM (SELECT Product_ID, AVG(Rating) AS AverageRating FROM Review GROUP BY Product_ID) AS AvgRatings);  

<ul>
  <li><b>Challenges</b><br>  Understanding nested subqueries and their purpose and Correlating the subquery with the main query</li>
  <li><b>Solution</b><br>  In this case, the nested subquery is used to determine the maximum average rating among all products, which is then used to filter the main query results. The subquery's output is used as a filter for the main query. The HAVING clause in the main query compares the average rating of each product to the maximum average rating obtained from the subquery, ensuring that only products with the highest average rating are included in the final results. </li>
</ul>

<h3>Q6. Find customers who have made more than one purchase on the same day </h3>
<img align = "right" width = "300" height = "100" src = "https://github.com/msherazsadiq/21I-0523_21I0586-Assignment_2_CY_T_DB/assets/148572780/933a86e2-311d-4c70-9e89-c49baa28f07a">

    SELECT C.CustomerID, C.CustomerName, COUNT(O.OrderID) AS PurchaseCount
    FROM Customer AS C
    JOIN Orders AS O ON C.CustomerID = O.Customer_ID
    GROUP BY C.CustomerID, C.CustomerName, CAST(O.CreationTimeStamp AS DATE)
    HAVING COUNT(O.OrderID) > 1  

<ul>
  <li><b>Challenges</b><br> Combining data from multiple tables using JOIN</li>
  <li><b>Solution</b><br>  Understanding how to join tables using a common field to combine data from multiple sources. In this query, the Customer and Orders tables are joined on the CustomerID and Customer_ID fields, respectively, to associate customer information with their orders. </li>
</ul>

<h3>Q7. Calculate the total revenue for each product category </h3>
<img align = "right" width = "200" height = "100" src = "https://github.com/msherazsadiq/21I-0523_21I0586-Assignment_2_CY_T_DB/assets/148572780/40f0d27a-8a5b-46ff-bfe8-a796588fdac3">

    SELECT P.ProductCatagory, SUM(OI.Quantity * P.Price) AS TotalRevenue
    FROM Product AS P
    INNER JOIN OrderItem AS OI ON P.ProductID = OI.Product_ID
    INNER JOIN Orders AS O ON OI.Order_ID = O.OrderID
    GROUP BY P.ProductCatagory;

<ul>
  <li><b>Challenges</b><br> Understanding multiple joins and their relationships and Aggregating data across multiple tables</li>
  <li><b>Solution</b><br>  The concept of joining multiple tables using different join types. In this query, two inner joins are used to connect the Product, OrderItem, and Orders tables based on their respective IDs. To aggregate data from multiple tables using aggregate functions and GROUP BY. The query calculates total revenue by multiplying quantity and price from different tables and then groups the results by product category to provide a summarized overview. </li>
</ul>

<h3>Q8. List customers who have not reviewed any products </h3>
<img align = "right" width = "200" height = "200" src = "https://github.com/msherazsadiq/21I-0523_21I0586-Assignment_2_CY_T_DB/assets/148572780/81debd2b-55cd-468e-94ad-8106d886eab5">

    SELECT C.CustomerID, C.CustomerName
    FROM Customer AS C
    LEFT JOIN Review AS R ON C.CustomerID = R.Customer_ID
    WHERE R.ReviewID IS NULL;

<ul>
  <li><b>Challenges</b><br> Understanding the use of LEFT JOIN and filtering on NULL values</li>
  <li><b>Solution</b><br>  Recognize that LEFT JOIN retains all rows from the left table (Customer) and matches corresponding rows from the right table (Review). Filtering on NULL values in the right table identifies customers who have no matching reviews. This query aims to identify customers who have not written any reviews. It utilizes a LEFT JOIN to combine the Customer and Review tables and then filters the results based on NULL values in the Review table. </li>
</ul>


<h3>Q9.  Find products with quantities below the average quantity in stock </h3>
<img align = "right" width = "250" height = "300" src = "https://github.com/msherazsadiq/21I-0523_21I0586-Assignment_2_CY_T_DB/assets/148572780/c081ef9c-c0ba-49c7-a617-5c29811e371d">

    SELECT P.ProductID, P.ProductName, I.QuantityInStock
    FROM Product AS P
    JOIN Inventory AS I ON P.ProductID = I.Product_ID
    WHERE I.QuantityInStock < (SELECT AVG(QuantityInStock) FROM Inventory);


<ul>
  <li><b>Challenges</b><br> Using a subquery to compare values against an aggregate value</li>
  <li><b>Solution</b><br>  Recognize that the subquery calculates the average quantity in stock, and the WHERE clause filters the main query results based on that average. This query aims to identify products with a quantity in stock below the average quantity in stock. It utilizes a subquery to calculate the average quantity in stock and then filters the main query results based on that average. </li>
</ul>

<h3>Q10. Calculate the total number of orders for each customer and show only those with more than 5 orders. </h3>
<img align = "right" width = "300" height = "100" src = "https://github.com/msherazsadiq/21I-0523_21I0586-Assignment_2_CY_T_DB/assets/148572780/2d293a23-696e-489d-b4b9-c9aefd053b49">

    SELECT C.CustomerID, C.CustomerName, COUNT(O.OrderID) AS TotalOrders
    FROM Customer AS C
    JOIN Orders AS O ON c.CustomerID = O.Customer_ID
    GROUP BY C.CustomerID, C.CustomerName
    HAVING COUNT(O.OrderID) >= 5;

<ul>
  <li><b>Challenges</b><br> Combining data from multiple tables using JOIN and filtering based on aggregate values</li>
  <li><b>Solution</b><br>  Recognize that JOIN combines data from multiple tables based on a common field, and HAVING filters the results based on aggregate values calculated using GROUP BY. This query aims to identify customers who have placed at least five orders. It utilizes a JOIN to combine the Customer and Orders tables, groups the results by customer, and filters the results using HAVING to only include customers with five or more orders. </li>
</ul>

<h3>Q11. Retrieve the 3 most recent orders for a specific customer </h3>
<img align = "right" width = "300" height = "130" src = "https://github.com/msherazsadiq/21I-0523_21I0586-Assignment_2_CY_T_DB/assets/148572780/9a2f305f-ccfb-4c7b-8b24-3256447909e8">

    SELECT TOP 3 O.OrderID, O.OrderNumber, O.CreationTimeStamp, O.TotalAmount
    FROM Orders AS O
    INNER JOIN Customer AS C ON O.Customer_ID = C.CustomerID
    WHERE C.CustomerID = 3  -- Replace ... with the specific customer's ID
    ORDER BY O.CreationTimeStamp DESC;

<ul>
  <li><b>Challenges</b><br> Retrieving a specific number of records and sorting them based on a timestamp</li>
  <li><b>Solution</b><br>  Recognize that TOP limits the number of records retrieved, and ORDER BY DESC sorts the results in descending order based on the specified column. This query aims to retrieve the three most recent orders for a specific customer. It utilizes an INNER JOIN to combine the Orders and Customer tables, filters the results based on the customer ID, and sorts the results in descending order based on the CreationTimeStamp column to obtain the most recent orders. </li>
</ul>


<h3>Q12. List customers who have purchased products from at least two different sellers. </h3>
<img align = "right" width = "200" height = "100" src = "https://github.com/msherazsadiq/21I-0523_21I0586-Assignment_2_CY_T_DB/assets/148572780/10611f4b-4050-4f85-a539-8c3f39436eeb">

    SELECT C.CustomerID, C.CustomerName
    FROM Customer AS C
    JOIN Orders AS O ON C.CustomerID = O.Customer_ID
    JOIN OrderItem AS OI ON O.OrderID = OI.Order_ID
    JOIN Product AS P ON OI.Product_ID = P.ProductID
    GROUP BY C.CustomerID, C.CustomerName
    HAVING COUNT(DISTINCT P.Seller_ID) >= 2;

<ul>
  <li><b>Challenges</b><br> Identifying customers who have purchased from multiple sellers</li>
  <li><b>Solution</b><br>   Recognize that COUNT(DISTINCT) counts the unique values of a column, and HAVING filters the results based on that count. This query aims to identify customers who have purchased products from at least two different sellers. It utilizes multiple JOINs to combine the Customer, Orders, OrderItem, and Product tables, groups the results by customer, and filters the results using HAVING to only include customers who have purchased from two or more distinct sellers based on the Seller_ID column. This query involves understanding multiple joins, aggregating data, and filtering based on distinct values. </li>
</ul>


<h3>Q13. Find customers who have placed an order in the last 30 days.</h3>
<img align = "right" width = "300" height = "200" src = "https://github.com/msherazsadiq/21I-0523_21I0586-Assignment_2_CY_T_DB/assets/148572780/5341f334-cc66-4113-b0ed-c45feacf53ad">

    SELECT DISTINCT C.CustomerID, C.CustomerName
    FROM Customer AS C
    INNER JOIN Orders AS O ON C.CustomerID = O.Customer_ID
    WHERE O.CreationTimeStamp >= DATEADD(DAY, -30, GETDATE());

<ul>
  <li><b>Challenges</b><br> Identifying customers who have placed orders within the last 30 days</li>
  <li><b>Solution</b><br>  Recognize that DATEADD() modifies a date value, and WHERE filters the results based on the modified date. This query aims to identify customers who have placed orders within the last 30 days. It utilizes an INNER JOIN to combine the Customer and Orders tables and filters the results using WHERE to only include orders with a CreationTimeStamp within the last 30 days, calculated using DATEADD() and GETDATE(). This query involves understanding date manipulation, joining tables, and filtering based on date criteria. </li>
</ul>


<h3>Q14. List customers who have made a purchase in every product category </h3>
<img align = "right" width = "200" height = "100" src = "https://github.com/msherazsadiq/21I-0523_21I0586-Assignment_2_CY_T_DB/assets/148572780/5744afb8-31af-4e57-adab-57ed052a977d">

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


<ul>
  <li><b>Challenges</b><br> Identifying customers who have purchased products from all product categories</li>
  <li><b>Solution</b><br>  Recognize that the nested subquery calculates the total number of product categories, and the WHERE clause filters the main query results based on customers who have purchased from all categories. This query aims to identify customers who have purchased products from every product category available. It utilizes a nested subquery to determine the total number of distinct product categories and then filters the main query results to only include customers whose purchase history covers all product categories. This query involves understanding nested subqueries, correlating subquery results with the main query, and filtering based on aggregate values. </li>
</ul>


<h3>Q15. Calculate the total number of products sold by each seller </h3>
<img align = "right" width = "250" height = "400" src = "https://github.com/msherazsadiq/21I-0523_21I0586-Assignment_2_CY_T_DB/assets/148572780/03492b45-b549-4e64-91bf-7542601a8369">

    SELECT s.SellerID, s.SellerName, COUNT(oi.Product_ID) AS TotalProductsSold
    FROM Seller s
    LEFT JOIN Product p ON s.SellerID = p.Seller_ID
    LEFT JOIN OrderItem oi ON p.ProductID = oi.Product_ID
    GROUP BY s.SellerID, s.SellerName
    ORDER BY s.SellerID;

<ul>
  <li><b>Challenges</b><br> Counting products sold by each seller, including those with no sales</li>
  <li><b>Solution</b><br>  Recognize that LEFT JOIN includes all rows from the left table (Seller) and matches corresponding rows from the right tables (Product and OrderItem). COUNT() aggregates product IDs, and GROUP BY ensures counts are calculated for each seller. This query aims to count the total number of products sold by each seller, including sellers with no sales. It utilizes LEFT JOINs to combine the Seller, Product, and OrderItem tables, ensuring all sellers are included. COUNT() aggregates the product IDs, and GROUP BY groups the results by seller to provide individual product counts for each seller. </li>
</ul>


<h3>Q16. Retrieve the top 5 products with the highest sales in the last month </h3>
<img align = "right" width = "250" height = "200" src = "https://github.com/msherazsadiq/21I-0523_21I0586-Assignment_2_CY_T_DB/assets/148572780/bf7dec82-9f6a-4f52-98b2-d20d78fb7671">

    SELECT TOP 5 P.ProductID, P.ProductName, SUM(OI.Quantity) AS TotalSales
    FROM Product AS P
    JOIN OrderItem AS OI ON P.ProductID = OI.Product_ID
    JOIN Orders AS O ON OI.Order_ID = O.OrderID
    WHERE O.CreationTimeStamp >= DATEADD(MONTH, -1, GETDATE()) -- Filter orders from the last month
    GROUP BY P.ProductID, P.ProductName
    ORDER BY TotalSales DESC;

<ul>
  <li><b>Challenges</b><br> Identifying the top 5 best-selling products from the last month</li>
  <li><b>Solution</b><br>  Recognize that DATEADD() modifies a date value, SUM() aggregates quantities, and TOP limits the results to the specified number. This query aims to identify the top 5 best-selling products based on sales from the last month. It utilizes JOINs to combine the Product, OrderItem, and Orders tables, filters the results using WHERE to only include orders from the last month, calculates total sales using SUM(), and sorts the results in descending order based on total sales to identify the top 5 products. </li>
</ul>


<h3>Q17. Retrieve the latest 5 orders along with customer details and order items for each order. </h3>

    SELECT TOP 5 O.OrderID, O.OrderNumber, O.CreationTimeStamp AS OrderCreationTime, C.CustomerID, C.CustomerName, C.ContactNo AS CustomerContactNo, 
	   OI.Quantity AS OrderItemQuantity, P.ProductName AS OrderItemProductName, P.Price AS OrderItemProductPrice
    FROM Orders AS O
    JOIN Customer AS C ON O.Customer_ID = C.CustomerID
    JOIN OrderItem AS OI ON O.OrderID = OI.Order_ID
    JOIN Product AS P ON OI.Product_ID = P.ProductID
    ORDER BY O.CreationTimeStamp DESC;

<img align = "center" width = "1000" height = "200" src = "https://github.com/msherazsadiq/21I-0523_21I0586-Assignment_2_CY_T_DB/assets/148572780/aa9049d5-5fe0-4c51-9bc8-9ff2eb2ea86e">

<ul>
  <li><b>Challenges</b><br> Combining data from multiple tables to provide detailed order information</li>
  <li><b>Solution</b><br>  Recognize that JOIN combines data from multiple tables based on common fields, and aliases provide meaningful names for columns. This query aims to retrieve detailed information about the five most recent orders. It utilizes JOINs to combine the Orders, Customer, OrderItem, and Product tables, selecting relevant information from each table and using aliases to provide clear column names. The results are sorted in descending order based on order creation time to obtain the five most recent orders. </li>
</ul>


<h3>Q18. Retrieve customers who have made purchases in every product category, along with the total number of categories they have purchased from. </h3>
<img align = "right" width = "400" height = "200" src = "https://github.com/msherazsadiq/21I-0523_21I0586-Assignment_2_CY_T_DB/assets/148572780/b670c4b7-b5ff-4e8c-8c32-359f6806b597">

    SELECT C.CustomerID, C.CustomerName, COUNT(DISTINCT P.ProductCatagory) AS TotalCatagoriesPurchased
    FROM Customer AS C
    JOIN Orders AS O ON C.CustomerID = O.Customer_ID
    JOIN OrderItem AS OI ON O.OrderID = OI.Order_ID
    JOIN Product AS P ON OI.Product_ID = P.ProductID
    GROUP BY C.CustomerID, C.CustomerName
    HAVING COUNT(DISTINCT P.ProductCatagory) = (SELECT COUNT(DISTINCT ProductCatagory) FROM Product)

<ul>
  <li><b>Challenges</b><br> Identifying customers who have purchased products from all product categories</li>
  <li><b>Solution</b><br>  Recognize that the subquery calculates the total number of product categories, and the HAVING clause filters the main query results based on customers who have purchased from all categories. This query aims to identify customers who have purchased products from every product category available. It utilizes a subquery to determine the total number of distinct product categories and then filters the main query results to only include customers whose purchase history covers all product categories. This query involves understanding subqueries, correlating subquery results with the main query, and filtering based on aggregate values. </li>
</ul>


<h3>Q19. List products that have never been reviewed and have quantities in stock greater than zero, along with the average rating for their category.  </h3>
<img align = "right" width = "450" height = "200" src = "https://github.com/msherazsadiq/21I-0523_21I0586-Assignment_2_CY_T_DB/assets/148572780/707658fc-e74c-4077-aa41-2dc2d9369a4a">

    SELECT P.ProductID, P.ProductName, P.ProductCatagory, I.QuantityInStock, AVG(R.Rating) AS AverageCategoryRating
    FROM Product AS P
    LEFT JOIN Review AS R ON P.ProductID = R.Product_ID
    JOIN Inventory AS I ON p.ProductID = I.Product_ID
    WHERE R.ReviewID IS NULL AND I.QuantityInStock > 0
    GROUP BY P.ProductID, P.ProductName, P.ProductCatagory, I.QuantityInStock;

<ul>
  <li><b>Challenges</b><br> Combining data from multiple tables and filtering based on multiple criteria</li>
  <li><b>Solution</b><br>  Recognize that JOIN combines data from multiple tables based on common fields, and WHERE filters the results based on specified conditions. This query aims to identify products with no reviews and a positive quantity in stock, along with their average category rating. It utilizes LEFT JOIN to combine the Product, Review, and Inventory tables, ensuring all products are included. WHERE filters the results to only include products with no reviews and a positive quantity in stock. AVG() calculates the average category rating, and GROUP BY groups the results by product to provide individual average ratings for each product. </li>
</ul>


<h3>Q20.  Find the top 3 products with the highest total sales, including details of the reviews for each product. </h3>

    SELECT TOP 3 P.ProductID, P.ProductName, SUM(oi.Quantity) AS TotalSales, R.ReviewID, R.Rating, R.Comment
    FROM Product AS P
    JOIN OrderItem AS OI ON P.ProductID = OI.Product_ID
    LEFT JOIN Review AS R ON P.ProductID = R.Product_ID
    GROUP BY P.ProductID, P.ProductName, R.ReviewID, R.Rating, R.Comment
    ORDER BY TotalSales DESC;

<img align = "center" width = "700" height = "200" src = "https://github.com/msherazsadiq/21I-0523_21I0586-Assignment_2_CY_T_DB/assets/148572780/e2e7070c-5fc5-4191-b42b-c642434774d3">

<ul>
  <li><b>Challenges</b><br> Combining data from multiple tables and retrieving top products with their reviews</li>
  <li><b>Solution</b><br>  Recognize that JOIN combines data from multiple tables based on common fields, and TOP limits the results to the specified number. This query aims to identify the top 3 best-selling products along with their reviews. It utilizes JOINs to combine the Product, OrderItem, and Review tables, calculates total sales using SUM(), and sorts the results in descending order based on total sales to identify the top 3 products. LEFT JOIN ensures that products with no reviews are still included. </li>
</ul>


<h3>Q21. Retrieve all customers who have placed orders, and include details of their orders, even for orders with no associated customers. Include information about the shipping addresses for each order.  </h3>

    SELECT C.CustomerID, C.CustomerName, O.OrderID, O.OrderNumber, O.CreationTimeStamp AS OrderCreationTime, A.AddressLines AS ShippingAddress, A.AddressCity,
    A.AddressState, A.Country, A.ZipCode, OI.Quantity AS OrderItemQuantity, P.ProductName AS OrderItemProductName, P.Price AS OrderItemProductPrice
    FROM Orders AS O
    LEFT JOIN Customer AS C ON O.Customer_ID = C.CustomerID
    LEFT JOIN Address AS A ON O.OrderID = A.Customer_ID
    LEFT JOIN OrderItem AS OI ON o.OrderID = OI.Order_ID
    LEFT JOIN Product AS P ON OI.Product_ID = P.ProductID
    ORDER BY O.OrderID;

<img align = "center" width = "1000" height = "500" src = "https://github.com/msherazsadiq/21I-0523_21I0586-Assignment_2_CY_T_DB/assets/148572780/4a503f2e-2f9f-4bb8-8f61-94f380ea64f6">

<ul>
  <li><b>Challenges</b><br> Combining data from multiple tables to provide comprehensive order details</li>
  <li><b>Solution</b><br>  Recognize that LEFT JOIN includes all rows from the left table (Orders) and matches corresponding rows from the other tables. Aliases provide meaningful names for columns. This query aims to retrieve comprehensive details about orders, including customer information, shipping address, order items, and product details. It utilizes LEFT JOINs to combine the Orders, Customer, Address, OrderItem, and Product tables, ensuring all orders are included even if some data is missing. Aliases are used to provide clear column names for the retrieved data. The results are sorted by order ID to maintain order sequence. </li>
</ul>


<h3>Q22. Write an SQL query to retrieve the total number of products and the total revenue for each product category. Include products that may not have been sold. Additionally, order the product in descending order based on total revenue. </h3>
<img align = "right" width = "400" height = "200" src = "https://github.com/msherazsadiq/21I-0523_21I0586-Assignment_2_CY_T_DB/assets/148572780/953dfbd6-b4e3-47f2-9f5b-3e5b82de83cf">

    SELECT P.ProductCatagory, COUNT(P.ProductID) AS TotalProducts, SUM(ISNULL(OI.Quantity, 0) + ISNULL(INV.QuantityInStock, 0) * P.Price) AS TotalRevenue
    FROM Product AS P
    LEFT JOIN OrderItem AS OI ON P.ProductID = OI.Product_ID
    LEFT JOIN Inventory AS INV ON P.ProductID = INV.Product_ID
    GROUP BY P.ProductCatagory
    ORDER BY TotalRevenue DESC;

<ul>
  <li><b>Challenges</b><br> Handling NULL values and combining data from multiple tables to calculate revenue</li>
  <li><b>Solution</b><br>  Recognize that ISNULL() replaces NULL values with a specified value, and JOIN combines data from multiple tables based on common fields. This query aims to calculate total revenue for each product category, considering both sold and unsold products. It utilizes LEFT JOINs to combine the Product, OrderItem, and Inventory tables, ensuring all products are included. ISNULL() replaces NULL values with 0 to ensure accurate calculations for products with no sales or no inventory. SUM() aggregates the product quantity and price to calculate total revenue, and GROUP BY groups the results by product category to provide individual revenue figures for each category.

 </li>
</ul>


<h3>Q23. Write a SQL query to retrieve detailed information about products and their associated orders. Include the product ID, product name, product category, order quantity, order price, and total revenue for each product. Ensure that products that have not been sold are also included in the result. Filter the results to include only products in the 'Electronics' category with order quantities between 5 and 10. Additionally, order results in descending order based on total revenue </h3>

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

<img align = "center" width = "700" height = "200" src = "https://github.com/msherazsadiq/21I-0523_21I0586-Assignment_2_CY_T_DB/assets/148572780/b227f8ad-4a35-4f56-b922-b8466bf042f3">

<ul>
  <li><b>Challenges</b><br> Handling NULL values and filtering based on multiple criteria</li>
  <li><b>Solution</b><br>  Recognize that ISNULL() replaces NULL values with a specified value, and WHERE filters the results based on specified conditions. This query aims to identify electronic products with order quantities between 5 and 10 and calculate their total revenue. It utilizes a LEFT JOIN to combine the Product and OrderItem tables, ensuring all products are included. ISNULL() replaces NULL values with 0 to ensure accurate calculations for products with no sales. WHERE filters the results to only include electronic products with order quantities between 5 and 10. Total revenue is calculated by multiplying order quantity and price, and the results are sorted in descending order based on total revenue. </li>
</ul>


<h3>Q24. Retrieve product categories with the total number of products sold, ordered in descending order by the total number of products sold, and show only categories with more than 10 products sold. </h3>
<img align = "right" width = "250" height = "100" src = "https://github.com/msherazsadiq/21I-0523_21I0586-Assignment_2_CY_T_DB/assets/148572780/c05f0cce-f047-411c-ac04-60c7f7ab62f6">

    SELECT
        p.ProductCatagory,
        COUNT(oi.Quantity) AS TotalProductsSold
    FROM Product p
    LEFT JOIN OrderItem oi ON p.ProductID = oi.Product_ID
    GROUP BY p.ProductCatagory
    HAVING COUNT(oi.Quantity) > 10
    ORDER BY TotalProductsSold DESC;

<ul>
  <li><b>Challenges</b><br> Aggregating product sales and filtering based on sales count</li>
  <li><b>Solution</b><br>  Recognize that COUNT() aggregates product quantities, and HAVING filters the aggregated results based on specified conditions. This query aims to identify product categories with more than 10 products sold. It utilizes a LEFT JOIN to combine the Product and OrderItem tables, ensuring all product categories are included. COUNT() aggregates the product quantities, and HAVING filters the results to only include categories with more than 10 products sold. The results are sorted in descending order based on the total number of products sold. </li>
</ul>


<h3>Q25. Retrieve customers with the total number of orders they have placed, ordered in descending order by the total number of orders, and show only customers who have placed more than 5 orders.  </h3>
<img align = "right" width = "450" height = "200" src = "https://github.com/msherazsadiq/21I-0523_21I0586-Assignment_2_CY_T_DB/assets/148572780/025c32f2-e436-4355-980b-ad334b4f37b4">

    SELECT
        c.CustomerID,
        c.CustomerName,
        COUNT(o.OrderID) AS TotalOrdersPlaced
    FROM Customer c
    LEFT JOIN Orders o ON c.CustomerID = o.Customer_ID
    GROUP BY c.CustomerID, c.CustomerName
    HAVING COUNT(o.OrderID) > 5
    ORDER BY TotalOrdersPlaced DESC;

<ul>
  <li><b>Challenges</b><br> Aggregating customer orders and filtering based on order count</li>
  <li><b>Solution</b><br>  Recognize that COUNT() aggregates order IDs and HAVING filters the aggregated results based on specified conditions. This query aims to identify customers who have placed more than 5 orders. It utilizes a LEFT JOIN to combine the Customer and Orders tables, ensuring all customers are included. COUNT() aggregates the order IDs and HAVING filters the results to only include customers with more than 5 orders placed. The results are sorted in descending order based on the total number of orders placed. </li>
</ul>


 










