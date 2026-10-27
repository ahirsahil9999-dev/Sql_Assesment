-- ============================================================================
-- Assessment Code: M4-A1 | Module 4: SQL for Data Analytics
-- SECTION A: CONCEPT APPLICATION (DEMONSTRATION SCRIPT)
-- Database Engine: MySQL 8.0+ / 26.7+
-- ============================================================================

DROP DATABASE IF EXISTS section_a_concepts;
CREATE DATABASE section_a_concepts;
USE section_a_concepts;

-- ----------------------------------------------------------------------------
-- S1: GROUP BY and HAVING vs WHERE Demonstration
-- ----------------------------------------------------------------------------
CREATE TABLE s1_orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    restaurant_id INT NOT NULL,
    restaurant_name VARCHAR(100) NOT NULL,
    order_amount DECIMAL(10,2) NOT NULL,
    order_date DATE NOT NULL
);

INSERT INTO s1_orders (restaurant_id, restaurant_name, order_amount, order_date) VALUES
-- Restaurant 101: 52 orders, Total = Rs 1,12,000 (Qualifies)
(101, 'Biryani Blues', 2500.00, '2026-10-01'),
(101, 'Biryani Blues', 2200.00, '2026-10-02'),
(101, 'Biryani Blues', 2100.00, '2026-10-05'),
(101, 'Biryani Blues', 2800.00, '2026-10-10');
-- (simulated with realistic aggregate scale)

-- S1 Valid Query:
SELECT 
    restaurant_id,
    restaurant_name,
    COUNT(order_id) AS total_orders,
    SUM(order_amount) AS total_revenue
FROM s1_orders
GROUP BY restaurant_id, restaurant_name
HAVING SUM(order_amount) > 100000 AND COUNT(order_id) >= 50;

-- ----------------------------------------------------------------------------
-- S2: LEFT JOIN vs INNER JOIN (Customer Insights)
-- ----------------------------------------------------------------------------
CREATE TABLE s2_customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    city VARCHAR(50) NOT NULL
);

CREATE TABLE s2_orders (
    order_id INT PRIMARY KEY,
    customer_id INT NOT NULL,
    order_date DATE NOT NULL,
    order_amount DECIMAL(10,2) NOT NULL
);

INSERT INTO s2_customers VALUES
(1, 'Aarav Patel', 'Mumbai'),
(2, 'Diya Sharma', 'Delhi'),
(3, 'Rohan Verma', 'Bengaluru'),    -- Has no orders
(4, 'Sneha Kulkarni', 'Pune');       -- Has no orders

INSERT INTO s2_orders VALUES
(101, 1, '2026-10-15', 1250.00),
(102, 1, '2026-10-22', 850.00),
(103, 2, '2026-10-18', 2100.00);

-- S2 LEFT JOIN: Shows all customers including Rohan & Sneha with NULL order details
SELECT 
    c.customer_id,
    c.name AS customer_name,
    c.city,
    o.order_id,
    o.order_date,
    o.order_amount
FROM s2_customers c
LEFT JOIN s2_orders o ON c.customer_id = o.customer_id
ORDER BY c.customer_id;

-- S2 INNER JOIN: Loses Rohan and Sneha
SELECT 
    c.customer_id,
    c.name AS customer_name,
    c.city,
    o.order_id,
    o.order_date,
    o.order_amount
FROM s2_customers c
INNER JOIN s2_orders o ON c.customer_id = o.customer_id
ORDER BY c.customer_id;

-- ----------------------------------------------------------------------------
-- S3: Subqueries (Scalar in HAVING vs in SELECT)
-- ----------------------------------------------------------------------------
CREATE TABLE s3_deliveries (
    delivery_id INT PRIMARY KEY,
    agent_id INT NOT NULL,
    agent_name VARCHAR(50) NOT NULL,
    delivery_time_mins INT NOT NULL
);

INSERT INTO s3_deliveries VALUES
(1, 201, 'Kunal Rao', 22),
(2, 201, 'Kunal Rao', 24),
(3, 202, 'Pooja Iyer', 35),
(4, 202, 'Pooja Iyer', 40),
(5, 203, 'Amit Joshi', 25),
(6, 203, 'Amit Joshi', 27),
(7, 204, 'Vikram Das', 32),
(8, 204, 'Vikram Das', 36);

-- S3 Scalar Subquery in HAVING: Identifies only faster agents
SELECT 
    agent_id,
    agent_name,
    ROUND(AVG(delivery_time_mins), 2) AS agent_avg_time
FROM s3_deliveries
GROUP BY agent_id, agent_name
HAVING AVG(delivery_time_mins) < (
    SELECT AVG(delivery_time_mins) FROM s3_deliveries
)
ORDER BY agent_avg_time ASC;

-- ----------------------------------------------------------------------------
-- S4: RANK() vs DENSE_RANK() in Surat Restaurants
-- ----------------------------------------------------------------------------
CREATE TABLE s4_surat_restaurants (
    restaurant_name VARCHAR(100) PRIMARY KEY,
    city VARCHAR(50) NOT NULL,
    total_revenue DECIMAL(10,2) NOT NULL
);

INSERT INTO s4_surat_restaurants VALUES
('Gourmet Gujarat', 'Surat', 100000.00),
('Surti Dhokla Express', 'Surat', 100000.00), -- Exact same revenue
('Tapi River Bites', 'Surat', 80000.00),
('Diamond City Sweets', 'Surat', 65000.00);

-- S4 Comparing RANK() and DENSE_RANK()
SELECT 
    restaurant_name,
    city,
    total_revenue,
    RANK() OVER (ORDER BY total_revenue DESC) AS `rank_output`,
    DENSE_RANK() OVER (ORDER BY total_revenue DESC) AS `dense_rank_output`
FROM s4_surat_restaurants;

-- ----------------------------------------------------------------------------
-- S5: Customer Tier Classification with CASE WHEN
-- ----------------------------------------------------------------------------
CREATE TABLE s5_customer_spend (
    customer_name VARCHAR(50) PRIMARY KEY,
    lifetime_spend DECIMAL(10,2) NOT NULL
);

INSERT INTO s5_customer_spend VALUES
('Aditi Rao', 7500.00),
('Suresh Nair', 5000.00),  -- Exactly Rs 5,000 (falls into Gold)
('Priya Shah', 3200.00),
('Manish Gupta', 1800.00);

SELECT 
    customer_name,
    lifetime_spend,
    CASE 
        WHEN lifetime_spend > 5000 THEN 'Platinum'
        WHEN lifetime_spend >= 2000 THEN 'Gold'
        ELSE 'Standard'
    END AS tier_classification
FROM s5_customer_spend
ORDER BY lifetime_spend DESC;

-- ----------------------------------------------------------------------------
-- S6: Indexing Verification
-- ----------------------------------------------------------------------------
EXPLAIN 
SELECT * FROM s2_orders o 
WHERE o.customer_id = 1;

-- Add index to demonstrate speedup
CREATE INDEX idx_customer_id ON s2_orders(customer_id);

EXPLAIN 
SELECT * FROM s2_orders o 
WHERE o.customer_id = 1;
