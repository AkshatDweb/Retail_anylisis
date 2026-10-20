Create DATABASE Retail_Anylysis;

-- ===== CREATE TABLES =====


CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL,
    city VARCHAR(60),
    state VARCHAR(60),
    signup_date DATE
);

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(120) NOT NULL,
    category VARCHAR(60),
    unit_price NUMERIC(10,2),
    stock_quantity INT
);

CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(100) NOT NULL,
    department VARCHAR(60),
    branch_city VARCHAR(60),
    monthly_salary NUMERIC(10,2)
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT REFERENCES customers(customer_id),
    order_date DATE,
    employee_id INT REFERENCES employees(employee_id),
    order_status VARCHAR(30),
    payment_method VARCHAR(30)
);

CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY,
    order_id INT REFERENCES orders(order_id),
    product_id INT REFERENCES products(product_id),
    quantity INT,
    unit_price_at_sale NUMERIC(10,2),
    discount_rate NUMERIC(4,2)
);

CREATE TABLE returns (
    return_id INT PRIMARY KEY,
    order_id INT REFERENCES orders(order_id),
    return_date DATE,
    return_reason VARCHAR(120)
);



-- ===== INSERT DATA =====


INSERT INTO customers VALUES
(1001, 'Aarav Sharma', 'aarav.sharma@example.com', 'Lucknow', 'Uttar Pradesh', '2024-01-15'),
(1002, 'Diya Verma', 'diya.verma@example.com', 'Kanpur', 'Uttar Pradesh', '2024-02-10'),
(1003, 'Kabir Singh', 'kabir.singh@example.com', 'Delhi', 'Delhi', '2023-11-22'),
(1004, 'Meera Patel', 'meera.patel@example.com', 'Jaipur', 'Rajasthan', '2024-03-05'),
(1005, 'Ishaan Gupta', 'ishaan.gupta@example.com', 'Lucknow', 'Uttar Pradesh', '2023-08-19'),
(1006, 'Ananya Rao', 'ananya.rao@example.com', 'Bhopal', 'Madhya Pradesh', '2024-04-12'),
(1007, 'Reyansh Khan', 'reyansh.khan@example.com', 'Delhi', 'Delhi', '2024-05-01'),
(1008, 'Saanvi Joshi', 'saanvi.joshi@example.com', 'Pune', 'Maharashtra', '2023-12-09'),
(1009, 'Vivaan Mishra', 'vivaan.mishra@example.com', 'Lucknow', 'Uttar Pradesh', '2024-06-17'),
(1010, 'Aditi Das', 'aditi.das@example.com', 'Kolkata', 'West Bengal', '2024-07-02'),
(1011, 'Arjun Mehta', 'arjun.mehta@example.com', 'Jaipur', 'Rajasthan', '2023-09-14'),
(1012, 'Myra Nair', 'myra.nair@example.com', 'Mumbai', 'Maharashtra', '2024-08-21');

INSERT INTO products VALUES
(201, 'Wireless Mouse', 'Accessories', 799.00, 80),
(202, 'Mechanical Keyboard', 'Accessories', 2499.00, 35),
(203, 'USB-C Hub', 'Accessories', 1899.00, 42),
(204, '27-inch Monitor', 'Displays', 14999.00, 18),
(205, 'Laptop Stand', 'Accessories', 1299.00, 55),
(206, 'Webcam HD', 'Peripherals', 3299.00, 24),
(207, 'Noise-Cancelling Headphones', 'Audio', 5999.00, 20),
(208, 'Bluetooth Speaker', 'Audio', 2199.00, 30),
(209, 'External SSD 1TB', 'Storage', 7499.00, 16),
(210, 'Ergonomic Chair', 'Furniture', 11999.00, 12);

INSERT INTO employees VALUES
(301, 'Nisha Kapoor', 'Sales', 'Lucknow', 52000),
(302, 'Rahul Bansal', 'Sales', 'Delhi', 58000),
(303, 'Pooja Iyer', 'Support', 'Lucknow', 44000),
(304, 'Karan Malhotra', 'Operations', 'Jaipur', 49000),
(305, 'Sneha Kulkarni', 'Sales', 'Pune', 61000);

