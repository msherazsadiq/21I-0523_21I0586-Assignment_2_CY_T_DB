CREATE DATABASE i210523_i210586_Assignment_2_CY_T_DB
USE i210523_i210586_Assignment_2_CY_T_DB;


CREATE TABLE Seller(
	SellerID NUMERIC(4) PRIMARY KEY,
	SellerName VARCHAR(15),
	ContactNo NUMERIC (15),
);

CREATE TABLE Customer(
	CustomerID NUMERIC(4) PRIMARY KEY,
	CustomerName VARCHAR(15),
	ContactNo NUMERIC (15),
);

CREATE TABLE Product(
	ProductID NUMERIC(4) PRIMARY KEY,
	Price NUMERIC (15),
	ProductName VARCHAR(15),
	ProductDescription VARCHAR(25),
	ProductCatagory VARCHAR(20),

	Seller_ID NUMERIC(4),
	FOREIGN KEY (Seller_ID) REFERENCES Seller (SellerID)
	ON DELETE CASCADE
);

CREATE TABLE Orders(
	OrderID NUMERIC(4) PRIMARY KEY,
	OrderNumber NUMERIC (15),
	CreationTimeStamp DATETIME,
	TotalAmount NUMERIC(25),

	Customer_ID NUMERIC(4)
	FOREIGN KEY (Customer_ID) REFERENCES Customer (CustomerID)
	ON DELETE CASCADE
);

CREATE TABLE OrderItem(
	Quantity NUMERIC (15),

	Order_ID NUMERIC(4)
	FOREIGN KEY (Order_ID) REFERENCES Orders (OrderID)
	ON DELETE CASCADE,

	Product_ID NUMERIC(4)
	FOREIGN KEY (Product_ID) REFERENCES Product (ProductID)
	ON DELETE CASCADE
);

CREATE TABLE ShoppingCart(
	CartID NUMERIC(4) PRIMARY KEY,
	CreationTimeStamp DATETIME,

	Customer_ID NUMERIC(4),
	FOREIGN KEY (Customer_ID) REFERENCES Customer (CustomerID)
	ON DELETE CASCADE
);

CREATE TABLE CartItem(
	Quantity NUMERIC(15),

	Cart_ID NUMERIC(4),
	FOREIGN KEY (Cart_ID) REFERENCES ShoppingCart (CartID)
	ON DELETE CASCADE,

	Product_ID NUMERIC(4),
	FOREIGN KEY (Product_ID) REFERENCES Product (ProductID)
	ON DELETE CASCADE
);

CREATE TABLE Payment(
	PaymentID NUMERIC(4) PRIMARY KEY,
	CreationTimeStamp DATETIME,
	PaymentMethod VARCHAR(10),
	Amount NUMERIC (10),

	Order_ID NUMERIC(4),
	FOREIGN KEY (Order_ID) REFERENCES Orders (OrderID)
	ON DELETE CASCADE
);

CREATE TABLE Review(
	ReviewID NUMERIC(4) PRIMARY KEY,
	Rating NUMERIC (15),
	Comment VARCHAR(50),

	Customer_ID NUMERIC(4)
	FOREIGN KEY (Customer_ID) REFERENCES Customer (CustomerID)
	ON DELETE CASCADE,

	Product_ID NUMERIC(4)
	FOREIGN KEY (Product_ID) REFERENCES Product (ProductID)
	ON DELETE CASCADE
);

CREATE TABLE Address(
	AddressID NUMERIC(4) PRIMARY KEY,
	AddressLines VARCHAR(15),
	AddressCity VARCHAR(15),
	AddressState VARCHAR (15),
	Country VARCHAR(15),
	ZipCode NUMERIC(10),
	ISBillingAddress BIT,
	ISShippingAddress BIT,

	Customer_ID NUMERIC(4)
	FOREIGN KEY (Customer_ID) REFERENCES Customer (CustomerID)
	ON DELETE CASCADE,
);

CREATE TABLE Inventory(
	InventoryID NUMERIC(4) PRIMARY KEY,
	QuantityInStock NUMERIC (15),
	Comment VARCHAR(50),
	LastStockUpdateTimestamp DATETIME,
	ReorderThershold VARCHAR(15),
	UniCost NUMERIC (10),

	Product_ID NUMERIC(4)
	FOREIGN KEY (Product_ID) REFERENCES Product (ProductID)
	ON DELETE CASCADE
);



