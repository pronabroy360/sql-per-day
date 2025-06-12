To calculate the **Active User Penetration Rate** for each country based on the given criteria and dataset, follow these steps:

---

### ✅ **Active User Criteria**

A user is *active* if:

* `last_active_date >= '2024-01-01'`
* `sessions >= 5`
* `listening_hours >= 10`

---

### 💡 **SQL Query**

```sql
SELECT 
  country,
  ROUND(COUNT(CASE 
               WHEN last_active_date >= '2024-01-01' 
                    AND sessions >= 5 
                    AND listening_hours >= 10 
               THEN user_id 
             END) * 1.0 / COUNT(user_id), 2) AS active_user_penetration_rate
FROM penetration_analysis
GROUP BY country;
```

---

### 📊 **Output**

| country | active\_user\_penetration\_rate |
| ------- | ------------------------------- |
| USA     | 0.67                            |
| India   | 0.67                            |
| UK      | 0.67                            |
| Canada  | 0.67                            |
| Germany | 0.67                            |

---

### 🧠 Explanation

* All countries have **3 users** each.
* **2 of 3** users in each country meet the active criteria.
* So: `2 / 3 = 0.666...`, rounded to **0.67**.

Let me know if you’d like the same calculation in **Pandas**, **Python**, or any visualization.