INSERT INTO orders VALUES
(5001, 1001, '2024-09-02', 301, 'Delivered', 'UPI'),
(5002, 1002, '2024-09-05', 302, 'Delivered', 'Card'),
(5003, 1003, '2024-09-07', 302, 'Returned', 'Card'),
(5004, 1001, '2024-09-15', 301, 'Delivered', 'UPI'),
(5005, 1004, '2024-10-01', 304, 'Delivered', 'Cash'),
(5006, 1005, '2024-10-04', 301, 'Delivered', 'Card'),
(5007, 1006, '2024-10-11', 303, 'Cancelled', 'UPI'),
(5008, 1007, '2024-10-18', 302, 'Delivered', 'Card'),
(5009, 1008, '2024-11-02', 305, 'Delivered', 'Wallet'),
(5010, 1009, '2024-11-10', 301, 'Returned', 'UPI'),
(5011, 1010, '2024-11-15', 304, 'Delivered', 'Card'),
(5012, 1011, '2024-12-01', 304, 'Delivered', 'Cash'),
(5013, 1012, '2024-12-09', 305, 'Delivered', 'Wallet'),
(5014, 1003, '2025-01-05', 302, 'Delivered', 'Card'),
(5015, 1002, '2025-01-12', 302, 'Delivered', 'UPI'),
(5016, 1005, '2025-01-20', 301, 'Delivered', 'Card'),
(5017, 1006, '2025-02-02', 303, 'Delivered', 'UPI'),
(5018, 1007, '2025-02-14', 302, 'Returned', 'Card'),
(5019, 1008, '2025-03-01', 305, 'Delivered', 'Wallet'),
(5020, 1009, '2025-03-15', 301, 'Delivered', 'UPI'),
(5021, 1010, '2025-04-03', 304, 'Cancelled', 'Cash'),
(5022, 1011, '2025-04-22', 304, 'Delivered', 'Card'),
(5023, 1012, '2025-05-07', 305, 'Delivered', 'Wallet'),
(5024, 1004, '2025-05-19', 304, 'Delivered', 'UPI');

INSERT INTO order_items VALUES
(1, 5001, 201, 2, 799, 0.05),
(2, 5001, 203, 1, 1899, 0.00),
(3, 5002, 202, 1, 2499, 0.10),
(4, 5002, 205, 2, 1299, 0.00),
(5, 5003, 207, 1, 5999, 0.00),
(6, 5004, 204, 1, 14999, 0.08),
(7, 5004, 201, 1, 799, 0.00),
(8, 5005, 210, 1, 11999, 0.05),
(9, 5006, 209, 1, 7499, 0.10),
(10, 5006, 203, 2, 1899, 0.00),
(11, 5007, 206, 1, 3299, 0.00),
(12, 5008, 207, 1, 5999, 0.15),
(13, 5008, 208, 2, 2199, 0.00),
(14, 5009, 202, 1, 2499, 0.05),
(15, 5009, 206, 1, 3299, 0.00),
(16, 5010, 204, 1, 14999, 0.00),
(17, 5011, 208, 3, 2199, 0.10),
(18, 5012, 210, 1, 11999, 0.00),
(19, 5013, 209, 2, 7499, 0.05),
(20, 5014, 202, 2, 2499, 0.00),
(21, 5014, 203, 1, 1899, 0.05),
(22, 5015, 205, 1, 1299, 0.00),
(23, 5015, 201, 3, 799, 0.10),
(24, 5016, 204, 1, 14999, 0.05),
(25, 5017, 206, 2, 3299, 0.00),
(26, 5017, 208, 1, 2199, 0.00),
(27, 5018, 207, 1, 5999, 0.00),
(28, 5019, 209, 1, 7499, 0.10),
(29, 5020, 203, 2, 1899, 0.00),
(30, 5020, 201, 1, 799, 0.00),
(31, 5021, 210, 1, 11999, 0.00),
(32, 5022, 202, 1, 2499, 0.00),
(33, 5022, 205, 1, 1299, 0.00),
(34, 5023, 209, 1, 7499, 0.00),
(35, 5024, 204, 1, 14999, 0.10),
(36, 5024, 205, 2, 1299, 0.00);

INSERT INTO returns VALUES
(9001, 5003, '2024-09-20', 'Damaged item'),
(9002, 5010, '2024-11-17', 'Changed mind'),
(9003, 5018, '2025-02-20', 'Product not as expected');


--Q1. Basic filtering and sorting

--List delivered orders placed between 1 October 2024 and 31 March 2025, showing order_id, order_date, customer_id, and payment_method. Sort by order_date descending.

SELECT order_id, order_date, customer_id, payment_method
FROM orders
WHERE order_status = 'Delivered'
  AND order_date BETWEEN DATE '2024-10-01' AND DATE '2025-03-31'
ORDER BY order_date DESC;

--Q2. Multi-table JOIN.

--Display each delivered order with customer_name, order_id, order_date, employee_name, and order_status. Include only orders with matching customer and employee records.

SELECT c.customer_name, o.order_id, o.order_date, e.employee_name, o.order_status
FROM orders o
JOIN customers c ON c.customer_id = o.customer_id
JOIN employees e ON e.employee_id = o.employee_id
WHERE o.order_status = 'Delivered'
ORDER BY o.order_date;

