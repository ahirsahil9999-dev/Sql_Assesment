-- ============================================================================
-- Assessment Code: M4-A1 | Module 4: SQL for Data Analytics
-- SECTION D: AI-AUGMENTED LEARNING (DEBUGGING & VERIFICATION SCRIPT)
-- Database Engine: MySQL 8.0+ / 26.7+
-- ============================================================================

DROP DATABASE IF EXISTS section_d_ai_learning;
CREATE DATABASE section_d_ai_learning;
USE section_d_ai_learning;

-- ----------------------------------------------------------------------------
-- Step 1: Create Schema
-- ----------------------------------------------------------------------------
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS delivery_agents;

CREATE TABLE delivery_agents (
    agent_id INT PRIMARY KEY AUTO_INCREMENT,
    agent_name VARCHAR(100) NOT NULL,
    city VARCHAR(50) NOT NULL
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    agent_id INT NOT NULL,
    order_status VARCHAR(20) NOT NULL,
    delivery_time_mins INT NULL,
    order_date DATE NOT NULL,
    FOREIGN KEY (agent_id) REFERENCES delivery_agents(agent_id)
);

-- ----------------------------------------------------------------------------
-- Step 2: Insert Test Data
-- Needs agents with > 5 completed orders and <= 5 completed orders in cities
-- ----------------------------------------------------------------------------
INSERT INTO delivery_agents (agent_id, agent_name, city) VALUES
(1, 'Kunal Rao',     'Mumbai'),    -- 8 completed orders (Qualifies)
(2, 'Pooja Iyer',    'Mumbai'),    -- 7 completed orders (Qualifies)
(3, 'Nitin Patil',   'Mumbai'),    -- 6 completed orders (Qualifies)
(4, 'Suresh Rane',   'Mumbai'),    -- 3 completed orders (Does NOT qualify: <= 5)
(5, 'Amit Joshi',    'Delhi'),     -- 9 completed orders (Qualifies)
(6, 'Sanjay Yadav',  'Delhi'),     -- 7 completed orders (Qualifies)
(7, 'Deepak Soni',   'Delhi'),     -- 6 completed orders (Qualifies)
(8, 'Vikram Das',    'Bengaluru'), -- 8 completed orders (Qualifies)
(9, 'Rahul Nair',    'Bengaluru'), -- 7 completed orders (Qualifies)
(10,'Harish Gowda',  'Bengaluru'); -- 6 completed orders (Qualifies)

-- Insert orders for Kunal Rao (8 delivered)
INSERT INTO orders (agent_id, order_status, delivery_time_mins, order_date) VALUES
(1, 'Delivered', 22, '2026-10-10'),
(1, 'Delivered', 25, '2026-10-11'),
(1, 'Delivered', 20, '2026-10-12'),
(1, 'Delivered', 24, '2026-10-13'),
(1, 'Delivered', 23, '2026-10-14'),
(1, 'Delivered', 21, '2026-10-15'),
(1, 'Delivered', 26, '2026-10-16'),
(1, 'Delivered', 22, '2026-10-17');

-- Insert orders for Pooja Iyer (7 delivered, 1 cancelled)
INSERT INTO orders (agent_id, order_status, delivery_time_mins, order_date) VALUES
(2, 'Delivered', 28, '2026-10-10'),
(2, 'Delivered', 30, '2026-10-11'),
(2, 'Delivered', 29, '2026-10-12'),
(2, 'Delivered', 32, '2026-10-13'),
(2, 'Delivered', 27, '2026-10-14'),
(2, 'Delivered', 31, '2026-10-15'),
(2, 'Delivered', 29, '2026-10-16'),
(2, 'Cancelled', NULL, '2026-10-17');

-- Insert orders for Nitin Patil (6 delivered)
INSERT INTO orders (agent_id, order_status, delivery_time_mins, order_date) VALUES
(3, 'Delivered', 34, '2026-10-10'),
(3, 'Delivered', 35, '2026-10-11'),
(3, 'Delivered', 33, '2026-10-12'),
(3, 'Delivered', 36, '2026-10-13'),
(3, 'Delivered', 32, '2026-10-14'),
(3, 'Delivered', 35, '2026-10-15');

