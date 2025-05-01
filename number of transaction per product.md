Here is a **detailed guide** for solving the SQL problem of finding the number of transactions per product using a `JOIN` and `GROUP BY`. This guide includes:

1. ✅ Problem Overview  
2. 📘 Learning Objective  
3. 🔧 Step-by-Step Approach  
4. 🧠 Pseudocode  
5. 💡 Final SQL Query  
6. 📤 Expected Output  
7. 🧪 Additional Tip  

---

### ✅ 1. Problem Overview

**Question:**  
Find the number of transactions that occurred for each product. Output the product name along with the corresponding number of transactions and order records by the product id in ascending order. You can ignore products without transactions.

🔍 By solving this, you'll learn how to use join with grouping. Give it a try and share the output! 👇

𝐒𝐜𝐡𝐞𝐦𝐚 𝐚𝐧𝐝 𝐃𝐚𝐭𝐚𝐬𝐞𝐭:
CREATE TABLE excel_sql_inventory_data (product_id INT,product_name VARCHAR(50),product_type VARCHAR(50),unit VARCHAR(20),price_unit FLOAT,wholesale FLOAT,current_inventory INT);

INSERT INTO excel_sql_inventory_data (product_id, product_name, product_type, unit, price_unit, wholesale, current_inventory) 
VALUES(1, 'strawberry', 'produce', 'lb', 3.28, 1.77, 13),(2, 'apple_fuji', 'produce', 'lb', 1.44, 0.43, 2),(3, 'orange', 'produce', 'lb', 1.02, 0.37, 2),(4, 'clementines', 'produce', 'lb', 1.19, 0.44, 44),(5, 'blood_orange', 'produce', 'lb', 3.86, 1.66, 19);

CREATE TABLE excel_sql_transaction_data (transaction_id INT PRIMARY KEY,time DATETIME,product_id INT);

INSERT INTO excel_sql_transaction_data (transaction_id, time, product_id) 
VALUES(153, '2016-01-06 08:57:52', 1),(91, '2016-01-07 12:17:27', 1),(31, '2016-01-05 13:19:25', 1),(24, '2016-01-03 10:47:44', 3),(4, '2016-01-06 17:57:42', 3),(163, '2016-01-03 10:11:22', 3),(92, '2016-01-08 12:03:20', 2),(32, '2016-01-04 19:37:14', 4),(253, '2016-01-06 14:15:20', 5),(118, '2016-01-06 14:27:33', 5);
------------

> Find the number of transactions that occurred for each product.  
> Output the product name along with the corresponding number of transactions and order records by the product id in ascending order.  
> Ignore products without transactions.

---

### 📘 2. Learning Objective

This problem helps you understand:

- How to use `JOIN` to combine data from multiple tables.
- How to use `GROUP BY` to aggregate data (e.g., count).
- How to use `ORDER BY` to sort the results.
- Real-world data relationships (inventory + transactions).

---

### 🔧 3. Step-by-Step Approach

Let’s break this down:

1. **Understand the schema**:
   - Table `excel_sql_inventory_data` holds product details.
   - Table `excel_sql_transaction_data` holds transactions per product.
   - Common field: `product_id`

2. **Goal**:
   - Count how many transactions exist per product.
   - Output: `product_id`, `product_name`, and `transaction_count`.
   - Sorted by `product_id`.
   - Exclude products with **no** transactions.

3. **Technique**:
   - Use an `INNER JOIN` to get matching records from both tables.
   - Use `GROUP BY` on `product_id` to count how many times each product appears in transactions.
   - Use `COUNT()` to get the total transactions per product.
   - Use `ORDER BY` for sorting.

---

### 🧠 4. Pseudocode

```sql
-- SELECT needed fields (product_id, product_name)
-- JOIN transaction table on product_id
-- GROUP BY product_id and product_name
-- COUNT number of transaction IDs
-- ORDER BY product_id

SELECT 
    i.product_id,
    i.product_name,
    COUNT(t.transaction_id) AS transaction_count
FROM 
    inventory_table AS i
JOIN 
    transaction_table AS t
ON 
    i.product_id = t.product_id
GROUP BY 
    i.product_id, i.product_name
ORDER BY 
    i.product_id ASC;
```

---

### 💡 5. Final SQL Query

Using your exact table and column names:

```sql
SELECT 
    i.product_id,
    i.product_name,
    COUNT(t.transaction_id) AS transaction_count
FROM 
    excel_sql_inventory_data i
JOIN 
    excel_sql_transaction_data t
ON 
    i.product_id = t.product_id
GROUP BY 
    i.product_id, i.product_name
ORDER BY 
    i.product_id ASC;
```

---

### 📤 6. Expected Output

| product_id | product_name   | transaction_count |
|------------|----------------|-------------------|
| 1          | strawberry     | 3                 |
| 2          | apple_fuji     | 1                 |
| 3          | orange         | 3                 |
| 4          | clementines    | 1                 |
| 5          | blood_orange   | 2                 |

---

### 🧪 7. Additional Tip: Include Products With Zero Transactions?

If you also wanted to include products that had **zero** transactions, you’d use a `LEFT JOIN` instead of an `INNER JOIN`, and `COUNT(t.transaction_id)` would be replaced with `COUNT(DISTINCT t.transaction_id)` or `COALESCE`.

But for this question, we use `INNER JOIN` to **ignore products without transactions**, as instructed.

---

Would you like me to help create a visual ER diagram for this too?