-- ============================================================================
-- Assessment Code: M4-A1 | Module 4: SQL for Data Analytics
-- SECTION C: MINI CAPSTONE PROJECT
-- Project: Food Delivery Analytics — SQL Backend
-- Database Engine: MySQL 8.0+ / 26.7+
-- ============================================================================

DROP DATABASE IF EXISTS food_delivery_capstone;
CREATE DATABASE food_delivery_capstone;
USE food_delivery_capstone;

-- ============================================================================
-- PART 1: RELATIONAL SCHEMA DESIGN WITH CONSTRAINTS
-- ============================================================================

-- Table 1: Customers
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS delivery_agents;
DROP TABLE IF EXISTS restaurants;
DROP TABLE IF EXISTS customers;

CREATE TABLE customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(15) NOT NULL,
    city VARCHAR(50) NOT NULL,
    signup_date DATE NOT NULL
);

-- Table 2: Restaurants
CREATE TABLE restaurants (
    restaurant_id INT PRIMARY KEY AUTO_INCREMENT,
    restaurant_name VARCHAR(100) NOT NULL,
    cuisine_type VARCHAR(50) NOT NULL,
    city VARCHAR(50) NOT NULL,
    rating DECIMAL(2,1) CHECK (rating >= 1.0 AND rating <= 5.0)
);

-- Table 3: Delivery Agents
CREATE TABLE delivery_agents (
    agent_id INT PRIMARY KEY AUTO_INCREMENT,
    agent_name VARCHAR(100) NOT NULL,
    phone VARCHAR(15) NOT NULL,
    city VARCHAR(50) NOT NULL,
    vehicle_type VARCHAR(30) NOT NULL
);

-- Table 4: Orders (Bridge / Fact table with Foreign Keys)
CREATE TABLE orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    restaurant_id INT NOT NULL,
    agent_id INT NOT NULL,
    order_amount DECIMAL(10,2) NOT NULL CHECK (order_amount > 0),
    delivery_time_mins INT NOT NULL CHECK (delivery_time_mins >= 0),
    order_status VARCHAR(20) NOT NULL DEFAULT 'Delivered',
    order_date DATE NOT NULL,
    CONSTRAINT fk_orders_customer FOREIGN KEY (customer_id) REFERENCES customers(customer_id) ON DELETE CASCADE,
    CONSTRAINT fk_orders_restaurant FOREIGN KEY (restaurant_id) REFERENCES restaurants(restaurant_id) ON DELETE CASCADE,
    CONSTRAINT fk_orders_agent FOREIGN KEY (agent_id) REFERENCES delivery_agents(agent_id) ON DELETE CASCADE
);

-- ============================================================================
-- PART 2: DATA INSERTION (At least 10 rows per table across 3+ cities)
-- ============================================================================

-- Insert into Customers (12 rows across Mumbai, Delhi, Bengaluru, Surat)
INSERT INTO customers (customer_id, customer_name, email, phone, city, signup_date) VALUES
(1,  'Aarav Patel',      'aarav.p@example.com',     '9820111222', 'Mumbai',    '2026-01-10'),
(2,  'Diya Sharma',       'diya.s@example.com',      '9811222333', 'Delhi',     '2026-02-15'),
(3,  'Rohan Mehta',       'rohan.m@example.com',     '9833444555', 'Mumbai',    '2026-03-20'),
(4,  'Sneha Reddy',       'sneha.r@example.com',     '9844555666', 'Bengaluru', '2026-04-05'),
(5,  'Kabir Verma',       'kabir.v@example.com',     '9855666777', 'Delhi',     '2026-05-12'),
(6,  'Ananya Iyer',       'ananya.i@example.com',    '9866777888', 'Bengaluru', '2026-06-18'),
(7,  'Varun Desai',       'varun.d@example.com',     '9877888999', 'Surat',     '2026-07-22'),
(8,  'Pooja Kulkarni',    'pooja.k@example.com',     '9888999000', 'Mumbai',    '2026-08-09'),
(9,  'Aditya Rao',        'aditya.r@example.com',    '9899000111', 'Bengaluru', '2026-08-25'),
(10, 'Ishita Chawla',     'ishita.c@example.com',    '9810111213', 'Delhi',     '2026-09-02'),
(11, 'Tanvi Shah',        'tanvi.s@example.com',     '9821222324', 'Surat',     '2026-09-15'),
(12, 'Manish Tiwari',     'manish.t@example.com',    '9832333435', 'Mumbai',    '2026-10-01');

