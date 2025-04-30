-- answers.sql

-- Question 1 Achieving 1NF (First Normal Form) 🛠️
-- The 'Products' column contains multiple values, which violates 1NF.
-- We need to break this into multiple rows so each row has only one product per order.

-- Original table (ProductDetail):
-- | OrderID | CustomerName  | Products            |
-- | 101     | John Doe      | Laptop, Mouse       |
-- | 102     | Jane Smith    | Tablet, Keyboard, Mouse |
-- | 103     | Emily Clark   | Phone               |

-- SQL Query to achieve 1NF:
-- Break down the multiple products into separate rows for each order.

-- The query assumes we are using a temporary solution to split the 'Products' into individual rows.
-- In a real-world scenario, this should be done at the data level or with a more complex method.

-- Example using UNION (you can adapt this depending on your database setup)
SELECT OrderID, CustomerName, 'Laptop' AS Product FROM ProductDetail WHERE Products LIKE '%Laptop%'
UNION
SELECT OrderID, CustomerName, 'Mouse' AS Product FROM ProductDetail WHERE Products LIKE '%Mouse%'
UNION
SELECT OrderID, CustomerName, 'Tablet' AS Product FROM ProductDetail WHERE Products LIKE '%Tablet%'
UNION
SELECT OrderID, CustomerName, 'Keyboard' AS Product FROM ProductDetail WHERE Products LIKE '%Keyboard%'
UNION
SELECT OrderID, CustomerName, 'Phone' AS Product FROM ProductDetail WHERE Products LIKE '%Phone%';

-- This will give us a table with each product on a separate row:
-- | OrderID | CustomerName  | Product  |
-- | 101     | John Doe      | Laptop   |
-- | 101     | John Doe      | Mouse    |
-- | 102     | Jane Smith    | Tablet   |
-- | 102     | Jane Smith    | Keyboard |
-- | 102     | Jane Smith    | Mouse    |
-- | 103     | Emily Clark   | Phone    |

-- Question 2 Achieving 2NF (Second Normal Form) 🧩
-- In the OrderDetails table, the CustomerName column depends only on OrderID, which is a partial dependency.
-- To achieve 2NF, we must separate the information into two tables:
-- One for Order details, and another for Customer information.

-- Original table (OrderDetails):
-- | OrderID | CustomerName  | Product  | Quantity |
-- | 101     | John Doe      | Laptop   | 2        |
-- | 101     | John Doe      | Mouse    | 1        |
-- | 102     | Jane Smith    | Tablet   | 3        |
-- | 102     | Jane Smith    | Keyboard | 1        |
-- | 102     | Jane Smith    | Mouse    | 2        |
-- | 103     | Emily Clark   | Phone    | 1        |

-- Step 1: Create a table for customers
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY AUTO_INCREMENT,
    CustomerName VARCHAR(100)
);

-- Step 2: Insert customer data into the new Customers table
-- The CustomerID will be used as a foreign key in the Orders table

INSERT INTO Customers (CustomerName)
SELECT DISTINCT CustomerName
FROM OrderDetails;

-- Step 3: Create a new Orders table
CREATE TABLE Orders (
    OrderID INT,
    CustomerID INT,
    Product VARCHAR(100),
    Quantity INT,
    PRIMARY KEY (OrderID, Product),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- Step 4: Insert data into the new Orders table with references to CustomerID
INSERT INTO Orders (OrderID, CustomerID, Product, Quantity)
SELECT o.OrderID, c.CustomerID, o.Product, o.Quantity
FROM OrderDetails o
JOIN Customers c ON o.CustomerName = c.CustomerName;

-- After this, we will have two tables:
-- Customers table:
-- | CustomerID | CustomerName |
-- | 1          | John Doe     |
-- | 2          | Jane Smith   |
-- | 3          | Emily Clark  |

-- Orders table:
-- | OrderID | CustomerID | Product  | Quantity |
-- | 101     | 1          | Laptop   | 2        |
-- | 101     | 1          | Mouse    | 1        |
-- | 102     | 2          | Tablet   | 3        |
-- | 102     | 2          | Keyboard | 1        |
-- | 102     | 2          | Mouse    | 2        |
-- | 103     | 3          | Phone    | 1        |

-- This eliminates the partial dependency, as now CustomerName is only stored in the Customers table, 
-- and each non-key attribute in the Orders table depends on the full primary key (OrderID, Product).