-- Insert orders for Suresh Rane (3 delivered - below threshold)
INSERT INTO orders (agent_id, order_status, delivery_time_mins, order_date) VALUES
(4, 'Delivered', 18, '2026-10-10'),
(4, 'Delivered', 19, '2026-10-11'),
(4, 'Delivered', 21, '2026-10-12');

-- Insert orders for Delhi agents
INSERT INTO orders (agent_id, order_status, delivery_time_mins, order_date) VALUES
(5, 'Delivered', 25, '2026-10-10'), (5, 'Delivered', 26, '2026-10-11'), (5, 'Delivered', 24, '2026-10-12'),
(5, 'Delivered', 28, '2026-10-13'), (5, 'Delivered', 27, '2026-10-14'), (5, 'Delivered', 25, '2026-10-15'),
(5, 'Delivered', 29, '2026-10-16'), (5, 'Delivered', 24, '2026-10-17'), (5, 'Delivered', 26, '2026-10-18'),
(6, 'Delivered', 31, '2026-10-10'), (6, 'Delivered', 30, '2026-10-11'), (6, 'Delivered', 32, '2026-10-12'),
(6, 'Delivered', 29, '2026-10-13'), (6, 'Delivered', 33, '2026-10-14'), (6, 'Delivered', 30, '2026-10-15'),
(6, 'Delivered', 31, '2026-10-16'),
(7, 'Delivered', 35, '2026-10-10'), (7, 'Delivered', 34, '2026-10-11'), (7, 'Delivered', 36, '2026-10-12'),
(7, 'Delivered', 33, '2026-10-13'), (7, 'Delivered', 37, '2026-10-14'), (7, 'Delivered', 35, '2026-10-15');

-- Insert orders for Bengaluru agents
INSERT INTO orders (agent_id, order_status, delivery_time_mins, order_date) VALUES
(8, 'Delivered', 23, '2026-10-10'), (8, 'Delivered', 22, '2026-10-11'), (8, 'Delivered', 24, '2026-10-12'),
(8, 'Delivered', 25, '2026-10-13'), (8, 'Delivered', 21, '2026-10-14'), (8, 'Delivered', 23, '2026-10-15'),
(8, 'Delivered', 22, '2026-10-16'), (8, 'Delivered', 24, '2026-10-17'),
(9, 'Delivered', 29, '2026-10-10'), (9, 'Delivered', 28, '2026-10-11'), (9, 'Delivered', 30, '2026-10-12'),
(9, 'Delivered', 27, '2026-10-13'), (9, 'Delivered', 31, '2026-10-14'), (9, 'Delivered', 29, '2026-10-15'),
(9, 'Delivered', 28, '2026-10-16'),
(10,'Delivered', 33, '2026-10-10'), (10,'Delivered', 35, '2026-10-11'), (10,'Delivered', 34, '2026-10-12'),
(10,'Delivered', 32, '2026-10-13'), (10,'Delivered', 36, '2026-10-14'), (10,'Delivered', 33, '2026-10-15');

-- ----------------------------------------------------------------------------
-- Step 3: Corrected & Optimized Production Query
-- ----------------------------------------------------------------------------
WITH qualified_agent_metrics AS (
    SELECT 
        da.city,
        da.agent_id,
        da.agent_name,
        COUNT(o.order_id) AS completed_orders,
        ROUND(AVG(o.delivery_time_mins), 2) AS avg_delivery_time
    FROM delivery_agents da
    INNER JOIN orders o ON da.agent_id = o.agent_id
    WHERE o.order_status = 'Delivered'
      AND o.delivery_time_mins IS NOT NULL
    GROUP BY 
        da.city, 
        da.agent_id, 
        da.agent_name
    HAVING 
        COUNT(o.order_id) > 5
),
ranked_city_agents AS (
    SELECT 
        city,
        agent_id,
        agent_name,
        completed_orders,
        avg_delivery_time,
        DENSE_RANK() OVER (
            PARTITION BY city 
            ORDER BY completed_orders DESC, avg_delivery_time ASC
        ) AS agent_rank
    FROM qualified_agent_metrics
)
SELECT 
    city,
    agent_rank,
    agent_id,
    agent_name,
    completed_orders,
    avg_delivery_time
FROM ranked_city_agents
WHERE agent_rank <= 3
ORDER BY 
    city ASC, 
    agent_rank ASC;

-- ============================================================================
-- End of Section D Script
-- ============================================================================