INSERT INTO Seller (SellerID, SellerName, ContactNo)
VALUES 
	(1, 'Seller1', 1234567890),
	(2, 'Seller2', 1234567891),
	(3, 'Seller3', 1234567892),
	(4, 'Seller4', 1234567893),
	(5, 'Seller5', 1234567894),
	(6, 'Seller6', 1234567895),
	(7, 'Seller7', 1234567896),
	(8, 'Seller8', 1234567897),
	(9, 'Seller9', 1234567898),
	(10, 'Seller10', 1234567899),
	(11, 'Seller11', 2234567890),
	(12, 'Seller12', 2234567891),
	(13, 'Seller13', 2234567892),
	(14, 'Seller14', 2234567893),
	(15, 'Seller15', 2234567894),
	(16, 'Seller16', 2234567895),
	(17, 'Seller17', 2234567896),
	(18, 'Seller18', 2234567897),
	(19, 'Seller19', 2234567898),
	(20, 'Seller20', 2234567899);

INSERT INTO Customer (CustomerID, CustomerName, ContactNo)
VALUES 
	(1, 'Customer1', 1234567890),
	(2, 'Customer2', 2345678901),
	(3, 'Customer3', 3456789012),
	(4, 'Customer4', 4567890123),
	(5, 'Customer5', 5678901234),
	(6, 'Customer6', 6789012345),
	(7, 'Customer7', 7890123456),
	(8, 'Customer8', 8901234567),
	(9, 'Customer9', 9012345678),
	(10, 'Customer10', 9876543210),
	(11, 'Customer11', 8765432109),
	(12, 'Customer12', 7654321098),
	(13, 'Customer13', 6543210987),
	(14, 'Customer14', 5432109876),
	(15, 'Customer15', 4321098765),
	(16, 'Customer16', 3210987654),
	(17, 'Customer17', 2109876543),
	(18, 'Customer18', 1098765432),
	(19, 'Customer19', 9876543211),
	(20, 'Customer20', 9876543212);

INSERT INTO Product (ProductID, Price, ProductName, ProductDescription, ProductCatagory, Seller_ID)
VALUES 
    (1, 1000, 'Product1', 'Description1', 'Electronics', 1),
    (2, 2000, 'Product2', 'Description2', 'Home Appliances', 2),
    (3, 3000, 'Product3', 'Description3', 'Clothing', 3),
    (4, 4000, 'Product4', 'Description4', 'Furniture', 5),
    (5, 5000, 'Product5', 'Description5', 'Electronics', 4),
    (6, 6000, 'Product6', 'Description6', 'Home Appliances', 1),
    (7, 7000, 'Product7', 'Description7', 'Clothing', 6),
    (8, 8000, 'Product8', 'Description8', 'Furniture', 8),
    (9, 9000, 'Product9', 'Description9', 'Electronics', 2),
    (10, 10000, 'Product10', 'Description10', 'Home Appliances', 9),
    (11, 11000, 'Product11', 'Description11', 'Clothing', 15),
    (12, 12000, 'Product12', 'Description12', 'Furniture', 12),
    (13, 13000, 'Product13', 'Description13', 'Electronics', 15),
    (14, 14000, 'Product14', 'Description14', 'Home Appliances', 3),
    (15, 15000, 'Product15', 'Description15', 'Clothing', 9),
    (16, 16000, 'Product16', 'Description16', 'Furniture', 2),
    (17, 17000, 'Product17', 'Description17', 'Electronics', 1),
    (18, 18000, 'Product18', 'Description18', 'Home Appliances', 6),
    (19, 19000, 'Product19', 'Description19', 'Clothing', 8),
    (20, 20000, 'Product20', 'Description20', 'Furniture', 18);