--Q3. Aggregation and HAVING.

--For each product category, calculate total units sold and net revenue from delivered orders. Show only categories with net revenue greater than ₹10,000; sort by net revenue descending.

SELECT p.category,
       SUM(oi.quantity) AS total_units_sold,
       ROUND(SUM(oi.quantity * oi.unit_price_at_sale * (1 - oi.discount_rate)), 2) AS net_revenue
FROM order_items oi
JOIN orders o   ON o.order_id = oi.order_id
JOIN products p ON p.product_id = oi.product_id
WHERE o.order_status = 'Delivered'
GROUP BY p.category
HAVING SUM(oi.quantity * oi.unit_price_at_sale * (1 - oi.discount_rate)) > 10000
ORDER BY net_revenue DESC;

--Q4.Customers with repeat purchases

--Find customers who have placed at least two delivered orders. Show customer_id, customer_name, number of delivered orders, and total net spend.

SELECT c.customer_id, c.customer_name,
       COUNT(DISTINCT o.order_id) AS delivered_orders,
       ROUND(SUM(oi.quantity * oi.unit_price_at_sale * (1 - oi.discount_rate)), 2) AS total_net_spend
FROM customers c
JOIN orders o       ON o.customer_id = c.customer_id
JOIN order_items oi ON oi.order_id = o.order_id
WHERE o.order_status = 'Delivered'
GROUP BY c.customer_id, c.customer_name
HAVING COUNT(DISTINCT o.order_id) >= 2
ORDER BY total_net_spend DESC;

--Q5. LEFT JOIN and zero activity

--List all customers and the number of delivered orders each has placed, including customers with zero delivered orders.

SELECT c.customer_id, c.customer_name,
       COUNT(o.order_id) AS delivered_orders
FROM customers c
LEFT JOIN orders o
       ON o.customer_id = c.customer_id
      AND o.order_status = 'Delivered'
GROUP BY c.customer_id, c.customer_name
ORDER BY delivered_orders DESC, c.customer_id;

--Q6. Subquery 
--Find products whose unit_price is greater than the average unit_price of all products. Display product name, category, unit price, and the overall average price.

SELECT product_name,
       category,
       unit_price,
       ROUND((SELECT AVG(unit_price) FROM products), 2) AS overall_avg_price
FROM products
WHERE unit_price > (SELECT AVG(unit_price) FROM products)
ORDER BY unit_price DESC;

--Q7. NOT EXISTS 
--Find customers who have never placed a delivered order. Return their customer_id, customer_name,and city.

SELECT c.customer_id,
       c.customer_name,
       c.city
FROM customers c
WHERE NOT EXISTS (
    SELECT 1
    FROM orders o
    WHERE o.customer_id = c.customer_id
      AND o.order_status = 'Delivered');

--Q8. Date functions 
--Group delivered orders by year and month, showing the number of orders and net revenue for eachmonth. Sort chronologically.

SELECT EXTRACT(YEAR  FROM o.order_date)::INT AS order_year,
       EXTRACT(MONTH FROM o.order_date)::INT AS order_month,
       COUNT(DISTINCT o.order_id)            AS delivered_orders,
       ROUND(SUM(oi.quantity * oi.unit_price_at_sale * (1 - oi.discount_rate)), 2) AS net_revenue
FROM orders o
JOIN order_items oi ON oi.order_id = o.order_id
WHERE o.order_status = 'Delivered'
GROUP BY order_year, order_month
ORDER BY order_year, order_month;

--Q9. CASE expression 
--Classify each product as 'Low Stock' when stock_quantity < 20, 'Moderate Stock' whenstock_quantity is between 20 and 40 inclusive, and 'High Stock' when stock_quantity > 40. Display product_name, stock_quantity, and stock label.

SELECT product_name,
       stock_quantity,
       CASE
           WHEN stock_quantity < 20               THEN 'Low Stock'
           WHEN stock_quantity BETWEEN 20 AND 40  THEN 'Moderate Stock'
           ELSE 'High Stock'
       END AS stock_label
FROM products
ORDER BY stock_quantity;

--Q10. Conditional aggregation 
--For each employee, calculate delivered, returned, and cancelled order counts using conditional aggregation. Include employees with no orders.

SELECT e.employee_id,
       e.employee_name,
       SUM(CASE WHEN o.order_status = 'Delivered' THEN 1 ELSE 0 END) AS delivered_orders,
       SUM(CASE WHEN o.order_status = 'Returned'  THEN 1 ELSE 0 END) AS returned_orders,
       SUM(CASE WHEN o.order_status = 'Cancelled' THEN 1 ELSE 0 END) AS cancelled_orders
