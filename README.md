# Retail Sales Analysis using PostgreSQL

An SQL project analysing sales, customers, employees and returns for a small electronics retailer. It builds a relational database in PostgreSQL and answers 15 business questions using joins, aggregation, subqueries, CTEs and window functions.

**Author:** [Your Name]
**Tools:** PostgreSQL 12 or later, pgAdmin / psql

---

## Repository Structure

```
retail-sales-analysis-sql/
├── README.md                     Project documentation and assumptions
├── sql/
│   ├── 01_schema.sql             Table definitions
│   ├── 02_data.sql               Sample data
│   └── 03_analysis_queries.sql   Queries for Q1–Q15
└── screenshots/                  Query outputs
```

## Database Schema

| Table | Description | Rows |
|---|---|---|
| customers | Customer details and signup date | 12 |
| products | Product catalogue with current price and stock | 10 |
| employees | Staff who handle orders | 5 |
| orders | Order header: customer, date, employee, status, payment method | 24 |
| order_items | Line items: product, quantity, price at sale, discount | 36 |
| returns | Return records for returned orders | 3 |

**Relationships**
- `orders.customer_id` → `customers.customer_id`
- `orders.employee_id` → `employees.employee_id`
- `order_items.order_id` → `orders.order_id`
- `order_items.product_id` → `products.product_id`
- `returns.order_id` → `orders.order_id`

## How to Run

1. Create the database (run this statement on its own):
```sql
   CREATE DATABASE retail_analysis;
```
2. Connect to `retail_analysis` (pgAdmin: open a Query Tool on that database; psql: `\c retail_analysis`).
3. Run the scripts in order: `01_schema.sql` → `02_data.sql` → `03_analysis_queries.sql`.

Using psql from a terminal:
```bash
psql -U postgres -c "CREATE DATABASE retail_analysis;"
psql -U postgres -d retail_analysis -f sql/01_schema.sql
psql -U postgres -d retail_analysis -f sql/02_data.sql
psql -U postgres -d retail_analysis -f sql/03_analysis_queries.sql
```

## Business Questions

| # | Concept | Question |
|---|---|---|
| Q1 | Filtering & sorting | Delivered orders between 1 Oct 2024 and 31 Mar 2025 |
| Q2 | Multi-table JOIN | Delivered orders with customer and employee names |
| Q3 | Aggregation & HAVING | Units sold and net revenue by category (above ₹10,000) |
| Q4 | Repeat customers | Customers with two or more delivered orders |
| Q5 | LEFT JOIN | Delivered order count for every customer, including zero |
| Q6 | Subquery | Products priced above the average product price |
| Q7 | NOT EXISTS | Customers who never placed a delivered order |
| Q8 | Date functions | Delivered orders and net revenue by year and month |
| Q9 | CASE expression | Stock level classification |
| Q10 | Conditional aggregation | Delivered / returned / cancelled counts per employee |
| Q11 | Window function (RANK) | Product revenue rank within each category |
| Q12 | Running total | Monthly net revenue with cumulative total |
| Q13 | Return analysis | Returned orders with pre-discount value |
| Q14 | CTE | Customers with above-average net revenue |
| Q15 | Business insight | Top 3 customers and their share of revenue |

## Metric Definitions

- **Net revenue** = `quantity × unit_price_at_sale × (1 − discount_rate)`, calculated for each order line and then summed.
- **Pre-discount value** = `quantity × unit_price_at_sale` (used in Q13).
- **Delivered order** = an order where `order_status = 'Delivered'`.

## Assumptions

### Revenue and pricing
1. Net revenue is calculated per line item using the formula above and then summed to order, customer, product, category or month level.
2. `discount_rate` is a fraction (0.05 = 5%) applied to that line item only, not to the whole order.
3. Revenue uses `unit_price_at_sale` (the price actually charged), not `products.unit_price` (the current catalogue price). The catalogue price is used only in Q6, which asks about product prices.
4. All amounts are in Indian Rupees (₹). Taxes, shipping and other charges are not in the data and are not considered.
5. Values are rounded to 2 decimal places only in the final output, not in intermediate calculations.

### Order status and returns
6. Only orders with status `'Delivered'` count as sales. `'Returned'` and `'Cancelled'` orders are excluded from all revenue figures.
7. Status values are stored exactly as `'Delivered'`, `'Returned'` and `'Cancelled'` (case-sensitive, no extra spaces).
8. A returned order is treated as a full return of all its items, because the `returns` table records returns at order level and has no item-level detail.
9. Each returned order has exactly one record in the `returns` table.
10. Returned orders are excluded from revenue entirely, rather than being counted as a sale and then subtracted as a refund.

### Dates
11. Revenue is assigned to the month of `order_date`, since no delivery or payment date is available.
12. Date ranges are inclusive. Q1 includes both 1 October 2024 and 31 March 2025. This works safely with `BETWEEN` because `order_date` is a DATE with no time part.

### Customers, employees and products
13. Each order is credited to the employee recorded on it, regardless of department (Support and Operations staff also handle orders).
14. A customer's location is taken from `customers.city`, not from the employee's branch city.
15. `stock_quantity` is a current stock snapshot and is not reduced by the orders in this dataset.
16. `stock_quantity` is never NULL. In Q9, a NULL value would otherwise fall into the `ELSE` branch.

### Query-specific
17. **Q3:** The ₹10,000 threshold applies to net revenue (after discount).
18. **Q4:** "At least two orders" counts delivered orders only.
19. **Q5, Q7, Q11:** These queries are written to handle zero-activity cases (LEFT JOIN, NOT EXISTS, COALESCE), even though in this dataset every customer has a delivered order and every product has delivered sales. Q7 therefore correctly returns no rows.
20. **Q6:** The average is a simple mean of the catalogue price of all 10 products, including unsold ones, not weighted by sales (₹5,249.00).
21. **Q11:** `RANK()` is used, so tied products share a rank and the next rank is skipped.
22. **Q14:** The average is calculated only across customers with at least one delivered purchase. In this dataset all 12 customers qualify, so it equals the average across all customers (₹13,683.97).
23. **Q15:** Percentage contribution is calculated against total delivered net revenue from all customers (₹1,64,207.63), not just the top three. `LIMIT 3` assumes there is no tie for third place, which holds for this data.

## Key Findings

- Of 24 orders, 19 were delivered, 3 returned (12.5%) and 2 cancelled. Total delivered net revenue is ₹1,64,207.63.
- Displays is the top category (₹41,547.23), driven entirely by the 27-inch Monitor. Peripherals (₹9,897.00) is the only category below ₹10,000.
- October 2024 was the strongest month (₹31,443.30) and April 2025 the weakest (₹3,798.00).
- The top three customers (Meera Patel, Ishaan Gupta and Myra Nair) contribute about 45% of delivered revenue.
- Noise-Cancelling Headphones were returned in 2 of the 3 orders that included them, which suggests a product quality or description issue.
- The three Low Stock products (Monitor, SSD, Chair) are also the three highest-revenue products, so they should be reordered first.
- Every customer has at least one delivered order, so Q7 returns an empty result.