INSERT INTO Orders (OrderID, OrderNumber, CreationTimeStamp, TotalAmount, Customer_ID)
VALUES 
	(1, 1001, CONVERT(DATETIME, '2023-10-15 01:01:10'), 1000, 1),
	(2, 1002, CONVERT(DATETIME, '2023-10-16 02:02:20'), 2000, 2),
	(3, 1003, CONVERT(DATETIME, '2023-10-17 03:03:30'), 3000, 3),
	(4, 1004, CONVERT(DATETIME, '2023-10-18 04:04:40'), 4000, 4),
	(5, 1005, CONVERT(DATETIME, '2023-10-19 05:05:50'), 5000, 1),
	(6, 1006, CONVERT(DATETIME, '2023-10-20 06:06:00'), 6000, 12),
	(7, 1007, CONVERT(DATETIME, '2023-10-21 07:07:10'), 7000, 1),
	(8, 1008, CONVERT(DATETIME, '2023-10-22 08:08:20'), 8000, 3),
	(9, 1009, CONVERT(DATETIME, '2023-10-23 09:09:30'), 9000, 3),
	(10, 1010, CONVERT(DATETIME, '2023-10-24 10:10:40'), 10000, 8),
	(11, 1011, CONVERT(DATETIME, '2023-10-25 11:11:50'), 11000, 1),
	(12, 1012, CONVERT(DATETIME, '2023-10-26 12:12:00'), 12000, 14),
	(13, 1013, CONVERT(DATETIME, '2023-10-27 01:13:10'), 13000, 1),
	(14, 1014, CONVERT(DATETIME, '2023-10-28 02:14:20'), 14000, 19),
	(15, 1015, CONVERT(DATETIME, '2023-10-29 03:15:30'), 15000, 3),
	(16, 1016, CONVERT(DATETIME, '2023-10-30 04:16:40'), 16000, 1),
	(17, 1017, CONVERT(DATETIME, '2023-10-16 05:17:50'), 17000, 2),
	(18, 1018, CONVERT(DATETIME, '2023-10-02 06:18:00'), 18000, 3),
	(19, 1019, CONVERT(DATETIME, '2023-10-18 07:19:10'), 19000, 4),
	(20, 1020, CONVERT(DATETIME, '2023-10-04 08:20:20'), 20000, 1);

INSERT INTO OrderItem (Quantity, Order_ID, Product_ID)
VALUES 
	(6, 1, 1),
	(4, 1, 2),
	(3, 1, 3),
	(1, 1, 4),
	(2, 17, 17),
	(3, 13, 13),
	(1, 8, 8),
	(2, 8, 8),
	(3, 3, 3),
	(1, 7, 7),
	(2, 9, 9),
	(2, 15, 15),
	(1, 16, 16),
	(2, 7, 7),
	(4, 6, 6),
	(1, 9, 9),
	(6, 5, 5),
	(3, 19, 19),
	(1, 11, 11),
	(2, 14, 14);

INSERT INTO ShoppingCart (CartID, CreationTimeStamp, Customer_ID)
VALUES
  (1, '2023-10-19 10:00:00', 1),
  (2, '2023-10-19 10:15:00', 2),
  (3, '2023-10-19 10:30:00', 3),
  (4, '2023-10-19 10:45:00', 4),
  (5, '2023-10-19 11:00:00', 11),
  (6, '2023-10-19 11:15:00', 12),
  (7, '2023-10-19 11:30:00', 1),
  (8, '2023-10-19 11:45:00', 3),
  (9, '2023-10-19 12:00:00', 16),
  (10, '2023-10-19 12:15:00', 8),
  (11, '2023-10-19 12:30:00', 13),
  (12, '2023-10-19 12:45:00', 14),
  (13, '2023-10-19 13:00:00', 19),
  (14, '2023-10-19 13:15:00', 19),
  (15, '2023-10-19 13:30:00', 3),
  (16, '2023-10-19 13:45:00', 1),
  (17, '2023-10-19 14:00:00', 5),
  (18, '2023-10-19 14:15:00', 6),
  (19, '2023-10-19 14:30:00', 8),
  (20, '2023-10-19 14:45:00', 12);

INSERT INTO CartItem (Quantity, Cart_ID, Product_ID)
VALUES
  (10, 2, 2),
  (5, 1, 1),
  (8, 3, 3),
  (12, 11, 11),
  (7, 17, 17),
  (9, 13, 13),
  (4, 8, 8),
  (15, 8, 8),
  (11, 3, 3),
  (6, 7, 7),
  (14, 9, 9),
  (8, 15, 15),
  (3, 16, 16),
  (10, 7, 7),
  (9, 6, 6),
  (13, 9, 9),
  (4, 5, 5),
  (7, 19, 19),
  (5, 11, 11),
  (11, 14, 14);

