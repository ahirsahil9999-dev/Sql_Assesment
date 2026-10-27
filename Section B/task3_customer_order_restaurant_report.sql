-- Assessment Code: M4-A1 | Module 4: SQL for Data Analytics
-- Section B - Task 3: Customer–Order–Restaurant Joined Report
USE section_b_food_analytics;

-- 1. Create Tables
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS restaurants;
DROP TABLE IF EXISTS customers;

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    city VARCHAR(50) NOT NULL,
    phone VARCHAR(15) NOT NULL
);

CREATE TABLE restaurants (
    restaurant_id INT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    cuisine_type VARCHAR(50) NOT NULL,
    city VARCHAR(50) NOT NULL
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT NOT NULL,
    restaurant_id INT NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    order_date DATE NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (restaurant_id) REFERENCES restaurants(restaurant_id)
);

-- 2. Insert Sample Data (7 customers, 6 restaurants, 8 orders; Customers 6 & 7 have no orders)
INSERT INTO customers (customer_id, name, city, phone) VALUES
(1, 'Aarav Patel',     'Mumbai',    '9820111222'),
(2, 'Diya Sharma',      'Delhi',     '9811222333'),
(3, 'Rohan Mehta',      'Mumbai',    '9833444555'),
(4, 'Sneha Reddy',      'Bengaluru', '9844555666'),
(5, 'Kabir Verma',      'Delhi',     '9855666777'),
(6, 'Vikram Seth',      'Pune',      '9866777888'), -- No orders placed
(7, 'Ananya Roy',       'Bengaluru', '9877888999'); -- No orders placed

INSERT INTO restaurants (restaurant_id, name, cuisine_type, city) VALUES
(101, 'Trishna',           'Seafood',     'Mumbai'),
(102, 'Bukhara',           'North Indian','Delhi'),
(103, 'Vidyarthi Bhavan',  'South Indian','Bengaluru'),
(104, 'Britannia & Co.',   'Parsi',       'Mumbai'),
(105, 'Karim\'s',          'Mughlai',     'Delhi'),
(106, 'The Permit Room',   'Fusion',      'Bengaluru');

INSERT INTO orders (order_id, customer_id, restaurant_id, amount, order_date) VALUES
(5001, 1, 101, 2450.00, '2026-10-12'),
(5002, 1, 104, 1850.00, '2026-10-15'),
(5003, 2, 102, 3200.00, '2026-10-14'),
(5004, 3, 101, 1500.00, '2026-10-18'),
(5005, 3, 102, 2800.00, '2026-10-20'),
(5006, 4, 103,  850.00, '2026-10-19'),
(5007, 5, 105, 2100.00, '2026-10-21'),
(5008, 2, 104, 1400.00, '2026-10-22');

-- Query 1: INNER JOIN (order, customer name, fulfilling restaurant name)
SELECT 
    o.order_id,
    o.order_date,
    c.name AS customer_name,
    c.city AS customer_city,
    r.name AS restaurant_name,
    r.city AS restaurant_city,
    o.amount AS order_amount
FROM orders o
INNER JOIN customers c ON o.customer_id = c.customer_id
INNER JOIN restaurants r ON o.restaurant_id = r.restaurant_id
ORDER BY o.order_id;

-- Query 2: LEFT JOIN (all customers, NULL where no orders exist)
SELECT 
    c.customer_id,
    c.name AS customer_name,
    c.city AS customer_city,
    c.phone,
    o.order_id,
    o.order_date,
    o.amount AS order_amount,
    r.name AS restaurant_name
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
LEFT JOIN restaurants r ON o.restaurant_id = r.restaurant_id
ORDER BY c.customer_id, o.order_id;

-- Query 3: WHERE condition showing only orders where customer and restaurant belong to the same city
SELECT 
    o.order_id,
    o.order_date,
    c.name AS customer_name,
    c.city AS customer_city,
    r.name AS restaurant_name,
    r.city AS restaurant_city,
    o.amount AS order_amount
FROM orders o
INNER JOIN customers c ON o.customer_id = c.customer_id
INNER JOIN restaurants r ON o.restaurant_id = r.restaurant_id
WHERE c.city = r.city
ORDER BY o.order_id;
