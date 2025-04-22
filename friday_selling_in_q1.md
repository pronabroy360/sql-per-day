### Problem:
IBM is working on a new feature to analyze user purchasing behavior for all Fridays in the first quarter of the year. For each Friday separately, calculate the average amount users have spent per order. The output should contain the week number of that Friday and average amount spent.

🔍 By solving this, you'll learn how to handle date and time by the end of the day. Give it a try! 👇

𝐒𝐜𝐡𝐞𝐦𝐚 𝐚𝐧𝐝 𝐃𝐚𝐭𝐚𝐬𝐞𝐭:
CREATE TABLE user_purchases(user_id int, date date, amount_spent float, day_name varchar(15));

INSERT INTO user_purchases VALUES(1047,'2023-01-01',288,'Sunday'),(1099,'2023-01-04',803,'Wednesday'),(1055,'2023-01-07',546,'Saturday'),(1040,'2023-01-10',680,'Tuesday'),(1052,'2023-01-13',889,'Friday'),(1052,'2023-01-13',596,'Friday'),(1016,'2023-01-16',960,'Monday'),(1023,'2023-01-17',861,'Tuesday'),(1010,'2023-01-19',758,'Thursday'),(1013,'2023-01-19',346,'Thursday'),(1069,'2023-01-21',541,'Saturday'),(1030,'2023-01-22',175,'Sunday'),(1034,'2023-01-23',707,'Monday'),(1019,'2023-01-25',253,'Wednesday'),(1052,'2023-01-25',868,'Wednesday'),(1095,'2023-01-27',424,'Friday'),(1017,'2023-01-28',755,'Saturday'),(1010,'2023-01-29',615,'Sunday'),(1063,'2023-01-31',534,'Tuesday'),(1019,'2023-02-03',185,'Friday'),(1019,'2023-02-03',995,'Friday'),(1092,'2023-02-06',796,'Monday'),(1058,'2023-02-09',384,'Thursday'),(1055,'2023-02-12',319,'Sunday'),(1090,'2023-02-15',168,'Wednesday'),(1090,'2023-02-18',146,'Saturday'),(1062,'2023-02-21',193,'Tuesday'),(1023,'2023-02-24',259,'Friday');
-------------
 
### 🧠 Problem Recap:
IBM wants to analyze **user purchasing behavior** for **Fridays** in the **first quarter (Q1: Jan–Mar)**.

Your goal:
1. **For each Friday**, calculate:
   - the **average amount spent per order**
   - the **week number**
2. Return a table like:

| week_number | avg_amount_spent |
|-------------|------------------|
| 2           | 742.50           |
| 4           | 424.00           |
| 5           | 590.00           |
| 8           | 259.00           |

---

### ✅ Step-by-Step SQL Explanation

#### 🔹 Step 1: Use a CTE (`WITH`)
You're writing a Common Table Expression to:
- Make your code clean and readable
- Filter down to just the data you need before aggregation

```sql
WITH q1_fridays AS (
  SELECT 
    user_id,
    date,
    amount_spent,
    DATEPART(week, date) AS week_number,
    day_name
  FROM user_purchases
  WHERE 
    day_name = 'Friday' AND
    DATEPART(month, date) IN (1, 2, 3)
)
```

##### 🧩 What this does:
- Selects all **purchases made on Fridays**
- **Limits** the results to the **first quarter** (January, February, March)
- Extracts the **week number** using `DATEPART(week, date)`
- Outputs a temporary table named `q1_fridays`

✅ *This gives us all Friday purchases in Q1, with week number included.*

---

#### 🔹 Step 2: Aggregate the data
Now, you take the CTE and **group it by week number** to get the average amount per week.

```sql
SELECT 
  week_number,
  ROUND(AVG(amount_spent), 2) AS avg_amount_spent
FROM 
  q1_fridays
GROUP BY 
  week_number
ORDER BY 
  week_number;
```

##### 🧩 What this does:
- `AVG(amount_spent)` calculates the **average per Friday/week**
- `ROUND(..., 2)` makes the numbers readable — 2 decimal places
- `GROUP BY week_number` groups the Friday orders week-by-week
- `ORDER BY week_number` ensures your output is in chronological order

---

### 📊 Final Output Example (Based on Your Sample Data)

| week_number | avg_amount_spent |
|-------------|------------------|
| 2           | 742.50           |
| 4           | 424.00           |
| 5           | 590.00           |
| 8           | 259.00           |

---

### 🧠 Key Concepts Reinforced:
- ✅ **CTE usage** for clean filtering
- ✅ **DATEPART** for extracting week/month info
- ✅ **GROUP BY + AVG** for aggregating
- ✅ **Filtering with logic (Fridays in Q1)**

---

### 🧪 Bonus Tip: Check your SQL Server settings
If you're using SQL Server, `DATEPART(week, ...)` behavior might vary depending on settings like `SET DATEFIRST` and `SET DATEFORMAT`. To get **ISO-standard week numbers**, you could use:

```sql
DATEPART(isowk, date) AS week_number
```

---

Let me know if you want to visualize it, adapt it for another database (like PostgreSQL or MySQL), or even write a version that includes **total orders per Friday** or **user breakdowns**!