INSERT INTO Payment (PaymentID, CreationTimeStamp, PaymentMethod, Amount, Order_ID)
VALUES
  (1, CONVERT(DATETIME, '2023-10-19 10:00:00'), 'CreditCard', 1000, 1),
  (2, CONVERT(DATETIME, '2023-10-19 10:15:00'), 'PayPal', 2000, 2),
  (3, CONVERT(DATETIME, '2023-10-19 10:30:00'), 'Cash', 3000, 3),
  (4, CONVERT(DATETIME, '2023-10-19 10:45:00'), 'CreditCard', 4000, 4),
  (5, CONVERT(DATETIME, '2023-10-19 11:00:00'), 'PayPal', 5000, 5),
  (6, CONVERT(DATETIME, '2023-10-19 11:15:00'), 'Cash', 6000, 6),
  (7, CONVERT(DATETIME, '2023-10-19 11:30:00'), 'CreditCard', 7000, 7),
  (8, CONVERT(DATETIME, '2023-10-19 11:45:00'), 'PayPal', 8000, 8),
  (9, CONVERT(DATETIME, '2023-10-19 12:00:00'), 'Cash', 9000, 9),
  (10, CONVERT(DATETIME, '2023-10-19 12:15:00'), 'CreditCard', 10000, 10),
  (11, CONVERT(DATETIME, '2023-10-19 12:30:00'), 'PayPal', 11000, 11),
  (12, CONVERT(DATETIME, '2023-10-19 12:45:00'), 'Cash', 12000, 12),
  (13, CONVERT(DATETIME, '2023-10-19 13:00:00'), 'CreditCard', 13000, 13),
  (14, CONVERT(DATETIME, '2023-10-19 13:15:00'), 'PayPal', 14000, 14),
  (15, CONVERT(DATETIME, '2023-10-19 13:30:00'), 'Cash', 15000, 15),
  (16, CONVERT(DATETIME, '2023-10-19 13:45:00'), 'CreditCard', 16000, 16),
  (17, CONVERT(DATETIME, '2023-10-19 14:00:00'), 'PayPal', 17000, 17),
  (18, CONVERT(DATETIME, '2023-10-19 14:15:00'), 'Cash', 18000, 18),
  (19, CONVERT(DATETIME, '2023-10-19 14:30:00'), 'CreditCard', 19000, 19),
  (20, CONVERT(DATETIME, '2023-10-19 14:45:00'), 'PayPal', 20000, 20);

INSERT INTO Review (ReviewID, Rating, Comment, Customer_ID, Product_ID)
VALUES
  (1, 5, 'Great product!', 1, 1),
  (2, 4, 'Good value for the price.', 2, 2),
  (3, 5, 'Highly recommended.', 3, 3),
  (4, 3, 'Could be better.', 4, 4),
  (5, 4, 'Satisfied with the purchase.', 7, 7),
  (6, 5, 'Excellent service.', 2, 2),
  (7, 2, 'Not worth the money.', 9, 9),
  (8, 4, 'Fast shipping.', 11, 11),
  (9, 5, 'Impressed with the quality.', 9, 18),
  (10, 3, 'Average product.', 13, 13),
  (11, 4, 'Decent performance.', 11, 11),
  (12, 5, 'Love it!', 13, 19),
  (13, 2, 'Disappointed.', 13, 4),
  (14, 4, 'Good customer support.', 14, 9),
  (15, 5, 'Best purchase ever.', 1, 10),
  (16, 3, 'Needs improvement.', 2, 16),
  (17, 4, 'Worth the price.', 3, 17),
  (18, 5, 'Outstanding product.', 18, 11),
  (19, 2, 'Not what I expected.', 19, 1),
  (20, 4, 'Happy with my choice.', 7, 7);

