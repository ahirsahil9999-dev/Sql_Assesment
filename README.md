# TOPS Technologies — Data Analytics (Module 4: SQL for Data Analytics)
## Assessment Code: M4-A1 | MySQL Implementation & Submission Package

**Program:** Data Analytics  
**Module:** Module 4 – SQL for Data Analytics  
**Assessment Code:** M4-A1  
**Stack:** SQL (MySQL 8.0+ / 26.7+)  
**Total Allocated Time:** 3 Hours  

---

### General Instructions Compliance
- **All Sections Completed**: Section A, Section B, Section C, and Section D are fully attempted and organized into dedicated single section folders.
- **MySQL Native Syntax**: All queries are written strictly for MySQL (InnoDB engine).
- **Custom Schema & Sample Data**: Complete database schemas created with primary keys, foreign keys, constraints, and realistic sample data spanning Mumbai, Delhi, Bengaluru, Surat, and Pune.
- **Labels & Identification**: Every question, task, and query is labeled with its respective section and task identifier.
- **Query Output Screenshots**: All scripts were executed on live MySQL Server 26.7; screenshots of query outputs are placed in the respective `screenshots/` folders inside each section folder.

---

### Clean Directory Structure

```text
SQL_Asessment/
│
├── Section A/
│   ├── Section_A_Concept_Application.md       # In-depth theoretical solutions for Scenarios S1 – S6
│   └── section_a_concepts_demo.sql            # Runnable MySQL demo script for Section A concepts
│
├── Section B/
│   ├── Section_B_Practical_Tasks.md           # Markdown report with tasks & embedded screenshots
│   ├── section_b_practical_tasks.sql          # Unified SQL script for Tasks 1 – 4
│   ├── task1_menu_order_explorer.sql          # Task 1 standalone SQL script
│   ├── task2_restaurant_revenue_summary.sql   # Task 2 standalone SQL script
│   ├── task3_customer_order_restaurant_report.sql # Task 3 standalone SQL script
│   ├── task4_delivery_agent_performance_ranking.sql # Task 4 standalone SQL script
│   └── screenshots/
│       ├── task1_menu_order_explorer.png      # Query output for Task 1
│       ├── task2_restaurant_revenue_summary.png # Query output for Task 2
│       ├── task3_customer_order_restaurant_report.png # Query output for Task 3
│       └── task4_delivery_agent_performance_ranking.png # Query output for Task 4
│
├── Section C/
│   ├── Section_C_Mini_Capstone.md             # Capstone architecture, schema ER, and query analysis
│   ├── section_c_mini_capstone.sql            # Full backend schema (4 tables) + 6 business queries + View
│   └── screenshots/
│       ├── query1_restaurant_revenue_report.png # Query 1 output (>3 orders)
│       ├── query2_customer_segmentation.png   # Query 2 output (Platinum/Gold/Standard)
│       ├── query3_top3_restaurants_dense_rank.png # Query 3 output (DENSE_RANK top 3 per city)
│       ├── query4_recent_order_row_number.png # Query 4 output (ROW_NUMBER single recent order)
│       └── query5_6_vw_daily_order_summary.png # Query 5 & 6 output (View creation & 7-day filter)
│
├── Section D/
│   ├── Section_D_AI_Augmented_Learning.md     # Prompt, AI flawed query, bugs identified, corrected query, note
│   ├── section_d_ai_learning.sql              # Runnable debug & verification SQL script
│   └── screenshots/
│       └── section_d_ai_corrected_query.png   # Output screenshot of the verified production query
│
└── README.md                                  # Master index and execution guide
```

---

### How to Execute the SQL Scripts in MySQL

From your MySQL client (MySQL CLI or MySQL Workbench):
```sql
-- 1. Section A Concepts Demonstration
SOURCE Section A/section_a_concepts_demo.sql;

-- 2. Section B Practical Tasks (All Tasks 1 to 4)
SOURCE Section B/section_b_practical_tasks.sql;

-- 3. Section C Mini Capstone Project
SOURCE Section C/section_c_mini_capstone.sql;

-- 4. Section D AI-Augmented Learning
SOURCE Section D/section_d_ai_learning.sql;
```
