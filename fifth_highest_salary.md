Problem:
You have been asked to find the fifth highest salary without using TOP or LIMIT. Note: Duplicate salaries should not be removed.



𝐒𝐜𝐡𝐞𝐦𝐚 𝐚𝐧𝐝 𝐃𝐚𝐭𝐚𝐬𝐞𝐭
CREATE TABLE com_worker ( worker_id BIGINT PRIMARY KEY, department VARCHAR(25), first_name VARCHAR(25), last_name VARCHAR(25), joining_date DATETIME, salary BIGINT);

INSERT INTO com_worker (worker_id, department, first_name, last_name, joining_date, salary) VALUES  (1, 'HR', 'John', 'Doe', '2020-01-15', 50000), (2, 'IT', 'Jane', 'Smith', '2019-03-10', 60000), (3, 'Finance', 'Emily', 'Jones', '2021-06-20', 75000), (4, 'Sales', 'Michael', 'Brown', '2018-09-05', 60000), (5, 'Marketing', 'Chris', 'Johnson', '2022-04-12', 70000), (6, 'IT', 'David', 'Wilson', '2020-11-01', 80000), (7, 'Finance', 'Sarah', 'Taylor', '2017-05-25', 45000), (8, 'HR', 'James', 'Anderson', '2023-01-09', 65000), (9, 'Sales', 'Anna', 'Thomas', '2020-02-18', 55000), (10, 'Marketing', 'Robert', 'Jackson', '2021-07-14', 60000);
---------

### ✅ Correct Version Using a CTE and Correlated Subquery:

If you're trying to use a CTE structure **and** want to find the 5th highest salary:

```sql
WITH salary_ranked AS (
  SELECT salary
  FROM com_worker w1
  WHERE (
    SELECT COUNT(*)
    FROM com_worker w2
    WHERE w2.salary > w1.salary
  ) = 4
)
SELECT DISTINCT salary
FROM salary_ranked;
```

If you want the full employee records with the 5th highest salary:

```sql
WITH fifth_highest_salary AS (
  SELECT salary
  FROM com_worker w1
  WHERE (
    SELECT COUNT(*)
    FROM com_worker w2
    WHERE w2.salary > w1.salary
  ) = 4
)
SELECT *
FROM com_worker
WHERE salary = (SELECT salary FROM fifth_highest_salary);
```

---

### 🔁 If You're Using a RANK-based Approach (and your SQL engine supports window functions):

```sql
WITH salary_ranks AS (
  SELECT *, DENSE_RANK() OVER (ORDER BY salary DESC) AS rnk
  FROM com_worker
)
SELECT worker_id, salary
FROM salary_ranks
WHERE rnk = 5;
```

> This uses `DENSE_RANK()` so duplicates in salary don't get skipped.

---
No problem — let's break down that query **step-by-step** so you can understand exactly how and why it works.

---

### ✅ Goal:

Find the **5th highest salary** from the `com_worker` table, **without removing duplicates**, and **without using `TOP` or `LIMIT`**.

---

### 🔍 The Query:

```sql
WITH ranked_salaries AS (
  SELECT * 
  FROM com_worker cw1
  WHERE (
    SELECT COUNT(*) 
    FROM com_worker cw2 
    WHERE cw2.salary > cw1.salary
  ) = 4
)
SELECT salary 
FROM ranked_salaries;
```

---

### 🧠 Step-by-Step Explanation:

#### 🔸 Outer Table (`cw1`):

We're looping through each row in `com_worker` and calling it `cw1`.

#### 🔸 Subquery (`cw2`):

For each `cw1.salary`, we're running this subquery:

```sql
SELECT COUNT(*) FROM com_worker cw2 WHERE cw2.salary > cw1.salary
```

This counts **how many salaries are greater** than the current salary (`cw1.salary`).

#### 🔸 WHERE condition: `= 4`

We’re selecting the row(s) where **exactly 4 other salaries are greater** than `cw1.salary`. That means this is the **5th highest salary** (think of it as 0-based index: 0 = 1st highest, 1 = 2nd highest, ..., 4 = 5th highest).

#### 🔸 Example:

Assume salaries (duplicates allowed):
`[80000, 75000, 70000, 65000, 60000, 60000, 60000, 55000, 50000, 45000]`

Now, check how many salaries are greater than each:

| Salary | Count of Greater Salaries |
| ------ | ------------------------- |
| 80000  | 0                         |
| 75000  | 1                         |
| 70000  | 2                         |
| 65000  | 3                         |
| 60000  | 4  ✅ ← Fifth highest      |
| 60000  | 4  ✅                      |
| 60000  | 4  ✅                      |
| 55000  | 7                         |
| 50000  | 8                         |
| 45000  | 9                         |

So the rows with salary = 60000 satisfy `COUNT(*) = 4`.

---

### ✅ Final Output:

`SELECT salary FROM ranked_salaries` simply gives the salary from those matching rows — in this case, **60000**.



Let me know if you'd like a visual flow of how this runs behind the scenes!