-- Insert into Restaurants (12 rows across Mumbai, Delhi, Bengaluru, Surat)
INSERT INTO restaurants (restaurant_id, restaurant_name, cuisine_type, city, rating) VALUES
(101, 'Trishna Seafood',      'Seafood',       'Mumbai',    4.8),
(102, 'Bukhara Grand',        'North Indian',  'Delhi',     4.9),
(103, 'Vidyarthi Tiffin',     'South Indian',  'Bengaluru', 4.6),
(104, 'Britannia Cafe',       'Parsi/Iranian', 'Mumbai',    4.5),
(105, 'Karim Mughlai',        'Mughlai',       'Delhi',     4.7),
(106, 'Permit Room Fusion',   'South Fusion',  'Bengaluru', 4.4),
(107, 'Surti Zaika',          'Gujarati',      'Surat',     4.6),
(108, 'The Bombay Canteen',   'Modern Indian', 'Mumbai',    4.9),
(109, 'Daryaganj Grill',      'North Indian',  'Delhi',     4.3),
(110, 'CTR Dosa Corner',      'South Indian',  'Bengaluru', 4.7),
(111, 'Kansar Thali House',   'Gujarati',      'Surat',     4.5),
(112, 'Mahesh Lunch Home',    'Coastal',       'Mumbai',    4.4);

-- Insert into Delivery Agents (10 rows across Mumbai, Delhi, Bengaluru, Surat)
INSERT INTO delivery_agents (agent_id, agent_name, phone, city, vehicle_type) VALUES
(201, 'Kunal Rao',        '9711001100', 'Mumbai',    'Electric Scooter'),
(202, 'Amit Joshi',       '9722002200', 'Delhi',     'Motorcycle'),
(203, 'Vikram Das',       '9733003300', 'Bengaluru', 'Electric Scooter'),
(204, 'Pooja Iyer',       '9744004400', 'Mumbai',    'Bicycle'),
(205, 'Deepak Soni',      '9755005500', 'Surat',     'Motorcycle'),
(206, 'Rahul Nair',       '9766006600', 'Bengaluru', 'Motorcycle'),
(207, 'Sanjay Yadav',     '9777007700', 'Delhi',     'Electric Scooter'),
(208, 'Nitin Patil',      '9788008800', 'Mumbai',    'Motorcycle'),
(209, 'Gaurav Bhatt',     '9799009900', 'Surat',     'Electric Scooter'),
(210, 'Harish Gowda',     '9700112233', 'Bengaluru', 'Motorcycle');

-- Insert into Orders (22 rows across dates up to 2026-10-27)
-- Includes high spenders, multi-order restaurants (>3 orders), recent orders (last 7 days: Oct 21-27)
INSERT INTO orders (order_id, customer_id, restaurant_id, agent_id, order_amount, delivery_time_mins, order_status, order_date) VALUES
-- Trishna Seafood (101): 4 orders -> Qualifies for >3 orders
(1001, 1, 101, 201, 2600.00, 24, 'Delivered', '2026-10-05'),
(1002, 3, 101, 204, 1800.00, 28, 'Delivered', '2026-10-12'),
(1003, 8, 101, 208, 3100.00, 22, 'Delivered', '2026-10-22'), -- Last 7 days
(1004, 1, 101, 201, 2400.00, 26, 'Delivered', '2026-10-25'), -- Last 7 days

