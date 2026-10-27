-- Assessment Code: M4-A1 | Module 4: SQL for Data Analytics
-- Section B - Task 4: Delivery Agent Performance Ranking
USE section_b_food_analytics;

-- 1. Create Table
DROP TABLE IF EXISTS deliveries;
CREATE TABLE deliveries (
    delivery_id INT PRIMARY KEY,
    agent_name VARCHAR(50) NOT NULL,
    restaurant_name VARCHAR(50) NOT NULL,
    delivery_time_mins INT NOT NULL,
    order_date DATE NOT NULL
);

-- 2. Insert Sample Data (12 rows across 4 agents with varied times)
INSERT INTO deliveries (delivery_id, agent_name, restaurant_name, delivery_time_mins, order_date) VALUES
(301, 'Kunal Rao',     'Spice Route',     22, '2026-10-15'),
(302, 'Kunal Rao',     'Pizza Express',   25, '2026-10-16'),
(303, 'Kunal Rao',     'Burger Bistro',   21, '2026-10-17'),
(304, 'Amit Joshi',    'Punjab Grill',    26, '2026-10-15'),
(305, 'Amit Joshi',    'South Tiffin',    28, '2026-10-18'),
(306, 'Amit Joshi',    'Coastal Curries', 27, '2026-10-20'),
(307, 'Vikram Das',    'Beijing Bites',   32, '2026-10-16'),
(308, 'Vikram Das',    'Royal Biryani',   34, '2026-10-19'),
(309, 'Vikram Das',    'Wok & Roll',      33, '2026-10-21'),
(310, 'Pooja Iyer',    'Green Leaf Cafe', 38, '2026-10-17'),
(311, 'Pooja Iyer',    'Tandoori Flame',  42, '2026-10-20'),
(312, 'Pooja Iyer',    'Spice Route',     36, '2026-10-22');

-- Query: CTE + RANK() + Scalar Subquery + CASE WHEN Classification
WITH agent_stats AS (
    SELECT 
        agent_name,
        COUNT(delivery_id) AS total_deliveries,
        ROUND(AVG(delivery_time_mins), 2) AS avg_delivery_time
    FROM deliveries
    GROUP BY agent_name
)
SELECT 
    agent_name,
    total_deliveries,
    avg_delivery_time,
    (SELECT ROUND(AVG(delivery_time_mins), 2) FROM deliveries) AS platform_avg_time,
    RANK() OVER (ORDER BY avg_delivery_time ASC) AS speed_rank,
    CASE 
        WHEN avg_delivery_time <= (SELECT AVG(delivery_time_mins) FROM deliveries) THEN 'On Track'
        ELSE 'Needs Improvement'
    END AS performance_status
FROM agent_stats
ORDER BY speed_rank ASC;
