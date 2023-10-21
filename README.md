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
  <li><b>Challenges</b><br> Understanding multiple joins and their relationships and Aggregating data across multiple tables</li>
  <li><b>Solution</b><br>  The concept of joining multiple tables using different join types. In this query, two inner joins are used to connect the Product, OrderItem, and Orders tables based on their respective IDs. To aggregate data from multiple tables using aggregate functions and GROUP BY. The query calculates total revenue by multiplying quantity and price from different tables and then groups the results by product category to provide a summarized overview. </li>
</ul>

<h3>Q9.  Find products with quantities below the average quantity in stock </h3>
<img align = "right" width = "200" height = "200" src = "https://github.com/msherazsadiq/21I-0523_21I0586-Assignment_2_CY_T_DB/assets/148572780/c081ef9c-c0ba-49c7-a617-5c29811e371d">

    SELECT P.ProductID, P.ProductName, I.QuantityInStock
    FROM Product AS P
    JOIN Inventory AS I ON P.ProductID = I.Product_ID
    WHERE I.QuantityInStock < (SELECT AVG(QuantityInStock) FROM Inventory);


<ul>
  <li><b>Challenges</b><br> Understanding multiple joins and their relationships and Aggregating data across multiple tables</li>
  <li><b>Solution</b><br>  The concept of joining multiple tables using different join types. In this query, two inner joins are used to connect the Product, OrderItem, and Orders tables based on their respective IDs. To aggregate data from multiple tables using aggregate functions and GROUP BY. The query calculates total revenue by multiplying quantity and price from different tables and then groups the results by product category to provide a summarized overview. </li>
</ul>

<h3>Q10. Calculate the total number of orders for each customer and show only those with more than 5 orders. </h3>
<img align = "right" width = "300" height = "100" src = "https://github.com/msherazsadiq/21I-0523_21I0586-Assignment_2_CY_T_DB/assets/148572780/2d293a23-696e-489d-b4b9-c9aefd053b49">

    SELECT C.CustomerID, C.CustomerName, COUNT(O.OrderID) AS TotalOrders
    FROM Customer AS C
    JOIN Orders AS O ON c.CustomerID = O.Customer_ID
    GROUP BY C.CustomerID, C.CustomerName
    HAVING COUNT(O.OrderID) >= 5;

<ul>
  <li><b>Challenges</b><br> Understanding multiple joins and their relationships and Aggregating data across multiple tables</li>
  <li><b>Solution</b><br>  The concept of joining multiple tables using different join types. In this query, two inner joins are used to connect the Product, OrderItem, and Orders tables based on their respective IDs. To aggregate data from multiple tables using aggregate functions and GROUP BY. The query calculates total revenue by multiplying quantity and price from different tables and then groups the results by product category to provide a summarized overview. </li>
</ul>

<h3>Q11. Retrieve the 3 most recent orders for a specific customer </h3>
<img align = "right" width = "200" height = "100" src = "https://github.com/msherazsadiq/21I-0523_21I0586-Assignment_2_CY_T_DB/assets/148572780/9a2f305f-ccfb-4c7b-8b24-3256447909e8">

    SELECT TOP 3 O.OrderID, O.OrderNumber, O.CreationTimeStamp, O.TotalAmount
    FROM Orders AS O
    INNER JOIN Customer AS C ON O.Customer_ID = C.CustomerID
    WHERE C.CustomerID = 3  -- Replace ... with the specific customer's ID
    ORDER BY O.CreationTimeStamp DESC;

<ul>
  <li><b>Challenges</b><br> Understanding multiple joins and their relationships and Aggregating data across multiple tables</li>
  <li><b>Solution</b><br>  The concept of joining multiple tables using different join types. In this query, two inner joins are used to connect the Product, OrderItem, and Orders tables based on their respective IDs. To aggregate data from multiple tables using aggregate functions and GROUP BY. The query calculates total revenue by multiplying quantity and price from different tables and then groups the results by product category to provide a summarized overview. </li>
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
  <li><b>Challenges</b><br> Understanding multiple joins and their relationships and Aggregating data across multiple tables</li>
  <li><b>Solution</b><br>  The concept of joining multiple tables using different join types. In this query, two inner joins are used to connect the Product, OrderItem, and Orders tables based on their respective IDs. To aggregate data from multiple tables using aggregate functions and GROUP BY. The query calculates total revenue by multiplying quantity and price from different tables and then groups the results by product category to provide a summarized overview. </li>
