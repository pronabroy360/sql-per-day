Sure! Here's a detailed **pseudocode** and **step-by-step approach** to solving the **returning active users** problem using the CTE and `DATEDIFF()` logic.

---

## 🎯 Problem Summary

> Identify users who made a **second purchase** within **7 days** of **any** of their previous purchases.

---

## 🧩 Step-by-Step Approach

### Step 1: Understand the Data

You have a table `amazon_transactions` with:

- `id`: Transaction ID
- `user_id`: Unique ID for each user
- `item`: Purchased item
- `created_at`: Date and time of purchase
- `revenue`: Amount spent

### Step 2: Define "Returning Active User"

A user qualifies as **returning active** if:

- They made **at least two purchases**
- The **second purchase** occurred **within 7 days** of a **previous one**

---

## 🔍 Pseudocode (Conceptual Plan)

```
FOR each pair of purchases (p1, p2) for the same user:
    IF p2.date > p1.date AND days_between(p2.date, p1.date) <= 7:
        mark user_id as returning active

RETURN list of unique returning active user_ids
```

---

## 🧾 SQL-Based Pseudocode with CTE & DATEDIFF

```sql
WITH purchases AS (
    SELECT * FROM amazon_transactions
),
joined_purchases AS (
    SELECT
        p1.user_id,
        p1.created_at AS first_purchase,
        p2.created_at AS second_purchase
    FROM purchases p1
    JOIN purchases p2
        ON p1.user_id = p2.user_id
        AND p2.created_at > p1.created_at
        AND p2.created_at <= datetime(p1.created_at, '+7 days')
)
SELECT DISTINCT user_id
FROM joined_purchases;

```

---

## 🧠 Notes

- We use `DATEDIFF(p2.created_at, p1.created_at)` to compute the day gap.
- `p2.created_at > p1.created_at` ensures that the second purchase happened **after** the first.
- The result gives us the list of users who made a second qualifying purchase.
