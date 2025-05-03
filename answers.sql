-- Quiz 1
CREATE TABLE productDetail_1nf (
    OrderID INT,
    CustomerName VARCHAR(100),
    Product VARCHAR(50)
);

INSERT INTO productDetail_1nf (OrderID, CustomerName, Product) VALUES (101, 'John Doe', 'Laptop');
INSERT INTO productDetail_1nf (OrderID, CustomerName, Product) VALUES (101, 'John Doe', 'Mouse');
INSERT INTO productDetail_1nf (OrderID, CustomerName, Product) VALUES (102, 'Jane Smith', 'Tablet');
INSERT INTO productDetail_1nf (OrderID, CustomerName, Product) VALUES (102, 'Jane Smith', 'Keyboard');
INSERT INTO productDetail_1nf (OrderID, CustomerName, Product) VALUES (102, 'Jane Smith', 'Mouse');
INSERT INTO productDetail_1nf (OrderID, CustomerName, Product) VALUES (103, 'Emily Clark', 'Phone');

-- Quiz 2
CREATE TABLE orders (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(100)
);

CREATE TABLE orderDetails_2nf (
    OrderID INT,
    Product VARCHAR(50),
    Quantity INT,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

INSERT INTO orders (OrderID, CustomerName) VALUES (101, 'John Doe');
INSERT INTO orders (OrderID, CustomerName) VALUES (102, 'Jane Smith');
INSERT INTO orders (OrderID, CustomerName) VALUES (103, 'Emily Clark');

INSERT INTO orderDetails_2nf (OrderID, Product, Quantity) VALUES (101, 'Laptop', 2);
INSERT INTO orderDetails_2nf (OrderID, Product, Quantity) VALUES (101, 'Mouse', 1);
INSERT INTO orderDetails_2nf (OrderID, Product, Quantity) VALUES (102, 'Tablet', 3);
INSERT INTO orderDetails_2nf (OrderID, Product, Quantity) VALUES (102, 'Keyboard', 1);
INSERT INTO orderDetails_2nf (OrderID, Product, Quantity) VALUES (102, 'Mouse', 2);
INSERT INTO orderDetails_2nf (OrderID, Product, Quantity) VALUES (103, 'Phone', 1);