</ul>


<h3>Q13. Find customers who have placed an order in the last 30 days.</h3>
<img align = "right" width = "200" height = "100" src = "https://github.com/msherazsadiq/21I-0523_21I0586-Assignment_2_CY_T_DB/assets/148572780/5341f334-cc66-4113-b0ed-c45feacf53ad">

    SELECT DISTINCT C.CustomerID, C.CustomerName
    FROM Customer AS C
    INNER JOIN Orders AS O ON C.CustomerID = O.Customer_ID
    WHERE O.CreationTimeStamp >= DATEADD(DAY, -30, GETDATE());

<ul>
  <li><b>Challenges</b><br> Understanding multiple joins and their relationships and Aggregating data across multiple tables</li>
  <li><b>Solution</b><br>  The concept of joining multiple tables using different join types. In this query, two inner joins are used to connect the Product, OrderItem, and Orders tables based on their respective IDs. To aggregate data from multiple tables using aggregate functions and GROUP BY. The query calculates total revenue by multiplying quantity and price from different tables and then groups the results by product category to provide a summarized overview. </li>
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
  <li><b>Challenges</b><br> Understanding multiple joins and their relationships and Aggregating data across multiple tables</li>
  <li><b>Solution</b><br>  The concept of joining multiple tables using different join types. In this query, two inner joins are used to connect the Product, OrderItem, and Orders tables based on their respective IDs. To aggregate data from multiple tables using aggregate functions and GROUP BY. The query calculates total revenue by multiplying quantity and price from different tables and then groups the results by product category to provide a summarized overview. </li>
</ul>


<h3>Q15. Calculate the total number of products sold by each seller </h3>
<img align = "right" width = "200" height = "100" src = "https://github.com/msherazsadiq/21I-0523_21I0586-Assignment_2_CY_T_DB/assets/148572780/03492b45-b549-4e64-91bf-7542601a8369">

    SELECT s.SellerID, s.SellerName, COUNT(oi.Product_ID) AS TotalProductsSold
    FROM Seller s
    LEFT JOIN Product p ON s.SellerID = p.Seller_ID
    LEFT JOIN OrderItem oi ON p.ProductID = oi.Product_ID
    GROUP BY s.SellerID, s.SellerName
    ORDER BY s.SellerID;

<ul>
  <li><b>Challenges</b><br> Understanding multiple joins and their relationships and Aggregating data across multiple tables</li>
  <li><b>Solution</b><br>  The concept of joining multiple tables using different join types. In this query, two inner joins are used to connect the Product, OrderItem, and Orders tables based on their respective IDs. To aggregate data from multiple tables using aggregate functions and GROUP BY. The query calculates total revenue by multiplying quantity and price from different tables and then groups the results by product category to provide a summarized overview. </li>
</ul>


<h3>Q16. Retrieve the top 5 products with the highest sales in the last month </h3>
<img align = "right" width = "200" height = "100" src = "https://github.com/msherazsadiq/21I-0523_21I0586-Assignment_2_CY_T_DB/assets/148572780/bf7dec82-9f6a-4f52-98b2-d20d78fb7671">

    SELECT TOP 5 P.ProductID, P.ProductName, SUM(OI.Quantity) AS TotalSales
    FROM Product AS P
    JOIN OrderItem AS OI ON P.ProductID = OI.Product_ID
    JOIN Orders AS O ON OI.Order_ID = O.OrderID
    WHERE O.CreationTimeStamp >= DATEADD(MONTH, -1, GETDATE()) -- Filter orders from the last month
    GROUP BY P.ProductID, P.ProductName
    ORDER BY TotalSales DESC;

<ul>
  <li><b>Challenges</b><br> Understanding multiple joins and their relationships and Aggregating data across multiple tables</li>
  <li><b>Solution</b><br>  The concept of joining multiple tables using different join types. In this query, two inner joins are used to connect the Product, OrderItem, and Orders tables based on their respective IDs. To aggregate data from multiple tables using aggregate functions and GROUP BY. The query calculates total revenue by multiplying quantity and price from different tables and then groups the results by product category to provide a summarized overview. </li>
</ul>



 