-- Bukhara Grand (102): 4 orders -> Qualifies for >3 orders
(1005, 2, 102, 202, 3500.00, 31, 'Delivered', '2026-10-08'),
(1006, 5, 102, 207, 2800.00, 35, 'Delivered', '2026-10-15'),
(1007, 10, 102, 202, 4200.00, 29, 'Delivered', '2026-10-23'), -- Last 7 days
(1008, 2, 102, 207, 1900.00, 33, 'Delivered', '2026-10-26'), -- Last 7 days

-- Vidyarthi Tiffin (103): 4 orders -> Qualifies for >3 orders
(1009, 4, 103, 203,  650.00, 18, 'Delivered', '2026-10-10'),
(1010, 6, 103, 206,  820.00, 21, 'Delivered', '2026-10-14'),
(1011, 9, 103, 210,  740.00, 19, 'Delivered', '2026-10-21'), -- Last 7 days
(1012, 4, 103, 203,  950.00, 22, 'Delivered', '2026-10-24'), -- Last 7 days

-- The Bombay Canteen (108): 3 orders -> <= 3 orders
(1013, 1, 108, 201, 3200.00, 34, 'Delivered', '2026-10-11'),
(1014, 12, 108, 208, 2800.00, 30, 'Delivered', '2026-10-24'), -- Last 7 days
(1015, 3, 108, 204, 1950.00, 29, 'Delivered', '2026-10-27'), -- Last 7 days

-- Karim Mughlai (105): 2 orders
(1016, 5, 105, 202, 1600.00, 27, 'Delivered', '2026-10-18'),
(1017, 10, 105, 207, 2200.00, 25, 'Delivered', '2026-10-25'), -- Last 7 days

-- CTR Dosa Corner (110): 2 orders
(1018, 6, 110, 206, 1100.00, 17, 'Delivered', '2026-10-19'),
(1019, 9, 110, 210, 1450.00, 20, 'Delivered', '2026-10-26'), -- Last 7 days

-- Surti Zaika (107): 2 orders
(1020, 7, 107, 205, 1800.00, 23, 'Delivered', '2026-10-20'),
(1021, 11, 107, 209, 1950.00, 22, 'Delivered', '2026-10-24'), -- Last 7 days

-- Kansar Thali House (111): 1 order
(1022, 7, 111, 205, 1250.00, 28, 'Delivered', '2026-10-25'); -- Last 7 days


-- ============================================================================
-- PART 3: ANALYTICAL QUERY SUITE
-- ============================================================================

-- ----------------------------------------------------------------------------
-- Query 3.1: Revenue Report Query (GROUP BY, HAVING, SUM, COUNT, AVG)
-- Returns total orders and total revenue per restaurant, filtered for > 3 orders
-- ----------------------------------------------------------------------------
SELECT 
    r.restaurant_id,
    r.restaurant_name,
    r.city,
    COUNT(o.order_id) AS total_orders,
    SUM(o.order_amount) AS total_revenue,
    ROUND(AVG(o.order_amount), 2) AS average_order_value
FROM restaurants r
INNER JOIN orders o ON r.restaurant_id = o.restaurant_id
GROUP BY 
    r.restaurant_id, 
    r.restaurant_name, 
    r.city
HAVING 
    COUNT(o.order_id) > 3
ORDER BY 
    total_revenue DESC;

-- ----------------------------------------------------------------------------
-- Query 3.2: Customer Segmentation Query via CASE WHEN
-- Classifies each customer into 'Platinum' (>5000), 'Gold' (2000-5000), 'Standard' (<2000)
-- Ordered from highest to lowest spender
-- ----------------------------------------------------------------------------
SELECT 
    c.customer_id,
    c.customer_name,
    c.city,
    COALESCE(SUM(o.order_amount), 0.00) AS total_spend,
    CASE 
        WHEN SUM(o.order_amount) > 5000 THEN 'Platinum'
        WHEN SUM(o.order_amount) >= 2000 THEN 'Gold'
        ELSE 'Standard'
    END AS customer_tier
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
GROUP BY 
    c.customer_id, 
    c.customer_name, 
    c.city
