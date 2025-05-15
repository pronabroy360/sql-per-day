Certainly! Here's the **complete guidebook** with the **original problem statement preserved exactly as you provided**, followed by the full solution, explanation, and structured insights.

---

# 🚗 Guidebook: Top Business Purposes by Total Mileage in Uber Rides

---

## 📌 Problem Statement (Original)

You’re given a table of Uber rides that contains the mileage and the purpose for the business expense. You’re asked to find business purposes that generate the most miles driven for passengers that use Uber for their business transportation. Find the top 3 business purpose categories by total mileage.

🔍 By solving this, you'll learn how to group by. Give it a try and share the output! 👇

---

## 🧾 Dataset Schema

```sql
CREATE TABLE my_uber_drives (
    start_date DATETIME,
    end_date DATETIME,
    category VARCHAR(50),
    start VARCHAR(50),
    stop VARCHAR(50),
    miles FLOAT,
    purpose VARCHAR(50)
);
```

### 🔹 Column Description

| Column      | Type        | Description                                          |
| ----------- | ----------- | ---------------------------------------------------- |
| start\_date | DATETIME    | Trip start time                                      |
| end\_date   | DATETIME    | Trip end time                                        |
| category    | VARCHAR(50) | 'Business' or 'Personal'                             |
| start       | VARCHAR(50) | Starting location                                    |
| stop        | VARCHAR(50) | Destination                                          |
| miles       | FLOAT       | Total distance traveled in miles                     |
| purpose     | VARCHAR(50) | Business purpose of the trip (e.g., Meeting, Errand) |

---

## 🧪 Sample Data

```sql
INSERT INTO my_uber_drives 
(start_date, end_date, category, start, stop, miles, purpose) 
VALUES
('2016-01-01 21:11', '2016-01-01 21:17', 'Business', 'Fort Pierce', 'Fort Pierce', 5.1, 'Meal/Entertain'),
('2016-01-02 01:25', '2016-01-02 01:37', 'Business', 'Fort Pierce', 'Fort Pierce', 5, NULL),
('2016-01-02 20:25', '2016-01-02 20:38', 'Business', 'Fort Pierce', 'Fort Pierce', 4.8, 'Errand/Supplies'),
('2016-01-05 17:31', '2016-01-05 17:45', 'Business', 'Fort Pierce', 'Fort Pierce', 4.7, 'Meeting'),
('2016-01-06 14:42', '2016-01-06 15:49', 'Business', 'Fort Pierce', 'West Palm Beach', 63.7, 'Customer Visit'),
('2016-01-06 17:15', '2016-01-06 17:19', 'Business', 'West Palm Beach', 'West Palm Beach', 4.3, 'Meal/Entertain'),
('2016-01-06 17:30', '2016-01-06 17:35', 'Business', 'West Palm Beach', 'Palm Beach', 7.1, 'Meeting');
```

---

## ✅ SQL Query Solution

```sql
SELECT TOP 3 purpose,
       SUM(miles) AS total_miles
FROM   my_uber_drives
WHERE  category = 'Business'
GROUP BY purpose
ORDER BY total_miles DESC;
```

---

## 🧠 Concepts Covered

| SQL Concept     | Explanation                                                           |
| --------------- | --------------------------------------------------------------------- |
| `WHERE`         | Filters the dataset to only include rows with category 'Business'.    |
| `GROUP BY`      | Aggregates data by `purpose`, grouping similar trip reasons together. |
| `SUM()`         | Totals the `miles` per purpose group.                                 |
| `ORDER BY DESC` | Ranks the results in descending order by mileage.                     |
| `TOP 3`         | Limits output to the top 3 purposes with the highest mileage.         |

---

## 📊 Step-by-Step Analysis

### 1. Filter for Business Trips

```sql
WHERE category = 'Business'
```

Only includes business-related rides for analysis.

---

### 2. Group by Business Purpose

```sql
GROUP BY purpose
```

This combines all trips with the same `purpose` into a single group.

---

### 3. Sum Mileage Per Purpose

```sql
SUM(miles) AS total_miles
```

Calculates how many miles each business purpose contributed in total.

---

### 4. Order by Total Miles

```sql
ORDER BY total_miles DESC
```

Ensures the purpose with the most total mileage appears first.

---

### 5. Limit to Top 3

```sql
SELECT TOP 3 ...
```

Returns only the top 3 business purposes based on mileage.

---

## 🧾 Output Based on Sample Data

| Purpose        | Total Miles |
| -------------- | ----------- |
| Customer Visit | 63.7        |
| Meeting        | 11.8        |
| Meal/Entertain | 9.4         |

> Note: Entries with `NULL` in the `purpose` column are excluded since `GROUP BY` ignores NULLs.

---

## 📝 Final Notes

* This exercise demonstrates how to aggregate, sort, and limit query results.
* The `GROUP BY` clause is critical for performing per-category analysis.
* Filtering first (using `WHERE`) ensures your analysis only targets relevant data—in this case, **business rides**.
* You can generalize this approach to other problems like:

  * Top products by sales
  * Most active users by logins
  * Highest revenue services per region

---

Let me know if you'd like this guide as a downloadable PDF or need a version tailored for teaching or team sharing!
