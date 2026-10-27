-- Assessment Code: M4-A1 | Module 4: SQL for Data Analytics
-- Section B - Task 1: Menu & Order Explorer
USE section_b_food_analytics;

-- 1. Create Table
DROP TABLE IF EXISTS food_orders;
CREATE TABLE food_orders (
    order_id INT PRIMARY KEY,
    customer_name VARCHAR(50) NOT NULL,
    restaurant_name VARCHAR(50) NOT NULL,
    item_ordered VARCHAR(50) NOT NULL,
    quantity INT NOT NULL,
    price_per_item DECIMAL(10,2) NOT NULL,
    order_date DATE NOT NULL,
    city VARCHAR(50) NOT NULL
);

-- 2. Insert Sample Data
INSERT INTO food_orders (order_id, customer_name, restaurant_name, item_ordered, quantity, price_per_item, order_date, city) VALUES
(101, 'Aarav Patel',    'Spice Route',     'Paneer Tikka Masala', 2, 380.00, '2026-10-15', 'Mumbai'),
(102, 'Priya Sharma',   'Pizza Express',   'Margherita Pizza',    1, 450.00, '2026-10-16', 'Mumbai'),
(103, 'Rohan Verma',    'Burger Bistro',   'Double Cheeseburger', 2, 280.00, '2026-10-17', 'Delhi'),
(104, 'Sneha Iyer',     'Spice Route',     'Garlic Naan Basket',  3, 120.00, '2026-10-18', 'Mumbai'),
(105, 'Karan Mehta',    'Punjab Grill',    'Butter Chicken Platter', 1, 550.00, '2026-10-19', 'Delhi'),
(106, 'Diya Nair',      'South Tiffin',    'Masala Dosa Combo',   2, 160.00, '2026-10-20', 'Bengaluru'),
(107, 'Vikram Malhotra','Beijing Bites',   'Schezwan Noodles',    2, 320.00, '2026-10-21', 'Bengaluru'),
(108, 'Neha Joshi',     'Pizza Express',   'Farmhouse Delight',   1, 520.00, '2026-10-22', 'Mumbai'),
(109, 'Anand Kulkarni', 'Coastal Curries', 'Fish Curry Rice Bowl',2, 420.00, '2026-10-23', 'Mumbai'),
(110, 'Pooja Reddy',    'Burger Bistro',   'Truffle Fries & Shake',1, 350.00, '2026-10-24', 'Delhi');

-- Query 1: All orders in 'Mumbai', sorted by price_per_item DESC
SELECT order_id, customer_name, restaurant_name, item_ordered, quantity, price_per_item, order_date, city
FROM food_orders
WHERE city = 'Mumbai'
ORDER BY price_per_item DESC;

-- Query 2: All distinct restaurant names that received at least one order
SELECT DISTINCT restaurant_name
FROM food_orders
ORDER BY restaurant_name ASC;

-- Query 3: Top 5 most expensive individual orders using ORDER BY and LIMIT
SELECT order_id, customer_name, restaurant_name, item_ordered, quantity, price_per_item, (quantity * price_per_item) AS total_order_amount, city
FROM food_orders
ORDER BY price_per_item DESC
LIMIT 5;
