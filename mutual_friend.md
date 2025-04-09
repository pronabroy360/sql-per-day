You are analyzing a social network dataset at Google. Your task is to find mutual friends between two users, Karl and Hans. There is only one user named Karl and one named Hans in the dataset.

The output should contain 'user_id' and 'user_name' columns.

🔗 Understanding how to join tables in SQL is essential for effective data analysis; mastering this concept allows you to combine related data seamlessly. Give it a try! 👇

𝐒𝐜𝐡𝐞𝐦𝐚 𝐚𝐧𝐝 𝐃𝐚𝐭𝐚𝐬𝐞𝐭:
CREATE TABLE users(user_id INT, user_name varchar(30));
INSERT INTO users VALUES (1, 'Karl'), (2, 'Hans'), (3, 'Emma'), (4, 'Emma'), (5, 'Mike'), (6, 'Lucas'), (7, 'Sarah'), (8, 'Lucas'), (9, 'Anna'), (10, 'John');

CREATE TABLE friends(user_id INT, friend_id INT);
INSERT INTO friends VALUES (1,3),(1,5),(2,3),(2,4),(3,1),(3,2),(3,6),(4,7),(5,8),(6,9),(7,10),(8,6),(9,10),(10,7),(10,9);
-------------

I have provided an explanation and query, but I encourage you to try solving it first. Later, you can check the query for reference.

𝐄𝐱𝐩𝐥𝐚𝐧𝐚𝐭𝐢𝐨𝐧 𝐨𝐟 𝐭𝐡𝐞 𝐐𝐮𝐞𝐫𝐲:
1. The CTEs (karl_friends and hans_friends) efficiently find all friends for Karl and Hans, respectively.

2. The main query joins these CTEs with the users table to find the users who are present in both Karl's and Hans's friend lists (mutual friends).


**Solution:**
No worries — let me walk you through it clearly and simply, step by step, and then show you the full SQL again in a cleaner way.

---

### 🎯 Goal:
We want to find mutual friends of **Karl** and **Hans**. That means we need:

- People who are friends with **Karl**
- People who are friends with **Hans**
- The intersection (i.e. common users in both friend lists)
- And we want the output as:
  - `user_id`
  - `user_name`

---

### 🧱 Tables Summary:

**users**
```
user_id | user_name
--------|-----------
1       | Karl
2       | Hans
3       | Emma
...
```

**friends**
```
user_id | friend_id
--------|-----------
1       | 3         -- Karl is friends with Emma (id 3)
1       | 5         -- Karl is friends with Mike (id 5)
2       | 3         -- Hans is friends with Emma (id 3)
2       | 4         -- Hans is friends with another Emma (id 4)
...
```

---

### 🔎 Plan:
1. Get `user_id` of Karl and Hans from `users`.
2. Find friends of Karl using `friends` where `user_id = Karl's id`.
3. Find friends of Hans the same way.
4. Find the **mutual** ones (i.e., friend_id appears in both lists).
5. Join back to `users` table to get their `user_name`.

---

### ✅ Simple Version of the Final SQL Query:

```sql
WITH
karl_friends AS (
  SELECT friend_id
  FROM friends
  WHERE user_id = (SELECT user_id FROM users WHERE user_name = 'Karl')
),
hans_friends AS (
  SELECT friend_id
  FROM friends
  WHERE user_id = (SELECT user_id FROM users WHERE user_name = 'Hans')
),
mutual_friends AS (
  SELECT k.friend_id AS user_id
  FROM karl_friends k
  INNER JOIN hans_friends h ON k.friend_id = h.friend_id
)
SELECT u.user_id, u.user_name
FROM mutual_friends mf
JOIN users u ON mf.user_id = u.user_id;
```

---

### 🧾 Output:
This will return:

```
user_id | user_name
--------|-----------
3       | Emma
```

So Karl and Hans both share Emma (user_id 3) as a mutual friend.

---

Let me know if you'd like a breakdown of what `WITH` does or want to try a version yourself!