INSERT INTO Address (AddressID, AddressLines, AddressCity, AddressState, Country, ZipCode, ISBillingAddress, ISShippingAddress, Customer_ID)
VALUES
  (1, '123 Main St', 'City1', 'State1', 'Country1', 12345, 1, 1, 1),
  (2, '456 Elm St', 'City2', 'State2', 'Country2', 23456, 1, 0, 2),
  (3, '789 Oak St', 'City3', 'State3', 'Country3', 34567, 0, 1, 3),
  (4, '101 Pine St', 'City4', 'State4', 'Country4', 45678, 1, 1, 4),
  (5, '202 Maple St', 'City5', 'State5', 'Country5', 56789, 0, 0, 5),
  (6, '303 Cedar St', 'City1', 'State1', 'Country1', 12345, 1, 1, 6),
  (7, '404 Birch St', 'City2', 'State2', 'Country2', 23456, 1, 1, 7),
  (8, '505 Willow St', 'City3', 'State3', 'Country3', 34567, 0, 0, 8),
  (9, '606 Spruce St', 'City4', 'State4', 'Country4', 45678, 1, 1, 9),
  (10, '707 Fir St', 'City5', 'State5', 'Country5', 56789, 1, 1, 10),
  (11, '808 Redwood St', 'City1', 'State1', 'Country1', 12345, 0, 0, 11),
  (12, '909 Sequoia St', 'City2', 'State2', 'Country2', 23456, 1, 1, 12),
  (13, '1010 Palm St', 'City3', 'State3', 'Country3', 34567, 1, 0, 13),
  (14, '1111 Oak St', 'City4', 'State4', 'Country4', 45678, 0, 1, 14),
  (15, '1212 Pine St', 'City5', 'State5', 'Country5', 56789, 1, 1, 15),
  (16, '1313 Maple St', 'City1', 'State1', 'Country1', 12345, 0, 0, 16),
  (17, '1414 Cedar St', 'City2', 'State2', 'Country2', 23456, 1, 1, 17),
  (18, '1515 Birch St', 'City3', 'State3', 'Country3', 34567, 1, 1, 18),
  (19, '1616 Willow St', 'City4', 'State4', 'Country4', 45678, 0, 0, 19),
  (20, '1717 Spruce St', 'City5', 'State5', 'Country5', 56789, 1, 1, 20);

INSERT INTO Inventory (InventoryID, QuantityInStock, Comment, LastStockUpdateTimestamp, ReorderThershold, UniCost, Product_ID)
VALUES
  (1, 100, 'Plenty of stock', CONVERT(DATETIME, '2023-10-19 10:00:00'), 'Low', 10.00, 1),
  (2, 75, 'Good condition', CONVERT(DATETIME, '2023-10-19 10:15:00'), 'Medium', 12.50, 2),
  (3, 120, 'Stocked up', CONVERT(DATETIME, '2023-10-19 10:30:00'), 'Low', 9.99, 3),
  (4, 50, 'Limited stock', CONVERT(DATETIME, '2023-10-19 10:45:00'), 'High', 15.00, 4),
  (5, 90, 'Steady supply', CONVERT(DATETIME, '2023-10-19 11:00:00'), 'Low', 11.25, 5),
  (6, 110, 'New shipment', CONVERT(DATETIME, '2023-10-19 11:15:00'), 'Medium', 10.50, 6),
  (7, 65, 'Almost out', CONVERT(DATETIME, '2023-10-19 11:30:00'), 'High', 14.99, 7),
  (8, 130, 'Overstocked', CONVERT(DATETIME, '2023-10-19 11:45:00'), 'Low', 9.75, 8),
  (9, 85, 'Replenished', CONVERT(DATETIME, '2023-10-19 12:00:00'), 'Medium', 13.50, 9),
  (10, 70, 'Fast-moving', CONVERT(DATETIME, '2023-10-19 12:15:00'), 'Low', 12.00, 10),
  (11, 60, 'Limited availability', CONVERT(DATETIME, '2023-10-19 12:30:00'), 'High', 14.50, 11),
  (12, 95, 'In-demand', CONVERT(DATETIME, '2023-10-19 12:45:00'), 'Low', 11.99, 12),
  (13, 80, 'Ready for orders', CONVERT(DATETIME, '2023-10-19 13:00:00'), 'Medium', 12.75, 13),
  (14, 105, 'Fresh stock', CONVERT(DATETIME, '2023-10-19 13:15:00'), 'Low', 10.99, 14),
  (15, 125, 'Plenty on hand', CONVERT(DATETIME, '2023-10-19 13:30:00'), 'Medium', 13.25, 15),
  (16, 45, 'Running low', CONVERT(DATETIME, '2023-10-19 13:45:00'), 'High', 15.99, 16),
  (17, 115, 'Stocked for season', CONVERT(DATETIME, '2023-10-19 14:00:00'), 'Low', 11.50, 17),
  (18, 55, 'Limited time offer', CONVERT(DATETIME, '2023-10-19 14:15:00'), 'Medium', 12.99, 18),
  (19, 95, 'Frequent restocks', CONVERT(DATETIME, '2023-10-19 14:30:00'), 'Low', 10.75, 19),
  (20, 70, 'Ready to ship', CONVERT(DATETIME, '2023-10-19 14:45:00'), 'Medium', 13.99, 20);