ORDER BY 
    total_spend DESC;

-- ----------------------------------------------------------------------------
-- Query 3.3: Top 3 Performing Restaurants in Each City via DENSE_RANK()
-- Window function: DENSE_RANK() OVER (PARTITION BY city ORDER BY total_revenue DESC)
-- ----------------------------------------------------------------------------
WITH restaurant_revenue AS (
    SELECT 
        r.restaurant_id,
        r.restaurant_name,
        r.city,
        r.cuisine_type,
        COALESCE(SUM(o.order_amount), 0.00) AS total_revenue
    FROM restaurants r
    LEFT JOIN orders o ON r.restaurant_id = o.restaurant_id
    GROUP BY 
        r.restaurant_id, 
        r.restaurant_name, 
        r.city, 
        r.cuisine_type
),
ranked_restaurants AS (
    SELECT 
        restaurant_id,
        restaurant_name,
        city,
        cuisine_type,
        total_revenue,
        DENSE_RANK() OVER (
            PARTITION BY city 
            ORDER BY total_revenue DESC
        ) AS city_rank
    FROM restaurant_revenue
)
SELECT 
    city,
    city_rank,
    restaurant_name,
    cuisine_type,
    total_revenue
FROM ranked_restaurants
WHERE city_rank <= 3
ORDER BY 
    city ASC, 
    city_rank ASC;

-- ----------------------------------------------------------------------------
-- Query 3.4: Most Recent Order Per Customer via ROW_NUMBER()
-- Window function query finding each customer's single most recent order
-- ----------------------------------------------------------------------------
WITH customer_order_history AS (
    SELECT 
        o.order_id,
        o.customer_id,
        c.customer_name,
        c.city AS customer_city,
        r.restaurant_name,
        o.order_amount,
        o.order_date,
        ROW_NUMBER() OVER (
            PARTITION BY o.customer_id 
            ORDER BY o.order_date DESC, o.order_id DESC
        ) AS order_sequence
    FROM orders o
    INNER JOIN customers c ON o.customer_id = c.customer_id
    INNER JOIN restaurants r ON o.restaurant_id = r.restaurant_id
)
SELECT 
    customer_id,
    customer_name,
    customer_city,
    order_id AS most_recent_order_id,
    order_date AS most_recent_order_date,
    restaurant_name,
    order_amount
FROM customer_order_history
WHERE order_sequence = 1
ORDER BY customer_id ASC;

-- ----------------------------------------------------------------------------
-- Query 3.5: Create Saved SQL VIEW: vw_daily_order_summary
-- Joins all four tables: customers, restaurants, orders, delivery_agents
-- ----------------------------------------------------------------------------
DROP VIEW IF EXISTS vw_daily_order_summary;

CREATE VIEW vw_daily_order_summary AS
SELECT 
    o.order_date,
    c.customer_name,
    r.restaurant_name,
    da.agent_name,
    o.order_amount,
    o.delivery_time_mins
FROM orders o
INNER JOIN customers c ON o.customer_id = c.customer_id
INNER JOIN restaurants r ON o.restaurant_id = r.restaurant_id
INNER JOIN delivery_agents da ON o.agent_id = da.agent_id;

-- ----------------------------------------------------------------------------
-- Query 3.6: Query View for Orders Placed in the Last 7 Days
-- (Dynamically calculated based on CURRENT_DATE or relative benchmark 2026-10-21)
-- ----------------------------------------------------------------------------
SELECT 
    order_date,
    customer_name,
    restaurant_name,
    agent_name,
    order_amount,
    delivery_time_mins
FROM vw_daily_order_summary
WHERE order_date >= DATE_SUB('2026-10-27', INTERVAL 7 DAY)
ORDER BY order_date DESC, customer_name ASC;

-- ============================================================================
-- End of Section C Script
-- ============================================================================
