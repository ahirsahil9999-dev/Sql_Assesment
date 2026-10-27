-- Assessment Code: M4-A1 | Module 4: SQL for Data Analytics
-- Section B - Task 2: Restaurant Revenue Summary
USE section_b_food_analytics;

-- 1. Create Table
DROP TABLE IF EXISTS delivery_orders;
CREATE TABLE delivery_orders (
    order_id INT PRIMARY KEY,
    restaurant_name VARCHAR(50) NOT NULL,
    city VARCHAR(50) NOT NULL,
    total_amount DECIMAL(10,2) NOT NULL,
    order_status VARCHAR(20) NOT NULL,
    order_date DATE NOT NULL
);

-- 2. Insert Sample Data (12 rows across 4 restaurants)
INSERT INTO delivery_orders (order_id, restaurant_name, city, total_amount, order_status, order_date) VALUES
(201, 'Royal Biryani',   'Mumbai',    3200.00, 'Delivered', '2026-10-01'),
(202, 'Royal Biryani',   'Mumbai',    4500.00, 'Delivered', '2026-10-03'),
(203, 'Royal Biryani',   'Mumbai',    3800.00, 'Delivered', '2026-10-06'),
(204, 'Green Leaf Cafe', 'Bengaluru', 2100.00, 'Delivered', '2026-10-02'),
(205, 'Green Leaf Cafe', 'Bengaluru', 2600.00, 'Delivered', '2026-10-07'),
(206, 'Green Leaf Cafe', 'Bengaluru', 2800.00, 'Delivered', '2026-10-12'),
(207, 'Tandoori Flame',  'Delhi',     1800.00, 'Delivered', '2026-10-04'),
(208, 'Tandoori Flame',  'Delhi',     1400.00, 'Delivered', '2026-10-10'),
(209, 'Tandoori Flame',  'Delhi',     1200.00, 'Delivered', '2026-10-15'),
(210, 'Wok & Roll',      'Mumbai',    4200.00, 'Delivered', '2026-10-05'),
(211, 'Wok & Roll',      'Mumbai',    4100.00, 'Delivered', '2026-10-11'),
(212, 'Wok & Roll',      'Mumbai',    3900.00, 'Delivered', '2026-10-16');

-- Query 1: Total Revenue, Total Orders, Average Order Value per restaurant
SELECT 
    restaurant_name,
    COUNT(order_id) AS total_orders,
    SUM(total_amount) AS total_revenue,
    ROUND(AVG(total_amount), 2) AS average_order_value
FROM delivery_orders
GROUP BY restaurant_name;

-- Query 2: HAVING clause filtering total revenue > Rs 5,000
SELECT 
    restaurant_name,
    COUNT(order_id) AS total_orders,
    SUM(total_amount) AS total_revenue,
    ROUND(AVG(total_amount), 2) AS average_order_value
FROM delivery_orders
GROUP BY restaurant_name
HAVING SUM(total_amount) > 5000;

-- Query 3: CASE WHEN labeling ('High Revenue' if > 10,000, else 'Moderate Revenue')
SELECT 
    restaurant_name,
    COUNT(order_id) AS total_orders,
    SUM(total_amount) AS total_revenue,
    ROUND(AVG(total_amount), 2) AS average_order_value,
    CASE 
        WHEN SUM(total_amount) > 10000 THEN 'High Revenue'
        ELSE 'Moderate Revenue'
    END AS revenue_tier
FROM delivery_orders
GROUP BY restaurant_name
HAVING SUM(total_amount) > 5000
ORDER BY total_revenue DESC;