FROM employees e
LEFT JOIN orders o ON o.employee_id = e.employee_id
GROUP BY e.employee_id, e.employee_name
ORDER BY e.employee_id;

--Q11. Window function – ranking 
--Rank products within each category by net revenue from delivered orders, highest first. Show category, product_name, net revenue, and rank. Products with no delivered sales should still be eligible to appear with zero revenue.

WITH product_revenue AS (
    SELECT oi.product_id,
           SUM(oi.quantity * oi.unit_price_at_sale * (1 - oi.discount_rate)) AS net_revenue
    FROM order_items oi
    JOIN orders o ON o.order_id = oi.order_id
    WHERE o.order_status = 'Delivered'
    GROUP BY oi.product_id
)
SELECT p.category,
       p.product_name,
       ROUND(COALESCE(pr.net_revenue, 0), 2) AS net_revenue,
       RANK() OVER (PARTITION BY p.category
                    ORDER BY COALESCE(pr.net_revenue, 0) DESC) AS revenue_rank
FROM products p
LEFT JOIN product_revenue pr ON pr.product_id = p.product_id
ORDER BY p.category, revenue_rank;

--Q12. Running total 
--For each month, calculate delivered-order net revenue and a cumulative running total of revenue across months in chronological order.

WITH monthly AS (
    SELECT DATE_TRUNC('month', o.order_date)::DATE AS month_start,
           SUM(oi.quantity * oi.unit_price_at_sale * (1 - oi.discount_rate)) AS net_revenue
    FROM orders o
    JOIN order_items oi ON oi.order_id = o.order_id
    WHERE o.order_status = 'Delivered'
    GROUP BY month_start
)
SELECT TO_CHAR(month_start, 'YYYY-MM') AS month,
       ROUND(net_revenue, 2)           AS net_revenue,
       ROUND(SUM(net_revenue) OVER (ORDER BY month_start
                                    ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW), 2) AS running_total
FROM monthly
ORDER BY month_start;

--Q13. Return analysis 
--List each returned order with customer name, return date, return reason, and the total pre-discount value of its order items.

SELECT o.order_id,
       c.customer_name,
       r.return_date,
       r.return_reason,
       SUM(oi.quantity * oi.unit_price_at_sale) AS pre_discount_value
FROM returns r
JOIN orders o       ON o.order_id = r.order_id
JOIN customers c    ON c.customer_id = o.customer_id
JOIN order_items oi ON oi.order_id = o.order_id
GROUP BY o.order_id, c.customer_name, r.return_date, r.return_reason
ORDER BY r.return_date;

--Q14. CTE 
--Using a CTE, calculate net revenue per customer from delivered orders, then return customers whose net revenue is above the average customer net revenue. State whether the average is calculated across all customers or only customers with delivered purchases.

WITH customer_revenue AS (
    SELECT c.customer_id,
           c.customer_name,
           SUM(oi.quantity * oi.unit_price_at_sale * (1 - oi.discount_rate)) AS net_revenue
    FROM customers c
    JOIN orders o       ON o.customer_id = c.customer_id
    JOIN order_items oi ON oi.order_id = o.order_id
    WHERE o.order_status = 'Delivered'
    GROUP BY c.customer_id, c.customer_name
)
SELECT customer_id,
       customer_name,
       ROUND(net_revenue, 2) AS net_revenue,
       ROUND((SELECT AVG(net_revenue) FROM customer_revenue), 2) AS avg_customer_revenue
FROM customer_revenue
WHERE net_revenue > (SELECT AVG(net_revenue) FROM customer_revenue)
ORDER BY net_revenue DESC;

--Q15. Business insight query
--Identify the top three customers by delivered net spend. Show customer name, number of delivered orders, net spend, and each customer's percentage contribution to total delivered net revenue.
   
WITH customer_spend AS (
    SELECT c.customer_id,
           c.customer_name,
           COUNT(DISTINCT o.order_id) AS delivered_orders,
           SUM(oi.quantity * oi.unit_price_at_sale * (1 - oi.discount_rate)) AS net_spend
    FROM customers c
    JOIN orders o       ON o.customer_id = c.customer_id
    JOIN order_items oi ON oi.order_id = o.order_id
    WHERE o.order_status = 'Delivered'
    GROUP BY c.customer_id, c.customer_name
)
SELECT customer_name,
       delivered_orders,
       ROUND(net_spend, 2) AS net_spend,
       ROUND(100.0 * net_spend / SUM(net_spend) OVER (), 2) AS pct_of_total_revenue
FROM customer_spend
ORDER BY net_spend DESC
LIMIT 3;

